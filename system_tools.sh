#!/bin/bash

# Define version number
# 定义版本号
VERSION="v1.5"

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
CHANGE_LOG_URL="https://raw.githubusercontent.com/scarsong/system_tools/main/Change_log"
CHANGE_LOG_ZH_CN_URL="https://raw.githubusercontent.com/scarsong/system_tools/main/Change_log_zh-cn"

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
        echo -e "【${BLUE}01${NC}】【${BLUE}管理${YELLOW} iptables IPv4 / ip6tables IPv6 ${BLUE}输入链规则${NC}】"
        echo -e "【${BLUE}02${NC}】【${BLUE}管理服务器${YELLOW} SSH ${BLUE}防火墙规则${NC}】"
        echo -e "【${BLUE}03${NC}】【${BLUE}查看${YELLOW} iptables IPv4 Docker ${BLUE}用户链规则${NC}】"
        echo -e "【${BLUE}04${NC}】【${BLUE}查看${YELLOW} ip6tables IPv6 Docker ${BLUE}用户链规则${NC}】"
        echo -e "【${BLUE}05${NC}】【${BLUE}查看${YELLOW} iptables IPv4 Docker NAT ${BLUE}规则${NC}】"
        echo -e "【${BLUE}06${NC}】【${BLUE}查看${YELLOW} ip6tables IPv6 Docker NAT ${BLUE}规则${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}07${NC}】【${BLUE}系统会话保持 ${YELLOW}screen ${BLUE}工具管理${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}17${NC}】【${RED}切换脚本显示语言${NC}】【${YELLOW}Switch script language${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}18${NC}】【${GREEN}脚本更新${NC}】"
        echo -e "【${BLUE}19${NC}】【${WHITE}更新日志${NC}】"
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
        echo -e "【${BLUE}01${NC}】【${BLUE}Manage${YELLOW} iptables IPv4 / ip6tables IPv6 ${BLUE}input chain rules${NC}】"
        echo -e "【${BLUE}02${NC}】【${BLUE}Manage server ${YELLOW}SSH ${BLUE}firewall rules${NC}】"
        echo -e "【${BLUE}03${NC}】【${BLUE}View ${YELLOW}iptables IPv4 Docker ${BLUE}user chain rules${NC}】"
        echo -e "【${BLUE}04${NC}】【${BLUE}View ${YELLOW}ip6tables IPv6 Docker ${BLUE}user chain rules${NC}】"
        echo -e "【${BLUE}05${NC}】【${BLUE}View ${YELLOW}iptables IPv4 Docker NAT ${BLUE}rules${NC}】"
        echo -e "【${BLUE}06${NC}】【${BLUE}View ${YELLOW}ip6tables IPv6 Docker NAT ${BLUE}rules${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}07${NC}】【${BLUE}System session management with ${YELLOW}screen ${BLUE}tool${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}17${NC}】【${RED}Switch script language${NC}【${YELLOW}切换脚本显示语言${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}18${NC}】【${GREEN}Update script${NC}】"
        echo -e "【${BLUE}19${NC}】【${WHITE}Change log${NC}】"
        echo -e "${BLUE}================================================================================${NC}"
        echo -e "【${BLUE}00${NC}】【${RED}Exit script${NC}】"
		echo -e "${BLUE}================================================================================${NC}"
    fi
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
                if [ -f "/root/add_ssh_ips.sh" ] && [ -f "/etc/systemd/system/add_ssh_ips.service" ]; then
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${GREEN}已找到现有规则文件并对其进行修改${NC}】"
                    else
                        echo -e "【${GREEN}Found existing rules files and modifying them${NC}】"
                    fi
                    # Call the function to modify existing rules
                    # 调用修改函数
                    modify_existing_rules
                else
                    if [ "$LANGUAGE" = "CN" ]; then
                        echo -e "【${RED}检测出现有规则文件或服务不存在${NC}】【${RED}已经开始创建${NC}】"
                    else
                        echo -e "【${RED}Existing rules files or service not detected${NC}】【${RED}Starting creation${NC}】"
                    fi
                    # Call the function to create SSH rules
                    # 调用创建函数
                    create_ssh_rules
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
            # Call the function to create SSH rules
            # 调用创建函数
            create_ssh_rules
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
        read -p "【${YELLOW} IPv4 ${NC}地址】" ipv4_addresses
        echo -e "【${RED}请输入允许访问${YELLOW} SSH ${RED}的${YELLOW} IPv6 ${RED}地址${NC}】【${RED}可用空格分隔多个地址${NC}】"
        read -p "【${YELLOW} IPv6 ${NC}地址】" ipv6_addresses
    else
        echo -e "【${RED}Please enter the${YELLOW} IPv4 ${RED}addresses allowed to access${YELLOW} SSH ${RED}${NC}】【${RED}Separate multiple addresses with spaces${NC}】"
        read -p "【${YELLOW} IPv4 ${NC}addresses】" ipv4_addresses
        echo -e "【${RED}Please enter the${YELLOW} IPv6 ${RED}addresses allowed to access${YELLOW} SSH ${RED}${NC}】【${RED}Separate multiple addresses with spaces${NC}】"
        read -p "【${YELLOW} IPv6 ${NC}addresses】" ipv6_addresses
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
            manage_firewall
            ;;
        02)
            manage_ssh_firewall
            ;;
        03)
            if [ "$LANGUAGE" = "CN" ]; then
                show_progress "【${BLUE}查看${YELLOW} IPv4 Docker ${BLUE}用户链规则${NC}】"
            else
                show_progress "【${BLUE}View${YELLOW} IPv4 Docker ${BLUE}User Chain Rules${NC}】"
            fi
            iptables -L DOCKER-USER -n --line-numbers | output_command
            ;;
        04)
            if [ "$LANGUAGE" = "CN" ]; then
                show_progress "【${BLUE}查看${YELLOW} IPv6 Docker ${BLUE}用户链规则${NC}】"
            else
                show_progress "【${BLUE}View${YELLOW} IPv6 Docker ${BLUE}User Chain Rules${NC}】"
            fi
            ip6tables -L DOCKER-USER -n --line-numbers | output_command
            ;;
        05)
            if [ "$LANGUAGE" = "CN" ]; then
                show_progress "【${BLUE}查看${YELLOW} IPv4 Docker NAT ${BLUE}规则${NC}】"
            else
                show_progress "【${BLUE}View${YELLOW} IPv4 Docker NAT ${BLUE}Rules${NC}】"
            fi
            iptables -t nat -L POSTROUTING -n --line-numbers | output_command
            ;;
        06)
            if [ "$LANGUAGE" = "CN" ]; then
                show_progress "【${BLUE}查看${YELLOW} IPv6 Docker NAT ${BLUE}规则${NC}】"
            else
                show_progress "【${BLUE}View${YELLOW} IPv6 Docker NAT ${BLUE}Rules${NC}】"
            fi
            ip6tables -t nat -L POSTROUTING -n --line-numbers | output_command
            ;;
        07)
            manage_screen 
            ;;
        17)
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
        18)
            update_script 
            ;;
        19)
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
