#!/bin/bash
# Auto-deploy script for GitHub + Render

echo "=== Djezzy BSS Backend Deployment ==="
echo ""
echo "Step 1: Configure Git (one time only)"
read -p "Enter your GitHub username: " GITHUB_USER
read -p "Enter your GitHub email: " GITHUB_EMAIL

git config --global user.name "$GITHUB_USER"
git config --global user.email "$GITHUB_EMAIL"

echo ""
echo "Step 2: Creating GitHub repo..."
echo "Visit: https://github.com/new"
echo "Create new repo named: djezzy-bss-backend"
echo "Click 'Create repository' (don't initialize with README)"
read -p "Press Enter when done..."

echo ""
echo "Step 3: Pushing to GitHub..."
REPO_URL="https://github.com/$GITHUB_USER/djezzy-bss-backend.git"

git remote add origin "$REPO_URL" 2>/dev/null || git remote set-url origin "$REPO_URL"
git branch -M main
git push -u origin main

echo ""
echo "Step 4: Deploy on Render..."
echo "Visit: https://render.com"
echo "1. Sign in with GitHub"
echo "2. Click 'New +' → 'Web Service'"
echo "3. Select your 'djezzy-bss-backend' repo"
echo "4. Settings:"
echo "   - Name: djezzy-bss-api"
echo "   - Region: Oregon"
echo "   - Plan: Free"
echo "   - Leave Build/Start commands empty"
echo "5. Click 'Deploy'"
read -p "Press Enter when deployed and paste your Render URL: " RENDER_URL

echo ""
echo "✅ Your deployment URL: $RENDER_URL"
echo "📱 Update this URL in your app.js files"
