# gsm-texts-forwarder aka "Huawei E173 SMS forwarder"

This is a simple script to redirect incoming texts to another phone number.

Requirements:
 * a gsm modem (tested with `Huawei E173`)
 * a sim card
 * UnRaid server (or any other docker-container-friendly thing)

How to use it?

1. install your gsm modem into any working usb port on your server
2. add a docker container, use `sokolimedia/gsm-texts-forwarder:latest` image
3. set `Privileged` to `True`
4. add mapping for the host path: `/dev/serial` (on UnRaid) to `/dev/serial` (in the container)
5. add `GAMMU_DEVICE` environmental variable with a path to the modem's AT connection (e.g. `/dev/serial/by-id/usb-HUAWEI_Technology_HUAWEI_Mobile-if04-port0`)
6. add `TARGET_NUMBER` with a phone number that messages should be redirected to (e.g. `+48123456789`)
7. start it, check logs for errors, enjoy!

Useful links:
 * [`gammu` api docs](https://docs.gammu.org/python/gammu.html)
 * [`gammu` binary docs](https://docs.gammu.org/gammu/)
