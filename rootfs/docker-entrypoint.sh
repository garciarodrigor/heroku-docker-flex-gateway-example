#!/bin/sh
# vim:sw=4:ts=4:et

ENTRYPOINT_DIR=${ENTRYPOINT_DIR:=/docker-entrypoint.d}

set -e

_log() {
    if [ "$ENTRYPOINT_LOGS_ENABLED" = 'true' ]; then
        echo "$@"
    fi
}


_log "$0: Looking for shell scripts in ${ENTRYPOINT_DIR}"
if [ -d "${ENTRYPOINT_DIR}" ]; then
  find "${ENTRYPOINT_DIR}" -follow -type f -print | sort -V | while read -r f; do
      case "$f" in
          *.envsh)
              if [ -x "$f" ]; then
                  _log "$0: Sourcing $f";
                  . "$f"
              else
                  # warn on shell scripts without exec bit
                  _log "$0: Ignoring $f, not executable";
              fi
              ;;
          *.sh)
              if [ -x "$f" ]; then
                  _log "$0: Launching $f";
                  "$f"
              else
                  # warn on shell scripts without exec bit
                  _log "$0: Ignoring $f, not executable";
              fi
              ;;
          *) _log "$0: Ignoring $f";;
      esac
  done
fi
_log "$0: Configuration complete; ready for start up"

exec "$@"
