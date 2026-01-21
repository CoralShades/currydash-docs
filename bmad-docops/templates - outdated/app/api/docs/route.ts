// app/api/docs/route.ts
// Headless API: Get documentation page map for custom frontends

import { NextResponse } from 'next/server'
import { getPageMap } from 'nextra/page-map'

export const dynamic = 'force-static'
export const revalidate = 3600

export async function GET() {
  try {
    const pageMap = await getPageMap()
    return NextResponse.json({
      pageMap: transformPageMap(pageMap),
      timestamp: new Date().toISOString(),
    })
  } catch (error) {
    return NextResponse.json({ error: 'Failed to fetch page map' }, { status: 500 })
  }
}

function transformPageMap(pageMap: any[]): any[] {
  return pageMap.map(item => {
    if (item.kind === 'Meta') return null
    const result: any = { name: item.name, route: item.route, title: item.title || item.name }
    if (item.kind === 'Folder') {
      result.type = 'folder'
      result.children = item.children ? transformPageMap(item.children) : []
    } else if (item.kind === 'MdxPage') {
      result.type = 'page'
      if (item.frontMatter) result.frontmatter = { title: item.frontMatter.title, description: item.frontMatter.description }
    }
    return result
  }).filter(Boolean)
}
