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
- [x] Apply Intel Baseline Profile in BIOS to protect CPU
- [x] Install NVIDIA drivers (v595.71.05, CUDA 13.2)
- [ ] Run FurMark stress test 10-15 min after OS install, check 4090 power connector for excessive heat
- [x] GPU sag bracket installed (4090 is ~2.2 lbs, 24/7 operation)
- [x] Voice satellite hardware — see Drone below (Raspberry Pi 4 + ReSpeaker 2-Mic HAT + speaker)

### Hardware Notes
- PSU is ATX 3.1 native — no 4090 power adapter needed, eliminates connector melting risk
- Dark Rock Pro 5 front fan is repositionable if RAM clearance becomes an issue
- CPU cooler mounting brackets must be oriented correctly or cooler rotates 90 degrees (learned this the hard way)
- Network is on 192.168.50.x subnet (not 192.168.1.x)
- JARVIS static IP set to 192.168.50.200 during OS install
- WiFi SSIDs: R2-D2-Alpha (5GHz, primary), R2-D2-Beta (2.4GHz, primary), C-3PO-Alpha (5GHz, IoT), C-3PO-Beta (2.4GHz, IoT)
- IoT devices (drone1, Ecobee, etc.) are on C-3PO SSIDs — "Allow Intranet Access" must be enabled on the router for these networks or LAN communication will be blocked
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

## Machines on the Network

| Hostname | Role | OS | IP |
|---|---|---|---|
| JARVIS | Home AI server (headless) | Ubuntu Server 24.04 LTS | 192.168.50.200 (static) |
| Melkhior | Workstation / primary client | Linux Mint (Cinnamon) | Dynamic |
| chopper | Desktop workstation | Nobara Linux 43 | — |
| drone1 | Voice satellite | Raspberry Pi OS Lite 64-bit | 192.168.50.204 (static via DHCP reservation) |

### JARVIS Users

| User | Role | Groups |
|---|---|---|
| mkeph | Primary admin | docker, family |
| joe | Admin | docker |
| tessa | NAS user | family |
| jeph | NAS user | family |
| ipad | NAS user | family |

### Chopper — Desktop (Nobara Linux 43) ✅ COMPLETE
- [x] Nobara Linux 43 installed

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
| Image generation | Fooocus (Stable Diffusion, on-demand) |

### VRAM Allocation
| Service | Estimated VRAM |
|---|---|
| Llama 3 70B | ~20GB |
| Coqui TTS | ~2-3GB |
| Total | ~22-23GB (fits within 24GB) |
| Fooocus (SDXL, on-demand) | ~6-12GB — not concurrent with Ollama; time-share the GPU |

### GUI Access (all from another device's browser — server stays headless)
| Tool | URL |
|---|---|
| Portainer | http://jarvis:9000 |
| Home Assistant | http://jarvis:8123 |
| OctoPrint | http://jarvis:5000 |
| Nextcloud | http://jarvis:8080 |
| Open WebUI | http://jarvis:3000 |
| Fooocus | http://jarvis:7865 (on-demand — start/stop via container.sh) |

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
- [x] Router DNS configured on ASUS RT-AX3000 — `jarvis` resolves to 192.168.50.200 network-wide
- [x] NVIDIA drivers installed (v595.71.05, CUDA 13.2)
- [x] nvidia-smi verified — RTX 4090 recognized, 24GB VRAM
- [x] Applied Intel Baseline Profile in BIOS

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

