# EasyAppDev.Blazor.Icons Generator Script
# This script generates Razor components from SVG files

param(
    [string]$SourceDir = "./icon-sources",
    [string]$OutputDir = "../EasyAppDev.Blazor.Icons/Components/Generated"
)

Write-Host "EasyAppDev.Blazor.Icons Generator" -ForegroundColor Cyan
Write-Host "===================" -ForegroundColor Cyan

# Define icon sets with their configurations
$iconSets = @{
    "lucide" = @{
        Namespace = "EasyAppDev.Blazor.Icons.Lucide"
        ViewBox = "0 0 24 24"
        Fill = "none"
        Stroke = "currentColor"
        StrokeWidth = "2"
        StrokeLinecap = "round"
        StrokeLinejoin = "round"
    }
    "fontawesome" = @{
        Namespace = "EasyAppDev.Blazor.Icons.FontAwesome"
        ViewBox = "0 0 512 512"
        Fill = "currentColor"
        Stroke = "none"
    }
    "material-design" = @{
        Namespace = "EasyAppDev.Blazor.Icons.MaterialDesign"
        ViewBox = "0 0 24 24"
        Fill = "currentColor"
        Stroke = "none"
    }
    "bootstrap" = @{
        Namespace = "EasyAppDev.Blazor.Icons.Bootstrap"
        ViewBox = "0 0 16 16"
        Fill = "currentColor"
        Stroke = "none"
    }
}

function Convert-ToValidIdentifier {
    param([string]$name)

    # Remove extension
    $name = [System.IO.Path]::GetFileNameWithoutExtension($name)

    # Capitalize first letter of each word and remove hyphens
    $name = $name -split '-' | ForEach-Object {
        $_.Substring(0,1).ToUpper() + $_.Substring(1).ToLower()
    }
    $name = $name -join ''

    # If starts with number, prefix with underscore
    if ($name -match '^\d') {
        $name = "_$name"
    }

    return $name
}

function Extract-SvgContent {
    param(
        [string]$svgPath
    )

    try {
        [xml]$svg = Get-Content $svgPath -Raw
        $svgElement = $svg.svg

        # Extract inner content (everything except the outer svg tag)
        $innerContent = $svgElement.InnerXml

        # Clean up the content
        $innerContent = $innerContent.Trim()

        return $innerContent
    }
    catch {
        Write-Warning "Failed to parse $svgPath : $_"
        return $null
    }
}

function Generate-RazorComponent {
    param(
        [string]$componentName,
        [string]$namespace,
        [string]$svgContent,
        [hashtable]$config,
        [string]$outputPath
    )

    $template = @"
@namespace $namespace

<svg @attributes="AdditionalAttributes"
     xmlns="http://www.w3.org/2000/svg"
     viewBox="$($config.ViewBox)"
     fill="$($config.Fill)"
"@

    if ($config.Stroke) {
        $template += @"

     stroke="$($config.Stroke)"
"@
    }

    if ($config.StrokeWidth) {
        $template += @"

     stroke-width="$($config.StrokeWidth)"
"@
    }

    if ($config.StrokeLinecap) {
        $template += @"

     stroke-linecap="$($config.StrokeLinecap)"
"@
    }

    if ($config.StrokeLinejoin) {
        $template += @"

     stroke-linejoin="$($config.StrokeLinejoin)"
"@
    }

    $template += @"
>
    $svgContent
</svg>

@code {
    [Parameter(CaptureUnmatchedValues = true)]
    public Dictionary<string, object>? AdditionalAttributes { get; set; }
}
"@

    Set-Content -Path $outputPath -Value $template -Encoding UTF8
}

# Process each icon set
foreach ($iconSet in $iconSets.Keys) {
    $sourceFolder = Join-Path $SourceDir $iconSet
    $outputFolder = Join-Path $OutputDir (Get-Culture).TextInfo.ToTitleCase($iconSet)
    $config = $iconSets[$iconSet]

    Write-Host "`nProcessing $iconSet icons..." -ForegroundColor Yellow

    if (-not (Test-Path $sourceFolder)) {
        Write-Warning "Source folder not found: $sourceFolder (skipping)"
        continue
    }

    # Create output directory
    if (-not (Test-Path $outputFolder)) {
        New-Item -ItemType Directory -Path $outputFolder -Force | Out-Null
    }

    # Get all SVG files
    $svgFiles = Get-ChildItem -Path $sourceFolder -Filter "*.svg" -File

    if ($svgFiles.Count -eq 0) {
        Write-Warning "No SVG files found in $sourceFolder"
        continue
    }

    $generated = 0
    foreach ($svgFile in $svgFiles) {
        $componentName = Convert-ToValidIdentifier $svgFile.Name
        $svgContent = Extract-SvgContent $svgFile.FullName

        if ($null -ne $svgContent) {
            $outputPath = Join-Path $outputFolder "$componentName.razor"
            Generate-RazorComponent `
                -componentName $componentName `
                -namespace $config.Namespace `
                -svgContent $svgContent `
                -config $config `
                -outputPath $outputPath

            $generated++
        }
    }

    Write-Host "Generated $generated components for $iconSet" -ForegroundColor Green
}

Write-Host "`nIcon generation complete!" -ForegroundColor Cyan
