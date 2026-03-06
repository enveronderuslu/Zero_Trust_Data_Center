Create user ansible  and the group ansible_users and add ansible to it. Sudo rules ( don’t forget !authenticate option in Options  part). In the  Jump server run the foolowing to have an access with ssh certificate.
sudo -i -u ansible

ssh-keygen -C ansible@example.local

 ipa user-mod ansible  --sshpubkey="$(cat /home/ansible/.ssh/id_ed25519.pub)" 