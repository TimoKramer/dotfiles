#!/usr/bin/env python3
"""Tray icon showing mount status for home-timo-mailboxdrive.mount"""

import subprocess
import threading
import time

import pystray
from PIL import Image, ImageDraw

MOUNT_UNIT = "home-timo-mailboxdrive.mount"
CHECK_INTERVAL = 10  # seconds


def is_mounted():
    """Check if the systemd mount unit is active."""
    result = subprocess.run(
        ["systemctl", "is-active", MOUNT_UNIT],
        capture_output=True,
        text=True,
    )
    return result.stdout.strip() == "active"


def create_icon(color):
    """Create a simple colored circle icon."""
    size = 64
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    draw.ellipse([4, 4, size - 4, size - 4], fill=color)
    return img


def get_status_text():
    return "Mounted" if is_mounted() else "Not mounted"


def update_icon(icon):
    """Periodically update icon based on mount status."""
    while icon.visible:
        mounted = is_mounted()
        icon.icon = create_icon("green" if mounted else "red")
        icon.title = f"Mailbox Drive: {get_status_text()}"
        time.sleep(CHECK_INTERVAL)


def setup(icon):
    icon.visible = True
    threading.Thread(target=update_icon, args=(icon,), daemon=True).start()


menu = pystray.Menu(
    pystray.MenuItem(lambda text: get_status_text(), None, enabled=False),
    pystray.Menu.SEPARATOR,
    pystray.MenuItem("Quit", lambda icon, item: icon.stop()),
)

icon = pystray.Icon("mailbox-mount", create_icon("gray"), "Mailbox Drive", menu)

icon.run(setup)
