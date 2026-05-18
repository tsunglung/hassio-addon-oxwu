#!/bin/bash
# OXWU startup script - patched for HAOS 17.3+ Electron sandbox compatibility
# See: addon Dockerfile comments for full explanation
set -e

OXWU_ALERT_INTENSITY=$(grep oxwu_alert_intensity /data/options.json 2>/dev/null | cut -d: -f2 | tr -d '" ,')

[ -f /app/notify.sh ] && chmod a+x /app/notify.sh
[ -f /config/oxwu/notify.sh ] && chmod a+x /config/oxwu/notify.sh

mkdir -p /home/kasm-user/.config/oxwu/
[ -f /tmp/settings.json ] && cp /tmp/settings.json /home/kasm-user/.config/oxwu/settings.json
[ -f /config/oxwu/settings.json ] && cp /config/oxwu/settings.json /home/kasm-user/.config/oxwu/settings.json
[ "x$OXWU_ALERT_INTENSITY" != "x" ] && \
    sed -i "s/\"alertIntensity\":.*/\"alertIntensity\": $OXWU_ALERT_INTENSITY,/g" \
        /home/kasm-user/.config/oxwu/settings.json

# Fix /home/kasm-user permissions (kasm-user needs to write SingletonLock, etc.)
chown -R kasm-user:kasm-user /home/kasm-user 2>/dev/null
chmod -R u+rwX /home/kasm-user 2>/dev/null

# Run as kasm-user, invoke extracted AppRun directly with --no-sandbox
exec runuser -u kasm-user -- env APPDIR=/opt/oxwu-extracted HERE=/opt/oxwu-extracted bash -c '
cd /opt/oxwu-extracted
exec ./AppRun --no-sandbox
'
