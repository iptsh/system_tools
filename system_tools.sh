#!/bin/bash

# 定义颜色
BLUE='\033[96m'       # 浅蓝色
YELLOW='\033[93m'     # 金黄色
RED='\033[91m'        # 红色
GREEN='\033[92m'      # 深绿色
WHITE='\033[97m'      # 白色
NC='\033[0m'          # 取消颜色

# 需要被快捷键执行的脚本路径
SCRIPT_PATH="/usr/local/bin/s"
SOURCE_SCRIPT="/root/system_tools.sh"

# 判断是否存在快捷文件s，如果不存在则创建并复制内容
if [ ! -f "$SCRIPT_PATH" ]; then
    echo -e "${YELLOW}文件 ${SCRIPT_PATH} 不存在，正在创建...${NC}"
    
    # 检查源文件是否存在
    if [ -f "$SOURCE_SCRIPT" ]; then
        cp "$SOURCE_SCRIPT" "$SCRIPT_PATH"
        chmod +x "$SCRIPT_PATH"
        echo -e "${GREEN}文件 ${SCRIPT_PATH} 已创建，并复制了 ${SOURCE_SCRIPT} 的内容，并赋予执行权限。${NC}"
    else
        echo -e "${RED}源文件 ${SOURCE_SCRIPT} 不存在，无法创建 ${SCRIPT_PATH}。${NC}"
        exit 1
    fi
fi

# 设置快捷键的函数
set_shortcut() {
    # 检查是否已经存在快捷键
    if ! grep -q "alias s='$SCRIPT_PATH'" ~/.bashrc; then
        # 删除旧的快捷键别名（如果存在）
        sed -i "/alias .*='s'$/d" ~/.bashrc

        # 添加新的快捷键别名
        echo "alias s='$SCRIPT_PATH'" >> ~/.bashrc

        # 重新加载 .bashrc 以使更改生效
        source ~/.bashrc

        echo -e "${GREEN}快捷键 's' 已设置为执行脚本: $SCRIPT_PATH${NC}"
    else
        echo -e "${GREEN}快捷键 's' 已存在，无需重新设置。${NC}"
    fi
}

# 设置快捷键
set_shortcut

# 显示菜单函数
show_menu() {
    clear
    echo -e "【${RED}系统工具合集${NC}】 ${YELLOW}v1.1${NC}"
    echo -e "${BLUE}------------------------------------------------------------${NC}"
    echo -e "${WHITE}通过键盘快捷键 ${YELLOW}s${WHITE}（小写字母）可快速启动并进入脚本${NC}"
    echo -e "${BLUE}------------------------------------------------------------${NC}"
    echo -e "【${BLUE}1${NC}】 ${BLUE}查看${YELLOW} IPv4 ${BLUE}输入链规则 ${YELLOW}(iptables)${NC}"
    echo -e "【${BLUE}2${NC}】 ${BLUE}查看${YELLOW} IPv6 ${BLUE}输入链规则 ${YELLOW}(ip6tables)${NC}"
    echo -e "【${BLUE}3${NC}】 ${BLUE}查看${YELLOW} IPv4 Docker ${BLUE}用户链规则 ${YELLOW}(iptables)${NC}"
    echo -e "【${BLUE}4${NC}】 ${BLUE}查看${YELLOW} IPv6 Docker ${BLUE}用户链规则 ${YELLOW}(ip6tables)${NC}"
    echo -e "【${BLUE}5${NC}】 ${BLUE}查看${YELLOW} IPv4 Docker NAT ${BLUE}规则 ${YELLOW}(iptables)${NC}"
    echo -e "【${BLUE}6${NC}】 ${BLUE}查看${YELLOW} IPv6 Docker NAT ${BLUE}规则 ${YELLOW}(ip6tables)${NC}"
    echo -e "【${BLUE}7${NC}】 ${BLUE}全部执行${NC}"
    echo -e "【${BLUE}0${NC}】 ${BLUE}退出${NC}"
    echo -e "${BLUE}------------------------------------------------------------${NC}"
}

# 输出命令的函数，过滤并着色DROP行
output_command() {
    while IFS= read -r line; do
        if echo "$line" | grep -q "DROP"; then
            echo -e "${WHITE}${line}${NC}"
        else
            echo -e "${GREEN}${line}${NC}"
        fi
    done
}

# 主循环
while true; do
    show_menu
    
    # 读取用户输入
    echo -ne "${RED}输入选项编号 (按回车确认): ${NC}"
    read choice

    # 根据选择执行命令
    case $choice in
        1)
            iptables -L INPUT -n --line-numbers | output_command
            ;;
        2)
            ip6tables -L INPUT -n --line-numbers | output_command
            ;;
        3)
            iptables -L DOCKER-USER -n --line-numbers | output_command
            ;;
        4)
            ip6tables -L DOCKER-USER -n --line-numbers | output_command
            ;;
        5)
            iptables -t nat -L DOCKER --line-numbers | output_command
            ;;
        6)
            ip6tables -t nat -L DOCKER --line-numbers | output_command
            ;;
        7)
            echo -e "${BLUE}执行全部命令:${NC}"
            iptables -L INPUT -n --line-numbers | output_command
            ip6tables -L INPUT -n --line-numbers | output_command
            iptables -L DOCKER-USER -n --line-numbers | output_command
            ip6tables -L DOCKER-USER -n --line-numbers | output_command
            iptables -t nat -L DOCKER --line-numbers | output_command
            ip6tables -t nat -L DOCKER --line-numbers | output_command
            ;;
        0)
            echo -e "${BLUE}退出${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}无效选项${NC}"
            ;;
    esac

    # 等待用户按键
    echo -ne "${RED}按任意键返回主菜单...${NC}"
    read -n 1
done