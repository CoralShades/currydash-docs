// app/api/docs/[...slug]/route.ts
// Headless API: Get compiled MDX for a specific page

import { NextRequest, NextResponse } from 'next/server'
import { compileMdx } from 'nextra/compile'
import { readFile } from 'fs/promises'
import { join } from 'path'
import matter from 'gray-matter'

export const dynamic = 'force-static'
export const revalidate = 3600

export async function GET(request: NextRequest, { params }: { params: Promise<{ slug: string[] }> }) {
  try {
    const slug = (await params).slug || []
    let content: string
    
    try {
      content = await readFile(join(process.cwd(), 'content', ...slug) + '.mdx', 'utf-8')
    } catch {
      try {
        content = await readFile(join(process.cwd(), 'content', ...slug, 'index.mdx'), 'utf-8')
      } catch {
        return NextResponse.json({ error: 'Page not found', slug: slug.join('/') }, { status: 404 })
      }
    }
    
    const { data: frontmatter, content: mdxContent } = matter(content)
    const compiledSource = await compileMdx(mdxContent)
    const toc = extractToc(mdxContent)
    
    return NextResponse.json({ content: compiledSource, frontmatter, toc, slug: slug.join('/'), timestamp: new Date().toISOString() })
  } catch (error) {
    return NextResponse.json({ error: 'Failed to fetch page', message: (error as Error).message }, { status: 500 })
  }
}

function extractToc(content: string) {
  const headingRegex = /^(#{2,4})\s+(.+)$/gm
  const toc: { id: string; text: string; level: number }[] = []
  let match
  while ((match = headingRegex.exec(content)) !== null) {
    const text = match[2].trim()
    toc.push({ id: text.toLowerCase().replace(/[^\w\s-]/g, '').replace(/\s+/g, '-'), text, level: match[1].length })
  }
  return toc
}
