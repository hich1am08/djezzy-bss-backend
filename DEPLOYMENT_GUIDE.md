# Deployment Guide - Render.com (FREE)

## Steps to Deploy Your Flask Backend 24/7

### 1. **Install Git** (if you don't have it)
```bash
# Download from: https://git-scm.com/download/win
```

### 2. **Initialize Git Repository** (in your project folder)
```bash
cd "c:\Users\LENOVO\OneDrive\Desktop\site config"
git init
git add .
git commit -m "Initial commit"
```

### 3. **Push to GitHub** (free, required for Render)
- Go to https://github.com/new
- Create a new repository (e.g., "djezzy-bss-backend")
- **Don't** initialize with README
- Copy the commands it shows you:
```bash
git remote add origin https://github.com/YOUR-USERNAME/djezzy-bss-backend.git
git branch -M main
git push -u origin main
```

### 4. **Deploy on Render**
- Go to https://render.com
- Sign up with GitHub
- Click "New +" → "Web Service"
- Connect your GitHub repo
- Choose: "djezzy-bss-backend"
- Name: `djezzy-bss-api`
- Root Directory: `/` (leave empty)
- Build Command: (leave empty)
- Start Command: (leave empty)
- Plan: **Free**
- Click "Deploy"

### 5. **Get Your Live URL**
After ~5 minutes, Render will give you a URL like:
```
https://djezzy-bss-api.onrender.com
```

### 6. **Update Your Apps** (Only URL change needed!)

**For Android App:**
Edit `android/www/app.js` - Find the API calls and change from:
```javascript
const API_BASE = 'http://localhost:5000'
// Change to:
const API_BASE = 'https://djezzy-bss-api.onrender.com'
```

**For Web App:**
Edit `app.js` - Same change as above

### 7. **Rebuild Android APK**
```bash
cd android
npm install
npm run build
npm run build:android
```

---

## Important Notes:

✅ **Free tier includes:**
- 750 hours/month (plenty for 24/7)
- Auto-deploys on git push
- SSL certificate (HTTPS)

⚠️ **Limitations:**
- Spins down after 15 min inactivity (takes 30 sec to wake up)
- Limited RAM/CPU

💡 **Keep it fast:**
- App will wake up when first request arrives
- Stay in Oregon region for lower latency

🔧 **Push updates anytime:**
Just push to GitHub and Render auto-deploys!

---

## Troubleshooting

If deployment fails:
1. Check Render logs (in dashboard)
2. Make sure `requirements.txt` is complete
3. Ensure port is 5000
4. Check `.dockerignore` isn't blocking needed files
