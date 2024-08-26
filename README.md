# Script Introduction

English | [简体中文](./README.zh-cn.md)

![Snipaste_2024-08-25_22-47-07](https://github.com/user-attachments/assets/19c25c82-4868-4f16-a9a2-4caf090079ab)

---

### 【Changelog】[Change log](./Change_log)

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

#### 【v1.6】 Sixth Edition, Managed Docker firewall rules.Managed Docker services that support only IPv4 access and those that support both IPv4 and IPv6 access.For services supporting both, the script requires enabling Docker custom networks and configuring IPv6 forwarding and access. The script does not force users to complete these configurations in a specific way, but currently, using the Docker project robbertkl/ipv6nat to achieve IPv6 forwarding and access in Docker networks is a recommended approach, though other methods can also be used.The Docker service firewall management function in this script was the original purpose of creating the script and is considered by the author to be a crucial part of automating Docker maintenance strategies.Two very important tasks: restricting external access to Docker services and enabling IPv6 access for Docker services.(2024.08.21 Noon)

---

#### 【v1.7】 Seventh Edition, Fixed logical errors in Docker firewall management options.Added a prompt to ask whether to create a configuration file.Added a submenu for common system commands.Added an option to the main menu for displaying Docker container information, which includes container name, network name, IPv4 address, IPv6 address, container status, and port mapping information.Improved the readability and aesthetic presentation of Docker container information display. (2024.08.22 Night)

---

#### 【v1.8】 Eighth Edition, Changed the container status in Docker container information display to white, in order to avoid visual confusion with container names when the code automatically wraps on mobile clients.Modified the script so that when Docker container information is not retrieved, it displays the character "N/A" to represent missing information, preventing potential misalignment of information columns. (2024.08.23 PM)(2024.08.23 PM)

---

#### 【v1.9】 Ninth Version, This version fixes the issue where the script did not check if ipset was already installed before creating Docker firewall configuration files. It optimizes and changes the terminal interaction logic when managing SSH firewall rules and Docker firewall rules.When a user chooses not to create a configuration file, the script will first check if the configuration file already exists in the system. This approach introduces a validation logic to prevent mistakenly proceeding directly to the file creation step, which may not be the best user experience. Similarly, when the user chooses to modify an existing configuration file, the script will also first check if the corresponding configuration file already exists in the system, applying the same validation logic.In previous versions, the script only checked if the configuration file existed right before actually creating it. Now, this check has been moved up to the interaction inquiry phase. This change ensures that before any configuration file is created, the system confirms the absence of the corresponding configuration file, avoiding any blind file creation. All actions are carried out under a transparent logical environment for the script's sensitive operations. The previous detection step is now converted into corresponding prompt messages.(2024.08.25 Night)

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
