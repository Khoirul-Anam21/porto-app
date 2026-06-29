# 05 - Frontend Guide

## Styling Approach

### Tailwind CSS (Primary)

The project uses **Tailwind CSS 3.3** as the primary styling system.

**Configuration**: `tailwind.config.js`

```javascript
// Custom colors defined in tailwind.config.js
colors: {
    'primary-dark': '#2C2D32',
    'primary-light': '#FFFFFF',
    'turquoise': '#30D5C8',
    'light-turquoise': '#D4FFFC',
    'dark-turquoise': '#06768D',
    'accent-color': '#F0BF6C'
}

// Custom animations
animation: {
    'loop-scroll-up': 'loop-scroll-up 60s linear infinite',
    'loop-scroll-down': 'loop-scroll-down 60s linear infinite',
    'rotate': 'rotate 1s linear',
    'rotateback': 'rotateback 1s linear',
    'horizontalBounce': 'horizontalBounce 1s ease-out infinite',
}
```

**Evidence**: `tailwind.config.js:49-56` for colors, `tailwind.config.js:42-48` for animations.

### Global CSS

**File**: `assets/css/main.css`

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
    html { @apply scroll-smooth }
    h1 { @apply text-black }
    h2 { @apply text-black }
}

@layer components {
    .highlight-text { @apply text-turquoise }
    .primary-btn { @apply bg-dark-turquoise text-primary-light px-4 py-2 shadow-lg dark:border dark:border-turquoise dark:bg-primary-dark dark:shadow-none }
    .side-btn { @apply bg-white text-dark-turquoise border-2 border-slate-900 }
}

@layer utilities {
    .paused { animation-play-state: paused; }
}
```

### Scoped CSS

Used alongside Tailwind for complex animations and custom styles that are hard to express with utilities:

```vue
<style scoped>
/* Examples from actual components */

/* Timeline dashed line (experience/timeline.vue) */
.timeline-custom-line {
    background-image: url("data:image/svg+xml,...");
}

