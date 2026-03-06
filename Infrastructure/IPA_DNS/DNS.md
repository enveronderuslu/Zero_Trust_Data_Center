 
sudo ipa-dns-install --auto-reverse


    • Add NS record (ensure the host has an A record before adding NS):
ipa dnsrecord-add example.local --ns-rec mgmt-ipa.example.local.  
	Record Name: @ (root of the zone)  


    • Create reverse zones before adding PTR records:
ipa dnszone-add --name-from-ip=10.0.0.0/16 (hepsibiyerde olacaksa)
ipa dnszone-add 10.0.10.in-addr.arpa
ipa dnszone-add 20.0.10.in-addr.arpa
ipa dnszone-add 30.0.10.in-addr.arpa
ipa dnszone-add 40.0.10.in-addr.arpa
ipa dnszone-add 50.0.10.in-addr.arpa
ipa dnszone-add 60.0.10.in-addr.arpa
ipa dnszone-add 70.0.10.in-addr.arpa
ipa dnszone-add 80.0.10.in-addr.arpa 
          
    • A Record Command
ipa dnsrecord-add $DOMAIN $HT --a-rec 10.0.$ZONE.$IP

    • PTR Record  Command
ipa dnsrecord-add $ZONE.0.10.in-addr.arpa. $IP --ptr-hostname=$HT.$DOMAIN.

    • Test the DNS records using dig:
dig mgmt-test.example.local A  dig -x 10.0.10.5

Diger aglar nasil DNS hizmeti alacak? Kimler DNS sunucuya ulasabildin
vim ipa-ext.conf
```vim
acl "trusted_networks" {
    127.0.0.1;
    10.0.30.0/24;
    10.0.10.0/24;
    10.0.20.0/24;
    10.0.40.0/24;
    10.0.50.0/24;
    10.0.60.0/24;
    10.0.70.0/24;
};

vim /etc/named/ipa-options-ext.conf
allow-query { trusted_networks; };
allow-recursion { trusted_networks; };
```
ipactl restart

