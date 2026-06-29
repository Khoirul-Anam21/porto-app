# 12 - Security Guide

## Authentication & Authorization

**None.** The application has no user authentication or authorization system. All endpoints are publicly accessible. This is intentional for a public portfolio website.

## Secrets Handling

### Environment Variables

Database credentials are stored in environment variables:

| Variable | Location | Exposed to Client |
|----------|----------|-------------------|
| `DB_HOST` | `.env.local` / Vercel env | No (server-only via `runtimeConfig`) |
| `DB_PORT` | `.env.local` / Vercel env | No |
| `DB_NAME` | `.env.local` / Vercel env | No |
| `DB_USER` | `.env.local` / Vercel env | No |
| `DB_PASSWORD` | `.env.local` / Vercel env | No |

**Evidence**: `nuxt.config.ts:40-46` — credentials are in the private `runtimeConfig` section (not `public`).

### .gitignore Protection

```
.env
.env.*
!.env.example
```

`.env.local` is git-ignored. `.env.example` is safe to commit (contains no real values).

### Runtime Config Access

```typescript
// Server-side: access private config
const config = useRuntimeConfig()
const pool = new Pool({ host: config.dbHost, ... })

// Client-side: only public config available
const config = useRuntimeConfig()
console.log(config.public.experience_icon) // OK
console.log(config.dbHost) // undefined (not accessible)
```

## SQL Injection Prevention

**Properly handled.** All queries use parameterized statements:

```typescript
// SAFE — parameterized query
await query(`SELECT * FROM table WHERE status = $1`, ['published'])

// SAFE — parameterized with array
await query(`SELECT * FROM table WHERE id = ANY($1)`, [ids])
```

**Evidence**: Every `query()` call in `server/api/*.ts` uses `$1`, `$2` placeholders with parameter arrays.

## XSS Prevention

### Risk Areas

1. **`v-html` usage** — HTML content from the database is rendered directly:
   ```html
   <div v-html="props.experience.job_detail" class="prose ...">
   <div v-html="item.detail" class="prose ...">
   ```
   - **Risk**: If database contains malicious HTML/JS, it will execute
   - **Mitigation**: Content is authored by the portfolio owner directly in the database
   - **Recommendation**: Sanitize HTML before storage or use a sanitization library

2. **Cloudinary image URLs** — used directly in `:src` attributes:
   ```html
   <NuxtImg :src="`${item.icon_img}`" />
   ```
   - **Low risk**: URLs are from a trusted CDN

### Safe Patterns

- Most content uses `{{ }}` text interpolation (auto-escaped)
- Profile data is hardcoded in the store (not from user input)

## CSRF Protection

**Not applicable.** The application has no write operations, forms, or state-changing endpoints. All API calls are GET-only read operations.

## HTTPS / SSL

- **Database connection**: SSL required (`ssl: { rejectUnauthorized: false }` for Aiven)
- **Vercel deployment**: HTTPS enabled by default
- **Docker deployment**: No SSL configuration (would need reverse proxy)

## Dependency Security

- `.npmrc` contains `strict-peer-dependencies=false` — reduces npm install failures but may mask dependency conflicts
- `bun.lockb` is present (binary lockfile)
- No automated vulnerability scanning configured

## Exposed Information

### In API Responses

Error responses include database error messages:
```json
{
    "statusCode": 500,
    "data": {
        "message": "connection timeout",
        "hint": "Check .env.local credentials and Aiven database connection"
    }
}
```

**Risk**: Database error messages could reveal connection details in production.

### In Console Logs

Server-side console.log statements include:
- Database host, port, database name
- Query results (partial)
- Error details

**Risk**: Logs may be accessible in serverless environments (Vercel function logs).

### In Client-Side Code

Personal information is hardcoded in the Pinia store:
- Full name, job title, address, hobby
- Birth date, WhatsApp number, email, social media URLs
- GitHub username, LinkedIn profile

**Risk**: Low — this is a public portfolio and this information is intended to be public.

## Recommendations

1. **Sanitize HTML content** from the database before rendering with `v-html`
2. **Remove or redact** error messages in production API responses
3. **Remove `console.log` statements** from production server code (or use a proper logger)
4. **Add rate limiting** to API endpoints to prevent abuse
5. **Consider CSP headers** for additional XSS protection
6. **Review `rejectUnauthorized: false`** — consider proper certificate validation for Aiven
