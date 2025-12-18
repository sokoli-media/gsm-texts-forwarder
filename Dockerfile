FROM debian:bookworm-slim

RUN apt update && apt install -y gammu usb-modeswitch bash && apt clean

COPY scripts/start.sh /usr/local/bin/start.sh
COPY scripts/forward_sms.sh /usr/local/bin/forward_sms.sh

CMD ["bash", "/usr/local/bin/start.sh"]
