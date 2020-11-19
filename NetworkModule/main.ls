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
2621                     ; 291 int main(void)
2621                     ; 292 {
2623                     .text:	section	.text,new
2624  0000               _main:
2626  0000 88            	push	a
2627       00000001      OFST:	set	1
2630                     ; 296   parse_complete = 0;
2632  0001 725f0093      	clr	_parse_complete
2633                     ; 297   mqtt_parse_complete = 0;
2635  0005 725f0092      	clr	_mqtt_parse_complete
2636                     ; 298   reboot_request = 0;
2638  0009 725f0098      	clr	_reboot_request
2639                     ; 299   user_reboot_request = 0;
2641  000d 725f0097      	clr	_user_reboot_request
2642                     ; 300   restart_request = 0;
2644  0011 725f0096      	clr	_restart_request
2645                     ; 302   time_mark2 = 0;           // Time capture used in reboot
2647  0015 5f            	clrw	x
2648  0016 cf008a        	ldw	_time_mark2+2,x
2649  0019 cf0088        	ldw	_time_mark2,x
2650                     ; 305   restart_reboot_step = RESTART_REBOOT_IDLE;
2652  001c 725f0095      	clr	_restart_reboot_step
2653                     ; 306   mqtt_close_tcp = 0;
2655  0020 725f0094      	clr	_mqtt_close_tcp
2656                     ; 307   stack_error = 0;
2658  0024 725f00f0      	clr	_stack_error
2659                     ; 310   mqtt_start = MQTT_START_TCP_CONNECT;	 // Tracks the MQTT startup steps
2661  0028 35010035      	mov	_mqtt_start,#1
2662                     ; 311   mqtt_start_status = MQTT_START_NOT_STARTED; // Tracks error states during
2664  002c 725f0034      	clr	_mqtt_start_status
2665                     ; 313   mqtt_keep_alive = 60;                  // Ping interval in seconds
2667  0030 ae003c        	ldw	x,#60
2668  0033 cf007e        	ldw	_mqtt_keep_alive,x
2669                     ; 315   mqtt_start_ctr1 = 0;			 // Tracks time for the MQTT startup
2671  0036 725f0033      	clr	_mqtt_start_ctr1
2672                     ; 317   mqtt_start_ctr2 = 0;			 // Tracks time for the MQTT startup
2674  003a 725f0032      	clr	_mqtt_start_ctr2
2675                     ; 319   mqtt_sanity_ctr = 0;			 // Tracks time for the MQTT sanity
2677  003e 725f0031      	clr	_mqtt_sanity_ctr
2678                     ; 321   mqtt_start_retry = 0;                  // Flag to retry the ARP/TCP Connect
2680  0042 725f0030      	clr	_mqtt_start_retry
2681                     ; 322   MQTT_error_status = 0;                 // For MQTT error status display in
2683  0046 725f0000      	clr	_MQTT_error_status
2684                     ; 324   mqtt_restart_step = MQTT_RESTART_IDLE; // Step counter for MQTT restart
2686  004a 725f002d      	clr	_mqtt_restart_step
2687                     ; 325   strcpy(topic_base, devicetype);        // Initial content of the topic_base.
2689  004e ae0001        	ldw	x,#_topic_base
2690  0051 90ae0000      	ldw	y,#L5261_devicetype
2691  0055               L6:
2692  0055 90f6          	ld	a,(y)
2693  0057 905c          	incw	y
2694  0059 f7            	ld	(x),a
2695  005a 5c            	incw	x
2696  005b 4d            	tnz	a
2697  005c 26f7          	jrne	L6
2698                     ; 331   state_request = STATE_REQUEST_IDLE;    // Set the state request received to
2700  005e c700f1        	ld	_state_request,a
2701                     ; 338   clock_init();            // Initialize and enable clocks and timers
2703  0061 cd0000        	call	_clock_init
2705                     ; 340   gpio_init();             // Initialize and enable gpio pins
2707  0064 cd0000        	call	_gpio_init
2709                     ; 342   spi_init();              // Initialize the SPI bit bang interface to the
2711  0067 cd0000        	call	_spi_init
2713                     ; 345   LEDcontrol(1);           // turn LED on
2715  006a a601          	ld	a,#1
2716  006c cd0000        	call	_LEDcontrol
2718                     ; 347   unlock_eeprom();         // unlock the EEPROM so writes can be performed
2720  006f cd0000        	call	_unlock_eeprom
2722                     ; 349   check_eeprom_settings(); // Check the EEPROM for previously stored Address
2724  0072 cd0000        	call	_check_eeprom_settings
2726                     ; 353   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
2728  0075 cd0000        	call	_Enc28j60Init
2730                     ; 355   uip_arp_init();          // Initialize the ARP module
2732  0078 cd0000        	call	_uip_arp_init
2734                     ; 357   uip_init();              // Initialize uIP Web Server
2736  007b cd0000        	call	_uip_init
2738                     ; 359   HttpDInit();             // Initialize listening ports
2740  007e cd0000        	call	_HttpDInit
2742                     ; 383   stack_limit1 = 0xaa;
2744  0081 35aa0001      	mov	_stack_limit1,#170
2745                     ; 384   stack_limit2 = 0x55;
2747  0085 35550000      	mov	_stack_limit2,#85
2748                     ; 395   mqtt_init(&mqttclient,
2748                     ; 396             mqtt_sendbuf,
2748                     ; 397 	    sizeof(mqtt_sendbuf),
2748                     ; 398 	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
2748                     ; 399 	    UIP_APPDATA_SIZE,
2748                     ; 400 	    publish_callback);
2750  0089 ae0000        	ldw	x,#_publish_callback
2751  008c 89            	pushw	x
2752  008d ae01be        	ldw	x,#446
2753  0090 89            	pushw	x
2754  0091 ae0036        	ldw	x,#_uip_buf+54
2755  0094 89            	pushw	x
2756  0095 ae00c8        	ldw	x,#200
2757  0098 89            	pushw	x
2758  0099 ae0000        	ldw	x,#_mqtt_sendbuf
2759  009c 89            	pushw	x
2760  009d ae0052        	ldw	x,#_mqttclient
2761  00a0 cd0000        	call	_mqtt_init
2763  00a3 5b0a          	addw	sp,#10
2764  00a5               L1561:
2765                     ; 514     uip_len = Enc28j60Receive(uip_buf); // Check for incoming packets
2767  00a5 ae0000        	ldw	x,#_uip_buf
2768  00a8 cd0000        	call	_Enc28j60Receive
2770  00ab cf0000        	ldw	_uip_len,x
2771                     ; 516     if (uip_len > 0) {
2773  00ae 2738          	jreq	L5561
2774                     ; 525       if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
2776  00b0 ae0800        	ldw	x,#2048
2777  00b3 cd0000        	call	_htons
2779  00b6 c3000c        	cpw	x,_uip_buf+12
2780  00b9 2612          	jrne	L7561
2781                     ; 526         uip_input(); // Calls uip_process(UIP_DATA) to process a received
2783  00bb a601          	ld	a,#1
2784  00bd cd0000        	call	_uip_process
2786                     ; 531         if (uip_len > 0) {
2788  00c0 ce0000        	ldw	x,_uip_len
2789  00c3 2723          	jreq	L5561
2790                     ; 532           uip_arp_out();
2792  00c5 cd0000        	call	_uip_arp_out
2794                     ; 536           Enc28j60Send(uip_buf, uip_len);
2796  00c8 ce0000        	ldw	x,_uip_len
2798  00cb 2013          	jp	LC001
2799  00cd               L7561:
2800                     ; 539       else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
2802  00cd ae0806        	ldw	x,#2054
2803  00d0 cd0000        	call	_htons
2805  00d3 c3000c        	cpw	x,_uip_buf+12
2806  00d6 2610          	jrne	L5561
2807                     ; 540         uip_arp_arpin();
2809  00d8 cd0000        	call	_uip_arp_arpin
2811                     ; 544         if (uip_len > 0) {
2813  00db ce0000        	ldw	x,_uip_len
2814  00de 2708          	jreq	L5561
2815                     ; 548           Enc28j60Send(uip_buf, uip_len);
2818  00e0               LC001:
2819  00e0 89            	pushw	x
2820  00e1 ae0000        	ldw	x,#_uip_buf
2821  00e4 cd0000        	call	_Enc28j60Send
2822  00e7 85            	popw	x
2823  00e8               L5561:
2824                     ; 558     if (mqtt_start != MQTT_START_COMPLETE
2824                     ; 559      && mqtt_restart_step == MQTT_RESTART_IDLE
2824                     ; 560      && restart_reboot_step == RESTART_REBOOT_IDLE) {
2826  00e8 c60035        	ld	a,_mqtt_start
2827  00eb a114          	cp	a,#20
2828  00ed 270d          	jreq	L1761
2830  00ef c6002d        	ld	a,_mqtt_restart_step
2831  00f2 2608          	jrne	L1761
2833  00f4 c60095        	ld	a,_restart_reboot_step
2834  00f7 2603          	jrne	L1761
2835                     ; 561        mqtt_startup();
2837  00f9 cd0000        	call	_mqtt_startup
2839  00fc               L1761:
2840                     ; 565     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
2842  00fc c60095        	ld	a,_restart_reboot_step
2843  00ff 2603          	jrne	L3761
2844                     ; 566       mqtt_sanity_check();
2846  0101 cd0000        	call	_mqtt_sanity_check
2848  0104               L3761:
2849                     ; 570     if (periodic_timer_expired()) {
2851  0104 cd0000        	call	_periodic_timer_expired
2853  0107 4d            	tnz	a
2854  0108 2743          	jreq	L5761
2855                     ; 572       for(i = 0; i < UIP_CONNS; i++) {
2857  010a 4f            	clr	a
2858  010b 6b01          	ld	(OFST+0,sp),a
2860  010d               L5071:
2861                     ; 573 	uip_periodic(i);
2863  010d 97            	ld	xl,a
2864  010e a629          	ld	a,#41
2865  0110 42            	mul	x,a
2866  0111 1c0000        	addw	x,#_uip_conns
2867  0114 cf0000        	ldw	_uip_conn,x
2870  0117 a602          	ld	a,#2
2871  0119 cd0000        	call	_uip_process
2873                     ; 592 	if (uip_len > 0) {
2875  011c ce0000        	ldw	x,_uip_len
2876  011f 270e          	jreq	L1171
2877                     ; 593 	  uip_arp_out(); // Verifies arp entry in the ARP table and builds LLH
2879  0121 cd0000        	call	_uip_arp_out
2881                     ; 594           Enc28j60Send(uip_buf, uip_len);
2883  0124 ce0000        	ldw	x,_uip_len
2884  0127 89            	pushw	x
2885  0128 ae0000        	ldw	x,#_uip_buf
2886  012b cd0000        	call	_Enc28j60Send
2888  012e 85            	popw	x
2889  012f               L1171:
2890                     ; 597         mqtt_start_ctr1++; // Increment the MQTT start loop timer 1. This is
2892  012f 725c0033      	inc	_mqtt_start_ctr1
2893                     ; 601         mqtt_start_ctr2++; // Increment the MQTT start loop timer 2. This is
2895  0133 725c0032      	inc	_mqtt_start_ctr2
2896                     ; 604         mqtt_sanity_ctr++; // Increment the MQTT sanity loop timer. This is
2898  0137 725c0031      	inc	_mqtt_sanity_ctr
2899                     ; 572       for(i = 0; i < UIP_CONNS; i++) {
2901  013b 0c01          	inc	(OFST+0,sp)
2905  013d 7b01          	ld	a,(OFST+0,sp)
2906  013f a104          	cp	a,#4
2907  0141 25ca          	jrult	L5071
2908                     ; 614       if (mqtt_start == MQTT_START_COMPLETE) {
2910  0143 c60035        	ld	a,_mqtt_start
2911  0146 a114          	cp	a,#20
2912  0148 2603          	jrne	L5761
2913                     ; 615         publish_outbound();
2915  014a cd0000        	call	_publish_outbound
2917  014d               L5761:
2918                     ; 622     if (arp_timer_expired()) {
2920  014d cd0000        	call	_arp_timer_expired
2922  0150 4d            	tnz	a
2923  0151 2703          	jreq	L5171
2924                     ; 623       uip_arp_timer(); // Clean out old ARP Table entries. Any entry that has
2926  0153 cd0000        	call	_uip_arp_timer
2928  0156               L5171:
2929                     ; 630     check_runtime_changes();
2931  0156 cd0000        	call	_check_runtime_changes
2933                     ; 633     check_reset_button();
2935  0159 cd0000        	call	_check_reset_button
2937                     ; 638     check_restart_reboot();
2939  015c cd0000        	call	_check_restart_reboot
2942  015f cc00a5        	jra	L1561
2993                     ; 666 void mqtt_startup(void)
2993                     ; 667 {
2994                     .text:	section	.text,new
2995  0000               _mqtt_startup:
2999                     ; 683   if (mqtt_start == MQTT_START_TCP_CONNECT) {
3001  0000 c60035        	ld	a,_mqtt_start
3002  0003 a101          	cp	a,#1
3003  0005 2630          	jrne	L7271
3004                     ; 684     if (stored_mqttserveraddr[3] != 0) {
3006  0007 c60034        	ld	a,_stored_mqttserveraddr+3
3007  000a 2603cc0225    	jreq	L7371
3008                     ; 704       mqtt_conn = uip_connect(&uip_mqttserveraddr, Port_Mqttd, Port_Mqttd);
3010  000f ce0083        	ldw	x,_Port_Mqttd
3011  0012 89            	pushw	x
3012  0013 89            	pushw	x
3013  0014 ae0000        	ldw	x,#_uip_mqttserveraddr
3014  0017 cd0000        	call	_uip_connect
3016  001a 5b04          	addw	sp,#4
3017  001c cf002e        	ldw	_mqtt_conn,x
3018                     ; 705       if (mqtt_conn != NULL) {
3020  001f 2711          	jreq	L3371
3021                     ; 706         mqtt_start_ctr1 = 0; // Clear 100ms counter
3023  0021 725f0033      	clr	_mqtt_start_ctr1
3024                     ; 707         mqtt_start_ctr2 = 0; // Clear 100ms counter
3026  0025 725f0032      	clr	_mqtt_start_ctr2
3027                     ; 708         mqtt_start_status = MQTT_START_CONNECTIONS_GOOD;
3029  0029 35100034      	mov	_mqtt_start_status,#16
3030                     ; 709         mqtt_start = MQTT_START_VERIFY_ARP;
3032  002d 35020035      	mov	_mqtt_start,#2
3035  0031 81            	ret	
3036  0032               L3371:
3037                     ; 712         mqtt_start_status |= MQTT_START_CONNECTIONS_ERROR;
3039  0032 72100034      	bset	_mqtt_start_status,#0
3041  0036 81            	ret	
3042  0037               L7271:
3043                     ; 717   else if (mqtt_start == MQTT_START_VERIFY_ARP
3043                     ; 718         && mqtt_start_ctr2 > 10) {
3045  0037 a102          	cp	a,#2
3046  0039 263a          	jrne	L1471
3048  003b c60032        	ld	a,_mqtt_start_ctr2
3049  003e a10b          	cp	a,#11
3050  0040 2533          	jrult	L1471
3051                     ; 719     mqtt_start_ctr2 = 0; // Clear 100ms counter
3053  0042 725f0032      	clr	_mqtt_start_ctr2
3054                     ; 726     if (check_mqtt_server_arp_entry() == 1) {
3056  0046 cd0000        	call	_check_mqtt_server_arp_entry
3058  0049 5a            	decw	x
3059  004a 2611          	jrne	L3471
3060                     ; 728       mqtt_start_retry = 0;
3062  004c 725f0030      	clr	_mqtt_start_retry
3063                     ; 729       mqtt_start_ctr1 = 0; // Clear 100ms counter
3065  0050 725f0033      	clr	_mqtt_start_ctr1
3066                     ; 730       mqtt_start_status |= MQTT_START_ARP_REQUEST_GOOD;
3068  0054 721a0034      	bset	_mqtt_start_status,#5
3069                     ; 731       mqtt_start = MQTT_START_VERIFY_TCP;
3071  0058 35030035      	mov	_mqtt_start,#3
3074  005c 81            	ret	
3075  005d               L3471:
3076                     ; 733     else if (mqtt_start_ctr1 > 150) {
3078  005d c60033        	ld	a,_mqtt_start_ctr1
3079  0060 a197          	cp	a,#151
3080  0062 25a8          	jrult	L7371
3081                     ; 736       mqtt_start_status |= MQTT_START_ARP_REQUEST_ERROR;
3083  0064 72120034      	bset	_mqtt_start_status,#1
3084                     ; 737       mqtt_start = MQTT_START_TCP_CONNECT;
3086  0068 35010035      	mov	_mqtt_start,#1
3087                     ; 739       mqtt_start_status = MQTT_START_NOT_STARTED;
3089  006c 725f0034      	clr	_mqtt_start_status
3090                     ; 740       mqtt_start_retry++;
3092  0070 725c0030      	inc	_mqtt_start_retry
3094  0074 81            	ret	
3095  0075               L1471:
3096                     ; 744   else if (mqtt_start == MQTT_START_VERIFY_TCP
3096                     ; 745         && mqtt_start_ctr2 > 10) {
3098  0075 c60035        	ld	a,_mqtt_start
3099  0078 a103          	cp	a,#3
3100  007a 263e          	jrne	L3571
3102  007c c60032        	ld	a,_mqtt_start_ctr2
3103  007f a10b          	cp	a,#11
3104  0081 2537          	jrult	L3571
3105                     ; 746     mqtt_start_ctr2 = 0; // Clear 100ms counter
3107  0083 725f0032      	clr	_mqtt_start_ctr2
3108                     ; 754     if ((mqtt_conn->tcpstateflags & UIP_TS_MASK) == UIP_ESTABLISHED) {
3110  0087 ce002e        	ldw	x,_mqtt_conn
3111  008a e619          	ld	a,(25,x)
3112  008c a40f          	and	a,#15
3113  008e a103          	cp	a,#3
3114  0090 260d          	jrne	L5571
3115                     ; 755       mqtt_start_retry = 0;
3117  0092 725f0030      	clr	_mqtt_start_retry
3118                     ; 756       mqtt_start_status |= MQTT_START_TCP_CONNECT_GOOD;
3120  0096 721c0034      	bset	_mqtt_start_status,#6
3121                     ; 757       mqtt_start = MQTT_START_QUEUE_CONNECT;
3123  009a 35040035      	mov	_mqtt_start,#4
3126  009e 81            	ret	
3127  009f               L5571:
3128                     ; 759     else if (mqtt_start_ctr1 > 150) {
3130  009f c60033        	ld	a,_mqtt_start_ctr1
3131  00a2 a197          	cp	a,#151
3132  00a4 2403cc0225    	jrult	L7371
3133                     ; 762       mqtt_start_status |= MQTT_START_TCP_CONNECT_ERROR;
3135  00a9 72140034      	bset	_mqtt_start_status,#2
3136                     ; 763       mqtt_start = MQTT_START_TCP_CONNECT;
3138  00ad 35010035      	mov	_mqtt_start,#1
3139                     ; 765       mqtt_start_status = MQTT_START_NOT_STARTED; 
3141  00b1 725f0034      	clr	_mqtt_start_status
3142                     ; 766       mqtt_start_retry++;
3144  00b5 725c0030      	inc	_mqtt_start_retry
3146  00b9 81            	ret	
3147  00ba               L3571:
3148                     ; 770   else if (mqtt_start == MQTT_START_QUEUE_CONNECT) {
3150  00ba c60035        	ld	a,_mqtt_start
3151  00bd a104          	cp	a,#4
3152  00bf 2703cc0147    	jrne	L5671
3153                     ; 781     strcpy(client_id_text, devicetype);
3155  00c4 ae0036        	ldw	x,#_client_id_text
3156  00c7 90ae0000      	ldw	y,#L5261_devicetype
3157  00cb               L411:
3158  00cb 90f6          	ld	a,(y)
3159  00cd 905c          	incw	y
3160  00cf f7            	ld	(x),a
3161  00d0 5c            	incw	x
3162  00d1 4d            	tnz	a
3163  00d2 26f7          	jrne	L411
3164                     ; 783     client_id_text[strlen(client_id_text) - 1] = '\0';
3166  00d4 ae0036        	ldw	x,#_client_id_text
3167  00d7 cd0000        	call	_strlen
3169  00da 5a            	decw	x
3170  00db 724f0036      	clr	(_client_id_text,x)
3171                     ; 785     strcat(client_id_text, mac_string);
3173  00df ae0099        	ldw	x,#_mac_string
3174  00e2 89            	pushw	x
3175  00e3 ae0036        	ldw	x,#_client_id_text
3176  00e6 cd0000        	call	_strcat
3178  00e9 85            	popw	x
3179                     ; 786     client_id = client_id_text;
3181  00ea ae0036        	ldw	x,#_client_id_text
3182  00ed cf0050        	ldw	_client_id,x
3183                     ; 789     connect_flags = MQTT_CONNECT_CLEAN_SESSION;
3185  00f0 35020087      	mov	_connect_flags,#2
3186                     ; 792     topic_base[topic_base_len] = '\0';
3188  00f4 5f            	clrw	x
3189  00f5 c60000        	ld	a,_topic_base_len
3190  00f8 97            	ld	xl,a
3191  00f9 724f0001      	clr	(_topic_base,x)
3192                     ; 793     strcat(topic_base, "/status");
3194  00fd ae0059        	ldw	x,#L7671
3195  0100 89            	pushw	x
3196  0101 ae0001        	ldw	x,#_topic_base
3197  0104 cd0000        	call	_strcat
3199  0107 85            	popw	x
3200                     ; 796     mqtt_connect(&mqttclient,
3200                     ; 797                  client_id,              // Based on MAC address
3200                     ; 798                  topic_base,             // Will topic
3200                     ; 799                  "offline",              // Will message 
3200                     ; 800                  7,                      // Will message size
3200                     ; 801                  stored_mqtt_username,   // Username
3200                     ; 802                  stored_mqtt_password,   // Password
3200                     ; 803                  connect_flags,          // Connect flags
3200                     ; 804                  mqtt_keep_alive);       // Ping interval
3202  0108 ce007e        	ldw	x,_mqtt_keep_alive
3203  010b 89            	pushw	x
3204  010c 3b0087        	push	_connect_flags
3205  010f ae0040        	ldw	x,#_stored_mqtt_password
3206  0112 89            	pushw	x
3207  0113 ae0035        	ldw	x,#_stored_mqtt_username
3208  0116 89            	pushw	x
3209  0117 ae0007        	ldw	x,#7
3210  011a 89            	pushw	x
3211  011b ae0051        	ldw	x,#L1771
3212  011e 89            	pushw	x
3213  011f ae0001        	ldw	x,#_topic_base
3214  0122 89            	pushw	x
3215  0123 ce0050        	ldw	x,_client_id
3216  0126 89            	pushw	x
3217  0127 ae0052        	ldw	x,#_mqttclient
3218  012a cd0000        	call	_mqtt_connect
3220  012d 5b0f          	addw	sp,#15
3221                     ; 806     if (mqttclient.error == MQTT_OK) {
3223  012f ce005c        	ldw	x,_mqttclient+10
3224  0132 5a            	decw	x
3225  0133 260d          	jrne	L3771
3226                     ; 807       mqtt_start_ctr1 = 0; // Clear 100ms counter
3228  0135 725f0033      	clr	_mqtt_start_ctr1
3229                     ; 808       mqtt_start_status |= MQTT_START_MQTT_CONNECT_GOOD;
3231  0139 721e0034      	bset	_mqtt_start_status,#7
3232                     ; 809       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE1;
3234  013d 35050035      	mov	_mqtt_start,#5
3237  0141 81            	ret	
3238  0142               L3771:
3239                     ; 812       mqtt_start_status |= MQTT_START_MQTT_CONNECT_ERROR;
3241  0142 72160034      	bset	_mqtt_start_status,#3
3243  0146 81            	ret	
3244  0147               L5671:
3245                     ; 816   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE1) {
3247  0147 a105          	cp	a,#5
3248  0149 2635          	jrne	L1002
3249                     ; 826     if (mqtt_start_ctr1 > 20) {
3251  014b c60033        	ld	a,_mqtt_start_ctr1
3252  014e a115          	cp	a,#21
3253  0150 2403cc0225    	jrult	L7371
3254                     ; 837       topic_base[topic_base_len] = '\0';
3256  0155 c60000        	ld	a,_topic_base_len
3257  0158 5f            	clrw	x
3258  0159 97            	ld	xl,a
3259  015a 724f0001      	clr	(_topic_base,x)
3260                     ; 838       strcat(topic_base, "/on");
3262  015e ae004d        	ldw	x,#L5002
3263  0161 89            	pushw	x
3264  0162 ae0001        	ldw	x,#_topic_base
3265  0165 cd0000        	call	_strcat
3267  0168 85            	popw	x
3268                     ; 839       mqtt_subscribe(&mqttclient, topic_base, 0);
3270  0169 5f            	clrw	x
3271  016a 89            	pushw	x
3272  016b ae0001        	ldw	x,#_topic_base
3273  016e 89            	pushw	x
3274  016f ae0052        	ldw	x,#_mqttclient
3275  0172 cd0000        	call	_mqtt_subscribe
3277  0175 5b04          	addw	sp,#4
3278                     ; 840       mqtt_start_ctr1 = 0; // Clear 100ms counter
3280  0177 725f0033      	clr	_mqtt_start_ctr1
3281                     ; 841       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE2;
3283  017b 35060035      	mov	_mqtt_start,#6
3285  017f 81            	ret	
3286  0180               L1002:
3287                     ; 845   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE2) {
3289  0180 a106          	cp	a,#6
3290  0182 2632          	jrne	L1102
3291                     ; 846     if (mqtt_start_ctr1 > 10) {
3293  0184 c60033        	ld	a,_mqtt_start_ctr1
3294  0187 a10b          	cp	a,#11
3295  0189 25c7          	jrult	L7371
3296                     ; 849       topic_base[topic_base_len] = '\0';
3298  018b c60000        	ld	a,_topic_base_len
3299  018e 5f            	clrw	x
3300  018f 97            	ld	xl,a
3301  0190 724f0001      	clr	(_topic_base,x)
3302                     ; 850       strcat(topic_base, "/off");
3304  0194 ae0048        	ldw	x,#L5102
3305  0197 89            	pushw	x
3306  0198 ae0001        	ldw	x,#_topic_base
3307  019b cd0000        	call	_strcat
3309  019e 85            	popw	x
3310                     ; 851       mqtt_subscribe(&mqttclient, topic_base, 0);
3312  019f 5f            	clrw	x
3313  01a0 89            	pushw	x
3314  01a1 ae0001        	ldw	x,#_topic_base
3315  01a4 89            	pushw	x
3316  01a5 ae0052        	ldw	x,#_mqttclient
3317  01a8 cd0000        	call	_mqtt_subscribe
3319  01ab 5b04          	addw	sp,#4
3320                     ; 852       mqtt_start_ctr1 = 0; // Clear 100ms counter
3322  01ad 725f0033      	clr	_mqtt_start_ctr1
3323                     ; 853       mqtt_start = MQTT_START_QUEUE_SUBSCRIBE3;
3325  01b1 35070035      	mov	_mqtt_start,#7
3327  01b5 81            	ret	
3328  01b6               L1102:
3329                     ; 857   else if (mqtt_start == MQTT_START_QUEUE_SUBSCRIBE3) {
3331  01b6 a107          	cp	a,#7
3332  01b8 2632          	jrne	L1202
3333                     ; 858     if (mqtt_start_ctr1 > 10) {
3335  01ba c60033        	ld	a,_mqtt_start_ctr1
3336  01bd a10b          	cp	a,#11
3337  01bf 2564          	jrult	L7371
3338                     ; 861       topic_base[topic_base_len] = '\0';
3340  01c1 c60000        	ld	a,_topic_base_len
3341  01c4 5f            	clrw	x
3342  01c5 97            	ld	xl,a
3343  01c6 724f0001      	clr	(_topic_base,x)
3344                     ; 862       strcat(topic_base, "/state-req");
3346  01ca ae003d        	ldw	x,#L5202
3347  01cd 89            	pushw	x
3348  01ce ae0001        	ldw	x,#_topic_base
3349  01d1 cd0000        	call	_strcat
3351  01d4 85            	popw	x
3352                     ; 863       mqtt_subscribe(&mqttclient, topic_base, 0);
3354  01d5 5f            	clrw	x
3355  01d6 89            	pushw	x
3356  01d7 ae0001        	ldw	x,#_topic_base
3357  01da 89            	pushw	x
3358  01db ae0052        	ldw	x,#_mqttclient
3359  01de cd0000        	call	_mqtt_subscribe
3361  01e1 5b04          	addw	sp,#4
3362                     ; 864       mqtt_start_ctr1 = 0; // Clear 100ms counter
3364  01e3 725f0033      	clr	_mqtt_start_ctr1
3365                     ; 865       mqtt_start = MQTT_START_QUEUE_PUBLISH;
3367  01e7 35090035      	mov	_mqtt_start,#9
3369  01eb 81            	ret	
3370  01ec               L1202:
3371                     ; 869   else if (mqtt_start == MQTT_START_QUEUE_PUBLISH) {
3373  01ec a109          	cp	a,#9
3374  01ee 2635          	jrne	L7371
3375                     ; 870     if (mqtt_start_ctr1 > 10) {
3377  01f0 c60033        	ld	a,_mqtt_start_ctr1
3378  01f3 a10b          	cp	a,#11
3379  01f5 252e          	jrult	L7371
3380                     ; 873       topic_base[topic_base_len] = '\0';
3382  01f7 c60000        	ld	a,_topic_base_len
3383  01fa 5f            	clrw	x
3384  01fb 97            	ld	xl,a
3385  01fc 724f0001      	clr	(_topic_base,x)
3386                     ; 874       strcat(topic_base, "/status");
3388  0200 ae0059        	ldw	x,#L7671
3389  0203 89            	pushw	x
3390  0204 ae0001        	ldw	x,#_topic_base
3391  0207 cd0000        	call	_strcat
3393  020a 85            	popw	x
3394                     ; 875       mqtt_publish(&mqttclient,
3394                     ; 876                    topic_base,
3394                     ; 877 		   "online",
3394                     ; 878 		   6,
3394                     ; 879 		   MQTT_PUBLISH_QOS_0 | MQTT_PUBLISH_RETAIN);
3396  020b 4b01          	push	#1
3397  020d ae0006        	ldw	x,#6
3398  0210 89            	pushw	x
3399  0211 ae0036        	ldw	x,#L5302
3400  0214 89            	pushw	x
3401  0215 ae0001        	ldw	x,#_topic_base
3402  0218 89            	pushw	x
3403  0219 ae0052        	ldw	x,#_mqttclient
3404  021c cd0000        	call	_mqtt_publish
3406  021f 5b07          	addw	sp,#7
3407                     ; 881       mqtt_start = MQTT_START_COMPLETE;
3409  0221 35140035      	mov	_mqtt_start,#20
3410  0225               L7371:
3411                     ; 884 }
3414  0225 81            	ret	
3450                     ; 887 void mqtt_sanity_check(void)
3450                     ; 888 {
3451                     .text:	section	.text,new
3452  0000               _mqtt_sanity_check:
3456                     ; 900   if (mqtt_restart_step == MQTT_RESTART_IDLE) {
3458  0000 c6002d        	ld	a,_mqtt_restart_step
3459  0003 2634          	jrne	L7402
3460                     ; 907     if (mqttclient.number_of_timeouts > 1) {
3462  0005 ce0060        	ldw	x,_mqttclient+14
3463  0008 a30002        	cpw	x,#2
3464  000b 2f08          	jrslt	L1502
3465                     ; 909       mqttclient.number_of_timeouts = 0;
3467  000d 5f            	clrw	x
3468  000e cf0060        	ldw	_mqttclient+14,x
3469                     ; 910       mqtt_restart_step = MQTT_RESTART_BEGIN;
3471  0011 3501002d      	mov	_mqtt_restart_step,#1
3472  0015               L1502:
3473                     ; 916     if (mqtt_start == MQTT_START_COMPLETE
3473                     ; 917      && mqtt_conn->tcpstateflags == UIP_CLOSED) {
3475  0015 c60035        	ld	a,_mqtt_start
3476  0018 a114          	cp	a,#20
3477  001a 260b          	jrne	L3502
3479  001c ce002e        	ldw	x,_mqtt_conn
3480  001f 6d19          	tnz	(25,x)
3481  0021 2604          	jrne	L3502
3482                     ; 918       mqtt_restart_step = MQTT_RESTART_BEGIN;
3484  0023 3501002d      	mov	_mqtt_restart_step,#1
3485  0027               L3502:
3486                     ; 924     if (mqtt_start == MQTT_START_COMPLETE
3486                     ; 925      && mqttclient.error != MQTT_OK) {
3488  0027 a114          	cp	a,#20
3489  0029 2703cc00b6    	jrne	L7502
3491  002e ce005c        	ldw	x,_mqttclient+10
3492  0031 5a            	decw	x
3493  0032 27f7          	jreq	L7502
3494                     ; 926       mqtt_restart_step = MQTT_RESTART_BEGIN;
3496  0034 3501002d      	mov	_mqtt_restart_step,#1
3498  0038 81            	ret	
3499  0039               L7402:
3500                     ; 930   else if (mqtt_restart_step == MQTT_RESTART_BEGIN) {
3502  0039 a101          	cp	a,#1
3503  003b 2609          	jrne	L1602
3504                     ; 938     mqtt_restart_step = MQTT_RESTART_DISCONNECT_START;
3506  003d 3502002d      	mov	_mqtt_restart_step,#2
3507                     ; 941     mqtt_start_status = MQTT_START_NOT_STARTED;
3509  0041 725f0034      	clr	_mqtt_start_status
3512  0045 81            	ret	
3513  0046               L1602:
3514                     ; 944   else if (mqtt_restart_step == MQTT_RESTART_DISCONNECT_START) {
3516  0046 a102          	cp	a,#2
3517  0048 260f          	jrne	L5602
3518                     ; 945     mqtt_restart_step = MQTT_RESTART_DISCONNECT_WAIT;
3520  004a 3503002d      	mov	_mqtt_restart_step,#3
3521                     ; 947     mqtt_disconnect(&mqttclient);
3523  004e ae0052        	ldw	x,#_mqttclient
3524  0051 cd0000        	call	_mqtt_disconnect
3526                     ; 948     mqtt_sanity_ctr = 0; // Clear 100ms counter
3528  0054 725f0031      	clr	_mqtt_sanity_ctr
3531  0058 81            	ret	
3532  0059               L5602:
3533                     ; 951   else if (mqtt_restart_step == MQTT_RESTART_DISCONNECT_WAIT) {
3535  0059 a103          	cp	a,#3
3536  005b 260c          	jrne	L1702
3537                     ; 952     if (mqtt_sanity_ctr > 10) {
3539  005d c60031        	ld	a,_mqtt_sanity_ctr
3540  0060 a10b          	cp	a,#11
3541  0062 2552          	jrult	L7502
3542                     ; 955       mqtt_restart_step = MQTT_RESTART_TCPCLOSE;
3544  0064 3504002d      	mov	_mqtt_restart_step,#4
3546  0068 81            	ret	
3547  0069               L1702:
3548                     ; 959   else if (mqtt_restart_step == MQTT_RESTART_TCPCLOSE) {
3550  0069 a104          	cp	a,#4
3551  006b 260d          	jrne	L7702
3552                     ; 975     mqtt_close_tcp = 1;
3554  006d 35010094      	mov	_mqtt_close_tcp,#1
3555                     ; 977     mqtt_sanity_ctr = 0; // Clear 100ms counter
3557  0071 725f0031      	clr	_mqtt_sanity_ctr
3558                     ; 978     mqtt_restart_step = MQTT_RESTART_TCPCLOSE_WAIT;
3560  0075 3505002d      	mov	_mqtt_restart_step,#5
3563  0079 81            	ret	
3564  007a               L7702:
3565                     ; 981   else if (mqtt_restart_step == MQTT_RESTART_TCPCLOSE_WAIT) {
3567  007a a105          	cp	a,#5
3568  007c 2610          	jrne	L3012
3569                     ; 986     if (mqtt_sanity_ctr > 20) {
3571  007e c60031        	ld	a,_mqtt_sanity_ctr
3572  0081 a115          	cp	a,#21
3573  0083 2531          	jrult	L7502
3574                     ; 987       mqtt_close_tcp = 0;
3576  0085 725f0094      	clr	_mqtt_close_tcp
3577                     ; 988       mqtt_restart_step = MQTT_RESTART_SIGNAL_STARTUP;
3579  0089 3506002d      	mov	_mqtt_restart_step,#6
3581  008d 81            	ret	
3582  008e               L3012:
3583                     ; 992   else if (mqtt_restart_step == MQTT_RESTART_SIGNAL_STARTUP) {
3585  008e a106          	cp	a,#6
3586  0090 2624          	jrne	L7502
3587                     ; 994     mqtt_init(&mqttclient,
3587                     ; 995               mqtt_sendbuf,
3587                     ; 996 	      sizeof(mqtt_sendbuf),
3587                     ; 997 	      &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
3587                     ; 998 	      UIP_APPDATA_SIZE,
3587                     ; 999 	      publish_callback);
3589  0092 ae0000        	ldw	x,#_publish_callback
3590  0095 89            	pushw	x
3591  0096 ae01be        	ldw	x,#446
3592  0099 89            	pushw	x
3593  009a ae0036        	ldw	x,#_uip_buf+54
3594  009d 89            	pushw	x
3595  009e ae00c8        	ldw	x,#200
3596  00a1 89            	pushw	x
3597  00a2 ae0000        	ldw	x,#_mqtt_sendbuf
3598  00a5 89            	pushw	x
3599  00a6 ae0052        	ldw	x,#_mqttclient
3600  00a9 cd0000        	call	_mqtt_init
3602  00ac 5b0a          	addw	sp,#10
3603                     ; 1002     mqtt_restart_step = MQTT_RESTART_IDLE;
3605  00ae 725f002d      	clr	_mqtt_restart_step
3606                     ; 1003     mqtt_start = MQTT_START_TCP_CONNECT;
3608  00b2 35010035      	mov	_mqtt_start,#1
3609  00b6               L7502:
3610                     ; 1005 }
3613  00b6 81            	ret	
3686                     ; 1083 void publish_callback(void** unused, struct mqtt_response_publish *published)
3686                     ; 1084 {
3687                     .text:	section	.text,new
3688  0000               _publish_callback:
3690  0000 5204          	subw	sp,#4
3691       00000004      OFST:	set	4
3694                     ; 1090   pin_value = 0;
3696  0002 0f01          	clr	(OFST-3,sp)
3698                     ; 1091   ParseNum = 0;
3700                     ; 1119   pBuffer = uip_appdata;
3702  0004 ce0000        	ldw	x,_uip_appdata
3704                     ; 1121   pBuffer = pBuffer + 1;
3706  0007 1c0012        	addw	x,#18
3708                     ; 1123   pBuffer = pBuffer + 1;
3711                     ; 1125   pBuffer = pBuffer + 2;
3714                     ; 1127   pBuffer = pBuffer + 14;
3716  000a 1f03          	ldw	(OFST-1,sp),x
3718                     ; 1129   pBuffer = pBuffer + strlen(stored_devicename) + 1;
3720  000c ae0000        	ldw	x,#_stored_devicename
3721  000f cd0000        	call	_strlen
3723  0012 72fb03        	addw	x,(OFST-1,sp)
3724  0015 5c            	incw	x
3725  0016 1f03          	ldw	(OFST-1,sp),x
3727                     ; 1132   if (*pBuffer == 'o') {
3729  0018 f6            	ld	a,(x)
3730  0019 a16f          	cp	a,#111
3731  001b 267a          	jrne	L3412
3732                     ; 1133     pBuffer++;
3734  001d 5c            	incw	x
3735  001e 1f03          	ldw	(OFST-1,sp),x
3737                     ; 1134     if (*pBuffer == 'n') {
3739  0020 f6            	ld	a,(x)
3740  0021 a16e          	cp	a,#110
3741  0023 2609          	jrne	L5412
3742                     ; 1135       pBuffer++;
3744  0025 5c            	incw	x
3745  0026 1f03          	ldw	(OFST-1,sp),x
3747                     ; 1136       pin_value = 1;
3749  0028 a601          	ld	a,#1
3750  002a 6b01          	ld	(OFST-3,sp),a
3753  002c 200b          	jra	L7412
3754  002e               L5412:
3755                     ; 1138     else if (*pBuffer == 'f') {
3757  002e a166          	cp	a,#102
3758  0030 2607          	jrne	L7412
3759                     ; 1139       pBuffer = pBuffer + 2;
3761  0032 1c0002        	addw	x,#2
3762  0035 1f03          	ldw	(OFST-1,sp),x
3764                     ; 1140       pin_value = 0;
3766  0037 0f01          	clr	(OFST-3,sp)
3768  0039               L7412:
3769                     ; 1144     if (*pBuffer == 'a') {
3771  0039 f6            	ld	a,(x)
3772  003a a161          	cp	a,#97
3773  003c 2625          	jrne	L3512
3774                     ; 1145       pBuffer++;
3776  003e 5c            	incw	x
3777  003f 1f03          	ldw	(OFST-1,sp),x
3779                     ; 1146       if (*pBuffer == 'l') {
3781  0041 f6            	ld	a,(x)
3782  0042 a16c          	cp	a,#108
3783  0044 264b          	jrne	L7612
3784                     ; 1147         pBuffer++;
3786  0046 5c            	incw	x
3787  0047 1f03          	ldw	(OFST-1,sp),x
3789                     ; 1148         if (*pBuffer == 'l') {
3791  0049 f6            	ld	a,(x)
3792  004a a16c          	cp	a,#108
3793  004c 2643          	jrne	L7612
3794                     ; 1150 	  for (i=0; i<8; i++) GpioSetPin(i, (uint8_t)pin_value);
3796  004e 0f02          	clr	(OFST-2,sp)
3798  0050               L1612:
3801  0050 7b01          	ld	a,(OFST-3,sp)
3802  0052 97            	ld	xl,a
3803  0053 7b02          	ld	a,(OFST-2,sp)
3804  0055 95            	ld	xh,a
3805  0056 cd0000        	call	_GpioSetPin
3809  0059 0c02          	inc	(OFST-2,sp)
3813  005b 7b02          	ld	a,(OFST-2,sp)
3814  005d a108          	cp	a,#8
3815  005f 25ef          	jrult	L1612
3816  0061 202e          	jra	L7612
3817  0063               L3512:
3818                     ; 1156     else if (*pBuffer == '0' || *pBuffer == '1') {
3820  0063 a130          	cp	a,#48
3821  0065 2704          	jreq	L3712
3823  0067 a131          	cp	a,#49
3824  0069 2626          	jrne	L7612
3825  006b               L3712:
3826                     ; 1158       ParseNum = (uint8_t)((*pBuffer - '0') * 10);
3828  006b 97            	ld	xl,a
3829  006c a60a          	ld	a,#10
3830  006e 42            	mul	x,a
3831  006f 9f            	ld	a,xl
3832  0070 a0e0          	sub	a,#224
3833  0072 6b02          	ld	(OFST-2,sp),a
3835                     ; 1159       pBuffer++;
3837  0074 1e03          	ldw	x,(OFST-1,sp)
3838  0076 5c            	incw	x
3839  0077 1f03          	ldw	(OFST-1,sp),x
3841                     ; 1161       ParseNum += (uint8_t)(*pBuffer - '0');
3843  0079 f6            	ld	a,(x)
3844  007a a030          	sub	a,#48
3845  007c 1b02          	add	a,(OFST-2,sp)
3846  007e 6b02          	ld	(OFST-2,sp),a
3848                     ; 1163       if (ParseNum > 0 && ParseNum < 9) {
3850  0080 270f          	jreq	L7612
3852  0082 a109          	cp	a,#9
3853  0084 240b          	jruge	L7612
3854                     ; 1165         ParseNum--;
3856  0086 0a02          	dec	(OFST-2,sp)
3858                     ; 1167         GpioSetPin(ParseNum, (uint8_t)pin_value);
3860  0088 7b01          	ld	a,(OFST-3,sp)
3861  008a 97            	ld	xl,a
3862  008b 7b02          	ld	a,(OFST-2,sp)
3863  008d 95            	ld	xh,a
3864  008e cd0000        	call	_GpioSetPin
3866  0091               L7612:
3867                     ; 1173     mqtt_parse_complete = 1;
3869  0091 35010092      	mov	_mqtt_parse_complete,#1
3871  0095 2013          	jra	L7712
3872  0097               L3412:
3873                     ; 1177   else if (*pBuffer == 's') {
3875  0097 a173          	cp	a,#115
3876  0099 260f          	jrne	L7712
3877                     ; 1178     pBuffer += 8;
3879  009b 1c0008        	addw	x,#8
3881                     ; 1179     if (*pBuffer == 'q') {
3883  009e f6            	ld	a,(x)
3884  009f a171          	cp	a,#113
3885  00a1 2607          	jrne	L7712
3886                     ; 1180       *pBuffer = '0'; // Destroy 'q' in buffer so subsequent "state"
3888  00a3 a630          	ld	a,#48
3889  00a5 f7            	ld	(x),a
3890                     ; 1191       state_request = STATE_REQUEST_RCVD;
3892  00a6 350100f1      	mov	_state_request,#1
3893  00aa               L7712:
3894                     ; 1194 }
3897  00aa 5b04          	addw	sp,#4
3898  00ac 81            	ret	
3937                     ; 1197 void publish_outbound(void)
3937                     ; 1198 {
3938                     .text:	section	.text,new
3939  0000               _publish_outbound:
3941  0000 88            	push	a
3942       00000001      OFST:	set	1
3945                     ; 1206   if (state_request == STATE_REQUEST_IDLE) {
3947  0001 c600f1        	ld	a,_state_request
3948  0004 2703cc00f9    	jrne	L1222
3949                     ; 1209     xor_tmp = (uint8_t)(IO_16to9 ^ IO_16to9_sent);
3951  0009 c600fb        	ld	a,_IO_16to9
3952  000c c800f5        	xor	a,_IO_16to9_sent
3953  000f 6b01          	ld	(OFST+0,sp),a
3955                     ; 1211     if      (xor_tmp & 0x80) publish_pinstate('I', '8', IO_16to9, 0x80); // Input 8
3957  0011 2a0a          	jrpl	L3222
3960  0013 4b80          	push	#128
3961  0015 3b00fb        	push	_IO_16to9
3962  0018 ae4938        	ldw	x,#18744
3965  001b 2060          	jp	LC002
3966  001d               L3222:
3967                     ; 1212     else if (xor_tmp & 0x40) publish_pinstate('I', '7', IO_16to9, 0x40); // Input 7
3969  001d a540          	bcp	a,#64
3970  001f 270a          	jreq	L7222
3973  0021 4b40          	push	#64
3974  0023 3b00fb        	push	_IO_16to9
3975  0026 ae4937        	ldw	x,#18743
3978  0029 2052          	jp	LC002
3979  002b               L7222:
3980                     ; 1213     else if (xor_tmp & 0x20) publish_pinstate('I', '6', IO_16to9, 0x20); // Input 6
3982  002b a520          	bcp	a,#32
3983  002d 270a          	jreq	L3322
3986  002f 4b20          	push	#32
3987  0031 3b00fb        	push	_IO_16to9
3988  0034 ae4936        	ldw	x,#18742
3991  0037 2044          	jp	LC002
3992  0039               L3322:
3993                     ; 1214     else if (xor_tmp & 0x10) publish_pinstate('I', '5', IO_16to9, 0x10); // Input 5
3995  0039 a510          	bcp	a,#16
3996  003b 270a          	jreq	L7322
3999  003d 4b10          	push	#16
4000  003f 3b00fb        	push	_IO_16to9
4001  0042 ae4935        	ldw	x,#18741
4004  0045 2036          	jp	LC002
4005  0047               L7322:
4006                     ; 1215     else if (xor_tmp & 0x08) publish_pinstate('I', '4', IO_16to9, 0x08); // Input 4
4008  0047 a508          	bcp	a,#8
4009  0049 270a          	jreq	L3422
4012  004b 4b08          	push	#8
4013  004d 3b00fb        	push	_IO_16to9
4014  0050 ae4934        	ldw	x,#18740
4017  0053 2028          	jp	LC002
4018  0055               L3422:
4019                     ; 1216     else if (xor_tmp & 0x04) publish_pinstate('I', '3', IO_16to9, 0x04); // Input 3
4021  0055 a504          	bcp	a,#4
4022  0057 270a          	jreq	L7422
4025  0059 4b04          	push	#4
4026  005b 3b00fb        	push	_IO_16to9
4027  005e ae4933        	ldw	x,#18739
4030  0061 201a          	jp	LC002
4031  0063               L7422:
4032                     ; 1217     else if (xor_tmp & 0x02) publish_pinstate('I', '2', IO_16to9, 0x02); // Input 2
4034  0063 a502          	bcp	a,#2
4035  0065 270a          	jreq	L3522
4038  0067 4b02          	push	#2
4039  0069 3b00fb        	push	_IO_16to9
4040  006c ae4932        	ldw	x,#18738
4043  006f 200c          	jp	LC002
4044  0071               L3522:
4045                     ; 1218     else if (xor_tmp & 0x01) publish_pinstate('I', '1', IO_16to9, 0x01); // Input 1
4047  0071 a501          	bcp	a,#1
4048  0073 270c          	jreq	L5222
4051  0075 4b01          	push	#1
4052  0077 3b00fb        	push	_IO_16to9
4053  007a ae4931        	ldw	x,#18737
4055  007d               LC002:
4056  007d cd0000        	call	_publish_pinstate
4057  0080 85            	popw	x
4058  0081               L5222:
4059                     ; 1222     xor_tmp = (uint8_t)(IO_8to1 ^ IO_8to1_sent);
4061  0081 c600fa        	ld	a,_IO_8to1
4062  0084 c800f4        	xor	a,_IO_8to1_sent
4063  0087 6b01          	ld	(OFST+0,sp),a
4065                     ; 1224     if      (xor_tmp & 0x80) publish_pinstate('O', '8', IO_8to1, 0x80); // Output 8
4067  0089 2a0a          	jrpl	L1622
4070  008b 4b80          	push	#128
4071  008d 3b00fa        	push	_IO_8to1
4072  0090 ae4f38        	ldw	x,#20280
4075  0093 2060          	jp	LC003
4076  0095               L1622:
4077                     ; 1225     else if (xor_tmp & 0x40) publish_pinstate('O', '7', IO_8to1, 0x40); // Output 7
4079  0095 a540          	bcp	a,#64
4080  0097 270a          	jreq	L5622
4083  0099 4b40          	push	#64
4084  009b 3b00fa        	push	_IO_8to1
4085  009e ae4f37        	ldw	x,#20279
4088  00a1 2052          	jp	LC003
4089  00a3               L5622:
4090                     ; 1226     else if (xor_tmp & 0x20) publish_pinstate('O', '6', IO_8to1, 0x20); // Output 6
4092  00a3 a520          	bcp	a,#32
4093  00a5 270a          	jreq	L1722
4096  00a7 4b20          	push	#32
4097  00a9 3b00fa        	push	_IO_8to1
4098  00ac ae4f36        	ldw	x,#20278
4101  00af 2044          	jp	LC003
4102  00b1               L1722:
4103                     ; 1227     else if (xor_tmp & 0x10) publish_pinstate('O', '5', IO_8to1, 0x10); // Output 5
4105  00b1 a510          	bcp	a,#16
4106  00b3 270a          	jreq	L5722
4109  00b5 4b10          	push	#16
4110  00b7 3b00fa        	push	_IO_8to1
4111  00ba ae4f35        	ldw	x,#20277
4114  00bd 2036          	jp	LC003
4115  00bf               L5722:
4116                     ; 1228     else if (xor_tmp & 0x08) publish_pinstate('O', '4', IO_8to1, 0x08); // Output 4
4118  00bf a508          	bcp	a,#8
4119  00c1 270a          	jreq	L1032
4122  00c3 4b08          	push	#8
4123  00c5 3b00fa        	push	_IO_8to1
4124  00c8 ae4f34        	ldw	x,#20276
4127  00cb 2028          	jp	LC003
4128  00cd               L1032:
4129                     ; 1229     else if (xor_tmp & 0x04) publish_pinstate('O', '3', IO_8to1, 0x04); // Output 3
4131  00cd a504          	bcp	a,#4
4132  00cf 270a          	jreq	L5032
4135  00d1 4b04          	push	#4
4136  00d3 3b00fa        	push	_IO_8to1
4137  00d6 ae4f33        	ldw	x,#20275
4140  00d9 201a          	jp	LC003
4141  00db               L5032:
4142                     ; 1230     else if (xor_tmp & 0x02) publish_pinstate('O', '2', IO_8to1, 0x02); // Output 2
4144  00db a502          	bcp	a,#2
4145  00dd 270a          	jreq	L1132
4148  00df 4b02          	push	#2
4149  00e1 3b00fa        	push	_IO_8to1
4150  00e4 ae4f32        	ldw	x,#20274
4153  00e7 200c          	jp	LC003
4154  00e9               L1132:
4155                     ; 1231     else if (xor_tmp & 0x01) publish_pinstate('O', '1', IO_8to1, 0x01); // Output 1
4157  00e9 a501          	bcp	a,#1
4158  00eb 270c          	jreq	L1222
4161  00ed 4b01          	push	#1
4162  00ef 3b00fa        	push	_IO_8to1
4163  00f2 ae4f31        	ldw	x,#20273
4165  00f5               LC003:
4166  00f5 cd0000        	call	_publish_pinstate
4167  00f8 85            	popw	x
4168  00f9               L1222:
4169                     ; 1235   if (state_request == STATE_REQUEST_RCVD) {
4171  00f9 c600f1        	ld	a,_state_request
4172  00fc 4a            	dec	a
4173  00fd 2606          	jrne	L7132
4174                     ; 1237     state_request = STATE_REQUEST_IDLE;
4176  00ff c700f1        	ld	_state_request,a
4177                     ; 1238     publish_pinstate_all();
4179  0102 cd0000        	call	_publish_pinstate_all
4181  0105               L7132:
4182                     ; 1266 }
4185  0105 84            	pop	a
4186  0106 81            	ret	
4250                     ; 1269 void publish_pinstate(uint8_t direction, uint8_t pin, uint8_t value, uint8_t mask)
4250                     ; 1270 {
4251                     .text:	section	.text,new
4252  0000               _publish_pinstate:
4254  0000 89            	pushw	x
4255       00000000      OFST:	set	0
4258                     ; 1273   application_message[0] = '0';
4260  0001 35300080      	mov	_application_message,#48
4261                     ; 1274   application_message[1] = (uint8_t)(pin);
4263  0005 9f            	ld	a,xl
4264  0006 c70081        	ld	_application_message+1,a
4265                     ; 1275   application_message[2] = '\0';
4267  0009 725f0082      	clr	_application_message+2
4268                     ; 1277   topic_base[topic_base_len] = '\0';
4270  000d 5f            	clrw	x
4271  000e c60000        	ld	a,_topic_base_len
4272  0011 97            	ld	xl,a
4273  0012 724f0001      	clr	(_topic_base,x)
4274                     ; 1280   if (direction == 'I') {
4276  0016 7b01          	ld	a,(OFST+1,sp)
4277  0018 a149          	cp	a,#73
4278  001a 2618          	jrne	L3432
4279                     ; 1282     if (invert_input == 0xff) value = (uint8_t)(~value);
4281  001c c600f2        	ld	a,_invert_input
4282  001f 4c            	inc	a
4283  0020 2602          	jrne	L5432
4286  0022 0305          	cpl	(OFST+5,sp)
4287  0024               L5432:
4288                     ; 1283     if (value & mask) strcat(topic_base, "/in_on");
4290  0024 7b05          	ld	a,(OFST+5,sp)
4291  0026 1506          	bcp	a,(OFST+6,sp)
4292  0028 2705          	jreq	L7432
4295  002a ae002f        	ldw	x,#L1532
4298  002d 2013          	jra	L7532
4299  002f               L7432:
4300                     ; 1284     else strcat(topic_base, "/in_off");
4302  002f ae0027        	ldw	x,#L5532
4304  0032 200e          	jra	L7532
4305  0034               L3432:
4306                     ; 1288     if (value & mask) strcat(topic_base, "/out_on");
4308  0034 7b05          	ld	a,(OFST+5,sp)
4309  0036 1506          	bcp	a,(OFST+6,sp)
4310  0038 2705          	jreq	L1632
4313  003a ae001f        	ldw	x,#L3632
4316  003d 2003          	jra	L7532
4317  003f               L1632:
4318                     ; 1289     else strcat(topic_base, "/out_off");
4320  003f ae0016        	ldw	x,#L7632
4322  0042               L7532:
4323  0042 89            	pushw	x
4324  0043 ae0001        	ldw	x,#_topic_base
4325  0046 cd0000        	call	_strcat
4326  0049 85            	popw	x
4327                     ; 1293   mqtt_publish(&mqttclient,
4327                     ; 1294                topic_base,
4327                     ; 1295 	       application_message,
4327                     ; 1296 	       2,
4327                     ; 1297 	       MQTT_PUBLISH_QOS_0);
4329  004a 4b00          	push	#0
4330  004c ae0002        	ldw	x,#2
4331  004f 89            	pushw	x
4332  0050 ae0080        	ldw	x,#_application_message
4333  0053 89            	pushw	x
4334  0054 ae0001        	ldw	x,#_topic_base
4335  0057 89            	pushw	x
4336  0058 ae0052        	ldw	x,#_mqttclient
4337  005b cd0000        	call	_mqtt_publish
4339  005e 5b07          	addw	sp,#7
4340                     ; 1299   if (direction == 'I') {
4342  0060 7b01          	ld	a,(OFST+1,sp)
4343  0062 a149          	cp	a,#73
4344  0064 2619          	jrne	L1732
4345                     ; 1301     if (IO_16to9 & mask) IO_16to9_sent |= mask;
4347  0066 c600fb        	ld	a,_IO_16to9
4348  0069 1506          	bcp	a,(OFST+6,sp)
4349  006b 2707          	jreq	L3732
4352  006d c600f5        	ld	a,_IO_16to9_sent
4353  0070 1a06          	or	a,(OFST+6,sp)
4355  0072 2006          	jp	LC005
4356  0074               L3732:
4357                     ; 1302     else IO_16to9_sent &= (uint8_t)~mask;
4359  0074 7b06          	ld	a,(OFST+6,sp)
4360  0076 43            	cpl	a
4361  0077 c400f5        	and	a,_IO_16to9_sent
4362  007a               LC005:
4363  007a c700f5        	ld	_IO_16to9_sent,a
4364  007d 2017          	jra	L7732
4365  007f               L1732:
4366                     ; 1306     if (IO_8to1 & mask) IO_8to1_sent |= mask;
4368  007f c600fa        	ld	a,_IO_8to1
4369  0082 1506          	bcp	a,(OFST+6,sp)
4370  0084 2707          	jreq	L1042
4373  0086 c600f4        	ld	a,_IO_8to1_sent
4374  0089 1a06          	or	a,(OFST+6,sp)
4376  008b 2006          	jp	LC004
4377  008d               L1042:
4378                     ; 1307     else IO_8to1_sent &= (uint8_t)~mask;
4380  008d 7b06          	ld	a,(OFST+6,sp)
4381  008f 43            	cpl	a
4382  0090 c400f4        	and	a,_IO_8to1_sent
4383  0093               LC004:
4384  0093 c700f4        	ld	_IO_8to1_sent,a
4385  0096               L7732:
4386                     ; 1309 }
4389  0096 85            	popw	x
4390  0097 81            	ret	
4439                     ; 1312 void publish_pinstate_all(void)
4439                     ; 1313 {
4440                     .text:	section	.text,new
4441  0000               _publish_pinstate_all:
4443  0000 89            	pushw	x
4444       00000002      OFST:	set	2
4447                     ; 1319   j = IO_16to9;
4449  0001 c600fb        	ld	a,_IO_16to9
4450  0004 6b02          	ld	(OFST+0,sp),a
4452                     ; 1320   k = IO_8to1;
4454  0006 c600fa        	ld	a,_IO_8to1
4455  0009 6b01          	ld	(OFST-1,sp),a
4457                     ; 1323   if (invert_input == 0xff) j = (uint8_t)(~j);
4459  000b c600f2        	ld	a,_invert_input
4460  000e 4c            	inc	a
4461  000f 2602          	jrne	L3242
4464  0011 0302          	cpl	(OFST+0,sp)
4466  0013               L3242:
4467                     ; 1325   application_message[0] = j;
4469  0013 7b02          	ld	a,(OFST+0,sp)
4470  0015 c70080        	ld	_application_message,a
4471                     ; 1326   application_message[1] = k;
4473  0018 7b01          	ld	a,(OFST-1,sp)
4474  001a c70081        	ld	_application_message+1,a
4475                     ; 1327   application_message[2] = '\0';
4477  001d 725f0082      	clr	_application_message+2
4478                     ; 1329   topic_base[topic_base_len] = '\0';
4480  0021 5f            	clrw	x
4481  0022 c60000        	ld	a,_topic_base_len
4482  0025 97            	ld	xl,a
4483  0026 724f0001      	clr	(_topic_base,x)
4484                     ; 1330   strcat(topic_base, "/state");
4486  002a ae000f        	ldw	x,#L5242
4487  002d 89            	pushw	x
4488  002e ae0001        	ldw	x,#_topic_base
4489  0031 cd0000        	call	_strcat
4491  0034 85            	popw	x
4492                     ; 1333   mqtt_publish(&mqttclient,
4492                     ; 1334                topic_base,
4492                     ; 1335 	       application_message,
4492                     ; 1336 	       2,
4492                     ; 1337 	       MQTT_PUBLISH_QOS_0);
4494  0035 4b00          	push	#0
4495  0037 ae0002        	ldw	x,#2
4496  003a 89            	pushw	x
4497  003b ae0080        	ldw	x,#_application_message
4498  003e 89            	pushw	x
4499  003f ae0001        	ldw	x,#_topic_base
4500  0042 89            	pushw	x
4501  0043 ae0052        	ldw	x,#_mqttclient
4502  0046 cd0000        	call	_mqtt_publish
4504                     ; 1338 }
4507  0049 5b09          	addw	sp,#9
4508  004b 81            	ret	
4533                     ; 1343 void unlock_eeprom(void)
4533                     ; 1344 {
4534                     .text:	section	.text,new
4535  0000               _unlock_eeprom:
4539  0000 2008          	jra	L1442
4540  0002               L7342:
4541                     ; 1356     FLASH_DUKR = 0xAE; // MASS key 1
4543  0002 35ae5064      	mov	_FLASH_DUKR,#174
4544                     ; 1357     FLASH_DUKR = 0x56; // MASS key 2
4546  0006 35565064      	mov	_FLASH_DUKR,#86
4547  000a               L1442:
4548                     ; 1355   while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
4550  000a 7207505ff3    	btjf	_FLASH_IAPSR,#3,L7342
4551                     ; 1385 }
4554  000f 81            	ret	
4639                     ; 1388 void check_eeprom_settings(void)
4639                     ; 1389 {
4640                     .text:	section	.text,new
4641  0000               _check_eeprom_settings:
4643  0000 88            	push	a
4644       00000001      OFST:	set	1
4647                     ; 1401   if ((magic4 == 0x55) && 
4647                     ; 1402       (magic3 == 0xee) && 
4647                     ; 1403       (magic2 == 0x0f) && 
4647                     ; 1404       (magic1 == 0xf0)) {
4649  0001 c6002e        	ld	a,_magic4
4650  0004 a155          	cp	a,#85
4651  0006 2703cc01af    	jrne	L1652
4653  000b c6002d        	ld	a,_magic3
4654  000e a1ee          	cp	a,#238
4655  0010 26f6          	jrne	L1652
4657  0012 c6002c        	ld	a,_magic2
4658  0015 a10f          	cp	a,#15
4659  0017 26ef          	jrne	L1652
4661  0019 c6002b        	ld	a,_magic1
4662  001c a1f0          	cp	a,#240
4663  001e 26e8          	jrne	L1652
4664                     ; 1409     uip_ipaddr(IpAddr, stored_hostaddr[3], stored_hostaddr[2], stored_hostaddr[1], stored_hostaddr[0]);
4666  0020 c6002a        	ld	a,_stored_hostaddr+3
4667  0023 97            	ld	xl,a
4668  0024 c60029        	ld	a,_stored_hostaddr+2
4669  0027 02            	rlwa	x,a
4670  0028 cf008c        	ldw	_IpAddr,x
4673  002b c60028        	ld	a,_stored_hostaddr+1
4674  002e 97            	ld	xl,a
4675  002f c60027        	ld	a,_stored_hostaddr
4676  0032 02            	rlwa	x,a
4677  0033 cf008e        	ldw	_IpAddr+2,x
4678                     ; 1410     uip_sethostaddr(IpAddr);
4680  0036 ce008c        	ldw	x,_IpAddr
4681  0039 cf0000        	ldw	_uip_hostaddr,x
4684  003c ce008e        	ldw	x,_IpAddr+2
4685  003f cf0002        	ldw	_uip_hostaddr+2,x
4686                     ; 1413     uip_ipaddr(IpAddr,
4688  0042 c60026        	ld	a,_stored_draddr+3
4689  0045 97            	ld	xl,a
4690  0046 c60025        	ld	a,_stored_draddr+2
4691  0049 02            	rlwa	x,a
4692  004a cf008c        	ldw	_IpAddr,x
4695  004d c60024        	ld	a,_stored_draddr+1
4696  0050 97            	ld	xl,a
4697  0051 c60023        	ld	a,_stored_draddr
4698  0054 02            	rlwa	x,a
4699  0055 cf008e        	ldw	_IpAddr+2,x
4700                     ; 1418     uip_setdraddr(IpAddr);
4702  0058 ce008c        	ldw	x,_IpAddr
4703  005b cf0000        	ldw	_uip_draddr,x
4706  005e ce008e        	ldw	x,_IpAddr+2
4707  0061 cf0002        	ldw	_uip_draddr+2,x
4708                     ; 1421     uip_ipaddr(IpAddr,
4710  0064 c60022        	ld	a,_stored_netmask+3
4711  0067 97            	ld	xl,a
4712  0068 c60021        	ld	a,_stored_netmask+2
4713  006b 02            	rlwa	x,a
4714  006c cf008c        	ldw	_IpAddr,x
4717  006f c60020        	ld	a,_stored_netmask+1
4718  0072 97            	ld	xl,a
4719  0073 c6001f        	ld	a,_stored_netmask
4720  0076 02            	rlwa	x,a
4721  0077 cf008e        	ldw	_IpAddr+2,x
4722                     ; 1426     uip_setnetmask(IpAddr);
4724  007a ce008c        	ldw	x,_IpAddr
4725  007d cf0000        	ldw	_uip_netmask,x
4728  0080 ce008e        	ldw	x,_IpAddr+2
4729  0083 cf0002        	ldw	_uip_netmask+2,x
4730                     ; 1430     uip_ipaddr(IpAddr,
4732  0086 c60034        	ld	a,_stored_mqttserveraddr+3
4733  0089 97            	ld	xl,a
4734  008a c60033        	ld	a,_stored_mqttserveraddr+2
4735  008d 02            	rlwa	x,a
4736  008e cf008c        	ldw	_IpAddr,x
4739  0091 c60032        	ld	a,_stored_mqttserveraddr+1
4740  0094 97            	ld	xl,a
4741  0095 c60031        	ld	a,_stored_mqttserveraddr
4742  0098 02            	rlwa	x,a
4743  0099 cf008e        	ldw	_IpAddr+2,x
4744                     ; 1435     uip_setmqttserveraddr(IpAddr);
4746  009c ce008c        	ldw	x,_IpAddr
4747  009f cf0000        	ldw	_uip_mqttserveraddr,x
4750  00a2 ce008e        	ldw	x,_IpAddr+2
4751  00a5 cf0002        	ldw	_uip_mqttserveraddr+2,x
4752                     ; 1437     Port_Mqttd = stored_mqttport;
4754  00a8 ce002f        	ldw	x,_stored_mqttport
4755  00ab cf0083        	ldw	_Port_Mqttd,x
4756                     ; 1441     Port_Httpd = stored_port;
4758  00ae ce001d        	ldw	x,_stored_port
4759  00b1 cf0090        	ldw	_Port_Httpd,x
4760                     ; 1446     uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
4762  00b4 55001c0000    	mov	_uip_ethaddr,_stored_uip_ethaddr_oct+5
4763                     ; 1447     uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
4765  00b9 55001b0001    	mov	_uip_ethaddr+1,_stored_uip_ethaddr_oct+4
4766                     ; 1448     uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
4768  00be 55001a0002    	mov	_uip_ethaddr+2,_stored_uip_ethaddr_oct+3
4769                     ; 1449     uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
4771  00c3 5500190003    	mov	_uip_ethaddr+3,_stored_uip_ethaddr_oct+2
4772                     ; 1450     uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
4774  00c8 5500180004    	mov	_uip_ethaddr+4,_stored_uip_ethaddr_oct+1
4775                     ; 1451     uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
4777  00cd 5500170005    	mov	_uip_ethaddr+5,_stored_uip_ethaddr_oct
4778                     ; 1455     if (stored_config_settings[0] != '0' && stored_config_settings[0] != '1') {
4780  00d2 c6004c        	ld	a,_stored_config_settings
4781  00d5 a130          	cp	a,#48
4782  00d7 270c          	jreq	L3252
4784  00d9 a131          	cp	a,#49
4785  00db 2708          	jreq	L3252
4786                     ; 1456       stored_config_settings[0] = '0';
4788  00dd a630          	ld	a,#48
4789  00df ae004c        	ldw	x,#_stored_config_settings
4790  00e2 cd0000        	call	c_eewrc
4792  00e5               L3252:
4793                     ; 1458     if (stored_config_settings[1] != '0' && stored_config_settings[1] != '1') {
4795  00e5 c6004d        	ld	a,_stored_config_settings+1
4796  00e8 a130          	cp	a,#48
4797  00ea 270c          	jreq	L5252
4799  00ec a131          	cp	a,#49
4800  00ee 2708          	jreq	L5252
4801                     ; 1459       stored_config_settings[1] = '0';
4803  00f0 a630          	ld	a,#48
4804  00f2 ae004d        	ldw	x,#_stored_config_settings+1
4805  00f5 cd0000        	call	c_eewrc
4807  00f8               L5252:
4808                     ; 1461     if (stored_config_settings[2] != '0' && stored_config_settings[2] != '1' && stored_config_settings[2] != '2') {
4810  00f8 c6004e        	ld	a,_stored_config_settings+2
4811  00fb a130          	cp	a,#48
4812  00fd 2710          	jreq	L7252
4814  00ff a131          	cp	a,#49
4815  0101 270c          	jreq	L7252
4817  0103 a132          	cp	a,#50
4818  0105 2708          	jreq	L7252
4819                     ; 1462       stored_config_settings[2] = '2';
4821  0107 a632          	ld	a,#50
4822  0109 ae004e        	ldw	x,#_stored_config_settings+2
4823  010c cd0000        	call	c_eewrc
4825  010f               L7252:
4826                     ; 1464     if (stored_config_settings[3] != '0' && stored_config_settings[3] != '1') {
4828  010f c6004f        	ld	a,_stored_config_settings+3
4829  0112 a130          	cp	a,#48
4830  0114 270c          	jreq	L1352
4832  0116 a131          	cp	a,#49
4833  0118 2708          	jreq	L1352
4834                     ; 1465       stored_config_settings[3] = '0';
4836  011a a630          	ld	a,#48
4837  011c ae004f        	ldw	x,#_stored_config_settings+3
4838  011f cd0000        	call	c_eewrc
4840  0122               L1352:
4841                     ; 1467     if (stored_config_settings[4] != '0') {
4843  0122 c60050        	ld	a,_stored_config_settings+4
4844  0125 a130          	cp	a,#48
4845  0127 2708          	jreq	L3352
4846                     ; 1468       stored_config_settings[4] = '0';
4848  0129 a630          	ld	a,#48
4849  012b ae0050        	ldw	x,#_stored_config_settings+4
4850  012e cd0000        	call	c_eewrc
4852  0131               L3352:
4853                     ; 1470     if (stored_config_settings[5] != '0') {
4855  0131 c60051        	ld	a,_stored_config_settings+5
4856  0134 a130          	cp	a,#48
4857  0136 2708          	jreq	L5352
4858                     ; 1471       stored_config_settings[5] = '0';
4860  0138 a630          	ld	a,#48
4861  013a ae0051        	ldw	x,#_stored_config_settings+5
4862  013d cd0000        	call	c_eewrc
4864  0140               L5352:
4865                     ; 1475     if (stored_config_settings[0] == '0') invert_output = 0x00;
4867  0140 c6004c        	ld	a,_stored_config_settings
4868  0143 a130          	cp	a,#48
4869  0145 2606          	jrne	L7352
4872  0147 725f00f3      	clr	_invert_output
4874  014b 2004          	jra	L1452
4875  014d               L7352:
4876                     ; 1476     else invert_output = 0xff;
4878  014d 35ff00f3      	mov	_invert_output,#255
4879  0151               L1452:
4880                     ; 1479     if (stored_config_settings[1] == '0') invert_input = 0x00;
4882  0151 c6004d        	ld	a,_stored_config_settings+1
4883  0154 a130          	cp	a,#48
4884  0156 2606          	jrne	L3452
4887  0158 725f00f2      	clr	_invert_input
4889  015c 2004          	jra	L5452
4890  015e               L3452:
4891                     ; 1480     else invert_input = 0xff;
4893  015e 35ff00f2      	mov	_invert_input,#255
4894  0162               L5452:
4895                     ; 1485     if (stored_config_settings[2] == '0') {
4897  0162 c6004e        	ld	a,_stored_config_settings+2
4898  0165 a130          	cp	a,#48
4899  0167 260a          	jrne	L7452
4900                     ; 1487       IO_16to9 = 0x00;
4902  0169 725f00fb      	clr	_IO_16to9
4903                     ; 1488       IO_8to1 = 0x00;
4905  016d 725f00fa      	clr	_IO_8to1
4907  0171 2036          	jra	L1552
4908  0173               L7452:
4909                     ; 1490     else if (stored_config_settings[2] == '1') {
4911  0173 a131          	cp	a,#49
4912  0175 260a          	jrne	L3552
4913                     ; 1492       IO_16to9 = 0xff;
4915  0177 35ff00fb      	mov	_IO_16to9,#255
4916                     ; 1493       IO_8to1 = 0xff;
4918  017b 35ff00fa      	mov	_IO_8to1,#255
4920  017f 2028          	jra	L1552
4921  0181               L3552:
4922                     ; 1497       IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9;
4924  0181 55004b00f5    	mov	_IO_16to9_sent,_stored_IO_16to9
4925  0186 5500f500f7    	mov	_IO_16to9_new2,_IO_16to9_sent
4926  018b 5500f700f9    	mov	_IO_16to9_new1,_IO_16to9_new2
4927  0190 5500f900fb    	mov	_IO_16to9,_IO_16to9_new1
4928                     ; 1498       IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1;
4930  0195 55001400f4    	mov	_IO_8to1_sent,_stored_IO_8to1
4931  019a 5500f400f6    	mov	_IO_8to1_new2,_IO_8to1_sent
4932  019f 5500f600f8    	mov	_IO_8to1_new1,_IO_8to1_new2
4933  01a4 5500f800fa    	mov	_IO_8to1,_IO_8to1_new1
4934  01a9               L1552:
4935                     ; 1502     write_output_registers();
4937  01a9 cd0000        	call	_write_output_registers
4940  01ac cc040e        	jra	L7552
4941  01af               L1652:
4942                     ; 1511     uip_ipaddr(IpAddr, 192,168,1,4);
4944  01af aec0a8        	ldw	x,#49320
4945  01b2 cf008c        	ldw	_IpAddr,x
4948  01b5 ae0104        	ldw	x,#260
4949  01b8 cf008e        	ldw	_IpAddr+2,x
4950                     ; 1512     uip_sethostaddr(IpAddr);
4952  01bb ce008c        	ldw	x,_IpAddr
4953  01be cf0000        	ldw	_uip_hostaddr,x
4956  01c1 ce008e        	ldw	x,_IpAddr+2
4957  01c4 cf0002        	ldw	_uip_hostaddr+2,x
4958                     ; 1514     stored_hostaddr[3] = 192;	// MSB
4960  01c7 a6c0          	ld	a,#192
4961  01c9 ae002a        	ldw	x,#_stored_hostaddr+3
4962  01cc cd0000        	call	c_eewrc
4964                     ; 1515     stored_hostaddr[2] = 168;	//
4966  01cf a6a8          	ld	a,#168
4967  01d1 ae0029        	ldw	x,#_stored_hostaddr+2
4968  01d4 cd0000        	call	c_eewrc
4970                     ; 1516     stored_hostaddr[1] = 1;	//
4972  01d7 a601          	ld	a,#1
4973  01d9 ae0028        	ldw	x,#_stored_hostaddr+1
4974  01dc cd0000        	call	c_eewrc
4976                     ; 1517     stored_hostaddr[0] = 4;	// LSB
4978  01df a604          	ld	a,#4
4979  01e1 ae0027        	ldw	x,#_stored_hostaddr
4980  01e4 cd0000        	call	c_eewrc
4982                     ; 1520     uip_ipaddr(IpAddr, 192,168,1,1);
4984  01e7 aec0a8        	ldw	x,#49320
4985  01ea cf008c        	ldw	_IpAddr,x
4988  01ed ae0101        	ldw	x,#257
4989  01f0 cf008e        	ldw	_IpAddr+2,x
4990                     ; 1521     uip_setdraddr(IpAddr);
4992  01f3 ce008c        	ldw	x,_IpAddr
4993  01f6 cf0000        	ldw	_uip_draddr,x
4996  01f9 ce008e        	ldw	x,_IpAddr+2
4997  01fc cf0002        	ldw	_uip_draddr+2,x
4998                     ; 1523     stored_draddr[3] = 192;	// MSB
5000  01ff a6c0          	ld	a,#192
5001  0201 ae0026        	ldw	x,#_stored_draddr+3
5002  0204 cd0000        	call	c_eewrc
5004                     ; 1524     stored_draddr[2] = 168;	//
5006  0207 a6a8          	ld	a,#168
5007  0209 ae0025        	ldw	x,#_stored_draddr+2
5008  020c cd0000        	call	c_eewrc
5010                     ; 1525     stored_draddr[1] = 1;		//
5012  020f a601          	ld	a,#1
5013  0211 ae0024        	ldw	x,#_stored_draddr+1
5014  0214 cd0000        	call	c_eewrc
5016                     ; 1526     stored_draddr[0] = 1;		// LSB
5018  0217 a601          	ld	a,#1
5019  0219 ae0023        	ldw	x,#_stored_draddr
5020  021c cd0000        	call	c_eewrc
5022                     ; 1529     uip_ipaddr(IpAddr, 255,255,255,0);
5024  021f aeffff        	ldw	x,#65535
5025  0222 cf008c        	ldw	_IpAddr,x
5028  0225 aeff00        	ldw	x,#65280
5029  0228 cf008e        	ldw	_IpAddr+2,x
5030                     ; 1530     uip_setnetmask(IpAddr);
5032  022b ce008c        	ldw	x,_IpAddr
5033  022e cf0000        	ldw	_uip_netmask,x
5036  0231 ce008e        	ldw	x,_IpAddr+2
5037  0234 cf0002        	ldw	_uip_netmask+2,x
5038                     ; 1532     stored_netmask[3] = 255;	// MSB
5040  0237 a6ff          	ld	a,#255
5041  0239 ae0022        	ldw	x,#_stored_netmask+3
5042  023c cd0000        	call	c_eewrc
5044                     ; 1533     stored_netmask[2] = 255;	//
5046  023f a6ff          	ld	a,#255
5047  0241 ae0021        	ldw	x,#_stored_netmask+2
5048  0244 cd0000        	call	c_eewrc
5050                     ; 1534     stored_netmask[1] = 255;	//
5052  0247 a6ff          	ld	a,#255
5053  0249 ae0020        	ldw	x,#_stored_netmask+1
5054  024c cd0000        	call	c_eewrc
5056                     ; 1535     stored_netmask[0] = 0;	// LSB
5058  024f 4f            	clr	a
5059  0250 ae001f        	ldw	x,#_stored_netmask
5060  0253 cd0000        	call	c_eewrc
5062                     ; 1539     uip_ipaddr(IpAddr, 0,0,0,0);
5064  0256 5f            	clrw	x
5065  0257 cf008c        	ldw	_IpAddr,x
5068  025a cf008e        	ldw	_IpAddr+2,x
5069                     ; 1540     uip_setmqttserveraddr(IpAddr);
5071  025d cf0000        	ldw	_uip_mqttserveraddr,x
5074  0260 cf0002        	ldw	_uip_mqttserveraddr+2,x
5075                     ; 1543     stored_mqttserveraddr[3] = 0;	// MSB
5077  0263 4f            	clr	a
5078  0264 ae0034        	ldw	x,#_stored_mqttserveraddr+3
5079  0267 cd0000        	call	c_eewrc
5081                     ; 1544     stored_mqttserveraddr[2] = 0;	//
5083  026a 4f            	clr	a
5084  026b ae0033        	ldw	x,#_stored_mqttserveraddr+2
5085  026e cd0000        	call	c_eewrc
5087                     ; 1545     stored_mqttserveraddr[1] = 0;	//
5089  0271 4f            	clr	a
5090  0272 ae0032        	ldw	x,#_stored_mqttserveraddr+1
5091  0275 cd0000        	call	c_eewrc
5093                     ; 1546     stored_mqttserveraddr[0] = 0;	// LSB
5095  0278 4f            	clr	a
5096  0279 ae0031        	ldw	x,#_stored_mqttserveraddr
5097  027c cd0000        	call	c_eewrc
5099                     ; 1549     stored_mqttport = 1883;		// Port
5101  027f ae075b        	ldw	x,#1883
5102  0282 89            	pushw	x
5103  0283 ae002f        	ldw	x,#_stored_mqttport
5104  0286 cd0000        	call	c_eewrw
5106  0289 85            	popw	x
5107                     ; 1551     Port_Mqttd = 1883;
5109  028a ae075b        	ldw	x,#1883
5110  028d cf0083        	ldw	_Port_Mqttd,x
5111                     ; 1554     for(i=0; i<11; i++) { stored_mqtt_username[i] = '\0'; }
5113  0290 4f            	clr	a
5114  0291 6b01          	ld	(OFST+0,sp),a
5116  0293               L1262:
5119  0293 5f            	clrw	x
5120  0294 97            	ld	xl,a
5121  0295 4f            	clr	a
5122  0296 1c0035        	addw	x,#_stored_mqtt_username
5123  0299 cd0000        	call	c_eewrc
5127  029c 0c01          	inc	(OFST+0,sp)
5131  029e 7b01          	ld	a,(OFST+0,sp)
5132  02a0 a10b          	cp	a,#11
5133  02a2 25ef          	jrult	L1262
5134                     ; 1555     for(i=0; i<11; i++) { stored_mqtt_password[i] = '\0'; }
5136  02a4 4f            	clr	a
5137  02a5 6b01          	ld	(OFST+0,sp),a
5139  02a7               L7262:
5142  02a7 5f            	clrw	x
5143  02a8 97            	ld	xl,a
5144  02a9 4f            	clr	a
5145  02aa 1c0040        	addw	x,#_stored_mqtt_password
5146  02ad cd0000        	call	c_eewrc
5150  02b0 0c01          	inc	(OFST+0,sp)
5154  02b2 7b01          	ld	a,(OFST+0,sp)
5155  02b4 a10b          	cp	a,#11
5156  02b6 25ef          	jrult	L7262
5157                     ; 1560     stored_port = 8080;
5159  02b8 ae1f90        	ldw	x,#8080
5160  02bb 89            	pushw	x
5161  02bc ae001d        	ldw	x,#_stored_port
5162  02bf cd0000        	call	c_eewrw
5164  02c2 85            	popw	x
5165                     ; 1562     Port_Httpd = 8080;
5167  02c3 ae1f90        	ldw	x,#8080
5168  02c6 cf0090        	ldw	_Port_Httpd,x
5169                     ; 1578     stored_uip_ethaddr_oct[5] = 0xc2;	//MAC MSB
5171  02c9 a6c2          	ld	a,#194
5172  02cb ae001c        	ldw	x,#_stored_uip_ethaddr_oct+5
5173  02ce cd0000        	call	c_eewrc
5175                     ; 1579     stored_uip_ethaddr_oct[4] = 0x4d;
5177  02d1 a64d          	ld	a,#77
5178  02d3 ae001b        	ldw	x,#_stored_uip_ethaddr_oct+4
5179  02d6 cd0000        	call	c_eewrc
5181                     ; 1580     stored_uip_ethaddr_oct[3] = 0x69;
5183  02d9 a669          	ld	a,#105
5184  02db ae001a        	ldw	x,#_stored_uip_ethaddr_oct+3
5185  02de cd0000        	call	c_eewrc
5187                     ; 1581     stored_uip_ethaddr_oct[2] = 0x6b;
5189  02e1 a66b          	ld	a,#107
5190  02e3 ae0019        	ldw	x,#_stored_uip_ethaddr_oct+2
5191  02e6 cd0000        	call	c_eewrc
5193                     ; 1582     stored_uip_ethaddr_oct[1] = 0x65;
5195  02e9 a665          	ld	a,#101
5196  02eb ae0018        	ldw	x,#_stored_uip_ethaddr_oct+1
5197  02ee cd0000        	call	c_eewrc
5199                     ; 1583     stored_uip_ethaddr_oct[0] = 0x00;	//MAC LSB
5201  02f1 4f            	clr	a
5202  02f2 ae0017        	ldw	x,#_stored_uip_ethaddr_oct
5203  02f5 cd0000        	call	c_eewrc
5205                     ; 1585     uip_ethaddr.addr[0] = stored_uip_ethaddr_oct[5]; // MSB
5207  02f8 35c20000      	mov	_uip_ethaddr,#194
5208                     ; 1586     uip_ethaddr.addr[1] = stored_uip_ethaddr_oct[4];
5210  02fc 354d0001      	mov	_uip_ethaddr+1,#77
5211                     ; 1587     uip_ethaddr.addr[2] = stored_uip_ethaddr_oct[3];
5213  0300 35690002      	mov	_uip_ethaddr+2,#105
5214                     ; 1588     uip_ethaddr.addr[3] = stored_uip_ethaddr_oct[2];
5216  0304 356b0003      	mov	_uip_ethaddr+3,#107
5217                     ; 1589     uip_ethaddr.addr[4] = stored_uip_ethaddr_oct[1];
5219  0308 35650004      	mov	_uip_ethaddr+4,#101
5220                     ; 1590     uip_ethaddr.addr[5] = stored_uip_ethaddr_oct[0]; // LSB
5222  030c 725f0005      	clr	_uip_ethaddr+5
5223                     ; 1593     stored_devicename[0] =  'N';
5225  0310 a64e          	ld	a,#78
5226  0312 ae0000        	ldw	x,#_stored_devicename
5227  0315 cd0000        	call	c_eewrc
5229                     ; 1594     stored_devicename[1] =  'e';
5231  0318 a665          	ld	a,#101
5232  031a ae0001        	ldw	x,#_stored_devicename+1
5233  031d cd0000        	call	c_eewrc
5235                     ; 1595     stored_devicename[2] =  'w';
5237  0320 a677          	ld	a,#119
5238  0322 ae0002        	ldw	x,#_stored_devicename+2
5239  0325 cd0000        	call	c_eewrc
5241                     ; 1596     stored_devicename[3] =  'D';
5243  0328 a644          	ld	a,#68
5244  032a ae0003        	ldw	x,#_stored_devicename+3
5245  032d cd0000        	call	c_eewrc
5247                     ; 1597     stored_devicename[4] =  'e';
5249  0330 a665          	ld	a,#101
5250  0332 ae0004        	ldw	x,#_stored_devicename+4
5251  0335 cd0000        	call	c_eewrc
5253                     ; 1598     stored_devicename[5] =  'v';
5255  0338 a676          	ld	a,#118
5256  033a ae0005        	ldw	x,#_stored_devicename+5
5257  033d cd0000        	call	c_eewrc
5259                     ; 1599     stored_devicename[6] =  'i';
5261  0340 a669          	ld	a,#105
5262  0342 ae0006        	ldw	x,#_stored_devicename+6
5263  0345 cd0000        	call	c_eewrc
5265                     ; 1600     stored_devicename[7] =  'c';
5267  0348 a663          	ld	a,#99
5268  034a ae0007        	ldw	x,#_stored_devicename+7
5269  034d cd0000        	call	c_eewrc
5271                     ; 1601     stored_devicename[8] =  'e';
5273  0350 a665          	ld	a,#101
5274  0352 ae0008        	ldw	x,#_stored_devicename+8
5275  0355 cd0000        	call	c_eewrc
5277                     ; 1602     stored_devicename[9] =  '0';
5279  0358 a630          	ld	a,#48
5280  035a ae0009        	ldw	x,#_stored_devicename+9
5281  035d cd0000        	call	c_eewrc
5283                     ; 1603     stored_devicename[10] = '0';
5285  0360 a630          	ld	a,#48
5286  0362 ae000a        	ldw	x,#_stored_devicename+10
5287  0365 cd0000        	call	c_eewrc
5289                     ; 1604     stored_devicename[11] = '0';
5291  0368 a630          	ld	a,#48
5292  036a ae000b        	ldw	x,#_stored_devicename+11
5293  036d cd0000        	call	c_eewrc
5295                     ; 1605     for (i=12; i<20; i++) stored_devicename[i] = '\0';
5297  0370 a60c          	ld	a,#12
5298  0372 6b01          	ld	(OFST+0,sp),a
5300  0374               L5362:
5303  0374 5f            	clrw	x
5304  0375 97            	ld	xl,a
5305  0376 4f            	clr	a
5306  0377 1c0000        	addw	x,#_stored_devicename
5307  037a cd0000        	call	c_eewrc
5311  037d 0c01          	inc	(OFST+0,sp)
5315  037f 7b01          	ld	a,(OFST+0,sp)
5316  0381 a114          	cp	a,#20
5317  0383 25ef          	jrult	L5362
5318                     ; 1610     stored_config_settings[0] = '0'; // Set to Invert Output OFF
5320  0385 a630          	ld	a,#48
5321  0387 ae004c        	ldw	x,#_stored_config_settings
5322  038a cd0000        	call	c_eewrc
5324                     ; 1611     stored_config_settings[1] = '0'; // Set to Invert Input Off
5326  038d a630          	ld	a,#48
5327  038f ae004d        	ldw	x,#_stored_config_settings+1
5328  0392 cd0000        	call	c_eewrc
5330                     ; 1612     stored_config_settings[2] = '2'; // Set to Retain pin states
5332  0395 a632          	ld	a,#50
5333  0397 ae004e        	ldw	x,#_stored_config_settings+2
5334  039a cd0000        	call	c_eewrc
5336                     ; 1613     stored_config_settings[3] = '0'; // Set to Half Duplex
5338  039d a630          	ld	a,#48
5339  039f ae004f        	ldw	x,#_stored_config_settings+3
5340  03a2 cd0000        	call	c_eewrc
5342                     ; 1614     stored_config_settings[4] = '0'; // undefined
5344  03a5 a630          	ld	a,#48
5345  03a7 ae0050        	ldw	x,#_stored_config_settings+4
5346  03aa cd0000        	call	c_eewrc
5348                     ; 1615     stored_config_settings[5] = '0'; // undefined
5350  03ad a630          	ld	a,#48
5351  03af ae0051        	ldw	x,#_stored_config_settings+5
5352  03b2 cd0000        	call	c_eewrc
5354                     ; 1616     invert_output = 0x00;			// Turn off output invert bit
5356  03b5 725f00f3      	clr	_invert_output
5357                     ; 1617     invert_input = 0x00;			// Turn off output invert bit
5359  03b9 725f00f2      	clr	_invert_input
5360                     ; 1618     IO_16to9 = IO_16to9_new1 = IO_16to9_new2 = IO_16to9_sent = stored_IO_16to9 = 0x00;
5362  03bd 4f            	clr	a
5363  03be ae004b        	ldw	x,#_stored_IO_16to9
5364  03c1 cd0000        	call	c_eewrc
5366  03c4 725f00f5      	clr	_IO_16to9_sent
5367  03c8 725f00f7      	clr	_IO_16to9_new2
5368  03cc 725f00f9      	clr	_IO_16to9_new1
5369  03d0 725f00fb      	clr	_IO_16to9
5370                     ; 1619     IO_8to1  = IO_8to1_new1  = IO_8to1_new2  = IO_8to1_sent  = stored_IO_8to1  = 0x00;
5372  03d4 4f            	clr	a
5373  03d5 ae0014        	ldw	x,#_stored_IO_8to1
5374  03d8 cd0000        	call	c_eewrc
5376  03db 725f00f4      	clr	_IO_8to1_sent
5377  03df 725f00f6      	clr	_IO_8to1_new2
5378  03e3 725f00f8      	clr	_IO_8to1_new1
5379  03e7 725f00fa      	clr	_IO_8to1
5380                     ; 1620     write_output_registers();          // Set Relay Control outputs
5382  03eb cd0000        	call	_write_output_registers
5384                     ; 1623     magic4 = 0x55;		// MSB
5386  03ee a655          	ld	a,#85
5387  03f0 ae002e        	ldw	x,#_magic4
5388  03f3 cd0000        	call	c_eewrc
5390                     ; 1624     magic3 = 0xee;		//
5392  03f6 a6ee          	ld	a,#238
5393  03f8 ae002d        	ldw	x,#_magic3
5394  03fb cd0000        	call	c_eewrc
5396                     ; 1625     magic2 = 0x0f;		//
5398  03fe a60f          	ld	a,#15
5399  0400 ae002c        	ldw	x,#_magic2
5400  0403 cd0000        	call	c_eewrc
5402                     ; 1626     magic1 = 0xf0;		// LSB
5404  0406 a6f0          	ld	a,#240
5405  0408 ae002b        	ldw	x,#_magic1
5406  040b cd0000        	call	c_eewrc
5408  040e               L7552:
5409                     ; 1631   for (i=0; i<4; i++) {
5411  040e 4f            	clr	a
5412  040f 6b01          	ld	(OFST+0,sp),a
5414  0411               L3462:
5415                     ; 1632     Pending_hostaddr[i] = stored_hostaddr[i];
5417  0411 5f            	clrw	x
5418  0412 97            	ld	xl,a
5419  0413 d60027        	ld	a,(_stored_hostaddr,x)
5420  0416 d700d0        	ld	(_Pending_hostaddr,x),a
5421                     ; 1633     Pending_draddr[i] = stored_draddr[i];
5423  0419 5f            	clrw	x
5424  041a 7b01          	ld	a,(OFST+0,sp)
5425  041c 97            	ld	xl,a
5426  041d d60023        	ld	a,(_stored_draddr,x)
5427  0420 d700cc        	ld	(_Pending_draddr,x),a
5428                     ; 1634     Pending_netmask[i] = stored_netmask[i];
5430  0423 5f            	clrw	x
5431  0424 7b01          	ld	a,(OFST+0,sp)
5432  0426 97            	ld	xl,a
5433  0427 d6001f        	ld	a,(_stored_netmask,x)
5434  042a d700c8        	ld	(_Pending_netmask,x),a
5435                     ; 1631   for (i=0; i<4; i++) {
5437  042d 0c01          	inc	(OFST+0,sp)
5441  042f 7b01          	ld	a,(OFST+0,sp)
5442  0431 a104          	cp	a,#4
5443  0433 25dc          	jrult	L3462
5444                     ; 1637   Pending_port = stored_port;
5446  0435 ce001d        	ldw	x,_stored_port
5447  0438 cf00c6        	ldw	_Pending_port,x
5448                     ; 1639   for (i=0; i<20; i++) {
5450  043b 4f            	clr	a
5451  043c 6b01          	ld	(OFST+0,sp),a
5453  043e               L1562:
5454                     ; 1640     Pending_devicename[i] = stored_devicename[i];
5456  043e 5f            	clrw	x
5457  043f 97            	ld	xl,a
5458  0440 d60000        	ld	a,(_stored_devicename,x)
5459  0443 d700b2        	ld	(_Pending_devicename,x),a
5460                     ; 1639   for (i=0; i<20; i++) {
5462  0446 0c01          	inc	(OFST+0,sp)
5466  0448 7b01          	ld	a,(OFST+0,sp)
5467  044a a114          	cp	a,#20
5468  044c 25f0          	jrult	L1562
5469                     ; 1643   for (i=0; i<6; i++) {
5471  044e 4f            	clr	a
5472  044f 6b01          	ld	(OFST+0,sp),a
5474  0451               L7562:
5475                     ; 1644     Pending_config_settings[i] = stored_config_settings[i];
5477  0451 5f            	clrw	x
5478  0452 97            	ld	xl,a
5479  0453 d6004c        	ld	a,(_stored_config_settings,x)
5480  0456 d700ac        	ld	(_Pending_config_settings,x),a
5481                     ; 1645     Pending_uip_ethaddr_oct[i] = stored_uip_ethaddr_oct[i];
5483  0459 5f            	clrw	x
5484  045a 7b01          	ld	a,(OFST+0,sp)
5485  045c 97            	ld	xl,a
5486  045d d60017        	ld	a,(_stored_uip_ethaddr_oct,x)
5487  0460 d700a6        	ld	(_Pending_uip_ethaddr_oct,x),a
5488                     ; 1643   for (i=0; i<6; i++) {
5490  0463 0c01          	inc	(OFST+0,sp)
5494  0465 7b01          	ld	a,(OFST+0,sp)
5495  0467 a106          	cp	a,#6
5496  0469 25e6          	jrult	L7562
5497                     ; 1649   for (i=0; i<4; i++) {
5499  046b 4f            	clr	a
5500  046c 6b01          	ld	(OFST+0,sp),a
5502  046e               L5662:
5503                     ; 1650     Pending_mqttserveraddr[i] = stored_mqttserveraddr[i];
5505  046e 5f            	clrw	x
5506  046f 97            	ld	xl,a
5507  0470 d60031        	ld	a,(_stored_mqttserveraddr,x)
5508  0473 d700ec        	ld	(_Pending_mqttserveraddr,x),a
5509                     ; 1649   for (i=0; i<4; i++) {
5511  0476 0c01          	inc	(OFST+0,sp)
5515  0478 7b01          	ld	a,(OFST+0,sp)
5516  047a a104          	cp	a,#4
5517  047c 25f0          	jrult	L5662
5518                     ; 1652   Pending_mqttport = stored_mqttport;
5520  047e ce002f        	ldw	x,_stored_mqttport
5521  0481 cf00ea        	ldw	_Pending_mqttport,x
5522                     ; 1653   for (i=0; i<11; i++) {
5524  0484 4f            	clr	a
5525  0485 6b01          	ld	(OFST+0,sp),a
5527  0487               L3762:
5528                     ; 1654     Pending_mqtt_username[i] = stored_mqtt_username[i];
5530  0487 5f            	clrw	x
5531  0488 97            	ld	xl,a
5532  0489 d60035        	ld	a,(_stored_mqtt_username,x)
5533  048c d700df        	ld	(_Pending_mqtt_username,x),a
5534                     ; 1655     Pending_mqtt_password[i] = stored_mqtt_password[i];
5536  048f 5f            	clrw	x
5537  0490 7b01          	ld	a,(OFST+0,sp)
5538  0492 97            	ld	xl,a
5539  0493 d60040        	ld	a,(_stored_mqtt_password,x)
5540  0496 d700d4        	ld	(_Pending_mqtt_password,x),a
5541                     ; 1653   for (i=0; i<11; i++) {
5543  0499 0c01          	inc	(OFST+0,sp)
5547  049b 7b01          	ld	a,(OFST+0,sp)
5548  049d a10b          	cp	a,#11
5549  049f 25e6          	jrult	L3762
5550                     ; 1658   strcat(topic_base, stored_devicename);
5552  04a1 ae0000        	ldw	x,#_stored_devicename
5553  04a4 89            	pushw	x
5554  04a5 ae0001        	ldw	x,#_topic_base
5555  04a8 cd0000        	call	_strcat
5557  04ab 85            	popw	x
5558                     ; 1661   topic_base_len = (uint8_t)strlen(topic_base);
5560  04ac ae0001        	ldw	x,#_topic_base
5561  04af cd0000        	call	_strlen
5563  04b2 9f            	ld	a,xl
5564  04b3 c70000        	ld	_topic_base_len,a
5565                     ; 1665   update_mac_string();
5567  04b6 cd0000        	call	_update_mac_string
5569                     ; 1667 }
5572  04b9 84            	pop	a
5573  04ba 81            	ret	
5616                     ; 1670 void update_mac_string(void) {
5617                     .text:	section	.text,new
5618  0000               _update_mac_string:
5620  0000 89            	pushw	x
5621       00000002      OFST:	set	2
5624                     ; 1676   i = 5;
5626  0001 a605          	ld	a,#5
5627  0003 6b01          	ld	(OFST-1,sp),a
5629                     ; 1677   j = 0;
5631  0005 0f02          	clr	(OFST+0,sp)
5633  0007               L7172:
5634                     ; 1679     emb_itoa(stored_uip_ethaddr_oct[i], OctetArray, 16, 2);
5636  0007 4b02          	push	#2
5637  0009 4b10          	push	#16
5638  000b ae0000        	ldw	x,#_OctetArray
5639  000e 89            	pushw	x
5640  000f 7b05          	ld	a,(OFST+3,sp)
5641  0011 5f            	clrw	x
5642  0012 97            	ld	xl,a
5643  0013 d60017        	ld	a,(_stored_uip_ethaddr_oct,x)
5644  0016 b703          	ld	c_lreg+3,a
5645  0018 3f02          	clr	c_lreg+2
5646  001a 3f01          	clr	c_lreg+1
5647  001c 3f00          	clr	c_lreg
5648  001e be02          	ldw	x,c_lreg+2
5649  0020 89            	pushw	x
5650  0021 be00          	ldw	x,c_lreg
5651  0023 89            	pushw	x
5652  0024 cd0000        	call	_emb_itoa
5654  0027 5b08          	addw	sp,#8
5655                     ; 1680     mac_string[j++] = OctetArray[0];
5657  0029 7b02          	ld	a,(OFST+0,sp)
5658  002b 0c02          	inc	(OFST+0,sp)
5660  002d 5f            	clrw	x
5661  002e 97            	ld	xl,a
5662  002f c60000        	ld	a,_OctetArray
5663  0032 d70099        	ld	(_mac_string,x),a
5664                     ; 1681     mac_string[j++] = OctetArray[1];
5666  0035 7b02          	ld	a,(OFST+0,sp)
5667  0037 0c02          	inc	(OFST+0,sp)
5669  0039 5f            	clrw	x
5670  003a 97            	ld	xl,a
5671  003b c60001        	ld	a,_OctetArray+1
5672  003e d70099        	ld	(_mac_string,x),a
5673                     ; 1682     i--;
5675  0041 0a01          	dec	(OFST-1,sp)
5677                     ; 1678   while (j<12) {
5679  0043 7b02          	ld	a,(OFST+0,sp)
5680  0045 a10c          	cp	a,#12
5681  0047 25be          	jrult	L7172
5682                     ; 1684   mac_string[12] = '\0';
5684  0049 725f00a5      	clr	_mac_string+12
5685                     ; 1685 }
5688  004d 85            	popw	x
5689  004e 81            	ret	
5767                     ; 1688 void check_runtime_changes(void)
5767                     ; 1689 {
5768                     .text:	section	.text,new
5769  0000               _check_runtime_changes:
5771  0000 88            	push	a
5772       00000001      OFST:	set	1
5775                     ; 1702   read_input_registers();
5777  0001 cd0000        	call	_read_input_registers
5779                     ; 1704   if (parse_complete == 1 || mqtt_parse_complete == 1) {
5781  0004 c60093        	ld	a,_parse_complete
5782  0007 4a            	dec	a
5783  0008 2706          	jreq	L3472
5785  000a c60092        	ld	a,_mqtt_parse_complete
5786  000d 4a            	dec	a
5787  000e 2624          	jrne	L1472
5788  0010               L3472:
5789                     ; 1728     if (stored_IO_8to1 != IO_8to1) {
5791  0010 c60014        	ld	a,_stored_IO_8to1
5792  0013 c100fa        	cp	a,_IO_8to1
5793  0016 2713          	jreq	L5472
5794                     ; 1732       if (stored_config_settings[2] == '2') {
5796  0018 c6004e        	ld	a,_stored_config_settings+2
5797  001b a132          	cp	a,#50
5798  001d 2609          	jrne	L7472
5799                     ; 1733         stored_IO_8to1 = IO_8to1;
5801  001f c600fa        	ld	a,_IO_8to1
5802  0022 ae0014        	ldw	x,#_stored_IO_8to1
5803  0025 cd0000        	call	c_eewrc
5805  0028               L7472:
5806                     ; 1737       write_output_registers();
5808  0028 cd0000        	call	_write_output_registers
5810  002b               L5472:
5811                     ; 1744     if (mqtt_parse_complete == 1) {
5813  002b c60092        	ld	a,_mqtt_parse_complete
5814  002e 4a            	dec	a
5815  002f 2603          	jrne	L1472
5816                     ; 1746       mqtt_parse_complete = 0;
5818  0031 c70092        	ld	_mqtt_parse_complete,a
5819  0034               L1472:
5820                     ; 1751   if (parse_complete == 1) {
5822  0034 c60093        	ld	a,_parse_complete
5823  0037 4a            	dec	a
5824  0038 2703cc02c5    	jrne	L3572
5825                     ; 1792     if ((Pending_config_settings[0] != stored_config_settings[0])
5825                     ; 1793      || (stored_IO_8to1 != IO_8to1)) {
5827  003d c6004c        	ld	a,_stored_config_settings
5828  0040 c100ac        	cp	a,_Pending_config_settings
5829  0043 2608          	jrne	L7572
5831  0045 c60014        	ld	a,_stored_IO_8to1
5832  0048 c100fa        	cp	a,_IO_8to1
5833  004b 272d          	jreq	L5572
5834  004d               L7572:
5835                     ; 1796       stored_config_settings[0] = Pending_config_settings[0];
5837  004d c600ac        	ld	a,_Pending_config_settings
5838  0050 ae004c        	ldw	x,#_stored_config_settings
5839  0053 cd0000        	call	c_eewrc
5841                     ; 1799       if (stored_config_settings[0] == '0') invert_output = 0x00;
5843  0056 c6004c        	ld	a,_stored_config_settings
5844  0059 a130          	cp	a,#48
5845  005b 2606          	jrne	L1672
5848  005d 725f00f3      	clr	_invert_output
5850  0061 2004          	jra	L3672
5851  0063               L1672:
5852                     ; 1800       else invert_output = 0xff;
5854  0063 35ff00f3      	mov	_invert_output,#255
5855  0067               L3672:
5856                     ; 1804       if (stored_config_settings[2] == '2') {
5858  0067 c6004e        	ld	a,_stored_config_settings+2
5859  006a a132          	cp	a,#50
5860  006c 2609          	jrne	L5672
5861                     ; 1805         stored_IO_8to1 = IO_8to1;
5863  006e c600fa        	ld	a,_IO_8to1
5864  0071 ae0014        	ldw	x,#_stored_IO_8to1
5865  0074 cd0000        	call	c_eewrc
5867  0077               L5672:
5868                     ; 1809       write_output_registers();
5870  0077 cd0000        	call	_write_output_registers
5872  007a               L5572:
5873                     ; 1813     if (Pending_config_settings[1] != stored_config_settings[1]) {
5875  007a c6004d        	ld	a,_stored_config_settings+1
5876  007d c100ad        	cp	a,_Pending_config_settings+1
5877  0080 271e          	jreq	L7672
5878                     ; 1815       stored_config_settings[1] = Pending_config_settings[1];
5880  0082 c600ad        	ld	a,_Pending_config_settings+1
5881  0085 ae004d        	ldw	x,#_stored_config_settings+1
5882  0088 cd0000        	call	c_eewrc
5884                     ; 1818       if (stored_config_settings[1] == '0') invert_input = 0x00;
5886  008b c6004d        	ld	a,_stored_config_settings+1
5887  008e a130          	cp	a,#48
5888  0090 2606          	jrne	L1772
5891  0092 725f00f2      	clr	_invert_input
5893  0096 2004          	jra	L3772
5894  0098               L1772:
5895                     ; 1819       else invert_input = 0xff;
5897  0098 35ff00f2      	mov	_invert_input,#255
5898  009c               L3772:
5899                     ; 1823       restart_request = 1;
5901  009c 35010096      	mov	_restart_request,#1
5902  00a0               L7672:
5903                     ; 1857     if (Pending_config_settings[2] != stored_config_settings[2]) {
5905  00a0 c6004e        	ld	a,_stored_config_settings+2
5906  00a3 c100ae        	cp	a,_Pending_config_settings+2
5907  00a6 2709          	jreq	L5772
5908                     ; 1859       stored_config_settings[2] = Pending_config_settings[2];
5910  00a8 c600ae        	ld	a,_Pending_config_settings+2
5911  00ab ae004e        	ldw	x,#_stored_config_settings+2
5912  00ae cd0000        	call	c_eewrc
5914  00b1               L5772:
5915                     ; 1863     if (Pending_config_settings[3] != stored_config_settings[3]) {
5917  00b1 c6004f        	ld	a,_stored_config_settings+3
5918  00b4 c100af        	cp	a,_Pending_config_settings+3
5919  00b7 270d          	jreq	L7772
5920                     ; 1866       stored_config_settings[3] = Pending_config_settings[3];
5922  00b9 c600af        	ld	a,_Pending_config_settings+3
5923  00bc ae004f        	ldw	x,#_stored_config_settings+3
5924  00bf cd0000        	call	c_eewrc
5926                     ; 1868       user_reboot_request = 1;
5928  00c2 35010097      	mov	_user_reboot_request,#1
5929  00c6               L7772:
5930                     ; 1871     stored_config_settings[4] = Pending_config_settings[4];
5932  00c6 c600b0        	ld	a,_Pending_config_settings+4
5933  00c9 ae0050        	ldw	x,#_stored_config_settings+4
5934  00cc cd0000        	call	c_eewrc
5936                     ; 1872     stored_config_settings[5] = Pending_config_settings[5];
5938  00cf c600b1        	ld	a,_Pending_config_settings+5
5939  00d2 ae0051        	ldw	x,#_stored_config_settings+5
5940  00d5 cd0000        	call	c_eewrc
5942                     ; 1875     if (stored_hostaddr[3] != Pending_hostaddr[3] ||
5942                     ; 1876         stored_hostaddr[2] != Pending_hostaddr[2] ||
5942                     ; 1877         stored_hostaddr[1] != Pending_hostaddr[1] ||
5942                     ; 1878         stored_hostaddr[0] != Pending_hostaddr[0]) {
5944  00d8 c6002a        	ld	a,_stored_hostaddr+3
5945  00db c100d3        	cp	a,_Pending_hostaddr+3
5946  00de 2618          	jrne	L3003
5948  00e0 c60029        	ld	a,_stored_hostaddr+2
5949  00e3 c100d2        	cp	a,_Pending_hostaddr+2
5950  00e6 2610          	jrne	L3003
5952  00e8 c60028        	ld	a,_stored_hostaddr+1
5953  00eb c100d1        	cp	a,_Pending_hostaddr+1
5954  00ee 2608          	jrne	L3003
5956  00f0 c60027        	ld	a,_stored_hostaddr
5957  00f3 c100d0        	cp	a,_Pending_hostaddr
5958  00f6 2713          	jreq	L1003
5959  00f8               L3003:
5960                     ; 1880       for (i=0; i<4; i++) stored_hostaddr[i] = Pending_hostaddr[i];
5962  00f8 4f            	clr	a
5963  00f9 6b01          	ld	(OFST+0,sp),a
5965  00fb               L1103:
5968  00fb 5f            	clrw	x
5969  00fc 97            	ld	xl,a
5970  00fd d600d0        	ld	a,(_Pending_hostaddr,x)
5971  0100 d70027        	ld	(_stored_hostaddr,x),a
5974  0103 0c01          	inc	(OFST+0,sp)
5978  0105 7b01          	ld	a,(OFST+0,sp)
5979  0107 a104          	cp	a,#4
5980  0109 25f0          	jrult	L1103
5981  010b               L1003:
5982                     ; 1884     if (stored_draddr[3] != Pending_draddr[3] ||
5982                     ; 1885         stored_draddr[2] != Pending_draddr[2] ||
5982                     ; 1886         stored_draddr[1] != Pending_draddr[1] ||
5982                     ; 1887         stored_draddr[0] != Pending_draddr[0]) {
5984  010b c60026        	ld	a,_stored_draddr+3
5985  010e c100cf        	cp	a,_Pending_draddr+3
5986  0111 2618          	jrne	L1203
5988  0113 c60025        	ld	a,_stored_draddr+2
5989  0116 c100ce        	cp	a,_Pending_draddr+2
5990  0119 2610          	jrne	L1203
5992  011b c60024        	ld	a,_stored_draddr+1
5993  011e c100cd        	cp	a,_Pending_draddr+1
5994  0121 2608          	jrne	L1203
5996  0123 c60023        	ld	a,_stored_draddr
5997  0126 c100cc        	cp	a,_Pending_draddr
5998  0129 2717          	jreq	L7103
5999  012b               L1203:
6000                     ; 1889       for (i=0; i<4; i++) stored_draddr[i] = Pending_draddr[i];
6002  012b 4f            	clr	a
6003  012c 6b01          	ld	(OFST+0,sp),a
6005  012e               L7203:
6008  012e 5f            	clrw	x
6009  012f 97            	ld	xl,a
6010  0130 d600cc        	ld	a,(_Pending_draddr,x)
6011  0133 d70023        	ld	(_stored_draddr,x),a
6014  0136 0c01          	inc	(OFST+0,sp)
6018  0138 7b01          	ld	a,(OFST+0,sp)
6019  013a a104          	cp	a,#4
6020  013c 25f0          	jrult	L7203
6021                     ; 1890       restart_request = 1;
6023  013e 35010096      	mov	_restart_request,#1
6024  0142               L7103:
6025                     ; 1894     if (stored_netmask[3] != Pending_netmask[3] ||
6025                     ; 1895         stored_netmask[2] != Pending_netmask[2] ||
6025                     ; 1896         stored_netmask[1] != Pending_netmask[1] ||
6025                     ; 1897         stored_netmask[0] != Pending_netmask[0]) {
6027  0142 c60022        	ld	a,_stored_netmask+3
6028  0145 c100cb        	cp	a,_Pending_netmask+3
6029  0148 2618          	jrne	L7303
6031  014a c60021        	ld	a,_stored_netmask+2
6032  014d c100ca        	cp	a,_Pending_netmask+2
6033  0150 2610          	jrne	L7303
6035  0152 c60020        	ld	a,_stored_netmask+1
6036  0155 c100c9        	cp	a,_Pending_netmask+1
6037  0158 2608          	jrne	L7303
6039  015a c6001f        	ld	a,_stored_netmask
6040  015d c100c8        	cp	a,_Pending_netmask
6041  0160 2717          	jreq	L5303
6042  0162               L7303:
6043                     ; 1899       for (i=0; i<4; i++) stored_netmask[i] = Pending_netmask[i];
6045  0162 4f            	clr	a
6046  0163 6b01          	ld	(OFST+0,sp),a
6048  0165               L5403:
6051  0165 5f            	clrw	x
6052  0166 97            	ld	xl,a
6053  0167 d600c8        	ld	a,(_Pending_netmask,x)
6054  016a d7001f        	ld	(_stored_netmask,x),a
6057  016d 0c01          	inc	(OFST+0,sp)
6061  016f 7b01          	ld	a,(OFST+0,sp)
6062  0171 a104          	cp	a,#4
6063  0173 25f0          	jrult	L5403
6064                     ; 1900       restart_request = 1;
6066  0175 35010096      	mov	_restart_request,#1
6067  0179               L5303:
6068                     ; 1904     if (stored_port != Pending_port) {
6070  0179 ce001d        	ldw	x,_stored_port
6071  017c c300c6        	cpw	x,_Pending_port
6072  017f 270f          	jreq	L3503
6073                     ; 1906       stored_port = Pending_port;
6075  0181 ce00c6        	ldw	x,_Pending_port
6076  0184 89            	pushw	x
6077  0185 ae001d        	ldw	x,#_stored_port
6078  0188 cd0000        	call	c_eewrw
6080  018b 35010096      	mov	_restart_request,#1
6081  018f 85            	popw	x
6082                     ; 1908       restart_request = 1;
6084  0190               L3503:
6085                     ; 1912     for(i=0; i<20; i++) {
6087  0190 4f            	clr	a
6088  0191 6b01          	ld	(OFST+0,sp),a
6090  0193               L5503:
6091                     ; 1913       if (stored_devicename[i] != Pending_devicename[i]) {
6093  0193 5f            	clrw	x
6094  0194 97            	ld	xl,a
6095  0195 905f          	clrw	y
6096  0197 9097          	ld	yl,a
6097  0199 90d60000      	ld	a,(_stored_devicename,y)
6098  019d d100b2        	cp	a,(_Pending_devicename,x)
6099  01a0 270e          	jreq	L3603
6100                     ; 1914         stored_devicename[i] = Pending_devicename[i];
6102  01a2 7b01          	ld	a,(OFST+0,sp)
6103  01a4 5f            	clrw	x
6104  01a5 97            	ld	xl,a
6105  01a6 d600b2        	ld	a,(_Pending_devicename,x)
6106  01a9 d70000        	ld	(_stored_devicename,x),a
6107                     ; 1920         restart_request = 1;
6109  01ac 35010096      	mov	_restart_request,#1
6110  01b0               L3603:
6111                     ; 1912     for(i=0; i<20; i++) {
6113  01b0 0c01          	inc	(OFST+0,sp)
6117  01b2 7b01          	ld	a,(OFST+0,sp)
6118  01b4 a114          	cp	a,#20
6119  01b6 25db          	jrult	L5503
6120                     ; 1927     strcpy(topic_base, devicetype);
6122  01b8 ae0001        	ldw	x,#_topic_base
6123  01bb 90ae0000      	ldw	y,#L5261_devicetype
6124  01bf               L403:
6125  01bf 90f6          	ld	a,(y)
6126  01c1 905c          	incw	y
6127  01c3 f7            	ld	(x),a
6128  01c4 5c            	incw	x
6129  01c5 4d            	tnz	a
6130  01c6 26f7          	jrne	L403
6131                     ; 1928     strcat(topic_base, stored_devicename);
6133  01c8 ae0000        	ldw	x,#_stored_devicename
6134  01cb 89            	pushw	x
6135  01cc ae0001        	ldw	x,#_topic_base
6136  01cf cd0000        	call	_strcat
6138  01d2 85            	popw	x
6139                     ; 1929     topic_base_len = (uint8_t)strlen(topic_base);
6141  01d3 ae0001        	ldw	x,#_topic_base
6142  01d6 cd0000        	call	_strlen
6144  01d9 9f            	ld	a,xl
6145  01da c70000        	ld	_topic_base_len,a
6146                     ; 1932     if (stored_mqttserveraddr[3] != Pending_mqttserveraddr[3] ||
6146                     ; 1933         stored_mqttserveraddr[2] != Pending_mqttserveraddr[2] ||
6146                     ; 1934         stored_mqttserveraddr[1] != Pending_mqttserveraddr[1] ||
6146                     ; 1935         stored_mqttserveraddr[0] != Pending_mqttserveraddr[0]) {
6148  01dd c60034        	ld	a,_stored_mqttserveraddr+3
6149  01e0 c100ef        	cp	a,_Pending_mqttserveraddr+3
6150  01e3 2618          	jrne	L7603
6152  01e5 c60033        	ld	a,_stored_mqttserveraddr+2
6153  01e8 c100ee        	cp	a,_Pending_mqttserveraddr+2
6154  01eb 2610          	jrne	L7603
6156  01ed c60032        	ld	a,_stored_mqttserveraddr+1
6157  01f0 c100ed        	cp	a,_Pending_mqttserveraddr+1
6158  01f3 2608          	jrne	L7603
6160  01f5 c60031        	ld	a,_stored_mqttserveraddr
6161  01f8 c100ec        	cp	a,_Pending_mqttserveraddr
6162  01fb 2717          	jreq	L5603
6163  01fd               L7603:
6164                     ; 1937       for (i=0; i<4; i++) stored_mqttserveraddr[i] = Pending_mqttserveraddr[i];
6166  01fd 4f            	clr	a
6167  01fe 6b01          	ld	(OFST+0,sp),a
6169  0200               L5703:
6172  0200 5f            	clrw	x
6173  0201 97            	ld	xl,a
6174  0202 d600ec        	ld	a,(_Pending_mqttserveraddr,x)
6175  0205 d70031        	ld	(_stored_mqttserveraddr,x),a
6178  0208 0c01          	inc	(OFST+0,sp)
6182  020a 7b01          	ld	a,(OFST+0,sp)
6183  020c a104          	cp	a,#4
6184  020e 25f0          	jrult	L5703
6185                     ; 1939       restart_request = 1;
6187  0210 35010096      	mov	_restart_request,#1
6188  0214               L5603:
6189                     ; 1943     if (stored_mqttport != Pending_mqttport) {
6191  0214 ce002f        	ldw	x,_stored_mqttport
6192  0217 c300ea        	cpw	x,_Pending_mqttport
6193  021a 270f          	jreq	L3013
6194                     ; 1945       stored_mqttport = Pending_mqttport;
6196  021c ce00ea        	ldw	x,_Pending_mqttport
6197  021f 89            	pushw	x
6198  0220 ae002f        	ldw	x,#_stored_mqttport
6199  0223 cd0000        	call	c_eewrw
6201  0226 35010096      	mov	_restart_request,#1
6202  022a 85            	popw	x
6203                     ; 1947       restart_request = 1;
6205  022b               L3013:
6206                     ; 1951     for(i=0; i<11; i++) {
6208  022b 4f            	clr	a
6209  022c 6b01          	ld	(OFST+0,sp),a
6211  022e               L5013:
6212                     ; 1952       if (stored_mqtt_username[i] != Pending_mqtt_username[i]) {
6214  022e 5f            	clrw	x
6215  022f 97            	ld	xl,a
6216  0230 905f          	clrw	y
6217  0232 9097          	ld	yl,a
6218  0234 90d60035      	ld	a,(_stored_mqtt_username,y)
6219  0238 d100df        	cp	a,(_Pending_mqtt_username,x)
6220  023b 270e          	jreq	L3113
6221                     ; 1953         stored_mqtt_username[i] = Pending_mqtt_username[i];
6223  023d 7b01          	ld	a,(OFST+0,sp)
6224  023f 5f            	clrw	x
6225  0240 97            	ld	xl,a
6226  0241 d600df        	ld	a,(_Pending_mqtt_username,x)
6227  0244 d70035        	ld	(_stored_mqtt_username,x),a
6228                     ; 1955         restart_request = 1;
6230  0247 35010096      	mov	_restart_request,#1
6231  024b               L3113:
6232                     ; 1951     for(i=0; i<11; i++) {
6234  024b 0c01          	inc	(OFST+0,sp)
6238  024d 7b01          	ld	a,(OFST+0,sp)
6239  024f a10b          	cp	a,#11
6240  0251 25db          	jrult	L5013
6241                     ; 1960     for(i=0; i<11; i++) {
6243  0253 4f            	clr	a
6244  0254 6b01          	ld	(OFST+0,sp),a
6246  0256               L5113:
6247                     ; 1961       if (stored_mqtt_password[i] != Pending_mqtt_password[i]) {
6249  0256 5f            	clrw	x
6250  0257 97            	ld	xl,a
6251  0258 905f          	clrw	y
6252  025a 9097          	ld	yl,a
6253  025c 90d60040      	ld	a,(_stored_mqtt_password,y)
6254  0260 d100d4        	cp	a,(_Pending_mqtt_password,x)
6255  0263 270e          	jreq	L3213
6256                     ; 1962         stored_mqtt_password[i] = Pending_mqtt_password[i];
6258  0265 7b01          	ld	a,(OFST+0,sp)
6259  0267 5f            	clrw	x
6260  0268 97            	ld	xl,a
6261  0269 d600d4        	ld	a,(_Pending_mqtt_password,x)
6262  026c d70040        	ld	(_stored_mqtt_password,x),a
6263                     ; 1964         restart_request = 1;
6265  026f 35010096      	mov	_restart_request,#1
6266  0273               L3213:
6267                     ; 1960     for(i=0; i<11; i++) {
6269  0273 0c01          	inc	(OFST+0,sp)
6273  0275 7b01          	ld	a,(OFST+0,sp)
6274  0277 a10b          	cp	a,#11
6275  0279 25db          	jrult	L5113
6276                     ; 1970     if (stored_uip_ethaddr_oct[0] != Pending_uip_ethaddr_oct[0] ||
6276                     ; 1971       stored_uip_ethaddr_oct[1] != Pending_uip_ethaddr_oct[1] ||
6276                     ; 1972       stored_uip_ethaddr_oct[2] != Pending_uip_ethaddr_oct[2] ||
6276                     ; 1973       stored_uip_ethaddr_oct[3] != Pending_uip_ethaddr_oct[3] ||
6276                     ; 1974       stored_uip_ethaddr_oct[4] != Pending_uip_ethaddr_oct[4] ||
6276                     ; 1975       stored_uip_ethaddr_oct[5] != Pending_uip_ethaddr_oct[5]) {
6278  027b c60017        	ld	a,_stored_uip_ethaddr_oct
6279  027e c100a6        	cp	a,_Pending_uip_ethaddr_oct
6280  0281 2628          	jrne	L7213
6282  0283 c60018        	ld	a,_stored_uip_ethaddr_oct+1
6283  0286 c100a7        	cp	a,_Pending_uip_ethaddr_oct+1
6284  0289 2620          	jrne	L7213
6286  028b c60019        	ld	a,_stored_uip_ethaddr_oct+2
6287  028e c100a8        	cp	a,_Pending_uip_ethaddr_oct+2
6288  0291 2618          	jrne	L7213
6290  0293 c6001a        	ld	a,_stored_uip_ethaddr_oct+3
6291  0296 c100a9        	cp	a,_Pending_uip_ethaddr_oct+3
6292  0299 2610          	jrne	L7213
6294  029b c6001b        	ld	a,_stored_uip_ethaddr_oct+4
6295  029e c100aa        	cp	a,_Pending_uip_ethaddr_oct+4
6296  02a1 2608          	jrne	L7213
6298  02a3 c6001c        	ld	a,_stored_uip_ethaddr_oct+5
6299  02a6 c100ab        	cp	a,_Pending_uip_ethaddr_oct+5
6300  02a9 271a          	jreq	L3572
6301  02ab               L7213:
6302                     ; 1977       for (i=0; i<6; i++) stored_uip_ethaddr_oct[i] = Pending_uip_ethaddr_oct[i];
6304  02ab 4f            	clr	a
6305  02ac 6b01          	ld	(OFST+0,sp),a
6307  02ae               L1413:
6310  02ae 5f            	clrw	x
6311  02af 97            	ld	xl,a
6312  02b0 d600a6        	ld	a,(_Pending_uip_ethaddr_oct,x)
6313  02b3 d70017        	ld	(_stored_uip_ethaddr_oct,x),a
6316  02b6 0c01          	inc	(OFST+0,sp)
6320  02b8 7b01          	ld	a,(OFST+0,sp)
6321  02ba a106          	cp	a,#6
6322  02bc 25f0          	jrult	L1413
6323                     ; 1979       update_mac_string();
6325  02be cd0000        	call	_update_mac_string
6327                     ; 1981       restart_request = 1;
6329  02c1 35010096      	mov	_restart_request,#1
6330  02c5               L3572:
6331                     ; 1985   if (restart_request == 1) {
6333  02c5 c60096        	ld	a,_restart_request
6334  02c8 4a            	dec	a
6335  02c9 2609          	jrne	L7413
6336                     ; 1988     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
6338  02cb c60095        	ld	a,_restart_reboot_step
6339  02ce 2604          	jrne	L7413
6340                     ; 1989       restart_reboot_step = RESTART_REBOOT_ARM;
6342  02d0 35010095      	mov	_restart_reboot_step,#1
6343  02d4               L7413:
6344                     ; 1993   if (user_reboot_request == 1) {
6346  02d4 c60097        	ld	a,_user_reboot_request
6347  02d7 4a            	dec	a
6348  02d8 2611          	jrne	L3513
6349                     ; 1996     if (restart_reboot_step == RESTART_REBOOT_IDLE) {
6351  02da 725d0095      	tnz	_restart_reboot_step
6352  02de 260b          	jrne	L3513
6353                     ; 1997       restart_reboot_step = RESTART_REBOOT_ARM;
6355  02e0 35010095      	mov	_restart_reboot_step,#1
6356                     ; 1998       user_reboot_request = 0;
6358  02e4 c70097        	ld	_user_reboot_request,a
6359                     ; 1999       reboot_request = 1;
6361  02e7 35010098      	mov	_reboot_request,#1
6362  02eb               L3513:
6363                     ; 2008   parse_complete = 0; // Reset parse_complete for future changes
6365  02eb 725f0093      	clr	_parse_complete
6366                     ; 2011   if (stack_limit1 != 0xaa || stack_limit2 != 0x55) {
6368  02ef c60001        	ld	a,_stack_limit1
6369  02f2 a1aa          	cp	a,#170
6370  02f4 2607          	jrne	L1613
6372  02f6 c60000        	ld	a,_stack_limit2
6373  02f9 a155          	cp	a,#85
6374  02fb 270a          	jreq	L7513
6375  02fd               L1613:
6376                     ; 2012     stack_error = 1;
6378  02fd 350100f0      	mov	_stack_error,#1
6379                     ; 2013     fastflash();
6381  0301 cd0000        	call	_fastflash
6383                     ; 2014     fastflash();
6385  0304 cd0000        	call	_fastflash
6387  0307               L7513:
6388                     ; 2027 }
6391  0307 84            	pop	a
6392  0308 81            	ret	
6427                     ; 2030 void check_restart_reboot(void)
6427                     ; 2031 {
6428                     .text:	section	.text,new
6429  0000               _check_restart_reboot:
6433                     ; 2037   if (restart_request == 1 || reboot_request == 1) {
6435  0000 c60096        	ld	a,_restart_request
6436  0003 4a            	dec	a
6437  0004 2709          	jreq	L5713
6439  0006 c60098        	ld	a,_reboot_request
6440  0009 4a            	dec	a
6441  000a 2703cc00d4    	jrne	L3713
6442  000f               L5713:
6443                     ; 2048     if (restart_reboot_step == RESTART_REBOOT_ARM) {
6445  000f c60095        	ld	a,_restart_reboot_step
6446  0012 a101          	cp	a,#1
6447  0014 2611          	jrne	L7713
6448                     ; 2053       time_mark2 = second_counter;
6450  0016 ce0002        	ldw	x,_second_counter+2
6451  0019 cf008a        	ldw	_time_mark2+2,x
6452  001c ce0000        	ldw	x,_second_counter
6453  001f cf0088        	ldw	_time_mark2,x
6454                     ; 2054       restart_reboot_step = RESTART_REBOOT_ARM2;
6456  0022 35020095      	mov	_restart_reboot_step,#2
6459  0026 81            	ret	
6460  0027               L7713:
6461                     ; 2057     else if (restart_reboot_step == RESTART_REBOOT_ARM2) {
6463  0027 a102          	cp	a,#2
6464  0029 2613          	jrne	L3023
6465                     ; 2063       if (second_counter > time_mark2 + 0 ) {
6467  002b ae0000        	ldw	x,#_second_counter
6468  002e cd0000        	call	c_ltor
6470  0031 ae0088        	ldw	x,#_time_mark2
6471  0034 cd0000        	call	c_lcmp
6473  0037 23d3          	jrule	L3713
6474                     ; 2064         restart_reboot_step = RESTART_REBOOT_DISCONNECT;
6476  0039 35030095      	mov	_restart_reboot_step,#3
6478  003d 81            	ret	
6479  003e               L3023:
6480                     ; 2069     else if (restart_reboot_step == RESTART_REBOOT_DISCONNECT) {
6482  003e a103          	cp	a,#3
6483  0040 261e          	jrne	L1123
6484                     ; 2070       restart_reboot_step = RESTART_REBOOT_DISCONNECTWAIT;
6486  0042 35040095      	mov	_restart_reboot_step,#4
6487                     ; 2071       if (mqtt_start == MQTT_START_COMPLETE) {
6489  0046 c60035        	ld	a,_mqtt_start
6490  0049 a114          	cp	a,#20
6491  004b 2606          	jrne	L3123
6492                     ; 2073         mqtt_disconnect(&mqttclient);
6494  004d ae0052        	ldw	x,#_mqttclient
6495  0050 cd0000        	call	_mqtt_disconnect
6497  0053               L3123:
6498                     ; 2076       time_mark2 = second_counter;
6500  0053 ce0002        	ldw	x,_second_counter+2
6501  0056 cf008a        	ldw	_time_mark2+2,x
6502  0059 ce0000        	ldw	x,_second_counter
6503  005c cf0088        	ldw	_time_mark2,x
6506  005f 81            	ret	
6507  0060               L1123:
6508                     ; 2079     else if (restart_reboot_step == RESTART_REBOOT_DISCONNECTWAIT) {
6510  0060 a104          	cp	a,#4
6511  0062 2618          	jrne	L7123
6512                     ; 2080       if (second_counter > time_mark2 + 1 ) {
6514  0064 ae0088        	ldw	x,#_time_mark2
6515  0067 cd0000        	call	c_ltor
6517  006a a601          	ld	a,#1
6518  006c cd0000        	call	c_ladc
6520  006f ae0000        	ldw	x,#_second_counter
6521  0072 cd0000        	call	c_lcmp
6523  0075 245d          	jruge	L3713
6524                     ; 2083         restart_reboot_step = RESTART_REBOOT_TCPCLOSE;
6526  0077 35050095      	mov	_restart_reboot_step,#5
6528  007b 81            	ret	
6529  007c               L7123:
6530                     ; 2087     else if (restart_reboot_step == RESTART_REBOOT_TCPCLOSE) {
6532  007c a105          	cp	a,#5
6533  007e 2615          	jrne	L5223
6534                     ; 2103       mqtt_close_tcp = 1;
6536  0080 35010094      	mov	_mqtt_close_tcp,#1
6537                     ; 2105       time_mark2 = second_counter;
6539  0084 ce0002        	ldw	x,_second_counter+2
6540  0087 cf008a        	ldw	_time_mark2+2,x
6541  008a ce0000        	ldw	x,_second_counter
6542  008d cf0088        	ldw	_time_mark2,x
6543                     ; 2106       restart_reboot_step = RESTART_REBOOT_TCPWAIT;
6545  0090 35060095      	mov	_restart_reboot_step,#6
6548  0094 81            	ret	
6549  0095               L5223:
6550                     ; 2108     else if (restart_reboot_step == RESTART_REBOOT_TCPWAIT) {
6552  0095 a106          	cp	a,#6
6553  0097 261c          	jrne	L1323
6554                     ; 2113       if (second_counter > time_mark2 + 1) {
6556  0099 ae0088        	ldw	x,#_time_mark2
6557  009c cd0000        	call	c_ltor
6559  009f a601          	ld	a,#1
6560  00a1 cd0000        	call	c_ladc
6562  00a4 ae0000        	ldw	x,#_second_counter
6563  00a7 cd0000        	call	c_lcmp
6565  00aa 2428          	jruge	L3713
6566                     ; 2114 	mqtt_close_tcp = 0;
6568  00ac 725f0094      	clr	_mqtt_close_tcp
6569                     ; 2115         restart_reboot_step = RESTART_REBOOT_FINISH;
6571  00b0 35070095      	mov	_restart_reboot_step,#7
6573  00b4 81            	ret	
6574  00b5               L1323:
6575                     ; 2125     else if (restart_reboot_step == RESTART_REBOOT_FINISH) {
6577  00b5 a107          	cp	a,#7
6578  00b7 261b          	jrne	L3713
6579                     ; 2126       if (reboot_request == 1) {
6581  00b9 c60098        	ld	a,_reboot_request
6582  00bc 4a            	dec	a
6583  00bd 2606          	jrne	L1423
6584                     ; 2127         restart_reboot_step = RESTART_REBOOT_IDLE;
6586  00bf c70095        	ld	_restart_reboot_step,a
6587                     ; 2129         reboot();
6589  00c2 cd0000        	call	_reboot
6591  00c5               L1423:
6592                     ; 2131       if (restart_request == 1) {
6594  00c5 c60096        	ld	a,_restart_request
6595  00c8 4a            	dec	a
6596  00c9 2609          	jrne	L3713
6597                     ; 2132 	restart_request = 0;
6599  00cb c70096        	ld	_restart_request,a
6600                     ; 2133         restart_reboot_step = RESTART_REBOOT_IDLE;
6602  00ce c70095        	ld	_restart_reboot_step,a
6603                     ; 2135 	restart();
6605  00d1 cd0000        	call	_restart
6607  00d4               L3713:
6608                     ; 2139 }
6611  00d4 81            	ret	
6664                     ; 2142 void restart(void)
6664                     ; 2143 {
6665                     .text:	section	.text,new
6666  0000               _restart:
6670                     ; 2157   LEDcontrol(0); // Turn LED off
6672  0000 4f            	clr	a
6673  0001 cd0000        	call	_LEDcontrol
6675                     ; 2159   parse_complete = 0;
6677  0004 725f0093      	clr	_parse_complete
6678                     ; 2160   reboot_request = 0;
6680  0008 725f0098      	clr	_reboot_request
6681                     ; 2161   restart_request = 0;
6683  000c 725f0096      	clr	_restart_request
6684                     ; 2163   time_mark2 = 0;           // Time capture used in reboot
6686  0010 5f            	clrw	x
6687  0011 cf008a        	ldw	_time_mark2+2,x
6688  0014 cf0088        	ldw	_time_mark2,x
6689                     ; 2166   mqtt_close_tcp = 0;
6691  0017 725f0094      	clr	_mqtt_close_tcp
6692                     ; 2168   mqtt_start = MQTT_START_TCP_CONNECT;
6694  001b 35010035      	mov	_mqtt_start,#1
6695                     ; 2169   mqtt_start_status = MQTT_START_NOT_STARTED;
6697  001f 725f0034      	clr	_mqtt_start_status
6698                     ; 2170   mqtt_start_ctr1 = 0;
6700  0023 725f0033      	clr	_mqtt_start_ctr1
6701                     ; 2171   mqtt_sanity_ctr = 0;
6703  0027 725f0031      	clr	_mqtt_sanity_ctr
6704                     ; 2172   mqtt_start_retry = 0;
6706  002b 725f0030      	clr	_mqtt_start_retry
6707                     ; 2173   MQTT_error_status = 0;
6709  002f 725f0000      	clr	_MQTT_error_status
6710                     ; 2174   mqtt_restart_step = MQTT_RESTART_IDLE;
6712  0033 725f002d      	clr	_mqtt_restart_step
6713                     ; 2175   strcpy(topic_base, devicetype);
6715  0037 ae0001        	ldw	x,#_topic_base
6716  003a 90ae0000      	ldw	y,#L5261_devicetype
6717  003e               L433:
6718  003e 90f6          	ld	a,(y)
6719  0040 905c          	incw	y
6720  0042 f7            	ld	(x),a
6721  0043 5c            	incw	x
6722  0044 4d            	tnz	a
6723  0045 26f7          	jrne	L433
6724                     ; 2176   state_request = STATE_REQUEST_IDLE;
6726  0047 c700f1        	ld	_state_request,a
6727                     ; 2179   spi_init();              // Initialize the SPI bit bang interface to the
6729  004a cd0000        	call	_spi_init
6731                     ; 2181   unlock_eeprom();         // unlock the EEPROM so writes can be performed
6733  004d cd0000        	call	_unlock_eeprom
6735                     ; 2182   check_eeprom_settings(); // Verify EEPROM up to date
6737  0050 cd0000        	call	_check_eeprom_settings
6739                     ; 2183   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
6741  0053 cd0000        	call	_Enc28j60Init
6743                     ; 2184   uip_arp_init();          // Initialize the ARP module
6745  0056 cd0000        	call	_uip_arp_init
6747                     ; 2185   uip_init();              // Initialize uIP
6749  0059 cd0000        	call	_uip_init
6751                     ; 2186   HttpDInit();             // Initialize httpd; sets up listening ports
6753  005c cd0000        	call	_HttpDInit
6755                     ; 2190   mqtt_init(&mqttclient,
6755                     ; 2191             mqtt_sendbuf,
6755                     ; 2192 	    sizeof(mqtt_sendbuf),
6755                     ; 2193 	    &uip_buf[UIP_IPTCPH_LEN + UIP_LLH_LEN],
6755                     ; 2194 	    UIP_APPDATA_SIZE,
6755                     ; 2195 	    publish_callback);
6757  005f ae0000        	ldw	x,#_publish_callback
6758  0062 89            	pushw	x
6759  0063 ae01be        	ldw	x,#446
6760  0066 89            	pushw	x
6761  0067 ae0036        	ldw	x,#_uip_buf+54
6762  006a 89            	pushw	x
6763  006b ae00c8        	ldw	x,#200
6764  006e 89            	pushw	x
6765  006f ae0000        	ldw	x,#_mqtt_sendbuf
6766  0072 89            	pushw	x
6767  0073 ae0052        	ldw	x,#_mqttclient
6768  0076 cd0000        	call	_mqtt_init
6770  0079 5b0a          	addw	sp,#10
6771                     ; 2198   LEDcontrol(1); // Turn LED on
6773  007b a601          	ld	a,#1
6775                     ; 2201 }
6778  007d cc0000        	jp	_LEDcontrol
6806                     ; 2204 void reboot(void)
6806                     ; 2205 {
6807                     .text:	section	.text,new
6808  0000               _reboot:
6812                     ; 2208   fastflash(); // A useful signal that a deliberate reboot is occurring.
6814  0000 cd0000        	call	_fastflash
6816                     ; 2210   LEDcontrol(0);  // turn LED off
6818  0003 4f            	clr	a
6819  0004 cd0000        	call	_LEDcontrol
6821                     ; 2212   WWDG_WR = (uint8_t)0x7f;     // Window register reset
6823  0007 357f50d2      	mov	_WWDG_WR,#127
6824                     ; 2213   WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
6826  000b 35ff50d1      	mov	_WWDG_CR,#255
6827                     ; 2214   WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
6829  000f 356050d2      	mov	_WWDG_WR,#96
6830                     ; 2217   wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
6832  0013 aec350        	ldw	x,#50000
6833  0016 cd0000        	call	_wait_timer
6835                     ; 2218   wait_timer((uint16_t)50000);
6837  0019 aec350        	ldw	x,#50000
6838  001c cd0000        	call	_wait_timer
6840                     ; 2219   wait_timer((uint16_t)50000);
6842  001f aec350        	ldw	x,#50000
6844                     ; 2220 }
6847  0022 cc0000        	jp	_wait_timer
6888                     ; 2223 void read_input_registers(void)
6888                     ; 2224 {
6889                     .text:	section	.text,new
6890  0000               _read_input_registers:
6892  0000 89            	pushw	x
6893       00000002      OFST:	set	2
6896                     ; 2241   if (PC_IDR & (uint8_t)0x40) IO_16to9_new1 |= 0x80; // PC bit 6 = 1, Input 8 = 1
6898  0001 720d500b06    	btjf	_PC_IDR,#6,L1033
6901  0006 721e00f9      	bset	_IO_16to9_new1,#7
6903  000a 2004          	jra	L3033
6904  000c               L1033:
6905                     ; 2242   else IO_16to9_new1 &= (uint8_t)(~0x80);
6907  000c 721f00f9      	bres	_IO_16to9_new1,#7
6908  0010               L3033:
6909                     ; 2243   if (PG_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x40; // PG bit 0 = 1, Input 7 = 1
6911  0010 7201501f06    	btjf	_PG_IDR,#0,L5033
6914  0015 721c00f9      	bset	_IO_16to9_new1,#6
6916  0019 2004          	jra	L7033
6917  001b               L5033:
6918                     ; 2244   else IO_16to9_new1 &= (uint8_t)(~0x40);
6920  001b 721d00f9      	bres	_IO_16to9_new1,#6
6921  001f               L7033:
6922                     ; 2245   if (PE_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x20; // PE bit 3 = 1, Input 6 = 1
6924  001f 7207501506    	btjf	_PE_IDR,#3,L1133
6927  0024 721a00f9      	bset	_IO_16to9_new1,#5
6929  0028 2004          	jra	L3133
6930  002a               L1133:
6931                     ; 2246   else IO_16to9_new1 &= (uint8_t)(~0x20);
6933  002a 721b00f9      	bres	_IO_16to9_new1,#5
6934  002e               L3133:
6935                     ; 2247   if (PD_IDR & (uint8_t)0x01) IO_16to9_new1 |= 0x10; // PD bit 0 = 1, Input 5 = 1
6937  002e 7201501006    	btjf	_PD_IDR,#0,L5133
6940  0033 721800f9      	bset	_IO_16to9_new1,#4
6942  0037 2004          	jra	L7133
6943  0039               L5133:
6944                     ; 2248   else IO_16to9_new1 &= (uint8_t)(~0x10);
6946  0039 721900f9      	bres	_IO_16to9_new1,#4
6947  003d               L7133:
6948                     ; 2249   if (PD_IDR & (uint8_t)0x08) IO_16to9_new1 |= 0x08; // PD bit 3 = 1, Input 4 = 1
6950  003d 7207501006    	btjf	_PD_IDR,#3,L1233
6953  0042 721600f9      	bset	_IO_16to9_new1,#3
6955  0046 2004          	jra	L3233
6956  0048               L1233:
6957                     ; 2250   else IO_16to9_new1 &= (uint8_t)(~0x08);
6959  0048 721700f9      	bres	_IO_16to9_new1,#3
6960  004c               L3233:
6961                     ; 2251   if (PD_IDR & (uint8_t)0x20) IO_16to9_new1 |= 0x04; // PD bit 5 = 1, Input 3 = 1
6963  004c 720b501006    	btjf	_PD_IDR,#5,L5233
6966  0051 721400f9      	bset	_IO_16to9_new1,#2
6968  0055 2004          	jra	L7233
6969  0057               L5233:
6970                     ; 2252   else IO_16to9_new1 &= (uint8_t)(~0x04);
6972  0057 721500f9      	bres	_IO_16to9_new1,#2
6973  005b               L7233:
6974                     ; 2253   if (PD_IDR & (uint8_t)0x80) IO_16to9_new1 |= 0x02; // PD bit 7 = 1, Input 2 = 1
6976  005b 720f501006    	btjf	_PD_IDR,#7,L1333
6979  0060 721200f9      	bset	_IO_16to9_new1,#1
6981  0064 2004          	jra	L3333
6982  0066               L1333:
6983                     ; 2254   else IO_16to9_new1 &= (uint8_t)(~0x02);
6985  0066 721300f9      	bres	_IO_16to9_new1,#1
6986  006a               L3333:
6987                     ; 2255   if (PA_IDR & (uint8_t)0x10) IO_16to9_new1 |= 0x01; // PA bit 4 = 1, Input 1 = 1
6989  006a 7209500106    	btjf	_PA_IDR,#4,L5333
6992  006f 721000f9      	bset	_IO_16to9_new1,#0
6994  0073 2004          	jra	L7333
6995  0075               L5333:
6996                     ; 2256   else IO_16to9_new1 &= (uint8_t)(~0x01);
6998  0075 721100f9      	bres	_IO_16to9_new1,#0
6999  0079               L7333:
7000                     ; 2261   xor_tmp = (uint8_t)((IO_16to9 ^ IO_16to9_new1) & (IO_16to9 ^ IO_16to9_new2));
7002  0079 c600fb        	ld	a,_IO_16to9
7003  007c c800f7        	xor	a,_IO_16to9_new2
7004  007f 6b01          	ld	(OFST-1,sp),a
7006  0081 c600fb        	ld	a,_IO_16to9
7007  0084 c800f9        	xor	a,_IO_16to9_new1
7008  0087 1401          	and	a,(OFST-1,sp)
7009  0089 6b02          	ld	(OFST+0,sp),a
7011                     ; 2262   IO_16to9 = (uint8_t)(IO_16to9 ^ xor_tmp);
7013  008b c800fb        	xor	a,_IO_16to9
7014  008e c700fb        	ld	_IO_16to9,a
7015                     ; 2264   IO_16to9_new2 = IO_16to9_new1;
7017                     ; 2318 }
7020  0091 85            	popw	x
7021  0092 5500f900f7    	mov	_IO_16to9_new2,_IO_16to9_new1
7022  0097 81            	ret	
7062                     ; 2321 void write_output_registers(void)
7062                     ; 2322 {
7063                     .text:	section	.text,new
7064  0000               _write_output_registers:
7066  0000 88            	push	a
7067       00000001      OFST:	set	1
7070                     ; 2376   xor_tmp = (uint8_t)(invert_output ^ IO_8to1);
7072  0001 c600f3        	ld	a,_invert_output
7073  0004 c800fa        	xor	a,_IO_8to1
7074  0007 6b01          	ld	(OFST+0,sp),a
7076                     ; 2377   if (xor_tmp & 0x80) PC_ODR |= (uint8_t)0x80; // Relay 8 off
7078  0009 2a06          	jrpl	L5533
7081  000b 721e500a      	bset	_PC_ODR,#7
7083  000f 2004          	jra	L7533
7084  0011               L5533:
7085                     ; 2378   else PC_ODR &= (uint8_t)~0x80; // Relay 8 on
7087  0011 721f500a      	bres	_PC_ODR,#7
7088  0015               L7533:
7089                     ; 2379   if (xor_tmp & 0x40) PG_ODR |= (uint8_t)0x02; // Relay 7 off
7091  0015 a540          	bcp	a,#64
7092  0017 2706          	jreq	L1633
7095  0019 7212501e      	bset	_PG_ODR,#1
7097  001d 2004          	jra	L3633
7098  001f               L1633:
7099                     ; 2380   else PG_ODR &= (uint8_t)~0x02; // Relay 7 on
7101  001f 7213501e      	bres	_PG_ODR,#1
7102  0023               L3633:
7103                     ; 2381   if (xor_tmp & 0x20) PE_ODR |= (uint8_t)0x01; // Relay 6 off
7105  0023 7b01          	ld	a,(OFST+0,sp)
7106  0025 a520          	bcp	a,#32
7107  0027 2706          	jreq	L5633
7110  0029 72105014      	bset	_PE_ODR,#0
7112  002d 2004          	jra	L7633
7113  002f               L5633:
7114                     ; 2382   else PE_ODR &= (uint8_t)~0x01; // Relay 6 on
7116  002f 72115014      	bres	_PE_ODR,#0
7117  0033               L7633:
7118                     ; 2383   if (xor_tmp & 0x10) PD_ODR |= (uint8_t)0x04; // Relay 5 off
7120  0033 a510          	bcp	a,#16
7121  0035 2706          	jreq	L1733
7124  0037 7214500f      	bset	_PD_ODR,#2
7126  003b 2004          	jra	L3733
7127  003d               L1733:
7128                     ; 2384   else PD_ODR &= (uint8_t)~0x04; // Relay 5 on
7130  003d 7215500f      	bres	_PD_ODR,#2
7131  0041               L3733:
7132                     ; 2385   if (xor_tmp & 0x08) PD_ODR |= (uint8_t)0x10; // Relay 4 off
7134  0041 7b01          	ld	a,(OFST+0,sp)
7135  0043 a508          	bcp	a,#8
7136  0045 2706          	jreq	L5733
7139  0047 7218500f      	bset	_PD_ODR,#4
7141  004b 2004          	jra	L7733
7142  004d               L5733:
7143                     ; 2386   else PD_ODR &= (uint8_t)~0x10; // Relay 4 on
7145  004d 7219500f      	bres	_PD_ODR,#4
7146  0051               L7733:
7147                     ; 2387   if (xor_tmp & 0x04) PD_ODR |= (uint8_t)0x40; // Relay 3 off
7149  0051 a504          	bcp	a,#4
7150  0053 2706          	jreq	L1043
7153  0055 721c500f      	bset	_PD_ODR,#6
7155  0059 2004          	jra	L3043
7156  005b               L1043:
7157                     ; 2388   else PD_ODR &= (uint8_t)~0x40; // Relay 3 on
7159  005b 721d500f      	bres	_PD_ODR,#6
7160  005f               L3043:
7161                     ; 2389   if (xor_tmp & 0x02) PA_ODR |= (uint8_t)0x20; // Relay 2 off
7163  005f 7b01          	ld	a,(OFST+0,sp)
7164  0061 a502          	bcp	a,#2
7165  0063 2706          	jreq	L5043
7168  0065 721a5000      	bset	_PA_ODR,#5
7170  0069 2004          	jra	L7043
7171  006b               L5043:
7172                     ; 2390   else PA_ODR &= (uint8_t)~0x20; // Relay 2 on
7174  006b 721b5000      	bres	_PA_ODR,#5
7175  006f               L7043:
7176                     ; 2391   if (xor_tmp & 0x01) PA_ODR |= (uint8_t)0x08; // Relay 1 off
7178  006f a501          	bcp	a,#1
7179  0071 2706          	jreq	L1143
7182  0073 72165000      	bset	_PA_ODR,#3
7184  0077 2004          	jra	L3143
7185  0079               L1143:
7186                     ; 2392   else PA_ODR &= (uint8_t)~0x08; // Relay 1 on
7188  0079 72175000      	bres	_PA_ODR,#3
7189  007d               L3143:
7190                     ; 2398 }
7193  007d 84            	pop	a
7194  007e 81            	ret	
7235                     ; 2401 void check_reset_button(void)
7235                     ; 2402 {
7236                     .text:	section	.text,new
7237  0000               _check_reset_button:
7239  0000 88            	push	a
7240       00000001      OFST:	set	1
7243                     ; 2407   if ((PA_IDR & 0x02) == 0) {
7245  0001 720250015d    	btjt	_PA_IDR,#1,L1343
7246                     ; 2409     for (i=0; i<100; i++) {
7248  0006 0f01          	clr	(OFST+0,sp)
7250  0008               L3343:
7251                     ; 2410       wait_timer(50000); // wait 50ms
7253  0008 aec350        	ldw	x,#50000
7254  000b cd0000        	call	_wait_timer
7256                     ; 2411       if ((PA_IDR & 0x02) == 1) { // check Reset Button again. If released
7258  000e c65001        	ld	a,_PA_IDR
7259  0011 a402          	and	a,#2
7260  0013 4a            	dec	a
7261  0014 2602          	jrne	L1443
7262                     ; 2413         return;
7265  0016 84            	pop	a
7266  0017 81            	ret	
7267  0018               L1443:
7268                     ; 2409     for (i=0; i<100; i++) {
7270  0018 0c01          	inc	(OFST+0,sp)
7274  001a 7b01          	ld	a,(OFST+0,sp)
7275  001c a164          	cp	a,#100
7276  001e 25e8          	jrult	L3343
7277                     ; 2418     LEDcontrol(0);  // turn LED off
7279  0020 4f            	clr	a
7280  0021 cd0000        	call	_LEDcontrol
7283  0024               L5443:
7284                     ; 2419     while((PA_IDR & 0x02) == 0) {  // Wait for button release
7286  0024 72035001fb    	btjf	_PA_IDR,#1,L5443
7287                     ; 2422     magic4 = 0x00;
7289  0029 4f            	clr	a
7290  002a ae002e        	ldw	x,#_magic4
7291  002d cd0000        	call	c_eewrc
7293                     ; 2423     magic3 = 0x00;
7295  0030 4f            	clr	a
7296  0031 ae002d        	ldw	x,#_magic3
7297  0034 cd0000        	call	c_eewrc
7299                     ; 2424     magic2 = 0x00;
7301  0037 4f            	clr	a
7302  0038 ae002c        	ldw	x,#_magic2
7303  003b cd0000        	call	c_eewrc
7305                     ; 2425     magic1 = 0x00;
7307  003e 4f            	clr	a
7308  003f ae002b        	ldw	x,#_magic1
7309  0042 cd0000        	call	c_eewrc
7311                     ; 2427     WWDG_WR = (uint8_t)0x7f;       // Window register reset
7313  0045 357f50d2      	mov	_WWDG_WR,#127
7314                     ; 2428     WWDG_CR = (uint8_t)0xff;       // Set watchdog to timeout in 49ms
7316  0049 35ff50d1      	mov	_WWDG_CR,#255
7317                     ; 2429     WWDG_WR = (uint8_t)0x60;       // Window register value - doesn't matter
7319  004d 356050d2      	mov	_WWDG_WR,#96
7320                     ; 2432     wait_timer((uint16_t)50000);   // Wait for watchdog to generate reset
7322  0051 aec350        	ldw	x,#50000
7323  0054 cd0000        	call	_wait_timer
7325                     ; 2433     wait_timer((uint16_t)50000);
7327  0057 aec350        	ldw	x,#50000
7328  005a cd0000        	call	_wait_timer
7330                     ; 2434     wait_timer((uint16_t)50000);
7332  005d aec350        	ldw	x,#50000
7333  0060 cd0000        	call	_wait_timer
7335  0063               L1343:
7336                     ; 2436 }
7339  0063 84            	pop	a
7340  0064 81            	ret	
7374                     ; 2439 void debugflash(void)
7374                     ; 2440 {
7375                     .text:	section	.text,new
7376  0000               _debugflash:
7378  0000 88            	push	a
7379       00000001      OFST:	set	1
7382                     ; 2455   LEDcontrol(0);     // turn LED off
7384  0001 4f            	clr	a
7385  0002 cd0000        	call	_LEDcontrol
7387                     ; 2456   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
7389  0005 0f01          	clr	(OFST+0,sp)
7391  0007               L5643:
7394  0007 aec350        	ldw	x,#50000
7395  000a cd0000        	call	_wait_timer
7399  000d 0c01          	inc	(OFST+0,sp)
7403  000f 7b01          	ld	a,(OFST+0,sp)
7404  0011 a10a          	cp	a,#10
7405  0013 25f2          	jrult	L5643
7406                     ; 2458   LEDcontrol(1);     // turn LED on
7408  0015 a601          	ld	a,#1
7409  0017 cd0000        	call	_LEDcontrol
7411                     ; 2459   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
7413  001a 0f01          	clr	(OFST+0,sp)
7415  001c               L3743:
7418  001c aec350        	ldw	x,#50000
7419  001f cd0000        	call	_wait_timer
7423  0022 0c01          	inc	(OFST+0,sp)
7427  0024 7b01          	ld	a,(OFST+0,sp)
7428  0026 a10a          	cp	a,#10
7429  0028 25f2          	jrult	L3743
7430                     ; 2460 }
7433  002a 84            	pop	a
7434  002b 81            	ret	
7468                     ; 2463 void fastflash(void)
7468                     ; 2464 {
7469                     .text:	section	.text,new
7470  0000               _fastflash:
7472  0000 88            	push	a
7473       00000001      OFST:	set	1
7476                     ; 2479   for (i=0; i<10; i++) {
7478  0001 0f01          	clr	(OFST+0,sp)
7480  0003               L5153:
7481                     ; 2480     LEDcontrol(0);     // turn LED off
7483  0003 4f            	clr	a
7484  0004 cd0000        	call	_LEDcontrol
7486                     ; 2481     wait_timer((uint16_t)50000); // wait 50ms
7488  0007 aec350        	ldw	x,#50000
7489  000a cd0000        	call	_wait_timer
7491                     ; 2483     LEDcontrol(1);     // turn LED on
7493  000d a601          	ld	a,#1
7494  000f cd0000        	call	_LEDcontrol
7496                     ; 2484     wait_timer((uint16_t)50000); // wait 50ms
7498  0012 aec350        	ldw	x,#50000
7499  0015 cd0000        	call	_wait_timer
7501                     ; 2479   for (i=0; i<10; i++) {
7503  0018 0c01          	inc	(OFST+0,sp)
7507  001a 7b01          	ld	a,(OFST+0,sp)
7508  001c a10a          	cp	a,#10
7509  001e 25e3          	jrult	L5153
7510                     ; 2486 }
7513  0020 84            	pop	a
7514  0021 81            	ret	
7539                     ; 2489 void oneflash(void)
7539                     ; 2490 {
7540                     .text:	section	.text,new
7541  0000               _oneflash:
7545                     ; 2505   LEDcontrol(0);     // turn LED off
7547  0000 4f            	clr	a
7548  0001 cd0000        	call	_LEDcontrol
7550                     ; 2506   wait_timer((uint16_t)25000); // wait 25ms
7552  0004 ae61a8        	ldw	x,#25000
7553  0007 cd0000        	call	_wait_timer
7555                     ; 2508   LEDcontrol(1);     // turn LED on
7557  000a a601          	ld	a,#1
7559                     ; 2509 }
7562  000c cc0000        	jp	_LEDcontrol
8869                     	switch	.bss
8870  0000               _topic_base_len:
8871  0000 00            	ds.b	1
8872                     	xdef	_topic_base_len
8873  0001               _topic_base:
8874  0001 000000000000  	ds.b	44
8875                     	xdef	_topic_base
8876  002d               _mqtt_restart_step:
8877  002d 00            	ds.b	1
8878                     	xdef	_mqtt_restart_step
8879                     	xref	_MQTT_error_status
8880  002e               _mqtt_conn:
8881  002e 0000          	ds.b	2
8882                     	xdef	_mqtt_conn
8883                     	xref	_mqtt_sendbuf
8884  0030               _mqtt_start_retry:
8885  0030 00            	ds.b	1
8886                     	xdef	_mqtt_start_retry
8887  0031               _mqtt_sanity_ctr:
8888  0031 00            	ds.b	1
8889                     	xdef	_mqtt_sanity_ctr
8890  0032               _mqtt_start_ctr2:
8891  0032 00            	ds.b	1
8892                     	xdef	_mqtt_start_ctr2
8893  0033               _mqtt_start_ctr1:
8894  0033 00            	ds.b	1
8895                     	xdef	_mqtt_start_ctr1
8896  0034               _mqtt_start_status:
8897  0034 00            	ds.b	1
8898                     	xdef	_mqtt_start_status
8899  0035               _mqtt_start:
8900  0035 00            	ds.b	1
8901                     	xdef	_mqtt_start
8902  0036               _client_id_text:
8903  0036 000000000000  	ds.b	26
8904                     	xdef	_client_id_text
8905  0050               _client_id:
8906  0050 0000          	ds.b	2
8907                     	xdef	_client_id
8908  0052               _mqttclient:
8909  0052 000000000000  	ds.b	44
8910                     	xdef	_mqttclient
8911  007e               _mqtt_keep_alive:
8912  007e 0000          	ds.b	2
8913                     	xdef	_mqtt_keep_alive
8914  0080               _application_message:
8915  0080 000000        	ds.b	3
8916                     	xdef	_application_message
8917  0083               _Port_Mqttd:
8918  0083 0000          	ds.b	2
8919                     	xdef	_Port_Mqttd
8920  0085               _mqttport:
8921  0085 0000          	ds.b	2
8922                     	xdef	_mqttport
8923  0087               _connect_flags:
8924  0087 00            	ds.b	1
8925                     	xdef	_connect_flags
8926                     	xref	_OctetArray
8927                     	xref	_second_counter
8928  0088               _time_mark2:
8929  0088 00000000      	ds.b	4
8930                     	xdef	_time_mark2
8931  008c               _IpAddr:
8932  008c 00000000      	ds.b	4
8933                     	xdef	_IpAddr
8934  0090               _Port_Httpd:
8935  0090 0000          	ds.b	2
8936                     	xdef	_Port_Httpd
8937  0092               _mqtt_parse_complete:
8938  0092 00            	ds.b	1
8939                     	xdef	_mqtt_parse_complete
8940  0093               _parse_complete:
8941  0093 00            	ds.b	1
8942                     	xdef	_parse_complete
8943  0094               _mqtt_close_tcp:
8944  0094 00            	ds.b	1
8945                     	xdef	_mqtt_close_tcp
8946  0095               _restart_reboot_step:
8947  0095 00            	ds.b	1
8948                     	xdef	_restart_reboot_step
8949  0096               _restart_request:
8950  0096 00            	ds.b	1
8951                     	xdef	_restart_request
8952  0097               _user_reboot_request:
8953  0097 00            	ds.b	1
8954                     	xdef	_user_reboot_request
8955  0098               _reboot_request:
8956  0098 00            	ds.b	1
8957                     	xdef	_reboot_request
8958  0099               _mac_string:
8959  0099 000000000000  	ds.b	13
8960                     	xdef	_mac_string
8961  00a6               _Pending_uip_ethaddr_oct:
8962  00a6 000000000000  	ds.b	6
8963                     	xdef	_Pending_uip_ethaddr_oct
8964  00ac               _Pending_config_settings:
8965  00ac 000000000000  	ds.b	6
8966                     	xdef	_Pending_config_settings
8967  00b2               _Pending_devicename:
8968  00b2 000000000000  	ds.b	20
8969                     	xdef	_Pending_devicename
8970  00c6               _Pending_port:
8971  00c6 0000          	ds.b	2
8972                     	xdef	_Pending_port
8973  00c8               _Pending_netmask:
8974  00c8 00000000      	ds.b	4
8975                     	xdef	_Pending_netmask
8976  00cc               _Pending_draddr:
8977  00cc 00000000      	ds.b	4
8978                     	xdef	_Pending_draddr
8979  00d0               _Pending_hostaddr:
8980  00d0 00000000      	ds.b	4
8981                     	xdef	_Pending_hostaddr
8982  00d4               _Pending_mqtt_password:
8983  00d4 000000000000  	ds.b	11
8984                     	xdef	_Pending_mqtt_password
8985  00df               _Pending_mqtt_username:
8986  00df 000000000000  	ds.b	11
8987                     	xdef	_Pending_mqtt_username
8988  00ea               _Pending_mqttport:
8989  00ea 0000          	ds.b	2
8990                     	xdef	_Pending_mqttport
8991  00ec               _Pending_mqttserveraddr:
8992  00ec 00000000      	ds.b	4
8993                     	xdef	_Pending_mqttserveraddr
8994  00f0               _stack_error:
8995  00f0 00            	ds.b	1
8996                     	xdef	_stack_error
8997  00f1               _state_request:
8998  00f1 00            	ds.b	1
8999                     	xdef	_state_request
9000  00f2               _invert_input:
9001  00f2 00            	ds.b	1
9002                     	xdef	_invert_input
9003  00f3               _invert_output:
9004  00f3 00            	ds.b	1
9005                     	xdef	_invert_output
9006  00f4               _IO_8to1_sent:
9007  00f4 00            	ds.b	1
9008                     	xdef	_IO_8to1_sent
9009  00f5               _IO_16to9_sent:
9010  00f5 00            	ds.b	1
9011                     	xdef	_IO_16to9_sent
9012  00f6               _IO_8to1_new2:
9013  00f6 00            	ds.b	1
9014                     	xdef	_IO_8to1_new2
9015  00f7               _IO_16to9_new2:
9016  00f7 00            	ds.b	1
9017                     	xdef	_IO_16to9_new2
9018  00f8               _IO_8to1_new1:
9019  00f8 00            	ds.b	1
9020                     	xdef	_IO_8to1_new1
9021  00f9               _IO_16to9_new1:
9022  00f9 00            	ds.b	1
9023                     	xdef	_IO_16to9_new1
9024  00fa               _IO_8to1:
9025  00fa 00            	ds.b	1
9026                     	xdef	_IO_8to1
9027  00fb               _IO_16to9:
9028  00fb 00            	ds.b	1
9029                     	xdef	_IO_16to9
9030                     .eeprom:	section	.data
9031  0000               _stored_devicename:
9032  0000 000000000000  	ds.b	20
9033                     	xdef	_stored_devicename
9034  0014               _stored_IO_8to1:
9035  0014 00            	ds.b	1
9036                     	xdef	_stored_IO_8to1
9037  0015               _stored_unused1:
9038  0015 00            	ds.b	1
9039                     	xdef	_stored_unused1
9040  0016               _stored_unused2:
9041  0016 00            	ds.b	1
9042                     	xdef	_stored_unused2
9043  0017               _stored_uip_ethaddr_oct:
9044  0017 000000000000  	ds.b	6
9045                     	xdef	_stored_uip_ethaddr_oct
9046  001d               _stored_port:
9047  001d 0000          	ds.b	2
9048                     	xdef	_stored_port
9049  001f               _stored_netmask:
9050  001f 00000000      	ds.b	4
9051                     	xdef	_stored_netmask
9052  0023               _stored_draddr:
9053  0023 00000000      	ds.b	4
9054                     	xdef	_stored_draddr
9055  0027               _stored_hostaddr:
9056  0027 00000000      	ds.b	4
9057                     	xdef	_stored_hostaddr
9058  002b               _magic1:
9059  002b 00            	ds.b	1
9060                     	xdef	_magic1
9061  002c               _magic2:
9062  002c 00            	ds.b	1
9063                     	xdef	_magic2
9064  002d               _magic3:
9065  002d 00            	ds.b	1
9066                     	xdef	_magic3
9067  002e               _magic4:
9068  002e 00            	ds.b	1
9069                     	xdef	_magic4
9070  002f               _stored_mqttport:
9071  002f 0000          	ds.b	2
9072                     	xdef	_stored_mqttport
9073  0031               _stored_mqttserveraddr:
9074  0031 00000000      	ds.b	4
9075                     	xdef	_stored_mqttserveraddr
9076  0035               _stored_mqtt_username:
9077  0035 000000000000  	ds.b	11
9078                     	xdef	_stored_mqtt_username
9079  0040               _stored_mqtt_password:
9080  0040 000000000000  	ds.b	11
9081                     	xdef	_stored_mqtt_password
9082  004b               _stored_IO_16to9:
9083  004b 00            	ds.b	1
9084                     	xdef	_stored_IO_16to9
9085  004c               _stored_config_settings:
9086  004c 000000000000  	ds.b	6
9087                     	xdef	_stored_config_settings
9088                     	xdef	_stack_limit2
9089                     	xdef	_stack_limit1
9090                     	xref	_mqtt_disconnect
9091                     	xref	_mqtt_subscribe
9092                     	xref	_mqtt_publish
9093                     	xref	_mqtt_connect
9094                     	xref	_mqtt_init
9095                     	xref	_strlen
9096                     	xref	_strcat
9097                     	xref	_wait_timer
9098                     	xref	_arp_timer_expired
9099                     	xref	_periodic_timer_expired
9100                     	xref	_clock_init
9101                     	xref	_LEDcontrol
9102                     	xref	_gpio_init
9103                     	xref	_check_mqtt_server_arp_entry
9104                     	xref	_uip_arp_timer
9105                     	xref	_uip_arp_out
9106                     	xref	_uip_arp_arpin
9107                     	xref	_uip_arp_init
9108                     	xref	_uip_ethaddr
9109                     	xref	_uip_mqttserveraddr
9110                     	xref	_uip_draddr
9111                     	xref	_uip_netmask
9112                     	xref	_uip_hostaddr
9113                     	xref	_uip_process
9114                     	xref	_uip_conns
9115                     	xref	_uip_conn
9116                     	xref	_uip_len
9117                     	xref	_uip_appdata
9118                     	xref	_htons
9119                     	xref	_uip_connect
9120                     	xref	_uip_buf
9121                     	xref	_uip_init
9122                     	xref	_GpioSetPin
9123                     	xref	_HttpDInit
9124                     	xref	_emb_itoa
9125                     	xref	_Enc28j60Send
9126                     	xref	_Enc28j60Receive
9127                     	xref	_Enc28j60Init
9128                     	xref	_spi_init
9129                     	xdef	_publish_pinstate_all
9130                     	xdef	_publish_pinstate
9131                     	xdef	_publish_outbound
9132                     	xdef	_publish_callback
9133                     	xdef	_mqtt_sanity_check
9134                     	xdef	_mqtt_startup
9135                     	xdef	_debugflash
9136                     	xdef	_fastflash
9137                     	xdef	_oneflash
9138                     	xdef	_reboot
9139                     	xdef	_restart
9140                     	xdef	_check_restart_reboot
9141                     	xdef	_check_reset_button
9142                     	xdef	_write_output_registers
9143                     	xdef	_read_input_registers
9144                     	xdef	_check_runtime_changes
9145                     	xdef	_update_mac_string
9146                     	xdef	_check_eeprom_settings
9147                     	xdef	_unlock_eeprom
9148                     	xdef	_main
9149                     	switch	.const
9150  000f               L5242:
9151  000f 2f7374617465  	dc.b	"/state",0
9152  0016               L7632:
9153  0016 2f6f75745f6f  	dc.b	"/out_off",0
9154  001f               L3632:
9155  001f 2f6f75745f6f  	dc.b	"/out_on",0
9156  0027               L5532:
9157  0027 2f696e5f6f66  	dc.b	"/in_off",0
9158  002f               L1532:
9159  002f 2f696e5f6f6e  	dc.b	"/in_on",0
9160  0036               L5302:
9161  0036 6f6e6c696e65  	dc.b	"online",0
9162  003d               L5202:
9163  003d 2f7374617465  	dc.b	"/state-req",0
9164  0048               L5102:
9165  0048 2f6f666600    	dc.b	"/off",0
9166  004d               L5002:
9167  004d 2f6f6e00      	dc.b	"/on",0
9168  0051               L1771:
9169  0051 6f66666c696e  	dc.b	"offline",0
9170  0059               L7671:
9171  0059 2f7374617475  	dc.b	"/status",0
9172                     	xref.b	c_lreg
9192                     	xref	c_ladc
9193                     	xref	c_lcmp
9194                     	xref	c_ltor
9195                     	xref	c_eewrw
9196                     	xref	c_eewrc
9197                     	end
