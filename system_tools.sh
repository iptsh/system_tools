#!/bin/bash

# Define version number
# 定义版本号
VERSION="v2.1"

# Define color
# 定义颜色
BLUE='\033[96m'        # Light blue 浅蓝色
YELLOW='\033[93m'      # Yellow 金黄色
RED='\033[91m'         # Red 红色
GREEN='\033[92m'       # Green 深绿色
WHITE='\033[97m'       # White 白色
NC='\033[0m'           # No Color 取消颜色

# Path to the script to be executed by the shortcut
# 需要被快捷键执行的脚本路径
SCRIPT_PATH="/usr/local/bin/s"
SOURCE_SCRIPT="/root/system_tools.sh"
REMOTE_SCRIPT_URL="https://raw.githubusercontent.com/scarsong/system_tools/main/system_tools.sh"
CHANGE_LOG_URL="https://raw.githubusercontent.com/scarsong/system_tools/main/Change_log.md"
CHANGE_LOG_ZH_CN_URL="https://raw.githubusercontent.com/scarsong/system_tools/main/Change_log_zh-cn.md"

# Check if the shortcut file 's' exists and if its content matches the expected script path
# 判断是否存在快捷文件s，并检查内容是否一致
if [ ! -f "$SCRIPT_PATH" ]; then
    echo -e "【${YELLOW}文件 ${SCRIPT_PATH} 不存在${NC}】【${YELLOW}正在创建${NC}】\n【${YELLOW}File ${SCRIPT_PATH} does not exist${NC}】【${YELLOW}Creating now${NC}】"
    COPY_FILE=1
elif ! cmp -s "$SOURCE_SCRIPT" "$SCRIPT_PATH"; then
    echo -e "【${YELLOW}文件 ${SCRIPT_PATH} 存在${NC}】【${YELLOW}但内容不同${NC}】【${YELLOW}正在更新${NC}】\n【${YELLOW}File ${SCRIPT_PATH} exists${NC}】【${YELLOW}but the content differs${NC}】【${YELLOW}Updating now${NC}】"
    COPY_FILE=1
else
    COPY_FILE=0
fi

# If needed, copy the file to the destination
# 如果需要复制文件
if [ $COPY_FILE -eq 1 ]; then
    if [ -f "$SOURCE_SCRIPT" ]; then
        cp "$SOURCE_SCRIPT" "$SCRIPT_PATH"
        chmod +x "$SCRIPT_PATH"
        echo -e "【${GREEN}文件 ${SCRIPT_PATH} 已更新${NC}】【${GREEN}且已复制 ${SOURCE_SCRIPT} 的内容${NC}】【${GREEN}并已赋予执行权限${NC}】\n【${GREEN}File ${SCRIPT_PATH} has been updated${NC}】【${GREEN}Content from ${SOURCE_SCRIPT} has been copied${NC}】【${GREEN}and execute permission granted${NC}】"
    else
        echo -e "【${RED}源文件 ${SOURCE_SCRIPT} 不存在${NC}】【${RED}无法更新 ${SCRIPT_PATH}${NC}】\n【${RED}Source file ${SOURCE_SCRIPT} does not exist${NC}】【${RED}Cannot update ${SCRIPT_PATH}${NC}】"
        exit 1
    fi
else
    echo -e "【${GREEN}文件 ${SCRIPT_PATH} 已是最新版本${NC}】【${GREEN}无需更新${NC}】\n【${GREEN}File ${SCRIPT_PATH} is up-to-date${NC}】【${GREEN}No update needed${NC}】"
fi

# Set shortcut function
# 设置快捷键的函数
set_shortcut() {
    if ! grep -q "alias s='$SCRIPT_PATH'" ~/.bashrc; then
        sed -i "/alias .*='s'$/d" ~/.bashrc
        echo "alias s='$SCRIPT_PATH'" >> ~/.bashrc
        source ~/.bashrc
        echo -e "【${GREEN}快捷键 's' 已设置为执行脚本 $SCRIPT_PATH${NC}】\n【${GREEN}Shortcut 's' is set to execute script $SCRIPT_PATH${NC}】"
    else
        echo -e "【${GREEN}快捷键 's' 已存在${NC}】【${GREEN}无需重新设置${NC}】\n【${GREEN}Shortcut 's' already exists${NC}】【${GREEN}No need to reset${NC}】"
    fi
}

# Set shortcut
# 设置快捷键
set_shortcut

# Show menu function
# 显示菜单函数
show_menu() {
    clear
    echo -e "${BLUE}================================================================================${NC}"

    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${RED}系统工具合集${NC}】【${YELLOW}${VERSION}${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${WHITE}作者网站】【${YELLOW} https://scarsong.com ${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${YELLOW}捷径${NC}】【${WHITE}通过快捷键 ${YELLOW}s${WHITE} 可快速启动脚本${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}01${NC}】【${BLUE}管理${YELLOW} Docker ${BLUE}防火墙规则${NC}】"
        echo -e "【${BLUE}02${NC}】【${BLUE}管理${YELLOW} iptables IPv4 / ip6tables IPv6 ${BLUE}输入链规则${NC}】"
        echo -e "【${BLUE}03${NC}】【${BLUE}管理服务器${YELLOW} SSH ${BLUE}防火墙规则${NC}】"
        echo -e "【${BLUE}04${NC}】【${BLUE}查看${YELLOW} iptables IPv4 Docker ${BLUE}用户链规则${NC}】"
        echo -e "【${BLUE}05${NC}】【${BLUE}查看${YELLOW} ip6tables IPv6 Docker ${BLUE}用户链规则${NC}】"
        echo -e "【${BLUE}06${NC}】【${BLUE}查看${YELLOW} iptables IPv4 Docker NAT ${BLUE}规则${NC}】"
        echo -e "【${BLUE}07${NC}】【${BLUE}查看${YELLOW} ip6tables IPv6 Docker NAT ${BLUE}规则${NC}】"
        echo -e "【${BLUE}08${NC}】【${BLUE}系统会话保持 ${YELLOW}screen ${BLUE}工具管理${NC}】"
        echo -e "【${BLUE}09${NC}】【${BLUE}常用系统命令${NC}】"
		echo -e "【${BLUE}10${NC}】【${BLUE}显示 ${YELLOW}Docker ${BLUE}容器信息${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}18${NC}】【${RED}切换脚本显示语言${NC}】【${YELLOW}Switch script language${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}19${NC}】【${GREEN}脚本更新${NC}】"
        echo -e "【${BLUE}20${NC}】【${WHITE}更新日志${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}00${NC}】【${RED}退出脚本${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
    else
        echo -e "【${RED}System Tools Collection${NC}】【${YELLOW}${VERSION}${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${WHITE}Author Website】【${YELLOW} https://scarsong.com ${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${YELLOW}Shortcut${NC}】【${WHITE}Use the shortcut key ${YELLOW}s${WHITE} to quickly start the script${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}01${NC}】【${BLUE}Manage${YELLOW} Docker ${BLUE}firewall rules${NC}】"
        echo -e "【${BLUE}02${NC}】【${BLUE}Manage${YELLOW} iptables IPv4 / ip6tables IPv6 ${BLUE}input chain rules${NC}】"
        echo -e "【${BLUE}03${NC}】【${BLUE}Manage server ${YELLOW}SSH ${BLUE}firewall rules${NC}】"
        echo -e "【${BLUE}04${NC}】【${BLUE}View ${YELLOW}iptables IPv4 Docker ${BLUE}user chain rules${NC}】"
        echo -e "【${BLUE}05${NC}】【${BLUE}View ${YELLOW}ip6tables IPv6 Docker ${BLUE}user chain rules${NC}】"
        echo -e "【${BLUE}06${NC}】【${BLUE}View ${YELLOW}iptables IPv4 Docker NAT ${BLUE}rules${NC}】"
        echo -e "【${BLUE}07${NC}】【${BLUE}View ${YELLOW}ip6tables IPv6 Docker NAT ${BLUE}rules${NC}】"
        echo -e "【${BLUE}08${NC}】【${BLUE}System session management with ${YELLOW}screen ${BLUE}tool${NC}】"
        echo -e "【${BLUE}09${NC}】【${BLUE}Common system commands${NC}】"
		echo -e "【${BLUE}10${NC}】【${BLUE}Show ${YELLOW}Docker ${BLUE}Container Info${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}18${NC}】【${RED}Switch script language${NC}】【${YELLOW}切换脚本显示语言${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}19${NC}】【${GREEN}Update script${NC}】"
        echo -e "【${BLUE}20${NC}】【${WHITE}Change log${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}00${NC}】【${RED}Exit script${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
    fi
}

# show_docker_container_info
# 显示 Docker 容器信息

# Display Docker container information
# 根据语言显示命令信息
show_docker_container_info() {
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${BLUE}执行命令${NC}】【${BLUE}显示 ${YELLOW}Docker ${BLUE}容器信息${NC}】"
    else
        echo -e "【${BLUE}Command${NC}】【${BLUE}Show ${YELLOW}Docker ${BLUE}Container Info${NC}】"
    fi

    # Temporary files to store container details
    # 临时文件用于存储容器详情
    temp_file=$(mktemp)
    long_ports_file=$(mktemp)

    # Function to print column headers
    # 打印列标题的函数
    print_header() {
        echo -e "${BLUE}================================================================================================================================================================${NC}"
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "${RED}容器名称                         ${BLUE}网络名称               ${YELLOW}IPv4地址          ${YELLOW}IPv6地址          ${WHITE}容器状态          ${GREEN}端口信息${NC}"
        else
            echo -e "${RED}Container Name                   ${BLUE}Network Name           ${YELLOW}IPv4 Address      ${YELLOW}IPv6 Address      ${WHITE}Container Status  ${GREEN}Port Information${NC}"
        fi
    }

    # Print headers
    # 打印标题
    print_header

    # Get all network IDs
    # 获取所有网络ID
    docker network ls -q | while read network_id; do
        network_name=$(docker network inspect --format '{{.Name}}' "$network_id")

        # If network name is not retrieved, skip this group
        # 如果没有获取到网络名称，跳过这个分组
        if [ -z "$network_name" ]; then
            continue
        fi

        # Print separator line
        # 打印分隔线
        echo -e "${BLUE}================================================================================================================================================================${NC}"

        docker network inspect "$network_id" --format '{{json .Containers}}' | jq -r '
            to_entries[] |
            .value |
            "\(.Name) \(.IPv4Address // "") \(.IPv6Address // "")"
        ' | while read container_name ipv4 ipv6; do
            # Ensure using full container ID
            # 确保使用完整的容器ID
            container_id=$(docker ps --filter "name=^/${container_name}$" --format "{{.ID}}")
            container_id=${container_id:-""}

            network_mode=$(docker inspect --format '{{.HostConfig.NetworkMode}}' "$container_id" 2>/dev/null || echo "")

            if [ "$network_mode" = "host" ]; then
                ports="Host network - no port mappings"
            elif [ -n "$network_mode" ]; then
                # Get port mappings, avoiding duplicate retrieval
                # 获取端口映射，避免重复获取
                ports=$(docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}}{{if $conf}}{{range $v := $conf}}{{if or (eq (index $v "HostIp") "0.0.0.0") (eq (index $v "HostIp") "::")}}{{index $v "HostIp"}}:{{index $v "HostPort"}}->{{$p}}, {{end}}{{end}}{{end}}{{end}}' "$container_id" | sort | uniq | sed 's/, $//')
                ports=${ports:-""}
            else
                ports=""
            fi

            status=$(docker inspect --format '{{.State.Status}}' "$container_id" 2>/dev/null || echo "")
            health_status=$(docker inspect --format '{{.State.Health.Status}}' "$container_id" 2>/dev/null || echo "")

            if [ -n "$health_status" ]; then
                status="$status($health_status)"
            fi


            # If the field is empty, set it to "N/A"
            # 如果字段为空，设置为 "N/A"
            ipv4=${ipv4:-"N/A"}
            ipv6=${ipv6:-"N/A"}
            ports=${ports:-"N/A"}
            status=${status:-"N/A"}

            # Determine if port information is considered long
            # 确定端口信息是否过长
            comma_count=$(echo "$ports" | grep -o ',' | wc -l)
            max_comma_count=1
            if [ $comma_count -gt $max_comma_count ]; then
                echo "$container_name $network_name $ipv4 $ipv6 $status $ports" >> "$long_ports_file"
            else
                printf "%-40b  %-30b  %-25b  %-25b  %-25b  %b%s\n" \
                    "${RED}$container_name${NC}" "${BLUE}$network_name${NC}" "${YELLOW}$ipv4${NC}" "${YELLOW}$ipv6${NC}" "${WHITE}$status${NC}" "${GREEN}$ports${NC}" >> "$temp_file"
            fi
        done

        # Sort short entries by container name and display
        # 将短条目按容器名称排序后显示
        sort -k1,1 "$temp_file"

        # Display long entries sorted by length (shortest first)
        # 显示超长条目，按照条目长度从短到长显示
        sort -k6,6 -r "$long_ports_file" | while IFS= read -r line; do
            IFS=' ' read -r container_name network_name ipv4 ipv6 status ports <<< "$line"
            printf "%-40b  %-30b  %-25b  %-25b  %-25b  %b%s\n" \
                "${RED}$container_name${NC}" "${BLUE}$network_name${NC}" "${YELLOW}$ipv4${NC}" "${YELLOW}$ipv6${NC}" "${WHITE}$status${NC}" "${GREEN}$ports${NC}"
        done

        # Clear temporary files
        # 清空临时文件
        > "$temp_file"
        > "$long_ports_file"
    done

    # Clean up temporary files
    # 清理临时文件
    rm "$temp_file" "$long_ports_file"

    echo -e "${BLUE}================================================================================================================================================================${NC}"
}

