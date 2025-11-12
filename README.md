# EasyAppDev.Blazor.Icons

A fully trimmable Blazor icon library with 11,000+ icons from Lucide, Bootstrap, and Material Design. Physical component files enable true trimming - only icons you reference are included in your published output.

## Features

- **True Trimming**: Only icons you directly reference are included in published output (~5-10KB for typical usage)
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

1. **Icon Data**: SVG content stored in source code as constants
2. **Component Generation**: Python script generates individual sealed `ComponentBase` classes with embedded SVG
3. **Compilation**: Each package compiles its icon components into separate assemblies
4. **Trimming**: .NET's IL Linker removes unreferenced icon classes during `dotnet publish`

```
SVG Files → Python Script → Physical .cs Component Files → .NET Compiler → Assemblies
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

| Package | Version | Icons | Size (Untrimmed) |
|---------|---------|-------|------------------|
| `EasyAppDev.Blazor.Icons.Lucide` | 1.0.0 | ~1,500 | ~1.5MB |
| `EasyAppDev.Blazor.Icons.Bootstrap` | 1.0.0 | ~2,000 | ~1.9MB |
| `EasyAppDev.Blazor.Icons.MaterialDesign` | 1.0.0 | ~7,400 | ~5.7MB |

After publishing with trimming enabled, the actual size depends on how many icons you use (typically 5-50KB).

### Basic Usage

No configuration needed! Just reference icons directly. Here are common patterns:

**Single icon library** (simplest):
```razor
@page "/"
@using EasyAppDev.Blazor.Icons.Lucide

<h1>My Page</h1>

<Activity />
<Airplay />
<Home />
```

**Multiple icon libraries** (using namespace aliases to avoid conflicts):
```razor
@page "/"
@using Lucide = EasyAppDev.Blazor.Icons.Lucide
@using Bootstrap = EasyAppDev.Blazor.Icons.Bootstrap

<h1>My Page</h1>

<!-- Lucide icons -->
<Lucide.Activity />
<Lucide.Airplay />
<Lucide.Home />

<!-- Bootstrap icons -->
<Bootstrap.House />
<Bootstrap.Person />
<Bootstrap.Gear />
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
@using Bootstrap = EasyAppDev.Blazor.Icons.Bootstrap
@using MaterialDesign = EasyAppDev.Blazor.Icons.MaterialDesign

<!-- Lucide (outline icons) - control stroke width -->
<Activity style="color: currentColor; stroke-width: 2;" />
<Activity style="color: currentColor; stroke-width: 1.5;" />

<!-- Bootstrap & Material Design (filled icons) -->
<Bootstrap.Activity style="color: currentColor;" />
<MaterialDesign.Activity style="color: currentColor;" />
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

When using multiple icon libraries, you have two options:

**Option 1: Use fully qualified names**

```razor
@using EasyAppDev.Blazor.Icons.Lucide
@using EasyAppDev.Blazor.Icons.Bootstrap

<!-- Fully qualified to avoid ambiguity -->
<EasyAppDev.Blazor.Icons.Lucide.Home />
<EasyAppDev.Blazor.Icons.Bootstrap.House />
```

**Option 2: Use namespace aliases**

```razor
@using Lucide = EasyAppDev.Blazor.Icons.Lucide
@using Bootstrap = EasyAppDev.Blazor.Icons.Bootstrap

<!-- Clear and concise with aliases -->
<Lucide.Home />
<Bootstrap.House />
```

**Option 3: Mix namespaced and unnamespaced usage**

```razor
@using EasyAppDev.Blazor.Icons.Lucide
@using EasyAppDev.Blazor.Icons.Bootstrap

<!-- Lucide icons with short names (after using) -->
<Home />
<Activity />

<!-- Bootstrap icons with fully qualified names -->
<EasyAppDev.Blazor.Icons.Bootstrap.House />
<EasyAppDev.Blazor.Icons.Bootstrap.Person />
```

#### Best Practices

- **For single icon library projects**: Use `@using` for clean, concise code
- **For multi-library projects**: Use namespace aliases to keep code readable while avoiding conflicts
- **For shared components**: Use fully qualified names for clarity and maintainability

## Building from Source

### Prerequisites

- .NET 9 SDK
- Python 3.x (only needed if regenerating icon data from SVGs)

### Build Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/EasyAppDev.Blazor.Icons.git
   cd EasyAppDev.Blazor.Icons
   ```

2. **Build the solution**:
   ```bash
   dotnet build
   ```
   The source generator runs automatically during build.

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

# Check icon library sizes before trimming
ls -lh src/EasyAppDev.Blazor.Icons.Lucide/bin/Release/net9.0/
# Should show: 1.5MB for Lucide (untrimmed)

# Publish with trimming
dotnet publish samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.Client/ \
  -c Release

# Check published icon library sizes
ls -lh samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.Client/bin/Release/net9.0/publish/wwwroot/_framework/ | grep -i "EasyAppDev"
# Should show: ~5-10KB for icon libraries (after trimming, with only referenced icons)
```

**Expected Results:**
- Untrimmed: 1.5MB+ for each icon library
- Trimmed: 5-10KB (only icons you actually use)

## How Trimming Works

The library achieves true trimming through:

1. **Physical Component Files** - Each of the 11,064 icons is a separate sealed ComponentBase class
2. **Separate Assemblies** - Icon packages are compiled into separate DLLs
3. **Direct References Only** - Icons must be directly referenced in code (e.g., `<Activity />`)
4. **IL Linker** - .NET's trimmer analyzes references and removes unreferenced classes
5. **No Reflection** - No dictionary lookups, no dynamic loading

**Why this works:**
- Source generation created code compiled into your app (couldn't trim)
- Physical files in separate packages allow .NET's trimmer to see unused types
- Each icon class is sealed, making trimmer analysis easier
- Unreferenced icons are removed during `dotnet publish`

**What works (trims properly)**:
```razor
<!-- Direct reference - will be trimmed if not used -->
<LucideActivity />
<EasyAppDev.Blazor.Icons.Lucide.Home />
```

**What doesn't work for trimming**:
```csharp
// Dynamic lookups prevent trimming - keeps all icons
var iconType = Type.GetType("EasyAppDev.Blazor.Icons.Lucide.Activity");
```

## Performance

- **Build time**: ~5-10 seconds (first build compiles all components, incremental builds much faster)
- **Icon library sizes (untrimmed)**:
  - Lucide: ~1.5MB
  - Bootstrap: ~1.9MB
  - MaterialDesign: ~5.7MB
- **Published app**: Only icons you use (~5-50KB typical for Lucide, ~10-100KB for MaterialDesign)
- **Runtime**: Zero overhead - just sealed component classes with embedded SVG

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
- Source generators create code compiled into YOUR assembly (can't trim)
- Physical files are in separate assemblies that the trimmer can analyze independently
- Unused types are identified and removed during `dotnet publish`
- Each icon is a sealed class, making trimmer analysis effective

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

### How do I add custom icons?

1. Add SVG files to `src/BlazorIcons.Generator/icon-sources/custom/`
2. Update `generate-components.py` to include your custom set
3. Run the generator: `python3 generate-components.py`
4. Rebuild: `dotnet build`

## Support

For issues, questions, or contributions:
- GitHub Issues: https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons/issues
- Documentation: https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons/wiki
