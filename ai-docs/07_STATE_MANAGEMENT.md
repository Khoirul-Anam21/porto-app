# 07 - State Management

## Technology: Pinia

**Package**: `pinia` ^2.1.6 with `@pinia/nuxt` ^0.4.11

## Store Structure

### `stores/index.ts` — `useStateStore`

The **only active Pinia store** in the application. Uses the **Options API style** (not setup stores).

```typescript
export const useStateStore = defineStore('state', {
    state: () => ({
        // UI state
        socmedActive: false,       // Social media animation toggle
        socmedIndex: 0,            // Current social media icon index (cycles 0-5)
        timer: null as NodeJS.Timeout | null,
        
        // Profile data (HARDCODED)
        birthDate: new Date('2001-02-21'),
        currentDate: new Date(),
        address: 'Malang, East Java, Indonesia',
        hobby: 'Reading Comics & Photography',
        name: 'Mohammad Khoirul Anam',
        jobPosition: 'Digital Effectiveness & Web Developer',
        
        // Social media URLs (HARDCODED)
        whatsapp_url: 'https://wa.me/6287894524561',
        email_url: 'mailto:khairulanamstud@gmail.com',
        github_url: 'https://github.com/Khoirul-Anam21',
        instagram_url: 'https://www.instagram.com/mohkhoirul_a?igsh=YTFhZXBzMHNiczh2',
        linkedin_url: 'https://www.linkedin.com/in/mohammad-khoirul-anam21/',
    }),
    actions: {
        activateSocmed() { ... },
        wiggleButtons() { ... },
        stopWiggle() { ... }
    }
})
```

**Usage**: Imported in `layouts/default.vue`:
```typescript
const stateStore = useStateStore()
```

**Accessed in template**:
```html
<h1>{{ stateStore.name }}</h1>
<p>{{ stateStore.jobPosition }}</p>
<a :href="stateStore.whatsapp_url">...</a>
```

### `stores/model-store.ts` — Type Definitions Only

**This is NOT a Pinia store.** It contains only TypeScript `interface` exports used across the codebase:

```typescript
export interface Language { ... }
export interface Level { ... }
export interface MainContent { ... }
export interface ProjectType { ... }
export interface Education { ... }
export interface ProjectFiles { ... }
export interface Specialty { ... }
export interface Experience { ... }
export interface ExperienceType { ... }
export interface ExperienceDetail { ... }
export interface Project { ... }
export interface Skill { ... }
```

**Imported by**: Pages and components that need type annotations for API data.

## Update Patterns

### Direct State Mutation (Pinia)

```typescript
// layouts/default.vue — direct state mutation in watcher
watch(stateStore.$state, (newV, oldV) => {
    if (!newV.socmedActive) return
    setTimeout(() => {
        if (stateStore.$state.socmedIndex === 5) {
            stateStore.$state.socmedIndex = 0
            return;
        }
        stateStore.$state.socmedIndex++
    }, 1000);
});
```

### Actions

```typescript
// Defined but appear to be legacy/unused — the watcher in default.vue 
// does the same thing directly
activateSocmed() {
    this.$state.socmedActive = !this.$state.socmedActive;
}
stopWiggle() {
    clearTimeout(this.timer as NodeJS.Timeout);
    this.$state.socmedActive = false;
    this.$state.socmedIndex = 0;
}
```

## Data Architecture

```
┌─────────────────────────────────────────┐
│           DATA SOURCES                   │
├──────────────────┬──────────────────────┤
│  HARDCODED       │  DATABASE (via API)  │
├──────────────────┼──────────────────────┤
│  Pinia Store     │  useLazyFetch()      │
│  - Profile info  │  - Main content      │
│  - Social links  │  - Projects          │
│  - Personal data │  - Experiences       │
│                  │  - Educations        │
├──────────────────┼──────────────────────┤
│  Composables     │                      │
│  - projects.ts   │                      │
│  - skills.ts     │                      │
│  - socmeds.ts    │                      │
└──────────────────┴──────────────────────┘
```

**Key observation**: The project has a **hybrid data architecture**. Profile/personal data is hardcoded in the Pinia store, while content data (projects, experiences, etc.) comes from the database. Some composable data files (`projects.ts`, `skills.ts`) appear to be legacy leftovers that may no longer be actively used.

## Async Handling

**No async actions in Pinia.** All async data fetching happens in page components via `useLazyFetch()`:

```typescript
// Page-level pattern (repeated in every page)
const { status, data, execute } = useLazyFetch("/api/endpoint", { server: false });
const items = computed(() => data.value ? [...data.value] : null);
onMounted(() => execute());
```

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Store definition | `defineStore('id', { ... })` | `defineStore('state', { ... })` |
| Store export | `use[Name]Store` | `useStateStore` |
| State properties | camelCase | `socmedActive`, `birthDate` |
| Actions | camelCase | `activateSocmed`, `wiggleButtons` |
| Interfaces | PascalCase | `Language`, `MainContent` |
