# 3D Printer Plan — Prusa MK3S+

## Hardware
| Spec | Value |
|---|---|
| Printer | Prusa MK3S+ |
| Build volume | 250 x 210 x 210 mm |
| Extruder | E3D V6, 0.4mm nozzle |
| Firmware | Prusa (Marlin-based) |
| Baud rate | 115200 |
| Connection | USB Type-B → JARVIS |
| USB device | `/dev/ttyUSB0` (verify before starting container) |

---

## Stack
| Layer | Tool |
|---|---|
| Print server | OctoPrint (Docker, port 5000) |
| Slicer | PrusaSlicer (on Melkhior) |
| HA integration | OctoPrint plugin for Home Assistant (optional) |

---

## Step 0 — Firmware Upgrade
- [ ] Install PrusaSlicer on your machine (Mac or Linux — both supported): https://www.prusa3d.com/page/prusaslicer_424/
- [ ] Connect Prusa MK3S+ via USB directly to that machine (not JARVIS — temporary, just for flashing)
- [ ] Power on the printer
- [ ] In PrusaSlicer: Help → Flash Printer Firmware
- [ ] Select printer: Original Prusa MK3S+
- [ ] Click Flash — PrusaSlicer downloads and flashes the latest firmware automatically
- [ ] Printer reboots and displays firmware version on screen — confirm, then move USB cable to JARVIS

## Step 1 — Physical Connection
- [ ] Locate USB Type-B cable (standard printer cable)
- [ ] Connect Prusa MK3S+ USB port to JARVIS
- [ ] Power on the printer
- [ ] Verify device appears on JARVIS:
```bash
ls /dev/ttyUSB* /dev/ttyACM*
```
- [ ] Note the device path — likely `/dev/ttyUSB0` or `/dev/ttyACM0`; update docker-compose if different

## Step 2 — Docker Setup
- [ ] Uncomment the `octoprint` service in `~/code/jarvis/docker/docker-compose.yml`
- [ ] Update the `devices` path if USB device is not `/dev/ttyUSB0`
- [ ] Add user to `dialout` group for USB serial access (required even in Docker):
```bash
sudo usermod -aG dialout $USER
```
- [ ] Start OctoPrint:
```bash
docker compose -f ~/code/jarvis/docker/docker-compose.yml up -d octoprint
```
- [ ] Confirm running: `docker ps | grep octoprint`

## Step 3 — Initial Setup Wizard
- [ ] Open `http://jarvis:5000` in browser
- [ ] Complete the setup wizard:
  - Create admin account
  - Skip printer profile for now (configure in Step 4)
  - Skip connectivity check

## Step 4 — Printer Profile
- [ ] Settings → Printer Profiles → Add Profile:

| Field | Value |
|---|---|
| Name | Prusa MK3S+ |
| Baud rate | 115200 |
| Build volume X | 250 mm |
| Build volume Y | 210 mm |
| Build volume Z | 210 mm |
| Heated bed | Yes |
| Heated chamber | No |
| Nozzle diameter | 0.4 mm |
| Number of extruders | 1 |

- [ ] Connect to printer — top bar → Connect (auto-detect port or select `/dev/ttyUSB0`)
- [ ] Confirm connection: printer state shows "Operational"

## Step 5 — Recommended Plugins
Install via Settings → Plugin Manager → Get More:

| Plugin | Purpose |
|---|---|
| Prusa Mesh Map | Visualizes mesh bed leveling grid |
| PrintTimeGenius | More accurate time estimates than stock |
| Bed Visualizer | Live bed mesh heatmap |
| Filament Manager | Track filament spools and usage |
| OctoEverywhere | Remote access without Tailscale (optional) |

- [ ] Install plugins and restart OctoPrint when prompted

## Step 6 — PrusaSlicer Integration (on Melkhior)
- [ ] Open PrusaSlicer → Printer Settings → General → Print Host
- [ ] Set Host: `http://jarvis:5000`
- [ ] Set API Key (OctoPrint → Settings → API → copy key)
- [ ] Test connection — green checkmark confirms it
- [ ] Slice a test file and send directly to OctoPrint via "Send to Printer" button

## Step 7 — Test Print
- [ ] Home all axes via OctoPrint control panel
- [ ] Preheat nozzle (215°C) and bed (60°C) for PLA
- [ ] Load a small test file (e.g. Prusa calibration cube)
- [ ] Confirm first layer adhesion before walking away

## Step 8 — Optional: Webcam
- [ ] Connect a USB webcam to JARVIS
- [ ] Add webcam to docker-compose octoprint service:
```yaml
devices:
  - /dev/ttyUSB0:/dev/ttyUSB0
  - /dev/video0:/dev/video0
environment:
  - CAMERA_DEV=/dev/video0
```
- [ ] Restart OctoPrint container
- [ ] Confirm webcam stream in OctoPrint control panel

## Step 9 — Optional: Home Assistant Integration
- [ ] Install OctoPrint integration in HA (Settings → Devices & Services → Add Integration → OctoPrint)
- [ ] Enter JARVIS IP and OctoPrint API key
- [ ] Confirm print status sensor appears in HA dashboard

---

## Notes
- Prusa MK3S+ uses a standard USB Type-B port (same as most printers/Arduinos) — not micro or mini USB
- Device path is usually `/dev/ttyACM0` on Linux for Prusa (ACM = Abstract Control Model, Prusa uses a USB CDC interface) — check with `ls /dev/tty*` after plugging in
- OctoPrint container must have the USB device passed through via `devices:` in docker-compose — the commented-out entry uses `/dev/ttyUSB0`, update if Prusa shows up as `/dev/ttyACM0`
- `dialout` group membership is required on the host for USB serial — log out and back in after `usermod` for it to take effect
- Never send a print job while the bed or nozzle are cold — always preheat first or use a start G-code that handles it
- PrusaSlicer's built-in profiles for MK3S+ are well-tuned — use them as a starting point rather than building from scratch
