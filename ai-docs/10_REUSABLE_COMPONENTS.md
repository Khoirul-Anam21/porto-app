# 10 - Reusable Components

## Base Components (`components/base/`)

### `BaseRoundDecor`
- **File**: `components/base/round-decor.vue`
- **Purpose**: Small orange circle decoration used as a visual accent
- **Inputs**: None
- **Output**: `<div class="w-5 h-5 rounded-full bg-orange-400">`
- **Usage**: `<BaseRoundDecor />` — used in pages as section dividers

### `BaseCardPulsar`
- **File**: `components/base/card-pulsar.vue`
- **Purpose**: Card with colored offset shadow (pulsar effect), cycles through red/orange/purple/green
- **Props**: `indexColor: number` — determines color variant
- **Slot**: Exposes `{ textStyle }` via scoped slot for text color matching
- **Usage**:
```html
<BaseCardPulsar :index-color="index">
    <template v-slot="{ textStyle }">
        <div :class="textStyle">Content</div>
    </template>
</BaseCardPulsar>
```

### `BaseCard`
- **File**: `components/base/card.vue`
- **Purpose**: Fixed-size card with colored background and offset shadow
- **Props**: `color: 'red' | 'orange' | 'purple' | 'green' | 'classic'`
- **Slot**: Default slot for content
- **Usage**: `<BaseCard color="classic">Content</BaseCard>`

### `BaseSmoothBtn`
- **File**: `components/base/smooth-btn.vue`
- **Purpose**: Comic-style button with hover/active animations
- **Emits**: `clicked`
- **Slot**: Button text
- **Usage**: `<BaseSmoothBtn @clicked="handler">Click Me</BaseSmoothBtn>`

### `BaseBasicBtn`
- **File**: `components/base/basic-btn.vue`
- **Purpose**: Simple dark button with shadow (unused in current pages)
- **Inputs**: None (hardcoded "Button" text)
- **Usage**: Appears unused

### `BaseRotateBtn`
- **File**: `components/base/rotate-btn.vue`
- **Purpose**: SVG plus icon that rotates on hover (unused in current pages)
- **Inputs**: None
- **Usage**: Appears unused

### `BaseChip`
- **File**: `components/base/chip.vue`
- **Purpose**: Pill-shaped label/tag with comic-style border
- **Props**: `value: string`
- **Usage**: `<BaseChip value="Beginner" />`

### `BaseLanguage`
- **File**: `components/base/language.vue`
- **Purpose**: Displays a language name with level chips (parsed from JSON)
- **Props**: `language: Language`
- **Usage**: `<BaseLanguage :language="item" />`
- **Note**: Uses `JSON.parse(language.level_types)` to parse stored JSON

### `BaseVerticalCard`
- **File**: `components/base/vertical-card.vue`
- **Purpose**: Small card with icon and vertical text (used in skill marquee)
- **Props**: `type: 'normal' | 'reverse'`, `title: string`, `iconStr: string`
- **Usage**: `<BaseVerticalCard type="normal" :title="skill.title" :icon-str="skill.icon_url" />`

### `BaseNavBtn`
- **File**: `components/base/nav-btn.vue`
- **Purpose**: Navigation button with active state highlighting
- **Props**: `name: string`, `route: string`
- **Usage**: `<BaseNavBtn name="About Me" route="/" />`

### `BaseOption`
- **File**: `components/base/option.vue`
- **Purpose**: Horizontal radio button group for tab/filter selection
- **Props**: `data: { key: number, name: string }[]`
- **Emits**: `updateCurrentOption(key: number)`
- **Usage**: `<BaseOption :data="options" @update-current-option="updateOption" />`

### `BaseTimeline`
- **File**: `components/base/timeline.vue`
- **Purpose**: Timeline layout with animated node, dashed line, and content card
- **Props**: `keyIndex: number` — affects animation delay
- **Slot**: Default slot for timeline content
- **Usage**: `<BaseTimeline :key-index="index"><div>Content</div></BaseTimeline>`

### `BaseAccordion`
- **File**: `components/base/accordion.vue`
- **Purpose**: Accordion container, manages active item state via provide/inject
- **Provides**: `activeItemId: Ref<number>`
- **Slot**: Default slot for `BaseAccordionItem` children
- **Usage**: `<BaseAccordion><BaseAccordionItem ...>...</BaseAccordionItem></BaseAccordion>`

