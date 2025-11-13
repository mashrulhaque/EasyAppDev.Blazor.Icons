#!/usr/bin/env python3
"""
EasyAppDev.Blazor.Icons - Icon Data Generator

This script generates IconData/*.cs files containing icon SVG content as const strings.
These files are read by the C# source generator at compile-time to generate individual
ComponentBase classes for each icon.

The generated components are fully embedded and trimmable - only icons you use are
included in published output.
"""

import os
import re
import sys
from pathlib import Path
from typing import Dict, List, Optional, Tuple

# Define icon sets with their configurations
ICON_SETS = {
    "lucide": {
        "namespace": "EasyAppDev.Blazor.Icons.Lucide",
        "class_name": "LucideIcons",
        "viewbox": "0 0 24 24",
        "fill": "none",
        "stroke": "currentColor",
        "stroke_width": "2",
        "stroke_linecap": "round",
        "stroke_linejoin": "round"
    },
    "bootstrap": {
        "namespace": "EasyAppDev.Blazor.Icons.Bootstrap",
        "class_name": "BootstrapIcons",
        "viewbox": "0 0 16 16",
        "fill": "currentColor",
        "stroke": None
    },
    "material-design": {
        "namespace": "EasyAppDev.Blazor.Icons.MaterialDesign",
        "class_name": "MaterialDesignIcons",
        "viewbox": "0 0 24 24",
        "fill": "currentColor",
        "stroke": None
    }
}

# Template for class header
CLASS_HEADER_TEMPLATE = """namespace {namespace};

/// <summary>
/// Static icon data for {class_name}
/// </summary>
public static class {class_name}
{{
    public const string ViewBox = "{viewbox}";
    public const string Fill = "{fill}";
{optional_attributes}
    /// <summary>
    /// Icon SVG path data
    /// </summary>
    public static class Icons
    {{
"""

# Template for class footer
CLASS_FOOTER_TEMPLATE = """    }
}
"""


def check_python_version():
    """Ensure Python 3.7+ is being used"""
    if sys.version_info < (3, 7):
        print("ERROR: Python 3.7 or higher is required")
        print(f"Current version: {sys.version}")
        sys.exit(1)


def validate_icon_name(name: str) -> Optional[str]:
    """
    Validate icon name

    Returns error message if invalid, None if valid
    """
    if not name:
        return "Icon name is empty"

    if len(name) > 100:
        return f"Icon name too long: {name}"

    # Check for invalid characters
    if not re.match(r'^[a-zA-Z0-9_-]+$', name):
        return f"Icon name contains invalid characters: {name}"

    return None


def convert_to_valid_identifier(name: str) -> str:
    """Convert filename to valid C# identifier"""
    name = Path(name).stem
    parts = name.split('-')
    result = ''.join(part.capitalize() for part in parts)
    if result and result[0].isdigit():
        result = f"_{result}"
    return result


def extract_svg_content(svg_path: Path) -> Optional[str]:
    """Extract inner SVG content from SVG file"""
    try:
        if not svg_path.exists():
            print(f"ERROR: SVG file not found: {svg_path}")
            return None

        with open(svg_path, 'r', encoding='utf-8') as f:
            content = f.read()

        if not content.strip():
            print(f"WARNING: Empty SVG file: {svg_path}")
            return None

        pattern = r'<svg[^>]*>(.*?)</svg>'
        match = re.search(pattern, content, re.DOTALL)

        if match:
            inner_content = match.group(1).strip()
            # Escape quotes for C# string
            inner_content = inner_content.replace('"', '\\"')
            # Clean up whitespace
            inner_content = re.sub(r'\s+', ' ', inner_content)
            return inner_content.strip()
        else:
            print(f"WARNING: No SVG content found in {svg_path}")
            return None
    except UnicodeDecodeError as e:
        print(f"ERROR: Failed to decode {svg_path}: {e}")
        return None
    except Exception as e:
        print(f"ERROR: Failed to parse {svg_path}: {e}")
        return None


def generate_optional_attributes(config: Dict[str, Optional[str]]) -> str:
    """Generate optional attribute declarations"""
    lines = []

    if config.get('stroke'):
        lines.append(f'    public const string Stroke = "{config["stroke"]}";')

    if config.get('stroke_width'):
        lines.append(f'    public const string StrokeWidth = "{config["stroke_width"]}";')

    if config.get('stroke_linecap'):
        lines.append(f'    public const string StrokeLinecap = "{config["stroke_linecap"]}";')

    if config.get('stroke_linejoin'):
        lines.append(f'    public const string StrokeLinejoin = "{config["stroke_linejoin"]}";')

    return '\n'.join(lines)


def validate_generated_code(code: str) -> Optional[str]:
    """
    Basic validation of generated C# code

    Returns error message if invalid, None if valid
    """
    # Check for basic C# syntax elements
    if 'namespace' not in code:
        return "Missing namespace declaration"

    if 'class' not in code:
        return "Missing class declaration"

    # Check for balanced braces
    if code.count('{') != code.count('}'):
        return "Unbalanced braces in generated code"

    return None


