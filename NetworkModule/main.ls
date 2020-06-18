   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2581                     ; 144 main(void)
2581                     ; 145 {
2583                     	switch	.text
2584  0000               _main:
2586  0000 89            	pushw	x
2587       00000002      OFST:	set	2
2590                     ; 149   devicename_changed = 0;
2592  0001 725f0000      	clr	_devicename_changed
2593                     ; 150   submit_changes = 0;
2595  0005 725f0001      	clr	_submit_changes
2596                     ; 152   clock_init();            // Initialize and enable clocks and timers
2598  0009 cd0000        	call	_clock_init
2600                     ; 154   gpio_init();             // Initialize and enable gpio pins
2602  000c cd0000        	call	_gpio_init
2604                     ; 156   spi_init();              // Initialize the SPI bit bang interface to the
2606  000f cd0000        	call	_spi_init
2608                     ; 159   LEDcontrol(1);           // turn LED on
2610  0012 a601          	ld	a,#1
2611  0014 cd0000        	call	_LEDcontrol
2613                     ; 161   unlock_eeprom();         // unlock the EEPROM so writes can be performed
2615  0017 cd00ba        	call	_unlock_eeprom
2617                     ; 163   check_eeprom_settings(); // Check the EEPROM for previously stored Address
2619  001a cd00ca        	call	_check_eeprom_settings
2621                     ; 167   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
2623  001d cd0000        	call	_Enc28j60Init
2625                     ; 169   uip_arp_init();          // Initialize the ARP module
2627  0020 cd0000        	call	_uip_arp_init
2629                     ; 171   uip_init();              // Initialize uIP
2631  0023 cd0000        	call	_uip_init
2633                     ; 173   HttpDInit();             // Initialize httpd; sets up listening ports
2635  0026 cd0000        	call	_HttpDInit
2637  0029               L1561:
2638                     ; 176     uip_len = Enc28j60Receive(uip_buf);
2640  0029 ae0000        	ldw	x,#_uip_buf
2641  002c cd0000        	call	_Enc28j60Receive
2643  002f cf0000        	ldw	_uip_len,x
2644                     ; 178     if (uip_len> 0) {
2646  0032 273b          	jreq	L5561
2647                     ; 179       if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
2649  0034 ae0800        	ldw	x,#2048
2650  0037 cd0000        	call	_htons
2652  003a c3000c        	cpw	x,_uip_buf+12
2653  003d 2612          	jrne	L7561
2654                     ; 181 	uip_input(); // calls uip_process(UIP_DATA)
2656  003f a601          	ld	a,#1
2657  0041 cd0000        	call	_uip_process
2659                     ; 185         if (uip_len> 0) {
2661  0044 ce0000        	ldw	x,_uip_len
2662  0047 2726          	jreq	L5561
2663                     ; 186           uip_arp_out();
2665  0049 cd0000        	call	_uip_arp_out
2667                     ; 190           Enc28j60CopyPacket(uip_buf, uip_len);
2669  004c ce0000        	ldw	x,_uip_len
2671                     ; 191           Enc28j60Send();
2673  004f 2013          	jp	LC001
2674  0051               L7561:
2675                     ; 194       else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
2677  0051 ae0806        	ldw	x,#2054
2678  0054 cd0000        	call	_htons
2680  0057 c3000c        	cpw	x,_uip_buf+12
2681  005a 2613          	jrne	L5561
2682                     ; 195         uip_arp_arpin();
2684  005c cd0000        	call	_uip_arp_arpin
2686                     ; 199         if (uip_len> 0) {
2688  005f ce0000        	ldw	x,_uip_len
2689  0062 270b          	jreq	L5561
2690                     ; 203           Enc28j60CopyPacket(uip_buf, uip_len);
2693                     ; 204           Enc28j60Send();
2695  0064               LC001:
2696  0064 89            	pushw	x
2697  0065 ae0000        	ldw	x,#_uip_buf
2698  0068 cd0000        	call	_Enc28j60CopyPacket
2699  006b 85            	popw	x
2701  006c cd0000        	call	_Enc28j60Send
2703  006f               L5561:
2704                     ; 209     if(periodic_timer_expired()) {
2706  006f cd0000        	call	_periodic_timer_expired
2708  0072 4d            	tnz	a
2709  0073 2733          	jreq	L1761
2710                     ; 210       for(i = 0; i < UIP_CONNS; i++) {
2712  0075 5f            	clrw	x
2713  0076 1f01          	ldw	(OFST-1,sp),x
2715  0078               L1071:
2716                     ; 211 	uip_periodic(i);
2718  0078 a628          	ld	a,#40
2719  007a cd0000        	call	c_bmulx
2721  007d 1c0000        	addw	x,#_uip_conns
2722  0080 cf0000        	ldw	_uip_conn,x
2725  0083 a602          	ld	a,#2
2726  0085 cd0000        	call	_uip_process
2728                     ; 215 	if(uip_len > 0) {
2730  0088 ce0000        	ldw	x,_uip_len
2731  008b 2711          	jreq	L5071
2732                     ; 216 	  uip_arp_out();
2734  008d cd0000        	call	_uip_arp_out
2736                     ; 220           Enc28j60CopyPacket(uip_buf, uip_len);
2738  0090 ce0000        	ldw	x,_uip_len
2739  0093 89            	pushw	x
2740  0094 ae0000        	ldw	x,#_uip_buf
2741  0097 cd0000        	call	_Enc28j60CopyPacket
2743  009a 85            	popw	x
2744                     ; 221           Enc28j60Send();
2746  009b cd0000        	call	_Enc28j60Send
2748  009e               L5071:
2749                     ; 210       for(i = 0; i < UIP_CONNS; i++) {
2751  009e 1e01          	ldw	x,(OFST-1,sp)
2752  00a0 5c            	incw	x
2753  00a1 1f01          	ldw	(OFST-1,sp),x
2757  00a3 a30006        	cpw	x,#6
2758  00a6 2fd0          	jrslt	L1071
2759  00a8               L1761:
2760                     ; 227     if(arp_timer_expired()) {
2762  00a8 cd0000        	call	_arp_timer_expired
2764  00ab 4d            	tnz	a
2765  00ac 2703          	jreq	L7071
2766                     ; 228       uip_arp_timer();
2768  00ae cd0000        	call	_uip_arp_timer
2770  00b1               L7071:
2771                     ; 233     check_runtime_changes();
2773  00b1 cd0463        	call	_check_runtime_changes
2775                     ; 236     check_reset_button();
2777  00b4 cd0859        	call	_check_reset_button
2780  00b7 cc0029        	jra	L1561
2805                     ; 261 void unlock_eeprom(void)
2805                     ; 262 {
2806                     	switch	.text
2807  00ba               _unlock_eeprom:
2811  00ba 2008          	jra	L3271
2812  00bc               L1271:
2813                     ; 270     FLASH_DUKR = 0xAE; // MASS key 1
2815  00bc 35ae5064      	mov	_FLASH_DUKR,#174
2816                     ; 271     FLASH_DUKR = 0x56; // MASS key 2
2818  00c0 35565064      	mov	_FLASH_DUKR,#86
2819  00c4               L3271:
2820                     ; 269   while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
2822  00c4 7207505ff3    	btjf	_FLASH_IAPSR,#3,L1271
2823                     ; 273 }
2826  00c9 81            	ret	
2935                     ; 276 void check_eeprom_settings(void)
2935                     ; 277 {
2936                     	switch	.text
2937  00ca               _check_eeprom_settings:
2939  00ca 88            	push	a
2940       00000001      OFST:	set	1
2943                     ; 287   if ((magic4 == 0x55) && 
2943                     ; 288       (magic3 == 0xee) && 
2943                     ; 289       (magic2 == 0x0f) && 
2943                     ; 290       (magic1 == 0xf0) == 1) {
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
2960                     ; 294     uip_ipaddr(IpAddr, stored_hostaddr4, stored_hostaddr3, stored_hostaddr2, stored_hostaddr1);
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
2974                     ; 295     uip_sethostaddr(IpAddr);
2976  0100 ce003e        	ldw	x,_IpAddr
2977  0103 cf0000        	ldw	_uip_hostaddr,x
2980  0106 ce0040        	ldw	x,_IpAddr+2
2981  0109 cf0002        	ldw	_uip_hostaddr+2,x
2982                     ; 297     uip_ipaddr(IpAddr, stored_draddr4, stored_draddr3, stored_draddr2, stored_draddr1);
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
2996                     ; 298     uip_setdraddr(IpAddr);
2998  0122 ce003e        	ldw	x,_IpAddr
2999  0125 cf0000        	ldw	_uip_draddr,x
3002  0128 ce0040        	ldw	x,_IpAddr+2
3003  012b cf0002        	ldw	_uip_draddr+2,x
3004                     ; 300     uip_ipaddr(IpAddr, stored_netmask4, stored_netmask3, stored_netmask2, stored_netmask1);
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
3018                     ; 301     uip_setnetmask(IpAddr);
3020  0144 ce003e        	ldw	x,_IpAddr
3021  0147 cf0000        	ldw	_uip_netmask,x
3024  014a ce0040        	ldw	x,_IpAddr+2
3025  014d cf0002        	ldw	_uip_netmask+2,x
3026                     ; 303     Port_Httpd = stored_port;
3028  0150 ce001d        	ldw	x,_stored_port
3029  0153 cf0045        	ldw	_Port_Httpd,x
3030                     ; 305     uip_ethaddr6 = stored_uip_ethaddr6;
3032  0156 5500170007    	mov	_uip_ethaddr6,_stored_uip_ethaddr6
3033                     ; 306     uip_ethaddr5 = stored_uip_ethaddr5;
3035  015b 5500180006    	mov	_uip_ethaddr5,_stored_uip_ethaddr5
3036                     ; 307     uip_ethaddr4 = stored_uip_ethaddr4;
3038  0160 5500190005    	mov	_uip_ethaddr4,_stored_uip_ethaddr4
3039                     ; 308     uip_ethaddr3 = stored_uip_ethaddr3;
3041  0165 55001a0004    	mov	_uip_ethaddr3,_stored_uip_ethaddr3
3042                     ; 309     uip_ethaddr2 = stored_uip_ethaddr2;
3044  016a 55001b0003    	mov	_uip_ethaddr2,_stored_uip_ethaddr2
3045                     ; 310     uip_ethaddr1 = stored_uip_ethaddr1;
3047  016f 55001c0002    	mov	_uip_ethaddr1,_stored_uip_ethaddr1
3048                     ; 312     uip_ethaddr.addr[0] = uip_ethaddr1;
3050  0174 5500020000    	mov	_uip_ethaddr,_uip_ethaddr1
3051                     ; 313     uip_ethaddr.addr[1] = uip_ethaddr2;
3053  0179 5500030001    	mov	_uip_ethaddr+1,_uip_ethaddr2
3054                     ; 314     uip_ethaddr.addr[2] = uip_ethaddr3;
3056  017e 5500040002    	mov	_uip_ethaddr+2,_uip_ethaddr3
3057                     ; 315     uip_ethaddr.addr[3] = uip_ethaddr4;
3059  0183 5500050003    	mov	_uip_ethaddr+3,_uip_ethaddr4
3060                     ; 316     uip_ethaddr.addr[4] = uip_ethaddr5;
3062  0188 5500060004    	mov	_uip_ethaddr+4,_uip_ethaddr5
3063                     ; 317     uip_ethaddr.addr[5] = uip_ethaddr6;
3065                     ; 319     for(i=0; i<20; i++) { ex_stored_devicename[i] = stored_devicename[i]; }
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
3087                     ; 323     invert_output = stored_invert_output;
3089  01a5 5500140042    	mov	_invert_output,_stored_invert_output
3090                     ; 324     Relays_16to9 = stored_Relays_16to9;
3092  01aa 5500160044    	mov	_Relays_16to9,_stored_Relays_16to9
3093                     ; 325     Relays_8to1 = stored_Relays_8to1;
3095  01af 5500150043    	mov	_Relays_8to1,_stored_Relays_8to1
3096                     ; 327     update_relay_control_registers();
3098  01b4 cd066f        	call	_update_relay_control_registers
3101  01b7 cc03af        	jra	L3002
3102  01ba               L5002:
3103                     ; 336     uip_ipaddr(IpAddr, 192,168,1,4);
3105  01ba aec0a8        	ldw	x,#49320
3106  01bd cf003e        	ldw	_IpAddr,x
3109  01c0 ae0104        	ldw	x,#260
3110  01c3 cf0040        	ldw	_IpAddr+2,x
3111                     ; 337     uip_sethostaddr(IpAddr);
3113  01c6 ce003e        	ldw	x,_IpAddr
3114  01c9 cf0000        	ldw	_uip_hostaddr,x
3117  01cc ce0040        	ldw	x,_IpAddr+2
3118  01cf cf0002        	ldw	_uip_hostaddr+2,x
3119                     ; 339     stored_hostaddr4 = 192;	// MSB
3121  01d2 a6c0          	ld	a,#192
3122  01d4 ae002a        	ldw	x,#_stored_hostaddr4
3123  01d7 cd0000        	call	c_eewrc
3125                     ; 340     stored_hostaddr3 = 168;	//
3127  01da a6a8          	ld	a,#168
3128  01dc ae0029        	ldw	x,#_stored_hostaddr3
3129  01df cd0000        	call	c_eewrc
3131                     ; 341     stored_hostaddr2 = 1;	//
3133  01e2 a601          	ld	a,#1
3134  01e4 ae0028        	ldw	x,#_stored_hostaddr2
3135  01e7 cd0000        	call	c_eewrc
3137                     ; 342     stored_hostaddr1 = 4;	// LSB
3139  01ea a604          	ld	a,#4
3140  01ec ae0027        	ldw	x,#_stored_hostaddr1
3141  01ef cd0000        	call	c_eewrc
3143                     ; 345     uip_ipaddr(IpAddr, 192,168,1,1);
3145  01f2 aec0a8        	ldw	x,#49320
3146  01f5 cf003e        	ldw	_IpAddr,x
3149  01f8 ae0101        	ldw	x,#257
3150  01fb cf0040        	ldw	_IpAddr+2,x
3151                     ; 346     uip_setdraddr(IpAddr);
3153  01fe ce003e        	ldw	x,_IpAddr
3154  0201 cf0000        	ldw	_uip_draddr,x
3157  0204 ce0040        	ldw	x,_IpAddr+2
3158  0207 cf0002        	ldw	_uip_draddr+2,x
3159                     ; 348     stored_draddr4 = 192;	// MSB
3161  020a a6c0          	ld	a,#192
3162  020c ae0026        	ldw	x,#_stored_draddr4
3163  020f cd0000        	call	c_eewrc
3165                     ; 349     stored_draddr3 = 168;	//
3167  0212 a6a8          	ld	a,#168
3168  0214 ae0025        	ldw	x,#_stored_draddr3
3169  0217 cd0000        	call	c_eewrc
3171                     ; 350     stored_draddr2 = 1;		//
3173  021a a601          	ld	a,#1
3174  021c ae0024        	ldw	x,#_stored_draddr2
3175  021f cd0000        	call	c_eewrc
3177                     ; 351     stored_draddr1 = 1;		// LSB
3179  0222 a601          	ld	a,#1
3180  0224 ae0023        	ldw	x,#_stored_draddr1
3181  0227 cd0000        	call	c_eewrc
3183                     ; 354     uip_ipaddr(IpAddr, 255,255,255,0);
3185  022a aeffff        	ldw	x,#65535
3186  022d cf003e        	ldw	_IpAddr,x
3189  0230 aeff00        	ldw	x,#65280
3190  0233 cf0040        	ldw	_IpAddr+2,x
3191                     ; 355     uip_setnetmask(IpAddr);
3193  0236 ce003e        	ldw	x,_IpAddr
3194  0239 cf0000        	ldw	_uip_netmask,x
3197  023c ce0040        	ldw	x,_IpAddr+2
3198  023f cf0002        	ldw	_uip_netmask+2,x
3199                     ; 357     stored_netmask4 = 255;	// MSB
3201  0242 a6ff          	ld	a,#255
3202  0244 ae0022        	ldw	x,#_stored_netmask4
3203  0247 cd0000        	call	c_eewrc
3205                     ; 358     stored_netmask3 = 255;	//
3207  024a a6ff          	ld	a,#255
3208  024c ae0021        	ldw	x,#_stored_netmask3
3209  024f cd0000        	call	c_eewrc
3211                     ; 359     stored_netmask2 = 255;	//
3213  0252 a6ff          	ld	a,#255
3214  0254 ae0020        	ldw	x,#_stored_netmask2
3215  0257 cd0000        	call	c_eewrc
3217                     ; 360     stored_netmask1 = 0;	// LSB
3219  025a 4f            	clr	a
3220  025b ae001f        	ldw	x,#_stored_netmask1
3221  025e cd0000        	call	c_eewrc
3223                     ; 363     stored_port = 8080;		// Port
3225  0261 ae1f90        	ldw	x,#8080
3226  0264 89            	pushw	x
3227  0265 ae001d        	ldw	x,#_stored_port
3228  0268 cd0000        	call	c_eewrw
3230  026b a6c2          	ld	a,#194
3231  026d 85            	popw	x
3232                     ; 375     stored_uip_ethaddr1 = 0xc2;	//MAC MSB
3234  026e ae001c        	ldw	x,#_stored_uip_ethaddr1
3235  0271 cd0000        	call	c_eewrc
3237                     ; 376     stored_uip_ethaddr2 = 0x4d;
3239  0274 a64d          	ld	a,#77
3240  0276 ae001b        	ldw	x,#_stored_uip_ethaddr2
3241  0279 cd0000        	call	c_eewrc
3243                     ; 377     stored_uip_ethaddr3 = 0x69;
3245  027c a669          	ld	a,#105
3246  027e ae001a        	ldw	x,#_stored_uip_ethaddr3
3247  0281 cd0000        	call	c_eewrc
3249                     ; 378     stored_uip_ethaddr4 = 0x6b;
3251  0284 a66b          	ld	a,#107
3252  0286 ae0019        	ldw	x,#_stored_uip_ethaddr4
3253  0289 cd0000        	call	c_eewrc
3255                     ; 379     stored_uip_ethaddr5 = 0x65;
3257  028c a665          	ld	a,#101
3258  028e ae0018        	ldw	x,#_stored_uip_ethaddr5
3259  0291 cd0000        	call	c_eewrc
3261                     ; 380     stored_uip_ethaddr6 = 0x00;	//MAC LSB
3263  0294 4f            	clr	a
3264  0295 ae0017        	ldw	x,#_stored_uip_ethaddr6
3265  0298 cd0000        	call	c_eewrc
3267                     ; 382     uip_ethaddr1 = stored_uip_ethaddr1;	//MAC MSB
3269  029b 35c20002      	mov	_uip_ethaddr1,#194
3270                     ; 383     uip_ethaddr2 = stored_uip_ethaddr2;
3272  029f 354d0003      	mov	_uip_ethaddr2,#77
3273                     ; 384     uip_ethaddr3 = stored_uip_ethaddr3;
3275  02a3 35690004      	mov	_uip_ethaddr3,#105
3276                     ; 385     uip_ethaddr4 = stored_uip_ethaddr4;
3278  02a7 356b0005      	mov	_uip_ethaddr4,#107
3279                     ; 386     uip_ethaddr5 = stored_uip_ethaddr5;
3281  02ab 35650006      	mov	_uip_ethaddr5,#101
3282                     ; 387     uip_ethaddr6 = stored_uip_ethaddr6;	//MAC LSB
3284  02af 725f0007      	clr	_uip_ethaddr6
3285                     ; 389     uip_ethaddr.addr[0] = uip_ethaddr1;
3287  02b3 35c20000      	mov	_uip_ethaddr,#194
3288                     ; 390     uip_ethaddr.addr[1] = uip_ethaddr2;
3290  02b7 354d0001      	mov	_uip_ethaddr+1,#77
3291                     ; 391     uip_ethaddr.addr[2] = uip_ethaddr3;
3293  02bb 35690002      	mov	_uip_ethaddr+2,#105
3294                     ; 392     uip_ethaddr.addr[3] = uip_ethaddr4;
3296  02bf 356b0003      	mov	_uip_ethaddr+3,#107
3297                     ; 393     uip_ethaddr.addr[4] = uip_ethaddr5;
3299  02c3 35650004      	mov	_uip_ethaddr+4,#101
3300                     ; 394     uip_ethaddr.addr[5] = uip_ethaddr6;
3302  02c7 725f0005      	clr	_uip_ethaddr+5
3303                     ; 396     stored_devicename[0] = 'N' ; // Device name first character
3305  02cb a64e          	ld	a,#78
3306  02cd ae0000        	ldw	x,#_stored_devicename
3307  02d0 cd0000        	call	c_eewrc
3309                     ; 397     stored_devicename[1] = 'e' ; //
3311  02d3 a665          	ld	a,#101
3312  02d5 ae0001        	ldw	x,#_stored_devicename+1
3313  02d8 cd0000        	call	c_eewrc
3315                     ; 398     stored_devicename[2] = 'w' ; //
3317  02db a677          	ld	a,#119
3318  02dd ae0002        	ldw	x,#_stored_devicename+2
3319  02e0 cd0000        	call	c_eewrc
3321                     ; 399     stored_devicename[3] = 'D' ; //
3323  02e3 a644          	ld	a,#68
3324  02e5 ae0003        	ldw	x,#_stored_devicename+3
3325  02e8 cd0000        	call	c_eewrc
3327                     ; 400     stored_devicename[4] = 'e' ; //
3329  02eb a665          	ld	a,#101
3330  02ed ae0004        	ldw	x,#_stored_devicename+4
3331  02f0 cd0000        	call	c_eewrc
3333                     ; 401     stored_devicename[5] = 'v' ; //
3335  02f3 a676          	ld	a,#118
3336  02f5 ae0005        	ldw	x,#_stored_devicename+5
3337  02f8 cd0000        	call	c_eewrc
3339                     ; 402     stored_devicename[6] = 'i' ; //
3341  02fb a669          	ld	a,#105
3342  02fd ae0006        	ldw	x,#_stored_devicename+6
3343  0300 cd0000        	call	c_eewrc
3345                     ; 403     stored_devicename[7] = 'c' ; //
3347  0303 a663          	ld	a,#99
3348  0305 ae0007        	ldw	x,#_stored_devicename+7
3349  0308 cd0000        	call	c_eewrc
3351                     ; 404     stored_devicename[8] = 'e' ; //
3353  030b a665          	ld	a,#101
3354  030d ae0008        	ldw	x,#_stored_devicename+8
3355  0310 cd0000        	call	c_eewrc
3357                     ; 405     stored_devicename[9] = '0' ; //
3359  0313 a630          	ld	a,#48
3360  0315 ae0009        	ldw	x,#_stored_devicename+9
3361  0318 cd0000        	call	c_eewrc
3363                     ; 406     stored_devicename[10] = '0' ; //
3365  031b a630          	ld	a,#48
3366  031d ae000a        	ldw	x,#_stored_devicename+10
3367  0320 cd0000        	call	c_eewrc
3369                     ; 407     stored_devicename[11] = '0' ; //
3371  0323 a630          	ld	a,#48
3372  0325 ae000b        	ldw	x,#_stored_devicename+11
3373  0328 cd0000        	call	c_eewrc
3375                     ; 408     stored_devicename[12] = ' ' ; //
3377  032b a620          	ld	a,#32
3378  032d ae000c        	ldw	x,#_stored_devicename+12
3379  0330 cd0000        	call	c_eewrc
3381                     ; 409     stored_devicename[13] = ' ' ; //
3383  0333 a620          	ld	a,#32
3384  0335 ae000d        	ldw	x,#_stored_devicename+13
3385  0338 cd0000        	call	c_eewrc
3387                     ; 410     stored_devicename[14] = ' ' ; //
3389  033b a620          	ld	a,#32
3390  033d ae000e        	ldw	x,#_stored_devicename+14
3391  0340 cd0000        	call	c_eewrc
3393                     ; 411     stored_devicename[15] = ' ' ; //
3395  0343 a620          	ld	a,#32
3396  0345 ae000f        	ldw	x,#_stored_devicename+15
3397  0348 cd0000        	call	c_eewrc
3399                     ; 412     stored_devicename[16] = ' ' ; //
3401  034b a620          	ld	a,#32
3402  034d ae0010        	ldw	x,#_stored_devicename+16
3403  0350 cd0000        	call	c_eewrc
3405                     ; 413     stored_devicename[17] = ' ' ; //
3407  0353 a620          	ld	a,#32
3408  0355 ae0011        	ldw	x,#_stored_devicename+17
3409  0358 cd0000        	call	c_eewrc
3411                     ; 414     stored_devicename[18] = ' ' ; //
3413  035b a620          	ld	a,#32
3414  035d ae0012        	ldw	x,#_stored_devicename+18
3415  0360 cd0000        	call	c_eewrc
3417                     ; 415     stored_devicename[19] = ' ' ; // Device name last character
3419  0363 a620          	ld	a,#32
3420  0365 ae0013        	ldw	x,#_stored_devicename+19
3421  0368 cd0000        	call	c_eewrc
3423                     ; 418     invert_output = 0;                  // Turn off output invert bit
3425  036b 725f0042      	clr	_invert_output
3426                     ; 419     stored_invert_output = 0;           // Store in EEPROM
3428  036f 4f            	clr	a
3429  0370 ae0014        	ldw	x,#_stored_invert_output
3430  0373 cd0000        	call	c_eewrc
3432                     ; 420     Relays_16to9 = (uint8_t)0xff;       // Turn off Relays 16 to 9
3434  0376 a6ff          	ld	a,#255
3435  0378 c70044        	ld	_Relays_16to9,a
3436                     ; 421     Relays_8to1  = (uint8_t)0xff;       // Turn off Relays 8 to 1
3438  037b c70043        	ld	_Relays_8to1,a
3439                     ; 422     stored_Relays_16to9 = Relays_16to9; // Store in EEPROM
3441  037e ae0016        	ldw	x,#_stored_Relays_16to9
3442  0381 cd0000        	call	c_eewrc
3444                     ; 423     stored_Relays_8to1 = Relays_8to1;   // Store in EEPROM
3446  0384 a6ff          	ld	a,#255
3447  0386 ae0015        	ldw	x,#_stored_Relays_8to1
3448  0389 cd0000        	call	c_eewrc
3450                     ; 424     update_relay_control_registers();   // Set Relay Control outputs
3452  038c cd066f        	call	_update_relay_control_registers
3454                     ; 427     magic4 = 0x55;		// MSB
3456  038f a655          	ld	a,#85
3457  0391 ae002e        	ldw	x,#_magic4
3458  0394 cd0000        	call	c_eewrc
3460                     ; 428     magic3 = 0xee;		//
3462  0397 a6ee          	ld	a,#238
3463  0399 ae002d        	ldw	x,#_magic3
3464  039c cd0000        	call	c_eewrc
3466                     ; 429     magic2 = 0x0f;		//
3468  039f a60f          	ld	a,#15
3469  03a1 ae002c        	ldw	x,#_magic2
3470  03a4 cd0000        	call	c_eewrc
3472                     ; 430     magic1 = 0xf0;		// LSB
3474  03a7 a6f0          	ld	a,#240
3475  03a9 ae002b        	ldw	x,#_magic1
3476  03ac cd0000        	call	c_eewrc
3478  03af               L3002:
3479                     ; 435   Pending_hostaddr4 = stored_hostaddr4;
3481  03af 55002a001b    	mov	_Pending_hostaddr4,_stored_hostaddr4
3482                     ; 436   Pending_hostaddr3 = stored_hostaddr3;
3484  03b4 550029001a    	mov	_Pending_hostaddr3,_stored_hostaddr3
3485                     ; 437   Pending_hostaddr2 = stored_hostaddr2;
3487  03b9 5500280019    	mov	_Pending_hostaddr2,_stored_hostaddr2
3488                     ; 438   Pending_hostaddr1 = stored_hostaddr1;
3490  03be 5500270018    	mov	_Pending_hostaddr1,_stored_hostaddr1
3491                     ; 440   Pending_draddr4 = stored_draddr4;
3493  03c3 5500260017    	mov	_Pending_draddr4,_stored_draddr4
3494                     ; 441   Pending_draddr3 = stored_draddr3;
3496  03c8 5500250016    	mov	_Pending_draddr3,_stored_draddr3
3497                     ; 442   Pending_draddr2 = stored_draddr2;
3499  03cd 5500240015    	mov	_Pending_draddr2,_stored_draddr2
3500                     ; 443   Pending_draddr1 = stored_draddr1;
3502  03d2 5500230014    	mov	_Pending_draddr1,_stored_draddr1
3503                     ; 445   Pending_netmask4 = stored_netmask4;
3505  03d7 5500220013    	mov	_Pending_netmask4,_stored_netmask4
3506                     ; 446   Pending_netmask3 = stored_netmask3;
3508  03dc 5500210012    	mov	_Pending_netmask3,_stored_netmask3
3509                     ; 447   Pending_netmask2 = stored_netmask2;
3511  03e1 5500200011    	mov	_Pending_netmask2,_stored_netmask2
3512                     ; 448   Pending_netmask1 = stored_netmask1;
3514  03e6 55001f0010    	mov	_Pending_netmask1,_stored_netmask1
3515                     ; 450   Pending_port = stored_port;
3517  03eb ce001d        	ldw	x,_stored_port
3518  03ee cf000e        	ldw	_Pending_port,x
3519                     ; 452   Pending_uip_ethaddr6 = stored_uip_ethaddr6;
3521  03f1 550017000d    	mov	_Pending_uip_ethaddr6,_stored_uip_ethaddr6
3522                     ; 453   Pending_uip_ethaddr5 = stored_uip_ethaddr5;
3524  03f6 550018000c    	mov	_Pending_uip_ethaddr5,_stored_uip_ethaddr5
3525                     ; 454   Pending_uip_ethaddr4 = stored_uip_ethaddr4;
3527  03fb 550019000b    	mov	_Pending_uip_ethaddr4,_stored_uip_ethaddr4
3528                     ; 455   Pending_uip_ethaddr3 = stored_uip_ethaddr3;
3530  0400 55001a000a    	mov	_Pending_uip_ethaddr3,_stored_uip_ethaddr3
3531                     ; 456   Pending_uip_ethaddr2 = stored_uip_ethaddr2;
3533  0405 55001b0009    	mov	_Pending_uip_ethaddr2,_stored_uip_ethaddr2
3534                     ; 457   Pending_uip_ethaddr1 = stored_uip_ethaddr1;
3536  040a 55001c0008    	mov	_Pending_uip_ethaddr1,_stored_uip_ethaddr1
3537                     ; 460   ex_stored_hostaddr4 = stored_hostaddr4;
3539  040f 55002a003d    	mov	_ex_stored_hostaddr4,_stored_hostaddr4
3540                     ; 461   ex_stored_hostaddr3 = stored_hostaddr3;
3542  0414 550029003c    	mov	_ex_stored_hostaddr3,_stored_hostaddr3
3543                     ; 462   ex_stored_hostaddr2 = stored_hostaddr2;
3545  0419 550028003b    	mov	_ex_stored_hostaddr2,_stored_hostaddr2
3546                     ; 463   ex_stored_hostaddr1 = stored_hostaddr1;
3548  041e 550027003a    	mov	_ex_stored_hostaddr1,_stored_hostaddr1
3549                     ; 465   ex_stored_draddr4 = stored_draddr4;
3551  0423 5500260039    	mov	_ex_stored_draddr4,_stored_draddr4
3552                     ; 466   ex_stored_draddr3 = stored_draddr3;
3554  0428 5500250038    	mov	_ex_stored_draddr3,_stored_draddr3
3555                     ; 467   ex_stored_draddr2 = stored_draddr2;
3557  042d 5500240037    	mov	_ex_stored_draddr2,_stored_draddr2
3558                     ; 468   ex_stored_draddr1 = stored_draddr1;
3560  0432 5500230036    	mov	_ex_stored_draddr1,_stored_draddr1
3561                     ; 470   ex_stored_netmask4 = stored_netmask4;
3563  0437 5500220035    	mov	_ex_stored_netmask4,_stored_netmask4
3564                     ; 471   ex_stored_netmask3 = stored_netmask3;
3566  043c 5500210034    	mov	_ex_stored_netmask3,_stored_netmask3
3567                     ; 472   ex_stored_netmask2 = stored_netmask2;
3569  0441 5500200033    	mov	_ex_stored_netmask2,_stored_netmask2
3570                     ; 473   ex_stored_netmask1 = stored_netmask1;
3572  0446 55001f0032    	mov	_ex_stored_netmask1,_stored_netmask1
3573                     ; 475   ex_stored_port = stored_port;
3575  044b cf0030        	ldw	_ex_stored_port,x
3576                     ; 477   for(i=0; i<20; i++) { ex_stored_devicename[i] = stored_devicename[i]; }
3578  044e 4f            	clr	a
3579  044f 6b01          	ld	(OFST+0,sp),a
3581  0451               L5302:
3584  0451 5f            	clrw	x
3585  0452 97            	ld	xl,a
3586  0453 d60000        	ld	a,(_stored_devicename,x)
3587  0456 d7001c        	ld	(_ex_stored_devicename,x),a
3590  0459 0c01          	inc	(OFST+0,sp)
3594  045b 7b01          	ld	a,(OFST+0,sp)
3595  045d a114          	cp	a,#20
3596  045f 25f0          	jrult	L5302
3597                     ; 479 }
3600  0461 84            	pop	a
3601  0462 81            	ret	
3692                     ; 482 void check_runtime_changes(void)
3692                     ; 483 {
3693                     	switch	.text
3694  0463               _check_runtime_changes:
3696  0463 88            	push	a
3697       00000001      OFST:	set	1
3700                     ; 491   if ((invert_output != stored_invert_output)
3700                     ; 492    || (stored_Relays_16to9 != Relays_16to9)
3700                     ; 493    || (stored_Relays_8to1 != Relays_8to1)) {
3702  0464 c60042        	ld	a,_invert_output
3703  0467 c10014        	cp	a,_stored_invert_output
3704  046a 2610          	jrne	L1602
3706  046c c60016        	ld	a,_stored_Relays_16to9
3707  046f c10044        	cp	a,_Relays_16to9
3708  0472 2608          	jrne	L1602
3710  0474 c60015        	ld	a,_stored_Relays_8to1
3711  0477 c10043        	cp	a,_Relays_8to1
3712  047a 271e          	jreq	L7502
3713  047c               L1602:
3714                     ; 495     stored_invert_output = invert_output;
3716  047c c60042        	ld	a,_invert_output
3717  047f ae0014        	ldw	x,#_stored_invert_output
3718  0482 cd0000        	call	c_eewrc
3720                     ; 497     stored_Relays_16to9 = Relays_16to9;
3722  0485 c60044        	ld	a,_Relays_16to9
3723  0488 ae0016        	ldw	x,#_stored_Relays_16to9
3724  048b cd0000        	call	c_eewrc
3726                     ; 498     stored_Relays_8to1 = Relays_8to1;
3728  048e c60043        	ld	a,_Relays_8to1
3729  0491 ae0015        	ldw	x,#_stored_Relays_8to1
3730  0494 cd0000        	call	c_eewrc
3732                     ; 500     update_relay_control_registers();
3734  0497 cd066f        	call	_update_relay_control_registers
3736  049a               L7502:
3737                     ; 504   if (stored_hostaddr4 != Pending_hostaddr4 ||
3737                     ; 505       stored_hostaddr3 != Pending_hostaddr3 ||
3737                     ; 506       stored_hostaddr2 != Pending_hostaddr2 ||
3737                     ; 507       stored_hostaddr1 != Pending_hostaddr1) {
3739  049a c6002a        	ld	a,_stored_hostaddr4
3740  049d c1001b        	cp	a,_Pending_hostaddr4
3741  04a0 2618          	jrne	L7602
3743  04a2 c60029        	ld	a,_stored_hostaddr3
3744  04a5 c1001a        	cp	a,_Pending_hostaddr3
3745  04a8 2610          	jrne	L7602
3747  04aa c60028        	ld	a,_stored_hostaddr2
3748  04ad c10019        	cp	a,_Pending_hostaddr2
3749  04b0 2608          	jrne	L7602
3751  04b2 c60027        	ld	a,_stored_hostaddr1
3752  04b5 c10018        	cp	a,_Pending_hostaddr1
3753  04b8 2728          	jreq	L5602
3754  04ba               L7602:
3755                     ; 509     stored_hostaddr4 = Pending_hostaddr4;
3757  04ba c6001b        	ld	a,_Pending_hostaddr4
3758  04bd ae002a        	ldw	x,#_stored_hostaddr4
3759  04c0 cd0000        	call	c_eewrc
3761                     ; 510     stored_hostaddr3 = Pending_hostaddr3;
3763  04c3 c6001a        	ld	a,_Pending_hostaddr3
3764  04c6 ae0029        	ldw	x,#_stored_hostaddr3
3765  04c9 cd0000        	call	c_eewrc
3767                     ; 511     stored_hostaddr2 = Pending_hostaddr2;
3769  04cc c60019        	ld	a,_Pending_hostaddr2
3770  04cf ae0028        	ldw	x,#_stored_hostaddr2
3771  04d2 cd0000        	call	c_eewrc
3773                     ; 512     stored_hostaddr1 = Pending_hostaddr1;
3775  04d5 c60018        	ld	a,_Pending_hostaddr1
3776  04d8 ae0027        	ldw	x,#_stored_hostaddr1
3777  04db cd0000        	call	c_eewrc
3779                     ; 514     submit_changes = 1;
3781  04de 35010001      	mov	_submit_changes,#1
3782  04e2               L5602:
3783                     ; 518   if (stored_draddr4 != Pending_draddr4 ||
3783                     ; 519       stored_draddr3 != Pending_draddr3 ||
3783                     ; 520       stored_draddr2 != Pending_draddr2 ||
3783                     ; 521       stored_draddr1 != Pending_draddr1) {
3785  04e2 c60026        	ld	a,_stored_draddr4
3786  04e5 c10017        	cp	a,_Pending_draddr4
3787  04e8 2618          	jrne	L7702
3789  04ea c60025        	ld	a,_stored_draddr3
3790  04ed c10016        	cp	a,_Pending_draddr3
3791  04f0 2610          	jrne	L7702
3793  04f2 c60024        	ld	a,_stored_draddr2
3794  04f5 c10015        	cp	a,_Pending_draddr2
3795  04f8 2608          	jrne	L7702
3797  04fa c60023        	ld	a,_stored_draddr1
3798  04fd c10014        	cp	a,_Pending_draddr1
3799  0500 2728          	jreq	L5702
3800  0502               L7702:
3801                     ; 523     stored_draddr4 = Pending_draddr4;
3803  0502 c60017        	ld	a,_Pending_draddr4
3804  0505 ae0026        	ldw	x,#_stored_draddr4
3805  0508 cd0000        	call	c_eewrc
3807                     ; 524     stored_draddr3 = Pending_draddr3;
3809  050b c60016        	ld	a,_Pending_draddr3
3810  050e ae0025        	ldw	x,#_stored_draddr3
3811  0511 cd0000        	call	c_eewrc
3813                     ; 525     stored_draddr2 = Pending_draddr2;
3815  0514 c60015        	ld	a,_Pending_draddr2
3816  0517 ae0024        	ldw	x,#_stored_draddr2
3817  051a cd0000        	call	c_eewrc
3819                     ; 526     stored_draddr1 = Pending_draddr1;
3821  051d c60014        	ld	a,_Pending_draddr1
3822  0520 ae0023        	ldw	x,#_stored_draddr1
3823  0523 cd0000        	call	c_eewrc
3825                     ; 528     submit_changes = 1;
3827  0526 35010001      	mov	_submit_changes,#1
3828  052a               L5702:
3829                     ; 532   if (stored_netmask4 != Pending_netmask4 ||
3829                     ; 533       stored_netmask3 != Pending_netmask3 ||
3829                     ; 534       stored_netmask2 != Pending_netmask2 ||
3829                     ; 535       stored_netmask1 != Pending_netmask1) {
3831  052a c60022        	ld	a,_stored_netmask4
3832  052d c10013        	cp	a,_Pending_netmask4
3833  0530 2618          	jrne	L7012
3835  0532 c60021        	ld	a,_stored_netmask3
3836  0535 c10012        	cp	a,_Pending_netmask3
3837  0538 2610          	jrne	L7012
3839  053a c60020        	ld	a,_stored_netmask2
3840  053d c10011        	cp	a,_Pending_netmask2
3841  0540 2608          	jrne	L7012
3843  0542 c6001f        	ld	a,_stored_netmask1
3844  0545 c10010        	cp	a,_Pending_netmask1
3845  0548 2728          	jreq	L5012
3846  054a               L7012:
3847                     ; 537     stored_netmask4 = Pending_netmask4;
3849  054a c60013        	ld	a,_Pending_netmask4
3850  054d ae0022        	ldw	x,#_stored_netmask4
3851  0550 cd0000        	call	c_eewrc
3853                     ; 538     stored_netmask3 = Pending_netmask3;
3855  0553 c60012        	ld	a,_Pending_netmask3
3856  0556 ae0021        	ldw	x,#_stored_netmask3
3857  0559 cd0000        	call	c_eewrc
3859                     ; 539     stored_netmask2 = Pending_netmask2;
3861  055c c60011        	ld	a,_Pending_netmask2
3862  055f ae0020        	ldw	x,#_stored_netmask2
3863  0562 cd0000        	call	c_eewrc
3865                     ; 540     stored_netmask1 = Pending_netmask1;
3867  0565 c60010        	ld	a,_Pending_netmask1
3868  0568 ae001f        	ldw	x,#_stored_netmask1
3869  056b cd0000        	call	c_eewrc
3871                     ; 542     submit_changes = 1;
3873  056e 35010001      	mov	_submit_changes,#1
3874  0572               L5012:
3875                     ; 546   if (stored_port != Pending_port) {
3877  0572 ce001d        	ldw	x,_stored_port
3878  0575 c3000e        	cpw	x,_Pending_port
3879  0578 270f          	jreq	L5112
3880                     ; 548     stored_port = Pending_port;
3882  057a ce000e        	ldw	x,_Pending_port
3883  057d 89            	pushw	x
3884  057e ae001d        	ldw	x,#_stored_port
3885  0581 cd0000        	call	c_eewrw
3887  0584 35010001      	mov	_submit_changes,#1
3888  0588 85            	popw	x
3889                     ; 550     submit_changes = 1;
3891  0589               L5112:
3892                     ; 554   devicename_changed = 0;
3894  0589 725f0000      	clr	_devicename_changed
3895                     ; 555   for(i=0; i<20; i++) {
3897  058d 4f            	clr	a
3898  058e 6b01          	ld	(OFST+0,sp),a
3900  0590               L7112:
3901                     ; 556     if(stored_devicename[i] != ex_stored_devicename[i]) devicename_changed = 1;
3903  0590 5f            	clrw	x
3904  0591 97            	ld	xl,a
3905  0592 905f          	clrw	y
3906  0594 9097          	ld	yl,a
3907  0596 90d60000      	ld	a,(_stored_devicename,y)
3908  059a d1001c        	cp	a,(_ex_stored_devicename,x)
3909  059d 2704          	jreq	L5212
3912  059f 35010000      	mov	_devicename_changed,#1
3913  05a3               L5212:
3914                     ; 555   for(i=0; i<20; i++) {
3916  05a3 0c01          	inc	(OFST+0,sp)
3920  05a5 7b01          	ld	a,(OFST+0,sp)
3921  05a7 a114          	cp	a,#20
3922  05a9 25e5          	jrult	L7112
3923                     ; 558   if(devicename_changed == 1) {
3925  05ab c60000        	ld	a,_devicename_changed
3926  05ae 4a            	dec	a
3927  05af 2612          	jrne	L7212
3928                     ; 560     for(i=0; i<20; i++) { stored_devicename[i] = ex_stored_devicename[i]; }
3930  05b1 6b01          	ld	(OFST+0,sp),a
3932  05b3               L1312:
3935  05b3 5f            	clrw	x
3936  05b4 97            	ld	xl,a
3937  05b5 d6001c        	ld	a,(_ex_stored_devicename,x)
3938  05b8 d70000        	ld	(_stored_devicename,x),a
3941  05bb 0c01          	inc	(OFST+0,sp)
3945  05bd 7b01          	ld	a,(OFST+0,sp)
3946  05bf a114          	cp	a,#20
3947  05c1 25f0          	jrult	L1312
3948  05c3               L7212:
3949                     ; 564   if (stored_uip_ethaddr6 != Pending_uip_ethaddr6 ||
3949                     ; 565       stored_uip_ethaddr5 != Pending_uip_ethaddr5 ||
3949                     ; 566       stored_uip_ethaddr4 != Pending_uip_ethaddr4 ||
3949                     ; 567       stored_uip_ethaddr3 != Pending_uip_ethaddr3 ||
3949                     ; 568       stored_uip_ethaddr2 != Pending_uip_ethaddr2 ||
3949                     ; 569       stored_uip_ethaddr1 != Pending_uip_ethaddr1) {
3951  05c3 c60017        	ld	a,_stored_uip_ethaddr6
3952  05c6 c1000d        	cp	a,_Pending_uip_ethaddr6
3953  05c9 2628          	jrne	L1412
3955  05cb c60018        	ld	a,_stored_uip_ethaddr5
3956  05ce c1000c        	cp	a,_Pending_uip_ethaddr5
3957  05d1 2620          	jrne	L1412
3959  05d3 c60019        	ld	a,_stored_uip_ethaddr4
3960  05d6 c1000b        	cp	a,_Pending_uip_ethaddr4
3961  05d9 2618          	jrne	L1412
3963  05db c6001a        	ld	a,_stored_uip_ethaddr3
3964  05de c1000a        	cp	a,_Pending_uip_ethaddr3
3965  05e1 2610          	jrne	L1412
3967  05e3 c6001b        	ld	a,_stored_uip_ethaddr2
3968  05e6 c10009        	cp	a,_Pending_uip_ethaddr2
3969  05e9 2608          	jrne	L1412
3971  05eb c6001c        	ld	a,_stored_uip_ethaddr1
3972  05ee c10008        	cp	a,_Pending_uip_ethaddr1
3973  05f1 273a          	jreq	L7312
3974  05f3               L1412:
3975                     ; 571     stored_uip_ethaddr6 = Pending_uip_ethaddr6;
3977  05f3 c6000d        	ld	a,_Pending_uip_ethaddr6
3978  05f6 ae0017        	ldw	x,#_stored_uip_ethaddr6
3979  05f9 cd0000        	call	c_eewrc
3981                     ; 572     stored_uip_ethaddr5 = Pending_uip_ethaddr5;
3983  05fc c6000c        	ld	a,_Pending_uip_ethaddr5
3984  05ff ae0018        	ldw	x,#_stored_uip_ethaddr5
3985  0602 cd0000        	call	c_eewrc
3987                     ; 573     stored_uip_ethaddr4 = Pending_uip_ethaddr4;
3989  0605 c6000b        	ld	a,_Pending_uip_ethaddr4
3990  0608 ae0019        	ldw	x,#_stored_uip_ethaddr4
3991  060b cd0000        	call	c_eewrc
3993                     ; 574     stored_uip_ethaddr3 = Pending_uip_ethaddr3;
3995  060e c6000a        	ld	a,_Pending_uip_ethaddr3
3996  0611 ae001a        	ldw	x,#_stored_uip_ethaddr3
3997  0614 cd0000        	call	c_eewrc
3999                     ; 575     stored_uip_ethaddr2 = Pending_uip_ethaddr2;
4001  0617 c60009        	ld	a,_Pending_uip_ethaddr2
4002  061a ae001b        	ldw	x,#_stored_uip_ethaddr2
4003  061d cd0000        	call	c_eewrc
4005                     ; 576     stored_uip_ethaddr1 = Pending_uip_ethaddr1;
4007  0620 c60008        	ld	a,_Pending_uip_ethaddr1
4008  0623 ae001c        	ldw	x,#_stored_uip_ethaddr1
4009  0626 cd0000        	call	c_eewrc
4011                     ; 578     submit_changes = 1;
4013  0629 35010001      	mov	_submit_changes,#1
4014  062d               L7312:
4015                     ; 581   if(submit_changes == 1) {
4017  062d c60001        	ld	a,_submit_changes
4018  0630 a101          	cp	a,#1
4019  0632 2613          	jrne	L3512
4020                     ; 588     check_eeprom_settings(); // Verify EEPROM up to date
4022  0634 cd00ca        	call	_check_eeprom_settings
4024                     ; 589     Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
4026  0637 cd0000        	call	_Enc28j60Init
4028                     ; 590     uip_arp_init();          // Initialize the ARP module
4030  063a cd0000        	call	_uip_arp_init
4032                     ; 591     uip_init();              // Initialize uIP
4034  063d cd0000        	call	_uip_init
4036                     ; 592     HttpDInit();             // Initialize httpd; sets up listening ports
4038  0640 cd0000        	call	_HttpDInit
4040                     ; 593     submit_changes = 0;
4042  0643 4f            	clr	a
4043  0644 c70001        	ld	_submit_changes,a
4044  0647               L3512:
4045                     ; 596   if(submit_changes == 2) {
4047  0647 a102          	cp	a,#2
4048  0649 2622          	jrne	L5512
4049                     ; 599     LEDcontrol(0);  // turn LED off
4051  064b 4f            	clr	a
4052  064c cd0000        	call	_LEDcontrol
4054                     ; 601     WWDG_WR = (uint8_t)0x7f;     // Window register reset
4056  064f 357f50d2      	mov	_WWDG_WR,#127
4057                     ; 602     WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
4059  0653 35ff50d1      	mov	_WWDG_CR,#255
4060                     ; 603     WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
4062  0657 356050d2      	mov	_WWDG_WR,#96
4063                     ; 606     wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
4065  065b aec350        	ldw	x,#50000
4066  065e cd0000        	call	_wait_timer
4068                     ; 607     wait_timer((uint16_t)50000);
4070  0661 aec350        	ldw	x,#50000
4071  0664 cd0000        	call	_wait_timer
4073                     ; 608     wait_timer((uint16_t)50000);
4075  0667 aec350        	ldw	x,#50000
4076  066a cd0000        	call	_wait_timer
4078  066d               L5512:
4079                     ; 610 }
4082  066d 84            	pop	a
4083  066e 81            	ret	
4115                     ; 613 void update_relay_control_registers(void)
4115                     ; 614 {
4116                     	switch	.text
4117  066f               _update_relay_control_registers:
4121                     ; 620   if (invert_output == 0) {
4123  066f c60042        	ld	a,_invert_output
4124  0672 2703cc0765    	jrne	L7612
4125                     ; 621     if (Relays_16to9 & 0x80) PC_ODR |= (uint8_t)0x40; // Relay 16 off, PC bit 6 = 1
4127  0677 720f004406    	btjf	_Relays_16to9,#7,L1712
4130  067c 721c500a      	bset	_PC_ODR,#6
4132  0680 2004          	jra	L3712
4133  0682               L1712:
4134                     ; 622     else PC_ODR &= (uint8_t)(~0x40);
4136  0682 721d500a      	bres	_PC_ODR,#6
4137  0686               L3712:
4138                     ; 623     if (Relays_16to9 & 0x40) PG_ODR |= (uint8_t)0x01; // Relay 15 off, PG bit 0 = 1
4140  0686 720d004406    	btjf	_Relays_16to9,#6,L5712
4143  068b 7210501e      	bset	_PG_ODR,#0
4145  068f 2004          	jra	L7712
4146  0691               L5712:
4147                     ; 624     else PG_ODR &= (uint8_t)(~0x01);
4149  0691 7211501e      	bres	_PG_ODR,#0
4150  0695               L7712:
4151                     ; 625     if (Relays_16to9 & 0x20) PE_ODR |= (uint8_t)0x08; // Relay 14 off, PE bit 3 = 1
4153  0695 720b004406    	btjf	_Relays_16to9,#5,L1022
4156  069a 72165014      	bset	_PE_ODR,#3
4158  069e 2004          	jra	L3022
4159  06a0               L1022:
4160                     ; 626     else PE_ODR &= (uint8_t)(~0x08);
4162  06a0 72175014      	bres	_PE_ODR,#3
4163  06a4               L3022:
4164                     ; 627     if (Relays_16to9 & 0x10) PD_ODR |= (uint8_t)0x01; // Relay 13 off, PD bit 0 = 1
4166  06a4 7209004406    	btjf	_Relays_16to9,#4,L5022
4169  06a9 7210500f      	bset	_PD_ODR,#0
4171  06ad 2004          	jra	L7022
4172  06af               L5022:
4173                     ; 628     else PD_ODR &= (uint8_t)(~0x01);
4175  06af 7211500f      	bres	_PD_ODR,#0
4176  06b3               L7022:
4177                     ; 629     if (Relays_16to9 & 0x08) PD_ODR |= (uint8_t)0x08; // Relay 12 off, PD bit 3 = 1
4179  06b3 7207004406    	btjf	_Relays_16to9,#3,L1122
4182  06b8 7216500f      	bset	_PD_ODR,#3
4184  06bc 2004          	jra	L3122
4185  06be               L1122:
4186                     ; 630     else PD_ODR &= (uint8_t)(~0x08);
4188  06be 7217500f      	bres	_PD_ODR,#3
4189  06c2               L3122:
4190                     ; 631     if (Relays_16to9 & 0x04) PD_ODR |= (uint8_t)0x20; // Relay 11 off, PD bit 5 = 1
4192  06c2 7205004406    	btjf	_Relays_16to9,#2,L5122
4195  06c7 721a500f      	bset	_PD_ODR,#5
4197  06cb 2004          	jra	L7122
4198  06cd               L5122:
4199                     ; 632     else PD_ODR &= (uint8_t)(~0x20);
4201  06cd 721b500f      	bres	_PD_ODR,#5
4202  06d1               L7122:
4203                     ; 633     if (Relays_16to9 & 0x02) PD_ODR |= (uint8_t)0x80; // Relay 10 off, PD bit 7 = 1
4205  06d1 7203004406    	btjf	_Relays_16to9,#1,L1222
4208  06d6 721e500f      	bset	_PD_ODR,#7
4210  06da 2004          	jra	L3222
4211  06dc               L1222:
4212                     ; 634     else PD_ODR &= (uint8_t)(~0x80);
4214  06dc 721f500f      	bres	_PD_ODR,#7
4215  06e0               L3222:
4216                     ; 635     if (Relays_16to9 & 0x01) PA_ODR |= (uint8_t)0x10; // Relay  9 off, PA bit 4 = 1
4218  06e0 7201004406    	btjf	_Relays_16to9,#0,L5222
4221  06e5 72185000      	bset	_PA_ODR,#4
4223  06e9 2004          	jra	L7222
4224  06eb               L5222:
4225                     ; 636     else PA_ODR &= (uint8_t)(~0x10);
4227  06eb 72195000      	bres	_PA_ODR,#4
4228  06ef               L7222:
4229                     ; 640     if (Relays_8to1 & 0x80) PC_ODR |= (uint8_t)0x80; // Relay  8 off, PC bit 7 = 1
4231  06ef 720f004306    	btjf	_Relays_8to1,#7,L1322
4234  06f4 721e500a      	bset	_PC_ODR,#7
4236  06f8 2004          	jra	L3322
4237  06fa               L1322:
4238                     ; 641     else PC_ODR &= (uint8_t)(~0x80);
4240  06fa 721f500a      	bres	_PC_ODR,#7
4241  06fe               L3322:
4242                     ; 642     if (Relays_8to1 & 0x40) PG_ODR |= (uint8_t)0x02; // Relay  7 off, PG bit 1 = 1
4244  06fe 720d004306    	btjf	_Relays_8to1,#6,L5322
4247  0703 7212501e      	bset	_PG_ODR,#1
4249  0707 2004          	jra	L7322
4250  0709               L5322:
4251                     ; 643     else PG_ODR &= (uint8_t)(~0x02);
4253  0709 7213501e      	bres	_PG_ODR,#1
4254  070d               L7322:
4255                     ; 644     if (Relays_8to1 & 0x20) PE_ODR |= (uint8_t)0x01; // Relay  6 off, PE bit 0 = 1
4257  070d 720b004306    	btjf	_Relays_8to1,#5,L1422
4260  0712 72105014      	bset	_PE_ODR,#0
4262  0716 2004          	jra	L3422
4263  0718               L1422:
4264                     ; 645     else PE_ODR &= (uint8_t)(~0x01);
4266  0718 72115014      	bres	_PE_ODR,#0
4267  071c               L3422:
4268                     ; 646     if (Relays_8to1 & 0x10) PD_ODR |= (uint8_t)0x04; // Relay  5 off, PD bit 2 = 1
4270  071c 7209004306    	btjf	_Relays_8to1,#4,L5422
4273  0721 7214500f      	bset	_PD_ODR,#2
4275  0725 2004          	jra	L7422
4276  0727               L5422:
4277                     ; 647     else PD_ODR &= (uint8_t)(~0x04);
4279  0727 7215500f      	bres	_PD_ODR,#2
4280  072b               L7422:
4281                     ; 648     if (Relays_8to1 & 0x08) PD_ODR |= (uint8_t)0x10; // Relay  4 off, PD bit 4 = 1
4283  072b 7207004306    	btjf	_Relays_8to1,#3,L1522
4286  0730 7218500f      	bset	_PD_ODR,#4
4288  0734 2004          	jra	L3522
4289  0736               L1522:
4290                     ; 649     else PD_ODR &= (uint8_t)(~0x10);
4292  0736 7219500f      	bres	_PD_ODR,#4
4293  073a               L3522:
4294                     ; 650     if (Relays_8to1 & 0x04) PD_ODR |= (uint8_t)0x40; // Relay  3 off, PD bit 6 = 1
4296  073a 7205004306    	btjf	_Relays_8to1,#2,L5522
4299  073f 721c500f      	bset	_PD_ODR,#6
4301  0743 2004          	jra	L7522
4302  0745               L5522:
4303                     ; 651     else PD_ODR &= (uint8_t)(~0x40);
4305  0745 721d500f      	bres	_PD_ODR,#6
4306  0749               L7522:
4307                     ; 652     if (Relays_8to1 & 0x02) PA_ODR |= (uint8_t)0x20; // Relay  2 off, PA bit 5 = 1
4309  0749 7203004306    	btjf	_Relays_8to1,#1,L1622
4312  074e 721a5000      	bset	_PA_ODR,#5
4314  0752 2004          	jra	L3622
4315  0754               L1622:
4316                     ; 653     else PA_ODR &= (uint8_t)(~0x20);
4318  0754 721b5000      	bres	_PA_ODR,#5
4319  0758               L3622:
4320                     ; 654     if (Relays_8to1 & 0x01) PA_ODR |= (uint8_t)0x08; // Relay  1 off, PA bit 3 = 1
4322  0758 7201004303    	btjf	_Relays_8to1,#0,L5622
4325  075d cc0854        	jp	L1732
4326  0760               L5622:
4327                     ; 655     else PA_ODR &= (uint8_t)(~0x08);
4330  0760 72175000      	bres	_PA_ODR,#3
4332  0764 81            	ret	
4333  0765               L7612:
4334                     ; 658   else if (invert_output == 1) {
4336  0765 4a            	dec	a
4337  0766 2703cc0858    	jrne	L1722
4338                     ; 659     if (Relays_16to9 & 0x80) PC_ODR &= (uint8_t)(~0x40); // Relay 16 off, PC bit 6 = 1
4340  076b 720f004406    	btjf	_Relays_16to9,#7,L5722
4343  0770 721d500a      	bres	_PC_ODR,#6
4345  0774 2004          	jra	L7722
4346  0776               L5722:
4347                     ; 660     else PC_ODR |= (uint8_t)0x40;
4349  0776 721c500a      	bset	_PC_ODR,#6
4350  077a               L7722:
4351                     ; 661     if (Relays_16to9 & 0x40) PG_ODR &= (uint8_t)(~0x01); // Relay 15 off, PG bit 0 = 1
4353  077a 720d004406    	btjf	_Relays_16to9,#6,L1032
4356  077f 7211501e      	bres	_PG_ODR,#0
4358  0783 2004          	jra	L3032
4359  0785               L1032:
4360                     ; 662     else PG_ODR |= (uint8_t)0x01;
4362  0785 7210501e      	bset	_PG_ODR,#0
4363  0789               L3032:
4364                     ; 663     if (Relays_16to9 & 0x20) PE_ODR &= (uint8_t)(~0x08); // Relay 14 off, PE bit 3 = 1
4366  0789 720b004406    	btjf	_Relays_16to9,#5,L5032
4369  078e 72175014      	bres	_PE_ODR,#3
4371  0792 2004          	jra	L7032
4372  0794               L5032:
4373                     ; 664     else PE_ODR |= (uint8_t)0x08;
4375  0794 72165014      	bset	_PE_ODR,#3
4376  0798               L7032:
4377                     ; 665     if (Relays_16to9 & 0x10) PD_ODR &= (uint8_t)(~0x01); // Relay 13 off, PD bit 0 = 1
4379  0798 7209004406    	btjf	_Relays_16to9,#4,L1132
4382  079d 7211500f      	bres	_PD_ODR,#0
4384  07a1 2004          	jra	L3132
4385  07a3               L1132:
4386                     ; 666     else PD_ODR |= (uint8_t)0x01;
4388  07a3 7210500f      	bset	_PD_ODR,#0
4389  07a7               L3132:
4390                     ; 667     if (Relays_16to9 & 0x08) PD_ODR &= (uint8_t)(~0x08); // Relay 12 off, PD bit 3 = 1
4392  07a7 7207004406    	btjf	_Relays_16to9,#3,L5132
4395  07ac 7217500f      	bres	_PD_ODR,#3
4397  07b0 2004          	jra	L7132
4398  07b2               L5132:
4399                     ; 668     else PD_ODR |= (uint8_t)0x08;
4401  07b2 7216500f      	bset	_PD_ODR,#3
4402  07b6               L7132:
4403                     ; 669     if (Relays_16to9 & 0x04) PD_ODR &= (uint8_t)(~0x20); // Relay 11 off, PD bit 5 = 1
4405  07b6 7205004406    	btjf	_Relays_16to9,#2,L1232
4408  07bb 721b500f      	bres	_PD_ODR,#5
4410  07bf 2004          	jra	L3232
4411  07c1               L1232:
4412                     ; 670     else PD_ODR |= (uint8_t)0x20;
4414  07c1 721a500f      	bset	_PD_ODR,#5
4415  07c5               L3232:
4416                     ; 671     if (Relays_16to9 & 0x02) PD_ODR &= (uint8_t)(~0x80); // Relay 10 off, PD bit 7 = 1
4418  07c5 7203004406    	btjf	_Relays_16to9,#1,L5232
4421  07ca 721f500f      	bres	_PD_ODR,#7
4423  07ce 2004          	jra	L7232
4424  07d0               L5232:
4425                     ; 672     else PD_ODR |= (uint8_t)0x80;
4427  07d0 721e500f      	bset	_PD_ODR,#7
4428  07d4               L7232:
4429                     ; 673     if (Relays_16to9 & 0x01) PA_ODR &= (uint8_t)(~0x10); // Relay  9 off, PA bit 4 = 1
4431  07d4 7201004406    	btjf	_Relays_16to9,#0,L1332
4434  07d9 72195000      	bres	_PA_ODR,#4
4436  07dd 2004          	jra	L3332
4437  07df               L1332:
4438                     ; 674     else PA_ODR |= (uint8_t)0x10;
4440  07df 72185000      	bset	_PA_ODR,#4
4441  07e3               L3332:
4442                     ; 678     if (Relays_8to1 & 0x80) PC_ODR &= (uint8_t)(~0x80); // Relay  8 off, PC bit 7 = 1
4444  07e3 720f004306    	btjf	_Relays_8to1,#7,L5332
4447  07e8 721f500a      	bres	_PC_ODR,#7
4449  07ec 2004          	jra	L7332
4450  07ee               L5332:
4451                     ; 679     else PC_ODR |= (uint8_t)0x80;
4453  07ee 721e500a      	bset	_PC_ODR,#7
4454  07f2               L7332:
4455                     ; 680     if (Relays_8to1 & 0x40) PG_ODR &= (uint8_t)(~0x02); // Relay  7 off, PG bit 1 = 1
4457  07f2 720d004306    	btjf	_Relays_8to1,#6,L1432
4460  07f7 7213501e      	bres	_PG_ODR,#1
4462  07fb 2004          	jra	L3432
4463  07fd               L1432:
4464                     ; 681     else PG_ODR |= (uint8_t)0x02;
4466  07fd 7212501e      	bset	_PG_ODR,#1
4467  0801               L3432:
4468                     ; 682     if (Relays_8to1 & 0x20) PE_ODR &= (uint8_t)(~0x01); // Relay  6 off, PE bit 0 = 1
4470  0801 720b004306    	btjf	_Relays_8to1,#5,L5432
4473  0806 72115014      	bres	_PE_ODR,#0
4475  080a 2004          	jra	L7432
4476  080c               L5432:
4477                     ; 683     else PE_ODR |= (uint8_t)0x01;
4479  080c 72105014      	bset	_PE_ODR,#0
4480  0810               L7432:
4481                     ; 684     if (Relays_8to1 & 0x10) PD_ODR &= (uint8_t)(~0x04); // Relay  5 off, PD bit 2 = 1
4483  0810 7209004306    	btjf	_Relays_8to1,#4,L1532
4486  0815 7215500f      	bres	_PD_ODR,#2
4488  0819 2004          	jra	L3532
4489  081b               L1532:
4490                     ; 685     else PD_ODR |= (uint8_t)0x04;
4492  081b 7214500f      	bset	_PD_ODR,#2
4493  081f               L3532:
4494                     ; 686     if (Relays_8to1 & 0x08) PD_ODR &= (uint8_t)(~0x10); // Relay  4 off, PD bit 4 = 1
4496  081f 7207004306    	btjf	_Relays_8to1,#3,L5532
4499  0824 7219500f      	bres	_PD_ODR,#4
4501  0828 2004          	jra	L7532
4502  082a               L5532:
4503                     ; 687     else PD_ODR |= (uint8_t)0x10;
4505  082a 7218500f      	bset	_PD_ODR,#4
4506  082e               L7532:
4507                     ; 688     if (Relays_8to1 & 0x04) PD_ODR &= (uint8_t)(~0x40); // Relay  3 off, PD bit 6 = 1
4509  082e 7205004306    	btjf	_Relays_8to1,#2,L1632
4512  0833 721d500f      	bres	_PD_ODR,#6
4514  0837 2004          	jra	L3632
4515  0839               L1632:
4516                     ; 689     else PD_ODR |= (uint8_t)0x40;
4518  0839 721c500f      	bset	_PD_ODR,#6
4519  083d               L3632:
4520                     ; 690     if (Relays_8to1 & 0x02) PA_ODR &= (uint8_t)(~0x20); // Relay  2 off, PA bit 5 = 1
4522  083d 7203004306    	btjf	_Relays_8to1,#1,L5632
4525  0842 721b5000      	bres	_PA_ODR,#5
4527  0846 2004          	jra	L7632
4528  0848               L5632:
4529                     ; 691     else PA_ODR |= (uint8_t)0x20;
4531  0848 721a5000      	bset	_PA_ODR,#5
4532  084c               L7632:
4533                     ; 692     if (Relays_8to1 & 0x01) PA_ODR &= (uint8_t)(~0x08); // Relay  1 off, PA bit 3 = 1
4535  084c 7201004303    	btjf	_Relays_8to1,#0,L1732
4538  0851 cc0760        	jp	L5622
4539  0854               L1732:
4540                     ; 693     else PA_ODR |= (uint8_t)0x08;
4543  0854 72165000      	bset	_PA_ODR,#3
4544  0858               L1722:
4545                     ; 695 }
4548  0858 81            	ret	
4612                     ; 697 void check_reset_button(void)
4612                     ; 698 {
4613                     	switch	.text
4614  0859               _check_reset_button:
4616  0859 88            	push	a
4617       00000001      OFST:	set	1
4620                     ; 703   if((PA_IDR & 0x02) == 0) {
4622  085a 7203500103cc  	btjt	_PA_IDR,#1,L1142
4623                     ; 705     for (i=0; i<100; i++) {
4625  0862 0f01          	clr	(OFST+0,sp)
4627  0864               L3142:
4628                     ; 706       wait_timer(50000); // wait 50ms
4630  0864 aec350        	ldw	x,#50000
4631  0867 cd0000        	call	_wait_timer
4633                     ; 707       if((PA_IDR & 0x02) == 1) {  // check Reset Button again. If released
4635  086a c65001        	ld	a,_PA_IDR
4636  086d a402          	and	a,#2
4637  086f 4a            	dec	a
4638  0870 2602          	jrne	L1242
4639                     ; 709         return;
4642  0872 84            	pop	a
4643  0873 81            	ret	
4644  0874               L1242:
4645                     ; 705     for (i=0; i<100; i++) {
4647  0874 0c01          	inc	(OFST+0,sp)
4651  0876 7b01          	ld	a,(OFST+0,sp)
4652  0878 a164          	cp	a,#100
4653  087a 25e8          	jrult	L3142
4654                     ; 714     LEDcontrol(0);  // turn LED off
4656  087c 4f            	clr	a
4657  087d cd0000        	call	_LEDcontrol
4660  0880               L5242:
4661                     ; 715     while((PA_IDR & 0x02) == 0) {  // Wait for button release
4663  0880 72035001fb    	btjf	_PA_IDR,#1,L5242
4664                     ; 724     magic4 = 0x00;		   // MSB Magic Number stored in EEPROM
4666  0885 4f            	clr	a
4667  0886 ae002e        	ldw	x,#_magic4
4668  0889 cd0000        	call	c_eewrc
4670                     ; 725     magic3 = 0x00;		   //
4672  088c 4f            	clr	a
4673  088d ae002d        	ldw	x,#_magic3
4674  0890 cd0000        	call	c_eewrc
4676                     ; 726     magic2 = 0x00;		   //
4678  0893 4f            	clr	a
4679  0894 ae002c        	ldw	x,#_magic2
4680  0897 cd0000        	call	c_eewrc
4682                     ; 727     magic1 = 0x00;		   // LSB Magic Number
4684  089a 4f            	clr	a
4685  089b ae002b        	ldw	x,#_magic1
4686  089e cd0000        	call	c_eewrc
4688                     ; 728     stored_hostaddr4 = 0x00;	   // MSB hostaddr stored in EEPROM
4690  08a1 4f            	clr	a
4691  08a2 ae002a        	ldw	x,#_stored_hostaddr4
4692  08a5 cd0000        	call	c_eewrc
4694                     ; 729     stored_hostaddr3 = 0x00;	   //
4696  08a8 4f            	clr	a
4697  08a9 ae0029        	ldw	x,#_stored_hostaddr3
4698  08ac cd0000        	call	c_eewrc
4700                     ; 730     stored_hostaddr2 = 0x00;	   //
4702  08af 4f            	clr	a
4703  08b0 ae0028        	ldw	x,#_stored_hostaddr2
4704  08b3 cd0000        	call	c_eewrc
4706                     ; 731     stored_hostaddr1 = 0x00;	   // LSB hostaddr
4708  08b6 4f            	clr	a
4709  08b7 ae0027        	ldw	x,#_stored_hostaddr1
4710  08ba cd0000        	call	c_eewrc
4712                     ; 732     stored_draddr4 = 0x00;	   // MSB draddr stored in EEPROM
4714  08bd 4f            	clr	a
4715  08be ae0026        	ldw	x,#_stored_draddr4
4716  08c1 cd0000        	call	c_eewrc
4718                     ; 733     stored_draddr3 = 0x00;	   //
4720  08c4 4f            	clr	a
4721  08c5 ae0025        	ldw	x,#_stored_draddr3
4722  08c8 cd0000        	call	c_eewrc
4724                     ; 734     stored_draddr2 = 0x00;	   //
4726  08cb 4f            	clr	a
4727  08cc ae0024        	ldw	x,#_stored_draddr2
4728  08cf cd0000        	call	c_eewrc
4730                     ; 735     stored_draddr1 = 0x00;	   // LSB draddr
4732  08d2 4f            	clr	a
4733  08d3 ae0023        	ldw	x,#_stored_draddr1
4734  08d6 cd0000        	call	c_eewrc
4736                     ; 736     stored_netmask4 = 0x00;	   // MSB netmask stored in EEPROM
4738  08d9 4f            	clr	a
4739  08da ae0022        	ldw	x,#_stored_netmask4
4740  08dd cd0000        	call	c_eewrc
4742                     ; 737     stored_netmask3 = 0x00;	   //
4744  08e0 4f            	clr	a
4745  08e1 ae0021        	ldw	x,#_stored_netmask3
4746  08e4 cd0000        	call	c_eewrc
4748                     ; 738     stored_netmask2 = 0x00;	   //
4750  08e7 4f            	clr	a
4751  08e8 ae0020        	ldw	x,#_stored_netmask2
4752  08eb cd0000        	call	c_eewrc
4754                     ; 739     stored_netmask1 = 0x00;	   // LSB netmask
4756  08ee 4f            	clr	a
4757  08ef ae001f        	ldw	x,#_stored_netmask1
4758  08f2 cd0000        	call	c_eewrc
4760                     ; 740     stored_port = 0x0000;	   // Port stored in EEPROM
4762  08f5 5f            	clrw	x
4763  08f6 89            	pushw	x
4764  08f7 ae001d        	ldw	x,#_stored_port
4765  08fa cd0000        	call	c_eewrw
4767  08fd 4f            	clr	a
4768  08fe 85            	popw	x
4769                     ; 741     stored_uip_ethaddr1 = 0x00;	   // MAC MSB
4771  08ff ae001c        	ldw	x,#_stored_uip_ethaddr1
4772  0902 cd0000        	call	c_eewrc
4774                     ; 742     stored_uip_ethaddr2 = 0x00;	   //
4776  0905 4f            	clr	a
4777  0906 ae001b        	ldw	x,#_stored_uip_ethaddr2
4778  0909 cd0000        	call	c_eewrc
4780                     ; 743     stored_uip_ethaddr3 = 0x00;	   //
4782  090c 4f            	clr	a
4783  090d ae001a        	ldw	x,#_stored_uip_ethaddr3
4784  0910 cd0000        	call	c_eewrc
4786                     ; 744     stored_uip_ethaddr4 = 0x00;	   //
4788  0913 4f            	clr	a
4789  0914 ae0019        	ldw	x,#_stored_uip_ethaddr4
4790  0917 cd0000        	call	c_eewrc
4792                     ; 745     stored_uip_ethaddr5 = 0x00;	   //
4794  091a 4f            	clr	a
4795  091b ae0018        	ldw	x,#_stored_uip_ethaddr5
4796  091e cd0000        	call	c_eewrc
4798                     ; 746     stored_uip_ethaddr6 = 0x00;	   // MAC LSB stored in EEPROM
4800  0921 4f            	clr	a
4801  0922 ae0017        	ldw	x,#_stored_uip_ethaddr6
4802  0925 cd0000        	call	c_eewrc
4804                     ; 747     stored_Relays_16to9 = 0x00;    // Relay states for relays 16 to 9
4806  0928 4f            	clr	a
4807  0929 ae0016        	ldw	x,#_stored_Relays_16to9
4808  092c cd0000        	call	c_eewrc
4810                     ; 748     stored_Relays_8to1 = 0x00;     // Relay states for relays 8 to 1
4812  092f 4f            	clr	a
4813  0930 ae0015        	ldw	x,#_stored_Relays_8to1
4814  0933 cd0000        	call	c_eewrc
4816                     ; 749     stored_invert_output = 0x00;   // Relay state inversion control
4818  0936 4f            	clr	a
4819  0937 ae0014        	ldw	x,#_stored_invert_output
4820  093a cd0000        	call	c_eewrc
4822                     ; 750     stored_devicename[0] = 0x00;   // Device name
4824  093d 4f            	clr	a
4825  093e ae0000        	ldw	x,#_stored_devicename
4826  0941 cd0000        	call	c_eewrc
4828                     ; 751     stored_devicename[1] = 0x00;   // Device name
4830  0944 4f            	clr	a
4831  0945 ae0001        	ldw	x,#_stored_devicename+1
4832  0948 cd0000        	call	c_eewrc
4834                     ; 752     stored_devicename[2] = 0x00;   // Device name
4836  094b 4f            	clr	a
4837  094c ae0002        	ldw	x,#_stored_devicename+2
4838  094f cd0000        	call	c_eewrc
4840                     ; 753     stored_devicename[3] = 0x00;   // Device name
4842  0952 4f            	clr	a
4843  0953 ae0003        	ldw	x,#_stored_devicename+3
4844  0956 cd0000        	call	c_eewrc
4846                     ; 754     stored_devicename[4] = 0x00;   // Device name
4848  0959 4f            	clr	a
4849  095a ae0004        	ldw	x,#_stored_devicename+4
4850  095d cd0000        	call	c_eewrc
4852                     ; 755     stored_devicename[5] = 0x00;   // Device name
4854  0960 4f            	clr	a
4855  0961 ae0005        	ldw	x,#_stored_devicename+5
4856  0964 cd0000        	call	c_eewrc
4858                     ; 756     stored_devicename[6] = 0x00;   // Device name
4860  0967 4f            	clr	a
4861  0968 ae0006        	ldw	x,#_stored_devicename+6
4862  096b cd0000        	call	c_eewrc
4864                     ; 757     stored_devicename[7] = 0x00;   // Device name
4866  096e 4f            	clr	a
4867  096f ae0007        	ldw	x,#_stored_devicename+7
4868  0972 cd0000        	call	c_eewrc
4870                     ; 758     stored_devicename[8] = 0x00;   // Device name
4872  0975 4f            	clr	a
4873  0976 ae0008        	ldw	x,#_stored_devicename+8
4874  0979 cd0000        	call	c_eewrc
4876                     ; 759     stored_devicename[9] = 0x00;   // Device name
4878  097c 4f            	clr	a
4879  097d ae0009        	ldw	x,#_stored_devicename+9
4880  0980 cd0000        	call	c_eewrc
4882                     ; 760     stored_devicename[10] = 0x00;  // Device name
4884  0983 4f            	clr	a
4885  0984 ae000a        	ldw	x,#_stored_devicename+10
4886  0987 cd0000        	call	c_eewrc
4888                     ; 761     stored_devicename[11] = 0x00;  // Device name
4890  098a 4f            	clr	a
4891  098b ae000b        	ldw	x,#_stored_devicename+11
4892  098e cd0000        	call	c_eewrc
4894                     ; 762     stored_devicename[12] = 0x00;  // Device name
4896  0991 4f            	clr	a
4897  0992 ae000c        	ldw	x,#_stored_devicename+12
4898  0995 cd0000        	call	c_eewrc
4900                     ; 763     stored_devicename[13] = 0x00;  // Device name
4902  0998 4f            	clr	a
4903  0999 ae000d        	ldw	x,#_stored_devicename+13
4904  099c cd0000        	call	c_eewrc
4906                     ; 764     stored_devicename[14] = 0x00;  // Device name
4908  099f 4f            	clr	a
4909  09a0 ae000e        	ldw	x,#_stored_devicename+14
4910  09a3 cd0000        	call	c_eewrc
4912                     ; 765     stored_devicename[15] = 0x00;  // Device name
4914  09a6 4f            	clr	a
4915  09a7 ae000f        	ldw	x,#_stored_devicename+15
4916  09aa cd0000        	call	c_eewrc
4918                     ; 766     stored_devicename[16] = 0x00;  // Device name
4920  09ad 4f            	clr	a
4921  09ae ae0010        	ldw	x,#_stored_devicename+16
4922  09b1 cd0000        	call	c_eewrc
4924                     ; 767     stored_devicename[17] = 0x00;  // Device name
4926  09b4 4f            	clr	a
4927  09b5 ae0011        	ldw	x,#_stored_devicename+17
4928  09b8 cd0000        	call	c_eewrc
4930                     ; 768     stored_devicename[18] = 0x00;  // Device name
4932  09bb 4f            	clr	a
4933  09bc ae0012        	ldw	x,#_stored_devicename+18
4934  09bf cd0000        	call	c_eewrc
4936                     ; 769     stored_devicename[19] = 0x00;  // Device name
4938  09c2 4f            	clr	a
4939  09c3 ae0013        	ldw	x,#_stored_devicename+19
4940  09c6 cd0000        	call	c_eewrc
4942                     ; 771     WWDG_WR = (uint8_t)0x7f;     // Window register reset
4944  09c9 357f50d2      	mov	_WWDG_WR,#127
4945                     ; 772     WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
4947  09cd 35ff50d1      	mov	_WWDG_CR,#255
4948                     ; 773     WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
4950  09d1 356050d2      	mov	_WWDG_WR,#96
4951                     ; 776     wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
4953  09d5 aec350        	ldw	x,#50000
4954  09d8 cd0000        	call	_wait_timer
4956                     ; 777     wait_timer((uint16_t)50000);
4958  09db aec350        	ldw	x,#50000
4959  09de cd0000        	call	_wait_timer
4961                     ; 778     wait_timer((uint16_t)50000);
4963  09e1 aec350        	ldw	x,#50000
4964  09e4 cd0000        	call	_wait_timer
4966  09e7               L1142:
4967                     ; 780 }
4970  09e7 84            	pop	a
4971  09e8 81            	ret	
5005                     ; 783 void debugflash(void)
5005                     ; 784 {
5006                     	switch	.text
5007  09e9               _debugflash:
5009  09e9 88            	push	a
5010       00000001      OFST:	set	1
5013                     ; 799   LEDcontrol(0);     // turn LED off
5015  09ea 4f            	clr	a
5016  09eb cd0000        	call	_LEDcontrol
5018                     ; 800   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
5020  09ee 0f01          	clr	(OFST+0,sp)
5022  09f0               L5442:
5025  09f0 aec350        	ldw	x,#50000
5026  09f3 cd0000        	call	_wait_timer
5030  09f6 0c01          	inc	(OFST+0,sp)
5034  09f8 7b01          	ld	a,(OFST+0,sp)
5035  09fa a10a          	cp	a,#10
5036  09fc 25f2          	jrult	L5442
5037                     ; 802   LEDcontrol(1);     // turn LED on
5039  09fe a601          	ld	a,#1
5040  0a00 cd0000        	call	_LEDcontrol
5042                     ; 803   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
5044  0a03 0f01          	clr	(OFST+0,sp)
5046  0a05               L3542:
5049  0a05 aec350        	ldw	x,#50000
5050  0a08 cd0000        	call	_wait_timer
5054  0a0b 0c01          	inc	(OFST+0,sp)
5058  0a0d 7b01          	ld	a,(OFST+0,sp)
5059  0a0f a10a          	cp	a,#10
5060  0a11 25f2          	jrult	L3542
5061                     ; 804 }
5064  0a13 84            	pop	a
5065  0a14 81            	ret	
5671                     	switch	.bss
5672  0000               _devicename_changed:
5673  0000 00            	ds.b	1
5674                     	xdef	_devicename_changed
5675  0001               _submit_changes:
5676  0001 00            	ds.b	1
5677                     	xdef	_submit_changes
5678  0002               _uip_ethaddr1:
5679  0002 00            	ds.b	1
5680                     	xdef	_uip_ethaddr1
5681  0003               _uip_ethaddr2:
5682  0003 00            	ds.b	1
5683                     	xdef	_uip_ethaddr2
5684  0004               _uip_ethaddr3:
5685  0004 00            	ds.b	1
5686                     	xdef	_uip_ethaddr3
5687  0005               _uip_ethaddr4:
5688  0005 00            	ds.b	1
5689                     	xdef	_uip_ethaddr4
5690  0006               _uip_ethaddr5:
5691  0006 00            	ds.b	1
5692                     	xdef	_uip_ethaddr5
5693  0007               _uip_ethaddr6:
5694  0007 00            	ds.b	1
5695                     	xdef	_uip_ethaddr6
5696  0008               _Pending_uip_ethaddr1:
5697  0008 00            	ds.b	1
5698                     	xdef	_Pending_uip_ethaddr1
5699  0009               _Pending_uip_ethaddr2:
5700  0009 00            	ds.b	1
5701                     	xdef	_Pending_uip_ethaddr2
5702  000a               _Pending_uip_ethaddr3:
5703  000a 00            	ds.b	1
5704                     	xdef	_Pending_uip_ethaddr3
5705  000b               _Pending_uip_ethaddr4:
5706  000b 00            	ds.b	1
5707                     	xdef	_Pending_uip_ethaddr4
5708  000c               _Pending_uip_ethaddr5:
5709  000c 00            	ds.b	1
5710                     	xdef	_Pending_uip_ethaddr5
5711  000d               _Pending_uip_ethaddr6:
5712  000d 00            	ds.b	1
5713                     	xdef	_Pending_uip_ethaddr6
5714  000e               _Pending_port:
5715  000e 0000          	ds.b	2
5716                     	xdef	_Pending_port
5717  0010               _Pending_netmask1:
5718  0010 00            	ds.b	1
5719                     	xdef	_Pending_netmask1
5720  0011               _Pending_netmask2:
5721  0011 00            	ds.b	1
5722                     	xdef	_Pending_netmask2
5723  0012               _Pending_netmask3:
5724  0012 00            	ds.b	1
5725                     	xdef	_Pending_netmask3
5726  0013               _Pending_netmask4:
5727  0013 00            	ds.b	1
5728                     	xdef	_Pending_netmask4
5729  0014               _Pending_draddr1:
5730  0014 00            	ds.b	1
5731                     	xdef	_Pending_draddr1
5732  0015               _Pending_draddr2:
5733  0015 00            	ds.b	1
5734                     	xdef	_Pending_draddr2
5735  0016               _Pending_draddr3:
5736  0016 00            	ds.b	1
5737                     	xdef	_Pending_draddr3
5738  0017               _Pending_draddr4:
5739  0017 00            	ds.b	1
5740                     	xdef	_Pending_draddr4
5741  0018               _Pending_hostaddr1:
5742  0018 00            	ds.b	1
5743                     	xdef	_Pending_hostaddr1
5744  0019               _Pending_hostaddr2:
5745  0019 00            	ds.b	1
5746                     	xdef	_Pending_hostaddr2
5747  001a               _Pending_hostaddr3:
5748  001a 00            	ds.b	1
5749                     	xdef	_Pending_hostaddr3
5750  001b               _Pending_hostaddr4:
5751  001b 00            	ds.b	1
5752                     	xdef	_Pending_hostaddr4
5753  001c               _ex_stored_devicename:
5754  001c 000000000000  	ds.b	20
5755                     	xdef	_ex_stored_devicename
5756  0030               _ex_stored_port:
5757  0030 0000          	ds.b	2
5758                     	xdef	_ex_stored_port
5759  0032               _ex_stored_netmask1:
5760  0032 00            	ds.b	1
5761                     	xdef	_ex_stored_netmask1
5762  0033               _ex_stored_netmask2:
5763  0033 00            	ds.b	1
5764                     	xdef	_ex_stored_netmask2
5765  0034               _ex_stored_netmask3:
5766  0034 00            	ds.b	1
5767                     	xdef	_ex_stored_netmask3
5768  0035               _ex_stored_netmask4:
5769  0035 00            	ds.b	1
5770                     	xdef	_ex_stored_netmask4
5771  0036               _ex_stored_draddr1:
5772  0036 00            	ds.b	1
5773                     	xdef	_ex_stored_draddr1
5774  0037               _ex_stored_draddr2:
5775  0037 00            	ds.b	1
5776                     	xdef	_ex_stored_draddr2
5777  0038               _ex_stored_draddr3:
5778  0038 00            	ds.b	1
5779                     	xdef	_ex_stored_draddr3
5780  0039               _ex_stored_draddr4:
5781  0039 00            	ds.b	1
5782                     	xdef	_ex_stored_draddr4
5783  003a               _ex_stored_hostaddr1:
5784  003a 00            	ds.b	1
5785                     	xdef	_ex_stored_hostaddr1
5786  003b               _ex_stored_hostaddr2:
5787  003b 00            	ds.b	1
5788                     	xdef	_ex_stored_hostaddr2
5789  003c               _ex_stored_hostaddr3:
5790  003c 00            	ds.b	1
5791                     	xdef	_ex_stored_hostaddr3
5792  003d               _ex_stored_hostaddr4:
5793  003d 00            	ds.b	1
5794                     	xdef	_ex_stored_hostaddr4
5795  003e               _IpAddr:
5796  003e 00000000      	ds.b	4
5797                     	xdef	_IpAddr
5798  0042               _invert_output:
5799  0042 00            	ds.b	1
5800                     	xdef	_invert_output
5801  0043               _Relays_8to1:
5802  0043 00            	ds.b	1
5803                     	xdef	_Relays_8to1
5804  0044               _Relays_16to9:
5805  0044 00            	ds.b	1
5806                     	xdef	_Relays_16to9
5807  0045               _Port_Httpd:
5808  0045 0000          	ds.b	2
5809                     	xdef	_Port_Httpd
5810                     .eeprom:	section	.data
5811  0000               _stored_devicename:
5812  0000 000000000000  	ds.b	20
5813                     	xdef	_stored_devicename
5814  0014               _stored_invert_output:
5815  0014 00            	ds.b	1
5816                     	xdef	_stored_invert_output
5817  0015               _stored_Relays_8to1:
5818  0015 00            	ds.b	1
5819                     	xdef	_stored_Relays_8to1
5820  0016               _stored_Relays_16to9:
5821  0016 00            	ds.b	1
5822                     	xdef	_stored_Relays_16to9
5823  0017               _stored_uip_ethaddr6:
5824  0017 00            	ds.b	1
5825                     	xdef	_stored_uip_ethaddr6
5826  0018               _stored_uip_ethaddr5:
5827  0018 00            	ds.b	1
5828                     	xdef	_stored_uip_ethaddr5
5829  0019               _stored_uip_ethaddr4:
5830  0019 00            	ds.b	1
5831                     	xdef	_stored_uip_ethaddr4
5832  001a               _stored_uip_ethaddr3:
5833  001a 00            	ds.b	1
5834                     	xdef	_stored_uip_ethaddr3
5835  001b               _stored_uip_ethaddr2:
5836  001b 00            	ds.b	1
5837                     	xdef	_stored_uip_ethaddr2
5838  001c               _stored_uip_ethaddr1:
5839  001c 00            	ds.b	1
5840                     	xdef	_stored_uip_ethaddr1
5841  001d               _stored_port:
5842  001d 0000          	ds.b	2
5843                     	xdef	_stored_port
5844  001f               _stored_netmask1:
5845  001f 00            	ds.b	1
5846                     	xdef	_stored_netmask1
5847  0020               _stored_netmask2:
5848  0020 00            	ds.b	1
5849                     	xdef	_stored_netmask2
5850  0021               _stored_netmask3:
5851  0021 00            	ds.b	1
5852                     	xdef	_stored_netmask3
5853  0022               _stored_netmask4:
5854  0022 00            	ds.b	1
5855                     	xdef	_stored_netmask4
5856  0023               _stored_draddr1:
5857  0023 00            	ds.b	1
5858                     	xdef	_stored_draddr1
5859  0024               _stored_draddr2:
5860  0024 00            	ds.b	1
5861                     	xdef	_stored_draddr2
5862  0025               _stored_draddr3:
5863  0025 00            	ds.b	1
5864                     	xdef	_stored_draddr3
5865  0026               _stored_draddr4:
5866  0026 00            	ds.b	1
5867                     	xdef	_stored_draddr4
5868  0027               _stored_hostaddr1:
5869  0027 00            	ds.b	1
5870                     	xdef	_stored_hostaddr1
5871  0028               _stored_hostaddr2:
5872  0028 00            	ds.b	1
5873                     	xdef	_stored_hostaddr2
5874  0029               _stored_hostaddr3:
5875  0029 00            	ds.b	1
5876                     	xdef	_stored_hostaddr3
5877  002a               _stored_hostaddr4:
5878  002a 00            	ds.b	1
5879                     	xdef	_stored_hostaddr4
5880  002b               _magic1:
5881  002b 00            	ds.b	1
5882                     	xdef	_magic1
5883  002c               _magic2:
5884  002c 00            	ds.b	1
5885                     	xdef	_magic2
5886  002d               _magic3:
5887  002d 00            	ds.b	1
5888                     	xdef	_magic3
5889  002e               _magic4:
5890  002e 00            	ds.b	1
5891                     	xdef	_magic4
5892                     	xref	_wait_timer
5893                     	xref	_arp_timer_expired
5894                     	xref	_periodic_timer_expired
5895                     	xref	_clock_init
5896                     	xref	_LEDcontrol
5897                     	xref	_gpio_init
5898                     	xref	_uip_arp_timer
5899                     	xref	_uip_arp_out
5900                     	xref	_uip_arp_arpin
5901                     	xref	_uip_arp_init
5902                     	xref	_uip_ethaddr
5903                     	xref	_uip_draddr
5904                     	xref	_uip_netmask
5905                     	xref	_uip_hostaddr
5906                     	xref	_uip_process
5907                     	xref	_uip_conns
5908                     	xref	_uip_conn
5909                     	xref	_uip_len
5910                     	xref	_htons
5911                     	xref	_uip_buf
5912                     	xref	_uip_init
5913                     	xref	_HttpDInit
5914                     	xref	_Enc28j60Send
5915                     	xref	_Enc28j60CopyPacket
5916                     	xref	_Enc28j60Receive
5917                     	xref	_Enc28j60Init
5918                     	xref	_spi_init
5919                     	xdef	_debugflash
5920                     	xdef	_check_reset_button
5921                     	xdef	_update_relay_control_registers
5922                     	xdef	_check_runtime_changes
5923                     	xdef	_check_eeprom_settings
5924                     	xdef	_unlock_eeprom
5925                     	xdef	_main
5926                     	xref.b	c_x
5946                     	xref	c_eewrw
5947                     	xref	c_eewrc
5948                     	xref	c_bmulx
5949                     	end
