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
REMOTE_SCRIPT_URL="https://raw.githubusercontent.com/scarsong/system_tools/main/system_tools.sh"
CHANGE_LOG_URL="https://raw.githubusercontent.com/scarsong/system_tools/main/Change_log"

# 判断是否存在快捷文件s，并检查内容是否一致
if [ ! -f "$SCRIPT_PATH" ]; then
    echo -e "${YELLOW}文件 ${SCRIPT_PATH} 不存在，正在创建...${NC}"
    COPY_FILE=1
elif ! cmp -s "$SOURCE_SCRIPT" "$SCRIPT_PATH"; then
    echo -e "${YELLOW}文件 ${SCRIPT_PATH} 存在，但内容不同，正在更新...${NC}"
    COPY_FILE=1
else
    COPY_FILE=0
fi

# 如果需要复制文件
if [ $COPY_FILE -eq 1 ]; then
    if [ -f "$SOURCE_SCRIPT" ]; then
        cp "$SOURCE_SCRIPT" "$SCRIPT_PATH"
        chmod +x "$SCRIPT_PATH"
        echo -e "${GREEN}文件 ${SCRIPT_PATH} 已更新，并复制了 ${SOURCE_SCRIPT} 的内容，并赋予执行权限。${NC}"
    else
        echo -e "${RED}源文件 ${SOURCE_SCRIPT} 不存在，无法更新 ${SCRIPT_PATH}。${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}文件 ${SCRIPT_PATH} 已是最新版本，无需更新。${NC}"
fi

# 设置快捷键的函数
set_shortcut() {
    if ! grep -q "alias s='$SCRIPT_PATH'" ~/.bashrc; then
        sed -i "/alias .*='s'$/d" ~/.bashrc
        echo "alias s='$SCRIPT_PATH'" >> ~/.bashrc
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
    echo -e "【${RED}系统工具合集${NC}】 ${YELLOW}v1.2${NC}"
    echo -e "${BLUE}------------------------------------------------------------${NC}"
    echo -e "${WHITE}通过键盘快捷键 ${YELLOW}s${WHITE}（小写字母）可快速启动并进入脚本${NC}"
    echo -e "${BLUE}------------------------------------------------------------${NC}"
    echo -e "【${BLUE}1${NC}】 ${BLUE}管理${YELLOW} IPv4/IPv6 ${BLUE}输入链规则 ${YELLOW}(iptables/ip6tables)${NC}"
    echo -e "【${BLUE}2${NC}】 ${BLUE}查看${YELLOW} IPv4 Docker ${BLUE}用户链规则 ${YELLOW}(iptables)${NC}"
    echo -e "【${BLUE}3${NC}】 ${BLUE}查看${YELLOW} IPv6 Docker ${BLUE}用户链规则 ${YELLOW}(ip6tables)${NC}"
    echo -e "【${BLUE}4${NC}】 ${BLUE}查看${YELLOW} IPv4 Docker NAT ${BLUE}规则 ${YELLOW}(iptables)${NC}"
    echo -e "【${BLUE}5${NC}】 ${BLUE}查看${YELLOW} IPv6 Docker NAT ${BLUE}规则 ${YELLOW}(ip6tables)${NC}"
    echo -e "【${BLUE}6${NC}】 ${BLUE}管理服务器 SSH 防火墙规则${NC}"
    echo -e "【${BLUE}7${NC}】 ${BLUE}更新脚本${NC}"
    echo -e "【${BLUE}8${NC}】 ${BLUE}查看更新日志${NC}"
    echo -e "【${BLUE}0${NC}】 ${BLUE}退出${NC}"
    echo -e "${BLUE}------------------------------------------------------------${NC}"
}

# 输出命令的函数，过滤并着色
output_command() {
    while IFS= read -r line; do
        if echo "$line" | grep -q "DROP"; then
            echo -e "${WHITE}${line}${NC}"
        elif echo "$line" | grep -q "ACCEPT"; then
            echo -e "${GREEN}${line}${NC}"
        else
            echo -e "${WHITE}${line}${NC}"
        fi
    done
}

# 列出所有规则
list_rules() {
    local table=$1
    local chain=$2
    eval "$table -L $chain -n --line-numbers"
}

# 删除指定规则
delete_rule() {
    local table=$1
    local chain=$2
    local rule_number=$3
    eval "$table -D $chain $rule_number"
}

