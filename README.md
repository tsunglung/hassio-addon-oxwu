# OWXU Add-ons

This repository contains add-ons to Home Assistant related to OWXU

Installation:

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Ftsunglung%2Fhassio-addon-oxwu)

## Add-ons

This repository contains the following add-ons:

![Supports amd64 Architecture][amd64-shield]

[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg

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
