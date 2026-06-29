# Files Handling Strategy

## Current Setup (Directus)

### 1. **Asset Proxy**
```typescript
// nuxt.config.ts
routeRules: {
  '/assets/**': {
    proxy: { to: "https:admin.anam6.my.id/assets/**" }
  }
}
```
- All `/assets/*` requests proxied through Directus
- Files stored in Directus file system
- Referenced by **file ID** (UUID-like `directus_files_id`)

### 2. **File Types Used**

| File Type | Usage | Count | Location |
|-----------|-------|-------|----------|
| **Icons** | Specialty icons, project type icons, skill icons | ~50 | `specialties.icon`, `project_types.icon`, `skills.icon` |
| **Project Images** | Project gallery/carousel | ~30-50 | `projects.images[].directus_files_id` |
| **Profile Photo** | Hardcoded Cloudinary URL | 1 | `layouts/default.vue` (line 117) |
| **Social Icons** | Contact links | 4 | `/public/images/icons/` (local) |

### 3. **Current File Reference Pattern**

```typescript
// In components using NuxtImg:
:src="`${config.public.apiBase}/assets/${item.icon}`"
// or
:src="`${config.public.apiBase}/assets/${image.directus_files_id}`"

// Resolves to: https://cms.itsanam.my.id/assets/{filename_or_id}
```

---

## Migration Options by Alternative

### Option A: **Cloudinary** (Recommended for Images)
Best for: Project images, optimized delivery

**Pros:**
- ✅ Free tier: 25 GB storage, unlimited transformations
- ✅ Image optimization built-in (WebP, sizes)
- ✅ CDN distribution
- ✅ URL-based transformations: `cloudinary.com/c_scale,w_300/...`

**Migration:**
1. Upload all project images to Cloudinary (free uploader or API)
2. Store `cloudinary_url` in Supabase instead of `directus_files_id`
3. Remove `/assets/` proxy from nuxt.config
4. Update components to use Cloudinary URLs directly

**Cost:** $0/month (free tier)

---

### Option B: **Supabase Storage** (Recommended for Full Control)
Best for: Complete replacement of Directus file system

**Pros:**
- ✅ Free tier: 1 GB storage
- ✅ Integrated with your database
- ✅ Row-level security
- ✅ Simple API

**Migration:**
1. Create Supabase bucket (e.g., `portfolio-assets`)
2. Upload all files via Supabase CLI or API
3. Store file paths in database: `specialty.icon_path = 'specialties/icon-1.png'`
4. Create public bucket or signed URLs
5. Update components to construct URLs: `${supabaseUrl}/storage/v1/object/public/portfolio-assets/${item.icon_path}`

**Cost:** $0/month (free tier covers 1 GB)

---

### Option C: **GitHub + Raw CDN** (Free, Minimal)
Best for: Small static files only (icons)

**Pros:**
- ✅ Completely free
- ✅ Version controlled
- ✅ Built-in CDN via Vercel/jsDelivr

**Migration:**
1. Commit all icons to `/public/assets/` in repo
2. Reference locally: `:src="'/assets/icons/specialty-1.png'"`
3. For project images: Still need Option A or B

**Cost:** $0/month

---

### Option D: **Supabase + Cloudinary Hybrid** (Best)
Use both:
- **Icons** → GitHub (`/public/assets/`) or Supabase (small, stable)
- **Project Images** → Cloudinary (large, need optimization)

**Cost:** $0/month

---

## Recommended Migration Path

### For Your Case: **Supabase Storage + Cloudinary for Images**

```
┌─────────────────────┐
│    Supabase DB      │
├─────────────────────┤
│ Specialty           │
│  ├─ id              │
│  ├─ icon_path ─────┐│
│  └─ ...            ││
│                    ││
│ Project             │
│  ├─ id              │
│  ├─ images[] ────┐  │
│  └─ ...          │  │
└────────┬─────────┘  │
         │            │
    ┌────▼──────────────────────────┐
    │                               │
    ▼ Local/Supabase               ▼ Cloudinary
  /assets/icons/                https://res.cloudinary.com/
  /assets/specialties/           c_scale,w_300,f_auto/...
```

---

## Step-by-Step Migration Guide

### Step 1: Inventory Current Files
```bash
# Export from Directus
# Go to https://cms.itsanam.my.id/admin/content/directus_files
# Note the file IDs and filenames for:
# - Specialty icons
# - Project type icons  
# - Skill icons
# - Project images
```

### Step 2: Upload Icons to Supabase
```typescript
// supabase.ts
const { data, error } = await supabaseClient.storage
  .from('portfolio-assets')
  .upload(`icons/specialty-1.png`, file)
```

### Step 3: Upload Project Images to Cloudinary
```bash
curl -X POST https://api.cloudinary.com/v1_1/YOUR_CLOUD/image/upload \
  -F "file=@local_image.jpg" \
  -F "folder=portfolio/projects"
```

### Step 4: Update Database Schema
```sql
-- Supabase
ALTER TABLE specialties ADD COLUMN icon_path text;
ALTER TABLE project_types ADD COLUMN icon_path text;
ALTER TABLE skills ADD COLUMN icon_path text;

-- Drop old icon column if not used elsewhere
ALTER TABLE specialties DROP COLUMN icon;
```

### Step 5: Update Components
**Before:**
```typescript
:src="`${config.public.apiBase}/assets/${item.icon}`"
```

**After (Supabase):**
```typescript
:src="`${supabaseUrl}/storage/v1/object/public/portfolio-assets/${item.icon_path}`"
```

**After (Cloudinary):**
```typescript
:src="`https://res.cloudinary.com/${cloudName}/image/upload/c_scale,w_300,f_auto/${imagePublicId}`"
```

### Step 6: Remove Nuxt Proxy
```typescript
// Delete from nuxt.config.ts
routeRules: {
  '/assets/**': { proxy: { to: "..." } }
}
```

---

## File Storage Summary

| Solution | Icons | Project Images | Cost | Effort |
|----------|-------|----------------|------|--------|
| **Supabase Only** | ✅ | ✅ | Free 1GB | Medium |
| **Cloudinary Only** | ✅ | ✅✅ | Free 25GB | Low |
| **GitHub (local)** | ✅ | ❌ | Free | Minimal |
| **Hybrid (Supabase + Cloudinary)** | ✅ | ✅✅ | Free | Medium |

---

## Estimated File Sizes
- **Icons**: 50 files × 50KB = ~2.5 MB
- **Project images**: 40 files × 500KB avg = ~20 MB
- **Total**: ~25 MB (fits easily in free tiers)

---

## Quick Links

- [Supabase Storage Docs](https://supabase.com/docs/guides/storage)
- [Cloudinary Upload API](https://cloudinary.com/documentation/image_upload_api_reference)
- [NuxtImg Component Docs](https://image.nuxt.com/)
