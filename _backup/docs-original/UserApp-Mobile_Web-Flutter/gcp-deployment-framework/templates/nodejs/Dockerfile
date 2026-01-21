# Node.js Production Dockerfile
# Optimized multi-stage build for Cloud Run

# ============================================
# Stage 1: Dependencies
# ============================================
FROM node:20-alpine AS deps

WORKDIR /app

# Copy package files
COPY package.json package-lock.json* yarn.lock* pnpm-lock.yaml* ./

# Install production dependencies only
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile --production; \
  elif [ -f package-lock.json ]; then npm ci --only=production; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile --prod; \
  else npm install --only=production; \
  fi

# ============================================
# Stage 2: Build (if TypeScript)
# ============================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package.json package-lock.json* yarn.lock* pnpm-lock.yaml* ./

# Install all dependencies (including dev for build)
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile; \
  else npm install; \
  fi

# Copy source code
COPY . .

# Build TypeScript (if applicable)
RUN npm run build || echo "No build step"

# ============================================
# Stage 3: Production Runner
# ============================================
FROM node:20-alpine AS runner

WORKDIR /app

# Set production environment
ENV NODE_ENV production

# Create non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 appuser

# Copy production dependencies
COPY --from=deps --chown=appuser:nodejs /app/node_modules ./node_modules

# Copy built application
# For TypeScript: copy from builder stage
COPY --from=builder --chown=appuser:nodejs /app/dist ./dist
# For JavaScript: uncomment below and comment above
# COPY --chown=appuser:nodejs . .

# Copy package.json for npm start
COPY --chown=appuser:nodejs package.json ./

# Switch to non-root user
USER appuser

# Expose port (Cloud Run uses 8080)
EXPOSE 8080
ENV PORT 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

# Start the application
CMD ["node", "dist/index.js"]
# For JavaScript without build: CMD ["node", "index.js"]
# Or use npm start: CMD ["npm", "start"]