# 返回主菜单函数
return_to_main_menu() {
    return  # 简单返回上层循环
}

# 删除规则并处理重新编号问题
process_rule_deletion() {
    local table=$1
    local chain=$2
    local rule_number

    echo -e "${BLUE}当前 ${chain} 链规则 ${YELLOW}(${table})${NC}:"
    list_rules "$table" "$chain" | output_command

    while true; do
        echo -e "${RED}请选择要删除的规则编号（用空格分隔多个编号），输入完毕后按回车确认（或输入 'q' 返回主菜单）:${NC}"
        read -p "规则编号: " -a rule_numbers

        # 检查用户是否选择返回主菜单
        if [[ " ${rule_numbers[*]} " =~ " q " ]]; then
            return_to_main_menu
            return
        fi

        # 检查输入的规则编号是否为有效数字
        invalid_input=false
        for rule_number in "${rule_numbers[@]}"; do
            if ! [[ "$rule_number" =~ ^[0-9]+$ ]]; then
                invalid_input=true
                break
            fi
            if ! iptables -L "$chain" --line-numbers | awk '{print $1}' | grep -q "^$rule_number$"; then
                invalid_input=true
                break
            fi
        done

        if $invalid_input; then
            echo  # 输出新行，确保提示不覆盖
            echo -e "${YELLOW}已跳过规则删除阶段。${NC}"
            return  # 跳出函数
        fi

        # 确保规则编号排序（降序排序，以避免编号变化问题）
        IFS=$'\n' sorted_rule_numbers=($(sort -nr <<<"${rule_numbers[*]}"))
        unset IFS

        for rule_number in "${sorted_rule_numbers[@]}"; do
            echo -e "${BLUE}正在删除规则编号 ${rule_number}...${NC}"
            delete_rule "$table" "$chain" "$rule_number"
            sleep 1  # 等待规则删除生效
            list_rules "$table" "$chain" | output_command
        done

        echo -e "${GREEN}规则删除完成。${NC}"
        return
    done
}

# 处理规则删除
handle_rule_deletion() {
    while true; do
        echo -e "【${BLUE}1${NC}】 ${BLUE}删除某一个编号的规则${NC}"
        echo -e "【${BLUE}2${NC}】 ${BLUE}删除多个规则${NC}"
        echo -e "【${BLUE}3${NC}】 ${BLUE}删除所有规则${NC}"
        echo -e "【${BLUE}q${NC}】 ${BLUE}返回主菜单${NC}"

        read -p "请输入选项 (1/2/3/q): " delete_choice

        case $delete_choice in
            1)
                while true; do
                    echo -e "${BLUE}删除某一个编号的规则:${NC}"
                    read -p "请输入要删除的规则编号（或输入 'q' 返回主菜单）: " rule_number

                    # 检查用户是否选择返回主菜单
                    if [[ "$rule_number" == "q" ]]; then
                        return_to_main_menu
                        return
                    fi

                    # 检查输入是否为数字
                    if ! [[ "$rule_number" =~ ^[0-9]+$ ]]; then
                        echo  # 输出新行，确保提示不覆盖
                        echo -e "${YELLOW}已跳过规则删除阶段。${NC}"
                        return  # 跳出函数
                    fi

                    # 检查规则编号是否存在
                    if ! iptables -L INPUT --line-numbers | awk '{print $1}' | grep -q "^$rule_number$"; then
                        echo  # 输出新行，确保提示不覆盖
                        echo -e "${YELLOW}已跳过规则删除阶段。${NC}"
                        return  # 跳出函数
                    else
                        break  # 输入有效，退出循环
                    fi
                done

                # 删除规则
                iptables -D INPUT "$rule_number" 2>/dev/null
                ip6tables -D INPUT "$rule_number" 2>/dev/null
                echo -ne "${GREEN}规则编号 ${rule_number} 已删除。${NC}\n"
                ;;
            2)
                # 处理 IPv4 规则
                echo -e "${BLUE}处理 IPv4 规则:${NC}"
                process_rule_deletion "iptables" "INPUT"

                # 确保处理完 IPv4 规则后再处理 IPv6
                echo -e "${BLUE}处理 IPv6 规则:${NC}"
                process_rule_deletion "ip6tables" "INPUT"
                ;;
            3)
                while true; do
                    echo -e "${BLUE}删除所有规则:${NC}"
                    read -p "确定要删除所有规则吗？(y/n 或 'q' 返回主菜单): " confirm
                    if [[ "$confirm" =~ ^[ynq]$ ]]; then
                        break  # 退出循环，继续处理选项
                    else
                        echo -e "${RED}无效输入，请重新输入。${NC}"
                    fi
                done

                if [[ "$confirm" == "q" ]]; then
                    return_to_main_menu
                    return
                elif [[ "$confirm" == "y" ]]; then
                    iptables -F INPUT
                    ip6tables -F INPUT
                    echo -ne "${GREEN}所有 INPUT 链规则已删除。${NC}\n"
                else
                    echo -e "${YELLOW}操作已取消。${NC}"
                fi
                ;;
            q)
                return_to_main_menu
                return
                ;;
            *)
                echo -e "${RED}无效选项。${NC}"
                echo  # 输出新行，确保提示不覆盖
                ;;
        esac
    done
}

