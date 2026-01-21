# Flutter Web Deployment Dockerfile
# Multi-stage build for optimized image size

# ============================================
# Stage 1: Build Flutter Web
# ============================================
FROM ghcr.io/cirruslabs/flutter:stable AS builder

# Set working directory
WORKDIR /app

# Copy pubspec files first for dependency caching
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build Flutter web release
RUN flutter build web --release --web-renderer canvaskit

# ============================================
# Stage 2: Serve with Nginx
# ============================================
FROM nginx:alpine

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built Flutter web app
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port (Cloud Run uses 8080)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
