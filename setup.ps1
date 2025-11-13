# EasyAppDev.Blazor.Icons - Setup Script for Windows
# This script sets up the development environment for new contributors

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "EasyAppDev.Blazor.Icons - Setup Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Node.js is installed
Write-Host "[1/4] Checking Node.js installation..." -ForegroundColor Yellow
try {
    $nodeVersion = node --version
    Write-Host "✓ Node.js is installed: $nodeVersion" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "ERROR: Node.js is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Node.js from: https://nodejs.org/"
    Write-Host ""
    exit 1
}

# Check if Python 3 is installed
Write-Host "[2/4] Checking Python 3 installation..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version
    if ($pythonVersion -notmatch "Python 3") {
        throw "Python 3 not found"
    }
    Write-Host "✓ Python 3 is installed: $pythonVersion" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "ERROR: Python 3 is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Python 3 from: https://www.python.org/downloads/"
    Write-Host ""
    Write-Host "Make sure to check 'Add Python to PATH' during installation."
    Write-Host ""
    exit 1
}

# Check if .NET SDK is installed
Write-Host "[3/4] Checking .NET SDK installation..." -ForegroundColor Yellow
try {
    $dotnetVersion = dotnet --version
    Write-Host "✓ .NET SDK is installed: $dotnetVersion" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "ERROR: .NET SDK is not installed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install .NET 9 SDK from: https://dotnet.microsoft.com/download"
    Write-Host ""
    exit 1
}

# Navigate to generator directory and install npm packages
Write-Host "[4/4] Setting up icon generation environment..." -ForegroundColor Yellow
Write-Host ""

Push-Location src\BlazorIcons.Generator

Write-Host "Installing NPM packages..." -ForegroundColor Blue
npm install

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: npm install failed!" -ForegroundColor Red
    Pop-Location
    exit 1
}

Write-Host ""
Write-Host "Downloading icon sources..." -ForegroundColor Blue
node download-icons.js

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Icon download failed!" -ForegroundColor Red
    Pop-Location
    exit 1
}

Write-Host ""
Pop-Location

Write-Host "Building solution..." -ForegroundColor Blue
dotnet build

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Build failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please check the error messages above and try again."
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "You're all set! Here's what was done:"
Write-Host "  ✓ Verified Node.js, Python 3, and .NET SDK"
Write-Host "  ✓ Installed NPM dependencies"
Write-Host "  ✓ Downloaded ~11,000 icon sources"
Write-Host "  ✓ Built the solution successfully"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  - Run the sample app: cd samples\EasyAppDev.Blazor.Icons.Sample\EasyAppDev.Blazor.Icons.Sample; dotnet run"
Write-Host "  - Generate icons: cd src\BlazorIcons.Generator; python generate-components.py"
Write-Host "  - Read the docs: type README.md"
Write-Host ""
