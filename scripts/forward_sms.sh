#!/bin/bash

cat > /root/.gammurc <<EOF
[gammu]
device = $GAMMU_DEVICE
connection = at
EOF

echo "config has been updated"

count=$(gammu --getfolders | grep -i 'Inbox' | awk '{print $4}')

echo "looking for new texts..."

if [ "$count" -ge 1 ]; then
  for i in $(seq 1 $count); do
    msg=$(gammu getsms INBOX $i $i | awk '/Text:/ {print substr($0,7)}')
    sender=$(gammu getsms INBOX $i $i | awk '/Sender:/ {print $2}')

    gammu sendsms TEXT "$TARGET_NUMBER" -text "From $sender: $msg"

    echo "forwarded $msg from $sender to $TARGET_NUMBER"

    gammu deletesms INBOX $i
  done
fi

echo "forwarder has finished"
