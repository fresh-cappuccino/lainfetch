#! /usr/bin/env bash

set_info() {

d_title="Copland@OS"
d_os_a=$(uname -a | awk '{print $2}')
d_os_o=$(uname -o)
d_kerneln=$(cat /proc/sys/kernel/ostype)
d_kernelv=$(cat /proc/sys/kernel/osrelease)
d_uptime=$(uptime | awk '{print $3}')" min"
d_shell=$(basename $SHELL)
d_term=$(echo $TERM | sed 's/-.*//g')
d_res=$(xrandr | sed -n 1p | sed 's/.*current.//g;s/,.*//g;s/ //g')
d_desk=$XDG_SESSION_DESKTOP
d_font=$(fc-match | sed 's/\..*//g')
d_cpu=$(cat /proc/cpuinfo | grep -o 'model name.*' | sed -n 1p | sed 's/.*:.//g;s/(.*)//g')
d_memused=$(echo $(cat /proc/meminfo | sed -n 2p | tr -d [A-Za-z:' ']) / 1000 | bc)" MiB"
d_memtotal=$(echo $(cat /proc/meminfo | sed -n 1p | tr -d [A-Za-z:' ']) / 1000 | bc)" MiB"
d_arch=$(getconf LONG_BIT)" - bits"
d_browser=$(xdg-settings get default-web-browser | sed 's/-.*//g;s/\..*//g')
d_line=$(expr length "$d_title"); cnt=
for i in $(seq 1 $d_line); do
	cnt="$cnt─"
done

}

display_info() {

set_info

cat << EOF

$d_title

$cnt

OS: ${d_os_a^} | $d_os_o
Kernel: $d_kerneln | $d_kernelv
Uptime: $d_uptime
Shell: $d_shell
Terminal: $d_term
Resolution: $d_res
Desk: $d_desk
Font: $d_font
CPU: $d_cpu
Mem: $d_memused / $d_memtotal
Arch: $d_arch
Browser: ${d_browser^}

EOF

}

lain="
                        ;dl.                       
                        .;,.                       
                                                   
           ..      .';clooolc;'.       '.          
        ,oxdo'  .:xOkdollclloddxo:.   dkkd:.       
     .lxdc,.. .lkko:..       .'coddl.  .,cool,     
   'dxl,.    ,kkl,.             .:ddl;     'ldo;   
 .dko,      ,kxl.     .;llc;.     ,ddl,      'odo, 
;Okl.       xko,     o000Okxo:.    :xd:.      .oxo;
dkd:       .kxl'    :OOOkxdoc;'    .xdc.       cxl,
.odl,      .xxo,    ..dddolcl;'    ,kd:.      'xl,.
  ,loc.     cxdl.    .,;doc..     .xxl,     .odc.  
    ,loo:.   lddl,               ,kko:.  .:ddc'    
      .:lol;. ,lodo;.         .:xkdc,. ,lol;.      
 'do;    .',.   'coddo:.   .dOOxl,.   .,,.    ;c;. 
  ''.             .,ooc,   cOkl'              ';'  
                    'c:'   ;dc'                    
                    .c;.   'l;.                    
                    'c'.   .c,.                    
          cl:.      :;..   .:,.      .::'          
          .'''.....,'.      ..... ..,,..           
              .....             ...                
                                                   
"

#printf "%s" "$lain"
#display_info

paste <(printf "%s" "$lain") <(display_info) | lolcat
