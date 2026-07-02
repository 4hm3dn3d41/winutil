---
name: fluent2-design
description: Microsoft Fluent 2 design system — design tokens, Figma UI kits, color, typography, spacing, corner radius, stroke width, and styling guidelines
license: MIT
compatibility: opencode
metadata:
  audience: designers, developers
  source: https://fluent2.microsoft.design
---

# Fluent 2 Design System

## Overview

Fluent 2 is Microsoft's design system for creating cohesive, accessible, and beautiful experiences across web, iOS, Android, and Windows. It provides a shared design language, component libraries, and design tokens that ensure consistency across Microsoft products.

## Design Tokens

### Color

Fluent 2 uses a two-tier token system:

- **Global tokens** — Raw color values (e.g., `red-100`, `blue-500`, `grey-10`)
- **Alias tokens** — Semantic mappings that reference global tokens (e.g., `colorBrandBackground`, `colorNeutralForeground1`, `colorStatusSuccessBackground3`)

Alias tokens support light/dark mode switching automatically through Figma variables.

**Key color token categories:**
- **Neutral** — Foreground, background, stroke for non-brand elements
- **Brand** — Primary brand colors for interactive elements
- **Status** — Success, warning, danger, info
- **Presence** — Available, away, busy, do-not-disturb, offline

### Typography

Fluent 2 uses a defined type ramp with specific font families:

- **Font families:** Segoe UI (Windows), San Francisco (iOS/macOS), Roboto (Android)
- **Type ramp:** Caption, body, bodyLarge, subtitle, subtitleLarge, title, titleLarge, title2, title3, display, mega
- **Weights:** Regular (400), Medium (500), Semibold (600), Bold (700)

### Spacing

Fluent 2 uses a 4px base unit spacing scale:

`0`, `2xs` (2px), `xs` (4px), `s` (8px), `m` (12px), `l` (16px), `xl` (20px), `2xl` (24px), `3xl` (28px), `4xl` (32px), `5xl` (40px), `6xl` (48px), `7xl` (56px), `8xl` (64px), `9xl` (72px), `10xl` (80px)

### Corner Radius

| Token | Value |
|-------|-------|
| `borderRadiusNone` | 0 |
| `borderRadiusSmall` | 2px |
| `borderRadiusMedium` | 4px |
| `borderRadiusLarge` | 6px |
| `borderRadiusXLarge` | 8px |
| `borderRadiusCircular` | 10000px |

### Stroke Width

| Token | Value |
|-------|-------|
| `strokeWidthThin` | 1px |
| `strokeWidthThick` | 2px |
| `strokeWidthThicker` | 3px |
| `strokeWidthThickest` | 4px |

### Size Tokens

A set of step-based sizing tokens for icons, avatars, and other fixed-size elements:

`2xs` (12px), `xs` (16px), `s` (20px), `m` (24px), `l` (28px), `xl` (32px), `2xl` (40px), `3xl` (48px), `4xl` (64px), `5xl` (96px), `6xl` (128px)

## Figma UI Kits

### Access

The Fluent 2 UI kits are available in Figma. Enable them from the **Libraries** dialog in the **Assets** panel. Auto-enable in **Account settings** for persistent access.

### Kit Organization (4 tiers)

| Tier | Description |
|------|-------------|
| **Fluent 2 Design Language** | Source of truth for all styling decisions — color, stroke width, corner radius, spacing, and size tokens |
| **Fluent 2 Core UI Kits** | Code-aligned building blocks for Web, iOS, and Android with structured, high-quality components |
| **Copilot UI Kits** | AI-focused components and patterns across Web, iOS, and Android aligning with Fluent AI |
| **Labs UI Kits** | Partner-led kits for experimentation and innovation |

### Figma Variables

The Fluent 2 design language file uses Figma variables for:
- **Global tokens** — Raw values for all design primitives
- **Alias tokens** — Semantic mappings with mode support
- **Mode switching** — Easy light/dark mode toggling
- **Theme and brand support** — Multi-theme and multi-brand configuration

## Design Principles

- **Accessible** — Meet WCAG standards; use sufficient color contrast, proper focus indicators, and semantic structure
- **Inclusive** — Design for all abilities, cultures, and contexts
- **Consistent** — Use the shared language of tokens and components
- **Expressive** — Allow for brand and product personality within the system

## Resources

- **Fluent 2 website:** https://fluent2.microsoft.design
- **Fluent 2 Web UI Kit (Figma):** https://aka.ms/Fluent2Toolkits/Web/Figma
- **Fluent 2 iOS UI Kit (Figma):** https://aka.ms/Fluent2Toolkits/iOS/Figma
- **Fluent 2 Android UI Kit (Figma):** https://aka.ms/Fluent2Toolkits/Android/Figma
- **Microsoft Figma Community:** https://www.figma.com/@microsoft
- **Microsoft Design:** https://www.microsoft.com/design
- **Inclusive Design:** https://inclusive.microsoft.design
