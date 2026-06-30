#!/bin/bash

YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}----------------------------Statistics of the server----------------------------"
echo -e "CPU usage:${NC}"
cpu_usage=$(LC_ALL=C top -bn1 | grep -i "cpu(s)" | sed 's/.*, *\([0-9.]* *id.*\)/\1/' | sed 's/,/./g' | LC_ALL=C awk '{printf "%.1f%%", 100 - $1}')
echo "  Used: $cpu_usage"

echo ""

echo -e "${YELLOW}MEM usage:${NC}"
total_mem=$(free -m | awk 'NR==2{print $2}')
used_mem=$(free -m | awk 'NR==2{print $3}')
free_mem=$(free -m | awk 'NR==2{print $7}')

used_mem_percentage=$(echo "scale=1; ${used_mem} * 100 / ${total_mem}" | bc)
free_mem_percentage=$(echo "scale=1; ${free_mem} * 100 / ${total_mem}" | bc)

echo "  Used: ${used_mem} MB/${total_mem} MB (${used_mem_percentage}%)"
echo "  Free: ${free_mem} MB/${total_mem} MB (${free_mem_percentage}%)"

echo ""

echo -e "${YELLOW}DISK usage:${NC}"
total_disk=$(df -BG / | awk 'NR==2{print $2}')
used_disk=$(df -BG / | awk 'NR==2{print $3}')
free_disk=$(df -BG / | awk 'NR==2{print $4}')

used_disk_percentage=$(echo "scale=1; ${used_disk} * 100 / ${total_disk}" | bc)
free_disk_percentage=$(echo "scale=1; ${free_disk} * 100 / ${total_disk}" | bc)

echo "  Used: ${used_disk} GB/${total_disk} GB (${used_disk_percentage}%)"
echo "  Free: ${free_disk} GB/${total_disk} GB (${free_disk_percentage}%)"

echo ""

echo -e "${YELLOW}Top 5 processes by CPU usage:${NC}"
top_cpu_usage=$(ps -e -o pid,cmd,%cpu,%mem --sort=-%cpu | head -n 6)
echo " ${top_cpu_usage}"

echo ""

echo -e "${YELLOW}Top 5 processes by MEM usage:${NC}"
top_cpu_usage=$(ps -e -o pid,cmd,%cpu,%mem --sort=-%mem | head -n 6)
echo " ${top_cpu_usage}"

echo -e  "${YELLOW}--------------------------------------------------------------------------------${NC}"
