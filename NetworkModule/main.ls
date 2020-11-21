   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2518                     .iconst:	section	.bss
2519  0000               _stack_limit2:
2520  0000 00            	ds.b	1
2521  0001               _stack_limit1:
2522  0001 00            	ds.b	1
2523                     .const:	section	.text
2524  0000               L5261_devicetype:
2525  0000 4e6574776f72  	dc.b	"NetworkModule/",0
2623                     ; 295 int main(void)
2623                     ; 296 {
2625                     .text:	section	.text,new
2626  0000               _main:
2628  0000 88            	push	a
2629       00000001      OFST:	set	1
2632                     ; 300   parse_complete = 0;
2634  0001 725f009b      	clr	_parse_complete
2635                     ; 301   mqtt_parse_complete = 0;
2637  0005 725f009a      	clr	_mqtt_parse_complete
2638                     ; 302   reboot_request = 0;
2640  0009 725f00a0      	clr	_reboot_request
2641                     ; 303   user_reboot_request = 0;
2643  000d 725f009f      	clr	_user_reboot_request
2644                     ; 304   restart_request = 0;
2646  0011 725f009e      	clr	_restart_request
2647                     ; 306   time_mark2 = 0;           // Time capture used in reboot
2649  0015 5f            	clrw	x
2650  0016 cf0092        	ldw	_time_mark2+2,x
2651  0019 cf0090        	ldw	_time_mark2,x
2652                     ; 309   restart_reboot_step = RESTART_REBOOT_IDLE;
2654  001c 725f009d      	clr	_restart_reboot_step
2655                     ; 310   mqtt_close_tcp = 0;
2657  0020 725f009c      	clr	_mqtt_close_tcp
2658                     ; 311   stack_error = 0;
2660  0024 725f00f8      	clr	_stack_error
2661                     ; 314   mqtt_start = MQTT_START_TCP_CONNECT;	 // Tracks the MQTT startup steps
2663  0028 3501003d      	mov	_mqtt_start,#1
2664                     ; 315   mqtt_start_status = MQTT_START_NOT_STARTED; // Tracks error states during
2666  002c 725f003c      	clr	_mqtt_start_status
2667                     ; 317   mqtt_keep_alive = 60;                  // Ping interval in seconds
2669  0030 ae003c        	ldw	x,#60
2670  0033 cf0086        	ldw	_mqtt_keep_alive,x
2671                     ; 319   mqtt_start_ctr1 = 0;			 // Tracks time for the MQTT startup
2673  0036 725f003b      	clr	_mqtt_start_ctr1
2674                     ; 321   mqtt_start_ctr2 = 0;			 // Tracks time for the MQTT startup
2676  003a 725f003a      	clr	_mqtt_start_ctr2
2677                     ; 323   mqtt_sanity_ctr = 0;			 // Tracks time for the MQTT sanity
2679  003e 725f0039      	clr	_mqtt_sanity_ctr
2680                     ; 325   mqtt_start_retry = 0;                  // Flag to retry the ARP/TCP Connect
2682  0042 725f0038      	clr	_mqtt_start_retry
2683                     ; 326   MQTT_error_status = 0;                 // For MQTT error status display in
2685  0046 725f0000      	clr	_MQTT_error_status
2686                     ; 328   mqtt_restart_step = MQTT_RESTART_IDLE; // Step counter for MQTT restart
2688  004a 725f0035      	clr	_mqtt_restart_step
2689                     ; 329   strcpy(topic_base, devicetype);        // Initial content of the topic_base.
2691  004e ae0009        	ldw	x,#_topic_base
2692  0051 90ae0000      	ldw	y,#L5261_devicetype
2693  0055               L6:
2694  0055 90f6          	ld	a,(y)
2695  0057 905c          	incw	y
2696  0059 f7            	ld	(x),a
2697  005a 5c            	incw	x
2698  005b 4d            	tnz	a
2699  005c 26f7          	jrne	L6
2700                     ; 335   state_request = STATE_REQUEST_IDLE;    // Set the state request received to
2702  005e c700f9        	ld	_state_request,a
2703                     ; 337   TXERIF_counter = 0;                    // Initialize the TXERIF error counter
2705  0061 5f            	clrw	x
2706  0062 cf0006        	ldw	_TXERIF_counter+2,x
2707  0065 cf0004        	ldw	_TXERIF_counter,x
2708                     ; 338   RXERIF_counter = 0;                    // Initialize the RXERIF error counter
2710  0068 cf0002        	ldw	_RXERIF_counter+2,x
2711  006b cf0000        	ldw	_RXERIF_counter,x
2712                     ; 344   clock_init();            // Initialize and enable clocks and timers
2714  006e cd0000        	call	_clock_init
2716                     ; 346   gpio_init();             // Initialize and enable gpio pins
2718  0071 cd0000        	call	_gpio_init
2720                     ; 348   spi_init();              // Initialize the SPI bit bang interface to the
2722  0074 cd0000        	call	_spi_init
2724                     ; 351   LEDcontrol(1);           // turn LED on
2726  0077 a601          	ld	a,#1
2727  0079 cd0000        	call	_LEDcontrol
2729                     ; 353   unlock_eeprom();         // unlock the EEPROM so writes can be performed
2731  007c cd0000        	call	_unlock_eeprom
2733                     ; 355   check_eeprom_settings(); // Check the EEPROM for previously stored Address
2735  007f cd0000        	call	_check_eeprom_settings
2737                     ; 359   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
2739  0082 cd0000        	call	_Enc28j60Init
2741                     ; 361   uip_arp_init();          // Initialize the ARP module
2743  0085 cd0000        	call	_uip_arp_init
2745                     ; 363   uip_init();              // Initialize uIP Web Server
2747  0088 cd0000        	call	_uip_init
2749                     ; 365   HttpDInit();             // Initialize listening ports
2751  008b cd0000        	call	_HttpDInit
2753                     ; 389   stack_limit1 = 0xaa;
2755  008e 35aa0001      	mov	_stack_limit1,#170
2756                     ; 390   stack_limit2 = 0x55;
2758  0092 35550000      	mov	_stack_limit2,#85
2759                     ; 401   mqtt_init(&mqttclient,
2759                     ; 402             mqtt_sendbuf,
2759                     ; 403 	    sizeof(mqtt_sendbuf),
2759                     ; 404 	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
2759                     ; 405 	    UIP_APPDATA_SIZE,
2759                     ; 406 	    publish_callback);
2761  0096 ae0000        	ldw	x,#_publish_callback
2762  0099 89            	pushw	x
2763  009a ae01be        	ldw	x,#446
2764  009d 89            	pushw	x
2765  009e ae0036        	ldw	x,#_uip_buf+54
2766  00a1 89            	pushw	x
2767  00a2 ae00c8        	ldw	x,#200
2768  00a5 89            	pushw	x
2769  00a6 ae0000        	ldw	x,#_mqtt_sendbuf
2770  00a9 89            	pushw	x
2771  00aa ae005a        	ldw	x,#_mqttclient
2772  00ad cd0000        	call	_mqtt_init
2774  00b0 5b0a          	addw	sp,#10
2775  00b2               L1561:
2776                     ; 520     uip_len = Enc28j60Receive(uip_buf); // Check for incoming packets
2778  00b2 ae0000        	ldw	x,#_uip_buf
2779  00b5 cd0000        	call	_Enc28j60Receive
2781  00b8 cf0000        	ldw	_uip_len,x
2782                     ; 522     if (uip_len > 0) {
2784  00bb 2738          	jreq	L5561
2785                     ; 531       if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
2787  00bd ae0800        	ldw	x,#2048
2788  00c0 cd0000        	call	_htons
2790  00c3 c3000c        	cpw	x,_uip_buf+12
2791  00c6 2612          	jrne	L7561
2792                     ; 532         uip_input(); // Calls uip_process(UIP_DATA) to process a received
2794  00c8 a601          	ld	a,#1
2795  00ca cd0000        	call	_uip_process
2797                     ; 537         if (uip_len > 0) {
2799  00cd ce0000        	ldw	x,_uip_len
2800  00d0 2723          	jreq	L5561
2801                     ; 538           uip_arp_out();
2803  00d2 cd0000        	call	_uip_arp_out
2805                     ; 542           Enc28j60Send(uip_buf, uip_len);
2807  00d5 ce0000        	ldw	x,_uip_len
2809  00d8 2013          	jp	LC001
2810  00da               L7561:
2811                     ; 545       else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
2813  00da ae0806        	ldw	x,#2054
2814  00dd cd0000        	call	_htons
2816  00e0 c3000c        	cpw	x,_uip_buf+12
2817  00e3 2610          	jrne	L5561
2818                     ; 546         uip_arp_arpin();
2820  00e5 cd0000        	call	_uip_arp_arpin
2822                     ; 550         if (uip_len > 0) {
2824  00e8 ce0000        	ldw	x,_uip_len
2825  00eb 2708          	jreq	L5561
2826                     ; 554           Enc28j60Send(uip_buf, uip_len);
2829  00ed               LC001:
2830  00ed 89            	pushw	x
2831  00ee ae0000        	ldw	x,#_uip_buf
2832  00f1 cd0000        	call	_Enc28j60Send
2833  00f4 85            	popw	x
2834  00f5               L5561:
2835                     ; 564     if (mqtt_start != MQTT_START_COMPLETE
2835                     ; 565      && mqtt_restart_step == MQTT_RESTART_IDLE
2835                     ; 566      && restart_reboot_step == RESTART_REBOOT_IDLE) {
2837  00f5 c6003d        	ld	a,_mqtt_start
2838  00f8 a114          	cp	a,#20
2839  00fa 270d          	jreq	L1761
2841  00fc c60035        	ld	a,_mqtt_restart_step
2842  00ff 2608          	jrne	L1761
2844  0101 c6009d        	ld	a,_restart_reboot_step
2845  0104 2603          	jrne	L1761
2846                     ; 567        mqtt_startup();
2848  0106 cd0000        	call	_mqtt_startup
2850  0109               L1761:
2851                     ; 571     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
2853  0109 c6009d        	ld	a,_restart_reboot_step
2854  010c 2603          	jrne	L3761
2855                     ; 572       mqtt_sanity_check();
2857  010e cd0000        	call	_mqtt_sanity_check
2859  0111               L3761:
2860                     ; 576     if (periodic_timer_expired()) {
2862  0111 cd0000        	call	_periodic_timer_expired
2864  0114 4d            	tnz	a
2865  0115 2743          	jreq	L5761
2866                     ; 578       for(i = 0; i < UIP_CONNS; i++) {
2868  0117 4f            	clr	a
2869  0118 6b01          	ld	(OFST+0,sp),a
2871  011a               L5071:
2872                     ; 579 	uip_periodic(i);
2874  011a 97            	ld	xl,a
2875  011b a629          	ld	a,#41
2876  011d 42            	mul	x,a
2877  011e 1c0000        	addw	x,#_uip_conns
2878  0121 cf0000        	ldw	_uip_conn,x
2881  0124 a602          	ld	a,#2
2882  0126 cd0000        	call	_uip_process
2884                     ; 598 	if (uip_len > 0) {
2886  0129 ce0000        	ldw	x,_uip_len
2887  012c 270e          	jreq	L1171
2888                     ; 599 	  uip_arp_out(); // Verifies arp entry in the ARP table and builds LLH
2890  012e cd0000        	call	_uip_arp_out
2892                     ; 600           Enc28j60Send(uip_buf, uip_len);
2894  0131 ce0000        	ldw	x,_uip_len
2895  0134 89            	pushw	x
2896  0135 ae0000        	ldw	x,#_uip_buf
2897  0138 cd0000        	call	_Enc28j60Send
2899  013b 85            	popw	x
2900  013c               L1171:
2901                     ; 603         mqtt_start_ctr1++; // Increment the MQTT start loop timer 1. This is
2903  013c 725c003b      	inc	_mqtt_start_ctr1
2904                     ; 607         mqtt_start_ctr2++; // Increment the MQTT start loop timer 2. This is
2906  0140 725c003a      	inc	_mqtt_start_ctr2
2907                     ; 610         mqtt_sanity_ctr++; // Increment the MQTT sanity loop timer. This is
2909  0144 725c0039      	inc	_mqtt_sanity_ctr
2910                     ; 578       for(i = 0; i < UIP_CONNS; i++) {
2912  0148 0c01          	inc	(OFST+0,sp)
2916  014a 7b01          	ld	a,(OFST+0,sp)
2917  014c a104          	cp	a,#4
2918  014e 25ca          	jrult	L5071
2919                     ; 620       if (mqtt_start == MQTT_START_COMPLETE) {
2921  0150 c6003d        	ld	a,_mqtt_start
2922  0153 a114          	cp	a,#20
2923  0155 2603          	jrne	L5761
2924                     ; 621         publish_outbound();
2926  0157 cd0000        	call	_publish_outbound
2928  015a               L5761:
2929                     ; 628     if (arp_timer_expired()) {
2931  015a cd0000        	call	_arp_timer_expired
2933  015d 4d            	tnz	a
2934  015e 2703          	jreq	L5171
2935                     ; 629       uip_arp_timer(); // Clean out old ARP Table entries. Any entry that has
2937  0160 cd0000        	call	_uip_arp_timer
2939  0163               L5171:
2940                     ; 636     check_runtime_changes();
2942  0163 cd0000        	call	_check_runtime_changes
2944                     ; 639     check_reset_button();
2946  0166 cd0000        	call	_check_reset_button
2948                     ; 644     check_restart_reboot();
2950  0169 cd0000        	call	_check_restart_reboot
2953  016c cc00b2        	jra	L1561
3004                     ; 672 void mqtt_startup(void)
3004                     ; 673 {
3005                     .text:	section	.text,new
3006  0000               _mqtt_startup:
3010                     ; 689   if (mqtt_start == MQTT_START_TCP_CONNECT) {
3012  0000 c6003d        	ld	a,_mqtt_start
3013  0003 a101          	cp	a,#1
3014  0005 2630          	jrne	L7271
3015                     ; 690     if (stored_mqttserveraddr[3] != 0) {
3017  0007 c60034        	ld	a,_stored_mqttserveraddr+3
3018  000a 2603cc0225    	jreq	L7371
3019                     ; 710       mqtt_conn = uip_connect(&uip_mqttserveraddr, Port_Mqttd, Port_Mqttd);
3021  000f ce008b        	ldw	x,_Port_Mqttd
3022  0012 89            	pushw	x
3023  0013 89            	pushw	x
3024  0014 ae0000        	ldw	x,#_uip_mqttserveraddr
3025  0017 cd0000        	call	_uip_connect
3027  001a 5b04          	addw	sp,#4
3028  001c cf0036        	ldw	_mqtt_conn,x
3029                     ; 711       if (mqtt_conn != NULL) {
3031  001f 2711          	jreq	L3371
3032                     ; 712         mqtt_start_ctr1 = 0; // Clear 100ms counter
3034  0021 725f003b      	clr	_mqtt_start_ctr1
3035                     ; 713         mqtt_start_ctr2 = 0; // Clear 100ms counter
3037  0025 725f003a      	clr	_mqtt_start_ctr2
3038                     ; 714         mqtt_start_status = MQTT_START_CONNECTIONS_GOOD;
3040  0029 3510003c      	mov	_mqtt_start_status,#16
3041                     ; 715         mqtt_start = MQTT_START_VERIFY_ARP;
3043  002d 3502003d      	mov	_mqtt_start,#2
3046  0031 81            	ret	
3047  0032               L3371:
3048                     ; 718         mqtt_start_status |= MQTT_START_CONNECTIONS_ERROR;
3050  0032 7210003c      	bset	_mqtt_start_status,#0
3052  0036 81            	ret	
3053  0037               L7271:
3054                     ; 723   else if (mqtt_start == MQTT_START_VERIFY_ARP
3054                     ; 724         && mqtt_start_ctr2 > 10) {
3056  0037 a102          	cp	a,#2
3057  0039 263a          	jrne	L1471
3059  003b c6003a        	ld	a,_mqtt_start_ctr2
3060  003e a10b          	cp	a,#11
3061  0040 2533          	jrult	L1471
3062                     ; 725     mqtt_start_ctr2 = 0; // Clear 100ms counter
3064  0042 725f003a      	clr	_mqtt_start_ctr2
3065                     ; 732     if (check_mqtt_server_arp_entry() == 1) {
3067  0046 cd0000        	call	_check_mqtt_server_arp_entry
3069  0049 5a            	decw	x
3070  004a 2611          	jrne	L3471
3071                     ; 734       mqtt_start_retry = 0;
3073  004c 725f0038      	clr	_mqtt_start_retry
3074                     ; 735       mqtt_start_ctr1 = 0; // Clear 100ms counter
3076  0050 725f003b      	clr	_mqtt_start_ctr1
3077                     ; 736       mqtt_start_status |= MQTT_START_ARP_REQUEST_GOOD;
3079  0054 721a003c      	bset	_mqtt_start_status,#5
3080                     ; 737       mqtt_start = MQTT_START_VERIFY_TCP;
3082  0058 3503003d      	mov	_mqtt_start,#3
3085  005c 81            	ret	
3086  005d               L3471:
3087                     ; 739     else if (mqtt_start_ctr1 > 150) {
3089  005d c6003b        	ld	a,_mqtt_start_ctr1
3090  0060 a197          	cp	a,#151
3091  0062 25a8          	jrult	L7371
3092                     ; 742       mqtt_start_status |= MQTT_START_ARP_REQUEST_ERROR;
3094  0064 7212003c      	bset	_mqtt_start_status,#1
3095                     ; 743       mqtt_start = MQTT_START_TCP_CONNECT;
3097  0068 3501003d      	mov	_mqtt_start,#1
3098                     ; 745       mqtt_start_status = MQTT_START_NOT_STARTED;
3100  006c 725f003c      	clr	_mqtt_start_status
3101                     ; 746       mqtt_start_retry++;
3103  0070 725c0038      	inc	_mqtt_start_retry
3105  0074 81            	ret	
3106  0075               L1471:
3107                     ; 750   else if (mqtt_start == MQTT_START_VERIFY_TCP
3107                     ; 751         && mqtt_start_ctr2 > 10) {
3109  0075 c6003d        	ld	a,_mqtt_start
3110  0078 a103          	cp	a,#3
3111  007a 263e          	jrne	L3571
3113  007c c6003a        	ld	a,_mqtt_start_ctr2
3114  007f a10b          	cp	a,#11
3115  0081 2537          	jrult	L3571
3116                     ; 752     mqtt_start_ctr2 = 0; // Clear 100ms counter
3118  0083 725f003a      	clr	_mqtt_start_ctr2
3119                     ; 760     if ((mqtt_conn->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
3121  0087 ce0036        	ldw	x,_mqtt_conn
3122  008a e619          	ld	a,(25,x)
3123  008c a40f          	and	a,#15
3124  008e a103          	cp	a,#3
3125  0090 260d          	jrne	L5571
3126                     ; 761       mqtt_start_retry = 0;
3128  0092 725f0038      	clr	_mqtt_start_retry
3129                     ; 762       mqtt_start_status |= MQTT_START_TCP_CONNECT_GOOD;
3131  0096 721c003c      	bset	_mqtt_start_status,#6
3132                     ; 763       mqtt_start = MQTT_START_QUEUE_CONNECT;
3134  009a 3504003d      	mov	_mqtt_start,#4
3137  009e 81            	ret	
3138  009f               L5571:
3139                     ; 765     else if (mqtt_start_ctr1 > 150) {
3141  009f c6003b        	ld	a,_mqtt_start_ctr1
3142  00a2 a197          	cp	a,#151
3143  00a4 2403cc0225    	jrult	L7371
3144                     ; 768       mqtt_start_status |= MQTT_START_TCP_CONNECT_ERROR;
3146  00a9 7214003c      	bset	_mqtt_start_status,#2
3147                     ; 769       mqtt_start = MQTT_START_TCP_CONNECT;
3149  00ad 3501003d      	mov	_mqtt_start,#1
3150                     ; 771       mqtt_start_status = MQTT_START_NOT_STARTED; 
3152  00b1 725f003c      	clr	_mqtt_start_status
3153                     ; 772       mqtt_start_retry++;
3155  00b5 725c0038      	inc	_mqtt_start_retry
3157  00b9 81            	ret	
3158  00ba               L3571:
3159                     ; 776   else if (mqtt_start == MQTT_START_QUEUE_CONNECT) {
3161  00ba c6003d        	ld	a,_mqtt_start
3162  00bd a104          	cp	a,#4
3163  00bf 2703cc0147    	jrne	L5671
3164                     ; 787     strcpy(client_id_text, devicetype);
3166  00c4 ae003e        	ldw	x,#_client_id_text
3167  00c7 90ae0000      	ldw	y,#L5261_devicetype
3168  00cb               L411:
3169  00cb 90f6          	ld	a,(y)
3170  00cd 905c          	incw	y
3171  00cf f7            	ld	(x),a
3172  00d0 5c            	incw	x
3173  00d1 4d            	tnz	a
3174  00d2 26f7          	jrne	L411
3175                     ; 789     client_id_text[strlen(client_id_text) - 1] = '\0';
3177  00d4 ae003e        	ldw	x,#_client_id_text
3178  00d7 cd0000        	call	_strlen
3180  00da 5a            	decw	x
3181  00db 724f003e      	clr	(_client_id_text,x)
3182                     ; 791     strcat(client_id_text, mac_string);
3184  00df ae00a1        	ldw	x,#_mac_string
3185  00e2 89            	pushw	x
3186  00e3 ae003e        	ldw	x,#_client_id_text
3187  00e6 cd0000        	call	_strcat
3189  00e9 85            	popw	x
3190                     ; 792     client_id = client_id_text;
3192  00ea ae003e        	ldw	x,#_client_id_text
3193  00ed cf0058        	ldw	_client_id,x
3194                     ; 795     connect_flags = MQTT_CONNECT_CLEAN_SESSION;
3196  00f0 3502008f      	mov	_connect_flags,#2
3197                     ; 798     topic_base[topic_base_len] = '\0';
3199  00f4 5f            	clrw	x
3200  00f5 c60008        	ld	a,_topic_base_len
3201  00f8 97            	ld	xl,a
3202  00f9 724f0009      	clr	(_topic_base,x)
3203                     ; 799     strcat(topic_base, "/status");
3205  00fd ae0059        	ldw	x,#L7671
3206  0100 89            	pushw	x
3207  0101 ae0009        	ldw	x,#_topic_base
3208  0104 cd0000        	call	_strcat
3210  0107 85            	popw	x
3211                     ; 802     mqtt_connect(&mqttclient,
3211                     ; 803                  client_id,              // Based on MAC address
3211                     ; 804                  topic_base,             // Will topic
3211                     ; 805                  "offline",              // Will message 
3211                     ; 806                  7,                      // Will message size
3211                     ; 807                  stored_mqtt_username,   // Username
3211                     ; 808                  stored_mqtt_password,   // Password
3211                     ; 809                  connect_flags,          // Connect flags
3211                     ; 810                  mqtt_keep_alive);       // Ping interval
3213  0108 ce0086        	ldw	x,_mqtt_keep_alive
3214  010b 89            	pushw	x
3215  010c 3b008f        	push	_connect_flags
3216  010f ae0040        	ldw	x,#_stored_mqtt_password
3217  0112 89            	pushw	x
3218  0113 ae0035        	ldw	x,#_stored_mqtt_username
3219  0116 89            	pushw	x
3220  0117 ae0007        	ldw	x,#7
3221  011a 89            	pushw	x
3222  011b ae0051        	ldw	x,#L1771
3223  011e 89            	pushw	x
3224  011f ae0009        	ldw	x,#_topic_base
3225  0122 89            	pushw	x
3226  0123 ce0058        	ldw	x,_client_id
3227  0126 89            	pushw	x
3228  0127 ae005a        	ldw	x,#_mqttclient
3229  012a cd0000        	call	_mqtt_connect
3231  012d 5b0f          	addw	sp,#15
3232                     ; 812     if (mqttclient.error == MQTT_OK) {
3234  012f ce0064        	ldw	x,_mqttclient+10
3235  0132 5a            	decw	x
3236  0133 260d          	jrne	L3771
3237                     ; 813       mqtt_start_ctr1 = 0; // Clear 100ms counter
3239  0135 725f003b      	clr	_mqtt_start_ctr1
3240                     ; 814       mqtt_start_status |= MQTT_START_MQTT_CONNECT_GOOD;
3242  0139 721e003c      	bset	_mqtt_start_status,#7
3243                     ; 815       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE1;
3245  013d 3505003d      	mov	_mqtt_start,#5
3248  0141 81            	ret	
3249  0142               L3771:
3250                     ; 818       mqtt_start_status |= MQTT_START_MQTT_CONNECT_ERROR;
3252  0142 7216003c      	bset	_mqtt_start_status,#3
3254  0146 81            	ret	
3255  0147               L5671:
3256                     ; 822   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE1) {
3258  0147 a105          	cp	a,#5
3259  0149 2635          	jrne	L1002
3260                     ; 832     if (mqtt_start_ctr1 > 20) {
3262  014b c6003b        	ld	a,_mqtt_start_ctr1
3263  014e a115          	cp	a,#21
3264  0150 2403cc0225    	jrult	L7371
3265                     ; 843       topic_base[topic_base_len] = '\0';
3267  0155 c60008        	ld	a,_topic_base_len
3268  0158 5f            	clrw	x
3269  0159 97            	ld	xl,a
3270  015a 724f0009      	clr	(_topic_base,x)
3271                     ; 844       strcat(topic_base, "/on");
3273  015e ae004d        	ldw	x,#L5002
3274  0161 89            	pushw	x
3275  0162 ae0009        	ldw	x,#_topic_base
3276  0165 cd0000        	call	_strcat
3278  0168 85            	popw	x
3279                     ; 845       mqtt_subscribe(&mqttclient, topic_base, 0);
3281  0169 5f            	clrw	x
3282  016a 89            	pushw	x
3283  016b ae0009        	ldw	x,#_topic_base
3284  016e 89            	pushw	x
3285  016f ae005a        	ldw	x,#_mqttclient
3286  0172 cd0000        	call	_mqtt_subscribe
3288  0175 5b04          	addw	sp,#4
3289                     ; 846       mqtt_start_ctr1 = 0; // Clear 100ms counter
3291  0177 725f003b      	clr	_mqtt_start_ctr1
3292                     ; 847       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE2;
3294  017b 3506003d      	mov	_mqtt_start,#6
3296  017f 81            	ret	
3297  0180               L1002:
3298                     ; 851   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE2) {
3300  0180 a106          	cp	a,#6
3301  0182 2632          	jrne	L1102
3302                     ; 852     if (mqtt_start_ctr1 > 10) {
3304  0184 c6003b        	ld	a,_mqtt_start_ctr1
3305  0187 a10b          	cp	a,#11
3306  0189 25c7          	jrult	L7371
3307                     ; 855       topic_base[topic_base_len] = '\0';
3309  018b c60008        	ld	a,_topic_base_len
3310  018e 5f            	clrw	x
3311  018f 97            	ld	xl,a
3312  0190 724f0009      	clr	(_topic_base,x)
3313                     ; 856       strcat(topic_base, "/off");
3315  0194 ae0048        	ldw	x,#L5102
3316  0197 89            	pushw	x
3317  0198 ae0009        	ldw	x,#_topic_base
3318  019b cd0000        	call	_strcat
3320  019e 85            	popw	x
3321                     ; 857       mqtt_subscribe(&mqttclient, topic_base, 0);
3323  019f 5f            	clrw	x
3324  01a0 89            	pushw	x
3325  01a1 ae0009        	ldw	x,#_topic_base
3326  01a4 89            	pushw	x
3327  01a5 ae005a        	ldw	x,#_mqttclient
3328  01a8 cd0000        	call	_mqtt_subscribe
3330  01ab 5b04          	addw	sp,#4
3331                     ; 858       mqtt_start_ctr1 = 0; // Clear 100ms counter
3333  01ad 725f003b      	clr	_mqtt_start_ctr1
3334                     ; 859       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE3;
3336  01b1 3507003d      	mov	_mqtt_start,#7
3338  01b5 81            	ret	
3339  01b6               L1102:
3340                     ; 863   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE3) {
3342  01b6 a107          	cp	a,#7
3343  01b8 2632          	jrne	L1202
3344                     ; 864     if (mqtt_start_ctr1 > 10) {
3346  01ba c6003b        	ld	a,_mqtt_start_ctr1
3347  01bd a10b          	cp	a,#11
3348  01bf 2564          	jrult	L7371
3349                     ; 867       topic_base[topic_base_len] = '\0';
3351  01c1 c60008        	ld	a,_topic_base_len
3352  01c4 5f            	clrw	x
3353  01c5 97            	ld	xl,a
3354  01c6 724f0009      	clr	(_topic_base,x)
3355                     ; 868       strcat(topic_base, "/state-req");
3357  01ca ae003d        	ldw	x,#L5202
3358  01cd 89            	pushw	x
3359  01ce ae0009        	ldw	x,#_topic_base
3360  01d1 cd0000        	call	_strcat
3362  01d4 85            	popw	x
3363                     ; 869       mqtt_subscribe(&mqttclient, topic_base, 0);
3365  01d5 5f            	clrw	x
3366  01d6 89            	pushw	x
3367  01d7 ae0009        	ldw	x,#_topic_base
3368  01da 89            	pushw	x
3369  01db ae005a        	ldw	x,#_mqttclient
3370  01de cd0000        	call	_mqtt_subscribe
3372  01e1 5b04          	addw	sp,#4
3373                     ; 870       mqtt_start_ctr1 = 0; // Clear 100ms counter
3375  01e3 725f003b      	clr	_mqtt_start_ctr1
3376                     ; 871       mqtt_start = MQTT_START_QUEUE_PUBLISH;
3378  01e7 3509003d      	mov	_mqtt_start,#9
3380  01eb 81            	ret	
3381  01ec               L1202:
3382                     ; 875   else if (mqtt_start == MQTT_START_QUEUE_PUBLISH) {
3384  01ec a109          	cp	a,#9
3385  01ee 2635          	jrne	L7371
3386                     ; 876     if (mqtt_start_ctr1 > 10) {
3388  01f0 c6003b        	ld	a,_mqtt_start_ctr1
3389  01f3 a10b          	cp	a,#11
3390  01f5 252e          	jrult	L7371
3391                     ; 879       topic_base[topic_base_len] = '\0';
3393  01f7 c60008        	ld	a,_topic_base_len
3394  01fa 5f            	clrw	x
3395  01fb 97            	ld	xl,a
3396  01fc 724f0009      	clr	(_topic_base,x)
3397                     ; 880       strcat(topic_base, "/status");
3399  0200 ae0059        	ldw	x,#L7671
3400  0203 89            	pushw	x
3401  0204 ae0009        	ldw	x,#_topic_base
3402  0207 cd0000        	call	_strcat
3404  020a 85            	popw	x
3405                     ; 881       mqtt_publish(&mqttclient,
3405                     ; 882                    topic_base,
3405                     ; 883 		   "online",
3405                     ; 884 		   6,
3405                     ; 885 		   MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
3407  020b 4b01          	push	#1
3408  020d ae0006        	ldw	x,#6
3409  0210 89            	pushw	x
3410  0211 ae0036        	ldw	x,#L5302
3411  0214 89            	pushw	x
3412  0215 ae0009        	ldw	x,#_topic_base
3413  0218 89            	pushw	x
3414  0219 ae005a        	ldw	x,#_mqttclient
3415  021c cd0000        	call	_mqtt_publish
3417  021f 5b07          	addw	sp,#7
3418                     ; 887       mqtt_start = MQTT_START_COMPLETE;
3420  0221 3514003d      	mov	_mqtt_start,#20
3421  0225               L7371:
3422                     ; 890 }
3425  0225 81            	ret	
3461                     ; 893 void mqtt_sanity_check(void)
3461                     ; 894 {
3462                     .text:	section	.text,new
3463  0000               _mqtt_sanity_check:
3467                     ; 906   if (mqtt_restart_step == MQTT_RESTART_IDLE) {
3469  0000 c60035        	ld	a,_mqtt_restart_step
3470  0003 2634          	jrne	L7402
3471                     ; 913     if (mqttclient.number_of_timeouts > 1) {
3473  0005 ce0068        	ldw	x,_mqttclient+14
3474  0008 a30002        	cpw	x,#2
3475  000b 2f08          	jrslt	L1502
3476                     ; 915       mqttclient.number_of_timeouts = 0;
3478  000d 5f            	clrw	x
3479  000e cf0068        	ldw	_mqttclient+14,x
3480                     ; 916       mqtt_restart_step = MQTT_RESTART_BEGIN;
3482  0011 35010035      	mov	_mqtt_restart_step,#1
3483  0015               L1502:
3484                     ; 922     if (mqtt_start == MQTT_START_COMPLETE
3484                     ; 923      && mqtt_conn->tcpstateflags == UIP_CLOSED) {
3486  0015 c6003d        	ld	a,_mqtt_start
3487  0018 a114          	cp	a,#20
3488  001a 260b          	jrne	L3502
3490  001c ce0036        	ldw	x,_mqtt_conn
3491  001f 6d19          	tnz	(25,x)
3492  0021 2604          	jrne	L3502
3493                     ; 924       mqtt_restart_step = MQTT_RESTART_BEGIN;
3495  0023 35010035      	mov	_mqtt_restart_step,#1
3496  0027               L3502:
3497                     ; 930     if (mqtt_start == MQTT_START_COMPLETE
3497                     ; 931      && mqttclient.error != MQTT_OK) {
3499  0027 a114          	cp	a,#20
3500  0029 2703cc00b6    	jrne	L7502
3502  002e ce0064        	ldw	x,_mqttclient+10
3503  0031 5a            	decw	x
3504  0032 27f7          	jreq	L7502
3505                     ; 932       mqtt_restart_step = MQTT_RESTART_BEGIN;
3507  0034 35010035      	mov	_mqtt_restart_step,#1
3509  0038 81            	ret	
3510  0039               L7402:
3511                     ; 936   else if (mqtt_restart_step == MQTT_RESTART_BEGIN) {
3513  0039 a101          	cp	a,#1
3514  003b 2609          	jrne	L1602
3515                     ; 944     mqtt_restart_step = MQTT_RESTART_DISCONNECT_START;
3517  003d 35020035      	mov	_mqtt_restart_step,#2
3518                     ; 947     mqtt_start_status = MQTT_START_NOT_STARTED;
3520  0041 725f003c      	clr	_mqtt_start_status
3523  0045 81            	ret	
3524  0046               L1602:
3525                     ; 950   else if (mqtt_restart_step == MQTT_RESTART_DISCONNECT_START) {
3527  0046 a102          	cp	a,#2
3528  0048 260f          	jrne	L5602
3529                     ; 951     mqtt_restart_step = MQTT_RESTART_DISCONNECT_WAIT;
3531  004a 35030035      	mov	_mqtt_restart_step,#3
3532                     ; 953     mqtt_disconnect(&mqttclient);
3534  004e ae005a        	ldw	x,#_mqttclient
3535  0051 cd0000        	call	_mqtt_disconnect
3537                     ; 954     mqtt_sanity_ctr = 0; // Clear 100ms counter
3539  0054 725f0039      	clr	_mqtt_sanity_ctr
3542  0058 81            	ret	
3543  0059               L5602:
3544                     ; 957   else if (mqtt_restart_step == MQTT_RESTART_DISCONNECT_WAIT) {
3546  0059 a103          	cp	a,#3
3547  005b 260c          	jrne	L1702
3548                     ; 958     if (mqtt_sanity_ctr > 10) {
3550  005d c60039        	ld	a,_mqtt_sanity_ctr
3551  0060 a10b          	cp	a,#11
3552  0062 2552          	jrult	L7502
3553                     ; 961       mqtt_restart_step = MQTT_RESTART_TCPCLOSE;
3555  0064 35040035      	mov	_mqtt_restart_step,#4
3557  0068 81            	ret	
3558  0069               L1702:
3559                     ; 965   else if (mqtt_restart_step == MQTT_RESTART_TCPCLOSE) {
3561  0069 a104          	cp	a,#4
3562  006b 260d          	jrne	L7702
3563                     ; 981     mqtt_close_tcp = 1;
3565  006d 3501009c      	mov	_mqtt_close_tcp,#1
3566                     ; 983     mqtt_sanity_ctr = 0; // Clear 100ms counter
3568  0071 725f0039      	clr	_mqtt_sanity_ctr
3569                     ; 984     mqtt_restart_step = MQTT_RESTART_TCPCLOSE_WAIT;
3571  0075 35050035      	mov	_mqtt_restart_step,#5
3574  0079 81            	ret	
3575  007a               L7702:
3576                     ; 987   else if (mqtt_restart_step == MQTT_RESTART_TCPCLOSE_WAIT) {
3578  007a a105          	cp	a,#5
3579  007c 2610          	jrne	L3012
3580                     ; 992     if (mqtt_sanity_ctr > 20) {
3582  007e c60039        	ld	a,_mqtt_sanity_ctr
3583  0081 a115          	cp	a,#21
3584  0083 2531          	jrult	L7502
3585                     ; 993       mqtt_close_tcp = 0;
3587  0085 725f009c      	clr	_mqtt_close_tcp
3588                     ; 994       mqtt_restart_step = MQTT_RESTART_SIGNAL_STARTUP;
3590  0089 35060035      	mov	_mqtt_restart_step,#6
3592  008d 81            	ret	
3593  008e               L3012:
3594                     ; 998   else if (mqtt_restart_step == MQTT_RESTART_SIGNAL_STARTUP) {
3596  008e a106          	cp	a,#6
3597  0090 2624          	jrne	L7502
3598                     ; 1000     mqtt_init(&mqttclient,
3598                     ; 1001               mqtt_sendbuf,
3598                     ; 1002 	      sizeof(mqtt_sendbuf),
3598                     ; 1003 	      &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
3598                     ; 1004 	      UIP_APPDATA_SIZE,
3598                     ; 1005 	      publish_callback);
3600  0092 ae0000        	ldw	x,#_publish_callback
3601  0095 89            	pushw	x
3602  0096 ae01be        	ldw	x,#446
3603  0099 89            	pushw	x
3604  009a ae0036        	ldw	x,#_uip_buf+54
3605  009d 89            	pushw	x
3606  009e ae00c8        	ldw	x,#200
3607  00a1 89            	pushw	x
3608  00a2 ae0000        	ldw	x,#_mqtt_sendbuf
3609  00a5 89            	pushw	x
3610  00a6 ae005a        	ldw	x,#_mqttclient
3611  00a9 cd0000        	call	_mqtt_init
3613  00ac 5b0a          	addw	sp,#10
3614                     ; 1008     mqtt_restart_step = MQTT_RESTART_IDLE;
3616  00ae 725f0035      	clr	_mqtt_restart_step
3617                     ; 1009     mqtt_start = MQTT_START_TCP_CONNECT;
3619  00b2 3501003d      	mov	_mqtt_start,#1
3620  00b6               L7502:
3621                     ; 1011 }
3624  00b6 81            	ret	
3697                     ; 1089 void publish_callback(void** unused, struct mqtt_response_publish *published)
3697                     ; 1090 {
3698                     .text:	section	.text,new
3699  0000               _publish_callback:
3701  0000 5204          	subw	sp,#4
3702       00000004      OFST:	set	4
3705                     ; 1096   pin_value = 0;
3707  0002 0f01          	clr	(OFST-3,sp)
3709                     ; 1097   ParseNum = 0;
3711                     ; 1125   pBuffer = uip_appdata;
3713  0004 ce0000        	ldw	x,_uip_appdata
3715                     ; 1127   pBuffer = pBuffer + 1;
3717  0007 1c0012        	addw	x,#18
3719                     ; 1129   pBuffer = pBuffer + 1;
3722                     ; 1131   pBuffer = pBuffer + 2;
3725                     ; 1133   pBuffer = pBuffer + 14;
3727  000a 1f03          	ldw	(OFST-1,sp),x
3729                     ; 1135   pBuffer = pBuffer + strlen(stored_devicename) + 1;
3731  000c ae0000        	ldw	x,#_stored_devicename
3732  000f cd0000        	call	_strlen
3734  0012 72fb03        	addw	x,(OFST-1,sp)
3735  0015 5c            	incw	x
3736  0016 1f03          	ldw	(OFST-1,sp),x
3738                     ; 1138   if (*pBuffer == 'o') {
3740  0018 f6            	ld	a,(x)
3741  0019 a16f          	cp	a,#111
3742  001b 267a          	jrne	L3412
3743                     ; 1139     pBuffer++;
3745  001d 5c            	incw	x
3746  001e 1f03          	ldw	(OFST-1,sp),x
3748                     ; 1140     if (*pBuffer == 'n') {
3750  0020 f6            	ld	a,(x)
3751  0021 a16e          	cp	a,#110
3752  0023 2609          	jrne	L5412
3753                     ; 1141       pBuffer++;
3755  0025 5c            	incw	x
3756  0026 1f03          	ldw	(OFST-1,sp),x
3758                     ; 1142       pin_value = 1;
3760  0028 a601          	ld	a,#1
3761  002a 6b01          	ld	(OFST-3,sp),a
3764  002c 200b          	jra	L7412
3765  002e               L5412:
3766                     ; 1144     else if (*pBuffer == 'f') {
3768  002e a166          	cp	a,#102
3769  0030 2607          	jrne	L7412
3770                     ; 1145       pBuffer = pBuffer + 2;
3772  0032 1c0002        	addw	x,#2
3773  0035 1f03          	ldw	(OFST-1,sp),x
3775                     ; 1146       pin_value = 0;
3777  0037 0f01          	clr	(OFST-3,sp)
3779  0039               L7412:
3780                     ; 1150     if (*pBuffer == 'a') {
3782  0039 f6            	ld	a,(x)
3783  003a a161          	cp	a,#97
3784  003c 2625          	jrne	L3512
3785                     ; 1151       pBuffer++;
3787  003e 5c            	incw	x
3788  003f 1f03          	ldw	(OFST-1,sp),x
3790                     ; 1152       if (*pBuffer == 'l') {
3792  0041 f6            	ld	a,(x)
3793  0042 a16c          	cp	a,#108
3794  0044 264b          	jrne	L7612
3795                     ; 1153         pBuffer++;
3797  0046 5c            	incw	x
3798  0047 1f03          	ldw	(OFST-1,sp),x
3800                     ; 1154         if (*pBuffer == 'l') {
3802  0049 f6            	ld	a,(x)
3803  004a a16c          	cp	a,#108
3804  004c 2643          	jrne	L7612
3805                     ; 1156 	  for (i=0; i<8; i++) GpioSetPin(i, (uint8_t)pin_value);
3807  004e 0f02          	clr	(OFST-2,sp)
3809  0050               L1612:
3812  0050 7b01          	ld	a,(OFST-3,sp)
3813  0052 97            	ld	xl,a
3814  0053 7b02          	ld	a,(OFST-2,sp)
3815  0055 95            	ld	xh,a
3816  0056 cd0000        	call	_GpioSetPin
3820  0059 0c02          	inc	(OFST-2,sp)
3824  005b 7b02          	ld	a,(OFST-2,sp)
3825  005d a108          	cp	a,#8
3826  005f 25ef          	jrult	L1612
3827  0061 202e          	jra	L7612
3828  0063               L3512:
3829                     ; 1162     else if (*pBuffer == '0' || *pBuffer == '1') {
3831  0063 a130          	cp	a,#48
3832  0065 2704          	jreq	L3712
3834  0067 a131          	cp	a,#49
3835  0069 2626          	jrne	L7612
3836  006b               L3712:
3837                     ; 1164       ParseNum = (uint8_t)((*pBuffer - '0') * 10);
3839  006b 97            	ld	xl,a
3840  006c a60a          	ld	a,#10
3841  006e 42            	mul	x,a
3842  006f 9f            	ld	a,xl
3843  0070 a0e0          	sub	a,#224
3844  0072 6b02          	ld	(OFST-2,sp),a
3846                     ; 1165       pBuffer++;
3848  0074 1e03          	ldw	x,(OFST-1,sp)
3849  0076 5c            	incw	x
3850  0077 1f03          	ldw	(OFST-1,sp),x
3852                     ; 1167       ParseNum += (uint8_t)(*pBuffer - '0');
3854  0079 f6            	ld	a,(x)
3855  007a a030          	sub	a,#48
3856  007c 1b02          	add	a,(OFST-2,sp)
3857  007e 6b02          	ld	(OFST-2,sp),a
3859                     ; 1169       if (ParseNum > 0 && ParseNum < 9) {
3861  0080 270f          	jreq	L7612
3863  0082 a109          	cp	a,#9
3864  0084 240b          	jruge	L7612
3865                     ; 1171         ParseNum--;
3867  0086 0a02          	dec	(OFST-2,sp)
3869                     ; 1173         GpioSetPin(ParseNum, (uint8_t)pin_value);
3871  0088 7b01          	ld	a,(OFST-3,sp)
3872  008a 97            	ld	xl,a
3873  008b 7b02          	ld	a,(OFST-2,sp)
3874  008d 95            	ld	xh,a
3875  008e cd0000        	call	_GpioSetPin
3877  0091               L7612:
3878                     ; 1179     mqtt_parse_complete = 1;
3880  0091 3501009a      	mov	_mqtt_parse_complete,#1
3882  0095 2013          	jra	L7712
3883  0097               L3412:
3884                     ; 1183   else if (*pBuffer == 's') {
3886  0097 a173          	cp	a,#115
3887  0099 260f          	jrne	L7712
3888                     ; 1184     pBuffer += 8;
3890  009b 1c0008        	addw	x,#8
3892                     ; 1185     if (*pBuffer == 'q') {
3894  009e f6            	ld	a,(x)
3895  009f a171          	cp	a,#113
3896  00a1 2607          	jrne	L7712
3897                     ; 1186       *pBuffer = '0'; // Destroy 'q' in buffer so subsequent "state"
3899  00a3 a630          	ld	a,#48
3900  00a5 f7            	ld	(x),a
3901                     ; 1197       state_request = STATE_REQUEST_RCVD;
3903  00a6 350100f9      	mov	_state_request,#1
3904  00aa               L7712:
3905                     ; 1200 }
3908  00aa 5b04          	addw	sp,#4
3909  00ac 81            	ret	
3948                     ; 1203 void publish_outbound(void)
3948                     ; 1204 {
3949                     .text:	section	.text,new
3950  0000               _publish_outbound:
3952  0000 88            	push	a
3953       00000001      OFST:	set	1
3956                     ; 1212   if (state_request == STATE_REQUEST_IDLE) {
3958  0001 c600f9        	ld	a,_state_request
3959  0004 2703cc00f9    	jrne	L1222
3960                     ; 1215     xor_tmp = (uint8_t)(IO_16to9 ^ IO_16to9_sent);
3962  0009 c60103        	ld	a,_IO_16to9
3963  000c c800fd        	xor	a,_IO_16to9_sent
3964  000f 6b01          	ld	(OFST+0,sp),a
3966                     ; 1217     if      (xor_tmp & 0x80) publish_pinstate('I', '8', IO_16to9, 0x80); // Input 8
3968  0011 2a0a          	jrpl	L3222
3971  0013 4b80          	push	#128
3972  0015 3b0103        	push	_IO_16to9
3973  0018 ae4938        	ldw	x,#18744
3976  001b 2060          	jp	LC002
3977  001d               L3222:
3978                     ; 1218     else if (xor_tmp & 0x40) publish_pinstate('I', '7', IO_16to9, 0x40); // Input 7
3980  001d a540          	bcp	a,#64
3981  001f 270a          	jreq	L7222
3984  0021 4b40          	push	#64
3985  0023 3b0103        	push	_IO_16to9
3986  0026 ae4937        	ldw	x,#18743
3989  0029 2052          	jp	LC002
3990  002b               L7222:
3991                     ; 1219     else if (xor_tmp & 0x20) publish_pinstate('I', '6', IO_16to9, 0x20); // Input 6
3993  002b a520          	bcp	a,#32
3994  002d 270a          	jreq	L3322
3997  002f 4b20          	push	#32
3998  0031 3b0103        	push	_IO_16to9
3999  0034 ae4936        	ldw	x,#18742
4002  0037 2044          	jp	LC002
4003  0039               L3322:
4004                     ; 1220     else if (xor_tmp & 0x10) publish_pinstate('I', '5', IO_16to9, 0x10); // Input 5
4006  0039 a510          	bcp	a,#16
4007  003b 270a          	jreq	L7322
4010  003d 4b10          	push	#16
4011  003f 3b0103        	push	_IO_16to9
4012  0042 ae4935        	ldw	x,#18741
4015  0045 2036          	jp	LC002
4016  0047               L7322:
4017                     ; 1221     else if (xor_tmp & 0x08) publish_pinstate('I', '4', IO_16to9, 0x08); // Input 4
4019  0047 a508          	bcp	a,#8
4020  0049 270a          	jreq	L3422
4023  004b 4b08          	push	#8
4024  004d 3b0103        	push	_IO_16to9
4025  0050 ae4934        	ldw	x,#18740
4028  0053 2028          	jp	LC002
4029  0055               L3422:
4030                     ; 1222     else if (xor_tmp & 0x04) publish_pinstate('I', '3', IO_16to9, 0x04); // Input 3
4032  0055 a504          	bcp	a,#4
4033  0057 270a          	jreq	L7422
4036  0059 4b04          	push	#4
4037  005b 3b0103        	push	_IO_16to9
4038  005e ae4933        	ldw	x,#18739
4041  0061 201a          	jp	LC002
4042  0063               L7422:
4043                     ; 1223     else if (xor_tmp & 0x02) publish_pinstate('I', '2', IO_16to9, 0x02); // Input 2
4045  0063 a502          	bcp	a,#2
4046  0065 270a          	jreq	L3522
4049  0067 4b02          	push	#2
4050  0069 3b0103        	push	_IO_16to9
4051  006c ae4932        	ldw	x,#18738
4054  006f 200c          	jp	LC002
4055  0071               L3522:
4056                     ; 1224     else if (xor_tmp & 0x01) publish_pinstate('I', '1', IO_16to9, 0x01); // Input 1
4058  0071 a501          	bcp	a,#1
4059  0073 270c          	jreq	L5222
4062  0075 4b01          	push	#1
4063  0077 3b0103        	push	_IO_16to9
4064  007a ae4931        	ldw	x,#18737
4066  007d               LC002:
4067  007d cd0000        	call	_publish_pinstate
4068  0080 85            	popw	x
4069  0081               L5222:
4070                     ; 1228     xor_tmp = (uint8_t)(IO_8to1 ^ IO_8to1_sent);
4072  0081 c60102        	ld	a,_IO_8to1
4073  0084 c800fc        	xor	a,_IO_8to1_sent
4074  0087 6b01          	ld	(OFST+0,sp),a
4076                     ; 1230     if      (xor_tmp & 0x80) publish_pinstate('O', '8', IO_8to1, 0x80); // Output 8
4078  0089 2a0a          	jrpl	L1622
4081  008b 4b80          	push	#128
4082  008d 3b0102        	push	_IO_8to1
4083  0090 ae4f38        	ldw	x,#20280
4086  0093 2060          	jp	LC003
4087  0095               L1622:
4088                     ; 1231     else if (xor_tmp & 0x40) publish_pinstate('O', '7', IO_8to1, 0x40); // Output 7
4090  0095 a540          	bcp	a,#64
4091  0097 270a          	jreq	L5622
4094  0099 4b40          	push	#64
4095  009b 3b0102        	push	_IO_8to1
4096  009e ae4f37        	ldw	x,#20279
4099  00a1 2052          	jp	LC003
4100  00a3               L5622:
4101                     ; 1232     else if (xor_tmp & 0x20) publish_pinstate('O', '6', IO_8to1, 0x20); // Output 6
4103  00a3 a520          	bcp	a,#32
4104  00a5 270a          	jreq	L1722
4107  00a7 4b20          	push	#32
4108  00a9 3b0102        	push	_IO_8to1
4109  00ac ae4f36        	ldw	x,#20278
4112  00af 2044          	jp	LC003
4113  00b1               L1722:
4114                     ; 1233     else if (xor_tmp & 0x10) publish_pinstate('O', '5', IO_8to1, 0x10); // Output 5
4116  00b1 a510          	bcp	a,#16
4117  00b3 270a          	jreq	L5722
4120  00b5 4b10          	push	#16
4121  00b7 3b0102        	push	_IO_8to1
4122  00ba ae4f35        	ldw	x,#20277
4125  00bd 2036          	jp	LC003
4126  00bf               L5722:
4127                     ; 1234     else if (xor_tmp & 0x08) publish_pinstate('O', '4', IO_8to1, 0x08); // Output 4
4129  00bf a508          	bcp	a,#8
4130  00c1 270a          	jreq	L1032
4133  00c3 4b08          	push	#8
4134  00c5 3b0102        	push	_IO_8to1
4135  00c8 ae4f34        	ldw	x,#20276
4138  00cb 2028          	jp	LC003
4139  00cd               L1032:
4140                     ; 1235     else if (xor_tmp & 0x04) publish_pinstate('O', '3', IO_8to1, 0x04); // Output 3
4142  00cd a504          	bcp	a,#4
4143  00cf 270a          	jreq	L5032
4146  00d1 4b04          	push	#4
4147  00d3 3b0102        	push	_IO_8to1
4148  00d6 ae4f33        	ldw	x,#20275
4151  00d9 201a          	jp	LC003
4152  00db               L5032:
4153                     ; 1236     else if (xor_tmp & 0x02) publish_pinstate('O', '2', IO_8to1, 0x02); // Output 2
4155  00db a502          	bcp	a,#2
4156  00dd 270a          	jreq	L1132
4159  00df 4b02          	push	#2
4160  00e1 3b0102        	push	_IO_8to1
4161  00e4 ae4f32        	ldw	x,#20274
4164  00e7 200c          	jp	LC003
4165  00e9               L1132:
4166                     ; 1237     else if (xor_tmp & 0x01) publish_pinstate('O', '1', IO_8to1, 0x01); // Output 1
4168  00e9 a501          	bcp	a,#1
4169  00eb 270c          	jreq	L1222
4172  00ed 4b01          	push	#1
4173  00ef 3b0102        	push	_IO_8to1
4174  00f2 ae4f31        	ldw	x,#20273
4176  00f5               LC003:
4177  00f5 cd0000        	call	_publish_pinstate
4178  00f8 85            	popw	x
4179  00f9               L1222:
4180                     ; 1241   if (state_request == STATE_REQUEST_RCVD) {
4182  00f9 c600f9        	ld	a,_state_request
4183  00fc 4a            	dec	a
4184  00fd 2606          	jrne	L7132
4185                     ; 1243     state_request = STATE_REQUEST_IDLE;
4187  00ff c700f9        	ld	_state_request,a
4188                     ; 1244     publish_pinstate_all();
4190  0102 cd0000        	call	_publish_pinstate_all
4192  0105               L7132:
4193                     ; 1272 }
4196  0105 84            	pop	a
4197  0106 81            	ret	
4261                     ; 1275 void publish_pinstate(uint8_t direction, uint8_t pin, uint8_t value, uint8_t mask)
4261                     ; 1276 {
4262                     .text:	section	.text,new
4263  0000               _publish_pinstate:
4265  0000 89            	pushw	x
4266       00000000      OFST:	set	0
4269                     ; 1279   application_message[0] = '0';
4271  0001 35300088      	mov	_application_message,#48
4272                     ; 1280   application_message[1] = (uint8_t)(pin);
4274  0005 9f            	ld	a,xl
4275  0006 c70089        	ld	_application_message+1,a
4276                     ; 1281   application_message[2] = '\0';
4278  0009 725f008a      	clr	_application_message+2
4279                     ; 1283   topic_base[topic_base_len] = '\0';
4281  000d 5f            	clrw	x
4282  000e c60008        	ld	a,_topic_base_len
4283  0011 97            	ld	xl,a
4284  0012 724f0009      	clr	(_topic_base,x)
4285                     ; 1286   if (direction == 'I') {
4287  0016 7b01          	ld	a,(OFST+1,sp)
4288  0018 a149          	cp	a,#73
4289  001a 2618          	jrne	L3432
4290                     ; 1288     if (invert_input == 0xff) value = (uint8_t)(~value);
4292  001c c600fa        	ld	a,_invert_input
4293  001f 4c            	inc	a
4294  0020 2602          	jrne	L5432
4297  0022 0305          	cpl	(OFST+5,sp)
4298  0024               L5432:
4299                     ; 1289     if (value & mask) strcat(topic_base, "/in_on");
4301  0024 7b05          	ld	a,(OFST+5,sp)
4302  0026 1506          	bcp	a,(OFST+6,sp)
4303  0028 2705          	jreq	L7432
4306  002a ae002f        	ldw	x,#L1532
4309  002d 2013          	jra	L7532
4310  002f               L7432:
4311                     ; 1290     else strcat(topic_base, "/in_off");
4313  002f ae0027        	ldw	x,#L5532
4315  0032 200e          	jra	L7532
4316  0034               L3432:
4317                     ; 1294     if (value & mask) strcat(topic_base, "/out_on");
4319  0034 7b05          	ld	a,(OFST+5,sp)
4320  0036 1506          	bcp	a,(OFST+6,sp)
4321  0038 2705          	jreq	L1632
4324  003a ae001f        	ldw	x,#L3632
4327  003d 2003          	jra	L7532
4328  003f               L1632:
4329                     ; 1295     else strcat(topic_base, "/out_off");
4331  003f ae0016        	ldw	x,#L7632
4333  0042               L7532:
4334  0042 89            	pushw	x
4335  0043 ae0009        	ldw	x,#_topic_base
4336  0046 cd0000        	call	_strcat
4337  0049 85            	popw	x
4338                     ; 1299   mqtt_publish(&mqttclient,
4338                     ; 1300                topic_base,
4338                     ; 1301 	       application_message,
4338                     ; 1302 	       2,
4338                     ; 1303 	       MQTT_PUBLISH_QOS_0);
4340  004a 4b00          	push	#0
4341  004c ae0002        	ldw	x,#2
4342  004f 89            	pushw	x
4343  0050 ae0088        	ldw	x,#_application_message
4344  0053 89            	pushw	x
4345  0054 ae0009        	ldw	x,#_topic_base
4346  0057 89            	pushw	x
4347  0058 ae005a        	ldw	x,#_mqttclient
4348  005b cd0000        	call	_mqtt_publish
4350  005e 5b07          	addw	sp,#7
4351                     ; 1305   if (direction == 'I') {
4353  0060 7b01          	ld	a,(OFST+1,sp)
4354  0062 a149          	cp	a,#73
4355  0064 2619          	jrne	L1732
4356                     ; 1307     if (IO_16to9 & mask) IO_16to9_sent |= mask;
4358  0066 c60103        	ld	a,_IO_16to9
4359  0069 1506          	bcp	a,(OFST+6,sp)
4360  006b 2707          	jreq	L3732
4363  006d c600fd        	ld	a,_IO_16to9_sent
4364  0070 1a06          	or	a,(OFST+6,sp)
4366  0072 2006          	jp	LC005
4367  0074               L3732:
4368                     ; 1308     else IO_16to9_sent &= (uint8_t)~mask;
4370  0074 7b06          	ld	a,(OFST+6,sp)
4371  0076 43            	cpl	a
4372  0077 c400fd        	and	a,_IO_16to9_sent
4373  007a               LC005:
4374  007a c700fd        	ld	_IO_16to9_sent,a
4375  007d 2017          	jra	L7732
4376  007f               L1732:
4377                     ; 1312     if (IO_8to1 & mask) IO_8to1_sent |= mask;
4379  007f c60102        	ld	a,_IO_8to1
4380  0082 1506          	bcp	a,(OFST+6,sp)
4381  0084 2707          	jreq	L1042
4384  0086 c600fc        	ld	a,_IO_8to1_sent
4385  0089 1a06          	or	a,(OFST+6,sp)
4387  008b 2006          	jp	LC004
4388  008d               L1042:
4389                     ; 1313     else IO_8to1_sent &= (uint8_t)~mask;
4391  008d 7b06          	ld	a,(OFST+6,sp)
4392  008f 43            	cpl	a
4393  0090 c400fc        	and	a,_IO_8to1_sent
4394  0093               LC004:
4395  0093 c700fc        	ld	_IO_8to1_sent,a
4396  0096               L7732:
4397                     ; 1315 }
4400  0096 85            	popw	x
4401  0097 81            	ret	
4450                     ; 1318 void publish_pinstate_all(void)
4450                     ; 1319 {
4451                     .text:	section	.text,new
4452  0000               _publish_pinstate_all:
4454  0000 89            	pushw	x
4455       00000002      OFST:	set	2
4458                     ; 1325   j = IO_16to9;
4460  0001 c60103        	ld	a,_IO_16to9
4461  0004 6b02          	ld	(OFST+0,sp),a
4463                     ; 1326   k = IO_8to1;
4465  0006 c60102        	ld	a,_IO_8to1
4466  0009 6b01          	ld	(OFST-1,sp),a
4468                     ; 1329   if (invert_input == 0xff) j = (uint8_t)(~j);
4470  000b c600fa        	ld	a,_invert_input
4471  000e 4c            	inc	a
4472  000f 2602          	jrne	L3242
4475  0011 0302          	cpl	(OFST+0,sp)
4477  0013               L3242:
4478                     ; 1331   application_message[0] = j;
4480  0013 7b02          	ld	a,(OFST+0,sp)
4481  0015 c70088        	ld	_application_message,a
4482                     ; 1332   application_message[1] = k;
4484  0018 7b01          	ld	a,(OFST-1,sp)
4485  001a c70089        	ld	_application_message+1,a
4486                     ; 1333   application_message[2] = '\0';
4488  001d 725f008a      	clr	_application_message+2
4489                     ; 1335   topic_base[topic_base_len] = '\0';
4491  0021 5f            	clrw	x
4492  0022 c60008        	ld	a,_topic_base_len
4493  0025 97            	ld	xl,a
4494  0026 724f0009      	clr	(_topic_base,x)
4495                     ; 1336   strcat(topic_base, "/state");
4497  002a ae000f        	ldw	x,#L5242
4498  002d 89            	pushw	x
4499  002e ae0009        	ldw	x,#_topic_base
4500  0031 cd0000        	call	_strcat
4502  0034 85            	popw	x
4503                     ; 1339   mqtt_publish(&mqttclient,
4503                     ; 1340                topic_base,
4503                     ; 1341 	       application_message,
4503                     ; 1342 	       2,
4503                     ; 1343 	       MQTT_PUBLISH_QOS_0);
4505  0035 4b00          	push	#0
4506  0037 ae0002        	ldw	x,#2
4507  003a 89            	pushw	x
4508  003b ae0088        	ldw	x,#_application_message
4509  003e 89            	pushw	x
4510  003f ae0009        	ldw	x,#_topic_base
4511  0042 89            	pushw	x
4512  0043 ae005a        	ldw	x,#_mqttclient
4513  0046 cd0000        	call	_mqtt_publish
4515                     ; 1344 }
4518  0049 5b09          	addw	sp,#9
4519  004b 81            	ret	
4544                     ; 1349 void unlock_eeprom(void)
4544                     ; 1350 {
4545                     .text:	section	.text,new
4546  0000               _unlock_eeprom:
4550  0000 2008          	jra	L1442
4551  0002               L7342:
4552                     ; 1362     FLASH_DUKR = 0xAE; // MASS key 1
4554  0002 35ae5064      	mov	_FLASH_DUKR,#174
4555                     ; 1363     FLASH_DUKR = 0x56; // MASS key 2
4557  0006 35565064      	mov	_FLASH_DUKR,#86
4558  000a               L1442:
4559                     ; 1361   while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
4561  000a 7207505ff3    	btjf	_FLASH_IAPSR,#3,L7342
4562                     ; 1391 }
4565  000f 81            	ret	
4650                     ; 1394 void check_eeprom_settings(void)
4650                     ; 1395 {
4651                     .text:	section	.text,new
4652  0000               _check_eeprom_settings:
4654  0000 88            	push	a
4655       00000001      OFST:	set	1
4658                     ; 1407   if ((magic4 == 0x55) && 
4658                     ; 1408       (magic3 == 0xee) && 
4658                     ; 1409       (magic2 == 0x0f) && 
4658                     ; 1410       (magic1 == 0xf0)) {
4660  0001 c6002e        	ld	a,_magic4
4661  0004 a155          	cp	a,#85
4662  0006 2703cc01af    	jrne	L1652
4664  000b c6002d        	ld	a,_magic3
4665  000e a1ee          	cp	a,#238
4666  0010 26f6          	jrne	L1652
4668  0012 c6002c        	ld	a,_magic2
4669  0015 a10f          	cp	a,#15
4670  0017 26ef          	jrne	L1652
4672  0019 c6002b        	ld	a,_magic1
4673  001c a1f0          	cp	a,#240
4674  001e 26e8          	jrne	L1652
4675                     ; 1415     uip_ipaddr(IpAddr, stored_hostaddr[3], stored_hostaddr[2], stored_hostaddr[1], stored_hostaddr[0]);
4677  0020 c6002a        	ld	a,_stored_hostaddr+3
4678  0023 97            	ld	xl,a
4679  0024 c60029        	ld	a,_stored_hostaddr+2
4680  0027 02            	rlwa	x,a
4681  0028 cf0094        	ldw	_IpAddr,x
4684  002b c60028        	ld	a,_stored_hostaddr+1
4685  002e 97            	ld	xl,a
4686  002f c60027        	ld	a,_stored_hostaddr
4687  0032 02            	rlwa	x,a
4688  0033 cf0096        	ldw	_IpAddr+2,x
4689                     ; 1416     uip_sethostaddr(IpAddr);
4691  0036 ce0094        	ldw	x,_IpAddr
4692  0039 cf0000        	ldw	_uip_hostaddr,x
4695  003c ce0096        	ldw	x,_IpAddr+2
4696  003f cf0002        	ldw	_uip_hostaddr+2,x
4697                     ; 1419     uip_ipaddr(IpAddr,
4699  0042 c60026        	ld	a,_stored_draddr+3
4700  0045 97            	ld	xl,a
4701  0046 c60025        	ld	a,_stored_draddr+2
4702  0049 02            	rlwa	x,a
4703  004a cf0094        	ldw	_IpAddr,x
4706  004d c60024        	ld	a,_stored_draddr+1
4707  0050 97            	ld	xl,a
4708  0051 c60023        	ld	a,_stored_draddr
4709  0054 02            	rlwa	x,a
4710  0055 cf0096        	ldw	_IpAddr+2,x
4711                     ; 1424     uip_setdraddr(IpAddr);
4713  0058 ce0094        	ldw	x,_IpAddr
4714  005b cf0000        	ldw	_uip_draddr,x
4717  005e ce0096        	ldw	x,_IpAddr+2
4718  0061 cf0002        	ldw	_uip_draddr+2,x
4719                     ; 1427     uip_ipaddr(IpAddr,
4721  0064 c60022        	ld	a,_stored_netmask+3
4722  0067 97            	ld	xl,a
4723  0068 c60021        	ld	a,_stored_netmask+2
4724  006b 02            	rlwa	x,a
4725  006c cf0094        	ldw	_IpAddr,x
4728  006f c60020        	ld	a,_stored_netmask+1
4729  0072 97            	ld	xl,a
4730  0073 c6001f        	ld	a,_stored_netmask
4731  0076 02            	rlwa	x,a
4732  0077 cf0096        	ldw	_IpAddr+2,x
4733                     ; 1432     uip_setnetmask(IpAddr);
4735  007a ce0094        	ldw	x,_IpAddr
4736  007d cf0000        	ldw	_uip_netmask,x
4739  0080 ce0096        	ldw	x,_IpAddr+2
4740  0083 cf0002        	ldw	_uip_netmask+2,x
4741                     ; 1436     uip_ipaddr(IpAddr,
4743  0086 c60034        	ld	a,_stored_mqttserveraddr+3
4744  0089 97            	ld	xl,a
4745  008a c60033        	ld	a,_stored_mqttserveraddr+2
4746  008d 02            	rlwa	x,a
4747  008e cf0094        	ldw	_IpAddr,x
4750  0091 c60032        	ld	a,_stored_mqttserveraddr+1
4751  0094 97            	ld	xl,a
4752  0095 c60031        	ld	a,_stored_mqttserveraddr
4753  0098 02            	rlwa	x,a
4754  0099 cf0096        	ldw	_IpAddr+2,x
4755                     ; 1441     uip_setmqttserveraddr(IpAddr);
4757  009c ce0094        	ldw	x,_IpAddr
4758  009f cf0000        	ldw	_uip_mqttserveraddr,x
4761  00a2 ce0096        	ldw	x,_IpAddr+2
4762  00a5 cf0002        	ldw	_uip_mqttserveraddr+2,x
4763                     ; 1443     Port_Mqttd = stored_mqttport;
4765  00a8 ce002f        	ldw	x,_stored_mqttport
4766  00ab cf008b        	ldw	_Port_Mqttd,x
4767                     ; 1447     Port_Httpd = stored_port;
4769  00ae ce001d        	ldw	x,_stored_port
4770  00b1 cf0098        	ldw	_Port_Httpd,x
4771                     ; 1452     uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
4773  00b4 55001c0000    	mov	_uip_ethaddr,_stored_uip_ethaddr_oct+5
4774                     ; 1453     uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
4776  00b9 55001b0001    	mov	_uip_ethaddr+1,_stored_uip_ethaddr_oct+4
4777                     ; 1454     uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
4779  00be 55001a0002    	mov	_uip_ethaddr+2,_stored_uip_ethaddr_oct+3
4780                     ; 1455     uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
4782  00c3 5500190003    	mov	_uip_ethaddr+3,_stored_uip_ethaddr_oct+2
4783                     ; 1456     uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
4785  00c8 5500180004    	mov	_uip_ethaddr+4,_stored_uip_ethaddr_oct+1
4786                     ; 1457     uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
4788  00cd 5500170005    	mov	_uip_ethaddr+5,_stored_uip_ethaddr_oct
4789                     ; 1461     if (stored_config_settings[0] != '0' && stored_config_settings[0] != '1') {
4791  00d2 c6004c        	ld	a,_stored_config_settings
4792  00d5 a130          	cp	a,#48
4793  00d7 270c          	jreq	L3252
4795  00d9 a131          	cp	a,#49
4796  00db 2708          	jreq	L3252
4797                     ; 1462       stored_config_settings[0] = '0';
4799  00dd a630          	ld	a,#48
4800  00df ae004c        	ldw	x,#_stored_config_settings
4801  00e2 cd0000        	call	c_eewrc
4803  00e5               L3252:
4804                     ; 1464     if (stored_config_settings[1] != '0' && stored_config_settings[1] != '1') {
4806  00e5 c6004d        	ld	a,_stored_config_settings+1
4807  00e8 a130          	cp	a,#48
4808  00ea 270c          	jreq	L5252
4810  00ec a131          	cp	a,#49
4811  00ee 2708          	jreq	L5252
4812                     ; 1465       stored_config_settings[1] = '0';
4814  00f0 a630          	ld	a,#48
4815  00f2 ae004d        	ldw	x,#_stored_config_settings+1
4816  00f5 cd0000        	call	c_eewrc
4818  00f8               L5252:
4819                     ; 1467     if (stored_config_settings[2] != '0' && stored_config_settings[2] != '1' && stored_config_settings[2] != '2') {
4821  00f8 c6004e        	ld	a,_stored_config_settings+2
4822  00fb a130          	cp	a,#48
4823  00fd 2710          	jreq	L7252
4825  00ff a131          	cp	a,#49
4826  0101 270c          	jreq	L7252
4828  0103 a132          	cp	a,#50
4829  0105 2708          	jreq	L7252
4830                     ; 1468       stored_config_settings[2] = '2';
4832  0107 a632          	ld	a,#50
4833  0109 ae004e        	ldw	x,#_stored_config_settings+2
4834  010c cd0000        	call	c_eewrc
4836  010f               L7252:
4837                     ; 1470     if (stored_config_settings[3] != '0' && stored_config_settings[3] != '1') {
4839  010f c6004f        	ld	a,_stored_config_settings+3
4840  0112 a130          	cp	a,#48
4841  0114 270c          	jreq	L1352
4843  0116 a131          	cp	a,#49
4844  0118 2708          	jreq	L1352
4845                     ; 1471       stored_config_settings[3] = '0';
4847  011a a630          	ld	a,#48
4848  011c ae004f        	ldw	x,#_stored_config_settings+3
4849  011f cd0000        	call	c_eewrc
4851  0122               L1352:
4852                     ; 1473     if (stored_config_settings[4] != '0') {
4854  0122 c60050        	ld	a,_stored_config_settings+4
4855  0125 a130          	cp	a,#48
4856  0127 2708          	jreq	L3352
4857                     ; 1474       stored_config_settings[4] = '0';
4859  0129 a630          	ld	a,#48
4860  012b ae0050        	ldw	x,#_stored_config_settings+4
4861  012e cd0000        	call	c_eewrc
4863  0131               L3352:
4864                     ; 1476     if (stored_config_settings[5] != '0') {
4866  0131 c60051        	ld	a,_stored_config_settings+5
4867  0134 a130          	cp	a,#48
4868  0136 2708          	jreq	L5352
4869                     ; 1477       stored_config_settings[5] = '0';
4871  0138 a630          	ld	a,#48
4872  013a ae0051        	ldw	x,#_stored_config_settings+5
4873  013d cd0000        	call	c_eewrc
4875  0140               L5352:
4876                     ; 1481     if (stored_config_settings[0] == '0') invert_output = 0x00;
4878  0140 c6004c        	ld	a,_stored_config_settings
4879  0143 a130          	cp	a,#48
4880  0145 2606          	jrne	L7352
4883  0147 725f00fb      	clr	_invert_output
4885  014b 2004          	jra	L1452
4886  014d               L7352:
4887                     ; 1482     else invert_output = 0xff;
4889  014d 35ff00fb      	mov	_invert_output,#255
4890  0151               L1452:
4891                     ; 1485     if (stored_config_settings[1] == '0') invert_input = 0x00;
4893  0151 c6004d        	ld	a,_stored_config_settings+1
4894  0154 a130          	cp	a,#48
4895  0156 2606          	jrne	L3452
4898  0158 725f00fa      	clr	_invert_input
4900  015c 2004          	jra	L5452
4901  015e               L3452:
4902                     ; 1486     else invert_input = 0xff;
4904  015e 35ff00fa      	mov	_invert_input,#255
4905  0162               L5452:
4906                     ; 1491     if (stored_config_settings[2] == '0') {
4908  0162 c6004e        	ld	a,_stored_config_settings+2
4909  0165 a130          	cp	a,#48
4910  0167 260a          	jrne	L7452
4911                     ; 1493       IO_16to9 = 0x00;
4913  0169 725f0103      	clr	_IO_16to9
4914                     ; 1494       IO_8to1 = 0x00;
4916  016d 725f0102      	clr	_IO_8to1
4918  0171 2036          	jra	L1552
4919  0173               L7452:
4920                     ; 1496     else if (stored_config_settings[2] == '1') {
4922  0173 a131          	cp	a,#49
4923  0175 260a          	jrne	L3552
4924                     ; 1498       IO_16to9 = 0xff;
4926  0177 35ff0103      	mov	_IO_16to9,#255
4927                     ; 1499       IO_8to1 = 0xff;
4929  017b 35ff0102      	mov	_IO_8to1,#255
4931  017f 2028          	jra	L1552
4932  0181               L3552:
4933                     ; 1503       IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9;
4935  0181 55004b00fd    	mov	_IO_16to9_sent,_stored_IO_16to9
4936  0186 5500fd00ff    	mov	_IO_16to9_new2,_IO_16to9_sent
4937  018b 5500ff0101    	mov	_IO_16to9_new1,_IO_16to9_new2
4938  0190 5501010103    	mov	_IO_16to9,_IO_16to9_new1
4939                     ; 1504       IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1;
4941  0195 55001400fc    	mov	_IO_8to1_sent,_stored_IO_8to1
4942  019a 5500fc00fe    	mov	_IO_8to1_new2,_IO_8to1_sent
4943  019f 5500fe0100    	mov	_IO_8to1_new1,_IO_8to1_new2
4944  01a4 5501000102    	mov	_IO_8to1,_IO_8to1_new1
4945  01a9               L1552:
4946                     ; 1508     write_output_registers();
4948  01a9 cd0000        	call	_write_output_registers
4951  01ac cc040e        	jra	L7552
4952  01af               L1652:
4953                     ; 1517     uip_ipaddr(IpAddr, 192,168,1,4);
4955  01af aec0a8        	ldw	x,#49320
4956  01b2 cf0094        	ldw	_IpAddr,x
4959  01b5 ae0104        	ldw	x,#260
4960  01b8 cf0096        	ldw	_IpAddr+2,x
4961                     ; 1518     uip_sethostaddr(IpAddr);
4963  01bb ce0094        	ldw	x,_IpAddr
4964  01be cf0000        	ldw	_uip_hostaddr,x
4967  01c1 ce0096        	ldw	x,_IpAddr+2
4968  01c4 cf0002        	ldw	_uip_hostaddr+2,x
4969                     ; 1520     stored_hostaddr[3] = 192;	// MSB
4971  01c7 a6c0          	ld	a,#192
4972  01c9 ae002a        	ldw	x,#_stored_hostaddr+3
4973  01cc cd0000        	call	c_eewrc
4975                     ; 1521     stored_hostaddr[2] = 168;	//
4977  01cf a6a8          	ld	a,#168
4978  01d1 ae0029        	ldw	x,#_stored_hostaddr+2
4979  01d4 cd0000        	call	c_eewrc
4981                     ; 1522     stored_hostaddr[1] = 1;	//
4983  01d7 a601          	ld	a,#1
4984  01d9 ae0028        	ldw	x,#_stored_hostaddr+1
4985  01dc cd0000        	call	c_eewrc
4987                     ; 1523     stored_hostaddr[0] = 4;	// LSB
4989  01df a604          	ld	a,#4
4990  01e1 ae0027        	ldw	x,#_stored_hostaddr
4991  01e4 cd0000        	call	c_eewrc
4993                     ; 1526     uip_ipaddr(IpAddr, 192,168,1,1);
4995  01e7 aec0a8        	ldw	x,#49320
4996  01ea cf0094        	ldw	_IpAddr,x
4999  01ed ae0101        	ldw	x,#257
5000  01f0 cf0096        	ldw	_IpAddr+2,x
5001                     ; 1527     uip_setdraddr(IpAddr);
5003  01f3 ce0094        	ldw	x,_IpAddr
5004  01f6 cf0000        	ldw	_uip_draddr,x
5007  01f9 ce0096        	ldw	x,_IpAddr+2
5008  01fc cf0002        	ldw	_uip_draddr+2,x
5009                     ; 1529     stored_draddr[3] = 192;	// MSB
5011  01ff a6c0          	ld	a,#192
5012  0201 ae0026        	ldw	x,#_stored_draddr+3
5013  0204 cd0000        	call	c_eewrc
5015                     ; 1530     stored_draddr[2] = 168;	//
5017  0207 a6a8          	ld	a,#168
5018  0209 ae0025        	ldw	x,#_stored_draddr+2
5019  020c cd0000        	call	c_eewrc
5021                     ; 1531     stored_draddr[1] = 1;		//
5023  020f a601          	ld	a,#1
5024  0211 ae0024        	ldw	x,#_stored_draddr+1
5025  0214 cd0000        	call	c_eewrc
5027                     ; 1532     stored_draddr[0] = 1;		// LSB
5029  0217 a601          	ld	a,#1
5030  0219 ae0023        	ldw	x,#_stored_draddr
5031  021c cd0000        	call	c_eewrc
5033                     ; 1535     uip_ipaddr(IpAddr, 255,255,255,0);
5035  021f aeffff        	ldw	x,#65535
5036  0222 cf0094        	ldw	_IpAddr,x
5039  0225 aeff00        	ldw	x,#65280
5040  0228 cf0096        	ldw	_IpAddr+2,x
5041                     ; 1536     uip_setnetmask(IpAddr);
5043  022b ce0094        	ldw	x,_IpAddr
5044  022e cf0000        	ldw	_uip_netmask,x
5047  0231 ce0096        	ldw	x,_IpAddr+2
5048  0234 cf0002        	ldw	_uip_netmask+2,x
5049                     ; 1538     stored_netmask[3] = 255;	// MSB
5051  0237 a6ff          	ld	a,#255
5052  0239 ae0022        	ldw	x,#_stored_netmask+3
5053  023c cd0000        	call	c_eewrc
5055                     ; 1539     stored_netmask[2] = 255;	//
5057  023f a6ff          	ld	a,#255
5058  0241 ae0021        	ldw	x,#_stored_netmask+2
5059  0244 cd0000        	call	c_eewrc
5061                     ; 1540     stored_netmask[1] = 255;	//
5063  0247 a6ff          	ld	a,#255
5064  0249 ae0020        	ldw	x,#_stored_netmask+1
5065  024c cd0000        	call	c_eewrc
5067                     ; 1541     stored_netmask[0] = 0;	// LSB
5069  024f 4f            	clr	a
5070  0250 ae001f        	ldw	x,#_stored_netmask
5071  0253 cd0000        	call	c_eewrc
5073                     ; 1545     uip_ipaddr(IpAddr, 0,0,0,0);
5075  0256 5f            	clrw	x
5076  0257 cf0094        	ldw	_IpAddr,x
5079  025a cf0096        	ldw	_IpAddr+2,x
5080                     ; 1546     uip_setmqttserveraddr(IpAddr);
5082  025d cf0000        	ldw	_uip_mqttserveraddr,x
5085  0260 cf0002        	ldw	_uip_mqttserveraddr+2,x
5086                     ; 1549     stored_mqttserveraddr[3] = 0;	// MSB
5088  0263 4f            	clr	a
5089  0264 ae0034        	ldw	x,#_stored_mqttserveraddr+3
5090  0267 cd0000        	call	c_eewrc
5092                     ; 1550     stored_mqttserveraddr[2] = 0;	//
5094  026a 4f            	clr	a
5095  026b ae0033        	ldw	x,#_stored_mqttserveraddr+2
5096  026e cd0000        	call	c_eewrc
5098                     ; 1551     stored_mqttserveraddr[1] = 0;	//
5100  0271 4f            	clr	a
5101  0272 ae0032        	ldw	x,#_stored_mqttserveraddr+1
5102  0275 cd0000        	call	c_eewrc
5104                     ; 1552     stored_mqttserveraddr[0] = 0;	// LSB
5106  0278 4f            	clr	a
5107  0279 ae0031        	ldw	x,#_stored_mqttserveraddr
5108  027c cd0000        	call	c_eewrc
5110                     ; 1555     stored_mqttport = 1883;		// Port
5112  027f ae075b        	ldw	x,#1883
5113  0282 89            	pushw	x
5114  0283 ae002f        	ldw	x,#_stored_mqttport
5115  0286 cd0000        	call	c_eewrw
5117  0289 85            	popw	x
5118                     ; 1557     Port_Mqttd = 1883;
5120  028a ae075b        	ldw	x,#1883
5121  028d cf008b        	ldw	_Port_Mqttd,x
5122                     ; 1560     for(i=0; i<11; i++) { stored_mqtt_username[i] = '\0'; }
5124  0290 4f            	clr	a
5125  0291 6b01          	ld	(OFST+0,sp),a
5127  0293               L1262:
5130  0293 5f            	clrw	x
5131  0294 97            	ld	xl,a
5132  0295 4f            	clr	a
5133  0296 1c0035        	addw	x,#_stored_mqtt_username
5134  0299 cd0000        	call	c_eewrc
5138  029c 0c01          	inc	(OFST+0,sp)
5142  029e 7b01          	ld	a,(OFST+0,sp)
5143  02a0 a10b          	cp	a,#11
5144  02a2 25ef          	jrult	L1262
5145                     ; 1561     for(i=0; i<11; i++) { stored_mqtt_password[i] = '\0'; }
5147  02a4 4f            	clr	a
5148  02a5 6b01          	ld	(OFST+0,sp),a
5150  02a7               L7262:
5153  02a7 5f            	clrw	x
5154  02a8 97            	ld	xl,a
5155  02a9 4f            	clr	a
5156  02aa 1c0040        	addw	x,#_stored_mqtt_password
5157  02ad cd0000        	call	c_eewrc
5161  02b0 0c01          	inc	(OFST+0,sp)
5165  02b2 7b01          	ld	a,(OFST+0,sp)
5166  02b4 a10b          	cp	a,#11
5167  02b6 25ef          	jrult	L7262
5168                     ; 1566     stored_port = 8080;
5170  02b8 ae1f90        	ldw	x,#8080
5171  02bb 89            	pushw	x
5172  02bc ae001d        	ldw	x,#_stored_port
5173  02bf cd0000        	call	c_eewrw
5175  02c2 85            	popw	x
5176                     ; 1568     Port_Httpd = 8080;
5178  02c3 ae1f90        	ldw	x,#8080
5179  02c6 cf0098        	ldw	_Port_Httpd,x
5180                     ; 1584     stored_uip_ethaddr_oct[5] = 0xc2;	//MAC MSB
5182  02c9 a6c2          	ld	a,#194
5183  02cb ae001c        	ldw	x,#_stored_uip_ethaddr_oct+5
5184  02ce cd0000        	call	c_eewrc
5186                     ; 1585     stored_uip_ethaddr_oct[4] = 0x4d;
5188  02d1 a64d          	ld	a,#77
5189  02d3 ae001b        	ldw	x,#_stored_uip_ethaddr_oct+4
5190  02d6 cd0000        	call	c_eewrc
5192                     ; 1586     stored_uip_ethaddr_oct[3] = 0x69;
5194  02d9 a669          	ld	a,#105
5195  02db ae001a        	ldw	x,#_stored_uip_ethaddr_oct+3
5196  02de cd0000        	call	c_eewrc
5198                     ; 1587     stored_uip_ethaddr_oct[2] = 0x6b;
5200  02e1 a66b          	ld	a,#107
5201  02e3 ae0019        	ldw	x,#_stored_uip_ethaddr_oct+2
5202  02e6 cd0000        	call	c_eewrc
5204                     ; 1588     stored_uip_ethaddr_oct[1] = 0x65;
5206  02e9 a665          	ld	a,#101
5207  02eb ae0018        	ldw	x,#_stored_uip_ethaddr_oct+1
5208  02ee cd0000        	call	c_eewrc
5210                     ; 1589     stored_uip_ethaddr_oct[0] = 0x00;	//MAC LSB
5212  02f1 4f            	clr	a
5213  02f2 ae0017        	ldw	x,#_stored_uip_ethaddr_oct
5214  02f5 cd0000        	call	c_eewrc
5216                     ; 1591     uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
5218  02f8 35c20000      	mov	_uip_ethaddr,#194
5219                     ; 1592     uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
5221  02fc 354d0001      	mov	_uip_ethaddr+1,#77
5222                     ; 1593     uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
5224  0300 35690002      	mov	_uip_ethaddr+2,#105
5225                     ; 1594     uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
5227  0304 356b0003      	mov	_uip_ethaddr+3,#107
5228                     ; 1595     uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
5230  0308 35650004      	mov	_uip_ethaddr+4,#101
5231                     ; 1596     uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
5233  030c 725f0005      	clr	_uip_ethaddr+5
5234                     ; 1599     stored_devicename[0] =  'N';
5236  0310 a64e          	ld	a,#78
5237  0312 ae0000        	ldw	x,#_stored_devicename
5238  0315 cd0000        	call	c_eewrc
5240                     ; 1600     stored_devicename[1] =  'e';
5242  0318 a665          	ld	a,#101
5243  031a ae0001        	ldw	x,#_stored_devicename+1
5244  031d cd0000        	call	c_eewrc
5246                     ; 1601     stored_devicename[2] =  'w';
5248  0320 a677          	ld	a,#119
5249  0322 ae0002        	ldw	x,#_stored_devicename+2
5250  0325 cd0000        	call	c_eewrc
5252                     ; 1602     stored_devicename[3] =  'D';
5254  0328 a644          	ld	a,#68
5255  032a ae0003        	ldw	x,#_stored_devicename+3
5256  032d cd0000        	call	c_eewrc
5258                     ; 1603     stored_devicename[4] =  'e';
5260  0330 a665          	ld	a,#101
5261  0332 ae0004        	ldw	x,#_stored_devicename+4
5262  0335 cd0000        	call	c_eewrc
5264                     ; 1604     stored_devicename[5] =  'v';
5266  0338 a676          	ld	a,#118
5267  033a ae0005        	ldw	x,#_stored_devicename+5
5268  033d cd0000        	call	c_eewrc
5270                     ; 1605     stored_devicename[6] =  'i';
5272  0340 a669          	ld	a,#105
5273  0342 ae0006        	ldw	x,#_stored_devicename+6
5274  0345 cd0000        	call	c_eewrc
5276                     ; 1606     stored_devicename[7] =  'c';
5278  0348 a663          	ld	a,#99
5279  034a ae0007        	ldw	x,#_stored_devicename+7
5280  034d cd0000        	call	c_eewrc
5282                     ; 1607     stored_devicename[8] =  'e';
5284  0350 a665          	ld	a,#101
5285  0352 ae0008        	ldw	x,#_stored_devicename+8
5286  0355 cd0000        	call	c_eewrc
5288                     ; 1608     stored_devicename[9] =  '0';
5290  0358 a630          	ld	a,#48
5291  035a ae0009        	ldw	x,#_stored_devicename+9
5292  035d cd0000        	call	c_eewrc
5294                     ; 1609     stored_devicename[10] = '0';
5296  0360 a630          	ld	a,#48
5297  0362 ae000a        	ldw	x,#_stored_devicename+10
5298  0365 cd0000        	call	c_eewrc
5300                     ; 1610     stored_devicename[11] = '0';
5302  0368 a630          	ld	a,#48
5303  036a ae000b        	ldw	x,#_stored_devicename+11
5304  036d cd0000        	call	c_eewrc
5306                     ; 1611     for (i=12; i<20; i++) stored_devicename[i] = '\0';
5308  0370 a60c          	ld	a,#12
5309  0372 6b01          	ld	(OFST+0,sp),a
5311  0374               L5362:
5314  0374 5f            	clrw	x
5315  0375 97            	ld	xl,a
5316  0376 4f            	clr	a
5317  0377 1c0000        	addw	x,#_stored_devicename
5318  037a cd0000        	call	c_eewrc
5322  037d 0c01          	inc	(OFST+0,sp)
5326  037f 7b01          	ld	a,(OFST+0,sp)
5327  0381 a114          	cp	a,#20
5328  0383 25ef          	jrult	L5362
5329                     ; 1616     stored_config_settings[0] = '0'; // Set to Invert Output OFF
5331  0385 a630          	ld	a,#48
5332  0387 ae004c        	ldw	x,#_stored_config_settings
5333  038a cd0000        	call	c_eewrc
5335                     ; 1617     stored_config_settings[1] = '0'; // Set to Invert Input Off
5337  038d a630          	ld	a,#48
5338  038f ae004d        	ldw	x,#_stored_config_settings+1
5339  0392 cd0000        	call	c_eewrc
5341                     ; 1618     stored_config_settings[2] = '2'; // Set to Retain pin states
5343  0395 a632          	ld	a,#50
5344  0397 ae004e        	ldw	x,#_stored_config_settings+2
5345  039a cd0000        	call	c_eewrc
5347                     ; 1619     stored_config_settings[3] = '0'; // Set to Half Duplex
5349  039d a630          	ld	a,#48
5350  039f ae004f        	ldw	x,#_stored_config_settings+3
5351  03a2 cd0000        	call	c_eewrc
5353                     ; 1620     stored_config_settings[4] = '0'; // undefined
5355  03a5 a630          	ld	a,#48
5356  03a7 ae0050        	ldw	x,#_stored_config_settings+4
5357  03aa cd0000        	call	c_eewrc
5359                     ; 1621     stored_config_settings[5] = '0'; // undefined
5361  03ad a630          	ld	a,#48
5362  03af ae0051        	ldw	x,#_stored_config_settings+5
5363  03b2 cd0000        	call	c_eewrc
5365                     ; 1622     invert_output = 0x00;			// Turn off output invert bit
5367  03b5 725f00fb      	clr	_invert_output
5368                     ; 1623     invert_input = 0x00;			// Turn off output invert bit
5370  03b9 725f00fa      	clr	_invert_input
5371                     ; 1624     IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9 = 0x00;
5373  03bd 4f            	clr	a
5374  03be ae004b        	ldw	x,#_stored_IO_16to9
5375  03c1 cd0000        	call	c_eewrc
5377  03c4 725f00fd      	clr	_IO_16to9_sent
5378  03c8 725f00ff      	clr	_IO_16to9_new2
5379  03cc 725f0101      	clr	_IO_16to9_new1
5380  03d0 725f0103      	clr	_IO_16to9
5381                     ; 1625     IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1  = 0x00;
5383  03d4 4f            	clr	a
5384  03d5 ae0014        	ldw	x,#_stored_IO_8to1
5385  03d8 cd0000        	call	c_eewrc
5387  03db 725f00fc      	clr	_IO_8to1_sent
5388  03df 725f00fe      	clr	_IO_8to1_new2
5389  03e3 725f0100      	clr	_IO_8to1_new1
5390  03e7 725f0102      	clr	_IO_8to1
5391                     ; 1626     write_output_registers();          // Set Relay Control outputs
5393  03eb cd0000        	call	_write_output_registers
5395                     ; 1629     magic4 = 0x55;		// MSB
5397  03ee a655          	ld	a,#85
5398  03f0 ae002e        	ldw	x,#_magic4
5399  03f3 cd0000        	call	c_eewrc
5401                     ; 1630     magic3 = 0xee;		//
5403  03f6 a6ee          	ld	a,#238
5404  03f8 ae002d        	ldw	x,#_magic3
5405  03fb cd0000        	call	c_eewrc
5407                     ; 1631     magic2 = 0x0f;		//
5409  03fe a60f          	ld	a,#15
5410  0400 ae002c        	ldw	x,#_magic2
5411  0403 cd0000        	call	c_eewrc
5413                     ; 1632     magic1 = 0xf0;		// LSB
5415  0406 a6f0          	ld	a,#240
5416  0408 ae002b        	ldw	x,#_magic1
5417  040b cd0000        	call	c_eewrc
5419  040e               L7552:
5420                     ; 1637   for (i=0; i<4; i++) {
5422  040e 4f            	clr	a
5423  040f 6b01          	ld	(OFST+0,sp),a
5425  0411               L3462:
5426                     ; 1638     Pending_hostaddr[i] = stored_hostaddr[i];
5428  0411 5f            	clrw	x
5429  0412 97            	ld	xl,a
5430  0413 d60027        	ld	a,(_stored_hostaddr,x)
5431  0416 d700d8        	ld	(_Pending_hostaddr,x),a
5432                     ; 1639     Pending_draddr[i] = stored_draddr[i];
5434  0419 5f            	clrw	x
5435  041a 7b01          	ld	a,(OFST+0,sp)
5436  041c 97            	ld	xl,a
5437  041d d60023        	ld	a,(_stored_draddr,x)
5438  0420 d700d4        	ld	(_Pending_draddr,x),a
5439                     ; 1640     Pending_netmask[i] = stored_netmask[i];
5441  0423 5f            	clrw	x
5442  0424 7b01          	ld	a,(OFST+0,sp)
5443  0426 97            	ld	xl,a
5444  0427 d6001f        	ld	a,(_stored_netmask,x)
5445  042a d700d0        	ld	(_Pending_netmask,x),a
5446                     ; 1637   for (i=0; i<4; i++) {
5448  042d 0c01          	inc	(OFST+0,sp)
5452  042f 7b01          	ld	a,(OFST+0,sp)
5453  0431 a104          	cp	a,#4
5454  0433 25dc          	jrult	L3462
5455                     ; 1643   Pending_port = stored_port;
5457  0435 ce001d        	ldw	x,_stored_port
5458  0438 cf00ce        	ldw	_Pending_port,x
5459                     ; 1645   for (i=0; i<20; i++) {
5461  043b 4f            	clr	a
5462  043c 6b01          	ld	(OFST+0,sp),a
5464  043e               L1562:
5465                     ; 1646     Pending_devicename[i] = stored_devicename[i];
5467  043e 5f            	clrw	x
5468  043f 97            	ld	xl,a
5469  0440 d60000        	ld	a,(_stored_devicename,x)
5470  0443 d700ba        	ld	(_Pending_devicename,x),a
5471                     ; 1645   for (i=0; i<20; i++) {
5473  0446 0c01          	inc	(OFST+0,sp)
5477  0448 7b01          	ld	a,(OFST+0,sp)
5478  044a a114          	cp	a,#20
5479  044c 25f0          	jrult	L1562
5480                     ; 1649   for (i=0; i<6; i++) {
5482  044e 4f            	clr	a
5483  044f 6b01          	ld	(OFST+0,sp),a
5485  0451               L7562:
5486                     ; 1650     Pending_config_settings[i] = stored_config_settings[i];
5488  0451 5f            	clrw	x
5489  0452 97            	ld	xl,a
5490  0453 d6004c        	ld	a,(_stored_config_settings,x)
5491  0456 d700b4        	ld	(_Pending_config_settings,x),a
5492                     ; 1651     Pending_uip_ethaddr_oct[i] = stored_uip_ethaddr_oct[i];
5494  0459 5f            	clrw	x
5495  045a 7b01          	ld	a,(OFST+0,sp)
5496  045c 97            	ld	xl,a
5497  045d d60017        	ld	a,(_stored_uip_ethaddr_oct,x)
5498  0460 d700ae        	ld	(_Pending_uip_ethaddr_oct,x),a
5499                     ; 1649   for (i=0; i<6; i++) {
5501  0463 0c01          	inc	(OFST+0,sp)
5505  0465 7b01          	ld	a,(OFST+0,sp)
5506  0467 a106          	cp	a,#6
5507  0469 25e6          	jrult	L7562
5508                     ; 1655   for (i=0; i<4; i++) {
5510  046b 4f            	clr	a
5511  046c 6b01          	ld	(OFST+0,sp),a
5513  046e               L5662:
5514                     ; 1656     Pending_mqttserveraddr[i] = stored_mqttserveraddr[i];
5516  046e 5f            	clrw	x
5517  046f 97            	ld	xl,a
5518  0470 d60031        	ld	a,(_stored_mqttserveraddr,x)
5519  0473 d700f4        	ld	(_Pending_mqttserveraddr,x),a
5520                     ; 1655   for (i=0; i<4; i++) {
5522  0476 0c01          	inc	(OFST+0,sp)
5526  0478 7b01          	ld	a,(OFST+0,sp)
5527  047a a104          	cp	a,#4
5528  047c 25f0          	jrult	L5662
5529                     ; 1658   Pending_mqttport = stored_mqttport;
5531  047e ce002f        	ldw	x,_stored_mqttport
5532  0481 cf00f2        	ldw	_Pending_mqttport,x
5533                     ; 1659   for (i=0; i<11; i++) {
5535  0484 4f            	clr	a
5536  0485 6b01          	ld	(OFST+0,sp),a
5538  0487               L3762:
5539                     ; 1660     Pending_mqtt_username[i] = stored_mqtt_username[i];
5541  0487 5f            	clrw	x
5542  0488 97            	ld	xl,a
5543  0489 d60035        	ld	a,(_stored_mqtt_username,x)
5544  048c d700e7        	ld	(_Pending_mqtt_username,x),a
5545                     ; 1661     Pending_mqtt_password[i] = stored_mqtt_password[i];
5547  048f 5f            	clrw	x
5548  0490 7b01          	ld	a,(OFST+0,sp)
5549  0492 97            	ld	xl,a
5550  0493 d60040        	ld	a,(_stored_mqtt_password,x)
5551  0496 d700dc        	ld	(_Pending_mqtt_password,x),a
5552                     ; 1659   for (i=0; i<11; i++) {
5554  0499 0c01          	inc	(OFST+0,sp)
5558  049b 7b01          	ld	a,(OFST+0,sp)
5559  049d a10b          	cp	a,#11
5560  049f 25e6          	jrult	L3762
5561                     ; 1664   strcat(topic_base, stored_devicename);
5563  04a1 ae0000        	ldw	x,#_stored_devicename
5564  04a4 89            	pushw	x
5565  04a5 ae0009        	ldw	x,#_topic_base
5566  04a8 cd0000        	call	_strcat
5568  04ab 85            	popw	x
5569                     ; 1667   topic_base_len = (uint8_t)strlen(topic_base);
5571  04ac ae0009        	ldw	x,#_topic_base
5572  04af cd0000        	call	_strlen
5574  04b2 9f            	ld	a,xl
5575  04b3 c70008        	ld	_topic_base_len,a
5576                     ; 1671   update_mac_string();
5578  04b6 cd0000        	call	_update_mac_string
5580                     ; 1673 }
5583  04b9 84            	pop	a
5584  04ba 81            	ret	
5627                     ; 1676 void update_mac_string(void) {
5628                     .text:	section	.text,new
5629  0000               _update_mac_string:
5631  0000 89            	pushw	x
5632       00000002      OFST:	set	2
5635                     ; 1682   i = 5;
5637  0001 a605          	ld	a,#5
5638  0003 6b01          	ld	(OFST-1,sp),a
5640                     ; 1683   j = 0;
5642  0005 0f02          	clr	(OFST+0,sp)
5644  0007               L7172:
5645                     ; 1685     emb_itoa(stored_uip_ethaddr_oct[i], OctetArray, 16, 2);
5647  0007 4b02          	push	#2
5648  0009 4b10          	push	#16
5649  000b ae0000        	ldw	x,#_OctetArray
5650  000e 89            	pushw	x
5651  000f 7b05          	ld	a,(OFST+3,sp)
5652  0011 5f            	clrw	x
5653  0012 97            	ld	xl,a
5654  0013 d60017        	ld	a,(_stored_uip_ethaddr_oct,x)
5655  0016 b703          	ld	c_lreg+3,a
5656  0018 3f02          	clr	c_lreg+2
5657  001a 3f01          	clr	c_lreg+1
5658  001c 3f00          	clr	c_lreg
5659  001e be02          	ldw	x,c_lreg+2
5660  0020 89            	pushw	x
5661  0021 be00          	ldw	x,c_lreg
5662  0023 89            	pushw	x
5663  0024 cd0000        	call	_emb_itoa
5665  0027 5b08          	addw	sp,#8
5666                     ; 1686     mac_string[j++] = OctetArray[0];
5668  0029 7b02          	ld	a,(OFST+0,sp)
5669  002b 0c02          	inc	(OFST+0,sp)
5671  002d 5f            	clrw	x
5672  002e 97            	ld	xl,a
5673  002f c60000        	ld	a,_OctetArray
5674  0032 d700a1        	ld	(_mac_string,x),a
5675                     ; 1687     mac_string[j++] = OctetArray[1];
5677  0035 7b02          	ld	a,(OFST+0,sp)
5678  0037 0c02          	inc	(OFST+0,sp)
5680  0039 5f            	clrw	x
5681  003a 97            	ld	xl,a
5682  003b c60001        	ld	a,_OctetArray+1
5683  003e d700a1        	ld	(_mac_string,x),a
5684                     ; 1688     i--;
5686  0041 0a01          	dec	(OFST-1,sp)
5688                     ; 1684   while (j<12) {
5690  0043 7b02          	ld	a,(OFST+0,sp)
5691  0045 a10c          	cp	a,#12
5692  0047 25be          	jrult	L7172
5693                     ; 1690   mac_string[12] = '\0';
5695  0049 725f00ad      	clr	_mac_string+12
5696                     ; 1691 }
5699  004d 85            	popw	x
5700  004e 81            	ret	
5778                     ; 1694 void check_runtime_changes(void)
5778                     ; 1695 {
5779                     .text:	section	.text,new
5780  0000               _check_runtime_changes:
5782  0000 88            	push	a
5783       00000001      OFST:	set	1
5786                     ; 1708   read_input_registers();
5788  0001 cd0000        	call	_read_input_registers
5790                     ; 1710   if (parse_complete == 1 || mqtt_parse_complete == 1) {
5792  0004 c6009b        	ld	a,_parse_complete
5793  0007 4a            	dec	a
5794  0008 2706          	jreq	L3472
5796  000a c6009a        	ld	a,_mqtt_parse_complete
5797  000d 4a            	dec	a
5798  000e 2624          	jrne	L1472
5799  0010               L3472:
5800                     ; 1734     if (stored_IO_8to1 != IO_8to1) {
5802  0010 c60014        	ld	a,_stored_IO_8to1
5803  0013 c10102        	cp	a,_IO_8to1
5804  0016 2713          	jreq	L5472
5805                     ; 1738       if (stored_config_settings[2] == '2') {
5807  0018 c6004e        	ld	a,_stored_config_settings+2
5808  001b a132          	cp	a,#50
5809  001d 2609          	jrne	L7472
5810                     ; 1739         stored_IO_8to1 = IO_8to1;
5812  001f c60102        	ld	a,_IO_8to1
5813  0022 ae0014        	ldw	x,#_stored_IO_8to1
5814  0025 cd0000        	call	c_eewrc
5816  0028               L7472:
5817                     ; 1743       write_output_registers();
5819  0028 cd0000        	call	_write_output_registers
5821  002b               L5472:
5822                     ; 1750     if (mqtt_parse_complete == 1) {
5824  002b c6009a        	ld	a,_mqtt_parse_complete
5825  002e 4a            	dec	a
5826  002f 2603          	jrne	L1472
5827                     ; 1752       mqtt_parse_complete = 0;
5829  0031 c7009a        	ld	_mqtt_parse_complete,a
5830  0034               L1472:
5831                     ; 1757   if (parse_complete == 1) {
5833  0034 c6009b        	ld	a,_parse_complete
5834  0037 4a            	dec	a
5835  0038 2703cc02c5    	jrne	L3572
5836                     ; 1798     if ((Pending_config_settings[0] != stored_config_settings[0])
5836                     ; 1799      || (stored_IO_8to1 != IO_8to1)) {
5838  003d c6004c        	ld	a,_stored_config_settings
5839  0040 c100b4        	cp	a,_Pending_config_settings
5840  0043 2608          	jrne	L7572
5842  0045 c60014        	ld	a,_stored_IO_8to1
5843  0048 c10102        	cp	a,_IO_8to1
5844  004b 272d          	jreq	L5572
5845  004d               L7572:
5846                     ; 1802       stored_config_settings[0] = Pending_config_settings[0];
5848  004d c600b4        	ld	a,_Pending_config_settings
5849  0050 ae004c        	ldw	x,#_stored_config_settings
5850  0053 cd0000        	call	c_eewrc
5852                     ; 1805       if (stored_config_settings[0] == '0') invert_output = 0x00;
5854  0056 c6004c        	ld	a,_stored_config_settings
5855  0059 a130          	cp	a,#48
5856  005b 2606          	jrne	L1672
5859  005d 725f00fb      	clr	_invert_output
5861  0061 2004          	jra	L3672
5862  0063               L1672:
5863                     ; 1806       else invert_output = 0xff;
5865  0063 35ff00fb      	mov	_invert_output,#255
5866  0067               L3672:
5867                     ; 1810       if (stored_config_settings[2] == '2') {
5869  0067 c6004e        	ld	a,_stored_config_settings+2
5870  006a a132          	cp	a,#50
5871  006c 2609          	jrne	L5672
5872                     ; 1811         stored_IO_8to1 = IO_8to1;
5874  006e c60102        	ld	a,_IO_8to1
5875  0071 ae0014        	ldw	x,#_stored_IO_8to1
5876  0074 cd0000        	call	c_eewrc
5878  0077               L5672:
5879                     ; 1815       write_output_registers();
5881  0077 cd0000        	call	_write_output_registers
5883  007a               L5572:
5884                     ; 1819     if (Pending_config_settings[1] != stored_config_settings[1]) {
5886  007a c6004d        	ld	a,_stored_config_settings+1
5887  007d c100b5        	cp	a,_Pending_config_settings+1
5888  0080 271e          	jreq	L7672
5889                     ; 1821       stored_config_settings[1] = Pending_config_settings[1];
5891  0082 c600b5        	ld	a,_Pending_config_settings+1
5892  0085 ae004d        	ldw	x,#_stored_config_settings+1
5893  0088 cd0000        	call	c_eewrc
5895                     ; 1824       if (stored_config_settings[1] == '0') invert_input = 0x00;
5897  008b c6004d        	ld	a,_stored_config_settings+1
5898  008e a130          	cp	a,#48
5899  0090 2606          	jrne	L1772
5902  0092 725f00fa      	clr	_invert_input
5904  0096 2004          	jra	L3772
5905  0098               L1772:
5906                     ; 1825       else invert_input = 0xff;
5908  0098 35ff00fa      	mov	_invert_input,#255
5909  009c               L3772:
5910                     ; 1829       restart_request = 1;
5912  009c 3501009e      	mov	_restart_request,#1
5913  00a0               L7672:
5914                     ; 1863     if (Pending_config_settings[2] != stored_config_settings[2]) {
5916  00a0 c6004e        	ld	a,_stored_config_settings+2
5917  00a3 c100b6        	cp	a,_Pending_config_settings+2
5918  00a6 2709          	jreq	L5772
5919                     ; 1865       stored_config_settings[2] = Pending_config_settings[2];
5921  00a8 c600b6        	ld	a,_Pending_config_settings+2
5922  00ab ae004e        	ldw	x,#_stored_config_settings+2
5923  00ae cd0000        	call	c_eewrc
5925  00b1               L5772:
5926                     ; 1869     if (Pending_config_settings[3] != stored_config_settings[3]) {
5928  00b1 c6004f        	ld	a,_stored_config_settings+3
5929  00b4 c100b7        	cp	a,_Pending_config_settings+3
5930  00b7 270d          	jreq	L7772
5931                     ; 1872       stored_config_settings[3] = Pending_config_settings[3];
5933  00b9 c600b7        	ld	a,_Pending_config_settings+3
5934  00bc ae004f        	ldw	x,#_stored_config_settings+3
5935  00bf cd0000        	call	c_eewrc
5937                     ; 1874       user_reboot_request = 1;
5939  00c2 3501009f      	mov	_user_reboot_request,#1
5940  00c6               L7772:
5941                     ; 1877     stored_config_settings[4] = Pending_config_settings[4];
5943  00c6 c600b8        	ld	a,_Pending_config_settings+4
5944  00c9 ae0050        	ldw	x,#_stored_config_settings+4
5945  00cc cd0000        	call	c_eewrc
5947                     ; 1878     stored_config_settings[5] = Pending_config_settings[5];
5949  00cf c600b9        	ld	a,_Pending_config_settings+5
5950  00d2 ae0051        	ldw	x,#_stored_config_settings+5
5951  00d5 cd0000        	call	c_eewrc
5953                     ; 1881     if (stored_hostaddr[3] != Pending_hostaddr[3] ||
5953                     ; 1882         stored_hostaddr[2] != Pending_hostaddr[2] ||
5953                     ; 1883         stored_hostaddr[1] != Pending_hostaddr[1] ||
5953                     ; 1884         stored_hostaddr[0] != Pending_hostaddr[0]) {
5955  00d8 c6002a        	ld	a,_stored_hostaddr+3
5956  00db c100db        	cp	a,_Pending_hostaddr+3
5957  00de 2618          	jrne	L3003
5959  00e0 c60029        	ld	a,_stored_hostaddr+2
5960  00e3 c100da        	cp	a,_Pending_hostaddr+2
5961  00e6 2610          	jrne	L3003
5963  00e8 c60028        	ld	a,_stored_hostaddr+1
5964  00eb c100d9        	cp	a,_Pending_hostaddr+1
5965  00ee 2608          	jrne	L3003
5967  00f0 c60027        	ld	a,_stored_hostaddr
5968  00f3 c100d8        	cp	a,_Pending_hostaddr
5969  00f6 2713          	jreq	L1003
5970  00f8               L3003:
5971                     ; 1886       for (i=0; i<4; i++) stored_hostaddr[i] = Pending_hostaddr[i];
5973  00f8 4f            	clr	a
5974  00f9 6b01          	ld	(OFST+0,sp),a
5976  00fb               L1103:
5979  00fb 5f            	clrw	x
5980  00fc 97            	ld	xl,a
5981  00fd d600d8        	ld	a,(_Pending_hostaddr,x)
5982  0100 d70027        	ld	(_stored_hostaddr,x),a
5985  0103 0c01          	inc	(OFST+0,sp)
5989  0105 7b01          	ld	a,(OFST+0,sp)
5990  0107 a104          	cp	a,#4
5991  0109 25f0          	jrult	L1103
5992  010b               L1003:
5993                     ; 1890     if (stored_draddr[3] != Pending_draddr[3] ||
5993                     ; 1891         stored_draddr[2] != Pending_draddr[2] ||
5993                     ; 1892         stored_draddr[1] != Pending_draddr[1] ||
5993                     ; 1893         stored_draddr[0] != Pending_draddr[0]) {
5995  010b c60026        	ld	a,_stored_draddr+3
5996  010e c100d7        	cp	a,_Pending_draddr+3
5997  0111 2618          	jrne	L1203
5999  0113 c60025        	ld	a,_stored_draddr+2
6000  0116 c100d6        	cp	a,_Pending_draddr+2
6001  0119 2610          	jrne	L1203
6003  011b c60024        	ld	a,_stored_draddr+1
6004  011e c100d5        	cp	a,_Pending_draddr+1
6005  0121 2608          	jrne	L1203
6007  0123 c60023        	ld	a,_stored_draddr
6008  0126 c100d4        	cp	a,_Pending_draddr
6009  0129 2717          	jreq	L7103
6010  012b               L1203:
6011                     ; 1895       for (i=0; i<4; i++) stored_draddr[i] = Pending_draddr[i];
6013  012b 4f            	clr	a
6014  012c 6b01          	ld	(OFST+0,sp),a
6016  012e               L7203:
6019  012e 5f            	clrw	x
6020  012f 97            	ld	xl,a
6021  0130 d600d4        	ld	a,(_Pending_draddr,x)
6022  0133 d70023        	ld	(_stored_draddr,x),a
6025  0136 0c01          	inc	(OFST+0,sp)
6029  0138 7b01          	ld	a,(OFST+0,sp)
6030  013a a104          	cp	a,#4
6031  013c 25f0          	jrult	L7203
6032                     ; 1896       restart_request = 1;
6034  013e 3501009e      	mov	_restart_request,#1
6035  0142               L7103:
6036                     ; 1900     if (stored_netmask[3] != Pending_netmask[3] ||
6036                     ; 1901         stored_netmask[2] != Pending_netmask[2] ||
6036                     ; 1902         stored_netmask[1] != Pending_netmask[1] ||
6036                     ; 1903         stored_netmask[0] != Pending_netmask[0]) {
6038  0142 c60022        	ld	a,_stored_netmask+3
6039  0145 c100d3        	cp	a,_Pending_netmask+3
6040  0148 2618          	jrne	L7303
6042  014a c60021        	ld	a,_stored_netmask+2
6043  014d c100d2        	cp	a,_Pending_netmask+2
6044  0150 2610          	jrne	L7303
6046  0152 c60020        	ld	a,_stored_netmask+1
6047  0155 c100d1        	cp	a,_Pending_netmask+1
6048  0158 2608          	jrne	L7303
6050  015a c6001f        	ld	a,_stored_netmask
6051  015d c100d0        	cp	a,_Pending_netmask
6052  0160 2717          	jreq	L5303
6053  0162               L7303:
6054                     ; 1905       for (i=0; i<4; i++) stored_netmask[i] = Pending_netmask[i];
6056  0162 4f            	clr	a
6057  0163 6b01          	ld	(OFST+0,sp),a
6059  0165               L5403:
6062  0165 5f            	clrw	x
6063  0166 97            	ld	xl,a
6064  0167 d600d0        	ld	a,(_Pending_netmask,x)
6065  016a d7001f        	ld	(_stored_netmask,x),a
6068  016d 0c01          	inc	(OFST+0,sp)
6072  016f 7b01          	ld	a,(OFST+0,sp)
6073  0171 a104          	cp	a,#4
6074  0173 25f0          	jrult	L5403
6075                     ; 1906       restart_request = 1;
6077  0175 3501009e      	mov	_restart_request,#1
6078  0179               L5303:
6079                     ; 1910     if (stored_port != Pending_port) {
6081  0179 ce001d        	ldw	x,_stored_port
6082  017c c300ce        	cpw	x,_Pending_port
6083  017f 270f          	jreq	L3503
6084                     ; 1912       stored_port = Pending_port;
6086  0181 ce00ce        	ldw	x,_Pending_port
6087  0184 89            	pushw	x
6088  0185 ae001d        	ldw	x,#_stored_port
6089  0188 cd0000        	call	c_eewrw
6091  018b 3501009e      	mov	_restart_request,#1
6092  018f 85            	popw	x
6093                     ; 1914       restart_request = 1;
6095  0190               L3503:
6096                     ; 1918     for(i=0; i<20; i++) {
6098  0190 4f            	clr	a
6099  0191 6b01          	ld	(OFST+0,sp),a
6101  0193               L5503:
6102                     ; 1919       if (stored_devicename[i] != Pending_devicename[i]) {
6104  0193 5f            	clrw	x
6105  0194 97            	ld	xl,a
6106  0195 905f          	clrw	y
6107  0197 9097          	ld	yl,a
6108  0199 90d60000      	ld	a,(_stored_devicename,y)
6109  019d d100ba        	cp	a,(_Pending_devicename,x)
6110  01a0 270e          	jreq	L3603
6111                     ; 1920         stored_devicename[i] = Pending_devicename[i];
6113  01a2 7b01          	ld	a,(OFST+0,sp)
6114  01a4 5f            	clrw	x
6115  01a5 97            	ld	xl,a
6116  01a6 d600ba        	ld	a,(_Pending_devicename,x)
6117  01a9 d70000        	ld	(_stored_devicename,x),a
6118                     ; 1926         restart_request = 1;
6120  01ac 3501009e      	mov	_restart_request,#1
6121  01b0               L3603:
6122                     ; 1918     for(i=0; i<20; i++) {
6124  01b0 0c01          	inc	(OFST+0,sp)
6128  01b2 7b01          	ld	a,(OFST+0,sp)
6129  01b4 a114          	cp	a,#20
6130  01b6 25db          	jrult	L5503
6131                     ; 1933     strcpy(topic_base, devicetype);
6133  01b8 ae0009        	ldw	x,#_topic_base
6134  01bb 90ae0000      	ldw	y,#L5261_devicetype
6135  01bf               L403:
6136  01bf 90f6          	ld	a,(y)
6137  01c1 905c          	incw	y
6138  01c3 f7            	ld	(x),a
6139  01c4 5c            	incw	x
6140  01c5 4d            	tnz	a
6141  01c6 26f7          	jrne	L403
6142                     ; 1934     strcat(topic_base, stored_devicename);
6144  01c8 ae0000        	ldw	x,#_stored_devicename
6145  01cb 89            	pushw	x
6146  01cc ae0009        	ldw	x,#_topic_base
6147  01cf cd0000        	call	_strcat
6149  01d2 85            	popw	x
6150                     ; 1935     topic_base_len = (uint8_t)strlen(topic_base);
6152  01d3 ae0009        	ldw	x,#_topic_base
6153  01d6 cd0000        	call	_strlen
6155  01d9 9f            	ld	a,xl
6156  01da c70008        	ld	_topic_base_len,a
6157                     ; 1938     if (stored_mqttserveraddr[3] != Pending_mqttserveraddr[3] ||
6157                     ; 1939         stored_mqttserveraddr[2] != Pending_mqttserveraddr[2] ||
6157                     ; 1940         stored_mqttserveraddr[1] != Pending_mqttserveraddr[1] ||
6157                     ; 1941         stored_mqttserveraddr[0] != Pending_mqttserveraddr[0]) {
6159  01dd c60034        	ld	a,_stored_mqttserveraddr+3
6160  01e0 c100f7        	cp	a,_Pending_mqttserveraddr+3
6161  01e3 2618          	jrne	L7603
6163  01e5 c60033        	ld	a,_stored_mqttserveraddr+2
6164  01e8 c100f6        	cp	a,_Pending_mqttserveraddr+2
6165  01eb 2610          	jrne	L7603
6167  01ed c60032        	ld	a,_stored_mqttserveraddr+1
6168  01f0 c100f5        	cp	a,_Pending_mqttserveraddr+1
6169  01f3 2608          	jrne	L7603
6171  01f5 c60031        	ld	a,_stored_mqttserveraddr
6172  01f8 c100f4        	cp	a,_Pending_mqttserveraddr
6173  01fb 2717          	jreq	L5603
6174  01fd               L7603:
6175                     ; 1943       for (i=0; i<4; i++) stored_mqttserveraddr[i] = Pending_mqttserveraddr[i];
6177  01fd 4f            	clr	a
6178  01fe 6b01          	ld	(OFST+0,sp),a
6180  0200               L5703:
6183  0200 5f            	clrw	x
6184  0201 97            	ld	xl,a
6185  0202 d600f4        	ld	a,(_Pending_mqttserveraddr,x)
6186  0205 d70031        	ld	(_stored_mqttserveraddr,x),a
6189  0208 0c01          	inc	(OFST+0,sp)
6193  020a 7b01          	ld	a,(OFST+0,sp)
6194  020c a104          	cp	a,#4
6195  020e 25f0          	jrult	L5703
6196                     ; 1945       restart_request = 1;
6198  0210 3501009e      	mov	_restart_request,#1
6199  0214               L5603:
6200                     ; 1949     if (stored_mqttport != Pending_mqttport) {
6202  0214 ce002f        	ldw	x,_stored_mqttport
6203  0217 c300f2        	cpw	x,_Pending_mqttport
6204  021a 270f          	jreq	L3013
6205                     ; 1951       stored_mqttport = Pending_mqttport;
6207  021c ce00f2        	ldw	x,_Pending_mqttport
6208  021f 89            	pushw	x
6209  0220 ae002f        	ldw	x,#_stored_mqttport
6210  0223 cd0000        	call	c_eewrw
6212  0226 3501009e      	mov	_restart_request,#1
6213  022a 85            	popw	x
6214                     ; 1953       restart_request = 1;
6216  022b               L3013:
6217                     ; 1957     for(i=0; i<11; i++) {
6219  022b 4f            	clr	a
6220  022c 6b01          	ld	(OFST+0,sp),a
6222  022e               L5013:
6223                     ; 1958       if (stored_mqtt_username[i] != Pending_mqtt_username[i]) {
6225  022e 5f            	clrw	x
6226  022f 97            	ld	xl,a
6227  0230 905f          	clrw	y
6228  0232 9097          	ld	yl,a
6229  0234 90d60035      	ld	a,(_stored_mqtt_username,y)
6230  0238 d100e7        	cp	a,(_Pending_mqtt_username,x)
6231  023b 270e          	jreq	L3113
6232                     ; 1959         stored_mqtt_username[i] = Pending_mqtt_username[i];
6234  023d 7b01          	ld	a,(OFST+0,sp)
6235  023f 5f            	clrw	x
6236  0240 97            	ld	xl,a
6237  0241 d600e7        	ld	a,(_Pending_mqtt_username,x)
6238  0244 d70035        	ld	(_stored_mqtt_username,x),a
6239                     ; 1961         restart_request = 1;
6241  0247 3501009e      	mov	_restart_request,#1
6242  024b               L3113:
6243                     ; 1957     for(i=0; i<11; i++) {
6245  024b 0c01          	inc	(OFST+0,sp)
6249  024d 7b01          	ld	a,(OFST+0,sp)
6250  024f a10b          	cp	a,#11
6251  0251 25db          	jrult	L5013
6252                     ; 1966     for(i=0; i<11; i++) {
6254  0253 4f            	clr	a
6255  0254 6b01          	ld	(OFST+0,sp),a
6257  0256               L5113:
6258                     ; 1967       if (stored_mqtt_password[i] != Pending_mqtt_password[i]) {
6260  0256 5f            	clrw	x
6261  0257 97            	ld	xl,a
6262  0258 905f          	clrw	y
6263  025a 9097          	ld	yl,a
6264  025c 90d60040      	ld	a,(_stored_mqtt_password,y)
6265  0260 d100dc        	cp	a,(_Pending_mqtt_password,x)
6266  0263 270e          	jreq	L3213
6267                     ; 1968         stored_mqtt_password[i] = Pending_mqtt_password[i];
6269  0265 7b01          	ld	a,(OFST+0,sp)
6270  0267 5f            	clrw	x
6271  0268 97            	ld	xl,a
6272  0269 d600dc        	ld	a,(_Pending_mqtt_password,x)
6273  026c d70040        	ld	(_stored_mqtt_password,x),a
6274                     ; 1970         restart_request = 1;
6276  026f 3501009e      	mov	_restart_request,#1
6277  0273               L3213:
6278                     ; 1966     for(i=0; i<11; i++) {
6280  0273 0c01          	inc	(OFST+0,sp)
6284  0275 7b01          	ld	a,(OFST+0,sp)
6285  0277 a10b          	cp	a,#11
6286  0279 25db          	jrult	L5113
6287                     ; 1976     if (stored_uip_ethaddr_oct[0] != Pending_uip_ethaddr_oct[0] ||
6287                     ; 1977       stored_uip_ethaddr_oct[1] != Pending_uip_ethaddr_oct[1] ||
6287                     ; 1978       stored_uip_ethaddr_oct[2] != Pending_uip_ethaddr_oct[2] ||
6287                     ; 1979       stored_uip_ethaddr_oct[3] != Pending_uip_ethaddr_oct[3] ||
6287                     ; 1980       stored_uip_ethaddr_oct[4] != Pending_uip_ethaddr_oct[4] ||
6287                     ; 1981       stored_uip_ethaddr_oct[5] != Pending_uip_ethaddr_oct[5]) {
6289  027b c60017        	ld	a,_stored_uip_ethaddr_oct
6290  027e c100ae        	cp	a,_Pending_uip_ethaddr_oct
6291  0281 2628          	jrne	L7213
6293  0283 c60018        	ld	a,_stored_uip_ethaddr_oct+1
6294  0286 c100af        	cp	a,_Pending_uip_ethaddr_oct+1
6295  0289 2620          	jrne	L7213
6297  028b c60019        	ld	a,_stored_uip_ethaddr_oct+2
6298  028e c100b0        	cp	a,_Pending_uip_ethaddr_oct+2
6299  0291 2618          	jrne	L7213
6301  0293 c6001a        	ld	a,_stored_uip_ethaddr_oct+3
6302  0296 c100b1        	cp	a,_Pending_uip_ethaddr_oct+3
6303  0299 2610          	jrne	L7213
6305  029b c6001b        	ld	a,_stored_uip_ethaddr_oct+4
6306  029e c100b2        	cp	a,_Pending_uip_ethaddr_oct+4
6307  02a1 2608          	jrne	L7213
6309  02a3 c6001c        	ld	a,_stored_uip_ethaddr_oct+5
6310  02a6 c100b3        	cp	a,_Pending_uip_ethaddr_oct+5
6311  02a9 271a          	jreq	L3572
6312  02ab               L7213:
6313                     ; 1983       for (i=0; i<6; i++) stored_uip_ethaddr_oct[i] = Pending_uip_ethaddr_oct[i];
6315  02ab 4f            	clr	a
6316  02ac 6b01          	ld	(OFST+0,sp),a
6318  02ae               L1413:
6321  02ae 5f            	clrw	x
6322  02af 97            	ld	xl,a
6323  02b0 d600ae        	ld	a,(_Pending_uip_ethaddr_oct,x)
6324  02b3 d70017        	ld	(_stored_uip_ethaddr_oct,x),a
6327  02b6 0c01          	inc	(OFST+0,sp)
6331  02b8 7b01          	ld	a,(OFST+0,sp)
6332  02ba a106          	cp	a,#6
6333  02bc 25f0          	jrult	L1413
6334                     ; 1985       update_mac_string();
6336  02be cd0000        	call	_update_mac_string
6338                     ; 1987       restart_request = 1;
6340  02c1 3501009e      	mov	_restart_request,#1
6341  02c5               L3572:
6342                     ; 1991   if (restart_request == 1) {
6344  02c5 c6009e        	ld	a,_restart_request
6345  02c8 4a            	dec	a
6346  02c9 2609          	jrne	L7413
6347                     ; 1994     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
6349  02cb c6009d        	ld	a,_restart_reboot_step
6350  02ce 2604          	jrne	L7413
6351                     ; 1995       restart_reboot_step = RESTART_REBOOT_ARM;
6353  02d0 3501009d      	mov	_restart_reboot_step,#1
6354  02d4               L7413:
6355                     ; 1999   if (user_reboot_request == 1) {
6357  02d4 c6009f        	ld	a,_user_reboot_request
6358  02d7 4a            	dec	a
6359  02d8 2611          	jrne	L3513
6360                     ; 2002     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
6362  02da 725d009d      	tnz	_restart_reboot_step
6363  02de 260b          	jrne	L3513
6364                     ; 2003       restart_reboot_step = RESTART_REBOOT_ARM;
6366  02e0 3501009d      	mov	_restart_reboot_step,#1
6367                     ; 2004       user_reboot_request = 0;
6369  02e4 c7009f        	ld	_user_reboot_request,a
6370                     ; 2005       reboot_request = 1;
6372  02e7 350100a0      	mov	_reboot_request,#1
6373  02eb               L3513:
6374                     ; 2014   parse_complete = 0; // Reset parse_complete for future changes
6376  02eb 725f009b      	clr	_parse_complete
6377                     ; 2017   if (stack_limit1 != 0xaa || stack_limit2 != 0x55) {
6379  02ef c60001        	ld	a,_stack_limit1
6380  02f2 a1aa          	cp	a,#170
6381  02f4 2607          	jrne	L1613
6383  02f6 c60000        	ld	a,_stack_limit2
6384  02f9 a155          	cp	a,#85
6385  02fb 270a          	jreq	L7513
6386  02fd               L1613:
6387                     ; 2018     stack_error = 1;
6389  02fd 350100f8      	mov	_stack_error,#1
6390                     ; 2019     fastflash();
6392  0301 cd0000        	call	_fastflash
6394                     ; 2020     fastflash();
6396  0304 cd0000        	call	_fastflash
6398  0307               L7513:
6399                     ; 2033 }
6402  0307 84            	pop	a
6403  0308 81            	ret	
6438                     ; 2036 void check_restart_reboot(void)
6438                     ; 2037 {
6439                     .text:	section	.text,new
6440  0000               _check_restart_reboot:
6444                     ; 2043   if (restart_request == 1 || reboot_request == 1) {
6446  0000 c6009e        	ld	a,_restart_request
6447  0003 4a            	dec	a
6448  0004 2709          	jreq	L5713
6450  0006 c600a0        	ld	a,_reboot_request
6451  0009 4a            	dec	a
6452  000a 2703cc00d4    	jrne	L3713
6453  000f               L5713:
6454                     ; 2054     if (restart_reboot_step == RESTART_REBOOT_ARM) {
6456  000f c6009d        	ld	a,_restart_reboot_step
6457  0012 a101          	cp	a,#1
6458  0014 2611          	jrne	L7713
6459                     ; 2059       time_mark2 = second_counter;
6461  0016 ce0002        	ldw	x,_second_counter+2
6462  0019 cf0092        	ldw	_time_mark2+2,x
6463  001c ce0000        	ldw	x,_second_counter
6464  001f cf0090        	ldw	_time_mark2,x
6465                     ; 2060       restart_reboot_step = RESTART_REBOOT_ARM2;
6467  0022 3502009d      	mov	_restart_reboot_step,#2
6470  0026 81            	ret	
6471  0027               L7713:
6472                     ; 2063     else if (restart_reboot_step == RESTART_REBOOT_ARM2) {
6474  0027 a102          	cp	a,#2
6475  0029 2613          	jrne	L3023
6476                     ; 2069       if (second_counter > time_mark2 + 0 ) {
6478  002b ae0000        	ldw	x,#_second_counter
6479  002e cd0000        	call	c_ltor
6481  0031 ae0090        	ldw	x,#_time_mark2
6482  0034 cd0000        	call	c_lcmp
6484  0037 23d3          	jrule	L3713
6485                     ; 2070         restart_reboot_step = RESTART_REBOOT_DISCONNECT;
6487  0039 3503009d      	mov	_restart_reboot_step,#3
6489  003d 81            	ret	
6490  003e               L3023:
6491                     ; 2075     else if (restart_reboot_step == RESTART_REBOOT_DISCONNECT) {
6493  003e a103          	cp	a,#3
6494  0040 261e          	jrne	L1123
6495                     ; 2076       restart_reboot_step = RESTART_REBOOT_DISCONNECTWAIT;
6497  0042 3504009d      	mov	_restart_reboot_step,#4
6498                     ; 2077       if (mqtt_start == MQTT_START_COMPLETE) {
6500  0046 c6003d        	ld	a,_mqtt_start
6501  0049 a114          	cp	a,#20
6502  004b 2606          	jrne	L3123
6503                     ; 2079         mqtt_disconnect(&mqttclient);
6505  004d ae005a        	ldw	x,#_mqttclient
6506  0050 cd0000        	call	_mqtt_disconnect
6508  0053               L3123:
6509                     ; 2082       time_mark2 = second_counter;
6511  0053 ce0002        	ldw	x,_second_counter+2
6512  0056 cf0092        	ldw	_time_mark2+2,x
6513  0059 ce0000        	ldw	x,_second_counter
6514  005c cf0090        	ldw	_time_mark2,x
6517  005f 81            	ret	
6518  0060               L1123:
6519                     ; 2085     else if (restart_reboot_step == RESTART_REBOOT_DISCONNECTWAIT) {
6521  0060 a104          	cp	a,#4
6522  0062 2618          	jrne	L7123
6523                     ; 2086       if (second_counter > time_mark2 + 1 ) {
6525  0064 ae0090        	ldw	x,#_time_mark2
6526  0067 cd0000        	call	c_ltor
6528  006a a601          	ld	a,#1
6529  006c cd0000        	call	c_ladc
6531  006f ae0000        	ldw	x,#_second_counter
6532  0072 cd0000        	call	c_lcmp
6534  0075 245d          	jruge	L3713
6535                     ; 2089         restart_reboot_step = RESTART_REBOOT_TCPCLOSE;
6537  0077 3505009d      	mov	_restart_reboot_step,#5
6539  007b 81            	ret	
6540  007c               L7123:
6541                     ; 2093     else if (restart_reboot_step == RESTART_REBOOT_TCPCLOSE) {
6543  007c a105          	cp	a,#5
6544  007e 2615          	jrne	L5223
6545                     ; 2109       mqtt_close_tcp = 1;
6547  0080 3501009c      	mov	_mqtt_close_tcp,#1
6548                     ; 2111       time_mark2 = second_counter;
6550  0084 ce0002        	ldw	x,_second_counter+2
6551  0087 cf0092        	ldw	_time_mark2+2,x
6552  008a ce0000        	ldw	x,_second_counter
6553  008d cf0090        	ldw	_time_mark2,x
6554                     ; 2112       restart_reboot_step = RESTART_REBOOT_TCPWAIT;
6556  0090 3506009d      	mov	_restart_reboot_step,#6
6559  0094 81            	ret	
6560  0095               L5223:
6561                     ; 2114     else if (restart_reboot_step == RESTART_REBOOT_TCPWAIT) {
6563  0095 a106          	cp	a,#6
6564  0097 261c          	jrne	L1323
6565                     ; 2119       if (second_counter > time_mark2 + 1) {
6567  0099 ae0090        	ldw	x,#_time_mark2
6568  009c cd0000        	call	c_ltor
6570  009f a601          	ld	a,#1
6571  00a1 cd0000        	call	c_ladc
6573  00a4 ae0000        	ldw	x,#_second_counter
6574  00a7 cd0000        	call	c_lcmp
6576  00aa 2428          	jruge	L3713
6577                     ; 2120 	mqtt_close_tcp = 0;
6579  00ac 725f009c      	clr	_mqtt_close_tcp
6580                     ; 2121         restart_reboot_step = RESTART_REBOOT_FINISH;
6582  00b0 3507009d      	mov	_restart_reboot_step,#7
6584  00b4 81            	ret	
6585  00b5               L1323:
6586                     ; 2131     else if (restart_reboot_step == RESTART_REBOOT_FINISH) {
6588  00b5 a107          	cp	a,#7
6589  00b7 261b          	jrne	L3713
6590                     ; 2132       if (reboot_request == 1) {
6592  00b9 c600a0        	ld	a,_reboot_request
6593  00bc 4a            	dec	a
6594  00bd 2606          	jrne	L1423
6595                     ; 2133         restart_reboot_step = RESTART_REBOOT_IDLE;
6597  00bf c7009d        	ld	_restart_reboot_step,a
6598                     ; 2135         reboot();
6600  00c2 cd0000        	call	_reboot
6602  00c5               L1423:
6603                     ; 2137       if (restart_request == 1) {
6605  00c5 c6009e        	ld	a,_restart_request
6606  00c8 4a            	dec	a
6607  00c9 2609          	jrne	L3713
6608                     ; 2138 	restart_request = 0;
6610  00cb c7009e        	ld	_restart_request,a
6611                     ; 2139         restart_reboot_step = RESTART_REBOOT_IDLE;
6613  00ce c7009d        	ld	_restart_reboot_step,a
6614                     ; 2141 	restart();
6616  00d1 cd0000        	call	_restart
6618  00d4               L3713:
6619                     ; 2145 }
6622  00d4 81            	ret	
6675                     ; 2148 void restart(void)
6675                     ; 2149 {
6676                     .text:	section	.text,new
6677  0000               _restart:
6681                     ; 2163   LEDcontrol(0); // Turn LED off
6683  0000 4f            	clr	a
6684  0001 cd0000        	call	_LEDcontrol
6686                     ; 2165   parse_complete = 0;
6688  0004 725f009b      	clr	_parse_complete
6689                     ; 2166   reboot_request = 0;
6691  0008 725f00a0      	clr	_reboot_request
6692                     ; 2167   restart_request = 0;
6694  000c 725f009e      	clr	_restart_request
6695                     ; 2169   time_mark2 = 0;           // Time capture used in reboot
6697  0010 5f            	clrw	x
6698  0011 cf0092        	ldw	_time_mark2+2,x
6699  0014 cf0090        	ldw	_time_mark2,x
6700                     ; 2172   mqtt_close_tcp = 0;
6702  0017 725f009c      	clr	_mqtt_close_tcp
6703                     ; 2174   mqtt_start = MQTT_START_TCP_CONNECT;
6705  001b 3501003d      	mov	_mqtt_start,#1
6706                     ; 2175   mqtt_start_status = MQTT_START_NOT_STARTED;
6708  001f 725f003c      	clr	_mqtt_start_status
6709                     ; 2176   mqtt_start_ctr1 = 0;
6711  0023 725f003b      	clr	_mqtt_start_ctr1
6712                     ; 2177   mqtt_sanity_ctr = 0;
6714  0027 725f0039      	clr	_mqtt_sanity_ctr
6715                     ; 2178   mqtt_start_retry = 0;
6717  002b 725f0038      	clr	_mqtt_start_retry
6718                     ; 2179   MQTT_error_status = 0;
6720  002f 725f0000      	clr	_MQTT_error_status
6721                     ; 2180   mqtt_restart_step = MQTT_RESTART_IDLE;
6723  0033 725f0035      	clr	_mqtt_restart_step
6724                     ; 2181   strcpy(topic_base, devicetype);
6726  0037 ae0009        	ldw	x,#_topic_base
6727  003a 90ae0000      	ldw	y,#L5261_devicetype
6728  003e               L433:
6729  003e 90f6          	ld	a,(y)
6730  0040 905c          	incw	y
6731  0042 f7            	ld	(x),a
6732  0043 5c            	incw	x
6733  0044 4d            	tnz	a
6734  0045 26f7          	jrne	L433
6735                     ; 2182   state_request = STATE_REQUEST_IDLE;
6737  0047 c700f9        	ld	_state_request,a
6738                     ; 2185   spi_init();              // Initialize the SPI bit bang interface to the
6740  004a cd0000        	call	_spi_init
6742                     ; 2187   unlock_eeprom();         // unlock the EEPROM so writes can be performed
6744  004d cd0000        	call	_unlock_eeprom
6746                     ; 2188   check_eeprom_settings(); // Verify EEPROM up to date
6748  0050 cd0000        	call	_check_eeprom_settings
6750                     ; 2189   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
6752  0053 cd0000        	call	_Enc28j60Init
6754                     ; 2190   uip_arp_init();          // Initialize the ARP module
6756  0056 cd0000        	call	_uip_arp_init
6758                     ; 2191   uip_init();              // Initialize uIP
6760  0059 cd0000        	call	_uip_init
6762                     ; 2192   HttpDInit();             // Initialize httpd; sets up listening ports
6764  005c cd0000        	call	_HttpDInit
6766                     ; 2196   mqtt_init(&mqttclient,
6766                     ; 2197             mqtt_sendbuf,
6766                     ; 2198 	    sizeof(mqtt_sendbuf),
6766                     ; 2199 	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
6766                     ; 2200 	    UIP_APPDATA_SIZE,
6766                     ; 2201 	    publish_callback);
6768  005f ae0000        	ldw	x,#_publish_callback
6769  0062 89            	pushw	x
6770  0063 ae01be        	ldw	x,#446
6771  0066 89            	pushw	x
6772  0067 ae0036        	ldw	x,#_uip_buf+54
6773  006a 89            	pushw	x
6774  006b ae00c8        	ldw	x,#200
6775  006e 89            	pushw	x
6776  006f ae0000        	ldw	x,#_mqtt_sendbuf
6777  0072 89            	pushw	x
6778  0073 ae005a        	ldw	x,#_mqttclient
6779  0076 cd0000        	call	_mqtt_init
6781  0079 5b0a          	addw	sp,#10
6782                     ; 2204   LEDcontrol(1); // Turn LED on
6784  007b a601          	ld	a,#1
6786                     ; 2207 }
6789  007d cc0000        	jp	_LEDcontrol
6817                     ; 2210 void reboot(void)
6817                     ; 2211 {
6818                     .text:	section	.text,new
6819  0000               _reboot:
6823                     ; 2214   fastflash(); // A useful signal that a deliberate reboot is occurring.
6825  0000 cd0000        	call	_fastflash
6827                     ; 2216   LEDcontrol(0);  // turn LED off
6829  0003 4f            	clr	a
6830  0004 cd0000        	call	_LEDcontrol
6832                     ; 2218   WWDG_WR = (uint8_t)0x7f;     // Window register reset
6834  0007 357f50d2      	mov	_WWDG_WR,#127
6835                     ; 2219   WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
6837  000b 35ff50d1      	mov	_WWDG_CR,#255
6838                     ; 2220   WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
6840  000f 356050d2      	mov	_WWDG_WR,#96
6841                     ; 2223   wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
6843  0013 aec350        	ldw	x,#50000
6844  0016 cd0000        	call	_wait_timer
6846                     ; 2224   wait_timer((uint16_t)50000);
6848  0019 aec350        	ldw	x,#50000
6849  001c cd0000        	call	_wait_timer
6851                     ; 2225   wait_timer((uint16_t)50000);
6853  001f aec350        	ldw	x,#50000
6855                     ; 2226 }
6858  0022 cc0000        	jp	_wait_timer
6899                     ; 2229 void read_input_registers(void)
6899                     ; 2230 {
6900                     .text:	section	.text,new
6901  0000               _read_input_registers:
6903  0000 89            	pushw	x
6904       00000002      OFST:	set	2
6907                     ; 2247   if (PC_IDR & (uint8_t)0x40) IO_16to9_new1 |= 0x80; // PC bit 6 = 1, Input 8 = 1
6909  0001 720d500b06    	btjf	_PC_IDR,#6,L1033
6912  0006 721e0101      	bset	_IO_16to9_new1,#7
6914  000a 2004          	jra	L3033
6915  000c               L1033:
6916                     ; 2248   else IO_16to9_new1 &= (uint8_t)(~0x80);
6918  000c 721f0101      	bres	_IO_16to9_new1,#7
6919  0010               L3033:
6920                     ; 2249   if (PG_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x40; // PG bit 0 = 1, Input 7 = 1
6922  0010 7201501f06    	btjf	_PG_IDR,#0,L5033
6925  0015 721c0101      	bset	_IO_16to9_new1,#6
6927  0019 2004          	jra	L7033
6928  001b               L5033:
6929                     ; 2250   else IO_16to9_new1 &= (uint8_t)(~0x40);
6931  001b 721d0101      	bres	_IO_16to9_new1,#6
6932  001f               L7033:
6933                     ; 2251   if (PE_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x20; // PE bit 3 = 1, Input 6 = 1
6935  001f 7207501506    	btjf	_PE_IDR,#3,L1133
6938  0024 721a0101      	bset	_IO_16to9_new1,#5
6940  0028 2004          	jra	L3133
6941  002a               L1133:
6942                     ; 2252   else IO_16to9_new1 &= (uint8_t)(~0x20);
6944  002a 721b0101      	bres	_IO_16to9_new1,#5
6945  002e               L3133:
6946                     ; 2253   if (PD_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x10; // PD bit 0 = 1, Input 5 = 1
6948  002e 7201501006    	btjf	_PD_IDR,#0,L5133
6951  0033 72180101      	bset	_IO_16to9_new1,#4
6953  0037 2004          	jra	L7133
6954  0039               L5133:
6955                     ; 2254   else IO_16to9_new1 &= (uint8_t)(~0x10);
6957  0039 72190101      	bres	_IO_16to9_new1,#4
6958  003d               L7133:
6959                     ; 2255   if (PD_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x08; // PD bit 3 = 1, Input 4 = 1
6961  003d 7207501006    	btjf	_PD_IDR,#3,L1233
6964  0042 72160101      	bset	_IO_16to9_new1,#3
6966  0046 2004          	jra	L3233
6967  0048               L1233:
6968                     ; 2256   else IO_16to9_new1 &= (uint8_t)(~0x08);
6970  0048 72170101      	bres	_IO_16to9_new1,#3
6971  004c               L3233:
6972                     ; 2257   if (PD_IDR & (uint8_t)0x20) IO_16to9_new1 |= 0x04; // PD bit 5 = 1, Input 3 = 1
6974  004c 720b501006    	btjf	_PD_IDR,#5,L5233
6977  0051 72140101      	bset	_IO_16to9_new1,#2
6979  0055 2004          	jra	L7233
6980  0057               L5233:
6981                     ; 2258   else IO_16to9_new1 &= (uint8_t)(~0x04);
6983  0057 72150101      	bres	_IO_16to9_new1,#2
6984  005b               L7233:
6985                     ; 2259   if (PD_IDR & (uint8_t)0x80) IO_16to9_new1 |= 0x02; // PD bit 7 = 1, Input 2 = 1
6987  005b 720f501006    	btjf	_PD_IDR,#7,L1333
6990  0060 72120101      	bset	_IO_16to9_new1,#1
6992  0064 2004          	jra	L3333
6993  0066               L1333:
6994                     ; 2260   else IO_16to9_new1 &= (uint8_t)(~0x02);
6996  0066 72130101      	bres	_IO_16to9_new1,#1
6997  006a               L3333:
6998                     ; 2261   if (PA_IDR & (uint8_t)0x10) IO_16to9_new1 |= 0x01; // PA bit 4 = 1, Input 1 = 1
7000  006a 7209500106    	btjf	_PA_IDR,#4,L5333
7003  006f 72100101      	bset	_IO_16to9_new1,#0
7005  0073 2004          	jra	L7333
7006  0075               L5333:
7007                     ; 2262   else IO_16to9_new1 &= (uint8_t)(~0x01);
7009  0075 72110101      	bres	_IO_16to9_new1,#0
7010  0079               L7333:
7011                     ; 2267   xor_tmp = (uint8_t)((IO_16to9 ^ IO_16to9_new1) & (IO_16to9 ^ IO_16to9_new2));
7013  0079 c60103        	ld	a,_IO_16to9
7014  007c c800ff        	xor	a,_IO_16to9_new2
7015  007f 6b01          	ld	(OFST-1,sp),a
7017  0081 c60103        	ld	a,_IO_16to9
7018  0084 c80101        	xor	a,_IO_16to9_new1
7019  0087 1401          	and	a,(OFST-1,sp)
7020  0089 6b02          	ld	(OFST+0,sp),a
7022                     ; 2268   IO_16to9 = (uint8_t)(IO_16to9 ^ xor_tmp);
7024  008b c80103        	xor	a,_IO_16to9
7025  008e c70103        	ld	_IO_16to9,a
7026                     ; 2270   IO_16to9_new2 = IO_16to9_new1;
7028                     ; 2324 }
7031  0091 85            	popw	x
7032  0092 55010100ff    	mov	_IO_16to9_new2,_IO_16to9_new1
7033  0097 81            	ret	
7073                     ; 2327 void write_output_registers(void)
7073                     ; 2328 {
7074                     .text:	section	.text,new
7075  0000               _write_output_registers:
7077  0000 88            	push	a
7078       00000001      OFST:	set	1
7081                     ; 2382   xor_tmp = (uint8_t)(invert_output ^ IO_8to1);
7083  0001 c600fb        	ld	a,_invert_output
7084  0004 c80102        	xor	a,_IO_8to1
7085  0007 6b01          	ld	(OFST+0,sp),a
7087                     ; 2383   if (xor_tmp & 0x80) PC_ODR |= (uint8_t)0x80; // Relay 8 off
7089  0009 2a06          	jrpl	L5533
7092  000b 721e500a      	bset	_PC_ODR,#7
7094  000f 2004          	jra	L7533
7095  0011               L5533:
7096                     ; 2384   else PC_ODR &= (uint8_t)~0x80; // Relay 8 on
7098  0011 721f500a      	bres	_PC_ODR,#7
7099  0015               L7533:
7100                     ; 2385   if (xor_tmp & 0x40) PG_ODR |= (uint8_t)0x02; // Relay 7 off
7102  0015 a540          	bcp	a,#64
7103  0017 2706          	jreq	L1633
7106  0019 7212501e      	bset	_PG_ODR,#1
7108  001d 2004          	jra	L3633
7109  001f               L1633:
7110                     ; 2386   else PG_ODR &= (uint8_t)~0x02; // Relay 7 on
7112  001f 7213501e      	bres	_PG_ODR,#1
7113  0023               L3633:
7114                     ; 2387   if (xor_tmp & 0x20) PE_ODR |= (uint8_t)0x01; // Relay 6 off
7116  0023 7b01          	ld	a,(OFST+0,sp)
7117  0025 a520          	bcp	a,#32
7118  0027 2706          	jreq	L5633
7121  0029 72105014      	bset	_PE_ODR,#0
7123  002d 2004          	jra	L7633
7124  002f               L5633:
7125                     ; 2388   else PE_ODR &= (uint8_t)~0x01; // Relay 6 on
7127  002f 72115014      	bres	_PE_ODR,#0
7128  0033               L7633:
7129                     ; 2389   if (xor_tmp & 0x10) PD_ODR |= (uint8_t)0x04; // Relay 5 off
7131  0033 a510          	bcp	a,#16
7132  0035 2706          	jreq	L1733
7135  0037 7214500f      	bset	_PD_ODR,#2
7137  003b 2004          	jra	L3733
7138  003d               L1733:
7139                     ; 2390   else PD_ODR &= (uint8_t)~0x04; // Relay 5 on
7141  003d 7215500f      	bres	_PD_ODR,#2
7142  0041               L3733:
7143                     ; 2391   if (xor_tmp & 0x08) PD_ODR |= (uint8_t)0x10; // Relay 4 off
7145  0041 7b01          	ld	a,(OFST+0,sp)
7146  0043 a508          	bcp	a,#8
7147  0045 2706          	jreq	L5733
7150  0047 7218500f      	bset	_PD_ODR,#4
7152  004b 2004          	jra	L7733
7153  004d               L5733:
7154                     ; 2392   else PD_ODR &= (uint8_t)~0x10; // Relay 4 on
7156  004d 7219500f      	bres	_PD_ODR,#4
7157  0051               L7733:
7158                     ; 2393   if (xor_tmp & 0x04) PD_ODR |= (uint8_t)0x40; // Relay 3 off
7160  0051 a504          	bcp	a,#4
7161  0053 2706          	jreq	L1043
7164  0055 721c500f      	bset	_PD_ODR,#6
7166  0059 2004          	jra	L3043
7167  005b               L1043:
7168                     ; 2394   else PD_ODR &= (uint8_t)~0x40; // Relay 3 on
7170  005b 721d500f      	bres	_PD_ODR,#6
7171  005f               L3043:
7172                     ; 2395   if (xor_tmp & 0x02) PA_ODR |= (uint8_t)0x20; // Relay 2 off
7174  005f 7b01          	ld	a,(OFST+0,sp)
7175  0061 a502          	bcp	a,#2
7176  0063 2706          	jreq	L5043
7179  0065 721a5000      	bset	_PA_ODR,#5
7181  0069 2004          	jra	L7043
7182  006b               L5043:
7183                     ; 2396   else PA_ODR &= (uint8_t)~0x20; // Relay 2 on
7185  006b 721b5000      	bres	_PA_ODR,#5
7186  006f               L7043:
7187                     ; 2397   if (xor_tmp & 0x01) PA_ODR |= (uint8_t)0x08; // Relay 1 off
7189  006f a501          	bcp	a,#1
7190  0071 2706          	jreq	L1143
7193  0073 72165000      	bset	_PA_ODR,#3
7195  0077 2004          	jra	L3143
7196  0079               L1143:
7197                     ; 2398   else PA_ODR &= (uint8_t)~0x08; // Relay 1 on
7199  0079 72175000      	bres	_PA_ODR,#3
7200  007d               L3143:
7201                     ; 2404 }
7204  007d 84            	pop	a
7205  007e 81            	ret	
7246                     ; 2407 void check_reset_button(void)
7246                     ; 2408 {
7247                     .text:	section	.text,new
7248  0000               _check_reset_button:
7250  0000 88            	push	a
7251       00000001      OFST:	set	1
7254                     ; 2413   if ((PA_IDR & 0x02) == 0) {
7256  0001 720250015d    	btjt	_PA_IDR,#1,L1343
7257                     ; 2415     for (i=0; i<100; i++) {
7259  0006 0f01          	clr	(OFST+0,sp)
7261  0008               L3343:
7262                     ; 2416       wait_timer(50000); // wait 50ms
7264  0008 aec350        	ldw	x,#50000
7265  000b cd0000        	call	_wait_timer
7267                     ; 2417       if ((PA_IDR & 0x02) == 1) { // check Reset Button again. If released
7269  000e c65001        	ld	a,_PA_IDR
7270  0011 a402          	and	a,#2
7271  0013 4a            	dec	a
7272  0014 2602          	jrne	L1443
7273                     ; 2419         return;
7276  0016 84            	pop	a
7277  0017 81            	ret	
7278  0018               L1443:
7279                     ; 2415     for (i=0; i<100; i++) {
7281  0018 0c01          	inc	(OFST+0,sp)
7285  001a 7b01          	ld	a,(OFST+0,sp)
7286  001c a164          	cp	a,#100
7287  001e 25e8          	jrult	L3343
7288                     ; 2424     LEDcontrol(0);  // turn LED off
7290  0020 4f            	clr	a
7291  0021 cd0000        	call	_LEDcontrol
7294  0024               L5443:
7295                     ; 2425     while((PA_IDR & 0x02) == 0) {  // Wait for button release
7297  0024 72035001fb    	btjf	_PA_IDR,#1,L5443
7298                     ; 2428     magic4 = 0x00;
7300  0029 4f            	clr	a
7301  002a ae002e        	ldw	x,#_magic4
7302  002d cd0000        	call	c_eewrc
7304                     ; 2429     magic3 = 0x00;
7306  0030 4f            	clr	a
7307  0031 ae002d        	ldw	x,#_magic3
7308  0034 cd0000        	call	c_eewrc
7310                     ; 2430     magic2 = 0x00;
7312  0037 4f            	clr	a
7313  0038 ae002c        	ldw	x,#_magic2
7314  003b cd0000        	call	c_eewrc
7316                     ; 2431     magic1 = 0x00;
7318  003e 4f            	clr	a
7319  003f ae002b        	ldw	x,#_magic1
7320  0042 cd0000        	call	c_eewrc
7322                     ; 2433     WWDG_WR = (uint8_t)0x7f;       // Window register reset
7324  0045 357f50d2      	mov	_WWDG_WR,#127
7325                     ; 2434     WWDG_CR = (uint8_t)0xff;       // Set watchdog to timeout in 49ms
7327  0049 35ff50d1      	mov	_WWDG_CR,#255
7328                     ; 2435     WWDG_WR = (uint8_t)0x60;       // Window register value - doesn't matter
7330  004d 356050d2      	mov	_WWDG_WR,#96
7331                     ; 2438     wait_timer((uint16_t)50000);   // Wait for watchdog to generate reset
7333  0051 aec350        	ldw	x,#50000
7334  0054 cd0000        	call	_wait_timer
7336                     ; 2439     wait_timer((uint16_t)50000);
7338  0057 aec350        	ldw	x,#50000
7339  005a cd0000        	call	_wait_timer
7341                     ; 2440     wait_timer((uint16_t)50000);
7343  005d aec350        	ldw	x,#50000
7344  0060 cd0000        	call	_wait_timer
7346  0063               L1343:
7347                     ; 2442 }
7350  0063 84            	pop	a
7351  0064 81            	ret	
7385                     ; 2445 void debugflash(void)
7385                     ; 2446 {
7386                     .text:	section	.text,new
7387  0000               _debugflash:
7389  0000 88            	push	a
7390       00000001      OFST:	set	1
7393                     ; 2461   LEDcontrol(0);     // turn LED off
7395  0001 4f            	clr	a
7396  0002 cd0000        	call	_LEDcontrol
7398                     ; 2462   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
7400  0005 0f01          	clr	(OFST+0,sp)
7402  0007               L5643:
7405  0007 aec350        	ldw	x,#50000
7406  000a cd0000        	call	_wait_timer
7410  000d 0c01          	inc	(OFST+0,sp)
7414  000f 7b01          	ld	a,(OFST+0,sp)
7415  0011 a10a          	cp	a,#10
7416  0013 25f2          	jrult	L5643
7417                     ; 2464   LEDcontrol(1);     // turn LED on
7419  0015 a601          	ld	a,#1
7420  0017 cd0000        	call	_LEDcontrol
7422                     ; 2465   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
7424  001a 0f01          	clr	(OFST+0,sp)
7426  001c               L3743:
7429  001c aec350        	ldw	x,#50000
7430  001f cd0000        	call	_wait_timer
7434  0022 0c01          	inc	(OFST+0,sp)
7438  0024 7b01          	ld	a,(OFST+0,sp)
7439  0026 a10a          	cp	a,#10
7440  0028 25f2          	jrult	L3743
7441                     ; 2466 }
7444  002a 84            	pop	a
7445  002b 81            	ret	
7479                     ; 2469 void fastflash(void)
7479                     ; 2470 {
7480                     .text:	section	.text,new
7481  0000               _fastflash:
7483  0000 88            	push	a
7484       00000001      OFST:	set	1
7487                     ; 2485   for (i=0; i<10; i++) {
7489  0001 0f01          	clr	(OFST+0,sp)
7491  0003               L5153:
7492                     ; 2486     LEDcontrol(0);     // turn LED off
7494  0003 4f            	clr	a
7495  0004 cd0000        	call	_LEDcontrol
7497                     ; 2487     wait_timer((uint16_t)50000); // wait 50ms
7499  0007 aec350        	ldw	x,#50000
7500  000a cd0000        	call	_wait_timer
7502                     ; 2489     LEDcontrol(1);     // turn LED on
7504  000d a601          	ld	a,#1
7505  000f cd0000        	call	_LEDcontrol
7507                     ; 2490     wait_timer((uint16_t)50000); // wait 50ms
7509  0012 aec350        	ldw	x,#50000
7510  0015 cd0000        	call	_wait_timer
7512                     ; 2485   for (i=0; i<10; i++) {
7514  0018 0c01          	inc	(OFST+0,sp)
7518  001a 7b01          	ld	a,(OFST+0,sp)
7519  001c a10a          	cp	a,#10
7520  001e 25e3          	jrult	L5153
7521                     ; 2492 }
7524  0020 84            	pop	a
7525  0021 81            	ret	
7550                     ; 2495 void oneflash(void)
7550                     ; 2496 {
7551                     .text:	section	.text,new
7552  0000               _oneflash:
7556                     ; 2511   LEDcontrol(0);     // turn LED off
7558  0000 4f            	clr	a
7559  0001 cd0000        	call	_LEDcontrol
7561                     ; 2512   wait_timer((uint16_t)25000); // wait 25ms
7563  0004 ae61a8        	ldw	x,#25000
7564  0007 cd0000        	call	_wait_timer
7566                     ; 2514   LEDcontrol(1);     // turn LED on
7568  000a a601          	ld	a,#1
7570                     ; 2515 }
7573  000c cc0000        	jp	_LEDcontrol
8894                     	switch	.bss
8895  0000               _RXERIF_counter:
8896  0000 00000000      	ds.b	4
8897                     	xdef	_RXERIF_counter
8898  0004               _TXERIF_counter:
8899  0004 00000000      	ds.b	4
8900                     	xdef	_TXERIF_counter
8901  0008               _topic_base_len:
8902  0008 00            	ds.b	1
8903                     	xdef	_topic_base_len
8904  0009               _topic_base:
8905  0009 000000000000  	ds.b	44
8906                     	xdef	_topic_base
8907  0035               _mqtt_restart_step:
8908  0035 00            	ds.b	1
8909                     	xdef	_mqtt_restart_step
8910                     	xref	_MQTT_error_status
8911  0036               _mqtt_conn:
8912  0036 0000          	ds.b	2
8913                     	xdef	_mqtt_conn
8914                     	xref	_mqtt_sendbuf
8915  0038               _mqtt_start_retry:
8916  0038 00            	ds.b	1
8917                     	xdef	_mqtt_start_retry
8918  0039               _mqtt_sanity_ctr:
8919  0039 00            	ds.b	1
8920                     	xdef	_mqtt_sanity_ctr
8921  003a               _mqtt_start_ctr2:
8922  003a 00            	ds.b	1
8923                     	xdef	_mqtt_start_ctr2
8924  003b               _mqtt_start_ctr1:
8925  003b 00            	ds.b	1
8926                     	xdef	_mqtt_start_ctr1
8927  003c               _mqtt_start_status:
8928  003c 00            	ds.b	1
8929                     	xdef	_mqtt_start_status
8930  003d               _mqtt_start:
8931  003d 00            	ds.b	1
8932                     	xdef	_mqtt_start
8933  003e               _client_id_text:
8934  003e 000000000000  	ds.b	26
8935                     	xdef	_client_id_text
8936  0058               _client_id:
8937  0058 0000          	ds.b	2
8938                     	xdef	_client_id
8939  005a               _mqttclient:
8940  005a 000000000000  	ds.b	44
8941                     	xdef	_mqttclient
8942  0086               _mqtt_keep_alive:
8943  0086 0000          	ds.b	2
8944                     	xdef	_mqtt_keep_alive
8945  0088               _application_message:
8946  0088 000000        	ds.b	3
8947                     	xdef	_application_message
8948  008b               _Port_Mqttd:
8949  008b 0000          	ds.b	2
8950                     	xdef	_Port_Mqttd
8951  008d               _mqttport:
8952  008d 0000          	ds.b	2
8953                     	xdef	_mqttport
8954  008f               _connect_flags:
8955  008f 00            	ds.b	1
8956                     	xdef	_connect_flags
8957                     	xref	_OctetArray
8958                     	xref	_second_counter
8959  0090               _time_mark2:
8960  0090 00000000      	ds.b	4
8961                     	xdef	_time_mark2
8962  0094               _IpAddr:
8963  0094 00000000      	ds.b	4
8964                     	xdef	_IpAddr
8965  0098               _Port_Httpd:
8966  0098 0000          	ds.b	2
8967                     	xdef	_Port_Httpd
8968  009a               _mqtt_parse_complete:
8969  009a 00            	ds.b	1
8970                     	xdef	_mqtt_parse_complete
8971  009b               _parse_complete:
8972  009b 00            	ds.b	1
8973                     	xdef	_parse_complete
8974  009c               _mqtt_close_tcp:
8975  009c 00            	ds.b	1
8976                     	xdef	_mqtt_close_tcp
8977  009d               _restart_reboot_step:
8978  009d 00            	ds.b	1
8979                     	xdef	_restart_reboot_step
8980  009e               _restart_request:
8981  009e 00            	ds.b	1
8982                     	xdef	_restart_request
8983  009f               _user_reboot_request:
8984  009f 00            	ds.b	1
8985                     	xdef	_user_reboot_request
8986  00a0               _reboot_request:
8987  00a0 00            	ds.b	1
8988                     	xdef	_reboot_request
8989  00a1               _mac_string:
8990  00a1 000000000000  	ds.b	13
8991                     	xdef	_mac_string
8992  00ae               _Pending_uip_ethaddr_oct:
8993  00ae 000000000000  	ds.b	6
8994                     	xdef	_Pending_uip_ethaddr_oct
8995  00b4               _Pending_config_settings:
8996  00b4 000000000000  	ds.b	6
8997                     	xdef	_Pending_config_settings
8998  00ba               _Pending_devicename:
8999  00ba 000000000000  	ds.b	20
9000                     	xdef	_Pending_devicename
9001  00ce               _Pending_port:
9002  00ce 0000          	ds.b	2
9003                     	xdef	_Pending_port
9004  00d0               _Pending_netmask:
9005  00d0 00000000      	ds.b	4
9006                     	xdef	_Pending_netmask
9007  00d4               _Pending_draddr:
9008  00d4 00000000      	ds.b	4
9009                     	xdef	_Pending_draddr
9010  00d8               _Pending_hostaddr:
9011  00d8 00000000      	ds.b	4
9012                     	xdef	_Pending_hostaddr
9013  00dc               _Pending_mqtt_password:
9014  00dc 000000000000  	ds.b	11
9015                     	xdef	_Pending_mqtt_password
9016  00e7               _Pending_mqtt_username:
9017  00e7 000000000000  	ds.b	11
9018                     	xdef	_Pending_mqtt_username
9019  00f2               _Pending_mqttport:
9020  00f2 0000          	ds.b	2
9021                     	xdef	_Pending_mqttport
9022  00f4               _Pending_mqttserveraddr:
9023  00f4 00000000      	ds.b	4
9024                     	xdef	_Pending_mqttserveraddr
9025  00f8               _stack_error:
9026  00f8 00            	ds.b	1
9027                     	xdef	_stack_error
9028  00f9               _state_request:
9029  00f9 00            	ds.b	1
9030                     	xdef	_state_request
9031  00fa               _invert_input:
9032  00fa 00            	ds.b	1
9033                     	xdef	_invert_input
9034  00fb               _invert_output:
9035  00fb 00            	ds.b	1
9036                     	xdef	_invert_output
9037  00fc               _IO_8to1_sent:
9038  00fc 00            	ds.b	1
9039                     	xdef	_IO_8to1_sent
9040  00fd               _IO_16to9_sent:
9041  00fd 00            	ds.b	1
9042                     	xdef	_IO_16to9_sent
9043  00fe               _IO_8to1_new2:
9044  00fe 00            	ds.b	1
9045                     	xdef	_IO_8to1_new2
9046  00ff               _IO_16to9_new2:
9047  00ff 00            	ds.b	1
9048                     	xdef	_IO_16to9_new2
9049  0100               _IO_8to1_new1:
9050  0100 00            	ds.b	1
9051                     	xdef	_IO_8to1_new1
9052  0101               _IO_16to9_new1:
9053  0101 00            	ds.b	1
9054                     	xdef	_IO_16to9_new1
9055  0102               _IO_8to1:
9056  0102 00            	ds.b	1
9057                     	xdef	_IO_8to1
9058  0103               _IO_16to9:
9059  0103 00            	ds.b	1
9060                     	xdef	_IO_16to9
9061                     .eeprom:	section	.data
9062  0000               _stored_devicename:
9063  0000 000000000000  	ds.b	20
9064                     	xdef	_stored_devicename
9065  0014               _stored_IO_8to1:
9066  0014 00            	ds.b	1
9067                     	xdef	_stored_IO_8to1
9068  0015               _stored_unused1:
9069  0015 00            	ds.b	1
9070                     	xdef	_stored_unused1
9071  0016               _stored_unused2:
9072  0016 00            	ds.b	1
9073                     	xdef	_stored_unused2
9074  0017               _stored_uip_ethaddr_oct:
9075  0017 000000000000  	ds.b	6
9076                     	xdef	_stored_uip_ethaddr_oct
9077  001d               _stored_port:
9078  001d 0000          	ds.b	2
9079                     	xdef	_stored_port
9080  001f               _stored_netmask:
9081  001f 00000000      	ds.b	4
9082                     	xdef	_stored_netmask
9083  0023               _stored_draddr:
9084  0023 00000000      	ds.b	4
9085                     	xdef	_stored_draddr
9086  0027               _stored_hostaddr:
9087  0027 00000000      	ds.b	4
9088                     	xdef	_stored_hostaddr
9089  002b               _magic1:
9090  002b 00            	ds.b	1
9091                     	xdef	_magic1
9092  002c               _magic2:
9093  002c 00            	ds.b	1
9094                     	xdef	_magic2
9095  002d               _magic3:
9096  002d 00            	ds.b	1
9097                     	xdef	_magic3
9098  002e               _magic4:
9099  002e 00            	ds.b	1
9100                     	xdef	_magic4
9101  002f               _stored_mqttport:
9102  002f 0000          	ds.b	2
9103                     	xdef	_stored_mqttport
9104  0031               _stored_mqttserveraddr:
9105  0031 00000000      	ds.b	4
9106                     	xdef	_stored_mqttserveraddr
9107  0035               _stored_mqtt_username:
9108  0035 000000000000  	ds.b	11
9109                     	xdef	_stored_mqtt_username
9110  0040               _stored_mqtt_password:
9111  0040 000000000000  	ds.b	11
9112                     	xdef	_stored_mqtt_password
9113  004b               _stored_IO_16to9:
9114  004b 00            	ds.b	1
9115                     	xdef	_stored_IO_16to9
9116  004c               _stored_config_settings:
9117  004c 000000000000  	ds.b	6
9118                     	xdef	_stored_config_settings
9119                     	xdef	_stack_limit2
9120                     	xdef	_stack_limit1
9121                     	xref	_mqtt_disconnect
9122                     	xref	_mqtt_subscribe
9123                     	xref	_mqtt_publish
9124                     	xref	_mqtt_connect
9125                     	xref	_mqtt_init
9126                     	xref	_strlen
9127                     	xref	_strcat
9128                     	xref	_wait_timer
9129                     	xref	_arp_timer_expired
9130                     	xref	_periodic_timer_expired
9131                     	xref	_clock_init
9132                     	xref	_LEDcontrol
9133                     	xref	_gpio_init
9134                     	xref	_check_mqtt_server_arp_entry
9135                     	xref	_uip_arp_timer
9136                     	xref	_uip_arp_out
9137                     	xref	_uip_arp_arpin
9138                     	xref	_uip_arp_init
9139                     	xref	_uip_ethaddr
9140                     	xref	_uip_mqttserveraddr
9141                     	xref	_uip_draddr
9142                     	xref	_uip_netmask
9143                     	xref	_uip_hostaddr
9144                     	xref	_uip_process
9145                     	xref	_uip_conns
9146                     	xref	_uip_conn
9147                     	xref	_uip_len
9148                     	xref	_uip_appdata
9149                     	xref	_htons
9150                     	xref	_uip_connect
9151                     	xref	_uip_buf
9152                     	xref	_uip_init
9153                     	xref	_GpioSetPin
9154                     	xref	_HttpDInit
9155                     	xref	_emb_itoa
9156                     	xref	_Enc28j60Send
9157                     	xref	_Enc28j60Receive
9158                     	xref	_Enc28j60Init
9159                     	xref	_spi_init
9160                     	xdef	_publish_pinstate_all
9161                     	xdef	_publish_pinstate
9162                     	xdef	_publish_outbound
9163                     	xdef	_publish_callback
9164                     	xdef	_mqtt_sanity_check
9165                     	xdef	_mqtt_startup
9166                     	xdef	_debugflash
9167                     	xdef	_fastflash
9168                     	xdef	_oneflash
9169                     	xdef	_reboot
9170                     	xdef	_restart
9171                     	xdef	_check_restart_reboot
9172                     	xdef	_check_reset_button
9173                     	xdef	_write_output_registers
9174                     	xdef	_read_input_registers
9175                     	xdef	_check_runtime_changes
9176                     	xdef	_update_mac_string
9177                     	xdef	_check_eeprom_settings
9178                     	xdef	_unlock_eeprom
9179                     	xdef	_main
9180                     	switch	.const
9181  000f               L5242:
9182  000f 2f7374617465  	dc.b	"/state",0
9183  0016               L7632:
9184  0016 2f6f75745f6f  	dc.b	"/out_off",0
9185  001f               L3632:
9186  001f 2f6f75745f6f  	dc.b	"/out_on",0
9187  0027               L5532:
9188  0027 2f696e5f6f66  	dc.b	"/in_off",0
9189  002f               L1532:
9190  002f 2f696e5f6f6e  	dc.b	"/in_on",0
9191  0036               L5302:
9192  0036 6f6e6c696e65  	dc.b	"online",0
9193  003d               L5202:
9194  003d 2f7374617465  	dc.b	"/state-req",0
9195  0048               L5102:
9196  0048 2f6f666600    	dc.b	"/off",0
9197  004d               L5002:
9198  004d 2f6f6e00      	dc.b	"/on",0
9199  0051               L1771:
9200  0051 6f66666c696e  	dc.b	"offline",0
9201  0059               L7671:
9202  0059 2f7374617475  	dc.b	"/status",0
9203                     	xref.b	c_lreg
9223                     	xref	c_ladc
9224                     	xref	c_lcmp
9225                     	xref	c_ltor
9226                     	xref	c_eewrw
9227                     	xref	c_eewrc
9228                     	end
