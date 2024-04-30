#!/usr/bin/env bash

# 移動滑鼠游標
screen_resolution=$(xrandr | grep -oP '\d{3,4}x\d{3,4}' | head -n 1)
xdotool mousemove $(echo $screen_resolution | cut -d 'x' -f 1) $(echo $screen_resolution | cut -d 'x' -f 2)

# 顯示一個時鐘
if [ "x$OXWU_XCLOCK" = "xtrue" ]; then
    sleep 10
    /usr/bin/xclock -digital \
        -fg "#222222" \
        -bg "#CECECE" \
        -face "文泉驛正黑:style=Bold" \
        -strftime "%Y-%m-%d %H:%M:%S ${OXWU_TOWN_NAME}" \
        -update 1 &

    sleep 1
    # 把時鐘移到左上角
    XCLOCK_WIN_ID=`VNC=:0 wmctrl -l | grep xclock | awk '{print $1}'`
    VNC=:0 wmctrl -i -r ${XCLOCK_WIN_ID} -b add,above
    VNC=:0 wmctrl -i -r ${XCLOCK_WIN_ID} -e 0,40,0,-1,-1
fi

# 串流畫面
if [ "x$OXWU_RTMP_URL" != "x" ]; then
    echo "啟動畫面串流…"
    ffmpeg \
        -framerate 30 \
        -video_size 1008x726 \
        -f x11grab \
        -i :1 \
        -f pulse \
        -i default \
        -c:v libx264 \
        -b:v 5000k \
        -maxrate 5000k \
        -bufsize 10000k \
        -g 60 \
        -vf format=yuv420p \
        -c:a aac \
        -b:a 128k \
        -f flv \
        ${OXWU_RTMP_URL}
fi

# Launch OXWU

if [ -f /app/notify.sh ]; then
    chmod a+x /app/notify.sh
fi

if [ -f /config/oxwu/notify.sh ]; then
    chmod a+x /config/oxwu/notify.sh
fi

mkdir -p /home/kasm-user/.config/oxwu/
if [ -f /tmp/settings.json ]; then
    cp /tmp/settings.json /home/kasm-user/.config/oxwu/settings.json
fi
if [ -f /config/oxwu/settings.json ]; then
    cp /config/oxwu/settings.json /home/kasm-user/.config/oxwu/settings.json
fi
if [ "x$OXWU_TOWN_ID" != "x" ]; then
    sed -i "s/\"townID\":.*/\"townID\": $OXWU_TOWN_ID,/g" /home/kasm-user/.config/oxwu/settings.json
fi
if [ "x$OXWU_ALERT_INTENSITY" != "x" ]; then
    sed -i "s/\"alertIntensity\":.*/\"alertIntensity\": $OXWU_ALERT_INTENSITY,/g" /home/kasm-user/.config/oxwu/settings.json
fi

if [ ! -e /dev/fuse ]; then
    echo "Fuse File System is not installed! Please install FUSE first."
fi
/Applications/oxwu-linux-x86_64.AppImage &

