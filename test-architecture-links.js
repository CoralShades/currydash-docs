#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// Configuration
const baseDir = './docs/content/developers/backend/architecture';
const results = {
  totalLinks: 0,
  validLinks: 0,
  brokenLinks: [],
  externalLinks: 0,
  anchorLinks: 0
};

// Regular expression to find markdown links
const linkRegex = /\[([^\]]+)\]\(([^)]+)\)/g;

// Check if a link is internal (not external URL or anchor)
function isInternalLink(url) {
  return !url.startsWith('http://') &&
         !url.startsWith('https://') &&
         !url.startsWith('#') &&
         !url.startsWith('mailto:');
}

// Resolve relative path
function resolvePath(fromFile, toPath) {
  // Remove any anchor from the path
  const [pathOnly] = toPath.split('#');

  const fromDir = path.dirname(fromFile);
  const resolved = path.resolve(fromDir, pathOnly);

  // Try multiple variations
  const variations = [
    resolved,
    resolved + '.mdx',
    resolved.replace(/\.md$/, '.mdx'),
    path.join(resolved, 'index.mdx'),
  ];

  return { variations, exists: variations.some(v => fs.existsSync(v)) };
}

// Get all MDX files in architecture directory
function getMDXFiles(dir) {
  const files = [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });

  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...getMDXFiles(fullPath));
    } else if (entry.name.endsWith('.mdx') || entry.name.endsWith('.md')) {
      files.push(fullPath);
    }
  }

  return files;
}

console.log('🔍 Testing Internal Links in Backend Architecture Documentation\n');
console.log('=' .repeat(70));
console.log(`Base Directory: ${baseDir}\n`);

// Get all files
const files = getMDXFiles(baseDir);
console.log(`📄 Found ${files.length} documentation files\n`);

// Process each file
files.forEach(file => {
  const content = fs.readFileSync(file, 'utf8');
  const relPath = path.relative('.', file);
  let match;
  let fileHasIssues = false;

  while ((match = linkRegex.exec(content)) !== null) {
    const linkText = match[1];
    const linkUrl = match[2];

    results.totalLinks++;

    // Skip external links
    if (!isInternalLink(linkUrl)) {
      if (linkUrl.startsWith('#')) {
        results.anchorLinks++;
      } else {
        results.externalLinks++;
      }
      continue;
    }

    // Check internal link
    const { variations, exists } = resolvePath(file, linkUrl);

    if (exists) {
      results.validLinks++;
    } else {
      if (!fileHasIssues) {
        console.log(`\n❌ ${relPath}`);
        fileHasIssues = true;
      }
      console.log(`   └─ [${linkText}](${linkUrl})`);
      console.log(`      Tried: ${variations.map(v => path.relative('.', v)).join(', ')}`);

      results.brokenLinks.push({
        file: relPath,
        linkText,
        linkUrl,
        triedPaths: variations
      });
    }
  }
});

// Print summary
console.log('\n' + '='.repeat(70));
console.log('\n📊 LINK VERIFICATION SUMMARY\n');
console.log(`Total Links Found:     ${results.totalLinks}`);
console.log(`├─ Internal Links:     ${results.validLinks + results.brokenLinks.length}`);
console.log(`│  ├─ Valid:           ${results.validLinks} ✅`);
console.log(`│  └─ Broken:          ${results.brokenLinks.length} ${results.brokenLinks.length > 0 ? '❌' : '✅'}`);
console.log(`├─ Anchor Links:       ${results.anchorLinks}`);
console.log(`└─ External Links:     ${results.externalLinks}`);

console.log('\n' + '='.repeat(70));

if (results.brokenLinks.length === 0) {
  console.log('\n✅ SUCCESS: All internal links are valid!\n');
  process.exit(0);
} else {
  console.log(`\n❌ FAILURE: Found ${results.brokenLinks.length} broken link(s)\n`);
  process.exit(1);
}
