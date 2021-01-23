REM       COMMAND FILE BUILT BY IDEA 
REM       Sat Jan 23 05:58:42 2021
REM
cxstm8 -v -l +strict +debug +modsl0 +split +warn "networkmodule_vector.c"
cxstm8 -v -l +strict +debug +modsl0 +split +warn "enc28j60.c" "gpio.c" "httpd.c" "main.c" "mqtt.c" "mqtt_pal.c" "spi.c" "timer.c" "uip.c" "uip_arp.c" "uip_tcpapphub.c"
clnk -v -sa -o "NetworkModule.sm8" -m "NetworkModule.map" "networkmodule.lkf"
chex -f3 -o "NetworkModule.sx" "NetworkModule.sm8"
clabs "NetworkModule.sm8"
