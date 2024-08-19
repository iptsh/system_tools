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
</div>
<div id="chinese" style="display:none;">
脚本介绍：
![IMG_20240817_232412](https://github.com/user-attachments/assets/0aade54f-aa7a-4889-929f-180b1644897f)
【更新日志】
【v1.1】 第一版，查看防火墙现有入站规则，包括 Docker 端口规则和转发规则。（2024.08.16午）
【v1.2】 第二版，防火墙 SSH 管理、更新菜单、更新日志、整合 ipset 地址、删除宿主规则。（2024.08.16夜）
【v1.3】 第三版，调整细节，优化色彩，增强易读性，关键信息突出显示，会话 screen 管理，修复选择 N/n 依然更新。（2024.08.17午）
【v1.4】 第四版，修复无法完成脚本更新问题，提醒删除更新临时文件，细节美观优化，作者网站添加显示。（2024.08.17夜）
为什么会有这个脚本？
日常中发现很多命令每次都需要手动输入，非常不方便，所以整合到脚本中，易于维护和查看。
这是一个非常简易化的系统工具合集，目前是初步版本，方便自己使用。
全部来自 ChatGPT 的训练结果，逐步添加更多常用功能，环境为 Debian 12 系统。
安装使用方法：
bash
复制代码
curl -O https://raw.githubusercontent.com/scarsong/system_tools/main/system_tools.sh && \
chmod +x ./system_tools.sh && \
./system_tools.sh
或者
bash
复制代码
wget "https://raw.githubusercontent.com/scarsong/system_tools/main/system_tools.sh?$(date +%s)" \
-O system_tools.sh && \
chmod +x system_tools.sh && \
./system_tools.sh
</div>
<script>
document.querySelector('[href="#"]').onclick = function() {
    var eng = document.getElementById('english');
    var chi = document.getElementById('chinese');
    if (eng.style.display === 'none') {
        eng.style.display = 'block';
        chi.style.display = 'none';
    } else {
        eng.style.display = 'none';
        chi.style.display = 'block';
    }
};
</script>
