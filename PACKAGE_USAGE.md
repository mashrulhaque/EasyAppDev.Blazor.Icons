# EasyAppDev.Blazor.Icons - Usage Guide

## ✅ Installation (2 Steps - Fully Automatic!)

### Step 1: Install the Package

```bash
dotnet add package EasyAppDev.Blazor.Icons
```

**That's it!** The source generator is automatically configured via MSBuild props. No manual setup needed! ✨

### Step 2: Use Icons in Your Razor Components

```razor
@page "/"

<h1>Welcome</h1>

<!-- Use icons with fully qualified names -->
@EasyAppDev.Blazor.Icons.Lucide.Home.Render()
@EasyAppDev.Blazor.Icons.Bootstrap.Person.Render()
@EasyAppDev.Blazor.Icons.MaterialDesign.Settings.Render()
```

## 📦 How It Works

### ✅ **Fully Trimmable Architecture**

Unlike traditional icon libraries that ship all 11,074 icons in a DLL:

1. **Source Generator Scans Your Code**: At build time, the generator scans your Razor files
2. **Detects Icon Usage**: Finds patterns like `@EasyAppDev.Blazor.Icons.Lucide.Home.Render()`
3. **Generates Only Used Icons**: Creates ONLY the icon classes you actually use
4. **Result**: Your app only includes the icons you need (~9 KB for 13 icons instead of 13 MB for all)

### 📊 Size Comparison

| Approach | Size | Icons Included |
|----------|------|----------------|
| Traditional (All icons in DLL) | 13 MB | 11,074 |
| **This Package (Usage-based)** | **~9 KB** | **Only what you use** |

## 🎨 Available Icon Libraries

- **Lucide**: 1,539 icons - `@EasyAppDev.Blazor.Icons.Lucide.{IconName}.Render()`
- **Bootstrap**: 2,050 icons - `@EasyAppDev.Blazor.Icons.Bootstrap.{IconName}.Render()`
- **Material Design**: 7,447 icons - `@EasyAppDev.Blazor.Icons.MaterialDesign.{IconName}.Render()`

## 💡 Usage Examples

### Basic Usage

```razor
<div class="icon-container">
    @EasyAppDev.Blazor.Icons.Lucide.Activity.Render()
</div>
```

### With Styling

```razor
<div class="icon-container" style="color: blue; font-size: 32px;">
    @EasyAppDev.Blazor.Icons.Lucide.Heart.Render()
</div>
```

### Multiple Icons

```razor
<nav>
    @EasyAppDev.Blazor.Icons.Lucide.Home.Render()
    @EasyAppDev.Blazor.Icons.Lucide.User.Render()
    @EasyAppDev.Blazor.Icons.Lucide.Settings.Render()
</nav>
```

## 🔍 Finding Icon Names

Icon names follow PascalCase convention:

- SVG file: `arrow-right.svg` → Icon name: `ArrowRight`
- SVG file: `home.svg` → Icon name: `Home`
- SVG file: `user-circle.svg` → Icon name: `UserCircle`

### Icon Libraries:

1. **Lucide Icons**: https://lucide.dev/icons/
2. **Bootstrap Icons**: https://icons.getbootstrap.com/
3. **Material Design Icons**: https://pictogrammers.com/library/mdi/

## ⚠️ Important Notes

1. **Build-Time Generation**: Icons are generated at compile time, not runtime
2. **Fully Qualified Names Required**: Must use full namespace (e.g., `@EasyAppDev.Blazor.Icons.Lucide.Home.Render()`)
3. **Clean Build**: If icons don't appear, try `dotnet clean && dotnet build`
4. **No Dynamic Loading**: Icon names must be hardcoded in Razor files (not from variables)

## 🚀 Performance Benefits

- **Smaller Bundle Size**: Only include what you use
- **Faster Load Times**: Less code to download and parse
- **Better Tree Shaking**: Unused icons are never compiled
- **No Runtime Overhead**: Icons are inlined at build time

## 🐛 Troubleshooting

### Icons Not Generating?

1. Verify source generator is referenced in your `.csproj`
2. Check that `AdditionalFiles` includes your Razor files
3. Run `dotnet clean && dotnet build`
4. Check build output for source generator diagnostics

### Icons Not Found?

1. Ensure you're using the correct library namespace (Lucide/Bootstrap/MaterialDesign)
2. Verify icon name is in PascalCase
3. Check the icon exists in the source library

### Build Errors?

1. Make sure IconData path points to the correct NuGet package location
2. Verify all `.csproj` configuration is correct
3. Try restoring packages: `dotnet restore`

## 📝 License

MIT License - See LICENSE file for details
