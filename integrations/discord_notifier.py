import os
import requests
from dotenv import load_dotenv

# ==========================================================
# Load environment variables
# ==========================================================

load_dotenv("../../.env")

# ==========================================================
# Discord Webhook Configuration
# ==========================================================

DISCORD_WEBHOOK_URL = "https://discord.com/api/webhooks/1548301988825927772/R9g6Ri18UJ1dlisGcx2dWI7XOWjeuf_DrrC_WsGTvwLBPef_QH70m_G2KSY_SvaC-SS_"


def send_discord_alert(title: str, message: str) -> bool:
    """
    Sends a message to the configured Discord webhook.

    Returns:
        True  -> Alert sent successfully
        False -> Alert failed
    """

    if not DISCORD_WEBHOOK_URL:
        raise RuntimeError(
            "DISCORD_WEBHOOK_URL not found inside .env"
        )

    payload = {
        "embeds": [
            {
                "title": title,
                "description": message,
                "color": 16711680  # Red
            }
        ]
    }

    response = requests.post(
        DISCORD_WEBHOOK_URL,
        json=payload,
        timeout=30,
    )

    if response.status_code in (200, 204):
        print("Discord alert sent successfully.")
        return True

    print("Discord alert failed.")
    print(f"Status Code: {response.status_code}")
    print(response.text)

    return False


# ==========================================================
# Test the Discord webhook
# ==========================================================

if __name__ == "__main__":

    send_discord_alert(
        title="🚨 EPC Test Alert",
        message="This is a test alert from the EPC Platform."
    )