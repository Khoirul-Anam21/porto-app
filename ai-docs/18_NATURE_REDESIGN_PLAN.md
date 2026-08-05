# Portfolio v2: Paper-Cut Nature Evolution

## Philosophy

**Evolve, don't rebuild.** Your current portfolio has strong information architecture. This plan preserves what works while layering in paper-cut aesthetics and GSAP enhancements.

**Goals:**
1. Preserve current navigation, layout, and content structure
2. Replace flat cards with layered paper components
3. Add handcrafted paper landscape that changes subtly between sections
4. Use GSAP to enhance interactions rather than dominate
5. Use paper-cut style for unique identity without sacrificing readability

---

## What We're Keeping

| Element | Why Keep |
|---------|----------|
| Sidebar profile layout | Works well, recognizable |
| Horizontal nav scroll | Functional on mobile |
| Accordion project items | Good UX for long content |
| Timeline experiences | Clear information hierarchy |
| Data flow (useLazyFetch) | Already solved |
| Pinia store structure | Already solved |
| Responsive breakpoints | Already working |

---

## Phase 1: Foundation — Paper Theme Tokens

### 1.1 Tailwind Config Update

**File:** `tailwind.config.js`

**New Colors (paper/nature palette):**
```javascript
colors: {
  // Paper tones
  'paper': '#F8F4EC',           // Main background (warm off-white)
  'paper-dark': '#EDE8DE',      // Slightly darker
  'paper-shadow': '#E8E0D0',    // Shadow tone
  'paper-edge': '#D4C9B8',      // Edge/depth tone
  
  // Nature accents
  'leaf': '#6B8F3C',            // Primary green
  'leaf-dark': '#4A6B28',       // Dark green
  'leaf-light': '#A8C97A',      // Light green
  'bark': '#5C4033',            // Brown (text)
  'bark-light': '#8B7355',      // Light brown
  'sky': '#87CEEB',             // Soft blue
  'sky-light': '#B8E2F8',       // Light blue
  'sunlight': '#F4D03F',        // Golden accent
  'sunlight-light': '#F9E79F',  // Light gold
  
  // Keep existing for backward compat
  'turquoise': '#30D5C8',
  'primary-dark': '#2C2D32',
  'primary-light': '#FFFFFF',
}
```

**New Shadows (paper depth):**
```javascript
boxShadow: {
  'paper': '0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.08)',
  'paper-md': '0 4px 6px rgba(0,0,0,0.1), 0 2px 4px rgba(0,0,0,0.06)',
  'paper-lg': '0 10px 15px rgba(0,0,0,0.1), 0 4px 6px rgba(0,0,0,0.05)',
  'paper-hover': '0 14px 28px rgba(0,0,0,0.12), 0 10px 10px rgba(0,0,0,0.08)',
}
```

### 1.2 Global CSS Updates

**File:** `assets/css/main.css`

**Add paper utility classes:**
```css
@layer components {
  .paper-card {
    @apply bg-paper rounded-2xl shadow-paper transition-all duration-300;
    background-image: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, transparent 100%);
  }
  
  .paper-card:hover {
    @apply shadow-paper-lg;
    transform: translateY(-2px);
  }
  
  .paper-edge {
    position: relative;
  }
  
  .paper-edge::after {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: inherit;
    box-shadow: inset 0 2px 4px rgba(0,0,0,0.06);
    pointer-events: none;
  }
  
  .paper-btn {
    @apply px-6 py-2 rounded-full font-medium transition-all duration-200;
    background: linear-gradient(135deg, #6B8F3C 0%, #4A6B28 100%);
    color: white;
    box-shadow: 0 2px 8px rgba(107, 143, 60, 0.3);
  }
  
  .paper-btn:hover {
    box-shadow: 0 4px 12px rgba(107, 143, 60, 0.4);
    transform: translateY(-1px);
  }
  
  .paper-btn:active {
    transform: translateY(1px);
    box-shadow: 0 1px 4px rgba(107, 143, 60, 0.3);
  }
  
  .paper-chip {
    @apply px-4 py-1 rounded-full text-sm font-medium;
    background: #F0EDE5;
    border: 1px solid #D4C9B8;
    color: #5C4033;
  }
}
```

