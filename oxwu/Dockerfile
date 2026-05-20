FROM tsunglung/oxwu:1.0.5

# === HAOS 17.3+ kernel namespace restriction workaround ===
# Issue: After HAOS 17.3 (CVE-2026-31431 kernel patch),
#        unprivileged user namespace clones are blocked.
#        Chromium's namespace sandbox fails -> Electron FATAL.
# Fix:   3 actions combined (any one alone is insufficient):
#        1. Pre-extract AppImage at build time (bypass AppImage runtime that
#           swallows --no-sandbox flag)
#        2. Run as kasm-user (UID 1000) instead of root (bypass Electron's
#           geteuid()==0 forced sandbox check)
#        3. Pass --no-sandbox to AppRun (skip namespace sandbox attempt)

WORKDIR /opt

# 1. Extract AppImage so we can invoke AppRun directly
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        /Applications/oxwu-linux-armv7l.AppImage --appimage-extract && \
        mv squashfs-root oxwu-extracted && \
        chmod -R a+rX oxwu-extracted && \
        rm -f /opt/oxwu-extracted/chrome-sandbox && \
        chown -R kasm-user:root /opt/oxwu-extracted; \
    else \
        /Applications/oxwu-linux-x86_64.AppImage --appimage-extract && \
        mv squashfs-root oxwu-extracted && \
        chmod -R a+rX oxwu-extracted && \
        rm -f /opt/oxwu-extracted/chrome-sandbox && \
        chown -R kasm-user:root /opt/oxwu-extracted; \
    fi;

# 2. Disable original AppImage path (avoid any code path bypassing our patch)
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        mv /Applications/oxwu-linux-armv7l.AppImage \
        /Applications/oxwu-linux-x86_64.AppImage.disabled; \
    else \
        mv /Applications/oxwu-linux-armv7l.AppImage \
        /Applications/oxwu-linux-armv7l.AppImage.disabled; \
    fi;

# 3. Replace kasm's startup script with one that uses runuser + --no-sandbox
COPY custom_startup.sh /dockerstartup/custom_startup.sh
RUN chmod a+x /dockerstartup/custom_startup.sh
