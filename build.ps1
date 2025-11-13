# EasyAppDev.Blazor.Icons Build Script
# Unified build script for Windows (PowerShell)

param(
    [switch]$Regenerate,
    [switch]$SkipPrompt,
    [switch]$Help
)

# Exit on error
$ErrorActionPreference = "Stop"

function Write-Header {
    param([string]$Message)
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host $Message -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ $Message" -ForegroundColor Yellow
}

function Write-Info {
    param([string]$Message)
    Write-Host "→ $Message" -ForegroundColor Yellow
}

function Check-Prerequisites {
    Write-Info "Checking prerequisites..."

    # Check .NET SDK
    try {
        $dotnetVersion = dotnet --version
        Write-Success ".NET SDK found: $dotnetVersion"
    }
    catch {
        Write-Error "Error: .NET SDK not found"
        Write-Warning "  Please install .NET 9 SDK from: https://dotnet.microsoft.com/download"
        exit 1
    }

    # Check Python (optional for regeneration)
    try {
        $pythonVersion = python --version
        Write-Success "Python found: $pythonVersion"
    }
    catch {
        Write-Warning "Python not found (only needed for icon regeneration)"
    }

    Write-Host
}

function Regenerate-Icons {
    Write-Info "Regenerating icon data..."

    try {
        $null = python --version
    }
    catch {
        Write-Error "Python is required for icon regeneration"
        exit 1
    }

    Push-Location src/BlazorIcons.Generator

    try {
        # Check if node_modules exists
        if (-not (Test-Path "node_modules")) {
            Write-Host "  Installing npm dependencies..." -ForegroundColor Yellow
            npm install
        }

        # Download icons
        Write-Host "  Downloading icons from NPM packages..." -ForegroundColor Yellow
        npm run download

        # Generate icon data
        Write-Host "  Generating icon data files..." -ForegroundColor Yellow
        python generate-icons.py

        Write-Success "Icon data regenerated"
        Write-Host
    }
    finally {
        Pop-Location
    }
}

function Build-Solution {
    Write-Info "Restoring NuGet packages..."
    dotnet restore
    Write-Success "Packages restored"
    Write-Host

    Write-Info "Building solution..."
    dotnet build --configuration Release --no-restore
    Write-Success "Build completed successfully"
    Write-Host
}

function Show-Usage {
    Write-Host "Usage: .\build.ps1 [OPTIONS]"
    Write-Host
    Write-Host "Options:"
    Write-Host "  -Regenerate     Regenerate icon data before building"
    Write-Host "  -SkipPrompt     Build without prompting for regeneration"
    Write-Host "  -Help           Show this help message"
    Write-Host
    Write-Host "Examples:"
    Write-Host "  .\build.ps1                    # Interactive build (asks about regeneration)"
    Write-Host "  .\build.ps1 -Regenerate        # Regenerate icons and build"
    Write-Host "  .\build.ps1 -SkipPrompt        # Quick build without regeneration"
    exit 0
}

# Main execution
function Main {
    if ($Help) {
        Show-Usage
    }

    Write-Header "EasyAppDev.Blazor.Icons Build Script"

    Check-Prerequisites

    # Ask if user wants to regenerate icons
    if ($Regenerate) {
        Regenerate-Icons
    }
    elseif (-not $SkipPrompt) {
        $response = Read-Host "Do you want to regenerate icon data before building? (y/N)"
        if ($response -eq 'y' -or $response -eq 'Y') {
            Regenerate-Icons
        }
    }

    Build-Solution

    Write-Header "✓ Build completed successfully!"

    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "  • Run sample app:  " -NoNewline -ForegroundColor White
    Write-Host "dotnet run --project samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.csproj" -ForegroundColor Cyan
    Write-Host "  • Create packages: " -NoNewline -ForegroundColor White
    Write-Host "dotnet pack --configuration Release" -ForegroundColor Cyan
    Write-Host "  • Run tests:       " -NoNewline -ForegroundColor White
    Write-Host "dotnet test" -ForegroundColor Cyan
    Write-Host
}

# Run main function
Main
