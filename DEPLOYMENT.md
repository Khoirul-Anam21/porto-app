# Deployment to Vercel

## Prerequisites

✅ Local development works (`npm run dev` successful)
✅ All API endpoints tested (`curl http://localhost:3000/api/...`)
✅ GitHub repository with code pushed

## Step 1: Prepare for Production

### 1.1 Make sure nuxt.config.ts is correct:

```bash
cat nuxt.config.ts
# Should have: runtimeConfig with dbHost, dbPort, dbName, dbUser, dbPassword
# Should NOT have: nuxt-directus in modules list
```

### 1.2 Verify package.json has `pg` dependency:

```bash
cat package.json | grep '"pg"'
# Should show: "pg": "^8.11.3"
```

### 1.3 Commit everything to GitHub:

```bash
git add .
git commit -m "Migrate from Directus to Aiven PostgreSQL"
git push
```

## Step 2: Create Vercel Account & Import Project

### 2.1 Go to Vercel

https://vercel.com

Sign up with GitHub if you haven't already.

### 2.2 Click "Add New..." → "Project"

![Vercel Dashboard](https://vercel.com/docs/static/get-started-import-a-project.png)

### 2.3 Import from GitHub

- Select your GitHub account
- Find and select `porto-app` repository
- Click "Import"

## Step 3: Configure Environment Variables

### 3.1 Project Settings

After importing, click "Continue to Dashboard" → Settings

### 3.2 Go to "Environment Variables"

![Environment Variables](https://vercel.com/docs/concepts/projects/environment-variables)

### 3.3 Add Variables

Add the SAME values from your `.env.local`:

| Key | Value |
|-----|-------|
| `DB_HOST` | `pg-xxxxx.c.aivencloud.com` |
| `DB_PORT` | `5432` |
| `DB_NAME` | `defaultdb` |
| `DB_USER` | `avnadmin` |
| `DB_PASSWORD` | `your_actual_password` |

**Important:** 
- Copy paste from `.env.local`
- Verify NO extra spaces
- Verify password is correct

### 3.4 Save

Click "Save" after each variable.

## Step 4: Deploy

### 4.1 In Vercel Dashboard

Look for "Deployments" tab.

You should see a deployment in progress:
```
Building...
Installing dependencies...
Running build command...
```

Wait for it to complete (usually 2-3 minutes).

### 4.2 Check Deployment Status

Once complete, you should see:
```
✓ Production Deployment Ready
https://porto-app-xxxxxxxxxx.vercel.app
```

### 4.3 Test Your Site

Click the URL to visit your deployed site:
```
https://your-project-name.vercel.app
```

## Step 5: Verify Everything Works

### 5.1 Test API Endpoints

```bash
# From your local machine or use browser Network tab
curl https://your-project-name.vercel.app/api/main_content
curl https://your-project-name.vercel.app/api/projects
curl https://your-project-name.vercel.app/api/educations
```

### 5.2 Check Browser Console

- Open browser DevTools (F12)
- Go to Console tab
- Look for any errors
- Check Network tab → see API responses

### 5.3 Test Each Page

- Home page (About Me)
- Projects page
- Educations page
- Experiences page

All should load data without errors.

## Step 6: Custom Domain (Optional)

If you want a custom domain instead of `vercel.app`:

### 6.1 Go to Settings → Domains

### 6.2 Add your domain

You can use:
- GoDaddy
- Namecheap
- Google Domains
- Any domain registrar

### 6.3 Point domain to Vercel

Update your domain's nameservers or DNS records to Vercel.

See: https://vercel.com/docs/concepts/projects/domains

## Step 7: Continuous Deployment

Once deployed, every time you push to GitHub:

```bash
git push origin main
```

Vercel automatically:
1. Detects the push
2. Rebuilds your site
3. Runs tests (if configured)
4. Deploys new version
5. Updates your live site

No manual deployment needed!

## Rollback to Previous Version

If something breaks:

1. Go to Vercel Dashboard → Deployments
2. Find the last good deployment
3. Click "Promote to Production"

Instant rollback! ✅

## Monitoring & Logs

### View Build Logs

Vercel Dashboard → Deployments → Click deployment → Logs

Shows exactly what happened during build.

### View Runtime Errors

Vercel Dashboard → Monitoring → Logs

Shows errors that happened while serving requests.

## Updating Environment Variables

If you change database password:

### 6.1 Update in Vercel Dashboard

Settings → Environment Variables → Edit variable

### 6.2 Redeploy

Just make a tiny commit and push:
```bash
git commit --allow-empty -m "Trigger rebuild with new DB password"
git push
```

Or click "Redeploy" in Vercel dashboard.

## Troubleshooting Deployment

### Issue: Build fails with "Cannot find module 'pg'"

**Check:**
- `package.json` has `"pg": "^8.11.3"` in dependencies (not devDependencies)
- Run `npm install` locally first

### Issue: Database connection fails in production

**Check:**
- All 5 environment variables are set in Vercel
- No extra spaces in values
- Password doesn't have special characters that need escaping
- Aiven allows connections from Vercel IPs (usually yes by default)

### Issue: "Built is OK, deploy failed"

**Usually just needs retry:**
```bash
git push  # Trigger new build
```

### Issue: API works locally but not in production

**Common causes:**
1. Environment variables not set → see logs
2. Database credentials wrong → verify in Vercel dashboard
3. Typo in variable name → DB_HOST vs DbHost

**Solution:**
1. Check Vercel logs
2. Verify env vars match your `.env.local` exactly
3. Try local build: `npm run build && npm run preview`

## Local Preview of Production Build

Before deploying, test the production build locally:

```bash
# Build for production
npm run build

# Run production build locally
npm run preview
```

Then visit: http://localhost:3000

This simulates exactly what will run on Vercel.

## Performance & Analytics

Vercel provides free analytics:

- Vercel Dashboard → Analytics
- See page load times
- See API response times
- Monitor errors

## Environment Variables Cheat Sheet

| Where to Set | Location | Example |
|--------------|----------|---------|
| **Local Dev** | `.env.local` file | `DB_HOST=pg-xxx.c.aiven...` |
| **Production** | Vercel Dashboard | Settings → Environment Variables |
| **Git** | `.env.example` (NO SECRETS!) | `DB_HOST=your_host` |

## Next Steps

1. ✅ Local development works
2. ✅ Deployed to Vercel
3. ⏭️ Optional: Set custom domain
4. ⏭️ Optional: Configure custom analytics
5. ⏭️ Optional: Migrate files to Cloudinary

## Summary: From Local to Live

```
┌──────────────────┐
│ npm run dev      │  ✅ Works locally
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ git push         │  ✅ Push to GitHub
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Vercel           │  ✅ Auto-deploys
│ (build)          │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Your site live   │  ✅ https://your-project.vercel.app
│ https://...      │
└──────────────────┘
```

**You're done!** Your portfolio is now live with zero VPS needed.
