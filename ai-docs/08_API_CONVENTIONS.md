# 08 - API Conventions

## API Layer Structure

```
Client (pages/*.vue)
  → useLazyFetch("/api/<endpoint>", { server: false })
    → Nuxt Nitro server (server/api/<endpoint>.ts)
      → query(sql, params) from server/utils/database.ts
        → PostgreSQL (Aiven)
      ← rows[]
    ← JSON response
  ← computed() transforms data
```

**Key**: All API calls use `server: false` — they execute client-side but hit the Nuxt server routes (not the database directly). The BFF pattern keeps DB credentials server-side.

## Request Patterns

### Client-Side (Pages)

Every page uses the same fetching pattern:

```typescript
// Pattern 1: Single endpoint
const { status, data, execute } = useLazyFetch("/api/main_content", { server: false });

// Pattern 2: Multiple endpoints (experiences page)
const { status: exStatus, data: exData, execute: exExecute } = useLazyFetch("/api/experiences", { server: false });
const { status: skStatus, data: skData, execute: skExecute } = useLazyFetch("/api/skills", { server: false });

// Execution
onMounted(() => {
    exExecute();
    skExecute();
});
```

**Characteristics**:
- `useLazyFetch` is used (not `useFetch`) — data fetching is deferred
- `server: false` — fetches happen client-side only
- `execute()` called in `onMounted()` — triggers the actual request
- `status` ref tracks loading state: `'pending'` → `'success'` | `'error'`

### Server-Side (API Routes)

```typescript
// All endpoints are GET-only, no request body parsing
export default defineEventHandler(async (event) => {
    // No event parsing needed — no query params, no body
    const data = await query(`SELECT ... FROM table WHERE status = $1`, ['published'])
    return data
})
```

**No query parameters, request bodies, or headers are used.** All endpoints return the complete dataset filtered by `status = 'published'`.

## Response Patterns

### Pattern 1: Wrapped Object (Most Common)

```json
// GET /api/main_content
{
    "id": 1,
    "about_desc": "...",
    "specialties": [...],
    "languages": [...]
}

// GET /api/projects
{
    "types": [...],
    "projects": [...]
}

// GET /api/experiences
{
    "types": [...],
    "experiences": [...]
}
```

### Pattern 2: Flat Array

```json
// GET /api/educations
[{ "id": 1, "institution": "...", ... }, ...]

// GET /api/skills
[{ "id": 1, "title": "...", ... }, ...]
```

**Inconsistency**: `educations` and `skills` return flat arrays, while `projects` and `experiences` return `{ types, data }` objects.

### Client-Side Data Transformation

```typescript
// Pages always wrap/transform the response with computed()
const contents: Ref<Project[] | null> = computed(() => 
    data.value ? [...data.value.projects] : null
);

// Or for flat arrays:
const educations: Ref<Education[] | null> = computed(() => 
    data.value ? [...data.value] : null
);
```

**Note**: The spread operator `[...data.value]` creates a new array — this is a defensive copy pattern.

## Error Handling

### Server-Side

```typescript
// Consistent error pattern in all API routes
catch (err: any) {
    console.error('❌ Failed to fetch [resource]:')
    console.error('Error type:', err.constructor.name)
    console.error('Error message:', err.message)
    console.error('Full error:', err)
    
    throw createError({
        statusCode: 500,
        statusMessage: 'Database Error',
        data: {
            message: err.message,
            hint: 'Check database connection'
        }
    })
}
```

### Client-Side

```typescript
// Status-based conditional rendering
<MainWavyLoader v-if="status !== 'success'" />
<div v-if="status === 'success'">...</div>

// No explicit error handling in pages
// If API fails, the loader just keeps spinning
```

**No client-side error handling exists.** If an API call fails, the loading state persists indefinitely.

## Authentication Handling

**None.** All endpoints are public. No auth headers, tokens, or cookies.

## Retry Mechanisms

**None.** Failed requests are not retried automatically. `useLazyFetch` does not have retry configuration.

## Cache Mechanisms

**None.** No client-side caching, no HTTP cache headers, no service worker. Every page navigation triggers fresh API calls.

## Generated Examples

### Adding a New Endpoint

**Server side** (`server/api/testimonials.ts`):
```typescript
import { query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    const testimonials = await query(
      `SELECT id, author, content, rating 
       FROM testimonials 
       WHERE status = $1 
       ORDER BY sort ASC`,
      ['published']
    )
    return testimonials
  } catch (err: any) {
    console.error('❌ Failed to fetch testimonials:', err.message)
    throw createError({
      statusCode: 500,
      statusMessage: 'Database Error',
      data: { message: err.message, hint: 'Check database connection' }
    })
  }
})
```

**Client side** (`pages/testimonials.vue`):
```typescript
const { status, data, execute } = useLazyFetch("/api/testimonials", { server: false });
const testimonials: Ref<Testimonial[] | null> = computed(() => data.value ? [...data.value] : null);
onMounted(() => execute());
```
