// app/not-found.tsx
// Custom 404 page for CurryDash Documentation

import Link from 'next/link'

export default function NotFound() {
  return (
    <div className="flex flex-col items-center justify-center min-h-[60vh] px-4">
      <div className="text-center">
        {/* 404 with brand color */}
        <h1 className="text-8xl font-bold" style={{ color: '#E6B04B' }}>
          404
        </h1>

        <h2 className="mt-4 text-2xl font-semibold text-gray-800 dark:text-gray-200">
          Page Not Found
        </h2>

        <p className="mt-2 text-gray-600 dark:text-gray-400 max-w-md">
          Sorry, we couldn't find the documentation page you're looking for.
          It may have been moved or doesn't exist.
        </p>

        {/* Navigation options */}
        <div className="mt-8 flex flex-col sm:flex-row gap-4 justify-center">
          <Link
            href="/"
            className="inline-flex items-center justify-center px-6 py-3 rounded-lg font-medium transition-colors"
            style={{ backgroundColor: '#E6B04B', color: 'white' }}
          >
            Go to Homepage
          </Link>

          <Link
            href="/developers"
            className="inline-flex items-center justify-center px-6 py-3 rounded-lg font-medium border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors"
          >
            Developer Docs
          </Link>
        </div>

        {/* Quick links */}
        <div className="mt-12 text-sm text-gray-500 dark:text-gray-400">
          <p className="mb-3">Or try one of these sections:</p>
          <div className="flex flex-wrap justify-center gap-4">
            <Link href="/vendors" className="hover:text-[#E6B04B] transition-colors">
              Vendor Guide
            </Link>
            <span className="text-gray-300 dark:text-gray-600">|</span>
            <Link href="/admins" className="hover:text-[#E6B04B] transition-colors">
              Admin Guide
            </Link>
            <span className="text-gray-300 dark:text-gray-600">|</span>
            <Link href="/api" className="hover:text-[#E6B04B] transition-colors">
              API Reference
            </Link>
          </div>
        </div>
      </div>
    </div>
  )
}
