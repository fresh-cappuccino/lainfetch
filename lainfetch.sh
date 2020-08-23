#! /usr/bin/env bash

set_info() {

d_title=$USER@$HOSTNAME
d_os_a=$(uname -a | awk '{print $2}')
d_os_o=$(uname -o)
d_kerneln=$(cat /proc/sys/kernel/ostype)
d_kernelv=$(cat /proc/sys/kernel/osrelease)
d_uptime=$(uptime | awk '{print $3}')" min"
d_shell=$(basename $SHELL)
d_res=$(xrandr | sed -n 1p | sed 's/.*current.//g;s/,.*//g;s/ //g')
d_desk=$XDG_SESSION_DESKTOP
d_font=$(fc-match | sed 's/\..*//g')
d_cpu=$(cat /proc/cpuinfo | grep -o 'model name.*' | sed -n 1p | sed 's/.*:.//g;s/(.*)//g')
d_memused=$(echo $(cat /proc/meminfo | sed -n 2p | tr -d [A-Za-z:' ']) / 1000 | bc)" MiB"
d_memtotal=$(echo $(cat /proc/meminfo | sed -n 1p | tr -d [A-Za-z:' ']) / 1000 | bc)" MiB"
d_arch=$(getconf LONG_BIT)" - bits"
d_browser=$(xdg-settings get default-web-browser | sed 's/-.*//g;s/\..*//g')

}

display_info() {

set_info

cat << EOF

$d_title
OS: ${d_os_a^} | $d_os_o
Kernel: $d_kerneln | $d_kernelv
Uptime: $d_uptime
Shell: $d_shell
Resolution: $d_res
Desk: $d_desk
Font: $d_font
CPU: $d_cpu
Mem: $d_memused / $d_memtotal
Arch: $d_arch
Browser: ${d_browser^}

EOF

}

display_info
