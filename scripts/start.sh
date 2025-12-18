#!/bin/bash

set -e

: "${GAMMU_DEVICE:?GAMMU_DEVICE env var not set}"
: "${TARGET_NUMBER:?TARGET_NUMBER env var not set}"

echo "switching Huawei modem to modem mode..."
usb_modeswitch -v 12d1 -p 1446 -J || true

echo "waiting for the modem to load..."
sleep 5


while true; do
  echo "starting forwarder..."
  /usr/local/bin/forward_sms.sh

  echo "waiting..."
  sleep 60
done