#!/usr/bin/env bash
# bin/render-build.sh
# This script is executed by Render on every deployment.
# Exit immediately if any command fails.
set -o errexit

# Install Ruby gem dependencies (excluding development/test groups)
bundle install

# Precompile assets for production
bundle exec rails assets:precompile

# Clear the asset cache to avoid stale files between deploys
bundle exec rails assets:clean

# Run database migrations (safe to run on every deploy)
bundle exec rails db:migrate

# Seed the database only on the first deploy.
# The RENDER_INITIAL_DEPLOY env var is set automatically by Render.
if [[ $RENDER_INITIAL_DEPLOY == "true" ]]; then
  bundle exec rails db:seed
fi
