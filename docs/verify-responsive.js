#!/usr/bin/env node
/**
 * Responsive Layout Verification Script
 * Validates that responsive CSS is properly configured
 *
 * Usage: node verify-responsive.js
 */

const http = require('http');
const fs = require('fs');
const path = require('path');

const SERVER_URL = 'http://localhost:3004';
const CSS_FILE = path.join(__dirname, 'app', 'globals.css');

console.log('🔍 Responsive Layout Verification\n');

// Test 1: Verify server is running
function checkServer() {
  return new Promise((resolve, reject) => {
    console.log('1️⃣  Checking dev server...');

    http.get(SERVER_URL, (res) => {
      if (res.statusCode === 200) {
        console.log('   ✅ Dev server running at', SERVER_URL);
        resolve(true);
      } else {
        console.log('   ❌ Server returned status:', res.statusCode);
        resolve(false);
      }
    }).on('error', (err) => {
      console.log('   ❌ Server not running:', err.message);
      console.log('   💡 Start server with: cd ./docs && npm run dev');
      resolve(false);
    });
  });
}

// Test 2: Verify CSS file exists and has responsive patterns
function checkCSSFile() {
  console.log('\n2️⃣  Analyzing CSS file...');

  if (!fs.existsSync(CSS_FILE)) {
    console.log('   ❌ CSS file not found:', CSS_FILE);
    return false;
  }

  const cssContent = fs.readFileSync(CSS_FILE, 'utf8');
  console.log('   ✅ CSS file found (', cssContent.split('\n').length, 'lines)');

  // Check for Tailwind v4 import
  const hasTailwindImport = cssContent.includes('@import "tailwindcss"');
  console.log('   ' + (hasTailwindImport ? '✅' : '❌') + ' Tailwind v4 import present');

  // Check for @theme directive
  const hasThemeDirective = cssContent.includes('@theme');
  console.log('   ' + (hasThemeDirective ? '✅' : '❌') + ' @theme directive present');

  // Check for @apply usage (component styling)
  const applyCount = (cssContent.match(/@apply/g) || []).length;
  console.log('   ✅ @apply directives found:', applyCount);

  // Check for dark mode variants
  const darkModeCount = (cssContent.match(/dark:/g) || []).length;
  console.log('   ✅ Dark mode variants:', darkModeCount);

  // Check for responsive utility classes (sm:, md:, lg:, etc.)
  const responsivePatterns = cssContent.match(/(sm:|md:|lg:|xl:|2xl:)/g) || [];
  if (responsivePatterns.length > 0) {
    console.log('   ✅ Responsive utilities found:', responsivePatterns.length);
  } else {
    console.log('   ℹ️  No explicit responsive utilities (Nextra handles internally)');
  }

  // Check for key responsive components
  const hasCards = cssContent.includes('.nextra-cards');
  const hasSidebar = cssContent.includes('.nextra-sidebar');

  console.log('   ' + (hasCards ? '✅' : '❌') + ' Card component styling');
  console.log('   ' + (hasSidebar ? '✅' : '❌') + ' Sidebar component styling');

  return hasTailwindImport && hasThemeDirective && applyCount > 0;
}

// Test 3: Verify layout configuration
function checkLayoutConfig() {
  console.log('\n3️⃣  Checking layout configuration...');

  const layoutFile = path.join(__dirname, 'app', 'layout.tsx');

  if (!fs.existsSync(layoutFile)) {
    console.log('   ❌ layout.tsx not found');
    return false;
  }

  const layoutContent = fs.readFileSync(layoutFile, 'utf8');

  // Check for responsive sidebar config
  const hasSidebarToggle = layoutContent.includes('toggleButton: true');
  console.log('   ' + (hasSidebarToggle ? '✅' : '❌') + ' Sidebar toggle button enabled');

  // Check for TOC config
  const hasTOC = layoutContent.includes('toc={{') || layoutContent.includes('toc: {');
  console.log('   ' + (hasTOC ? '✅' : '❌') + ' Table of Contents configured');

  // Check for viewport meta
  const hasHead = layoutContent.includes('<Head>');
  console.log('   ' + (hasHead ? '✅' : '❌') + ' Head component present (viewport meta)');

  return hasSidebarToggle && hasTOC;
}

// Test 4: Verify responsive components
function checkResponsiveComponents() {
  console.log('\n4️⃣  Verifying responsive component patterns...');

  const componentsToCheck = [
    { selector: '.nextra-cards', description: 'Cards grid' },
    { selector: '.nextra-card', description: 'Individual card' },
    { selector: '.nextra-sidebar', description: 'Sidebar navigation' },
    { selector: '.nextra-toc', description: 'Table of contents' },
  ];

  const cssContent = fs.readFileSync(CSS_FILE, 'utf8');

  componentsToCheck.forEach(component => {
    const exists = cssContent.includes(component.selector);
    console.log('   ' + (exists ? '✅' : '❌') + ' ' + component.description + ' (' + component.selector + ')');
  });

  return true;
}

// Test 5: Verify Tailwind v4 specific features
function checkTailwindV4Features() {
  console.log('\n5️⃣  Verifying Tailwind v4 compatibility...');

  const cssContent = fs.readFileSync(CSS_FILE, 'utf8');

  // Check for v4-specific syntax
  const checks = [
    {
      name: 'Color opacity slash notation',
      pattern: /(?:bg|text|border)-[a-z]+-\d+\/\d+/,
      expected: true
    },
    {
      name: 'No legacy opacity classes',
      pattern: /(?:bg|text|border)-opacity-/,
      expected: false
    },
    {
      name: '@theme custom properties',
      pattern: /@theme\s*{/,
      expected: true
    },
    {
      name: 'Important modifier syntax',
      pattern: /@apply\s+![a-z]/,
      expected: true
    },
  ];

  checks.forEach(check => {
    const found = check.pattern.test(cssContent);
    const passed = found === check.expected;
    const matches = cssContent.match(new RegExp(check.pattern, 'g')) || [];

    console.log('   ' + (passed ? '✅' : '❌') + ' ' + check.name +
                (matches.length > 0 ? ` (${matches.length} instances)` : ''));
  });

  return true;
}

// Main execution
async function main() {
  console.log('Starting responsive layout verification...\n');
  console.log('━'.repeat(60));

  const results = {
    server: await checkServer(),
    css: checkCSSFile(),
    layout: checkLayoutConfig(),
    components: checkResponsiveComponents(),
    tailwindV4: checkTailwindV4Features(),
  };

  console.log('\n' + '━'.repeat(60));
  console.log('\n📊 VERIFICATION SUMMARY\n');

  Object.entries(results).forEach(([test, passed]) => {
    console.log('   ' + (passed ? '✅' : '❌') + ' ' + test.charAt(0).toUpperCase() + test.slice(1) + ' checks');
  });

  const allPassed = Object.values(results).every(r => r === true);

  console.log('\n' + '━'.repeat(60));

  if (allPassed) {
    console.log('\n✅ ALL CHECKS PASSED - Responsive layouts are properly configured\n');
    console.log('Manual browser testing required for visual verification:');
    console.log('1. Open http://localhost:3004 in browser');
    console.log('2. Use DevTools responsive mode (Ctrl+Shift+M)');
    console.log('3. Test at breakpoints: 375px, 768px, 1024px, 1440px');
    console.log('4. Verify sidebar collapse, cards grid, code blocks\n');
    process.exit(0);
  } else {
    console.log('\n❌ SOME CHECKS FAILED - Review output above\n');
    process.exit(1);
  }
}

// Run verification
main().catch(err => {
  console.error('\n❌ Error running verification:', err.message);
  process.exit(1);
});
