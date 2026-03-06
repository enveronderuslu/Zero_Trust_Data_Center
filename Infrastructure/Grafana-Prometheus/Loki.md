
# LOKI
## on RHEL
```bash 
mkdir -p /mnt/loki/config /mnt/loki/data
chown -R 10001:10001 /mnt/loki/data
semanage fcontext -a -t container_file_t "/mnt/loki(/.*)?"
restorecon -Rv /mnt/loki
```

vim /mnt/loki/config/loki-config.yaml
```yaml
auth_enabled: false

server:
  http_listen_port: 3100

common:
  instance_addr: 0.0.0.0
  path_prefix: /var/lib/loki
  storage:
    filesystem:
      chunks_directory: /var/lib/loki/chunks
      rules_directory: /var/lib/loki/rules
  replication_factor: 1
  ring:
    kvstore:
      store: inmemory

limits_config:
  allow_structured_metadata: false

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h

```
firewall-cmd --permanent --add-port=3100/tcp
firewall-cmd --reload

```bash
docker run -d \
  --name loki \
  --restart always \
  -v /mnt/loki/config:/mnt/config \
  -v /mnt/loki/data:/var/lib/loki \
  -p 3100:3100 \
  grafana/loki:latest \
  -config.file=/mnt/config/loki-config.yaml
```

curl http://localhost:3100/ready

---

## on UBUNTU
```bash 
mkdir -p /mnt/loki/config /mnt/loki/data
chown -R 10001:10001 /mnt/loki/data
```

vim /mnt/loki/config/loki-config.yaml
```yaml
auth_enabled: false

server:
  http_listen_port: 3100

common:
  instance_addr: 0.0.0.0
  path_prefix: /var/lib/loki
  storage:
    filesystem:
      chunks_directory: /var/lib/loki/chunks
      rules_directory: /var/lib/loki/rules
  replication_factor: 1
  ring:
    kvstore:
      store: inmemory

limits_config:
  allow_structured_metadata: false

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h

```
sudo ufw allow 3100/tcp

```bash
docker run -d \
  --name loki \
  --restart always \
  -v /mnt/loki/config:/mnt/config \
  -v /mnt/loki/data:/var/lib/loki \
  -p 3100:3100 \
  grafana/loki:latest \
  -config.file=/mnt/config/loki-config.yaml
```

curl http://localhost:3100/ready

---

## Promtail installation
find  deployment files  in Ansible folder. install following on Controller. 
```bash
ansible-galaxy collection install community.docker
```

