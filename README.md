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
    subgraph External_Network [External]
        Internet((Internet))
    end

    subgraph Gateway [pfSense Firewall]
        FW[Firewall / Suricata]
        VPN[OpenVPN - Port 1194]
        Squid[Squid Proxy - Port 3128]
    end

    subgraph VLAN_Segmentation [Network Segments]
        MGMT[MGMT - 10.0.10.1/24]
        CORPLAN[CORPLAN - 10.0.20.1/24]
        DMZ[DMZ - 10.0.30.1/24]
        APP[APPLOGIC - 10.0.40.1/24]
        DB[(DB - 10.0.50.1/24)]
        SEC[SEC - 10.0.60.1/24]
        GUEST[GUEST - DHCP]
        BACKUP[BACKUPZONE - 10.0.80.1/24]
    end

    %% External Connections
    Internet <--> FW
    FW <--> VPN
    
    %% NAT & Port Forwarding Logic
    Internet -.->|Port 1443| DMZ
    Internet -.->|Port 44380| SEC
    Internet -.->|Port 19090| SEC

    %% Internal Routing
    FW <--> MGMT
    FW <--> CORPLAN
    FW <--> DMZ
    FW <--> APP
    FW <--> DB
    FW <--> SEC
    FW <--> GUEST
    FW <--> BACKUP

    %% Specific Communication Rules from Config
    DMZ -.->|HTTP 18080| APP
    APP -.->|SQL 3306| DB
    MGMT -.->|SSH 22| APP
    SEC -.->|Prometheus/Loki| MGMT
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
