#!/bin/bash

# EasyAppDev.Blazor.Icons - Setup Script for Unix/macOS
# This script sets up the development environment for new contributors

set -e  # Exit on error

echo ""
echo "========================================"
echo "EasyAppDev.Blazor.Icons - Setup Script"
echo "========================================"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Node.js is installed
echo -e "${YELLOW}[1/4]${NC} Checking Node.js installation..."
if ! command -v node &> /dev/null; then
    echo -e "${RED}ERROR: Node.js is not installed!${NC}"
    echo ""
    echo "Please install Node.js from: https://nodejs.org/"
    echo ""
    echo "On macOS, you can use Homebrew:"
    echo "  brew install node"
    echo ""
    exit 1
fi

NODE_VERSION=$(node --version)
echo -e "${GREEN}✓${NC} Node.js is installed: ${NODE_VERSION}"
echo ""

# Check if Python 3 is installed
echo -e "${YELLOW}[2/4]${NC} Checking Python 3 installation..."
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}ERROR: Python 3 is not installed!${NC}"
    echo ""
    echo "Please install Python 3 from: https://www.python.org/downloads/"
    echo ""
    echo "On macOS, you can use Homebrew:"
    echo "  brew install python3"
    echo ""
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
echo -e "${GREEN}✓${NC} Python 3 is installed: ${PYTHON_VERSION}"
echo ""

# Check if .NET SDK is installed
echo -e "${YELLOW}[3/4]${NC} Checking .NET SDK installation..."
if ! command -v dotnet &> /dev/null; then
    echo -e "${RED}ERROR: .NET SDK is not installed!${NC}"
    echo ""
    echo "Please install .NET 9 SDK from: https://dotnet.microsoft.com/download"
    echo ""
    exit 1
fi

DOTNET_VERSION=$(dotnet --version)
echo -e "${GREEN}✓${NC} .NET SDK is installed: ${DOTNET_VERSION}"
echo ""

# Navigate to generator directory and install npm packages
echo -e "${YELLOW}[4/4]${NC} Setting up icon generation environment..."
echo ""

cd src/BlazorIcons.Generator

echo -e "${BLUE}Installing NPM packages...${NC}"
npm install

if [ $? -ne 0 ]; then
    echo -e "${RED}ERROR: npm install failed!${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}Downloading icon sources...${NC}"
node download-icons.js

if [ $? -ne 0 ]; then
    echo -e "${RED}ERROR: Icon download failed!${NC}"
    exit 1
fi

echo ""
cd ../..

echo -e "${BLUE}Building solution...${NC}"
dotnet build

if [ $? -ne 0 ]; then
    echo -e "${RED}ERROR: Build failed!${NC}"
    echo ""
    echo "Please check the error messages above and try again."
    exit 1
fi

echo ""
echo -e "${GREEN}========================================"
echo "✓ Setup Complete!"
echo "========================================${NC}"
echo ""
echo "You're all set! Here's what was done:"
echo "  ✓ Verified Node.js, Python 3, and .NET SDK"
echo "  ✓ Installed NPM dependencies"
echo "  ✓ Downloaded ~11,000 icon sources"
echo "  ✓ Built the solution successfully"
echo ""
echo "Next steps:"
echo "  - Run the sample app: cd samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample && dotnet run"
echo "  - Generate icons: cd src/BlazorIcons.Generator && python3 generate-components.py"
echo "  - Read the docs: cat README.md"
echo ""
