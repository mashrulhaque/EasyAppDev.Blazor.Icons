# EasyAppDev.Blazor.Icons

[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.Lucide.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.Lucide/)
[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.Bootstrap.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.Bootstrap/)
[![NuGet](https://img.shields.io/nuget/v/EasyAppDev.Blazor.Icons.MaterialDesign.svg)](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.MaterialDesign/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A fully trimmable Blazor icon library with 11,000+ icons from Lucide, Bootstrap, and Material Design. Physical component files enable true trimming - only icons you reference are included in your published output.

## Features

- **True Trimming**: Only icons you directly reference are included in published output (~6KB for typical usage, 99.96% reduction from full library)
- **Physical Components**: Individual sealed ComponentBase classes (11,064 total)
- **Zero Runtime Overhead**: No reflection, no HTTP calls, no dictionaries - just compiled code
- **Fully Embedded**: SVG content embedded directly in component code
- **Type-Safe**: Full compile-time checking with direct component references
- **Full IntelliSense**: Complete autocomplete and intellisense for all 11,000+ icons in your IDE
- **CSS Controllable**: Style icons with standard CSS properties (color, width, height, etc.)
- **Separate Packages**: Choose only the icon libraries you need:
  - `EasyAppDev.Blazor.Icons.Lucide` (~1,500 icons)
  - `EasyAppDev.Blazor.Icons.Bootstrap` (~2,000 icons)
  - `EasyAppDev.Blazor.Icons.MaterialDesign` (~7,400 icons)
- **Fast Builds**: Incremental builds leverage existing compiled components

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
│   │   │   ├── Activity.cs
│   │   │   ├── Home.cs
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

## Usage

### Installation

Install only the icon libraries you need:

```bash
# Lucide icons (~1,500 icons)
dotnet add package EasyAppDev.Blazor.Icons.Lucide

# Bootstrap icons (~2,000 icons)
dotnet add package EasyAppDev.Blazor.Icons.Bootstrap

# Material Design icons (~7,400 icons)
dotnet add package EasyAppDev.Blazor.Icons.MaterialDesign

# Or install multiple:
dotnet add package EasyAppDev.Blazor.Icons.Lucide
dotnet add package EasyAppDev.Blazor.Icons.Bootstrap
```

### Package Versions

Current versions of available packages:

| Package | Version | NuGet | Icons | Development Size | Published Size (Trimmed) |
|---------|---------|-------|-------|-----------------|-------------------------|
| `EasyAppDev.Blazor.Icons.Lucide` | 1.0.2 | [Install](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.Lucide/) | ~1,500 | ~1.5MB | **~2-4KB** ✨ |
| `EasyAppDev.Blazor.Icons.Bootstrap` | 1.0.2 | [Install](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.Bootstrap/) | ~2,000 | ~1.9MB | **~2-4KB** ✨ |
| `EasyAppDev.Blazor.Icons.MaterialDesign` | 1.0.2 | [Install](https://www.nuget.org/packages/EasyAppDev.Blazor.Icons.MaterialDesign/) | ~7,400 | ~5.7MB | **~2-5KB** ✨ |

**Trimming is extremely effective!** With proper syntax (see warning below), published apps include only referenced icons. Typical apps using 50-100 icons from all three libraries result in only **~6KB total overhead** (99.96% reduction).

### Basic Usage

No configuration needed! Just reference icons directly.

**⚠️ IMPORTANT: Do NOT use namespace aliases like `@using Lucide = ...` - this breaks trimming!** See the [Handling Naming Conflicts](#handling-naming-conflicts) section for details.

**Single icon library** (simplest):
```razor
@page "/"
@using EasyAppDev.Blazor.Icons.Lucide

<h1>My Page</h1>

<Activity />
<Airplay />
<Home />
```

**Multiple icon libraries** (use fully qualified names to avoid conflicts):
```razor
@page "/"

<h1>My Page</h1>

<!-- Lucide icons with fully qualified names -->
<EasyAppDev.Blazor.Icons.Lucide.Activity />
<EasyAppDev.Blazor.Icons.Lucide.Airplay />
<EasyAppDev.Blazor.Icons.Lucide.Home />

<!-- Bootstrap icons with fully qualified names -->
<EasyAppDev.Blazor.Icons.Bootstrap.House />
<EasyAppDev.Blazor.Icons.Bootstrap.Person />
<EasyAppDev.Blazor.Icons.Bootstrap.Gear />
```

**Alternative: Mix using statements with fully qualified names**
```razor
@page "/"
@using EasyAppDev.Blazor.Icons.Lucide

<h1>My Page</h1>

<!-- Lucide icons (short names after @using) -->
<Activity />
<Airplay />
<Home />

<!-- Bootstrap icons (fully qualified to avoid conflicts) -->
<EasyAppDev.Blazor.Icons.Bootstrap.House />
<EasyAppDev.Blazor.Icons.Bootstrap.Person />
<EasyAppDev.Blazor.Icons.Bootstrap.Gear />
```

### Styling Icons

Icons support all standard CSS styling. Icons inherit size and color from their parent element by default.

#### Size Control

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Using width and height -->
<Activity style="width: 24px; height: 24px;" />
<Activity style="width: 32px; height: 32px;" />
<Activity style="width: 48px; height: 48px;" />

<!-- Using font-size (if icon container doesn't specify width/height) -->
<div style="font-size: 24px;">
    <Activity />
</div>

<!-- Using CSS classes -->
<Home class="icon-sm" />      <!-- small -->
<Home class="icon-md" />      <!-- medium -->
<Home class="icon-lg" />      <!-- large -->
```

#### Color Control

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Inline color -->
<Activity style="color: red;" />
<Activity style="color: #00ff00;" />

<!-- Using CSS classes -->
<Activity class="text-primary" />
<Activity class="text-danger" />

<!-- From parent element -->
<div style="color: blue;">
    <Activity />
</div>
```

#### Icon Set Specific Styling

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Lucide (outline icons) - control stroke width -->
<Activity style="color: currentColor; stroke-width: 2;" />
<Activity style="color: currentColor; stroke-width: 1.5;" />

<!-- Bootstrap & Material Design (filled icons) - use fully qualified names -->
<EasyAppDev.Blazor.Icons.Bootstrap.House style="color: currentColor;" />
<EasyAppDev.Blazor.Icons.MaterialDesign.Home style="color: currentColor;" />
```

#### Animations & Effects

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Spinning animation -->
<div style="animation: spin 1s linear infinite;">
    <Loader />
</div>

<!-- Hover effects -->
<Activity class="icon-hover" />

<!-- Fade in/out -->
<Activity style="opacity: 0.7; transition: opacity 0.3s;" />
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
<Activity class="icon-responsive" />
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

<Activity class="icon-styled" />
```

### Accessibility

```razor
<!-- Decorative icon (default) -->
<Activity />

<!-- Icon with semantic meaning -->
<Activity AriaLabel="Loading activity" />
```

### Available Icon Sets

- **Lucide** (~1,500 icons): Modern, consistent design system
  - Namespace: `EasyAppDev.Blazor.Icons.Lucide`
  - Defaults: Outline style with `currentColor` stroke

- **Bootstrap** (~2,000 icons): Clean, simple Bootstrap icons
  - Namespace: `EasyAppDev.Blazor.Icons.Bootstrap`
  - Defaults: Filled style with `currentColor`

- **Material Design** (~7,500 icons): Google's Material Design icons
  - Namespace: `EasyAppDev.Blazor.Icons.MaterialDesign`
  - Defaults: Filled style with `currentColor`

### Handling Naming Conflicts

Icon names are isolated within their own namespaces, so icons with the same name across different libraries don't conflict. For example, many icon sets include a `Home` or `Activity` icon:

#### Using Single Library

If you use only one icon library, there are no conflicts:

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- This works - no ambiguity -->
<Home />
<Activity />
```

#### Using Multiple Libraries

When using multiple icon libraries, you have two options to avoid naming conflicts:

**Option 1: Use fully qualified names (recommended)**

```razor
<!-- No using statements needed -->
<EasyAppDev.Blazor.Icons.Lucide.Home />
<EasyAppDev.Blazor.Icons.Bootstrap.House />
<EasyAppDev.Blazor.Icons.MaterialDesign.Home />
```

**Option 2: Mix using statements with fully qualified names**

```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Lucide icons with short names (after @using) -->
<Home />
<Activity />

<!-- Other libraries with fully qualified names to avoid conflicts -->
<EasyAppDev.Blazor.Icons.Bootstrap.House />
<EasyAppDev.Blazor.Icons.MaterialDesign.Home />
```

**⚠️ CRITICAL: Namespace Alias Syntax Does Not Work**

**DO NOT use namespace aliases** like this:
```razor
@using Lucide = EasyAppDev.Blazor.Icons.Lucide
<Lucide.Activity />  <!-- ❌ WRONG - Breaks trimming! -->
```

This syntax causes the Razor compiler to treat icons as HTML elements instead of components, which:
- Generates RZ10012 warnings during build
- **Prevents trimming from working** (all icons will be included)
- Results in 14MB+ overhead instead of ~6KB

**✅ CORRECT approaches:**

```razor
<!-- Option 1: Direct namespace import -->
@using EasyAppDev.Blazor.Icons.Lucide
<Activity />  <!-- ✅ Works perfectly -->

<!-- Option 2: Fully qualified names -->
<EasyAppDev.Blazor.Icons.Lucide.Activity />  <!-- ✅ Works perfectly -->
```

**How to verify trimming will work:**
- Build your Blazor WebAssembly project
- Check for RZ10012 warnings about icon components
- If you see warnings like "Found markup element with unexpected name", trimming will NOT work properly
- Fix by using the correct syntax above

#### Best Practices

- **For single icon library projects**: Use `@using` for clean, concise code
- **For multi-library projects**: Use fully qualified names or mix approaches as shown above
- **For shared components**: Use fully qualified names for clarity and maintainability

## Building from Source

### Prerequisites

- .NET 9 SDK
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
| **Development Build** (Debug) | Separate DLL files | Lucide: ~1.5MB<br>Bootstrap: ~1.9MB<br>MaterialDesign: ~5.7MB | Full libraries for development |
| **Published (Release)** with `TrimMode=full` | **Merged into client assembly** | Client assembly: ~6KB overhead | Icon libraries completely trimmed and merged |
| **Published without proper syntax** | Separate WASM files | ~14MB total overhead | ❌ Trimming failed - check for RZ10012 warnings |

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
1. **Development**: All icon libraries compiled as separate DLLs (~9MB total)
2. **Build Analysis**: Razor compiler identifies which icon components are referenced
3. **Publish with Trimming**: .NET IL Linker analyzes references
4. **Merge & Trim**: Used icons inlined into client assembly, unused icons discarded
5. **Result**: Only ~6KB overhead for icon functionality (99.96% reduction)

**What works (trims properly)**:
```razor
@using EasyAppDev.Blazor.Icons.Lucide

<!-- Direct reference - will be trimmed if not used -->
<Activity />
<Home />

<!-- Or with fully qualified names -->
<EasyAppDev.Blazor.Icons.Lucide.Activity />
<EasyAppDev.Blazor.Icons.Bootstrap.House />
```

**What doesn't work for trimming**:
```csharp
// Dynamic lookups prevent trimming - keeps all icons
var iconType = Type.GetType("EasyAppDev.Blazor.Icons.Lucide.Activity");
```

## Performance

- **Build time**: ~5-10 seconds (first build compiles all components, incremental builds <1 second)
- **Icon library sizes (Development/Debug)**:
  - Lucide: ~1.5MB (1,539 icons)
  - Bootstrap: ~1.9MB (2,078 icons)
  - MaterialDesign: ~5.7MB (7,447 icons)
  - Total: ~9MB for all three libraries
- **Published app (Release with trimming)**:
  - Icon overhead: **~6KB** (only referenced icons merged into client assembly)
  - Trimming effectiveness: **99.96% reduction** (9MB → 6KB)
  - Icon library WASM files: **Not present** (merged and trimmed)
- **Typical usage** (80 icons from multiple libraries): ~6-10KB overhead
- **Runtime**: Zero overhead - just sealed component classes with embedded SVG
- **Network**: Zero HTTP requests - all SVG content embedded in compiled code

**Real-world example** (sample app with ~80 icons from all three libraries):
- Development build: 9MB+ icon libraries
- Published (trimmed): 6KB icon overhead
- Reduction: 99.93%

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT License - see LICENSE file for details

## Acknowledgments

- [Lucide Icons](https://lucide.dev/) - Beautiful open-source icon library
- [Material Design Icons](https://fonts.google.com/icons) - Google's Material Design icons
- [Bootstrap Icons](https://icons.getbootstrap.com/) - Official Bootstrap icon library

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

Yes! The library works with all Blazor hosting models. Icons are embedded in compiled components.

### Can I use icons dynamically?

For best trimming, always reference icons directly. Dynamic loading via `Type.GetType()` would prevent trimming and require keeping all icons.

### I'm seeing RZ10012 warnings - what does this mean?

RZ10012 warnings like "Found markup element with unexpected name 'Lucide.Activity'" mean:
- The Razor compiler doesn't recognize your icons as components
- **Trimming will NOT work** - all icons will be included in published output (~14MB overhead)
- You're likely using namespace alias syntax (`@using Lucide = ...`)

**Fix:** Use direct namespace imports instead:
```razor
<!-- ❌ WRONG - causes RZ10012 warnings -->
@using Lucide = EasyAppDev.Blazor.Icons.Lucide
<Lucide.Activity />

<!-- ✅ CORRECT - no warnings, trimming works -->
@using EasyAppDev.Blazor.Icons.Lucide
<Activity />
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
