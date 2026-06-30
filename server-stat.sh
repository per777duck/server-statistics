#!/usr/bin/env bash

VERSION='1.0.0'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

show_help() {
	echo ""
	echo -e  "${YELLOW}--------------------------------------------------------------------------------${NC}"
	echo -e "${YELLOW}How to use:${NC}"
	echo "    ./server-stat.sh [OPTION]"
	echo ""
	echo -e "${YELLOW}Description:${NC}"
	echo "    The script allows you to view basic system statistics"
	echo "    and assess its load, as well as see the processes"
	echo "    that are putting the greatest load on the system."
	echo ""
	echo -e "${YELLOW}Options:${NC}"
	echo "    -h, --help        show this help and exit"
	echo "    -v, --version     show script version and exit"
	echo "    -s, --start       start script"
	echo ""
	echo -e "${YELLOW}Example:${NC}"
	echo "    ./server-stat.sh --start"
	echo -e  "${YELLOW}--------------------------------------------------------------------------------${NC}"
	echo ""
}

server_stat() {
	echo ""
	echo -e  "${YELLOW}--------------------------------------Users--------------------------------------;${NC}"

	echo -e "${YELLOW}Users in network:${NC}"
	users=$(w -sf | awk 'NR!=1{print $0}')
	echo "${users}" | sed 's/^/  /'

	echo -e "${YELLOW}---------------------------------Server statistics--------------------------------${NC}"

	echo -e  "${YELLOW}Load average:${NC}"
	LC_ALL=C uptime | LC_ALL=C awk '{print "1m: " $8 "5m: " $9 "15m: " $10}' | sed 's/,/ /g' |  sed 's/^/  /'

	echo ""

	echo -e "${YELLOW}CPU usage:${NC}"
	cpu_usage=$(LC_ALL=C top -b -n 1 | grep -i "cpu(s)" | sed 's/.*, *\([0-9.]* *id.*\)/\1/' | sed 's/,/./g' | LC_ALL=C awk '{printf "%.1f%%", 100 - $1}')
	echo "Used: ${cpu_usage}" | sed 's/^/  /'

	echo ""

	echo -e "${YELLOW}MEM usage:${NC}"
	total_mem=$(free -m | awk 'NR==2{print $2}')
	used_mem=$(free -m | awk 'NR==2{print $3}')
	free_mem=$(free -m | awk 'NR==2{print $7}')
	used_mem_percentage=$(echo "scale=1; ${used_mem} * 100 / ${total_mem}" | bc)
	free_mem_percentage=$(echo "scale=1; ${free_mem} * 100 / ${total_mem}" | bc)
	echo "Used: ${used_mem} MB/${total_mem} MB (${used_mem_percentage}%)" | sed 's/^/  /'
	echo "Free: ${free_mem} MB/${total_mem} MB (${free_mem_percentage}%)" | sed 's/^/  /'

	echo ""

	echo -e "${YELLOW}DISK usage:${NC}"
	total_disk=$(df -B G / | awk 'NR==2{print $2}' |  sed 's/G//')
	used_disk=$(df -B G / | awk 'NR==2{print $3}' | sed 's/G//')
	free_disk=$(df -B G / | awk 'NR==2{print $4}' | sed 's/G//')
	used_disk_percentage=$(echo "scale=1; ${used_disk} * 100 / ${total_disk}" | bc)
	free_disk_percentage=$(echo "scale=1; ${free_disk} * 100 / ${total_disk}" | bc)
	echo "Used: ${used_disk} GB/${total_disk} GB (${used_disk_percentage}%)" | sed 's/^/  /'
	echo "Free: ${free_disk} GB/${total_disk} GB (${free_disk_percentage}%)" | sed 's/^/  /'

	echo ""

	echo -e "${YELLOW}Top 5 processes by CPU usage:${NC}"
	top_cpu_usage=$(ps -e -o pid,cmd,%cpu,%mem --sort=-%cpu | head -n 6)
	echo "${top_cpu_usage}" | sed 's/^/ /'

	echo ""

	echo -e "${YELLOW}Top 5 processes by MEM usage:${NC}"
	top_cpu_usage=$(ps -e -o pid,cmd,%cpu,%mem --sort=-%mem | head -n 6)
	echo "${top_cpu_usage}" | sed 's/^/ /'

	echo -e  "${YELLOW}--------------------------------------------------------------------------------${NC}"
	echo ""
}


case "$1" in
	-h|--help)
		show_help
		exit 0
		;;
	-v|--version)
		echo "${VERSION}"
		exit 0
		;;
	-s|--start)
		server_stat
		exit 0
		;;
	"")
		echo -e "${RED}ERROR: No argument specified. Use --help for help.${NC}"
		exit 1
		;;
	*)
		echo -e "${RED}ERROR: Unknown option ${1}. Use --help for help.${NC}"
		exit 1
		;;
esac