def generate_icon_class(
    icon_set: str,
    config: Dict[str, Optional[str]],
    source_dir: Path,
    output_dir: Path
) -> Tuple[int, int]:
    """
    Generate a static class with all icons

    Returns tuple of (processed_count, error_count)
    """
    source_folder = source_dir / icon_set
    output_file = output_dir / f"{config['class_name']}.cs"

    print(f"\nProcessing {icon_set} icons...")

    # Validate directories
    if not source_folder.exists():
        print(f"ERROR: Source folder not found: {source_folder}")
        return 0, 1

    # Get all SVG files
    svg_files = sorted(source_folder.glob("*.svg"))

    if not svg_files:
        print(f"WARNING: No SVG files found in {source_folder}")
        return 0, 0

    total_files = len(svg_files)
    print(f"Found {total_files} SVG files")

    # Build the class using template
    lines = []

    # Add header
    optional_attrs = generate_optional_attributes(config)
    header = CLASS_HEADER_TEMPLATE.format(
        namespace=config['namespace'],
        class_name=config['class_name'],
        viewbox=config['viewbox'],
        fill=config['fill'],
        optional_attributes=optional_attrs + '\n' if optional_attrs else ''
    )
    lines.append(header)

    # Add each icon as a const string
    processed = 0
    errors = 0
    seen_names = set()

    for idx, svg_file in enumerate(svg_files, 1):
        # Show progress for large sets
        if total_files > 100 and idx % 100 == 0:
            print(f"  Progress: {idx}/{total_files} ({idx*100//total_files}%)")

        # Validate icon name
        validation_error = validate_icon_name(svg_file.stem)
        if validation_error:
            print(f"ERROR: {validation_error}")
            errors += 1
            continue

        icon_name = convert_to_valid_identifier(svg_file.name)

        # Check for duplicate names
        if icon_name in seen_names:
            print(f"ERROR: Duplicate icon name: {icon_name}")
            errors += 1
            continue
        seen_names.add(icon_name)

        # Extract SVG content
        svg_content = extract_svg_content(svg_file)

        if svg_content:
            lines.append(f'        public const string {icon_name} = "{svg_content}";')
            processed += 1
        else:
            errors += 1

    # Add footer
    lines.append(CLASS_FOOTER_TEMPLATE)

    # Combine all lines
    code = '\n'.join(lines)

    # Validate generated code
    validation_error = validate_generated_code(code)
    if validation_error:
        print(f"ERROR: Invalid generated code: {validation_error}")
        return 0, errors + 1

    # Write to file
    try:
        output_dir.mkdir(parents=True, exist_ok=True)
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(code)
    except Exception as e:
        print(f"ERROR: Failed to write output file {output_file}: {e}")
        return 0, errors + 1

    print(f"Generated {processed} icon constants in {output_file.name}")
    if errors > 0:
        print(f"WARNING: {errors} errors occurred during generation")

    return processed, errors


def main():
    """Main entry point"""
    print("\033[1;36m" + "="*60 + "\033[0m")
    print("\033[1;36mEasyAppDev.Blazor.Icons - Icon Data Generator\033[0m")
    print("\033[1;36m" + "="*60 + "\033[0m\n")

    # Check Python version
    check_python_version()

    # Define paths
    source_dir = Path("./icon-sources")
    output_dir = Path("../EasyAppDev.Blazor.Icons/IconData")

    # Validate source directory exists
    if not source_dir.exists():
        print(f"\033[1;31mERROR: Source directory not found: {source_dir.absolute()}\033[0m")
        print("Please ensure you're running this script from the correct directory.")
        sys.exit(1)

    # Generate icon data for each icon set
    total_processed = 0
    total_errors = 0

    for icon_set, config in ICON_SETS.items():
        try:
            processed, errors = generate_icon_class(icon_set, config, source_dir, output_dir)
            total_processed += processed
            total_errors += errors
        except Exception as e:
            print(f"\033[1;31mERROR: Failed to process {icon_set}: {e}\033[0m")
            total_errors += 1

    # Summary
    print("\n" + "\033[1;36m" + "="*60 + "\033[0m")
    if total_processed > 0:
        print(f"\033[1;32m✓ Successfully generated {total_processed} total icon constants\033[0m")
    else:
        print(f"\033[1;31m✗ No icon constants were generated\033[0m")

    if total_errors > 0:
        print(f"\033[1;31m✗ {total_errors} error(s) occurred during generation\033[0m")

    print("\033[1;36m" + "="*60 + "\033[0m")

    if total_processed > 0:
        print("\n\033[1;36mNext step:\033[0m Build the project to trigger source generation")
        print("  Command: dotnet build")

    sys.exit(0 if total_errors == 0 else 1)


if __name__ == "__main__":
    main()
