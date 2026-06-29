# 04 - Code Style Guide

## Naming Conventions

### File Naming

| Type | Convention | Examples |
|------|-----------|----------|
| Vue Components | `kebab-case.vue` | `card-pulsar.vue`, `nav-list.vue`, `wavy-loader.vue` |
| Composables | `camelCase.ts` or `usePrefix.ts` | `useFormatDate.ts`, `projects.ts` |
| Stores | `kebab-case.ts` or `index.ts` | `model-store.ts`, `index.ts` |
| Server API routes | `snake_case.ts` | `main_content.ts`, `project_types` (in DB) |
| Server utilities | `camelCase.ts` | `database.ts` |

### Component Naming

Components use **PascalCase** in templates (auto-imported by Nuxt):

```html
<!-- Prefix convention based on directory -->
<BaseRoundDecor />      <!-- components/base/round-decor.vue -->
<BaseCardPulsar />      <!-- components/base/card-pulsar.vue -->
<BaseSmoothBtn />       <!-- components/base/smooth-btn.vue -->
<BaseNavBtn />          <!-- components/base/nav-btn.vue -->
<BaseLanguage />        <!-- components/base/language.vue -->
<BaseChip />            <!-- components/base/chip.vue -->
<BaseAccordion />       <!-- components/base/accordion.vue -->
<BaseAccordionItem />   <!-- components/base/accordion-item.vue -->
<MainNavList />         <!-- components/main/nav-list.vue -->
<MainWavyLoader />      <!-- components/main/wavy-loader.vue -->
<MainSkillsets />       <!-- components/main/skillsets.vue -->
<MainProjectList />     <!-- components/main/project-list.vue -->
<EducationTimeline />   <!-- components/education/timeline.vue -->
<ExperienceTimeline />  <!-- components/experience/timeline.vue -->
<ProjectCarousel />     <!-- components/project/project-carousel.vue -->
```

**Prefix mapping**:
- `base/` → `Base*`
- `main/` → `Main*`
- `education/` → `Education*`
- `experience/` → `Experience*`
- `project/` → `Project*`

### Variable Naming

```typescript
// Refs — camelCase
const visibleRef = ref(false)
const imagesRef = ref<string[]>([])
const tabIndex = ref<number | null>(null)

// Computed — camelCase
const content = computed(() => ...)
const projectData = computed(() => ...)

// Props — camelCase in defineProps
const props = defineProps<{
    indexColor: number     // camelCase
    education: Education   // camelCase
}>()

// Functions — camelCase
const openProfileSheet = () => { ... }
const toggleCollapse = () => { ... }
const updateHeight = () => { ... }

// Interfaces — PascalCase
interface ProjectInterface { ... }
interface SkillInterface { ... }
interface SocmedInterface { ... }
```

### Store Naming

```typescript
// Pinia store — camelCase with 'Store' suffix
export const useStateStore = defineStore('state', { ... })

// Store ID — lowercase string
defineStore('state', { ... })
```

### Type/Interface Naming

```typescript
// Interfaces — PascalCase, no 'I' prefix
export interface Language { ... }
export interface MainContent { ... }
export interface Project { ... }
export interface Experience { ... }
export interface Skill { ... }
export interface Education { ... }

// Exception: some composables use 'Interface' suffix
export interface ProjectInterface { ... }
export interface SkillInterface { ... }
export interface SocmedInterface { ... }
```

**Note**: There is an inconsistency — `model-store.ts` uses plain PascalCase (`Language`, `Project`), while composables use `Interface` suffix (`ProjectInterface`, `SkillInterface`). The `model-store.ts` pattern is the dominant one.

### Template Style

- Vue 3 Composition API with `<script setup lang="ts">` exclusively
- Props defined with `defineProps<{...}>()` (TypeScript generics, no runtime validation)
- Emits defined with `defineEmits<{}>()` or `defineEmits(['event-name'])`
- `v-if` used for conditional rendering (not `v-show`)
- `v-for` always includes `:key`
- Event handlers: `@click="handler"`, `@click="$emit('clicked')"`

### CSS/Scoped Styles

```vue
<!-- Tailwind utility classes preferred -->
<div class="px-8 md:px-14 lg:px-24 py-8 md:py-11 lg:py-16">

<!-- Scoped CSS used for complex animations/styles -->
<style scoped>
.timeline-custom-line {
    height: 100%;
    width: 4px;
    background-image: url("data:image/svg+xml,...");
}
</style>
```

### Import Style

```typescript
// Type imports — explicit `type` keyword
import { type MainContent } from '../stores/model-store'
import { type Project, type ProjectType } from '../stores/model-store'

// Composable imports — named export
import formatDate from '../../composables/useFormatDate'

// Nuxt auto-imports — NO import needed for:
// - ref, computed, watch, onMounted, nextTick
// - useRoute, useRouter, useRuntimeConfig, useColorMode
// - useLazyFetch, useFetch
// - definePageMeta (if used)
```

## Code Patterns

### Data Fetching Pattern (Pages)

Every page follows this exact pattern:

```typescript
// 1. Fetch with useLazyFetch (client-side only: server: false)
const { status, data, execute } = useLazyFetch("/api/endpoint", { server: false });

// 2. Transform with computed
const items: Ref<Type[] | null> = computed(() => data.value ? [...data.value] : null);

// 3. Execute on mount
onMounted(() => execute());
```

### Component Props Pattern

```typescript
// Always TypeScript generics, no default values
const props = defineProps<{
    education: Education
}>()

// Access via props.education in template
<p>{{ props.education.institution }}</p>
```

### Error Handling Pattern (Server)

```typescript
// Every API route follows this:
export default defineEventHandler(async (event) => {
  try {
    const data = await query(...)
    return data
  } catch (err: any) {
    console.error('❌ Failed to fetch ...')
    throw createError({
      statusCode: 500,
      statusMessage: 'Database Error',
      data: { message: err.message, hint: '...' }
    })
  }
})
```
