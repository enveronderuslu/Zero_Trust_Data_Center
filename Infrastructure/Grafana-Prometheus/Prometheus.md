# Prometheus

## On RHEL
sudo mkdir -p /opt/prometheus/data 
sudo chown -R 65534:65534 /opt/prometheus/data 

vim /opt/prometheus/prometheus.yaml

```vim
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'rocky_nodes'
    static_configs:
      - targets:
        - '10.0.10.6:9100'
        - '10.0.40.11:9100'
        - '10.0.20.11:9100'
        - '10.0.60.13:9100'
        - '10.0.50.11:9100'
        - 'localhost:9100' # Prometheus server
```

```bash
firewall-cmd --permanent --add-port=19090/tcp

firewall-cmd --reload
```


```docker
docker run -d \
    --name=prometheus \
    --restart=always \
    -p 19090:9090 \
    -v /opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml \
    -v /opt/prometheus/data:/prometheus \
    prom/prometheus
```

verify  deployment  on Prometheus  server

curl -s http://localhost:19090/api/v1/targets | jq '.data.activeTargets[] | {node: .discoveredLabels.__address__, health: .health}'


## On UBUNTU
sudo mkdir -p /opt/prometheus/data 
sudo chown -R 65534:65534 /opt/prometheus/data 

vim /opt/prometheus/prometheus.yaml

```vim
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'all_nodes'
    static_configs:
      - targets:
        - '10.0.10.7:9100'
        - '10.0.50.11:9100'
        - '10.0.30.11:9100'
        - '10.0.40.11:9100'
        - '10.0.80.11:9100'
        - '10.0.60.13:9100'
        - 'localhost:9100' # Prometheus server
```

```bash
sudo ufw allow 19090/tcp
```


```docker
sudo docker run -d \
    --name=prometheus \
    --restart=always \
    --user root \
    -p 19090:9090 \
    -v /opt/prometheus/prometheus.yaml:/etc/prometheus/prometheus.yml \
    -v /opt/prometheus/data:/prometheus \
    prom/prometheus
```

verify  deployment  on Prometheus  server

curl -s http://localhost:19090/api/v1/targets | jq '.data.activeTargets[] | {node: .discoveredLabels.__address__, health: .health}'


