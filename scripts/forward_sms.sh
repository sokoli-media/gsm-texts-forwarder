#!/bin/bash

if [ -z "$GAMMU_DEVICE" ]; then
  echo "GAMMU_DEVICE is not set"
  exit 1
else
  echo "GAMMU_DEVICE is set to $GAMMU_DEVICE"
fi

if [ -z "$TARGET_NUMBER" ]; then
  echo "TARGET_NUMBER is not set"
  exit 1
else
  echo "TARGET_NUMBER is set to $TARGET_NUMBER"
fi

cat > /root/.gammurc <<EOF
[gammu]
device = $GAMMU_DEVICE
connection = at
EOF

count=$(gammu --getfolders | grep -i 'Inbox' | awk '{print $4}')

if [ "$count" -ge 1 ]; then
  for i in $(seq 1 $count); do
    msg=$(gammu getsms INBOX $i $i | awk '/Text:/ {print substr($0,7)}')
    sender=$(gammu getsms INBOX $i $i | awk '/Sender:/ {print $2}')

    gammu sendsms TEXT "$TARGET_NUMBER" -text "From $sender: $msg"

    echo "Forwarded $msg from $sender to $TARGET_NUMBER"

    gammu deletesms INBOX $i
  done
fi
