// app/[[...mdxPath]]/page.tsx
// Catch-all route for Nextra content directory - serves all MDX pages including root

import { generateStaticParamsFor, importPage } from 'nextra/pages'
import { useMDXComponents as getMDXComponents } from '../../mdx-components'
import type { ReactNode } from 'react'

export const generateStaticParams = generateStaticParamsFor('mdxPath')

export async function generateMetadata({ params }: { params: Promise<{ mdxPath?: string[] }> }) {
  const { metadata } = await importPage((await params).mdxPath)
  return metadata
}

// Get the wrapper component or use a simple Fragment fallback
const components = getMDXComponents()
const Wrapper = components.wrapper || (({ children }: { children: ReactNode }) => <>{children}</>)

export default async function Page({ params, ...props }: { params: Promise<{ mdxPath?: string[] }> }) {
  const resolvedParams = await params
  const { default: MDXContent, toc, metadata } = await importPage(resolvedParams.mdxPath)
  return (
    <Wrapper toc={toc} metadata={metadata}>
      <MDXContent {...props} params={resolvedParams} />
    </Wrapper>
  )
}
