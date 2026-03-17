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
graph TD
    %% Global Styles
    classDef firewall fill:#e01b24,stroke:#333,stroke-width:2px,color:#fff;
    classDef vlan fill:#f6f5f4,stroke:#333,stroke-width:2px;
    classDef external fill:#9a9996,stroke:#333,color:#fff;

    subgraph External_Network [External]
        Internet((Internet))
    end

    subgraph Gateway [pfSense Security Gateway]
        FW[Firewall / Suricata]:::firewall
        VPN[OpenVPN]
        Proxy[Squid Proxy]
    end

    subgraph VDC [Virtual Data Center Segments]
        MGMT[MGMT VLAN 10 - Ansible]:::vlan
        DMZ[DMZ VLAN 30 - Nginx]:::vlan
        APP[APPLOGIC VLAN 40 - Docker]:::vlan
        DB[(DB VLAN 50 - MariaDB)]:::vlan
        SEC[SEC VLAN 60 - FreeIPA]:::vlan
        BACKUP[BACKUP VLAN 80 - Storage]:::vlan
    end

    %% Routing
    Internet <--> FW
    FW <--> VPN
    
    FW === MGMT
    FW === DMZ
    FW === APP
    FW === DB
    FW === SEC
    FW === BACKUP

    %% Data Flow
    DMZ -.-> APP
    APP -.-> DB
    SEC -.-> APP
    SEC -.-> MGMT

    class Internet external;
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
