# 17 - Feature Implementation Playbook

## Step-by-Step: Adding a New Feature

### Example: Add a "Testimonials" Section

---

### Step 1: Database Schema

Create the table in PostgreSQL:
```sql
CREATE TABLE public.testimonials (
    id bigint NOT NULL DEFAULT nextval('testimonials_id_seq'),
    status varchar(255) DEFAULT 'draft' NOT NULL,
    sort bigint,
    date_created timestamptz,
    date_updated timestamptz,
    author varchar(255),
    company varchar(255),
    content text,
    rating bigint
);
```

### Step 2: Server API Route

Create `server/api/testimonials.ts`:
```typescript
import { query } from '~/server/utils/database'

export default defineEventHandler(async (event) => {
  try {
    const testimonials = await query(
      `SELECT id, author, company, content, rating 
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

### Step 3: Type Definition

Add to `stores/model-store.ts`:
```typescript
export interface Testimonial {
    readonly id: number;
    readonly author: string;
    readonly company: string;
    readonly content: string;
    readonly rating: number;
}
```

### Step 4: Component

Create `components/testimonial/card.vue`:
```vue
<script setup lang="ts">
import { type Testimonial } from '../../stores/model-store';

const props = defineProps<{
    testimonial: Testimonial
}>()
</script>

<template>
    <div class="border-2 border-black rounded-2xl p-4 bg-pink-50">
        <p class="text-sm md:text-base">"{{ props.testimonial.content }}"</p>
        <div class="flex items-center gap-2 mt-4">
            <span class="font-bold">{{ props.testimonial.author }}</span>
            <span class="text-sm text-gray-600">- {{ props.testimonial.company }}</span>
        </div>
    </div>
</template>
```

### Step 5: Page

Create `pages/testimonials.vue`:
```vue
<script setup lang="ts">
import { type Testimonial } from '../stores/model-store';

const { status, data, execute } = useLazyFetch("/api/testimonials", { server: false });

const testimonials: Ref<Testimonial[] | null> = computed(() => data.value ? [...data.value] : null);

onMounted(() => execute());
</script>

<template>
    <section class="px-2 md:px-14 lg:px-24 py-8 md:py-11 lg:py-16">
        <div class="flex items-center gap-2 pb-4">
            <h1 class="text-3xl sm:text-4xl md:text-5xl">Testimonials</h1>
            <BaseRoundDecor />
        </div>
        <MainWavyLoader v-if="status !== 'success'" />
        <div v-if="status === 'success'" class="grid gap-4">
            <TestimonialCard v-for="item in testimonials" :key="item.id" :testimonial="item" />
        </div>
    </section>
</template>
```

### Step 6: Navigation (Optional)

Add to `components/main/nav-list.vue`:
```html
<BaseNavBtn name="Testimonials" route="/testimonials" />
```

---

## Checklist for New Features

### Backend
- [ ] SQL table with `status` column (default: `'draft'`)
- [ ] API route in `server/api/<name>.ts`
- [ ] Parameterized query with `WHERE status = $1`
- [ ] Standard try/catch error handling
- [ ] Import `query` from `~/server/utils/database`

### Types
- [ ] Interface in `stores/model-store.ts`
- [ ] Use `readonly` for fields that shouldn't be mutated

### Frontend
- [ ] Page in `pages/<name>.vue`
- [ ] `<script setup lang="ts">` at the top
- [ ] `useLazyFetch` with `server: false`
- [ ] `computed()` transformation
- [ ] `onMounted(() => execute())`
- [ ] Loading state with `<MainWavyLoader v-if="status !== 'success'" />`
- [ ] Content with `v-if="status === 'success'"`
- [ ] Tailwind responsive classes (`sm:`, `md:`, `lg:`)
- [ ] AOS animations where appropriate (`data-aos="fade-up"`)

### Component (if reusable)
- [ ] File: `components/<domain>/<name>.vue`
- [ ] Props with `defineProps<{...}>()`
- [ ] Scoped CSS if needed (`<style scoped>`)
- [ ] PascalCase auto-import name

### Styling
- [ ] Use existing color tokens (`turquoise`, `primary-dark`, etc.)
- [ ] Responsive padding: `px-2 md:px-14 lg:px-24`
- [ ] Border style: `border-2 border-black` (comic theme)
- [ ] Rounded corners: `rounded-2xl`

## Naming Patterns

| Item | Pattern | Example |
|------|---------|---------|
| Page file | `kebab-case.vue` | `testimonials.vue` |
| Component file | `kebab-case.vue` | `card-pulsar.vue` |
| Component name | `PascalCase` prefix | `BaseCardPulsar` |
| API route file | `snake_case.ts` | `main_content.ts` |
| API endpoint | `/api/<name>` | `/api/testimonials` |
| Interface | `PascalCase` | `Testimonial` |
| Props | `camelCase` | `indexColor` |
| State ref | `camelCase` + `Ref` suffix | `testimonialsRef` |
| Computed | `camelCase` | `filteredProjects` |
