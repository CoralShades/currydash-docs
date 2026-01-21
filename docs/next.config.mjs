// next.config.mjs
// Nextra 4 configuration for CurryDash Documentation

import nextra from 'nextra'

const withNextra = nextra({
  // Search configuration (Pagefind - Rust-powered)
  search: {
    codeblocks: false,
  },
})

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,

  // Transpile nextra packages to ensure CSS is handled correctly
  transpilePackages: ['nextra', 'nextra-theme-docs'],

  // CORS headers for headless API
  async headers() {
    return [
      {
        source: '/api/docs/:path*',
        headers: [
          { key: 'Access-Control-Allow-Credentials', value: 'true' },
          { key: 'Access-Control-Allow-Origin', value: '*' },
          { key: 'Access-Control-Allow-Methods', value: 'GET,POST,OPTIONS' },
          { key: 'Access-Control-Allow-Headers', value: 'Content-Type, Authorization' },
        ],
      },
    ]
  },
}

export default withNextra(nextConfig)