### `BaseAccordionItem`
- **File**: `components/base/accordion-item.vue`
- **Purpose**: Collapsible accordion panel with height animation
- **Props**: `itemId: number`
- **Injects**: `activeItemId` from parent `BaseAccordion`
- **Slots**: `#header` (always visible) and default (collapsible content)
- **Usage**:
```html
<BaseAccordionItem :item-id="index">
    <template #header><h5>Title</h5></template>
    <div>Collapsible content</div>
</BaseAccordionItem>
```

### `BaseCatLoader`
- **File**: `components/base/cat-loader.vue`
- **Purpose**: Animated SVG cat with "ZZZ" sleep animation
- **Inputs**: None
- **Usage**: `<BaseCatLoader />` — used on "Coming Soon" page

## Main Components (`components/main/`)

### `MainNavList`
- **File**: `components/main/nav-list.vue`
- **Purpose**: Horizontal navigation bar with 4 route links
- **Inputs**: None (hardcoded routes)
- **Usage**: `<MainNavList />` — rendered in `layouts/default.vue`

### `MainWavyLoader`
- **File**: `components/main/wavy-loader.vue`
- **Purpose**: Loading indicator with 5 animated dots
- **Inputs**: None
- **Usage**: `<MainWavyLoader v-if="status !== 'success'" />`

### `MainSkillsets`
- **File**: `components/main/skillsets.vue`
- **Purpose**: Dual-column infinite scroll marquee of skill cards
- **Props**: `skills: Skill[]`
- **Usage**: `<MainSkillsets :skills="skills" />`
- **CSS**: Uses `animate-loop-scroll-up`/`animate-loop-scroll-down` with `paused` on hover

### `MainProjectList`
- **File**: `components/main/project-list.vue`
- **Purpose**: Project listing with category filtering, accordion display, and image lightbox
- **Props**: `projects: Project[] | null`, `projectTypes: ProjectType[] | null`
- **Usage**: `<MainProjectList :projects="contents" :project-types="types" />`
- **Features**: Category filter tabs, accordion items, lightbox, responsive design

### `MainProjectCard`
- **File**: `components/main/project-card.vue`
- **Purpose**: Individual project card (appears unused — legacy from before DB migration)
- **Props**: `project: ProjectInterface`
- **Note**: Uses `ProjectInterface` from `composables/projects.ts` (legacy static data)

## Domain Components

### `EducationTimeline`
- **File**: `components/education/timeline.vue`
- **Purpose**: Single education entry in timeline format
- **Props**: `education: Education`
- **Usage**: `<EducationTimeline :education="item" />`

### `ExperienceTimeline`
- **File**: `components/experience/timeline.vue`
- **Purpose**: Single experience entry with HTML detail rendering
- **Props**: `experience: Experience`, `experience_type?: ExperienceType`
- **Usage**: `<ExperienceTimeline :experience="item" :experience_type="type" />`
- **Note**: Uses `v-html` to render rich text content

### `ProjectCarousel`
- **File**: `components/project/project-carousel.vue`
- **Purpose**: Horizontal scrollable image gallery for project screenshots
- **Props**: `images: ProjectFiles[]`
- **Emits**: `update:images(images: string[], index: number)`
- **Usage**: `<ProjectCarousel :images="item.images" @update:images="selectImages" />`
- **Note**: References `config.public.apiBase` (Directus legacy — may need updating)

## Composables (Auto-Imported)

### `formatDate()`
- **File**: `composables/useFormatDate.ts`
- **Purpose**: Formats date to "Month Year" (e.g., "January 2024")
- **Input**: `dateString: string | Date`
- **Output**: `string`
- **Usage**: `formatDate(item.date_start)` — used in timeline components

### `projectData` (Static)
- **File**: `composables/projects.ts`
- **Purpose**: Hardcoded project data (legacy — projects now come from DB)
- **Type**: `Ref<ProjectInterface[]>`

### `skillData` (Static)
- **File**: `composables/skills.ts`
- **Purpose**: Skill-to-icon mapping (still used in `MainProjectCard`)
- **Type**: `Ref<SkillInterface[]>`

### `socmedData` (Static)
- **File**: `composables/socmeds.ts`
- **Purpose**: Social media links (legacy — now in Pinia store)
- **Type**: `Ref<SocmedInterface[]>`
