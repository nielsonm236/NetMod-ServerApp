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
 378  17a6 652052657669  	dc.b	"e Revision 2020111"
 379  17b8 362030323536  	dc.b	"6 0256</p>%y03/91%"
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
 391  1865 6561643e3c74  	dc.b	"ead><title>Help Pa"
 392  1877 676520323c2f  	dc.b	"ge 2</title><link "
 393  1889 72656c3d2769  	dc.b	"rel='icon' href='d"
 394  189b 6174613a2c27  	dc.b	"ata:,'></head><bod"
 395  18ad 793e3c703e25  	dc.b	"y><p>%f00</p></bod"
 396  18bf 793e3c2f6874  	dc.b	"y></html>",0
 397  18c9               L12_page_string00:
 398  18c9 706174746572  	dc.b	"pattern='[0-9]{3}'"
 399  18db 207469746c65  	dc.b	" title='Enter 000 "
 400  18ed 746f20323535  	dc.b	"to 255' maxlength="
 401  18ff 2733273e3c2f  	dc.b	"'3'></td>",0
 402  1909               L32_page_string00_len:
 403  1909 3f            	dc.b	63
 404  190a               L52_page_string00_len_less4:
 405  190a 3b            	dc.b	59
 406  190b               L72_page_string01:
 407  190b 706174746572  	dc.b	"pattern='[0-9a-f]{"
 408  191d 327d27207469  	dc.b	"2}' title='Enter 0"
 409  192f 3020746f2066  	dc.b	"0 to ff' maxlength"
 410  1941 3d2732273e3c  	dc.b	"='2'></td>",0
 411  194c               L13_page_string01_len:
 412  194c 40            	dc.b	64
 413  194d               L33_page_string01_len_less4:
 414  194d 3c            	dc.b	60
 415  194e               L53_page_string02:
 416  194e 27206d657468  	dc.b	"' method='GET'><bu"
 417  1960 74746f6e2074  	dc.b	"tton title='Save f"
 418  1972 697273742120  	dc.b	"irst! This button "
 419  1984 77696c6c206e  	dc.b	"will not save your"
 420  1996 206368616e67  	dc.b	" changes'>",0
 421  19a1               L73_page_string02_len:
 422  19a1 52            	dc.b	82
 423  19a2               L14_page_string02_len_less4:
 424  19a2 4e            	dc.b	78
 425  19a3               L34_page_string03:
 426  19a3 3c666f726d20  	dc.b	"<form style='displ"
 427  19b5 61793a20696e  	dc.b	"ay: inline' action"
 428  19c7 3d2700        	dc.b	"='",0
 429  19ca               L54_page_string03_len:
 430  19ca 26            	dc.b	38
 431  19cb               L74_page_string03_len_less4:
 432  19cb 22            	dc.b	34
 433  19cc               L15_page_string04:
 434  19cc 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 435  19de 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 436  19f0 6561643e3c6c  	dc.b	"ead><link rel='ico"
 437  1a02 6e2720687265  	dc.b	"n' href='data:,'>",0
 438  1a14               L35_page_string04_len:
 439  1a14 47            	dc.b	71
 440  1a15               L55_page_string04_len_less4:
 441  1a15 43            	dc.b	67
 442  1a16               L75_page_string05:
 443  1a16 3c7374796c65  	dc.b	"<style>.s0 { backg"
 444  1a28 726f756e642d  	dc.b	"round-color: red; "
 445  1a3a 77696474683a  	dc.b	"width: 30px; }.s1 "
 446  1a4c 7b206261636b  	dc.b	"{ background-color"
 447  1a5e 3a2067726565  	dc.b	": green; width: 30"
 448  1a70 70783b207d2e  	dc.b	"px; }.t1 { width: "
 449  1a82 31323070783b  	dc.b	"120px; }.t2 { widt"
 450  1a94 683a20313438  	dc.b	"h: 148px; }.t3 { w"
 451  1aa6 696474683a20  	dc.b	"idth: 30px; }.t5 {"
 452  1ab8 207769647468  	dc.b	" width: 60px; }.t6"
 453  1aca 207b20776964  	dc.b	" { width: 25px; }."
 454  1adc 7437207b2077  	dc.b	"t7 { width: 18px; "
 455  1aee 7d2e7438207b  	dc.b	"}.t8 { width: 40px"
 456  1b00 3b207d00      	dc.b	"; }",0
 457  1b04               L16_page_string05_len:
 458  1b04 ed            	dc.b	237
 459  1b05               L36_page_string05_len_less4:
 460  1b05 e9            	dc.b	233
 461  1b06               L56_page_string06:
 462  1b06 7464207b2074  	dc.b	"td { text-align: c"
 463  1b18 656e7465723b  	dc.b	"enter; border: 1px"
 464  1b2a 20626c61636b  	dc.b	" black solid; }</s"
 465  1b3c 74796c653e00  	dc.b	"tyle>",0
 466  1b42               L76_page_string06_len:
 467  1b42 3b            	dc.b	59
 468  1b43               L17_page_string06_len_less4:
 469  1b43 37            	dc.b	55
 523                     ; 1205 uint16_t adjust_template_size()
 523                     ; 1206 {
 525                     .text:	section	.text,new
 526  0000               _adjust_template_size:
 528  0000 89            	pushw	x
 529       00000002      OFST:	set	2
 532                     ; 1224   size = 0;
 534  0001 5f            	clrw	x
 535  0002 1f01          	ldw	(OFST-1,sp),x
 537                     ; 1229   if (current_webpage == WEBPAGE_IOCONTROL) {
 539  0004 c60003        	ld	a,_current_webpage
 540  0007 2613          	jrne	L511
 541                     ; 1230     size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
 543                     ; 1233     size = size + page_string04_len_less4
 543                     ; 1234                 + page_string05_len_less4
 543                     ; 1235 		+ page_string06_len_less4;
 545  0009 ae0d69        	ldw	x,#3433
 546  000c 1f01          	ldw	(OFST-1,sp),x
 548                     ; 1240     size = size + strlen(stored_devicename) - 4 ;
 550  000e ae0000        	ldw	x,#_stored_devicename
 551  0011 cd0000        	call	_strlen
 553  0014 72fb01        	addw	x,(OFST-1,sp)
 554  0017 1c00a4        	addw	x,#164
 556                     ; 1247     size = size - 48;
 559                     ; 1263     size = size - 8;
 562                     ; 1277     size = size + (2 * page_string03_len_less4);
 565                     ; 1306     size = size + (2 * (page_string02_len_less4));
 569  001a 203d          	jra	L711
 570  001c               L511:
 571                     ; 1325   else if (current_webpage == WEBPAGE_CONFIGURATION) {
 573  001c a101          	cp	a,#1
 574  001e 2632          	jrne	L121
 575                     ; 1326     size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
 577                     ; 1329     size = size + page_string04_len_less4
 577                     ; 1330                 + page_string05_len_less4
 577                     ; 1331 		+ page_string06_len_less4;
 579  0020 ae0d94        	ldw	x,#3476
 580  0023 1f01          	ldw	(OFST-1,sp),x
 582                     ; 1336     size = size + strlen(stored_devicename) - 4 ;
 584  0025 ae0000        	ldw	x,#_stored_devicename
 585  0028 cd0000        	call	_strlen
 587  002b 72fb01        	addw	x,(OFST-1,sp)
 588  002e 1d001c        	subw	x,#28
 590                     ; 1343     size = size - 12;
 593                     ; 1350     size = size + 1;
 596                     ; 1357     size = size - 12;
 599                     ; 1365     size = size + 2;
 602                     ; 1373     size = size - 4;
 605                     ; 1380     size = size + 1;
 607  0031 1f01          	ldw	(OFST-1,sp),x
 609                     ; 1385     size = size + (strlen(stored_mqtt_username) - 4);
 611  0033 ae0000        	ldw	x,#_stored_mqtt_username
 612  0036 cd0000        	call	_strlen
 614  0039 1d0004        	subw	x,#4
 615  003c 72fb01        	addw	x,(OFST-1,sp)
 616  003f 1f01          	ldw	(OFST-1,sp),x
 618                     ; 1390     size = size + (strlen(stored_mqtt_password) - 4);
 620  0041 ae0000        	ldw	x,#_stored_mqtt_password
 621  0044 cd0000        	call	_strlen
 623  0047 1d0004        	subw	x,#4
 624  004a 72fb01        	addw	x,(OFST-1,sp)
 626                     ; 1397     size = size - 15;
 628  004d 1c0659        	addw	x,#1625
 630                     ; 1411     size = size + (3 * page_string03_len_less4);
 633                     ; 1440     size = size + (12 * (page_string00_len_less4));
 636                     ; 1449     size = size + (4 * (page_string00_len_less4));
 639                     ; 1459     size = size + (6 * (page_string01_len_less4));
 642                     ; 1468     size = size + (3 * (page_string02_len_less4));
 646  0050 2007          	jra	L711
 647  0052               L121:
 648                     ; 1578   else if (current_webpage == WEBPAGE_RSTATE) {
 650  0052 a106          	cp	a,#6
 651  0054 2603          	jrne	L711
 652                     ; 1579     size = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
 654                     ; 1584     size = size + 12;
 656  0056 ae0093        	ldw	x,#147
 658  0059               L711:
 659                     ; 1587   return size;
 663  0059 5b02          	addw	sp,#2
 664  005b 81            	ret	
 755                     ; 1591 void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
 755                     ; 1592 {
 756                     .text:	section	.text,new
 757  0000               _emb_itoa:
 759  0000 5207          	subw	sp,#7
 760       00000007      OFST:	set	7
 763                     ; 1610   for (i=0; i < pad; i++) str[i] = '0';
 765  0002 0f07          	clr	(OFST+0,sp)
 768  0004 200a          	jra	L171
 769  0006               L561:
 772  0006 5f            	clrw	x
 773  0007 97            	ld	xl,a
 774  0008 72fb0e        	addw	x,(OFST+7,sp)
 775  000b a630          	ld	a,#48
 776  000d f7            	ld	(x),a
 779  000e 0c07          	inc	(OFST+0,sp)
 781  0010               L171:
 784  0010 7b07          	ld	a,(OFST+0,sp)
 785  0012 1111          	cp	a,(OFST+10,sp)
 786  0014 25f0          	jrult	L561
 787                     ; 1611   str[pad] = '\0';
 789  0016 7b11          	ld	a,(OFST+10,sp)
 790  0018 5f            	clrw	x
 791  0019 97            	ld	xl,a
 792  001a 72fb0e        	addw	x,(OFST+7,sp)
 793  001d 7f            	clr	(x)
 794                     ; 1612   if (num == 0) return;
 796  001e 96            	ldw	x,sp
 797  001f 1c000a        	addw	x,#OFST+3
 798  0022 cd0000        	call	c_lzmp
 800  0025 2603cc00cf    	jreq	L02
 803                     ; 1615   i = 0;
 805  002a 0f07          	clr	(OFST+0,sp)
 808  002c 2060          	jra	L302
 809  002e               L771:
 810                     ; 1617     rem = (uint8_t)(num % base);
 812  002e 7b10          	ld	a,(OFST+9,sp)
 813  0030 b703          	ld	c_lreg+3,a
 814  0032 3f02          	clr	c_lreg+2
 815  0034 3f01          	clr	c_lreg+1
 816  0036 3f00          	clr	c_lreg
 817  0038 96            	ldw	x,sp
 818  0039 5c            	incw	x
 819  003a cd0000        	call	c_rtol
 822  003d 96            	ldw	x,sp
 823  003e 1c000a        	addw	x,#OFST+3
 824  0041 cd0000        	call	c_ltor
 826  0044 96            	ldw	x,sp
 827  0045 5c            	incw	x
 828  0046 cd0000        	call	c_lumd
 830  0049 b603          	ld	a,c_lreg+3
 831  004b 6b06          	ld	(OFST-1,sp),a
 833                     ; 1618     if (rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
 835  004d a10a          	cp	a,#10
 836  004f 7b07          	ld	a,(OFST+0,sp)
 837  0051 250d          	jrult	L702
 840  0053 0c07          	inc	(OFST+0,sp)
 842  0055 5f            	clrw	x
 843  0056 97            	ld	xl,a
 844  0057 72fb0e        	addw	x,(OFST+7,sp)
 845  005a 7b06          	ld	a,(OFST-1,sp)
 846  005c ab57          	add	a,#87
 848  005e 200b          	jra	L112
 849  0060               L702:
 850                     ; 1619     else str[i++] = (uint8_t)(rem + '0');
 852  0060 0c07          	inc	(OFST+0,sp)
 854  0062 5f            	clrw	x
 855  0063 97            	ld	xl,a
 856  0064 72fb0e        	addw	x,(OFST+7,sp)
 857  0067 7b06          	ld	a,(OFST-1,sp)
 858  0069 ab30          	add	a,#48
 859  006b               L112:
 860  006b f7            	ld	(x),a
 861                     ; 1620     num = num/base;
 863  006c 7b10          	ld	a,(OFST+9,sp)
 864  006e b703          	ld	c_lreg+3,a
 865  0070 3f02          	clr	c_lreg+2
 866  0072 3f01          	clr	c_lreg+1
 867  0074 3f00          	clr	c_lreg
 868  0076 96            	ldw	x,sp
 869  0077 5c            	incw	x
 870  0078 cd0000        	call	c_rtol
 873  007b 96            	ldw	x,sp
 874  007c 1c000a        	addw	x,#OFST+3
 875  007f cd0000        	call	c_ltor
 877  0082 96            	ldw	x,sp
 878  0083 5c            	incw	x
 879  0084 cd0000        	call	c_ludv
 881  0087 96            	ldw	x,sp
 882  0088 1c000a        	addw	x,#OFST+3
 883  008b cd0000        	call	c_rtol
 885  008e               L302:
 886                     ; 1616   while (num != 0) {
 888  008e 96            	ldw	x,sp
 889  008f 1c000a        	addw	x,#OFST+3
 890  0092 cd0000        	call	c_lzmp
 892  0095 2697          	jrne	L771
 893                     ; 1629     start = 0;
 895  0097 0f06          	clr	(OFST-1,sp)
 897                     ; 1630     end = (uint8_t)(pad - 1);
 899  0099 7b11          	ld	a,(OFST+10,sp)
 900  009b 4a            	dec	a
 901  009c 6b07          	ld	(OFST+0,sp),a
 904  009e 2029          	jra	L712
 905  00a0               L312:
 906                     ; 1633       temp = str[start];
 908  00a0 5f            	clrw	x
 909  00a1 97            	ld	xl,a
 910  00a2 72fb0e        	addw	x,(OFST+7,sp)
 911  00a5 f6            	ld	a,(x)
 912  00a6 6b05          	ld	(OFST-2,sp),a
 914                     ; 1634       str[start] = str[end];
 916  00a8 5f            	clrw	x
 917  00a9 7b06          	ld	a,(OFST-1,sp)
 918  00ab 97            	ld	xl,a
 919  00ac 72fb0e        	addw	x,(OFST+7,sp)
 920  00af 7b07          	ld	a,(OFST+0,sp)
 921  00b1 905f          	clrw	y
 922  00b3 9097          	ld	yl,a
 923  00b5 72f90e        	addw	y,(OFST+7,sp)
 924  00b8 90f6          	ld	a,(y)
 925  00ba f7            	ld	(x),a
 926                     ; 1635       str[end] = temp;
 928  00bb 5f            	clrw	x
 929  00bc 7b07          	ld	a,(OFST+0,sp)
 930  00be 97            	ld	xl,a
 931  00bf 72fb0e        	addw	x,(OFST+7,sp)
 932  00c2 7b05          	ld	a,(OFST-2,sp)
 933  00c4 f7            	ld	(x),a
 934                     ; 1636       start++;
 936  00c5 0c06          	inc	(OFST-1,sp)
 938                     ; 1637       end--;
 940  00c7 0a07          	dec	(OFST+0,sp)
 942  00c9               L712:
 943                     ; 1632     while (start < end) {
 943                     ; 1633       temp = str[start];
 943                     ; 1634       str[start] = str[end];
 943                     ; 1635       str[end] = temp;
 943                     ; 1636       start++;
 943                     ; 1637       end--;
 945  00c9 7b06          	ld	a,(OFST-1,sp)
 946  00cb 1107          	cp	a,(OFST+0,sp)
 947  00cd 25d1          	jrult	L312
 948                     ; 1640 }
 949  00cf               L02:
 952  00cf 5b07          	addw	sp,#7
 953  00d1 81            	ret	
1013                     ; 1643 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1013                     ; 1644 {
1014                     .text:	section	.text,new
1015  0000               L3_CopyStringP:
1017  0000 89            	pushw	x
1018  0001 5203          	subw	sp,#3
1019       00000003      OFST:	set	3
1022                     ; 1649   nBytes = 0;
1024  0003 5f            	clrw	x
1026  0004 2014          	jra	L552
1027  0006               L152:
1028                     ; 1651     **ppBuffer = Character;
1030  0006 1e04          	ldw	x,(OFST+1,sp)
1031  0008 fe            	ldw	x,(x)
1032  0009 f7            	ld	(x),a
1033                     ; 1652     *ppBuffer = *ppBuffer + 1;
1035  000a 1e04          	ldw	x,(OFST+1,sp)
1036  000c 9093          	ldw	y,x
1037  000e fe            	ldw	x,(x)
1038  000f 5c            	incw	x
1039  0010 90ff          	ldw	(y),x
1040                     ; 1653     pString = pString + 1;
1042  0012 1e08          	ldw	x,(OFST+5,sp)
1043  0014 5c            	incw	x
1044  0015 1f08          	ldw	(OFST+5,sp),x
1045                     ; 1654     nBytes++;
1047  0017 1e01          	ldw	x,(OFST-2,sp)
1048  0019 5c            	incw	x
1049  001a               L552:
1050  001a 1f01          	ldw	(OFST-2,sp),x
1052                     ; 1650   while ((Character = pString[0]) != '\0') {
1052                     ; 1651     **ppBuffer = Character;
1052                     ; 1652     *ppBuffer = *ppBuffer + 1;
1052                     ; 1653     pString = pString + 1;
1052                     ; 1654     nBytes++;
1054  001c 1e08          	ldw	x,(OFST+5,sp)
1055  001e f6            	ld	a,(x)
1056  001f 6b03          	ld	(OFST+0,sp),a
1058  0021 26e3          	jrne	L152
1059                     ; 1656   return nBytes;
1061  0023 1e01          	ldw	x,(OFST-2,sp)
1064  0025 5b05          	addw	sp,#5
1065  0027 81            	ret	
1124                     ; 1660 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen)
1124                     ; 1661 {
1125                     .text:	section	.text,new
1126  0000               L5_CopyHttpHeader:
1128  0000 89            	pushw	x
1129  0001 5203          	subw	sp,#3
1130       00000003      OFST:	set	3
1133                     ; 1665   nBytes = 0;
1135  0003 5f            	clrw	x
1136  0004 1f02          	ldw	(OFST-1,sp),x
1138                     ; 1667   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
1140  0006 ae1c37        	ldw	x,#L503
1141  0009 89            	pushw	x
1142  000a 96            	ldw	x,sp
1143  000b 1c0006        	addw	x,#OFST+3
1144  000e cd0000        	call	L3_CopyStringP
1146  0011 5b02          	addw	sp,#2
1147  0013 72fb02        	addw	x,(OFST-1,sp)
1148  0016 1f02          	ldw	(OFST-1,sp),x
1150                     ; 1668   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1152  0018 ae1c34        	ldw	x,#L703
1153  001b 89            	pushw	x
1154  001c 96            	ldw	x,sp
1155  001d 1c0006        	addw	x,#OFST+3
1156  0020 cd0000        	call	L3_CopyStringP
1158  0023 5b02          	addw	sp,#2
1159  0025 72fb02        	addw	x,(OFST-1,sp)
1160  0028 1f02          	ldw	(OFST-1,sp),x
1162                     ; 1670   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
1164  002a ae1c24        	ldw	x,#L113
1165  002d 89            	pushw	x
1166  002e 96            	ldw	x,sp
1167  002f 1c0006        	addw	x,#OFST+3
1168  0032 cd0000        	call	L3_CopyStringP
1170  0035 5b02          	addw	sp,#2
1171  0037 72fb02        	addw	x,(OFST-1,sp)
1172  003a 1f02          	ldw	(OFST-1,sp),x
1174                     ; 1674   emb_itoa(nDataLen, OctetArray, 10, 5);
1176  003c 4b05          	push	#5
1177  003e 4b0a          	push	#10
1178  0040 ae0045        	ldw	x,#_OctetArray
1179  0043 89            	pushw	x
1180  0044 1e0c          	ldw	x,(OFST+9,sp)
1181  0046 cd0000        	call	c_uitolx
1183  0049 be02          	ldw	x,c_lreg+2
1184  004b 89            	pushw	x
1185  004c be00          	ldw	x,c_lreg
1186  004e 89            	pushw	x
1187  004f cd0000        	call	_emb_itoa
1189  0052 5b08          	addw	sp,#8
1190                     ; 1675   for (i=0; i<5; i++) {
1192  0054 4f            	clr	a
1193  0055 6b01          	ld	(OFST-2,sp),a
1195  0057               L313:
1196                     ; 1676     *pBuffer = (uint8_t)OctetArray[i];
1198  0057 5f            	clrw	x
1199  0058 97            	ld	xl,a
1200  0059 d60045        	ld	a,(_OctetArray,x)
1201  005c 1e04          	ldw	x,(OFST+1,sp)
1202  005e f7            	ld	(x),a
1203                     ; 1677     pBuffer = pBuffer + 1;
1205  005f 5c            	incw	x
1206  0060 1f04          	ldw	(OFST+1,sp),x
1207                     ; 1675   for (i=0; i<5; i++) {
1209  0062 0c01          	inc	(OFST-2,sp)
1213  0064 7b01          	ld	a,(OFST-2,sp)
1214  0066 a105          	cp	a,#5
1215  0068 25ed          	jrult	L313
1216                     ; 1679   nBytes += 5;
1218  006a 1e02          	ldw	x,(OFST-1,sp)
1219  006c 1c0005        	addw	x,#5
1220  006f 1f02          	ldw	(OFST-1,sp),x
1222                     ; 1681   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1224  0071 ae1c34        	ldw	x,#L703
1225  0074 89            	pushw	x
1226  0075 96            	ldw	x,sp
1227  0076 1c0006        	addw	x,#OFST+3
1228  0079 cd0000        	call	L3_CopyStringP
1230  007c 5b02          	addw	sp,#2
1231  007e 72fb02        	addw	x,(OFST-1,sp)
1232  0081 1f02          	ldw	(OFST-1,sp),x
1234                     ; 1684   nBytes += CopyStringP(&pBuffer, (const char *)("Cache-Control: no-cache, no-store\r\n"));
1236  0083 ae1c00        	ldw	x,#L123
1237  0086 89            	pushw	x
1238  0087 96            	ldw	x,sp
1239  0088 1c0006        	addw	x,#OFST+3
1240  008b cd0000        	call	L3_CopyStringP
1242  008e 5b02          	addw	sp,#2
1243  0090 72fb02        	addw	x,(OFST-1,sp)
1244  0093 1f02          	ldw	(OFST-1,sp),x
1246                     ; 1686   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type: text/html; charset=utf-8\r\n"));
1248  0095 ae1bd7        	ldw	x,#L323
1249  0098 89            	pushw	x
1250  0099 96            	ldw	x,sp
1251  009a 1c0006        	addw	x,#OFST+3
1252  009d cd0000        	call	L3_CopyStringP
1254  00a0 5b02          	addw	sp,#2
1255  00a2 72fb02        	addw	x,(OFST-1,sp)
1256  00a5 1f02          	ldw	(OFST-1,sp),x
1258                     ; 1688   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
1260  00a7 ae1bc4        	ldw	x,#L523
1261  00aa 89            	pushw	x
1262  00ab 96            	ldw	x,sp
1263  00ac 1c0006        	addw	x,#OFST+3
1264  00af cd0000        	call	L3_CopyStringP
1266  00b2 5b02          	addw	sp,#2
1267  00b4 72fb02        	addw	x,(OFST-1,sp)
1268  00b7 1f02          	ldw	(OFST-1,sp),x
1270                     ; 1689   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1272  00b9 ae1c34        	ldw	x,#L703
1273  00bc 89            	pushw	x
1274  00bd 96            	ldw	x,sp
1275  00be 1c0006        	addw	x,#OFST+3
1276  00c1 cd0000        	call	L3_CopyStringP
1278  00c4 5b02          	addw	sp,#2
1279  00c6 72fb02        	addw	x,(OFST-1,sp)
1281                     ; 1691   return nBytes;
1285  00c9 5b05          	addw	sp,#5
1286  00cb 81            	ret	
1432                     	switch	.const
1433  1b44               L431:
1434  1b44 01b2          	dc.w	L723
1435  1b46 01c0          	dc.w	L133
1436  1b48 01ce          	dc.w	L333
1437  1b4a 01dc          	dc.w	L533
1438  1b4c 01ea          	dc.w	L733
1439  1b4e 01f8          	dc.w	L143
1440  1b50 0206          	dc.w	L343
1441  1b52 0213          	dc.w	L543
1442  1b54 0220          	dc.w	L743
1443  1b56 022d          	dc.w	L153
1444  1b58 023a          	dc.w	L353
1445  1b5a 0247          	dc.w	L553
1446  1b5c 0254          	dc.w	L753
1447  1b5e 0261          	dc.w	L163
1448  1b60 026e          	dc.w	L363
1449  1b62 027b          	dc.w	L563
1450                     ; 1695 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
1450                     ; 1696 {
1451                     .text:	section	.text,new
1452  0000               L7_CopyHttpData:
1454  0000 89            	pushw	x
1455  0001 5207          	subw	sp,#7
1456       00000007      OFST:	set	7
1459                     ; 1714   nBytes = 0;
1461  0003 5f            	clrw	x
1462  0004 1f04          	ldw	(OFST-3,sp),x
1464                     ; 1715   nParsedNum = 0;
1466  0006 0f06          	clr	(OFST-1,sp)
1468                     ; 1716   nParsedMode = 0;
1470  0008 0f03          	clr	(OFST-4,sp)
1472                     ; 1771   nMaxBytes = UIP_TCP_MSS - 25;
1474  000a ae019f        	ldw	x,#415
1475  000d 1f10          	ldw	(OFST+9,sp),x
1477  000f cc054b        	jra	L574
1478  0012               L374:
1479                     ; 1805     if (*pDataLeft > 0) {
1481  0012 1e0e          	ldw	x,(OFST+7,sp)
1482  0014 e601          	ld	a,(1,x)
1483  0016 fa            	or	a,(x)
1484  0017 2603cc0554    	jreq	L774
1485                     ; 1812       if (insertion_flag[0] != 0) {
1487  001c c60000        	ld	a,_insertion_flag
1488  001f 2711          	jreq	L305
1489                     ; 1821         nParsedMode = insertion_flag[1];
1491  0021 c60001        	ld	a,_insertion_flag+1
1492  0024 6b03          	ld	(OFST-4,sp),a
1494                     ; 1822         nParsedNum = insertion_flag[2];
1496  0026 c60002        	ld	a,_insertion_flag+2
1497  0029 6b06          	ld	(OFST-1,sp),a
1499                     ; 1823 	nByte = '0'; // Need to set nByte to something other than '%' so we
1501  002b a630          	ld	a,#48
1502  002d 6b02          	ld	(OFST-5,sp),a
1505  002f cc00f1        	jra	L505
1506  0032               L305:
1507                     ; 1836         memcpy(&nByte, *ppData, 1);
1509  0032 96            	ldw	x,sp
1510  0033 1c0002        	addw	x,#OFST-5
1511  0036 bf00          	ldw	c_x,x
1512  0038 160c          	ldw	y,(OFST+5,sp)
1513  003a 90fe          	ldw	y,(y)
1514  003c 90bf00        	ldw	c_y,y
1515  003f ae0001        	ldw	x,#1
1516  0042               L25:
1517  0042 5a            	decw	x
1518  0043 92d600        	ld	a,([c_y.w],x)
1519  0046 92d700        	ld	([c_x.w],x),a
1520  0049 5d            	tnzw	x
1521  004a 26f6          	jrne	L25
1522                     ; 1879         if (nByte == '%') {
1524  004c 7b02          	ld	a,(OFST-5,sp)
1525  004e a125          	cp	a,#37
1526  0050 26dd          	jrne	L505
1527                     ; 1880           *ppData = *ppData + 1;
1529  0052 1e0c          	ldw	x,(OFST+5,sp)
1530  0054 9093          	ldw	y,x
1531  0056 fe            	ldw	x,(x)
1532  0057 5c            	incw	x
1533  0058 90ff          	ldw	(y),x
1534                     ; 1881           *pDataLeft = *pDataLeft - 1;
1536  005a 1e0e          	ldw	x,(OFST+7,sp)
1537  005c 9093          	ldw	y,x
1538  005e fe            	ldw	x,(x)
1539  005f 5a            	decw	x
1540  0060 90ff          	ldw	(y),x
1541                     ; 1886           memcpy(&nParsedMode, *ppData, 1);
1543  0062 96            	ldw	x,sp
1544  0063 1c0003        	addw	x,#OFST-4
1545  0066 bf00          	ldw	c_x,x
1546  0068 160c          	ldw	y,(OFST+5,sp)
1547  006a 90fe          	ldw	y,(y)
1548  006c 90bf00        	ldw	c_y,y
1549  006f ae0001        	ldw	x,#1
1550  0072               L45:
1551  0072 5a            	decw	x
1552  0073 92d600        	ld	a,([c_y.w],x)
1553  0076 92d700        	ld	([c_x.w],x),a
1554  0079 5d            	tnzw	x
1555  007a 26f6          	jrne	L45
1556                     ; 1887           *ppData = *ppData + 1;
1558  007c 1e0c          	ldw	x,(OFST+5,sp)
1559  007e 9093          	ldw	y,x
1560  0080 fe            	ldw	x,(x)
1561  0081 5c            	incw	x
1562  0082 90ff          	ldw	(y),x
1563                     ; 1888           *pDataLeft = *pDataLeft - 1;
1565  0084 1e0e          	ldw	x,(OFST+7,sp)
1566  0086 9093          	ldw	y,x
1567  0088 fe            	ldw	x,(x)
1568  0089 5a            	decw	x
1569  008a 90ff          	ldw	(y),x
1570                     ; 1893           memcpy(&temp, *ppData, 1);
1572  008c 96            	ldw	x,sp
1573  008d 5c            	incw	x
1574  008e bf00          	ldw	c_x,x
1575  0090 160c          	ldw	y,(OFST+5,sp)
1576  0092 90fe          	ldw	y,(y)
1577  0094 90bf00        	ldw	c_y,y
1578  0097 ae0001        	ldw	x,#1
1579  009a               L65:
1580  009a 5a            	decw	x
1581  009b 92d600        	ld	a,([c_y.w],x)
1582  009e 92d700        	ld	([c_x.w],x),a
1583  00a1 5d            	tnzw	x
1584  00a2 26f6          	jrne	L65
1585                     ; 1894           nParsedNum = (uint8_t)((temp - '0') * 10);
1587  00a4 7b01          	ld	a,(OFST-6,sp)
1588  00a6 97            	ld	xl,a
1589  00a7 a60a          	ld	a,#10
1590  00a9 42            	mul	x,a
1591  00aa 9f            	ld	a,xl
1592  00ab a0e0          	sub	a,#224
1593  00ad 6b06          	ld	(OFST-1,sp),a
1595                     ; 1895           *ppData = *ppData + 1;
1597  00af 1e0c          	ldw	x,(OFST+5,sp)
1598  00b1 9093          	ldw	y,x
1599  00b3 fe            	ldw	x,(x)
1600  00b4 5c            	incw	x
1601  00b5 90ff          	ldw	(y),x
1602                     ; 1896           *pDataLeft = *pDataLeft - 1;
1604  00b7 1e0e          	ldw	x,(OFST+7,sp)
1605  00b9 9093          	ldw	y,x
1606  00bb fe            	ldw	x,(x)
1607  00bc 5a            	decw	x
1608  00bd 90ff          	ldw	(y),x
1609                     ; 1901           memcpy(&temp, *ppData, 1);
1611  00bf 96            	ldw	x,sp
1612  00c0 5c            	incw	x
1613  00c1 bf00          	ldw	c_x,x
1614  00c3 160c          	ldw	y,(OFST+5,sp)
1615  00c5 90fe          	ldw	y,(y)
1616  00c7 90bf00        	ldw	c_y,y
1617  00ca ae0001        	ldw	x,#1
1618  00cd               L06:
1619  00cd 5a            	decw	x
1620  00ce 92d600        	ld	a,([c_y.w],x)
1621  00d1 92d700        	ld	([c_x.w],x),a
1622  00d4 5d            	tnzw	x
1623  00d5 26f6          	jrne	L06
1624                     ; 1902           nParsedNum = (uint8_t)(nParsedNum + temp - '0');
1626  00d7 7b06          	ld	a,(OFST-1,sp)
1627  00d9 1b01          	add	a,(OFST-6,sp)
1628  00db a030          	sub	a,#48
1629  00dd 6b06          	ld	(OFST-1,sp),a
1631                     ; 1903           *ppData = *ppData + 1;
1633  00df 1e0c          	ldw	x,(OFST+5,sp)
1634  00e1 9093          	ldw	y,x
1635  00e3 fe            	ldw	x,(x)
1636  00e4 5c            	incw	x
1637  00e5 90ff          	ldw	(y),x
1638                     ; 1904           *pDataLeft = *pDataLeft - 1;
1640  00e7 1e0e          	ldw	x,(OFST+7,sp)
1641  00e9 9093          	ldw	y,x
1642  00eb fe            	ldw	x,(x)
1643  00ec 5a            	decw	x
1644  00ed 90ff          	ldw	(y),x
1645  00ef 7b02          	ld	a,(OFST-5,sp)
1646  00f1               L505:
1647                     ; 1908       if ((nByte == '%') || (insertion_flag[0] != 0)) {
1649  00f1 a125          	cp	a,#37
1650  00f3 2709          	jreq	L315
1652  00f5 725d0000      	tnz	_insertion_flag
1653  00f9 2603cc052e    	jreq	L115
1654  00fe               L315:
1655                     ; 1918         if (nParsedMode == 'i') {
1657  00fe 7b03          	ld	a,(OFST-4,sp)
1658  0100 a169          	cp	a,#105
1659  0102 2630          	jrne	L515
1660                     ; 1932           if (nParsedNum > 7) {
1662  0104 7b06          	ld	a,(OFST-1,sp)
1663  0106 a108          	cp	a,#8
1664  0108 2520          	jrult	L715
1665                     ; 1934 	    i = GpioGetPin(nParsedNum);
1667  010a cd0000        	call	_GpioGetPin
1669  010d 6b07          	ld	(OFST+0,sp),a
1671                     ; 1935 	    if (invert_input == 0x00) *pBuffer = (uint8_t)(i + '0');
1673  010f 725d0000      	tnz	_invert_input
1674  0113 2607          	jrne	L125
1677  0115 ab30          	add	a,#48
1678  0117 1e08          	ldw	x,(OFST+1,sp)
1680  0119 cc036e        	jra	LC008
1681  011c               L125:
1682                     ; 1937 	      if (i == 0) *pBuffer = (uint8_t)('1');
1684  011c 7b07          	ld	a,(OFST+0,sp)
1687  011e 2603cc045a    	jreq	LC009
1688                     ; 1938 	      else *pBuffer = (uint8_t)('0');
1690  0123 1e08          	ldw	x,(OFST+1,sp)
1691  0125 a630          	ld	a,#48
1692                     ; 1940             pBuffer++;
1693                     ; 1941             nBytes++;
1695  0127 cc036e        	jp	LC008
1696  012a               L715:
1697                     ; 1945 	    *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
1699  012a cd0000        	call	_GpioGetPin
1701  012d ab30          	add	a,#48
1702  012f 1e08          	ldw	x,(OFST+1,sp)
1703                     ; 1946             pBuffer++;
1704                     ; 1947             nBytes++;
1705  0131 cc036e        	jp	LC008
1706  0134               L515:
1707                     ; 1965         else if ((nParsedMode == 'o' && ((uint8_t)(GpioGetPin(nParsedNum) == 1)))
1707                     ; 1966 	      || (nParsedMode == 'p' && ((uint8_t)(GpioGetPin(nParsedNum) == 0)))) { 
1709  0134 a16f          	cp	a,#111
1710  0136 260a          	jrne	L145
1712  0138 7b06          	ld	a,(OFST-1,sp)
1713  013a cd0000        	call	_GpioGetPin
1715  013d 4a            	dec	a
1716  013e 270e          	jreq	L735
1717  0140 7b03          	ld	a,(OFST-4,sp)
1718  0142               L145:
1720  0142 a170          	cp	a,#112
1721  0144 2626          	jrne	L535
1723  0146 7b06          	ld	a,(OFST-1,sp)
1724  0148 cd0000        	call	_GpioGetPin
1726  014b 4d            	tnz	a
1727  014c 261e          	jrne	L535
1728  014e               L735:
1729                     ; 1971           for(i=0; i<7; i++) {
1731  014e 4f            	clr	a
1732  014f 6b07          	ld	(OFST+0,sp),a
1734  0151               L345:
1735                     ; 1972             *pBuffer = checked[i];
1737  0151 5f            	clrw	x
1738  0152 97            	ld	xl,a
1739  0153 d60000        	ld	a,(L11_checked,x)
1740  0156 1e08          	ldw	x,(OFST+1,sp)
1741  0158 f7            	ld	(x),a
1742                     ; 1973             pBuffer++;
1744  0159 5c            	incw	x
1745  015a 1f08          	ldw	(OFST+1,sp),x
1746                     ; 1971           for(i=0; i<7; i++) {
1748  015c 0c07          	inc	(OFST+0,sp)
1752  015e 7b07          	ld	a,(OFST+0,sp)
1753  0160 a107          	cp	a,#7
1754  0162 25ed          	jrult	L345
1755                     ; 1975 	  nBytes += 7;
1757  0164 1e04          	ldw	x,(OFST-3,sp)
1758  0166 1c0007        	addw	x,#7
1760  0169 cc0549        	jp	LC005
1761  016c               L535:
1762                     ; 1978         else if (nParsedMode == 'a') {
1764  016c 7b03          	ld	a,(OFST-4,sp)
1765  016e a161          	cp	a,#97
1766  0170 2629          	jrne	L355
1767                     ; 1980 	  for(i=0; i<19; i++) {
1769  0172 4f            	clr	a
1770  0173 6b07          	ld	(OFST+0,sp),a
1772  0175               L555:
1773                     ; 1981 	    if (stored_devicename[i] != '\0') {
1775  0175 5f            	clrw	x
1776  0176 97            	ld	xl,a
1777  0177 724d0000      	tnz	(_stored_devicename,x)
1778  017b 2603cc054b    	jreq	L574
1779                     ; 1982               *pBuffer = (uint8_t)(stored_devicename[i]);
1781  0180 5f            	clrw	x
1782  0181 97            	ld	xl,a
1783  0182 d60000        	ld	a,(_stored_devicename,x)
1784  0185 1e08          	ldw	x,(OFST+1,sp)
1785  0187 f7            	ld	(x),a
1786                     ; 1983               pBuffer++;
1788  0188 5c            	incw	x
1789  0189 1f08          	ldw	(OFST+1,sp),x
1790                     ; 1984               nBytes++;
1792  018b 1e04          	ldw	x,(OFST-3,sp)
1793  018d 5c            	incw	x
1794  018e 1f04          	ldw	(OFST-3,sp),x
1797                     ; 1980 	  for(i=0; i<19; i++) {
1799  0190 0c07          	inc	(OFST+0,sp)
1803  0192 7b07          	ld	a,(OFST+0,sp)
1804  0194 a113          	cp	a,#19
1805  0196 25dd          	jrult	L555
1806  0198 cc054b        	jra	L574
1807  019b               L355:
1808                     ; 1990         else if (nParsedMode == 'b') {
1810  019b a162          	cp	a,#98
1811  019d 2703cc02b7    	jrne	L175
1812                     ; 1995           switch (nParsedNum)
1814  01a2 7b06          	ld	a,(OFST-1,sp)
1816                     ; 2016 	    default: break;
1817  01a4 a110          	cp	a,#16
1818  01a6 2503cc0299    	jruge	L575
1819  01ab 5f            	clrw	x
1820  01ac 97            	ld	xl,a
1821  01ad 58            	sllw	x
1822  01ae de1b44        	ldw	x,(L431,x)
1823  01b1 fc            	jp	(x)
1824  01b2               L723:
1825                     ; 1998 	    case 0:  emb_itoa(stored_hostaddr[3], OctetArray, 10, 3); break;
1827  01b2 4b03          	push	#3
1828  01b4 4b0a          	push	#10
1829  01b6 ae0045        	ldw	x,#_OctetArray
1830  01b9 89            	pushw	x
1831  01ba c60003        	ld	a,_stored_hostaddr+3
1835  01bd cc0286        	jp	LC001
1836  01c0               L133:
1837                     ; 1999 	    case 1:  emb_itoa(stored_hostaddr[2], OctetArray, 10, 3); break;
1839  01c0 4b03          	push	#3
1840  01c2 4b0a          	push	#10
1841  01c4 ae0045        	ldw	x,#_OctetArray
1842  01c7 89            	pushw	x
1843  01c8 c60002        	ld	a,_stored_hostaddr+2
1847  01cb cc0286        	jp	LC001
1848  01ce               L333:
1849                     ; 2000 	    case 2:  emb_itoa(stored_hostaddr[1], OctetArray, 10, 3); break;
1851  01ce 4b03          	push	#3
1852  01d0 4b0a          	push	#10
1853  01d2 ae0045        	ldw	x,#_OctetArray
1854  01d5 89            	pushw	x
1855  01d6 c60001        	ld	a,_stored_hostaddr+1
1859  01d9 cc0286        	jp	LC001
1860  01dc               L533:
1861                     ; 2001 	    case 3:  emb_itoa(stored_hostaddr[0], OctetArray, 10, 3); break;
1863  01dc 4b03          	push	#3
1864  01de 4b0a          	push	#10
1865  01e0 ae0045        	ldw	x,#_OctetArray
1866  01e3 89            	pushw	x
1867  01e4 c60000        	ld	a,_stored_hostaddr
1871  01e7 cc0286        	jp	LC001
1872  01ea               L733:
1873                     ; 2002 	    case 4:  emb_itoa(stored_draddr[3],   OctetArray, 10, 3); break;
1875  01ea 4b03          	push	#3
1876  01ec 4b0a          	push	#10
1877  01ee ae0045        	ldw	x,#_OctetArray
1878  01f1 89            	pushw	x
1879  01f2 c60003        	ld	a,_stored_draddr+3
1883  01f5 cc0286        	jp	LC001
1884  01f8               L143:
1885                     ; 2003 	    case 5:  emb_itoa(stored_draddr[2],   OctetArray, 10, 3); break;
1887  01f8 4b03          	push	#3
1888  01fa 4b0a          	push	#10
1889  01fc ae0045        	ldw	x,#_OctetArray
1890  01ff 89            	pushw	x
1891  0200 c60002        	ld	a,_stored_draddr+2
1895  0203 cc0286        	jp	LC001
1896  0206               L343:
1897                     ; 2004 	    case 6:  emb_itoa(stored_draddr[1],   OctetArray, 10, 3); break;
1899  0206 4b03          	push	#3
1900  0208 4b0a          	push	#10
1901  020a ae0045        	ldw	x,#_OctetArray
1902  020d 89            	pushw	x
1903  020e c60001        	ld	a,_stored_draddr+1
1907  0211 2073          	jp	LC001
1908  0213               L543:
1909                     ; 2005 	    case 7:  emb_itoa(stored_draddr[0],   OctetArray, 10, 3); break;
1911  0213 4b03          	push	#3
1912  0215 4b0a          	push	#10
1913  0217 ae0045        	ldw	x,#_OctetArray
1914  021a 89            	pushw	x
1915  021b c60000        	ld	a,_stored_draddr
1919  021e 2066          	jp	LC001
1920  0220               L743:
1921                     ; 2006 	    case 8:  emb_itoa(stored_netmask[3],  OctetArray, 10, 3); break;
1923  0220 4b03          	push	#3
1924  0222 4b0a          	push	#10
1925  0224 ae0045        	ldw	x,#_OctetArray
1926  0227 89            	pushw	x
1927  0228 c60003        	ld	a,_stored_netmask+3
1931  022b 2059          	jp	LC001
1932  022d               L153:
1933                     ; 2007 	    case 9:  emb_itoa(stored_netmask[2],  OctetArray, 10, 3); break;
1935  022d 4b03          	push	#3
1936  022f 4b0a          	push	#10
1937  0231 ae0045        	ldw	x,#_OctetArray
1938  0234 89            	pushw	x
1939  0235 c60002        	ld	a,_stored_netmask+2
1943  0238 204c          	jp	LC001
1944  023a               L353:
1945                     ; 2008 	    case 10: emb_itoa(stored_netmask[1],  OctetArray, 10, 3); break;
1947  023a 4b03          	push	#3
1948  023c 4b0a          	push	#10
1949  023e ae0045        	ldw	x,#_OctetArray
1950  0241 89            	pushw	x
1951  0242 c60001        	ld	a,_stored_netmask+1
1955  0245 203f          	jp	LC001
1956  0247               L553:
1957                     ; 2009 	    case 11: emb_itoa(stored_netmask[0],  OctetArray, 10, 3); break;
1959  0247 4b03          	push	#3
1960  0249 4b0a          	push	#10
1961  024b ae0045        	ldw	x,#_OctetArray
1962  024e 89            	pushw	x
1963  024f c60000        	ld	a,_stored_netmask
1967  0252 2032          	jp	LC001
1968  0254               L753:
1969                     ; 2011 	    case 12: emb_itoa(stored_mqttserveraddr[3], OctetArray, 10, 3); break;
1971  0254 4b03          	push	#3
1972  0256 4b0a          	push	#10
1973  0258 ae0045        	ldw	x,#_OctetArray
1974  025b 89            	pushw	x
1975  025c c60003        	ld	a,_stored_mqttserveraddr+3
1979  025f 2025          	jp	LC001
1980  0261               L163:
1981                     ; 2012 	    case 13: emb_itoa(stored_mqttserveraddr[2], OctetArray, 10, 3); break;
1983  0261 4b03          	push	#3
1984  0263 4b0a          	push	#10
1985  0265 ae0045        	ldw	x,#_OctetArray
1986  0268 89            	pushw	x
1987  0269 c60002        	ld	a,_stored_mqttserveraddr+2
1991  026c 2018          	jp	LC001
1992  026e               L363:
1993                     ; 2013 	    case 14: emb_itoa(stored_mqttserveraddr[1], OctetArray, 10, 3); break;
1995  026e 4b03          	push	#3
1996  0270 4b0a          	push	#10
1997  0272 ae0045        	ldw	x,#_OctetArray
1998  0275 89            	pushw	x
1999  0276 c60001        	ld	a,_stored_mqttserveraddr+1
2003  0279 200b          	jp	LC001
2004  027b               L563:
2005                     ; 2014 	    case 15: emb_itoa(stored_mqttserveraddr[0], OctetArray, 10, 3); break;
2007  027b 4b03          	push	#3
2008  027d 4b0a          	push	#10
2009  027f ae0045        	ldw	x,#_OctetArray
2010  0282 89            	pushw	x
2011  0283 c60000        	ld	a,_stored_mqttserveraddr
2013  0286               LC001:
2014  0286 b703          	ld	c_lreg+3,a
2015  0288 3f02          	clr	c_lreg+2
2016  028a 3f01          	clr	c_lreg+1
2017  028c 3f00          	clr	c_lreg
2018  028e be02          	ldw	x,c_lreg+2
2019  0290 89            	pushw	x
2020  0291 be00          	ldw	x,c_lreg
2021  0293 89            	pushw	x
2022  0294 cd0000        	call	_emb_itoa
2023  0297 5b08          	addw	sp,#8
2026                     ; 2016 	    default: break;
2028  0299               L575:
2029                     ; 2020 	  for(i=0; i<3; i++) {
2031  0299 4f            	clr	a
2032  029a 6b07          	ld	(OFST+0,sp),a
2034  029c               L775:
2035                     ; 2021 	    *pBuffer = (uint8_t)OctetArray[i];
2037  029c 5f            	clrw	x
2038  029d 97            	ld	xl,a
2039  029e d60045        	ld	a,(_OctetArray,x)
2040  02a1 1e08          	ldw	x,(OFST+1,sp)
2041  02a3 f7            	ld	(x),a
2042                     ; 2022             pBuffer++;
2044  02a4 5c            	incw	x
2045  02a5 1f08          	ldw	(OFST+1,sp),x
2046                     ; 2020 	  for(i=0; i<3; i++) {
2048  02a7 0c07          	inc	(OFST+0,sp)
2052  02a9 7b07          	ld	a,(OFST+0,sp)
2053  02ab a103          	cp	a,#3
2054  02ad 25ed          	jrult	L775
2055                     ; 2024 	  nBytes += 3;
2057  02af 1e04          	ldw	x,(OFST-3,sp)
2058  02b1 1c0003        	addw	x,#3
2060  02b4 cc0549        	jp	LC005
2061  02b7               L175:
2062                     ; 2027         else if (nParsedMode == 'c') {
2064  02b7 a163          	cp	a,#99
2065  02b9 2648          	jrne	L706
2066                     ; 2036 	  if (nParsedNum == 0) emb_itoa(stored_port, OctetArray, 10, 5);
2068  02bb 7b06          	ld	a,(OFST-1,sp)
2069  02bd 260d          	jrne	L116
2072  02bf 4b05          	push	#5
2073  02c1 4b0a          	push	#10
2074  02c3 ae0045        	ldw	x,#_OctetArray
2075  02c6 89            	pushw	x
2076  02c7 ce0000        	ldw	x,_stored_port
2080  02ca 200b          	jra	L316
2081  02cc               L116:
2082                     ; 2038 	  else emb_itoa(stored_mqttport, OctetArray, 10, 5);
2084  02cc 4b05          	push	#5
2085  02ce 4b0a          	push	#10
2086  02d0 ae0045        	ldw	x,#_OctetArray
2087  02d3 89            	pushw	x
2088  02d4 ce0000        	ldw	x,_stored_mqttport
2091  02d7               L316:
2092  02d7 cd0000        	call	c_uitolx
2093  02da be02          	ldw	x,c_lreg+2
2094  02dc 89            	pushw	x
2095  02dd be00          	ldw	x,c_lreg
2096  02df 89            	pushw	x
2097  02e0 cd0000        	call	_emb_itoa
2098  02e3 5b08          	addw	sp,#8
2099                     ; 2042 	  for(i=0; i<5; i++) {
2101  02e5 4f            	clr	a
2102  02e6 6b07          	ld	(OFST+0,sp),a
2104  02e8               L516:
2105                     ; 2043             *pBuffer = (uint8_t)OctetArray[i];
2107  02e8 5f            	clrw	x
2108  02e9 97            	ld	xl,a
2109  02ea d60045        	ld	a,(_OctetArray,x)
2110  02ed 1e08          	ldw	x,(OFST+1,sp)
2111  02ef f7            	ld	(x),a
2112                     ; 2044             pBuffer++;
2114  02f0 5c            	incw	x
2115  02f1 1f08          	ldw	(OFST+1,sp),x
2116                     ; 2042 	  for(i=0; i<5; i++) {
2118  02f3 0c07          	inc	(OFST+0,sp)
2122  02f5 7b07          	ld	a,(OFST+0,sp)
2123  02f7 a105          	cp	a,#5
2124  02f9 25ed          	jrult	L516
2125                     ; 2046 	  nBytes += 5;
2127  02fb 1e04          	ldw	x,(OFST-3,sp)
2128  02fd 1c0005        	addw	x,#5
2130  0300 cc0549        	jp	LC005
2131  0303               L706:
2132                     ; 2049         else if (nParsedMode == 'd') {
2134  0303 a164          	cp	a,#100
2135  0305 266b          	jrne	L526
2136                     ; 2054 	  if (nParsedNum == 0) { OctetArray[0] = mac_string[0]; OctetArray[1] = mac_string[1]; }
2138  0307 7b06          	ld	a,(OFST-1,sp)
2139  0309 260a          	jrne	L726
2142  030b 5500000045    	mov	_OctetArray,_mac_string
2145  0310 5500010046    	mov	_OctetArray+1,_mac_string+1
2146  0315               L726:
2147                     ; 2055 	  if (nParsedNum == 1) { OctetArray[0] = mac_string[2]; OctetArray[1] = mac_string[3]; }
2149  0315 a101          	cp	a,#1
2150  0317 260a          	jrne	L136
2153  0319 5500020045    	mov	_OctetArray,_mac_string+2
2156  031e 5500030046    	mov	_OctetArray+1,_mac_string+3
2157  0323               L136:
2158                     ; 2056 	  if (nParsedNum == 2) { OctetArray[0] = mac_string[4]; OctetArray[1] = mac_string[5]; }
2160  0323 a102          	cp	a,#2
2161  0325 260a          	jrne	L336
2164  0327 5500040045    	mov	_OctetArray,_mac_string+4
2167  032c 5500050046    	mov	_OctetArray+1,_mac_string+5
2168  0331               L336:
2169                     ; 2057 	  if (nParsedNum == 3) { OctetArray[0] = mac_string[6]; OctetArray[1] = mac_string[7]; }
2171  0331 a103          	cp	a,#3
2172  0333 260a          	jrne	L536
2175  0335 5500060045    	mov	_OctetArray,_mac_string+6
2178  033a 5500070046    	mov	_OctetArray+1,_mac_string+7
2179  033f               L536:
2180                     ; 2058 	  if (nParsedNum == 4) { OctetArray[0] = mac_string[8]; OctetArray[1] = mac_string[9]; }
2182  033f a104          	cp	a,#4
2183  0341 260a          	jrne	L736
2186  0343 5500080045    	mov	_OctetArray,_mac_string+8
2189  0348 5500090046    	mov	_OctetArray+1,_mac_string+9
2190  034d               L736:
2191                     ; 2059 	  if (nParsedNum == 5) { OctetArray[0] = mac_string[10]; OctetArray[1] = mac_string[11]; }
2193  034d a105          	cp	a,#5
2194  034f 260a          	jrne	L146
2197  0351 55000a0045    	mov	_OctetArray,_mac_string+10
2200  0356 55000b0046    	mov	_OctetArray+1,_mac_string+11
2201  035b               L146:
2202                     ; 2061           *pBuffer = OctetArray[0];
2204  035b 1e08          	ldw	x,(OFST+1,sp)
2205  035d c60045        	ld	a,_OctetArray
2206  0360 f7            	ld	(x),a
2207                     ; 2062           pBuffer++;
2209  0361 5c            	incw	x
2210  0362 1f08          	ldw	(OFST+1,sp),x
2211                     ; 2063           nBytes++;
2213  0364 1e04          	ldw	x,(OFST-3,sp)
2214  0366 5c            	incw	x
2215  0367 1f04          	ldw	(OFST-3,sp),x
2217                     ; 2065           *pBuffer = OctetArray[1];
2219  0369 c60046        	ld	a,_OctetArray+1
2220  036c 1e08          	ldw	x,(OFST+1,sp)
2221  036e               LC008:
2222  036e f7            	ld	(x),a
2223                     ; 2066           pBuffer++;
2224                     ; 2067           nBytes++;
2226  036f cc0543        	jp	LC006
2227  0372               L526:
2228                     ; 2225         else if (nParsedMode == 'f') {
2230  0372 a166          	cp	a,#102
2231  0374 261e          	jrne	L546
2232                     ; 2228 	  for(i=0; i<16; i++) {
2234  0376 4f            	clr	a
2235  0377 6b07          	ld	(OFST+0,sp),a
2237  0379               L746:
2238                     ; 2229 	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
2240  0379 cd0000        	call	_GpioGetPin
2242  037c 1e08          	ldw	x,(OFST+1,sp)
2243  037e ab30          	add	a,#48
2244  0380 f7            	ld	(x),a
2245                     ; 2230             pBuffer++;
2247  0381 5c            	incw	x
2248  0382 1f08          	ldw	(OFST+1,sp),x
2249                     ; 2228 	  for(i=0; i<16; i++) {
2251  0384 0c07          	inc	(OFST+0,sp)
2255  0386 7b07          	ld	a,(OFST+0,sp)
2256  0388 a110          	cp	a,#16
2257  038a 25ed          	jrult	L746
2258                     ; 2232 	  nBytes += 16;
2260  038c 1e04          	ldw	x,(OFST-3,sp)
2261  038e 1c0010        	addw	x,#16
2263  0391 cc0549        	jp	LC005
2264  0394               L546:
2265                     ; 2235         else if (nParsedMode == 'g') {
2267  0394 a167          	cp	a,#103
2268  0396 261e          	jrne	L756
2269                     ; 2248 	  for(i = 0; i < 6; i++) {
2271  0398 4f            	clr	a
2272  0399 6b07          	ld	(OFST+0,sp),a
2274  039b               L166:
2275                     ; 2249             *pBuffer = stored_config_settings[i];
2277  039b 5f            	clrw	x
2278  039c 97            	ld	xl,a
2279  039d d60000        	ld	a,(_stored_config_settings,x)
2280  03a0 1e08          	ldw	x,(OFST+1,sp)
2281  03a2 f7            	ld	(x),a
2282                     ; 2250             pBuffer++;
2284  03a3 5c            	incw	x
2285  03a4 1f08          	ldw	(OFST+1,sp),x
2286                     ; 2248 	  for(i = 0; i < 6; i++) {
2288  03a6 0c07          	inc	(OFST+0,sp)
2292  03a8 7b07          	ld	a,(OFST+0,sp)
2293  03aa a106          	cp	a,#6
2294  03ac 25ed          	jrult	L166
2295                     ; 2252           nBytes += 6;
2297  03ae 1e04          	ldw	x,(OFST-3,sp)
2298  03b0 1c0006        	addw	x,#6
2300  03b3 cc0549        	jp	LC005
2301  03b6               L756:
2302                     ; 2256         else if (nParsedMode == 'l') {
2304  03b6 a16c          	cp	a,#108
2305  03b8 2629          	jrne	L176
2306                     ; 2259           for(i=0; i<10; i++) {
2308  03ba 4f            	clr	a
2309  03bb 6b07          	ld	(OFST+0,sp),a
2311  03bd               L376:
2312                     ; 2260 	    if (stored_mqtt_username[i] != '\0') {
2314  03bd 5f            	clrw	x
2315  03be 97            	ld	xl,a
2316  03bf 724d0000      	tnz	(_stored_mqtt_username,x)
2317  03c3 2603cc054b    	jreq	L574
2318                     ; 2261               *pBuffer = (uint8_t)(stored_mqtt_username[i]);
2320  03c8 5f            	clrw	x
2321  03c9 97            	ld	xl,a
2322  03ca d60000        	ld	a,(_stored_mqtt_username,x)
2323  03cd 1e08          	ldw	x,(OFST+1,sp)
2324  03cf f7            	ld	(x),a
2325                     ; 2262               pBuffer++;
2327  03d0 5c            	incw	x
2328  03d1 1f08          	ldw	(OFST+1,sp),x
2329                     ; 2263               nBytes++;
2331  03d3 1e04          	ldw	x,(OFST-3,sp)
2332  03d5 5c            	incw	x
2333  03d6 1f04          	ldw	(OFST-3,sp),x
2336                     ; 2259           for(i=0; i<10; i++) {
2338  03d8 0c07          	inc	(OFST+0,sp)
2342  03da 7b07          	ld	a,(OFST+0,sp)
2343  03dc a10a          	cp	a,#10
2344  03de 25dd          	jrult	L376
2345  03e0 cc054b        	jra	L574
2346  03e3               L176:
2347                     ; 2269         else if (nParsedMode == 'm') {
2349  03e3 a16d          	cp	a,#109
2350  03e5 2626          	jrne	L707
2351                     ; 2272           for(i=0; i<10; i++) {
2353  03e7 4f            	clr	a
2354  03e8 6b07          	ld	(OFST+0,sp),a
2356  03ea               L117:
2357                     ; 2273 	    if (stored_mqtt_password[i] != '\0') {
2359  03ea 5f            	clrw	x
2360  03eb 97            	ld	xl,a
2361  03ec 724d0000      	tnz	(_stored_mqtt_password,x)
2362  03f0 27ee          	jreq	L574
2363                     ; 2274               *pBuffer = (uint8_t)(stored_mqtt_password[i]);
2365  03f2 5f            	clrw	x
2366  03f3 97            	ld	xl,a
2367  03f4 d60000        	ld	a,(_stored_mqtt_password,x)
2368  03f7 1e08          	ldw	x,(OFST+1,sp)
2369  03f9 f7            	ld	(x),a
2370                     ; 2275               pBuffer++;
2372  03fa 5c            	incw	x
2373  03fb 1f08          	ldw	(OFST+1,sp),x
2374                     ; 2276               nBytes++;
2376  03fd 1e04          	ldw	x,(OFST-3,sp)
2377  03ff 5c            	incw	x
2378  0400 1f04          	ldw	(OFST-3,sp),x
2381                     ; 2272           for(i=0; i<10; i++) {
2383  0402 0c07          	inc	(OFST+0,sp)
2387  0404 7b07          	ld	a,(OFST+0,sp)
2388  0406 a10a          	cp	a,#10
2389  0408 25e0          	jrult	L117
2390  040a cc054b        	jra	L574
2391  040d               L707:
2392                     ; 2282         else if (nParsedMode == 'n') {
2394  040d a16e          	cp	a,#110
2395  040f 2657          	jrne	L527
2396                     ; 2286 	  no_err = 0;
2398  0411 0f07          	clr	(OFST+0,sp)
2400                     ; 2287           switch (nParsedNum)
2402  0413 7b06          	ld	a,(OFST-1,sp)
2404                     ; 2309 	    default:
2404                     ; 2310 	      break;
2405  0415 270e          	jreq	L173
2406  0417 4a            	dec	a
2407  0418 2712          	jreq	L373
2408  041a 4a            	dec	a
2409  041b 2716          	jreq	L573
2410  041d 4a            	dec	a
2411  041e 271a          	jreq	L773
2412  0420 4a            	dec	a
2413  0421 271f          	jreq	L104
2414  0423 2030          	jra	L137
2415  0425               L173:
2416                     ; 2289 	    case 0:
2416                     ; 2290               // Connection request status
2416                     ; 2291 	      if (mqtt_start_status & MQTT_START_CONNECTIONS_GOOD) no_err = 1;
2418  0425 720900002b    	btjf	_mqtt_start_status,#4,L137
2420  042a 2013          	jp	LC003
2421  042c               L373:
2422                     ; 2293 	    case 1:
2422                     ; 2294 	      // ARP request status
2422                     ; 2295 	      if (mqtt_start_status & MQTT_START_ARP_REQUEST_GOOD) no_err = 1;
2424  042c 720b000024    	btjf	_mqtt_start_status,#5,L137
2426  0431 200c          	jp	LC003
2427  0433               L573:
2428                     ; 2297 	    case 2:
2428                     ; 2298 	      // TCP connection status
2428                     ; 2299 	      if (mqtt_start_status & MQTT_START_TCP_CONNECT_GOOD) no_err = 1;
2430  0433 720d00001d    	btjf	_mqtt_start_status,#6,L137
2432  0438 2005          	jp	LC003
2433  043a               L773:
2434                     ; 2301 	    case 3:
2434                     ; 2302 	      // MQTT Connection status 1
2434                     ; 2303 	      if (mqtt_start_status & MQTT_START_MQTT_CONNECT_GOOD) no_err = 1;
2436  043a 720f000016    	btjf	_mqtt_start_status,#7,L137
2439  043f               LC003:
2443  043f 4c            	inc	a
2444  0440 2011          	jp	LC002
2445  0442               L104:
2446                     ; 2305 	    case 4:
2446                     ; 2306 	      // MQTT start complete with no errors
2446                     ; 2307 	      if ((MQTT_error_status == 1) && ((mqtt_start_status & 0xf0) == 0xf0) ) no_err = 1;
2448  0442 c60000        	ld	a,_MQTT_error_status
2449  0445 4a            	dec	a
2450  0446 260d          	jrne	L137
2452  0448 c60000        	ld	a,_mqtt_start_status
2453  044b a4f0          	and	a,#240
2454  044d a1f0          	cp	a,#240
2455  044f 2604          	jrne	L137
2458  0451 a601          	ld	a,#1
2459  0453               LC002:
2460  0453 6b07          	ld	(OFST+0,sp),a
2462                     ; 2309 	    default:
2462                     ; 2310 	      break;
2464  0455               L137:
2465                     ; 2312 	  if (no_err == 1) *pBuffer = '1'; // Paint a green square
2467  0455 7b07          	ld	a,(OFST+0,sp)
2468  0457 4a            	dec	a
2469  0458 2607          	jrne	L547
2472  045a               LC009:
2474  045a 1e08          	ldw	x,(OFST+1,sp)
2475  045c a631          	ld	a,#49
2477  045e cc036e        	jra	LC008
2478  0461               L547:
2479                     ; 2313 	  else *pBuffer = '0'; // Paint a red square
2481  0461 1e08          	ldw	x,(OFST+1,sp)
2482  0463 a630          	ld	a,#48
2483                     ; 2314           pBuffer++;
2484                     ; 2315           nBytes++;
2486  0465 cc036e        	jp	LC008
2487  0468               L527:
2488                     ; 2319         else if (nParsedMode == 'y') {
2490  0468 a179          	cp	a,#121
2491  046a 269e          	jrne	L574
2492                     ; 2364 	  i = insertion_flag[0];
2494  046c c60000        	ld	a,_insertion_flag
2495  046f 6b07          	ld	(OFST+0,sp),a
2497                     ; 2365 	  insertion_flag[1] = nParsedMode;
2499  0471 7b03          	ld	a,(OFST-4,sp)
2500  0473 c70001        	ld	_insertion_flag+1,a
2501                     ; 2366 	  insertion_flag[2] = nParsedNum;
2503  0476 7b06          	ld	a,(OFST-1,sp)
2504  0478 c70002        	ld	_insertion_flag+2,a
2505                     ; 2368           switch (nParsedNum)
2508                     ; 2416 	    default: break;
2509  047b 2718          	jreq	L504
2510  047d 4a            	dec	a
2511  047e 272a          	jreq	L704
2512  0480 4a            	dec	a
2513  0481 273c          	jreq	L114
2514  0483 4a            	dec	a
2515  0484 274e          	jreq	L314
2516  0486 4a            	dec	a
2517  0487 2760          	jreq	L514
2518  0489 4a            	dec	a
2519  048a 2772          	jreq	L714
2520  048c 4a            	dec	a
2521  048d 2603cc0513    	jreq	L124
2522  0492 cc0541        	jra	LC007
2523  0495               L504:
2524                     ; 2370 	    case 0:
2524                     ; 2371 	      // %y00 replaced with string 
2524                     ; 2372 	      // page_string00[] = "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'";
2524                     ; 2373               *pBuffer = (uint8_t)page_string00[i];
2526  0495 7b07          	ld	a,(OFST+0,sp)
2527  0497 5f            	clrw	x
2528  0498 97            	ld	xl,a
2529  0499 d618c9        	ld	a,(L12_page_string00,x)
2530  049c 1e08          	ldw	x,(OFST+1,sp)
2531  049e f7            	ld	(x),a
2532                     ; 2374 	      insertion_flag[0]++;
2534  049f 725c0000      	inc	_insertion_flag
2535                     ; 2375 	      if (insertion_flag[0] == page_string00_len) insertion_flag[0] = 0;
2537  04a3 c60000        	ld	a,_insertion_flag
2538  04a6 a13f          	cp	a,#63
2540  04a8 207c          	jp	LC004
2541  04aa               L704:
2542                     ; 2377 	    case 1:
2542                     ; 2378 	      // %y01 replaced with string 
2542                     ; 2379               // page_string01[] = "pattern='[0-9a-f]{2}' title='Enter 00 to ff' maxlength='2'";
2542                     ; 2380               *pBuffer = (uint8_t)page_string01[i];
2544  04aa 7b07          	ld	a,(OFST+0,sp)
2545  04ac 5f            	clrw	x
2546  04ad 97            	ld	xl,a
2547  04ae d6190b        	ld	a,(L72_page_string01,x)
2548  04b1 1e08          	ldw	x,(OFST+1,sp)
2549  04b3 f7            	ld	(x),a
2550                     ; 2381 	      insertion_flag[0]++;
2552  04b4 725c0000      	inc	_insertion_flag
2553                     ; 2382 	      if (insertion_flag[0] == page_string01_len) insertion_flag[0] = 0;
2555  04b8 c60000        	ld	a,_insertion_flag
2556  04bb a140          	cp	a,#64
2558  04bd 2067          	jp	LC004
2559  04bf               L114:
2560                     ; 2384 	    case 2:
2560                     ; 2385 	      // %y02 replaced with string 
2560                     ; 2386               // page_string02[] = "<button title='Save first! This button will not save your changes'>";
2560                     ; 2387               *pBuffer = (uint8_t)page_string02[i];
2562  04bf 7b07          	ld	a,(OFST+0,sp)
2563  04c1 5f            	clrw	x
2564  04c2 97            	ld	xl,a
2565  04c3 d6194e        	ld	a,(L53_page_string02,x)
2566  04c6 1e08          	ldw	x,(OFST+1,sp)
2567  04c8 f7            	ld	(x),a
2568                     ; 2388 	      insertion_flag[0]++;
2570  04c9 725c0000      	inc	_insertion_flag
2571                     ; 2389 	      if (insertion_flag[0] == page_string02_len) insertion_flag[0] = 0;
2573  04cd c60000        	ld	a,_insertion_flag
2574  04d0 a152          	cp	a,#82
2576  04d2 2052          	jp	LC004
2577  04d4               L314:
2578                     ; 2391 	    case 3:
2578                     ; 2392 	      // %y03 replaced with string 
2578                     ; 2393               // page_string03[] = "<form style='display: inline' action='http://";
2578                     ; 2394               *pBuffer = (uint8_t)page_string03[i];
2580  04d4 7b07          	ld	a,(OFST+0,sp)
2581  04d6 5f            	clrw	x
2582  04d7 97            	ld	xl,a
2583  04d8 d619a3        	ld	a,(L34_page_string03,x)
2584  04db 1e08          	ldw	x,(OFST+1,sp)
2585  04dd f7            	ld	(x),a
2586                     ; 2395 	      insertion_flag[0]++;
2588  04de 725c0000      	inc	_insertion_flag
2589                     ; 2396 	      if (insertion_flag[0] == page_string03_len) insertion_flag[0] = 0;
2591  04e2 c60000        	ld	a,_insertion_flag
2592  04e5 a126          	cp	a,#38
2594  04e7 203d          	jp	LC004
2595  04e9               L514:
2596                     ; 2398 	    case 4:
2596                     ; 2399 	      // %y04 replaced with first header string 
2596                     ; 2400               *pBuffer = (uint8_t)page_string04[i];
2598  04e9 7b07          	ld	a,(OFST+0,sp)
2599  04eb 5f            	clrw	x
2600  04ec 97            	ld	xl,a
2601  04ed d619cc        	ld	a,(L15_page_string04,x)
2602  04f0 1e08          	ldw	x,(OFST+1,sp)
2603  04f2 f7            	ld	(x),a
2604                     ; 2401 	      insertion_flag[0]++;
2606  04f3 725c0000      	inc	_insertion_flag
2607                     ; 2402 	      if (insertion_flag[0] == page_string04_len) insertion_flag[0] = 0;
2609  04f7 c60000        	ld	a,_insertion_flag
2610  04fa a147          	cp	a,#71
2612  04fc 2028          	jp	LC004
2613  04fe               L714:
2614                     ; 2404 	    case 5:
2614                     ; 2405 	      // %y05 replaced with second header string 
2614                     ; 2406               *pBuffer = (uint8_t)page_string05[i];
2616  04fe 7b07          	ld	a,(OFST+0,sp)
2617  0500 5f            	clrw	x
2618  0501 97            	ld	xl,a
2619  0502 d61a16        	ld	a,(L75_page_string05,x)
2620  0505 1e08          	ldw	x,(OFST+1,sp)
2621  0507 f7            	ld	(x),a
2622                     ; 2407 	      insertion_flag[0]++;
2624  0508 725c0000      	inc	_insertion_flag
2625                     ; 2408 	      if (insertion_flag[0] == page_string05_len) insertion_flag[0] = 0;
2627  050c c60000        	ld	a,_insertion_flag
2628  050f a1ed          	cp	a,#237
2630  0511 2013          	jp	LC004
2631  0513               L124:
2632                     ; 2410 	    case 6:
2632                     ; 2411 	      // %y06 replaced with third header string 
2632                     ; 2412               *pBuffer = (uint8_t)page_string06[i];
2634  0513 7b07          	ld	a,(OFST+0,sp)
2635  0515 5f            	clrw	x
2636  0516 97            	ld	xl,a
2637  0517 d61b06        	ld	a,(L56_page_string06,x)
2638  051a 1e08          	ldw	x,(OFST+1,sp)
2639  051c f7            	ld	(x),a
2640                     ; 2413 	      insertion_flag[0]++;
2642  051d 725c0000      	inc	_insertion_flag
2643                     ; 2414 	      if (insertion_flag[0] == page_string06_len) insertion_flag[0] = 0;
2645  0521 c60000        	ld	a,_insertion_flag
2646  0524 a13b          	cp	a,#59
2649  0526               LC004:
2650  0526 2619          	jrne	LC007
2657  0528 725f0000      	clr	_insertion_flag
2658                     ; 2416 	    default: break;
2660                     ; 2418           pBuffer++;
2661                     ; 2419           nBytes++;
2662  052c 2013          	jp	LC007
2663  052e               L115:
2664                     ; 2427         *pBuffer = nByte;
2666  052e 1e08          	ldw	x,(OFST+1,sp)
2667  0530 f7            	ld	(x),a
2668                     ; 2428         *ppData = *ppData + 1;
2670  0531 1e0c          	ldw	x,(OFST+5,sp)
2671  0533 9093          	ldw	y,x
2672  0535 fe            	ldw	x,(x)
2673  0536 5c            	incw	x
2674  0537 90ff          	ldw	(y),x
2675                     ; 2429         *pDataLeft = *pDataLeft - 1;
2677  0539 1e0e          	ldw	x,(OFST+7,sp)
2678  053b 9093          	ldw	y,x
2679  053d fe            	ldw	x,(x)
2680  053e 5a            	decw	x
2681  053f 90ff          	ldw	(y),x
2682                     ; 2430         pBuffer++;
2684  0541               LC007:
2686  0541 1e08          	ldw	x,(OFST+1,sp)
2687                     ; 2431         nBytes++;
2689  0543               LC006:
2694  0543 5c            	incw	x
2695  0544 1f08          	ldw	(OFST+1,sp),x
2701  0546 1e04          	ldw	x,(OFST-3,sp)
2702  0548 5c            	incw	x
2703  0549               LC005:
2704  0549 1f04          	ldw	(OFST-3,sp),x
2706  054b               L574:
2707                     ; 1774   while (nBytes < nMaxBytes) {
2709  054b 1e04          	ldw	x,(OFST-3,sp)
2710  054d 1310          	cpw	x,(OFST+9,sp)
2711  054f 2403cc0012    	jrult	L374
2712  0554               L774:
2713                     ; 2436   return nBytes;
2715  0554 1e04          	ldw	x,(OFST-3,sp)
2718  0556 5b09          	addw	sp,#9
2719  0558 81            	ret	
2751                     ; 2440 void HttpDInit()
2751                     ; 2441 {
2752                     .text:	section	.text,new
2753  0000               _HttpDInit:
2757                     ; 2443   uip_listen(htons(Port_Httpd));
2759  0000 ce0000        	ldw	x,_Port_Httpd
2760  0003 cd0000        	call	_htons
2762  0006 cd0000        	call	_uip_listen
2764                     ; 2444   current_webpage = WEBPAGE_IOCONTROL;
2766  0009 725f0003      	clr	_current_webpage
2767                     ; 2447   insertion_flag[0] = 0;
2769  000d 725f0000      	clr	_insertion_flag
2770                     ; 2448   insertion_flag[1] = 0;
2772  0011 725f0001      	clr	_insertion_flag+1
2773                     ; 2449   insertion_flag[2] = 0;
2775  0015 725f0002      	clr	_insertion_flag+2
2776                     ; 2452   saved_nstate = STATE_NULL;
2778  0019 357f0044      	mov	_saved_nstate,#127
2779                     ; 2453   saved_parsestate = PARSE_CMD;
2781  001d 725f0043      	clr	_saved_parsestate
2782                     ; 2454   saved_nparseleft = 0;
2784  0021 725f0042      	clr	_saved_nparseleft
2785                     ; 2455   clear_saved_postpartial_all();
2788                     ; 2456 }
2791  0025 cc0000        	jp	_clear_saved_postpartial_all
2981                     	switch	.const
2982  1b64               L212:
2983  1b64 088e          	dc.w	L7101
2984  1b66 0895          	dc.w	L1201
2985  1b68 089c          	dc.w	L3201
2986  1b6a 08a3          	dc.w	L5201
2987  1b6c 08aa          	dc.w	L7201
2988  1b6e 08b1          	dc.w	L1301
2989  1b70 08b8          	dc.w	L3301
2990  1b72 08bf          	dc.w	L5301
2991  1b74 08c6          	dc.w	L7301
2992  1b76 08cd          	dc.w	L1401
2993  1b78 08d4          	dc.w	L3401
2994  1b7a 08db          	dc.w	L5401
2995  1b7c 08e1          	dc.w	L7401
2996  1b7e 08e7          	dc.w	L1501
2997  1b80 08ed          	dc.w	L3501
2998  1b82 08f3          	dc.w	L5501
2999                     ; 2459 void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
2999                     ; 2460 {
3000                     .text:	section	.text,new
3001  0000               _HttpDCall:
3003  0000 89            	pushw	x
3004  0001 5204          	subw	sp,#4
3005       00000004      OFST:	set	4
3008                     ; 2464   i = 0;
3010  0003 0f04          	clr	(OFST+0,sp)
3012                     ; 2466   if (uip_connected()) {
3014  0005 720d000043    	btjf	_uip_flags,#6,L7611
3015                     ; 2468     if (current_webpage == WEBPAGE_IOCONTROL) {
3017  000a c60003        	ld	a,_current_webpage
3018  000d 260e          	jrne	L1711
3019                     ; 2469       pSocket->pData = g_HtmlPageIOControl;
3021  000f 1e0b          	ldw	x,(OFST+7,sp)
3022  0011 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
3023  0015 ef01          	ldw	(1,x),y
3024                     ; 2470       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
3026  0017 90ae0c06      	ldw	y,#3078
3028  001b 2022          	jp	LC010
3029  001d               L1711:
3030                     ; 2474     else if (current_webpage == WEBPAGE_CONFIGURATION) {
3032  001d a101          	cp	a,#1
3033  001f 260e          	jrne	L5711
3034                     ; 2475       pSocket->pData = g_HtmlPageConfiguration;
3036  0021 1e0b          	ldw	x,(OFST+7,sp)
3037  0023 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
3038  0027 ef01          	ldw	(1,x),y
3039                     ; 2476       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
3041  0029 90ae0c31      	ldw	y,#3121
3043  002d 2010          	jp	LC010
3044  002f               L5711:
3045                     ; 2497     else if (current_webpage == WEBPAGE_RSTATE) {
3047  002f a106          	cp	a,#6
3048  0031 260e          	jrne	L3711
3049                     ; 2498       pSocket->pData = g_HtmlPageRstate;
3051  0033 1e0b          	ldw	x,(OFST+7,sp)
3052  0035 90ae1841      	ldw	y,#L71_g_HtmlPageRstate
3053  0039 ef01          	ldw	(1,x),y
3054                     ; 2499       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
3056  003b 90ae0087      	ldw	y,#135
3057  003f               LC010:
3058  003f ef03          	ldw	(3,x),y
3059  0041               L3711:
3060                     ; 2502     pSocket->nState = STATE_CONNECTED;
3062  0041 1e0b          	ldw	x,(OFST+7,sp)
3063                     ; 2503     pSocket->nPrevBytes = 0xFFFF;
3065  0043 90aeffff      	ldw	y,#65535
3066  0047 7f            	clr	(x)
3067  0048 ef0b          	ldw	(11,x),y
3069  004a cc011d        	jra	L042
3070  004d               L7611:
3071                     ; 2512   else if (uip_newdata() || uip_acked()) {
3073  004d 7202000008    	btjt	_uip_flags,#1,L7021
3075  0052 7200000003cc  	btjf	_uip_flags,#0,L5021
3076  005a               L7021:
3077                     ; 2513     if (uip_acked()) {
3079  005a 7201000003cc  	btjt	_uip_flags,#0,L7701
3080                     ; 2516       goto senddata;
3082                     ; 2586     if (saved_nstate != STATE_NULL) {
3084  0062 c60044        	ld	a,_saved_nstate
3085  0065 a17f          	cp	a,#127
3086  0067 2603cc00e9    	jreq	L1421
3087                     ; 2592       pSocket->nState = saved_nstate;
3089  006c 1e0b          	ldw	x,(OFST+7,sp)
3090  006e f7            	ld	(x),a
3091                     ; 2599       pSocket->ParseState = saved_parsestate;
3093  006f c60043        	ld	a,_saved_parsestate
3094  0072 e70a          	ld	(10,x),a
3095                     ; 2603       pSocket->nParseLeft = saved_nparseleft;
3097  0074 c60042        	ld	a,_saved_nparseleft
3098  0077 e706          	ld	(6,x),a
3099                     ; 2605       pSocket->nNewlines = saved_newlines;
3101  0079 c60011        	ld	a,_saved_newlines
3102  007c e705          	ld	(5,x),a
3103                     ; 2617       for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i];
3105  007e 4f            	clr	a
3106  007f 6b04          	ld	(OFST+0,sp),a
3108  0081               L5121:
3111  0081 5f            	clrw	x
3112  0082 97            	ld	xl,a
3113  0083 d6002a        	ld	a,(_saved_postpartial,x)
3114  0086 d70012        	ld	(_saved_postpartial_previous,x),a
3117  0089 0c04          	inc	(OFST+0,sp)
3121  008b 7b04          	ld	a,(OFST+0,sp)
3122  008d a118          	cp	a,#24
3123  008f 25f0          	jrult	L5121
3124                     ; 2622       if (saved_nstate == STATE_PARSEPOST) {
3126  0091 c60044        	ld	a,_saved_nstate
3127  0094 a10a          	cp	a,#10
3128  0096 2651          	jrne	L1421
3129                     ; 2623         if (saved_parsestate == PARSE_CMD) {
3131  0098 c60043        	ld	a,_saved_parsestate
3132  009b 274c          	jreq	L1421
3134                     ; 2626         else if (saved_parsestate == PARSE_NUM10) {
3136  009d a101          	cp	a,#1
3137  009f 2609          	jrne	L1321
3138                     ; 2628 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3140  00a1 1e0b          	ldw	x,(OFST+7,sp)
3141  00a3 c60012        	ld	a,_saved_postpartial_previous
3142  00a6 e708          	ld	(8,x),a
3144  00a8 203f          	jra	L1421
3145  00aa               L1321:
3146                     ; 2630         else if (saved_parsestate == PARSE_NUM1) {
3148  00aa a102          	cp	a,#2
3149  00ac 2615          	jrne	L5321
3150                     ; 2632 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3152  00ae 1e0b          	ldw	x,(OFST+7,sp)
3153  00b0 c60012        	ld	a,_saved_postpartial_previous
3154  00b3 e708          	ld	(8,x),a
3155                     ; 2633           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3157  00b5 c60013        	ld	a,_saved_postpartial_previous+1
3158  00b8 97            	ld	xl,a
3159  00b9 a60a          	ld	a,#10
3160  00bb 42            	mul	x,a
3161  00bc 9f            	ld	a,xl
3162  00bd a0e0          	sub	a,#224
3163  00bf 1e0b          	ldw	x,(OFST+7,sp)
3165  00c1 2024          	jp	LC011
3166  00c3               L5321:
3167                     ; 2635         else if (saved_parsestate == PARSE_EQUAL || saved_parsestate == PARSE_VAL) {
3169  00c3 a103          	cp	a,#3
3170  00c5 2704          	jreq	L3421
3172  00c7 a104          	cp	a,#4
3173  00c9 261e          	jrne	L1421
3174  00cb               L3421:
3175                     ; 2637 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3177  00cb 1e0b          	ldw	x,(OFST+7,sp)
3178  00cd c60012        	ld	a,_saved_postpartial_previous
3179  00d0 e708          	ld	(8,x),a
3180                     ; 2638           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3182  00d2 c60013        	ld	a,_saved_postpartial_previous+1
3183  00d5 97            	ld	xl,a
3184  00d6 a60a          	ld	a,#10
3185  00d8 42            	mul	x,a
3186  00d9 9f            	ld	a,xl
3187  00da 1e0b          	ldw	x,(OFST+7,sp)
3188  00dc a0e0          	sub	a,#224
3189  00de e709          	ld	(9,x),a
3190                     ; 2639           pSocket->ParseNum += (uint8_t)(saved_postpartial_previous[2] - '0');
3192  00e0 c60014        	ld	a,_saved_postpartial_previous+2
3193  00e3 a030          	sub	a,#48
3194  00e5 eb09          	add	a,(9,x)
3195  00e7               LC011:
3196  00e7 e709          	ld	(9,x),a
3198  00e9               L1421:
3199                     ; 2641 	else if (saved_parsestate == PARSE_DELIM) {
3201                     ; 2661     if (pSocket->nState == STATE_CONNECTED) {
3203  00e9 1e0b          	ldw	x,(OFST+7,sp)
3204  00eb f6            	ld	a,(x)
3205  00ec 2627          	jrne	L1521
3206                     ; 2662       if (nBytes == 0) return;
3208  00ee 1e09          	ldw	x,(OFST+5,sp)
3209  00f0 272b          	jreq	L042
3212                     ; 2663       if (*pBuffer == 'G') {
3214  00f2 1e05          	ldw	x,(OFST+1,sp)
3215  00f4 f6            	ld	a,(x)
3216  00f5 a147          	cp	a,#71
3217  00f7 2606          	jrne	L5521
3218                     ; 2664         pSocket->nState = STATE_GET_G;
3220  00f9 1e0b          	ldw	x,(OFST+7,sp)
3221  00fb a601          	ld	a,#1
3223  00fd 2008          	jp	LC012
3224  00ff               L5521:
3225                     ; 2666       else if (*pBuffer == 'P') {
3227  00ff a150          	cp	a,#80
3228  0101 2605          	jrne	L7521
3229                     ; 2667         pSocket->nState = STATE_POST_P;
3231  0103 1e0b          	ldw	x,(OFST+7,sp)
3232  0105 a604          	ld	a,#4
3233  0107               LC012:
3234  0107 f7            	ld	(x),a
3235  0108               L7521:
3236                     ; 2669       nBytes--;
3238  0108 1e09          	ldw	x,(OFST+5,sp)
3239  010a 5a            	decw	x
3240  010b 1f09          	ldw	(OFST+5,sp),x
3241                     ; 2670       pBuffer++;
3243  010d 1e05          	ldw	x,(OFST+1,sp)
3244  010f 5c            	incw	x
3245  0110 1f05          	ldw	(OFST+1,sp),x
3246  0112 1e0b          	ldw	x,(OFST+7,sp)
3247  0114 f6            	ld	a,(x)
3248  0115               L1521:
3249                     ; 2673     if (pSocket->nState == STATE_GET_G) {
3251  0115 a101          	cp	a,#1
3252  0117 2620          	jrne	L3621
3253                     ; 2674       if (nBytes == 0) return;
3255  0119 1e09          	ldw	x,(OFST+5,sp)
3256  011b 2603          	jrne	L5621
3258  011d               L042:
3261  011d 5b06          	addw	sp,#6
3262  011f 81            	ret	
3263  0120               L5621:
3264                     ; 2675       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
3266  0120 1e05          	ldw	x,(OFST+1,sp)
3267  0122 f6            	ld	a,(x)
3268  0123 a145          	cp	a,#69
3269  0125 2605          	jrne	L7621
3272  0127 1e0b          	ldw	x,(OFST+7,sp)
3273  0129 a602          	ld	a,#2
3274  012b f7            	ld	(x),a
3275  012c               L7621:
3276                     ; 2676       nBytes--;
3278  012c 1e09          	ldw	x,(OFST+5,sp)
3279  012e 5a            	decw	x
3280  012f 1f09          	ldw	(OFST+5,sp),x
3281                     ; 2677       pBuffer++;
3283  0131 1e05          	ldw	x,(OFST+1,sp)
3284  0133 5c            	incw	x
3285  0134 1f05          	ldw	(OFST+1,sp),x
3286  0136 1e0b          	ldw	x,(OFST+7,sp)
3287  0138 f6            	ld	a,(x)
3288  0139               L3621:
3289                     ; 2680     if (pSocket->nState == STATE_GET_GE) {
3291  0139 a102          	cp	a,#2
3292  013b 261d          	jrne	L1721
3293                     ; 2681       if (nBytes == 0) return;
3295  013d 1e09          	ldw	x,(OFST+5,sp)
3296  013f 27dc          	jreq	L042
3299                     ; 2682       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
3301  0141 1e05          	ldw	x,(OFST+1,sp)
3302  0143 f6            	ld	a,(x)
3303  0144 a154          	cp	a,#84
3304  0146 2605          	jrne	L5721
3307  0148 1e0b          	ldw	x,(OFST+7,sp)
3308  014a a603          	ld	a,#3
3309  014c f7            	ld	(x),a
3310  014d               L5721:
3311                     ; 2683       nBytes--;
3313  014d 1e09          	ldw	x,(OFST+5,sp)
3314  014f 5a            	decw	x
3315  0150 1f09          	ldw	(OFST+5,sp),x
3316                     ; 2684       pBuffer++;
3318  0152 1e05          	ldw	x,(OFST+1,sp)
3319  0154 5c            	incw	x
3320  0155 1f05          	ldw	(OFST+1,sp),x
3321  0157 1e0b          	ldw	x,(OFST+7,sp)
3322  0159 f6            	ld	a,(x)
3323  015a               L1721:
3324                     ; 2687     if (pSocket->nState == STATE_GET_GET) {
3326  015a a103          	cp	a,#3
3327  015c 261d          	jrne	L7721
3328                     ; 2688       if (nBytes == 0) return;
3330  015e 1e09          	ldw	x,(OFST+5,sp)
3331  0160 27bb          	jreq	L042
3334                     ; 2689       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
3336  0162 1e05          	ldw	x,(OFST+1,sp)
3337  0164 f6            	ld	a,(x)
3338  0165 a120          	cp	a,#32
3339  0167 2605          	jrne	L3031
3342  0169 1e0b          	ldw	x,(OFST+7,sp)
3343  016b a608          	ld	a,#8
3344  016d f7            	ld	(x),a
3345  016e               L3031:
3346                     ; 2690       nBytes--;
3348  016e 1e09          	ldw	x,(OFST+5,sp)
3349  0170 5a            	decw	x
3350  0171 1f09          	ldw	(OFST+5,sp),x
3351                     ; 2691       pBuffer++;
3353  0173 1e05          	ldw	x,(OFST+1,sp)
3354  0175 5c            	incw	x
3355  0176 1f05          	ldw	(OFST+1,sp),x
3356  0178 1e0b          	ldw	x,(OFST+7,sp)
3357  017a f6            	ld	a,(x)
3358  017b               L7721:
3359                     ; 2694     if (pSocket->nState == STATE_POST_P) {
3361  017b a104          	cp	a,#4
3362  017d 261d          	jrne	L5031
3363                     ; 2695       if (nBytes == 0) return;
3365  017f 1e09          	ldw	x,(OFST+5,sp)
3366  0181 279a          	jreq	L042
3369                     ; 2696       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
3371  0183 1e05          	ldw	x,(OFST+1,sp)
3372  0185 f6            	ld	a,(x)
3373  0186 a14f          	cp	a,#79
3374  0188 2605          	jrne	L1131
3377  018a 1e0b          	ldw	x,(OFST+7,sp)
3378  018c a605          	ld	a,#5
3379  018e f7            	ld	(x),a
3380  018f               L1131:
3381                     ; 2697       nBytes--;
3383  018f 1e09          	ldw	x,(OFST+5,sp)
3384  0191 5a            	decw	x
3385  0192 1f09          	ldw	(OFST+5,sp),x
3386                     ; 2698       pBuffer++;
3388  0194 1e05          	ldw	x,(OFST+1,sp)
3389  0196 5c            	incw	x
3390  0197 1f05          	ldw	(OFST+1,sp),x
3391  0199 1e0b          	ldw	x,(OFST+7,sp)
3392  019b f6            	ld	a,(x)
3393  019c               L5031:
3394                     ; 2701     if (pSocket->nState == STATE_POST_PO) {
3396  019c a105          	cp	a,#5
3397  019e 2620          	jrne	L3131
3398                     ; 2702       if (nBytes == 0) return;
3400  01a0 1e09          	ldw	x,(OFST+5,sp)
3401  01a2 2603cc011d    	jreq	L042
3404                     ; 2703       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
3406  01a7 1e05          	ldw	x,(OFST+1,sp)
3407  01a9 f6            	ld	a,(x)
3408  01aa a153          	cp	a,#83
3409  01ac 2605          	jrne	L7131
3412  01ae 1e0b          	ldw	x,(OFST+7,sp)
3413  01b0 a606          	ld	a,#6
3414  01b2 f7            	ld	(x),a
3415  01b3               L7131:
3416                     ; 2704       nBytes--;
3418  01b3 1e09          	ldw	x,(OFST+5,sp)
3419  01b5 5a            	decw	x
3420  01b6 1f09          	ldw	(OFST+5,sp),x
3421                     ; 2705       pBuffer++;
3423  01b8 1e05          	ldw	x,(OFST+1,sp)
3424  01ba 5c            	incw	x
3425  01bb 1f05          	ldw	(OFST+1,sp),x
3426  01bd 1e0b          	ldw	x,(OFST+7,sp)
3427  01bf f6            	ld	a,(x)
3428  01c0               L3131:
3429                     ; 2708     if (pSocket->nState == STATE_POST_POS) {
3431  01c0 a106          	cp	a,#6
3432  01c2 261d          	jrne	L1231
3433                     ; 2709       if (nBytes == 0) return;
3435  01c4 1e09          	ldw	x,(OFST+5,sp)
3436  01c6 27dc          	jreq	L042
3439                     ; 2710       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
3441  01c8 1e05          	ldw	x,(OFST+1,sp)
3442  01ca f6            	ld	a,(x)
3443  01cb a154          	cp	a,#84
3444  01cd 2605          	jrne	L5231
3447  01cf 1e0b          	ldw	x,(OFST+7,sp)
3448  01d1 a607          	ld	a,#7
3449  01d3 f7            	ld	(x),a
3450  01d4               L5231:
3451                     ; 2711       nBytes--;
3453  01d4 1e09          	ldw	x,(OFST+5,sp)
3454  01d6 5a            	decw	x
3455  01d7 1f09          	ldw	(OFST+5,sp),x
3456                     ; 2712       pBuffer++;
3458  01d9 1e05          	ldw	x,(OFST+1,sp)
3459  01db 5c            	incw	x
3460  01dc 1f05          	ldw	(OFST+1,sp),x
3461  01de 1e0b          	ldw	x,(OFST+7,sp)
3462  01e0 f6            	ld	a,(x)
3463  01e1               L1231:
3464                     ; 2715     if (pSocket->nState == STATE_POST_POST) {
3466  01e1 a107          	cp	a,#7
3467  01e3 261d          	jrne	L7231
3468                     ; 2716       if (nBytes == 0) return;
3470  01e5 1e09          	ldw	x,(OFST+5,sp)
3471  01e7 27bb          	jreq	L042
3474                     ; 2717       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
3476  01e9 1e05          	ldw	x,(OFST+1,sp)
3477  01eb f6            	ld	a,(x)
3478  01ec a120          	cp	a,#32
3479  01ee 2605          	jrne	L3331
3482  01f0 1e0b          	ldw	x,(OFST+7,sp)
3483  01f2 a609          	ld	a,#9
3484  01f4 f7            	ld	(x),a
3485  01f5               L3331:
3486                     ; 2718       nBytes--;
3488  01f5 1e09          	ldw	x,(OFST+5,sp)
3489  01f7 5a            	decw	x
3490  01f8 1f09          	ldw	(OFST+5,sp),x
3491                     ; 2719       pBuffer++;
3493  01fa 1e05          	ldw	x,(OFST+1,sp)
3494  01fc 5c            	incw	x
3495  01fd 1f05          	ldw	(OFST+1,sp),x
3496  01ff 1e0b          	ldw	x,(OFST+7,sp)
3497  0201 f6            	ld	a,(x)
3498  0202               L7231:
3499                     ; 2722     if (pSocket->nState == STATE_GOTPOST) {
3501  0202 a109          	cp	a,#9
3502  0204 2703cc028b    	jrne	L5331
3503                     ; 2724       saved_nstate = STATE_GOTPOST;
3505  0209 35090044      	mov	_saved_nstate,#9
3506                     ; 2725       if (nBytes == 0) {
3508  020d 1e09          	ldw	x,(OFST+5,sp)
3509  020f 2676          	jrne	L3431
3510                     ; 2728 	saved_newlines = pSocket->nNewlines;
3512  0211 1e0b          	ldw	x,(OFST+7,sp)
3513  0213 e605          	ld	a,(5,x)
3514  0215 c70011        	ld	_saved_newlines,a
3515                     ; 2729         return;
3517  0218 cc011d        	jra	L042
3518  021b               L1431:
3519                     ; 2737 	if (saved_newlines == 2) {
3521  021b c60011        	ld	a,_saved_newlines
3522  021e a102          	cp	a,#2
3523  0220 272b          	jreq	L1531
3525                     ; 2742           if (*pBuffer == '\n') pSocket->nNewlines++;
3527  0222 1e05          	ldw	x,(OFST+1,sp)
3528  0224 f6            	ld	a,(x)
3529  0225 a10a          	cp	a,#10
3530  0227 2606          	jrne	L3531
3533  0229 1e0b          	ldw	x,(OFST+7,sp)
3534  022b 6c05          	inc	(5,x)
3536  022d 2008          	jra	L5531
3537  022f               L3531:
3538                     ; 2743           else if (*pBuffer == '\r') { }
3540  022f a10d          	cp	a,#13
3541  0231 2704          	jreq	L5531
3543                     ; 2744           else pSocket->nNewlines = 0;
3545  0233 1e0b          	ldw	x,(OFST+7,sp)
3546  0235 6f05          	clr	(5,x)
3547  0237               L5531:
3548                     ; 2745           pBuffer++;
3550  0237 1e05          	ldw	x,(OFST+1,sp)
3551  0239 5c            	incw	x
3552  023a 1f05          	ldw	(OFST+1,sp),x
3553                     ; 2746           nBytes--;
3555  023c 1e09          	ldw	x,(OFST+5,sp)
3556  023e 5a            	decw	x
3557  023f 1f09          	ldw	(OFST+5,sp),x
3558                     ; 2747           if (nBytes == 0) {
3560  0241 260a          	jrne	L1531
3561                     ; 2750             saved_newlines = pSocket->nNewlines;
3563  0243 1e0b          	ldw	x,(OFST+7,sp)
3564  0245 e605          	ld	a,(5,x)
3565  0247 c70011        	ld	_saved_newlines,a
3566                     ; 2751             return;
3568  024a cc011d        	jra	L042
3569  024d               L1531:
3570                     ; 2759         if (pSocket->nNewlines == 2) {
3572  024d 1e0b          	ldw	x,(OFST+7,sp)
3573  024f e605          	ld	a,(5,x)
3574  0251 a102          	cp	a,#2
3575  0253 2632          	jrne	L3431
3576                     ; 2762           if (current_webpage == WEBPAGE_IOCONTROL) {
3578  0255 c60003        	ld	a,_current_webpage
3579  0258 2609          	jrne	L7631
3580                     ; 2763 	    pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
3582  025a a635          	ld	a,#53
3583  025c e706          	ld	(6,x),a
3584                     ; 2764 	    pSocket->nParseLeftAddl = PARSEBYTES_IOCONTROL_ADDL;
3586  025e 6f07          	clr	(7,x)
3587  0260 c60003        	ld	a,_current_webpage
3588  0263               L7631:
3589                     ; 2766           if (current_webpage == WEBPAGE_CONFIGURATION) {
3591  0263 4a            	dec	a
3592  0264 2608          	jrne	L1731
3593                     ; 2767 	    pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
3595  0266 a6ec          	ld	a,#236
3596  0268 e706          	ld	(6,x),a
3597                     ; 2768 	    pSocket->nParseLeftAddl = PARSEBYTES_CONFIGURATION_ADDL;
3599  026a a618          	ld	a,#24
3600  026c e707          	ld	(7,x),a
3601  026e               L1731:
3602                     ; 2770           pSocket->ParseState = saved_parsestate = PARSE_CMD;
3604  026e 725f0043      	clr	_saved_parsestate
3605  0272 6f0a          	clr	(10,x)
3606                     ; 2771 	  saved_nparseleft = pSocket->nParseLeft;
3608  0274 e606          	ld	a,(6,x)
3609  0276 c70042        	ld	_saved_nparseleft,a
3610                     ; 2773           pSocket->nState = STATE_PARSEPOST;
3612  0279 a60a          	ld	a,#10
3613  027b f7            	ld	(x),a
3614                     ; 2774 	  saved_nstate = STATE_PARSEPOST;
3616  027c 350a0044      	mov	_saved_nstate,#10
3617                     ; 2775 	  if (nBytes == 0) {
3619  0280 1e09          	ldw	x,(OFST+5,sp)
3620  0282 2607          	jrne	L5331
3621                     ; 2778 	    return;
3623  0284 cc011d        	jra	L042
3624  0287               L3431:
3625                     ; 2732       while (nBytes != 0) {
3627  0287 1e09          	ldw	x,(OFST+5,sp)
3628  0289 2690          	jrne	L1431
3629  028b               L5331:
3630                     ; 2785     if (pSocket->nState == STATE_GOTGET) {
3632  028b 1e0b          	ldw	x,(OFST+7,sp)
3633  028d f6            	ld	a,(x)
3634  028e a108          	cp	a,#8
3635  0290 2609          	jrne	L5731
3636                     ; 2789       pSocket->nParseLeft = 6;
3638  0292 a606          	ld	a,#6
3639  0294 e706          	ld	(6,x),a
3640                     ; 2790       pSocket->ParseState = PARSE_SLASH1;
3642  0296 e70a          	ld	(10,x),a
3643                     ; 2792       pSocket->nState = STATE_PARSEGET;
3645  0298 a60d          	ld	a,#13
3646  029a f7            	ld	(x),a
3647  029b               L5731:
3648                     ; 2795     if (pSocket->nState == STATE_PARSEPOST) {
3650  029b a10a          	cp	a,#10
3651  029d 2703cc077b    	jrne	L7731
3652  02a2               L1041:
3653                     ; 2809         if (pSocket->ParseState == PARSE_CMD) {
3655  02a2 1e0b          	ldw	x,(OFST+7,sp)
3656  02a4 e60a          	ld	a,(10,x)
3657  02a6 2664          	jrne	L5041
3658                     ; 2810           pSocket->ParseCmd = *pBuffer;
3660  02a8 1e05          	ldw	x,(OFST+1,sp)
3661  02aa f6            	ld	a,(x)
3662  02ab 1e0b          	ldw	x,(OFST+7,sp)
3663  02ad e708          	ld	(8,x),a
3664                     ; 2811 	  saved_postpartial[0] = *pBuffer;
3666  02af 1e05          	ldw	x,(OFST+1,sp)
3667  02b1 f6            	ld	a,(x)
3668  02b2 c7002a        	ld	_saved_postpartial,a
3669                     ; 2812           pSocket->ParseState = saved_parsestate = PARSE_NUM10;
3671  02b5 a601          	ld	a,#1
3672  02b7 c70043        	ld	_saved_parsestate,a
3673  02ba 1e0b          	ldw	x,(OFST+7,sp)
3674  02bc e70a          	ld	(10,x),a
3675                     ; 2813 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3677  02be e606          	ld	a,(6,x)
3678  02c0 2704          	jreq	L7041
3679                     ; 2814 	    pSocket->nParseLeft--;
3681  02c2 6a06          	dec	(6,x)
3683  02c4 2004          	jra	L1141
3684  02c6               L7041:
3685                     ; 2818 	    pSocket->ParseState = PARSE_DELIM;
3687  02c6 a605          	ld	a,#5
3688  02c8 e70a          	ld	(10,x),a
3689  02ca               L1141:
3690                     ; 2820 	  saved_nparseleft = pSocket->nParseLeft;
3692  02ca e606          	ld	a,(6,x)
3693  02cc c70042        	ld	_saved_nparseleft,a
3694                     ; 2821           pBuffer++;
3696  02cf 1e05          	ldw	x,(OFST+1,sp)
3697  02d1 5c            	incw	x
3698  02d2 1f05          	ldw	(OFST+1,sp),x
3699                     ; 2822 	  nBytes --;
3701  02d4 1e09          	ldw	x,(OFST+5,sp)
3702  02d6 5a            	decw	x
3703  02d7 1f09          	ldw	(OFST+5,sp),x
3704                     ; 2824 	  if (pSocket->ParseCmd == 'o' ||
3704                     ; 2825 	      pSocket->ParseCmd == 'a' ||
3704                     ; 2826 	      pSocket->ParseCmd == 'b' ||
3704                     ; 2827 	      pSocket->ParseCmd == 'c' ||
3704                     ; 2828 	      pSocket->ParseCmd == 'd' ||
3704                     ; 2829 	      pSocket->ParseCmd == 'g' ||
3704                     ; 2830 	      pSocket->ParseCmd == 'l' ||
3704                     ; 2831 	      pSocket->ParseCmd == 'm' ||
3704                     ; 2832 	      pSocket->ParseCmd == 'z') { }
3706  02d9 1e0b          	ldw	x,(OFST+7,sp)
3707  02db e608          	ld	a,(8,x)
3708  02dd a16f          	cp	a,#111
3709  02df 2724          	jreq	L5341
3711  02e1 a161          	cp	a,#97
3712  02e3 2720          	jreq	L5341
3714  02e5 a162          	cp	a,#98
3715  02e7 271c          	jreq	L5341
3717  02e9 a163          	cp	a,#99
3718  02eb 2718          	jreq	L5341
3720  02ed a164          	cp	a,#100
3721  02ef 2714          	jreq	L5341
3723  02f1 a167          	cp	a,#103
3724  02f3 2710          	jreq	L5341
3726  02f5 a16c          	cp	a,#108
3727  02f7 270c          	jreq	L5341
3729  02f9 a16d          	cp	a,#109
3730  02fb 2708          	jreq	L5341
3732  02fd a17a          	cp	a,#122
3733  02ff 2704          	jreq	L5341
3734                     ; 2835 	    pSocket->ParseState = PARSE_DELIM;
3736  0301 a605          	ld	a,#5
3737  0303 e70a          	ld	(10,x),a
3738  0305               L5341:
3739                     ; 2837 	  if (nBytes == 0) { // Hit end of fragment. Break out of while()
3741  0305 1e09          	ldw	x,(OFST+5,sp)
3742  0307 2699          	jrne	L1041
3743                     ; 2839 	    break;
3745  0309 cc0723        	jra	L3041
3746  030c               L5041:
3747                     ; 2843         else if (pSocket->ParseState == PARSE_NUM10) {
3749  030c a101          	cp	a,#1
3750  030e 2640          	jrne	L3441
3751                     ; 2844           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
3753  0310 1e05          	ldw	x,(OFST+1,sp)
3754  0312 f6            	ld	a,(x)
3755  0313 97            	ld	xl,a
3756  0314 a60a          	ld	a,#10
3757  0316 42            	mul	x,a
3758  0317 9f            	ld	a,xl
3759  0318 1e0b          	ldw	x,(OFST+7,sp)
3760  031a a0e0          	sub	a,#224
3761  031c e709          	ld	(9,x),a
3762                     ; 2845 	  saved_postpartial[1] = *pBuffer;
3764  031e 1e05          	ldw	x,(OFST+1,sp)
3765  0320 f6            	ld	a,(x)
3766  0321 c7002b        	ld	_saved_postpartial+1,a
3767                     ; 2846           pSocket->ParseState = saved_parsestate = PARSE_NUM1;
3769  0324 a602          	ld	a,#2
3770  0326 c70043        	ld	_saved_parsestate,a
3771  0329 1e0b          	ldw	x,(OFST+7,sp)
3772  032b e70a          	ld	(10,x),a
3773                     ; 2847 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3775  032d e606          	ld	a,(6,x)
3776  032f 2704          	jreq	L5441
3777                     ; 2848 	    pSocket->nParseLeft--;
3779  0331 6a06          	dec	(6,x)
3781  0333 2004          	jra	L7441
3782  0335               L5441:
3783                     ; 2852 	    pSocket->ParseState = PARSE_DELIM;
3785  0335 a605          	ld	a,#5
3786  0337 e70a          	ld	(10,x),a
3787  0339               L7441:
3788                     ; 2854 	  saved_nparseleft = pSocket->nParseLeft;
3790  0339 e606          	ld	a,(6,x)
3791  033b c70042        	ld	_saved_nparseleft,a
3792                     ; 2855           pBuffer++;
3794  033e 1e05          	ldw	x,(OFST+1,sp)
3795  0340 5c            	incw	x
3796  0341 1f05          	ldw	(OFST+1,sp),x
3797                     ; 2856 	  nBytes--;
3799  0343 1e09          	ldw	x,(OFST+5,sp)
3800  0345 5a            	decw	x
3801  0346 1f09          	ldw	(OFST+5,sp),x
3802                     ; 2857 	  if (nBytes == 0) {
3804  0348 2703cc02a2    	jrne	L1041
3805                     ; 2859 	    break;
3807  034d cc0723        	jra	L3041
3808  0350               L3441:
3809                     ; 2863         else if (pSocket->ParseState == PARSE_NUM1) {
3811  0350 a102          	cp	a,#2
3812  0352 2638          	jrne	L5541
3813                     ; 2864           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
3815  0354 1605          	ldw	y,(OFST+1,sp)
3816  0356 90f6          	ld	a,(y)
3817  0358 a030          	sub	a,#48
3818  035a eb09          	add	a,(9,x)
3819  035c e709          	ld	(9,x),a
3820                     ; 2865 	  saved_postpartial[2] = *pBuffer;
3822  035e 93            	ldw	x,y
3823  035f f6            	ld	a,(x)
3824  0360 c7002c        	ld	_saved_postpartial+2,a
3825                     ; 2866           pSocket->ParseState = saved_parsestate = PARSE_EQUAL;
3827  0363 a603          	ld	a,#3
3828  0365 c70043        	ld	_saved_parsestate,a
3829  0368 1e0b          	ldw	x,(OFST+7,sp)
3830  036a e70a          	ld	(10,x),a
3831                     ; 2867 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3833  036c e606          	ld	a,(6,x)
3834  036e 2704          	jreq	L7541
3835                     ; 2868 	    pSocket->nParseLeft--;
3837  0370 6a06          	dec	(6,x)
3839  0372 2004          	jra	L1641
3840  0374               L7541:
3841                     ; 2872 	    pSocket->ParseState = PARSE_DELIM;
3843  0374 a605          	ld	a,#5
3844  0376 e70a          	ld	(10,x),a
3845  0378               L1641:
3846                     ; 2874 	  saved_nparseleft = pSocket->nParseLeft;
3848  0378 e606          	ld	a,(6,x)
3849  037a c70042        	ld	_saved_nparseleft,a
3850                     ; 2875           pBuffer++;
3852  037d 1e05          	ldw	x,(OFST+1,sp)
3853  037f 5c            	incw	x
3854  0380 1f05          	ldw	(OFST+1,sp),x
3855                     ; 2876 	  nBytes--;
3857  0382 1e09          	ldw	x,(OFST+5,sp)
3858  0384 5a            	decw	x
3859  0385 1f09          	ldw	(OFST+5,sp),x
3860                     ; 2877 	  if (nBytes == 0) {
3862  0387 26c1          	jrne	L1041
3863                     ; 2879 	    break;
3865  0389 cc0723        	jra	L3041
3866  038c               L5541:
3867                     ; 2883         else if (pSocket->ParseState == PARSE_EQUAL) {
3869  038c a103          	cp	a,#3
3870  038e 262f          	jrne	L7641
3871                     ; 2884           pSocket->ParseState = saved_parsestate = PARSE_VAL;
3873  0390 a604          	ld	a,#4
3874  0392 c70043        	ld	_saved_parsestate,a
3875  0395 e70a          	ld	(10,x),a
3876                     ; 2885 	  saved_postpartial[3] = *pBuffer;
3878  0397 1e05          	ldw	x,(OFST+1,sp)
3879  0399 f6            	ld	a,(x)
3880  039a c7002d        	ld	_saved_postpartial+3,a
3881                     ; 2886 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3883  039d 1e0b          	ldw	x,(OFST+7,sp)
3884  039f e606          	ld	a,(6,x)
3885  03a1 2704          	jreq	L1741
3886                     ; 2887 	    pSocket->nParseLeft--;
3888  03a3 6a06          	dec	(6,x)
3890  03a5 2004          	jra	L3741
3891  03a7               L1741:
3892                     ; 2891 	    pSocket->ParseState = PARSE_DELIM;
3894  03a7 a605          	ld	a,#5
3895  03a9 e70a          	ld	(10,x),a
3896  03ab               L3741:
3897                     ; 2893 	  saved_nparseleft = pSocket->nParseLeft;
3899  03ab e606          	ld	a,(6,x)
3900  03ad c70042        	ld	_saved_nparseleft,a
3901                     ; 2894           pBuffer++;
3903  03b0 1e05          	ldw	x,(OFST+1,sp)
3904  03b2 5c            	incw	x
3905  03b3 1f05          	ldw	(OFST+1,sp),x
3906                     ; 2895 	  nBytes--;
3908  03b5 1e09          	ldw	x,(OFST+5,sp)
3909  03b7 5a            	decw	x
3910  03b8 1f09          	ldw	(OFST+5,sp),x
3911                     ; 2896 	  if (nBytes == 0) {
3913  03ba 268e          	jrne	L1041
3914                     ; 2898 	    break;
3916  03bc cc0723        	jra	L3041
3917  03bf               L7641:
3918                     ; 2902         else if (pSocket->ParseState == PARSE_VAL) {
3920  03bf a104          	cp	a,#4
3921  03c1 2703cc06f6    	jrne	L1051
3922                     ; 2915           if (pSocket->ParseCmd == 'o') {
3924  03c6 e608          	ld	a,(8,x)
3925  03c8 a16f          	cp	a,#111
3926  03ca 2640          	jrne	L3051
3927                     ; 2929               if ((uint8_t)(*pBuffer) == '1') pin_value = 1;
3929  03cc 1e05          	ldw	x,(OFST+1,sp)
3930  03ce f6            	ld	a,(x)
3931  03cf a131          	cp	a,#49
3932  03d1 2604          	jrne	L5051
3935  03d3 a601          	ld	a,#1
3937  03d5 2001          	jra	L7051
3938  03d7               L5051:
3939                     ; 2930 	      else pin_value = 0;
3941  03d7 4f            	clr	a
3942  03d8               L7051:
3943  03d8 6b01          	ld	(OFST-3,sp),a
3945                     ; 2931 	      GpioSetPin(pSocket->ParseNum, (uint8_t)pin_value);
3947  03da 160b          	ldw	y,(OFST+7,sp)
3948  03dc 97            	ld	xl,a
3949  03dd 90e609        	ld	a,(9,y)
3950  03e0 95            	ld	xh,a
3951  03e1 cd0000        	call	_GpioSetPin
3953                     ; 2933 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent
3955  03e4 1e0b          	ldw	x,(OFST+7,sp)
3956  03e6 e606          	ld	a,(6,x)
3957  03e8 2704          	jreq	L1151
3960  03ea 6a06          	dec	(6,x)
3961  03ec e606          	ld	a,(6,x)
3962  03ee               L1151:
3963                     ; 2935             saved_nparseleft = pSocket->nParseLeft;
3965  03ee c70042        	ld	_saved_nparseleft,a
3966                     ; 2936             pBuffer++;
3968  03f1 1e05          	ldw	x,(OFST+1,sp)
3969  03f3 5c            	incw	x
3970  03f4 1f05          	ldw	(OFST+1,sp),x
3971                     ; 2937 	    nBytes--;
3973  03f6 1e09          	ldw	x,(OFST+5,sp)
3974  03f8 5a            	decw	x
3975  03f9 1f09          	ldw	(OFST+5,sp),x
3976                     ; 2938 	    if (nBytes == 0) {
3978  03fb 2703cc06d4    	jrne	L5151
3979                     ; 2941 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
3981  0400 a605          	ld	a,#5
3982  0402 c70043        	ld	_saved_parsestate,a
3983  0405 1e0b          	ldw	x,(OFST+7,sp)
3984  0407 e70a          	ld	(10,x),a
3985                     ; 2942 	      break;
3987  0409 cc0723        	jra	L3041
3988  040c               L3051:
3989                     ; 2949           else if (pSocket->ParseCmd == 'a'
3989                     ; 2950                 || pSocket->ParseCmd == 'l'
3989                     ; 2951                 || pSocket->ParseCmd == 'm' ) {
3991  040c a161          	cp	a,#97
3992  040e 2708          	jreq	L1251
3994  0410 a16c          	cp	a,#108
3995  0412 2704          	jreq	L1251
3997  0414 a16d          	cp	a,#109
3998  0416 2657          	jrne	L7151
3999  0418               L1251:
4000                     ; 2955 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4002  0418 725f000a      	clr	_break_while
4003                     ; 2957             tmp_pBuffer = pBuffer;
4005  041c 1e05          	ldw	x,(OFST+1,sp)
4006  041e cf000e        	ldw	_tmp_pBuffer,x
4007                     ; 2958             tmp_nBytes = nBytes;
4009  0421 1e09          	ldw	x,(OFST+5,sp)
4010  0423 cf000c        	ldw	_tmp_nBytes,x
4011                     ; 2959 	    tmp_nParseLeft = pSocket->nParseLeft;
4013  0426 1e0b          	ldw	x,(OFST+7,sp)
4014  0428 e606          	ld	a,(6,x)
4015  042a c7000b        	ld	_tmp_nParseLeft,a
4016                     ; 2960             switch (pSocket->ParseCmd) {
4018  042d e608          	ld	a,(8,x)
4020                     ; 2963               case 'm': i = 10; break;
4021  042f a061          	sub	a,#97
4022  0431 270b          	jreq	L3101
4023  0433 a00b          	sub	a,#11
4024  0435 270b          	jreq	L5101
4025  0437 4a            	dec	a
4026  0438 2708          	jreq	L5101
4027  043a 7b04          	ld	a,(OFST+0,sp)
4028  043c 2008          	jra	L7251
4029  043e               L3101:
4030                     ; 2961               case 'a': i = 19; break;
4032  043e a613          	ld	a,#19
4035  0440 2002          	jp	LC015
4036  0442               L5101:
4037                     ; 2962               case 'l':
4037                     ; 2963               case 'm': i = 10; break;
4039  0442 a60a          	ld	a,#10
4040  0444               LC015:
4041  0444 6b04          	ld	(OFST+0,sp),a
4045  0446               L7251:
4046                     ; 2965             parse_POST_string(pSocket->ParseCmd, i);
4048  0446 160b          	ldw	y,(OFST+7,sp)
4049  0448 97            	ld	xl,a
4050  0449 90e608        	ld	a,(8,y)
4051  044c 95            	ld	xh,a
4052  044d cd0000        	call	_parse_POST_string
4054                     ; 2966             pBuffer = tmp_pBuffer;
4056  0450 ce000e        	ldw	x,_tmp_pBuffer
4057  0453 1f05          	ldw	(OFST+1,sp),x
4058                     ; 2967             nBytes = tmp_nBytes;
4060  0455 ce000c        	ldw	x,_tmp_nBytes
4061  0458 1f09          	ldw	(OFST+5,sp),x
4062                     ; 2968 	    pSocket->nParseLeft = tmp_nParseLeft;
4064  045a 1e0b          	ldw	x,(OFST+7,sp)
4065  045c c6000b        	ld	a,_tmp_nParseLeft
4066  045f e706          	ld	(6,x),a
4067                     ; 2969             if (break_while == 1) {
4069  0461 c6000a        	ld	a,_break_while
4070  0464 4a            	dec	a
4071  0465 2696          	jrne	L5151
4072                     ; 2973 	      pSocket->ParseState = saved_parsestate;
4074  0467 c60043        	ld	a,_saved_parsestate
4075  046a e70a          	ld	(10,x),a
4076                     ; 2974 	      break;
4078  046c cc0723        	jra	L3041
4079  046f               L7151:
4080                     ; 2981           else if (pSocket->ParseCmd == 'b') {
4082  046f a162          	cp	a,#98
4083  0471 2654          	jrne	L5351
4084                     ; 2989 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4086  0473 725f000a      	clr	_break_while
4087                     ; 2991             tmp_pBuffer = pBuffer;
4089  0477 1e05          	ldw	x,(OFST+1,sp)
4090  0479 cf000e        	ldw	_tmp_pBuffer,x
4091                     ; 2992             tmp_nBytes = nBytes;
4093  047c 1e09          	ldw	x,(OFST+5,sp)
4094  047e cf000c        	ldw	_tmp_nBytes,x
4095                     ; 2993 	    tmp_nParseLeft = pSocket->nParseLeft;
4097  0481 1e0b          	ldw	x,(OFST+7,sp)
4098  0483 e606          	ld	a,(6,x)
4099  0485 c7000b        	ld	_tmp_nParseLeft,a
4100                     ; 2994             parse_POST_address(pSocket->ParseCmd, pSocket->ParseNum);
4102  0488 e609          	ld	a,(9,x)
4103  048a 160b          	ldw	y,(OFST+7,sp)
4104  048c 97            	ld	xl,a
4105  048d 90e608        	ld	a,(8,y)
4106  0490 95            	ld	xh,a
4107  0491 cd0000        	call	_parse_POST_address
4109                     ; 2995             pBuffer = tmp_pBuffer;
4111  0494 ce000e        	ldw	x,_tmp_pBuffer
4112  0497 1f05          	ldw	(OFST+1,sp),x
4113                     ; 2996             nBytes = tmp_nBytes;
4115  0499 ce000c        	ldw	x,_tmp_nBytes
4116  049c 1f09          	ldw	(OFST+5,sp),x
4117                     ; 2997 	    pSocket->nParseLeft = tmp_nParseLeft;
4119  049e 1e0b          	ldw	x,(OFST+7,sp)
4120  04a0 c6000b        	ld	a,_tmp_nParseLeft
4121  04a3 e706          	ld	(6,x),a
4122                     ; 2998             if (break_while == 1) {
4124  04a5 c6000a        	ld	a,_break_while
4125  04a8 a101          	cp	a,#1
4126  04aa 260a          	jrne	L7351
4127                     ; 3002               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4129  04ac a604          	ld	a,#4
4130  04ae c70043        	ld	_saved_parsestate,a
4131  04b1 e70a          	ld	(10,x),a
4132                     ; 3003 	      break;
4134  04b3 cc0723        	jra	L3041
4135  04b6               L7351:
4136                     ; 3005             if (break_while == 2) {
4138  04b6 a102          	cp	a,#2
4139  04b8 2703cc06d4    	jrne	L5151
4140                     ; 3008               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4142  04bd a605          	ld	a,#5
4143  04bf c70043        	ld	_saved_parsestate,a
4144  04c2 e70a          	ld	(10,x),a
4145                     ; 3009 	      break;
4147  04c4 cc0723        	jra	L3041
4148  04c7               L5351:
4149                     ; 3016           else if (pSocket->ParseCmd == 'c') {
4151  04c7 a163          	cp	a,#99
4152  04c9 2651          	jrne	L5451
4153                     ; 3025 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4155  04cb 725f000a      	clr	_break_while
4156                     ; 3027             tmp_pBuffer = pBuffer;
4158  04cf 1e05          	ldw	x,(OFST+1,sp)
4159  04d1 cf000e        	ldw	_tmp_pBuffer,x
4160                     ; 3028             tmp_nBytes = nBytes;
4162  04d4 1e09          	ldw	x,(OFST+5,sp)
4163  04d6 cf000c        	ldw	_tmp_nBytes,x
4164                     ; 3029 	    tmp_nParseLeft = pSocket->nParseLeft;
4166  04d9 1e0b          	ldw	x,(OFST+7,sp)
4167  04db e606          	ld	a,(6,x)
4168  04dd c7000b        	ld	_tmp_nParseLeft,a
4169                     ; 3030             parse_POST_port(pSocket->ParseCmd, pSocket->ParseNum);
4171  04e0 e609          	ld	a,(9,x)
4172  04e2 160b          	ldw	y,(OFST+7,sp)
4173  04e4 97            	ld	xl,a
4174  04e5 90e608        	ld	a,(8,y)
4175  04e8 95            	ld	xh,a
4176  04e9 cd0000        	call	_parse_POST_port
4178                     ; 3031             pBuffer = tmp_pBuffer;
4180  04ec ce000e        	ldw	x,_tmp_pBuffer
4181  04ef 1f05          	ldw	(OFST+1,sp),x
4182                     ; 3032             nBytes = tmp_nBytes;
4184  04f1 ce000c        	ldw	x,_tmp_nBytes
4185  04f4 1f09          	ldw	(OFST+5,sp),x
4186                     ; 3033 	    pSocket->nParseLeft = tmp_nParseLeft;
4188  04f6 1e0b          	ldw	x,(OFST+7,sp)
4189  04f8 c6000b        	ld	a,_tmp_nParseLeft
4190  04fb e706          	ld	(6,x),a
4191                     ; 3034             if (break_while == 1) {
4193  04fd c6000a        	ld	a,_break_while
4194  0500 a101          	cp	a,#1
4195  0502 260a          	jrne	L7451
4196                     ; 3037               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4198  0504 a604          	ld	a,#4
4199  0506 c70043        	ld	_saved_parsestate,a
4200  0509 e70a          	ld	(10,x),a
4201                     ; 3038 	      break;
4203  050b cc0723        	jra	L3041
4204  050e               L7451:
4205                     ; 3040             if (break_while == 2) {
4207  050e a102          	cp	a,#2
4208  0510 26a8          	jrne	L5151
4209                     ; 3043               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4211  0512 a605          	ld	a,#5
4212  0514 c70043        	ld	_saved_parsestate,a
4213  0517 e70a          	ld	(10,x),a
4214                     ; 3044 	      break;
4216  0519 cc0723        	jra	L3041
4217  051c               L5451:
4218                     ; 3051           else if (pSocket->ParseCmd == 'd') {
4220  051c a164          	cp	a,#100
4221  051e 2703cc05be    	jrne	L5551
4222                     ; 3057 	    alpha[0] = '-';
4224  0523 352d0004      	mov	_alpha,#45
4225                     ; 3058 	    alpha[1] = '-';
4227  0527 352d0005      	mov	_alpha+1,#45
4228                     ; 3060 	    if (saved_postpartial_previous[0] == 'd') {
4230  052b c60012        	ld	a,_saved_postpartial_previous
4231  052e a164          	cp	a,#100
4232  0530 261a          	jrne	L7551
4233                     ; 3064 	      saved_postpartial_previous[0] = '\0';
4235  0532 725f0012      	clr	_saved_postpartial_previous
4236                     ; 3070 	      if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
4238  0536 c60016        	ld	a,_saved_postpartial_previous+4
4239  0539 2705          	jreq	L1651
4242  053b 5500160004    	mov	_alpha,_saved_postpartial_previous+4
4243  0540               L1651:
4244                     ; 3071 	      if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
4246  0540 c60017        	ld	a,_saved_postpartial_previous+5
4247  0543 270a          	jreq	L5651
4250  0545 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
4251  054a 2003          	jra	L5651
4252  054c               L7551:
4253                     ; 3078               clear_saved_postpartial_data(); // Clear [4] and higher
4255  054c cd0000        	call	_clear_saved_postpartial_data
4257  054f               L5651:
4258                     ; 3081             if (alpha[0] == '-') {
4260  054f c60004        	ld	a,_alpha
4261  0552 a12d          	cp	a,#45
4262  0554 261e          	jrne	L7651
4263                     ; 3082 	      alpha[0] = (uint8_t)(*pBuffer);
4265  0556 1e05          	ldw	x,(OFST+1,sp)
4266  0558 f6            	ld	a,(x)
4267  0559 c70004        	ld	_alpha,a
4268                     ; 3083               saved_postpartial[4] = *pBuffer;
4270  055c c7002e        	ld	_saved_postpartial+4,a
4271                     ; 3084               pSocket->nParseLeft--;
4273  055f 1e0b          	ldw	x,(OFST+7,sp)
4274  0561 6a06          	dec	(6,x)
4275                     ; 3085               saved_nparseleft = pSocket->nParseLeft;
4277  0563 e606          	ld	a,(6,x)
4278  0565 c70042        	ld	_saved_nparseleft,a
4279                     ; 3086               pBuffer++;
4281  0568 1e05          	ldw	x,(OFST+1,sp)
4282  056a 5c            	incw	x
4283  056b 1f05          	ldw	(OFST+1,sp),x
4284                     ; 3087 	      nBytes--;
4286  056d 1e09          	ldw	x,(OFST+5,sp)
4287  056f 5a            	decw	x
4288  0570 1f09          	ldw	(OFST+5,sp),x
4289                     ; 3088               if (nBytes == 0) break; // Hit end of fragment. Break out of
4291  0572 27a5          	jreq	L3041
4294  0574               L7651:
4295                     ; 3092             if (alpha[1] == '-') {
4297  0574 c60005        	ld	a,_alpha+1
4298  0577 a12d          	cp	a,#45
4299  0579 261c          	jrne	L3751
4300                     ; 3093 	      alpha[1] = (uint8_t)(*pBuffer);
4302  057b 1e05          	ldw	x,(OFST+1,sp)
4303  057d f6            	ld	a,(x)
4304  057e c70005        	ld	_alpha+1,a
4305                     ; 3094               saved_postpartial[5] = *pBuffer;
4307  0581 c7002f        	ld	_saved_postpartial+5,a
4308                     ; 3095               pSocket->nParseLeft--;
4310  0584 1e0b          	ldw	x,(OFST+7,sp)
4311  0586 6a06          	dec	(6,x)
4312                     ; 3096               saved_nparseleft = pSocket->nParseLeft;
4314  0588 e606          	ld	a,(6,x)
4315  058a c70042        	ld	_saved_nparseleft,a
4316                     ; 3097               pBuffer++;
4318  058d 1e05          	ldw	x,(OFST+1,sp)
4319  058f 5c            	incw	x
4320  0590 1f05          	ldw	(OFST+1,sp),x
4321                     ; 3098 	      nBytes--;
4323  0592 1e09          	ldw	x,(OFST+5,sp)
4324  0594 5a            	decw	x
4325  0595 1f09          	ldw	(OFST+5,sp),x
4326  0597               L3751:
4327                     ; 3104             clear_saved_postpartial_all();
4329  0597 cd0000        	call	_clear_saved_postpartial_all
4331                     ; 3106             SetMAC(pSocket->ParseNum, alpha[0], alpha[1]);
4333  059a 3b0005        	push	_alpha+1
4334  059d c60004        	ld	a,_alpha
4335  05a0 160c          	ldw	y,(OFST+8,sp)
4336  05a2 97            	ld	xl,a
4337  05a3 90e609        	ld	a,(9,y)
4338  05a6 95            	ld	xh,a
4339  05a7 cd0000        	call	_SetMAC
4341  05aa 84            	pop	a
4342                     ; 3108             if (nBytes == 0) {
4344  05ab 1e09          	ldw	x,(OFST+5,sp)
4345  05ad 2703cc06d4    	jrne	L5151
4346                     ; 3111 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4348  05b2 a605          	ld	a,#5
4349  05b4 c70043        	ld	_saved_parsestate,a
4350  05b7 1e0b          	ldw	x,(OFST+7,sp)
4351  05b9 e70a          	ld	(10,x),a
4352                     ; 3112 	      break;
4354  05bb cc0723        	jra	L3041
4355  05be               L5551:
4356                     ; 3119 	  else if (pSocket->ParseCmd == 'g') {
4358  05be a167          	cp	a,#103
4359  05c0 2703cc06c7    	jrne	L1061
4360                     ; 3130             for (i=0; i<6; i++) alpha[i] = '-';
4362  05c5 4f            	clr	a
4363  05c6 6b04          	ld	(OFST+0,sp),a
4365  05c8               L3061:
4368  05c8 5f            	clrw	x
4369  05c9 97            	ld	xl,a
4370  05ca a62d          	ld	a,#45
4371  05cc d70004        	ld	(_alpha,x),a
4374  05cf 0c04          	inc	(OFST+0,sp)
4378  05d1 7b04          	ld	a,(OFST+0,sp)
4379  05d3 a106          	cp	a,#6
4380  05d5 25f1          	jrult	L3061
4381                     ; 3132 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4383  05d7 725f000a      	clr	_break_while
4384                     ; 3135 	    if (saved_postpartial_previous[0] == 'g') {
4386  05db c60012        	ld	a,_saved_postpartial_previous
4387  05de a167          	cp	a,#103
4388  05e0 2621          	jrne	L1161
4389                     ; 3139 	      saved_postpartial_previous[0] = '\0';
4391  05e2 725f0012      	clr	_saved_postpartial_previous
4392                     ; 3145               for (i=0; i<6; i++) {
4394  05e6 4f            	clr	a
4395  05e7 6b04          	ld	(OFST+0,sp),a
4397  05e9               L3161:
4398                     ; 3146                 if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
4400  05e9 5f            	clrw	x
4401  05ea 97            	ld	xl,a
4402  05eb 724d0016      	tnz	(_saved_postpartial_previous+4,x)
4403  05ef 2708          	jreq	L1261
4406  05f1 5f            	clrw	x
4407  05f2 97            	ld	xl,a
4408  05f3 d60016        	ld	a,(_saved_postpartial_previous+4,x)
4409  05f6 d70004        	ld	(_alpha,x),a
4410  05f9               L1261:
4411                     ; 3145               for (i=0; i<6; i++) {
4413  05f9 0c04          	inc	(OFST+0,sp)
4417  05fb 7b04          	ld	a,(OFST+0,sp)
4418  05fd a106          	cp	a,#6
4419  05ff 25e8          	jrult	L3161
4421  0601 2003          	jra	L3261
4422  0603               L1161:
4423                     ; 3154               clear_saved_postpartial_data(); // Clear [4] and higher
4425  0603 cd0000        	call	_clear_saved_postpartial_data
4427  0606               L3261:
4428                     ; 3157             for (i=0; i<6; i++) {
4430  0606 4f            	clr	a
4431  0607 6b04          	ld	(OFST+0,sp),a
4433  0609               L5261:
4434                     ; 3163               if (alpha[i] == '-') {
4436  0609 5f            	clrw	x
4437  060a 97            	ld	xl,a
4438  060b d60004        	ld	a,(_alpha,x)
4439  060e a12d          	cp	a,#45
4440  0610 2636          	jrne	L3361
4441                     ; 3164 	        alpha[i] = (uint8_t)(*pBuffer);
4443  0612 7b04          	ld	a,(OFST+0,sp)
4444  0614 5f            	clrw	x
4445  0615 1605          	ldw	y,(OFST+1,sp)
4446  0617 97            	ld	xl,a
4447  0618 90f6          	ld	a,(y)
4448  061a d70004        	ld	(_alpha,x),a
4449                     ; 3165                 saved_postpartial[i+4] = *pBuffer;
4451  061d 5f            	clrw	x
4452  061e 7b04          	ld	a,(OFST+0,sp)
4453  0620 97            	ld	xl,a
4454  0621 90f6          	ld	a,(y)
4455  0623 d7002e        	ld	(_saved_postpartial+4,x),a
4456                     ; 3166                 pSocket->nParseLeft--;
4458  0626 1e0b          	ldw	x,(OFST+7,sp)
4459  0628 6a06          	dec	(6,x)
4460                     ; 3167                 saved_nparseleft = pSocket->nParseLeft;
4462  062a e606          	ld	a,(6,x)
4463  062c c70042        	ld	_saved_nparseleft,a
4464                     ; 3168                 pBuffer++;
4466  062f 93            	ldw	x,y
4467  0630 5c            	incw	x
4468  0631 1f05          	ldw	(OFST+1,sp),x
4469                     ; 3169 	        nBytes--;
4471  0633 1e09          	ldw	x,(OFST+5,sp)
4472  0635 5a            	decw	x
4473  0636 1f09          	ldw	(OFST+5,sp),x
4474                     ; 3170                 if (i != 5 && nBytes == 0) {
4476  0638 7b04          	ld	a,(OFST+0,sp)
4477  063a a105          	cp	a,#5
4478  063c 270a          	jreq	L3361
4480  063e 1e09          	ldw	x,(OFST+5,sp)
4481  0640 2606          	jrne	L3361
4482                     ; 3171 		  break_while = 1; // Hit end of fragment. Break out of
4484  0642 3501000a      	mov	_break_while,#1
4485                     ; 3173 		  break; // Break out of for() loop
4487  0646 2008          	jra	L1361
4488  0648               L3361:
4489                     ; 3157             for (i=0; i<6; i++) {
4491  0648 0c04          	inc	(OFST+0,sp)
4495  064a 7b04          	ld	a,(OFST+0,sp)
4496  064c a106          	cp	a,#6
4497  064e 25b9          	jrult	L5261
4498  0650               L1361:
4499                     ; 3177 	    if (break_while == 1) {
4501  0650 c6000a        	ld	a,_break_while
4502  0653 4a            	dec	a
4503  0654 2603cc0723    	jreq	L3041
4504                     ; 3179 	      break;
4506                     ; 3185             clear_saved_postpartial_all();
4508  0659 cd0000        	call	_clear_saved_postpartial_all
4510                     ; 3188 	    if (alpha[0] != '0' && alpha[0] != '1') alpha[0] = '0';
4512  065c c60004        	ld	a,_alpha
4513  065f a130          	cp	a,#48
4514  0661 2708          	jreq	L1461
4516  0663 a131          	cp	a,#49
4517  0665 2704          	jreq	L1461
4520  0667 35300004      	mov	_alpha,#48
4521  066b               L1461:
4522                     ; 3189 	    if (alpha[1] != '0' && alpha[1] != '1') alpha[1] = '0';
4524  066b c60005        	ld	a,_alpha+1
4525  066e a130          	cp	a,#48
4526  0670 2708          	jreq	L3461
4528  0672 a131          	cp	a,#49
4529  0674 2704          	jreq	L3461
4532  0676 35300005      	mov	_alpha+1,#48
4533  067a               L3461:
4534                     ; 3190 	    if (alpha[2] != '0' && alpha[2] != '1' && alpha[2] != '2') alpha[2] = '2';
4536  067a c60006        	ld	a,_alpha+2
4537  067d a130          	cp	a,#48
4538  067f 270c          	jreq	L5461
4540  0681 a131          	cp	a,#49
4541  0683 2708          	jreq	L5461
4543  0685 a132          	cp	a,#50
4544  0687 2704          	jreq	L5461
4547  0689 35320006      	mov	_alpha+2,#50
4548  068d               L5461:
4549                     ; 3191 	    if (alpha[3] != '0' && alpha[3] != '1') alpha[3] = '0';
4551  068d c60007        	ld	a,_alpha+3
4552  0690 a130          	cp	a,#48
4553  0692 2708          	jreq	L7461
4555  0694 a131          	cp	a,#49
4556  0696 2704          	jreq	L7461
4559  0698 35300007      	mov	_alpha+3,#48
4560  069c               L7461:
4561                     ; 3193 	    Pending_config_settings[0] = (uint8_t)alpha[0];
4563  069c 5500040000    	mov	_Pending_config_settings,_alpha
4564                     ; 3194             Pending_config_settings[1] = (uint8_t)alpha[1];
4566  06a1 5500050001    	mov	_Pending_config_settings+1,_alpha+1
4567                     ; 3195             Pending_config_settings[2] = (uint8_t)alpha[2];
4569  06a6 5500060002    	mov	_Pending_config_settings+2,_alpha+2
4570                     ; 3196             Pending_config_settings[3] = (uint8_t)alpha[3];
4572  06ab 5500070003    	mov	_Pending_config_settings+3,_alpha+3
4573                     ; 3197             Pending_config_settings[4] = '0';
4575  06b0 35300004      	mov	_Pending_config_settings+4,#48
4576                     ; 3198             Pending_config_settings[5] = '0';
4578  06b4 35300005      	mov	_Pending_config_settings+5,#48
4579                     ; 3200             if (nBytes == 0) {
4581  06b8 1e09          	ldw	x,(OFST+5,sp)
4582  06ba 2618          	jrne	L5151
4583                     ; 3203 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4585  06bc a605          	ld	a,#5
4586  06be c70043        	ld	_saved_parsestate,a
4587  06c1 1e0b          	ldw	x,(OFST+7,sp)
4588  06c3 e70a          	ld	(10,x),a
4589                     ; 3204 	      break;
4591  06c5 205c          	jra	L3041
4592  06c7               L1061:
4593                     ; 3211 	  else if (pSocket->ParseCmd == 'z') {
4595  06c7 a17a          	cp	a,#122
4596  06c9 2609          	jrne	L5151
4597                     ; 3236 	    nBytes = 0;
4599  06cb 5f            	clrw	x
4600  06cc 1f09          	ldw	(OFST+5,sp),x
4601                     ; 3237 	    pSocket->nParseLeft = 0;
4603  06ce 1e0b          	ldw	x,(OFST+7,sp)
4604  06d0 6f06          	clr	(6,x)
4605                     ; 3238             break; // Break out of the while loop. We're done with POST.
4607  06d2 204f          	jra	L3041
4608  06d4               L5151:
4609                     ; 3249           pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4611  06d4 a605          	ld	a,#5
4612  06d6 c70043        	ld	_saved_parsestate,a
4613  06d9 1e0b          	ldw	x,(OFST+7,sp)
4614  06db e70a          	ld	(10,x),a
4615                     ; 3251           if (pSocket->nParseLeft < 30) {
4617  06dd e606          	ld	a,(6,x)
4618  06df a11e          	cp	a,#30
4619  06e1 2503cc02a2    	jruge	L1041
4620                     ; 3266 	    if (pSocket->nParseLeftAddl > 0) {
4622  06e6 6d07          	tnz	(7,x)
4623  06e8 27f9          	jreq	L1041
4624                     ; 3267 	      pSocket->nParseLeft += pSocket->nParseLeftAddl;
4626  06ea eb07          	add	a,(7,x)
4627  06ec e706          	ld	(6,x),a
4628                     ; 3268 	      pSocket->nParseLeftAddl = 0;
4630  06ee 6f07          	clr	(7,x)
4631                     ; 3269 	      saved_nparseleft = pSocket->nParseLeft;
4633  06f0 c70042        	ld	_saved_nparseleft,a
4634  06f3 cc02a2        	jra	L1041
4635  06f6               L1051:
4636                     ; 3274         else if (pSocket->ParseState == PARSE_DELIM) {
4638  06f6 a105          	cp	a,#5
4639  06f8 26f9          	jrne	L1041
4640                     ; 3275           if (pSocket->nParseLeft > 0) {
4642  06fa e606          	ld	a,(6,x)
4643  06fc 2720          	jreq	L7661
4644                     ; 3278             pSocket->ParseState = saved_parsestate = PARSE_CMD;
4646  06fe 725f0043      	clr	_saved_parsestate
4647  0702 6f0a          	clr	(10,x)
4648                     ; 3279             pSocket->nParseLeft--;
4650  0704 6a06          	dec	(6,x)
4651                     ; 3280             saved_nparseleft = pSocket->nParseLeft;
4653  0706 e606          	ld	a,(6,x)
4654  0708 c70042        	ld	_saved_nparseleft,a
4655                     ; 3281             pBuffer++;
4657  070b 1e05          	ldw	x,(OFST+1,sp)
4658  070d 5c            	incw	x
4659  070e 1f05          	ldw	(OFST+1,sp),x
4660                     ; 3282 	    nBytes--;
4662  0710 1e09          	ldw	x,(OFST+5,sp)
4663  0712 5a            	decw	x
4664  0713 1f09          	ldw	(OFST+5,sp),x
4665                     ; 3284 	    clear_saved_postpartial_all();
4667  0715 cd0000        	call	_clear_saved_postpartial_all
4669                     ; 3288             if (nBytes == 0) {
4671  0718 1e09          	ldw	x,(OFST+5,sp)
4672  071a 26d7          	jrne	L1041
4673                     ; 3289 	      break; // Hit end of fragment but still have more to parse in
4675  071c 2005          	jra	L3041
4676  071e               L7661:
4677                     ; 3299             pSocket->nParseLeft = 0; // End the parsing
4679  071e e706          	ld	(6,x),a
4680                     ; 3300 	    nBytes = 0;
4682  0720 5f            	clrw	x
4683  0721 1f09          	ldw	(OFST+5,sp),x
4684                     ; 3301 	    break; // Exit parsing
4685  0723               L3041:
4686                     ; 3328       if (pSocket->nParseLeft == 0) {
4688  0723 1e0b          	ldw	x,(OFST+7,sp)
4689  0725 e606          	ld	a,(6,x)
4690  0727 264e          	jrne	L5761
4691                     ; 3331 	saved_nstate = STATE_NULL;
4693  0729 357f0044      	mov	_saved_nstate,#127
4694                     ; 3332 	saved_parsestate = PARSE_CMD;
4696  072d c70043        	ld	_saved_parsestate,a
4697                     ; 3333         saved_nparseleft = 0;
4699  0730 c70042        	ld	_saved_nparseleft,a
4700                     ; 3334         saved_newlines = 0;
4702  0733 c70011        	ld	_saved_newlines,a
4703                     ; 3335 	for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i] = '\0';
4705  0736 6b04          	ld	(OFST+0,sp),a
4707  0738               L7761:
4710  0738 5f            	clrw	x
4711  0739 97            	ld	xl,a
4712  073a 724f002a      	clr	(_saved_postpartial,x)
4713  073e 5f            	clrw	x
4714  073f 97            	ld	xl,a
4715  0740 724f0012      	clr	(_saved_postpartial_previous,x)
4718  0744 0c04          	inc	(OFST+0,sp)
4722  0746 7b04          	ld	a,(OFST+0,sp)
4723  0748 a118          	cp	a,#24
4724  074a 25ec          	jrult	L7761
4725                     ; 3341 	parse_complete = 1;
4727  074c 35010000      	mov	_parse_complete,#1
4728                     ; 3342 	pSocket->nState = STATE_SENDHEADER;
4730  0750 1e0b          	ldw	x,(OFST+7,sp)
4731  0752 a60b          	ld	a,#11
4732  0754 f7            	ld	(x),a
4733                     ; 3354         if (current_webpage == WEBPAGE_IOCONTROL) {
4735  0755 c60003        	ld	a,_current_webpage
4736  0758 260c          	jrne	L5071
4737                     ; 3355           pSocket->pData = g_HtmlPageIOControl;
4739  075a 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4740  075e ef01          	ldw	(1,x),y
4741                     ; 3356           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4743  0760 90ae0c06      	ldw	y,#3078
4744  0764 ef03          	ldw	(3,x),y
4745  0766               L5071:
4746                     ; 3358         if (current_webpage == WEBPAGE_CONFIGURATION) {
4748  0766 4a            	dec	a
4749  0767 2612          	jrne	L7731
4750                     ; 3359           pSocket->pData = g_HtmlPageConfiguration;
4752  0769 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
4753  076d ef01          	ldw	(1,x),y
4754                     ; 3360           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
4756  076f 90ae0c31      	ldw	y,#3121
4757  0773 ef03          	ldw	(3,x),y
4758  0775 2004          	jra	L7731
4759  0777               L5761:
4760                     ; 3380 	uip_len = 0;
4762  0777 5f            	clrw	x
4763  0778 cf0000        	ldw	_uip_len,x
4764  077b               L7731:
4765                     ; 3384     if (pSocket->nState == STATE_PARSEGET) {
4767  077b 1e0b          	ldw	x,(OFST+7,sp)
4768  077d f6            	ld	a,(x)
4769  077e a10d          	cp	a,#13
4770  0780 2703cc097a    	jrne	L3171
4772  0785 cc0973        	jra	L7171
4773  0788               L5171:
4774                     ; 3413         if (pSocket->ParseState == PARSE_SLASH1) {
4776  0788 1e0b          	ldw	x,(OFST+7,sp)
4777  078a e60a          	ld	a,(10,x)
4778  078c a106          	cp	a,#6
4779  078e 263c          	jrne	L3271
4780                     ; 3416           pSocket->ParseCmd = *pBuffer;
4782  0790 1e05          	ldw	x,(OFST+1,sp)
4783  0792 f6            	ld	a,(x)
4784  0793 1e0b          	ldw	x,(OFST+7,sp)
4785  0795 e708          	ld	(8,x),a
4786                     ; 3417           pSocket->nParseLeft--;
4788  0797 6a06          	dec	(6,x)
4789                     ; 3418           pBuffer++;
4791  0799 1e05          	ldw	x,(OFST+1,sp)
4792  079b 5c            	incw	x
4793  079c 1f05          	ldw	(OFST+1,sp),x
4794                     ; 3419 	  nBytes--;
4796  079e 1e09          	ldw	x,(OFST+5,sp)
4797  07a0 5a            	decw	x
4798  07a1 1f09          	ldw	(OFST+5,sp),x
4799                     ; 3420 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
4801  07a3 1e0b          	ldw	x,(OFST+7,sp)
4802  07a5 e608          	ld	a,(8,x)
4803  07a7 a12f          	cp	a,#47
4804  07a9 2605          	jrne	L5271
4805                     ; 3421 	    pSocket->ParseState = PARSE_NUM10;
4807  07ab a601          	ld	a,#1
4809  07ad cc0846        	jp	LC018
4810  07b0               L5271:
4811                     ; 3425 	    current_webpage = WEBPAGE_IOCONTROL;
4813  07b0 725f0003      	clr	_current_webpage
4814                     ; 3426             pSocket->pData = g_HtmlPageIOControl;
4816  07b4 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4817  07b8 ef01          	ldw	(1,x),y
4818                     ; 3427             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4820  07ba 90ae0c06      	ldw	y,#3078
4821  07be ef03          	ldw	(3,x),y
4822                     ; 3428             pSocket->nParseLeft = 0; // This will cause the while() to exit
4824  07c0 6f06          	clr	(6,x)
4825                     ; 3430             pSocket->nState = STATE_CONNECTED;
4827  07c2 7f            	clr	(x)
4828                     ; 3431             pSocket->nPrevBytes = 0xFFFF;
4830  07c3 90aeffff      	ldw	y,#65535
4831  07c7 ef0b          	ldw	(11,x),y
4832  07c9 cc0962        	jra	L1371
4833  07cc               L3271:
4834                     ; 3435         else if (pSocket->ParseState == PARSE_NUM10) {
4836  07cc a101          	cp	a,#1
4837  07ce 2640          	jrne	L3371
4838                     ; 3440 	  if (*pBuffer == ' ') {
4840  07d0 1e05          	ldw	x,(OFST+1,sp)
4841  07d2 f6            	ld	a,(x)
4842  07d3 a120          	cp	a,#32
4843  07d5 261e          	jrne	L5371
4844                     ; 3441 	    current_webpage = WEBPAGE_IOCONTROL;
4846  07d7 725f0003      	clr	_current_webpage
4847                     ; 3442             pSocket->pData = g_HtmlPageIOControl;
4849  07db 1e0b          	ldw	x,(OFST+7,sp)
4850  07dd 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4851  07e1 ef01          	ldw	(1,x),y
4852                     ; 3443             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4854  07e3 90ae0c06      	ldw	y,#3078
4855  07e7 ef03          	ldw	(3,x),y
4856                     ; 3444             pSocket->nParseLeft = 0;
4858  07e9 6f06          	clr	(6,x)
4859                     ; 3446             pSocket->nState = STATE_CONNECTED;
4861  07eb 7f            	clr	(x)
4862                     ; 3447             pSocket->nPrevBytes = 0xFFFF;
4864  07ec 90aeffff      	ldw	y,#65535
4865  07f0 ef0b          	ldw	(11,x),y
4867  07f2 cc0962        	jra	L1371
4868  07f5               L5371:
4869                     ; 3451 	  else if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
4871  07f5 a130          	cp	a,#48
4872  07f7 2547          	jrult	L1571
4874  07f9 a13a          	cp	a,#58
4875  07fb 2443          	jruge	L1571
4876                     ; 3453             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
4878  07fd 97            	ld	xl,a
4879  07fe a60a          	ld	a,#10
4880  0800 42            	mul	x,a
4881  0801 9f            	ld	a,xl
4882  0802 1e0b          	ldw	x,(OFST+7,sp)
4883  0804 a0e0          	sub	a,#224
4884  0806 e709          	ld	(9,x),a
4885                     ; 3454 	    pSocket->ParseState = PARSE_NUM1;
4887  0808 a602          	ld	a,#2
4888  080a e70a          	ld	(10,x),a
4889                     ; 3455             pSocket->nParseLeft--;
4891  080c 6a06          	dec	(6,x)
4892                     ; 3456             pBuffer++;
4893                     ; 3457 	    nBytes--;
4895  080e 2023          	jp	LC020
4896                     ; 3462             pSocket->nParseLeft = 0;
4897                     ; 3463             pSocket->ParseState = PARSE_FAIL;
4898  0810               L3371:
4899                     ; 3468         else if (pSocket->ParseState == PARSE_NUM1) {
4901  0810 a102          	cp	a,#2
4902  0812 2637          	jrne	L7471
4903                     ; 3469 	  if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
4905  0814 1e05          	ldw	x,(OFST+1,sp)
4906  0816 f6            	ld	a,(x)
4907  0817 a130          	cp	a,#48
4908  0819 2525          	jrult	L1571
4910  081b a13a          	cp	a,#58
4911  081d 2421          	jruge	L1571
4912                     ; 3471             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
4914  081f 1605          	ldw	y,(OFST+1,sp)
4915  0821 1e0b          	ldw	x,(OFST+7,sp)
4916  0823 90f6          	ld	a,(y)
4917  0825 a030          	sub	a,#48
4918  0827 eb09          	add	a,(9,x)
4919  0829 e709          	ld	(9,x),a
4920                     ; 3472             pSocket->ParseState = PARSE_VAL;
4922  082b a604          	ld	a,#4
4923  082d e70a          	ld	(10,x),a
4924                     ; 3473             pSocket->nParseLeft = 1; // Set to 1 so PARSE_VAL will be called
4926  082f a601          	ld	a,#1
4927  0831 e706          	ld	(6,x),a
4928                     ; 3474             pBuffer++;
4930                     ; 3475 	    nBytes--;
4932  0833               LC020:
4934  0833 1e05          	ldw	x,(OFST+1,sp)
4935  0835 5c            	incw	x
4936  0836 1f05          	ldw	(OFST+1,sp),x
4938  0838 1e09          	ldw	x,(OFST+5,sp)
4939  083a 5a            	decw	x
4940  083b 1f09          	ldw	(OFST+5,sp),x
4942  083d cc0962        	jra	L1371
4943  0840               L1571:
4944                     ; 3480             pSocket->nParseLeft = 0;
4946                     ; 3481             pSocket->ParseState = PARSE_FAIL;
4949  0840 1e0b          	ldw	x,(OFST+7,sp)
4951  0842 a607          	ld	a,#7
4952  0844 6f06          	clr	(6,x)
4953  0846               LC018:
4954  0846 e70a          	ld	(10,x),a
4955  0848 cc0962        	jra	L1371
4956  084b               L7471:
4957                     ; 3485         else if (pSocket->ParseState == PARSE_VAL) {
4959  084b a104          	cp	a,#4
4960  084d 26f9          	jrne	L1371
4961                     ; 3551           switch(pSocket->ParseNum)
4963  084f e609          	ld	a,(9,x)
4965                     ; 3726 	      break;
4966  0851 a110          	cp	a,#16
4967  0853 2407          	jruge	L012
4968  0855 5f            	clrw	x
4969  0856 97            	ld	xl,a
4970  0857 58            	sllw	x
4971  0858 de1b64        	ldw	x,(L212,x)
4972  085b fc            	jp	(x)
4973  085c               L012:
4974  085c a037          	sub	a,#55
4975  085e 2603cc08f9    	jreq	L7501
4976  0863 4a            	dec	a
4977  0864 2603cc08ff    	jreq	L1601
4978  0869 a004          	sub	a,#4
4979  086b 2603cc0904    	jreq	L3601
4980  0870 4a            	dec	a
4981  0871 2603cc0913    	jreq	L5601
4982  0876 a004          	sub	a,#4
4983  0878 2603cc0926    	jreq	L7601
4984  087d a01a          	sub	a,#26
4985  087f 2603cc0931    	jreq	L1701
4986  0884 a008          	sub	a,#8
4987  0886 2603cc0937    	jreq	L3701
4988  088b cc0947        	jra	L5701
4989  088e               L7101:
4990                     ; 3599 	    case 0:  IO_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
4992  088e 72110000      	bres	_IO_8to1,#0
4995  0892 cc095e        	jra	L3671
4996  0895               L1201:
4997                     ; 3600 	    case 1:  IO_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
4999  0895 72100000      	bset	_IO_8to1,#0
5002  0899 cc095e        	jra	L3671
5003  089c               L3201:
5004                     ; 3601 	    case 2:  IO_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
5006  089c 72130000      	bres	_IO_8to1,#1
5009  08a0 cc095e        	jra	L3671
5010  08a3               L5201:
5011                     ; 3602 	    case 3:  IO_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
5013  08a3 72120000      	bset	_IO_8to1,#1
5016  08a7 cc095e        	jra	L3671
5017  08aa               L7201:
5018                     ; 3603 	    case 4:  IO_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
5020  08aa 72150000      	bres	_IO_8to1,#2
5023  08ae cc095e        	jra	L3671
5024  08b1               L1301:
5025                     ; 3604 	    case 5:  IO_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
5027  08b1 72140000      	bset	_IO_8to1,#2
5030  08b5 cc095e        	jra	L3671
5031  08b8               L3301:
5032                     ; 3605 	    case 6:  IO_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
5034  08b8 72170000      	bres	_IO_8to1,#3
5037  08bc cc095e        	jra	L3671
5038  08bf               L5301:
5039                     ; 3606 	    case 7:  IO_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
5041  08bf 72160000      	bset	_IO_8to1,#3
5044  08c3 cc095e        	jra	L3671
5045  08c6               L7301:
5046                     ; 3607 	    case 8:  IO_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
5048  08c6 72190000      	bres	_IO_8to1,#4
5051  08ca cc095e        	jra	L3671
5052  08cd               L1401:
5053                     ; 3608 	    case 9:  IO_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
5055  08cd 72180000      	bset	_IO_8to1,#4
5058  08d1 cc095e        	jra	L3671
5059  08d4               L3401:
5060                     ; 3609 	    case 10: IO_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
5062  08d4 721b0000      	bres	_IO_8to1,#5
5065  08d8 cc095e        	jra	L3671
5066  08db               L5401:
5067                     ; 3610 	    case 11: IO_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
5069  08db 721a0000      	bset	_IO_8to1,#5
5072  08df 207d          	jra	L3671
5073  08e1               L7401:
5074                     ; 3611 	    case 12: IO_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
5076  08e1 721d0000      	bres	_IO_8to1,#6
5079  08e5 2077          	jra	L3671
5080  08e7               L1501:
5081                     ; 3612 	    case 13: IO_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
5083  08e7 721c0000      	bset	_IO_8to1,#6
5086  08eb 2071          	jra	L3671
5087  08ed               L3501:
5088                     ; 3613 	    case 14: IO_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
5090  08ed 721f0000      	bres	_IO_8to1,#7
5093  08f1 206b          	jra	L3671
5094  08f3               L5501:
5095                     ; 3614 	    case 15: IO_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
5097  08f3 721e0000      	bset	_IO_8to1,#7
5100  08f7 2065          	jra	L3671
5101  08f9               L7501:
5102                     ; 3616 	    case 55:
5102                     ; 3617   	      IO_8to1 = (uint8_t)0xff; // Relays 1-8 ON
5104  08f9 35ff0000      	mov	_IO_8to1,#255
5105                     ; 3618 	      break;
5107  08fd 205f          	jra	L3671
5108  08ff               L1601:
5109                     ; 3620 	    case 56:
5109                     ; 3621               IO_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
5111  08ff c70000        	ld	_IO_8to1,a
5112                     ; 3622 	      break;
5114  0902 205a          	jra	L3671
5115  0904               L3601:
5116                     ; 3629 	    case 60: // Show IO Control page
5116                     ; 3630 	      current_webpage = WEBPAGE_IOCONTROL;
5118  0904 c70003        	ld	_current_webpage,a
5119                     ; 3631               pSocket->pData = g_HtmlPageIOControl;
5121  0907 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5122  090b ef01          	ldw	(1,x),y
5123                     ; 3632               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5125  090d 90ae0c06      	ldw	y,#3078
5126                     ; 3633               pSocket->nState = STATE_CONNECTED;
5127                     ; 3634               pSocket->nPrevBytes = 0xFFFF;
5128                     ; 3635 	      break;
5130  0911 200e          	jp	LC017
5131  0913               L5601:
5132                     ; 3637 	    case 61: // Show Configuration page
5132                     ; 3638 	      current_webpage = WEBPAGE_CONFIGURATION;
5134  0913 35010003      	mov	_current_webpage,#1
5135                     ; 3639               pSocket->pData = g_HtmlPageConfiguration;
5137  0917 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
5138  091b ef01          	ldw	(1,x),y
5139                     ; 3640               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
5141  091d 90ae0c31      	ldw	y,#3121
5142                     ; 3641               pSocket->nState = STATE_CONNECTED;
5144  0921               LC017:
5145  0921 ef03          	ldw	(3,x),y
5148  0923 f7            	ld	(x),a
5149                     ; 3642               pSocket->nPrevBytes = 0xFFFF;
5150                     ; 3643 	      break;
5152  0924 2032          	jp	LC016
5153  0926               L7601:
5154                     ; 3663 	    case 65: // Flash LED for diagnostics
5154                     ; 3664 	      // XXXXXXXXXXXXXXXXXXXXXX
5154                     ; 3665 	      // XXXXXXXXXXXXXXXXXXXXXX
5154                     ; 3666 	      // XXXXXXXXXXXXXXXXXXXXXX
5154                     ; 3667 	      debugflash();
5156  0926 cd0000        	call	_debugflash
5158                     ; 3668 	      debugflash();
5160  0929 cd0000        	call	_debugflash
5162                     ; 3669 	      debugflash();
5164  092c cd0000        	call	_debugflash
5166                     ; 3673 	      break;
5168  092f 202d          	jra	L3671
5169  0931               L1701:
5170                     ; 3708 	    case 91: // Reboot
5170                     ; 3709 	      user_reboot_request = 1;
5172  0931 35010000      	mov	_user_reboot_request,#1
5173                     ; 3710 	      break;
5175  0935 2027          	jra	L3671
5176  0937               L3701:
5177                     ; 3712             case 99: // Show simplified IO state page
5177                     ; 3713 	      current_webpage = WEBPAGE_RSTATE;
5179  0937 35060003      	mov	_current_webpage,#6
5180                     ; 3714               pSocket->pData = g_HtmlPageRstate;
5182  093b 90ae1841      	ldw	y,#L71_g_HtmlPageRstate
5183  093f ef01          	ldw	(1,x),y
5184                     ; 3715               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
5186  0941 90ae0087      	ldw	y,#135
5187                     ; 3716               pSocket->nState = STATE_CONNECTED;
5188                     ; 3717               pSocket->nPrevBytes = 0xFFFF;
5189                     ; 3718 	      break;
5191  0945 20da          	jp	LC017
5192  0947               L5701:
5193                     ; 3720 	    default: // Show IO Control page
5193                     ; 3721 	      current_webpage = WEBPAGE_IOCONTROL;
5195  0947 725f0003      	clr	_current_webpage
5196                     ; 3722               pSocket->pData = g_HtmlPageIOControl;
5198  094b 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5199  094f ef01          	ldw	(1,x),y
5200                     ; 3723               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5202  0951 90ae0c06      	ldw	y,#3078
5203  0955 ef03          	ldw	(3,x),y
5204                     ; 3724               pSocket->nState = STATE_CONNECTED;
5206  0957 7f            	clr	(x)
5207                     ; 3725               pSocket->nPrevBytes = 0xFFFF;
5209  0958               LC016:
5213  0958 90aeffff      	ldw	y,#65535
5214  095c ef0b          	ldw	(11,x),y
5215                     ; 3726 	      break;
5217  095e               L3671:
5218                     ; 3728           pSocket->nParseLeft = 0;
5220  095e 1e0b          	ldw	x,(OFST+7,sp)
5221  0960 6f06          	clr	(6,x)
5222  0962               L1371:
5223                     ; 3731         if (pSocket->ParseState == PARSE_FAIL) {
5225  0962 1e0b          	ldw	x,(OFST+7,sp)
5226  0964 e60a          	ld	a,(10,x)
5227  0966 a107          	cp	a,#7
5228                     ; 3736           pSocket->nState = STATE_SENDHEADER;
5229                     ; 3737 	  break;
5231  0968 2704          	jreq	LC021
5232                     ; 3740         if (pSocket->nParseLeft == 0) {
5234  096a e606          	ld	a,(6,x)
5235  096c 2605          	jrne	L7171
5236                     ; 3743           pSocket->nState = STATE_SENDHEADER;
5238  096e               LC021:
5240  096e a60b          	ld	a,#11
5241  0970 f7            	ld	(x),a
5242                     ; 3744           break;
5244  0971 2007          	jra	L3171
5245  0973               L7171:
5246                     ; 3412       while (nBytes != 0) {
5248  0973 1e09          	ldw	x,(OFST+5,sp)
5249  0975 2703cc0788    	jrne	L5171
5250  097a               L3171:
5251                     ; 3749     if (pSocket->nState == STATE_SENDHEADER) {
5253  097a 1e0b          	ldw	x,(OFST+7,sp)
5254  097c f6            	ld	a,(x)
5255  097d a10b          	cp	a,#11
5256  097f 261c          	jrne	L7701
5257                     ; 3755       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5259  0981 cd0000        	call	_adjust_template_size
5261  0984 89            	pushw	x
5262  0985 ce0000        	ldw	x,_uip_appdata
5263  0988 cd0000        	call	L5_CopyHttpHeader
5265  098b 5b02          	addw	sp,#2
5266  098d 89            	pushw	x
5267  098e ce0000        	ldw	x,_uip_appdata
5268  0991 cd0000        	call	_uip_send
5270  0994 85            	popw	x
5271                     ; 3756       pSocket->nState = STATE_SENDDATA;
5273  0995 1e0b          	ldw	x,(OFST+7,sp)
5274  0997 a60c          	ld	a,#12
5275  0999 f7            	ld	(x),a
5276                     ; 3757       return;
5278  099a cc011d        	jra	L042
5279  099d               L7701:
5280                     ; 3760     senddata:
5280                     ; 3761     if (pSocket->nState == STATE_SENDDATA) {
5282  099d 1e0b          	ldw	x,(OFST+7,sp)
5283  099f f6            	ld	a,(x)
5284  09a0 a10c          	cp	a,#12
5285  09a2 26f6          	jrne	L042
5286                     ; 3768       if (pSocket->nDataLeft == 0) {
5288  09a4 e604          	ld	a,(4,x)
5289  09a6 ea03          	or	a,(3,x)
5290  09a8 2605          	jrne	L5771
5291                     ; 3770         nBufSize = 0;
5293  09aa 5f            	clrw	x
5294  09ab 1f02          	ldw	(OFST-2,sp),x
5297  09ad 202f          	jra	L7771
5298  09af               L5771:
5299                     ; 3773         pSocket->nPrevBytes = pSocket->nDataLeft;
5301  09af 9093          	ldw	y,x
5302  09b1 90ee03        	ldw	y,(3,y)
5303  09b4 ef0b          	ldw	(11,x),y
5304                     ; 3774         nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5306  09b6 ce0000        	ldw	x,_uip_conn
5307  09b9 ee12          	ldw	x,(18,x)
5308  09bb 89            	pushw	x
5309  09bc 1e0d          	ldw	x,(OFST+9,sp)
5310  09be 1c0003        	addw	x,#3
5311  09c1 89            	pushw	x
5312  09c2 1e0f          	ldw	x,(OFST+11,sp)
5313  09c4 5c            	incw	x
5314  09c5 89            	pushw	x
5315  09c6 ce0000        	ldw	x,_uip_appdata
5316  09c9 cd0000        	call	L7_CopyHttpData
5318  09cc 5b06          	addw	sp,#6
5319  09ce 1f02          	ldw	(OFST-2,sp),x
5321                     ; 3775         pSocket->nPrevBytes -= pSocket->nDataLeft;
5323  09d0 1e0b          	ldw	x,(OFST+7,sp)
5324  09d2 e60c          	ld	a,(12,x)
5325  09d4 e004          	sub	a,(4,x)
5326  09d6 e70c          	ld	(12,x),a
5327  09d8 e60b          	ld	a,(11,x)
5328  09da e203          	sbc	a,(3,x)
5329  09dc e70b          	ld	(11,x),a
5330  09de               L7771:
5331                     ; 3778       if (nBufSize == 0) {
5333  09de 1e02          	ldw	x,(OFST-2,sp)
5334  09e0 2621          	jrne	LC013
5335                     ; 3780         uip_close();
5337  09e2               LC014:
5339  09e2 35100000      	mov	_uip_flags,#16
5341  09e6 cc011d        	jra	L042
5342                     ; 3784         uip_send(uip_appdata, nBufSize);
5344                     ; 3786       return;
5346  09e9               L5021:
5347                     ; 3790   else if (uip_rexmit()) {
5349  09e9 7205000075    	btjf	_uip_flags,#2,L3021
5350                     ; 3791     if (pSocket->nPrevBytes == 0xFFFF) {
5352  09ee 160b          	ldw	y,(OFST+7,sp)
5353  09f0 90ee0b        	ldw	y,(11,y)
5354  09f3 905c          	incw	y
5355  09f5 2617          	jrne	L1102
5356                     ; 3793       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5358  09f7 cd0000        	call	_adjust_template_size
5360  09fa 89            	pushw	x
5361  09fb ce0000        	ldw	x,_uip_appdata
5362  09fe cd0000        	call	L5_CopyHttpHeader
5364  0a01 5b02          	addw	sp,#2
5366  0a03               LC013:
5368  0a03 89            	pushw	x
5369  0a04 ce0000        	ldw	x,_uip_appdata
5370  0a07 cd0000        	call	_uip_send
5371  0a0a 85            	popw	x
5373  0a0b cc011d        	jra	L042
5374  0a0e               L1102:
5375                     ; 3796       pSocket->pData -= pSocket->nPrevBytes;
5377  0a0e 1e0b          	ldw	x,(OFST+7,sp)
5378  0a10 e602          	ld	a,(2,x)
5379  0a12 e00c          	sub	a,(12,x)
5380  0a14 e702          	ld	(2,x),a
5381  0a16 e601          	ld	a,(1,x)
5382  0a18 e20b          	sbc	a,(11,x)
5383  0a1a e701          	ld	(1,x),a
5384                     ; 3797       pSocket->nDataLeft += pSocket->nPrevBytes;
5386  0a1c e604          	ld	a,(4,x)
5387  0a1e eb0c          	add	a,(12,x)
5388  0a20 e704          	ld	(4,x),a
5389  0a22 e603          	ld	a,(3,x)
5390  0a24 e90b          	adc	a,(11,x)
5391                     ; 3798       pSocket->nPrevBytes = pSocket->nDataLeft;
5393  0a26 9093          	ldw	y,x
5394  0a28 e703          	ld	(3,x),a
5395  0a2a 90ee03        	ldw	y,(3,y)
5396  0a2d ef0b          	ldw	(11,x),y
5397                     ; 3799       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5399  0a2f ce0000        	ldw	x,_uip_conn
5400  0a32 ee12          	ldw	x,(18,x)
5401  0a34 89            	pushw	x
5402  0a35 1e0d          	ldw	x,(OFST+9,sp)
5403  0a37 1c0003        	addw	x,#3
5404  0a3a 89            	pushw	x
5405  0a3b 1e0f          	ldw	x,(OFST+11,sp)
5406  0a3d 5c            	incw	x
5407  0a3e 89            	pushw	x
5408  0a3f ce0000        	ldw	x,_uip_appdata
5409  0a42 cd0000        	call	L7_CopyHttpData
5411  0a45 5b06          	addw	sp,#6
5412  0a47 1f02          	ldw	(OFST-2,sp),x
5414                     ; 3800       pSocket->nPrevBytes -= pSocket->nDataLeft;
5416  0a49 1e0b          	ldw	x,(OFST+7,sp)
5417  0a4b e60c          	ld	a,(12,x)
5418  0a4d e004          	sub	a,(4,x)
5419  0a4f e70c          	ld	(12,x),a
5420  0a51 e60b          	ld	a,(11,x)
5421  0a53 e203          	sbc	a,(3,x)
5422  0a55 e70b          	ld	(11,x),a
5423                     ; 3801       if (nBufSize == 0) {
5425  0a57 1e02          	ldw	x,(OFST-2,sp)
5426                     ; 3803         uip_close();
5428  0a59 2787          	jreq	LC014
5429                     ; 3807         uip_send(uip_appdata, nBufSize);
5431  0a5b 89            	pushw	x
5432  0a5c ce0000        	ldw	x,_uip_appdata
5433  0a5f cd0000        	call	_uip_send
5435  0a62 85            	popw	x
5436                     ; 3810     return;
5438  0a63               L3021:
5439                     ; 3812 }
5441  0a63 cc011d        	jra	L042
5475                     ; 3815 void clear_saved_postpartial_all(void)
5475                     ; 3816 {
5476                     .text:	section	.text,new
5477  0000               _clear_saved_postpartial_all:
5479  0000 88            	push	a
5480       00000001      OFST:	set	1
5483                     ; 3818   for (i=0; i<24; i++) saved_postpartial[i] = '\0';
5485  0001 4f            	clr	a
5486  0002 6b01          	ld	(OFST+0,sp),a
5488  0004               L5302:
5491  0004 5f            	clrw	x
5492  0005 97            	ld	xl,a
5493  0006 724f002a      	clr	(_saved_postpartial,x)
5496  000a 0c01          	inc	(OFST+0,sp)
5500  000c 7b01          	ld	a,(OFST+0,sp)
5501  000e a118          	cp	a,#24
5502  0010 25f2          	jrult	L5302
5503                     ; 3819 }
5506  0012 84            	pop	a
5507  0013 81            	ret	
5541                     ; 3822 void clear_saved_postpartial_data(void)
5541                     ; 3823 {
5542                     .text:	section	.text,new
5543  0000               _clear_saved_postpartial_data:
5545  0000 88            	push	a
5546       00000001      OFST:	set	1
5549                     ; 3825   for (i=4; i<24; i++) saved_postpartial[i] = '\0';
5551  0001 a604          	ld	a,#4
5552  0003 6b01          	ld	(OFST+0,sp),a
5554  0005               L7502:
5557  0005 5f            	clrw	x
5558  0006 97            	ld	xl,a
5559  0007 724f002a      	clr	(_saved_postpartial,x)
5562  000b 0c01          	inc	(OFST+0,sp)
5566  000d 7b01          	ld	a,(OFST+0,sp)
5567  000f a118          	cp	a,#24
5568  0011 25f2          	jrult	L7502
5569                     ; 3826 }
5572  0013 84            	pop	a
5573  0014 81            	ret	
5607                     ; 3829 void clear_saved_postpartial_previous(void)
5607                     ; 3830 {
5608                     .text:	section	.text,new
5609  0000               _clear_saved_postpartial_previous:
5611  0000 88            	push	a
5612       00000001      OFST:	set	1
5615                     ; 3832   for (i=0; i<24; i++) saved_postpartial_previous[i] = '\0';
5617  0001 4f            	clr	a
5618  0002 6b01          	ld	(OFST+0,sp),a
5620  0004               L1012:
5623  0004 5f            	clrw	x
5624  0005 97            	ld	xl,a
5625  0006 724f0012      	clr	(_saved_postpartial_previous,x)
5628  000a 0c01          	inc	(OFST+0,sp)
5632  000c 7b01          	ld	a,(OFST+0,sp)
5633  000e a118          	cp	a,#24
5634  0010 25f2          	jrult	L1012
5635                     ; 3833 }
5638  0012 84            	pop	a
5639  0013 81            	ret	
5729                     ; 3836 void parse_POST_string(uint8_t curr_ParseCmd, uint8_t num_chars)
5729                     ; 3837 {
5730                     .text:	section	.text,new
5731  0000               _parse_POST_string:
5733  0000 89            	pushw	x
5734  0001 5217          	subw	sp,#23
5735       00000017      OFST:	set	23
5738                     ; 3860   amp_found = 0;
5740  0003 0f02          	clr	(OFST-21,sp)
5742                     ; 3861   for (i=0; i<20; i++) tmp_Pending[i] = '\0';
5744  0005 0f17          	clr	(OFST+0,sp)
5746  0007               L1412:
5749  0007 96            	ldw	x,sp
5750  0008 1c0003        	addw	x,#OFST-20
5751  000b 9f            	ld	a,xl
5752  000c 5e            	swapw	x
5753  000d 1b17          	add	a,(OFST+0,sp)
5754  000f 2401          	jrnc	L252
5755  0011 5c            	incw	x
5756  0012               L252:
5757  0012 02            	rlwa	x,a
5758  0013 7f            	clr	(x)
5761  0014 0c17          	inc	(OFST+0,sp)
5765  0016 7b17          	ld	a,(OFST+0,sp)
5766  0018 a114          	cp	a,#20
5767  001a 25eb          	jrult	L1412
5768                     ; 3863   if (saved_postpartial_previous[0] == curr_ParseCmd) {
5770  001c c60012        	ld	a,_saved_postpartial_previous
5771  001f 1118          	cp	a,(OFST+1,sp)
5772  0021 260a          	jrne	L7412
5773                     ; 3866     saved_postpartial_previous[0] = '\0';
5775  0023 725f0012      	clr	_saved_postpartial_previous
5776                     ; 3872     frag_flag = 1; // frag_flag is used to manage the TCP Fragment restore
5778  0027 a601          	ld	a,#1
5779  0029 6b17          	ld	(OFST+0,sp),a
5782  002b 2005          	jra	L1512
5783  002d               L7412:
5784                     ; 3876     frag_flag = 0;
5786  002d 0f17          	clr	(OFST+0,sp)
5788                     ; 3880     clear_saved_postpartial_data(); // Clear [4] and higher
5790  002f cd0000        	call	_clear_saved_postpartial_data
5792  0032               L1512:
5793                     ; 3901   resume = 0;
5795  0032 0f01          	clr	(OFST-22,sp)
5797                     ; 3902   if (frag_flag == 1) {
5799  0034 7b17          	ld	a,(OFST+0,sp)
5800  0036 4a            	dec	a
5801  0037 263f          	jrne	L3512
5802                     ; 3904     for (i = 0; i < num_chars; i++) {
5804  0039 6b17          	ld	(OFST+0,sp),a
5807  003b 2033          	jra	L1612
5808  003d               L5512:
5809                     ; 3913       if (saved_postpartial_previous[4+i] != '\0') {
5811  003d 5f            	clrw	x
5812  003e 97            	ld	xl,a
5813  003f 724d0016      	tnz	(_saved_postpartial_previous+4,x)
5814  0043 271b          	jreq	L5612
5815                     ; 3914         tmp_Pending[i] = saved_postpartial_previous[4+i];
5817  0045 96            	ldw	x,sp
5818  0046 1c0003        	addw	x,#OFST-20
5819  0049 9f            	ld	a,xl
5820  004a 5e            	swapw	x
5821  004b 1b17          	add	a,(OFST+0,sp)
5822  004d 2401          	jrnc	L652
5823  004f 5c            	incw	x
5824  0050               L652:
5825  0050 02            	rlwa	x,a
5826  0051 7b17          	ld	a,(OFST+0,sp)
5827  0053 905f          	clrw	y
5828  0055 9097          	ld	yl,a
5829  0057 90d60016      	ld	a,(_saved_postpartial_previous+4,y)
5830  005b f7            	ld	(x),a
5832                     ; 3904     for (i = 0; i < num_chars; i++) {
5834  005c 0c17          	inc	(OFST+0,sp)
5836  005e 2010          	jra	L1612
5837  0060               L5612:
5838                     ; 3917         resume = i;
5840  0060 6b01          	ld	(OFST-22,sp),a
5842                     ; 3918         break;
5843  0062               L3612:
5844                     ; 3921     if (*tmp_pBuffer == '&') {
5846  0062 72c6000e      	ld	a,[_tmp_pBuffer.w]
5847  0066 a126          	cp	a,#38
5848  0068 260e          	jrne	L3512
5849                     ; 3925       amp_found = 1;
5851  006a a601          	ld	a,#1
5852  006c 6b02          	ld	(OFST-21,sp),a
5854  006e 2008          	jra	L3512
5855  0070               L1612:
5856                     ; 3904     for (i = 0; i < num_chars; i++) {
5858  0070 7b17          	ld	a,(OFST+0,sp)
5859  0072 1119          	cp	a,(OFST+2,sp)
5860  0074 25c7          	jrult	L5512
5861  0076 20ea          	jra	L3612
5862  0078               L3512:
5863                     ; 3937   if (amp_found == 0) {
5865  0078 7b02          	ld	a,(OFST-21,sp)
5866  007a 2703cc0104    	jrne	L3712
5867                     ; 3938     for (i = resume; i < num_chars; i++) {
5869  007f 7b01          	ld	a,(OFST-22,sp)
5870  0081 6b17          	ld	(OFST+0,sp),a
5873  0083 207b          	jra	L1022
5874  0085               L5712:
5875                     ; 3941       if (amp_found == 0) {
5877  0085 7b02          	ld	a,(OFST-21,sp)
5878  0087 265d          	jrne	L5022
5879                     ; 3944         if (*tmp_pBuffer == '&') {
5881  0089 72c6000e      	ld	a,[_tmp_pBuffer.w]
5882  008d a126          	cp	a,#38
5883  008f 2606          	jrne	L7022
5884                     ; 3947           amp_found = 1;
5886  0091 a601          	ld	a,#1
5887  0093 6b02          	ld	(OFST-21,sp),a
5890  0095 204f          	jra	L5022
5891  0097               L7022:
5892                     ; 3950           tmp_Pending[i] = *tmp_pBuffer;
5894  0097 96            	ldw	x,sp
5895  0098 1c0003        	addw	x,#OFST-20
5896  009b 9f            	ld	a,xl
5897  009c 5e            	swapw	x
5898  009d 1b17          	add	a,(OFST+0,sp)
5899  009f 2401          	jrnc	L062
5900  00a1 5c            	incw	x
5901  00a2               L062:
5902  00a2 90ce000e      	ldw	y,_tmp_pBuffer
5903  00a6 02            	rlwa	x,a
5904  00a7 90f6          	ld	a,(y)
5905  00a9 f7            	ld	(x),a
5906                     ; 3951           saved_postpartial[4+i] = *tmp_pBuffer;
5908  00aa 5f            	clrw	x
5909  00ab 7b17          	ld	a,(OFST+0,sp)
5910  00ad 97            	ld	xl,a
5911  00ae 90f6          	ld	a,(y)
5912  00b0 d7002e        	ld	(_saved_postpartial+4,x),a
5913                     ; 3952           tmp_nParseLeft--;
5915  00b3 725a000b      	dec	_tmp_nParseLeft
5916                     ; 3953           saved_nparseleft = tmp_nParseLeft;
5918                     ; 3954           tmp_pBuffer++;
5920  00b7 93            	ldw	x,y
5921  00b8 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
5922  00bd 5c            	incw	x
5923  00be cf000e        	ldw	_tmp_pBuffer,x
5924                     ; 3955           tmp_nBytes--;
5926  00c1 ce000c        	ldw	x,_tmp_nBytes
5927  00c4 5a            	decw	x
5928  00c5 cf000c        	ldw	_tmp_nBytes,x
5929                     ; 3956           if (tmp_nBytes == 0) {
5931  00c8 261c          	jrne	L5022
5932                     ; 3960             if (i == (num_chars - 1)) {
5934  00ca 7b19          	ld	a,(OFST+2,sp)
5935  00cc 5f            	clrw	x
5936  00cd 97            	ld	xl,a
5937  00ce 5a            	decw	x
5938  00cf 7b17          	ld	a,(OFST+0,sp)
5939  00d1 905f          	clrw	y
5940  00d3 9097          	ld	yl,a
5941  00d5 90bf00        	ldw	c_y,y
5942  00d8 b300          	cpw	x,c_y
5943  00da 2604          	jrne	L5122
5944                     ; 3965               saved_parsestate = PARSE_DELIM;
5946  00dc 35050043      	mov	_saved_parsestate,#5
5947  00e0               L5122:
5948                     ; 3967             break_while = 1;
5950  00e0 3501000a      	mov	_break_while,#1
5951                     ; 3968             break; // This will break the for() loop. But we need to break the
5953  00e4 201e          	jra	L3712
5954  00e6               L5022:
5955                     ; 3974       if (amp_found == 1) {
5957  00e6 7b02          	ld	a,(OFST-21,sp)
5958  00e8 4a            	dec	a
5959  00e9 2611          	jrne	L7122
5960                     ; 3977         tmp_Pending[i] = '\0';
5962  00eb 96            	ldw	x,sp
5963  00ec 1c0003        	addw	x,#OFST-20
5964  00ef 9f            	ld	a,xl
5965  00f0 5e            	swapw	x
5966  00f1 1b17          	add	a,(OFST+0,sp)
5967  00f3 2401          	jrnc	L262
5968  00f5 5c            	incw	x
5969  00f6               L262:
5970  00f6 02            	rlwa	x,a
5971  00f7 7f            	clr	(x)
5972                     ; 3986         tmp_nParseLeft--;
5974  00f8 725a000b      	dec	_tmp_nParseLeft
5975  00fc               L7122:
5976                     ; 3938     for (i = resume; i < num_chars; i++) {
5978  00fc 0c17          	inc	(OFST+0,sp)
5980  00fe 7b17          	ld	a,(OFST+0,sp)
5981  0100               L1022:
5984  0100 1119          	cp	a,(OFST+2,sp)
5985  0102 2581          	jrult	L5712
5986  0104               L3712:
5987                     ; 4007   if (break_while == 0) clear_saved_postpartial_all();
5989  0104 c6000a        	ld	a,_break_while
5990  0107 2603          	jrne	L1222
5993  0109 cd0000        	call	_clear_saved_postpartial_all
5995  010c               L1222:
5996                     ; 4010   if (curr_ParseCmd == 'a') {
5998  010c 7b18          	ld	a,(OFST+1,sp)
5999  010e a161          	cp	a,#97
6000  0110 2622          	jrne	L3222
6001                     ; 4011     for (i=0; i<num_chars; i++) Pending_devicename[i] = tmp_Pending[i];
6003  0112 0f17          	clr	(OFST+0,sp)
6006  0114 2016          	jra	L1322
6007  0116               L5222:
6010  0116 5f            	clrw	x
6011  0117 97            	ld	xl,a
6012  0118 89            	pushw	x
6013  0119 96            	ldw	x,sp
6014  011a 1c0005        	addw	x,#OFST-18
6015  011d 9f            	ld	a,xl
6016  011e 5e            	swapw	x
6017  011f 1b19          	add	a,(OFST+2,sp)
6018  0121 2401          	jrnc	L662
6019  0123 5c            	incw	x
6020  0124               L662:
6021  0124 02            	rlwa	x,a
6022  0125 f6            	ld	a,(x)
6023  0126 85            	popw	x
6024  0127 d70000        	ld	(_Pending_devicename,x),a
6027  012a 0c17          	inc	(OFST+0,sp)
6029  012c               L1322:
6032  012c 7b17          	ld	a,(OFST+0,sp)
6033  012e 1119          	cp	a,(OFST+2,sp)
6034  0130 25e4          	jrult	L5222
6036  0132 204a          	jra	L5322
6037  0134               L3222:
6038                     ; 4016   else if (curr_ParseCmd == 'l') {
6040  0134 a16c          	cp	a,#108
6041  0136 2622          	jrne	L7322
6042                     ; 4017     for (i=0; i<num_chars; i++) Pending_mqtt_username[i] = tmp_Pending[i];
6044  0138 0f17          	clr	(OFST+0,sp)
6047  013a 2016          	jra	L5422
6048  013c               L1422:
6051  013c 5f            	clrw	x
6052  013d 97            	ld	xl,a
6053  013e 89            	pushw	x
6054  013f 96            	ldw	x,sp
6055  0140 1c0005        	addw	x,#OFST-18
6056  0143 9f            	ld	a,xl
6057  0144 5e            	swapw	x
6058  0145 1b19          	add	a,(OFST+2,sp)
6059  0147 2401          	jrnc	L072
6060  0149 5c            	incw	x
6061  014a               L072:
6062  014a 02            	rlwa	x,a
6063  014b f6            	ld	a,(x)
6064  014c 85            	popw	x
6065  014d d70000        	ld	(_Pending_mqtt_username,x),a
6068  0150 0c17          	inc	(OFST+0,sp)
6070  0152               L5422:
6073  0152 7b17          	ld	a,(OFST+0,sp)
6074  0154 1119          	cp	a,(OFST+2,sp)
6075  0156 25e4          	jrult	L1422
6077  0158 2024          	jra	L5322
6078  015a               L7322:
6079                     ; 4021   else if (curr_ParseCmd == 'm') {
6081  015a a16d          	cp	a,#109
6082  015c 2620          	jrne	L5322
6083                     ; 4022     for (i=0; i<num_chars; i++) Pending_mqtt_password[i] = tmp_Pending[i];
6085  015e 0f17          	clr	(OFST+0,sp)
6088  0160 2016          	jra	L1622
6089  0162               L5522:
6092  0162 5f            	clrw	x
6093  0163 97            	ld	xl,a
6094  0164 89            	pushw	x
6095  0165 96            	ldw	x,sp
6096  0166 1c0005        	addw	x,#OFST-18
6097  0169 9f            	ld	a,xl
6098  016a 5e            	swapw	x
6099  016b 1b19          	add	a,(OFST+2,sp)
6100  016d 2401          	jrnc	L272
6101  016f 5c            	incw	x
6102  0170               L272:
6103  0170 02            	rlwa	x,a
6104  0171 f6            	ld	a,(x)
6105  0172 85            	popw	x
6106  0173 d70000        	ld	(_Pending_mqtt_password,x),a
6109  0176 0c17          	inc	(OFST+0,sp)
6111  0178               L1622:
6114  0178 7b17          	ld	a,(OFST+0,sp)
6115  017a 1119          	cp	a,(OFST+2,sp)
6116  017c 25e4          	jrult	L5522
6117  017e               L5322:
6118                     ; 4025 }
6121  017e 5b19          	addw	sp,#25
6122  0180 81            	ret	
6196                     	switch	.const
6197  1b84               L403:
6198  1b84 00de          	dc.w	L5622
6199  1b86 00e5          	dc.w	L7622
6200  1b88 00ec          	dc.w	L1722
6201  1b8a 00f3          	dc.w	L3722
6202  1b8c 00fa          	dc.w	L5722
6203  1b8e 0101          	dc.w	L7722
6204  1b90 0108          	dc.w	L1032
6205  1b92 010f          	dc.w	L3032
6206  1b94 0116          	dc.w	L5032
6207  1b96 011d          	dc.w	L7032
6208  1b98 0124          	dc.w	L1132
6209  1b9a 012b          	dc.w	L3132
6210  1b9c 0132          	dc.w	L5132
6211  1b9e 0139          	dc.w	L7132
6212  1ba0 0140          	dc.w	L1232
6213  1ba2 0147          	dc.w	L3232
6214                     ; 4028 void parse_POST_address(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6214                     ; 4029 {
6215                     .text:	section	.text,new
6216  0000               _parse_POST_address:
6218  0000 89            	pushw	x
6219  0001 89            	pushw	x
6220       00000002      OFST:	set	2
6223                     ; 4032   alpha[0] = '-';
6225  0002 352d0004      	mov	_alpha,#45
6226                     ; 4033   alpha[1] = '-';
6228  0006 352d0005      	mov	_alpha+1,#45
6229                     ; 4034   alpha[2] = '-';
6231  000a 352d0006      	mov	_alpha+2,#45
6232                     ; 4037   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6234  000e 9e            	ld	a,xh
6235  000f c10012        	cp	a,_saved_postpartial_previous
6236  0012 2624          	jrne	L3532
6237                     ; 4040     saved_postpartial_previous[0] = '\0';
6239  0014 725f0012      	clr	_saved_postpartial_previous
6240                     ; 4047     if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
6242  0018 c60016        	ld	a,_saved_postpartial_previous+4
6243  001b 2705          	jreq	L5532
6246  001d 5500160004    	mov	_alpha,_saved_postpartial_previous+4
6247  0022               L5532:
6248                     ; 4048     if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
6250  0022 c60017        	ld	a,_saved_postpartial_previous+5
6251  0025 2705          	jreq	L7532
6254  0027 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
6255  002c               L7532:
6256                     ; 4049     if (saved_postpartial_previous[6] != '\0') alpha[2] = saved_postpartial_previous[6];
6258  002c c60018        	ld	a,_saved_postpartial_previous+6
6259  002f 270a          	jreq	L3632
6262  0031 5500180006    	mov	_alpha+2,_saved_postpartial_previous+6
6263  0036 2003          	jra	L3632
6264  0038               L3532:
6265                     ; 4055     clear_saved_postpartial_data(); // Clear [4] and higher
6267  0038 cd0000        	call	_clear_saved_postpartial_data
6269  003b               L3632:
6270                     ; 4058   for (i=0; i<3; i++) {
6272  003b 4f            	clr	a
6273  003c 6b02          	ld	(OFST+0,sp),a
6275  003e               L5632:
6276                     ; 4064     if (alpha[i] == '-') {
6278  003e 5f            	clrw	x
6279  003f 97            	ld	xl,a
6280  0040 d60004        	ld	a,(_alpha,x)
6281  0043 a12d          	cp	a,#45
6282  0045 263c          	jrne	L3732
6283                     ; 4065       alpha[i] = (uint8_t)(*tmp_pBuffer);
6285  0047 7b02          	ld	a,(OFST+0,sp)
6286  0049 5f            	clrw	x
6287  004a 90ce000e      	ldw	y,_tmp_pBuffer
6288  004e 97            	ld	xl,a
6289  004f 90f6          	ld	a,(y)
6290  0051 d70004        	ld	(_alpha,x),a
6291                     ; 4066       saved_postpartial[i+4] = (uint8_t)(*tmp_pBuffer);
6293  0054 5f            	clrw	x
6294  0055 7b02          	ld	a,(OFST+0,sp)
6295  0057 97            	ld	xl,a
6296  0058 90f6          	ld	a,(y)
6297  005a d7002e        	ld	(_saved_postpartial+4,x),a
6298                     ; 4067       tmp_nParseLeft--;
6300  005d 725a000b      	dec	_tmp_nParseLeft
6301                     ; 4068       saved_nparseleft = tmp_nParseLeft;
6303                     ; 4069       tmp_pBuffer++;
6305  0061 93            	ldw	x,y
6306  0062 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6307  0067 5c            	incw	x
6308  0068 cf000e        	ldw	_tmp_pBuffer,x
6309                     ; 4070       tmp_nBytes--;
6311  006b ce000c        	ldw	x,_tmp_nBytes
6312  006e 5a            	decw	x
6313  006f cf000c        	ldw	_tmp_nBytes,x
6314                     ; 4071       if (i != 2 && tmp_nBytes == 0) {
6316  0072 7b02          	ld	a,(OFST+0,sp)
6317  0074 a102          	cp	a,#2
6318  0076 270b          	jreq	L3732
6320  0078 ce000c        	ldw	x,_tmp_nBytes
6321  007b 2606          	jrne	L3732
6322                     ; 4072         break_while = 1; // Hit end of fragment but still have characters to
6324  007d 3501000a      	mov	_break_while,#1
6325                     ; 4076         break; // Break out of for() loop.
6327  0081 2008          	jra	L1732
6328  0083               L3732:
6329                     ; 4058   for (i=0; i<3; i++) {
6331  0083 0c02          	inc	(OFST+0,sp)
6335  0085 7b02          	ld	a,(OFST+0,sp)
6336  0087 a103          	cp	a,#3
6337  0089 25b3          	jrult	L5632
6338  008b               L1732:
6339                     ; 4080   if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
6341  008b c6000a        	ld	a,_break_while
6342  008e 4a            	dec	a
6343  008f 2603cc0155    	jreq	L603
6346                     ; 4084   clear_saved_postpartial_all();
6348  0094 cd0000        	call	_clear_saved_postpartial_all
6350                     ; 4097     invalid = 0;
6352  0097 0f01          	clr	(OFST-1,sp)
6354                     ; 4099     temp = (uint8_t)(       (alpha[2] - '0'));
6356  0099 c60006        	ld	a,_alpha+2
6357  009c a030          	sub	a,#48
6358  009e 6b02          	ld	(OFST+0,sp),a
6360                     ; 4100     temp = (uint8_t)(temp + (alpha[1] - '0') * 10);
6362  00a0 c60005        	ld	a,_alpha+1
6363  00a3 97            	ld	xl,a
6364  00a4 a60a          	ld	a,#10
6365  00a6 42            	mul	x,a
6366  00a7 9f            	ld	a,xl
6367  00a8 a0e0          	sub	a,#224
6368  00aa 1b02          	add	a,(OFST+0,sp)
6369  00ac 6b02          	ld	(OFST+0,sp),a
6371                     ; 4101     if (temp > 55 && alpha[0] > '1') invalid = 1;
6373  00ae a138          	cp	a,#56
6374  00b0 250d          	jrult	L1042
6376  00b2 c60004        	ld	a,_alpha
6377  00b5 a132          	cp	a,#50
6378  00b7 2506          	jrult	L1042
6381  00b9 a601          	ld	a,#1
6382  00bb 6b01          	ld	(OFST-1,sp),a
6385  00bd 200e          	jra	L3042
6386  00bf               L1042:
6387                     ; 4102     else temp = (uint8_t)(temp + (alpha[0] - '0') * 100);
6389  00bf c60004        	ld	a,_alpha
6390  00c2 97            	ld	xl,a
6391  00c3 a664          	ld	a,#100
6392  00c5 42            	mul	x,a
6393  00c6 9f            	ld	a,xl
6394  00c7 a0c0          	sub	a,#192
6395  00c9 1b02          	add	a,(OFST+0,sp)
6396  00cb 6b02          	ld	(OFST+0,sp),a
6398  00cd               L3042:
6399                     ; 4103     if (invalid == 0) { // Make change only if valid entry
6401  00cd 7b01          	ld	a,(OFST-1,sp)
6402  00cf 267b          	jrne	L5042
6403                     ; 4104       switch(curr_ParseNum)
6405  00d1 7b04          	ld	a,(OFST+2,sp)
6407                     ; 4127         default: break;
6408  00d3 a110          	cp	a,#16
6409  00d5 2475          	jruge	L5042
6410  00d7 5f            	clrw	x
6411  00d8 97            	ld	xl,a
6412  00d9 58            	sllw	x
6413  00da de1b84        	ldw	x,(L403,x)
6414  00dd fc            	jp	(x)
6415  00de               L5622:
6416                     ; 4106         case 0:  Pending_hostaddr[3] = (uint8_t)temp; break;
6418  00de 7b02          	ld	a,(OFST+0,sp)
6419  00e0 c70003        	ld	_Pending_hostaddr+3,a
6422  00e3 2067          	jra	L5042
6423  00e5               L7622:
6424                     ; 4107         case 1:  Pending_hostaddr[2] = (uint8_t)temp; break;
6426  00e5 7b02          	ld	a,(OFST+0,sp)
6427  00e7 c70002        	ld	_Pending_hostaddr+2,a
6430  00ea 2060          	jra	L5042
6431  00ec               L1722:
6432                     ; 4108         case 2:  Pending_hostaddr[1] = (uint8_t)temp; break;
6434  00ec 7b02          	ld	a,(OFST+0,sp)
6435  00ee c70001        	ld	_Pending_hostaddr+1,a
6438  00f1 2059          	jra	L5042
6439  00f3               L3722:
6440                     ; 4109         case 3:  Pending_hostaddr[0] = (uint8_t)temp; break;
6442  00f3 7b02          	ld	a,(OFST+0,sp)
6443  00f5 c70000        	ld	_Pending_hostaddr,a
6446  00f8 2052          	jra	L5042
6447  00fa               L5722:
6448                     ; 4110         case 4:  Pending_draddr[3] = (uint8_t)temp; break;
6450  00fa 7b02          	ld	a,(OFST+0,sp)
6451  00fc c70003        	ld	_Pending_draddr+3,a
6454  00ff 204b          	jra	L5042
6455  0101               L7722:
6456                     ; 4111         case 5:  Pending_draddr[2] = (uint8_t)temp; break;
6458  0101 7b02          	ld	a,(OFST+0,sp)
6459  0103 c70002        	ld	_Pending_draddr+2,a
6462  0106 2044          	jra	L5042
6463  0108               L1032:
6464                     ; 4112         case 6:  Pending_draddr[1] = (uint8_t)temp; break;
6466  0108 7b02          	ld	a,(OFST+0,sp)
6467  010a c70001        	ld	_Pending_draddr+1,a
6470  010d 203d          	jra	L5042
6471  010f               L3032:
6472                     ; 4113         case 7:  Pending_draddr[0] = (uint8_t)temp; break;
6474  010f 7b02          	ld	a,(OFST+0,sp)
6475  0111 c70000        	ld	_Pending_draddr,a
6478  0114 2036          	jra	L5042
6479  0116               L5032:
6480                     ; 4114         case 8:  Pending_netmask[3] = (uint8_t)temp; break;
6482  0116 7b02          	ld	a,(OFST+0,sp)
6483  0118 c70003        	ld	_Pending_netmask+3,a
6486  011b 202f          	jra	L5042
6487  011d               L7032:
6488                     ; 4115         case 9:  Pending_netmask[2] = (uint8_t)temp; break;
6490  011d 7b02          	ld	a,(OFST+0,sp)
6491  011f c70002        	ld	_Pending_netmask+2,a
6494  0122 2028          	jra	L5042
6495  0124               L1132:
6496                     ; 4116         case 10: Pending_netmask[1] = (uint8_t)temp; break;
6498  0124 7b02          	ld	a,(OFST+0,sp)
6499  0126 c70001        	ld	_Pending_netmask+1,a
6502  0129 2021          	jra	L5042
6503  012b               L3132:
6504                     ; 4117         case 11: Pending_netmask[0] = (uint8_t)temp; break;
6506  012b 7b02          	ld	a,(OFST+0,sp)
6507  012d c70000        	ld	_Pending_netmask,a
6510  0130 201a          	jra	L5042
6511  0132               L5132:
6512                     ; 4120 	  Pending_mqttserveraddr[3] = (uint8_t)temp;
6514  0132 7b02          	ld	a,(OFST+0,sp)
6515  0134 c70003        	ld	_Pending_mqttserveraddr+3,a
6516                     ; 4121 	  break;
6518  0137 2013          	jra	L5042
6519  0139               L7132:
6520                     ; 4123         case 13: Pending_mqttserveraddr[2] = (uint8_t)temp; break;
6522  0139 7b02          	ld	a,(OFST+0,sp)
6523  013b c70002        	ld	_Pending_mqttserveraddr+2,a
6526  013e 200c          	jra	L5042
6527  0140               L1232:
6528                     ; 4124         case 14: Pending_mqttserveraddr[1] = (uint8_t)temp; break;
6530  0140 7b02          	ld	a,(OFST+0,sp)
6531  0142 c70001        	ld	_Pending_mqttserveraddr+1,a
6534  0145 2005          	jra	L5042
6535  0147               L3232:
6536                     ; 4125         case 15: Pending_mqttserveraddr[0] = (uint8_t)temp; break;
6538  0147 7b02          	ld	a,(OFST+0,sp)
6539  0149 c70000        	ld	_Pending_mqttserveraddr,a
6542                     ; 4127         default: break;
6544  014c               L5042:
6545                     ; 4132   if (tmp_nBytes == 0) {
6547  014c ce000c        	ldw	x,_tmp_nBytes
6548  014f 2604          	jrne	L603
6549                     ; 4135     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
6551  0151 3502000a      	mov	_break_while,#2
6552                     ; 4138     return;
6553  0155               L603:
6556  0155 5b04          	addw	sp,#4
6557  0157 81            	ret	
6558                     ; 4140 }
6638                     ; 4143 void parse_POST_port(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6638                     ; 4144 {
6639                     .text:	section	.text,new
6640  0000               _parse_POST_port:
6642  0000 89            	pushw	x
6643  0001 5203          	subw	sp,#3
6644       00000003      OFST:	set	3
6647                     ; 4147   for (i=0; i<5; i++) alpha[i] = '-';
6649  0003 4f            	clr	a
6650  0004 6b03          	ld	(OFST+0,sp),a
6652  0006               L3442:
6655  0006 5f            	clrw	x
6656  0007 97            	ld	xl,a
6657  0008 a62d          	ld	a,#45
6658  000a d70004        	ld	(_alpha,x),a
6661  000d 0c03          	inc	(OFST+0,sp)
6665  000f 7b03          	ld	a,(OFST+0,sp)
6666  0011 a105          	cp	a,#5
6667  0013 25f1          	jrult	L3442
6668                     ; 4149   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6670  0015 c60012        	ld	a,_saved_postpartial_previous
6671  0018 1104          	cp	a,(OFST+1,sp)
6672  001a 2621          	jrne	L1542
6673                     ; 4152     saved_postpartial_previous[0] = '\0';
6675  001c 725f0012      	clr	_saved_postpartial_previous
6676                     ; 4159     for (i=0; i<5; i++) {
6678  0020 4f            	clr	a
6679  0021 6b03          	ld	(OFST+0,sp),a
6681  0023               L3542:
6682                     ; 4160       if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
6684  0023 5f            	clrw	x
6685  0024 97            	ld	xl,a
6686  0025 724d0016      	tnz	(_saved_postpartial_previous+4,x)
6687  0029 2708          	jreq	L1642
6690  002b 5f            	clrw	x
6691  002c 97            	ld	xl,a
6692  002d d60016        	ld	a,(_saved_postpartial_previous+4,x)
6693  0030 d70004        	ld	(_alpha,x),a
6694  0033               L1642:
6695                     ; 4159     for (i=0; i<5; i++) {
6697  0033 0c03          	inc	(OFST+0,sp)
6701  0035 7b03          	ld	a,(OFST+0,sp)
6702  0037 a105          	cp	a,#5
6703  0039 25e8          	jrult	L3542
6705  003b 2003          	jra	L3642
6706  003d               L1542:
6707                     ; 4167     clear_saved_postpartial_data(); // Clear [4] and higher
6709  003d cd0000        	call	_clear_saved_postpartial_data
6711  0040               L3642:
6712                     ; 4172     for (i=0; i<5; i++) {
6714  0040 4f            	clr	a
6715  0041 6b03          	ld	(OFST+0,sp),a
6717  0043               L5642:
6718                     ; 4178       if (alpha[i] == '-') {
6720  0043 5f            	clrw	x
6721  0044 97            	ld	xl,a
6722  0045 d60004        	ld	a,(_alpha,x)
6723  0048 a12d          	cp	a,#45
6724  004a 263c          	jrne	L3742
6725                     ; 4179         alpha[i] = (uint8_t)(*tmp_pBuffer);
6727  004c 7b03          	ld	a,(OFST+0,sp)
6728  004e 5f            	clrw	x
6729  004f 90ce000e      	ldw	y,_tmp_pBuffer
6730  0053 97            	ld	xl,a
6731  0054 90f6          	ld	a,(y)
6732  0056 d70004        	ld	(_alpha,x),a
6733                     ; 4180         saved_postpartial[i+4] = *tmp_pBuffer;
6735  0059 5f            	clrw	x
6736  005a 7b03          	ld	a,(OFST+0,sp)
6737  005c 97            	ld	xl,a
6738  005d 90f6          	ld	a,(y)
6739  005f d7002e        	ld	(_saved_postpartial+4,x),a
6740                     ; 4181         tmp_nParseLeft--;
6742  0062 725a000b      	dec	_tmp_nParseLeft
6743                     ; 4182         saved_nparseleft = tmp_nParseLeft;
6745                     ; 4183         tmp_pBuffer++;
6747  0066 93            	ldw	x,y
6748  0067 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6749  006c 5c            	incw	x
6750  006d cf000e        	ldw	_tmp_pBuffer,x
6751                     ; 4184         tmp_nBytes--;
6753  0070 ce000c        	ldw	x,_tmp_nBytes
6754  0073 5a            	decw	x
6755  0074 cf000c        	ldw	_tmp_nBytes,x
6756                     ; 4185         if (i != 4 && tmp_nBytes == 0) {
6758  0077 7b03          	ld	a,(OFST+0,sp)
6759  0079 a104          	cp	a,#4
6760  007b 270b          	jreq	L3742
6762  007d ce000c        	ldw	x,_tmp_nBytes
6763  0080 2606          	jrne	L3742
6764                     ; 4186           break_while = 1; // Hit end of fragment but still have characters to
6766  0082 3501000a      	mov	_break_while,#1
6767                     ; 4190    	break; // Break out of for() loop.
6769  0086 2008          	jra	L1742
6770  0088               L3742:
6771                     ; 4172     for (i=0; i<5; i++) {
6773  0088 0c03          	inc	(OFST+0,sp)
6777  008a 7b03          	ld	a,(OFST+0,sp)
6778  008c a105          	cp	a,#5
6779  008e 25b3          	jrult	L5642
6780  0090               L1742:
6781                     ; 4194     if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
6783  0090 c6000a        	ld	a,_break_while
6784  0093 4a            	dec	a
6785  0094 2603cc0122    	jreq	L613
6788                     ; 4199   clear_saved_postpartial_all();
6790  0099 cd0000        	call	_clear_saved_postpartial_all
6792                     ; 4208     invalid = 0;
6794  009c 0f03          	clr	(OFST+0,sp)
6796                     ; 4210     temp = (uint16_t)(       (alpha[4] - '0'));
6798  009e 5f            	clrw	x
6799  009f c60008        	ld	a,_alpha+4
6800  00a2 97            	ld	xl,a
6801  00a3 1d0030        	subw	x,#48
6802  00a6 1f01          	ldw	(OFST-2,sp),x
6804                     ; 4211     temp = (uint16_t)(temp + (alpha[3] - '0') * 10);
6806  00a8 c60007        	ld	a,_alpha+3
6807  00ab 97            	ld	xl,a
6808  00ac a60a          	ld	a,#10
6809  00ae 42            	mul	x,a
6810  00af 1d01e0        	subw	x,#480
6811  00b2 72fb01        	addw	x,(OFST-2,sp)
6812  00b5 1f01          	ldw	(OFST-2,sp),x
6814                     ; 4212     temp = (uint16_t)(temp + (alpha[2] - '0') * 100);
6816  00b7 c60006        	ld	a,_alpha+2
6817  00ba 97            	ld	xl,a
6818  00bb a664          	ld	a,#100
6819  00bd 42            	mul	x,a
6820  00be 1d12c0        	subw	x,#4800
6821  00c1 72fb01        	addw	x,(OFST-2,sp)
6822  00c4 1f01          	ldw	(OFST-2,sp),x
6824                     ; 4213     temp = (uint16_t)(temp + (alpha[1] - '0') * 1000);
6826  00c6 5f            	clrw	x
6827  00c7 c60005        	ld	a,_alpha+1
6828  00ca 97            	ld	xl,a
6829  00cb 90ae03e8      	ldw	y,#1000
6830  00cf cd0000        	call	c_imul
6832  00d2 1dbb80        	subw	x,#48000
6833  00d5 72fb01        	addw	x,(OFST-2,sp)
6834  00d8 1f01          	ldw	(OFST-2,sp),x
6836                     ; 4214     if (temp > 5535 && alpha[0] > '5') invalid = 1;
6838  00da a315a0        	cpw	x,#5536
6839  00dd 250d          	jrult	L1052
6841  00df c60004        	ld	a,_alpha
6842  00e2 a136          	cp	a,#54
6843  00e4 2506          	jrult	L1052
6846  00e6 a601          	ld	a,#1
6847  00e8 6b03          	ld	(OFST+0,sp),a
6850  00ea 2014          	jra	L3052
6851  00ec               L1052:
6852                     ; 4215     else temp = (uint16_t)(temp + (alpha[0] - '0') * 10000);
6854  00ec c60004        	ld	a,_alpha
6855  00ef 5f            	clrw	x
6856  00f0 97            	ld	xl,a
6857  00f1 90ae2710      	ldw	y,#10000
6858  00f5 cd0000        	call	c_imul
6860  00f8 1d5300        	subw	x,#21248
6861  00fb 72fb01        	addw	x,(OFST-2,sp)
6862  00fe 1f01          	ldw	(OFST-2,sp),x
6864  0100               L3052:
6865                     ; 4216     if (temp < 10) invalid = 1;
6867  0100 a3000a        	cpw	x,#10
6868  0103 2404          	jruge	L5052
6871  0105 a601          	ld	a,#1
6872  0107 6b03          	ld	(OFST+0,sp),a
6874  0109               L5052:
6875                     ; 4217     if (invalid == 0) {
6877  0109 7b03          	ld	a,(OFST+0,sp)
6878  010b 260c          	jrne	L7052
6879                     ; 4218       if (curr_ParseNum == 0) Pending_port = (uint16_t)temp;
6881  010d 7b05          	ld	a,(OFST+2,sp)
6882  010f 2605          	jrne	L1152
6885  0111 cf0000        	ldw	_Pending_port,x
6887  0114 2003          	jra	L7052
6888  0116               L1152:
6889                     ; 4220       else Pending_mqttport = (uint16_t)temp;
6891  0116 cf0000        	ldw	_Pending_mqttport,x
6892  0119               L7052:
6893                     ; 4225   if (tmp_nBytes == 0) {
6895  0119 ce000c        	ldw	x,_tmp_nBytes
6896  011c 2604          	jrne	L613
6897                     ; 4228     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
6899  011e 3502000a      	mov	_break_while,#2
6900                     ; 4231     return;
6901  0122               L613:
6904  0122 5b05          	addw	sp,#5
6905  0124 81            	ret	
6906                     ; 4233 }
6941                     	switch	.const
6942  1ba4               L423:
6943  1ba4 000e          	dc.w	L7152
6944  1ba6 0016          	dc.w	L1252
6945  1ba8 001e          	dc.w	L3252
6946  1baa 0026          	dc.w	L5252
6947  1bac 002e          	dc.w	L7252
6948  1bae 0036          	dc.w	L1352
6949  1bb0 003e          	dc.w	L3352
6950  1bb2 0046          	dc.w	L5352
6951  1bb4 004e          	dc.w	L7352
6952  1bb6 0056          	dc.w	L1452
6953  1bb8 005e          	dc.w	L3452
6954  1bba 0066          	dc.w	L5452
6955  1bbc 006e          	dc.w	L7452
6956  1bbe 0076          	dc.w	L1552
6957  1bc0 007e          	dc.w	L3552
6958  1bc2 0086          	dc.w	L5552
6959                     ; 4236 uint8_t GpioGetPin(uint8_t nGpio)
6959                     ; 4237 {
6960                     .text:	section	.text,new
6961  0000               _GpioGetPin:
6965                     ; 4242   switch (nGpio) {
6968                     ; 4258     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
6969  0000 a110          	cp	a,#16
6970  0002 2503cc008e    	jruge	L5752
6971  0007 5f            	clrw	x
6972  0008 97            	ld	xl,a
6973  0009 58            	sllw	x
6974  000a de1ba4        	ldw	x,(L423,x)
6975  000d fc            	jp	(x)
6976  000e               L7152:
6977                     ; 4243     case 0:  if (IO_8to1  & (uint8_t)(0x01)) return 1; break;
6979  000e 720100007b    	btjf	_IO_8to1,#0,L5752
6982  0013 a601          	ld	a,#1
6985  0015 81            	ret	
6986  0016               L1252:
6987                     ; 4244     case 1:  if (IO_8to1  & (uint8_t)(0x02)) return 1; break;
6989  0016 7203000073    	btjf	_IO_8to1,#1,L5752
6992  001b a601          	ld	a,#1
6995  001d 81            	ret	
6996  001e               L3252:
6997                     ; 4245     case 2:  if (IO_8to1  & (uint8_t)(0x04)) return 1; break;
6999  001e 720500006b    	btjf	_IO_8to1,#2,L5752
7002  0023 a601          	ld	a,#1
7005  0025 81            	ret	
7006  0026               L5252:
7007                     ; 4246     case 3:  if (IO_8to1  & (uint8_t)(0x08)) return 1; break;
7009  0026 7207000063    	btjf	_IO_8to1,#3,L5752
7012  002b a601          	ld	a,#1
7015  002d 81            	ret	
7016  002e               L7252:
7017                     ; 4247     case 4:  if (IO_8to1  & (uint8_t)(0x10)) return 1; break;
7019  002e 720900005b    	btjf	_IO_8to1,#4,L5752
7022  0033 a601          	ld	a,#1
7025  0035 81            	ret	
7026  0036               L1352:
7027                     ; 4248     case 5:  if (IO_8to1  & (uint8_t)(0x20)) return 1; break;
7029  0036 720b000053    	btjf	_IO_8to1,#5,L5752
7032  003b a601          	ld	a,#1
7035  003d 81            	ret	
7036  003e               L3352:
7037                     ; 4249     case 6:  if (IO_8to1  & (uint8_t)(0x40)) return 1; break;
7039  003e 720d00004b    	btjf	_IO_8to1,#6,L5752
7042  0043 a601          	ld	a,#1
7045  0045 81            	ret	
7046  0046               L5352:
7047                     ; 4250     case 7:  if (IO_8to1  & (uint8_t)(0x80)) return 1; break;
7049  0046 720f000043    	btjf	_IO_8to1,#7,L5752
7052  004b a601          	ld	a,#1
7055  004d 81            	ret	
7056  004e               L7352:
7057                     ; 4251     case 8:  if (IO_16to9 & (uint8_t)(0x01)) return 1; break;
7059  004e 720100003b    	btjf	_IO_16to9,#0,L5752
7062  0053 a601          	ld	a,#1
7065  0055 81            	ret	
7066  0056               L1452:
7067                     ; 4252     case 9:  if (IO_16to9 & (uint8_t)(0x02)) return 1; break;
7069  0056 7203000033    	btjf	_IO_16to9,#1,L5752
7072  005b a601          	ld	a,#1
7075  005d 81            	ret	
7076  005e               L3452:
7077                     ; 4253     case 10: if (IO_16to9 & (uint8_t)(0x04)) return 1; break;
7079  005e 720500002b    	btjf	_IO_16to9,#2,L5752
7082  0063 a601          	ld	a,#1
7085  0065 81            	ret	
7086  0066               L5452:
7087                     ; 4254     case 11: if (IO_16to9 & (uint8_t)(0x08)) return 1; break;
7089  0066 7207000023    	btjf	_IO_16to9,#3,L5752
7092  006b a601          	ld	a,#1
7095  006d 81            	ret	
7096  006e               L7452:
7097                     ; 4255     case 12: if (IO_16to9 & (uint8_t)(0x10)) return 1; break;
7099  006e 720900001b    	btjf	_IO_16to9,#4,L5752
7102  0073 a601          	ld	a,#1
7105  0075 81            	ret	
7106  0076               L1552:
7107                     ; 4256     case 13: if (IO_16to9 & (uint8_t)(0x20)) return 1; break;
7109  0076 720b000013    	btjf	_IO_16to9,#5,L5752
7112  007b a601          	ld	a,#1
7115  007d 81            	ret	
7116  007e               L3552:
7117                     ; 4257     case 14: if (IO_16to9 & (uint8_t)(0x40)) return 1; break;
7119  007e 720d00000b    	btjf	_IO_16to9,#6,L5752
7122  0083 a601          	ld	a,#1
7125  0085 81            	ret	
7126  0086               L5552:
7127                     ; 4258     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7129  0086 720f000003    	btjf	_IO_16to9,#7,L5752
7132  008b a601          	ld	a,#1
7135  008d 81            	ret	
7136  008e               L5752:
7137                     ; 4260   return 0;
7139  008e 4f            	clr	a
7142  008f 81            	ret	
7189                     ; 4309 void GpioSetPin(uint8_t nGpio, uint8_t nState)
7189                     ; 4310 {
7190                     .text:	section	.text,new
7191  0000               _GpioSetPin:
7193  0000 89            	pushw	x
7194  0001 88            	push	a
7195       00000001      OFST:	set	1
7198                     ; 4317   mask = 0;
7200  0002 0f01          	clr	(OFST+0,sp)
7202                     ; 4319   switch(nGpio) {
7204  0004 9e            	ld	a,xh
7206                     ; 4328     default: break;
7207  0005 4d            	tnz	a
7208  0006 2717          	jreq	L7362
7209  0008 4a            	dec	a
7210  0009 2717          	jreq	L1462
7211  000b 4a            	dec	a
7212  000c 2718          	jreq	L3462
7213  000e 4a            	dec	a
7214  000f 2719          	jreq	L5462
7215  0011 4a            	dec	a
7216  0012 271a          	jreq	L7462
7217  0014 4a            	dec	a
7218  0015 271b          	jreq	L1562
7219  0017 4a            	dec	a
7220  0018 271c          	jreq	L3562
7221  001a 4a            	dec	a
7222  001b 271d          	jreq	L5562
7223  001d 201f          	jra	L3072
7224  001f               L7362:
7225                     ; 4320     case 0: mask = 0x01; break;
7227  001f 4c            	inc	a
7230  0020 201a          	jp	LC022
7231  0022               L1462:
7232                     ; 4321     case 1: mask = 0x02; break;
7234  0022 a602          	ld	a,#2
7237  0024 2016          	jp	LC022
7238  0026               L3462:
7239                     ; 4322     case 2: mask = 0x04; break;
7241  0026 a604          	ld	a,#4
7244  0028 2012          	jp	LC022
7245  002a               L5462:
7246                     ; 4323     case 3: mask = 0x08; break;
7248  002a a608          	ld	a,#8
7251  002c 200e          	jp	LC022
7252  002e               L7462:
7253                     ; 4324     case 4: mask = 0x10; break;
7255  002e a610          	ld	a,#16
7258  0030 200a          	jp	LC022
7259  0032               L1562:
7260                     ; 4325     case 5: mask = 0x20; break;
7262  0032 a620          	ld	a,#32
7265  0034 2006          	jp	LC022
7266  0036               L3562:
7267                     ; 4326     case 6: mask = 0x40; break;
7269  0036 a640          	ld	a,#64
7272  0038 2002          	jp	LC022
7273  003a               L5562:
7274                     ; 4327     case 7: mask = 0x80; break;
7276  003a a680          	ld	a,#128
7277  003c               LC022:
7278  003c 6b01          	ld	(OFST+0,sp),a
7282                     ; 4328     default: break;
7284  003e               L3072:
7285                     ; 4331   if (nState) IO_8to1 |= mask;
7287  003e 7b03          	ld	a,(OFST+2,sp)
7288  0040 2707          	jreq	L5072
7291  0042 c60000        	ld	a,_IO_8to1
7292  0045 1a01          	or	a,(OFST+0,sp)
7294  0047 2006          	jra	L7072
7295  0049               L5072:
7296                     ; 4332   else IO_8to1 &= (uint8_t)~mask;
7298  0049 7b01          	ld	a,(OFST+0,sp)
7299  004b 43            	cpl	a
7300  004c c40000        	and	a,_IO_8to1
7301  004f               L7072:
7302  004f c70000        	ld	_IO_8to1,a
7303                     ; 4334 }
7306  0052 5b03          	addw	sp,#3
7307  0054 81            	ret	
7368                     ; 4346 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7368                     ; 4347 {
7369                     .text:	section	.text,new
7370  0000               _SetMAC:
7372  0000 89            	pushw	x
7373  0001 5203          	subw	sp,#3
7374       00000003      OFST:	set	3
7377                     ; 4361   temp = 0;
7379                     ; 4362   invalid = 0;
7381  0003 0f01          	clr	(OFST-2,sp)
7383                     ; 4365   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7385  0005 9f            	ld	a,xl
7386  0006 a130          	cp	a,#48
7387  0008 250b          	jrult	L3572
7389  000a 9f            	ld	a,xl
7390  000b a13a          	cp	a,#58
7391  000d 2406          	jruge	L3572
7394  000f 7b05          	ld	a,(OFST+2,sp)
7395  0011 a030          	sub	a,#48
7397  0013 200c          	jp	LC023
7398  0015               L3572:
7399                     ; 4366   else if (alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7401  0015 7b05          	ld	a,(OFST+2,sp)
7402  0017 a161          	cp	a,#97
7403  0019 250a          	jrult	L7572
7405  001b a167          	cp	a,#103
7406  001d 2406          	jruge	L7572
7409  001f a057          	sub	a,#87
7410  0021               LC023:
7411  0021 6b05          	ld	(OFST+2,sp),a
7413  0023 2004          	jra	L5572
7414  0025               L7572:
7415                     ; 4367   else invalid = 1; // If an invalid entry set indicator
7417  0025 a601          	ld	a,#1
7418  0027 6b01          	ld	(OFST-2,sp),a
7420  0029               L5572:
7421                     ; 4369   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7423  0029 7b08          	ld	a,(OFST+5,sp)
7424  002b a130          	cp	a,#48
7425  002d 2508          	jrult	L3672
7427  002f a13a          	cp	a,#58
7428  0031 2404          	jruge	L3672
7431  0033 a030          	sub	a,#48
7433  0035 200a          	jp	LC024
7434  0037               L3672:
7435                     ; 4370   else if (alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7437  0037 a161          	cp	a,#97
7438  0039 250a          	jrult	L7672
7440  003b a167          	cp	a,#103
7441  003d 2406          	jruge	L7672
7444  003f a057          	sub	a,#87
7445  0041               LC024:
7446  0041 6b08          	ld	(OFST+5,sp),a
7448  0043 2004          	jra	L5672
7449  0045               L7672:
7450                     ; 4371   else invalid = 1; // If an invalid entry set indicator
7452  0045 a601          	ld	a,#1
7453  0047 6b01          	ld	(OFST-2,sp),a
7455  0049               L5672:
7456                     ; 4373   if (invalid == 0) { // Change value only if valid entry
7458  0049 7b01          	ld	a,(OFST-2,sp)
7459  004b 264a          	jrne	L3772
7460                     ; 4374     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7462  004d 7b05          	ld	a,(OFST+2,sp)
7463  004f 97            	ld	xl,a
7464  0050 a610          	ld	a,#16
7465  0052 42            	mul	x,a
7466  0053 01            	rrwa	x,a
7467  0054 1b08          	add	a,(OFST+5,sp)
7468  0056 5f            	clrw	x
7469  0057 97            	ld	xl,a
7470  0058 1f02          	ldw	(OFST-1,sp),x
7472                     ; 4375     switch(itemnum)
7474  005a 7b04          	ld	a,(OFST+1,sp)
7476                     ; 4383     default: break;
7477  005c 2711          	jreq	L1172
7478  005e 4a            	dec	a
7479  005f 2715          	jreq	L3172
7480  0061 4a            	dec	a
7481  0062 2719          	jreq	L5172
7482  0064 4a            	dec	a
7483  0065 271d          	jreq	L7172
7484  0067 4a            	dec	a
7485  0068 2721          	jreq	L1272
7486  006a 4a            	dec	a
7487  006b 2725          	jreq	L3272
7488  006d 2028          	jra	L3772
7489  006f               L1172:
7490                     ; 4377     case 0: Pending_uip_ethaddr_oct[5] = (uint8_t)temp; break;
7492  006f 7b03          	ld	a,(OFST+0,sp)
7493  0071 c70005        	ld	_Pending_uip_ethaddr_oct+5,a
7496  0074 2021          	jra	L3772
7497  0076               L3172:
7498                     ; 4378     case 1: Pending_uip_ethaddr_oct[4] = (uint8_t)temp; break;
7500  0076 7b03          	ld	a,(OFST+0,sp)
7501  0078 c70004        	ld	_Pending_uip_ethaddr_oct+4,a
7504  007b 201a          	jra	L3772
7505  007d               L5172:
7506                     ; 4379     case 2: Pending_uip_ethaddr_oct[3] = (uint8_t)temp; break;
7508  007d 7b03          	ld	a,(OFST+0,sp)
7509  007f c70003        	ld	_Pending_uip_ethaddr_oct+3,a
7512  0082 2013          	jra	L3772
7513  0084               L7172:
7514                     ; 4380     case 3: Pending_uip_ethaddr_oct[2] = (uint8_t)temp; break;
7516  0084 7b03          	ld	a,(OFST+0,sp)
7517  0086 c70002        	ld	_Pending_uip_ethaddr_oct+2,a
7520  0089 200c          	jra	L3772
7521  008b               L1272:
7522                     ; 4381     case 4: Pending_uip_ethaddr_oct[1] = (uint8_t)temp; break;
7524  008b 7b03          	ld	a,(OFST+0,sp)
7525  008d c70001        	ld	_Pending_uip_ethaddr_oct+1,a
7528  0090 2005          	jra	L3772
7529  0092               L3272:
7530                     ; 4382     case 5: Pending_uip_ethaddr_oct[0] = (uint8_t)temp; break;
7532  0092 7b03          	ld	a,(OFST+0,sp)
7533  0094 c70000        	ld	_Pending_uip_ethaddr_oct,a
7536                     ; 4383     default: break;
7538  0097               L3772:
7539                     ; 4386 }
7542  0097 5b05          	addw	sp,#5
7543  0099 81            	ret	
7927                     	switch	.bss
7928  0000               _insertion_flag:
7929  0000 000000        	ds.b	3
7930                     	xdef	_insertion_flag
7931                     	xref	_MQTT_error_status
7932                     	xref	_mqtt_start_status
7933                     	xref	_Pending_mqtt_password
7934                     	xref	_Pending_mqtt_username
7935                     	xref	_Pending_mqttport
7936                     	xref	_Pending_mqttserveraddr
7937                     	xref	_stored_mqtt_password
7938                     	xref	_stored_mqtt_username
7939                     	xref	_stored_mqttport
7940                     	xref	_stored_mqttserveraddr
7941  0003               _current_webpage:
7942  0003 00            	ds.b	1
7943                     	xdef	_current_webpage
7944  0004               _alpha:
7945  0004 000000000000  	ds.b	6
7946                     	xdef	_alpha
7947  000a               _break_while:
7948  000a 00            	ds.b	1
7949                     	xdef	_break_while
7950  000b               _tmp_nParseLeft:
7951  000b 00            	ds.b	1
7952                     	xdef	_tmp_nParseLeft
7953  000c               _tmp_nBytes:
7954  000c 0000          	ds.b	2
7955                     	xdef	_tmp_nBytes
7956  000e               _tmp_pBuffer:
7957  000e 0000          	ds.b	2
7958                     	xdef	_tmp_pBuffer
7959  0010               _z_diag:
7960  0010 00            	ds.b	1
7961                     	xdef	_z_diag
7962  0011               _saved_newlines:
7963  0011 00            	ds.b	1
7964                     	xdef	_saved_newlines
7965  0012               _saved_postpartial_previous:
7966  0012 000000000000  	ds.b	24
7967                     	xdef	_saved_postpartial_previous
7968  002a               _saved_postpartial:
7969  002a 000000000000  	ds.b	24
7970                     	xdef	_saved_postpartial
7971  0042               _saved_nparseleft:
7972  0042 00            	ds.b	1
7973                     	xdef	_saved_nparseleft
7974  0043               _saved_parsestate:
7975  0043 00            	ds.b	1
7976                     	xdef	_saved_parsestate
7977  0044               _saved_nstate:
7978  0044 00            	ds.b	1
7979                     	xdef	_saved_nstate
7980  0045               _OctetArray:
7981  0045 000000000000  	ds.b	11
7982                     	xdef	_OctetArray
7983                     	xref	_user_reboot_request
7984                     	xref	_parse_complete
7985                     	xref	_mac_string
7986                     	xref	_stored_config_settings
7987                     	xref	_stored_devicename
7988                     	xref	_stored_port
7989                     	xref	_stored_netmask
7990                     	xref	_stored_draddr
7991                     	xref	_stored_hostaddr
7992                     	xref	_Pending_uip_ethaddr_oct
7993                     	xref	_Pending_config_settings
7994                     	xref	_Pending_devicename
7995                     	xref	_Pending_port
7996                     	xref	_Pending_netmask
7997                     	xref	_Pending_draddr
7998                     	xref	_Pending_hostaddr
7999                     	xref	_invert_input
8000                     	xref	_IO_8to1
8001                     	xref	_IO_16to9
8002                     	xref	_Port_Httpd
8003                     	xref	_strlen
8004                     	xref	_debugflash
8005                     	xref	_uip_flags
8006                     	xref	_uip_conn
8007                     	xref	_uip_len
8008                     	xref	_uip_appdata
8009                     	xref	_htons
8010                     	xref	_uip_send
8011                     	xref	_uip_listen
8012                     	xdef	_SetMAC
8013                     	xdef	_clear_saved_postpartial_previous
8014                     	xdef	_clear_saved_postpartial_data
8015                     	xdef	_clear_saved_postpartial_all
8016                     	xdef	_GpioSetPin
8017                     	xdef	_GpioGetPin
8018                     	xdef	_parse_POST_port
8019                     	xdef	_parse_POST_address
8020                     	xdef	_parse_POST_string
8021                     	xdef	_HttpDCall
8022                     	xdef	_HttpDInit
8023                     	xdef	_emb_itoa
8024                     	xdef	_adjust_template_size
8025                     	switch	.const
8026  1bc4               L523:
8027  1bc4 436f6e6e6563  	dc.b	"Connection:close",13
8028  1bd5 0a00          	dc.b	10,0
8029  1bd7               L323:
8030  1bd7 436f6e74656e  	dc.b	"Content-Type: text"
8031  1be9 2f68746d6c3b  	dc.b	"/html; charset=utf"
8032  1bfb 2d380d        	dc.b	"-8",13
8033  1bfe 0a00          	dc.b	10,0
8034  1c00               L123:
8035  1c00 43616368652d  	dc.b	"Cache-Control: no-"
8036  1c12 63616368652c  	dc.b	"cache, no-store",13
8037  1c22 0a00          	dc.b	10,0
8038  1c24               L113:
8039  1c24 436f6e74656e  	dc.b	"Content-Length:",0
8040  1c34               L703:
8041  1c34 0d0a00        	dc.b	13,10,0
8042  1c37               L503:
8043  1c37 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8044                     	xref.b	c_lreg
8045                     	xref.b	c_x
8046                     	xref.b	c_y
8066                     	xref	c_imul
8067                     	xref	c_uitolx
8068                     	xref	c_ludv
8069                     	xref	c_lumd
8070                     	xref	c_rtol
8071                     	xref	c_ltor
8072                     	xref	c_lzmp
8073                     	end
