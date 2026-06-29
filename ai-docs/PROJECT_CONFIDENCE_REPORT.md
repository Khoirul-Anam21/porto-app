# PROJECT_CONFIDENCE_REPORT.md

## Confidence Scores

| Section | Score | Notes |
|---------|-------|-------|
| 01 - Project Overview | 95% | Clear purpose, technology stack well-documented |
| 02 - Architecture | 90% | BFF pattern confirmed; some ambiguity around legacy Directus references |
| 03 - Folder Structure | 95% | All directories and files mapped with evidence |
| 04 - Code Style Guide | 85% | Conventions extracted from code; some inconsistencies noted |
| 05 - Frontend Guide | 90% | Styling, animations, responsive patterns well-documented |
| 06 - Backend Guide | 95% | All API routes and database patterns documented with code |
| 07 - State Management | 90% | Pinia store and data sources clearly analyzed |
| 08 - API Conventions | 90% | Request/response patterns documented; inconsistency noted |
| 09 - Database Guide | 85% | Schema from SQL dump; no FK constraints verified |
| 10 - Reusable Components | 95% | All 21 components documented with props/usage |
| 11 - Business Rules | 85% | Rules extracted from code; some implicit rules may be missed |
| 12 - Security Guide | 80% | Basic security analyzed; no pentest performed |
| 13 - Testing Guide | 95% | Accurately reports: no testing infrastructure exists |
| 14 - Deployment Guide | 90% | Vercel + Docker configs documented |
| 15 - AI Development Rules | 90% | Rules derived from actual patterns in the codebase |
| 16 - Technical Debt | 85% | 16 items identified with evidence |
| 17 - Feature Playbook | 85% | Step-by-step guide based on existing patterns |

**Overall Confidence: 89%**

## Missing Information

1. **Directus CMS details** — The database schema originated from Directus CMS (many `directus_*` tables exist in the SQL dump). The original CMS configuration, collections setup, and Directus-specific field types are not documented here since Directus is no longer in use.

2. **`config.public.apiBase`** — Referenced in `project/project-carousel.vue:48` but not defined in `nuxt.config.ts` runtimeConfig. This appears to be a legacy reference that may be broken. (Inference: this was the old Directus API base URL)

3. **`skills_used` rendering** — In `main/project-list.vue:97-103`, the skills display template is mostly commented out and replaced with empty divs. The feature appears incomplete or broken.

4. **Exact Cloudinary transformation parameters** — The Cloudinary URLs include hash-based transformation strings but the exact transformation configuration is not documented.

5. **`gpa` field in educations** — The `Education` interface includes a `gpa` field that's always `null` in the interface definition. It's queried from the DB but never displayed in the UI.

## Ambiguous Areas

1. **`composables/skills.ts` vs database `skills` table** — The composable contains static skill-to-icon mapping data. It's unclear if this is still actively used or is a leftover from before the database migration. `MainProjectCard` references it, but `MainProjectCard` itself appears unused.

2. **`composables/projects.ts`** — Contains hardcoded project data with `ProjectInterface`. This interface differs from the database `Project` interface. Both exist but it's unclear which is canonical.

3. **Dark mode** — The dark mode toggle is commented out in `layouts/default.vue:76-86`. Tailwind `dark:` classes exist in some components. It's unclear if dark mode is actively supported or abandoned.

4. **`pages/about-me.vue` vs `pages/index.vue`** — Both serve "about" content. `about-me.vue` is a stub, while `index.vue` has the actual about content. The route `/about-me` exists but serves no useful content.

5. **`layouts/custom.vue`** — This layout exists but no page references it. It may be unused or reserved for future use.

## Suggested Manual Review Items

1. **Verify `config.public.apiBase`** — Check if project image carousel works in production. If not, the `project-carousel.vue` component needs the Directus asset URL replaced with Cloudinary or another source.

2. **Test all API endpoints** — Manually verify each endpoint returns data:
   - `GET /api/main_content`
   - `GET /api/projects`
   - `GET /api/experiences`
   - `GET /api/educations`
   - `GET /api/skills`

3. **Review `v-html` content** — Inspect `experience/job_detail` and `project/detail` fields in the database for any potentially unsafe HTML.

4. **Clean up unused files** — Consider removing:
   - `pages/about-me.vue` (stub)
   - `pages/indexx.vue` ("Coming Soon" page)
   - `components/base/basic-btn.vue` (unused)
   - `components/base/rotate-btn.vue` (unused)
   - `layouts/custom.vue` (unused)
   - `composables/socmeds.ts` (unused — data in Pinia)
   - `composables/index.ts` (empty)

5. **Fix `project-carousel.vue`** — Verify image loading works. The `config.public.apiBase` reference may be broken since Directus was removed.

6. **Review error exposure** — The API error responses include `err.message` which could reveal database details in production.

7. **Verify `languanges.level_types` parsing** — The `JSON.parse(language.level_types)` in `components/base/language.vue:15` assumes valid JSON in the database. Verify this doesn't throw at runtime.

8. **Check Docker build** — The Dockerfile uses `pnpm` but `vercel.json` uses `bun`. Verify both build paths work.
