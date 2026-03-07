#!/bin/bash
echo "name of the VM"
read user

echo "(host?).example.local"
read host

SOURCE="/var/lib/libvirt/images/10.07.MGMT-BASTION.qcow2"
DEST="/var/lib/libvirt/images/$user.qcow2"

sudo cp -p "$SOURCE" "$DEST"


sudo virt-sysprep -a "$DEST" \
  --hostname "$host.example.local" \
  --root-password password:asd \
  --enable customize,net-hostname,net-hwaddr,machine-id


sudo virt-install \
  --name "$user" \
  --ram "2048" \
  --vcpus "1" \
  --disk path="$DEST" \
  --import \
  --os-variant ubuntu24.04 \
  --network network=LAB \
  --graphics vnc \
  --noautoconsole

  # 10.06.MGMT-IPA
  # 10.07.MGMT-BASTION