/* Smooth button hover effect (base/smooth-btn.vue) */
.comic-button { box-shadow: 3px 3px 0px #000; }
.comic-button:hover { box-shadow: 5px 5px 0px #ff5252; }
.comic-button:active { background-color: #fcf414; }

/* No-scrollbar utility (repeated in multiple components) */
.no-scrollbar::-webkit-scrollbar { display: none; }
.no-scrollbar { -ms-overflow-style: none; scrollbar-width: none; }

/* Container background (layouts/default.vue) */
.container-bg {
    background-color: yellow;
    background-image: radial-gradient(#7D7D7D 1px, #fbfbfb 1px);
    background-size: 30px 30px;
}
</style>
```

### Typography

- Uses `@tailwindcss/typography` plugin for prose styling (`prose`, `prose-slate`, `dark:prose-invert`)
- Font family: `Helvetica, Arial, sans-serif` (set in `tailwind.config.js:58`)
- Used in `experience/timeline.vue:38` and `main/project-list.vue:107` for rendering HTML content

## Responsive Strategy

**Approach**: Mobile-first with Tailwind responsive prefixes (`sm:`, `md:`, `lg:`).

**Breakpoint usage pattern** (from `layouts/default.vue`):
```html
<div class="px-5 sm:px-24 py-8 sm:py-28">         <!-- mobile → desktop padding -->
<div class="flex flex-col md:flex-row-reverse">     <!-- stack → side-by-side -->
<div class="w-full md:basis-1/3">                   <!-- full width → fixed sidebar -->
```

**Window size detection** (for conditional behavior, not just styling):
```typescript
// layouts/default.vue
const { width } = useWindowSize()
// Used for profile sheet toggle at < 768px
if (width.value < 768) { profileSheetOpen.value = !profileSheetOpen.value }
```

**CSS media queries** (for cases Tailwind can't handle):
```css
/* experiences.vue - vertical text only on desktop */
.text-vertical { writing-mode: horizontal-tb }
@media (min-width: 800px) { .text-vertical { writing-mode: vertical-rl } }
```

## Animations

### AOS (Animate On Scroll)

Heavily used throughout the app via `nuxt-aos` module:

```html
<!-- Standard AOS usage -->
<p data-aos="fade-up" data-aos-duration="1000">...</p>
<h1 data-aos="fade-left" :data-aos-delay="index * 100" data-aos-duration="600">...</h1>

<!-- Timeline animations with dynamic duration -->
<div data-aos="zoom-in-up" :data-aos-duration="mainDuration + (keyIndex * 200)">
```

**AOS animation types used**: `fade-up`, `fade-left`, `zoom-in-up`

### CSS Keyframe Animations

```html
<!-- Infinite scroll marquee (main/skillsets.vue) -->
<div class="animate-loop-scroll-up group-hover:paused">
<div class="animate-loop-scroll-down group-hover:paused">
```

```html
<!-- Toggle rotation (layouts/default.vue) -->
<div :class="{ 'animate-rotate': isDark, 'animate-rotateback': !isDark }">
```

### CSS Transitions

```html
<!-- Smooth transitions on interactive elements -->
<div class="transform-gpu transition-all ease-out duration-[600ms]">
<div class="transform-gpu transition-all duration-200 delay-200">
```

## Image Handling

### NuxtImg Component

```html
<!-- Profile image (Cloudinary) -->
<NuxtImg class="rounded-full w-[120px] h-[120px] object-cover"
    format="webp"
    src="https://res.cloudinary.com/dj8gvk6wr/image/upload/..." />

<!-- Dynamic image from config -->
<NuxtImg :src="`${config.public.education_icon}`" class="w-[40px]" />

<!-- Static public image -->
<NuxtImg src="images/icons/icons8-whatsapp-48.png" />
```

**Cloudinary base URL**: `https://res.cloudinary.com/dj8gvk6wr/image/upload/`

### Image Sources

| Source | Usage |
|--------|-------|
| Cloudinary URLs | Profile photo, experience/education icons (via runtimeConfig) |
| Database | Project images (via `projects_files` table → Directus file IDs) |
| Public directory | Social media icons |

**Note**: Project images still reference `config.public.apiBase` (Directus) which appears to be a legacy reference. See `project/project-carousel.vue:48`.

## Form Handling

**No forms exist in the application**. This is a read-only portfolio. The only interactive elements are:

- Navigation buttons (`BaseNavBtn`)
- Accordion toggles (`BaseAccordionItem`)
- Option/radio buttons (`BaseOption` for project filtering)
- Social media links (plain `<a>` tags)
- Download CV button (opens Google Docs link)

## Component Composition Patterns

### Slot Pattern (Base Components)

```vue
<!-- BaseCardPulsar exposes slot data -->
<slot :textStyle="textStyles[numIndex]"></slot>

<!-- Consumer uses scoped slot -->
<BaseCardPulsar v-for="(item, index) in content.specialties" :index-color="index">
    <template v-slot="{ textStyle }">
        <div :class="textStyle">...</div>
    </template>
</BaseCardPulsar>
```

### Provide/Inject Pattern (Accordion)

```vue
<!-- Parent: BaseAccordion provides state -->
provide('activeItemId', activeItemId);

<!-- Child: BaseAccordionItem injects state -->
const activeItemId = inject('activeItemId') as Ref<number>;
```

### Lazy Loading Pattern

```html
<!-- LazyBaseLanguage — component loaded only when visible -->
<LazyBaseLanguage v-for="(item, index) in content.languages" :language="item" />
```

## Layout System

The default layout (`layouts/default.vue`) implements a **two-column responsive layout**:

```
┌──────────────────────────────────────────────────┐
│  Mobile: Profile (top, collapsible) + Content    │
├──────────────────────────────────────────────────┤
│  Desktop: Content (left 2/3) | Profile (right 1/3)│
└──────────────────────────────────────────────────┘
```

**Key features**:
- Profile sidebar is **sticky** on desktop (`md:sticky top-16`)
- Nav list is **sticky** at top (`sticky top-10 z-50`)
- Profile sheet is **collapsible on mobile** with height animation
- Content area has a **border + rounded corners + white background**
- Background has a **dotted pattern** on yellow (`container-bg`)
