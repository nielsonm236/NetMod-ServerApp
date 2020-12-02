   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  18                     .const:	section	.text
  19  0000               L11_checked:
  20  0000 636865636b65  	dc.b	"checked",0
  21  0008               L31_g_HtmlPageIOControl:
  22  0008 257930342579  	dc.b	"%y04%y05%y06<title"
  23  001a 3e494f20436f  	dc.b	">IO Control</title"
  24  002c 3e3c2f686561  	dc.b	"></head><body><h1>"
  25  003e 494f20436f6e  	dc.b	"IO Control</h1><fo"
  26  0050 726d206d6574  	dc.b	"rm method='POST' a"
  27  0062 6374696f6e3d  	dc.b	"ction='/'><table><"
  28  0074 74723e3c7464  	dc.b	"tr><td class='t1'>"
  29  0086 4e616d653a3c  	dc.b	"Name:</td><td clas"
  30  0098 733d27743227  	dc.b	"s='t2'>%a00</td></"
  31  00aa 74723e3c2f74  	dc.b	"tr></table><table>"
  32  00bc 3c74723e3c74  	dc.b	"<tr><td class='t1'"
  33  00ce 3e3c2f74643e  	dc.b	"></td><td class='t"
  34  00e0 33273e3c2f74  	dc.b	"3'></td><td class="
  35  00f2 277431273e53  	dc.b	"'t1'>SET</td></tr>"
  36  0104 3c7472        	dc.b	"<tr"
  37  0107 3e3c74642063  	dc.b	"><td class='t1'>Ou"
  38  0119 747075743031  	dc.b	"tput01</td><td cla"
  39  012b 73733d277325  	dc.b	"ss='s%i00'></td><t"
  40  013d 6420636c6173  	dc.b	"d class='t1'><inpu"
  41  014f 742074797065  	dc.b	"t type='radio' id="
  42  0161 2730316f6e27  	dc.b	"'01on' name='o00' "
  43  0173 76616c75653d  	dc.b	"value='1' %o00><la"
  44  0185 62656c20666f  	dc.b	"bel for='01on'>ON<"
  45  0197 2f6c6162656c  	dc.b	"/label><input type"
  46  01a9 3d2772616469  	dc.b	"='radio' id='01off"
  47  01bb 27206e616d65  	dc.b	"' name='o00' value"
  48  01cd 3d2730272025  	dc.b	"='0' %p00><label f"
  49  01df 6f723d273031  	dc.b	"or='01off'>OFF</la"
  50  01f1 62656c3e3c2f  	dc.b	"bel></td></tr><tr>"
  51  0203 3c7464        	dc.b	"<td"
  52  0206 20636c617373  	dc.b	" class='t1'>Output"
  53  0218 30323c2f7464  	dc.b	"02</td><td class='"
  54  022a 732569303127  	dc.b	"s%i01'></td><td cl"
  55  023c 6173733d2774  	dc.b	"ass='t1'><input ty"
  56  024e 70653d277261  	dc.b	"pe='radio' id='02o"
  57  0260 6e27206e616d  	dc.b	"n' name='o01' valu"
  58  0272 653d27312720  	dc.b	"e='1' %o01><label "
  59  0284 666f723d2730  	dc.b	"for='02on'>ON</lab"
  60  0296 656c3e3c696e  	dc.b	"el><input type='ra"
  61  02a8 64696f272069  	dc.b	"dio' id='02off' na"
  62  02ba 6d653d276f30  	dc.b	"me='o01' value='0'"
  63  02cc 20257030313e  	dc.b	" %p01><label for='"
  64  02de 30326f666627  	dc.b	"02off'>OFF</label>"
  65  02f0 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
  66  0302 636c61        	dc.b	"cla"
  67  0305 73733d277431  	dc.b	"ss='t1'>Output03</"
  68  0317 74643e3c7464  	dc.b	"td><td class='s%i0"
  69  0329 32273e3c2f74  	dc.b	"2'></td><td class="
  70  033b 277431273e3c  	dc.b	"'t1'><input type='"
  71  034d 726164696f27  	dc.b	"radio' id='03on' n"
  72  035f 616d653d276f  	dc.b	"ame='o02' value='1"
  73  0371 2720256f3032  	dc.b	"' %o02><label for="
  74  0383 2730336f6e27  	dc.b	"'03on'>ON</label><"
  75  0395 696e70757420  	dc.b	"input type='radio'"
  76  03a7 2069643d2730  	dc.b	" id='03off' name='"
  77  03b9 6f3032272076  	dc.b	"o02' value='0' %p0"
  78  03cb 323e3c6c6162  	dc.b	"2><label for='03of"
  79  03dd 66273e4f4646  	dc.b	"f'>OFF</label></td"
  80  03ef 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
  81  0401 733d27        	dc.b	"s='"
  82  0404 7431273e4f75  	dc.b	"t1'>Output04</td><"
  83  0416 746420636c61  	dc.b	"td class='s%i03'><"
  84  0428 2f74643e3c74  	dc.b	"/td><td class='t1'"
  85  043a 3e3c696e7075  	dc.b	"><input type='radi"
  86  044c 6f272069643d  	dc.b	"o' id='04on' name="
  87  045e 276f30332720  	dc.b	"'o03' value='1' %o"
  88  0470 30333e3c6c61  	dc.b	"03><label for='04o"
  89  0482 6e273e4f4e3c  	dc.b	"n'>ON</label><inpu"
  90  0494 742074797065  	dc.b	"t type='radio' id="
  91  04a6 2730346f6666  	dc.b	"'04off' name='o03'"
  92  04b8 2076616c7565  	dc.b	" value='0' %p03><l"
  93  04ca 6162656c2066  	dc.b	"abel for='04off'>O"
  94  04dc 46463c2f6c61  	dc.b	"FF</label></td></t"
  95  04ee 723e3c74723e  	dc.b	"r><tr><td class='t"
  96  0500 31273e        	dc.b	"1'>"
  97  0503 4f7574707574  	dc.b	"Output05</td><td c"
  98  0515 6c6173733d27  	dc.b	"lass='s%i04'></td>"
  99  0527 3c746420636c  	dc.b	"<td class='t1'><in"
 100  0539 707574207479  	dc.b	"put type='radio' i"
 101  054b 643d2730356f  	dc.b	"d='05on' name='o04"
 102  055d 272076616c75  	dc.b	"' value='1' %o04><"
 103  056f 6c6162656c20  	dc.b	"label for='05on'>O"
 104  0581 4e3c2f6c6162  	dc.b	"N</label><input ty"
 105  0593 70653d277261  	dc.b	"pe='radio' id='05o"
 106  05a5 666627206e61  	dc.b	"ff' name='o04' val"
 107  05b7 75653d273027  	dc.b	"ue='0' %p04><label"
 108  05c9 20666f723d27  	dc.b	" for='05off'>OFF</"
 109  05db 6c6162656c3e  	dc.b	"label></td></tr><t"
 110  05ed 723e3c746420  	dc.b	"r><td class='t1'>O"
 111  05ff 757470        	dc.b	"utp"
 112  0602 757430363c2f  	dc.b	"ut06</td><td class"
 113  0614 3d2773256930  	dc.b	"='s%i05'></td><td "
 114  0626 636c6173733d  	dc.b	"class='t1'><input "
 115  0638 747970653d27  	dc.b	"type='radio' id='0"
 116  064a 366f6e27206e  	dc.b	"6on' name='o05' va"
 117  065c 6c75653d2731  	dc.b	"lue='1' %o05><labe"
 118  066e 6c20666f723d  	dc.b	"l for='06on'>ON</l"
 119  0680 6162656c3e3c  	dc.b	"abel><input type='"
 120  0692 726164696f27  	dc.b	"radio' id='06off' "
 121  06a4 6e616d653d27  	dc.b	"name='o05' value='"
 122  06b6 302720257030  	dc.b	"0' %p05><label for"
 123  06c8 3d2730366f66  	dc.b	"='06off'>OFF</labe"
 124  06da 6c3e3c2f7464  	dc.b	"l></td></tr><tr><t"
 125  06ec 6420636c6173  	dc.b	"d class='t1'>Outpu"
 126  06fe 743037        	dc.b	"t07"
 127  0701 3c2f74643e3c  	dc.b	"</td><td class='s%"
 128  0713 693036273e3c  	dc.b	"i06'></td><td clas"
 129  0725 733d27743127  	dc.b	"s='t1'><input type"
 130  0737 3d2772616469  	dc.b	"='radio' id='07on'"
 131  0749 206e616d653d  	dc.b	" name='o06' value="
 132  075b 27312720256f  	dc.b	"'1' %o06><label fo"
 133  076d 723d2730376f  	dc.b	"r='07on'>ON</label"
 134  077f 3e3c696e7075  	dc.b	"><input type='radi"
 135  0791 6f272069643d  	dc.b	"o' id='07off' name"
 136  07a3 3d276f303627  	dc.b	"='o06' value='0' %"
 137  07b5 7030363e3c6c  	dc.b	"p06><label for='07"
 138  07c7 6f6666273e4f  	dc.b	"off'>OFF</label></"
 139  07d9 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
 140  07eb 6173733d2774  	dc.b	"ass='t1'>Output08<"
 141  07fd 2f7464        	dc.b	"/td"
 142  0800 3e3c74642063  	dc.b	"><td class='s%i07'"
 143  0812 3e3c2f74643e  	dc.b	"></td><td class='t"
 144  0824 31273e3c696e  	dc.b	"1'><input type='ra"
 145  0836 64696f272069  	dc.b	"dio' id='08on' nam"
 146  0848 653d276f3037  	dc.b	"e='o07' value='1' "
 147  085a 256f30373e3c  	dc.b	"%o07><label for='0"
 148  086c 386f6e273e4f  	dc.b	"8on'>ON</label><in"
 149  087e 707574207479  	dc.b	"put type='radio' i"
 150  0890 643d2730386f  	dc.b	"d='08off' name='o0"
 151  08a2 37272076616c  	dc.b	"7' value='0' %p07>"
 152  08b4 3c6c6162656c  	dc.b	"<label for='08off'"
 153  08c6 3e4f46463c2f  	dc.b	">OFF</label></td><"
 154  08d8 2f74723e3c2f  	dc.b	"/tr></table><table"
 155  08ea 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 156  08fc 273e49        	dc.b	"'>I"
 157  08ff 6e7075743031  	dc.b	"nput01</td><td cla"
 158  0911 73733d277325  	dc.b	"ss='s%i08'></td></"
 159  0923 74723e3c7472  	dc.b	"tr><tr><td class='"
 160  0935 7431273e496e  	dc.b	"t1'>Input02</td><t"
 161  0947 6420636c6173  	dc.b	"d class='s%i09'></"
 162  0959 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
 163  096b 6173733d2774  	dc.b	"ass='t1'>Input03</"
 164  097d 74643e3c7464  	dc.b	"td><td class='s%i1"
 165  098f 30273e3c2f74  	dc.b	"0'></td></tr><tr><"
 166  09a1 746420636c61  	dc.b	"td class='t1'>Inpu"
 167  09b3 7430343c2f74  	dc.b	"t04</td><td class="
 168  09c5 277325693131  	dc.b	"'s%i11'></td></tr>"
 169  09d7 3c74723e3c74  	dc.b	"<tr><td class='t1'"
 170  09e9 3e496e707574  	dc.b	">Input05</td><td c"
 171  09fb 6c6173        	dc.b	"las"
 172  09fe 733d27732569  	dc.b	"s='s%i12'></td></t"
 173  0a10 723e3c74723e  	dc.b	"r><tr><td class='t"
 174  0a22 31273e496e70  	dc.b	"1'>Input06</td><td"
 175  0a34 20636c617373  	dc.b	" class='s%i13'></t"
 176  0a46 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
 177  0a58 73733d277431  	dc.b	"ss='t1'>Input07</t"
 178  0a6a 643e3c746420  	dc.b	"d><td class='s%i14"
 179  0a7c 273e3c2f7464  	dc.b	"'></td></tr><tr><t"
 180  0a8e 6420636c6173  	dc.b	"d class='t1'>Input"
 181  0aa0 30383c2f7464  	dc.b	"08</td><td class='"
 182  0ab2 732569313527  	dc.b	"s%i15'></td></tr><"
 183  0ac4 2f7461626c65  	dc.b	"/table><input type"
 184  0ad6 3d2768696464  	dc.b	"='hidden' name='z0"
 185  0ae8 30272076616c  	dc.b	"0' value='0'><butt"
 186  0afa 6f6e20        	dc.b	"on "
 187  0afd 747970653d27  	dc.b	"type='submit' titl"
 188  0b0f 653d27536176  	dc.b	"e='Saves your chan"
 189  0b21 676573207468  	dc.b	"ges then restarts "
 190  0b33 746865204e65  	dc.b	"the Network Module"
 191  0b45 273e53617665  	dc.b	"'>Save</button><bu"
 192  0b57 74746f6e2074  	dc.b	"tton type='reset' "
 193  0b69 7469746c653d  	dc.b	"title='Un-does any"
 194  0b7b 206368616e67  	dc.b	" changes that have"
 195  0b8d 206e6f742062  	dc.b	" not been saved'>U"
 196  0b9f 6e646f20416c  	dc.b	"ndo All</button></"
 197  0bb1 666f726d3e25  	dc.b	"form>%y03/60%y02Re"
 198  0bc3 66726573683c  	dc.b	"fresh</button></fo"
 199  0bd5 726d3e257930  	dc.b	"rm>%y03/61%y02Conf"
 200  0be7 696775726174  	dc.b	"iguration</button>"
 201  0bf9 3c2f66        	dc.b	"</f"
 202  0bfc 6f726d3e3c2f  	dc.b	"orm></body></html>",0
 203  0c0f               L51_g_HtmlPageConfiguration:
 204  0c0f 257930342579  	dc.b	"%y04%y05%y06<title"
 205  0c21 3e436f6e6669  	dc.b	">Configuration</ti"
 206  0c33 746c653e3c2f  	dc.b	"tle></head><body><"
 207  0c45 68313e436f6e  	dc.b	"h1>Configuration</"
 208  0c57 68313e3c666f  	dc.b	"h1><form method='P"
 209  0c69 4f5354272061  	dc.b	"OST' action='/'><t"
 210  0c7b 61626c653e3c  	dc.b	"able><tr><td class"
 211  0c8d 3d277431273e  	dc.b	"='t1'>Name:</td><t"
 212  0c9f 643e3c696e70  	dc.b	"d><input name='a00"
 213  0cb1 2720636c6173  	dc.b	"' class='t2' value"
 214  0cc3 3d2725613030  	dc.b	"='%a00' pattern='["
 215  0cd5 302d39612d7a  	dc.b	"0-9a-zA-Z-_*.]{1,1"
 216  0ce7 397d27207265  	dc.b	"9}' required title"
 217  0cf9 3d273120746f  	dc.b	"='1 to 19 letters,"
 218  0d0b 206e75        	dc.b	" nu"
 219  0d0e 6d626572732c  	dc.b	"mbers, and -_*. no"
 220  0d20 207370616365  	dc.b	" spaces' maxlength"
 221  0d32 3d273139273e  	dc.b	"='19'></td></tr></"
 222  0d44 7461626c653e  	dc.b	"table><table><tr><"
 223  0d56 746420636c61  	dc.b	"td class='t1'>Conf"
 224  0d68 69673c2f7464  	dc.b	"ig</td><td><input "
 225  0d7a 6e616d653d27  	dc.b	"name='g00' class='"
 226  0d8c 743527207661  	dc.b	"t5' value='%g00' p"
 227  0d9e 61747465726e  	dc.b	"attern='[0-9a-zA-Z"
 228  0db0 5d7b367d2720  	dc.b	"]{6}' title='6 cha"
 229  0dc2 726163746572  	dc.b	"racters required. "
 230  0dd4 53656520446f  	dc.b	"See Documentation'"
 231  0de6 206d61786c65  	dc.b	" maxlength='6'></t"
 232  0df8 643e3c2f7472  	dc.b	"d></tr></table><p>"
 233  0e0a 3c2f70        	dc.b	"</p"
 234  0e0d 3e3c7461626c  	dc.b	"><table><tr><td cl"
 235  0e1f 6173733d2774  	dc.b	"ass='t1'>IP Addres"
 236  0e31 733c2f74643e  	dc.b	"s</td><td><input n"
 237  0e43 616d653d2762  	dc.b	"ame='b00' class='t"
 238  0e55 36272076616c  	dc.b	"6' value='%b00' %y"
 239  0e67 30303c74643e  	dc.b	"00<td><input name="
 240  0e79 276230312720  	dc.b	"'b01' class='t6' v"
 241  0e8b 616c75653d27  	dc.b	"alue='%b01' %y00<t"
 242  0e9d 643e3c696e70  	dc.b	"d><input name='b02"
 243  0eaf 2720636c6173  	dc.b	"' class='t6' value"
 244  0ec1 3d2725623032  	dc.b	"='%b02' %y00<td><i"
 245  0ed3 6e707574206e  	dc.b	"nput name='b03' cl"
 246  0ee5 6173733d2774  	dc.b	"ass='t6' value='%b"
 247  0ef7 303327202579  	dc.b	"03' %y00</tr><tr><"
 248  0f09 746420        	dc.b	"td "
 249  0f0c 636c6173733d  	dc.b	"class='t1'>Gateway"
 250  0f1e 3c2f74643e3c  	dc.b	"</td><td><input na"
 251  0f30 6d653d276230  	dc.b	"me='b04' class='t6"
 252  0f42 272076616c75  	dc.b	"' value='%b04' %y0"
 253  0f54 303c74643e3c  	dc.b	"0<td><input name='"
 254  0f66 623035272063  	dc.b	"b05' class='t6' va"
 255  0f78 6c75653d2725  	dc.b	"lue='%b05' %y00<td"
 256  0f8a 3e3c696e7075  	dc.b	"><input name='b06'"
 257  0f9c 20636c617373  	dc.b	" class='t6' value="
 258  0fae 272562303627  	dc.b	"'%b06' %y00<td><in"
 259  0fc0 707574206e61  	dc.b	"put name='b07' cla"
 260  0fd2 73733d277436  	dc.b	"ss='t6' value='%b0"
 261  0fe4 372720257930  	dc.b	"7' %y00</tr><tr><t"
 262  0ff6 6420636c6173  	dc.b	"d class='t1'>Netma"
 263  1008 736b3c        	dc.b	"sk<"
 264  100b 2f74643e3c74  	dc.b	"/td><td><input nam"
 265  101d 653d27623038  	dc.b	"e='b08' class='t6'"
 266  102f 2076616c7565  	dc.b	" value='%b08' %y00"
 267  1041 3c74643e3c69  	dc.b	"<td><input name='b"
 268  1053 30392720636c  	dc.b	"09' class='t6' val"
 269  1065 75653d272562  	dc.b	"ue='%b09' %y00<td>"
 270  1077 3c696e707574  	dc.b	"<input name='b10' "
 271  1089 636c6173733d  	dc.b	"class='t6' value='"
 272  109b 256231302720  	dc.b	"%b10' %y00<td><inp"
 273  10ad 7574206e616d  	dc.b	"ut name='b11' clas"
 274  10bf 733d27743627  	dc.b	"s='t6' value='%b11"
 275  10d1 272025793030  	dc.b	"' %y00</tr></table"
 276  10e3 3e3c7461626c  	dc.b	"><table><tr><td cl"
 277  10f5 6173733d2774  	dc.b	"ass='t1'>Port</td>"
 278  1107 3c7464        	dc.b	"<td"
 279  110a 3e3c696e7075  	dc.b	"><input name='c00'"
 280  111c 20636c617373  	dc.b	" class='t8' value="
 281  112e 272563303027  	dc.b	"'%c00' pattern='[0"
 282  1140 2d395d7b357d  	dc.b	"-9]{5}' title='Ent"
 283  1152 657220303030  	dc.b	"er 00010 to 65535'"
 284  1164 206d61786c65  	dc.b	" maxlength='5'></t"
 285  1176 643e3c2f7472  	dc.b	"d></tr></table><ta"
 286  1188 626c653e3c74  	dc.b	"ble><tr><td class="
 287  119a 277431273e4d  	dc.b	"'t1'>MAC Address</"
 288  11ac 74643e3c7464  	dc.b	"td><td><input name"
 289  11be 3d2764303027  	dc.b	"='d00' class='t7' "
 290  11d0 76616c75653d  	dc.b	"value='%d00' %y01<"
 291  11e2 74643e3c696e  	dc.b	"td><input name='d0"
 292  11f4 312720636c61  	dc.b	"1' class='t7' valu"
 293  1206 653d27        	dc.b	"e='"
 294  1209 256430312720  	dc.b	"%d01' %y01<td><inp"
 295  121b 7574206e616d  	dc.b	"ut name='d02' clas"
 296  122d 733d27743727  	dc.b	"s='t7' value='%d02"
 297  123f 272025793031  	dc.b	"' %y01<td><input n"
 298  1251 616d653d2764  	dc.b	"ame='d03' class='t"
 299  1263 37272076616c  	dc.b	"7' value='%d03' %y"
 300  1275 30313c74643e  	dc.b	"01<td><input name="
 301  1287 276430342720  	dc.b	"'d04' class='t7' v"
 302  1299 616c75653d27  	dc.b	"alue='%d04' %y01<t"
 303  12ab 643e3c696e70  	dc.b	"d><input name='d05"
 304  12bd 2720636c6173  	dc.b	"' class='t7' value"
 305  12cf 3d2725643035  	dc.b	"='%d05' %y01</tr><"
 306  12e1 2f7461626c65  	dc.b	"/table><p></p><tab"
 307  12f3 6c653e3c7472  	dc.b	"le><tr><td class='"
 308  1305 743127        	dc.b	"t1'"
 309  1308 3e4d51545420  	dc.b	">MQTT Server</td><"
 310  131a 74643e3c696e  	dc.b	"td><input name='b1"
 311  132c 322720636c61  	dc.b	"2' class='t6' valu"
 312  133e 653d27256231  	dc.b	"e='%b12' %y00<td><"
 313  1350 696e70757420  	dc.b	"input name='b13' c"
 314  1362 6c6173733d27  	dc.b	"lass='t6' value='%"
 315  1374 623133272025  	dc.b	"b13' %y00<td><inpu"
 316  1386 74206e616d65  	dc.b	"t name='b14' class"
 317  1398 3d2774362720  	dc.b	"='t6' value='%b14'"
 318  13aa 20257930303c  	dc.b	" %y00<td><input na"
 319  13bc 6d653d276231  	dc.b	"me='b15' class='t6"
 320  13ce 272076616c75  	dc.b	"' value='%b15' %y0"
 321  13e0 303c2f74723e  	dc.b	"0</tr></table><tab"
 322  13f2 6c653e3c7472  	dc.b	"le><tr><td class='"
 323  1404 743127        	dc.b	"t1'"
 324  1407 3e4d51545420  	dc.b	">MQTT Port</td><td"
 325  1419 3e3c696e7075  	dc.b	"><input name='c01'"
 326  142b 20636c617373  	dc.b	" class='t8' value="
 327  143d 272563303127  	dc.b	"'%c01' pattern='[0"
 328  144f 2d395d7b357d  	dc.b	"-9]{5}' title='Ent"
 329  1461 657220303030  	dc.b	"er 00010 to 65535'"
 330  1473 206d61786c65  	dc.b	" maxlength='5'></t"
 331  1485 643e3c2f7472  	dc.b	"d></tr></table><ta"
 332  1497 626c653e3c74  	dc.b	"ble><tr><td class="
 333  14a9 277431273e4d  	dc.b	"'t1'>MQTT Username"
 334  14bb 3c2f74643e3c  	dc.b	"</td><td><input na"
 335  14cd 6d653d276c30  	dc.b	"me='l00' class='t1"
 336  14df 272076616c75  	dc.b	"' value='%l00' pat"
 337  14f1 7465726e3d27  	dc.b	"tern='[0-9a-zA-Z-_"
 338  1503 2a2e5d        	dc.b	"*.]"
 339  1506 7b302c31307d  	dc.b	"{0,10}' title='0 t"
 340  1518 6f203130206c  	dc.b	"o 10 letters, numb"
 341  152a 6572732c2061  	dc.b	"ers, and -_*. no s"
 342  153c 70616365732e  	dc.b	"paces. Use none fo"
 343  154e 72206e6f2065  	dc.b	"r no entry.' maxle"
 344  1560 6e6774683d27  	dc.b	"ngth='10'></td></t"
 345  1572 723e3c74723e  	dc.b	"r><tr><td class='t"
 346  1584 31273e4d5154  	dc.b	"1'>MQTT Password</"
 347  1596 74643e3c7464  	dc.b	"td><td><input name"
 348  15a8 3d276d303027  	dc.b	"='m00' class='t1' "
 349  15ba 76616c75653d  	dc.b	"value='%m00' patte"
 350  15cc 726e3d275b30  	dc.b	"rn='[0-9a-zA-Z-_*."
 351  15de 5d7b302c3130  	dc.b	"]{0,10}' title='0 "
 352  15f0 746f20313020  	dc.b	"to 10 letters, num"
 353  1602 626572        	dc.b	"ber"
 354  1605 732c20616e64  	dc.b	"s, and -_*. no spa"
 355  1617 6365732e2055  	dc.b	"ces. Use none for "
 356  1629 6e6f20656e74  	dc.b	"no entry.' maxleng"
 357  163b 74683d273130  	dc.b	"th='10'></td></tr>"
 358  164d 3c2f7461626c  	dc.b	"</table><table><tr"
 359  165f 3e3c74642063  	dc.b	"><td class='t1'>MQ"
 360  1671 545420537461  	dc.b	"TT Status  </td><t"
 361  1683 6420636c6173  	dc.b	"d class='s%n00'></"
 362  1695 74643e3c7464  	dc.b	"td><td class='s%n0"
 363  16a7 31273e3c2f74  	dc.b	"1'></td><td class="
 364  16b9 2773256e3032  	dc.b	"'s%n02'></td><td c"
 365  16cb 6c6173733d27  	dc.b	"lass='s%n03'></td>"
 366  16dd 3c746420636c  	dc.b	"<td class='s%n04'>"
 367  16ef 3c2f74643e3c  	dc.b	"</td></tr></table>"
 368  1701 3c703e        	dc.b	"<p>"
 369  1704 3c2f703e3c69  	dc.b	"</p><input type='h"
 370  1716 696464656e27  	dc.b	"idden' name='z00' "
 371  1728 76616c75653d  	dc.b	"value='1'><button "
 372  173a 747970653d27  	dc.b	"type='submit'>Save"
 373  174c 3c2f62757474  	dc.b	"</button><button t"
 374  175e 7970653d2772  	dc.b	"ype='reset'>Undo A"
 375  1770 6c6c3c2f6275  	dc.b	"ll</button></form>"
 376  1782 3c703e536565  	dc.b	"<p>See Documentati"
 377  1794 6f6e20666f72  	dc.b	"on for help<br>Cod"
 378  17a6 652052657669  	dc.b	"e Revision 2020120"
 379  17b8 322031353437  	dc.b	"2 1547</p>%y03/91%"
 380  17ca 793032526562  	dc.b	"y02Reboot</button>"
 381  17dc 3c2f666f726d  	dc.b	"</form><br><br>%y0"
 382  17ee 332f36312579  	dc.b	"3/61%y02Refresh</b"
 383  1800 757474        	dc.b	"utt"
 384  1803 6f6e3e3c2f66  	dc.b	"on></form>%y03/60%"
 385  1815 793032494f20  	dc.b	"y02IO Control</but"
 386  1827 746f6e3e3c2f  	dc.b	"ton></form></body>"
 387  1839 3c2f68746d6c  	dc.b	"</html>",0
 388  1841               L71_g_HtmlPageRstate:
 389  1841 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 390  1853 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 391  1865 6561643e3c74  	dc.b	"ead><title>Short F"
 392  1877 6f726d3c2f74  	dc.b	"orm</title><link r"
 393  1889 656c3d276963  	dc.b	"el='icon' href='da"
 394  189b 74613a2c273e  	dc.b	"ta:,'></head><body"
 395  18ad 3e3c703e2566  	dc.b	"><p>%f00</p></body"
 396  18bf 3e3c2f68746d  	dc.b	"></html>",0
 397  18c8               L12_g_HtmlPageSstate:
 398  18c8 2566303000    	dc.b	"%f00",0
 399  18cd               L32_page_string00:
 400  18cd 706174746572  	dc.b	"pattern='[0-9]{3}'"
 401  18df 207469746c65  	dc.b	" title='Enter 000 "
 402  18f1 746f20323535  	dc.b	"to 255' maxlength="
 403  1903 2733273e3c2f  	dc.b	"'3'></td>",0
 404  190d               L52_page_string00_len:
 405  190d 3f            	dc.b	63
 406  190e               L72_page_string00_len_less4:
 407  190e 3b            	dc.b	59
 408  190f               L13_page_string01:
 409  190f 706174746572  	dc.b	"pattern='[0-9a-f]{"
 410  1921 327d27207469  	dc.b	"2}' title='Enter 0"
 411  1933 3020746f2066  	dc.b	"0 to ff' maxlength"
 412  1945 3d2732273e3c  	dc.b	"='2'></td>",0
 413  1950               L33_page_string01_len:
 414  1950 40            	dc.b	64
 415  1951               L53_page_string01_len_less4:
 416  1951 3c            	dc.b	60
 417  1952               L73_page_string02:
 418  1952 27206d657468  	dc.b	"' method='GET'><bu"
 419  1964 74746f6e2074  	dc.b	"tton title='Save f"
 420  1976 697273742120  	dc.b	"irst! This button "
 421  1988 77696c6c206e  	dc.b	"will not save your"
 422  199a 206368616e67  	dc.b	" changes'>",0
 423  19a5               L14_page_string02_len:
 424  19a5 52            	dc.b	82
 425  19a6               L34_page_string02_len_less4:
 426  19a6 4e            	dc.b	78
 427  19a7               L54_page_string03:
 428  19a7 3c666f726d20  	dc.b	"<form style='displ"
 429  19b9 61793a20696e  	dc.b	"ay: inline' action"
 430  19cb 3d2700        	dc.b	"='",0
 431  19ce               L74_page_string03_len:
 432  19ce 26            	dc.b	38
 433  19cf               L15_page_string03_len_less4:
 434  19cf 22            	dc.b	34
 435  19d0               L35_page_string04:
 436  19d0 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 437  19e2 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 438  19f4 6561643e3c6c  	dc.b	"ead><link rel='ico"
 439  1a06 6e2720687265  	dc.b	"n' href='data:,'>",0
 440  1a18               L55_page_string04_len:
 441  1a18 47            	dc.b	71
 442  1a19               L75_page_string04_len_less4:
 443  1a19 43            	dc.b	67
 444  1a1a               L16_page_string05:
 445  1a1a 3c7374796c65  	dc.b	"<style>.s0 { backg"
 446  1a2c 726f756e642d  	dc.b	"round-color: red; "
 447  1a3e 77696474683a  	dc.b	"width: 30px; }.s1 "
 448  1a50 7b206261636b  	dc.b	"{ background-color"
 449  1a62 3a2067726565  	dc.b	": green; width: 30"
 450  1a74 70783b207d2e  	dc.b	"px; }.t1 { width: "
 451  1a86 31323070783b  	dc.b	"120px; }.t2 { widt"
 452  1a98 683a20313438  	dc.b	"h: 148px; }.t3 { w"
 453  1aaa 696474683a20  	dc.b	"idth: 30px; }.t5 {"
 454  1abc 207769647468  	dc.b	" width: 60px; }.t6"
 455  1ace 207b20776964  	dc.b	" { width: 25px; }."
 456  1ae0 7437207b2077  	dc.b	"t7 { width: 18px; "
 457  1af2 7d2e7438207b  	dc.b	"}.t8 { width: 40px"
 458  1b04 3b207d00      	dc.b	"; }",0
 459  1b08               L36_page_string05_len:
 460  1b08 ed            	dc.b	237
 461  1b09               L56_page_string05_len_less4:
 462  1b09 e9            	dc.b	233
 463  1b0a               L76_page_string06:
 464  1b0a 7464207b2074  	dc.b	"td { text-align: c"
 465  1b1c 656e7465723b  	dc.b	"enter; border: 1px"
 466  1b2e 20626c61636b  	dc.b	" black solid; }</s"
 467  1b40 74796c653e00  	dc.b	"tyle>",0
 468  1b46               L17_page_string06_len:
 469  1b46 3b            	dc.b	59
 470  1b47               L37_page_string06_len_less4:
 471  1b47 37            	dc.b	55
 526                     ; 1221 uint16_t adjust_template_size()
 526                     ; 1222 {
 528                     .text:	section	.text,new
 529  0000               _adjust_template_size:
 531  0000 89            	pushw	x
 532       00000002      OFST:	set	2
 535                     ; 1240   size = 0;
 537  0001 5f            	clrw	x
 538  0002 1f01          	ldw	(OFST-1,sp),x
 540                     ; 1245   if (current_webpage == WEBPAGE_IOCONTROL) {
 542  0004 c60003        	ld	a,_current_webpage
 543  0007 2613          	jrne	L711
 544                     ; 1246     size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
 546                     ; 1249     size = size + page_string04_len_less4
 546                     ; 1250                 + page_string05_len_less4
 546                     ; 1251 		+ page_string06_len_less4;
 548  0009 ae0d69        	ldw	x,#3433
 549  000c 1f01          	ldw	(OFST-1,sp),x
 551                     ; 1256     size = size + strlen(stored_devicename) - 4 ;
 553  000e ae0000        	ldw	x,#_stored_devicename
 554  0011 cd0000        	call	_strlen
 556  0014 72fb01        	addw	x,(OFST-1,sp)
 557  0017 1c00a4        	addw	x,#164
 559                     ; 1263     size = size - 48;
 562                     ; 1279     size = size - 8;
 565                     ; 1293     size = size + (2 * page_string03_len_less4);
 568                     ; 1322     size = size + (2 * (page_string02_len_less4));
 572  001a 2046          	jra	L121
 573  001c               L711:
 574                     ; 1341   else if (current_webpage == WEBPAGE_CONFIGURATION) {
 576  001c a101          	cp	a,#1
 577  001e 2632          	jrne	L321
 578                     ; 1342     size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
 580                     ; 1345     size = size + page_string04_len_less4
 580                     ; 1346                 + page_string05_len_less4
 580                     ; 1347 		+ page_string06_len_less4;
 582  0020 ae0d94        	ldw	x,#3476
 583  0023 1f01          	ldw	(OFST-1,sp),x
 585                     ; 1352     size = size + strlen(stored_devicename) - 4 ;
 587  0025 ae0000        	ldw	x,#_stored_devicename
 588  0028 cd0000        	call	_strlen
 590  002b 72fb01        	addw	x,(OFST-1,sp)
 591  002e 1d001c        	subw	x,#28
 593                     ; 1359     size = size - 12;
 596                     ; 1366     size = size + 1;
 599                     ; 1373     size = size - 12;
 602                     ; 1381     size = size + 2;
 605                     ; 1389     size = size - 4;
 608                     ; 1396     size = size + 1;
 610  0031 1f01          	ldw	(OFST-1,sp),x
 612                     ; 1401     size = size + (strlen(stored_mqtt_username) - 4);
 614  0033 ae0000        	ldw	x,#_stored_mqtt_username
 615  0036 cd0000        	call	_strlen
 617  0039 1d0004        	subw	x,#4
 618  003c 72fb01        	addw	x,(OFST-1,sp)
 619  003f 1f01          	ldw	(OFST-1,sp),x
 621                     ; 1406     size = size + (strlen(stored_mqtt_password) - 4);
 623  0041 ae0000        	ldw	x,#_stored_mqtt_password
 624  0044 cd0000        	call	_strlen
 626  0047 1d0004        	subw	x,#4
 627  004a 72fb01        	addw	x,(OFST-1,sp)
 629                     ; 1413     size = size - 15;
 631  004d 1c0659        	addw	x,#1625
 633                     ; 1427     size = size + (3 * page_string03_len_less4);
 636                     ; 1456     size = size + (12 * (page_string00_len_less4));
 639                     ; 1465     size = size + (4 * (page_string00_len_less4));
 642                     ; 1475     size = size + (6 * (page_string01_len_less4));
 645                     ; 1484     size = size + (3 * (page_string02_len_less4));
 649  0050 2010          	jra	L121
 650  0052               L321:
 651                     ; 1598   else if (current_webpage == WEBPAGE_RSTATE) {
 653  0052 a106          	cp	a,#6
 654  0054 2605          	jrne	L721
 655                     ; 1599     size = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
 657                     ; 1604     size = size + 12;
 659  0056 ae0092        	ldw	x,#146
 662  0059 2007          	jra	L121
 663  005b               L721:
 664                     ; 1611   else if (current_webpage == WEBPAGE_SSTATE) {
 666  005b a107          	cp	a,#7
 667  005d 2603          	jrne	L121
 668                     ; 1612     size = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
 670                     ; 1617     size = size + 12;
 672  005f ae0010        	ldw	x,#16
 674  0062               L121:
 675                     ; 1620   return size;
 679  0062 5b02          	addw	sp,#2
 680  0064 81            	ret	
 771                     ; 1624 void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
 771                     ; 1625 {
 772                     .text:	section	.text,new
 773  0000               _emb_itoa:
 775  0000 5207          	subw	sp,#7
 776       00000007      OFST:	set	7
 779                     ; 1643   for (i=0; i < pad; i++) str[i] = '0';
 781  0002 0f07          	clr	(OFST+0,sp)
 784  0004 200a          	jra	L771
 785  0006               L371:
 788  0006 5f            	clrw	x
 789  0007 97            	ld	xl,a
 790  0008 72fb0e        	addw	x,(OFST+7,sp)
 791  000b a630          	ld	a,#48
 792  000d f7            	ld	(x),a
 795  000e 0c07          	inc	(OFST+0,sp)
 797  0010               L771:
 800  0010 7b07          	ld	a,(OFST+0,sp)
 801  0012 1111          	cp	a,(OFST+10,sp)
 802  0014 25f0          	jrult	L371
 803                     ; 1644   str[pad] = '\0';
 805  0016 7b11          	ld	a,(OFST+10,sp)
 806  0018 5f            	clrw	x
 807  0019 97            	ld	xl,a
 808  001a 72fb0e        	addw	x,(OFST+7,sp)
 809  001d 7f            	clr	(x)
 810                     ; 1645   if (num == 0) return;
 812  001e 96            	ldw	x,sp
 813  001f 1c000a        	addw	x,#OFST+3
 814  0022 cd0000        	call	c_lzmp
 816  0025 2603cc00cf    	jreq	L02
 819                     ; 1648   i = 0;
 821  002a 0f07          	clr	(OFST+0,sp)
 824  002c 2060          	jra	L112
 825  002e               L502:
 826                     ; 1650     rem = (uint8_t)(num % base);
 828  002e 7b10          	ld	a,(OFST+9,sp)
 829  0030 b703          	ld	c_lreg+3,a
 830  0032 3f02          	clr	c_lreg+2
 831  0034 3f01          	clr	c_lreg+1
 832  0036 3f00          	clr	c_lreg
 833  0038 96            	ldw	x,sp
 834  0039 5c            	incw	x
 835  003a cd0000        	call	c_rtol
 838  003d 96            	ldw	x,sp
 839  003e 1c000a        	addw	x,#OFST+3
 840  0041 cd0000        	call	c_ltor
 842  0044 96            	ldw	x,sp
 843  0045 5c            	incw	x
 844  0046 cd0000        	call	c_lumd
 846  0049 b603          	ld	a,c_lreg+3
 847  004b 6b06          	ld	(OFST-1,sp),a
 849                     ; 1651     if (rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
 851  004d a10a          	cp	a,#10
 852  004f 7b07          	ld	a,(OFST+0,sp)
 853  0051 250d          	jrult	L512
 856  0053 0c07          	inc	(OFST+0,sp)
 858  0055 5f            	clrw	x
 859  0056 97            	ld	xl,a
 860  0057 72fb0e        	addw	x,(OFST+7,sp)
 861  005a 7b06          	ld	a,(OFST-1,sp)
 862  005c ab57          	add	a,#87
 864  005e 200b          	jra	L712
 865  0060               L512:
 866                     ; 1652     else str[i++] = (uint8_t)(rem + '0');
 868  0060 0c07          	inc	(OFST+0,sp)
 870  0062 5f            	clrw	x
 871  0063 97            	ld	xl,a
 872  0064 72fb0e        	addw	x,(OFST+7,sp)
 873  0067 7b06          	ld	a,(OFST-1,sp)
 874  0069 ab30          	add	a,#48
 875  006b               L712:
 876  006b f7            	ld	(x),a
 877                     ; 1653     num = num/base;
 879  006c 7b10          	ld	a,(OFST+9,sp)
 880  006e b703          	ld	c_lreg+3,a
 881  0070 3f02          	clr	c_lreg+2
 882  0072 3f01          	clr	c_lreg+1
 883  0074 3f00          	clr	c_lreg
 884  0076 96            	ldw	x,sp
 885  0077 5c            	incw	x
 886  0078 cd0000        	call	c_rtol
 889  007b 96            	ldw	x,sp
 890  007c 1c000a        	addw	x,#OFST+3
 891  007f cd0000        	call	c_ltor
 893  0082 96            	ldw	x,sp
 894  0083 5c            	incw	x
 895  0084 cd0000        	call	c_ludv
 897  0087 96            	ldw	x,sp
 898  0088 1c000a        	addw	x,#OFST+3
 899  008b cd0000        	call	c_rtol
 901  008e               L112:
 902                     ; 1649   while (num != 0) {
 904  008e 96            	ldw	x,sp
 905  008f 1c000a        	addw	x,#OFST+3
 906  0092 cd0000        	call	c_lzmp
 908  0095 2697          	jrne	L502
 909                     ; 1662     start = 0;
 911  0097 0f06          	clr	(OFST-1,sp)
 913                     ; 1663     end = (uint8_t)(pad - 1);
 915  0099 7b11          	ld	a,(OFST+10,sp)
 916  009b 4a            	dec	a
 917  009c 6b07          	ld	(OFST+0,sp),a
 920  009e 2029          	jra	L522
 921  00a0               L122:
 922                     ; 1666       temp = str[start];
 924  00a0 5f            	clrw	x
 925  00a1 97            	ld	xl,a
 926  00a2 72fb0e        	addw	x,(OFST+7,sp)
 927  00a5 f6            	ld	a,(x)
 928  00a6 6b05          	ld	(OFST-2,sp),a
 930                     ; 1667       str[start] = str[end];
 932  00a8 5f            	clrw	x
 933  00a9 7b06          	ld	a,(OFST-1,sp)
 934  00ab 97            	ld	xl,a
 935  00ac 72fb0e        	addw	x,(OFST+7,sp)
 936  00af 7b07          	ld	a,(OFST+0,sp)
 937  00b1 905f          	clrw	y
 938  00b3 9097          	ld	yl,a
 939  00b5 72f90e        	addw	y,(OFST+7,sp)
 940  00b8 90f6          	ld	a,(y)
 941  00ba f7            	ld	(x),a
 942                     ; 1668       str[end] = temp;
 944  00bb 5f            	clrw	x
 945  00bc 7b07          	ld	a,(OFST+0,sp)
 946  00be 97            	ld	xl,a
 947  00bf 72fb0e        	addw	x,(OFST+7,sp)
 948  00c2 7b05          	ld	a,(OFST-2,sp)
 949  00c4 f7            	ld	(x),a
 950                     ; 1669       start++;
 952  00c5 0c06          	inc	(OFST-1,sp)
 954                     ; 1670       end--;
 956  00c7 0a07          	dec	(OFST+0,sp)
 958  00c9               L522:
 959                     ; 1665     while (start < end) {
 959                     ; 1666       temp = str[start];
 959                     ; 1667       str[start] = str[end];
 959                     ; 1668       str[end] = temp;
 959                     ; 1669       start++;
 959                     ; 1670       end--;
 961  00c9 7b06          	ld	a,(OFST-1,sp)
 962  00cb 1107          	cp	a,(OFST+0,sp)
 963  00cd 25d1          	jrult	L122
 964                     ; 1673 }
 965  00cf               L02:
 968  00cf 5b07          	addw	sp,#7
 969  00d1 81            	ret	
1029                     ; 1676 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1029                     ; 1677 {
1030                     .text:	section	.text,new
1031  0000               L3_CopyStringP:
1033  0000 89            	pushw	x
1034  0001 5203          	subw	sp,#3
1035       00000003      OFST:	set	3
1038                     ; 1682   nBytes = 0;
1040  0003 5f            	clrw	x
1042  0004 2014          	jra	L362
1043  0006               L752:
1044                     ; 1684     **ppBuffer = Character;
1046  0006 1e04          	ldw	x,(OFST+1,sp)
1047  0008 fe            	ldw	x,(x)
1048  0009 f7            	ld	(x),a
1049                     ; 1685     *ppBuffer = *ppBuffer + 1;
1051  000a 1e04          	ldw	x,(OFST+1,sp)
1052  000c 9093          	ldw	y,x
1053  000e fe            	ldw	x,(x)
1054  000f 5c            	incw	x
1055  0010 90ff          	ldw	(y),x
1056                     ; 1686     pString = pString + 1;
1058  0012 1e08          	ldw	x,(OFST+5,sp)
1059  0014 5c            	incw	x
1060  0015 1f08          	ldw	(OFST+5,sp),x
1061                     ; 1687     nBytes++;
1063  0017 1e01          	ldw	x,(OFST-2,sp)
1064  0019 5c            	incw	x
1065  001a               L362:
1066  001a 1f01          	ldw	(OFST-2,sp),x
1068                     ; 1683   while ((Character = pString[0]) != '\0') {
1068                     ; 1684     **ppBuffer = Character;
1068                     ; 1685     *ppBuffer = *ppBuffer + 1;
1068                     ; 1686     pString = pString + 1;
1068                     ; 1687     nBytes++;
1070  001c 1e08          	ldw	x,(OFST+5,sp)
1071  001e f6            	ld	a,(x)
1072  001f 6b03          	ld	(OFST+0,sp),a
1074  0021 26e3          	jrne	L752
1075                     ; 1689   return nBytes;
1077  0023 1e01          	ldw	x,(OFST-2,sp)
1080  0025 5b05          	addw	sp,#5
1081  0027 81            	ret	
1140                     ; 1693 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen)
1140                     ; 1694 {
1141                     .text:	section	.text,new
1142  0000               L5_CopyHttpHeader:
1144  0000 89            	pushw	x
1145  0001 5203          	subw	sp,#3
1146       00000003      OFST:	set	3
1149                     ; 1698   nBytes = 0;
1151  0003 5f            	clrw	x
1152  0004 1f02          	ldw	(OFST-1,sp),x
1154                     ; 1700   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
1156  0006 ae1c3b        	ldw	x,#L313
1157  0009 89            	pushw	x
1158  000a 96            	ldw	x,sp
1159  000b 1c0006        	addw	x,#OFST+3
1160  000e cd0000        	call	L3_CopyStringP
1162  0011 5b02          	addw	sp,#2
1163  0013 72fb02        	addw	x,(OFST-1,sp)
1164  0016 1f02          	ldw	(OFST-1,sp),x
1166                     ; 1701   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1168  0018 ae1c38        	ldw	x,#L513
1169  001b 89            	pushw	x
1170  001c 96            	ldw	x,sp
1171  001d 1c0006        	addw	x,#OFST+3
1172  0020 cd0000        	call	L3_CopyStringP
1174  0023 5b02          	addw	sp,#2
1175  0025 72fb02        	addw	x,(OFST-1,sp)
1176  0028 1f02          	ldw	(OFST-1,sp),x
1178                     ; 1703   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
1180  002a ae1c28        	ldw	x,#L713
1181  002d 89            	pushw	x
1182  002e 96            	ldw	x,sp
1183  002f 1c0006        	addw	x,#OFST+3
1184  0032 cd0000        	call	L3_CopyStringP
1186  0035 5b02          	addw	sp,#2
1187  0037 72fb02        	addw	x,(OFST-1,sp)
1188  003a 1f02          	ldw	(OFST-1,sp),x
1190                     ; 1707   emb_itoa(nDataLen, OctetArray, 10, 5);
1192  003c 4b05          	push	#5
1193  003e 4b0a          	push	#10
1194  0040 ae0045        	ldw	x,#_OctetArray
1195  0043 89            	pushw	x
1196  0044 1e0c          	ldw	x,(OFST+9,sp)
1197  0046 cd0000        	call	c_uitolx
1199  0049 be02          	ldw	x,c_lreg+2
1200  004b 89            	pushw	x
1201  004c be00          	ldw	x,c_lreg
1202  004e 89            	pushw	x
1203  004f cd0000        	call	_emb_itoa
1205  0052 5b08          	addw	sp,#8
1206                     ; 1708   for (i=0; i<5; i++) {
1208  0054 4f            	clr	a
1209  0055 6b01          	ld	(OFST-2,sp),a
1211  0057               L123:
1212                     ; 1709     *pBuffer = (uint8_t)OctetArray[i];
1214  0057 5f            	clrw	x
1215  0058 97            	ld	xl,a
1216  0059 d60045        	ld	a,(_OctetArray,x)
1217  005c 1e04          	ldw	x,(OFST+1,sp)
1218  005e f7            	ld	(x),a
1219                     ; 1710     pBuffer = pBuffer + 1;
1221  005f 5c            	incw	x
1222  0060 1f04          	ldw	(OFST+1,sp),x
1223                     ; 1708   for (i=0; i<5; i++) {
1225  0062 0c01          	inc	(OFST-2,sp)
1229  0064 7b01          	ld	a,(OFST-2,sp)
1230  0066 a105          	cp	a,#5
1231  0068 25ed          	jrult	L123
1232                     ; 1712   nBytes += 5;
1234  006a 1e02          	ldw	x,(OFST-1,sp)
1235  006c 1c0005        	addw	x,#5
1236  006f 1f02          	ldw	(OFST-1,sp),x
1238                     ; 1714   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1240  0071 ae1c38        	ldw	x,#L513
1241  0074 89            	pushw	x
1242  0075 96            	ldw	x,sp
1243  0076 1c0006        	addw	x,#OFST+3
1244  0079 cd0000        	call	L3_CopyStringP
1246  007c 5b02          	addw	sp,#2
1247  007e 72fb02        	addw	x,(OFST-1,sp)
1248  0081 1f02          	ldw	(OFST-1,sp),x
1250                     ; 1717   nBytes += CopyStringP(&pBuffer, (const char *)("Cache-Control: no-cache, no-store\r\n"));
1252  0083 ae1c04        	ldw	x,#L723
1253  0086 89            	pushw	x
1254  0087 96            	ldw	x,sp
1255  0088 1c0006        	addw	x,#OFST+3
1256  008b cd0000        	call	L3_CopyStringP
1258  008e 5b02          	addw	sp,#2
1259  0090 72fb02        	addw	x,(OFST-1,sp)
1260  0093 1f02          	ldw	(OFST-1,sp),x
1262                     ; 1719   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type: text/html; charset=utf-8\r\n"));
1264  0095 ae1bdb        	ldw	x,#L133
1265  0098 89            	pushw	x
1266  0099 96            	ldw	x,sp
1267  009a 1c0006        	addw	x,#OFST+3
1268  009d cd0000        	call	L3_CopyStringP
1270  00a0 5b02          	addw	sp,#2
1271  00a2 72fb02        	addw	x,(OFST-1,sp)
1272  00a5 1f02          	ldw	(OFST-1,sp),x
1274                     ; 1721   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
1276  00a7 ae1bc8        	ldw	x,#L333
1277  00aa 89            	pushw	x
1278  00ab 96            	ldw	x,sp
1279  00ac 1c0006        	addw	x,#OFST+3
1280  00af cd0000        	call	L3_CopyStringP
1282  00b2 5b02          	addw	sp,#2
1283  00b4 72fb02        	addw	x,(OFST-1,sp)
1284  00b7 1f02          	ldw	(OFST-1,sp),x
1286                     ; 1722   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1288  00b9 ae1c38        	ldw	x,#L513
1289  00bc 89            	pushw	x
1290  00bd 96            	ldw	x,sp
1291  00be 1c0006        	addw	x,#OFST+3
1292  00c1 cd0000        	call	L3_CopyStringP
1294  00c4 5b02          	addw	sp,#2
1295  00c6 72fb02        	addw	x,(OFST-1,sp)
1297                     ; 1724   return nBytes;
1301  00c9 5b05          	addw	sp,#5
1302  00cb 81            	ret	
1455                     	switch	.const
1456  1b48               L431:
1457  1b48 01b2          	dc.w	L533
1458  1b4a 01c0          	dc.w	L733
1459  1b4c 01ce          	dc.w	L143
1460  1b4e 01dc          	dc.w	L343
1461  1b50 01ea          	dc.w	L543
1462  1b52 01f8          	dc.w	L743
1463  1b54 0206          	dc.w	L153
1464  1b56 0213          	dc.w	L353
1465  1b58 0220          	dc.w	L553
1466  1b5a 022d          	dc.w	L753
1467  1b5c 023a          	dc.w	L163
1468  1b5e 0247          	dc.w	L363
1469  1b60 0254          	dc.w	L563
1470  1b62 0261          	dc.w	L763
1471  1b64 026e          	dc.w	L173
1472  1b66 027b          	dc.w	L373
1473                     ; 1728 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
1473                     ; 1729 {
1474                     .text:	section	.text,new
1475  0000               L7_CopyHttpData:
1477  0000 89            	pushw	x
1478  0001 5208          	subw	sp,#8
1479       00000008      OFST:	set	8
1482                     ; 1748   nBytes = 0;
1484  0003 5f            	clrw	x
1485  0004 1f05          	ldw	(OFST-3,sp),x
1487                     ; 1749   nParsedNum = 0;
1489  0006 0f07          	clr	(OFST-1,sp)
1491                     ; 1750   nParsedMode = 0;
1493  0008 0f04          	clr	(OFST-4,sp)
1495                     ; 1805   nMaxBytes = UIP_TCP_MSS - 25;
1497  000a ae019f        	ldw	x,#415
1498  000d 1f11          	ldw	(OFST+9,sp),x
1500  000f cc056a        	jra	L505
1501  0012               L305:
1502                     ; 1839     if (*pDataLeft > 0) {
1504  0012 1e0f          	ldw	x,(OFST+7,sp)
1505  0014 e601          	ld	a,(1,x)
1506  0016 fa            	or	a,(x)
1507  0017 2603cc0573    	jreq	L705
1508                     ; 1846       if (insertion_flag[0] != 0) {
1510  001c c60000        	ld	a,_insertion_flag
1511  001f 2711          	jreq	L315
1512                     ; 1855         nParsedMode = insertion_flag[1];
1514  0021 c60001        	ld	a,_insertion_flag+1
1515  0024 6b04          	ld	(OFST-4,sp),a
1517                     ; 1856         nParsedNum = insertion_flag[2];
1519  0026 c60002        	ld	a,_insertion_flag+2
1520  0029 6b07          	ld	(OFST-1,sp),a
1522                     ; 1857 	nByte = '0'; // Need to set nByte to something other than '%' so we
1524  002b a630          	ld	a,#48
1525  002d 6b02          	ld	(OFST-6,sp),a
1528  002f cc00f1        	jra	L515
1529  0032               L315:
1530                     ; 1870         memcpy(&nByte, *ppData, 1);
1532  0032 96            	ldw	x,sp
1533  0033 1c0002        	addw	x,#OFST-6
1534  0036 bf00          	ldw	c_x,x
1535  0038 160d          	ldw	y,(OFST+5,sp)
1536  003a 90fe          	ldw	y,(y)
1537  003c 90bf00        	ldw	c_y,y
1538  003f ae0001        	ldw	x,#1
1539  0042               L25:
1540  0042 5a            	decw	x
1541  0043 92d600        	ld	a,([c_y.w],x)
1542  0046 92d700        	ld	([c_x.w],x),a
1543  0049 5d            	tnzw	x
1544  004a 26f6          	jrne	L25
1545                     ; 1913         if (nByte == '%') {
1547  004c 7b02          	ld	a,(OFST-6,sp)
1548  004e a125          	cp	a,#37
1549  0050 26dd          	jrne	L515
1550                     ; 1914           *ppData = *ppData + 1;
1552  0052 1e0d          	ldw	x,(OFST+5,sp)
1553  0054 9093          	ldw	y,x
1554  0056 fe            	ldw	x,(x)
1555  0057 5c            	incw	x
1556  0058 90ff          	ldw	(y),x
1557                     ; 1915           *pDataLeft = *pDataLeft - 1;
1559  005a 1e0f          	ldw	x,(OFST+7,sp)
1560  005c 9093          	ldw	y,x
1561  005e fe            	ldw	x,(x)
1562  005f 5a            	decw	x
1563  0060 90ff          	ldw	(y),x
1564                     ; 1920           memcpy(&nParsedMode, *ppData, 1);
1566  0062 96            	ldw	x,sp
1567  0063 1c0004        	addw	x,#OFST-4
1568  0066 bf00          	ldw	c_x,x
1569  0068 160d          	ldw	y,(OFST+5,sp)
1570  006a 90fe          	ldw	y,(y)
1571  006c 90bf00        	ldw	c_y,y
1572  006f ae0001        	ldw	x,#1
1573  0072               L45:
1574  0072 5a            	decw	x
1575  0073 92d600        	ld	a,([c_y.w],x)
1576  0076 92d700        	ld	([c_x.w],x),a
1577  0079 5d            	tnzw	x
1578  007a 26f6          	jrne	L45
1579                     ; 1921           *ppData = *ppData + 1;
1581  007c 1e0d          	ldw	x,(OFST+5,sp)
1582  007e 9093          	ldw	y,x
1583  0080 fe            	ldw	x,(x)
1584  0081 5c            	incw	x
1585  0082 90ff          	ldw	(y),x
1586                     ; 1922           *pDataLeft = *pDataLeft - 1;
1588  0084 1e0f          	ldw	x,(OFST+7,sp)
1589  0086 9093          	ldw	y,x
1590  0088 fe            	ldw	x,(x)
1591  0089 5a            	decw	x
1592  008a 90ff          	ldw	(y),x
1593                     ; 1927           memcpy(&temp, *ppData, 1);
1595  008c 96            	ldw	x,sp
1596  008d 5c            	incw	x
1597  008e bf00          	ldw	c_x,x
1598  0090 160d          	ldw	y,(OFST+5,sp)
1599  0092 90fe          	ldw	y,(y)
1600  0094 90bf00        	ldw	c_y,y
1601  0097 ae0001        	ldw	x,#1
1602  009a               L65:
1603  009a 5a            	decw	x
1604  009b 92d600        	ld	a,([c_y.w],x)
1605  009e 92d700        	ld	([c_x.w],x),a
1606  00a1 5d            	tnzw	x
1607  00a2 26f6          	jrne	L65
1608                     ; 1928           nParsedNum = (uint8_t)((temp - '0') * 10);
1610  00a4 7b01          	ld	a,(OFST-7,sp)
1611  00a6 97            	ld	xl,a
1612  00a7 a60a          	ld	a,#10
1613  00a9 42            	mul	x,a
1614  00aa 9f            	ld	a,xl
1615  00ab a0e0          	sub	a,#224
1616  00ad 6b07          	ld	(OFST-1,sp),a
1618                     ; 1929           *ppData = *ppData + 1;
1620  00af 1e0d          	ldw	x,(OFST+5,sp)
1621  00b1 9093          	ldw	y,x
1622  00b3 fe            	ldw	x,(x)
1623  00b4 5c            	incw	x
1624  00b5 90ff          	ldw	(y),x
1625                     ; 1930           *pDataLeft = *pDataLeft - 1;
1627  00b7 1e0f          	ldw	x,(OFST+7,sp)
1628  00b9 9093          	ldw	y,x
1629  00bb fe            	ldw	x,(x)
1630  00bc 5a            	decw	x
1631  00bd 90ff          	ldw	(y),x
1632                     ; 1935           memcpy(&temp, *ppData, 1);
1634  00bf 96            	ldw	x,sp
1635  00c0 5c            	incw	x
1636  00c1 bf00          	ldw	c_x,x
1637  00c3 160d          	ldw	y,(OFST+5,sp)
1638  00c5 90fe          	ldw	y,(y)
1639  00c7 90bf00        	ldw	c_y,y
1640  00ca ae0001        	ldw	x,#1
1641  00cd               L06:
1642  00cd 5a            	decw	x
1643  00ce 92d600        	ld	a,([c_y.w],x)
1644  00d1 92d700        	ld	([c_x.w],x),a
1645  00d4 5d            	tnzw	x
1646  00d5 26f6          	jrne	L06
1647                     ; 1936           nParsedNum = (uint8_t)(nParsedNum + temp - '0');
1649  00d7 7b07          	ld	a,(OFST-1,sp)
1650  00d9 1b01          	add	a,(OFST-7,sp)
1651  00db a030          	sub	a,#48
1652  00dd 6b07          	ld	(OFST-1,sp),a
1654                     ; 1937           *ppData = *ppData + 1;
1656  00df 1e0d          	ldw	x,(OFST+5,sp)
1657  00e1 9093          	ldw	y,x
1658  00e3 fe            	ldw	x,(x)
1659  00e4 5c            	incw	x
1660  00e5 90ff          	ldw	(y),x
1661                     ; 1938           *pDataLeft = *pDataLeft - 1;
1663  00e7 1e0f          	ldw	x,(OFST+7,sp)
1664  00e9 9093          	ldw	y,x
1665  00eb fe            	ldw	x,(x)
1666  00ec 5a            	decw	x
1667  00ed 90ff          	ldw	(y),x
1668  00ef 7b02          	ld	a,(OFST-6,sp)
1669  00f1               L515:
1670                     ; 1942       if ((nByte == '%') || (insertion_flag[0] != 0)) {
1672  00f1 a125          	cp	a,#37
1673  00f3 2709          	jreq	L325
1675  00f5 725d0000      	tnz	_insertion_flag
1676  00f9 2603cc054d    	jreq	L125
1677  00fe               L325:
1678                     ; 1952         if (nParsedMode == 'i') {
1680  00fe 7b04          	ld	a,(OFST-4,sp)
1681  0100 a169          	cp	a,#105
1682  0102 2630          	jrne	L525
1683                     ; 1966           if (nParsedNum > 7) {
1685  0104 7b07          	ld	a,(OFST-1,sp)
1686  0106 a108          	cp	a,#8
1687  0108 2520          	jrult	L725
1688                     ; 1968 	    i = GpioGetPin(nParsedNum);
1690  010a cd0000        	call	_GpioGetPin
1692  010d 6b08          	ld	(OFST+0,sp),a
1694                     ; 1969 	    if (invert_input == 0x00) *pBuffer = (uint8_t)(i + '0');
1696  010f 725d0000      	tnz	_invert_input
1697  0113 2607          	jrne	L135
1700  0115 ab30          	add	a,#48
1701  0117 1e09          	ldw	x,(OFST+1,sp)
1703  0119 cc036e        	jra	LC008
1704  011c               L135:
1705                     ; 1971 	      if (i == 0) *pBuffer = (uint8_t)('1');
1707  011c 7b08          	ld	a,(OFST+0,sp)
1710  011e 2603cc0479    	jreq	LC009
1711                     ; 1972 	      else *pBuffer = (uint8_t)('0');
1713  0123 1e09          	ldw	x,(OFST+1,sp)
1714  0125 a630          	ld	a,#48
1715                     ; 1974             pBuffer++;
1716                     ; 1975             nBytes++;
1718  0127 cc036e        	jp	LC008
1719  012a               L725:
1720                     ; 1979 	    *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
1722  012a cd0000        	call	_GpioGetPin
1724  012d ab30          	add	a,#48
1725  012f 1e09          	ldw	x,(OFST+1,sp)
1726                     ; 1980             pBuffer++;
1727                     ; 1981             nBytes++;
1728  0131 cc036e        	jp	LC008
1729  0134               L525:
1730                     ; 1999         else if ((nParsedMode == 'o' && ((uint8_t)(GpioGetPin(nParsedNum) == 1)))
1730                     ; 2000 	      || (nParsedMode == 'p' && ((uint8_t)(GpioGetPin(nParsedNum) == 0)))) { 
1732  0134 a16f          	cp	a,#111
1733  0136 260a          	jrne	L155
1735  0138 7b07          	ld	a,(OFST-1,sp)
1736  013a cd0000        	call	_GpioGetPin
1738  013d 4a            	dec	a
1739  013e 270e          	jreq	L745
1740  0140 7b04          	ld	a,(OFST-4,sp)
1741  0142               L155:
1743  0142 a170          	cp	a,#112
1744  0144 2626          	jrne	L545
1746  0146 7b07          	ld	a,(OFST-1,sp)
1747  0148 cd0000        	call	_GpioGetPin
1749  014b 4d            	tnz	a
1750  014c 261e          	jrne	L545
1751  014e               L745:
1752                     ; 2005           for(i=0; i<7; i++) {
1754  014e 4f            	clr	a
1755  014f 6b08          	ld	(OFST+0,sp),a
1757  0151               L355:
1758                     ; 2006             *pBuffer = checked[i];
1760  0151 5f            	clrw	x
1761  0152 97            	ld	xl,a
1762  0153 d60000        	ld	a,(L11_checked,x)
1763  0156 1e09          	ldw	x,(OFST+1,sp)
1764  0158 f7            	ld	(x),a
1765                     ; 2007             pBuffer++;
1767  0159 5c            	incw	x
1768  015a 1f09          	ldw	(OFST+1,sp),x
1769                     ; 2005           for(i=0; i<7; i++) {
1771  015c 0c08          	inc	(OFST+0,sp)
1775  015e 7b08          	ld	a,(OFST+0,sp)
1776  0160 a107          	cp	a,#7
1777  0162 25ed          	jrult	L355
1778                     ; 2009 	  nBytes += 7;
1780  0164 1e05          	ldw	x,(OFST-3,sp)
1781  0166 1c0007        	addw	x,#7
1783  0169 cc0568        	jp	LC005
1784  016c               L545:
1785                     ; 2012         else if (nParsedMode == 'a') {
1787  016c 7b04          	ld	a,(OFST-4,sp)
1788  016e a161          	cp	a,#97
1789  0170 2629          	jrne	L365
1790                     ; 2014 	  for(i=0; i<19; i++) {
1792  0172 4f            	clr	a
1793  0173 6b08          	ld	(OFST+0,sp),a
1795  0175               L565:
1796                     ; 2015 	    if (stored_devicename[i] != '\0') {
1798  0175 5f            	clrw	x
1799  0176 97            	ld	xl,a
1800  0177 724d0000      	tnz	(_stored_devicename,x)
1801  017b 2603cc056a    	jreq	L505
1802                     ; 2016               *pBuffer = (uint8_t)(stored_devicename[i]);
1804  0180 5f            	clrw	x
1805  0181 97            	ld	xl,a
1806  0182 d60000        	ld	a,(_stored_devicename,x)
1807  0185 1e09          	ldw	x,(OFST+1,sp)
1808  0187 f7            	ld	(x),a
1809                     ; 2017               pBuffer++;
1811  0188 5c            	incw	x
1812  0189 1f09          	ldw	(OFST+1,sp),x
1813                     ; 2018               nBytes++;
1815  018b 1e05          	ldw	x,(OFST-3,sp)
1816  018d 5c            	incw	x
1817  018e 1f05          	ldw	(OFST-3,sp),x
1820                     ; 2014 	  for(i=0; i<19; i++) {
1822  0190 0c08          	inc	(OFST+0,sp)
1826  0192 7b08          	ld	a,(OFST+0,sp)
1827  0194 a113          	cp	a,#19
1828  0196 25dd          	jrult	L565
1829  0198 cc056a        	jra	L505
1830  019b               L365:
1831                     ; 2024         else if (nParsedMode == 'b') {
1833  019b a162          	cp	a,#98
1834  019d 2703cc02b7    	jrne	L106
1835                     ; 2029           switch (nParsedNum)
1837  01a2 7b07          	ld	a,(OFST-1,sp)
1839                     ; 2050 	    default: break;
1840  01a4 a110          	cp	a,#16
1841  01a6 2503cc0299    	jruge	L506
1842  01ab 5f            	clrw	x
1843  01ac 97            	ld	xl,a
1844  01ad 58            	sllw	x
1845  01ae de1b48        	ldw	x,(L431,x)
1846  01b1 fc            	jp	(x)
1847  01b2               L533:
1848                     ; 2032 	    case 0:  emb_itoa(stored_hostaddr[3], OctetArray, 10, 3); break;
1850  01b2 4b03          	push	#3
1851  01b4 4b0a          	push	#10
1852  01b6 ae0045        	ldw	x,#_OctetArray
1853  01b9 89            	pushw	x
1854  01ba c60003        	ld	a,_stored_hostaddr+3
1858  01bd cc0286        	jp	LC001
1859  01c0               L733:
1860                     ; 2033 	    case 1:  emb_itoa(stored_hostaddr[2], OctetArray, 10, 3); break;
1862  01c0 4b03          	push	#3
1863  01c2 4b0a          	push	#10
1864  01c4 ae0045        	ldw	x,#_OctetArray
1865  01c7 89            	pushw	x
1866  01c8 c60002        	ld	a,_stored_hostaddr+2
1870  01cb cc0286        	jp	LC001
1871  01ce               L143:
1872                     ; 2034 	    case 2:  emb_itoa(stored_hostaddr[1], OctetArray, 10, 3); break;
1874  01ce 4b03          	push	#3
1875  01d0 4b0a          	push	#10
1876  01d2 ae0045        	ldw	x,#_OctetArray
1877  01d5 89            	pushw	x
1878  01d6 c60001        	ld	a,_stored_hostaddr+1
1882  01d9 cc0286        	jp	LC001
1883  01dc               L343:
1884                     ; 2035 	    case 3:  emb_itoa(stored_hostaddr[0], OctetArray, 10, 3); break;
1886  01dc 4b03          	push	#3
1887  01de 4b0a          	push	#10
1888  01e0 ae0045        	ldw	x,#_OctetArray
1889  01e3 89            	pushw	x
1890  01e4 c60000        	ld	a,_stored_hostaddr
1894  01e7 cc0286        	jp	LC001
1895  01ea               L543:
1896                     ; 2036 	    case 4:  emb_itoa(stored_draddr[3],   OctetArray, 10, 3); break;
1898  01ea 4b03          	push	#3
1899  01ec 4b0a          	push	#10
1900  01ee ae0045        	ldw	x,#_OctetArray
1901  01f1 89            	pushw	x
1902  01f2 c60003        	ld	a,_stored_draddr+3
1906  01f5 cc0286        	jp	LC001
1907  01f8               L743:
1908                     ; 2037 	    case 5:  emb_itoa(stored_draddr[2],   OctetArray, 10, 3); break;
1910  01f8 4b03          	push	#3
1911  01fa 4b0a          	push	#10
1912  01fc ae0045        	ldw	x,#_OctetArray
1913  01ff 89            	pushw	x
1914  0200 c60002        	ld	a,_stored_draddr+2
1918  0203 cc0286        	jp	LC001
1919  0206               L153:
1920                     ; 2038 	    case 6:  emb_itoa(stored_draddr[1],   OctetArray, 10, 3); break;
1922  0206 4b03          	push	#3
1923  0208 4b0a          	push	#10
1924  020a ae0045        	ldw	x,#_OctetArray
1925  020d 89            	pushw	x
1926  020e c60001        	ld	a,_stored_draddr+1
1930  0211 2073          	jp	LC001
1931  0213               L353:
1932                     ; 2039 	    case 7:  emb_itoa(stored_draddr[0],   OctetArray, 10, 3); break;
1934  0213 4b03          	push	#3
1935  0215 4b0a          	push	#10
1936  0217 ae0045        	ldw	x,#_OctetArray
1937  021a 89            	pushw	x
1938  021b c60000        	ld	a,_stored_draddr
1942  021e 2066          	jp	LC001
1943  0220               L553:
1944                     ; 2040 	    case 8:  emb_itoa(stored_netmask[3],  OctetArray, 10, 3); break;
1946  0220 4b03          	push	#3
1947  0222 4b0a          	push	#10
1948  0224 ae0045        	ldw	x,#_OctetArray
1949  0227 89            	pushw	x
1950  0228 c60003        	ld	a,_stored_netmask+3
1954  022b 2059          	jp	LC001
1955  022d               L753:
1956                     ; 2041 	    case 9:  emb_itoa(stored_netmask[2],  OctetArray, 10, 3); break;
1958  022d 4b03          	push	#3
1959  022f 4b0a          	push	#10
1960  0231 ae0045        	ldw	x,#_OctetArray
1961  0234 89            	pushw	x
1962  0235 c60002        	ld	a,_stored_netmask+2
1966  0238 204c          	jp	LC001
1967  023a               L163:
1968                     ; 2042 	    case 10: emb_itoa(stored_netmask[1],  OctetArray, 10, 3); break;
1970  023a 4b03          	push	#3
1971  023c 4b0a          	push	#10
1972  023e ae0045        	ldw	x,#_OctetArray
1973  0241 89            	pushw	x
1974  0242 c60001        	ld	a,_stored_netmask+1
1978  0245 203f          	jp	LC001
1979  0247               L363:
1980                     ; 2043 	    case 11: emb_itoa(stored_netmask[0],  OctetArray, 10, 3); break;
1982  0247 4b03          	push	#3
1983  0249 4b0a          	push	#10
1984  024b ae0045        	ldw	x,#_OctetArray
1985  024e 89            	pushw	x
1986  024f c60000        	ld	a,_stored_netmask
1990  0252 2032          	jp	LC001
1991  0254               L563:
1992                     ; 2045 	    case 12: emb_itoa(stored_mqttserveraddr[3], OctetArray, 10, 3); break;
1994  0254 4b03          	push	#3
1995  0256 4b0a          	push	#10
1996  0258 ae0045        	ldw	x,#_OctetArray
1997  025b 89            	pushw	x
1998  025c c60003        	ld	a,_stored_mqttserveraddr+3
2002  025f 2025          	jp	LC001
2003  0261               L763:
2004                     ; 2046 	    case 13: emb_itoa(stored_mqttserveraddr[2], OctetArray, 10, 3); break;
2006  0261 4b03          	push	#3
2007  0263 4b0a          	push	#10
2008  0265 ae0045        	ldw	x,#_OctetArray
2009  0268 89            	pushw	x
2010  0269 c60002        	ld	a,_stored_mqttserveraddr+2
2014  026c 2018          	jp	LC001
2015  026e               L173:
2016                     ; 2047 	    case 14: emb_itoa(stored_mqttserveraddr[1], OctetArray, 10, 3); break;
2018  026e 4b03          	push	#3
2019  0270 4b0a          	push	#10
2020  0272 ae0045        	ldw	x,#_OctetArray
2021  0275 89            	pushw	x
2022  0276 c60001        	ld	a,_stored_mqttserveraddr+1
2026  0279 200b          	jp	LC001
2027  027b               L373:
2028                     ; 2048 	    case 15: emb_itoa(stored_mqttserveraddr[0], OctetArray, 10, 3); break;
2030  027b 4b03          	push	#3
2031  027d 4b0a          	push	#10
2032  027f ae0045        	ldw	x,#_OctetArray
2033  0282 89            	pushw	x
2034  0283 c60000        	ld	a,_stored_mqttserveraddr
2036  0286               LC001:
2037  0286 b703          	ld	c_lreg+3,a
2038  0288 3f02          	clr	c_lreg+2
2039  028a 3f01          	clr	c_lreg+1
2040  028c 3f00          	clr	c_lreg
2041  028e be02          	ldw	x,c_lreg+2
2042  0290 89            	pushw	x
2043  0291 be00          	ldw	x,c_lreg
2044  0293 89            	pushw	x
2045  0294 cd0000        	call	_emb_itoa
2046  0297 5b08          	addw	sp,#8
2049                     ; 2050 	    default: break;
2051  0299               L506:
2052                     ; 2054 	  for(i=0; i<3; i++) {
2054  0299 4f            	clr	a
2055  029a 6b08          	ld	(OFST+0,sp),a
2057  029c               L706:
2058                     ; 2055 	    *pBuffer = (uint8_t)OctetArray[i];
2060  029c 5f            	clrw	x
2061  029d 97            	ld	xl,a
2062  029e d60045        	ld	a,(_OctetArray,x)
2063  02a1 1e09          	ldw	x,(OFST+1,sp)
2064  02a3 f7            	ld	(x),a
2065                     ; 2056             pBuffer++;
2067  02a4 5c            	incw	x
2068  02a5 1f09          	ldw	(OFST+1,sp),x
2069                     ; 2054 	  for(i=0; i<3; i++) {
2071  02a7 0c08          	inc	(OFST+0,sp)
2075  02a9 7b08          	ld	a,(OFST+0,sp)
2076  02ab a103          	cp	a,#3
2077  02ad 25ed          	jrult	L706
2078                     ; 2058 	  nBytes += 3;
2080  02af 1e05          	ldw	x,(OFST-3,sp)
2081  02b1 1c0003        	addw	x,#3
2083  02b4 cc0568        	jp	LC005
2084  02b7               L106:
2085                     ; 2061         else if (nParsedMode == 'c') {
2087  02b7 a163          	cp	a,#99
2088  02b9 2648          	jrne	L716
2089                     ; 2070 	  if (nParsedNum == 0) emb_itoa(stored_port, OctetArray, 10, 5);
2091  02bb 7b07          	ld	a,(OFST-1,sp)
2092  02bd 260d          	jrne	L126
2095  02bf 4b05          	push	#5
2096  02c1 4b0a          	push	#10
2097  02c3 ae0045        	ldw	x,#_OctetArray
2098  02c6 89            	pushw	x
2099  02c7 ce0000        	ldw	x,_stored_port
2103  02ca 200b          	jra	L326
2104  02cc               L126:
2105                     ; 2072 	  else emb_itoa(stored_mqttport, OctetArray, 10, 5);
2107  02cc 4b05          	push	#5
2108  02ce 4b0a          	push	#10
2109  02d0 ae0045        	ldw	x,#_OctetArray
2110  02d3 89            	pushw	x
2111  02d4 ce0000        	ldw	x,_stored_mqttport
2114  02d7               L326:
2115  02d7 cd0000        	call	c_uitolx
2116  02da be02          	ldw	x,c_lreg+2
2117  02dc 89            	pushw	x
2118  02dd be00          	ldw	x,c_lreg
2119  02df 89            	pushw	x
2120  02e0 cd0000        	call	_emb_itoa
2121  02e3 5b08          	addw	sp,#8
2122                     ; 2076 	  for(i=0; i<5; i++) {
2124  02e5 4f            	clr	a
2125  02e6 6b08          	ld	(OFST+0,sp),a
2127  02e8               L526:
2128                     ; 2077             *pBuffer = (uint8_t)OctetArray[i];
2130  02e8 5f            	clrw	x
2131  02e9 97            	ld	xl,a
2132  02ea d60045        	ld	a,(_OctetArray,x)
2133  02ed 1e09          	ldw	x,(OFST+1,sp)
2134  02ef f7            	ld	(x),a
2135                     ; 2078             pBuffer++;
2137  02f0 5c            	incw	x
2138  02f1 1f09          	ldw	(OFST+1,sp),x
2139                     ; 2076 	  for(i=0; i<5; i++) {
2141  02f3 0c08          	inc	(OFST+0,sp)
2145  02f5 7b08          	ld	a,(OFST+0,sp)
2146  02f7 a105          	cp	a,#5
2147  02f9 25ed          	jrult	L526
2148                     ; 2080 	  nBytes += 5;
2150  02fb 1e05          	ldw	x,(OFST-3,sp)
2151  02fd 1c0005        	addw	x,#5
2153  0300 cc0568        	jp	LC005
2154  0303               L716:
2155                     ; 2083         else if (nParsedMode == 'd') {
2157  0303 a164          	cp	a,#100
2158  0305 266b          	jrne	L536
2159                     ; 2088 	  if (nParsedNum == 0) { OctetArray[0] = mac_string[0]; OctetArray[1] = mac_string[1]; }
2161  0307 7b07          	ld	a,(OFST-1,sp)
2162  0309 260a          	jrne	L736
2165  030b 5500000045    	mov	_OctetArray,_mac_string
2168  0310 5500010046    	mov	_OctetArray+1,_mac_string+1
2169  0315               L736:
2170                     ; 2089 	  if (nParsedNum == 1) { OctetArray[0] = mac_string[2]; OctetArray[1] = mac_string[3]; }
2172  0315 a101          	cp	a,#1
2173  0317 260a          	jrne	L146
2176  0319 5500020045    	mov	_OctetArray,_mac_string+2
2179  031e 5500030046    	mov	_OctetArray+1,_mac_string+3
2180  0323               L146:
2181                     ; 2090 	  if (nParsedNum == 2) { OctetArray[0] = mac_string[4]; OctetArray[1] = mac_string[5]; }
2183  0323 a102          	cp	a,#2
2184  0325 260a          	jrne	L346
2187  0327 5500040045    	mov	_OctetArray,_mac_string+4
2190  032c 5500050046    	mov	_OctetArray+1,_mac_string+5
2191  0331               L346:
2192                     ; 2091 	  if (nParsedNum == 3) { OctetArray[0] = mac_string[6]; OctetArray[1] = mac_string[7]; }
2194  0331 a103          	cp	a,#3
2195  0333 260a          	jrne	L546
2198  0335 5500060045    	mov	_OctetArray,_mac_string+6
2201  033a 5500070046    	mov	_OctetArray+1,_mac_string+7
2202  033f               L546:
2203                     ; 2092 	  if (nParsedNum == 4) { OctetArray[0] = mac_string[8]; OctetArray[1] = mac_string[9]; }
2205  033f a104          	cp	a,#4
2206  0341 260a          	jrne	L746
2209  0343 5500080045    	mov	_OctetArray,_mac_string+8
2212  0348 5500090046    	mov	_OctetArray+1,_mac_string+9
2213  034d               L746:
2214                     ; 2093 	  if (nParsedNum == 5) { OctetArray[0] = mac_string[10]; OctetArray[1] = mac_string[11]; }
2216  034d a105          	cp	a,#5
2217  034f 260a          	jrne	L156
2220  0351 55000a0045    	mov	_OctetArray,_mac_string+10
2223  0356 55000b0046    	mov	_OctetArray+1,_mac_string+11
2224  035b               L156:
2225                     ; 2095           *pBuffer = OctetArray[0];
2227  035b 1e09          	ldw	x,(OFST+1,sp)
2228  035d c60045        	ld	a,_OctetArray
2229  0360 f7            	ld	(x),a
2230                     ; 2096           pBuffer++;
2232  0361 5c            	incw	x
2233  0362 1f09          	ldw	(OFST+1,sp),x
2234                     ; 2097           nBytes++;
2236  0364 1e05          	ldw	x,(OFST-3,sp)
2237  0366 5c            	incw	x
2238  0367 1f05          	ldw	(OFST-3,sp),x
2240                     ; 2099           *pBuffer = OctetArray[1];
2242  0369 c60046        	ld	a,_OctetArray+1
2243  036c 1e09          	ldw	x,(OFST+1,sp)
2244  036e               LC008:
2245  036e f7            	ld	(x),a
2246                     ; 2100           pBuffer++;
2247                     ; 2101           nBytes++;
2249  036f cc0562        	jp	LC006
2250  0372               L536:
2251                     ; 2187         else if (nParsedMode == 'f') {
2253  0372 a166          	cp	a,#102
2254  0374 263d          	jrne	L556
2255                     ; 2202 	  for(i=0; i<16; i++) {
2257  0376 4f            	clr	a
2258  0377 6b08          	ld	(OFST+0,sp),a
2260  0379               L756:
2261                     ; 2203             if (i > 7) {
2263  0379 a108          	cp	a,#8
2264  037b 251b          	jrult	L566
2265                     ; 2205               j = GpioGetPin(i);
2267  037d cd0000        	call	_GpioGetPin
2269  0380 6b03          	ld	(OFST-5,sp),a
2271                     ; 2206               if (invert_input == 0x00) *pBuffer = (uint8_t)(j + '0');
2273  0382 725d0000      	tnz	_invert_input
2276  0386 2713          	jreq	LC010
2277                     ; 2208                 if (j == 0) *pBuffer = (uint8_t)('1'); 
2279  0388 7b03          	ld	a,(OFST-5,sp)
2280  038a 2606          	jrne	L376
2283  038c 1e09          	ldw	x,(OFST+1,sp)
2284  038e a631          	ld	a,#49
2286  0390 200d          	jra	L776
2287  0392               L376:
2288                     ; 2209                 else *pBuffer = (uint8_t)('0');
2290  0392 1e09          	ldw	x,(OFST+1,sp)
2291  0394 a630          	ld	a,#48
2292                     ; 2211               pBuffer++;
2294  0396 2007          	jra	L776
2295  0398               L566:
2296                     ; 2215               *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
2298  0398 cd0000        	call	_GpioGetPin
2300  039b               LC010:
2302  039b ab30          	add	a,#48
2303  039d 1e09          	ldw	x,(OFST+1,sp)
2304                     ; 2216               pBuffer++;
2306  039f               L776:
2307  039f f7            	ld	(x),a
2309  03a0 5c            	incw	x
2310  03a1 1f09          	ldw	(OFST+1,sp),x
2311                     ; 2202 	  for(i=0; i<16; i++) {
2313  03a3 0c08          	inc	(OFST+0,sp)
2317  03a5 7b08          	ld	a,(OFST+0,sp)
2318  03a7 a110          	cp	a,#16
2319  03a9 25ce          	jrult	L756
2320                     ; 2219 	  nBytes += 16;
2322  03ab 1e05          	ldw	x,(OFST-3,sp)
2323  03ad 1c0010        	addw	x,#16
2325  03b0 cc0568        	jp	LC005
2326  03b3               L556:
2327                     ; 2238 else if (nParsedMode == 'g') {
2329  03b3 a167          	cp	a,#103
2330  03b5 261e          	jrne	L307
2331                     ; 2251 	  for(i = 0; i < 6; i++) {
2333  03b7 4f            	clr	a
2334  03b8 6b08          	ld	(OFST+0,sp),a
2336  03ba               L507:
2337                     ; 2252             *pBuffer = stored_config_settings[i];
2339  03ba 5f            	clrw	x
2340  03bb 97            	ld	xl,a
2341  03bc d60000        	ld	a,(_stored_config_settings,x)
2342  03bf 1e09          	ldw	x,(OFST+1,sp)
2343  03c1 f7            	ld	(x),a
2344                     ; 2253             pBuffer++;
2346  03c2 5c            	incw	x
2347  03c3 1f09          	ldw	(OFST+1,sp),x
2348                     ; 2251 	  for(i = 0; i < 6; i++) {
2350  03c5 0c08          	inc	(OFST+0,sp)
2354  03c7 7b08          	ld	a,(OFST+0,sp)
2355  03c9 a106          	cp	a,#6
2356  03cb 25ed          	jrult	L507
2357                     ; 2255           nBytes += 6;
2359  03cd 1e05          	ldw	x,(OFST-3,sp)
2360  03cf 1c0006        	addw	x,#6
2362  03d2 cc0568        	jp	LC005
2363  03d5               L307:
2364                     ; 2259         else if (nParsedMode == 'l') {
2366  03d5 a16c          	cp	a,#108
2367  03d7 2629          	jrne	L517
2368                     ; 2262           for(i=0; i<10; i++) {
2370  03d9 4f            	clr	a
2371  03da 6b08          	ld	(OFST+0,sp),a
2373  03dc               L717:
2374                     ; 2263 	    if (stored_mqtt_username[i] != '\0') {
2376  03dc 5f            	clrw	x
2377  03dd 97            	ld	xl,a
2378  03de 724d0000      	tnz	(_stored_mqtt_username,x)
2379  03e2 2603cc056a    	jreq	L505
2380                     ; 2264               *pBuffer = (uint8_t)(stored_mqtt_username[i]);
2382  03e7 5f            	clrw	x
2383  03e8 97            	ld	xl,a
2384  03e9 d60000        	ld	a,(_stored_mqtt_username,x)
2385  03ec 1e09          	ldw	x,(OFST+1,sp)
2386  03ee f7            	ld	(x),a
2387                     ; 2265               pBuffer++;
2389  03ef 5c            	incw	x
2390  03f0 1f09          	ldw	(OFST+1,sp),x
2391                     ; 2266               nBytes++;
2393  03f2 1e05          	ldw	x,(OFST-3,sp)
2394  03f4 5c            	incw	x
2395  03f5 1f05          	ldw	(OFST-3,sp),x
2398                     ; 2262           for(i=0; i<10; i++) {
2400  03f7 0c08          	inc	(OFST+0,sp)
2404  03f9 7b08          	ld	a,(OFST+0,sp)
2405  03fb a10a          	cp	a,#10
2406  03fd 25dd          	jrult	L717
2407  03ff cc056a        	jra	L505
2408  0402               L517:
2409                     ; 2272         else if (nParsedMode == 'm') {
2411  0402 a16d          	cp	a,#109
2412  0404 2626          	jrne	L337
2413                     ; 2275           for(i=0; i<10; i++) {
2415  0406 4f            	clr	a
2416  0407 6b08          	ld	(OFST+0,sp),a
2418  0409               L537:
2419                     ; 2276 	    if (stored_mqtt_password[i] != '\0') {
2421  0409 5f            	clrw	x
2422  040a 97            	ld	xl,a
2423  040b 724d0000      	tnz	(_stored_mqtt_password,x)
2424  040f 27ee          	jreq	L505
2425                     ; 2277               *pBuffer = (uint8_t)(stored_mqtt_password[i]);
2427  0411 5f            	clrw	x
2428  0412 97            	ld	xl,a
2429  0413 d60000        	ld	a,(_stored_mqtt_password,x)
2430  0416 1e09          	ldw	x,(OFST+1,sp)
2431  0418 f7            	ld	(x),a
2432                     ; 2278               pBuffer++;
2434  0419 5c            	incw	x
2435  041a 1f09          	ldw	(OFST+1,sp),x
2436                     ; 2279               nBytes++;
2438  041c 1e05          	ldw	x,(OFST-3,sp)
2439  041e 5c            	incw	x
2440  041f 1f05          	ldw	(OFST-3,sp),x
2443                     ; 2275           for(i=0; i<10; i++) {
2445  0421 0c08          	inc	(OFST+0,sp)
2449  0423 7b08          	ld	a,(OFST+0,sp)
2450  0425 a10a          	cp	a,#10
2451  0427 25e0          	jrult	L537
2452  0429 cc056a        	jra	L505
2453  042c               L337:
2454                     ; 2285         else if (nParsedMode == 'n') {
2456  042c a16e          	cp	a,#110
2457  042e 2657          	jrne	L157
2458                     ; 2289 	  no_err = 0;
2460  0430 0f08          	clr	(OFST+0,sp)
2462                     ; 2290           switch (nParsedNum)
2464  0432 7b07          	ld	a,(OFST-1,sp)
2466                     ; 2312 	    default:
2466                     ; 2313 	      break;
2467  0434 270e          	jreq	L773
2468  0436 4a            	dec	a
2469  0437 2712          	jreq	L104
2470  0439 4a            	dec	a
2471  043a 2716          	jreq	L304
2472  043c 4a            	dec	a
2473  043d 271a          	jreq	L504
2474  043f 4a            	dec	a
2475  0440 271f          	jreq	L704
2476  0442 2030          	jra	L557
2477  0444               L773:
2478                     ; 2292 	    case 0:
2478                     ; 2293               // Connection request status
2478                     ; 2294 	      if (mqtt_start_status & MQTT_START_CONNECTIONS_GOOD) no_err = 1;
2480  0444 720900002b    	btjf	_mqtt_start_status,#4,L557
2482  0449 2013          	jp	LC003
2483  044b               L104:
2484                     ; 2296 	    case 1:
2484                     ; 2297 	      // ARP request status
2484                     ; 2298 	      if (mqtt_start_status & MQTT_START_ARP_REQUEST_GOOD) no_err = 1;
2486  044b 720b000024    	btjf	_mqtt_start_status,#5,L557
2488  0450 200c          	jp	LC003
2489  0452               L304:
2490                     ; 2300 	    case 2:
2490                     ; 2301 	      // TCP connection status
2490                     ; 2302 	      if (mqtt_start_status & MQTT_START_TCP_CONNECT_GOOD) no_err = 1;
2492  0452 720d00001d    	btjf	_mqtt_start_status,#6,L557
2494  0457 2005          	jp	LC003
2495  0459               L504:
2496                     ; 2304 	    case 3:
2496                     ; 2305 	      // MQTT Connection status 1
2496                     ; 2306 	      if (mqtt_start_status & MQTT_START_MQTT_CONNECT_GOOD) no_err = 1;
2498  0459 720f000016    	btjf	_mqtt_start_status,#7,L557
2501  045e               LC003:
2505  045e 4c            	inc	a
2506  045f 2011          	jp	LC002
2507  0461               L704:
2508                     ; 2308 	    case 4:
2508                     ; 2309 	      // MQTT start complete with no errors
2508                     ; 2310 	      if ((MQTT_error_status == 1) && ((mqtt_start_status & 0xf0) == 0xf0) ) no_err = 1;
2510  0461 c60000        	ld	a,_MQTT_error_status
2511  0464 4a            	dec	a
2512  0465 260d          	jrne	L557
2514  0467 c60000        	ld	a,_mqtt_start_status
2515  046a a4f0          	and	a,#240
2516  046c a1f0          	cp	a,#240
2517  046e 2604          	jrne	L557
2520  0470 a601          	ld	a,#1
2521  0472               LC002:
2522  0472 6b08          	ld	(OFST+0,sp),a
2524                     ; 2312 	    default:
2524                     ; 2313 	      break;
2526  0474               L557:
2527                     ; 2315 	  if (no_err == 1) *pBuffer = '1'; // Paint a green square
2529  0474 7b08          	ld	a,(OFST+0,sp)
2530  0476 4a            	dec	a
2531  0477 2607          	jrne	L177
2534  0479               LC009:
2536  0479 1e09          	ldw	x,(OFST+1,sp)
2537  047b a631          	ld	a,#49
2539  047d cc036e        	jra	LC008
2540  0480               L177:
2541                     ; 2316 	  else *pBuffer = '0'; // Paint a red square
2543  0480 1e09          	ldw	x,(OFST+1,sp)
2544  0482 a630          	ld	a,#48
2545                     ; 2317           pBuffer++;
2546                     ; 2318           nBytes++;
2548  0484 cc036e        	jp	LC008
2549  0487               L157:
2550                     ; 2322         else if (nParsedMode == 'y') {
2552  0487 a179          	cp	a,#121
2553  0489 269e          	jrne	L505
2554                     ; 2367 	  i = insertion_flag[0];
2556  048b c60000        	ld	a,_insertion_flag
2557  048e 6b08          	ld	(OFST+0,sp),a
2559                     ; 2368 	  insertion_flag[1] = nParsedMode;
2561  0490 7b04          	ld	a,(OFST-4,sp)
2562  0492 c70001        	ld	_insertion_flag+1,a
2563                     ; 2369 	  insertion_flag[2] = nParsedNum;
2565  0495 7b07          	ld	a,(OFST-1,sp)
2566  0497 c70002        	ld	_insertion_flag+2,a
2567                     ; 2371           switch (nParsedNum)
2570                     ; 2419 	    default: break;
2571  049a 2718          	jreq	L314
2572  049c 4a            	dec	a
2573  049d 272a          	jreq	L514
2574  049f 4a            	dec	a
2575  04a0 273c          	jreq	L714
2576  04a2 4a            	dec	a
2577  04a3 274e          	jreq	L124
2578  04a5 4a            	dec	a
2579  04a6 2760          	jreq	L324
2580  04a8 4a            	dec	a
2581  04a9 2772          	jreq	L524
2582  04ab 4a            	dec	a
2583  04ac 2603cc0532    	jreq	L724
2584  04b1 cc0560        	jra	LC007
2585  04b4               L314:
2586                     ; 2373 	    case 0:
2586                     ; 2374 	      // %y00 replaced with string 
2586                     ; 2375 	      // page_string00[] = "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'";
2586                     ; 2376               *pBuffer = (uint8_t)page_string00[i];
2588  04b4 7b08          	ld	a,(OFST+0,sp)
2589  04b6 5f            	clrw	x
2590  04b7 97            	ld	xl,a
2591  04b8 d618cd        	ld	a,(L32_page_string00,x)
2592  04bb 1e09          	ldw	x,(OFST+1,sp)
2593  04bd f7            	ld	(x),a
2594                     ; 2377 	      insertion_flag[0]++;
2596  04be 725c0000      	inc	_insertion_flag
2597                     ; 2378 	      if (insertion_flag[0] == page_string00_len) insertion_flag[0] = 0;
2599  04c2 c60000        	ld	a,_insertion_flag
2600  04c5 a13f          	cp	a,#63
2602  04c7 207c          	jp	LC004
2603  04c9               L514:
2604                     ; 2380 	    case 1:
2604                     ; 2381 	      // %y01 replaced with string 
2604                     ; 2382               // page_string01[] = "pattern='[0-9a-f]{2}' title='Enter 00 to ff' maxlength='2'";
2604                     ; 2383               *pBuffer = (uint8_t)page_string01[i];
2606  04c9 7b08          	ld	a,(OFST+0,sp)
2607  04cb 5f            	clrw	x
2608  04cc 97            	ld	xl,a
2609  04cd d6190f        	ld	a,(L13_page_string01,x)
2610  04d0 1e09          	ldw	x,(OFST+1,sp)
2611  04d2 f7            	ld	(x),a
2612                     ; 2384 	      insertion_flag[0]++;
2614  04d3 725c0000      	inc	_insertion_flag
2615                     ; 2385 	      if (insertion_flag[0] == page_string01_len) insertion_flag[0] = 0;
2617  04d7 c60000        	ld	a,_insertion_flag
2618  04da a140          	cp	a,#64
2620  04dc 2067          	jp	LC004
2621  04de               L714:
2622                     ; 2387 	    case 2:
2622                     ; 2388 	      // %y02 replaced with string 
2622                     ; 2389               // page_string02[] = "<button title='Save first! This button will not save your changes'>";
2622                     ; 2390               *pBuffer = (uint8_t)page_string02[i];
2624  04de 7b08          	ld	a,(OFST+0,sp)
2625  04e0 5f            	clrw	x
2626  04e1 97            	ld	xl,a
2627  04e2 d61952        	ld	a,(L73_page_string02,x)
2628  04e5 1e09          	ldw	x,(OFST+1,sp)
2629  04e7 f7            	ld	(x),a
2630                     ; 2391 	      insertion_flag[0]++;
2632  04e8 725c0000      	inc	_insertion_flag
2633                     ; 2392 	      if (insertion_flag[0] == page_string02_len) insertion_flag[0] = 0;
2635  04ec c60000        	ld	a,_insertion_flag
2636  04ef a152          	cp	a,#82
2638  04f1 2052          	jp	LC004
2639  04f3               L124:
2640                     ; 2394 	    case 3:
2640                     ; 2395 	      // %y03 replaced with string 
2640                     ; 2396               // page_string03[] = "<form style='display: inline' action='http://";
2640                     ; 2397               *pBuffer = (uint8_t)page_string03[i];
2642  04f3 7b08          	ld	a,(OFST+0,sp)
2643  04f5 5f            	clrw	x
2644  04f6 97            	ld	xl,a
2645  04f7 d619a7        	ld	a,(L54_page_string03,x)
2646  04fa 1e09          	ldw	x,(OFST+1,sp)
2647  04fc f7            	ld	(x),a
2648                     ; 2398 	      insertion_flag[0]++;
2650  04fd 725c0000      	inc	_insertion_flag
2651                     ; 2399 	      if (insertion_flag[0] == page_string03_len) insertion_flag[0] = 0;
2653  0501 c60000        	ld	a,_insertion_flag
2654  0504 a126          	cp	a,#38
2656  0506 203d          	jp	LC004
2657  0508               L324:
2658                     ; 2401 	    case 4:
2658                     ; 2402 	      // %y04 replaced with first header string 
2658                     ; 2403               *pBuffer = (uint8_t)page_string04[i];
2660  0508 7b08          	ld	a,(OFST+0,sp)
2661  050a 5f            	clrw	x
2662  050b 97            	ld	xl,a
2663  050c d619d0        	ld	a,(L35_page_string04,x)
2664  050f 1e09          	ldw	x,(OFST+1,sp)
2665  0511 f7            	ld	(x),a
2666                     ; 2404 	      insertion_flag[0]++;
2668  0512 725c0000      	inc	_insertion_flag
2669                     ; 2405 	      if (insertion_flag[0] == page_string04_len) insertion_flag[0] = 0;
2671  0516 c60000        	ld	a,_insertion_flag
2672  0519 a147          	cp	a,#71
2674  051b 2028          	jp	LC004
2675  051d               L524:
2676                     ; 2407 	    case 5:
2676                     ; 2408 	      // %y05 replaced with second header string 
2676                     ; 2409               *pBuffer = (uint8_t)page_string05[i];
2678  051d 7b08          	ld	a,(OFST+0,sp)
2679  051f 5f            	clrw	x
2680  0520 97            	ld	xl,a
2681  0521 d61a1a        	ld	a,(L16_page_string05,x)
2682  0524 1e09          	ldw	x,(OFST+1,sp)
2683  0526 f7            	ld	(x),a
2684                     ; 2410 	      insertion_flag[0]++;
2686  0527 725c0000      	inc	_insertion_flag
2687                     ; 2411 	      if (insertion_flag[0] == page_string05_len) insertion_flag[0] = 0;
2689  052b c60000        	ld	a,_insertion_flag
2690  052e a1ed          	cp	a,#237
2692  0530 2013          	jp	LC004
2693  0532               L724:
2694                     ; 2413 	    case 6:
2694                     ; 2414 	      // %y06 replaced with third header string 
2694                     ; 2415               *pBuffer = (uint8_t)page_string06[i];
2696  0532 7b08          	ld	a,(OFST+0,sp)
2697  0534 5f            	clrw	x
2698  0535 97            	ld	xl,a
2699  0536 d61b0a        	ld	a,(L76_page_string06,x)
2700  0539 1e09          	ldw	x,(OFST+1,sp)
2701  053b f7            	ld	(x),a
2702                     ; 2416 	      insertion_flag[0]++;
2704  053c 725c0000      	inc	_insertion_flag
2705                     ; 2417 	      if (insertion_flag[0] == page_string06_len) insertion_flag[0] = 0;
2707  0540 c60000        	ld	a,_insertion_flag
2708  0543 a13b          	cp	a,#59
2711  0545               LC004:
2712  0545 2619          	jrne	LC007
2719  0547 725f0000      	clr	_insertion_flag
2720                     ; 2419 	    default: break;
2722                     ; 2421           pBuffer++;
2723                     ; 2422           nBytes++;
2724  054b 2013          	jp	LC007
2725  054d               L125:
2726                     ; 2430         *pBuffer = nByte;
2728  054d 1e09          	ldw	x,(OFST+1,sp)
2729  054f f7            	ld	(x),a
2730                     ; 2431         *ppData = *ppData + 1;
2732  0550 1e0d          	ldw	x,(OFST+5,sp)
2733  0552 9093          	ldw	y,x
2734  0554 fe            	ldw	x,(x)
2735  0555 5c            	incw	x
2736  0556 90ff          	ldw	(y),x
2737                     ; 2432         *pDataLeft = *pDataLeft - 1;
2739  0558 1e0f          	ldw	x,(OFST+7,sp)
2740  055a 9093          	ldw	y,x
2741  055c fe            	ldw	x,(x)
2742  055d 5a            	decw	x
2743  055e 90ff          	ldw	(y),x
2744                     ; 2433         pBuffer++;
2746  0560               LC007:
2748  0560 1e09          	ldw	x,(OFST+1,sp)
2749                     ; 2434         nBytes++;
2751  0562               LC006:
2756  0562 5c            	incw	x
2757  0563 1f09          	ldw	(OFST+1,sp),x
2763  0565 1e05          	ldw	x,(OFST-3,sp)
2764  0567 5c            	incw	x
2765  0568               LC005:
2766  0568 1f05          	ldw	(OFST-3,sp),x
2768  056a               L505:
2769                     ; 1808   while (nBytes < nMaxBytes) {
2771  056a 1e05          	ldw	x,(OFST-3,sp)
2772  056c 1311          	cpw	x,(OFST+9,sp)
2773  056e 2403cc0012    	jrult	L305
2774  0573               L705:
2775                     ; 2439   return nBytes;
2777  0573 1e05          	ldw	x,(OFST-3,sp)
2780  0575 5b0a          	addw	sp,#10
2781  0577 81            	ret	
2813                     ; 2443 void HttpDInit()
2813                     ; 2444 {
2814                     .text:	section	.text,new
2815  0000               _HttpDInit:
2819                     ; 2446   uip_listen(htons(Port_Httpd));
2821  0000 ce0000        	ldw	x,_Port_Httpd
2822  0003 cd0000        	call	_htons
2824  0006 cd0000        	call	_uip_listen
2826                     ; 2447   current_webpage = WEBPAGE_IOCONTROL;
2828  0009 725f0003      	clr	_current_webpage
2829                     ; 2450   insertion_flag[0] = 0;
2831  000d 725f0000      	clr	_insertion_flag
2832                     ; 2451   insertion_flag[1] = 0;
2834  0011 725f0001      	clr	_insertion_flag+1
2835                     ; 2452   insertion_flag[2] = 0;
2837  0015 725f0002      	clr	_insertion_flag+2
2838                     ; 2455   saved_nstate = STATE_NULL;
2840  0019 357f0044      	mov	_saved_nstate,#127
2841                     ; 2456   saved_parsestate = PARSE_CMD;
2843  001d 725f0043      	clr	_saved_parsestate
2844                     ; 2457   saved_nparseleft = 0;
2846  0021 725f0042      	clr	_saved_nparseleft
2847                     ; 2458   clear_saved_postpartial_all();
2850                     ; 2459 }
2853  0025 cc0000        	jp	_clear_saved_postpartial_all
3044                     	switch	.const
3045  1b68               L412:
3046  1b68 08ae          	dc.w	L3401
3047  1b6a 08b9          	dc.w	L5401
3048  1b6c 08c4          	dc.w	L7401
3049  1b6e 08cf          	dc.w	L1501
3050  1b70 08da          	dc.w	L3501
3051  1b72 08e5          	dc.w	L5501
3052  1b74 08f0          	dc.w	L7501
3053  1b76 08fb          	dc.w	L1601
3054  1b78 0906          	dc.w	L3601
3055  1b7a 0911          	dc.w	L5601
3056  1b7c 091c          	dc.w	L7601
3057  1b7e 0927          	dc.w	L1701
3058  1b80 0932          	dc.w	L3701
3059  1b82 093d          	dc.w	L5701
3060  1b84 0948          	dc.w	L7701
3061  1b86 0953          	dc.w	L1011
3062                     ; 2462 void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
3062                     ; 2463 {
3063                     .text:	section	.text,new
3064  0000               _HttpDCall:
3066  0000 89            	pushw	x
3067  0001 5204          	subw	sp,#4
3068       00000004      OFST:	set	4
3071                     ; 2467   i = 0;
3073  0003 0f04          	clr	(OFST+0,sp)
3075                     ; 2469   if (uip_connected()) {
3077  0005 720d000055    	btjf	_uip_flags,#6,L5121
3078                     ; 2471     if (current_webpage == WEBPAGE_IOCONTROL) {
3080  000a c60003        	ld	a,_current_webpage
3081  000d 260e          	jrne	L7121
3082                     ; 2472       pSocket->pData = g_HtmlPageIOControl;
3084  000f 1e0b          	ldw	x,(OFST+7,sp)
3085  0011 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
3086  0015 ef01          	ldw	(1,x),y
3087                     ; 2473       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
3089  0017 90ae0c06      	ldw	y,#3078
3091  001b 2034          	jp	LC011
3092  001d               L7121:
3093                     ; 2477     else if (current_webpage == WEBPAGE_CONFIGURATION) {
3095  001d a101          	cp	a,#1
3096  001f 260e          	jrne	L3221
3097                     ; 2478       pSocket->pData = g_HtmlPageConfiguration;
3099  0021 1e0b          	ldw	x,(OFST+7,sp)
3100  0023 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
3101  0027 ef01          	ldw	(1,x),y
3102                     ; 2479       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
3104  0029 90ae0c31      	ldw	y,#3121
3106  002d 2022          	jp	LC011
3107  002f               L3221:
3108                     ; 2500     else if (current_webpage == WEBPAGE_RSTATE) {
3110  002f a106          	cp	a,#6
3111  0031 260e          	jrne	L7221
3112                     ; 2501       pSocket->pData = g_HtmlPageRstate;
3114  0033 1e0b          	ldw	x,(OFST+7,sp)
3115  0035 90ae1841      	ldw	y,#L71_g_HtmlPageRstate
3116  0039 ef01          	ldw	(1,x),y
3117                     ; 2502       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
3119  003b 90ae0086      	ldw	y,#134
3121  003f 2010          	jp	LC011
3122  0041               L7221:
3123                     ; 2505     else if (current_webpage == WEBPAGE_SSTATE) {
3125  0041 a107          	cp	a,#7
3126  0043 260e          	jrne	L1221
3127                     ; 2506       pSocket->pData = g_HtmlPageSstate;
3129  0045 1e0b          	ldw	x,(OFST+7,sp)
3130  0047 90ae18c8      	ldw	y,#L12_g_HtmlPageSstate
3131  004b ef01          	ldw	(1,x),y
3132                     ; 2507       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
3134  004d 90ae0004      	ldw	y,#4
3135  0051               LC011:
3136  0051 ef03          	ldw	(3,x),y
3137  0053               L1221:
3138                     ; 2510     pSocket->nState = STATE_CONNECTED;
3140  0053 1e0b          	ldw	x,(OFST+7,sp)
3141                     ; 2511     pSocket->nPrevBytes = 0xFFFF;
3143  0055 90aeffff      	ldw	y,#65535
3144  0059 7f            	clr	(x)
3145  005a ef0b          	ldw	(11,x),y
3147  005c cc012f        	jra	L242
3148  005f               L5121:
3149                     ; 2520   else if (uip_newdata() || uip_acked()) {
3151  005f 7202000008    	btjt	_uip_flags,#1,L1421
3153  0064 7200000003cc  	btjf	_uip_flags,#0,L7321
3154  006c               L1421:
3155                     ; 2521     if (uip_acked()) {
3157  006c 7201000003cc  	btjt	_uip_flags,#0,L5211
3158                     ; 2524       goto senddata;
3160                     ; 2594     if (saved_nstate != STATE_NULL) {
3162  0074 c60044        	ld	a,_saved_nstate
3163  0077 a17f          	cp	a,#127
3164  0079 2603cc00fb    	jreq	L3721
3165                     ; 2600       pSocket->nState = saved_nstate;
3167  007e 1e0b          	ldw	x,(OFST+7,sp)
3168  0080 f7            	ld	(x),a
3169                     ; 2607       pSocket->ParseState = saved_parsestate;
3171  0081 c60043        	ld	a,_saved_parsestate
3172  0084 e70a          	ld	(10,x),a
3173                     ; 2611       pSocket->nParseLeft = saved_nparseleft;
3175  0086 c60042        	ld	a,_saved_nparseleft
3176  0089 e706          	ld	(6,x),a
3177                     ; 2613       pSocket->nNewlines = saved_newlines;
3179  008b c60011        	ld	a,_saved_newlines
3180  008e e705          	ld	(5,x),a
3181                     ; 2625       for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i];
3183  0090 4f            	clr	a
3184  0091 6b04          	ld	(OFST+0,sp),a
3186  0093               L7421:
3189  0093 5f            	clrw	x
3190  0094 97            	ld	xl,a
3191  0095 d6002a        	ld	a,(_saved_postpartial,x)
3192  0098 d70012        	ld	(_saved_postpartial_previous,x),a
3195  009b 0c04          	inc	(OFST+0,sp)
3199  009d 7b04          	ld	a,(OFST+0,sp)
3200  009f a118          	cp	a,#24
3201  00a1 25f0          	jrult	L7421
3202                     ; 2630       if (saved_nstate == STATE_PARSEPOST) {
3204  00a3 c60044        	ld	a,_saved_nstate
3205  00a6 a10a          	cp	a,#10
3206  00a8 2651          	jrne	L3721
3207                     ; 2631         if (saved_parsestate == PARSE_CMD) {
3209  00aa c60043        	ld	a,_saved_parsestate
3210  00ad 274c          	jreq	L3721
3212                     ; 2634         else if (saved_parsestate == PARSE_NUM10) {
3214  00af a101          	cp	a,#1
3215  00b1 2609          	jrne	L3621
3216                     ; 2636 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3218  00b3 1e0b          	ldw	x,(OFST+7,sp)
3219  00b5 c60012        	ld	a,_saved_postpartial_previous
3220  00b8 e708          	ld	(8,x),a
3222  00ba 203f          	jra	L3721
3223  00bc               L3621:
3224                     ; 2638         else if (saved_parsestate == PARSE_NUM1) {
3226  00bc a102          	cp	a,#2
3227  00be 2615          	jrne	L7621
3228                     ; 2640 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3230  00c0 1e0b          	ldw	x,(OFST+7,sp)
3231  00c2 c60012        	ld	a,_saved_postpartial_previous
3232  00c5 e708          	ld	(8,x),a
3233                     ; 2641           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3235  00c7 c60013        	ld	a,_saved_postpartial_previous+1
3236  00ca 97            	ld	xl,a
3237  00cb a60a          	ld	a,#10
3238  00cd 42            	mul	x,a
3239  00ce 9f            	ld	a,xl
3240  00cf a0e0          	sub	a,#224
3241  00d1 1e0b          	ldw	x,(OFST+7,sp)
3243  00d3 2024          	jp	LC012
3244  00d5               L7621:
3245                     ; 2643         else if (saved_parsestate == PARSE_EQUAL || saved_parsestate == PARSE_VAL) {
3247  00d5 a103          	cp	a,#3
3248  00d7 2704          	jreq	L5721
3250  00d9 a104          	cp	a,#4
3251  00db 261e          	jrne	L3721
3252  00dd               L5721:
3253                     ; 2645 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3255  00dd 1e0b          	ldw	x,(OFST+7,sp)
3256  00df c60012        	ld	a,_saved_postpartial_previous
3257  00e2 e708          	ld	(8,x),a
3258                     ; 2646           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3260  00e4 c60013        	ld	a,_saved_postpartial_previous+1
3261  00e7 97            	ld	xl,a
3262  00e8 a60a          	ld	a,#10
3263  00ea 42            	mul	x,a
3264  00eb 9f            	ld	a,xl
3265  00ec 1e0b          	ldw	x,(OFST+7,sp)
3266  00ee a0e0          	sub	a,#224
3267  00f0 e709          	ld	(9,x),a
3268                     ; 2647           pSocket->ParseNum += (uint8_t)(saved_postpartial_previous[2] - '0');
3270  00f2 c60014        	ld	a,_saved_postpartial_previous+2
3271  00f5 a030          	sub	a,#48
3272  00f7 eb09          	add	a,(9,x)
3273  00f9               LC012:
3274  00f9 e709          	ld	(9,x),a
3276  00fb               L3721:
3277                     ; 2649 	else if (saved_parsestate == PARSE_DELIM) {
3279                     ; 2669     if (pSocket->nState == STATE_CONNECTED) {
3281  00fb 1e0b          	ldw	x,(OFST+7,sp)
3282  00fd f6            	ld	a,(x)
3283  00fe 2627          	jrne	L3031
3284                     ; 2670       if (nBytes == 0) return;
3286  0100 1e09          	ldw	x,(OFST+5,sp)
3287  0102 272b          	jreq	L242
3290                     ; 2671       if (*pBuffer == 'G') {
3292  0104 1e05          	ldw	x,(OFST+1,sp)
3293  0106 f6            	ld	a,(x)
3294  0107 a147          	cp	a,#71
3295  0109 2606          	jrne	L7031
3296                     ; 2672         pSocket->nState = STATE_GET_G;
3298  010b 1e0b          	ldw	x,(OFST+7,sp)
3299  010d a601          	ld	a,#1
3301  010f 2008          	jp	LC013
3302  0111               L7031:
3303                     ; 2674       else if (*pBuffer == 'P') {
3305  0111 a150          	cp	a,#80
3306  0113 2605          	jrne	L1131
3307                     ; 2675         pSocket->nState = STATE_POST_P;
3309  0115 1e0b          	ldw	x,(OFST+7,sp)
3310  0117 a604          	ld	a,#4
3311  0119               LC013:
3312  0119 f7            	ld	(x),a
3313  011a               L1131:
3314                     ; 2677       nBytes--;
3316  011a 1e09          	ldw	x,(OFST+5,sp)
3317  011c 5a            	decw	x
3318  011d 1f09          	ldw	(OFST+5,sp),x
3319                     ; 2678       pBuffer++;
3321  011f 1e05          	ldw	x,(OFST+1,sp)
3322  0121 5c            	incw	x
3323  0122 1f05          	ldw	(OFST+1,sp),x
3324  0124 1e0b          	ldw	x,(OFST+7,sp)
3325  0126 f6            	ld	a,(x)
3326  0127               L3031:
3327                     ; 2681     if (pSocket->nState == STATE_GET_G) {
3329  0127 a101          	cp	a,#1
3330  0129 2620          	jrne	L5131
3331                     ; 2682       if (nBytes == 0) return;
3333  012b 1e09          	ldw	x,(OFST+5,sp)
3334  012d 2603          	jrne	L7131
3336  012f               L242:
3339  012f 5b06          	addw	sp,#6
3340  0131 81            	ret	
3341  0132               L7131:
3342                     ; 2683       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
3344  0132 1e05          	ldw	x,(OFST+1,sp)
3345  0134 f6            	ld	a,(x)
3346  0135 a145          	cp	a,#69
3347  0137 2605          	jrne	L1231
3350  0139 1e0b          	ldw	x,(OFST+7,sp)
3351  013b a602          	ld	a,#2
3352  013d f7            	ld	(x),a
3353  013e               L1231:
3354                     ; 2684       nBytes--;
3356  013e 1e09          	ldw	x,(OFST+5,sp)
3357  0140 5a            	decw	x
3358  0141 1f09          	ldw	(OFST+5,sp),x
3359                     ; 2685       pBuffer++;
3361  0143 1e05          	ldw	x,(OFST+1,sp)
3362  0145 5c            	incw	x
3363  0146 1f05          	ldw	(OFST+1,sp),x
3364  0148 1e0b          	ldw	x,(OFST+7,sp)
3365  014a f6            	ld	a,(x)
3366  014b               L5131:
3367                     ; 2688     if (pSocket->nState == STATE_GET_GE) {
3369  014b a102          	cp	a,#2
3370  014d 261d          	jrne	L3231
3371                     ; 2689       if (nBytes == 0) return;
3373  014f 1e09          	ldw	x,(OFST+5,sp)
3374  0151 27dc          	jreq	L242
3377                     ; 2690       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
3379  0153 1e05          	ldw	x,(OFST+1,sp)
3380  0155 f6            	ld	a,(x)
3381  0156 a154          	cp	a,#84
3382  0158 2605          	jrne	L7231
3385  015a 1e0b          	ldw	x,(OFST+7,sp)
3386  015c a603          	ld	a,#3
3387  015e f7            	ld	(x),a
3388  015f               L7231:
3389                     ; 2691       nBytes--;
3391  015f 1e09          	ldw	x,(OFST+5,sp)
3392  0161 5a            	decw	x
3393  0162 1f09          	ldw	(OFST+5,sp),x
3394                     ; 2692       pBuffer++;
3396  0164 1e05          	ldw	x,(OFST+1,sp)
3397  0166 5c            	incw	x
3398  0167 1f05          	ldw	(OFST+1,sp),x
3399  0169 1e0b          	ldw	x,(OFST+7,sp)
3400  016b f6            	ld	a,(x)
3401  016c               L3231:
3402                     ; 2695     if (pSocket->nState == STATE_GET_GET) {
3404  016c a103          	cp	a,#3
3405  016e 261d          	jrne	L1331
3406                     ; 2696       if (nBytes == 0) return;
3408  0170 1e09          	ldw	x,(OFST+5,sp)
3409  0172 27bb          	jreq	L242
3412                     ; 2697       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
3414  0174 1e05          	ldw	x,(OFST+1,sp)
3415  0176 f6            	ld	a,(x)
3416  0177 a120          	cp	a,#32
3417  0179 2605          	jrne	L5331
3420  017b 1e0b          	ldw	x,(OFST+7,sp)
3421  017d a608          	ld	a,#8
3422  017f f7            	ld	(x),a
3423  0180               L5331:
3424                     ; 2698       nBytes--;
3426  0180 1e09          	ldw	x,(OFST+5,sp)
3427  0182 5a            	decw	x
3428  0183 1f09          	ldw	(OFST+5,sp),x
3429                     ; 2699       pBuffer++;
3431  0185 1e05          	ldw	x,(OFST+1,sp)
3432  0187 5c            	incw	x
3433  0188 1f05          	ldw	(OFST+1,sp),x
3434  018a 1e0b          	ldw	x,(OFST+7,sp)
3435  018c f6            	ld	a,(x)
3436  018d               L1331:
3437                     ; 2702     if (pSocket->nState == STATE_POST_P) {
3439  018d a104          	cp	a,#4
3440  018f 261d          	jrne	L7331
3441                     ; 2703       if (nBytes == 0) return;
3443  0191 1e09          	ldw	x,(OFST+5,sp)
3444  0193 279a          	jreq	L242
3447                     ; 2704       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
3449  0195 1e05          	ldw	x,(OFST+1,sp)
3450  0197 f6            	ld	a,(x)
3451  0198 a14f          	cp	a,#79
3452  019a 2605          	jrne	L3431
3455  019c 1e0b          	ldw	x,(OFST+7,sp)
3456  019e a605          	ld	a,#5
3457  01a0 f7            	ld	(x),a
3458  01a1               L3431:
3459                     ; 2705       nBytes--;
3461  01a1 1e09          	ldw	x,(OFST+5,sp)
3462  01a3 5a            	decw	x
3463  01a4 1f09          	ldw	(OFST+5,sp),x
3464                     ; 2706       pBuffer++;
3466  01a6 1e05          	ldw	x,(OFST+1,sp)
3467  01a8 5c            	incw	x
3468  01a9 1f05          	ldw	(OFST+1,sp),x
3469  01ab 1e0b          	ldw	x,(OFST+7,sp)
3470  01ad f6            	ld	a,(x)
3471  01ae               L7331:
3472                     ; 2709     if (pSocket->nState == STATE_POST_PO) {
3474  01ae a105          	cp	a,#5
3475  01b0 2620          	jrne	L5431
3476                     ; 2710       if (nBytes == 0) return;
3478  01b2 1e09          	ldw	x,(OFST+5,sp)
3479  01b4 2603cc012f    	jreq	L242
3482                     ; 2711       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
3484  01b9 1e05          	ldw	x,(OFST+1,sp)
3485  01bb f6            	ld	a,(x)
3486  01bc a153          	cp	a,#83
3487  01be 2605          	jrne	L1531
3490  01c0 1e0b          	ldw	x,(OFST+7,sp)
3491  01c2 a606          	ld	a,#6
3492  01c4 f7            	ld	(x),a
3493  01c5               L1531:
3494                     ; 2712       nBytes--;
3496  01c5 1e09          	ldw	x,(OFST+5,sp)
3497  01c7 5a            	decw	x
3498  01c8 1f09          	ldw	(OFST+5,sp),x
3499                     ; 2713       pBuffer++;
3501  01ca 1e05          	ldw	x,(OFST+1,sp)
3502  01cc 5c            	incw	x
3503  01cd 1f05          	ldw	(OFST+1,sp),x
3504  01cf 1e0b          	ldw	x,(OFST+7,sp)
3505  01d1 f6            	ld	a,(x)
3506  01d2               L5431:
3507                     ; 2716     if (pSocket->nState == STATE_POST_POS) {
3509  01d2 a106          	cp	a,#6
3510  01d4 261d          	jrne	L3531
3511                     ; 2717       if (nBytes == 0) return;
3513  01d6 1e09          	ldw	x,(OFST+5,sp)
3514  01d8 27dc          	jreq	L242
3517                     ; 2718       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
3519  01da 1e05          	ldw	x,(OFST+1,sp)
3520  01dc f6            	ld	a,(x)
3521  01dd a154          	cp	a,#84
3522  01df 2605          	jrne	L7531
3525  01e1 1e0b          	ldw	x,(OFST+7,sp)
3526  01e3 a607          	ld	a,#7
3527  01e5 f7            	ld	(x),a
3528  01e6               L7531:
3529                     ; 2719       nBytes--;
3531  01e6 1e09          	ldw	x,(OFST+5,sp)
3532  01e8 5a            	decw	x
3533  01e9 1f09          	ldw	(OFST+5,sp),x
3534                     ; 2720       pBuffer++;
3536  01eb 1e05          	ldw	x,(OFST+1,sp)
3537  01ed 5c            	incw	x
3538  01ee 1f05          	ldw	(OFST+1,sp),x
3539  01f0 1e0b          	ldw	x,(OFST+7,sp)
3540  01f2 f6            	ld	a,(x)
3541  01f3               L3531:
3542                     ; 2723     if (pSocket->nState == STATE_POST_POST) {
3544  01f3 a107          	cp	a,#7
3545  01f5 261d          	jrne	L1631
3546                     ; 2724       if (nBytes == 0) return;
3548  01f7 1e09          	ldw	x,(OFST+5,sp)
3549  01f9 27bb          	jreq	L242
3552                     ; 2725       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
3554  01fb 1e05          	ldw	x,(OFST+1,sp)
3555  01fd f6            	ld	a,(x)
3556  01fe a120          	cp	a,#32
3557  0200 2605          	jrne	L5631
3560  0202 1e0b          	ldw	x,(OFST+7,sp)
3561  0204 a609          	ld	a,#9
3562  0206 f7            	ld	(x),a
3563  0207               L5631:
3564                     ; 2726       nBytes--;
3566  0207 1e09          	ldw	x,(OFST+5,sp)
3567  0209 5a            	decw	x
3568  020a 1f09          	ldw	(OFST+5,sp),x
3569                     ; 2727       pBuffer++;
3571  020c 1e05          	ldw	x,(OFST+1,sp)
3572  020e 5c            	incw	x
3573  020f 1f05          	ldw	(OFST+1,sp),x
3574  0211 1e0b          	ldw	x,(OFST+7,sp)
3575  0213 f6            	ld	a,(x)
3576  0214               L1631:
3577                     ; 2730     if (pSocket->nState == STATE_GOTPOST) {
3579  0214 a109          	cp	a,#9
3580  0216 2703cc029d    	jrne	L7631
3581                     ; 2732       saved_nstate = STATE_GOTPOST;
3583  021b 35090044      	mov	_saved_nstate,#9
3584                     ; 2733       if (nBytes == 0) {
3586  021f 1e09          	ldw	x,(OFST+5,sp)
3587  0221 2676          	jrne	L5731
3588                     ; 2736 	saved_newlines = pSocket->nNewlines;
3590  0223 1e0b          	ldw	x,(OFST+7,sp)
3591  0225 e605          	ld	a,(5,x)
3592  0227 c70011        	ld	_saved_newlines,a
3593                     ; 2737         return;
3595  022a cc012f        	jra	L242
3596  022d               L3731:
3597                     ; 2745 	if (saved_newlines == 2) {
3599  022d c60011        	ld	a,_saved_newlines
3600  0230 a102          	cp	a,#2
3601  0232 272b          	jreq	L3041
3603                     ; 2750           if (*pBuffer == '\n') pSocket->nNewlines++;
3605  0234 1e05          	ldw	x,(OFST+1,sp)
3606  0236 f6            	ld	a,(x)
3607  0237 a10a          	cp	a,#10
3608  0239 2606          	jrne	L5041
3611  023b 1e0b          	ldw	x,(OFST+7,sp)
3612  023d 6c05          	inc	(5,x)
3614  023f 2008          	jra	L7041
3615  0241               L5041:
3616                     ; 2751           else if (*pBuffer == '\r') { }
3618  0241 a10d          	cp	a,#13
3619  0243 2704          	jreq	L7041
3621                     ; 2752           else pSocket->nNewlines = 0;
3623  0245 1e0b          	ldw	x,(OFST+7,sp)
3624  0247 6f05          	clr	(5,x)
3625  0249               L7041:
3626                     ; 2753           pBuffer++;
3628  0249 1e05          	ldw	x,(OFST+1,sp)
3629  024b 5c            	incw	x
3630  024c 1f05          	ldw	(OFST+1,sp),x
3631                     ; 2754           nBytes--;
3633  024e 1e09          	ldw	x,(OFST+5,sp)
3634  0250 5a            	decw	x
3635  0251 1f09          	ldw	(OFST+5,sp),x
3636                     ; 2755           if (nBytes == 0) {
3638  0253 260a          	jrne	L3041
3639                     ; 2758             saved_newlines = pSocket->nNewlines;
3641  0255 1e0b          	ldw	x,(OFST+7,sp)
3642  0257 e605          	ld	a,(5,x)
3643  0259 c70011        	ld	_saved_newlines,a
3644                     ; 2759             return;
3646  025c cc012f        	jra	L242
3647  025f               L3041:
3648                     ; 2767         if (pSocket->nNewlines == 2) {
3650  025f 1e0b          	ldw	x,(OFST+7,sp)
3651  0261 e605          	ld	a,(5,x)
3652  0263 a102          	cp	a,#2
3653  0265 2632          	jrne	L5731
3654                     ; 2770           if (current_webpage == WEBPAGE_IOCONTROL) {
3656  0267 c60003        	ld	a,_current_webpage
3657  026a 2609          	jrne	L1241
3658                     ; 2771 	    pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
3660  026c a635          	ld	a,#53
3661  026e e706          	ld	(6,x),a
3662                     ; 2772 	    pSocket->nParseLeftAddl = PARSEBYTES_IOCONTROL_ADDL;
3664  0270 6f07          	clr	(7,x)
3665  0272 c60003        	ld	a,_current_webpage
3666  0275               L1241:
3667                     ; 2774           if (current_webpage == WEBPAGE_CONFIGURATION) {
3669  0275 4a            	dec	a
3670  0276 2608          	jrne	L3241
3671                     ; 2775 	    pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
3673  0278 a6ec          	ld	a,#236
3674  027a e706          	ld	(6,x),a
3675                     ; 2776 	    pSocket->nParseLeftAddl = PARSEBYTES_CONFIGURATION_ADDL;
3677  027c a618          	ld	a,#24
3678  027e e707          	ld	(7,x),a
3679  0280               L3241:
3680                     ; 2778           pSocket->ParseState = saved_parsestate = PARSE_CMD;
3682  0280 725f0043      	clr	_saved_parsestate
3683  0284 6f0a          	clr	(10,x)
3684                     ; 2779 	  saved_nparseleft = pSocket->nParseLeft;
3686  0286 e606          	ld	a,(6,x)
3687  0288 c70042        	ld	_saved_nparseleft,a
3688                     ; 2781           pSocket->nState = STATE_PARSEPOST;
3690  028b a60a          	ld	a,#10
3691  028d f7            	ld	(x),a
3692                     ; 2782 	  saved_nstate = STATE_PARSEPOST;
3694  028e 350a0044      	mov	_saved_nstate,#10
3695                     ; 2783 	  if (nBytes == 0) {
3697  0292 1e09          	ldw	x,(OFST+5,sp)
3698  0294 2607          	jrne	L7631
3699                     ; 2786 	    return;
3701  0296 cc012f        	jra	L242
3702  0299               L5731:
3703                     ; 2740       while (nBytes != 0) {
3705  0299 1e09          	ldw	x,(OFST+5,sp)
3706  029b 2690          	jrne	L3731
3707  029d               L7631:
3708                     ; 2793     if (pSocket->nState == STATE_GOTGET) {
3710  029d 1e0b          	ldw	x,(OFST+7,sp)
3711  029f f6            	ld	a,(x)
3712  02a0 a108          	cp	a,#8
3713  02a2 2609          	jrne	L7241
3714                     ; 2797       pSocket->nParseLeft = 6;
3716  02a4 a606          	ld	a,#6
3717  02a6 e706          	ld	(6,x),a
3718                     ; 2798       pSocket->ParseState = PARSE_SLASH1;
3720  02a8 e70a          	ld	(10,x),a
3721                     ; 2800       pSocket->nState = STATE_PARSEGET;
3723  02aa a60d          	ld	a,#13
3724  02ac f7            	ld	(x),a
3725  02ad               L7241:
3726                     ; 2803     if (pSocket->nState == STATE_PARSEPOST) {
3728  02ad a10a          	cp	a,#10
3729  02af 2703cc0795    	jrne	L1341
3730  02b4               L3341:
3731                     ; 2817         if (pSocket->ParseState == PARSE_CMD) {
3733  02b4 1e0b          	ldw	x,(OFST+7,sp)
3734  02b6 e60a          	ld	a,(10,x)
3735  02b8 2664          	jrne	L7341
3736                     ; 2818           pSocket->ParseCmd = *pBuffer;
3738  02ba 1e05          	ldw	x,(OFST+1,sp)
3739  02bc f6            	ld	a,(x)
3740  02bd 1e0b          	ldw	x,(OFST+7,sp)
3741  02bf e708          	ld	(8,x),a
3742                     ; 2819 	  saved_postpartial[0] = *pBuffer;
3744  02c1 1e05          	ldw	x,(OFST+1,sp)
3745  02c3 f6            	ld	a,(x)
3746  02c4 c7002a        	ld	_saved_postpartial,a
3747                     ; 2820           pSocket->ParseState = saved_parsestate = PARSE_NUM10;
3749  02c7 a601          	ld	a,#1
3750  02c9 c70043        	ld	_saved_parsestate,a
3751  02cc 1e0b          	ldw	x,(OFST+7,sp)
3752  02ce e70a          	ld	(10,x),a
3753                     ; 2821 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3755  02d0 e606          	ld	a,(6,x)
3756  02d2 2704          	jreq	L1441
3757                     ; 2822 	    pSocket->nParseLeft--;
3759  02d4 6a06          	dec	(6,x)
3761  02d6 2004          	jra	L3441
3762  02d8               L1441:
3763                     ; 2826 	    pSocket->ParseState = PARSE_DELIM;
3765  02d8 a605          	ld	a,#5
3766  02da e70a          	ld	(10,x),a
3767  02dc               L3441:
3768                     ; 2828 	  saved_nparseleft = pSocket->nParseLeft;
3770  02dc e606          	ld	a,(6,x)
3771  02de c70042        	ld	_saved_nparseleft,a
3772                     ; 2829           pBuffer++;
3774  02e1 1e05          	ldw	x,(OFST+1,sp)
3775  02e3 5c            	incw	x
3776  02e4 1f05          	ldw	(OFST+1,sp),x
3777                     ; 2830 	  nBytes --;
3779  02e6 1e09          	ldw	x,(OFST+5,sp)
3780  02e8 5a            	decw	x
3781  02e9 1f09          	ldw	(OFST+5,sp),x
3782                     ; 2832 	  if (pSocket->ParseCmd == 'o' ||
3782                     ; 2833 	      pSocket->ParseCmd == 'a' ||
3782                     ; 2834 	      pSocket->ParseCmd == 'b' ||
3782                     ; 2835 	      pSocket->ParseCmd == 'c' ||
3782                     ; 2836 	      pSocket->ParseCmd == 'd' ||
3782                     ; 2837 	      pSocket->ParseCmd == 'g' ||
3782                     ; 2838 	      pSocket->ParseCmd == 'l' ||
3782                     ; 2839 	      pSocket->ParseCmd == 'm' ||
3782                     ; 2840 	      pSocket->ParseCmd == 'z') { }
3784  02eb 1e0b          	ldw	x,(OFST+7,sp)
3785  02ed e608          	ld	a,(8,x)
3786  02ef a16f          	cp	a,#111
3787  02f1 2724          	jreq	L7641
3789  02f3 a161          	cp	a,#97
3790  02f5 2720          	jreq	L7641
3792  02f7 a162          	cp	a,#98
3793  02f9 271c          	jreq	L7641
3795  02fb a163          	cp	a,#99
3796  02fd 2718          	jreq	L7641
3798  02ff a164          	cp	a,#100
3799  0301 2714          	jreq	L7641
3801  0303 a167          	cp	a,#103
3802  0305 2710          	jreq	L7641
3804  0307 a16c          	cp	a,#108
3805  0309 270c          	jreq	L7641
3807  030b a16d          	cp	a,#109
3808  030d 2708          	jreq	L7641
3810  030f a17a          	cp	a,#122
3811  0311 2704          	jreq	L7641
3812                     ; 2843 	    pSocket->ParseState = PARSE_DELIM;
3814  0313 a605          	ld	a,#5
3815  0315 e70a          	ld	(10,x),a
3816  0317               L7641:
3817                     ; 2845 	  if (nBytes == 0) { // Hit end of fragment. Break out of while()
3819  0317 1e09          	ldw	x,(OFST+5,sp)
3820  0319 2699          	jrne	L3341
3821                     ; 2847 	    break;
3823  031b cc073d        	jra	L5341
3824  031e               L7341:
3825                     ; 2851         else if (pSocket->ParseState == PARSE_NUM10) {
3827  031e a101          	cp	a,#1
3828  0320 2640          	jrne	L5741
3829                     ; 2852           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
3831  0322 1e05          	ldw	x,(OFST+1,sp)
3832  0324 f6            	ld	a,(x)
3833  0325 97            	ld	xl,a
3834  0326 a60a          	ld	a,#10
3835  0328 42            	mul	x,a
3836  0329 9f            	ld	a,xl
3837  032a 1e0b          	ldw	x,(OFST+7,sp)
3838  032c a0e0          	sub	a,#224
3839  032e e709          	ld	(9,x),a
3840                     ; 2853 	  saved_postpartial[1] = *pBuffer;
3842  0330 1e05          	ldw	x,(OFST+1,sp)
3843  0332 f6            	ld	a,(x)
3844  0333 c7002b        	ld	_saved_postpartial+1,a
3845                     ; 2854           pSocket->ParseState = saved_parsestate = PARSE_NUM1;
3847  0336 a602          	ld	a,#2
3848  0338 c70043        	ld	_saved_parsestate,a
3849  033b 1e0b          	ldw	x,(OFST+7,sp)
3850  033d e70a          	ld	(10,x),a
3851                     ; 2855 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3853  033f e606          	ld	a,(6,x)
3854  0341 2704          	jreq	L7741
3855                     ; 2856 	    pSocket->nParseLeft--;
3857  0343 6a06          	dec	(6,x)
3859  0345 2004          	jra	L1051
3860  0347               L7741:
3861                     ; 2860 	    pSocket->ParseState = PARSE_DELIM;
3863  0347 a605          	ld	a,#5
3864  0349 e70a          	ld	(10,x),a
3865  034b               L1051:
3866                     ; 2862 	  saved_nparseleft = pSocket->nParseLeft;
3868  034b e606          	ld	a,(6,x)
3869  034d c70042        	ld	_saved_nparseleft,a
3870                     ; 2863           pBuffer++;
3872  0350 1e05          	ldw	x,(OFST+1,sp)
3873  0352 5c            	incw	x
3874  0353 1f05          	ldw	(OFST+1,sp),x
3875                     ; 2864 	  nBytes--;
3877  0355 1e09          	ldw	x,(OFST+5,sp)
3878  0357 5a            	decw	x
3879  0358 1f09          	ldw	(OFST+5,sp),x
3880                     ; 2865 	  if (nBytes == 0) {
3882  035a 2703cc02b4    	jrne	L3341
3883                     ; 2867 	    break;
3885  035f cc073d        	jra	L5341
3886  0362               L5741:
3887                     ; 2871         else if (pSocket->ParseState == PARSE_NUM1) {
3889  0362 a102          	cp	a,#2
3890  0364 2638          	jrne	L7051
3891                     ; 2872           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
3893  0366 1605          	ldw	y,(OFST+1,sp)
3894  0368 90f6          	ld	a,(y)
3895  036a a030          	sub	a,#48
3896  036c eb09          	add	a,(9,x)
3897  036e e709          	ld	(9,x),a
3898                     ; 2873 	  saved_postpartial[2] = *pBuffer;
3900  0370 93            	ldw	x,y
3901  0371 f6            	ld	a,(x)
3902  0372 c7002c        	ld	_saved_postpartial+2,a
3903                     ; 2874           pSocket->ParseState = saved_parsestate = PARSE_EQUAL;
3905  0375 a603          	ld	a,#3
3906  0377 c70043        	ld	_saved_parsestate,a
3907  037a 1e0b          	ldw	x,(OFST+7,sp)
3908  037c e70a          	ld	(10,x),a
3909                     ; 2875 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3911  037e e606          	ld	a,(6,x)
3912  0380 2704          	jreq	L1151
3913                     ; 2876 	    pSocket->nParseLeft--;
3915  0382 6a06          	dec	(6,x)
3917  0384 2004          	jra	L3151
3918  0386               L1151:
3919                     ; 2880 	    pSocket->ParseState = PARSE_DELIM;
3921  0386 a605          	ld	a,#5
3922  0388 e70a          	ld	(10,x),a
3923  038a               L3151:
3924                     ; 2882 	  saved_nparseleft = pSocket->nParseLeft;
3926  038a e606          	ld	a,(6,x)
3927  038c c70042        	ld	_saved_nparseleft,a
3928                     ; 2883           pBuffer++;
3930  038f 1e05          	ldw	x,(OFST+1,sp)
3931  0391 5c            	incw	x
3932  0392 1f05          	ldw	(OFST+1,sp),x
3933                     ; 2884 	  nBytes--;
3935  0394 1e09          	ldw	x,(OFST+5,sp)
3936  0396 5a            	decw	x
3937  0397 1f09          	ldw	(OFST+5,sp),x
3938                     ; 2885 	  if (nBytes == 0) {
3940  0399 26c1          	jrne	L3341
3941                     ; 2887 	    break;
3943  039b cc073d        	jra	L5341
3944  039e               L7051:
3945                     ; 2891         else if (pSocket->ParseState == PARSE_EQUAL) {
3947  039e a103          	cp	a,#3
3948  03a0 262f          	jrne	L1251
3949                     ; 2892           pSocket->ParseState = saved_parsestate = PARSE_VAL;
3951  03a2 a604          	ld	a,#4
3952  03a4 c70043        	ld	_saved_parsestate,a
3953  03a7 e70a          	ld	(10,x),a
3954                     ; 2893 	  saved_postpartial[3] = *pBuffer;
3956  03a9 1e05          	ldw	x,(OFST+1,sp)
3957  03ab f6            	ld	a,(x)
3958  03ac c7002d        	ld	_saved_postpartial+3,a
3959                     ; 2894 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3961  03af 1e0b          	ldw	x,(OFST+7,sp)
3962  03b1 e606          	ld	a,(6,x)
3963  03b3 2704          	jreq	L3251
3964                     ; 2895 	    pSocket->nParseLeft--;
3966  03b5 6a06          	dec	(6,x)
3968  03b7 2004          	jra	L5251
3969  03b9               L3251:
3970                     ; 2899 	    pSocket->ParseState = PARSE_DELIM;
3972  03b9 a605          	ld	a,#5
3973  03bb e70a          	ld	(10,x),a
3974  03bd               L5251:
3975                     ; 2901 	  saved_nparseleft = pSocket->nParseLeft;
3977  03bd e606          	ld	a,(6,x)
3978  03bf c70042        	ld	_saved_nparseleft,a
3979                     ; 2902           pBuffer++;
3981  03c2 1e05          	ldw	x,(OFST+1,sp)
3982  03c4 5c            	incw	x
3983  03c5 1f05          	ldw	(OFST+1,sp),x
3984                     ; 2903 	  nBytes--;
3986  03c7 1e09          	ldw	x,(OFST+5,sp)
3987  03c9 5a            	decw	x
3988  03ca 1f09          	ldw	(OFST+5,sp),x
3989                     ; 2904 	  if (nBytes == 0) {
3991  03cc 268e          	jrne	L3341
3992                     ; 2906 	    break;
3994  03ce cc073d        	jra	L5341
3995  03d1               L1251:
3996                     ; 2910         else if (pSocket->ParseState == PARSE_VAL) {
3998  03d1 a104          	cp	a,#4
3999  03d3 2703cc0710    	jrne	L3351
4000                     ; 2923           if (pSocket->ParseCmd == 'o') {
4002  03d8 e608          	ld	a,(8,x)
4003  03da a16f          	cp	a,#111
4004  03dc 2644          	jrne	L5351
4005                     ; 2939 	    current_webpage = WEBPAGE_IOCONTROL;
4007  03de 725f0003      	clr	_current_webpage
4008                     ; 2943               if ((uint8_t)(*pBuffer) == '1') pin_value = 1;
4010  03e2 1e05          	ldw	x,(OFST+1,sp)
4011  03e4 f6            	ld	a,(x)
4012  03e5 a131          	cp	a,#49
4013  03e7 2604          	jrne	L7351
4016  03e9 a601          	ld	a,#1
4018  03eb 2001          	jra	L1451
4019  03ed               L7351:
4020                     ; 2944 	      else pin_value = 0;
4022  03ed 4f            	clr	a
4023  03ee               L1451:
4024  03ee 6b01          	ld	(OFST-3,sp),a
4026                     ; 2945 	      GpioSetPin(pSocket->ParseNum, (uint8_t)pin_value);
4028  03f0 160b          	ldw	y,(OFST+7,sp)
4029  03f2 97            	ld	xl,a
4030  03f3 90e609        	ld	a,(9,y)
4031  03f6 95            	ld	xh,a
4032  03f7 cd0000        	call	_GpioSetPin
4034                     ; 2947 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent
4036  03fa 1e0b          	ldw	x,(OFST+7,sp)
4037  03fc e606          	ld	a,(6,x)
4038  03fe 2704          	jreq	L3451
4041  0400 6a06          	dec	(6,x)
4042  0402 e606          	ld	a,(6,x)
4043  0404               L3451:
4044                     ; 2949             saved_nparseleft = pSocket->nParseLeft;
4046  0404 c70042        	ld	_saved_nparseleft,a
4047                     ; 2950             pBuffer++;
4049  0407 1e05          	ldw	x,(OFST+1,sp)
4050  0409 5c            	incw	x
4051  040a 1f05          	ldw	(OFST+1,sp),x
4052                     ; 2951 	    nBytes--;
4054  040c 1e09          	ldw	x,(OFST+5,sp)
4055  040e 5a            	decw	x
4056  040f 1f09          	ldw	(OFST+5,sp),x
4057                     ; 2952 	    if (nBytes == 0) {
4059  0411 2703cc06ee    	jrne	L7451
4060                     ; 2955 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4062  0416 a605          	ld	a,#5
4063  0418 c70043        	ld	_saved_parsestate,a
4064  041b 1e0b          	ldw	x,(OFST+7,sp)
4065  041d e70a          	ld	(10,x),a
4066                     ; 2956 	      break;
4068  041f cc073d        	jra	L5341
4069  0422               L5351:
4070                     ; 2963           else if (pSocket->ParseCmd == 'a'
4070                     ; 2964                 || pSocket->ParseCmd == 'l'
4070                     ; 2965                 || pSocket->ParseCmd == 'm' ) {
4072  0422 a161          	cp	a,#97
4073  0424 2708          	jreq	L3551
4075  0426 a16c          	cp	a,#108
4076  0428 2704          	jreq	L3551
4078  042a a16d          	cp	a,#109
4079  042c 265b          	jrne	L1551
4080  042e               L3551:
4081                     ; 2974 	    current_webpage = WEBPAGE_CONFIGURATION;
4083  042e 35010003      	mov	_current_webpage,#1
4084                     ; 2976 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4086  0432 725f000a      	clr	_break_while
4087                     ; 2978             tmp_pBuffer = pBuffer;
4089  0436 1e05          	ldw	x,(OFST+1,sp)
4090  0438 cf000e        	ldw	_tmp_pBuffer,x
4091                     ; 2979             tmp_nBytes = nBytes;
4093  043b 1e09          	ldw	x,(OFST+5,sp)
4094  043d cf000c        	ldw	_tmp_nBytes,x
4095                     ; 2980 	    tmp_nParseLeft = pSocket->nParseLeft;
4097  0440 1e0b          	ldw	x,(OFST+7,sp)
4098  0442 e606          	ld	a,(6,x)
4099  0444 c7000b        	ld	_tmp_nParseLeft,a
4100                     ; 2981             switch (pSocket->ParseCmd) {
4102  0447 e608          	ld	a,(8,x)
4104                     ; 2984               case 'm': i = 10; break;
4105  0449 a061          	sub	a,#97
4106  044b 270b          	jreq	L7301
4107  044d a00b          	sub	a,#11
4108  044f 270b          	jreq	L1401
4109  0451 4a            	dec	a
4110  0452 2708          	jreq	L1401
4111  0454 7b04          	ld	a,(OFST+0,sp)
4112  0456 2008          	jra	L1651
4113  0458               L7301:
4114                     ; 2982               case 'a': i = 19; break;
4116  0458 a613          	ld	a,#19
4119  045a 2002          	jp	LC016
4120  045c               L1401:
4121                     ; 2983               case 'l':
4121                     ; 2984               case 'm': i = 10; break;
4123  045c a60a          	ld	a,#10
4124  045e               LC016:
4125  045e 6b04          	ld	(OFST+0,sp),a
4129  0460               L1651:
4130                     ; 2986             parse_POST_string(pSocket->ParseCmd, i);
4132  0460 160b          	ldw	y,(OFST+7,sp)
4133  0462 97            	ld	xl,a
4134  0463 90e608        	ld	a,(8,y)
4135  0466 95            	ld	xh,a
4136  0467 cd0000        	call	_parse_POST_string
4138                     ; 2987             pBuffer = tmp_pBuffer;
4140  046a ce000e        	ldw	x,_tmp_pBuffer
4141  046d 1f05          	ldw	(OFST+1,sp),x
4142                     ; 2988             nBytes = tmp_nBytes;
4144  046f ce000c        	ldw	x,_tmp_nBytes
4145  0472 1f09          	ldw	(OFST+5,sp),x
4146                     ; 2989 	    pSocket->nParseLeft = tmp_nParseLeft;
4148  0474 1e0b          	ldw	x,(OFST+7,sp)
4149  0476 c6000b        	ld	a,_tmp_nParseLeft
4150  0479 e706          	ld	(6,x),a
4151                     ; 2990             if (break_while == 1) {
4153  047b c6000a        	ld	a,_break_while
4154  047e 4a            	dec	a
4155  047f 2692          	jrne	L7451
4156                     ; 2994 	      pSocket->ParseState = saved_parsestate;
4158  0481 c60043        	ld	a,_saved_parsestate
4159  0484 e70a          	ld	(10,x),a
4160                     ; 2995 	      break;
4162  0486 cc073d        	jra	L5341
4163  0489               L1551:
4164                     ; 3002           else if (pSocket->ParseCmd == 'b') {
4166  0489 a162          	cp	a,#98
4167  048b 2654          	jrne	L7651
4168                     ; 3010 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4170  048d 725f000a      	clr	_break_while
4171                     ; 3012             tmp_pBuffer = pBuffer;
4173  0491 1e05          	ldw	x,(OFST+1,sp)
4174  0493 cf000e        	ldw	_tmp_pBuffer,x
4175                     ; 3013             tmp_nBytes = nBytes;
4177  0496 1e09          	ldw	x,(OFST+5,sp)
4178  0498 cf000c        	ldw	_tmp_nBytes,x
4179                     ; 3014 	    tmp_nParseLeft = pSocket->nParseLeft;
4181  049b 1e0b          	ldw	x,(OFST+7,sp)
4182  049d e606          	ld	a,(6,x)
4183  049f c7000b        	ld	_tmp_nParseLeft,a
4184                     ; 3015             parse_POST_address(pSocket->ParseCmd, pSocket->ParseNum);
4186  04a2 e609          	ld	a,(9,x)
4187  04a4 160b          	ldw	y,(OFST+7,sp)
4188  04a6 97            	ld	xl,a
4189  04a7 90e608        	ld	a,(8,y)
4190  04aa 95            	ld	xh,a
4191  04ab cd0000        	call	_parse_POST_address
4193                     ; 3016             pBuffer = tmp_pBuffer;
4195  04ae ce000e        	ldw	x,_tmp_pBuffer
4196  04b1 1f05          	ldw	(OFST+1,sp),x
4197                     ; 3017             nBytes = tmp_nBytes;
4199  04b3 ce000c        	ldw	x,_tmp_nBytes
4200  04b6 1f09          	ldw	(OFST+5,sp),x
4201                     ; 3018 	    pSocket->nParseLeft = tmp_nParseLeft;
4203  04b8 1e0b          	ldw	x,(OFST+7,sp)
4204  04ba c6000b        	ld	a,_tmp_nParseLeft
4205  04bd e706          	ld	(6,x),a
4206                     ; 3019             if (break_while == 1) {
4208  04bf c6000a        	ld	a,_break_while
4209  04c2 a101          	cp	a,#1
4210  04c4 260a          	jrne	L1751
4211                     ; 3023               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4213  04c6 a604          	ld	a,#4
4214  04c8 c70043        	ld	_saved_parsestate,a
4215  04cb e70a          	ld	(10,x),a
4216                     ; 3024 	      break;
4218  04cd cc073d        	jra	L5341
4219  04d0               L1751:
4220                     ; 3026             if (break_while == 2) {
4222  04d0 a102          	cp	a,#2
4223  04d2 2703cc06ee    	jrne	L7451
4224                     ; 3029               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4226  04d7 a605          	ld	a,#5
4227  04d9 c70043        	ld	_saved_parsestate,a
4228  04dc e70a          	ld	(10,x),a
4229                     ; 3030 	      break;
4231  04de cc073d        	jra	L5341
4232  04e1               L7651:
4233                     ; 3037           else if (pSocket->ParseCmd == 'c') {
4235  04e1 a163          	cp	a,#99
4236  04e3 2651          	jrne	L7751
4237                     ; 3046 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4239  04e5 725f000a      	clr	_break_while
4240                     ; 3048             tmp_pBuffer = pBuffer;
4242  04e9 1e05          	ldw	x,(OFST+1,sp)
4243  04eb cf000e        	ldw	_tmp_pBuffer,x
4244                     ; 3049             tmp_nBytes = nBytes;
4246  04ee 1e09          	ldw	x,(OFST+5,sp)
4247  04f0 cf000c        	ldw	_tmp_nBytes,x
4248                     ; 3050 	    tmp_nParseLeft = pSocket->nParseLeft;
4250  04f3 1e0b          	ldw	x,(OFST+7,sp)
4251  04f5 e606          	ld	a,(6,x)
4252  04f7 c7000b        	ld	_tmp_nParseLeft,a
4253                     ; 3051             parse_POST_port(pSocket->ParseCmd, pSocket->ParseNum);
4255  04fa e609          	ld	a,(9,x)
4256  04fc 160b          	ldw	y,(OFST+7,sp)
4257  04fe 97            	ld	xl,a
4258  04ff 90e608        	ld	a,(8,y)
4259  0502 95            	ld	xh,a
4260  0503 cd0000        	call	_parse_POST_port
4262                     ; 3052             pBuffer = tmp_pBuffer;
4264  0506 ce000e        	ldw	x,_tmp_pBuffer
4265  0509 1f05          	ldw	(OFST+1,sp),x
4266                     ; 3053             nBytes = tmp_nBytes;
4268  050b ce000c        	ldw	x,_tmp_nBytes
4269  050e 1f09          	ldw	(OFST+5,sp),x
4270                     ; 3054 	    pSocket->nParseLeft = tmp_nParseLeft;
4272  0510 1e0b          	ldw	x,(OFST+7,sp)
4273  0512 c6000b        	ld	a,_tmp_nParseLeft
4274  0515 e706          	ld	(6,x),a
4275                     ; 3055             if (break_while == 1) {
4277  0517 c6000a        	ld	a,_break_while
4278  051a a101          	cp	a,#1
4279  051c 260a          	jrne	L1061
4280                     ; 3058               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4282  051e a604          	ld	a,#4
4283  0520 c70043        	ld	_saved_parsestate,a
4284  0523 e70a          	ld	(10,x),a
4285                     ; 3059 	      break;
4287  0525 cc073d        	jra	L5341
4288  0528               L1061:
4289                     ; 3061             if (break_while == 2) {
4291  0528 a102          	cp	a,#2
4292  052a 26a8          	jrne	L7451
4293                     ; 3064               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4295  052c a605          	ld	a,#5
4296  052e c70043        	ld	_saved_parsestate,a
4297  0531 e70a          	ld	(10,x),a
4298                     ; 3065 	      break;
4300  0533 cc073d        	jra	L5341
4301  0536               L7751:
4302                     ; 3072           else if (pSocket->ParseCmd == 'd') {
4304  0536 a164          	cp	a,#100
4305  0538 2703cc05d8    	jrne	L7061
4306                     ; 3078 	    alpha[0] = '-';
4308  053d 352d0004      	mov	_alpha,#45
4309                     ; 3079 	    alpha[1] = '-';
4311  0541 352d0005      	mov	_alpha+1,#45
4312                     ; 3081 	    if (saved_postpartial_previous[0] == 'd') {
4314  0545 c60012        	ld	a,_saved_postpartial_previous
4315  0548 a164          	cp	a,#100
4316  054a 261a          	jrne	L1161
4317                     ; 3085 	      saved_postpartial_previous[0] = '\0';
4319  054c 725f0012      	clr	_saved_postpartial_previous
4320                     ; 3091 	      if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
4322  0550 c60016        	ld	a,_saved_postpartial_previous+4
4323  0553 2705          	jreq	L3161
4326  0555 5500160004    	mov	_alpha,_saved_postpartial_previous+4
4327  055a               L3161:
4328                     ; 3092 	      if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
4330  055a c60017        	ld	a,_saved_postpartial_previous+5
4331  055d 270a          	jreq	L7161
4334  055f 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
4335  0564 2003          	jra	L7161
4336  0566               L1161:
4337                     ; 3099               clear_saved_postpartial_data(); // Clear [4] and higher
4339  0566 cd0000        	call	_clear_saved_postpartial_data
4341  0569               L7161:
4342                     ; 3102             if (alpha[0] == '-') {
4344  0569 c60004        	ld	a,_alpha
4345  056c a12d          	cp	a,#45
4346  056e 261e          	jrne	L1261
4347                     ; 3103 	      alpha[0] = (uint8_t)(*pBuffer);
4349  0570 1e05          	ldw	x,(OFST+1,sp)
4350  0572 f6            	ld	a,(x)
4351  0573 c70004        	ld	_alpha,a
4352                     ; 3104               saved_postpartial[4] = *pBuffer;
4354  0576 c7002e        	ld	_saved_postpartial+4,a
4355                     ; 3105               pSocket->nParseLeft--;
4357  0579 1e0b          	ldw	x,(OFST+7,sp)
4358  057b 6a06          	dec	(6,x)
4359                     ; 3106               saved_nparseleft = pSocket->nParseLeft;
4361  057d e606          	ld	a,(6,x)
4362  057f c70042        	ld	_saved_nparseleft,a
4363                     ; 3107               pBuffer++;
4365  0582 1e05          	ldw	x,(OFST+1,sp)
4366  0584 5c            	incw	x
4367  0585 1f05          	ldw	(OFST+1,sp),x
4368                     ; 3108 	      nBytes--;
4370  0587 1e09          	ldw	x,(OFST+5,sp)
4371  0589 5a            	decw	x
4372  058a 1f09          	ldw	(OFST+5,sp),x
4373                     ; 3109               if (nBytes == 0) break; // Hit end of fragment. Break out of
4375  058c 27a5          	jreq	L5341
4378  058e               L1261:
4379                     ; 3113             if (alpha[1] == '-') {
4381  058e c60005        	ld	a,_alpha+1
4382  0591 a12d          	cp	a,#45
4383  0593 261c          	jrne	L5261
4384                     ; 3114 	      alpha[1] = (uint8_t)(*pBuffer);
4386  0595 1e05          	ldw	x,(OFST+1,sp)
4387  0597 f6            	ld	a,(x)
4388  0598 c70005        	ld	_alpha+1,a
4389                     ; 3115               saved_postpartial[5] = *pBuffer;
4391  059b c7002f        	ld	_saved_postpartial+5,a
4392                     ; 3116               pSocket->nParseLeft--;
4394  059e 1e0b          	ldw	x,(OFST+7,sp)
4395  05a0 6a06          	dec	(6,x)
4396                     ; 3117               saved_nparseleft = pSocket->nParseLeft;
4398  05a2 e606          	ld	a,(6,x)
4399  05a4 c70042        	ld	_saved_nparseleft,a
4400                     ; 3118               pBuffer++;
4402  05a7 1e05          	ldw	x,(OFST+1,sp)
4403  05a9 5c            	incw	x
4404  05aa 1f05          	ldw	(OFST+1,sp),x
4405                     ; 3119 	      nBytes--;
4407  05ac 1e09          	ldw	x,(OFST+5,sp)
4408  05ae 5a            	decw	x
4409  05af 1f09          	ldw	(OFST+5,sp),x
4410  05b1               L5261:
4411                     ; 3125             clear_saved_postpartial_all();
4413  05b1 cd0000        	call	_clear_saved_postpartial_all
4415                     ; 3127             SetMAC(pSocket->ParseNum, alpha[0], alpha[1]);
4417  05b4 3b0005        	push	_alpha+1
4418  05b7 c60004        	ld	a,_alpha
4419  05ba 160c          	ldw	y,(OFST+8,sp)
4420  05bc 97            	ld	xl,a
4421  05bd 90e609        	ld	a,(9,y)
4422  05c0 95            	ld	xh,a
4423  05c1 cd0000        	call	_SetMAC
4425  05c4 84            	pop	a
4426                     ; 3129             if (nBytes == 0) {
4428  05c5 1e09          	ldw	x,(OFST+5,sp)
4429  05c7 2703cc06ee    	jrne	L7451
4430                     ; 3132 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4432  05cc a605          	ld	a,#5
4433  05ce c70043        	ld	_saved_parsestate,a
4434  05d1 1e0b          	ldw	x,(OFST+7,sp)
4435  05d3 e70a          	ld	(10,x),a
4436                     ; 3133 	      break;
4438  05d5 cc073d        	jra	L5341
4439  05d8               L7061:
4440                     ; 3140 	  else if (pSocket->ParseCmd == 'g') {
4442  05d8 a167          	cp	a,#103
4443  05da 2703cc06e1    	jrne	L3361
4444                     ; 3151             for (i=0; i<6; i++) alpha[i] = '-';
4446  05df 4f            	clr	a
4447  05e0 6b04          	ld	(OFST+0,sp),a
4449  05e2               L5361:
4452  05e2 5f            	clrw	x
4453  05e3 97            	ld	xl,a
4454  05e4 a62d          	ld	a,#45
4455  05e6 d70004        	ld	(_alpha,x),a
4458  05e9 0c04          	inc	(OFST+0,sp)
4462  05eb 7b04          	ld	a,(OFST+0,sp)
4463  05ed a106          	cp	a,#6
4464  05ef 25f1          	jrult	L5361
4465                     ; 3153 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4467  05f1 725f000a      	clr	_break_while
4468                     ; 3156 	    if (saved_postpartial_previous[0] == 'g') {
4470  05f5 c60012        	ld	a,_saved_postpartial_previous
4471  05f8 a167          	cp	a,#103
4472  05fa 2621          	jrne	L3461
4473                     ; 3160 	      saved_postpartial_previous[0] = '\0';
4475  05fc 725f0012      	clr	_saved_postpartial_previous
4476                     ; 3166               for (i=0; i<6; i++) {
4478  0600 4f            	clr	a
4479  0601 6b04          	ld	(OFST+0,sp),a
4481  0603               L5461:
4482                     ; 3167                 if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
4484  0603 5f            	clrw	x
4485  0604 97            	ld	xl,a
4486  0605 724d0016      	tnz	(_saved_postpartial_previous+4,x)
4487  0609 2708          	jreq	L3561
4490  060b 5f            	clrw	x
4491  060c 97            	ld	xl,a
4492  060d d60016        	ld	a,(_saved_postpartial_previous+4,x)
4493  0610 d70004        	ld	(_alpha,x),a
4494  0613               L3561:
4495                     ; 3166               for (i=0; i<6; i++) {
4497  0613 0c04          	inc	(OFST+0,sp)
4501  0615 7b04          	ld	a,(OFST+0,sp)
4502  0617 a106          	cp	a,#6
4503  0619 25e8          	jrult	L5461
4505  061b 2003          	jra	L5561
4506  061d               L3461:
4507                     ; 3175               clear_saved_postpartial_data(); // Clear [4] and higher
4509  061d cd0000        	call	_clear_saved_postpartial_data
4511  0620               L5561:
4512                     ; 3178             for (i=0; i<6; i++) {
4514  0620 4f            	clr	a
4515  0621 6b04          	ld	(OFST+0,sp),a
4517  0623               L7561:
4518                     ; 3184               if (alpha[i] == '-') {
4520  0623 5f            	clrw	x
4521  0624 97            	ld	xl,a
4522  0625 d60004        	ld	a,(_alpha,x)
4523  0628 a12d          	cp	a,#45
4524  062a 2636          	jrne	L5661
4525                     ; 3185 	        alpha[i] = (uint8_t)(*pBuffer);
4527  062c 7b04          	ld	a,(OFST+0,sp)
4528  062e 5f            	clrw	x
4529  062f 1605          	ldw	y,(OFST+1,sp)
4530  0631 97            	ld	xl,a
4531  0632 90f6          	ld	a,(y)
4532  0634 d70004        	ld	(_alpha,x),a
4533                     ; 3186                 saved_postpartial[i+4] = *pBuffer;
4535  0637 5f            	clrw	x
4536  0638 7b04          	ld	a,(OFST+0,sp)
4537  063a 97            	ld	xl,a
4538  063b 90f6          	ld	a,(y)
4539  063d d7002e        	ld	(_saved_postpartial+4,x),a
4540                     ; 3187                 pSocket->nParseLeft--;
4542  0640 1e0b          	ldw	x,(OFST+7,sp)
4543  0642 6a06          	dec	(6,x)
4544                     ; 3188                 saved_nparseleft = pSocket->nParseLeft;
4546  0644 e606          	ld	a,(6,x)
4547  0646 c70042        	ld	_saved_nparseleft,a
4548                     ; 3189                 pBuffer++;
4550  0649 93            	ldw	x,y
4551  064a 5c            	incw	x
4552  064b 1f05          	ldw	(OFST+1,sp),x
4553                     ; 3190 	        nBytes--;
4555  064d 1e09          	ldw	x,(OFST+5,sp)
4556  064f 5a            	decw	x
4557  0650 1f09          	ldw	(OFST+5,sp),x
4558                     ; 3191                 if (i != 5 && nBytes == 0) {
4560  0652 7b04          	ld	a,(OFST+0,sp)
4561  0654 a105          	cp	a,#5
4562  0656 270a          	jreq	L5661
4564  0658 1e09          	ldw	x,(OFST+5,sp)
4565  065a 2606          	jrne	L5661
4566                     ; 3192 		  break_while = 1; // Hit end of fragment. Break out of
4568  065c 3501000a      	mov	_break_while,#1
4569                     ; 3194 		  break; // Break out of for() loop
4571  0660 2008          	jra	L3661
4572  0662               L5661:
4573                     ; 3178             for (i=0; i<6; i++) {
4575  0662 0c04          	inc	(OFST+0,sp)
4579  0664 7b04          	ld	a,(OFST+0,sp)
4580  0666 a106          	cp	a,#6
4581  0668 25b9          	jrult	L7561
4582  066a               L3661:
4583                     ; 3198 	    if (break_while == 1) {
4585  066a c6000a        	ld	a,_break_while
4586  066d 4a            	dec	a
4587  066e 2603cc073d    	jreq	L5341
4588                     ; 3200 	      break;
4590                     ; 3206             clear_saved_postpartial_all();
4592  0673 cd0000        	call	_clear_saved_postpartial_all
4594                     ; 3209 	    if (alpha[0] != '0' && alpha[0] != '1') alpha[0] = '0';
4596  0676 c60004        	ld	a,_alpha
4597  0679 a130          	cp	a,#48
4598  067b 2708          	jreq	L3761
4600  067d a131          	cp	a,#49
4601  067f 2704          	jreq	L3761
4604  0681 35300004      	mov	_alpha,#48
4605  0685               L3761:
4606                     ; 3210 	    if (alpha[1] != '0' && alpha[1] != '1') alpha[1] = '0';
4608  0685 c60005        	ld	a,_alpha+1
4609  0688 a130          	cp	a,#48
4610  068a 2708          	jreq	L5761
4612  068c a131          	cp	a,#49
4613  068e 2704          	jreq	L5761
4616  0690 35300005      	mov	_alpha+1,#48
4617  0694               L5761:
4618                     ; 3211 	    if (alpha[2] != '0' && alpha[2] != '1' && alpha[2] != '2') alpha[2] = '2';
4620  0694 c60006        	ld	a,_alpha+2
4621  0697 a130          	cp	a,#48
4622  0699 270c          	jreq	L7761
4624  069b a131          	cp	a,#49
4625  069d 2708          	jreq	L7761
4627  069f a132          	cp	a,#50
4628  06a1 2704          	jreq	L7761
4631  06a3 35320006      	mov	_alpha+2,#50
4632  06a7               L7761:
4633                     ; 3212 	    if (alpha[3] != '0' && alpha[3] != '1') alpha[3] = '0';
4635  06a7 c60007        	ld	a,_alpha+3
4636  06aa a130          	cp	a,#48
4637  06ac 2708          	jreq	L1071
4639  06ae a131          	cp	a,#49
4640  06b0 2704          	jreq	L1071
4643  06b2 35300007      	mov	_alpha+3,#48
4644  06b6               L1071:
4645                     ; 3214 	    Pending_config_settings[0] = (uint8_t)alpha[0];
4647  06b6 5500040000    	mov	_Pending_config_settings,_alpha
4648                     ; 3215             Pending_config_settings[1] = (uint8_t)alpha[1];
4650  06bb 5500050001    	mov	_Pending_config_settings+1,_alpha+1
4651                     ; 3216             Pending_config_settings[2] = (uint8_t)alpha[2];
4653  06c0 5500060002    	mov	_Pending_config_settings+2,_alpha+2
4654                     ; 3217             Pending_config_settings[3] = (uint8_t)alpha[3];
4656  06c5 5500070003    	mov	_Pending_config_settings+3,_alpha+3
4657                     ; 3218             Pending_config_settings[4] = '0';
4659  06ca 35300004      	mov	_Pending_config_settings+4,#48
4660                     ; 3219             Pending_config_settings[5] = '0';
4662  06ce 35300005      	mov	_Pending_config_settings+5,#48
4663                     ; 3221             if (nBytes == 0) {
4665  06d2 1e09          	ldw	x,(OFST+5,sp)
4666  06d4 2618          	jrne	L7451
4667                     ; 3224 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4669  06d6 a605          	ld	a,#5
4670  06d8 c70043        	ld	_saved_parsestate,a
4671  06db 1e0b          	ldw	x,(OFST+7,sp)
4672  06dd e70a          	ld	(10,x),a
4673                     ; 3225 	      break;
4675  06df 205c          	jra	L5341
4676  06e1               L3361:
4677                     ; 3232 	  else if (pSocket->ParseCmd == 'z') {
4679  06e1 a17a          	cp	a,#122
4680  06e3 2609          	jrne	L7451
4681                     ; 3257 	    nBytes = 0;
4683  06e5 5f            	clrw	x
4684  06e6 1f09          	ldw	(OFST+5,sp),x
4685                     ; 3258 	    pSocket->nParseLeft = 0;
4687  06e8 1e0b          	ldw	x,(OFST+7,sp)
4688  06ea 6f06          	clr	(6,x)
4689                     ; 3259             break; // Break out of the while loop. We're done with POST.
4691  06ec 204f          	jra	L5341
4692  06ee               L7451:
4693                     ; 3270           pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4695  06ee a605          	ld	a,#5
4696  06f0 c70043        	ld	_saved_parsestate,a
4697  06f3 1e0b          	ldw	x,(OFST+7,sp)
4698  06f5 e70a          	ld	(10,x),a
4699                     ; 3272           if (pSocket->nParseLeft < 30) {
4701  06f7 e606          	ld	a,(6,x)
4702  06f9 a11e          	cp	a,#30
4703  06fb 2503cc02b4    	jruge	L3341
4704                     ; 3287 	    if (pSocket->nParseLeftAddl > 0) {
4706  0700 6d07          	tnz	(7,x)
4707  0702 27f9          	jreq	L3341
4708                     ; 3288 	      pSocket->nParseLeft += pSocket->nParseLeftAddl;
4710  0704 eb07          	add	a,(7,x)
4711  0706 e706          	ld	(6,x),a
4712                     ; 3289 	      pSocket->nParseLeftAddl = 0;
4714  0708 6f07          	clr	(7,x)
4715                     ; 3290 	      saved_nparseleft = pSocket->nParseLeft;
4717  070a c70042        	ld	_saved_nparseleft,a
4718  070d cc02b4        	jra	L3341
4719  0710               L3351:
4720                     ; 3295         else if (pSocket->ParseState == PARSE_DELIM) {
4722  0710 a105          	cp	a,#5
4723  0712 26f9          	jrne	L3341
4724                     ; 3296           if (pSocket->nParseLeft > 0) {
4726  0714 e606          	ld	a,(6,x)
4727  0716 2720          	jreq	L1271
4728                     ; 3299             pSocket->ParseState = saved_parsestate = PARSE_CMD;
4730  0718 725f0043      	clr	_saved_parsestate
4731  071c 6f0a          	clr	(10,x)
4732                     ; 3300             pSocket->nParseLeft--;
4734  071e 6a06          	dec	(6,x)
4735                     ; 3301             saved_nparseleft = pSocket->nParseLeft;
4737  0720 e606          	ld	a,(6,x)
4738  0722 c70042        	ld	_saved_nparseleft,a
4739                     ; 3302             pBuffer++;
4741  0725 1e05          	ldw	x,(OFST+1,sp)
4742  0727 5c            	incw	x
4743  0728 1f05          	ldw	(OFST+1,sp),x
4744                     ; 3303 	    nBytes--;
4746  072a 1e09          	ldw	x,(OFST+5,sp)
4747  072c 5a            	decw	x
4748  072d 1f09          	ldw	(OFST+5,sp),x
4749                     ; 3305 	    clear_saved_postpartial_all();
4751  072f cd0000        	call	_clear_saved_postpartial_all
4753                     ; 3309             if (nBytes == 0) {
4755  0732 1e09          	ldw	x,(OFST+5,sp)
4756  0734 26d7          	jrne	L3341
4757                     ; 3310 	      break; // Hit end of fragment but still have more to parse in
4759  0736 2005          	jra	L5341
4760  0738               L1271:
4761                     ; 3320             pSocket->nParseLeft = 0; // End the parsing
4763  0738 e706          	ld	(6,x),a
4764                     ; 3321 	    nBytes = 0;
4766  073a 5f            	clrw	x
4767  073b 1f09          	ldw	(OFST+5,sp),x
4768                     ; 3322 	    break; // Exit parsing
4769  073d               L5341:
4770                     ; 3349       if (pSocket->nParseLeft == 0) {
4772  073d 1e0b          	ldw	x,(OFST+7,sp)
4773  073f e606          	ld	a,(6,x)
4774  0741 264e          	jrne	L7271
4775                     ; 3352 	saved_nstate = STATE_NULL;
4777  0743 357f0044      	mov	_saved_nstate,#127
4778                     ; 3353 	saved_parsestate = PARSE_CMD;
4780  0747 c70043        	ld	_saved_parsestate,a
4781                     ; 3354         saved_nparseleft = 0;
4783  074a c70042        	ld	_saved_nparseleft,a
4784                     ; 3355         saved_newlines = 0;
4786  074d c70011        	ld	_saved_newlines,a
4787                     ; 3356 	for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i] = '\0';
4789  0750 6b04          	ld	(OFST+0,sp),a
4791  0752               L1371:
4794  0752 5f            	clrw	x
4795  0753 97            	ld	xl,a
4796  0754 724f002a      	clr	(_saved_postpartial,x)
4797  0758 5f            	clrw	x
4798  0759 97            	ld	xl,a
4799  075a 724f0012      	clr	(_saved_postpartial_previous,x)
4802  075e 0c04          	inc	(OFST+0,sp)
4806  0760 7b04          	ld	a,(OFST+0,sp)
4807  0762 a118          	cp	a,#24
4808  0764 25ec          	jrult	L1371
4809                     ; 3362 	parse_complete = 1;
4811  0766 35010000      	mov	_parse_complete,#1
4812                     ; 3363 	pSocket->nState = STATE_SENDHEADER;
4814  076a 1e0b          	ldw	x,(OFST+7,sp)
4815  076c a60b          	ld	a,#11
4816  076e f7            	ld	(x),a
4817                     ; 3375         if (current_webpage == WEBPAGE_IOCONTROL) {
4819  076f c60003        	ld	a,_current_webpage
4820  0772 260c          	jrne	L7371
4821                     ; 3376           pSocket->pData = g_HtmlPageIOControl;
4823  0774 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4824  0778 ef01          	ldw	(1,x),y
4825                     ; 3377           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4827  077a 90ae0c06      	ldw	y,#3078
4828  077e ef03          	ldw	(3,x),y
4829  0780               L7371:
4830                     ; 3379         if (current_webpage == WEBPAGE_CONFIGURATION) {
4832  0780 4a            	dec	a
4833  0781 2612          	jrne	L1341
4834                     ; 3380           pSocket->pData = g_HtmlPageConfiguration;
4836  0783 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
4837  0787 ef01          	ldw	(1,x),y
4838                     ; 3381           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
4840  0789 90ae0c31      	ldw	y,#3121
4841  078d ef03          	ldw	(3,x),y
4842  078f 2004          	jra	L1341
4843  0791               L7271:
4844                     ; 3401 	uip_len = 0;
4846  0791 5f            	clrw	x
4847  0792 cf0000        	ldw	_uip_len,x
4848  0795               L1341:
4849                     ; 3405     if (pSocket->nState == STATE_PARSEGET) {
4851  0795 1e0b          	ldw	x,(OFST+7,sp)
4852  0797 f6            	ld	a,(x)
4853  0798 a10d          	cp	a,#13
4854  079a 2703cc09ee    	jrne	L5471
4856  079f cc09e7        	jra	L1571
4857  07a2               L7471:
4858                     ; 3434         if (pSocket->ParseState == PARSE_SLASH1) {
4860  07a2 1e0b          	ldw	x,(OFST+7,sp)
4861  07a4 e60a          	ld	a,(10,x)
4862  07a6 a106          	cp	a,#6
4863  07a8 263c          	jrne	L5571
4864                     ; 3437           pSocket->ParseCmd = *pBuffer;
4866  07aa 1e05          	ldw	x,(OFST+1,sp)
4867  07ac f6            	ld	a,(x)
4868  07ad 1e0b          	ldw	x,(OFST+7,sp)
4869  07af e708          	ld	(8,x),a
4870                     ; 3438           pSocket->nParseLeft--;
4872  07b1 6a06          	dec	(6,x)
4873                     ; 3439           pBuffer++;
4875  07b3 1e05          	ldw	x,(OFST+1,sp)
4876  07b5 5c            	incw	x
4877  07b6 1f05          	ldw	(OFST+1,sp),x
4878                     ; 3440 	  nBytes--;
4880  07b8 1e09          	ldw	x,(OFST+5,sp)
4881  07ba 5a            	decw	x
4882  07bb 1f09          	ldw	(OFST+5,sp),x
4883                     ; 3441 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
4885  07bd 1e0b          	ldw	x,(OFST+7,sp)
4886  07bf e608          	ld	a,(8,x)
4887  07c1 a12f          	cp	a,#47
4888  07c3 2605          	jrne	L7571
4889                     ; 3442 	    pSocket->ParseState = PARSE_NUM10;
4891  07c5 a601          	ld	a,#1
4893  07c7 cc0860        	jp	LC019
4894  07ca               L7571:
4895                     ; 3446 	    current_webpage = WEBPAGE_IOCONTROL;
4897  07ca 725f0003      	clr	_current_webpage
4898                     ; 3447             pSocket->pData = g_HtmlPageIOControl;
4900  07ce 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4901  07d2 ef01          	ldw	(1,x),y
4902                     ; 3448             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4904  07d4 90ae0c06      	ldw	y,#3078
4905  07d8 ef03          	ldw	(3,x),y
4906                     ; 3449             pSocket->nParseLeft = 0; // This will cause the while() to exit
4908  07da 6f06          	clr	(6,x)
4909                     ; 3451             pSocket->nState = STATE_CONNECTED;
4911  07dc 7f            	clr	(x)
4912                     ; 3452             pSocket->nPrevBytes = 0xFFFF;
4914  07dd 90aeffff      	ldw	y,#65535
4915  07e1 ef0b          	ldw	(11,x),y
4916  07e3 cc09d6        	jra	L3671
4917  07e6               L5571:
4918                     ; 3456         else if (pSocket->ParseState == PARSE_NUM10) {
4920  07e6 a101          	cp	a,#1
4921  07e8 2640          	jrne	L5671
4922                     ; 3461 	  if (*pBuffer == ' ') {
4924  07ea 1e05          	ldw	x,(OFST+1,sp)
4925  07ec f6            	ld	a,(x)
4926  07ed a120          	cp	a,#32
4927  07ef 261e          	jrne	L7671
4928                     ; 3462 	    current_webpage = WEBPAGE_IOCONTROL;
4930  07f1 725f0003      	clr	_current_webpage
4931                     ; 3463             pSocket->pData = g_HtmlPageIOControl;
4933  07f5 1e0b          	ldw	x,(OFST+7,sp)
4934  07f7 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4935  07fb ef01          	ldw	(1,x),y
4936                     ; 3464             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4938  07fd 90ae0c06      	ldw	y,#3078
4939  0801 ef03          	ldw	(3,x),y
4940                     ; 3465             pSocket->nParseLeft = 0;
4942  0803 6f06          	clr	(6,x)
4943                     ; 3467             pSocket->nState = STATE_CONNECTED;
4945  0805 7f            	clr	(x)
4946                     ; 3468             pSocket->nPrevBytes = 0xFFFF;
4948  0806 90aeffff      	ldw	y,#65535
4949  080a ef0b          	ldw	(11,x),y
4951  080c cc09d6        	jra	L3671
4952  080f               L7671:
4953                     ; 3472 	  else if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
4955  080f a130          	cp	a,#48
4956  0811 2547          	jrult	L3002
4958  0813 a13a          	cp	a,#58
4959  0815 2443          	jruge	L3002
4960                     ; 3474             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
4962  0817 97            	ld	xl,a
4963  0818 a60a          	ld	a,#10
4964  081a 42            	mul	x,a
4965  081b 9f            	ld	a,xl
4966  081c 1e0b          	ldw	x,(OFST+7,sp)
4967  081e a0e0          	sub	a,#224
4968  0820 e709          	ld	(9,x),a
4969                     ; 3475 	    pSocket->ParseState = PARSE_NUM1;
4971  0822 a602          	ld	a,#2
4972  0824 e70a          	ld	(10,x),a
4973                     ; 3476             pSocket->nParseLeft--;
4975  0826 6a06          	dec	(6,x)
4976                     ; 3477             pBuffer++;
4977                     ; 3478 	    nBytes--;
4979  0828 2023          	jp	LC021
4980                     ; 3483             pSocket->nParseLeft = 0;
4981                     ; 3484             pSocket->ParseState = PARSE_FAIL;
4982  082a               L5671:
4983                     ; 3489         else if (pSocket->ParseState == PARSE_NUM1) {
4985  082a a102          	cp	a,#2
4986  082c 2637          	jrne	L1002
4987                     ; 3490 	  if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
4989  082e 1e05          	ldw	x,(OFST+1,sp)
4990  0830 f6            	ld	a,(x)
4991  0831 a130          	cp	a,#48
4992  0833 2525          	jrult	L3002
4994  0835 a13a          	cp	a,#58
4995  0837 2421          	jruge	L3002
4996                     ; 3492             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
4998  0839 1605          	ldw	y,(OFST+1,sp)
4999  083b 1e0b          	ldw	x,(OFST+7,sp)
5000  083d 90f6          	ld	a,(y)
5001  083f a030          	sub	a,#48
5002  0841 eb09          	add	a,(9,x)
5003  0843 e709          	ld	(9,x),a
5004                     ; 3493             pSocket->ParseState = PARSE_VAL;
5006  0845 a604          	ld	a,#4
5007  0847 e70a          	ld	(10,x),a
5008                     ; 3494             pSocket->nParseLeft = 1; // Set to 1 so PARSE_VAL will be called
5010  0849 a601          	ld	a,#1
5011  084b e706          	ld	(6,x),a
5012                     ; 3495             pBuffer++;
5014                     ; 3496 	    nBytes--;
5016  084d               LC021:
5018  084d 1e05          	ldw	x,(OFST+1,sp)
5019  084f 5c            	incw	x
5020  0850 1f05          	ldw	(OFST+1,sp),x
5022  0852 1e09          	ldw	x,(OFST+5,sp)
5023  0854 5a            	decw	x
5024  0855 1f09          	ldw	(OFST+5,sp),x
5026  0857 cc09d6        	jra	L3671
5027  085a               L3002:
5028                     ; 3501             pSocket->nParseLeft = 0;
5030                     ; 3502             pSocket->ParseState = PARSE_FAIL;
5033  085a 1e0b          	ldw	x,(OFST+7,sp)
5035  085c a607          	ld	a,#7
5036  085e 6f06          	clr	(6,x)
5037  0860               LC019:
5038  0860 e70a          	ld	(10,x),a
5039  0862 cc09d6        	jra	L3671
5040  0865               L1002:
5041                     ; 3506         else if (pSocket->ParseState == PARSE_VAL) {
5043  0865 a104          	cp	a,#4
5044  0867 26f9          	jrne	L3671
5045                     ; 3573           switch(pSocket->ParseNum)
5047  0869 e609          	ld	a,(9,x)
5049                     ; 3774 	      break;
5050  086b a110          	cp	a,#16
5051  086d 2407          	jruge	L212
5052  086f 5f            	clrw	x
5053  0870 97            	ld	xl,a
5054  0871 58            	sllw	x
5055  0872 de1b68        	ldw	x,(L412,x)
5056  0875 fc            	jp	(x)
5057  0876               L212:
5058  0876 a037          	sub	a,#55
5059  0878 2603cc095d    	jreq	L3011
5060  087d 4a            	dec	a
5061  087e 2603cc0967    	jreq	L5011
5062  0883 a004          	sub	a,#4
5063  0885 2603cc0970    	jreq	L7011
5064  088a 4a            	dec	a
5065  088b 2603cc097f    	jreq	L1111
5066  0890 a004          	sub	a,#4
5067  0892 2603cc0992    	jreq	L3111
5068  0897 a01a          	sub	a,#26
5069  0899 2603cc099d    	jreq	L5111
5070  089e a007          	sub	a,#7
5071  08a0 2603cc09a3    	jreq	L7111
5072  08a5 4a            	dec	a
5073  08a6 2603cc09af    	jreq	L1211
5074  08ab cc09bb        	jra	L3211
5075  08ae               L3401:
5076                     ; 3623 	    case 0:  IO_8to1 &= (uint8_t)(~0x01);  parse_complete = 1; break; // Relay-01 OFF
5078  08ae 72110000      	bres	_IO_8to1,#0
5081  08b2 35010000      	mov	_parse_complete,#1
5084  08b6 cc09d2        	jra	L5102
5085  08b9               L5401:
5086                     ; 3624 	    case 1:  IO_8to1 |= (uint8_t)0x01;     parse_complete = 1; break; // Relay-01 ON
5088  08b9 72100000      	bset	_IO_8to1,#0
5091  08bd 35010000      	mov	_parse_complete,#1
5094  08c1 cc09d2        	jra	L5102
5095  08c4               L7401:
5096                     ; 3625 	    case 2:  IO_8to1 &= (uint8_t)(~0x02);  parse_complete = 1; break; // Relay-02 OFF
5098  08c4 72130000      	bres	_IO_8to1,#1
5101  08c8 35010000      	mov	_parse_complete,#1
5104  08cc cc09d2        	jra	L5102
5105  08cf               L1501:
5106                     ; 3626 	    case 3:  IO_8to1 |= (uint8_t)0x02;     parse_complete = 1; break; // Relay-02 ON
5108  08cf 72120000      	bset	_IO_8to1,#1
5111  08d3 35010000      	mov	_parse_complete,#1
5114  08d7 cc09d2        	jra	L5102
5115  08da               L3501:
5116                     ; 3627 	    case 4:  IO_8to1 &= (uint8_t)(~0x04);  parse_complete = 1; break; // Relay-03 OFF
5118  08da 72150000      	bres	_IO_8to1,#2
5121  08de 35010000      	mov	_parse_complete,#1
5124  08e2 cc09d2        	jra	L5102
5125  08e5               L5501:
5126                     ; 3628 	    case 5:  IO_8to1 |= (uint8_t)0x04;     parse_complete = 1; break; // Relay-03 ON
5128  08e5 72140000      	bset	_IO_8to1,#2
5131  08e9 35010000      	mov	_parse_complete,#1
5134  08ed cc09d2        	jra	L5102
5135  08f0               L7501:
5136                     ; 3629 	    case 6:  IO_8to1 &= (uint8_t)(~0x08);  parse_complete = 1; break; // Relay-04 OFF
5138  08f0 72170000      	bres	_IO_8to1,#3
5141  08f4 35010000      	mov	_parse_complete,#1
5144  08f8 cc09d2        	jra	L5102
5145  08fb               L1601:
5146                     ; 3630 	    case 7:  IO_8to1 |= (uint8_t)0x08;     parse_complete = 1; break; // Relay-04 ON
5148  08fb 72160000      	bset	_IO_8to1,#3
5151  08ff 35010000      	mov	_parse_complete,#1
5154  0903 cc09d2        	jra	L5102
5155  0906               L3601:
5156                     ; 3631 	    case 8:  IO_8to1 &= (uint8_t)(~0x10);  parse_complete = 1; break; // Relay-05 OFF
5158  0906 72190000      	bres	_IO_8to1,#4
5161  090a 35010000      	mov	_parse_complete,#1
5164  090e cc09d2        	jra	L5102
5165  0911               L5601:
5166                     ; 3632 	    case 9:  IO_8to1 |= (uint8_t)0x10;     parse_complete = 1; break; // Relay-05 ON
5168  0911 72180000      	bset	_IO_8to1,#4
5171  0915 35010000      	mov	_parse_complete,#1
5174  0919 cc09d2        	jra	L5102
5175  091c               L7601:
5176                     ; 3633 	    case 10: IO_8to1 &= (uint8_t)(~0x20);  parse_complete = 1; break; // Relay-06 OFF
5178  091c 721b0000      	bres	_IO_8to1,#5
5181  0920 35010000      	mov	_parse_complete,#1
5184  0924 cc09d2        	jra	L5102
5185  0927               L1701:
5186                     ; 3634 	    case 11: IO_8to1 |= (uint8_t)0x20;     parse_complete = 1; break; // Relay-06 ON
5188  0927 721a0000      	bset	_IO_8to1,#5
5191  092b 35010000      	mov	_parse_complete,#1
5194  092f cc09d2        	jra	L5102
5195  0932               L3701:
5196                     ; 3635 	    case 12: IO_8to1 &= (uint8_t)(~0x40);  parse_complete = 1; break; // Relay-07 OFF
5198  0932 721d0000      	bres	_IO_8to1,#6
5201  0936 35010000      	mov	_parse_complete,#1
5204  093a cc09d2        	jra	L5102
5205  093d               L5701:
5206                     ; 3636 	    case 13: IO_8to1 |= (uint8_t)0x40;     parse_complete = 1; break; // Relay-07 ON
5208  093d 721c0000      	bset	_IO_8to1,#6
5211  0941 35010000      	mov	_parse_complete,#1
5214  0945 cc09d2        	jra	L5102
5215  0948               L7701:
5216                     ; 3637 	    case 14: IO_8to1 &= (uint8_t)(~0x80);  parse_complete = 1; break; // Relay-08 OFF
5218  0948 721f0000      	bres	_IO_8to1,#7
5221  094c 35010000      	mov	_parse_complete,#1
5224  0950 cc09d2        	jra	L5102
5225  0953               L1011:
5226                     ; 3638 	    case 15: IO_8to1 |= (uint8_t)0x80;     parse_complete = 1; break; // Relay-08 ON
5228  0953 721e0000      	bset	_IO_8to1,#7
5231  0957 35010000      	mov	_parse_complete,#1
5234  095b 2075          	jra	L5102
5235  095d               L3011:
5236                     ; 3640 	    case 55:
5236                     ; 3641   	      IO_8to1 = (uint8_t)0xff; // Relays 1-8 ON
5238  095d 35ff0000      	mov	_IO_8to1,#255
5239                     ; 3642 	      parse_complete = 1; 
5241  0961 35010000      	mov	_parse_complete,#1
5242                     ; 3643 	      break;
5244  0965 206b          	jra	L5102
5245  0967               L5011:
5246                     ; 3645 	    case 56:
5246                     ; 3646               IO_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
5248  0967 c70000        	ld	_IO_8to1,a
5249                     ; 3647 	      parse_complete = 1; 
5251  096a 35010000      	mov	_parse_complete,#1
5252                     ; 3648 	      break;
5254  096e 2062          	jra	L5102
5255  0970               L7011:
5256                     ; 3655 	    case 60: // Show IO Control page
5256                     ; 3656 	      current_webpage = WEBPAGE_IOCONTROL;
5258  0970 c70003        	ld	_current_webpage,a
5259                     ; 3657               pSocket->pData = g_HtmlPageIOControl;
5261  0973 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5262  0977 ef01          	ldw	(1,x),y
5263                     ; 3658               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5265  0979 90ae0c06      	ldw	y,#3078
5266                     ; 3659               pSocket->nState = STATE_CONNECTED;
5267                     ; 3660               pSocket->nPrevBytes = 0xFFFF;
5268                     ; 3661 	      break;
5270  097d 200e          	jp	LC018
5271  097f               L1111:
5272                     ; 3663 	    case 61: // Show Configuration page
5272                     ; 3664 	      current_webpage = WEBPAGE_CONFIGURATION;
5274  097f 35010003      	mov	_current_webpage,#1
5275                     ; 3665               pSocket->pData = g_HtmlPageConfiguration;
5277  0983 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
5278  0987 ef01          	ldw	(1,x),y
5279                     ; 3666               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
5281  0989 90ae0c31      	ldw	y,#3121
5282                     ; 3667               pSocket->nState = STATE_CONNECTED;
5284  098d               LC018:
5285  098d ef03          	ldw	(3,x),y
5289  098f f7            	ld	(x),a
5290                     ; 3668               pSocket->nPrevBytes = 0xFFFF;
5291                     ; 3669 	      break;
5293  0990 203a          	jp	LC017
5294  0992               L3111:
5295                     ; 3689 	    case 65: // Flash LED for diagnostics
5295                     ; 3690 	      // XXXXXXXXXXXXXXXXXXXXXX
5295                     ; 3691 	      // XXXXXXXXXXXXXXXXXXXXXX
5295                     ; 3692 	      // XXXXXXXXXXXXXXXXXXXXXX
5295                     ; 3693 	      debugflash();
5297  0992 cd0000        	call	_debugflash
5299                     ; 3694 	      debugflash();
5301  0995 cd0000        	call	_debugflash
5303                     ; 3695 	      debugflash();
5305  0998 cd0000        	call	_debugflash
5307                     ; 3699 	      break;
5309  099b 2035          	jra	L5102
5310  099d               L5111:
5311                     ; 3734 	    case 91: // Reboot
5311                     ; 3735 	      user_reboot_request = 1;
5313  099d 35010000      	mov	_user_reboot_request,#1
5314                     ; 3736 	      break;
5316  09a1 202f          	jra	L5102
5317  09a3               L7111:
5318                     ; 3738             case 98: // Show Very Short Form IO state page
5318                     ; 3739 	      // Normally when a page is transmitted the "current_webpage" is
5318                     ; 3740 	      // updated to reflect the page just transmitted. This is not
5318                     ; 3741 	      // done for this case as the page is very short (only requires
5318                     ; 3742 	      // one packet to send) and not changing the current_webpage
5318                     ; 3743 	      // pointer prevents "page interference" between normal browser
5318                     ; 3744 	      // activity and the automated functions that normally use this
5318                     ; 3745 	      // page.
5318                     ; 3746 	      // current_webpage = WEBPAGE_SSTATE;
5318                     ; 3747               pSocket->pData = g_HtmlPageSstate;
5320  09a3 90ae18c8      	ldw	y,#L12_g_HtmlPageSstate
5321  09a7 ef01          	ldw	(1,x),y
5322                     ; 3748               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
5324  09a9 90ae0004      	ldw	y,#4
5325                     ; 3749               pSocket->nState = STATE_CONNECTED;
5326                     ; 3750               pSocket->nPrevBytes = 0xFFFF;
5327                     ; 3751 	      break;
5329  09ad 20de          	jp	LC018
5330  09af               L1211:
5331                     ; 3753             case 99: // Show Short Form IO state page
5331                     ; 3754 	      // Normally when a page is transmitted the "current_webpage" is
5331                     ; 3755 	      // updated to reflect the page just transmitted. This is not
5331                     ; 3756 	      // done for this case as the page is very short (only requires
5331                     ; 3757 	      // one packet to send) and not changing the current_webpage
5331                     ; 3758 	      // pointer prevents "page interference" between normal browser
5331                     ; 3759 	      // activity and the automated functions that normally use this
5331                     ; 3760 	      // page.
5331                     ; 3761 	      // current_webpage = WEBPAGE_RSTATE;
5331                     ; 3762               pSocket->pData = g_HtmlPageRstate;
5333  09af 90ae1841      	ldw	y,#L71_g_HtmlPageRstate
5334  09b3 ef01          	ldw	(1,x),y
5335                     ; 3763               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
5337  09b5 90ae0086      	ldw	y,#134
5338                     ; 3764               pSocket->nState = STATE_CONNECTED;
5339                     ; 3765               pSocket->nPrevBytes = 0xFFFF;
5340                     ; 3766 	      break;
5342  09b9 20d2          	jp	LC018
5343  09bb               L3211:
5344                     ; 3768 	    default: // Show IO Control page
5344                     ; 3769 	      current_webpage = WEBPAGE_IOCONTROL;
5346  09bb 725f0003      	clr	_current_webpage
5347                     ; 3770               pSocket->pData = g_HtmlPageIOControl;
5349  09bf 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5350  09c3 ef01          	ldw	(1,x),y
5351                     ; 3771               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5353  09c5 90ae0c06      	ldw	y,#3078
5354  09c9 ef03          	ldw	(3,x),y
5355                     ; 3772               pSocket->nState = STATE_CONNECTED;
5357  09cb 7f            	clr	(x)
5358                     ; 3773               pSocket->nPrevBytes = 0xFFFF;
5360  09cc               LC017:
5365  09cc 90aeffff      	ldw	y,#65535
5366  09d0 ef0b          	ldw	(11,x),y
5367                     ; 3774 	      break;
5369  09d2               L5102:
5370                     ; 3776           pSocket->nParseLeft = 0;
5372  09d2 1e0b          	ldw	x,(OFST+7,sp)
5373  09d4 6f06          	clr	(6,x)
5374  09d6               L3671:
5375                     ; 3779         if (pSocket->ParseState == PARSE_FAIL) {
5377  09d6 1e0b          	ldw	x,(OFST+7,sp)
5378  09d8 e60a          	ld	a,(10,x)
5379  09da a107          	cp	a,#7
5380                     ; 3784           pSocket->nState = STATE_SENDHEADER;
5381                     ; 3785 	  break;
5383  09dc 2704          	jreq	LC022
5384                     ; 3788         if (pSocket->nParseLeft == 0) {
5386  09de e606          	ld	a,(6,x)
5387  09e0 2605          	jrne	L1571
5388                     ; 3791           pSocket->nState = STATE_SENDHEADER;
5390  09e2               LC022:
5392  09e2 a60b          	ld	a,#11
5393  09e4 f7            	ld	(x),a
5394                     ; 3792           break;
5396  09e5 2007          	jra	L5471
5397  09e7               L1571:
5398                     ; 3433       while (nBytes != 0) {
5400  09e7 1e09          	ldw	x,(OFST+5,sp)
5401  09e9 2703cc07a2    	jrne	L7471
5402  09ee               L5471:
5403                     ; 3797     if (pSocket->nState == STATE_SENDHEADER) {
5405  09ee 1e0b          	ldw	x,(OFST+7,sp)
5406  09f0 f6            	ld	a,(x)
5407  09f1 a10b          	cp	a,#11
5408  09f3 261c          	jrne	L5211
5409                     ; 3803       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5411  09f5 cd0000        	call	_adjust_template_size
5413  09f8 89            	pushw	x
5414  09f9 ce0000        	ldw	x,_uip_appdata
5415  09fc cd0000        	call	L5_CopyHttpHeader
5417  09ff 5b02          	addw	sp,#2
5418  0a01 89            	pushw	x
5419  0a02 ce0000        	ldw	x,_uip_appdata
5420  0a05 cd0000        	call	_uip_send
5422  0a08 85            	popw	x
5423                     ; 3804       pSocket->nState = STATE_SENDDATA;
5425  0a09 1e0b          	ldw	x,(OFST+7,sp)
5426  0a0b a60c          	ld	a,#12
5427  0a0d f7            	ld	(x),a
5428                     ; 3805       return;
5430  0a0e cc012f        	jra	L242
5431  0a11               L5211:
5432                     ; 3808     senddata:
5432                     ; 3809     if (pSocket->nState == STATE_SENDDATA) {
5434  0a11 1e0b          	ldw	x,(OFST+7,sp)
5435  0a13 f6            	ld	a,(x)
5436  0a14 a10c          	cp	a,#12
5437  0a16 26f6          	jrne	L242
5438                     ; 3816       if (pSocket->nDataLeft == 0) {
5440  0a18 e604          	ld	a,(4,x)
5441  0a1a ea03          	or	a,(3,x)
5442  0a1c 2605          	jrne	L7202
5443                     ; 3818         nBufSize = 0;
5445  0a1e 5f            	clrw	x
5446  0a1f 1f02          	ldw	(OFST-2,sp),x
5449  0a21 202f          	jra	L1302
5450  0a23               L7202:
5451                     ; 3821         pSocket->nPrevBytes = pSocket->nDataLeft;
5453  0a23 9093          	ldw	y,x
5454  0a25 90ee03        	ldw	y,(3,y)
5455  0a28 ef0b          	ldw	(11,x),y
5456                     ; 3822         nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5458  0a2a ce0000        	ldw	x,_uip_conn
5459  0a2d ee12          	ldw	x,(18,x)
5460  0a2f 89            	pushw	x
5461  0a30 1e0d          	ldw	x,(OFST+9,sp)
5462  0a32 1c0003        	addw	x,#3
5463  0a35 89            	pushw	x
5464  0a36 1e0f          	ldw	x,(OFST+11,sp)
5465  0a38 5c            	incw	x
5466  0a39 89            	pushw	x
5467  0a3a ce0000        	ldw	x,_uip_appdata
5468  0a3d cd0000        	call	L7_CopyHttpData
5470  0a40 5b06          	addw	sp,#6
5471  0a42 1f02          	ldw	(OFST-2,sp),x
5473                     ; 3823         pSocket->nPrevBytes -= pSocket->nDataLeft;
5475  0a44 1e0b          	ldw	x,(OFST+7,sp)
5476  0a46 e60c          	ld	a,(12,x)
5477  0a48 e004          	sub	a,(4,x)
5478  0a4a e70c          	ld	(12,x),a
5479  0a4c e60b          	ld	a,(11,x)
5480  0a4e e203          	sbc	a,(3,x)
5481  0a50 e70b          	ld	(11,x),a
5482  0a52               L1302:
5483                     ; 3826       if (nBufSize == 0) {
5485  0a52 1e02          	ldw	x,(OFST-2,sp)
5486  0a54 2621          	jrne	LC014
5487                     ; 3828         uip_close();
5489  0a56               LC015:
5491  0a56 35100000      	mov	_uip_flags,#16
5493  0a5a cc012f        	jra	L242
5494                     ; 3832         uip_send(uip_appdata, nBufSize);
5496                     ; 3834       return;
5498  0a5d               L7321:
5499                     ; 3838   else if (uip_rexmit()) {
5501  0a5d 7205000075    	btjf	_uip_flags,#2,L5321
5502                     ; 3839     if (pSocket->nPrevBytes == 0xFFFF) {
5504  0a62 160b          	ldw	y,(OFST+7,sp)
5505  0a64 90ee0b        	ldw	y,(11,y)
5506  0a67 905c          	incw	y
5507  0a69 2617          	jrne	L3402
5508                     ; 3841       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5510  0a6b cd0000        	call	_adjust_template_size
5512  0a6e 89            	pushw	x
5513  0a6f ce0000        	ldw	x,_uip_appdata
5514  0a72 cd0000        	call	L5_CopyHttpHeader
5516  0a75 5b02          	addw	sp,#2
5518  0a77               LC014:
5520  0a77 89            	pushw	x
5521  0a78 ce0000        	ldw	x,_uip_appdata
5522  0a7b cd0000        	call	_uip_send
5523  0a7e 85            	popw	x
5525  0a7f cc012f        	jra	L242
5526  0a82               L3402:
5527                     ; 3844       pSocket->pData -= pSocket->nPrevBytes;
5529  0a82 1e0b          	ldw	x,(OFST+7,sp)
5530  0a84 e602          	ld	a,(2,x)
5531  0a86 e00c          	sub	a,(12,x)
5532  0a88 e702          	ld	(2,x),a
5533  0a8a e601          	ld	a,(1,x)
5534  0a8c e20b          	sbc	a,(11,x)
5535  0a8e e701          	ld	(1,x),a
5536                     ; 3845       pSocket->nDataLeft += pSocket->nPrevBytes;
5538  0a90 e604          	ld	a,(4,x)
5539  0a92 eb0c          	add	a,(12,x)
5540  0a94 e704          	ld	(4,x),a
5541  0a96 e603          	ld	a,(3,x)
5542  0a98 e90b          	adc	a,(11,x)
5543                     ; 3846       pSocket->nPrevBytes = pSocket->nDataLeft;
5545  0a9a 9093          	ldw	y,x
5546  0a9c e703          	ld	(3,x),a
5547  0a9e 90ee03        	ldw	y,(3,y)
5548  0aa1 ef0b          	ldw	(11,x),y
5549                     ; 3847       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5551  0aa3 ce0000        	ldw	x,_uip_conn
5552  0aa6 ee12          	ldw	x,(18,x)
5553  0aa8 89            	pushw	x
5554  0aa9 1e0d          	ldw	x,(OFST+9,sp)
5555  0aab 1c0003        	addw	x,#3
5556  0aae 89            	pushw	x
5557  0aaf 1e0f          	ldw	x,(OFST+11,sp)
5558  0ab1 5c            	incw	x
5559  0ab2 89            	pushw	x
5560  0ab3 ce0000        	ldw	x,_uip_appdata
5561  0ab6 cd0000        	call	L7_CopyHttpData
5563  0ab9 5b06          	addw	sp,#6
5564  0abb 1f02          	ldw	(OFST-2,sp),x
5566                     ; 3848       pSocket->nPrevBytes -= pSocket->nDataLeft;
5568  0abd 1e0b          	ldw	x,(OFST+7,sp)
5569  0abf e60c          	ld	a,(12,x)
5570  0ac1 e004          	sub	a,(4,x)
5571  0ac3 e70c          	ld	(12,x),a
5572  0ac5 e60b          	ld	a,(11,x)
5573  0ac7 e203          	sbc	a,(3,x)
5574  0ac9 e70b          	ld	(11,x),a
5575                     ; 3849       if (nBufSize == 0) {
5577  0acb 1e02          	ldw	x,(OFST-2,sp)
5578                     ; 3851         uip_close();
5580  0acd 2787          	jreq	LC015
5581                     ; 3855         uip_send(uip_appdata, nBufSize);
5583  0acf 89            	pushw	x
5584  0ad0 ce0000        	ldw	x,_uip_appdata
5585  0ad3 cd0000        	call	_uip_send
5587  0ad6 85            	popw	x
5588                     ; 3858     return;
5590  0ad7               L5321:
5591                     ; 3860 }
5593  0ad7 cc012f        	jra	L242
5627                     ; 3863 void clear_saved_postpartial_all(void)
5627                     ; 3864 {
5628                     .text:	section	.text,new
5629  0000               _clear_saved_postpartial_all:
5631  0000 88            	push	a
5632       00000001      OFST:	set	1
5635                     ; 3866   for (i=0; i<24; i++) saved_postpartial[i] = '\0';
5637  0001 4f            	clr	a
5638  0002 6b01          	ld	(OFST+0,sp),a
5640  0004               L7602:
5643  0004 5f            	clrw	x
5644  0005 97            	ld	xl,a
5645  0006 724f002a      	clr	(_saved_postpartial,x)
5648  000a 0c01          	inc	(OFST+0,sp)
5652  000c 7b01          	ld	a,(OFST+0,sp)
5653  000e a118          	cp	a,#24
5654  0010 25f2          	jrult	L7602
5655                     ; 3867 }
5658  0012 84            	pop	a
5659  0013 81            	ret	
5693                     ; 3870 void clear_saved_postpartial_data(void)
5693                     ; 3871 {
5694                     .text:	section	.text,new
5695  0000               _clear_saved_postpartial_data:
5697  0000 88            	push	a
5698       00000001      OFST:	set	1
5701                     ; 3873   for (i=4; i<24; i++) saved_postpartial[i] = '\0';
5703  0001 a604          	ld	a,#4
5704  0003 6b01          	ld	(OFST+0,sp),a
5706  0005               L1112:
5709  0005 5f            	clrw	x
5710  0006 97            	ld	xl,a
5711  0007 724f002a      	clr	(_saved_postpartial,x)
5714  000b 0c01          	inc	(OFST+0,sp)
5718  000d 7b01          	ld	a,(OFST+0,sp)
5719  000f a118          	cp	a,#24
5720  0011 25f2          	jrult	L1112
5721                     ; 3874 }
5724  0013 84            	pop	a
5725  0014 81            	ret	
5759                     ; 3877 void clear_saved_postpartial_previous(void)
5759                     ; 3878 {
5760                     .text:	section	.text,new
5761  0000               _clear_saved_postpartial_previous:
5763  0000 88            	push	a
5764       00000001      OFST:	set	1
5767                     ; 3880   for (i=0; i<24; i++) saved_postpartial_previous[i] = '\0';
5769  0001 4f            	clr	a
5770  0002 6b01          	ld	(OFST+0,sp),a
5772  0004               L3312:
5775  0004 5f            	clrw	x
5776  0005 97            	ld	xl,a
5777  0006 724f0012      	clr	(_saved_postpartial_previous,x)
5780  000a 0c01          	inc	(OFST+0,sp)
5784  000c 7b01          	ld	a,(OFST+0,sp)
5785  000e a118          	cp	a,#24
5786  0010 25f2          	jrult	L3312
5787                     ; 3881 }
5790  0012 84            	pop	a
5791  0013 81            	ret	
5881                     ; 3884 void parse_POST_string(uint8_t curr_ParseCmd, uint8_t num_chars)
5881                     ; 3885 {
5882                     .text:	section	.text,new
5883  0000               _parse_POST_string:
5885  0000 89            	pushw	x
5886  0001 5217          	subw	sp,#23
5887       00000017      OFST:	set	23
5890                     ; 3908   amp_found = 0;
5892  0003 0f02          	clr	(OFST-21,sp)
5894                     ; 3909   for (i=0; i<20; i++) tmp_Pending[i] = '\0';
5896  0005 0f17          	clr	(OFST+0,sp)
5898  0007               L3712:
5901  0007 96            	ldw	x,sp
5902  0008 1c0003        	addw	x,#OFST-20
5903  000b 9f            	ld	a,xl
5904  000c 5e            	swapw	x
5905  000d 1b17          	add	a,(OFST+0,sp)
5906  000f 2401          	jrnc	L452
5907  0011 5c            	incw	x
5908  0012               L452:
5909  0012 02            	rlwa	x,a
5910  0013 7f            	clr	(x)
5913  0014 0c17          	inc	(OFST+0,sp)
5917  0016 7b17          	ld	a,(OFST+0,sp)
5918  0018 a114          	cp	a,#20
5919  001a 25eb          	jrult	L3712
5920                     ; 3911   if (saved_postpartial_previous[0] == curr_ParseCmd) {
5922  001c c60012        	ld	a,_saved_postpartial_previous
5923  001f 1118          	cp	a,(OFST+1,sp)
5924  0021 260a          	jrne	L1022
5925                     ; 3914     saved_postpartial_previous[0] = '\0';
5927  0023 725f0012      	clr	_saved_postpartial_previous
5928                     ; 3920     frag_flag = 1; // frag_flag is used to manage the TCP Fragment restore
5930  0027 a601          	ld	a,#1
5931  0029 6b17          	ld	(OFST+0,sp),a
5934  002b 2005          	jra	L3022
5935  002d               L1022:
5936                     ; 3924     frag_flag = 0;
5938  002d 0f17          	clr	(OFST+0,sp)
5940                     ; 3928     clear_saved_postpartial_data(); // Clear [4] and higher
5942  002f cd0000        	call	_clear_saved_postpartial_data
5944  0032               L3022:
5945                     ; 3949   resume = 0;
5947  0032 0f01          	clr	(OFST-22,sp)
5949                     ; 3950   if (frag_flag == 1) {
5951  0034 7b17          	ld	a,(OFST+0,sp)
5952  0036 4a            	dec	a
5953  0037 263f          	jrne	L5022
5954                     ; 3952     for (i = 0; i < num_chars; i++) {
5956  0039 6b17          	ld	(OFST+0,sp),a
5959  003b 2033          	jra	L3122
5960  003d               L7022:
5961                     ; 3961       if (saved_postpartial_previous[4+i] != '\0') {
5963  003d 5f            	clrw	x
5964  003e 97            	ld	xl,a
5965  003f 724d0016      	tnz	(_saved_postpartial_previous+4,x)
5966  0043 271b          	jreq	L7122
5967                     ; 3962         tmp_Pending[i] = saved_postpartial_previous[4+i];
5969  0045 96            	ldw	x,sp
5970  0046 1c0003        	addw	x,#OFST-20
5971  0049 9f            	ld	a,xl
5972  004a 5e            	swapw	x
5973  004b 1b17          	add	a,(OFST+0,sp)
5974  004d 2401          	jrnc	L062
5975  004f 5c            	incw	x
5976  0050               L062:
5977  0050 02            	rlwa	x,a
5978  0051 7b17          	ld	a,(OFST+0,sp)
5979  0053 905f          	clrw	y
5980  0055 9097          	ld	yl,a
5981  0057 90d60016      	ld	a,(_saved_postpartial_previous+4,y)
5982  005b f7            	ld	(x),a
5984                     ; 3952     for (i = 0; i < num_chars; i++) {
5986  005c 0c17          	inc	(OFST+0,sp)
5988  005e 2010          	jra	L3122
5989  0060               L7122:
5990                     ; 3965         resume = i;
5992  0060 6b01          	ld	(OFST-22,sp),a
5994                     ; 3966         break;
5995  0062               L5122:
5996                     ; 3969     if (*tmp_pBuffer == '&') {
5998  0062 72c6000e      	ld	a,[_tmp_pBuffer.w]
5999  0066 a126          	cp	a,#38
6000  0068 260e          	jrne	L5022
6001                     ; 3973       amp_found = 1;
6003  006a a601          	ld	a,#1
6004  006c 6b02          	ld	(OFST-21,sp),a
6006  006e 2008          	jra	L5022
6007  0070               L3122:
6008                     ; 3952     for (i = 0; i < num_chars; i++) {
6010  0070 7b17          	ld	a,(OFST+0,sp)
6011  0072 1119          	cp	a,(OFST+2,sp)
6012  0074 25c7          	jrult	L7022
6013  0076 20ea          	jra	L5122
6014  0078               L5022:
6015                     ; 3985   if (amp_found == 0) {
6017  0078 7b02          	ld	a,(OFST-21,sp)
6018  007a 2703cc0104    	jrne	L5222
6019                     ; 3986     for (i = resume; i < num_chars; i++) {
6021  007f 7b01          	ld	a,(OFST-22,sp)
6022  0081 6b17          	ld	(OFST+0,sp),a
6025  0083 207b          	jra	L3322
6026  0085               L7222:
6027                     ; 3989       if (amp_found == 0) {
6029  0085 7b02          	ld	a,(OFST-21,sp)
6030  0087 265d          	jrne	L7322
6031                     ; 3992         if (*tmp_pBuffer == '&') {
6033  0089 72c6000e      	ld	a,[_tmp_pBuffer.w]
6034  008d a126          	cp	a,#38
6035  008f 2606          	jrne	L1422
6036                     ; 3995           amp_found = 1;
6038  0091 a601          	ld	a,#1
6039  0093 6b02          	ld	(OFST-21,sp),a
6042  0095 204f          	jra	L7322
6043  0097               L1422:
6044                     ; 3998           tmp_Pending[i] = *tmp_pBuffer;
6046  0097 96            	ldw	x,sp
6047  0098 1c0003        	addw	x,#OFST-20
6048  009b 9f            	ld	a,xl
6049  009c 5e            	swapw	x
6050  009d 1b17          	add	a,(OFST+0,sp)
6051  009f 2401          	jrnc	L262
6052  00a1 5c            	incw	x
6053  00a2               L262:
6054  00a2 90ce000e      	ldw	y,_tmp_pBuffer
6055  00a6 02            	rlwa	x,a
6056  00a7 90f6          	ld	a,(y)
6057  00a9 f7            	ld	(x),a
6058                     ; 3999           saved_postpartial[4+i] = *tmp_pBuffer;
6060  00aa 5f            	clrw	x
6061  00ab 7b17          	ld	a,(OFST+0,sp)
6062  00ad 97            	ld	xl,a
6063  00ae 90f6          	ld	a,(y)
6064  00b0 d7002e        	ld	(_saved_postpartial+4,x),a
6065                     ; 4000           tmp_nParseLeft--;
6067  00b3 725a000b      	dec	_tmp_nParseLeft
6068                     ; 4001           saved_nparseleft = tmp_nParseLeft;
6070                     ; 4002           tmp_pBuffer++;
6072  00b7 93            	ldw	x,y
6073  00b8 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6074  00bd 5c            	incw	x
6075  00be cf000e        	ldw	_tmp_pBuffer,x
6076                     ; 4003           tmp_nBytes--;
6078  00c1 ce000c        	ldw	x,_tmp_nBytes
6079  00c4 5a            	decw	x
6080  00c5 cf000c        	ldw	_tmp_nBytes,x
6081                     ; 4004           if (tmp_nBytes == 0) {
6083  00c8 261c          	jrne	L7322
6084                     ; 4008             if (i == (num_chars - 1)) {
6086  00ca 7b19          	ld	a,(OFST+2,sp)
6087  00cc 5f            	clrw	x
6088  00cd 97            	ld	xl,a
6089  00ce 5a            	decw	x
6090  00cf 7b17          	ld	a,(OFST+0,sp)
6091  00d1 905f          	clrw	y
6092  00d3 9097          	ld	yl,a
6093  00d5 90bf00        	ldw	c_y,y
6094  00d8 b300          	cpw	x,c_y
6095  00da 2604          	jrne	L7422
6096                     ; 4013               saved_parsestate = PARSE_DELIM;
6098  00dc 35050043      	mov	_saved_parsestate,#5
6099  00e0               L7422:
6100                     ; 4015             break_while = 1;
6102  00e0 3501000a      	mov	_break_while,#1
6103                     ; 4016             break; // This will break the for() loop. But we need to break the
6105  00e4 201e          	jra	L5222
6106  00e6               L7322:
6107                     ; 4022       if (amp_found == 1) {
6109  00e6 7b02          	ld	a,(OFST-21,sp)
6110  00e8 4a            	dec	a
6111  00e9 2611          	jrne	L1522
6112                     ; 4025         tmp_Pending[i] = '\0';
6114  00eb 96            	ldw	x,sp
6115  00ec 1c0003        	addw	x,#OFST-20
6116  00ef 9f            	ld	a,xl
6117  00f0 5e            	swapw	x
6118  00f1 1b17          	add	a,(OFST+0,sp)
6119  00f3 2401          	jrnc	L462
6120  00f5 5c            	incw	x
6121  00f6               L462:
6122  00f6 02            	rlwa	x,a
6123  00f7 7f            	clr	(x)
6124                     ; 4034         tmp_nParseLeft--;
6126  00f8 725a000b      	dec	_tmp_nParseLeft
6127  00fc               L1522:
6128                     ; 3986     for (i = resume; i < num_chars; i++) {
6130  00fc 0c17          	inc	(OFST+0,sp)
6132  00fe 7b17          	ld	a,(OFST+0,sp)
6133  0100               L3322:
6136  0100 1119          	cp	a,(OFST+2,sp)
6137  0102 2581          	jrult	L7222
6138  0104               L5222:
6139                     ; 4055   if (break_while == 0) clear_saved_postpartial_all();
6141  0104 c6000a        	ld	a,_break_while
6142  0107 2603          	jrne	L3522
6145  0109 cd0000        	call	_clear_saved_postpartial_all
6147  010c               L3522:
6148                     ; 4058   if (curr_ParseCmd == 'a') {
6150  010c 7b18          	ld	a,(OFST+1,sp)
6151  010e a161          	cp	a,#97
6152  0110 2622          	jrne	L5522
6153                     ; 4059     for (i=0; i<num_chars; i++) Pending_devicename[i] = tmp_Pending[i];
6155  0112 0f17          	clr	(OFST+0,sp)
6158  0114 2016          	jra	L3622
6159  0116               L7522:
6162  0116 5f            	clrw	x
6163  0117 97            	ld	xl,a
6164  0118 89            	pushw	x
6165  0119 96            	ldw	x,sp
6166  011a 1c0005        	addw	x,#OFST-18
6167  011d 9f            	ld	a,xl
6168  011e 5e            	swapw	x
6169  011f 1b19          	add	a,(OFST+2,sp)
6170  0121 2401          	jrnc	L072
6171  0123 5c            	incw	x
6172  0124               L072:
6173  0124 02            	rlwa	x,a
6174  0125 f6            	ld	a,(x)
6175  0126 85            	popw	x
6176  0127 d70000        	ld	(_Pending_devicename,x),a
6179  012a 0c17          	inc	(OFST+0,sp)
6181  012c               L3622:
6184  012c 7b17          	ld	a,(OFST+0,sp)
6185  012e 1119          	cp	a,(OFST+2,sp)
6186  0130 25e4          	jrult	L7522
6188  0132 204a          	jra	L7622
6189  0134               L5522:
6190                     ; 4064   else if (curr_ParseCmd == 'l') {
6192  0134 a16c          	cp	a,#108
6193  0136 2622          	jrne	L1722
6194                     ; 4065     for (i=0; i<num_chars; i++) Pending_mqtt_username[i] = tmp_Pending[i];
6196  0138 0f17          	clr	(OFST+0,sp)
6199  013a 2016          	jra	L7722
6200  013c               L3722:
6203  013c 5f            	clrw	x
6204  013d 97            	ld	xl,a
6205  013e 89            	pushw	x
6206  013f 96            	ldw	x,sp
6207  0140 1c0005        	addw	x,#OFST-18
6208  0143 9f            	ld	a,xl
6209  0144 5e            	swapw	x
6210  0145 1b19          	add	a,(OFST+2,sp)
6211  0147 2401          	jrnc	L272
6212  0149 5c            	incw	x
6213  014a               L272:
6214  014a 02            	rlwa	x,a
6215  014b f6            	ld	a,(x)
6216  014c 85            	popw	x
6217  014d d70000        	ld	(_Pending_mqtt_username,x),a
6220  0150 0c17          	inc	(OFST+0,sp)
6222  0152               L7722:
6225  0152 7b17          	ld	a,(OFST+0,sp)
6226  0154 1119          	cp	a,(OFST+2,sp)
6227  0156 25e4          	jrult	L3722
6229  0158 2024          	jra	L7622
6230  015a               L1722:
6231                     ; 4069   else if (curr_ParseCmd == 'm') {
6233  015a a16d          	cp	a,#109
6234  015c 2620          	jrne	L7622
6235                     ; 4070     for (i=0; i<num_chars; i++) Pending_mqtt_password[i] = tmp_Pending[i];
6237  015e 0f17          	clr	(OFST+0,sp)
6240  0160 2016          	jra	L3132
6241  0162               L7032:
6244  0162 5f            	clrw	x
6245  0163 97            	ld	xl,a
6246  0164 89            	pushw	x
6247  0165 96            	ldw	x,sp
6248  0166 1c0005        	addw	x,#OFST-18
6249  0169 9f            	ld	a,xl
6250  016a 5e            	swapw	x
6251  016b 1b19          	add	a,(OFST+2,sp)
6252  016d 2401          	jrnc	L472
6253  016f 5c            	incw	x
6254  0170               L472:
6255  0170 02            	rlwa	x,a
6256  0171 f6            	ld	a,(x)
6257  0172 85            	popw	x
6258  0173 d70000        	ld	(_Pending_mqtt_password,x),a
6261  0176 0c17          	inc	(OFST+0,sp)
6263  0178               L3132:
6266  0178 7b17          	ld	a,(OFST+0,sp)
6267  017a 1119          	cp	a,(OFST+2,sp)
6268  017c 25e4          	jrult	L7032
6269  017e               L7622:
6270                     ; 4073 }
6273  017e 5b19          	addw	sp,#25
6274  0180 81            	ret	
6348                     	switch	.const
6349  1b88               L603:
6350  1b88 00de          	dc.w	L7132
6351  1b8a 00e5          	dc.w	L1232
6352  1b8c 00ec          	dc.w	L3232
6353  1b8e 00f3          	dc.w	L5232
6354  1b90 00fa          	dc.w	L7232
6355  1b92 0101          	dc.w	L1332
6356  1b94 0108          	dc.w	L3332
6357  1b96 010f          	dc.w	L5332
6358  1b98 0116          	dc.w	L7332
6359  1b9a 011d          	dc.w	L1432
6360  1b9c 0124          	dc.w	L3432
6361  1b9e 012b          	dc.w	L5432
6362  1ba0 0132          	dc.w	L7432
6363  1ba2 0139          	dc.w	L1532
6364  1ba4 0140          	dc.w	L3532
6365  1ba6 0147          	dc.w	L5532
6366                     ; 4076 void parse_POST_address(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6366                     ; 4077 {
6367                     .text:	section	.text,new
6368  0000               _parse_POST_address:
6370  0000 89            	pushw	x
6371  0001 89            	pushw	x
6372       00000002      OFST:	set	2
6375                     ; 4080   alpha[0] = '-';
6377  0002 352d0004      	mov	_alpha,#45
6378                     ; 4081   alpha[1] = '-';
6380  0006 352d0005      	mov	_alpha+1,#45
6381                     ; 4082   alpha[2] = '-';
6383  000a 352d0006      	mov	_alpha+2,#45
6384                     ; 4085   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6386  000e 9e            	ld	a,xh
6387  000f c10012        	cp	a,_saved_postpartial_previous
6388  0012 2624          	jrne	L5042
6389                     ; 4088     saved_postpartial_previous[0] = '\0';
6391  0014 725f0012      	clr	_saved_postpartial_previous
6392                     ; 4095     if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
6394  0018 c60016        	ld	a,_saved_postpartial_previous+4
6395  001b 2705          	jreq	L7042
6398  001d 5500160004    	mov	_alpha,_saved_postpartial_previous+4
6399  0022               L7042:
6400                     ; 4096     if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
6402  0022 c60017        	ld	a,_saved_postpartial_previous+5
6403  0025 2705          	jreq	L1142
6406  0027 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
6407  002c               L1142:
6408                     ; 4097     if (saved_postpartial_previous[6] != '\0') alpha[2] = saved_postpartial_previous[6];
6410  002c c60018        	ld	a,_saved_postpartial_previous+6
6411  002f 270a          	jreq	L5142
6414  0031 5500180006    	mov	_alpha+2,_saved_postpartial_previous+6
6415  0036 2003          	jra	L5142
6416  0038               L5042:
6417                     ; 4103     clear_saved_postpartial_data(); // Clear [4] and higher
6419  0038 cd0000        	call	_clear_saved_postpartial_data
6421  003b               L5142:
6422                     ; 4106   for (i=0; i<3; i++) {
6424  003b 4f            	clr	a
6425  003c 6b02          	ld	(OFST+0,sp),a
6427  003e               L7142:
6428                     ; 4112     if (alpha[i] == '-') {
6430  003e 5f            	clrw	x
6431  003f 97            	ld	xl,a
6432  0040 d60004        	ld	a,(_alpha,x)
6433  0043 a12d          	cp	a,#45
6434  0045 263c          	jrne	L5242
6435                     ; 4113       alpha[i] = (uint8_t)(*tmp_pBuffer);
6437  0047 7b02          	ld	a,(OFST+0,sp)
6438  0049 5f            	clrw	x
6439  004a 90ce000e      	ldw	y,_tmp_pBuffer
6440  004e 97            	ld	xl,a
6441  004f 90f6          	ld	a,(y)
6442  0051 d70004        	ld	(_alpha,x),a
6443                     ; 4114       saved_postpartial[i+4] = (uint8_t)(*tmp_pBuffer);
6445  0054 5f            	clrw	x
6446  0055 7b02          	ld	a,(OFST+0,sp)
6447  0057 97            	ld	xl,a
6448  0058 90f6          	ld	a,(y)
6449  005a d7002e        	ld	(_saved_postpartial+4,x),a
6450                     ; 4115       tmp_nParseLeft--;
6452  005d 725a000b      	dec	_tmp_nParseLeft
6453                     ; 4116       saved_nparseleft = tmp_nParseLeft;
6455                     ; 4117       tmp_pBuffer++;
6457  0061 93            	ldw	x,y
6458  0062 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6459  0067 5c            	incw	x
6460  0068 cf000e        	ldw	_tmp_pBuffer,x
6461                     ; 4118       tmp_nBytes--;
6463  006b ce000c        	ldw	x,_tmp_nBytes
6464  006e 5a            	decw	x
6465  006f cf000c        	ldw	_tmp_nBytes,x
6466                     ; 4119       if (i != 2 && tmp_nBytes == 0) {
6468  0072 7b02          	ld	a,(OFST+0,sp)
6469  0074 a102          	cp	a,#2
6470  0076 270b          	jreq	L5242
6472  0078 ce000c        	ldw	x,_tmp_nBytes
6473  007b 2606          	jrne	L5242
6474                     ; 4120         break_while = 1; // Hit end of fragment but still have characters to
6476  007d 3501000a      	mov	_break_while,#1
6477                     ; 4124         break; // Break out of for() loop.
6479  0081 2008          	jra	L3242
6480  0083               L5242:
6481                     ; 4106   for (i=0; i<3; i++) {
6483  0083 0c02          	inc	(OFST+0,sp)
6487  0085 7b02          	ld	a,(OFST+0,sp)
6488  0087 a103          	cp	a,#3
6489  0089 25b3          	jrult	L7142
6490  008b               L3242:
6491                     ; 4128   if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
6493  008b c6000a        	ld	a,_break_while
6494  008e 4a            	dec	a
6495  008f 2603cc0155    	jreq	L013
6498                     ; 4132   clear_saved_postpartial_all();
6500  0094 cd0000        	call	_clear_saved_postpartial_all
6502                     ; 4145     invalid = 0;
6504  0097 0f01          	clr	(OFST-1,sp)
6506                     ; 4147     temp = (uint8_t)(       (alpha[2] - '0'));
6508  0099 c60006        	ld	a,_alpha+2
6509  009c a030          	sub	a,#48
6510  009e 6b02          	ld	(OFST+0,sp),a
6512                     ; 4148     temp = (uint8_t)(temp + (alpha[1] - '0') * 10);
6514  00a0 c60005        	ld	a,_alpha+1
6515  00a3 97            	ld	xl,a
6516  00a4 a60a          	ld	a,#10
6517  00a6 42            	mul	x,a
6518  00a7 9f            	ld	a,xl
6519  00a8 a0e0          	sub	a,#224
6520  00aa 1b02          	add	a,(OFST+0,sp)
6521  00ac 6b02          	ld	(OFST+0,sp),a
6523                     ; 4149     if (temp > 55 && alpha[0] > '1') invalid = 1;
6525  00ae a138          	cp	a,#56
6526  00b0 250d          	jrult	L3342
6528  00b2 c60004        	ld	a,_alpha
6529  00b5 a132          	cp	a,#50
6530  00b7 2506          	jrult	L3342
6533  00b9 a601          	ld	a,#1
6534  00bb 6b01          	ld	(OFST-1,sp),a
6537  00bd 200e          	jra	L5342
6538  00bf               L3342:
6539                     ; 4150     else temp = (uint8_t)(temp + (alpha[0] - '0') * 100);
6541  00bf c60004        	ld	a,_alpha
6542  00c2 97            	ld	xl,a
6543  00c3 a664          	ld	a,#100
6544  00c5 42            	mul	x,a
6545  00c6 9f            	ld	a,xl
6546  00c7 a0c0          	sub	a,#192
6547  00c9 1b02          	add	a,(OFST+0,sp)
6548  00cb 6b02          	ld	(OFST+0,sp),a
6550  00cd               L5342:
6551                     ; 4151     if (invalid == 0) { // Make change only if valid entry
6553  00cd 7b01          	ld	a,(OFST-1,sp)
6554  00cf 267b          	jrne	L7342
6555                     ; 4152       switch(curr_ParseNum)
6557  00d1 7b04          	ld	a,(OFST+2,sp)
6559                     ; 4175         default: break;
6560  00d3 a110          	cp	a,#16
6561  00d5 2475          	jruge	L7342
6562  00d7 5f            	clrw	x
6563  00d8 97            	ld	xl,a
6564  00d9 58            	sllw	x
6565  00da de1b88        	ldw	x,(L603,x)
6566  00dd fc            	jp	(x)
6567  00de               L7132:
6568                     ; 4154         case 0:  Pending_hostaddr[3] = (uint8_t)temp; break;
6570  00de 7b02          	ld	a,(OFST+0,sp)
6571  00e0 c70003        	ld	_Pending_hostaddr+3,a
6574  00e3 2067          	jra	L7342
6575  00e5               L1232:
6576                     ; 4155         case 1:  Pending_hostaddr[2] = (uint8_t)temp; break;
6578  00e5 7b02          	ld	a,(OFST+0,sp)
6579  00e7 c70002        	ld	_Pending_hostaddr+2,a
6582  00ea 2060          	jra	L7342
6583  00ec               L3232:
6584                     ; 4156         case 2:  Pending_hostaddr[1] = (uint8_t)temp; break;
6586  00ec 7b02          	ld	a,(OFST+0,sp)
6587  00ee c70001        	ld	_Pending_hostaddr+1,a
6590  00f1 2059          	jra	L7342
6591  00f3               L5232:
6592                     ; 4157         case 3:  Pending_hostaddr[0] = (uint8_t)temp; break;
6594  00f3 7b02          	ld	a,(OFST+0,sp)
6595  00f5 c70000        	ld	_Pending_hostaddr,a
6598  00f8 2052          	jra	L7342
6599  00fa               L7232:
6600                     ; 4158         case 4:  Pending_draddr[3] = (uint8_t)temp; break;
6602  00fa 7b02          	ld	a,(OFST+0,sp)
6603  00fc c70003        	ld	_Pending_draddr+3,a
6606  00ff 204b          	jra	L7342
6607  0101               L1332:
6608                     ; 4159         case 5:  Pending_draddr[2] = (uint8_t)temp; break;
6610  0101 7b02          	ld	a,(OFST+0,sp)
6611  0103 c70002        	ld	_Pending_draddr+2,a
6614  0106 2044          	jra	L7342
6615  0108               L3332:
6616                     ; 4160         case 6:  Pending_draddr[1] = (uint8_t)temp; break;
6618  0108 7b02          	ld	a,(OFST+0,sp)
6619  010a c70001        	ld	_Pending_draddr+1,a
6622  010d 203d          	jra	L7342
6623  010f               L5332:
6624                     ; 4161         case 7:  Pending_draddr[0] = (uint8_t)temp; break;
6626  010f 7b02          	ld	a,(OFST+0,sp)
6627  0111 c70000        	ld	_Pending_draddr,a
6630  0114 2036          	jra	L7342
6631  0116               L7332:
6632                     ; 4162         case 8:  Pending_netmask[3] = (uint8_t)temp; break;
6634  0116 7b02          	ld	a,(OFST+0,sp)
6635  0118 c70003        	ld	_Pending_netmask+3,a
6638  011b 202f          	jra	L7342
6639  011d               L1432:
6640                     ; 4163         case 9:  Pending_netmask[2] = (uint8_t)temp; break;
6642  011d 7b02          	ld	a,(OFST+0,sp)
6643  011f c70002        	ld	_Pending_netmask+2,a
6646  0122 2028          	jra	L7342
6647  0124               L3432:
6648                     ; 4164         case 10: Pending_netmask[1] = (uint8_t)temp; break;
6650  0124 7b02          	ld	a,(OFST+0,sp)
6651  0126 c70001        	ld	_Pending_netmask+1,a
6654  0129 2021          	jra	L7342
6655  012b               L5432:
6656                     ; 4165         case 11: Pending_netmask[0] = (uint8_t)temp; break;
6658  012b 7b02          	ld	a,(OFST+0,sp)
6659  012d c70000        	ld	_Pending_netmask,a
6662  0130 201a          	jra	L7342
6663  0132               L7432:
6664                     ; 4168 	  Pending_mqttserveraddr[3] = (uint8_t)temp;
6666  0132 7b02          	ld	a,(OFST+0,sp)
6667  0134 c70003        	ld	_Pending_mqttserveraddr+3,a
6668                     ; 4169 	  break;
6670  0137 2013          	jra	L7342
6671  0139               L1532:
6672                     ; 4171         case 13: Pending_mqttserveraddr[2] = (uint8_t)temp; break;
6674  0139 7b02          	ld	a,(OFST+0,sp)
6675  013b c70002        	ld	_Pending_mqttserveraddr+2,a
6678  013e 200c          	jra	L7342
6679  0140               L3532:
6680                     ; 4172         case 14: Pending_mqttserveraddr[1] = (uint8_t)temp; break;
6682  0140 7b02          	ld	a,(OFST+0,sp)
6683  0142 c70001        	ld	_Pending_mqttserveraddr+1,a
6686  0145 2005          	jra	L7342
6687  0147               L5532:
6688                     ; 4173         case 15: Pending_mqttserveraddr[0] = (uint8_t)temp; break;
6690  0147 7b02          	ld	a,(OFST+0,sp)
6691  0149 c70000        	ld	_Pending_mqttserveraddr,a
6694                     ; 4175         default: break;
6696  014c               L7342:
6697                     ; 4180   if (tmp_nBytes == 0) {
6699  014c ce000c        	ldw	x,_tmp_nBytes
6700  014f 2604          	jrne	L013
6701                     ; 4183     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
6703  0151 3502000a      	mov	_break_while,#2
6704                     ; 4186     return;
6705  0155               L013:
6708  0155 5b04          	addw	sp,#4
6709  0157 81            	ret	
6710                     ; 4188 }
6790                     ; 4191 void parse_POST_port(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6790                     ; 4192 {
6791                     .text:	section	.text,new
6792  0000               _parse_POST_port:
6794  0000 89            	pushw	x
6795  0001 5203          	subw	sp,#3
6796       00000003      OFST:	set	3
6799                     ; 4195   for (i=0; i<5; i++) alpha[i] = '-';
6801  0003 4f            	clr	a
6802  0004 6b03          	ld	(OFST+0,sp),a
6804  0006               L5742:
6807  0006 5f            	clrw	x
6808  0007 97            	ld	xl,a
6809  0008 a62d          	ld	a,#45
6810  000a d70004        	ld	(_alpha,x),a
6813  000d 0c03          	inc	(OFST+0,sp)
6817  000f 7b03          	ld	a,(OFST+0,sp)
6818  0011 a105          	cp	a,#5
6819  0013 25f1          	jrult	L5742
6820                     ; 4197   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6822  0015 c60012        	ld	a,_saved_postpartial_previous
6823  0018 1104          	cp	a,(OFST+1,sp)
6824  001a 2621          	jrne	L3052
6825                     ; 4200     saved_postpartial_previous[0] = '\0';
6827  001c 725f0012      	clr	_saved_postpartial_previous
6828                     ; 4207     for (i=0; i<5; i++) {
6830  0020 4f            	clr	a
6831  0021 6b03          	ld	(OFST+0,sp),a
6833  0023               L5052:
6834                     ; 4208       if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
6836  0023 5f            	clrw	x
6837  0024 97            	ld	xl,a
6838  0025 724d0016      	tnz	(_saved_postpartial_previous+4,x)
6839  0029 2708          	jreq	L3152
6842  002b 5f            	clrw	x
6843  002c 97            	ld	xl,a
6844  002d d60016        	ld	a,(_saved_postpartial_previous+4,x)
6845  0030 d70004        	ld	(_alpha,x),a
6846  0033               L3152:
6847                     ; 4207     for (i=0; i<5; i++) {
6849  0033 0c03          	inc	(OFST+0,sp)
6853  0035 7b03          	ld	a,(OFST+0,sp)
6854  0037 a105          	cp	a,#5
6855  0039 25e8          	jrult	L5052
6857  003b 2003          	jra	L5152
6858  003d               L3052:
6859                     ; 4215     clear_saved_postpartial_data(); // Clear [4] and higher
6861  003d cd0000        	call	_clear_saved_postpartial_data
6863  0040               L5152:
6864                     ; 4220     for (i=0; i<5; i++) {
6866  0040 4f            	clr	a
6867  0041 6b03          	ld	(OFST+0,sp),a
6869  0043               L7152:
6870                     ; 4226       if (alpha[i] == '-') {
6872  0043 5f            	clrw	x
6873  0044 97            	ld	xl,a
6874  0045 d60004        	ld	a,(_alpha,x)
6875  0048 a12d          	cp	a,#45
6876  004a 263c          	jrne	L5252
6877                     ; 4227         alpha[i] = (uint8_t)(*tmp_pBuffer);
6879  004c 7b03          	ld	a,(OFST+0,sp)
6880  004e 5f            	clrw	x
6881  004f 90ce000e      	ldw	y,_tmp_pBuffer
6882  0053 97            	ld	xl,a
6883  0054 90f6          	ld	a,(y)
6884  0056 d70004        	ld	(_alpha,x),a
6885                     ; 4228         saved_postpartial[i+4] = *tmp_pBuffer;
6887  0059 5f            	clrw	x
6888  005a 7b03          	ld	a,(OFST+0,sp)
6889  005c 97            	ld	xl,a
6890  005d 90f6          	ld	a,(y)
6891  005f d7002e        	ld	(_saved_postpartial+4,x),a
6892                     ; 4229         tmp_nParseLeft--;
6894  0062 725a000b      	dec	_tmp_nParseLeft
6895                     ; 4230         saved_nparseleft = tmp_nParseLeft;
6897                     ; 4231         tmp_pBuffer++;
6899  0066 93            	ldw	x,y
6900  0067 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6901  006c 5c            	incw	x
6902  006d cf000e        	ldw	_tmp_pBuffer,x
6903                     ; 4232         tmp_nBytes--;
6905  0070 ce000c        	ldw	x,_tmp_nBytes
6906  0073 5a            	decw	x
6907  0074 cf000c        	ldw	_tmp_nBytes,x
6908                     ; 4233         if (i != 4 && tmp_nBytes == 0) {
6910  0077 7b03          	ld	a,(OFST+0,sp)
6911  0079 a104          	cp	a,#4
6912  007b 270b          	jreq	L5252
6914  007d ce000c        	ldw	x,_tmp_nBytes
6915  0080 2606          	jrne	L5252
6916                     ; 4234           break_while = 1; // Hit end of fragment but still have characters to
6918  0082 3501000a      	mov	_break_while,#1
6919                     ; 4238    	break; // Break out of for() loop.
6921  0086 2008          	jra	L3252
6922  0088               L5252:
6923                     ; 4220     for (i=0; i<5; i++) {
6925  0088 0c03          	inc	(OFST+0,sp)
6929  008a 7b03          	ld	a,(OFST+0,sp)
6930  008c a105          	cp	a,#5
6931  008e 25b3          	jrult	L7152
6932  0090               L3252:
6933                     ; 4242     if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
6935  0090 c6000a        	ld	a,_break_while
6936  0093 4a            	dec	a
6937  0094 2603cc0122    	jreq	L023
6940                     ; 4247   clear_saved_postpartial_all();
6942  0099 cd0000        	call	_clear_saved_postpartial_all
6944                     ; 4256     invalid = 0;
6946  009c 0f03          	clr	(OFST+0,sp)
6948                     ; 4258     temp = (uint16_t)(       (alpha[4] - '0'));
6950  009e 5f            	clrw	x
6951  009f c60008        	ld	a,_alpha+4
6952  00a2 97            	ld	xl,a
6953  00a3 1d0030        	subw	x,#48
6954  00a6 1f01          	ldw	(OFST-2,sp),x
6956                     ; 4259     temp = (uint16_t)(temp + (alpha[3] - '0') * 10);
6958  00a8 c60007        	ld	a,_alpha+3
6959  00ab 97            	ld	xl,a
6960  00ac a60a          	ld	a,#10
6961  00ae 42            	mul	x,a
6962  00af 1d01e0        	subw	x,#480
6963  00b2 72fb01        	addw	x,(OFST-2,sp)
6964  00b5 1f01          	ldw	(OFST-2,sp),x
6966                     ; 4260     temp = (uint16_t)(temp + (alpha[2] - '0') * 100);
6968  00b7 c60006        	ld	a,_alpha+2
6969  00ba 97            	ld	xl,a
6970  00bb a664          	ld	a,#100
6971  00bd 42            	mul	x,a
6972  00be 1d12c0        	subw	x,#4800
6973  00c1 72fb01        	addw	x,(OFST-2,sp)
6974  00c4 1f01          	ldw	(OFST-2,sp),x
6976                     ; 4261     temp = (uint16_t)(temp + (alpha[1] - '0') * 1000);
6978  00c6 5f            	clrw	x
6979  00c7 c60005        	ld	a,_alpha+1
6980  00ca 97            	ld	xl,a
6981  00cb 90ae03e8      	ldw	y,#1000
6982  00cf cd0000        	call	c_imul
6984  00d2 1dbb80        	subw	x,#48000
6985  00d5 72fb01        	addw	x,(OFST-2,sp)
6986  00d8 1f01          	ldw	(OFST-2,sp),x
6988                     ; 4262     if (temp > 5535 && alpha[0] > '5') invalid = 1;
6990  00da a315a0        	cpw	x,#5536
6991  00dd 250d          	jrult	L3352
6993  00df c60004        	ld	a,_alpha
6994  00e2 a136          	cp	a,#54
6995  00e4 2506          	jrult	L3352
6998  00e6 a601          	ld	a,#1
6999  00e8 6b03          	ld	(OFST+0,sp),a
7002  00ea 2014          	jra	L5352
7003  00ec               L3352:
7004                     ; 4263     else temp = (uint16_t)(temp + (alpha[0] - '0') * 10000);
7006  00ec c60004        	ld	a,_alpha
7007  00ef 5f            	clrw	x
7008  00f0 97            	ld	xl,a
7009  00f1 90ae2710      	ldw	y,#10000
7010  00f5 cd0000        	call	c_imul
7012  00f8 1d5300        	subw	x,#21248
7013  00fb 72fb01        	addw	x,(OFST-2,sp)
7014  00fe 1f01          	ldw	(OFST-2,sp),x
7016  0100               L5352:
7017                     ; 4264     if (temp < 10) invalid = 1;
7019  0100 a3000a        	cpw	x,#10
7020  0103 2404          	jruge	L7352
7023  0105 a601          	ld	a,#1
7024  0107 6b03          	ld	(OFST+0,sp),a
7026  0109               L7352:
7027                     ; 4265     if (invalid == 0) {
7029  0109 7b03          	ld	a,(OFST+0,sp)
7030  010b 260c          	jrne	L1452
7031                     ; 4266       if (curr_ParseNum == 0) Pending_port = (uint16_t)temp;
7033  010d 7b05          	ld	a,(OFST+2,sp)
7034  010f 2605          	jrne	L3452
7037  0111 cf0000        	ldw	_Pending_port,x
7039  0114 2003          	jra	L1452
7040  0116               L3452:
7041                     ; 4268       else Pending_mqttport = (uint16_t)temp;
7043  0116 cf0000        	ldw	_Pending_mqttport,x
7044  0119               L1452:
7045                     ; 4273   if (tmp_nBytes == 0) {
7047  0119 ce000c        	ldw	x,_tmp_nBytes
7048  011c 2604          	jrne	L023
7049                     ; 4276     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
7051  011e 3502000a      	mov	_break_while,#2
7052                     ; 4279     return;
7053  0122               L023:
7056  0122 5b05          	addw	sp,#5
7057  0124 81            	ret	
7058                     ; 4281 }
7093                     	switch	.const
7094  1ba8               L623:
7095  1ba8 000e          	dc.w	L1552
7096  1baa 0016          	dc.w	L3552
7097  1bac 001e          	dc.w	L5552
7098  1bae 0026          	dc.w	L7552
7099  1bb0 002e          	dc.w	L1652
7100  1bb2 0036          	dc.w	L3652
7101  1bb4 003e          	dc.w	L5652
7102  1bb6 0046          	dc.w	L7652
7103  1bb8 004e          	dc.w	L1752
7104  1bba 0056          	dc.w	L3752
7105  1bbc 005e          	dc.w	L5752
7106  1bbe 0066          	dc.w	L7752
7107  1bc0 006e          	dc.w	L1062
7108  1bc2 0076          	dc.w	L3062
7109  1bc4 007e          	dc.w	L5062
7110  1bc6 0086          	dc.w	L7062
7111                     ; 4284 uint8_t GpioGetPin(uint8_t nGpio)
7111                     ; 4285 {
7112                     .text:	section	.text,new
7113  0000               _GpioGetPin:
7117                     ; 4290   switch (nGpio) {
7120                     ; 4306     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7121  0000 a110          	cp	a,#16
7122  0002 2503cc008e    	jruge	L7262
7123  0007 5f            	clrw	x
7124  0008 97            	ld	xl,a
7125  0009 58            	sllw	x
7126  000a de1ba8        	ldw	x,(L623,x)
7127  000d fc            	jp	(x)
7128  000e               L1552:
7129                     ; 4291     case 0:  if (IO_8to1  & (uint8_t)(0x01)) return 1; break;
7131  000e 720100007b    	btjf	_IO_8to1,#0,L7262
7134  0013 a601          	ld	a,#1
7137  0015 81            	ret	
7138  0016               L3552:
7139                     ; 4292     case 1:  if (IO_8to1  & (uint8_t)(0x02)) return 1; break;
7141  0016 7203000073    	btjf	_IO_8to1,#1,L7262
7144  001b a601          	ld	a,#1
7147  001d 81            	ret	
7148  001e               L5552:
7149                     ; 4293     case 2:  if (IO_8to1  & (uint8_t)(0x04)) return 1; break;
7151  001e 720500006b    	btjf	_IO_8to1,#2,L7262
7154  0023 a601          	ld	a,#1
7157  0025 81            	ret	
7158  0026               L7552:
7159                     ; 4294     case 3:  if (IO_8to1  & (uint8_t)(0x08)) return 1; break;
7161  0026 7207000063    	btjf	_IO_8to1,#3,L7262
7164  002b a601          	ld	a,#1
7167  002d 81            	ret	
7168  002e               L1652:
7169                     ; 4295     case 4:  if (IO_8to1  & (uint8_t)(0x10)) return 1; break;
7171  002e 720900005b    	btjf	_IO_8to1,#4,L7262
7174  0033 a601          	ld	a,#1
7177  0035 81            	ret	
7178  0036               L3652:
7179                     ; 4296     case 5:  if (IO_8to1  & (uint8_t)(0x20)) return 1; break;
7181  0036 720b000053    	btjf	_IO_8to1,#5,L7262
7184  003b a601          	ld	a,#1
7187  003d 81            	ret	
7188  003e               L5652:
7189                     ; 4297     case 6:  if (IO_8to1  & (uint8_t)(0x40)) return 1; break;
7191  003e 720d00004b    	btjf	_IO_8to1,#6,L7262
7194  0043 a601          	ld	a,#1
7197  0045 81            	ret	
7198  0046               L7652:
7199                     ; 4298     case 7:  if (IO_8to1  & (uint8_t)(0x80)) return 1; break;
7201  0046 720f000043    	btjf	_IO_8to1,#7,L7262
7204  004b a601          	ld	a,#1
7207  004d 81            	ret	
7208  004e               L1752:
7209                     ; 4299     case 8:  if (IO_16to9 & (uint8_t)(0x01)) return 1; break;
7211  004e 720100003b    	btjf	_IO_16to9,#0,L7262
7214  0053 a601          	ld	a,#1
7217  0055 81            	ret	
7218  0056               L3752:
7219                     ; 4300     case 9:  if (IO_16to9 & (uint8_t)(0x02)) return 1; break;
7221  0056 7203000033    	btjf	_IO_16to9,#1,L7262
7224  005b a601          	ld	a,#1
7227  005d 81            	ret	
7228  005e               L5752:
7229                     ; 4301     case 10: if (IO_16to9 & (uint8_t)(0x04)) return 1; break;
7231  005e 720500002b    	btjf	_IO_16to9,#2,L7262
7234  0063 a601          	ld	a,#1
7237  0065 81            	ret	
7238  0066               L7752:
7239                     ; 4302     case 11: if (IO_16to9 & (uint8_t)(0x08)) return 1; break;
7241  0066 7207000023    	btjf	_IO_16to9,#3,L7262
7244  006b a601          	ld	a,#1
7247  006d 81            	ret	
7248  006e               L1062:
7249                     ; 4303     case 12: if (IO_16to9 & (uint8_t)(0x10)) return 1; break;
7251  006e 720900001b    	btjf	_IO_16to9,#4,L7262
7254  0073 a601          	ld	a,#1
7257  0075 81            	ret	
7258  0076               L3062:
7259                     ; 4304     case 13: if (IO_16to9 & (uint8_t)(0x20)) return 1; break;
7261  0076 720b000013    	btjf	_IO_16to9,#5,L7262
7264  007b a601          	ld	a,#1
7267  007d 81            	ret	
7268  007e               L5062:
7269                     ; 4305     case 14: if (IO_16to9 & (uint8_t)(0x40)) return 1; break;
7271  007e 720d00000b    	btjf	_IO_16to9,#6,L7262
7274  0083 a601          	ld	a,#1
7277  0085 81            	ret	
7278  0086               L7062:
7279                     ; 4306     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7281  0086 720f000003    	btjf	_IO_16to9,#7,L7262
7284  008b a601          	ld	a,#1
7287  008d 81            	ret	
7288  008e               L7262:
7289                     ; 4308   return 0;
7291  008e 4f            	clr	a
7294  008f 81            	ret	
7341                     ; 4357 void GpioSetPin(uint8_t nGpio, uint8_t nState)
7341                     ; 4358 {
7342                     .text:	section	.text,new
7343  0000               _GpioSetPin:
7345  0000 89            	pushw	x
7346  0001 88            	push	a
7347       00000001      OFST:	set	1
7350                     ; 4365   mask = 0;
7352  0002 0f01          	clr	(OFST+0,sp)
7354                     ; 4367   switch(nGpio) {
7356  0004 9e            	ld	a,xh
7358                     ; 4376     default: break;
7359  0005 4d            	tnz	a
7360  0006 2717          	jreq	L1762
7361  0008 4a            	dec	a
7362  0009 2717          	jreq	L3762
7363  000b 4a            	dec	a
7364  000c 2718          	jreq	L5762
7365  000e 4a            	dec	a
7366  000f 2719          	jreq	L7762
7367  0011 4a            	dec	a
7368  0012 271a          	jreq	L1072
7369  0014 4a            	dec	a
7370  0015 271b          	jreq	L3072
7371  0017 4a            	dec	a
7372  0018 271c          	jreq	L5072
7373  001a 4a            	dec	a
7374  001b 271d          	jreq	L7072
7375  001d 201f          	jra	L5372
7376  001f               L1762:
7377                     ; 4368     case 0: mask = 0x01; break;
7379  001f 4c            	inc	a
7382  0020 201a          	jp	LC023
7383  0022               L3762:
7384                     ; 4369     case 1: mask = 0x02; break;
7386  0022 a602          	ld	a,#2
7389  0024 2016          	jp	LC023
7390  0026               L5762:
7391                     ; 4370     case 2: mask = 0x04; break;
7393  0026 a604          	ld	a,#4
7396  0028 2012          	jp	LC023
7397  002a               L7762:
7398                     ; 4371     case 3: mask = 0x08; break;
7400  002a a608          	ld	a,#8
7403  002c 200e          	jp	LC023
7404  002e               L1072:
7405                     ; 4372     case 4: mask = 0x10; break;
7407  002e a610          	ld	a,#16
7410  0030 200a          	jp	LC023
7411  0032               L3072:
7412                     ; 4373     case 5: mask = 0x20; break;
7414  0032 a620          	ld	a,#32
7417  0034 2006          	jp	LC023
7418  0036               L5072:
7419                     ; 4374     case 6: mask = 0x40; break;
7421  0036 a640          	ld	a,#64
7424  0038 2002          	jp	LC023
7425  003a               L7072:
7426                     ; 4375     case 7: mask = 0x80; break;
7428  003a a680          	ld	a,#128
7429  003c               LC023:
7430  003c 6b01          	ld	(OFST+0,sp),a
7434                     ; 4376     default: break;
7436  003e               L5372:
7437                     ; 4379   if (nState) IO_8to1 |= mask;
7439  003e 7b03          	ld	a,(OFST+2,sp)
7440  0040 2707          	jreq	L7372
7443  0042 c60000        	ld	a,_IO_8to1
7444  0045 1a01          	or	a,(OFST+0,sp)
7446  0047 2006          	jra	L1472
7447  0049               L7372:
7448                     ; 4380   else IO_8to1 &= (uint8_t)~mask;
7450  0049 7b01          	ld	a,(OFST+0,sp)
7451  004b 43            	cpl	a
7452  004c c40000        	and	a,_IO_8to1
7453  004f               L1472:
7454  004f c70000        	ld	_IO_8to1,a
7455                     ; 4382 }
7458  0052 5b03          	addw	sp,#3
7459  0054 81            	ret	
7520                     ; 4394 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7520                     ; 4395 {
7521                     .text:	section	.text,new
7522  0000               _SetMAC:
7524  0000 89            	pushw	x
7525  0001 5203          	subw	sp,#3
7526       00000003      OFST:	set	3
7529                     ; 4409   temp = 0;
7531                     ; 4410   invalid = 0;
7533  0003 0f01          	clr	(OFST-2,sp)
7535                     ; 4413   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7537  0005 9f            	ld	a,xl
7538  0006 a130          	cp	a,#48
7539  0008 250b          	jrult	L5003
7541  000a 9f            	ld	a,xl
7542  000b a13a          	cp	a,#58
7543  000d 2406          	jruge	L5003
7546  000f 7b05          	ld	a,(OFST+2,sp)
7547  0011 a030          	sub	a,#48
7549  0013 200c          	jp	LC024
7550  0015               L5003:
7551                     ; 4414   else if (alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7553  0015 7b05          	ld	a,(OFST+2,sp)
7554  0017 a161          	cp	a,#97
7555  0019 250a          	jrult	L1103
7557  001b a167          	cp	a,#103
7558  001d 2406          	jruge	L1103
7561  001f a057          	sub	a,#87
7562  0021               LC024:
7563  0021 6b05          	ld	(OFST+2,sp),a
7565  0023 2004          	jra	L7003
7566  0025               L1103:
7567                     ; 4415   else invalid = 1; // If an invalid entry set indicator
7569  0025 a601          	ld	a,#1
7570  0027 6b01          	ld	(OFST-2,sp),a
7572  0029               L7003:
7573                     ; 4417   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7575  0029 7b08          	ld	a,(OFST+5,sp)
7576  002b a130          	cp	a,#48
7577  002d 2508          	jrult	L5103
7579  002f a13a          	cp	a,#58
7580  0031 2404          	jruge	L5103
7583  0033 a030          	sub	a,#48
7585  0035 200a          	jp	LC025
7586  0037               L5103:
7587                     ; 4418   else if (alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7589  0037 a161          	cp	a,#97
7590  0039 250a          	jrult	L1203
7592  003b a167          	cp	a,#103
7593  003d 2406          	jruge	L1203
7596  003f a057          	sub	a,#87
7597  0041               LC025:
7598  0041 6b08          	ld	(OFST+5,sp),a
7600  0043 2004          	jra	L7103
7601  0045               L1203:
7602                     ; 4419   else invalid = 1; // If an invalid entry set indicator
7604  0045 a601          	ld	a,#1
7605  0047 6b01          	ld	(OFST-2,sp),a
7607  0049               L7103:
7608                     ; 4421   if (invalid == 0) { // Change value only if valid entry
7610  0049 7b01          	ld	a,(OFST-2,sp)
7611  004b 264a          	jrne	L5203
7612                     ; 4422     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7614  004d 7b05          	ld	a,(OFST+2,sp)
7615  004f 97            	ld	xl,a
7616  0050 a610          	ld	a,#16
7617  0052 42            	mul	x,a
7618  0053 01            	rrwa	x,a
7619  0054 1b08          	add	a,(OFST+5,sp)
7620  0056 5f            	clrw	x
7621  0057 97            	ld	xl,a
7622  0058 1f02          	ldw	(OFST-1,sp),x
7624                     ; 4423     switch(itemnum)
7626  005a 7b04          	ld	a,(OFST+1,sp)
7628                     ; 4431     default: break;
7629  005c 2711          	jreq	L3472
7630  005e 4a            	dec	a
7631  005f 2715          	jreq	L5472
7632  0061 4a            	dec	a
7633  0062 2719          	jreq	L7472
7634  0064 4a            	dec	a
7635  0065 271d          	jreq	L1572
7636  0067 4a            	dec	a
7637  0068 2721          	jreq	L3572
7638  006a 4a            	dec	a
7639  006b 2725          	jreq	L5572
7640  006d 2028          	jra	L5203
7641  006f               L3472:
7642                     ; 4425     case 0: Pending_uip_ethaddr_oct[5] = (uint8_t)temp; break;
7644  006f 7b03          	ld	a,(OFST+0,sp)
7645  0071 c70005        	ld	_Pending_uip_ethaddr_oct+5,a
7648  0074 2021          	jra	L5203
7649  0076               L5472:
7650                     ; 4426     case 1: Pending_uip_ethaddr_oct[4] = (uint8_t)temp; break;
7652  0076 7b03          	ld	a,(OFST+0,sp)
7653  0078 c70004        	ld	_Pending_uip_ethaddr_oct+4,a
7656  007b 201a          	jra	L5203
7657  007d               L7472:
7658                     ; 4427     case 2: Pending_uip_ethaddr_oct[3] = (uint8_t)temp; break;
7660  007d 7b03          	ld	a,(OFST+0,sp)
7661  007f c70003        	ld	_Pending_uip_ethaddr_oct+3,a
7664  0082 2013          	jra	L5203
7665  0084               L1572:
7666                     ; 4428     case 3: Pending_uip_ethaddr_oct[2] = (uint8_t)temp; break;
7668  0084 7b03          	ld	a,(OFST+0,sp)
7669  0086 c70002        	ld	_Pending_uip_ethaddr_oct+2,a
7672  0089 200c          	jra	L5203
7673  008b               L3572:
7674                     ; 4429     case 4: Pending_uip_ethaddr_oct[1] = (uint8_t)temp; break;
7676  008b 7b03          	ld	a,(OFST+0,sp)
7677  008d c70001        	ld	_Pending_uip_ethaddr_oct+1,a
7680  0090 2005          	jra	L5203
7681  0092               L5572:
7682                     ; 4430     case 5: Pending_uip_ethaddr_oct[0] = (uint8_t)temp; break;
7684  0092 7b03          	ld	a,(OFST+0,sp)
7685  0094 c70000        	ld	_Pending_uip_ethaddr_oct,a
7688                     ; 4431     default: break;
7690  0097               L5203:
7691                     ; 4434 }
7694  0097 5b05          	addw	sp,#5
7695  0099 81            	ret	
8089                     	switch	.bss
8090  0000               _insertion_flag:
8091  0000 000000        	ds.b	3
8092                     	xdef	_insertion_flag
8093                     	xref	_MQTT_error_status
8094                     	xref	_mqtt_start_status
8095                     	xref	_Pending_mqtt_password
8096                     	xref	_Pending_mqtt_username
8097                     	xref	_Pending_mqttport
8098                     	xref	_Pending_mqttserveraddr
8099                     	xref	_stored_mqtt_password
8100                     	xref	_stored_mqtt_username
8101                     	xref	_stored_mqttport
8102                     	xref	_stored_mqttserveraddr
8103  0003               _current_webpage:
8104  0003 00            	ds.b	1
8105                     	xdef	_current_webpage
8106  0004               _alpha:
8107  0004 000000000000  	ds.b	6
8108                     	xdef	_alpha
8109  000a               _break_while:
8110  000a 00            	ds.b	1
8111                     	xdef	_break_while
8112  000b               _tmp_nParseLeft:
8113  000b 00            	ds.b	1
8114                     	xdef	_tmp_nParseLeft
8115  000c               _tmp_nBytes:
8116  000c 0000          	ds.b	2
8117                     	xdef	_tmp_nBytes
8118  000e               _tmp_pBuffer:
8119  000e 0000          	ds.b	2
8120                     	xdef	_tmp_pBuffer
8121  0010               _z_diag:
8122  0010 00            	ds.b	1
8123                     	xdef	_z_diag
8124  0011               _saved_newlines:
8125  0011 00            	ds.b	1
8126                     	xdef	_saved_newlines
8127  0012               _saved_postpartial_previous:
8128  0012 000000000000  	ds.b	24
8129                     	xdef	_saved_postpartial_previous
8130  002a               _saved_postpartial:
8131  002a 000000000000  	ds.b	24
8132                     	xdef	_saved_postpartial
8133  0042               _saved_nparseleft:
8134  0042 00            	ds.b	1
8135                     	xdef	_saved_nparseleft
8136  0043               _saved_parsestate:
8137  0043 00            	ds.b	1
8138                     	xdef	_saved_parsestate
8139  0044               _saved_nstate:
8140  0044 00            	ds.b	1
8141                     	xdef	_saved_nstate
8142  0045               _OctetArray:
8143  0045 000000000000  	ds.b	11
8144                     	xdef	_OctetArray
8145                     	xref	_user_reboot_request
8146                     	xref	_parse_complete
8147                     	xref	_mac_string
8148                     	xref	_stored_config_settings
8149                     	xref	_stored_devicename
8150                     	xref	_stored_port
8151                     	xref	_stored_netmask
8152                     	xref	_stored_draddr
8153                     	xref	_stored_hostaddr
8154                     	xref	_Pending_uip_ethaddr_oct
8155                     	xref	_Pending_config_settings
8156                     	xref	_Pending_devicename
8157                     	xref	_Pending_port
8158                     	xref	_Pending_netmask
8159                     	xref	_Pending_draddr
8160                     	xref	_Pending_hostaddr
8161                     	xref	_invert_input
8162                     	xref	_IO_8to1
8163                     	xref	_IO_16to9
8164                     	xref	_Port_Httpd
8165                     	xref	_strlen
8166                     	xref	_debugflash
8167                     	xref	_uip_flags
8168                     	xref	_uip_conn
8169                     	xref	_uip_len
8170                     	xref	_uip_appdata
8171                     	xref	_htons
8172                     	xref	_uip_send
8173                     	xref	_uip_listen
8174                     	xdef	_SetMAC
8175                     	xdef	_clear_saved_postpartial_previous
8176                     	xdef	_clear_saved_postpartial_data
8177                     	xdef	_clear_saved_postpartial_all
8178                     	xdef	_GpioSetPin
8179                     	xdef	_GpioGetPin
8180                     	xdef	_parse_POST_port
8181                     	xdef	_parse_POST_address
8182                     	xdef	_parse_POST_string
8183                     	xdef	_HttpDCall
8184                     	xdef	_HttpDInit
8185                     	xdef	_emb_itoa
8186                     	xdef	_adjust_template_size
8187                     	switch	.const
8188  1bc8               L333:
8189  1bc8 436f6e6e6563  	dc.b	"Connection:close",13
8190  1bd9 0a00          	dc.b	10,0
8191  1bdb               L133:
8192  1bdb 436f6e74656e  	dc.b	"Content-Type: text"
8193  1bed 2f68746d6c3b  	dc.b	"/html; charset=utf"
8194  1bff 2d380d        	dc.b	"-8",13
8195  1c02 0a00          	dc.b	10,0
8196  1c04               L723:
8197  1c04 43616368652d  	dc.b	"Cache-Control: no-"
8198  1c16 63616368652c  	dc.b	"cache, no-store",13
8199  1c26 0a00          	dc.b	10,0
8200  1c28               L713:
8201  1c28 436f6e74656e  	dc.b	"Content-Length:",0
8202  1c38               L513:
8203  1c38 0d0a00        	dc.b	13,10,0
8204  1c3b               L313:
8205  1c3b 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8206                     	xref.b	c_lreg
8207                     	xref.b	c_x
8208                     	xref.b	c_y
8228                     	xref	c_imul
8229                     	xref	c_uitolx
8230                     	xref	c_ludv
8231                     	xref	c_lumd
8232                     	xref	c_rtol
8233                     	xref	c_ltor
8234                     	xref	c_lzmp
8235                     	end
