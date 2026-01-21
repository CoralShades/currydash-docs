// app/docs/[[...mdxPath]]/page.tsx
// Catch-all route for Nextra content directory

import { generateStaticParamsFor, importPage } from 'nextra/pages'
import { useMDXComponents as getMDXComponents } from '../../../mdx-components'

export const generateStaticParams = generateStaticParamsFor('mdxPath')

export async function generateMetadata({ params }: { params: Promise<{ mdxPath?: string[] }> }) {
  const { metadata } = await importPage((await params).mdxPath)
  return metadata
}

const Wrapper = getMDXComponents().wrapper

export default async function Page({ params, ...props }: { params: Promise<{ mdxPath?: string[] }> }) {
  const resolvedParams = await params
  const { default: MDXContent, toc, metadata } = await importPage(resolvedParams.mdxPath)
  return (
    <Wrapper toc={toc} metadata={metadata}>
      <MDXContent {...props} params={resolvedParams} />
    </Wrapper>
  )
}
