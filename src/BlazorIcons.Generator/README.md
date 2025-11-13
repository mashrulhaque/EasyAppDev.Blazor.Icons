# 🎨 Icon Generator

Generate Blazor icon components from SVG files in seconds.

---

## 🚀 Initial Setup - REQUIRED FOR NEW CONTRIBUTORS

**IMPORTANT:** Before generating icons, you must download the icon sources first!

### Step 1: Install Node.js Dependencies

```bash
cd src/BlazorIcons.Generator
npm install
```

This installs the NPM packages that contain the icon SVG files.

### Step 2: Download Icon Sources

```bash
node download-icons.js
```

This downloads ~11,000 SVG files from NPM packages:
- **Lucide** (~1,500 icons)
- **Bootstrap** (~2,000 icons)
- **Material Design** (~7,400 icons)

**Note:** Icon sources are NOT committed to git (see .gitignore). All contributors must run this step.

### Step 3: You're Ready!

Now you can generate components using the instructions below.

---

## ⚡ Quick Start

### 1️⃣ Add Your SVG Files

Place SVG files in the appropriate icon library folder:

```
icon-sources/
├── lucide/           # Add Lucide SVGs here
├── bootstrap/        # Add Bootstrap SVGs here
└── material-design/  # Add Material Design SVGs here
```

### 2️⃣ Run the Generator

**macOS / Linux:**
```bash
cd src/BlazorIcons.Generator
python3 generate-components.py
```

**Windows (PowerShell):**
```powershell
cd src\BlazorIcons.Generator
python3 generate-components.py
```

### 3️⃣ Rebuild Your Project

```bash
dotnet build
```

That's it! Your icons are now ready to use. ✨

---

## 📖 How It Works

```
SVG Files in icon-sources/
        ↓
   Generator reads SVGs
        ↓
  Extracts inner content
        ↓
  Generates .cs component files
        ↓
  Organized by icon library
        ↓
   Ready to compile!
```

**Result:** Individual sealed `ComponentBase` classes for each icon, optimized for trimming.

---

## 🗂️ Directory Structure

```
src/BlazorIcons.Generator/
│
├── 📄 generate-components.py       ← Main generator script
├── 📄 generate-icons.py            ← Legacy (for icon data only)
│
├── 🗂️ icon-sources/                ← Your SVG files go here
│   ├── lucide/                    # ~1,500 Lucide SVGs
│   ├── bootstrap/                 # ~2,000 Bootstrap SVGs
│   └── material-design/           # ~7,400 Material Design SVGs
│
└── 📖 README.md                    ← You are here!
```

---

## 🚀 Generated Output

The generator creates physical `.cs` component files in three separate packages:

```
Generated Components:
├── src/EasyAppDev.Blazor.Icons.Lucide/Components/
│   ├── Activity.cs
│   ├── Home.cs
│   └── ... (1,539 total)
│
├── src/EasyAppDev.Blazor.Icons.Bootstrap/Components/
│   ├── House.cs
│   ├── Search.cs
│   └── ... (2,078 total)
│
└── src/EasyAppDev.Blazor.Icons.MaterialDesign/Components/
    ├── Home.cs
    ├── Settings.cs
    └── ... (7,447 total)
```

Each component is:
- ✅ A sealed `ComponentBase` class
- ✅ Fully embedded SVG content
- ✅ Zero runtime overhead
- ✅ Trimmable by .NET linker

---

## 🔧 Configuration

Each icon library has default SVG attributes that are applied automatically:

| Library | ViewBox | Default Fill | Default Stroke | Notes |
|---------|---------|--------------|-----------------|-------|
| **Lucide** | `0 0 24 24` | `none` | `currentColor` | Outline style, 2px stroke |
| **Bootstrap** | `0 0 16 16` | `currentColor` | — | Filled style |
| **Material Design** | `0 0 24 24` | `currentColor` | — | Filled style |

These are applied automatically in the generator - no manual configuration needed!

---

## 📝 Step-by-Step: Adding New Icons

