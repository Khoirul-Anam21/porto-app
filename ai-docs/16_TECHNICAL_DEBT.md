# 16 - Technical Debt

## Duplicated Logic

### 1. No-Scrollbar CSS (3 locations)
**Files**: `components/base/option.vue:55-63`, `components/main/nav-list.vue:38-45`, `components/project/project-carousel.vue:63-74`

```css
/* Exact same code repeated in 3 components */
.no-scrollbar::-webkit-scrollbar { display: none; }
.no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }
```

**Fix**: Move to `assets/css/main.css` as a Tailwind utility class.

### 2. Container Background CSS (2 locations)
**Files**: `layouts/default.vue:188-194`, `layouts/custom.vue:11-17`

```css
.container-bg {
    background-color: yellow;
    background-image: radial-gradient(#7D7D7D 1px, #fbfbfb 1px);
    background-size: 30px 30px;
}
```

**Fix**: Extract to shared CSS or Tailwind config.

### 3. Client-Side Sort Override
**Files**: `pages/experiences.vue:41`, `pages/educations.vue:26`

```typescript
// Both pages sort DESC on client despite server sorting ASC
experiences?.sort((a, b) => b.sequence - a.sequence)
educations?.sort((a, b) => b.sequence - a.sequence)
```

**Fix**: Sort in SQL (`ORDER BY sequence DESC`) and remove client-side sort.

## Anti-Patterns

### 4. Dual Data Sources
- **Hardcoded**: Profile data in `stores/index.ts`, static data in `composables/projects.ts`, `composables/skills.ts`, `composables/socmeds.ts`
- **Database**: Same categories of data fetched via API routes

**Risk**: Data can become out of sync. The `composables/projects.ts` data and `stores/model-store.ts` `ProjectInterface` are legacy leftovers from the Directus migration.

### 5. Console.log in Production Code
**Files**: All `server/api/*.ts`, `pages/index.vue:7`, `pages/projects.vue:6`

```typescript
console.log('📡 Fetching main content...')
console.log(data) // pages/index.vue
```

**Fix**: Remove or replace with a proper logger with log levels.

### 6. Exposed Error Details
**Files**: All `server/api/*.ts`

```typescript
throw createError({
    statusCode: 500,
    data: {
        message: err.message,  // Exposes DB error to client
        hint: 'Check .env.local...'
    }
})
```

**Fix**: Return generic error in production; log details server-side only.

## Large / Overloaded Files

### 7. `layouts/default.vue` (208 lines)
Contains:
- Profile sidebar rendering (120+ lines of template)
- Dark mode toggle logic (commented out)
- Profile sheet collapse/expand logic
- Social media animation watcher
- Age calculation
- CV download handler

**Recommendation**: Extract profile sidebar into `components/main/profile-sidebar.vue`.

### 8. `components/main/project-list.vue` (127 lines)
Contains:
- Category filtering logic
- Image lightbox state management
- Scroll lock management
- Project data transformation

**Recommendation**: Extract filtering logic into a composable.

## Inconsistencies

### 9. API Response Shape
- `educations` and `skills` return flat arrays
- `projects` and `experiences` return `{ types, data }` objects

**Fix**: Standardize all endpoints to return `{ data: [...], types: [...] }` or all flat arrays.

### 10. Interface Naming
- `model-store.ts`: `Language`, `Project`, `Experience` (no suffix)
- `composables/`: `ProjectInterface`, `SkillInterface`, `SocmedInterface` (with `Interface` suffix)

**Fix**: Use consistent naming — prefer no suffix (the dominant pattern).

### 11. Table Name Typo
The `languanges` table is misspelled (should be `languages`). This is a legacy Directus schema issue.

### 12. Unused Files
- `components/base/basic-btn.vue` — not used in any page
- `components/base/rotate-btn.vue` — not used in any page
- `composables/index.ts` — empty barrel file
- `composables/socmeds.ts` — not used (data is in Pinia store)
- `layouts/custom.vue` — no page references this layout
- `pages/about-me.vue` — placeholder ("This is About me")
- `pages/indexx.vue` — placeholder ("Coming Soon")

## Potential Refactoring Opportunities

### 13. Extract `queryOne()` Usage
`queryOne()` is defined in `server/utils/database.ts` but never used. Either use it where appropriate or remove it.

### 14. N+1 Query Pattern in Projects
`server/api/projects.ts` fetches images and skills separately, then joins in JS. For small datasets this is fine, but a SQL JOIN would be more efficient.

### 15. Hardcoded Cloudinary URLs
Profile photo URL and social media icon URLs are hardcoded in components. These could be moved to `runtimeConfig.public` for consistency with experience/education icons.

### 16. Commented-Out Code
Multiple components contain commented-out code blocks:
- `layouts/default.vue:76-86` — dark mode toggle
- `components/project/project-carousel.vue:43-44, 52-54, 57-59` — carousel navigation
- `components/base/option.vue:29-34` — additional option items
- `components/main/project-list.vue:59-62, 100-101` — image display
