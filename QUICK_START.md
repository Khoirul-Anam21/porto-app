# Quick Start (5 Minutes)

## ⚡ TL;DR

```bash
# 1. Create .env.local with your Aiven credentials
echo "DB_HOST=pg-xxxxx.c.aivencloud.com
DB_PORT=5432
DB_NAME=defaultdb
DB_USER=avnadmin
DB_PASSWORD=your_password" > .env.local

# 2. Install dependencies
npm install

# 3. Start dev server
npm run dev

# 4. Open browser
# http://localhost:3000
```

## Get Your Aiven Credentials

1. Go to https://console.aiven.io/
2. Click your PostgreSQL service
3. Click "Connection info"
4. Copy-paste the values (Host, Port, Database, User, Password)

## Create .env.local

Replace values with YOUR actual Aiven credentials:

```
DB_HOST=pg-abc123.c.aivencloud.com
DB_PORT=5432
DB_NAME=defaultdb
DB_USER=avnadmin
DB_PASSWORD=YourActualPassword123
```

**Save as `.env.local` in project root**

## Install & Run

```bash
npm install
npm run dev
```

Open: http://localhost:3000

## Test API

```bash
curl http://localhost:3000/api/main_content
curl http://localhost:3000/api/projects
curl http://localhost:3000/api/educations
curl http://localhost:3000/api/experiences
curl http://localhost:3000/api/skills
```

All should return JSON.

## If It Fails

Check `.env.local`:
```bash
cat .env.local
```

Verify:
- ✅ Values match Aiven console
- ✅ No extra spaces
- ✅ Password is correct

Check logs in terminal running `npm run dev`.

## Deploy to Vercel (Optional)

```bash
git push
# Auto-deploys to Vercel, just add env vars in Vercel dashboard
```

See `DEPLOYMENT.md` for details.

## Key Files Changed

- `nuxt.config.ts` - Removed Directus module
- `server/api/*` - New API routes (use database directly)
- `server/utils/database.ts` - Database connection pool
- `package.json` - Added `pg` library
- `.env.example` - Template (commit this)
- `.env.local` - Your secrets (DON'T commit)

## API Endpoints

| Endpoint | Returns |
|----------|---------|
| `/api/main_content` | About section + specialties + languages |
| `/api/educations` | Education history |
| `/api/experiences` | Work experience |
| `/api/projects` | Projects with images & skills |
| `/api/skills` | All skills |

## Database Schema

Already in Aiven:
- educations
- experiences
- projects
- skills
- specialties
- main_contents
- project_types
- job_types
- languanges

Plus file references and relations.

## Next

Read `SETUP_LOCAL_DEV.md` for detailed troubleshooting.

Read `DEPLOYMENT.md` for Vercel deployment.

That's it! You're running without Directus. ✅