---

## Phase 2: Layout Evolution

### 2.1 Layout Refinements (Not Rebuild)

**File:** `layouts/default.vue`

**Changes:**
1. Replace `container-bg` (yellow dots) → paper texture background
2. Keep sidebar structure, update styling
3. Add nature illustration placeholders (Phase 5)

**Paper background CSS:**
```css
.paper-bg {
  background-color: #F8F4EC;
  background-image: 
    radial-gradient(circle at 20% 80%, rgba(107, 143, 60, 0.05) 0%, transparent 50%),
    radial-gradient(circle at 80% 20%, rgba(135, 206, 235, 0.05) 0%, transparent 50%),
    url("data:image/svg+xml,..."); /* subtle paper grain */
  background-size: 200px 200px;
}
```

### 2.2 Sidebar Evolution

**Keep:** Structure, data, responsiveness
**Change:** Styling

| Before | After |
|--------|-------|
| `border-4 border-black` | `shadow-paper` |
| `bg-white` | `bg-paper` |
| Sharp corners | Same rounded, softer feel |
| Thick shadows | Layered paper shadows |

### 2.3 Content Area Evolution

**Keep:** Sticky nav, content slot, footer
**Change:** Card styling

```html
<!-- BEFORE -->
<section class="border-4 border-black border-opacity-85 rounded-2xl p-4 bg-white">

<!-- AFTER -->
<section class="paper-card paper-edge p-6">
```

---

## Phase 3: Component Evolution

### 3.1 Base Components — Paper Style

#### `smooth-btn.vue`

**Current:** Comic button with offset shadow
**New:** Paper button with subtle depth

```css
.comic-button {
  @apply px-6 py-2 rounded-full font-medium transition-all duration-200;
  background: linear-gradient(135deg, #6B8F3C 0%, #4A6B28 100%);
  color: white;
  box-shadow: 0 2px 8px rgba(107, 143, 60, 0.3);
}

.comic-button:hover {
  box-shadow: 0 4px 12px rgba(107, 143, 60, 0.4);
  transform: translateY(-1px);
}

.comic-button:active {
  transform: translateY(1px);
  box-shadow: 0 1px 4px rgba(107, 143, 60, 0.3);
}
```

#### `chip.vue`

**Current:** Comic pill
**New:** Paper chip with nature accent

```css
.comic-button {
  @apply px-4 py-1 rounded-full text-sm font-medium;
  background: #F0EDE5;
  border: 1px solid #D4C9B8;
  color: #5C4033;
}
```

#### `nav-btn.vue`

**Current:** Border + sweep animation
**New:** Rounded tab with subtle transition

```html
<NuxtLink :to="`${props.route}`"
  class="font-medium px-4 py-2 rounded-xl transition-all duration-200"
  :class="{ 'bg-leaf text-white shadow-md': params === props.route, 'bg-paper-dark text-bark hover:bg-paper-edge': params !== props.route }">
  <p class="text-sm sm:text-base">{{ props.name }}</p>
</NuxtLink>
```

#### `card-pulsar.vue`

**Current:** Offset colored cards
**New:** Paper cards with nature accent

```javascript
const styles = [
  "absolute w-full h-full rounded-2xl translate-x-1 translate-y-1 bg-leaf-light/30",
  "absolute w-full h-full rounded-2xl translate-x-1 translate-y-1 bg-sky-light/30",
  "absolute w-full h-full rounded-2xl translate-x-1 translate-y-1 bg-sunlight-light/30",
  "absolute w-full h-full rounded-2xl translate-x-1 translate-y-1 bg-paper-shadow"
];

const textStyles = [' text-leaf-dark', 'text-bark', 'text-bark', 'text-bark'];
```

#### `timeline.vue`

**Current:** Dashed SVG line
**New:** Organic curved line

```html
<!-- BEFORE -->
<div class="timeline-custom-line"></div>

<!-- AFTER -->
<div class="timeline-organic-line"></div>
```

