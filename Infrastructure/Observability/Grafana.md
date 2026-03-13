# Grafana
## On RHEL
sudo dnf install -y grafana
sudo systemctl enable --now grafana-server

sudo firewall-cmd --permanent --add-port=3000/tcp
sudo firewall-cmd --reload


http://10.0.60.13:3000  admin/admin

## On UBUNTU
sudo apt-get update
sudo apt-get install -y apt-transport-https software-properties-common wget

sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt-get update
sudo apt-get install grafana -y

sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

sudo ufw allow 3000/tcp



http://10.0.60.13:3000  admin/admin