REM       COMMAND FILE BUILT BY IDEA 
REM       Thu Jul 09 21:58:59 2020
REM
cxstm8 -v -l +strict +debug +modsl0 +warn "networkmodule_vector.c"
cxstm8 -v -l +strict +debug +modsl0 +warn "enc28j60.c" "gpio.c" "httpd.c" "main.c" "spi.c" "timer.c" "uip.c" "uip_arp.c" "uip_tcpapphub.c"
clnk -o "NetworkModule.sm8" -m "NetworkModule.map" "NetworkModule.lkf"
chex -f3 -o "NetworkModule.sx" "NetworkModule.sm8"
clabs "NetworkModule.sm8"
