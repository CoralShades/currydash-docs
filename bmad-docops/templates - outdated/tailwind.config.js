/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/**/*.{js,ts,jsx,tsx,mdx}',
    './content/**/*.{md,mdx}',
    './mdx-components.tsx',
    './node_modules/nextra-theme-docs/**/*.js',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
  darkMode: 'class',
}
