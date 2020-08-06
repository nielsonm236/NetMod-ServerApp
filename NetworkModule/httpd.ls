   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  17                     .const:	section	.text
  18  0000               L31_checked:
  19  0000 636865636b65  	dc.b	"checked",0
  20  0008               L51_g_HtmlPageDefault:
  21  0008 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
  22  001a 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
  23  002c 6561643e3c74  	dc.b	"ead><title>IO Cont"
  24  003e 726f6c3c2f74  	dc.b	"rol</title><style>"
  25  0050 2e7330207b20  	dc.b	".s0 { background-c"
  26  0062 6f6c6f723a20  	dc.b	"olor: red; width: "
  27  0074 333070783b20  	dc.b	"30px; }.s1 { backg"
  28  0086 726f756e642d  	dc.b	"round-color: green"
  29  0098 3b2077696474  	dc.b	"; width: 30px; }.t"
  30  00aa 31207b207769  	dc.b	"1 { width: 100px; "
  31  00bc 7d2e7432207b  	dc.b	"}.t2 { width: 148p"
  32  00ce 783b207d2e74  	dc.b	"x; }.t3 { width: 3"
  33  00e0 3070783b207d  	dc.b	"0px; }.t4 { width:"
  34  00f2 203132307078  	dc.b	" 120px; }td { text"
  35  0104 2d616c        	dc.b	"-al"
  36  0107 69676e3a2063  	dc.b	"ign: center; borde"
  37  0119 723a20317078  	dc.b	"r: 1px black solid"
  38  012b 3b207d3c2f73  	dc.b	"; }</style></head>"
  39  013d 3c626f64793e  	dc.b	"<body><h1>IO Contr"
  40  014f 6f6c3c2f6831  	dc.b	"ol</h1><form metho"
  41  0161 643d27504f53  	dc.b	"d='POST' action='/"
  42  0173 273e3c746162  	dc.b	"'><table><tr><td c"
  43  0185 6c6173733d27  	dc.b	"lass='t1'>Name:</t"
  44  0197 643e3c74643e  	dc.b	"d><td><input type="
  45  01a9 277465787427  	dc.b	"'text' name='a00' "
  46  01bb 636c6173733d  	dc.b	"class='t2' value='"
  47  01cd 256130307878  	dc.b	"%a00xxxxxxxxxxxxxx"
  48  01df 787878787878  	dc.b	"xxxxxx' pattern='["
  49  01f1 302d39612d7a  	dc.b	"0-9a-zA-Z-_*.]{1,2"
  50  0203 307d27        	dc.b	"0}'"
  51  0206 207469746c65  	dc.b	" title='1 to 20 le"
  52  0218 74746572732c  	dc.b	"tters, numbers, an"
  53  022a 64202d5f2a2e  	dc.b	"d -_*. no spaces' "
  54  023c 6d61786c656e  	dc.b	"maxlength='20'></t"
  55  024e 643e3c2f7472  	dc.b	"d></tr></table><ta"
  56  0260 626c653e3c74  	dc.b	"ble><tr><td class="
  57  0272 277431273e49  	dc.b	"'t1'>Input01</td><"
  58  0284 746420636c61  	dc.b	"td class='s%i00'><"
  59  0296 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
  60  02a8 6c6173733d27  	dc.b	"lass='t1'>Input02<"
  61  02ba 2f74643e3c74  	dc.b	"/td><td class='s%i"
  62  02cc 3031273e3c2f  	dc.b	"01'></td></tr><tr>"
  63  02de 3c746420636c  	dc.b	"<td class='t1'>Inp"
  64  02f0 757430333c2f  	dc.b	"ut03</td><td class"
  65  0302 3d2773        	dc.b	"='s"
  66  0305 25693032273e  	dc.b	"%i02'></td></tr><t"
  67  0317 723e3c746420  	dc.b	"r><td class='t1'>I"
  68  0329 6e7075743034  	dc.b	"nput04</td><td cla"
  69  033b 73733d277325  	dc.b	"ss='s%i03'></td></"
  70  034d 74723e3c7472  	dc.b	"tr><tr><td class='"
  71  035f 7431273e496e  	dc.b	"t1'>Input05</td><t"
  72  0371 6420636c6173  	dc.b	"d class='s%i04'></"
  73  0383 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
  74  0395 6173733d2774  	dc.b	"ass='t1'>Input06</"
  75  03a7 74643e3c7464  	dc.b	"td><td class='s%i0"
  76  03b9 35273e3c2f74  	dc.b	"5'></td></tr><tr><"
  77  03cb 746420636c61  	dc.b	"td class='t1'>Inpu"
  78  03dd 7430373c2f74  	dc.b	"t07</td><td class="
  79  03ef 277325693036  	dc.b	"'s%i06'></td></tr>"
  80  0401 3c7472        	dc.b	"<tr"
  81  0404 3e3c74642063  	dc.b	"><td class='t1'>In"
  82  0416 70757430383c  	dc.b	"put08</td><td clas"
  83  0428 733d27732569  	dc.b	"s='s%i07'></td></t"
  84  043a 723e3c74723e  	dc.b	"r><tr><td class='t"
  85  044c 31273e496e70  	dc.b	"1'>Input09</td><td"
  86  045e 20636c617373  	dc.b	" class='s%i08'></t"
  87  0470 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
  88  0482 73733d277431  	dc.b	"ss='t1'>Input10</t"
  89  0494 643e3c746420  	dc.b	"d><td class='s%i09"
  90  04a6 273e3c2f7464  	dc.b	"'></td></tr><tr><t"
  91  04b8 6420636c6173  	dc.b	"d class='t1'>Input"
  92  04ca 31313c2f7464  	dc.b	"11</td><td class='"
  93  04dc 732569313027  	dc.b	"s%i10'></td></tr><"
  94  04ee 74723e3c7464  	dc.b	"tr><td class='t1'>"
  95  0500 496e70        	dc.b	"Inp"
  96  0503 757431323c2f  	dc.b	"ut12</td><td class"
  97  0515 3d2773256931  	dc.b	"='s%i11'></td></tr"
  98  0527 3e3c74723e3c  	dc.b	"><tr><td class='t1"
  99  0539 273e496e7075  	dc.b	"'>Input13</td><td "
 100  054b 636c6173733d  	dc.b	"class='s%i12'></td"
 101  055d 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 102  056f 733d27743127  	dc.b	"s='t1'>Input14</td"
 103  0581 3e3c74642063  	dc.b	"><td class='s%i13'"
 104  0593 3e3c2f74643e  	dc.b	"></td></tr><tr><td"
 105  05a5 20636c617373  	dc.b	" class='t1'>Input1"
 106  05b7 353c2f74643e  	dc.b	"5</td><td class='s"
 107  05c9 25693134273e  	dc.b	"%i14'></td></tr><t"
 108  05db 723e3c746420  	dc.b	"r><td class='t1'>I"
 109  05ed 6e7075743136  	dc.b	"nput16</td><td cla"
 110  05ff 73733d        	dc.b	"ss="
 111  0602 277325693135  	dc.b	"'s%i15'></td></tr>"
 112  0614 3c2f7461626c  	dc.b	"</table><input typ"
 113  0626 653d27686964  	dc.b	"e='hidden' name='z"
 114  0638 303027207661  	dc.b	"00' value='0'<br><"
 115  064a 627574746f6e  	dc.b	"button type='submi"
 116  065c 742720746974  	dc.b	"t' title='Saves yo"
 117  066e 757220636861  	dc.b	"ur changes - does "
 118  0680 6e6f74207265  	dc.b	"not restart the Ne"
 119  0692 74776f726b20  	dc.b	"twork Module'>Save"
 120  06a4 3c2f62757474  	dc.b	"</button><button t"
 121  06b6 7970653d2772  	dc.b	"ype='reset' title="
 122  06c8 27556e2d646f  	dc.b	"'Un-does any chang"
 123  06da 657320746861  	dc.b	"es that have not b"
 124  06ec 65656e207361  	dc.b	"een saved'>Undo Al"
 125  06fe 6c3c2f        	dc.b	"l</"
 126  0701 627574746f6e  	dc.b	"button></form><for"
 127  0713 6d207374796c  	dc.b	"m style='display: "
 128  0725 696e6c696e65  	dc.b	"inline' action='%x"
 129  0737 303068747470  	dc.b	"00http://192.168.0"
 130  0749 30312e303034  	dc.b	"01.004:08080/60' m"
 131  075b 6574686f643d  	dc.b	"ethod='GET'><butto"
 132  076d 6e207469746c  	dc.b	"n title='Save firs"
 133  077f 742120546869  	dc.b	"t! This button wil"
 134  0791 6c206e6f7420  	dc.b	"l not save your ch"
 135  07a3 616e67657327  	dc.b	"anges'>Refresh</bu"
 136  07b5 74746f6e3e3c  	dc.b	"tton></form><form "
 137  07c7 7374796c653d  	dc.b	"style='display: in"
 138  07d9 6c696e652720  	dc.b	"line' action='%x00"
 139  07eb 687474703a2f  	dc.b	"http://192.168.001"
 140  07fd 2e3030        	dc.b	".00"
 141  0800 343a30383038  	dc.b	"4:08080/61' method"
 142  0812 3d2747455427  	dc.b	"='GET'><button tit"
 143  0824 6c653d275361  	dc.b	"le='Save first! Th"
 144  0836 697320627574  	dc.b	"is button will not"
 145  0848 207361766520  	dc.b	" save your changes"
 146  085a 273e41646472  	dc.b	"'>Address Settings"
 147  086c 3c2f62757474  	dc.b	"</button></form><f"
 148  087e 6f726d207374  	dc.b	"orm style='display"
 149  0890 3a20696e6c69  	dc.b	": inline' action='"
 150  08a2 257830306874  	dc.b	"%x00http://192.168"
 151  08b4 2e3030312e30  	dc.b	".001.004:08080/66'"
 152  08c6 206d6574686f  	dc.b	" method='GET'><but"
 153  08d8 746f6e207469  	dc.b	"ton title='Save fi"
 154  08ea 727374212054  	dc.b	"rst! This button w"
 155  08fc 696c6c        	dc.b	"ill"
 156  08ff 206e6f742073  	dc.b	" not save your cha"
 157  0911 6e676573273e  	dc.b	"nges'>Network Stat"
 158  0923 697374696373  	dc.b	"istics</button></f"
 159  0935 6f726d3e3c66  	dc.b	"orm><form style='d"
 160  0947 6973706c6179  	dc.b	"isplay: inline' ac"
 161  0959 74696f6e3d27  	dc.b	"tion='%x00http://1"
 162  096b 39322e313638  	dc.b	"92.168.001.004:080"
 163  097d 38302f363327  	dc.b	"80/63' method='GET"
 164  098f 273e3c627574  	dc.b	"'><button title='S"
 165  09a1 617665206669  	dc.b	"ave first! This bu"
 166  09b3 74746f6e2077  	dc.b	"tton will not save"
 167  09c5 20796f757220  	dc.b	" your changes'>Hel"
 168  09d7 703c2f627574  	dc.b	"p</button></form><"
 169  09e9 2f626f64793e  	dc.b	"/body></html>",0
 170  09f7               L71_g_HtmlPageAddress:
 171  09f7 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 172  0a09 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 173  0a1b 6561643e3c74  	dc.b	"ead><title>Address"
 174  0a2d 205365747469  	dc.b	" Settings</title><"
 175  0a3f 7374796c653e  	dc.b	"style>.t1 { width:"
 176  0a51 203130307078  	dc.b	" 100px; }.t2 { wid"
 177  0a63 74683a203235  	dc.b	"th: 25px; }.t3 { w"
 178  0a75 696474683a20  	dc.b	"idth: 18px; }.t4 {"
 179  0a87 207769647468  	dc.b	" width: 40px; }td "
 180  0a99 7b2074657874  	dc.b	"{ text-align: cent"
 181  0aab 65723b20626f  	dc.b	"er; border: 1px bl"
 182  0abd 61636b20736f  	dc.b	"ack solid; }</styl"
 183  0acf 653e3c2f6865  	dc.b	"e></head><body><h1"
 184  0ae1 3e4164647265  	dc.b	">Address Settings<"
 185  0af3 2f6831        	dc.b	"/h1"
 186  0af6 3e3c666f726d  	dc.b	"><form method='POS"
 187  0b08 542720616374  	dc.b	"T' action='/'><tab"
 188  0b1a 6c653e3c7472  	dc.b	"le><tr><td class='"
 189  0b2c 7431273e4950  	dc.b	"t1'>IP Addr</td><t"
 190  0b3e 643e3c696e70  	dc.b	"d><input type='tex"
 191  0b50 7427206e616d  	dc.b	"t' name='b00' clas"
 192  0b62 733d27743227  	dc.b	"s='t2' value='%b00"
 193  0b74 272070617474  	dc.b	"' pattern='[0-9]{3"
 194  0b86 7d2720746974  	dc.b	"}' title='Enter 00"
 195  0b98 3020746f2032  	dc.b	"0 to 255' maxlengt"
 196  0baa 683d2733273e  	dc.b	"h='3'></td><td><in"
 197  0bbc 707574207479  	dc.b	"put type='text' na"
 198  0bce 6d653d276230  	dc.b	"me='b01' class='t2"
 199  0be0 272076616c75  	dc.b	"' value='%b01' pat"
 200  0bf2 746572        	dc.b	"ter"
 201  0bf5 6e3d275b302d  	dc.b	"n='[0-9]{3}' title"
 202  0c07 3d27456e7465  	dc.b	"='Enter 000 to 255"
 203  0c19 27206d61786c  	dc.b	"' maxlength='3'></"
 204  0c2b 74643e3c7464  	dc.b	"td><td><input type"
 205  0c3d 3d2774657874  	dc.b	"='text' name='b02'"
 206  0c4f 20636c617373  	dc.b	" class='t2' value="
 207  0c61 272562303227  	dc.b	"'%b02' pattern='[0"
 208  0c73 2d395d7b337d  	dc.b	"-9]{3}' title='Ent"
 209  0c85 657220303030  	dc.b	"er 000 to 255' max"
 210  0c97 6c656e677468  	dc.b	"length='3'></td><t"
 211  0ca9 643e3c696e70  	dc.b	"d><input type='tex"
 212  0cbb 7427206e616d  	dc.b	"t' name='b03' clas"
 213  0ccd 733d27743227  	dc.b	"s='t2' value='%b03"
 214  0cdf 272070617474  	dc.b	"' pattern='[0-9]{3"
 215  0cf1 7d2720        	dc.b	"}' "
 216  0cf4 7469746c653d  	dc.b	"title='Enter 000 t"
 217  0d06 6f2032353527  	dc.b	"o 255' maxlength='"
 218  0d18 33273e3c2f74  	dc.b	"3'></td></tr><tr><"
 219  0d2a 746420636c61  	dc.b	"td class='t1'>Gate"
 220  0d3c 7761793c2f74  	dc.b	"way</td><td><input"
 221  0d4e 20747970653d  	dc.b	" type='text' name="
 222  0d60 276230342720  	dc.b	"'b04' class='t2' v"
 223  0d72 616c75653d27  	dc.b	"alue='%b04' patter"
 224  0d84 6e3d275b302d  	dc.b	"n='[0-9]{3}' title"
 225  0d96 3d27456e7465  	dc.b	"='Enter 000 to 255"
 226  0da8 27206d61786c  	dc.b	"' maxlength='3'></"
 227  0dba 74643e3c7464  	dc.b	"td><td><input type"
 228  0dcc 3d2774657874  	dc.b	"='text' name='b05'"
 229  0dde 20636c617373  	dc.b	" class='t2' value="
 230  0df0 272562        	dc.b	"'%b"
 231  0df3 303527207061  	dc.b	"05' pattern='[0-9]"
 232  0e05 7b337d272074  	dc.b	"{3}' title='Enter "
 233  0e17 30303020746f  	dc.b	"000 to 255' maxlen"
 234  0e29 6774683d2733  	dc.b	"gth='3'></td><td><"
 235  0e3b 696e70757420  	dc.b	"input type='text' "
 236  0e4d 6e616d653d27  	dc.b	"name='b06' class='"
 237  0e5f 743227207661  	dc.b	"t2' value='%b06' p"
 238  0e71 61747465726e  	dc.b	"attern='[0-9]{3}' "
 239  0e83 7469746c653d  	dc.b	"title='Enter 000 t"
 240  0e95 6f2032353527  	dc.b	"o 255' maxlength='"
 241  0ea7 33273e3c2f74  	dc.b	"3'></td><td><input"
 242  0eb9 20747970653d  	dc.b	" type='text' name="
 243  0ecb 276230372720  	dc.b	"'b07' class='t2' v"
 244  0edd 616c75653d27  	dc.b	"alue='%b07' patter"
 245  0eef 6e3d27        	dc.b	"n='"
 246  0ef2 5b302d395d7b  	dc.b	"[0-9]{3}' title='E"
 247  0f04 6e7465722030  	dc.b	"nter 000 to 255' m"
 248  0f16 61786c656e67  	dc.b	"axlength='3'></td>"
 249  0f28 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 250  0f3a 3d277431273e  	dc.b	"='t1'>Netmask</td>"
 251  0f4c 3c74643e3c69  	dc.b	"<td><input type='t"
 252  0f5e 65787427206e  	dc.b	"ext' name='b08' cl"
 253  0f70 6173733d2774  	dc.b	"ass='t2' value='%b"
 254  0f82 303827207061  	dc.b	"08' pattern='[0-9]"
 255  0f94 7b337d272074  	dc.b	"{3}' title='Enter "
 256  0fa6 30303020746f  	dc.b	"000 to 255' maxlen"
 257  0fb8 6774683d2733  	dc.b	"gth='3'></td><td><"
 258  0fca 696e70757420  	dc.b	"input type='text' "
 259  0fdc 6e616d653d27  	dc.b	"name='b09' class='"
 260  0fee 743227        	dc.b	"t2'"
 261  0ff1 2076616c7565  	dc.b	" value='%b09' patt"
 262  1003 65726e3d275b  	dc.b	"ern='[0-9]{3}' tit"
 263  1015 6c653d27456e  	dc.b	"le='Enter 000 to 2"
 264  1027 353527206d61  	dc.b	"55' maxlength='3'>"
 265  1039 3c2f74643e3c  	dc.b	"</td><td><input ty"
 266  104b 70653d277465  	dc.b	"pe='text' name='b1"
 267  105d 302720636c61  	dc.b	"0' class='t2' valu"
 268  106f 653d27256231  	dc.b	"e='%b10' pattern='"
 269  1081 5b302d395d7b  	dc.b	"[0-9]{3}' title='E"
 270  1093 6e7465722030  	dc.b	"nter 000 to 255' m"
 271  10a5 61786c656e67  	dc.b	"axlength='3'></td>"
 272  10b7 3c74643e3c69  	dc.b	"<td><input type='t"
 273  10c9 65787427206e  	dc.b	"ext' name='b11' cl"
 274  10db 6173733d2774  	dc.b	"ass='t2' value='%b"
 275  10ed 313127        	dc.b	"11'"
 276  10f0 207061747465  	dc.b	" pattern='[0-9]{3}"
 277  1102 27207469746c  	dc.b	"' title='Enter 000"
 278  1114 20746f203235  	dc.b	" to 255' maxlength"
 279  1126 3d2733273e3c  	dc.b	"='3'></td></tr></t"
 280  1138 61626c653e3c  	dc.b	"able><table><tr><t"
 281  114a 6420636c6173  	dc.b	"d class='t1'>Port "
 282  115c 20203c2f7464  	dc.b	"  </td><td><input "
 283  116e 747970653d27  	dc.b	"type='text' name='"
 284  1180 633030272063  	dc.b	"c00' class='t4' va"
 285  1192 6c75653d2725  	dc.b	"lue='%c00' pattern"
 286  11a4 3d275b302d39  	dc.b	"='[0-9]{5}' title="
 287  11b6 27456e746572  	dc.b	"'Enter 00010 to 65"
 288  11c8 35333627206d  	dc.b	"536' maxlength='5'"
 289  11da 3e3c2f74643e  	dc.b	"></td></tr></table"
 290  11ec 3e3c74        	dc.b	"><t"
 291  11ef 61626c653e3c  	dc.b	"able><tr><td class"
 292  1201 3d277431273e  	dc.b	"='t1'>MAC Address<"
 293  1213 2f74643e3c74  	dc.b	"/td><td><input typ"
 294  1225 653d27746578  	dc.b	"e='text' name='d00"
 295  1237 2720636c6173  	dc.b	"' class='t3' value"
 296  1249 3d2725643030  	dc.b	"='%d00' pattern='["
 297  125b 302d39612d66  	dc.b	"0-9a-f]{2}' title="
 298  126d 27456e746572  	dc.b	"'Enter 00 to ff' m"
 299  127f 61786c656e67  	dc.b	"axlength='2'></td>"
 300  1291 3c74643e3c69  	dc.b	"<td><input type='t"
 301  12a3 65787427206e  	dc.b	"ext' name='d01' cl"
 302  12b5 6173733d2774  	dc.b	"ass='t3' value='%d"
 303  12c7 303127207061  	dc.b	"01' pattern='[0-9a"
 304  12d9 2d665d7b327d  	dc.b	"-f]{2}' title='Ent"
 305  12eb 657220        	dc.b	"er "
 306  12ee 303020746f20  	dc.b	"00 to ff' maxlengt"
 307  1300 683d2732273e  	dc.b	"h='2'></td><td><in"
 308  1312 707574207479  	dc.b	"put type='text' na"
 309  1324 6d653d276430  	dc.b	"me='d02' class='t3"
 310  1336 272076616c75  	dc.b	"' value='%d02' pat"
 311  1348 7465726e3d27  	dc.b	"tern='[0-9a-f]{2}'"
 312  135a 207469746c65  	dc.b	" title='Enter 00 t"
 313  136c 6f2066662720  	dc.b	"o ff' maxlength='2"
 314  137e 273e3c2f7464  	dc.b	"'></td><td><input "
 315  1390 747970653d27  	dc.b	"type='text' name='"
 316  13a2 643033272063  	dc.b	"d03' class='t3' va"
 317  13b4 6c75653d2725  	dc.b	"lue='%d03' pattern"
 318  13c6 3d275b302d39  	dc.b	"='[0-9a-f]{2}' tit"
 319  13d8 6c653d27456e  	dc.b	"le='Enter 00 to ff"
 320  13ea 27206d        	dc.b	"' m"
 321  13ed 61786c656e67  	dc.b	"axlength='2'></td>"
 322  13ff 3c74643e3c69  	dc.b	"<td><input type='t"
 323  1411 65787427206e  	dc.b	"ext' name='d04' cl"
 324  1423 6173733d2774  	dc.b	"ass='t3' value='%d"
 325  1435 303427207061  	dc.b	"04' pattern='[0-9a"
 326  1447 2d665d7b327d  	dc.b	"-f]{2}' title='Ent"
 327  1459 657220303020  	dc.b	"er 00 to ff' maxle"
 328  146b 6e6774683d27  	dc.b	"ngth='2'></td><td>"
 329  147d 3c696e707574  	dc.b	"<input type='text'"
 330  148f 206e616d653d  	dc.b	" name='d05' class="
 331  14a1 277433272076  	dc.b	"'t3' value='%d05' "
 332  14b3 706174746572  	dc.b	"pattern='[0-9a-f]{"
 333  14c5 327d27207469  	dc.b	"2}' title='Enter 0"
 334  14d7 3020746f2066  	dc.b	"0 to ff' maxlength"
 335  14e9 3d2732        	dc.b	"='2"
 336  14ec 273e3c2f7464  	dc.b	"'></td></tr></tabl"
 337  14fe 653e3c627574  	dc.b	"e><button type='su"
 338  1510 626d69742720  	dc.b	"bmit' title='Saves"
 339  1522 20796f757220  	dc.b	" your changes then"
 340  1534 207265737461  	dc.b	" restarts the Netw"
 341  1546 6f726b204d6f  	dc.b	"ork Module'>Save</"
 342  1558 627574746f6e  	dc.b	"button><button typ"
 343  156a 653d27726573  	dc.b	"e='reset' title='U"
 344  157c 6e2d646f6573  	dc.b	"n-does any changes"
 345  158e 207468617420  	dc.b	" that have not bee"
 346  15a0 6e2073617665  	dc.b	"n saved'>Undo All<"
 347  15b2 2f627574746f  	dc.b	"/button></form><p "
 348  15c4 6c696e652d68  	dc.b	"line-height 20px>U"
 349  15d6 736520636175  	dc.b	"se caution when ch"
 350  15e8 616e67        	dc.b	"ang"
 351  15eb 696e67207468  	dc.b	"ing the above. If "
 352  15fd 796f75206d61  	dc.b	"you make a mistake"
 353  160f 20796f75206d  	dc.b	" you may have to<b"
 354  1621 723e72657374  	dc.b	"r>restore factory "
 355  1633 64656661756c  	dc.b	"defaults by holdin"
 356  1645 6720646f776e  	dc.b	"g down the reset b"
 357  1657 7574746f6e20  	dc.b	"utton for 10 secon"
 358  1669 64732e3c6272  	dc.b	"ds.<br><br>Make su"
 359  167b 726520746865  	dc.b	"re the MAC you ass"
 360  168d 69676e206973  	dc.b	"ign is unique to y"
 361  169f 6f7572206c6f  	dc.b	"our local network."
 362  16b1 205265636f6d  	dc.b	" Recommended<br>is"
 363  16c3 207468617420  	dc.b	" that you just inc"
 364  16d5 72656d656e74  	dc.b	"rement the lowest "
 365  16e7 6f6374        	dc.b	"oct"
 366  16ea 657420616e64  	dc.b	"et and then label "
 367  16fc 796f75722064  	dc.b	"your devices for<b"
 368  170e 723e66757475  	dc.b	"r>future reference"
 369  1720 2e3c62723e3c  	dc.b	".<br><br>If you ch"
 370  1732 616e67652074  	dc.b	"ange the highest o"
 371  1744 63746574206f  	dc.b	"ctet of the MAC yo"
 372  1756 75204d555354  	dc.b	"u MUST use an even"
 373  1768 206e756d6265  	dc.b	" number to<br>form"
 374  177a 206120756e69  	dc.b	" a unicast address"
 375  178c 2e2030302c20  	dc.b	". 00, 02, ... fc, "
 376  179e 666520657463  	dc.b	"fe etc work fine. "
 377  17b0 30312c203033  	dc.b	"01, 03 ... fd, ff "
 378  17c2 61726520666f  	dc.b	"are for<br>multica"
 379  17d4 737420616e64  	dc.b	"st and will not wo"
 380  17e6 726b2e        	dc.b	"rk."
 381  17e9 3c2f703e3c66  	dc.b	"</p><form style='d"
 382  17fb 6973706c6179  	dc.b	"isplay: inline' ac"
 383  180d 74696f6e3d27  	dc.b	"tion='%x00http://1"
 384  181f 39322e313638  	dc.b	"92.168.001.004:080"
 385  1831 38302f393127  	dc.b	"80/91' method='GET"
 386  1843 273e3c627574  	dc.b	"'><button title='S"
 387  1855 617665206669  	dc.b	"ave first! This bu"
 388  1867 74746f6e2077  	dc.b	"tton will not save"
 389  1879 20796f757220  	dc.b	" your changes'>Reb"
 390  188b 6f6f743c2f62  	dc.b	"oot</button></form"
 391  189d 3e266e627370  	dc.b	">&nbsp&nbspNOTE: R"
 392  18af 65626f6f7420  	dc.b	"eboot may cause th"
 393  18c1 652072656c61  	dc.b	"e relays to cycle."
 394  18d3 3c62723e3c62  	dc.b	"<br><br><form styl"
 395  18e5 653d27        	dc.b	"e='"
 396  18e8 646973706c61  	dc.b	"display: inline' a"
 397  18fa 6374696f6e3d  	dc.b	"ction='%x00http://"
 398  190c 3139322e3136  	dc.b	"192.168.001.004:08"
 399  191e 3038302f3630  	dc.b	"080/60' method='GE"
 400  1930 54273e3c6275  	dc.b	"T'><button title='"
 401  1942 536176652066  	dc.b	"Save first! This b"
 402  1954 7574746f6e20  	dc.b	"utton will not sav"
 403  1966 6520796f7572  	dc.b	"e your changes'>IO"
 404  1978 20436f6e7472  	dc.b	" Control</button><"
 405  198a 2f666f726d3e  	dc.b	"/form><form style="
 406  199c 27646973706c  	dc.b	"'display: inline' "
 407  19ae 616374696f6e  	dc.b	"action='%x00http:/"
 408  19c0 2f3139322e31  	dc.b	"/192.168.001.004:0"
 409  19d2 383038302f36  	dc.b	"8080/66' method='G"
 410  19e4 455427        	dc.b	"ET'"
 411  19e7 3e3c62757474  	dc.b	"><button title='Sa"
 412  19f9 766520666972  	dc.b	"ve first! This but"
 413  1a0b 746f6e207769  	dc.b	"ton will not save "
 414  1a1d 796f75722063  	dc.b	"your changes'>Netw"
 415  1a2f 6f726b205374  	dc.b	"ork Statistics</bu"
 416  1a41 74746f6e3e3c  	dc.b	"tton></form><form "
 417  1a53 7374796c653d  	dc.b	"style='display: in"
 418  1a65 6c696e652720  	dc.b	"line' action='%x00"
 419  1a77 687474703a2f  	dc.b	"http://192.168.001"
 420  1a89 2e3030343a30  	dc.b	".004:08080/63' met"
 421  1a9b 686f643d2747  	dc.b	"hod='GET'><button "
 422  1aad 7469746c653d  	dc.b	"title='Save first!"
 423  1abf 205468697320  	dc.b	" This button will "
 424  1ad1 6e6f74207361  	dc.b	"not save your chan"
 425  1ae3 676573        	dc.b	"ges"
 426  1ae6 273e48656c70  	dc.b	"'>Help</button></f"
 427  1af8 6f726d3e3c2f  	dc.b	"orm></body></html>",0
 428  1b0b               L12_g_HtmlPageHelp:
 429  1b0b 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 430  1b1d 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 431  1b2f 6561643e3c74  	dc.b	"ead><title>Help Pa"
 432  1b41 67653c2f7469  	dc.b	"ge</title><style>t"
 433  1b53 64207b207769  	dc.b	"d { width: 140px; "
 434  1b65 70616464696e  	dc.b	"padding: 0px; }</s"
 435  1b77 74796c653e3c  	dc.b	"tyle></head><body>"
 436  1b89 3c68313e4865  	dc.b	"<h1>Help Page 1</h"
 437  1b9b 313e3c70206c  	dc.b	"1><p line-height 2"
 438  1bad 3070783e5245  	dc.b	"0px>REST commands<"
 439  1bbf 62723e456e74  	dc.b	"br>Enter http://IP"
 440  1bd1 3a506f72742f  	dc.b	":Port/xx where<br>"
 441  1be3 2d204950203d  	dc.b	"- IP = the device "
 442  1bf5 495020416464  	dc.b	"IP Address, for ex"
 443  1c07 616d70        	dc.b	"amp"
 444  1c0a 6c6520313932  	dc.b	"le 192.168.1.4<br>"
 445  1c1c 2d20506f7274  	dc.b	"- Port = the devic"
 446  1c2e 6520506f7274  	dc.b	"e Port number, for"
 447  1c40 206578616d70  	dc.b	" example 8080<br>-"
 448  1c52 207878203d20  	dc.b	" xx = one of the c"
 449  1c64 6f6465732062  	dc.b	"odes below:<br>60 "
 450  1c76 3d2053686f77  	dc.b	"= Show IO Control "
 451  1c88 706167653c62  	dc.b	"page<br>61 = Show "
 452  1c9a 416464726573  	dc.b	"Address Settings p"
 453  1cac 6167653c6272  	dc.b	"age<br>63 = Show H"
 454  1cbe 656c70205061  	dc.b	"elp Page 1<br>64 ="
 455  1cd0 2053686f7720  	dc.b	" Show Help Page 2<"
 456  1ce2 62723e363520  	dc.b	"br>65 = Flash LED<"
 457  1cf4 62723e363620  	dc.b	"br>66 = Show Stati"
 458  1d06 737469        	dc.b	"sti"
 459  1d09 63733c62723e  	dc.b	"cs<br>67 = Clear S"
 460  1d1b 746174697374  	dc.b	"tatistics<br>91 = "
 461  1d2d 5265626f6f74  	dc.b	"Reboot<br>99 = Sho"
 462  1d3f 772053686f72  	dc.b	"w Short Form IO St"
 463  1d51 617475733c62  	dc.b	"atus<br></p><form "
 464  1d63 7374796c653d  	dc.b	"style='display: in"
 465  1d75 6c696e652720  	dc.b	"line' action='%x00"
 466  1d87 687474703a2f  	dc.b	"http://192.168.001"
 467  1d99 2e3030343a30  	dc.b	".004:08080/64' met"
 468  1dab 686f643d2747  	dc.b	"hod='GET'><button "
 469  1dbd 7469746c653d  	dc.b	"title='Go to next "
 470  1dcf 48656c702070  	dc.b	"Help page'>Next He"
 471  1de1 6c7020506167  	dc.b	"lp Page</button></"
 472  1df3 666f726d3e3c  	dc.b	"form></body></html"
 473  1e05 3e00          	dc.b	">",0
 474  1e07               L32_g_HtmlPageHelp2:
 475  1e07 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 476  1e19 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 477  1e2b 6561643e3c74  	dc.b	"ead><title>Help Pa"
 478  1e3d 676520323c2f  	dc.b	"ge 2</title></head"
 479  1e4f 3e3c626f6479  	dc.b	"><body><h1>Help Pa"
 480  1e61 676520323c2f  	dc.b	"ge 2</h1><p line-h"
 481  1e73 656967687420  	dc.b	"eight 20px>IP Addr"
 482  1e85 6573732c2047  	dc.b	"ess, Gateway Addre"
 483  1e97 73732c204e65  	dc.b	"ss, Netmask, Port,"
 484  1ea9 20616e64204d  	dc.b	" and MAC Address c"
 485  1ebb 616e206f6e6c  	dc.b	"an only be<br>chan"
 486  1ecd 676564207669  	dc.b	"ged via the web in"
 487  1edf 746572666163  	dc.b	"terface. If the de"
 488  1ef1 766963652062  	dc.b	"vice becomes inacc"
 489  1f03 657373        	dc.b	"ess"
 490  1f06 69626c652079  	dc.b	"ible you can<br>re"
 491  1f18 73657420746f  	dc.b	"set to factory def"
 492  1f2a 61756c747320  	dc.b	"aults by holding t"
 493  1f3c 686520726573  	dc.b	"he reset button do"
 494  1f4e 776e20666f72  	dc.b	"wn for 10 seconds."
 495  1f60 3c62723e4465  	dc.b	"<br>Defaults:<br> "
 496  1f72 495020313932  	dc.b	"IP 192.168.1.4<br>"
 497  1f84 204761746577  	dc.b	" Gateway 192.168.1"
 498  1f96 2e313c62723e  	dc.b	".1<br> Netmask 255"
 499  1fa8 2e3235352e32  	dc.b	".255.255.0<br> Por"
 500  1fba 742030383038  	dc.b	"t 08080<br> MAC c2"
 501  1fcc 2d34642d3639  	dc.b	"-4d-69-6b-65-00<br"
 502  1fde 3e3c62723e43  	dc.b	"><br>Code Revision"
 503  1ff0 203230323030  	dc.b	" 20200802 1800</p>"
 504  2002 3c666f        	dc.b	"<fo"
 505  2005 726d20737479  	dc.b	"rm style='display:"
 506  2017 20696e6c696e  	dc.b	" inline' action='%"
 507  2029 783030687474  	dc.b	"x00http://192.168."
 508  203b 3030312e3030  	dc.b	"001.004:08080/60' "
 509  204d 6d6574686f64  	dc.b	"method='GET'><butt"
 510  205f 6f6e20746974  	dc.b	"on title='Go to IO"
 511  2071 20436f6e7472  	dc.b	" Control Page'>IO "
 512  2083 436f6e74726f  	dc.b	"Control</button></"
 513  2095 666f726d3e3c  	dc.b	"form></body></html"
 514  20a7 3e00          	dc.b	">",0
 515  20a9               L52_g_HtmlPageStats:
 516  20a9 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 517  20bb 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 518  20cd 6561643e3c74  	dc.b	"ead><title>Network"
 519  20df 205374617469  	dc.b	" Statistics</title"
 520  20f1 3e3c7374796c  	dc.b	"><style>.t1 { widt"
 521  2103 683a20313030  	dc.b	"h: 100px; }.t2 { w"
 522  2115 696474683a20  	dc.b	"idth: 450px; }td {"
 523  2127 20626f726465  	dc.b	" border: 1px black"
 524  2139 20736f6c6964  	dc.b	" solid; }</style><"
 525  214b 2f686561643e  	dc.b	"/head><body><h1>Ne"
 526  215d 74776f726b20  	dc.b	"twork Statistics</"
 527  216f 68313e3c703e  	dc.b	"h1><p>Values shown"
 528  2181 206172652073  	dc.b	" are since last po"
 529  2193 776572206f6e  	dc.b	"wer on or reset</p"
 530  21a5 3e3c74        	dc.b	"><t"
 531  21a8 61626c653e3c  	dc.b	"able><tr><td class"
 532  21ba 3d277431273e  	dc.b	"='t1'>%e00xxxxxxxx"
 533  21cc 78783c2f7464  	dc.b	"xx</td><td class='"
 534  21de 7432273e4472  	dc.b	"t2'>Dropped packet"
 535  21f0 732061742074  	dc.b	"s at the IP layer<"
 536  2202 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 537  2214 6c6173733d27  	dc.b	"lass='t1'>%e01xxxx"
 538  2226 787878787878  	dc.b	"xxxxxx</td><td cla"
 539  2238 73733d277432  	dc.b	"ss='t2'>Received p"
 540  224a 61636b657473  	dc.b	"ackets at the IP l"
 541  225c 617965723c2f  	dc.b	"ayer</td></tr><tr>"
 542  226e 3c746420636c  	dc.b	"<td class='t1'>%e0"
 543  2280 327878787878  	dc.b	"2xxxxxxxxxx</td><t"
 544  2292 6420636c6173  	dc.b	"d class='t2'>Sent "
 545  22a4 706163        	dc.b	"pac"
 546  22a7 6b6574732061  	dc.b	"kets at the IP lay"
 547  22b9 65723c2f7464  	dc.b	"er</td></tr><tr><t"
 548  22cb 6420636c6173  	dc.b	"d class='t1'>%e03x"
 549  22dd 787878787878  	dc.b	"xxxxxxxxx</td><td "
 550  22ef 636c6173733d  	dc.b	"class='t2'>Packets"
 551  2301 2064726f7070  	dc.b	" dropped due to wr"
 552  2313 6f6e67204950  	dc.b	"ong IP version or "
 553  2325 686561646572  	dc.b	"header length</td>"
 554  2337 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 555  2349 3d277431273e  	dc.b	"='t1'>%e04xxxxxxxx"
 556  235b 78783c2f7464  	dc.b	"xx</td><td class='"
 557  236d 7432273e5061  	dc.b	"t2'>Packets droppe"
 558  237f 642064756520  	dc.b	"d due to wrong IP "
 559  2391 6c656e677468  	dc.b	"length, high byte<"
 560  23a3 2f7464        	dc.b	"/td"
 561  23a6 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 562  23b8 733d27743127  	dc.b	"s='t1'>%e05xxxxxxx"
 563  23ca 7878783c2f74  	dc.b	"xxx</td><td class="
 564  23dc 277432273e50  	dc.b	"'t2'>Packets dropp"
 565  23ee 656420647565  	dc.b	"ed due to wrong IP"
 566  2400 206c656e6774  	dc.b	" length, low byte<"
 567  2412 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 568  2424 6c6173733d27  	dc.b	"lass='t1'>%e06xxxx"
 569  2436 787878787878  	dc.b	"xxxxxx</td><td cla"
 570  2448 73733d277432  	dc.b	"ss='t2'>Packets dr"
 571  245a 6f7070656420  	dc.b	"opped since they w"
 572  246c 657265204950  	dc.b	"ere IP fragments</"
 573  247e 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
 574  2490 6173733d2774  	dc.b	"ass='t1'>%e07xxxxx"
 575  24a2 787878        	dc.b	"xxx"
 576  24a5 78783c2f7464  	dc.b	"xx</td><td class='"
 577  24b7 7432273e5061  	dc.b	"t2'>Packets droppe"
 578  24c9 642064756520  	dc.b	"d due to IP checks"
 579  24db 756d20657272  	dc.b	"um errors</td></tr"
 580  24ed 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 581  24ff 273e25653038  	dc.b	"'>%e08xxxxxxxxxx</"
 582  2511 74643e3c7464  	dc.b	"td><td class='t2'>"
 583  2523 5061636b6574  	dc.b	"Packets dropped si"
 584  2535 6e6365207468  	dc.b	"nce they were not "
 585  2547 49434d50206f  	dc.b	"ICMP or TCP</td></"
 586  2559 74723e3c7472  	dc.b	"tr><tr><td class='"
 587  256b 7431273e2565  	dc.b	"t1'>%e09xxxxxxxxxx"
 588  257d 3c2f74643e3c  	dc.b	"</td><td class='t2"
 589  258f 273e44726f70  	dc.b	"'>Dropped ICMP pac"
 590  25a1 6b6574        	dc.b	"ket"
 591  25a4 733c2f74643e  	dc.b	"s</td></tr><tr><td"
 592  25b6 20636c617373  	dc.b	" class='t1'>%e10xx"
 593  25c8 787878787878  	dc.b	"xxxxxxxx</td><td c"
 594  25da 6c6173733d27  	dc.b	"lass='t2'>Received"
 595  25ec 2049434d5020  	dc.b	" ICMP packets</td>"
 596  25fe 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 597  2610 3d277431273e  	dc.b	"='t1'>%e11xxxxxxxx"
 598  2622 78783c2f7464  	dc.b	"xx</td><td class='"
 599  2634 7432273e5365  	dc.b	"t2'>Sent ICMP pack"
 600  2646 6574733c2f74  	dc.b	"ets</td></tr><tr><"
 601  2658 746420636c61  	dc.b	"td class='t1'>%e12"
 602  266a 787878787878  	dc.b	"xxxxxxxxxx</td><td"
 603  267c 20636c617373  	dc.b	" class='t2'>ICMP p"
 604  268e 61636b657473  	dc.b	"ackets with a wron"
 605  26a0 672074        	dc.b	"g t"
 606  26a3 7970653c2f74  	dc.b	"ype</td></tr><tr><"
 607  26b5 746420636c61  	dc.b	"td class='t1'>%e13"
 608  26c7 787878787878  	dc.b	"xxxxxxxxxx</td><td"
 609  26d9 20636c617373  	dc.b	" class='t2'>Droppe"
 610  26eb 642054435020  	dc.b	"d TCP segments</td"
 611  26fd 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 612  270f 733d27743127  	dc.b	"s='t1'>%e14xxxxxxx"
 613  2721 7878783c2f74  	dc.b	"xxx</td><td class="
 614  2733 277432273e52  	dc.b	"'t2'>Received TCP "
 615  2745 7365676d656e  	dc.b	"segments</td></tr>"
 616  2757 3c74723e3c74  	dc.b	"<tr><td class='t1'"
 617  2769 3e2565313578  	dc.b	">%e15xxxxxxxxxx</t"
 618  277b 643e3c746420  	dc.b	"d><td class='t2'>S"
 619  278d 656e74205443  	dc.b	"ent TCP segments</"
 620  279f 74643e        	dc.b	"td>"
 621  27a2 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 622  27b4 3d277431273e  	dc.b	"='t1'>%e16xxxxxxxx"
 623  27c6 78783c2f7464  	dc.b	"xx</td><td class='"
 624  27d8 7432273e5443  	dc.b	"t2'>TCP segments w"
 625  27ea 697468206120  	dc.b	"ith a bad checksum"
 626  27fc 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 627  280e 636c6173733d  	dc.b	"class='t1'>%e17xxx"
 628  2820 787878787878  	dc.b	"xxxxxxx</td><td cl"
 629  2832 6173733d2774  	dc.b	"ass='t2'>TCP segme"
 630  2844 6e7473207769  	dc.b	"nts with a bad ACK"
 631  2856 206e756d6265  	dc.b	" number</td></tr><"
 632  2868 74723e3c7464  	dc.b	"tr><td class='t1'>"
 633  287a 256531387878  	dc.b	"%e18xxxxxxxxxx</td"
 634  288c 3e3c74642063  	dc.b	"><td class='t2'>Re"
 635  289e 636569        	dc.b	"cei"
 636  28a1 766564205443  	dc.b	"ved TCP RST (reset"
 637  28b3 29207365676d  	dc.b	") segments</td></t"
 638  28c5 723e3c74723e  	dc.b	"r><tr><td class='t"
 639  28d7 31273e256531  	dc.b	"1'>%e19xxxxxxxxxx<"
 640  28e9 2f74643e3c74  	dc.b	"/td><td class='t2'"
 641  28fb 3e5265747261  	dc.b	">Retransmitted TCP"
 642  290d 207365676d65  	dc.b	" segments</td></tr"
 643  291f 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 644  2931 273e25653230  	dc.b	"'>%e20xxxxxxxxxx</"
 645  2943 74643e3c7464  	dc.b	"td><td class='t2'>"
 646  2955 44726f707065  	dc.b	"Dropped SYNs due t"
 647  2967 6f20746f6f20  	dc.b	"o too few connecti"
 648  2979 6f6e73206176  	dc.b	"ons avaliable</td>"
 649  298b 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 650  299d 3d2774        	dc.b	"='t"
 651  29a0 31273e256532  	dc.b	"1'>%e21xxxxxxxxxx<"
 652  29b2 2f74643e3c74  	dc.b	"/td><td class='t2'"
 653  29c4 3e53594e7320  	dc.b	">SYNs for closed p"
 654  29d6 6f7274732c20  	dc.b	"orts, triggering a"
 655  29e8 205253543c2f  	dc.b	" RST</td></tr></ta"
 656  29fa 626c653e3c66  	dc.b	"ble><form style='d"
 657  2a0c 6973706c6179  	dc.b	"isplay: inline' ac"
 658  2a1e 74696f6e3d27  	dc.b	"tion='%x00http://1"
 659  2a30 39322e313638  	dc.b	"92.168.001.004:080"
 660  2a42 38302f363027  	dc.b	"80/60' method='GET"
 661  2a54 273e3c627574  	dc.b	"'><button title='G"
 662  2a66 6f20746f2049  	dc.b	"o to IO Control Pa"
 663  2a78 6765273e494f  	dc.b	"ge'>IO Control</bu"
 664  2a8a 74746f6e3e3c  	dc.b	"tton></form><form "
 665  2a9c 737479        	dc.b	"sty"
 666  2a9f 6c653d276469  	dc.b	"le='display: inlin"
 667  2ab1 652720616374  	dc.b	"e' action='%x00htt"
 668  2ac3 703a2f2f3139  	dc.b	"p://192.168.001.00"
 669  2ad5 343a30383038  	dc.b	"4:08080/67' method"
 670  2ae7 3d2747455427  	dc.b	"='GET'><button tit"
 671  2af9 6c653d27436c  	dc.b	"le='Clear Statisti"
 672  2b0b 6373273e436c  	dc.b	"cs'>Clear Statisti"
 673  2b1d 63733c2f6275  	dc.b	"cs</button></form>"
 674  2b2f 3c2f626f6479  	dc.b	"</body></html>",0
 675  2b3e               L72_g_HtmlPageRstate:
 676  2b3e 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 677  2b50 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 678  2b62 6561643e3c74  	dc.b	"ead><title>Help Pa"
 679  2b74 676520323c2f  	dc.b	"ge 2</title></head"
 680  2b86 3e3c626f6479  	dc.b	"><body><p>%f00xxxx"
 681  2b98 787878787878  	dc.b	"xxxxxxxxxxxx</p></"
 682  2baa 626f64793e3c  	dc.b	"body></html>",0
 748                     ; 778 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
 748                     ; 779 {
 750                     	switch	.text
 751  0000               L3_CopyStringP:
 753  0000 89            	pushw	x
 754  0001 5203          	subw	sp,#3
 755       00000003      OFST:	set	3
 758                     ; 784   nBytes = 0;
 760  0003 5f            	clrw	x
 762  0004 2014          	jra	L17
 763  0006               L56:
 764                     ; 786     **ppBuffer = Character;
 766  0006 1e04          	ldw	x,(OFST+1,sp)
 767  0008 fe            	ldw	x,(x)
 768  0009 f7            	ld	(x),a
 769                     ; 787     *ppBuffer = *ppBuffer + 1;
 771  000a 1e04          	ldw	x,(OFST+1,sp)
 772  000c 9093          	ldw	y,x
 773  000e fe            	ldw	x,(x)
 774  000f 5c            	incw	x
 775  0010 90ff          	ldw	(y),x
 776                     ; 788     pString = pString + 1;
 778  0012 1e08          	ldw	x,(OFST+5,sp)
 779  0014 5c            	incw	x
 780  0015 1f08          	ldw	(OFST+5,sp),x
 781                     ; 789     nBytes++;
 783  0017 1e01          	ldw	x,(OFST-2,sp)
 784  0019 5c            	incw	x
 785  001a               L17:
 786  001a 1f01          	ldw	(OFST-2,sp),x
 788                     ; 785   while ((Character = pString[0]) != '\0') {
 788                     ; 786     **ppBuffer = Character;
 788                     ; 787     *ppBuffer = *ppBuffer + 1;
 788                     ; 788     pString = pString + 1;
 788                     ; 789     nBytes++;
 790  001c 1e08          	ldw	x,(OFST+5,sp)
 791  001e f6            	ld	a,(x)
 792  001f 6b03          	ld	(OFST+0,sp),a
 794  0021 26e3          	jrne	L56
 795                     ; 791   return nBytes;
 797  0023 1e01          	ldw	x,(OFST-2,sp)
 800  0025 5b05          	addw	sp,#5
 801  0027 81            	ret	
 846                     ; 795 static uint16_t CopyValue(uint8_t** ppBuffer, uint32_t nValue)
 846                     ; 796 {
 847                     	switch	.text
 848  0028               L5_CopyValue:
 850  0028 89            	pushw	x
 851       00000000      OFST:	set	0
 854                     ; 804   emb_itoa(nValue, OctetArray, 10, 5);
 856  0029 4b05          	push	#5
 857  002b 4b0a          	push	#10
 858  002d ae0000        	ldw	x,#_OctetArray
 859  0030 89            	pushw	x
 860  0031 1e0b          	ldw	x,(OFST+11,sp)
 861  0033 89            	pushw	x
 862  0034 1e0b          	ldw	x,(OFST+11,sp)
 863  0036 89            	pushw	x
 864  0037 ad53          	call	_emb_itoa
 866  0039 5b08          	addw	sp,#8
 867                     ; 806   **ppBuffer = OctetArray[0];
 869  003b 1e01          	ldw	x,(OFST+1,sp)
 870  003d fe            	ldw	x,(x)
 871  003e c60000        	ld	a,_OctetArray
 872  0041 f7            	ld	(x),a
 873                     ; 807   *ppBuffer = *ppBuffer + 1;
 875  0042 1e01          	ldw	x,(OFST+1,sp)
 876  0044 9093          	ldw	y,x
 877  0046 fe            	ldw	x,(x)
 878  0047 5c            	incw	x
 879  0048 90ff          	ldw	(y),x
 880                     ; 809   **ppBuffer = OctetArray[1];
 882  004a 1e01          	ldw	x,(OFST+1,sp)
 883  004c fe            	ldw	x,(x)
 884  004d c60001        	ld	a,_OctetArray+1
 885  0050 f7            	ld	(x),a
 886                     ; 810   *ppBuffer = *ppBuffer + 1;
 888  0051 1e01          	ldw	x,(OFST+1,sp)
 889  0053 9093          	ldw	y,x
 890  0055 fe            	ldw	x,(x)
 891  0056 5c            	incw	x
 892  0057 90ff          	ldw	(y),x
 893                     ; 812   **ppBuffer = OctetArray[2];
 895  0059 1e01          	ldw	x,(OFST+1,sp)
 896  005b fe            	ldw	x,(x)
 897  005c c60002        	ld	a,_OctetArray+2
 898  005f f7            	ld	(x),a
 899                     ; 813   *ppBuffer = *ppBuffer + 1;
 901  0060 1e01          	ldw	x,(OFST+1,sp)
 902  0062 9093          	ldw	y,x
 903  0064 fe            	ldw	x,(x)
 904  0065 5c            	incw	x
 905  0066 90ff          	ldw	(y),x
 906                     ; 815   **ppBuffer = OctetArray[3];
 908  0068 1e01          	ldw	x,(OFST+1,sp)
 909  006a fe            	ldw	x,(x)
 910  006b c60003        	ld	a,_OctetArray+3
 911  006e f7            	ld	(x),a
 912                     ; 816   *ppBuffer = *ppBuffer + 1;
 914  006f 1e01          	ldw	x,(OFST+1,sp)
 915  0071 9093          	ldw	y,x
 916  0073 fe            	ldw	x,(x)
 917  0074 5c            	incw	x
 918  0075 90ff          	ldw	(y),x
 919                     ; 818   **ppBuffer = OctetArray[4];
 921  0077 1e01          	ldw	x,(OFST+1,sp)
 922  0079 fe            	ldw	x,(x)
 923  007a c60004        	ld	a,_OctetArray+4
 924  007d f7            	ld	(x),a
 925                     ; 819   *ppBuffer = *ppBuffer + 1;
 927  007e 1e01          	ldw	x,(OFST+1,sp)
 928  0080 9093          	ldw	y,x
 929  0082 fe            	ldw	x,(x)
 930  0083 5c            	incw	x
 931  0084 90ff          	ldw	(y),x
 932                     ; 821   return 5;
 934  0086 ae0005        	ldw	x,#5
 937  0089 5b02          	addw	sp,#2
 938  008b 81            	ret	
1010                     ; 825 char* emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
1010                     ; 826 {
1011                     	switch	.text
1012  008c               _emb_itoa:
1014  008c 5206          	subw	sp,#6
1015       00000006      OFST:	set	6
1018                     ; 841   for (i=0; i < 10; i++) str[i] = '0';
1020  008e 4f            	clr	a
1021  008f 6b06          	ld	(OFST+0,sp),a
1023  0091               L541:
1026  0091 5f            	clrw	x
1027  0092 97            	ld	xl,a
1028  0093 72fb0d        	addw	x,(OFST+7,sp)
1029  0096 a630          	ld	a,#48
1030  0098 f7            	ld	(x),a
1033  0099 0c06          	inc	(OFST+0,sp)
1037  009b 7b06          	ld	a,(OFST+0,sp)
1038  009d a10a          	cp	a,#10
1039  009f 25f0          	jrult	L541
1040                     ; 842   str[pad] = '\0';
1042  00a1 7b10          	ld	a,(OFST+10,sp)
1043  00a3 5f            	clrw	x
1044  00a4 97            	ld	xl,a
1045  00a5 72fb0d        	addw	x,(OFST+7,sp)
1046  00a8 7f            	clr	(x)
1047                     ; 843   if (num == 0) return str;
1049  00a9 96            	ldw	x,sp
1050  00aa 1c0009        	addw	x,#OFST+3
1051  00ad cd0000        	call	c_lzmp
1055  00b0 2775          	jreq	L61
1056                     ; 846   i = 0;
1058  00b2 0f06          	clr	(OFST+0,sp)
1061  00b4 2060          	jra	L161
1062  00b6               L551:
1063                     ; 848     rem = (uint8_t)(num % base);
1065  00b6 7b0f          	ld	a,(OFST+9,sp)
1066  00b8 b703          	ld	c_lreg+3,a
1067  00ba 3f02          	clr	c_lreg+2
1068  00bc 3f01          	clr	c_lreg+1
1069  00be 3f00          	clr	c_lreg
1070  00c0 96            	ldw	x,sp
1071  00c1 5c            	incw	x
1072  00c2 cd0000        	call	c_rtol
1075  00c5 96            	ldw	x,sp
1076  00c6 1c0009        	addw	x,#OFST+3
1077  00c9 cd0000        	call	c_ltor
1079  00cc 96            	ldw	x,sp
1080  00cd 5c            	incw	x
1081  00ce cd0000        	call	c_lumd
1083  00d1 b603          	ld	a,c_lreg+3
1084  00d3 6b05          	ld	(OFST-1,sp),a
1086                     ; 849     if (rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
1088  00d5 a10a          	cp	a,#10
1089  00d7 7b06          	ld	a,(OFST+0,sp)
1090  00d9 250d          	jrult	L561
1093  00db 0c06          	inc	(OFST+0,sp)
1095  00dd 5f            	clrw	x
1096  00de 97            	ld	xl,a
1097  00df 72fb0d        	addw	x,(OFST+7,sp)
1098  00e2 7b05          	ld	a,(OFST-1,sp)
1099  00e4 ab57          	add	a,#87
1101  00e6 200b          	jra	L761
1102  00e8               L561:
1103                     ; 850     else str[i++] = (uint8_t)(rem + '0');
1105  00e8 0c06          	inc	(OFST+0,sp)
1107  00ea 5f            	clrw	x
1108  00eb 97            	ld	xl,a
1109  00ec 72fb0d        	addw	x,(OFST+7,sp)
1110  00ef 7b05          	ld	a,(OFST-1,sp)
1111  00f1 ab30          	add	a,#48
1112  00f3               L761:
1113  00f3 f7            	ld	(x),a
1114                     ; 851     num = num/base;
1116  00f4 7b0f          	ld	a,(OFST+9,sp)
1117  00f6 b703          	ld	c_lreg+3,a
1118  00f8 3f02          	clr	c_lreg+2
1119  00fa 3f01          	clr	c_lreg+1
1120  00fc 3f00          	clr	c_lreg
1121  00fe 96            	ldw	x,sp
1122  00ff 5c            	incw	x
1123  0100 cd0000        	call	c_rtol
1126  0103 96            	ldw	x,sp
1127  0104 1c0009        	addw	x,#OFST+3
1128  0107 cd0000        	call	c_ltor
1130  010a 96            	ldw	x,sp
1131  010b 5c            	incw	x
1132  010c cd0000        	call	c_ludv
1134  010f 96            	ldw	x,sp
1135  0110 1c0009        	addw	x,#OFST+3
1136  0113 cd0000        	call	c_rtol
1138  0116               L161:
1139                     ; 847   while (num != 0) {
1141  0116 96            	ldw	x,sp
1142  0117 1c0009        	addw	x,#OFST+3
1143  011a cd0000        	call	c_lzmp
1145  011d 2697          	jrne	L551
1146                     ; 855   reverse(str, pad);
1148  011f 7b10          	ld	a,(OFST+10,sp)
1149  0121 88            	push	a
1150  0122 1e0e          	ldw	x,(OFST+8,sp)
1151  0124 ad06          	call	_reverse
1153  0126 84            	pop	a
1154                     ; 857   return str;
1157  0127               L61:
1159  0127 1e0d          	ldw	x,(OFST+7,sp)
1161  0129 5b06          	addw	sp,#6
1162  012b 81            	ret	
1225                     ; 862 void reverse(char str[], uint8_t length)
1225                     ; 863 {
1226                     	switch	.text
1227  012c               _reverse:
1229  012c 89            	pushw	x
1230  012d 5203          	subw	sp,#3
1231       00000003      OFST:	set	3
1234                     ; 868   start = 0;
1236  012f 0f02          	clr	(OFST-1,sp)
1238                     ; 869   end = (uint8_t)(length - 1);
1240  0131 7b08          	ld	a,(OFST+5,sp)
1241  0133 4a            	dec	a
1242  0134 6b03          	ld	(OFST+0,sp),a
1245  0136 2029          	jra	L322
1246  0138               L712:
1247                     ; 872     temp = str[start];
1249  0138 5f            	clrw	x
1250  0139 97            	ld	xl,a
1251  013a 72fb04        	addw	x,(OFST+1,sp)
1252  013d f6            	ld	a,(x)
1253  013e 6b01          	ld	(OFST-2,sp),a
1255                     ; 873     str[start] = str[end];
1257  0140 5f            	clrw	x
1258  0141 7b02          	ld	a,(OFST-1,sp)
1259  0143 97            	ld	xl,a
1260  0144 72fb04        	addw	x,(OFST+1,sp)
1261  0147 7b03          	ld	a,(OFST+0,sp)
1262  0149 905f          	clrw	y
1263  014b 9097          	ld	yl,a
1264  014d 72f904        	addw	y,(OFST+1,sp)
1265  0150 90f6          	ld	a,(y)
1266  0152 f7            	ld	(x),a
1267                     ; 874     str[end] = temp;
1269  0153 5f            	clrw	x
1270  0154 7b03          	ld	a,(OFST+0,sp)
1271  0156 97            	ld	xl,a
1272  0157 72fb04        	addw	x,(OFST+1,sp)
1273  015a 7b01          	ld	a,(OFST-2,sp)
1274  015c f7            	ld	(x),a
1275                     ; 875     start++;
1277  015d 0c02          	inc	(OFST-1,sp)
1279                     ; 876     end--;
1281  015f 0a03          	dec	(OFST+0,sp)
1283  0161               L322:
1284                     ; 871   while (start < end) {
1284                     ; 872     temp = str[start];
1284                     ; 873     str[start] = str[end];
1284                     ; 874     str[end] = temp;
1284                     ; 875     start++;
1284                     ; 876     end--;
1286  0161 7b02          	ld	a,(OFST-1,sp)
1287  0163 1103          	cp	a,(OFST+0,sp)
1288  0165 25d1          	jrult	L712
1289                     ; 878 }
1292  0167 5b05          	addw	sp,#5
1293  0169 81            	ret	
1354                     ; 881 uint8_t three_alpha_to_uint(uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
1354                     ; 882 {
1355                     	switch	.text
1356  016a               _three_alpha_to_uint:
1358  016a 89            	pushw	x
1359  016b 89            	pushw	x
1360       00000002      OFST:	set	2
1363                     ; 890   value = (uint8_t)((alpha1 - '0') *100);
1365  016c 9e            	ld	a,xh
1366  016d 97            	ld	xl,a
1367  016e a664          	ld	a,#100
1368  0170 42            	mul	x,a
1369  0171 9f            	ld	a,xl
1370  0172 a0c0          	sub	a,#192
1371  0174 6b02          	ld	(OFST+0,sp),a
1373                     ; 891   digit = (uint8_t)((alpha2 - '0') * 10);
1375  0176 7b04          	ld	a,(OFST+2,sp)
1376  0178 97            	ld	xl,a
1377  0179 a60a          	ld	a,#10
1378  017b 42            	mul	x,a
1379  017c 9f            	ld	a,xl
1380  017d a0e0          	sub	a,#224
1382                     ; 892   value = (uint8_t)(value + digit);
1384  017f 1b02          	add	a,(OFST+0,sp)
1385  0181 6b02          	ld	(OFST+0,sp),a
1387                     ; 893   digit = (uint8_t)(alpha3 - '0');
1389  0183 7b07          	ld	a,(OFST+5,sp)
1390  0185 a030          	sub	a,#48
1391  0187 6b01          	ld	(OFST-1,sp),a
1393                     ; 894   value = (uint8_t)(value + digit);
1395  0189 1b02          	add	a,(OFST+0,sp)
1397                     ; 896   if (value >= 255) value = 0;
1399  018b a1ff          	cp	a,#255
1400  018d 2501          	jrult	L352
1403  018f 4f            	clr	a
1405  0190               L352:
1406                     ; 898   return value;
1410  0190 5b04          	addw	sp,#4
1411  0192 81            	ret	
1457                     ; 902 uint8_t two_alpha_to_uint(uint8_t alpha1, uint8_t alpha2)
1457                     ; 903 {
1458                     	switch	.text
1459  0193               _two_alpha_to_uint:
1461  0193 89            	pushw	x
1462  0194 88            	push	a
1463       00000001      OFST:	set	1
1466                     ; 910   if (alpha1 >= '0' && alpha1 <= '9') value = (uint8_t)((alpha1 - '0') << 4);
1468  0195 9e            	ld	a,xh
1469  0196 a130          	cp	a,#48
1470  0198 250f          	jrult	L572
1472  019a 9e            	ld	a,xh
1473  019b a13a          	cp	a,#58
1474  019d 240a          	jruge	L572
1477  019f 9e            	ld	a,xh
1478  01a0 97            	ld	xl,a
1479  01a1 a610          	ld	a,#16
1480  01a3 42            	mul	x,a
1481  01a4 9f            	ld	a,xl
1482  01a5 a000          	sub	a,#0
1484  01a7 2030          	jp	LC001
1485  01a9               L572:
1486                     ; 911   else if (alpha1 == 'a') value = 0xa0;
1488  01a9 7b02          	ld	a,(OFST+1,sp)
1489  01ab a161          	cp	a,#97
1490  01ad 2604          	jrne	L103
1493  01af a6a0          	ld	a,#160
1495  01b1 2026          	jp	LC001
1496  01b3               L103:
1497                     ; 912   else if (alpha1 == 'b') value = 0xb0;
1499  01b3 a162          	cp	a,#98
1500  01b5 2604          	jrne	L503
1503  01b7 a6b0          	ld	a,#176
1505  01b9 201e          	jp	LC001
1506  01bb               L503:
1507                     ; 913   else if (alpha1 == 'c') value = 0xc0;
1509  01bb a163          	cp	a,#99
1510  01bd 2604          	jrne	L113
1513  01bf a6c0          	ld	a,#192
1515  01c1 2016          	jp	LC001
1516  01c3               L113:
1517                     ; 914   else if (alpha1 == 'd') value = 0xd0;
1519  01c3 a164          	cp	a,#100
1520  01c5 2604          	jrne	L513
1523  01c7 a6d0          	ld	a,#208
1525  01c9 200e          	jp	LC001
1526  01cb               L513:
1527                     ; 915   else if (alpha1 == 'e') value = 0xe0;
1529  01cb a165          	cp	a,#101
1530  01cd 2604          	jrne	L123
1533  01cf a6e0          	ld	a,#224
1535  01d1 2006          	jp	LC001
1536  01d3               L123:
1537                     ; 916   else if (alpha1 == 'f') value = 0xf0;
1539  01d3 a166          	cp	a,#102
1540  01d5 2606          	jrne	L523
1543  01d7 a6f0          	ld	a,#240
1544  01d9               LC001:
1545  01d9 6b01          	ld	(OFST+0,sp),a
1548  01db 2002          	jra	L772
1549  01dd               L523:
1550                     ; 917   else value = 0; // If an invalid entry is made convert it to 0
1552  01dd 0f01          	clr	(OFST+0,sp)
1554  01df               L772:
1555                     ; 919   if (alpha2 >= '0' && alpha2 <= '9') value = (uint8_t)(value + alpha2 - '0');
1557  01df 7b03          	ld	a,(OFST+2,sp)
1558  01e1 a130          	cp	a,#48
1559  01e3 250c          	jrult	L133
1561  01e5 a13a          	cp	a,#58
1562  01e7 2408          	jruge	L133
1565  01e9 7b01          	ld	a,(OFST+0,sp)
1566  01eb 1b03          	add	a,(OFST+2,sp)
1567  01ed a030          	sub	a,#48
1569  01ef 203d          	jp	L333
1570  01f1               L133:
1571                     ; 920   else if (alpha2 == 'a') value = (uint8_t)(value + 0x0a);
1573  01f1 a161          	cp	a,#97
1574  01f3 2606          	jrne	L533
1577  01f5 7b01          	ld	a,(OFST+0,sp)
1578  01f7 ab0a          	add	a,#10
1580  01f9 2033          	jp	L333
1581  01fb               L533:
1582                     ; 921   else if (alpha2 == 'b') value = (uint8_t)(value + 0x0b);
1584  01fb a162          	cp	a,#98
1585  01fd 2606          	jrne	L143
1588  01ff 7b01          	ld	a,(OFST+0,sp)
1589  0201 ab0b          	add	a,#11
1591  0203 2029          	jp	L333
1592  0205               L143:
1593                     ; 922   else if (alpha2 == 'c') value = (uint8_t)(value + 0x0c);
1595  0205 a163          	cp	a,#99
1596  0207 2606          	jrne	L543
1599  0209 7b01          	ld	a,(OFST+0,sp)
1600  020b ab0c          	add	a,#12
1602  020d 201f          	jp	L333
1603  020f               L543:
1604                     ; 923   else if (alpha2 == 'd') value = (uint8_t)(value + 0x0d);
1606  020f a164          	cp	a,#100
1607  0211 2606          	jrne	L153
1610  0213 7b01          	ld	a,(OFST+0,sp)
1611  0215 ab0d          	add	a,#13
1613  0217 2015          	jp	L333
1614  0219               L153:
1615                     ; 924   else if (alpha2 == 'e') value = (uint8_t)(value + 0x0e);
1617  0219 a165          	cp	a,#101
1618  021b 2606          	jrne	L553
1621  021d 7b01          	ld	a,(OFST+0,sp)
1622  021f ab0e          	add	a,#14
1624  0221 200b          	jp	L333
1625  0223               L553:
1626                     ; 925   else if (alpha2 == 'f') value = (uint8_t)(value + 0x0f);
1628  0223 a166          	cp	a,#102
1629  0225 2606          	jrne	L163
1632  0227 7b01          	ld	a,(OFST+0,sp)
1633  0229 ab0f          	add	a,#15
1636  022b 2001          	jra	L333
1637  022d               L163:
1638                     ; 926   else value = 0; // If an invalid entry is made convert it to 0
1640  022d 4f            	clr	a
1642  022e               L333:
1643                     ; 928   return value;
1647  022e 5b03          	addw	sp,#3
1648  0230 81            	ret	
1699                     ; 932 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint32_t nDataLen)
1699                     ; 933 {
1700                     	switch	.text
1701  0231               L7_CopyHttpHeader:
1703  0231 89            	pushw	x
1704  0232 89            	pushw	x
1705       00000002      OFST:	set	2
1708                     ; 936   nBytes = 0;
1710  0233 5f            	clrw	x
1711  0234 1f01          	ldw	(OFST-1,sp),x
1713                     ; 938   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
1715  0236 ae2c52        	ldw	x,#L704
1716  0239 89            	pushw	x
1717  023a 96            	ldw	x,sp
1718  023b 1c0005        	addw	x,#OFST+3
1719  023e cd0000        	call	L3_CopyStringP
1721  0241 5b02          	addw	sp,#2
1722  0243 72fb01        	addw	x,(OFST-1,sp)
1723  0246 1f01          	ldw	(OFST-1,sp),x
1725                     ; 939   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1727  0248 ae2c4f        	ldw	x,#L114
1728  024b 89            	pushw	x
1729  024c 96            	ldw	x,sp
1730  024d 1c0005        	addw	x,#OFST+3
1731  0250 cd0000        	call	L3_CopyStringP
1733  0253 5b02          	addw	sp,#2
1734  0255 72fb01        	addw	x,(OFST-1,sp)
1735  0258 1f01          	ldw	(OFST-1,sp),x
1737                     ; 941   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
1739  025a ae2c3f        	ldw	x,#L314
1740  025d 89            	pushw	x
1741  025e 96            	ldw	x,sp
1742  025f 1c0005        	addw	x,#OFST+3
1743  0262 cd0000        	call	L3_CopyStringP
1745  0265 5b02          	addw	sp,#2
1746  0267 72fb01        	addw	x,(OFST-1,sp)
1747  026a 1f01          	ldw	(OFST-1,sp),x
1749                     ; 942   nBytes += CopyValue(&pBuffer, nDataLen);
1751  026c 1e09          	ldw	x,(OFST+7,sp)
1752  026e 89            	pushw	x
1753  026f 1e09          	ldw	x,(OFST+7,sp)
1754  0271 89            	pushw	x
1755  0272 96            	ldw	x,sp
1756  0273 1c0007        	addw	x,#OFST+5
1757  0276 cd0028        	call	L5_CopyValue
1759  0279 5b04          	addw	sp,#4
1760  027b 72fb01        	addw	x,(OFST-1,sp)
1761  027e 1f01          	ldw	(OFST-1,sp),x
1763                     ; 943   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1765  0280 ae2c4f        	ldw	x,#L114
1766  0283 89            	pushw	x
1767  0284 96            	ldw	x,sp
1768  0285 1c0005        	addw	x,#OFST+3
1769  0288 cd0000        	call	L3_CopyStringP
1771  028b 5b02          	addw	sp,#2
1772  028d 72fb01        	addw	x,(OFST-1,sp)
1773  0290 1f01          	ldw	(OFST-1,sp),x
1775                     ; 945   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type:text/html\r\n"));
1777  0292 ae2c26        	ldw	x,#L514
1778  0295 89            	pushw	x
1779  0296 96            	ldw	x,sp
1780  0297 1c0005        	addw	x,#OFST+3
1781  029a cd0000        	call	L3_CopyStringP
1783  029d 5b02          	addw	sp,#2
1784  029f 72fb01        	addw	x,(OFST-1,sp)
1785  02a2 1f01          	ldw	(OFST-1,sp),x
1787                     ; 946   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
1789  02a4 ae2c13        	ldw	x,#L714
1790  02a7 89            	pushw	x
1791  02a8 96            	ldw	x,sp
1792  02a9 1c0005        	addw	x,#OFST+3
1793  02ac cd0000        	call	L3_CopyStringP
1795  02af 5b02          	addw	sp,#2
1796  02b1 72fb01        	addw	x,(OFST-1,sp)
1797  02b4 1f01          	ldw	(OFST-1,sp),x
1799                     ; 947   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1801  02b6 ae2c4f        	ldw	x,#L114
1802  02b9 89            	pushw	x
1803  02ba 96            	ldw	x,sp
1804  02bb 1c0005        	addw	x,#OFST+3
1805  02be cd0000        	call	L3_CopyStringP
1807  02c1 5b02          	addw	sp,#2
1808  02c3 72fb01        	addw	x,(OFST-1,sp)
1810                     ; 949   return nBytes;
1814  02c6 5b04          	addw	sp,#4
1815  02c8 81            	ret	
1954                     	switch	.const
1955  2bb7               L421:
1956  2bb7 046d          	dc.w	L124
1957  2bb9 047b          	dc.w	L324
1958  2bbb 0489          	dc.w	L524
1959  2bbd 0496          	dc.w	L724
1960  2bbf 04a3          	dc.w	L134
1961  2bc1 04b0          	dc.w	L334
1962  2bc3 04bd          	dc.w	L534
1963  2bc5 04ca          	dc.w	L734
1964  2bc7 04d7          	dc.w	L144
1965  2bc9 04e4          	dc.w	L344
1966  2bcb 04f1          	dc.w	L544
1967  2bcd 04fe          	dc.w	L744
1968  2bcf               L422:
1969  2bcf 063d          	dc.w	L354
1970  2bd1 064f          	dc.w	L554
1971  2bd3 0661          	dc.w	L754
1972  2bd5 0673          	dc.w	L164
1973  2bd7 0685          	dc.w	L364
1974  2bd9 0697          	dc.w	L564
1975  2bdb 06a9          	dc.w	L764
1976  2bdd 06bb          	dc.w	L174
1977  2bdf 06cd          	dc.w	L374
1978  2be1 06df          	dc.w	L574
1979  2be3 06f1          	dc.w	L774
1980  2be5 0703          	dc.w	L105
1981  2be7 0715          	dc.w	L305
1982  2be9 0727          	dc.w	L505
1983  2beb 0739          	dc.w	L705
1984  2bed 074b          	dc.w	L115
1985  2bef 075c          	dc.w	L315
1986  2bf1 076d          	dc.w	L515
1987  2bf3 077e          	dc.w	L715
1988  2bf5 078f          	dc.w	L125
1989  2bf7 07a0          	dc.w	L325
1990  2bf9 07b1          	dc.w	L525
1991                     ; 953 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
1991                     ; 954 {
1992                     	switch	.text
1993  02c9               L11_CopyHttpData:
1995  02c9 89            	pushw	x
1996  02ca 5207          	subw	sp,#7
1997       00000007      OFST:	set	7
2000                     ; 970   nBytes = 0;
2002  02cc 5f            	clrw	x
2003  02cd 1f05          	ldw	(OFST-2,sp),x
2005                     ; 1006   if (nMaxBytes > 400) nMaxBytes = 400; // limit just in case
2007  02cf 1e10          	ldw	x,(OFST+9,sp)
2008  02d1 a30191        	cpw	x,#401
2009  02d4 2403cc0af8    	jrult	L306
2012  02d9 ae0190        	ldw	x,#400
2013  02dc 1f10          	ldw	(OFST+9,sp),x
2014  02de cc0af8        	jra	L306
2015  02e1               L106:
2016                     ; 1029     if (*pDataLeft > 0) {
2018  02e1 1e0e          	ldw	x,(OFST+7,sp)
2019  02e3 e601          	ld	a,(1,x)
2020  02e5 fa            	or	a,(x)
2021  02e6 2603cc0b01    	jreq	L506
2022                     ; 1033       memcpy(&nByte, *ppData, 1);
2024  02eb 96            	ldw	x,sp
2025  02ec 5c            	incw	x
2026  02ed bf00          	ldw	c_x,x
2027  02ef 160c          	ldw	y,(OFST+5,sp)
2028  02f1 90fe          	ldw	y,(y)
2029  02f3 90bf00        	ldw	c_y,y
2030  02f6 ae0001        	ldw	x,#1
2031  02f9               L25:
2032  02f9 5a            	decw	x
2033  02fa 92d600        	ld	a,([c_y.w],x)
2034  02fd 92d700        	ld	([c_x.w],x),a
2035  0300 5d            	tnzw	x
2036  0301 26f6          	jrne	L25
2037                     ; 1063       if (nByte == '%') {
2039  0303 7b01          	ld	a,(OFST-6,sp)
2040  0305 a125          	cp	a,#37
2041  0307 2703cc0adb    	jrne	L116
2042                     ; 1064         *ppData = *ppData + 1;
2044  030c 1e0c          	ldw	x,(OFST+5,sp)
2045  030e 9093          	ldw	y,x
2046  0310 fe            	ldw	x,(x)
2047  0311 5c            	incw	x
2048  0312 90ff          	ldw	(y),x
2049                     ; 1065         *pDataLeft = *pDataLeft - 1;
2051  0314 1e0e          	ldw	x,(OFST+7,sp)
2052  0316 9093          	ldw	y,x
2053  0318 fe            	ldw	x,(x)
2054  0319 5a            	decw	x
2055  031a 90ff          	ldw	(y),x
2056                     ; 1070         memcpy(&nParsedMode, *ppData, 1);
2058  031c 96            	ldw	x,sp
2059  031d 1c0003        	addw	x,#OFST-4
2060  0320 bf00          	ldw	c_x,x
2061  0322 160c          	ldw	y,(OFST+5,sp)
2062  0324 90fe          	ldw	y,(y)
2063  0326 90bf00        	ldw	c_y,y
2064  0329 ae0001        	ldw	x,#1
2065  032c               L45:
2066  032c 5a            	decw	x
2067  032d 92d600        	ld	a,([c_y.w],x)
2068  0330 92d700        	ld	([c_x.w],x),a
2069  0333 5d            	tnzw	x
2070  0334 26f6          	jrne	L45
2071                     ; 1071         *ppData = *ppData + 1;
2073  0336 1e0c          	ldw	x,(OFST+5,sp)
2074  0338 9093          	ldw	y,x
2075  033a fe            	ldw	x,(x)
2076  033b 5c            	incw	x
2077  033c 90ff          	ldw	(y),x
2078                     ; 1072         *pDataLeft = *pDataLeft - 1;
2080  033e 1e0e          	ldw	x,(OFST+7,sp)
2081  0340 9093          	ldw	y,x
2082  0342 fe            	ldw	x,(x)
2083  0343 5a            	decw	x
2084  0344 90ff          	ldw	(y),x
2085                     ; 1076         memcpy(&temp, *ppData, 1);
2087  0346 96            	ldw	x,sp
2088  0347 1c0002        	addw	x,#OFST-5
2089  034a bf00          	ldw	c_x,x
2090  034c 160c          	ldw	y,(OFST+5,sp)
2091  034e 90fe          	ldw	y,(y)
2092  0350 90bf00        	ldw	c_y,y
2093  0353 ae0001        	ldw	x,#1
2094  0356               L65:
2095  0356 5a            	decw	x
2096  0357 92d600        	ld	a,([c_y.w],x)
2097  035a 92d700        	ld	([c_x.w],x),a
2098  035d 5d            	tnzw	x
2099  035e 26f6          	jrne	L65
2100                     ; 1077 	nParsedNum = (uint8_t)((temp - '0') * 10);
2102  0360 7b02          	ld	a,(OFST-5,sp)
2103  0362 97            	ld	xl,a
2104  0363 a60a          	ld	a,#10
2105  0365 42            	mul	x,a
2106  0366 9f            	ld	a,xl
2107  0367 a0e0          	sub	a,#224
2108  0369 6b04          	ld	(OFST-3,sp),a
2110                     ; 1078         *ppData = *ppData + 1;
2112  036b 1e0c          	ldw	x,(OFST+5,sp)
2113  036d 9093          	ldw	y,x
2114  036f fe            	ldw	x,(x)
2115  0370 5c            	incw	x
2116  0371 90ff          	ldw	(y),x
2117                     ; 1079         *pDataLeft = *pDataLeft - 1;
2119  0373 1e0e          	ldw	x,(OFST+7,sp)
2120  0375 9093          	ldw	y,x
2121  0377 fe            	ldw	x,(x)
2122  0378 5a            	decw	x
2123  0379 90ff          	ldw	(y),x
2124                     ; 1083         memcpy(&temp, *ppData, 1);
2126  037b 96            	ldw	x,sp
2127  037c 1c0002        	addw	x,#OFST-5
2128  037f bf00          	ldw	c_x,x
2129  0381 160c          	ldw	y,(OFST+5,sp)
2130  0383 90fe          	ldw	y,(y)
2131  0385 90bf00        	ldw	c_y,y
2132  0388 ae0001        	ldw	x,#1
2133  038b               L06:
2134  038b 5a            	decw	x
2135  038c 92d600        	ld	a,([c_y.w],x)
2136  038f 92d700        	ld	([c_x.w],x),a
2137  0392 5d            	tnzw	x
2138  0393 26f6          	jrne	L06
2139                     ; 1084 	nParsedNum = (uint8_t)(nParsedNum + temp - '0');
2141  0395 7b04          	ld	a,(OFST-3,sp)
2142  0397 1b02          	add	a,(OFST-5,sp)
2143  0399 a030          	sub	a,#48
2144  039b 6b04          	ld	(OFST-3,sp),a
2146                     ; 1085         *ppData = *ppData + 1;
2148  039d 1e0c          	ldw	x,(OFST+5,sp)
2149  039f 9093          	ldw	y,x
2150  03a1 fe            	ldw	x,(x)
2151  03a2 5c            	incw	x
2152  03a3 90ff          	ldw	(y),x
2153                     ; 1086         *pDataLeft = *pDataLeft - 1;
2155  03a5 1e0e          	ldw	x,(OFST+7,sp)
2156  03a7 9093          	ldw	y,x
2157  03a9 fe            	ldw	x,(x)
2158  03aa 5a            	decw	x
2159  03ab 90ff          	ldw	(y),x
2160                     ; 1096         if (nParsedMode == 'i') {
2162  03ad 7b03          	ld	a,(OFST-4,sp)
2163  03af a169          	cp	a,#105
2164  03b1 2614          	jrne	L316
2165                     ; 1100 	  *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
2167  03b3 7b04          	ld	a,(OFST-3,sp)
2168  03b5 cd125b        	call	_GpioGetPin
2170  03b8 1e08          	ldw	x,(OFST+1,sp)
2171  03ba ab30          	add	a,#48
2172  03bc f7            	ld	(x),a
2173                     ; 1101           pBuffer++;
2175  03bd 5c            	incw	x
2176  03be 1f08          	ldw	(OFST+1,sp),x
2177                     ; 1102           nBytes++;
2179  03c0 1e05          	ldw	x,(OFST-2,sp)
2180  03c2 5c            	incw	x
2181  03c3 1f05          	ldw	(OFST-2,sp),x
2184  03c5 204e          	jra	L516
2185  03c7               L316:
2186                     ; 1126         else if (nParsedMode == 'o') {
2188  03c7 a16f          	cp	a,#111
2189  03c9 2624          	jrne	L716
2190                     ; 1129           if ((uint8_t)(GpioGetPin(nParsedNum) == 1)) { // Insert 'checked'
2192  03cb 7b04          	ld	a,(OFST-3,sp)
2193  03cd cd125b        	call	_GpioGetPin
2195  03d0 4a            	dec	a
2196  03d1 2642          	jrne	L516
2197                     ; 1130             for(i=0; i<7; i++) {
2199  03d3 6b07          	ld	(OFST+0,sp),a
2201  03d5               L326:
2202                     ; 1131               *pBuffer = checked[i];
2204  03d5 5f            	clrw	x
2205  03d6 97            	ld	xl,a
2206  03d7 d60000        	ld	a,(L31_checked,x)
2207  03da 1e08          	ldw	x,(OFST+1,sp)
2208  03dc f7            	ld	(x),a
2209                     ; 1132               pBuffer++;
2211  03dd 5c            	incw	x
2212  03de 1f08          	ldw	(OFST+1,sp),x
2213                     ; 1133               nBytes++;
2215  03e0 1e05          	ldw	x,(OFST-2,sp)
2216  03e2 5c            	incw	x
2217  03e3 1f05          	ldw	(OFST-2,sp),x
2219                     ; 1130             for(i=0; i<7; i++) {
2221  03e5 0c07          	inc	(OFST+0,sp)
2225  03e7 7b07          	ld	a,(OFST+0,sp)
2226  03e9 a107          	cp	a,#7
2227  03eb 25e8          	jrult	L326
2229  03ed 2026          	jra	L516
2230  03ef               L716:
2231                     ; 1140         else if (nParsedMode == 'p') {
2233  03ef a170          	cp	a,#112
2234  03f1 2622          	jrne	L516
2235                     ; 1143           if ((uint8_t)(GpioGetPin(nParsedNum) == 0)) { // Insert 'checked'
2237  03f3 7b04          	ld	a,(OFST-3,sp)
2238  03f5 cd125b        	call	_GpioGetPin
2240  03f8 4d            	tnz	a
2241  03f9 261a          	jrne	L516
2242                     ; 1144             for(i=0; i<7; i++) {
2244  03fb 6b07          	ld	(OFST+0,sp),a
2246  03fd               L146:
2247                     ; 1145               *pBuffer = checked[i];
2249  03fd 5f            	clrw	x
2250  03fe 97            	ld	xl,a
2251  03ff d60000        	ld	a,(L31_checked,x)
2252  0402 1e08          	ldw	x,(OFST+1,sp)
2253  0404 f7            	ld	(x),a
2254                     ; 1146               pBuffer++;
2256  0405 5c            	incw	x
2257  0406 1f08          	ldw	(OFST+1,sp),x
2258                     ; 1147               nBytes++;
2260  0408 1e05          	ldw	x,(OFST-2,sp)
2261  040a 5c            	incw	x
2262  040b 1f05          	ldw	(OFST-2,sp),x
2264                     ; 1144             for(i=0; i<7; i++) {
2266  040d 0c07          	inc	(OFST+0,sp)
2270  040f 7b07          	ld	a,(OFST+0,sp)
2271  0411 a107          	cp	a,#7
2272  0413 25e8          	jrult	L146
2274  0415               L516:
2275                     ; 1154         if (nParsedMode == 'a') {
2277  0415 7b03          	ld	a,(OFST-4,sp)
2278  0417 a161          	cp	a,#97
2279  0419 263b          	jrne	L156
2280                     ; 1156 	  for(i=0; i<20; i++) {
2282  041b 4f            	clr	a
2283  041c 6b07          	ld	(OFST+0,sp),a
2285  041e               L356:
2286                     ; 1157 	    if (ex_stored_devicename[i] != ' ') { // Don't write spaces out - confuses the
2288  041e 5f            	clrw	x
2289  041f 97            	ld	xl,a
2290  0420 d60000        	ld	a,(_ex_stored_devicename,x)
2291  0423 a120          	cp	a,#32
2292  0425 2712          	jreq	L166
2293                     ; 1159               *pBuffer = (uint8_t)(ex_stored_devicename[i]);
2295  0427 7b07          	ld	a,(OFST+0,sp)
2296  0429 5f            	clrw	x
2297  042a 97            	ld	xl,a
2298  042b d60000        	ld	a,(_ex_stored_devicename,x)
2299  042e 1e08          	ldw	x,(OFST+1,sp)
2300  0430 f7            	ld	(x),a
2301                     ; 1160               pBuffer++;
2303  0431 5c            	incw	x
2304  0432 1f08          	ldw	(OFST+1,sp),x
2305                     ; 1161               nBytes++;
2307  0434 1e05          	ldw	x,(OFST-2,sp)
2308  0436 5c            	incw	x
2309  0437 1f05          	ldw	(OFST-2,sp),x
2311  0439               L166:
2312                     ; 1156 	  for(i=0; i<20; i++) {
2314  0439 0c07          	inc	(OFST+0,sp)
2318  043b 7b07          	ld	a,(OFST+0,sp)
2319  043d a114          	cp	a,#20
2320  043f 25dd          	jrult	L356
2321                     ; 1176           *ppData = *ppData + 20;
2323  0441 1e0c          	ldw	x,(OFST+5,sp)
2324  0443 9093          	ldw	y,x
2325  0445 fe            	ldw	x,(x)
2326  0446 1c0014        	addw	x,#20
2327  0449 90ff          	ldw	(y),x
2328                     ; 1177           *pDataLeft = *pDataLeft - 20;
2330  044b 1e0e          	ldw	x,(OFST+7,sp)
2331  044d 9093          	ldw	y,x
2332  044f fe            	ldw	x,(x)
2333  0450 1d0014        	subw	x,#20
2335  0453 cc0832        	jp	LC011
2336  0456               L156:
2337                     ; 1180         else if (nParsedMode == 'b') {
2339  0456 a162          	cp	a,#98
2340  0458 2703cc0556    	jrne	L566
2341                     ; 1185 	  advanceptrs = 0;
2343                     ; 1187           switch (nParsedNum)
2345  045d 7b04          	ld	a,(OFST-3,sp)
2347                     ; 1202 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2348  045f a10c          	cp	a,#12
2349  0461 2503cc0518    	jruge	L154
2350  0466 5f            	clrw	x
2351  0467 97            	ld	xl,a
2352  0468 58            	sllw	x
2353  0469 de2bb7        	ldw	x,(L421,x)
2354  046c fc            	jp	(x)
2355  046d               L124:
2356                     ; 1190 	    case 0:  emb_itoa(ex_stored_hostaddr4, OctetArray, 10, 3); advanceptrs = 1; break;
2358  046d 4b03          	push	#3
2359  046f 4b0a          	push	#10
2360  0471 ae0000        	ldw	x,#_OctetArray
2361  0474 89            	pushw	x
2362  0475 c60000        	ld	a,_ex_stored_hostaddr4
2367  0478 cc0509        	jp	LC003
2368  047b               L324:
2369                     ; 1191 	    case 1:  emb_itoa(ex_stored_hostaddr3, OctetArray, 10, 3); advanceptrs = 1; break;
2371  047b 4b03          	push	#3
2372  047d 4b0a          	push	#10
2373  047f ae0000        	ldw	x,#_OctetArray
2374  0482 89            	pushw	x
2375  0483 c60000        	ld	a,_ex_stored_hostaddr3
2380  0486 cc0509        	jp	LC003
2381  0489               L524:
2382                     ; 1192 	    case 2:  emb_itoa(ex_stored_hostaddr2, OctetArray, 10, 3); advanceptrs = 1; break;
2384  0489 4b03          	push	#3
2385  048b 4b0a          	push	#10
2386  048d ae0000        	ldw	x,#_OctetArray
2387  0490 89            	pushw	x
2388  0491 c60000        	ld	a,_ex_stored_hostaddr2
2393  0494 2073          	jp	LC003
2394  0496               L724:
2395                     ; 1193 	    case 3:  emb_itoa(ex_stored_hostaddr1, OctetArray, 10, 3); advanceptrs = 1; break;
2397  0496 4b03          	push	#3
2398  0498 4b0a          	push	#10
2399  049a ae0000        	ldw	x,#_OctetArray
2400  049d 89            	pushw	x
2401  049e c60000        	ld	a,_ex_stored_hostaddr1
2406  04a1 2066          	jp	LC003
2407  04a3               L134:
2408                     ; 1194 	    case 4:  emb_itoa(ex_stored_draddr4,   OctetArray, 10, 3); advanceptrs = 1; break;
2410  04a3 4b03          	push	#3
2411  04a5 4b0a          	push	#10
2412  04a7 ae0000        	ldw	x,#_OctetArray
2413  04aa 89            	pushw	x
2414  04ab c60000        	ld	a,_ex_stored_draddr4
2419  04ae 2059          	jp	LC003
2420  04b0               L334:
2421                     ; 1195 	    case 5:  emb_itoa(ex_stored_draddr3,   OctetArray, 10, 3); advanceptrs = 1; break;
2423  04b0 4b03          	push	#3
2424  04b2 4b0a          	push	#10
2425  04b4 ae0000        	ldw	x,#_OctetArray
2426  04b7 89            	pushw	x
2427  04b8 c60000        	ld	a,_ex_stored_draddr3
2432  04bb 204c          	jp	LC003
2433  04bd               L534:
2434                     ; 1196 	    case 6:  emb_itoa(ex_stored_draddr2,   OctetArray, 10, 3); advanceptrs = 1; break;
2436  04bd 4b03          	push	#3
2437  04bf 4b0a          	push	#10
2438  04c1 ae0000        	ldw	x,#_OctetArray
2439  04c4 89            	pushw	x
2440  04c5 c60000        	ld	a,_ex_stored_draddr2
2445  04c8 203f          	jp	LC003
2446  04ca               L734:
2447                     ; 1197 	    case 7:  emb_itoa(ex_stored_draddr1,   OctetArray, 10, 3); advanceptrs = 1; break;
2449  04ca 4b03          	push	#3
2450  04cc 4b0a          	push	#10
2451  04ce ae0000        	ldw	x,#_OctetArray
2452  04d1 89            	pushw	x
2453  04d2 c60000        	ld	a,_ex_stored_draddr1
2458  04d5 2032          	jp	LC003
2459  04d7               L144:
2460                     ; 1198 	    case 8:  emb_itoa(ex_stored_netmask4,  OctetArray, 10, 3); advanceptrs = 1; break;
2462  04d7 4b03          	push	#3
2463  04d9 4b0a          	push	#10
2464  04db ae0000        	ldw	x,#_OctetArray
2465  04de 89            	pushw	x
2466  04df c60000        	ld	a,_ex_stored_netmask4
2471  04e2 2025          	jp	LC003
2472  04e4               L344:
2473                     ; 1199 	    case 9:  emb_itoa(ex_stored_netmask3,  OctetArray, 10, 3); advanceptrs = 1; break;
2475  04e4 4b03          	push	#3
2476  04e6 4b0a          	push	#10
2477  04e8 ae0000        	ldw	x,#_OctetArray
2478  04eb 89            	pushw	x
2479  04ec c60000        	ld	a,_ex_stored_netmask3
2484  04ef 2018          	jp	LC003
2485  04f1               L544:
2486                     ; 1200 	    case 10: emb_itoa(ex_stored_netmask2,  OctetArray, 10, 3); advanceptrs = 1; break;
2488  04f1 4b03          	push	#3
2489  04f3 4b0a          	push	#10
2490  04f5 ae0000        	ldw	x,#_OctetArray
2491  04f8 89            	pushw	x
2492  04f9 c60000        	ld	a,_ex_stored_netmask2
2497  04fc 200b          	jp	LC003
2498  04fe               L744:
2499                     ; 1201 	    case 11: emb_itoa(ex_stored_netmask1,  OctetArray, 10, 3); advanceptrs = 1; break;
2501  04fe 4b03          	push	#3
2502  0500 4b0a          	push	#10
2503  0502 ae0000        	ldw	x,#_OctetArray
2504  0505 89            	pushw	x
2505  0506 c60000        	ld	a,_ex_stored_netmask1
2506  0509               LC003:
2507  0509 b703          	ld	c_lreg+3,a
2508  050b 3f02          	clr	c_lreg+2
2509  050d 3f01          	clr	c_lreg+1
2510  050f 3f00          	clr	c_lreg
2511  0511 be02          	ldw	x,c_lreg+2
2512  0513 89            	pushw	x
2513  0514 be00          	ldw	x,c_lreg
2518  0516 200a          	jra	L176
2519  0518               L154:
2520                     ; 1202 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2522  0518 4b03          	push	#3
2523  051a 4b0a          	push	#10
2524  051c ae0000        	ldw	x,#_OctetArray
2525  051f 89            	pushw	x
2526  0520 5f            	clrw	x
2527  0521 89            	pushw	x
2533  0522               L176:
2534  0522 89            	pushw	x
2535  0523 cd008c        	call	_emb_itoa
2536  0526 5b08          	addw	sp,#8
2549  0528 a601          	ld	a,#1
2550  052a 6b07          	ld	(OFST+0,sp),a
2552                     ; 1205 	  if (advanceptrs == 1) { // Copy OctetArray and advance pointers if one of the above
2554  052c 4a            	dec	a
2555  052d 2703cc0af8    	jrne	L306
2556                     ; 1207             *pBuffer = (uint8_t)OctetArray[0];
2558  0532 1e08          	ldw	x,(OFST+1,sp)
2559  0534 c60000        	ld	a,_OctetArray
2560  0537 f7            	ld	(x),a
2561                     ; 1208             pBuffer++;
2563  0538 5c            	incw	x
2564  0539 1f08          	ldw	(OFST+1,sp),x
2565                     ; 1209             nBytes++;
2567  053b 1e05          	ldw	x,(OFST-2,sp)
2568  053d 5c            	incw	x
2569  053e 1f05          	ldw	(OFST-2,sp),x
2571                     ; 1211             *pBuffer = (uint8_t)OctetArray[1];
2573  0540 1e08          	ldw	x,(OFST+1,sp)
2574  0542 c60001        	ld	a,_OctetArray+1
2575  0545 f7            	ld	(x),a
2576                     ; 1212             pBuffer++;
2578  0546 5c            	incw	x
2579  0547 1f08          	ldw	(OFST+1,sp),x
2580                     ; 1213             nBytes++;
2582  0549 1e05          	ldw	x,(OFST-2,sp)
2583  054b 5c            	incw	x
2584  054c 1f05          	ldw	(OFST-2,sp),x
2586                     ; 1215             *pBuffer = (uint8_t)OctetArray[2];
2588  054e c60002        	ld	a,_OctetArray+2
2589  0551 1e08          	ldw	x,(OFST+1,sp)
2590                     ; 1216             pBuffer++;
2591                     ; 1217             nBytes++;
2592  0553 cc0622        	jp	LC010
2593  0556               L566:
2594                     ; 1221         else if (nParsedMode == 'c') {
2596  0556 a163          	cp	a,#99
2597  0558 2637          	jrne	L776
2598                     ; 1227           emb_itoa(ex_stored_port, OctetArray, 10, 5);
2600  055a 4b05          	push	#5
2601  055c 4b0a          	push	#10
2602  055e ae0000        	ldw	x,#_OctetArray
2603  0561 89            	pushw	x
2604  0562 ce0000        	ldw	x,_ex_stored_port
2605  0565 cd0000        	call	c_uitolx
2607  0568 be02          	ldw	x,c_lreg+2
2608  056a 89            	pushw	x
2609  056b be00          	ldw	x,c_lreg
2610  056d 89            	pushw	x
2611  056e cd008c        	call	_emb_itoa
2613  0571 5b08          	addw	sp,#8
2614                     ; 1229 	  for(i=0; i<5; i++) {
2616  0573 4f            	clr	a
2617  0574 6b07          	ld	(OFST+0,sp),a
2619  0576               L107:
2620                     ; 1230             *pBuffer = (uint8_t)OctetArray[i];
2622  0576 5f            	clrw	x
2623  0577 97            	ld	xl,a
2624  0578 d60000        	ld	a,(_OctetArray,x)
2625  057b 1e08          	ldw	x,(OFST+1,sp)
2626  057d f7            	ld	(x),a
2627                     ; 1231             pBuffer++;
2629  057e 5c            	incw	x
2630  057f 1f08          	ldw	(OFST+1,sp),x
2631                     ; 1232             nBytes++;
2633  0581 1e05          	ldw	x,(OFST-2,sp)
2634  0583 5c            	incw	x
2635  0584 1f05          	ldw	(OFST-2,sp),x
2637                     ; 1229 	  for(i=0; i<5; i++) {
2639  0586 0c07          	inc	(OFST+0,sp)
2643  0588 7b07          	ld	a,(OFST+0,sp)
2644  058a a105          	cp	a,#5
2645  058c 25e8          	jrult	L107
2647  058e cc0af8        	jra	L306
2648  0591               L776:
2649                     ; 1236         else if (nParsedMode == 'd') {
2651  0591 a164          	cp	a,#100
2652  0593 2703cc0626    	jrne	L117
2653                     ; 1241 	  if (nParsedNum == 0)      emb_itoa(uip_ethaddr1, OctetArray, 16, 2);
2655  0598 7b04          	ld	a,(OFST-3,sp)
2656  059a 260d          	jrne	L317
2659  059c 4b02          	push	#2
2660  059e 4b10          	push	#16
2661  05a0 ae0000        	ldw	x,#_OctetArray
2662  05a3 89            	pushw	x
2663  05a4 c60000        	ld	a,_uip_ethaddr1
2666  05a7 2053          	jp	LC004
2667  05a9               L317:
2668                     ; 1242 	  else if (nParsedNum == 1) emb_itoa(uip_ethaddr2, OctetArray, 16, 2);
2670  05a9 a101          	cp	a,#1
2671  05ab 260d          	jrne	L717
2674  05ad 4b02          	push	#2
2675  05af 4b10          	push	#16
2676  05b1 ae0000        	ldw	x,#_OctetArray
2677  05b4 89            	pushw	x
2678  05b5 c60000        	ld	a,_uip_ethaddr2
2681  05b8 2042          	jp	LC004
2682  05ba               L717:
2683                     ; 1243 	  else if (nParsedNum == 2) emb_itoa(uip_ethaddr3, OctetArray, 16, 2);
2685  05ba a102          	cp	a,#2
2686  05bc 260d          	jrne	L327
2689  05be 4b02          	push	#2
2690  05c0 4b10          	push	#16
2691  05c2 ae0000        	ldw	x,#_OctetArray
2692  05c5 89            	pushw	x
2693  05c6 c60000        	ld	a,_uip_ethaddr3
2696  05c9 2031          	jp	LC004
2697  05cb               L327:
2698                     ; 1244 	  else if (nParsedNum == 3) emb_itoa(uip_ethaddr4, OctetArray, 16, 2);
2700  05cb a103          	cp	a,#3
2701  05cd 260d          	jrne	L727
2704  05cf 4b02          	push	#2
2705  05d1 4b10          	push	#16
2706  05d3 ae0000        	ldw	x,#_OctetArray
2707  05d6 89            	pushw	x
2708  05d7 c60000        	ld	a,_uip_ethaddr4
2711  05da 2020          	jp	LC004
2712  05dc               L727:
2713                     ; 1245 	  else if (nParsedNum == 4) emb_itoa(uip_ethaddr5, OctetArray, 16, 2);
2715  05dc a104          	cp	a,#4
2716  05de 260d          	jrne	L337
2719  05e0 4b02          	push	#2
2720  05e2 4b10          	push	#16
2721  05e4 ae0000        	ldw	x,#_OctetArray
2722  05e7 89            	pushw	x
2723  05e8 c60000        	ld	a,_uip_ethaddr5
2726  05eb 200f          	jp	LC004
2727  05ed               L337:
2728                     ; 1246 	  else if (nParsedNum == 5) emb_itoa(uip_ethaddr6, OctetArray, 16, 2);
2730  05ed a105          	cp	a,#5
2731  05ef 261e          	jrne	L517
2734  05f1 4b02          	push	#2
2735  05f3 4b10          	push	#16
2736  05f5 ae0000        	ldw	x,#_OctetArray
2737  05f8 89            	pushw	x
2738  05f9 c60000        	ld	a,_uip_ethaddr6
2740  05fc               LC004:
2741  05fc b703          	ld	c_lreg+3,a
2742  05fe 3f02          	clr	c_lreg+2
2743  0600 3f01          	clr	c_lreg+1
2744  0602 3f00          	clr	c_lreg
2745  0604 be02          	ldw	x,c_lreg+2
2746  0606 89            	pushw	x
2747  0607 be00          	ldw	x,c_lreg
2748  0609 89            	pushw	x
2749  060a cd008c        	call	_emb_itoa
2750  060d 5b08          	addw	sp,#8
2751  060f               L517:
2752                     ; 1248           *pBuffer = OctetArray[0];
2754  060f 1e08          	ldw	x,(OFST+1,sp)
2755  0611 c60000        	ld	a,_OctetArray
2756  0614 f7            	ld	(x),a
2757                     ; 1249           pBuffer++;
2759  0615 5c            	incw	x
2760  0616 1f08          	ldw	(OFST+1,sp),x
2761                     ; 1250           nBytes++;
2763  0618 1e05          	ldw	x,(OFST-2,sp)
2764  061a 5c            	incw	x
2765  061b 1f05          	ldw	(OFST-2,sp),x
2767                     ; 1252           *pBuffer = OctetArray[1];
2769  061d c60001        	ld	a,_OctetArray+1
2770  0620 1e08          	ldw	x,(OFST+1,sp)
2771  0622               LC010:
2772  0622 f7            	ld	(x),a
2773                     ; 1253           pBuffer++;
2774                     ; 1254           nBytes++;
2776  0623 cc0af0        	jp	LC009
2777  0626               L117:
2778                     ; 1259         else if (nParsedMode == 'e') {
2780  0626 a165          	cp	a,#101
2781  0628 2703cc0801    	jrne	L347
2782                     ; 1286           switch (nParsedNum)
2784  062d 7b04          	ld	a,(OFST-3,sp)
2786                     ; 1311 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
2787  062f a116          	cp	a,#22
2788  0631 2503cc07c2    	jruge	L725
2789  0636 5f            	clrw	x
2790  0637 97            	ld	xl,a
2791  0638 58            	sllw	x
2792  0639 de2bcf        	ldw	x,(L422,x)
2793  063c fc            	jp	(x)
2794  063d               L354:
2795                     ; 1289 	    case 0:  emb_itoa(uip_stat.ip.drop,      OctetArray, 10, 10); break;
2797  063d 4b0a          	push	#10
2798  063f 4b0a          	push	#10
2799  0641 ae0000        	ldw	x,#_OctetArray
2800  0644 89            	pushw	x
2801  0645 ce0002        	ldw	x,_uip_stat+2
2802  0648 89            	pushw	x
2803  0649 ce0000        	ldw	x,_uip_stat
2807  064c cc07cc        	jra	L747
2808  064f               L554:
2809                     ; 1290 	    case 1:  emb_itoa(uip_stat.ip.recv,      OctetArray, 10, 10); break;
2811  064f 4b0a          	push	#10
2812  0651 4b0a          	push	#10
2813  0653 ae0000        	ldw	x,#_OctetArray
2814  0656 89            	pushw	x
2815  0657 ce0006        	ldw	x,_uip_stat+6
2816  065a 89            	pushw	x
2817  065b ce0004        	ldw	x,_uip_stat+4
2821  065e cc07cc        	jra	L747
2822  0661               L754:
2823                     ; 1291 	    case 2:  emb_itoa(uip_stat.ip.sent,      OctetArray, 10, 10); break;
2825  0661 4b0a          	push	#10
2826  0663 4b0a          	push	#10
2827  0665 ae0000        	ldw	x,#_OctetArray
2828  0668 89            	pushw	x
2829  0669 ce000a        	ldw	x,_uip_stat+10
2830  066c 89            	pushw	x
2831  066d ce0008        	ldw	x,_uip_stat+8
2835  0670 cc07cc        	jra	L747
2836  0673               L164:
2837                     ; 1292 	    case 3:  emb_itoa(uip_stat.ip.vhlerr,    OctetArray, 10, 10); break;
2839  0673 4b0a          	push	#10
2840  0675 4b0a          	push	#10
2841  0677 ae0000        	ldw	x,#_OctetArray
2842  067a 89            	pushw	x
2843  067b ce000e        	ldw	x,_uip_stat+14
2844  067e 89            	pushw	x
2845  067f ce000c        	ldw	x,_uip_stat+12
2849  0682 cc07cc        	jra	L747
2850  0685               L364:
2851                     ; 1293 	    case 4:  emb_itoa(uip_stat.ip.hblenerr,  OctetArray, 10, 10); break;
2853  0685 4b0a          	push	#10
2854  0687 4b0a          	push	#10
2855  0689 ae0000        	ldw	x,#_OctetArray
2856  068c 89            	pushw	x
2857  068d ce0012        	ldw	x,_uip_stat+18
2858  0690 89            	pushw	x
2859  0691 ce0010        	ldw	x,_uip_stat+16
2863  0694 cc07cc        	jra	L747
2864  0697               L564:
2865                     ; 1294 	    case 5:  emb_itoa(uip_stat.ip.lblenerr,  OctetArray, 10, 10); break;
2867  0697 4b0a          	push	#10
2868  0699 4b0a          	push	#10
2869  069b ae0000        	ldw	x,#_OctetArray
2870  069e 89            	pushw	x
2871  069f ce0016        	ldw	x,_uip_stat+22
2872  06a2 89            	pushw	x
2873  06a3 ce0014        	ldw	x,_uip_stat+20
2877  06a6 cc07cc        	jra	L747
2878  06a9               L764:
2879                     ; 1295 	    case 6:  emb_itoa(uip_stat.ip.fragerr,   OctetArray, 10, 10); break;
2881  06a9 4b0a          	push	#10
2882  06ab 4b0a          	push	#10
2883  06ad ae0000        	ldw	x,#_OctetArray
2884  06b0 89            	pushw	x
2885  06b1 ce001a        	ldw	x,_uip_stat+26
2886  06b4 89            	pushw	x
2887  06b5 ce0018        	ldw	x,_uip_stat+24
2891  06b8 cc07cc        	jra	L747
2892  06bb               L174:
2893                     ; 1296 	    case 7:  emb_itoa(uip_stat.ip.chkerr,    OctetArray, 10, 10); break;
2895  06bb 4b0a          	push	#10
2896  06bd 4b0a          	push	#10
2897  06bf ae0000        	ldw	x,#_OctetArray
2898  06c2 89            	pushw	x
2899  06c3 ce001e        	ldw	x,_uip_stat+30
2900  06c6 89            	pushw	x
2901  06c7 ce001c        	ldw	x,_uip_stat+28
2905  06ca cc07cc        	jra	L747
2906  06cd               L374:
2907                     ; 1297 	    case 8:  emb_itoa(uip_stat.ip.protoerr,  OctetArray, 10, 10); break;
2909  06cd 4b0a          	push	#10
2910  06cf 4b0a          	push	#10
2911  06d1 ae0000        	ldw	x,#_OctetArray
2912  06d4 89            	pushw	x
2913  06d5 ce0022        	ldw	x,_uip_stat+34
2914  06d8 89            	pushw	x
2915  06d9 ce0020        	ldw	x,_uip_stat+32
2919  06dc cc07cc        	jra	L747
2920  06df               L574:
2921                     ; 1298 	    case 9:  emb_itoa(uip_stat.icmp.drop,    OctetArray, 10, 10); break;
2923  06df 4b0a          	push	#10
2924  06e1 4b0a          	push	#10
2925  06e3 ae0000        	ldw	x,#_OctetArray
2926  06e6 89            	pushw	x
2927  06e7 ce0026        	ldw	x,_uip_stat+38
2928  06ea 89            	pushw	x
2929  06eb ce0024        	ldw	x,_uip_stat+36
2933  06ee cc07cc        	jra	L747
2934  06f1               L774:
2935                     ; 1299 	    case 10: emb_itoa(uip_stat.icmp.recv,    OctetArray, 10, 10); break;
2937  06f1 4b0a          	push	#10
2938  06f3 4b0a          	push	#10
2939  06f5 ae0000        	ldw	x,#_OctetArray
2940  06f8 89            	pushw	x
2941  06f9 ce002a        	ldw	x,_uip_stat+42
2942  06fc 89            	pushw	x
2943  06fd ce0028        	ldw	x,_uip_stat+40
2947  0700 cc07cc        	jra	L747
2948  0703               L105:
2949                     ; 1300 	    case 11: emb_itoa(uip_stat.icmp.sent,    OctetArray, 10, 10); break;
2951  0703 4b0a          	push	#10
2952  0705 4b0a          	push	#10
2953  0707 ae0000        	ldw	x,#_OctetArray
2954  070a 89            	pushw	x
2955  070b ce002e        	ldw	x,_uip_stat+46
2956  070e 89            	pushw	x
2957  070f ce002c        	ldw	x,_uip_stat+44
2961  0712 cc07cc        	jra	L747
2962  0715               L305:
2963                     ; 1301 	    case 12: emb_itoa(uip_stat.icmp.typeerr, OctetArray, 10, 10); break;
2965  0715 4b0a          	push	#10
2966  0717 4b0a          	push	#10
2967  0719 ae0000        	ldw	x,#_OctetArray
2968  071c 89            	pushw	x
2969  071d ce0032        	ldw	x,_uip_stat+50
2970  0720 89            	pushw	x
2971  0721 ce0030        	ldw	x,_uip_stat+48
2975  0724 cc07cc        	jra	L747
2976  0727               L505:
2977                     ; 1302 	    case 13: emb_itoa(uip_stat.tcp.drop,     OctetArray, 10, 10); break;
2979  0727 4b0a          	push	#10
2980  0729 4b0a          	push	#10
2981  072b ae0000        	ldw	x,#_OctetArray
2982  072e 89            	pushw	x
2983  072f ce0036        	ldw	x,_uip_stat+54
2984  0732 89            	pushw	x
2985  0733 ce0034        	ldw	x,_uip_stat+52
2989  0736 cc07cc        	jra	L747
2990  0739               L705:
2991                     ; 1303 	    case 14: emb_itoa(uip_stat.tcp.recv,     OctetArray, 10, 10); break;
2993  0739 4b0a          	push	#10
2994  073b 4b0a          	push	#10
2995  073d ae0000        	ldw	x,#_OctetArray
2996  0740 89            	pushw	x
2997  0741 ce003a        	ldw	x,_uip_stat+58
2998  0744 89            	pushw	x
2999  0745 ce0038        	ldw	x,_uip_stat+56
3003  0748 cc07cc        	jra	L747
3004  074b               L115:
3005                     ; 1304 	    case 15: emb_itoa(uip_stat.tcp.sent,     OctetArray, 10, 10); break;
3007  074b 4b0a          	push	#10
3008  074d 4b0a          	push	#10
3009  074f ae0000        	ldw	x,#_OctetArray
3010  0752 89            	pushw	x
3011  0753 ce003e        	ldw	x,_uip_stat+62
3012  0756 89            	pushw	x
3013  0757 ce003c        	ldw	x,_uip_stat+60
3017  075a 2070          	jra	L747
3018  075c               L315:
3019                     ; 1305 	    case 16: emb_itoa(uip_stat.tcp.chkerr,   OctetArray, 10, 10); break;
3021  075c 4b0a          	push	#10
3022  075e 4b0a          	push	#10
3023  0760 ae0000        	ldw	x,#_OctetArray
3024  0763 89            	pushw	x
3025  0764 ce0042        	ldw	x,_uip_stat+66
3026  0767 89            	pushw	x
3027  0768 ce0040        	ldw	x,_uip_stat+64
3031  076b 205f          	jra	L747
3032  076d               L515:
3033                     ; 1306 	    case 17: emb_itoa(uip_stat.tcp.ackerr,   OctetArray, 10, 10); break;
3035  076d 4b0a          	push	#10
3036  076f 4b0a          	push	#10
3037  0771 ae0000        	ldw	x,#_OctetArray
3038  0774 89            	pushw	x
3039  0775 ce0046        	ldw	x,_uip_stat+70
3040  0778 89            	pushw	x
3041  0779 ce0044        	ldw	x,_uip_stat+68
3045  077c 204e          	jra	L747
3046  077e               L715:
3047                     ; 1307 	    case 18: emb_itoa(uip_stat.tcp.rst,      OctetArray, 10, 10); break;
3049  077e 4b0a          	push	#10
3050  0780 4b0a          	push	#10
3051  0782 ae0000        	ldw	x,#_OctetArray
3052  0785 89            	pushw	x
3053  0786 ce004a        	ldw	x,_uip_stat+74
3054  0789 89            	pushw	x
3055  078a ce0048        	ldw	x,_uip_stat+72
3059  078d 203d          	jra	L747
3060  078f               L125:
3061                     ; 1308 	    case 19: emb_itoa(uip_stat.tcp.rexmit,   OctetArray, 10, 10); break;
3063  078f 4b0a          	push	#10
3064  0791 4b0a          	push	#10
3065  0793 ae0000        	ldw	x,#_OctetArray
3066  0796 89            	pushw	x
3067  0797 ce004e        	ldw	x,_uip_stat+78
3068  079a 89            	pushw	x
3069  079b ce004c        	ldw	x,_uip_stat+76
3073  079e 202c          	jra	L747
3074  07a0               L325:
3075                     ; 1309 	    case 20: emb_itoa(uip_stat.tcp.syndrop,  OctetArray, 10, 10); break;
3077  07a0 4b0a          	push	#10
3078  07a2 4b0a          	push	#10
3079  07a4 ae0000        	ldw	x,#_OctetArray
3080  07a7 89            	pushw	x
3081  07a8 ce0052        	ldw	x,_uip_stat+82
3082  07ab 89            	pushw	x
3083  07ac ce0050        	ldw	x,_uip_stat+80
3087  07af 201b          	jra	L747
3088  07b1               L525:
3089                     ; 1310 	    case 21: emb_itoa(uip_stat.tcp.synrst,   OctetArray, 10, 10); break;
3091  07b1 4b0a          	push	#10
3092  07b3 4b0a          	push	#10
3093  07b5 ae0000        	ldw	x,#_OctetArray
3094  07b8 89            	pushw	x
3095  07b9 ce0056        	ldw	x,_uip_stat+86
3096  07bc 89            	pushw	x
3097  07bd ce0054        	ldw	x,_uip_stat+84
3101  07c0 200a          	jra	L747
3102  07c2               L725:
3103                     ; 1311 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3105  07c2 4b0a          	push	#10
3106  07c4 4b0a          	push	#10
3107  07c6 ae0000        	ldw	x,#_OctetArray
3108  07c9 89            	pushw	x
3109  07ca 5f            	clrw	x
3110  07cb 89            	pushw	x
3114  07cc               L747:
3115  07cc 89            	pushw	x
3116  07cd cd008c        	call	_emb_itoa
3117  07d0 5b08          	addw	sp,#8
3118                     ; 1314 	  for (i=0; i<10; i++) {
3120  07d2 4f            	clr	a
3121  07d3 6b07          	ld	(OFST+0,sp),a
3123  07d5               L157:
3124                     ; 1315             *pBuffer = OctetArray[i];
3126  07d5 5f            	clrw	x
3127  07d6 97            	ld	xl,a
3128  07d7 d60000        	ld	a,(_OctetArray,x)
3129  07da 1e08          	ldw	x,(OFST+1,sp)
3130  07dc f7            	ld	(x),a
3131                     ; 1316             pBuffer++;
3133  07dd 5c            	incw	x
3134  07de 1f08          	ldw	(OFST+1,sp),x
3135                     ; 1317             nBytes++;
3137  07e0 1e05          	ldw	x,(OFST-2,sp)
3138  07e2 5c            	incw	x
3139  07e3 1f05          	ldw	(OFST-2,sp),x
3141                     ; 1314 	  for (i=0; i<10; i++) {
3143  07e5 0c07          	inc	(OFST+0,sp)
3147  07e7 7b07          	ld	a,(OFST+0,sp)
3148  07e9 a10a          	cp	a,#10
3149  07eb 25e8          	jrult	L157
3150                     ; 1322           *ppData = *ppData + 10;
3152  07ed 1e0c          	ldw	x,(OFST+5,sp)
3153  07ef 9093          	ldw	y,x
3154  07f1 fe            	ldw	x,(x)
3155  07f2 1c000a        	addw	x,#10
3156  07f5 90ff          	ldw	(y),x
3157                     ; 1323           *pDataLeft = *pDataLeft - 10;
3159  07f7 1e0e          	ldw	x,(OFST+7,sp)
3160  07f9 9093          	ldw	y,x
3161  07fb fe            	ldw	x,(x)
3162  07fc 1d000a        	subw	x,#10
3164  07ff 2031          	jp	LC011
3165  0801               L347:
3166                     ; 1328         else if (nParsedMode == 'f') {
3168  0801 a166          	cp	a,#102
3169  0803 2632          	jrne	L167
3170                     ; 1331 	  for(i=0; i<16; i++) {
3172  0805 4f            	clr	a
3173  0806 6b07          	ld	(OFST+0,sp),a
3175  0808               L367:
3176                     ; 1332 	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
3178  0808 cd125b        	call	_GpioGetPin
3180  080b 1e08          	ldw	x,(OFST+1,sp)
3181  080d ab30          	add	a,#48
3182  080f f7            	ld	(x),a
3183                     ; 1333             pBuffer++;
3185  0810 5c            	incw	x
3186  0811 1f08          	ldw	(OFST+1,sp),x
3187                     ; 1334             nBytes++;
3189  0813 1e05          	ldw	x,(OFST-2,sp)
3190  0815 5c            	incw	x
3191  0816 1f05          	ldw	(OFST-2,sp),x
3193                     ; 1331 	  for(i=0; i<16; i++) {
3195  0818 0c07          	inc	(OFST+0,sp)
3199  081a 7b07          	ld	a,(OFST+0,sp)
3200  081c a110          	cp	a,#16
3201  081e 25e8          	jrult	L367
3202                     ; 1338           *ppData = *ppData + 16;
3204  0820 1e0c          	ldw	x,(OFST+5,sp)
3205  0822 9093          	ldw	y,x
3206  0824 fe            	ldw	x,(x)
3207  0825 1c0010        	addw	x,#16
3208  0828 90ff          	ldw	(y),x
3209                     ; 1339           *pDataLeft = *pDataLeft - 16;
3211  082a 1e0e          	ldw	x,(OFST+7,sp)
3212  082c 9093          	ldw	y,x
3213  082e fe            	ldw	x,(x)
3214  082f 1d0010        	subw	x,#16
3215  0832               LC011:
3216  0832 90ff          	ldw	(y),x
3218  0834 cc0af8        	jra	L306
3219  0837               L167:
3220                     ; 1342         else if (nParsedMode == 'g') {
3222  0837 a167          	cp	a,#103
3223  0839 2623          	jrne	L377
3224                     ; 1346 	  if (invert_output == 1) {  // Insert 'checked'
3226  083b c60000        	ld	a,_invert_output
3227  083e 4a            	dec	a
3228  083f 26f3          	jrne	L306
3229                     ; 1347             for(i=0; i<7; i++) {
3231  0841 6b07          	ld	(OFST+0,sp),a
3233  0843               L777:
3234                     ; 1348               *pBuffer = checked[i];
3236  0843 5f            	clrw	x
3237  0844 97            	ld	xl,a
3238  0845 d60000        	ld	a,(L31_checked,x)
3239  0848 1e08          	ldw	x,(OFST+1,sp)
3240  084a f7            	ld	(x),a
3241                     ; 1349               pBuffer++;
3243  084b 5c            	incw	x
3244  084c 1f08          	ldw	(OFST+1,sp),x
3245                     ; 1350               nBytes++;
3247  084e 1e05          	ldw	x,(OFST-2,sp)
3248  0850 5c            	incw	x
3249  0851 1f05          	ldw	(OFST-2,sp),x
3251                     ; 1347             for(i=0; i<7; i++) {
3253  0853 0c07          	inc	(OFST+0,sp)
3257  0855 7b07          	ld	a,(OFST+0,sp)
3258  0857 a107          	cp	a,#7
3259  0859 25e8          	jrult	L777
3260  085b cc0af8        	jra	L306
3261  085e               L377:
3262                     ; 1355         else if (nParsedMode == 'h') {
3264  085e a168          	cp	a,#104
3265  0860 2622          	jrne	L7001
3266                     ; 1360 	  if (invert_output == 0) {  // Insert 'checked'
3268  0862 c60000        	ld	a,_invert_output
3269  0865 26f4          	jrne	L306
3270                     ; 1361             for(i=0; i<7; i++) {
3272  0867 6b07          	ld	(OFST+0,sp),a
3274  0869               L3101:
3275                     ; 1362               *pBuffer = checked[i];
3277  0869 5f            	clrw	x
3278  086a 97            	ld	xl,a
3279  086b d60000        	ld	a,(L31_checked,x)
3280  086e 1e08          	ldw	x,(OFST+1,sp)
3281  0870 f7            	ld	(x),a
3282                     ; 1363               pBuffer++;
3284  0871 5c            	incw	x
3285  0872 1f08          	ldw	(OFST+1,sp),x
3286                     ; 1364               nBytes++;
3288  0874 1e05          	ldw	x,(OFST-2,sp)
3289  0876 5c            	incw	x
3290  0877 1f05          	ldw	(OFST-2,sp),x
3292                     ; 1361             for(i=0; i<7; i++) {
3294  0879 0c07          	inc	(OFST+0,sp)
3298  087b 7b07          	ld	a,(OFST+0,sp)
3299  087d a107          	cp	a,#7
3300  087f 25e8          	jrult	L3101
3301  0881 cc0af8        	jra	L306
3302  0884               L7001:
3303                     ; 1369         else if (nParsedMode == 'x') {
3305  0884 a178          	cp	a,#120
3306  0886 26f9          	jrne	L306
3307                     ; 1379           *pBuffer = 'h'; pBuffer++; nBytes++;
3309  0888 1e08          	ldw	x,(OFST+1,sp)
3310  088a a668          	ld	a,#104
3311  088c f7            	ld	(x),a
3314  088d 5c            	incw	x
3315  088e 1f08          	ldw	(OFST+1,sp),x
3318  0890 1e05          	ldw	x,(OFST-2,sp)
3319  0892 5c            	incw	x
3320  0893 1f05          	ldw	(OFST-2,sp),x
3322                     ; 1380           *pBuffer = 't'; pBuffer++; nBytes++;
3324  0895 1e08          	ldw	x,(OFST+1,sp)
3325  0897 a674          	ld	a,#116
3326  0899 f7            	ld	(x),a
3329  089a 5c            	incw	x
3330  089b 1f08          	ldw	(OFST+1,sp),x
3333  089d 1e05          	ldw	x,(OFST-2,sp)
3334  089f 5c            	incw	x
3335  08a0 1f05          	ldw	(OFST-2,sp),x
3337                     ; 1381           *pBuffer = 't'; pBuffer++; nBytes++;
3339  08a2 1e08          	ldw	x,(OFST+1,sp)
3340  08a4 f7            	ld	(x),a
3343  08a5 5c            	incw	x
3344  08a6 1f08          	ldw	(OFST+1,sp),x
3347  08a8 1e05          	ldw	x,(OFST-2,sp)
3348  08aa 5c            	incw	x
3349  08ab 1f05          	ldw	(OFST-2,sp),x
3351                     ; 1382           *pBuffer = 'p'; pBuffer++; nBytes++;
3353  08ad 1e08          	ldw	x,(OFST+1,sp)
3354  08af a670          	ld	a,#112
3355  08b1 f7            	ld	(x),a
3358  08b2 5c            	incw	x
3359  08b3 1f08          	ldw	(OFST+1,sp),x
3362  08b5 1e05          	ldw	x,(OFST-2,sp)
3363  08b7 5c            	incw	x
3364  08b8 1f05          	ldw	(OFST-2,sp),x
3366                     ; 1383           *pBuffer = ':'; pBuffer++; nBytes++;
3368  08ba 1e08          	ldw	x,(OFST+1,sp)
3369  08bc a63a          	ld	a,#58
3370  08be f7            	ld	(x),a
3373  08bf 5c            	incw	x
3374  08c0 1f08          	ldw	(OFST+1,sp),x
3377  08c2 1e05          	ldw	x,(OFST-2,sp)
3378  08c4 5c            	incw	x
3379  08c5 1f05          	ldw	(OFST-2,sp),x
3381                     ; 1384           *pBuffer = '/'; pBuffer++; nBytes++;
3383  08c7 1e08          	ldw	x,(OFST+1,sp)
3384  08c9 a62f          	ld	a,#47
3385  08cb f7            	ld	(x),a
3388  08cc 5c            	incw	x
3389  08cd 1f08          	ldw	(OFST+1,sp),x
3392  08cf 1e05          	ldw	x,(OFST-2,sp)
3393  08d1 5c            	incw	x
3394  08d2 1f05          	ldw	(OFST-2,sp),x
3396                     ; 1385           *pBuffer = '/'; pBuffer++; nBytes++;
3398  08d4 1e08          	ldw	x,(OFST+1,sp)
3399  08d6 f7            	ld	(x),a
3402  08d7 5c            	incw	x
3403  08d8 1f08          	ldw	(OFST+1,sp),x
3406  08da 1e05          	ldw	x,(OFST-2,sp)
3407  08dc 5c            	incw	x
3408  08dd 1f05          	ldw	(OFST-2,sp),x
3410                     ; 1389           emb_itoa(ex_stored_hostaddr4,  OctetArray, 10, 3);
3412  08df 4b03          	push	#3
3413  08e1 4b0a          	push	#10
3414  08e3 ae0000        	ldw	x,#_OctetArray
3415  08e6 89            	pushw	x
3416  08e7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr4
3417  08ec 3f02          	clr	c_lreg+2
3418  08ee 3f01          	clr	c_lreg+1
3419  08f0 3f00          	clr	c_lreg
3420  08f2 be02          	ldw	x,c_lreg+2
3421  08f4 89            	pushw	x
3422  08f5 be00          	ldw	x,c_lreg
3423  08f7 89            	pushw	x
3424  08f8 cd008c        	call	_emb_itoa
3426  08fb 5b08          	addw	sp,#8
3427                     ; 1391 	  if (OctetArray[0] != '0') {
3429  08fd c60000        	ld	a,_OctetArray
3430  0900 a130          	cp	a,#48
3431  0902 270b          	jreq	L5201
3432                     ; 1392 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3434  0904 1e08          	ldw	x,(OFST+1,sp)
3435  0906 f7            	ld	(x),a
3438  0907 5c            	incw	x
3439  0908 1f08          	ldw	(OFST+1,sp),x
3442  090a 1e05          	ldw	x,(OFST-2,sp)
3443  090c 5c            	incw	x
3444  090d 1f05          	ldw	(OFST-2,sp),x
3446  090f               L5201:
3447                     ; 1394 	  if (OctetArray[0] != '0') {
3449  090f a130          	cp	a,#48
3450  0911 2707          	jreq	L7201
3451                     ; 1395             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3453  0913 1e08          	ldw	x,(OFST+1,sp)
3454  0915 c60001        	ld	a,_OctetArray+1
3458  0918 2009          	jp	LC005
3459  091a               L7201:
3460                     ; 1397 	  else if (OctetArray[1] != '0') {
3462  091a c60001        	ld	a,_OctetArray+1
3463  091d a130          	cp	a,#48
3464  091f 270b          	jreq	L1301
3465                     ; 1398             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3467  0921 1e08          	ldw	x,(OFST+1,sp)
3472  0923               LC005:
3473  0923 f7            	ld	(x),a
3475  0924 5c            	incw	x
3476  0925 1f08          	ldw	(OFST+1,sp),x
3478  0927 1e05          	ldw	x,(OFST-2,sp)
3479  0929 5c            	incw	x
3480  092a 1f05          	ldw	(OFST-2,sp),x
3482  092c               L1301:
3483                     ; 1400           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3485  092c 1e08          	ldw	x,(OFST+1,sp)
3486  092e c60002        	ld	a,_OctetArray+2
3487  0931 f7            	ld	(x),a
3490  0932 5c            	incw	x
3491  0933 1f08          	ldw	(OFST+1,sp),x
3494  0935 1e05          	ldw	x,(OFST-2,sp)
3495  0937 5c            	incw	x
3496  0938 1f05          	ldw	(OFST-2,sp),x
3498                     ; 1402           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3500  093a 1e08          	ldw	x,(OFST+1,sp)
3501  093c a62e          	ld	a,#46
3502  093e f7            	ld	(x),a
3505  093f 5c            	incw	x
3506  0940 1f08          	ldw	(OFST+1,sp),x
3509  0942 1e05          	ldw	x,(OFST-2,sp)
3510  0944 5c            	incw	x
3511  0945 1f05          	ldw	(OFST-2,sp),x
3513                     ; 1405           emb_itoa(ex_stored_hostaddr3,  OctetArray, 10, 3);
3515  0947 4b03          	push	#3
3516  0949 4b0a          	push	#10
3517  094b ae0000        	ldw	x,#_OctetArray
3518  094e 89            	pushw	x
3519  094f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr3
3520  0954 3f02          	clr	c_lreg+2
3521  0956 3f01          	clr	c_lreg+1
3522  0958 3f00          	clr	c_lreg
3523  095a be02          	ldw	x,c_lreg+2
3524  095c 89            	pushw	x
3525  095d be00          	ldw	x,c_lreg
3526  095f 89            	pushw	x
3527  0960 cd008c        	call	_emb_itoa
3529  0963 5b08          	addw	sp,#8
3530                     ; 1407 	  if (OctetArray[0] != '0') {
3532  0965 c60000        	ld	a,_OctetArray
3533  0968 a130          	cp	a,#48
3534  096a 270b          	jreq	L5301
3535                     ; 1408 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3537  096c 1e08          	ldw	x,(OFST+1,sp)
3538  096e f7            	ld	(x),a
3541  096f 5c            	incw	x
3542  0970 1f08          	ldw	(OFST+1,sp),x
3545  0972 1e05          	ldw	x,(OFST-2,sp)
3546  0974 5c            	incw	x
3547  0975 1f05          	ldw	(OFST-2,sp),x
3549  0977               L5301:
3550                     ; 1410 	  if (OctetArray[0] != '0') {
3552  0977 a130          	cp	a,#48
3553  0979 2707          	jreq	L7301
3554                     ; 1411             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3556  097b 1e08          	ldw	x,(OFST+1,sp)
3557  097d c60001        	ld	a,_OctetArray+1
3561  0980 2009          	jp	LC006
3562  0982               L7301:
3563                     ; 1413 	  else if (OctetArray[1] != '0') {
3565  0982 c60001        	ld	a,_OctetArray+1
3566  0985 a130          	cp	a,#48
3567  0987 270b          	jreq	L1401
3568                     ; 1414             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3570  0989 1e08          	ldw	x,(OFST+1,sp)
3575  098b               LC006:
3576  098b f7            	ld	(x),a
3578  098c 5c            	incw	x
3579  098d 1f08          	ldw	(OFST+1,sp),x
3581  098f 1e05          	ldw	x,(OFST-2,sp)
3582  0991 5c            	incw	x
3583  0992 1f05          	ldw	(OFST-2,sp),x
3585  0994               L1401:
3586                     ; 1416           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3588  0994 1e08          	ldw	x,(OFST+1,sp)
3589  0996 c60002        	ld	a,_OctetArray+2
3590  0999 f7            	ld	(x),a
3593  099a 5c            	incw	x
3594  099b 1f08          	ldw	(OFST+1,sp),x
3597  099d 1e05          	ldw	x,(OFST-2,sp)
3598  099f 5c            	incw	x
3599  09a0 1f05          	ldw	(OFST-2,sp),x
3601                     ; 1418           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3603  09a2 1e08          	ldw	x,(OFST+1,sp)
3604  09a4 a62e          	ld	a,#46
3605  09a6 f7            	ld	(x),a
3608  09a7 5c            	incw	x
3609  09a8 1f08          	ldw	(OFST+1,sp),x
3612  09aa 1e05          	ldw	x,(OFST-2,sp)
3613  09ac 5c            	incw	x
3614  09ad 1f05          	ldw	(OFST-2,sp),x
3616                     ; 1421           emb_itoa(ex_stored_hostaddr2,  OctetArray, 10, 3);
3618  09af 4b03          	push	#3
3619  09b1 4b0a          	push	#10
3620  09b3 ae0000        	ldw	x,#_OctetArray
3621  09b6 89            	pushw	x
3622  09b7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr2
3623  09bc 3f02          	clr	c_lreg+2
3624  09be 3f01          	clr	c_lreg+1
3625  09c0 3f00          	clr	c_lreg
3626  09c2 be02          	ldw	x,c_lreg+2
3627  09c4 89            	pushw	x
3628  09c5 be00          	ldw	x,c_lreg
3629  09c7 89            	pushw	x
3630  09c8 cd008c        	call	_emb_itoa
3632  09cb 5b08          	addw	sp,#8
3633                     ; 1423 	  if (OctetArray[0] != '0') {
3635  09cd c60000        	ld	a,_OctetArray
3636  09d0 a130          	cp	a,#48
3637  09d2 270b          	jreq	L5401
3638                     ; 1424 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3640  09d4 1e08          	ldw	x,(OFST+1,sp)
3641  09d6 f7            	ld	(x),a
3644  09d7 5c            	incw	x
3645  09d8 1f08          	ldw	(OFST+1,sp),x
3648  09da 1e05          	ldw	x,(OFST-2,sp)
3649  09dc 5c            	incw	x
3650  09dd 1f05          	ldw	(OFST-2,sp),x
3652  09df               L5401:
3653                     ; 1426 	  if (OctetArray[0] != '0') {
3655  09df a130          	cp	a,#48
3656  09e1 2707          	jreq	L7401
3657                     ; 1427             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3659  09e3 1e08          	ldw	x,(OFST+1,sp)
3660  09e5 c60001        	ld	a,_OctetArray+1
3664  09e8 2009          	jp	LC007
3665  09ea               L7401:
3666                     ; 1429 	  else if (OctetArray[1] != '0') {
3668  09ea c60001        	ld	a,_OctetArray+1
3669  09ed a130          	cp	a,#48
3670  09ef 270b          	jreq	L1501
3671                     ; 1430             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3673  09f1 1e08          	ldw	x,(OFST+1,sp)
3678  09f3               LC007:
3679  09f3 f7            	ld	(x),a
3681  09f4 5c            	incw	x
3682  09f5 1f08          	ldw	(OFST+1,sp),x
3684  09f7 1e05          	ldw	x,(OFST-2,sp)
3685  09f9 5c            	incw	x
3686  09fa 1f05          	ldw	(OFST-2,sp),x
3688  09fc               L1501:
3689                     ; 1432           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3691  09fc 1e08          	ldw	x,(OFST+1,sp)
3692  09fe c60002        	ld	a,_OctetArray+2
3693  0a01 f7            	ld	(x),a
3696  0a02 5c            	incw	x
3697  0a03 1f08          	ldw	(OFST+1,sp),x
3700  0a05 1e05          	ldw	x,(OFST-2,sp)
3701  0a07 5c            	incw	x
3702  0a08 1f05          	ldw	(OFST-2,sp),x
3704                     ; 1434           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3706  0a0a 1e08          	ldw	x,(OFST+1,sp)
3707  0a0c a62e          	ld	a,#46
3708  0a0e f7            	ld	(x),a
3711  0a0f 5c            	incw	x
3712  0a10 1f08          	ldw	(OFST+1,sp),x
3715  0a12 1e05          	ldw	x,(OFST-2,sp)
3716  0a14 5c            	incw	x
3717  0a15 1f05          	ldw	(OFST-2,sp),x
3719                     ; 1437           emb_itoa(ex_stored_hostaddr1,  OctetArray, 10, 3);
3721  0a17 4b03          	push	#3
3722  0a19 4b0a          	push	#10
3723  0a1b ae0000        	ldw	x,#_OctetArray
3724  0a1e 89            	pushw	x
3725  0a1f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr1
3726  0a24 3f02          	clr	c_lreg+2
3727  0a26 3f01          	clr	c_lreg+1
3728  0a28 3f00          	clr	c_lreg
3729  0a2a be02          	ldw	x,c_lreg+2
3730  0a2c 89            	pushw	x
3731  0a2d be00          	ldw	x,c_lreg
3732  0a2f 89            	pushw	x
3733  0a30 cd008c        	call	_emb_itoa
3735  0a33 5b08          	addw	sp,#8
3736                     ; 1439 	  if (OctetArray[0] != '0') {
3738  0a35 c60000        	ld	a,_OctetArray
3739  0a38 a130          	cp	a,#48
3740  0a3a 270b          	jreq	L5501
3741                     ; 1440 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3743  0a3c 1e08          	ldw	x,(OFST+1,sp)
3744  0a3e f7            	ld	(x),a
3747  0a3f 5c            	incw	x
3748  0a40 1f08          	ldw	(OFST+1,sp),x
3751  0a42 1e05          	ldw	x,(OFST-2,sp)
3752  0a44 5c            	incw	x
3753  0a45 1f05          	ldw	(OFST-2,sp),x
3755  0a47               L5501:
3756                     ; 1442 	  if (OctetArray[0] != '0') {
3758  0a47 a130          	cp	a,#48
3759  0a49 2707          	jreq	L7501
3760                     ; 1443             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3762  0a4b 1e08          	ldw	x,(OFST+1,sp)
3763  0a4d c60001        	ld	a,_OctetArray+1
3767  0a50 2009          	jp	LC008
3768  0a52               L7501:
3769                     ; 1445 	  else if (OctetArray[1] != '0') {
3771  0a52 c60001        	ld	a,_OctetArray+1
3772  0a55 a130          	cp	a,#48
3773  0a57 270b          	jreq	L1601
3774                     ; 1446             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3776  0a59 1e08          	ldw	x,(OFST+1,sp)
3781  0a5b               LC008:
3782  0a5b f7            	ld	(x),a
3784  0a5c 5c            	incw	x
3785  0a5d 1f08          	ldw	(OFST+1,sp),x
3787  0a5f 1e05          	ldw	x,(OFST-2,sp)
3788  0a61 5c            	incw	x
3789  0a62 1f05          	ldw	(OFST-2,sp),x
3791  0a64               L1601:
3792                     ; 1448           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3794  0a64 1e08          	ldw	x,(OFST+1,sp)
3795  0a66 c60002        	ld	a,_OctetArray+2
3796  0a69 f7            	ld	(x),a
3799  0a6a 5c            	incw	x
3800  0a6b 1f08          	ldw	(OFST+1,sp),x
3803  0a6d 1e05          	ldw	x,(OFST-2,sp)
3804  0a6f 5c            	incw	x
3805  0a70 1f05          	ldw	(OFST-2,sp),x
3807                     ; 1450           *pBuffer = ':'; pBuffer++; nBytes++; // Output ':'
3809  0a72 1e08          	ldw	x,(OFST+1,sp)
3810  0a74 a63a          	ld	a,#58
3811  0a76 f7            	ld	(x),a
3814  0a77 5c            	incw	x
3815  0a78 1f08          	ldw	(OFST+1,sp),x
3818  0a7a 1e05          	ldw	x,(OFST-2,sp)
3819  0a7c 5c            	incw	x
3820  0a7d 1f05          	ldw	(OFST-2,sp),x
3822                     ; 1453   	  emb_itoa(ex_stored_port, OctetArray, 10, 5);
3824  0a7f 4b05          	push	#5
3825  0a81 4b0a          	push	#10
3826  0a83 ae0000        	ldw	x,#_OctetArray
3827  0a86 89            	pushw	x
3828  0a87 ce0000        	ldw	x,_ex_stored_port
3829  0a8a cd0000        	call	c_uitolx
3831  0a8d be02          	ldw	x,c_lreg+2
3832  0a8f 89            	pushw	x
3833  0a90 be00          	ldw	x,c_lreg
3834  0a92 89            	pushw	x
3835  0a93 cd008c        	call	_emb_itoa
3837  0a96 5b08          	addw	sp,#8
3838                     ; 1455 	  for(i=0; i<5; i++) {
3840  0a98 4f            	clr	a
3841  0a99 6b07          	ld	(OFST+0,sp),a
3843  0a9b               L5601:
3844                     ; 1456 	    if (OctetArray[i] != '0') break;
3846  0a9b 5f            	clrw	x
3847  0a9c 97            	ld	xl,a
3848  0a9d d60000        	ld	a,(_OctetArray,x)
3849  0aa0 a130          	cp	a,#48
3850  0aa2 261c          	jrne	L7701
3853                     ; 1455 	  for(i=0; i<5; i++) {
3855  0aa4 0c07          	inc	(OFST+0,sp)
3859  0aa6 7b07          	ld	a,(OFST+0,sp)
3860  0aa8 a105          	cp	a,#5
3861  0aaa 25ef          	jrult	L5601
3862  0aac 2012          	jra	L7701
3863  0aae               L5701:
3864                     ; 1459 	    *pBuffer = OctetArray[i]; pBuffer++; nBytes++;
3866  0aae 5f            	clrw	x
3867  0aaf 97            	ld	xl,a
3868  0ab0 d60000        	ld	a,(_OctetArray,x)
3869  0ab3 1e08          	ldw	x,(OFST+1,sp)
3870  0ab5 f7            	ld	(x),a
3873  0ab6 5c            	incw	x
3874  0ab7 1f08          	ldw	(OFST+1,sp),x
3877  0ab9 1e05          	ldw	x,(OFST-2,sp)
3878  0abb 5c            	incw	x
3879  0abc 1f05          	ldw	(OFST-2,sp),x
3881                     ; 1460 	    i++;
3883  0abe 0c07          	inc	(OFST+0,sp)
3885  0ac0               L7701:
3886                     ; 1458 	  while(i<5) {
3888  0ac0 7b07          	ld	a,(OFST+0,sp)
3889  0ac2 a105          	cp	a,#5
3890  0ac4 25e8          	jrult	L5701
3891                     ; 1465           *ppData = *ppData + 28;
3893  0ac6 1e0c          	ldw	x,(OFST+5,sp)
3894  0ac8 9093          	ldw	y,x
3895  0aca fe            	ldw	x,(x)
3896  0acb 1c001c        	addw	x,#28
3897  0ace 90ff          	ldw	(y),x
3898                     ; 1466           *pDataLeft = *pDataLeft - 28;
3900  0ad0 1e0e          	ldw	x,(OFST+7,sp)
3901  0ad2 9093          	ldw	y,x
3902  0ad4 fe            	ldw	x,(x)
3903  0ad5 1d001c        	subw	x,#28
3904  0ad8 cc0832        	jp	LC011
3905  0adb               L116:
3906                     ; 1470         *pBuffer = nByte;
3908  0adb 1e08          	ldw	x,(OFST+1,sp)
3909  0add f7            	ld	(x),a
3910                     ; 1471         *ppData = *ppData + 1;
3912  0ade 1e0c          	ldw	x,(OFST+5,sp)
3913  0ae0 9093          	ldw	y,x
3914  0ae2 fe            	ldw	x,(x)
3915  0ae3 5c            	incw	x
3916  0ae4 90ff          	ldw	(y),x
3917                     ; 1472         *pDataLeft = *pDataLeft - 1;
3919  0ae6 1e0e          	ldw	x,(OFST+7,sp)
3920  0ae8 9093          	ldw	y,x
3921  0aea fe            	ldw	x,(x)
3922  0aeb 5a            	decw	x
3923  0aec 90ff          	ldw	(y),x
3924                     ; 1473         pBuffer++;
3926  0aee 1e08          	ldw	x,(OFST+1,sp)
3927                     ; 1474         nBytes++;
3929  0af0               LC009:
3932  0af0 5c            	incw	x
3933  0af1 1f08          	ldw	(OFST+1,sp),x
3936  0af3 1e05          	ldw	x,(OFST-2,sp)
3937  0af5 5c            	incw	x
3938  0af6 1f05          	ldw	(OFST-2,sp),x
3940  0af8               L306:
3941                     ; 1008   while (nBytes < nMaxBytes) {
3943  0af8 1e05          	ldw	x,(OFST-2,sp)
3944  0afa 1310          	cpw	x,(OFST+9,sp)
3945  0afc 2403cc02e1    	jrult	L106
3946  0b01               L506:
3947                     ; 1479   return nBytes;
3949  0b01 1e05          	ldw	x,(OFST-2,sp)
3952  0b03 5b09          	addw	sp,#9
3953  0b05 81            	ret	
3980                     ; 1483 void HttpDInit()
3980                     ; 1484 {
3981                     	switch	.text
3982  0b06               _HttpDInit:
3986                     ; 1486   uip_listen(htons(Port_Httpd));
3988  0b06 ce0000        	ldw	x,_Port_Httpd
3989  0b09 cd0000        	call	_htons
3991  0b0c cd0000        	call	_uip_listen
3993                     ; 1487   current_webpage = WEBPAGE_DEFAULT;
3995  0b0f 725f000b      	clr	_current_webpage
3996                     ; 1488 }
3999  0b13 81            	ret	
4204                     ; 1491 void HttpDCall(	uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
4204                     ; 1492 {
4205                     	switch	.text
4206  0b14               _HttpDCall:
4208  0b14 89            	pushw	x
4209  0b15 5207          	subw	sp,#7
4210       00000007      OFST:	set	7
4213                     ; 1502   alpha_1 = '0';
4215                     ; 1503   alpha_2 = '0';
4217                     ; 1504   alpha_3 = '0';
4219                     ; 1505   alpha_4 = '0';
4221                     ; 1506   alpha_5 = '0';
4223                     ; 1508   if (uip_connected()) {
4225  0b17 720d00007a    	btjf	_uip_flags,#6,L1421
4226                     ; 1510     if (current_webpage == WEBPAGE_DEFAULT) {
4228  0b1c c6000b        	ld	a,_current_webpage
4229  0b1f 260e          	jrne	L3421
4230                     ; 1511       pSocket->pData = g_HtmlPageDefault;
4232  0b21 1e0e          	ldw	x,(OFST+7,sp)
4233  0b23 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
4234  0b27 ef01          	ldw	(1,x),y
4235                     ; 1512       pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
4237  0b29 90ae09ee      	ldw	y,#2542
4239  0b2d 2058          	jp	LC012
4240  0b2f               L3421:
4241                     ; 1516     else if (current_webpage == WEBPAGE_ADDRESS) {
4243  0b2f a101          	cp	a,#1
4244  0b31 260e          	jrne	L7421
4245                     ; 1517       pSocket->pData = g_HtmlPageAddress;
4247  0b33 1e0e          	ldw	x,(OFST+7,sp)
4248  0b35 90ae09f7      	ldw	y,#L71_g_HtmlPageAddress
4249  0b39 ef01          	ldw	(1,x),y
4250                     ; 1518       pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
4252  0b3b 90ae1113      	ldw	y,#4371
4254  0b3f 2046          	jp	LC012
4255  0b41               L7421:
4256                     ; 1522     else if (current_webpage == WEBPAGE_HELP) {
4258  0b41 a103          	cp	a,#3
4259  0b43 260e          	jrne	L3521
4260                     ; 1523       pSocket->pData = g_HtmlPageHelp;
4262  0b45 1e0e          	ldw	x,(OFST+7,sp)
4263  0b47 90ae1b0b      	ldw	y,#L12_g_HtmlPageHelp
4264  0b4b ef01          	ldw	(1,x),y
4265                     ; 1524       pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
4267  0b4d 90ae02fb      	ldw	y,#763
4269  0b51 2034          	jp	LC012
4270  0b53               L3521:
4271                     ; 1526     else if (current_webpage == WEBPAGE_HELP2) {
4273  0b53 a104          	cp	a,#4
4274  0b55 260e          	jrne	L7521
4275                     ; 1527       pSocket->pData = g_HtmlPageHelp2;
4277  0b57 1e0e          	ldw	x,(OFST+7,sp)
4278  0b59 90ae1e07      	ldw	y,#L32_g_HtmlPageHelp2
4279  0b5d ef01          	ldw	(1,x),y
4280                     ; 1528       pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
4282  0b5f 90ae02a1      	ldw	y,#673
4284  0b63 2022          	jp	LC012
4285  0b65               L7521:
4286                     ; 1533     else if (current_webpage == WEBPAGE_STATS) {
4288  0b65 a105          	cp	a,#5
4289  0b67 260e          	jrne	L3621
4290                     ; 1534       pSocket->pData = g_HtmlPageStats;
4292  0b69 1e0e          	ldw	x,(OFST+7,sp)
4293  0b6b 90ae20a9      	ldw	y,#L52_g_HtmlPageStats
4294  0b6f ef01          	ldw	(1,x),y
4295                     ; 1535       pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
4297  0b71 90ae0a94      	ldw	y,#2708
4299  0b75 2010          	jp	LC012
4300  0b77               L3621:
4301                     ; 1538     else if (current_webpage == WEBPAGE_RSTATE) {
4303  0b77 a106          	cp	a,#6
4304  0b79 260e          	jrne	L5421
4305                     ; 1539       pSocket->pData = g_HtmlPageRstate;
4307  0b7b 1e0e          	ldw	x,(OFST+7,sp)
4308  0b7d 90ae2b3e      	ldw	y,#L72_g_HtmlPageRstate
4309  0b81 ef01          	ldw	(1,x),y
4310                     ; 1540       pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
4312  0b83 90ae0078      	ldw	y,#120
4313  0b87               LC012:
4314  0b87 ef03          	ldw	(3,x),y
4315  0b89               L5421:
4316                     ; 1542     pSocket->nNewlines = 0;
4318  0b89 1e0e          	ldw	x,(OFST+7,sp)
4319                     ; 1543     pSocket->nState = STATE_CONNECTED;
4321  0b8b 7f            	clr	(x)
4322  0b8c 6f05          	clr	(5,x)
4323                     ; 1544     pSocket->nPrevBytes = 0xFFFF;
4325  0b8e 90aeffff      	ldw	y,#65535
4326  0b92 ef0a          	ldw	(10,x),y
4328  0b94 2041          	jra	L413
4329  0b96               L1421:
4330                     ; 1546   else if (uip_newdata() || uip_acked()) {
4332  0b96 7202000008    	btjt	_uip_flags,#1,L5721
4334  0b9b 7200000003cc  	btjf	_uip_flags,#0,L3721
4335  0ba3               L5721:
4336                     ; 1547     if (pSocket->nState == STATE_CONNECTED) {
4338  0ba3 1e0e          	ldw	x,(OFST+7,sp)
4339  0ba5 f6            	ld	a,(x)
4340  0ba6 2627          	jrne	L7721
4341                     ; 1548       if (nBytes == 0) return;
4343  0ba8 1e0c          	ldw	x,(OFST+5,sp)
4344  0baa 272b          	jreq	L413
4347                     ; 1549       if (*pBuffer == 'G') pSocket->nState = STATE_GET_G;
4349  0bac 1e08          	ldw	x,(OFST+1,sp)
4350  0bae f6            	ld	a,(x)
4351  0baf a147          	cp	a,#71
4352  0bb1 2606          	jrne	L3031
4355  0bb3 1e0e          	ldw	x,(OFST+7,sp)
4356  0bb5 a601          	ld	a,#1
4358  0bb7 2008          	jp	LC013
4359  0bb9               L3031:
4360                     ; 1550       else if (*pBuffer == 'P') pSocket->nState = STATE_POST_P;
4362  0bb9 a150          	cp	a,#80
4363  0bbb 2605          	jrne	L5031
4366  0bbd 1e0e          	ldw	x,(OFST+7,sp)
4367  0bbf a604          	ld	a,#4
4368  0bc1               LC013:
4369  0bc1 f7            	ld	(x),a
4370  0bc2               L5031:
4371                     ; 1551       nBytes--;
4373  0bc2 1e0c          	ldw	x,(OFST+5,sp)
4374  0bc4 5a            	decw	x
4375  0bc5 1f0c          	ldw	(OFST+5,sp),x
4376                     ; 1552       pBuffer++;
4378  0bc7 1e08          	ldw	x,(OFST+1,sp)
4379  0bc9 5c            	incw	x
4380  0bca 1f08          	ldw	(OFST+1,sp),x
4381  0bcc 1e0e          	ldw	x,(OFST+7,sp)
4382  0bce f6            	ld	a,(x)
4383  0bcf               L7721:
4384                     ; 1555     if (pSocket->nState == STATE_GET_G) {
4386  0bcf a101          	cp	a,#1
4387  0bd1 2620          	jrne	L1131
4388                     ; 1556       if (nBytes == 0) return;
4390  0bd3 1e0c          	ldw	x,(OFST+5,sp)
4391  0bd5 2603          	jrne	L3131
4393  0bd7               L413:
4396  0bd7 5b09          	addw	sp,#9
4397  0bd9 81            	ret	
4398  0bda               L3131:
4399                     ; 1557       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
4401  0bda 1e08          	ldw	x,(OFST+1,sp)
4402  0bdc f6            	ld	a,(x)
4403  0bdd a145          	cp	a,#69
4404  0bdf 2605          	jrne	L5131
4407  0be1 1e0e          	ldw	x,(OFST+7,sp)
4408  0be3 a602          	ld	a,#2
4409  0be5 f7            	ld	(x),a
4410  0be6               L5131:
4411                     ; 1558       nBytes--;
4413  0be6 1e0c          	ldw	x,(OFST+5,sp)
4414  0be8 5a            	decw	x
4415  0be9 1f0c          	ldw	(OFST+5,sp),x
4416                     ; 1559       pBuffer++;
4418  0beb 1e08          	ldw	x,(OFST+1,sp)
4419  0bed 5c            	incw	x
4420  0bee 1f08          	ldw	(OFST+1,sp),x
4421  0bf0 1e0e          	ldw	x,(OFST+7,sp)
4422  0bf2 f6            	ld	a,(x)
4423  0bf3               L1131:
4424                     ; 1562     if (pSocket->nState == STATE_GET_GE) {
4426  0bf3 a102          	cp	a,#2
4427  0bf5 261d          	jrne	L7131
4428                     ; 1563       if (nBytes == 0) return;
4430  0bf7 1e0c          	ldw	x,(OFST+5,sp)
4431  0bf9 27dc          	jreq	L413
4434                     ; 1564       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
4436  0bfb 1e08          	ldw	x,(OFST+1,sp)
4437  0bfd f6            	ld	a,(x)
4438  0bfe a154          	cp	a,#84
4439  0c00 2605          	jrne	L3231
4442  0c02 1e0e          	ldw	x,(OFST+7,sp)
4443  0c04 a603          	ld	a,#3
4444  0c06 f7            	ld	(x),a
4445  0c07               L3231:
4446                     ; 1565       nBytes--;
4448  0c07 1e0c          	ldw	x,(OFST+5,sp)
4449  0c09 5a            	decw	x
4450  0c0a 1f0c          	ldw	(OFST+5,sp),x
4451                     ; 1566       pBuffer++;
4453  0c0c 1e08          	ldw	x,(OFST+1,sp)
4454  0c0e 5c            	incw	x
4455  0c0f 1f08          	ldw	(OFST+1,sp),x
4456  0c11 1e0e          	ldw	x,(OFST+7,sp)
4457  0c13 f6            	ld	a,(x)
4458  0c14               L7131:
4459                     ; 1569     if (pSocket->nState == STATE_GET_GET) {
4461  0c14 a103          	cp	a,#3
4462  0c16 261d          	jrne	L5231
4463                     ; 1570       if (nBytes == 0) return;
4465  0c18 1e0c          	ldw	x,(OFST+5,sp)
4466  0c1a 27bb          	jreq	L413
4469                     ; 1571       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
4471  0c1c 1e08          	ldw	x,(OFST+1,sp)
4472  0c1e f6            	ld	a,(x)
4473  0c1f a120          	cp	a,#32
4474  0c21 2605          	jrne	L1331
4477  0c23 1e0e          	ldw	x,(OFST+7,sp)
4478  0c25 a608          	ld	a,#8
4479  0c27 f7            	ld	(x),a
4480  0c28               L1331:
4481                     ; 1572       nBytes--;
4483  0c28 1e0c          	ldw	x,(OFST+5,sp)
4484  0c2a 5a            	decw	x
4485  0c2b 1f0c          	ldw	(OFST+5,sp),x
4486                     ; 1573       pBuffer++;
4488  0c2d 1e08          	ldw	x,(OFST+1,sp)
4489  0c2f 5c            	incw	x
4490  0c30 1f08          	ldw	(OFST+1,sp),x
4491  0c32 1e0e          	ldw	x,(OFST+7,sp)
4492  0c34 f6            	ld	a,(x)
4493  0c35               L5231:
4494                     ; 1576     if (pSocket->nState == STATE_POST_P) {
4496  0c35 a104          	cp	a,#4
4497  0c37 261d          	jrne	L3331
4498                     ; 1577       if (nBytes == 0) return;
4500  0c39 1e0c          	ldw	x,(OFST+5,sp)
4501  0c3b 279a          	jreq	L413
4504                     ; 1578       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
4506  0c3d 1e08          	ldw	x,(OFST+1,sp)
4507  0c3f f6            	ld	a,(x)
4508  0c40 a14f          	cp	a,#79
4509  0c42 2605          	jrne	L7331
4512  0c44 1e0e          	ldw	x,(OFST+7,sp)
4513  0c46 a605          	ld	a,#5
4514  0c48 f7            	ld	(x),a
4515  0c49               L7331:
4516                     ; 1579       nBytes--;
4518  0c49 1e0c          	ldw	x,(OFST+5,sp)
4519  0c4b 5a            	decw	x
4520  0c4c 1f0c          	ldw	(OFST+5,sp),x
4521                     ; 1580       pBuffer++;
4523  0c4e 1e08          	ldw	x,(OFST+1,sp)
4524  0c50 5c            	incw	x
4525  0c51 1f08          	ldw	(OFST+1,sp),x
4526  0c53 1e0e          	ldw	x,(OFST+7,sp)
4527  0c55 f6            	ld	a,(x)
4528  0c56               L3331:
4529                     ; 1583     if (pSocket->nState == STATE_POST_PO) {
4531  0c56 a105          	cp	a,#5
4532  0c58 2620          	jrne	L1431
4533                     ; 1584       if (nBytes == 0) return;
4535  0c5a 1e0c          	ldw	x,(OFST+5,sp)
4536  0c5c 2603cc0bd7    	jreq	L413
4539                     ; 1585       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
4541  0c61 1e08          	ldw	x,(OFST+1,sp)
4542  0c63 f6            	ld	a,(x)
4543  0c64 a153          	cp	a,#83
4544  0c66 2605          	jrne	L5431
4547  0c68 1e0e          	ldw	x,(OFST+7,sp)
4548  0c6a a606          	ld	a,#6
4549  0c6c f7            	ld	(x),a
4550  0c6d               L5431:
4551                     ; 1586       nBytes--;
4553  0c6d 1e0c          	ldw	x,(OFST+5,sp)
4554  0c6f 5a            	decw	x
4555  0c70 1f0c          	ldw	(OFST+5,sp),x
4556                     ; 1587       pBuffer++;
4558  0c72 1e08          	ldw	x,(OFST+1,sp)
4559  0c74 5c            	incw	x
4560  0c75 1f08          	ldw	(OFST+1,sp),x
4561  0c77 1e0e          	ldw	x,(OFST+7,sp)
4562  0c79 f6            	ld	a,(x)
4563  0c7a               L1431:
4564                     ; 1590     if (pSocket->nState == STATE_POST_POS) {
4566  0c7a a106          	cp	a,#6
4567  0c7c 261d          	jrne	L7431
4568                     ; 1591       if (nBytes == 0) return;
4570  0c7e 1e0c          	ldw	x,(OFST+5,sp)
4571  0c80 27dc          	jreq	L413
4574                     ; 1592       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
4576  0c82 1e08          	ldw	x,(OFST+1,sp)
4577  0c84 f6            	ld	a,(x)
4578  0c85 a154          	cp	a,#84
4579  0c87 2605          	jrne	L3531
4582  0c89 1e0e          	ldw	x,(OFST+7,sp)
4583  0c8b a607          	ld	a,#7
4584  0c8d f7            	ld	(x),a
4585  0c8e               L3531:
4586                     ; 1593       nBytes--;
4588  0c8e 1e0c          	ldw	x,(OFST+5,sp)
4589  0c90 5a            	decw	x
4590  0c91 1f0c          	ldw	(OFST+5,sp),x
4591                     ; 1594       pBuffer++;
4593  0c93 1e08          	ldw	x,(OFST+1,sp)
4594  0c95 5c            	incw	x
4595  0c96 1f08          	ldw	(OFST+1,sp),x
4596  0c98 1e0e          	ldw	x,(OFST+7,sp)
4597  0c9a f6            	ld	a,(x)
4598  0c9b               L7431:
4599                     ; 1597     if (pSocket->nState == STATE_POST_POST) {
4601  0c9b a107          	cp	a,#7
4602  0c9d 261d          	jrne	L5531
4603                     ; 1598       if (nBytes == 0) return;
4605  0c9f 1e0c          	ldw	x,(OFST+5,sp)
4606  0ca1 27bb          	jreq	L413
4609                     ; 1599       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
4611  0ca3 1e08          	ldw	x,(OFST+1,sp)
4612  0ca5 f6            	ld	a,(x)
4613  0ca6 a120          	cp	a,#32
4614  0ca8 2605          	jrne	L1631
4617  0caa 1e0e          	ldw	x,(OFST+7,sp)
4618  0cac a609          	ld	a,#9
4619  0cae f7            	ld	(x),a
4620  0caf               L1631:
4621                     ; 1600       nBytes--;
4623  0caf 1e0c          	ldw	x,(OFST+5,sp)
4624  0cb1 5a            	decw	x
4625  0cb2 1f0c          	ldw	(OFST+5,sp),x
4626                     ; 1601       pBuffer++;
4628  0cb4 1e08          	ldw	x,(OFST+1,sp)
4629  0cb6 5c            	incw	x
4630  0cb7 1f08          	ldw	(OFST+1,sp),x
4631  0cb9 1e0e          	ldw	x,(OFST+7,sp)
4632  0cbb f6            	ld	a,(x)
4633  0cbc               L5531:
4634                     ; 1604     if (pSocket->nState == STATE_GOTPOST) {
4636  0cbc a109          	cp	a,#9
4637  0cbe 2647          	jrne	L3631
4639  0cc0 2041          	jra	L7631
4640  0cc2               L5631:
4641                     ; 1607         if (*pBuffer == '\n') pSocket->nNewlines++;
4643  0cc2 1e08          	ldw	x,(OFST+1,sp)
4644  0cc4 f6            	ld	a,(x)
4645  0cc5 a10a          	cp	a,#10
4646  0cc7 2606          	jrne	L3731
4649  0cc9 1e0e          	ldw	x,(OFST+7,sp)
4650  0ccb 6c05          	inc	(5,x)
4652  0ccd 2008          	jra	L5731
4653  0ccf               L3731:
4654                     ; 1608         else if (*pBuffer == '\r') { }
4656  0ccf a10d          	cp	a,#13
4657  0cd1 2704          	jreq	L5731
4659                     ; 1609         else pSocket->nNewlines = 0;
4661  0cd3 1e0e          	ldw	x,(OFST+7,sp)
4662  0cd5 6f05          	clr	(5,x)
4663  0cd7               L5731:
4664                     ; 1610         pBuffer++;
4666  0cd7 1e08          	ldw	x,(OFST+1,sp)
4667  0cd9 5c            	incw	x
4668  0cda 1f08          	ldw	(OFST+1,sp),x
4669                     ; 1611         nBytes--;
4671  0cdc 1e0c          	ldw	x,(OFST+5,sp)
4672  0cde 5a            	decw	x
4673  0cdf 1f0c          	ldw	(OFST+5,sp),x
4674                     ; 1612         if (pSocket->nNewlines == 2) {
4676  0ce1 1e0e          	ldw	x,(OFST+7,sp)
4677  0ce3 e605          	ld	a,(5,x)
4678  0ce5 a102          	cp	a,#2
4679  0ce7 261a          	jrne	L7631
4680                     ; 1615           if (current_webpage == WEBPAGE_DEFAULT) pSocket->nParseLeft = PARSEBYTES_DEFAULT;
4682  0ce9 c6000b        	ld	a,_current_webpage
4683  0cec 2607          	jrne	L5041
4686  0cee a618          	ld	a,#24
4687  0cf0 e706          	ld	(6,x),a
4688  0cf2 c6000b        	ld	a,_current_webpage
4689  0cf5               L5041:
4690                     ; 1616           if (current_webpage == WEBPAGE_ADDRESS) pSocket->nParseLeft = PARSEBYTES_ADDRESS;
4692  0cf5 4a            	dec	a
4693  0cf6 2604          	jrne	L7041
4696  0cf8 a693          	ld	a,#147
4697  0cfa e706          	ld	(6,x),a
4698  0cfc               L7041:
4699                     ; 1617           pSocket->ParseState = PARSE_CMD;
4701  0cfc 6f09          	clr	(9,x)
4702                     ; 1619           pSocket->nState = STATE_PARSEPOST;
4704  0cfe a60a          	ld	a,#10
4705  0d00 f7            	ld	(x),a
4706                     ; 1620           break;
4708  0d01 2004          	jra	L3631
4709  0d03               L7631:
4710                     ; 1606       while (nBytes != 0) {
4712  0d03 1e0c          	ldw	x,(OFST+5,sp)
4713  0d05 26bb          	jrne	L5631
4714  0d07               L3631:
4715                     ; 1625     if (pSocket->nState == STATE_GOTGET) {
4717  0d07 1e0e          	ldw	x,(OFST+7,sp)
4718  0d09 f6            	ld	a,(x)
4719  0d0a a108          	cp	a,#8
4720  0d0c 2609          	jrne	L1141
4721                     ; 1629       pSocket->nParseLeft = 6;
4723  0d0e a606          	ld	a,#6
4724  0d10 e706          	ld	(6,x),a
4725                     ; 1630       pSocket->ParseState = PARSE_SLASH1;
4727  0d12 e709          	ld	(9,x),a
4728                     ; 1632       pSocket->nState = STATE_PARSEGET;
4730  0d14 a60d          	ld	a,#13
4731  0d16 f7            	ld	(x),a
4732  0d17               L1141:
4733                     ; 1635     if (pSocket->nState == STATE_PARSEPOST) {
4735  0d17 a10a          	cp	a,#10
4736  0d19 2703cc0f89    	jrne	L3141
4738  0d1e cc0f7a        	jra	L7141
4739  0d21               L5141:
4740                     ; 1645         if (pSocket->ParseState == PARSE_CMD) {
4742  0d21 1e0e          	ldw	x,(OFST+7,sp)
4743  0d23 e609          	ld	a,(9,x)
4744  0d25 263e          	jrne	L3241
4745                     ; 1646           pSocket->ParseCmd = *pBuffer;
4747  0d27 1e08          	ldw	x,(OFST+1,sp)
4748  0d29 f6            	ld	a,(x)
4749  0d2a 1e0e          	ldw	x,(OFST+7,sp)
4750  0d2c e707          	ld	(7,x),a
4751                     ; 1647           pSocket->ParseState = PARSE_NUM10;
4753  0d2e a601          	ld	a,#1
4754  0d30 e709          	ld	(9,x),a
4755                     ; 1648 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
4757  0d32 e606          	ld	a,(6,x)
4758  0d34 2704          	jreq	L5241
4761  0d36 6a06          	dec	(6,x)
4763  0d38 2004          	jra	L7241
4764  0d3a               L5241:
4765                     ; 1649 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
4767  0d3a a605          	ld	a,#5
4768  0d3c e709          	ld	(9,x),a
4769  0d3e               L7241:
4770                     ; 1650           pBuffer++;
4772  0d3e 1e08          	ldw	x,(OFST+1,sp)
4773  0d40 5c            	incw	x
4774  0d41 1f08          	ldw	(OFST+1,sp),x
4775                     ; 1652 	  if (pSocket->ParseCmd == 'o' ||
4775                     ; 1653 	      pSocket->ParseCmd == 'a' ||
4775                     ; 1654 	      pSocket->ParseCmd == 'b' ||
4775                     ; 1655 	      pSocket->ParseCmd == 'c' ||
4775                     ; 1656 	      pSocket->ParseCmd == 'd' ||
4775                     ; 1657 	      pSocket->ParseCmd == 'g') { }
4777  0d43 1e0e          	ldw	x,(OFST+7,sp)
4778  0d45 e607          	ld	a,(7,x)
4779  0d47 a16f          	cp	a,#111
4780  0d49 2603cc0f6c    	jreq	L7441
4782  0d4e a161          	cp	a,#97
4783  0d50 27f9          	jreq	L7441
4785  0d52 a162          	cp	a,#98
4786  0d54 27f5          	jreq	L7441
4788  0d56 a163          	cp	a,#99
4789  0d58 27f1          	jreq	L7441
4791  0d5a a164          	cp	a,#100
4792  0d5c 27ed          	jreq	L7441
4794  0d5e a167          	cp	a,#103
4795  0d60 27e9          	jreq	L7441
4796                     ; 1658 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
4797  0d62 cc0f51        	jp	LC018
4798  0d65               L3241:
4799                     ; 1660         else if (pSocket->ParseState == PARSE_NUM10) {
4801  0d65 a101          	cp	a,#1
4802  0d67 2619          	jrne	L1541
4803                     ; 1661           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
4805  0d69 1e08          	ldw	x,(OFST+1,sp)
4806  0d6b f6            	ld	a,(x)
4807  0d6c 97            	ld	xl,a
4808  0d6d a60a          	ld	a,#10
4809  0d6f 42            	mul	x,a
4810  0d70 9f            	ld	a,xl
4811  0d71 1e0e          	ldw	x,(OFST+7,sp)
4812  0d73 a0e0          	sub	a,#224
4813  0d75 e708          	ld	(8,x),a
4814                     ; 1662           pSocket->ParseState = PARSE_NUM1;
4816  0d77 a602          	ld	a,#2
4817  0d79 e709          	ld	(9,x),a
4818                     ; 1663 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
4820  0d7b e606          	ld	a,(6,x)
4821  0d7d 2719          	jreq	L3641
4824  0d7f cc0f61        	jp	LC025
4825                     ; 1664 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
4826                     ; 1665           pBuffer++;
4828  0d82               L1541:
4829                     ; 1667         else if (pSocket->ParseState == PARSE_NUM1) {
4831  0d82 a102          	cp	a,#2
4832  0d84 2616          	jrne	L1641
4833                     ; 1668           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
4835  0d86 1608          	ldw	y,(OFST+1,sp)
4836  0d88 90f6          	ld	a,(y)
4837  0d8a a030          	sub	a,#48
4838  0d8c eb08          	add	a,(8,x)
4839  0d8e e708          	ld	(8,x),a
4840                     ; 1669           pSocket->ParseState = PARSE_EQUAL;
4842  0d90 a603          	ld	a,#3
4843  0d92 e709          	ld	(9,x),a
4844                     ; 1670 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
4846  0d94 e606          	ld	a,(6,x)
4849  0d96 26e7          	jrne	LC025
4850  0d98               L3641:
4851                     ; 1671 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
4854  0d98 a605          	ld	a,#5
4855                     ; 1672           pBuffer++;
4857  0d9a 200d          	jp	LC026
4858  0d9c               L1641:
4859                     ; 1674         else if (pSocket->ParseState == PARSE_EQUAL) {
4861  0d9c a103          	cp	a,#3
4862  0d9e 260e          	jrne	L1741
4863                     ; 1675           pSocket->ParseState = PARSE_VAL;
4865  0da0 a604          	ld	a,#4
4866  0da2 e709          	ld	(9,x),a
4867                     ; 1676 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
4869  0da4 6d06          	tnz	(6,x)
4872  0da6 26d7          	jrne	LC025
4873                     ; 1677 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
4875  0da8 4c            	inc	a
4876  0da9               LC026:
4877  0da9 e709          	ld	(9,x),a
4878                     ; 1678           pBuffer++;
4880  0dab cc0f63        	jp	LC017
4881  0dae               L1741:
4882                     ; 1680         else if (pSocket->ParseState == PARSE_VAL) {
4884  0dae a104          	cp	a,#4
4885  0db0 2703cc0f57    	jrne	L1051
4886                     ; 1688           if (pSocket->ParseCmd == 'o') {
4888  0db5 e607          	ld	a,(7,x)
4889  0db7 a16f          	cp	a,#111
4890  0db9 2625          	jrne	L3051
4891                     ; 1691             if ((uint8_t)(*pBuffer) == '1') GpioSetPin(pSocket->ParseNum, (uint8_t)1);
4893  0dbb 1e08          	ldw	x,(OFST+1,sp)
4894  0dbd f6            	ld	a,(x)
4895  0dbe a131          	cp	a,#49
4896  0dc0 2609          	jrne	L5051
4899  0dc2 1e0e          	ldw	x,(OFST+7,sp)
4900  0dc4 e608          	ld	a,(8,x)
4901  0dc6 ae0001        	ldw	x,#1
4904  0dc9 2005          	jra	L7051
4905  0dcb               L5051:
4906                     ; 1692             else GpioSetPin(pSocket->ParseNum, (uint8_t)0);
4908  0dcb 1e0e          	ldw	x,(OFST+7,sp)
4909  0dcd e608          	ld	a,(8,x)
4910  0dcf 5f            	clrw	x
4912  0dd0               L7051:
4913  0dd0 95            	ld	xh,a
4914  0dd1 cd131b        	call	_GpioSetPin
4915                     ; 1693 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
4917  0dd4 1e0e          	ldw	x,(OFST+7,sp)
4918  0dd6 e606          	ld	a,(6,x)
4919  0dd8 2603cc0f4a    	jreq	L1651
4921                     ; 1694             pBuffer++;
4923  0ddd cc0f48        	jp	LC024
4924  0de0               L3051:
4925                     ; 1697           else if (pSocket->ParseCmd == 'a') {
4927  0de0 a161          	cp	a,#97
4928  0de2 2656          	jrne	L5151
4929                     ; 1707             ex_stored_devicename[0] = (uint8_t)(*pBuffer);
4931  0de4 1e08          	ldw	x,(OFST+1,sp)
4932  0de6 f6            	ld	a,(x)
4933  0de7 c70000        	ld	_ex_stored_devicename,a
4934                     ; 1708             pSocket->nParseLeft--;
4936  0dea 1e0e          	ldw	x,(OFST+7,sp)
4937  0dec 6a06          	dec	(6,x)
4938                     ; 1709             pBuffer++; // nBytes already decremented for first char
4940  0dee 1e08          	ldw	x,(OFST+1,sp)
4941  0df0 5c            	incw	x
4942  0df1 1f08          	ldw	(OFST+1,sp),x
4943                     ; 1713 	    amp_found = 0;
4945  0df3 0f06          	clr	(OFST-1,sp)
4947                     ; 1714 	    for(i=1; i<20; i++) {
4949  0df5 a601          	ld	a,#1
4950  0df7 6b07          	ld	(OFST+0,sp),a
4952  0df9               L7151:
4953                     ; 1715 	      if ((uint8_t)(*pBuffer) == 38) amp_found = 1;
4955  0df9 1e08          	ldw	x,(OFST+1,sp)
4956  0dfb f6            	ld	a,(x)
4957  0dfc a126          	cp	a,#38
4958  0dfe 2604          	jrne	L5251
4961  0e00 a601          	ld	a,#1
4962  0e02 6b06          	ld	(OFST-1,sp),a
4964  0e04               L5251:
4965                     ; 1716 	      if (amp_found == 0) {
4967  0e04 7b06          	ld	a,(OFST-1,sp)
4968  0e06 261a          	jrne	L7251
4969                     ; 1718                 ex_stored_devicename[i] = (uint8_t)(*pBuffer);
4971  0e08 7b07          	ld	a,(OFST+0,sp)
4972  0e0a 5f            	clrw	x
4973  0e0b 1608          	ldw	y,(OFST+1,sp)
4974  0e0d 97            	ld	xl,a
4975  0e0e 90f6          	ld	a,(y)
4976  0e10 d70000        	ld	(_ex_stored_devicename,x),a
4977                     ; 1719                 pSocket->nParseLeft--;
4979  0e13 1e0e          	ldw	x,(OFST+7,sp)
4980  0e15 6a06          	dec	(6,x)
4981                     ; 1720                 pBuffer++;
4983  0e17 93            	ldw	x,y
4984  0e18 5c            	incw	x
4985  0e19 1f08          	ldw	(OFST+1,sp),x
4986                     ; 1721                 nBytes--; // Must subtract 1 from nBytes for extra byte read
4988  0e1b 1e0c          	ldw	x,(OFST+5,sp)
4989  0e1d 5a            	decw	x
4990  0e1e 1f0c          	ldw	(OFST+5,sp),x
4992  0e20 200d          	jra	L1351
4993  0e22               L7251:
4994                     ; 1725 	        ex_stored_devicename[i] = ' ';
4996  0e22 7b07          	ld	a,(OFST+0,sp)
4997  0e24 5f            	clrw	x
4998  0e25 97            	ld	xl,a
4999  0e26 a620          	ld	a,#32
5000  0e28 d70000        	ld	(_ex_stored_devicename,x),a
5001                     ; 1734                 pSocket->nParseLeft--;
5003  0e2b 1e0e          	ldw	x,(OFST+7,sp)
5004  0e2d 6a06          	dec	(6,x)
5005  0e2f               L1351:
5006                     ; 1714 	    for(i=1; i<20; i++) {
5008  0e2f 0c07          	inc	(OFST+0,sp)
5012  0e31 7b07          	ld	a,(OFST+0,sp)
5013  0e33 a114          	cp	a,#20
5014  0e35 25c2          	jrult	L7151
5016  0e37 cc0f4f        	jra	L3151
5017  0e3a               L5151:
5018                     ; 1739           else if (pSocket->ParseCmd == 'b') {
5020  0e3a a162          	cp	a,#98
5021  0e3c 2646          	jrne	L5351
5022                     ; 1746 	    alpha_1 = '-';
5024                     ; 1747 	    alpha_2 = '-';
5026                     ; 1748 	    alpha_3 = '-';
5028                     ; 1750             alpha_1 = (uint8_t)(*pBuffer);
5030  0e3e 1e08          	ldw	x,(OFST+1,sp)
5031  0e40 f6            	ld	a,(x)
5032  0e41 6b07          	ld	(OFST+0,sp),a
5034                     ; 1751             pSocket->nParseLeft--;
5036  0e43 1e0e          	ldw	x,(OFST+7,sp)
5037  0e45 6a06          	dec	(6,x)
5038                     ; 1752             pBuffer++; // nBytes already decremented for first char
5040  0e47 1e08          	ldw	x,(OFST+1,sp)
5041  0e49 5c            	incw	x
5042  0e4a 1f08          	ldw	(OFST+1,sp),x
5043                     ; 1754 	    alpha_2 = (uint8_t)(*pBuffer);
5045  0e4c f6            	ld	a,(x)
5046  0e4d 6b05          	ld	(OFST-2,sp),a
5048                     ; 1755             pSocket->nParseLeft--;
5050  0e4f 1e0e          	ldw	x,(OFST+7,sp)
5051  0e51 6a06          	dec	(6,x)
5052                     ; 1756             pBuffer++;
5054  0e53 1e08          	ldw	x,(OFST+1,sp)
5055  0e55 5c            	incw	x
5056  0e56 1f08          	ldw	(OFST+1,sp),x
5057                     ; 1757 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5059  0e58 1e0c          	ldw	x,(OFST+5,sp)
5060  0e5a 5a            	decw	x
5061  0e5b 1f0c          	ldw	(OFST+5,sp),x
5062                     ; 1759 	    alpha_3 = (uint8_t)(*pBuffer);
5064  0e5d 1e08          	ldw	x,(OFST+1,sp)
5065  0e5f f6            	ld	a,(x)
5066  0e60 6b06          	ld	(OFST-1,sp),a
5068                     ; 1760             pSocket->nParseLeft--;
5070  0e62 1e0e          	ldw	x,(OFST+7,sp)
5071  0e64 6a06          	dec	(6,x)
5072                     ; 1761             pBuffer++;
5074  0e66 1e08          	ldw	x,(OFST+1,sp)
5075  0e68 5c            	incw	x
5076  0e69 1f08          	ldw	(OFST+1,sp),x
5077                     ; 1762 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5079  0e6b 1e0c          	ldw	x,(OFST+5,sp)
5080  0e6d 5a            	decw	x
5081  0e6e 1f0c          	ldw	(OFST+5,sp),x
5082                     ; 1764 	    SetAddresses(pSocket->ParseNum, (uint8_t)alpha_1, (uint8_t)alpha_2, (uint8_t)alpha_3);
5084  0e70 88            	push	a
5085  0e71 7b06          	ld	a,(OFST-1,sp)
5086  0e73 88            	push	a
5087  0e74 7b09          	ld	a,(OFST+2,sp)
5088  0e76 1610          	ldw	y,(OFST+9,sp)
5089  0e78 97            	ld	xl,a
5090  0e79 90e608        	ld	a,(8,y)
5091  0e7c 95            	ld	xh,a
5092  0e7d cd131c        	call	_SetAddresses
5094  0e80 85            	popw	x
5096  0e81 cc0f4f        	jra	L3151
5097  0e84               L5351:
5098                     ; 1767           else if (pSocket->ParseCmd == 'c') {
5100  0e84 a163          	cp	a,#99
5101  0e86 2672          	jrne	L1451
5102                     ; 1773 	    alpha_1 = '-';
5104                     ; 1774 	    alpha_2 = '-';
5106                     ; 1775 	    alpha_3 = '-';
5108                     ; 1776 	    alpha_4 = '-';
5110                     ; 1777 	    alpha_5 = '-';
5112                     ; 1780   	    alpha_1 = (uint8_t)(*pBuffer);
5114  0e88 1e08          	ldw	x,(OFST+1,sp)
5115  0e8a f6            	ld	a,(x)
5116  0e8b 6b07          	ld	(OFST+0,sp),a
5118                     ; 1781             pSocket->nParseLeft--;
5120  0e8d 1e0e          	ldw	x,(OFST+7,sp)
5121  0e8f 6a06          	dec	(6,x)
5122                     ; 1782             pBuffer++; // nBytes already decremented for first char
5124  0e91 1e08          	ldw	x,(OFST+1,sp)
5125  0e93 5c            	incw	x
5126  0e94 1f08          	ldw	(OFST+1,sp),x
5127                     ; 1784 	    alpha_2 = (uint8_t)(*pBuffer);
5129  0e96 f6            	ld	a,(x)
5130  0e97 6b05          	ld	(OFST-2,sp),a
5132                     ; 1785             pSocket->nParseLeft--;
5134  0e99 1e0e          	ldw	x,(OFST+7,sp)
5135  0e9b 6a06          	dec	(6,x)
5136                     ; 1786             pBuffer++;
5138  0e9d 1e08          	ldw	x,(OFST+1,sp)
5139  0e9f 5c            	incw	x
5140  0ea0 1f08          	ldw	(OFST+1,sp),x
5141                     ; 1787 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5143  0ea2 1e0c          	ldw	x,(OFST+5,sp)
5144  0ea4 5a            	decw	x
5145  0ea5 1f0c          	ldw	(OFST+5,sp),x
5146                     ; 1789 	    alpha_3 = (uint8_t)(*pBuffer);
5148  0ea7 1e08          	ldw	x,(OFST+1,sp)
5149  0ea9 f6            	ld	a,(x)
5150  0eaa 6b06          	ld	(OFST-1,sp),a
5152                     ; 1790             pSocket->nParseLeft--;
5154  0eac 1e0e          	ldw	x,(OFST+7,sp)
5155  0eae 6a06          	dec	(6,x)
5156                     ; 1791             pBuffer++;
5158  0eb0 1e08          	ldw	x,(OFST+1,sp)
5159  0eb2 5c            	incw	x
5160  0eb3 1f08          	ldw	(OFST+1,sp),x
5161                     ; 1792 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5163  0eb5 1e0c          	ldw	x,(OFST+5,sp)
5164  0eb7 5a            	decw	x
5165  0eb8 1f0c          	ldw	(OFST+5,sp),x
5166                     ; 1794 	    alpha_4 = (uint8_t)(*pBuffer);
5168  0eba 1e08          	ldw	x,(OFST+1,sp)
5169  0ebc f6            	ld	a,(x)
5170  0ebd 6b03          	ld	(OFST-4,sp),a
5172                     ; 1795             pSocket->nParseLeft--;
5174  0ebf 1e0e          	ldw	x,(OFST+7,sp)
5175  0ec1 6a06          	dec	(6,x)
5176                     ; 1796             pBuffer++;
5178  0ec3 1e08          	ldw	x,(OFST+1,sp)
5179  0ec5 5c            	incw	x
5180  0ec6 1f08          	ldw	(OFST+1,sp),x
5181                     ; 1797 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5183  0ec8 1e0c          	ldw	x,(OFST+5,sp)
5184  0eca 5a            	decw	x
5185  0ecb 1f0c          	ldw	(OFST+5,sp),x
5186                     ; 1799             alpha_5 = (uint8_t)(*pBuffer);
5188  0ecd 1e08          	ldw	x,(OFST+1,sp)
5189  0ecf f6            	ld	a,(x)
5190  0ed0 6b04          	ld	(OFST-3,sp),a
5192                     ; 1800             pSocket->nParseLeft--;
5194  0ed2 1e0e          	ldw	x,(OFST+7,sp)
5195  0ed4 6a06          	dec	(6,x)
5196                     ; 1801             pBuffer++;
5198  0ed6 1e08          	ldw	x,(OFST+1,sp)
5199  0ed8 5c            	incw	x
5200  0ed9 1f08          	ldw	(OFST+1,sp),x
5201                     ; 1802 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5203  0edb 1e0c          	ldw	x,(OFST+5,sp)
5204  0edd 5a            	decw	x
5205  0ede 1f0c          	ldw	(OFST+5,sp),x
5206                     ; 1804 	    SetPort(pSocket->ParseNum,
5206                     ; 1805 	            (uint8_t)alpha_1,
5206                     ; 1806 		    (uint8_t)alpha_2,
5206                     ; 1807 		    (uint8_t)alpha_3,
5206                     ; 1808 		    (uint8_t)alpha_4,
5206                     ; 1809 		    (uint8_t)alpha_5);
5208  0ee0 88            	push	a
5209  0ee1 7b04          	ld	a,(OFST-3,sp)
5210  0ee3 88            	push	a
5211  0ee4 7b08          	ld	a,(OFST+1,sp)
5212  0ee6 88            	push	a
5213  0ee7 7b08          	ld	a,(OFST+1,sp)
5214  0ee9 88            	push	a
5215  0eea 7b0b          	ld	a,(OFST+4,sp)
5216  0eec 1612          	ldw	y,(OFST+11,sp)
5217  0eee 97            	ld	xl,a
5218  0eef 90e608        	ld	a,(8,y)
5219  0ef2 95            	ld	xh,a
5220  0ef3 cd13a6        	call	_SetPort
5222  0ef6 5b04          	addw	sp,#4
5224  0ef8 2055          	jra	L3151
5225  0efa               L1451:
5226                     ; 1812           else if (pSocket->ParseCmd == 'd') {
5228  0efa a164          	cp	a,#100
5229  0efc 262f          	jrne	L5451
5230                     ; 1818 	    alpha_1 = (uint8_t)(*pBuffer);
5232  0efe 1e08          	ldw	x,(OFST+1,sp)
5233  0f00 f6            	ld	a,(x)
5234  0f01 6b07          	ld	(OFST+0,sp),a
5236                     ; 1819             pSocket->nParseLeft--;
5238  0f03 1e0e          	ldw	x,(OFST+7,sp)
5239  0f05 6a06          	dec	(6,x)
5240                     ; 1820             pBuffer++; // nBytes already decremented for first char
5242  0f07 1e08          	ldw	x,(OFST+1,sp)
5243  0f09 5c            	incw	x
5244  0f0a 1f08          	ldw	(OFST+1,sp),x
5245                     ; 1822 	    alpha_2 = (uint8_t)(*pBuffer);
5247  0f0c f6            	ld	a,(x)
5248  0f0d 6b05          	ld	(OFST-2,sp),a
5250                     ; 1823             pSocket->nParseLeft--;
5252  0f0f 1e0e          	ldw	x,(OFST+7,sp)
5253  0f11 6a06          	dec	(6,x)
5254                     ; 1824             pBuffer++;
5256  0f13 1e08          	ldw	x,(OFST+1,sp)
5257  0f15 5c            	incw	x
5258  0f16 1f08          	ldw	(OFST+1,sp),x
5259                     ; 1825 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5261  0f18 1e0c          	ldw	x,(OFST+5,sp)
5262  0f1a 5a            	decw	x
5263  0f1b 1f0c          	ldw	(OFST+5,sp),x
5264                     ; 1827 	    SetMAC(pSocket->ParseNum, alpha_1, alpha_2);
5266  0f1d 88            	push	a
5267  0f1e 7b08          	ld	a,(OFST+1,sp)
5268  0f20 160f          	ldw	y,(OFST+8,sp)
5269  0f22 97            	ld	xl,a
5270  0f23 90e608        	ld	a,(8,y)
5271  0f26 95            	ld	xh,a
5272  0f27 cd13ea        	call	_SetMAC
5274  0f2a 84            	pop	a
5276  0f2b 2022          	jra	L3151
5277  0f2d               L5451:
5278                     ; 1830 	  else if (pSocket->ParseCmd == 'g') {
5280  0f2d a167          	cp	a,#103
5281  0f2f 261e          	jrne	L3151
5282                     ; 1833             if ((uint8_t)(*pBuffer) == '1') invert_output = 1;
5284  0f31 1e08          	ldw	x,(OFST+1,sp)
5285  0f33 f6            	ld	a,(x)
5286  0f34 a131          	cp	a,#49
5287  0f36 2606          	jrne	L3551
5290  0f38 35010000      	mov	_invert_output,#1
5292  0f3c 2004          	jra	L5551
5293  0f3e               L3551:
5294                     ; 1834             else invert_output = 0;
5296  0f3e 725f0000      	clr	_invert_output
5297  0f42               L5551:
5298                     ; 1835 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--;
5300  0f42 1e0e          	ldw	x,(OFST+7,sp)
5301  0f44 e606          	ld	a,(6,x)
5302  0f46 2702          	jreq	L1651
5305  0f48               LC024:
5307  0f48 6a06          	dec	(6,x)
5309  0f4a               L1651:
5310                     ; 1837             pBuffer++;
5313  0f4a 1e08          	ldw	x,(OFST+1,sp)
5314  0f4c 5c            	incw	x
5315  0f4d 1f08          	ldw	(OFST+1,sp),x
5316  0f4f               L3151:
5317                     ; 1840           pSocket->ParseState = PARSE_DELIM;
5319  0f4f 1e0e          	ldw	x,(OFST+7,sp)
5320  0f51               LC018:
5322  0f51 a605          	ld	a,#5
5323  0f53 e709          	ld	(9,x),a
5325  0f55 2015          	jra	L7441
5326  0f57               L1051:
5327                     ; 1843         else if (pSocket->ParseState == PARSE_DELIM) {
5329  0f57 a105          	cp	a,#5
5330  0f59 2611          	jrne	L7441
5331                     ; 1844           if (pSocket->nParseLeft > 0) {
5333  0f5b e606          	ld	a,(6,x)
5334  0f5d 270b          	jreq	L7651
5335                     ; 1845             pSocket->ParseState = PARSE_CMD;
5337  0f5f 6f09          	clr	(9,x)
5338                     ; 1846             pSocket->nParseLeft--;
5340  0f61               LC025:
5344  0f61 6a06          	dec	(6,x)
5345                     ; 1847             pBuffer++;
5347  0f63               LC017:
5351  0f63 1e08          	ldw	x,(OFST+1,sp)
5352  0f65 5c            	incw	x
5353  0f66 1f08          	ldw	(OFST+1,sp),x
5355  0f68 2002          	jra	L7441
5356  0f6a               L7651:
5357                     ; 1850             pSocket->nParseLeft = 0; // Something out of sync - end the parsing
5359  0f6a e706          	ld	(6,x),a
5360  0f6c               L7441:
5361                     ; 1854         if (pSocket->nParseLeft == 0) {
5363  0f6c 1e0e          	ldw	x,(OFST+7,sp)
5364  0f6e e606          	ld	a,(6,x)
5365  0f70 2608          	jrne	L7141
5366                     ; 1856           pSocket->nState = STATE_SENDHEADER;
5368  0f72 a60b          	ld	a,#11
5369  0f74 f7            	ld	(x),a
5370                     ; 1857           break;
5371  0f75               L1241:
5372                     ; 1861       pSocket->nState = STATE_SENDHEADER;
5374  0f75 1e0e          	ldw	x,(OFST+7,sp)
5375  0f77 f7            	ld	(x),a
5376  0f78 200f          	jra	L3141
5377  0f7a               L7141:
5378                     ; 1644       while (nBytes--) {
5380  0f7a 1e0c          	ldw	x,(OFST+5,sp)
5381  0f7c 5a            	decw	x
5382  0f7d 1f0c          	ldw	(OFST+5,sp),x
5383  0f7f 5c            	incw	x
5384  0f80 2703cc0d21    	jrne	L5141
5385  0f85 a60b          	ld	a,#11
5386  0f87 20ec          	jra	L1241
5387  0f89               L3141:
5388                     ; 1864     if (pSocket->nState == STATE_PARSEGET) {
5390  0f89 a10d          	cp	a,#13
5391  0f8b 2703cc1167    	jrne	L5751
5393  0f90 cc115c        	jra	L1061
5394  0f93               L7751:
5395                     ; 1878         if (pSocket->ParseState == PARSE_SLASH1) {
5397  0f93 1e0e          	ldw	x,(OFST+7,sp)
5398  0f95 e609          	ld	a,(9,x)
5399  0f97 a106          	cp	a,#6
5400  0f99 263e          	jrne	L5061
5401                     ; 1881           pSocket->ParseCmd = *pBuffer;
5403  0f9b 1e08          	ldw	x,(OFST+1,sp)
5404  0f9d f6            	ld	a,(x)
5405  0f9e 1e0e          	ldw	x,(OFST+7,sp)
5406  0fa0 e707          	ld	(7,x),a
5407                     ; 1882           pSocket->nParseLeft--;
5409  0fa2 6a06          	dec	(6,x)
5410                     ; 1883           pBuffer++;
5412  0fa4 1e08          	ldw	x,(OFST+1,sp)
5413  0fa6 5c            	incw	x
5414  0fa7 1f08          	ldw	(OFST+1,sp),x
5415                     ; 1884 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5417  0fa9 1e0e          	ldw	x,(OFST+7,sp)
5418  0fab e607          	ld	a,(7,x)
5419  0fad a12f          	cp	a,#47
5420  0faf 2604          	jrne	L7061
5421                     ; 1885 	    pSocket->ParseState = PARSE_NUM10;
5423  0fb1 a601          	ld	a,#1
5424  0fb3 e709          	ld	(9,x),a
5425  0fb5               L7061:
5426                     ; 1887 	  if (pSocket->nParseLeft == 0) {
5428  0fb5 e606          	ld	a,(6,x)
5429  0fb7 2703cc113a    	jrne	L3161
5430                     ; 1889 	    current_webpage = WEBPAGE_DEFAULT;
5432  0fbc c7000b        	ld	_current_webpage,a
5433                     ; 1890             pSocket->pData = g_HtmlPageDefault;
5435  0fbf 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5436  0fc3 ef01          	ldw	(1,x),y
5437                     ; 1891             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5439  0fc5 90ae09ee      	ldw	y,#2542
5440  0fc9 ef03          	ldw	(3,x),y
5441                     ; 1892             pSocket->nNewlines = 0;
5443  0fcb e705          	ld	(5,x),a
5444                     ; 1893             pSocket->nState = STATE_SENDHEADER;
5446  0fcd a60b          	ld	a,#11
5447  0fcf f7            	ld	(x),a
5448                     ; 1894             pSocket->nPrevBytes = 0xFFFF;
5450  0fd0 90aeffff      	ldw	y,#65535
5451  0fd4 ef0a          	ldw	(10,x),y
5452                     ; 1895             break;
5454  0fd6 cc1167        	jra	L5751
5455  0fd9               L5061:
5456                     ; 1898         else if (pSocket->ParseState == PARSE_NUM10) {
5458  0fd9 a101          	cp	a,#1
5459  0fdb 264e          	jrne	L5161
5460                     ; 1903 	  if (*pBuffer == ' ') {
5462  0fdd 1e08          	ldw	x,(OFST+1,sp)
5463  0fdf f6            	ld	a,(x)
5464  0fe0 a120          	cp	a,#32
5465  0fe2 2620          	jrne	L7161
5466                     ; 1904 	    current_webpage = WEBPAGE_DEFAULT;
5468  0fe4 725f000b      	clr	_current_webpage
5469                     ; 1905             pSocket->pData = g_HtmlPageDefault;
5471  0fe8 1e0e          	ldw	x,(OFST+7,sp)
5472  0fea 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5473  0fee ef01          	ldw	(1,x),y
5474                     ; 1906             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5476  0ff0 90ae09ee      	ldw	y,#2542
5477  0ff4 ef03          	ldw	(3,x),y
5478                     ; 1907             pSocket->nNewlines = 0;
5480  0ff6 6f05          	clr	(5,x)
5481                     ; 1908             pSocket->nState = STATE_SENDHEADER;
5483  0ff8 a60b          	ld	a,#11
5484  0ffa f7            	ld	(x),a
5485                     ; 1909             pSocket->nPrevBytes = 0xFFFF;
5487  0ffb 90aeffff      	ldw	y,#65535
5488  0fff ef0a          	ldw	(10,x),y
5489                     ; 1910 	    break;
5491  1001 cc1167        	jra	L5751
5492  1004               L7161:
5493                     ; 1913 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5495  1004 a130          	cp	a,#48
5496  1006 2504          	jrult	L1261
5498  1008 a13a          	cp	a,#58
5499  100a 2506          	jrult	L3261
5501  100c               L1261:
5502                     ; 1914 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5504  100c 1e0e          	ldw	x,(OFST+7,sp)
5505  100e a605          	ld	a,#5
5506  1010 e709          	ld	(9,x),a
5507  1012               L3261:
5508                     ; 1915           if (pSocket->ParseState == PARSE_NUM10) {      // Still good - parse number
5510  1012 1e0e          	ldw	x,(OFST+7,sp)
5511  1014 e609          	ld	a,(9,x)
5512  1016 4a            	dec	a
5513  1017 26a0          	jrne	L3161
5514                     ; 1916             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5516  1019 1e08          	ldw	x,(OFST+1,sp)
5517  101b f6            	ld	a,(x)
5518  101c 97            	ld	xl,a
5519  101d a60a          	ld	a,#10
5520  101f 42            	mul	x,a
5521  1020 9f            	ld	a,xl
5522  1021 1e0e          	ldw	x,(OFST+7,sp)
5523  1023 a0e0          	sub	a,#224
5524  1025 e708          	ld	(8,x),a
5525                     ; 1917 	    pSocket->ParseState = PARSE_NUM1;
5527  1027 a602          	ld	a,#2
5528                     ; 1918             pSocket->nParseLeft--;
5529                     ; 1919             pBuffer++;
5530  1029 202c          	jp	LC022
5531  102b               L5161:
5532                     ; 1923         else if (pSocket->ParseState == PARSE_NUM1) {
5534  102b a102          	cp	a,#2
5535  102d 2634          	jrne	L1361
5536                     ; 1924 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5538  102f 1e08          	ldw	x,(OFST+1,sp)
5539  1031 f6            	ld	a,(x)
5540  1032 a130          	cp	a,#48
5541  1034 2504          	jrult	L3361
5543  1036 a13a          	cp	a,#58
5544  1038 2506          	jrult	L5361
5546  103a               L3361:
5547                     ; 1925 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5549  103a 1e0e          	ldw	x,(OFST+7,sp)
5550  103c a605          	ld	a,#5
5551  103e e709          	ld	(9,x),a
5552  1040               L5361:
5553                     ; 1926           if (pSocket->ParseState == PARSE_NUM1) {       // Still good - parse number
5555  1040 1e0e          	ldw	x,(OFST+7,sp)
5556  1042 e609          	ld	a,(9,x)
5557  1044 a102          	cp	a,#2
5558  1046 2703cc113a    	jrne	L3161
5559                     ; 1927             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5561  104b 1608          	ldw	y,(OFST+1,sp)
5562  104d 90f6          	ld	a,(y)
5563  104f a030          	sub	a,#48
5564  1051 eb08          	add	a,(8,x)
5565  1053 e708          	ld	(8,x),a
5566                     ; 1928             pSocket->ParseState = PARSE_VAL;
5568  1055 a604          	ld	a,#4
5569                     ; 1929             pSocket->nParseLeft--;
5571                     ; 1930             pBuffer++;
5573  1057               LC022:
5574  1057 e709          	ld	(9,x),a
5576  1059 6a06          	dec	(6,x)
5578  105b 1e08          	ldw	x,(OFST+1,sp)
5579  105d 5c            	incw	x
5580  105e 1f08          	ldw	(OFST+1,sp),x
5581  1060 cc113a        	jra	L3161
5582  1063               L1361:
5583                     ; 1933         else if (pSocket->ParseState == PARSE_VAL) {
5585  1063 a104          	cp	a,#4
5586  1065 2703cc1142    	jrne	L3461
5587                     ; 1989           switch(pSocket->ParseNum)
5589  106a e608          	ld	a,(8,x)
5591                     ; 2154 	      break;
5592  106c a03c          	sub	a,#60
5593  106e 2731          	jreq	L7111
5594  1070 4a            	dec	a
5595  1071 273d          	jreq	L1211
5596  1073 a002          	sub	a,#2
5597  1075 2749          	jreq	L3211
5598  1077 4a            	dec	a
5599  1078 2756          	jreq	L5211
5600  107a 4a            	dec	a
5601  107b 2763          	jreq	L7211
5602  107d 4a            	dec	a
5603  107e 276b          	jreq	L1311
5604  1080 4a            	dec	a
5605  1081 2778          	jreq	L3311
5606  1083 a018          	sub	a,#24
5607  1085 2603cc1115    	jreq	L5311
5608  108a a008          	sub	a,#8
5609  108c 2603cc111b    	jreq	L7311
5610                     ; 2147 	    default: // Show IO state page
5610                     ; 2148 	      current_webpage = WEBPAGE_DEFAULT;
5612  1091 725f000b      	clr	_current_webpage
5613                     ; 2149               pSocket->pData = g_HtmlPageDefault;
5615  1095 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5616  1099 ef01          	ldw	(1,x),y
5617                     ; 2150               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5619  109b 90ae09ee      	ldw	y,#2542
5620                     ; 2151               pSocket->nNewlines = 0;
5621                     ; 2152               pSocket->nState = STATE_CONNECTED;
5622                     ; 2153               pSocket->nPrevBytes = 0xFFFF;
5623                     ; 2154 	      break;
5625  109f 206d          	jp	LC021
5626  10a1               L7111:
5627                     ; 2063 	    case 60: // Show IO states page
5627                     ; 2064 	      current_webpage = WEBPAGE_DEFAULT;
5629  10a1 c7000b        	ld	_current_webpage,a
5630                     ; 2065               pSocket->pData = g_HtmlPageDefault;
5632  10a4 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5633  10a8 ef01          	ldw	(1,x),y
5634                     ; 2066               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5636  10aa 90ae09ee      	ldw	y,#2542
5637                     ; 2067               pSocket->nNewlines = 0;
5638                     ; 2068               pSocket->nState = STATE_CONNECTED;
5639                     ; 2069               pSocket->nPrevBytes = 0xFFFF;
5640                     ; 2070 	      break;
5642  10ae 2079          	jp	LC020
5643  10b0               L1211:
5644                     ; 2072 	    case 61: // Show address settings page
5644                     ; 2073 	      current_webpage = WEBPAGE_ADDRESS;
5646  10b0 3501000b      	mov	_current_webpage,#1
5647                     ; 2074               pSocket->pData = g_HtmlPageAddress;
5649  10b4 90ae09f7      	ldw	y,#L71_g_HtmlPageAddress
5650  10b8 ef01          	ldw	(1,x),y
5651                     ; 2075               pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
5653  10ba 90ae1113      	ldw	y,#4371
5654                     ; 2076               pSocket->nNewlines = 0;
5655                     ; 2077               pSocket->nState = STATE_CONNECTED;
5656                     ; 2078               pSocket->nPrevBytes = 0xFFFF;
5657                     ; 2079 	      break;
5659  10be 2069          	jp	LC020
5660  10c0               L3211:
5661                     ; 2082 	    case 63: // Show help page 1
5661                     ; 2083 	      current_webpage = WEBPAGE_HELP;
5663  10c0 3503000b      	mov	_current_webpage,#3
5664                     ; 2084               pSocket->pData = g_HtmlPageHelp;
5666  10c4 90ae1b0b      	ldw	y,#L12_g_HtmlPageHelp
5667  10c8 ef01          	ldw	(1,x),y
5668                     ; 2085               pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
5670  10ca 90ae02fb      	ldw	y,#763
5671                     ; 2086               pSocket->nNewlines = 0;
5672                     ; 2087               pSocket->nState = STATE_CONNECTED;
5673                     ; 2088               pSocket->nPrevBytes = 0xFFFF;
5674                     ; 2089 	      break;
5676  10ce 2059          	jp	LC020
5677  10d0               L5211:
5678                     ; 2091 	    case 64: // Show help page 2
5678                     ; 2092 	      current_webpage = WEBPAGE_HELP2;
5680  10d0 3504000b      	mov	_current_webpage,#4
5681                     ; 2093               pSocket->pData = g_HtmlPageHelp2;
5683  10d4 90ae1e07      	ldw	y,#L32_g_HtmlPageHelp2
5684  10d8 ef01          	ldw	(1,x),y
5685                     ; 2094               pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
5687  10da 90ae02a1      	ldw	y,#673
5688                     ; 2095               pSocket->nNewlines = 0;
5689                     ; 2096               pSocket->nState = STATE_CONNECTED;
5690                     ; 2097               pSocket->nPrevBytes = 0xFFFF;
5691                     ; 2098 	      break;
5693  10de 2049          	jp	LC020
5694  10e0               L7211:
5695                     ; 2101 	    case 65: // Flash LED for diagnostics
5695                     ; 2102 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
5695                     ; 2103 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
5695                     ; 2104 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
5695                     ; 2105 	      debugflash();
5697  10e0 cd0000        	call	_debugflash
5699                     ; 2106 	      debugflash();
5701  10e3 cd0000        	call	_debugflash
5703                     ; 2107 	      debugflash();
5705  10e6 cd0000        	call	_debugflash
5707                     ; 2111 	      break;
5709  10e9 2049          	jra	L7461
5710  10eb               L1311:
5711                     ; 2114             case 66: // Show statistics page
5711                     ; 2115 	      current_webpage = WEBPAGE_STATS;
5713  10eb 3505000b      	mov	_current_webpage,#5
5714                     ; 2116               pSocket->pData = g_HtmlPageStats;
5716  10ef 90ae20a9      	ldw	y,#L52_g_HtmlPageStats
5717  10f3 ef01          	ldw	(1,x),y
5718                     ; 2117               pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
5720  10f5 90ae0a94      	ldw	y,#2708
5721                     ; 2118               pSocket->nNewlines = 0;
5722                     ; 2119               pSocket->nState = STATE_CONNECTED;
5723                     ; 2120               pSocket->nPrevBytes = 0xFFFF;
5724                     ; 2121 	      break;
5726  10f9 202e          	jp	LC020
5727  10fb               L3311:
5728                     ; 2123             case 67: // Clear statistics
5728                     ; 2124 	      uip_init_stats();
5730  10fb cd0000        	call	_uip_init_stats
5732                     ; 2125 	      current_webpage = WEBPAGE_STATS;
5734  10fe 3505000b      	mov	_current_webpage,#5
5735                     ; 2126               pSocket->pData = g_HtmlPageStats;
5737  1102 1e0e          	ldw	x,(OFST+7,sp)
5738  1104 90ae20a9      	ldw	y,#L52_g_HtmlPageStats
5739  1108 ef01          	ldw	(1,x),y
5740                     ; 2127               pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
5742  110a 90ae0a94      	ldw	y,#2708
5743                     ; 2128               pSocket->nNewlines = 0;
5745                     ; 2129               pSocket->nState = STATE_CONNECTED;
5747  110e               LC021:
5748  110e ef03          	ldw	(3,x),y
5750  1110 6f05          	clr	(5,x)
5752  1112 7f            	clr	(x)
5753                     ; 2130               pSocket->nPrevBytes = 0xFFFF;
5754                     ; 2131 	      break;
5756  1113 2019          	jp	LC019
5757  1115               L5311:
5758                     ; 2134 	    case 91: // Reboot
5758                     ; 2135 	      submit_changes = 2;
5760  1115 35020000      	mov	_submit_changes,#2
5761                     ; 2136 	      break;
5763  1119 2019          	jra	L7461
5764  111b               L7311:
5765                     ; 2138             case 99: // Show simplified IO state page
5765                     ; 2139 	      current_webpage = WEBPAGE_RSTATE;
5767  111b 3506000b      	mov	_current_webpage,#6
5768                     ; 2140               pSocket->pData = g_HtmlPageRstate;
5770  111f 90ae2b3e      	ldw	y,#L72_g_HtmlPageRstate
5771  1123 ef01          	ldw	(1,x),y
5772                     ; 2141               pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
5774  1125 90ae0078      	ldw	y,#120
5775                     ; 2142               pSocket->nNewlines = 0;
5777                     ; 2143               pSocket->nState = STATE_CONNECTED;
5779  1129               LC020:
5780  1129 ef03          	ldw	(3,x),y
5786  112b e705          	ld	(5,x),a
5792  112d f7            	ld	(x),a
5793                     ; 2144               pSocket->nPrevBytes = 0xFFFF;
5795  112e               LC019:
5803  112e 90aeffff      	ldw	y,#65535
5804  1132 ef0a          	ldw	(10,x),y
5805                     ; 2145 	      break;
5807  1134               L7461:
5808                     ; 2156           pSocket->ParseState = PARSE_DELIM;
5810  1134 1e0e          	ldw	x,(OFST+7,sp)
5811  1136 a605          	ld	a,#5
5812  1138 e709          	ld	(9,x),a
5814  113a               L3161:
5815                     ; 2170         if (pSocket->nParseLeft == 0) {
5817  113a 1e0e          	ldw	x,(OFST+7,sp)
5818  113c e606          	ld	a,(6,x)
5819  113e 261c          	jrne	L1061
5820                     ; 2172           pSocket->nState = STATE_SENDHEADER;
5821                     ; 2173           break;
5823  1140 2015          	jp	LC023
5824  1142               L3461:
5825                     ; 2159         else if (pSocket->ParseState == PARSE_DELIM) {
5827  1142 a105          	cp	a,#5
5828  1144 26f4          	jrne	L3161
5829                     ; 2161           pSocket->ParseState = PARSE_DELIM;
5831  1146 a605          	ld	a,#5
5832  1148 e709          	ld	(9,x),a
5833                     ; 2162           pSocket->nParseLeft--;
5835  114a 6a06          	dec	(6,x)
5836                     ; 2163           pBuffer++;
5838  114c 1e08          	ldw	x,(OFST+1,sp)
5839  114e 5c            	incw	x
5840  114f 1f08          	ldw	(OFST+1,sp),x
5841                     ; 2164 	  if (pSocket->nParseLeft == 0) {
5843  1151 1e0e          	ldw	x,(OFST+7,sp)
5844  1153 e606          	ld	a,(6,x)
5845  1155 26e3          	jrne	L3161
5846                     ; 2166             pSocket->nState = STATE_SENDHEADER;
5848  1157               LC023:
5850  1157 a60b          	ld	a,#11
5851  1159 f7            	ld	(x),a
5852                     ; 2167             break;
5854  115a 200b          	jra	L5751
5855  115c               L1061:
5856                     ; 1877       while (nBytes--) {
5858  115c 1e0c          	ldw	x,(OFST+5,sp)
5859  115e 5a            	decw	x
5860  115f 1f0c          	ldw	(OFST+5,sp),x
5861  1161 5c            	incw	x
5862  1162 2703cc0f93    	jrne	L7751
5863  1167               L5751:
5864                     ; 2178     if (pSocket->nState == STATE_SENDHEADER) {
5866  1167 1e0e          	ldw	x,(OFST+7,sp)
5867  1169 f6            	ld	a,(x)
5868  116a a10b          	cp	a,#11
5869  116c 2623          	jrne	L1661
5870                     ; 2179       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
5872  116e ee03          	ldw	x,(3,x)
5873  1170 cd0000        	call	c_uitolx
5875  1173 be02          	ldw	x,c_lreg+2
5876  1175 89            	pushw	x
5877  1176 be00          	ldw	x,c_lreg
5878  1178 89            	pushw	x
5879  1179 ce0000        	ldw	x,_uip_appdata
5880  117c cd0231        	call	L7_CopyHttpHeader
5882  117f 5b04          	addw	sp,#4
5883  1181 89            	pushw	x
5884  1182 ce0000        	ldw	x,_uip_appdata
5885  1185 cd0000        	call	_uip_send
5887  1188 85            	popw	x
5888                     ; 2180       pSocket->nState = STATE_SENDDATA;
5890  1189 1e0e          	ldw	x,(OFST+7,sp)
5891  118b a60c          	ld	a,#12
5892  118d f7            	ld	(x),a
5893                     ; 2181       return;
5895  118e cc0bd7        	jra	L413
5896  1191               L1661:
5897                     ; 2184     if (pSocket->nState == STATE_SENDDATA) {
5899  1191 a10c          	cp	a,#12
5900  1193 26f9          	jrne	L413
5901                     ; 2188       pSocket->nPrevBytes = pSocket->nDataLeft;
5903  1195 9093          	ldw	y,x
5904  1197 90ee03        	ldw	y,(3,y)
5905  119a ef0a          	ldw	(10,x),y
5906                     ; 2189       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5908  119c ce0000        	ldw	x,_uip_conn
5909  119f ee12          	ldw	x,(18,x)
5910  11a1 89            	pushw	x
5911  11a2 1e10          	ldw	x,(OFST+9,sp)
5912  11a4 1c0003        	addw	x,#3
5913  11a7 89            	pushw	x
5914  11a8 1e12          	ldw	x,(OFST+11,sp)
5915  11aa 5c            	incw	x
5916  11ab 89            	pushw	x
5917  11ac ce0000        	ldw	x,_uip_appdata
5918  11af cd02c9        	call	L11_CopyHttpData
5920  11b2 5b06          	addw	sp,#6
5921  11b4 1f01          	ldw	(OFST-6,sp),x
5923                     ; 2190       pSocket->nPrevBytes -= pSocket->nDataLeft;
5925  11b6 1e0e          	ldw	x,(OFST+7,sp)
5926  11b8 e60b          	ld	a,(11,x)
5927  11ba e004          	sub	a,(4,x)
5928  11bc e70b          	ld	(11,x),a
5929  11be e60a          	ld	a,(10,x)
5930  11c0 e203          	sbc	a,(3,x)
5931  11c2 e70a          	ld	(10,x),a
5932                     ; 2192       if (nBufSize == 0) {
5934  11c4 1e01          	ldw	x,(OFST-6,sp)
5935  11c6 262d          	jrne	LC014
5936                     ; 2194         uip_close();
5938  11c8               LC015:
5940  11c8 35100000      	mov	_uip_flags,#16
5942  11cc cc0bd7        	jra	L413
5943                     ; 2198         uip_send(uip_appdata, nBufSize);
5945                     ; 2200       return;
5947  11cf               L3721:
5948                     ; 2204   else if (uip_rexmit()) {
5950  11cf 7204000003cc  	btjf	_uip_flags,#2,L1721
5951                     ; 2205     if (pSocket->nPrevBytes == 0xFFFF) {
5953  11d7 160e          	ldw	y,(OFST+7,sp)
5954  11d9 90ee0a        	ldw	y,(10,y)
5955  11dc 905c          	incw	y
5956  11de 2620          	jrne	L5761
5957                     ; 2207       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
5959  11e0 1e0e          	ldw	x,(OFST+7,sp)
5960  11e2 ee03          	ldw	x,(3,x)
5961  11e4 cd0000        	call	c_uitolx
5963  11e7 be02          	ldw	x,c_lreg+2
5964  11e9 89            	pushw	x
5965  11ea be00          	ldw	x,c_lreg
5966  11ec 89            	pushw	x
5967  11ed ce0000        	ldw	x,_uip_appdata
5968  11f0 cd0231        	call	L7_CopyHttpHeader
5970  11f3 5b04          	addw	sp,#4
5972  11f5               LC014:
5974  11f5 89            	pushw	x
5975  11f6 ce0000        	ldw	x,_uip_appdata
5976  11f9 cd0000        	call	_uip_send
5977  11fc 85            	popw	x
5979  11fd cc0bd7        	jra	L413
5980  1200               L5761:
5981                     ; 2210       pSocket->pData -= pSocket->nPrevBytes;
5983  1200 1e0e          	ldw	x,(OFST+7,sp)
5984  1202 e602          	ld	a,(2,x)
5985  1204 e00b          	sub	a,(11,x)
5986  1206 e702          	ld	(2,x),a
5987  1208 e601          	ld	a,(1,x)
5988  120a e20a          	sbc	a,(10,x)
5989  120c e701          	ld	(1,x),a
5990                     ; 2211       pSocket->nDataLeft += pSocket->nPrevBytes;
5992  120e e604          	ld	a,(4,x)
5993  1210 eb0b          	add	a,(11,x)
5994  1212 e704          	ld	(4,x),a
5995  1214 e603          	ld	a,(3,x)
5996  1216 e90a          	adc	a,(10,x)
5997                     ; 2212       pSocket->nPrevBytes = pSocket->nDataLeft;
5999  1218 9093          	ldw	y,x
6000  121a e703          	ld	(3,x),a
6001  121c 90ee03        	ldw	y,(3,y)
6002  121f ef0a          	ldw	(10,x),y
6003                     ; 2213       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6005  1221 ce0000        	ldw	x,_uip_conn
6006  1224 ee12          	ldw	x,(18,x)
6007  1226 89            	pushw	x
6008  1227 1e10          	ldw	x,(OFST+9,sp)
6009  1229 1c0003        	addw	x,#3
6010  122c 89            	pushw	x
6011  122d 1e12          	ldw	x,(OFST+11,sp)
6012  122f 5c            	incw	x
6013  1230 89            	pushw	x
6014  1231 ce0000        	ldw	x,_uip_appdata
6015  1234 cd02c9        	call	L11_CopyHttpData
6017  1237 5b06          	addw	sp,#6
6018  1239 1f01          	ldw	(OFST-6,sp),x
6020                     ; 2214       pSocket->nPrevBytes -= pSocket->nDataLeft;
6022  123b 1e0e          	ldw	x,(OFST+7,sp)
6023  123d e60b          	ld	a,(11,x)
6024  123f e004          	sub	a,(4,x)
6025  1241 e70b          	ld	(11,x),a
6026  1243 e60a          	ld	a,(10,x)
6027  1245 e203          	sbc	a,(3,x)
6028  1247 e70a          	ld	(10,x),a
6029                     ; 2215       if (nBufSize == 0) {
6031  1249 1e01          	ldw	x,(OFST-6,sp)
6032                     ; 2217         uip_close();
6034  124b 2603cc11c8    	jreq	LC015
6035                     ; 2221         uip_send(uip_appdata, nBufSize);
6037  1250 89            	pushw	x
6038  1251 ce0000        	ldw	x,_uip_appdata
6039  1254 cd0000        	call	_uip_send
6041  1257 85            	popw	x
6042                     ; 2224     return;
6044  1258               L1721:
6045                     ; 2226 }
6047  1258 cc0bd7        	jra	L413
6081                     ; 2229 uint8_t GpioGetPin(uint8_t nGpio)
6081                     ; 2230 {
6082                     	switch	.text
6083  125b               _GpioGetPin:
6085       00000000      OFST:	set	0
6088                     ; 2233   if (nGpio == 0       && (IO_8to1  & (uint8_t)(0x01))) return 1;
6090  125b 4d            	tnz	a
6091  125c 2607          	jrne	L1271
6093  125e 7201000002    	btjf	_IO_8to1,#0,L1271
6096  1263 4c            	inc	a
6099  1264 81            	ret	
6100  1265               L1271:
6101                     ; 2234   else if (nGpio == 1  && (IO_8to1  & (uint8_t)(0x02))) return 1;
6103  1265 a101          	cp	a,#1
6104  1267 2608          	jrne	L5271
6106  1269 7203000003    	btjf	_IO_8to1,#1,L5271
6109  126e a601          	ld	a,#1
6112  1270 81            	ret	
6113  1271               L5271:
6114                     ; 2235   else if (nGpio == 2  && (IO_8to1  & (uint8_t)(0x04))) return 1;
6116  1271 a102          	cp	a,#2
6117  1273 2608          	jrne	L1371
6119  1275 7205000003    	btjf	_IO_8to1,#2,L1371
6122  127a a601          	ld	a,#1
6125  127c 81            	ret	
6126  127d               L1371:
6127                     ; 2236   else if (nGpio == 3  && (IO_8to1  & (uint8_t)(0x08))) return 1;
6129  127d a103          	cp	a,#3
6130  127f 2608          	jrne	L5371
6132  1281 7207000003    	btjf	_IO_8to1,#3,L5371
6135  1286 a601          	ld	a,#1
6138  1288 81            	ret	
6139  1289               L5371:
6140                     ; 2237   else if (nGpio == 4  && (IO_8to1  & (uint8_t)(0x10))) return 1;
6142  1289 a104          	cp	a,#4
6143  128b 2608          	jrne	L1471
6145  128d 7209000003    	btjf	_IO_8to1,#4,L1471
6148  1292 a601          	ld	a,#1
6151  1294 81            	ret	
6152  1295               L1471:
6153                     ; 2238   else if (nGpio == 5  && (IO_8to1  & (uint8_t)(0x20))) return 1;
6155  1295 a105          	cp	a,#5
6156  1297 2608          	jrne	L5471
6158  1299 720b000003    	btjf	_IO_8to1,#5,L5471
6161  129e a601          	ld	a,#1
6164  12a0 81            	ret	
6165  12a1               L5471:
6166                     ; 2239   else if (nGpio == 6  && (IO_8to1  & (uint8_t)(0x40))) return 1;
6168  12a1 a106          	cp	a,#6
6169  12a3 2608          	jrne	L1571
6171  12a5 720d000003    	btjf	_IO_8to1,#6,L1571
6174  12aa a601          	ld	a,#1
6177  12ac 81            	ret	
6178  12ad               L1571:
6179                     ; 2240   else if (nGpio == 7  && (IO_8to1  & (uint8_t)(0x80))) return 1;
6181  12ad a107          	cp	a,#7
6182  12af 2608          	jrne	L5571
6184  12b1 720f000003    	btjf	_IO_8to1,#7,L5571
6187  12b6 a601          	ld	a,#1
6190  12b8 81            	ret	
6191  12b9               L5571:
6192                     ; 2241   else if (nGpio == 8  && (IO_16to9 & (uint8_t)(0x01))) return 1;
6194  12b9 a108          	cp	a,#8
6195  12bb 2608          	jrne	L1671
6197  12bd 7201000003    	btjf	_IO_16to9,#0,L1671
6200  12c2 a601          	ld	a,#1
6203  12c4 81            	ret	
6204  12c5               L1671:
6205                     ; 2242   else if (nGpio == 9  && (IO_16to9 & (uint8_t)(0x02))) return 1;
6207  12c5 a109          	cp	a,#9
6208  12c7 2608          	jrne	L5671
6210  12c9 7203000003    	btjf	_IO_16to9,#1,L5671
6213  12ce a601          	ld	a,#1
6216  12d0 81            	ret	
6217  12d1               L5671:
6218                     ; 2243   else if (nGpio == 10 && (IO_16to9 & (uint8_t)(0x04))) return 1;
6220  12d1 a10a          	cp	a,#10
6221  12d3 2608          	jrne	L1771
6223  12d5 7205000003    	btjf	_IO_16to9,#2,L1771
6226  12da a601          	ld	a,#1
6229  12dc 81            	ret	
6230  12dd               L1771:
6231                     ; 2244   else if (nGpio == 11 && (IO_16to9 & (uint8_t)(0x08))) return 1;
6233  12dd a10b          	cp	a,#11
6234  12df 2608          	jrne	L5771
6236  12e1 7207000003    	btjf	_IO_16to9,#3,L5771
6239  12e6 a601          	ld	a,#1
6242  12e8 81            	ret	
6243  12e9               L5771:
6244                     ; 2245   else if (nGpio == 12 && (IO_16to9 & (uint8_t)(0x10))) return 1;
6246  12e9 a10c          	cp	a,#12
6247  12eb 2608          	jrne	L1002
6249  12ed 7209000003    	btjf	_IO_16to9,#4,L1002
6252  12f2 a601          	ld	a,#1
6255  12f4 81            	ret	
6256  12f5               L1002:
6257                     ; 2246   else if (nGpio == 13 && (IO_16to9 & (uint8_t)(0x20))) return 1;
6259  12f5 a10d          	cp	a,#13
6260  12f7 2608          	jrne	L5002
6262  12f9 720b000003    	btjf	_IO_16to9,#5,L5002
6265  12fe a601          	ld	a,#1
6268  1300 81            	ret	
6269  1301               L5002:
6270                     ; 2247   else if (nGpio == 14 && (IO_16to9 & (uint8_t)(0x40))) return 1;
6272  1301 a10e          	cp	a,#14
6273  1303 2608          	jrne	L1102
6275  1305 720d000003    	btjf	_IO_16to9,#6,L1102
6278  130a a601          	ld	a,#1
6281  130c 81            	ret	
6282  130d               L1102:
6283                     ; 2248   else if (nGpio == 15 && (IO_16to9 & (uint8_t)(0x80))) return 1;
6285  130d a10f          	cp	a,#15
6286  130f 2608          	jrne	L3271
6288  1311 720f000003    	btjf	_IO_16to9,#7,L3271
6291  1316 a601          	ld	a,#1
6294  1318 81            	ret	
6295  1319               L3271:
6296                     ; 2249   return 0;
6298  1319 4f            	clr	a
6301  131a 81            	ret	
6333                     ; 2382 void GpioSetPin(uint8_t nGpio, uint8_t nState)
6333                     ; 2383 {
6334                     	switch	.text
6335  131b               _GpioSetPin:
6339                     ; 2385 }
6342  131b 81            	ret	
6432                     	switch	.const
6433  2bfb               L033:
6434  2bfb 1351          	dc.w	L3302
6435  2bfd 1358          	dc.w	L5302
6436  2bff 135f          	dc.w	L7302
6437  2c01 1366          	dc.w	L1402
6438  2c03 136d          	dc.w	L3402
6439  2c05 1374          	dc.w	L5402
6440  2c07 137b          	dc.w	L7402
6441  2c09 1382          	dc.w	L1502
6442  2c0b 1389          	dc.w	L3502
6443  2c0d 1390          	dc.w	L5502
6444  2c0f 1397          	dc.w	L7502
6445  2c11 139e          	dc.w	L1602
6446                     ; 2389 void SetAddresses(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
6446                     ; 2390 {
6447                     	switch	.text
6448  131c               _SetAddresses:
6450  131c 89            	pushw	x
6451  131d 5207          	subw	sp,#7
6452       00000007      OFST:	set	7
6455                     ; 2403   temp = 0;
6457                     ; 2404   invalid = 0;
6459  131f 0f01          	clr	(OFST-6,sp)
6461                     ; 2407   str[0] = (uint8_t)alpha1;
6463  1321 9f            	ld	a,xl
6464  1322 6b02          	ld	(OFST-5,sp),a
6466                     ; 2408   str[1] = (uint8_t)alpha2;
6468  1324 7b0c          	ld	a,(OFST+5,sp)
6469  1326 6b03          	ld	(OFST-4,sp),a
6471                     ; 2409   str[2] = (uint8_t)alpha3;
6473  1328 7b0d          	ld	a,(OFST+6,sp)
6474  132a 6b04          	ld	(OFST-3,sp),a
6476                     ; 2410   str[3] = 0;
6478  132c 0f05          	clr	(OFST-2,sp)
6480                     ; 2411   temp = atoi(str);
6482  132e 96            	ldw	x,sp
6483  132f 1c0002        	addw	x,#OFST-5
6484  1332 cd0000        	call	_atoi
6486  1335 1f06          	ldw	(OFST-1,sp),x
6488                     ; 2412   if (temp > 255) invalid = 1; // If an invalid entry set indicator
6490  1337 a30100        	cpw	x,#256
6491  133a 2504          	jrult	L7112
6494  133c a601          	ld	a,#1
6495  133e 6b01          	ld	(OFST-6,sp),a
6497  1340               L7112:
6498                     ; 2414   if (invalid == 0) { // Make change only if valid entry
6500  1340 7b01          	ld	a,(OFST-6,sp)
6501  1342 265f          	jrne	L1212
6502                     ; 2415     switch(itemnum)
6504  1344 7b08          	ld	a,(OFST+1,sp)
6506                     ; 2429     default: break;
6507  1346 a10c          	cp	a,#12
6508  1348 2459          	jruge	L1212
6509  134a 5f            	clrw	x
6510  134b 97            	ld	xl,a
6511  134c 58            	sllw	x
6512  134d de2bfb        	ldw	x,(L033,x)
6513  1350 fc            	jp	(x)
6514  1351               L3302:
6515                     ; 2417     case 0:  Pending_hostaddr4 = (uint8_t)temp; break;
6517  1351 7b07          	ld	a,(OFST+0,sp)
6518  1353 c70000        	ld	_Pending_hostaddr4,a
6521  1356 204b          	jra	L1212
6522  1358               L5302:
6523                     ; 2418     case 1:  Pending_hostaddr3 = (uint8_t)temp; break;
6525  1358 7b07          	ld	a,(OFST+0,sp)
6526  135a c70000        	ld	_Pending_hostaddr3,a
6529  135d 2044          	jra	L1212
6530  135f               L7302:
6531                     ; 2419     case 2:  Pending_hostaddr2 = (uint8_t)temp; break;
6533  135f 7b07          	ld	a,(OFST+0,sp)
6534  1361 c70000        	ld	_Pending_hostaddr2,a
6537  1364 203d          	jra	L1212
6538  1366               L1402:
6539                     ; 2420     case 3:  Pending_hostaddr1 = (uint8_t)temp; break;
6541  1366 7b07          	ld	a,(OFST+0,sp)
6542  1368 c70000        	ld	_Pending_hostaddr1,a
6545  136b 2036          	jra	L1212
6546  136d               L3402:
6547                     ; 2421     case 4:  Pending_draddr4 = (uint8_t)temp; break;
6549  136d 7b07          	ld	a,(OFST+0,sp)
6550  136f c70000        	ld	_Pending_draddr4,a
6553  1372 202f          	jra	L1212
6554  1374               L5402:
6555                     ; 2422     case 5:  Pending_draddr3 = (uint8_t)temp; break;
6557  1374 7b07          	ld	a,(OFST+0,sp)
6558  1376 c70000        	ld	_Pending_draddr3,a
6561  1379 2028          	jra	L1212
6562  137b               L7402:
6563                     ; 2423     case 6:  Pending_draddr2 = (uint8_t)temp; break;
6565  137b 7b07          	ld	a,(OFST+0,sp)
6566  137d c70000        	ld	_Pending_draddr2,a
6569  1380 2021          	jra	L1212
6570  1382               L1502:
6571                     ; 2424     case 7:  Pending_draddr1 = (uint8_t)temp; break;
6573  1382 7b07          	ld	a,(OFST+0,sp)
6574  1384 c70000        	ld	_Pending_draddr1,a
6577  1387 201a          	jra	L1212
6578  1389               L3502:
6579                     ; 2425     case 8:  Pending_netmask4 = (uint8_t)temp; break;
6581  1389 7b07          	ld	a,(OFST+0,sp)
6582  138b c70000        	ld	_Pending_netmask4,a
6585  138e 2013          	jra	L1212
6586  1390               L5502:
6587                     ; 2426     case 9:  Pending_netmask3 = (uint8_t)temp; break;
6589  1390 7b07          	ld	a,(OFST+0,sp)
6590  1392 c70000        	ld	_Pending_netmask3,a
6593  1395 200c          	jra	L1212
6594  1397               L7502:
6595                     ; 2427     case 10: Pending_netmask2 = (uint8_t)temp; break;
6597  1397 7b07          	ld	a,(OFST+0,sp)
6598  1399 c70000        	ld	_Pending_netmask2,a
6601  139c 2005          	jra	L1212
6602  139e               L1602:
6603                     ; 2428     case 11: Pending_netmask1 = (uint8_t)temp; break;
6605  139e 7b07          	ld	a,(OFST+0,sp)
6606  13a0 c70000        	ld	_Pending_netmask1,a
6609                     ; 2429     default: break;
6611  13a3               L1212:
6612                     ; 2432 }
6615  13a3 5b09          	addw	sp,#9
6616  13a5 81            	ret	
6709                     ; 2435 void SetPort(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3, uint8_t alpha4, uint8_t alpha5)
6709                     ; 2436 {
6710                     	switch	.text
6711  13a6               _SetPort:
6713  13a6 89            	pushw	x
6714  13a7 5209          	subw	sp,#9
6715       00000009      OFST:	set	9
6718                     ; 2449   temp = 0;
6720  13a9 5f            	clrw	x
6721  13aa 1f01          	ldw	(OFST-8,sp),x
6723                     ; 2450   invalid = 0;
6725  13ac 0f03          	clr	(OFST-6,sp)
6727                     ; 2453   if (alpha1 > '6') invalid = 1;
6729  13ae 7b0b          	ld	a,(OFST+2,sp)
6730  13b0 a137          	cp	a,#55
6731  13b2 2506          	jrult	L5612
6734  13b4 a601          	ld	a,#1
6735  13b6 6b03          	ld	(OFST-6,sp),a
6738  13b8 201d          	jra	L7612
6739  13ba               L5612:
6740                     ; 2455     str[0] = (uint8_t)alpha1;
6742  13ba 6b04          	ld	(OFST-5,sp),a
6744                     ; 2456     str[1] = (uint8_t)alpha2;
6746  13bc 7b0e          	ld	a,(OFST+5,sp)
6747  13be 6b05          	ld	(OFST-4,sp),a
6749                     ; 2457     str[2] = (uint8_t)alpha3;
6751  13c0 7b0f          	ld	a,(OFST+6,sp)
6752  13c2 6b06          	ld	(OFST-3,sp),a
6754                     ; 2458     str[3] = (uint8_t)alpha4;
6756  13c4 7b10          	ld	a,(OFST+7,sp)
6757  13c6 6b07          	ld	(OFST-2,sp),a
6759                     ; 2459     str[4] = (uint8_t)alpha5;
6761  13c8 7b11          	ld	a,(OFST+8,sp)
6762  13ca 6b08          	ld	(OFST-1,sp),a
6764                     ; 2460     str[5] = 0;
6766  13cc 0f09          	clr	(OFST+0,sp)
6768                     ; 2461     temp = atoi(str);
6770  13ce 96            	ldw	x,sp
6771  13cf 1c0004        	addw	x,#OFST-5
6772  13d2 cd0000        	call	_atoi
6774  13d5 1f01          	ldw	(OFST-8,sp),x
6776  13d7               L7612:
6777                     ; 2464   if (temp < 10) invalid = 1;
6779  13d7 a3000a        	cpw	x,#10
6780  13da 2404          	jruge	L1712
6783  13dc a601          	ld	a,#1
6784  13de 6b03          	ld	(OFST-6,sp),a
6786  13e0               L1712:
6787                     ; 2466   if (invalid == 0) { // Make change only if valid entry
6789  13e0 7b03          	ld	a,(OFST-6,sp)
6790  13e2 2603          	jrne	L3712
6791                     ; 2467     Pending_port = (uint16_t)temp;
6793  13e4 cf0000        	ldw	_Pending_port,x
6794  13e7               L3712:
6795                     ; 2469 }
6798  13e7 5b0b          	addw	sp,#11
6799  13e9 81            	ret	
6865                     ; 2472 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
6865                     ; 2473 {
6866                     	switch	.text
6867  13ea               _SetMAC:
6869  13ea 89            	pushw	x
6870  13eb 5203          	subw	sp,#3
6871       00000003      OFST:	set	3
6874                     ; 2485   temp = 0;
6876                     ; 2486   invalid = 0;
6878  13ed 0f01          	clr	(OFST-2,sp)
6880                     ; 2489   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
6882  13ef 9f            	ld	a,xl
6883  13f0 a130          	cp	a,#48
6884  13f2 250b          	jrult	L7322
6886  13f4 9f            	ld	a,xl
6887  13f5 a13a          	cp	a,#58
6888  13f7 2406          	jruge	L7322
6891  13f9 7b05          	ld	a,(OFST+2,sp)
6892  13fb a030          	sub	a,#48
6894  13fd 200c          	jp	LC028
6895  13ff               L7322:
6896                     ; 2490   else if (alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
6898  13ff 7b05          	ld	a,(OFST+2,sp)
6899  1401 a161          	cp	a,#97
6900  1403 250a          	jrult	L3422
6902  1405 a167          	cp	a,#103
6903  1407 2406          	jruge	L3422
6906  1409 a057          	sub	a,#87
6907  140b               LC028:
6908  140b 6b05          	ld	(OFST+2,sp),a
6910  140d 2004          	jra	L1422
6911  140f               L3422:
6912                     ; 2491   else invalid = 1; // If an invalid entry set indicator
6914  140f a601          	ld	a,#1
6915  1411 6b01          	ld	(OFST-2,sp),a
6917  1413               L1422:
6918                     ; 2493   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
6920  1413 7b08          	ld	a,(OFST+5,sp)
6921  1415 a130          	cp	a,#48
6922  1417 2508          	jrult	L7422
6924  1419 a13a          	cp	a,#58
6925  141b 2404          	jruge	L7422
6928  141d a030          	sub	a,#48
6930  141f 200a          	jp	LC029
6931  1421               L7422:
6932                     ; 2494   else if (alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
6934  1421 a161          	cp	a,#97
6935  1423 250a          	jrult	L3522
6937  1425 a167          	cp	a,#103
6938  1427 2406          	jruge	L3522
6941  1429 a057          	sub	a,#87
6942  142b               LC029:
6943  142b 6b08          	ld	(OFST+5,sp),a
6945  142d 2004          	jra	L1522
6946  142f               L3522:
6947                     ; 2495   else invalid = 1; // If an invalid entry set indicator
6949  142f a601          	ld	a,#1
6950  1431 6b01          	ld	(OFST-2,sp),a
6952  1433               L1522:
6953                     ; 2497   if (invalid == 0) { // Change value only if valid entry
6955  1433 7b01          	ld	a,(OFST-2,sp)
6956  1435 264a          	jrne	L7522
6957                     ; 2498     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
6959  1437 7b05          	ld	a,(OFST+2,sp)
6960  1439 97            	ld	xl,a
6961  143a a610          	ld	a,#16
6962  143c 42            	mul	x,a
6963  143d 01            	rrwa	x,a
6964  143e 1b08          	add	a,(OFST+5,sp)
6965  1440 5f            	clrw	x
6966  1441 97            	ld	xl,a
6967  1442 1f02          	ldw	(OFST-1,sp),x
6969                     ; 2499     switch(itemnum)
6971  1444 7b04          	ld	a,(OFST+1,sp)
6973                     ; 2507     default: break;
6974  1446 2711          	jreq	L5712
6975  1448 4a            	dec	a
6976  1449 2715          	jreq	L7712
6977  144b 4a            	dec	a
6978  144c 2719          	jreq	L1022
6979  144e 4a            	dec	a
6980  144f 271d          	jreq	L3022
6981  1451 4a            	dec	a
6982  1452 2721          	jreq	L5022
6983  1454 4a            	dec	a
6984  1455 2725          	jreq	L7022
6985  1457 2028          	jra	L7522
6986  1459               L5712:
6987                     ; 2501     case 0: Pending_uip_ethaddr1 = (uint8_t)temp; break;
6989  1459 7b03          	ld	a,(OFST+0,sp)
6990  145b c70000        	ld	_Pending_uip_ethaddr1,a
6993  145e 2021          	jra	L7522
6994  1460               L7712:
6995                     ; 2502     case 1: Pending_uip_ethaddr2 = (uint8_t)temp; break;
6997  1460 7b03          	ld	a,(OFST+0,sp)
6998  1462 c70000        	ld	_Pending_uip_ethaddr2,a
7001  1465 201a          	jra	L7522
7002  1467               L1022:
7003                     ; 2503     case 2: Pending_uip_ethaddr3 = (uint8_t)temp; break;
7005  1467 7b03          	ld	a,(OFST+0,sp)
7006  1469 c70000        	ld	_Pending_uip_ethaddr3,a
7009  146c 2013          	jra	L7522
7010  146e               L3022:
7011                     ; 2504     case 3: Pending_uip_ethaddr4 = (uint8_t)temp; break;
7013  146e 7b03          	ld	a,(OFST+0,sp)
7014  1470 c70000        	ld	_Pending_uip_ethaddr4,a
7017  1473 200c          	jra	L7522
7018  1475               L5022:
7019                     ; 2505     case 4: Pending_uip_ethaddr5 = (uint8_t)temp; break;
7021  1475 7b03          	ld	a,(OFST+0,sp)
7022  1477 c70000        	ld	_Pending_uip_ethaddr5,a
7025  147a 2005          	jra	L7522
7026  147c               L7022:
7027                     ; 2506     case 5: Pending_uip_ethaddr6 = (uint8_t)temp; break;
7029  147c 7b03          	ld	a,(OFST+0,sp)
7030  147e c70000        	ld	_Pending_uip_ethaddr6,a
7033                     ; 2507     default: break;
7035  1481               L7522:
7036                     ; 2510 }
7039  1481 5b05          	addw	sp,#5
7040  1483 81            	ret	
7142                     	switch	.bss
7143  0000               _OctetArray:
7144  0000 000000000000  	ds.b	11
7145                     	xdef	_OctetArray
7146                     	xref	_submit_changes
7147                     	xref	_ex_stored_devicename
7148                     	xref	_uip_ethaddr6
7149                     	xref	_uip_ethaddr5
7150                     	xref	_uip_ethaddr4
7151                     	xref	_uip_ethaddr3
7152                     	xref	_uip_ethaddr2
7153                     	xref	_uip_ethaddr1
7154                     	xref	_ex_stored_port
7155                     	xref	_ex_stored_netmask1
7156                     	xref	_ex_stored_netmask2
7157                     	xref	_ex_stored_netmask3
7158                     	xref	_ex_stored_netmask4
7159                     	xref	_ex_stored_draddr1
7160                     	xref	_ex_stored_draddr2
7161                     	xref	_ex_stored_draddr3
7162                     	xref	_ex_stored_draddr4
7163                     	xref	_ex_stored_hostaddr1
7164                     	xref	_ex_stored_hostaddr2
7165                     	xref	_ex_stored_hostaddr3
7166                     	xref	_ex_stored_hostaddr4
7167                     	xref	_Pending_uip_ethaddr6
7168                     	xref	_Pending_uip_ethaddr5
7169                     	xref	_Pending_uip_ethaddr4
7170                     	xref	_Pending_uip_ethaddr3
7171                     	xref	_Pending_uip_ethaddr2
7172                     	xref	_Pending_uip_ethaddr1
7173                     	xref	_Pending_port
7174                     	xref	_Pending_netmask1
7175                     	xref	_Pending_netmask2
7176                     	xref	_Pending_netmask3
7177                     	xref	_Pending_netmask4
7178                     	xref	_Pending_draddr1
7179                     	xref	_Pending_draddr2
7180                     	xref	_Pending_draddr3
7181                     	xref	_Pending_draddr4
7182                     	xref	_Pending_hostaddr1
7183                     	xref	_Pending_hostaddr2
7184                     	xref	_Pending_hostaddr3
7185                     	xref	_Pending_hostaddr4
7186                     	xref	_invert_output
7187                     	xref	_IO_8to1
7188                     	xref	_IO_16to9
7189                     	xref	_Port_Httpd
7190  000b               _current_webpage:
7191  000b 00            	ds.b	1
7192                     	xdef	_current_webpage
7193                     	xref	_atoi
7194                     	xref	_debugflash
7195                     	xref	_uip_flags
7196                     	xref	_uip_stat
7197                     	xref	_uip_conn
7198                     	xref	_uip_appdata
7199                     	xref	_htons
7200                     	xref	_uip_send
7201                     	xref	_uip_listen
7202                     	xref	_uip_init_stats
7203                     	xdef	_SetMAC
7204                     	xdef	_SetPort
7205                     	xdef	_SetAddresses
7206                     	xdef	_GpioSetPin
7207                     	xdef	_GpioGetPin
7208                     	xdef	_HttpDCall
7209                     	xdef	_HttpDInit
7210                     	xdef	_reverse
7211                     	xdef	_emb_itoa
7212                     	xdef	_two_alpha_to_uint
7213                     	xdef	_three_alpha_to_uint
7214                     	switch	.const
7215  2c13               L714:
7216  2c13 436f6e6e6563  	dc.b	"Connection:close",13
7217  2c24 0a00          	dc.b	10,0
7218  2c26               L514:
7219  2c26 436f6e74656e  	dc.b	"Content-Type:text/"
7220  2c38 68746d6c0d    	dc.b	"html",13
7221  2c3d 0a00          	dc.b	10,0
7222  2c3f               L314:
7223  2c3f 436f6e74656e  	dc.b	"Content-Length:",0
7224  2c4f               L114:
7225  2c4f 0d0a00        	dc.b	13,10,0
7226  2c52               L704:
7227  2c52 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
7228                     	xref.b	c_lreg
7229                     	xref.b	c_x
7230                     	xref.b	c_y
7250                     	xref	c_uitolx
7251                     	xref	c_ludv
7252                     	xref	c_lumd
7253                     	xref	c_rtol
7254                     	xref	c_ltor
7255                     	xref	c_lzmp
7256                     	end
