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
 371  1728 76616c75653d  	dc.b	"value='0'><button "
 372  173a 747970653d27  	dc.b	"type='submit'>Save"
 373  174c 3c2f62757474  	dc.b	"</button><button t"
 374  175e 7970653d2772  	dc.b	"ype='reset'>Undo A"
 375  1770 6c6c3c2f6275  	dc.b	"ll</button></form>"
 376  1782 3c703e536565  	dc.b	"<p>See Documentati"
 377  1794 6f6e20666f72  	dc.b	"on for help<br>Cod"
 378  17a6 652052657669  	dc.b	"e Revision 2020113"
 379  17b8 302031373532  	dc.b	"0 1752</p>%y03/91%"
 380  17ca 793032526562  	dc.b	"y02Reboot</button>"
 381  17dc 3c2f666f726d  	dc.b	"</form><br><br>%y0"
 382  17ee 332f36312579  	dc.b	"3/61%y02Refresh</b"
 383  1800 757474        	dc.b	"utt"
 384  1803 6f6e3e3c2f66  	dc.b	"on></form>%y03/60%"
 385  1815 793032494f20  	dc.b	"y02IO Control</but"
 386  1827 746f6e3e3c2f  	dc.b	"ton></form>%y03/66"
 387  1839 257930324572  	dc.b	"%y02Error Statisti"
 388  184b 63733c2f6275  	dc.b	"cs</button></form>"
 389  185d 3c2f626f6479  	dc.b	"</body></html>",0
 390  186c               L71_g_HtmlPageStats:
 391  186c 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 392  187e 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 393  1890 6561643e3c6c  	dc.b	"ead><link rel='ico"
 394  18a2 6e2720687265  	dc.b	"n' href='data:,'><"
 395  18b4 2f686561643e  	dc.b	"/head><body><table"
 396  18c6 3e3c74723e3c  	dc.b	"><tr><td>Seconds s"
 397  18d8 696e63652062  	dc.b	"ince boot %e26</td"
 398  18ea 3e3c2f74723e  	dc.b	"></tr><tr><td>RXER"
 399  18fc 494620636f75  	dc.b	"IF count %e27</td>"
 400  190e 3c2f74723e3c  	dc.b	"</tr><tr><td>TXERI"
 401  1920 4620636f756e  	dc.b	"F count %e28</td><"
 402  1932 2f74723e3c74  	dc.b	"/tr><tr><td>TRANSM"
 403  1944 495420636f75  	dc.b	"IT count %e29</td>"
 404  1956 3c2f74723e3c  	dc.b	"</tr></table>%y03/"
 405  1968 363127        	dc.b	"61'"
 406  196b 206d6574686f  	dc.b	" method='GET'><but"
 407  197d 746f6e3e436f  	dc.b	"ton>Configuration<"
 408  198f 2f627574746f  	dc.b	"/button></form>%y0"
 409  19a1 332f36362720  	dc.b	"3/66' method='GET'"
 410  19b3 3e3c62757474  	dc.b	"><button>Refresh</"
 411  19c5 627574746f6e  	dc.b	"button></form></bo"
 412  19d7 64793e3c2f68  	dc.b	"dy></html>",0
 413  19e2               L12_g_HtmlPageRstate:
 414  19e2 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 415  19f4 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 416  1a06 6561643e3c74  	dc.b	"ead><title>Short F"
 417  1a18 6f726d3c2f74  	dc.b	"orm</title><link r"
 418  1a2a 656c3d276963  	dc.b	"el='icon' href='da"
 419  1a3c 74613a2c273e  	dc.b	"ta:,'></head><body"
 420  1a4e 3e3c703e2566  	dc.b	"><p>%f00</p></body"
 421  1a60 3e3c2f68746d  	dc.b	"></html>",0
 422  1a69               L32_g_HtmlPageSstate:
 423  1a69 2566303000    	dc.b	"%f00",0
 424  1a6e               L52_page_string00:
 425  1a6e 706174746572  	dc.b	"pattern='[0-9]{3}'"
 426  1a80 207469746c65  	dc.b	" title='Enter 000 "
 427  1a92 746f20323535  	dc.b	"to 255' maxlength="
 428  1aa4 2733273e3c2f  	dc.b	"'3'></td>",0
 429  1aae               L72_page_string00_len:
 430  1aae 3f            	dc.b	63
 431  1aaf               L13_page_string00_len_less4:
 432  1aaf 3b            	dc.b	59
 433  1ab0               L33_page_string01:
 434  1ab0 706174746572  	dc.b	"pattern='[0-9a-f]{"
 435  1ac2 327d27207469  	dc.b	"2}' title='Enter 0"
 436  1ad4 3020746f2066  	dc.b	"0 to ff' maxlength"
 437  1ae6 3d2732273e3c  	dc.b	"='2'></td>",0
 438  1af1               L53_page_string01_len:
 439  1af1 40            	dc.b	64
 440  1af2               L73_page_string01_len_less4:
 441  1af2 3c            	dc.b	60
 442  1af3               L14_page_string02:
 443  1af3 27206d657468  	dc.b	"' method='GET'><bu"
 444  1b05 74746f6e2074  	dc.b	"tton title='Save f"
 445  1b17 697273742120  	dc.b	"irst! This button "
 446  1b29 77696c6c206e  	dc.b	"will not save your"
 447  1b3b 206368616e67  	dc.b	" changes'>",0
 448  1b46               L34_page_string02_len:
 449  1b46 52            	dc.b	82
 450  1b47               L54_page_string02_len_less4:
 451  1b47 4e            	dc.b	78
 452  1b48               L74_page_string03:
 453  1b48 3c666f726d20  	dc.b	"<form style='displ"
 454  1b5a 61793a20696e  	dc.b	"ay: inline' action"
 455  1b6c 3d2700        	dc.b	"='",0
 456  1b6f               L15_page_string03_len:
 457  1b6f 26            	dc.b	38
 458  1b70               L35_page_string03_len_less4:
 459  1b70 22            	dc.b	34
 460  1b71               L55_page_string04:
 461  1b71 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 462  1b83 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 463  1b95 6561643e3c6c  	dc.b	"ead><link rel='ico"
 464  1ba7 6e2720687265  	dc.b	"n' href='data:,'>",0
 465  1bb9               L75_page_string04_len:
 466  1bb9 47            	dc.b	71
 467  1bba               L16_page_string04_len_less4:
 468  1bba 43            	dc.b	67
 469  1bbb               L36_page_string05:
 470  1bbb 3c7374796c65  	dc.b	"<style>.s0 { backg"
 471  1bcd 726f756e642d  	dc.b	"round-color: red; "
 472  1bdf 77696474683a  	dc.b	"width: 30px; }.s1 "
 473  1bf1 7b206261636b  	dc.b	"{ background-color"
 474  1c03 3a2067726565  	dc.b	": green; width: 30"
 475  1c15 70783b207d2e  	dc.b	"px; }.t1 { width: "
 476  1c27 31323070783b  	dc.b	"120px; }.t2 { widt"
 477  1c39 683a20313438  	dc.b	"h: 148px; }.t3 { w"
 478  1c4b 696474683a20  	dc.b	"idth: 30px; }.t5 {"
 479  1c5d 207769647468  	dc.b	" width: 60px; }.t6"
 480  1c6f 207b20776964  	dc.b	" { width: 25px; }."
 481  1c81 7437207b2077  	dc.b	"t7 { width: 18px; "
 482  1c93 7d2e7438207b  	dc.b	"}.t8 { width: 40px"
 483  1ca5 3b207d00      	dc.b	"; }",0
 484  1ca9               L56_page_string05_len:
 485  1ca9 ed            	dc.b	237
 486  1caa               L76_page_string05_len_less4:
 487  1caa e9            	dc.b	233
 488  1cab               L17_page_string06:
 489  1cab 7464207b2074  	dc.b	"td { text-align: c"
 490  1cbd 656e7465723b  	dc.b	"enter; border: 1px"
 491  1ccf 20626c61636b  	dc.b	" black solid; }</s"
 492  1ce1 74796c653e00  	dc.b	"tyle>",0
 493  1ce7               L37_page_string06_len:
 494  1ce7 3b            	dc.b	59
 495  1ce8               L57_page_string06_len_less4:
 496  1ce8 37            	dc.b	55
 552                     ; 1220 uint16_t adjust_template_size()
 552                     ; 1221 {
 554                     .text:	section	.text,new
 555  0000               _adjust_template_size:
 557  0000 89            	pushw	x
 558       00000002      OFST:	set	2
 561                     ; 1239   size = 0;
 563  0001 5f            	clrw	x
 564  0002 1f01          	ldw	(OFST-1,sp),x
 566                     ; 1244   if (current_webpage == WEBPAGE_IOCONTROL) {
 568  0004 c60003        	ld	a,_current_webpage
 569  0007 2613          	jrne	L121
 570                     ; 1245     size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
 572                     ; 1248     size = size + page_string04_len_less4
 572                     ; 1249                 + page_string05_len_less4
 572                     ; 1250 		+ page_string06_len_less4;
 574  0009 ae0d69        	ldw	x,#3433
 575  000c 1f01          	ldw	(OFST-1,sp),x
 577                     ; 1255     size = size + strlen(stored_devicename) - 4 ;
 579  000e ae0000        	ldw	x,#_stored_devicename
 580  0011 cd0000        	call	_strlen
 582  0014 72fb01        	addw	x,(OFST-1,sp)
 583  0017 1c00a4        	addw	x,#164
 585                     ; 1262     size = size - 48;
 588                     ; 1278     size = size - 8;
 591                     ; 1292     size = size + (2 * page_string03_len_less4);
 594                     ; 1321     size = size + (2 * (page_string02_len_less4));
 598  001a 204f          	jra	L321
 599  001c               L121:
 600                     ; 1340   else if (current_webpage == WEBPAGE_CONFIGURATION) {
 602  001c a101          	cp	a,#1
 603  001e 2632          	jrne	L521
 604                     ; 1341     size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
 606                     ; 1344     size = size + page_string04_len_less4
 606                     ; 1345                 + page_string05_len_less4
 606                     ; 1346 		+ page_string06_len_less4;
 608  0020 ae0dbf        	ldw	x,#3519
 609  0023 1f01          	ldw	(OFST-1,sp),x
 611                     ; 1351     size = size + strlen(stored_devicename) - 4 ;
 613  0025 ae0000        	ldw	x,#_stored_devicename
 614  0028 cd0000        	call	_strlen
 616  002b 72fb01        	addw	x,(OFST-1,sp)
 617  002e 1d001c        	subw	x,#28
 619                     ; 1358     size = size - 12;
 622                     ; 1365     size = size + 1;
 625                     ; 1372     size = size - 12;
 628                     ; 1380     size = size + 2;
 631                     ; 1388     size = size - 4;
 634                     ; 1395     size = size + 1;
 636  0031 1f01          	ldw	(OFST-1,sp),x
 638                     ; 1400     size = size + (strlen(stored_mqtt_username) - 4);
 640  0033 ae0000        	ldw	x,#_stored_mqtt_username
 641  0036 cd0000        	call	_strlen
 643  0039 1d0004        	subw	x,#4
 644  003c 72fb01        	addw	x,(OFST-1,sp)
 645  003f 1f01          	ldw	(OFST-1,sp),x
 647                     ; 1405     size = size + (strlen(stored_mqtt_password) - 4);
 649  0041 ae0000        	ldw	x,#_stored_mqtt_password
 650  0044 cd0000        	call	_strlen
 652  0047 1d0004        	subw	x,#4
 653  004a 72fb01        	addw	x,(OFST-1,sp)
 655                     ; 1412     size = size - 15;
 657  004d 1c06c9        	addw	x,#1737
 659                     ; 1426     size = size + (3 * page_string03_len_less4);
 662                     ; 1432     size = size + page_string03_len_less4;
 665                     ; 1455     size = size + (12 * (page_string00_len_less4));
 668                     ; 1464     size = size + (4 * (page_string00_len_less4));
 671                     ; 1474     size = size + (6 * (page_string01_len_less4));
 674                     ; 1483     size = size + (3 * (page_string02_len_less4));
 677                     ; 1498     size = size + page_string02_len_less4;
 681  0050 2019          	jra	L321
 682  0052               L521:
 683                     ; 1572   else if (current_webpage == WEBPAGE_STATS) {
 685  0052 a105          	cp	a,#5
 686  0054 2605          	jrne	L131
 687                     ; 1573     size = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
 689                     ; 1580     size = size + 24;
 691                     ; 1589     size = size + (2 * page_string03_len_less4);
 693  0056 ae01d1        	ldw	x,#465
 696  0059 2010          	jra	L321
 697  005b               L131:
 698                     ; 1597   else if (current_webpage == WEBPAGE_RSTATE) {
 700  005b a106          	cp	a,#6
 701  005d 2605          	jrne	L531
 702                     ; 1598     size = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
 704                     ; 1603     size = size + 12;
 706  005f ae0092        	ldw	x,#146
 709  0062 2007          	jra	L321
 710  0064               L531:
 711                     ; 1610   else if (current_webpage == WEBPAGE_SSTATE) {
 713  0064 a107          	cp	a,#7
 714  0066 2603          	jrne	L321
 715                     ; 1611     size = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
 717                     ; 1616     size = size + 12;
 719  0068 ae0010        	ldw	x,#16
 721  006b               L321:
 722                     ; 1619   return size;
 726  006b 5b02          	addw	sp,#2
 727  006d 81            	ret	
 818                     ; 1623 void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
 818                     ; 1624 {
 819                     .text:	section	.text,new
 820  0000               _emb_itoa:
 822  0000 5207          	subw	sp,#7
 823       00000007      OFST:	set	7
 826                     ; 1642   for (i=0; i < pad; i++) str[i] = '0';
 828  0002 0f07          	clr	(OFST+0,sp)
 831  0004 200a          	jra	L502
 832  0006               L102:
 835  0006 5f            	clrw	x
 836  0007 97            	ld	xl,a
 837  0008 72fb0e        	addw	x,(OFST+7,sp)
 838  000b a630          	ld	a,#48
 839  000d f7            	ld	(x),a
 842  000e 0c07          	inc	(OFST+0,sp)
 844  0010               L502:
 847  0010 7b07          	ld	a,(OFST+0,sp)
 848  0012 1111          	cp	a,(OFST+10,sp)
 849  0014 25f0          	jrult	L102
 850                     ; 1643   str[pad] = '\0';
 852  0016 7b11          	ld	a,(OFST+10,sp)
 853  0018 5f            	clrw	x
 854  0019 97            	ld	xl,a
 855  001a 72fb0e        	addw	x,(OFST+7,sp)
 856  001d 7f            	clr	(x)
 857                     ; 1644   if (num == 0) return;
 859  001e 96            	ldw	x,sp
 860  001f 1c000a        	addw	x,#OFST+3
 861  0022 cd0000        	call	c_lzmp
 863  0025 2603cc00cf    	jreq	L02
 866                     ; 1647   i = 0;
 868  002a 0f07          	clr	(OFST+0,sp)
 871  002c 2060          	jra	L712
 872  002e               L312:
 873                     ; 1649     rem = (uint8_t)(num % base);
 875  002e 7b10          	ld	a,(OFST+9,sp)
 876  0030 b703          	ld	c_lreg+3,a
 877  0032 3f02          	clr	c_lreg+2
 878  0034 3f01          	clr	c_lreg+1
 879  0036 3f00          	clr	c_lreg
 880  0038 96            	ldw	x,sp
 881  0039 5c            	incw	x
 882  003a cd0000        	call	c_rtol
 885  003d 96            	ldw	x,sp
 886  003e 1c000a        	addw	x,#OFST+3
 887  0041 cd0000        	call	c_ltor
 889  0044 96            	ldw	x,sp
 890  0045 5c            	incw	x
 891  0046 cd0000        	call	c_lumd
 893  0049 b603          	ld	a,c_lreg+3
 894  004b 6b06          	ld	(OFST-1,sp),a
 896                     ; 1650     if (rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
 898  004d a10a          	cp	a,#10
 899  004f 7b07          	ld	a,(OFST+0,sp)
 900  0051 250d          	jrult	L322
 903  0053 0c07          	inc	(OFST+0,sp)
 905  0055 5f            	clrw	x
 906  0056 97            	ld	xl,a
 907  0057 72fb0e        	addw	x,(OFST+7,sp)
 908  005a 7b06          	ld	a,(OFST-1,sp)
 909  005c ab57          	add	a,#87
 911  005e 200b          	jra	L522
 912  0060               L322:
 913                     ; 1651     else str[i++] = (uint8_t)(rem + '0');
 915  0060 0c07          	inc	(OFST+0,sp)
 917  0062 5f            	clrw	x
 918  0063 97            	ld	xl,a
 919  0064 72fb0e        	addw	x,(OFST+7,sp)
 920  0067 7b06          	ld	a,(OFST-1,sp)
 921  0069 ab30          	add	a,#48
 922  006b               L522:
 923  006b f7            	ld	(x),a
 924                     ; 1652     num = num/base;
 926  006c 7b10          	ld	a,(OFST+9,sp)
 927  006e b703          	ld	c_lreg+3,a
 928  0070 3f02          	clr	c_lreg+2
 929  0072 3f01          	clr	c_lreg+1
 930  0074 3f00          	clr	c_lreg
 931  0076 96            	ldw	x,sp
 932  0077 5c            	incw	x
 933  0078 cd0000        	call	c_rtol
 936  007b 96            	ldw	x,sp
 937  007c 1c000a        	addw	x,#OFST+3
 938  007f cd0000        	call	c_ltor
 940  0082 96            	ldw	x,sp
 941  0083 5c            	incw	x
 942  0084 cd0000        	call	c_ludv
 944  0087 96            	ldw	x,sp
 945  0088 1c000a        	addw	x,#OFST+3
 946  008b cd0000        	call	c_rtol
 948  008e               L712:
 949                     ; 1648   while (num != 0) {
 951  008e 96            	ldw	x,sp
 952  008f 1c000a        	addw	x,#OFST+3
 953  0092 cd0000        	call	c_lzmp
 955  0095 2697          	jrne	L312
 956                     ; 1661     start = 0;
 958  0097 0f06          	clr	(OFST-1,sp)
 960                     ; 1662     end = (uint8_t)(pad - 1);
 962  0099 7b11          	ld	a,(OFST+10,sp)
 963  009b 4a            	dec	a
 964  009c 6b07          	ld	(OFST+0,sp),a
 967  009e 2029          	jra	L332
 968  00a0               L722:
 969                     ; 1665       temp = str[start];
 971  00a0 5f            	clrw	x
 972  00a1 97            	ld	xl,a
 973  00a2 72fb0e        	addw	x,(OFST+7,sp)
 974  00a5 f6            	ld	a,(x)
 975  00a6 6b05          	ld	(OFST-2,sp),a
 977                     ; 1666       str[start] = str[end];
 979  00a8 5f            	clrw	x
 980  00a9 7b06          	ld	a,(OFST-1,sp)
 981  00ab 97            	ld	xl,a
 982  00ac 72fb0e        	addw	x,(OFST+7,sp)
 983  00af 7b07          	ld	a,(OFST+0,sp)
 984  00b1 905f          	clrw	y
 985  00b3 9097          	ld	yl,a
 986  00b5 72f90e        	addw	y,(OFST+7,sp)
 987  00b8 90f6          	ld	a,(y)
 988  00ba f7            	ld	(x),a
 989                     ; 1667       str[end] = temp;
 991  00bb 5f            	clrw	x
 992  00bc 7b07          	ld	a,(OFST+0,sp)
 993  00be 97            	ld	xl,a
 994  00bf 72fb0e        	addw	x,(OFST+7,sp)
 995  00c2 7b05          	ld	a,(OFST-2,sp)
 996  00c4 f7            	ld	(x),a
 997                     ; 1668       start++;
 999  00c5 0c06          	inc	(OFST-1,sp)
1001                     ; 1669       end--;
1003  00c7 0a07          	dec	(OFST+0,sp)
1005  00c9               L332:
1006                     ; 1664     while (start < end) {
1006                     ; 1665       temp = str[start];
1006                     ; 1666       str[start] = str[end];
1006                     ; 1667       str[end] = temp;
1006                     ; 1668       start++;
1006                     ; 1669       end--;
1008  00c9 7b06          	ld	a,(OFST-1,sp)
1009  00cb 1107          	cp	a,(OFST+0,sp)
1010  00cd 25d1          	jrult	L722
1011                     ; 1672 }
1012  00cf               L02:
1015  00cf 5b07          	addw	sp,#7
1016  00d1 81            	ret	
1076                     ; 1675 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1076                     ; 1676 {
1077                     .text:	section	.text,new
1078  0000               L3_CopyStringP:
1080  0000 89            	pushw	x
1081  0001 5203          	subw	sp,#3
1082       00000003      OFST:	set	3
1085                     ; 1681   nBytes = 0;
1087  0003 5f            	clrw	x
1089  0004 2014          	jra	L172
1090  0006               L562:
1091                     ; 1683     **ppBuffer = Character;
1093  0006 1e04          	ldw	x,(OFST+1,sp)
1094  0008 fe            	ldw	x,(x)
1095  0009 f7            	ld	(x),a
1096                     ; 1684     *ppBuffer = *ppBuffer + 1;
1098  000a 1e04          	ldw	x,(OFST+1,sp)
1099  000c 9093          	ldw	y,x
1100  000e fe            	ldw	x,(x)
1101  000f 5c            	incw	x
1102  0010 90ff          	ldw	(y),x
1103                     ; 1685     pString = pString + 1;
1105  0012 1e08          	ldw	x,(OFST+5,sp)
1106  0014 5c            	incw	x
1107  0015 1f08          	ldw	(OFST+5,sp),x
1108                     ; 1686     nBytes++;
1110  0017 1e01          	ldw	x,(OFST-2,sp)
1111  0019 5c            	incw	x
1112  001a               L172:
1113  001a 1f01          	ldw	(OFST-2,sp),x
1115                     ; 1682   while ((Character = pString[0]) != '\0') {
1115                     ; 1683     **ppBuffer = Character;
1115                     ; 1684     *ppBuffer = *ppBuffer + 1;
1115                     ; 1685     pString = pString + 1;
1115                     ; 1686     nBytes++;
1117  001c 1e08          	ldw	x,(OFST+5,sp)
1118  001e f6            	ld	a,(x)
1119  001f 6b03          	ld	(OFST+0,sp),a
1121  0021 26e3          	jrne	L562
1122                     ; 1688   return nBytes;
1124  0023 1e01          	ldw	x,(OFST-2,sp)
1127  0025 5b05          	addw	sp,#5
1128  0027 81            	ret	
1187                     ; 1692 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen)
1187                     ; 1693 {
1188                     .text:	section	.text,new
1189  0000               L5_CopyHttpHeader:
1191  0000 89            	pushw	x
1192  0001 5203          	subw	sp,#3
1193       00000003      OFST:	set	3
1196                     ; 1697   nBytes = 0;
1198  0003 5f            	clrw	x
1199  0004 1f02          	ldw	(OFST-1,sp),x
1201                     ; 1699   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
1203  0006 ae1ddc        	ldw	x,#L123
1204  0009 89            	pushw	x
1205  000a 96            	ldw	x,sp
1206  000b 1c0006        	addw	x,#OFST+3
1207  000e cd0000        	call	L3_CopyStringP
1209  0011 5b02          	addw	sp,#2
1210  0013 72fb02        	addw	x,(OFST-1,sp)
1211  0016 1f02          	ldw	(OFST-1,sp),x
1213                     ; 1700   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1215  0018 ae1dd9        	ldw	x,#L323
1216  001b 89            	pushw	x
1217  001c 96            	ldw	x,sp
1218  001d 1c0006        	addw	x,#OFST+3
1219  0020 cd0000        	call	L3_CopyStringP
1221  0023 5b02          	addw	sp,#2
1222  0025 72fb02        	addw	x,(OFST-1,sp)
1223  0028 1f02          	ldw	(OFST-1,sp),x
1225                     ; 1702   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
1227  002a ae1dc9        	ldw	x,#L523
1228  002d 89            	pushw	x
1229  002e 96            	ldw	x,sp
1230  002f 1c0006        	addw	x,#OFST+3
1231  0032 cd0000        	call	L3_CopyStringP
1233  0035 5b02          	addw	sp,#2
1234  0037 72fb02        	addw	x,(OFST-1,sp)
1235  003a 1f02          	ldw	(OFST-1,sp),x
1237                     ; 1706   emb_itoa(nDataLen, OctetArray, 10, 5);
1239  003c 4b05          	push	#5
1240  003e 4b0a          	push	#10
1241  0040 ae0045        	ldw	x,#_OctetArray
1242  0043 89            	pushw	x
1243  0044 1e0c          	ldw	x,(OFST+9,sp)
1244  0046 cd0000        	call	c_uitolx
1246  0049 be02          	ldw	x,c_lreg+2
1247  004b 89            	pushw	x
1248  004c be00          	ldw	x,c_lreg
1249  004e 89            	pushw	x
1250  004f cd0000        	call	_emb_itoa
1252  0052 5b08          	addw	sp,#8
1253                     ; 1707   for (i=0; i<5; i++) {
1255  0054 4f            	clr	a
1256  0055 6b01          	ld	(OFST-2,sp),a
1258  0057               L723:
1259                     ; 1708     *pBuffer = (uint8_t)OctetArray[i];
1261  0057 5f            	clrw	x
1262  0058 97            	ld	xl,a
1263  0059 d60045        	ld	a,(_OctetArray,x)
1264  005c 1e04          	ldw	x,(OFST+1,sp)
1265  005e f7            	ld	(x),a
1266                     ; 1709     pBuffer = pBuffer + 1;
1268  005f 5c            	incw	x
1269  0060 1f04          	ldw	(OFST+1,sp),x
1270                     ; 1707   for (i=0; i<5; i++) {
1272  0062 0c01          	inc	(OFST-2,sp)
1276  0064 7b01          	ld	a,(OFST-2,sp)
1277  0066 a105          	cp	a,#5
1278  0068 25ed          	jrult	L723
1279                     ; 1711   nBytes += 5;
1281  006a 1e02          	ldw	x,(OFST-1,sp)
1282  006c 1c0005        	addw	x,#5
1283  006f 1f02          	ldw	(OFST-1,sp),x
1285                     ; 1713   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1287  0071 ae1dd9        	ldw	x,#L323
1288  0074 89            	pushw	x
1289  0075 96            	ldw	x,sp
1290  0076 1c0006        	addw	x,#OFST+3
1291  0079 cd0000        	call	L3_CopyStringP
1293  007c 5b02          	addw	sp,#2
1294  007e 72fb02        	addw	x,(OFST-1,sp)
1295  0081 1f02          	ldw	(OFST-1,sp),x
1297                     ; 1716   nBytes += CopyStringP(&pBuffer, (const char *)("Cache-Control: no-cache, no-store\r\n"));
1299  0083 ae1da5        	ldw	x,#L533
1300  0086 89            	pushw	x
1301  0087 96            	ldw	x,sp
1302  0088 1c0006        	addw	x,#OFST+3
1303  008b cd0000        	call	L3_CopyStringP
1305  008e 5b02          	addw	sp,#2
1306  0090 72fb02        	addw	x,(OFST-1,sp)
1307  0093 1f02          	ldw	(OFST-1,sp),x
1309                     ; 1718   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type: text/html; charset=utf-8\r\n"));
1311  0095 ae1d7c        	ldw	x,#L733
1312  0098 89            	pushw	x
1313  0099 96            	ldw	x,sp
1314  009a 1c0006        	addw	x,#OFST+3
1315  009d cd0000        	call	L3_CopyStringP
1317  00a0 5b02          	addw	sp,#2
1318  00a2 72fb02        	addw	x,(OFST-1,sp)
1319  00a5 1f02          	ldw	(OFST-1,sp),x
1321                     ; 1720   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
1323  00a7 ae1d69        	ldw	x,#L143
1324  00aa 89            	pushw	x
1325  00ab 96            	ldw	x,sp
1326  00ac 1c0006        	addw	x,#OFST+3
1327  00af cd0000        	call	L3_CopyStringP
1329  00b2 5b02          	addw	sp,#2
1330  00b4 72fb02        	addw	x,(OFST-1,sp)
1331  00b7 1f02          	ldw	(OFST-1,sp),x
1333                     ; 1721   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1335  00b9 ae1dd9        	ldw	x,#L323
1336  00bc 89            	pushw	x
1337  00bd 96            	ldw	x,sp
1338  00be 1c0006        	addw	x,#OFST+3
1339  00c1 cd0000        	call	L3_CopyStringP
1341  00c4 5b02          	addw	sp,#2
1342  00c6 72fb02        	addw	x,(OFST-1,sp)
1344                     ; 1723   return nBytes;
1348  00c9 5b05          	addw	sp,#5
1349  00cb 81            	ret	
1506                     	switch	.const
1507  1ce9               L431:
1508  1ce9 01ad          	dc.w	L343
1509  1ceb 01bb          	dc.w	L543
1510  1ced 01c9          	dc.w	L743
1511  1cef 01d7          	dc.w	L153
1512  1cf1 01e5          	dc.w	L353
1513  1cf3 01f3          	dc.w	L553
1514  1cf5 0201          	dc.w	L753
1515  1cf7 020e          	dc.w	L163
1516  1cf9 021b          	dc.w	L363
1517  1cfb 0228          	dc.w	L563
1518  1cfd 0235          	dc.w	L763
1519  1cff 0242          	dc.w	L173
1520  1d01 024f          	dc.w	L373
1521  1d03 025c          	dc.w	L573
1522  1d05 0269          	dc.w	L773
1523  1d07 0276          	dc.w	L104
1524                     ; 1727 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
1524                     ; 1728 {
1525                     .text:	section	.text,new
1526  0000               L7_CopyHttpData:
1528  0000 89            	pushw	x
1529  0001 5208          	subw	sp,#8
1530       00000008      OFST:	set	8
1533                     ; 1747   nBytes = 0;
1535  0003 5f            	clrw	x
1536  0004 1f05          	ldw	(OFST-3,sp),x
1538                     ; 1748   nParsedNum = 0;
1540  0006 0f07          	clr	(OFST-1,sp)
1542                     ; 1749   nParsedMode = 0;
1544  0008 0f04          	clr	(OFST-4,sp)
1546                     ; 1804   nMaxBytes = UIP_TCP_MSS - 25;
1548  000a ae019f        	ldw	x,#415
1549  000d 1f11          	ldw	(OFST+9,sp),x
1551  000f cc05df        	jra	L325
1552  0012               L125:
1553                     ; 1838     if (*pDataLeft > 0) {
1555  0012 1e0f          	ldw	x,(OFST+7,sp)
1556  0014 e601          	ld	a,(1,x)
1557  0016 fa            	or	a,(x)
1558  0017 2603cc05e8    	jreq	L525
1559                     ; 1845       if (insertion_flag[0] != 0) {
1561  001c c60000        	ld	a,_insertion_flag
1562  001f 2711          	jreq	L135
1563                     ; 1854         nParsedMode = insertion_flag[1];
1565  0021 c60001        	ld	a,_insertion_flag+1
1566  0024 6b04          	ld	(OFST-4,sp),a
1568                     ; 1855         nParsedNum = insertion_flag[2];
1570  0026 c60002        	ld	a,_insertion_flag+2
1571  0029 6b07          	ld	(OFST-1,sp),a
1573                     ; 1856 	nByte = '0'; // Need to set nByte to something other than '%' so we
1575  002b a630          	ld	a,#48
1576  002d 6b02          	ld	(OFST-6,sp),a
1579  002f cc00f1        	jra	L335
1580  0032               L135:
1581                     ; 1869         memcpy(&nByte, *ppData, 1);
1583  0032 96            	ldw	x,sp
1584  0033 1c0002        	addw	x,#OFST-6
1585  0036 bf00          	ldw	c_x,x
1586  0038 160d          	ldw	y,(OFST+5,sp)
1587  003a 90fe          	ldw	y,(y)
1588  003c 90bf00        	ldw	c_y,y
1589  003f ae0001        	ldw	x,#1
1590  0042               L25:
1591  0042 5a            	decw	x
1592  0043 92d600        	ld	a,([c_y.w],x)
1593  0046 92d700        	ld	([c_x.w],x),a
1594  0049 5d            	tnzw	x
1595  004a 26f6          	jrne	L25
1596                     ; 1912         if (nByte == '%') {
1598  004c 7b02          	ld	a,(OFST-6,sp)
1599  004e a125          	cp	a,#37
1600  0050 26dd          	jrne	L335
1601                     ; 1913           *ppData = *ppData + 1;
1603  0052 1e0d          	ldw	x,(OFST+5,sp)
1604  0054 9093          	ldw	y,x
1605  0056 fe            	ldw	x,(x)
1606  0057 5c            	incw	x
1607  0058 90ff          	ldw	(y),x
1608                     ; 1914           *pDataLeft = *pDataLeft - 1;
1610  005a 1e0f          	ldw	x,(OFST+7,sp)
1611  005c 9093          	ldw	y,x
1612  005e fe            	ldw	x,(x)
1613  005f 5a            	decw	x
1614  0060 90ff          	ldw	(y),x
1615                     ; 1919           memcpy(&nParsedMode, *ppData, 1);
1617  0062 96            	ldw	x,sp
1618  0063 1c0004        	addw	x,#OFST-4
1619  0066 bf00          	ldw	c_x,x
1620  0068 160d          	ldw	y,(OFST+5,sp)
1621  006a 90fe          	ldw	y,(y)
1622  006c 90bf00        	ldw	c_y,y
1623  006f ae0001        	ldw	x,#1
1624  0072               L45:
1625  0072 5a            	decw	x
1626  0073 92d600        	ld	a,([c_y.w],x)
1627  0076 92d700        	ld	([c_x.w],x),a
1628  0079 5d            	tnzw	x
1629  007a 26f6          	jrne	L45
1630                     ; 1920           *ppData = *ppData + 1;
1632  007c 1e0d          	ldw	x,(OFST+5,sp)
1633  007e 9093          	ldw	y,x
1634  0080 fe            	ldw	x,(x)
1635  0081 5c            	incw	x
1636  0082 90ff          	ldw	(y),x
1637                     ; 1921           *pDataLeft = *pDataLeft - 1;
1639  0084 1e0f          	ldw	x,(OFST+7,sp)
1640  0086 9093          	ldw	y,x
1641  0088 fe            	ldw	x,(x)
1642  0089 5a            	decw	x
1643  008a 90ff          	ldw	(y),x
1644                     ; 1926           memcpy(&temp, *ppData, 1);
1646  008c 96            	ldw	x,sp
1647  008d 5c            	incw	x
1648  008e bf00          	ldw	c_x,x
1649  0090 160d          	ldw	y,(OFST+5,sp)
1650  0092 90fe          	ldw	y,(y)
1651  0094 90bf00        	ldw	c_y,y
1652  0097 ae0001        	ldw	x,#1
1653  009a               L65:
1654  009a 5a            	decw	x
1655  009b 92d600        	ld	a,([c_y.w],x)
1656  009e 92d700        	ld	([c_x.w],x),a
1657  00a1 5d            	tnzw	x
1658  00a2 26f6          	jrne	L65
1659                     ; 1927           nParsedNum = (uint8_t)((temp - '0') * 10);
1661  00a4 7b01          	ld	a,(OFST-7,sp)
1662  00a6 97            	ld	xl,a
1663  00a7 a60a          	ld	a,#10
1664  00a9 42            	mul	x,a
1665  00aa 9f            	ld	a,xl
1666  00ab a0e0          	sub	a,#224
1667  00ad 6b07          	ld	(OFST-1,sp),a
1669                     ; 1928           *ppData = *ppData + 1;
1671  00af 1e0d          	ldw	x,(OFST+5,sp)
1672  00b1 9093          	ldw	y,x
1673  00b3 fe            	ldw	x,(x)
1674  00b4 5c            	incw	x
1675  00b5 90ff          	ldw	(y),x
1676                     ; 1929           *pDataLeft = *pDataLeft - 1;
1678  00b7 1e0f          	ldw	x,(OFST+7,sp)
1679  00b9 9093          	ldw	y,x
1680  00bb fe            	ldw	x,(x)
1681  00bc 5a            	decw	x
1682  00bd 90ff          	ldw	(y),x
1683                     ; 1934           memcpy(&temp, *ppData, 1);
1685  00bf 96            	ldw	x,sp
1686  00c0 5c            	incw	x
1687  00c1 bf00          	ldw	c_x,x
1688  00c3 160d          	ldw	y,(OFST+5,sp)
1689  00c5 90fe          	ldw	y,(y)
1690  00c7 90bf00        	ldw	c_y,y
1691  00ca ae0001        	ldw	x,#1
1692  00cd               L06:
1693  00cd 5a            	decw	x
1694  00ce 92d600        	ld	a,([c_y.w],x)
1695  00d1 92d700        	ld	([c_x.w],x),a
1696  00d4 5d            	tnzw	x
1697  00d5 26f6          	jrne	L06
1698                     ; 1935           nParsedNum = (uint8_t)(nParsedNum + temp - '0');
1700  00d7 7b07          	ld	a,(OFST-1,sp)
1701  00d9 1b01          	add	a,(OFST-7,sp)
1702  00db a030          	sub	a,#48
1703  00dd 6b07          	ld	(OFST-1,sp),a
1705                     ; 1936           *ppData = *ppData + 1;
1707  00df 1e0d          	ldw	x,(OFST+5,sp)
1708  00e1 9093          	ldw	y,x
1709  00e3 fe            	ldw	x,(x)
1710  00e4 5c            	incw	x
1711  00e5 90ff          	ldw	(y),x
1712                     ; 1937           *pDataLeft = *pDataLeft - 1;
1714  00e7 1e0f          	ldw	x,(OFST+7,sp)
1715  00e9 9093          	ldw	y,x
1716  00eb fe            	ldw	x,(x)
1717  00ec 5a            	decw	x
1718  00ed 90ff          	ldw	(y),x
1719  00ef 7b02          	ld	a,(OFST-6,sp)
1720  00f1               L335:
1721                     ; 1941       if ((nByte == '%') || (insertion_flag[0] != 0)) {
1723  00f1 a125          	cp	a,#37
1724  00f3 2709          	jreq	L145
1726  00f5 725d0000      	tnz	_insertion_flag
1727  00f9 2603cc05c2    	jreq	L735
1728  00fe               L145:
1729                     ; 1951         if (nParsedMode == 'i') {
1731  00fe 7b04          	ld	a,(OFST-4,sp)
1732  0100 a169          	cp	a,#105
1733  0102 262b          	jrne	L345
1734                     ; 1965           if (nParsedNum > 7) {
1736  0104 7b07          	ld	a,(OFST-1,sp)
1737  0106 a108          	cp	a,#8
1738  0108 2520          	jrult	L545
1739                     ; 1967 	    i = GpioGetPin(nParsedNum);
1741  010a cd0000        	call	_GpioGetPin
1743  010d 6b08          	ld	(OFST+0,sp),a
1745                     ; 1968 	    if (invert_input == 0x00) *pBuffer = (uint8_t)(i + '0');
1747  010f 725d0000      	tnz	_invert_input
1748  0113 2607          	jrne	L745
1751  0115               LC012:
1752  0115 ab30          	add	a,#48
1753  0117 1e09          	ldw	x,(OFST+1,sp)
1755  0119 cc04f8        	jra	L7201
1756  011c               L745:
1757                     ; 1970 	      if (i == 0) *pBuffer = (uint8_t)('1');
1759  011c 7b08          	ld	a,(OFST+0,sp)
1760  011e 2703cc04f4    	jrne	L5201
1763  0123 1e09          	ldw	x,(OFST+1,sp)
1764  0125 a631          	ld	a,#49
1766  0127 cc04f8        	jra	L7201
1767                     ; 1971 	      else *pBuffer = (uint8_t)('0');
1768                     ; 1973             pBuffer++;
1769                     ; 1974             nBytes++;
1771  012a               L545:
1772                     ; 1978 	    *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
1774  012a cd0000        	call	_GpioGetPin
1776                     ; 1979             pBuffer++;
1777                     ; 1980             nBytes++;
1778  012d 20e6          	jp	LC012
1779  012f               L345:
1780                     ; 1998         else if ((nParsedMode == 'o' && ((uint8_t)(GpioGetPin(nParsedNum) == 1)))
1780                     ; 1999 	      || (nParsedMode == 'p' && ((uint8_t)(GpioGetPin(nParsedNum) == 0)))) { 
1782  012f a16f          	cp	a,#111
1783  0131 260a          	jrne	L765
1785  0133 7b07          	ld	a,(OFST-1,sp)
1786  0135 cd0000        	call	_GpioGetPin
1788  0138 4a            	dec	a
1789  0139 270e          	jreq	L565
1790  013b 7b04          	ld	a,(OFST-4,sp)
1791  013d               L765:
1793  013d a170          	cp	a,#112
1794  013f 2626          	jrne	L365
1796  0141 7b07          	ld	a,(OFST-1,sp)
1797  0143 cd0000        	call	_GpioGetPin
1799  0146 4d            	tnz	a
1800  0147 261e          	jrne	L365
1801  0149               L565:
1802                     ; 2004           for(i=0; i<7; i++) {
1804  0149 4f            	clr	a
1805  014a 6b08          	ld	(OFST+0,sp),a
1807  014c               L175:
1808                     ; 2005             *pBuffer = checked[i];
1810  014c 5f            	clrw	x
1811  014d 97            	ld	xl,a
1812  014e d60000        	ld	a,(L11_checked,x)
1813  0151 1e09          	ldw	x,(OFST+1,sp)
1814  0153 f7            	ld	(x),a
1815                     ; 2006             pBuffer++;
1817  0154 5c            	incw	x
1818  0155 1f09          	ldw	(OFST+1,sp),x
1819                     ; 2004           for(i=0; i<7; i++) {
1821  0157 0c08          	inc	(OFST+0,sp)
1825  0159 7b08          	ld	a,(OFST+0,sp)
1826  015b a107          	cp	a,#7
1827  015d 25ed          	jrult	L175
1828                     ; 2008 	  nBytes += 7;
1830  015f 1e05          	ldw	x,(OFST-3,sp)
1831  0161 1c0007        	addw	x,#7
1833  0164 cc05dd        	jp	LC006
1834  0167               L365:
1835                     ; 2011         else if (nParsedMode == 'a') {
1837  0167 7b04          	ld	a,(OFST-4,sp)
1838  0169 a161          	cp	a,#97
1839  016b 2629          	jrne	L106
1840                     ; 2013 	  for(i=0; i<19; i++) {
1842  016d 4f            	clr	a
1843  016e 6b08          	ld	(OFST+0,sp),a
1845  0170               L306:
1846                     ; 2014 	    if (stored_devicename[i] != '\0') {
1848  0170 5f            	clrw	x
1849  0171 97            	ld	xl,a
1850  0172 724d0000      	tnz	(_stored_devicename,x)
1851  0176 2603cc05df    	jreq	L325
1852                     ; 2015               *pBuffer = (uint8_t)(stored_devicename[i]);
1854  017b 5f            	clrw	x
1855  017c 97            	ld	xl,a
1856  017d d60000        	ld	a,(_stored_devicename,x)
1857  0180 1e09          	ldw	x,(OFST+1,sp)
1858  0182 f7            	ld	(x),a
1859                     ; 2016               pBuffer++;
1861  0183 5c            	incw	x
1862  0184 1f09          	ldw	(OFST+1,sp),x
1863                     ; 2017               nBytes++;
1865  0186 1e05          	ldw	x,(OFST-3,sp)
1866  0188 5c            	incw	x
1867  0189 1f05          	ldw	(OFST-3,sp),x
1870                     ; 2013 	  for(i=0; i<19; i++) {
1872  018b 0c08          	inc	(OFST+0,sp)
1876  018d 7b08          	ld	a,(OFST+0,sp)
1877  018f a113          	cp	a,#19
1878  0191 25dd          	jrult	L306
1879  0193 cc05df        	jra	L325
1880  0196               L106:
1881                     ; 2023         else if (nParsedMode == 'b') {
1883  0196 a162          	cp	a,#98
1884  0198 2703cc02b2    	jrne	L716
1885                     ; 2028           switch (nParsedNum)
1887  019d 7b07          	ld	a,(OFST-1,sp)
1889                     ; 2049 	    default: break;
1890  019f a110          	cp	a,#16
1891  01a1 2503cc0294    	jruge	L326
1892  01a6 5f            	clrw	x
1893  01a7 97            	ld	xl,a
1894  01a8 58            	sllw	x
1895  01a9 de1ce9        	ldw	x,(L431,x)
1896  01ac fc            	jp	(x)
1897  01ad               L343:
1898                     ; 2031 	    case 0:  emb_itoa(stored_hostaddr[3], OctetArray, 10, 3); break;
1900  01ad 4b03          	push	#3
1901  01af 4b0a          	push	#10
1902  01b1 ae0045        	ldw	x,#_OctetArray
1903  01b4 89            	pushw	x
1904  01b5 c60003        	ld	a,_stored_hostaddr+3
1908  01b8 cc0281        	jp	LC001
1909  01bb               L543:
1910                     ; 2032 	    case 1:  emb_itoa(stored_hostaddr[2], OctetArray, 10, 3); break;
1912  01bb 4b03          	push	#3
1913  01bd 4b0a          	push	#10
1914  01bf ae0045        	ldw	x,#_OctetArray
1915  01c2 89            	pushw	x
1916  01c3 c60002        	ld	a,_stored_hostaddr+2
1920  01c6 cc0281        	jp	LC001
1921  01c9               L743:
1922                     ; 2033 	    case 2:  emb_itoa(stored_hostaddr[1], OctetArray, 10, 3); break;
1924  01c9 4b03          	push	#3
1925  01cb 4b0a          	push	#10
1926  01cd ae0045        	ldw	x,#_OctetArray
1927  01d0 89            	pushw	x
1928  01d1 c60001        	ld	a,_stored_hostaddr+1
1932  01d4 cc0281        	jp	LC001
1933  01d7               L153:
1934                     ; 2034 	    case 3:  emb_itoa(stored_hostaddr[0], OctetArray, 10, 3); break;
1936  01d7 4b03          	push	#3
1937  01d9 4b0a          	push	#10
1938  01db ae0045        	ldw	x,#_OctetArray
1939  01de 89            	pushw	x
1940  01df c60000        	ld	a,_stored_hostaddr
1944  01e2 cc0281        	jp	LC001
1945  01e5               L353:
1946                     ; 2035 	    case 4:  emb_itoa(stored_draddr[3],   OctetArray, 10, 3); break;
1948  01e5 4b03          	push	#3
1949  01e7 4b0a          	push	#10
1950  01e9 ae0045        	ldw	x,#_OctetArray
1951  01ec 89            	pushw	x
1952  01ed c60003        	ld	a,_stored_draddr+3
1956  01f0 cc0281        	jp	LC001
1957  01f3               L553:
1958                     ; 2036 	    case 5:  emb_itoa(stored_draddr[2],   OctetArray, 10, 3); break;
1960  01f3 4b03          	push	#3
1961  01f5 4b0a          	push	#10
1962  01f7 ae0045        	ldw	x,#_OctetArray
1963  01fa 89            	pushw	x
1964  01fb c60002        	ld	a,_stored_draddr+2
1968  01fe cc0281        	jp	LC001
1969  0201               L753:
1970                     ; 2037 	    case 6:  emb_itoa(stored_draddr[1],   OctetArray, 10, 3); break;
1972  0201 4b03          	push	#3
1973  0203 4b0a          	push	#10
1974  0205 ae0045        	ldw	x,#_OctetArray
1975  0208 89            	pushw	x
1976  0209 c60001        	ld	a,_stored_draddr+1
1980  020c 2073          	jp	LC001
1981  020e               L163:
1982                     ; 2038 	    case 7:  emb_itoa(stored_draddr[0],   OctetArray, 10, 3); break;
1984  020e 4b03          	push	#3
1985  0210 4b0a          	push	#10
1986  0212 ae0045        	ldw	x,#_OctetArray
1987  0215 89            	pushw	x
1988  0216 c60000        	ld	a,_stored_draddr
1992  0219 2066          	jp	LC001
1993  021b               L363:
1994                     ; 2039 	    case 8:  emb_itoa(stored_netmask[3],  OctetArray, 10, 3); break;
1996  021b 4b03          	push	#3
1997  021d 4b0a          	push	#10
1998  021f ae0045        	ldw	x,#_OctetArray
1999  0222 89            	pushw	x
2000  0223 c60003        	ld	a,_stored_netmask+3
2004  0226 2059          	jp	LC001
2005  0228               L563:
2006                     ; 2040 	    case 9:  emb_itoa(stored_netmask[2],  OctetArray, 10, 3); break;
2008  0228 4b03          	push	#3
2009  022a 4b0a          	push	#10
2010  022c ae0045        	ldw	x,#_OctetArray
2011  022f 89            	pushw	x
2012  0230 c60002        	ld	a,_stored_netmask+2
2016  0233 204c          	jp	LC001
2017  0235               L763:
2018                     ; 2041 	    case 10: emb_itoa(stored_netmask[1],  OctetArray, 10, 3); break;
2020  0235 4b03          	push	#3
2021  0237 4b0a          	push	#10
2022  0239 ae0045        	ldw	x,#_OctetArray
2023  023c 89            	pushw	x
2024  023d c60001        	ld	a,_stored_netmask+1
2028  0240 203f          	jp	LC001
2029  0242               L173:
2030                     ; 2042 	    case 11: emb_itoa(stored_netmask[0],  OctetArray, 10, 3); break;
2032  0242 4b03          	push	#3
2033  0244 4b0a          	push	#10
2034  0246 ae0045        	ldw	x,#_OctetArray
2035  0249 89            	pushw	x
2036  024a c60000        	ld	a,_stored_netmask
2040  024d 2032          	jp	LC001
2041  024f               L373:
2042                     ; 2044 	    case 12: emb_itoa(stored_mqttserveraddr[3], OctetArray, 10, 3); break;
2044  024f 4b03          	push	#3
2045  0251 4b0a          	push	#10
2046  0253 ae0045        	ldw	x,#_OctetArray
2047  0256 89            	pushw	x
2048  0257 c60003        	ld	a,_stored_mqttserveraddr+3
2052  025a 2025          	jp	LC001
2053  025c               L573:
2054                     ; 2045 	    case 13: emb_itoa(stored_mqttserveraddr[2], OctetArray, 10, 3); break;
2056  025c 4b03          	push	#3
2057  025e 4b0a          	push	#10
2058  0260 ae0045        	ldw	x,#_OctetArray
2059  0263 89            	pushw	x
2060  0264 c60002        	ld	a,_stored_mqttserveraddr+2
2064  0267 2018          	jp	LC001
2065  0269               L773:
2066                     ; 2046 	    case 14: emb_itoa(stored_mqttserveraddr[1], OctetArray, 10, 3); break;
2068  0269 4b03          	push	#3
2069  026b 4b0a          	push	#10
2070  026d ae0045        	ldw	x,#_OctetArray
2071  0270 89            	pushw	x
2072  0271 c60001        	ld	a,_stored_mqttserveraddr+1
2076  0274 200b          	jp	LC001
2077  0276               L104:
2078                     ; 2047 	    case 15: emb_itoa(stored_mqttserveraddr[0], OctetArray, 10, 3); break;
2080  0276 4b03          	push	#3
2081  0278 4b0a          	push	#10
2082  027a ae0045        	ldw	x,#_OctetArray
2083  027d 89            	pushw	x
2084  027e c60000        	ld	a,_stored_mqttserveraddr
2086  0281               LC001:
2087  0281 b703          	ld	c_lreg+3,a
2088  0283 3f02          	clr	c_lreg+2
2089  0285 3f01          	clr	c_lreg+1
2090  0287 3f00          	clr	c_lreg
2091  0289 be02          	ldw	x,c_lreg+2
2092  028b 89            	pushw	x
2093  028c be00          	ldw	x,c_lreg
2094  028e 89            	pushw	x
2095  028f cd0000        	call	_emb_itoa
2096  0292 5b08          	addw	sp,#8
2099                     ; 2049 	    default: break;
2101  0294               L326:
2102                     ; 2053 	  for(i=0; i<3; i++) {
2104  0294 4f            	clr	a
2105  0295 6b08          	ld	(OFST+0,sp),a
2107  0297               L526:
2108                     ; 2054 	    *pBuffer = (uint8_t)OctetArray[i];
2110  0297 5f            	clrw	x
2111  0298 97            	ld	xl,a
2112  0299 d60045        	ld	a,(_OctetArray,x)
2113  029c 1e09          	ldw	x,(OFST+1,sp)
2114  029e f7            	ld	(x),a
2115                     ; 2055             pBuffer++;
2117  029f 5c            	incw	x
2118  02a0 1f09          	ldw	(OFST+1,sp),x
2119                     ; 2053 	  for(i=0; i<3; i++) {
2121  02a2 0c08          	inc	(OFST+0,sp)
2125  02a4 7b08          	ld	a,(OFST+0,sp)
2126  02a6 a103          	cp	a,#3
2127  02a8 25ed          	jrult	L526
2128                     ; 2057 	  nBytes += 3;
2130  02aa 1e05          	ldw	x,(OFST-3,sp)
2131  02ac 1c0003        	addw	x,#3
2133  02af cc05dd        	jp	LC006
2134  02b2               L716:
2135                     ; 2060         else if (nParsedMode == 'c') {
2137  02b2 a163          	cp	a,#99
2138  02b4 2648          	jrne	L536
2139                     ; 2069 	  if (nParsedNum == 0) emb_itoa(stored_port, OctetArray, 10, 5);
2141  02b6 7b07          	ld	a,(OFST-1,sp)
2142  02b8 260d          	jrne	L736
2145  02ba 4b05          	push	#5
2146  02bc 4b0a          	push	#10
2147  02be ae0045        	ldw	x,#_OctetArray
2148  02c1 89            	pushw	x
2149  02c2 ce0000        	ldw	x,_stored_port
2153  02c5 200b          	jra	L146
2154  02c7               L736:
2155                     ; 2071 	  else emb_itoa(stored_mqttport, OctetArray, 10, 5);
2157  02c7 4b05          	push	#5
2158  02c9 4b0a          	push	#10
2159  02cb ae0045        	ldw	x,#_OctetArray
2160  02ce 89            	pushw	x
2161  02cf ce0000        	ldw	x,_stored_mqttport
2164  02d2               L146:
2165  02d2 cd0000        	call	c_uitolx
2166  02d5 be02          	ldw	x,c_lreg+2
2167  02d7 89            	pushw	x
2168  02d8 be00          	ldw	x,c_lreg
2169  02da 89            	pushw	x
2170  02db cd0000        	call	_emb_itoa
2171  02de 5b08          	addw	sp,#8
2172                     ; 2075 	  for(i=0; i<5; i++) {
2174  02e0 4f            	clr	a
2175  02e1 6b08          	ld	(OFST+0,sp),a
2177  02e3               L346:
2178                     ; 2076             *pBuffer = (uint8_t)OctetArray[i];
2180  02e3 5f            	clrw	x
2181  02e4 97            	ld	xl,a
2182  02e5 d60045        	ld	a,(_OctetArray,x)
2183  02e8 1e09          	ldw	x,(OFST+1,sp)
2184  02ea f7            	ld	(x),a
2185                     ; 2077             pBuffer++;
2187  02eb 5c            	incw	x
2188  02ec 1f09          	ldw	(OFST+1,sp),x
2189                     ; 2075 	  for(i=0; i<5; i++) {
2191  02ee 0c08          	inc	(OFST+0,sp)
2195  02f0 7b08          	ld	a,(OFST+0,sp)
2196  02f2 a105          	cp	a,#5
2197  02f4 25ed          	jrult	L346
2198                     ; 2079 	  nBytes += 5;
2200  02f6 1e05          	ldw	x,(OFST-3,sp)
2201  02f8 1c0005        	addw	x,#5
2203  02fb cc05dd        	jp	LC006
2204  02fe               L536:
2205                     ; 2082         else if (nParsedMode == 'd') {
2207  02fe a164          	cp	a,#100
2208  0300 266a          	jrne	L356
2209                     ; 2087 	  if (nParsedNum == 0) { OctetArray[0] = mac_string[0]; OctetArray[1] = mac_string[1]; }
2211  0302 7b07          	ld	a,(OFST-1,sp)
2212  0304 260a          	jrne	L556
2215  0306 5500000045    	mov	_OctetArray,_mac_string
2218  030b 5500010046    	mov	_OctetArray+1,_mac_string+1
2219  0310               L556:
2220                     ; 2088 	  if (nParsedNum == 1) { OctetArray[0] = mac_string[2]; OctetArray[1] = mac_string[3]; }
2222  0310 a101          	cp	a,#1
2223  0312 260a          	jrne	L756
2226  0314 5500020045    	mov	_OctetArray,_mac_string+2
2229  0319 5500030046    	mov	_OctetArray+1,_mac_string+3
2230  031e               L756:
2231                     ; 2089 	  if (nParsedNum == 2) { OctetArray[0] = mac_string[4]; OctetArray[1] = mac_string[5]; }
2233  031e a102          	cp	a,#2
2234  0320 260a          	jrne	L166
2237  0322 5500040045    	mov	_OctetArray,_mac_string+4
2240  0327 5500050046    	mov	_OctetArray+1,_mac_string+5
2241  032c               L166:
2242                     ; 2090 	  if (nParsedNum == 3) { OctetArray[0] = mac_string[6]; OctetArray[1] = mac_string[7]; }
2244  032c a103          	cp	a,#3
2245  032e 260a          	jrne	L366
2248  0330 5500060045    	mov	_OctetArray,_mac_string+6
2251  0335 5500070046    	mov	_OctetArray+1,_mac_string+7
2252  033a               L366:
2253                     ; 2091 	  if (nParsedNum == 4) { OctetArray[0] = mac_string[8]; OctetArray[1] = mac_string[9]; }
2255  033a a104          	cp	a,#4
2256  033c 260a          	jrne	L566
2259  033e 5500080045    	mov	_OctetArray,_mac_string+8
2262  0343 5500090046    	mov	_OctetArray+1,_mac_string+9
2263  0348               L566:
2264                     ; 2092 	  if (nParsedNum == 5) { OctetArray[0] = mac_string[10]; OctetArray[1] = mac_string[11]; }
2266  0348 a105          	cp	a,#5
2267  034a 260a          	jrne	L766
2270  034c 55000a0045    	mov	_OctetArray,_mac_string+10
2273  0351 55000b0046    	mov	_OctetArray+1,_mac_string+11
2274  0356               L766:
2275                     ; 2094           *pBuffer = OctetArray[0];
2277  0356 1e09          	ldw	x,(OFST+1,sp)
2278  0358 c60045        	ld	a,_OctetArray
2279  035b f7            	ld	(x),a
2280                     ; 2095           pBuffer++;
2282  035c 5c            	incw	x
2283  035d 1f09          	ldw	(OFST+1,sp),x
2284                     ; 2096           nBytes++;
2286  035f 1e05          	ldw	x,(OFST-3,sp)
2287  0361 5c            	incw	x
2288  0362 1f05          	ldw	(OFST-3,sp),x
2290                     ; 2098           *pBuffer = OctetArray[1];
2292  0364 c60046        	ld	a,_OctetArray+1
2293  0367 1e09          	ldw	x,(OFST+1,sp)
2294                     ; 2099           pBuffer++;
2295                     ; 2100           nBytes++;
2297  0369 cc04f8        	jp	L7201
2298  036c               L356:
2299                     ; 2168         else if (nParsedMode == 'e') {
2301  036c a165          	cp	a,#101
2302  036e 2677          	jrne	L376
2303                     ; 2169           switch (nParsedNum)
2305  0370 7b07          	ld	a,(OFST-1,sp)
2307                     ; 2176 	    case 29:  emb_itoa(TRANSMIT_counter, OctetArray, 10, 10); break;
2308  0372 a01a          	sub	a,#26
2309  0374 270b          	jreq	L504
2310  0376 4a            	dec	a
2311  0377 2719          	jreq	L704
2312  0379 4a            	dec	a
2313  037a 2727          	jreq	L114
2314  037c 4a            	dec	a
2315  037d 2735          	jreq	L314
2316  037f 2048          	jra	L776
2317  0381               L504:
2318                     ; 2173 	    case 26:  emb_itoa(second_counter, OctetArray, 10, 10); break;
2320  0381 4b0a          	push	#10
2321  0383 4b0a          	push	#10
2322  0385 ae0045        	ldw	x,#_OctetArray
2323  0388 89            	pushw	x
2324  0389 ce0002        	ldw	x,_second_counter+2
2325  038c 89            	pushw	x
2326  038d ce0000        	ldw	x,_second_counter
2330  0390 2031          	jp	LC002
2331  0392               L704:
2332                     ; 2174 	    case 27:  emb_itoa(RXERIF_counter, OctetArray, 10, 10); break;
2334  0392 4b0a          	push	#10
2335  0394 4b0a          	push	#10
2336  0396 ae0045        	ldw	x,#_OctetArray
2337  0399 89            	pushw	x
2338  039a ce0002        	ldw	x,_RXERIF_counter+2
2339  039d 89            	pushw	x
2340  039e ce0000        	ldw	x,_RXERIF_counter
2344  03a1 2020          	jp	LC002
2345  03a3               L114:
2346                     ; 2175 	    case 28:  emb_itoa(TXERIF_counter, OctetArray, 10, 10); break;
2348  03a3 4b0a          	push	#10
2349  03a5 4b0a          	push	#10
2350  03a7 ae0045        	ldw	x,#_OctetArray
2351  03aa 89            	pushw	x
2352  03ab ce0002        	ldw	x,_TXERIF_counter+2
2353  03ae 89            	pushw	x
2354  03af ce0000        	ldw	x,_TXERIF_counter
2358  03b2 200f          	jp	LC002
2359  03b4               L314:
2360                     ; 2176 	    case 29:  emb_itoa(TRANSMIT_counter, OctetArray, 10, 10); break;
2362  03b4 4b0a          	push	#10
2363  03b6 4b0a          	push	#10
2364  03b8 ae0045        	ldw	x,#_OctetArray
2365  03bb 89            	pushw	x
2366  03bc ce0002        	ldw	x,_TRANSMIT_counter+2
2367  03bf 89            	pushw	x
2368  03c0 ce0000        	ldw	x,_TRANSMIT_counter
2370  03c3               LC002:
2371  03c3 89            	pushw	x
2372  03c4 cd0000        	call	_emb_itoa
2373  03c7 5b08          	addw	sp,#8
2376  03c9               L776:
2377                     ; 2178 	  for (i=0; i<10; i++) {
2379  03c9 4f            	clr	a
2380  03ca 6b08          	ld	(OFST+0,sp),a
2382  03cc               L107:
2383                     ; 2179             *pBuffer = OctetArray[i];
2385  03cc 5f            	clrw	x
2386  03cd 97            	ld	xl,a
2387  03ce d60045        	ld	a,(_OctetArray,x)
2388  03d1 1e09          	ldw	x,(OFST+1,sp)
2389  03d3 f7            	ld	(x),a
2390                     ; 2180             pBuffer++;
2392  03d4 5c            	incw	x
2393  03d5 1f09          	ldw	(OFST+1,sp),x
2394                     ; 2178 	  for (i=0; i<10; i++) {
2396  03d7 0c08          	inc	(OFST+0,sp)
2400  03d9 7b08          	ld	a,(OFST+0,sp)
2401  03db a10a          	cp	a,#10
2402  03dd 25ed          	jrult	L107
2403                     ; 2182 	  nBytes += 10;
2405  03df 1e05          	ldw	x,(OFST-3,sp)
2406  03e1 1c000a        	addw	x,#10
2408  03e4 cc05dd        	jp	LC006
2409  03e7               L376:
2410                     ; 2186         else if (nParsedMode == 'f') {
2412  03e7 a166          	cp	a,#102
2413  03e9 263d          	jrne	L117
2414                     ; 2201 	  for(i=0; i<16; i++) {
2416  03eb 4f            	clr	a
2417  03ec 6b08          	ld	(OFST+0,sp),a
2419  03ee               L317:
2420                     ; 2202             if (i > 7) {
2422  03ee a108          	cp	a,#8
2423  03f0 251b          	jrult	L127
2424                     ; 2204               j = GpioGetPin(i);
2426  03f2 cd0000        	call	_GpioGetPin
2428  03f5 6b03          	ld	(OFST-5,sp),a
2430                     ; 2205               if (invert_input == 0x00) *pBuffer = (uint8_t)(j + '0');
2432  03f7 725d0000      	tnz	_invert_input
2435  03fb 2713          	jreq	LC010
2436                     ; 2207                 if (j == 0) *pBuffer = (uint8_t)('1'); 
2438  03fd 7b03          	ld	a,(OFST-5,sp)
2439  03ff 2606          	jrne	L727
2442  0401 1e09          	ldw	x,(OFST+1,sp)
2443  0403 a631          	ld	a,#49
2445  0405 200d          	jra	L337
2446  0407               L727:
2447                     ; 2208                 else *pBuffer = (uint8_t)('0');
2449  0407 1e09          	ldw	x,(OFST+1,sp)
2450  0409 a630          	ld	a,#48
2451                     ; 2210               pBuffer++;
2453  040b 2007          	jra	L337
2454  040d               L127:
2455                     ; 2214               *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
2457  040d cd0000        	call	_GpioGetPin
2459  0410               LC010:
2461  0410 ab30          	add	a,#48
2462  0412 1e09          	ldw	x,(OFST+1,sp)
2463                     ; 2215               pBuffer++;
2465  0414               L337:
2466  0414 f7            	ld	(x),a
2468  0415 5c            	incw	x
2469  0416 1f09          	ldw	(OFST+1,sp),x
2470                     ; 2201 	  for(i=0; i<16; i++) {
2472  0418 0c08          	inc	(OFST+0,sp)
2476  041a 7b08          	ld	a,(OFST+0,sp)
2477  041c a110          	cp	a,#16
2478  041e 25ce          	jrult	L317
2479                     ; 2218 	  nBytes += 16;
2481  0420 1e05          	ldw	x,(OFST-3,sp)
2482  0422 1c0010        	addw	x,#16
2484  0425 cc05dd        	jp	LC006
2485  0428               L117:
2486                     ; 2237 else if (nParsedMode == 'g') {
2488  0428 a167          	cp	a,#103
2489  042a 261e          	jrne	L737
2490                     ; 2250 	  for(i = 0; i < 6; i++) {
2492  042c 4f            	clr	a
2493  042d 6b08          	ld	(OFST+0,sp),a
2495  042f               L147:
2496                     ; 2251             *pBuffer = stored_config_settings[i];
2498  042f 5f            	clrw	x
2499  0430 97            	ld	xl,a
2500  0431 d60000        	ld	a,(_stored_config_settings,x)
2501  0434 1e09          	ldw	x,(OFST+1,sp)
2502  0436 f7            	ld	(x),a
2503                     ; 2252             pBuffer++;
2505  0437 5c            	incw	x
2506  0438 1f09          	ldw	(OFST+1,sp),x
2507                     ; 2250 	  for(i = 0; i < 6; i++) {
2509  043a 0c08          	inc	(OFST+0,sp)
2513  043c 7b08          	ld	a,(OFST+0,sp)
2514  043e a106          	cp	a,#6
2515  0440 25ed          	jrult	L147
2516                     ; 2254           nBytes += 6;
2518  0442 1e05          	ldw	x,(OFST-3,sp)
2519  0444 1c0006        	addw	x,#6
2521  0447 cc05dd        	jp	LC006
2522  044a               L737:
2523                     ; 2258         else if (nParsedMode == 'l') {
2525  044a a16c          	cp	a,#108
2526  044c 2629          	jrne	L157
2527                     ; 2261           for(i=0; i<10; i++) {
2529  044e 4f            	clr	a
2530  044f 6b08          	ld	(OFST+0,sp),a
2532  0451               L357:
2533                     ; 2262 	    if (stored_mqtt_username[i] != '\0') {
2535  0451 5f            	clrw	x
2536  0452 97            	ld	xl,a
2537  0453 724d0000      	tnz	(_stored_mqtt_username,x)
2538  0457 2603cc05df    	jreq	L325
2539                     ; 2263               *pBuffer = (uint8_t)(stored_mqtt_username[i]);
2541  045c 5f            	clrw	x
2542  045d 97            	ld	xl,a
2543  045e d60000        	ld	a,(_stored_mqtt_username,x)
2544  0461 1e09          	ldw	x,(OFST+1,sp)
2545  0463 f7            	ld	(x),a
2546                     ; 2264               pBuffer++;
2548  0464 5c            	incw	x
2549  0465 1f09          	ldw	(OFST+1,sp),x
2550                     ; 2265               nBytes++;
2552  0467 1e05          	ldw	x,(OFST-3,sp)
2553  0469 5c            	incw	x
2554  046a 1f05          	ldw	(OFST-3,sp),x
2557                     ; 2261           for(i=0; i<10; i++) {
2559  046c 0c08          	inc	(OFST+0,sp)
2563  046e 7b08          	ld	a,(OFST+0,sp)
2564  0470 a10a          	cp	a,#10
2565  0472 25dd          	jrult	L357
2566  0474 cc05df        	jra	L325
2567  0477               L157:
2568                     ; 2271         else if (nParsedMode == 'm') {
2570  0477 a16d          	cp	a,#109
2571  0479 2626          	jrne	L767
2572                     ; 2274           for(i=0; i<10; i++) {
2574  047b 4f            	clr	a
2575  047c 6b08          	ld	(OFST+0,sp),a
2577  047e               L177:
2578                     ; 2275 	    if (stored_mqtt_password[i] != '\0') {
2580  047e 5f            	clrw	x
2581  047f 97            	ld	xl,a
2582  0480 724d0000      	tnz	(_stored_mqtt_password,x)
2583  0484 27ee          	jreq	L325
2584                     ; 2276               *pBuffer = (uint8_t)(stored_mqtt_password[i]);
2586  0486 5f            	clrw	x
2587  0487 97            	ld	xl,a
2588  0488 d60000        	ld	a,(_stored_mqtt_password,x)
2589  048b 1e09          	ldw	x,(OFST+1,sp)
2590  048d f7            	ld	(x),a
2591                     ; 2277               pBuffer++;
2593  048e 5c            	incw	x
2594  048f 1f09          	ldw	(OFST+1,sp),x
2595                     ; 2278               nBytes++;
2597  0491 1e05          	ldw	x,(OFST-3,sp)
2598  0493 5c            	incw	x
2599  0494 1f05          	ldw	(OFST-3,sp),x
2602                     ; 2274           for(i=0; i<10; i++) {
2604  0496 0c08          	inc	(OFST+0,sp)
2608  0498 7b08          	ld	a,(OFST+0,sp)
2609  049a a10a          	cp	a,#10
2610  049c 25e0          	jrult	L177
2611  049e cc05df        	jra	L325
2612  04a1               L767:
2613                     ; 2284         else if (nParsedMode == 'n') {
2615  04a1 a16e          	cp	a,#110
2616  04a3 2657          	jrne	L5001
2617                     ; 2288 	  no_err = 0;
2619  04a5 0f08          	clr	(OFST+0,sp)
2621                     ; 2289           switch (nParsedNum)
2623  04a7 7b07          	ld	a,(OFST-1,sp)
2625                     ; 2311 	    default:
2625                     ; 2312 	      break;
2626  04a9 270e          	jreq	L514
2627  04ab 4a            	dec	a
2628  04ac 2712          	jreq	L714
2629  04ae 4a            	dec	a
2630  04af 2716          	jreq	L124
2631  04b1 4a            	dec	a
2632  04b2 271a          	jreq	L324
2633  04b4 4a            	dec	a
2634  04b5 271f          	jreq	L524
2635  04b7 2030          	jra	L1101
2636  04b9               L514:
2637                     ; 2291 	    case 0:
2637                     ; 2292               // Connection request status
2637                     ; 2293 	      if (mqtt_start_status & MQTT_START_CONNECTIONS_GOOD) no_err = 1;
2639  04b9 720900002b    	btjf	_mqtt_start_status,#4,L1101
2641  04be 2013          	jp	LC004
2642  04c0               L714:
2643                     ; 2295 	    case 1:
2643                     ; 2296 	      // ARP request status
2643                     ; 2297 	      if (mqtt_start_status & MQTT_START_ARP_REQUEST_GOOD) no_err = 1;
2645  04c0 720b000024    	btjf	_mqtt_start_status,#5,L1101
2647  04c5 200c          	jp	LC004
2648  04c7               L124:
2649                     ; 2299 	    case 2:
2649                     ; 2300 	      // TCP connection status
2649                     ; 2301 	      if (mqtt_start_status & MQTT_START_TCP_CONNECT_GOOD) no_err = 1;
2651  04c7 720d00001d    	btjf	_mqtt_start_status,#6,L1101
2653  04cc 2005          	jp	LC004
2654  04ce               L324:
2655                     ; 2303 	    case 3:
2655                     ; 2304 	      // MQTT Connection status 1
2655                     ; 2305 	      if (mqtt_start_status & MQTT_START_MQTT_CONNECT_GOOD) no_err = 1;
2657  04ce 720f000016    	btjf	_mqtt_start_status,#7,L1101
2660  04d3               LC004:
2664  04d3 4c            	inc	a
2665  04d4 2011          	jp	LC003
2666  04d6               L524:
2667                     ; 2307 	    case 4:
2667                     ; 2308 	      // MQTT start complete with no errors
2667                     ; 2309 	      if ((MQTT_error_status == 1) && ((mqtt_start_status & 0xf0) == 0xf0) ) no_err = 1;
2669  04d6 c60000        	ld	a,_MQTT_error_status
2670  04d9 4a            	dec	a
2671  04da 260d          	jrne	L1101
2673  04dc c60000        	ld	a,_mqtt_start_status
2674  04df a4f0          	and	a,#240
2675  04e1 a1f0          	cp	a,#240
2676  04e3 2604          	jrne	L1101
2679  04e5 a601          	ld	a,#1
2680  04e7               LC003:
2681  04e7 6b08          	ld	(OFST+0,sp),a
2683                     ; 2311 	    default:
2683                     ; 2312 	      break;
2685  04e9               L1101:
2686                     ; 2314 	  if (no_err == 1) *pBuffer = '1'; // Paint a green square
2688  04e9 7b08          	ld	a,(OFST+0,sp)
2689  04eb 4a            	dec	a
2690  04ec 2606          	jrne	L5201
2693  04ee 1e09          	ldw	x,(OFST+1,sp)
2694  04f0 a631          	ld	a,#49
2696  04f2 2004          	jra	L7201
2697  04f4               L5201:
2698                     ; 2315 	  else *pBuffer = '0'; // Paint a red square
2701  04f4 1e09          	ldw	x,(OFST+1,sp)
2702  04f6 a630          	ld	a,#48
2703  04f8               L7201:
2704  04f8 f7            	ld	(x),a
2705                     ; 2316           pBuffer++;
2706                     ; 2317           nBytes++;
2708  04f9 cc05d7        	jp	LC007
2709  04fc               L5001:
2710                     ; 2321         else if (nParsedMode == 'y') {
2712  04fc a179          	cp	a,#121
2713  04fe 269e          	jrne	L325
2714                     ; 2366 	  i = insertion_flag[0];
2716  0500 c60000        	ld	a,_insertion_flag
2717  0503 6b08          	ld	(OFST+0,sp),a
2719                     ; 2367 	  insertion_flag[1] = nParsedMode;
2721  0505 7b04          	ld	a,(OFST-4,sp)
2722  0507 c70001        	ld	_insertion_flag+1,a
2723                     ; 2368 	  insertion_flag[2] = nParsedNum;
2725  050a 7b07          	ld	a,(OFST-1,sp)
2726  050c c70002        	ld	_insertion_flag+2,a
2727                     ; 2370           switch (nParsedNum)
2730                     ; 2418 	    default: break;
2731  050f 2718          	jreq	L134
2732  0511 4a            	dec	a
2733  0512 272a          	jreq	L334
2734  0514 4a            	dec	a
2735  0515 273c          	jreq	L534
2736  0517 4a            	dec	a
2737  0518 274e          	jreq	L734
2738  051a 4a            	dec	a
2739  051b 2760          	jreq	L144
2740  051d 4a            	dec	a
2741  051e 2772          	jreq	L344
2742  0520 4a            	dec	a
2743  0521 2603cc05a7    	jreq	L544
2744  0526 cc05d5        	jra	LC008
2745  0529               L134:
2746                     ; 2372 	    case 0:
2746                     ; 2373 	      // %y00 replaced with string 
2746                     ; 2374 	      // page_string00[] = "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'";
2746                     ; 2375               *pBuffer = (uint8_t)page_string00[i];
2748  0529 7b08          	ld	a,(OFST+0,sp)
2749  052b 5f            	clrw	x
2750  052c 97            	ld	xl,a
2751  052d d61a6e        	ld	a,(L52_page_string00,x)
2752  0530 1e09          	ldw	x,(OFST+1,sp)
2753  0532 f7            	ld	(x),a
2754                     ; 2376 	      insertion_flag[0]++;
2756  0533 725c0000      	inc	_insertion_flag
2757                     ; 2377 	      if (insertion_flag[0] == page_string00_len) insertion_flag[0] = 0;
2759  0537 c60000        	ld	a,_insertion_flag
2760  053a a13f          	cp	a,#63
2762  053c 207c          	jp	LC005
2763  053e               L334:
2764                     ; 2379 	    case 1:
2764                     ; 2380 	      // %y01 replaced with string 
2764                     ; 2381               // page_string01[] = "pattern='[0-9a-f]{2}' title='Enter 00 to ff' maxlength='2'";
2764                     ; 2382               *pBuffer = (uint8_t)page_string01[i];
2766  053e 7b08          	ld	a,(OFST+0,sp)
2767  0540 5f            	clrw	x
2768  0541 97            	ld	xl,a
2769  0542 d61ab0        	ld	a,(L33_page_string01,x)
2770  0545 1e09          	ldw	x,(OFST+1,sp)
2771  0547 f7            	ld	(x),a
2772                     ; 2383 	      insertion_flag[0]++;
2774  0548 725c0000      	inc	_insertion_flag
2775                     ; 2384 	      if (insertion_flag[0] == page_string01_len) insertion_flag[0] = 0;
2777  054c c60000        	ld	a,_insertion_flag
2778  054f a140          	cp	a,#64
2780  0551 2067          	jp	LC005
2781  0553               L534:
2782                     ; 2386 	    case 2:
2782                     ; 2387 	      // %y02 replaced with string 
2782                     ; 2388               // page_string02[] = "<button title='Save first! This button will not save your changes'>";
2782                     ; 2389               *pBuffer = (uint8_t)page_string02[i];
2784  0553 7b08          	ld	a,(OFST+0,sp)
2785  0555 5f            	clrw	x
2786  0556 97            	ld	xl,a
2787  0557 d61af3        	ld	a,(L14_page_string02,x)
2788  055a 1e09          	ldw	x,(OFST+1,sp)
2789  055c f7            	ld	(x),a
2790                     ; 2390 	      insertion_flag[0]++;
2792  055d 725c0000      	inc	_insertion_flag
2793                     ; 2391 	      if (insertion_flag[0] == page_string02_len) insertion_flag[0] = 0;
2795  0561 c60000        	ld	a,_insertion_flag
2796  0564 a152          	cp	a,#82
2798  0566 2052          	jp	LC005
2799  0568               L734:
2800                     ; 2393 	    case 3:
2800                     ; 2394 	      // %y03 replaced with string 
2800                     ; 2395               // page_string03[] = "<form style='display: inline' action='http://";
2800                     ; 2396               *pBuffer = (uint8_t)page_string03[i];
2802  0568 7b08          	ld	a,(OFST+0,sp)
2803  056a 5f            	clrw	x
2804  056b 97            	ld	xl,a
2805  056c d61b48        	ld	a,(L74_page_string03,x)
2806  056f 1e09          	ldw	x,(OFST+1,sp)
2807  0571 f7            	ld	(x),a
2808                     ; 2397 	      insertion_flag[0]++;
2810  0572 725c0000      	inc	_insertion_flag
2811                     ; 2398 	      if (insertion_flag[0] == page_string03_len) insertion_flag[0] = 0;
2813  0576 c60000        	ld	a,_insertion_flag
2814  0579 a126          	cp	a,#38
2816  057b 203d          	jp	LC005
2817  057d               L144:
2818                     ; 2400 	    case 4:
2818                     ; 2401 	      // %y04 replaced with first header string 
2818                     ; 2402               *pBuffer = (uint8_t)page_string04[i];
2820  057d 7b08          	ld	a,(OFST+0,sp)
2821  057f 5f            	clrw	x
2822  0580 97            	ld	xl,a
2823  0581 d61b71        	ld	a,(L55_page_string04,x)
2824  0584 1e09          	ldw	x,(OFST+1,sp)
2825  0586 f7            	ld	(x),a
2826                     ; 2403 	      insertion_flag[0]++;
2828  0587 725c0000      	inc	_insertion_flag
2829                     ; 2404 	      if (insertion_flag[0] == page_string04_len) insertion_flag[0] = 0;
2831  058b c60000        	ld	a,_insertion_flag
2832  058e a147          	cp	a,#71
2834  0590 2028          	jp	LC005
2835  0592               L344:
2836                     ; 2406 	    case 5:
2836                     ; 2407 	      // %y05 replaced with second header string 
2836                     ; 2408               *pBuffer = (uint8_t)page_string05[i];
2838  0592 7b08          	ld	a,(OFST+0,sp)
2839  0594 5f            	clrw	x
2840  0595 97            	ld	xl,a
2841  0596 d61bbb        	ld	a,(L36_page_string05,x)
2842  0599 1e09          	ldw	x,(OFST+1,sp)
2843  059b f7            	ld	(x),a
2844                     ; 2409 	      insertion_flag[0]++;
2846  059c 725c0000      	inc	_insertion_flag
2847                     ; 2410 	      if (insertion_flag[0] == page_string05_len) insertion_flag[0] = 0;
2849  05a0 c60000        	ld	a,_insertion_flag
2850  05a3 a1ed          	cp	a,#237
2852  05a5 2013          	jp	LC005
2853  05a7               L544:
2854                     ; 2412 	    case 6:
2854                     ; 2413 	      // %y06 replaced with third header string 
2854                     ; 2414               *pBuffer = (uint8_t)page_string06[i];
2856  05a7 7b08          	ld	a,(OFST+0,sp)
2857  05a9 5f            	clrw	x
2858  05aa 97            	ld	xl,a
2859  05ab d61cab        	ld	a,(L17_page_string06,x)
2860  05ae 1e09          	ldw	x,(OFST+1,sp)
2861  05b0 f7            	ld	(x),a
2862                     ; 2415 	      insertion_flag[0]++;
2864  05b1 725c0000      	inc	_insertion_flag
2865                     ; 2416 	      if (insertion_flag[0] == page_string06_len) insertion_flag[0] = 0;
2867  05b5 c60000        	ld	a,_insertion_flag
2868  05b8 a13b          	cp	a,#59
2871  05ba               LC005:
2872  05ba 2619          	jrne	LC008
2879  05bc 725f0000      	clr	_insertion_flag
2880                     ; 2418 	    default: break;
2882                     ; 2420           pBuffer++;
2883                     ; 2421           nBytes++;
2884  05c0 2013          	jp	LC008
2885  05c2               L735:
2886                     ; 2429         *pBuffer = nByte;
2888  05c2 1e09          	ldw	x,(OFST+1,sp)
2889  05c4 f7            	ld	(x),a
2890                     ; 2430         *ppData = *ppData + 1;
2892  05c5 1e0d          	ldw	x,(OFST+5,sp)
2893  05c7 9093          	ldw	y,x
2894  05c9 fe            	ldw	x,(x)
2895  05ca 5c            	incw	x
2896  05cb 90ff          	ldw	(y),x
2897                     ; 2431         *pDataLeft = *pDataLeft - 1;
2899  05cd 1e0f          	ldw	x,(OFST+7,sp)
2900  05cf 9093          	ldw	y,x
2901  05d1 fe            	ldw	x,(x)
2902  05d2 5a            	decw	x
2903  05d3 90ff          	ldw	(y),x
2904                     ; 2432         pBuffer++;
2906  05d5               LC008:
2908  05d5 1e09          	ldw	x,(OFST+1,sp)
2909                     ; 2433         nBytes++;
2911  05d7               LC007:
2916  05d7 5c            	incw	x
2917  05d8 1f09          	ldw	(OFST+1,sp),x
2923  05da 1e05          	ldw	x,(OFST-3,sp)
2924  05dc 5c            	incw	x
2925  05dd               LC006:
2926  05dd 1f05          	ldw	(OFST-3,sp),x
2928  05df               L325:
2929                     ; 1807   while (nBytes < nMaxBytes) {
2931  05df 1e05          	ldw	x,(OFST-3,sp)
2932  05e1 1311          	cpw	x,(OFST+9,sp)
2933  05e3 2403cc0012    	jrult	L125
2934  05e8               L525:
2935                     ; 2438   return nBytes;
2937  05e8 1e05          	ldw	x,(OFST-3,sp)
2940  05ea 5b0a          	addw	sp,#10
2941  05ec 81            	ret	
2973                     ; 2442 void HttpDInit()
2973                     ; 2443 {
2974                     .text:	section	.text,new
2975  0000               _HttpDInit:
2979                     ; 2445   uip_listen(htons(Port_Httpd));
2981  0000 ce0000        	ldw	x,_Port_Httpd
2982  0003 cd0000        	call	_htons
2984  0006 cd0000        	call	_uip_listen
2986                     ; 2446   current_webpage = WEBPAGE_IOCONTROL;
2988  0009 725f0003      	clr	_current_webpage
2989                     ; 2449   insertion_flag[0] = 0;
2991  000d 725f0000      	clr	_insertion_flag
2992                     ; 2450   insertion_flag[1] = 0;
2994  0011 725f0001      	clr	_insertion_flag+1
2995                     ; 2451   insertion_flag[2] = 0;
2997  0015 725f0002      	clr	_insertion_flag+2
2998                     ; 2454   saved_nstate = STATE_NULL;
3000  0019 357f0044      	mov	_saved_nstate,#127
3001                     ; 2455   saved_parsestate = PARSE_CMD;
3003  001d 725f0043      	clr	_saved_parsestate
3004                     ; 2456   saved_nparseleft = 0;
3006  0021 725f0042      	clr	_saved_nparseleft
3007                     ; 2457   clear_saved_postpartial_all();
3010                     ; 2458 }
3013  0025 cc0000        	jp	_clear_saved_postpartial_all
3206                     	switch	.const
3207  1d09               L622:
3208  1d09 08c4          	dc.w	L7701
3209  1d0b 08cf          	dc.w	L1011
3210  1d0d 08da          	dc.w	L3011
3211  1d0f 08e5          	dc.w	L5011
3212  1d11 08f0          	dc.w	L7011
3213  1d13 08fb          	dc.w	L1111
3214  1d15 0906          	dc.w	L3111
3215  1d17 0911          	dc.w	L5111
3216  1d19 091c          	dc.w	L7111
3217  1d1b 0927          	dc.w	L1211
3218  1d1d 0932          	dc.w	L3211
3219  1d1f 093d          	dc.w	L5211
3220  1d21 0948          	dc.w	L7211
3221  1d23 0953          	dc.w	L1311
3222  1d25 095e          	dc.w	L3311
3223  1d27 0969          	dc.w	L5311
3224                     ; 2461 void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
3224                     ; 2462 {
3225                     .text:	section	.text,new
3226  0000               _HttpDCall:
3228  0000 89            	pushw	x
3229  0001 5204          	subw	sp,#4
3230       00000004      OFST:	set	4
3233                     ; 2466   i = 0;
3235  0003 0f04          	clr	(OFST+0,sp)
3237                     ; 2468   if (uip_connected()) {
3239  0005 720d000067    	btjf	_uip_flags,#6,L5521
3240                     ; 2470     if (current_webpage == WEBPAGE_IOCONTROL) {
3242  000a c60003        	ld	a,_current_webpage
3243  000d 260e          	jrne	L7521
3244                     ; 2471       pSocket->pData = g_HtmlPageIOControl;
3246  000f 1e0b          	ldw	x,(OFST+7,sp)
3247  0011 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
3248  0015 ef01          	ldw	(1,x),y
3249                     ; 2472       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
3251  0017 90ae0c06      	ldw	y,#3078
3253  001b 2046          	jp	LC013
3254  001d               L7521:
3255                     ; 2476     else if (current_webpage == WEBPAGE_CONFIGURATION) {
3257  001d a101          	cp	a,#1
3258  001f 260e          	jrne	L3621
3259                     ; 2477       pSocket->pData = g_HtmlPageConfiguration;
3261  0021 1e0b          	ldw	x,(OFST+7,sp)
3262  0023 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
3263  0027 ef01          	ldw	(1,x),y
3264                     ; 2478       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
3266  0029 90ae0c5c      	ldw	y,#3164
3268  002d 2034          	jp	LC013
3269  002f               L3621:
3270                     ; 2493     else if (current_webpage == WEBPAGE_STATS) {
3272  002f a105          	cp	a,#5
3273  0031 260e          	jrne	L7621
3274                     ; 2494       pSocket->pData = g_HtmlPageStats;
3276  0033 1e0b          	ldw	x,(OFST+7,sp)
3277  0035 90ae186c      	ldw	y,#L71_g_HtmlPageStats
3278  0039 ef01          	ldw	(1,x),y
3279                     ; 2495       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
3281  003b 90ae0175      	ldw	y,#373
3283  003f 2022          	jp	LC013
3284  0041               L7621:
3285                     ; 2499     else if (current_webpage == WEBPAGE_RSTATE) {
3287  0041 a106          	cp	a,#6
3288  0043 260e          	jrne	L3721
3289                     ; 2500       pSocket->pData = g_HtmlPageRstate;
3291  0045 1e0b          	ldw	x,(OFST+7,sp)
3292  0047 90ae19e2      	ldw	y,#L12_g_HtmlPageRstate
3293  004b ef01          	ldw	(1,x),y
3294                     ; 2501       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
3296  004d 90ae0086      	ldw	y,#134
3298  0051 2010          	jp	LC013
3299  0053               L3721:
3300                     ; 2504     else if (current_webpage == WEBPAGE_SSTATE) {
3302  0053 a107          	cp	a,#7
3303  0055 260e          	jrne	L1621
3304                     ; 2505       pSocket->pData = g_HtmlPageSstate;
3306  0057 1e0b          	ldw	x,(OFST+7,sp)
3307  0059 90ae1a69      	ldw	y,#L32_g_HtmlPageSstate
3308  005d ef01          	ldw	(1,x),y
3309                     ; 2506       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
3311  005f 90ae0004      	ldw	y,#4
3312  0063               LC013:
3313  0063 ef03          	ldw	(3,x),y
3314  0065               L1621:
3315                     ; 2509     pSocket->nState = STATE_CONNECTED;
3317  0065 1e0b          	ldw	x,(OFST+7,sp)
3318                     ; 2510     pSocket->nPrevBytes = 0xFFFF;
3320  0067 90aeffff      	ldw	y,#65535
3321  006b 7f            	clr	(x)
3322  006c ef0b          	ldw	(11,x),y
3324  006e cc0141        	jra	L452
3325  0071               L5521:
3326                     ; 2519   else if (uip_newdata() || uip_acked()) {
3328  0071 7202000008    	btjt	_uip_flags,#1,L5031
3330  0076 7200000003cc  	btjf	_uip_flags,#0,L3031
3331  007e               L5031:
3332                     ; 2520     if (uip_acked()) {
3334  007e 7201000003cc  	btjt	_uip_flags,#0,L5611
3335                     ; 2523       goto senddata;
3337                     ; 2593     if (saved_nstate != STATE_NULL) {
3339  0086 c60044        	ld	a,_saved_nstate
3340  0089 a17f          	cp	a,#127
3341  008b 2603cc010d    	jreq	L7331
3342                     ; 2599       pSocket->nState = saved_nstate;
3344  0090 1e0b          	ldw	x,(OFST+7,sp)
3345  0092 f7            	ld	(x),a
3346                     ; 2606       pSocket->ParseState = saved_parsestate;
3348  0093 c60043        	ld	a,_saved_parsestate
3349  0096 e70a          	ld	(10,x),a
3350                     ; 2610       pSocket->nParseLeft = saved_nparseleft;
3352  0098 c60042        	ld	a,_saved_nparseleft
3353  009b e706          	ld	(6,x),a
3354                     ; 2612       pSocket->nNewlines = saved_newlines;
3356  009d c60011        	ld	a,_saved_newlines
3357  00a0 e705          	ld	(5,x),a
3358                     ; 2624       for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i];
3360  00a2 4f            	clr	a
3361  00a3 6b04          	ld	(OFST+0,sp),a
3363  00a5               L3131:
3366  00a5 5f            	clrw	x
3367  00a6 97            	ld	xl,a
3368  00a7 d6002a        	ld	a,(_saved_postpartial,x)
3369  00aa d70012        	ld	(_saved_postpartial_previous,x),a
3372  00ad 0c04          	inc	(OFST+0,sp)
3376  00af 7b04          	ld	a,(OFST+0,sp)
3377  00b1 a118          	cp	a,#24
3378  00b3 25f0          	jrult	L3131
3379                     ; 2629       if (saved_nstate == STATE_PARSEPOST) {
3381  00b5 c60044        	ld	a,_saved_nstate
3382  00b8 a10a          	cp	a,#10
3383  00ba 2651          	jrne	L7331
3384                     ; 2630         if (saved_parsestate == PARSE_CMD) {
3386  00bc c60043        	ld	a,_saved_parsestate
3387  00bf 274c          	jreq	L7331
3389                     ; 2633         else if (saved_parsestate == PARSE_NUM10) {
3391  00c1 a101          	cp	a,#1
3392  00c3 2609          	jrne	L7231
3393                     ; 2635 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3395  00c5 1e0b          	ldw	x,(OFST+7,sp)
3396  00c7 c60012        	ld	a,_saved_postpartial_previous
3397  00ca e708          	ld	(8,x),a
3399  00cc 203f          	jra	L7331
3400  00ce               L7231:
3401                     ; 2637         else if (saved_parsestate == PARSE_NUM1) {
3403  00ce a102          	cp	a,#2
3404  00d0 2615          	jrne	L3331
3405                     ; 2639 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3407  00d2 1e0b          	ldw	x,(OFST+7,sp)
3408  00d4 c60012        	ld	a,_saved_postpartial_previous
3409  00d7 e708          	ld	(8,x),a
3410                     ; 2640           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3412  00d9 c60013        	ld	a,_saved_postpartial_previous+1
3413  00dc 97            	ld	xl,a
3414  00dd a60a          	ld	a,#10
3415  00df 42            	mul	x,a
3416  00e0 9f            	ld	a,xl
3417  00e1 a0e0          	sub	a,#224
3418  00e3 1e0b          	ldw	x,(OFST+7,sp)
3420  00e5 2024          	jp	LC014
3421  00e7               L3331:
3422                     ; 2642         else if (saved_parsestate == PARSE_EQUAL || saved_parsestate == PARSE_VAL) {
3424  00e7 a103          	cp	a,#3
3425  00e9 2704          	jreq	L1431
3427  00eb a104          	cp	a,#4
3428  00ed 261e          	jrne	L7331
3429  00ef               L1431:
3430                     ; 2644 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3432  00ef 1e0b          	ldw	x,(OFST+7,sp)
3433  00f1 c60012        	ld	a,_saved_postpartial_previous
3434  00f4 e708          	ld	(8,x),a
3435                     ; 2645           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3437  00f6 c60013        	ld	a,_saved_postpartial_previous+1
3438  00f9 97            	ld	xl,a
3439  00fa a60a          	ld	a,#10
3440  00fc 42            	mul	x,a
3441  00fd 9f            	ld	a,xl
3442  00fe 1e0b          	ldw	x,(OFST+7,sp)
3443  0100 a0e0          	sub	a,#224
3444  0102 e709          	ld	(9,x),a
3445                     ; 2646           pSocket->ParseNum += (uint8_t)(saved_postpartial_previous[2] - '0');
3447  0104 c60014        	ld	a,_saved_postpartial_previous+2
3448  0107 a030          	sub	a,#48
3449  0109 eb09          	add	a,(9,x)
3450  010b               LC014:
3451  010b e709          	ld	(9,x),a
3453  010d               L7331:
3454                     ; 2648 	else if (saved_parsestate == PARSE_DELIM) {
3456                     ; 2668     if (pSocket->nState == STATE_CONNECTED) {
3458  010d 1e0b          	ldw	x,(OFST+7,sp)
3459  010f f6            	ld	a,(x)
3460  0110 2627          	jrne	L7431
3461                     ; 2669       if (nBytes == 0) return;
3463  0112 1e09          	ldw	x,(OFST+5,sp)
3464  0114 272b          	jreq	L452
3467                     ; 2670       if (*pBuffer == 'G') {
3469  0116 1e05          	ldw	x,(OFST+1,sp)
3470  0118 f6            	ld	a,(x)
3471  0119 a147          	cp	a,#71
3472  011b 2606          	jrne	L3531
3473                     ; 2671         pSocket->nState = STATE_GET_G;
3475  011d 1e0b          	ldw	x,(OFST+7,sp)
3476  011f a601          	ld	a,#1
3478  0121 2008          	jp	LC015
3479  0123               L3531:
3480                     ; 2673       else if (*pBuffer == 'P') {
3482  0123 a150          	cp	a,#80
3483  0125 2605          	jrne	L5531
3484                     ; 2674         pSocket->nState = STATE_POST_P;
3486  0127 1e0b          	ldw	x,(OFST+7,sp)
3487  0129 a604          	ld	a,#4
3488  012b               LC015:
3489  012b f7            	ld	(x),a
3490  012c               L5531:
3491                     ; 2676       nBytes--;
3493  012c 1e09          	ldw	x,(OFST+5,sp)
3494  012e 5a            	decw	x
3495  012f 1f09          	ldw	(OFST+5,sp),x
3496                     ; 2677       pBuffer++;
3498  0131 1e05          	ldw	x,(OFST+1,sp)
3499  0133 5c            	incw	x
3500  0134 1f05          	ldw	(OFST+1,sp),x
3501  0136 1e0b          	ldw	x,(OFST+7,sp)
3502  0138 f6            	ld	a,(x)
3503  0139               L7431:
3504                     ; 2680     if (pSocket->nState == STATE_GET_G) {
3506  0139 a101          	cp	a,#1
3507  013b 2620          	jrne	L1631
3508                     ; 2681       if (nBytes == 0) return;
3510  013d 1e09          	ldw	x,(OFST+5,sp)
3511  013f 2603          	jrne	L3631
3513  0141               L452:
3516  0141 5b06          	addw	sp,#6
3517  0143 81            	ret	
3518  0144               L3631:
3519                     ; 2682       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
3521  0144 1e05          	ldw	x,(OFST+1,sp)
3522  0146 f6            	ld	a,(x)
3523  0147 a145          	cp	a,#69
3524  0149 2605          	jrne	L5631
3527  014b 1e0b          	ldw	x,(OFST+7,sp)
3528  014d a602          	ld	a,#2
3529  014f f7            	ld	(x),a
3530  0150               L5631:
3531                     ; 2683       nBytes--;
3533  0150 1e09          	ldw	x,(OFST+5,sp)
3534  0152 5a            	decw	x
3535  0153 1f09          	ldw	(OFST+5,sp),x
3536                     ; 2684       pBuffer++;
3538  0155 1e05          	ldw	x,(OFST+1,sp)
3539  0157 5c            	incw	x
3540  0158 1f05          	ldw	(OFST+1,sp),x
3541  015a 1e0b          	ldw	x,(OFST+7,sp)
3542  015c f6            	ld	a,(x)
3543  015d               L1631:
3544                     ; 2687     if (pSocket->nState == STATE_GET_GE) {
3546  015d a102          	cp	a,#2
3547  015f 261d          	jrne	L7631
3548                     ; 2688       if (nBytes == 0) return;
3550  0161 1e09          	ldw	x,(OFST+5,sp)
3551  0163 27dc          	jreq	L452
3554                     ; 2689       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
3556  0165 1e05          	ldw	x,(OFST+1,sp)
3557  0167 f6            	ld	a,(x)
3558  0168 a154          	cp	a,#84
3559  016a 2605          	jrne	L3731
3562  016c 1e0b          	ldw	x,(OFST+7,sp)
3563  016e a603          	ld	a,#3
3564  0170 f7            	ld	(x),a
3565  0171               L3731:
3566                     ; 2690       nBytes--;
3568  0171 1e09          	ldw	x,(OFST+5,sp)
3569  0173 5a            	decw	x
3570  0174 1f09          	ldw	(OFST+5,sp),x
3571                     ; 2691       pBuffer++;
3573  0176 1e05          	ldw	x,(OFST+1,sp)
3574  0178 5c            	incw	x
3575  0179 1f05          	ldw	(OFST+1,sp),x
3576  017b 1e0b          	ldw	x,(OFST+7,sp)
3577  017d f6            	ld	a,(x)
3578  017e               L7631:
3579                     ; 2694     if (pSocket->nState == STATE_GET_GET) {
3581  017e a103          	cp	a,#3
3582  0180 261d          	jrne	L5731
3583                     ; 2695       if (nBytes == 0) return;
3585  0182 1e09          	ldw	x,(OFST+5,sp)
3586  0184 27bb          	jreq	L452
3589                     ; 2696       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
3591  0186 1e05          	ldw	x,(OFST+1,sp)
3592  0188 f6            	ld	a,(x)
3593  0189 a120          	cp	a,#32
3594  018b 2605          	jrne	L1041
3597  018d 1e0b          	ldw	x,(OFST+7,sp)
3598  018f a608          	ld	a,#8
3599  0191 f7            	ld	(x),a
3600  0192               L1041:
3601                     ; 2697       nBytes--;
3603  0192 1e09          	ldw	x,(OFST+5,sp)
3604  0194 5a            	decw	x
3605  0195 1f09          	ldw	(OFST+5,sp),x
3606                     ; 2698       pBuffer++;
3608  0197 1e05          	ldw	x,(OFST+1,sp)
3609  0199 5c            	incw	x
3610  019a 1f05          	ldw	(OFST+1,sp),x
3611  019c 1e0b          	ldw	x,(OFST+7,sp)
3612  019e f6            	ld	a,(x)
3613  019f               L5731:
3614                     ; 2701     if (pSocket->nState == STATE_POST_P) {
3616  019f a104          	cp	a,#4
3617  01a1 261d          	jrne	L3041
3618                     ; 2702       if (nBytes == 0) return;
3620  01a3 1e09          	ldw	x,(OFST+5,sp)
3621  01a5 279a          	jreq	L452
3624                     ; 2703       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
3626  01a7 1e05          	ldw	x,(OFST+1,sp)
3627  01a9 f6            	ld	a,(x)
3628  01aa a14f          	cp	a,#79
3629  01ac 2605          	jrne	L7041
3632  01ae 1e0b          	ldw	x,(OFST+7,sp)
3633  01b0 a605          	ld	a,#5
3634  01b2 f7            	ld	(x),a
3635  01b3               L7041:
3636                     ; 2704       nBytes--;
3638  01b3 1e09          	ldw	x,(OFST+5,sp)
3639  01b5 5a            	decw	x
3640  01b6 1f09          	ldw	(OFST+5,sp),x
3641                     ; 2705       pBuffer++;
3643  01b8 1e05          	ldw	x,(OFST+1,sp)
3644  01ba 5c            	incw	x
3645  01bb 1f05          	ldw	(OFST+1,sp),x
3646  01bd 1e0b          	ldw	x,(OFST+7,sp)
3647  01bf f6            	ld	a,(x)
3648  01c0               L3041:
3649                     ; 2708     if (pSocket->nState == STATE_POST_PO) {
3651  01c0 a105          	cp	a,#5
3652  01c2 2620          	jrne	L1141
3653                     ; 2709       if (nBytes == 0) return;
3655  01c4 1e09          	ldw	x,(OFST+5,sp)
3656  01c6 2603cc0141    	jreq	L452
3659                     ; 2710       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
3661  01cb 1e05          	ldw	x,(OFST+1,sp)
3662  01cd f6            	ld	a,(x)
3663  01ce a153          	cp	a,#83
3664  01d0 2605          	jrne	L5141
3667  01d2 1e0b          	ldw	x,(OFST+7,sp)
3668  01d4 a606          	ld	a,#6
3669  01d6 f7            	ld	(x),a
3670  01d7               L5141:
3671                     ; 2711       nBytes--;
3673  01d7 1e09          	ldw	x,(OFST+5,sp)
3674  01d9 5a            	decw	x
3675  01da 1f09          	ldw	(OFST+5,sp),x
3676                     ; 2712       pBuffer++;
3678  01dc 1e05          	ldw	x,(OFST+1,sp)
3679  01de 5c            	incw	x
3680  01df 1f05          	ldw	(OFST+1,sp),x
3681  01e1 1e0b          	ldw	x,(OFST+7,sp)
3682  01e3 f6            	ld	a,(x)
3683  01e4               L1141:
3684                     ; 2715     if (pSocket->nState == STATE_POST_POS) {
3686  01e4 a106          	cp	a,#6
3687  01e6 261d          	jrne	L7141
3688                     ; 2716       if (nBytes == 0) return;
3690  01e8 1e09          	ldw	x,(OFST+5,sp)
3691  01ea 27dc          	jreq	L452
3694                     ; 2717       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
3696  01ec 1e05          	ldw	x,(OFST+1,sp)
3697  01ee f6            	ld	a,(x)
3698  01ef a154          	cp	a,#84
3699  01f1 2605          	jrne	L3241
3702  01f3 1e0b          	ldw	x,(OFST+7,sp)
3703  01f5 a607          	ld	a,#7
3704  01f7 f7            	ld	(x),a
3705  01f8               L3241:
3706                     ; 2718       nBytes--;
3708  01f8 1e09          	ldw	x,(OFST+5,sp)
3709  01fa 5a            	decw	x
3710  01fb 1f09          	ldw	(OFST+5,sp),x
3711                     ; 2719       pBuffer++;
3713  01fd 1e05          	ldw	x,(OFST+1,sp)
3714  01ff 5c            	incw	x
3715  0200 1f05          	ldw	(OFST+1,sp),x
3716  0202 1e0b          	ldw	x,(OFST+7,sp)
3717  0204 f6            	ld	a,(x)
3718  0205               L7141:
3719                     ; 2722     if (pSocket->nState == STATE_POST_POST) {
3721  0205 a107          	cp	a,#7
3722  0207 261d          	jrne	L5241
3723                     ; 2723       if (nBytes == 0) return;
3725  0209 1e09          	ldw	x,(OFST+5,sp)
3726  020b 27bb          	jreq	L452
3729                     ; 2724       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
3731  020d 1e05          	ldw	x,(OFST+1,sp)
3732  020f f6            	ld	a,(x)
3733  0210 a120          	cp	a,#32
3734  0212 2605          	jrne	L1341
3737  0214 1e0b          	ldw	x,(OFST+7,sp)
3738  0216 a609          	ld	a,#9
3739  0218 f7            	ld	(x),a
3740  0219               L1341:
3741                     ; 2725       nBytes--;
3743  0219 1e09          	ldw	x,(OFST+5,sp)
3744  021b 5a            	decw	x
3745  021c 1f09          	ldw	(OFST+5,sp),x
3746                     ; 2726       pBuffer++;
3748  021e 1e05          	ldw	x,(OFST+1,sp)
3749  0220 5c            	incw	x
3750  0221 1f05          	ldw	(OFST+1,sp),x
3751  0223 1e0b          	ldw	x,(OFST+7,sp)
3752  0225 f6            	ld	a,(x)
3753  0226               L5241:
3754                     ; 2729     if (pSocket->nState == STATE_GOTPOST) {
3756  0226 a109          	cp	a,#9
3757  0228 2703cc02af    	jrne	L3341
3758                     ; 2731       saved_nstate = STATE_GOTPOST;
3760  022d 35090044      	mov	_saved_nstate,#9
3761                     ; 2732       if (nBytes == 0) {
3763  0231 1e09          	ldw	x,(OFST+5,sp)
3764  0233 2676          	jrne	L1441
3765                     ; 2735 	saved_newlines = pSocket->nNewlines;
3767  0235 1e0b          	ldw	x,(OFST+7,sp)
3768  0237 e605          	ld	a,(5,x)
3769  0239 c70011        	ld	_saved_newlines,a
3770                     ; 2736         return;
3772  023c cc0141        	jra	L452
3773  023f               L7341:
3774                     ; 2744 	if (saved_newlines == 2) {
3776  023f c60011        	ld	a,_saved_newlines
3777  0242 a102          	cp	a,#2
3778  0244 272b          	jreq	L7441
3780                     ; 2749           if (*pBuffer == '\n') pSocket->nNewlines++;
3782  0246 1e05          	ldw	x,(OFST+1,sp)
3783  0248 f6            	ld	a,(x)
3784  0249 a10a          	cp	a,#10
3785  024b 2606          	jrne	L1541
3788  024d 1e0b          	ldw	x,(OFST+7,sp)
3789  024f 6c05          	inc	(5,x)
3791  0251 2008          	jra	L3541
3792  0253               L1541:
3793                     ; 2750           else if (*pBuffer == '\r') { }
3795  0253 a10d          	cp	a,#13
3796  0255 2704          	jreq	L3541
3798                     ; 2751           else pSocket->nNewlines = 0;
3800  0257 1e0b          	ldw	x,(OFST+7,sp)
3801  0259 6f05          	clr	(5,x)
3802  025b               L3541:
3803                     ; 2752           pBuffer++;
3805  025b 1e05          	ldw	x,(OFST+1,sp)
3806  025d 5c            	incw	x
3807  025e 1f05          	ldw	(OFST+1,sp),x
3808                     ; 2753           nBytes--;
3810  0260 1e09          	ldw	x,(OFST+5,sp)
3811  0262 5a            	decw	x
3812  0263 1f09          	ldw	(OFST+5,sp),x
3813                     ; 2754           if (nBytes == 0) {
3815  0265 260a          	jrne	L7441
3816                     ; 2757             saved_newlines = pSocket->nNewlines;
3818  0267 1e0b          	ldw	x,(OFST+7,sp)
3819  0269 e605          	ld	a,(5,x)
3820  026b c70011        	ld	_saved_newlines,a
3821                     ; 2758             return;
3823  026e cc0141        	jra	L452
3824  0271               L7441:
3825                     ; 2766         if (pSocket->nNewlines == 2) {
3827  0271 1e0b          	ldw	x,(OFST+7,sp)
3828  0273 e605          	ld	a,(5,x)
3829  0275 a102          	cp	a,#2
3830  0277 2632          	jrne	L1441
3831                     ; 2769           if (current_webpage == WEBPAGE_IOCONTROL) {
3833  0279 c60003        	ld	a,_current_webpage
3834  027c 2609          	jrne	L5641
3835                     ; 2770 	    pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
3837  027e a635          	ld	a,#53
3838  0280 e706          	ld	(6,x),a
3839                     ; 2771 	    pSocket->nParseLeftAddl = PARSEBYTES_IOCONTROL_ADDL;
3841  0282 6f07          	clr	(7,x)
3842  0284 c60003        	ld	a,_current_webpage
3843  0287               L5641:
3844                     ; 2773           if (current_webpage == WEBPAGE_CONFIGURATION) {
3846  0287 4a            	dec	a
3847  0288 2608          	jrne	L7641
3848                     ; 2774 	    pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
3850  028a a6ec          	ld	a,#236
3851  028c e706          	ld	(6,x),a
3852                     ; 2775 	    pSocket->nParseLeftAddl = PARSEBYTES_CONFIGURATION_ADDL;
3854  028e a618          	ld	a,#24
3855  0290 e707          	ld	(7,x),a
3856  0292               L7641:
3857                     ; 2777           pSocket->ParseState = saved_parsestate = PARSE_CMD;
3859  0292 725f0043      	clr	_saved_parsestate
3860  0296 6f0a          	clr	(10,x)
3861                     ; 2778 	  saved_nparseleft = pSocket->nParseLeft;
3863  0298 e606          	ld	a,(6,x)
3864  029a c70042        	ld	_saved_nparseleft,a
3865                     ; 2780           pSocket->nState = STATE_PARSEPOST;
3867  029d a60a          	ld	a,#10
3868  029f f7            	ld	(x),a
3869                     ; 2781 	  saved_nstate = STATE_PARSEPOST;
3871  02a0 350a0044      	mov	_saved_nstate,#10
3872                     ; 2782 	  if (nBytes == 0) {
3874  02a4 1e09          	ldw	x,(OFST+5,sp)
3875  02a6 2607          	jrne	L3341
3876                     ; 2785 	    return;
3878  02a8 cc0141        	jra	L452
3879  02ab               L1441:
3880                     ; 2739       while (nBytes != 0) {
3882  02ab 1e09          	ldw	x,(OFST+5,sp)
3883  02ad 2690          	jrne	L7341
3884  02af               L3341:
3885                     ; 2792     if (pSocket->nState == STATE_GOTGET) {
3887  02af 1e0b          	ldw	x,(OFST+7,sp)
3888  02b1 f6            	ld	a,(x)
3889  02b2 a108          	cp	a,#8
3890  02b4 2609          	jrne	L3741
3891                     ; 2796       pSocket->nParseLeft = 6;
3893  02b6 a606          	ld	a,#6
3894  02b8 e706          	ld	(6,x),a
3895                     ; 2797       pSocket->ParseState = PARSE_SLASH1;
3897  02ba e70a          	ld	(10,x),a
3898                     ; 2799       pSocket->nState = STATE_PARSEGET;
3900  02bc a60d          	ld	a,#13
3901  02be f7            	ld	(x),a
3902  02bf               L3741:
3903                     ; 2802     if (pSocket->nState == STATE_PARSEPOST) {
3905  02bf a10a          	cp	a,#10
3906  02c1 2703cc079f    	jrne	L5741
3907  02c6               L7741:
3908                     ; 2816         if (pSocket->ParseState == PARSE_CMD) {
3910  02c6 1e0b          	ldw	x,(OFST+7,sp)
3911  02c8 e60a          	ld	a,(10,x)
3912  02ca 2664          	jrne	L3051
3913                     ; 2817           pSocket->ParseCmd = *pBuffer;
3915  02cc 1e05          	ldw	x,(OFST+1,sp)
3916  02ce f6            	ld	a,(x)
3917  02cf 1e0b          	ldw	x,(OFST+7,sp)
3918  02d1 e708          	ld	(8,x),a
3919                     ; 2818 	  saved_postpartial[0] = *pBuffer;
3921  02d3 1e05          	ldw	x,(OFST+1,sp)
3922  02d5 f6            	ld	a,(x)
3923  02d6 c7002a        	ld	_saved_postpartial,a
3924                     ; 2819           pSocket->ParseState = saved_parsestate = PARSE_NUM10;
3926  02d9 a601          	ld	a,#1
3927  02db c70043        	ld	_saved_parsestate,a
3928  02de 1e0b          	ldw	x,(OFST+7,sp)
3929  02e0 e70a          	ld	(10,x),a
3930                     ; 2820 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3932  02e2 e606          	ld	a,(6,x)
3933  02e4 2704          	jreq	L5051
3934                     ; 2821 	    pSocket->nParseLeft--;
3936  02e6 6a06          	dec	(6,x)
3938  02e8 2004          	jra	L7051
3939  02ea               L5051:
3940                     ; 2825 	    pSocket->ParseState = PARSE_DELIM;
3942  02ea a605          	ld	a,#5
3943  02ec e70a          	ld	(10,x),a
3944  02ee               L7051:
3945                     ; 2827 	  saved_nparseleft = pSocket->nParseLeft;
3947  02ee e606          	ld	a,(6,x)
3948  02f0 c70042        	ld	_saved_nparseleft,a
3949                     ; 2828           pBuffer++;
3951  02f3 1e05          	ldw	x,(OFST+1,sp)
3952  02f5 5c            	incw	x
3953  02f6 1f05          	ldw	(OFST+1,sp),x
3954                     ; 2829 	  nBytes --;
3956  02f8 1e09          	ldw	x,(OFST+5,sp)
3957  02fa 5a            	decw	x
3958  02fb 1f09          	ldw	(OFST+5,sp),x
3959                     ; 2831 	  if (pSocket->ParseCmd == 'o' ||
3959                     ; 2832 	      pSocket->ParseCmd == 'a' ||
3959                     ; 2833 	      pSocket->ParseCmd == 'b' ||
3959                     ; 2834 	      pSocket->ParseCmd == 'c' ||
3959                     ; 2835 	      pSocket->ParseCmd == 'd' ||
3959                     ; 2836 	      pSocket->ParseCmd == 'g' ||
3959                     ; 2837 	      pSocket->ParseCmd == 'l' ||
3959                     ; 2838 	      pSocket->ParseCmd == 'm' ||
3959                     ; 2839 	      pSocket->ParseCmd == 'z') { }
3961  02fd 1e0b          	ldw	x,(OFST+7,sp)
3962  02ff e608          	ld	a,(8,x)
3963  0301 a16f          	cp	a,#111
3964  0303 2724          	jreq	L3351
3966  0305 a161          	cp	a,#97
3967  0307 2720          	jreq	L3351
3969  0309 a162          	cp	a,#98
3970  030b 271c          	jreq	L3351
3972  030d a163          	cp	a,#99
3973  030f 2718          	jreq	L3351
3975  0311 a164          	cp	a,#100
3976  0313 2714          	jreq	L3351
3978  0315 a167          	cp	a,#103
3979  0317 2710          	jreq	L3351
3981  0319 a16c          	cp	a,#108
3982  031b 270c          	jreq	L3351
3984  031d a16d          	cp	a,#109
3985  031f 2708          	jreq	L3351
3987  0321 a17a          	cp	a,#122
3988  0323 2704          	jreq	L3351
3989                     ; 2842 	    pSocket->ParseState = PARSE_DELIM;
3991  0325 a605          	ld	a,#5
3992  0327 e70a          	ld	(10,x),a
3993  0329               L3351:
3994                     ; 2844 	  if (nBytes == 0) { // Hit end of fragment. Break out of while()
3996  0329 1e09          	ldw	x,(OFST+5,sp)
3997  032b 2699          	jrne	L7741
3998                     ; 2846 	    break;
4000  032d cc0747        	jra	L1051
4001  0330               L3051:
4002                     ; 2850         else if (pSocket->ParseState == PARSE_NUM10) {
4004  0330 a101          	cp	a,#1
4005  0332 2640          	jrne	L1451
4006                     ; 2851           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
4008  0334 1e05          	ldw	x,(OFST+1,sp)
4009  0336 f6            	ld	a,(x)
4010  0337 97            	ld	xl,a
4011  0338 a60a          	ld	a,#10
4012  033a 42            	mul	x,a
4013  033b 9f            	ld	a,xl
4014  033c 1e0b          	ldw	x,(OFST+7,sp)
4015  033e a0e0          	sub	a,#224
4016  0340 e709          	ld	(9,x),a
4017                     ; 2852 	  saved_postpartial[1] = *pBuffer;
4019  0342 1e05          	ldw	x,(OFST+1,sp)
4020  0344 f6            	ld	a,(x)
4021  0345 c7002b        	ld	_saved_postpartial+1,a
4022                     ; 2853           pSocket->ParseState = saved_parsestate = PARSE_NUM1;
4024  0348 a602          	ld	a,#2
4025  034a c70043        	ld	_saved_parsestate,a
4026  034d 1e0b          	ldw	x,(OFST+7,sp)
4027  034f e70a          	ld	(10,x),a
4028                     ; 2854 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
4030  0351 e606          	ld	a,(6,x)
4031  0353 2704          	jreq	L3451
4032                     ; 2855 	    pSocket->nParseLeft--;
4034  0355 6a06          	dec	(6,x)
4036  0357 2004          	jra	L5451
4037  0359               L3451:
4038                     ; 2859 	    pSocket->ParseState = PARSE_DELIM;
4040  0359 a605          	ld	a,#5
4041  035b e70a          	ld	(10,x),a
4042  035d               L5451:
4043                     ; 2861 	  saved_nparseleft = pSocket->nParseLeft;
4045  035d e606          	ld	a,(6,x)
4046  035f c70042        	ld	_saved_nparseleft,a
4047                     ; 2862           pBuffer++;
4049  0362 1e05          	ldw	x,(OFST+1,sp)
4050  0364 5c            	incw	x
4051  0365 1f05          	ldw	(OFST+1,sp),x
4052                     ; 2863 	  nBytes--;
4054  0367 1e09          	ldw	x,(OFST+5,sp)
4055  0369 5a            	decw	x
4056  036a 1f09          	ldw	(OFST+5,sp),x
4057                     ; 2864 	  if (nBytes == 0) {
4059  036c 2703cc02c6    	jrne	L7741
4060                     ; 2866 	    break;
4062  0371 cc0747        	jra	L1051
4063  0374               L1451:
4064                     ; 2870         else if (pSocket->ParseState == PARSE_NUM1) {
4066  0374 a102          	cp	a,#2
4067  0376 2638          	jrne	L3551
4068                     ; 2871           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
4070  0378 1605          	ldw	y,(OFST+1,sp)
4071  037a 90f6          	ld	a,(y)
4072  037c a030          	sub	a,#48
4073  037e eb09          	add	a,(9,x)
4074  0380 e709          	ld	(9,x),a
4075                     ; 2872 	  saved_postpartial[2] = *pBuffer;
4077  0382 93            	ldw	x,y
4078  0383 f6            	ld	a,(x)
4079  0384 c7002c        	ld	_saved_postpartial+2,a
4080                     ; 2873           pSocket->ParseState = saved_parsestate = PARSE_EQUAL;
4082  0387 a603          	ld	a,#3
4083  0389 c70043        	ld	_saved_parsestate,a
4084  038c 1e0b          	ldw	x,(OFST+7,sp)
4085  038e e70a          	ld	(10,x),a
4086                     ; 2874 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
4088  0390 e606          	ld	a,(6,x)
4089  0392 2704          	jreq	L5551
4090                     ; 2875 	    pSocket->nParseLeft--;
4092  0394 6a06          	dec	(6,x)
4094  0396 2004          	jra	L7551
4095  0398               L5551:
4096                     ; 2879 	    pSocket->ParseState = PARSE_DELIM;
4098  0398 a605          	ld	a,#5
4099  039a e70a          	ld	(10,x),a
4100  039c               L7551:
4101                     ; 2881 	  saved_nparseleft = pSocket->nParseLeft;
4103  039c e606          	ld	a,(6,x)
4104  039e c70042        	ld	_saved_nparseleft,a
4105                     ; 2882           pBuffer++;
4107  03a1 1e05          	ldw	x,(OFST+1,sp)
4108  03a3 5c            	incw	x
4109  03a4 1f05          	ldw	(OFST+1,sp),x
4110                     ; 2883 	  nBytes--;
4112  03a6 1e09          	ldw	x,(OFST+5,sp)
4113  03a8 5a            	decw	x
4114  03a9 1f09          	ldw	(OFST+5,sp),x
4115                     ; 2884 	  if (nBytes == 0) {
4117  03ab 26c1          	jrne	L7741
4118                     ; 2886 	    break;
4120  03ad cc0747        	jra	L1051
4121  03b0               L3551:
4122                     ; 2890         else if (pSocket->ParseState == PARSE_EQUAL) {
4124  03b0 a103          	cp	a,#3
4125  03b2 262f          	jrne	L5651
4126                     ; 2891           pSocket->ParseState = saved_parsestate = PARSE_VAL;
4128  03b4 a604          	ld	a,#4
4129  03b6 c70043        	ld	_saved_parsestate,a
4130  03b9 e70a          	ld	(10,x),a
4131                     ; 2892 	  saved_postpartial[3] = *pBuffer;
4133  03bb 1e05          	ldw	x,(OFST+1,sp)
4134  03bd f6            	ld	a,(x)
4135  03be c7002d        	ld	_saved_postpartial+3,a
4136                     ; 2893 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
4138  03c1 1e0b          	ldw	x,(OFST+7,sp)
4139  03c3 e606          	ld	a,(6,x)
4140  03c5 2704          	jreq	L7651
4141                     ; 2894 	    pSocket->nParseLeft--;
4143  03c7 6a06          	dec	(6,x)
4145  03c9 2004          	jra	L1751
4146  03cb               L7651:
4147                     ; 2898 	    pSocket->ParseState = PARSE_DELIM;
4149  03cb a605          	ld	a,#5
4150  03cd e70a          	ld	(10,x),a
4151  03cf               L1751:
4152                     ; 2900 	  saved_nparseleft = pSocket->nParseLeft;
4154  03cf e606          	ld	a,(6,x)
4155  03d1 c70042        	ld	_saved_nparseleft,a
4156                     ; 2901           pBuffer++;
4158  03d4 1e05          	ldw	x,(OFST+1,sp)
4159  03d6 5c            	incw	x
4160  03d7 1f05          	ldw	(OFST+1,sp),x
4161                     ; 2902 	  nBytes--;
4163  03d9 1e09          	ldw	x,(OFST+5,sp)
4164  03db 5a            	decw	x
4165  03dc 1f09          	ldw	(OFST+5,sp),x
4166                     ; 2903 	  if (nBytes == 0) {
4168  03de 268e          	jrne	L7741
4169                     ; 2905 	    break;
4171  03e0 cc0747        	jra	L1051
4172  03e3               L5651:
4173                     ; 2909         else if (pSocket->ParseState == PARSE_VAL) {
4175  03e3 a104          	cp	a,#4
4176  03e5 2703cc071a    	jrne	L7751
4177                     ; 2922           if (pSocket->ParseCmd == 'o') {
4179  03ea e608          	ld	a,(8,x)
4180  03ec a16f          	cp	a,#111
4181  03ee 2640          	jrne	L1061
4182                     ; 2936               if ((uint8_t)(*pBuffer) == '1') pin_value = 1;
4184  03f0 1e05          	ldw	x,(OFST+1,sp)
4185  03f2 f6            	ld	a,(x)
4186  03f3 a131          	cp	a,#49
4187  03f5 2604          	jrne	L3061
4190  03f7 a601          	ld	a,#1
4192  03f9 2001          	jra	L5061
4193  03fb               L3061:
4194                     ; 2937 	      else pin_value = 0;
4196  03fb 4f            	clr	a
4197  03fc               L5061:
4198  03fc 6b01          	ld	(OFST-3,sp),a
4200                     ; 2938 	      GpioSetPin(pSocket->ParseNum, (uint8_t)pin_value);
4202  03fe 160b          	ldw	y,(OFST+7,sp)
4203  0400 97            	ld	xl,a
4204  0401 90e609        	ld	a,(9,y)
4205  0404 95            	ld	xh,a
4206  0405 cd0000        	call	_GpioSetPin
4208                     ; 2940 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent
4210  0408 1e0b          	ldw	x,(OFST+7,sp)
4211  040a e606          	ld	a,(6,x)
4212  040c 2704          	jreq	L7061
4215  040e 6a06          	dec	(6,x)
4216  0410 e606          	ld	a,(6,x)
4217  0412               L7061:
4218                     ; 2942             saved_nparseleft = pSocket->nParseLeft;
4220  0412 c70042        	ld	_saved_nparseleft,a
4221                     ; 2943             pBuffer++;
4223  0415 1e05          	ldw	x,(OFST+1,sp)
4224  0417 5c            	incw	x
4225  0418 1f05          	ldw	(OFST+1,sp),x
4226                     ; 2944 	    nBytes--;
4228  041a 1e09          	ldw	x,(OFST+5,sp)
4229  041c 5a            	decw	x
4230  041d 1f09          	ldw	(OFST+5,sp),x
4231                     ; 2945 	    if (nBytes == 0) {
4233  041f 2703cc06f8    	jrne	L3161
4234                     ; 2948 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4236  0424 a605          	ld	a,#5
4237  0426 c70043        	ld	_saved_parsestate,a
4238  0429 1e0b          	ldw	x,(OFST+7,sp)
4239  042b e70a          	ld	(10,x),a
4240                     ; 2949 	      break;
4242  042d cc0747        	jra	L1051
4243  0430               L1061:
4244                     ; 2956           else if (pSocket->ParseCmd == 'a'
4244                     ; 2957                 || pSocket->ParseCmd == 'l'
4244                     ; 2958                 || pSocket->ParseCmd == 'm' ) {
4246  0430 a161          	cp	a,#97
4247  0432 2708          	jreq	L7161
4249  0434 a16c          	cp	a,#108
4250  0436 2704          	jreq	L7161
4252  0438 a16d          	cp	a,#109
4253  043a 2657          	jrne	L5161
4254  043c               L7161:
4255                     ; 2962 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4257  043c 725f000a      	clr	_break_while
4258                     ; 2964             tmp_pBuffer = pBuffer;
4260  0440 1e05          	ldw	x,(OFST+1,sp)
4261  0442 cf000e        	ldw	_tmp_pBuffer,x
4262                     ; 2965             tmp_nBytes = nBytes;
4264  0445 1e09          	ldw	x,(OFST+5,sp)
4265  0447 cf000c        	ldw	_tmp_nBytes,x
4266                     ; 2966 	    tmp_nParseLeft = pSocket->nParseLeft;
4268  044a 1e0b          	ldw	x,(OFST+7,sp)
4269  044c e606          	ld	a,(6,x)
4270  044e c7000b        	ld	_tmp_nParseLeft,a
4271                     ; 2967             switch (pSocket->ParseCmd) {
4273  0451 e608          	ld	a,(8,x)
4275                     ; 2970               case 'm': i = 10; break;
4276  0453 a061          	sub	a,#97
4277  0455 270b          	jreq	L3701
4278  0457 a00b          	sub	a,#11
4279  0459 270b          	jreq	L5701
4280  045b 4a            	dec	a
4281  045c 2708          	jreq	L5701
4282  045e 7b04          	ld	a,(OFST+0,sp)
4283  0460 2008          	jra	L5261
4284  0462               L3701:
4285                     ; 2968               case 'a': i = 19; break;
4287  0462 a613          	ld	a,#19
4290  0464 2002          	jp	LC018
4291  0466               L5701:
4292                     ; 2969               case 'l':
4292                     ; 2970               case 'm': i = 10; break;
4294  0466 a60a          	ld	a,#10
4295  0468               LC018:
4296  0468 6b04          	ld	(OFST+0,sp),a
4300  046a               L5261:
4301                     ; 2972             parse_POST_string(pSocket->ParseCmd, i);
4303  046a 160b          	ldw	y,(OFST+7,sp)
4304  046c 97            	ld	xl,a
4305  046d 90e608        	ld	a,(8,y)
4306  0470 95            	ld	xh,a
4307  0471 cd0000        	call	_parse_POST_string
4309                     ; 2973             pBuffer = tmp_pBuffer;
4311  0474 ce000e        	ldw	x,_tmp_pBuffer
4312  0477 1f05          	ldw	(OFST+1,sp),x
4313                     ; 2974             nBytes = tmp_nBytes;
4315  0479 ce000c        	ldw	x,_tmp_nBytes
4316  047c 1f09          	ldw	(OFST+5,sp),x
4317                     ; 2975 	    pSocket->nParseLeft = tmp_nParseLeft;
4319  047e 1e0b          	ldw	x,(OFST+7,sp)
4320  0480 c6000b        	ld	a,_tmp_nParseLeft
4321  0483 e706          	ld	(6,x),a
4322                     ; 2976             if (break_while == 1) {
4324  0485 c6000a        	ld	a,_break_while
4325  0488 4a            	dec	a
4326  0489 2696          	jrne	L3161
4327                     ; 2980 	      pSocket->ParseState = saved_parsestate;
4329  048b c60043        	ld	a,_saved_parsestate
4330  048e e70a          	ld	(10,x),a
4331                     ; 2981 	      break;
4333  0490 cc0747        	jra	L1051
4334  0493               L5161:
4335                     ; 2988           else if (pSocket->ParseCmd == 'b') {
4337  0493 a162          	cp	a,#98
4338  0495 2654          	jrne	L3361
4339                     ; 2996 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4341  0497 725f000a      	clr	_break_while
4342                     ; 2998             tmp_pBuffer = pBuffer;
4344  049b 1e05          	ldw	x,(OFST+1,sp)
4345  049d cf000e        	ldw	_tmp_pBuffer,x
4346                     ; 2999             tmp_nBytes = nBytes;
4348  04a0 1e09          	ldw	x,(OFST+5,sp)
4349  04a2 cf000c        	ldw	_tmp_nBytes,x
4350                     ; 3000 	    tmp_nParseLeft = pSocket->nParseLeft;
4352  04a5 1e0b          	ldw	x,(OFST+7,sp)
4353  04a7 e606          	ld	a,(6,x)
4354  04a9 c7000b        	ld	_tmp_nParseLeft,a
4355                     ; 3001             parse_POST_address(pSocket->ParseCmd, pSocket->ParseNum);
4357  04ac e609          	ld	a,(9,x)
4358  04ae 160b          	ldw	y,(OFST+7,sp)
4359  04b0 97            	ld	xl,a
4360  04b1 90e608        	ld	a,(8,y)
4361  04b4 95            	ld	xh,a
4362  04b5 cd0000        	call	_parse_POST_address
4364                     ; 3002             pBuffer = tmp_pBuffer;
4366  04b8 ce000e        	ldw	x,_tmp_pBuffer
4367  04bb 1f05          	ldw	(OFST+1,sp),x
4368                     ; 3003             nBytes = tmp_nBytes;
4370  04bd ce000c        	ldw	x,_tmp_nBytes
4371  04c0 1f09          	ldw	(OFST+5,sp),x
4372                     ; 3004 	    pSocket->nParseLeft = tmp_nParseLeft;
4374  04c2 1e0b          	ldw	x,(OFST+7,sp)
4375  04c4 c6000b        	ld	a,_tmp_nParseLeft
4376  04c7 e706          	ld	(6,x),a
4377                     ; 3005             if (break_while == 1) {
4379  04c9 c6000a        	ld	a,_break_while
4380  04cc a101          	cp	a,#1
4381  04ce 260a          	jrne	L5361
4382                     ; 3009               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4384  04d0 a604          	ld	a,#4
4385  04d2 c70043        	ld	_saved_parsestate,a
4386  04d5 e70a          	ld	(10,x),a
4387                     ; 3010 	      break;
4389  04d7 cc0747        	jra	L1051
4390  04da               L5361:
4391                     ; 3012             if (break_while == 2) {
4393  04da a102          	cp	a,#2
4394  04dc 2703cc06f8    	jrne	L3161
4395                     ; 3015               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4397  04e1 a605          	ld	a,#5
4398  04e3 c70043        	ld	_saved_parsestate,a
4399  04e6 e70a          	ld	(10,x),a
4400                     ; 3016 	      break;
4402  04e8 cc0747        	jra	L1051
4403  04eb               L3361:
4404                     ; 3023           else if (pSocket->ParseCmd == 'c') {
4406  04eb a163          	cp	a,#99
4407  04ed 2651          	jrne	L3461
4408                     ; 3032 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4410  04ef 725f000a      	clr	_break_while
4411                     ; 3034             tmp_pBuffer = pBuffer;
4413  04f3 1e05          	ldw	x,(OFST+1,sp)
4414  04f5 cf000e        	ldw	_tmp_pBuffer,x
4415                     ; 3035             tmp_nBytes = nBytes;
4417  04f8 1e09          	ldw	x,(OFST+5,sp)
4418  04fa cf000c        	ldw	_tmp_nBytes,x
4419                     ; 3036 	    tmp_nParseLeft = pSocket->nParseLeft;
4421  04fd 1e0b          	ldw	x,(OFST+7,sp)
4422  04ff e606          	ld	a,(6,x)
4423  0501 c7000b        	ld	_tmp_nParseLeft,a
4424                     ; 3037             parse_POST_port(pSocket->ParseCmd, pSocket->ParseNum);
4426  0504 e609          	ld	a,(9,x)
4427  0506 160b          	ldw	y,(OFST+7,sp)
4428  0508 97            	ld	xl,a
4429  0509 90e608        	ld	a,(8,y)
4430  050c 95            	ld	xh,a
4431  050d cd0000        	call	_parse_POST_port
4433                     ; 3038             pBuffer = tmp_pBuffer;
4435  0510 ce000e        	ldw	x,_tmp_pBuffer
4436  0513 1f05          	ldw	(OFST+1,sp),x
4437                     ; 3039             nBytes = tmp_nBytes;
4439  0515 ce000c        	ldw	x,_tmp_nBytes
4440  0518 1f09          	ldw	(OFST+5,sp),x
4441                     ; 3040 	    pSocket->nParseLeft = tmp_nParseLeft;
4443  051a 1e0b          	ldw	x,(OFST+7,sp)
4444  051c c6000b        	ld	a,_tmp_nParseLeft
4445  051f e706          	ld	(6,x),a
4446                     ; 3041             if (break_while == 1) {
4448  0521 c6000a        	ld	a,_break_while
4449  0524 a101          	cp	a,#1
4450  0526 260a          	jrne	L5461
4451                     ; 3044               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4453  0528 a604          	ld	a,#4
4454  052a c70043        	ld	_saved_parsestate,a
4455  052d e70a          	ld	(10,x),a
4456                     ; 3045 	      break;
4458  052f cc0747        	jra	L1051
4459  0532               L5461:
4460                     ; 3047             if (break_while == 2) {
4462  0532 a102          	cp	a,#2
4463  0534 26a8          	jrne	L3161
4464                     ; 3050               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4466  0536 a605          	ld	a,#5
4467  0538 c70043        	ld	_saved_parsestate,a
4468  053b e70a          	ld	(10,x),a
4469                     ; 3051 	      break;
4471  053d cc0747        	jra	L1051
4472  0540               L3461:
4473                     ; 3058           else if (pSocket->ParseCmd == 'd') {
4475  0540 a164          	cp	a,#100
4476  0542 2703cc05e2    	jrne	L3561
4477                     ; 3064 	    alpha[0] = '-';
4479  0547 352d0004      	mov	_alpha,#45
4480                     ; 3065 	    alpha[1] = '-';
4482  054b 352d0005      	mov	_alpha+1,#45
4483                     ; 3067 	    if (saved_postpartial_previous[0] == 'd') {
4485  054f c60012        	ld	a,_saved_postpartial_previous
4486  0552 a164          	cp	a,#100
4487  0554 261a          	jrne	L5561
4488                     ; 3071 	      saved_postpartial_previous[0] = '\0';
4490  0556 725f0012      	clr	_saved_postpartial_previous
4491                     ; 3077 	      if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
4493  055a c60016        	ld	a,_saved_postpartial_previous+4
4494  055d 2705          	jreq	L7561
4497  055f 5500160004    	mov	_alpha,_saved_postpartial_previous+4
4498  0564               L7561:
4499                     ; 3078 	      if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
4501  0564 c60017        	ld	a,_saved_postpartial_previous+5
4502  0567 270a          	jreq	L3661
4505  0569 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
4506  056e 2003          	jra	L3661
4507  0570               L5561:
4508                     ; 3085               clear_saved_postpartial_data(); // Clear [4] and higher
4510  0570 cd0000        	call	_clear_saved_postpartial_data
4512  0573               L3661:
4513                     ; 3088             if (alpha[0] == '-') {
4515  0573 c60004        	ld	a,_alpha
4516  0576 a12d          	cp	a,#45
4517  0578 261e          	jrne	L5661
4518                     ; 3089 	      alpha[0] = (uint8_t)(*pBuffer);
4520  057a 1e05          	ldw	x,(OFST+1,sp)
4521  057c f6            	ld	a,(x)
4522  057d c70004        	ld	_alpha,a
4523                     ; 3090               saved_postpartial[4] = *pBuffer;
4525  0580 c7002e        	ld	_saved_postpartial+4,a
4526                     ; 3091               pSocket->nParseLeft--;
4528  0583 1e0b          	ldw	x,(OFST+7,sp)
4529  0585 6a06          	dec	(6,x)
4530                     ; 3092               saved_nparseleft = pSocket->nParseLeft;
4532  0587 e606          	ld	a,(6,x)
4533  0589 c70042        	ld	_saved_nparseleft,a
4534                     ; 3093               pBuffer++;
4536  058c 1e05          	ldw	x,(OFST+1,sp)
4537  058e 5c            	incw	x
4538  058f 1f05          	ldw	(OFST+1,sp),x
4539                     ; 3094 	      nBytes--;
4541  0591 1e09          	ldw	x,(OFST+5,sp)
4542  0593 5a            	decw	x
4543  0594 1f09          	ldw	(OFST+5,sp),x
4544                     ; 3095               if (nBytes == 0) break; // Hit end of fragment. Break out of
4546  0596 27a5          	jreq	L1051
4549  0598               L5661:
4550                     ; 3099             if (alpha[1] == '-') {
4552  0598 c60005        	ld	a,_alpha+1
4553  059b a12d          	cp	a,#45
4554  059d 261c          	jrne	L1761
4555                     ; 3100 	      alpha[1] = (uint8_t)(*pBuffer);
4557  059f 1e05          	ldw	x,(OFST+1,sp)
4558  05a1 f6            	ld	a,(x)
4559  05a2 c70005        	ld	_alpha+1,a
4560                     ; 3101               saved_postpartial[5] = *pBuffer;
4562  05a5 c7002f        	ld	_saved_postpartial+5,a
4563                     ; 3102               pSocket->nParseLeft--;
4565  05a8 1e0b          	ldw	x,(OFST+7,sp)
4566  05aa 6a06          	dec	(6,x)
4567                     ; 3103               saved_nparseleft = pSocket->nParseLeft;
4569  05ac e606          	ld	a,(6,x)
4570  05ae c70042        	ld	_saved_nparseleft,a
4571                     ; 3104               pBuffer++;
4573  05b1 1e05          	ldw	x,(OFST+1,sp)
4574  05b3 5c            	incw	x
4575  05b4 1f05          	ldw	(OFST+1,sp),x
4576                     ; 3105 	      nBytes--;
4578  05b6 1e09          	ldw	x,(OFST+5,sp)
4579  05b8 5a            	decw	x
4580  05b9 1f09          	ldw	(OFST+5,sp),x
4581  05bb               L1761:
4582                     ; 3111             clear_saved_postpartial_all();
4584  05bb cd0000        	call	_clear_saved_postpartial_all
4586                     ; 3113             SetMAC(pSocket->ParseNum, alpha[0], alpha[1]);
4588  05be 3b0005        	push	_alpha+1
4589  05c1 c60004        	ld	a,_alpha
4590  05c4 160c          	ldw	y,(OFST+8,sp)
4591  05c6 97            	ld	xl,a
4592  05c7 90e609        	ld	a,(9,y)
4593  05ca 95            	ld	xh,a
4594  05cb cd0000        	call	_SetMAC
4596  05ce 84            	pop	a
4597                     ; 3115             if (nBytes == 0) {
4599  05cf 1e09          	ldw	x,(OFST+5,sp)
4600  05d1 2703cc06f8    	jrne	L3161
4601                     ; 3118 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4603  05d6 a605          	ld	a,#5
4604  05d8 c70043        	ld	_saved_parsestate,a
4605  05db 1e0b          	ldw	x,(OFST+7,sp)
4606  05dd e70a          	ld	(10,x),a
4607                     ; 3119 	      break;
4609  05df cc0747        	jra	L1051
4610  05e2               L3561:
4611                     ; 3126 	  else if (pSocket->ParseCmd == 'g') {
4613  05e2 a167          	cp	a,#103
4614  05e4 2703cc06eb    	jrne	L7761
4615                     ; 3137             for (i=0; i<6; i++) alpha[i] = '-';
4617  05e9 4f            	clr	a
4618  05ea 6b04          	ld	(OFST+0,sp),a
4620  05ec               L1071:
4623  05ec 5f            	clrw	x
4624  05ed 97            	ld	xl,a
4625  05ee a62d          	ld	a,#45
4626  05f0 d70004        	ld	(_alpha,x),a
4629  05f3 0c04          	inc	(OFST+0,sp)
4633  05f5 7b04          	ld	a,(OFST+0,sp)
4634  05f7 a106          	cp	a,#6
4635  05f9 25f1          	jrult	L1071
4636                     ; 3139 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4638  05fb 725f000a      	clr	_break_while
4639                     ; 3142 	    if (saved_postpartial_previous[0] == 'g') {
4641  05ff c60012        	ld	a,_saved_postpartial_previous
4642  0602 a167          	cp	a,#103
4643  0604 2621          	jrne	L7071
4644                     ; 3146 	      saved_postpartial_previous[0] = '\0';
4646  0606 725f0012      	clr	_saved_postpartial_previous
4647                     ; 3152               for (i=0; i<6; i++) {
4649  060a 4f            	clr	a
4650  060b 6b04          	ld	(OFST+0,sp),a
4652  060d               L1171:
4653                     ; 3153                 if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
4655  060d 5f            	clrw	x
4656  060e 97            	ld	xl,a
4657  060f 724d0016      	tnz	(_saved_postpartial_previous+4,x)
4658  0613 2708          	jreq	L7171
4661  0615 5f            	clrw	x
4662  0616 97            	ld	xl,a
4663  0617 d60016        	ld	a,(_saved_postpartial_previous+4,x)
4664  061a d70004        	ld	(_alpha,x),a
4665  061d               L7171:
4666                     ; 3152               for (i=0; i<6; i++) {
4668  061d 0c04          	inc	(OFST+0,sp)
4672  061f 7b04          	ld	a,(OFST+0,sp)
4673  0621 a106          	cp	a,#6
4674  0623 25e8          	jrult	L1171
4676  0625 2003          	jra	L1271
4677  0627               L7071:
4678                     ; 3161               clear_saved_postpartial_data(); // Clear [4] and higher
4680  0627 cd0000        	call	_clear_saved_postpartial_data
4682  062a               L1271:
4683                     ; 3164             for (i=0; i<6; i++) {
4685  062a 4f            	clr	a
4686  062b 6b04          	ld	(OFST+0,sp),a
4688  062d               L3271:
4689                     ; 3170               if (alpha[i] == '-') {
4691  062d 5f            	clrw	x
4692  062e 97            	ld	xl,a
4693  062f d60004        	ld	a,(_alpha,x)
4694  0632 a12d          	cp	a,#45
4695  0634 2636          	jrne	L1371
4696                     ; 3171 	        alpha[i] = (uint8_t)(*pBuffer);
4698  0636 7b04          	ld	a,(OFST+0,sp)
4699  0638 5f            	clrw	x
4700  0639 1605          	ldw	y,(OFST+1,sp)
4701  063b 97            	ld	xl,a
4702  063c 90f6          	ld	a,(y)
4703  063e d70004        	ld	(_alpha,x),a
4704                     ; 3172                 saved_postpartial[i+4] = *pBuffer;
4706  0641 5f            	clrw	x
4707  0642 7b04          	ld	a,(OFST+0,sp)
4708  0644 97            	ld	xl,a
4709  0645 90f6          	ld	a,(y)
4710  0647 d7002e        	ld	(_saved_postpartial+4,x),a
4711                     ; 3173                 pSocket->nParseLeft--;
4713  064a 1e0b          	ldw	x,(OFST+7,sp)
4714  064c 6a06          	dec	(6,x)
4715                     ; 3174                 saved_nparseleft = pSocket->nParseLeft;
4717  064e e606          	ld	a,(6,x)
4718  0650 c70042        	ld	_saved_nparseleft,a
4719                     ; 3175                 pBuffer++;
4721  0653 93            	ldw	x,y
4722  0654 5c            	incw	x
4723  0655 1f05          	ldw	(OFST+1,sp),x
4724                     ; 3176 	        nBytes--;
4726  0657 1e09          	ldw	x,(OFST+5,sp)
4727  0659 5a            	decw	x
4728  065a 1f09          	ldw	(OFST+5,sp),x
4729                     ; 3177                 if (i != 5 && nBytes == 0) {
4731  065c 7b04          	ld	a,(OFST+0,sp)
4732  065e a105          	cp	a,#5
4733  0660 270a          	jreq	L1371
4735  0662 1e09          	ldw	x,(OFST+5,sp)
4736  0664 2606          	jrne	L1371
4737                     ; 3178 		  break_while = 1; // Hit end of fragment. Break out of
4739  0666 3501000a      	mov	_break_while,#1
4740                     ; 3180 		  break; // Break out of for() loop
4742  066a 2008          	jra	L7271
4743  066c               L1371:
4744                     ; 3164             for (i=0; i<6; i++) {
4746  066c 0c04          	inc	(OFST+0,sp)
4750  066e 7b04          	ld	a,(OFST+0,sp)
4751  0670 a106          	cp	a,#6
4752  0672 25b9          	jrult	L3271
4753  0674               L7271:
4754                     ; 3184 	    if (break_while == 1) {
4756  0674 c6000a        	ld	a,_break_while
4757  0677 4a            	dec	a
4758  0678 2603cc0747    	jreq	L1051
4759                     ; 3186 	      break;
4761                     ; 3192             clear_saved_postpartial_all();
4763  067d cd0000        	call	_clear_saved_postpartial_all
4765                     ; 3195 	    if (alpha[0] != '0' && alpha[0] != '1') alpha[0] = '0';
4767  0680 c60004        	ld	a,_alpha
4768  0683 a130          	cp	a,#48
4769  0685 2708          	jreq	L7371
4771  0687 a131          	cp	a,#49
4772  0689 2704          	jreq	L7371
4775  068b 35300004      	mov	_alpha,#48
4776  068f               L7371:
4777                     ; 3196 	    if (alpha[1] != '0' && alpha[1] != '1') alpha[1] = '0';
4779  068f c60005        	ld	a,_alpha+1
4780  0692 a130          	cp	a,#48
4781  0694 2708          	jreq	L1471
4783  0696 a131          	cp	a,#49
4784  0698 2704          	jreq	L1471
4787  069a 35300005      	mov	_alpha+1,#48
4788  069e               L1471:
4789                     ; 3197 	    if (alpha[2] != '0' && alpha[2] != '1' && alpha[2] != '2') alpha[2] = '2';
4791  069e c60006        	ld	a,_alpha+2
4792  06a1 a130          	cp	a,#48
4793  06a3 270c          	jreq	L3471
4795  06a5 a131          	cp	a,#49
4796  06a7 2708          	jreq	L3471
4798  06a9 a132          	cp	a,#50
4799  06ab 2704          	jreq	L3471
4802  06ad 35320006      	mov	_alpha+2,#50
4803  06b1               L3471:
4804                     ; 3198 	    if (alpha[3] != '0' && alpha[3] != '1') alpha[3] = '0';
4806  06b1 c60007        	ld	a,_alpha+3
4807  06b4 a130          	cp	a,#48
4808  06b6 2708          	jreq	L5471
4810  06b8 a131          	cp	a,#49
4811  06ba 2704          	jreq	L5471
4814  06bc 35300007      	mov	_alpha+3,#48
4815  06c0               L5471:
4816                     ; 3200 	    Pending_config_settings[0] = (uint8_t)alpha[0];
4818  06c0 5500040000    	mov	_Pending_config_settings,_alpha
4819                     ; 3201             Pending_config_settings[1] = (uint8_t)alpha[1];
4821  06c5 5500050001    	mov	_Pending_config_settings+1,_alpha+1
4822                     ; 3202             Pending_config_settings[2] = (uint8_t)alpha[2];
4824  06ca 5500060002    	mov	_Pending_config_settings+2,_alpha+2
4825                     ; 3203             Pending_config_settings[3] = (uint8_t)alpha[3];
4827  06cf 5500070003    	mov	_Pending_config_settings+3,_alpha+3
4828                     ; 3204             Pending_config_settings[4] = '0';
4830  06d4 35300004      	mov	_Pending_config_settings+4,#48
4831                     ; 3205             Pending_config_settings[5] = '0';
4833  06d8 35300005      	mov	_Pending_config_settings+5,#48
4834                     ; 3207             if (nBytes == 0) {
4836  06dc 1e09          	ldw	x,(OFST+5,sp)
4837  06de 2618          	jrne	L3161
4838                     ; 3210 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4840  06e0 a605          	ld	a,#5
4841  06e2 c70043        	ld	_saved_parsestate,a
4842  06e5 1e0b          	ldw	x,(OFST+7,sp)
4843  06e7 e70a          	ld	(10,x),a
4844                     ; 3211 	      break;
4846  06e9 205c          	jra	L1051
4847  06eb               L7761:
4848                     ; 3218 	  else if (pSocket->ParseCmd == 'z') {
4850  06eb a17a          	cp	a,#122
4851  06ed 2609          	jrne	L3161
4852                     ; 3243 	    nBytes = 0;
4854  06ef 5f            	clrw	x
4855  06f0 1f09          	ldw	(OFST+5,sp),x
4856                     ; 3244 	    pSocket->nParseLeft = 0;
4858  06f2 1e0b          	ldw	x,(OFST+7,sp)
4859  06f4 6f06          	clr	(6,x)
4860                     ; 3245             break; // Break out of the while loop. We're done with POST.
4862  06f6 204f          	jra	L1051
4863  06f8               L3161:
4864                     ; 3256           pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4866  06f8 a605          	ld	a,#5
4867  06fa c70043        	ld	_saved_parsestate,a
4868  06fd 1e0b          	ldw	x,(OFST+7,sp)
4869  06ff e70a          	ld	(10,x),a
4870                     ; 3258           if (pSocket->nParseLeft < 30) {
4872  0701 e606          	ld	a,(6,x)
4873  0703 a11e          	cp	a,#30
4874  0705 2503cc02c6    	jruge	L7741
4875                     ; 3273 	    if (pSocket->nParseLeftAddl > 0) {
4877  070a 6d07          	tnz	(7,x)
4878  070c 27f9          	jreq	L7741
4879                     ; 3274 	      pSocket->nParseLeft += pSocket->nParseLeftAddl;
4881  070e eb07          	add	a,(7,x)
4882  0710 e706          	ld	(6,x),a
4883                     ; 3275 	      pSocket->nParseLeftAddl = 0;
4885  0712 6f07          	clr	(7,x)
4886                     ; 3276 	      saved_nparseleft = pSocket->nParseLeft;
4888  0714 c70042        	ld	_saved_nparseleft,a
4889  0717 cc02c6        	jra	L7741
4890  071a               L7751:
4891                     ; 3281         else if (pSocket->ParseState == PARSE_DELIM) {
4893  071a a105          	cp	a,#5
4894  071c 26f9          	jrne	L7741
4895                     ; 3282           if (pSocket->nParseLeft > 0) {
4897  071e e606          	ld	a,(6,x)
4898  0720 2720          	jreq	L5671
4899                     ; 3285             pSocket->ParseState = saved_parsestate = PARSE_CMD;
4901  0722 725f0043      	clr	_saved_parsestate
4902  0726 6f0a          	clr	(10,x)
4903                     ; 3286             pSocket->nParseLeft--;
4905  0728 6a06          	dec	(6,x)
4906                     ; 3287             saved_nparseleft = pSocket->nParseLeft;
4908  072a e606          	ld	a,(6,x)
4909  072c c70042        	ld	_saved_nparseleft,a
4910                     ; 3288             pBuffer++;
4912  072f 1e05          	ldw	x,(OFST+1,sp)
4913  0731 5c            	incw	x
4914  0732 1f05          	ldw	(OFST+1,sp),x
4915                     ; 3289 	    nBytes--;
4917  0734 1e09          	ldw	x,(OFST+5,sp)
4918  0736 5a            	decw	x
4919  0737 1f09          	ldw	(OFST+5,sp),x
4920                     ; 3291 	    clear_saved_postpartial_all();
4922  0739 cd0000        	call	_clear_saved_postpartial_all
4924                     ; 3295             if (nBytes == 0) {
4926  073c 1e09          	ldw	x,(OFST+5,sp)
4927  073e 26d7          	jrne	L7741
4928                     ; 3296 	      break; // Hit end of fragment but still have more to parse in
4930  0740 2005          	jra	L1051
4931  0742               L5671:
4932                     ; 3306             pSocket->nParseLeft = 0; // End the parsing
4934  0742 e706          	ld	(6,x),a
4935                     ; 3307 	    nBytes = 0;
4937  0744 5f            	clrw	x
4938  0745 1f09          	ldw	(OFST+5,sp),x
4939                     ; 3308 	    break; // Exit parsing
4940  0747               L1051:
4941                     ; 3335       if (pSocket->nParseLeft == 0) {
4943  0747 1e0b          	ldw	x,(OFST+7,sp)
4944  0749 e606          	ld	a,(6,x)
4945  074b 264e          	jrne	L3771
4946                     ; 3338 	saved_nstate = STATE_NULL;
4948  074d 357f0044      	mov	_saved_nstate,#127
4949                     ; 3339 	saved_parsestate = PARSE_CMD;
4951  0751 c70043        	ld	_saved_parsestate,a
4952                     ; 3340         saved_nparseleft = 0;
4954  0754 c70042        	ld	_saved_nparseleft,a
4955                     ; 3341         saved_newlines = 0;
4957  0757 c70011        	ld	_saved_newlines,a
4958                     ; 3342 	for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i] = '\0';
4960  075a 6b04          	ld	(OFST+0,sp),a
4962  075c               L5771:
4965  075c 5f            	clrw	x
4966  075d 97            	ld	xl,a
4967  075e 724f002a      	clr	(_saved_postpartial,x)
4968  0762 5f            	clrw	x
4969  0763 97            	ld	xl,a
4970  0764 724f0012      	clr	(_saved_postpartial_previous,x)
4973  0768 0c04          	inc	(OFST+0,sp)
4977  076a 7b04          	ld	a,(OFST+0,sp)
4978  076c a118          	cp	a,#24
4979  076e 25ec          	jrult	L5771
4980                     ; 3348 	parse_complete = 1;
4982  0770 35010000      	mov	_parse_complete,#1
4983                     ; 3349 	pSocket->nState = STATE_SENDHEADER;
4985  0774 1e0b          	ldw	x,(OFST+7,sp)
4986  0776 a60b          	ld	a,#11
4987  0778 f7            	ld	(x),a
4988                     ; 3361         if (current_webpage == WEBPAGE_IOCONTROL) {
4990  0779 c60003        	ld	a,_current_webpage
4991  077c 260c          	jrne	L3002
4992                     ; 3362           pSocket->pData = g_HtmlPageIOControl;
4994  077e 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4995  0782 ef01          	ldw	(1,x),y
4996                     ; 3363           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4998  0784 90ae0c06      	ldw	y,#3078
4999  0788 ef03          	ldw	(3,x),y
5000  078a               L3002:
5001                     ; 3365         if (current_webpage == WEBPAGE_CONFIGURATION) {
5003  078a 4a            	dec	a
5004  078b 2612          	jrne	L5741
5005                     ; 3366           pSocket->pData = g_HtmlPageConfiguration;
5007  078d 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
5008  0791 ef01          	ldw	(1,x),y
5009                     ; 3367           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
5011  0793 90ae0c5c      	ldw	y,#3164
5012  0797 ef03          	ldw	(3,x),y
5013  0799 2004          	jra	L5741
5014  079b               L3771:
5015                     ; 3387 	uip_len = 0;
5017  079b 5f            	clrw	x
5018  079c cf0000        	ldw	_uip_len,x
5019  079f               L5741:
5020                     ; 3391     if (pSocket->nState == STATE_PARSEGET) {
5022  079f 1e0b          	ldw	x,(OFST+7,sp)
5023  07a1 f6            	ld	a,(x)
5024  07a2 a10d          	cp	a,#13
5025  07a4 2703cc0a34    	jrne	L1102
5027  07a9 cc0a2d        	jra	L5102
5028  07ac               L3102:
5029                     ; 3420         if (pSocket->ParseState == PARSE_SLASH1) {
5031  07ac 1e0b          	ldw	x,(OFST+7,sp)
5032  07ae e60a          	ld	a,(10,x)
5033  07b0 a106          	cp	a,#6
5034  07b2 263c          	jrne	L1202
5035                     ; 3423           pSocket->ParseCmd = *pBuffer;
5037  07b4 1e05          	ldw	x,(OFST+1,sp)
5038  07b6 f6            	ld	a,(x)
5039  07b7 1e0b          	ldw	x,(OFST+7,sp)
5040  07b9 e708          	ld	(8,x),a
5041                     ; 3424           pSocket->nParseLeft--;
5043  07bb 6a06          	dec	(6,x)
5044                     ; 3425           pBuffer++;
5046  07bd 1e05          	ldw	x,(OFST+1,sp)
5047  07bf 5c            	incw	x
5048  07c0 1f05          	ldw	(OFST+1,sp),x
5049                     ; 3426 	  nBytes--;
5051  07c2 1e09          	ldw	x,(OFST+5,sp)
5052  07c4 5a            	decw	x
5053  07c5 1f09          	ldw	(OFST+5,sp),x
5054                     ; 3427 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5056  07c7 1e0b          	ldw	x,(OFST+7,sp)
5057  07c9 e608          	ld	a,(8,x)
5058  07cb a12f          	cp	a,#47
5059  07cd 2605          	jrne	L3202
5060                     ; 3428 	    pSocket->ParseState = PARSE_NUM10;
5062  07cf a601          	ld	a,#1
5064  07d1 cc086a        	jp	LC022
5065  07d4               L3202:
5066                     ; 3432 	    current_webpage = WEBPAGE_IOCONTROL;
5068  07d4 725f0003      	clr	_current_webpage
5069                     ; 3433             pSocket->pData = g_HtmlPageIOControl;
5071  07d8 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5072  07dc ef01          	ldw	(1,x),y
5073                     ; 3434             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5075  07de 90ae0c06      	ldw	y,#3078
5076  07e2 ef03          	ldw	(3,x),y
5077                     ; 3435             pSocket->nParseLeft = 0; // This will cause the while() to exit
5079  07e4 6f06          	clr	(6,x)
5080                     ; 3437             pSocket->nState = STATE_CONNECTED;
5082  07e6 7f            	clr	(x)
5083                     ; 3438             pSocket->nPrevBytes = 0xFFFF;
5085  07e7 90aeffff      	ldw	y,#65535
5086  07eb ef0b          	ldw	(11,x),y
5087  07ed cc0a1c        	jra	L7202
5088  07f0               L1202:
5089                     ; 3442         else if (pSocket->ParseState == PARSE_NUM10) {
5091  07f0 a101          	cp	a,#1
5092  07f2 2640          	jrne	L1302
5093                     ; 3447 	  if (*pBuffer == ' ') {
5095  07f4 1e05          	ldw	x,(OFST+1,sp)
5096  07f6 f6            	ld	a,(x)
5097  07f7 a120          	cp	a,#32
5098  07f9 261e          	jrne	L3302
5099                     ; 3448 	    current_webpage = WEBPAGE_IOCONTROL;
5101  07fb 725f0003      	clr	_current_webpage
5102                     ; 3449             pSocket->pData = g_HtmlPageIOControl;
5104  07ff 1e0b          	ldw	x,(OFST+7,sp)
5105  0801 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5106  0805 ef01          	ldw	(1,x),y
5107                     ; 3450             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5109  0807 90ae0c06      	ldw	y,#3078
5110  080b ef03          	ldw	(3,x),y
5111                     ; 3451             pSocket->nParseLeft = 0;
5113  080d 6f06          	clr	(6,x)
5114                     ; 3453             pSocket->nState = STATE_CONNECTED;
5116  080f 7f            	clr	(x)
5117                     ; 3454             pSocket->nPrevBytes = 0xFFFF;
5119  0810 90aeffff      	ldw	y,#65535
5120  0814 ef0b          	ldw	(11,x),y
5122  0816 cc0a1c        	jra	L7202
5123  0819               L3302:
5124                     ; 3458 	  else if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
5126  0819 a130          	cp	a,#48
5127  081b 2547          	jrult	L7402
5129  081d a13a          	cp	a,#58
5130  081f 2443          	jruge	L7402
5131                     ; 3460             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5133  0821 97            	ld	xl,a
5134  0822 a60a          	ld	a,#10
5135  0824 42            	mul	x,a
5136  0825 9f            	ld	a,xl
5137  0826 1e0b          	ldw	x,(OFST+7,sp)
5138  0828 a0e0          	sub	a,#224
5139  082a e709          	ld	(9,x),a
5140                     ; 3461 	    pSocket->ParseState = PARSE_NUM1;
5142  082c a602          	ld	a,#2
5143  082e e70a          	ld	(10,x),a
5144                     ; 3462             pSocket->nParseLeft--;
5146  0830 6a06          	dec	(6,x)
5147                     ; 3463             pBuffer++;
5148                     ; 3464 	    nBytes--;
5150  0832 2023          	jp	LC024
5151                     ; 3469             pSocket->nParseLeft = 0;
5152                     ; 3470             pSocket->ParseState = PARSE_FAIL;
5153  0834               L1302:
5154                     ; 3475         else if (pSocket->ParseState == PARSE_NUM1) {
5156  0834 a102          	cp	a,#2
5157  0836 2637          	jrne	L5402
5158                     ; 3476 	  if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
5160  0838 1e05          	ldw	x,(OFST+1,sp)
5161  083a f6            	ld	a,(x)
5162  083b a130          	cp	a,#48
5163  083d 2525          	jrult	L7402
5165  083f a13a          	cp	a,#58
5166  0841 2421          	jruge	L7402
5167                     ; 3478             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5169  0843 1605          	ldw	y,(OFST+1,sp)
5170  0845 1e0b          	ldw	x,(OFST+7,sp)
5171  0847 90f6          	ld	a,(y)
5172  0849 a030          	sub	a,#48
5173  084b eb09          	add	a,(9,x)
5174  084d e709          	ld	(9,x),a
5175                     ; 3479             pSocket->ParseState = PARSE_VAL;
5177  084f a604          	ld	a,#4
5178  0851 e70a          	ld	(10,x),a
5179                     ; 3480             pSocket->nParseLeft = 1; // Set to 1 so PARSE_VAL will be called
5181  0853 a601          	ld	a,#1
5182  0855 e706          	ld	(6,x),a
5183                     ; 3481             pBuffer++;
5185                     ; 3482 	    nBytes--;
5187  0857               LC024:
5189  0857 1e05          	ldw	x,(OFST+1,sp)
5190  0859 5c            	incw	x
5191  085a 1f05          	ldw	(OFST+1,sp),x
5193  085c 1e09          	ldw	x,(OFST+5,sp)
5194  085e 5a            	decw	x
5195  085f 1f09          	ldw	(OFST+5,sp),x
5197  0861 cc0a1c        	jra	L7202
5198  0864               L7402:
5199                     ; 3487             pSocket->nParseLeft = 0;
5201                     ; 3488             pSocket->ParseState = PARSE_FAIL;
5204  0864 1e0b          	ldw	x,(OFST+7,sp)
5206  0866 a607          	ld	a,#7
5207  0868 6f06          	clr	(6,x)
5208  086a               LC022:
5209  086a e70a          	ld	(10,x),a
5210  086c cc0a1c        	jra	L7202
5211  086f               L5402:
5212                     ; 3492         else if (pSocket->ParseState == PARSE_VAL) {
5214  086f a104          	cp	a,#4
5215  0871 26f9          	jrne	L7202
5216                     ; 3559           switch(pSocket->ParseNum)
5218  0873 e609          	ld	a,(9,x)
5220                     ; 3746 	      break;
5221  0875 a110          	cp	a,#16
5222  0877 2407          	jruge	L422
5223  0879 5f            	clrw	x
5224  087a 97            	ld	xl,a
5225  087b 58            	sllw	x
5226  087c de1d09        	ldw	x,(L622,x)
5227  087f fc            	jp	(x)
5228  0880               L422:
5229  0880 a037          	sub	a,#55
5230  0882 2603cc0974    	jreq	L7311
5231  0887 4a            	dec	a
5232  0888 2603cc097f    	jreq	L1411
5233  088d a004          	sub	a,#4
5234  088f 2603cc0989    	jreq	L3411
5235  0894 4a            	dec	a
5236  0895 2603cc0998    	jreq	L5411
5237  089a a004          	sub	a,#4
5238  089c 2603cc09a8    	jreq	L7411
5239  08a1 4a            	dec	a
5240  08a2 2603cc09b3    	jreq	L1511
5241  08a7 4a            	dec	a
5242  08a8 2603cc09c6    	jreq	L3511
5243  08ad a018          	sub	a,#24
5244  08af 2603cc09db    	jreq	L5511
5245  08b4 a007          	sub	a,#7
5246  08b6 2603cc09e1    	jreq	L7511
5247  08bb 4a            	dec	a
5248  08bc 2603cc09f1    	jreq	L1611
5249  08c1 cc0a01        	jra	L3611
5250  08c4               L7701:
5251                     ; 3609 	    case 0:  IO_8to1 &= (uint8_t)(~0x01);  parse_complete = 1; break; // Relay-01 OFF
5253  08c4 72110000      	bres	_IO_8to1,#0
5256  08c8 35010000      	mov	_parse_complete,#1
5259  08cc cc0a18        	jra	L1602
5260  08cf               L1011:
5261                     ; 3610 	    case 1:  IO_8to1 |= (uint8_t)0x01;     parse_complete = 1; break; // Relay-01 ON
5263  08cf 72100000      	bset	_IO_8to1,#0
5266  08d3 35010000      	mov	_parse_complete,#1
5269  08d7 cc0a18        	jra	L1602
5270  08da               L3011:
5271                     ; 3611 	    case 2:  IO_8to1 &= (uint8_t)(~0x02);  parse_complete = 1; break; // Relay-02 OFF
5273  08da 72130000      	bres	_IO_8to1,#1
5276  08de 35010000      	mov	_parse_complete,#1
5279  08e2 cc0a18        	jra	L1602
5280  08e5               L5011:
5281                     ; 3612 	    case 3:  IO_8to1 |= (uint8_t)0x02;     parse_complete = 1; break; // Relay-02 ON
5283  08e5 72120000      	bset	_IO_8to1,#1
5286  08e9 35010000      	mov	_parse_complete,#1
5289  08ed cc0a18        	jra	L1602
5290  08f0               L7011:
5291                     ; 3613 	    case 4:  IO_8to1 &= (uint8_t)(~0x04);  parse_complete = 1; break; // Relay-03 OFF
5293  08f0 72150000      	bres	_IO_8to1,#2
5296  08f4 35010000      	mov	_parse_complete,#1
5299  08f8 cc0a18        	jra	L1602
5300  08fb               L1111:
5301                     ; 3614 	    case 5:  IO_8to1 |= (uint8_t)0x04;     parse_complete = 1; break; // Relay-03 ON
5303  08fb 72140000      	bset	_IO_8to1,#2
5306  08ff 35010000      	mov	_parse_complete,#1
5309  0903 cc0a18        	jra	L1602
5310  0906               L3111:
5311                     ; 3615 	    case 6:  IO_8to1 &= (uint8_t)(~0x08);  parse_complete = 1; break; // Relay-04 OFF
5313  0906 72170000      	bres	_IO_8to1,#3
5316  090a 35010000      	mov	_parse_complete,#1
5319  090e cc0a18        	jra	L1602
5320  0911               L5111:
5321                     ; 3616 	    case 7:  IO_8to1 |= (uint8_t)0x08;     parse_complete = 1; break; // Relay-04 ON
5323  0911 72160000      	bset	_IO_8to1,#3
5326  0915 35010000      	mov	_parse_complete,#1
5329  0919 cc0a18        	jra	L1602
5330  091c               L7111:
5331                     ; 3617 	    case 8:  IO_8to1 &= (uint8_t)(~0x10);  parse_complete = 1; break; // Relay-05 OFF
5333  091c 72190000      	bres	_IO_8to1,#4
5336  0920 35010000      	mov	_parse_complete,#1
5339  0924 cc0a18        	jra	L1602
5340  0927               L1211:
5341                     ; 3618 	    case 9:  IO_8to1 |= (uint8_t)0x10;     parse_complete = 1; break; // Relay-05 ON
5343  0927 72180000      	bset	_IO_8to1,#4
5346  092b 35010000      	mov	_parse_complete,#1
5349  092f cc0a18        	jra	L1602
5350  0932               L3211:
5351                     ; 3619 	    case 10: IO_8to1 &= (uint8_t)(~0x20);  parse_complete = 1; break; // Relay-06 OFF
5353  0932 721b0000      	bres	_IO_8to1,#5
5356  0936 35010000      	mov	_parse_complete,#1
5359  093a cc0a18        	jra	L1602
5360  093d               L5211:
5361                     ; 3620 	    case 11: IO_8to1 |= (uint8_t)0x20;     parse_complete = 1; break; // Relay-06 ON
5363  093d 721a0000      	bset	_IO_8to1,#5
5366  0941 35010000      	mov	_parse_complete,#1
5369  0945 cc0a18        	jra	L1602
5370  0948               L7211:
5371                     ; 3621 	    case 12: IO_8to1 &= (uint8_t)(~0x40);  parse_complete = 1; break; // Relay-07 OFF
5373  0948 721d0000      	bres	_IO_8to1,#6
5376  094c 35010000      	mov	_parse_complete,#1
5379  0950 cc0a18        	jra	L1602
5380  0953               L1311:
5381                     ; 3622 	    case 13: IO_8to1 |= (uint8_t)0x40;     parse_complete = 1; break; // Relay-07 ON
5383  0953 721c0000      	bset	_IO_8to1,#6
5386  0957 35010000      	mov	_parse_complete,#1
5389  095b cc0a18        	jra	L1602
5390  095e               L3311:
5391                     ; 3623 	    case 14: IO_8to1 &= (uint8_t)(~0x80);  parse_complete = 1; break; // Relay-08 OFF
5393  095e 721f0000      	bres	_IO_8to1,#7
5396  0962 35010000      	mov	_parse_complete,#1
5399  0966 cc0a18        	jra	L1602
5400  0969               L5311:
5401                     ; 3624 	    case 15: IO_8to1 |= (uint8_t)0x80;     parse_complete = 1; break; // Relay-08 ON
5403  0969 721e0000      	bset	_IO_8to1,#7
5406  096d 35010000      	mov	_parse_complete,#1
5409  0971 cc0a18        	jra	L1602
5410  0974               L7311:
5411                     ; 3626 	    case 55:
5411                     ; 3627   	      IO_8to1 = (uint8_t)0xff; // Relays 1-8 ON
5413  0974 35ff0000      	mov	_IO_8to1,#255
5414                     ; 3628 	      parse_complete = 1; 
5416  0978 35010000      	mov	_parse_complete,#1
5417                     ; 3629 	      break;
5419  097c cc0a18        	jra	L1602
5420  097f               L1411:
5421                     ; 3631 	    case 56:
5421                     ; 3632               IO_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
5423  097f c70000        	ld	_IO_8to1,a
5424                     ; 3633 	      parse_complete = 1; 
5426  0982 35010000      	mov	_parse_complete,#1
5427                     ; 3634 	      break;
5429  0986 cc0a18        	jra	L1602
5430  0989               L3411:
5431                     ; 3641 	    case 60: // Show IO Control page
5431                     ; 3642 	      current_webpage = WEBPAGE_IOCONTROL;
5433  0989 c70003        	ld	_current_webpage,a
5434                     ; 3643               pSocket->pData = g_HtmlPageIOControl;
5436  098c 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5437  0990 ef01          	ldw	(1,x),y
5438                     ; 3644               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5440  0992 90ae0c06      	ldw	y,#3078
5441                     ; 3645               pSocket->nState = STATE_CONNECTED;
5442                     ; 3646               pSocket->nPrevBytes = 0xFFFF;
5443                     ; 3647 	      break;
5445  0996 2029          	jp	LC021
5446  0998               L5411:
5447                     ; 3649 	    case 61: // Show Configuration page
5447                     ; 3650 	      current_webpage = WEBPAGE_CONFIGURATION;
5449  0998 35010003      	mov	_current_webpage,#1
5450                     ; 3651               pSocket->pData = g_HtmlPageConfiguration;
5452  099c 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
5453  09a0 ef01          	ldw	(1,x),y
5454                     ; 3652               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
5456  09a2 90ae0c5c      	ldw	y,#3164
5457                     ; 3653               pSocket->nState = STATE_CONNECTED;
5458                     ; 3654               pSocket->nPrevBytes = 0xFFFF;
5459                     ; 3655 	      break;
5461  09a6 2019          	jp	LC021
5462  09a8               L7411:
5463                     ; 3675 	    case 65: // Flash LED for diagnostics
5463                     ; 3676 	      // XXXXXXXXXXXXXXXXXXXXXX
5463                     ; 3677 	      // XXXXXXXXXXXXXXXXXXXXXX
5463                     ; 3678 	      // XXXXXXXXXXXXXXXXXXXXXX
5463                     ; 3679 	      debugflash();
5465  09a8 cd0000        	call	_debugflash
5467                     ; 3680 	      debugflash();
5469  09ab cd0000        	call	_debugflash
5471                     ; 3681 	      debugflash();
5473  09ae cd0000        	call	_debugflash
5475                     ; 3685 	      break;
5477  09b1 2065          	jra	L1602
5478  09b3               L1511:
5479                     ; 3688             case 66: // Show statistics page
5479                     ; 3689 	      current_webpage = WEBPAGE_STATS;
5481  09b3 35050003      	mov	_current_webpage,#5
5482                     ; 3690               pSocket->pData = g_HtmlPageStats;
5484  09b7 90ae186c      	ldw	y,#L71_g_HtmlPageStats
5485  09bb ef01          	ldw	(1,x),y
5486                     ; 3691               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
5488  09bd 90ae0175      	ldw	y,#373
5489                     ; 3692               pSocket->nState = STATE_CONNECTED;
5491  09c1               LC021:
5492  09c1 ef03          	ldw	(3,x),y
5497  09c3 f7            	ld	(x),a
5498                     ; 3693               pSocket->nPrevBytes = 0xFFFF;
5499                     ; 3694 	      break;
5501  09c4 204c          	jp	LC019
5502  09c6               L3511:
5503                     ; 3696             case 67: // Clear statistics
5503                     ; 3697 	      uip_init_stats();
5505  09c6 cd0000        	call	_uip_init_stats
5507                     ; 3712 	      current_webpage = WEBPAGE_STATS;
5509  09c9 35050003      	mov	_current_webpage,#5
5510                     ; 3713               pSocket->pData = g_HtmlPageStats;
5512  09cd 1e0b          	ldw	x,(OFST+7,sp)
5513  09cf 90ae186c      	ldw	y,#L71_g_HtmlPageStats
5514  09d3 ef01          	ldw	(1,x),y
5515                     ; 3714               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
5517  09d5 90ae0175      	ldw	y,#373
5518                     ; 3715               pSocket->nState = STATE_CONNECTED;
5519                     ; 3716               pSocket->nPrevBytes = 0xFFFF;
5520                     ; 3717 	      break;
5522  09d9 2034          	jp	LC020
5523  09db               L5511:
5524                     ; 3720 	    case 91: // Reboot
5524                     ; 3721 	      user_reboot_request = 1;
5526  09db 35010000      	mov	_user_reboot_request,#1
5527                     ; 3722 	      break;
5529  09df 2037          	jra	L1602
5530  09e1               L7511:
5531                     ; 3724             case 98: // Show Very Short Form IO state page
5531                     ; 3725 	      current_webpage = WEBPAGE_SSTATE;
5533  09e1 35070003      	mov	_current_webpage,#7
5534                     ; 3726               pSocket->pData = g_HtmlPageSstate;
5536  09e5 90ae1a69      	ldw	y,#L32_g_HtmlPageSstate
5537  09e9 ef01          	ldw	(1,x),y
5538                     ; 3727               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageSstate) - 1);
5540  09eb 90ae0004      	ldw	y,#4
5541                     ; 3728               pSocket->nState = STATE_CONNECTED;
5542                     ; 3729               pSocket->nPrevBytes = 0xFFFF;
5543                     ; 3730 	      break;
5545  09ef 20d0          	jp	LC021
5546  09f1               L1611:
5547                     ; 3732             case 99: // Show Short Form IO state page
5547                     ; 3733 	      current_webpage = WEBPAGE_RSTATE;
5549  09f1 35060003      	mov	_current_webpage,#6
5550                     ; 3734               pSocket->pData = g_HtmlPageRstate;
5552  09f5 90ae19e2      	ldw	y,#L12_g_HtmlPageRstate
5553  09f9 ef01          	ldw	(1,x),y
5554                     ; 3735               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
5556  09fb 90ae0086      	ldw	y,#134
5557                     ; 3736               pSocket->nState = STATE_CONNECTED;
5558                     ; 3737               pSocket->nPrevBytes = 0xFFFF;
5559                     ; 3738 	      break;
5561  09ff 20c0          	jp	LC021
5562  0a01               L3611:
5563                     ; 3740 	    default: // Show IO Control page
5563                     ; 3741 	      current_webpage = WEBPAGE_IOCONTROL;
5565  0a01 725f0003      	clr	_current_webpage
5566                     ; 3742               pSocket->pData = g_HtmlPageIOControl;
5568  0a05 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5569  0a09 ef01          	ldw	(1,x),y
5570                     ; 3743               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5572  0a0b 90ae0c06      	ldw	y,#3078
5573                     ; 3744               pSocket->nState = STATE_CONNECTED;
5575  0a0f               LC020:
5576  0a0f ef03          	ldw	(3,x),y
5578  0a11 7f            	clr	(x)
5579                     ; 3745               pSocket->nPrevBytes = 0xFFFF;
5581  0a12               LC019:
5588  0a12 90aeffff      	ldw	y,#65535
5589  0a16 ef0b          	ldw	(11,x),y
5590                     ; 3746 	      break;
5592  0a18               L1602:
5593                     ; 3748           pSocket->nParseLeft = 0;
5595  0a18 1e0b          	ldw	x,(OFST+7,sp)
5596  0a1a 6f06          	clr	(6,x)
5597  0a1c               L7202:
5598                     ; 3751         if (pSocket->ParseState == PARSE_FAIL) {
5600  0a1c 1e0b          	ldw	x,(OFST+7,sp)
5601  0a1e e60a          	ld	a,(10,x)
5602  0a20 a107          	cp	a,#7
5603                     ; 3756           pSocket->nState = STATE_SENDHEADER;
5604                     ; 3757 	  break;
5606  0a22 2704          	jreq	LC025
5607                     ; 3760         if (pSocket->nParseLeft == 0) {
5609  0a24 e606          	ld	a,(6,x)
5610  0a26 2605          	jrne	L5102
5611                     ; 3763           pSocket->nState = STATE_SENDHEADER;
5613  0a28               LC025:
5615  0a28 a60b          	ld	a,#11
5616  0a2a f7            	ld	(x),a
5617                     ; 3764           break;
5619  0a2b 2007          	jra	L1102
5620  0a2d               L5102:
5621                     ; 3419       while (nBytes != 0) {
5623  0a2d 1e09          	ldw	x,(OFST+5,sp)
5624  0a2f 2703cc07ac    	jrne	L3102
5625  0a34               L1102:
5626                     ; 3769     if (pSocket->nState == STATE_SENDHEADER) {
5628  0a34 1e0b          	ldw	x,(OFST+7,sp)
5629  0a36 f6            	ld	a,(x)
5630  0a37 a10b          	cp	a,#11
5631  0a39 261c          	jrne	L5611
5632                     ; 3775       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5634  0a3b cd0000        	call	_adjust_template_size
5636  0a3e 89            	pushw	x
5637  0a3f ce0000        	ldw	x,_uip_appdata
5638  0a42 cd0000        	call	L5_CopyHttpHeader
5640  0a45 5b02          	addw	sp,#2
5641  0a47 89            	pushw	x
5642  0a48 ce0000        	ldw	x,_uip_appdata
5643  0a4b cd0000        	call	_uip_send
5645  0a4e 85            	popw	x
5646                     ; 3776       pSocket->nState = STATE_SENDDATA;
5648  0a4f 1e0b          	ldw	x,(OFST+7,sp)
5649  0a51 a60c          	ld	a,#12
5650  0a53 f7            	ld	(x),a
5651                     ; 3777       return;
5653  0a54 cc0141        	jra	L452
5654  0a57               L5611:
5655                     ; 3780     senddata:
5655                     ; 3781     if (pSocket->nState == STATE_SENDDATA) {
5657  0a57 1e0b          	ldw	x,(OFST+7,sp)
5658  0a59 f6            	ld	a,(x)
5659  0a5a a10c          	cp	a,#12
5660  0a5c 26f6          	jrne	L452
5661                     ; 3788       if (pSocket->nDataLeft == 0) {
5663  0a5e e604          	ld	a,(4,x)
5664  0a60 ea03          	or	a,(3,x)
5665  0a62 2605          	jrne	L3702
5666                     ; 3790         nBufSize = 0;
5668  0a64 5f            	clrw	x
5669  0a65 1f02          	ldw	(OFST-2,sp),x
5672  0a67 202f          	jra	L5702
5673  0a69               L3702:
5674                     ; 3793         pSocket->nPrevBytes = pSocket->nDataLeft;
5676  0a69 9093          	ldw	y,x
5677  0a6b 90ee03        	ldw	y,(3,y)
5678  0a6e ef0b          	ldw	(11,x),y
5679                     ; 3794         nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5681  0a70 ce0000        	ldw	x,_uip_conn
5682  0a73 ee12          	ldw	x,(18,x)
5683  0a75 89            	pushw	x
5684  0a76 1e0d          	ldw	x,(OFST+9,sp)
5685  0a78 1c0003        	addw	x,#3
5686  0a7b 89            	pushw	x
5687  0a7c 1e0f          	ldw	x,(OFST+11,sp)
5688  0a7e 5c            	incw	x
5689  0a7f 89            	pushw	x
5690  0a80 ce0000        	ldw	x,_uip_appdata
5691  0a83 cd0000        	call	L7_CopyHttpData
5693  0a86 5b06          	addw	sp,#6
5694  0a88 1f02          	ldw	(OFST-2,sp),x
5696                     ; 3795         pSocket->nPrevBytes -= pSocket->nDataLeft;
5698  0a8a 1e0b          	ldw	x,(OFST+7,sp)
5699  0a8c e60c          	ld	a,(12,x)
5700  0a8e e004          	sub	a,(4,x)
5701  0a90 e70c          	ld	(12,x),a
5702  0a92 e60b          	ld	a,(11,x)
5703  0a94 e203          	sbc	a,(3,x)
5704  0a96 e70b          	ld	(11,x),a
5705  0a98               L5702:
5706                     ; 3798       if (nBufSize == 0) {
5708  0a98 1e02          	ldw	x,(OFST-2,sp)
5709  0a9a 2621          	jrne	LC016
5710                     ; 3800         uip_close();
5712  0a9c               LC017:
5714  0a9c 35100000      	mov	_uip_flags,#16
5716  0aa0 cc0141        	jra	L452
5717                     ; 3804         uip_send(uip_appdata, nBufSize);
5719                     ; 3806       return;
5721  0aa3               L3031:
5722                     ; 3810   else if (uip_rexmit()) {
5724  0aa3 7205000075    	btjf	_uip_flags,#2,L1031
5725                     ; 3811     if (pSocket->nPrevBytes == 0xFFFF) {
5727  0aa8 160b          	ldw	y,(OFST+7,sp)
5728  0aaa 90ee0b        	ldw	y,(11,y)
5729  0aad 905c          	incw	y
5730  0aaf 2617          	jrne	L7012
5731                     ; 3813       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5733  0ab1 cd0000        	call	_adjust_template_size
5735  0ab4 89            	pushw	x
5736  0ab5 ce0000        	ldw	x,_uip_appdata
5737  0ab8 cd0000        	call	L5_CopyHttpHeader
5739  0abb 5b02          	addw	sp,#2
5741  0abd               LC016:
5743  0abd 89            	pushw	x
5744  0abe ce0000        	ldw	x,_uip_appdata
5745  0ac1 cd0000        	call	_uip_send
5746  0ac4 85            	popw	x
5748  0ac5 cc0141        	jra	L452
5749  0ac8               L7012:
5750                     ; 3816       pSocket->pData -= pSocket->nPrevBytes;
5752  0ac8 1e0b          	ldw	x,(OFST+7,sp)
5753  0aca e602          	ld	a,(2,x)
5754  0acc e00c          	sub	a,(12,x)
5755  0ace e702          	ld	(2,x),a
5756  0ad0 e601          	ld	a,(1,x)
5757  0ad2 e20b          	sbc	a,(11,x)
5758  0ad4 e701          	ld	(1,x),a
5759                     ; 3817       pSocket->nDataLeft += pSocket->nPrevBytes;
5761  0ad6 e604          	ld	a,(4,x)
5762  0ad8 eb0c          	add	a,(12,x)
5763  0ada e704          	ld	(4,x),a
5764  0adc e603          	ld	a,(3,x)
5765  0ade e90b          	adc	a,(11,x)
5766                     ; 3818       pSocket->nPrevBytes = pSocket->nDataLeft;
5768  0ae0 9093          	ldw	y,x
5769  0ae2 e703          	ld	(3,x),a
5770  0ae4 90ee03        	ldw	y,(3,y)
5771  0ae7 ef0b          	ldw	(11,x),y
5772                     ; 3819       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5774  0ae9 ce0000        	ldw	x,_uip_conn
5775  0aec ee12          	ldw	x,(18,x)
5776  0aee 89            	pushw	x
5777  0aef 1e0d          	ldw	x,(OFST+9,sp)
5778  0af1 1c0003        	addw	x,#3
5779  0af4 89            	pushw	x
5780  0af5 1e0f          	ldw	x,(OFST+11,sp)
5781  0af7 5c            	incw	x
5782  0af8 89            	pushw	x
5783  0af9 ce0000        	ldw	x,_uip_appdata
5784  0afc cd0000        	call	L7_CopyHttpData
5786  0aff 5b06          	addw	sp,#6
5787  0b01 1f02          	ldw	(OFST-2,sp),x
5789                     ; 3820       pSocket->nPrevBytes -= pSocket->nDataLeft;
5791  0b03 1e0b          	ldw	x,(OFST+7,sp)
5792  0b05 e60c          	ld	a,(12,x)
5793  0b07 e004          	sub	a,(4,x)
5794  0b09 e70c          	ld	(12,x),a
5795  0b0b e60b          	ld	a,(11,x)
5796  0b0d e203          	sbc	a,(3,x)
5797  0b0f e70b          	ld	(11,x),a
5798                     ; 3821       if (nBufSize == 0) {
5800  0b11 1e02          	ldw	x,(OFST-2,sp)
5801                     ; 3823         uip_close();
5803  0b13 2787          	jreq	LC017
5804                     ; 3827         uip_send(uip_appdata, nBufSize);
5806  0b15 89            	pushw	x
5807  0b16 ce0000        	ldw	x,_uip_appdata
5808  0b19 cd0000        	call	_uip_send
5810  0b1c 85            	popw	x
5811                     ; 3830     return;
5813  0b1d               L1031:
5814                     ; 3832 }
5816  0b1d cc0141        	jra	L452
5850                     ; 3835 void clear_saved_postpartial_all(void)
5850                     ; 3836 {
5851                     .text:	section	.text,new
5852  0000               _clear_saved_postpartial_all:
5854  0000 88            	push	a
5855       00000001      OFST:	set	1
5858                     ; 3838   for (i=0; i<24; i++) saved_postpartial[i] = '\0';
5860  0001 4f            	clr	a
5861  0002 6b01          	ld	(OFST+0,sp),a
5863  0004               L3312:
5866  0004 5f            	clrw	x
5867  0005 97            	ld	xl,a
5868  0006 724f002a      	clr	(_saved_postpartial,x)
5871  000a 0c01          	inc	(OFST+0,sp)
5875  000c 7b01          	ld	a,(OFST+0,sp)
5876  000e a118          	cp	a,#24
5877  0010 25f2          	jrult	L3312
5878                     ; 3839 }
5881  0012 84            	pop	a
5882  0013 81            	ret	
5916                     ; 3842 void clear_saved_postpartial_data(void)
5916                     ; 3843 {
5917                     .text:	section	.text,new
5918  0000               _clear_saved_postpartial_data:
5920  0000 88            	push	a
5921       00000001      OFST:	set	1
5924                     ; 3845   for (i=4; i<24; i++) saved_postpartial[i] = '\0';
5926  0001 a604          	ld	a,#4
5927  0003 6b01          	ld	(OFST+0,sp),a
5929  0005               L5512:
5932  0005 5f            	clrw	x
5933  0006 97            	ld	xl,a
5934  0007 724f002a      	clr	(_saved_postpartial,x)
5937  000b 0c01          	inc	(OFST+0,sp)
5941  000d 7b01          	ld	a,(OFST+0,sp)
5942  000f a118          	cp	a,#24
5943  0011 25f2          	jrult	L5512
5944                     ; 3846 }
5947  0013 84            	pop	a
5948  0014 81            	ret	
5982                     ; 3849 void clear_saved_postpartial_previous(void)
5982                     ; 3850 {
5983                     .text:	section	.text,new
5984  0000               _clear_saved_postpartial_previous:
5986  0000 88            	push	a
5987       00000001      OFST:	set	1
5990                     ; 3852   for (i=0; i<24; i++) saved_postpartial_previous[i] = '\0';
5992  0001 4f            	clr	a
5993  0002 6b01          	ld	(OFST+0,sp),a
5995  0004               L7712:
5998  0004 5f            	clrw	x
5999  0005 97            	ld	xl,a
6000  0006 724f0012      	clr	(_saved_postpartial_previous,x)
6003  000a 0c01          	inc	(OFST+0,sp)
6007  000c 7b01          	ld	a,(OFST+0,sp)
6008  000e a118          	cp	a,#24
6009  0010 25f2          	jrult	L7712
6010                     ; 3853 }
6013  0012 84            	pop	a
6014  0013 81            	ret	
6104                     ; 3856 void parse_POST_string(uint8_t curr_ParseCmd, uint8_t num_chars)
6104                     ; 3857 {
6105                     .text:	section	.text,new
6106  0000               _parse_POST_string:
6108  0000 89            	pushw	x
6109  0001 5217          	subw	sp,#23
6110       00000017      OFST:	set	23
6113                     ; 3880   amp_found = 0;
6115  0003 0f02          	clr	(OFST-21,sp)
6117                     ; 3881   for (i=0; i<20; i++) tmp_Pending[i] = '\0';
6119  0005 0f17          	clr	(OFST+0,sp)
6121  0007               L7322:
6124  0007 96            	ldw	x,sp
6125  0008 1c0003        	addw	x,#OFST-20
6126  000b 9f            	ld	a,xl
6127  000c 5e            	swapw	x
6128  000d 1b17          	add	a,(OFST+0,sp)
6129  000f 2401          	jrnc	L662
6130  0011 5c            	incw	x
6131  0012               L662:
6132  0012 02            	rlwa	x,a
6133  0013 7f            	clr	(x)
6136  0014 0c17          	inc	(OFST+0,sp)
6140  0016 7b17          	ld	a,(OFST+0,sp)
6141  0018 a114          	cp	a,#20
6142  001a 25eb          	jrult	L7322
6143                     ; 3883   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6145  001c c60012        	ld	a,_saved_postpartial_previous
6146  001f 1118          	cp	a,(OFST+1,sp)
6147  0021 260a          	jrne	L5422
6148                     ; 3886     saved_postpartial_previous[0] = '\0';
6150  0023 725f0012      	clr	_saved_postpartial_previous
6151                     ; 3892     frag_flag = 1; // frag_flag is used to manage the TCP Fragment restore
6153  0027 a601          	ld	a,#1
6154  0029 6b17          	ld	(OFST+0,sp),a
6157  002b 2005          	jra	L7422
6158  002d               L5422:
6159                     ; 3896     frag_flag = 0;
6161  002d 0f17          	clr	(OFST+0,sp)
6163                     ; 3900     clear_saved_postpartial_data(); // Clear [4] and higher
6165  002f cd0000        	call	_clear_saved_postpartial_data
6167  0032               L7422:
6168                     ; 3921   resume = 0;
6170  0032 0f01          	clr	(OFST-22,sp)
6172                     ; 3922   if (frag_flag == 1) {
6174  0034 7b17          	ld	a,(OFST+0,sp)
6175  0036 4a            	dec	a
6176  0037 263f          	jrne	L1522
6177                     ; 3924     for (i = 0; i < num_chars; i++) {
6179  0039 6b17          	ld	(OFST+0,sp),a
6182  003b 2033          	jra	L7522
6183  003d               L3522:
6184                     ; 3933       if (saved_postpartial_previous[4+i] != '\0') {
6186  003d 5f            	clrw	x
6187  003e 97            	ld	xl,a
6188  003f 724d0016      	tnz	(_saved_postpartial_previous+4,x)
6189  0043 271b          	jreq	L3622
6190                     ; 3934         tmp_Pending[i] = saved_postpartial_previous[4+i];
6192  0045 96            	ldw	x,sp
6193  0046 1c0003        	addw	x,#OFST-20
6194  0049 9f            	ld	a,xl
6195  004a 5e            	swapw	x
6196  004b 1b17          	add	a,(OFST+0,sp)
6197  004d 2401          	jrnc	L272
6198  004f 5c            	incw	x
6199  0050               L272:
6200  0050 02            	rlwa	x,a
6201  0051 7b17          	ld	a,(OFST+0,sp)
6202  0053 905f          	clrw	y
6203  0055 9097          	ld	yl,a
6204  0057 90d60016      	ld	a,(_saved_postpartial_previous+4,y)
6205  005b f7            	ld	(x),a
6207                     ; 3924     for (i = 0; i < num_chars; i++) {
6209  005c 0c17          	inc	(OFST+0,sp)
6211  005e 2010          	jra	L7522
6212  0060               L3622:
6213                     ; 3937         resume = i;
6215  0060 6b01          	ld	(OFST-22,sp),a
6217                     ; 3938         break;
6218  0062               L1622:
6219                     ; 3941     if (*tmp_pBuffer == '&') {
6221  0062 72c6000e      	ld	a,[_tmp_pBuffer.w]
6222  0066 a126          	cp	a,#38
6223  0068 260e          	jrne	L1522
6224                     ; 3945       amp_found = 1;
6226  006a a601          	ld	a,#1
6227  006c 6b02          	ld	(OFST-21,sp),a
6229  006e 2008          	jra	L1522
6230  0070               L7522:
6231                     ; 3924     for (i = 0; i < num_chars; i++) {
6233  0070 7b17          	ld	a,(OFST+0,sp)
6234  0072 1119          	cp	a,(OFST+2,sp)
6235  0074 25c7          	jrult	L3522
6236  0076 20ea          	jra	L1622
6237  0078               L1522:
6238                     ; 3957   if (amp_found == 0) {
6240  0078 7b02          	ld	a,(OFST-21,sp)
6241  007a 2703cc0104    	jrne	L1722
6242                     ; 3958     for (i = resume; i < num_chars; i++) {
6244  007f 7b01          	ld	a,(OFST-22,sp)
6245  0081 6b17          	ld	(OFST+0,sp),a
6248  0083 207b          	jra	L7722
6249  0085               L3722:
6250                     ; 3961       if (amp_found == 0) {
6252  0085 7b02          	ld	a,(OFST-21,sp)
6253  0087 265d          	jrne	L3032
6254                     ; 3964         if (*tmp_pBuffer == '&') {
6256  0089 72c6000e      	ld	a,[_tmp_pBuffer.w]
6257  008d a126          	cp	a,#38
6258  008f 2606          	jrne	L5032
6259                     ; 3967           amp_found = 1;
6261  0091 a601          	ld	a,#1
6262  0093 6b02          	ld	(OFST-21,sp),a
6265  0095 204f          	jra	L3032
6266  0097               L5032:
6267                     ; 3970           tmp_Pending[i] = *tmp_pBuffer;
6269  0097 96            	ldw	x,sp
6270  0098 1c0003        	addw	x,#OFST-20
6271  009b 9f            	ld	a,xl
6272  009c 5e            	swapw	x
6273  009d 1b17          	add	a,(OFST+0,sp)
6274  009f 2401          	jrnc	L472
6275  00a1 5c            	incw	x
6276  00a2               L472:
6277  00a2 90ce000e      	ldw	y,_tmp_pBuffer
6278  00a6 02            	rlwa	x,a
6279  00a7 90f6          	ld	a,(y)
6280  00a9 f7            	ld	(x),a
6281                     ; 3971           saved_postpartial[4+i] = *tmp_pBuffer;
6283  00aa 5f            	clrw	x
6284  00ab 7b17          	ld	a,(OFST+0,sp)
6285  00ad 97            	ld	xl,a
6286  00ae 90f6          	ld	a,(y)
6287  00b0 d7002e        	ld	(_saved_postpartial+4,x),a
6288                     ; 3972           tmp_nParseLeft--;
6290  00b3 725a000b      	dec	_tmp_nParseLeft
6291                     ; 3973           saved_nparseleft = tmp_nParseLeft;
6293                     ; 3974           tmp_pBuffer++;
6295  00b7 93            	ldw	x,y
6296  00b8 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6297  00bd 5c            	incw	x
6298  00be cf000e        	ldw	_tmp_pBuffer,x
6299                     ; 3975           tmp_nBytes--;
6301  00c1 ce000c        	ldw	x,_tmp_nBytes
6302  00c4 5a            	decw	x
6303  00c5 cf000c        	ldw	_tmp_nBytes,x
6304                     ; 3976           if (tmp_nBytes == 0) {
6306  00c8 261c          	jrne	L3032
6307                     ; 3980             if (i == (num_chars - 1)) {
6309  00ca 7b19          	ld	a,(OFST+2,sp)
6310  00cc 5f            	clrw	x
6311  00cd 97            	ld	xl,a
6312  00ce 5a            	decw	x
6313  00cf 7b17          	ld	a,(OFST+0,sp)
6314  00d1 905f          	clrw	y
6315  00d3 9097          	ld	yl,a
6316  00d5 90bf00        	ldw	c_y,y
6317  00d8 b300          	cpw	x,c_y
6318  00da 2604          	jrne	L3132
6319                     ; 3985               saved_parsestate = PARSE_DELIM;
6321  00dc 35050043      	mov	_saved_parsestate,#5
6322  00e0               L3132:
6323                     ; 3987             break_while = 1;
6325  00e0 3501000a      	mov	_break_while,#1
6326                     ; 3988             break; // This will break the for() loop. But we need to break the
6328  00e4 201e          	jra	L1722
6329  00e6               L3032:
6330                     ; 3994       if (amp_found == 1) {
6332  00e6 7b02          	ld	a,(OFST-21,sp)
6333  00e8 4a            	dec	a
6334  00e9 2611          	jrne	L5132
6335                     ; 3997         tmp_Pending[i] = '\0';
6337  00eb 96            	ldw	x,sp
6338  00ec 1c0003        	addw	x,#OFST-20
6339  00ef 9f            	ld	a,xl
6340  00f0 5e            	swapw	x
6341  00f1 1b17          	add	a,(OFST+0,sp)
6342  00f3 2401          	jrnc	L672
6343  00f5 5c            	incw	x
6344  00f6               L672:
6345  00f6 02            	rlwa	x,a
6346  00f7 7f            	clr	(x)
6347                     ; 4006         tmp_nParseLeft--;
6349  00f8 725a000b      	dec	_tmp_nParseLeft
6350  00fc               L5132:
6351                     ; 3958     for (i = resume; i < num_chars; i++) {
6353  00fc 0c17          	inc	(OFST+0,sp)
6355  00fe 7b17          	ld	a,(OFST+0,sp)
6356  0100               L7722:
6359  0100 1119          	cp	a,(OFST+2,sp)
6360  0102 2581          	jrult	L3722
6361  0104               L1722:
6362                     ; 4027   if (break_while == 0) clear_saved_postpartial_all();
6364  0104 c6000a        	ld	a,_break_while
6365  0107 2603          	jrne	L7132
6368  0109 cd0000        	call	_clear_saved_postpartial_all
6370  010c               L7132:
6371                     ; 4030   if (curr_ParseCmd == 'a') {
6373  010c 7b18          	ld	a,(OFST+1,sp)
6374  010e a161          	cp	a,#97
6375  0110 2622          	jrne	L1232
6376                     ; 4031     for (i=0; i<num_chars; i++) Pending_devicename[i] = tmp_Pending[i];
6378  0112 0f17          	clr	(OFST+0,sp)
6381  0114 2016          	jra	L7232
6382  0116               L3232:
6385  0116 5f            	clrw	x
6386  0117 97            	ld	xl,a
6387  0118 89            	pushw	x
6388  0119 96            	ldw	x,sp
6389  011a 1c0005        	addw	x,#OFST-18
6390  011d 9f            	ld	a,xl
6391  011e 5e            	swapw	x
6392  011f 1b19          	add	a,(OFST+2,sp)
6393  0121 2401          	jrnc	L203
6394  0123 5c            	incw	x
6395  0124               L203:
6396  0124 02            	rlwa	x,a
6397  0125 f6            	ld	a,(x)
6398  0126 85            	popw	x
6399  0127 d70000        	ld	(_Pending_devicename,x),a
6402  012a 0c17          	inc	(OFST+0,sp)
6404  012c               L7232:
6407  012c 7b17          	ld	a,(OFST+0,sp)
6408  012e 1119          	cp	a,(OFST+2,sp)
6409  0130 25e4          	jrult	L3232
6411  0132 204a          	jra	L3332
6412  0134               L1232:
6413                     ; 4036   else if (curr_ParseCmd == 'l') {
6415  0134 a16c          	cp	a,#108
6416  0136 2622          	jrne	L5332
6417                     ; 4037     for (i=0; i<num_chars; i++) Pending_mqtt_username[i] = tmp_Pending[i];
6419  0138 0f17          	clr	(OFST+0,sp)
6422  013a 2016          	jra	L3432
6423  013c               L7332:
6426  013c 5f            	clrw	x
6427  013d 97            	ld	xl,a
6428  013e 89            	pushw	x
6429  013f 96            	ldw	x,sp
6430  0140 1c0005        	addw	x,#OFST-18
6431  0143 9f            	ld	a,xl
6432  0144 5e            	swapw	x
6433  0145 1b19          	add	a,(OFST+2,sp)
6434  0147 2401          	jrnc	L403
6435  0149 5c            	incw	x
6436  014a               L403:
6437  014a 02            	rlwa	x,a
6438  014b f6            	ld	a,(x)
6439  014c 85            	popw	x
6440  014d d70000        	ld	(_Pending_mqtt_username,x),a
6443  0150 0c17          	inc	(OFST+0,sp)
6445  0152               L3432:
6448  0152 7b17          	ld	a,(OFST+0,sp)
6449  0154 1119          	cp	a,(OFST+2,sp)
6450  0156 25e4          	jrult	L7332
6452  0158 2024          	jra	L3332
6453  015a               L5332:
6454                     ; 4041   else if (curr_ParseCmd == 'm') {
6456  015a a16d          	cp	a,#109
6457  015c 2620          	jrne	L3332
6458                     ; 4042     for (i=0; i<num_chars; i++) Pending_mqtt_password[i] = tmp_Pending[i];
6460  015e 0f17          	clr	(OFST+0,sp)
6463  0160 2016          	jra	L7532
6464  0162               L3532:
6467  0162 5f            	clrw	x
6468  0163 97            	ld	xl,a
6469  0164 89            	pushw	x
6470  0165 96            	ldw	x,sp
6471  0166 1c0005        	addw	x,#OFST-18
6472  0169 9f            	ld	a,xl
6473  016a 5e            	swapw	x
6474  016b 1b19          	add	a,(OFST+2,sp)
6475  016d 2401          	jrnc	L603
6476  016f 5c            	incw	x
6477  0170               L603:
6478  0170 02            	rlwa	x,a
6479  0171 f6            	ld	a,(x)
6480  0172 85            	popw	x
6481  0173 d70000        	ld	(_Pending_mqtt_password,x),a
6484  0176 0c17          	inc	(OFST+0,sp)
6486  0178               L7532:
6489  0178 7b17          	ld	a,(OFST+0,sp)
6490  017a 1119          	cp	a,(OFST+2,sp)
6491  017c 25e4          	jrult	L3532
6492  017e               L3332:
6493                     ; 4045 }
6496  017e 5b19          	addw	sp,#25
6497  0180 81            	ret	
6571                     	switch	.const
6572  1d29               L023:
6573  1d29 00de          	dc.w	L3632
6574  1d2b 00e5          	dc.w	L5632
6575  1d2d 00ec          	dc.w	L7632
6576  1d2f 00f3          	dc.w	L1732
6577  1d31 00fa          	dc.w	L3732
6578  1d33 0101          	dc.w	L5732
6579  1d35 0108          	dc.w	L7732
6580  1d37 010f          	dc.w	L1042
6581  1d39 0116          	dc.w	L3042
6582  1d3b 011d          	dc.w	L5042
6583  1d3d 0124          	dc.w	L7042
6584  1d3f 012b          	dc.w	L1142
6585  1d41 0132          	dc.w	L3142
6586  1d43 0139          	dc.w	L5142
6587  1d45 0140          	dc.w	L7142
6588  1d47 0147          	dc.w	L1242
6589                     ; 4048 void parse_POST_address(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6589                     ; 4049 {
6590                     .text:	section	.text,new
6591  0000               _parse_POST_address:
6593  0000 89            	pushw	x
6594  0001 89            	pushw	x
6595       00000002      OFST:	set	2
6598                     ; 4052   alpha[0] = '-';
6600  0002 352d0004      	mov	_alpha,#45
6601                     ; 4053   alpha[1] = '-';
6603  0006 352d0005      	mov	_alpha+1,#45
6604                     ; 4054   alpha[2] = '-';
6606  000a 352d0006      	mov	_alpha+2,#45
6607                     ; 4057   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6609  000e 9e            	ld	a,xh
6610  000f c10012        	cp	a,_saved_postpartial_previous
6611  0012 2624          	jrne	L1542
6612                     ; 4060     saved_postpartial_previous[0] = '\0';
6614  0014 725f0012      	clr	_saved_postpartial_previous
6615                     ; 4067     if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
6617  0018 c60016        	ld	a,_saved_postpartial_previous+4
6618  001b 2705          	jreq	L3542
6621  001d 5500160004    	mov	_alpha,_saved_postpartial_previous+4
6622  0022               L3542:
6623                     ; 4068     if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
6625  0022 c60017        	ld	a,_saved_postpartial_previous+5
6626  0025 2705          	jreq	L5542
6629  0027 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
6630  002c               L5542:
6631                     ; 4069     if (saved_postpartial_previous[6] != '\0') alpha[2] = saved_postpartial_previous[6];
6633  002c c60018        	ld	a,_saved_postpartial_previous+6
6634  002f 270a          	jreq	L1642
6637  0031 5500180006    	mov	_alpha+2,_saved_postpartial_previous+6
6638  0036 2003          	jra	L1642
6639  0038               L1542:
6640                     ; 4075     clear_saved_postpartial_data(); // Clear [4] and higher
6642  0038 cd0000        	call	_clear_saved_postpartial_data
6644  003b               L1642:
6645                     ; 4078   for (i=0; i<3; i++) {
6647  003b 4f            	clr	a
6648  003c 6b02          	ld	(OFST+0,sp),a
6650  003e               L3642:
6651                     ; 4084     if (alpha[i] == '-') {
6653  003e 5f            	clrw	x
6654  003f 97            	ld	xl,a
6655  0040 d60004        	ld	a,(_alpha,x)
6656  0043 a12d          	cp	a,#45
6657  0045 263c          	jrne	L1742
6658                     ; 4085       alpha[i] = (uint8_t)(*tmp_pBuffer);
6660  0047 7b02          	ld	a,(OFST+0,sp)
6661  0049 5f            	clrw	x
6662  004a 90ce000e      	ldw	y,_tmp_pBuffer
6663  004e 97            	ld	xl,a
6664  004f 90f6          	ld	a,(y)
6665  0051 d70004        	ld	(_alpha,x),a
6666                     ; 4086       saved_postpartial[i+4] = (uint8_t)(*tmp_pBuffer);
6668  0054 5f            	clrw	x
6669  0055 7b02          	ld	a,(OFST+0,sp)
6670  0057 97            	ld	xl,a
6671  0058 90f6          	ld	a,(y)
6672  005a d7002e        	ld	(_saved_postpartial+4,x),a
6673                     ; 4087       tmp_nParseLeft--;
6675  005d 725a000b      	dec	_tmp_nParseLeft
6676                     ; 4088       saved_nparseleft = tmp_nParseLeft;
6678                     ; 4089       tmp_pBuffer++;
6680  0061 93            	ldw	x,y
6681  0062 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6682  0067 5c            	incw	x
6683  0068 cf000e        	ldw	_tmp_pBuffer,x
6684                     ; 4090       tmp_nBytes--;
6686  006b ce000c        	ldw	x,_tmp_nBytes
6687  006e 5a            	decw	x
6688  006f cf000c        	ldw	_tmp_nBytes,x
6689                     ; 4091       if (i != 2 && tmp_nBytes == 0) {
6691  0072 7b02          	ld	a,(OFST+0,sp)
6692  0074 a102          	cp	a,#2
6693  0076 270b          	jreq	L1742
6695  0078 ce000c        	ldw	x,_tmp_nBytes
6696  007b 2606          	jrne	L1742
6697                     ; 4092         break_while = 1; // Hit end of fragment but still have characters to
6699  007d 3501000a      	mov	_break_while,#1
6700                     ; 4096         break; // Break out of for() loop.
6702  0081 2008          	jra	L7642
6703  0083               L1742:
6704                     ; 4078   for (i=0; i<3; i++) {
6706  0083 0c02          	inc	(OFST+0,sp)
6710  0085 7b02          	ld	a,(OFST+0,sp)
6711  0087 a103          	cp	a,#3
6712  0089 25b3          	jrult	L3642
6713  008b               L7642:
6714                     ; 4100   if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
6716  008b c6000a        	ld	a,_break_while
6717  008e 4a            	dec	a
6718  008f 2603cc0155    	jreq	L223
6721                     ; 4104   clear_saved_postpartial_all();
6723  0094 cd0000        	call	_clear_saved_postpartial_all
6725                     ; 4117     invalid = 0;
6727  0097 0f01          	clr	(OFST-1,sp)
6729                     ; 4119     temp = (uint8_t)(       (alpha[2] - '0'));
6731  0099 c60006        	ld	a,_alpha+2
6732  009c a030          	sub	a,#48
6733  009e 6b02          	ld	(OFST+0,sp),a
6735                     ; 4120     temp = (uint8_t)(temp + (alpha[1] - '0') * 10);
6737  00a0 c60005        	ld	a,_alpha+1
6738  00a3 97            	ld	xl,a
6739  00a4 a60a          	ld	a,#10
6740  00a6 42            	mul	x,a
6741  00a7 9f            	ld	a,xl
6742  00a8 a0e0          	sub	a,#224
6743  00aa 1b02          	add	a,(OFST+0,sp)
6744  00ac 6b02          	ld	(OFST+0,sp),a
6746                     ; 4121     if (temp > 55 && alpha[0] > '1') invalid = 1;
6748  00ae a138          	cp	a,#56
6749  00b0 250d          	jrult	L7742
6751  00b2 c60004        	ld	a,_alpha
6752  00b5 a132          	cp	a,#50
6753  00b7 2506          	jrult	L7742
6756  00b9 a601          	ld	a,#1
6757  00bb 6b01          	ld	(OFST-1,sp),a
6760  00bd 200e          	jra	L1052
6761  00bf               L7742:
6762                     ; 4122     else temp = (uint8_t)(temp + (alpha[0] - '0') * 100);
6764  00bf c60004        	ld	a,_alpha
6765  00c2 97            	ld	xl,a
6766  00c3 a664          	ld	a,#100
6767  00c5 42            	mul	x,a
6768  00c6 9f            	ld	a,xl
6769  00c7 a0c0          	sub	a,#192
6770  00c9 1b02          	add	a,(OFST+0,sp)
6771  00cb 6b02          	ld	(OFST+0,sp),a
6773  00cd               L1052:
6774                     ; 4123     if (invalid == 0) { // Make change only if valid entry
6776  00cd 7b01          	ld	a,(OFST-1,sp)
6777  00cf 267b          	jrne	L3052
6778                     ; 4124       switch(curr_ParseNum)
6780  00d1 7b04          	ld	a,(OFST+2,sp)
6782                     ; 4147         default: break;
6783  00d3 a110          	cp	a,#16
6784  00d5 2475          	jruge	L3052
6785  00d7 5f            	clrw	x
6786  00d8 97            	ld	xl,a
6787  00d9 58            	sllw	x
6788  00da de1d29        	ldw	x,(L023,x)
6789  00dd fc            	jp	(x)
6790  00de               L3632:
6791                     ; 4126         case 0:  Pending_hostaddr[3] = (uint8_t)temp; break;
6793  00de 7b02          	ld	a,(OFST+0,sp)
6794  00e0 c70003        	ld	_Pending_hostaddr+3,a
6797  00e3 2067          	jra	L3052
6798  00e5               L5632:
6799                     ; 4127         case 1:  Pending_hostaddr[2] = (uint8_t)temp; break;
6801  00e5 7b02          	ld	a,(OFST+0,sp)
6802  00e7 c70002        	ld	_Pending_hostaddr+2,a
6805  00ea 2060          	jra	L3052
6806  00ec               L7632:
6807                     ; 4128         case 2:  Pending_hostaddr[1] = (uint8_t)temp; break;
6809  00ec 7b02          	ld	a,(OFST+0,sp)
6810  00ee c70001        	ld	_Pending_hostaddr+1,a
6813  00f1 2059          	jra	L3052
6814  00f3               L1732:
6815                     ; 4129         case 3:  Pending_hostaddr[0] = (uint8_t)temp; break;
6817  00f3 7b02          	ld	a,(OFST+0,sp)
6818  00f5 c70000        	ld	_Pending_hostaddr,a
6821  00f8 2052          	jra	L3052
6822  00fa               L3732:
6823                     ; 4130         case 4:  Pending_draddr[3] = (uint8_t)temp; break;
6825  00fa 7b02          	ld	a,(OFST+0,sp)
6826  00fc c70003        	ld	_Pending_draddr+3,a
6829  00ff 204b          	jra	L3052
6830  0101               L5732:
6831                     ; 4131         case 5:  Pending_draddr[2] = (uint8_t)temp; break;
6833  0101 7b02          	ld	a,(OFST+0,sp)
6834  0103 c70002        	ld	_Pending_draddr+2,a
6837  0106 2044          	jra	L3052
6838  0108               L7732:
6839                     ; 4132         case 6:  Pending_draddr[1] = (uint8_t)temp; break;
6841  0108 7b02          	ld	a,(OFST+0,sp)
6842  010a c70001        	ld	_Pending_draddr+1,a
6845  010d 203d          	jra	L3052
6846  010f               L1042:
6847                     ; 4133         case 7:  Pending_draddr[0] = (uint8_t)temp; break;
6849  010f 7b02          	ld	a,(OFST+0,sp)
6850  0111 c70000        	ld	_Pending_draddr,a
6853  0114 2036          	jra	L3052
6854  0116               L3042:
6855                     ; 4134         case 8:  Pending_netmask[3] = (uint8_t)temp; break;
6857  0116 7b02          	ld	a,(OFST+0,sp)
6858  0118 c70003        	ld	_Pending_netmask+3,a
6861  011b 202f          	jra	L3052
6862  011d               L5042:
6863                     ; 4135         case 9:  Pending_netmask[2] = (uint8_t)temp; break;
6865  011d 7b02          	ld	a,(OFST+0,sp)
6866  011f c70002        	ld	_Pending_netmask+2,a
6869  0122 2028          	jra	L3052
6870  0124               L7042:
6871                     ; 4136         case 10: Pending_netmask[1] = (uint8_t)temp; break;
6873  0124 7b02          	ld	a,(OFST+0,sp)
6874  0126 c70001        	ld	_Pending_netmask+1,a
6877  0129 2021          	jra	L3052
6878  012b               L1142:
6879                     ; 4137         case 11: Pending_netmask[0] = (uint8_t)temp; break;
6881  012b 7b02          	ld	a,(OFST+0,sp)
6882  012d c70000        	ld	_Pending_netmask,a
6885  0130 201a          	jra	L3052
6886  0132               L3142:
6887                     ; 4140 	  Pending_mqttserveraddr[3] = (uint8_t)temp;
6889  0132 7b02          	ld	a,(OFST+0,sp)
6890  0134 c70003        	ld	_Pending_mqttserveraddr+3,a
6891                     ; 4141 	  break;
6893  0137 2013          	jra	L3052
6894  0139               L5142:
6895                     ; 4143         case 13: Pending_mqttserveraddr[2] = (uint8_t)temp; break;
6897  0139 7b02          	ld	a,(OFST+0,sp)
6898  013b c70002        	ld	_Pending_mqttserveraddr+2,a
6901  013e 200c          	jra	L3052
6902  0140               L7142:
6903                     ; 4144         case 14: Pending_mqttserveraddr[1] = (uint8_t)temp; break;
6905  0140 7b02          	ld	a,(OFST+0,sp)
6906  0142 c70001        	ld	_Pending_mqttserveraddr+1,a
6909  0145 2005          	jra	L3052
6910  0147               L1242:
6911                     ; 4145         case 15: Pending_mqttserveraddr[0] = (uint8_t)temp; break;
6913  0147 7b02          	ld	a,(OFST+0,sp)
6914  0149 c70000        	ld	_Pending_mqttserveraddr,a
6917                     ; 4147         default: break;
6919  014c               L3052:
6920                     ; 4152   if (tmp_nBytes == 0) {
6922  014c ce000c        	ldw	x,_tmp_nBytes
6923  014f 2604          	jrne	L223
6924                     ; 4155     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
6926  0151 3502000a      	mov	_break_while,#2
6927                     ; 4158     return;
6928  0155               L223:
6931  0155 5b04          	addw	sp,#4
6932  0157 81            	ret	
6933                     ; 4160 }
7013                     ; 4163 void parse_POST_port(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
7013                     ; 4164 {
7014                     .text:	section	.text,new
7015  0000               _parse_POST_port:
7017  0000 89            	pushw	x
7018  0001 5203          	subw	sp,#3
7019       00000003      OFST:	set	3
7022                     ; 4167   for (i=0; i<5; i++) alpha[i] = '-';
7024  0003 4f            	clr	a
7025  0004 6b03          	ld	(OFST+0,sp),a
7027  0006               L1452:
7030  0006 5f            	clrw	x
7031  0007 97            	ld	xl,a
7032  0008 a62d          	ld	a,#45
7033  000a d70004        	ld	(_alpha,x),a
7036  000d 0c03          	inc	(OFST+0,sp)
7040  000f 7b03          	ld	a,(OFST+0,sp)
7041  0011 a105          	cp	a,#5
7042  0013 25f1          	jrult	L1452
7043                     ; 4169   if (saved_postpartial_previous[0] == curr_ParseCmd) {
7045  0015 c60012        	ld	a,_saved_postpartial_previous
7046  0018 1104          	cp	a,(OFST+1,sp)
7047  001a 2621          	jrne	L7452
7048                     ; 4172     saved_postpartial_previous[0] = '\0';
7050  001c 725f0012      	clr	_saved_postpartial_previous
7051                     ; 4179     for (i=0; i<5; i++) {
7053  0020 4f            	clr	a
7054  0021 6b03          	ld	(OFST+0,sp),a
7056  0023               L1552:
7057                     ; 4180       if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
7059  0023 5f            	clrw	x
7060  0024 97            	ld	xl,a
7061  0025 724d0016      	tnz	(_saved_postpartial_previous+4,x)
7062  0029 2708          	jreq	L7552
7065  002b 5f            	clrw	x
7066  002c 97            	ld	xl,a
7067  002d d60016        	ld	a,(_saved_postpartial_previous+4,x)
7068  0030 d70004        	ld	(_alpha,x),a
7069  0033               L7552:
7070                     ; 4179     for (i=0; i<5; i++) {
7072  0033 0c03          	inc	(OFST+0,sp)
7076  0035 7b03          	ld	a,(OFST+0,sp)
7077  0037 a105          	cp	a,#5
7078  0039 25e8          	jrult	L1552
7080  003b 2003          	jra	L1652
7081  003d               L7452:
7082                     ; 4187     clear_saved_postpartial_data(); // Clear [4] and higher
7084  003d cd0000        	call	_clear_saved_postpartial_data
7086  0040               L1652:
7087                     ; 4192     for (i=0; i<5; i++) {
7089  0040 4f            	clr	a
7090  0041 6b03          	ld	(OFST+0,sp),a
7092  0043               L3652:
7093                     ; 4198       if (alpha[i] == '-') {
7095  0043 5f            	clrw	x
7096  0044 97            	ld	xl,a
7097  0045 d60004        	ld	a,(_alpha,x)
7098  0048 a12d          	cp	a,#45
7099  004a 263c          	jrne	L1752
7100                     ; 4199         alpha[i] = (uint8_t)(*tmp_pBuffer);
7102  004c 7b03          	ld	a,(OFST+0,sp)
7103  004e 5f            	clrw	x
7104  004f 90ce000e      	ldw	y,_tmp_pBuffer
7105  0053 97            	ld	xl,a
7106  0054 90f6          	ld	a,(y)
7107  0056 d70004        	ld	(_alpha,x),a
7108                     ; 4200         saved_postpartial[i+4] = *tmp_pBuffer;
7110  0059 5f            	clrw	x
7111  005a 7b03          	ld	a,(OFST+0,sp)
7112  005c 97            	ld	xl,a
7113  005d 90f6          	ld	a,(y)
7114  005f d7002e        	ld	(_saved_postpartial+4,x),a
7115                     ; 4201         tmp_nParseLeft--;
7117  0062 725a000b      	dec	_tmp_nParseLeft
7118                     ; 4202         saved_nparseleft = tmp_nParseLeft;
7120                     ; 4203         tmp_pBuffer++;
7122  0066 93            	ldw	x,y
7123  0067 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
7124  006c 5c            	incw	x
7125  006d cf000e        	ldw	_tmp_pBuffer,x
7126                     ; 4204         tmp_nBytes--;
7128  0070 ce000c        	ldw	x,_tmp_nBytes
7129  0073 5a            	decw	x
7130  0074 cf000c        	ldw	_tmp_nBytes,x
7131                     ; 4205         if (i != 4 && tmp_nBytes == 0) {
7133  0077 7b03          	ld	a,(OFST+0,sp)
7134  0079 a104          	cp	a,#4
7135  007b 270b          	jreq	L1752
7137  007d ce000c        	ldw	x,_tmp_nBytes
7138  0080 2606          	jrne	L1752
7139                     ; 4206           break_while = 1; // Hit end of fragment but still have characters to
7141  0082 3501000a      	mov	_break_while,#1
7142                     ; 4210    	break; // Break out of for() loop.
7144  0086 2008          	jra	L7652
7145  0088               L1752:
7146                     ; 4192     for (i=0; i<5; i++) {
7148  0088 0c03          	inc	(OFST+0,sp)
7152  008a 7b03          	ld	a,(OFST+0,sp)
7153  008c a105          	cp	a,#5
7154  008e 25b3          	jrult	L3652
7155  0090               L7652:
7156                     ; 4214     if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
7158  0090 c6000a        	ld	a,_break_while
7159  0093 4a            	dec	a
7160  0094 2603cc0122    	jreq	L233
7163                     ; 4219   clear_saved_postpartial_all();
7165  0099 cd0000        	call	_clear_saved_postpartial_all
7167                     ; 4228     invalid = 0;
7169  009c 0f03          	clr	(OFST+0,sp)
7171                     ; 4230     temp = (uint16_t)(       (alpha[4] - '0'));
7173  009e 5f            	clrw	x
7174  009f c60008        	ld	a,_alpha+4
7175  00a2 97            	ld	xl,a
7176  00a3 1d0030        	subw	x,#48
7177  00a6 1f01          	ldw	(OFST-2,sp),x
7179                     ; 4231     temp = (uint16_t)(temp + (alpha[3] - '0') * 10);
7181  00a8 c60007        	ld	a,_alpha+3
7182  00ab 97            	ld	xl,a
7183  00ac a60a          	ld	a,#10
7184  00ae 42            	mul	x,a
7185  00af 1d01e0        	subw	x,#480
7186  00b2 72fb01        	addw	x,(OFST-2,sp)
7187  00b5 1f01          	ldw	(OFST-2,sp),x
7189                     ; 4232     temp = (uint16_t)(temp + (alpha[2] - '0') * 100);
7191  00b7 c60006        	ld	a,_alpha+2
7192  00ba 97            	ld	xl,a
7193  00bb a664          	ld	a,#100
7194  00bd 42            	mul	x,a
7195  00be 1d12c0        	subw	x,#4800
7196  00c1 72fb01        	addw	x,(OFST-2,sp)
7197  00c4 1f01          	ldw	(OFST-2,sp),x
7199                     ; 4233     temp = (uint16_t)(temp + (alpha[1] - '0') * 1000);
7201  00c6 5f            	clrw	x
7202  00c7 c60005        	ld	a,_alpha+1
7203  00ca 97            	ld	xl,a
7204  00cb 90ae03e8      	ldw	y,#1000
7205  00cf cd0000        	call	c_imul
7207  00d2 1dbb80        	subw	x,#48000
7208  00d5 72fb01        	addw	x,(OFST-2,sp)
7209  00d8 1f01          	ldw	(OFST-2,sp),x
7211                     ; 4234     if (temp > 5535 && alpha[0] > '5') invalid = 1;
7213  00da a315a0        	cpw	x,#5536
7214  00dd 250d          	jrult	L7752
7216  00df c60004        	ld	a,_alpha
7217  00e2 a136          	cp	a,#54
7218  00e4 2506          	jrult	L7752
7221  00e6 a601          	ld	a,#1
7222  00e8 6b03          	ld	(OFST+0,sp),a
7225  00ea 2014          	jra	L1062
7226  00ec               L7752:
7227                     ; 4235     else temp = (uint16_t)(temp + (alpha[0] - '0') * 10000);
7229  00ec c60004        	ld	a,_alpha
7230  00ef 5f            	clrw	x
7231  00f0 97            	ld	xl,a
7232  00f1 90ae2710      	ldw	y,#10000
7233  00f5 cd0000        	call	c_imul
7235  00f8 1d5300        	subw	x,#21248
7236  00fb 72fb01        	addw	x,(OFST-2,sp)
7237  00fe 1f01          	ldw	(OFST-2,sp),x
7239  0100               L1062:
7240                     ; 4236     if (temp < 10) invalid = 1;
7242  0100 a3000a        	cpw	x,#10
7243  0103 2404          	jruge	L3062
7246  0105 a601          	ld	a,#1
7247  0107 6b03          	ld	(OFST+0,sp),a
7249  0109               L3062:
7250                     ; 4237     if (invalid == 0) {
7252  0109 7b03          	ld	a,(OFST+0,sp)
7253  010b 260c          	jrne	L5062
7254                     ; 4238       if (curr_ParseNum == 0) Pending_port = (uint16_t)temp;
7256  010d 7b05          	ld	a,(OFST+2,sp)
7257  010f 2605          	jrne	L7062
7260  0111 cf0000        	ldw	_Pending_port,x
7262  0114 2003          	jra	L5062
7263  0116               L7062:
7264                     ; 4240       else Pending_mqttport = (uint16_t)temp;
7266  0116 cf0000        	ldw	_Pending_mqttport,x
7267  0119               L5062:
7268                     ; 4245   if (tmp_nBytes == 0) {
7270  0119 ce000c        	ldw	x,_tmp_nBytes
7271  011c 2604          	jrne	L233
7272                     ; 4248     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
7274  011e 3502000a      	mov	_break_while,#2
7275                     ; 4251     return;
7276  0122               L233:
7279  0122 5b05          	addw	sp,#5
7280  0124 81            	ret	
7281                     ; 4253 }
7316                     	switch	.const
7317  1d49               L043:
7318  1d49 000e          	dc.w	L5162
7319  1d4b 0016          	dc.w	L7162
7320  1d4d 001e          	dc.w	L1262
7321  1d4f 0026          	dc.w	L3262
7322  1d51 002e          	dc.w	L5262
7323  1d53 0036          	dc.w	L7262
7324  1d55 003e          	dc.w	L1362
7325  1d57 0046          	dc.w	L3362
7326  1d59 004e          	dc.w	L5362
7327  1d5b 0056          	dc.w	L7362
7328  1d5d 005e          	dc.w	L1462
7329  1d5f 0066          	dc.w	L3462
7330  1d61 006e          	dc.w	L5462
7331  1d63 0076          	dc.w	L7462
7332  1d65 007e          	dc.w	L1562
7333  1d67 0086          	dc.w	L3562
7334                     ; 4256 uint8_t GpioGetPin(uint8_t nGpio)
7334                     ; 4257 {
7335                     .text:	section	.text,new
7336  0000               _GpioGetPin:
7340                     ; 4262   switch (nGpio) {
7343                     ; 4278     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7344  0000 a110          	cp	a,#16
7345  0002 2503cc008e    	jruge	L3762
7346  0007 5f            	clrw	x
7347  0008 97            	ld	xl,a
7348  0009 58            	sllw	x
7349  000a de1d49        	ldw	x,(L043,x)
7350  000d fc            	jp	(x)
7351  000e               L5162:
7352                     ; 4263     case 0:  if (IO_8to1  & (uint8_t)(0x01)) return 1; break;
7354  000e 720100007b    	btjf	_IO_8to1,#0,L3762
7357  0013 a601          	ld	a,#1
7360  0015 81            	ret	
7361  0016               L7162:
7362                     ; 4264     case 1:  if (IO_8to1  & (uint8_t)(0x02)) return 1; break;
7364  0016 7203000073    	btjf	_IO_8to1,#1,L3762
7367  001b a601          	ld	a,#1
7370  001d 81            	ret	
7371  001e               L1262:
7372                     ; 4265     case 2:  if (IO_8to1  & (uint8_t)(0x04)) return 1; break;
7374  001e 720500006b    	btjf	_IO_8to1,#2,L3762
7377  0023 a601          	ld	a,#1
7380  0025 81            	ret	
7381  0026               L3262:
7382                     ; 4266     case 3:  if (IO_8to1  & (uint8_t)(0x08)) return 1; break;
7384  0026 7207000063    	btjf	_IO_8to1,#3,L3762
7387  002b a601          	ld	a,#1
7390  002d 81            	ret	
7391  002e               L5262:
7392                     ; 4267     case 4:  if (IO_8to1  & (uint8_t)(0x10)) return 1; break;
7394  002e 720900005b    	btjf	_IO_8to1,#4,L3762
7397  0033 a601          	ld	a,#1
7400  0035 81            	ret	
7401  0036               L7262:
7402                     ; 4268     case 5:  if (IO_8to1  & (uint8_t)(0x20)) return 1; break;
7404  0036 720b000053    	btjf	_IO_8to1,#5,L3762
7407  003b a601          	ld	a,#1
7410  003d 81            	ret	
7411  003e               L1362:
7412                     ; 4269     case 6:  if (IO_8to1  & (uint8_t)(0x40)) return 1; break;
7414  003e 720d00004b    	btjf	_IO_8to1,#6,L3762
7417  0043 a601          	ld	a,#1
7420  0045 81            	ret	
7421  0046               L3362:
7422                     ; 4270     case 7:  if (IO_8to1  & (uint8_t)(0x80)) return 1; break;
7424  0046 720f000043    	btjf	_IO_8to1,#7,L3762
7427  004b a601          	ld	a,#1
7430  004d 81            	ret	
7431  004e               L5362:
7432                     ; 4271     case 8:  if (IO_16to9 & (uint8_t)(0x01)) return 1; break;
7434  004e 720100003b    	btjf	_IO_16to9,#0,L3762
7437  0053 a601          	ld	a,#1
7440  0055 81            	ret	
7441  0056               L7362:
7442                     ; 4272     case 9:  if (IO_16to9 & (uint8_t)(0x02)) return 1; break;
7444  0056 7203000033    	btjf	_IO_16to9,#1,L3762
7447  005b a601          	ld	a,#1
7450  005d 81            	ret	
7451  005e               L1462:
7452                     ; 4273     case 10: if (IO_16to9 & (uint8_t)(0x04)) return 1; break;
7454  005e 720500002b    	btjf	_IO_16to9,#2,L3762
7457  0063 a601          	ld	a,#1
7460  0065 81            	ret	
7461  0066               L3462:
7462                     ; 4274     case 11: if (IO_16to9 & (uint8_t)(0x08)) return 1; break;
7464  0066 7207000023    	btjf	_IO_16to9,#3,L3762
7467  006b a601          	ld	a,#1
7470  006d 81            	ret	
7471  006e               L5462:
7472                     ; 4275     case 12: if (IO_16to9 & (uint8_t)(0x10)) return 1; break;
7474  006e 720900001b    	btjf	_IO_16to9,#4,L3762
7477  0073 a601          	ld	a,#1
7480  0075 81            	ret	
7481  0076               L7462:
7482                     ; 4276     case 13: if (IO_16to9 & (uint8_t)(0x20)) return 1; break;
7484  0076 720b000013    	btjf	_IO_16to9,#5,L3762
7487  007b a601          	ld	a,#1
7490  007d 81            	ret	
7491  007e               L1562:
7492                     ; 4277     case 14: if (IO_16to9 & (uint8_t)(0x40)) return 1; break;
7494  007e 720d00000b    	btjf	_IO_16to9,#6,L3762
7497  0083 a601          	ld	a,#1
7500  0085 81            	ret	
7501  0086               L3562:
7502                     ; 4278     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7504  0086 720f000003    	btjf	_IO_16to9,#7,L3762
7507  008b a601          	ld	a,#1
7510  008d 81            	ret	
7511  008e               L3762:
7512                     ; 4280   return 0;
7514  008e 4f            	clr	a
7517  008f 81            	ret	
7564                     ; 4329 void GpioSetPin(uint8_t nGpio, uint8_t nState)
7564                     ; 4330 {
7565                     .text:	section	.text,new
7566  0000               _GpioSetPin:
7568  0000 89            	pushw	x
7569  0001 88            	push	a
7570       00000001      OFST:	set	1
7573                     ; 4337   mask = 0;
7575  0002 0f01          	clr	(OFST+0,sp)
7577                     ; 4339   switch(nGpio) {
7579  0004 9e            	ld	a,xh
7581                     ; 4348     default: break;
7582  0005 4d            	tnz	a
7583  0006 2717          	jreq	L5372
7584  0008 4a            	dec	a
7585  0009 2717          	jreq	L7372
7586  000b 4a            	dec	a
7587  000c 2718          	jreq	L1472
7588  000e 4a            	dec	a
7589  000f 2719          	jreq	L3472
7590  0011 4a            	dec	a
7591  0012 271a          	jreq	L5472
7592  0014 4a            	dec	a
7593  0015 271b          	jreq	L7472
7594  0017 4a            	dec	a
7595  0018 271c          	jreq	L1572
7596  001a 4a            	dec	a
7597  001b 271d          	jreq	L3572
7598  001d 201f          	jra	L1003
7599  001f               L5372:
7600                     ; 4340     case 0: mask = 0x01; break;
7602  001f 4c            	inc	a
7605  0020 201a          	jp	LC026
7606  0022               L7372:
7607                     ; 4341     case 1: mask = 0x02; break;
7609  0022 a602          	ld	a,#2
7612  0024 2016          	jp	LC026
7613  0026               L1472:
7614                     ; 4342     case 2: mask = 0x04; break;
7616  0026 a604          	ld	a,#4
7619  0028 2012          	jp	LC026
7620  002a               L3472:
7621                     ; 4343     case 3: mask = 0x08; break;
7623  002a a608          	ld	a,#8
7626  002c 200e          	jp	LC026
7627  002e               L5472:
7628                     ; 4344     case 4: mask = 0x10; break;
7630  002e a610          	ld	a,#16
7633  0030 200a          	jp	LC026
7634  0032               L7472:
7635                     ; 4345     case 5: mask = 0x20; break;
7637  0032 a620          	ld	a,#32
7640  0034 2006          	jp	LC026
7641  0036               L1572:
7642                     ; 4346     case 6: mask = 0x40; break;
7644  0036 a640          	ld	a,#64
7647  0038 2002          	jp	LC026
7648  003a               L3572:
7649                     ; 4347     case 7: mask = 0x80; break;
7651  003a a680          	ld	a,#128
7652  003c               LC026:
7653  003c 6b01          	ld	(OFST+0,sp),a
7657                     ; 4348     default: break;
7659  003e               L1003:
7660                     ; 4351   if (nState) IO_8to1 |= mask;
7662  003e 7b03          	ld	a,(OFST+2,sp)
7663  0040 2707          	jreq	L3003
7666  0042 c60000        	ld	a,_IO_8to1
7667  0045 1a01          	or	a,(OFST+0,sp)
7669  0047 2006          	jra	L5003
7670  0049               L3003:
7671                     ; 4352   else IO_8to1 &= (uint8_t)~mask;
7673  0049 7b01          	ld	a,(OFST+0,sp)
7674  004b 43            	cpl	a
7675  004c c40000        	and	a,_IO_8to1
7676  004f               L5003:
7677  004f c70000        	ld	_IO_8to1,a
7678                     ; 4354 }
7681  0052 5b03          	addw	sp,#3
7682  0054 81            	ret	
7743                     ; 4366 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7743                     ; 4367 {
7744                     .text:	section	.text,new
7745  0000               _SetMAC:
7747  0000 89            	pushw	x
7748  0001 5203          	subw	sp,#3
7749       00000003      OFST:	set	3
7752                     ; 4381   temp = 0;
7754                     ; 4382   invalid = 0;
7756  0003 0f01          	clr	(OFST-2,sp)
7758                     ; 4385   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7760  0005 9f            	ld	a,xl
7761  0006 a130          	cp	a,#48
7762  0008 250b          	jrult	L1503
7764  000a 9f            	ld	a,xl
7765  000b a13a          	cp	a,#58
7766  000d 2406          	jruge	L1503
7769  000f 7b05          	ld	a,(OFST+2,sp)
7770  0011 a030          	sub	a,#48
7772  0013 200c          	jp	LC027
7773  0015               L1503:
7774                     ; 4386   else if (alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7776  0015 7b05          	ld	a,(OFST+2,sp)
7777  0017 a161          	cp	a,#97
7778  0019 250a          	jrult	L5503
7780  001b a167          	cp	a,#103
7781  001d 2406          	jruge	L5503
7784  001f a057          	sub	a,#87
7785  0021               LC027:
7786  0021 6b05          	ld	(OFST+2,sp),a
7788  0023 2004          	jra	L3503
7789  0025               L5503:
7790                     ; 4387   else invalid = 1; // If an invalid entry set indicator
7792  0025 a601          	ld	a,#1
7793  0027 6b01          	ld	(OFST-2,sp),a
7795  0029               L3503:
7796                     ; 4389   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7798  0029 7b08          	ld	a,(OFST+5,sp)
7799  002b a130          	cp	a,#48
7800  002d 2508          	jrult	L1603
7802  002f a13a          	cp	a,#58
7803  0031 2404          	jruge	L1603
7806  0033 a030          	sub	a,#48
7808  0035 200a          	jp	LC028
7809  0037               L1603:
7810                     ; 4390   else if (alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7812  0037 a161          	cp	a,#97
7813  0039 250a          	jrult	L5603
7815  003b a167          	cp	a,#103
7816  003d 2406          	jruge	L5603
7819  003f a057          	sub	a,#87
7820  0041               LC028:
7821  0041 6b08          	ld	(OFST+5,sp),a
7823  0043 2004          	jra	L3603
7824  0045               L5603:
7825                     ; 4391   else invalid = 1; // If an invalid entry set indicator
7827  0045 a601          	ld	a,#1
7828  0047 6b01          	ld	(OFST-2,sp),a
7830  0049               L3603:
7831                     ; 4393   if (invalid == 0) { // Change value only if valid entry
7833  0049 7b01          	ld	a,(OFST-2,sp)
7834  004b 264a          	jrne	L1703
7835                     ; 4394     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7837  004d 7b05          	ld	a,(OFST+2,sp)
7838  004f 97            	ld	xl,a
7839  0050 a610          	ld	a,#16
7840  0052 42            	mul	x,a
7841  0053 01            	rrwa	x,a
7842  0054 1b08          	add	a,(OFST+5,sp)
7843  0056 5f            	clrw	x
7844  0057 97            	ld	xl,a
7845  0058 1f02          	ldw	(OFST-1,sp),x
7847                     ; 4395     switch(itemnum)
7849  005a 7b04          	ld	a,(OFST+1,sp)
7851                     ; 4403     default: break;
7852  005c 2711          	jreq	L7003
7853  005e 4a            	dec	a
7854  005f 2715          	jreq	L1103
7855  0061 4a            	dec	a
7856  0062 2719          	jreq	L3103
7857  0064 4a            	dec	a
7858  0065 271d          	jreq	L5103
7859  0067 4a            	dec	a
7860  0068 2721          	jreq	L7103
7861  006a 4a            	dec	a
7862  006b 2725          	jreq	L1203
7863  006d 2028          	jra	L1703
7864  006f               L7003:
7865                     ; 4397     case 0: Pending_uip_ethaddr_oct[5] = (uint8_t)temp; break;
7867  006f 7b03          	ld	a,(OFST+0,sp)
7868  0071 c70005        	ld	_Pending_uip_ethaddr_oct+5,a
7871  0074 2021          	jra	L1703
7872  0076               L1103:
7873                     ; 4398     case 1: Pending_uip_ethaddr_oct[4] = (uint8_t)temp; break;
7875  0076 7b03          	ld	a,(OFST+0,sp)
7876  0078 c70004        	ld	_Pending_uip_ethaddr_oct+4,a
7879  007b 201a          	jra	L1703
7880  007d               L3103:
7881                     ; 4399     case 2: Pending_uip_ethaddr_oct[3] = (uint8_t)temp; break;
7883  007d 7b03          	ld	a,(OFST+0,sp)
7884  007f c70003        	ld	_Pending_uip_ethaddr_oct+3,a
7887  0082 2013          	jra	L1703
7888  0084               L5103:
7889                     ; 4400     case 3: Pending_uip_ethaddr_oct[2] = (uint8_t)temp; break;
7891  0084 7b03          	ld	a,(OFST+0,sp)
7892  0086 c70002        	ld	_Pending_uip_ethaddr_oct+2,a
7895  0089 200c          	jra	L1703
7896  008b               L7103:
7897                     ; 4401     case 4: Pending_uip_ethaddr_oct[1] = (uint8_t)temp; break;
7899  008b 7b03          	ld	a,(OFST+0,sp)
7900  008d c70001        	ld	_Pending_uip_ethaddr_oct+1,a
7903  0090 2005          	jra	L1703
7904  0092               L1203:
7905                     ; 4402     case 5: Pending_uip_ethaddr_oct[0] = (uint8_t)temp; break;
7907  0092 7b03          	ld	a,(OFST+0,sp)
7908  0094 c70000        	ld	_Pending_uip_ethaddr_oct,a
7911                     ; 4403     default: break;
7913  0097               L1703:
7914                     ; 4406 }
7917  0097 5b05          	addw	sp,#5
7918  0099 81            	ret	
8322                     	switch	.bss
8323  0000               _insertion_flag:
8324  0000 000000        	ds.b	3
8325                     	xdef	_insertion_flag
8326                     	xref	_second_counter
8327                     	xref	_TRANSMIT_counter
8328                     	xref	_TXERIF_counter
8329                     	xref	_RXERIF_counter
8330                     	xref	_MQTT_error_status
8331                     	xref	_mqtt_start_status
8332                     	xref	_Pending_mqtt_password
8333                     	xref	_Pending_mqtt_username
8334                     	xref	_Pending_mqttport
8335                     	xref	_Pending_mqttserveraddr
8336                     	xref	_stored_mqtt_password
8337                     	xref	_stored_mqtt_username
8338                     	xref	_stored_mqttport
8339                     	xref	_stored_mqttserveraddr
8340  0003               _current_webpage:
8341  0003 00            	ds.b	1
8342                     	xdef	_current_webpage
8343  0004               _alpha:
8344  0004 000000000000  	ds.b	6
8345                     	xdef	_alpha
8346  000a               _break_while:
8347  000a 00            	ds.b	1
8348                     	xdef	_break_while
8349  000b               _tmp_nParseLeft:
8350  000b 00            	ds.b	1
8351                     	xdef	_tmp_nParseLeft
8352  000c               _tmp_nBytes:
8353  000c 0000          	ds.b	2
8354                     	xdef	_tmp_nBytes
8355  000e               _tmp_pBuffer:
8356  000e 0000          	ds.b	2
8357                     	xdef	_tmp_pBuffer
8358  0010               _z_diag:
8359  0010 00            	ds.b	1
8360                     	xdef	_z_diag
8361  0011               _saved_newlines:
8362  0011 00            	ds.b	1
8363                     	xdef	_saved_newlines
8364  0012               _saved_postpartial_previous:
8365  0012 000000000000  	ds.b	24
8366                     	xdef	_saved_postpartial_previous
8367  002a               _saved_postpartial:
8368  002a 000000000000  	ds.b	24
8369                     	xdef	_saved_postpartial
8370  0042               _saved_nparseleft:
8371  0042 00            	ds.b	1
8372                     	xdef	_saved_nparseleft
8373  0043               _saved_parsestate:
8374  0043 00            	ds.b	1
8375                     	xdef	_saved_parsestate
8376  0044               _saved_nstate:
8377  0044 00            	ds.b	1
8378                     	xdef	_saved_nstate
8379  0045               _OctetArray:
8380  0045 000000000000  	ds.b	11
8381                     	xdef	_OctetArray
8382                     	xref	_user_reboot_request
8383                     	xref	_parse_complete
8384                     	xref	_mac_string
8385                     	xref	_stored_config_settings
8386                     	xref	_stored_devicename
8387                     	xref	_stored_port
8388                     	xref	_stored_netmask
8389                     	xref	_stored_draddr
8390                     	xref	_stored_hostaddr
8391                     	xref	_Pending_uip_ethaddr_oct
8392                     	xref	_Pending_config_settings
8393                     	xref	_Pending_devicename
8394                     	xref	_Pending_port
8395                     	xref	_Pending_netmask
8396                     	xref	_Pending_draddr
8397                     	xref	_Pending_hostaddr
8398                     	xref	_invert_input
8399                     	xref	_IO_8to1
8400                     	xref	_IO_16to9
8401                     	xref	_Port_Httpd
8402                     	xref	_strlen
8403                     	xref	_debugflash
8404                     	xref	_uip_flags
8405                     	xref	_uip_conn
8406                     	xref	_uip_len
8407                     	xref	_uip_appdata
8408                     	xref	_htons
8409                     	xref	_uip_send
8410                     	xref	_uip_listen
8411                     	xref	_uip_init_stats
8412                     	xdef	_SetMAC
8413                     	xdef	_clear_saved_postpartial_previous
8414                     	xdef	_clear_saved_postpartial_data
8415                     	xdef	_clear_saved_postpartial_all
8416                     	xdef	_GpioSetPin
8417                     	xdef	_GpioGetPin
8418                     	xdef	_parse_POST_port
8419                     	xdef	_parse_POST_address
8420                     	xdef	_parse_POST_string
8421                     	xdef	_HttpDCall
8422                     	xdef	_HttpDInit
8423                     	xdef	_emb_itoa
8424                     	xdef	_adjust_template_size
8425                     	switch	.const
8426  1d69               L143:
8427  1d69 436f6e6e6563  	dc.b	"Connection:close",13
8428  1d7a 0a00          	dc.b	10,0
8429  1d7c               L733:
8430  1d7c 436f6e74656e  	dc.b	"Content-Type: text"
8431  1d8e 2f68746d6c3b  	dc.b	"/html; charset=utf"
8432  1da0 2d380d        	dc.b	"-8",13
8433  1da3 0a00          	dc.b	10,0
8434  1da5               L533:
8435  1da5 43616368652d  	dc.b	"Cache-Control: no-"
8436  1db7 63616368652c  	dc.b	"cache, no-store",13
8437  1dc7 0a00          	dc.b	10,0
8438  1dc9               L523:
8439  1dc9 436f6e74656e  	dc.b	"Content-Length:",0
8440  1dd9               L323:
8441  1dd9 0d0a00        	dc.b	13,10,0
8442  1ddc               L123:
8443  1ddc 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8444                     	xref.b	c_lreg
8445                     	xref.b	c_x
8446                     	xref.b	c_y
8466                     	xref	c_imul
8467                     	xref	c_uitolx
8468                     	xref	c_ludv
8469                     	xref	c_lumd
8470                     	xref	c_rtol
8471                     	xref	c_ltor
8472                     	xref	c_lzmp
8473                     	end