# Show system commands submenu function
# 显示常用系统命令子菜单函数
show_system_commands() {
    while true; do
        clear
        echo -e "${BLUE}================================================================================${NC}"
        
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}常用系统命令${NC}】"
            echo -e "${BLUE}================================================================================${NC}"
            echo -e "【${BLUE}01${NC}】【${BLUE}显示磁盘使用情况${NC}】【${YELLOW}df -h -x overlay -x tmpfs${NC}】"
            echo -e "【${BLUE}02${NC}】【${BLUE}显示主机信息${NC}】【${YELLOW}hostnamectl${NC}】"
            echo -e "【${BLUE}03${NC}】【${BLUE}显示所有Docker容器${NC}】【${YELLOW}docker ps -a${NC}】"
            echo -e "【${BLUE}04${NC}】【${BLUE}显示内存使用情况${NC}】【${YELLOW}free -m${NC}】"
            echo -e "【${BLUE}05${NC}】【${BLUE}重启Docker服务${NC}】【${YELLOW}systemctl restart docker${NC}】"
            echo -e "【${BLUE}06${NC}】【${BLUE}显示Docker版本信息${NC}】【${YELLOW}docker version${NC}】"
            echo -e "【${BLUE}07${NC}】【${BLUE}更新并升级系统${NC}】【${YELLOW}apt-get update && apt-get upgrade${NC}】"
            echo -e "【${BLUE}08${NC}】【${BLUE}显示当前登录用户信息${NC}】【${YELLOW}who -u${NC}】"
            echo -e "【${BLUE}09${NC}】【${BLUE}重新启动系统${NC}】【${YELLOW}reboot${NC}】"
            echo -e "【${BLUE}00${NC}】【${RED}返回主菜单${NC}】"
            echo -e "${BLUE}================================================================================${NC}"
        else
            echo -e "【${RED}System Commands${NC}】"
            echo -e "${BLUE}================================================================================${NC}"
            echo -e "【${BLUE}01${NC}】【${BLUE}Show disk usage${NC}】【${YELLOW}df -h -x overlay -x tmpfs${NC}】"
            echo -e "【${BLUE}02${NC}】【${BLUE}Show host information${NC}】【${YELLOW}hostnamectl${NC}】"
            echo -e "【${BLUE}03${NC}】【${BLUE}Show all Docker containers${NC}】【${YELLOW}docker ps -a${NC}】"
            echo -e "【${BLUE}04${NC}】【${BLUE}Show memory usage${NC}】【${YELLOW}free -m${NC}】"
            echo -e "【${BLUE}05${NC}】【${BLUE}Restart Docker service${NC}】【${YELLOW}systemctl restart docker${NC}】"
            echo -e "【${BLUE}06${NC}】【${BLUE}Show Docker version${NC}】【${YELLOW}docker version${NC}】"
            echo -e "【${BLUE}07${NC}】【${BLUE}Update and upgrade system${NC}】【${YELLOW}apt-get update && apt-get upgrade${NC}】"
            echo -e "【${BLUE}08${NC}】【${BLUE}Show current user information${NC}】【${YELLOW}who -u${NC}】"
            echo -e "【${BLUE}09${NC}】【${BLUE}Reboot system${NC}】【${YELLOW}reboot${NC}】"
            echo -e "【${BLUE}00${NC}】【${RED}Return to main menu${NC}】"
            echo -e "${BLUE}================================================================================${NC}"
        fi

        if [ "$LANGUAGE" = "CN" ]; then
            echo -ne "【${RED}输入选项编号并按回车确认${NC}】"
        else
            echo -ne "【${RED}Enter option number and press Enter to confirm${NC}】"
        fi
        read sys_cmd_choice
        case $sys_cmd_choice in
            01)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 显示磁盘使用情况 (df -h -x overlay -x tmpfs)${NC}】"
                else
                    echo -e "【${BLUE}Command: Show disk usage (df -h -x overlay -x tmpfs)${NC}】"
                fi
                df -h -x overlay -x tmpfs
                ;;
            02)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 显示主机信息 (hostnamectl)${NC}】"
                else
                    echo -e "【${BLUE}Command: Show host information (hostnamectl)${NC}】"
                fi
                hostnamectl
                ;;
            03)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 显示所有Docker容器 (docker ps -a)${NC}】"
                else
                    echo -e "【${BLUE}Command: Show all Docker containers (docker ps -a)${NC}】"
                fi
                docker ps -a
                ;;
            04)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 显示内存使用情况 (free -m)${NC}】"
                else
                    echo -e "【${BLUE}Command: Show memory usage (free -m)${NC}】"
                fi
                free -m
                ;;
            05)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 重启Docker服务 (systemctl restart docker)${NC}】"
                else
                    echo -e "【${BLUE}Command: Restart Docker service (systemctl restart docker)${NC}】"
                fi
                systemctl restart docker
                ;;
            06)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 显示Docker版本信息 (docker version)${NC}】"
                else
                    echo -e "【${BLUE}Command: Show Docker version (docker version)${NC}】"
                fi
                docker version
                ;;
            07)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 更新并升级系统 (apt-get update && apt-get upgrade)${NC}】"
                else
                    echo -e "【${BLUE}Command: Update and upgrade system (apt-get update && apt-get upgrade)${NC}】"
                fi
                apt-get update && apt-get upgrade
                ;;
            08)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 显示当前登录用户信息 (who -u)${NC}】"
                else
                    echo -e "【${BLUE}Command: Show current user information (who -u)${NC}】"
                fi
                who -u
                ;;
            09)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}执行命令: 重新启动系统 (reboot)${NC}】"
                else
                    echo -e "【${BLUE}Command: Reboot system (reboot)${NC}】"
                fi
                reboot
                ;;
            00)
                break
                ;;
            *)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${RED}无效选项${NC}】"
                else
                    echo -e "【${RED}Invalid option${NC}】"
                fi
                ;;
        esac
        
        # Prompt user to return to the submenu
        if [ "$LANGUAGE" = "CN" ]; then
            echo -ne "【${RED}按回车键返回子菜单${NC}】"
        else
            echo -ne "【${RED}Press Enter to return to the submenu${NC}】"
        fi
        read -r
    done
}

# Manage screen tool function
# 管理 screen 工具的函数
manage_screen() {
    if ! command -v screen &> /dev/null; then
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}screen 工具未安装${NC}】"
            read -p "【${YELLOW}是否立即安装 screen 工具？（y/n）${NC}】" install_choice
        else
            echo -e "【${RED}Screen tool is not installed${NC}】"
            read -p "【${YELLOW}Do you want to install the screen tool now? (y/n)${NC}】" install_choice
        fi
        if [[ "$install_choice" == "y" || "$install_choice" == "Y" ]]; then
            sudo apt-get update && sudo apt-get install -y screen
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${GREEN}screen 工具已成功安装${NC}】"
            else
                echo -e "【${GREEN}Screen tool has been successfully installed${NC}】"
            fi
        else
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${RED}操作已取消，返回主菜单${NC}】"
            else
                echo -e "【${RED}Operation canceled, returning to main menu${NC}】"
            fi
            return
        fi
    fi

    while true; do
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${BLUE}1${NC}】 ${BLUE}查看现有会话${NC}"
            echo -e "【${BLUE}2${NC}】 ${BLUE}创建新会话${NC}"
            echo -e "【${BLUE}3${NC}】 ${BLUE}脱离当前会话${NC}"
            echo -e "【${BLUE}4${NC}】 ${BLUE}重新回到默认会话${NC}"
            echo -e "【${BLUE}5${NC}】 ${BLUE}删除会话${NC}"
            echo -e "【${BLUE}q${NC}】 ${BLUE}返回主菜单${NC}"
            read -p "【请输入选项】" screen_choice
        else
            echo -e "【${BLUE}1${NC}】 ${BLUE}View existing sessions${NC}"
            echo -e "【${BLUE}2${NC}】 ${BLUE}Create new session${NC}"
            echo -e "【${BLUE}3${NC}】 ${BLUE}Detach current session${NC}"
            echo -e "【${BLUE}4${NC}】 ${BLUE}Resume default session${NC}"
            echo -e "【${BLUE}5${NC}】 ${BLUE}Delete session${NC}"
            echo -e "【${BLUE}q${NC}】 ${BLUE}Return to main menu${NC}"
            read -p "【Please enter an option】" screen_choice
        fi

        case $screen_choice in
            1)
                screen -ls | grep -q "No Sockets found"
                if [ $? -eq 0 ]; then
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${YELLOW}当前没有正在运行的会话${NC}】"
                    else
                        echo -e "【${YELLOW}No active sessions found${NC}】"
                    fi
                else
                    screen -ls
                fi
                ;;
            2)
                if [ "$LANGUAGE" = "CN" ]; then
                    read -p "【请输入新会话名称】" session_name
                else
                    read -p "【Enter new session name】" session_name
                fi
                screen -S "$session_name"
                ;;
            3)
                screen -d
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${GREEN}当前会话已脱离${NC}】"
                else
                    echo -e "【${GREEN}Current session detached${NC}】"
                fi
                ;;
            4)
                screen -ls | grep -q "No Sockets found"
                if [ $? -eq 0 ]; then
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${YELLOW}当前没有可恢复的会话${NC}】"
                    else
                        echo -e "【${YELLOW}No sessions available to resume${NC}】"
                    fi
                else
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}选择要恢复的会话${NC}】"
                    else
                        echo -e "【${BLUE}Select the session to resume${NC}】"
                    fi
                    screen -ls
                    if [ "$LANGUAGE" = "CN" ]; then
                        read -p "【请输入会话名称】" session_name
                    else
                        read -p "【Enter session name】" session_name
                    fi
                    screen -r "$session_name"
                fi
                ;;
            5)
                screen -ls | grep -q "No Sockets found"
                if [ $? -eq 0 ]; then
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${YELLOW}当前没有可删除的会话${NC}】"
                    else
                        echo -e "【${YELLOW}No sessions available to delete${NC}】"
                    fi
                else
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}选择要删除的会话${NC}】"
                    else
                        echo -e "【${BLUE}Select the session to delete${NC}】"
                    fi
                    screen -ls
                    if [ "$LANGUAGE" = "CN" ]; then
                        read -p "【请输入会话名称】" session_name
                    else
                        read -p "【Enter session name】" session_name
                    fi
                    screen -S "$session_name" -X quit
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${GREEN}会话 ${session_name} 已删除${NC}】"
                    else
                        echo -e "【${GREEN}Session ${session_name} has been deleted${NC}】"
                    fi
                fi
                ;;
            q)
                break
                ;;
            *)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${RED}无效选项${NC}】"
                else
                    echo -e "【${RED}Invalid option${NC}】"
                fi
                ;;
        esac
    done
}

# Output command function, filter and colorize
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

# List all rules
# 列出所有规则
list_rules() {
    local table=$1
    local chain=$2
    eval "$table -L $chain -n --line-numbers"
}

# Delete specified rule
# 删除指定规则
delete_rule() {
    local table=$1
    local chain=$2
    local rule_number=$3
    eval "$table -D $chain $rule_number"
}

# Return to main menu function
# 返回主菜单函数
return_to_main_menu() {
    return  # Simply return to upper-level loop 简单返回上层循环
}

