#!/bin/bash
set -e

sudo apt install -y samba

sudo tee -a /etc/samba/smb.conf << 'EOF'

[Jarvis]
   path = /mnt/nas
   browseable = yes
   read only = no
   guest ok = yes
   create mask = 0777
   directory mask = 0777
   force user = nobody
EOF

sudo systemctl restart smbd

echo "Samba share 'Jarvis' is live at smb://192.168.50.200/Jarvis"
