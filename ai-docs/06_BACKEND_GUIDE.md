# 06 - Backend Guide

## Overview

The backend is a **Nuxt 3 Server (Nitro)** layer acting as a Backend-for-Frontend (BFF). It has:
- **5 API route handlers** in `server/api/`
- **1 utility module** in `server/utils/database.ts`
- **No controllers, services, repositories, or DTOs** — it's a thin data-access layer

## Controller Patterns (API Route Handlers)

Each API route is a single file in `server/api/` that exports a default `defineEventHandler`.

### Pattern

```typescript
// server/api/<endpoint>.ts
import { query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    // 1. Query database
    const data = await query(`SELECT ... FROM table WHERE status = $1`, ['published'])
    
    // 2. Return JSON
    return data  // or { types, data } for compound responses
  } catch (err: any) {
    // 3. Error handling
    console.error('❌ Failed to fetch ...')
    throw createError({
      statusCode: 500,
      statusMessage: 'Database Error',
      data: { message: err.message, hint: '...' }
    })
  }
})
```

### Existing Endpoints

| Endpoint | File | Method | Response Shape |
|----------|------|--------|----------------|
| `/api/main_content` | `main_content.ts` | GET | `{ id, about_desc, specialties[], languages[] }` |
| `/api/projects` | `projects.ts` | GET | `{ types[], projects[] }` (projects include images + skills) |
| `/api/experiences` | `experiences.ts` | GET | `{ types[], experiences[] }` |
| `/api/educations` | `educations.ts` | GET | `Education[]` (flat array, not wrapped) |
| `/api/skills` | `skills.ts` | GET | `Skill[]` (flat array, not wrapped) |

**Inconsistency**: `educations` and `skills` return flat arrays, while `projects` and `experiences` return `{ types, data }` objects.

### Compound Query Pattern

For endpoints returning related data:

```typescript
// server/api/projects.ts — fetch related data in separate queries, then join in JS
const projectsRaw = await query(`SELECT ... FROM projects WHERE status = $1`, ['published'])
const allImages = await query(`SELECT ... FROM projects_files WHERE projects_id = ANY($1)`, [ids])
const allSkills = await query(`SELECT ... FROM skills JOIN projects_skills ... WHERE projects_id = ANY($1)`, [ids])

// Map in JavaScript
const projects = projectsRaw.map(project => ({
    ...project,
    images: allImages.filter(img => img.projects_id === project.id),
    skills_used: allSkills.filter(skill => skill.projects_id === project.id)
}))
```

**Note**: This is an N+1 avoidance pattern — fetching all related records in batch, then joining in JS rather than using SQL JOINs or subqueries.

## Service Patterns

**There is no service layer.** Business logic is minimal and handled directly in API route handlers. For a read-only portfolio, this is acceptable.

## Repository Patterns

**There is no repository abstraction.** Database access is done directly via the `query()` utility function with inline SQL.

## DTO Patterns

**There are no DTOs (Data Transfer Objects).** Database rows are returned directly as JSON. The TypeScript interfaces in `stores/model-store.ts` serve as informal type contracts for the client side.

## Validation Patterns

**There is no input validation.** All endpoints are GET-only with no query parameters or request bodies. The `WHERE status = 'published'` clause acts as a data filter.

## Middleware

**No custom middleware is defined.** The only server-side middleware-like behavior is the connection pool management in `database.ts`.

## Authentication & Authorization

**None.** All endpoints are publicly accessible. This is intentional — it's a public portfolio website.

## Error Handling

Every API route follows this exact pattern:

```typescript
try {
    // ... queries
} catch (err: any) {
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

**Characteristics**:
- All errors are treated as 500 Internal Server Error
- No 404 handling (if no data found, throws generic Error in `main_content.ts`)
- Debug information exposed in `data.message` and `data.hint`
- Console logging with emoji prefixes for readability

## Database Connection

**File**: `server/utils/database.ts`

```typescript
// Singleton pattern — pool created once, reused
let pool: Pool | null = null

export function getPool(): Pool {
  if (!pool) {
    pool = new Pool({
      host: config.dbHost,
      port: parseInt(config.dbPort),
      database: config.dbName,
      user: config.dbUser,
      password: config.dbPassword,
      ssl: { rejectUnauthorized: false },  // Required for Aiven
      max: 5,                              // Aiven free tier limit
      idleTimeoutMillis: 10000,
      connectionTimeoutMillis: 5000,
      statement_timeout: 30000,
    })
  }
  return pool
}

// Helper functions
export async function query(text: string, params: any[] = []): Promise<any[]>
export async function queryOne(text: string, params: any[] = []): Promise<any | null>
export async function closePool(): Promise<void>
```

**Key characteristics**:
- Parameterized queries (SQL injection prevention via `$1`, `$2` placeholders)
- Connection pool with max 5 connections (Aiven free tier optimized)
- SSL required for cloud database
- Statement timeout of 30 seconds
- Connection lifecycle logging
- `queryOne()` convenience method exists but is not currently used by any endpoint

## Runtime Configuration

Credentials are stored in Nuxt runtime config (from environment variables):

```typescript
// nuxt.config.ts
runtimeConfig: {
    // Server-only (never exposed to client)
    dbHost: process.env.DB_HOST,
    dbPort: process.env.DB_PORT,
    dbName: process.env.DB_NAME,
    dbUser: process.env.DB_USER,
    dbPassword: process.env.DB_PASSWORD,
    
    // Public (exposed to client)
    public: {
        experience_icon: 'https://res.cloudinary.com/...',
        education_icon: 'https://res.cloudinary.com/...'
    }
}
```

Accessed in server routes via `useRuntimeConfig()` and in client components via `useRuntimeConfig().public`.
