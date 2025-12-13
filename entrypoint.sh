#!/bin/bash
set -e

# Function to wait for Redis
wait_for_redis() {
  echo "? Waiting for Redis..."
  local max_attempts=30
  local attempt=0
  
  while [ $attempt -lt $max_attempts ]; do
    if timeout 1 bash -c "cat < /dev/null > /dev/tcp/decidim-modules-redis/6379" 2>/dev/null; then
      echo "? Redis is ready"
      return 0
    fi
    attempt=$((attempt + 1))
    echo "? Waiting for Redis... ($attempt/$max_attempts)"
    sleep 1
  done
  
  echo "? Redis connection timeout after $max_attempts attempts"
  exit 1
}

# Wait for Redis to be available
wait_for_redis

echo "? Checking if the database exists..."
if ! bundle exec rails db:exists >/dev/null 2>&1; then
  echo "?? Database does not exist. Creating the database..."
  bundle exec rails db:create
  echo "? Database created"
else
  echo "? Database already exists"
fi

echo "? Running database migrations..."
bundle exec rails db:migrate
echo "? Migrations are all up to date"

echo "? Starting Rails server..."
exec "$@"