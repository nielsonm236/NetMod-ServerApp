   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
 508                     ; 77 int16_t mqtt_sync(struct mqtt_client *client)
 508                     ; 78 {
 510                     .text:	section	.text,new
 511  0000               _mqtt_sync:
 513  0000 89            	pushw	x
 514  0001 89            	pushw	x
 515       00000002      OFST:	set	2
 518                     ; 86     if ((uip_newdata() || uip_acked()) && uip_len > 0) {
 520  0002 7202000005    	btjt	_uip_flags,#1,L172
 522  0007 7201000011    	btjf	_uip_flags,#0,L762
 523  000c               L172:
 525  000c ce0000        	ldw	x,_uip_len
 526  000f 270c          	jreq	L762
 527                     ; 87       err = __mqtt_recv(client);
 529  0011 1e03          	ldw	x,(OFST+1,sp)
 530  0013 cd0000        	call	___mqtt_recv
 532  0016 1f01          	ldw	(OFST-1,sp),x
 534                     ; 88       if (err != MQTT_OK) {
 536  0018 a30001        	cpw	x,#1
 537                     ; 89         return err;
 540  001b 2616          	jrne	L772
 541  001d               L762:
 542                     ; 98     err = __mqtt_send(client);
 544  001d 1e03          	ldw	x,(OFST+1,sp)
 545  001f cd0000        	call	___mqtt_send
 547  0022 1f01          	ldw	(OFST-1,sp),x
 549                     ; 101     if (err == MQTT_OK) {
 551  0024 a30001        	cpw	x,#1
 552  0027 2606          	jrne	L572
 553                     ; 102       MQTT_error_status = 1;
 555  0029 3501012c      	mov	_MQTT_error_status,#1
 557  002d 2004          	jra	L772
 558  002f               L572:
 559                     ; 104     else MQTT_error_status = 0;
 561  002f 725f012c      	clr	_MQTT_error_status
 562  0033               L772:
 563                     ; 105     return err;
 567  0033 5b04          	addw	sp,#4
 568  0035 81            	ret	
 631                     ; 109 uint16_t __mqtt_next_pid(struct mqtt_client *client)
 631                     ; 110 {
 632                     .text:	section	.text,new
 633  0000               ___mqtt_next_pid:
 635  0000 89            	pushw	x
 636  0001 5204          	subw	sp,#4
 637       00000004      OFST:	set	4
 640                     ; 112     int16_t pid_exists = 0;
 642                     ; 113     if (client->pid_lfsr == 0) client->pid_lfsr = 163u;
 644  0003 e601          	ld	a,(1,x)
 645  0005 fa            	or	a,(x)
 646  0006 2605          	jrne	L533
 649  0008 90ae00a3      	ldw	y,#163
 650  000c ff            	ldw	(x),y
 651  000d               L533:
 652                     ; 119         unsigned lsb = client->pid_lfsr & 1;
 654  000d 1e05          	ldw	x,(OFST+1,sp)
 655  000f fe            	ldw	x,(x)
 656  0010 01            	rrwa	x,a
 657  0011 a401          	and	a,#1
 658  0013 5f            	clrw	x
 659  0014 02            	rlwa	x,a
 660  0015 1f03          	ldw	(OFST-1,sp),x
 661  0017 01            	rrwa	x,a
 663                     ; 120         (client->pid_lfsr) >>= 1;
 665  0018 1e05          	ldw	x,(OFST+1,sp)
 666  001a 74            	srl	(x)
 667  001b 6601          	rrc	(1,x)
 668                     ; 121         if (lsb) client->pid_lfsr ^= 0xB400u;
 670  001d 1e03          	ldw	x,(OFST-1,sp)
 671  001f 2706          	jreq	L343
 674  0021 1e05          	ldw	x,(OFST+1,sp)
 675  0023 f6            	ld	a,(x)
 676  0024 a8b4          	xor	a,#180
 677  0026 f7            	ld	(x),a
 678  0027               L343:
 679                     ; 124         pid_exists = 0;
 681  0027 5f            	clrw	x
 682  0028 1f03          	ldw	(OFST-1,sp),x
 684                     ; 125         for(curr = mqtt_mq_get(&(client->mq), 0); curr >= client->mq.queue_tail; --curr) {
 686  002a 1e05          	ldw	x,(OFST+1,sp)
 687  002c ee24          	ldw	x,(36,x)
 689  002e 201b          	jra	L153
 690  0030               L543:
 691                     ; 126             if (curr->packet_id == client->pid_lfsr) {
 693  0030 1e01          	ldw	x,(OFST-3,sp)
 694  0032 1605          	ldw	y,(OFST+1,sp)
 695  0034 ee0a          	ldw	x,(10,x)
 696  0036 90f3          	cpw	x,(y)
 697  0038 260f          	jrne	L553
 698                     ; 127                 pid_exists = 1;
 700  003a ae0001        	ldw	x,#1
 701  003d 1f03          	ldw	(OFST-1,sp),x
 703                     ; 128                 break;
 704  003f               L733:
 705                     ; 132     } while(pid_exists);
 707  003f 1e03          	ldw	x,(OFST-1,sp)
 708  0041 26ca          	jrne	L533
 709                     ; 134     return client->pid_lfsr;
 711  0043 1e05          	ldw	x,(OFST+1,sp)
 712  0045 fe            	ldw	x,(x)
 715  0046 5b06          	addw	sp,#6
 716  0048 81            	ret	
 717  0049               L553:
 718                     ; 125         for(curr = mqtt_mq_get(&(client->mq), 0); curr >= client->mq.queue_tail; --curr) {
 720  0049 1e01          	ldw	x,(OFST-3,sp)
 721  004b               L153:
 722  004b 1d000c        	subw	x,#12
 723  004e 1f01          	ldw	(OFST-3,sp),x
 727  0050 1e05          	ldw	x,(OFST+1,sp)
 728  0052 ee2a          	ldw	x,(42,x)
 729  0054 1301          	cpw	x,(OFST-3,sp)
 730  0056 23d8          	jrule	L543
 731  0058 20e5          	jra	L733
 815                     ; 138 int16_t mqtt_init(struct mqtt_client *client,
 815                     ; 139                uint8_t *sendbuf, uint16_t sendbufsz,
 815                     ; 140                uint8_t *recvbuf, uint16_t recvbufsz,
 815                     ; 141                void (*publish_response_callback)(void** state,struct mqtt_response_publish *publish))
 815                     ; 142 {
 816                     .text:	section	.text,new
 817  0000               _mqtt_init:
 819  0000 89            	pushw	x
 820       00000000      OFST:	set	0
 823                     ; 143     if (client == NULL || sendbuf == NULL || recvbuf == NULL) {
 825  0001 5d            	tnzw	x
 826  0002 2708          	jreq	L124
 828  0004 1e05          	ldw	x,(OFST+5,sp)
 829  0006 2704          	jreq	L124
 831  0008 1e09          	ldw	x,(OFST+9,sp)
 832  000a 2605          	jrne	L714
 833  000c               L124:
 834                     ; 144       return MQTT_ERROR_NULLPTR;
 836  000c ae8001        	ldw	x,#32769
 838  000f 2044          	jra	L22
 839  0011               L714:
 840                     ; 147     mqtt_mq_init(&client->mq, sendbuf, sendbufsz);
 842  0011 1e07          	ldw	x,(OFST+7,sp)
 843  0013 89            	pushw	x
 844  0014 1e07          	ldw	x,(OFST+7,sp)
 845  0016 89            	pushw	x
 846  0017 1e05          	ldw	x,(OFST+5,sp)
 847  0019 1c0022        	addw	x,#34
 848  001c cd0000        	call	_mqtt_mq_init
 850  001f 5b04          	addw	sp,#4
 851                     ; 149     client->recv_buffer.mem_start = recvbuf;
 853  0021 1e01          	ldw	x,(OFST+1,sp)
 854  0023 1609          	ldw	y,(OFST+9,sp)
 855  0025 ef1a          	ldw	(26,x),y
 856                     ; 150     client->recv_buffer.mem_size = recvbufsz;
 858  0027 160b          	ldw	y,(OFST+11,sp)
 859  0029 ef1c          	ldw	(28,x),y
 860                     ; 151     client->recv_buffer.curr = client->recv_buffer.mem_start;
 862  002b 9093          	ldw	y,x
 863  002d 90ee1a        	ldw	y,(26,y)
 864  0030 ef1e          	ldw	(30,x),y
 865                     ; 152     client->recv_buffer.curr_sz = client->recv_buffer.mem_size;
 867  0032 9093          	ldw	y,x
 868  0034 90ee1c        	ldw	y,(28,y)
 869  0037 ef20          	ldw	(32,x),y
 870                     ; 154     client->error = MQTT_ERROR_CONNECT_NOT_CALLED;
 872  0039 90ae800f      	ldw	y,#32783
 873  003d ef0a          	ldw	(10,x),y
 874                     ; 155     client->response_timeout = 30;
 876  003f 90ae001e      	ldw	y,#30
 877  0043 ef0c          	ldw	(12,x),y
 878                     ; 156     client->number_of_timeouts = 0;
 880  0045 905f          	clrw	y
 881  0047 ef0e          	ldw	(14,x),y
 882                     ; 157     client->publish_response_callback = publish_response_callback;
 884  0049 160d          	ldw	y,(OFST+13,sp)
 885  004b ef10          	ldw	(16,x),y
 886                     ; 158     client->pid_lfsr = 0;
 888  004d 905f          	clrw	y
 889  004f ff            	ldw	(x),y
 890                     ; 159     client->send_offset = 0;
 892  0050 ef04          	ldw	(4,x),y
 893                     ; 161     return MQTT_OK;
 895  0052 ae0001        	ldw	x,#1
 897  0055               L22:
 899  0055 5b02          	addw	sp,#2
 900  0057 81            	ret	
1030                     ; 228 int16_t mqtt_connect(struct mqtt_client *client,
1030                     ; 229                      const char* client_id,
1030                     ; 230                      const char* will_topic,
1030                     ; 231                      const void* will_message,
1030                     ; 232                      uint16_t will_message_size,
1030                     ; 233                      const char* user_name,
1030                     ; 234                      const char* password,
1030                     ; 235                      uint8_t connect_flags,
1030                     ; 236                      uint16_t keep_alive)
1030                     ; 237 {
1031                     .text:	section	.text,new
1032  0000               _mqtt_connect:
1034  0000 89            	pushw	x
1035  0001 89            	pushw	x
1036       00000002      OFST:	set	2
1039                     ; 242     client->keep_alive = keep_alive;
1041  0002 1614          	ldw	y,(OFST+18,sp)
1042  0004 ef02          	ldw	(2,x),y
1043                     ; 244     if (client->error == MQTT_ERROR_CONNECT_NOT_CALLED) {
1045  0006 9093          	ldw	y,x
1046  0008 90ee0a        	ldw	y,(10,y)
1047  000b 90a3800f      	cpw	y,#32783
1048  000f 2606          	jrne	L705
1049                     ; 245         client->error = MQTT_OK;
1051  0011 90ae0001      	ldw	y,#1
1052  0015 ef0a          	ldw	(10,x),y
1053  0017               L705:
1054                     ; 249     MQTT_CLIENT_TRY_PACK(rv, msg, client, 
1056  0017 e60a          	ld	a,(10,x)
1057  0019 2a04          	jrpl	L115
1060  001b ee0a          	ldw	x,(10,x)
1062  001d 2031          	jra	L63
1063  001f               L115:
1066  001f 1e14          	ldw	x,(OFST+18,sp)
1067  0021 89            	pushw	x
1068  0022 7b15          	ld	a,(OFST+19,sp)
1069  0024 88            	push	a
1070  0025 1e14          	ldw	x,(OFST+18,sp)
1071  0027 89            	pushw	x
1072  0028 1e14          	ldw	x,(OFST+18,sp)
1073  002a 89            	pushw	x
1074  002b 1e14          	ldw	x,(OFST+18,sp)
1075  002d 89            	pushw	x
1076  002e 1e14          	ldw	x,(OFST+18,sp)
1077  0030 89            	pushw	x
1078  0031 1e14          	ldw	x,(OFST+18,sp)
1079  0033 89            	pushw	x
1080  0034 1e14          	ldw	x,(OFST+18,sp)
1081  0036 89            	pushw	x
1082  0037 1e12          	ldw	x,(OFST+16,sp)
1083  0039 ee28          	ldw	x,(40,x)
1084  003b 89            	pushw	x
1085  003c 1e14          	ldw	x,(OFST+18,sp)
1086  003e ee26          	ldw	x,(38,x)
1087  0040 cd0000        	call	_mqtt_pack_connection_request
1089  0043 5b11          	addw	sp,#17
1090  0045 1f01          	ldw	(OFST-1,sp),x
1094  0047 2a0a          	jrpl	L315
1099  0049               LC001:
1101  0049 1e03          	ldw	x,(OFST+1,sp)
1102  004b 1601          	ldw	y,(OFST-1,sp)
1103  004d ef0a          	ldw	(10,x),y
1105  004f 93            	ldw	x,y
1107  0050               L63:
1109  0050 5b04          	addw	sp,#4
1110  0052 81            	ret	
1111  0053               L315:
1114  0053 2641          	jrne	L515
1117  0055 1e03          	ldw	x,(OFST+1,sp)
1118  0057 1c0022        	addw	x,#34
1119  005a cd0000        	call	_mqtt_mq_clean
1123  005d 1e14          	ldw	x,(OFST+18,sp)
1124  005f 89            	pushw	x
1125  0060 7b15          	ld	a,(OFST+19,sp)
1126  0062 88            	push	a
1127  0063 1e14          	ldw	x,(OFST+18,sp)
1128  0065 89            	pushw	x
1129  0066 1e14          	ldw	x,(OFST+18,sp)
1130  0068 89            	pushw	x
1131  0069 1e14          	ldw	x,(OFST+18,sp)
1132  006b 89            	pushw	x
1133  006c 1e14          	ldw	x,(OFST+18,sp)
1134  006e 89            	pushw	x
1135  006f 1e14          	ldw	x,(OFST+18,sp)
1136  0071 89            	pushw	x
1137  0072 1e14          	ldw	x,(OFST+18,sp)
1138  0074 89            	pushw	x
1139  0075 1e12          	ldw	x,(OFST+16,sp)
1140  0077 ee28          	ldw	x,(40,x)
1141  0079 89            	pushw	x
1142  007a 1e14          	ldw	x,(OFST+18,sp)
1143  007c ee26          	ldw	x,(38,x)
1144  007e cd0000        	call	_mqtt_pack_connection_request
1146  0081 5b11          	addw	sp,#17
1147  0083 1f01          	ldw	(OFST-1,sp),x
1154  0085 2bc2          	jrmi	LC001
1157  0087 260d          	jrne	L515
1160  0089 1e03          	ldw	x,(OFST+1,sp)
1161  008b 90ae8010      	ldw	y,#32784
1162  008f ef0a          	ldw	(10,x),y
1165  0091 ae8010        	ldw	x,#32784
1167  0094 20ba          	jra	L63
1168  0096               L515:
1171  0096 89            	pushw	x
1172  0097 1e05          	ldw	x,(OFST+3,sp)
1173  0099 1c0022        	addw	x,#34
1174  009c cd0000        	call	_mqtt_mq_register
1176  009f 5b02          	addw	sp,#2
1178                     ; 266     msg->control_type = MQTT_CONTROL_CONNECT;
1181  00a1 a601          	ld	a,#1
1182  00a3 e709          	ld	(9,x),a
1183                     ; 268     return MQTT_OK;
1185  00a5 ae0001        	ldw	x,#1
1187  00a8 20a6          	jra	L63
1290                     ; 272 int16_t mqtt_publish(struct mqtt_client *client,
1290                     ; 273                      const char* topic_name,
1290                     ; 274                      const void* application_message,
1290                     ; 275                      uint16_t application_message_size,
1290                     ; 276                      uint8_t publish_flags)
1290                     ; 277 {
1291                     .text:	section	.text,new
1292  0000               _mqtt_publish:
1294  0000 89            	pushw	x
1295  0001 5204          	subw	sp,#4
1296       00000004      OFST:	set	4
1299                     ; 281     packet_id = __mqtt_next_pid(client);
1301  0003 cd0000        	call	___mqtt_next_pid
1303  0006 1f01          	ldw	(OFST-3,sp),x
1305                     ; 284     MQTT_CLIENT_TRY_PACK(
1307  0008 1e05          	ldw	x,(OFST+1,sp)
1308  000a e60a          	ld	a,(10,x)
1309  000c 2a04          	jrpl	L575
1312  000e ee0a          	ldw	x,(10,x)
1314  0010 2028          	jra	L45
1315  0012               L575:
1318  0012 7b0f          	ld	a,(OFST+11,sp)
1319  0014 88            	push	a
1320  0015 1e0e          	ldw	x,(OFST+10,sp)
1321  0017 89            	pushw	x
1322  0018 1e0e          	ldw	x,(OFST+10,sp)
1323  001a 89            	pushw	x
1324  001b 1e06          	ldw	x,(OFST+2,sp)
1325  001d 89            	pushw	x
1326  001e 1e10          	ldw	x,(OFST+12,sp)
1327  0020 89            	pushw	x
1328  0021 1e0e          	ldw	x,(OFST+10,sp)
1329  0023 ee28          	ldw	x,(40,x)
1330  0025 89            	pushw	x
1331  0026 1e10          	ldw	x,(OFST+12,sp)
1332  0028 ee26          	ldw	x,(38,x)
1333  002a cd0000        	call	_mqtt_pack_publish_request
1335  002d 5b0b          	addw	sp,#11
1336  002f 1f03          	ldw	(OFST-1,sp),x
1340  0031 2a0a          	jrpl	L775
1345  0033               LC002:
1347  0033 1e05          	ldw	x,(OFST+1,sp)
1348  0035 1603          	ldw	y,(OFST-1,sp)
1349  0037 ef0a          	ldw	(10,x),y
1351  0039 93            	ldw	x,y
1353  003a               L45:
1355  003a 5b06          	addw	sp,#6
1356  003c 81            	ret	
1357  003d               L775:
1360  003d 2638          	jrne	L106
1363  003f 1e05          	ldw	x,(OFST+1,sp)
1364  0041 1c0022        	addw	x,#34
1365  0044 cd0000        	call	_mqtt_mq_clean
1369  0047 7b0f          	ld	a,(OFST+11,sp)
1370  0049 88            	push	a
1371  004a 1e0e          	ldw	x,(OFST+10,sp)
1372  004c 89            	pushw	x
1373  004d 1e0e          	ldw	x,(OFST+10,sp)
1374  004f 89            	pushw	x
1375  0050 1e06          	ldw	x,(OFST+2,sp)
1376  0052 89            	pushw	x
1377  0053 1e10          	ldw	x,(OFST+12,sp)
1378  0055 89            	pushw	x
1379  0056 1e0e          	ldw	x,(OFST+10,sp)
1380  0058 ee28          	ldw	x,(40,x)
1381  005a 89            	pushw	x
1382  005b 1e10          	ldw	x,(OFST+12,sp)
1383  005d ee26          	ldw	x,(38,x)
1384  005f cd0000        	call	_mqtt_pack_publish_request
1386  0062 5b0b          	addw	sp,#11
1387  0064 1f03          	ldw	(OFST-1,sp),x
1394  0066 2bcb          	jrmi	LC002
1397  0068 260d          	jrne	L106
1400  006a 1e05          	ldw	x,(OFST+1,sp)
1401  006c 90ae8010      	ldw	y,#32784
1402  0070 ef0a          	ldw	(10,x),y
1405  0072 ae8010        	ldw	x,#32784
1407  0075 20c3          	jra	L45
1408  0077               L106:
1411  0077 89            	pushw	x
1412  0078 1e07          	ldw	x,(OFST+3,sp)
1413  007a 1c0022        	addw	x,#34
1414  007d cd0000        	call	_mqtt_mq_register
1416  0080 5b02          	addw	sp,#2
1417  0082 1f03          	ldw	(OFST-1,sp),x
1419                     ; 298     msg->control_type = MQTT_CONTROL_PUBLISH;
1422  0084 a603          	ld	a,#3
1423  0086 e709          	ld	(9,x),a
1424                     ; 299     msg->packet_id = packet_id;
1426  0088 1601          	ldw	y,(OFST-3,sp)
1427  008a ef0a          	ldw	(10,x),y
1428                     ; 301     return MQTT_OK;
1430  008c ae0001        	ldw	x,#1
1432  008f 20a9          	jra	L45
1498                     ; 305 int16_t __mqtt_puback(struct mqtt_client *client, uint16_t packet_id) {
1499                     .text:	section	.text,new
1500  0000               ___mqtt_puback:
1502  0000 89            	pushw	x
1503  0001 89            	pushw	x
1504       00000002      OFST:	set	2
1507                     ; 310     MQTT_CLIENT_TRY_PACK(
1509  0002 e60a          	ld	a,(10,x)
1510  0004 2a04          	jrpl	L546
1513  0006 ee0a          	ldw	x,(10,x)
1515  0008 201e          	jra	L07
1516  000a               L546:
1519  000a 1e07          	ldw	x,(OFST+5,sp)
1520  000c 89            	pushw	x
1521  000d 4b04          	push	#4
1522  000f 1e06          	ldw	x,(OFST+4,sp)
1523  0011 ee28          	ldw	x,(40,x)
1524  0013 89            	pushw	x
1525  0014 1e08          	ldw	x,(OFST+6,sp)
1526  0016 ee26          	ldw	x,(38,x)
1527  0018 cd0000        	call	_mqtt_pack_pubxxx_request
1529  001b 5b05          	addw	sp,#5
1530  001d 1f01          	ldw	(OFST-1,sp),x
1534  001f 2a0a          	jrpl	L746
1539  0021               LC003:
1541  0021 1e03          	ldw	x,(OFST+1,sp)
1542  0023 1601          	ldw	y,(OFST-1,sp)
1543  0025 ef0a          	ldw	(10,x),y
1545  0027 93            	ldw	x,y
1547  0028               L07:
1549  0028 5b04          	addw	sp,#4
1550  002a 81            	ret	
1551  002b               L746:
1554  002b 262e          	jrne	L156
1557  002d 1e03          	ldw	x,(OFST+1,sp)
1558  002f 1c0022        	addw	x,#34
1559  0032 cd0000        	call	_mqtt_mq_clean
1563  0035 1e07          	ldw	x,(OFST+5,sp)
1564  0037 89            	pushw	x
1565  0038 4b04          	push	#4
1566  003a 1e06          	ldw	x,(OFST+4,sp)
1567  003c ee28          	ldw	x,(40,x)
1568  003e 89            	pushw	x
1569  003f 1e08          	ldw	x,(OFST+6,sp)
1570  0041 ee26          	ldw	x,(38,x)
1571  0043 cd0000        	call	_mqtt_pack_pubxxx_request
1573  0046 5b05          	addw	sp,#5
1574  0048 1f01          	ldw	(OFST-1,sp),x
1581  004a 2bd5          	jrmi	LC003
1584  004c 260d          	jrne	L156
1587  004e 1e03          	ldw	x,(OFST+1,sp)
1588  0050 90ae8010      	ldw	y,#32784
1589  0054 ef0a          	ldw	(10,x),y
1592  0056 ae8010        	ldw	x,#32784
1594  0059 20cd          	jra	L07
1595  005b               L156:
1598  005b 89            	pushw	x
1599  005c 1e05          	ldw	x,(OFST+3,sp)
1600  005e 1c0022        	addw	x,#34
1601  0061 cd0000        	call	_mqtt_mq_register
1603  0064 5b02          	addw	sp,#2
1604  0066 1f01          	ldw	(OFST-1,sp),x
1606                     ; 321     msg->control_type = MQTT_CONTROL_PUBACK;
1609  0068 a604          	ld	a,#4
1610  006a e709          	ld	(9,x),a
1611                     ; 322     msg->packet_id = packet_id;
1613  006c 1607          	ldw	y,(OFST+5,sp)
1614  006e ef0a          	ldw	(10,x),y
1615                     ; 324     return MQTT_OK;
1617  0070 ae0001        	ldw	x,#1
1619  0073 20b3          	jra	L07
1685                     ; 328 int16_t __mqtt_pubrec(struct mqtt_client *client, uint16_t packet_id)
1685                     ; 329 {
1686                     .text:	section	.text,new
1687  0000               ___mqtt_pubrec:
1689  0000 89            	pushw	x
1690  0001 89            	pushw	x
1691       00000002      OFST:	set	2
1694                     ; 334     MQTT_CLIENT_TRY_PACK(
1696  0002 e60a          	ld	a,(10,x)
1697  0004 2a04          	jrpl	L517
1700  0006 ee0a          	ldw	x,(10,x)
1702  0008 201e          	jra	L401
1703  000a               L517:
1706  000a 1e07          	ldw	x,(OFST+5,sp)
1707  000c 89            	pushw	x
1708  000d 4b05          	push	#5
1709  000f 1e06          	ldw	x,(OFST+4,sp)
1710  0011 ee28          	ldw	x,(40,x)
1711  0013 89            	pushw	x
1712  0014 1e08          	ldw	x,(OFST+6,sp)
1713  0016 ee26          	ldw	x,(38,x)
1714  0018 cd0000        	call	_mqtt_pack_pubxxx_request
1716  001b 5b05          	addw	sp,#5
1717  001d 1f01          	ldw	(OFST-1,sp),x
1721  001f 2a0a          	jrpl	L717
1726  0021               LC004:
1728  0021 1e03          	ldw	x,(OFST+1,sp)
1729  0023 1601          	ldw	y,(OFST-1,sp)
1730  0025 ef0a          	ldw	(10,x),y
1732  0027 93            	ldw	x,y
1734  0028               L401:
1736  0028 5b04          	addw	sp,#4
1737  002a 81            	ret	
1738  002b               L717:
1741  002b 262e          	jrne	L127
1744  002d 1e03          	ldw	x,(OFST+1,sp)
1745  002f 1c0022        	addw	x,#34
1746  0032 cd0000        	call	_mqtt_mq_clean
1750  0035 1e07          	ldw	x,(OFST+5,sp)
1751  0037 89            	pushw	x
1752  0038 4b05          	push	#5
1753  003a 1e06          	ldw	x,(OFST+4,sp)
1754  003c ee28          	ldw	x,(40,x)
1755  003e 89            	pushw	x
1756  003f 1e08          	ldw	x,(OFST+6,sp)
1757  0041 ee26          	ldw	x,(38,x)
1758  0043 cd0000        	call	_mqtt_pack_pubxxx_request
1760  0046 5b05          	addw	sp,#5
1761  0048 1f01          	ldw	(OFST-1,sp),x
1768  004a 2bd5          	jrmi	LC004
1771  004c 260d          	jrne	L127
1774  004e 1e03          	ldw	x,(OFST+1,sp)
1775  0050 90ae8010      	ldw	y,#32784
1776  0054 ef0a          	ldw	(10,x),y
1779  0056 ae8010        	ldw	x,#32784
1781  0059 20cd          	jra	L401
1782  005b               L127:
1785  005b 89            	pushw	x
1786  005c 1e05          	ldw	x,(OFST+3,sp)
1787  005e 1c0022        	addw	x,#34
1788  0061 cd0000        	call	_mqtt_mq_register
1790  0064 5b02          	addw	sp,#2
1791  0066 1f01          	ldw	(OFST-1,sp),x
1793                     ; 345     msg->control_type = MQTT_CONTROL_PUBREC;
1796  0068 a605          	ld	a,#5
1797  006a e709          	ld	(9,x),a
1798                     ; 346     msg->packet_id = packet_id;
1800  006c 1607          	ldw	y,(OFST+5,sp)
1801  006e ef0a          	ldw	(10,x),y
1802                     ; 348     return MQTT_OK;
1804  0070 ae0001        	ldw	x,#1
1806  0073 20b3          	jra	L401
1872                     ; 352 int16_t __mqtt_pubrel(struct mqtt_client *client, uint16_t packet_id)
1872                     ; 353 {
1873                     .text:	section	.text,new
1874  0000               ___mqtt_pubrel:
1876  0000 89            	pushw	x
1877  0001 89            	pushw	x
1878       00000002      OFST:	set	2
1881                     ; 358     MQTT_CLIENT_TRY_PACK(
1883  0002 e60a          	ld	a,(10,x)
1884  0004 2a04          	jrpl	L567
1887  0006 ee0a          	ldw	x,(10,x)
1889  0008 201e          	jra	L021
1890  000a               L567:
1893  000a 1e07          	ldw	x,(OFST+5,sp)
1894  000c 89            	pushw	x
1895  000d 4b06          	push	#6
1896  000f 1e06          	ldw	x,(OFST+4,sp)
1897  0011 ee28          	ldw	x,(40,x)
1898  0013 89            	pushw	x
1899  0014 1e08          	ldw	x,(OFST+6,sp)
1900  0016 ee26          	ldw	x,(38,x)
1901  0018 cd0000        	call	_mqtt_pack_pubxxx_request
1903  001b 5b05          	addw	sp,#5
1904  001d 1f01          	ldw	(OFST-1,sp),x
1908  001f 2a0a          	jrpl	L767
1913  0021               LC005:
1915  0021 1e03          	ldw	x,(OFST+1,sp)
1916  0023 1601          	ldw	y,(OFST-1,sp)
1917  0025 ef0a          	ldw	(10,x),y
1919  0027 93            	ldw	x,y
1921  0028               L021:
1923  0028 5b04          	addw	sp,#4
1924  002a 81            	ret	
1925  002b               L767:
1928  002b 262e          	jrne	L177
1931  002d 1e03          	ldw	x,(OFST+1,sp)
1932  002f 1c0022        	addw	x,#34
1933  0032 cd0000        	call	_mqtt_mq_clean
1937  0035 1e07          	ldw	x,(OFST+5,sp)
1938  0037 89            	pushw	x
1939  0038 4b06          	push	#6
1940  003a 1e06          	ldw	x,(OFST+4,sp)
1941  003c ee28          	ldw	x,(40,x)
1942  003e 89            	pushw	x
1943  003f 1e08          	ldw	x,(OFST+6,sp)
1944  0041 ee26          	ldw	x,(38,x)
1945  0043 cd0000        	call	_mqtt_pack_pubxxx_request
1947  0046 5b05          	addw	sp,#5
1948  0048 1f01          	ldw	(OFST-1,sp),x
1955  004a 2bd5          	jrmi	LC005
1958  004c 260d          	jrne	L177
1961  004e 1e03          	ldw	x,(OFST+1,sp)
1962  0050 90ae8010      	ldw	y,#32784
1963  0054 ef0a          	ldw	(10,x),y
1966  0056 ae8010        	ldw	x,#32784
1968  0059 20cd          	jra	L021
1969  005b               L177:
1972  005b 89            	pushw	x
1973  005c 1e05          	ldw	x,(OFST+3,sp)
1974  005e 1c0022        	addw	x,#34
1975  0061 cd0000        	call	_mqtt_mq_register
1977  0064 5b02          	addw	sp,#2
1978  0066 1f01          	ldw	(OFST-1,sp),x
1980                     ; 369     msg->control_type = MQTT_CONTROL_PUBREL;
1983  0068 a606          	ld	a,#6
1984  006a e709          	ld	(9,x),a
1985                     ; 370     msg->packet_id = packet_id;
1987  006c 1607          	ldw	y,(OFST+5,sp)
1988  006e ef0a          	ldw	(10,x),y
1989                     ; 372     return MQTT_OK;
1991  0070 ae0001        	ldw	x,#1
1993  0073 20b3          	jra	L021
2059                     ; 376 int16_t __mqtt_pubcomp(struct mqtt_client *client, uint16_t packet_id)
2059                     ; 377 {
2060                     .text:	section	.text,new
2061  0000               ___mqtt_pubcomp:
2063  0000 89            	pushw	x
2064  0001 89            	pushw	x
2065       00000002      OFST:	set	2
2068                     ; 382     MQTT_CLIENT_TRY_PACK(
2070  0002 e60a          	ld	a,(10,x)
2071  0004 2a04          	jrpl	L5301
2074  0006 ee0a          	ldw	x,(10,x)
2076  0008 201e          	jra	L431
2077  000a               L5301:
2080  000a 1e07          	ldw	x,(OFST+5,sp)
2081  000c 89            	pushw	x
2082  000d 4b07          	push	#7
2083  000f 1e06          	ldw	x,(OFST+4,sp)
2084  0011 ee28          	ldw	x,(40,x)
2085  0013 89            	pushw	x
2086  0014 1e08          	ldw	x,(OFST+6,sp)
2087  0016 ee26          	ldw	x,(38,x)
2088  0018 cd0000        	call	_mqtt_pack_pubxxx_request
2090  001b 5b05          	addw	sp,#5
2091  001d 1f01          	ldw	(OFST-1,sp),x
2095  001f 2a0a          	jrpl	L7301
2100  0021               LC006:
2102  0021 1e03          	ldw	x,(OFST+1,sp)
2103  0023 1601          	ldw	y,(OFST-1,sp)
2104  0025 ef0a          	ldw	(10,x),y
2106  0027 93            	ldw	x,y
2108  0028               L431:
2110  0028 5b04          	addw	sp,#4
2111  002a 81            	ret	
2112  002b               L7301:
2115  002b 262e          	jrne	L1401
2118  002d 1e03          	ldw	x,(OFST+1,sp)
2119  002f 1c0022        	addw	x,#34
2120  0032 cd0000        	call	_mqtt_mq_clean
2124  0035 1e07          	ldw	x,(OFST+5,sp)
2125  0037 89            	pushw	x
2126  0038 4b07          	push	#7
2127  003a 1e06          	ldw	x,(OFST+4,sp)
2128  003c ee28          	ldw	x,(40,x)
2129  003e 89            	pushw	x
2130  003f 1e08          	ldw	x,(OFST+6,sp)
2131  0041 ee26          	ldw	x,(38,x)
2132  0043 cd0000        	call	_mqtt_pack_pubxxx_request
2134  0046 5b05          	addw	sp,#5
2135  0048 1f01          	ldw	(OFST-1,sp),x
2142  004a 2bd5          	jrmi	LC006
2145  004c 260d          	jrne	L1401
2148  004e 1e03          	ldw	x,(OFST+1,sp)
2149  0050 90ae8010      	ldw	y,#32784
2150  0054 ef0a          	ldw	(10,x),y
2153  0056 ae8010        	ldw	x,#32784
2155  0059 20cd          	jra	L431
2156  005b               L1401:
2159  005b 89            	pushw	x
2160  005c 1e05          	ldw	x,(OFST+3,sp)
2161  005e 1c0022        	addw	x,#34
2162  0061 cd0000        	call	_mqtt_mq_register
2164  0064 5b02          	addw	sp,#2
2165  0066 1f01          	ldw	(OFST-1,sp),x
2167                     ; 393     msg->control_type = MQTT_CONTROL_PUBCOMP;
2170  0068 a607          	ld	a,#7
2171  006a e709          	ld	(9,x),a
2172                     ; 394     msg->packet_id = packet_id;
2174  006c 1607          	ldw	y,(OFST+5,sp)
2175  006e ef0a          	ldw	(10,x),y
2176                     ; 396     return MQTT_OK;
2178  0070 ae0001        	ldw	x,#1
2180  0073 20b3          	jra	L431
2264                     ; 400 int16_t mqtt_subscribe(struct mqtt_client *client,
2264                     ; 401                        const char* topic_name,
2264                     ; 402                        int16_t max_qos_level)
2264                     ; 403 {
2265                     .text:	section	.text,new
2266  0000               _mqtt_subscribe:
2268  0000 89            	pushw	x
2269  0001 5204          	subw	sp,#4
2270       00000004      OFST:	set	4
2273                     ; 407     packet_id = __mqtt_next_pid(client);
2275  0003 cd0000        	call	___mqtt_next_pid
2277  0006 1f01          	ldw	(OFST-3,sp),x
2279                     ; 410     MQTT_CLIENT_TRY_PACK(
2281  0008 1e05          	ldw	x,(OFST+1,sp)
2282  000a e60a          	ld	a,(10,x)
2283  000c 2a04          	jrpl	L3111
2286  000e ee0a          	ldw	x,(10,x)
2288  0010 2024          	jra	L251
2289  0012               L3111:
2292  0012 5f            	clrw	x
2293  0013 89            	pushw	x
2294  0014 1e0d          	ldw	x,(OFST+9,sp)
2295  0016 89            	pushw	x
2296  0017 1e0d          	ldw	x,(OFST+9,sp)
2297  0019 89            	pushw	x
2298  001a 1e07          	ldw	x,(OFST+3,sp)
2299  001c 89            	pushw	x
2300  001d 1e0d          	ldw	x,(OFST+9,sp)
2301  001f ee28          	ldw	x,(40,x)
2302  0021 89            	pushw	x
2303  0022 1e0f          	ldw	x,(OFST+11,sp)
2304  0024 ee26          	ldw	x,(38,x)
2305  0026 cd0000        	call	_mqtt_pack_subscribe_request
2307  0029 5b0a          	addw	sp,#10
2308  002b 1f03          	ldw	(OFST-1,sp),x
2312  002d 2a0a          	jrpl	L5111
2317  002f               LC007:
2319  002f 1e05          	ldw	x,(OFST+1,sp)
2320  0031 1603          	ldw	y,(OFST-1,sp)
2321  0033 ef0a          	ldw	(10,x),y
2323  0035 93            	ldw	x,y
2325  0036               L251:
2327  0036 5b06          	addw	sp,#6
2328  0038 81            	ret	
2329  0039               L5111:
2332  0039 2634          	jrne	L7111
2335  003b 1e05          	ldw	x,(OFST+1,sp)
2336  003d 1c0022        	addw	x,#34
2337  0040 cd0000        	call	_mqtt_mq_clean
2341  0043 5f            	clrw	x
2342  0044 89            	pushw	x
2343  0045 1e0d          	ldw	x,(OFST+9,sp)
2344  0047 89            	pushw	x
2345  0048 1e0d          	ldw	x,(OFST+9,sp)
2346  004a 89            	pushw	x
2347  004b 1e07          	ldw	x,(OFST+3,sp)
2348  004d 89            	pushw	x
2349  004e 1e0d          	ldw	x,(OFST+9,sp)
2350  0050 ee28          	ldw	x,(40,x)
2351  0052 89            	pushw	x
2352  0053 1e0f          	ldw	x,(OFST+11,sp)
2353  0055 ee26          	ldw	x,(38,x)
2354  0057 cd0000        	call	_mqtt_pack_subscribe_request
2356  005a 5b0a          	addw	sp,#10
2357  005c 1f03          	ldw	(OFST-1,sp),x
2364  005e 2bcf          	jrmi	LC007
2367  0060 260d          	jrne	L7111
2370  0062 1e05          	ldw	x,(OFST+1,sp)
2371  0064 90ae8010      	ldw	y,#32784
2372  0068 ef0a          	ldw	(10,x),y
2375  006a ae8010        	ldw	x,#32784
2377  006d 20c7          	jra	L251
2378  006f               L7111:
2381  006f 89            	pushw	x
2382  0070 1e07          	ldw	x,(OFST+3,sp)
2383  0072 1c0022        	addw	x,#34
2384  0075 cd0000        	call	_mqtt_mq_register
2386  0078 5b02          	addw	sp,#2
2387  007a 1f03          	ldw	(OFST-1,sp),x
2389                     ; 423     msg->control_type = MQTT_CONTROL_SUBSCRIBE;
2392  007c a608          	ld	a,#8
2393  007e e709          	ld	(9,x),a
2394                     ; 424     msg->packet_id = packet_id;
2396  0080 1601          	ldw	y,(OFST-3,sp)
2397  0082 ef0a          	ldw	(10,x),y
2398                     ; 425     return MQTT_OK;
2400  0084 ae0001        	ldw	x,#1
2402  0087 20ad          	jra	L251
2479                     ; 429 int16_t mqtt_unsubscribe(struct mqtt_client *client,
2479                     ; 430                          const char* topic_name)
2479                     ; 431 {
2480                     .text:	section	.text,new
2481  0000               _mqtt_unsubscribe:
2483  0000 89            	pushw	x
2484  0001 5204          	subw	sp,#4
2485       00000004      OFST:	set	4
2488                     ; 432     uint16_t packet_id = __mqtt_next_pid(client);
2490  0003 cd0000        	call	___mqtt_next_pid
2492  0006 1f01          	ldw	(OFST-3,sp),x
2494                     ; 437     MQTT_CLIENT_TRY_PACK(
2496  0008 1e05          	ldw	x,(OFST+1,sp)
2497  000a e60a          	ld	a,(10,x)
2498  000c 2a04          	jrpl	L7611
2501  000e ee0a          	ldw	x,(10,x)
2503  0010 2021          	jra	L071
2504  0012               L7611:
2507  0012 5f            	clrw	x
2508  0013 89            	pushw	x
2509  0014 1e0b          	ldw	x,(OFST+7,sp)
2510  0016 89            	pushw	x
2511  0017 1e05          	ldw	x,(OFST+1,sp)
2512  0019 89            	pushw	x
2513  001a 1e0b          	ldw	x,(OFST+7,sp)
2514  001c ee28          	ldw	x,(40,x)
2515  001e 89            	pushw	x
2516  001f 1e0d          	ldw	x,(OFST+9,sp)
2517  0021 ee26          	ldw	x,(38,x)
2518  0023 cd0000        	call	_mqtt_pack_unsubscribe_request
2520  0026 5b08          	addw	sp,#8
2521  0028 1f03          	ldw	(OFST-1,sp),x
2525  002a 2a0a          	jrpl	L1711
2530  002c               LC008:
2532  002c 1e05          	ldw	x,(OFST+1,sp)
2533  002e 1603          	ldw	y,(OFST-1,sp)
2534  0030 ef0a          	ldw	(10,x),y
2536  0032 93            	ldw	x,y
2538  0033               L071:
2540  0033 5b06          	addw	sp,#6
2541  0035 81            	ret	
2542  0036               L1711:
2545  0036 2631          	jrne	L3711
2548  0038 1e05          	ldw	x,(OFST+1,sp)
2549  003a 1c0022        	addw	x,#34
2550  003d cd0000        	call	_mqtt_mq_clean
2554  0040 5f            	clrw	x
2555  0041 89            	pushw	x
2556  0042 1e0b          	ldw	x,(OFST+7,sp)
2557  0044 89            	pushw	x
2558  0045 1e05          	ldw	x,(OFST+1,sp)
2559  0047 89            	pushw	x
2560  0048 1e0b          	ldw	x,(OFST+7,sp)
2561  004a ee28          	ldw	x,(40,x)
2562  004c 89            	pushw	x
2563  004d 1e0d          	ldw	x,(OFST+9,sp)
2564  004f ee26          	ldw	x,(38,x)
2565  0051 cd0000        	call	_mqtt_pack_unsubscribe_request
2567  0054 5b08          	addw	sp,#8
2568  0056 1f03          	ldw	(OFST-1,sp),x
2575  0058 2bd2          	jrmi	LC008
2578  005a 260d          	jrne	L3711
2581  005c 1e05          	ldw	x,(OFST+1,sp)
2582  005e 90ae8010      	ldw	y,#32784
2583  0062 ef0a          	ldw	(10,x),y
2586  0064 ae8010        	ldw	x,#32784
2588  0067 20ca          	jra	L071
2589  0069               L3711:
2592  0069 89            	pushw	x
2593  006a 1e07          	ldw	x,(OFST+3,sp)
2594  006c 1c0022        	addw	x,#34
2595  006f cd0000        	call	_mqtt_mq_register
2597  0072 5b02          	addw	sp,#2
2598  0074 1f03          	ldw	(OFST-1,sp),x
2600                     ; 449     msg->control_type = MQTT_CONTROL_UNSUBSCRIBE;
2603  0076 a60a          	ld	a,#10
2604  0078 e709          	ld	(9,x),a
2605                     ; 450     msg->packet_id = packet_id;
2607  007a 1601          	ldw	y,(OFST-3,sp)
2608  007c ef0a          	ldw	(10,x),y
2609                     ; 452     return MQTT_OK;
2611  007e ae0001        	ldw	x,#1
2613  0081 20b0          	jra	L071
2658                     ; 456 int16_t mqtt_ping(struct mqtt_client *client)
2658                     ; 457 {
2659                     .text:	section	.text,new
2660  0000               _mqtt_ping:
2662  0000 89            	pushw	x
2663       00000002      OFST:	set	2
2666                     ; 459     rv = __mqtt_ping(client);
2668  0001 cd0000        	call	___mqtt_ping
2671                     ; 460     return rv;
2675  0004 5b02          	addw	sp,#2
2676  0006 81            	ret	
2735                     ; 464 int16_t __mqtt_ping(struct mqtt_client *client) 
2735                     ; 465 {
2736                     .text:	section	.text,new
2737  0000               ___mqtt_ping:
2739  0000 89            	pushw	x
2740  0001 89            	pushw	x
2741       00000002      OFST:	set	2
2744                     ; 470     MQTT_CLIENT_TRY_PACK(
2746  0002 e60a          	ld	a,(10,x)
2747  0004 2a04          	jrpl	L7521
2750  0006 ee0a          	ldw	x,(10,x)
2752  0008 2017          	jra	L012
2753  000a               L7521:
2756  000a ee28          	ldw	x,(40,x)
2757  000c 89            	pushw	x
2758  000d 1e05          	ldw	x,(OFST+3,sp)
2759  000f ee26          	ldw	x,(38,x)
2760  0011 cd0000        	call	_mqtt_pack_ping_request
2762  0014 5b02          	addw	sp,#2
2763  0016 1f01          	ldw	(OFST-1,sp),x
2767  0018 2a0a          	jrpl	L1621
2772  001a               LC009:
2774  001a 1e03          	ldw	x,(OFST+1,sp)
2775  001c 1601          	ldw	y,(OFST-1,sp)
2776  001e ef0a          	ldw	(10,x),y
2778  0020 93            	ldw	x,y
2780  0021               L012:
2782  0021 5b04          	addw	sp,#4
2783  0023 81            	ret	
2784  0024               L1621:
2787  0024 2629          	jrne	L3621
2790  0026 1e03          	ldw	x,(OFST+1,sp)
2791  0028 1c0022        	addw	x,#34
2792  002b cd0000        	call	_mqtt_mq_clean
2796  002e 1e03          	ldw	x,(OFST+1,sp)
2797  0030 ee28          	ldw	x,(40,x)
2798  0032 89            	pushw	x
2799  0033 1e05          	ldw	x,(OFST+3,sp)
2800  0035 ee26          	ldw	x,(38,x)
2801  0037 cd0000        	call	_mqtt_pack_ping_request
2803  003a 5b02          	addw	sp,#2
2804  003c 1f01          	ldw	(OFST-1,sp),x
2811  003e 2bda          	jrmi	LC009
2814  0040 260d          	jrne	L3621
2817  0042 1e03          	ldw	x,(OFST+1,sp)
2818  0044 90ae8010      	ldw	y,#32784
2819  0048 ef0a          	ldw	(10,x),y
2822  004a ae8010        	ldw	x,#32784
2824  004d 20d2          	jra	L012
2825  004f               L3621:
2828  004f 89            	pushw	x
2829  0050 1e05          	ldw	x,(OFST+3,sp)
2830  0052 1c0022        	addw	x,#34
2831  0055 cd0000        	call	_mqtt_mq_register
2833  0058 5b02          	addw	sp,#2
2835                     ; 479     msg->control_type = MQTT_CONTROL_PINGREQ;
2838  005a a60c          	ld	a,#12
2839  005c e709          	ld	(9,x),a
2840                     ; 481     return MQTT_OK;
2842  005e ae0001        	ldw	x,#1
2844  0061 20be          	jra	L012
2903                     ; 485 int16_t mqtt_disconnect(struct mqtt_client *client) 
2903                     ; 486 {
2904                     .text:	section	.text,new
2905  0000               _mqtt_disconnect:
2907  0000 89            	pushw	x
2908  0001 89            	pushw	x
2909       00000002      OFST:	set	2
2912                     ; 491     MQTT_CLIENT_TRY_PACK(
2914  0002 e60a          	ld	a,(10,x)
2915  0004 2a04          	jrpl	L5231
2918  0006 ee0a          	ldw	x,(10,x)
2920  0008 2017          	jra	L422
2921  000a               L5231:
2924  000a ee28          	ldw	x,(40,x)
2925  000c 89            	pushw	x
2926  000d 1e05          	ldw	x,(OFST+3,sp)
2927  000f ee26          	ldw	x,(38,x)
2928  0011 cd0000        	call	_mqtt_pack_disconnect
2930  0014 5b02          	addw	sp,#2
2931  0016 1f01          	ldw	(OFST-1,sp),x
2935  0018 2a0a          	jrpl	L7231
2940  001a               LC010:
2942  001a 1e03          	ldw	x,(OFST+1,sp)
2943  001c 1601          	ldw	y,(OFST-1,sp)
2944  001e ef0a          	ldw	(10,x),y
2946  0020 93            	ldw	x,y
2948  0021               L422:
2950  0021 5b04          	addw	sp,#4
2951  0023 81            	ret	
2952  0024               L7231:
2955  0024 2629          	jrne	L1331
2958  0026 1e03          	ldw	x,(OFST+1,sp)
2959  0028 1c0022        	addw	x,#34
2960  002b cd0000        	call	_mqtt_mq_clean
2964  002e 1e03          	ldw	x,(OFST+1,sp)
2965  0030 ee28          	ldw	x,(40,x)
2966  0032 89            	pushw	x
2967  0033 1e05          	ldw	x,(OFST+3,sp)
2968  0035 ee26          	ldw	x,(38,x)
2969  0037 cd0000        	call	_mqtt_pack_disconnect
2971  003a 5b02          	addw	sp,#2
2972  003c 1f01          	ldw	(OFST-1,sp),x
2979  003e 2bda          	jrmi	LC010
2982  0040 260d          	jrne	L1331
2985  0042 1e03          	ldw	x,(OFST+1,sp)
2986  0044 90ae8010      	ldw	y,#32784
2987  0048 ef0a          	ldw	(10,x),y
2990  004a ae8010        	ldw	x,#32784
2992  004d 20d2          	jra	L422
2993  004f               L1331:
2996  004f 89            	pushw	x
2997  0050 1e05          	ldw	x,(OFST+3,sp)
2998  0052 1c0022        	addw	x,#34
2999  0055 cd0000        	call	_mqtt_mq_register
3001  0058 5b02          	addw	sp,#2
3003                     ; 500     msg->control_type = MQTT_CONTROL_DISCONNECT;
3006  005a a60e          	ld	a,#14
3007  005c e709          	ld	(9,x),a
3008                     ; 502     return MQTT_OK;
3010  005e ae0001        	ldw	x,#1
3012  0061 20be          	jra	L422
3120                     ; 506 int16_t __mqtt_send(struct mqtt_client *client) 
3120                     ; 507 {
3121                     .text:	section	.text,new
3122  0000               ___mqtt_send:
3124  0000 89            	pushw	x
3125  0001 520d          	subw	sp,#13
3126       0000000d      OFST:	set	13
3129                     ; 510     int16_t inflight_qos2 = 0;
3131  0003 5f            	clrw	x
3132  0004 1f07          	ldw	(OFST-6,sp),x
3134                     ; 511     int16_t i = 0;
3136  0006 1f0b          	ldw	(OFST-2,sp),x
3138                     ; 513     if (client->error < 0 && client->error != MQTT_ERROR_SEND_BUFFER_IS_FULL) {
3140  0008 1e0e          	ldw	x,(OFST+1,sp)
3141  000a 6d0a          	tnz	(10,x)
3142  000c 2a10          	jrpl	L1241
3144  000e 9093          	ldw	y,x
3145  0010 90ee0a        	ldw	y,(10,y)
3146  0013 90a38010      	cpw	y,#32784
3147  0017 2705          	jreq	L1241
3148                     ; 514       return client->error;
3150  0019 ee0a          	ldw	x,(10,x)
3152  001b cc00e3        	jra	L432
3153  001e               L1241:
3154                     ; 518     len = mqtt_mq_length(&client->mq);
3156  001e ee24          	ldw	x,(36,x)
3157  0020 160e          	ldw	y,(OFST+1,sp)
3158  0022 01            	rrwa	x,a
3159  0023 90e02b        	sub	a,(43,y)
3160  0026 01            	rrwa	x,a
3161  0027 90e22a        	sbc	a,(42,y)
3162  002a 01            	rrwa	x,a
3163  002b a60c          	ld	a,#12
3164  002d cd0000        	call	c_sdivx
3166  0030 1f09          	ldw	(OFST-4,sp),x
3169  0032 cc01ce        	jra	L7241
3170  0035               L3241:
3171                     ; 520         struct mqtt_queued_message *msg = mqtt_mq_get(&client->mq, i);
3173  0035 a60c          	ld	a,#12
3174  0037 cd0000        	call	c_bmulx
3176  003a 1f01          	ldw	(OFST-12,sp),x
3178  003c 1e0e          	ldw	x,(OFST+1,sp)
3179  003e ee24          	ldw	x,(36,x)
3180  0040 1d000c        	subw	x,#12
3181  0043 72f001        	subw	x,(OFST-12,sp)
3182  0046 1f05          	ldw	(OFST-8,sp),x
3184                     ; 521         int16_t resend = 0;
3186  0048 5f            	clrw	x
3187  0049 1f03          	ldw	(OFST-10,sp),x
3189                     ; 522         if (msg->state == MQTT_QUEUED_UNSENT) {
3191  004b 1e05          	ldw	x,(OFST-8,sp)
3192  004d e604          	ld	a,(4,x)
3193  004f 2607          	jrne	L3341
3194                     ; 524             resend = 1;
3196  0051 ae0001        	ldw	x,#1
3197  0054 1f03          	ldw	(OFST-10,sp),x
3200  0056 202f          	jra	L5341
3201  0058               L3341:
3202                     ; 526 	else if (msg->state == MQTT_QUEUED_AWAITING_ACK) {
3204  0058 4a            	dec	a
3205  0059 262c          	jrne	L5341
3206                     ; 528             if (second_counter > msg->time_sent + client->response_timeout) {
3208  005b 1e0e          	ldw	x,(OFST+1,sp)
3209  005d ee0c          	ldw	x,(12,x)
3210  005f cd0000        	call	c_itolx
3212  0062 1e05          	ldw	x,(OFST-8,sp)
3213  0064 1c0005        	addw	x,#5
3214  0067 cd0000        	call	c_ladd
3216  006a ae0000        	ldw	x,#_second_counter
3217  006d cd0000        	call	c_lcmp
3219  0070 2415          	jruge	L5341
3220                     ; 529                 resend = 1;
3222  0072 ae0001        	ldw	x,#1
3223  0075 1f03          	ldw	(OFST-10,sp),x
3225                     ; 530                 client->number_of_timeouts += 1;
3227  0077 1e0e          	ldw	x,(OFST+1,sp)
3228  0079 9093          	ldw	y,x
3229  007b ee0e          	ldw	x,(14,x)
3230  007d 5c            	incw	x
3231  007e 90ef0e        	ldw	(14,y),x
3232                     ; 531                 client->send_offset = 0;
3234  0081 1e0e          	ldw	x,(OFST+1,sp)
3235  0083 905f          	clrw	y
3236  0085 ef04          	ldw	(4,x),y
3237  0087               L5341:
3238                     ; 536         if (msg->control_type == MQTT_CONTROL_PUBLISH
3238                     ; 537             && (msg->state == MQTT_QUEUED_UNSENT || msg->state == MQTT_QUEUED_AWAITING_ACK)) 
3240  0087 1e05          	ldw	x,(OFST-8,sp)
3241  0089 e609          	ld	a,(9,x)
3242  008b a103          	cp	a,#3
3243  008d 261f          	jrne	L3441
3245  008f e604          	ld	a,(4,x)
3246  0091 2704          	jreq	L5441
3248  0093 a101          	cp	a,#1
3249  0095 2617          	jrne	L3441
3250  0097               L5441:
3251                     ; 539             inspected = (uint8_t)(0x03 & ((msg->start[0]) >> 1)); // qos
3253  0097 fe            	ldw	x,(x)
3254  0098 f6            	ld	a,(x)
3255  0099 a406          	and	a,#6
3256  009b 44            	srl	a
3257  009c 6b0d          	ld	(OFST+0,sp),a
3259                     ; 540             if (inspected == 2) {
3261  009e a102          	cp	a,#2
3262  00a0 260c          	jrne	L3441
3263                     ; 541                 if (inflight_qos2) resend = 0;
3265  00a2 1e07          	ldw	x,(OFST-6,sp)
3266  00a4 2703          	jreq	L1541
3269  00a6 5f            	clrw	x
3270  00a7 1f03          	ldw	(OFST-10,sp),x
3272  00a9               L1541:
3273                     ; 542                 inflight_qos2 = 1;
3275  00a9 ae0001        	ldw	x,#1
3276  00ac 1f07          	ldw	(OFST-6,sp),x
3278  00ae               L3441:
3279                     ; 547         if (!resend) continue;
3281  00ae 1e03          	ldw	x,(OFST-10,sp)
3282  00b0 2603cc01a5    	jreq	L5241
3285                     ; 551           int16_t tmp = mqtt_pal_sendall(msg->start + client->send_offset, msg->size - client->send_offset);
3287  00b5 1e05          	ldw	x,(OFST-8,sp)
3288  00b7 160e          	ldw	y,(OFST+1,sp)
3289  00b9 ee02          	ldw	x,(2,x)
3290  00bb 01            	rrwa	x,a
3291  00bc 90e005        	sub	a,(5,y)
3292  00bf 01            	rrwa	x,a
3293  00c0 90e204        	sbc	a,(4,y)
3294  00c3 01            	rrwa	x,a
3295  00c4 89            	pushw	x
3296  00c5 1e10          	ldw	x,(OFST+3,sp)
3297  00c7 1607          	ldw	y,(OFST-6,sp)
3298  00c9 ee04          	ldw	x,(4,x)
3299  00cb 01            	rrwa	x,a
3300  00cc 90eb01        	add	a,(1,y)
3301  00cf 01            	rrwa	x,a
3302  00d0 90f9          	adc	a,(y)
3303  00d2 01            	rrwa	x,a
3304  00d3 cd0000        	call	_mqtt_pal_sendall
3306  00d6 5b02          	addw	sp,#2
3307  00d8 1f03          	ldw	(OFST-10,sp),x
3309                     ; 554           if (tmp < 0) {
3311  00da 2a0a          	jrpl	L5541
3312                     ; 555             client->error = tmp;
3314  00dc 1e0e          	ldw	x,(OFST+1,sp)
3315  00de 1603          	ldw	y,(OFST-10,sp)
3316                     ; 556             return tmp;
3318  00e0               LC014:
3319  00e0 ef0a          	ldw	(10,x),y
3321  00e2 93            	ldw	x,y
3323  00e3               L432:
3325  00e3 5b0f          	addw	sp,#15
3326  00e5 81            	ret	
3327  00e6               L5541:
3328                     ; 559             client->send_offset += tmp;
3330  00e6 1e0e          	ldw	x,(OFST+1,sp)
3331  00e8 9093          	ldw	y,x
3332  00ea ee04          	ldw	x,(4,x)
3333  00ec 72fb03        	addw	x,(OFST-10,sp)
3334  00ef 90ef04        	ldw	(4,y),x
3335                     ; 560             if(client->send_offset < msg->size) {
3337  00f2 1e0e          	ldw	x,(OFST+1,sp)
3338  00f4 1605          	ldw	y,(OFST-8,sp)
3339  00f6 ee04          	ldw	x,(4,x)
3340  00f8 90e302        	cpw	x,(2,y)
3341  00fb 2441          	jruge	L1641
3342                     ; 562               break;
3343  00fd               L1341:
3344                     ; 629         uint32_t keep_alive_timeout = client->time_of_last_send + (uint32_t)((float)(client->keep_alive) * 0.75);
3346  00fd 1e0e          	ldw	x,(OFST+1,sp)
3347  00ff ee02          	ldw	x,(2,x)
3348  0101 cd0000        	call	c_uitof
3350  0104 ae0040        	ldw	x,#L5051
3351  0107 cd0000        	call	c_fmul
3353  010a cd0000        	call	c_ftol
3355  010d 1e0e          	ldw	x,(OFST+1,sp)
3356  010f 1c0006        	addw	x,#6
3357  0112 cd0000        	call	c_ladd
3359  0115 96            	ldw	x,sp
3360  0116 1c0003        	addw	x,#OFST-10
3361  0119 cd0000        	call	c_rtol
3364                     ; 630         if (second_counter > keep_alive_timeout) {
3366  011c ae0000        	ldw	x,#_second_counter
3367  011f cd0000        	call	c_ltor
3369  0122 96            	ldw	x,sp
3370  0123 1c0003        	addw	x,#OFST-10
3371  0126 cd0000        	call	c_lcmp
3373  0129 2203cc01da    	jrule	L1151
3374                     ; 631           int16_t rv = __mqtt_ping(client);
3376  012e 1e0e          	ldw	x,(OFST+1,sp)
3377  0130 cd0000        	call	___mqtt_ping
3379  0133 1f09          	ldw	(OFST-4,sp),x
3381                     ; 632           if (rv != MQTT_OK) {
3383  0135 5a            	decw	x
3384  0136 27f3          	jreq	L1151
3385                     ; 633             client->error = rv;
3387  0138 1e0e          	ldw	x,(OFST+1,sp)
3388  013a 1609          	ldw	y,(OFST-4,sp)
3389                     ; 634             return rv;
3391  013c 20a2          	jp	LC014
3392  013e               L1641:
3393                     ; 567               client->send_offset = 0;
3395  013e 1e0e          	ldw	x,(OFST+1,sp)
3396  0140 905f          	clrw	y
3397  0142 ef04          	ldw	(4,x),y
3398                     ; 573         client->time_of_last_send = second_counter;
3400  0144 c60003        	ld	a,_second_counter+3
3401  0147 e709          	ld	(9,x),a
3402  0149 c60002        	ld	a,_second_counter+2
3403  014c e708          	ld	(8,x),a
3404  014e c60001        	ld	a,_second_counter+1
3405  0151 e707          	ld	(7,x),a
3406  0153 c60000        	ld	a,_second_counter
3407  0156 e706          	ld	(6,x),a
3408                     ; 574         msg->time_sent = client->time_of_last_send;
3410  0158 1605          	ldw	y,(OFST-8,sp)
3411  015a e609          	ld	a,(9,x)
3412  015c 90e708        	ld	(8,y),a
3413  015f e608          	ld	a,(8,x)
3414  0161 90e707        	ld	(7,y),a
3415  0164 e607          	ld	a,(7,x)
3416  0166 90e706        	ld	(6,y),a
3417  0169 e606          	ld	a,(6,x)
3418                     ; 593         switch (msg->control_type) {
3420  016b 93            	ldw	x,y
3421  016c 90e705        	ld	(5,y),a
3422  016f e609          	ld	a,(9,x)
3424                     ; 623             return MQTT_ERROR_MALFORMED_REQUEST;
3425  0171 4a            	dec	a
3426  0172 2756          	jreq	L7431
3427  0174 a002          	sub	a,#2
3428  0176 2734          	jreq	L5431
3429  0178 4a            	dec	a
3430  0179 2726          	jreq	L3431
3431  017b 4a            	dec	a
3432  017c 274c          	jreq	L7431
3433  017e 4a            	dec	a
3434  017f 2749          	jreq	L7431
3435  0181 4a            	dec	a
3436  0182 271d          	jreq	L3431
3437  0184 4a            	dec	a
3438  0185 2743          	jreq	L7431
3439  0187 a002          	sub	a,#2
3440  0189 273f          	jreq	L7431
3441  018b a002          	sub	a,#2
3442  018d 273b          	jreq	L7431
3443  018f a002          	sub	a,#2
3444  0191 270e          	jreq	L3431
3445                     ; 621         default:
3445                     ; 622             client->error = MQTT_ERROR_MALFORMED_REQUEST;
3447  0193 1e0e          	ldw	x,(OFST+1,sp)
3448  0195 90ae8012      	ldw	y,#32786
3449  0199 ef0a          	ldw	(10,x),y
3450                     ; 623             return MQTT_ERROR_MALFORMED_REQUEST;
3452  019b ae8012        	ldw	x,#32786
3454  019e cc00e3        	jra	L432
3455  01a1               L3431:
3456                     ; 594         case MQTT_CONTROL_PUBACK:
3456                     ; 595         case MQTT_CONTROL_PUBCOMP:
3456                     ; 596         case MQTT_CONTROL_DISCONNECT:
3456                     ; 597             msg->state = MQTT_QUEUED_COMPLETE;
3458  01a1 a602          	ld	a,#2
3459  01a3               LC011:
3460  01a3 e704          	ld	(4,x),a
3461                     ; 598             break;
3462  01a5               L5241:
3463                     ; 519     for(; i < len; ++i) {
3465  01a5 1e0b          	ldw	x,(OFST-2,sp)
3466  01a7 5c            	incw	x
3467  01a8 1f0b          	ldw	(OFST-2,sp),x
3469  01aa 2022          	jra	L7241
3470  01ac               L5431:
3471                     ; 599         case MQTT_CONTROL_PUBLISH:
3471                     ; 600             inspected = (uint8_t)(( MQTT_PUBLISH_QOS_MASK & (msg->start[0]) ) >> 1); /* qos */
3473  01ac fe            	ldw	x,(x)
3474  01ad f6            	ld	a,(x)
3475  01ae a406          	and	a,#6
3476  01b0 44            	srl	a
3477  01b1 6b0d          	ld	(OFST+0,sp),a
3479                     ; 601             if (inspected == 0) {
3481  01b3 2604          	jrne	L1741
3482                     ; 602                 msg->state = MQTT_QUEUED_COMPLETE;
3484  01b5 1e05          	ldw	x,(OFST-8,sp)
3486  01b7 20e8          	jp	L3431
3487  01b9               L1741:
3488                     ; 604 	    else if (inspected == 1) {
3490  01b9 4a            	dec	a
3491  01ba 260c          	jrne	L5741
3492                     ; 605                 msg->state = MQTT_QUEUED_AWAITING_ACK;
3494  01bc 1e05          	ldw	x,(OFST-8,sp)
3495  01be 4c            	inc	a
3496  01bf e704          	ld	(4,x),a
3497                     ; 607                 msg->start[0] |= MQTT_PUBLISH_DUP;
3499  01c1 fe            	ldw	x,(x)
3500  01c2 f6            	ld	a,(x)
3501  01c3 aa08          	or	a,#8
3502  01c5 f7            	ld	(x),a
3504  01c6 20dd          	jra	L5241
3505  01c8               L5741:
3506                     ; 610                 msg->state = MQTT_QUEUED_AWAITING_ACK;
3508  01c8 1e05          	ldw	x,(OFST-8,sp)
3509  01ca               L7431:
3510                     ; 613         case MQTT_CONTROL_CONNECT:
3510                     ; 614         case MQTT_CONTROL_PUBREC:
3510                     ; 615         case MQTT_CONTROL_PUBREL:
3510                     ; 616         case MQTT_CONTROL_SUBSCRIBE:
3510                     ; 617         case MQTT_CONTROL_UNSUBSCRIBE:
3510                     ; 618         case MQTT_CONTROL_PINGREQ:
3510                     ; 619             msg->state = MQTT_QUEUED_AWAITING_ACK;
3512  01ca a601          	ld	a,#1
3513                     ; 620             break;
3515  01cc 20d5          	jp	LC011
3516  01ce               L7241:
3517                     ; 519     for(; i < len; ++i) {
3519  01ce 1e0b          	ldw	x,(OFST-2,sp)
3520  01d0 1309          	cpw	x,(OFST-4,sp)
3521  01d2 2e03cc0035    	jrslt	L3241
3522  01d7 cc00fd        	jra	L1341
3523  01da               L1151:
3524                     ; 639     return MQTT_OK;
3526  01da ae0001        	ldw	x,#1
3528  01dd cc00e3        	jra	L432
4080                     ; 643 int16_t __mqtt_recv(struct mqtt_client *client)
4080                     ; 644 {
4081                     .text:	section	.text,new
4082  0000               ___mqtt_recv:
4084  0000 89            	pushw	x
4085  0001 5220          	subw	sp,#32
4086       00000020      OFST:	set	32
4089                     ; 646     int16_t mqtt_recv_ret = MQTT_OK;
4091  0003 ae0001        	ldw	x,#1
4092  0006 1f07          	ldw	(OFST-25,sp),x
4094                     ; 648     struct mqtt_queued_message *msg = NULL;
4096                     ; 656     rv = mqtt_pal_recvall(client->recv_buffer.curr, client->recv_buffer.curr_sz);
4098  0008 1e21          	ldw	x,(OFST+1,sp)
4099  000a ee20          	ldw	x,(32,x)
4100  000c 89            	pushw	x
4101  000d 1e23          	ldw	x,(OFST+3,sp)
4102  000f ee1e          	ldw	x,(30,x)
4103  0011 cd0000        	call	_mqtt_pal_recvall
4105  0014 5b02          	addw	sp,#2
4106  0016 1f1f          	ldw	(OFST-1,sp),x
4108                     ; 658     client->recv_buffer.curr += rv;
4110  0018 1e21          	ldw	x,(OFST+1,sp)
4111  001a 9093          	ldw	y,x
4112  001c ee1e          	ldw	x,(30,x)
4113  001e 72fb1f        	addw	x,(OFST-1,sp)
4114  0021 90ef1e        	ldw	(30,y),x
4115                     ; 659     client->recv_buffer.curr_sz -= rv;
4117  0024 1e21          	ldw	x,(OFST+1,sp)
4118  0026 9093          	ldw	y,x
4119  0028 ee20          	ldw	x,(32,x)
4120  002a 72f01f        	subw	x,(OFST-1,sp)
4121  002d 90ef20        	ldw	(32,y),x
4122                     ; 662     consumed = mqtt_unpack_response(&response, client->recv_buffer.mem_start, client->recv_buffer.curr - client->recv_buffer.mem_start);
4124  0030 1e21          	ldw	x,(OFST+1,sp)
4125  0032 1621          	ldw	y,(OFST+1,sp)
4126  0034 ee1e          	ldw	x,(30,x)
4127  0036 01            	rrwa	x,a
4128  0037 90e01b        	sub	a,(27,y)
4129  003a 01            	rrwa	x,a
4130  003b 90e21a        	sbc	a,(26,y)
4131  003e 01            	rrwa	x,a
4132  003f 89            	pushw	x
4133  0040 1e23          	ldw	x,(OFST+3,sp)
4134  0042 ee1a          	ldw	x,(26,x)
4135  0044 89            	pushw	x
4136  0045 96            	ldw	x,sp
4137  0046 1c000d        	addw	x,#OFST-19
4138  0049 cd0000        	call	_mqtt_unpack_response
4140  004c 5b04          	addw	sp,#4
4141  004e 1f05          	ldw	(OFST-27,sp),x
4143                     ; 664     if (consumed < 0) {
4145  0050 2a09          	jrpl	L7502
4146                     ; 665         client->error = consumed;
4148  0052 1e21          	ldw	x,(OFST+1,sp)
4149  0054 1605          	ldw	y,(OFST-27,sp)
4150  0056 ef0a          	ldw	(10,x),y
4151                     ; 666         return consumed;
4153  0058 93            	ldw	x,y
4155  0059 2013          	jra	L403
4156  005b               L7502:
4157                     ; 668     else if (consumed == 0) {
4159  005b 2619          	jrne	L1602
4160                     ; 674         if (client->recv_buffer.curr_sz == 0) {
4162  005d 1e21          	ldw	x,(OFST+1,sp)
4163  005f e621          	ld	a,(33,x)
4164  0061 ea20          	or	a,(32,x)
4165  0063 260c          	jrne	L5602
4166                     ; 675             client->error = MQTT_ERROR_RECV_BUFFER_TOO_SMALL;
4168  0065 90ae8013      	ldw	y,#32787
4169  0069 ef0a          	ldw	(10,x),y
4170                     ; 676             return MQTT_ERROR_RECV_BUFFER_TOO_SMALL;
4172  006b ae8013        	ldw	x,#32787
4174  006e               L403:
4176  006e 5b22          	addw	sp,#34
4177  0070 81            	ret	
4178  0071               L5602:
4179                     ; 680         return MQTT_OK;
4181  0071 ae0001        	ldw	x,#1
4183  0074 20f8          	jra	L403
4184  0076               L1602:
4185                     ; 712     switch (response.fixed_header.control_type) {
4187  0076 7b09          	ld	a,(OFST-23,sp)
4189                     ; 861             break;
4190  0078 a002          	sub	a,#2
4191  007a 2741          	jreq	L5151
4192  007c 4a            	dec	a
4193  007d 2603cc00ff    	jreq	L7151
4194  0082 4a            	dec	a
4195  0083 2603cc0164    	jreq	L1251
4196  0088 4a            	dec	a
4197  0089 2603cc018a    	jreq	L3251
4198  008e 4a            	dec	a
4199  008f 2603cc01cf    	jreq	L5251
4200  0094 4a            	dec	a
4201  0095 2603cc0200    	jreq	L7251
4202  009a a002          	sub	a,#2
4203  009c 2603cc020a    	jreq	L1351
4204  00a1 a002          	sub	a,#2
4205  00a3 2603cc023c    	jreq	L3351
4206  00a8 a002          	sub	a,#2
4207  00aa 2603cc0246    	jreq	L5351
4208                     ; 858         default:
4208                     ; 859             client->error = MQTT_ERROR_MALFORMED_RESPONSE;
4210  00af 1e21          	ldw	x,(OFST+1,sp)
4211  00b1 90ae800c      	ldw	y,#32780
4212  00b5 ef0a          	ldw	(10,x),y
4213                     ; 860             mqtt_recv_ret = MQTT_ERROR_MALFORMED_RESPONSE;
4215  00b7 ae800c        	ldw	x,#32780
4216                     ; 861             break;
4218  00ba cc0238        	jp	LC016
4219  00bd               L5151:
4220                     ; 713         case MQTT_CONTROL_CONNACK:
4220                     ; 714 
4220                     ; 715             // release associated CONNECT
4220                     ; 716             msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_CONNECT, NULL);
4222  00bd 5f            	clrw	x
4223  00be 89            	pushw	x
4224  00bf 4b01          	push	#1
4225  00c1 1e24          	ldw	x,(OFST+4,sp)
4226  00c3 1c0022        	addw	x,#34
4227  00c6 cd0000        	call	_mqtt_mq_find
4229  00c9 5b03          	addw	sp,#3
4230  00cb 1f1f          	ldw	(OFST-1,sp),x
4232                     ; 717             if (msg == NULL) {
4234                     ; 718                 client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
4235                     ; 719                 mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
4236                     ; 720                 break;
4238  00cd 2603cc017c    	jreq	LC017
4239                     ; 722             msg->state = MQTT_QUEUED_COMPLETE;
4241  00d2 a602          	ld	a,#2
4242  00d4 e704          	ld	(4,x),a
4243                     ; 724             if (response.decoded.connack.return_code != MQTT_CONNACK_ACCEPTED) {
4245  00d6 0d13          	tnz	(OFST-13,sp)
4246  00d8 2603cc025c    	jreq	L1702
4247                     ; 725                 if (response.decoded.connack.return_code == MQTT_CONNACK_REFUSED_IDENTIFIER_REJECTED) {
4249  00dd 7b13          	ld	a,(OFST-13,sp)
4250  00df a102          	cp	a,#2
4251  00e1 260e          	jrne	L7702
4252                     ; 726                     client->error = MQTT_ERROR_CONNECT_CLIENT_ID_REFUSED;
4254  00e3 1e21          	ldw	x,(OFST+1,sp)
4255  00e5 90ae8005      	ldw	y,#32773
4256  00e9 ef0a          	ldw	(10,x),y
4257                     ; 727                     mqtt_recv_ret = MQTT_ERROR_CONNECT_CLIENT_ID_REFUSED;
4259  00eb ae8005        	ldw	x,#32773
4261  00ee cc0238        	jp	LC016
4262  00f1               L7702:
4263                     ; 730                     client->error = MQTT_ERROR_CONNECTION_REFUSED;
4265  00f1 1e21          	ldw	x,(OFST+1,sp)
4266  00f3 90ae8016      	ldw	y,#32790
4267  00f7 ef0a          	ldw	(10,x),y
4268                     ; 731                     mqtt_recv_ret = MQTT_ERROR_CONNECTION_REFUSED;
4270  00f9 ae8016        	ldw	x,#32790
4271  00fc cc0238        	jp	LC016
4272  00ff               L7151:
4273                     ; 736         case MQTT_CONTROL_PUBLISH:
4273                     ; 737             // stage response, none if qos==0, PUBACK if qos==1, PUBREC if qos==2
4273                     ; 738             if (response.decoded.publish.qos_level == 1) {
4275  00ff 7b13          	ld	a,(OFST-13,sp)
4276  0101 a101          	cp	a,#1
4277  0103 2619          	jrne	L3012
4278                     ; 739                 rv = __mqtt_puback(client, response.decoded.publish.packet_id);
4280  0105 1e19          	ldw	x,(OFST-7,sp)
4281  0107 89            	pushw	x
4282  0108 1e23          	ldw	x,(OFST+3,sp)
4283  010a cd0000        	call	___mqtt_puback
4285  010d 5b02          	addw	sp,#2
4286  010f 1f1f          	ldw	(OFST-1,sp),x
4288                     ; 740                 if (rv != MQTT_OK) {
4290  0111 5a            	decw	x
4291  0112 273b          	jreq	L7012
4292                     ; 741                     client->error = rv;
4294  0114 1e21          	ldw	x,(OFST+1,sp)
4295  0116 161f          	ldw	y,(OFST-1,sp)
4296  0118 ef0a          	ldw	(10,x),y
4297                     ; 742                     mqtt_recv_ret = rv;
4299  011a 93            	ldw	x,y
4300                     ; 743                     break;
4302  011b cc0238        	jp	LC016
4303  011e               L3012:
4304                     ; 746             else if (response.decoded.publish.qos_level == 2) {
4306  011e a102          	cp	a,#2
4307  0120 262d          	jrne	L7012
4308                     ; 748                 if (mqtt_mq_find(&client->mq, MQTT_CONTROL_PUBREC, &response.decoded.publish.packet_id) != NULL) {
4310  0122 96            	ldw	x,sp
4311  0123 1c0019        	addw	x,#OFST-7
4312  0126 89            	pushw	x
4313  0127 4b05          	push	#5
4314  0129 1e24          	ldw	x,(OFST+4,sp)
4315  012b 1c0022        	addw	x,#34
4316  012e cd0000        	call	_mqtt_mq_find
4318  0131 5b03          	addw	sp,#3
4319  0133 5d            	tnzw	x
4320  0134 26a4          	jrne	L1702
4321                     ; 749                     break;
4323                     ; 752                 rv = __mqtt_pubrec(client, response.decoded.publish.packet_id);
4325  0136 1e19          	ldw	x,(OFST-7,sp)
4326  0138 89            	pushw	x
4327  0139 1e23          	ldw	x,(OFST+3,sp)
4328  013b cd0000        	call	___mqtt_pubrec
4330  013e 5b02          	addw	sp,#2
4331  0140 1f1f          	ldw	(OFST-1,sp),x
4333                     ; 753                 if (rv != MQTT_OK) {
4335  0142 5a            	decw	x
4336  0143 270a          	jreq	L7012
4337                     ; 754                     client->error = rv;
4339  0145 1e21          	ldw	x,(OFST+1,sp)
4340  0147 161f          	ldw	y,(OFST-1,sp)
4341  0149 ef0a          	ldw	(10,x),y
4342                     ; 755                     mqtt_recv_ret = rv;
4344  014b 93            	ldw	x,y
4345                     ; 756                     break;
4347  014c cc0238        	jp	LC016
4348  014f               L7012:
4349                     ; 761             client->publish_response_callback(&client->publish_response_callback_state, &response.decoded.publish);
4351  014f 96            	ldw	x,sp
4352  0150 1c0012        	addw	x,#OFST-14
4353  0153 89            	pushw	x
4354  0154 1e23          	ldw	x,(OFST+3,sp)
4355  0156 1623          	ldw	y,(OFST+3,sp)
4356  0158 1c0012        	addw	x,#18
4357  015b 90ee10        	ldw	y,(16,y)
4358  015e 90fd          	call	(y)
4360  0160 85            	popw	x
4361                     ; 762             break;
4363  0161 cc025c        	jra	L1702
4364  0164               L1251:
4365                     ; 763         case MQTT_CONTROL_PUBACK:
4365                     ; 764             // release associated PUBLISH
4365                     ; 765             msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_PUBLISH, &response.decoded.puback.packet_id);
4367  0164 96            	ldw	x,sp
4368  0165 1c0012        	addw	x,#OFST-14
4369  0168 89            	pushw	x
4370  0169 4b03          	push	#3
4372                     ; 766             if (msg == NULL) {
4374  016b               LC018:
4375  016b 1e24          	ldw	x,(OFST+4,sp)
4376  016d 1c0022        	addw	x,#34
4377  0170 cd0000        	call	_mqtt_mq_find
4378  0173 5b03          	addw	sp,#3
4379  0175 1f1f          	ldw	(OFST-1,sp),x
4383  0177 2703cc0258    	jrne	L3412
4384                     ; 767                 client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
4386                     ; 768                 mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
4388  017c               LC017:
4396  017c 1e21          	ldw	x,(OFST+1,sp)
4397  017e 90ae8014      	ldw	y,#32788
4398  0182 ef0a          	ldw	(10,x),y
4406  0184 ae8014        	ldw	x,#32788
4407                     ; 769                 break;
4409  0187 cc0238        	jp	LC016
4410                     ; 771             msg->state = MQTT_QUEUED_COMPLETE;
4411                     ; 772             break;
4413  018a               L3251:
4414                     ; 773         case MQTT_CONTROL_PUBREC:
4414                     ; 774             // check if this is a duplicate
4414                     ; 775             if (mqtt_mq_find(&client->mq, MQTT_CONTROL_PUBREL, &response.decoded.pubrec.packet_id) != NULL) {
4416  018a 96            	ldw	x,sp
4417  018b 1c0012        	addw	x,#OFST-14
4418  018e 89            	pushw	x
4419  018f 4b06          	push	#6
4420  0191 1e24          	ldw	x,(OFST+4,sp)
4421  0193 1c0022        	addw	x,#34
4422  0196 cd0000        	call	_mqtt_mq_find
4424  0199 5b03          	addw	sp,#3
4425  019b 5d            	tnzw	x
4426  019c 26c3          	jrne	L1702
4427                     ; 776                 break;
4429                     ; 779             msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_PUBLISH, &response.decoded.pubrec.packet_id);
4431  019e 96            	ldw	x,sp
4432  019f 1c0012        	addw	x,#OFST-14
4433  01a2 89            	pushw	x
4434  01a3 4b03          	push	#3
4435  01a5 1e24          	ldw	x,(OFST+4,sp)
4436  01a7 1c0022        	addw	x,#34
4437  01aa cd0000        	call	_mqtt_mq_find
4439  01ad 5b03          	addw	sp,#3
4440  01af 1f1f          	ldw	(OFST-1,sp),x
4442                     ; 780             if (msg == NULL) {
4444                     ; 781                 client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
4445                     ; 782                 mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
4446                     ; 783                 break;
4448  01b1 27c9          	jreq	LC017
4449                     ; 785             msg->state = MQTT_QUEUED_COMPLETE;
4451  01b3 a602          	ld	a,#2
4452  01b5 e704          	ld	(4,x),a
4453                     ; 787             rv = __mqtt_pubrel(client, response.decoded.pubrec.packet_id);
4455  01b7 1e12          	ldw	x,(OFST-14,sp)
4456  01b9 89            	pushw	x
4457  01ba 1e23          	ldw	x,(OFST+3,sp)
4458  01bc cd0000        	call	___mqtt_pubrel
4460  01bf 5b02          	addw	sp,#2
4461  01c1 1f1f          	ldw	(OFST-1,sp),x
4463                     ; 788             if (rv != MQTT_OK) {
4465  01c3 5a            	decw	x
4466  01c4 279b          	jreq	L1702
4467                     ; 789                 client->error = rv;
4469  01c6 1e21          	ldw	x,(OFST+1,sp)
4470  01c8 161f          	ldw	y,(OFST-1,sp)
4471  01ca ef0a          	ldw	(10,x),y
4472                     ; 790                 mqtt_recv_ret = rv;
4474  01cc 93            	ldw	x,y
4475                     ; 791                 break;
4477  01cd 2069          	jp	LC016
4478  01cf               L5251:
4479                     ; 794         case MQTT_CONTROL_PUBREL:
4479                     ; 795             // release associated PUBREC
4479                     ; 796             msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_PUBREC, &response.decoded.pubrel.packet_id);
4481  01cf 96            	ldw	x,sp
4482  01d0 1c0012        	addw	x,#OFST-14
4483  01d3 89            	pushw	x
4484  01d4 4b05          	push	#5
4485  01d6 1e24          	ldw	x,(OFST+4,sp)
4486  01d8 1c0022        	addw	x,#34
4487  01db cd0000        	call	_mqtt_mq_find
4489  01de 5b03          	addw	sp,#3
4490  01e0 1f1f          	ldw	(OFST-1,sp),x
4492                     ; 797             if (msg == NULL) {
4494                     ; 798                 client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
4495                     ; 799                 mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
4496                     ; 800                 break;
4498  01e2 2798          	jreq	LC017
4499                     ; 802             msg->state = MQTT_QUEUED_COMPLETE;
4501  01e4 a602          	ld	a,#2
4502  01e6 e704          	ld	(4,x),a
4503                     ; 804             rv = __mqtt_pubcomp(client, response.decoded.pubrec.packet_id);
4505  01e8 1e12          	ldw	x,(OFST-14,sp)
4506  01ea 89            	pushw	x
4507  01eb 1e23          	ldw	x,(OFST+3,sp)
4508  01ed cd0000        	call	___mqtt_pubcomp
4510  01f0 5b02          	addw	sp,#2
4511  01f2 1f1f          	ldw	(OFST-1,sp),x
4513                     ; 805             if (rv != MQTT_OK) {
4515  01f4 5a            	decw	x
4516  01f5 2765          	jreq	L1702
4517                     ; 806                 client->error = rv;
4519  01f7 1e21          	ldw	x,(OFST+1,sp)
4520  01f9 161f          	ldw	y,(OFST-1,sp)
4521  01fb ef0a          	ldw	(10,x),y
4522                     ; 807                 mqtt_recv_ret = rv;
4524  01fd 93            	ldw	x,y
4525                     ; 808                 break;
4527  01fe 2038          	jp	LC016
4528  0200               L7251:
4529                     ; 811         case MQTT_CONTROL_PUBCOMP:
4529                     ; 812             // release associated PUBREL
4529                     ; 813             msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_PUBREL, &response.decoded.pubcomp.packet_id);
4531  0200 96            	ldw	x,sp
4532  0201 1c0012        	addw	x,#OFST-14
4533  0204 89            	pushw	x
4534  0205 4b06          	push	#6
4536                     ; 814             if (msg == NULL) {
4537                     ; 815                 client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
4538                     ; 816                 mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
4539                     ; 817                 break;
4541  0207 cc016b        	jp	LC018
4542                     ; 819             msg->state = MQTT_QUEUED_COMPLETE;
4543                     ; 820             break;
4545  020a               L1351:
4546                     ; 821         case MQTT_CONTROL_SUBACK:
4546                     ; 822             // release associated SUBSCRIBE
4546                     ; 823             msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_SUBSCRIBE, &response.decoded.suback.packet_id);
4548  020a 96            	ldw	x,sp
4549  020b 1c0012        	addw	x,#OFST-14
4550  020e 89            	pushw	x
4551  020f 4b08          	push	#8
4552  0211 1e24          	ldw	x,(OFST+4,sp)
4553  0213 1c0022        	addw	x,#34
4554  0216 cd0000        	call	_mqtt_mq_find
4556  0219 5b03          	addw	sp,#3
4557  021b 1f1f          	ldw	(OFST-1,sp),x
4559                     ; 824             if (msg == NULL) {
4561                     ; 825                 client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
4562                     ; 826                 mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
4563                     ; 827                 break;
4565  021d 2603cc017c    	jreq	LC017
4566                     ; 829             msg->state = MQTT_QUEUED_COMPLETE;
4568  0222 a602          	ld	a,#2
4569  0224 e704          	ld	(4,x),a
4570                     ; 832             if (response.decoded.suback.return_codes[0] == MQTT_SUBACK_FAILURE) {
4572  0226 1e14          	ldw	x,(OFST-12,sp)
4573  0228 f6            	ld	a,(x)
4574  0229 a180          	cp	a,#128
4575  022b 262f          	jrne	L1702
4576                     ; 833                 client->error = MQTT_ERROR_SUBSCRIBE_FAILED;
4578  022d 1e21          	ldw	x,(OFST+1,sp)
4579  022f 90ae8017      	ldw	y,#32791
4580  0233 ef0a          	ldw	(10,x),y
4581                     ; 834                 mqtt_recv_ret = MQTT_ERROR_SUBSCRIBE_FAILED;
4583  0235 ae8017        	ldw	x,#32791
4584  0238               LC016:
4585  0238 1f07          	ldw	(OFST-25,sp),x
4587                     ; 835                 break;
4589  023a 2020          	jra	L1702
4590  023c               L3351:
4591                     ; 838         case MQTT_CONTROL_UNSUBACK:
4591                     ; 839             // release associated UNSUBSCRIBE
4591                     ; 840             msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_UNSUBSCRIBE, &response.decoded.unsuback.packet_id);
4593  023c 96            	ldw	x,sp
4594  023d 1c0012        	addw	x,#OFST-14
4595  0240 89            	pushw	x
4596  0241 4b0a          	push	#10
4598                     ; 841             if (msg == NULL) {
4599                     ; 842                 client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
4600                     ; 843                 mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
4601                     ; 844                 break;
4603  0243 cc016b        	jp	LC018
4604                     ; 846             msg->state = MQTT_QUEUED_COMPLETE;
4605                     ; 847             break;
4607  0246               L5351:
4608                     ; 848         case MQTT_CONTROL_PINGRESP:
4608                     ; 849             // release associated PINGREQ
4608                     ; 850             msg = mqtt_mq_find(&client->mq, MQTT_CONTROL_PINGREQ, NULL);
4610  0246 5f            	clrw	x
4611  0247 89            	pushw	x
4612  0248 4b0c          	push	#12
4613  024a 1e24          	ldw	x,(OFST+4,sp)
4614  024c 1c0022        	addw	x,#34
4615  024f cd0000        	call	_mqtt_mq_find
4617  0252 5b03          	addw	sp,#3
4618  0254 1f1f          	ldw	(OFST-1,sp),x
4620                     ; 851             if (msg == NULL) {
4622                     ; 852                 client->error = MQTT_ERROR_ACK_OF_UNKNOWN;
4623                     ; 853                 mqtt_recv_ret = MQTT_ERROR_ACK_OF_UNKNOWN;
4624                     ; 854                 break;
4626  0256 27c7          	jreq	LC017
4627  0258               L3412:
4628                     ; 856             msg->state = MQTT_QUEUED_COMPLETE;
4633  0258 a602          	ld	a,#2
4634  025a e704          	ld	(4,x),a
4635                     ; 857             break;
4637  025c               L1702:
4638                     ; 890         void* dest = (unsigned char*)client->recv_buffer.mem_start;
4640  025c 1e21          	ldw	x,(OFST+1,sp)
4641  025e ee1a          	ldw	x,(26,x)
4642  0260 1f01          	ldw	(OFST-31,sp),x
4644                     ; 891         void* src  = (unsigned char*)client->recv_buffer.mem_start + consumed;
4646  0262 1e21          	ldw	x,(OFST+1,sp)
4647  0264 ee1a          	ldw	x,(26,x)
4648  0266 72fb05        	addw	x,(OFST-27,sp)
4649  0269 1f03          	ldw	(OFST-29,sp),x
4651                     ; 892         uint16_t n = client->recv_buffer.curr - client->recv_buffer.mem_start - consumed;
4653  026b 1e21          	ldw	x,(OFST+1,sp)
4654  026d 1621          	ldw	y,(OFST+1,sp)
4655  026f ee1e          	ldw	x,(30,x)
4656  0271 01            	rrwa	x,a
4657  0272 90e01b        	sub	a,(27,y)
4658  0275 01            	rrwa	x,a
4659  0276 90e21a        	sbc	a,(26,y)
4660  0279 01            	rrwa	x,a
4661  027a 72f005        	subw	x,(OFST-27,sp)
4662  027d 1f1f          	ldw	(OFST-1,sp),x
4664                     ; 893         memmove(dest, src, n);
4666  027f 89            	pushw	x
4667  0280 1e05          	ldw	x,(OFST-27,sp)
4668  0282 89            	pushw	x
4669  0283 1e05          	ldw	x,(OFST-27,sp)
4670  0285 cd0000        	call	_memmove
4672  0288 5b04          	addw	sp,#4
4673                     ; 894         client->recv_buffer.curr -= consumed;
4675  028a 1e21          	ldw	x,(OFST+1,sp)
4676  028c 9093          	ldw	y,x
4677  028e ee1e          	ldw	x,(30,x)
4678  0290 72f005        	subw	x,(OFST-27,sp)
4679  0293 90ef1e        	ldw	(30,y),x
4680                     ; 895         client->recv_buffer.curr_sz += consumed;
4682  0296 1e21          	ldw	x,(OFST+1,sp)
4683  0298 9093          	ldw	y,x
4684  029a ee20          	ldw	x,(32,x)
4685  029c 72fb05        	addw	x,(OFST-27,sp)
4686  029f 90ef20        	ldw	(32,y),x
4687                     ; 904     return mqtt_recv_ret;
4689  02a2 1e07          	ldw	x,(OFST-25,sp)
4691  02a4 cc006e        	jra	L403
4694                     .const:	section	.text
4695  0000               L5412_control_type_is_valid:
4696  0000 00            	dc.b	0
4697  0001 01            	dc.b	1
4698  0002 01            	dc.b	1
4699  0003 01            	dc.b	1
4700  0004 01            	dc.b	1
4701  0005 01            	dc.b	1
4702  0006 01            	dc.b	1
4703  0007 01            	dc.b	1
4704  0008 01            	dc.b	1
4705  0009 01            	dc.b	1
4706  000a 01            	dc.b	1
4707  000b 01            	dc.b	1
4708  000c 01            	dc.b	1
4709  000d 01            	dc.b	1
4710  000e 01            	dc.b	1
4711  000f 00            	dc.b	0
4712  0010               L7412_required_flags:
4713  0010 00            	dc.b	0
4714  0011 00            	dc.b	0
4715  0012 00            	dc.b	0
4716  0013 00            	dc.b	0
4717  0014 00            	dc.b	0
4718  0015 00            	dc.b	0
4719  0016 02            	dc.b	2
4720  0017 00            	dc.b	0
4721  0018 02            	dc.b	2
4722  0019 00            	dc.b	0
4723  001a 02            	dc.b	2
4724  001b 00            	dc.b	0
4725  001c 00            	dc.b	0
4726  001d 00            	dc.b	0
4727  001e 00            	dc.b	0
4728  001f 00            	dc.b	0
4729  0020               L1512_mask_required_flags:
4730  0020 00            	dc.b	0
4731  0021 0f            	dc.b	15
4732  0022 0f            	dc.b	15
4733  0023 00            	dc.b	0
4734  0024 0f            	dc.b	15
4735  0025 0f            	dc.b	15
4736  0026 0f            	dc.b	15
4737  0027 0f            	dc.b	15
4738  0028 0f            	dc.b	15
4739  0029 0f            	dc.b	15
4740  002a 0f            	dc.b	15
4741  002b 0f            	dc.b	15
4742  002c 0f            	dc.b	15
4743  002d 0f            	dc.b	15
4744  002e 0f            	dc.b	15
4745  002f 00            	dc.b	0
4798                     ; 966 static int16_t mqtt_fixed_header_rule_violation(const struct mqtt_fixed_header *fixed_header)
4798                     ; 967 {
4799                     .text:	section	.text,new
4800  0000               L3512_mqtt_fixed_header_rule_violation:
4802  0000 89            	pushw	x
4803       00000002      OFST:	set	2
4806                     ; 972     control_type = fixed_header->control_type;
4808  0001 f6            	ld	a,(x)
4809  0002 6b02          	ld	(OFST+0,sp),a
4811                     ; 973     control_flags = fixed_header->control_flags;
4813  0004 e604          	ld	a,(4,x)
4814  0006 a40f          	and	a,#15
4815  0008 6b01          	ld	(OFST-1,sp),a
4817                     ; 976     if (control_type_is_valid[control_type] != 0x01) {
4819  000a 5f            	clrw	x
4820  000b 7b02          	ld	a,(OFST+0,sp)
4821  000d 97            	ld	xl,a
4822  000e d60000        	ld	a,(L5412_control_type_is_valid,x)
4823  0011 4a            	dec	a
4824  0012 2705          	jreq	L1022
4825                     ; 977         return MQTT_ERROR_CONTROL_FORBIDDEN_TYPE;
4827  0014 ae8002        	ldw	x,#32770
4829  0017 2017          	jra	L013
4830  0019               L1022:
4831                     ; 981     if(((control_flags ^ required_flags[control_type]) & mask_required_flags[control_type]) == 1) {
4833  0019 7b02          	ld	a,(OFST+0,sp)
4834  001b 5f            	clrw	x
4835  001c 97            	ld	xl,a
4836  001d 905f          	clrw	y
4837  001f 9097          	ld	yl,a
4838  0021 90d60010      	ld	a,(L7412_required_flags,y)
4839  0025 1801          	xor	a,(OFST-1,sp)
4840  0027 d40020        	and	a,(L1512_mask_required_flags,x)
4841  002a 4a            	dec	a
4842  002b 2606          	jrne	L3022
4843                     ; 982         return MQTT_ERROR_CONTROL_INVALID_FLAGS;
4845  002d ae8003        	ldw	x,#32771
4847  0030               L013:
4849  0030 5b02          	addw	sp,#2
4850  0032 81            	ret	
4851  0033               L3022:
4852                     ; 985     return 0;
4854  0033 5f            	clrw	x
4856  0034 20fa          	jra	L013
4948                     ; 989 int16_t mqtt_unpack_fixed_header(struct mqtt_response *response, const uint8_t *buf, uint16_t bufsz)
4948                     ; 990 {
4949                     .text:	section	.text,new
4950  0000               _mqtt_unpack_fixed_header:
4952  0000 89            	pushw	x
4953  0001 520a          	subw	sp,#10
4954       0000000a      OFST:	set	10
4957                     ; 992     const uint8_t *start = buf;
4959  0003 1e0f          	ldw	x,(OFST+5,sp)
4960  0005 1f05          	ldw	(OFST-5,sp),x
4962                     ; 997     if (response == NULL || buf == NULL) {
4964  0007 1e0b          	ldw	x,(OFST+1,sp)
4965  0009 2704          	jreq	L3522
4967  000b 1e0f          	ldw	x,(OFST+5,sp)
4968  000d 2605          	jrne	L1522
4969  000f               L3522:
4970                     ; 998       return MQTT_ERROR_NULLPTR;
4972  000f ae8001        	ldw	x,#32769
4974  0012 2009          	jra	L223
4975  0014               L1522:
4976                     ; 1000     fixed_header = &(response->fixed_header);
4978  0014 1e0b          	ldw	x,(OFST+1,sp)
4979  0016 1f07          	ldw	(OFST-3,sp),x
4981                     ; 1003     if (bufsz == 0) return 0;
4983  0018 1e11          	ldw	x,(OFST+7,sp)
4984  001a 2604          	jrne	L5522
4987  001c               LC019:
4990  001c 5f            	clrw	x
4992  001d               L223:
4994  001d 5b0c          	addw	sp,#12
4995  001f 81            	ret	
4996  0020               L5522:
4997                     ; 1006     fixed_header->control_type  = (uint8_t)(*buf >> 4);
4999  0020 1e0f          	ldw	x,(OFST+5,sp)
5000  0022 f6            	ld	a,(x)
5001  0023 4e            	swap	a
5002  0024 1e07          	ldw	x,(OFST-3,sp)
5003  0026 a40f          	and	a,#15
5004  0028 f7            	ld	(x),a
5005                     ; 1007     fixed_header->control_flags = (uint8_t)(*buf & 0x0F);
5007  0029 1e0f          	ldw	x,(OFST+5,sp)
5008  002b f6            	ld	a,(x)
5009  002c 1e07          	ldw	x,(OFST-3,sp)
5010  002e e804          	xor	a,(4,x)
5011  0030 a40f          	and	a,#15
5012  0032 e804          	xor	a,(4,x)
5013  0034 e704          	ld	(4,x),a
5014                     ; 1010     fixed_header->remaining_length = 0;
5016  0036 4f            	clr	a
5017  0037 e708          	ld	(8,x),a
5018  0039 e707          	ld	(7,x),a
5019  003b e706          	ld	(6,x),a
5020  003d e705          	ld	(5,x),a
5021                     ; 1012     lshift = 0;
5023  003f 5f            	clrw	x
5024  0040 1f09          	ldw	(OFST-1,sp),x
5026  0042               L7522:
5027                     ; 1015         if(lshift == 28) {
5029  0042 1e09          	ldw	x,(OFST-1,sp)
5030  0044 a3001c        	cpw	x,#28
5031  0047 2605          	jrne	L5622
5032                     ; 1016             return MQTT_ERROR_INVALID_REMAINING_LENGTH;
5034  0049 ae801a        	ldw	x,#32794
5036  004c 20cf          	jra	L223
5037  004e               L5622:
5038                     ; 1020         --bufsz;
5040  004e 1e11          	ldw	x,(OFST+7,sp)
5041  0050 5a            	decw	x
5042  0051 1f11          	ldw	(OFST+7,sp),x
5043                     ; 1021         ++buf;
5045  0053 1e0f          	ldw	x,(OFST+5,sp)
5046  0055 5c            	incw	x
5047  0056 1f0f          	ldw	(OFST+5,sp),x
5048                     ; 1022         if (bufsz == 0) return 0;
5050  0058 1e11          	ldw	x,(OFST+7,sp)
5053  005a 27c0          	jreq	LC019
5054                     ; 1025         fixed_header->remaining_length += (*buf & 0x7F) << lshift;
5056  005c 160f          	ldw	y,(OFST+5,sp)
5057  005e 1e07          	ldw	x,(OFST-3,sp)
5058  0060 90f6          	ld	a,(y)
5059  0062 a47f          	and	a,#127
5060  0064 905f          	clrw	y
5061  0066 9097          	ld	yl,a
5062  0068 7b0a          	ld	a,(OFST+0,sp)
5063  006a 2705          	jreq	L413
5064  006c               L613:
5065  006c 9058          	sllw	y
5066  006e 4a            	dec	a
5067  006f 26fb          	jrne	L613
5068  0071               L413:
5069  0071 cd0000        	call	c_itoly
5071  0074 1c0005        	addw	x,#5
5072  0077 cd0000        	call	c_lgadd
5074                     ; 1026         lshift += 7;
5076  007a 1e09          	ldw	x,(OFST-1,sp)
5077  007c 1c0007        	addw	x,#7
5078  007f 1f09          	ldw	(OFST-1,sp),x
5080                     ; 1027     } while(*buf & 0x80); /* while continue bit is set */ 
5082  0081 1e0f          	ldw	x,(OFST+5,sp)
5083  0083 f6            	ld	a,(x)
5084  0084 2bbc          	jrmi	L7522
5085                     ; 1030     --bufsz;
5087  0086 1e11          	ldw	x,(OFST+7,sp)
5088  0088 5a            	decw	x
5089  0089 1f11          	ldw	(OFST+7,sp),x
5090                     ; 1031     ++buf;
5092  008b 1e0f          	ldw	x,(OFST+5,sp)
5093  008d 5c            	incw	x
5094  008e 1f0f          	ldw	(OFST+5,sp),x
5095                     ; 1034     errcode = mqtt_fixed_header_rule_violation(fixed_header);
5097  0090 1e07          	ldw	x,(OFST-3,sp)
5098  0092 cd0000        	call	L3512_mqtt_fixed_header_rule_violation
5100  0095 1f09          	ldw	(OFST-1,sp),x
5102                     ; 1035     if (errcode) return errcode;
5107  0097 2684          	jrne	L223
5108                     ; 1038     if (bufsz < fixed_header->remaining_length) return 0;
5110  0099 1e11          	ldw	x,(OFST+7,sp)
5111  009b cd0000        	call	c_uitolx
5113  009e 96            	ldw	x,sp
5114  009f 5c            	incw	x
5115  00a0 cd0000        	call	c_rtol
5118  00a3 1e07          	ldw	x,(OFST-3,sp)
5119  00a5 1c0005        	addw	x,#5
5120  00a8 cd0000        	call	c_ltor
5122  00ab 96            	ldw	x,sp
5123  00ac 5c            	incw	x
5124  00ad cd0000        	call	c_lcmp
5128  00b0 2303cc001c    	jrugt	LC019
5129                     ; 1041     return buf - start;
5131  00b5 1e0f          	ldw	x,(OFST+5,sp)
5132  00b7 72f005        	subw	x,(OFST-5,sp)
5134  00ba cc001d        	jra	L223
5214                     	switch	.const
5215  0030               L033:
5216  0030 00000080      	dc.l	128
5217                     ; 1045 int16_t mqtt_pack_fixed_header(uint8_t *buf, uint16_t bufsz, const struct mqtt_fixed_header *fixed_header)
5217                     ; 1046 {
5218                     .text:	section	.text,new
5219  0000               _mqtt_pack_fixed_header:
5221  0000 89            	pushw	x
5222  0001 520c          	subw	sp,#12
5223       0000000c      OFST:	set	12
5226                     ; 1047     const uint8_t *start = buf;
5228  0003 1f05          	ldw	(OFST-7,sp),x
5230                     ; 1052     if (fixed_header == NULL || buf == NULL) {
5232  0005 1e13          	ldw	x,(OFST+7,sp)
5233  0007 2704          	jreq	L5332
5235  0009 1e0d          	ldw	x,(OFST+1,sp)
5236  000b 2605          	jrne	L3332
5237  000d               L5332:
5238                     ; 1053       return MQTT_ERROR_NULLPTR;
5240  000d ae8001        	ldw	x,#32769
5242  0010 2009          	jra	L233
5243  0012               L3332:
5244                     ; 1057     errcode = mqtt_fixed_header_rule_violation(fixed_header);
5246  0012 1e13          	ldw	x,(OFST+7,sp)
5247  0014 cd0000        	call	L3512_mqtt_fixed_header_rule_violation
5249  0017 1f07          	ldw	(OFST-5,sp),x
5251                     ; 1058     if (errcode) return errcode;
5253  0019 2703          	jreq	L7332
5257  001b               L233:
5259  001b 5b0e          	addw	sp,#14
5260  001d 81            	ret	
5261  001e               L7332:
5262                     ; 1061     if (bufsz == 0) return 0;
5264  001e 1e11          	ldw	x,(OFST+5,sp)
5265  0020 2603          	jrne	L1432
5268  0022 5f            	clrw	x
5270  0023 20f6          	jra	L233
5271  0025               L1432:
5272                     ; 1064     *buf =  (uint8_t)((fixed_header->control_type << 4) & 0xF0);
5274  0025 1e13          	ldw	x,(OFST+7,sp)
5275  0027 f6            	ld	a,(x)
5276  0028 97            	ld	xl,a
5277  0029 a610          	ld	a,#16
5278  002b 42            	mul	x,a
5279  002c 9f            	ld	a,xl
5280  002d 1e0d          	ldw	x,(OFST+1,sp)
5281  002f a4f0          	and	a,#240
5282  0031 f7            	ld	(x),a
5283                     ; 1065     *buf |= (uint8_t)(fixed_header->control_flags & 0x0F);
5285  0032 1613          	ldw	y,(OFST+7,sp)
5286  0034 90e604        	ld	a,(4,y)
5287  0037 a40f          	and	a,#15
5288  0039 fa            	or	a,(x)
5289  003a f7            	ld	(x),a
5290                     ; 1067     remaining_length = fixed_header->remaining_length;
5292  003b 93            	ldw	x,y
5293  003c ee07          	ldw	x,(7,x)
5294  003e 1f0b          	ldw	(OFST-1,sp),x
5295  0040 93            	ldw	x,y
5296  0041 ee05          	ldw	x,(5,x)
5297  0043 1f09          	ldw	(OFST-3,sp),x
5299  0045               L3432:
5300                     ; 1075         --bufsz;
5302  0045 1e11          	ldw	x,(OFST+5,sp)
5303  0047 5a            	decw	x
5304  0048 1f11          	ldw	(OFST+5,sp),x
5305                     ; 1076         ++buf;
5307  004a 1e0d          	ldw	x,(OFST+1,sp)
5308  004c 5c            	incw	x
5309  004d 1f0d          	ldw	(OFST+1,sp),x
5310                     ; 1077         if (bufsz == 0) return 0;
5312  004f 1e11          	ldw	x,(OFST+5,sp)
5313  0051 2603          	jrne	L1532
5316  0053 5f            	clrw	x
5318  0054 20c5          	jra	L233
5319  0056               L1532:
5320                     ; 1080         *buf  = (uint8_t)(remaining_length & 0x7F);
5322  0056 7b0c          	ld	a,(OFST+0,sp)
5323  0058 1e0d          	ldw	x,(OFST+1,sp)
5324  005a a47f          	and	a,#127
5325  005c f7            	ld	(x),a
5326                     ; 1081         if(remaining_length > 127) *buf |= 0x80;
5328  005d 96            	ldw	x,sp
5329  005e 1c0009        	addw	x,#OFST-3
5330  0061 cd0000        	call	c_ltor
5332  0064 ae0030        	ldw	x,#L033
5333  0067 cd0000        	call	c_lcmp
5335  006a 2506          	jrult	L3532
5338  006c 1e0d          	ldw	x,(OFST+1,sp)
5339  006e f6            	ld	a,(x)
5340  006f aa80          	or	a,#128
5341  0071 f7            	ld	(x),a
5342  0072               L3532:
5343                     ; 1082         remaining_length = remaining_length >> 7;
5345  0072 96            	ldw	x,sp
5346  0073 1c0009        	addw	x,#OFST-3
5347  0076 a607          	ld	a,#7
5348  0078 cd0000        	call	c_lgursh
5351                     ; 1083     } while(*buf & 0x80);
5353  007b 1e0d          	ldw	x,(OFST+1,sp)
5354  007d f6            	ld	a,(x)
5355  007e 2bc5          	jrmi	L3432
5356                     ; 1086     --bufsz;
5358  0080 1e11          	ldw	x,(OFST+5,sp)
5359  0082 5a            	decw	x
5360  0083 1f11          	ldw	(OFST+5,sp),x
5361                     ; 1087     ++buf;
5363  0085 1e0d          	ldw	x,(OFST+1,sp)
5364  0087 5c            	incw	x
5365  0088 1f0d          	ldw	(OFST+1,sp),x
5366                     ; 1090     if (bufsz < fixed_header->remaining_length) return 0;
5368  008a 1e11          	ldw	x,(OFST+5,sp)
5369  008c cd0000        	call	c_uitolx
5371  008f 96            	ldw	x,sp
5372  0090 5c            	incw	x
5373  0091 cd0000        	call	c_rtol
5376  0094 1e13          	ldw	x,(OFST+7,sp)
5377  0096 1c0005        	addw	x,#5
5378  0099 cd0000        	call	c_ltor
5380  009c 96            	ldw	x,sp
5381  009d 5c            	incw	x
5382  009e cd0000        	call	c_lcmp
5384  00a1 2304          	jrule	L5532
5387  00a3 5f            	clrw	x
5389  00a4 cc001b        	jra	L233
5390  00a7               L5532:
5391                     ; 1093     return buf - start;
5393  00a7 1e0d          	ldw	x,(OFST+1,sp)
5394  00a9 72f005        	subw	x,(OFST-7,sp)
5396  00ac cc001b        	jra	L233
5549                     ; 1098 int16_t mqtt_pack_connection_request(uint8_t* buf, uint16_t bufsz,
5549                     ; 1099                                      const char* client_id,
5549                     ; 1100                                      const char* will_topic,
5549                     ; 1101                                      const void* will_message,
5549                     ; 1102                                      uint16_t will_message_size,
5549                     ; 1103                                      const char* user_name,
5549                     ; 1104                                      const char* password,
5549                     ; 1105                                      uint8_t connect_flags,
5549                     ; 1106                                      uint16_t keep_alive)
5549                     ; 1107 { 
5550                     .text:	section	.text,new
5551  0000               _mqtt_pack_connection_request:
5553  0000 89            	pushw	x
5554  0001 520d          	subw	sp,#13
5555       0000000d      OFST:	set	13
5558                     ; 1110     const uint8_t *const start = buf;
5560  0003 1f01          	ldw	(OFST-12,sp),x
5562                     ; 1114     fixed_header.control_type = MQTT_CONTROL_CONNECT;
5564  0005 a601          	ld	a,#1
5565  0007 6b03          	ld	(OFST-10,sp),a
5567                     ; 1115     fixed_header.control_flags = 0x00;
5569  0009 7b07          	ld	a,(OFST-6,sp)
5570  000b a4f0          	and	a,#240
5571  000d 6b07          	ld	(OFST-6,sp),a
5573                     ; 1118     connect_flags = (uint8_t)(connect_flags & ~MQTT_CONNECT_RESERVED);
5575  000f 7b20          	ld	a,(OFST+19,sp)
5576  0011 a4fe          	and	a,#254
5577  0013 6b20          	ld	(OFST+19,sp),a
5578                     ; 1121     remaining_length = 10; /* size of variable header */
5580  0015 ae000a        	ldw	x,#10
5581  0018 1f0c          	ldw	(OFST-1,sp),x
5583                     ; 1133     remaining_length += __mqtt_packed_cstrlen(client_id);
5585  001a 1e14          	ldw	x,(OFST+7,sp)
5586  001c cd0000        	call	_strlen
5588  001f 1c0002        	addw	x,#2
5589  0022 72fb0c        	addw	x,(OFST-1,sp)
5590  0025 1f0c          	ldw	(OFST-1,sp),x
5592                     ; 1163     connect_flags |= MQTT_CONNECT_WILL_FLAG;
5594  0027 7b20          	ld	a,(OFST+19,sp)
5595                     ; 1164     connect_flags |= MQTT_CONNECT_WILL_RETAIN;
5597  0029 aa24          	or	a,#36
5598  002b 6b20          	ld	(OFST+19,sp),a
5599                     ; 1165     remaining_length += __mqtt_packed_cstrlen(will_topic);
5601  002d 1e16          	ldw	x,(OFST+9,sp)
5602  002f cd0000        	call	_strlen
5604  0032 1c0002        	addw	x,#2
5605  0035 72fb0c        	addw	x,(OFST-1,sp)
5606  0038 1f0c          	ldw	(OFST-1,sp),x
5608                     ; 1166     remaining_length += 2 + will_message_size; /* size of will_message */
5610  003a 1e1a          	ldw	x,(OFST+13,sp)
5611  003c 1c0002        	addw	x,#2
5612  003f 72fb0c        	addw	x,(OFST-1,sp)
5613  0042 1f0c          	ldw	(OFST-1,sp),x
5615                     ; 1168     if (user_name != NULL) {
5617  0044 1e1c          	ldw	x,(OFST+15,sp)
5618  0046 2713          	jreq	L5442
5619                     ; 1170         connect_flags |= MQTT_CONNECT_USER_NAME;
5621  0048 7b20          	ld	a,(OFST+19,sp)
5622  004a aa80          	or	a,#128
5623  004c 6b20          	ld	(OFST+19,sp),a
5624                     ; 1171         remaining_length += __mqtt_packed_cstrlen(user_name);
5626  004e cd0000        	call	_strlen
5628  0051 1c0002        	addw	x,#2
5629  0054 72fb0c        	addw	x,(OFST-1,sp)
5630  0057 1f0c          	ldw	(OFST-1,sp),x
5633  0059 2006          	jra	L7442
5634  005b               L5442:
5635                     ; 1173     else connect_flags &= (uint8_t)(~MQTT_CONNECT_USER_NAME);
5637  005b 7b20          	ld	a,(OFST+19,sp)
5638  005d a47f          	and	a,#127
5639  005f 6b20          	ld	(OFST+19,sp),a
5640  0061               L7442:
5641                     ; 1175     if (password != NULL) {
5643  0061 1e1e          	ldw	x,(OFST+17,sp)
5644  0063 2713          	jreq	L1542
5645                     ; 1177         connect_flags |= MQTT_CONNECT_PASSWORD;
5647  0065 7b20          	ld	a,(OFST+19,sp)
5648  0067 aa40          	or	a,#64
5649  0069 6b20          	ld	(OFST+19,sp),a
5650                     ; 1178         remaining_length += __mqtt_packed_cstrlen(password);
5652  006b cd0000        	call	_strlen
5654  006e 1c0002        	addw	x,#2
5655  0071 72fb0c        	addw	x,(OFST-1,sp)
5656  0074 1f0c          	ldw	(OFST-1,sp),x
5659  0076 2008          	jra	L3542
5660  0078               L1542:
5661                     ; 1180     else connect_flags &= (uint8_t)(~MQTT_CONNECT_PASSWORD);
5663  0078 7b20          	ld	a,(OFST+19,sp)
5664  007a a4bf          	and	a,#191
5665  007c 6b20          	ld	(OFST+19,sp),a
5666  007e 1e0c          	ldw	x,(OFST-1,sp)
5667  0080               L3542:
5668                     ; 1183     fixed_header.remaining_length = remaining_length;
5670  0080 cd0000        	call	c_uitolx
5672  0083 96            	ldw	x,sp
5673  0084 1c0008        	addw	x,#OFST-5
5674  0087 cd0000        	call	c_rtol
5677                     ; 1186     rv = mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
5679  008a 96            	ldw	x,sp
5680  008b 1c0003        	addw	x,#OFST-10
5681  008e 89            	pushw	x
5682  008f 1e14          	ldw	x,(OFST+7,sp)
5683  0091 89            	pushw	x
5684  0092 1e12          	ldw	x,(OFST+5,sp)
5685  0094 cd0000        	call	_mqtt_pack_fixed_header
5687  0097 5b04          	addw	sp,#4
5688  0099 1f0c          	ldw	(OFST-1,sp),x
5690                     ; 1187     if (rv <= 0) {
5692  009b 9c            	rvf	
5693                     ; 1188       return rv; /* something went wrong */
5696  009c 2d1b          	jrsle	L073
5697                     ; 1191     buf += rv;
5699  009e 1e0e          	ldw	x,(OFST+1,sp)
5700  00a0 72fb0c        	addw	x,(OFST-1,sp)
5701  00a3 1f0e          	ldw	(OFST+1,sp),x
5702                     ; 1192     bufsz -= rv;
5704  00a5 1e12          	ldw	x,(OFST+5,sp)
5705  00a7 72f00c        	subw	x,(OFST-1,sp)
5706  00aa 1f12          	ldw	(OFST+5,sp),x
5707                     ; 1195     if (bufsz < fixed_header.remaining_length) return 0;
5709  00ac cd0000        	call	c_uitolx
5711  00af 96            	ldw	x,sp
5712  00b0 1c0008        	addw	x,#OFST-5
5713  00b3 cd0000        	call	c_lcmp
5715  00b6 2404          	jruge	L7542
5718  00b8 5f            	clrw	x
5720  00b9               L073:
5722  00b9 5b0f          	addw	sp,#15
5723  00bb 81            	ret	
5724  00bc               L7542:
5725                     ; 1198     *buf++ = 0x00;
5727  00bc 1e0e          	ldw	x,(OFST+1,sp)
5728  00be 7f            	clr	(x)
5729  00bf 5c            	incw	x
5730                     ; 1199     *buf++ = 0x04;
5732  00c0 a604          	ld	a,#4
5733  00c2 f7            	ld	(x),a
5734  00c3 5c            	incw	x
5735                     ; 1200     *buf++ = (uint8_t) 'M';
5737  00c4 a64d          	ld	a,#77
5738  00c6 f7            	ld	(x),a
5739  00c7 5c            	incw	x
5740                     ; 1201     *buf++ = (uint8_t) 'Q';
5742  00c8 a651          	ld	a,#81
5743  00ca f7            	ld	(x),a
5744  00cb 5c            	incw	x
5745                     ; 1202     *buf++ = (uint8_t) 'T';
5747  00cc a654          	ld	a,#84
5748  00ce f7            	ld	(x),a
5749  00cf 5c            	incw	x
5750                     ; 1203     *buf++ = (uint8_t) 'T';
5752  00d0 f7            	ld	(x),a
5753  00d1 5c            	incw	x
5754                     ; 1204     *buf++ = MQTT_PROTOCOL_LEVEL;
5756  00d2 a604          	ld	a,#4
5757  00d4 f7            	ld	(x),a
5758  00d5 5c            	incw	x
5759                     ; 1205     *buf++ = connect_flags;
5761  00d6 7b20          	ld	a,(OFST+19,sp)
5762  00d8 f7            	ld	(x),a
5763  00d9 5c            	incw	x
5764  00da 1f0e          	ldw	(OFST+1,sp),x
5765                     ; 1206     buf += __mqtt_pack_uint16(buf, keep_alive);
5767  00dc 1e21          	ldw	x,(OFST+20,sp)
5768  00de 89            	pushw	x
5769  00df 1e10          	ldw	x,(OFST+3,sp)
5770  00e1 cd0000        	call	___mqtt_pack_uint16
5772  00e4 5b02          	addw	sp,#2
5773  00e6 72fb0e        	addw	x,(OFST+1,sp)
5774  00e9 1f0e          	ldw	(OFST+1,sp),x
5775                     ; 1209     buf += __mqtt_pack_str(buf, client_id);
5777  00eb 1e14          	ldw	x,(OFST+7,sp)
5778  00ed 89            	pushw	x
5779  00ee 1e10          	ldw	x,(OFST+3,sp)
5780  00f0 cd0000        	call	___mqtt_pack_str
5782  00f3 5b02          	addw	sp,#2
5783  00f5 72fb0e        	addw	x,(OFST+1,sp)
5784  00f8 1f0e          	ldw	(OFST+1,sp),x
5785                     ; 1210     if (connect_flags & MQTT_CONNECT_WILL_FLAG) {
5787  00fa 7b20          	ld	a,(OFST+19,sp)
5788  00fc a504          	bcp	a,#4
5789  00fe 273c          	jreq	L1642
5790                     ; 1211         buf += __mqtt_pack_str(buf, will_topic);
5792  0100 1e16          	ldw	x,(OFST+9,sp)
5793  0102 89            	pushw	x
5794  0103 1e10          	ldw	x,(OFST+3,sp)
5795  0105 cd0000        	call	___mqtt_pack_str
5797  0108 5b02          	addw	sp,#2
5798  010a 72fb0e        	addw	x,(OFST+1,sp)
5799  010d 1f0e          	ldw	(OFST+1,sp),x
5800                     ; 1212         buf += __mqtt_pack_uint16(buf, (uint16_t)will_message_size);
5802  010f 1e1a          	ldw	x,(OFST+13,sp)
5803  0111 89            	pushw	x
5804  0112 1e10          	ldw	x,(OFST+3,sp)
5805  0114 cd0000        	call	___mqtt_pack_uint16
5807  0117 5b02          	addw	sp,#2
5808  0119 72fb0e        	addw	x,(OFST+1,sp)
5809  011c 1f0e          	ldw	(OFST+1,sp),x
5810                     ; 1213         memcpy(buf, will_message, will_message_size);
5812  011e bf00          	ldw	c_x,x
5813  0120 1618          	ldw	y,(OFST+11,sp)
5814  0122 90bf00        	ldw	c_y,y
5815  0125 1e1a          	ldw	x,(OFST+13,sp)
5816  0127 270a          	jreq	L063
5817  0129               L263:
5818  0129 5a            	decw	x
5819  012a 92d600        	ld	a,([c_y.w],x)
5820  012d 92d700        	ld	([c_x.w],x),a
5821  0130 5d            	tnzw	x
5822  0131 26f6          	jrne	L263
5823  0133               L063:
5824                     ; 1214         buf += will_message_size;
5826  0133 1e0e          	ldw	x,(OFST+1,sp)
5827  0135 72fb1a        	addw	x,(OFST+13,sp)
5828  0138 1f0e          	ldw	(OFST+1,sp),x
5829  013a 7b20          	ld	a,(OFST+19,sp)
5830  013c               L1642:
5831                     ; 1217     if (connect_flags & MQTT_CONNECT_USER_NAME) buf += __mqtt_pack_str(buf, user_name);
5833  013c a580          	bcp	a,#128
5834  013e 2711          	jreq	L3642
5837  0140 1e1c          	ldw	x,(OFST+15,sp)
5838  0142 89            	pushw	x
5839  0143 1e10          	ldw	x,(OFST+3,sp)
5840  0145 cd0000        	call	___mqtt_pack_str
5842  0148 5b02          	addw	sp,#2
5843  014a 72fb0e        	addw	x,(OFST+1,sp)
5844  014d 1f0e          	ldw	(OFST+1,sp),x
5845  014f 7b20          	ld	a,(OFST+19,sp)
5846  0151               L3642:
5847                     ; 1219     if (connect_flags & MQTT_CONNECT_PASSWORD) buf += __mqtt_pack_str(buf, password);
5849  0151 a540          	bcp	a,#64
5850  0153 270f          	jreq	L5642
5853  0155 1e1e          	ldw	x,(OFST+17,sp)
5854  0157 89            	pushw	x
5855  0158 1e10          	ldw	x,(OFST+3,sp)
5856  015a cd0000        	call	___mqtt_pack_str
5858  015d 5b02          	addw	sp,#2
5859  015f 72fb0e        	addw	x,(OFST+1,sp)
5860  0162 1f0e          	ldw	(OFST+1,sp),x
5861  0164               L5642:
5862                     ; 1222     return buf - start;
5864  0164 72f001        	subw	x,(OFST-12,sp)
5866  0167 cc00b9        	jra	L073
5936                     	switch	.const
5937  0034               L473:
5938  0034 00000002      	dc.l	2
5939                     ; 1227 int16_t mqtt_unpack_connack_response(struct mqtt_response *mqtt_response, const uint8_t *buf)
5939                     ; 1228 {
5940                     .text:	section	.text,new
5941  0000               _mqtt_unpack_connack_response:
5943  0000 89            	pushw	x
5944  0001 5204          	subw	sp,#4
5945       00000004      OFST:	set	4
5948                     ; 1229     const uint8_t *const start = buf;
5950  0003 1e09          	ldw	x,(OFST+5,sp)
5951  0005 1f01          	ldw	(OFST-3,sp),x
5953                     ; 1233     if (mqtt_response->fixed_header.remaining_length != 2) {
5955  0007 1e05          	ldw	x,(OFST+1,sp)
5956  0009 1c0005        	addw	x,#5
5957  000c cd0000        	call	c_ltor
5959  000f ae0034        	ldw	x,#L473
5960  0012 cd0000        	call	c_lcmp
5962  0015 2705          	jreq	L5252
5963                     ; 1234       return MQTT_ERROR_MALFORMED_RESPONSE;
5965  0017 ae800c        	ldw	x,#32780
5967  001a 2011          	jra	L673
5968  001c               L5252:
5969                     ; 1237     response = &(mqtt_response->decoded.connack);
5971  001c 1e05          	ldw	x,(OFST+1,sp)
5972  001e 1c0009        	addw	x,#9
5973  0021 1f03          	ldw	(OFST-1,sp),x
5975                     ; 1239     if (*buf & 0xFE) {
5977  0023 1e09          	ldw	x,(OFST+5,sp)
5978  0025 f6            	ld	a,(x)
5979  0026 a5fe          	bcp	a,#254
5980  0028 2706          	jreq	L7252
5981                     ; 1240       return MQTT_ERROR_CONNACK_FORBIDDEN_FLAGS; /* only bit 1 can be set */
5983  002a ae8008        	ldw	x,#32776
5985  002d               L673:
5987  002d 5b06          	addw	sp,#6
5988  002f 81            	ret	
5989  0030               L7252:
5990                     ; 1242     else response->session_present_flag = *buf++;
5992  0030 5c            	incw	x
5993  0031 1f09          	ldw	(OFST+5,sp),x
5994  0033 1e03          	ldw	x,(OFST-1,sp)
5995  0035 f7            	ld	(x),a
5996                     ; 1244     if (*buf > 5u) {
5998  0036 1e09          	ldw	x,(OFST+5,sp)
5999  0038 f6            	ld	a,(x)
6000  0039 a106          	cp	a,#6
6001  003b 2505          	jrult	L3352
6002                     ; 1245       return MQTT_ERROR_CONNACK_FORBIDDEN_CODE; /* only bit 1 can be set */
6004  003d ae8009        	ldw	x,#32777
6006  0040 20eb          	jra	L673
6007  0042               L3352:
6008                     ; 1247     else response->return_code = (enum MQTTConnackReturnCode) *buf++;
6010  0042 5c            	incw	x
6011  0043 1f09          	ldw	(OFST+5,sp),x
6012  0045 1e03          	ldw	x,(OFST-1,sp)
6013  0047 e701          	ld	(1,x),a
6014                     ; 1249     return buf - start;
6016  0049 1e09          	ldw	x,(OFST+5,sp)
6017  004b 72f001        	subw	x,(OFST-3,sp)
6019  004e 20dd          	jra	L673
6073                     ; 1254 int16_t mqtt_pack_disconnect(uint8_t *buf, uint16_t bufsz)
6073                     ; 1255 {
6074                     .text:	section	.text,new
6075  0000               _mqtt_pack_disconnect:
6077  0000 89            	pushw	x
6078  0001 5209          	subw	sp,#9
6079       00000009      OFST:	set	9
6082                     ; 1257     fixed_header.control_type = MQTT_CONTROL_DISCONNECT;
6084  0003 a60e          	ld	a,#14
6085  0005 6b01          	ld	(OFST-8,sp),a
6087                     ; 1258     fixed_header.control_flags = 0;
6089  0007 7b05          	ld	a,(OFST-4,sp)
6090  0009 a4f0          	and	a,#240
6091  000b 6b05          	ld	(OFST-4,sp),a
6093                     ; 1259     fixed_header.remaining_length = 0;
6095  000d 5f            	clrw	x
6096  000e 1f08          	ldw	(OFST-1,sp),x
6097  0010 1f06          	ldw	(OFST-3,sp),x
6099                     ; 1260     return mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
6101  0012 96            	ldw	x,sp
6102  0013 5c            	incw	x
6103  0014 89            	pushw	x
6104  0015 1e10          	ldw	x,(OFST+7,sp)
6105  0017 89            	pushw	x
6106  0018 1e0e          	ldw	x,(OFST+5,sp)
6107  001a cd0000        	call	_mqtt_pack_fixed_header
6109  001d 5b0f          	addw	sp,#15
6112  001f 81            	ret	
6166                     ; 1265 int16_t mqtt_pack_ping_request(uint8_t *buf, uint16_t bufsz)
6166                     ; 1266 {
6167                     .text:	section	.text,new
6168  0000               _mqtt_pack_ping_request:
6170  0000 89            	pushw	x
6171  0001 5209          	subw	sp,#9
6172       00000009      OFST:	set	9
6175                     ; 1268     fixed_header.control_type = MQTT_CONTROL_PINGREQ;
6177  0003 a60c          	ld	a,#12
6178  0005 6b01          	ld	(OFST-8,sp),a
6180                     ; 1269     fixed_header.control_flags = 0;
6182  0007 7b05          	ld	a,(OFST-4,sp)
6183  0009 a4f0          	and	a,#240
6184  000b 6b05          	ld	(OFST-4,sp),a
6186                     ; 1270     fixed_header.remaining_length = 0;
6188  000d 5f            	clrw	x
6189  000e 1f08          	ldw	(OFST-1,sp),x
6190  0010 1f06          	ldw	(OFST-3,sp),x
6192                     ; 1271     return mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
6194  0012 96            	ldw	x,sp
6195  0013 5c            	incw	x
6196  0014 89            	pushw	x
6197  0015 1e10          	ldw	x,(OFST+7,sp)
6198  0017 89            	pushw	x
6199  0018 1e0e          	ldw	x,(OFST+5,sp)
6200  001a cd0000        	call	_mqtt_pack_fixed_header
6202  001d 5b0f          	addw	sp,#15
6205  001f 81            	ret	
6337                     ; 1276 int16_t mqtt_pack_publish_request(uint8_t *buf, uint16_t bufsz,
6337                     ; 1277                                   const char* topic_name,
6337                     ; 1278                                   uint16_t packet_id,
6337                     ; 1279                                   const void* application_message,
6337                     ; 1280                                   uint16_t application_message_size,
6337                     ; 1281                                   uint8_t publish_flags)
6337                     ; 1282 {
6338                     .text:	section	.text,new
6339  0000               _mqtt_pack_publish_request:
6341  0000 89            	pushw	x
6342  0001 5212          	subw	sp,#18
6343       00000012      OFST:	set	18
6346                     ; 1283     const uint8_t *const start = buf;
6348  0003 1f01          	ldw	(OFST-17,sp),x
6350                     ; 1290     if(buf == NULL || topic_name == NULL) {
6352  0005 2704          	jreq	L5662
6354  0007 1e19          	ldw	x,(OFST+7,sp)
6355  0009 2605          	jrne	L3662
6356  000b               L5662:
6357                     ; 1291       return MQTT_ERROR_NULLPTR;
6359  000b ae8001        	ldw	x,#32769
6361  000e 204f          	jra	L624
6362  0010               L3662:
6363                     ; 1295     inspected_qos = (uint8_t)((publish_flags & MQTT_PUBLISH_QOS_MASK) >> 1); /* mask */
6365  0010 7b21          	ld	a,(OFST+15,sp)
6366  0012 a406          	and	a,#6
6367  0014 44            	srl	a
6368  0015 6b12          	ld	(OFST+0,sp),a
6370                     ; 1298     fixed_header.control_type = MQTT_CONTROL_PUBLISH;
6372  0017 a603          	ld	a,#3
6373  0019 6b03          	ld	(OFST-15,sp),a
6375                     ; 1301     remaining_length = (uint32_t)__mqtt_packed_cstrlen(topic_name);
6377  001b cd0000        	call	_strlen
6379  001e 1c0002        	addw	x,#2
6380  0021 cd0000        	call	c_uitolx
6382  0024 96            	ldw	x,sp
6383  0025 1c000e        	addw	x,#OFST-4
6384  0028 cd0000        	call	c_rtol
6387                     ; 1302     if (inspected_qos > 0) remaining_length += 2;
6389  002b 7b12          	ld	a,(OFST+0,sp)
6390  002d 2709          	jreq	L7662
6393  002f 96            	ldw	x,sp
6394  0030 1c000e        	addw	x,#OFST-4
6395  0033 a602          	ld	a,#2
6396  0035 cd0000        	call	c_lgadc
6399  0038               L7662:
6400                     ; 1303     remaining_length += (uint32_t)application_message_size;
6402  0038 1e1f          	ldw	x,(OFST+13,sp)
6403  003a cd0000        	call	c_uitolx
6405  003d 96            	ldw	x,sp
6406  003e 1c000e        	addw	x,#OFST-4
6407  0041 cd0000        	call	c_lgadd
6410                     ; 1304     fixed_header.remaining_length = remaining_length;
6412  0044 1e10          	ldw	x,(OFST-2,sp)
6413  0046 1f0a          	ldw	(OFST-8,sp),x
6414  0048 1e0e          	ldw	x,(OFST-4,sp)
6415  004a 1f08          	ldw	(OFST-10,sp),x
6417                     ; 1307     if (inspected_qos == 0) publish_flags &= (uint8_t)(~MQTT_PUBLISH_DUP);
6419  004c 7b12          	ld	a,(OFST+0,sp)
6420  004e 2608          	jrne	L1762
6423  0050 7b21          	ld	a,(OFST+15,sp)
6424  0052 a4f7          	and	a,#247
6425  0054 6b21          	ld	(OFST+15,sp),a
6426  0056 7b12          	ld	a,(OFST+0,sp)
6427  0058               L1762:
6428                     ; 1310     if (inspected_qos == 3) {
6430  0058 a103          	cp	a,#3
6431  005a 2606          	jrne	L3762
6432                     ; 1311       return MQTT_ERROR_PUBLISH_FORBIDDEN_QOS;
6434  005c ae800a        	ldw	x,#32778
6436  005f               L624:
6438  005f 5b14          	addw	sp,#20
6439  0061 81            	ret	
6440  0062               L3762:
6441                     ; 1313     fixed_header.control_flags = publish_flags;
6443  0062 7b21          	ld	a,(OFST+15,sp)
6444  0064 1807          	xor	a,(OFST-11,sp)
6445  0066 a40f          	and	a,#15
6446  0068 1807          	xor	a,(OFST-11,sp)
6447  006a 6b07          	ld	(OFST-11,sp),a
6449                     ; 1316     rv = mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
6451  006c 96            	ldw	x,sp
6452  006d 1c0003        	addw	x,#OFST-15
6453  0070 89            	pushw	x
6454  0071 1e19          	ldw	x,(OFST+7,sp)
6455  0073 89            	pushw	x
6456  0074 1e17          	ldw	x,(OFST+5,sp)
6457  0076 cd0000        	call	_mqtt_pack_fixed_header
6459  0079 5b04          	addw	sp,#4
6460  007b 1f0c          	ldw	(OFST-6,sp),x
6462                     ; 1317     if (rv <= 0) return rv; /* something went wrong */
6464  007d 9c            	rvf	
6468  007e 2ddf          	jrsle	L624
6469                     ; 1319     buf += rv;
6471  0080 1e13          	ldw	x,(OFST+1,sp)
6472  0082 72fb0c        	addw	x,(OFST-6,sp)
6473  0085 1f13          	ldw	(OFST+1,sp),x
6474                     ; 1320     bufsz -= rv;
6476  0087 1e17          	ldw	x,(OFST+5,sp)
6477  0089 72f00c        	subw	x,(OFST-6,sp)
6478  008c 1f17          	ldw	(OFST+5,sp),x
6479                     ; 1323     if (bufsz < remaining_length) return 0;
6481  008e cd0000        	call	c_uitolx
6483  0091 96            	ldw	x,sp
6484  0092 1c000e        	addw	x,#OFST-4
6485  0095 cd0000        	call	c_lcmp
6487  0098 2403          	jruge	L7762
6490  009a 5f            	clrw	x
6492  009b 20c2          	jra	L624
6493  009d               L7762:
6494                     ; 1326     buf += __mqtt_pack_str(buf, topic_name);
6496  009d 1e19          	ldw	x,(OFST+7,sp)
6497  009f 89            	pushw	x
6498  00a0 1e15          	ldw	x,(OFST+3,sp)
6499  00a2 cd0000        	call	___mqtt_pack_str
6501  00a5 5b02          	addw	sp,#2
6502  00a7 72fb13        	addw	x,(OFST+1,sp)
6503  00aa 1f13          	ldw	(OFST+1,sp),x
6504                     ; 1327     if (inspected_qos > 0) buf += __mqtt_pack_uint16(buf, packet_id);
6506  00ac 7b12          	ld	a,(OFST+0,sp)
6507  00ae 270f          	jreq	L1072
6510  00b0 1e1b          	ldw	x,(OFST+9,sp)
6511  00b2 89            	pushw	x
6512  00b3 1e15          	ldw	x,(OFST+3,sp)
6513  00b5 cd0000        	call	___mqtt_pack_uint16
6515  00b8 5b02          	addw	sp,#2
6516  00ba 72fb13        	addw	x,(OFST+1,sp)
6517  00bd 1f13          	ldw	(OFST+1,sp),x
6518  00bf               L1072:
6519                     ; 1330     memcpy(buf, application_message, application_message_size);
6521  00bf bf00          	ldw	c_x,x
6522  00c1 161d          	ldw	y,(OFST+11,sp)
6523  00c3 90bf00        	ldw	c_y,y
6524  00c6 1e1f          	ldw	x,(OFST+13,sp)
6525  00c8 270a          	jreq	L224
6526  00ca               L424:
6527  00ca 5a            	decw	x
6528  00cb 92d600        	ld	a,([c_y.w],x)
6529  00ce 92d700        	ld	([c_x.w],x),a
6530  00d1 5d            	tnzw	x
6531  00d2 26f6          	jrne	L424
6532  00d4               L224:
6533                     ; 1331     buf += application_message_size;
6535  00d4 1e13          	ldw	x,(OFST+1,sp)
6536  00d6 72fb1f        	addw	x,(OFST+13,sp)
6537  00d9 1f13          	ldw	(OFST+1,sp),x
6538                     ; 1333     return buf - start;
6540  00db 72f001        	subw	x,(OFST-17,sp)
6542  00de cc005f        	jra	L624
6625                     	switch	.const
6626  0038               L234:
6627  0038 00000004      	dc.l	4
6628                     ; 1337 int16_t mqtt_unpack_publish_response(struct mqtt_response *mqtt_response, const uint8_t *buf)
6628                     ; 1338 {    
6629                     .text:	section	.text,new
6630  0000               _mqtt_unpack_publish_response:
6632  0000 89            	pushw	x
6633  0001 5206          	subw	sp,#6
6634       00000006      OFST:	set	6
6637                     ; 1339     const uint8_t *const start = buf;
6639  0003 1e0b          	ldw	x,(OFST+5,sp)
6640  0005 1f01          	ldw	(OFST-5,sp),x
6642                     ; 1343     fixed_header = &(mqtt_response->fixed_header);
6644  0007 1e07          	ldw	x,(OFST+1,sp)
6645  0009 1f03          	ldw	(OFST-3,sp),x
6647                     ; 1344     response = &(mqtt_response->decoded.publish);
6649  000b 1c0009        	addw	x,#9
6650  000e 1f05          	ldw	(OFST-1,sp),x
6652                     ; 1347     response->dup_flag = (uint8_t)((fixed_header->control_flags & MQTT_PUBLISH_DUP) >> 3);
6654  0010 1e03          	ldw	x,(OFST-3,sp)
6655  0012 e604          	ld	a,(4,x)
6656  0014 a40f          	and	a,#15
6657  0016 44            	srl	a
6658  0017 44            	srl	a
6659  0018 1e05          	ldw	x,(OFST-1,sp)
6660  001a 44            	srl	a
6661  001b f7            	ld	(x),a
6662                     ; 1348     response->qos_level = (uint8_t)((fixed_header->control_flags & MQTT_PUBLISH_QOS_MASK) >> 1);
6664  001c 1e03          	ldw	x,(OFST-3,sp)
6665  001e e604          	ld	a,(4,x)
6666  0020 a406          	and	a,#6
6667  0022 1e05          	ldw	x,(OFST-1,sp)
6668  0024 44            	srl	a
6669  0025 e701          	ld	(1,x),a
6670                     ; 1349     response->retain_flag = (uint8_t)(fixed_header->control_flags & MQTT_PUBLISH_RETAIN);
6672  0027 1e03          	ldw	x,(OFST-3,sp)
6673  0029 e604          	ld	a,(4,x)
6674  002b 1e05          	ldw	x,(OFST-1,sp)
6675  002d a401          	and	a,#1
6676  002f e702          	ld	(2,x),a
6677                     ; 1352     if (mqtt_response->fixed_header.remaining_length < 4) {
6679  0031 1e07          	ldw	x,(OFST+1,sp)
6680  0033 1c0005        	addw	x,#5
6681  0036 cd0000        	call	c_ltor
6683  0039 ae0038        	ldw	x,#L234
6684  003c cd0000        	call	c_lcmp
6686  003f 2405          	jruge	L7472
6687                     ; 1353         return MQTT_ERROR_MALFORMED_RESPONSE;
6689  0041 ae800c        	ldw	x,#32780
6691  0044 2072          	jra	L044
6692  0046               L7472:
6693                     ; 1357     response->topic_name_size = __mqtt_unpack_uint16(buf);
6695  0046 1e0b          	ldw	x,(OFST+5,sp)
6696  0048 cd0000        	call	___mqtt_unpack_uint16
6698  004b 1605          	ldw	y,(OFST-1,sp)
6699  004d 90ef03        	ldw	(3,y),x
6700                     ; 1358     buf += 2;
6702  0050 1e0b          	ldw	x,(OFST+5,sp)
6703  0052 1c0002        	addw	x,#2
6704  0055 1f0b          	ldw	(OFST+5,sp),x
6705                     ; 1359     response->topic_name = buf;
6707  0057 93            	ldw	x,y
6708  0058 160b          	ldw	y,(OFST+5,sp)
6709  005a ef05          	ldw	(5,x),y
6710                     ; 1360     buf += response->topic_name_size;
6712  005c ee03          	ldw	x,(3,x)
6713  005e 72fb0b        	addw	x,(OFST+5,sp)
6714  0061 1f0b          	ldw	(OFST+5,sp),x
6715                     ; 1362     if (response->qos_level > 0) {
6717  0063 1e05          	ldw	x,(OFST-1,sp)
6718  0065 6d01          	tnz	(1,x)
6719  0067 2712          	jreq	L1572
6720                     ; 1363         response->packet_id = __mqtt_unpack_uint16(buf);
6722  0069 1e0b          	ldw	x,(OFST+5,sp)
6723  006b cd0000        	call	___mqtt_unpack_uint16
6725  006e 1605          	ldw	y,(OFST-1,sp)
6726  0070 90ef07        	ldw	(7,y),x
6727                     ; 1364         buf += 2;
6729  0073 1e0b          	ldw	x,(OFST+5,sp)
6730  0075 1c0002        	addw	x,#2
6731  0078 1f0b          	ldw	(OFST+5,sp),x
6732  007a 93            	ldw	x,y
6733  007b               L1572:
6734                     ; 1368     response->application_message = buf;
6736  007b 160b          	ldw	y,(OFST+5,sp)
6737  007d ef09          	ldw	(9,x),y
6738                     ; 1369     if (response->qos_level == 0) {
6740  007f 6d01          	tnz	(1,x)
6741  0081 2614          	jrne	L3572
6742                     ; 1370         response->application_message_size = (uint16_t)(fixed_header->remaining_length - response->topic_name_size - 2);
6744  0083 1e03          	ldw	x,(OFST-3,sp)
6745  0085 1605          	ldw	y,(OFST-1,sp)
6746  0087 ee07          	ldw	x,(7,x)
6747  0089 01            	rrwa	x,a
6748  008a 90e004        	sub	a,(4,y)
6749  008d 01            	rrwa	x,a
6750  008e 90e203        	sbc	a,(3,y)
6751  0091 01            	rrwa	x,a
6752  0092 1d0002        	subw	x,#2
6754  0095 2012          	jra	L5572
6755  0097               L3572:
6756                     ; 1373         response->application_message_size = (uint16_t)(fixed_header->remaining_length - response->topic_name_size - 4);
6758  0097 1e03          	ldw	x,(OFST-3,sp)
6759  0099 1605          	ldw	y,(OFST-1,sp)
6760  009b ee07          	ldw	x,(7,x)
6761  009d 01            	rrwa	x,a
6762  009e 90e004        	sub	a,(4,y)
6763  00a1 01            	rrwa	x,a
6764  00a2 90e203        	sbc	a,(3,y)
6765  00a5 01            	rrwa	x,a
6766  00a6 1d0004        	subw	x,#4
6767  00a9               L5572:
6768  00a9 90ef0b        	ldw	(11,y),x
6769                     ; 1375     buf += response->application_message_size;
6771  00ac 1e05          	ldw	x,(OFST-1,sp)
6772  00ae ee0b          	ldw	x,(11,x)
6773  00b0 72fb0b        	addw	x,(OFST+5,sp)
6774  00b3 1f0b          	ldw	(OFST+5,sp),x
6775                     ; 1378     return buf - start;
6777  00b5 72f001        	subw	x,(OFST-5,sp)
6779  00b8               L044:
6781  00b8 5b08          	addw	sp,#8
6782  00ba 81            	ret	
6871                     ; 1383 int16_t mqtt_pack_pubxxx_request(uint8_t *buf, uint16_t bufsz, 
6871                     ; 1384                                  enum MQTTControlPacketType control_type,
6871                     ; 1385                                  uint16_t packet_id) 
6871                     ; 1386 {
6872                     .text:	section	.text,new
6873  0000               _mqtt_pack_pubxxx_request:
6875  0000 89            	pushw	x
6876  0001 520d          	subw	sp,#13
6877       0000000d      OFST:	set	13
6880                     ; 1387     const uint8_t *const start = buf;
6882  0003 1f01          	ldw	(OFST-12,sp),x
6884                     ; 1390     if (buf == NULL) {
6886  0005 2605          	jrne	L7103
6887                     ; 1391       return MQTT_ERROR_NULLPTR;
6889  0007 ae8001        	ldw	x,#32769
6891  000a 2032          	jra	L054
6892  000c               L7103:
6893                     ; 1395     fixed_header.control_type = control_type;
6895  000c 7b14          	ld	a,(OFST+7,sp)
6896  000e 6b05          	ld	(OFST-8,sp),a
6898                     ; 1396     if (control_type == MQTT_CONTROL_PUBREL) fixed_header.control_flags = 0x02;
6900  0010 a106          	cp	a,#6
6901  0012 2608          	jrne	L1203
6904  0014 7b09          	ld	a,(OFST-4,sp)
6905  0016 a4f0          	and	a,#240
6906  0018 aa02          	or	a,#2
6908  001a 2004          	jra	L3203
6909  001c               L1203:
6910                     ; 1397     else fixed_header.control_flags = 0;
6912  001c 7b09          	ld	a,(OFST-4,sp)
6913  001e a4f0          	and	a,#240
6914  0020               L3203:
6915  0020 6b09          	ld	(OFST-4,sp),a
6917                     ; 1399     fixed_header.remaining_length = 2;
6919  0022 ae0002        	ldw	x,#2
6920  0025 1f0c          	ldw	(OFST-1,sp),x
6921  0027 5f            	clrw	x
6922  0028 1f0a          	ldw	(OFST-3,sp),x
6924                     ; 1400     rv = mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
6926  002a 96            	ldw	x,sp
6927  002b 1c0005        	addw	x,#OFST-8
6928  002e 89            	pushw	x
6929  002f 1e14          	ldw	x,(OFST+7,sp)
6930  0031 89            	pushw	x
6931  0032 1e12          	ldw	x,(OFST+5,sp)
6932  0034 cd0000        	call	_mqtt_pack_fixed_header
6934  0037 5b04          	addw	sp,#4
6935  0039 1f03          	ldw	(OFST-10,sp),x
6937                     ; 1401     if (rv <= 0) return rv;
6939  003b 9c            	rvf	
6940  003c 2c03          	jrsgt	L5203
6944  003e               L054:
6946  003e 5b0f          	addw	sp,#15
6947  0040 81            	ret	
6948  0041               L5203:
6949                     ; 1402     buf += rv;
6951  0041 1e0e          	ldw	x,(OFST+1,sp)
6952  0043 72fb03        	addw	x,(OFST-10,sp)
6953  0046 1f0e          	ldw	(OFST+1,sp),x
6954                     ; 1403     bufsz -= rv;
6956  0048 1e12          	ldw	x,(OFST+5,sp)
6957  004a 72f003        	subw	x,(OFST-10,sp)
6958  004d 1f12          	ldw	(OFST+5,sp),x
6959                     ; 1405     if (bufsz < fixed_header.remaining_length) return 0;
6961  004f cd0000        	call	c_uitolx
6963  0052 96            	ldw	x,sp
6964  0053 1c000a        	addw	x,#OFST-3
6965  0056 cd0000        	call	c_lcmp
6967  0059 2403          	jruge	L7203
6970  005b 5f            	clrw	x
6972  005c 20e0          	jra	L054
6973  005e               L7203:
6974                     ; 1407     buf += __mqtt_pack_uint16(buf, packet_id);
6976  005e 1e15          	ldw	x,(OFST+8,sp)
6977  0060 89            	pushw	x
6978  0061 1e10          	ldw	x,(OFST+3,sp)
6979  0063 cd0000        	call	___mqtt_pack_uint16
6981  0066 5b02          	addw	sp,#2
6982  0068 72fb0e        	addw	x,(OFST+1,sp)
6983  006b 1f0e          	ldw	(OFST+1,sp),x
6984                     ; 1409     return buf - start;
6986  006d 72f001        	subw	x,(OFST-12,sp)
6988  0070 20cc          	jra	L054
7054                     ; 1413 int16_t mqtt_unpack_pubxxx_response(struct mqtt_response *mqtt_response, const uint8_t *buf) 
7054                     ; 1414 {
7055                     .text:	section	.text,new
7056  0000               _mqtt_unpack_pubxxx_response:
7058  0000 89            	pushw	x
7059  0001 5204          	subw	sp,#4
7060       00000004      OFST:	set	4
7063                     ; 1415     const uint8_t *const start = buf;
7065  0003 1e09          	ldw	x,(OFST+5,sp)
7066  0005 1f01          	ldw	(OFST-3,sp),x
7068                     ; 1419     if (mqtt_response->fixed_header.remaining_length != 2) {
7070  0007 1e05          	ldw	x,(OFST+1,sp)
7071  0009 1c0005        	addw	x,#5
7072  000c cd0000        	call	c_ltor
7074  000f ae0034        	ldw	x,#L473
7075  0012 cd0000        	call	c_lcmp
7077  0015 2705          	jreq	L3603
7078                     ; 1420         return MQTT_ERROR_MALFORMED_RESPONSE;
7080  0017 ae800c        	ldw	x,#32780
7082  001a 2019          	jra	L654
7083  001c               L3603:
7084                     ; 1424     packet_id = __mqtt_unpack_uint16(buf);
7086  001c 1e09          	ldw	x,(OFST+5,sp)
7087  001e cd0000        	call	___mqtt_unpack_uint16
7089  0021 1f03          	ldw	(OFST-1,sp),x
7091                     ; 1425     buf += 2;
7093  0023 1e09          	ldw	x,(OFST+5,sp)
7094  0025 1c0002        	addw	x,#2
7095  0028 1f09          	ldw	(OFST+5,sp),x
7096                     ; 1427     if (mqtt_response->fixed_header.control_type == MQTT_CONTROL_PUBACK) {
7098                     ; 1428         mqtt_response->decoded.puback.packet_id = packet_id;
7100                     ; 1430     else if (mqtt_response->fixed_header.control_type == MQTT_CONTROL_PUBREC) {
7102                     ; 1431         mqtt_response->decoded.pubrec.packet_id = packet_id;
7104                     ; 1433     else if (mqtt_response->fixed_header.control_type == MQTT_CONTROL_PUBREL) {
7106                     ; 1434         mqtt_response->decoded.pubrel.packet_id = packet_id;
7108                     ; 1437         mqtt_response->decoded.pubcomp.packet_id = packet_id;
7113  002a 1e05          	ldw	x,(OFST+1,sp)
7114  002c 1603          	ldw	y,(OFST-1,sp)
7115  002e ef09          	ldw	(9,x),y
7116                     ; 1440     return buf - start;
7118  0030 1e09          	ldw	x,(OFST+5,sp)
7119  0032 72f001        	subw	x,(OFST-3,sp)
7121  0035               L654:
7123  0035 5b06          	addw	sp,#6
7124  0037 81            	ret	
7190                     	switch	.const
7191  003c               L264:
7192  003c 00000003      	dc.l	3
7193                     ; 1445 int16_t mqtt_unpack_suback_response (struct mqtt_response *mqtt_response, const uint8_t *buf)
7193                     ; 1446 {
7194                     .text:	section	.text,new
7195  0000               _mqtt_unpack_suback_response:
7197  0000 89            	pushw	x
7198  0001 5208          	subw	sp,#8
7199       00000008      OFST:	set	8
7202                     ; 1447     const uint8_t *const start = buf;
7204  0003 1e0d          	ldw	x,(OFST+5,sp)
7205  0005 1f03          	ldw	(OFST-5,sp),x
7207                     ; 1448     uint32_t remaining_length = mqtt_response->fixed_header.remaining_length;
7209  0007 1e09          	ldw	x,(OFST+1,sp)
7210  0009 9093          	ldw	y,x
7211  000b ee07          	ldw	x,(7,x)
7212  000d 1f07          	ldw	(OFST-1,sp),x
7213  000f 93            	ldw	x,y
7214  0010 ee05          	ldw	x,(5,x)
7215  0012 1f05          	ldw	(OFST-3,sp),x
7217                     ; 1451     if (remaining_length < 3) {
7219  0014 96            	ldw	x,sp
7220  0015 1c0005        	addw	x,#OFST-3
7221  0018 cd0000        	call	c_ltor
7223  001b ae003c        	ldw	x,#L264
7224  001e cd0000        	call	c_lcmp
7226  0021 2405          	jruge	L3313
7227                     ; 1452       return MQTT_ERROR_MALFORMED_RESPONSE;
7229  0023 ae800c        	ldw	x,#32780
7231  0026 2037          	jra	L664
7232  0028               L3313:
7233                     ; 1456     mqtt_response->decoded.suback.packet_id = __mqtt_unpack_uint16(buf);
7235  0028 1e0d          	ldw	x,(OFST+5,sp)
7236  002a cd0000        	call	___mqtt_unpack_uint16
7238  002d 1609          	ldw	y,(OFST+1,sp)
7239  002f 90ef09        	ldw	(9,y),x
7240                     ; 1457     buf += 2;
7242  0032 1e0d          	ldw	x,(OFST+5,sp)
7243  0034 1c0002        	addw	x,#2
7244  0037 1f0d          	ldw	(OFST+5,sp),x
7245                     ; 1458     remaining_length -= 2;
7247  0039 96            	ldw	x,sp
7248  003a 1c0005        	addw	x,#OFST-3
7249  003d a602          	ld	a,#2
7250  003f cd0000        	call	c_lgsbc
7253                     ; 1461     mqtt_response->decoded.suback.num_return_codes = (uint16_t) remaining_length;
7255  0042 1e09          	ldw	x,(OFST+1,sp)
7256  0044 1607          	ldw	y,(OFST-1,sp)
7257  0046 ef0d          	ldw	(13,x),y
7258                     ; 1462     mqtt_response->decoded.suback.return_codes = buf;
7260  0048 160d          	ldw	y,(OFST+5,sp)
7261  004a ef0b          	ldw	(11,x),y
7262                     ; 1463     buf += remaining_length;
7264  004c 96            	ldw	x,sp
7265  004d 1c0005        	addw	x,#OFST-3
7266  0050 cd0000        	call	c_ltor
7268  0053 be02          	ldw	x,c_lreg+2
7269  0055 1f01          	ldw	(OFST-7,sp),x
7271  0057 72fb0d        	addw	x,(OFST+5,sp)
7272  005a 1f0d          	ldw	(OFST+5,sp),x
7273                     ; 1465     return buf - start;
7275  005c 72f003        	subw	x,(OFST-5,sp)
7277  005f               L664:
7279  005f 5b0a          	addw	sp,#10
7280  0061 81            	ret	
7406                     ; 1470 int16_t mqtt_pack_subscribe_request(uint8_t *buf, uint16_t bufsz, uint16_t packet_id, ...)
7406                     ; 1471 {
7407                     .text:	section	.text,new
7408  0000               _mqtt_pack_subscribe_request:
7410  0000 89            	pushw	x
7411  0001 5229          	subw	sp,#41
7412       00000029      OFST:	set	41
7415                     ; 1473     const uint8_t *const start = buf;
7417  0003 1f03          	ldw	(OFST-38,sp),x
7419                     ; 1476     uint16_t num_subs = 0;
7421  0005 5f            	clrw	x
7422  0006 1f26          	ldw	(OFST-3,sp),x
7424                     ; 1482     va_start(args, packet_id);
7426  0008 96            	ldw	x,sp
7427  0009 1c0032        	addw	x,#OFST+9
7428  000c 1f28          	ldw	(OFST-1,sp),x
7430  000e               L1123:
7431                     ; 1484         topic[num_subs] = va_arg(args, const char*);
7433  000e 1e28          	ldw	x,(OFST-1,sp)
7434  0010 1c0002        	addw	x,#2
7435  0013 1f28          	ldw	(OFST-1,sp),x
7437  0015 1d0002        	subw	x,#2
7438  0018 9096          	ldw	y,sp
7439  001a 72a90016      	addw	y,#OFST-19
7440  001e 1701          	ldw	(OFST-40,sp),y
7442  0020 1626          	ldw	y,(OFST-3,sp)
7443  0022 9058          	sllw	y
7444  0024 72f901        	addw	y,(OFST-40,sp)
7445  0027 fe            	ldw	x,(x)
7446  0028 90ff          	ldw	(y),x
7447                     ; 1485         if (topic[num_subs] == NULL) {
7449  002a 96            	ldw	x,sp
7450  002b 1c0016        	addw	x,#OFST-19
7451  002e 1f01          	ldw	(OFST-40,sp),x
7453  0030 1e26          	ldw	x,(OFST-3,sp)
7454  0032 58            	sllw	x
7455  0033 72fb01        	addw	x,(OFST-40,sp)
7456  0036 e601          	ld	a,(1,x)
7457  0038 fa            	or	a,(x)
7458  0039 2616          	jrne	L5123
7459                     ; 1487             break;
7460                     ; 1497     va_end(args);
7462                     ; 1500     fixed_header.control_type = MQTT_CONTROL_SUBSCRIBE;
7464  003b a608          	ld	a,#8
7465  003d 6b0d          	ld	(OFST-28,sp),a
7467                     ; 1501     fixed_header.control_flags = 2u;
7469  003f 7b11          	ld	a,(OFST-24,sp)
7470  0041 a4f0          	and	a,#240
7471  0043 aa02          	or	a,#2
7472  0045 6b11          	ld	(OFST-24,sp),a
7474                     ; 1502     fixed_header.remaining_length = 2u; /* size of variable header */
7476  0047 ae0002        	ldw	x,#2
7477  004a 1f14          	ldw	(OFST-21,sp),x
7478  004c 5f            	clrw	x
7479  004d 1f12          	ldw	(OFST-23,sp),x
7481                     ; 1503     for(i = 0; i < num_subs; ++i) {
7483  004f 203f          	jra	L5223
7484  0051               L5123:
7485                     ; 1490         max_qos[num_subs] = (uint8_t) va_arg(args, uint16_t);
7487  0051 1e28          	ldw	x,(OFST-1,sp)
7489  0053 e601          	ld	a,(1,x)
7490  0055 1c0002        	addw	x,#2
7491  0058 1f28          	ldw	(OFST-1,sp),x
7492  005a 96            	ldw	x,sp
7493  005b 1c0005        	addw	x,#OFST-36
7494  005e 72fb26        	addw	x,(OFST-3,sp)
7495  0061 f7            	ld	(x),a
7496                     ; 1492         ++num_subs;
7498  0062 1e26          	ldw	x,(OFST-3,sp)
7499  0064 5c            	incw	x
7500  0065 1f26          	ldw	(OFST-3,sp),x
7502                     ; 1493         if (num_subs >= MQTT_SUBSCRIBE_REQUEST_MAX_NUM_TOPICS) {
7504  0067 a30008        	cpw	x,#8
7505  006a 25a2          	jrult	L1123
7506                     ; 1494             return MQTT_ERROR_SUBSCRIBE_TOO_MANY_TOPICS;
7508  006c ae800b        	ldw	x,#32779
7510  006f 2039          	jra	L205
7511  0071               L1223:
7512                     ; 1505         fixed_header.remaining_length += __mqtt_packed_cstrlen(topic[i]) + 1;
7514  0071 1c0016        	addw	x,#OFST-19
7515  0074 1f01          	ldw	(OFST-40,sp),x
7517  0076 1e28          	ldw	x,(OFST-1,sp)
7518  0078 58            	sllw	x
7519  0079 72fb01        	addw	x,(OFST-40,sp)
7520  007c fe            	ldw	x,(x)
7521  007d cd0000        	call	_strlen
7523  0080 1c0003        	addw	x,#3
7524  0083 cd0000        	call	c_uitolx
7526  0086 96            	ldw	x,sp
7527  0087 1c0012        	addw	x,#OFST-23
7528  008a cd0000        	call	c_lgadd
7531                     ; 1503     for(i = 0; i < num_subs; ++i) {
7533  008d 1e28          	ldw	x,(OFST-1,sp)
7534  008f 5c            	incw	x
7535  0090               L5223:
7537  0090 1f28          	ldw	(OFST-1,sp),x
7541  0092 1326          	cpw	x,(OFST-3,sp)
7542  0094 96            	ldw	x,sp
7543  0095 25da          	jrult	L1223
7544                     ; 1509     rv = mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
7546  0097 1c000d        	addw	x,#OFST-28
7547  009a 89            	pushw	x
7548  009b 1e30          	ldw	x,(OFST+7,sp)
7549  009d 89            	pushw	x
7550  009e 1e2e          	ldw	x,(OFST+5,sp)
7551  00a0 cd0000        	call	_mqtt_pack_fixed_header
7553  00a3 5b04          	addw	sp,#4
7554  00a5 1f28          	ldw	(OFST-1,sp),x
7556                     ; 1510     if (rv <= 0) return rv;
7558  00a7 9c            	rvf	
7559  00a8 2c03          	jrsgt	L1323
7563  00aa               L205:
7565  00aa 5b2b          	addw	sp,#43
7566  00ac 81            	ret	
7567  00ad               L1323:
7568                     ; 1511     buf += rv;
7570  00ad 1e2a          	ldw	x,(OFST+1,sp)
7571  00af 72fb28        	addw	x,(OFST-1,sp)
7572  00b2 1f2a          	ldw	(OFST+1,sp),x
7573                     ; 1512     bufsz -= rv;
7575  00b4 1e2e          	ldw	x,(OFST+5,sp)
7576  00b6 72f028        	subw	x,(OFST-1,sp)
7577  00b9 1f2e          	ldw	(OFST+5,sp),x
7578                     ; 1515     if (bufsz < fixed_header.remaining_length) return 0;
7580  00bb cd0000        	call	c_uitolx
7582  00be 96            	ldw	x,sp
7583  00bf 1c0012        	addw	x,#OFST-23
7584  00c2 cd0000        	call	c_lcmp
7586  00c5 2403          	jruge	L3323
7589  00c7 5f            	clrw	x
7591  00c8 20e0          	jra	L205
7592  00ca               L3323:
7593                     ; 1518     buf += __mqtt_pack_uint16(buf, packet_id);
7595  00ca 1e30          	ldw	x,(OFST+7,sp)
7596  00cc 89            	pushw	x
7597  00cd 1e2c          	ldw	x,(OFST+3,sp)
7598  00cf cd0000        	call	___mqtt_pack_uint16
7600  00d2 5b02          	addw	sp,#2
7601  00d4 72fb2a        	addw	x,(OFST+1,sp)
7602  00d7 1f2a          	ldw	(OFST+1,sp),x
7603                     ; 1521     for(i = 0; i < num_subs; ++i) {
7605  00d9 5f            	clrw	x
7607  00da 202b          	jra	L1423
7608  00dc               L5323:
7609                     ; 1522         buf += __mqtt_pack_str(buf, topic[i]);
7611  00dc 96            	ldw	x,sp
7612  00dd 1c0016        	addw	x,#OFST-19
7613  00e0 1f01          	ldw	(OFST-40,sp),x
7615  00e2 1e28          	ldw	x,(OFST-1,sp)
7616  00e4 58            	sllw	x
7617  00e5 72fb01        	addw	x,(OFST-40,sp)
7618  00e8 fe            	ldw	x,(x)
7619  00e9 89            	pushw	x
7620  00ea 1e2c          	ldw	x,(OFST+3,sp)
7621  00ec cd0000        	call	___mqtt_pack_str
7623  00ef 5b02          	addw	sp,#2
7624  00f1 72fb2a        	addw	x,(OFST+1,sp)
7625  00f4 1f2a          	ldw	(OFST+1,sp),x
7626                     ; 1523         *buf++ = max_qos[i];
7628  00f6 96            	ldw	x,sp
7629  00f7 1c0005        	addw	x,#OFST-36
7630  00fa 72fb28        	addw	x,(OFST-1,sp)
7631  00fd f6            	ld	a,(x)
7632  00fe 1e2a          	ldw	x,(OFST+1,sp)
7633  0100 f7            	ld	(x),a
7634  0101 5c            	incw	x
7635  0102 1f2a          	ldw	(OFST+1,sp),x
7636                     ; 1521     for(i = 0; i < num_subs; ++i) {
7638  0104 1e28          	ldw	x,(OFST-1,sp)
7639  0106 5c            	incw	x
7640  0107               L1423:
7641  0107 1f28          	ldw	(OFST-1,sp),x
7645  0109 1326          	cpw	x,(OFST-3,sp)
7646  010b 25cf          	jrult	L5323
7647                     ; 1526     return buf - start;
7649  010d 1e2a          	ldw	x,(OFST+1,sp)
7650  010f 72f003        	subw	x,(OFST-38,sp)
7652  0112 2096          	jra	L205
7711                     ; 1531 int16_t mqtt_unpack_unsuback_response(struct mqtt_response *mqtt_response, const uint8_t *buf) 
7711                     ; 1532 {
7712                     .text:	section	.text,new
7713  0000               _mqtt_unpack_unsuback_response:
7715  0000 89            	pushw	x
7716  0001 89            	pushw	x
7717       00000002      OFST:	set	2
7720                     ; 1533     const uint8_t *const start = buf;
7722  0002 1e07          	ldw	x,(OFST+5,sp)
7723  0004 1f01          	ldw	(OFST-1,sp),x
7725                     ; 1535     if (mqtt_response->fixed_header.remaining_length != 2) {
7727  0006 1e03          	ldw	x,(OFST+1,sp)
7728  0008 1c0005        	addw	x,#5
7729  000b cd0000        	call	c_ltor
7731  000e ae0034        	ldw	x,#L473
7732  0011 cd0000        	call	c_lcmp
7734  0014 2705          	jreq	L5723
7735                     ; 1536         return MQTT_ERROR_MALFORMED_RESPONSE;
7737  0016 ae800c        	ldw	x,#32780
7739  0019 2014          	jra	L015
7740  001b               L5723:
7741                     ; 1540     mqtt_response->decoded.unsuback.packet_id = __mqtt_unpack_uint16(buf);
7743  001b 1e07          	ldw	x,(OFST+5,sp)
7744  001d cd0000        	call	___mqtt_unpack_uint16
7746  0020 1603          	ldw	y,(OFST+1,sp)
7747  0022 90ef09        	ldw	(9,y),x
7748                     ; 1541     buf += 2;
7750  0025 1e07          	ldw	x,(OFST+5,sp)
7751  0027 1c0002        	addw	x,#2
7752  002a 1f07          	ldw	(OFST+5,sp),x
7753                     ; 1543     return buf - start;
7755  002c 72f001        	subw	x,(OFST-1,sp)
7757  002f               L015:
7759  002f 5b04          	addw	sp,#4
7760  0031 81            	ret	
7876                     ; 1548 int16_t mqtt_pack_unsubscribe_request(uint8_t *buf, uint16_t bufsz, uint16_t packet_id, ...)
7876                     ; 1549 {
7877                     .text:	section	.text,new
7878  0000               _mqtt_pack_unsubscribe_request:
7880  0000 89            	pushw	x
7881  0001 5221          	subw	sp,#33
7882       00000021      OFST:	set	33
7885                     ; 1551     const uint8_t *const start = buf;
7887  0003 1f03          	ldw	(OFST-30,sp),x
7889                     ; 1554     uint16_t num_subs = 0;
7891  0005 5f            	clrw	x
7892  0006 1f1e          	ldw	(OFST-3,sp),x
7894                     ; 1559     va_start(args, packet_id);
7896  0008 96            	ldw	x,sp
7897  0009 1c002a        	addw	x,#OFST+9
7898  000c 1f20          	ldw	(OFST-1,sp),x
7900  000e               L7433:
7901                     ; 1561         topic[num_subs] = va_arg(args, const char*);
7903  000e 1e20          	ldw	x,(OFST-1,sp)
7904  0010 1c0002        	addw	x,#2
7905  0013 1f20          	ldw	(OFST-1,sp),x
7907  0015 1d0002        	subw	x,#2
7908  0018 9096          	ldw	y,sp
7909  001a 72a9000e      	addw	y,#OFST-19
7910  001e 1701          	ldw	(OFST-32,sp),y
7912  0020 161e          	ldw	y,(OFST-3,sp)
7913  0022 9058          	sllw	y
7914  0024 72f901        	addw	y,(OFST-32,sp)
7915  0027 fe            	ldw	x,(x)
7916  0028 90ff          	ldw	(y),x
7917                     ; 1562         if (topic[num_subs] == NULL) {
7919  002a 96            	ldw	x,sp
7920  002b 1c000e        	addw	x,#OFST-19
7921  002e 1f01          	ldw	(OFST-32,sp),x
7923  0030 1e1e          	ldw	x,(OFST-3,sp)
7924  0032 58            	sllw	x
7925  0033 72fb01        	addw	x,(OFST-32,sp)
7926  0036 e601          	ld	a,(1,x)
7927  0038 fa            	or	a,(x)
7928  0039 2616          	jrne	L3533
7929                     ; 1564             break;
7930                     ; 1572     va_end(args);
7932                     ; 1575     fixed_header.control_type = MQTT_CONTROL_UNSUBSCRIBE;
7934  003b a60a          	ld	a,#10
7935  003d 6b05          	ld	(OFST-28,sp),a
7937                     ; 1576     fixed_header.control_flags = 2u;
7939  003f 7b09          	ld	a,(OFST-24,sp)
7940  0041 a4f0          	and	a,#240
7941  0043 aa02          	or	a,#2
7942  0045 6b09          	ld	(OFST-24,sp),a
7944                     ; 1577     fixed_header.remaining_length = 2u; // size of variable header
7946  0047 ae0002        	ldw	x,#2
7947  004a 1f0c          	ldw	(OFST-21,sp),x
7948  004c 5f            	clrw	x
7949  004d 1f0a          	ldw	(OFST-23,sp),x
7951                     ; 1578     for(i = 0; i < num_subs; ++i) {
7953  004f 202e          	jra	L3633
7954  0051               L3533:
7955                     ; 1567         ++num_subs;
7957  0051 1e1e          	ldw	x,(OFST-3,sp)
7958  0053 5c            	incw	x
7959  0054 1f1e          	ldw	(OFST-3,sp),x
7961                     ; 1568         if (num_subs >= MQTT_UNSUBSCRIBE_REQUEST_MAX_NUM_TOPICS) {
7963  0056 a30008        	cpw	x,#8
7964  0059 25b3          	jrult	L7433
7965                     ; 1569             return MQTT_ERROR_UNSUBSCRIBE_TOO_MANY_TOPICS;
7967  005b ae800d        	ldw	x,#32781
7969  005e 2039          	jra	L425
7970  0060               L7533:
7971                     ; 1580         fixed_header.remaining_length += __mqtt_packed_cstrlen(topic[i]);
7973  0060 1c000e        	addw	x,#OFST-19
7974  0063 1f01          	ldw	(OFST-32,sp),x
7976  0065 1e20          	ldw	x,(OFST-1,sp)
7977  0067 58            	sllw	x
7978  0068 72fb01        	addw	x,(OFST-32,sp)
7979  006b fe            	ldw	x,(x)
7980  006c cd0000        	call	_strlen
7982  006f 1c0002        	addw	x,#2
7983  0072 cd0000        	call	c_uitolx
7985  0075 96            	ldw	x,sp
7986  0076 1c000a        	addw	x,#OFST-23
7987  0079 cd0000        	call	c_lgadd
7990                     ; 1578     for(i = 0; i < num_subs; ++i) {
7992  007c 1e20          	ldw	x,(OFST-1,sp)
7993  007e 5c            	incw	x
7994  007f               L3633:
7996  007f 1f20          	ldw	(OFST-1,sp),x
8000  0081 131e          	cpw	x,(OFST-3,sp)
8001  0083 96            	ldw	x,sp
8002  0084 25da          	jrult	L7533
8003                     ; 1584     rv = mqtt_pack_fixed_header(buf, bufsz, &fixed_header);
8005  0086 1c0005        	addw	x,#OFST-28
8006  0089 89            	pushw	x
8007  008a 1e28          	ldw	x,(OFST+7,sp)
8008  008c 89            	pushw	x
8009  008d 1e26          	ldw	x,(OFST+5,sp)
8010  008f cd0000        	call	_mqtt_pack_fixed_header
8012  0092 5b04          	addw	sp,#4
8013  0094 1f20          	ldw	(OFST-1,sp),x
8015                     ; 1585     if (rv <= 0) return rv;
8017  0096 9c            	rvf	
8018  0097 2c03          	jrsgt	L7633
8022  0099               L425:
8024  0099 5b23          	addw	sp,#35
8025  009b 81            	ret	
8026  009c               L7633:
8027                     ; 1586     buf += rv;
8029  009c 1e22          	ldw	x,(OFST+1,sp)
8030  009e 72fb20        	addw	x,(OFST-1,sp)
8031  00a1 1f22          	ldw	(OFST+1,sp),x
8032                     ; 1587     bufsz -= rv;
8034  00a3 1e26          	ldw	x,(OFST+5,sp)
8035  00a5 72f020        	subw	x,(OFST-1,sp)
8036  00a8 1f26          	ldw	(OFST+5,sp),x
8037                     ; 1590     if (bufsz < fixed_header.remaining_length) return 0;
8039  00aa cd0000        	call	c_uitolx
8041  00ad 96            	ldw	x,sp
8042  00ae 1c000a        	addw	x,#OFST-23
8043  00b1 cd0000        	call	c_lcmp
8045  00b4 2403          	jruge	L1733
8048  00b6 5f            	clrw	x
8050  00b7 20e0          	jra	L425
8051  00b9               L1733:
8052                     ; 1593     buf += __mqtt_pack_uint16(buf, packet_id);
8054  00b9 1e28          	ldw	x,(OFST+7,sp)
8055  00bb 89            	pushw	x
8056  00bc 1e24          	ldw	x,(OFST+3,sp)
8057  00be cd0000        	call	___mqtt_pack_uint16
8059  00c1 5b02          	addw	sp,#2
8060  00c3 72fb22        	addw	x,(OFST+1,sp)
8061  00c6 1f22          	ldw	(OFST+1,sp),x
8062                     ; 1596     for(i = 0; i < num_subs; ++i) buf += __mqtt_pack_str(buf, topic[i]);
8064  00c8 5f            	clrw	x
8066  00c9 201d          	jra	L7733
8067  00cb               L3733:
8070  00cb 96            	ldw	x,sp
8071  00cc 1c000e        	addw	x,#OFST-19
8072  00cf 1f01          	ldw	(OFST-32,sp),x
8074  00d1 1e20          	ldw	x,(OFST-1,sp)
8075  00d3 58            	sllw	x
8076  00d4 72fb01        	addw	x,(OFST-32,sp)
8077  00d7 fe            	ldw	x,(x)
8078  00d8 89            	pushw	x
8079  00d9 1e24          	ldw	x,(OFST+3,sp)
8080  00db cd0000        	call	___mqtt_pack_str
8082  00de 5b02          	addw	sp,#2
8083  00e0 72fb22        	addw	x,(OFST+1,sp)
8084  00e3 1f22          	ldw	(OFST+1,sp),x
8087  00e5 1e20          	ldw	x,(OFST-1,sp)
8088  00e7 5c            	incw	x
8089  00e8               L7733:
8090  00e8 1f20          	ldw	(OFST-1,sp),x
8094  00ea 131e          	cpw	x,(OFST-3,sp)
8095  00ec 25dd          	jrult	L3733
8096                     ; 1598     return buf - start;
8098  00ee 1e22          	ldw	x,(OFST+1,sp)
8099  00f0 72f003        	subw	x,(OFST-30,sp)
8101  00f3 20a4          	jra	L425
8155                     ; 1603 void mqtt_mq_init(struct mqtt_message_queue *mq, void *buf, uint16_t bufsz) 
8155                     ; 1604 {  
8156                     .text:	section	.text,new
8157  0000               _mqtt_mq_init:
8159  0000 89            	pushw	x
8160       00000000      OFST:	set	0
8163                     ; 1605     if(buf != NULL)
8165  0001 1e05          	ldw	x,(OFST+5,sp)
8166  0003 2748          	jreq	L1343
8167                     ; 1607         mq->mem_start = buf;
8169  0005 1e01          	ldw	x,(OFST+1,sp)
8170  0007 1605          	ldw	y,(OFST+5,sp)
8171  0009 ff            	ldw	(x),y
8172                     ; 1608         mq->mem_end = (unsigned char*)buf + bufsz;
8174  000a 93            	ldw	x,y
8175  000b 1601          	ldw	y,(OFST+1,sp)
8176  000d 72fb07        	addw	x,(OFST+7,sp)
8177  0010 90ef02        	ldw	(2,y),x
8178                     ; 1609         mq->curr = buf;
8180  0013 93            	ldw	x,y
8181  0014 1605          	ldw	y,(OFST+5,sp)
8182  0016 ef04          	ldw	(4,x),y
8183                     ; 1610         mq->queue_tail = mq->mem_end;
8185  0018 9093          	ldw	y,x
8186  001a 90ee02        	ldw	y,(2,y)
8187  001d ef08          	ldw	(8,x),y
8188                     ; 1611         mq->curr_sz = mqtt_mq_currsz(mq);
8190  001f 1601          	ldw	y,(OFST+1,sp)
8191  0021 90ee08        	ldw	y,(8,y)
8192  0024 72a2000c      	subw	y,#12
8193  0028 90bf00        	ldw	c_y,y
8194  002b 9093          	ldw	y,x
8195  002d 90ee04        	ldw	y,(4,y)
8196  0030 90b300        	cpw	y,c_y
8197  0033 2505          	jrult	L035
8198  0035 5f            	clrw	x
8199  0036 1601          	ldw	y,(OFST+1,sp)
8200  0038 2010          	jra	L235
8201  003a               L035:
8202  003a ee08          	ldw	x,(8,x)
8203  003c 1d000c        	subw	x,#12
8204  003f 1601          	ldw	y,(OFST+1,sp)
8205  0041 01            	rrwa	x,a
8206  0042 90e005        	sub	a,(5,y)
8207  0045 01            	rrwa	x,a
8208  0046 90e204        	sbc	a,(4,y)
8209  0049 01            	rrwa	x,a
8210  004a               L235:
8211  004a 90ef06        	ldw	(6,y),x
8212  004d               L1343:
8213                     ; 1613 }
8216  004d 85            	popw	x
8217  004e 81            	ret	
8264                     ; 1616 struct mqtt_queued_message* mqtt_mq_register(struct mqtt_message_queue *mq, uint16_t nbytes)
8264                     ; 1617 {
8265                     .text:	section	.text,new
8266  0000               _mqtt_mq_register:
8268  0000 89            	pushw	x
8269       00000000      OFST:	set	0
8272                     ; 1619     --(mq->queue_tail);
8274  0001 9093          	ldw	y,x
8275  0003 ee08          	ldw	x,(8,x)
8276  0005 1d000c        	subw	x,#12
8277  0008 90ef08        	ldw	(8,y),x
8278                     ; 1620     mq->queue_tail->start = mq->curr;
8280  000b 1e01          	ldw	x,(OFST+1,sp)
8281  000d 9093          	ldw	y,x
8282  000f 90ee08        	ldw	y,(8,y)
8283  0012 ee04          	ldw	x,(4,x)
8284  0014 90ff          	ldw	(y),x
8285                     ; 1621     mq->queue_tail->size = nbytes;
8287  0016 1e01          	ldw	x,(OFST+1,sp)
8288  0018 ee08          	ldw	x,(8,x)
8289  001a 1605          	ldw	y,(OFST+5,sp)
8290  001c ef02          	ldw	(2,x),y
8291                     ; 1622     mq->queue_tail->state = MQTT_QUEUED_UNSENT;
8293  001e 1e01          	ldw	x,(OFST+1,sp)
8294  0020 ee08          	ldw	x,(8,x)
8295  0022 6f04          	clr	(4,x)
8296                     ; 1625     mq->curr += nbytes;
8298  0024 1e01          	ldw	x,(OFST+1,sp)
8299  0026 9093          	ldw	y,x
8300  0028 ee04          	ldw	x,(4,x)
8301  002a 72fb05        	addw	x,(OFST+5,sp)
8302  002d 90ef04        	ldw	(4,y),x
8303                     ; 1626     mq->curr_sz = mqtt_mq_currsz(mq);
8305  0030 1e01          	ldw	x,(OFST+1,sp)
8306  0032 9093          	ldw	y,x
8307  0034 90ee08        	ldw	y,(8,y)
8308  0037 72a2000c      	subw	y,#12
8309  003b 90bf00        	ldw	c_y,y
8310  003e 9093          	ldw	y,x
8311  0040 90ee04        	ldw	y,(4,y)
8312  0043 90b300        	cpw	y,c_y
8313  0046 2505          	jrult	L635
8314  0048 5f            	clrw	x
8315  0049 1601          	ldw	y,(OFST+1,sp)
8316  004b 2010          	jra	L045
8317  004d               L635:
8318  004d ee08          	ldw	x,(8,x)
8319  004f 1d000c        	subw	x,#12
8320  0052 1601          	ldw	y,(OFST+1,sp)
8321  0054 01            	rrwa	x,a
8322  0055 90e005        	sub	a,(5,y)
8323  0058 01            	rrwa	x,a
8324  0059 90e204        	sbc	a,(4,y)
8325  005c 01            	rrwa	x,a
8326  005d               L045:
8327  005d 90ef06        	ldw	(6,y),x
8328                     ; 1628     return mq->queue_tail;
8330  0060 1e01          	ldw	x,(OFST+1,sp)
8331  0062 ee08          	ldw	x,(8,x)
8334  0064 5b02          	addw	sp,#2
8335  0066 81            	ret	
8413                     ; 1632 void mqtt_mq_clean(struct mqtt_message_queue *mq) {
8414                     .text:	section	.text,new
8415  0000               _mqtt_mq_clean:
8417  0000 89            	pushw	x
8418  0001 5208          	subw	sp,#8
8419       00000008      OFST:	set	8
8422                     ; 1635     for(new_head = mqtt_mq_get(mq, 0); new_head >= mq->queue_tail; --new_head) {
8424  0003 ee02          	ldw	x,(2,x)
8426  0005 2047          	jra	L5253
8427  0007               L5153:
8428                     ; 1636         if (new_head->state != MQTT_QUEUED_COMPLETE) break;
8430  0007 1e07          	ldw	x,(OFST-1,sp)
8431  0009 e604          	ld	a,(4,x)
8432  000b a102          	cp	a,#2
8433  000d 273f          	jreq	L5253
8435  000f               L3253:
8436                     ; 1640     if (new_head < mq->queue_tail) {
8438  000f 1e09          	ldw	x,(OFST+1,sp)
8439  0011 ee08          	ldw	x,(8,x)
8440  0013 1307          	cpw	x,(OFST-1,sp)
8441  0015 2346          	jrule	L7253
8442                     ; 1641         mq->curr = mq->mem_start;
8444  0017 1e09          	ldw	x,(OFST+1,sp)
8445  0019 9093          	ldw	y,x
8446  001b 90fe          	ldw	y,(y)
8447  001d ef04          	ldw	(4,x),y
8448                     ; 1642         mq->queue_tail = mq->mem_end;
8450  001f 9093          	ldw	y,x
8451  0021 90ee02        	ldw	y,(2,y)
8452  0024 ef08          	ldw	(8,x),y
8453                     ; 1643         mq->curr_sz = mqtt_mq_currsz(mq);
8455  0026 72a2000c      	subw	y,#12
8456  002a 90bf00        	ldw	c_y,y
8457  002d 9093          	ldw	y,x
8458  002f 90ee04        	ldw	y,(4,y)
8459  0032 90b300        	cpw	y,c_y
8460  0035 2504          	jrult	L445
8461  0037               LC022:
8462  0037 5f            	clrw	x
8463  0038 cc0146        	jp	L655
8464  003b               L445:
8465  003b ee08          	ldw	x,(8,x)
8466  003d 1d000c        	subw	x,#12
8467  0040 1609          	ldw	y,(OFST+1,sp)
8468  0042 01            	rrwa	x,a
8469  0043 90e005        	sub	a,(5,y)
8470  0046 01            	rrwa	x,a
8471  0047 90e204        	sbc	a,(4,y)
8472  004a 01            	rrwa	x,a
8473                     ; 1644         return;
8475  004b cc0148        	jp	LC020
8476  004e               L5253:
8477                     ; 1635     for(new_head = mqtt_mq_get(mq, 0); new_head >= mq->queue_tail; --new_head) {
8479  004e 1d000c        	subw	x,#12
8480  0051 1f07          	ldw	(OFST-1,sp),x
8484  0053 1e09          	ldw	x,(OFST+1,sp)
8485  0055 ee08          	ldw	x,(8,x)
8486  0057 1307          	cpw	x,(OFST-1,sp)
8487  0059 23ac          	jrule	L5153
8488  005b 20b2          	jra	L3253
8489  005d               L7253:
8490                     ; 1646     else if (new_head == mqtt_mq_get(mq, 0)) {
8492  005d 1e09          	ldw	x,(OFST+1,sp)
8493  005f ee02          	ldw	x,(2,x)
8494  0061 1d000c        	subw	x,#12
8495  0064 1307          	cpw	x,(OFST-1,sp)
8496  0066 2603          	jrne	L1353
8497                     ; 1648         return;
8498  0068               L065:
8501  0068 5b0a          	addw	sp,#10
8502  006a 81            	ret	
8503  006b               L1353:
8504                     ; 1653         uint16_t n = mq->curr - new_head->start;
8506  006b 1e09          	ldw	x,(OFST+1,sp)
8507  006d 1607          	ldw	y,(OFST-1,sp)
8508  006f ee04          	ldw	x,(4,x)
8509  0071 01            	rrwa	x,a
8510  0072 90e001        	sub	a,(1,y)
8511  0075 01            	rrwa	x,a
8512  0076 90f2          	sbc	a,(y)
8513  0078 01            	rrwa	x,a
8514  0079 1f05          	ldw	(OFST-3,sp),x
8516                     ; 1654         uint16_t removing = new_head->start - (uint8_t*) mq->mem_start;
8518  007b 93            	ldw	x,y
8519  007c 1609          	ldw	y,(OFST+1,sp)
8520  007e fe            	ldw	x,(x)
8521  007f 01            	rrwa	x,a
8522  0080 90e001        	sub	a,(1,y)
8523  0083 01            	rrwa	x,a
8524  0084 90f2          	sbc	a,(y)
8525  0086 01            	rrwa	x,a
8526  0087 1f03          	ldw	(OFST-5,sp),x
8528                     ; 1655         memmove(mq->mem_start, new_head->start, n);
8530  0089 1e05          	ldw	x,(OFST-3,sp)
8531  008b 89            	pushw	x
8532  008c 1e09          	ldw	x,(OFST+1,sp)
8533  008e fe            	ldw	x,(x)
8534  008f 89            	pushw	x
8535  0090 1e0d          	ldw	x,(OFST+5,sp)
8536  0092 fe            	ldw	x,(x)
8537  0093 cd0000        	call	_memmove
8539  0096 5b04          	addw	sp,#4
8540                     ; 1656         mq->curr = (unsigned char*)mq->mem_start + n;
8542  0098 1e09          	ldw	x,(OFST+1,sp)
8543  009a fe            	ldw	x,(x)
8544  009b 1609          	ldw	y,(OFST+1,sp)
8545  009d 72fb05        	addw	x,(OFST-3,sp)
8546  00a0 90ef04        	ldw	(4,y),x
8547                     ; 1660             int16_t new_tail_idx = new_head - mq->queue_tail;
8549  00a3 1e07          	ldw	x,(OFST-1,sp)
8550  00a5 01            	rrwa	x,a
8551  00a6 90e009        	sub	a,(9,y)
8552  00a9 01            	rrwa	x,a
8553  00aa 90e208        	sbc	a,(8,y)
8554  00ad 01            	rrwa	x,a
8555  00ae a60c          	ld	a,#12
8556  00b0 cd0000        	call	c_sdivx
8558  00b3 1f05          	ldw	(OFST-3,sp),x
8560                     ; 1661             memmove(mqtt_mq_get(mq, new_tail_idx), mq->queue_tail, sizeof(struct mqtt_queued_message) * (new_tail_idx + 1));
8562  00b5 5c            	incw	x
8563  00b6 a60c          	ld	a,#12
8564  00b8 cd0000        	call	c_bmulx
8566  00bb 89            	pushw	x
8567  00bc 1e0b          	ldw	x,(OFST+3,sp)
8568  00be ee08          	ldw	x,(8,x)
8569  00c0 89            	pushw	x
8570  00c1 1e09          	ldw	x,(OFST+1,sp)
8571  00c3 a60c          	ld	a,#12
8572  00c5 cd0000        	call	c_bmulx
8574  00c8 1f05          	ldw	(OFST-3,sp),x
8576  00ca 1e0d          	ldw	x,(OFST+5,sp)
8577  00cc ee02          	ldw	x,(2,x)
8578  00ce 1d000c        	subw	x,#12
8579  00d1 72f005        	subw	x,(OFST-3,sp)
8580  00d4 cd0000        	call	_memmove
8582  00d7 5b04          	addw	sp,#4
8583                     ; 1662             mq->queue_tail = mqtt_mq_get(mq, new_tail_idx);
8585  00d9 1e05          	ldw	x,(OFST-3,sp)
8586  00db a60c          	ld	a,#12
8587  00dd cd0000        	call	c_bmulx
8589  00e0 1f01          	ldw	(OFST-7,sp),x
8591  00e2 1e09          	ldw	x,(OFST+1,sp)
8592  00e4 ee02          	ldw	x,(2,x)
8593  00e6 1d000c        	subw	x,#12
8594  00e9 1609          	ldw	y,(OFST+1,sp)
8595  00eb 72f001        	subw	x,(OFST-7,sp)
8596  00ee 90ef08        	ldw	(8,y),x
8597                     ; 1666                 int16_t i = 0;
8599  00f1 5f            	clrw	x
8601  00f2 201e          	jra	L1453
8602  00f4               L5353:
8603                     ; 1667                 for(; i < new_tail_idx + 1; ++i) mqtt_mq_get(mq, i)->start -= removing;
8605  00f4 1e07          	ldw	x,(OFST-1,sp)
8606  00f6 a60c          	ld	a,#12
8607  00f8 cd0000        	call	c_bmulx
8609  00fb 1f01          	ldw	(OFST-7,sp),x
8611  00fd 1e09          	ldw	x,(OFST+1,sp)
8612  00ff ee02          	ldw	x,(2,x)
8613  0101 1d000c        	subw	x,#12
8614  0104 72f001        	subw	x,(OFST-7,sp)
8615  0107 9093          	ldw	y,x
8616  0109 fe            	ldw	x,(x)
8617  010a 72f003        	subw	x,(OFST-5,sp)
8618  010d 90ff          	ldw	(y),x
8621  010f 1e07          	ldw	x,(OFST-1,sp)
8622  0111 5c            	incw	x
8623  0112               L1453:
8624  0112 1f07          	ldw	(OFST-1,sp),x
8628  0114 1e05          	ldw	x,(OFST-3,sp)
8629  0116 5c            	incw	x
8630  0117 1307          	cpw	x,(OFST-1,sp)
8631  0119 2cd9          	jrsgt	L5353
8632                     ; 1673     mq->curr_sz = mqtt_mq_currsz(mq);
8634  011b 1e09          	ldw	x,(OFST+1,sp)
8635  011d 9093          	ldw	y,x
8636  011f 90ee08        	ldw	y,(8,y)
8637  0122 72a2000c      	subw	y,#12
8638  0126 90bf00        	ldw	c_y,y
8639  0129 9093          	ldw	y,x
8640  012b 90ee04        	ldw	y,(4,y)
8641  012e 90b300        	cpw	y,c_y
8642  0131 2503cc0037    	jruge	LC022
8643  0136 ee08          	ldw	x,(8,x)
8644  0138 1d000c        	subw	x,#12
8645  013b 1609          	ldw	y,(OFST+1,sp)
8646  013d 01            	rrwa	x,a
8647  013e 90e005        	sub	a,(5,y)
8648  0141 01            	rrwa	x,a
8649  0142 90e204        	sbc	a,(4,y)
8650  0145 01            	rrwa	x,a
8651  0146               L655:
8652  0146 1609          	ldw	y,(OFST+1,sp)
8653  0148               LC020:
8654  0148 90ef06        	ldw	(6,y),x
8655                     ; 1674 }
8657  014b cc0068        	jra	L065
8729                     ; 1677 struct mqtt_queued_message* mqtt_mq_find(struct mqtt_message_queue *mq, enum MQTTControlPacketType control_type, uint16_t *packet_id)
8729                     ; 1678 {
8730                     .text:	section	.text,new
8731  0000               _mqtt_mq_find:
8733  0000 89            	pushw	x
8734  0001 89            	pushw	x
8735       00000002      OFST:	set	2
8738                     ; 1680     for(curr = mqtt_mq_get(mq, 0); curr >= mq->queue_tail; --curr) {
8740  0002 ee02          	ldw	x,(2,x)
8742  0004 2025          	jra	L1163
8743  0006               L5063:
8744                     ; 1681         if (curr->control_type == control_type) {
8746  0006 1e01          	ldw	x,(OFST-1,sp)
8747  0008 e609          	ld	a,(9,x)
8748  000a 1107          	cp	a,(OFST+5,sp)
8749  000c 261b          	jrne	L5163
8750                     ; 1682             if ((packet_id == NULL && curr->state != MQTT_QUEUED_COMPLETE) ||
8750                     ; 1683                 (packet_id != NULL && *packet_id == curr->packet_id)) {
8752  000e 1e08          	ldw	x,(OFST+6,sp)
8753  0010 2608          	jrne	L3263
8755  0012 1e01          	ldw	x,(OFST-1,sp)
8756  0014 e604          	ld	a,(4,x)
8757  0016 a102          	cp	a,#2
8758  0018 261f          	jrne	L465
8759  001a               L3263:
8761  001a 1e08          	ldw	x,(OFST+6,sp)
8762  001c 270b          	jreq	L5163
8764  001e 1601          	ldw	y,(OFST-1,sp)
8765  0020 fe            	ldw	x,(x)
8766  0021 90e30a        	cpw	x,(10,y)
8767  0024 2603          	jrne	L5163
8768  0026 93            	ldw	x,y
8769                     ; 1684                 return curr;
8772  0027 2010          	jra	L465
8773  0029               L5163:
8774                     ; 1680     for(curr = mqtt_mq_get(mq, 0); curr >= mq->queue_tail; --curr) {
8776  0029 1e01          	ldw	x,(OFST-1,sp)
8777  002b               L1163:
8778  002b 1d000c        	subw	x,#12
8779  002e 1f01          	ldw	(OFST-1,sp),x
8783  0030 1e03          	ldw	x,(OFST+1,sp)
8784  0032 ee08          	ldw	x,(8,x)
8785  0034 1301          	cpw	x,(OFST-1,sp)
8786  0036 23ce          	jrule	L5063
8787                     ; 1688     return NULL;
8789  0038 5f            	clrw	x
8791  0039               L465:
8793  0039 5b04          	addw	sp,#4
8794  003b 81            	ret	
8872                     ; 1693 int16_t mqtt_unpack_response(struct mqtt_response* response, const uint8_t *buf, uint16_t bufsz)
8872                     ; 1694 {
8873                     .text:	section	.text,new
8874  0000               _mqtt_unpack_response:
8876  0000 89            	pushw	x
8877  0001 5204          	subw	sp,#4
8878       00000004      OFST:	set	4
8881                     ; 1695     const uint8_t *const start = buf;
8883  0003 1e09          	ldw	x,(OFST+5,sp)
8884  0005 1f01          	ldw	(OFST-3,sp),x
8886                     ; 1696     int16_t rv = mqtt_unpack_fixed_header(response, buf, bufsz);
8888  0007 1e0b          	ldw	x,(OFST+7,sp)
8889  0009 89            	pushw	x
8890  000a 1e0b          	ldw	x,(OFST+7,sp)
8891  000c 89            	pushw	x
8892  000d 1e09          	ldw	x,(OFST+5,sp)
8893  000f cd0000        	call	_mqtt_unpack_fixed_header
8895  0012 5b04          	addw	sp,#4
8896  0014 1f03          	ldw	(OFST-1,sp),x
8898                     ; 1698     if (rv <= 0) return rv;
8900  0016 9c            	rvf	
8904  0017 2d2c          	jrsle	L216
8905                     ; 1699     else buf += rv;
8907  0019 1e09          	ldw	x,(OFST+5,sp)
8908  001b 72fb03        	addw	x,(OFST-1,sp)
8909  001e 1f09          	ldw	(OFST+5,sp),x
8910                     ; 1701     switch(response->fixed_header.control_type) {
8912  0020 1e05          	ldw	x,(OFST+1,sp)
8913  0022 f6            	ld	a,(x)
8915                     ; 1728         default:
8915                     ; 1729             return MQTT_ERROR_RESPONSE_INVALID_CONTROL_TYPE;
8916  0023 a002          	sub	a,#2
8917  0025 2721          	jreq	L5263
8918  0027 4a            	dec	a
8919  0028 2728          	jreq	L7263
8920  002a 4a            	dec	a
8921  002b 272f          	jreq	L1363
8922  002d 4a            	dec	a
8923  002e 2736          	jreq	L3363
8924  0030 4a            	dec	a
8925  0031 273d          	jreq	L5363
8926  0033 4a            	dec	a
8927  0034 2744          	jreq	L7363
8928  0036 a002          	sub	a,#2
8929  0038 274a          	jreq	L1463
8930  003a a002          	sub	a,#2
8931  003c 2750          	jreq	L3463
8932  003e a002          	sub	a,#2
8933  0040 2756          	jreq	L5463
8936  0042 ae800e        	ldw	x,#32782
8938  0045               L216:
8940  0045 5b06          	addw	sp,#6
8941  0047 81            	ret	
8942  0048               L5263:
8943                     ; 1702         case MQTT_CONTROL_CONNACK:
8943                     ; 1703             rv = mqtt_unpack_connack_response(response, buf);
8945  0048 1e09          	ldw	x,(OFST+5,sp)
8946  004a 89            	pushw	x
8947  004b 1e07          	ldw	x,(OFST+3,sp)
8948  004d cd0000        	call	_mqtt_unpack_connack_response
8950                     ; 1704             break;
8952  0050 204a          	jra	L3173
8953  0052               L7263:
8954                     ; 1705         case MQTT_CONTROL_PUBLISH:
8954                     ; 1706             rv = mqtt_unpack_publish_response(response, buf);
8956  0052 1e09          	ldw	x,(OFST+5,sp)
8957  0054 89            	pushw	x
8958  0055 1e07          	ldw	x,(OFST+3,sp)
8959  0057 cd0000        	call	_mqtt_unpack_publish_response
8961                     ; 1707             break;
8963  005a 2040          	jra	L3173
8964  005c               L1363:
8965                     ; 1708         case MQTT_CONTROL_PUBACK:
8965                     ; 1709             rv = mqtt_unpack_pubxxx_response(response, buf);
8967  005c 1e09          	ldw	x,(OFST+5,sp)
8968  005e 89            	pushw	x
8969  005f 1e07          	ldw	x,(OFST+3,sp)
8970  0061 cd0000        	call	_mqtt_unpack_pubxxx_response
8972                     ; 1710             break;
8974  0064 2036          	jra	L3173
8975  0066               L3363:
8976                     ; 1711         case MQTT_CONTROL_PUBREC:
8976                     ; 1712             rv = mqtt_unpack_pubxxx_response(response, buf);
8978  0066 1e09          	ldw	x,(OFST+5,sp)
8979  0068 89            	pushw	x
8980  0069 1e07          	ldw	x,(OFST+3,sp)
8981  006b cd0000        	call	_mqtt_unpack_pubxxx_response
8983                     ; 1713             break;
8985  006e 202c          	jra	L3173
8986  0070               L5363:
8987                     ; 1714         case MQTT_CONTROL_PUBREL:
8987                     ; 1715             rv = mqtt_unpack_pubxxx_response(response, buf);
8989  0070 1e09          	ldw	x,(OFST+5,sp)
8990  0072 89            	pushw	x
8991  0073 1e07          	ldw	x,(OFST+3,sp)
8992  0075 cd0000        	call	_mqtt_unpack_pubxxx_response
8994                     ; 1716             break;
8996  0078 2022          	jra	L3173
8997  007a               L7363:
8998                     ; 1717         case MQTT_CONTROL_PUBCOMP:
8998                     ; 1718             rv = mqtt_unpack_pubxxx_response(response, buf);
9000  007a 1e09          	ldw	x,(OFST+5,sp)
9001  007c 89            	pushw	x
9002  007d 1e07          	ldw	x,(OFST+3,sp)
9003  007f cd0000        	call	_mqtt_unpack_pubxxx_response
9005                     ; 1719             break;
9007  0082 2018          	jra	L3173
9008  0084               L1463:
9009                     ; 1720         case MQTT_CONTROL_SUBACK:
9009                     ; 1721             rv = mqtt_unpack_suback_response(response, buf);
9011  0084 1e09          	ldw	x,(OFST+5,sp)
9012  0086 89            	pushw	x
9013  0087 1e07          	ldw	x,(OFST+3,sp)
9014  0089 cd0000        	call	_mqtt_unpack_suback_response
9016                     ; 1722             break;
9018  008c 200e          	jra	L3173
9019  008e               L3463:
9020                     ; 1723         case MQTT_CONTROL_UNSUBACK:
9020                     ; 1724             rv = mqtt_unpack_unsuback_response(response, buf);
9022  008e 1e09          	ldw	x,(OFST+5,sp)
9023  0090 89            	pushw	x
9024  0091 1e07          	ldw	x,(OFST+3,sp)
9025  0093 cd0000        	call	_mqtt_unpack_unsuback_response
9027                     ; 1725             break;
9029  0096 2004          	jra	L3173
9030  0098               L5463:
9031                     ; 1726         case MQTT_CONTROL_PINGRESP:
9031                     ; 1727             return rv;
9033  0098 1e03          	ldw	x,(OFST-1,sp)
9035  009a 20a9          	jra	L216
9036  009c               L3173:
9037  009c 5b02          	addw	sp,#2
9038  009e 1f03          	ldw	(OFST-1,sp),x
9040                     ; 1732     if (rv < 0) return rv;
9045  00a0 2ba3          	jrmi	L216
9046                     ; 1733     buf += rv;
9048  00a2 72fb09        	addw	x,(OFST+5,sp)
9049  00a5 1f09          	ldw	(OFST+5,sp),x
9050                     ; 1734     return buf - start;
9052  00a7 72f001        	subw	x,(OFST-3,sp)
9054  00aa 2099          	jra	L216
9104                     ; 1751 int16_t __mqtt_pack_uint16(uint8_t *buf, uint16_t integer)
9104                     ; 1752 {
9105                     .text:	section	.text,new
9106  0000               ___mqtt_pack_uint16:
9108  0000 89            	pushw	x
9109  0001 89            	pushw	x
9110       00000002      OFST:	set	2
9113                     ; 1753   uint16_t integer_htons = HTONS(integer);
9115  0002 1e07          	ldw	x,(OFST+5,sp)
9116  0004 1f01          	ldw	(OFST-1,sp),x
9118                     ; 1754   memcpy(buf, &integer_htons, 2);
9120  0006 1e03          	ldw	x,(OFST+1,sp)
9121  0008 bf00          	ldw	c_x,x
9122  000a 9096          	ldw	y,sp
9123  000c 905c          	incw	y
9124  000e 90bf00        	ldw	c_y,y
9125  0011 ae0002        	ldw	x,#2
9126  0014               L616:
9127  0014 5a            	decw	x
9128  0015 92d600        	ld	a,([c_y.w],x)
9129  0018 92d700        	ld	([c_x.w],x),a
9130  001b 5d            	tnzw	x
9131  001c 26f6          	jrne	L616
9132                     ; 1755   return 2;
9134  001e ae0002        	ldw	x,#2
9137  0021 5b04          	addw	sp,#4
9138  0023 81            	ret	
9182                     ; 1759 uint16_t __mqtt_unpack_uint16(const uint8_t *buf)
9182                     ; 1760 {
9183                     .text:	section	.text,new
9184  0000               ___mqtt_unpack_uint16:
9186  0000 89            	pushw	x
9187  0001 89            	pushw	x
9188       00000002      OFST:	set	2
9191                     ; 1762   memcpy(&integer_htons, buf, 2);
9193  0002 96            	ldw	x,sp
9194  0003 5c            	incw	x
9195  0004 bf00          	ldw	c_x,x
9196  0006 1603          	ldw	y,(OFST+1,sp)
9197  0008 90bf00        	ldw	c_y,y
9198  000b ae0002        	ldw	x,#2
9199  000e               L226:
9200  000e 5a            	decw	x
9201  000f 92d600        	ld	a,([c_y.w],x)
9202  0012 92d700        	ld	([c_x.w],x),a
9203  0015 5d            	tnzw	x
9204  0016 26f6          	jrne	L226
9205                     ; 1763   return HTONS(integer_htons);
9207  0018 1e01          	ldw	x,(OFST-1,sp)
9210  001a 5b04          	addw	sp,#4
9211  001c 81            	ret	
9272                     ; 1767 int16_t __mqtt_pack_str(uint8_t *buf, const char* str)
9272                     ; 1768 {
9273                     .text:	section	.text,new
9274  0000               ___mqtt_pack_str:
9276  0000 89            	pushw	x
9277  0001 5204          	subw	sp,#4
9278       00000004      OFST:	set	4
9281                     ; 1769     uint16_t length = (uint16_t)strlen(str);
9283  0003 1e09          	ldw	x,(OFST+5,sp)
9284  0005 cd0000        	call	_strlen
9286  0008 1f01          	ldw	(OFST-3,sp),x
9288                     ; 1770     int16_t i = 0;
9290  000a 5f            	clrw	x
9291  000b 1f03          	ldw	(OFST-1,sp),x
9293                     ; 1772     buf += __mqtt_pack_uint16(buf, length);
9295  000d 1e01          	ldw	x,(OFST-3,sp)
9296  000f 89            	pushw	x
9297  0010 1e07          	ldw	x,(OFST+3,sp)
9298  0012 cd0000        	call	___mqtt_pack_uint16
9300  0015 5b02          	addw	sp,#2
9301  0017 72fb05        	addw	x,(OFST+1,sp)
9302  001a 1f05          	ldw	(OFST+1,sp),x
9304  001c 1e03          	ldw	x,(OFST-1,sp)
9305  001e 200f          	jra	L3104
9306  0020               L7004:
9307                     ; 1775     for(; i < length; ++i) *(buf++) = str[i];
9309  0020 72fb09        	addw	x,(OFST+5,sp)
9310  0023 f6            	ld	a,(x)
9311  0024 1e05          	ldw	x,(OFST+1,sp)
9312  0026 f7            	ld	(x),a
9313  0027 5c            	incw	x
9314  0028 1f05          	ldw	(OFST+1,sp),x
9317  002a 1e03          	ldw	x,(OFST-1,sp)
9318  002c 5c            	incw	x
9319  002d 1f03          	ldw	(OFST-1,sp),x
9321  002f               L3104:
9324  002f 1301          	cpw	x,(OFST-3,sp)
9325  0031 25ed          	jrult	L7004
9326                     ; 1778     return length + 2;
9328  0033 1e01          	ldw	x,(OFST-3,sp)
9329  0035 1c0002        	addw	x,#2
9332  0038 5b06          	addw	sp,#6
9333  003a 81            	ret	
9397                     	switch	.bss
9398  0000               _mqtt_sendbuf:
9399  0000 000000000000  	ds.b	300
9400                     	xdef	_mqtt_sendbuf
9401  012c               _MQTT_error_status:
9402  012c 00            	ds.b	1
9403                     	xdef	_MQTT_error_status
9404                     	xref	_second_counter
9405                     	xref	_uip_flags
9406                     	xref	_uip_len
9407                     	xdef	_mqtt_disconnect
9408                     	xdef	___mqtt_ping
9409                     	xdef	_mqtt_ping
9410                     	xdef	_mqtt_unsubscribe
9411                     	xdef	_mqtt_subscribe
9412                     	xdef	___mqtt_pubcomp
9413                     	xdef	___mqtt_pubrel
9414                     	xdef	___mqtt_pubrec
9415                     	xdef	___mqtt_puback
9416                     	xdef	_mqtt_publish
9417                     	xdef	_mqtt_connect
9418                     	xdef	_mqtt_init
9419                     	xdef	_mqtt_sync
9420                     	xdef	___mqtt_recv
9421                     	xdef	___mqtt_send
9422                     	xdef	___mqtt_next_pid
9423                     	xdef	_mqtt_mq_find
9424                     	xdef	_mqtt_mq_register
9425                     	xdef	_mqtt_mq_clean
9426                     	xdef	_mqtt_mq_init
9427                     	xdef	_mqtt_pack_disconnect
9428                     	xdef	_mqtt_pack_ping_request
9429                     	xdef	_mqtt_pack_unsubscribe_request
9430                     	xdef	_mqtt_pack_subscribe_request
9431                     	xdef	_mqtt_pack_pubxxx_request
9432                     	xdef	_mqtt_pack_publish_request
9433                     	xdef	_mqtt_pack_connection_request
9434                     	xdef	_mqtt_pack_fixed_header
9435                     	xdef	_mqtt_unpack_response
9436                     	xdef	_mqtt_unpack_unsuback_response
9437                     	xdef	_mqtt_unpack_suback_response
9438                     	xdef	_mqtt_unpack_pubxxx_response
9439                     	xdef	_mqtt_unpack_publish_response
9440                     	xdef	_mqtt_unpack_connack_response
9441                     	xdef	_mqtt_unpack_fixed_header
9442                     	xdef	___mqtt_pack_str
9443                     	xdef	___mqtt_unpack_uint16
9444                     	xdef	___mqtt_pack_uint16
9445                     	xref	_mqtt_pal_recvall
9446                     	xref	_mqtt_pal_sendall
9447                     	xref	_memmove
9448                     	xref	_strlen
9449                     	switch	.const
9450  0040               L5051:
9451  0040 3f400000      	dc.w	16192,0
9452                     	xref.b	c_lreg
9453                     	xref.b	c_x
9454                     	xref.b	c_y
9474                     	xref	c_lgsbc
9475                     	xref	c_lgadc
9476                     	xref	c_lgursh
9477                     	xref	c_uitolx
9478                     	xref	c_lgadd
9479                     	xref	c_itoly
9480                     	xref	c_ltor
9481                     	xref	c_rtol
9482                     	xref	c_ftol
9483                     	xref	c_fmul
9484                     	xref	c_uitof
9485                     	xref	c_lcmp
9486                     	xref	c_ladd
9487                     	xref	c_itolx
9488                     	xref	c_bmulx
9489                     	xref	c_bmuly
9490                     	xref	c_sdivx
9491                     	end