# Delete rule and handle renumbering issues
# 删除规则并处理重新编号问题
process_rule_deletion() {
    local table=$1
    local chain=$2
    local rule_number

    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${BLUE}当前 ${chain} 链规则 ${YELLOW}(${table})${NC}】"
        list_rules "$table" "$chain" | output_command

        while true; do
            echo -e "【${RED}请选择要删除的规则编号（用空格分隔多个编号）输入完毕后按回车确认${NC}】"
            read -p "【规则编号】" -a rule_numbers

            # Check if user chose to return to the main menu
            # 检查用户是否选择返回主菜单
            if [[ " ${rule_numbers[*]} " =~ " q " ]]; then
                return_to_main_menu
                return
            fi

            # Check if the input rule number is a valid number
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
                echo  # Output a new line to ensure prompts do not overlap 输出新行，确保提示不覆盖
                echo -e "【${YELLOW}已跳过规则删除阶段${NC}】"
                return  # Exit the function 跳出函数
            fi

            # Ensure rule numbers are sorted (in descending order to avoid numbering issues)
            # 确保规则编号排序（降序排序，以避免编号变化问题）
            IFS=$'\n' sorted_rule_numbers=($(sort -nr <<<"${rule_numbers[*]}"))
            unset IFS

            for rule_number in "${sorted_rule_numbers[@]}"; do
                echo -e "【${BLUE}正在删除规则编号 ${rule_number}${NC}】"
                delete_rule "$table" "$chain" "$rule_number"
                sleep 1  # Wait for rule deletion to take effect 等待规则删除生效
                list_rules "$table" "$chain" | output_command
            done

            echo -e "【${GREEN}规则删除完成${NC}】"
            return
        done
    else
        echo -e "【${BLUE}Current rules for ${chain} chain ${YELLOW}(${table})${NC}】"
        list_rules "$table" "$chain" | output_command

        while true; do
            echo -e "【${RED}Select rule numbers to delete (separate multiple numbers with spaces). Press Enter to confirm${NC}】"
            read -p "【Rule numbers】" -a rule_numbers

            # Check if user chose to return to the main menu
            # 检查用户是否选择返回主菜单
            if [[ " ${rule_numbers[*]} " =~ " q " ]]; then
                return_to_main_menu
                return
            fi

            # Check if the input rule number is a valid number
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
                echo  # Output a new line to ensure prompts do not overlap 输出新行，确保提示不覆盖
                echo -e "【${YELLOW}Skipping rule deletion phase${NC}】"
                return  # Exit the function 跳出函数
            fi

            # Ensure rule numbers are sorted (in descending order to avoid numbering issues)
            # 确保规则编号排序（降序排序，以避免编号变化问题）
            IFS=$'\n' sorted_rule_numbers=($(sort -nr <<<"${rule_numbers[*]}"))
            unset IFS

            for rule_number in "${sorted_rule_numbers[@]}"; do
                echo -e "【${BLUE}Deleting rule number ${rule_number}${NC}】"
                delete_rule "$table" "$chain" "$rule_number"
                sleep 1  # Wait for rule deletion to take effect 等待规则删除生效
                list_rules "$table" "$chain" | output_command
            done

            echo -e "【${GREEN}Rule deletion complete${NC}】"
            return
        done
    fi
}

# Handle rule deletion
# 处理规则删除
handle_rule_deletion() {
    while true; do
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${BLUE}1${NC}】 ${BLUE}删除某一个编号的规则${NC}"
            echo -e "【${BLUE}2${NC}】 ${BLUE}删除多个规则${NC}"
            echo -e "【${BLUE}3${NC}】 ${BLUE}删除所有规则${NC}"
            echo -e "【${BLUE}q${NC}】 ${BLUE}返回主菜单${NC}"
            read -p "【请输入选项】" delete_choice
        else
            echo -e "【${BLUE}1${NC}】 ${BLUE}Delete a rule by number${NC}"
            echo -e "【${BLUE}2${NC}】 ${BLUE}Delete multiple rules${NC}"
            echo -e "【${BLUE}3${NC}】 ${BLUE}Delete all rules${NC}"
            echo -e "【${BLUE}q${NC}】 ${BLUE}Return to main menu${NC}"
            read -p "【Please enter an option】" delete_choice
        fi

        case $delete_choice in
            1)
                while true; do
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}删除某一个编号的规则${NC}】"
                        read -p "【请输入要删除的规则编号】" rule_number
                    else
                        echo -e "【${BLUE}Delete a rule by number${NC}】"
                        read -p "【Enter the rule number to delete】" rule_number
                    fi

                    # Check if user chose to return to the main menu
                    # 检查用户是否选择返回主菜单
                    if [[ "$rule_number" == "q" ]]; then
                        return_to_main_menu
                        return
                    fi

                    # Check if input is a number
                    # 检查输入是否为数字
                    if ! [[ "$rule_number" =~ ^[0-9]+$ ]]; then
                        echo  # Output a new line to ensure the prompt doesn't overwrite
                        if [ "$LANGUAGE" = "CN" ]; then
                            echo -e "【${YELLOW}已跳过规则删除阶段${NC}】"
                        else
                            echo -e "【${YELLOW}Rule deletion phase skipped${NC}】"
                        fi
                        return  # Exit function
                    fi

                    # Check if rule number exists
                    # 检查规则编号是否存在
                    if ! iptables -L INPUT --line-numbers | awk '{print $1}' | grep -q "^$rule_number$"; then
                        echo  # Output a new line to ensure the prompt doesn't overwrite
                        if [ "$LANGUAGE" = "CN" ]; then
                            echo -e "【${YELLOW}已跳过规则删除阶段${NC}】"
                        else
                            echo -e "【${YELLOW}Rule deletion phase skipped${NC}】"
                        fi
                        return  # Exit function
                    else
                        break  # Valid input, exit loop
                    fi
                done

                # Delete rule
                # 删除规则
                iptables -D INPUT "$rule_number" 2>/dev/null
                ip6tables -D INPUT "$rule_number" 2>/dev/null
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -ne "【${GREEN}规则编号 ${rule_number} 已删除${NC}】\n"
                else
                    echo -ne "【${GREEN}Rule number ${rule_number} deleted${NC}】\n"
                fi
                ;;
            2)
                # Handle IPv4 rules
                # 处理 IPv4 规则
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}处理 IPv4 规则${NC}】"
                else
                    echo -e "【${BLUE}Handling IPv4 rules${NC}】"
                fi
                process_rule_deletion "iptables" "INPUT"

                # Ensure IPv6 rules are handled after IPv4
                # 确保处理完 IPv4 规则后再处理 IPv6
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${BLUE}处理 IPv6 规则${NC}】"
                else
                    echo -e "【${BLUE}Handling IPv6 rules${NC}】"
                fi
                process_rule_deletion "ip6tables" "INPUT"
                ;;
            3)
                while true; do
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}删除所有规则${NC}】"
                        read -p "【${YELLOW}确定要删除所有规则吗？输入${RED} Y/N ${YELLOW}或${RED} 'q' ${YELLOW}返回主菜单${NC}】" confirm
                    else
                        echo -e "【${BLUE}Delete all rules${NC}】"
                        read -p "【${YELLOW}Are you sure you want to delete all rules? Enter ${RED} Y/N ${YELLOW} or ${RED} 'q' ${YELLOW} to return to main menu${NC}】" confirm
                    fi
                    if [[ "$confirm" =~ ^[ynq]$ ]]; then
                        break  # Exit loop, continue processing option
                    else
                        if [ "$LANGUAGE" = "CN" ]; then
                            echo -e "【${RED}无效输入，请重新输入${NC}】"
                        else
                            echo -e "【${RED}Invalid input, please try again${NC}】"
                        fi
                    fi
                done

                if [[ "$confirm" == "q" ]]; then
                    return_to_main_menu
                    return
                elif [[ "$confirm" == "y" ]]; then
                    iptables -F INPUT
                    ip6tables -F INPUT
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -ne "【${GREEN}所有 INPUT 链规则已删除${NC}】\n"
                    else
                        echo -ne "【${GREEN}All INPUT chain rules deleted${NC}】\n"
                    fi
                else
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${YELLOW}操作已取消${NC}】"
                    else
                        echo -e "【${YELLOW}Operation canceled${NC}】"
                    fi
                fi
                ;;
            q)
                return_to_main_menu
                return
                ;;
            *)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${RED}无效选项${NC}】"
                else
                    echo -e "【${RED}Invalid option${NC}】"
                fi
                echo  # Output a new line to ensure the prompt doesn't overwrite
                ;;
        esac
    done
}

# Manage firewall rules
# 管理防火墙规则
manage_firewall() {
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${RED}已选择管理防火墙输入链规则${NC}】"
        echo -e "【${BLUE}1${NC}】 ${BLUE}查看防火墙输入链规则${NC}"
        echo -e "【${BLUE}2${NC}】 ${BLUE}删除防火墙输入链规则${NC}"
        read -p "【请输入选项】" manage_choice
    else
        echo -e "【${RED}Selected to manage firewall INPUT chain rules${NC}】"
        echo -e "【${BLUE}1${NC}】 ${BLUE}View firewall INPUT chain rules${NC}"
        echo -e "【${BLUE}2${NC}】 ${BLUE}Delete firewall INPUT chain rules${NC}"
        read -p "【Please enter an option】" manage_choice
    fi

    case $manage_choice in
        1)
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${BLUE}查看防火墙输入链规则${NC}】"
                echo -e "【${BLUE}1${NC}】 ${BLUE}查看${YELLOW} iptables IPv4 ${BLUE}输入链规则${NC}"
                echo -e "【${BLUE}2${NC}】 ${BLUE}查看${YELLOW} ip6tables IPv6 ${BLUE}输入链规则${NC}"
                read -p "【请输入选项】" view_choice
            else
                echo -e "【${BLUE}View firewall INPUT chain rules${NC}】"
                echo -e "【${BLUE}1${NC}】 ${BLUE}View ${YELLOW} iptables IPv4 ${BLUE} INPUT chain rules${NC}"
                echo -e "【${BLUE}2${NC}】 ${BLUE}View ${YELLOW} ip6tables IPv6 ${BLUE} INPUT chain rules${NC}"
                read -p "【Please enter an option】" view_choice
            fi

            case $view_choice in
                1)
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}查看${YELLOW} iptables IPv4 ${BLUE}输入链规则${NC}】"
                    else
                        echo -e "【${BLUE}Viewing ${YELLOW} iptables IPv4 ${BLUE} INPUT chain rules${NC}】"
                    fi
                    list_rules "iptables" "INPUT" | output_command
                    ;;
                2)
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}查看${YELLOW} ip6tables IPv6 ${BLUE}输入链规则${NC}】"
                    else
                        echo -e "【${BLUE}Viewing ${YELLOW} ip6tables IPv6 ${BLUE} INPUT chain rules${NC}】"
                    fi
                    list_rules "ip6tables" "INPUT" | output_command
                    ;;
                *)
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${RED}无效选项${NC}】"
                    else
                        echo -e "【${RED}Invalid option${NC}】"
                    fi
                    ;;
            esac
            ;;
        2)
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${BLUE}删除防火墙输入链规则${NC}】"
                echo -e "【${BLUE}1${NC}】 ${BLUE}删除${YELLOW} iptables IPv4 ${BLUE}输入链规则${NC}"
                echo -e "【${BLUE}2${NC}】 ${BLUE}删除${YELLOW} ip6tables IPv6 ${BLUE}输入链规则${NC}"
                read -p "【请输入选项】" delete_choice
            else
                echo -e "【${BLUE}Delete firewall INPUT chain rules${NC}】"
                echo -e "【${BLUE}1${NC}】 ${BLUE}Delete ${YELLOW} iptables IPv4 ${BLUE} INPUT chain rules${NC}"
                echo -e "【${BLUE}2${NC}】 ${BLUE}Delete ${YELLOW} ip6tables IPv6 ${BLUE} INPUT chain rules${NC}"
                read -p "【Please enter an option】" delete_choice
            fi

            case $delete_choice in
                1)
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}管理${YELLOW} iptables IPv4 ${BLUE}输入链规则${NC}】"
                    else
                        echo -e "【${BLUE}Managing ${YELLOW} iptables IPv4 ${BLUE} INPUT chain rules${NC}】"
                    fi
                    handle_rule_deletion
                    ;;
                2)
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}管理${YELLOW} ip6tables IPv6 ${BLUE}输入链规则${NC}】"
                    else
                        echo -e "【${BLUE}Managing ${YELLOW} ip6tables IPv6 ${BLUE} INPUT chain rules${NC}】"
                    fi
                    handle_rule_deletion
                    ;;
                *)
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${RED}无效选项${NC}】"
                    else
                        echo -e "【${RED}Invalid option${NC}】"
                    fi
                    ;;
            esac
            ;;
        *)
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${RED}无效选项${NC}】"
            else
                echo -e "【${RED}Invalid option${NC}】"
            fi
            ;;
    esac
}

