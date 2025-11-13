# Changelog

All notable changes to EasyAppDev.Blazor.Icons will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2025-11-12

### Added
- Package icons for NuGet visibility (Lucide, Bootstrap, and Material Design packages)
- NuGet badges and version information in README.md

### Changed
- Updated all packages to version 1.0.2 for consistency
- Enhanced README.md with package version table and NuGet links

### Fixed
- Package metadata consistency across all icon libraries

## [1.0.1] - 2025-11-12

### Changed
- Updated package metadata with proper descriptions and repository URLs
- Improved documentation structure and clarity
- Enhanced project configuration for better NuGet package presentation

### Removed
- Removed PACKAGE_USAGE.md (consolidated into README.md)

## [1.0.0] - 2025-11-12

### Added
- Initial release of EasyAppDev.Blazor.Icons
- Three separate icon library packages:
  - `EasyAppDev.Blazor.Icons.Lucide` - 1,539 Lucide icons
  - `EasyAppDev.Blazor.Icons.Bootstrap` - 2,078 Bootstrap icons
  - `EasyAppDev.Blazor.Icons.MaterialDesign` - 7,447 Material Design icons
- Python-generated physical component files architecture
- Full trimming support for optimal bundle sizes
- Individual sealed ComponentBase classes for each icon
- Embedded SVG content with no runtime dependencies
- Accessibility support with AriaLabel parameter
- CSS controllable styling
- Sample Blazor application demonstrating usage
- Comprehensive documentation

### Features
- True trimming: Only referenced icons included in published output
- Zero runtime overhead: No reflection, no HTTP calls, no dictionaries
- Type-safe with full IntelliSense support
- Separate packages for granular dependency management
- Fast incremental builds
- Support for all Blazor hosting models (Server, WebAssembly, Hybrid)

[1.0.2]: https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/mashrulhaque/EasyAppDev.Blazor.Icons/releases/tag/v1.0.0
