# Setup Checklist

## Pre-Setup
- [ ] Have Aiven PostgreSQL credentials ready
- [ ] Node.js 18+ installed (`node --version`)
- [ ] GitHub account with repo cloned locally

## Step 1: Create Environment File
```bash
# Windows (PowerShell)
New-Item -Path ".env.local" -ItemType File

# Mac/Linux
touch .env.local
```

- [ ] `.env.local` file created in project root
- [ ] Added DB_HOST from Aiven console
- [ ] Added DB_PORT (5432)
- [ ] Added DB_NAME (defaultdb)
- [ ] Added DB_USER (avnadmin)
- [ ] Added DB_PASSWORD (from Aiven)
- [ ] No extra spaces in values
- [ ] No quotes around values

**Example:**
```
DB_HOST=pg-abc123.c.aivencloud.com
DB_PORT=5432
DB_NAME=defaultdb
DB_USER=avnadmin
DB_PASSWORD=YourPassword123
```

## Step 2: Verify Code Changes
- [ ] Checked `nuxt.config.ts` - no directus module
- [ ] Checked `package.json` - has `"pg": "^8.11.3"`
- [ ] Checked `server/api/` directory exists
- [ ] Checked `server/utils/database.ts` exists

## Step 3: Install Dependencies
```bash
npm install
```

- [ ] `npm install` completed without errors
- [ ] `node_modules/pg/` directory exists
- [ ] No `npm ERR!` messages

## Step 4: Start Development Server
```bash
npm run dev
```

- [ ] Server starts without errors
- [ ] See "Local: http://localhost:3000"
- [ ] Terminal shows no error messages

## Step 5: Test in Browser
- [ ] Browser opens automatically OR you visit http://localhost:3000
- [ ] Page loads without errors
- [ ] No red errors in browser console (F12)

## Step 6: Test API Endpoints

**Test each in terminal while `npm run dev` is running:**

```bash
curl http://localhost:3000/api/main_content
```
- [ ] Returns JSON object with `about_desc`, `specialties`, `languages`

```bash
curl http://localhost:3000/api/educations
```
- [ ] Returns JSON array of educations

```bash
curl http://localhost:3000/api/experiences
```
- [ ] Returns JSON object with `experiences` and `types`

```bash
curl http://localhost:3000/api/projects
```
- [ ] Returns JSON object with `projects` and `types`

```bash
curl http://localhost:3000/api/skills
```
- [ ] Returns JSON array of skills

## Step 7: Verify Frontend
- [ ] Home page loads and shows content
- [ ] About Me section visible
- [ ] Specialties displayed
- [ ] Languages listed
- [ ] Projects page loads
- [ ] Experiences page loads
- [ ] Educations page loads
- [ ] No console errors (F12 → Console tab)

## Step 8: Test Locally Complete ✅

All steps passed? You're ready to:
- [ ] Deploy to Vercel (see DEPLOYMENT.md)
- [ ] Make code changes (see SETUP_LOCAL_DEV.md)
- [ ] Add more features
- [ ] Migrate files to Cloudinary (optional)

---

## Troubleshooting

If something fails, check here:

### ❌ `npm install` fails
```bash
# Try clearing cache
npm cache clean --force

# Try again
npm install
```

### ❌ `npm run dev` shows error about database
Check `.env.local`:
```bash
cat .env.local
```
Verify all 5 values match Aiven console exactly.

### ❌ Browser shows "Failed to fetch data"
1. Check terminal logs while `npm run dev` is running
2. Verify database connection: `curl http://localhost:3000/api/main_content`
3. Check Aiven console: is database online?

### ❌ API returns "Failed to fetch"
Look at terminal logs. Common issues:
- Database connection failed → check credentials
- Query syntax error → check database.ts
- Database table missing data → check Aiven

### ❌ Cannot find module 'pg'
```bash
npm install pg
```

### ❌ "ENOTFOUND pg-xxx.c.aivencloud.com"
- Network issue or wrong host in `.env.local`
- Verify DB_HOST matches Aiven console exactly

---

## Success Signs ✅

You know it's working when:

1. ✅ Terminal shows "Local: http://localhost:3000"
2. ✅ Browser displays your portfolio
3. ✅ `curl http://localhost:3000/api/main_content` returns JSON
4. ✅ All API endpoints return data
5. ✅ No errors in browser console (F12)
6. ✅ All portfolio pages (projects, educations, experiences) load

---

## Next Steps

### If local works:
1. Read `DEPLOYMENT.md` to deploy to Vercel
2. Or read `SETUP_LOCAL_DEV.md` for development tips
3. Or continue adding features

### If you want to migrate files:
1. Read `FILES_HANDLING.md`
2. Upload to Cloudinary or Supabase Storage
3. Update database icon URLs

### If you need help:
1. Check `QUICK_START.md` for quick reference
2. Check `SETUP_LOCAL_DEV.md` for detailed steps
3. Check `AIVEN_MIGRATION_GUIDE.md` for technical details

---

## Environment Verification

Run this to verify your setup:

```bash
# Check Node.js version
node --version
# Should be 18+ 

# Check npm
npm --version

# Check .env.local exists
cat .env.local
# Should show your 5 database variables

# Check pg is installed
npm list pg
# Should show pg version

# Check database.ts exists
cat server/utils/database.ts
# Should show connection pool code

# Check API routes exist
ls server/api/
# Should show: main_content.ts, educations.ts, etc.
```

All checks passing? **You're ready!** 🎉

---

## Files Modified/Created

### Modified:
- ✅ `nuxt.config.ts` - Removed Directus
- ✅ `package.json` - Added pg library

### Created:
- ✅ `server/utils/database.ts` - Connection pool
- ✅ `server/api/main_content.ts` - API route
- ✅ `server/api/educations.ts` - API route
- ✅ `server/api/experiences.ts` - API route
- ✅ `server/api/projects.ts` - API route
- ✅ `server/api/skills.ts` - API route
- ✅ `.env.local` - Your secrets
- ✅ `.env.example` - Template
- ✅ `vercel.json` - Vercel config

### Documentation:
- ✅ `QUICK_START.md`
- ✅ `SETUP_LOCAL_DEV.md`
- ✅ `DEPLOYMENT.md`
- ✅ `IMPLEMENTATION_SUMMARY.md`
- ✅ `CHECKLIST.md` (this file)

---

## Ready? 

Start with: `QUICK_START.md`

Or follow this checklist step-by-step above. ✅
