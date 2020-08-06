   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
2581                     ; 164 main(void)
2581                     ; 165 {
2583                     	switch	.text
2584  0000               _main:
2586  0000 89            	pushw	x
2587       00000002      OFST:	set	2
2590                     ; 169   devicename_changed = 0;
2592  0001 725f0006      	clr	_devicename_changed
2593                     ; 170   submit_changes = 0;
2595  0005 725f0007      	clr	_submit_changes
2596                     ; 172   clock_init();            // Initialize and enable clocks and timers
2598  0009 cd0000        	call	_clock_init
2600                     ; 174   gpio_init();             // Initialize and enable gpio pins
2602  000c cd0000        	call	_gpio_init
2604                     ; 176   spi_init();              // Initialize the SPI bit bang interface to the
2606  000f cd0000        	call	_spi_init
2608                     ; 179   LEDcontrol(1);           // turn LED on
2610  0012 a601          	ld	a,#1
2611  0014 cd0000        	call	_LEDcontrol
2613                     ; 181   unlock_eeprom();         // unlock the EEPROM so writes can be performed
2615  0017 cd00ba        	call	_unlock_eeprom
2617                     ; 183   check_eeprom_settings(); // Check the EEPROM for previously stored Address
2619  001a cd00ca        	call	_check_eeprom_settings
2621                     ; 187   Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
2623  001d cd0000        	call	_Enc28j60Init
2625                     ; 189   uip_arp_init();          // Initialize the ARP module
2627  0020 cd0000        	call	_uip_arp_init
2629                     ; 191   uip_init();              // Initialize uIP Web Server
2631  0023 cd0000        	call	_uip_init
2633                     ; 193   HttpDInit();             // Initialize listening ports
2635  0026 cd0000        	call	_HttpDInit
2637  0029               L1561:
2638                     ; 196     uip_len = Enc28j60Receive(uip_buf); // Check for incoming packets
2640  0029 ae0000        	ldw	x,#_uip_buf
2641  002c cd0000        	call	_Enc28j60Receive
2643  002f cf0000        	ldw	_uip_len,x
2644                     ; 198     if (uip_len> 0) {
2646  0032 273b          	jreq	L5561
2647                     ; 199       if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_IP)) {
2649  0034 ae0800        	ldw	x,#2048
2650  0037 cd0000        	call	_htons
2652  003a c3000c        	cpw	x,_uip_buf+12
2653  003d 2612          	jrne	L7561
2654                     ; 201 	uip_input(); // Calls uip_process(UIP_DATA) to process incoming packet
2656  003f a601          	ld	a,#1
2657  0041 cd0000        	call	_uip_process
2659                     ; 204         if (uip_len> 0) {
2661  0044 ce0000        	ldw	x,_uip_len
2662  0047 2726          	jreq	L5561
2663                     ; 205           uip_arp_out();
2665  0049 cd0000        	call	_uip_arp_out
2667                     ; 209           Enc28j60CopyPacket(uip_buf, uip_len);
2669  004c ce0000        	ldw	x,_uip_len
2671                     ; 210           Enc28j60Send();
2673  004f 2013          	jp	LC001
2674  0051               L7561:
2675                     ; 213       else if (((struct uip_eth_hdr *) & uip_buf[0])->type == htons(UIP_ETHTYPE_ARP)) {
2677  0051 ae0806        	ldw	x,#2054
2678  0054 cd0000        	call	_htons
2680  0057 c3000c        	cpw	x,_uip_buf+12
2681  005a 2613          	jrne	L5561
2682                     ; 214         uip_arp_arpin();
2684  005c cd0000        	call	_uip_arp_arpin
2686                     ; 217         if (uip_len> 0) {
2688  005f ce0000        	ldw	x,_uip_len
2689  0062 270b          	jreq	L5561
2690                     ; 221           Enc28j60CopyPacket(uip_buf, uip_len);
2693                     ; 222           Enc28j60Send();
2695  0064               LC001:
2696  0064 89            	pushw	x
2697  0065 ae0000        	ldw	x,#_uip_buf
2698  0068 cd0000        	call	_Enc28j60CopyPacket
2699  006b 85            	popw	x
2701  006c cd0000        	call	_Enc28j60Send
2703  006f               L5561:
2704                     ; 227     if (periodic_timer_expired()) {
2706  006f cd0000        	call	_periodic_timer_expired
2708  0072 4d            	tnz	a
2709  0073 2733          	jreq	L1761
2710                     ; 228       for(i = 0; i < UIP_CONNS; i++) {
2712  0075 5f            	clrw	x
2713  0076 1f01          	ldw	(OFST-1,sp),x
2715  0078               L1071:
2716                     ; 229 	uip_periodic(i);
2718  0078 a628          	ld	a,#40
2719  007a cd0000        	call	c_bmulx
2721  007d 1c0000        	addw	x,#_uip_conns
2722  0080 cf0000        	ldw	_uip_conn,x
2725  0083 a602          	ld	a,#2
2726  0085 cd0000        	call	_uip_process
2728                     ; 232 	if (uip_len > 0) {
2730  0088 ce0000        	ldw	x,_uip_len
2731  008b 2711          	jreq	L5071
2732                     ; 233 	  uip_arp_out();
2734  008d cd0000        	call	_uip_arp_out
2736                     ; 237           Enc28j60CopyPacket(uip_buf, uip_len);
2738  0090 ce0000        	ldw	x,_uip_len
2739  0093 89            	pushw	x
2740  0094 ae0000        	ldw	x,#_uip_buf
2741  0097 cd0000        	call	_Enc28j60CopyPacket
2743  009a 85            	popw	x
2744                     ; 238           Enc28j60Send();
2746  009b cd0000        	call	_Enc28j60Send
2748  009e               L5071:
2749                     ; 228       for(i = 0; i < UIP_CONNS; i++) {
2751  009e 1e01          	ldw	x,(OFST-1,sp)
2752  00a0 5c            	incw	x
2753  00a1 1f01          	ldw	(OFST-1,sp),x
2757  00a3 a30006        	cpw	x,#6
2758  00a6 2fd0          	jrslt	L1071
2759  00a8               L1761:
2760                     ; 244     if (arp_timer_expired()) uip_arp_timer();
2762  00a8 cd0000        	call	_arp_timer_expired
2764  00ab 4d            	tnz	a
2765  00ac 2703          	jreq	L7071
2768  00ae cd0000        	call	_uip_arp_timer
2770  00b1               L7071:
2771                     ; 248     check_runtime_changes();
2773  00b1 cd0449        	call	_check_runtime_changes
2775                     ; 251     check_reset_button();
2777  00b4 cd0713        	call	_check_reset_button
2780  00b7 cc0029        	jra	L1561
2805                     ; 276 void unlock_eeprom(void)
2805                     ; 277 {
2806                     	switch	.text
2807  00ba               _unlock_eeprom:
2811  00ba 2008          	jra	L3271
2812  00bc               L1271:
2813                     ; 286     FLASH_DUKR = 0xAE; // MASS key 1
2815  00bc 35ae5064      	mov	_FLASH_DUKR,#174
2816                     ; 287     FLASH_DUKR = 0x56; // MASS key 2
2818  00c0 35565064      	mov	_FLASH_DUKR,#86
2819  00c4               L3271:
2820                     ; 285   while (!(FLASH_IAPSR & 0x08)) {  // Check DUL bit, 0=Protected
2822  00c4 7207505ff3    	btjf	_FLASH_IAPSR,#3,L1271
2823                     ; 289 }
2826  00c9 81            	ret	
2931                     ; 292 void check_eeprom_settings(void)
2931                     ; 293 {
2932                     	switch	.text
2933  00ca               _check_eeprom_settings:
2935  00ca 88            	push	a
2936       00000001      OFST:	set	1
2939                     ; 305   if ((magic4 == 0x55) && 
2939                     ; 306       (magic3 == 0xee) && 
2939                     ; 307       (magic2 == 0x0f) && 
2939                     ; 308       (magic1 == 0xf0) == 1) {
2941  00cb c6002e        	ld	a,_magic4
2942  00ce a155          	cp	a,#85
2943  00d0 2703cc01b0    	jrne	L5002
2945  00d5 c6002d        	ld	a,_magic3
2946  00d8 a1ee          	cp	a,#238
2947  00da 26f6          	jrne	L5002
2949  00dc c6002c        	ld	a,_magic2
2950  00df a10f          	cp	a,#15
2951  00e1 26ef          	jrne	L5002
2953  00e3 c6002b        	ld	a,_magic1
2954  00e6 a1f0          	cp	a,#240
2955  00e8 26e8          	jrne	L5002
2956                     ; 313     uip_ipaddr(IpAddr, stored_hostaddr4, stored_hostaddr3, stored_hostaddr2, stored_hostaddr1);
2958  00ea c6002a        	ld	a,_stored_hostaddr4
2959  00ed 97            	ld	xl,a
2960  00ee c60029        	ld	a,_stored_hostaddr3
2961  00f1 02            	rlwa	x,a
2962  00f2 cf0000        	ldw	_IpAddr,x
2965  00f5 c60028        	ld	a,_stored_hostaddr2
2966  00f8 97            	ld	xl,a
2967  00f9 c60027        	ld	a,_stored_hostaddr1
2968  00fc 02            	rlwa	x,a
2969  00fd cf0002        	ldw	_IpAddr+2,x
2970                     ; 314     uip_sethostaddr(IpAddr);
2972  0100 ce0000        	ldw	x,_IpAddr
2973  0103 cf0000        	ldw	_uip_hostaddr,x
2976  0106 ce0002        	ldw	x,_IpAddr+2
2977  0109 cf0002        	ldw	_uip_hostaddr+2,x
2978                     ; 317     uip_ipaddr(IpAddr, stored_draddr4, stored_draddr3, stored_draddr2, stored_draddr1);
2980  010c c60026        	ld	a,_stored_draddr4
2981  010f 97            	ld	xl,a
2982  0110 c60025        	ld	a,_stored_draddr3
2983  0113 02            	rlwa	x,a
2984  0114 cf0000        	ldw	_IpAddr,x
2987  0117 c60024        	ld	a,_stored_draddr2
2988  011a 97            	ld	xl,a
2989  011b c60023        	ld	a,_stored_draddr1
2990  011e 02            	rlwa	x,a
2991  011f cf0002        	ldw	_IpAddr+2,x
2992                     ; 318     uip_setdraddr(IpAddr);
2994  0122 ce0000        	ldw	x,_IpAddr
2995  0125 cf0000        	ldw	_uip_draddr,x
2998  0128 ce0002        	ldw	x,_IpAddr+2
2999  012b cf0002        	ldw	_uip_draddr+2,x
3000                     ; 321     uip_ipaddr(IpAddr, stored_netmask4, stored_netmask3, stored_netmask2, stored_netmask1);
3002  012e c60022        	ld	a,_stored_netmask4
3003  0131 97            	ld	xl,a
3004  0132 c60021        	ld	a,_stored_netmask3
3005  0135 02            	rlwa	x,a
3006  0136 cf0000        	ldw	_IpAddr,x
3009  0139 c60020        	ld	a,_stored_netmask2
3010  013c 97            	ld	xl,a
3011  013d c6001f        	ld	a,_stored_netmask1
3012  0140 02            	rlwa	x,a
3013  0141 cf0002        	ldw	_IpAddr+2,x
3014                     ; 322     uip_setnetmask(IpAddr);
3016  0144 ce0000        	ldw	x,_IpAddr
3017  0147 cf0000        	ldw	_uip_netmask,x
3020  014a ce0002        	ldw	x,_IpAddr+2
3021  014d cf0002        	ldw	_uip_netmask+2,x
3022                     ; 325     Port_Httpd = stored_port;
3024  0150 ce001d        	ldw	x,_stored_port
3025  0153 cf0004        	ldw	_Port_Httpd,x
3026                     ; 328     uip_ethaddr6 = stored_uip_ethaddr6;
3028  0156 550017000d    	mov	_uip_ethaddr6,_stored_uip_ethaddr6
3029                     ; 329     uip_ethaddr5 = stored_uip_ethaddr5;
3031  015b 550018000c    	mov	_uip_ethaddr5,_stored_uip_ethaddr5
3032                     ; 330     uip_ethaddr4 = stored_uip_ethaddr4;
3034  0160 550019000b    	mov	_uip_ethaddr4,_stored_uip_ethaddr4
3035                     ; 331     uip_ethaddr3 = stored_uip_ethaddr3;
3037  0165 55001a000a    	mov	_uip_ethaddr3,_stored_uip_ethaddr3
3038                     ; 332     uip_ethaddr2 = stored_uip_ethaddr2;
3040  016a 55001b0009    	mov	_uip_ethaddr2,_stored_uip_ethaddr2
3041                     ; 333     uip_ethaddr1 = stored_uip_ethaddr1;
3043  016f 55001c0008    	mov	_uip_ethaddr1,_stored_uip_ethaddr1
3044                     ; 335     uip_ethaddr.addr[0] = uip_ethaddr1;
3046  0174 5500080000    	mov	_uip_ethaddr,_uip_ethaddr1
3047                     ; 336     uip_ethaddr.addr[1] = uip_ethaddr2;
3049  0179 5500090001    	mov	_uip_ethaddr+1,_uip_ethaddr2
3050                     ; 337     uip_ethaddr.addr[2] = uip_ethaddr3;
3052  017e 55000a0002    	mov	_uip_ethaddr+2,_uip_ethaddr3
3053                     ; 338     uip_ethaddr.addr[3] = uip_ethaddr4;
3055  0183 55000b0003    	mov	_uip_ethaddr+3,_uip_ethaddr4
3056                     ; 339     uip_ethaddr.addr[4] = uip_ethaddr5;
3058  0188 55000c0004    	mov	_uip_ethaddr+4,_uip_ethaddr5
3059                     ; 340     uip_ethaddr.addr[5] = uip_ethaddr6;
3061                     ; 343     for(i=0; i<20; i++) { ex_stored_devicename[i] = stored_devicename[i]; }
3063  018d 4f            	clr	a
3064  018e 55000d0005    	mov	_uip_ethaddr+5,_uip_ethaddr6
3065  0193 6b01          	ld	(OFST+0,sp),a
3067  0195               L5771:
3070  0195 5f            	clrw	x
3071  0196 97            	ld	xl,a
3072  0197 d60000        	ld	a,(_stored_devicename,x)
3073  019a d70022        	ld	(_ex_stored_devicename,x),a
3076  019d 0c01          	inc	(OFST+0,sp)
3080  019f 7b01          	ld	a,(OFST+0,sp)
3081  01a1 a114          	cp	a,#20
3082  01a3 25f0          	jrult	L5771
3083                     ; 346     invert_output = stored_invert_output;
3085  01a5 5500140036    	mov	_invert_output,_stored_invert_output
3086                     ; 358     write_output_registers();
3088  01aa cd0712        	call	_write_output_registers
3091  01ad cc0395        	jra	L3002
3092  01b0               L5002:
3093                     ; 367     uip_ipaddr(IpAddr, 192,168,1,4);
3095  01b0 aec0a8        	ldw	x,#49320
3096  01b3 cf0000        	ldw	_IpAddr,x
3099  01b6 ae0104        	ldw	x,#260
3100  01b9 cf0002        	ldw	_IpAddr+2,x
3101                     ; 368     uip_sethostaddr(IpAddr);
3103  01bc ce0000        	ldw	x,_IpAddr
3104  01bf cf0000        	ldw	_uip_hostaddr,x
3107  01c2 ce0002        	ldw	x,_IpAddr+2
3108  01c5 cf0002        	ldw	_uip_hostaddr+2,x
3109                     ; 370     stored_hostaddr4 = 192;	// MSB
3111  01c8 a6c0          	ld	a,#192
3112  01ca ae002a        	ldw	x,#_stored_hostaddr4
3113  01cd cd0000        	call	c_eewrc
3115                     ; 371     stored_hostaddr3 = 168;	//
3117  01d0 a6a8          	ld	a,#168
3118  01d2 ae0029        	ldw	x,#_stored_hostaddr3
3119  01d5 cd0000        	call	c_eewrc
3121                     ; 372     stored_hostaddr2 = 1;	//
3123  01d8 a601          	ld	a,#1
3124  01da ae0028        	ldw	x,#_stored_hostaddr2
3125  01dd cd0000        	call	c_eewrc
3127                     ; 373     stored_hostaddr1 = 4;	// LSB
3129  01e0 a604          	ld	a,#4
3130  01e2 ae0027        	ldw	x,#_stored_hostaddr1
3131  01e5 cd0000        	call	c_eewrc
3133                     ; 376     uip_ipaddr(IpAddr, 192,168,1,1);
3135  01e8 aec0a8        	ldw	x,#49320
3136  01eb cf0000        	ldw	_IpAddr,x
3139  01ee ae0101        	ldw	x,#257
3140  01f1 cf0002        	ldw	_IpAddr+2,x
3141                     ; 377     uip_setdraddr(IpAddr);
3143  01f4 ce0000        	ldw	x,_IpAddr
3144  01f7 cf0000        	ldw	_uip_draddr,x
3147  01fa ce0002        	ldw	x,_IpAddr+2
3148  01fd cf0002        	ldw	_uip_draddr+2,x
3149                     ; 379     stored_draddr4 = 192;	// MSB
3151  0200 a6c0          	ld	a,#192
3152  0202 ae0026        	ldw	x,#_stored_draddr4
3153  0205 cd0000        	call	c_eewrc
3155                     ; 380     stored_draddr3 = 168;	//
3157  0208 a6a8          	ld	a,#168
3158  020a ae0025        	ldw	x,#_stored_draddr3
3159  020d cd0000        	call	c_eewrc
3161                     ; 381     stored_draddr2 = 1;		//
3163  0210 a601          	ld	a,#1
3164  0212 ae0024        	ldw	x,#_stored_draddr2
3165  0215 cd0000        	call	c_eewrc
3167                     ; 382     stored_draddr1 = 1;		// LSB
3169  0218 a601          	ld	a,#1
3170  021a ae0023        	ldw	x,#_stored_draddr1
3171  021d cd0000        	call	c_eewrc
3173                     ; 385     uip_ipaddr(IpAddr, 255,255,255,0);
3175  0220 aeffff        	ldw	x,#65535
3176  0223 cf0000        	ldw	_IpAddr,x
3179  0226 aeff00        	ldw	x,#65280
3180  0229 cf0002        	ldw	_IpAddr+2,x
3181                     ; 386     uip_setnetmask(IpAddr);
3183  022c ce0000        	ldw	x,_IpAddr
3184  022f cf0000        	ldw	_uip_netmask,x
3187  0232 ce0002        	ldw	x,_IpAddr+2
3188  0235 cf0002        	ldw	_uip_netmask+2,x
3189                     ; 388     stored_netmask4 = 255;	// MSB
3191  0238 a6ff          	ld	a,#255
3192  023a ae0022        	ldw	x,#_stored_netmask4
3193  023d cd0000        	call	c_eewrc
3195                     ; 389     stored_netmask3 = 255;	//
3197  0240 a6ff          	ld	a,#255
3198  0242 ae0021        	ldw	x,#_stored_netmask3
3199  0245 cd0000        	call	c_eewrc
3201                     ; 390     stored_netmask2 = 255;	//
3203  0248 a6ff          	ld	a,#255
3204  024a ae0020        	ldw	x,#_stored_netmask2
3205  024d cd0000        	call	c_eewrc
3207                     ; 391     stored_netmask1 = 0;	// LSB
3209  0250 4f            	clr	a
3210  0251 ae001f        	ldw	x,#_stored_netmask1
3211  0254 cd0000        	call	c_eewrc
3213                     ; 394     stored_port = 8080;		// Port
3215  0257 ae1f90        	ldw	x,#8080
3216  025a 89            	pushw	x
3217  025b ae001d        	ldw	x,#_stored_port
3218  025e cd0000        	call	c_eewrw
3220  0261 85            	popw	x
3221                     ; 396     Port_Httpd = 8080;
3223  0262 ae1f90        	ldw	x,#8080
3224  0265 cf0004        	ldw	_Port_Httpd,x
3225                     ; 409     stored_uip_ethaddr1 = 0xc2;	//MAC MSB
3227  0268 a6c2          	ld	a,#194
3228  026a ae001c        	ldw	x,#_stored_uip_ethaddr1
3229  026d cd0000        	call	c_eewrc
3231                     ; 410     stored_uip_ethaddr2 = 0x4d;
3233  0270 a64d          	ld	a,#77
3234  0272 ae001b        	ldw	x,#_stored_uip_ethaddr2
3235  0275 cd0000        	call	c_eewrc
3237                     ; 411     stored_uip_ethaddr3 = 0x69;
3239  0278 a669          	ld	a,#105
3240  027a ae001a        	ldw	x,#_stored_uip_ethaddr3
3241  027d cd0000        	call	c_eewrc
3243                     ; 412     stored_uip_ethaddr4 = 0x6b;
3245  0280 a66b          	ld	a,#107
3246  0282 ae0019        	ldw	x,#_stored_uip_ethaddr4
3247  0285 cd0000        	call	c_eewrc
3249                     ; 413     stored_uip_ethaddr5 = 0x65;
3251  0288 a665          	ld	a,#101
3252  028a ae0018        	ldw	x,#_stored_uip_ethaddr5
3253  028d cd0000        	call	c_eewrc
3255                     ; 414     stored_uip_ethaddr6 = 0x00;	//MAC LSB
3257  0290 4f            	clr	a
3258  0291 ae0017        	ldw	x,#_stored_uip_ethaddr6
3259  0294 cd0000        	call	c_eewrc
3261                     ; 416     uip_ethaddr1 = stored_uip_ethaddr1;	//MAC MSB
3263  0297 35c20008      	mov	_uip_ethaddr1,#194
3264                     ; 417     uip_ethaddr2 = stored_uip_ethaddr2;
3266  029b 354d0009      	mov	_uip_ethaddr2,#77
3267                     ; 418     uip_ethaddr3 = stored_uip_ethaddr3;
3269  029f 3569000a      	mov	_uip_ethaddr3,#105
3270                     ; 419     uip_ethaddr4 = stored_uip_ethaddr4;
3272  02a3 356b000b      	mov	_uip_ethaddr4,#107
3273                     ; 420     uip_ethaddr5 = stored_uip_ethaddr5;
3275  02a7 3565000c      	mov	_uip_ethaddr5,#101
3276                     ; 421     uip_ethaddr6 = stored_uip_ethaddr6;	//MAC LSB
3278  02ab 725f000d      	clr	_uip_ethaddr6
3279                     ; 423     uip_ethaddr.addr[0] = uip_ethaddr1;
3281  02af 35c20000      	mov	_uip_ethaddr,#194
3282                     ; 424     uip_ethaddr.addr[1] = uip_ethaddr2;
3284  02b3 354d0001      	mov	_uip_ethaddr+1,#77
3285                     ; 425     uip_ethaddr.addr[2] = uip_ethaddr3;
3287  02b7 35690002      	mov	_uip_ethaddr+2,#105
3288                     ; 426     uip_ethaddr.addr[3] = uip_ethaddr4;
3290  02bb 356b0003      	mov	_uip_ethaddr+3,#107
3291                     ; 427     uip_ethaddr.addr[4] = uip_ethaddr5;
3293  02bf 35650004      	mov	_uip_ethaddr+4,#101
3294                     ; 428     uip_ethaddr.addr[5] = uip_ethaddr6;
3296  02c3 725f0005      	clr	_uip_ethaddr+5
3297                     ; 430     stored_devicename[0] = 'N' ; // Device name first character
3299  02c7 a64e          	ld	a,#78
3300  02c9 ae0000        	ldw	x,#_stored_devicename
3301  02cc cd0000        	call	c_eewrc
3303                     ; 431     stored_devicename[1] = 'e' ; //
3305  02cf a665          	ld	a,#101
3306  02d1 ae0001        	ldw	x,#_stored_devicename+1
3307  02d4 cd0000        	call	c_eewrc
3309                     ; 432     stored_devicename[2] = 'w' ; //
3311  02d7 a677          	ld	a,#119
3312  02d9 ae0002        	ldw	x,#_stored_devicename+2
3313  02dc cd0000        	call	c_eewrc
3315                     ; 433     stored_devicename[3] = 'D' ; //
3317  02df a644          	ld	a,#68
3318  02e1 ae0003        	ldw	x,#_stored_devicename+3
3319  02e4 cd0000        	call	c_eewrc
3321                     ; 434     stored_devicename[4] = 'e' ; //
3323  02e7 a665          	ld	a,#101
3324  02e9 ae0004        	ldw	x,#_stored_devicename+4
3325  02ec cd0000        	call	c_eewrc
3327                     ; 435     stored_devicename[5] = 'v' ; //
3329  02ef a676          	ld	a,#118
3330  02f1 ae0005        	ldw	x,#_stored_devicename+5
3331  02f4 cd0000        	call	c_eewrc
3333                     ; 436     stored_devicename[6] = 'i' ; //
3335  02f7 a669          	ld	a,#105
3336  02f9 ae0006        	ldw	x,#_stored_devicename+6
3337  02fc cd0000        	call	c_eewrc
3339                     ; 437     stored_devicename[7] = 'c' ; //
3341  02ff a663          	ld	a,#99
3342  0301 ae0007        	ldw	x,#_stored_devicename+7
3343  0304 cd0000        	call	c_eewrc
3345                     ; 438     stored_devicename[8] = 'e' ; //
3347  0307 a665          	ld	a,#101
3348  0309 ae0008        	ldw	x,#_stored_devicename+8
3349  030c cd0000        	call	c_eewrc
3351                     ; 439     stored_devicename[9] = '0' ; //
3353  030f a630          	ld	a,#48
3354  0311 ae0009        	ldw	x,#_stored_devicename+9
3355  0314 cd0000        	call	c_eewrc
3357                     ; 440     stored_devicename[10] = '0' ; //
3359  0317 a630          	ld	a,#48
3360  0319 ae000a        	ldw	x,#_stored_devicename+10
3361  031c cd0000        	call	c_eewrc
3363                     ; 441     stored_devicename[11] = '0' ; //
3365  031f a630          	ld	a,#48
3366  0321 ae000b        	ldw	x,#_stored_devicename+11
3367  0324 cd0000        	call	c_eewrc
3369                     ; 442     stored_devicename[12] = ' ' ; //
3371  0327 a620          	ld	a,#32
3372  0329 ae000c        	ldw	x,#_stored_devicename+12
3373  032c cd0000        	call	c_eewrc
3375                     ; 443     stored_devicename[13] = ' ' ; //
3377  032f a620          	ld	a,#32
3378  0331 ae000d        	ldw	x,#_stored_devicename+13
3379  0334 cd0000        	call	c_eewrc
3381                     ; 444     stored_devicename[14] = ' ' ; //
3383  0337 a620          	ld	a,#32
3384  0339 ae000e        	ldw	x,#_stored_devicename+14
3385  033c cd0000        	call	c_eewrc
3387                     ; 445     stored_devicename[15] = ' ' ; //
3389  033f a620          	ld	a,#32
3390  0341 ae000f        	ldw	x,#_stored_devicename+15
3391  0344 cd0000        	call	c_eewrc
3393                     ; 446     stored_devicename[16] = ' ' ; //
3395  0347 a620          	ld	a,#32
3396  0349 ae0010        	ldw	x,#_stored_devicename+16
3397  034c cd0000        	call	c_eewrc
3399                     ; 447     stored_devicename[17] = ' ' ; //
3401  034f a620          	ld	a,#32
3402  0351 ae0011        	ldw	x,#_stored_devicename+17
3403  0354 cd0000        	call	c_eewrc
3405                     ; 448     stored_devicename[18] = ' ' ; //
3407  0357 a620          	ld	a,#32
3408  0359 ae0012        	ldw	x,#_stored_devicename+18
3409  035c cd0000        	call	c_eewrc
3411                     ; 449     stored_devicename[19] = ' ' ; // Device name last character
3413  035f a620          	ld	a,#32
3414  0361 ae0013        	ldw	x,#_stored_devicename+19
3415  0364 cd0000        	call	c_eewrc
3417                     ; 452     invert_output = 0;                  // Turn off output invert bit
3419  0367 725f0036      	clr	_invert_output
3420                     ; 453     stored_invert_output = 0;           // Store in EEPROM
3422  036b 4f            	clr	a
3423  036c ae0014        	ldw	x,#_stored_invert_output
3424  036f cd0000        	call	c_eewrc
3426                     ; 467     write_output_registers();          // Set Relay Control outputs
3428  0372 cd0712        	call	_write_output_registers
3430                     ; 470     magic4 = 0x55;		// MSB
3432  0375 a655          	ld	a,#85
3433  0377 ae002e        	ldw	x,#_magic4
3434  037a cd0000        	call	c_eewrc
3436                     ; 471     magic3 = 0xee;		//
3438  037d a6ee          	ld	a,#238
3439  037f ae002d        	ldw	x,#_magic3
3440  0382 cd0000        	call	c_eewrc
3442                     ; 472     magic2 = 0x0f;		//
3444  0385 a60f          	ld	a,#15
3445  0387 ae002c        	ldw	x,#_magic2
3446  038a cd0000        	call	c_eewrc
3448                     ; 473     magic1 = 0xf0;		// LSB
3450  038d a6f0          	ld	a,#240
3451  038f ae002b        	ldw	x,#_magic1
3452  0392 cd0000        	call	c_eewrc
3454  0395               L3002:
3455                     ; 478   Pending_hostaddr4 = stored_hostaddr4;
3457  0395 55002a0021    	mov	_Pending_hostaddr4,_stored_hostaddr4
3458                     ; 479   Pending_hostaddr3 = stored_hostaddr3;
3460  039a 5500290020    	mov	_Pending_hostaddr3,_stored_hostaddr3
3461                     ; 480   Pending_hostaddr2 = stored_hostaddr2;
3463  039f 550028001f    	mov	_Pending_hostaddr2,_stored_hostaddr2
3464                     ; 481   Pending_hostaddr1 = stored_hostaddr1;
3466  03a4 550027001e    	mov	_Pending_hostaddr1,_stored_hostaddr1
3467                     ; 483   Pending_draddr4 = stored_draddr4;
3469  03a9 550026001d    	mov	_Pending_draddr4,_stored_draddr4
3470                     ; 484   Pending_draddr3 = stored_draddr3;
3472  03ae 550025001c    	mov	_Pending_draddr3,_stored_draddr3
3473                     ; 485   Pending_draddr2 = stored_draddr2;
3475  03b3 550024001b    	mov	_Pending_draddr2,_stored_draddr2
3476                     ; 486   Pending_draddr1 = stored_draddr1;
3478  03b8 550023001a    	mov	_Pending_draddr1,_stored_draddr1
3479                     ; 488   Pending_netmask4 = stored_netmask4;
3481  03bd 5500220019    	mov	_Pending_netmask4,_stored_netmask4
3482                     ; 489   Pending_netmask3 = stored_netmask3;
3484  03c2 5500210018    	mov	_Pending_netmask3,_stored_netmask3
3485                     ; 490   Pending_netmask2 = stored_netmask2;
3487  03c7 5500200017    	mov	_Pending_netmask2,_stored_netmask2
3488                     ; 491   Pending_netmask1 = stored_netmask1;
3490  03cc 55001f0016    	mov	_Pending_netmask1,_stored_netmask1
3491                     ; 493   Pending_port = stored_port;
3493  03d1 ce001d        	ldw	x,_stored_port
3494  03d4 cf0014        	ldw	_Pending_port,x
3495                     ; 495   Pending_uip_ethaddr6 = stored_uip_ethaddr6;
3497  03d7 5500170013    	mov	_Pending_uip_ethaddr6,_stored_uip_ethaddr6
3498                     ; 496   Pending_uip_ethaddr5 = stored_uip_ethaddr5;
3500  03dc 5500180012    	mov	_Pending_uip_ethaddr5,_stored_uip_ethaddr5
3501                     ; 497   Pending_uip_ethaddr4 = stored_uip_ethaddr4;
3503  03e1 5500190011    	mov	_Pending_uip_ethaddr4,_stored_uip_ethaddr4
3504                     ; 498   Pending_uip_ethaddr3 = stored_uip_ethaddr3;
3506  03e6 55001a0010    	mov	_Pending_uip_ethaddr3,_stored_uip_ethaddr3
3507                     ; 499   Pending_uip_ethaddr2 = stored_uip_ethaddr2;
3509  03eb 55001b000f    	mov	_Pending_uip_ethaddr2,_stored_uip_ethaddr2
3510                     ; 500   Pending_uip_ethaddr1 = stored_uip_ethaddr1;
3512  03f0 55001c000e    	mov	_Pending_uip_ethaddr1,_stored_uip_ethaddr1
3513                     ; 503   ex_stored_hostaddr4 = stored_hostaddr4;
3515  03f5 55002a0046    	mov	_ex_stored_hostaddr4,_stored_hostaddr4
3516                     ; 504   ex_stored_hostaddr3 = stored_hostaddr3;
3518  03fa 5500290045    	mov	_ex_stored_hostaddr3,_stored_hostaddr3
3519                     ; 505   ex_stored_hostaddr2 = stored_hostaddr2;
3521  03ff 5500280044    	mov	_ex_stored_hostaddr2,_stored_hostaddr2
3522                     ; 506   ex_stored_hostaddr1 = stored_hostaddr1;
3524  0404 5500270043    	mov	_ex_stored_hostaddr1,_stored_hostaddr1
3525                     ; 508   ex_stored_draddr4 = stored_draddr4;
3527  0409 5500260042    	mov	_ex_stored_draddr4,_stored_draddr4
3528                     ; 509   ex_stored_draddr3 = stored_draddr3;
3530  040e 5500250041    	mov	_ex_stored_draddr3,_stored_draddr3
3531                     ; 510   ex_stored_draddr2 = stored_draddr2;
3533  0413 5500240040    	mov	_ex_stored_draddr2,_stored_draddr2
3534                     ; 511   ex_stored_draddr1 = stored_draddr1;
3536  0418 550023003f    	mov	_ex_stored_draddr1,_stored_draddr1
3537                     ; 513   ex_stored_netmask4 = stored_netmask4;
3539  041d 550022003e    	mov	_ex_stored_netmask4,_stored_netmask4
3540                     ; 514   ex_stored_netmask3 = stored_netmask3;
3542  0422 550021003d    	mov	_ex_stored_netmask3,_stored_netmask3
3543                     ; 515   ex_stored_netmask2 = stored_netmask2;
3545  0427 550020003c    	mov	_ex_stored_netmask2,_stored_netmask2
3546                     ; 516   ex_stored_netmask1 = stored_netmask1;
3548  042c 55001f003b    	mov	_ex_stored_netmask1,_stored_netmask1
3549                     ; 518   ex_stored_port = stored_port;
3551  0431 cf0039        	ldw	_ex_stored_port,x
3552                     ; 520   for(i=0; i<20; i++) { ex_stored_devicename[i] = stored_devicename[i]; }
3554  0434 4f            	clr	a
3555  0435 6b01          	ld	(OFST+0,sp),a
3557  0437               L5302:
3560  0437 5f            	clrw	x
3561  0438 97            	ld	xl,a
3562  0439 d60000        	ld	a,(_stored_devicename,x)
3563  043c d70022        	ld	(_ex_stored_devicename,x),a
3566  043f 0c01          	inc	(OFST+0,sp)
3570  0441 7b01          	ld	a,(OFST+0,sp)
3571  0443 a114          	cp	a,#20
3572  0445 25f0          	jrult	L5302
3573                     ; 522 }
3576  0447 84            	pop	a
3577  0448 81            	ret	
3662                     ; 525 void check_runtime_changes(void)
3662                     ; 526 {
3663                     	switch	.text
3664  0449               _check_runtime_changes:
3666  0449 88            	push	a
3667       00000001      OFST:	set	1
3670                     ; 534   read_input_registers();
3672  044a cd0622        	call	_read_input_registers
3674                     ; 567   if (stored_hostaddr4 != Pending_hostaddr4 ||
3674                     ; 568       stored_hostaddr3 != Pending_hostaddr3 ||
3674                     ; 569       stored_hostaddr2 != Pending_hostaddr2 ||
3674                     ; 570       stored_hostaddr1 != Pending_hostaddr1) {
3676  044d c6002a        	ld	a,_stored_hostaddr4
3677  0450 c10021        	cp	a,_Pending_hostaddr4
3678  0453 2618          	jrne	L1602
3680  0455 c60029        	ld	a,_stored_hostaddr3
3681  0458 c10020        	cp	a,_Pending_hostaddr3
3682  045b 2610          	jrne	L1602
3684  045d c60028        	ld	a,_stored_hostaddr2
3685  0460 c1001f        	cp	a,_Pending_hostaddr2
3686  0463 2608          	jrne	L1602
3688  0465 c60027        	ld	a,_stored_hostaddr1
3689  0468 c1001e        	cp	a,_Pending_hostaddr1
3690  046b 2728          	jreq	L7502
3691  046d               L1602:
3692                     ; 572     stored_hostaddr4 = Pending_hostaddr4;
3694  046d c60021        	ld	a,_Pending_hostaddr4
3695  0470 ae002a        	ldw	x,#_stored_hostaddr4
3696  0473 cd0000        	call	c_eewrc
3698                     ; 573     stored_hostaddr3 = Pending_hostaddr3;
3700  0476 c60020        	ld	a,_Pending_hostaddr3
3701  0479 ae0029        	ldw	x,#_stored_hostaddr3
3702  047c cd0000        	call	c_eewrc
3704                     ; 574     stored_hostaddr2 = Pending_hostaddr2;
3706  047f c6001f        	ld	a,_Pending_hostaddr2
3707  0482 ae0028        	ldw	x,#_stored_hostaddr2
3708  0485 cd0000        	call	c_eewrc
3710                     ; 575     stored_hostaddr1 = Pending_hostaddr1;
3712  0488 c6001e        	ld	a,_Pending_hostaddr1
3713  048b ae0027        	ldw	x,#_stored_hostaddr1
3714  048e cd0000        	call	c_eewrc
3716                     ; 577     submit_changes = 1;
3718  0491 35010007      	mov	_submit_changes,#1
3719  0495               L7502:
3720                     ; 581   if (stored_draddr4 != Pending_draddr4 ||
3720                     ; 582       stored_draddr3 != Pending_draddr3 ||
3720                     ; 583       stored_draddr2 != Pending_draddr2 ||
3720                     ; 584       stored_draddr1 != Pending_draddr1) {
3722  0495 c60026        	ld	a,_stored_draddr4
3723  0498 c1001d        	cp	a,_Pending_draddr4
3724  049b 2618          	jrne	L1702
3726  049d c60025        	ld	a,_stored_draddr3
3727  04a0 c1001c        	cp	a,_Pending_draddr3
3728  04a3 2610          	jrne	L1702
3730  04a5 c60024        	ld	a,_stored_draddr2
3731  04a8 c1001b        	cp	a,_Pending_draddr2
3732  04ab 2608          	jrne	L1702
3734  04ad c60023        	ld	a,_stored_draddr1
3735  04b0 c1001a        	cp	a,_Pending_draddr1
3736  04b3 2728          	jreq	L7602
3737  04b5               L1702:
3738                     ; 586     stored_draddr4 = Pending_draddr4;
3740  04b5 c6001d        	ld	a,_Pending_draddr4
3741  04b8 ae0026        	ldw	x,#_stored_draddr4
3742  04bb cd0000        	call	c_eewrc
3744                     ; 587     stored_draddr3 = Pending_draddr3;
3746  04be c6001c        	ld	a,_Pending_draddr3
3747  04c1 ae0025        	ldw	x,#_stored_draddr3
3748  04c4 cd0000        	call	c_eewrc
3750                     ; 588     stored_draddr2 = Pending_draddr2;
3752  04c7 c6001b        	ld	a,_Pending_draddr2
3753  04ca ae0024        	ldw	x,#_stored_draddr2
3754  04cd cd0000        	call	c_eewrc
3756                     ; 589     stored_draddr1 = Pending_draddr1;
3758  04d0 c6001a        	ld	a,_Pending_draddr1
3759  04d3 ae0023        	ldw	x,#_stored_draddr1
3760  04d6 cd0000        	call	c_eewrc
3762                     ; 591     submit_changes = 1;
3764  04d9 35010007      	mov	_submit_changes,#1
3765  04dd               L7602:
3766                     ; 595   if (stored_netmask4 != Pending_netmask4 ||
3766                     ; 596       stored_netmask3 != Pending_netmask3 ||
3766                     ; 597       stored_netmask2 != Pending_netmask2 ||
3766                     ; 598       stored_netmask1 != Pending_netmask1) {
3768  04dd c60022        	ld	a,_stored_netmask4
3769  04e0 c10019        	cp	a,_Pending_netmask4
3770  04e3 2618          	jrne	L1012
3772  04e5 c60021        	ld	a,_stored_netmask3
3773  04e8 c10018        	cp	a,_Pending_netmask3
3774  04eb 2610          	jrne	L1012
3776  04ed c60020        	ld	a,_stored_netmask2
3777  04f0 c10017        	cp	a,_Pending_netmask2
3778  04f3 2608          	jrne	L1012
3780  04f5 c6001f        	ld	a,_stored_netmask1
3781  04f8 c10016        	cp	a,_Pending_netmask1
3782  04fb 2728          	jreq	L7702
3783  04fd               L1012:
3784                     ; 600     stored_netmask4 = Pending_netmask4;
3786  04fd c60019        	ld	a,_Pending_netmask4
3787  0500 ae0022        	ldw	x,#_stored_netmask4
3788  0503 cd0000        	call	c_eewrc
3790                     ; 601     stored_netmask3 = Pending_netmask3;
3792  0506 c60018        	ld	a,_Pending_netmask3
3793  0509 ae0021        	ldw	x,#_stored_netmask3
3794  050c cd0000        	call	c_eewrc
3796                     ; 602     stored_netmask2 = Pending_netmask2;
3798  050f c60017        	ld	a,_Pending_netmask2
3799  0512 ae0020        	ldw	x,#_stored_netmask2
3800  0515 cd0000        	call	c_eewrc
3802                     ; 603     stored_netmask1 = Pending_netmask1;
3804  0518 c60016        	ld	a,_Pending_netmask1
3805  051b ae001f        	ldw	x,#_stored_netmask1
3806  051e cd0000        	call	c_eewrc
3808                     ; 605     submit_changes = 1;
3810  0521 35010007      	mov	_submit_changes,#1
3811  0525               L7702:
3812                     ; 609   if (stored_port != Pending_port) {
3814  0525 ce001d        	ldw	x,_stored_port
3815  0528 c30014        	cpw	x,_Pending_port
3816  052b 270f          	jreq	L7012
3817                     ; 611     stored_port = Pending_port;
3819  052d ce0014        	ldw	x,_Pending_port
3820  0530 89            	pushw	x
3821  0531 ae001d        	ldw	x,#_stored_port
3822  0534 cd0000        	call	c_eewrw
3824  0537 35010007      	mov	_submit_changes,#1
3825  053b 85            	popw	x
3826                     ; 613     submit_changes = 1;
3828  053c               L7012:
3829                     ; 617   devicename_changed = 0;
3831  053c 725f0006      	clr	_devicename_changed
3832                     ; 618   for(i=0; i<20; i++) {
3834  0540 4f            	clr	a
3835  0541 6b01          	ld	(OFST+0,sp),a
3837  0543               L1112:
3838                     ; 619     if (stored_devicename[i] != ex_stored_devicename[i]) devicename_changed = 1;
3840  0543 5f            	clrw	x
3841  0544 97            	ld	xl,a
3842  0545 905f          	clrw	y
3843  0547 9097          	ld	yl,a
3844  0549 90d60000      	ld	a,(_stored_devicename,y)
3845  054d d10022        	cp	a,(_ex_stored_devicename,x)
3846  0550 2704          	jreq	L7112
3849  0552 35010006      	mov	_devicename_changed,#1
3850  0556               L7112:
3851                     ; 618   for(i=0; i<20; i++) {
3853  0556 0c01          	inc	(OFST+0,sp)
3857  0558 7b01          	ld	a,(OFST+0,sp)
3858  055a a114          	cp	a,#20
3859  055c 25e5          	jrult	L1112
3860                     ; 621   if (devicename_changed == 1) {
3862  055e c60006        	ld	a,_devicename_changed
3863  0561 4a            	dec	a
3864  0562 2612          	jrne	L1212
3865                     ; 623     for(i=0; i<20; i++) { stored_devicename[i] = ex_stored_devicename[i]; }
3867  0564 6b01          	ld	(OFST+0,sp),a
3869  0566               L3212:
3872  0566 5f            	clrw	x
3873  0567 97            	ld	xl,a
3874  0568 d60022        	ld	a,(_ex_stored_devicename,x)
3875  056b d70000        	ld	(_stored_devicename,x),a
3878  056e 0c01          	inc	(OFST+0,sp)
3882  0570 7b01          	ld	a,(OFST+0,sp)
3883  0572 a114          	cp	a,#20
3884  0574 25f0          	jrult	L3212
3885  0576               L1212:
3886                     ; 627   if (stored_uip_ethaddr6 != Pending_uip_ethaddr6 ||
3886                     ; 628       stored_uip_ethaddr5 != Pending_uip_ethaddr5 ||
3886                     ; 629       stored_uip_ethaddr4 != Pending_uip_ethaddr4 ||
3886                     ; 630       stored_uip_ethaddr3 != Pending_uip_ethaddr3 ||
3886                     ; 631       stored_uip_ethaddr2 != Pending_uip_ethaddr2 ||
3886                     ; 632       stored_uip_ethaddr1 != Pending_uip_ethaddr1) {
3888  0576 c60017        	ld	a,_stored_uip_ethaddr6
3889  0579 c10013        	cp	a,_Pending_uip_ethaddr6
3890  057c 2628          	jrne	L3312
3892  057e c60018        	ld	a,_stored_uip_ethaddr5
3893  0581 c10012        	cp	a,_Pending_uip_ethaddr5
3894  0584 2620          	jrne	L3312
3896  0586 c60019        	ld	a,_stored_uip_ethaddr4
3897  0589 c10011        	cp	a,_Pending_uip_ethaddr4
3898  058c 2618          	jrne	L3312
3900  058e c6001a        	ld	a,_stored_uip_ethaddr3
3901  0591 c10010        	cp	a,_Pending_uip_ethaddr3
3902  0594 2610          	jrne	L3312
3904  0596 c6001b        	ld	a,_stored_uip_ethaddr2
3905  0599 c1000f        	cp	a,_Pending_uip_ethaddr2
3906  059c 2608          	jrne	L3312
3908  059e c6001c        	ld	a,_stored_uip_ethaddr1
3909  05a1 c1000e        	cp	a,_Pending_uip_ethaddr1
3910  05a4 273a          	jreq	L1312
3911  05a6               L3312:
3912                     ; 634     stored_uip_ethaddr6 = Pending_uip_ethaddr6;
3914  05a6 c60013        	ld	a,_Pending_uip_ethaddr6
3915  05a9 ae0017        	ldw	x,#_stored_uip_ethaddr6
3916  05ac cd0000        	call	c_eewrc
3918                     ; 635     stored_uip_ethaddr5 = Pending_uip_ethaddr5;
3920  05af c60012        	ld	a,_Pending_uip_ethaddr5
3921  05b2 ae0018        	ldw	x,#_stored_uip_ethaddr5
3922  05b5 cd0000        	call	c_eewrc
3924                     ; 636     stored_uip_ethaddr4 = Pending_uip_ethaddr4;
3926  05b8 c60011        	ld	a,_Pending_uip_ethaddr4
3927  05bb ae0019        	ldw	x,#_stored_uip_ethaddr4
3928  05be cd0000        	call	c_eewrc
3930                     ; 637     stored_uip_ethaddr3 = Pending_uip_ethaddr3;
3932  05c1 c60010        	ld	a,_Pending_uip_ethaddr3
3933  05c4 ae001a        	ldw	x,#_stored_uip_ethaddr3
3934  05c7 cd0000        	call	c_eewrc
3936                     ; 638     stored_uip_ethaddr2 = Pending_uip_ethaddr2;
3938  05ca c6000f        	ld	a,_Pending_uip_ethaddr2
3939  05cd ae001b        	ldw	x,#_stored_uip_ethaddr2
3940  05d0 cd0000        	call	c_eewrc
3942                     ; 639     stored_uip_ethaddr1 = Pending_uip_ethaddr1;
3944  05d3 c6000e        	ld	a,_Pending_uip_ethaddr1
3945  05d6 ae001c        	ldw	x,#_stored_uip_ethaddr1
3946  05d9 cd0000        	call	c_eewrc
3948                     ; 641     submit_changes = 1;
3950  05dc 35010007      	mov	_submit_changes,#1
3951  05e0               L1312:
3952                     ; 644   if (submit_changes == 1) {
3954  05e0 c60007        	ld	a,_submit_changes
3955  05e3 a101          	cp	a,#1
3956  05e5 2613          	jrne	L5412
3957                     ; 651     check_eeprom_settings(); // Verify EEPROM up to date
3959  05e7 cd00ca        	call	_check_eeprom_settings
3961                     ; 652     Enc28j60Init();          // Initialize the ENC28J60 ethernet interface
3963  05ea cd0000        	call	_Enc28j60Init
3965                     ; 653     uip_arp_init();          // Initialize the ARP module
3967  05ed cd0000        	call	_uip_arp_init
3969                     ; 654     uip_init();              // Initialize uIP
3971  05f0 cd0000        	call	_uip_init
3973                     ; 655     HttpDInit();             // Initialize httpd; sets up listening ports
3975  05f3 cd0000        	call	_HttpDInit
3977                     ; 656     submit_changes = 0;
3979  05f6 4f            	clr	a
3980  05f7 c70007        	ld	_submit_changes,a
3981  05fa               L5412:
3982                     ; 659   if (submit_changes == 2) {
3984  05fa a102          	cp	a,#2
3985  05fc 2622          	jrne	L7412
3986                     ; 662     LEDcontrol(0);  // turn LED off
3988  05fe 4f            	clr	a
3989  05ff cd0000        	call	_LEDcontrol
3991                     ; 664     WWDG_WR = (uint8_t)0x7f;     // Window register reset
3993  0602 357f50d2      	mov	_WWDG_WR,#127
3994                     ; 665     WWDG_CR = (uint8_t)0xff;     // Set watchdog to timeout in 49ms
3996  0606 35ff50d1      	mov	_WWDG_CR,#255
3997                     ; 666     WWDG_WR = (uint8_t)0x60;     // Window register value - doesn't matter
3999  060a 356050d2      	mov	_WWDG_WR,#96
4000                     ; 669     wait_timer((uint16_t)50000); // Wait for watchdog to generate reset
4002  060e aec350        	ldw	x,#50000
4003  0611 cd0000        	call	_wait_timer
4005                     ; 670     wait_timer((uint16_t)50000);
4007  0614 aec350        	ldw	x,#50000
4008  0617 cd0000        	call	_wait_timer
4010                     ; 671     wait_timer((uint16_t)50000);
4012  061a aec350        	ldw	x,#50000
4013  061d cd0000        	call	_wait_timer
4015  0620               L7412:
4016                     ; 673 }
4019  0620 84            	pop	a
4020  0621 81            	ret	
4051                     ; 676 void read_input_registers(void)
4051                     ; 677 {
4052                     	switch	.text
4053  0622               _read_input_registers:
4057                     ; 705   if (PC_IDR & (uint8_t)0x40) IO_16to9 |= 0x80; // PC bit 6 = 1, Input 16 = 1
4059  0622 720d500b06    	btjf	_PC_IDR,#6,L1612
4062  0627 721e0038      	bset	_IO_16to9,#7
4064  062b 2004          	jra	L3612
4065  062d               L1612:
4066                     ; 706   else IO_16to9 &= (uint8_t)(~0x80);
4068  062d 721f0038      	bres	_IO_16to9,#7
4069  0631               L3612:
4070                     ; 707   if (PG_IDR & (uint8_t)0x01) IO_16to9 |= 0x40; // PG bit 0 = 1, Input 15 = 1
4072  0631 7201501f06    	btjf	_PG_IDR,#0,L5612
4075  0636 721c0038      	bset	_IO_16to9,#6
4077  063a 2004          	jra	L7612
4078  063c               L5612:
4079                     ; 708   else IO_16to9 &= (uint8_t)(~0x40);
4081  063c 721d0038      	bres	_IO_16to9,#6
4082  0640               L7612:
4083                     ; 709   if (PE_IDR & (uint8_t)0x08) IO_16to9 |= 0x20; // PE bit 3 = 1, Input 14 = 1
4085  0640 7207501506    	btjf	_PE_IDR,#3,L1712
4088  0645 721a0038      	bset	_IO_16to9,#5
4090  0649 2004          	jra	L3712
4091  064b               L1712:
4092                     ; 710   else IO_16to9 &= (uint8_t)(~0x20);
4094  064b 721b0038      	bres	_IO_16to9,#5
4095  064f               L3712:
4096                     ; 711   if (PD_IDR & (uint8_t)0x01) IO_16to9 |= 0x10; // PD bit 0 = 1, Input 13 = 1
4098  064f 7201501006    	btjf	_PD_IDR,#0,L5712
4101  0654 72180038      	bset	_IO_16to9,#4
4103  0658 2004          	jra	L7712
4104  065a               L5712:
4105                     ; 712   else IO_16to9 &= (uint8_t)(~0x10);
4107  065a 72190038      	bres	_IO_16to9,#4
4108  065e               L7712:
4109                     ; 713   if (PD_IDR & (uint8_t)0x08) IO_16to9 |= 0x08; // PD bit 3 = 1, Input 12 = 1
4111  065e 7207501006    	btjf	_PD_IDR,#3,L1022
4114  0663 72160038      	bset	_IO_16to9,#3
4116  0667 2004          	jra	L3022
4117  0669               L1022:
4118                     ; 714   else IO_16to9 &= (uint8_t)(~0x08);
4120  0669 72170038      	bres	_IO_16to9,#3
4121  066d               L3022:
4122                     ; 715   if (PD_IDR & (uint8_t)0x20) IO_16to9 |= 0x04; // PD bit 5 = 1, Input 11 = 1
4124  066d 720b501006    	btjf	_PD_IDR,#5,L5022
4127  0672 72140038      	bset	_IO_16to9,#2
4129  0676 2004          	jra	L7022
4130  0678               L5022:
4131                     ; 716   else IO_16to9 &= (uint8_t)(~0x04);
4133  0678 72150038      	bres	_IO_16to9,#2
4134  067c               L7022:
4135                     ; 717   if (PD_IDR & (uint8_t)0x80) IO_16to9 |= 0x02; // PD bit 7 = 1, Input 10 = 1
4137  067c 720f501006    	btjf	_PD_IDR,#7,L1122
4140  0681 72120038      	bset	_IO_16to9,#1
4142  0685 2004          	jra	L3122
4143  0687               L1122:
4144                     ; 718   else IO_16to9 &= (uint8_t)(~0x02);
4146  0687 72130038      	bres	_IO_16to9,#1
4147  068b               L3122:
4148                     ; 719   if (PA_IDR & (uint8_t)0x10) IO_16to9 |= 0x01; // PA bit 4 = 1, Input 9 = 1
4150  068b 7209500106    	btjf	_PA_IDR,#4,L5122
4153  0690 72100038      	bset	_IO_16to9,#0
4155  0694 2004          	jra	L7122
4156  0696               L5122:
4157                     ; 720   else IO_16to9 &= (uint8_t)(~0x01);
4159  0696 72110038      	bres	_IO_16to9,#0
4160  069a               L7122:
4161                     ; 722   if (PC_IDR & (uint8_t)0x80) IO_8to1 |= 0x80;  // PC bit 7 = 1, Input 8 = 1
4163  069a 720f500b06    	btjf	_PC_IDR,#7,L1222
4166  069f 721e0037      	bset	_IO_8to1,#7
4168  06a3 2004          	jra	L3222
4169  06a5               L1222:
4170                     ; 723   else IO_8to1 &= (uint8_t)(~0x80);
4172  06a5 721f0037      	bres	_IO_8to1,#7
4173  06a9               L3222:
4174                     ; 724   if (PG_IDR & (uint8_t)0x02) IO_8to1 |= 0x40;  // PG bit 1 = 1, Input 7 = 1
4176  06a9 7203501f06    	btjf	_PG_IDR,#1,L5222
4179  06ae 721c0037      	bset	_IO_8to1,#6
4181  06b2 2004          	jra	L7222
4182  06b4               L5222:
4183                     ; 725   else IO_8to1 &= (uint8_t)(~0x40);
4185  06b4 721d0037      	bres	_IO_8to1,#6
4186  06b8               L7222:
4187                     ; 726   if (PE_IDR & (uint8_t)0x01) IO_8to1 |= 0x20;  // PE bit 0 = 1, Input 6 = 1
4189  06b8 7201501506    	btjf	_PE_IDR,#0,L1322
4192  06bd 721a0037      	bset	_IO_8to1,#5
4194  06c1 2004          	jra	L3322
4195  06c3               L1322:
4196                     ; 727   else IO_8to1 &= (uint8_t)(~0x20);
4198  06c3 721b0037      	bres	_IO_8to1,#5
4199  06c7               L3322:
4200                     ; 728   if (PD_IDR & (uint8_t)0x04) IO_8to1 |= 0x10;  // PD bit 2 = 1, Input 5 = 1
4202  06c7 7205501006    	btjf	_PD_IDR,#2,L5322
4205  06cc 72180037      	bset	_IO_8to1,#4
4207  06d0 2004          	jra	L7322
4208  06d2               L5322:
4209                     ; 729   else IO_8to1 &= (uint8_t)(~0x10);
4211  06d2 72190037      	bres	_IO_8to1,#4
4212  06d6               L7322:
4213                     ; 730   if (PD_IDR & (uint8_t)0x10) IO_8to1 |= 0x08;  // PD bit 4 = 1, Input 4 = 1
4215  06d6 7209501006    	btjf	_PD_IDR,#4,L1422
4218  06db 72160037      	bset	_IO_8to1,#3
4220  06df 2004          	jra	L3422
4221  06e1               L1422:
4222                     ; 731   else IO_8to1 &= (uint8_t)(~0x08);
4224  06e1 72170037      	bres	_IO_8to1,#3
4225  06e5               L3422:
4226                     ; 732   if (PD_IDR & (uint8_t)0x40) IO_8to1 |= 0x04;  // PD bit 6 = 1, Input 3 = 1
4228  06e5 720d501006    	btjf	_PD_IDR,#6,L5422
4231  06ea 72140037      	bset	_IO_8to1,#2
4233  06ee 2004          	jra	L7422
4234  06f0               L5422:
4235                     ; 733   else IO_8to1 &= (uint8_t)(~0x04);
4237  06f0 72150037      	bres	_IO_8to1,#2
4238  06f4               L7422:
4239                     ; 734   if (PA_IDR & (uint8_t)0x20) IO_8to1 |= 0x02;  // PA bit 5 = 1, Input 2 = 1
4241  06f4 720b500106    	btjf	_PA_IDR,#5,L1522
4244  06f9 72120037      	bset	_IO_8to1,#1
4246  06fd 2004          	jra	L3522
4247  06ff               L1522:
4248                     ; 735   else IO_8to1 &= (uint8_t)(~0x02);
4250  06ff 72130037      	bres	_IO_8to1,#1
4251  0703               L3522:
4252                     ; 736   if (PA_IDR & (uint8_t)0x08) IO_8to1 |= 0x01;  // PA bit 3 = 1, Input 1 = 1
4254  0703 7207500105    	btjf	_PA_IDR,#3,L5522
4257  0708 72100037      	bset	_IO_8to1,#0
4260  070c 81            	ret	
4261  070d               L5522:
4262                     ; 737   else IO_8to1 &= (uint8_t)(~0x01);
4264  070d 72110037      	bres	_IO_8to1,#0
4265                     ; 739 }
4268  0711 81            	ret	
4292                     ; 742 void write_output_registers(void)
4292                     ; 743 {
4293                     	switch	.text
4294  0712               _write_output_registers:
4298                     ; 877 }
4301  0712 81            	ret	
4365                     ; 880 void check_reset_button(void)
4365                     ; 881 {
4366                     	switch	.text
4367  0713               _check_reset_button:
4369  0713 88            	push	a
4370       00000001      OFST:	set	1
4373                     ; 886   if ((PA_IDR & 0x02) == 0) {
4375  0714 7203500103cc  	btjt	_PA_IDR,#1,L5032
4376                     ; 888     for (i=0; i<100; i++) {
4378  071c 0f01          	clr	(OFST+0,sp)
4380  071e               L7032:
4381                     ; 889       wait_timer(50000); // wait 50ms
4383  071e aec350        	ldw	x,#50000
4384  0721 cd0000        	call	_wait_timer
4386                     ; 890       if ((PA_IDR & 0x02) == 1) { // check Reset Button again. If released
4388  0724 c65001        	ld	a,_PA_IDR
4389  0727 a402          	and	a,#2
4390  0729 4a            	dec	a
4391  072a 2602          	jrne	L5132
4392                     ; 892         return;
4395  072c 84            	pop	a
4396  072d 81            	ret	
4397  072e               L5132:
4398                     ; 888     for (i=0; i<100; i++) {
4400  072e 0c01          	inc	(OFST+0,sp)
4404  0730 7b01          	ld	a,(OFST+0,sp)
4405  0732 a164          	cp	a,#100
4406  0734 25e8          	jrult	L7032
4407                     ; 897     LEDcontrol(0);  // turn LED off
4409  0736 4f            	clr	a
4410  0737 cd0000        	call	_LEDcontrol
4413  073a               L1232:
4414                     ; 898     while((PA_IDR & 0x02) == 0) {  // Wait for button release
4416  073a 72035001fb    	btjf	_PA_IDR,#1,L1232
4417                     ; 901     magic4 = 0x00;		   // MSB Magic Number stored in EEPROM
4419  073f 4f            	clr	a
4420  0740 ae002e        	ldw	x,#_magic4
4421  0743 cd0000        	call	c_eewrc
4423                     ; 902     magic3 = 0x00;		   //
4425  0746 4f            	clr	a
4426  0747 ae002d        	ldw	x,#_magic3
4427  074a cd0000        	call	c_eewrc
4429                     ; 903     magic2 = 0x00;		   //
4431  074d 4f            	clr	a
4432  074e ae002c        	ldw	x,#_magic2
4433  0751 cd0000        	call	c_eewrc
4435                     ; 904     magic1 = 0x00;		   // LSB Magic Number
4437  0754 4f            	clr	a
4438  0755 ae002b        	ldw	x,#_magic1
4439  0758 cd0000        	call	c_eewrc
4441                     ; 906     stored_hostaddr4 = 0x00;	   // MSB hostaddr stored in EEPROM
4443  075b 4f            	clr	a
4444  075c ae002a        	ldw	x,#_stored_hostaddr4
4445  075f cd0000        	call	c_eewrc
4447                     ; 907     stored_hostaddr3 = 0x00;	   //
4449  0762 4f            	clr	a
4450  0763 ae0029        	ldw	x,#_stored_hostaddr3
4451  0766 cd0000        	call	c_eewrc
4453                     ; 908     stored_hostaddr2 = 0x00;	   //
4455  0769 4f            	clr	a
4456  076a ae0028        	ldw	x,#_stored_hostaddr2
4457  076d cd0000        	call	c_eewrc
4459                     ; 909     stored_hostaddr1 = 0x00;	   // LSB hostaddr
4461  0770 4f            	clr	a
4462  0771 ae0027        	ldw	x,#_stored_hostaddr1
4463  0774 cd0000        	call	c_eewrc
4465                     ; 911     stored_draddr4 = 0x00;	   // MSB draddr stored in EEPROM
4467  0777 4f            	clr	a
4468  0778 ae0026        	ldw	x,#_stored_draddr4
4469  077b cd0000        	call	c_eewrc
4471                     ; 912     stored_draddr3 = 0x00;	   //
4473  077e 4f            	clr	a
4474  077f ae0025        	ldw	x,#_stored_draddr3
4475  0782 cd0000        	call	c_eewrc
4477                     ; 913     stored_draddr2 = 0x00;	   //
4479  0785 4f            	clr	a
4480  0786 ae0024        	ldw	x,#_stored_draddr2
4481  0789 cd0000        	call	c_eewrc
4483                     ; 914     stored_draddr1 = 0x00;	   // LSB draddr
4485  078c 4f            	clr	a
4486  078d ae0023        	ldw	x,#_stored_draddr1
4487  0790 cd0000        	call	c_eewrc
4489                     ; 916     stored_netmask4 = 0x00;	   // MSB netmask stored in EEPROM
4491  0793 4f            	clr	a
4492  0794 ae0022        	ldw	x,#_stored_netmask4
4493  0797 cd0000        	call	c_eewrc
4495                     ; 917     stored_netmask3 = 0x00;	   //
4497  079a 4f            	clr	a
4498  079b ae0021        	ldw	x,#_stored_netmask3
4499  079e cd0000        	call	c_eewrc
4501                     ; 918     stored_netmask2 = 0x00;	   //
4503  07a1 4f            	clr	a
4504  07a2 ae0020        	ldw	x,#_stored_netmask2
4505  07a5 cd0000        	call	c_eewrc
4507                     ; 919     stored_netmask1 = 0x00;	   // LSB netmask
4509  07a8 4f            	clr	a
4510  07a9 ae001f        	ldw	x,#_stored_netmask1
4511  07ac cd0000        	call	c_eewrc
4513                     ; 921     stored_port = 0x0000;	   // Port stored in EEPROM
4515  07af 5f            	clrw	x
4516  07b0 89            	pushw	x
4517  07b1 ae001d        	ldw	x,#_stored_port
4518  07b4 cd0000        	call	c_eewrw
4520  07b7 4f            	clr	a
4521  07b8 85            	popw	x
4522                     ; 923     stored_uip_ethaddr1 = 0x00;	   // MAC MSB
4524  07b9 ae001c        	ldw	x,#_stored_uip_ethaddr1
4525  07bc cd0000        	call	c_eewrc
4527                     ; 924     stored_uip_ethaddr2 = 0x00;	   //
4529  07bf 4f            	clr	a
4530  07c0 ae001b        	ldw	x,#_stored_uip_ethaddr2
4531  07c3 cd0000        	call	c_eewrc
4533                     ; 925     stored_uip_ethaddr3 = 0x00;	   //
4535  07c6 4f            	clr	a
4536  07c7 ae001a        	ldw	x,#_stored_uip_ethaddr3
4537  07ca cd0000        	call	c_eewrc
4539                     ; 926     stored_uip_ethaddr4 = 0x00;	   //
4541  07cd 4f            	clr	a
4542  07ce ae0019        	ldw	x,#_stored_uip_ethaddr4
4543  07d1 cd0000        	call	c_eewrc
4545                     ; 927     stored_uip_ethaddr5 = 0x00;	   //
4547  07d4 4f            	clr	a
4548  07d5 ae0018        	ldw	x,#_stored_uip_ethaddr5
4549  07d8 cd0000        	call	c_eewrc
4551                     ; 928     stored_uip_ethaddr6 = 0x00;	   // MAC LSB stored in EEPROM
4553  07db 4f            	clr	a
4554  07dc ae0017        	ldw	x,#_stored_uip_ethaddr6
4555  07df cd0000        	call	c_eewrc
4557                     ; 930     stored_IO_16to9 = 0x00;        // IO States 16 to 9
4559  07e2 4f            	clr	a
4560  07e3 ae0016        	ldw	x,#_stored_IO_16to9
4561  07e6 cd0000        	call	c_eewrc
4563                     ; 931     stored_IO_8to1 = 0x00;         // IO States 8 to 1
4565  07e9 4f            	clr	a
4566  07ea ae0015        	ldw	x,#_stored_IO_8to1
4567  07ed cd0000        	call	c_eewrc
4569                     ; 932     stored_invert_output = 0x00;   // Relay state inversion control
4571  07f0 4f            	clr	a
4572  07f1 ae0014        	ldw	x,#_stored_invert_output
4573  07f4 cd0000        	call	c_eewrc
4575                     ; 934     stored_devicename[0] = 0x00;   // Device name
4577  07f7 4f            	clr	a
4578  07f8 ae0000        	ldw	x,#_stored_devicename
4579  07fb cd0000        	call	c_eewrc
4581                     ; 935     stored_devicename[1] = 0x00;   // Device name
4583  07fe 4f            	clr	a
4584  07ff ae0001        	ldw	x,#_stored_devicename+1
4585  0802 cd0000        	call	c_eewrc
4587                     ; 936     stored_devicename[2] = 0x00;   // Device name
4589  0805 4f            	clr	a
4590  0806 ae0002        	ldw	x,#_stored_devicename+2
4591  0809 cd0000        	call	c_eewrc
4593                     ; 937     stored_devicename[3] = 0x00;   // Device name
4595  080c 4f            	clr	a
4596  080d ae0003        	ldw	x,#_stored_devicename+3
4597  0810 cd0000        	call	c_eewrc
4599                     ; 938     stored_devicename[4] = 0x00;   // Device name
4601  0813 4f            	clr	a
4602  0814 ae0004        	ldw	x,#_stored_devicename+4
4603  0817 cd0000        	call	c_eewrc
4605                     ; 939     stored_devicename[5] = 0x00;   // Device name
4607  081a 4f            	clr	a
4608  081b ae0005        	ldw	x,#_stored_devicename+5
4609  081e cd0000        	call	c_eewrc
4611                     ; 940     stored_devicename[6] = 0x00;   // Device name
4613  0821 4f            	clr	a
4614  0822 ae0006        	ldw	x,#_stored_devicename+6
4615  0825 cd0000        	call	c_eewrc
4617                     ; 941     stored_devicename[7] = 0x00;   // Device name
4619  0828 4f            	clr	a
4620  0829 ae0007        	ldw	x,#_stored_devicename+7
4621  082c cd0000        	call	c_eewrc
4623                     ; 942     stored_devicename[8] = 0x00;   // Device name
4625  082f 4f            	clr	a
4626  0830 ae0008        	ldw	x,#_stored_devicename+8
4627  0833 cd0000        	call	c_eewrc
4629                     ; 943     stored_devicename[9] = 0x00;   // Device name
4631  0836 4f            	clr	a
4632  0837 ae0009        	ldw	x,#_stored_devicename+9
4633  083a cd0000        	call	c_eewrc
4635                     ; 944     stored_devicename[10] = 0x00;  // Device name
4637  083d 4f            	clr	a
4638  083e ae000a        	ldw	x,#_stored_devicename+10
4639  0841 cd0000        	call	c_eewrc
4641                     ; 945     stored_devicename[11] = 0x00;  // Device name
4643  0844 4f            	clr	a
4644  0845 ae000b        	ldw	x,#_stored_devicename+11
4645  0848 cd0000        	call	c_eewrc
4647                     ; 946     stored_devicename[12] = 0x00;  // Device name
4649  084b 4f            	clr	a
4650  084c ae000c        	ldw	x,#_stored_devicename+12
4651  084f cd0000        	call	c_eewrc
4653                     ; 947     stored_devicename[13] = 0x00;  // Device name
4655  0852 4f            	clr	a
4656  0853 ae000d        	ldw	x,#_stored_devicename+13
4657  0856 cd0000        	call	c_eewrc
4659                     ; 948     stored_devicename[14] = 0x00;  // Device name
4661  0859 4f            	clr	a
4662  085a ae000e        	ldw	x,#_stored_devicename+14
4663  085d cd0000        	call	c_eewrc
4665                     ; 949     stored_devicename[15] = 0x00;  // Device name
4667  0860 4f            	clr	a
4668  0861 ae000f        	ldw	x,#_stored_devicename+15
4669  0864 cd0000        	call	c_eewrc
4671                     ; 950     stored_devicename[16] = 0x00;  // Device name
4673  0867 4f            	clr	a
4674  0868 ae0010        	ldw	x,#_stored_devicename+16
4675  086b cd0000        	call	c_eewrc
4677                     ; 951     stored_devicename[17] = 0x00;  // Device name
4679  086e 4f            	clr	a
4680  086f ae0011        	ldw	x,#_stored_devicename+17
4681  0872 cd0000        	call	c_eewrc
4683                     ; 952     stored_devicename[18] = 0x00;  // Device name
4685  0875 4f            	clr	a
4686  0876 ae0012        	ldw	x,#_stored_devicename+18
4687  0879 cd0000        	call	c_eewrc
4689                     ; 953     stored_devicename[19] = 0x00;  // Device name
4691  087c 4f            	clr	a
4692  087d ae0013        	ldw	x,#_stored_devicename+19
4693  0880 cd0000        	call	c_eewrc
4695                     ; 955     WWDG_WR = (uint8_t)0x7f;       // Window register reset
4697  0883 357f50d2      	mov	_WWDG_WR,#127
4698                     ; 956     WWDG_CR = (uint8_t)0xff;       // Set watchdog to timeout in 49ms
4700  0887 35ff50d1      	mov	_WWDG_CR,#255
4701                     ; 957     WWDG_WR = (uint8_t)0x60;       // Window register value - doesn't matter
4703  088b 356050d2      	mov	_WWDG_WR,#96
4704                     ; 960     wait_timer((uint16_t)50000);   // Wait for watchdog to generate reset
4706  088f aec350        	ldw	x,#50000
4707  0892 cd0000        	call	_wait_timer
4709                     ; 961     wait_timer((uint16_t)50000);
4711  0895 aec350        	ldw	x,#50000
4712  0898 cd0000        	call	_wait_timer
4714                     ; 962     wait_timer((uint16_t)50000);
4716  089b aec350        	ldw	x,#50000
4717  089e cd0000        	call	_wait_timer
4719  08a1               L5032:
4720                     ; 964 }
4723  08a1 84            	pop	a
4724  08a2 81            	ret	
4758                     ; 967 void debugflash(void)
4758                     ; 968 {
4759                     	switch	.text
4760  08a3               _debugflash:
4762  08a3 88            	push	a
4763       00000001      OFST:	set	1
4766                     ; 983   LEDcontrol(0);     // turn LED off
4768  08a4 4f            	clr	a
4769  08a5 cd0000        	call	_LEDcontrol
4771                     ; 984   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
4773  08a8 0f01          	clr	(OFST+0,sp)
4775  08aa               L1432:
4778  08aa aec350        	ldw	x,#50000
4779  08ad cd0000        	call	_wait_timer
4783  08b0 0c01          	inc	(OFST+0,sp)
4787  08b2 7b01          	ld	a,(OFST+0,sp)
4788  08b4 a10a          	cp	a,#10
4789  08b6 25f2          	jrult	L1432
4790                     ; 986   LEDcontrol(1);     // turn LED on
4792  08b8 a601          	ld	a,#1
4793  08ba cd0000        	call	_LEDcontrol
4795                     ; 987   for(i=0; i<10; i++) wait_timer((uint16_t)50000); // wait 500ms
4797  08bd 0f01          	clr	(OFST+0,sp)
4799  08bf               L7432:
4802  08bf aec350        	ldw	x,#50000
4803  08c2 cd0000        	call	_wait_timer
4807  08c5 0c01          	inc	(OFST+0,sp)
4811  08c7 7b01          	ld	a,(OFST+0,sp)
4812  08c9 a10a          	cp	a,#10
4813  08cb 25f2          	jrult	L7432
4814                     ; 988 }
4817  08cd 84            	pop	a
4818  08ce 81            	ret	
5423                     	switch	.bss
5424  0000               _IpAddr:
5425  0000 00000000      	ds.b	4
5426                     	xdef	_IpAddr
5427  0004               _Port_Httpd:
5428  0004 0000          	ds.b	2
5429                     	xdef	_Port_Httpd
5430  0006               _devicename_changed:
5431  0006 00            	ds.b	1
5432                     	xdef	_devicename_changed
5433  0007               _submit_changes:
5434  0007 00            	ds.b	1
5435                     	xdef	_submit_changes
5436  0008               _uip_ethaddr1:
5437  0008 00            	ds.b	1
5438                     	xdef	_uip_ethaddr1
5439  0009               _uip_ethaddr2:
5440  0009 00            	ds.b	1
5441                     	xdef	_uip_ethaddr2
5442  000a               _uip_ethaddr3:
5443  000a 00            	ds.b	1
5444                     	xdef	_uip_ethaddr3
5445  000b               _uip_ethaddr4:
5446  000b 00            	ds.b	1
5447                     	xdef	_uip_ethaddr4
5448  000c               _uip_ethaddr5:
5449  000c 00            	ds.b	1
5450                     	xdef	_uip_ethaddr5
5451  000d               _uip_ethaddr6:
5452  000d 00            	ds.b	1
5453                     	xdef	_uip_ethaddr6
5454  000e               _Pending_uip_ethaddr1:
5455  000e 00            	ds.b	1
5456                     	xdef	_Pending_uip_ethaddr1
5457  000f               _Pending_uip_ethaddr2:
5458  000f 00            	ds.b	1
5459                     	xdef	_Pending_uip_ethaddr2
5460  0010               _Pending_uip_ethaddr3:
5461  0010 00            	ds.b	1
5462                     	xdef	_Pending_uip_ethaddr3
5463  0011               _Pending_uip_ethaddr4:
5464  0011 00            	ds.b	1
5465                     	xdef	_Pending_uip_ethaddr4
5466  0012               _Pending_uip_ethaddr5:
5467  0012 00            	ds.b	1
5468                     	xdef	_Pending_uip_ethaddr5
5469  0013               _Pending_uip_ethaddr6:
5470  0013 00            	ds.b	1
5471                     	xdef	_Pending_uip_ethaddr6
5472  0014               _Pending_port:
5473  0014 0000          	ds.b	2
5474                     	xdef	_Pending_port
5475  0016               _Pending_netmask1:
5476  0016 00            	ds.b	1
5477                     	xdef	_Pending_netmask1
5478  0017               _Pending_netmask2:
5479  0017 00            	ds.b	1
5480                     	xdef	_Pending_netmask2
5481  0018               _Pending_netmask3:
5482  0018 00            	ds.b	1
5483                     	xdef	_Pending_netmask3
5484  0019               _Pending_netmask4:
5485  0019 00            	ds.b	1
5486                     	xdef	_Pending_netmask4
5487  001a               _Pending_draddr1:
5488  001a 00            	ds.b	1
5489                     	xdef	_Pending_draddr1
5490  001b               _Pending_draddr2:
5491  001b 00            	ds.b	1
5492                     	xdef	_Pending_draddr2
5493  001c               _Pending_draddr3:
5494  001c 00            	ds.b	1
5495                     	xdef	_Pending_draddr3
5496  001d               _Pending_draddr4:
5497  001d 00            	ds.b	1
5498                     	xdef	_Pending_draddr4
5499  001e               _Pending_hostaddr1:
5500  001e 00            	ds.b	1
5501                     	xdef	_Pending_hostaddr1
5502  001f               _Pending_hostaddr2:
5503  001f 00            	ds.b	1
5504                     	xdef	_Pending_hostaddr2
5505  0020               _Pending_hostaddr3:
5506  0020 00            	ds.b	1
5507                     	xdef	_Pending_hostaddr3
5508  0021               _Pending_hostaddr4:
5509  0021 00            	ds.b	1
5510                     	xdef	_Pending_hostaddr4
5511  0022               _ex_stored_devicename:
5512  0022 000000000000  	ds.b	20
5513                     	xdef	_ex_stored_devicename
5514  0036               _invert_output:
5515  0036 00            	ds.b	1
5516                     	xdef	_invert_output
5517  0037               _IO_8to1:
5518  0037 00            	ds.b	1
5519                     	xdef	_IO_8to1
5520  0038               _IO_16to9:
5521  0038 00            	ds.b	1
5522                     	xdef	_IO_16to9
5523  0039               _ex_stored_port:
5524  0039 0000          	ds.b	2
5525                     	xdef	_ex_stored_port
5526  003b               _ex_stored_netmask1:
5527  003b 00            	ds.b	1
5528                     	xdef	_ex_stored_netmask1
5529  003c               _ex_stored_netmask2:
5530  003c 00            	ds.b	1
5531                     	xdef	_ex_stored_netmask2
5532  003d               _ex_stored_netmask3:
5533  003d 00            	ds.b	1
5534                     	xdef	_ex_stored_netmask3
5535  003e               _ex_stored_netmask4:
5536  003e 00            	ds.b	1
5537                     	xdef	_ex_stored_netmask4
5538  003f               _ex_stored_draddr1:
5539  003f 00            	ds.b	1
5540                     	xdef	_ex_stored_draddr1
5541  0040               _ex_stored_draddr2:
5542  0040 00            	ds.b	1
5543                     	xdef	_ex_stored_draddr2
5544  0041               _ex_stored_draddr3:
5545  0041 00            	ds.b	1
5546                     	xdef	_ex_stored_draddr3
5547  0042               _ex_stored_draddr4:
5548  0042 00            	ds.b	1
5549                     	xdef	_ex_stored_draddr4
5550  0043               _ex_stored_hostaddr1:
5551  0043 00            	ds.b	1
5552                     	xdef	_ex_stored_hostaddr1
5553  0044               _ex_stored_hostaddr2:
5554  0044 00            	ds.b	1
5555                     	xdef	_ex_stored_hostaddr2
5556  0045               _ex_stored_hostaddr3:
5557  0045 00            	ds.b	1
5558                     	xdef	_ex_stored_hostaddr3
5559  0046               _ex_stored_hostaddr4:
5560  0046 00            	ds.b	1
5561                     	xdef	_ex_stored_hostaddr4
5562                     .eeprom:	section	.data
5563  0000               _stored_devicename:
5564  0000 000000000000  	ds.b	20
5565                     	xdef	_stored_devicename
5566  0014               _stored_invert_output:
5567  0014 00            	ds.b	1
5568                     	xdef	_stored_invert_output
5569  0015               _stored_IO_8to1:
5570  0015 00            	ds.b	1
5571                     	xdef	_stored_IO_8to1
5572  0016               _stored_IO_16to9:
5573  0016 00            	ds.b	1
5574                     	xdef	_stored_IO_16to9
5575  0017               _stored_uip_ethaddr6:
5576  0017 00            	ds.b	1
5577                     	xdef	_stored_uip_ethaddr6
5578  0018               _stored_uip_ethaddr5:
5579  0018 00            	ds.b	1
5580                     	xdef	_stored_uip_ethaddr5
5581  0019               _stored_uip_ethaddr4:
5582  0019 00            	ds.b	1
5583                     	xdef	_stored_uip_ethaddr4
5584  001a               _stored_uip_ethaddr3:
5585  001a 00            	ds.b	1
5586                     	xdef	_stored_uip_ethaddr3
5587  001b               _stored_uip_ethaddr2:
5588  001b 00            	ds.b	1
5589                     	xdef	_stored_uip_ethaddr2
5590  001c               _stored_uip_ethaddr1:
5591  001c 00            	ds.b	1
5592                     	xdef	_stored_uip_ethaddr1
5593  001d               _stored_port:
5594  001d 0000          	ds.b	2
5595                     	xdef	_stored_port
5596  001f               _stored_netmask1:
5597  001f 00            	ds.b	1
5598                     	xdef	_stored_netmask1
5599  0020               _stored_netmask2:
5600  0020 00            	ds.b	1
5601                     	xdef	_stored_netmask2
5602  0021               _stored_netmask3:
5603  0021 00            	ds.b	1
5604                     	xdef	_stored_netmask3
5605  0022               _stored_netmask4:
5606  0022 00            	ds.b	1
5607                     	xdef	_stored_netmask4
5608  0023               _stored_draddr1:
5609  0023 00            	ds.b	1
5610                     	xdef	_stored_draddr1
5611  0024               _stored_draddr2:
5612  0024 00            	ds.b	1
5613                     	xdef	_stored_draddr2
5614  0025               _stored_draddr3:
5615  0025 00            	ds.b	1
5616                     	xdef	_stored_draddr3
5617  0026               _stored_draddr4:
5618  0026 00            	ds.b	1
5619                     	xdef	_stored_draddr4
5620  0027               _stored_hostaddr1:
5621  0027 00            	ds.b	1
5622                     	xdef	_stored_hostaddr1
5623  0028               _stored_hostaddr2:
5624  0028 00            	ds.b	1
5625                     	xdef	_stored_hostaddr2
5626  0029               _stored_hostaddr3:
5627  0029 00            	ds.b	1
5628                     	xdef	_stored_hostaddr3
5629  002a               _stored_hostaddr4:
5630  002a 00            	ds.b	1
5631                     	xdef	_stored_hostaddr4
5632  002b               _magic1:
5633  002b 00            	ds.b	1
5634                     	xdef	_magic1
5635  002c               _magic2:
5636  002c 00            	ds.b	1
5637                     	xdef	_magic2
5638  002d               _magic3:
5639  002d 00            	ds.b	1
5640                     	xdef	_magic3
5641  002e               _magic4:
5642  002e 00            	ds.b	1
5643                     	xdef	_magic4
5644                     	xref	_wait_timer
5645                     	xref	_arp_timer_expired
5646                     	xref	_periodic_timer_expired
5647                     	xref	_clock_init
5648                     	xref	_LEDcontrol
5649                     	xref	_gpio_init
5650                     	xref	_uip_arp_timer
5651                     	xref	_uip_arp_out
5652                     	xref	_uip_arp_arpin
5653                     	xref	_uip_arp_init
5654                     	xref	_uip_ethaddr
5655                     	xref	_uip_draddr
5656                     	xref	_uip_netmask
5657                     	xref	_uip_hostaddr
5658                     	xref	_uip_process
5659                     	xref	_uip_conns
5660                     	xref	_uip_conn
5661                     	xref	_uip_len
5662                     	xref	_htons
5663                     	xref	_uip_buf
5664                     	xref	_uip_init
5665                     	xref	_HttpDInit
5666                     	xref	_Enc28j60Send
5667                     	xref	_Enc28j60CopyPacket
5668                     	xref	_Enc28j60Receive
5669                     	xref	_Enc28j60Init
5670                     	xref	_spi_init
5671                     	xdef	_debugflash
5672                     	xdef	_check_reset_button
5673                     	xdef	_write_output_registers
5674                     	xdef	_read_input_registers
5675                     	xdef	_check_runtime_changes
5676                     	xdef	_check_eeprom_settings
5677                     	xdef	_unlock_eeprom
5678                     	xdef	_main
5679                     	xref.b	c_x
5699                     	xref	c_eewrw
5700                     	xref	c_eewrc
5701                     	xref	c_bmulx
5702                     	end