# 管理防火墙规则
manage_firewall() {
    echo -e "${RED}您选择了管理防火墙输入链规则。${NC}"
    echo -e "【${BLUE}1${NC}】 ${BLUE}查看防火墙输入链规则${NC}"
    echo -e "【${BLUE}2${NC}】 ${BLUE}删除防火墙输入链规则${NC}"
    read -p "请输入选项 (1/2): " manage_choice

    case $manage_choice in
        1)
            echo -e "${BLUE}查看防火墙输入链规则:${NC}"
            echo -e "【${BLUE}1${NC}】 ${BLUE}查看 IPv4 输入链规则 ${YELLOW}(iptables)${NC}"
            echo -e "【${BLUE}2${NC}】 ${BLUE}查看 IPv6 输入链规则 ${YELLOW}(ip6tables)${NC}"
            read -p "请输入选项 (1/2): " view_choice

            case $view_choice in
                1)
                    echo -e "${BLUE}查看 IPv4 输入链规则 ${YELLOW}(iptables):${NC}"
                    list_rules "iptables" "INPUT" | output_command
                    ;;
                2)
                    echo -e "${BLUE}查看 IPv6 输入链规则 ${YELLOW}(ip6tables):${NC}"
                    list_rules "ip6tables" "INPUT" | output_command
                    ;;
                *)
                    echo -e "${RED}无效选项。${NC}"
                    ;;
            esac
            ;;
        2)
            echo -e "${BLUE}删除防火墙输入链规则:${NC}"
            echo -e "【${BLUE}1${NC}】 ${BLUE}删除 IPv4 输入链规则 ${YELLOW}(iptables)${NC}"
            echo -e "【${BLUE}2${NC}】 ${BLUE}删除 IPv6 输入链规则 ${YELLOW}(ip6tables)${NC}"
            read -p "请输入选项 (1/2): " delete_choice

            case $delete_choice in
                1)
                    echo -e "${BLUE}管理 IPv4 输入链规则 ${YELLOW}(iptables):${NC}"
                    handle_rule_deletion
                    ;;
                2)
                    echo -e "${BLUE}管理 IPv6 输入链规则 ${YELLOW}(ip6tables):${NC}"
                    handle_rule_deletion
                    ;;
                *)
                    echo -e "${RED}无效选项。${NC}"
                    ;;
            esac
            ;;
        *)
            echo -e "${RED}无效选项。${NC}"
            ;;
    esac
}

# 显示正在进行的项目名称
show_progress() {
    echo -e "${RED}正在进行: ${1}${NC}"
}

