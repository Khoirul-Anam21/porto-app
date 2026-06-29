# 11 - Business Rules

## Content Publishing Rules

### Status Filter
Every database query filters by `status = 'published'`:
- Only published content is displayed to visitors
- Default status for new records is `'draft'` (per table column defaults)
- No draft/preview mode exists in the frontend

**Evidence**: All API queries use `WHERE status = $1` with `['published']`.

### Display Ordering
Content ordering follows these rules:
- **Specialties, Skills, Languages**: `ORDER BY sort ASC` (ascending — lowest first)
- **Projects**: `ORDER BY sort DESC` (descending — highest/most recent first)
- **Experiences**: `ORDER BY sequence ASC` in SQL, but **client-side sorts DESC** (`experiences?.sort((a, b) => b.sequence - a.sequence)`)
- **Educations**: `ORDER BY sequence ASC` in SQL, but **client-side sorts DESC** (`educations?.sort((a, b) => b.sequence - a.sequence)`)

**Inconsistency**: Server sorts ASC but client reverses to DESC for experiences and educations. This means the server-side sort is wasted work.

## Profile Display Rules

### Age Calculation
```typescript
// layouts/default.vue
const age = computed(() => {
    const rangeDate = new Date(stateStore.currentDate.valueOf() - stateStore.birthDate.valueOf());
    const ageNum = rangeDate.getUTCFullYear() - 1970
    return ageNum;
})
```
- Birth date: `2001-02-21` (hardcoded)
- Current date: `new Date()` (re-evaluated at runtime)
- Displayed as: `"${age} y.o"` in profile sidebar

### Profile Sheet Behavior
- On mobile (< 768px): Profile is a collapsible bottom sheet
- On desktop (>= 768px): Profile is a sticky sidebar
- Sheet toggles open/closed on mobile tap
- Height is dynamically calculated from `scrollHeight`

## Social Media Animation

A cycling animation rotates through social media icons:
- Index cycles 0 → 5 → 0 (wraps at 5)
- 1-second interval per icon
- Triggered by `socmedActive` state in Pinia store
- Currently only the profile page watcher implements this

## Navigation Rules

4 hardcoded routes:
| Route | Name | Page |
|-------|------|------|
| `/` | About Me | `pages/index.vue` |
| `/projects` | Projects | `pages/projects.vue` |
| `/experiences` | Experiences & Skills | `pages/experiences.vue` |
| `/educations` | Educations | `pages/educations.vue` |

**Evidence**: `components/main/nav-list.vue:11-14`

## Content Display Rules

### Data Availability Check
Every page checks `status === 'success'` before rendering content:
```html
<MainWavyLoader v-if="status !== 'success'" />
<div v-if="status === 'success'">...</div>
```

### Empty State Handling
- No explicit empty state handling
- If no data exists, content areas are simply not rendered
- The "null" computed pattern provides fallback: `data.value ? [...] : null`

### HTML Content Rendering
Experience and project details contain HTML that is rendered with `v-html`:
```html
<div v-html="props.experience.job_detail" class="prose prose-slate ...">
</div>
```
- Uses `@tailwindcss/typography` prose classes for styling
- Content comes from the database — author must ensure it's safe HTML

### Date Display
- Dates displayed as "Month Year" (e.g., "January 2024")
- End dates: if null, displays "Now" (indicating current/present)
- Format: `formatDate(date) → "Month YYYY"`

## Project Filtering

- Projects can be filtered by type using `BaseOption` radio buttons
- "All" option shows all projects (tabIndex = 0)
- Selecting a type filters by `project.type === tabIndex`
- Types come from `project_types` database table

## CV Download

```typescript
const downloadCV = () => {
    window.open('https://docs.google.com/document/d/1B09vjlvs6BRPIiXFsgUlOEos6JMNCoZjHxe3PVf8WVA/edit?usp=sharing', '_blank');
}
```
- Opens external Google Document in new tab
- Hardcoded URL

## Image Handling Rules

### Profile Image
- Served from Cloudinary: `https://res.cloudinary.com/dj8gvk6wr/image/upload/...`
- Fixed dimensions: 120px mobile, 200px desktop
- `object-cover` for consistent sizing

### Project Images
- Stored in `projects_files` table with Directus file IDs
- Referenced via `config.public.apiBase` (may be legacy)
- Displayed in carousel with lightbox on click

### Experience/Education Icons
- Served from Cloudinary URLs stored in `runtimeConfig.public`
- Fixed 40-48px width

## Scroll Behavior

Custom scroll behavior defined in `plugins/router.ts`:
- Smooth scrolling to hash targets
- 30px offset from top
- Only applies to hash-based navigation