```css
.timeline-organic-line {
  height: 100%;
  width: 3px;
  background: linear-gradient(180deg, #6B8F3C 0%, #D4C9B8 100%);
  border-radius: 2px;
}
```

Timeline nodes:
```html
<!-- BEFORE -->
<div class="w-6 md:w-10 h-6 md:h-10 bg-black relative mt-1">
  <div class="w-6 md:w-10 h-6 md:h-10 bg-purple-400 border border-black -translate-x-1 -translate-y-1"></div>
</div>

<!-- AFTER -->
<div class="w-6 md:w-10 h-6 md:h-10 bg-leaf rounded-full relative mt-1 shadow-md">
  <div class="w-6 md:w-10 h-6 md:h-10 bg-leaf-light rounded-full -translate-x-1 -translate-y-1"></div>
</div>
```

#### `accordion-item.vue`

**Current:** Thick border, offset shadow
**New:** Thin border, paper shadow

```css
.card-container {
  @apply bg-paper border border-paper-edge w-full h-full rounded-2xl transform-gpu transition-all duration-200;
  box-shadow: 0 1px 3px rgba(0,0,0,0.08);
}

.card-container:hover {
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}
```

#### `vertical-card.vue`

**Current:** Yellow/black cards
**New:** Paper cards with green accents

```html
<div class="bg-paper-dark border border-paper-edge gap-2 pt-1 pb-2 pl-1 pr-2 rounded-xl shadow-paper">
  <div class="w-11 h-11 relative">
    <div class="absolute w-full h-full bg-leaf rounded-lg translate-x-0.5 translate-y-0.5"></div>
    <div class="absolute w-full h-full bg-paper border border-paper-edge rounded-lg flex p-1 items-center justify-center">
      <NuxtImg class="rotate-90 md:rotate-0" :src="`${props.iconStr}`" alt="" srcset=""/>
    </div>
  </div>
  <p :style="{writingMode: 'vertical-rl'}" class="py-1 text-bark">{{ props.title }}</p>
</div>
```

#### Other Components

- `wavy-loader.vue`: Blue circles → Green circles
- `cat-loader.vue`: Black text → Green text
- `basic-btn.vue`: Dark monospace → Green gradient
- `card.vue`: Red/orange/purple/green → Nature-tinted
- `rotate-btn.vue`: Zinc colors → Green colors
- `round-decor.vue`: Orange dot → Green dot
- `language.vue`: Orange bar → Green bar
- `option.vue`: Black/white → Green/cream

### 3.2 Page Components

#### Experience Timeline (`experience/timeline.vue`)

```html
<!-- BEFORE -->
<span class="py-1.5 px-4 bg-red-200 rounded-lg text-xs font-medium">

<!-- AFTER -->
<span class="py-1.5 px-4 bg-leaf-light/30 text-leaf-dark rounded-lg text-xs font-medium">
```

#### Education Timeline (`education/timeline.vue`)

```html
<!-- BEFORE -->
<span class="py-1 px-6 bg-red-200 rounded-xl text-xs md:text-sm w-max">

<!-- AFTER -->
<span class="py-1 px-6 bg-leaf-light/30 text-leaf-dark rounded-xl text-xs md:text-sm w-max">
```

#### Project Carousel (`project/project-carousel.vue`)

```html
<!-- BEFORE -->
class="w-[200px] h-[150px] object-cover rounded-lg border-2 border-black cursor-pointer"

<!-- AFTER -->
class="w-[200px] h-[150px] object-cover rounded-lg border border-paper-edge cursor-pointer shadow-paper"
```

#### Project List (`main/project-list.vue`)

