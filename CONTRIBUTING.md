# Contributing to EasyAppDev.Blazor.Icons

Thank you for your interest in contributing to EasyAppDev.Blazor.Icons! This document provides guidelines and instructions for contributing to this project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Development Setup](#development-setup)
- [Architecture Overview](#architecture-overview)
- [Making Changes](#making-changes)
- [Code Style Guidelines](#code-style-guidelines)
- [Submitting Changes](#submitting-changes)
- [Reporting Issues](#reporting-issues)

## Code of Conduct

We are committed to providing a welcoming and inclusive environment for all contributors. Please be respectful and professional in all interactions.

## Getting Started

Before you begin:

- Check existing issues and pull requests to avoid duplicating work
- For major changes, open an issue first to discuss your proposed changes
- Make sure you have the required prerequisites installed

## Prerequisites

Before contributing, ensure you have the following installed:

- **.NET 9 SDK** - [Download here](https://dotnet.microsoft.com/download/dotnet/9.0)
- **Python 3.x** - Required only if regenerating icons from SVG sources
- **Git** - For version control
- **IDE** - Visual Studio 2022, Visual Studio Code, or JetBrains Rider

## Development Setup

### 1. Fork and Clone the Repository

```bash
# Fork the repository on GitHub, then clone your fork
git clone https://github.com/YOUR-USERNAME/EasyAppDev.Blazor.Icons.git
cd EasyAppDev.Blazor.Icons
```

### 2. Build the Solution

```bash
# Build all projects
dotnet build

# Or build specific packages
dotnet build src/EasyAppDev.Blazor.Icons.Lucide/EasyAppDev.Blazor.Icons.Lucide.csproj
```

The source generator runs automatically during build and generates icon components from the IconData files.

### 3. Run the Sample Application

```bash
# Run the Blazor sample application
dotnet run --project samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.csproj
```

Open `http://localhost:5090` in your browser to view the sample application.

### 4. Test Your Changes

```bash
# Build in Release mode to test
dotnet build -c Release

# Publish to test trimming
dotnet publish samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.Client/ -c Release

# Verify trimmed DLL sizes
ls -lh samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.Client/bin/Release/net9.0/publish/wwwroot/_framework/ | grep EasyAppDev
```

## Architecture Overview

This library uses a source generation approach to create fully trimmable Blazor icon components:

### How It Works

1. **Icon Data (`IconData/**/*.cs`)**: SVG content stored as const strings in partial classes
   - Split across multiple files for manageability
   - Excluded from compilation but included as AdditionalFiles
   - Read by source generator at compile-time

2. **Source Generator (`IconSourceGenerator.cs`)**: Compile-time generator that:
   - Reads icon data from IconData files using Roslyn
   - Creates individual sealed ComponentBase classes
   - Embeds SVG content directly in component code
   - Generates ~11,000 components automatically

3. **Generated Components**: Individual sealed classes like:
   ```csharp
   namespace EasyAppDev.Blazor.Icons.Lucide
   {
       public sealed class Activity : ComponentBase { ... }
   }
   ```

4. **Direct Usage**: No services or configuration needed:
   ```razor
   <Activity />
   ```

### Why This Approach Enables Trimming

- **Individual sealed classes** for each icon (not source generated into consumer's assembly)
- **Direct references only** (no reflection, no dictionaries)
- **Embedded SVG content** (no runtime loading)
- **.NET trimmer** removes unused components automatically

## Making Changes

### Adding New Icons

To add new icons or update existing icon sources:

1. **Place SVG files** in the appropriate directory:
   ```bash
   src/BlazorIcons.Generator/icon-sources/lucide/
   src/BlazorIcons.Generator/icon-sources/bootstrap/
   src/BlazorIcons.Generator/icon-sources/materialdesign/
   ```

2. **Run the icon generator script**:
   ```bash
   cd src/BlazorIcons.Generator
   python3 generate-icons.py
   cd ../..
   ```

3. **Rebuild the solution**:
   ```bash
   dotnet build
   ```

The Python script will:
- Read SVG files from `icon-sources/`
- Extract inner SVG content
- Generate `IconData/**/*.cs` files with const strings
- Source generator picks these up during build

### Icon Naming Convention

SVG filenames are converted to PascalCase C# identifiers:
- `home.svg` → `Home`
- `arrow-right.svg` → `ArrowRight`
- `123-icon.svg` → `_123Icon` (prefixed with underscore if starts with number)

### Updating Icon Sources

To update icon sources from upstream libraries:

1. **Update npm packages** (in `src/BlazorIcons.Generator/`):
   ```bash
   cd src/BlazorIcons.Generator
   npm update lucide-static bootstrap-icons @mdi/svg
   cd ../..
   ```

2. **Regenerate icon data**:
   ```bash
   cd src/BlazorIcons.Generator
   python3 generate-icons.py
   cd ../..
   ```

3. **Rebuild and test**:
   ```bash
   dotnet build
   dotnet run --project samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.csproj
   ```

### Modifying the Source Generator

The source generator is located at:
```
src/EasyAppDev.Blazor.Icons.SourceGenerator/IconSourceGenerator.cs
```

When modifying the source generator:

1. Update the generator code
2. Rebuild the solution (source generator runs automatically)
3. Inspect generated components to verify changes
4. Test with sample application
5. Verify trimming still works correctly

## Code Style Guidelines

This project follows standard .NET coding conventions:

### C# Code Style

- **Indentation**: 4 spaces
- **Line endings**: LF (Unix-style)
- **Encoding**: UTF-8
- **Naming conventions**: Follow Microsoft's C# naming guidelines
  - PascalCase for public members, types, namespaces
  - camelCase for private fields (prefixed with underscore)
- **Null handling**: Use nullable reference types (`enable`)
- **File organization**: One class per file (except partial classes)

### Razor Code Style

- **Indentation**: 2 spaces for Razor files
- **@using directives**: At the top of the file
- **Component parameters**: Use PascalCase

### JSON/YAML Code Style

- **Indentation**: 2 spaces
- **Formatting**: Follow standard JSON/YAML conventions

The project includes an `.editorconfig` file that enforces these conventions. Most IDEs will automatically apply these settings.

### Code Quality

- Write clean, readable code with meaningful names
- Add XML documentation comments for public APIs
- Keep methods focused and concise
- Follow SOLID principles where applicable
- Avoid unnecessary complexity

## Submitting Changes

### Pull Request Process

1. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following the code style guidelines

3. **Test your changes thoroughly**:
   - Build the solution without errors
   - Run the sample application
   - Test trimming if applicable
   - Verify icons display correctly

4. **Commit your changes** with clear commit messages:
   ```bash
   git add .
   git commit -m "Add: Brief description of changes"
   ```

   Commit message conventions:
   - `Add:` for new features
   - `Fix:` for bug fixes
   - `Update:` for improvements to existing features
   - `Refactor:` for code refactoring
   - `Docs:` for documentation changes

5. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request** on GitHub:
   - Provide a clear title and description
   - Reference any related issues
   - Complete the PR checklist
   - Ensure all CI checks pass

### Pull Request Guidelines

- Keep PRs focused on a single feature or fix
- Write clear PR descriptions explaining what and why
- Update documentation if needed
- Add tests if applicable
- Be responsive to feedback and review comments
- Keep PRs reasonably sized for easier review

## Reporting Issues

### Bug Reports

When reporting a bug, please include:

- Clear, descriptive title
- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Environment details:
  - .NET version
  - Blazor hosting model (Server, WebAssembly, Hybrid)
  - Browser and version (if applicable)
  - Operating system
- Code samples or screenshots if applicable

Use the **Bug Report** issue template when available.

### Feature Requests

When requesting a feature:

- Describe the feature clearly
- Explain the use case and why it's valuable
- Consider how it fits with the library's goals
- Provide examples or mockups if helpful

Use the **Feature Request** issue template when available.

### Icon Requests

To request specific icons:

- Specify the icon library (Lucide, Bootstrap, Material Design)
- Provide the icon name from the source library
- Include use case or reason for request
- Check if the icon already exists under a different name

Use the **Icon Request** issue template when available.

## Questions?

If you have questions about contributing:

- Check the [README.md](README.md) for project documentation
- Check the [CLAUDE.md](CLAUDE.md) for architecture details
- Open a [GitHub Discussion](https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons/discussions)
- Open an issue with your question

## License

By contributing to EasyAppDev.Blazor.Icons, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing!
