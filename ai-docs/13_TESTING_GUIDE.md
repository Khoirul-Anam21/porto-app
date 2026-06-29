# 13 - Testing Guide

## Testing Framework

**None configured.** There is no testing framework, test runner, or test files in the project.

**Evidence**:
- No test scripts in `package.json`
- No `vitest`, `jest`, `@vue/test-utils`, or `cypress` in dependencies
- No `test/`, `tests/`, `__tests__/`, or `*.spec.ts`/`*.test.ts` files found
- No testing configuration files (vitest.config.ts, jest.config.js, etc.)

## Current Testing Approach

**Manual testing only.** The developer verifies functionality by:
1. Running `npm run dev`
2. Opening `http://localhost:3000`
3. Navigating through pages
4. Visually checking content rendering

**Evidence**: `START_HERE.md` — "Test It Works" section only describes manual browser verification.

## Recommended Testing Strategy

Given the project's nature (read-only portfolio), a minimal testing approach is sufficient:

### Priority 1: Server API Routes

```typescript
// Example: server/api/__tests__/skills.test.ts
import { describe, it, expect } from 'vitest'

describe('GET /api/skills', () => {
    it('returns published skills as array', async () => {
        const data = await $fetch('/api/skills')
        expect(Array.isArray(data)).toBe(true)
    })
})
```

### Priority 2: Component Smoke Tests

```typescript
// Example: components/base/__tests__/chip.test.ts
import { mount } from '@vue/test-utils'
import BaseChip from '../chip.vue'

describe('BaseChip', () => {
    it('renders value text', () => {
        const wrapper = mount(BaseChip, { props: { value: 'Beginner' } })
        expect(wrapper.text()).toContain('Beginner')
    })
})
```

### Priority 3: Composable Unit Tests

```typescript
// Example: composables/__tests__/useFormatDate.test.ts
import { describe, it, expect } from 'vitest'
import formatDate from '../useFormatDate'

describe('formatDate', () => {
    it('formats date to Month Year', () => {
        expect(formatDate('2024-01-15')).toBe('January 2024')
    })
})
```

## Mocking Strategy

- **Database**: Mock `query()` from `server/utils/database.ts` for API route tests
- **API responses**: Mock `useLazyFetch` return values for component tests
- **No external services**: All third-party integrations (Cloudinary, Vercel Analytics) are read-only

## Existing Coverage

| Area | Coverage | Notes |
|------|----------|-------|
| Unit tests | 0% | No tests exist |
| Component tests | 0% | No tests exist |
| API route tests | 0% | No tests exist |
| E2E tests | 0% | No tests exist |
| Manual testing | Informal | Developer checks in browser |
