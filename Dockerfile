FROM python:3.13-slim

RUN apt update && apt install -y gammu libgammu-dev usb-modeswitch gcc && apt clean
RUN pip3 install python-gammu

COPY scripts/start.sh /usr/local/bin/start.sh
COPY scripts/forward_sms.py /usr/local/bin/forward_sms.py

CMD ["bash", "/usr/local/bin/start.sh"]
