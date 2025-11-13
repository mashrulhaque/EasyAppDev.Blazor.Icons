# EasyAppDev.Blazor.Icons - Base Package

## Purpose

This is the **base meta-package** for EasyAppDev.Blazor.Icons. It serves as a reference package but does NOT contain any icon components.

## What This Package Contains

- Package metadata and documentation
- Common types and interfaces (if any)
- Links to actual icon library packages

## Actual Icon Libraries

To use icons in your Blazor application, install one or more of the specific icon library packages:

### Available Icon Libraries:

1. **EasyAppDev.Blazor.Icons.Lucide** - ~1,500 outline-style icons
   ```bash
   dotnet add package EasyAppDev.Blazor.Icons.Lucide
   ```

2. **EasyAppDev.Blazor.Icons.Bootstrap** - ~2,000 filled-style icons
   ```bash
   dotnet add package EasyAppDev.Blazor.Icons.Bootstrap
   ```

3. **EasyAppDev.Blazor.Icons.MaterialDesign** - ~7,400 filled-style icons
   ```bash
   dotnet add package EasyAppDev.Blazor.Icons.MaterialDesign
   ```

## Usage

After installing a specific icon library package:

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<LucideHome />
<LucideActivity style="color: blue; width: 32px;" />
<LucideUser AriaLabel="User profile" />
```

## Why a Separate Base Package?

The base package allows:
- Common documentation and metadata
- Future shared utilities or interfaces
- Users to reference a common package ID if needed
- Flexibility to add common functionality without affecting individual icon libraries

## Package Structure

```
EasyAppDev.Blazor.Icons (this package)
├── EasyAppDev.Blazor.Icons.Lucide
├── EasyAppDev.Blazor.Icons.Bootstrap
└── EasyAppDev.Blazor.Icons.MaterialDesign
```

Each icon library is independent and fully trimmable. Install only what you need!

## Documentation

For full documentation, visit: https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons
