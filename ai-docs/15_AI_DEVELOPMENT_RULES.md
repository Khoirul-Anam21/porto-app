# 15 - AI Development Rules

## Critical Rules

1. **SSR is disabled** — All client code runs in the browser. Never assume server-side rendering.
2. **No ORM** — Use raw SQL with parameterized queries (`$1`, `$2` placeholders). Never concatenate strings into SQL.
3. **Server credentials stay server-side** — Database credentials are in `runtimeConfig` (not `public`). Never expose them to client code.
4. **Query only published content** — Always add `WHERE status = 'published'` to queries.
5. **Reuse existing components** — Check `components/base/` and `components/main/` before creating new ones.

## Component Rules

6. **Component naming**: `kebab-case.vue` files, `PascalCase` prefix based on directory (`Base*`, `Main*`, `Education*`, `Experience*`, `Project*`).
7. **Use `<script setup lang="ts">`** — Composition API with TypeScript only. No Options API.
8. **Props via `defineProps<{...}>()`** — TypeScript generics, no runtime validation.
9. **Scoped CSS** — Use `<style scoped>` for component-specific styles.
10. **Tailwind first** — Use Tailwind utility classes. Only use scoped CSS for animations/complex styles Tailwind can't express.

## Data Fetching Rules

11. **Use `useLazyFetch` with `server: false`** for all API calls.
12. **Follow the standard pattern**:
    ```typescript
    const { status, data, execute } = useLazyFetch("/api/endpoint", { server: false });
    const items = computed(() => data.value ? [...data.value] : null);
    onMounted(() => execute());
    ```
13. **Show loader while pending** — Use `<MainWavyLoader v-if="status !== 'success'" />`.
14. **Check status before rendering** — `v-if="status === 'success'"` on content.

## API Route Rules

15. **One file per endpoint** in `server/api/`.
16. **Import `query` from `~/server/utils/database`**.
17. **Wrap in try/catch** — Follow the standard error handling pattern with `createError()`.
18. **Use parameterized queries** — Never interpolate user input into SQL strings.

## State Management Rules

19. **Profile data is hardcoded** in `stores/index.ts`. Don't move it to the database unless asked.
20. **New global state** → Pinia store in `stores/`.
21. **New types/interfaces** → `stores/model-store.ts`.
22. **Page-level state** → `ref()` or `computed()` in the page component.

## Styling Rules

23. **Use existing custom colors**: `turquoise`, `light-turquoise`, `dark-turquoise`, `primary-dark`, `primary-light`, `accent-color`.
24. **Use existing animations**: `animate-loop-scroll-up`, `animate-loop-scroll-down`, `animate-rotate`.
25. **AOS for scroll animations** — Use `data-aos`, `data-aos-duration`, `data-aos-delay` attributes.
26. **Responsive prefixes** — Always use `sm:`, `md:`, `lg:` for responsive design.

## File Organization Rules

27. **Pages** go in `pages/` (become routes automatically).
28. **Reusable UI** goes in `components/base/`.
29. **App-specific components** go in `components/main/`.
30. **Domain components** go in `components/<domain>/`.
31. **Server utilities** go in `server/utils/`.
32. **Type definitions** go in `stores/model-store.ts`.

## Forbidden Patterns

33. **Don't add a new dependency** unless absolutely necessary. Use existing deps (`@vueuse`, `pg`, Tailwind).
34. **Don't use Options API** — Always Composition API with `<script setup>`.
35. **Don't hardcode secrets** — Use `runtimeConfig` for any sensitive values.
36. **Don't use `v-html` with untrusted content** — Only use with known-safe database content.
37. **Don't add comments** unless explicitly asked.
38. **Don't create abstract interfaces with one implementation** — YAGNI.
39. **Don't create factory patterns** — Direct instantiation is fine.
40. **Don't add boilerplate** — Only write code that is needed now.

## Quick Reference

| Need | Where |
|------|-------|
| New page/route | `pages/<name>.vue` |
| New reusable component | `components/base/<name>.vue` |
| New domain component | `components/<domain>/<name>.vue` |
| New API endpoint | `server/api/<name>.ts` |
| New type/interface | `stores/model-store.ts` |
| New global state | `stores/<name>.ts` (Pinia store) |
| New utility function | `composables/<name>.ts` |
| Database query | `server/api/*.ts` using `query()` |
| Date formatting | `formatDate()` from `composables/useFormatDate.ts` |
