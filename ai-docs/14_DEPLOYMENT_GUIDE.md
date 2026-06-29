# 14 - Deployment Guide

## Deployment Platforms

### Primary: Vercel

**Configuration**: `vercel.json`
```json
{
    "buildCommand": "bun run build",
    "devCommand": "bun run dev",
    "installCommand": "bun install",
    "framework": "nuxt",
    "env": ["DB_HOST", "DB_PORT", "DB_NAME", "DB_USER", "DB_PASSWORD"]
}
```

**Build process**:
1. `bun install` — install dependencies
2. `bun run build` — runs `node --max-old-space-size=700 node_modules/nuxt/bin/nuxt.mjs build`
3. Outputs to `.output/` directory
4. Vercel serves via Nitro serverless functions

**Environment variables**: Must be configured in Vercel dashboard (not in `.env.local`):
- `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`

**Evidence**: `package.json:5` — build script uses increased memory (700MB) for build.

### Alternative: Docker

**Dockerfile**: Multi-stage build
```dockerfile
# Stage 1: Build
FROM node:18.14.2-slim as build
RUN npm install -g pnpm
RUN pnpm i --production=false
RUN pnpm run build

# Stage 2: Run
FROM node:18.14.2-slim
COPY --from=build /src/.output /src/.output
CMD [ "node", ".output/server/index.mjs" ]
```

**docker-compose.yml**:
```yaml
version: "3"
services:
  my-app:
    build: { context: . }
    ports: ["3000:3000"]
    volumes: [".:/app", "/app/node_modules"]
```

**Note**: Docker compose mounts the source code (development mode), not the built output.

### Alternative: Local Development

```bash
npm install
npm run dev
# Server at http://localhost:3000
```

## CI/CD Pipeline

**None configured.** No GitHub Actions, GitLab CI, or other CI/CD pipelines exist.

Deployment is manual:
- Vercel: Git push triggers automatic deployment (if connected to repo)
- Docker: Manual `docker build` and `docker run`

## Environment Setup

### Local Development

1. Clone repo
2. Create `.env.local` with Aiven credentials
3. `npm install`
4. `npm run dev`

### Production (Vercel)

1. Connect repo to Vercel
2. Add environment variables in Vercel dashboard
3. Push to trigger deployment

### Production (Docker)

1. Create `.env` or pass environment variables
2. `docker-compose up -d`

## Database Setup

- **No migration system** — schema is managed via Directus (legacy) or direct SQL
- **Database dump**: `dump-defaultdb-202603071120.sql` — 6274 lines, includes Directus system tables
- **Restore**: `psql -h host -U user -d dbname < dump-defaultdb-202603071120.sql`

## Performance Considerations

- Build script uses `--max-old-space-size=700` to handle large builds
- `nuxt-vitalizer` configured to disable stylesheets and prefetch links for faster loading
- AOS animations loaded with configurable timing
- Images served via Cloudinary CDN with format optimization (`format="webp"`)