```html
<!-- BEFORE -->
class="prose prose-neutral prose-sm sm:prose-base md:prose-lg dark:prose-invert prose-li:my-0 prose-p:text-black prose-p:text-base prose-li:text-sm prose-img:rounded-lg prose-img:w-[70%] prose-h1:text-slate-700 prose-h1:text-3xl prose-h2:text-2xl prose-h3:text-xl overflow-hidden"

<!-- AFTER -->
class="prose prose-neutral prose-sm sm:prose-base md:prose-lg dark:prose-invert prose-li:my-0 prose-p:text-bark prose-p:text-base prose-li:text-sm prose-img:rounded-lg prose-img:w-[70%] prose-h1:text-bark prose-h1:text-3xl prose-h2:text-bark prose-h2:text-2xl prose-h3:text-bark prose-h3:text-xl overflow-hidden"
```

---

## Phase 4: GSAP Integration (Enhancement, Not Domination)

### 4.1 Install GSAP

```bash
npm install gsap
```

### 4.2 GSAP Plugin

**File:** `plugins/gsap.client.ts`

```typescript
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

export default defineNuxtPlugin(() => {
  if (import.meta.client) {
    gsap.registerPlugin(ScrollTrigger)
  }
  return {
    provide: {
      gsap,
      ScrollTrigger
    }
  }
})
```

### 4.3 Animation Strategy

**Principle:** Enhance existing interactions, don't add new complexity.

#### Scroll Animations (Replace AOS)

**Current:** AOS (`data-aos="fade-up"`)
**New:** GSAP ScrollTrigger (smoother, more control)

**File:** `composables/useScrollAnimations.ts`

```typescript
import { gsap } from 'gsap'
import { ScrollTrigger } from 'gsap/ScrollTrigger'

export const useScrollAnimations = () => {
  const initAnimations = () => {
    gsap.utils.toArray('.paper-card').forEach((card: any) => {
      gsap.from(card, {
        scrollTrigger: {
          trigger: card,
          start: 'top 85%',
          toggleActions: 'play none none none'
        },
        y: 30,
        opacity: 0,
        duration: 0.6,
        ease: 'power2.out'
      })
    })
  }

  return { initAnimations }
}
```

#### Page Load Animation

```typescript
gsap.from('.page-content', {
  opacity: 0,
  y: 20,
  duration: 0.5,
  ease: 'power2.out'
})
```

#### Hover Enhancements

```css
.paper-card {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.paper-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.12);
}
```

### 4.4 What NOT to Animate

- ❌ Don't animate layout shifts
- ❌ Don't animate the sidebar
- ❌ Don't add parallax to background (too heavy)
- ❌ Don't animate the navigation bar
- ✅ DO animate content cards entering viewport
- ✅ DO animate hover states
- ✅ DO animate page transitions

---

## Phase 5: Nature Landscape (Subtle, Not Dominant)

### 5.1 Layout Integration Points

**File:** `layouts/default.vue`

```html
<div class="relative">
  <!-- Nature decorations (absolute positioned) -->
  <div class="absolute top-0 left-0 w-32 h-32 opacity-20 pointer-events-none">
    <NuxtImg src="/images/nature/tree-left.svg" />
  </div>
  <div class="absolute top-20 right-0 w-24 h-24 opacity-15 pointer-events-none">
    <NuxtImg src="/images/nature/cloud.svg" />
  </div>
  
  <!-- Main content -->
  <div>...</div>
</div>
```

### 5.2 Section-Specific Landscapes

| Section | Landscape Element |
|---------|-------------------|
| About Me | Gentle hills at bottom |
| Projects | Small trees on sides |
| Experiences | Mountains in background |
| Educations | Book/plant hybrid |

```html
<!-- pages/index.vue -->
<template>
  <div class="relative">
    <!-- Section-specific decoration -->
    <div class="absolute bottom-0 left-0 right-0 h-24 opacity-30 pointer-events-none">
      <NuxtImg src="/images/nature/hills.svg" class="w-full h-full object-cover" />
    </div>
    
    <!-- Content -->
    <div>...</div>
  </div>
</template>
```

### 5.3 Paper Landscape Concept

Layer 1: Paper texture background (full page)
Layer 2: Distant mountains/hills (fixed, subtle)
Layer 3: Mid-ground trees (scroll parallax, light)
Layer 4: Foreground flowers/leaves (scroll parallax, medium)

