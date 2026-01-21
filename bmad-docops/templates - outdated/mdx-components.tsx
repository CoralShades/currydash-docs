// mdx-components.tsx
// Custom MDX components for Nextra 4 documentation

import type { MDXComponents } from 'mdx/types'
import { useMDXComponents as getNextraMDXComponents } from 'nextra/mdx-components'
import { Callout, Cards, Card, FileTree, Steps, Tabs, Tab } from 'nextra/components'

// Custom BMAD components
const BMADComponents = {
  // API endpoint documentation
  APIEndpoint: ({ method, path, description, children }: { 
    method: 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH'
    path: string
    description?: string
    children?: React.ReactNode
  }) => {
    const colors = {
      GET: 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-200',
      POST: 'bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200',
      PUT: 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-200',
      DELETE: 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-200',
      PATCH: 'bg-purple-100 text-purple-800 dark:bg-purple-900 dark:text-purple-200',
    }
    return (
      <div className="my-4 rounded-lg border border-gray-200 dark:border-gray-800 p-4">
        <div className="flex items-center gap-3 mb-2">
          <span className={`px-2 py-1 rounded text-xs font-bold ${colors[method]}`}>{method}</span>
          <code className="text-sm font-mono">{path}</code>
        </div>
        {description && <p className="text-sm text-gray-600 dark:text-gray-400 mb-3">{description}</p>}
        {children}
      </div>
    )
  },

  // Version badge
  VersionBadge: ({ version, status = 'stable' }: { version: string; status?: 'stable' | 'beta' | 'deprecated' }) => {
    const colors = { stable: 'bg-green-100 text-green-800', beta: 'bg-yellow-100 text-yellow-800', deprecated: 'bg-red-100 text-red-800' }
    return (
      <span className={`inline-flex items-center px-2 py-1 rounded text-xs font-medium ${colors[status]}`}>
        v{version}{status !== 'stable' && ` (${status})`}
      </span>
    )
  },

  // Story reference
  StoryRef: ({ id, title }: { id: string; title?: string }) => (
    <span className="inline-flex items-center text-sm">
      <span className="bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200 px-2 py-0.5 rounded font-mono text-xs">{id}</span>
      {title && <span className="ml-2 text-gray-600 dark:text-gray-400">{title}</span>}
    </span>
  ),

  // Changelog entry
  ChangelogEntry: ({ version, date, type, children }: { version: string; date: string; type: 'major' | 'minor' | 'patch'; children: React.ReactNode }) => {
    const colors = { major: 'border-l-red-500', minor: 'border-l-blue-500', patch: 'border-l-green-500' }
    return (
      <div className={`border-l-4 ${colors[type]} pl-4 my-6`}>
        <div className="flex items-center gap-3 mb-2">
          <span className="text-xl font-bold">v{version}</span>
          <span className="text-sm text-gray-500">{date}</span>
        </div>
        {children}
      </div>
    )
  },
}

export function useMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...getNextraMDXComponents({ ...components }),
    Callout, Cards, Card, FileTree, Steps, Tabs, Tab,
    ...BMADComponents,
    ...components,
  }
}
