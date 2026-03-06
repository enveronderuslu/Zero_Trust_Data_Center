# DIRECTORY SERVICES-SERVER
```bash
# installation
sudo dnf install freeipa-server freeipa-server-dns -y
sudo ipa-server-install # Start the interactive installation process

# Local Firewall Configuration (on iam Server)
firewall-cmd –list-ports # List current open ports
firewall-cmd --add-port={123,88,464,53}/udp --permanent
firewall-cmd --add-port={80,443,389,636,88,464,53}/tcp --permanent
sudo firewall-cmd --add-service={freeipa-ldap,freeipa-ldaps,kerberos,dns} --permanent
firewall-cmd –reload && firewall-cmd –list-ports 
```

ipactl status

backup critical files with `ipa-backup`

## Users and Groups
```bash
kinit admin  # admin olarak sisteme girdin. Obtain Kerberis ticket
ipa user-add (name:test last name:user)
ipa user-del test-user
ipa user-add cemsit-ademov
ipa user-find --login=c.ademov
ipa user-find --last=ademov
ipa user-find --first=CeMsIt # case sensitive degil
ipa user-find --all ( > users.txt) #basta admin olmak üzere tüm users

ipa group-add # grup olusturuldu
ipa group-find --all

ipa host-add test.example.com
ipa host-find --all # finds the hosts on domain
```
