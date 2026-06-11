function Invoke-WPFTab {
    param (
        [Parameter(Mandatory,position=0)]
        [string]$ClickedTab
    )

    $tabNav = Get-WinUtilVariables | Where-Object {$psitem -like "WPFTabNav"}
    $tabNumber = [int]($ClickedTab -replace "WPFTab","" -replace "BT","") - 1

    $filter = Get-WinUtilVariables -Type ToggleButton | Where-Object {$psitem -like "WPFTab?BT"}
    ($sync.GetEnumerator()).where{$psitem.Key -in $filter} | ForEach-Object {
        if ($ClickedTab -ne $PSItem.name) {
            $sync[$PSItem.Name].IsChecked = $false
        } else {
            $sync["$ClickedTab"].IsChecked = $true
            $tabNumber = [int]($ClickedTab-replace "WPFTab","" -replace "BT","") - 1
            $sync.$tabNav.Items[$tabNumber].IsSelected = $true
        }
    }
    $sync.currentTab = $sync.$tabNav.Items[$tabNumber].Header

    # Always reset the filter for the current tab
    if ($sync.currentTab -eq "Install") {
        Find-AppsByNameOrDescription -SearchString ""
    } elseif ($sync.currentTab -eq "Tweaks") {
        Find-TweaksByNameOrDescription -SearchString ""
    }

    # Show search bar + package manager in Install and Tweaks tabs
    if ($tabNumber -eq 0 -or $tabNumber -eq 1) {
        $sync.SearchBar.Visibility = "Visible"
        $searchBarArea = $sync["Form"].FindName("WPFSearchBarArea")
        if ($searchBarArea) { $searchBarArea.Visibility = "Visible" }
    } else {
        $sync.SearchBar.Visibility = "Collapsed"
        $searchBarArea = $sync["Form"].FindName("WPFSearchBarArea")
        if ($searchBarArea) { $searchBarArea.Visibility = "Collapsed" }
        $sync.SearchBarClearButton.Visibility = "Collapsed"
    }

    # Show package manager toolbar only on Install tab
    $installOptionsBar = $sync["Form"].FindName("WPFInstallOptionsBar")
    if ($installOptionsBar) {
        $installOptionsBar.Visibility = if ($tabNumber -eq 0) { "Visible" } else { "Collapsed" }
    }
}
