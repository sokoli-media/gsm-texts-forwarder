import logging
import os
import sys

import gammu


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)


TARGET_NUMBER = os.getenv("TARGET_NUMBER")
if not TARGET_NUMBER:
    logging.error("missing TARGET_NUMBER environment variable")
    sys.exit(1)


def main() -> None:
    logging.info("configuring gammu...")

    sm = gammu.StateMachine()
    sm.ReadConfig()
    sm.Init()

    logging.info("checking for new messages...")
    while True:
        try:
            messages = sm.GetNextSMS(
                Location=0,
                Folder=0,
            )
        except gammu.ERR_EMPTY:
            logging.info("inbox empty, exiting")
            return None

        for message in messages:
            sender = message["Number"]
            text = message["Text"]

            logging.info("received a text from %s: %s", sender, text)

            sm.SendSMS({
                "Text": f"From {sender}: {text}",
                "SMSC": {"Location": 1},
                "Number": TARGET_NUMBER,
            })
            sm.DeleteSMS(
                Folder=message["Folder"],
                Location=message["Location"],
            )
            logging.info("message has been forwarded and deleted")


if __name__ == "__main__":
    main()