# Display the name of the ongoing project
# 显示正在进行的项目名称
show_progress() {
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${YELLOW}正在进行${NC}】${1}${NC}"
    else
        echo -e "【${YELLOW}In progress${NC}】${1}${NC}"
    fi
}

# Manage SSH firewall rules
# 管理 SSH 防火墙规则
manage_ssh_firewall() {
    if [ "$LANGUAGE" = "CN" ]; then
        show_progress "【${BLUE}管理${YELLOW} SSH ${BLUE}防火墙规则${NC}】"
        echo -e "【${RED}系统中是否已经配置${YELLOW} SSH ${RED}防火墙规则${NC}】"
        echo -e "【${BLUE}1${NC}】 ${BLUE}是${NC}"
        echo -e "【${BLUE}2${NC}】 ${BLUE}否${NC}"
        read -p "【请输入选项】" ssh_choice
    else
        show_progress "【${BLUE}Managing${YELLOW} SSH ${BLUE}Firewall Rules${NC}】"
        echo -e "【${RED}Are SSH ${YELLOW}firewall rules${RED} configured in the system${NC}】"
        echo -e "【${BLUE}1${NC}】 ${BLUE}Yes${NC}"
        echo -e "【${BLUE}2${NC}】 ${BLUE}No${NC}"
        read -p "【Please enter an option】" ssh_choice
    fi

    case $ssh_choice in
        1)
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${BLUE}1${NC}】 ${BLUE}查看现有规则${NC}"
                echo -e "【${BLUE}2${NC}】 ${BLUE}修改现有规则${NC}"
                read -p "【请输入选项】" modify_choice
            else
                echo -e "【${BLUE}1${NC}】 ${BLUE}View existing rules${NC}"
                echo -e "【${BLUE}2${NC}】 ${BLUE}Modify existing rules${NC}"
                read -p "【Please enter an option】" modify_choice
            fi

            if [[ $modify_choice == "1" ]]; then
                # Display the current firewall rules
                # 查看现有防火墙规则
                if [ "$LANGUAGE" = "CN" ]; then
                    show_progress "【${BLUE}查看现有防火墙规则${NC}】"
                else
                    show_progress "【${BLUE}Viewing Existing Firewall Rules${NC}】"
                fi
                iptables -L INPUT -n --line-numbers | output_command
                ip6tables -L INPUT -n --line-numbers | output_command
                show_ipset   # Display IPSET addresses
                # 调用显示 IPSET 地址
            elif [[ $modify_choice == "2" ]]; then
                # Check for existing rules files or services
                # 检查现有规则文件或服务
                if [ -f "/root/add_ssh_ips.sh" ]; then
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${RED}现有规则文件已存在${NC}】"
                        read -p "【是否要修改现有规则文件】【1】 是 【2】 否" modify_choice
                        if [[ $modify_choice == "1" ]]; then
                            # Call the function to modify existing rules
                            # 调用修改函数
                            modify_existing_rules
                        else
                            echo -e "【${BLUE}不进行修改${NC}】"
                        fi
                    else
                        echo -e "【${RED}Existing rules file already exists${NC}】"
                        read -p "【Do you want to modify the existing rules file】【1】 Yes 【2】 No" modify_choice
                        if [[ $modify_choice == "1" ]]; then
                            # Call the function to modify existing rules
                            # 调用修改函数
                            modify_existing_rules
                        else
                            echo -e "【${BLUE}No modification${NC}】"
                        fi
                    fi
                else
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${RED}规则文件不存在${NC}】【${RED}开始创建新的规则文件${NC}】"
                    else
                        echo -e "【${RED}Rules file not found${NC}】【${RED}Starting creation of new rules file${NC}】"
                    fi
                    if [ "$LANGUAGE" = "CN" ]; then
                        read -p "【是否要创建新的规则文件】【1】 是 【2】 否" create_choice
                    else
                        read -p "【Do you want to create a new rules file】【1】 Yes 【2】 No" create_choice
                    fi
                    if [[ $create_choice == "1" ]]; then
                        # Call the function to create SSH rules
                        # 调用创建函数
                        create_ssh_rules
                    else
                        echo -e "【${BLUE}不进行创建${NC}】"
                    fi
                fi
            else
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${RED}无效选项${NC}】"
                else
                    echo -e "【${RED}Invalid option${NC}】"
                fi
            fi
            ;;
        2)
            # Check if SSH rules file exists before creating
            # 在创建之前检查 SSH 规则文件是否存在
            if [ -f "/root/add_ssh_ips.sh" ]; then
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${RED}现有规则文件已存在${NC}】"
                    read -p "【是否要修改现有规则文件】【1】 是 【2】 否" modify_choice
                    if [[ $modify_choice == "1" ]]; then
                        # Call the function to modify existing rules
                        # 调用修改函数
                        modify_existing_rules
                    else
                        echo -e "【${BLUE}不进行修改${NC}】"
                    fi
                else
                    echo -e "【${RED}Existing rules file already exists${NC}】"
                    read -p "【Do you want to modify the existing rules file】【1】 Yes 【2】 No" modify_choice
                    if [[ $modify_choice == "1" ]]; then
                        # Call the function to modify existing rules
                        # 调用修改函数
                        modify_existing_rules
                    else
                        echo -e "【${BLUE}No modification${NC}】"
                    fi
                fi
            else
                # Call the function to create SSH rules
                # 调用创建函数
                create_ssh_rules
            fi
            ;;
        *)
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${RED}无效选项${NC}】"
            else
                echo -e "【${RED}Invalid option${NC}】"
            fi
            ;;
    esac
}

# Create SSH firewall rules
# 创建 SSH 防火墙规则
create_ssh_rules() {
    if [ "$LANGUAGE" = "CN" ]; then
        show_progress "【${BLUE}创建${YELLOW} SSH ${BLUE}防火墙规则${NC}】"
    else
        show_progress "【${BLUE}Creating${YELLOW} SSH ${BLUE}Firewall Rules${NC}】"
    fi

    # Display a message indicating the creation of the /root/add_ssh_ips.sh file and startup service
    # 显示创建 /root/add_ssh_ips.sh 文件及开机自启动服务的提示信息
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${YELLOW}正在创建 ${GREEN}/root/add_ssh_ips.sh ${YELLOW}配置文件及开机自启动服务文件${NC}】"
    else
        echo -e "【${YELLOW}Creating ${GREEN}/root/add_ssh_ips.sh ${YELLOW}configuration file and startup service file${NC}】"
    fi
	
    # Check and install ipset
    # 检查并安装ipset
    if ! command -v ipset &> /dev/null; then
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}检测出${YELLOW} ipset ${NC}未安装${NC}】【${RED}已经开始部署${NC}】"
        else
            echo -e "【${RED}Detected${YELLOW} ipset ${NC}is not installed${NC}】【${RED}Starting installation${NC}】"
        fi
        apt-get update && apt-get install -y ipset
    else
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}发现当前${YELLOW} ipset ${GREEN}已存在${NC}】【已经跳过安装${NC}】"
        else
            echo -e "【${GREEN}Found existing${YELLOW} ipset ${GREEN}installed${NC}】【Skipping installation${NC}】"
        fi
    fi

    # Get SSH port number
    # 获取 SSH 端口号
    PORT=$(grep "^Port " /etc/ssh/sshd_config | awk '{print $2}')
    if [ -z "$PORT" ]; then
        if [ "$LANGUAGE" = "CN" ]; then
            read -p "【尝试自动检测${YELLOW} SSH ${NC}端口号已失败】【需要手动输入】" PORT
        else
            read -p "【Failed to auto-detect${YELLOW} SSH ${NC}port】【Please enter manually】" PORT
        fi
    fi

    # Prompt the user to enter IPv4 and IPv6 addresses
    # 让用户输入IPv4和IPv6地址
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${RED}请输入允许访问${YELLOW} SSH ${RED}的${YELLOW} IPv4 ${RED}地址${NC}】【${RED}可用空格分隔多个地址${NC}】"
        read -p "【IPv4 地址】" ipv4_addresses
        echo -e "【${RED}请输入允许访问${YELLOW} SSH ${RED}的${YELLOW} IPv6 ${RED}地址${NC}】【${RED}可用空格分隔多个地址${NC}】"
        read -p "【IPv6 地址】" ipv6_addresses
    else
        echo -e "【${RED}Please enter the${YELLOW} IPv4 ${RED}addresses allowed to access${YELLOW} SSH ${RED}${NC}】【${RED}Separate multiple addresses with spaces${NC}】"
        read -p "【IPv4 addresses】" ipv4_addresses
        echo -e "【${RED}Please enter the${YELLOW} IPv6 ${RED}addresses allowed to access${YELLOW} SSH ${RED}${NC}】【${RED}Separate multiple addresses with spaces${NC}】"
        read -p "【IPv6 addresses】" ipv6_addresses
    fi

    # Create the add_ssh_ips.sh script
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

    # Ensure the script is executable
    # 确保脚本可执行
    chmod +x /root/add_ssh_ips.sh

    # Create the systemd service file
    # 创建 systemd service 文件
    cat <<EOF > /etc/systemd/system/add_ssh_ips.service
[Unit]
Description=Add SSH IP rules using ipset and iptables
# 使用 ipset 和 iptables 添加 SSH IP 规则
After=network.target

[Service]
ExecStart=/root/add_ssh_ips.sh

[Install]
WantedBy=multi-user.target
EOF

    # Reload systemd configuration and enable the service
    # 重新加载 systemd 配置并启用服务
    systemctl daemon-reload
    systemctl enable add_ssh_ips.service
    systemctl start add_ssh_ips.service

    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${GREEN}当前${YELLOW} SSH ${NC}防火墙规则已被创建并成功启用${NC}】"
    else
        echo -e "【${GREEN}SSH ${YELLOW}Firewall rules have been successfully created and activated${NC}】"
    fi

    show_ipset   # Display IPSET addresses
    # 显示 IPSET 地址
}

# Modify existing SSH firewall rules
# 修改现有 SSH 防火墙规则
modify_existing_rules() {
    if [ "$LANGUAGE" = "CN" ]; then
        show_progress "【${BLUE}修改现有${YELLOW} SSH ${BLUE}防火墙规则${NC}】"
    else
        show_progress "【${BLUE}Modifying Existing${YELLOW} SSH ${BLUE}Firewall Rules${NC}】"
    fi

    if [ -f "/root/add_ssh_ips.sh" ]; then
        # Extract line numbers related to IP addresses
        # 提取IP地址相关的行号
        ip_lines=$(grep -nE "^\s*ipset add allowed_ssh_ips" /root/add_ssh_ips.sh | cut -d: -f1)

        if [[ -z "$ip_lines" ]]; then
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${RED}无法找到脚本中的${YELLOW} IP ${RED}设置部分${NC}】【${RED}即将打开脚本供手动修改${NC}】"
                read -p "【按任意键继续】" -n 1
            else
                echo -e "【${RED}Unable to find${YELLOW} IP ${RED}settings in the script${NC}】【${RED}Opening script for manual modification${NC}】"
                read -p "【Press any key to continue】" -n 1
            fi
            nano /root/add_ssh_ips.sh
        else
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${BLUE}脚本中的${YELLOW} IP ${NC}地址配置位于以下行${NC}】"
                echo "$ip_lines"
                echo -e "【${RED}将自动定位到第一个${YELLOW} IP ${RED}地址所在的行${NC}】"
                read -p "【按任意键继续编辑脚本】" -n 1
            else
                echo -e "【${BLUE}IP address settings in the script are located at the following lines${NC}】"
                echo "$ip_lines"
                echo -e "【${RED}Auto-positioning to the first line with an${YELLOW} IP ${RED}address${NC}】"
                read -p "【Press any key to continue editing the script】" -n 1
            fi

            # Open the file and jump to the first IP address line
            # 打开文件并定位到第一个IP地址的行
            nano +$(echo "$ip_lines" | head -n 1) /root/add_ssh_ips.sh
        fi

        # Make the script executable
        # 赋予脚本执行权限
        chmod +x /root/add_ssh_ips.sh
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}已赋予脚本执行权限${NC}】"
        else
            echo -e "【${GREEN}Script execution permissions granted${NC}】"
        fi

        # Reapply the rules
        # 重新应用规则
        systemctl restart add_ssh_ips.service
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}当前${YELLOW} SSH ${GREEN}防火墙规则已被修改并成功重新应用${NC}】"
        else
            echo -e "【${GREEN}SSH ${YELLOW}Firewall rules have been modified and successfully reapplied${NC}】"
        fi
        show_ipset   # Display IPSET addresses
        # 显示 IPSET 地址

    else
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}无法找到现有规则文件${NC}】【${RED}无法修改${NC}】"
        else
            echo -e "【${RED}Existing rules file not found${NC}】【${RED}Unable to modify${NC}】"
        fi
    fi
}

