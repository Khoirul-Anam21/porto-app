# 03 - Folder Structure

```
porto-app/
├── app.vue                    # Root component, wraps layout + pages
├── nuxt.config.ts             # Nuxt configuration (SSR off, modules, runtime config)
├── tailwind.config.js         # Tailwind CSS configuration
├── package.json               # Dependencies and scripts
├── tsconfig.json              # TypeScript config (extends .nuxt/tsconfig.json)
├── vercel.json                # Vercel deployment config
├── Dockerfile                 # Docker build config
├── docker-compose.yml         # Docker compose config
├── .env.example               # Environment variable template
├── .env.local                 # Local env vars (git-ignored)
├── .npmrc                     # npm config (strict-peer-dependencies=false)
├── .gitignore                 # Git ignore rules
├── dump-defaultdb-*.sql       # PostgreSQL database dump (for reference/migration)
│
├── ai-docs/                   # AI-generated project documentation
│
├── assets/                    # Static assets processed by build
│   ├── css/
│   │   └── main.css           # Global CSS: Tailwind directives + custom layers
│   └── images/
│       ├── api-doc.png        # Legacy project thumbnails (hardcoded paths)
│       ├── personal-web.png
│       ├── profile-bw.png
│       └── thumbnail-lms.png
│
├── components/                # Vue components (auto-imported by Nuxt)
│   ├── base/                  # Generic, reusable UI primitives
│   ├── education/             # Education domain components
│   ├── experience/            # Experience domain components
│   ├── main/                  # Application-level layout components
│   └── project/               # Project domain components
│
├── composables/               # Vue composables (auto-imported by Nuxt)
│   ├── index.ts               # Empty barrel file
│   ├── projects.ts            # Static project data (HARDCODED)
│   ├── skills.ts              # Static skill-to-icon mapping (HARDCODED)
│   ├── socmeds.ts             # Static social media data (HARDCODED)
│   └── useFormatDate.ts       # Date formatting utility
│
├── layouts/                   # Nuxt layouts
│   ├── default.vue            # Main layout: sidebar profile + nav + content slot
│   └── custom.vue             # Minimal layout (unused — no page references it)
│
├── pages/                     # File-based routing
│   ├── index.vue              # Home/About page
│   ├── projects.vue           # Projects listing
│   ├── experiences.vue        # Experiences + Skills
│   ├── educations.vue         # Education timeline
│   ├── about-me.vue           # Placeholder page ("This is About me")
│   └── indexx.vue             # "Coming Soon" placeholder page
│
├── plugins/                   # Nuxt plugins
│   └── router.ts              # Custom scroll behavior (smooth scroll to hash)
│
├── public/                    # Static files served as-is
│   ├── favicon.ico
│   └── images/
│       ├── icons/             # Social media icon PNGs
│       └── img-porto.png
│
├── server/                    # Server-side code (Nitro)
│   ├── api/                   # API route handlers
│   │   ├── main_content.ts    # GET /api/main_content
│   │   ├── projects.ts        # GET /api/projects
│   │   ├── experiences.ts     # GET /api/experiences
│   │   ├── educations.ts      # GET /api/educations
│   │   └── skills.ts          # GET /api/skills
│   ├── utils/
│   │   └── database.ts        # PostgreSQL connection pool + query helpers
│   └── tsconfig.json          # Server-specific TS config
│
└── stores/                    # Pinia stores
    ├── index.ts               # Global state store (profile data, UI state)
    └── model-store.ts         # TypeScript interfaces ONLY (no Pinia store)
```

## Detailed Folder Analysis

### `pages/` — File-Based Routing

**Responsibility**: Each `.vue` file becomes a route. Nuxt auto-generates routes from this directory.

| File | Route | Status |
|------|-------|--------|
| `index.vue` | `/` | Active — main landing page |
| `projects.vue` | `/projects` | Active |
| `experiences.vue` | `/experiences` | Active |
| `educations.vue` | `/educations` | Active |
| `about-me.vue` | `/about-me` | Placeholder (stub content) |
| `indexx.vue` | `/indexx` | Placeholder ("Coming Soon") |

**What belongs**: Page-level components that compose other components and fetch data.
**What must NOT belong**: Reusable UI primitives, business logic, utility functions.

### `components/` — Vue Components

