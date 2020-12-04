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
2624                     ; 296 int main(void)
2624                     ; 297 {
2626                     .text:	section	.text,new
2627  0000               _main:
2629  0000 88            	push	a
2630       00000001      OFST:	set	1
2633                     ; 301   parse_complete = 0;
2635  0001 725f009f      	clr	_parse_complete
2636                     ; 302   mqtt_parse_complete = 0;
2638  0005 725f009e      	clr	_mqtt_parse_complete
2639                     ; 303   reboot_request = 0;
2641  0009 725f00a4      	clr	_reboot_request
2642                     ; 304   user_reboot_request = 0;
2644  000d 725f00a3      	clr	_user_reboot_request
2645                     ; 305   restart_request = 0;
2647  0011 725f00a2      	clr	_restart_request
2648                     ; 307   time_mark2 = 0;           // Time capture used in reboot
2650  0015 5f            	clrw	x
2651  0016 cf0096        	ldw	_time_mark2+2,x
2652  0019 cf0094        	ldw	_time_mark2,x
2653                     ; 310   restart_reboot_step = RESTART_REBOOT_IDLE;
2655  001c 725f00a1      	clr	_restart_reboot_step
2656                     ; 311   mqtt_close_tcp = 0;
2658  0020 725f00a0      	clr	_mqtt_close_tcp
2659                     ; 312   stack_error = 0;
2661  0024 725f00fc      	clr	_stack_error
2662                     ; 315   mqtt_start = MQTT_START_TCP_CONNECT;	 // Tracks the MQTT startup steps
2664  0028 35010041      	mov	_mqtt_start,#1
2665                     ; 316   mqtt_start_status = MQTT_START_NOT_STARTED; // Tracks error states during
2667  002c 725f0040      	clr	_mqtt_start_status
2668                     ; 318   mqtt_keep_alive = 60;                  // Ping interval in seconds
2670  0030 ae003c        	ldw	x,#60
2671  0033 cf008a        	ldw	_mqtt_keep_alive,x
2672                     ; 320   mqtt_start_ctr1 = 0;			 // Tracks time for the MQTT startup
2674  0036 725f003f      	clr	_mqtt_start_ctr1
2675                     ; 322   mqtt_start_ctr2 = 0;			 // Tracks time for the MQTT startup
2677  003a 725f003e      	clr	_mqtt_start_ctr2
2678                     ; 324   mqtt_sanity_ctr = 0;			 // Tracks time for the MQTT sanity
2680  003e 725f003d      	clr	_mqtt_sanity_ctr
2681                     ; 326   mqtt_start_retry = 0;                  // Flag to retry the ARP/TCP Connect
2683  0042 725f003c      	clr	_mqtt_start_retry
2684                     ; 327   MQTT_error_status = 0;                 // For MQTT error status display in
2686  0046 725f0000      	clr	_MQTT_error_status
2687                     ; 329   mqtt_restart_step = MQTT_RESTART_IDLE; // Step counter for MQTT restart
2689  004a 725f0039      	clr	_mqtt_restart_step
2690                     ; 330   strcpy(topic_base, devicetype);        // Initial content of the topic_base.
2692  004e ae000d        	ldw	x,#_topic_base
2693  0051 90ae0000      	ldw	y,#L5261_devicetype
2694  0055               L6:
2695  0055 90f6          	ld	a,(y)
2696  0057 905c          	incw	y
2697  0059 f7            	ld	(x),a
2698  005a 5c            	incw	x
2699  005b 4d            	tnz	a
2700  005c 26f7          	jrne	L6
2701                     ; 336   state_request = STATE_REQUEST_IDLE;    // Set the state request received to
2703  005e c700fd        	ld	_state_request,a
2704                     ; 338   TXERIF_counter = 0;                    // Initialize the TXERIF error counter
2706  0061 5f            	clrw	x
2707  0062 cf0006        	ldw	_TXERIF_counter+2,x
2708  0065 cf0004        	ldw	_TXERIF_counter,x
2709                     ; 339   RXERIF_counter = 0;                    // Initialize the RXERIF error counter
2711  0068 cf000a        	ldw	_RXERIF_counter+2,x
2712  006b cf0008        	ldw	_RXERIF_counter,x
2713                     ; 340   TRANSMIT_counter = 0;
2715  006e cf0002        	ldw	_TRANSMIT_counter+2,x
2716  0071 cf0000        	ldw	_TRANSMIT_counter,x
2717                     ; 346   clock_init();            // Initialize and enable clocks and timers
2719  0074 cd0000        	call	_clock_init
2721                     ; 348   unlock_eeprom();         // unlock the EEPROM so writes can be performed
2723  0077 cd0000        	call	_unlock_eeprom
2725                     ; 350   gpio_init();             // Initialize and enable gpio pins
2727  007a cd0000        	call	_gpio_init
2729                     ; 352   spi_init();              // Initialize the SPI bit bang interface to the
2731  007d cd0000        	call	_spi_init
2733                     ; 355   LEDcontrol(1);           // turn LED on
2735  0080 a601          	ld	a,#1
2736  0082 cd0000        	call	_LEDcontrol
2738                     ; 357   check_eeprom_settings(); // Check the EEPROM for previously stored Address
2740  0085 cd0000        	call	_check_eeprom_settings
2742                     ; 361   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
2744  0088 cd0000        	call	_Enc28j60Init
2746                     ; 363   uip_arp_init();          // Initialize the ARP module
2748  008b cd0000        	call	_uip_arp_init
2750                     ; 365   uip_init();              // Initialize uIP Web Server
2752  008e cd0000        	call	_uip_init
2754                     ; 367   HttpDInit();             // Initialize listening ports
2756  0091 cd0000        	call	_HttpDInit
2758                     ; 374   stack_limit1 = 0xaa;
2760  0094 35aa0001      	mov	_stack_limit1,#170
2761                     ; 375   stack_limit2 = 0x55;
2763  0098 35550000      	mov	_stack_limit2,#85
2764                     ; 380   mqtt_init(&mqttclient,
2764                     ; 381             mqtt_sendbuf,
2764                     ; 382 	    sizeof(mqtt_sendbuf),
2764                     ; 383 	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
2764                     ; 384 	    UIP_APPDATA_SIZE,
2764                     ; 385 	    publish_callback);
2766  009c ae0000        	ldw	x,#_publish_callback
2767  009f 89            	pushw	x
2768  00a0 ae01be        	ldw	x,#446
2769  00a3 89            	pushw	x
2770  00a4 ae0036        	ldw	x,#_uip_buf+54
2771  00a7 89            	pushw	x
2772  00a8 ae00c8        	ldw	x,#200
2773  00ab 89            	pushw	x
2774  00ac ae0000        	ldw	x,#_mqtt_sendbuf
2775  00af 89            	pushw	x
2776  00b0 ae005e        	ldw	x,#_mqttclient
2777  00b3 cd0000        	call	_mqtt_init
2779  00b6 5b0a          	addw	sp,#10
2780  00b8               L1561:
2781                     ; 499     uip_len = Enc28j60Receive(uip_buf); // Check for incoming packets
2783  00b8 ae0000        	ldw	x,#_uip_buf
2784  00bb cd0000        	call	_Enc28j60Receive
2786  00be cf0000        	ldw	_uip_len,x
2787                     ; 501     if (uip_len > 0) {
2789  00c1 2738          	jreq	L5561
2790                     ; 505       if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
2792  00c3 ae0800        	ldw	x,#2048
2793  00c6 cd0000        	call	_htons
2795  00c9 c3000c        	cpw	x,_uip_buf+12
2796  00cc 2612          	jrne	L7561
2797                     ; 506         uip_input(); // Calls uip_process(UIP_DATA) to process a received
2799  00ce a601          	ld	a,#1
2800  00d0 cd0000        	call	_uip_process
2802                     ; 511         if (uip_len > 0) {
2804  00d3 ce0000        	ldw	x,_uip_len
2805  00d6 2723          	jreq	L5561
2806                     ; 512           uip_arp_out();
2808  00d8 cd0000        	call	_uip_arp_out
2810                     ; 516           Enc28j60Send(uip_buf, uip_len);
2812  00db ce0000        	ldw	x,_uip_len
2814  00de 2013          	jp	LC001
2815  00e0               L7561:
2816                     ; 519       else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
2818  00e0 ae0806        	ldw	x,#2054
2819  00e3 cd0000        	call	_htons
2821  00e6 c3000c        	cpw	x,_uip_buf+12
2822  00e9 2610          	jrne	L5561
2823                     ; 520         uip_arp_arpin();
2825  00eb cd0000        	call	_uip_arp_arpin
2827                     ; 524         if (uip_len > 0) {
2829  00ee ce0000        	ldw	x,_uip_len
2830  00f1 2708          	jreq	L5561
2831                     ; 528           Enc28j60Send(uip_buf, uip_len);
2834  00f3               LC001:
2835  00f3 89            	pushw	x
2836  00f4 ae0000        	ldw	x,#_uip_buf
2837  00f7 cd0000        	call	_Enc28j60Send
2838  00fa 85            	popw	x
2839  00fb               L5561:
2840                     ; 538     if (mqtt_start != MQTT_START_COMPLETE
2840                     ; 539      && mqtt_restart_step == MQTT_RESTART_IDLE
2840                     ; 540      && restart_reboot_step == RESTART_REBOOT_IDLE) {
2842  00fb c60041        	ld	a,_mqtt_start
2843  00fe a114          	cp	a,#20
2844  0100 270d          	jreq	L1761
2846  0102 c60039        	ld	a,_mqtt_restart_step
2847  0105 2608          	jrne	L1761
2849  0107 c600a1        	ld	a,_restart_reboot_step
2850  010a 2603          	jrne	L1761
2851                     ; 541        mqtt_startup();
2853  010c cd0000        	call	_mqtt_startup
2855  010f               L1761:
2856                     ; 545     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
2858  010f c600a1        	ld	a,_restart_reboot_step
2859  0112 2603          	jrne	L3761
2860                     ; 546       mqtt_sanity_check();
2862  0114 cd0000        	call	_mqtt_sanity_check
2864  0117               L3761:
2865                     ; 550     if (periodic_timer_expired()) {
2867  0117 cd0000        	call	_periodic_timer_expired
2869  011a 4d            	tnz	a
2870  011b 2743          	jreq	L5761
2871                     ; 552       for(i = 0; i < UIP_CONNS; i++) {
2873  011d 4f            	clr	a
2874  011e 6b01          	ld	(OFST+0,sp),a
2876  0120               L5071:
2877                     ; 553 	uip_periodic(i);
2879  0120 97            	ld	xl,a
2880  0121 a629          	ld	a,#41
2881  0123 42            	mul	x,a
2882  0124 1c0000        	addw	x,#_uip_conns
2883  0127 cf0000        	ldw	_uip_conn,x
2886  012a a602          	ld	a,#2
2887  012c cd0000        	call	_uip_process
2889                     ; 572 	if (uip_len > 0) {
2891  012f ce0000        	ldw	x,_uip_len
2892  0132 270e          	jreq	L1171
2893                     ; 573 	  uip_arp_out(); // Verifies arp entry in the ARP table and builds LLH
2895  0134 cd0000        	call	_uip_arp_out
2897                     ; 574           Enc28j60Send(uip_buf, uip_len);
2899  0137 ce0000        	ldw	x,_uip_len
2900  013a 89            	pushw	x
2901  013b ae0000        	ldw	x,#_uip_buf
2902  013e cd0000        	call	_Enc28j60Send
2904  0141 85            	popw	x
2905  0142               L1171:
2906                     ; 577         mqtt_start_ctr1++; // Increment the MQTT start loop timer 1. This is
2908  0142 725c003f      	inc	_mqtt_start_ctr1
2909                     ; 581         mqtt_start_ctr2++; // Increment the MQTT start loop timer 2. This is
2911  0146 725c003e      	inc	_mqtt_start_ctr2
2912                     ; 584         mqtt_sanity_ctr++; // Increment the MQTT sanity loop timer. This is
2914  014a 725c003d      	inc	_mqtt_sanity_ctr
2915                     ; 552       for(i = 0; i < UIP_CONNS; i++) {
2917  014e 0c01          	inc	(OFST+0,sp)
2921  0150 7b01          	ld	a,(OFST+0,sp)
2922  0152 a104          	cp	a,#4
2923  0154 25ca          	jrult	L5071
2924                     ; 594       if (mqtt_start == MQTT_START_COMPLETE) {
2926  0156 c60041        	ld	a,_mqtt_start
2927  0159 a114          	cp	a,#20
2928  015b 2603          	jrne	L5761
2929                     ; 595         publish_outbound();
2931  015d cd0000        	call	_publish_outbound
2933  0160               L5761:
2934                     ; 602     if (arp_timer_expired()) {
2936  0160 cd0000        	call	_arp_timer_expired
2938  0163 4d            	tnz	a
2939  0164 2703          	jreq	L5171
2940                     ; 603       uip_arp_timer(); // Clean out old ARP Table entries. Any entry that has
2942  0166 cd0000        	call	_uip_arp_timer
2944  0169               L5171:
2945                     ; 610     check_runtime_changes();
2947  0169 cd0000        	call	_check_runtime_changes
2949                     ; 613     check_reset_button();
2951  016c cd0000        	call	_check_reset_button
2953                     ; 618     check_restart_reboot();
2955  016f cd0000        	call	_check_restart_reboot
2958  0172 cc00b8        	jra	L1561
3009                     ; 646 void mqtt_startup(void)
3009                     ; 647 {
3010                     .text:	section	.text,new
3011  0000               _mqtt_startup:
3015                     ; 663   if (mqtt_start == MQTT_START_TCP_CONNECT) {
3017  0000 c60041        	ld	a,_mqtt_start
3018  0003 a101          	cp	a,#1
3019  0005 2630          	jrne	L7271
3020                     ; 664     if (stored_mqttserveraddr[3] != 0) {
3022  0007 c60034        	ld	a,_stored_mqttserveraddr+3
3023  000a 2603cc0225    	jreq	L7371
3024                     ; 684       mqtt_conn = uip_connect(&uip_mqttserveraddr, Port_Mqttd, Port_Mqttd);
3026  000f ce008f        	ldw	x,_Port_Mqttd
3027  0012 89            	pushw	x
3028  0013 89            	pushw	x
3029  0014 ae0000        	ldw	x,#_uip_mqttserveraddr
3030  0017 cd0000        	call	_uip_connect
3032  001a 5b04          	addw	sp,#4
3033  001c cf003a        	ldw	_mqtt_conn,x
3034                     ; 685       if (mqtt_conn != NULL) {
3036  001f 2711          	jreq	L3371
3037                     ; 686         mqtt_start_ctr1 = 0; // Clear 100ms counter
3039  0021 725f003f      	clr	_mqtt_start_ctr1
3040                     ; 687         mqtt_start_ctr2 = 0; // Clear 100ms counter
3042  0025 725f003e      	clr	_mqtt_start_ctr2
3043                     ; 688         mqtt_start_status = MQTT_START_CONNECTIONS_GOOD;
3045  0029 35100040      	mov	_mqtt_start_status,#16
3046                     ; 689         mqtt_start = MQTT_START_VERIFY_ARP;
3048  002d 35020041      	mov	_mqtt_start,#2
3051  0031 81            	ret	
3052  0032               L3371:
3053                     ; 692         mqtt_start_status |= MQTT_START_CONNECTIONS_ERROR;
3055  0032 72100040      	bset	_mqtt_start_status,#0
3057  0036 81            	ret	
3058  0037               L7271:
3059                     ; 697   else if (mqtt_start == MQTT_START_VERIFY_ARP
3059                     ; 698         && mqtt_start_ctr2 > 10) {
3061  0037 a102          	cp	a,#2
3062  0039 263a          	jrne	L1471
3064  003b c6003e        	ld	a,_mqtt_start_ctr2
3065  003e a10b          	cp	a,#11
3066  0040 2533          	jrult	L1471
3067                     ; 699     mqtt_start_ctr2 = 0; // Clear 100ms counter
3069  0042 725f003e      	clr	_mqtt_start_ctr2
3070                     ; 706     if (check_mqtt_server_arp_entry() == 1) {
3072  0046 cd0000        	call	_check_mqtt_server_arp_entry
3074  0049 5a            	decw	x
3075  004a 2611          	jrne	L3471
3076                     ; 708       mqtt_start_retry = 0;
3078  004c 725f003c      	clr	_mqtt_start_retry
3079                     ; 709       mqtt_start_ctr1 = 0; // Clear 100ms counter
3081  0050 725f003f      	clr	_mqtt_start_ctr1
3082                     ; 710       mqtt_start_status |= MQTT_START_ARP_REQUEST_GOOD;
3084  0054 721a0040      	bset	_mqtt_start_status,#5
3085                     ; 711       mqtt_start = MQTT_START_VERIFY_TCP;
3087  0058 35030041      	mov	_mqtt_start,#3
3090  005c 81            	ret	
3091  005d               L3471:
3092                     ; 713     else if (mqtt_start_ctr1 > 150) {
3094  005d c6003f        	ld	a,_mqtt_start_ctr1
3095  0060 a197          	cp	a,#151
3096  0062 25a8          	jrult	L7371
3097                     ; 716       mqtt_start_status |= MQTT_START_ARP_REQUEST_ERROR;
3099  0064 72120040      	bset	_mqtt_start_status,#1
3100                     ; 717       mqtt_start = MQTT_START_TCP_CONNECT;
3102  0068 35010041      	mov	_mqtt_start,#1
3103                     ; 719       mqtt_start_status = MQTT_START_NOT_STARTED;
3105  006c 725f0040      	clr	_mqtt_start_status
3106                     ; 720       mqtt_start_retry++;
3108  0070 725c003c      	inc	_mqtt_start_retry
3110  0074 81            	ret	
3111  0075               L1471:
3112                     ; 724   else if (mqtt_start == MQTT_START_VERIFY_TCP
3112                     ; 725         && mqtt_start_ctr2 > 10) {
3114  0075 c60041        	ld	a,_mqtt_start
3115  0078 a103          	cp	a,#3
3116  007a 263e          	jrne	L3571
3118  007c c6003e        	ld	a,_mqtt_start_ctr2
3119  007f a10b          	cp	a,#11
3120  0081 2537          	jrult	L3571
3121                     ; 726     mqtt_start_ctr2 = 0; // Clear 100ms counter
3123  0083 725f003e      	clr	_mqtt_start_ctr2
3124                     ; 734     if ((mqtt_conn->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
3126  0087 ce003a        	ldw	x,_mqtt_conn
3127  008a e619          	ld	a,(25,x)
3128  008c a40f          	and	a,#15
3129  008e a103          	cp	a,#3
3130  0090 260d          	jrne	L5571
3131                     ; 735       mqtt_start_retry = 0;
3133  0092 725f003c      	clr	_mqtt_start_retry
3134                     ; 736       mqtt_start_status |= MQTT_START_TCP_CONNECT_GOOD;
3136  0096 721c0040      	bset	_mqtt_start_status,#6
3137                     ; 737       mqtt_start = MQTT_START_QUEUE_CONNECT;
3139  009a 35040041      	mov	_mqtt_start,#4
3142  009e 81            	ret	
3143  009f               L5571:
3144                     ; 739     else if (mqtt_start_ctr1 > 150) {
3146  009f c6003f        	ld	a,_mqtt_start_ctr1
3147  00a2 a197          	cp	a,#151
3148  00a4 2403cc0225    	jrult	L7371
3149                     ; 742       mqtt_start_status |= MQTT_START_TCP_CONNECT_ERROR;
3151  00a9 72140040      	bset	_mqtt_start_status,#2
3152                     ; 743       mqtt_start = MQTT_START_TCP_CONNECT;
3154  00ad 35010041      	mov	_mqtt_start,#1
3155                     ; 745       mqtt_start_status = MQTT_START_NOT_STARTED; 
3157  00b1 725f0040      	clr	_mqtt_start_status
3158                     ; 746       mqtt_start_retry++;
3160  00b5 725c003c      	inc	_mqtt_start_retry
3162  00b9 81            	ret	
3163  00ba               L3571:
3164                     ; 750   else if (mqtt_start == MQTT_START_QUEUE_CONNECT) {
3166  00ba c60041        	ld	a,_mqtt_start
3167  00bd a104          	cp	a,#4
3168  00bf 2703cc0147    	jrne	L5671
3169                     ; 761     strcpy(client_id_text, devicetype);
3171  00c4 ae0042        	ldw	x,#_client_id_text
3172  00c7 90ae0000      	ldw	y,#L5261_devicetype
3173  00cb               L411:
3174  00cb 90f6          	ld	a,(y)
3175  00cd 905c          	incw	y
3176  00cf f7            	ld	(x),a
3177  00d0 5c            	incw	x
3178  00d1 4d            	tnz	a
3179  00d2 26f7          	jrne	L411
3180                     ; 763     client_id_text[strlen(client_id_text) - 1] = '\0';
3182  00d4 ae0042        	ldw	x,#_client_id_text
3183  00d7 cd0000        	call	_strlen
3185  00da 5a            	decw	x
3186  00db 724f0042      	clr	(_client_id_text,x)
3187                     ; 765     strcat(client_id_text, mac_string);
3189  00df ae00a5        	ldw	x,#_mac_string
3190  00e2 89            	pushw	x
3191  00e3 ae0042        	ldw	x,#_client_id_text
3192  00e6 cd0000        	call	_strcat
3194  00e9 85            	popw	x
3195                     ; 766     client_id = client_id_text;
3197  00ea ae0042        	ldw	x,#_client_id_text
3198  00ed cf005c        	ldw	_client_id,x
3199                     ; 769     connect_flags = MQTT_CONNECT_CLEAN_SESSION;
3201  00f0 35020093      	mov	_connect_flags,#2
3202                     ; 772     topic_base[topic_base_len] = '\0';
3204  00f4 5f            	clrw	x
3205  00f5 c6000c        	ld	a,_topic_base_len
3206  00f8 97            	ld	xl,a
3207  00f9 724f000d      	clr	(_topic_base,x)
3208                     ; 773     strcat(topic_base, "/status");
3210  00fd ae0059        	ldw	x,#L7671
3211  0100 89            	pushw	x
3212  0101 ae000d        	ldw	x,#_topic_base
3213  0104 cd0000        	call	_strcat
3215  0107 85            	popw	x
3216                     ; 776     mqtt_connect(&mqttclient,
3216                     ; 777                  client_id,              // Based on MAC address
3216                     ; 778                  topic_base,             // Will topic
3216                     ; 779                  "offline",              // Will message 
3216                     ; 780                  7,                      // Will message size
3216                     ; 781                  stored_mqtt_username,   // Username
3216                     ; 782                  stored_mqtt_password,   // Password
3216                     ; 783                  connect_flags,          // Connect flags
3216                     ; 784                  mqtt_keep_alive);       // Ping interval
3218  0108 ce008a        	ldw	x,_mqtt_keep_alive
3219  010b 89            	pushw	x
3220  010c 3b0093        	push	_connect_flags
3221  010f ae0040        	ldw	x,#_stored_mqtt_password
3222  0112 89            	pushw	x
3223  0113 ae0035        	ldw	x,#_stored_mqtt_username
3224  0116 89            	pushw	x
3225  0117 ae0007        	ldw	x,#7
3226  011a 89            	pushw	x
3227  011b ae0051        	ldw	x,#L1771
3228  011e 89            	pushw	x
3229  011f ae000d        	ldw	x,#_topic_base
3230  0122 89            	pushw	x
3231  0123 ce005c        	ldw	x,_client_id
3232  0126 89            	pushw	x
3233  0127 ae005e        	ldw	x,#_mqttclient
3234  012a cd0000        	call	_mqtt_connect
3236  012d 5b0f          	addw	sp,#15
3237                     ; 786     if (mqttclient.error == MQTT_OK) {
3239  012f ce0068        	ldw	x,_mqttclient+10
3240  0132 5a            	decw	x
3241  0133 260d          	jrne	L3771
3242                     ; 787       mqtt_start_ctr1 = 0; // Clear 100ms counter
3244  0135 725f003f      	clr	_mqtt_start_ctr1
3245                     ; 788       mqtt_start_status |= MQTT_START_MQTT_CONNECT_GOOD;
3247  0139 721e0040      	bset	_mqtt_start_status,#7
3248                     ; 789       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE1;
3250  013d 35050041      	mov	_mqtt_start,#5
3253  0141 81            	ret	
3254  0142               L3771:
3255                     ; 792       mqtt_start_status |= MQTT_START_MQTT_CONNECT_ERROR;
3257  0142 72160040      	bset	_mqtt_start_status,#3
3259  0146 81            	ret	
3260  0147               L5671:
3261                     ; 796   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE1) {
3263  0147 a105          	cp	a,#5
3264  0149 2635          	jrne	L1002
3265                     ; 806     if (mqtt_start_ctr1 > 20) {
3267  014b c6003f        	ld	a,_mqtt_start_ctr1
3268  014e a115          	cp	a,#21
3269  0150 2403cc0225    	jrult	L7371
3270                     ; 817       topic_base[topic_base_len] = '\0';
3272  0155 c6000c        	ld	a,_topic_base_len
3273  0158 5f            	clrw	x
3274  0159 97            	ld	xl,a
3275  015a 724f000d      	clr	(_topic_base,x)
3276                     ; 818       strcat(topic_base, "/on");
3278  015e ae004d        	ldw	x,#L5002
3279  0161 89            	pushw	x
3280  0162 ae000d        	ldw	x,#_topic_base
3281  0165 cd0000        	call	_strcat
3283  0168 85            	popw	x
3284                     ; 819       mqtt_subscribe(&mqttclient, topic_base, 0);
3286  0169 5f            	clrw	x
3287  016a 89            	pushw	x
3288  016b ae000d        	ldw	x,#_topic_base
3289  016e 89            	pushw	x
3290  016f ae005e        	ldw	x,#_mqttclient
3291  0172 cd0000        	call	_mqtt_subscribe
3293  0175 5b04          	addw	sp,#4
3294                     ; 820       mqtt_start_ctr1 = 0; // Clear 100ms counter
3296  0177 725f003f      	clr	_mqtt_start_ctr1
3297                     ; 821       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE2;
3299  017b 35060041      	mov	_mqtt_start,#6
3301  017f 81            	ret	
3302  0180               L1002:
3303                     ; 825   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE2) {
3305  0180 a106          	cp	a,#6
3306  0182 2632          	jrne	L1102
3307                     ; 826     if (mqtt_start_ctr1 > 10) {
3309  0184 c6003f        	ld	a,_mqtt_start_ctr1
3310  0187 a10b          	cp	a,#11
3311  0189 25c7          	jrult	L7371
3312                     ; 829       topic_base[topic_base_len] = '\0';
3314  018b c6000c        	ld	a,_topic_base_len
3315  018e 5f            	clrw	x
3316  018f 97            	ld	xl,a
3317  0190 724f000d      	clr	(_topic_base,x)
3318                     ; 830       strcat(topic_base, "/off");
3320  0194 ae0048        	ldw	x,#L5102
3321  0197 89            	pushw	x
3322  0198 ae000d        	ldw	x,#_topic_base
3323  019b cd0000        	call	_strcat
3325  019e 85            	popw	x
3326                     ; 831       mqtt_subscribe(&mqttclient, topic_base, 0);
3328  019f 5f            	clrw	x
3329  01a0 89            	pushw	x
3330  01a1 ae000d        	ldw	x,#_topic_base
3331  01a4 89            	pushw	x
3332  01a5 ae005e        	ldw	x,#_mqttclient
3333  01a8 cd0000        	call	_mqtt_subscribe
3335  01ab 5b04          	addw	sp,#4
3336                     ; 832       mqtt_start_ctr1 = 0; // Clear 100ms counter
3338  01ad 725f003f      	clr	_mqtt_start_ctr1
3339                     ; 833       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE3;
3341  01b1 35070041      	mov	_mqtt_start,#7
3343  01b5 81            	ret	
3344  01b6               L1102:
3345                     ; 837   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE3) {
3347  01b6 a107          	cp	a,#7
3348  01b8 2632          	jrne	L1202
3349                     ; 838     if (mqtt_start_ctr1 > 10) {
3351  01ba c6003f        	ld	a,_mqtt_start_ctr1
3352  01bd a10b          	cp	a,#11
3353  01bf 2564          	jrult	L7371
3354                     ; 841       topic_base[topic_base_len] = '\0';
3356  01c1 c6000c        	ld	a,_topic_base_len
3357  01c4 5f            	clrw	x
3358  01c5 97            	ld	xl,a
3359  01c6 724f000d      	clr	(_topic_base,x)
3360                     ; 842       strcat(topic_base, "/state-req");
3362  01ca ae003d        	ldw	x,#L5202
3363  01cd 89            	pushw	x
3364  01ce ae000d        	ldw	x,#_topic_base
3365  01d1 cd0000        	call	_strcat
3367  01d4 85            	popw	x
3368                     ; 843       mqtt_subscribe(&mqttclient, topic_base, 0);
3370  01d5 5f            	clrw	x
3371  01d6 89            	pushw	x
3372  01d7 ae000d        	ldw	x,#_topic_base
3373  01da 89            	pushw	x
3374  01db ae005e        	ldw	x,#_mqttclient
3375  01de cd0000        	call	_mqtt_subscribe
3377  01e1 5b04          	addw	sp,#4
3378                     ; 844       mqtt_start_ctr1 = 0; // Clear 100ms counter
3380  01e3 725f003f      	clr	_mqtt_start_ctr1
3381                     ; 845       mqtt_start = MQTT_START_QUEUE_PUBLISH;
3383  01e7 35090041      	mov	_mqtt_start,#9
3385  01eb 81            	ret	
3386  01ec               L1202:
3387                     ; 849   else if (mqtt_start == MQTT_START_QUEUE_PUBLISH) {
3389  01ec a109          	cp	a,#9
3390  01ee 2635          	jrne	L7371
3391                     ; 850     if (mqtt_start_ctr1 > 10) {
3393  01f0 c6003f        	ld	a,_mqtt_start_ctr1
3394  01f3 a10b          	cp	a,#11
3395  01f5 252e          	jrult	L7371
3396                     ; 853       topic_base[topic_base_len] = '\0';
3398  01f7 c6000c        	ld	a,_topic_base_len
3399  01fa 5f            	clrw	x
3400  01fb 97            	ld	xl,a
3401  01fc 724f000d      	clr	(_topic_base,x)
3402                     ; 854       strcat(topic_base, "/status");
3404  0200 ae0059        	ldw	x,#L7671
3405  0203 89            	pushw	x
3406  0204 ae000d        	ldw	x,#_topic_base
3407  0207 cd0000        	call	_strcat
3409  020a 85            	popw	x
3410                     ; 855       mqtt_publish(&mqttclient,
3410                     ; 856                    topic_base,
3410                     ; 857 		   "online",
3410                     ; 858 		   6,
3410                     ; 859 		   MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
3412  020b 4b01          	push	#1
3413  020d ae0006        	ldw	x,#6
3414  0210 89            	pushw	x
3415  0211 ae0036        	ldw	x,#L5302
3416  0214 89            	pushw	x
3417  0215 ae000d        	ldw	x,#_topic_base
3418  0218 89            	pushw	x
3419  0219 ae005e        	ldw	x,#_mqttclient
3420  021c cd0000        	call	_mqtt_publish
3422  021f 5b07          	addw	sp,#7
3423                     ; 861       mqtt_start = MQTT_START_COMPLETE;
3425  0221 35140041      	mov	_mqtt_start,#20
3426  0225               L7371:
3427                     ; 864 }
3430  0225 81            	ret	
3466                     ; 867 void mqtt_sanity_check(void)
3466                     ; 868 {
3467                     .text:	section	.text,new
3468  0000               _mqtt_sanity_check:
3472                     ; 880   if (mqtt_restart_step == MQTT_RESTART_IDLE) {
3474  0000 c60039        	ld	a,_mqtt_restart_step
3475  0003 2634          	jrne	L7402
3476                     ; 887     if (mqttclient.number_of_timeouts > 1) {
3478  0005 ce006c        	ldw	x,_mqttclient+14
3479  0008 a30002        	cpw	x,#2
3480  000b 2f08          	jrslt	L1502
3481                     ; 889       mqttclient.number_of_timeouts = 0;
3483  000d 5f            	clrw	x
3484  000e cf006c        	ldw	_mqttclient+14,x
3485                     ; 890       mqtt_restart_step = MQTT_RESTART_BEGIN;
3487  0011 35010039      	mov	_mqtt_restart_step,#1
3488  0015               L1502:
3489                     ; 896     if (mqtt_start == MQTT_START_COMPLETE
3489                     ; 897      && mqtt_conn->tcpstateflags == UIP_CLOSED) {
3491  0015 c60041        	ld	a,_mqtt_start
3492  0018 a114          	cp	a,#20
3493  001a 260b          	jrne	L3502
3495  001c ce003a        	ldw	x,_mqtt_conn
3496  001f 6d19          	tnz	(25,x)
3497  0021 2604          	jrne	L3502
3498                     ; 898       mqtt_restart_step = MQTT_RESTART_BEGIN;
3500  0023 35010039      	mov	_mqtt_restart_step,#1
3501  0027               L3502:
3502                     ; 904     if (mqtt_start == MQTT_START_COMPLETE
3502                     ; 905      && mqttclient.error != MQTT_OK) {
3504  0027 a114          	cp	a,#20
3505  0029 2703cc00b6    	jrne	L7502
3507  002e ce0068        	ldw	x,_mqttclient+10
3508  0031 5a            	decw	x
3509  0032 27f7          	jreq	L7502
3510                     ; 906       mqtt_restart_step = MQTT_RESTART_BEGIN;
3512  0034 35010039      	mov	_mqtt_restart_step,#1
3514  0038 81            	ret	
3515  0039               L7402:
3516                     ; 910   else if (mqtt_restart_step == MQTT_RESTART_BEGIN) {
3518  0039 a101          	cp	a,#1
3519  003b 2609          	jrne	L1602
3520                     ; 918     mqtt_restart_step = MQTT_RESTART_DISCONNECT_START;
3522  003d 35020039      	mov	_mqtt_restart_step,#2
3523                     ; 921     mqtt_start_status = MQTT_START_NOT_STARTED;
3525  0041 725f0040      	clr	_mqtt_start_status
3528  0045 81            	ret	
3529  0046               L1602:
3530                     ; 924   else if (mqtt_restart_step == MQTT_RESTART_DISCONNECT_START) {
3532  0046 a102          	cp	a,#2
3533  0048 260f          	jrne	L5602
3534                     ; 925     mqtt_restart_step = MQTT_RESTART_DISCONNECT_WAIT;
3536  004a 35030039      	mov	_mqtt_restart_step,#3
3537                     ; 927     mqtt_disconnect(&mqttclient);
3539  004e ae005e        	ldw	x,#_mqttclient
3540  0051 cd0000        	call	_mqtt_disconnect
3542                     ; 928     mqtt_sanity_ctr = 0; // Clear 100ms counter
3544  0054 725f003d      	clr	_mqtt_sanity_ctr
3547  0058 81            	ret	
3548  0059               L5602:
3549                     ; 931   else if (mqtt_restart_step == MQTT_RESTART_DISCONNECT_WAIT) {
3551  0059 a103          	cp	a,#3
3552  005b 260c          	jrne	L1702
3553                     ; 932     if (mqtt_sanity_ctr > 10) {
3555  005d c6003d        	ld	a,_mqtt_sanity_ctr
3556  0060 a10b          	cp	a,#11
3557  0062 2552          	jrult	L7502
3558                     ; 935       mqtt_restart_step = MQTT_RESTART_TCPCLOSE;
3560  0064 35040039      	mov	_mqtt_restart_step,#4
3562  0068 81            	ret	
3563  0069               L1702:
3564                     ; 939   else if (mqtt_restart_step == MQTT_RESTART_TCPCLOSE) {
3566  0069 a104          	cp	a,#4
3567  006b 260d          	jrne	L7702
3568                     ; 955     mqtt_close_tcp = 1;
3570  006d 350100a0      	mov	_mqtt_close_tcp,#1
3571                     ; 957     mqtt_sanity_ctr = 0; // Clear 100ms counter
3573  0071 725f003d      	clr	_mqtt_sanity_ctr
3574                     ; 958     mqtt_restart_step = MQTT_RESTART_TCPCLOSE_WAIT;
3576  0075 35050039      	mov	_mqtt_restart_step,#5
3579  0079 81            	ret	
3580  007a               L7702:
3581                     ; 961   else if (mqtt_restart_step == MQTT_RESTART_TCPCLOSE_WAIT) {
3583  007a a105          	cp	a,#5
3584  007c 2610          	jrne	L3012
3585                     ; 966     if (mqtt_sanity_ctr > 20) {
3587  007e c6003d        	ld	a,_mqtt_sanity_ctr
3588  0081 a115          	cp	a,#21
3589  0083 2531          	jrult	L7502
3590                     ; 967       mqtt_close_tcp = 0;
3592  0085 725f00a0      	clr	_mqtt_close_tcp
3593                     ; 968       mqtt_restart_step = MQTT_RESTART_SIGNAL_STARTUP;
3595  0089 35060039      	mov	_mqtt_restart_step,#6
3597  008d 81            	ret	
3598  008e               L3012:
3599                     ; 972   else if (mqtt_restart_step == MQTT_RESTART_SIGNAL_STARTUP) {
3601  008e a106          	cp	a,#6
3602  0090 2624          	jrne	L7502
3603                     ; 974     mqtt_init(&mqttclient,
3603                     ; 975               mqtt_sendbuf,
3603                     ; 976 	      sizeof(mqtt_sendbuf),
3603                     ; 977 	      &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
3603                     ; 978 	      UIP_APPDATA_SIZE,
3603                     ; 979 	      publish_callback);
3605  0092 ae0000        	ldw	x,#_publish_callback
3606  0095 89            	pushw	x
3607  0096 ae01be        	ldw	x,#446
3608  0099 89            	pushw	x
3609  009a ae0036        	ldw	x,#_uip_buf+54
3610  009d 89            	pushw	x
3611  009e ae00c8        	ldw	x,#200
3612  00a1 89            	pushw	x
3613  00a2 ae0000        	ldw	x,#_mqtt_sendbuf
3614  00a5 89            	pushw	x
3615  00a6 ae005e        	ldw	x,#_mqttclient
3616  00a9 cd0000        	call	_mqtt_init
3618  00ac 5b0a          	addw	sp,#10
3619                     ; 982     mqtt_restart_step = MQTT_RESTART_IDLE;
3621  00ae 725f0039      	clr	_mqtt_restart_step
3622                     ; 983     mqtt_start = MQTT_START_TCP_CONNECT;
3624  00b2 35010041      	mov	_mqtt_start,#1
3625  00b6               L7502:
3626                     ; 985 }
3629  00b6 81            	ret	
3702                     ; 1063 void publish_callback(void** unused, struct mqtt_response_publish *published)
3702                     ; 1064 {
3703                     .text:	section	.text,new
3704  0000               _publish_callback:
3706  0000 5204          	subw	sp,#4
3707       00000004      OFST:	set	4
3710                     ; 1070   pin_value = 0;
3712  0002 0f01          	clr	(OFST-3,sp)
3714                     ; 1071   ParseNum = 0;
3716                     ; 1099   pBuffer = uip_appdata;
3718  0004 ce0000        	ldw	x,_uip_appdata
3720                     ; 1101   pBuffer = pBuffer + 1;
3722  0007 1c0012        	addw	x,#18
3724                     ; 1103   pBuffer = pBuffer + 1;
3727                     ; 1105   pBuffer = pBuffer + 2;
3730                     ; 1107   pBuffer = pBuffer + 14;
3732  000a 1f03          	ldw	(OFST-1,sp),x
3734                     ; 1109   pBuffer = pBuffer + strlen(stored_devicename) + 1;
3736  000c ae0000        	ldw	x,#_stored_devicename
3737  000f cd0000        	call	_strlen
3739  0012 72fb03        	addw	x,(OFST-1,sp)
3740  0015 5c            	incw	x
3741  0016 1f03          	ldw	(OFST-1,sp),x
3743                     ; 1112   if (*pBuffer == 'o') {
3745  0018 f6            	ld	a,(x)
3746  0019 a16f          	cp	a,#111
3747  001b 267a          	jrne	L3412
3748                     ; 1113     pBuffer++;
3750  001d 5c            	incw	x
3751  001e 1f03          	ldw	(OFST-1,sp),x
3753                     ; 1114     if (*pBuffer == 'n') {
3755  0020 f6            	ld	a,(x)
3756  0021 a16e          	cp	a,#110
3757  0023 2609          	jrne	L5412
3758                     ; 1115       pBuffer++;
3760  0025 5c            	incw	x
3761  0026 1f03          	ldw	(OFST-1,sp),x
3763                     ; 1116       pin_value = 1;
3765  0028 a601          	ld	a,#1
3766  002a 6b01          	ld	(OFST-3,sp),a
3769  002c 200b          	jra	L7412
3770  002e               L5412:
3771                     ; 1118     else if (*pBuffer == 'f') {
3773  002e a166          	cp	a,#102
3774  0030 2607          	jrne	L7412
3775                     ; 1119       pBuffer = pBuffer + 2;
3777  0032 1c0002        	addw	x,#2
3778  0035 1f03          	ldw	(OFST-1,sp),x
3780                     ; 1120       pin_value = 0;
3782  0037 0f01          	clr	(OFST-3,sp)
3784  0039               L7412:
3785                     ; 1124     if (*pBuffer == 'a') {
3787  0039 f6            	ld	a,(x)
3788  003a a161          	cp	a,#97
3789  003c 2625          	jrne	L3512
3790                     ; 1125       pBuffer++;
3792  003e 5c            	incw	x
3793  003f 1f03          	ldw	(OFST-1,sp),x
3795                     ; 1126       if (*pBuffer == 'l') {
3797  0041 f6            	ld	a,(x)
3798  0042 a16c          	cp	a,#108
3799  0044 264b          	jrne	L7612
3800                     ; 1127         pBuffer++;
3802  0046 5c            	incw	x
3803  0047 1f03          	ldw	(OFST-1,sp),x
3805                     ; 1128         if (*pBuffer == 'l') {
3807  0049 f6            	ld	a,(x)
3808  004a a16c          	cp	a,#108
3809  004c 2643          	jrne	L7612
3810                     ; 1130 	  for (i=0; i<8; i++) GpioSetPin(i, (uint8_t)pin_value);
3812  004e 0f02          	clr	(OFST-2,sp)
3814  0050               L1612:
3817  0050 7b01          	ld	a,(OFST-3,sp)
3818  0052 97            	ld	xl,a
3819  0053 7b02          	ld	a,(OFST-2,sp)
3820  0055 95            	ld	xh,a
3821  0056 cd0000        	call	_GpioSetPin
3825  0059 0c02          	inc	(OFST-2,sp)
3829  005b 7b02          	ld	a,(OFST-2,sp)
3830  005d a108          	cp	a,#8
3831  005f 25ef          	jrult	L1612
3832  0061 202e          	jra	L7612
3833  0063               L3512:
3834                     ; 1136     else if (*pBuffer == '0' || *pBuffer == '1') {
3836  0063 a130          	cp	a,#48
3837  0065 2704          	jreq	L3712
3839  0067 a131          	cp	a,#49
3840  0069 2626          	jrne	L7612
3841  006b               L3712:
3842                     ; 1138       ParseNum = (uint8_t)((*pBuffer - '0') * 10);
3844  006b 97            	ld	xl,a
3845  006c a60a          	ld	a,#10
3846  006e 42            	mul	x,a
3847  006f 9f            	ld	a,xl
3848  0070 a0e0          	sub	a,#224
3849  0072 6b02          	ld	(OFST-2,sp),a
3851                     ; 1139       pBuffer++;
3853  0074 1e03          	ldw	x,(OFST-1,sp)
3854  0076 5c            	incw	x
3855  0077 1f03          	ldw	(OFST-1,sp),x
3857                     ; 1141       ParseNum += (uint8_t)(*pBuffer - '0');
3859  0079 f6            	ld	a,(x)
3860  007a a030          	sub	a,#48
3861  007c 1b02          	add	a,(OFST-2,sp)
3862  007e 6b02          	ld	(OFST-2,sp),a
3864                     ; 1143       if (ParseNum > 0 && ParseNum < 9) {
3866  0080 270f          	jreq	L7612
3868  0082 a109          	cp	a,#9
3869  0084 240b          	jruge	L7612
3870                     ; 1145         ParseNum--;
3872  0086 0a02          	dec	(OFST-2,sp)
3874                     ; 1147         GpioSetPin(ParseNum, (uint8_t)pin_value);
3876  0088 7b01          	ld	a,(OFST-3,sp)
3877  008a 97            	ld	xl,a
3878  008b 7b02          	ld	a,(OFST-2,sp)
3879  008d 95            	ld	xh,a
3880  008e cd0000        	call	_GpioSetPin
3882  0091               L7612:
3883                     ; 1153     mqtt_parse_complete = 1;
3885  0091 3501009e      	mov	_mqtt_parse_complete,#1
3887  0095 2013          	jra	L7712
3888  0097               L3412:
3889                     ; 1157   else if (*pBuffer == 's') {
3891  0097 a173          	cp	a,#115
3892  0099 260f          	jrne	L7712
3893                     ; 1158     pBuffer += 8;
3895  009b 1c0008        	addw	x,#8
3897                     ; 1159     if (*pBuffer == 'q') {
3899  009e f6            	ld	a,(x)
3900  009f a171          	cp	a,#113
3901  00a1 2607          	jrne	L7712
3902                     ; 1160       *pBuffer = '0'; // Destroy 'q' in buffer so subsequent "state"
3904  00a3 a630          	ld	a,#48
3905  00a5 f7            	ld	(x),a
3906                     ; 1171       state_request = STATE_REQUEST_RCVD;
3908  00a6 350100fd      	mov	_state_request,#1
3909  00aa               L7712:
3910                     ; 1174 }
3913  00aa 5b04          	addw	sp,#4
3914  00ac 81            	ret	
3953                     ; 1177 void publish_outbound(void)
3953                     ; 1178 {
3954                     .text:	section	.text,new
3955  0000               _publish_outbound:
3957  0000 88            	push	a
3958       00000001      OFST:	set	1
3961                     ; 1210   if (state_request == STATE_REQUEST_IDLE) {
3963  0001 c600fd        	ld	a,_state_request
3964  0004 2703cc00f9    	jrne	L1222
3965                     ; 1213     xor_tmp = (uint8_t)(IO_16to9 ^ IO_16to9_sent);
3967  0009 c60107        	ld	a,_IO_16to9
3968  000c c80101        	xor	a,_IO_16to9_sent
3969  000f 6b01          	ld	(OFST+0,sp),a
3971                     ; 1215     if      (xor_tmp & 0x80) publish_pinstate('I', '8', IO_16to9, 0x80); // Input 8
3973  0011 2a0a          	jrpl	L3222
3976  0013 4b80          	push	#128
3977  0015 3b0107        	push	_IO_16to9
3978  0018 ae4938        	ldw	x,#18744
3981  001b 2060          	jp	LC002
3982  001d               L3222:
3983                     ; 1216     else if (xor_tmp & 0x40) publish_pinstate('I', '7', IO_16to9, 0x40); // Input 7
3985  001d a540          	bcp	a,#64
3986  001f 270a          	jreq	L7222
3989  0021 4b40          	push	#64
3990  0023 3b0107        	push	_IO_16to9
3991  0026 ae4937        	ldw	x,#18743
3994  0029 2052          	jp	LC002
3995  002b               L7222:
3996                     ; 1217     else if (xor_tmp & 0x20) publish_pinstate('I', '6', IO_16to9, 0x20); // Input 6
3998  002b a520          	bcp	a,#32
3999  002d 270a          	jreq	L3322
4002  002f 4b20          	push	#32
4003  0031 3b0107        	push	_IO_16to9
4004  0034 ae4936        	ldw	x,#18742
4007  0037 2044          	jp	LC002
4008  0039               L3322:
4009                     ; 1218     else if (xor_tmp & 0x10) publish_pinstate('I', '5', IO_16to9, 0x10); // Input 5
4011  0039 a510          	bcp	a,#16
4012  003b 270a          	jreq	L7322
4015  003d 4b10          	push	#16
4016  003f 3b0107        	push	_IO_16to9
4017  0042 ae4935        	ldw	x,#18741
4020  0045 2036          	jp	LC002
4021  0047               L7322:
4022                     ; 1219     else if (xor_tmp & 0x08) publish_pinstate('I', '4', IO_16to9, 0x08); // Input 4
4024  0047 a508          	bcp	a,#8
4025  0049 270a          	jreq	L3422
4028  004b 4b08          	push	#8
4029  004d 3b0107        	push	_IO_16to9
4030  0050 ae4934        	ldw	x,#18740
4033  0053 2028          	jp	LC002
4034  0055               L3422:
4035                     ; 1220     else if (xor_tmp & 0x04) publish_pinstate('I', '3', IO_16to9, 0x04); // Input 3
4037  0055 a504          	bcp	a,#4
4038  0057 270a          	jreq	L7422
4041  0059 4b04          	push	#4
4042  005b 3b0107        	push	_IO_16to9
4043  005e ae4933        	ldw	x,#18739
4046  0061 201a          	jp	LC002
4047  0063               L7422:
4048                     ; 1221     else if (xor_tmp & 0x02) publish_pinstate('I', '2', IO_16to9, 0x02); // Input 2
4050  0063 a502          	bcp	a,#2
4051  0065 270a          	jreq	L3522
4054  0067 4b02          	push	#2
4055  0069 3b0107        	push	_IO_16to9
4056  006c ae4932        	ldw	x,#18738
4059  006f 200c          	jp	LC002
4060  0071               L3522:
4061                     ; 1222     else if (xor_tmp & 0x01) publish_pinstate('I', '1', IO_16to9, 0x01); // Input 1
4063  0071 a501          	bcp	a,#1
4064  0073 270c          	jreq	L5222
4067  0075 4b01          	push	#1
4068  0077 3b0107        	push	_IO_16to9
4069  007a ae4931        	ldw	x,#18737
4071  007d               LC002:
4072  007d cd0000        	call	_publish_pinstate
4073  0080 85            	popw	x
4074  0081               L5222:
4075                     ; 1226     xor_tmp = (uint8_t)(IO_8to1 ^ IO_8to1_sent);
4077  0081 c60106        	ld	a,_IO_8to1
4078  0084 c80100        	xor	a,_IO_8to1_sent
4079  0087 6b01          	ld	(OFST+0,sp),a
4081                     ; 1228     if      (xor_tmp & 0x80) publish_pinstate('O', '8', IO_8to1, 0x80); // Output 8
4083  0089 2a0a          	jrpl	L1622
4086  008b 4b80          	push	#128
4087  008d 3b0106        	push	_IO_8to1
4088  0090 ae4f38        	ldw	x,#20280
4091  0093 2060          	jp	LC003
4092  0095               L1622:
4093                     ; 1229     else if (xor_tmp & 0x40) publish_pinstate('O', '7', IO_8to1, 0x40); // Output 7
4095  0095 a540          	bcp	a,#64
4096  0097 270a          	jreq	L5622
4099  0099 4b40          	push	#64
4100  009b 3b0106        	push	_IO_8to1
4101  009e ae4f37        	ldw	x,#20279
4104  00a1 2052          	jp	LC003
4105  00a3               L5622:
4106                     ; 1230     else if (xor_tmp & 0x20) publish_pinstate('O', '6', IO_8to1, 0x20); // Output 6
4108  00a3 a520          	bcp	a,#32
4109  00a5 270a          	jreq	L1722
4112  00a7 4b20          	push	#32
4113  00a9 3b0106        	push	_IO_8to1
4114  00ac ae4f36        	ldw	x,#20278
4117  00af 2044          	jp	LC003
4118  00b1               L1722:
4119                     ; 1231     else if (xor_tmp & 0x10) publish_pinstate('O', '5', IO_8to1, 0x10); // Output 5
4121  00b1 a510          	bcp	a,#16
4122  00b3 270a          	jreq	L5722
4125  00b5 4b10          	push	#16
4126  00b7 3b0106        	push	_IO_8to1
4127  00ba ae4f35        	ldw	x,#20277
4130  00bd 2036          	jp	LC003
4131  00bf               L5722:
4132                     ; 1232     else if (xor_tmp & 0x08) publish_pinstate('O', '4', IO_8to1, 0x08); // Output 4
4134  00bf a508          	bcp	a,#8
4135  00c1 270a          	jreq	L1032
4138  00c3 4b08          	push	#8
4139  00c5 3b0106        	push	_IO_8to1
4140  00c8 ae4f34        	ldw	x,#20276
4143  00cb 2028          	jp	LC003
4144  00cd               L1032:
4145                     ; 1233     else if (xor_tmp & 0x04) publish_pinstate('O', '3', IO_8to1, 0x04); // Output 3
4147  00cd a504          	bcp	a,#4
4148  00cf 270a          	jreq	L5032
4151  00d1 4b04          	push	#4
4152  00d3 3b0106        	push	_IO_8to1
4153  00d6 ae4f33        	ldw	x,#20275
4156  00d9 201a          	jp	LC003
4157  00db               L5032:
4158                     ; 1234     else if (xor_tmp & 0x02) publish_pinstate('O', '2', IO_8to1, 0x02); // Output 2
4160  00db a502          	bcp	a,#2
4161  00dd 270a          	jreq	L1132
4164  00df 4b02          	push	#2
4165  00e1 3b0106        	push	_IO_8to1
4166  00e4 ae4f32        	ldw	x,#20274
4169  00e7 200c          	jp	LC003
4170  00e9               L1132:
4171                     ; 1235     else if (xor_tmp & 0x01) publish_pinstate('O', '1', IO_8to1, 0x01); // Output 1
4173  00e9 a501          	bcp	a,#1
4174  00eb 270c          	jreq	L1222
4177  00ed 4b01          	push	#1
4178  00ef 3b0106        	push	_IO_8to1
4179  00f2 ae4f31        	ldw	x,#20273
4181  00f5               LC003:
4182  00f5 cd0000        	call	_publish_pinstate
4183  00f8 85            	popw	x
4184  00f9               L1222:
4185                     ; 1239   if (state_request == STATE_REQUEST_RCVD) {
4187  00f9 c600fd        	ld	a,_state_request
4188  00fc 4a            	dec	a
4189  00fd 2606          	jrne	L7132
4190                     ; 1241     state_request = STATE_REQUEST_IDLE;
4192  00ff c700fd        	ld	_state_request,a
4193                     ; 1242     publish_pinstate_all();
4195  0102 cd0000        	call	_publish_pinstate_all
4197  0105               L7132:
4198                     ; 1244 }
4201  0105 84            	pop	a
4202  0106 81            	ret	
4266                     ; 1247 void publish_pinstate(uint8_t direction, uint8_t pin, uint8_t value, uint8_t mask)
4266                     ; 1248 {
4267                     .text:	section	.text,new
4268  0000               _publish_pinstate:
4270  0000 89            	pushw	x
4271       00000000      OFST:	set	0
4274                     ; 1251   application_message[0] = '0';
4276  0001 3530008c      	mov	_application_message,#48
4277                     ; 1252   application_message[1] = (uint8_t)(pin);
4279  0005 9f            	ld	a,xl
4280  0006 c7008d        	ld	_application_message+1,a
4281                     ; 1253   application_message[2] = '\0';
4283  0009 725f008e      	clr	_application_message+2
4284                     ; 1255   topic_base[topic_base_len] = '\0';
4286  000d 5f            	clrw	x
4287  000e c6000c        	ld	a,_topic_base_len
4288  0011 97            	ld	xl,a
4289  0012 724f000d      	clr	(_topic_base,x)
4290                     ; 1258   if (direction == 'I') {
4292  0016 7b01          	ld	a,(OFST+1,sp)
4293  0018 a149          	cp	a,#73
4294  001a 2618          	jrne	L3432
4295                     ; 1260     if (invert_input == 0xff) value = (uint8_t)(~value);
4297  001c c600fe        	ld	a,_invert_input
4298  001f 4c            	inc	a
4299  0020 2602          	jrne	L5432
4302  0022 0305          	cpl	(OFST+5,sp)
4303  0024               L5432:
4304                     ; 1261     if (value & mask) strcat(topic_base, "/in_on");
4306  0024 7b05          	ld	a,(OFST+5,sp)
4307  0026 1506          	bcp	a,(OFST+6,sp)
4308  0028 2705          	jreq	L7432
4311  002a ae002f        	ldw	x,#L1532
4314  002d 2013          	jra	L7532
4315  002f               L7432:
4316                     ; 1262     else strcat(topic_base, "/in_off");
4318  002f ae0027        	ldw	x,#L5532
4320  0032 200e          	jra	L7532
4321  0034               L3432:
4322                     ; 1266     if (value & mask) strcat(topic_base, "/out_on");
4324  0034 7b05          	ld	a,(OFST+5,sp)
4325  0036 1506          	bcp	a,(OFST+6,sp)
4326  0038 2705          	jreq	L1632
4329  003a ae001f        	ldw	x,#L3632
4332  003d 2003          	jra	L7532
4333  003f               L1632:
4334                     ; 1267     else strcat(topic_base, "/out_off");
4336  003f ae0016        	ldw	x,#L7632
4338  0042               L7532:
4339  0042 89            	pushw	x
4340  0043 ae000d        	ldw	x,#_topic_base
4341  0046 cd0000        	call	_strcat
4342  0049 85            	popw	x
4343                     ; 1271   mqtt_publish(&mqttclient,
4343                     ; 1272                topic_base,
4343                     ; 1273 	       application_message,
4343                     ; 1274 	       2,
4343                     ; 1275 	       MQTT_PUBLISH_QOS_0);
4345  004a 4b00          	push	#0
4346  004c ae0002        	ldw	x,#2
4347  004f 89            	pushw	x
4348  0050 ae008c        	ldw	x,#_application_message
4349  0053 89            	pushw	x
4350  0054 ae000d        	ldw	x,#_topic_base
4351  0057 89            	pushw	x
4352  0058 ae005e        	ldw	x,#_mqttclient
4353  005b cd0000        	call	_mqtt_publish
4355  005e 5b07          	addw	sp,#7
4356                     ; 1277   if (direction == 'I') {
4358  0060 7b01          	ld	a,(OFST+1,sp)
4359  0062 a149          	cp	a,#73
4360  0064 2619          	jrne	L1732
4361                     ; 1279     if (IO_16to9 & mask) IO_16to9_sent |= mask;
4363  0066 c60107        	ld	a,_IO_16to9
4364  0069 1506          	bcp	a,(OFST+6,sp)
4365  006b 2707          	jreq	L3732
4368  006d c60101        	ld	a,_IO_16to9_sent
4369  0070 1a06          	or	a,(OFST+6,sp)
4371  0072 2006          	jp	LC005
4372  0074               L3732:
4373                     ; 1280     else IO_16to9_sent &= (uint8_t)~mask;
4375  0074 7b06          	ld	a,(OFST+6,sp)
4376  0076 43            	cpl	a
4377  0077 c40101        	and	a,_IO_16to9_sent
4378  007a               LC005:
4379  007a c70101        	ld	_IO_16to9_sent,a
4380  007d 2017          	jra	L7732
4381  007f               L1732:
4382                     ; 1284     if (IO_8to1 & mask) IO_8to1_sent |= mask;
4384  007f c60106        	ld	a,_IO_8to1
4385  0082 1506          	bcp	a,(OFST+6,sp)
4386  0084 2707          	jreq	L1042
4389  0086 c60100        	ld	a,_IO_8to1_sent
4390  0089 1a06          	or	a,(OFST+6,sp)
4392  008b 2006          	jp	LC004
4393  008d               L1042:
4394                     ; 1285     else IO_8to1_sent &= (uint8_t)~mask;
4396  008d 7b06          	ld	a,(OFST+6,sp)
4397  008f 43            	cpl	a
4398  0090 c40100        	and	a,_IO_8to1_sent
4399  0093               LC004:
4400  0093 c70100        	ld	_IO_8to1_sent,a
4401  0096               L7732:
4402                     ; 1287 }
4405  0096 85            	popw	x
4406  0097 81            	ret	
4455                     ; 1290 void publish_pinstate_all(void)
4455                     ; 1291 {
4456                     .text:	section	.text,new
4457  0000               _publish_pinstate_all:
4459  0000 89            	pushw	x
4460       00000002      OFST:	set	2
4463                     ; 1297   j = IO_16to9;
4465  0001 c60107        	ld	a,_IO_16to9
4466  0004 6b02          	ld	(OFST+0,sp),a
4468                     ; 1298   k = IO_8to1;
4470  0006 c60106        	ld	a,_IO_8to1
4471  0009 6b01          	ld	(OFST-1,sp),a
4473                     ; 1301   if (invert_input == 0xff) j = (uint8_t)(~j);
4475  000b c600fe        	ld	a,_invert_input
4476  000e 4c            	inc	a
4477  000f 2602          	jrne	L3242
4480  0011 0302          	cpl	(OFST+0,sp)
4482  0013               L3242:
4483                     ; 1303   application_message[0] = j;
4485  0013 7b02          	ld	a,(OFST+0,sp)
4486  0015 c7008c        	ld	_application_message,a
4487                     ; 1304   application_message[1] = k;
4489  0018 7b01          	ld	a,(OFST-1,sp)
4490  001a c7008d        	ld	_application_message+1,a
4491                     ; 1305   application_message[2] = '\0';
4493  001d 725f008e      	clr	_application_message+2
4494                     ; 1307   topic_base[topic_base_len] = '\0';
4496  0021 5f            	clrw	x
4497  0022 c6000c        	ld	a,_topic_base_len
4498  0025 97            	ld	xl,a
4499  0026 724f000d      	clr	(_topic_base,x)
4500                     ; 1308   strcat(topic_base, "/state");
4502  002a ae000f        	ldw	x,#L5242
4503  002d 89            	pushw	x
4504  002e ae000d        	ldw	x,#_topic_base
4505  0031 cd0000        	call	_strcat
4507  0034 85            	popw	x
4508                     ; 1311   mqtt_publish(&mqttclient,
4508                     ; 1312                topic_base,
4508                     ; 1313 	       application_message,
4508                     ; 1314 	       2,
4508                     ; 1315 	       MQTT_PUBLISH_QOS_0);
4510  0035 4b00          	push	#0
4511  0037 ae0002        	ldw	x,#2
4512  003a 89            	pushw	x
4513  003b ae008c        	ldw	x,#_application_message
4514  003e 89            	pushw	x
4515  003f ae000d        	ldw	x,#_topic_base
4516  0042 89            	pushw	x
4517  0043 ae005e        	ldw	x,#_mqttclient
4518  0046 cd0000        	call	_mqtt_publish
4520                     ; 1316 }
4523  0049 5b09          	addw	sp,#9
4524  004b 81            	ret	
4549                     ; 1321 void unlock_eeprom(void)
4549                     ; 1322 {
4550                     .text:	section	.text,new
4551  0000               _unlock_eeprom:
4555  0000 2008          	jra	L1442
4556  0002               L7342:
4557                     ; 1335     FLASH_DUKR = 0xAE; // MASS key 1
4559  0002 35ae5064      	mov	_FLASH_DUKR,#174
4560                     ; 1336     FLASH_DUKR = 0x56; // MASS key 2
4562  0006 35565064      	mov	_FLASH_DUKR,#86
4563  000a               L1442:
4564                     ; 1334   while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
4566  000a 7207505ff3    	btjf	_FLASH_IAPSR,#3,L7342
4567                     ; 1364 }
4570  000f 81            	ret	
4656                     ; 1367 void check_eeprom_settings(void)
4656                     ; 1368 {
4657                     .text:	section	.text,new
4658  0000               _check_eeprom_settings:
4660  0000 88            	push	a
4661       00000001      OFST:	set	1
4664                     ; 1380   if ((magic4 == 0x55) && 
4664                     ; 1381       (magic3 == 0xee) && 
4664                     ; 1382       (magic2 == 0x0f) && 
4664                     ; 1383       (magic1 == 0xf0)) {
4666  0001 c6002e        	ld	a,_magic4
4667  0004 a155          	cp	a,#85
4668  0006 2703cc00db    	jrne	L5252
4670  000b c6002d        	ld	a,_magic3
4671  000e a1ee          	cp	a,#238
4672  0010 26f6          	jrne	L5252
4674  0012 c6002c        	ld	a,_magic2
4675  0015 a10f          	cp	a,#15
4676  0017 26ef          	jrne	L5252
4678  0019 c6002b        	ld	a,_magic1
4679  001c a1f0          	cp	a,#240
4680  001e 26e8          	jrne	L5252
4681                     ; 1388     uip_ipaddr(IpAddr, stored_hostaddr[3], stored_hostaddr[2], stored_hostaddr[1], stored_hostaddr[0]);
4683  0020 c6002a        	ld	a,_stored_hostaddr+3
4684  0023 97            	ld	xl,a
4685  0024 c60029        	ld	a,_stored_hostaddr+2
4686  0027 02            	rlwa	x,a
4687  0028 cf0098        	ldw	_IpAddr,x
4690  002b c60028        	ld	a,_stored_hostaddr+1
4691  002e 97            	ld	xl,a
4692  002f c60027        	ld	a,_stored_hostaddr
4693  0032 02            	rlwa	x,a
4694  0033 cf009a        	ldw	_IpAddr+2,x
4695                     ; 1389     uip_sethostaddr(IpAddr);
4697  0036 ce0098        	ldw	x,_IpAddr
4698  0039 cf0000        	ldw	_uip_hostaddr,x
4701  003c ce009a        	ldw	x,_IpAddr+2
4702  003f cf0002        	ldw	_uip_hostaddr+2,x
4703                     ; 1392     uip_ipaddr(IpAddr,
4705  0042 c60026        	ld	a,_stored_draddr+3
4706  0045 97            	ld	xl,a
4707  0046 c60025        	ld	a,_stored_draddr+2
4708  0049 02            	rlwa	x,a
4709  004a cf0098        	ldw	_IpAddr,x
4712  004d c60024        	ld	a,_stored_draddr+1
4713  0050 97            	ld	xl,a
4714  0051 c60023        	ld	a,_stored_draddr
4715  0054 02            	rlwa	x,a
4716  0055 cf009a        	ldw	_IpAddr+2,x
4717                     ; 1397     uip_setdraddr(IpAddr);
4719  0058 ce0098        	ldw	x,_IpAddr
4720  005b cf0000        	ldw	_uip_draddr,x
4723  005e ce009a        	ldw	x,_IpAddr+2
4724  0061 cf0002        	ldw	_uip_draddr+2,x
4725                     ; 1400     uip_ipaddr(IpAddr,
4727  0064 c60022        	ld	a,_stored_netmask+3
4728  0067 97            	ld	xl,a
4729  0068 c60021        	ld	a,_stored_netmask+2
4730  006b 02            	rlwa	x,a
4731  006c cf0098        	ldw	_IpAddr,x
4734  006f c60020        	ld	a,_stored_netmask+1
4735  0072 97            	ld	xl,a
4736  0073 c6001f        	ld	a,_stored_netmask
4737  0076 02            	rlwa	x,a
4738  0077 cf009a        	ldw	_IpAddr+2,x
4739                     ; 1405     uip_setnetmask(IpAddr);
4741  007a ce0098        	ldw	x,_IpAddr
4742  007d cf0000        	ldw	_uip_netmask,x
4745  0080 ce009a        	ldw	x,_IpAddr+2
4746  0083 cf0002        	ldw	_uip_netmask+2,x
4747                     ; 1409     uip_ipaddr(IpAddr,
4749  0086 c60034        	ld	a,_stored_mqttserveraddr+3
4750  0089 97            	ld	xl,a
4751  008a c60033        	ld	a,_stored_mqttserveraddr+2
4752  008d 02            	rlwa	x,a
4753  008e cf0098        	ldw	_IpAddr,x
4756  0091 c60032        	ld	a,_stored_mqttserveraddr+1
4757  0094 97            	ld	xl,a
4758  0095 c60031        	ld	a,_stored_mqttserveraddr
4759  0098 02            	rlwa	x,a
4760  0099 cf009a        	ldw	_IpAddr+2,x
4761                     ; 1414     uip_setmqttserveraddr(IpAddr);
4763  009c ce0098        	ldw	x,_IpAddr
4764  009f cf0000        	ldw	_uip_mqttserveraddr,x
4767  00a2 ce009a        	ldw	x,_IpAddr+2
4768  00a5 cf0002        	ldw	_uip_mqttserveraddr+2,x
4769                     ; 1416     Port_Mqttd = stored_mqttport;
4771  00a8 ce002f        	ldw	x,_stored_mqttport
4772  00ab cf008f        	ldw	_Port_Mqttd,x
4773                     ; 1420     Port_Httpd = stored_port;
4775  00ae ce001d        	ldw	x,_stored_port
4776  00b1 cf009c        	ldw	_Port_Httpd,x
4777                     ; 1425     uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
4779  00b4 55001c0000    	mov	_uip_ethaddr,_stored_uip_ethaddr_oct+5
4780                     ; 1426     uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
4782  00b9 55001b0001    	mov	_uip_ethaddr+1,_stored_uip_ethaddr_oct+4
4783                     ; 1427     uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
4785  00be 55001a0002    	mov	_uip_ethaddr+2,_stored_uip_ethaddr_oct+3
4786                     ; 1428     uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
4788  00c3 5500190003    	mov	_uip_ethaddr+3,_stored_uip_ethaddr_oct+2
4789                     ; 1429     uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
4791  00c8 5500180004    	mov	_uip_ethaddr+4,_stored_uip_ethaddr_oct+1
4792                     ; 1430     uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
4794  00cd 5500170005    	mov	_uip_ethaddr+5,_stored_uip_ethaddr_oct
4795                     ; 1436     check_eeprom_IOpin_settings();
4797  00d2 cd0000        	call	_check_eeprom_IOpin_settings
4799                     ; 1439     write_output_registers();
4801  00d5 cd0000        	call	_write_output_registers
4804  00d8 cc033a        	jra	L3252
4805  00db               L5252:
4806                     ; 1448     uip_ipaddr(IpAddr, 192,168,1,4);
4808  00db aec0a8        	ldw	x,#49320
4809  00de cf0098        	ldw	_IpAddr,x
4812  00e1 ae0104        	ldw	x,#260
4813  00e4 cf009a        	ldw	_IpAddr+2,x
4814                     ; 1449     uip_sethostaddr(IpAddr);
4816  00e7 ce0098        	ldw	x,_IpAddr
4817  00ea cf0000        	ldw	_uip_hostaddr,x
4820  00ed ce009a        	ldw	x,_IpAddr+2
4821  00f0 cf0002        	ldw	_uip_hostaddr+2,x
4822                     ; 1451     stored_hostaddr[3] = 192;	// MSB
4824  00f3 a6c0          	ld	a,#192
4825  00f5 ae002a        	ldw	x,#_stored_hostaddr+3
4826  00f8 cd0000        	call	c_eewrc
4828                     ; 1452     stored_hostaddr[2] = 168;	//
4830  00fb a6a8          	ld	a,#168
4831  00fd ae0029        	ldw	x,#_stored_hostaddr+2
4832  0100 cd0000        	call	c_eewrc
4834                     ; 1453     stored_hostaddr[1] = 1;	//
4836  0103 a601          	ld	a,#1
4837  0105 ae0028        	ldw	x,#_stored_hostaddr+1
4838  0108 cd0000        	call	c_eewrc
4840                     ; 1454     stored_hostaddr[0] = 4;	// LSB
4842  010b a604          	ld	a,#4
4843  010d ae0027        	ldw	x,#_stored_hostaddr
4844  0110 cd0000        	call	c_eewrc
4846                     ; 1457     uip_ipaddr(IpAddr, 192,168,1,1);
4848  0113 aec0a8        	ldw	x,#49320
4849  0116 cf0098        	ldw	_IpAddr,x
4852  0119 ae0101        	ldw	x,#257
4853  011c cf009a        	ldw	_IpAddr+2,x
4854                     ; 1458     uip_setdraddr(IpAddr);
4856  011f ce0098        	ldw	x,_IpAddr
4857  0122 cf0000        	ldw	_uip_draddr,x
4860  0125 ce009a        	ldw	x,_IpAddr+2
4861  0128 cf0002        	ldw	_uip_draddr+2,x
4862                     ; 1460     stored_draddr[3] = 192;	// MSB
4864  012b a6c0          	ld	a,#192
4865  012d ae0026        	ldw	x,#_stored_draddr+3
4866  0130 cd0000        	call	c_eewrc
4868                     ; 1461     stored_draddr[2] = 168;	//
4870  0133 a6a8          	ld	a,#168
4871  0135 ae0025        	ldw	x,#_stored_draddr+2
4872  0138 cd0000        	call	c_eewrc
4874                     ; 1462     stored_draddr[1] = 1;		//
4876  013b a601          	ld	a,#1
4877  013d ae0024        	ldw	x,#_stored_draddr+1
4878  0140 cd0000        	call	c_eewrc
4880                     ; 1463     stored_draddr[0] = 1;		// LSB
4882  0143 a601          	ld	a,#1
4883  0145 ae0023        	ldw	x,#_stored_draddr
4884  0148 cd0000        	call	c_eewrc
4886                     ; 1466     uip_ipaddr(IpAddr, 255,255,255,0);
4888  014b aeffff        	ldw	x,#65535
4889  014e cf0098        	ldw	_IpAddr,x
4892  0151 aeff00        	ldw	x,#65280
4893  0154 cf009a        	ldw	_IpAddr+2,x
4894                     ; 1467     uip_setnetmask(IpAddr);
4896  0157 ce0098        	ldw	x,_IpAddr
4897  015a cf0000        	ldw	_uip_netmask,x
4900  015d ce009a        	ldw	x,_IpAddr+2
4901  0160 cf0002        	ldw	_uip_netmask+2,x
4902                     ; 1469     stored_netmask[3] = 255;	// MSB
4904  0163 a6ff          	ld	a,#255
4905  0165 ae0022        	ldw	x,#_stored_netmask+3
4906  0168 cd0000        	call	c_eewrc
4908                     ; 1470     stored_netmask[2] = 255;	//
4910  016b a6ff          	ld	a,#255
4911  016d ae0021        	ldw	x,#_stored_netmask+2
4912  0170 cd0000        	call	c_eewrc
4914                     ; 1471     stored_netmask[1] = 255;	//
4916  0173 a6ff          	ld	a,#255
4917  0175 ae0020        	ldw	x,#_stored_netmask+1
4918  0178 cd0000        	call	c_eewrc
4920                     ; 1472     stored_netmask[0] = 0;	// LSB
4922  017b 4f            	clr	a
4923  017c ae001f        	ldw	x,#_stored_netmask
4924  017f cd0000        	call	c_eewrc
4926                     ; 1476     uip_ipaddr(IpAddr, 0,0,0,0);
4928  0182 5f            	clrw	x
4929  0183 cf0098        	ldw	_IpAddr,x
4932  0186 cf009a        	ldw	_IpAddr+2,x
4933                     ; 1477     uip_setmqttserveraddr(IpAddr);
4935  0189 cf0000        	ldw	_uip_mqttserveraddr,x
4938  018c cf0002        	ldw	_uip_mqttserveraddr+2,x
4939                     ; 1480     stored_mqttserveraddr[3] = 0;	// MSB
4941  018f 4f            	clr	a
4942  0190 ae0034        	ldw	x,#_stored_mqttserveraddr+3
4943  0193 cd0000        	call	c_eewrc
4945                     ; 1481     stored_mqttserveraddr[2] = 0;	//
4947  0196 4f            	clr	a
4948  0197 ae0033        	ldw	x,#_stored_mqttserveraddr+2
4949  019a cd0000        	call	c_eewrc
4951                     ; 1482     stored_mqttserveraddr[1] = 0;	//
4953  019d 4f            	clr	a
4954  019e ae0032        	ldw	x,#_stored_mqttserveraddr+1
4955  01a1 cd0000        	call	c_eewrc
4957                     ; 1483     stored_mqttserveraddr[0] = 0;	// LSB
4959  01a4 4f            	clr	a
4960  01a5 ae0031        	ldw	x,#_stored_mqttserveraddr
4961  01a8 cd0000        	call	c_eewrc
4963                     ; 1486     stored_mqttport = 1883;		// Port
4965  01ab ae075b        	ldw	x,#1883
4966  01ae 89            	pushw	x
4967  01af ae002f        	ldw	x,#_stored_mqttport
4968  01b2 cd0000        	call	c_eewrw
4970  01b5 85            	popw	x
4971                     ; 1488     Port_Mqttd = 1883;
4973  01b6 ae075b        	ldw	x,#1883
4974  01b9 cf008f        	ldw	_Port_Mqttd,x
4975                     ; 1491     for(i=0; i<11; i++) { stored_mqtt_username[i] = '\0'; }
4977  01bc 4f            	clr	a
4978  01bd 6b01          	ld	(OFST+0,sp),a
4980  01bf               L5652:
4983  01bf 5f            	clrw	x
4984  01c0 97            	ld	xl,a
4985  01c1 4f            	clr	a
4986  01c2 1c0035        	addw	x,#_stored_mqtt_username
4987  01c5 cd0000        	call	c_eewrc
4991  01c8 0c01          	inc	(OFST+0,sp)
4995  01ca 7b01          	ld	a,(OFST+0,sp)
4996  01cc a10b          	cp	a,#11
4997  01ce 25ef          	jrult	L5652
4998                     ; 1492     for(i=0; i<11; i++) { stored_mqtt_password[i] = '\0'; }
5000  01d0 4f            	clr	a
5001  01d1 6b01          	ld	(OFST+0,sp),a
5003  01d3               L3752:
5006  01d3 5f            	clrw	x
5007  01d4 97            	ld	xl,a
5008  01d5 4f            	clr	a
5009  01d6 1c0040        	addw	x,#_stored_mqtt_password
5010  01d9 cd0000        	call	c_eewrc
5014  01dc 0c01          	inc	(OFST+0,sp)
5018  01de 7b01          	ld	a,(OFST+0,sp)
5019  01e0 a10b          	cp	a,#11
5020  01e2 25ef          	jrult	L3752
5021                     ; 1497     stored_port = 8080;
5023  01e4 ae1f90        	ldw	x,#8080
5024  01e7 89            	pushw	x
5025  01e8 ae001d        	ldw	x,#_stored_port
5026  01eb cd0000        	call	c_eewrw
5028  01ee 85            	popw	x
5029                     ; 1499     Port_Httpd = 8080;
5031  01ef ae1f90        	ldw	x,#8080
5032  01f2 cf009c        	ldw	_Port_Httpd,x
5033                     ; 1515     stored_uip_ethaddr_oct[5] = 0xc2;	//MAC MSB
5035  01f5 a6c2          	ld	a,#194
5036  01f7 ae001c        	ldw	x,#_stored_uip_ethaddr_oct+5
5037  01fa cd0000        	call	c_eewrc
5039                     ; 1516     stored_uip_ethaddr_oct[4] = 0x4d;
5041  01fd a64d          	ld	a,#77
5042  01ff ae001b        	ldw	x,#_stored_uip_ethaddr_oct+4
5043  0202 cd0000        	call	c_eewrc
5045                     ; 1517     stored_uip_ethaddr_oct[3] = 0x69;
5047  0205 a669          	ld	a,#105
5048  0207 ae001a        	ldw	x,#_stored_uip_ethaddr_oct+3
5049  020a cd0000        	call	c_eewrc
5051                     ; 1518     stored_uip_ethaddr_oct[2] = 0x6b;
5053  020d a66b          	ld	a,#107
5054  020f ae0019        	ldw	x,#_stored_uip_ethaddr_oct+2
5055  0212 cd0000        	call	c_eewrc
5057                     ; 1519     stored_uip_ethaddr_oct[1] = 0x65;
5059  0215 a665          	ld	a,#101
5060  0217 ae0018        	ldw	x,#_stored_uip_ethaddr_oct+1
5061  021a cd0000        	call	c_eewrc
5063                     ; 1520     stored_uip_ethaddr_oct[0] = 0x00;	//MAC LSB
5065  021d 4f            	clr	a
5066  021e ae0017        	ldw	x,#_stored_uip_ethaddr_oct
5067  0221 cd0000        	call	c_eewrc
5069                     ; 1522     uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
5071  0224 35c20000      	mov	_uip_ethaddr,#194
5072                     ; 1523     uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
5074  0228 354d0001      	mov	_uip_ethaddr+1,#77
5075                     ; 1524     uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
5077  022c 35690002      	mov	_uip_ethaddr+2,#105
5078                     ; 1525     uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
5080  0230 356b0003      	mov	_uip_ethaddr+3,#107
5081                     ; 1526     uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
5083  0234 35650004      	mov	_uip_ethaddr+4,#101
5084                     ; 1527     uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
5086  0238 725f0005      	clr	_uip_ethaddr+5
5087                     ; 1530     stored_devicename[0] =  'N';
5089  023c a64e          	ld	a,#78
5090  023e ae0000        	ldw	x,#_stored_devicename
5091  0241 cd0000        	call	c_eewrc
5093                     ; 1531     stored_devicename[1] =  'e';
5095  0244 a665          	ld	a,#101
5096  0246 ae0001        	ldw	x,#_stored_devicename+1
5097  0249 cd0000        	call	c_eewrc
5099                     ; 1532     stored_devicename[2] =  'w';
5101  024c a677          	ld	a,#119
5102  024e ae0002        	ldw	x,#_stored_devicename+2
5103  0251 cd0000        	call	c_eewrc
5105                     ; 1533     stored_devicename[3] =  'D';
5107  0254 a644          	ld	a,#68
5108  0256 ae0003        	ldw	x,#_stored_devicename+3
5109  0259 cd0000        	call	c_eewrc
5111                     ; 1534     stored_devicename[4] =  'e';
5113  025c a665          	ld	a,#101
5114  025e ae0004        	ldw	x,#_stored_devicename+4
5115  0261 cd0000        	call	c_eewrc
5117                     ; 1535     stored_devicename[5] =  'v';
5119  0264 a676          	ld	a,#118
5120  0266 ae0005        	ldw	x,#_stored_devicename+5
5121  0269 cd0000        	call	c_eewrc
5123                     ; 1536     stored_devicename[6] =  'i';
5125  026c a669          	ld	a,#105
5126  026e ae0006        	ldw	x,#_stored_devicename+6
5127  0271 cd0000        	call	c_eewrc
5129                     ; 1537     stored_devicename[7] =  'c';
5131  0274 a663          	ld	a,#99
5132  0276 ae0007        	ldw	x,#_stored_devicename+7
5133  0279 cd0000        	call	c_eewrc
5135                     ; 1538     stored_devicename[8] =  'e';
5137  027c a665          	ld	a,#101
5138  027e ae0008        	ldw	x,#_stored_devicename+8
5139  0281 cd0000        	call	c_eewrc
5141                     ; 1539     stored_devicename[9] =  '0';
5143  0284 a630          	ld	a,#48
5144  0286 ae0009        	ldw	x,#_stored_devicename+9
5145  0289 cd0000        	call	c_eewrc
5147                     ; 1540     stored_devicename[10] = '0';
5149  028c a630          	ld	a,#48
5150  028e ae000a        	ldw	x,#_stored_devicename+10
5151  0291 cd0000        	call	c_eewrc
5153                     ; 1541     stored_devicename[11] = '0';
5155  0294 a630          	ld	a,#48
5156  0296 ae000b        	ldw	x,#_stored_devicename+11
5157  0299 cd0000        	call	c_eewrc
5159                     ; 1542     for (i=12; i<20; i++) stored_devicename[i] = '\0';
5161  029c a60c          	ld	a,#12
5162  029e 6b01          	ld	(OFST+0,sp),a
5164  02a0               L1062:
5167  02a0 5f            	clrw	x
5168  02a1 97            	ld	xl,a
5169  02a2 4f            	clr	a
5170  02a3 1c0000        	addw	x,#_stored_devicename
5171  02a6 cd0000        	call	c_eewrc
5175  02a9 0c01          	inc	(OFST+0,sp)
5179  02ab 7b01          	ld	a,(OFST+0,sp)
5180  02ad a114          	cp	a,#20
5181  02af 25ef          	jrult	L1062
5182                     ; 1547     stored_config_settings[0] = '0'; // Set to Invert Output OFF
5184  02b1 a630          	ld	a,#48
5185  02b3 ae004c        	ldw	x,#_stored_config_settings
5186  02b6 cd0000        	call	c_eewrc
5188                     ; 1548     stored_config_settings[1] = '0'; // Set to Invert Input Off
5190  02b9 a630          	ld	a,#48
5191  02bb ae004d        	ldw	x,#_stored_config_settings+1
5192  02be cd0000        	call	c_eewrc
5194                     ; 1549     stored_config_settings[2] = '2'; // Set to Retain pin states
5196  02c1 a632          	ld	a,#50
5197  02c3 ae004e        	ldw	x,#_stored_config_settings+2
5198  02c6 cd0000        	call	c_eewrc
5200                     ; 1550     stored_config_settings[3] = '0'; // Set to Half Duplex
5202  02c9 a630          	ld	a,#48
5203  02cb ae004f        	ldw	x,#_stored_config_settings+3
5204  02ce cd0000        	call	c_eewrc
5206                     ; 1551     stored_config_settings[4] = '0'; // undefined
5208  02d1 a630          	ld	a,#48
5209  02d3 ae0050        	ldw	x,#_stored_config_settings+4
5210  02d6 cd0000        	call	c_eewrc
5212                     ; 1552     stored_config_settings[5] = '0'; // undefined
5214  02d9 a630          	ld	a,#48
5215  02db ae0051        	ldw	x,#_stored_config_settings+5
5216  02de cd0000        	call	c_eewrc
5218                     ; 1553     invert_output = 0x00;			// Turn off output invert bit
5220  02e1 725f00ff      	clr	_invert_output
5221                     ; 1554     invert_input = 0x00;			// Turn off output invert bit
5223  02e5 725f00fe      	clr	_invert_input
5224                     ; 1555     IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9 = 0x00;
5226  02e9 4f            	clr	a
5227  02ea ae004b        	ldw	x,#_stored_IO_16to9
5228  02ed cd0000        	call	c_eewrc
5230  02f0 725f0101      	clr	_IO_16to9_sent
5231  02f4 725f0103      	clr	_IO_16to9_new2
5232  02f8 725f0105      	clr	_IO_16to9_new1
5233  02fc 725f0107      	clr	_IO_16to9
5234                     ; 1556     IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1  = 0x00;
5236  0300 4f            	clr	a
5237  0301 ae0014        	ldw	x,#_stored_IO_8to1
5238  0304 cd0000        	call	c_eewrc
5240  0307 725f0100      	clr	_IO_8to1_sent
5241  030b 725f0102      	clr	_IO_8to1_new2
5242  030f 725f0104      	clr	_IO_8to1_new1
5243  0313 725f0106      	clr	_IO_8to1
5244                     ; 1557     write_output_registers();          // Set Relay Control outputs
5246  0317 cd0000        	call	_write_output_registers
5248                     ; 1560     magic4 = 0x55;		// MSB
5250  031a a655          	ld	a,#85
5251  031c ae002e        	ldw	x,#_magic4
5252  031f cd0000        	call	c_eewrc
5254                     ; 1561     magic3 = 0xee;		//
5256  0322 a6ee          	ld	a,#238
5257  0324 ae002d        	ldw	x,#_magic3
5258  0327 cd0000        	call	c_eewrc
5260                     ; 1562     magic2 = 0x0f;		//
5262  032a a60f          	ld	a,#15
5263  032c ae002c        	ldw	x,#_magic2
5264  032f cd0000        	call	c_eewrc
5266                     ; 1563     magic1 = 0xf0;		// LSB
5268  0332 a6f0          	ld	a,#240
5269  0334 ae002b        	ldw	x,#_magic1
5270  0337 cd0000        	call	c_eewrc
5272  033a               L3252:
5273                     ; 1568   for (i=0; i<4; i++) {
5275  033a 4f            	clr	a
5276  033b 6b01          	ld	(OFST+0,sp),a
5278  033d               L7062:
5279                     ; 1569     Pending_hostaddr[i] = stored_hostaddr[i];
5281  033d 5f            	clrw	x
5282  033e 97            	ld	xl,a
5283  033f d60027        	ld	a,(_stored_hostaddr,x)
5284  0342 d700dc        	ld	(_Pending_hostaddr,x),a
5285                     ; 1570     Pending_draddr[i] = stored_draddr[i];
5287  0345 5f            	clrw	x
5288  0346 7b01          	ld	a,(OFST+0,sp)
5289  0348 97            	ld	xl,a
5290  0349 d60023        	ld	a,(_stored_draddr,x)
5291  034c d700d8        	ld	(_Pending_draddr,x),a
5292                     ; 1571     Pending_netmask[i] = stored_netmask[i];
5294  034f 5f            	clrw	x
5295  0350 7b01          	ld	a,(OFST+0,sp)
5296  0352 97            	ld	xl,a
5297  0353 d6001f        	ld	a,(_stored_netmask,x)
5298  0356 d700d4        	ld	(_Pending_netmask,x),a
5299                     ; 1568   for (i=0; i<4; i++) {
5301  0359 0c01          	inc	(OFST+0,sp)
5305  035b 7b01          	ld	a,(OFST+0,sp)
5306  035d a104          	cp	a,#4
5307  035f 25dc          	jrult	L7062
5308                     ; 1574   Pending_port = stored_port;
5310  0361 ce001d        	ldw	x,_stored_port
5311  0364 cf00d2        	ldw	_Pending_port,x
5312                     ; 1576   for (i=0; i<20; i++) {
5314  0367 4f            	clr	a
5315  0368 6b01          	ld	(OFST+0,sp),a
5317  036a               L5162:
5318                     ; 1577     Pending_devicename[i] = stored_devicename[i];
5320  036a 5f            	clrw	x
5321  036b 97            	ld	xl,a
5322  036c d60000        	ld	a,(_stored_devicename,x)
5323  036f d700be        	ld	(_Pending_devicename,x),a
5324                     ; 1576   for (i=0; i<20; i++) {
5326  0372 0c01          	inc	(OFST+0,sp)
5330  0374 7b01          	ld	a,(OFST+0,sp)
5331  0376 a114          	cp	a,#20
5332  0378 25f0          	jrult	L5162
5333                     ; 1580   for (i=0; i<6; i++) {
5335  037a 4f            	clr	a
5336  037b 6b01          	ld	(OFST+0,sp),a
5338  037d               L3262:
5339                     ; 1581     Pending_config_settings[i] = stored_config_settings[i];
5341  037d 5f            	clrw	x
5342  037e 97            	ld	xl,a
5343  037f d6004c        	ld	a,(_stored_config_settings,x)
5344  0382 d700b8        	ld	(_Pending_config_settings,x),a
5345                     ; 1582     Pending_uip_ethaddr_oct[i] = stored_uip_ethaddr_oct[i];
5347  0385 5f            	clrw	x
5348  0386 7b01          	ld	a,(OFST+0,sp)
5349  0388 97            	ld	xl,a
5350  0389 d60017        	ld	a,(_stored_uip_ethaddr_oct,x)
5351  038c d700b2        	ld	(_Pending_uip_ethaddr_oct,x),a
5352                     ; 1580   for (i=0; i<6; i++) {
5354  038f 0c01          	inc	(OFST+0,sp)
5358  0391 7b01          	ld	a,(OFST+0,sp)
5359  0393 a106          	cp	a,#6
5360  0395 25e6          	jrult	L3262
5361                     ; 1586   for (i=0; i<4; i++) {
5363  0397 4f            	clr	a
5364  0398 6b01          	ld	(OFST+0,sp),a
5366  039a               L1362:
5367                     ; 1587     Pending_mqttserveraddr[i] = stored_mqttserveraddr[i];
5369  039a 5f            	clrw	x
5370  039b 97            	ld	xl,a
5371  039c d60031        	ld	a,(_stored_mqttserveraddr,x)
5372  039f d700f8        	ld	(_Pending_mqttserveraddr,x),a
5373                     ; 1586   for (i=0; i<4; i++) {
5375  03a2 0c01          	inc	(OFST+0,sp)
5379  03a4 7b01          	ld	a,(OFST+0,sp)
5380  03a6 a104          	cp	a,#4
5381  03a8 25f0          	jrult	L1362
5382                     ; 1589   Pending_mqttport = stored_mqttport;
5384  03aa ce002f        	ldw	x,_stored_mqttport
5385  03ad cf00f6        	ldw	_Pending_mqttport,x
5386                     ; 1590   for (i=0; i<11; i++) {
5388  03b0 4f            	clr	a
5389  03b1 6b01          	ld	(OFST+0,sp),a
5391  03b3               L7362:
5392                     ; 1591     Pending_mqtt_username[i] = stored_mqtt_username[i];
5394  03b3 5f            	clrw	x
5395  03b4 97            	ld	xl,a
5396  03b5 d60035        	ld	a,(_stored_mqtt_username,x)
5397  03b8 d700eb        	ld	(_Pending_mqtt_username,x),a
5398                     ; 1592     Pending_mqtt_password[i] = stored_mqtt_password[i];
5400  03bb 5f            	clrw	x
5401  03bc 7b01          	ld	a,(OFST+0,sp)
5402  03be 97            	ld	xl,a
5403  03bf d60040        	ld	a,(_stored_mqtt_password,x)
5404  03c2 d700e0        	ld	(_Pending_mqtt_password,x),a
5405                     ; 1590   for (i=0; i<11; i++) {
5407  03c5 0c01          	inc	(OFST+0,sp)
5411  03c7 7b01          	ld	a,(OFST+0,sp)
5412  03c9 a10b          	cp	a,#11
5413  03cb 25e6          	jrult	L7362
5414                     ; 1595   strcat(topic_base, stored_devicename);
5416  03cd ae0000        	ldw	x,#_stored_devicename
5417  03d0 89            	pushw	x
5418  03d1 ae000d        	ldw	x,#_topic_base
5419  03d4 cd0000        	call	_strcat
5421  03d7 85            	popw	x
5422                     ; 1598   topic_base_len = (uint8_t)strlen(topic_base);
5424  03d8 ae000d        	ldw	x,#_topic_base
5425  03db cd0000        	call	_strlen
5427  03de 9f            	ld	a,xl
5428  03df c7000c        	ld	_topic_base_len,a
5429                     ; 1602   update_mac_string();
5431  03e2 cd0000        	call	_update_mac_string
5433                     ; 1604 }
5436  03e5 84            	pop	a
5437  03e6 81            	ret	
5474                     ; 1607 void check_eeprom_IOpin_settings(void)
5474                     ; 1608 {
5475                     .text:	section	.text,new
5476  0000               _check_eeprom_IOpin_settings:
5480                     ; 1614   if (stored_config_settings[0] != '0' && stored_config_settings[0] != '1') {
5482  0000 c6004c        	ld	a,_stored_config_settings
5483  0003 a130          	cp	a,#48
5484  0005 270c          	jreq	L5562
5486  0007 a131          	cp	a,#49
5487  0009 2708          	jreq	L5562
5488                     ; 1615     stored_config_settings[0] = '0';
5490  000b a630          	ld	a,#48
5491  000d ae004c        	ldw	x,#_stored_config_settings
5492  0010 cd0000        	call	c_eewrc
5494  0013               L5562:
5495                     ; 1617   if (stored_config_settings[1] != '0' && stored_config_settings[1] != '1') {
5497  0013 c6004d        	ld	a,_stored_config_settings+1
5498  0016 a130          	cp	a,#48
5499  0018 270c          	jreq	L7562
5501  001a a131          	cp	a,#49
5502  001c 2708          	jreq	L7562
5503                     ; 1618     stored_config_settings[1] = '0';
5505  001e a630          	ld	a,#48
5506  0020 ae004d        	ldw	x,#_stored_config_settings+1
5507  0023 cd0000        	call	c_eewrc
5509  0026               L7562:
5510                     ; 1620   if (stored_config_settings[2] != '0' && stored_config_settings[2] != '1' && stored_config_settings[2] != '2') {
5512  0026 c6004e        	ld	a,_stored_config_settings+2
5513  0029 a130          	cp	a,#48
5514  002b 2710          	jreq	L1662
5516  002d a131          	cp	a,#49
5517  002f 270c          	jreq	L1662
5519  0031 a132          	cp	a,#50
5520  0033 2708          	jreq	L1662
5521                     ; 1621     stored_config_settings[2] = '2';
5523  0035 a632          	ld	a,#50
5524  0037 ae004e        	ldw	x,#_stored_config_settings+2
5525  003a cd0000        	call	c_eewrc
5527  003d               L1662:
5528                     ; 1623   if (stored_config_settings[3] != '0' && stored_config_settings[3] != '1') {
5530  003d c6004f        	ld	a,_stored_config_settings+3
5531  0040 a130          	cp	a,#48
5532  0042 270c          	jreq	L3662
5534  0044 a131          	cp	a,#49
5535  0046 2708          	jreq	L3662
5536                     ; 1624     stored_config_settings[3] = '0';
5538  0048 a630          	ld	a,#48
5539  004a ae004f        	ldw	x,#_stored_config_settings+3
5540  004d cd0000        	call	c_eewrc
5542  0050               L3662:
5543                     ; 1626   if (stored_config_settings[4] != '0') {
5545  0050 c60050        	ld	a,_stored_config_settings+4
5546  0053 a130          	cp	a,#48
5547  0055 2708          	jreq	L5662
5548                     ; 1627     stored_config_settings[4] = '0';
5550  0057 a630          	ld	a,#48
5551  0059 ae0050        	ldw	x,#_stored_config_settings+4
5552  005c cd0000        	call	c_eewrc
5554  005f               L5662:
5555                     ; 1629   if (stored_config_settings[5] != '0') {
5557  005f c60051        	ld	a,_stored_config_settings+5
5558  0062 a130          	cp	a,#48
5559  0064 2708          	jreq	L7662
5560                     ; 1630     stored_config_settings[5] = '0';
5562  0066 a630          	ld	a,#48
5563  0068 ae0051        	ldw	x,#_stored_config_settings+5
5564  006b cd0000        	call	c_eewrc
5566  006e               L7662:
5567                     ; 1634   if (stored_config_settings[0] == '0') invert_output = 0x00;
5569  006e c6004c        	ld	a,_stored_config_settings
5570  0071 a130          	cp	a,#48
5571  0073 2606          	jrne	L1762
5574  0075 725f00ff      	clr	_invert_output
5576  0079 2004          	jra	L3762
5577  007b               L1762:
5578                     ; 1635   else invert_output = 0xff;
5580  007b 35ff00ff      	mov	_invert_output,#255
5581  007f               L3762:
5582                     ; 1638   if (stored_config_settings[1] == '0') invert_input = 0x00;
5584  007f c6004d        	ld	a,_stored_config_settings+1
5585  0082 a130          	cp	a,#48
5586  0084 2606          	jrne	L5762
5589  0086 725f00fe      	clr	_invert_input
5591  008a 2004          	jra	L7762
5592  008c               L5762:
5593                     ; 1639   else invert_input = 0xff;
5595  008c 35ff00fe      	mov	_invert_input,#255
5596  0090               L7762:
5597                     ; 1644   if (stored_config_settings[2] == '0') {
5599  0090 c6004e        	ld	a,_stored_config_settings+2
5600  0093 a130          	cp	a,#48
5601  0095 2609          	jrne	L1072
5602                     ; 1646     IO_16to9 = 0x00;
5604  0097 725f0107      	clr	_IO_16to9
5605                     ; 1647     IO_8to1 = 0x00;
5607  009b 725f0106      	clr	_IO_8to1
5610  009f 81            	ret	
5611  00a0               L1072:
5612                     ; 1649   else if (stored_config_settings[2] == '1') {
5614  00a0 a131          	cp	a,#49
5615  00a2 2609          	jrne	L5072
5616                     ; 1651     IO_16to9 = 0xff;
5618  00a4 35ff0107      	mov	_IO_16to9,#255
5619                     ; 1652     IO_8to1 = 0xff;
5621  00a8 35ff0106      	mov	_IO_8to1,#255
5624  00ac 81            	ret	
5625  00ad               L5072:
5626                     ; 1656     IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9;
5628  00ad 55004b0101    	mov	_IO_16to9_sent,_stored_IO_16to9
5629  00b2 5501010103    	mov	_IO_16to9_new2,_IO_16to9_sent
5630  00b7 5501030105    	mov	_IO_16to9_new1,_IO_16to9_new2
5631  00bc 5501050107    	mov	_IO_16to9,_IO_16to9_new1
5632                     ; 1657     IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1;
5634  00c1 5500140100    	mov	_IO_8to1_sent,_stored_IO_8to1
5635  00c6 5501000102    	mov	_IO_8to1_new2,_IO_8to1_sent
5636  00cb 5501020104    	mov	_IO_8to1_new1,_IO_8to1_new2
5637  00d0 5501040106    	mov	_IO_8to1,_IO_8to1_new1
5638                     ; 1659 }  
5641  00d5 81            	ret	
5684                     ; 1662 void update_mac_string(void)
5684                     ; 1663 {
5685                     .text:	section	.text,new
5686  0000               _update_mac_string:
5688  0000 89            	pushw	x
5689       00000002      OFST:	set	2
5692                     ; 1669   i = 5;
5694  0001 a605          	ld	a,#5
5695  0003 6b01          	ld	(OFST-1,sp),a
5697                     ; 1670   j = 0;
5699  0005 0f02          	clr	(OFST+0,sp)
5701  0007               L7272:
5702                     ; 1672     emb_itoa(stored_uip_ethaddr_oct[i], OctetArray, 16, 2);
5704  0007 4b02          	push	#2
5705  0009 4b10          	push	#16
5706  000b ae0000        	ldw	x,#_OctetArray
5707  000e 89            	pushw	x
5708  000f 7b05          	ld	a,(OFST+3,sp)
5709  0011 5f            	clrw	x
5710  0012 97            	ld	xl,a
5711  0013 d60017        	ld	a,(_stored_uip_ethaddr_oct,x)
5712  0016 b703          	ld	c_lreg+3,a
5713  0018 3f02          	clr	c_lreg+2
5714  001a 3f01          	clr	c_lreg+1
5715  001c 3f00          	clr	c_lreg
5716  001e be02          	ldw	x,c_lreg+2
5717  0020 89            	pushw	x
5718  0021 be00          	ldw	x,c_lreg
5719  0023 89            	pushw	x
5720  0024 cd0000        	call	_emb_itoa
5722  0027 5b08          	addw	sp,#8
5723                     ; 1673     mac_string[j++] = OctetArray[0];
5725  0029 7b02          	ld	a,(OFST+0,sp)
5726  002b 0c02          	inc	(OFST+0,sp)
5728  002d 5f            	clrw	x
5729  002e 97            	ld	xl,a
5730  002f c60000        	ld	a,_OctetArray
5731  0032 d700a5        	ld	(_mac_string,x),a
5732                     ; 1674     mac_string[j++] = OctetArray[1];
5734  0035 7b02          	ld	a,(OFST+0,sp)
5735  0037 0c02          	inc	(OFST+0,sp)
5737  0039 5f            	clrw	x
5738  003a 97            	ld	xl,a
5739  003b c60001        	ld	a,_OctetArray+1
5740  003e d700a5        	ld	(_mac_string,x),a
5741                     ; 1675     i--;
5743  0041 0a01          	dec	(OFST-1,sp)
5745                     ; 1671   while (j<12) {
5747  0043 7b02          	ld	a,(OFST+0,sp)
5748  0045 a10c          	cp	a,#12
5749  0047 25be          	jrult	L7272
5750                     ; 1677   mac_string[12] = '\0';
5752  0049 725f00b1      	clr	_mac_string+12
5753                     ; 1678 }
5756  004d 85            	popw	x
5757  004e 81            	ret	
5835                     ; 1681 void check_runtime_changes(void)
5835                     ; 1682 {
5836                     .text:	section	.text,new
5837  0000               _check_runtime_changes:
5839  0000 88            	push	a
5840       00000001      OFST:	set	1
5843                     ; 1695   read_input_registers();
5845  0001 cd0000        	call	_read_input_registers
5847                     ; 1697   if (parse_complete == 1 || mqtt_parse_complete == 1) {
5849  0004 c6009f        	ld	a,_parse_complete
5850  0007 4a            	dec	a
5851  0008 2706          	jreq	L3572
5853  000a c6009e        	ld	a,_mqtt_parse_complete
5854  000d 4a            	dec	a
5855  000e 2624          	jrne	L1572
5856  0010               L3572:
5857                     ; 1721     if (stored_IO_8to1 != IO_8to1) {
5859  0010 c60014        	ld	a,_stored_IO_8to1
5860  0013 c10106        	cp	a,_IO_8to1
5861  0016 2710          	jreq	L5572
5862                     ; 1725       if (stored_config_settings[2] == '2') {
5864  0018 c6004e        	ld	a,_stored_config_settings+2
5865  001b a132          	cp	a,#50
5866  001d 2609          	jrne	L5572
5867                     ; 1726         stored_IO_8to1 = IO_8to1;
5869  001f c60106        	ld	a,_IO_8to1
5870  0022 ae0014        	ldw	x,#_stored_IO_8to1
5871  0025 cd0000        	call	c_eewrc
5873  0028               L5572:
5874                     ; 1730     write_output_registers();
5876  0028 cd0000        	call	_write_output_registers
5878                     ; 1736     if (mqtt_parse_complete == 1) {
5880  002b c6009e        	ld	a,_mqtt_parse_complete
5881  002e 4a            	dec	a
5882  002f 2603          	jrne	L1572
5883                     ; 1738       mqtt_parse_complete = 0;
5885  0031 c7009e        	ld	_mqtt_parse_complete,a
5886  0034               L1572:
5887                     ; 1743   if (parse_complete == 1) {
5889  0034 c6009f        	ld	a,_parse_complete
5890  0037 4a            	dec	a
5891  0038 2703cc02c5    	jrne	L3672
5892                     ; 1784     if ((Pending_config_settings[0] != stored_config_settings[0])
5892                     ; 1785      || (stored_IO_8to1 != IO_8to1)) {
5894  003d c6004c        	ld	a,_stored_config_settings
5895  0040 c100b8        	cp	a,_Pending_config_settings
5896  0043 2608          	jrne	L7672
5898  0045 c60014        	ld	a,_stored_IO_8to1
5899  0048 c10106        	cp	a,_IO_8to1
5900  004b 272d          	jreq	L5672
5901  004d               L7672:
5902                     ; 1788       stored_config_settings[0] = Pending_config_settings[0];
5904  004d c600b8        	ld	a,_Pending_config_settings
5905  0050 ae004c        	ldw	x,#_stored_config_settings
5906  0053 cd0000        	call	c_eewrc
5908                     ; 1791       if (stored_config_settings[0] == '0') invert_output = 0x00;
5910  0056 c6004c        	ld	a,_stored_config_settings
5911  0059 a130          	cp	a,#48
5912  005b 2606          	jrne	L1772
5915  005d 725f00ff      	clr	_invert_output
5917  0061 2004          	jra	L3772
5918  0063               L1772:
5919                     ; 1792       else invert_output = 0xff;
5921  0063 35ff00ff      	mov	_invert_output,#255
5922  0067               L3772:
5923                     ; 1796       if (stored_config_settings[2] == '2') {
5925  0067 c6004e        	ld	a,_stored_config_settings+2
5926  006a a132          	cp	a,#50
5927  006c 2609          	jrne	L5772
5928                     ; 1797         stored_IO_8to1 = IO_8to1;
5930  006e c60106        	ld	a,_IO_8to1
5931  0071 ae0014        	ldw	x,#_stored_IO_8to1
5932  0074 cd0000        	call	c_eewrc
5934  0077               L5772:
5935                     ; 1801       write_output_registers();
5937  0077 cd0000        	call	_write_output_registers
5939  007a               L5672:
5940                     ; 1805     if (Pending_config_settings[1] != stored_config_settings[1]) {
5942  007a c6004d        	ld	a,_stored_config_settings+1
5943  007d c100b9        	cp	a,_Pending_config_settings+1
5944  0080 271e          	jreq	L7772
5945                     ; 1807       stored_config_settings[1] = Pending_config_settings[1];
5947  0082 c600b9        	ld	a,_Pending_config_settings+1
5948  0085 ae004d        	ldw	x,#_stored_config_settings+1
5949  0088 cd0000        	call	c_eewrc
5951                     ; 1810       if (stored_config_settings[1] == '0') invert_input = 0x00;
5953  008b c6004d        	ld	a,_stored_config_settings+1
5954  008e a130          	cp	a,#48
5955  0090 2606          	jrne	L1003
5958  0092 725f00fe      	clr	_invert_input
5960  0096 2004          	jra	L3003
5961  0098               L1003:
5962                     ; 1811       else invert_input = 0xff;
5964  0098 35ff00fe      	mov	_invert_input,#255
5965  009c               L3003:
5966                     ; 1815       restart_request = 1;
5968  009c 350100a2      	mov	_restart_request,#1
5969  00a0               L7772:
5970                     ; 1849     if (Pending_config_settings[2] != stored_config_settings[2]) {
5972  00a0 c6004e        	ld	a,_stored_config_settings+2
5973  00a3 c100ba        	cp	a,_Pending_config_settings+2
5974  00a6 2709          	jreq	L5003
5975                     ; 1851       stored_config_settings[2] = Pending_config_settings[2];
5977  00a8 c600ba        	ld	a,_Pending_config_settings+2
5978  00ab ae004e        	ldw	x,#_stored_config_settings+2
5979  00ae cd0000        	call	c_eewrc
5981  00b1               L5003:
5982                     ; 1855     if (Pending_config_settings[3] != stored_config_settings[3]) {
5984  00b1 c6004f        	ld	a,_stored_config_settings+3
5985  00b4 c100bb        	cp	a,_Pending_config_settings+3
5986  00b7 270d          	jreq	L7003
5987                     ; 1858       stored_config_settings[3] = Pending_config_settings[3];
5989  00b9 c600bb        	ld	a,_Pending_config_settings+3
5990  00bc ae004f        	ldw	x,#_stored_config_settings+3
5991  00bf cd0000        	call	c_eewrc
5993                     ; 1860       user_reboot_request = 1;
5995  00c2 350100a3      	mov	_user_reboot_request,#1
5996  00c6               L7003:
5997                     ; 1863     stored_config_settings[4] = Pending_config_settings[4];
5999  00c6 c600bc        	ld	a,_Pending_config_settings+4
6000  00c9 ae0050        	ldw	x,#_stored_config_settings+4
6001  00cc cd0000        	call	c_eewrc
6003                     ; 1864     stored_config_settings[5] = Pending_config_settings[5];
6005  00cf c600bd        	ld	a,_Pending_config_settings+5
6006  00d2 ae0051        	ldw	x,#_stored_config_settings+5
6007  00d5 cd0000        	call	c_eewrc
6009                     ; 1867     if (stored_hostaddr[3] != Pending_hostaddr[3] ||
6009                     ; 1868         stored_hostaddr[2] != Pending_hostaddr[2] ||
6009                     ; 1869         stored_hostaddr[1] != Pending_hostaddr[1] ||
6009                     ; 1870         stored_hostaddr[0] != Pending_hostaddr[0]) {
6011  00d8 c6002a        	ld	a,_stored_hostaddr+3
6012  00db c100df        	cp	a,_Pending_hostaddr+3
6013  00de 2618          	jrne	L3103
6015  00e0 c60029        	ld	a,_stored_hostaddr+2
6016  00e3 c100de        	cp	a,_Pending_hostaddr+2
6017  00e6 2610          	jrne	L3103
6019  00e8 c60028        	ld	a,_stored_hostaddr+1
6020  00eb c100dd        	cp	a,_Pending_hostaddr+1
6021  00ee 2608          	jrne	L3103
6023  00f0 c60027        	ld	a,_stored_hostaddr
6024  00f3 c100dc        	cp	a,_Pending_hostaddr
6025  00f6 2713          	jreq	L1103
6026  00f8               L3103:
6027                     ; 1872       for (i=0; i<4; i++) stored_hostaddr[i] = Pending_hostaddr[i];
6029  00f8 4f            	clr	a
6030  00f9 6b01          	ld	(OFST+0,sp),a
6032  00fb               L1203:
6035  00fb 5f            	clrw	x
6036  00fc 97            	ld	xl,a
6037  00fd d600dc        	ld	a,(_Pending_hostaddr,x)
6038  0100 d70027        	ld	(_stored_hostaddr,x),a
6041  0103 0c01          	inc	(OFST+0,sp)
6045  0105 7b01          	ld	a,(OFST+0,sp)
6046  0107 a104          	cp	a,#4
6047  0109 25f0          	jrult	L1203
6048  010b               L1103:
6049                     ; 1876     if (stored_draddr[3] != Pending_draddr[3] ||
6049                     ; 1877         stored_draddr[2] != Pending_draddr[2] ||
6049                     ; 1878         stored_draddr[1] != Pending_draddr[1] ||
6049                     ; 1879         stored_draddr[0] != Pending_draddr[0]) {
6051  010b c60026        	ld	a,_stored_draddr+3
6052  010e c100db        	cp	a,_Pending_draddr+3
6053  0111 2618          	jrne	L1303
6055  0113 c60025        	ld	a,_stored_draddr+2
6056  0116 c100da        	cp	a,_Pending_draddr+2
6057  0119 2610          	jrne	L1303
6059  011b c60024        	ld	a,_stored_draddr+1
6060  011e c100d9        	cp	a,_Pending_draddr+1
6061  0121 2608          	jrne	L1303
6063  0123 c60023        	ld	a,_stored_draddr
6064  0126 c100d8        	cp	a,_Pending_draddr
6065  0129 2717          	jreq	L7203
6066  012b               L1303:
6067                     ; 1881       for (i=0; i<4; i++) stored_draddr[i] = Pending_draddr[i];
6069  012b 4f            	clr	a
6070  012c 6b01          	ld	(OFST+0,sp),a
6072  012e               L7303:
6075  012e 5f            	clrw	x
6076  012f 97            	ld	xl,a
6077  0130 d600d8        	ld	a,(_Pending_draddr,x)
6078  0133 d70023        	ld	(_stored_draddr,x),a
6081  0136 0c01          	inc	(OFST+0,sp)
6085  0138 7b01          	ld	a,(OFST+0,sp)
6086  013a a104          	cp	a,#4
6087  013c 25f0          	jrult	L7303
6088                     ; 1882       restart_request = 1;
6090  013e 350100a2      	mov	_restart_request,#1
6091  0142               L7203:
6092                     ; 1886     if (stored_netmask[3] != Pending_netmask[3] ||
6092                     ; 1887         stored_netmask[2] != Pending_netmask[2] ||
6092                     ; 1888         stored_netmask[1] != Pending_netmask[1] ||
6092                     ; 1889         stored_netmask[0] != Pending_netmask[0]) {
6094  0142 c60022        	ld	a,_stored_netmask+3
6095  0145 c100d7        	cp	a,_Pending_netmask+3
6096  0148 2618          	jrne	L7403
6098  014a c60021        	ld	a,_stored_netmask+2
6099  014d c100d6        	cp	a,_Pending_netmask+2
6100  0150 2610          	jrne	L7403
6102  0152 c60020        	ld	a,_stored_netmask+1
6103  0155 c100d5        	cp	a,_Pending_netmask+1
6104  0158 2608          	jrne	L7403
6106  015a c6001f        	ld	a,_stored_netmask
6107  015d c100d4        	cp	a,_Pending_netmask
6108  0160 2717          	jreq	L5403
6109  0162               L7403:
6110                     ; 1891       for (i=0; i<4; i++) stored_netmask[i] = Pending_netmask[i];
6112  0162 4f            	clr	a
6113  0163 6b01          	ld	(OFST+0,sp),a
6115  0165               L5503:
6118  0165 5f            	clrw	x
6119  0166 97            	ld	xl,a
6120  0167 d600d4        	ld	a,(_Pending_netmask,x)
6121  016a d7001f        	ld	(_stored_netmask,x),a
6124  016d 0c01          	inc	(OFST+0,sp)
6128  016f 7b01          	ld	a,(OFST+0,sp)
6129  0171 a104          	cp	a,#4
6130  0173 25f0          	jrult	L5503
6131                     ; 1892       restart_request = 1;
6133  0175 350100a2      	mov	_restart_request,#1
6134  0179               L5403:
6135                     ; 1896     if (stored_port != Pending_port) {
6137  0179 ce001d        	ldw	x,_stored_port
6138  017c c300d2        	cpw	x,_Pending_port
6139  017f 270f          	jreq	L3603
6140                     ; 1898       stored_port = Pending_port;
6142  0181 ce00d2        	ldw	x,_Pending_port
6143  0184 89            	pushw	x
6144  0185 ae001d        	ldw	x,#_stored_port
6145  0188 cd0000        	call	c_eewrw
6147  018b 350100a2      	mov	_restart_request,#1
6148  018f 85            	popw	x
6149                     ; 1900       restart_request = 1;
6151  0190               L3603:
6152                     ; 1904     for(i=0; i<20; i++) {
6154  0190 4f            	clr	a
6155  0191 6b01          	ld	(OFST+0,sp),a
6157  0193               L5603:
6158                     ; 1905       if (stored_devicename[i] != Pending_devicename[i]) {
6160  0193 5f            	clrw	x
6161  0194 97            	ld	xl,a
6162  0195 905f          	clrw	y
6163  0197 9097          	ld	yl,a
6164  0199 90d60000      	ld	a,(_stored_devicename,y)
6165  019d d100be        	cp	a,(_Pending_devicename,x)
6166  01a0 270e          	jreq	L3703
6167                     ; 1906         stored_devicename[i] = Pending_devicename[i];
6169  01a2 7b01          	ld	a,(OFST+0,sp)
6170  01a4 5f            	clrw	x
6171  01a5 97            	ld	xl,a
6172  01a6 d600be        	ld	a,(_Pending_devicename,x)
6173  01a9 d70000        	ld	(_stored_devicename,x),a
6174                     ; 1912         restart_request = 1;
6176  01ac 350100a2      	mov	_restart_request,#1
6177  01b0               L3703:
6178                     ; 1904     for(i=0; i<20; i++) {
6180  01b0 0c01          	inc	(OFST+0,sp)
6184  01b2 7b01          	ld	a,(OFST+0,sp)
6185  01b4 a114          	cp	a,#20
6186  01b6 25db          	jrult	L5603
6187                     ; 1919     strcpy(topic_base, devicetype);
6189  01b8 ae000d        	ldw	x,#_topic_base
6190  01bb 90ae0000      	ldw	y,#L5261_devicetype
6191  01bf               L013:
6192  01bf 90f6          	ld	a,(y)
6193  01c1 905c          	incw	y
6194  01c3 f7            	ld	(x),a
6195  01c4 5c            	incw	x
6196  01c5 4d            	tnz	a
6197  01c6 26f7          	jrne	L013
6198                     ; 1920     strcat(topic_base, stored_devicename);
6200  01c8 ae0000        	ldw	x,#_stored_devicename
6201  01cb 89            	pushw	x
6202  01cc ae000d        	ldw	x,#_topic_base
6203  01cf cd0000        	call	_strcat
6205  01d2 85            	popw	x
6206                     ; 1921     topic_base_len = (uint8_t)strlen(topic_base);
6208  01d3 ae000d        	ldw	x,#_topic_base
6209  01d6 cd0000        	call	_strlen
6211  01d9 9f            	ld	a,xl
6212  01da c7000c        	ld	_topic_base_len,a
6213                     ; 1924     if (stored_mqttserveraddr[3] != Pending_mqttserveraddr[3] ||
6213                     ; 1925         stored_mqttserveraddr[2] != Pending_mqttserveraddr[2] ||
6213                     ; 1926         stored_mqttserveraddr[1] != Pending_mqttserveraddr[1] ||
6213                     ; 1927         stored_mqttserveraddr[0] != Pending_mqttserveraddr[0]) {
6215  01dd c60034        	ld	a,_stored_mqttserveraddr+3
6216  01e0 c100fb        	cp	a,_Pending_mqttserveraddr+3
6217  01e3 2618          	jrne	L7703
6219  01e5 c60033        	ld	a,_stored_mqttserveraddr+2
6220  01e8 c100fa        	cp	a,_Pending_mqttserveraddr+2
6221  01eb 2610          	jrne	L7703
6223  01ed c60032        	ld	a,_stored_mqttserveraddr+1
6224  01f0 c100f9        	cp	a,_Pending_mqttserveraddr+1
6225  01f3 2608          	jrne	L7703
6227  01f5 c60031        	ld	a,_stored_mqttserveraddr
6228  01f8 c100f8        	cp	a,_Pending_mqttserveraddr
6229  01fb 2717          	jreq	L5703
6230  01fd               L7703:
6231                     ; 1929       for (i=0; i<4; i++) stored_mqttserveraddr[i] = Pending_mqttserveraddr[i];
6233  01fd 4f            	clr	a
6234  01fe 6b01          	ld	(OFST+0,sp),a
6236  0200               L5013:
6239  0200 5f            	clrw	x
6240  0201 97            	ld	xl,a
6241  0202 d600f8        	ld	a,(_Pending_mqttserveraddr,x)
6242  0205 d70031        	ld	(_stored_mqttserveraddr,x),a
6245  0208 0c01          	inc	(OFST+0,sp)
6249  020a 7b01          	ld	a,(OFST+0,sp)
6250  020c a104          	cp	a,#4
6251  020e 25f0          	jrult	L5013
6252                     ; 1931       restart_request = 1;
6254  0210 350100a2      	mov	_restart_request,#1
6255  0214               L5703:
6256                     ; 1935     if (stored_mqttport != Pending_mqttport) {
6258  0214 ce002f        	ldw	x,_stored_mqttport
6259  0217 c300f6        	cpw	x,_Pending_mqttport
6260  021a 270f          	jreq	L3113
6261                     ; 1937       stored_mqttport = Pending_mqttport;
6263  021c ce00f6        	ldw	x,_Pending_mqttport
6264  021f 89            	pushw	x
6265  0220 ae002f        	ldw	x,#_stored_mqttport
6266  0223 cd0000        	call	c_eewrw
6268  0226 350100a2      	mov	_restart_request,#1
6269  022a 85            	popw	x
6270                     ; 1939       restart_request = 1;
6272  022b               L3113:
6273                     ; 1943     for(i=0; i<11; i++) {
6275  022b 4f            	clr	a
6276  022c 6b01          	ld	(OFST+0,sp),a
6278  022e               L5113:
6279                     ; 1944       if (stored_mqtt_username[i] != Pending_mqtt_username[i]) {
6281  022e 5f            	clrw	x
6282  022f 97            	ld	xl,a
6283  0230 905f          	clrw	y
6284  0232 9097          	ld	yl,a
6285  0234 90d60035      	ld	a,(_stored_mqtt_username,y)
6286  0238 d100eb        	cp	a,(_Pending_mqtt_username,x)
6287  023b 270e          	jreq	L3213
6288                     ; 1945         stored_mqtt_username[i] = Pending_mqtt_username[i];
6290  023d 7b01          	ld	a,(OFST+0,sp)
6291  023f 5f            	clrw	x
6292  0240 97            	ld	xl,a
6293  0241 d600eb        	ld	a,(_Pending_mqtt_username,x)
6294  0244 d70035        	ld	(_stored_mqtt_username,x),a
6295                     ; 1947         restart_request = 1;
6297  0247 350100a2      	mov	_restart_request,#1
6298  024b               L3213:
6299                     ; 1943     for(i=0; i<11; i++) {
6301  024b 0c01          	inc	(OFST+0,sp)
6305  024d 7b01          	ld	a,(OFST+0,sp)
6306  024f a10b          	cp	a,#11
6307  0251 25db          	jrult	L5113
6308                     ; 1952     for(i=0; i<11; i++) {
6310  0253 4f            	clr	a
6311  0254 6b01          	ld	(OFST+0,sp),a
6313  0256               L5213:
6314                     ; 1953       if (stored_mqtt_password[i] != Pending_mqtt_password[i]) {
6316  0256 5f            	clrw	x
6317  0257 97            	ld	xl,a
6318  0258 905f          	clrw	y
6319  025a 9097          	ld	yl,a
6320  025c 90d60040      	ld	a,(_stored_mqtt_password,y)
6321  0260 d100e0        	cp	a,(_Pending_mqtt_password,x)
6322  0263 270e          	jreq	L3313
6323                     ; 1954         stored_mqtt_password[i] = Pending_mqtt_password[i];
6325  0265 7b01          	ld	a,(OFST+0,sp)
6326  0267 5f            	clrw	x
6327  0268 97            	ld	xl,a
6328  0269 d600e0        	ld	a,(_Pending_mqtt_password,x)
6329  026c d70040        	ld	(_stored_mqtt_password,x),a
6330                     ; 1956         restart_request = 1;
6332  026f 350100a2      	mov	_restart_request,#1
6333  0273               L3313:
6334                     ; 1952     for(i=0; i<11; i++) {
6336  0273 0c01          	inc	(OFST+0,sp)
6340  0275 7b01          	ld	a,(OFST+0,sp)
6341  0277 a10b          	cp	a,#11
6342  0279 25db          	jrult	L5213
6343                     ; 1962     if (stored_uip_ethaddr_oct[0] != Pending_uip_ethaddr_oct[0] ||
6343                     ; 1963       stored_uip_ethaddr_oct[1] != Pending_uip_ethaddr_oct[1] ||
6343                     ; 1964       stored_uip_ethaddr_oct[2] != Pending_uip_ethaddr_oct[2] ||
6343                     ; 1965       stored_uip_ethaddr_oct[3] != Pending_uip_ethaddr_oct[3] ||
6343                     ; 1966       stored_uip_ethaddr_oct[4] != Pending_uip_ethaddr_oct[4] ||
6343                     ; 1967       stored_uip_ethaddr_oct[5] != Pending_uip_ethaddr_oct[5]) {
6345  027b c60017        	ld	a,_stored_uip_ethaddr_oct
6346  027e c100b2        	cp	a,_Pending_uip_ethaddr_oct
6347  0281 2628          	jrne	L7313
6349  0283 c60018        	ld	a,_stored_uip_ethaddr_oct+1
6350  0286 c100b3        	cp	a,_Pending_uip_ethaddr_oct+1
6351  0289 2620          	jrne	L7313
6353  028b c60019        	ld	a,_stored_uip_ethaddr_oct+2
6354  028e c100b4        	cp	a,_Pending_uip_ethaddr_oct+2
6355  0291 2618          	jrne	L7313
6357  0293 c6001a        	ld	a,_stored_uip_ethaddr_oct+3
6358  0296 c100b5        	cp	a,_Pending_uip_ethaddr_oct+3
6359  0299 2610          	jrne	L7313
6361  029b c6001b        	ld	a,_stored_uip_ethaddr_oct+4
6362  029e c100b6        	cp	a,_Pending_uip_ethaddr_oct+4
6363  02a1 2608          	jrne	L7313
6365  02a3 c6001c        	ld	a,_stored_uip_ethaddr_oct+5
6366  02a6 c100b7        	cp	a,_Pending_uip_ethaddr_oct+5
6367  02a9 271a          	jreq	L3672
6368  02ab               L7313:
6369                     ; 1969       for (i=0; i<6; i++) stored_uip_ethaddr_oct[i] = Pending_uip_ethaddr_oct[i];
6371  02ab 4f            	clr	a
6372  02ac 6b01          	ld	(OFST+0,sp),a
6374  02ae               L1513:
6377  02ae 5f            	clrw	x
6378  02af 97            	ld	xl,a
6379  02b0 d600b2        	ld	a,(_Pending_uip_ethaddr_oct,x)
6380  02b3 d70017        	ld	(_stored_uip_ethaddr_oct,x),a
6383  02b6 0c01          	inc	(OFST+0,sp)
6387  02b8 7b01          	ld	a,(OFST+0,sp)
6388  02ba a106          	cp	a,#6
6389  02bc 25f0          	jrult	L1513
6390                     ; 1971       update_mac_string();
6392  02be cd0000        	call	_update_mac_string
6394                     ; 1973       restart_request = 1;
6396  02c1 350100a2      	mov	_restart_request,#1
6397  02c5               L3672:
6398                     ; 1977   if (restart_request == 1) {
6400  02c5 c600a2        	ld	a,_restart_request
6401  02c8 4a            	dec	a
6402  02c9 2609          	jrne	L7513
6403                     ; 1980     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
6405  02cb c600a1        	ld	a,_restart_reboot_step
6406  02ce 2604          	jrne	L7513
6407                     ; 1981       restart_reboot_step = RESTART_REBOOT_ARM;
6409  02d0 350100a1      	mov	_restart_reboot_step,#1
6410  02d4               L7513:
6411                     ; 1985   if (user_reboot_request == 1) {
6413  02d4 c600a3        	ld	a,_user_reboot_request
6414  02d7 4a            	dec	a
6415  02d8 2611          	jrne	L3613
6416                     ; 1988     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
6418  02da 725d00a1      	tnz	_restart_reboot_step
6419  02de 260b          	jrne	L3613
6420                     ; 1989       restart_reboot_step = RESTART_REBOOT_ARM;
6422  02e0 350100a1      	mov	_restart_reboot_step,#1
6423                     ; 1990       user_reboot_request = 0;
6425  02e4 c700a3        	ld	_user_reboot_request,a
6426                     ; 1991       reboot_request = 1;
6428  02e7 350100a4      	mov	_reboot_request,#1
6429  02eb               L3613:
6430                     ; 2000   parse_complete = 0; // Reset parse_complete for future changes
6432  02eb 725f009f      	clr	_parse_complete
6433                     ; 2003   if (stack_limit1 != 0xaa || stack_limit2 != 0x55) {
6435  02ef c60001        	ld	a,_stack_limit1
6436  02f2 a1aa          	cp	a,#170
6437  02f4 2607          	jrne	L1713
6439  02f6 c60000        	ld	a,_stack_limit2
6440  02f9 a155          	cp	a,#85
6441  02fb 270a          	jreq	L7613
6442  02fd               L1713:
6443                     ; 2004     stack_error = 1;
6445  02fd 350100fc      	mov	_stack_error,#1
6446                     ; 2005     fastflash();
6448  0301 cd0000        	call	_fastflash
6450                     ; 2006     fastflash();
6452  0304 cd0000        	call	_fastflash
6454  0307               L7613:
6455                     ; 2019 }
6458  0307 84            	pop	a
6459  0308 81            	ret	
6494                     ; 2022 void check_restart_reboot(void)
6494                     ; 2023 {
6495                     .text:	section	.text,new
6496  0000               _check_restart_reboot:
6500                     ; 2029   if (restart_request == 1 || reboot_request == 1) {
6502  0000 c600a2        	ld	a,_restart_request
6503  0003 4a            	dec	a
6504  0004 2709          	jreq	L5023
6506  0006 c600a4        	ld	a,_reboot_request
6507  0009 4a            	dec	a
6508  000a 2703cc00d4    	jrne	L3023
6509  000f               L5023:
6510                     ; 2040     if (restart_reboot_step == RESTART_REBOOT_ARM) {
6512  000f c600a1        	ld	a,_restart_reboot_step
6513  0012 a101          	cp	a,#1
6514  0014 2611          	jrne	L7023
6515                     ; 2045       time_mark2 = second_counter;
6517  0016 ce0002        	ldw	x,_second_counter+2
6518  0019 cf0096        	ldw	_time_mark2+2,x
6519  001c ce0000        	ldw	x,_second_counter
6520  001f cf0094        	ldw	_time_mark2,x
6521                     ; 2046       restart_reboot_step = RESTART_REBOOT_ARM2;
6523  0022 350200a1      	mov	_restart_reboot_step,#2
6526  0026 81            	ret	
6527  0027               L7023:
6528                     ; 2049     else if (restart_reboot_step == RESTART_REBOOT_ARM2) {
6530  0027 a102          	cp	a,#2
6531  0029 2613          	jrne	L3123
6532                     ; 2055       if (second_counter > time_mark2 + 0 ) {
6534  002b ae0000        	ldw	x,#_second_counter
6535  002e cd0000        	call	c_ltor
6537  0031 ae0094        	ldw	x,#_time_mark2
6538  0034 cd0000        	call	c_lcmp
6540  0037 23d3          	jrule	L3023
6541                     ; 2056         restart_reboot_step = RESTART_REBOOT_DISCONNECT;
6543  0039 350300a1      	mov	_restart_reboot_step,#3
6545  003d 81            	ret	
6546  003e               L3123:
6547                     ; 2061     else if (restart_reboot_step == RESTART_REBOOT_DISCONNECT) {
6549  003e a103          	cp	a,#3
6550  0040 261e          	jrne	L1223
6551                     ; 2062       restart_reboot_step = RESTART_REBOOT_DISCONNECTWAIT;
6553  0042 350400a1      	mov	_restart_reboot_step,#4
6554                     ; 2063       if (mqtt_start == MQTT_START_COMPLETE) {
6556  0046 c60041        	ld	a,_mqtt_start
6557  0049 a114          	cp	a,#20
6558  004b 2606          	jrne	L3223
6559                     ; 2065         mqtt_disconnect(&mqttclient);
6561  004d ae005e        	ldw	x,#_mqttclient
6562  0050 cd0000        	call	_mqtt_disconnect
6564  0053               L3223:
6565                     ; 2068       time_mark2 = second_counter;
6567  0053 ce0002        	ldw	x,_second_counter+2
6568  0056 cf0096        	ldw	_time_mark2+2,x
6569  0059 ce0000        	ldw	x,_second_counter
6570  005c cf0094        	ldw	_time_mark2,x
6573  005f 81            	ret	
6574  0060               L1223:
6575                     ; 2071     else if (restart_reboot_step == RESTART_REBOOT_DISCONNECTWAIT) {
6577  0060 a104          	cp	a,#4
6578  0062 2618          	jrne	L7223
6579                     ; 2072       if (second_counter > time_mark2 + 1 ) {
6581  0064 ae0094        	ldw	x,#_time_mark2
6582  0067 cd0000        	call	c_ltor
6584  006a a601          	ld	a,#1
6585  006c cd0000        	call	c_ladc
6587  006f ae0000        	ldw	x,#_second_counter
6588  0072 cd0000        	call	c_lcmp
6590  0075 245d          	jruge	L3023
6591                     ; 2075         restart_reboot_step = RESTART_REBOOT_TCPCLOSE;
6593  0077 350500a1      	mov	_restart_reboot_step,#5
6595  007b 81            	ret	
6596  007c               L7223:
6597                     ; 2079     else if (restart_reboot_step == RESTART_REBOOT_TCPCLOSE) {
6599  007c a105          	cp	a,#5
6600  007e 2615          	jrne	L5323
6601                     ; 2095       mqtt_close_tcp = 1;
6603  0080 350100a0      	mov	_mqtt_close_tcp,#1
6604                     ; 2097       time_mark2 = second_counter;
6606  0084 ce0002        	ldw	x,_second_counter+2
6607  0087 cf0096        	ldw	_time_mark2+2,x
6608  008a ce0000        	ldw	x,_second_counter
6609  008d cf0094        	ldw	_time_mark2,x
6610                     ; 2098       restart_reboot_step = RESTART_REBOOT_TCPWAIT;
6612  0090 350600a1      	mov	_restart_reboot_step,#6
6615  0094 81            	ret	
6616  0095               L5323:
6617                     ; 2100     else if (restart_reboot_step == RESTART_REBOOT_TCPWAIT) {
6619  0095 a106          	cp	a,#6
6620  0097 261c          	jrne	L1423
6621                     ; 2105       if (second_counter > time_mark2 + 1) {
6623  0099 ae0094        	ldw	x,#_time_mark2
6624  009c cd0000        	call	c_ltor
6626  009f a601          	ld	a,#1
6627  00a1 cd0000        	call	c_ladc
6629  00a4 ae0000        	ldw	x,#_second_counter
6630  00a7 cd0000        	call	c_lcmp
6632  00aa 2428          	jruge	L3023
6633                     ; 2106 	mqtt_close_tcp = 0;
6635  00ac 725f00a0      	clr	_mqtt_close_tcp
6636                     ; 2107         restart_reboot_step = RESTART_REBOOT_FINISH;
6638  00b0 350700a1      	mov	_restart_reboot_step,#7
6640  00b4 81            	ret	
6641  00b5               L1423:
6642                     ; 2117     else if (restart_reboot_step == RESTART_REBOOT_FINISH) {
6644  00b5 a107          	cp	a,#7
6645  00b7 261b          	jrne	L3023
6646                     ; 2118       if (reboot_request == 1) {
6648  00b9 c600a4        	ld	a,_reboot_request
6649  00bc 4a            	dec	a
6650  00bd 2606          	jrne	L1523
6651                     ; 2119         restart_reboot_step = RESTART_REBOOT_IDLE;
6653  00bf c700a1        	ld	_restart_reboot_step,a
6654                     ; 2121         reboot();
6656  00c2 cd0000        	call	_reboot
6658  00c5               L1523:
6659                     ; 2123       if (restart_request == 1) {
6661  00c5 c600a2        	ld	a,_restart_request
6662  00c8 4a            	dec	a
6663  00c9 2609          	jrne	L3023
6664                     ; 2124 	restart_request = 0;
6666  00cb c700a2        	ld	_restart_request,a
6667                     ; 2125         restart_reboot_step = RESTART_REBOOT_IDLE;
6669  00ce c700a1        	ld	_restart_reboot_step,a
6670                     ; 2127 	restart();
6672  00d1 cd0000        	call	_restart
6674  00d4               L3023:
6675                     ; 2131 }
6678  00d4 81            	ret	
6731                     ; 2134 void restart(void)
6731                     ; 2135 {
6732                     .text:	section	.text,new
6733  0000               _restart:
6737                     ; 2149   LEDcontrol(0); // Turn LED off
6739  0000 4f            	clr	a
6740  0001 cd0000        	call	_LEDcontrol
6742                     ; 2151   parse_complete = 0;
6744  0004 725f009f      	clr	_parse_complete
6745                     ; 2152   reboot_request = 0;
6747  0008 725f00a4      	clr	_reboot_request
6748                     ; 2153   restart_request = 0;
6750  000c 725f00a2      	clr	_restart_request
6751                     ; 2155   time_mark2 = 0;           // Time capture used in reboot
6753  0010 5f            	clrw	x
6754  0011 cf0096        	ldw	_time_mark2+2,x
6755  0014 cf0094        	ldw	_time_mark2,x
6756                     ; 2158   mqtt_close_tcp = 0;
6758  0017 725f00a0      	clr	_mqtt_close_tcp
6759                     ; 2160   mqtt_start = MQTT_START_TCP_CONNECT;
6761  001b 35010041      	mov	_mqtt_start,#1
6762                     ; 2161   mqtt_start_status = MQTT_START_NOT_STARTED;
6764  001f 725f0040      	clr	_mqtt_start_status
6765                     ; 2162   mqtt_start_ctr1 = 0;
6767  0023 725f003f      	clr	_mqtt_start_ctr1
6768                     ; 2163   mqtt_sanity_ctr = 0;
6770  0027 725f003d      	clr	_mqtt_sanity_ctr
6771                     ; 2164   mqtt_start_retry = 0;
6773  002b 725f003c      	clr	_mqtt_start_retry
6774                     ; 2165   MQTT_error_status = 0;
6776  002f 725f0000      	clr	_MQTT_error_status
6777                     ; 2166   mqtt_restart_step = MQTT_RESTART_IDLE;
6779  0033 725f0039      	clr	_mqtt_restart_step
6780                     ; 2167   strcpy(topic_base, devicetype);
6782  0037 ae000d        	ldw	x,#_topic_base
6783  003a 90ae0000      	ldw	y,#L5261_devicetype
6784  003e               L043:
6785  003e 90f6          	ld	a,(y)
6786  0040 905c          	incw	y
6787  0042 f7            	ld	(x),a
6788  0043 5c            	incw	x
6789  0044 4d            	tnz	a
6790  0045 26f7          	jrne	L043
6791                     ; 2168   state_request = STATE_REQUEST_IDLE;
6793  0047 c700fd        	ld	_state_request,a
6794                     ; 2171   spi_init();              // Initialize the SPI bit bang interface to the
6796  004a cd0000        	call	_spi_init
6798                     ; 2173   unlock_eeprom();         // unlock the EEPROM so writes can be performed
6800  004d cd0000        	call	_unlock_eeprom
6802                     ; 2174   check_eeprom_settings(); // Verify EEPROM up to date
6804  0050 cd0000        	call	_check_eeprom_settings
6806                     ; 2175   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
6808  0053 cd0000        	call	_Enc28j60Init
6810                     ; 2176   uip_arp_init();          // Initialize the ARP module
6812  0056 cd0000        	call	_uip_arp_init
6814                     ; 2177   uip_init();              // Initialize uIP
6816  0059 cd0000        	call	_uip_init
6818                     ; 2178   HttpDInit();             // Initialize httpd; sets up listening ports
6820  005c cd0000        	call	_HttpDInit
6822                     ; 2182   mqtt_init(&mqttclient,
6822                     ; 2183             mqtt_sendbuf,
6822                     ; 2184 	    sizeof(mqtt_sendbuf),
6822                     ; 2185 	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
6822                     ; 2186 	    UIP_APPDATA_SIZE,
6822                     ; 2187 	    publish_callback);
6824  005f ae0000        	ldw	x,#_publish_callback
6825  0062 89            	pushw	x
6826  0063 ae01be        	ldw	x,#446
6827  0066 89            	pushw	x
6828  0067 ae0036        	ldw	x,#_uip_buf+54
6829  006a 89            	pushw	x
6830  006b ae00c8        	ldw	x,#200
6831  006e 89            	pushw	x
6832  006f ae0000        	ldw	x,#_mqtt_sendbuf
6833  0072 89            	pushw	x
6834  0073 ae005e        	ldw	x,#_mqttclient
6835  0076 cd0000        	call	_mqtt_init
6837  0079 5b0a          	addw	sp,#10
6838                     ; 2190   LEDcontrol(1); // Turn LED on
6840  007b a601          	ld	a,#1
6842                     ; 2193 }
6845  007d cc0000        	jp	_LEDcontrol
6873                     ; 2196 void reboot(void)
6873                     ; 2197 {
6874                     .text:	section	.text,new
6875  0000               _reboot:
6879                     ; 2200   fastflash(); // A useful signal that a deliberate reboot is occurring.
6881  0000 cd0000        	call	_fastflash
6883                     ; 2202   LEDcontrol(0);  // turn LED off
6885  0003 4f            	clr	a
6886  0004 cd0000        	call	_LEDcontrol
6888                     ; 2204   WWDG_WR = (uint8_t)0x7f;     // Window register reset
6890  0007 357f50d2      	mov	_WWDG_WR,#127
6891                     ; 2205   WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
6893  000b 35ff50d1      	mov	_WWDG_CR,#255
6894                     ; 2206   WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
6896  000f 356050d2      	mov	_WWDG_WR,#96
6897                     ; 2209   wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
6899  0013 aec350        	ldw	x,#50000
6900  0016 cd0000        	call	_wait_timer
6902                     ; 2210   wait_timer((uint16_t)50000);
6904  0019 aec350        	ldw	x,#50000
6905  001c cd0000        	call	_wait_timer
6907                     ; 2211   wait_timer((uint16_t)50000);
6909  001f aec350        	ldw	x,#50000
6911                     ; 2212 }
6914  0022 cc0000        	jp	_wait_timer
6955                     ; 2215 void read_input_registers(void)
6955                     ; 2216 {
6956                     .text:	section	.text,new
6957  0000               _read_input_registers:
6959  0000 89            	pushw	x
6960       00000002      OFST:	set	2
6963                     ; 2233   if (PC_IDR & (uint8_t)0x40) IO_16to9_new1 |= 0x80; // PC bit 6 = 1, Input 8 = 1
6965  0001 720d500b06    	btjf	_PC_IDR,#6,L1133
6968  0006 721e0105      	bset	_IO_16to9_new1,#7
6970  000a 2004          	jra	L3133
6971  000c               L1133:
6972                     ; 2234   else IO_16to9_new1 &= (uint8_t)(~0x80);
6974  000c 721f0105      	bres	_IO_16to9_new1,#7
6975  0010               L3133:
6976                     ; 2235   if (PG_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x40; // PG bit 0 = 1, Input 7 = 1
6978  0010 7201501f06    	btjf	_PG_IDR,#0,L5133
6981  0015 721c0105      	bset	_IO_16to9_new1,#6
6983  0019 2004          	jra	L7133
6984  001b               L5133:
6985                     ; 2236   else IO_16to9_new1 &= (uint8_t)(~0x40);
6987  001b 721d0105      	bres	_IO_16to9_new1,#6
6988  001f               L7133:
6989                     ; 2237   if (PE_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x20; // PE bit 3 = 1, Input 6 = 1
6991  001f 7207501506    	btjf	_PE_IDR,#3,L1233
6994  0024 721a0105      	bset	_IO_16to9_new1,#5
6996  0028 2004          	jra	L3233
6997  002a               L1233:
6998                     ; 2238   else IO_16to9_new1 &= (uint8_t)(~0x20);
7000  002a 721b0105      	bres	_IO_16to9_new1,#5
7001  002e               L3233:
7002                     ; 2239   if (PD_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x10; // PD bit 0 = 1, Input 5 = 1
7004  002e 7201501006    	btjf	_PD_IDR,#0,L5233
7007  0033 72180105      	bset	_IO_16to9_new1,#4
7009  0037 2004          	jra	L7233
7010  0039               L5233:
7011                     ; 2240   else IO_16to9_new1 &= (uint8_t)(~0x10);
7013  0039 72190105      	bres	_IO_16to9_new1,#4
7014  003d               L7233:
7015                     ; 2241   if (PD_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x08; // PD bit 3 = 1, Input 4 = 1
7017  003d 7207501006    	btjf	_PD_IDR,#3,L1333
7020  0042 72160105      	bset	_IO_16to9_new1,#3
7022  0046 2004          	jra	L3333
7023  0048               L1333:
7024                     ; 2242   else IO_16to9_new1 &= (uint8_t)(~0x08);
7026  0048 72170105      	bres	_IO_16to9_new1,#3
7027  004c               L3333:
7028                     ; 2243   if (PD_IDR & (uint8_t)0x20) IO_16to9_new1 |= 0x04; // PD bit 5 = 1, Input 3 = 1
7030  004c 720b501006    	btjf	_PD_IDR,#5,L5333
7033  0051 72140105      	bset	_IO_16to9_new1,#2
7035  0055 2004          	jra	L7333
7036  0057               L5333:
7037                     ; 2244   else IO_16to9_new1 &= (uint8_t)(~0x04);
7039  0057 72150105      	bres	_IO_16to9_new1,#2
7040  005b               L7333:
7041                     ; 2245   if (PD_IDR & (uint8_t)0x80) IO_16to9_new1 |= 0x02; // PD bit 7 = 1, Input 2 = 1
7043  005b 720f501006    	btjf	_PD_IDR,#7,L1433
7046  0060 72120105      	bset	_IO_16to9_new1,#1
7048  0064 2004          	jra	L3433
7049  0066               L1433:
7050                     ; 2246   else IO_16to9_new1 &= (uint8_t)(~0x02);
7052  0066 72130105      	bres	_IO_16to9_new1,#1
7053  006a               L3433:
7054                     ; 2247   if (PA_IDR & (uint8_t)0x10) IO_16to9_new1 |= 0x01; // PA bit 4 = 1, Input 1 = 1
7056  006a 7209500106    	btjf	_PA_IDR,#4,L5433
7059  006f 72100105      	bset	_IO_16to9_new1,#0
7061  0073 2004          	jra	L7433
7062  0075               L5433:
7063                     ; 2248   else IO_16to9_new1 &= (uint8_t)(~0x01);
7065  0075 72110105      	bres	_IO_16to9_new1,#0
7066  0079               L7433:
7067                     ; 2253   xor_tmp = (uint8_t)((IO_16to9 ^ IO_16to9_new1) & (IO_16to9 ^ IO_16to9_new2));
7069  0079 c60107        	ld	a,_IO_16to9
7070  007c c80103        	xor	a,_IO_16to9_new2
7071  007f 6b01          	ld	(OFST-1,sp),a
7073  0081 c60107        	ld	a,_IO_16to9
7074  0084 c80105        	xor	a,_IO_16to9_new1
7075  0087 1401          	and	a,(OFST-1,sp)
7076  0089 6b02          	ld	(OFST+0,sp),a
7078                     ; 2254   IO_16to9 = (uint8_t)(IO_16to9 ^ xor_tmp);
7080  008b c80107        	xor	a,_IO_16to9
7081  008e c70107        	ld	_IO_16to9,a
7082                     ; 2256   IO_16to9_new2 = IO_16to9_new1;
7084                     ; 2310 }
7087  0091 85            	popw	x
7088  0092 5501050103    	mov	_IO_16to9_new2,_IO_16to9_new1
7089  0097 81            	ret	
7129                     ; 2313 void write_output_registers(void)
7129                     ; 2314 {
7130                     .text:	section	.text,new
7131  0000               _write_output_registers:
7133  0000 88            	push	a
7134       00000001      OFST:	set	1
7137                     ; 2368   xor_tmp = (uint8_t)(invert_output ^ IO_8to1);
7139  0001 c600ff        	ld	a,_invert_output
7140  0004 c80106        	xor	a,_IO_8to1
7141  0007 6b01          	ld	(OFST+0,sp),a
7143                     ; 2369   if (xor_tmp & 0x80) PC_ODR |= (uint8_t)0x80; // Relay 8 off
7145  0009 2a06          	jrpl	L5633
7148  000b 721e500a      	bset	_PC_ODR,#7
7150  000f 2004          	jra	L7633
7151  0011               L5633:
7152                     ; 2370   else PC_ODR &= (uint8_t)~0x80; // Relay 8 on
7154  0011 721f500a      	bres	_PC_ODR,#7
7155  0015               L7633:
7156                     ; 2371   if (xor_tmp & 0x40) PG_ODR |= (uint8_t)0x02; // Relay 7 off
7158  0015 a540          	bcp	a,#64
7159  0017 2706          	jreq	L1733
7162  0019 7212501e      	bset	_PG_ODR,#1
7164  001d 2004          	jra	L3733
7165  001f               L1733:
7166                     ; 2372   else PG_ODR &= (uint8_t)~0x02; // Relay 7 on
7168  001f 7213501e      	bres	_PG_ODR,#1
7169  0023               L3733:
7170                     ; 2373   if (xor_tmp & 0x20) PE_ODR |= (uint8_t)0x01; // Relay 6 off
7172  0023 7b01          	ld	a,(OFST+0,sp)
7173  0025 a520          	bcp	a,#32
7174  0027 2706          	jreq	L5733
7177  0029 72105014      	bset	_PE_ODR,#0
7179  002d 2004          	jra	L7733
7180  002f               L5733:
7181                     ; 2374   else PE_ODR &= (uint8_t)~0x01; // Relay 6 on
7183  002f 72115014      	bres	_PE_ODR,#0
7184  0033               L7733:
7185                     ; 2375   if (xor_tmp & 0x10) PD_ODR |= (uint8_t)0x04; // Relay 5 off
7187  0033 a510          	bcp	a,#16
7188  0035 2706          	jreq	L1043
7191  0037 7214500f      	bset	_PD_ODR,#2
7193  003b 2004          	jra	L3043
7194  003d               L1043:
7195                     ; 2376   else PD_ODR &= (uint8_t)~0x04; // Relay 5 on
7197  003d 7215500f      	bres	_PD_ODR,#2
7198  0041               L3043:
7199                     ; 2377   if (xor_tmp & 0x08) PD_ODR |= (uint8_t)0x10; // Relay 4 off
7201  0041 7b01          	ld	a,(OFST+0,sp)
7202  0043 a508          	bcp	a,#8
7203  0045 2706          	jreq	L5043
7206  0047 7218500f      	bset	_PD_ODR,#4
7208  004b 2004          	jra	L7043
7209  004d               L5043:
7210                     ; 2378   else PD_ODR &= (uint8_t)~0x10; // Relay 4 on
7212  004d 7219500f      	bres	_PD_ODR,#4
7213  0051               L7043:
7214                     ; 2379   if (xor_tmp & 0x04) PD_ODR |= (uint8_t)0x40; // Relay 3 off
7216  0051 a504          	bcp	a,#4
7217  0053 2706          	jreq	L1143
7220  0055 721c500f      	bset	_PD_ODR,#6
7222  0059 2004          	jra	L3143
7223  005b               L1143:
7224                     ; 2380   else PD_ODR &= (uint8_t)~0x40; // Relay 3 on
7226  005b 721d500f      	bres	_PD_ODR,#6
7227  005f               L3143:
7228                     ; 2381   if (xor_tmp & 0x02) PA_ODR |= (uint8_t)0x20; // Relay 2 off
7230  005f 7b01          	ld	a,(OFST+0,sp)
7231  0061 a502          	bcp	a,#2
7232  0063 2706          	jreq	L5143
7235  0065 721a5000      	bset	_PA_ODR,#5
7237  0069 2004          	jra	L7143
7238  006b               L5143:
7239                     ; 2382   else PA_ODR &= (uint8_t)~0x20; // Relay 2 on
7241  006b 721b5000      	bres	_PA_ODR,#5
7242  006f               L7143:
7243                     ; 2383   if (xor_tmp & 0x01) PA_ODR |= (uint8_t)0x08; // Relay 1 off
7245  006f a501          	bcp	a,#1
7246  0071 2706          	jreq	L1243
7249  0073 72165000      	bset	_PA_ODR,#3
7251  0077 2004          	jra	L3243
7252  0079               L1243:
7253                     ; 2384   else PA_ODR &= (uint8_t)~0x08; // Relay 1 on
7255  0079 72175000      	bres	_PA_ODR,#3
7256  007d               L3243:
7257                     ; 2390 }
7260  007d 84            	pop	a
7261  007e 81            	ret	
7302                     ; 2393 void check_reset_button(void)
7302                     ; 2394 {
7303                     .text:	section	.text,new
7304  0000               _check_reset_button:
7306  0000 88            	push	a
7307       00000001      OFST:	set	1
7310                     ; 2399   if ((PA_IDR & 0x02) == 0) {
7312  0001 720250015d    	btjt	_PA_IDR,#1,L1443
7313                     ; 2401     for (i=0; i<100; i++) {
7315  0006 0f01          	clr	(OFST+0,sp)
7317  0008               L3443:
7318                     ; 2402       wait_timer(50000); // wait 50ms
7320  0008 aec350        	ldw	x,#50000
7321  000b cd0000        	call	_wait_timer
7323                     ; 2403       if ((PA_IDR & 0x02) == 1) { // check Reset Button again. If released
7325  000e c65001        	ld	a,_PA_IDR
7326  0011 a402          	and	a,#2
7327  0013 4a            	dec	a
7328  0014 2602          	jrne	L1543
7329                     ; 2405         return;
7332  0016 84            	pop	a
7333  0017 81            	ret	
7334  0018               L1543:
7335                     ; 2401     for (i=0; i<100; i++) {
7337  0018 0c01          	inc	(OFST+0,sp)
7341  001a 7b01          	ld	a,(OFST+0,sp)
7342  001c a164          	cp	a,#100
7343  001e 25e8          	jrult	L3443
7344                     ; 2410     LEDcontrol(0);  // turn LED off
7346  0020 4f            	clr	a
7347  0021 cd0000        	call	_LEDcontrol
7350  0024               L5543:
7351                     ; 2411     while((PA_IDR & 0x02) == 0) {  // Wait for button release
7353  0024 72035001fb    	btjf	_PA_IDR,#1,L5543
7354                     ; 2414     magic4 = 0x00;
7356  0029 4f            	clr	a
7357  002a ae002e        	ldw	x,#_magic4
7358  002d cd0000        	call	c_eewrc
7360                     ; 2415     magic3 = 0x00;
7362  0030 4f            	clr	a
7363  0031 ae002d        	ldw	x,#_magic3
7364  0034 cd0000        	call	c_eewrc
7366                     ; 2416     magic2 = 0x00;
7368  0037 4f            	clr	a
7369  0038 ae002c        	ldw	x,#_magic2
7370  003b cd0000        	call	c_eewrc
7372                     ; 2417     magic1 = 0x00;
7374  003e 4f            	clr	a
7375  003f ae002b        	ldw	x,#_magic1
7376  0042 cd0000        	call	c_eewrc
7378                     ; 2419     WWDG_WR = (uint8_t)0x7f;       // Window register reset
7380  0045 357f50d2      	mov	_WWDG_WR,#127
7381                     ; 2420     WWDG_CR = (uint8_t)0xff;       // Set watchdog to timeout in 49ms
7383  0049 35ff50d1      	mov	_WWDG_CR,#255
7384                     ; 2421     WWDG_WR = (uint8_t)0x60;       // Window register value - doesn't matter
7386  004d 356050d2      	mov	_WWDG_WR,#96
7387                     ; 2424     wait_timer((uint16_t)50000);   // Wait for watchdog to generate reset
7389  0051 aec350        	ldw	x,#50000
7390  0054 cd0000        	call	_wait_timer
7392                     ; 2425     wait_timer((uint16_t)50000);
7394  0057 aec350        	ldw	x,#50000
7395  005a cd0000        	call	_wait_timer
7397                     ; 2426     wait_timer((uint16_t)50000);
7399  005d aec350        	ldw	x,#50000
7400  0060 cd0000        	call	_wait_timer
7402  0063               L1443:
7403                     ; 2428 }
7406  0063 84            	pop	a
7407  0064 81            	ret	
7441                     ; 2431 void debugflash(void)
7441                     ; 2432 {
7442                     .text:	section	.text,new
7443  0000               _debugflash:
7445  0000 88            	push	a
7446       00000001      OFST:	set	1
7449                     ; 2447   LEDcontrol(0);     // turn LED off
7451  0001 4f            	clr	a
7452  0002 cd0000        	call	_LEDcontrol
7454                     ; 2448   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
7456  0005 0f01          	clr	(OFST+0,sp)
7458  0007               L5743:
7461  0007 aec350        	ldw	x,#50000
7462  000a cd0000        	call	_wait_timer
7466  000d 0c01          	inc	(OFST+0,sp)
7470  000f 7b01          	ld	a,(OFST+0,sp)
7471  0011 a10a          	cp	a,#10
7472  0013 25f2          	jrult	L5743
7473                     ; 2450   LEDcontrol(1);     // turn LED on
7475  0015 a601          	ld	a,#1
7476  0017 cd0000        	call	_LEDcontrol
7478                     ; 2451   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
7480  001a 0f01          	clr	(OFST+0,sp)
7482  001c               L3053:
7485  001c aec350        	ldw	x,#50000
7486  001f cd0000        	call	_wait_timer
7490  0022 0c01          	inc	(OFST+0,sp)
7494  0024 7b01          	ld	a,(OFST+0,sp)
7495  0026 a10a          	cp	a,#10
7496  0028 25f2          	jrult	L3053
7497                     ; 2452 }
7500  002a 84            	pop	a
7501  002b 81            	ret	
7535                     ; 2455 void fastflash(void)
7535                     ; 2456 {
7536                     .text:	section	.text,new
7537  0000               _fastflash:
7539  0000 88            	push	a
7540       00000001      OFST:	set	1
7543                     ; 2471   for (i=0; i<10; i++) {
7545  0001 0f01          	clr	(OFST+0,sp)
7547  0003               L5253:
7548                     ; 2472     LEDcontrol(0);     // turn LED off
7550  0003 4f            	clr	a
7551  0004 cd0000        	call	_LEDcontrol
7553                     ; 2473     wait_timer((uint16_t)50000); // wait 50ms
7555  0007 aec350        	ldw	x,#50000
7556  000a cd0000        	call	_wait_timer
7558                     ; 2475     LEDcontrol(1);     // turn LED on
7560  000d a601          	ld	a,#1
7561  000f cd0000        	call	_LEDcontrol
7563                     ; 2476     wait_timer((uint16_t)50000); // wait 50ms
7565  0012 aec350        	ldw	x,#50000
7566  0015 cd0000        	call	_wait_timer
7568                     ; 2471   for (i=0; i<10; i++) {
7570  0018 0c01          	inc	(OFST+0,sp)
7574  001a 7b01          	ld	a,(OFST+0,sp)
7575  001c a10a          	cp	a,#10
7576  001e 25e3          	jrult	L5253
7577                     ; 2478 }
7580  0020 84            	pop	a
7581  0021 81            	ret	
7606                     ; 2481 void oneflash(void)
7606                     ; 2482 {
7607                     .text:	section	.text,new
7608  0000               _oneflash:
7612                     ; 2497   LEDcontrol(0);     // turn LED off
7614  0000 4f            	clr	a
7615  0001 cd0000        	call	_LEDcontrol
7617                     ; 2498   wait_timer((uint16_t)25000); // wait 25ms
7619  0004 ae61a8        	ldw	x,#25000
7620  0007 cd0000        	call	_wait_timer
7622                     ; 2500   LEDcontrol(1);     // turn LED on
7624  000a a601          	ld	a,#1
7626                     ; 2501 }
7629  000c cc0000        	jp	_LEDcontrol
8957                     	switch	.bss
8958  0000               _TRANSMIT_counter:
8959  0000 00000000      	ds.b	4
8960                     	xdef	_TRANSMIT_counter
8961  0004               _TXERIF_counter:
8962  0004 00000000      	ds.b	4
8963                     	xdef	_TXERIF_counter
8964  0008               _RXERIF_counter:
8965  0008 00000000      	ds.b	4
8966                     	xdef	_RXERIF_counter
8967  000c               _topic_base_len:
8968  000c 00            	ds.b	1
8969                     	xdef	_topic_base_len
8970  000d               _topic_base:
8971  000d 000000000000  	ds.b	44
8972                     	xdef	_topic_base
8973  0039               _mqtt_restart_step:
8974  0039 00            	ds.b	1
8975                     	xdef	_mqtt_restart_step
8976                     	xref	_MQTT_error_status
8977  003a               _mqtt_conn:
8978  003a 0000          	ds.b	2
8979                     	xdef	_mqtt_conn
8980                     	xref	_mqtt_sendbuf
8981  003c               _mqtt_start_retry:
8982  003c 00            	ds.b	1
8983                     	xdef	_mqtt_start_retry
8984  003d               _mqtt_sanity_ctr:
8985  003d 00            	ds.b	1
8986                     	xdef	_mqtt_sanity_ctr
8987  003e               _mqtt_start_ctr2:
8988  003e 00            	ds.b	1
8989                     	xdef	_mqtt_start_ctr2
8990  003f               _mqtt_start_ctr1:
8991  003f 00            	ds.b	1
8992                     	xdef	_mqtt_start_ctr1
8993  0040               _mqtt_start_status:
8994  0040 00            	ds.b	1
8995                     	xdef	_mqtt_start_status
8996  0041               _mqtt_start:
8997  0041 00            	ds.b	1
8998                     	xdef	_mqtt_start
8999  0042               _client_id_text:
9000  0042 000000000000  	ds.b	26
9001                     	xdef	_client_id_text
9002  005c               _client_id:
9003  005c 0000          	ds.b	2
9004                     	xdef	_client_id
9005  005e               _mqttclient:
9006  005e 000000000000  	ds.b	44
9007                     	xdef	_mqttclient
9008  008a               _mqtt_keep_alive:
9009  008a 0000          	ds.b	2
9010                     	xdef	_mqtt_keep_alive
9011  008c               _application_message:
9012  008c 000000        	ds.b	3
9013                     	xdef	_application_message
9014  008f               _Port_Mqttd:
9015  008f 0000          	ds.b	2
9016                     	xdef	_Port_Mqttd
9017  0091               _mqttport:
9018  0091 0000          	ds.b	2
9019                     	xdef	_mqttport
9020  0093               _connect_flags:
9021  0093 00            	ds.b	1
9022                     	xdef	_connect_flags
9023                     	xref	_OctetArray
9024                     	xref	_second_counter
9025  0094               _time_mark2:
9026  0094 00000000      	ds.b	4
9027                     	xdef	_time_mark2
9028  0098               _IpAddr:
9029  0098 00000000      	ds.b	4
9030                     	xdef	_IpAddr
9031  009c               _Port_Httpd:
9032  009c 0000          	ds.b	2
9033                     	xdef	_Port_Httpd
9034  009e               _mqtt_parse_complete:
9035  009e 00            	ds.b	1
9036                     	xdef	_mqtt_parse_complete
9037  009f               _parse_complete:
9038  009f 00            	ds.b	1
9039                     	xdef	_parse_complete
9040  00a0               _mqtt_close_tcp:
9041  00a0 00            	ds.b	1
9042                     	xdef	_mqtt_close_tcp
9043  00a1               _restart_reboot_step:
9044  00a1 00            	ds.b	1
9045                     	xdef	_restart_reboot_step
9046  00a2               _restart_request:
9047  00a2 00            	ds.b	1
9048                     	xdef	_restart_request
9049  00a3               _user_reboot_request:
9050  00a3 00            	ds.b	1
9051                     	xdef	_user_reboot_request
9052  00a4               _reboot_request:
9053  00a4 00            	ds.b	1
9054                     	xdef	_reboot_request
9055  00a5               _mac_string:
9056  00a5 000000000000  	ds.b	13
9057                     	xdef	_mac_string
9058  00b2               _Pending_uip_ethaddr_oct:
9059  00b2 000000000000  	ds.b	6
9060                     	xdef	_Pending_uip_ethaddr_oct
9061  00b8               _Pending_config_settings:
9062  00b8 000000000000  	ds.b	6
9063                     	xdef	_Pending_config_settings
9064  00be               _Pending_devicename:
9065  00be 000000000000  	ds.b	20
9066                     	xdef	_Pending_devicename
9067  00d2               _Pending_port:
9068  00d2 0000          	ds.b	2
9069                     	xdef	_Pending_port
9070  00d4               _Pending_netmask:
9071  00d4 00000000      	ds.b	4
9072                     	xdef	_Pending_netmask
9073  00d8               _Pending_draddr:
9074  00d8 00000000      	ds.b	4
9075                     	xdef	_Pending_draddr
9076  00dc               _Pending_hostaddr:
9077  00dc 00000000      	ds.b	4
9078                     	xdef	_Pending_hostaddr
9079  00e0               _Pending_mqtt_password:
9080  00e0 000000000000  	ds.b	11
9081                     	xdef	_Pending_mqtt_password
9082  00eb               _Pending_mqtt_username:
9083  00eb 000000000000  	ds.b	11
9084                     	xdef	_Pending_mqtt_username
9085  00f6               _Pending_mqttport:
9086  00f6 0000          	ds.b	2
9087                     	xdef	_Pending_mqttport
9088  00f8               _Pending_mqttserveraddr:
9089  00f8 00000000      	ds.b	4
9090                     	xdef	_Pending_mqttserveraddr
9091  00fc               _stack_error:
9092  00fc 00            	ds.b	1
9093                     	xdef	_stack_error
9094  00fd               _state_request:
9095  00fd 00            	ds.b	1
9096                     	xdef	_state_request
9097  00fe               _invert_input:
9098  00fe 00            	ds.b	1
9099                     	xdef	_invert_input
9100  00ff               _invert_output:
9101  00ff 00            	ds.b	1
9102                     	xdef	_invert_output
9103  0100               _IO_8to1_sent:
9104  0100 00            	ds.b	1
9105                     	xdef	_IO_8to1_sent
9106  0101               _IO_16to9_sent:
9107  0101 00            	ds.b	1
9108                     	xdef	_IO_16to9_sent
9109  0102               _IO_8to1_new2:
9110  0102 00            	ds.b	1
9111                     	xdef	_IO_8to1_new2
9112  0103               _IO_16to9_new2:
9113  0103 00            	ds.b	1
9114                     	xdef	_IO_16to9_new2
9115  0104               _IO_8to1_new1:
9116  0104 00            	ds.b	1
9117                     	xdef	_IO_8to1_new1
9118  0105               _IO_16to9_new1:
9119  0105 00            	ds.b	1
9120                     	xdef	_IO_16to9_new1
9121  0106               _IO_8to1:
9122  0106 00            	ds.b	1
9123                     	xdef	_IO_8to1
9124  0107               _IO_16to9:
9125  0107 00            	ds.b	1
9126                     	xdef	_IO_16to9
9127                     .eeprom:	section	.data
9128  0000               _stored_devicename:
9129  0000 000000000000  	ds.b	20
9130                     	xdef	_stored_devicename
9131  0014               _stored_IO_8to1:
9132  0014 00            	ds.b	1
9133                     	xdef	_stored_IO_8to1
9134  0015               _stored_unused1:
9135  0015 00            	ds.b	1
9136                     	xdef	_stored_unused1
9137  0016               _stored_unused2:
9138  0016 00            	ds.b	1
9139                     	xdef	_stored_unused2
9140  0017               _stored_uip_ethaddr_oct:
9141  0017 000000000000  	ds.b	6
9142                     	xdef	_stored_uip_ethaddr_oct
9143  001d               _stored_port:
9144  001d 0000          	ds.b	2
9145                     	xdef	_stored_port
9146  001f               _stored_netmask:
9147  001f 00000000      	ds.b	4
9148                     	xdef	_stored_netmask
9149  0023               _stored_draddr:
9150  0023 00000000      	ds.b	4
9151                     	xdef	_stored_draddr
9152  0027               _stored_hostaddr:
9153  0027 00000000      	ds.b	4
9154                     	xdef	_stored_hostaddr
9155  002b               _magic1:
9156  002b 00            	ds.b	1
9157                     	xdef	_magic1
9158  002c               _magic2:
9159  002c 00            	ds.b	1
9160                     	xdef	_magic2
9161  002d               _magic3:
9162  002d 00            	ds.b	1
9163                     	xdef	_magic3
9164  002e               _magic4:
9165  002e 00            	ds.b	1
9166                     	xdef	_magic4
9167  002f               _stored_mqttport:
9168  002f 0000          	ds.b	2
9169                     	xdef	_stored_mqttport
9170  0031               _stored_mqttserveraddr:
9171  0031 00000000      	ds.b	4
9172                     	xdef	_stored_mqttserveraddr
9173  0035               _stored_mqtt_username:
9174  0035 000000000000  	ds.b	11
9175                     	xdef	_stored_mqtt_username
9176  0040               _stored_mqtt_password:
9177  0040 000000000000  	ds.b	11
9178                     	xdef	_stored_mqtt_password
9179  004b               _stored_IO_16to9:
9180  004b 00            	ds.b	1
9181                     	xdef	_stored_IO_16to9
9182  004c               _stored_config_settings:
9183  004c 000000000000  	ds.b	6
9184                     	xdef	_stored_config_settings
9185                     	xdef	_stack_limit2
9186                     	xdef	_stack_limit1
9187                     	xref	_mqtt_disconnect
9188                     	xref	_mqtt_subscribe
9189                     	xref	_mqtt_publish
9190                     	xref	_mqtt_connect
9191                     	xref	_mqtt_init
9192                     	xref	_strlen
9193                     	xref	_strcat
9194                     	xref	_wait_timer
9195                     	xref	_arp_timer_expired
9196                     	xref	_periodic_timer_expired
9197                     	xref	_clock_init
9198                     	xref	_LEDcontrol
9199                     	xref	_gpio_init
9200                     	xref	_check_mqtt_server_arp_entry
9201                     	xref	_uip_arp_timer
9202                     	xref	_uip_arp_out
9203                     	xref	_uip_arp_arpin
9204                     	xref	_uip_arp_init
9205                     	xref	_uip_ethaddr
9206                     	xref	_uip_mqttserveraddr
9207                     	xref	_uip_draddr
9208                     	xref	_uip_netmask
9209                     	xref	_uip_hostaddr
9210                     	xref	_uip_process
9211                     	xref	_uip_conns
9212                     	xref	_uip_conn
9213                     	xref	_uip_len
9214                     	xref	_uip_appdata
9215                     	xref	_htons
9216                     	xref	_uip_connect
9217                     	xref	_uip_buf
9218                     	xref	_uip_init
9219                     	xref	_GpioSetPin
9220                     	xref	_HttpDInit
9221                     	xref	_emb_itoa
9222                     	xref	_Enc28j60Send
9223                     	xref	_Enc28j60Receive
9224                     	xref	_Enc28j60Init
9225                     	xref	_spi_init
9226                     	xdef	_publish_pinstate_all
9227                     	xdef	_publish_pinstate
9228                     	xdef	_publish_outbound
9229                     	xdef	_publish_callback
9230                     	xdef	_mqtt_sanity_check
9231                     	xdef	_mqtt_startup
9232                     	xdef	_debugflash
9233                     	xdef	_fastflash
9234                     	xdef	_oneflash
9235                     	xdef	_reboot
9236                     	xdef	_restart
9237                     	xdef	_check_restart_reboot
9238                     	xdef	_check_reset_button
9239                     	xdef	_write_output_registers
9240                     	xdef	_read_input_registers
9241                     	xdef	_check_runtime_changes
9242                     	xdef	_update_mac_string
9243                     	xdef	_check_eeprom_IOpin_settings
9244                     	xdef	_check_eeprom_settings
9245                     	xdef	_unlock_eeprom
9246                     	xdef	_main
9247                     	switch	.const
9248  000f               L5242:
9249  000f 2f7374617465  	dc.b	"/state",0
9250  0016               L7632:
9251  0016 2f6f75745f6f  	dc.b	"/out_off",0
9252  001f               L3632:
9253  001f 2f6f75745f6f  	dc.b	"/out_on",0
9254  0027               L5532:
9255  0027 2f696e5f6f66  	dc.b	"/in_off",0
9256  002f               L1532:
9257  002f 2f696e5f6f6e  	dc.b	"/in_on",0
9258  0036               L5302:
9259  0036 6f6e6c696e65  	dc.b	"online",0
9260  003d               L5202:
9261  003d 2f7374617465  	dc.b	"/state-req",0
9262  0048               L5102:
9263  0048 2f6f666600    	dc.b	"/off",0
9264  004d               L5002:
9265  004d 2f6f6e00      	dc.b	"/on",0
9266  0051               L1771:
9267  0051 6f66666c696e  	dc.b	"offline",0
9268  0059               L7671:
9269  0059 2f7374617475  	dc.b	"/status",0
9270                     	xref.b	c_lreg
9290                     	xref	c_ladc
9291                     	xref	c_lcmp
9292                     	xref	c_ltor
9293                     	xref	c_eewrw
9294                     	xref	c_eewrc
9295                     	end
