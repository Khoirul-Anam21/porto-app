# Local Development Setup

## Prerequisites

- Node.js 18+ (or Bun)
- Aiven PostgreSQL connection details
- Git

## Step 1: Get Your Aiven Database Credentials

From https://console.aiven.io/

Look for your PostgreSQL service and find:
- **Host**: `pg-xxxxx.c.aivencloud.com`
- **Port**: `5432`
- **Database**: `defaultdb`
- **Username**: `avnadmin`
- **Password**: (visible in Connection string)

## Step 2: Install Dependencies

```bash
npm install
# or
bun install
```

This installs `pg` library for PostgreSQL connection.

## Step 3: Create .env.local File

Create a new file `.env.local` in the root directory:

```bash
# Windows (PowerShell)
New-Item -Path ".env.local" -ItemType File

# Mac/Linux
touch .env.local
```

**Add your Aiven credentials:**

```
DB_HOST=pg-xxxxx.c.aivencloud.com
DB_PORT=5432
DB_NAME=defaultdb
DB_USER=avnadmin
DB_PASSWORD=your_actual_password
```

**Example (with real values):**
```
DB_HOST=pg-abc123def456.c.aivencloud.com
DB_PORT=5432
DB_NAME=defaultdb
DB_USER=avnadmin
DB_PASSWORD=SuperSecure123Password456
```

## Step 4: Test Database Connection

Run a quick test to verify connection:

```bash
npm run dev
```

Then in another terminal, test the API:

```bash
curl http://localhost:3000/api/main_content
```

Should return JSON like:
```json
{
  "id": 1,
  "about_desc": "Digitalization Specialist...",
  "specialties": [...],
  "languages": [...]
}
```

### If it fails:

**Check credentials:**
```bash
# Verify in .env.local
cat .env.local
```

**Check Aiven connection:**
```bash
# Can you access Aiven console?
# https://console.aiven.io/
```

**Check logs:**
```bash
# Terminal where `npm run dev` is running
# Look for error messages about database connection
```

## Step 5: Test All API Endpoints

```bash
# Main content (home page)
curl http://localhost:3000/api/main_content

# Educations
curl http://localhost:3000/api/educations

# Experiences  
curl http://localhost:3000/api/experiences

# Projects
curl http://localhost:3000/api/projects

# Skills
curl http://localhost:3000/api/skills
```

All should return JSON arrays/objects.

## Step 6: Test Frontend

Visit: http://localhost:3000

Check browser console for any fetch errors.

## Project Structure

```
porto-app/
├── server/
│   ├── api/                  ← API routes
│   │   ├── main_content.ts
│   │   ├── educations.ts
│   │   ├── experiences.ts
│   │   ├── projects.ts
│   │   └── skills.ts
│   └── utils/
│       └── database.ts       ← DB connection pool
├── pages/                    ← Pages (unchanged)
├── components/               ← Components (unchanged)
├── nuxt.config.ts           ← Updated (no Directus)
├── .env.local               ← Local secrets (git-ignored)
├── .env.example             ← Template (commit to git)
└── package.json
```

## Development Workflow

### Daily Development

```bash
# 1. Start dev server
npm run dev

# 2. Open browser
http://localhost:3000

# 3. Edit pages/components
# Changes auto-refresh

# 4. Test API changes
curl http://localhost:3000/api/projects
```

### Adding Data

1. Go to your Aiven Console: https://console.aiven.io/
2. Click your PostgreSQL service → Database Browser
3. Insert/update data in tables (educations, projects, etc.)
4. Refresh browser: http://localhost:3000

### Modifying API Routes

**Example: Change projects order**

Edit `server/api/projects.ts`:
```typescript
// Change this:
ORDER BY p.sort DESC

// To this:
ORDER BY p.date_created DESC
```

Save → Nuxt auto-rebuilds → Test it:
```bash
curl http://localhost:3000/api/projects
```

## Common Issues

### Issue: "Cannot find module 'pg'"

**Solution:**
```bash
npm install pg
# or
bun install
```

### Issue: "getaddrinfo ENOTFOUND pg-xxx.c.aivencloud.com"

**Cause:** Wrong host or no internet connection

**Solution:**
1. Verify DB_HOST in `.env.local`
2. Check internet connection
3. Try pinging host: `ping pg-xxx.c.aivencloud.com`

### Issue: "FATAL: remaining connection slots are reserved"

**Cause:** Too many open connections

**Solution:**
- Restart dev server: `Ctrl+C` then `npm run dev`
- Check database.ts pool settings

### Issue: API returns "Failed to fetch main_content"

**Cause:** Database query error (likely wrong column names or data missing)

**Solution:**
1. Check Aiven database has data
2. Verify query in API route matches schema
3. Check browser console for details

## Environment Variables Explained

| Variable | Purpose | Example |
|----------|---------|---------|
| `DB_HOST` | PostgreSQL server address | `pg-abc.c.aivencloud.com` |
| `DB_PORT` | PostgreSQL port | `5432` |
| `DB_NAME` | Database name | `defaultdb` |
| `DB_USER` | Database user | `avnadmin` |
| `DB_PASSWORD` | Database password | `SecurePassword123` |

**Important:**
- ✅ `.env.local` = Local only (git-ignored)
- ❌ Never commit `.env.local` to git
- ✅ Vercel: Add same variables in dashboard
- ❌ Never hardcode passwords in code

## Build & Production Preview

```bash
# Build for production
npm run build

# Preview production build
npm run preview
```

This simulates what will run on Vercel.

## Database Connection Pool

The `server/utils/database.ts` handles:
- ✅ Connection pooling (reuses connections)
- ✅ Error handling
- ✅ Graceful cleanup

Settings in `database.ts`:
```typescript
max: 20,                      // Max connections
idleTimeoutMillis: 30000,     // Close after 30s idle
connectionTimeoutMillis: 2000 // 2s connection timeout
```

Adjust if needed, but defaults are good for most cases.

## Next Steps: Deploy to Vercel

Once everything works locally:

1. Commit to GitHub:
   ```bash
   git add .
   git commit -m "Setup direct Aiven database connection"
   git push
   ```

2. Go to https://vercel.com/new
3. Import your GitHub repo
4. Add same environment variables
5. Deploy

See `DEPLOYMENT.md` for full Vercel setup.

## Troubleshooting Checklist

- [ ] `.env.local` has correct credentials
- [ ] `npm install` completed successfully
- [ ] `npm run dev` starts without errors
- [ ] `curl http://localhost:3000/api/main_content` returns JSON
- [ ] Browser loads http://localhost:3000
- [ ] Components display data

## Getting Help

1. Check the error message carefully
2. Test API directly: `curl http://localhost:3000/api/projects`
3. Check Aiven console: verify data exists
4. Check `.env.local`: verify credentials
5. Check terminal: look for error logs when running `npm run dev`
