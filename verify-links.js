#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const glob = require('glob');

// Find all MDX files in the API section
const mdxFiles = glob.sync('docs/content/api/**/*.mdx');

// Track all broken links
const brokenLinks = [];
const allLinks = [];

// Regular expression to find markdown links
const linkRegex = /\[([^\]]+)\]\(([^)]+)\)/g;

// Check if a link is internal (not external URL)
function isInternalLink(url) {
  return !url.startsWith('http://') && !url.startsWith('https://') && !url.startsWith('#');
}

// Resolve relative path
function resolvePath(fromFile, toPath) {
  let resolved;

  // Handle root-relative URLs (starting with /)
  if (toPath.startsWith('/')) {
    // Remove leading slash and resolve from docs/content
    const relativePath = toPath.substring(1);
    resolved = path.join('docs/content', relativePath);
  } else {
    // Handle relative URLs
    const fromDir = path.dirname(fromFile);
    resolved = path.resolve(fromDir, toPath);
  }

  // Remove .mdx extension if present
  let cleanPath = resolved.replace(/\.mdx$/, '');

  // Remove anchor fragments
  cleanPath = cleanPath.split('#')[0];
  resolved = resolved.split('#')[0];

  // Try multiple variations
  const variations = [
    resolved,
    resolved + '.mdx',
    cleanPath + '.mdx',
    path.join(resolved, 'index.mdx'),
    path.join(cleanPath, 'index.mdx'),
  ];

  return variations;
}

console.log('Checking links in API reference documentation...\n');

mdxFiles.forEach(file => {
  const content = fs.readFileSync(file, 'utf8');
  let match;

  while ((match = linkRegex.exec(content)) !== null) {
    const linkText = match[1];
    const linkUrl = match[2];

    allLinks.push({ file, linkText, linkUrl });

    if (isInternalLink(linkUrl)) {
      const variations = resolvePath(file, linkUrl);
      const exists = variations.some(v => fs.existsSync(v));

      if (!exists) {
        brokenLinks.push({
          file,
          linkText,
          linkUrl,
          triedPaths: variations
        });
      }
    }
  }
});

console.log(`Total internal links found: ${allLinks.filter(l => isInternalLink(l.linkUrl)).length}`);
console.log(`Total external links found: ${allLinks.filter(l => !isInternalLink(l.linkUrl)).length}\n`);

if (brokenLinks.length > 0) {
  console.log('❌ BROKEN LINKS FOUND:\n');
  brokenLinks.forEach(broken => {
    console.log(`File: ${broken.file}`);
    console.log(`  Link: [${broken.linkText}](${broken.linkUrl})`);
    console.log(`  Tried paths:`);
    broken.triedPaths.forEach(p => console.log(`    - ${p}`));
    console.log('');
  });
  process.exit(1);
} else {
  console.log('✅ All internal links are valid!');
  process.exit(0);
}
