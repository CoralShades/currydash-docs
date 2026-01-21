// app/layout.tsx
// Root layout for Nextra 4 documentation site

import type { Metadata } from 'next'
import { Footer, Layout, Navbar } from 'nextra-theme-docs'
import { Banner, Head } from 'nextra/components'
import { getPageMap } from 'nextra/page-map'
import 'nextra-theme-docs/style.css'
import './globals.css'

export const metadata: Metadata = {
  title: { default: 'Documentation', template: '%s | Docs' },
  description: 'Product documentation powered by BMAD DocOps',
}

const banner = <Banner storageKey="docs-banner-v1">🚀 Welcome to our documentation!</Banner>

const navbar = (
  <Navbar
    logo={<span className="font-bold text-lg">📚 Docs</span>}
    projectLink="https://github.com/your-org/your-repo"
  />
)

const footer = (
  <Footer>
    <span>MIT {new Date().getFullYear()} © Your Company. Built with Nextra & BMAD DocOps.</span>
  </Footer>
)

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" dir="ltr" suppressHydrationWarning>
      <Head><link rel="icon" href="/favicon.ico" /></Head>
      <body>
        <Layout
          banner={banner}
          navbar={navbar}
          footer={footer}
          pageMap={await getPageMap()}
          docsRepositoryBase="https://github.com/your-org/your-repo/tree/main/content"
          editLink="Edit this page on GitHub"
          sidebar={{ defaultMenuCollapseLevel: 1, toggleButton: true }}
          toc={{ backToTop: true, float: true, title: 'On This Page' }}
        >
          {children}
        </Layout>
      </body>
    </html>
  )
}
