// app/loading.tsx
// Loading component for CurryDash Documentation

export default function Loading() {
  return (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="flex flex-col items-center gap-4">
        <div className="relative">
          {/* Outer ring with brand color */}
          <div className="w-12 h-12 rounded-full border-4 border-gray-200 dark:border-gray-700"></div>
          {/* Spinning inner ring with turmeric gold */}
          <div className="absolute top-0 left-0 w-12 h-12 rounded-full border-4 border-transparent border-t-[#E6B04B] animate-spin"></div>
        </div>
        <p className="text-sm text-gray-500 dark:text-gray-400">Loading documentation...</p>
      </div>
    </div>
  )
}
