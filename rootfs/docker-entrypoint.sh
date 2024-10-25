#!/bin/sh
# vim:sw=4:ts=4:et

set -e

entrypoint_log() {
    if [ "$ENTRYPOINT_LOGS_ENABLED" = 'true' ]; then
        echo "$@"
    fi
}


entrypoint_log "$0: Looking for shell scripts in /docker-entrypoint.d/"
if [ -d "/docker-entrypoint.d/" ]; then
  find "/docker-entrypoint.d/" -follow -type f -print | sort -V | while read -r f; do
      case "$f" in
          *.envsh)
              if [ -x "$f" ]; then
                  entrypoint_log "$0: Sourcing $f";
                  . "$f"
              else
                  # warn on shell scripts without exec bit
                  entrypoint_log "$0: Ignoring $f, not executable";
              fi
              ;;
          *.sh)
              if [ -x "$f" ]; then
                  entrypoint_log "$0: Launching $f";
                  "$f"
              else
                  # warn on shell scripts without exec bit
                  entrypoint_log "$0: Ignoring $f, not executable";
              fi
              ;;
          *) entrypoint_log "$0: Ignoring $f";;
      esac
  done
fi
entrypoint_log "$0: Configuration complete; ready for start up"

exec "$@"
