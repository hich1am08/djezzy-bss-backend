@echo off
REM Windows Deployment Script for Djezzy BSS Backend

echo.
echo ========================================
echo Djezzy BSS - Render.com Deployment
echo ========================================
echo.

REM Step 1: GitHub Setup
echo STEP 1: Create GitHub Repository
echo.
echo 1. Go to https://github.com/new
echo 2. Repository name: djezzy-bss-backend
echo 3. Description: Djezzy BSS Backend API
echo 4. Choose Public or Private
echo 5. Do NOT initialize with README
echo 6. Click "Create repository"
echo.
pause /B

cls
echo STEP 2: Set up Git Remote
echo.
echo Enter your GitHub username (what appears in github.com/[USERNAME]):
set /p GITHUB_USER=^> 

set REPO_URL=https://github.com/%GITHUB_USER%/djezzy-bss-backend.git

git remote add origin %REPO_URL%
git branch -M main

cls
echo STEP 3: Authenticate with GitHub
echo.
echo Git will now prompt you for authentication.
echo Use one of these methods:
echo   - GitHub Personal Access Token (recommended)
echo   - Or just use your GitHub username
echo.
pause /B

cls
echo Pushing code to GitHub...
echo This may take a minute...
echo.

git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo ❌ Push failed! Troubleshoot:
    echo    1. Check your GitHub username is correct
    echo    2. Verify repo exists at github.com/%GITHUB_USER%/djezzy-bss-backend
    echo    3. If prompted, enter GitHub login info (use token if 2FA enabled)
    echo.
    pause /B
    exit /b 1
)

cls
echo ✅ Code pushed to GitHub successfully!
echo.
echo STEP 4: Deploy on Render.com
echo.
echo 1. Go to https://render.com
echo 2. Click "Sign up" or "Sign in with GitHub"
echo 3. Authorize Render to access your GitHub repos
echo 4. Click "New +" button (top right)
echo 5. Select "Web Service"
echo 6. Choose your "djezzy-bss-backend" repo and click "Connect"
echo 7. Fill in these settings:
echo    - Name: djezzy-bss-api
echo    - Runtime: Docker
echo    - Region: Oregon
echo    - Plan: Free (scroll down to see it)
echo 8. Leave Build Command and Start Command EMPTY
echo 9. Click "Create Web Service"
echo.
echo Your app will deploy in 5-10 minutes!
echo.
pause /B

cls
echo ✅ Almost Done!
echo.
echo Once Render shows "Live", you'll have a URL like:
echo    https://djezzy-bss-api.onrender.com
echo.
echo Next Steps:
echo    1. Copy that URL
echo    2. Edit app.js (both web and android/www versions)
echo    3. Change API_BASE = 'http://localhost:5000'
echo       To: API_BASE = 'https://djezzy-bss-api.onrender.com'
echo    4. Rebuild Android APK if needed
echo.
echo Need help? Check DEPLOYMENT_GUIDE.md
echo.
pause /B