# 管理 SSH 防火墙规则
manage_ssh_firewall() {
    show_progress "管理 SSH 防火墙规则"

    echo -e "${RED}系统中已经配置 SSH 防火墙规则？${NC}"
    echo -e "【${BLUE}1${NC}】 ${BLUE}是${NC}"
    echo -e "【${BLUE}2${NC}】 ${BLUE}否${NC}"
    read -p "请输入选项 (1/2): " ssh_choice

    case $ssh_choice in
        1)
            echo -e "【${BLUE}1${NC}】 ${BLUE}查看现有规则${NC}"
            echo -e "【${BLUE}2${NC}】 ${BLUE}修改现有规则${NC}"
            read -p "请输入选项 (1/2): " modify_choice
            if [[ $modify_choice == "1" ]]; then
                show_progress "查看现有防火墙规则"
                iptables -L INPUT -n --line-numbers | output_command
                ip6tables -L INPUT -n --line-numbers | output_command
                show_ipset   # 调用显示 IPSET 地址
            elif [[ $modify_choice == "2" ]]; then
                if [ -f "/root/add_ssh_ips.sh" ] && [ -f "/etc/systemd/system/add_ssh_ips.service" ]; then
                    echo -e "${GREEN}找到现有规则文件，将对其进行修改。${NC}"
                    # 调用修改函数
                    modify_existing_rules
                else
                    echo -e "${RED}现有规则文件或服务不存在，正在创建...${NC}"
                    # 调用创建函数
                    create_ssh_rules
                fi
            else
                echo -e "${RED}无效选项。${NC}"
            fi
            ;;
        2)
            create_ssh_rules
            ;;
        *)
            echo -e "${RED}无效选项。${NC}"
            ;;
    esac
}

# 创建 SSH 防火墙规则
create_ssh_rules() {
    show_progress "创建 SSH 防火墙规则"

    # 检查并安装ipset
    if ! command -v ipset &> /dev/null; then
        echo -e "${YELLOW}ipset 未安装，正在安装...${NC}"
        apt-get update && apt-get install -y ipset
    else
        echo -e "${GREEN}ipset 已安装，跳过安装步骤。${NC}"
    fi

    # 获取 SSH 端口号
    PORT=$(grep "^Port " /etc/ssh/sshd_config | awk '{print $2}')
    if [ -z "$PORT" ]; then
        read -p "未能自动检测到SSH端口号，请手动输入: " PORT
    fi

    # 让用户输入IPv4和IPv6地址
    echo -e "${YELLOW}请输入允许访问SSH的IPv4地址（用空格分隔多个地址）:${NC}"
    read -p "IPv4地址: " ipv4_addresses
    echo -e "${YELLOW}请输入允许访问SSH的IPv6地址（用空格分隔多个地址）:${NC}"
    read -p "IPv6地址: " ipv6_addresses

    # 创建 add_ssh_ips.sh 脚本
    cat <<EOF > /root/add_ssh_ips.sh
#!/bin/bash

ipset create allowed_ssh_ips hash:ip
ipset create allowed_ssh_ipv6_ips hash:ip family inet6

$(for ip in $ipv4_addresses; do echo "ipset add allowed_ssh_ips $ip"; done)
$(for ip in $ipv6_addresses; do echo "ipset add allowed_ssh_ipv6_ips $ip"; done)

COMMENT_ESCAPED="Svc:SSH"

while iptables -D INPUT -p tcp -m multiport --dports $PORT -m set --match-set allowed_ssh_ips src -j ACCEPT 2>/dev/null; do :; done
iptables -A INPUT -p tcp -m multiport --dports $PORT -m set --match-set allowed_ssh_ips src -m comment --comment "\${COMMENT_ESCAPED}" -j ACCEPT

while ip6tables -D INPUT -p tcp -m multiport --dports $PORT -m set --match-set allowed_ssh_ipv6_ips src -j ACCEPT 2>/dev/null; do :; done
ip6tables -A INPUT -p tcp -m multiport --dports $PORT -m set --match-set allowed_ssh_ipv6_ips src -m comment --comment "\${COMMENT_ESCAPED}" -j ACCEPT
EOF

    # 确保脚本可执行
    chmod +x /root/add_ssh_ips.sh

    # 创建 systemd service 文件
    cat <<EOF > /etc/systemd/system/add_ssh_ips.service
[Unit]
Description=Add SSH IP rules using ipset and iptables
After=network.target

[Service]
ExecStart=/root/add_ssh_ips.sh

[Install]
WantedBy=multi-user.target
EOF

    # 重新加载 systemd 配置并启用服务
    systemctl daemon-reload
    systemctl enable add_ssh_ips.service
    systemctl start add_ssh_ips.service

    echo -e "${GREEN}SSH 防火墙规则已创建并启用。${NC}"
    show_ipset   # 显示 IPSET 地址
}

