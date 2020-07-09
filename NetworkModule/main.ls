   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2581                     ; 156 main(void)
2581                     ; 157 {
2583                     	switch	.text
2584  0000               _main:
2586  0000 89            	pushw	x
2587       00000002      OFST:	set	2
2590                     ; 161   devicename_changed = 0;
2592  0001 725f0000      	clr	_devicename_changed
2593                     ; 162   submit_changes = 0;
2595  0005 725f0001      	clr	_submit_changes
2596                     ; 164   clock_init();            // Initialize and enable clocks and timers
2598  0009 cd0000        	call	_clock_init
2600                     ; 166   gpio_init();             // Initialize and enable gpio pins
2602  000c cd0000        	call	_gpio_init
2604                     ; 168   spi_init();              // Initialize the SPI bit bang interface to the
2606  000f cd0000        	call	_spi_init
2608                     ; 171   LEDcontrol(1);           // turn LED on
2610  0012 a601          	ld	a,#1
2611  0014 cd0000        	call	_LEDcontrol
2613                     ; 173   unlock_eeprom();         // unlock the EEPROM so writes can be performed
2615  0017 cd00ba        	call	_unlock_eeprom
2617                     ; 175   check_eeprom_settings(); // Check the EEPROM for previously stored Address
2619  001a cd00ca        	call	_check_eeprom_settings
2621                     ; 179   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
2623  001d cd0000        	call	_Enc28j60Init
2625                     ; 181   uip_arp_init();          // Initialize the ARP module
2627  0020 cd0000        	call	_uip_arp_init
2629                     ; 183   uip_init();              // Initialize uIP
2631  0023 cd0000        	call	_uip_init
2633                     ; 185   HttpDInit();             // Initialize httpd; sets up listening ports
2635  0026 cd0000        	call	_HttpDInit
2637  0029               L1561:
2638                     ; 188     uip_len = Enc28j60Receive(uip_buf);
2640  0029 ae0000        	ldw	x,#_uip_buf
2641  002c cd0000        	call	_Enc28j60Receive
2643  002f cf0000        	ldw	_uip_len,x
2644                     ; 190     if (uip_len> 0) {
2646  0032 273b          	jreq	L5561
2647                     ; 191       if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
2649  0034 ae0800        	ldw	x,#2048
2650  0037 cd0000        	call	_htons
2652  003a c3000c        	cpw	x,_uip_buf+12
2653  003d 2612          	jrne	L7561
2654                     ; 193 	uip_input(); // calls uip_process(UIP_DATA)
2656  003f a601          	ld	a,#1
2657  0041 cd0000        	call	_uip_process
2659                     ; 197         if (uip_len> 0) {
2661  0044 ce0000        	ldw	x,_uip_len
2662  0047 2726          	jreq	L5561
2663                     ; 198           uip_arp_out();
2665  0049 cd0000        	call	_uip_arp_out
2667                     ; 202           Enc28j60CopyPacket(uip_buf, uip_len);
2669  004c ce0000        	ldw	x,_uip_len
2671                     ; 203           Enc28j60Send();
2673  004f 2013          	jp	LC001
2674  0051               L7561:
2675                     ; 206       else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
2677  0051 ae0806        	ldw	x,#2054
2678  0054 cd0000        	call	_htons
2680  0057 c3000c        	cpw	x,_uip_buf+12
2681  005a 2613          	jrne	L5561
2682                     ; 207         uip_arp_arpin();
2684  005c cd0000        	call	_uip_arp_arpin
2686                     ; 211         if (uip_len> 0) {
2688  005f ce0000        	ldw	x,_uip_len
2689  0062 270b          	jreq	L5561
2690                     ; 215           Enc28j60CopyPacket(uip_buf, uip_len);
2693                     ; 216           Enc28j60Send();
2695  0064               LC001:
2696  0064 89            	pushw	x
2697  0065 ae0000        	ldw	x,#_uip_buf
2698  0068 cd0000        	call	_Enc28j60CopyPacket
2699  006b 85            	popw	x
2701  006c cd0000        	call	_Enc28j60Send
2703  006f               L5561:
2704                     ; 221     if (periodic_timer_expired()) {
2706  006f cd0000        	call	_periodic_timer_expired
2708  0072 4d            	tnz	a
2709  0073 2733          	jreq	L1761
2710                     ; 222       for(i = 0; i < UIP_CONNS; i++) {
2712  0075 5f            	clrw	x
2713  0076 1f01          	ldw	(OFST-1,sp),x
2715  0078               L1071:
2716                     ; 223 	uip_periodic(i);
2718  0078 a628          	ld	a,#40
2719  007a cd0000        	call	c_bmulx
2721  007d 1c0000        	addw	x,#_uip_conns
2722  0080 cf0000        	ldw	_uip_conn,x
2725  0083 a602          	ld	a,#2
2726  0085 cd0000        	call	_uip_process
2728                     ; 227 	if (uip_len > 0) {
2730  0088 ce0000        	ldw	x,_uip_len
2731  008b 2711          	jreq	L5071
2732                     ; 228 	  uip_arp_out();
2734  008d cd0000        	call	_uip_arp_out
2736                     ; 232           Enc28j60CopyPacket(uip_buf, uip_len);
2738  0090 ce0000        	ldw	x,_uip_len
2739  0093 89            	pushw	x
2740  0094 ae0000        	ldw	x,#_uip_buf
2741  0097 cd0000        	call	_Enc28j60CopyPacket
2743  009a 85            	popw	x
2744                     ; 233           Enc28j60Send();
2746  009b cd0000        	call	_Enc28j60Send
2748  009e               L5071:
2749                     ; 222       for(i = 0; i < UIP_CONNS; i++) {
2751  009e 1e01          	ldw	x,(OFST-1,sp)
2752  00a0 5c            	incw	x
2753  00a1 1f01          	ldw	(OFST-1,sp),x
2757  00a3 a30006        	cpw	x,#6
2758  00a6 2fd0          	jrslt	L1071
2759  00a8               L1761:
2760                     ; 239     if (arp_timer_expired()) {
2762  00a8 cd0000        	call	_arp_timer_expired
2764  00ab 4d            	tnz	a
2765  00ac 2703          	jreq	L7071
2766                     ; 240       uip_arp_timer();
2768  00ae cd0000        	call	_uip_arp_timer
2770  00b1               L7071:
2771                     ; 245     check_runtime_changes();
2773  00b1 cd0469        	call	_check_runtime_changes
2775                     ; 248     check_reset_button();
2777  00b4 cd085f        	call	_check_reset_button
2780  00b7 cc0029        	jra	L1561
2805                     ; 273 void unlock_eeprom(void)
2805                     ; 274 {
2806                     	switch	.text
2807  00ba               _unlock_eeprom:
2811  00ba 2008          	jra	L3271
2812  00bc               L1271:
2813                     ; 282     FLASH_DUKR = 0xAE; // MASS key 1
2815  00bc 35ae5064      	mov	_FLASH_DUKR,#174
2816                     ; 283     FLASH_DUKR = 0x56; // MASS key 2
2818  00c0 35565064      	mov	_FLASH_DUKR,#86
2819  00c4               L3271:
2820                     ; 281   while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
2822  00c4 7207505ff3    	btjf	_FLASH_IAPSR,#3,L1271
2823                     ; 285 }
2826  00c9 81            	ret	
2935                     ; 288 void check_eeprom_settings(void)
2935                     ; 289 {
2936                     	switch	.text
2937  00ca               _check_eeprom_settings:
2939  00ca 88            	push	a
2940       00000001      OFST:	set	1
2943                     ; 299   if ((magic4 == 0x55) && 
2943                     ; 300       (magic3 == 0xee) && 
2943                     ; 301       (magic2 == 0x0f) && 
2943                     ; 302       (magic1 == 0xf0) == 1) {
2945  00cb c6002e        	ld	a,_magic4
2946  00ce a155          	cp	a,#85
2947  00d0 2703cc01ba    	jrne	L5002
2949  00d5 c6002d        	ld	a,_magic3
2950  00d8 a1ee          	cp	a,#238
2951  00da 26f6          	jrne	L5002
2953  00dc c6002c        	ld	a,_magic2
2954  00df a10f          	cp	a,#15
2955  00e1 26ef          	jrne	L5002
2957  00e3 c6002b        	ld	a,_magic1
2958  00e6 a1f0          	cp	a,#240
2959  00e8 26e8          	jrne	L5002
2960                     ; 306     uip_ipaddr(IpAddr, stored_hostaddr4, stored_hostaddr3, stored_hostaddr2, stored_hostaddr1);
2962  00ea c6002a        	ld	a,_stored_hostaddr4
2963  00ed 97            	ld	xl,a
2964  00ee c60029        	ld	a,_stored_hostaddr3
2965  00f1 02            	rlwa	x,a
2966  00f2 cf003e        	ldw	_IpAddr,x
2969  00f5 c60028        	ld	a,_stored_hostaddr2
2970  00f8 97            	ld	xl,a
2971  00f9 c60027        	ld	a,_stored_hostaddr1
2972  00fc 02            	rlwa	x,a
2973  00fd cf0040        	ldw	_IpAddr+2,x
2974                     ; 307     uip_sethostaddr(IpAddr);
2976  0100 ce003e        	ldw	x,_IpAddr
2977  0103 cf0000        	ldw	_uip_hostaddr,x
2980  0106 ce0040        	ldw	x,_IpAddr+2
2981  0109 cf0002        	ldw	_uip_hostaddr+2,x
2982                     ; 309     uip_ipaddr(IpAddr, stored_draddr4, stored_draddr3, stored_draddr2, stored_draddr1);
2984  010c c60026        	ld	a,_stored_draddr4
2985  010f 97            	ld	xl,a
2986  0110 c60025        	ld	a,_stored_draddr3
2987  0113 02            	rlwa	x,a
2988  0114 cf003e        	ldw	_IpAddr,x
2991  0117 c60024        	ld	a,_stored_draddr2
2992  011a 97            	ld	xl,a
2993  011b c60023        	ld	a,_stored_draddr1
2994  011e 02            	rlwa	x,a
2995  011f cf0040        	ldw	_IpAddr+2,x
2996                     ; 310     uip_setdraddr(IpAddr);
2998  0122 ce003e        	ldw	x,_IpAddr
2999  0125 cf0000        	ldw	_uip_draddr,x
3002  0128 ce0040        	ldw	x,_IpAddr+2
3003  012b cf0002        	ldw	_uip_draddr+2,x
3004                     ; 312     uip_ipaddr(IpAddr, stored_netmask4, stored_netmask3, stored_netmask2, stored_netmask1);
3006  012e c60022        	ld	a,_stored_netmask4
3007  0131 97            	ld	xl,a
3008  0132 c60021        	ld	a,_stored_netmask3
3009  0135 02            	rlwa	x,a
3010  0136 cf003e        	ldw	_IpAddr,x
3013  0139 c60020        	ld	a,_stored_netmask2
3014  013c 97            	ld	xl,a
3015  013d c6001f        	ld	a,_stored_netmask1
3016  0140 02            	rlwa	x,a
3017  0141 cf0040        	ldw	_IpAddr+2,x
3018                     ; 313     uip_setnetmask(IpAddr);
3020  0144 ce003e        	ldw	x,_IpAddr
3021  0147 cf0000        	ldw	_uip_netmask,x
3024  014a ce0040        	ldw	x,_IpAddr+2
3025  014d cf0002        	ldw	_uip_netmask+2,x
3026                     ; 315     Port_Httpd = stored_port;
3028  0150 ce001d        	ldw	x,_stored_port
3029  0153 cf0045        	ldw	_Port_Httpd,x
3030                     ; 317     uip_ethaddr6 = stored_uip_ethaddr6;
3032  0156 5500170007    	mov	_uip_ethaddr6,_stored_uip_ethaddr6
3033                     ; 318     uip_ethaddr5 = stored_uip_ethaddr5;
3035  015b 5500180006    	mov	_uip_ethaddr5,_stored_uip_ethaddr5
3036                     ; 319     uip_ethaddr4 = stored_uip_ethaddr4;
3038  0160 5500190005    	mov	_uip_ethaddr4,_stored_uip_ethaddr4
3039                     ; 320     uip_ethaddr3 = stored_uip_ethaddr3;
3041  0165 55001a0004    	mov	_uip_ethaddr3,_stored_uip_ethaddr3
3042                     ; 321     uip_ethaddr2 = stored_uip_ethaddr2;
3044  016a 55001b0003    	mov	_uip_ethaddr2,_stored_uip_ethaddr2
3045                     ; 322     uip_ethaddr1 = stored_uip_ethaddr1;
3047  016f 55001c0002    	mov	_uip_ethaddr1,_stored_uip_ethaddr1
3048                     ; 324     uip_ethaddr.addr[0] = uip_ethaddr1;
3050  0174 5500020000    	mov	_uip_ethaddr,_uip_ethaddr1
3051                     ; 325     uip_ethaddr.addr[1] = uip_ethaddr2;
3053  0179 5500030001    	mov	_uip_ethaddr+1,_uip_ethaddr2
3054                     ; 326     uip_ethaddr.addr[2] = uip_ethaddr3;
3056  017e 5500040002    	mov	_uip_ethaddr+2,_uip_ethaddr3
3057                     ; 327     uip_ethaddr.addr[3] = uip_ethaddr4;
3059  0183 5500050003    	mov	_uip_ethaddr+3,_uip_ethaddr4
3060                     ; 328     uip_ethaddr.addr[4] = uip_ethaddr5;
3062  0188 5500060004    	mov	_uip_ethaddr+4,_uip_ethaddr5
3063                     ; 329     uip_ethaddr.addr[5] = uip_ethaddr6;
3065                     ; 331     for(i=0; i<20; i++) { ex_stored_devicename[i] = stored_devicename[i]; }
3067  018d 4f            	clr	a
3068  018e 5500070005    	mov	_uip_ethaddr+5,_uip_ethaddr6
3069  0193 6b01          	ld	(OFST+0,sp),a
3071  0195               L5771:
3074  0195 5f            	clrw	x
3075  0196 97            	ld	xl,a
3076  0197 d60000        	ld	a,(_stored_devicename,x)
3077  019a d7001c        	ld	(_ex_stored_devicename,x),a
3080  019d 0c01          	inc	(OFST+0,sp)
3084  019f 7b01          	ld	a,(OFST+0,sp)
3085  01a1 a114          	cp	a,#20
3086  01a3 25f0          	jrult	L5771
3087                     ; 335     invert_output = stored_invert_output;
3089  01a5 5500140042    	mov	_invert_output,_stored_invert_output
3090                     ; 336     Relays_16to9 = stored_Relays_16to9;
3092  01aa 5500160044    	mov	_Relays_16to9,_stored_Relays_16to9
3093                     ; 337     Relays_8to1 = stored_Relays_8to1;
3095  01af 5500150043    	mov	_Relays_8to1,_stored_Relays_8to1
3096                     ; 339     update_relay_control_registers();
3098  01b4 cd0675        	call	_update_relay_control_registers
3101  01b7 cc03b5        	jra	L3002
3102  01ba               L5002:
3103                     ; 348     uip_ipaddr(IpAddr, 192,168,1,4);
3105  01ba aec0a8        	ldw	x,#49320
3106  01bd cf003e        	ldw	_IpAddr,x
3109  01c0 ae0104        	ldw	x,#260
3110  01c3 cf0040        	ldw	_IpAddr+2,x
3111                     ; 349     uip_sethostaddr(IpAddr);
3113  01c6 ce003e        	ldw	x,_IpAddr
3114  01c9 cf0000        	ldw	_uip_hostaddr,x
3117  01cc ce0040        	ldw	x,_IpAddr+2
3118  01cf cf0002        	ldw	_uip_hostaddr+2,x
3119                     ; 351     stored_hostaddr4 = 192;	// MSB
3121  01d2 a6c0          	ld	a,#192
3122  01d4 ae002a        	ldw	x,#_stored_hostaddr4
3123  01d7 cd0000        	call	c_eewrc
3125                     ; 352     stored_hostaddr3 = 168;	//
3127  01da a6a8          	ld	a,#168
3128  01dc ae0029        	ldw	x,#_stored_hostaddr3
3129  01df cd0000        	call	c_eewrc
3131                     ; 353     stored_hostaddr2 = 1;	//
3133  01e2 a601          	ld	a,#1
3134  01e4 ae0028        	ldw	x,#_stored_hostaddr2
3135  01e7 cd0000        	call	c_eewrc
3137                     ; 354     stored_hostaddr1 = 4;	// LSB
3139  01ea a604          	ld	a,#4
3140  01ec ae0027        	ldw	x,#_stored_hostaddr1
3141  01ef cd0000        	call	c_eewrc
3143                     ; 357     uip_ipaddr(IpAddr, 192,168,1,1);
3145  01f2 aec0a8        	ldw	x,#49320
3146  01f5 cf003e        	ldw	_IpAddr,x
3149  01f8 ae0101        	ldw	x,#257
3150  01fb cf0040        	ldw	_IpAddr+2,x
3151                     ; 358     uip_setdraddr(IpAddr);
3153  01fe ce003e        	ldw	x,_IpAddr
3154  0201 cf0000        	ldw	_uip_draddr,x
3157  0204 ce0040        	ldw	x,_IpAddr+2
3158  0207 cf0002        	ldw	_uip_draddr+2,x
3159                     ; 360     stored_draddr4 = 192;	// MSB
3161  020a a6c0          	ld	a,#192
3162  020c ae0026        	ldw	x,#_stored_draddr4
3163  020f cd0000        	call	c_eewrc
3165                     ; 361     stored_draddr3 = 168;	//
3167  0212 a6a8          	ld	a,#168
3168  0214 ae0025        	ldw	x,#_stored_draddr3
3169  0217 cd0000        	call	c_eewrc
3171                     ; 362     stored_draddr2 = 1;		//
3173  021a a601          	ld	a,#1
3174  021c ae0024        	ldw	x,#_stored_draddr2
3175  021f cd0000        	call	c_eewrc
3177                     ; 363     stored_draddr1 = 1;		// LSB
3179  0222 a601          	ld	a,#1
3180  0224 ae0023        	ldw	x,#_stored_draddr1
3181  0227 cd0000        	call	c_eewrc
3183                     ; 366     uip_ipaddr(IpAddr, 255,255,255,0);
3185  022a aeffff        	ldw	x,#65535
3186  022d cf003e        	ldw	_IpAddr,x
3189  0230 aeff00        	ldw	x,#65280
3190  0233 cf0040        	ldw	_IpAddr+2,x
3191                     ; 367     uip_setnetmask(IpAddr);
3193  0236 ce003e        	ldw	x,_IpAddr
3194  0239 cf0000        	ldw	_uip_netmask,x
3197  023c ce0040        	ldw	x,_IpAddr+2
3198  023f cf0002        	ldw	_uip_netmask+2,x
3199                     ; 369     stored_netmask4 = 255;	// MSB
3201  0242 a6ff          	ld	a,#255
3202  0244 ae0022        	ldw	x,#_stored_netmask4
3203  0247 cd0000        	call	c_eewrc
3205                     ; 370     stored_netmask3 = 255;	//
3207  024a a6ff          	ld	a,#255
3208  024c ae0021        	ldw	x,#_stored_netmask3
3209  024f cd0000        	call	c_eewrc
3211                     ; 371     stored_netmask2 = 255;	//
3213  0252 a6ff          	ld	a,#255
3214  0254 ae0020        	ldw	x,#_stored_netmask2
3215  0257 cd0000        	call	c_eewrc
3217                     ; 372     stored_netmask1 = 0;	// LSB
3219  025a 4f            	clr	a
3220  025b ae001f        	ldw	x,#_stored_netmask1
3221  025e cd0000        	call	c_eewrc
3223                     ; 375     stored_port = 8080;		// Port
3225  0261 ae1f90        	ldw	x,#8080
3226  0264 89            	pushw	x
3227  0265 ae001d        	ldw	x,#_stored_port
3228  0268 cd0000        	call	c_eewrw
3230  026b 85            	popw	x
3231                     ; 377     Port_Httpd = 8080;
3233  026c ae1f90        	ldw	x,#8080
3234  026f cf0045        	ldw	_Port_Httpd,x
3235                     ; 389     stored_uip_ethaddr1 = 0xc2;	//MAC MSB
3237  0272 a6c2          	ld	a,#194
3238  0274 ae001c        	ldw	x,#_stored_uip_ethaddr1
3239  0277 cd0000        	call	c_eewrc
3241                     ; 390     stored_uip_ethaddr2 = 0x4d;
3243  027a a64d          	ld	a,#77
3244  027c ae001b        	ldw	x,#_stored_uip_ethaddr2
3245  027f cd0000        	call	c_eewrc
3247                     ; 391     stored_uip_ethaddr3 = 0x69;
3249  0282 a669          	ld	a,#105
3250  0284 ae001a        	ldw	x,#_stored_uip_ethaddr3
3251  0287 cd0000        	call	c_eewrc
3253                     ; 392     stored_uip_ethaddr4 = 0x6b;
3255  028a a66b          	ld	a,#107
3256  028c ae0019        	ldw	x,#_stored_uip_ethaddr4
3257  028f cd0000        	call	c_eewrc
3259                     ; 393     stored_uip_ethaddr5 = 0x65;
3261  0292 a665          	ld	a,#101
3262  0294 ae0018        	ldw	x,#_stored_uip_ethaddr5
3263  0297 cd0000        	call	c_eewrc
3265                     ; 394     stored_uip_ethaddr6 = 0x00;	//MAC LSB
3267  029a 4f            	clr	a
3268  029b ae0017        	ldw	x,#_stored_uip_ethaddr6
3269  029e cd0000        	call	c_eewrc
3271                     ; 396     uip_ethaddr1 = stored_uip_ethaddr1;	//MAC MSB
3273  02a1 35c20002      	mov	_uip_ethaddr1,#194
3274                     ; 397     uip_ethaddr2 = stored_uip_ethaddr2;
3276  02a5 354d0003      	mov	_uip_ethaddr2,#77
3277                     ; 398     uip_ethaddr3 = stored_uip_ethaddr3;
3279  02a9 35690004      	mov	_uip_ethaddr3,#105
3280                     ; 399     uip_ethaddr4 = stored_uip_ethaddr4;
3282  02ad 356b0005      	mov	_uip_ethaddr4,#107
3283                     ; 400     uip_ethaddr5 = stored_uip_ethaddr5;
3285  02b1 35650006      	mov	_uip_ethaddr5,#101
3286                     ; 401     uip_ethaddr6 = stored_uip_ethaddr6;	//MAC LSB
3288  02b5 725f0007      	clr	_uip_ethaddr6
3289                     ; 403     uip_ethaddr.addr[0] = uip_ethaddr1;
3291  02b9 35c20000      	mov	_uip_ethaddr,#194
3292                     ; 404     uip_ethaddr.addr[1] = uip_ethaddr2;
3294  02bd 354d0001      	mov	_uip_ethaddr+1,#77
3295                     ; 405     uip_ethaddr.addr[2] = uip_ethaddr3;
3297  02c1 35690002      	mov	_uip_ethaddr+2,#105
3298                     ; 406     uip_ethaddr.addr[3] = uip_ethaddr4;
3300  02c5 356b0003      	mov	_uip_ethaddr+3,#107
3301                     ; 407     uip_ethaddr.addr[4] = uip_ethaddr5;
3303  02c9 35650004      	mov	_uip_ethaddr+4,#101
3304                     ; 408     uip_ethaddr.addr[5] = uip_ethaddr6;
3306  02cd 725f0005      	clr	_uip_ethaddr+5
3307                     ; 410     stored_devicename[0] = 'N' ; // Device name first character
3309  02d1 a64e          	ld	a,#78
3310  02d3 ae0000        	ldw	x,#_stored_devicename
3311  02d6 cd0000        	call	c_eewrc
3313                     ; 411     stored_devicename[1] = 'e' ; //
3315  02d9 a665          	ld	a,#101
3316  02db ae0001        	ldw	x,#_stored_devicename+1
3317  02de cd0000        	call	c_eewrc
3319                     ; 412     stored_devicename[2] = 'w' ; //
3321  02e1 a677          	ld	a,#119
3322  02e3 ae0002        	ldw	x,#_stored_devicename+2
3323  02e6 cd0000        	call	c_eewrc
3325                     ; 413     stored_devicename[3] = 'D' ; //
3327  02e9 a644          	ld	a,#68
3328  02eb ae0003        	ldw	x,#_stored_devicename+3
3329  02ee cd0000        	call	c_eewrc
3331                     ; 414     stored_devicename[4] = 'e' ; //
3333  02f1 a665          	ld	a,#101
3334  02f3 ae0004        	ldw	x,#_stored_devicename+4
3335  02f6 cd0000        	call	c_eewrc
3337                     ; 415     stored_devicename[5] = 'v' ; //
3339  02f9 a676          	ld	a,#118
3340  02fb ae0005        	ldw	x,#_stored_devicename+5
3341  02fe cd0000        	call	c_eewrc
3343                     ; 416     stored_devicename[6] = 'i' ; //
3345  0301 a669          	ld	a,#105
3346  0303 ae0006        	ldw	x,#_stored_devicename+6
3347  0306 cd0000        	call	c_eewrc
3349                     ; 417     stored_devicename[7] = 'c' ; //
3351  0309 a663          	ld	a,#99
3352  030b ae0007        	ldw	x,#_stored_devicename+7
3353  030e cd0000        	call	c_eewrc
3355                     ; 418     stored_devicename[8] = 'e' ; //
3357  0311 a665          	ld	a,#101
3358  0313 ae0008        	ldw	x,#_stored_devicename+8
3359  0316 cd0000        	call	c_eewrc
3361                     ; 419     stored_devicename[9] = '0' ; //
3363  0319 a630          	ld	a,#48
3364  031b ae0009        	ldw	x,#_stored_devicename+9
3365  031e cd0000        	call	c_eewrc
3367                     ; 420     stored_devicename[10] = '0' ; //
3369  0321 a630          	ld	a,#48
3370  0323 ae000a        	ldw	x,#_stored_devicename+10
3371  0326 cd0000        	call	c_eewrc
3373                     ; 421     stored_devicename[11] = '0' ; //
3375  0329 a630          	ld	a,#48
3376  032b ae000b        	ldw	x,#_stored_devicename+11
3377  032e cd0000        	call	c_eewrc
3379                     ; 422     stored_devicename[12] = ' ' ; //
3381  0331 a620          	ld	a,#32
3382  0333 ae000c        	ldw	x,#_stored_devicename+12
3383  0336 cd0000        	call	c_eewrc
3385                     ; 423     stored_devicename[13] = ' ' ; //
3387  0339 a620          	ld	a,#32
3388  033b ae000d        	ldw	x,#_stored_devicename+13
3389  033e cd0000        	call	c_eewrc
3391                     ; 424     stored_devicename[14] = ' ' ; //
3393  0341 a620          	ld	a,#32
3394  0343 ae000e        	ldw	x,#_stored_devicename+14
3395  0346 cd0000        	call	c_eewrc
3397                     ; 425     stored_devicename[15] = ' ' ; //
3399  0349 a620          	ld	a,#32
3400  034b ae000f        	ldw	x,#_stored_devicename+15
3401  034e cd0000        	call	c_eewrc
3403                     ; 426     stored_devicename[16] = ' ' ; //
3405  0351 a620          	ld	a,#32
3406  0353 ae0010        	ldw	x,#_stored_devicename+16
3407  0356 cd0000        	call	c_eewrc
3409                     ; 427     stored_devicename[17] = ' ' ; //
3411  0359 a620          	ld	a,#32
3412  035b ae0011        	ldw	x,#_stored_devicename+17
3413  035e cd0000        	call	c_eewrc
3415                     ; 428     stored_devicename[18] = ' ' ; //
3417  0361 a620          	ld	a,#32
3418  0363 ae0012        	ldw	x,#_stored_devicename+18
3419  0366 cd0000        	call	c_eewrc
3421                     ; 429     stored_devicename[19] = ' ' ; // Device name last character
3423  0369 a620          	ld	a,#32
3424  036b ae0013        	ldw	x,#_stored_devicename+19
3425  036e cd0000        	call	c_eewrc
3427                     ; 432     invert_output = 0;                  // Turn off output invert bit
3429  0371 725f0042      	clr	_invert_output
3430                     ; 433     stored_invert_output = 0;           // Store in EEPROM
3432  0375 4f            	clr	a
3433  0376 ae0014        	ldw	x,#_stored_invert_output
3434  0379 cd0000        	call	c_eewrc
3436                     ; 434     Relays_16to9 = (uint8_t)0x00;       // Turn off Relays 16 to 9
3438  037c 725f0044      	clr	_Relays_16to9
3439                     ; 435     Relays_8to1  = (uint8_t)0x00;       // Turn off Relays 8 to 1
3441  0380 725f0043      	clr	_Relays_8to1
3442                     ; 436     stored_Relays_16to9 = Relays_16to9; // Store in EEPROM
3444  0384 4f            	clr	a
3445  0385 ae0016        	ldw	x,#_stored_Relays_16to9
3446  0388 cd0000        	call	c_eewrc
3448                     ; 437     stored_Relays_8to1 = Relays_8to1;   // Store in EEPROM
3450  038b 4f            	clr	a
3451  038c ae0015        	ldw	x,#_stored_Relays_8to1
3452  038f cd0000        	call	c_eewrc
3454                     ; 438     update_relay_control_registers();   // Set Relay Control outputs
3456  0392 cd0675        	call	_update_relay_control_registers
3458                     ; 441     magic4 = 0x55;		// MSB
3460  0395 a655          	ld	a,#85
3461  0397 ae002e        	ldw	x,#_magic4
3462  039a cd0000        	call	c_eewrc
3464                     ; 442     magic3 = 0xee;		//
3466  039d a6ee          	ld	a,#238
3467  039f ae002d        	ldw	x,#_magic3
3468  03a2 cd0000        	call	c_eewrc
3470                     ; 443     magic2 = 0x0f;		//
3472  03a5 a60f          	ld	a,#15
3473  03a7 ae002c        	ldw	x,#_magic2
3474  03aa cd0000        	call	c_eewrc
3476                     ; 444     magic1 = 0xf0;		// LSB
3478  03ad a6f0          	ld	a,#240
3479  03af ae002b        	ldw	x,#_magic1
3480  03b2 cd0000        	call	c_eewrc
3482  03b5               L3002:
3483                     ; 449   Pending_hostaddr4 = stored_hostaddr4;
3485  03b5 55002a001b    	mov	_Pending_hostaddr4,_stored_hostaddr4
3486                     ; 450   Pending_hostaddr3 = stored_hostaddr3;
3488  03ba 550029001a    	mov	_Pending_hostaddr3,_stored_hostaddr3
3489                     ; 451   Pending_hostaddr2 = stored_hostaddr2;
3491  03bf 5500280019    	mov	_Pending_hostaddr2,_stored_hostaddr2
3492                     ; 452   Pending_hostaddr1 = stored_hostaddr1;
3494  03c4 5500270018    	mov	_Pending_hostaddr1,_stored_hostaddr1
3495                     ; 454   Pending_draddr4 = stored_draddr4;
3497  03c9 5500260017    	mov	_Pending_draddr4,_stored_draddr4
3498                     ; 455   Pending_draddr3 = stored_draddr3;
3500  03ce 5500250016    	mov	_Pending_draddr3,_stored_draddr3
3501                     ; 456   Pending_draddr2 = stored_draddr2;
3503  03d3 5500240015    	mov	_Pending_draddr2,_stored_draddr2
3504                     ; 457   Pending_draddr1 = stored_draddr1;
3506  03d8 5500230014    	mov	_Pending_draddr1,_stored_draddr1
3507                     ; 459   Pending_netmask4 = stored_netmask4;
3509  03dd 5500220013    	mov	_Pending_netmask4,_stored_netmask4
3510                     ; 460   Pending_netmask3 = stored_netmask3;
3512  03e2 5500210012    	mov	_Pending_netmask3,_stored_netmask3
3513                     ; 461   Pending_netmask2 = stored_netmask2;
3515  03e7 5500200011    	mov	_Pending_netmask2,_stored_netmask2
3516                     ; 462   Pending_netmask1 = stored_netmask1;
3518  03ec 55001f0010    	mov	_Pending_netmask1,_stored_netmask1
3519                     ; 464   Pending_port = stored_port;
3521  03f1 ce001d        	ldw	x,_stored_port
3522  03f4 cf000e        	ldw	_Pending_port,x
3523                     ; 466   Pending_uip_ethaddr6 = stored_uip_ethaddr6;
3525  03f7 550017000d    	mov	_Pending_uip_ethaddr6,_stored_uip_ethaddr6
3526                     ; 467   Pending_uip_ethaddr5 = stored_uip_ethaddr5;
3528  03fc 550018000c    	mov	_Pending_uip_ethaddr5,_stored_uip_ethaddr5
3529                     ; 468   Pending_uip_ethaddr4 = stored_uip_ethaddr4;
3531  0401 550019000b    	mov	_Pending_uip_ethaddr4,_stored_uip_ethaddr4
3532                     ; 469   Pending_uip_ethaddr3 = stored_uip_ethaddr3;
3534  0406 55001a000a    	mov	_Pending_uip_ethaddr3,_stored_uip_ethaddr3
3535                     ; 470   Pending_uip_ethaddr2 = stored_uip_ethaddr2;
3537  040b 55001b0009    	mov	_Pending_uip_ethaddr2,_stored_uip_ethaddr2
3538                     ; 471   Pending_uip_ethaddr1 = stored_uip_ethaddr1;
3540  0410 55001c0008    	mov	_Pending_uip_ethaddr1,_stored_uip_ethaddr1
3541                     ; 474   ex_stored_hostaddr4 = stored_hostaddr4;
3543  0415 55002a003d    	mov	_ex_stored_hostaddr4,_stored_hostaddr4
3544                     ; 475   ex_stored_hostaddr3 = stored_hostaddr3;
3546  041a 550029003c    	mov	_ex_stored_hostaddr3,_stored_hostaddr3
3547                     ; 476   ex_stored_hostaddr2 = stored_hostaddr2;
3549  041f 550028003b    	mov	_ex_stored_hostaddr2,_stored_hostaddr2
3550                     ; 477   ex_stored_hostaddr1 = stored_hostaddr1;
3552  0424 550027003a    	mov	_ex_stored_hostaddr1,_stored_hostaddr1
3553                     ; 479   ex_stored_draddr4 = stored_draddr4;
3555  0429 5500260039    	mov	_ex_stored_draddr4,_stored_draddr4
3556                     ; 480   ex_stored_draddr3 = stored_draddr3;
3558  042e 5500250038    	mov	_ex_stored_draddr3,_stored_draddr3
3559                     ; 481   ex_stored_draddr2 = stored_draddr2;
3561  0433 5500240037    	mov	_ex_stored_draddr2,_stored_draddr2
3562                     ; 482   ex_stored_draddr1 = stored_draddr1;
3564  0438 5500230036    	mov	_ex_stored_draddr1,_stored_draddr1
3565                     ; 484   ex_stored_netmask4 = stored_netmask4;
3567  043d 5500220035    	mov	_ex_stored_netmask4,_stored_netmask4
3568                     ; 485   ex_stored_netmask3 = stored_netmask3;
3570  0442 5500210034    	mov	_ex_stored_netmask3,_stored_netmask3
3571                     ; 486   ex_stored_netmask2 = stored_netmask2;
3573  0447 5500200033    	mov	_ex_stored_netmask2,_stored_netmask2
3574                     ; 487   ex_stored_netmask1 = stored_netmask1;
3576  044c 55001f0032    	mov	_ex_stored_netmask1,_stored_netmask1
3577                     ; 489   ex_stored_port = stored_port;
3579  0451 cf0030        	ldw	_ex_stored_port,x
3580                     ; 491   for(i=0; i<20; i++) { ex_stored_devicename[i] = stored_devicename[i]; }
3582  0454 4f            	clr	a
3583  0455 6b01          	ld	(OFST+0,sp),a
3585  0457               L5302:
3588  0457 5f            	clrw	x
3589  0458 97            	ld	xl,a
3590  0459 d60000        	ld	a,(_stored_devicename,x)
3591  045c d7001c        	ld	(_ex_stored_devicename,x),a
3594  045f 0c01          	inc	(OFST+0,sp)
3598  0461 7b01          	ld	a,(OFST+0,sp)
3599  0463 a114          	cp	a,#20
3600  0465 25f0          	jrult	L5302
3601                     ; 493 }
3604  0467 84            	pop	a
3605  0468 81            	ret	
3696                     ; 496 void check_runtime_changes(void)
3696                     ; 497 {
3697                     	switch	.text
3698  0469               _check_runtime_changes:
3700  0469 88            	push	a
3701       00000001      OFST:	set	1
3704                     ; 505   if ((invert_output != stored_invert_output)
3704                     ; 506    || (stored_Relays_16to9 != Relays_16to9)
3704                     ; 507    || (stored_Relays_8to1 != Relays_8to1)) {
3706  046a c60042        	ld	a,_invert_output
3707  046d c10014        	cp	a,_stored_invert_output
3708  0470 2610          	jrne	L1602
3710  0472 c60016        	ld	a,_stored_Relays_16to9
3711  0475 c10044        	cp	a,_Relays_16to9
3712  0478 2608          	jrne	L1602
3714  047a c60015        	ld	a,_stored_Relays_8to1
3715  047d c10043        	cp	a,_Relays_8to1
3716  0480 271e          	jreq	L7502
3717  0482               L1602:
3718                     ; 509     stored_invert_output = invert_output;
3720  0482 c60042        	ld	a,_invert_output
3721  0485 ae0014        	ldw	x,#_stored_invert_output
3722  0488 cd0000        	call	c_eewrc
3724                     ; 511     stored_Relays_16to9 = Relays_16to9;
3726  048b c60044        	ld	a,_Relays_16to9
3727  048e ae0016        	ldw	x,#_stored_Relays_16to9
3728  0491 cd0000        	call	c_eewrc
3730                     ; 512     stored_Relays_8to1 = Relays_8to1;
3732  0494 c60043        	ld	a,_Relays_8to1
3733  0497 ae0015        	ldw	x,#_stored_Relays_8to1
3734  049a cd0000        	call	c_eewrc
3736                     ; 514     update_relay_control_registers();
3738  049d cd0675        	call	_update_relay_control_registers
3740  04a0               L7502:
3741                     ; 518   if (stored_hostaddr4 != Pending_hostaddr4 ||
3741                     ; 519       stored_hostaddr3 != Pending_hostaddr3 ||
3741                     ; 520       stored_hostaddr2 != Pending_hostaddr2 ||
3741                     ; 521       stored_hostaddr1 != Pending_hostaddr1) {
3743  04a0 c6002a        	ld	a,_stored_hostaddr4
3744  04a3 c1001b        	cp	a,_Pending_hostaddr4
3745  04a6 2618          	jrne	L7602
3747  04a8 c60029        	ld	a,_stored_hostaddr3
3748  04ab c1001a        	cp	a,_Pending_hostaddr3
3749  04ae 2610          	jrne	L7602
3751  04b0 c60028        	ld	a,_stored_hostaddr2
3752  04b3 c10019        	cp	a,_Pending_hostaddr2
3753  04b6 2608          	jrne	L7602
3755  04b8 c60027        	ld	a,_stored_hostaddr1
3756  04bb c10018        	cp	a,_Pending_hostaddr1
3757  04be 2728          	jreq	L5602
3758  04c0               L7602:
3759                     ; 523     stored_hostaddr4 = Pending_hostaddr4;
3761  04c0 c6001b        	ld	a,_Pending_hostaddr4
3762  04c3 ae002a        	ldw	x,#_stored_hostaddr4
3763  04c6 cd0000        	call	c_eewrc
3765                     ; 524     stored_hostaddr3 = Pending_hostaddr3;
3767  04c9 c6001a        	ld	a,_Pending_hostaddr3
3768  04cc ae0029        	ldw	x,#_stored_hostaddr3
3769  04cf cd0000        	call	c_eewrc
3771                     ; 525     stored_hostaddr2 = Pending_hostaddr2;
3773  04d2 c60019        	ld	a,_Pending_hostaddr2
3774  04d5 ae0028        	ldw	x,#_stored_hostaddr2
3775  04d8 cd0000        	call	c_eewrc
3777                     ; 526     stored_hostaddr1 = Pending_hostaddr1;
3779  04db c60018        	ld	a,_Pending_hostaddr1
3780  04de ae0027        	ldw	x,#_stored_hostaddr1
3781  04e1 cd0000        	call	c_eewrc
3783                     ; 528     submit_changes = 1;
3785  04e4 35010001      	mov	_submit_changes,#1
3786  04e8               L5602:
3787                     ; 532   if (stored_draddr4 != Pending_draddr4 ||
3787                     ; 533       stored_draddr3 != Pending_draddr3 ||
3787                     ; 534       stored_draddr2 != Pending_draddr2 ||
3787                     ; 535       stored_draddr1 != Pending_draddr1) {
3789  04e8 c60026        	ld	a,_stored_draddr4
3790  04eb c10017        	cp	a,_Pending_draddr4
3791  04ee 2618          	jrne	L7702
3793  04f0 c60025        	ld	a,_stored_draddr3
3794  04f3 c10016        	cp	a,_Pending_draddr3
3795  04f6 2610          	jrne	L7702
3797  04f8 c60024        	ld	a,_stored_draddr2
3798  04fb c10015        	cp	a,_Pending_draddr2
3799  04fe 2608          	jrne	L7702
3801  0500 c60023        	ld	a,_stored_draddr1
3802  0503 c10014        	cp	a,_Pending_draddr1
3803  0506 2728          	jreq	L5702
3804  0508               L7702:
3805                     ; 537     stored_draddr4 = Pending_draddr4;
3807  0508 c60017        	ld	a,_Pending_draddr4
3808  050b ae0026        	ldw	x,#_stored_draddr4
3809  050e cd0000        	call	c_eewrc
3811                     ; 538     stored_draddr3 = Pending_draddr3;
3813  0511 c60016        	ld	a,_Pending_draddr3
3814  0514 ae0025        	ldw	x,#_stored_draddr3
3815  0517 cd0000        	call	c_eewrc
3817                     ; 539     stored_draddr2 = Pending_draddr2;
3819  051a c60015        	ld	a,_Pending_draddr2
3820  051d ae0024        	ldw	x,#_stored_draddr2
3821  0520 cd0000        	call	c_eewrc
3823                     ; 540     stored_draddr1 = Pending_draddr1;
3825  0523 c60014        	ld	a,_Pending_draddr1
3826  0526 ae0023        	ldw	x,#_stored_draddr1
3827  0529 cd0000        	call	c_eewrc
3829                     ; 542     submit_changes = 1;
3831  052c 35010001      	mov	_submit_changes,#1
3832  0530               L5702:
3833                     ; 546   if (stored_netmask4 != Pending_netmask4 ||
3833                     ; 547       stored_netmask3 != Pending_netmask3 ||
3833                     ; 548       stored_netmask2 != Pending_netmask2 ||
3833                     ; 549       stored_netmask1 != Pending_netmask1) {
3835  0530 c60022        	ld	a,_stored_netmask4
3836  0533 c10013        	cp	a,_Pending_netmask4
3837  0536 2618          	jrne	L7012
3839  0538 c60021        	ld	a,_stored_netmask3
3840  053b c10012        	cp	a,_Pending_netmask3
3841  053e 2610          	jrne	L7012
3843  0540 c60020        	ld	a,_stored_netmask2
3844  0543 c10011        	cp	a,_Pending_netmask2
3845  0546 2608          	jrne	L7012
3847  0548 c6001f        	ld	a,_stored_netmask1
3848  054b c10010        	cp	a,_Pending_netmask1
3849  054e 2728          	jreq	L5012
3850  0550               L7012:
3851                     ; 551     stored_netmask4 = Pending_netmask4;
3853  0550 c60013        	ld	a,_Pending_netmask4
3854  0553 ae0022        	ldw	x,#_stored_netmask4
3855  0556 cd0000        	call	c_eewrc
3857                     ; 552     stored_netmask3 = Pending_netmask3;
3859  0559 c60012        	ld	a,_Pending_netmask3
3860  055c ae0021        	ldw	x,#_stored_netmask3
3861  055f cd0000        	call	c_eewrc
3863                     ; 553     stored_netmask2 = Pending_netmask2;
3865  0562 c60011        	ld	a,_Pending_netmask2
3866  0565 ae0020        	ldw	x,#_stored_netmask2
3867  0568 cd0000        	call	c_eewrc
3869                     ; 554     stored_netmask1 = Pending_netmask1;
3871  056b c60010        	ld	a,_Pending_netmask1
3872  056e ae001f        	ldw	x,#_stored_netmask1
3873  0571 cd0000        	call	c_eewrc
3875                     ; 556     submit_changes = 1;
3877  0574 35010001      	mov	_submit_changes,#1
3878  0578               L5012:
3879                     ; 560   if (stored_port != Pending_port) {
3881  0578 ce001d        	ldw	x,_stored_port
3882  057b c3000e        	cpw	x,_Pending_port
3883  057e 270f          	jreq	L5112
3884                     ; 562     stored_port = Pending_port;
3886  0580 ce000e        	ldw	x,_Pending_port
3887  0583 89            	pushw	x
3888  0584 ae001d        	ldw	x,#_stored_port
3889  0587 cd0000        	call	c_eewrw
3891  058a 35010001      	mov	_submit_changes,#1
3892  058e 85            	popw	x
3893                     ; 564     submit_changes = 1;
3895  058f               L5112:
3896                     ; 568   devicename_changed = 0;
3898  058f 725f0000      	clr	_devicename_changed
3899                     ; 569   for(i=0; i<20; i++) {
3901  0593 4f            	clr	a
3902  0594 6b01          	ld	(OFST+0,sp),a
3904  0596               L7112:
3905                     ; 570     if (stored_devicename[i] != ex_stored_devicename[i]) devicename_changed = 1;
3907  0596 5f            	clrw	x
3908  0597 97            	ld	xl,a
3909  0598 905f          	clrw	y
3910  059a 9097          	ld	yl,a
3911  059c 90d60000      	ld	a,(_stored_devicename,y)
3912  05a0 d1001c        	cp	a,(_ex_stored_devicename,x)
3913  05a3 2704          	jreq	L5212
3916  05a5 35010000      	mov	_devicename_changed,#1
3917  05a9               L5212:
3918                     ; 569   for(i=0; i<20; i++) {
3920  05a9 0c01          	inc	(OFST+0,sp)
3924  05ab 7b01          	ld	a,(OFST+0,sp)
3925  05ad a114          	cp	a,#20
3926  05af 25e5          	jrult	L7112
3927                     ; 572   if (devicename_changed == 1) {
3929  05b1 c60000        	ld	a,_devicename_changed
3930  05b4 4a            	dec	a
3931  05b5 2612          	jrne	L7212
3932                     ; 574     for(i=0; i<20; i++) { stored_devicename[i] = ex_stored_devicename[i]; }
3934  05b7 6b01          	ld	(OFST+0,sp),a
3936  05b9               L1312:
3939  05b9 5f            	clrw	x
3940  05ba 97            	ld	xl,a
3941  05bb d6001c        	ld	a,(_ex_stored_devicename,x)
3942  05be d70000        	ld	(_stored_devicename,x),a
3945  05c1 0c01          	inc	(OFST+0,sp)
3949  05c3 7b01          	ld	a,(OFST+0,sp)
3950  05c5 a114          	cp	a,#20
3951  05c7 25f0          	jrult	L1312
3952  05c9               L7212:
3953                     ; 578   if (stored_uip_ethaddr6 != Pending_uip_ethaddr6 ||
3953                     ; 579       stored_uip_ethaddr5 != Pending_uip_ethaddr5 ||
3953                     ; 580       stored_uip_ethaddr4 != Pending_uip_ethaddr4 ||
3953                     ; 581       stored_uip_ethaddr3 != Pending_uip_ethaddr3 ||
3953                     ; 582       stored_uip_ethaddr2 != Pending_uip_ethaddr2 ||
3953                     ; 583       stored_uip_ethaddr1 != Pending_uip_ethaddr1) {
3955  05c9 c60017        	ld	a,_stored_uip_ethaddr6
3956  05cc c1000d        	cp	a,_Pending_uip_ethaddr6
3957  05cf 2628          	jrne	L1412
3959  05d1 c60018        	ld	a,_stored_uip_ethaddr5
3960  05d4 c1000c        	cp	a,_Pending_uip_ethaddr5
3961  05d7 2620          	jrne	L1412
3963  05d9 c60019        	ld	a,_stored_uip_ethaddr4
3964  05dc c1000b        	cp	a,_Pending_uip_ethaddr4
3965  05df 2618          	jrne	L1412
3967  05e1 c6001a        	ld	a,_stored_uip_ethaddr3
3968  05e4 c1000a        	cp	a,_Pending_uip_ethaddr3
3969  05e7 2610          	jrne	L1412
3971  05e9 c6001b        	ld	a,_stored_uip_ethaddr2
3972  05ec c10009        	cp	a,_Pending_uip_ethaddr2
3973  05ef 2608          	jrne	L1412
3975  05f1 c6001c        	ld	a,_stored_uip_ethaddr1
3976  05f4 c10008        	cp	a,_Pending_uip_ethaddr1
3977  05f7 273a          	jreq	L7312
3978  05f9               L1412:
3979                     ; 585     stored_uip_ethaddr6 = Pending_uip_ethaddr6;
3981  05f9 c6000d        	ld	a,_Pending_uip_ethaddr6
3982  05fc ae0017        	ldw	x,#_stored_uip_ethaddr6
3983  05ff cd0000        	call	c_eewrc
3985                     ; 586     stored_uip_ethaddr5 = Pending_uip_ethaddr5;
3987  0602 c6000c        	ld	a,_Pending_uip_ethaddr5
3988  0605 ae0018        	ldw	x,#_stored_uip_ethaddr5
3989  0608 cd0000        	call	c_eewrc
3991                     ; 587     stored_uip_ethaddr4 = Pending_uip_ethaddr4;
3993  060b c6000b        	ld	a,_Pending_uip_ethaddr4
3994  060e ae0019        	ldw	x,#_stored_uip_ethaddr4
3995  0611 cd0000        	call	c_eewrc
3997                     ; 588     stored_uip_ethaddr3 = Pending_uip_ethaddr3;
3999  0614 c6000a        	ld	a,_Pending_uip_ethaddr3
4000  0617 ae001a        	ldw	x,#_stored_uip_ethaddr3
4001  061a cd0000        	call	c_eewrc
4003                     ; 589     stored_uip_ethaddr2 = Pending_uip_ethaddr2;
4005  061d c60009        	ld	a,_Pending_uip_ethaddr2
4006  0620 ae001b        	ldw	x,#_stored_uip_ethaddr2
4007  0623 cd0000        	call	c_eewrc
4009                     ; 590     stored_uip_ethaddr1 = Pending_uip_ethaddr1;
4011  0626 c60008        	ld	a,_Pending_uip_ethaddr1
4012  0629 ae001c        	ldw	x,#_stored_uip_ethaddr1
4013  062c cd0000        	call	c_eewrc
4015                     ; 592     submit_changes = 1;
4017  062f 35010001      	mov	_submit_changes,#1
4018  0633               L7312:
4019                     ; 595   if (submit_changes == 1) {
4021  0633 c60001        	ld	a,_submit_changes
4022  0636 a101          	cp	a,#1
4023  0638 2613          	jrne	L3512
4024                     ; 602     check_eeprom_settings(); // Verify EEPROM up to date
4026  063a cd00ca        	call	_check_eeprom_settings
4028                     ; 603     Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
4030  063d cd0000        	call	_Enc28j60Init
4032                     ; 604     uip_arp_init();          // Initialize the ARP module
4034  0640 cd0000        	call	_uip_arp_init
4036                     ; 605     uip_init();              // Initialize uIP
4038  0643 cd0000        	call	_uip_init
4040                     ; 606     HttpDInit();             // Initialize httpd; sets up listening ports
4042  0646 cd0000        	call	_HttpDInit
4044                     ; 607     submit_changes = 0;
4046  0649 4f            	clr	a
4047  064a c70001        	ld	_submit_changes,a
4048  064d               L3512:
4049                     ; 610   if (submit_changes == 2) {
4051  064d a102          	cp	a,#2
4052  064f 2622          	jrne	L5512
4053                     ; 613     LEDcontrol(0);  // turn LED off
4055  0651 4f            	clr	a
4056  0652 cd0000        	call	_LEDcontrol
4058                     ; 615     WWDG_WR = (uint8_t)0x7f;     // Window register reset
4060  0655 357f50d2      	mov	_WWDG_WR,#127
4061                     ; 616     WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
4063  0659 35ff50d1      	mov	_WWDG_CR,#255
4064                     ; 617     WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
4066  065d 356050d2      	mov	_WWDG_WR,#96
4067                     ; 620     wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
4069  0661 aec350        	ldw	x,#50000
4070  0664 cd0000        	call	_wait_timer
4072                     ; 621     wait_timer((uint16_t)50000);
4074  0667 aec350        	ldw	x,#50000
4075  066a cd0000        	call	_wait_timer
4077                     ; 622     wait_timer((uint16_t)50000);
4079  066d aec350        	ldw	x,#50000
4080  0670 cd0000        	call	_wait_timer
4082  0673               L5512:
4083                     ; 624 }
4086  0673 84            	pop	a
4087  0674 81            	ret	
4119                     ; 627 void update_relay_control_registers(void)
4119                     ; 628 {
4120                     	switch	.text
4121  0675               _update_relay_control_registers:
4125                     ; 634   if (invert_output == 0) {
4127  0675 c60042        	ld	a,_invert_output
4128  0678 2703cc076b    	jrne	L7612
4129                     ; 635     if (Relays_16to9 & 0x80) PC_ODR |= (uint8_t)0x40; // Relay 16 on, PC bit 6 = 1
4131  067d 720f004406    	btjf	_Relays_16to9,#7,L1712
4134  0682 721c500a      	bset	_PC_ODR,#6
4136  0686 2004          	jra	L3712
4137  0688               L1712:
4138                     ; 636     else PC_ODR &= (uint8_t)(~0x40);
4140  0688 721d500a      	bres	_PC_ODR,#6
4141  068c               L3712:
4142                     ; 637     if (Relays_16to9 & 0x40) PG_ODR |= (uint8_t)0x01; // Relay 15 on, PG bit 0 = 1
4144  068c 720d004406    	btjf	_Relays_16to9,#6,L5712
4147  0691 7210501e      	bset	_PG_ODR,#0
4149  0695 2004          	jra	L7712
4150  0697               L5712:
4151                     ; 638     else PG_ODR &= (uint8_t)(~0x01);
4153  0697 7211501e      	bres	_PG_ODR,#0
4154  069b               L7712:
4155                     ; 639     if (Relays_16to9 & 0x20) PE_ODR |= (uint8_t)0x08; // Relay 14 on, PE bit 3 = 1
4157  069b 720b004406    	btjf	_Relays_16to9,#5,L1022
4160  06a0 72165014      	bset	_PE_ODR,#3
4162  06a4 2004          	jra	L3022
4163  06a6               L1022:
4164                     ; 640     else PE_ODR &= (uint8_t)(~0x08);
4166  06a6 72175014      	bres	_PE_ODR,#3
4167  06aa               L3022:
4168                     ; 641     if (Relays_16to9 & 0x10) PD_ODR |= (uint8_t)0x01; // Relay 13 on, PD bit 0 = 1
4170  06aa 7209004406    	btjf	_Relays_16to9,#4,L5022
4173  06af 7210500f      	bset	_PD_ODR,#0
4175  06b3 2004          	jra	L7022
4176  06b5               L5022:
4177                     ; 642     else PD_ODR &= (uint8_t)(~0x01);
4179  06b5 7211500f      	bres	_PD_ODR,#0
4180  06b9               L7022:
4181                     ; 643     if (Relays_16to9 & 0x08) PD_ODR |= (uint8_t)0x08; // Relay 12 on, PD bit 3 = 1
4183  06b9 7207004406    	btjf	_Relays_16to9,#3,L1122
4186  06be 7216500f      	bset	_PD_ODR,#3
4188  06c2 2004          	jra	L3122
4189  06c4               L1122:
4190                     ; 644     else PD_ODR &= (uint8_t)(~0x08);
4192  06c4 7217500f      	bres	_PD_ODR,#3
4193  06c8               L3122:
4194                     ; 645     if (Relays_16to9 & 0x04) PD_ODR |= (uint8_t)0x20; // Relay 11 on, PD bit 5 = 1
4196  06c8 7205004406    	btjf	_Relays_16to9,#2,L5122
4199  06cd 721a500f      	bset	_PD_ODR,#5
4201  06d1 2004          	jra	L7122
4202  06d3               L5122:
4203                     ; 646     else PD_ODR &= (uint8_t)(~0x20);
4205  06d3 721b500f      	bres	_PD_ODR,#5
4206  06d7               L7122:
4207                     ; 647     if (Relays_16to9 & 0x02) PD_ODR |= (uint8_t)0x80; // Relay 10 on, PD bit 7 = 1
4209  06d7 7203004406    	btjf	_Relays_16to9,#1,L1222
4212  06dc 721e500f      	bset	_PD_ODR,#7
4214  06e0 2004          	jra	L3222
4215  06e2               L1222:
4216                     ; 648     else PD_ODR &= (uint8_t)(~0x80);
4218  06e2 721f500f      	bres	_PD_ODR,#7
4219  06e6               L3222:
4220                     ; 649     if (Relays_16to9 & 0x01) PA_ODR |= (uint8_t)0x10; // Relay  9 on, PA bit 4 = 1
4222  06e6 7201004406    	btjf	_Relays_16to9,#0,L5222
4225  06eb 72185000      	bset	_PA_ODR,#4
4227  06ef 2004          	jra	L7222
4228  06f1               L5222:
4229                     ; 650     else PA_ODR &= (uint8_t)(~0x10);
4231  06f1 72195000      	bres	_PA_ODR,#4
4232  06f5               L7222:
4233                     ; 654     if (Relays_8to1 & 0x80) PC_ODR |= (uint8_t)0x80; // Relay  8 on, PC bit 7 = 1
4235  06f5 720f004306    	btjf	_Relays_8to1,#7,L1322
4238  06fa 721e500a      	bset	_PC_ODR,#7
4240  06fe 2004          	jra	L3322
4241  0700               L1322:
4242                     ; 655     else PC_ODR &= (uint8_t)(~0x80);
4244  0700 721f500a      	bres	_PC_ODR,#7
4245  0704               L3322:
4246                     ; 656     if (Relays_8to1 & 0x40) PG_ODR |= (uint8_t)0x02; // Relay  7 on, PG bit 1 = 1
4248  0704 720d004306    	btjf	_Relays_8to1,#6,L5322
4251  0709 7212501e      	bset	_PG_ODR,#1
4253  070d 2004          	jra	L7322
4254  070f               L5322:
4255                     ; 657     else PG_ODR &= (uint8_t)(~0x02);
4257  070f 7213501e      	bres	_PG_ODR,#1
4258  0713               L7322:
4259                     ; 658     if (Relays_8to1 & 0x20) PE_ODR |= (uint8_t)0x01; // Relay  6 on, PE bit 0 = 1
4261  0713 720b004306    	btjf	_Relays_8to1,#5,L1422
4264  0718 72105014      	bset	_PE_ODR,#0
4266  071c 2004          	jra	L3422
4267  071e               L1422:
4268                     ; 659     else PE_ODR &= (uint8_t)(~0x01);
4270  071e 72115014      	bres	_PE_ODR,#0
4271  0722               L3422:
4272                     ; 660     if (Relays_8to1 & 0x10) PD_ODR |= (uint8_t)0x04; // Relay  5 on, PD bit 2 = 1
4274  0722 7209004306    	btjf	_Relays_8to1,#4,L5422
4277  0727 7214500f      	bset	_PD_ODR,#2
4279  072b 2004          	jra	L7422
4280  072d               L5422:
4281                     ; 661     else PD_ODR &= (uint8_t)(~0x04);
4283  072d 7215500f      	bres	_PD_ODR,#2
4284  0731               L7422:
4285                     ; 662     if (Relays_8to1 & 0x08) PD_ODR |= (uint8_t)0x10; // Relay  4 on, PD bit 4 = 1
4287  0731 7207004306    	btjf	_Relays_8to1,#3,L1522
4290  0736 7218500f      	bset	_PD_ODR,#4
4292  073a 2004          	jra	L3522
4293  073c               L1522:
4294                     ; 663     else PD_ODR &= (uint8_t)(~0x10);
4296  073c 7219500f      	bres	_PD_ODR,#4
4297  0740               L3522:
4298                     ; 664     if (Relays_8to1 & 0x04) PD_ODR |= (uint8_t)0x40; // Relay  3 on, PD bit 6 = 1
4300  0740 7205004306    	btjf	_Relays_8to1,#2,L5522
4303  0745 721c500f      	bset	_PD_ODR,#6
4305  0749 2004          	jra	L7522
4306  074b               L5522:
4307                     ; 665     else PD_ODR &= (uint8_t)(~0x40);
4309  074b 721d500f      	bres	_PD_ODR,#6
4310  074f               L7522:
4311                     ; 666     if (Relays_8to1 & 0x02) PA_ODR |= (uint8_t)0x20; // Relay  2 on, PA bit 5 = 1
4313  074f 7203004306    	btjf	_Relays_8to1,#1,L1622
4316  0754 721a5000      	bset	_PA_ODR,#5
4318  0758 2004          	jra	L3622
4319  075a               L1622:
4320                     ; 667     else PA_ODR &= (uint8_t)(~0x20);
4322  075a 721b5000      	bres	_PA_ODR,#5
4323  075e               L3622:
4324                     ; 668     if (Relays_8to1 & 0x01) PA_ODR |= (uint8_t)0x08; // Relay  1 on, PA bit 3 = 1
4326  075e 7201004303    	btjf	_Relays_8to1,#0,L5622
4329  0763 cc085a        	jp	L1732
4330  0766               L5622:
4331                     ; 669     else PA_ODR &= (uint8_t)(~0x08);
4334  0766 72175000      	bres	_PA_ODR,#3
4336  076a 81            	ret	
4337  076b               L7612:
4338                     ; 672   else if (invert_output == 1) {
4340  076b 4a            	dec	a
4341  076c 2703cc085e    	jrne	L1722
4342                     ; 673     if (Relays_16to9 & 0x80) PC_ODR &= (uint8_t)(~0x40); // Relay 16 off, PC bit 6 = 0
4344  0771 720f004406    	btjf	_Relays_16to9,#7,L5722
4347  0776 721d500a      	bres	_PC_ODR,#6
4349  077a 2004          	jra	L7722
4350  077c               L5722:
4351                     ; 674     else PC_ODR |= (uint8_t)0x40;
4353  077c 721c500a      	bset	_PC_ODR,#6
4354  0780               L7722:
4355                     ; 675     if (Relays_16to9 & 0x40) PG_ODR &= (uint8_t)(~0x01); // Relay 15 off, PG bit 0 = 0
4357  0780 720d004406    	btjf	_Relays_16to9,#6,L1032
4360  0785 7211501e      	bres	_PG_ODR,#0
4362  0789 2004          	jra	L3032
4363  078b               L1032:
4364                     ; 676     else PG_ODR |= (uint8_t)0x01;
4366  078b 7210501e      	bset	_PG_ODR,#0
4367  078f               L3032:
4368                     ; 677     if (Relays_16to9 & 0x20) PE_ODR &= (uint8_t)(~0x08); // Relay 14 off, PE bit 3 = 0
4370  078f 720b004406    	btjf	_Relays_16to9,#5,L5032
4373  0794 72175014      	bres	_PE_ODR,#3
4375  0798 2004          	jra	L7032
4376  079a               L5032:
4377                     ; 678     else PE_ODR |= (uint8_t)0x08;
4379  079a 72165014      	bset	_PE_ODR,#3
4380  079e               L7032:
4381                     ; 679     if (Relays_16to9 & 0x10) PD_ODR &= (uint8_t)(~0x01); // Relay 13 off, PD bit 0 = 0
4383  079e 7209004406    	btjf	_Relays_16to9,#4,L1132
4386  07a3 7211500f      	bres	_PD_ODR,#0
4388  07a7 2004          	jra	L3132
4389  07a9               L1132:
4390                     ; 680     else PD_ODR |= (uint8_t)0x01;
4392  07a9 7210500f      	bset	_PD_ODR,#0
4393  07ad               L3132:
4394                     ; 681     if (Relays_16to9 & 0x08) PD_ODR &= (uint8_t)(~0x08); // Relay 12 off, PD bit 3 = 0
4396  07ad 7207004406    	btjf	_Relays_16to9,#3,L5132
4399  07b2 7217500f      	bres	_PD_ODR,#3
4401  07b6 2004          	jra	L7132
4402  07b8               L5132:
4403                     ; 682     else PD_ODR |= (uint8_t)0x08;
4405  07b8 7216500f      	bset	_PD_ODR,#3
4406  07bc               L7132:
4407                     ; 683     if (Relays_16to9 & 0x04) PD_ODR &= (uint8_t)(~0x20); // Relay 11 off, PD bit 5 = 0
4409  07bc 7205004406    	btjf	_Relays_16to9,#2,L1232
4412  07c1 721b500f      	bres	_PD_ODR,#5
4414  07c5 2004          	jra	L3232
4415  07c7               L1232:
4416                     ; 684     else PD_ODR |= (uint8_t)0x20;
4418  07c7 721a500f      	bset	_PD_ODR,#5
4419  07cb               L3232:
4420                     ; 685     if (Relays_16to9 & 0x02) PD_ODR &= (uint8_t)(~0x80); // Relay 10 off, PD bit 7 = 0
4422  07cb 7203004406    	btjf	_Relays_16to9,#1,L5232
4425  07d0 721f500f      	bres	_PD_ODR,#7
4427  07d4 2004          	jra	L7232
4428  07d6               L5232:
4429                     ; 686     else PD_ODR |= (uint8_t)0x80;
4431  07d6 721e500f      	bset	_PD_ODR,#7
4432  07da               L7232:
4433                     ; 687     if (Relays_16to9 & 0x01) PA_ODR &= (uint8_t)(~0x10); // Relay  9 off, PA bit 4 = 0
4435  07da 7201004406    	btjf	_Relays_16to9,#0,L1332
4438  07df 72195000      	bres	_PA_ODR,#4
4440  07e3 2004          	jra	L3332
4441  07e5               L1332:
4442                     ; 688     else PA_ODR |= (uint8_t)0x10;
4444  07e5 72185000      	bset	_PA_ODR,#4
4445  07e9               L3332:
4446                     ; 692     if (Relays_8to1 & 0x80) PC_ODR &= (uint8_t)(~0x80); // Relay  8 off, PC bit 7 = 0
4448  07e9 720f004306    	btjf	_Relays_8to1,#7,L5332
4451  07ee 721f500a      	bres	_PC_ODR,#7
4453  07f2 2004          	jra	L7332
4454  07f4               L5332:
4455                     ; 693     else PC_ODR |= (uint8_t)0x80;
4457  07f4 721e500a      	bset	_PC_ODR,#7
4458  07f8               L7332:
4459                     ; 694     if (Relays_8to1 & 0x40) PG_ODR &= (uint8_t)(~0x02); // Relay  7 off, PG bit 1 = 0
4461  07f8 720d004306    	btjf	_Relays_8to1,#6,L1432
4464  07fd 7213501e      	bres	_PG_ODR,#1
4466  0801 2004          	jra	L3432
4467  0803               L1432:
4468                     ; 695     else PG_ODR |= (uint8_t)0x02;
4470  0803 7212501e      	bset	_PG_ODR,#1
4471  0807               L3432:
4472                     ; 696     if (Relays_8to1 & 0x20) PE_ODR &= (uint8_t)(~0x01); // Relay  6 off, PE bit 0 = 0
4474  0807 720b004306    	btjf	_Relays_8to1,#5,L5432
4477  080c 72115014      	bres	_PE_ODR,#0
4479  0810 2004          	jra	L7432
4480  0812               L5432:
4481                     ; 697     else PE_ODR |= (uint8_t)0x01;
4483  0812 72105014      	bset	_PE_ODR,#0
4484  0816               L7432:
4485                     ; 698     if (Relays_8to1 & 0x10) PD_ODR &= (uint8_t)(~0x04); // Relay  5 off, PD bit 2 = 0
4487  0816 7209004306    	btjf	_Relays_8to1,#4,L1532
4490  081b 7215500f      	bres	_PD_ODR,#2
4492  081f 2004          	jra	L3532
4493  0821               L1532:
4494                     ; 699     else PD_ODR |= (uint8_t)0x04;
4496  0821 7214500f      	bset	_PD_ODR,#2
4497  0825               L3532:
4498                     ; 700     if (Relays_8to1 & 0x08) PD_ODR &= (uint8_t)(~0x10); // Relay  4 off, PD bit 4 = 0
4500  0825 7207004306    	btjf	_Relays_8to1,#3,L5532
4503  082a 7219500f      	bres	_PD_ODR,#4
4505  082e 2004          	jra	L7532
4506  0830               L5532:
4507                     ; 701     else PD_ODR |= (uint8_t)0x10;
4509  0830 7218500f      	bset	_PD_ODR,#4
4510  0834               L7532:
4511                     ; 702     if (Relays_8to1 & 0x04) PD_ODR &= (uint8_t)(~0x40); // Relay  3 off, PD bit 6 = 0
4513  0834 7205004306    	btjf	_Relays_8to1,#2,L1632
4516  0839 721d500f      	bres	_PD_ODR,#6
4518  083d 2004          	jra	L3632
4519  083f               L1632:
4520                     ; 703     else PD_ODR |= (uint8_t)0x40;
4522  083f 721c500f      	bset	_PD_ODR,#6
4523  0843               L3632:
4524                     ; 704     if (Relays_8to1 & 0x02) PA_ODR &= (uint8_t)(~0x20); // Relay  2 off, PA bit 5 = 0
4526  0843 7203004306    	btjf	_Relays_8to1,#1,L5632
4529  0848 721b5000      	bres	_PA_ODR,#5
4531  084c 2004          	jra	L7632
4532  084e               L5632:
4533                     ; 705     else PA_ODR |= (uint8_t)0x20;
4535  084e 721a5000      	bset	_PA_ODR,#5
4536  0852               L7632:
4537                     ; 706     if (Relays_8to1 & 0x01) PA_ODR &= (uint8_t)(~0x08); // Relay  1 off, PA bit 3 = 0
4539  0852 7201004303    	btjf	_Relays_8to1,#0,L1732
4542  0857 cc0766        	jp	L5622
4543  085a               L1732:
4544                     ; 707     else PA_ODR |= (uint8_t)0x08;
4547  085a 72165000      	bset	_PA_ODR,#3
4548  085e               L1722:
4549                     ; 709 }
4552  085e 81            	ret	
4616                     ; 711 void check_reset_button(void)
4616                     ; 712 {
4617                     	switch	.text
4618  085f               _check_reset_button:
4620  085f 88            	push	a
4621       00000001      OFST:	set	1
4624                     ; 717   if ((PA_IDR & 0x02) == 0) {
4626  0860 7203500103cc  	btjt	_PA_IDR,#1,L1142
4627                     ; 719     for (i=0; i<100; i++) {
4629  0868 0f01          	clr	(OFST+0,sp)
4631  086a               L3142:
4632                     ; 720       wait_timer(50000); // wait 50ms
4634  086a aec350        	ldw	x,#50000
4635  086d cd0000        	call	_wait_timer
4637                     ; 721       if ((PA_IDR & 0x02) == 1) {  // check Reset Button again. If released
4639  0870 c65001        	ld	a,_PA_IDR
4640  0873 a402          	and	a,#2
4641  0875 4a            	dec	a
4642  0876 2602          	jrne	L1242
4643                     ; 723         return;
4646  0878 84            	pop	a
4647  0879 81            	ret	
4648  087a               L1242:
4649                     ; 719     for (i=0; i<100; i++) {
4651  087a 0c01          	inc	(OFST+0,sp)
4655  087c 7b01          	ld	a,(OFST+0,sp)
4656  087e a164          	cp	a,#100
4657  0880 25e8          	jrult	L3142
4658                     ; 728     LEDcontrol(0);  // turn LED off
4660  0882 4f            	clr	a
4661  0883 cd0000        	call	_LEDcontrol
4664  0886               L5242:
4665                     ; 729     while((PA_IDR & 0x02) == 0) {  // Wait for button release
4667  0886 72035001fb    	btjf	_PA_IDR,#1,L5242
4668                     ; 732     magic4 = 0x00;		   // MSB Magic Number stored in EEPROM
4670  088b 4f            	clr	a
4671  088c ae002e        	ldw	x,#_magic4
4672  088f cd0000        	call	c_eewrc
4674                     ; 733     magic3 = 0x00;		   //
4676  0892 4f            	clr	a
4677  0893 ae002d        	ldw	x,#_magic3
4678  0896 cd0000        	call	c_eewrc
4680                     ; 734     magic2 = 0x00;		   //
4682  0899 4f            	clr	a
4683  089a ae002c        	ldw	x,#_magic2
4684  089d cd0000        	call	c_eewrc
4686                     ; 735     magic1 = 0x00;		   // LSB Magic Number
4688  08a0 4f            	clr	a
4689  08a1 ae002b        	ldw	x,#_magic1
4690  08a4 cd0000        	call	c_eewrc
4692                     ; 736     stored_hostaddr4 = 0x00;	   // MSB hostaddr stored in EEPROM
4694  08a7 4f            	clr	a
4695  08a8 ae002a        	ldw	x,#_stored_hostaddr4
4696  08ab cd0000        	call	c_eewrc
4698                     ; 737     stored_hostaddr3 = 0x00;	   //
4700  08ae 4f            	clr	a
4701  08af ae0029        	ldw	x,#_stored_hostaddr3
4702  08b2 cd0000        	call	c_eewrc
4704                     ; 738     stored_hostaddr2 = 0x00;	   //
4706  08b5 4f            	clr	a
4707  08b6 ae0028        	ldw	x,#_stored_hostaddr2
4708  08b9 cd0000        	call	c_eewrc
4710                     ; 739     stored_hostaddr1 = 0x00;	   // LSB hostaddr
4712  08bc 4f            	clr	a
4713  08bd ae0027        	ldw	x,#_stored_hostaddr1
4714  08c0 cd0000        	call	c_eewrc
4716                     ; 740     stored_draddr4 = 0x00;	   // MSB draddr stored in EEPROM
4718  08c3 4f            	clr	a
4719  08c4 ae0026        	ldw	x,#_stored_draddr4
4720  08c7 cd0000        	call	c_eewrc
4722                     ; 741     stored_draddr3 = 0x00;	   //
4724  08ca 4f            	clr	a
4725  08cb ae0025        	ldw	x,#_stored_draddr3
4726  08ce cd0000        	call	c_eewrc
4728                     ; 742     stored_draddr2 = 0x00;	   //
4730  08d1 4f            	clr	a
4731  08d2 ae0024        	ldw	x,#_stored_draddr2
4732  08d5 cd0000        	call	c_eewrc
4734                     ; 743     stored_draddr1 = 0x00;	   // LSB draddr
4736  08d8 4f            	clr	a
4737  08d9 ae0023        	ldw	x,#_stored_draddr1
4738  08dc cd0000        	call	c_eewrc
4740                     ; 744     stored_netmask4 = 0x00;	   // MSB netmask stored in EEPROM
4742  08df 4f            	clr	a
4743  08e0 ae0022        	ldw	x,#_stored_netmask4
4744  08e3 cd0000        	call	c_eewrc
4746                     ; 745     stored_netmask3 = 0x00;	   //
4748  08e6 4f            	clr	a
4749  08e7 ae0021        	ldw	x,#_stored_netmask3
4750  08ea cd0000        	call	c_eewrc
4752                     ; 746     stored_netmask2 = 0x00;	   //
4754  08ed 4f            	clr	a
4755  08ee ae0020        	ldw	x,#_stored_netmask2
4756  08f1 cd0000        	call	c_eewrc
4758                     ; 747     stored_netmask1 = 0x00;	   // LSB netmask
4760  08f4 4f            	clr	a
4761  08f5 ae001f        	ldw	x,#_stored_netmask1
4762  08f8 cd0000        	call	c_eewrc
4764                     ; 748     stored_port = 0x0000;	   // Port stored in EEPROM
4766  08fb 5f            	clrw	x
4767  08fc 89            	pushw	x
4768  08fd ae001d        	ldw	x,#_stored_port
4769  0900 cd0000        	call	c_eewrw
4771  0903 4f            	clr	a
4772  0904 85            	popw	x
4773                     ; 749     stored_uip_ethaddr1 = 0x00;	   // MAC MSB
4775  0905 ae001c        	ldw	x,#_stored_uip_ethaddr1
4776  0908 cd0000        	call	c_eewrc
4778                     ; 750     stored_uip_ethaddr2 = 0x00;	   //
4780  090b 4f            	clr	a
4781  090c ae001b        	ldw	x,#_stored_uip_ethaddr2
4782  090f cd0000        	call	c_eewrc
4784                     ; 751     stored_uip_ethaddr3 = 0x00;	   //
4786  0912 4f            	clr	a
4787  0913 ae001a        	ldw	x,#_stored_uip_ethaddr3
4788  0916 cd0000        	call	c_eewrc
4790                     ; 752     stored_uip_ethaddr4 = 0x00;	   //
4792  0919 4f            	clr	a
4793  091a ae0019        	ldw	x,#_stored_uip_ethaddr4
4794  091d cd0000        	call	c_eewrc
4796                     ; 753     stored_uip_ethaddr5 = 0x00;	   //
4798  0920 4f            	clr	a
4799  0921 ae0018        	ldw	x,#_stored_uip_ethaddr5
4800  0924 cd0000        	call	c_eewrc
4802                     ; 754     stored_uip_ethaddr6 = 0x00;	   // MAC LSB stored in EEPROM
4804  0927 4f            	clr	a
4805  0928 ae0017        	ldw	x,#_stored_uip_ethaddr6
4806  092b cd0000        	call	c_eewrc
4808                     ; 755     stored_Relays_16to9 = 0x00;    // Relay states for relays 16 to 9
4810  092e 4f            	clr	a
4811  092f ae0016        	ldw	x,#_stored_Relays_16to9
4812  0932 cd0000        	call	c_eewrc
4814                     ; 756     stored_Relays_8to1 = 0x00;     // Relay states for relays 8 to 1
4816  0935 4f            	clr	a
4817  0936 ae0015        	ldw	x,#_stored_Relays_8to1
4818  0939 cd0000        	call	c_eewrc
4820                     ; 757     stored_invert_output = 0x00;   // Relay state inversion control
4822  093c 4f            	clr	a
4823  093d ae0014        	ldw	x,#_stored_invert_output
4824  0940 cd0000        	call	c_eewrc
4826                     ; 758     stored_devicename[0] = 0x00;   // Device name
4828  0943 4f            	clr	a
4829  0944 ae0000        	ldw	x,#_stored_devicename
4830  0947 cd0000        	call	c_eewrc
4832                     ; 759     stored_devicename[1] = 0x00;   // Device name
4834  094a 4f            	clr	a
4835  094b ae0001        	ldw	x,#_stored_devicename+1
4836  094e cd0000        	call	c_eewrc
4838                     ; 760     stored_devicename[2] = 0x00;   // Device name
4840  0951 4f            	clr	a
4841  0952 ae0002        	ldw	x,#_stored_devicename+2
4842  0955 cd0000        	call	c_eewrc
4844                     ; 761     stored_devicename[3] = 0x00;   // Device name
4846  0958 4f            	clr	a
4847  0959 ae0003        	ldw	x,#_stored_devicename+3
4848  095c cd0000        	call	c_eewrc
4850                     ; 762     stored_devicename[4] = 0x00;   // Device name
4852  095f 4f            	clr	a
4853  0960 ae0004        	ldw	x,#_stored_devicename+4
4854  0963 cd0000        	call	c_eewrc
4856                     ; 763     stored_devicename[5] = 0x00;   // Device name
4858  0966 4f            	clr	a
4859  0967 ae0005        	ldw	x,#_stored_devicename+5
4860  096a cd0000        	call	c_eewrc
4862                     ; 764     stored_devicename[6] = 0x00;   // Device name
4864  096d 4f            	clr	a
4865  096e ae0006        	ldw	x,#_stored_devicename+6
4866  0971 cd0000        	call	c_eewrc
4868                     ; 765     stored_devicename[7] = 0x00;   // Device name
4870  0974 4f            	clr	a
4871  0975 ae0007        	ldw	x,#_stored_devicename+7
4872  0978 cd0000        	call	c_eewrc
4874                     ; 766     stored_devicename[8] = 0x00;   // Device name
4876  097b 4f            	clr	a
4877  097c ae0008        	ldw	x,#_stored_devicename+8
4878  097f cd0000        	call	c_eewrc
4880                     ; 767     stored_devicename[9] = 0x00;   // Device name
4882  0982 4f            	clr	a
4883  0983 ae0009        	ldw	x,#_stored_devicename+9
4884  0986 cd0000        	call	c_eewrc
4886                     ; 768     stored_devicename[10] = 0x00;  // Device name
4888  0989 4f            	clr	a
4889  098a ae000a        	ldw	x,#_stored_devicename+10
4890  098d cd0000        	call	c_eewrc
4892                     ; 769     stored_devicename[11] = 0x00;  // Device name
4894  0990 4f            	clr	a
4895  0991 ae000b        	ldw	x,#_stored_devicename+11
4896  0994 cd0000        	call	c_eewrc
4898                     ; 770     stored_devicename[12] = 0x00;  // Device name
4900  0997 4f            	clr	a
4901  0998 ae000c        	ldw	x,#_stored_devicename+12
4902  099b cd0000        	call	c_eewrc
4904                     ; 771     stored_devicename[13] = 0x00;  // Device name
4906  099e 4f            	clr	a
4907  099f ae000d        	ldw	x,#_stored_devicename+13
4908  09a2 cd0000        	call	c_eewrc
4910                     ; 772     stored_devicename[14] = 0x00;  // Device name
4912  09a5 4f            	clr	a
4913  09a6 ae000e        	ldw	x,#_stored_devicename+14
4914  09a9 cd0000        	call	c_eewrc
4916                     ; 773     stored_devicename[15] = 0x00;  // Device name
4918  09ac 4f            	clr	a
4919  09ad ae000f        	ldw	x,#_stored_devicename+15
4920  09b0 cd0000        	call	c_eewrc
4922                     ; 774     stored_devicename[16] = 0x00;  // Device name
4924  09b3 4f            	clr	a
4925  09b4 ae0010        	ldw	x,#_stored_devicename+16
4926  09b7 cd0000        	call	c_eewrc
4928                     ; 775     stored_devicename[17] = 0x00;  // Device name
4930  09ba 4f            	clr	a
4931  09bb ae0011        	ldw	x,#_stored_devicename+17
4932  09be cd0000        	call	c_eewrc
4934                     ; 776     stored_devicename[18] = 0x00;  // Device name
4936  09c1 4f            	clr	a
4937  09c2 ae0012        	ldw	x,#_stored_devicename+18
4938  09c5 cd0000        	call	c_eewrc
4940                     ; 777     stored_devicename[19] = 0x00;  // Device name
4942  09c8 4f            	clr	a
4943  09c9 ae0013        	ldw	x,#_stored_devicename+19
4944  09cc cd0000        	call	c_eewrc
4946                     ; 779     WWDG_WR = (uint8_t)0x7f;     // Window register reset
4948  09cf 357f50d2      	mov	_WWDG_WR,#127
4949                     ; 780     WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
4951  09d3 35ff50d1      	mov	_WWDG_CR,#255
4952                     ; 781     WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
4954  09d7 356050d2      	mov	_WWDG_WR,#96
4955                     ; 784     wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
4957  09db aec350        	ldw	x,#50000
4958  09de cd0000        	call	_wait_timer
4960                     ; 785     wait_timer((uint16_t)50000);
4962  09e1 aec350        	ldw	x,#50000
4963  09e4 cd0000        	call	_wait_timer
4965                     ; 786     wait_timer((uint16_t)50000);
4967  09e7 aec350        	ldw	x,#50000
4968  09ea cd0000        	call	_wait_timer
4970  09ed               L1142:
4971                     ; 788 }
4974  09ed 84            	pop	a
4975  09ee 81            	ret	
5009                     ; 791 void debugflash(void)
5009                     ; 792 {
5010                     	switch	.text
5011  09ef               _debugflash:
5013  09ef 88            	push	a
5014       00000001      OFST:	set	1
5017                     ; 807   LEDcontrol(0);     // turn LED off
5019  09f0 4f            	clr	a
5020  09f1 cd0000        	call	_LEDcontrol
5022                     ; 808   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
5024  09f4 0f01          	clr	(OFST+0,sp)
5026  09f6               L5442:
5029  09f6 aec350        	ldw	x,#50000
5030  09f9 cd0000        	call	_wait_timer
5034  09fc 0c01          	inc	(OFST+0,sp)
5038  09fe 7b01          	ld	a,(OFST+0,sp)
5039  0a00 a10a          	cp	a,#10
5040  0a02 25f2          	jrult	L5442
5041                     ; 810   LEDcontrol(1);     // turn LED on
5043  0a04 a601          	ld	a,#1
5044  0a06 cd0000        	call	_LEDcontrol
5046                     ; 811   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
5048  0a09 0f01          	clr	(OFST+0,sp)
5050  0a0b               L3542:
5053  0a0b aec350        	ldw	x,#50000
5054  0a0e cd0000        	call	_wait_timer
5058  0a11 0c01          	inc	(OFST+0,sp)
5062  0a13 7b01          	ld	a,(OFST+0,sp)
5063  0a15 a10a          	cp	a,#10
5064  0a17 25f2          	jrult	L3542
5065                     ; 812 }
5068  0a19 84            	pop	a
5069  0a1a 81            	ret	
5675                     	switch	.bss
5676  0000               _devicename_changed:
5677  0000 00            	ds.b	1
5678                     	xdef	_devicename_changed
5679  0001               _submit_changes:
5680  0001 00            	ds.b	1
5681                     	xdef	_submit_changes
5682  0002               _uip_ethaddr1:
5683  0002 00            	ds.b	1
5684                     	xdef	_uip_ethaddr1
5685  0003               _uip_ethaddr2:
5686  0003 00            	ds.b	1
5687                     	xdef	_uip_ethaddr2
5688  0004               _uip_ethaddr3:
5689  0004 00            	ds.b	1
5690                     	xdef	_uip_ethaddr3
5691  0005               _uip_ethaddr4:
5692  0005 00            	ds.b	1
5693                     	xdef	_uip_ethaddr4
5694  0006               _uip_ethaddr5:
5695  0006 00            	ds.b	1
5696                     	xdef	_uip_ethaddr5
5697  0007               _uip_ethaddr6:
5698  0007 00            	ds.b	1
5699                     	xdef	_uip_ethaddr6
5700  0008               _Pending_uip_ethaddr1:
5701  0008 00            	ds.b	1
5702                     	xdef	_Pending_uip_ethaddr1
5703  0009               _Pending_uip_ethaddr2:
5704  0009 00            	ds.b	1
5705                     	xdef	_Pending_uip_ethaddr2
5706  000a               _Pending_uip_ethaddr3:
5707  000a 00            	ds.b	1
5708                     	xdef	_Pending_uip_ethaddr3
5709  000b               _Pending_uip_ethaddr4:
5710  000b 00            	ds.b	1
5711                     	xdef	_Pending_uip_ethaddr4
5712  000c               _Pending_uip_ethaddr5:
5713  000c 00            	ds.b	1
5714                     	xdef	_Pending_uip_ethaddr5
5715  000d               _Pending_uip_ethaddr6:
5716  000d 00            	ds.b	1
5717                     	xdef	_Pending_uip_ethaddr6
5718  000e               _Pending_port:
5719  000e 0000          	ds.b	2
5720                     	xdef	_Pending_port
5721  0010               _Pending_netmask1:
5722  0010 00            	ds.b	1
5723                     	xdef	_Pending_netmask1
5724  0011               _Pending_netmask2:
5725  0011 00            	ds.b	1
5726                     	xdef	_Pending_netmask2
5727  0012               _Pending_netmask3:
5728  0012 00            	ds.b	1
5729                     	xdef	_Pending_netmask3
5730  0013               _Pending_netmask4:
5731  0013 00            	ds.b	1
5732                     	xdef	_Pending_netmask4
5733  0014               _Pending_draddr1:
5734  0014 00            	ds.b	1
5735                     	xdef	_Pending_draddr1
5736  0015               _Pending_draddr2:
5737  0015 00            	ds.b	1
5738                     	xdef	_Pending_draddr2
5739  0016               _Pending_draddr3:
5740  0016 00            	ds.b	1
5741                     	xdef	_Pending_draddr3
5742  0017               _Pending_draddr4:
5743  0017 00            	ds.b	1
5744                     	xdef	_Pending_draddr4
5745  0018               _Pending_hostaddr1:
5746  0018 00            	ds.b	1
5747                     	xdef	_Pending_hostaddr1
5748  0019               _Pending_hostaddr2:
5749  0019 00            	ds.b	1
5750                     	xdef	_Pending_hostaddr2
5751  001a               _Pending_hostaddr3:
5752  001a 00            	ds.b	1
5753                     	xdef	_Pending_hostaddr3
5754  001b               _Pending_hostaddr4:
5755  001b 00            	ds.b	1
5756                     	xdef	_Pending_hostaddr4
5757  001c               _ex_stored_devicename:
5758  001c 000000000000  	ds.b	20
5759                     	xdef	_ex_stored_devicename
5760  0030               _ex_stored_port:
5761  0030 0000          	ds.b	2
5762                     	xdef	_ex_stored_port
5763  0032               _ex_stored_netmask1:
5764  0032 00            	ds.b	1
5765                     	xdef	_ex_stored_netmask1
5766  0033               _ex_stored_netmask2:
5767  0033 00            	ds.b	1
5768                     	xdef	_ex_stored_netmask2
5769  0034               _ex_stored_netmask3:
5770  0034 00            	ds.b	1
5771                     	xdef	_ex_stored_netmask3
5772  0035               _ex_stored_netmask4:
5773  0035 00            	ds.b	1
5774                     	xdef	_ex_stored_netmask4
5775  0036               _ex_stored_draddr1:
5776  0036 00            	ds.b	1
5777                     	xdef	_ex_stored_draddr1
5778  0037               _ex_stored_draddr2:
5779  0037 00            	ds.b	1
5780                     	xdef	_ex_stored_draddr2
5781  0038               _ex_stored_draddr3:
5782  0038 00            	ds.b	1
5783                     	xdef	_ex_stored_draddr3
5784  0039               _ex_stored_draddr4:
5785  0039 00            	ds.b	1
5786                     	xdef	_ex_stored_draddr4
5787  003a               _ex_stored_hostaddr1:
5788  003a 00            	ds.b	1
5789                     	xdef	_ex_stored_hostaddr1
5790  003b               _ex_stored_hostaddr2:
5791  003b 00            	ds.b	1
5792                     	xdef	_ex_stored_hostaddr2
5793  003c               _ex_stored_hostaddr3:
5794  003c 00            	ds.b	1
5795                     	xdef	_ex_stored_hostaddr3
5796  003d               _ex_stored_hostaddr4:
5797  003d 00            	ds.b	1
5798                     	xdef	_ex_stored_hostaddr4
5799  003e               _IpAddr:
5800  003e 00000000      	ds.b	4
5801                     	xdef	_IpAddr
5802  0042               _invert_output:
5803  0042 00            	ds.b	1
5804                     	xdef	_invert_output
5805  0043               _Relays_8to1:
5806  0043 00            	ds.b	1
5807                     	xdef	_Relays_8to1
5808  0044               _Relays_16to9:
5809  0044 00            	ds.b	1
5810                     	xdef	_Relays_16to9
5811  0045               _Port_Httpd:
5812  0045 0000          	ds.b	2
5813                     	xdef	_Port_Httpd
5814                     .eeprom:	section	.data
5815  0000               _stored_devicename:
5816  0000 000000000000  	ds.b	20
5817                     	xdef	_stored_devicename
5818  0014               _stored_invert_output:
5819  0014 00            	ds.b	1
5820                     	xdef	_stored_invert_output
5821  0015               _stored_Relays_8to1:
5822  0015 00            	ds.b	1
5823                     	xdef	_stored_Relays_8to1
5824  0016               _stored_Relays_16to9:
5825  0016 00            	ds.b	1
5826                     	xdef	_stored_Relays_16to9
5827  0017               _stored_uip_ethaddr6:
5828  0017 00            	ds.b	1
5829                     	xdef	_stored_uip_ethaddr6
5830  0018               _stored_uip_ethaddr5:
5831  0018 00            	ds.b	1
5832                     	xdef	_stored_uip_ethaddr5
5833  0019               _stored_uip_ethaddr4:
5834  0019 00            	ds.b	1
5835                     	xdef	_stored_uip_ethaddr4
5836  001a               _stored_uip_ethaddr3:
5837  001a 00            	ds.b	1
5838                     	xdef	_stored_uip_ethaddr3
5839  001b               _stored_uip_ethaddr2:
5840  001b 00            	ds.b	1
5841                     	xdef	_stored_uip_ethaddr2
5842  001c               _stored_uip_ethaddr1:
5843  001c 00            	ds.b	1
5844                     	xdef	_stored_uip_ethaddr1
5845  001d               _stored_port:
5846  001d 0000          	ds.b	2
5847                     	xdef	_stored_port
5848  001f               _stored_netmask1:
5849  001f 00            	ds.b	1
5850                     	xdef	_stored_netmask1
5851  0020               _stored_netmask2:
5852  0020 00            	ds.b	1
5853                     	xdef	_stored_netmask2
5854  0021               _stored_netmask3:
5855  0021 00            	ds.b	1
5856                     	xdef	_stored_netmask3
5857  0022               _stored_netmask4:
5858  0022 00            	ds.b	1
5859                     	xdef	_stored_netmask4
5860  0023               _stored_draddr1:
5861  0023 00            	ds.b	1
5862                     	xdef	_stored_draddr1
5863  0024               _stored_draddr2:
5864  0024 00            	ds.b	1
5865                     	xdef	_stored_draddr2
5866  0025               _stored_draddr3:
5867  0025 00            	ds.b	1
5868                     	xdef	_stored_draddr3
5869  0026               _stored_draddr4:
5870  0026 00            	ds.b	1
5871                     	xdef	_stored_draddr4
5872  0027               _stored_hostaddr1:
5873  0027 00            	ds.b	1
5874                     	xdef	_stored_hostaddr1
5875  0028               _stored_hostaddr2:
5876  0028 00            	ds.b	1
5877                     	xdef	_stored_hostaddr2
5878  0029               _stored_hostaddr3:
5879  0029 00            	ds.b	1
5880                     	xdef	_stored_hostaddr3
5881  002a               _stored_hostaddr4:
5882  002a 00            	ds.b	1
5883                     	xdef	_stored_hostaddr4
5884  002b               _magic1:
5885  002b 00            	ds.b	1
5886                     	xdef	_magic1
5887  002c               _magic2:
5888  002c 00            	ds.b	1
5889                     	xdef	_magic2
5890  002d               _magic3:
5891  002d 00            	ds.b	1
5892                     	xdef	_magic3
5893  002e               _magic4:
5894  002e 00            	ds.b	1
5895                     	xdef	_magic4
5896                     	xref	_wait_timer
5897                     	xref	_arp_timer_expired
5898                     	xref	_periodic_timer_expired
5899                     	xref	_clock_init
5900                     	xref	_LEDcontrol
5901                     	xref	_gpio_init
5902                     	xref	_uip_arp_timer
5903                     	xref	_uip_arp_out
5904                     	xref	_uip_arp_arpin
5905                     	xref	_uip_arp_init
5906                     	xref	_uip_ethaddr
5907                     	xref	_uip_draddr
5908                     	xref	_uip_netmask
5909                     	xref	_uip_hostaddr
5910                     	xref	_uip_process
5911                     	xref	_uip_conns
5912                     	xref	_uip_conn
5913                     	xref	_uip_len
5914                     	xref	_htons
5915                     	xref	_uip_buf
5916                     	xref	_uip_init
5917                     	xref	_HttpDInit
5918                     	xref	_Enc28j60Send
5919                     	xref	_Enc28j60CopyPacket
5920                     	xref	_Enc28j60Receive
5921                     	xref	_Enc28j60Init
5922                     	xref	_spi_init
5923                     	xdef	_debugflash
5924                     	xdef	_check_reset_button
5925                     	xdef	_update_relay_control_registers
5926                     	xdef	_check_runtime_changes
5927                     	xdef	_check_eeprom_settings
5928                     	xdef	_unlock_eeprom
5929                     	xdef	_main
5930                     	xref.b	c_x
5950                     	xref	c_eewrw
5951                     	xref	c_eewrc
5952                     	xref	c_bmulx
5953                     	end
