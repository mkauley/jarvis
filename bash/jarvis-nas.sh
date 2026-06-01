#!/bin/bash
set -e

GROUP="family"

sudo apt install -y samba

# Create group if it doesn't exist
if ! getent group "$GROUP" > /dev/null 2>&1; then
    sudo groupadd "$GROUP"
fi

# Add the owner to the group
sudo usermod -aG "$GROUP" mkeph

# Set ownership and permissions on /mnt/nas
# setgid (2775) so new files/dirs inherit the group
sudo chown -R mkeph:"$GROUP" /mnt/nas
sudo find /mnt/nas -type d -exec chmod 2775 {} \;
sudo find /mnt/nas -type f -exec chmod 664 {} \;

# Patch global settings to disable guest access
sudo sed -i 's/map to guest = bad user/map to guest = never/' /etc/samba/smb.conf
sudo sed -i 's/usershare allow guests = yes/usershare allow guests = no/' /etc/samba/smb.conf

# Remove existing [jarvis] or [Jarvis] block from smb.conf if present
sudo python3 -c "
import re
conf = open('/etc/samba/smb.conf').read()
conf = re.sub(r'\n\[jarvis\].*', '', conf, flags=re.DOTALL | re.IGNORECASE)
open('/etc/samba/smb.conf', 'w').write(conf.rstrip() + '\n')
"

sudo tee -a /etc/samba/smb.conf << EOF

[jarvis]
   path = /mnt/nas
   browseable = yes
   read only = no
   valid users = @$GROUP
   force group = $GROUP
   create mask = 0664
   directory mask = 0775
EOF

sudo systemctl restart smbd

echo "Samba share 'jarvis' configured with group-based access ($GROUP)"
echo "Run jarvis-nas-users.sh <username> to add family members"
