# 01 - Project Overview

## Project Purpose

A personal portfolio website for **Mohammad Khoirul Anam**, a Digital Effectiveness & Web Developer based in Malang, East Java, Indonesia. The site showcases the developer's profile, projects, work experiences, education history, skills, and contact information.

## Main Business Domain

Personal portfolio / CV website. Read-only content management — all data is authored externally (originally via Directus CMS, now directly in PostgreSQL) and served to visitors.

## Application Type

- **SPA** (Single Page Application) — SSR is explicitly disabled (`ssr: false` in `nuxt.config.ts:4`)
- Nuxt 3 framework running in client-side mode
- Server API routes used purely as a backend-for-frontend (BFF) layer

## Technology Stack

| Layer | Technology | Version (approx) |
|-------|-----------|-------------------|
| Framework | Nuxt 3 | ^3.7.1 |
| UI Framework | Vue 3 (Composition API, `<script setup>`) | via Nuxt |
| Language | TypeScript | ^5.2.2 |
| Styling | Tailwind CSS + Scoped CSS | ^3.3.3 |
| State Management | Pinia | ^2.1.6 |
| Database | PostgreSQL (Aiven free tier) | via `pg` ^8.11.3 |
| Animations | AOS (Animate On Scroll) | via nuxt-aos 1.2.5 |
| Image Optimization | @nuxt/image + Cloudinary | ^1.4.0 |
| Analytics | @vercel/analytics + @vercel/speed-insights | ^1.5.0 / ^1.2.0 |
| Lightbox | vue-easy-lightbox | via nuxt-easy-lightbox 1.1.0 |
| Utilities | @vueuse/core | ^10.4.1 |
| Icons | nuxt-icon | ^0.5.0 |
| Performance | nuxt-vitalizer | 2.0.0 |

## Important Dependencies

- **`pg` (node-postgres)**: Raw PostgreSQL client. No ORM is used. All queries are hand-written SQL.
- **`@vueuse/core` + `@vueuse/nuxt`**: Reactive utilities (`useWindowSize`, `useColorMode`).
- **`@nuxt/image`**: Used via `<NuxtImg>` component for optimized image delivery (Cloudinary).
- **`nuxt-aos`**: Scroll-triggered animations.
- **`nuxt-easy-lightbox`**: Image lightbox for project galleries.

## Entry Points

| Entry Point | File | Role |
|-------------|------|------|
| App root | `app.vue` | Wraps everything in `<NuxtLayout>` + `<NuxtPage>` |
| Layout | `layouts/default.vue` | Main layout with sidebar profile + nav + content slot |
| Home page | `pages/index.vue` | About Me, Specialties, Languages |
| Projects | `pages/projects.vue` | Project listing with filtering |
| Experiences | `pages/experiences.vue` | Work experience timeline + skills marquee |
| Education | `pages/educations.vue` | Education timeline |
| Server API | `server/api/*.ts` | 5 API endpoints fetching from PostgreSQL |

## Runtime Flow

```
Browser loads app.vue
  -> NuxtLayout (default.vue)
    -> Profile sidebar (hardcoded in Pinia store)
    -> NavList (4 routes)
    -> Slot renders page (e.g., pages/index.vue)
      -> useLazyFetch("/api/main_content") 
        -> Nuxt server route (server/api/main_content.ts)
          -> query() from server/utils/database.ts
            -> PostgreSQL (Aiven)
          <- Returns JSON
        <- Returns JSON to client
      <- computed() transforms data
      <- Template renders with Tailwind classes + AOS animations
```

## Deployment

- **Primary**: Vercel (configured in `vercel.json` — uses `bun` for build/install)
- **Alternative**: Docker (Dockerfile + docker-compose.yml present)
- Database: Aiven PostgreSQL (free tier, cloud-hosted)

## Key Characteristics

- Read-only application (no user authentication, no write operations)
- No CRUD operations from the frontend
- Content is managed directly in the database (no admin panel)
- All personal data is hardcoded in the Pinia store (`stores/index.ts`)
- Dynamic content (projects, experiences, educations, skills) comes from the database via API
