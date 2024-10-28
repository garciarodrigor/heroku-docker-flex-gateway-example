#!/usr/bin/env sh
# shellcheck shell=sh
# Setup Flex Redis Shared Storage

HEROKU_REDIS_CONFIG_PATH=${HEROKU_REDIS_CONFIG_PATH:-/usr/local/share/mulesoft/flex-gateway/conf.d/shared-storage-redis.configuration.yaml}

_log() {
    if [ "$ENTRYPOINT_LOGS_ENABLED" = 'true' ]; then
        echo "$@"
    fi
}

# This regular expression is used to parse and extract information
# from a Redis connection string in the format "rediss://user:password@host:port".
#
# - "^rediss://" is the starting point of the string, indicating that it begins with the protocol "rediss://".
# - "([^:]*)" captures any characters that are not a colon ":" zero or more times, representing the username in the connection string.
# - "([^@]+)" captures any characters that are not an "@" symbol one or more times, representing the password in the connection string.
# - "@([^/]+)" captures any characters that are not a forward slash "/" one or more times, representing the host or server address in the connection string.
regex="^rediss:\/\/([^:]*):([^@]+)@([^\/]+)"
if [ -n "$REDIS_URL" ]; then
  REDIS_USER=$(echo "$REDIS_URL" | sed -E "s/$regex/\1/")
  REDIS_PASSWORD=$(echo "$REDIS_URL" | sed -E "s/$regex/\2/")
  REDIS_ADDRESS=$(echo "$REDIS_URL" | sed -E "s/$regex/\3/")

  _log "$0: Setup Flex Shared Storage, using REDIS located in '${REDIS_ADDRESS}'"

  cat <<EOF > "${HEROKU_REDIS_CONFIG_PATH}"
---
apiVersion: gateway.mulesoft.com/v1alpha1
kind: Configuration
metadata:
  name: shared-storage-redis
spec:
  sharedStorage:
    redis:
      address: "${REDIS_ADDRESS}"
      username: "${REDIS_USER}"
      password: "${REDIS_PASSWORD}"
      tls:
        skipValidation: true
        minVersion: "1.1"
        maxVersion: "1.3"
EOF
fi
