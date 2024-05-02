# OX Wake Up

OX Wake Up, a Home Assistant Add-on, run OXWU to get earthquake alert.

See https://github.com/tsunglung/hassio-addon-oxwu

To access Kasm VNC, use https://[ha-ip]:/6901

User: kasm_user

Password: vncpassword

## Configuration

Create a settings.json in /config/oxwu of Home Assistant.
Then configure the "townID" according to https://hub.docker.com/r/jscat/oxwu and configure the "alertIntensity".


```
{
    "warning": {
        "townID": 6703500,
        "alertIntensity": 2,
        "applySiteEffect": true,
        "popupWindow": true,
        "popupNotification": true,
        "playSound": false,
        "alwaysOnTop": true,
        "showPWave": true,
        "smoothWave": false,
        "defaultSound": "0",
        "customSound": null
    },
    "report": {
        "popupWindow": false,
        "popupNotification": false,
        "playSound": false,
        "showIntensity": true,
        "customSound": null
    },
    "autorun": true,
    "autoDownload": false,
    "connectPath": "/config/oxwu/notify.sh",
    "connectOnce": true,
    "scale": 0.75
}
```

Also you can create a script notify.sh in "/config/oxwu" to customize notify.
Make sure that "/config/oxwu/notify.sh" is executable. If not, use terminal of HA to chmod.
```
chmod a+x /config/oxwu/notify.sh
```