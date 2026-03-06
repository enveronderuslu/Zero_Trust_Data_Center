#!/bin/bash
echo "name of the VM"
read user

echo "(host?).example.local"
read host

SOURCE="/var/lib/libvirt/images/fedora.qcow2"
DEST="/var/lib/libvirt/images/$user.qcow2"

sudo cp -p "$SOURCE" "$DEST"


sudo virt-sysprep -a "$DEST" \
  --hostname "$host.example.local" \
  --root-password password:asd \
  --enable customize,net-hostname,net-hwaddr,machine-id

sudo virt-install \
  --name "$user" \
  --ram "1024" \
  --vcpus "1" \
  --disk path="$DEST" \
  --import \
  --os-variant fedora42 \
  --network network=LAB \
  --graphics vnc \
  --noautoconsole

# 10.06.MGMT-IPA
# 10.07.MGMT-BASTION
# 20.11.corp-ws1
# 30.11.dmz-srv1
# 40.11.app-srv1
# 50.11.db-srv1.
# 60.11.sec-loki
# 60.13.sec-grafana
# 80.11.backup-srv1
