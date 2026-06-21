#!/bin/bash
# Drone satellite setup — Raspberry Pi 4 + ReSpeaker 2-Mic Pi HAT
# Run as the drone user (e.g. drone1) after first boot.
#
# Phase 1: installs the ReSpeaker audio driver, then prompts reboot.
# Phase 2: run again after reboot — installs wyoming-satellite +
#          wyoming-openwakeword, writes systemd services, starts everything.
#
# When complete, add the satellite in Home Assistant:
#   Settings → Devices & Services → Add Integration → Wyoming Protocol
#   Host: <drone IP>   Port: 10700

set -euo pipefail

JARVIS_IP="192.168.50.200"
SATELLITE_PORT=10700
WAKE_PORT=10400
WAKE_WORD="hey_jarvis"
PHASE_FILE="$HOME/.drone_setup_phase"
DRONE_USER="$USER"

phase=$(cat "$PHASE_FILE" 2>/dev/null || echo "1")

# ── Phase 1: seeed-voicecard driver ──────────────────────────────────────────
if [ "$phase" = "1" ]; then
    echo "=== Phase 1: Installing seeed-voicecard driver ==="

    sudo apt-get update
    sudo apt-get install -y git dkms linux-headers-$(uname -r)

    cd "$HOME"
    git clone https://github.com/HinTak/seeed-voicecard.git
    cd seeed-voicecard
    sudo ./install.sh

    echo "2" > "$PHASE_FILE"
    echo ""
    echo "Driver installed. Reboot now, then run this script again."
    echo "  sudo reboot"
    exit 0
fi

# ── Phase 2: wyoming-satellite + wyoming-openwakeword ────────────────────────
if [ "$phase" = "2" ]; then
    echo "=== Phase 2: Installing wyoming-satellite and wyoming-openwakeword ==="

    sudo apt-get update
    sudo apt-get install -y python3-venv python3-pip libopenblas-dev

    # Enable SPI for ReSpeaker LED ring (APA102 via spidev)
    if ! grep -q "^dtparam=spi=on" /boot/firmware/config.txt 2>/dev/null; then
        echo "dtparam=spi=on" | sudo tee -a /boot/firmware/config.txt
    fi

    # Verify audio card is present before continuing
    if ! arecord -l 2>/dev/null | grep -q "seeed2micvoicec"; then
        echo "ERROR: ReSpeaker card (seeed2micvoicec) not found."
        echo "Check driver install and confirm reboot completed."
        echo "Run: arecord -l"
        exit 1
    fi

    # LED control script — scp drone/led.py from the jarvis repo before running phase 2:
    #   scp ~/code/jarvis/drone/led.py drone1:~/drone/led.py
    mkdir -p "$HOME/drone"
    if [ ! -f "$HOME/drone/led.py" ]; then
        echo "ERROR: ~/drone/led.py not found on this machine."
        echo "Copy it over first: scp ~/code/jarvis/drone/led.py drone1:~/drone/led.py"
        exit 1
    fi
    chmod +x "$HOME/drone/led.py"

    # wyoming-openwakeword
    cd "$HOME"
    git clone https://github.com/rhasspy/wyoming-openwakeword.git
    cd wyoming-openwakeword
    python3 -m venv .venv
    .venv/bin/pip install --upgrade pip
    .venv/bin/pip install -e .

    # wyoming-satellite
    cd "$HOME"
    git clone https://github.com/rhasspy/wyoming-satellite.git
    cd wyoming-satellite
    python3 -m venv .venv
    .venv/bin/pip install --upgrade pip
    .venv/bin/pip install -e .
    .venv/bin/pip install spidev pixel-ring

    # ── systemd: wyoming-openwakeword ─────────────────────────────────────────
    sudo tee /etc/systemd/system/wyoming-openwakeword.service > /dev/null <<EOF
[Unit]
Description=Wyoming OpenWakeWord
After=network.target

[Service]
Type=simple
User=$DRONE_USER
WorkingDirectory=$HOME/wyoming-openwakeword
ExecStart=$HOME/wyoming-openwakeword/.venv/bin/python -m wyoming_openwakeword \\
    --uri tcp://0.0.0.0:$WAKE_PORT
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    # ── systemd: wyoming-satellite ────────────────────────────────────────────
    sudo tee /etc/systemd/system/wyoming-satellite.service > /dev/null <<EOF
[Unit]
Description=Wyoming Satellite
Wants=wyoming-openwakeword.service
After=network-online.target wyoming-openwakeword.service
Wants=network-online.target

[Service]
Type=simple
User=$DRONE_USER
WorkingDirectory=$HOME/wyoming-satellite
ExecStart=$HOME/wyoming-satellite/.venv/bin/python -m wyoming_satellite \\
    --name "$HOSTNAME" \\
    --uri tcp://0.0.0.0:$SATELLITE_PORT \\
    --mic-command "arecord -D plughw:CARD=seeed2micvoicec,DEV=0 -r 16000 -c 1 -f S16_LE -t raw" \\
    --snd-command "aplay -D plughw:CARD=seeed2micvoicec,DEV=0 -r 22050 -c 1 -f S16_LE -t raw" \\
    --wake-uri tcp://127.0.0.1:$WAKE_PORT \\
    --wake-word-name "$WAKE_WORD" \\
    --detection-command "$HOME/wyoming-satellite/.venv/bin/python $HOME/drone/led.py listen" \\
    --transcript-command "$HOME/wyoming-satellite/.venv/bin/python $HOME/drone/led.py think" \\
    --tts-start-command "$HOME/wyoming-satellite/.venv/bin/python $HOME/drone/led.py speak" \\
    --tts-stop-command "$HOME/wyoming-satellite/.venv/bin/python $HOME/drone/led.py off"
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
    sudo systemctl enable wyoming-openwakeword wyoming-satellite
    sudo systemctl start wyoming-openwakeword wyoming-satellite

    echo "3" > "$PHASE_FILE"
    echo ""
    echo "=== Setup complete ==="
    echo ""
    echo "Services running:"
    echo "  wyoming-openwakeword  — port $WAKE_PORT (local wake word: $WAKE_WORD)"
    echo "  wyoming-satellite     — port $SATELLITE_PORT"
    echo ""
    echo "In Home Assistant, add Wyoming integration:"
    echo "  Settings → Devices & Services → Add Integration → Wyoming Protocol"
    echo "  Host: $(hostname -I | awk '{print $1}')   Port: $SATELLITE_PORT"
    echo ""
    echo "Check service logs if anything seems wrong:"
    echo "  journalctl -u wyoming-satellite -f"
    echo "  journalctl -u wyoming-openwakeword -f"
fi