**GSAP Parallax (optional, light):**
```typescript
gsap.to('.landscape-mountains', {
  scrollTrigger: {
    trigger: '.page-content',
    start: 'top top',
    end: 'bottom top',
    scrub: true
  },
  y: 50,
  ease: 'none'
})
```

---

## Phase 6: Asset Generation (Final)

### 6.1 Nature Illustrations

**Files:** `public/images/nature/`

| Asset | Purpose |
|-------|---------|
| `tree-left.svg` | Left side decoration |
| `tree-right.svg` | Right side decoration |
| `mountains.svg` | Background element |
| `hot-air-balloon.svg` | Accent decoration |
| `clouds.svg` | Floating clouds |
| `flowers.svg` | Bottom border decoration |
| `birds.svg` | Flying birds accent |
| `leaves.svg` | Scattered leaf elements |

### 6.2 Icons

**Files:** `public/images/icons/`

| Icon | Purpose |
|------|---------|
| `leaf.svg` | Specialty icon |
| `mountain.svg` | Specialty icon |
| `code.svg` | Specialty icon |
| `chart.svg` | Specialty icon |
| `pen.svg` | Specialty icon |

---

## Implementation Order

### Week 1: Foundation
1. Update `tailwind.config.js` with new colors
2. Update `assets/css/main.css` with paper utilities
3. Test colors on existing components

### Week 2: Base Components
1. Redesign `smooth-btn.vue`
2. Redesign `chip.vue`
3. Redesign `nav-btn.vue`
4. Redesign `card-pulsar.vue`
5. Redesign `timeline.vue`
6. Redesign `accordion-item.vue`

### Week 3: Layout
1. Update `layouts/default.vue` (paper background)
2. Update sidebar styling
3. Update content area styling
4. Update nav-list styling

### Week 4: Pages
1. Update `pages/index.vue`
2. Update `pages/projects.vue`
3. Update `pages/experiences.vue`
4. Update `pages/educations.vue`

### Week 5: GSAP
1. Create GSAP plugin
2. Create `useScrollAnimations` composable
3. Add scroll animations to pages
4. Add hover enhancements
5. Performance testing

### Week 6: Assets
1. Create paper texture background
2. Create SVG nature elements
3. Add to layout (decorative accents)
4. Add section-specific landscapes
5. Final polish

---

## Critical Files

| Priority | File | Change Type |
|----------|------|-------------|
| **P0** | `tailwind.config.js` | Update colors/shadows |
| **P0** | `assets/css/main.css` | Add paper utilities |
| **P0** | `layouts/default.vue` | Paper background + sidebar |
| **P1** | `components/base/smooth-btn.vue` | Paper button |
| **P1** | `components/base/chip.vue` | Paper chip |
| **P1** | `components/base/nav-btn.vue` | Paper nav |
| **P1** | `components/base/card-pulsar.vue` | Paper card |
| **P1** | `components/base/timeline.vue` | Organic line |
| **P1** | `components/base/accordion-item.vue` | Paper accordion |
| **P1** | `components/main/nav-list.vue` | Paper nav bar |
| **P2** | `pages/index.vue` | Paper styling |
| **P2** | `pages/projects.vue` | Paper styling |
| **P2** | `pages/experiences.vue` | Paper styling |
| **P2** | `pages/educations.vue` | Paper styling |
| **P3** | `plugins/gsap.client.ts` | New GSAP plugin |
| **P3** | `composables/useScrollAnimations.ts` | New composable |
| **P4** | `public/images/nature/*.svg` | Nature assets |

---

## Verification Checklist

- [ ] All existing functionality works
- [ ] No data flow changes needed
- [ ] Mobile layout works (375px)
- [ ] Tablet layout works (768px)
- [ ] Desktop layout works (1440px)
- [ ] Paper styling is consistent
- [ ] GSAP animations are smooth
- [ ] Nature elements are subtle (not overwhelming)
- [ ] Lighthouse score > 90
- [ ] No console errors

---

## Key Principle

**Evolution, not revolution.** Every change should feel like an improvement, not a replacement. The portfolio should still feel like *your* portfolio, just more polished and nature-themed.
