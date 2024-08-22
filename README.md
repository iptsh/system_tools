# Script Introduction

English | [简体中文](./README.zh-cn.md)

![Snipaste_2024-08-23_01-20-49](https://github.com/user-attachments/assets/27f5a08e-280e-4fbf-850d-9e89ae600e07)

---

### 【Changelog】

---

#### 【v1.1】First version, view existing inbound firewall rules, including Docker port rules and forwarding rules. (2024.08.16)

---

#### 【v1.2】Second version, SSH management for the firewall, menu update, changelog, integration of ipset addresses, deletion of host rules. (2024.08.16)

---

#### 【v1.3】Third version, fine-tuning, color optimization, improved readability, key information highlighted, session screen management, fixed updating even when choosing N/n. (2024.08.17)

---

#### 【v1.4】Fourth version, fixed the script update issue, reminder to delete temporary update files, aesthetic optimizations, added author website display. (2024.08.17)

---

#### 【v1.5】 Fifth Edition, Added language switching feature to the script, supporting switching between Chinese and English, with improvements to the script’s appearance. (2024.08.20 Night)

---

#### 【v1.6】 Sixth Edition，This script manages Docker firewall rules and supports services that allow either IPv4-only access or both IPv4 and IPv6 access. If the latter is the case, enabling Docker's custom network and configuring IPv6 forwarding and access is necessary. The script does not impose how users should configure these settings, but as of now, using the Docker project `robbertkl/ipv6nat` to achieve IPv6 forwarding and access within Docker networks is a recommended approach, although other methods can also be used.The management of Docker service firewall rules was the primary motivation for creating this script and is considered by the author as a highly necessary strategy for Docker maintenance. Two very important aspects are limiting external access to Docker services and enabling IPv6 access for Docker services. (2024.08.21 Noon)

---
【v1.7】 The seventh version corrects the logic error of Docker firewall management options, adds a judgment link to ask whether to create a configuration file, adds a submenu of common system commands, and adds an option to display Docker container information in the main menu to display the container name and the network where the container is located. Name, IPv4 address, IPv6 address, container running status, container port mapping information, optimize the readability of Docker container information display and the aesthetics of information output. (2024.08.22 Night)
---
# Why was this script created?

#### Noticed that many commands had to be entered manually each time, which was very inconvenient, so I integrated them into a script for easier maintenance and viewing.
#### This is a very simplified system tool collection, currently in its initial version, convenient for personal use.
#### All features come from ChatGPT training results, with more common functions gradually added, environment for Debian 12 system.

# Installation & Usage:

```bash
curl -O https://raw.githubusercontent.com/scarsong/system_tools/main/system_tools.sh && \
chmod +x ./system_tools.sh && \
./system_tools.sh
```
#### OR
```bash
wget "https://raw.githubusercontent.com/scarsong/system_tools/main/system_tools.sh?$(date +%s)" \
-O system_tools.sh && \
chmod +x system_tools.sh && \
./system_tools.sh
```
