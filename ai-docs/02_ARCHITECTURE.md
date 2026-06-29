# 02 - Architecture

## High-Level Architecture

```
┌─────────────────────────────────────────────────┐
│                    CLIENT                        │
│  ┌─────────┐  ┌──────────┐  ┌───────────────┐  │
│  │ Pages   │  │Components│  │ Pinia Store   │  │
│  │ (routes)│──│ (UI)     │──│ (global state)│  │
│  └────┬────┘  └──────────┘  └───────────────┘  │
│       │                                          │
│  ┌────▼────────────────────────────┐            │
│  │  useLazyFetch() / useFetch()    │            │
│  └────────────────┬────────────────┘            │
└───────────────────┼─────────────────────────────┘
                    │ HTTP (internal)
┌───────────────────▼─────────────────────────────┐
│                  SERVER (Nitro)                   │
│  ┌──────────────────────────────────┐            │
│  │  server/api/*.ts                 │            │
│  │  (5 API route handlers)          │            │
│  └────────────────┬─────────────────┘            │
│                   │                              │
│  ┌────────────────▼─────────────────┐            │
│  │  server/utils/database.ts        │            │
│  │  (pg Pool + query helpers)       │            │
│  └────────────────┬─────────────────┘            │
└───────────────────┼─────────────────────────────┘
                    │ TCP/SSL
┌───────────────────▼─────────────────────────────┐
│          PostgreSQL (Aiven Cloud)                 │
│  12 business tables + Directus system tables     │
└─────────────────────────────────────────────────┘
```

## Architecture Pattern

**Server-Side Rendering is OFF** (`ssr: false` in `nuxt.config.ts:4`). The application behaves as a **client-side SPA** with a **Backend-for-Frontend (BFF)** pattern:

- **Client**: Vue 3 SPA with client-side routing
- **BFF**: Nuxt server API routes act as an intermediary between the client and the database
- **Database**: PostgreSQL directly (no ORM, no REST API layer like Directus)

This is **NOT** Clean Architecture, Hexagonal, or MVC in the traditional sense. It is a **pragmatic Nuxt 3 BFF architecture** — simple and appropriate for a portfolio site.

## Layer Architecture

### 1. Presentation Layer
- **Files**: `pages/*.vue`, `components/**/*.vue`, `layouts/*.vue`
- **Responsibility**: Render UI, handle user interactions, animations
- **Dependencies**: Pinia store, composables, server API (via `useLazyFetch`)

### 2. Application Layer (BFF / API Routes)
- **Files**: `server/api/*.ts`
- **Responsibility**: Accept HTTP requests, query database, return JSON
- **Dependencies**: `server/utils/database.ts`

### 3. Data Access Layer
- **Files**: `server/utils/database.ts`
- **Responsibility**: PostgreSQL connection pool management, query execution
- **Dependencies**: `pg` library, runtime config for credentials

### 4. Data Layer
- **External**: Aiven PostgreSQL database
- **Schema**: Inherited from Directus CMS (tables prefixed with `directus_` for system, unprefixed for business data)

## Module Boundaries

```
composables/          ← Shared data + utilities (client-side)
  ├── index.ts        ← Empty barrel file
  ├── projects.ts     ← Static project data (HARDCODED, not from DB)
  ├── skills.ts       ← Static skill icons mapping (HARDCODED)
  ├── socmeds.ts      ← Static social media links (HARDCODED)
  └── useFormatDate.ts← Date formatting utility

stores/               ← Global state
  ├── index.ts        ← Profile data, social links, UI state (HARDCODED)
  └── model-store.ts  ← TypeScript interfaces only (NO store, just types)

server/               ← Server-side code
  ├── api/            ← API route handlers (one file per endpoint)
  └── utils/          ← Database connection utility

components/           ← UI components organized by domain
  ├── base/           ← Generic, reusable UI primitives
  ├── main/           ← Application-specific layout components
  ├── education/      ← Education-specific components
  ├── experience/     ← Experience-specific components
  └── project/        ← Project-specific components
```

## Dependency Flow

```
pages/ → components/ → composables/ (data & utils)
  │                      │
  │                      ├── skills.ts (static icon mapping)
  │                      ├── projects.ts (static project data)
  │                      └── useFormatDate.ts
  │
  ├── stores/index.ts (global profile + UI state)
  └── stores/model-store.ts (TypeScript interfaces)

pages/ → useLazyFetch("/api/*")
  └── server/api/*.ts → server/utils/database.ts → PostgreSQL
```

**Critical observation**: There is a **dual data source pattern** — some data is hardcoded in composables/stores (profile, static projects, static skills), while dynamic data comes from the database via API routes.

## Data Flow

### Profile Data (Hardcoded)
```
stores/index.ts → default.vue → renders sidebar
```

### Dynamic Content (Database)
```
pages/*.vue
  → useLazyFetch("/api/endpoint")
    → server/api/endpoint.ts
      → query(sql) → PostgreSQL
    ← JSON response
  → computed() transforms
  → Template renders
```

## Key Architectural Decisions

| Decision | Evidence | Rationale |
|----------|----------|-----------|
| SSR disabled | `nuxt.config.ts:4` `ssr: false` | Simple SPA; no SEO needed for portfolio |
| No ORM | Raw SQL in `server/api/*.ts` | Simplicity; small codebase; Directus legacy schema |
| BFF pattern | `server/api/*.ts` | Keeps DB credentials server-side |
| Pinia Options API style | `stores/index.ts` `defineStore('state', { state, actions })` | Legacy Pinia pattern (not setup store) |
| Component auto-import | `components/base/round-decor.vue` used as `<BaseRoundDecor />` | Nuxt 3 default behavior |
| Lazy loading | `LazyBaseLanguage` in `pages/index.vue:61` | Performance optimization for below-fold content |