# Update script function
# 更新脚本函数
update_script() {
    if [ "$LANGUAGE" = "CN" ]; then
        show_progress "【${GREEN}更新脚本${NC}】"
    else
        show_progress "【${GREEN}Updating Script${NC}】"
    fi

    # Step 1: Download the remote script to a temporary file
    # 第一步：下载远程脚本到临时文件
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${RED}正在从远程${YELLOW} URL ${RED}检测最新版本的脚本${NC}】【${YELLOW}已下载远程脚本到临时文件${NC}】"
    else
        echo -e "【${RED}Checking the latest version of the script from the remote${YELLOW} URL ${RED}${NC}】【${YELLOW}Downloaded the remote script to a temporary file${NC}】"
    fi
    curl -o "/tmp/temp_script.sh" "$REMOTE_SCRIPT_URL"

    # Step 2: Compare the temporary file with the current script
    # 第二步：比对临时文件和当前脚本
    if cmp -s "/tmp/temp_script.sh" "$SCRIPT_PATH"; then
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}脚本已经是最新版本${NC}】【${GREEN}无需更新${NC}】"
            echo -e "【${YELLOW}临时文件已删除${NC}】"
        else
            echo -e "【${GREEN}The script is already up-to-date${NC}】【${GREEN}No update needed${NC}】"
            echo -e "【${YELLOW}Temporary file deleted${NC}】"
        fi
        rm -f "/tmp/temp_script.sh"  # Delete the temporary file
        # 删除临时文件
    else
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${YELLOW}检测到脚本有更新内容${NC}】【${YELLOW}是否更新${NC}】"
        else
            echo -e "【${YELLOW}Script updates detected${NC}】【${YELLOW}Would you like to update?${NC}】"
        fi
        read -p "$(if [ "$LANGUAGE" = "CN" ]; then echo -e "【${GREEN}请输入${RED} Y/N ${GREEN}回车确认${NC}】"; else echo -e "【${GREEN}Enter${RED} Y/N ${GREEN}to confirm${NC}】"; fi)" update_choice
        case $update_choice in
            y|Y)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${RED}正在更新脚本${NC}】"
                else
                    echo -e "【${RED}Updating script${NC}】"
                fi
                # Download and update the script using curl
                # 使用 curl 直接下载并更新脚本
                curl -O "$REMOTE_SCRIPT_URL" && \
                chmod +x ./system_tools.sh && \
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${GREEN}脚本已成功更新${NC}】【${YELLOW}正在重新启动${NC}】"
                else
                    echo -e "【${GREEN}Script updated successfully${NC}】【${YELLOW}Restarting${NC}】"
                fi && \
                ./system_tools.sh  # Restart the script
                # 重新启动脚本
                exit 0
                ;;
            n|N)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${RED}脚本更新已取消${NC}】"
                else
                    echo -e "【${RED}Script update canceled${NC}】"
                fi
                ;;
            *)
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${RED}无效选择${NC}】【${RED}脚本更新已取消${NC}】"
                else
                    echo -e "【${RED}Invalid selection${NC}】【${RED}Script update canceled${NC}】"
                fi
                ;;
        esac
        rm -f "/tmp/temp_script.sh"  # Delete the temporary file
        # 删除临时文件
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${YELLOW}临时文件已删除${NC}】"
        else
            echo -e "【${YELLOW}Temporary file deleted${NC}】"
        fi
    fi
}

# View change log function
# 查看更新日志函数
view_change_log() {
    # Display progress message based on language
    # 根据语言显示进度信息
    if [ "$LANGUAGE" = "CN" ]; then
        show_progress "【${YELLOW}查看更新日志${NC}】"
    else
        show_progress "【${YELLOW}Viewing Change Log${NC}】"
    fi

    # Displaying message for fetching the changelog
    # 显示获取更新日志的消息
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${RED}正在从远程${YELLOW} URL ${RED}获取更新日志${NC}】"
    else
        echo -e "【${RED}Fetching change log from remote${YELLOW} URL ${RED}${NC}】"
    fi

    # Determine the appropriate URL based on language
    # 根据语言选择相应的 URL
    if [ "$LANGUAGE" = "CN" ]; then
        URL_TO_FETCH="$CHANGE_LOG_ZH_CN_URL"
    else
        URL_TO_FETCH="$CHANGE_LOG_URL"
    fi

    # Fetch the change log with forced cache refresh using curl
    # 使用 curl 强制刷新缓存并获取更新日志
    curl -s -H "Cache-Control: no-cache" "$URL_TO_FETCH" | while IFS= read -r line; do
        echo "$line"
    done

    # Prompt user to press enter after reading
    # 提示用户按下回车键确认已阅读
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${GREEN}请按下回车确认已经完成阅读${NC}】"
    else
        echo -e "【${GREEN}Press enter to confirm you have finished reading${NC}】"
    fi
    read
}

# Display IPSET addresses
# 显示 IPSET 地址
show_ipset() {
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${BLUE}当前系统防火墙通过${YELLOW} IPSET ${BLUE}工具放行的${YELLOW} IP ${BLUE}地址${NC}】"
    else
        echo -e "【${BLUE}IP addresses allowed by firewall via ${YELLOW}IPSET ${BLUE}in the system${NC}】"
    fi

    # Handling IPv4 addresses
    # 处理 IPv4 地址
    ipset list allowed_ssh_ips 2>/dev/null | awk -v green="$GREEN" -v yellow="$YELLOW" -v reset="$NC" '
    BEGIN {in_list=0}
    /Name:/ || /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {
        if ($0 ~ /Name:/) {
            print yellow $0 reset;
        } else if (in_list && $0 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) {
            gsub(/([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/, green "&" reset);
            print;
        }
    }
    /Members:/ {in_list=1; next}
    '

    # Handling IPv6 addresses
    # 处理 IPv6 地址
    ipset list allowed_ssh_ipv6_ips 2>/dev/null | awk -v green="$GREEN" -v yellow="$YELLOW" -v reset="$NC" '
    BEGIN {in_list=0}
    /Name:/ || /^[0-9a-fA-F:]+$/ {
        if ($0 ~ /Name:/) {
            print yellow $0 reset;
        } else if (in_list && $0 ~ /^[0-9a-fA-F:]+$/) {
            gsub(/([0-9a-fA-F:]+)/, green "&" reset);
            print;
        }
    }
    /Members:/ {in_list=1; next}
    '
}

# Handle script exit
# 处理退出脚本
exit_script() {
    clear
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${RED}系统工具合集脚本${NC}】【${GREEN}已成功退出${NC}】"
    else
        echo -e "【${RED}System Tools Collection Script${NC}】【${GREEN}Exited Successfully${NC}】"
    fi
    exit 0
}

# Path to the configuration file where user settings are stored
# 配置文件的路径，用于存储用户设置
CONFIG_FILE="$HOME/.script_config"

# Load or initialize configuration
# 加载或初始化配置
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
    else
        first_run
    fi
}

# Function to handle first run and language selection
# 处理首次运行和语言选择的函数
first_run() {
    echo -e "【${BLUE}First time running${NC}】【${BLUE}please select a language${NC}】 / 【${BLUE}首次运行${NC}】【${BLUE}请选择语言${NC}】"
    echo -e "【${BLUE}1${NC}】【${YELLOW}English${NC}】"
    echo -e "【${BLUE}2${NC}】【${YELLOW}中文${NC}】"
    read -p "$(echo -e "【${RED}Enter choice${NC}】 / 【${RED}输入选项${NC}】")" lang_choice
    case $lang_choice in
        1)
            LANGUAGE="EN"
            echo "LANGUAGE='EN'" > "$CONFIG_FILE"
            echo -e "【${GREEN}Language set to English${NC}】 / 【${GREEN}语言已设置为英文${NC}】"
            ;;
        2)
            LANGUAGE="CN"
            echo "LANGUAGE='CN'" > "$CONFIG_FILE"
            echo -e "【${GREEN}语言已设置为中文${NC}】 / 【${GREEN}Language set to Chinese${NC}】"
            ;;
        *)
            echo -e "【${RED}Invalid option${NC}】 / 【${RED}无效选项${NC}】"
            first_run
            ;;
    esac
}

# Load or initialize configuration
# 加载或初始化配置
load_config