**Responsibility**: Auto-imported Vue components. Nuxt convention: directory name becomes prefix.

| Directory | Prefix | Contents |
|-----------|--------|----------|
| `base/` | `Base*` | 15 generic UI components (buttons, cards, loaders, accordion, etc.) |
| `main/` | `Main*` | 5 application-level components (nav, project list, skillsets, loaders) |
| `education/` | `Education*` | 1 component (timeline) |
| `experience/` | `Experience*` | 1 component (timeline) |
| `project/` | `Project*` | 1 component (carousel) |

**What belongs**: UI components, domain-specific display components.
**What must NOT belong**: Data fetching, route logic, API calls.

### `composables/` — Composables & Static Data

**Responsibility**: Auto-imported composables and utility functions.

**Critical finding**: This directory contains **both** composable functions AND static hardcoded data arrays. The static data in `projects.ts`, `skills.ts`, and `socmeds.ts` are legacy leftovers — the app now fetches this data from the database.

| File | Purpose | Used By |
|------|---------|---------|
| `index.ts` | Empty barrel file | Nothing (unused) |
| `projects.ts` | Hardcoded project data | `main/project-card.vue` (legacy) |
| `skills.ts` | Skill-to-icon mapping | `main/project-card.vue` (for icon lookup) |
| `socmeds.ts` | Social media links | Nothing (unused — data now in Pinia store) |
| `useFormatDate.ts` | `formatDate()` utility | `education/timeline.vue`, `experience/timeline.vue` |

**What belongs**: Composable functions (functions prefixed with `use`), utility functions.
**What must NOT belong**: Static data arrays, component code, API calls.

### `stores/` — Pinia State Management

**Responsibility**: Global reactive state shared across components.

| File | Contents |
|------|----------|
| `index.ts` | `useStateStore` — profile data (name, job, links), social media animation state |
| `model-store.ts` | TypeScript interfaces only (Language, MainContent, Project, Experience, etc.) |

**What belongs**: Global state definitions, actions, getters.
**What must NOT belong**: UI components, API calls (use composables or server routes).

### `server/api/` — API Route Handlers

**Responsibility**: Server-side endpoints that query the database and return JSON.

| File | Endpoint | Returns |
|------|----------|---------|
| `main_content.ts` | `GET /api/main_content` | About text + specialties + languages |
| `projects.ts` | `GET /api/projects` | Projects + types + images + skills |
| `experiences.ts` | `GET /api/experiences` | Experiences + job types |
| `educations.ts` | `GET /api/educations` | Education records |
| `skills.ts` | `GET /api/skills` | Skills list |

**What belongs**: Event handler functions, database queries, response formatting.
**What must NOT belong**: Business logic that could be shared, client-side code.

### `server/utils/` — Server Utilities

**Responsibility**: Shared server-side utilities.

| File | Purpose |
|------|---------|
| `database.ts` | PostgreSQL connection pool (`getPool()`), `query()`, `queryOne()`, `closePool()` |

**What belongs**: Database helpers, shared server utilities.
**What must NOT belong**: API route handlers, client-side code.

### `layouts/` — Nuxt Layouts

**Responsibility**: Page wrapper components that provide shared structure.

| File | Used | Purpose |
|------|------|---------|
| `default.vue` | Yes (all pages) | Sidebar profile + sticky nav + content slot + footer |
| `custom.vue` | No | Minimal layout with dotted background (appears unused) |

### `assets/` — Processed Static Assets

**Responsibility**: Files processed by the build system (CSS, images referenced in code).

| Path | Purpose |
|------|---------|
| `css/main.css` | Tailwind directives + custom component classes |
| `images/*.png` | Legacy project thumbnails (some appear unused) |

### `public/` — Static Files (Unprocessed)

**Responsibility**: Files served directly without build processing.

| Path | Purpose |
|------|---------|
| `favicon.ico` | Browser tab icon |
| `images/icons/*.png` | Social media icon images used in profile sidebar |
| `images/img-porto.png` | Portfolio image |

### `plugins/` — Nuxt Plugins

**Responsibility**: Extend Nuxt functionality at runtime.

| File | Purpose |
|------|---------|
| `router.ts` | Custom scroll behavior for hash-based navigation (smooth scroll, 30px offset) |
