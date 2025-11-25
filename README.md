# EasyAppDev.Blazor.Icons

[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.Lucide.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.Lucide/)
[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.Bootstrap.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.Bootstrap/)
[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.MaterialDesign.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.MaterialDesign/)
[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.FontAwesome5.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.FontAwesome5/)
[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.FontAwesome6.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.FontAwesome6/)
[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.FluentUI.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.FluentUI/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A fully trimmable Blazor icon library with 18,000+ icons from Lucide, Bootstrap, Material Design, FontAwesome 5, FontAwesome 6, and FluentUI. Physical component files enable true trimming - only icons you reference are included in your published output.

## Quick Start

```bash
# 1. Install the icon library you want
dotnet add package EasyAppDev.Blazor.Icons.Lucide

# 2. Add using statement to your Razor component or _Imports.razor
@using EasyAppDev.Blazor.Icons.Lucide

# 3. Use icons directly in your markup
<LuHome />
<LuActivity />
<LuSettings />
```

That's it! No configuration, no services, no setup. Just install and use.

## Icon Library Samples

Here are examples from each icon library to help you get started:

```razor
@using EasyAppDev.Blazor.Icons.Lucide
@using EasyAppDev.Blazor.Icons.Bootstrap
@using EasyAppDev.Blazor.Icons.MaterialDesign
@using EasyAppDev.Blazor.Icons.FontAwesome5
@using EasyAppDev.Blazor.Icons.FontAwesome6
@using EasyAppDev.Blazor.Icons.FluentUI

<!-- Lucide - Modern outline icons -->
<LuHome />
<LuActivity />
<LuSettings />
<LuUser />

<!-- Bootstrap - Clean filled icons -->
<BiHouse />
<BiPerson />
<BiGear />
<BiHeart />

<!-- Material Design - Google's Material icons -->
<MdHome />
<MdPerson />
<MdSettings />
<MdFavorite />

<!-- FontAwesome 5 - Multiple variants -->
<Fa5SolidHome />
<Fa5RegularHeart />
<Fa5BrandsTwitter />
<Fa5BrandsGithub />

<!-- FontAwesome 6 - Latest FontAwesome -->
<Fa6SolidHome />
<Fa6RegularStar />
<Fa6BrandsDiscord />
<Fa6BrandsTwitter />

<!-- FluentUI - Microsoft's Fluent Design -->
<FiHome24Regular />
<FiPerson24Filled />
<FiSettings24Regular />
<FiApps24Regular />
```

**Pro tip**: All icons support standard CSS styling:
```razor
<LuHome style="color: blue; width: 32px; height: 32px;" />
<BiHeart class="text-danger icon-lg" />
```

## Features

- **Multi-Target Support**: Compatible with both .NET 8.0 and .NET 9.0
- **True Trimming**: Only icons you directly reference are included in published output (~6KB uncompressed, ~2.3KB Brotli, **99.96% reduction** from full library)
- **Prefix-Based Naming**: All icons use library prefixes (Lu/Bi/Md/Fa5/Fa6/Fi) - no naming conflicts with your components
- **Physical Components**: Individual sealed ComponentBase classes (18,000+ total)
- **Zero Runtime Overhead**: No reflection, no HTTP calls, no dictionaries - just compiled code
- **Fully Embedded**: SVG content embedded directly in component code
- **Type-Safe**: Full compile-time checking with direct component references
- **Full IntelliSense**: Complete autocomplete and intellisense for all 18,000+ icons in your IDE
- **CSS Controllable**: Style icons with standard CSS properties (color, width, height, etc.)
- **Separate Packages**: Choose only the icon libraries you need:
  - `EasyAppDev.Blazor.Icons.Lucide` (~1,500 icons, 1.6MB)
  - `EasyAppDev.Blazor.Icons.Bootstrap` (~2,000 icons, 3.2MB)
  - `EasyAppDev.Blazor.Icons.MaterialDesign` (~7,400 icons, 10MB)
  - `EasyAppDev.Blazor.Icons.FontAwesome5` (~1,600 icons, 2.5MB)
  - `EasyAppDev.Blazor.Icons.FontAwesome6` (~2,000 icons, 3.2MB)
  - `EasyAppDev.Blazor.Icons.FluentUI` (~3,000 icons, 4MB)
- **Fast Builds**: Incremental builds leverage existing compiled components

## Usage

### Installation

Install only the icon libraries you need:

```bash
# Lucide icons (~1,500 icons - modern, consistent outline icons)
dotnet add package EasyAppDev.Blazor.Icons.Lucide

# Bootstrap icons (~2,000 icons - clean, simple filled icons)
dotnet add package EasyAppDev.Blazor.Icons.Bootstrap

# Material Design icons (~7,400 icons - Google's Material Design)
dotnet add package EasyAppDev.Blazor.Icons.MaterialDesign

# FontAwesome 5 icons (~1,600 icons - solid, regular, brands)
dotnet add package EasyAppDev.Blazor.Icons.FontAwesome5

# FontAwesome 6 icons (~2,000 icons - solid, regular, brands)
dotnet add package EasyAppDev.Blazor.Icons.FontAwesome6

# FluentUI icons (~3,000 icons - Microsoft's Fluent Design System)
dotnet add package EasyAppDev.Blazor.Icons.FluentUI

# Or install multiple packages together
dotnet add package EasyAppDev.Blazor.Icons.Lucide
dotnet add package EasyAppDev.Blazor.Icons.FluentUI
```

### Package Versions

| Package | Version | Icons | Development Size | Published Size (Trimmed) |
|---------|---------|-------|-----------------|-------------------------|
| `EasyAppDev.Blazor.Icons.Lucide` | 2.0.1 | ~1,500 | ~1.6MB | **~2-4KB** ✨ |
| `EasyAppDev.Blazor.Icons.Bootstrap` | 2.0.1 | ~2,000 | ~3.2MB | **~2-4KB** ✨ |
| `EasyAppDev.Blazor.Icons.MaterialDesign` | 2.0.1 | ~7,400 | ~10MB | **~2-5KB** ✨ |
| `EasyAppDev.Blazor.Icons.FontAwesome5` | 2.0.1 | ~1,600 | ~2.5MB | **~2-4KB** ✨ |
| `EasyAppDev.Blazor.Icons.FontAwesome6` | 2.0.1 | ~2,000 | ~3.2MB | **~2-4KB** ✨ |
| `EasyAppDev.Blazor.Icons.FluentUI` | 2.0.1 | ~3,000 | ~4MB | **~2-4KB** ✨ |

**Trimming is extremely effective!** With proper syntax (see warning below), published apps include only referenced icons. Typical apps using 50-100 icons from all libraries result in only **~6KB total overhead** (99.96% reduction).

### Basic Usage

No configuration needed! Just add using statements and reference icons directly.

**Single icon library**:
```razor
@page "/"
@using EasyAppDev.Blazor.Icons.Lucide

<h1>My Page</h1>

<LuActivity />
<LuAirplay />
<LuHome />
```

**Multiple icon libraries** (prefixes prevent naming conflicts):
```razor
@page "/"
@using EasyAppDev.Blazor.Icons.Lucide
@using EasyAppDev.Blazor.Icons.Bootstrap
@using EasyAppDev.Blazor.Icons.MaterialDesign
@using EasyAppDev.Blazor.Icons.FontAwesome5
@using EasyAppDev.Blazor.Icons.FontAwesome6
@using EasyAppDev.Blazor.Icons.FluentUI

<h1>My Page</h1>

<!-- All libraries work together - prefixes prevent conflicts -->
<LuHome />           <!-- Lucide home icon -->
<BiHouse />          <!-- Bootstrap house icon -->
<MdHome />           <!-- Material Design home icon -->
<Fa5SolidHome />     <!-- FontAwesome 5 solid home icon -->
<Fa6SolidHome />     <!-- FontAwesome 6 solid home icon -->
<FiHome24Regular />  <!-- FluentUI home icon (24px, regular weight) -->

<LuActivity />       <!-- Lucide -->
<BiPerson />         <!-- Bootstrap -->
<MdSettings />       <!-- Material Design -->
<Fa5BrandsTwitter /> <!-- FontAwesome 5 brands -->
<Fa6RegularHeart />  <!-- FontAwesome 6 regular -->
<FiPerson24Filled /> <!-- FluentUI person icon (24px, filled) -->
```

**Alternative: Use fully qualified names** (if you prefer):
```razor
@page "/"

<h1>My Page</h1>

<!-- No using statements needed -->
<EasyAppDev.Blazor.Icons.Lucide.LuActivity />
<EasyAppDev.Blazor.Icons.Bootstrap.BiHouse />
<EasyAppDev.Blazor.Icons.MaterialDesign.MdHome />
<EasyAppDev.Blazor.Icons.FluentUI.FiHome24Regular />
```

**⚠️ IMPORTANT: Do NOT use namespace aliases** - this breaks trimming:
```razor
<!-- ❌ WRONG - breaks trimming -->
@using Lucide = EasyAppDev.Blazor.Icons.Lucide
<Lucide.LuActivity />

<!-- ✅ CORRECT - trimming works -->
@using EasyAppDev.Blazor.Icons.Lucide
<LuActivity />
```

### Styling Icons

Icons support all standard CSS styling. Icons inherit size and color from their parent element by default.

#### Size Control

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Using width and height -->
<LuActivity style="width: 24px; height: 24px;" />
<LuActivity style="width: 32px; height: 32px;" />
<LuActivity style="width: 48px; height: 48px;" />

<!-- Using font-size (if icon container doesn't specify width/height) -->
<div style="font-size: 24px;">
    <LuActivity />
</div>

<!-- Using CSS classes -->
<LuHome class="icon-sm" />      <!-- small -->
<LuHome class="icon-md" />      <!-- medium -->
<LuHome class="icon-lg" />      <!-- large -->
```

#### Color Control

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Inline color -->
<LuActivity style="color: red;" />
<LuActivity style="color: #00ff00;" />

<!-- Using CSS classes -->
<LuActivity class="text-primary" />
<LuActivity class="text-danger" />

<!-- From parent element -->
<div style="color: blue;">
    <LuActivity />
</div>
```

#### Icon Set Specific Styling

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Lucide (outline icons) - control stroke width -->
<LuActivity style="color: currentColor; stroke-width: 2;" />
<LuActivity style="color: currentColor; stroke-width: 1.5;" />

<!-- Bootstrap & Material Design (filled icons) - use fully qualified names -->
<EasyAppDev.Blazor.Icons.Bootstrap.BiHouse style="color: currentColor;" />
<EasyAppDev.Blazor.Icons.MaterialDesign.MdHome style="color: currentColor;" />
```

#### Animations & Effects

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Spinning animation -->
<div style="animation: spin 1s linear infinite;">
    <LuLoader />
</div>

<!-- Hover effects -->
<LuActivity class="icon-hover" />

<!-- Fade in/out -->
<LuActivity style="opacity: 0.7; transition: opacity 0.3s;" />
```

CSS for animations:

```css
@keyframes spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.icon-hover {
    transition: color 0.2s, transform 0.2s;
}

.icon-hover:hover {
    color: #0066ff;
    transform: scale(1.2);
}

.icon-sm { width: 16px; height: 16px; }
.icon-md { width: 24px; height: 24px; }
.icon-lg { width: 32px; height: 32px; }
.icon-xl { width: 48px; height: 48px; }
```

#### Responsive Styling

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Mobile and desktop sizes -->
<LuActivity class="icon-responsive" />
```

```css
@media (max-width: 768px) {
    .icon-responsive {
        width: 20px;
        height: 20px;
    }
}

@media (min-width: 769px) {
    .icon-responsive {
        width: 32px;
        height: 32px;
    }
}
```

#### Using CSS Variables

```css
:root {
    --icon-color: #333;
    --icon-size: 24px;
}

.icon-styled {
    color: var(--icon-color);
    width: var(--icon-size);
    height: var(--icon-size);
}
```

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<LuActivity class="icon-styled" />
```

### Accessibility

```razor
<!-- Decorative icon (default) -->
<LuActivity />

<!-- Icon with semantic meaning -->
<LuActivity AriaLabel="Loading activity" />
```

### Available Icon Sets

- **Lucide** (~1,500 icons): Modern, consistent outline icons
  - Namespace: `EasyAppDev.Blazor.Icons.Lucide`
  - Prefix: `Lu` (e.g., `LuHome`, `LuActivity`)
  - Style: Outline with `currentColor` stroke

- **Bootstrap** (~2,000 icons): Clean, simple filled icons
  - Namespace: `EasyAppDev.Blazor.Icons.Bootstrap`
  - Prefix: `Bi` (e.g., `BiHome`, `BiHouse`)
  - Style: Filled with `currentColor`

- **Material Design** (~7,400 icons): Google's Material Design icons
  - Namespace: `EasyAppDev.Blazor.Icons.MaterialDesign`
  - Prefix: `Md` (e.g., `MdHome`, `MdMenu`)
  - Style: Filled with `currentColor`

- **FontAwesome 5** (~1,600 icons): Solid, regular, and brands
  - Namespace: `EasyAppDev.Blazor.Icons.FontAwesome5`
  - Prefix: `Fa5Solid`, `Fa5Regular`, `Fa5Brands` (e.g., `Fa5SolidHome`, `Fa5BrandsTwitter`)
  - Style: Varies by variant (solid, regular, brands)

- **FontAwesome 6** (~2,000 icons): Solid, regular, and brands
  - Namespace: `EasyAppDev.Blazor.Icons.FontAwesome6`
  - Prefix: `Fa6Solid`, `Fa6Regular`, `Fa6Brands` (e.g., `Fa6SolidHome`, `Fa6RegularHeart`)
  - Style: Varies by variant (solid, regular, brands)

- **FluentUI** (~3,000 icons): Microsoft's Fluent Design System
  - Namespace: `EasyAppDev.Blazor.Icons.FluentUI`
  - Prefix: `Fi` (e.g., `FiHome24Regular`, `FiPerson24Filled`)
  - Style: Multiple sizes (16/20/24/28/32/48px) and weights (regular, filled)
  - Naming pattern: `Fi{IconName}{Size}{Weight}` (e.g., `FiHome24Regular`, `FiSettings32Filled`)

### ⚠️ CRITICAL: Namespace Aliases Break Trimming

**DO NOT use namespace aliases** - this prevents trimming:

```razor
<!-- ❌ WRONG - Breaks trimming! -->
@using Lucide = EasyAppDev.Blazor.Icons.Lucide
<Lucide.LuActivity />
```

This syntax causes the Razor compiler to treat icons as HTML elements instead of components:
- Generates RZ10012 warnings during build
- **Prevents trimming from working** (all 11,000+ icons will be included)
- Results in 14.8MB overhead instead of ~6KB

**✅ CORRECT - Trimming works:**

```razor
<!-- Option 1: Direct namespace import (recommended) -->
@using EasyAppDev.Blazor.Icons.Lucide
<LuActivity />

<!-- Option 2: Fully qualified names -->
<EasyAppDev.Blazor.Icons.Lucide.LuActivity />
```

**Verify trimming will work:**
- Build your project and check for RZ10012 warnings
- If you see "Found markup element with unexpected name", trimming will NOT work
- Fix by using correct syntax above

### Best Practices

**Recommended approach** - Use `@using` statements for clean code:
```razor
@using EasyAppDev.Blazor.Icons.Lucide
<LuHome />
```

**Alternative** - Use fully qualified names for extra clarity:
```razor
<EasyAppDev.Blazor.Icons.Lucide.LuHome />
```

**Global imports** - Add to `_Imports.razor` for use across all pages:
```razor
@* _Imports.razor *@
@using EasyAppDev.Blazor.Icons.Lucide
@using EasyAppDev.Blazor.Icons.Bootstrap
@using EasyAppDev.Blazor.Icons.MaterialDesign
@using EasyAppDev.Blazor.Icons.FontAwesome6
@using EasyAppDev.Blazor.Icons.FluentUI
```

## How It Works

### Physical Component Files

1. **SVG Sources**: Original SVG files stored in `src/BlazorIcons.Generator/icon-sources/`
2. **Python Generation**: `generate-components.py` script reads SVGs and generates individual physical .cs files
3. **Physical Components**: Each icon becomes a sealed `ComponentBase` class in its package's `Components/` directory
4. **Compilation**: Each package compiles its ~1,000-7,000 component files into separate assemblies
5. **Trimming**: .NET's IL Linker removes unreferenced icon classes during `dotnet publish`

```
SVG Files → Python Script → Physical .cs Component Files → .NET Compiler → Separate Package DLLs
                                                                                      ↓
                                                                            Your Code References
                                                                                      ↓
                                                                          .NET Trimmer Removes Unused
```

### Architecture

```
EasyAppDev.Blazor.Icons/
├── src/
│   ├── EasyAppDev.Blazor.Icons.Lucide/           # Lucide icon package
│   │   ├── Components/                             # 1,539 physical component files
│   │   │   ├── LuActivity.cs
│   │   │   ├── LuHome.cs
│   │   │   └── ... (1,539 total)
│   │   └── EasyAppDev.Blazor.Icons.Lucide.csproj
│   ├── EasyAppDev.Blazor.Icons.Bootstrap/        # Bootstrap icon package
│   │   ├── Components/                             # 2,078 physical component files
│   │   └── EasyAppDev.Blazor.Icons.Bootstrap.csproj
│   ├── EasyAppDev.Blazor.Icons.MaterialDesign/   # Material Design icon package
│   │   ├── Components/                             # 7,447 physical component files
│   │   └── EasyAppDev.Blazor.Icons.MaterialDesign.csproj
│   └── BlazorIcons.Generator/                     # Icon generator tool
│       ├── generate-components.py                 # Generates physical .cs files from SVGs
│       └── icon-sources/                          # SVG source files
└── samples/
    └── EasyAppDev.Blazor.Icons.Sample/           # Demo Blazor app
```

## Building from Source

### Prerequisites

- .NET 8.0 or .NET 9.0 SDK
- Python 3.x (only needed if regenerating icon data from SVGs)

### Build Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons.git
   cd EasyAppDev.Blazor.Icons
   ```

2. **Build the solution**:
   ```bash
   dotnet build
   ```
   All physical component files are compiled into their respective package assemblies.

3. **Run the sample app**:
   ```bash
   dotnet run --project samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample
   ```
   Open `http://localhost:5090` in your browser.

### Regenerating Icons (Optional)

Only needed if you modify SVG sources or add new icons:

```bash
cd src/BlazorIcons.Generator
python3 generate-components.py
cd ../..
dotnet build
```

This regenerates all 11,064 component files in the appropriate package directories.

## Testing Trimming

To verify trimming is working:

```bash
# Build the sample app
dotnet build samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.Client/

# Check for RZ10012 warnings (these indicate trimming WON'T work)
# Build output should have NO warnings about "unexpected name" for icon components

# Check icon library sizes before trimming
ls -lh src/EasyAppDev.Blazor.Icons.Lucide/bin/Release/net9.0/
# Should show: ~1.5MB for Lucide (untrimmed)

# Publish with trimming
dotnet publish samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.Client/ \
  -c Release

# Check published output
ls -lh samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.Client/bin/Release/net9.0/publish/wwwroot/_framework/*.wasm | grep -i "Icons"
# Icon library WASM files should NOT be present (they're merged and trimmed into client assembly)

# Check client assembly size
ls -lh samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.Client/bin/Release/net9.0/publish/wwwroot/_framework/*.wasm | grep "Sample.Client"
# Should show: ~6-10KB for the client assembly (contains only referenced icons)
```

**Expected Results:**

| Status | Icon Libraries | Size | Notes |
|--------|---------------|------|-------|
| **Development Build** (Release) | Separate DLL files | Lucide: ~1.6MB<br>Bootstrap: ~3.2MB<br>MaterialDesign: ~10MB<br>**Total: 14.8MB** | Full libraries for development |
| **Published (Release)** with trimming | **Merged into client assembly** | Client assembly: ~6KB overhead<br>Brotli compressed: ~2.3KB | Icon libraries completely trimmed and merged |
| **Published without proper syntax** | Separate WASM files | ~14.8MB total overhead | ❌ Trimming failed - check for RZ10012 warnings |

**Signs trimming is working:**
- ✅ No RZ10012 warnings during build
- ✅ Icon library WASM files are NOT in published _framework folder
- ✅ Client assembly size is only ~6-10KB
- ✅ Published app is dramatically smaller than development build

**Signs trimming is NOT working:**
- ❌ RZ10012 warnings about "unexpected name" during build
- ❌ Icon library WASM files present in published _framework folder (~14MB total)
- ❌ Build warnings suggest namespace alias syntax was used

## How Trimming Works

The library achieves true trimming through:

1. **Physical Component Files** - Each of the 11,064 icons is a separate sealed ComponentBase class
2. **Separate Assemblies** - Icon packages are compiled into separate DLLs
3. **Direct References Only** - Icons must be directly referenced in code (e.g., `<Activity />`)
4. **IL Linker** - .NET's trimmer analyzes references and removes unreferenced classes
5. **No Reflection** - No dictionary lookups, no dynamic loading

**Why this works:**
- Source generation creates code compiled into your app (can't trim individual icons)
- Physical files in separate packages allow .NET's trimmer to see unused types
- Each icon class is sealed, making trimmer analysis straightforward
- Unreferenced icons are removed during `dotnet publish`
- With `TrimMode=full`, the trimmer merges used icons into your client assembly and discards unused ones

**Trimming Process:**
1. **Development**: All icon libraries compiled as separate DLLs (~14.8MB total)
2. **Build Analysis**: Razor compiler identifies which icon components are referenced
3. **Publish with Trimming**: .NET IL Linker analyzes references
4. **Merge & Trim**: Used icons inlined into client assembly, unused icons discarded
5. **Result**: Only ~6KB overhead for icon functionality (99.96% reduction from 14.8MB)

**What works (trims properly)**:
```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Direct reference - will be trimmed if not used -->
<LuActivity />
<LuHome />

<!-- Or with fully qualified names -->
<EasyAppDev.Blazor.Icons.Lucide.LuActivity />
<EasyAppDev.Blazor.Icons.Bootstrap.BiHouse />
```

**What doesn't work for trimming**:
```csharp
// Dynamic lookups prevent trimming - keeps all icons
var iconType = Type.GetType("EasyAppDev.Blazor.Icons.Lucide.LuActivity");
```

## Performance

- **Build time**: ~5-10 seconds (first build compiles all components, incremental builds <1 second)
- **Icon library sizes (Development/Release)**:
  - Lucide: ~1.6MB (1,539 icons)
  - Bootstrap: ~3.2MB (2,078 icons)
  - MaterialDesign: ~10MB (7,447 icons)
  - Total: ~14.8MB for all three libraries
- **Published app (Release with trimming)**:
  - Icon overhead: **~6KB** (only referenced icons merged into client assembly)
  - Compressed (Brotli): **~2.3KB**
  - Trimming effectiveness: **99.96% reduction** (14.8MB → 6KB)
  - Icon library WASM files: **Not present** (merged and trimmed)
- **Typical usage** (60 icons from multiple libraries): ~6KB overhead
- **Runtime**: Zero overhead - just sealed component classes with embedded SVG
- **Network**: Zero HTTP requests - all SVG content embedded in compiled code

**Real-world example** (sample app with ~60 icons from all three libraries):
- Development build: 14.8MB icon libraries
- Published (trimmed): 6.3KB icon overhead (2.3KB Brotli compressed)
- Reduction: 99.96%

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT License - see LICENSE file for details

## Acknowledgments

- [Lucide Icons](https://lucide.dev/) - Beautiful open-source icon library
- [Bootstrap Icons](https://icons.getbootstrap.com/) - Official Bootstrap icon library
- [Material Design Icons](https://fonts.google.com/icons) - Google's Material Design icons
- [FontAwesome](https://fontawesome.com/) - The web's most popular icon set
- [FluentUI System Icons](https://github.com/microsoft/fluentui-system-icons) - Microsoft's Fluent Design System icons

## FAQ

### Why physical components instead of source generation?

Physical component files in separate packages enable true trimming because:
- Source generators create code compiled into YOUR assembly (can't trim individual icons)
- Physical files compiled into separate package assemblies allow the .NET IL Linker to analyze and remove unused types
- Each icon is a sealed class in a separate file, making trimmer analysis straightforward
- Unused icons are completely removed during `dotnet publish`, reducing output size dramatically

### Why separate packages instead of one large package?

Separate packages allow you to:
- Install only the icon libraries you need
- Reduce total package size (don't include unused icon sets)
- Have finer control over dependencies
- Keep the sample smaller when testing

You can install multiple packages together if needed.

### Does this work with Blazor Server, WebAssembly, and Hybrid?

Yes! The library works with all Blazor hosting models on both .NET 8.0 and .NET 9.0. Icons are embedded in compiled components.

### Can I use icons dynamically?

For best trimming, always reference icons directly. Dynamic loading via `Type.GetType()` would prevent trimming and require keeping all icons.

### I'm seeing RZ10012 warnings - what does this mean?

RZ10012 warnings like "Found markup element with unexpected name 'Lucide.LuActivity'" mean:
- The Razor compiler doesn't recognize your icons as components
- **Trimming will NOT work** - all icons will be included in published output (~14.8MB overhead instead of ~6KB)
- You're using namespace alias syntax (`@using Lucide = ...`)

**Fix:** Use direct namespace imports or fully qualified names:
```razor
<!-- ❌ WRONG - causes RZ10012 warnings -->
@using Lucide = EasyAppDev.Blazor.Icons.Lucide
<Lucide.LuActivity />

<!-- ✅ CORRECT - Option 1: Direct import -->
@using EasyAppDev.Blazor.Icons.Lucide
<LuActivity />

<!-- ✅ CORRECT - Option 2: Fully qualified -->
<EasyAppDev.Blazor.Icons.Lucide.LuActivity />
```

After fixing, rebuild and verify there are no RZ10012 warnings in your build output.

### How can I verify trimming is working?

1. **Build your WebAssembly project** and check for RZ10012 warnings
2. **Publish in Release mode**: `dotnet publish -c Release`
3. **Check published output**: Icon library WASM files should NOT be present
4. **Verify size**: Client assembly should be only ~6-10KB

See the [Testing Trimming](#testing-trimming) section for detailed verification steps.

### How do I add custom icons?

1. Add SVG files to `src/BlazorIcons.Generator/icon-sources/custom/`
2. Update `generate-components.py` to include your custom set
3. Run the generator: `python3 generate-components.py`
4. Rebuild: `dotnet build`

## Support

For issues, questions, or contributions:
- GitHub Issues: https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons/issues
- Documentation: https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons/wiki
