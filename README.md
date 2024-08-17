# 脚本介绍：
#### 管理 IPv4/IPv6 防火墙现有入站规则，包括Docker端口规则和转发规则。增加 SSH 防火墙管理，增加更新脚本选项，增加查看更新日志选项，增加查看 ipset 地址合集，增加删除宿主规则选项。
![Snipaste_2024-08-17_02-01-21](https://github.com/user-attachments/assets/aa160284-a627-4988-8d2e-269ac7ab5098)
# 为什么会有这个脚本？
#### 日常中发现很多命令每次都需要手动输入，非常不方便，所以整合到脚本中，易于维护和查看。
#### 这是一个非常简易化的系统工具合集，目前是初步版本，方便自己使用。
#### 全部来自 ChatGPT 的训练结果，逐步添加更多常用功能，环境为 Debian 12 系统。
# 安装使用方法：
```bash
curl -O https://raw.githubusercontent.com/scarsong/system_tools/main/system_tools.sh && \
chmod +x ./system_tools.sh && \
./system_tools.sh
```
#### 或者
```bash
wget "https://raw.githubusercontent.com/scarsong/system_tools/main/system_tools.sh?$(date +%s)" -O system_tools.sh && \
chmod +x system_tools.sh && \
./system_tools.sh
```
