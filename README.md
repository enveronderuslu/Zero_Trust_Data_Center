# Zero-Trust Virtual Data Center (PoC)


## Purpose of this Project

This project demonstrates practical skills in:
- Linux system administration
- Network security and segmentation
- Infrastructure automation
- Monitoring and observability

---

## Overview
This repository contains a Proof of Concept (PoC) of a Virtual Data Center designed with Zero-Trust principles. The focus is on network security, system hardening, automation, and centralized identity management.

The goal of this project is to simulate a production-like secure infrastructure and demonstrate practical skills in Linux administration and IT security.

---

## Key Features
- Zero-Trust architecture (deny-by-default communication)
- Network segmentation using VLANs
- Centralized Identity & Access Management (FreeIPA)
- Infrastructure as Code (Ansible)
- Full monitoring and logging stack
- Containerized workloads (Rootless Docker)
- Secure service deployment (Nginx, MariaDB)

---

## Technology Stack

**Virtualization**
- KVM / QEMU
- Libvirt / Virt-Manager

**Operating Systems**
- Rocky Linux
- Alpine Linux

**Network & Security**
- pfSense (Firewall)
- Suricata (IDS)
- VLAN segmentation
- OpenVPN
- Squid Proxy

**Identity Management**
- FreeIPA (LDAP, Kerberos, RBAC, HBAC)

**Services**
- Nginx (Reverse Proxy)
- MariaDB

**Containerization**
- Docker (Rootless)

**Automation**
- Ansible (Agentless, Playbooks, Roles)

**Monitoring & Logging**
- Prometheus
- Grafana
- Loki
- Promtail
- Node Exporter

---

## Architecture

```mermaid
%%{init: {'theme': 'base', 'themeVariables': { 'fontSize': '16px', 'primaryColor': '#1a5fb4', 'primaryTextColor': '#fff', 'primaryBorderColor': '#1a5fb4', 'lineColor': '#777', 'secondaryColor': '#f6f5f4', 'tertiaryColor': '#ffffff' }}}%%
graph TD
    subgraph External_Network [ ]
        Internet((🌐 Internet))
    end

    subgraph Gateway [🛡️ pfSense Security Gateway]
        FW[Firewall / Suricata]
        VPN[OpenVPN]
        Squid[Squid Proxy]
    end

    subgraph VDC [🏗️ Virtual Data Center Segments]
        MGMT[<b>MGMT (VLAN 10)</b><br/>Ansible & JumpHost]
        DMZ[<b>DMZ (VLAN 30)</b><br/>Nginx Reverse Proxy]
        APP[<b>APPLOGIC (VLAN 40)</b><br/>Rootless Docker]
        DB[(<b>DB (VLAN 50)</b><br/>MariaDB)]
        SEC[<b>SEC (VLAN 60)</b><br/>FreeIPA & Monitoring]
        BACKUP[<b>BACKUP (VLAN 80)</b><br/>BackupZone]
    end

    %% Connectivity logic
    Internet <--> FW
    FW <--> VPN
    
    %% Traffic flows
    FW === MGMT
    FW === DMZ
    FW === APP
    FW === DB
    FW === SEC
    FW === BACKUP

    %% Specific interactions
    DMZ -.->|Port 18080| APP
    APP -.->|Port 3306| DB
    SEC -.->|Auth/Authz| APP
    SEC -.->|Logs/Metrics| MGMT

    style FW fill:#e01b24,stroke:#a51d2d,stroke-width:2px,color:#fff
    style VPN fill:#1c71d8,stroke:#1a5fb4,color:#fff
    style Internet fill:#9a9996,stroke:#5e5c64,color:#fff
    style MGMT fill:#f6f5f4,stroke:#333,stroke-width:2px
    style DMZ fill:#f6f5f4,stroke:#333,stroke-width:2px
    style APP fill:#f6f5f4,stroke:#333,stroke-width:2px
    style DB fill:#f6f5f4,stroke:#333,stroke-width:2px
    style SEC fill:#f6f5f4,stroke:#333,stroke-width:2px
    style BACKUP fill:#f6f5f4,stroke:#333,stroke-width:2px
```
The infrastructure is divided into multiple VLANs to reduce attack surface and enforce strict access control:

- MGMT – Management & Ansible
- DMZ – Public services
- APP – Application layer
- DB – Database layer (encrypted)
- SEC – Monitoring & logging
- GUEST – Isolated network
- BACKUP – Backup storage

All traffic is filtered and controlled via pfSense firewall rules.

---

## Security Concept

- Zero-Trust model (no implicit trust)
- Least privilege access
- Central authentication via FreeIPA
- Controlled admin access via Jump Server
- Segmented network with strict firewall rules

---

## Automation

The entire environment is managed using Ansible, ensuring:
- Consistent configuration
- Reproducible deployments
- Minimal manual intervention

---

## Monitoring & Logging

- Metrics collection with Prometheus
- Central log aggregation via Loki
- Visualization using Grafana dashboards

---

## Repository Structure

Configs/           # Network and firewall configs
Infrastructure/    # Ansible, services, system configs
Documentation/     # Technical documentation
Diagrams/          # Architecture diagrams
Screenshots/       # Implementation proof

---


## Notes
This is a personal PoC project created for learning and demonstration purposes.
