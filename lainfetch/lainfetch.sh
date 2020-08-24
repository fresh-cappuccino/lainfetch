#! /usr/bin/env bash

set_info() {

d_title="Let'sAllLove@Lain"
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
                        ...''.....                   
                    .;loc::cxkxdl;.. .               
                 .;okkk'   .ckkkkkx:....             
             .'.;dkkkkkd';lkkkkkkkkkl..... .         
            ...lkkkkkkkxxkkkkkkkkkkkkc.....,c:..     
            ..ckko:'.      .';lxkkkkkx......cl;..    
            ..l,                .:xkkk,.....;c'.     
           ..                      ,dk'.........     
          .,.       ..O K.           '.........      
          :.       ':O0:Nc',  l,       ........      
          :     ...x:Xk0Ndlx:.dX.,      .......      
          .    .do00xxKNNKNNXxlocl.      .......     
          .    OOd'.;ONNNNNNNKxkk00d     .......     
          'c'  NO0:,dNNNNNNNNNk'..lOl     ......     
          lll .NNK00XNNNNNNNNNKc;lKdO.    ......     
         .llc .NNNNNNNNKXNNNNNNX00XN: ..  ......     
         ,cl:..NNNNNNNN00NNNNNNNNNNK.  .,  ......    
         ,lllc.ONNNNNNNNNNNNNNNNNNNc   o; .......    
        .clllddx0NNNNNNNKNNNNNNNNNX.   .  :l'....    
       'cllllxkkxONNNNNNNNNNNNNNNK,    ,.:llc... .   
     .,llllldkkkkkxKNNNNNNNNNNNXO,   ;lllllll;.. ..  
    ...:lllokkkkkkxodONNNNNNXOxl.  ;xkkollllll'. ... 
   .....':ldxoc:'.    .cxxo;....  dkkkkxllllll: .....
   .....................,......   .;dkkkolllll:......
   ....................':......  ... 'lkdllll;.......
   ............................. ..... .:::,.........
   ..................................................
   ................................................. 
                                                     
"

#printf "%s" "$lain"
#display_info

paste <(printf "%s" "$lain") <(display_info) | lolcat
