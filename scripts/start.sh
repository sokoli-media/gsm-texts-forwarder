#!/bin/bash

# switch Huawei modem to modem mode
usb_modeswitch -v 12d1 -p 1446 -J || true

# wait a few seconds for ttyUSB devices to appear
sleep 5

# start cron
cron -f
