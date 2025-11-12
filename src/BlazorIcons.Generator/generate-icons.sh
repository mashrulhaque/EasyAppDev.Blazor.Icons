#!/bin/bash

# EasyAppDev.Blazor.Icons Generator Script
# This script generates Razor components from SVG files

SOURCE_DIR="${1:-./icon-sources}"
OUTPUT_DIR="${2:-../EasyAppDev.Blazor.Icons/Components/Generated}"

echo -e "\033[1;36mEasyAppDev.Blazor.Icons Generator\033[0m"
echo -e "\033[1;36m===================\033[0m"

# Function to convert filename to valid C# identifier
convert_to_valid_identifier() {
    local name="$1"
    # Remove extension
    name="${name%.svg}"

    # Split by hyphens and capitalize
    IFS='-' read -ra PARTS <<< "$name"
    result=""
    for part in "${PARTS[@]}"; do
        # Capitalize first letter
        result+="$(tr '[:lower:]' '[:upper:]' <<< ${part:0:1})${part:1}"
    done

    # If starts with number, prefix with underscore
    if [[ $result =~ ^[0-9] ]]; then
        result="_$result"
    fi

    echo "$result"
}

# Function to extract SVG content
extract_svg_content() {
    local svg_file="$1"

    # Extract inner content between <svg> tags
    # Remove the opening and closing svg tags, keep only inner content
    sed -n '/<svg/,/<\/svg>/p' "$svg_file" | \
        sed '1d;$d' | \
        sed 's/^[[:space:]]*//'
}

# Function to generate Razor component
generate_razor_component() {
    local component_name="$1"
    local namespace="$2"
    local svg_content="$3"
    local viewbox="$4"
    local fill="$5"
    local stroke="$6"
    local stroke_width="$7"
    local stroke_linecap="$8"
    local stroke_linejoin="$9"
    local output_path="${10}"

    cat > "$output_path" << EOF
@namespace $namespace

<svg @attributes="AdditionalAttributes"
     xmlns="http://www.w3.org/2000/svg"
     viewBox="$viewbox"
     fill="$fill"
EOF

    if [ -n "$stroke" ] && [ "$stroke" != "none" ]; then
        echo "     stroke=\"$stroke\"" >> "$output_path"
    fi

    if [ -n "$stroke_width" ]; then
        echo "     stroke-width=\"$stroke_width\"" >> "$output_path"
    fi

    if [ -n "$stroke_linecap" ]; then
        echo "     stroke-linecap=\"$stroke_linecap\"" >> "$output_path"
    fi

    if [ -n "$stroke_linejoin" ]; then
        echo "     stroke-linejoin=\"$stroke_linejoin\"" >> "$output_path"
    fi

    cat >> "$output_path" << EOF
>
    $svg_content
</svg>

@code {
    [Parameter(CaptureUnmatchedValues = true)]
    public Dictionary<string, object>? AdditionalAttributes { get; set; }
}
EOF
}

# Process Lucide icons
process_icon_set() {
    local icon_set="$1"
    local namespace="$2"
    local viewbox="$3"
    local fill="$4"
    local stroke="$5"
    local stroke_width="$6"
    local stroke_linecap="$7"
    local stroke_linejoin="$8"

    local source_folder="$SOURCE_DIR/$icon_set"
    local output_folder="$OUTPUT_DIR/$(echo $icon_set | sed 's/\b\(.\)/\u\1/g')"

    echo -e "\n\033[1;33mProcessing $icon_set icons...\033[0m"

    if [ ! -d "$source_folder" ]; then
        echo -e "\033[0;33mWarning: Source folder not found: $source_folder (skipping)\033[0m"
        return
    fi

    # Create output directory
    mkdir -p "$output_folder"

    # Count SVG files
    svg_count=$(find "$source_folder" -maxdepth 1 -name "*.svg" -type f | wc -l)

    if [ "$svg_count" -eq 0 ]; then
        echo -e "\033[0;33mWarning: No SVG files found in $source_folder\033[0m"
        return
    fi

    generated=0

    # Process each SVG file
    for svg_file in "$source_folder"/*.svg; do
        if [ -f "$svg_file" ]; then
            filename=$(basename "$svg_file")
            component_name=$(convert_to_valid_identifier "$filename")
            svg_content=$(extract_svg_content "$svg_file")

            if [ -n "$svg_content" ]; then
                output_path="$output_folder/$component_name.razor"
                generate_razor_component \
                    "$component_name" \
                    "$namespace" \
                    "$svg_content" \
                    "$viewbox" \
                    "$fill" \
                    "$stroke" \
                    "$stroke_width" \
                    "$stroke_linecap" \
                    "$stroke_linejoin" \
                    "$output_path"

                ((generated++))
            fi
        fi
    done

    echo -e "\033[1;32mGenerated $generated components for $icon_set\033[0m"
}

# Process each icon set
process_icon_set "lucide" "EasyAppDev.Blazor.Icons.Lucide" "0 0 24 24" "none" "currentColor" "2" "round" "round"
process_icon_set "fontawesome" "EasyAppDev.Blazor.Icons.FontAwesome" "0 0 512 512" "currentColor" "none" "" "" ""
process_icon_set "material-design" "EasyAppDev.Blazor.Icons.MaterialDesign" "0 0 24 24" "currentColor" "none" "" "" ""
process_icon_set "bootstrap" "EasyAppDev.Blazor.Icons.Bootstrap" "0 0 16 16" "currentColor" "none" "" "" ""

echo -e "\n\033[1;36mIcon generation complete!\033[0m"
