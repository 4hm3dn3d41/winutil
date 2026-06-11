function Invoke-WinutilThemeChange {
    param (
        [string]$theme = "Auto"
    )

    function Set-WinutilTheme {
        param (
            [string]$currentTheme
        )

        function Set-ThemeResourceProperty {
            param($Name, $Value, $Type)

            if (-not $Type) {
                if ($Value -match '^#[0-9A-Fa-f]{6,8}$') {
                    $Type = "ColorBrush"
                } elseif ($Name -match 'Radius') {
                    $Type = "CornerRadius"
                } elseif ($Name -match 'Thickness|Margin$|Padding$') {
                    $Type = "Thickness"
                } elseif ($Name -match 'FontFamily') {
                    $Type = "FontFamily"
                } elseif ($Name -match 'RowHeight|NavRailWidth|TitleBarHeight') {
                    $Type = "GridLength"
                } elseif ($Value -match '^-?[\d.]+$') {
                    $Type = "Double"
                } else {
                    $Type = "Double"
                }
            }

            try {
                $sync.Form.Resources[$Name] = switch ($Type) {
                    "ColorBrush" {
                        if ($Value.Length -eq 9) {
                            $hex = $Value.TrimStart("#")
                            $a = [Convert]::ToInt32($hex.Substring(0,2), 16)
                            $r = [Convert]::ToInt32($hex.Substring(2,2), 16)
                            $g = [Convert]::ToInt32($hex.Substring(4,2), 16)
                            $b = [Convert]::ToInt32($hex.Substring(6,2), 16)
                            [Windows.Media.SolidColorBrush]::new([Windows.Media.Color]::FromArgb($a, $r, $g, $b))
                        } else {
                            [Windows.Media.SolidColorBrush]::new($Value)
                        }
                    }
                    "Color" {
                        $hexColor = $Value.TrimStart("#")
                        $r = [Convert]::ToInt32($hexColor.Substring(0,2), 16)
                        $g = [Convert]::ToInt32($hexColor.Substring(2,2), 16)
                        $b = [Convert]::ToInt32($hexColor.Substring(4,2), 16)
                        [Windows.Media.Color]::FromRgb($r, $g, $b)
                    }
                    "CornerRadius" { [System.Windows.CornerRadius]::new([double]$Value) }
                    "GridLength" { [System.Windows.GridLength]::new([double]$Value) }
                    "Thickness" {
                        $values = ($Value -replace '\s', '') -split ","
                        switch ($values.Count) {
                            1 { [System.Windows.Thickness]::new([double]$values[0]) }
                            2 { [System.Windows.Thickness]::new([double]$values[0], [double]$values[1]) }
                            4 { [System.Windows.Thickness]::new([double]$values[0], [double]$values[1], [double]$values[2], [double]$values[3]) }
                        }
                    }
                    "FontFamily" { [Windows.Media.FontFamily]::new($Value) }
                    "Double" { [double]$Value }
                    default { $Value }
                }
            }
            catch {
                Write-Warning "Failed to set property $($Name): $_"
            }
        }

        $themeProperties = $sync.configs.themes.$currentTheme.PSObject.Properties
        foreach ($_ in $themeProperties) {
            Set-ThemeResourceProperty -Name $_.Name -Value $_.Value

            # Also set C-prefixed Color for DropShadowEffect compatibility
            if ($_.Name -in @("BorderColor", "ButtonBackgroundHoverColor", "ShadowColor", "AccentColor")) {
                Set-ThemeResourceProperty -Name "C$($_.Name)" -Value $_.Value -Type "Color"
            }
        }
    }

    $sync.preferences.theme = $theme
    Set-Preferences -save
    Set-WinutilTheme -currentTheme "shared"

    switch ($sync.preferences.theme) {
        "Auto" {
            $systemUsesDarkMode = Get-WinUtilToggleStatus WPFToggleDarkMode
            if ($systemUsesDarkMode) {
                $theme = "Dark"
            } else {
                $theme = "Light"
            }
            Set-WinutilTheme -currentTheme $theme
            $themeButtonIcon = [char]0xF08C
        }
        "Dark" {
            Set-WinutilTheme -currentTheme $sync.preferences.theme
            $themeButtonIcon = [char]0xE708
        }
        "Light" {
            Set-WinutilTheme -currentTheme $sync.preferences.theme
            $themeButtonIcon = [char]0xE706
        }
    }

    # Set FOSS Highlight Color
    $fossEnabled = $true
    if ($sync.WPFToggleFOSSHighlight) {
        $fossEnabled = $sync.WPFToggleFOSSHighlight.IsChecked
    }

    if ($fossEnabled) {
         $sync.Form.Resources["FOSSColor"] = [Windows.Media.SolidColorBrush]::new([Windows.Media.Color]::FromRgb(76, 175, 80))
    } else {
         $sync.Form.Resources["FOSSColor"] = $sync.Form.Resources["MainForegroundColor"]
    }

    $ThemeButton = $sync.Form.FindName("ThemeButton")
    $ThemeButton.Content = [string]$themeButtonIcon
}
