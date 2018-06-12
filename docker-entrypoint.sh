#!/bin/sh
set -e

isCommand() {
  for cmd in \
    "dot" \
    "dsm" \
    "help" \
    "list" \
    "metrics" \
    "test-features" \
    "text" \
    "uml"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

if [ "${1:0:1}" = "-" ]; then
  set -- /sbin/tini -- php /vendor/bin/dephpend "$@"
elif [ "$1" = "/vendor/bin/dephpend" ]; then
  set -- /sbin/tini -- php "$@"
elif [ "$1" = "dephpend" ]; then
  set -- /sbin/tini -- php /vendor/bin/"$@"
elif isCommand "$1"; then
  set -- /sbin/tini -- php /vendor/bin/dephpend "$@"
fi

exec "$@"
