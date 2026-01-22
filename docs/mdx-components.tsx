// mdx-components.tsx
// Nextra MDX components with CurryDash BMAD components

import { useMDXComponents as getNextraMDXComponents } from 'nextra-theme-docs'
import type { MDXComponents } from 'nextra/mdx-components'
import { Callout, Cards, FileTree, Steps, Tabs } from 'nextra/components'
import type { ReactNode } from 'react'

// Custom BMAD components for CurryDash documentation
const BMADComponents = {
  APIEndpoint: ({ method, path, description, children }: {
    method: 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH'
    path: string
    description?: string
    children?: ReactNode
  }) => {
    const methodColors = {
      GET: 'bg-green-500/10 text-green-700 dark:text-green-400 border-green-500/20',
      POST: 'bg-blue-500/10 text-blue-700 dark:text-blue-400 border-blue-500/20',
      PUT: 'bg-yellow-500/10 text-yellow-700 dark:text-yellow-400 border-yellow-500/20',
      DELETE: 'bg-red-500/10 text-red-700 dark:text-red-400 border-red-500/20',
      PATCH: 'bg-purple-500/10 text-purple-700 dark:text-purple-400 border-purple-500/20',
    }
    return (
      <div className="my-4 rounded-lg border p-4 bg-gray-50 dark:bg-gray-900">
        <div className="flex items-center gap-3 mb-2">
          <span className={`px-2.5 py-1 rounded-md text-xs font-semibold border ${methodColors[method]}`}>
            {method}
          </span>
          <code className="text-sm font-mono bg-gray-100 dark:bg-gray-800 px-2 py-1 rounded">{path}</code>
        </div>
        {description && <p className="text-sm text-gray-600 dark:text-gray-400 mb-3">{description}</p>}
        {children}
      </div>
    )
  },

  VersionBadge: ({ version, status = 'stable' }: {
    version: string
    status?: 'stable' | 'beta' | 'deprecated'
  }) => {
    const statusColors = {
      stable: 'bg-green-500/10 text-green-700 dark:text-green-400',
      beta: 'bg-yellow-500/10 text-yellow-700 dark:text-yellow-400',
      deprecated: 'bg-red-500/10 text-red-700 dark:text-red-400',
    }
    return (
      <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${statusColors[status]}`}>
        v{version}{status !== 'stable' && ` (${status})`}
      </span>
    )
  },
}

export function useMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...getNextraMDXComponents(components || {}),
    Callout,
    Cards,
    FileTree,
    Steps,
    Tabs,
    ...BMADComponents,
    ...(components || {}),
  } as MDXComponents
}
