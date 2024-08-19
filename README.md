# Script Introduction

[English Version](#) | [中文版本](#) <!-- 切换按钮 -->

<div id="english" style="display:block;">
  
![IMG_20240817_232412](https://github.com/user-attachments/assets/0aade54f-aa7a-4889-929f-180b1644897f)

---

### [Changelog]

---

#### [v1.1] First version, view existing inbound firewall rules, including Docker port rules and forwarding rules. (2024.08.16)

---

#### [v1.2] Second version, SSH management for the firewall, menu update, changelog, integration of ipset addresses, deletion of host rules. (2024.08.16)

---

#### [v1.3] Third version, fine-tuning, color optimization, improved readability, key information highlighted, session screen management, fixed updating even when choosing N/n. (2024.08.17)

---

#### [v1.4] Fourth version, fixed the script update issue, reminder to delete temporary update files, aesthetic optimizations, added author website display. (2024.08.17)

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
