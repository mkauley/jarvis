# Home AI Server Project Plan — JARVIS

## Project Overview
Build a local, private home AI server that runs a large language model, integrates with Home Assistant for home automation, provides a voice assistant interface, and serves as a NAS — all on a single physical machine. Server runs headless — all management via SSH or browser-based UIs from another device.

---

## Hardware ✅ COMPLETE

| Component | Selection |
|---|---|
| Motherboard | ASUS ROG Maximus Z790 Dark Hero ATX LGA1700 |
| CPU | Intel i9-14900K 3.2GHz 24-Core |
| RAM | 128GB G.Skill Trident Z5 RGB DDR5-6400 CL32 (2x 64GB kits) |
| GPU | ASUS ROG Strix OC GeForce RTX 4090 24GB |
| CPU Cooler | be quiet! Dark Rock Pro 5 (162.8mm — ~1mm clearance above RAM, confirmed fits) |
| Case | Antec C8 ATX Mid-Tower |
| PSU | Seasonic Focus GX V4 1000W 80+ Gold ATX 3.1 Fully Modular |
| Storage | See storage plan below |
| OS | Ubuntu Server 24.04 LTS |

### Storage Plan
| Drive | Size | Use |
|---|---|---|
| M.2 #1 (WD Black SN770) | 250GB | OS + Ollama models |
| M.2 #2 + M.2 #3 (RAID 1) | 500GB usable | Container volumes + NAS (mounted at `/mnt/nas`) |

### Future Storage Expansion
- Z790 Dark Hero has 5 M.2 slots total — 2 remaining slots available for additional NVMe drives
- Case has 2x 3.5" bays for traditional HDDs if bulk storage needed later

### Hardware Checklist
- [x] Physical build complete
- [x] System POSTing successfully
- [x] BIOS flashed to latest version
- [x] Ubuntu Server 24.04 LTS installed (minimized install, no snaps)
- [x] Static IP configured (192.168.50.200)
- [x] SSH configured with key authentication
- [x] SSH alias "jarvis" configured on Melkhior
- [x] OpenRGB installed and configured
- [x] RAM set to static blue via OpenRGB (persistent via crontab)
- [x] Corsair fans set to static blue via iCUE hardware lighting
- [x] JARVIS racked and running headless
- [ ] Apply Intel Baseline Profile in BIOS to protect CPU ⚠️ DO THIS BEFORE HEAVY USE
- [ ] Install NVIDIA drivers (next step)
- [ ] Run FurMark stress test 10-15 min after OS install, check 4090 power connector for excessive heat
- [ ] GPU sag bracket recommended (4090 is ~2.2 lbs, 24/7 operation) — search "GPU support bracket heavy" on Amazon/Newegg
- [ ] USB microphone + speaker (or dedicated voice satellite hardware)

### Hardware Notes
- PSU is ATX 3.1 native — no 4090 power adapter needed, eliminates connector melting risk
- Dark Rock Pro 5 front fan is repositionable if RAM clearance becomes an issue
- CPU cooler mounting brackets must be oriented correctly or cooler rotates 90 degrees (learned this the hard way)
- Network is on 192.168.50.x subnet (not 192.168.1.x)
- JARVIS static IP set to 192.168.50.200 during OS install
- Corsair iCUE Link QX120 RGB fans controlled via OpenRGB (HID device, requires i2c-dev for full control)
- Ubuntu 26.04 missing linux-modules-extra for kernel 7.0 — downgraded to 24.04 LTS for stability
- OS updated to Ubuntu Server 24.04 LTS