### Phase 3 — LLM (Ollama + Open WebUI) ✅ COMPLETE
- [x] Ollama container running (port 11434)
- [x] Open WebUI container running (http://jarvis:3000)
- [x] gemma3:27b pulled and running
- [x] Admin account created in Open WebUI
- [x] System prompt set to inject current date (`Today's date is {{CURRENT_DATE}}.`)
- [x] Model display name customized in Open WebUI (Workspace → Models)
- [x] Additional user accounts created for family

### LLM Notes
- gemma3:27b chosen over llama3:70b — fits entirely in 24GB VRAM, faster responses for voice pipeline
- 70B models at Q4 ~40GB would require CPU RAM offloading (slower) on a 24GB card
- Sweet spot for this hardware is 27-32B models at Q4 quantization (~18-20GB VRAM)
- System prompt lives at Admin Panel → Settings → Models → System Prompt
- Model display name: edit the model in Workspace → Models → click the name to rename

### Phase 4 — Home Assistant
- [x] Home Assistant container running (http://jarvis:8123)
- [x] Initial onboarding complete
- [x] HACS installed (via `docker exec -it homeassistant bash -c "wget -O - https://get.hacs.xyz | bash -"`)
- [x] Reolink cameras integrated
- [x] Ecobee integrated via HomeKit Controller — paired successfully; controllable via HA chat/Assist
- [x] Govee integrated — manual control working via HA panel
- [x] Ollama connected as conversation agent using `qwen2.5:14b` (tools-compatible model)
- [x] `qwen2.5:14b` pulled for HA conversation agent (tool/function calling support)
- [x] Router "Allow Intranet Access" enabled for IoT SSIDs — resolves device visibility issues
- [ ] Bring HA back into docker-compose management — run `docker inspect homeassistant` to capture current config, then add service to docker-compose.yml
- [ ] Stop and remove the orphan homeassistant container, restart via compose
- [ ] Expose Govee entities to Assist for voice control (blocked — entities not appearing in Expose list, need Developer Tools → States to debug entity types)
- [ ] Enable Advanced Mode on profile to unlock Developer Tools
- [ ] Confirm Govee entity types in Developer Tools → States (filter "govee")
- [ ] Wire Ollama conversation agent to control exposed devices via Assist

#### Local Weather
- [ ] Add Met.no integration in HA (Settings → Devices & Services → Add Integration → "Met.no") — no API key required, uses home coordinates set during onboarding
- [ ] Expose the weather entity to the Ollama conversation agent
- [ ] Test voice query: "What's the weather like?" / "Do I need an umbrella today?"

#### Google Calendar Integration
- [ ] Create OAuth 2.0 credential in Google Cloud Console (type: Web application)
- [ ] Add Google Calendar integration in HA (Settings → Devices & Services → Google Calendar)
- [ ] Complete OAuth flow — enable write scope to allow event creation
- [ ] Test reading calendar events in HA
- [ ] Test voice command to add event via Assist + Ollama (e.g. "Add dentist Friday at 3pm")
- [ ] Tune Ollama system prompt if event parsing is inconsistent

### Home Assistant Notes
- HA is currently running as an unmanaged orphan container (`ghcr.io/home-assistant/home-assistant:stable`) — not in docker-compose yet; needs to be brought back in
- Original reason for removing from compose was frustration with devices not appearing — root cause was router "Allow Intranet Access" disabled on IoT SSIDs (C-3PO-Alpha/Beta), not a Docker issue
- Ecobee: paired via HomeKit Controller; Ecobee native API is unavailable (program suspended) but HomeKit pairing works and device is controllable via Assist/chat
- Govee: cloud API integration doesn't support control for most devices; Govee LAN Hass works for manual control but entities aren't appearing in Expose list yet
- HA conversation agent MUST use a tools-compatible model — gemma3:27b does NOT support tools and will error
- Use `qwen2.5:14b` for HA (tools + conversation), keep `gemma3:27b` for Open WebUI general chat
- Developer Tools only visible with Advanced Mode enabled (profile → scroll down → Advanced Mode)
- Google Calendar: OAuth client must be type "Web application" — enable write scope during setup to allow `google_calendar.create_event` service calls; `qwen2.5:14b` handles natural language → structured event data via tool calling

### Phase 5 — NAS ✅ COMPLETE
- [x] RAID 1 set up with mdadm on M.2 #2 and M.2 #3 (/dev/md0)
- [x] Formatted ext4 and mounted at `/mnt/nas`
- [x] Added to `/etc/fstab` for auto-mount on boot
- [x] Samba installed and configured via `bash ~/code/jarvis/bash/jarvis-nas.sh`
- [x] Share accessible at `\\jarvis\jarvis` (Windows) or `smb://jarvis/jarvis` (Mac/Linux)
- [x] Group-based access control — `family` group owns `/mnt/nas`
- [x] `/mnt/nas` permissions set to `mkeph:family 2775` (setgid — new files inherit group)
- [x] smb.conf global guest access disabled (`map to guest = never`, `usershare allow guests = no`)
- [x] Family members added via `bash ~/code/jarvis/bash/jarvis-nas-users.sh <username>`

### Melkhior NAS Client
- [ ] Update `/etc/fstab` on Melkhior to use on-demand automount (laptop moves between networks — don't mount at boot): add `noauto,x-systemd.automount,x-systemd.mount-timeout=5,nofail` to the existing cifs entry, then `sudo systemctl daemon-reload && sudo umount /mnt/jarvis`

### NAS Notes
- Share name is lowercase: `\\jarvis\jarvis`
- Access requires a named Samba user — guest access is disabled globally in smb.conf
- To add a family member: `bash ~/code/jarvis/bash/jarvis-nas-users.sh <username>` — creates a no-login Linux user, adds to `family` group, sets Samba password
- To change a user's Samba password: `sudo smbpasswd <username>`
- To list Samba users: `sudo pdbedit -L`
- Container volumes live at `/mnt/nas/docker/` to keep the share root clean
- All management via `\\jarvis\jarvis` from any device on the network
- Ubuntu default smb.conf has `map to guest = bad user` and `usershare allow guests = yes` — both must be patched to enforce authentication
- Apple/iPad access: `fruit streams_xattr` VFS and `fruit:model = MacSamba` added to `[global]` in smb.conf for compatibility
- iPad (Files app): connect via `smb://jarvis/jarvis` — the top-level server listing shows "read only" but the share itself is writable; navigate into the jarvis folder to confirm

### Phase 6 — Voice Pipeline
The voice pipeline chains: **Wake word → Whisper (STT) → Ollama (brain) → TTS (voice) → Speaker**

- [x] Whisper container running (port 10300) — Wyoming-compatible, works with HA directly
- [x] Coqui TTS container running (port 5002) — ⚠️ HTTP server only, NOT Wyoming-compatible
- [x] Add `wyoming-openwakeword` container for wake word detection (port 10400)
- [x] Add `wyoming-piper` container as Wyoming-compatible TTS for HA integration (port 10200, voice: en_US-lessac-medium) — defined in docker-compose, not yet started
- [x] Whisper added to HA via Wyoming integration (JARVIS:10300)
- [x] Start wyoming-piper container on JARVIS (`docker compose up -d wyoming-piper`) then add to HA via Wyoming integration (JARVIS:10200)
- [x] Create voice assistant pipeline in HA (Settings → Voice Assistants) — Whisper STT + Piper TTS + Ollama conversation agent
- [x] Fix conversation agent language — created `jarvis-assistant` custom model via `bash ~/code/jarvis/bash/create-models.sh`; system prompt forces English and suppresses reasoning verbalization
- [x] Test full voice pipeline end to end — wake word, STT, Ollama, TTS, speaker all working; thermostat control via voice confirmed

### Drone — Voice Satellite(s)
- Hardware: Raspberry Pi 4 + KEYESTUDIO ReSpeaker 2-Mic Pi HAT V1.0 + speaker (8ohm 3W JST-PH2.0, already plugged in)
- Naming scheme: `drone1`, `drone2`, etc. — hostname and username match (e.g. hostname `drone1`, user `drone1`)
- Password: cypher key "D"
- [x] microSD card acquired
- [x] USB microSD reader acquired
- [x] Raspberry Pi OS Lite 64-bit flashed via Raspberry Pi Imager (hostname `drone1`, user `drone1`, SSH key from Melkhior)
- [x] Pi boots successfully (solid red PWR, green ACT active during boot)
- [x] Resolve network issue — root cause: drone1 was on C-3PO-Beta (2.4GHz IoT SSID); "Allow Intranet Access" was disabled for that network on the ASUS router; enabling it restored LAN connectivity
- [x] drone1 pinging JARVIS and all LAN devices successfully
- [x] drone1 static IP via DHCP reservation on router (192.168.50.204)
- [x] Install seeed-voicecard drivers + wyoming-satellite + wyoming-openwakeword via `bash ~/code/jarvis/bash/drone-setup.sh` (phase 1 → reboot → phase 2)
- [x] drone1 added to HA via Wyoming Protocol (auto-discovered via zeroconf, port 10700)
- [ ] Apply conversational context fix to drone1 — edit `/etc/systemd/system/wyoming-satellite.service`, add `--conversation-id drone1` to the `ExecStart` line, then `sudo systemctl daemon-reload && sudo systemctl restart wyoming-satellite` (already patched in `drone-setup.sh` for future drones)
- [ ] Apply LED feedback to drone1 — (1) `scp ~/code/jarvis/drone/led.py drone1:~/drone/led.py`, (2) enable SPI: `echo "dtparam=spi=on" | sudo tee -a /boot/firmware/config.txt && sudo reboot`, (3) install deps: `~/wyoming-satellite/.venv/bin/pip install spidev pixel-ring`, (4) add the four event hook flags to `/etc/systemd/system/wyoming-satellite.service` and `sudo systemctl daemon-reload && sudo systemctl restart wyoming-satellite` (already patched in `drone-setup.sh` for future drones)
- Wake word: `hey_jarvis` (runs locally on Pi); STT → JARVIS:10300 (Whisper); TTS → JARVIS:10200 (wyoming-piper, en_US-lessac-medium)

### Future Drone Nodes
- Stick with Pi 4 for additional drones — ReSpeaker 2-Mic HAT driver support is mature on Pi 4
- Pi 5 + ReSpeaker HAT is problematic — Pi 5 changed its I2S audio architecture, seeed-voicecard driver support is incomplete
- If using Pi 5 in the future, use a USB audio adapter instead — no driver issues, fully supported, often cheaper
- Pi 5 1GB is otherwise viable for the workload (wyoming-satellite + openwakeword runs well under 300MB)

### Voice Pipeline Notes
- HA's voice pipeline requires **Wyoming protocol** for STT and TTS — Coqui TTS in its current form cannot integrate with HA
- `wyoming-piper` is the recommended Wyoming-native TTS and is actively maintained
- `wyoming-openwakeword` handles wake word detection and is Wyoming-native
- Coqui TTS (port 5002) can remain running for direct API use or future voice cloning — just not wired into HA's pipeline
- Wake word is `hey_jarvis` — a supported openWakeWord model, runs locally on the Pi
- HA runs in host network mode so it can reach Wyoming services on 192.168.50.200 directly
- The HA conversation agent **must** use a model that supports tool/function calling (e.g. qwen2.5, llama3.1, mistral) — gemma3 does NOT support tools and cannot control devices
- seeed-voicecard on kernel 6.12: must use the `v6.12` branch of the HinTak fork (`git checkout v6.12`) — master branch fails to compile against kernel 6.12
- wyoming-satellite 1.4.1+: `--stt-uri` and `--tts-uri` flags removed — HA handles routing to Whisper/Piper directly; satellite only needs `--wake-uri`
- wyoming-satellite must use `network-online.target` (not `network.target`) in systemd — satellite starts before WiFi is ready otherwise and crashes with "Network is unreachable"
- qwen2.5:14b defaults to responding in Chinese — use `jarvis-assistant` custom model (created via `bash ~/code/jarvis/bash/create-models.sh`) which has an English system prompt baked in; also suppresses chain-of-thought verbalization
- "Think before responding" in HA voice assistant causes the model to speak its reasoning aloud — keep it off; instead the system prompt instructs the model to only speak the final answer
- For real-time data (weather, etc.) a weather integration needs to be added to HA and exposed to the assistant — model has no live data access on its own
- To update `jarvis-assistant`: `ssh jarvis docker exec ollama ollama rm jarvis-assistant` then rerun `create-models.sh`

### Phase 6b — Voice Training (Wake Word)
~~Custom wake word training not needed — pre-built `hey_jarvis` model is sufficient.~~

### Phase 7 — Voice Cloning (Coqui TTS)
- [ ] Record or gather 3–10 minutes of clean audio from target voice
  - Single speaker only
  - No background music or crosstalk
  - Consistent volume
  - WAV format preferred
- [ ] Follow Coqui TTS voice cloning documentation to train custom voice
- [ ] Swap cloned voice into the pipeline

### Voice Cloning Notes
- ⚠️ Coqui TTS company shut down in 2024 — the `ghcr.io/coqui-ai/tts` image is community-maintained and may lose support over time
- Voice cloning with Piper (the Wyoming-native alternative) is less straightforward — evaluate options when reaching this phase
- Do not remove the Coqui container until a cloning solution is confirmed

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
- [ ] Plug Prusa MK3S+ into JARVIS via USB and run `ls /dev/tty*` to confirm device path — likely `/dev/ttyACM0` (not `/dev/ttyUSB0`); update docker-compose octoprint `devices:` entry accordingly before starting the container
- [ ] Identify printer model and confirm USB cable compatibility
- [ ] Connect 3D printer to JARVIS via USB cable
- [ ] Identify the USB device path:
```bash
ls /dev/tty* | grep -i usb
```
- [ ] Uncomment octoprint service in docker-compose and update `/dev/ttyUSB0` if the path differs
- [ ] Start OctoPrint container: `bash ~/code/jarvis/bash/container.sh start octoprint`
- [ ] Access at `http://jarvis:5000` and complete initial setup wizard
- [ ] Connect OctoPrint to the printer (set baud rate and port in OctoPrint settings)
- [ ] Configure printer profile (bed size, extruder, etc.)
- [ ] Test print to confirm connection
- [ ] Optional: add a USB webcam for print monitoring
- [ ] Optional: integrate OctoPrint with Home Assistant for print status in dashboard

### OctoPrint Notes
- ⚠️ OctoPrint service is commented out in docker-compose until printer is connected — uncomment before starting
- USB device path may vary — always verify with `ls /dev/tty*` before starting the container

### Phase 10 — File Sync (Nextcloud + rclone)

#### rclone — Google Drive mirror
rclone runs directly on the OS (not in Docker) and syncs Google Drive to `/mnt/nas/gdrive` on a schedule.

- [ ] Install rclone:
```bash
sudo apt install rclone
```
- [ ] Configure Google Drive remote — ⚠️ JARVIS is headless, browser auth won't work directly. Use `--auth-no-browser` flag and complete auth on another machine, or SSH tunnel the auth port:
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
- [ ] Access at `http://jarvis:8080` and complete initial setup
- [ ] In Nextcloud admin → External Storage → add `/mnt/gdrive` as a local external storage mount
- [ ] Install Nextcloud desktop/mobile client on your devices and point it at `http://jarvis:8080`

#### Storage layout
| Path | Contents |
|---|---|
| `/mnt/nas/nextcloud` | Nextcloud user data |
| `/mnt/nas/nextcloud-db` | Nextcloud MariaDB database |
| `/mnt/nas/gdrive` | rclone Google Drive mirror (one copy, surfaced in Nextcloud via external storage) |

### Phase 11 — Image Generation (Fooocus)
Fooocus is a Stable Diffusion image generation UI. It competes with Ollama for VRAM, so it runs on-demand — brought up when needed, torn down when done. Set `OLLAMA_KEEP_ALIVE=0` so Ollama unloads its model immediately after each request, freeing VRAM before Fooocus starts.

- [x] Add Fooocus service to `docker/docker-compose.yml` (commented out by default)
- [x] Set `OLLAMA_KEEP_ALIVE=0` in Ollama container environment in docker-compose
- [x] Create `bash/fooocus-up.sh` — stops Ollama, starts Fooocus
- [x] Create `bash/fooocus-down.sh` — stops Fooocus, starts Ollama
- [x] On JARVIS: pull the image: `docker pull ghcr.io/lllyasviel/fooocus`
- [x] Fix bind mount permissions: `sudo mkdir -p /mnt/nas/docker/fooocus/models /mnt/nas/docker/fooocus/outputs && sudo chmod 777 /mnt/nas/docker/fooocus/models /mnt/nas/docker/fooocus/outputs`
- [x] Test spin-up: `bash ~/code/jarvis/bash/fooocus-up.sh` — working
- [x] Test spin-down: `bash ~/code/jarvis/bash/fooocus-down.sh` — Ollama restores
- [x] Enable NSFW/adult content in Fooocus UI settings
- [x] Test image generation with GPU confirmed via `nvidia-smi`

### Fooocus Notes
- Fooocus runs on-demand via `fooocus-up.sh` / `fooocus-down.sh` — not a persistent service
- Correct image: `ghcr.io/lllyasviel/fooocus` (not Docker Hub — image doesn't exist there)
- Bind mount dirs must be pre-created with 777 permissions or container exits with permission errors
- Fooocus (SDXL) needs ~6-12GB VRAM; gemma3:27b needs ~18-20GB — cannot run concurrently
- To enable adult content: Advanced tab in the Fooocus UI → disable safety filter
- To check VRAM usage before starting Fooocus: `ssh jarvis nvidia-smi`

#### GPU Time-Sharing Options

**Option A — OLLAMA_KEEP_ALIVE=0 (soft, elegant)**
- Set `OLLAMA_KEEP_ALIVE=0` in Ollama's docker-compose environment
- Ollama unloads its model from VRAM immediately after each request (default is 5 min)
- Fooocus can start and grab free VRAM without stopping Ollama
- Ollama container stays running — reloads model on next request (adds a few seconds)
- Best for: casual use, don't need guaranteed full 24GB for Fooocus

**Option B — Hard stop/start scripts (explicit, guaranteed)**
- Two wrapper scripts: `fooocus-up.sh` (stops Ollama, starts Fooocus) and `fooocus-down.sh` (stops Fooocus, starts Ollama)
- Ollama container is fully stopped — full 24GB guaranteed free for Fooocus
- Fooocus takes 30-60s to load model into VRAM on first generation
- Ollama takes a few seconds to reload on first request after switching back
- Best for: high-res generation, want certainty, don't need Ollama available while generating

**Option C — Combine both ✅ CHOSEN**
- Set `OLLAMA_KEEP_ALIVE=0` as baseline (Ollama idles without holding VRAM)
- `bash ~/code/jarvis/bash/fooocus-up.sh` — stops Ollama hard, starts Fooocus (guaranteed full VRAM)
- `bash ~/code/jarvis/bash/fooocus-down.sh` — stops Fooocus, restores Ollama
- Most flexible — soft mode for casual use, hard switch available when needed

### Phase 12b — VPN (WireGuard)
Route all of JARVIS's outbound internet traffic through a VPN provider for ISP-level privacy. WireGuard runs natively on the OS (not in Docker) for system-wide coverage. A kill switch is included in the generated config — if the tunnel drops, traffic is blocked rather than leaking in plaintext.

**⚠️ Provider not yet decided — candidates: Mullvad vs ProtonVPN**

| | Mullvad | ProtonVPN |
|---|---|---|
| Account | Number only, no email | Email required |
| Pricing | Flat ~$5/mo | Tiered (free → Plus → Unlimited) |
| Kill switch | In generated config | In generated config |
| Jurisdiction | Sweden | Switzerland |
| Secure Core | No | Yes (multi-hop through CH/IS/SE) |
| Port forwarding | Yes | Removed in 2023 |
| Ecosystem | Standalone | Proton suite (Mail, Drive, Pass) |

Both support downloading raw WireGuard `.conf` files — headless Linux setup is identical either way.
Port forwarding is a non-factor for the current JARVIS setup (Tailscale covers remote access; all services are LAN-only).

- [ ] **Decide on provider** (Mullvad vs ProtonVPN) and sign up
- [ ] Install WireGuard and resolvconf:
```bash
sudo apt install wireguard resolvconf
```
- [ ] Generate a WireGuard config from the provider's dashboard — select server location, enable kill switch → download `.conf`
- [ ] Copy the config to JARVIS:
```bash
scp <provider>-xx.conf jarvis:/etc/wireguard/
```
- [ ] Bring the tunnel up and verify:
```bash
sudo wg-quick up <config-name>
curl ifconfig.me   # should return the provider's IP, not your home IP
```
- [ ] Enable on boot:
```bash
sudo systemctl enable wg-quick@<config-name>
```
- [ ] Test kill switch: `sudo wg-quick down <config-name>` then confirm internet is unreachable (`curl ifconfig.me` should fail or time out)
- [ ] Re-enable tunnel: `sudo wg-quick up <config-name>`
- [ ] Verify DNS isn't leaking using an external DNS leak test

### VPN Notes
- Both Mullvad and ProtonVPN generated `.conf` files include `PostUp`/`PreDown` iptables rules for the kill switch — no manual firewall config needed
- Config file goes in `/etc/wireguard/` — filename determines the systemd service name (e.g. `mullvad-us-nyc.conf` → `wg-quick@mullvad-us-nyc`)
- `resolvconf` is required for WireGuard to manage DNS — without it `wg-quick` will warn and DNS may not route through the tunnel
- Choose a geographically close server for lowest latency
- Tailscale (Phase 8) coexists fine — it uses its own WireGuard interface (`tailscale0`) separate from the VPN tunnel
- If a Docker container needs to bypass the VPN (e.g. a service that needs your real IP), that requires per-container routing — evaluate when needed
- To check tunnel status: `sudo wg show`
- To switch servers: bring down current tunnel, copy new config, bring up new tunnel; can keep multiple `.conf` files and swap as needed

---

### Phase 12 — World of Darkness RAG (AI Lore Assistant)
Build a RAG pipeline that embeds the White Wolf WoD book corpus into a vector database, then wires it to a dedicated Ollama persona in Open WebUI. The model will retrieve relevant passages at query time and answer questions grounded in the actual source material.

**Depends on:** External PDF-to-text conversion project (WoD books → plain text files)

#### Step 1 — Corpus Preparation
- [ ] Confirm output format from the PDF conversion project (plain `.txt` files, one per book, or chunked JSON)
- [ ] Decide on storage location: `/mnt/nas/wod/corpus/` — one file per book
- [ ] Review a few converted files for quality — check for garbled OCR, missing text, encoding issues

#### Step 2 — Vector Database
- [ ] Add ChromaDB service to `docker/docker-compose.yml` (persistent volume at `/mnt/nas/docker/chromadb`)
- [ ] Start ChromaDB: `docker compose up -d chromadb`
- [ ] Confirm ChromaDB is accessible at `http://jarvis:8000`

#### Step 3 — Embedding the Corpus
- [ ] Write `bash/wod-ingest.py` — reads corpus files, chunks text (~500 tokens with overlap), embeds via Ollama (`nomic-embed-text` model), stores in ChromaDB collection `wod`
- [ ] Pull embedding model: `docker exec ollama ollama pull nomic-embed-text`
- [ ] Run ingestion: `python ~/code/jarvis/bash/wod-ingest.py` — expect this to take a while on first run
- [ ] Verify collection populated: query ChromaDB for a known term and confirm results return

#### Step 4 — Open WebUI RAG Integration
- [ ] In Open WebUI: Admin Panel → Documents → add ChromaDB as the vector store backend
- [ ] Upload or point Open WebUI at the corpus directory for indexing (alternatively, ingestion script handles this directly)
- [ ] Create a new model in Open WebUI Workspace → Models: `wod-lore`
  - Base model: `gemma3:27b` (or `qwen2.5:14b` if tool calling needed)
  - System prompt: instructs the model to answer as a WoD lore authority, cite source books when possible, stay in-universe
  - Enable RAG on this model, pointed at the `wod` ChromaDB collection

#### Step 5 — Testing
- [ ] Test factual recall: ask about specific clans, disciplines, lore — verify answers match source material
- [ ] Test citation behavior: confirm model references book names when relevant
- [ ] Test edge cases: questions spanning multiple books, contradictions between editions

### WoD RAG Notes
- RAG chosen over fine-tuning: keeps answers grounded in actual source text, no weight retraining required, easy to update when new books are added
- ChromaDB is the simplest self-hosted vector DB — no auth required for local use, persistent storage via bind mount
- `nomic-embed-text` is the recommended embedding model for Ollama RAG — fast, good quality, small footprint
- Chunk size ~500 tokens with ~50 token overlap is a good starting point; tune if retrieval quality is poor
- Open WebUI has native RAG support but its built-in document pipeline may conflict with a custom ChromaDB ingest — evaluate both paths
- When adding new books: re-run `wod-ingest.py` with just the new files; ChromaDB supports incremental upserts
- Keep the `wod` ChromaDB collection separate from any other RAG collections to avoid cross-contamination

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

## Useful Tools & Bookmarks

| Tool | URL | Purpose |
|---|---|---|
| EZRip | https://ezrip.net | Extract MP3 audio from YouTube videos |

---

## Notes & Reminders
- Text editor: **vim** only — never nano
- Server name: JARVIS
- Static IP: 192.168.50.200
- mkeph password on JARVIS: cypher key "A"
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
