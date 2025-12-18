FROM debian:bookworm-slim

RUN apt update && apt install -y gammu usb-modeswitch cron bash && apt clean

COPY scripts/start.sh /usr/local/bin/start.sh
COPY scripts/forward_sms.sh /usr/local/bin/forward_sms.sh

RUN echo "* * * * * root /usr/local/bin/forward_sms.sh >> /var/log/sms_forward.log 2>&1" > /etc/cron.d/sms_forward

CMD ["bash", "/usr/local/bin/start.sh"]
