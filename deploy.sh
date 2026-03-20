#!/bin/bash
# Deploy to Cloudflare Pages (rahulsharma.ai)
# Usage: ./deploy.sh

set -e

# Use env var or prompt
if [ -z "$CLOUDFLARE_API_TOKEN" ]; then
    echo "Set CLOUDFLARE_API_TOKEN env var or export it first"
    echo "  export CLOUDFLARE_API_TOKEN=your_token_here"
    exit 1
fi

COMMIT_HASH=$(git rev-parse HEAD 2>/dev/null || echo "manual")
COMMIT_MSG=$(git log -1 --pretty=%s 2>/dev/null || echo "manual deploy")

echo "Deploying to rahulsharma.ai..."
npx wrangler pages deploy . \
    --project-name=rahulsharma-ai \
    --branch=main \
    --commit-hash="$COMMIT_HASH" \
    --commit-message="$COMMIT_MSG" \
    --commit-dirty=true

echo ""
echo "Done! Live at https://rahulsharma.ai"
