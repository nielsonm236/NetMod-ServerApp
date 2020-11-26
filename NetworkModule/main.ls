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
2721                     ; 348   gpio_init();             // Initialize and enable gpio pins
2723  0077 cd0000        	call	_gpio_init
2725                     ; 350   spi_init();              // Initialize the SPI bit bang interface to the
2727  007a cd0000        	call	_spi_init
2729                     ; 353   LEDcontrol(1);           // turn LED on
2731  007d a601          	ld	a,#1
2732  007f cd0000        	call	_LEDcontrol
2734                     ; 355   unlock_eeprom();         // unlock the EEPROM so writes can be performed
2736  0082 cd0000        	call	_unlock_eeprom
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
3961                     ; 1186   if (state_request == STATE_REQUEST_IDLE) {
3963  0001 c600fd        	ld	a,_state_request
3964  0004 2703cc00f9    	jrne	L1222
3965                     ; 1189     xor_tmp = (uint8_t)(IO_16to9 ^ IO_16to9_sent);
3967  0009 c60107        	ld	a,_IO_16to9
3968  000c c80101        	xor	a,_IO_16to9_sent
3969  000f 6b01          	ld	(OFST+0,sp),a
3971                     ; 1191     if      (xor_tmp & 0x80) publish_pinstate('I', '8', IO_16to9, 0x80); // Input 8
3973  0011 2a0a          	jrpl	L3222
3976  0013 4b80          	push	#128
3977  0015 3b0107        	push	_IO_16to9
3978  0018 ae4938        	ldw	x,#18744
3981  001b 2060          	jp	LC002
3982  001d               L3222:
3983                     ; 1192     else if (xor_tmp & 0x40) publish_pinstate('I', '7', IO_16to9, 0x40); // Input 7
3985  001d a540          	bcp	a,#64
3986  001f 270a          	jreq	L7222
3989  0021 4b40          	push	#64
3990  0023 3b0107        	push	_IO_16to9
3991  0026 ae4937        	ldw	x,#18743
3994  0029 2052          	jp	LC002
3995  002b               L7222:
3996                     ; 1193     else if (xor_tmp & 0x20) publish_pinstate('I', '6', IO_16to9, 0x20); // Input 6
3998  002b a520          	bcp	a,#32
3999  002d 270a          	jreq	L3322
4002  002f 4b20          	push	#32
4003  0031 3b0107        	push	_IO_16to9
4004  0034 ae4936        	ldw	x,#18742
4007  0037 2044          	jp	LC002
4008  0039               L3322:
4009                     ; 1194     else if (xor_tmp & 0x10) publish_pinstate('I', '5', IO_16to9, 0x10); // Input 5
4011  0039 a510          	bcp	a,#16
4012  003b 270a          	jreq	L7322
4015  003d 4b10          	push	#16
4016  003f 3b0107        	push	_IO_16to9
4017  0042 ae4935        	ldw	x,#18741
4020  0045 2036          	jp	LC002
4021  0047               L7322:
4022                     ; 1195     else if (xor_tmp & 0x08) publish_pinstate('I', '4', IO_16to9, 0x08); // Input 4
4024  0047 a508          	bcp	a,#8
4025  0049 270a          	jreq	L3422
4028  004b 4b08          	push	#8
4029  004d 3b0107        	push	_IO_16to9
4030  0050 ae4934        	ldw	x,#18740
4033  0053 2028          	jp	LC002
4034  0055               L3422:
4035                     ; 1196     else if (xor_tmp & 0x04) publish_pinstate('I', '3', IO_16to9, 0x04); // Input 3
4037  0055 a504          	bcp	a,#4
4038  0057 270a          	jreq	L7422
4041  0059 4b04          	push	#4
4042  005b 3b0107        	push	_IO_16to9
4043  005e ae4933        	ldw	x,#18739
4046  0061 201a          	jp	LC002
4047  0063               L7422:
4048                     ; 1197     else if (xor_tmp & 0x02) publish_pinstate('I', '2', IO_16to9, 0x02); // Input 2
4050  0063 a502          	bcp	a,#2
4051  0065 270a          	jreq	L3522
4054  0067 4b02          	push	#2
4055  0069 3b0107        	push	_IO_16to9
4056  006c ae4932        	ldw	x,#18738
4059  006f 200c          	jp	LC002
4060  0071               L3522:
4061                     ; 1198     else if (xor_tmp & 0x01) publish_pinstate('I', '1', IO_16to9, 0x01); // Input 1
4063  0071 a501          	bcp	a,#1
4064  0073 270c          	jreq	L5222
4067  0075 4b01          	push	#1
4068  0077 3b0107        	push	_IO_16to9
4069  007a ae4931        	ldw	x,#18737
4071  007d               LC002:
4072  007d cd0000        	call	_publish_pinstate
4073  0080 85            	popw	x
4074  0081               L5222:
4075                     ; 1202     xor_tmp = (uint8_t)(IO_8to1 ^ IO_8to1_sent);
4077  0081 c60106        	ld	a,_IO_8to1
4078  0084 c80100        	xor	a,_IO_8to1_sent
4079  0087 6b01          	ld	(OFST+0,sp),a
4081                     ; 1204     if      (xor_tmp & 0x80) publish_pinstate('O', '8', IO_8to1, 0x80); // Output 8
4083  0089 2a0a          	jrpl	L1622
4086  008b 4b80          	push	#128
4087  008d 3b0106        	push	_IO_8to1
4088  0090 ae4f38        	ldw	x,#20280
4091  0093 2060          	jp	LC003
4092  0095               L1622:
4093                     ; 1205     else if (xor_tmp & 0x40) publish_pinstate('O', '7', IO_8to1, 0x40); // Output 7
4095  0095 a540          	bcp	a,#64
4096  0097 270a          	jreq	L5622
4099  0099 4b40          	push	#64
4100  009b 3b0106        	push	_IO_8to1
4101  009e ae4f37        	ldw	x,#20279
4104  00a1 2052          	jp	LC003
4105  00a3               L5622:
4106                     ; 1206     else if (xor_tmp & 0x20) publish_pinstate('O', '6', IO_8to1, 0x20); // Output 6
4108  00a3 a520          	bcp	a,#32
4109  00a5 270a          	jreq	L1722
4112  00a7 4b20          	push	#32
4113  00a9 3b0106        	push	_IO_8to1
4114  00ac ae4f36        	ldw	x,#20278
4117  00af 2044          	jp	LC003
4118  00b1               L1722:
4119                     ; 1207     else if (xor_tmp & 0x10) publish_pinstate('O', '5', IO_8to1, 0x10); // Output 5
4121  00b1 a510          	bcp	a,#16
4122  00b3 270a          	jreq	L5722
4125  00b5 4b10          	push	#16
4126  00b7 3b0106        	push	_IO_8to1
4127  00ba ae4f35        	ldw	x,#20277
4130  00bd 2036          	jp	LC003
4131  00bf               L5722:
4132                     ; 1208     else if (xor_tmp & 0x08) publish_pinstate('O', '4', IO_8to1, 0x08); // Output 4
4134  00bf a508          	bcp	a,#8
4135  00c1 270a          	jreq	L1032
4138  00c3 4b08          	push	#8
4139  00c5 3b0106        	push	_IO_8to1
4140  00c8 ae4f34        	ldw	x,#20276
4143  00cb 2028          	jp	LC003
4144  00cd               L1032:
4145                     ; 1209     else if (xor_tmp & 0x04) publish_pinstate('O', '3', IO_8to1, 0x04); // Output 3
4147  00cd a504          	bcp	a,#4
4148  00cf 270a          	jreq	L5032
4151  00d1 4b04          	push	#4
4152  00d3 3b0106        	push	_IO_8to1
4153  00d6 ae4f33        	ldw	x,#20275
4156  00d9 201a          	jp	LC003
4157  00db               L5032:
4158                     ; 1210     else if (xor_tmp & 0x02) publish_pinstate('O', '2', IO_8to1, 0x02); // Output 2
4160  00db a502          	bcp	a,#2
4161  00dd 270a          	jreq	L1132
4164  00df 4b02          	push	#2
4165  00e1 3b0106        	push	_IO_8to1
4166  00e4 ae4f32        	ldw	x,#20274
4169  00e7 200c          	jp	LC003
4170  00e9               L1132:
4171                     ; 1211     else if (xor_tmp & 0x01) publish_pinstate('O', '1', IO_8to1, 0x01); // Output 1
4173  00e9 a501          	bcp	a,#1
4174  00eb 270c          	jreq	L1222
4177  00ed 4b01          	push	#1
4178  00ef 3b0106        	push	_IO_8to1
4179  00f2 ae4f31        	ldw	x,#20273
4181  00f5               LC003:
4182  00f5 cd0000        	call	_publish_pinstate
4183  00f8 85            	popw	x
4184  00f9               L1222:
4185                     ; 1215   if (state_request == STATE_REQUEST_RCVD) {
4187  00f9 c600fd        	ld	a,_state_request
4188  00fc 4a            	dec	a
4189  00fd 2606          	jrne	L7132
4190                     ; 1217     state_request = STATE_REQUEST_IDLE;
4192  00ff c700fd        	ld	_state_request,a
4193                     ; 1218     publish_pinstate_all();
4195  0102 cd0000        	call	_publish_pinstate_all
4197  0105               L7132:
4198                     ; 1246 }
4201  0105 84            	pop	a
4202  0106 81            	ret	
4266                     ; 1249 void publish_pinstate(uint8_t direction, uint8_t pin, uint8_t value, uint8_t mask)
4266                     ; 1250 {
4267                     .text:	section	.text,new
4268  0000               _publish_pinstate:
4270  0000 89            	pushw	x
4271       00000000      OFST:	set	0
4274                     ; 1253   application_message[0] = '0';
4276  0001 3530008c      	mov	_application_message,#48
4277                     ; 1254   application_message[1] = (uint8_t)(pin);
4279  0005 9f            	ld	a,xl
4280  0006 c7008d        	ld	_application_message+1,a
4281                     ; 1255   application_message[2] = '\0';
4283  0009 725f008e      	clr	_application_message+2
4284                     ; 1257   topic_base[topic_base_len] = '\0';
4286  000d 5f            	clrw	x
4287  000e c6000c        	ld	a,_topic_base_len
4288  0011 97            	ld	xl,a
4289  0012 724f000d      	clr	(_topic_base,x)
4290                     ; 1260   if (direction == 'I') {
4292  0016 7b01          	ld	a,(OFST+1,sp)
4293  0018 a149          	cp	a,#73
4294  001a 2618          	jrne	L3432
4295                     ; 1262     if (invert_input == 0xff) value = (uint8_t)(~value);
4297  001c c600fe        	ld	a,_invert_input
4298  001f 4c            	inc	a
4299  0020 2602          	jrne	L5432
4302  0022 0305          	cpl	(OFST+5,sp)
4303  0024               L5432:
4304                     ; 1263     if (value & mask) strcat(topic_base, "/in_on");
4306  0024 7b05          	ld	a,(OFST+5,sp)
4307  0026 1506          	bcp	a,(OFST+6,sp)
4308  0028 2705          	jreq	L7432
4311  002a ae002f        	ldw	x,#L1532
4314  002d 2013          	jra	L7532
4315  002f               L7432:
4316                     ; 1264     else strcat(topic_base, "/in_off");
4318  002f ae0027        	ldw	x,#L5532
4320  0032 200e          	jra	L7532
4321  0034               L3432:
4322                     ; 1268     if (value & mask) strcat(topic_base, "/out_on");
4324  0034 7b05          	ld	a,(OFST+5,sp)
4325  0036 1506          	bcp	a,(OFST+6,sp)
4326  0038 2705          	jreq	L1632
4329  003a ae001f        	ldw	x,#L3632
4332  003d 2003          	jra	L7532
4333  003f               L1632:
4334                     ; 1269     else strcat(topic_base, "/out_off");
4336  003f ae0016        	ldw	x,#L7632
4338  0042               L7532:
4339  0042 89            	pushw	x
4340  0043 ae000d        	ldw	x,#_topic_base
4341  0046 cd0000        	call	_strcat
4342  0049 85            	popw	x
4343                     ; 1273   mqtt_publish(&mqttclient,
4343                     ; 1274                topic_base,
4343                     ; 1275 	       application_message,
4343                     ; 1276 	       2,
4343                     ; 1277 	       MQTT_PUBLISH_QOS_0);
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
4356                     ; 1279   if (direction == 'I') {
4358  0060 7b01          	ld	a,(OFST+1,sp)
4359  0062 a149          	cp	a,#73
4360  0064 2619          	jrne	L1732
4361                     ; 1281     if (IO_16to9 & mask) IO_16to9_sent |= mask;
4363  0066 c60107        	ld	a,_IO_16to9
4364  0069 1506          	bcp	a,(OFST+6,sp)
4365  006b 2707          	jreq	L3732
4368  006d c60101        	ld	a,_IO_16to9_sent
4369  0070 1a06          	or	a,(OFST+6,sp)
4371  0072 2006          	jp	LC005
4372  0074               L3732:
4373                     ; 1282     else IO_16to9_sent &= (uint8_t)~mask;
4375  0074 7b06          	ld	a,(OFST+6,sp)
4376  0076 43            	cpl	a
4377  0077 c40101        	and	a,_IO_16to9_sent
4378  007a               LC005:
4379  007a c70101        	ld	_IO_16to9_sent,a
4380  007d 2017          	jra	L7732
4381  007f               L1732:
4382                     ; 1286     if (IO_8to1 & mask) IO_8to1_sent |= mask;
4384  007f c60106        	ld	a,_IO_8to1
4385  0082 1506          	bcp	a,(OFST+6,sp)
4386  0084 2707          	jreq	L1042
4389  0086 c60100        	ld	a,_IO_8to1_sent
4390  0089 1a06          	or	a,(OFST+6,sp)
4392  008b 2006          	jp	LC004
4393  008d               L1042:
4394                     ; 1287     else IO_8to1_sent &= (uint8_t)~mask;
4396  008d 7b06          	ld	a,(OFST+6,sp)
4397  008f 43            	cpl	a
4398  0090 c40100        	and	a,_IO_8to1_sent
4399  0093               LC004:
4400  0093 c70100        	ld	_IO_8to1_sent,a
4401  0096               L7732:
4402                     ; 1289 }
4405  0096 85            	popw	x
4406  0097 81            	ret	
4455                     ; 1292 void publish_pinstate_all(void)
4455                     ; 1293 {
4456                     .text:	section	.text,new
4457  0000               _publish_pinstate_all:
4459  0000 89            	pushw	x
4460       00000002      OFST:	set	2
4463                     ; 1299   j = IO_16to9;
4465  0001 c60107        	ld	a,_IO_16to9
4466  0004 6b02          	ld	(OFST+0,sp),a
4468                     ; 1300   k = IO_8to1;
4470  0006 c60106        	ld	a,_IO_8to1
4471  0009 6b01          	ld	(OFST-1,sp),a
4473                     ; 1303   if (invert_input == 0xff) j = (uint8_t)(~j);
4475  000b c600fe        	ld	a,_invert_input
4476  000e 4c            	inc	a
4477  000f 2602          	jrne	L3242
4480  0011 0302          	cpl	(OFST+0,sp)
4482  0013               L3242:
4483                     ; 1305   application_message[0] = j;
4485  0013 7b02          	ld	a,(OFST+0,sp)
4486  0015 c7008c        	ld	_application_message,a
4487                     ; 1306   application_message[1] = k;
4489  0018 7b01          	ld	a,(OFST-1,sp)
4490  001a c7008d        	ld	_application_message+1,a
4491                     ; 1307   application_message[2] = '\0';
4493  001d 725f008e      	clr	_application_message+2
4494                     ; 1309   topic_base[topic_base_len] = '\0';
4496  0021 5f            	clrw	x
4497  0022 c6000c        	ld	a,_topic_base_len
4498  0025 97            	ld	xl,a
4499  0026 724f000d      	clr	(_topic_base,x)
4500                     ; 1310   strcat(topic_base, "/state");
4502  002a ae000f        	ldw	x,#L5242
4503  002d 89            	pushw	x
4504  002e ae000d        	ldw	x,#_topic_base
4505  0031 cd0000        	call	_strcat
4507  0034 85            	popw	x
4508                     ; 1313   mqtt_publish(&mqttclient,
4508                     ; 1314                topic_base,
4508                     ; 1315 	       application_message,
4508                     ; 1316 	       2,
4508                     ; 1317 	       MQTT_PUBLISH_QOS_0);
4510  0035 4b00          	push	#0
4511  0037 ae0002        	ldw	x,#2
4512  003a 89            	pushw	x
4513  003b ae008c        	ldw	x,#_application_message
4514  003e 89            	pushw	x
4515  003f ae000d        	ldw	x,#_topic_base
4516  0042 89            	pushw	x
4517  0043 ae005e        	ldw	x,#_mqttclient
4518  0046 cd0000        	call	_mqtt_publish
4520                     ; 1318 }
4523  0049 5b09          	addw	sp,#9
4524  004b 81            	ret	
4549                     ; 1323 void unlock_eeprom(void)
4549                     ; 1324 {
4550                     .text:	section	.text,new
4551  0000               _unlock_eeprom:
4555  0000 2008          	jra	L1442
4556  0002               L7342:
4557                     ; 1336     FLASH_DUKR = 0xAE; // MASS key 1
4559  0002 35ae5064      	mov	_FLASH_DUKR,#174
4560                     ; 1337     FLASH_DUKR = 0x56; // MASS key 2
4562  0006 35565064      	mov	_FLASH_DUKR,#86
4563  000a               L1442:
4564                     ; 1335   while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
4566  000a 7207505ff3    	btjf	_FLASH_IAPSR,#3,L7342
4567                     ; 1365 }
4570  000f 81            	ret	
4655                     ; 1368 void check_eeprom_settings(void)
4655                     ; 1369 {
4656                     .text:	section	.text,new
4657  0000               _check_eeprom_settings:
4659  0000 88            	push	a
4660       00000001      OFST:	set	1
4663                     ; 1381   if ((magic4 == 0x55) && 
4663                     ; 1382       (magic3 == 0xee) && 
4663                     ; 1383       (magic2 == 0x0f) && 
4663                     ; 1384       (magic1 == 0xf0)) {
4665  0001 c6002e        	ld	a,_magic4
4666  0004 a155          	cp	a,#85
4667  0006 2703cc01af    	jrne	L1652
4669  000b c6002d        	ld	a,_magic3
4670  000e a1ee          	cp	a,#238
4671  0010 26f6          	jrne	L1652
4673  0012 c6002c        	ld	a,_magic2
4674  0015 a10f          	cp	a,#15
4675  0017 26ef          	jrne	L1652
4677  0019 c6002b        	ld	a,_magic1
4678  001c a1f0          	cp	a,#240
4679  001e 26e8          	jrne	L1652
4680                     ; 1389     uip_ipaddr(IpAddr, stored_hostaddr[3], stored_hostaddr[2], stored_hostaddr[1], stored_hostaddr[0]);
4682  0020 c6002a        	ld	a,_stored_hostaddr+3
4683  0023 97            	ld	xl,a
4684  0024 c60029        	ld	a,_stored_hostaddr+2
4685  0027 02            	rlwa	x,a
4686  0028 cf0098        	ldw	_IpAddr,x
4689  002b c60028        	ld	a,_stored_hostaddr+1
4690  002e 97            	ld	xl,a
4691  002f c60027        	ld	a,_stored_hostaddr
4692  0032 02            	rlwa	x,a
4693  0033 cf009a        	ldw	_IpAddr+2,x
4694                     ; 1390     uip_sethostaddr(IpAddr);
4696  0036 ce0098        	ldw	x,_IpAddr
4697  0039 cf0000        	ldw	_uip_hostaddr,x
4700  003c ce009a        	ldw	x,_IpAddr+2
4701  003f cf0002        	ldw	_uip_hostaddr+2,x
4702                     ; 1393     uip_ipaddr(IpAddr,
4704  0042 c60026        	ld	a,_stored_draddr+3
4705  0045 97            	ld	xl,a
4706  0046 c60025        	ld	a,_stored_draddr+2
4707  0049 02            	rlwa	x,a
4708  004a cf0098        	ldw	_IpAddr,x
4711  004d c60024        	ld	a,_stored_draddr+1
4712  0050 97            	ld	xl,a
4713  0051 c60023        	ld	a,_stored_draddr
4714  0054 02            	rlwa	x,a
4715  0055 cf009a        	ldw	_IpAddr+2,x
4716                     ; 1398     uip_setdraddr(IpAddr);
4718  0058 ce0098        	ldw	x,_IpAddr
4719  005b cf0000        	ldw	_uip_draddr,x
4722  005e ce009a        	ldw	x,_IpAddr+2
4723  0061 cf0002        	ldw	_uip_draddr+2,x
4724                     ; 1401     uip_ipaddr(IpAddr,
4726  0064 c60022        	ld	a,_stored_netmask+3
4727  0067 97            	ld	xl,a
4728  0068 c60021        	ld	a,_stored_netmask+2
4729  006b 02            	rlwa	x,a
4730  006c cf0098        	ldw	_IpAddr,x
4733  006f c60020        	ld	a,_stored_netmask+1
4734  0072 97            	ld	xl,a
4735  0073 c6001f        	ld	a,_stored_netmask
4736  0076 02            	rlwa	x,a
4737  0077 cf009a        	ldw	_IpAddr+2,x
4738                     ; 1406     uip_setnetmask(IpAddr);
4740  007a ce0098        	ldw	x,_IpAddr
4741  007d cf0000        	ldw	_uip_netmask,x
4744  0080 ce009a        	ldw	x,_IpAddr+2
4745  0083 cf0002        	ldw	_uip_netmask+2,x
4746                     ; 1410     uip_ipaddr(IpAddr,
4748  0086 c60034        	ld	a,_stored_mqttserveraddr+3
4749  0089 97            	ld	xl,a
4750  008a c60033        	ld	a,_stored_mqttserveraddr+2
4751  008d 02            	rlwa	x,a
4752  008e cf0098        	ldw	_IpAddr,x
4755  0091 c60032        	ld	a,_stored_mqttserveraddr+1
4756  0094 97            	ld	xl,a
4757  0095 c60031        	ld	a,_stored_mqttserveraddr
4758  0098 02            	rlwa	x,a
4759  0099 cf009a        	ldw	_IpAddr+2,x
4760                     ; 1415     uip_setmqttserveraddr(IpAddr);
4762  009c ce0098        	ldw	x,_IpAddr
4763  009f cf0000        	ldw	_uip_mqttserveraddr,x
4766  00a2 ce009a        	ldw	x,_IpAddr+2
4767  00a5 cf0002        	ldw	_uip_mqttserveraddr+2,x
4768                     ; 1417     Port_Mqttd = stored_mqttport;
4770  00a8 ce002f        	ldw	x,_stored_mqttport
4771  00ab cf008f        	ldw	_Port_Mqttd,x
4772                     ; 1421     Port_Httpd = stored_port;
4774  00ae ce001d        	ldw	x,_stored_port
4775  00b1 cf009c        	ldw	_Port_Httpd,x
4776                     ; 1426     uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
4778  00b4 55001c0000    	mov	_uip_ethaddr,_stored_uip_ethaddr_oct+5
4779                     ; 1427     uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
4781  00b9 55001b0001    	mov	_uip_ethaddr+1,_stored_uip_ethaddr_oct+4
4782                     ; 1428     uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
4784  00be 55001a0002    	mov	_uip_ethaddr+2,_stored_uip_ethaddr_oct+3
4785                     ; 1429     uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
4787  00c3 5500190003    	mov	_uip_ethaddr+3,_stored_uip_ethaddr_oct+2
4788                     ; 1430     uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
4790  00c8 5500180004    	mov	_uip_ethaddr+4,_stored_uip_ethaddr_oct+1
4791                     ; 1431     uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
4793  00cd 5500170005    	mov	_uip_ethaddr+5,_stored_uip_ethaddr_oct
4794                     ; 1435     if (stored_config_settings[0] != '0' && stored_config_settings[0] != '1') {
4796  00d2 c6004c        	ld	a,_stored_config_settings
4797  00d5 a130          	cp	a,#48
4798  00d7 270c          	jreq	L3252
4800  00d9 a131          	cp	a,#49
4801  00db 2708          	jreq	L3252
4802                     ; 1436       stored_config_settings[0] = '0';
4804  00dd a630          	ld	a,#48
4805  00df ae004c        	ldw	x,#_stored_config_settings
4806  00e2 cd0000        	call	c_eewrc
4808  00e5               L3252:
4809                     ; 1438     if (stored_config_settings[1] != '0' && stored_config_settings[1] != '1') {
4811  00e5 c6004d        	ld	a,_stored_config_settings+1
4812  00e8 a130          	cp	a,#48
4813  00ea 270c          	jreq	L5252
4815  00ec a131          	cp	a,#49
4816  00ee 2708          	jreq	L5252
4817                     ; 1439       stored_config_settings[1] = '0';
4819  00f0 a630          	ld	a,#48
4820  00f2 ae004d        	ldw	x,#_stored_config_settings+1
4821  00f5 cd0000        	call	c_eewrc
4823  00f8               L5252:
4824                     ; 1441     if (stored_config_settings[2] != '0' && stored_config_settings[2] != '1' && stored_config_settings[2] != '2') {
4826  00f8 c6004e        	ld	a,_stored_config_settings+2
4827  00fb a130          	cp	a,#48
4828  00fd 2710          	jreq	L7252
4830  00ff a131          	cp	a,#49
4831  0101 270c          	jreq	L7252
4833  0103 a132          	cp	a,#50
4834  0105 2708          	jreq	L7252
4835                     ; 1442       stored_config_settings[2] = '2';
4837  0107 a632          	ld	a,#50
4838  0109 ae004e        	ldw	x,#_stored_config_settings+2
4839  010c cd0000        	call	c_eewrc
4841  010f               L7252:
4842                     ; 1444     if (stored_config_settings[3] != '0' && stored_config_settings[3] != '1') {
4844  010f c6004f        	ld	a,_stored_config_settings+3
4845  0112 a130          	cp	a,#48
4846  0114 270c          	jreq	L1352
4848  0116 a131          	cp	a,#49
4849  0118 2708          	jreq	L1352
4850                     ; 1445       stored_config_settings[3] = '0';
4852  011a a630          	ld	a,#48
4853  011c ae004f        	ldw	x,#_stored_config_settings+3
4854  011f cd0000        	call	c_eewrc
4856  0122               L1352:
4857                     ; 1447     if (stored_config_settings[4] != '0') {
4859  0122 c60050        	ld	a,_stored_config_settings+4
4860  0125 a130          	cp	a,#48
4861  0127 2708          	jreq	L3352
4862                     ; 1448       stored_config_settings[4] = '0';
4864  0129 a630          	ld	a,#48
4865  012b ae0050        	ldw	x,#_stored_config_settings+4
4866  012e cd0000        	call	c_eewrc
4868  0131               L3352:
4869                     ; 1450     if (stored_config_settings[5] != '0') {
4871  0131 c60051        	ld	a,_stored_config_settings+5
4872  0134 a130          	cp	a,#48
4873  0136 2708          	jreq	L5352
4874                     ; 1451       stored_config_settings[5] = '0';
4876  0138 a630          	ld	a,#48
4877  013a ae0051        	ldw	x,#_stored_config_settings+5
4878  013d cd0000        	call	c_eewrc
4880  0140               L5352:
4881                     ; 1455     if (stored_config_settings[0] == '0') invert_output = 0x00;
4883  0140 c6004c        	ld	a,_stored_config_settings
4884  0143 a130          	cp	a,#48
4885  0145 2606          	jrne	L7352
4888  0147 725f00ff      	clr	_invert_output
4890  014b 2004          	jra	L1452
4891  014d               L7352:
4892                     ; 1456     else invert_output = 0xff;
4894  014d 35ff00ff      	mov	_invert_output,#255
4895  0151               L1452:
4896                     ; 1459     if (stored_config_settings[1] == '0') invert_input = 0x00;
4898  0151 c6004d        	ld	a,_stored_config_settings+1
4899  0154 a130          	cp	a,#48
4900  0156 2606          	jrne	L3452
4903  0158 725f00fe      	clr	_invert_input
4905  015c 2004          	jra	L5452
4906  015e               L3452:
4907                     ; 1460     else invert_input = 0xff;
4909  015e 35ff00fe      	mov	_invert_input,#255
4910  0162               L5452:
4911                     ; 1465     if (stored_config_settings[2] == '0') {
4913  0162 c6004e        	ld	a,_stored_config_settings+2
4914  0165 a130          	cp	a,#48
4915  0167 260a          	jrne	L7452
4916                     ; 1467       IO_16to9 = 0x00;
4918  0169 725f0107      	clr	_IO_16to9
4919                     ; 1468       IO_8to1 = 0x00;
4921  016d 725f0106      	clr	_IO_8to1
4923  0171 2036          	jra	L1552
4924  0173               L7452:
4925                     ; 1470     else if (stored_config_settings[2] == '1') {
4927  0173 a131          	cp	a,#49
4928  0175 260a          	jrne	L3552
4929                     ; 1472       IO_16to9 = 0xff;
4931  0177 35ff0107      	mov	_IO_16to9,#255
4932                     ; 1473       IO_8to1 = 0xff;
4934  017b 35ff0106      	mov	_IO_8to1,#255
4936  017f 2028          	jra	L1552
4937  0181               L3552:
4938                     ; 1477       IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9;
4940  0181 55004b0101    	mov	_IO_16to9_sent,_stored_IO_16to9
4941  0186 5501010103    	mov	_IO_16to9_new2,_IO_16to9_sent
4942  018b 5501030105    	mov	_IO_16to9_new1,_IO_16to9_new2
4943  0190 5501050107    	mov	_IO_16to9,_IO_16to9_new1
4944                     ; 1478       IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1;
4946  0195 5500140100    	mov	_IO_8to1_sent,_stored_IO_8to1
4947  019a 5501000102    	mov	_IO_8to1_new2,_IO_8to1_sent
4948  019f 5501020104    	mov	_IO_8to1_new1,_IO_8to1_new2
4949  01a4 5501040106    	mov	_IO_8to1,_IO_8to1_new1
4950  01a9               L1552:
4951                     ; 1482     write_output_registers();
4953  01a9 cd0000        	call	_write_output_registers
4956  01ac cc040e        	jra	L7552
4957  01af               L1652:
4958                     ; 1491     uip_ipaddr(IpAddr, 192,168,1,4);
4960  01af aec0a8        	ldw	x,#49320
4961  01b2 cf0098        	ldw	_IpAddr,x
4964  01b5 ae0104        	ldw	x,#260
4965  01b8 cf009a        	ldw	_IpAddr+2,x
4966                     ; 1492     uip_sethostaddr(IpAddr);
4968  01bb ce0098        	ldw	x,_IpAddr
4969  01be cf0000        	ldw	_uip_hostaddr,x
4972  01c1 ce009a        	ldw	x,_IpAddr+2
4973  01c4 cf0002        	ldw	_uip_hostaddr+2,x
4974                     ; 1494     stored_hostaddr[3] = 192;	// MSB
4976  01c7 a6c0          	ld	a,#192
4977  01c9 ae002a        	ldw	x,#_stored_hostaddr+3
4978  01cc cd0000        	call	c_eewrc
4980                     ; 1495     stored_hostaddr[2] = 168;	//
4982  01cf a6a8          	ld	a,#168
4983  01d1 ae0029        	ldw	x,#_stored_hostaddr+2
4984  01d4 cd0000        	call	c_eewrc
4986                     ; 1496     stored_hostaddr[1] = 1;	//
4988  01d7 a601          	ld	a,#1
4989  01d9 ae0028        	ldw	x,#_stored_hostaddr+1
4990  01dc cd0000        	call	c_eewrc
4992                     ; 1497     stored_hostaddr[0] = 4;	// LSB
4994  01df a604          	ld	a,#4
4995  01e1 ae0027        	ldw	x,#_stored_hostaddr
4996  01e4 cd0000        	call	c_eewrc
4998                     ; 1500     uip_ipaddr(IpAddr, 192,168,1,1);
5000  01e7 aec0a8        	ldw	x,#49320
5001  01ea cf0098        	ldw	_IpAddr,x
5004  01ed ae0101        	ldw	x,#257
5005  01f0 cf009a        	ldw	_IpAddr+2,x
5006                     ; 1501     uip_setdraddr(IpAddr);
5008  01f3 ce0098        	ldw	x,_IpAddr
5009  01f6 cf0000        	ldw	_uip_draddr,x
5012  01f9 ce009a        	ldw	x,_IpAddr+2
5013  01fc cf0002        	ldw	_uip_draddr+2,x
5014                     ; 1503     stored_draddr[3] = 192;	// MSB
5016  01ff a6c0          	ld	a,#192
5017  0201 ae0026        	ldw	x,#_stored_draddr+3
5018  0204 cd0000        	call	c_eewrc
5020                     ; 1504     stored_draddr[2] = 168;	//
5022  0207 a6a8          	ld	a,#168
5023  0209 ae0025        	ldw	x,#_stored_draddr+2
5024  020c cd0000        	call	c_eewrc
5026                     ; 1505     stored_draddr[1] = 1;		//
5028  020f a601          	ld	a,#1
5029  0211 ae0024        	ldw	x,#_stored_draddr+1
5030  0214 cd0000        	call	c_eewrc
5032                     ; 1506     stored_draddr[0] = 1;		// LSB
5034  0217 a601          	ld	a,#1
5035  0219 ae0023        	ldw	x,#_stored_draddr
5036  021c cd0000        	call	c_eewrc
5038                     ; 1509     uip_ipaddr(IpAddr, 255,255,255,0);
5040  021f aeffff        	ldw	x,#65535
5041  0222 cf0098        	ldw	_IpAddr,x
5044  0225 aeff00        	ldw	x,#65280
5045  0228 cf009a        	ldw	_IpAddr+2,x
5046                     ; 1510     uip_setnetmask(IpAddr);
5048  022b ce0098        	ldw	x,_IpAddr
5049  022e cf0000        	ldw	_uip_netmask,x
5052  0231 ce009a        	ldw	x,_IpAddr+2
5053  0234 cf0002        	ldw	_uip_netmask+2,x
5054                     ; 1512     stored_netmask[3] = 255;	// MSB
5056  0237 a6ff          	ld	a,#255
5057  0239 ae0022        	ldw	x,#_stored_netmask+3
5058  023c cd0000        	call	c_eewrc
5060                     ; 1513     stored_netmask[2] = 255;	//
5062  023f a6ff          	ld	a,#255
5063  0241 ae0021        	ldw	x,#_stored_netmask+2
5064  0244 cd0000        	call	c_eewrc
5066                     ; 1514     stored_netmask[1] = 255;	//
5068  0247 a6ff          	ld	a,#255
5069  0249 ae0020        	ldw	x,#_stored_netmask+1
5070  024c cd0000        	call	c_eewrc
5072                     ; 1515     stored_netmask[0] = 0;	// LSB
5074  024f 4f            	clr	a
5075  0250 ae001f        	ldw	x,#_stored_netmask
5076  0253 cd0000        	call	c_eewrc
5078                     ; 1519     uip_ipaddr(IpAddr, 0,0,0,0);
5080  0256 5f            	clrw	x
5081  0257 cf0098        	ldw	_IpAddr,x
5084  025a cf009a        	ldw	_IpAddr+2,x
5085                     ; 1520     uip_setmqttserveraddr(IpAddr);
5087  025d cf0000        	ldw	_uip_mqttserveraddr,x
5090  0260 cf0002        	ldw	_uip_mqttserveraddr+2,x
5091                     ; 1523     stored_mqttserveraddr[3] = 0;	// MSB
5093  0263 4f            	clr	a
5094  0264 ae0034        	ldw	x,#_stored_mqttserveraddr+3
5095  0267 cd0000        	call	c_eewrc
5097                     ; 1524     stored_mqttserveraddr[2] = 0;	//
5099  026a 4f            	clr	a
5100  026b ae0033        	ldw	x,#_stored_mqttserveraddr+2
5101  026e cd0000        	call	c_eewrc
5103                     ; 1525     stored_mqttserveraddr[1] = 0;	//
5105  0271 4f            	clr	a
5106  0272 ae0032        	ldw	x,#_stored_mqttserveraddr+1
5107  0275 cd0000        	call	c_eewrc
5109                     ; 1526     stored_mqttserveraddr[0] = 0;	// LSB
5111  0278 4f            	clr	a
5112  0279 ae0031        	ldw	x,#_stored_mqttserveraddr
5113  027c cd0000        	call	c_eewrc
5115                     ; 1529     stored_mqttport = 1883;		// Port
5117  027f ae075b        	ldw	x,#1883
5118  0282 89            	pushw	x
5119  0283 ae002f        	ldw	x,#_stored_mqttport
5120  0286 cd0000        	call	c_eewrw
5122  0289 85            	popw	x
5123                     ; 1531     Port_Mqttd = 1883;
5125  028a ae075b        	ldw	x,#1883
5126  028d cf008f        	ldw	_Port_Mqttd,x
5127                     ; 1534     for(i=0; i<11; i++) { stored_mqtt_username[i] = '\0'; }
5129  0290 4f            	clr	a
5130  0291 6b01          	ld	(OFST+0,sp),a
5132  0293               L1262:
5135  0293 5f            	clrw	x
5136  0294 97            	ld	xl,a
5137  0295 4f            	clr	a
5138  0296 1c0035        	addw	x,#_stored_mqtt_username
5139  0299 cd0000        	call	c_eewrc
5143  029c 0c01          	inc	(OFST+0,sp)
5147  029e 7b01          	ld	a,(OFST+0,sp)
5148  02a0 a10b          	cp	a,#11
5149  02a2 25ef          	jrult	L1262
5150                     ; 1535     for(i=0; i<11; i++) { stored_mqtt_password[i] = '\0'; }
5152  02a4 4f            	clr	a
5153  02a5 6b01          	ld	(OFST+0,sp),a
5155  02a7               L7262:
5158  02a7 5f            	clrw	x
5159  02a8 97            	ld	xl,a
5160  02a9 4f            	clr	a
5161  02aa 1c0040        	addw	x,#_stored_mqtt_password
5162  02ad cd0000        	call	c_eewrc
5166  02b0 0c01          	inc	(OFST+0,sp)
5170  02b2 7b01          	ld	a,(OFST+0,sp)
5171  02b4 a10b          	cp	a,#11
5172  02b6 25ef          	jrult	L7262
5173                     ; 1540     stored_port = 8080;
5175  02b8 ae1f90        	ldw	x,#8080
5176  02bb 89            	pushw	x
5177  02bc ae001d        	ldw	x,#_stored_port
5178  02bf cd0000        	call	c_eewrw
5180  02c2 85            	popw	x
5181                     ; 1542     Port_Httpd = 8080;
5183  02c3 ae1f90        	ldw	x,#8080
5184  02c6 cf009c        	ldw	_Port_Httpd,x
5185                     ; 1558     stored_uip_ethaddr_oct[5] = 0xc2;	//MAC MSB
5187  02c9 a6c2          	ld	a,#194
5188  02cb ae001c        	ldw	x,#_stored_uip_ethaddr_oct+5
5189  02ce cd0000        	call	c_eewrc
5191                     ; 1559     stored_uip_ethaddr_oct[4] = 0x4d;
5193  02d1 a64d          	ld	a,#77
5194  02d3 ae001b        	ldw	x,#_stored_uip_ethaddr_oct+4
5195  02d6 cd0000        	call	c_eewrc
5197                     ; 1560     stored_uip_ethaddr_oct[3] = 0x69;
5199  02d9 a669          	ld	a,#105
5200  02db ae001a        	ldw	x,#_stored_uip_ethaddr_oct+3
5201  02de cd0000        	call	c_eewrc
5203                     ; 1561     stored_uip_ethaddr_oct[2] = 0x6b;
5205  02e1 a66b          	ld	a,#107
5206  02e3 ae0019        	ldw	x,#_stored_uip_ethaddr_oct+2
5207  02e6 cd0000        	call	c_eewrc
5209                     ; 1562     stored_uip_ethaddr_oct[1] = 0x65;
5211  02e9 a665          	ld	a,#101
5212  02eb ae0018        	ldw	x,#_stored_uip_ethaddr_oct+1
5213  02ee cd0000        	call	c_eewrc
5215                     ; 1563     stored_uip_ethaddr_oct[0] = 0x00;	//MAC LSB
5217  02f1 4f            	clr	a
5218  02f2 ae0017        	ldw	x,#_stored_uip_ethaddr_oct
5219  02f5 cd0000        	call	c_eewrc
5221                     ; 1565     uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
5223  02f8 35c20000      	mov	_uip_ethaddr,#194
5224                     ; 1566     uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
5226  02fc 354d0001      	mov	_uip_ethaddr+1,#77
5227                     ; 1567     uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
5229  0300 35690002      	mov	_uip_ethaddr+2,#105
5230                     ; 1568     uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
5232  0304 356b0003      	mov	_uip_ethaddr+3,#107
5233                     ; 1569     uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
5235  0308 35650004      	mov	_uip_ethaddr+4,#101
5236                     ; 1570     uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
5238  030c 725f0005      	clr	_uip_ethaddr+5
5239                     ; 1573     stored_devicename[0] =  'N';
5241  0310 a64e          	ld	a,#78
5242  0312 ae0000        	ldw	x,#_stored_devicename
5243  0315 cd0000        	call	c_eewrc
5245                     ; 1574     stored_devicename[1] =  'e';
5247  0318 a665          	ld	a,#101
5248  031a ae0001        	ldw	x,#_stored_devicename+1
5249  031d cd0000        	call	c_eewrc
5251                     ; 1575     stored_devicename[2] =  'w';
5253  0320 a677          	ld	a,#119
5254  0322 ae0002        	ldw	x,#_stored_devicename+2
5255  0325 cd0000        	call	c_eewrc
5257                     ; 1576     stored_devicename[3] =  'D';
5259  0328 a644          	ld	a,#68
5260  032a ae0003        	ldw	x,#_stored_devicename+3
5261  032d cd0000        	call	c_eewrc
5263                     ; 1577     stored_devicename[4] =  'e';
5265  0330 a665          	ld	a,#101
5266  0332 ae0004        	ldw	x,#_stored_devicename+4
5267  0335 cd0000        	call	c_eewrc
5269                     ; 1578     stored_devicename[5] =  'v';
5271  0338 a676          	ld	a,#118
5272  033a ae0005        	ldw	x,#_stored_devicename+5
5273  033d cd0000        	call	c_eewrc
5275                     ; 1579     stored_devicename[6] =  'i';
5277  0340 a669          	ld	a,#105
5278  0342 ae0006        	ldw	x,#_stored_devicename+6
5279  0345 cd0000        	call	c_eewrc
5281                     ; 1580     stored_devicename[7] =  'c';
5283  0348 a663          	ld	a,#99
5284  034a ae0007        	ldw	x,#_stored_devicename+7
5285  034d cd0000        	call	c_eewrc
5287                     ; 1581     stored_devicename[8] =  'e';
5289  0350 a665          	ld	a,#101
5290  0352 ae0008        	ldw	x,#_stored_devicename+8
5291  0355 cd0000        	call	c_eewrc
5293                     ; 1582     stored_devicename[9] =  '0';
5295  0358 a630          	ld	a,#48
5296  035a ae0009        	ldw	x,#_stored_devicename+9
5297  035d cd0000        	call	c_eewrc
5299                     ; 1583     stored_devicename[10] = '0';
5301  0360 a630          	ld	a,#48
5302  0362 ae000a        	ldw	x,#_stored_devicename+10
5303  0365 cd0000        	call	c_eewrc
5305                     ; 1584     stored_devicename[11] = '0';
5307  0368 a630          	ld	a,#48
5308  036a ae000b        	ldw	x,#_stored_devicename+11
5309  036d cd0000        	call	c_eewrc
5311                     ; 1585     for (i=12; i<20; i++) stored_devicename[i] = '\0';
5313  0370 a60c          	ld	a,#12
5314  0372 6b01          	ld	(OFST+0,sp),a
5316  0374               L5362:
5319  0374 5f            	clrw	x
5320  0375 97            	ld	xl,a
5321  0376 4f            	clr	a
5322  0377 1c0000        	addw	x,#_stored_devicename
5323  037a cd0000        	call	c_eewrc
5327  037d 0c01          	inc	(OFST+0,sp)
5331  037f 7b01          	ld	a,(OFST+0,sp)
5332  0381 a114          	cp	a,#20
5333  0383 25ef          	jrult	L5362
5334                     ; 1590     stored_config_settings[0] = '0'; // Set to Invert Output OFF
5336  0385 a630          	ld	a,#48
5337  0387 ae004c        	ldw	x,#_stored_config_settings
5338  038a cd0000        	call	c_eewrc
5340                     ; 1591     stored_config_settings[1] = '0'; // Set to Invert Input Off
5342  038d a630          	ld	a,#48
5343  038f ae004d        	ldw	x,#_stored_config_settings+1
5344  0392 cd0000        	call	c_eewrc
5346                     ; 1592     stored_config_settings[2] = '2'; // Set to Retain pin states
5348  0395 a632          	ld	a,#50
5349  0397 ae004e        	ldw	x,#_stored_config_settings+2
5350  039a cd0000        	call	c_eewrc
5352                     ; 1593     stored_config_settings[3] = '0'; // Set to Half Duplex
5354  039d a630          	ld	a,#48
5355  039f ae004f        	ldw	x,#_stored_config_settings+3
5356  03a2 cd0000        	call	c_eewrc
5358                     ; 1594     stored_config_settings[4] = '0'; // undefined
5360  03a5 a630          	ld	a,#48
5361  03a7 ae0050        	ldw	x,#_stored_config_settings+4
5362  03aa cd0000        	call	c_eewrc
5364                     ; 1595     stored_config_settings[5] = '0'; // undefined
5366  03ad a630          	ld	a,#48
5367  03af ae0051        	ldw	x,#_stored_config_settings+5
5368  03b2 cd0000        	call	c_eewrc
5370                     ; 1596     invert_output = 0x00;			// Turn off output invert bit
5372  03b5 725f00ff      	clr	_invert_output
5373                     ; 1597     invert_input = 0x00;			// Turn off output invert bit
5375  03b9 725f00fe      	clr	_invert_input
5376                     ; 1598     IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9 = 0x00;
5378  03bd 4f            	clr	a
5379  03be ae004b        	ldw	x,#_stored_IO_16to9
5380  03c1 cd0000        	call	c_eewrc
5382  03c4 725f0101      	clr	_IO_16to9_sent
5383  03c8 725f0103      	clr	_IO_16to9_new2
5384  03cc 725f0105      	clr	_IO_16to9_new1
5385  03d0 725f0107      	clr	_IO_16to9
5386                     ; 1599     IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1  = 0x00;
5388  03d4 4f            	clr	a
5389  03d5 ae0014        	ldw	x,#_stored_IO_8to1
5390  03d8 cd0000        	call	c_eewrc
5392  03db 725f0100      	clr	_IO_8to1_sent
5393  03df 725f0102      	clr	_IO_8to1_new2
5394  03e3 725f0104      	clr	_IO_8to1_new1
5395  03e7 725f0106      	clr	_IO_8to1
5396                     ; 1600     write_output_registers();          // Set Relay Control outputs
5398  03eb cd0000        	call	_write_output_registers
5400                     ; 1603     magic4 = 0x55;		// MSB
5402  03ee a655          	ld	a,#85
5403  03f0 ae002e        	ldw	x,#_magic4
5404  03f3 cd0000        	call	c_eewrc
5406                     ; 1604     magic3 = 0xee;		//
5408  03f6 a6ee          	ld	a,#238
5409  03f8 ae002d        	ldw	x,#_magic3
5410  03fb cd0000        	call	c_eewrc
5412                     ; 1605     magic2 = 0x0f;		//
5414  03fe a60f          	ld	a,#15
5415  0400 ae002c        	ldw	x,#_magic2
5416  0403 cd0000        	call	c_eewrc
5418                     ; 1606     magic1 = 0xf0;		// LSB
5420  0406 a6f0          	ld	a,#240
5421  0408 ae002b        	ldw	x,#_magic1
5422  040b cd0000        	call	c_eewrc
5424  040e               L7552:
5425                     ; 1611   for (i=0; i<4; i++) {
5427  040e 4f            	clr	a
5428  040f 6b01          	ld	(OFST+0,sp),a
5430  0411               L3462:
5431                     ; 1612     Pending_hostaddr[i] = stored_hostaddr[i];
5433  0411 5f            	clrw	x
5434  0412 97            	ld	xl,a
5435  0413 d60027        	ld	a,(_stored_hostaddr,x)
5436  0416 d700dc        	ld	(_Pending_hostaddr,x),a
5437                     ; 1613     Pending_draddr[i] = stored_draddr[i];
5439  0419 5f            	clrw	x
5440  041a 7b01          	ld	a,(OFST+0,sp)
5441  041c 97            	ld	xl,a
5442  041d d60023        	ld	a,(_stored_draddr,x)
5443  0420 d700d8        	ld	(_Pending_draddr,x),a
5444                     ; 1614     Pending_netmask[i] = stored_netmask[i];
5446  0423 5f            	clrw	x
5447  0424 7b01          	ld	a,(OFST+0,sp)
5448  0426 97            	ld	xl,a
5449  0427 d6001f        	ld	a,(_stored_netmask,x)
5450  042a d700d4        	ld	(_Pending_netmask,x),a
5451                     ; 1611   for (i=0; i<4; i++) {
5453  042d 0c01          	inc	(OFST+0,sp)
5457  042f 7b01          	ld	a,(OFST+0,sp)
5458  0431 a104          	cp	a,#4
5459  0433 25dc          	jrult	L3462
5460                     ; 1617   Pending_port = stored_port;
5462  0435 ce001d        	ldw	x,_stored_port
5463  0438 cf00d2        	ldw	_Pending_port,x
5464                     ; 1619   for (i=0; i<20; i++) {
5466  043b 4f            	clr	a
5467  043c 6b01          	ld	(OFST+0,sp),a
5469  043e               L1562:
5470                     ; 1620     Pending_devicename[i] = stored_devicename[i];
5472  043e 5f            	clrw	x
5473  043f 97            	ld	xl,a
5474  0440 d60000        	ld	a,(_stored_devicename,x)
5475  0443 d700be        	ld	(_Pending_devicename,x),a
5476                     ; 1619   for (i=0; i<20; i++) {
5478  0446 0c01          	inc	(OFST+0,sp)
5482  0448 7b01          	ld	a,(OFST+0,sp)
5483  044a a114          	cp	a,#20
5484  044c 25f0          	jrult	L1562
5485                     ; 1623   for (i=0; i<6; i++) {
5487  044e 4f            	clr	a
5488  044f 6b01          	ld	(OFST+0,sp),a
5490  0451               L7562:
5491                     ; 1624     Pending_config_settings[i] = stored_config_settings[i];
5493  0451 5f            	clrw	x
5494  0452 97            	ld	xl,a
5495  0453 d6004c        	ld	a,(_stored_config_settings,x)
5496  0456 d700b8        	ld	(_Pending_config_settings,x),a
5497                     ; 1625     Pending_uip_ethaddr_oct[i] = stored_uip_ethaddr_oct[i];
5499  0459 5f            	clrw	x
5500  045a 7b01          	ld	a,(OFST+0,sp)
5501  045c 97            	ld	xl,a
5502  045d d60017        	ld	a,(_stored_uip_ethaddr_oct,x)
5503  0460 d700b2        	ld	(_Pending_uip_ethaddr_oct,x),a
5504                     ; 1623   for (i=0; i<6; i++) {
5506  0463 0c01          	inc	(OFST+0,sp)
5510  0465 7b01          	ld	a,(OFST+0,sp)
5511  0467 a106          	cp	a,#6
5512  0469 25e6          	jrult	L7562
5513                     ; 1629   for (i=0; i<4; i++) {
5515  046b 4f            	clr	a
5516  046c 6b01          	ld	(OFST+0,sp),a
5518  046e               L5662:
5519                     ; 1630     Pending_mqttserveraddr[i] = stored_mqttserveraddr[i];
5521  046e 5f            	clrw	x
5522  046f 97            	ld	xl,a
5523  0470 d60031        	ld	a,(_stored_mqttserveraddr,x)
5524  0473 d700f8        	ld	(_Pending_mqttserveraddr,x),a
5525                     ; 1629   for (i=0; i<4; i++) {
5527  0476 0c01          	inc	(OFST+0,sp)
5531  0478 7b01          	ld	a,(OFST+0,sp)
5532  047a a104          	cp	a,#4
5533  047c 25f0          	jrult	L5662
5534                     ; 1632   Pending_mqttport = stored_mqttport;
5536  047e ce002f        	ldw	x,_stored_mqttport
5537  0481 cf00f6        	ldw	_Pending_mqttport,x
5538                     ; 1633   for (i=0; i<11; i++) {
5540  0484 4f            	clr	a
5541  0485 6b01          	ld	(OFST+0,sp),a
5543  0487               L3762:
5544                     ; 1634     Pending_mqtt_username[i] = stored_mqtt_username[i];
5546  0487 5f            	clrw	x
5547  0488 97            	ld	xl,a
5548  0489 d60035        	ld	a,(_stored_mqtt_username,x)
5549  048c d700eb        	ld	(_Pending_mqtt_username,x),a
5550                     ; 1635     Pending_mqtt_password[i] = stored_mqtt_password[i];
5552  048f 5f            	clrw	x
5553  0490 7b01          	ld	a,(OFST+0,sp)
5554  0492 97            	ld	xl,a
5555  0493 d60040        	ld	a,(_stored_mqtt_password,x)
5556  0496 d700e0        	ld	(_Pending_mqtt_password,x),a
5557                     ; 1633   for (i=0; i<11; i++) {
5559  0499 0c01          	inc	(OFST+0,sp)
5563  049b 7b01          	ld	a,(OFST+0,sp)
5564  049d a10b          	cp	a,#11
5565  049f 25e6          	jrult	L3762
5566                     ; 1638   strcat(topic_base, stored_devicename);
5568  04a1 ae0000        	ldw	x,#_stored_devicename
5569  04a4 89            	pushw	x
5570  04a5 ae000d        	ldw	x,#_topic_base
5571  04a8 cd0000        	call	_strcat
5573  04ab 85            	popw	x
5574                     ; 1641   topic_base_len = (uint8_t)strlen(topic_base);
5576  04ac ae000d        	ldw	x,#_topic_base
5577  04af cd0000        	call	_strlen
5579  04b2 9f            	ld	a,xl
5580  04b3 c7000c        	ld	_topic_base_len,a
5581                     ; 1645   update_mac_string();
5583  04b6 cd0000        	call	_update_mac_string
5585                     ; 1647 }
5588  04b9 84            	pop	a
5589  04ba 81            	ret	
5632                     ; 1650 void update_mac_string(void) {
5633                     .text:	section	.text,new
5634  0000               _update_mac_string:
5636  0000 89            	pushw	x
5637       00000002      OFST:	set	2
5640                     ; 1656   i = 5;
5642  0001 a605          	ld	a,#5
5643  0003 6b01          	ld	(OFST-1,sp),a
5645                     ; 1657   j = 0;
5647  0005 0f02          	clr	(OFST+0,sp)
5649  0007               L7172:
5650                     ; 1659     emb_itoa(stored_uip_ethaddr_oct[i], OctetArray, 16, 2);
5652  0007 4b02          	push	#2
5653  0009 4b10          	push	#16
5654  000b ae0000        	ldw	x,#_OctetArray
5655  000e 89            	pushw	x
5656  000f 7b05          	ld	a,(OFST+3,sp)
5657  0011 5f            	clrw	x
5658  0012 97            	ld	xl,a
5659  0013 d60017        	ld	a,(_stored_uip_ethaddr_oct,x)
5660  0016 b703          	ld	c_lreg+3,a
5661  0018 3f02          	clr	c_lreg+2
5662  001a 3f01          	clr	c_lreg+1
5663  001c 3f00          	clr	c_lreg
5664  001e be02          	ldw	x,c_lreg+2
5665  0020 89            	pushw	x
5666  0021 be00          	ldw	x,c_lreg
5667  0023 89            	pushw	x
5668  0024 cd0000        	call	_emb_itoa
5670  0027 5b08          	addw	sp,#8
5671                     ; 1660     mac_string[j++] = OctetArray[0];
5673  0029 7b02          	ld	a,(OFST+0,sp)
5674  002b 0c02          	inc	(OFST+0,sp)
5676  002d 5f            	clrw	x
5677  002e 97            	ld	xl,a
5678  002f c60000        	ld	a,_OctetArray
5679  0032 d700a5        	ld	(_mac_string,x),a
5680                     ; 1661     mac_string[j++] = OctetArray[1];
5682  0035 7b02          	ld	a,(OFST+0,sp)
5683  0037 0c02          	inc	(OFST+0,sp)
5685  0039 5f            	clrw	x
5686  003a 97            	ld	xl,a
5687  003b c60001        	ld	a,_OctetArray+1
5688  003e d700a5        	ld	(_mac_string,x),a
5689                     ; 1662     i--;
5691  0041 0a01          	dec	(OFST-1,sp)
5693                     ; 1658   while (j<12) {
5695  0043 7b02          	ld	a,(OFST+0,sp)
5696  0045 a10c          	cp	a,#12
5697  0047 25be          	jrult	L7172
5698                     ; 1664   mac_string[12] = '\0';
5700  0049 725f00b1      	clr	_mac_string+12
5701                     ; 1665 }
5704  004d 85            	popw	x
5705  004e 81            	ret	
5783                     ; 1668 void check_runtime_changes(void)
5783                     ; 1669 {
5784                     .text:	section	.text,new
5785  0000               _check_runtime_changes:
5787  0000 88            	push	a
5788       00000001      OFST:	set	1
5791                     ; 1682   read_input_registers();
5793  0001 cd0000        	call	_read_input_registers
5795                     ; 1684   if (parse_complete == 1 || mqtt_parse_complete == 1) {
5797  0004 c6009f        	ld	a,_parse_complete
5798  0007 4a            	dec	a
5799  0008 2706          	jreq	L3472
5801  000a c6009e        	ld	a,_mqtt_parse_complete
5802  000d 4a            	dec	a
5803  000e 2624          	jrne	L1472
5804  0010               L3472:
5805                     ; 1707     if (stored_IO_8to1 != IO_8to1) {
5807  0010 c60014        	ld	a,_stored_IO_8to1
5808  0013 c10106        	cp	a,_IO_8to1
5809  0016 2710          	jreq	L5472
5810                     ; 1711       if (stored_config_settings[2] == '2') {
5812  0018 c6004e        	ld	a,_stored_config_settings+2
5813  001b a132          	cp	a,#50
5814  001d 2609          	jrne	L5472
5815                     ; 1712         stored_IO_8to1 = IO_8to1;
5817  001f c60106        	ld	a,_IO_8to1
5818  0022 ae0014        	ldw	x,#_stored_IO_8to1
5819  0025 cd0000        	call	c_eewrc
5821  0028               L5472:
5822                     ; 1716     write_output_registers();
5824  0028 cd0000        	call	_write_output_registers
5826                     ; 1722     if (mqtt_parse_complete == 1) {
5828  002b c6009e        	ld	a,_mqtt_parse_complete
5829  002e 4a            	dec	a
5830  002f 2603          	jrne	L1472
5831                     ; 1724       mqtt_parse_complete = 0;
5833  0031 c7009e        	ld	_mqtt_parse_complete,a
5834  0034               L1472:
5835                     ; 1729   if (parse_complete == 1) {
5837  0034 c6009f        	ld	a,_parse_complete
5838  0037 4a            	dec	a
5839  0038 2703cc02c5    	jrne	L3572
5840                     ; 1770     if ((Pending_config_settings[0] != stored_config_settings[0])
5840                     ; 1771      || (stored_IO_8to1 != IO_8to1)) {
5842  003d c6004c        	ld	a,_stored_config_settings
5843  0040 c100b8        	cp	a,_Pending_config_settings
5844  0043 2608          	jrne	L7572
5846  0045 c60014        	ld	a,_stored_IO_8to1
5847  0048 c10106        	cp	a,_IO_8to1
5848  004b 272d          	jreq	L5572
5849  004d               L7572:
5850                     ; 1774       stored_config_settings[0] = Pending_config_settings[0];
5852  004d c600b8        	ld	a,_Pending_config_settings
5853  0050 ae004c        	ldw	x,#_stored_config_settings
5854  0053 cd0000        	call	c_eewrc
5856                     ; 1777       if (stored_config_settings[0] == '0') invert_output = 0x00;
5858  0056 c6004c        	ld	a,_stored_config_settings
5859  0059 a130          	cp	a,#48
5860  005b 2606          	jrne	L1672
5863  005d 725f00ff      	clr	_invert_output
5865  0061 2004          	jra	L3672
5866  0063               L1672:
5867                     ; 1778       else invert_output = 0xff;
5869  0063 35ff00ff      	mov	_invert_output,#255
5870  0067               L3672:
5871                     ; 1782       if (stored_config_settings[2] == '2') {
5873  0067 c6004e        	ld	a,_stored_config_settings+2
5874  006a a132          	cp	a,#50
5875  006c 2609          	jrne	L5672
5876                     ; 1783         stored_IO_8to1 = IO_8to1;
5878  006e c60106        	ld	a,_IO_8to1
5879  0071 ae0014        	ldw	x,#_stored_IO_8to1
5880  0074 cd0000        	call	c_eewrc
5882  0077               L5672:
5883                     ; 1787       write_output_registers();
5885  0077 cd0000        	call	_write_output_registers
5887  007a               L5572:
5888                     ; 1791     if (Pending_config_settings[1] != stored_config_settings[1]) {
5890  007a c6004d        	ld	a,_stored_config_settings+1
5891  007d c100b9        	cp	a,_Pending_config_settings+1
5892  0080 271e          	jreq	L7672
5893                     ; 1793       stored_config_settings[1] = Pending_config_settings[1];
5895  0082 c600b9        	ld	a,_Pending_config_settings+1
5896  0085 ae004d        	ldw	x,#_stored_config_settings+1
5897  0088 cd0000        	call	c_eewrc
5899                     ; 1796       if (stored_config_settings[1] == '0') invert_input = 0x00;
5901  008b c6004d        	ld	a,_stored_config_settings+1
5902  008e a130          	cp	a,#48
5903  0090 2606          	jrne	L1772
5906  0092 725f00fe      	clr	_invert_input
5908  0096 2004          	jra	L3772
5909  0098               L1772:
5910                     ; 1797       else invert_input = 0xff;
5912  0098 35ff00fe      	mov	_invert_input,#255
5913  009c               L3772:
5914                     ; 1801       restart_request = 1;
5916  009c 350100a2      	mov	_restart_request,#1
5917  00a0               L7672:
5918                     ; 1835     if (Pending_config_settings[2] != stored_config_settings[2]) {
5920  00a0 c6004e        	ld	a,_stored_config_settings+2
5921  00a3 c100ba        	cp	a,_Pending_config_settings+2
5922  00a6 2709          	jreq	L5772
5923                     ; 1837       stored_config_settings[2] = Pending_config_settings[2];
5925  00a8 c600ba        	ld	a,_Pending_config_settings+2
5926  00ab ae004e        	ldw	x,#_stored_config_settings+2
5927  00ae cd0000        	call	c_eewrc
5929  00b1               L5772:
5930                     ; 1841     if (Pending_config_settings[3] != stored_config_settings[3]) {
5932  00b1 c6004f        	ld	a,_stored_config_settings+3
5933  00b4 c100bb        	cp	a,_Pending_config_settings+3
5934  00b7 270d          	jreq	L7772
5935                     ; 1844       stored_config_settings[3] = Pending_config_settings[3];
5937  00b9 c600bb        	ld	a,_Pending_config_settings+3
5938  00bc ae004f        	ldw	x,#_stored_config_settings+3
5939  00bf cd0000        	call	c_eewrc
5941                     ; 1846       user_reboot_request = 1;
5943  00c2 350100a3      	mov	_user_reboot_request,#1
5944  00c6               L7772:
5945                     ; 1849     stored_config_settings[4] = Pending_config_settings[4];
5947  00c6 c600bc        	ld	a,_Pending_config_settings+4
5948  00c9 ae0050        	ldw	x,#_stored_config_settings+4
5949  00cc cd0000        	call	c_eewrc
5951                     ; 1850     stored_config_settings[5] = Pending_config_settings[5];
5953  00cf c600bd        	ld	a,_Pending_config_settings+5
5954  00d2 ae0051        	ldw	x,#_stored_config_settings+5
5955  00d5 cd0000        	call	c_eewrc
5957                     ; 1853     if (stored_hostaddr[3] != Pending_hostaddr[3] ||
5957                     ; 1854         stored_hostaddr[2] != Pending_hostaddr[2] ||
5957                     ; 1855         stored_hostaddr[1] != Pending_hostaddr[1] ||
5957                     ; 1856         stored_hostaddr[0] != Pending_hostaddr[0]) {
5959  00d8 c6002a        	ld	a,_stored_hostaddr+3
5960  00db c100df        	cp	a,_Pending_hostaddr+3
5961  00de 2618          	jrne	L3003
5963  00e0 c60029        	ld	a,_stored_hostaddr+2
5964  00e3 c100de        	cp	a,_Pending_hostaddr+2
5965  00e6 2610          	jrne	L3003
5967  00e8 c60028        	ld	a,_stored_hostaddr+1
5968  00eb c100dd        	cp	a,_Pending_hostaddr+1
5969  00ee 2608          	jrne	L3003
5971  00f0 c60027        	ld	a,_stored_hostaddr
5972  00f3 c100dc        	cp	a,_Pending_hostaddr
5973  00f6 2713          	jreq	L1003
5974  00f8               L3003:
5975                     ; 1858       for (i=0; i<4; i++) stored_hostaddr[i] = Pending_hostaddr[i];
5977  00f8 4f            	clr	a
5978  00f9 6b01          	ld	(OFST+0,sp),a
5980  00fb               L1103:
5983  00fb 5f            	clrw	x
5984  00fc 97            	ld	xl,a
5985  00fd d600dc        	ld	a,(_Pending_hostaddr,x)
5986  0100 d70027        	ld	(_stored_hostaddr,x),a
5989  0103 0c01          	inc	(OFST+0,sp)
5993  0105 7b01          	ld	a,(OFST+0,sp)
5994  0107 a104          	cp	a,#4
5995  0109 25f0          	jrult	L1103
5996  010b               L1003:
5997                     ; 1862     if (stored_draddr[3] != Pending_draddr[3] ||
5997                     ; 1863         stored_draddr[2] != Pending_draddr[2] ||
5997                     ; 1864         stored_draddr[1] != Pending_draddr[1] ||
5997                     ; 1865         stored_draddr[0] != Pending_draddr[0]) {
5999  010b c60026        	ld	a,_stored_draddr+3
6000  010e c100db        	cp	a,_Pending_draddr+3
6001  0111 2618          	jrne	L1203
6003  0113 c60025        	ld	a,_stored_draddr+2
6004  0116 c100da        	cp	a,_Pending_draddr+2
6005  0119 2610          	jrne	L1203
6007  011b c60024        	ld	a,_stored_draddr+1
6008  011e c100d9        	cp	a,_Pending_draddr+1
6009  0121 2608          	jrne	L1203
6011  0123 c60023        	ld	a,_stored_draddr
6012  0126 c100d8        	cp	a,_Pending_draddr
6013  0129 2717          	jreq	L7103
6014  012b               L1203:
6015                     ; 1867       for (i=0; i<4; i++) stored_draddr[i] = Pending_draddr[i];
6017  012b 4f            	clr	a
6018  012c 6b01          	ld	(OFST+0,sp),a
6020  012e               L7203:
6023  012e 5f            	clrw	x
6024  012f 97            	ld	xl,a
6025  0130 d600d8        	ld	a,(_Pending_draddr,x)
6026  0133 d70023        	ld	(_stored_draddr,x),a
6029  0136 0c01          	inc	(OFST+0,sp)
6033  0138 7b01          	ld	a,(OFST+0,sp)
6034  013a a104          	cp	a,#4
6035  013c 25f0          	jrult	L7203
6036                     ; 1868       restart_request = 1;
6038  013e 350100a2      	mov	_restart_request,#1
6039  0142               L7103:
6040                     ; 1872     if (stored_netmask[3] != Pending_netmask[3] ||
6040                     ; 1873         stored_netmask[2] != Pending_netmask[2] ||
6040                     ; 1874         stored_netmask[1] != Pending_netmask[1] ||
6040                     ; 1875         stored_netmask[0] != Pending_netmask[0]) {
6042  0142 c60022        	ld	a,_stored_netmask+3
6043  0145 c100d7        	cp	a,_Pending_netmask+3
6044  0148 2618          	jrne	L7303
6046  014a c60021        	ld	a,_stored_netmask+2
6047  014d c100d6        	cp	a,_Pending_netmask+2
6048  0150 2610          	jrne	L7303
6050  0152 c60020        	ld	a,_stored_netmask+1
6051  0155 c100d5        	cp	a,_Pending_netmask+1
6052  0158 2608          	jrne	L7303
6054  015a c6001f        	ld	a,_stored_netmask
6055  015d c100d4        	cp	a,_Pending_netmask
6056  0160 2717          	jreq	L5303
6057  0162               L7303:
6058                     ; 1877       for (i=0; i<4; i++) stored_netmask[i] = Pending_netmask[i];
6060  0162 4f            	clr	a
6061  0163 6b01          	ld	(OFST+0,sp),a
6063  0165               L5403:
6066  0165 5f            	clrw	x
6067  0166 97            	ld	xl,a
6068  0167 d600d4        	ld	a,(_Pending_netmask,x)
6069  016a d7001f        	ld	(_stored_netmask,x),a
6072  016d 0c01          	inc	(OFST+0,sp)
6076  016f 7b01          	ld	a,(OFST+0,sp)
6077  0171 a104          	cp	a,#4
6078  0173 25f0          	jrult	L5403
6079                     ; 1878       restart_request = 1;
6081  0175 350100a2      	mov	_restart_request,#1
6082  0179               L5303:
6083                     ; 1882     if (stored_port != Pending_port) {
6085  0179 ce001d        	ldw	x,_stored_port
6086  017c c300d2        	cpw	x,_Pending_port
6087  017f 270f          	jreq	L3503
6088                     ; 1884       stored_port = Pending_port;
6090  0181 ce00d2        	ldw	x,_Pending_port
6091  0184 89            	pushw	x
6092  0185 ae001d        	ldw	x,#_stored_port
6093  0188 cd0000        	call	c_eewrw
6095  018b 350100a2      	mov	_restart_request,#1
6096  018f 85            	popw	x
6097                     ; 1886       restart_request = 1;
6099  0190               L3503:
6100                     ; 1890     for(i=0; i<20; i++) {
6102  0190 4f            	clr	a
6103  0191 6b01          	ld	(OFST+0,sp),a
6105  0193               L5503:
6106                     ; 1891       if (stored_devicename[i] != Pending_devicename[i]) {
6108  0193 5f            	clrw	x
6109  0194 97            	ld	xl,a
6110  0195 905f          	clrw	y
6111  0197 9097          	ld	yl,a
6112  0199 90d60000      	ld	a,(_stored_devicename,y)
6113  019d d100be        	cp	a,(_Pending_devicename,x)
6114  01a0 270e          	jreq	L3603
6115                     ; 1892         stored_devicename[i] = Pending_devicename[i];
6117  01a2 7b01          	ld	a,(OFST+0,sp)
6118  01a4 5f            	clrw	x
6119  01a5 97            	ld	xl,a
6120  01a6 d600be        	ld	a,(_Pending_devicename,x)
6121  01a9 d70000        	ld	(_stored_devicename,x),a
6122                     ; 1898         restart_request = 1;
6124  01ac 350100a2      	mov	_restart_request,#1
6125  01b0               L3603:
6126                     ; 1890     for(i=0; i<20; i++) {
6128  01b0 0c01          	inc	(OFST+0,sp)
6132  01b2 7b01          	ld	a,(OFST+0,sp)
6133  01b4 a114          	cp	a,#20
6134  01b6 25db          	jrult	L5503
6135                     ; 1905     strcpy(topic_base, devicetype);
6137  01b8 ae000d        	ldw	x,#_topic_base
6138  01bb 90ae0000      	ldw	y,#L5261_devicetype
6139  01bf               L403:
6140  01bf 90f6          	ld	a,(y)
6141  01c1 905c          	incw	y
6142  01c3 f7            	ld	(x),a
6143  01c4 5c            	incw	x
6144  01c5 4d            	tnz	a
6145  01c6 26f7          	jrne	L403
6146                     ; 1906     strcat(topic_base, stored_devicename);
6148  01c8 ae0000        	ldw	x,#_stored_devicename
6149  01cb 89            	pushw	x
6150  01cc ae000d        	ldw	x,#_topic_base
6151  01cf cd0000        	call	_strcat
6153  01d2 85            	popw	x
6154                     ; 1907     topic_base_len = (uint8_t)strlen(topic_base);
6156  01d3 ae000d        	ldw	x,#_topic_base
6157  01d6 cd0000        	call	_strlen
6159  01d9 9f            	ld	a,xl
6160  01da c7000c        	ld	_topic_base_len,a
6161                     ; 1910     if (stored_mqttserveraddr[3] != Pending_mqttserveraddr[3] ||
6161                     ; 1911         stored_mqttserveraddr[2] != Pending_mqttserveraddr[2] ||
6161                     ; 1912         stored_mqttserveraddr[1] != Pending_mqttserveraddr[1] ||
6161                     ; 1913         stored_mqttserveraddr[0] != Pending_mqttserveraddr[0]) {
6163  01dd c60034        	ld	a,_stored_mqttserveraddr+3
6164  01e0 c100fb        	cp	a,_Pending_mqttserveraddr+3
6165  01e3 2618          	jrne	L7603
6167  01e5 c60033        	ld	a,_stored_mqttserveraddr+2
6168  01e8 c100fa        	cp	a,_Pending_mqttserveraddr+2
6169  01eb 2610          	jrne	L7603
6171  01ed c60032        	ld	a,_stored_mqttserveraddr+1
6172  01f0 c100f9        	cp	a,_Pending_mqttserveraddr+1
6173  01f3 2608          	jrne	L7603
6175  01f5 c60031        	ld	a,_stored_mqttserveraddr
6176  01f8 c100f8        	cp	a,_Pending_mqttserveraddr
6177  01fb 2717          	jreq	L5603
6178  01fd               L7603:
6179                     ; 1915       for (i=0; i<4; i++) stored_mqttserveraddr[i] = Pending_mqttserveraddr[i];
6181  01fd 4f            	clr	a
6182  01fe 6b01          	ld	(OFST+0,sp),a
6184  0200               L5703:
6187  0200 5f            	clrw	x
6188  0201 97            	ld	xl,a
6189  0202 d600f8        	ld	a,(_Pending_mqttserveraddr,x)
6190  0205 d70031        	ld	(_stored_mqttserveraddr,x),a
6193  0208 0c01          	inc	(OFST+0,sp)
6197  020a 7b01          	ld	a,(OFST+0,sp)
6198  020c a104          	cp	a,#4
6199  020e 25f0          	jrult	L5703
6200                     ; 1917       restart_request = 1;
6202  0210 350100a2      	mov	_restart_request,#1
6203  0214               L5603:
6204                     ; 1921     if (stored_mqttport != Pending_mqttport) {
6206  0214 ce002f        	ldw	x,_stored_mqttport
6207  0217 c300f6        	cpw	x,_Pending_mqttport
6208  021a 270f          	jreq	L3013
6209                     ; 1923       stored_mqttport = Pending_mqttport;
6211  021c ce00f6        	ldw	x,_Pending_mqttport
6212  021f 89            	pushw	x
6213  0220 ae002f        	ldw	x,#_stored_mqttport
6214  0223 cd0000        	call	c_eewrw
6216  0226 350100a2      	mov	_restart_request,#1
6217  022a 85            	popw	x
6218                     ; 1925       restart_request = 1;
6220  022b               L3013:
6221                     ; 1929     for(i=0; i<11; i++) {
6223  022b 4f            	clr	a
6224  022c 6b01          	ld	(OFST+0,sp),a
6226  022e               L5013:
6227                     ; 1930       if (stored_mqtt_username[i] != Pending_mqtt_username[i]) {
6229  022e 5f            	clrw	x
6230  022f 97            	ld	xl,a
6231  0230 905f          	clrw	y
6232  0232 9097          	ld	yl,a
6233  0234 90d60035      	ld	a,(_stored_mqtt_username,y)
6234  0238 d100eb        	cp	a,(_Pending_mqtt_username,x)
6235  023b 270e          	jreq	L3113
6236                     ; 1931         stored_mqtt_username[i] = Pending_mqtt_username[i];
6238  023d 7b01          	ld	a,(OFST+0,sp)
6239  023f 5f            	clrw	x
6240  0240 97            	ld	xl,a
6241  0241 d600eb        	ld	a,(_Pending_mqtt_username,x)
6242  0244 d70035        	ld	(_stored_mqtt_username,x),a
6243                     ; 1933         restart_request = 1;
6245  0247 350100a2      	mov	_restart_request,#1
6246  024b               L3113:
6247                     ; 1929     for(i=0; i<11; i++) {
6249  024b 0c01          	inc	(OFST+0,sp)
6253  024d 7b01          	ld	a,(OFST+0,sp)
6254  024f a10b          	cp	a,#11
6255  0251 25db          	jrult	L5013
6256                     ; 1938     for(i=0; i<11; i++) {
6258  0253 4f            	clr	a
6259  0254 6b01          	ld	(OFST+0,sp),a
6261  0256               L5113:
6262                     ; 1939       if (stored_mqtt_password[i] != Pending_mqtt_password[i]) {
6264  0256 5f            	clrw	x
6265  0257 97            	ld	xl,a
6266  0258 905f          	clrw	y
6267  025a 9097          	ld	yl,a
6268  025c 90d60040      	ld	a,(_stored_mqtt_password,y)
6269  0260 d100e0        	cp	a,(_Pending_mqtt_password,x)
6270  0263 270e          	jreq	L3213
6271                     ; 1940         stored_mqtt_password[i] = Pending_mqtt_password[i];
6273  0265 7b01          	ld	a,(OFST+0,sp)
6274  0267 5f            	clrw	x
6275  0268 97            	ld	xl,a
6276  0269 d600e0        	ld	a,(_Pending_mqtt_password,x)
6277  026c d70040        	ld	(_stored_mqtt_password,x),a
6278                     ; 1942         restart_request = 1;
6280  026f 350100a2      	mov	_restart_request,#1
6281  0273               L3213:
6282                     ; 1938     for(i=0; i<11; i++) {
6284  0273 0c01          	inc	(OFST+0,sp)
6288  0275 7b01          	ld	a,(OFST+0,sp)
6289  0277 a10b          	cp	a,#11
6290  0279 25db          	jrult	L5113
6291                     ; 1948     if (stored_uip_ethaddr_oct[0] != Pending_uip_ethaddr_oct[0] ||
6291                     ; 1949       stored_uip_ethaddr_oct[1] != Pending_uip_ethaddr_oct[1] ||
6291                     ; 1950       stored_uip_ethaddr_oct[2] != Pending_uip_ethaddr_oct[2] ||
6291                     ; 1951       stored_uip_ethaddr_oct[3] != Pending_uip_ethaddr_oct[3] ||
6291                     ; 1952       stored_uip_ethaddr_oct[4] != Pending_uip_ethaddr_oct[4] ||
6291                     ; 1953       stored_uip_ethaddr_oct[5] != Pending_uip_ethaddr_oct[5]) {
6293  027b c60017        	ld	a,_stored_uip_ethaddr_oct
6294  027e c100b2        	cp	a,_Pending_uip_ethaddr_oct
6295  0281 2628          	jrne	L7213
6297  0283 c60018        	ld	a,_stored_uip_ethaddr_oct+1
6298  0286 c100b3        	cp	a,_Pending_uip_ethaddr_oct+1
6299  0289 2620          	jrne	L7213
6301  028b c60019        	ld	a,_stored_uip_ethaddr_oct+2
6302  028e c100b4        	cp	a,_Pending_uip_ethaddr_oct+2
6303  0291 2618          	jrne	L7213
6305  0293 c6001a        	ld	a,_stored_uip_ethaddr_oct+3
6306  0296 c100b5        	cp	a,_Pending_uip_ethaddr_oct+3
6307  0299 2610          	jrne	L7213
6309  029b c6001b        	ld	a,_stored_uip_ethaddr_oct+4
6310  029e c100b6        	cp	a,_Pending_uip_ethaddr_oct+4
6311  02a1 2608          	jrne	L7213
6313  02a3 c6001c        	ld	a,_stored_uip_ethaddr_oct+5
6314  02a6 c100b7        	cp	a,_Pending_uip_ethaddr_oct+5
6315  02a9 271a          	jreq	L3572
6316  02ab               L7213:
6317                     ; 1955       for (i=0; i<6; i++) stored_uip_ethaddr_oct[i] = Pending_uip_ethaddr_oct[i];
6319  02ab 4f            	clr	a
6320  02ac 6b01          	ld	(OFST+0,sp),a
6322  02ae               L1413:
6325  02ae 5f            	clrw	x
6326  02af 97            	ld	xl,a
6327  02b0 d600b2        	ld	a,(_Pending_uip_ethaddr_oct,x)
6328  02b3 d70017        	ld	(_stored_uip_ethaddr_oct,x),a
6331  02b6 0c01          	inc	(OFST+0,sp)
6335  02b8 7b01          	ld	a,(OFST+0,sp)
6336  02ba a106          	cp	a,#6
6337  02bc 25f0          	jrult	L1413
6338                     ; 1957       update_mac_string();
6340  02be cd0000        	call	_update_mac_string
6342                     ; 1959       restart_request = 1;
6344  02c1 350100a2      	mov	_restart_request,#1
6345  02c5               L3572:
6346                     ; 1963   if (restart_request == 1) {
6348  02c5 c600a2        	ld	a,_restart_request
6349  02c8 4a            	dec	a
6350  02c9 2609          	jrne	L7413
6351                     ; 1966     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
6353  02cb c600a1        	ld	a,_restart_reboot_step
6354  02ce 2604          	jrne	L7413
6355                     ; 1967       restart_reboot_step = RESTART_REBOOT_ARM;
6357  02d0 350100a1      	mov	_restart_reboot_step,#1
6358  02d4               L7413:
6359                     ; 1971   if (user_reboot_request == 1) {
6361  02d4 c600a3        	ld	a,_user_reboot_request
6362  02d7 4a            	dec	a
6363  02d8 2611          	jrne	L3513
6364                     ; 1974     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
6366  02da 725d00a1      	tnz	_restart_reboot_step
6367  02de 260b          	jrne	L3513
6368                     ; 1975       restart_reboot_step = RESTART_REBOOT_ARM;
6370  02e0 350100a1      	mov	_restart_reboot_step,#1
6371                     ; 1976       user_reboot_request = 0;
6373  02e4 c700a3        	ld	_user_reboot_request,a
6374                     ; 1977       reboot_request = 1;
6376  02e7 350100a4      	mov	_reboot_request,#1
6377  02eb               L3513:
6378                     ; 1986   parse_complete = 0; // Reset parse_complete for future changes
6380  02eb 725f009f      	clr	_parse_complete
6381                     ; 1989   if (stack_limit1 != 0xaa || stack_limit2 != 0x55) {
6383  02ef c60001        	ld	a,_stack_limit1
6384  02f2 a1aa          	cp	a,#170
6385  02f4 2607          	jrne	L1613
6387  02f6 c60000        	ld	a,_stack_limit2
6388  02f9 a155          	cp	a,#85
6389  02fb 270a          	jreq	L7513
6390  02fd               L1613:
6391                     ; 1990     stack_error = 1;
6393  02fd 350100fc      	mov	_stack_error,#1
6394                     ; 1991     fastflash();
6396  0301 cd0000        	call	_fastflash
6398                     ; 1992     fastflash();
6400  0304 cd0000        	call	_fastflash
6402  0307               L7513:
6403                     ; 2005 }
6406  0307 84            	pop	a
6407  0308 81            	ret	
6442                     ; 2008 void check_restart_reboot(void)
6442                     ; 2009 {
6443                     .text:	section	.text,new
6444  0000               _check_restart_reboot:
6448                     ; 2015   if (restart_request == 1 || reboot_request == 1) {
6450  0000 c600a2        	ld	a,_restart_request
6451  0003 4a            	dec	a
6452  0004 2709          	jreq	L5713
6454  0006 c600a4        	ld	a,_reboot_request
6455  0009 4a            	dec	a
6456  000a 2703cc00d4    	jrne	L3713
6457  000f               L5713:
6458                     ; 2026     if (restart_reboot_step == RESTART_REBOOT_ARM) {
6460  000f c600a1        	ld	a,_restart_reboot_step
6461  0012 a101          	cp	a,#1
6462  0014 2611          	jrne	L7713
6463                     ; 2031       time_mark2 = second_counter;
6465  0016 ce0002        	ldw	x,_second_counter+2
6466  0019 cf0096        	ldw	_time_mark2+2,x
6467  001c ce0000        	ldw	x,_second_counter
6468  001f cf0094        	ldw	_time_mark2,x
6469                     ; 2032       restart_reboot_step = RESTART_REBOOT_ARM2;
6471  0022 350200a1      	mov	_restart_reboot_step,#2
6474  0026 81            	ret	
6475  0027               L7713:
6476                     ; 2035     else if (restart_reboot_step == RESTART_REBOOT_ARM2) {
6478  0027 a102          	cp	a,#2
6479  0029 2613          	jrne	L3023
6480                     ; 2041       if (second_counter > time_mark2 + 0 ) {
6482  002b ae0000        	ldw	x,#_second_counter
6483  002e cd0000        	call	c_ltor
6485  0031 ae0094        	ldw	x,#_time_mark2
6486  0034 cd0000        	call	c_lcmp
6488  0037 23d3          	jrule	L3713
6489                     ; 2042         restart_reboot_step = RESTART_REBOOT_DISCONNECT;
6491  0039 350300a1      	mov	_restart_reboot_step,#3
6493  003d 81            	ret	
6494  003e               L3023:
6495                     ; 2047     else if (restart_reboot_step == RESTART_REBOOT_DISCONNECT) {
6497  003e a103          	cp	a,#3
6498  0040 261e          	jrne	L1123
6499                     ; 2048       restart_reboot_step = RESTART_REBOOT_DISCONNECTWAIT;
6501  0042 350400a1      	mov	_restart_reboot_step,#4
6502                     ; 2049       if (mqtt_start == MQTT_START_COMPLETE) {
6504  0046 c60041        	ld	a,_mqtt_start
6505  0049 a114          	cp	a,#20
6506  004b 2606          	jrne	L3123
6507                     ; 2051         mqtt_disconnect(&mqttclient);
6509  004d ae005e        	ldw	x,#_mqttclient
6510  0050 cd0000        	call	_mqtt_disconnect
6512  0053               L3123:
6513                     ; 2054       time_mark2 = second_counter;
6515  0053 ce0002        	ldw	x,_second_counter+2
6516  0056 cf0096        	ldw	_time_mark2+2,x
6517  0059 ce0000        	ldw	x,_second_counter
6518  005c cf0094        	ldw	_time_mark2,x
6521  005f 81            	ret	
6522  0060               L1123:
6523                     ; 2057     else if (restart_reboot_step == RESTART_REBOOT_DISCONNECTWAIT) {
6525  0060 a104          	cp	a,#4
6526  0062 2618          	jrne	L7123
6527                     ; 2058       if (second_counter > time_mark2 + 1 ) {
6529  0064 ae0094        	ldw	x,#_time_mark2
6530  0067 cd0000        	call	c_ltor
6532  006a a601          	ld	a,#1
6533  006c cd0000        	call	c_ladc
6535  006f ae0000        	ldw	x,#_second_counter
6536  0072 cd0000        	call	c_lcmp
6538  0075 245d          	jruge	L3713
6539                     ; 2061         restart_reboot_step = RESTART_REBOOT_TCPCLOSE;
6541  0077 350500a1      	mov	_restart_reboot_step,#5
6543  007b 81            	ret	
6544  007c               L7123:
6545                     ; 2065     else if (restart_reboot_step == RESTART_REBOOT_TCPCLOSE) {
6547  007c a105          	cp	a,#5
6548  007e 2615          	jrne	L5223
6549                     ; 2081       mqtt_close_tcp = 1;
6551  0080 350100a0      	mov	_mqtt_close_tcp,#1
6552                     ; 2083       time_mark2 = second_counter;
6554  0084 ce0002        	ldw	x,_second_counter+2
6555  0087 cf0096        	ldw	_time_mark2+2,x
6556  008a ce0000        	ldw	x,_second_counter
6557  008d cf0094        	ldw	_time_mark2,x
6558                     ; 2084       restart_reboot_step = RESTART_REBOOT_TCPWAIT;
6560  0090 350600a1      	mov	_restart_reboot_step,#6
6563  0094 81            	ret	
6564  0095               L5223:
6565                     ; 2086     else if (restart_reboot_step == RESTART_REBOOT_TCPWAIT) {
6567  0095 a106          	cp	a,#6
6568  0097 261c          	jrne	L1323
6569                     ; 2091       if (second_counter > time_mark2 + 1) {
6571  0099 ae0094        	ldw	x,#_time_mark2
6572  009c cd0000        	call	c_ltor
6574  009f a601          	ld	a,#1
6575  00a1 cd0000        	call	c_ladc
6577  00a4 ae0000        	ldw	x,#_second_counter
6578  00a7 cd0000        	call	c_lcmp
6580  00aa 2428          	jruge	L3713
6581                     ; 2092 	mqtt_close_tcp = 0;
6583  00ac 725f00a0      	clr	_mqtt_close_tcp
6584                     ; 2093         restart_reboot_step = RESTART_REBOOT_FINISH;
6586  00b0 350700a1      	mov	_restart_reboot_step,#7
6588  00b4 81            	ret	
6589  00b5               L1323:
6590                     ; 2103     else if (restart_reboot_step == RESTART_REBOOT_FINISH) {
6592  00b5 a107          	cp	a,#7
6593  00b7 261b          	jrne	L3713
6594                     ; 2104       if (reboot_request == 1) {
6596  00b9 c600a4        	ld	a,_reboot_request
6597  00bc 4a            	dec	a
6598  00bd 2606          	jrne	L1423
6599                     ; 2105         restart_reboot_step = RESTART_REBOOT_IDLE;
6601  00bf c700a1        	ld	_restart_reboot_step,a
6602                     ; 2107         reboot();
6604  00c2 cd0000        	call	_reboot
6606  00c5               L1423:
6607                     ; 2109       if (restart_request == 1) {
6609  00c5 c600a2        	ld	a,_restart_request
6610  00c8 4a            	dec	a
6611  00c9 2609          	jrne	L3713
6612                     ; 2110 	restart_request = 0;
6614  00cb c700a2        	ld	_restart_request,a
6615                     ; 2111         restart_reboot_step = RESTART_REBOOT_IDLE;
6617  00ce c700a1        	ld	_restart_reboot_step,a
6618                     ; 2113 	restart();
6620  00d1 cd0000        	call	_restart
6622  00d4               L3713:
6623                     ; 2117 }
6626  00d4 81            	ret	
6679                     ; 2120 void restart(void)
6679                     ; 2121 {
6680                     .text:	section	.text,new
6681  0000               _restart:
6685                     ; 2135   LEDcontrol(0); // Turn LED off
6687  0000 4f            	clr	a
6688  0001 cd0000        	call	_LEDcontrol
6690                     ; 2137   parse_complete = 0;
6692  0004 725f009f      	clr	_parse_complete
6693                     ; 2138   reboot_request = 0;
6695  0008 725f00a4      	clr	_reboot_request
6696                     ; 2139   restart_request = 0;
6698  000c 725f00a2      	clr	_restart_request
6699                     ; 2141   time_mark2 = 0;           // Time capture used in reboot
6701  0010 5f            	clrw	x
6702  0011 cf0096        	ldw	_time_mark2+2,x
6703  0014 cf0094        	ldw	_time_mark2,x
6704                     ; 2144   mqtt_close_tcp = 0;
6706  0017 725f00a0      	clr	_mqtt_close_tcp
6707                     ; 2146   mqtt_start = MQTT_START_TCP_CONNECT;
6709  001b 35010041      	mov	_mqtt_start,#1
6710                     ; 2147   mqtt_start_status = MQTT_START_NOT_STARTED;
6712  001f 725f0040      	clr	_mqtt_start_status
6713                     ; 2148   mqtt_start_ctr1 = 0;
6715  0023 725f003f      	clr	_mqtt_start_ctr1
6716                     ; 2149   mqtt_sanity_ctr = 0;
6718  0027 725f003d      	clr	_mqtt_sanity_ctr
6719                     ; 2150   mqtt_start_retry = 0;
6721  002b 725f003c      	clr	_mqtt_start_retry
6722                     ; 2151   MQTT_error_status = 0;
6724  002f 725f0000      	clr	_MQTT_error_status
6725                     ; 2152   mqtt_restart_step = MQTT_RESTART_IDLE;
6727  0033 725f0039      	clr	_mqtt_restart_step
6728                     ; 2153   strcpy(topic_base, devicetype);
6730  0037 ae000d        	ldw	x,#_topic_base
6731  003a 90ae0000      	ldw	y,#L5261_devicetype
6732  003e               L433:
6733  003e 90f6          	ld	a,(y)
6734  0040 905c          	incw	y
6735  0042 f7            	ld	(x),a
6736  0043 5c            	incw	x
6737  0044 4d            	tnz	a
6738  0045 26f7          	jrne	L433
6739                     ; 2154   state_request = STATE_REQUEST_IDLE;
6741  0047 c700fd        	ld	_state_request,a
6742                     ; 2157   spi_init();              // Initialize the SPI bit bang interface to the
6744  004a cd0000        	call	_spi_init
6746                     ; 2159   unlock_eeprom();         // unlock the EEPROM so writes can be performed
6748  004d cd0000        	call	_unlock_eeprom
6750                     ; 2160   check_eeprom_settings(); // Verify EEPROM up to date
6752  0050 cd0000        	call	_check_eeprom_settings
6754                     ; 2161   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
6756  0053 cd0000        	call	_Enc28j60Init
6758                     ; 2162   uip_arp_init();          // Initialize the ARP module
6760  0056 cd0000        	call	_uip_arp_init
6762                     ; 2163   uip_init();              // Initialize uIP
6764  0059 cd0000        	call	_uip_init
6766                     ; 2164   HttpDInit();             // Initialize httpd; sets up listening ports
6768  005c cd0000        	call	_HttpDInit
6770                     ; 2168   mqtt_init(&mqttclient,
6770                     ; 2169             mqtt_sendbuf,
6770                     ; 2170 	    sizeof(mqtt_sendbuf),
6770                     ; 2171 	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
6770                     ; 2172 	    UIP_APPDATA_SIZE,
6770                     ; 2173 	    publish_callback);
6772  005f ae0000        	ldw	x,#_publish_callback
6773  0062 89            	pushw	x
6774  0063 ae01be        	ldw	x,#446
6775  0066 89            	pushw	x
6776  0067 ae0036        	ldw	x,#_uip_buf+54
6777  006a 89            	pushw	x
6778  006b ae00c8        	ldw	x,#200
6779  006e 89            	pushw	x
6780  006f ae0000        	ldw	x,#_mqtt_sendbuf
6781  0072 89            	pushw	x
6782  0073 ae005e        	ldw	x,#_mqttclient
6783  0076 cd0000        	call	_mqtt_init
6785  0079 5b0a          	addw	sp,#10
6786                     ; 2176   LEDcontrol(1); // Turn LED on
6788  007b a601          	ld	a,#1
6790                     ; 2179 }
6793  007d cc0000        	jp	_LEDcontrol
6821                     ; 2182 void reboot(void)
6821                     ; 2183 {
6822                     .text:	section	.text,new
6823  0000               _reboot:
6827                     ; 2186   fastflash(); // A useful signal that a deliberate reboot is occurring.
6829  0000 cd0000        	call	_fastflash
6831                     ; 2188   LEDcontrol(0);  // turn LED off
6833  0003 4f            	clr	a
6834  0004 cd0000        	call	_LEDcontrol
6836                     ; 2190   WWDG_WR = (uint8_t)0x7f;     // Window register reset
6838  0007 357f50d2      	mov	_WWDG_WR,#127
6839                     ; 2191   WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
6841  000b 35ff50d1      	mov	_WWDG_CR,#255
6842                     ; 2192   WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
6844  000f 356050d2      	mov	_WWDG_WR,#96
6845                     ; 2195   wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
6847  0013 aec350        	ldw	x,#50000
6848  0016 cd0000        	call	_wait_timer
6850                     ; 2196   wait_timer((uint16_t)50000);
6852  0019 aec350        	ldw	x,#50000
6853  001c cd0000        	call	_wait_timer
6855                     ; 2197   wait_timer((uint16_t)50000);
6857  001f aec350        	ldw	x,#50000
6859                     ; 2198 }
6862  0022 cc0000        	jp	_wait_timer
6903                     ; 2201 void read_input_registers(void)
6903                     ; 2202 {
6904                     .text:	section	.text,new
6905  0000               _read_input_registers:
6907  0000 89            	pushw	x
6908       00000002      OFST:	set	2
6911                     ; 2219   if (PC_IDR & (uint8_t)0x40) IO_16to9_new1 |= 0x80; // PC bit 6 = 1, Input 8 = 1
6913  0001 720d500b06    	btjf	_PC_IDR,#6,L1033
6916  0006 721e0105      	bset	_IO_16to9_new1,#7
6918  000a 2004          	jra	L3033
6919  000c               L1033:
6920                     ; 2220   else IO_16to9_new1 &= (uint8_t)(~0x80);
6922  000c 721f0105      	bres	_IO_16to9_new1,#7
6923  0010               L3033:
6924                     ; 2221   if (PG_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x40; // PG bit 0 = 1, Input 7 = 1
6926  0010 7201501f06    	btjf	_PG_IDR,#0,L5033
6929  0015 721c0105      	bset	_IO_16to9_new1,#6
6931  0019 2004          	jra	L7033
6932  001b               L5033:
6933                     ; 2222   else IO_16to9_new1 &= (uint8_t)(~0x40);
6935  001b 721d0105      	bres	_IO_16to9_new1,#6
6936  001f               L7033:
6937                     ; 2223   if (PE_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x20; // PE bit 3 = 1, Input 6 = 1
6939  001f 7207501506    	btjf	_PE_IDR,#3,L1133
6942  0024 721a0105      	bset	_IO_16to9_new1,#5
6944  0028 2004          	jra	L3133
6945  002a               L1133:
6946                     ; 2224   else IO_16to9_new1 &= (uint8_t)(~0x20);
6948  002a 721b0105      	bres	_IO_16to9_new1,#5
6949  002e               L3133:
6950                     ; 2225   if (PD_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x10; // PD bit 0 = 1, Input 5 = 1
6952  002e 7201501006    	btjf	_PD_IDR,#0,L5133
6955  0033 72180105      	bset	_IO_16to9_new1,#4
6957  0037 2004          	jra	L7133
6958  0039               L5133:
6959                     ; 2226   else IO_16to9_new1 &= (uint8_t)(~0x10);
6961  0039 72190105      	bres	_IO_16to9_new1,#4
6962  003d               L7133:
6963                     ; 2227   if (PD_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x08; // PD bit 3 = 1, Input 4 = 1
6965  003d 7207501006    	btjf	_PD_IDR,#3,L1233
6968  0042 72160105      	bset	_IO_16to9_new1,#3
6970  0046 2004          	jra	L3233
6971  0048               L1233:
6972                     ; 2228   else IO_16to9_new1 &= (uint8_t)(~0x08);
6974  0048 72170105      	bres	_IO_16to9_new1,#3
6975  004c               L3233:
6976                     ; 2229   if (PD_IDR & (uint8_t)0x20) IO_16to9_new1 |= 0x04; // PD bit 5 = 1, Input 3 = 1
6978  004c 720b501006    	btjf	_PD_IDR,#5,L5233
6981  0051 72140105      	bset	_IO_16to9_new1,#2
6983  0055 2004          	jra	L7233
6984  0057               L5233:
6985                     ; 2230   else IO_16to9_new1 &= (uint8_t)(~0x04);
6987  0057 72150105      	bres	_IO_16to9_new1,#2
6988  005b               L7233:
6989                     ; 2231   if (PD_IDR & (uint8_t)0x80) IO_16to9_new1 |= 0x02; // PD bit 7 = 1, Input 2 = 1
6991  005b 720f501006    	btjf	_PD_IDR,#7,L1333
6994  0060 72120105      	bset	_IO_16to9_new1,#1
6996  0064 2004          	jra	L3333
6997  0066               L1333:
6998                     ; 2232   else IO_16to9_new1 &= (uint8_t)(~0x02);
7000  0066 72130105      	bres	_IO_16to9_new1,#1
7001  006a               L3333:
7002                     ; 2233   if (PA_IDR & (uint8_t)0x10) IO_16to9_new1 |= 0x01; // PA bit 4 = 1, Input 1 = 1
7004  006a 7209500106    	btjf	_PA_IDR,#4,L5333
7007  006f 72100105      	bset	_IO_16to9_new1,#0
7009  0073 2004          	jra	L7333
7010  0075               L5333:
7011                     ; 2234   else IO_16to9_new1 &= (uint8_t)(~0x01);
7013  0075 72110105      	bres	_IO_16to9_new1,#0
7014  0079               L7333:
7015                     ; 2239   xor_tmp = (uint8_t)((IO_16to9 ^ IO_16to9_new1) & (IO_16to9 ^ IO_16to9_new2));
7017  0079 c60107        	ld	a,_IO_16to9
7018  007c c80103        	xor	a,_IO_16to9_new2
7019  007f 6b01          	ld	(OFST-1,sp),a
7021  0081 c60107        	ld	a,_IO_16to9
7022  0084 c80105        	xor	a,_IO_16to9_new1
7023  0087 1401          	and	a,(OFST-1,sp)
7024  0089 6b02          	ld	(OFST+0,sp),a
7026                     ; 2240   IO_16to9 = (uint8_t)(IO_16to9 ^ xor_tmp);
7028  008b c80107        	xor	a,_IO_16to9
7029  008e c70107        	ld	_IO_16to9,a
7030                     ; 2242   IO_16to9_new2 = IO_16to9_new1;
7032                     ; 2296 }
7035  0091 85            	popw	x
7036  0092 5501050103    	mov	_IO_16to9_new2,_IO_16to9_new1
7037  0097 81            	ret	
7077                     ; 2299 void write_output_registers(void)
7077                     ; 2300 {
7078                     .text:	section	.text,new
7079  0000               _write_output_registers:
7081  0000 88            	push	a
7082       00000001      OFST:	set	1
7085                     ; 2354   xor_tmp = (uint8_t)(invert_output ^ IO_8to1);
7087  0001 c600ff        	ld	a,_invert_output
7088  0004 c80106        	xor	a,_IO_8to1
7089  0007 6b01          	ld	(OFST+0,sp),a
7091                     ; 2355   if (xor_tmp & 0x80) PC_ODR |= (uint8_t)0x80; // Relay 8 off
7093  0009 2a06          	jrpl	L5533
7096  000b 721e500a      	bset	_PC_ODR,#7
7098  000f 2004          	jra	L7533
7099  0011               L5533:
7100                     ; 2356   else PC_ODR &= (uint8_t)~0x80; // Relay 8 on
7102  0011 721f500a      	bres	_PC_ODR,#7
7103  0015               L7533:
7104                     ; 2357   if (xor_tmp & 0x40) PG_ODR |= (uint8_t)0x02; // Relay 7 off
7106  0015 a540          	bcp	a,#64
7107  0017 2706          	jreq	L1633
7110  0019 7212501e      	bset	_PG_ODR,#1
7112  001d 2004          	jra	L3633
7113  001f               L1633:
7114                     ; 2358   else PG_ODR &= (uint8_t)~0x02; // Relay 7 on
7116  001f 7213501e      	bres	_PG_ODR,#1
7117  0023               L3633:
7118                     ; 2359   if (xor_tmp & 0x20) PE_ODR |= (uint8_t)0x01; // Relay 6 off
7120  0023 7b01          	ld	a,(OFST+0,sp)
7121  0025 a520          	bcp	a,#32
7122  0027 2706          	jreq	L5633
7125  0029 72105014      	bset	_PE_ODR,#0
7127  002d 2004          	jra	L7633
7128  002f               L5633:
7129                     ; 2360   else PE_ODR &= (uint8_t)~0x01; // Relay 6 on
7131  002f 72115014      	bres	_PE_ODR,#0
7132  0033               L7633:
7133                     ; 2361   if (xor_tmp & 0x10) PD_ODR |= (uint8_t)0x04; // Relay 5 off
7135  0033 a510          	bcp	a,#16
7136  0035 2706          	jreq	L1733
7139  0037 7214500f      	bset	_PD_ODR,#2
7141  003b 2004          	jra	L3733
7142  003d               L1733:
7143                     ; 2362   else PD_ODR &= (uint8_t)~0x04; // Relay 5 on
7145  003d 7215500f      	bres	_PD_ODR,#2
7146  0041               L3733:
7147                     ; 2363   if (xor_tmp & 0x08) PD_ODR |= (uint8_t)0x10; // Relay 4 off
7149  0041 7b01          	ld	a,(OFST+0,sp)
7150  0043 a508          	bcp	a,#8
7151  0045 2706          	jreq	L5733
7154  0047 7218500f      	bset	_PD_ODR,#4
7156  004b 2004          	jra	L7733
7157  004d               L5733:
7158                     ; 2364   else PD_ODR &= (uint8_t)~0x10; // Relay 4 on
7160  004d 7219500f      	bres	_PD_ODR,#4
7161  0051               L7733:
7162                     ; 2365   if (xor_tmp & 0x04) PD_ODR |= (uint8_t)0x40; // Relay 3 off
7164  0051 a504          	bcp	a,#4
7165  0053 2706          	jreq	L1043
7168  0055 721c500f      	bset	_PD_ODR,#6
7170  0059 2004          	jra	L3043
7171  005b               L1043:
7172                     ; 2366   else PD_ODR &= (uint8_t)~0x40; // Relay 3 on
7174  005b 721d500f      	bres	_PD_ODR,#6
7175  005f               L3043:
7176                     ; 2367   if (xor_tmp & 0x02) PA_ODR |= (uint8_t)0x20; // Relay 2 off
7178  005f 7b01          	ld	a,(OFST+0,sp)
7179  0061 a502          	bcp	a,#2
7180  0063 2706          	jreq	L5043
7183  0065 721a5000      	bset	_PA_ODR,#5
7185  0069 2004          	jra	L7043
7186  006b               L5043:
7187                     ; 2368   else PA_ODR &= (uint8_t)~0x20; // Relay 2 on
7189  006b 721b5000      	bres	_PA_ODR,#5
7190  006f               L7043:
7191                     ; 2369   if (xor_tmp & 0x01) PA_ODR |= (uint8_t)0x08; // Relay 1 off
7193  006f a501          	bcp	a,#1
7194  0071 2706          	jreq	L1143
7197  0073 72165000      	bset	_PA_ODR,#3
7199  0077 2004          	jra	L3143
7200  0079               L1143:
7201                     ; 2370   else PA_ODR &= (uint8_t)~0x08; // Relay 1 on
7203  0079 72175000      	bres	_PA_ODR,#3
7204  007d               L3143:
7205                     ; 2376 }
7208  007d 84            	pop	a
7209  007e 81            	ret	
7250                     ; 2379 void check_reset_button(void)
7250                     ; 2380 {
7251                     .text:	section	.text,new
7252  0000               _check_reset_button:
7254  0000 88            	push	a
7255       00000001      OFST:	set	1
7258                     ; 2385   if ((PA_IDR & 0x02) == 0) {
7260  0001 720250015d    	btjt	_PA_IDR,#1,L1343
7261                     ; 2387     for (i=0; i<100; i++) {
7263  0006 0f01          	clr	(OFST+0,sp)
7265  0008               L3343:
7266                     ; 2388       wait_timer(50000); // wait 50ms
7268  0008 aec350        	ldw	x,#50000
7269  000b cd0000        	call	_wait_timer
7271                     ; 2389       if ((PA_IDR & 0x02) == 1) { // check Reset Button again. If released
7273  000e c65001        	ld	a,_PA_IDR
7274  0011 a402          	and	a,#2
7275  0013 4a            	dec	a
7276  0014 2602          	jrne	L1443
7277                     ; 2391         return;
7280  0016 84            	pop	a
7281  0017 81            	ret	
7282  0018               L1443:
7283                     ; 2387     for (i=0; i<100; i++) {
7285  0018 0c01          	inc	(OFST+0,sp)
7289  001a 7b01          	ld	a,(OFST+0,sp)
7290  001c a164          	cp	a,#100
7291  001e 25e8          	jrult	L3343
7292                     ; 2396     LEDcontrol(0);  // turn LED off
7294  0020 4f            	clr	a
7295  0021 cd0000        	call	_LEDcontrol
7298  0024               L5443:
7299                     ; 2397     while((PA_IDR & 0x02) == 0) {  // Wait for button release
7301  0024 72035001fb    	btjf	_PA_IDR,#1,L5443
7302                     ; 2400     magic4 = 0x00;
7304  0029 4f            	clr	a
7305  002a ae002e        	ldw	x,#_magic4
7306  002d cd0000        	call	c_eewrc
7308                     ; 2401     magic3 = 0x00;
7310  0030 4f            	clr	a
7311  0031 ae002d        	ldw	x,#_magic3
7312  0034 cd0000        	call	c_eewrc
7314                     ; 2402     magic2 = 0x00;
7316  0037 4f            	clr	a
7317  0038 ae002c        	ldw	x,#_magic2
7318  003b cd0000        	call	c_eewrc
7320                     ; 2403     magic1 = 0x00;
7322  003e 4f            	clr	a
7323  003f ae002b        	ldw	x,#_magic1
7324  0042 cd0000        	call	c_eewrc
7326                     ; 2405     WWDG_WR = (uint8_t)0x7f;       // Window register reset
7328  0045 357f50d2      	mov	_WWDG_WR,#127
7329                     ; 2406     WWDG_CR = (uint8_t)0xff;       // Set watchdog to timeout in 49ms
7331  0049 35ff50d1      	mov	_WWDG_CR,#255
7332                     ; 2407     WWDG_WR = (uint8_t)0x60;       // Window register value - doesn't matter
7334  004d 356050d2      	mov	_WWDG_WR,#96
7335                     ; 2410     wait_timer((uint16_t)50000);   // Wait for watchdog to generate reset
7337  0051 aec350        	ldw	x,#50000
7338  0054 cd0000        	call	_wait_timer
7340                     ; 2411     wait_timer((uint16_t)50000);
7342  0057 aec350        	ldw	x,#50000
7343  005a cd0000        	call	_wait_timer
7345                     ; 2412     wait_timer((uint16_t)50000);
7347  005d aec350        	ldw	x,#50000
7348  0060 cd0000        	call	_wait_timer
7350  0063               L1343:
7351                     ; 2414 }
7354  0063 84            	pop	a
7355  0064 81            	ret	
7389                     ; 2417 void debugflash(void)
7389                     ; 2418 {
7390                     .text:	section	.text,new
7391  0000               _debugflash:
7393  0000 88            	push	a
7394       00000001      OFST:	set	1
7397                     ; 2433   LEDcontrol(0);     // turn LED off
7399  0001 4f            	clr	a
7400  0002 cd0000        	call	_LEDcontrol
7402                     ; 2434   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
7404  0005 0f01          	clr	(OFST+0,sp)
7406  0007               L5643:
7409  0007 aec350        	ldw	x,#50000
7410  000a cd0000        	call	_wait_timer
7414  000d 0c01          	inc	(OFST+0,sp)
7418  000f 7b01          	ld	a,(OFST+0,sp)
7419  0011 a10a          	cp	a,#10
7420  0013 25f2          	jrult	L5643
7421                     ; 2436   LEDcontrol(1);     // turn LED on
7423  0015 a601          	ld	a,#1
7424  0017 cd0000        	call	_LEDcontrol
7426                     ; 2437   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
7428  001a 0f01          	clr	(OFST+0,sp)
7430  001c               L3743:
7433  001c aec350        	ldw	x,#50000
7434  001f cd0000        	call	_wait_timer
7438  0022 0c01          	inc	(OFST+0,sp)
7442  0024 7b01          	ld	a,(OFST+0,sp)
7443  0026 a10a          	cp	a,#10
7444  0028 25f2          	jrult	L3743
7445                     ; 2438 }
7448  002a 84            	pop	a
7449  002b 81            	ret	
7483                     ; 2441 void fastflash(void)
7483                     ; 2442 {
7484                     .text:	section	.text,new
7485  0000               _fastflash:
7487  0000 88            	push	a
7488       00000001      OFST:	set	1
7491                     ; 2457   for (i=0; i<10; i++) {
7493  0001 0f01          	clr	(OFST+0,sp)
7495  0003               L5153:
7496                     ; 2458     LEDcontrol(0);     // turn LED off
7498  0003 4f            	clr	a
7499  0004 cd0000        	call	_LEDcontrol
7501                     ; 2459     wait_timer((uint16_t)50000); // wait 50ms
7503  0007 aec350        	ldw	x,#50000
7504  000a cd0000        	call	_wait_timer
7506                     ; 2461     LEDcontrol(1);     // turn LED on
7508  000d a601          	ld	a,#1
7509  000f cd0000        	call	_LEDcontrol
7511                     ; 2462     wait_timer((uint16_t)50000); // wait 50ms
7513  0012 aec350        	ldw	x,#50000
7514  0015 cd0000        	call	_wait_timer
7516                     ; 2457   for (i=0; i<10; i++) {
7518  0018 0c01          	inc	(OFST+0,sp)
7522  001a 7b01          	ld	a,(OFST+0,sp)
7523  001c a10a          	cp	a,#10
7524  001e 25e3          	jrult	L5153
7525                     ; 2464 }
7528  0020 84            	pop	a
7529  0021 81            	ret	
7554                     ; 2467 void oneflash(void)
7554                     ; 2468 {
7555                     .text:	section	.text,new
7556  0000               _oneflash:
7560                     ; 2483   LEDcontrol(0);     // turn LED off
7562  0000 4f            	clr	a
7563  0001 cd0000        	call	_LEDcontrol
7565                     ; 2484   wait_timer((uint16_t)25000); // wait 25ms
7567  0004 ae61a8        	ldw	x,#25000
7568  0007 cd0000        	call	_wait_timer
7570                     ; 2486   LEDcontrol(1);     // turn LED on
7572  000a a601          	ld	a,#1
7574                     ; 2487 }
7577  000c cc0000        	jp	_LEDcontrol
8905                     	switch	.bss
8906  0000               _TRANSMIT_counter:
8907  0000 00000000      	ds.b	4
8908                     	xdef	_TRANSMIT_counter
8909  0004               _TXERIF_counter:
8910  0004 00000000      	ds.b	4
8911                     	xdef	_TXERIF_counter
8912  0008               _RXERIF_counter:
8913  0008 00000000      	ds.b	4
8914                     	xdef	_RXERIF_counter
8915  000c               _topic_base_len:
8916  000c 00            	ds.b	1
8917                     	xdef	_topic_base_len
8918  000d               _topic_base:
8919  000d 000000000000  	ds.b	44
8920                     	xdef	_topic_base
8921  0039               _mqtt_restart_step:
8922  0039 00            	ds.b	1
8923                     	xdef	_mqtt_restart_step
8924                     	xref	_MQTT_error_status
8925  003a               _mqtt_conn:
8926  003a 0000          	ds.b	2
8927                     	xdef	_mqtt_conn
8928                     	xref	_mqtt_sendbuf
8929  003c               _mqtt_start_retry:
8930  003c 00            	ds.b	1
8931                     	xdef	_mqtt_start_retry
8932  003d               _mqtt_sanity_ctr:
8933  003d 00            	ds.b	1
8934                     	xdef	_mqtt_sanity_ctr
8935  003e               _mqtt_start_ctr2:
8936  003e 00            	ds.b	1
8937                     	xdef	_mqtt_start_ctr2
8938  003f               _mqtt_start_ctr1:
8939  003f 00            	ds.b	1
8940                     	xdef	_mqtt_start_ctr1
8941  0040               _mqtt_start_status:
8942  0040 00            	ds.b	1
8943                     	xdef	_mqtt_start_status
8944  0041               _mqtt_start:
8945  0041 00            	ds.b	1
8946                     	xdef	_mqtt_start
8947  0042               _client_id_text:
8948  0042 000000000000  	ds.b	26
8949                     	xdef	_client_id_text
8950  005c               _client_id:
8951  005c 0000          	ds.b	2
8952                     	xdef	_client_id
8953  005e               _mqttclient:
8954  005e 000000000000  	ds.b	44
8955                     	xdef	_mqttclient
8956  008a               _mqtt_keep_alive:
8957  008a 0000          	ds.b	2
8958                     	xdef	_mqtt_keep_alive
8959  008c               _application_message:
8960  008c 000000        	ds.b	3
8961                     	xdef	_application_message
8962  008f               _Port_Mqttd:
8963  008f 0000          	ds.b	2
8964                     	xdef	_Port_Mqttd
8965  0091               _mqttport:
8966  0091 0000          	ds.b	2
8967                     	xdef	_mqttport
8968  0093               _connect_flags:
8969  0093 00            	ds.b	1
8970                     	xdef	_connect_flags
8971                     	xref	_OctetArray
8972                     	xref	_second_counter
8973  0094               _time_mark2:
8974  0094 00000000      	ds.b	4
8975                     	xdef	_time_mark2
8976  0098               _IpAddr:
8977  0098 00000000      	ds.b	4
8978                     	xdef	_IpAddr
8979  009c               _Port_Httpd:
8980  009c 0000          	ds.b	2
8981                     	xdef	_Port_Httpd
8982  009e               _mqtt_parse_complete:
8983  009e 00            	ds.b	1
8984                     	xdef	_mqtt_parse_complete
8985  009f               _parse_complete:
8986  009f 00            	ds.b	1
8987                     	xdef	_parse_complete
8988  00a0               _mqtt_close_tcp:
8989  00a0 00            	ds.b	1
8990                     	xdef	_mqtt_close_tcp
8991  00a1               _restart_reboot_step:
8992  00a1 00            	ds.b	1
8993                     	xdef	_restart_reboot_step
8994  00a2               _restart_request:
8995  00a2 00            	ds.b	1
8996                     	xdef	_restart_request
8997  00a3               _user_reboot_request:
8998  00a3 00            	ds.b	1
8999                     	xdef	_user_reboot_request
9000  00a4               _reboot_request:
9001  00a4 00            	ds.b	1
9002                     	xdef	_reboot_request
9003  00a5               _mac_string:
9004  00a5 000000000000  	ds.b	13
9005                     	xdef	_mac_string
9006  00b2               _Pending_uip_ethaddr_oct:
9007  00b2 000000000000  	ds.b	6
9008                     	xdef	_Pending_uip_ethaddr_oct
9009  00b8               _Pending_config_settings:
9010  00b8 000000000000  	ds.b	6
9011                     	xdef	_Pending_config_settings
9012  00be               _Pending_devicename:
9013  00be 000000000000  	ds.b	20
9014                     	xdef	_Pending_devicename
9015  00d2               _Pending_port:
9016  00d2 0000          	ds.b	2
9017                     	xdef	_Pending_port
9018  00d4               _Pending_netmask:
9019  00d4 00000000      	ds.b	4
9020                     	xdef	_Pending_netmask
9021  00d8               _Pending_draddr:
9022  00d8 00000000      	ds.b	4
9023                     	xdef	_Pending_draddr
9024  00dc               _Pending_hostaddr:
9025  00dc 00000000      	ds.b	4
9026                     	xdef	_Pending_hostaddr
9027  00e0               _Pending_mqtt_password:
9028  00e0 000000000000  	ds.b	11
9029                     	xdef	_Pending_mqtt_password
9030  00eb               _Pending_mqtt_username:
9031  00eb 000000000000  	ds.b	11
9032                     	xdef	_Pending_mqtt_username
9033  00f6               _Pending_mqttport:
9034  00f6 0000          	ds.b	2
9035                     	xdef	_Pending_mqttport
9036  00f8               _Pending_mqttserveraddr:
9037  00f8 00000000      	ds.b	4
9038                     	xdef	_Pending_mqttserveraddr
9039  00fc               _stack_error:
9040  00fc 00            	ds.b	1
9041                     	xdef	_stack_error
9042  00fd               _state_request:
9043  00fd 00            	ds.b	1
9044                     	xdef	_state_request
9045  00fe               _invert_input:
9046  00fe 00            	ds.b	1
9047                     	xdef	_invert_input
9048  00ff               _invert_output:
9049  00ff 00            	ds.b	1
9050                     	xdef	_invert_output
9051  0100               _IO_8to1_sent:
9052  0100 00            	ds.b	1
9053                     	xdef	_IO_8to1_sent
9054  0101               _IO_16to9_sent:
9055  0101 00            	ds.b	1
9056                     	xdef	_IO_16to9_sent
9057  0102               _IO_8to1_new2:
9058  0102 00            	ds.b	1
9059                     	xdef	_IO_8to1_new2
9060  0103               _IO_16to9_new2:
9061  0103 00            	ds.b	1
9062                     	xdef	_IO_16to9_new2
9063  0104               _IO_8to1_new1:
9064  0104 00            	ds.b	1
9065                     	xdef	_IO_8to1_new1
9066  0105               _IO_16to9_new1:
9067  0105 00            	ds.b	1
9068                     	xdef	_IO_16to9_new1
9069  0106               _IO_8to1:
9070  0106 00            	ds.b	1
9071                     	xdef	_IO_8to1
9072  0107               _IO_16to9:
9073  0107 00            	ds.b	1
9074                     	xdef	_IO_16to9
9075                     .eeprom:	section	.data
9076  0000               _stored_devicename:
9077  0000 000000000000  	ds.b	20
9078                     	xdef	_stored_devicename
9079  0014               _stored_IO_8to1:
9080  0014 00            	ds.b	1
9081                     	xdef	_stored_IO_8to1
9082  0015               _stored_unused1:
9083  0015 00            	ds.b	1
9084                     	xdef	_stored_unused1
9085  0016               _stored_unused2:
9086  0016 00            	ds.b	1
9087                     	xdef	_stored_unused2
9088  0017               _stored_uip_ethaddr_oct:
9089  0017 000000000000  	ds.b	6
9090                     	xdef	_stored_uip_ethaddr_oct
9091  001d               _stored_port:
9092  001d 0000          	ds.b	2
9093                     	xdef	_stored_port
9094  001f               _stored_netmask:
9095  001f 00000000      	ds.b	4
9096                     	xdef	_stored_netmask
9097  0023               _stored_draddr:
9098  0023 00000000      	ds.b	4
9099                     	xdef	_stored_draddr
9100  0027               _stored_hostaddr:
9101  0027 00000000      	ds.b	4
9102                     	xdef	_stored_hostaddr
9103  002b               _magic1:
9104  002b 00            	ds.b	1
9105                     	xdef	_magic1
9106  002c               _magic2:
9107  002c 00            	ds.b	1
9108                     	xdef	_magic2
9109  002d               _magic3:
9110  002d 00            	ds.b	1
9111                     	xdef	_magic3
9112  002e               _magic4:
9113  002e 00            	ds.b	1
9114                     	xdef	_magic4
9115  002f               _stored_mqttport:
9116  002f 0000          	ds.b	2
9117                     	xdef	_stored_mqttport
9118  0031               _stored_mqttserveraddr:
9119  0031 00000000      	ds.b	4
9120                     	xdef	_stored_mqttserveraddr
9121  0035               _stored_mqtt_username:
9122  0035 000000000000  	ds.b	11
9123                     	xdef	_stored_mqtt_username
9124  0040               _stored_mqtt_password:
9125  0040 000000000000  	ds.b	11
9126                     	xdef	_stored_mqtt_password
9127  004b               _stored_IO_16to9:
9128  004b 00            	ds.b	1
9129                     	xdef	_stored_IO_16to9
9130  004c               _stored_config_settings:
9131  004c 000000000000  	ds.b	6
9132                     	xdef	_stored_config_settings
9133                     	xdef	_stack_limit2
9134                     	xdef	_stack_limit1
9135                     	xref	_mqtt_disconnect
9136                     	xref	_mqtt_subscribe
9137                     	xref	_mqtt_publish
9138                     	xref	_mqtt_connect
9139                     	xref	_mqtt_init
9140                     	xref	_strlen
9141                     	xref	_strcat
9142                     	xref	_wait_timer
9143                     	xref	_arp_timer_expired
9144                     	xref	_periodic_timer_expired
9145                     	xref	_clock_init
9146                     	xref	_LEDcontrol
9147                     	xref	_gpio_init
9148                     	xref	_check_mqtt_server_arp_entry
9149                     	xref	_uip_arp_timer
9150                     	xref	_uip_arp_out
9151                     	xref	_uip_arp_arpin
9152                     	xref	_uip_arp_init
9153                     	xref	_uip_ethaddr
9154                     	xref	_uip_mqttserveraddr
9155                     	xref	_uip_draddr
9156                     	xref	_uip_netmask
9157                     	xref	_uip_hostaddr
9158                     	xref	_uip_process
9159                     	xref	_uip_conns
9160                     	xref	_uip_conn
9161                     	xref	_uip_len
9162                     	xref	_uip_appdata
9163                     	xref	_htons
9164                     	xref	_uip_connect
9165                     	xref	_uip_buf
9166                     	xref	_uip_init
9167                     	xref	_GpioSetPin
9168                     	xref	_HttpDInit
9169                     	xref	_emb_itoa
9170                     	xref	_Enc28j60Send
9171                     	xref	_Enc28j60Receive
9172                     	xref	_Enc28j60Init
9173                     	xref	_spi_init
9174                     	xdef	_publish_pinstate_all
9175                     	xdef	_publish_pinstate
9176                     	xdef	_publish_outbound
9177                     	xdef	_publish_callback
9178                     	xdef	_mqtt_sanity_check
9179                     	xdef	_mqtt_startup
9180                     	xdef	_debugflash
9181                     	xdef	_fastflash
9182                     	xdef	_oneflash
9183                     	xdef	_reboot
9184                     	xdef	_restart
9185                     	xdef	_check_restart_reboot
9186                     	xdef	_check_reset_button
9187                     	xdef	_write_output_registers
9188                     	xdef	_read_input_registers
9189                     	xdef	_check_runtime_changes
9190                     	xdef	_update_mac_string
9191                     	xdef	_check_eeprom_settings
9192                     	xdef	_unlock_eeprom
9193                     	xdef	_main
9194                     	switch	.const
9195  000f               L5242:
9196  000f 2f7374617465  	dc.b	"/state",0
9197  0016               L7632:
9198  0016 2f6f75745f6f  	dc.b	"/out_off",0
9199  001f               L3632:
9200  001f 2f6f75745f6f  	dc.b	"/out_on",0
9201  0027               L5532:
9202  0027 2f696e5f6f66  	dc.b	"/in_off",0
9203  002f               L1532:
9204  002f 2f696e5f6f6e  	dc.b	"/in_on",0
9205  0036               L5302:
9206  0036 6f6e6c696e65  	dc.b	"online",0
9207  003d               L5202:
9208  003d 2f7374617465  	dc.b	"/state-req",0
9209  0048               L5102:
9210  0048 2f6f666600    	dc.b	"/off",0
9211  004d               L5002:
9212  004d 2f6f6e00      	dc.b	"/on",0
9213  0051               L1771:
9214  0051 6f66666c696e  	dc.b	"offline",0
9215  0059               L7671:
9216  0059 2f7374617475  	dc.b	"/status",0
9217                     	xref.b	c_lreg
9237                     	xref	c_ladc
9238                     	xref	c_lcmp
9239                     	xref	c_ltor
9240                     	xref	c_eewrw
9241                     	xref	c_eewrc
9242                     	end
