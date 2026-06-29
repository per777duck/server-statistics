#!/bin/bash

echo "----------------------------Statistics of the server----------------------------"
echo "CPU usage:"
cpu_stats=$(top -bn1 | grep "Cpu(s)" |  sed 's/.*, *\([0-9]*,[0-9]*\)%* id.*/\1/' |  awk '{print 100 - $1"%"}')
echo "  $cpu_stats"

echo "MEM usage:"
total=$(free -m | awk 'NR==2{print $2}')
used=$(free -m | awk 'NR==2{print $3}')
free=$(free -m | awk 'NR==2{print $7}')

used_percentage=$(echo "scale=1; ${used} * 100 / ${total}" | bc)
free_percentage=$(echo "scale=1; ${free} * 100 / ${total}" | bc)

echo "  Used: ${used} MB/${total} MB (${used_percentage}%)"
echo "  Free: ${free} MB/${total} MB (${free_percentage}%)"
