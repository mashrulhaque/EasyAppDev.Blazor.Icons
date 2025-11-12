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
from pathlib import Path

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

def convert_to_valid_identifier(name):
    """Convert filename to valid C# identifier"""
    name = Path(name).stem
    parts = name.split('-')
    result = ''.join(part.capitalize() for part in parts)
    if result[0].isdigit():
        result = f"_{result}"
    return result

def extract_svg_content(svg_path):
    """Extract inner SVG content"""
    try:
        with open(svg_path, 'r', encoding='utf-8') as f:
            content = f.read()

        pattern = r'<svg[^>]*>(.*?)</svg>'
        match = re.search(pattern, content, re.DOTALL)

        if match:
            inner_content = match.group(1).strip()
            # Escape quotes for C# string
            inner_content = inner_content.replace('"', '\\"')
            # Clean up whitespace
            inner_content = re.sub(r'\s+', ' ', inner_content)
            return inner_content.strip()
        return None
    except Exception as e:
        print(f"Warning: Failed to parse {svg_path}: {e}")
        return None

def generate_icon_class(icon_set, config, source_dir, output_dir):
    """Generate a static class with all icons"""
    source_folder = source_dir / icon_set
    output_file = output_dir / f"{config['class_name']}.cs"

    print(f"\nProcessing {icon_set} icons...")

    if not source_folder.exists():
        print(f"Warning: Source folder not found: {source_folder} (skipping)")
        return

    # Get all SVG files
    svg_files = sorted(source_folder.glob("*.svg"))

    if not svg_files:
        print(f"Warning: No SVG files found in {source_folder}")
        return

    # Start building the class
    lines = [
        f"namespace {config['namespace']};",
        "",
        "/// <summary>",
        f"/// Static icon data for {config['class_name']}",
        "/// </summary>",
        f"public static class {config['class_name']}",
        "{",
        f"    public const string ViewBox = \"{config['viewbox']}\";",
        f"    public const string Fill = \"{config['fill']}\";",
    ]

    if config.get('stroke'):
        lines.append(f"    public const string Stroke = \"{config['stroke']}\";")
    if config.get('stroke_width'):
        lines.append(f"    public const string StrokeWidth = \"{config['stroke_width']}\";")
    if config.get('stroke_linecap'):
        lines.append(f"    public const string StrokeLinecap = \"{config['stroke_linecap']}\";")
    if config.get('stroke_linejoin'):
        lines.append(f"    public const string StrokeLinejoin = \"{config['stroke_linejoin']}\";")

    lines.append("")
    lines.append("    /// <summary>")
    lines.append("    /// Icon SVG path data")
    lines.append("    /// </summary>")
    lines.append("    public static class Icons")
    lines.append("    {")

    # Add each icon as a const string
    processed = 0
    for svg_file in svg_files:
        icon_name = convert_to_valid_identifier(svg_file.name)
        svg_content = extract_svg_content(svg_file)

        if svg_content:
            lines.append(f"        public const string {icon_name} = \"{svg_content}\";")
            processed += 1

    lines.append("    }")
    lines.append("}")
    lines.append("")

    # Write to file
    output_dir.mkdir(parents=True, exist_ok=True)
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))

    print(f"Generated {processed} icon constants in {output_file.name}")
    return processed

def main():
    """Main entry point"""
    print("\033[1;36mEasyAppDev.Blazor.Icons - Icon Data Generator\033[0m")
    print("\033[1;36m===============================================\033[0m")

    source_dir = Path("./icon-sources")
    output_dir = Path("../EasyAppDev.Blazor.Icons/IconData")

    total = 0
    for icon_set, config in ICON_SETS.items():
        count = generate_icon_class(icon_set, config, source_dir, output_dir)
        if count:
            total += count

    print(f"\n\033[1;32mGenerated {total} total icon constants\033[0m")
    print("\033[1;36m\nNext: Build the project - source generator will create components\033[0m")

if __name__ == "__main__":
    main()
