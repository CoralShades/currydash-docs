'use client'

import { useState } from 'react'
import { CopyToClipboard } from 'react-copy-to-clipboard'

export function CodeBlock({ code, language = 'typescript', showLineNumbers = true }: {
  code: string
  language?: string
  showLineNumbers?: boolean
}) {
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
}
