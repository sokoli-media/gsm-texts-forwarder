#!/bin/bash

echo "switching Huawei modem to modem mode..."
usb_modeswitch -v 12d1 -p 1446 -J || true

echo "waiting for the modem to load..."
sleep 5

echo "starting cron..."
cron -f