# Display Docker IPv4 IPSET addresses
# 显示 Docker IPv4 IPSET 地址
show_docker_ipv4_ipset() {
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${BLUE}当前系统防火墙通过${YELLOW} IPSET ${BLUE}工具放行的${YELLOW} IPv4 ${BLUE}地址${NC}】"
    else
        echo -e "【${BLUE}IPv4 addresses allowed by firewall via ${YELLOW}IPSET ${BLUE}in the system${NC}】"
    fi

    # Handling IPv4 addresses
    # 处理 IPv4 地址
    ipset list allowed_ipv4_ips 2>/dev/null | awk -v green="$GREEN" -v yellow="$YELLOW" -v reset="$NC" '
    BEGIN {in_list=0}
    /Name:/ || /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {
        if ($0 ~ /Name:/) {
            print yellow $0 reset;
        } else if (in_list && $0 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) {
            gsub(/([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/, green "&" reset);
            print;
        }
    }
    /Members:/ {in_list=1; next}
    '
}

# Display Docker IPv4 and IPv6 IPSET addresses
# 显示 Docker IPv4 和 IPv6 IPSET 地址
show_docker_ipv4_ipv6_ipset() {
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${BLUE}当前系统防火墙通过${YELLOW} IPSET ${BLUE}工具放行的${YELLOW} IPv4 和 IPv6 ${BLUE}地址${NC}】"
    else
        echo -e "【${BLUE}IPv4 and IPv6 addresses allowed by firewall via ${YELLOW}IPSET ${BLUE}in the system${NC}】"
    fi

    # Handling IPv4 addresses
    # 处理 IPv4 地址
    ipset list allowed_ips 2>/dev/null | awk -v green="$GREEN" -v yellow="$YELLOW" -v reset="$NC" '
    BEGIN {in_list=0}
    /Name:/ || /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {
        if ($0 ~ /Name:/) {
            print yellow $0 reset;
        } else if (in_list && $0 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) {
            gsub(/([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/, green "&" reset);
            print;
        }
    }
    /Members:/ {in_list=1; next}
    '

    # Handling IPv6 addresses
    # 处理 IPv6 地址
    ipset list allowed_ipv6_ips 2>/dev/null | awk -v green="$GREEN" -v yellow="$YELLOW" -v reset="$NC" '
    BEGIN {in_list=0}
    /Name:/ || /^[0-9a-fA-F:]+$/ {
        if ($0 ~ /Name:/) {
            print yellow $0 reset;
        } else if (in_list && $0 ~ /^[0-9a-fA-F:]+$/) {
            gsub(/([0-9a-fA-F:]+)/, green "&" reset);
            print;
        }
    }
    /Members:/ {in_list=1; next}
    '

    # Handling Nezha IPv4 addresses (if applicable)
    # 处理 Nezha IPv4 地址（如果适用）
    if ipset list allowed_nezha_ips 2>/dev/null > /dev/null; then
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${BLUE}当前系统防火墙通过${YELLOW} IPSET ${BLUE}工具放行的${YELLOW} Nezha IPv4 ${BLUE}地址${NC}】"
        else
            echo -e "【${BLUE}IPv4 addresses for Nezha allowed by firewall via ${YELLOW}IPSET ${BLUE}in the system${NC}】"
        fi
        ipset list allowed_nezha_ips 2>/dev/null | awk -v green="$GREEN" -v yellow="$YELLOW" -v reset="$NC" '
        BEGIN {in_list=0}
        /Name:/ || /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/ {
            if ($0 ~ /Name:/) {
                print yellow $0 reset;
            } else if (in_list && $0 ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) {
                gsub(/([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)/, green "&" reset);
                print;
            }
        }
        /Members:/ {in_list=1; next}
        '
    fi

    # Handling Nezha IPv6 addresses (if applicable)
    # 处理 Nezha IPv6 地址（如果适用）
    if ipset list allowed_nezha_ipv6_ips 2>/dev/null > /dev/null; then
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${BLUE}当前系统防火墙通过${YELLOW} IPSET ${BLUE}工具放行的${YELLOW} Nezha IPv6 ${BLUE}地址${NC}】"
        else
            echo -e "【${BLUE}IPv6 addresses for Nezha allowed by firewall via ${YELLOW}IPSET ${BLUE}in the system${NC}】"
        fi
        ipset list allowed_nezha_ipv6_ips 2>/dev/null | awk -v green="$GREEN" -v yellow="$YELLOW" -v reset="$NC" '
        BEGIN {in_list=0}
        /Name:/ || /^[0-9a-fA-F:]+$/ {
            if ($0 ~ /Name:/) {
                print yellow $0 reset;
            } else if (in_list && $0 ~ /^[0-9a-fA-F:]+$/) {
                gsub(/([0-9a-fA-F:]+)/, green "&" reset);
                print;
            }
        }
        /Members:/ {in_list=1; next}
        '
    fi
}

# Check if Docker is installed
# 检查是否已安装 Docker
check_docker_installed() {
    if ! command -v docker &> /dev/null; then
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}当前系统 ${YELLOW}Docker ${RED}未安装${NC}】【${RED}无法管理防火墙规则${NC}】"
            echo -e "【${YELLOW}返回主菜单${NC}】"
        else
            echo -e "【${RED}Docker is not installed on this system${NC}】【${RED}Cannot manage firewall rules${NC}】"
            echo -e "【${YELLOW}Returning to main menu${NC}】"
        fi
        return 1
    else
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}当前系统已经安装 Docker${NC}】"
            echo -e "【${YELLOW}请选择需要管理的 Docker 网络类型${NC}】\n【${BLUE}1${NC}】 ${BLUE}所选 Docker 网络仅支持IPv4${NC}\n【${BLUE}2${NC}】 ${BLUE}所选 Docker 网络同时支持IPv4和IPv6${NC}"
            read -p "【请输入选项】" network_choice
        else
            echo -e "【${GREEN}Docker is already installed on this system${NC}】"
            echo -e "【${YELLOW}Please select Docker network configuration${NC}】\n【${BLUE}1${NC}】 ${BLUE}The selected Docker network supports IPv4 only${NC}\n【${BLUE}2${NC}】 ${BLUE}The selected Docker network supports both IPv4 and IPv6${NC}"
            read -p "【Enter your choice】" network_choice
        fi

        # Check if network_choice is valid
		# 检查network_choice是否有效
        if [[ "$network_choice" != "1" && "$network_choice" != "2" ]]; then
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${RED}无效选项${NC}】【${YELLOW}返回主菜单${NC}】"
            else
                echo -e "【${RED}Invalid option${NC}】【${YELLOW}Returning to main menu${NC}】"
            fi
            return 1
        fi

        # Determine which configuration file to check
        # 确定要检测的配置文件
        if [[ "$network_choice" == "1" ]]; then
            config_file="/root/add_ipv4_ips.sh"
        else
            config_file="/root/add_ips.sh"
        fi

        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${YELLOW}是否已经配置 Docker 防火墙规则${NC}】\n【${BLUE}1${NC}】 ${BLUE}是${NC}\n【${BLUE}2${NC}】 ${BLUE}否${NC}"
            read -p "【请输入选项】" docker_choice
        else
            echo -e "【${YELLOW}Have Docker firewall rules been configured${NC}】\n【${BLUE}1${NC}】 ${BLUE}Yes${NC}\n【${BLUE}2${NC}】 ${BLUE}No${NC}"
            read -p "【Enter your choice】" docker_choice
        fi

        if [[ "$docker_choice" == "1" ]]; then
            manage_docker_firewall
        elif [[ "$docker_choice" == "2" ]]; then
            # Check if the configuration file exists
            # 检查配置文件是否存在
            if [ -f "$config_file" ]; then
                if [ "$LANGUAGE" = "CN" ]; then
                    echo -e "【${YELLOW}检测到配置文件已存在${NC}】\n【${BLUE}1${NC}】 ${BLUE}管理配置文件${NC}\n【${BLUE}2${NC}】 ${BLUE}返回主菜单${NC}"
                    read -p "【请输入选项】" modify_choice
                else
                    echo -e "【${YELLOW}Configuration file already exists${NC}】\n【${BLUE}1${NC}】 ${BLUE}Modify configuration file${NC}\n【${BLUE}2${NC}】 ${BLUE}Return to main menu${NC}"
                    read -p "【Enter your choice】" modify_choice
                fi

                if [[ "$modify_choice" == "1" ]]; then
                    manage_docker_firewall
                else
                    return 0
                fi
            else
                if [ "$LANGUAGE" = "CN" ]; then
                    read -p "配置文件不存在，是否创建配置文件？(y/n): " create_choice
                else
                    read -p "Configuration file does not exist. Do you want to create it? (y/n): " create_choice
                fi

                if [[ "$create_choice" == "y" || "$create_choice" == "Y" ]]; then
                    create_docker_rules
                else
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${YELLOW}已选择不创建配置文件${NC}】"
                    else
                        echo -e "【${YELLOW}Chose not to create the configuration file${NC}】"
                    fi
                fi
            fi
        else
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${RED}无效选项${NC}】【${YELLOW}返回主菜单${NC}】"
            else
                echo -e "【${RED}Invalid option${NC}】【${YELLOW}Returning to main menu${NC}】"
            fi
            return 1
        fi
    fi
}

# Manage Docker firewall rules
# 管理 Docker 防火墙规则
manage_docker_firewall() {
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${YELLOW}请选择操作${NC}】\n【${BLUE}1${NC}】 ${BLUE}查看现有规则${NC}\n【${BLUE}2${NC}】 ${BLUE}修改现有规则${NC}"
        read -p "请输入选项：" modify_choice
    else
        echo -e "【${YELLOW}Select an operation${NC}】\n【${BLUE}1${NC}】 ${BLUE}View existing rules${NC}\n【${BLUE}2${NC}】 ${BLUE}Modify existing rules${NC}"
        read -p "Enter your choice：" modify_choice
    fi

    case $modify_choice in
        1)
            case $network_choice in
                1)
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}查看 IPv4 防火墙规则${NC}】"
                    else
                        echo -e "【${BLUE}Viewing IPv4 firewall rules${NC}】"
                    fi
                    iptables -L DOCKER-USER -n --line-numbers | output_command
                    show_docker_ipv4_ipset
                    ;;
                2)
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${BLUE}查看 IPv4 和 IPv6 防火墙规则${NC}】"
                    else
                        echo -e "【${BLUE}Viewing IPv4 and IPv6 firewall rules${NC}】"
                    fi
                    iptables -L DOCKER-USER -n --line-numbers | output_command
                    ip6tables -L DOCKER-USER -n --line-numbers | output_command
                    show_docker_ipv4_ipv6_ipset
                    ;;
            esac
            ;;
        2)
            case $network_choice in
                1)
                    if [ -f "/root/add_ipv4_ips.sh" ] && [ -f "/etc/systemd/system/add_ipv4_ips.service" ]; then
                        if [ "$LANGUAGE" = "CN" ]; then
                            echo -e "【${GREEN}已找到 IPv4 规则文件${NC}】"
                            read -p "是否要修改现有规则文件？【1】 是 【2】 否：" modify_choice
                        else
                            echo -e "【${GREEN}IPv4 rule file found${NC}】"
                            read -p "Do you want to modify the existing rules file? 【1】 Yes 【2】 No：" modify_choice
                        fi

                        if [[ "$modify_choice" == "1" ]]; then
                            modify_docker_ipv4_rules
                        else
                            if [ "$LANGUAGE" = "CN" ]; then
                                echo -e "【${YELLOW}已选择不修改现有规则文件${NC}】"
                            else
                                echo -e "【${YELLOW}Chose not to modify the existing rules file${NC}】"
                            fi
                        fi
                    else
                        if [ "$LANGUAGE" = "CN" ]; then
                            echo -e "【${RED}未检测到 IPv4 规则文件或服务${NC}】"
                            read -p "是否创建新的规则文件？【1】 是 【2】 否：" create_choice
                        else
                            echo -e "【${RED}IPv4 rule file or service not detected${NC}】"
                            read -p "Do you want to create a new rules file? 【1】 Yes 【2】 No：" create_choice
                        fi

                        if [[ "$create_choice" == "1" ]]; then
                            if [ "$LANGUAGE" = "CN" ]; then
                                echo -e "【${RED}开始创建新的 IPv4 规则文件${NC}】"
                            else
                                echo -e "【${RED}Starting creation of new IPv4 rule file${NC}】"
                            fi
                            create_docker_rules
                        else
                            if [ "$LANGUAGE" = "CN" ]; then
                                echo -e "【${YELLOW}已选择不创建新的规则文件${NC}】"
                            else
                                echo -e "【${YELLOW}Chose not to create a new rules file${NC}】"
                            fi
                        fi
                    fi
                    ;;
                2)
                    if [ -f "/root/add_ips.sh" ] && [ -f "/etc/systemd/system/add_ips.service" ]; then
                        if [ "$LANGUAGE" = "CN" ]; then
                            echo -e "【${GREEN}已找到 IPv4 和 IPv6 规则文件${NC}】"
                            read -p "是否要修改现有规则文件？【1】 是 【2】 否：" modify_choice
                        else
                            echo -e "【${GREEN}IPv4 and IPv6 rule file found${NC}】"
                            read -p "Do you want to modify the existing rules file? 【1】 Yes 【2】 No：" modify_choice
                        fi

                        if [[ "$modify_choice" == "1" ]]; then
                            modify_docker_ipv6_rules
                        else
                            if [ "$LANGUAGE" = "CN" ]; then
                                echo -e "【${YELLOW}已选择不修改现有规则文件${NC}】"
                            else
                                echo -e "【${YELLOW}Chose not to modify the existing rules file${NC}】"
                            fi
                        fi
                    else
                        if [ "$LANGUAGE" = "CN" ]; then
                            echo -e "【${RED}未检测到 IPv4 和 IPv6 规则文件或服务${NC}】"
                            read -p "是否创建新的规则文件？【1】 是 【2】 否：" create_choice
                        else
                            echo -e "【${RED}IPv4 and IPv6 rule file or service not detected${NC}】"
                            read -p "Do you want to create a new rules file? 【1】 Yes 【2】 No：" create_choice
                        fi

                        if [[ "$create_choice" == "1" ]]; then
                            if [ "$LANGUAGE" = "CN" ]; then
                                echo -e "【${RED}开始创建新的 IPv4 和 IPv6 规则文件${NC}】"
                            else
                                echo -e "【${RED}Starting creation of new IPv4 and IPv6 rule files${NC}】"
                            fi
                            create_docker_rules
                        else
                            if [ "$LANGUAGE" = "CN" ]; then
                                echo -e "【${YELLOW}已选择不创建新的规则文件${NC}】"
                            else
                                echo -e "【${YELLOW}Chose not to create a new rules file${NC}】"
                            fi
                        fi
                    fi
                    ;;
            esac
            ;;
        *)
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${RED}无效选项${NC}】【${YELLOW}返回主菜单${NC}】"
            else
                echo -e "【${RED}Invalid option${NC}】【${YELLOW}Returning to main menu${NC}】"
            fi
            ;;
    esac
}

# Modify Docker IPv4 firewall rules
# 修改 Docker IPv4 防火墙规则
modify_docker_ipv4_rules() {
    local script_path="/root/add_ipv4_ips.sh"
    local service_name="add_ipv4_ips.service"
    local show_ipset_function="show_docker_ipv4_ipset"

    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${BLUE}修改${YELLOW} Docker ${BLUE}IPv4 ${YELLOW}防火墙规则${NC}】"
    else
        echo -e "【${BLUE}Modifying${YELLOW} Docker ${BLUE}IPv4 ${YELLOW}Firewall Rules${NC}】"
    fi

    if [ -f "$script_path" ]; then
        # Open the script for manual modification
        # 打开脚本供手动修改
        nano $script_path

        # Make the script executable
        # 赋予脚本执行权限
        chmod +x $script_path
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}已赋予脚本执行权限${NC}】"
        else
            echo -e "【${GREEN}Script execution permissions granted${NC}】"
        fi

        # Reapply the rules
        # 重新应用规则
        systemctl restart $service_name
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}当前${YELLOW} Docker ${GREEN}IPv4 ${YELLOW}防火墙规则已被修改并成功重新应用${NC}】"
        else
            echo -e "【${GREEN}Docker ${YELLOW}IPv4 ${GREEN}Firewall rules have been modified and successfully reapplied${NC}】"
        fi

        # Display IPSET addresses
        # 显示 IPSET 地址
        $show_ipset_function
    else
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}无法找到 IPv4 规则文件${NC}】【${RED}无法修改${NC}】"
        else
            echo -e "【${RED}IPv4 rules file not found${NC}】【${RED}Unable to modify${NC}】"
        fi
    fi

    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${GREEN}IPv4 规则已更新${NC}】"
    else
        echo -e "【${GREEN}IPv4 rules have been updated${NC}】"
    fi
}

