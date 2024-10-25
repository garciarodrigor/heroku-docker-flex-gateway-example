#!/usr/bin/env sh
# shellcheck shell=sh
# Setup Flex Redis Shared Storage

if [ -n "$REDIS_TEMPORARY_URL" ]; then
  # Extract password (between '://' and '@')
  REDIS_PASSWORD=$(echo "$REDIS_TEMPORARY_URL" | sed -E 's/^redis:\/\/:([^@]+)@.*$/\1/')

  # Extract address (after '@' to end, split address and port by ':')
  REDIS_ADDRESS=$(echo "$REDIS_TEMPORARY_URL" | sed -E 's/^redis:\/\/:[^@]+@([^:]+):([0-9]+)$/\1:\2/')

  # Set environment variables for the current shell session
  cat <<EOF > /usr/local/share/mulesoft/flex-gateway/conf.d/shared-storage-redis.configuration.yaml
---
apiVersion: gateway.mulesoft.com/v1alpha1
kind: Configuration
metadata:
  name: shared-storage-redis
spec:
  sharedStorage:
    redis:
      address: "${REDIS_ADDRESS}"
      username: ""
      password: "${REDIS_PASSWORD}"
      db: 0
      # tls:
      #   skipValidation: true
EOF
fi
