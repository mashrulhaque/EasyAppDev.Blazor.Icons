#!/usr/bin/env node

/**
 * BlazorIcons - Icon Source Downloader
 *
 * This script downloads icon SVG files from NPM packages and prepares them
 * for component generation.
 *
 * USAGE:
 *   node download-icons.js
 *
 * PREREQUISITES:
 *   - Node.js installed
 *   - Run 'npm install' first to install dependencies
 *
 * WHAT IT DOES:
 *   1. Creates icon-sources/ directory structure
 *   2. Downloads Lucide icons from lucide-static package
 *   3. Downloads Bootstrap icons from bootstrap-icons package
 *   4. Downloads Material Design icons from @mdi/svg package
 *   5. Copies SVG files to icon-sources/{library}/ folders
 *
 * AFTER RUNNING:
 *   Run 'python3 generate-components.py' to generate Blazor components
 *
 * NOTE:
 *   Icon source files are NOT committed to git (see .gitignore).
 *   New contributors must run this script first to download icon sources.
 */

const fs = require('fs');
const path = require('path');

console.log('\x1b[36m%s\x1b[0m', 'BlazorIcons - Downloading Icons from NPM Packages');
console.log('\x1b[36m%s\x1b[0m', '=================================================\n');

// Check if node_modules exists
const nodeModulesPath = path.join(__dirname, 'node_modules');
if (!fs.existsSync(nodeModulesPath)) {
    console.log('\x1b[31m%s\x1b[0m', '\nERROR: node_modules not found!');
    console.log('\x1b[33m%s\x1b[0m', '\nPlease run: npm install');
    console.log('\x1b[33m%s\x1b[0m', 'This will install the required icon packages.\n');
    process.exit(1);
}

// Create output directories
const iconSourcesDir = path.join(__dirname, 'icon-sources');
const dirs = ['lucide', 'bootstrap', 'material-design', 'fontawesome'];

console.log('\x1b[33m%s\x1b[0m', 'Creating output directories...');
dirs.forEach(dir => {
    const fullPath = path.join(iconSourcesDir, dir);
    if (!fs.existsSync(fullPath)) {
        fs.mkdirSync(fullPath, { recursive: true });
        console.log('\x1b[32m%s\x1b[0m', `  ✓ Created ${dir}/`);
    } else {
        console.log('\x1b[90m%s\x1b[0m', `  - ${dir}/ already exists`);
    }
});
console.log();

// Copy Lucide icons
console.log('\x1b[33m%s\x1b[0m', 'Copying Lucide icons...');
try {
    const lucidePath = path.join(__dirname, 'node_modules', 'lucide-static', 'icons');
    const lucideOutput = path.join(iconSourcesDir, 'lucide');

    if (fs.existsSync(lucidePath)) {
        const files = fs.readdirSync(lucidePath).filter(f => f.endsWith('.svg'));

        // Clear existing files
        const existingFiles = fs.readdirSync(lucideOutput).filter(f => f.endsWith('.svg'));
        existingFiles.forEach(f => fs.unlinkSync(path.join(lucideOutput, f)));

        // Copy new files
        files.forEach(file => {
            fs.copyFileSync(
                path.join(lucidePath, file),
                path.join(lucideOutput, file)
            );
        });

        console.log('\x1b[32m%s\x1b[0m', `  ✓ Copied ${files.length} Lucide icons`);
    } else {
        console.log('\x1b[31m%s\x1b[0m', '  ✗ Lucide icons not found in node_modules');
    }
} catch (error) {
    console.error('\x1b[31m%s\x1b[0m', `  ✗ Error copying Lucide icons: ${error.message}`);
}

// Copy Bootstrap icons
console.log('\x1b[33m%s\x1b[0m', '\nCopying Bootstrap icons...');
try {
    const bootstrapPath = path.join(__dirname, 'node_modules', 'bootstrap-icons', 'icons');
    const bootstrapOutput = path.join(iconSourcesDir, 'bootstrap');

    if (fs.existsSync(bootstrapPath)) {
        const files = fs.readdirSync(bootstrapPath).filter(f => f.endsWith('.svg'));

        // Clear existing files
        const existingFiles = fs.readdirSync(bootstrapOutput).filter(f => f.endsWith('.svg'));
        existingFiles.forEach(f => fs.unlinkSync(path.join(bootstrapOutput, f)));

        // Copy new files
        files.forEach(file => {
            fs.copyFileSync(
                path.join(bootstrapPath, file),
                path.join(bootstrapOutput, file)
            );
        });

        console.log('\x1b[32m%s\x1b[0m', `  ✓ Copied ${files.length} Bootstrap icons`);
    } else {
        console.log('\x1b[31m%s\x1b[0m', '  ✗ Bootstrap icons not found in node_modules');
    }
} catch (error) {
    console.error('\x1b[31m%s\x1b[0m', `  ✗ Error copying Bootstrap icons: ${error.message}`);
}

// Copy Material Design icons
console.log('\x1b[33m%s\x1b[0m', '\nCopying Material Design icons...');
try {
    const mdiPath = path.join(__dirname, 'node_modules', '@mdi', 'svg', 'svg');
    const mdiOutput = path.join(iconSourcesDir, 'material-design');

    if (fs.existsSync(mdiPath)) {
        const files = fs.readdirSync(mdiPath).filter(f => f.endsWith('.svg'));

        // Clear existing files
        const existingFiles = fs.readdirSync(mdiOutput).filter(f => f.endsWith('.svg'));
        existingFiles.forEach(f => fs.unlinkSync(path.join(mdiOutput, f)));

        // Copy new files
        files.forEach(file => {
            fs.copyFileSync(
                path.join(mdiPath, file),
                path.join(mdiOutput, file)
            );
        });

        console.log('\x1b[32m%s\x1b[0m', `  ✓ Copied ${files.length} Material Design icons`);
    } else {
        console.log('\x1b[31m%s\x1b[0m', '  ✗ Material Design icons not found in node_modules');
    }
} catch (error) {
    console.error('\x1b[31m%s\x1b[0m', `  ✗ Error copying Material Design icons: ${error.message}`);
}

// FontAwesome note
console.log('\x1b[33m%s\x1b[0m', '\nFontAwesome icons:');
console.log('\x1b[33m%s\x1b[0m', '  Note: FontAwesome Free requires manual download from their website');
console.log('\x1b[33m%s\x1b[0m', '  or use @fortawesome/fontawesome-free package (instructions in README)');

console.log('\n\x1b[36m%s\x1b[0m', 'Icon download complete!');
console.log('\x1b[36m%s\x1b[0m', '\nNext step: Run the generator script');
console.log('  python3 generate-icons.py');
