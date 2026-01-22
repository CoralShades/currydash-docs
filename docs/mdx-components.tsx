// mdx-components.tsx
// Nextra MDX components with CurryDash BMAD components

import type { MDXComponents } from 'mdx/types'
import { useMDXComponents as getNextraMDXComponents } from 'nextra/mdx-components'
import { Callout, Cards, FileTree, Steps, Tabs } from 'nextra/components'
import { useState, type ReactNode } from 'react'
import { CopyToClipboard } from 'react-copy-to-clipboard'

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

  CodeBlock: ({ code, language = 'typescript', showLineNumbers = true }: {
    code: string
    language?: string
    showLineNumbers?: boolean
  }) => {
    const [copied, setCopied] = useState(false)

    const handleCopy = () => {
      setCopied(true)
      setTimeout(() => setCopied(false), 2000)
    }

    return (
      <div className="relative my-4 rounded-lg border bg-gray-50 dark:bg-gray-900">
        <div className="flex items-center justify-between px-4 py-2 border-b bg-gray-100 dark:bg-gray-800">
          <span className="text-xs font-medium text-gray-600 dark:text-gray-400 uppercase">
            {language}
          </span>
          <CopyToClipboard text={code} onCopy={handleCopy}>
            <button
              className="px-3 py-1 text-xs font-medium rounded-md transition-colors bg-gray-200 hover:bg-gray-300 dark:bg-gray-700 dark:hover:bg-gray-600 text-gray-700 dark:text-gray-300"
              aria-label="Copy code to clipboard"
            >
              {copied ? (
                <span className="flex items-center gap-1">
                  <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                  </svg>
                  Copied!
                </span>
              ) : (
                <span className="flex items-center gap-1">
                  <svg className="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z" />
                  </svg>
                  Copy
                </span>
              )}
            </button>
          </CopyToClipboard>
        </div>
        <pre className="p-4 overflow-x-auto">
          <code className={`language-${language} text-sm`}>
            {code}
          </code>
        </pre>
      </div>
    )
  },
}

export function useMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...getNextraMDXComponents(components as any),
    Callout,
    Cards,
    FileTree,
    Steps,
    Tabs,
    ...BMADComponents,
    ...components,
  } as MDXComponents
}