# Modify Docker IPv6 firewall rules
# 修改 Docker IPv6 防火墙规则
modify_docker_ipv6_rules() {
    local script_path="/root/add_ips.sh"
    local service_name="add_ips.service"
    local show_ipset_function="show_docker_ipv4_ipv6_ipset"

    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${BLUE}修改${YELLOW} Docker ${BLUE}IPv4_IPv6 ${YELLOW}防火墙规则${NC}】"
    else
        echo -e "【${BLUE}Modifying${YELLOW} Docker ${BLUE}IPv6 ${YELLOW}Firewall Rules${NC}】"
    fi

    if [ -f "$script_path" ]; then
        # Open the script for manual modification
        # 打开脚本供手动修改
        nano $script_path

        # Make the script executable
        # 赋予脚本执行权限
        chmod +x $script_path
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}已赋予脚本执行权限${NC}】"
        else
            echo -e "【${GREEN}Script execution permissions granted${NC}】"
        fi

        # Reapply the rules
        # 重新应用规则
        systemctl restart $service_name
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}当前${YELLOW} Docker ${GREEN}IPv4_IPv6 ${YELLOW}防火墙规则已被修改并成功重新应用${NC}】"
        else
            echo -e "【${GREEN}Docker ${YELLOW}IPv6 ${GREEN}Firewall rules have been modified and successfully reapplied${NC}】"
        fi

        # Display IPSET addresses
        # 显示 IPSET 地址
        $show_ipset_function
    else
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}无法找到 IPv6 规则文件${NC}】【${RED}无法修改${NC}】"
        else
            echo -e "【${RED}IPv6 rules file not found${NC}】【${RED}Unable to modify${NC}】"
        fi
    fi

    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${GREEN}IPv4_IPv6 规则已更新${NC}】"
    else
        echo -e "【${GREEN}IPv6 rules have been updated${NC}】"
    fi
}

# Create Docker firewall rules
# 创建 Docker 防火墙规则
create_docker_rules() {
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${YELLOW}创建 Docker 防火墙规则${NC}】"
    else
        echo -e "【${YELLOW}Creating Docker firewall rules${NC}】"
    fi

    # Choose to execute different scripts based on network configuration
    # 根据网络配置选择执行不同的脚本
    if [[ $network_choice == "1" ]]; then
        create_ipv4_only_rules
    elif [[ $network_choice == "2" ]]; then
        create_dual_stack_rules
    fi
}

# Create an IPv4-only Docker firewall rule
# 创建仅支持 IPv4 的 Docker 防火墙规则
create_ipv4_only_rules() {
    # Display a message indicating the creation of the /root/add_ipv4_ips.sh file and startup service
    # 显示创建 /root/add_ipv4_ips.sh 文件及开机自启动服务的提示信息
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${YELLOW}正在创建 ${GREEN}/root/add_ipv4_ips.sh ${YELLOW}配置文件及开机自启动服务文件${NC}】"
    else
        echo -e "【${YELLOW}Creating ${GREEN}/root/add_ipv4_ips.sh ${YELLOW}configuration file and startup service file${NC}】"
    fi

    # Check and install ipset
    # 检查并安装ipset
    if ! command -v ipset &> /dev/null; then
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}检测出${YELLOW} ipset ${NC}未安装${NC}】【${RED}已经开始部署${NC}】"
        else
            echo -e "【${RED}Detected${YELLOW} ipset ${NC}is not installed${NC}】【${RED}Starting installation${NC}】"
        fi
        apt-get update && apt-get install -y ipset
    else
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}发现当前${YELLOW} ipset ${GREEN}已存在${NC}】【已经跳过安装${NC}】"
        else
            echo -e "【${GREEN}Found existing${YELLOW} ipset ${GREEN}installed${NC}】【Skipping installation${NC}】"
        fi
    fi

    # Create the add_ipv4_ips.sh script
    # 创建 add_ipv4_ips.sh 脚本
    cat <<EOF > /root/add_ipv4_ips.sh
#!/bin/bash

# Get the IPv4 address of the container
# 获取容器的 IPv4 地址
get_container_ip() {
    local container_name=\$1
    docker inspect "\$container_name" | jq -r '.[0].NetworkSettings.Networks | to_entries | .[0].value.IPAddress'
}

# Get the host port mapped to the container
# 获取容器映射到宿主机的端口
get_host_port() {
    local container_name=\$1
    local container_port=\$2
    docker inspect "\$container_name" | jq -r --arg port "\$container_port/tcp" '.[0].NetworkSettings.Ports[$port][0].HostPort'
}

# Maximum wait time is 240 seconds, check every 1 second
# 最大等待时间为 240 秒，每 1 秒检查一次
MAX_WAIT=240
INTERVAL=1
TIME_WAITED=0

# Define container names and port mappings
# 定义容器名称和端口映射
declare -A CONTAINERS
CONTAINERS=(
    ["tools-80"]="80"
    # Add more containers and ports
    # 添加更多容器和端口
)

# Create ipset address set (if it doesn't exist)
# 创建 ipset 地址合集（如果不存在）
ipset list allowed_ipv4_ips &> /dev/null || ipset create allowed_ipv4_ips hash:ip

# Manually add IP addresses to the ipset set (if not already present)
# 手动添加 IP 地址到 ipset 合集（如果未存在）
ipset add allowed_ipv4_ips IP addresses 2>/dev/null || true

# Wait for the iptables DOCKER-USER chain to be available
# 等待 iptables DOCKER-USER 链可用
while [ \$TIME_WAITED -lt \$MAX_WAIT ]; do
    if iptables -L DOCKER-USER &> /dev/null; then
        for key in "\${!CONTAINERS[@]}"; do
            # Separate container name and port
            # 分离容器名称和端口
            container_name=\$(echo \$key | sed 's/-[0-9]*$//')
            container_port=\${CONTAINERS[\$key]}

            # Get the container's IPv4 address
            # 获取容器的 IPv4 地址
            CONTAINER_IP=\$(get_container_ip "\$container_name")

            # Skip containers that cannot get an IP address
            # 跳过无法获取 IP 地址的容器
            [ -z "\$CONTAINER_IP" ] && continue

            # Get the host port mapped to the container
            # 获取容器映射到宿主机的端口
            HOST_PORT=\$(get_host_port "\$container_name" "\$container_port")

            # Skip containers that cannot get the host port
            # 跳过无法获取宿主机端口的容器
            [ -z "\$HOST_PORT" ] && continue

            # Generate unquoted comment
            # 生成不带引号的注释
            COMMENT_ESCAPED="Svc:\${container_name}_Port:\${HOST_PORT}"

            # Generate iptables rules
            # 生成 iptables 规则
            ACCEPT_RULE="-m set --match-set allowed_ipv4_ips src -d \$CONTAINER_IP -p tcp --dport \$container_port -m comment --comment \$COMMENT_ESCAPED -j ACCEPT"
            DROP_RULE="-d \$CONTAINER_IP -p tcp --dport \$container_port -m comment --comment \$COMMENT_ESCAPED -j DROP"

            # Remove existing duplicate rules
            # 删除现有的重复规则
            while iptables -D DOCKER-USER \$ACCEPT_RULE &> /dev/null; do :; done
            while iptables -D DOCKER-USER \$DROP_RULE &> /dev/null; do :; done

            # Insert DROP rule first, then insert ACCEPT rule
            # 先插入 DROP 规则，然后插入 ACCEPT 规则
            iptables -I DOCKER-USER \$DROP_RULE
            iptables -I DOCKER-USER \$ACCEPT_RULE
        done

        # Display success message
        # 提示成功消息
        echo -e "${GREEN}iptables rules have been successfully set${NC}"
        exit 0
    fi
    sleep \$INTERVAL
    TIME_WAITED=\$((TIME_WAITED + INTERVAL))
done

# Display timeout message
# 提示超时消息
echo -e "${RED}Timeout waiting for iptables DOCKER-USER chain${NC}"

exit 1

EOF

    chmod +x /root/add_ipv4_ips.sh

    # Create a systemd service to run scripts on startup
    # 创建 systemd 服务以在启动时运行脚本
    cat <<EOF > /etc/systemd/system/add_ipv4_ips.service
[Unit]
Description=Add IP addresses to ipset for Docker containers
After=docker.service

[Service]
ExecStart=/bin/bash /root/add_ipv4_ips.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable add_ipv4_ips.service
    systemctl start add_ipv4_ips.service
	
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${GREEN}Docker 防火墙规则已成功创建并启用${NC}】【${YELLOW}请确保根据需求修改 /root/add_ipv4_ips.sh 文件关键信息${NC}】"
    else
        echo -e "【${GREEN}Docker firewall rules have been successfully created and enabled${NC}】【${YELLOW}Please ensure to modify the key information in the /root/add_ipv4_ips.sh file as needed${NC}】"
    fi
	
    # Display IPSET addresses
    # 显示 IPSET 地址
    show_docker_ipv4_ipset
}

