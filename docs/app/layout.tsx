// app/layout.tsx
// CurryDash Platform Documentation - Root Layout

import type { Metadata } from 'next'
import { Footer, Layout, Navbar } from 'nextra-theme-docs'
import { Banner, Head } from 'nextra/components'
import { getPageMap } from 'nextra/page-map'

// Import Nextra theme CSS FIRST, then custom styles
import 'nextra-theme-docs/style.css'
import './globals.css'

export const metadata: Metadata = {
  title: { default: 'CurryDash Documentation', template: '%s | CurryDash Docs' },
  description: 'Complete documentation for the CurryDash Sri Lankan food delivery platform',
  keywords: ['CurryDash', 'food delivery', 'documentation', 'API', 'Laravel', 'Flutter', 'Sri Lankan'],
}

const banner = (
  <Banner storageKey="currydash-banner-v1">
    Welcome to CurryDash Documentation - Sri Lankan Food Delivery Platform
  </Banner>
)

const navbar = (
  <Navbar
    logo={
      <span className="font-bold text-lg flex items-center gap-2">
        <span style={{ color: '#E6B04B' }}>CurryDash</span>
      </span>
    }
    projectLink="https://github.com/CoralShades/currydash-docs"
  />
)

const footer = (
  <Footer>
    <div className="flex flex-col items-center gap-2">
      <span>MIT {new Date().getFullYear()} CoralShades</span>
      <span className="text-sm text-gray-500">Built with Nextra & BMAD DocOps</span>
    </div>
  </Footer>
)

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" dir="ltr" suppressHydrationWarning>
      <Head>
        <link rel="icon" href="/favicon.svg" type="image/svg+xml" />
        <meta name="theme-color" content="#E6B04B" />
      </Head>
      <body>
        <Layout
          banner={banner}
          navbar={navbar}
          footer={footer}
          pageMap={await getPageMap()}
          docsRepositoryBase="https://github.com/CoralShades/currydash-docs/tree/main/docs/content"
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