# 修改现有 SSH 防火墙规则
modify_existing_rules() {
    show_progress "修改现有 SSH 防火墙规则"

    if [ -f "/root/add_ssh_ips.sh" ]; then
        # 提取IP地址相关的行号
        ip_lines=$(grep -nE "^\s*ipset add allowed_ssh_ips" /root/add_ssh_ips.sh | cut -d: -f1)

        if [[ -z "$ip_lines" ]]; then
            echo -e "${YELLOW}无法找到脚本中的IP设置部分。即将打开脚本供手动修改。${NC}"
            read -p "按任意键继续..." -n 1
            nano /root/add_ssh_ips.sh
        else
            echo -e "${BLUE}脚本中的IP地址配置位于以下行:${NC}"
            echo "$ip_lines"

            echo -e "${YELLOW}将自动定位到第一个IP地址所在行。${NC}"
            read -p "按任意键继续编辑脚本..." -n 1

            # 打开文件并定位到第一个IP地址的行
            nano +$(echo "$ip_lines" | head -n 1) /root/add_ssh_ips.sh
        fi

        # 赋予脚本执行权限
        chmod +x /root/add_ssh_ips.sh
        echo -e "${GREEN}已赋予脚本执行权限。${NC}"

        # 重新应用规则
        systemctl restart add_ssh_ips.service
        echo -e "${GREEN}SSH 防火墙规则已修改并重新应用。${NC}"
        show_ipset   # 显示 IPSET 地址

    else
        echo -e "${RED}无法找到现有规则文件，无法修改。${NC}"
    fi
}


# 更新脚本函数
update_script() {
    show_progress "更新脚本"

    echo -e "${YELLOW}正在从远程URL下载最新版本的脚本...${NC}"
    curl -o "$SOURCE_SCRIPT" "$REMOTE_SCRIPT_URL"
    if cmp -s "$SOURCE_SCRIPT" "$SCRIPT_PATH"; then
        echo -e "${GREEN}脚本已经是最新版本，无需更新。${NC}"
    else
        echo -e "${YELLOW}检测到脚本有更新内容。是否更新？（y/n）${NC}"
        read -p "请输入选择 (y/n): " update_choice
        case $update_choice in
            y|Y)
                cp "$SOURCE_SCRIPT" "$SCRIPT_PATH"
                chmod +x "$SCRIPT_PATH"
                echo -e "${GREEN}脚本已成功更新。${NC}"
                ;;
            n|N)
                echo -e "${RED}脚本更新已取消。${NC}"
                ;;
            *)
                echo -e "${RED}无效选择，脚本更新已取消。${NC}"
                ;;
        esac
    fi
}

# 查看更新日志函数
view_change_log() {
    show_progress "查看更新日志"

    echo -e "${YELLOW}正在从远程URL获取更新日志...${NC}"
    # 添加 '-H "Cache-Control: no-cache"' 以强制刷新缓存
    curl -s -H "Cache-Control: no-cache" "$CHANGE_LOG_URL" | while IFS= read -r line; do
        echo "$line"
    done

    echo -e "${RED}更新日志已经显示完毕，请按下回车，确认已经完成阅读。${NC}"
    read
}

# 显示 IPSET 地址
show_ipset() {
    echo -e "${RED}当前 IPSET 地址:${NC}"
    ipset list allowed_ssh_ips 2>/dev/null
    ipset list allowed_ssh_ipv6_ips 2>/dev/null
}

# 主菜单循环
while true; do
    show_menu
    # 使用红色提示用户输入选项编号
    echo -ne "${RED}输入选项编号 (按回车确认): ${NC}"
    read choice
    case $choice in
        1)
            manage_firewall
            ;;
        2)
            show_progress "查看IPv4 Docker用户链规则"
            iptables -L DOCKER-USER -n --line-numbers | output_command
            ;;
        3)
            show_progress "查看IPv6 Docker用户链规则"
            ip6tables -L DOCKER-USER -n --line-numbers | output_command
            ;;
        4)
            show_progress "查看IPv4 Docker NAT规则"
            iptables -t nat -L POSTROUTING -n --line-numbers | output_command
            ;;
        5)
            show_progress "查看IPv6 Docker NAT规则"
            ip6tables -t nat -L POSTROUTING -n --line-numbers | output_command
            ;;
        6)
            manage_ssh_firewall
            ;;
        7) 
            update_script 
            ;;
        8) 
            view_change_log 
            ;;
        0) 
            echo -e "${BLUE}退出脚本。${NC}" ; exit 
            ;;
        *) 
            echo -e "${RED}无效选项。${NC}" 
            ;;
    esac
    echo -ne "${RED}按任意键返回主菜单...${NC}"
    read -n 1
done