# Create Docker firewall rules that support IPv4 and IPv6
# 创建支持 IPv4 和 IPv6 的 Docker 防火墙规则
create_dual_stack_rules() {
    # Display a message indicating the creation of the /root/add_ips.sh file and startup service
    # 显示创建 /root/add_ips.sh 文件及开机自启动服务的提示信息
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${YELLOW}正在创建 ${GREEN}/root/add_ips.sh ${YELLOW}配置文件及开机自启动服务文件${NC}】"
    else
        echo -e "【${YELLOW}Creating ${GREEN}/root/add_ips.sh ${YELLOW}configuration file and startup service file${NC}】"
    fi

    # Check and install ipset
    # 检查并安装ipset
    if ! command -v ipset &> /dev/null; then
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${RED}检测出${YELLOW} ipset ${NC}未安装${NC}】【${RED}已经开始部署${NC}】"
        else
            echo -e "【${RED}Detected${YELLOW} ipset ${NC}is not installed${NC}】【${RED}Starting installation${NC}】"
        fi
        apt-get update && apt-get install -y ipset
    else
        if [ "$LANGUAGE" = "CN" ]; then
            echo -e "【${GREEN}发现当前${YELLOW} ipset ${GREEN}已存在${NC}】【已经跳过安装${NC}】"
        else
            echo -e "【${GREEN}Found existing${YELLOW} ipset ${GREEN}installed${NC}】【Skipping installation${NC}】"
        fi
    fi
	
    # Create the add_ips.sh script
    # 创建 add_ips.sh 脚本
    cat <<EOF > /root/add_ips.sh
#!/bin/bash

# Tip: Modify your network name here
# 提示：请在这里修改您的网络名称
# Change "my-net-ipv6" to your actual Docker network name
# 请将 "my-net-ipv6" 修改为您实际的 Docker 网络名称
NETWORK_NAME="my-net-ipv6"

# Get the IPv4 address of the container
# 获取容器的 IPv4 地址
get_container_ip() {
    local container_name=\$1
    docker inspect \$container_name | jq -r '.[0].NetworkSettings.Networks["\$NETWORK_NAME"].IPAddress'
}

# Get the IPv6 address of the container
# 获取容器的 IPv6 地址
get_container_ipv6() {
    local container_name=\$1
    docker inspect \$container_name | jq -r '.[0].NetworkSettings.Networks["\$NETWORK_NAME"].GlobalIPv6Address'
}

# Get the host port mapped to the container
# 获取容器映射到宿主的端口
get_host_port() {
    local container_name=\$1
    local container_port=\$2
    docker port \$container_name \$container_port | cut -d ':' -f 2
}

# Maximum wait time is 240 seconds, check every 1 second
# 最大等待时间为 240 秒，每 1 秒检查一次
MAX_WAIT=240
INTERVAL=1
TIME_WAITED=0

# Tip: Define container names and ports here
# 提示：请在这里定义容器名称和端口
# Replace with your actual container names and ports
declare -A CONTAINERS
CONTAINERS=(
    ["nextcloud-aio-mastercontainer-8080"]="8080"
    ["dashboard-dashboard-1-5555"]="5555"
    # Add more containers and ports
    # 添加更多容器和端口
)

# Tip: Create your needed ipset address sets here
# 提示：请在这里创建您需要的 ipset 地址合集
# Ensure the ipset address sets meet your security requirements
# 确保以下 ipset 地址合集符合您的安全需求
ipset list allowed_ips &> /dev/null || ipset create allowed_ips hash:ip
ipset list allowed_ipv6_ips &> /dev/null || ipset create allowed_ipv6_ips hash:ip family inet6
ipset list allowed_nezha_ips &> /dev/null || ipset create allowed_nezha_ips hash:ip
ipset list allowed_nezha_ipv6_ips &> /dev/null || ipset create allowed_nezha_ipv6_ips hash:ip family inet6

# Tip: Manually add IP addresses to ipset sets here
# 提示：请在这里手动添加 IP 地址到 ipset 合集
# Replace the IP addresses with those you need
# 将以下 IP 地址修改为您需要的 IP 地址
ipset add allowed_ips IP addresses 2>/dev/null || true
ipset add allowed_ipv6_ips IP addresses 2>/dev/null || true
ipset add allowed_nezha_ips IP addresses 2>/dev/null || true
ipset add allowed_nezha_ipv6_ips IP addresses 2>/dev/null || true

for key in "\${!CONTAINERS[@]}"; do
    # Split container name and port
    # 分离容器名称和端口
    container_name=\$(echo \$key | sed 's/-[0-9]*\$//')
    container_port=\${CONTAINERS[\$key]}
    host_port=\$(get_host_port \$container_name \$container_port)

    # Get container IPv4 and IPv6 addresses
    # 获取容器的 IPv4 和 IPv6 地址
    CONTAINER_IP=\$(get_container_ip \$container_name)
    CONTAINER_IPV6=\$(get_container_ipv6 \$container_name)

    if [ -z "\$CONTAINER_IP" ] || [ -z "\$CONTAINER_IPV6" ]; then
        continue
    fi

    # Generate unquoted comment
    # 生成不带引号的注释
    COMMENT="Svc:\${container_name}_Port:\${host_port}"

    if [[ "\$key" == "nextcloud-aio-mastercontainer-8080" ]]; then
        # Only add DROP rules
        # 仅添加 DROP 规则
        DROP_RULE_IPV4="-d \$CONTAINER_IP -p tcp --dport \$container_port -m comment --comment \$COMMENT -j DROP"
        DROP_RULE_IPV6="-d \$CONTAINER_IPV6 -p tcp --dport \$container_port -m comment --comment \$COMMENT -j DROP"

        # Remove potential duplicate rules
        # 删除可能存在的重复规则
        while iptables -D DOCKER-USER \$DROP_RULE_IPV4 2>/dev/null; do :; done
        while ip6tables -D DOCKER-USER \$DROP_RULE_IPV6 2>/dev/null; do :; done

        iptables -I DOCKER-USER 1 \$DROP_RULE_IPV4
        ip6tables -I DOCKER-USER 1 \$DROP_RULE_IPV6

    else
        if { [[ "$container_name" == "dashboard-dashboard-1" && "$container_port" == "5555" ]] || [[ "$container_name" == "nezha-dashboard" && "$container_port" == "8008" ]]; }; then
            # Define Nezha rules
            # 定义 Nezha 规则
            ACCEPT_RULE_IPV4="-m set --match-set allowed_nezha_ips src -d \$CONTAINER_IP -p tcp --dport \$container_port -m comment --comment \$COMMENT -j ACCEPT"
            DROP_RULE_IPV4="-d \$CONTAINER_IP -p tcp --dport \$container_port -m comment --comment \$COMMENT -j DROP"

            # Remove potential duplicate rules
            # 删除可能存在的重复规则
            while iptables -D DOCKER-USER \$DROP_RULE_IPV4 2>/dev/null; do :; done
            while iptables -D DOCKER-USER \$ACCEPT_RULE_IPV4 2>/dev/null; do :; done

            iptables -I DOCKER-USER 1 \$ACCEPT_RULE_IPV4
            iptables -I DOCKER-USER 2 \$DROP_RULE_IPV4

            ACCEPT_RULE_IPV6="-m set --match-set allowed_nezha_ipv6_ips src -d \$CONTAINER_IPV6 -p tcp --dport \$container_port -m comment --comment \$COMMENT -j ACCEPT"
            DROP_RULE_IPV6="-d \$CONTAINER_IPV6 -p tcp --dport \$container_port -m comment --comment \$COMMENT -j DROP"

            # Remove potential duplicate rules
            # 删除可能存在的重复规则
            while ip6tables -D DOCKER-USER \$DROP_RULE_IPV6 2>/dev/null; do :; done
            while ip6tables -D DOCKER-USER \$ACCEPT_RULE_IPV6 2>/dev/null; do :; done

            ip6tables -I DOCKER-USER 1 \$ACCEPT_RULE_IPV6
            ip6tables -I DOCKER-USER 2 \$DROP_RULE_IPV6

        else
            # Define standard rules
            # 定义常规规则
            ACCEPT_RULE_IPV4="-m set --match-set allowed_ips src -d \$CONTAINER_IP -p tcp --dport \$container_port -m comment --comment \$COMMENT -j ACCEPT"
            DROP_RULE_IPV4="-d \$CONTAINER_IP -p tcp --dport \$container_port -m comment --comment \$COMMENT -j DROP"

            # Remove potential duplicate rules
            # 删除可能存在的重复规则
            while iptables -D DOCKER-USER \$DROP_RULE_IPV4 2>/dev/null; do :; done
            while iptables -D DOCKER-USER \$ACCEPT_RULE_IPV4 2>/dev/null; do :; done

            iptables -I DOCKER-USER 1 \$ACCEPT_RULE_IPV4
            iptables -I DOCKER-USER 2 \$DROP_RULE_IPV4

            ACCEPT_RULE_IPV6="-m set --match-set allowed_ipv6_ips src -d \$CONTAINER_IPV6 -p tcp --dport \$container_port -m comment --comment \$COMMENT -j ACCEPT"
            DROP_RULE_IPV6="-d \$CONTAINER_IPV6 -p tcp --dport \$container_port -m comment --comment \$COMMENT -j DROP"

            # Remove potential duplicate rules
            # 删除可能存在的重复规则
            while ip6tables -D DOCKER-USER \$DROP_RULE_IPV6 2>/dev/null; do :; done
            while ip6tables -D DOCKER-USER \$ACCEPT_RULE_IPV6 2>/dev/null; do :; done

            ip6tables -I DOCKER-USER 1 \$ACCEPT_RULE_IPV6
            ip6tables -I DOCKER-USER 2 \$DROP_RULE_IPV6
        fi
    fi
done

exit 0
EOF

    chmod +x /root/add_ips.sh

    # Create a systemd service to run scripts on startup
    # 创建 systemd 服务以在启动时运行脚本
    cat <<EOF > /etc/systemd/system/add_ips.service
[Unit]
Description=Add IP addresses to ipset for Docker containers
After=docker.service

[Service]
ExecStart=/bin/bash /root/add_ips.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable add_ips.service
    systemctl start add_ips.service
	
    if [ "$LANGUAGE" = "CN" ]; then
        echo -e "【${GREEN}Docker 防火墙规则已成功创建并启用${NC}】【${YELLOW}请确保根据需求修改 /root/add_ips.sh 文件关键信息${NC}】"
    else
        echo -e "【${GREEN}Docker firewall rules have been successfully created and enabled${NC}】【${YELLOW}Please ensure to modify the key information in the /root/add_ips.sh file as needed${NC}】"
    fi
	
    # Display IPSET addresses
    # 显示 IPSET 地址	
    show_docker_ipv4_ipv6_ipset
}

# Main menu cycle
# 主菜单循环
while true; do
    show_menu
    if [ "$LANGUAGE" = "CN" ]; then
        echo -ne "【${BLUE}输入选项编号并按回车确认${NC}】"
    else
        echo -ne "【${BLUE}Enter option number and press Enter to confirm${NC}】"
    fi
    read choice
    case $choice in
        01)
            check_docker_installed
            ;;
        02)
            manage_firewall
            ;;
        03)
            manage_ssh_firewall
            ;;
        04)
            if [ "$LANGUAGE" = "CN" ]; then
                show_progress "【${BLUE}查看${YELLOW} IPv4 Docker ${BLUE}用户链规则${NC}】"
            else
                show_progress "【${BLUE}View${YELLOW} IPv4 Docker ${BLUE}User Chain Rules${NC}】"
            fi
            iptables -L DOCKER-USER -n --line-numbers | output_command
            ;;
        05)
            if [ "$LANGUAGE" = "CN" ]; then
                show_progress "【${BLUE}查看${YELLOW} IPv6 Docker ${BLUE}用户链规则${NC}】"
            else
                show_progress "【${BLUE}View${YELLOW} IPv6 Docker ${BLUE}User Chain Rules${NC}】"
            fi
            ip6tables -L DOCKER-USER -n --line-numbers | output_command
            ;;
        06)
            if [ "$LANGUAGE" = "CN" ]; then
                show_progress "【${BLUE}查看${YELLOW} IPv4 Docker NAT ${BLUE}规则${NC}】"
            else
                show_progress "【${BLUE}View${YELLOW} IPv4 Docker NAT ${BLUE}Rules${NC}】"
            fi
            {
                echo -e "\n===== POSTROUTING 链 ====="
                iptables -t nat -L POSTROUTING -n --line-numbers
                echo -e "\n===== DOCKER 链 ====="
                iptables -t nat -L DOCKER -n --line-numbers
            } | output_command
            ;;
        07)
            if [ "$LANGUAGE" = "CN" ]; then
                show_progress "【${BLUE}查看${YELLOW} IPv6 Docker NAT ${BLUE}规则${NC}】"
            else
                show_progress "【${BLUE}View${YELLOW} IPv6 Docker NAT ${BLUE}Rules${NC}】"
            fi
            {
                echo -e "\n===== POSTROUTING 链 ====="
                ip6tables -t nat -L POSTROUTING -n --line-numbers
                echo -e "\n===== DOCKER 链 ====="
                ip6tables -t nat -L DOCKER -n --line-numbers
            } | output_command
            ;;
        08)
            manage_screen
            ;;
        09)
            show_system_commands
            ;;
        10)
            show_docker_container_info
            ;;		
        18)
            if [ "$LANGUAGE" = "EN" ]; then
                echo -e "【${BLUE}Please select language${NC}】 / 【${BLUE}请选择语言${NC}】"
                echo -e "【${BLUE}1${NC}】【${YELLOW}English${NC}】"
                echo -e "【${BLUE}2${NC}】【${YELLOW}中文${NC}】"
                read -p "$(echo -e "【${RED}Enter choice${NC}】 / 【${RED}输入选项${NC}】")" lang_choice
            else
                echo -e "【${BLUE}请选择语言${NC}】 / 【${BLUE}Please select language${NC}】"
                echo -e "【${BLUE}1${NC}】【${YELLOW}中文${NC}】"
                echo -e "【${BLUE}2${NC}】【${YELLOW}English${NC}】"
                read -p "$(echo -e "【${RED}输入选项${NC}】 / 【${RED}Enter choice${NC}】")" lang_choice
            fi

            case $lang_choice in
                1)
                    if [ "$LANGUAGE" = "EN" ]; then
                        LANGUAGE="EN"
                        echo "LANGUAGE='EN'" > "$CONFIG_FILE"
                        echo -e "【${GREEN}Language switched to English${NC}】 / 【${GREEN}语言已切换为英文${NC}】"
                    else
                        LANGUAGE="CN"
                        echo "LANGUAGE='CN'" > "$CONFIG_FILE"
                        echo -e "【${GREEN}语言已切换为中文${NC}】 / 【${GREEN}Language switched to Chinese${NC}】"
                    fi
                    ;;
                2)
                    if [ "$LANGUAGE" = "EN" ]; then
                        LANGUAGE="CN"
                        echo "LANGUAGE='CN'" > "$CONFIG_FILE"
                        echo -e "【${GREEN}Language switched to Chinese${NC}】 / 【${GREEN}语言已切换为中文${NC}】"
                    else
                        LANGUAGE="EN"
                        echo "LANGUAGE='EN'" > "$CONFIG_FILE"
                        echo -e "【${GREEN}语言已切换为英文${NC}】 / 【${GREEN}Language switched to English${NC}】"
                    fi
                    ;;
                *)
                    if [ "$LANGUAGE" = "EN" ]; then
                        echo -e "【${RED}Invalid option${NC}】 / 【${RED}无效选项${NC}】"
                    else
                        echo -e "【${RED}无效选项${NC}】 / 【${RED}Invalid option${NC}】"
                    fi
                    ;;
            esac
            ;;
        19)
            update_script
            ;;
        20)
            view_change_log
            ;;
        00)
            exit_script
            ;;
        *)
            if [ "$LANGUAGE" = "CN" ]; then
                echo -e "【${RED}无效选项${NC}】"
            else
                echo -e "【${RED}Invalid option${NC}】"
            fi
            ;;
    esac
    if [ "$LANGUAGE" = "CN" ]; then
        echo -ne "【${RED}按任意键返回主菜单${NC}】"
    else
        echo -ne "【${RED}Press any key to return to the main menu${NC}】"
    fi
    read -n 1
done
