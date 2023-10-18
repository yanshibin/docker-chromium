#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

export HOME=/config
mkdir -p /config/profile
mkdir -p /config/log/chromium
rm -rf /config/profile/Singleton* # remove chrome Singleton mode
whoami
exec /usr/bin/firefox_wrapper --no-sandbox --user-data-dir=/config/profile >> /config/log/chromium/output.log 2>> /config/log/chromium/error.log