### For Lucide Icons:
1. Download SVGs from [lucide.dev](https://lucide.dev)
2. Extract to `icon-sources/lucide/`
3. Run: `python3 generate-components.py`
4. Rebuild: `dotnet build`

### For Bootstrap Icons:
1. Download SVGs from [icons.getbootstrap.com](https://icons.getbootstrap.com)
2. Extract to `icon-sources/bootstrap/`
3. Run: `python3 generate-components.py`
4. Rebuild: `dotnet build`

### For Material Design Icons:
1. Download SVGs from [fonts.google.com/icons](https://fonts.google.com/icons)
2. Extract to `icon-sources/material-design/`
3. Run: `python3 generate-components.py`
4. Rebuild: `dotnet build`

---

## ✅ What You Get

After running the generator:

- ✅ **11,064** physical component files (one per icon)
- ✅ **Organized** by icon library in separate projects
- ✅ **Type-safe** - Full IntelliSense support
- ✅ **Trimmable** - Only used icons in published output
- ✅ **Fast** - Sealed classes, no reflection
- ✅ **Embedded** - SVG content directly in component code

---

## 🎯 Component Usage

Once generated and built, use icons in your Razor components:

```razor
@using EasyAppDev.Blazor.Icons.Lucide
@using EasyAppDev.Blazor.Icons.Bootstrap

<!-- Simple usage -->
<LucideHome />
<BootstrapSearch />

<!-- With styling -->
<LucideActivity style="color: red; width: 32px;" />

<!-- With accessibility -->
<LucideUser AriaLabel="User profile" />
```

---

## 🐛 Troubleshooting

### "No SVG files found in icon-sources"
- Check SVG files are directly in `icon-sources/{library}/`
- Not in subfolders - they should be flat
- Files must have `.svg` extension

### "Python3 not found"
- Install Python 3: https://www.python.org/downloads/
- Or use system package manager:
  ```bash
  # macOS
  brew install python3

  # Ubuntu/Debian
  sudo apt-get install python3
  ```

### Build fails after generation
- Clean and rebuild: `dotnet clean && dotnet build`
- Check generator output for errors
- Verify icon names are valid C# identifiers

---

## 📚 Icon Library Reference

| Library | Count | Style | Homepage |
|---------|-------|-------|----------|
| **Lucide** | ~1,500 | Outline | [lucide.dev](https://lucide.dev) |
| **Bootstrap** | ~2,000 | Filled | [icons.getbootstrap.com](https://icons.getbootstrap.com) |
| **Material Design** | ~7,400 | Filled | [fonts.google.com/icons](https://fonts.google.com/icons) |

---

## 💡 Tips & Tricks

### Optimize Build Speed
- Only add icons you actually use
- Don't include entire icon libraries if you only need a few
- Clean build cache: `dotnet clean`

### Verify Generated Components
```bash
# Count generated files
find ../EasyAppDev.Blazor.Icons.Lucide/Components -name "*.cs" | wc -l

# List first few components
ls ../EasyAppDev.Blazor.Icons.Lucide/Components | head -10
```

### Check Component Size
The generated DLLs are optimized:
- Lucide: ~1.5MB (untrimmed)
- Bootstrap: ~3MB (untrimmed)
- Material Design: ~9.6MB (untrimmed)

After trimming for production: **~5-50KB** (depending on usage)

---

## 🔄 Regenerating All Icons

Want to update all icons?

```bash
# From project root
cd src/BlazorIcons.Generator
python3 generate-components.py
cd ../..
dotnet build
```

This regenerates all **11,064** icon components with the latest SVG data.

---

## 🎓 How Generation Works

1. **Scan**: Reads all `.svg` files from `icon-sources/{library}/`
2. **Parse**: Extracts inner SVG content from each file
3. **Name**: Converts filename to PascalCase C# identifier
   - `home.svg` → `Home`
   - `arrow-right.svg` → `ArrowRight`
   - `123-icon.svg` → `_123Icon` (prefixed with `_`)
4. **Generate**: Creates component class with:
   - Embedded SVG content
   - Default attributes for that library
   - `AriaLabel` parameter for accessibility
   - `AdditionalAttributes` for custom styling
5. **Organize**: Saves to correct package folder

---

## 🚀 Next Steps

1. ✅ Add your SVG files to `icon-sources/`
2. ✅ Run `python3 generate-components.py`
3. ✅ Build with `dotnet build`
4. ✅ Use icons in your Razor components
5. ✅ Publish and enjoy tiny trimmed bundles!

---

## 📞 Questions?

- Check the main [README.md](../../README.md) for usage examples
- See [CLAUDE.md](../../CLAUDE.md) for architecture details
- Review component code for available parameters

Happy icon generating! 🎉
