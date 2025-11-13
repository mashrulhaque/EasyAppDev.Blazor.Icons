# Updating Icon Libraries

This guide explains how to update the icon libraries (Lucide, Bootstrap, Material Design) to their latest versions and regenerate the components.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Detailed Steps](#detailed-steps)
- [Testing Changes](#testing-changes)
- [Verifying Trimming](#verifying-trimming)
- [Troubleshooting](#troubleshooting)

## Overview

The icon update workflow consists of these steps:

1. Update NPM package versions in `package.json`
2. Download new icon SVG files from NPM packages
3. Regenerate C# icon data files
4. Build the library (source generator creates components)
5. Test and verify trimming still works

## Quick Start

For experienced developers, use the automated setup:

```bash
# Navigate to generator directory
cd src/BlazorIcons.Generator

# Update package.json versions (see below)
# Then run the complete setup
npm install
npm run setup

# Build the library
cd ../..
./build.sh --skip-prompt
```

Or use the unified build script with regeneration:

```bash
# From repository root
./build.sh --regenerate
```

## Detailed Steps

### 1. Update Icon Library Versions

Edit `src/BlazorIcons.Generator/package.json` and update the dependency versions:

```json
{
  "dependencies": {
    "lucide-static": "^0.460.0",      // Update this version
    "bootstrap-icons": "^1.11.3",     // Update this version
    "@mdi/svg": "^7.4.47"             // Update this version
  }
}
```

To find the latest versions:

```bash
# Check latest Lucide version
npm view lucide-static version

# Check latest Bootstrap Icons version
npm view bootstrap-icons version

# Check latest Material Design Icons version
npm view @mdi/svg version
```

### 2. Download New Icons

Navigate to the generator directory and download the updated icons:

```bash
cd src/BlazorIcons.Generator

# Install updated NPM packages
npm install

# Download icon SVG files
npm run download
```

This will:
- Download SVG files from the NPM packages
- Copy them to `icon-sources/{library}/` directories
- Clear old SVG files and replace with new ones

### 3. Regenerate Icon Data

Generate the C# icon data files from the downloaded SVGs:

```bash
# Still in src/BlazorIcons.Generator
npm run generate

# Or run Python script directly
python3 generate-icons.py
```

This creates/updates files in `../EasyAppDev.Blazor.Icons/IconData/`:
- `IconData/LucideIcons/LucideIcons.Icons.Part*.cs`
- `IconData/BootstrapIcons/BootstrapIcons.Icons.Part*.cs`
- `IconData/MaterialDesignIcons/MaterialDesignIcons.Icons.Part*.cs`

### 4. Build the Library

The source generator reads the IconData files and creates individual component classes:

```bash
# Return to repository root
cd ../..

# Build the solution
dotnet build

# Or use the build script
./build.sh --skip-prompt
```

During the build, the source generator (`EasyAppDev.Blazor.Icons.SourceGenerator`) will:
- Read IconData files as AdditionalFiles
- Generate individual sealed ComponentBase classes for each icon
- Output ~11,000+ component classes

### 5. Update Package Versions

If this is a new release, update the version numbers in the package `.csproj` files:

- `src/EasyAppDev.Blazor.Icons.Lucide/EasyAppDev.Blazor.Icons.Lucide.csproj`
- `src/EasyAppDev.Blazor.Icons.Bootstrap/EasyAppDev.Blazor.Icons.Bootstrap.csproj`
- `src/EasyAppDev.Blazor.Icons.MaterialDesign/EasyAppDev.Blazor.Icons.MaterialDesign.csproj`

Update the `<Version>` property:

```xml
<PropertyGroup>
  <Version>1.0.3</Version>
</PropertyGroup>
```

## Testing Changes

### 1. Run the Sample Application

Test that icons render correctly:

```bash
dotnet run --project samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.csproj
```

Visit `http://localhost:5090` and verify:
- Icons render correctly
- No missing SVG content
- Styling attributes work (color, size, etc.)

### 2. Test New Icons

If the icon library added new icons, test them:

```razor
@* Add to a sample page *@
<LucideNewIconName />
<BootstrapNewIconName />
<MaterialDesignNewIconName />
```

### 3. Check for Breaking Changes

Review the icon library's changelog for:
- Renamed icons (may break existing code)
- Removed icons (will cause compilation errors)
- Changed SVG structure (may affect styling)

## Verifying Trimming

Trimming is the core feature - verify it still works:

### 1. Publish the Sample App

```bash
dotnet publish samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.csproj \
  -c Release \
  --output ./publish
```

### 2. Check Published DLL Size

```bash
# On Unix/macOS
ls -lh publish/wwwroot/_framework/EasyAppDev.Blazor.Icons.*.dll

# On Windows PowerShell
Get-ChildItem publish\wwwroot\_framework\EasyAppDev.Blazor.Icons.*.dll | Format-Table Name, Length
```

### 3. Expected Results

- **Unpublished (Debug)**: ~20MB with all 11,000+ icons
- **Published with trimming**: Only referenced icons included (~5-50KB typical)

If the sample app uses ~5-10 icons, the published DLL should be small (5-50KB).

### 4. Verify Trimming Settings

Ensure these settings are in the icon library `.csproj` files:

```xml
<PropertyGroup>
  <IsTrimmable>true</IsTrimmable>
  <EnableTrimAnalyzer>true</EnableTrimAnalyzer>
  <TrimMode>link</TrimMode>
</PropertyGroup>
```

## Troubleshooting

### Icons Not Generating

**Problem**: Build succeeds but no icons appear

**Solution**:
1. Check that `IconData/**/*.cs` files exist and contain icon data
2. Verify `<AdditionalFiles Include="IconData/**/*.cs" />` in `.csproj`
3. Clean and rebuild: `dotnet clean && dotnet build`

### Build Errors After Update

**Problem**: Compilation errors after updating icons

**Solution**:
1. Check if icons were renamed/removed in the new version
2. Review the icon library's changelog/migration guide
3. Update sample app code to use new icon names

### Trimming Not Working

**Problem**: Published DLL is still 20MB with all icons

**Solution**:
1. Verify `IsTrimmable=true` in all icon library `.csproj` files
2. Ensure using `dotnet publish` in Release configuration
3. Check that components are sealed classes (enables trimming)
4. Verify no reflection or dynamic loading of icons

### Python Script Fails

**Problem**: `generate-icons.py` errors or doesn't generate files

**Solution**:
1. Ensure Python 3.x is installed: `python3 --version`
2. Check that `icon-sources/` directories contain SVG files
3. Run `npm run download` first to download SVGs
4. Check for permission errors in output directories

### SVG Content Issues

**Problem**: Icons render incorrectly or missing paths

**Solution**:
1. Inspect the generated `IconData/**/*.cs` files
2. Check if SVG content was properly extracted
3. Verify icon SVG files in `icon-sources/` are valid
4. Re-run `npm run setup` to regenerate everything

## Advanced Workflows

### Partial Update (Single Library)

To update only one icon library (e.g., Lucide):

```bash
cd src/BlazorIcons.Generator

# Update only Lucide in package.json
npm install

# Download icons (downloads all libraries)
npm run download

# Generate icon data (processes all libraries)
python3 generate-icons.py

# Build
cd ../..
dotnet build
```

Note: The generator processes all libraries, so you'll get updates for any changed SVG files.

### Testing Without Committing

To test icon updates without committing the generated files:

```bash
# Create a test branch
git checkout -b test-icon-update

# Run the update process
cd src/BlazorIcons.Generator
npm install
npm run setup

# Build and test
cd ../..
dotnet build
dotnet run --project samples/.../Sample.csproj

# If successful, commit; otherwise discard
git checkout main
git branch -D test-icon-update
```

### Reverting Icon Updates

If an update causes issues:

```bash
# Restore IconData files from git
git restore src/EasyAppDev.Blazor.Icons/IconData/

# Restore package.json
git restore src/BlazorIcons.Generator/package.json

# Rebuild with old data
dotnet clean
dotnet build
```

## Icon Library Documentation

- **Lucide**: https://lucide.dev/
- **Bootstrap Icons**: https://icons.getbootstrap.com/
- **Material Design Icons**: https://pictogrammers.com/library/mdi/

## Next Steps

After successfully updating icons:

1. Test thoroughly with the sample app
2. Verify trimming with a published build
3. Update version numbers in `.csproj` files
4. Update README.md with new icon counts (if changed significantly)
5. Create NuGet packages: `dotnet pack -c Release`
6. Commit changes and create a release
