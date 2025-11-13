#!/bin/bash
# EasyAppDev.Blazor.Icons Build Script
# Unified build script for Unix-based systems (macOS, Linux)

set -e  # Exit on error

echo -e "\033[1;36m========================================\033[0m"
echo -e "\033[1;36mEasyAppDev.Blazor.Icons Build Script\033[0m"
echo -e "\033[1;36m========================================\033[0m"
echo

# Function to check prerequisites
check_prerequisites() {
    echo -e "\033[1;33m→ Checking prerequisites...\033[0m"

    # Check .NET SDK
    if ! command -v dotnet &> /dev/null; then
        echo -e "\033[1;31m✗ Error: .NET SDK not found\033[0m"
        echo -e "\033[0;33m  Please install .NET 9 SDK from: https://dotnet.microsoft.com/download\033[0m"
        exit 1
    fi

    DOTNET_VERSION=$(dotnet --version)
    echo -e "\033[1;32m✓ .NET SDK found: $DOTNET_VERSION\033[0m"

    # Check Python (optional for regeneration)
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version)
        echo -e "\033[1;32m✓ Python found: $PYTHON_VERSION\033[0m"
    else
        echo -e "\033[0;33m⚠ Python 3 not found (only needed for icon regeneration)\033[0m"
    fi

    echo
}

# Function to regenerate icon components
regenerate_icons() {
    echo -e "\033[1;33m→ Regenerating icon data...\033[0m"

    if ! command -v python3 &> /dev/null; then
        echo -e "\033[1;31m✗ Python 3 is required for icon regeneration\033[0m"
        exit 1
    fi

    cd src/BlazorIcons.Generator

    # Check if node_modules exists
    if [ ! -d "node_modules" ]; then
        echo -e "\033[0;33m  Installing npm dependencies...\033[0m"
        npm install
    fi

    # Download icons
    echo -e "\033[0;33m  Downloading icons from NPM packages...\033[0m"
    npm run download

    # Generate icon data
    echo -e "\033[0;33m  Generating icon data files...\033[0m"
    python3 generate-icons.py

    cd ../..
    echo -e "\033[1;32m✓ Icon data regenerated\033[0m"
    echo
}

# Function to build the solution
build_solution() {
    echo -e "\033[1;33m→ Restoring NuGet packages...\033[0m"
    dotnet restore
    echo -e "\033[1;32m✓ Packages restored\033[0m"
    echo

    echo -e "\033[1;33m→ Building solution...\033[0m"
    dotnet build --configuration Release --no-restore
    echo -e "\033[1;32m✓ Build completed successfully\033[0m"
    echo
}

# Main execution
main() {
    check_prerequisites

    # Ask if user wants to regenerate icons
    if [ "$1" == "--regenerate" ] || [ "$1" == "-r" ]; then
        regenerate_icons
    elif [ "$1" != "--skip-prompt" ]; then
        read -p "Do you want to regenerate icon data before building? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            regenerate_icons
        fi
    fi

    build_solution

    echo -e "\033[1;36m========================================\033[0m"
    echo -e "\033[1;32m✓ Build completed successfully!\033[0m"
    echo -e "\033[1;36m========================================\033[0m"
    echo
    echo -e "\033[0;33mNext steps:\033[0m"
    echo -e "  • Run sample app:  \033[1mdotnet run --project samples/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample/EasyAppDev.Blazor.Icons.Sample.csproj\033[0m"
    echo -e "  • Create packages: \033[1mdotnet pack --configuration Release\033[0m"
    echo -e "  • Run tests:       \033[1mdotnet test\033[0m"
    echo
}

# Show usage if --help
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: ./build.sh [OPTIONS]"
    echo
    echo "Options:"
    echo "  -r, --regenerate    Regenerate icon data before building"
    echo "  --skip-prompt       Build without prompting for regeneration"
    echo "  -h, --help          Show this help message"
    echo
    echo "Examples:"
    echo "  ./build.sh                    # Interactive build (asks about regeneration)"
    echo "  ./build.sh --regenerate       # Regenerate icons and build"
    echo "  ./build.sh --skip-prompt      # Quick build without regeneration"
    exit 0
fi

main "$@"