### Hardware Reference Links
- [BIOS Updates — ASUS ROG Maximus Z790 Dark Hero](https://rog.asus.com/us/motherboards/rog-maximus/rog-maximus-z790-dark-hero/helpdesk_bios/)
- [Motherboard Manual (PDF)](https://dlcdnta.asus.com/pub/ASUS/mb/LGA1700/ROG_MAXIMUS_Z790_DARK_HERO/E22500_ROG_MAXIMUS_Z790_DARK_HERO_EM_WEB.pdf)
- [Corsair iCUE Link QX120 RGB Fan Info](https://www.corsair.com/us/en/explorer/diy-builder/fans/qx-rgb-fan/)
- [Corsair iCUE Link QX120 RGB Starter Kit](https://www.corsair.com/us/en/p/case-fans/co-9051002-ww/icue-link-qx120-rgb-120mm-pwm-pc-fans-starter-kit-with-icue-link-system-hub-co-9051002-ww)
- [PCPartPicker Part List](https://pcpartpicker.com/list/vzRC6B)

### PCPartPicker Part List

<a href="https://pcpartpicker.com/list/vzRC6B">PCPartPicker Part List</a>
<table class="pcpp-part-list">
  <thead>
    <tr>
      <th>Type</th>
      <th>Item</th>
      <th>Price</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="pcpp-part-list-type">CPU</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/ZLjRsY/intel-core-i9-14900k-32-ghz-24-core-processor-bx8071514900k">Intel Core i9-14900K 3.2 GHz 24-Core Processor</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/ZLjRsY/intel-core-i9-14900k-32-ghz-24-core-processor-bx8071514900k">$464.00 @ Newegg</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">CPU Cooler</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/LyyH99/be-quiet-dark-rock-pro-5-cpu-cooler-bk036">be quiet! Dark Rock Pro 5 CPU Cooler</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/LyyH99/be-quiet-dark-rock-pro-5-cpu-cooler-bk036">$79.90 @ Newegg</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Motherboard</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/PnXV3C/asus-rog-maximus-z790-dark-hero-atx-lga1700-motherboard-rog-maximus-z790-dark-hero">Asus ROG MAXIMUS Z790 DARK HERO ATX LGA1700 Motherboard</a></td>
      <td class="pcpp-part-list-price"></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Memory</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/636p99/gskill-trident-z5-rgb-64-gb-2-x-32-gb-ddr5-6400-cl32-memory-f5-6400j3239g32gx2-tz5rk">G.Skill Trident Z5 RGB 64 GB (2 x 32 GB) DDR5-6400 CL32 Memory</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/636p99/gskill-trident-z5-rgb-64-gb-2-x-32-gb-ddr5-6400-cl32-memory-f5-6400j3239g32gx2-tz5rk">$899.99 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Memory</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/636p99/gskill-trident-z5-rgb-64-gb-2-x-32-gb-ddr5-6400-cl32-memory-f5-6400j3239g32gx2-tz5rk">G.Skill Trident Z5 RGB 64 GB (2 x 32 GB) DDR5-6400 CL32 Memory</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/636p99/gskill-trident-z5-rgb-64-gb-2-x-32-gb-ddr5-6400-cl32-memory-f5-6400j3239g32gx2-tz5rk">$899.99 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Storage</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/fJZ9TW/western-digital-black-sn770-250-gb-m2-2280-pcie-40-x4-nvme-solid-state-drive-wds250g3x0e">Western Digital Black SN770 250 GB M.2-2280 PCIe 4.0 X4 NVME Solid State Drive</a></td>
      <td class="pcpp-part-list-price"></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Storage</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/MNQwrH/inland-qn450-1-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-1tb-qn450">Inland QN450 1 TB M.2-2280 PCIe 4.0 X4 NVME Solid State Drive</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/MNQwrH/inland-qn450-1-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-1tb-qn450">$184.99 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Storage</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/MNQwrH/inland-qn450-1-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-1tb-qn450">Inland QN450 1 TB M.2-2280 PCIe 4.0 X4 NVME Solid State Drive</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/MNQwrH/inland-qn450-1-tb-m2-2280-pcie-40-x4-nvme-solid-state-drive-1tb-qn450">$184.99 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Video Card</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/ZKWzK8/asus-rog-strix-gaming-oc-geforce-rtx-4090-24-gb-video-card-rog-strix-rtx4090-o24g-gaming">Asus ROG STRIX GAMING OC GeForce RTX 4090 24 GB Video Card</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/ZKWzK8/asus-rog-strix-gaming-oc-geforce-rtx-4090-24-gb-video-card-rog-strix-rtx4090-o24g-gaming">$3499.95 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Case</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/yxdG3C/antec-c8-atx-mid-tower-case-c8">Antec C8 ATX Full Tower Case</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/yxdG3C/antec-c8-atx-mid-tower-case-c8">$99.99 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Power Supply</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/YkCZxr/seasonic-focus-gx-atx-30-v4-2024-1000-w-80-gold-certified-fully-modular-atx-power-supply-focus-gx-1000-v4">SeaSonic Focus GX V4 ATX 3 (2024) 1000 W 80+ Gold Certified Fully Modular ATX Power Supply</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/YkCZxr/seasonic-focus-gx-atx-30-v4-2024-1000-w-80-gold-certified-fully-modular-atx-power-supply-focus-gx-1000-v4">$178.99 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Case Fan</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/4VBzK8/corsair-icue-link-qx120-rgb-starter-kit-631-cfm-120-mm-fans-3-pack-co-9051002-ww">Corsair iCUE LINK QX120 RGB Starter Kit 63.1 CFM 120 mm Fans 3-Pack</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/4VBzK8/corsair-icue-link-qx120-rgb-starter-kit-631-cfm-120-mm-fans-3-pack-co-9051002-ww">$109.99 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Case Fan</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/4VBzK8/corsair-icue-link-qx120-rgb-starter-kit-631-cfm-120-mm-fans-3-pack-co-9051002-ww">Corsair iCUE LINK QX120 RGB Starter Kit 63.1 CFM 120 mm Fans 3-Pack</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/4VBzK8/corsair-icue-link-qx120-rgb-starter-kit-631-cfm-120-mm-fans-3-pack-co-9051002-ww">$109.99 @ Amazon</a></td>
    </tr>
    <tr>
      <td class="pcpp-part-list-type">Case Fan</td>
      <td class="pcpp-part-list-item"><a href="https://pcpartpicker.com/product/4VBzK8/corsair-icue-link-qx120-rgb-starter-kit-631-cfm-120-mm-fans-3-pack-co-9051002-ww">Corsair iCUE LINK QX120 RGB Starter Kit 63.1 CFM 120 mm Fans 3-Pack</a></td>
      <td class="pcpp-part-list-price"><a href="https://pcpartpicker.com/product/4VBzK8/corsair-icue-link-qx120-rgb-starter-kit-631-cfm-120-mm-fans-3-pack-co-9051002-ww">$109.99 @ Amazon</a></td>
    </tr>
    <tr class="pcpp-part-list-price-note">
      <td></td>
      <td class="pcpp-part-list-price-note">Prices include shipping, taxes, rebates, and discounts</td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td class="pcpp-part-list-total">Total</td>
      <td class="pcpp-part-list-total-price">$6822.76</td>
    </tr>
    <tr>
      <td></td>
      <td class="pcpp-part-list-price-note">Generated by <a href="https://pcpartpicker.com">PCPartPicker</a> 2026-05-25 20:57 EDT-0400</td>
      <td></td>
    </tr>
  </tbody>
</table>

---

## Target Stack

| Layer | Tool |
|---|---|
| Base OS | Ubuntu Server 24.04 LTS |
| Container runtime | Docker + Docker Compose (CLI-first approach) |
| Container GUI | Portainer (installed but use CLI for learning) |
| LLM engine | Ollama (Llama 3 70B) |
| Home automation | Home Assistant |
| NAS | Samba share |
| Wake word detection | Wyoming protocol (via HA) |
| Speech to Text | Whisper (local) |
| Text to Speech | Coqui TTS (local, voice cloning) |
| Remote access | Tailscale (HA mobile app + NAS from anywhere) |
| 3D printer control | OctoPrint (USB connected) |
| File sync | Nextcloud + rclone (Google Drive mirror) |
| LLM chat UI | Open WebUI |

### VRAM Allocation
| Service | Estimated VRAM |
|---|---|
| Llama 3 70B | ~20GB |
| Coqui TTS | ~2-3GB |
| Total | ~22-23GB (fits within 24GB) |

### GUI Access (all from another device's browser — server stays headless)
| Tool | URL |
|---|---|
| Portainer | http://192.168.50.200:9000 |
| Home Assistant | http://192.168.50.200:8123 |
| OctoPrint | http://192.168.50.200:5000 |
| Nextcloud | http://192.168.50.200:8080 |
| Open WebUI | http://192.168.50.200:3000 |

---

## Implementation Steps

### Phase 1 — Base Server Setup ✅ COMPLETE
- [x] Physical build complete
- [x] BIOS flashed to latest version
- [x] Ubuntu Server 24.04 LTS installed (minimized install, no snaps)
- [x] Static IP configured (192.168.50.200)
- [x] SSH enabled and verified
- [x] SSH key authentication configured (Melkhior → JARVIS)
- [x] SSH alias "jarvis" configured on Melkhior
- [x] /etc/hosts updated on Melkhior (jarvis → 192.168.50.200)
- [x] NVIDIA drivers installed (v595.71.05, CUDA 13.2)
- [x] nvidia-smi verified — RTX 4090 recognized, 24GB VRAM
- [ ] Apply Intel Baseline Profile in BIOS ⚠️ DO THIS BEFORE HEAVY USE

### Phase 2 — Docker & Container Management ✅ COMPLETE
- [x] Docker installed (v29.5.2) via get.docker.com script
- [x] User added to docker group
- [x] Git installed and configured on JARVIS
- [x] GitHub SSH key added for JARVIS
- [x] Git repo created at ~/code/jarvis (all configs stored here)
- [x] Consolidated docker-compose at ~/code/jarvis/docker/docker-compose.yml (all services in one file)
- [x] Container management script at ~/code/jarvis/bash/container.sh
- [x] Portainer accessible at http://jarvis:9000
- [x] nvidia-container-toolkit installed (required for GPU passthrough to Docker containers)

### Docker install notes
- Use `curl -fsSL https://get.docker.com | sh` — NOT `apt install docker.io`
- Remove any broken PPAs before running (e.g. thopiekar/openrgb caused apt failures)
- Docker Compose is included in the get.docker.com install — no separate install needed

### Useful Docker CLI commands to know
```bash
docker ps                              # list running containers
docker ps -a                           # list all containers including stopped
docker logs <container_name>           # view container logs
docker stop <container_name>           # stop a container
docker start <container_name>          # start a container
docker restart <container_name>        # restart a container
docker images                          # list downloaded images
docker exec -it <container_name> bash  # open shell inside container
```

### Phase 3 — LLM (Ollama + Open WebUI)
- [x] Ollama container running (port 11434)
- [x] Open WebUI container running (http://192.168.50.200:3000)
- [ ] Create admin account at http://192.168.50.200:3000
- [ ] Start with a small model to verify everything works:
```bash
docker exec -it ollama ollama pull llama3        # ~4GB, 8B model for testing
docker exec -it ollama ollama run llama3
```
- [ ] Once confirmed working, pull the full model:
```bash
docker exec -it ollama ollama pull llama3:70b
```
- [ ] Test the local API:
```bash
curl http://localhost:11434/api/generate \
  -d '{"model": "llama3:70b", "prompt": "Hello!", "stream": false}'
```

### Phase 4 — Home Assistant
- [x] Home Assistant container running (http://192.168.50.200:8123)
- [ ] Complete initial HA setup and onboarding

### Phase 5 — NAS
- [x] RAID 1 set up with mdadm on M.2 #2 and M.2 #3 (/dev/md0)
- [x] Formatted ext4 and mounted at `/mnt/nas`
- [x] Added to `/etc/fstab` for auto-mount on boot
- [ ] Run Samba setup script: `bash ~/code/jarvis/bash/jarvis-nas.sh`
- [ ] Verify share is accessible at `\\192.168.50.200\Jarvis` (Windows) or `smb://192.168.50.200/Jarvis` (Mac/Linux)

### Phase 6 — Voice Pipeline
The voice pipeline chains: **Wake word → Whisper (STT) → Ollama (brain) → Coqui TTS (voice) → Speaker**

- [x] Whisper container running (port 10300)
- [x] Coqui TTS container running (port 5002) — uses `tts-server` entrypoint with tacotron2-DDC model
- [ ] Install Wyoming protocol integration in Home Assistant
- [ ] Connect Whisper and Coqui TTS to HA via Wyoming integration
- [ ] Configure Ollama as the conversation agent in HA
- [ ] Test full voice pipeline end to end

### Phase 7 — Voice Cloning (Coqui TTS)
- [ ] Record or gather 3–10 minutes of clean audio from target voice
  - Single speaker only
  - No background music or crosstalk
  - Consistent volume
  - WAV format preferred
- [ ] Follow Coqui TTS voice cloning documentation to train custom voice
- [ ] Swap cloned voice into the HA TTS pipeline

### Phase 8 — Remote Access (HA Mobile App + NAS)
Tailscale creates an encrypted private network between your devices. Your server never exposes ports to the public internet, but you can access everything as if you're on your home network from anywhere.

- [ ] Install Tailscale on the server:
```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```
- [ ] Install Tailscale on your phone and any laptops you want access from
- [ ] Connect Home Assistant app via Tailscale IP
- [ ] Access NAS shares via Tailscale IP from any device (same as local access, just through Tailscale)

### Phase 9 — 3D Printer (OctoPrint)
- [ ] Connect 3D printer to JARVIS via USB cable
- [ ] Identify the USB device path:
```bash
ls /dev/tty* | grep -i usb
```
- [ ] Update `/dev/ttyUSB0` in docker-compose if the path differs
- [ ] Start OctoPrint container: `bash ~/code/jarvis/bash/container.sh start octoprint`
- [ ] Access at `http://192.168.50.200:5000` and complete initial setup
- [ ] Connect OctoPrint to the printer (set baud rate and port in OctoPrint settings)
- [ ] Optional: add a USB webcam for print monitoring

### Phase 10 — File Sync (Nextcloud + rclone)

#### rclone — Google Drive mirror
rclone runs directly on the OS (not in Docker) and syncs Google Drive to `/mnt/nas/gdrive` on a schedule.

- [ ] Install rclone:
```bash
sudo apt install rclone
```
- [ ] Configure Google Drive remote (interactive):
```bash
rclone config
# Follow prompts: New remote → name it "gdrive" → Google Drive → authenticate via browser
```
- [ ] Test the sync manually:
```bash
rclone sync gdrive: /mnt/nas/gdrive --transfers 4 --progress
```
- [ ] Add to crontab to run daily at 2am:
```bash
crontab -e
# Add: 0 2 * * * rclone sync gdrive: /mnt/nas/gdrive --transfers 4
```

#### Nextcloud
- [x] Passwords set in `docker/docker-compose.yml`
- [ ] Start Nextcloud: `bash ~/code/jarvis/bash/container.sh start nextcloud-db && bash ~/code/jarvis/bash/container.sh start nextcloud`
- [ ] Access at `http://192.168.50.200:8080` and complete initial setup
- [ ] In Nextcloud admin → External Storage → add `/mnt/gdrive` as a local external storage mount
- [ ] Install Nextcloud desktop/mobile client on your devices and point it at `http://192.168.50.200:8080`

#### Storage layout
| Path | Contents |
|---|---|
| `/mnt/nas/nextcloud` | Nextcloud user data |
| `/mnt/nas/nextcloud-db` | Nextcloud MariaDB database |
| `/mnt/nas/gdrive` | rclone Google Drive mirror (one copy, surfaced in Nextcloud via external storage) |

---

## Key Concepts Learned in This Project

| Concept | Where you'll encounter it |
|---|---|
| Linux administration | Ubuntu Server setup and management |
| SSH & key-based auth | Headless server access |
| Docker & containers | Running all services via CLI |
| Networking basics | Static IPs, ports, service communication |
| LLM inference | Ollama + model selection |
| Voice AI pipeline | Wake word, STT, TTS integration |
| RAG (future exploration) | Feeding documents to your LLM |
| Home automation | Home Assistant configuration |

---

## Suggested Learning Order
1. ✅ Hardware built and BIOS flashed
2. ✅ Ubuntu Server 26.04 LTS installed
3. Get SSH working and set up key authentication
4. Apply Intel Baseline Profile in BIOS
5. Install NVIDIA drivers and verify with nvidia-smi
6. Install Docker + Docker Compose (practice CLI commands)
7. Install Portainer as a visual reference tool
8. Get Ollama running with a small 7B model first
9. Add Home Assistant
10. Build the voice pipeline (Whisper → Ollama → Coqui TTS)
11. Swap to 70B model once everything is stable
12. Do voice cloning with Coqui TTS
13. Explore RAG and fine-tuning as curiosity develops

---

## Notes & Reminders
- Server name: JARVIS
- Static IP: 192.168.50.200
- Network subnet: 192.168.50.x
- Server is fully headless after initial Ubuntu install — monitor/keyboard not needed after that
- All management via SSH or browser-based UIs from another device
- Coqui TTS and Ollama share the GPU — monitor VRAM usage with `nvidia-smi`
- Start simple, get each piece working before adding the next
- Portainer is installed but use Docker CLI commands for learning — Portainer is a fallback
- The `--gpus all` Docker flag is required for GPU acceleration in containers
- Tailscale handles all remote access (HA + NAS) — no ports exposed to the public internet
- Coqui TTS company shut down in 2024 but project is open source and actively community maintained
- Coqui TTS container requires `entrypoint: tts-server` — the default `tts` entrypoint is a CLI synthesis tool, not a server
- nvidia-container-toolkit must be installed separately from NVIDIA drivers for Docker GPU passthrough (`apt install nvidia-container-toolkit` + `nvidia-ctk runtime configure --runtime=docker`)
- Do NOT select snaps during Ubuntu install — install everything via Docker instead
- Ubuntu 26.04 ISO download mirror: releases.ubuntu.com/26.04/ (use if ubuntu.com is down)
