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
 378  17a6 652052657669  	dc.b	"e Revision 2020112"
 379  17b8 312030343533  	dc.b	"1 0453</p>%y03/91%"
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
 402  1932 2f74723e3c2f  	dc.b	"/tr></table>%y03/6"
 403  1944 3127206d6574  	dc.b	"1' method='GET'><b"
 404  1956 7574746f6e3e  	dc.b	"utton>Configuratio"
 405  1968 6e3c2f        	dc.b	"n</"
 406  196b 627574746f6e  	dc.b	"button></form>%y03"
 407  197d 2f363627206d  	dc.b	"/66' method='GET'>"
 408  198f 3c627574746f  	dc.b	"<button>Refresh</b"
 409  19a1 7574746f6e3e  	dc.b	"utton></form></bod"
 410  19b3 793e3c2f6874  	dc.b	"y></html>",0
 411  19bd               L12_g_HtmlPageRstate:
 412  19bd 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 413  19cf 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 414  19e1 6561643e3c74  	dc.b	"ead><title>Help Pa"
 415  19f3 676520323c2f  	dc.b	"ge 2</title><link "
 416  1a05 72656c3d2769  	dc.b	"rel='icon' href='d"
 417  1a17 6174613a2c27  	dc.b	"ata:,'></head><bod"
 418  1a29 793e3c703e25  	dc.b	"y><p>%f00</p></bod"
 419  1a3b 793e3c2f6874  	dc.b	"y></html>",0
 420  1a45               L32_page_string00:
 421  1a45 706174746572  	dc.b	"pattern='[0-9]{3}'"
 422  1a57 207469746c65  	dc.b	" title='Enter 000 "
 423  1a69 746f20323535  	dc.b	"to 255' maxlength="
 424  1a7b 2733273e3c2f  	dc.b	"'3'></td>",0
 425  1a85               L52_page_string00_len:
 426  1a85 3f            	dc.b	63
 427  1a86               L72_page_string00_len_less4:
 428  1a86 3b            	dc.b	59
 429  1a87               L13_page_string01:
 430  1a87 706174746572  	dc.b	"pattern='[0-9a-f]{"
 431  1a99 327d27207469  	dc.b	"2}' title='Enter 0"
 432  1aab 3020746f2066  	dc.b	"0 to ff' maxlength"
 433  1abd 3d2732273e3c  	dc.b	"='2'></td>",0
 434  1ac8               L33_page_string01_len:
 435  1ac8 40            	dc.b	64
 436  1ac9               L53_page_string01_len_less4:
 437  1ac9 3c            	dc.b	60
 438  1aca               L73_page_string02:
 439  1aca 27206d657468  	dc.b	"' method='GET'><bu"
 440  1adc 74746f6e2074  	dc.b	"tton title='Save f"
 441  1aee 697273742120  	dc.b	"irst! This button "
 442  1b00 77696c6c206e  	dc.b	"will not save your"
 443  1b12 206368616e67  	dc.b	" changes'>",0
 444  1b1d               L14_page_string02_len:
 445  1b1d 52            	dc.b	82
 446  1b1e               L34_page_string02_len_less4:
 447  1b1e 4e            	dc.b	78
 448  1b1f               L54_page_string03:
 449  1b1f 3c666f726d20  	dc.b	"<form style='displ"
 450  1b31 61793a20696e  	dc.b	"ay: inline' action"
 451  1b43 3d2700        	dc.b	"='",0
 452  1b46               L74_page_string03_len:
 453  1b46 26            	dc.b	38
 454  1b47               L15_page_string03_len_less4:
 455  1b47 22            	dc.b	34
 456  1b48               L35_page_string04:
 457  1b48 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 458  1b5a 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 459  1b6c 6561643e3c6c  	dc.b	"ead><link rel='ico"
 460  1b7e 6e2720687265  	dc.b	"n' href='data:,'>",0
 461  1b90               L55_page_string04_len:
 462  1b90 47            	dc.b	71
 463  1b91               L75_page_string04_len_less4:
 464  1b91 43            	dc.b	67
 465  1b92               L16_page_string05:
 466  1b92 3c7374796c65  	dc.b	"<style>.s0 { backg"
 467  1ba4 726f756e642d  	dc.b	"round-color: red; "
 468  1bb6 77696474683a  	dc.b	"width: 30px; }.s1 "
 469  1bc8 7b206261636b  	dc.b	"{ background-color"
 470  1bda 3a2067726565  	dc.b	": green; width: 30"
 471  1bec 70783b207d2e  	dc.b	"px; }.t1 { width: "
 472  1bfe 31323070783b  	dc.b	"120px; }.t2 { widt"
 473  1c10 683a20313438  	dc.b	"h: 148px; }.t3 { w"
 474  1c22 696474683a20  	dc.b	"idth: 30px; }.t5 {"
 475  1c34 207769647468  	dc.b	" width: 60px; }.t6"
 476  1c46 207b20776964  	dc.b	" { width: 25px; }."
 477  1c58 7437207b2077  	dc.b	"t7 { width: 18px; "
 478  1c6a 7d2e7438207b  	dc.b	"}.t8 { width: 40px"
 479  1c7c 3b207d00      	dc.b	"; }",0
 480  1c80               L36_page_string05_len:
 481  1c80 ed            	dc.b	237
 482  1c81               L56_page_string05_len_less4:
 483  1c81 e9            	dc.b	233
 484  1c82               L76_page_string06:
 485  1c82 7464207b2074  	dc.b	"td { text-align: c"
 486  1c94 656e7465723b  	dc.b	"enter; border: 1px"
 487  1ca6 20626c61636b  	dc.b	" black solid; }</s"
 488  1cb8 74796c653e00  	dc.b	"tyle>",0
 489  1cbe               L17_page_string06_len:
 490  1cbe 3b            	dc.b	59
 491  1cbf               L37_page_string06_len_less4:
 492  1cbf 37            	dc.b	55
 547                     ; 1204 uint16_t adjust_template_size()
 547                     ; 1205 {
 549                     .text:	section	.text,new
 550  0000               _adjust_template_size:
 552  0000 89            	pushw	x
 553       00000002      OFST:	set	2
 556                     ; 1223   size = 0;
 558  0001 5f            	clrw	x
 559  0002 1f01          	ldw	(OFST-1,sp),x
 561                     ; 1228   if (current_webpage == WEBPAGE_IOCONTROL) {
 563  0004 c60003        	ld	a,_current_webpage
 564  0007 2613          	jrne	L711
 565                     ; 1229     size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
 567                     ; 1232     size = size + page_string04_len_less4
 567                     ; 1233                 + page_string05_len_less4
 567                     ; 1234 		+ page_string06_len_less4;
 569  0009 ae0d69        	ldw	x,#3433
 570  000c 1f01          	ldw	(OFST-1,sp),x
 572                     ; 1239     size = size + strlen(stored_devicename) - 4 ;
 574  000e ae0000        	ldw	x,#_stored_devicename
 575  0011 cd0000        	call	_strlen
 577  0014 72fb01        	addw	x,(OFST-1,sp)
 578  0017 1c00a4        	addw	x,#164
 580                     ; 1246     size = size - 48;
 583                     ; 1262     size = size - 8;
 586                     ; 1276     size = size + (2 * page_string03_len_less4);
 589                     ; 1305     size = size + (2 * (page_string02_len_less4));
 593  001a 2046          	jra	L121
 594  001c               L711:
 595                     ; 1324   else if (current_webpage == WEBPAGE_CONFIGURATION) {
 597  001c a101          	cp	a,#1
 598  001e 2632          	jrne	L321
 599                     ; 1325     size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
 601                     ; 1328     size = size + page_string04_len_less4
 601                     ; 1329                 + page_string05_len_less4
 601                     ; 1330 		+ page_string06_len_less4;
 603  0020 ae0dbf        	ldw	x,#3519
 604  0023 1f01          	ldw	(OFST-1,sp),x
 606                     ; 1335     size = size + strlen(stored_devicename) - 4 ;
 608  0025 ae0000        	ldw	x,#_stored_devicename
 609  0028 cd0000        	call	_strlen
 611  002b 72fb01        	addw	x,(OFST-1,sp)
 612  002e 1d001c        	subw	x,#28
 614                     ; 1342     size = size - 12;
 617                     ; 1349     size = size + 1;
 620                     ; 1356     size = size - 12;
 623                     ; 1364     size = size + 2;
 626                     ; 1372     size = size - 4;
 629                     ; 1379     size = size + 1;
 631  0031 1f01          	ldw	(OFST-1,sp),x
 633                     ; 1384     size = size + (strlen(stored_mqtt_username) - 4);
 635  0033 ae0000        	ldw	x,#_stored_mqtt_username
 636  0036 cd0000        	call	_strlen
 638  0039 1d0004        	subw	x,#4
 639  003c 72fb01        	addw	x,(OFST-1,sp)
 640  003f 1f01          	ldw	(OFST-1,sp),x
 642                     ; 1389     size = size + (strlen(stored_mqtt_password) - 4);
 644  0041 ae0000        	ldw	x,#_stored_mqtt_password
 645  0044 cd0000        	call	_strlen
 647  0047 1d0004        	subw	x,#4
 648  004a 72fb01        	addw	x,(OFST-1,sp)
 650                     ; 1396     size = size - 15;
 652  004d 1c06c9        	addw	x,#1737
 654                     ; 1410     size = size + (3 * page_string03_len_less4);
 657                     ; 1416     size = size + page_string03_len_less4;
 660                     ; 1439     size = size + (12 * (page_string00_len_less4));
 663                     ; 1448     size = size + (4 * (page_string00_len_less4));
 666                     ; 1458     size = size + (6 * (page_string01_len_less4));
 669                     ; 1467     size = size + (3 * (page_string02_len_less4));
 672                     ; 1482     size = size + page_string02_len_less4;
 676  0050 2010          	jra	L121
 677  0052               L321:
 678                     ; 1556   else if (current_webpage == WEBPAGE_STATS) {
 680  0052 a105          	cp	a,#5
 681  0054 2605          	jrne	L721
 682                     ; 1557     size = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
 684                     ; 1564     size = size + 18;
 686                     ; 1573     size = size + (2 * page_string03_len_less4);
 688  0056 ae01a6        	ldw	x,#422
 691  0059 2007          	jra	L121
 692  005b               L721:
 693                     ; 1581   else if (current_webpage == WEBPAGE_RSTATE) {
 695  005b a106          	cp	a,#6
 696  005d 2603          	jrne	L121
 697                     ; 1582     size = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
 699                     ; 1587     size = size + 12;
 701  005f ae0093        	ldw	x,#147
 703  0062               L121:
 704                     ; 1590   return size;
 708  0062 5b02          	addw	sp,#2
 709  0064 81            	ret	
 800                     ; 1594 void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
 800                     ; 1595 {
 801                     .text:	section	.text,new
 802  0000               _emb_itoa:
 804  0000 5207          	subw	sp,#7
 805       00000007      OFST:	set	7
 808                     ; 1613   for (i=0; i < pad; i++) str[i] = '0';
 810  0002 0f07          	clr	(OFST+0,sp)
 813  0004 200a          	jra	L771
 814  0006               L371:
 817  0006 5f            	clrw	x
 818  0007 97            	ld	xl,a
 819  0008 72fb0e        	addw	x,(OFST+7,sp)
 820  000b a630          	ld	a,#48
 821  000d f7            	ld	(x),a
 824  000e 0c07          	inc	(OFST+0,sp)
 826  0010               L771:
 829  0010 7b07          	ld	a,(OFST+0,sp)
 830  0012 1111          	cp	a,(OFST+10,sp)
 831  0014 25f0          	jrult	L371
 832                     ; 1614   str[pad] = '\0';
 834  0016 7b11          	ld	a,(OFST+10,sp)
 835  0018 5f            	clrw	x
 836  0019 97            	ld	xl,a
 837  001a 72fb0e        	addw	x,(OFST+7,sp)
 838  001d 7f            	clr	(x)
 839                     ; 1615   if (num == 0) return;
 841  001e 96            	ldw	x,sp
 842  001f 1c000a        	addw	x,#OFST+3
 843  0022 cd0000        	call	c_lzmp
 845  0025 2603cc00cf    	jreq	L02
 848                     ; 1618   i = 0;
 850  002a 0f07          	clr	(OFST+0,sp)
 853  002c 2060          	jra	L112
 854  002e               L502:
 855                     ; 1620     rem = (uint8_t)(num % base);
 857  002e 7b10          	ld	a,(OFST+9,sp)
 858  0030 b703          	ld	c_lreg+3,a
 859  0032 3f02          	clr	c_lreg+2
 860  0034 3f01          	clr	c_lreg+1
 861  0036 3f00          	clr	c_lreg
 862  0038 96            	ldw	x,sp
 863  0039 5c            	incw	x
 864  003a cd0000        	call	c_rtol
 867  003d 96            	ldw	x,sp
 868  003e 1c000a        	addw	x,#OFST+3
 869  0041 cd0000        	call	c_ltor
 871  0044 96            	ldw	x,sp
 872  0045 5c            	incw	x
 873  0046 cd0000        	call	c_lumd
 875  0049 b603          	ld	a,c_lreg+3
 876  004b 6b06          	ld	(OFST-1,sp),a
 878                     ; 1621     if (rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
 880  004d a10a          	cp	a,#10
 881  004f 7b07          	ld	a,(OFST+0,sp)
 882  0051 250d          	jrult	L512
 885  0053 0c07          	inc	(OFST+0,sp)
 887  0055 5f            	clrw	x
 888  0056 97            	ld	xl,a
 889  0057 72fb0e        	addw	x,(OFST+7,sp)
 890  005a 7b06          	ld	a,(OFST-1,sp)
 891  005c ab57          	add	a,#87
 893  005e 200b          	jra	L712
 894  0060               L512:
 895                     ; 1622     else str[i++] = (uint8_t)(rem + '0');
 897  0060 0c07          	inc	(OFST+0,sp)
 899  0062 5f            	clrw	x
 900  0063 97            	ld	xl,a
 901  0064 72fb0e        	addw	x,(OFST+7,sp)
 902  0067 7b06          	ld	a,(OFST-1,sp)
 903  0069 ab30          	add	a,#48
 904  006b               L712:
 905  006b f7            	ld	(x),a
 906                     ; 1623     num = num/base;
 908  006c 7b10          	ld	a,(OFST+9,sp)
 909  006e b703          	ld	c_lreg+3,a
 910  0070 3f02          	clr	c_lreg+2
 911  0072 3f01          	clr	c_lreg+1
 912  0074 3f00          	clr	c_lreg
 913  0076 96            	ldw	x,sp
 914  0077 5c            	incw	x
 915  0078 cd0000        	call	c_rtol
 918  007b 96            	ldw	x,sp
 919  007c 1c000a        	addw	x,#OFST+3
 920  007f cd0000        	call	c_ltor
 922  0082 96            	ldw	x,sp
 923  0083 5c            	incw	x
 924  0084 cd0000        	call	c_ludv
 926  0087 96            	ldw	x,sp
 927  0088 1c000a        	addw	x,#OFST+3
 928  008b cd0000        	call	c_rtol
 930  008e               L112:
 931                     ; 1619   while (num != 0) {
 933  008e 96            	ldw	x,sp
 934  008f 1c000a        	addw	x,#OFST+3
 935  0092 cd0000        	call	c_lzmp
 937  0095 2697          	jrne	L502
 938                     ; 1632     start = 0;
 940  0097 0f06          	clr	(OFST-1,sp)
 942                     ; 1633     end = (uint8_t)(pad - 1);
 944  0099 7b11          	ld	a,(OFST+10,sp)
 945  009b 4a            	dec	a
 946  009c 6b07          	ld	(OFST+0,sp),a
 949  009e 2029          	jra	L522
 950  00a0               L122:
 951                     ; 1636       temp = str[start];
 953  00a0 5f            	clrw	x
 954  00a1 97            	ld	xl,a
 955  00a2 72fb0e        	addw	x,(OFST+7,sp)
 956  00a5 f6            	ld	a,(x)
 957  00a6 6b05          	ld	(OFST-2,sp),a
 959                     ; 1637       str[start] = str[end];
 961  00a8 5f            	clrw	x
 962  00a9 7b06          	ld	a,(OFST-1,sp)
 963  00ab 97            	ld	xl,a
 964  00ac 72fb0e        	addw	x,(OFST+7,sp)
 965  00af 7b07          	ld	a,(OFST+0,sp)
 966  00b1 905f          	clrw	y
 967  00b3 9097          	ld	yl,a
 968  00b5 72f90e        	addw	y,(OFST+7,sp)
 969  00b8 90f6          	ld	a,(y)
 970  00ba f7            	ld	(x),a
 971                     ; 1638       str[end] = temp;
 973  00bb 5f            	clrw	x
 974  00bc 7b07          	ld	a,(OFST+0,sp)
 975  00be 97            	ld	xl,a
 976  00bf 72fb0e        	addw	x,(OFST+7,sp)
 977  00c2 7b05          	ld	a,(OFST-2,sp)
 978  00c4 f7            	ld	(x),a
 979                     ; 1639       start++;
 981  00c5 0c06          	inc	(OFST-1,sp)
 983                     ; 1640       end--;
 985  00c7 0a07          	dec	(OFST+0,sp)
 987  00c9               L522:
 988                     ; 1635     while (start < end) {
 988                     ; 1636       temp = str[start];
 988                     ; 1637       str[start] = str[end];
 988                     ; 1638       str[end] = temp;
 988                     ; 1639       start++;
 988                     ; 1640       end--;
 990  00c9 7b06          	ld	a,(OFST-1,sp)
 991  00cb 1107          	cp	a,(OFST+0,sp)
 992  00cd 25d1          	jrult	L122
 993                     ; 1643 }
 994  00cf               L02:
 997  00cf 5b07          	addw	sp,#7
 998  00d1 81            	ret	
1058                     ; 1646 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1058                     ; 1647 {
1059                     .text:	section	.text,new
1060  0000               L3_CopyStringP:
1062  0000 89            	pushw	x
1063  0001 5203          	subw	sp,#3
1064       00000003      OFST:	set	3
1067                     ; 1652   nBytes = 0;
1069  0003 5f            	clrw	x
1071  0004 2014          	jra	L362
1072  0006               L752:
1073                     ; 1654     **ppBuffer = Character;
1075  0006 1e04          	ldw	x,(OFST+1,sp)
1076  0008 fe            	ldw	x,(x)
1077  0009 f7            	ld	(x),a
1078                     ; 1655     *ppBuffer = *ppBuffer + 1;
1080  000a 1e04          	ldw	x,(OFST+1,sp)
1081  000c 9093          	ldw	y,x
1082  000e fe            	ldw	x,(x)
1083  000f 5c            	incw	x
1084  0010 90ff          	ldw	(y),x
1085                     ; 1656     pString = pString + 1;
1087  0012 1e08          	ldw	x,(OFST+5,sp)
1088  0014 5c            	incw	x
1089  0015 1f08          	ldw	(OFST+5,sp),x
1090                     ; 1657     nBytes++;
1092  0017 1e01          	ldw	x,(OFST-2,sp)
1093  0019 5c            	incw	x
1094  001a               L362:
1095  001a 1f01          	ldw	(OFST-2,sp),x
1097                     ; 1653   while ((Character = pString[0]) != '\0') {
1097                     ; 1654     **ppBuffer = Character;
1097                     ; 1655     *ppBuffer = *ppBuffer + 1;
1097                     ; 1656     pString = pString + 1;
1097                     ; 1657     nBytes++;
1099  001c 1e08          	ldw	x,(OFST+5,sp)
1100  001e f6            	ld	a,(x)
1101  001f 6b03          	ld	(OFST+0,sp),a
1103  0021 26e3          	jrne	L752
1104                     ; 1659   return nBytes;
1106  0023 1e01          	ldw	x,(OFST-2,sp)
1109  0025 5b05          	addw	sp,#5
1110  0027 81            	ret	
1169                     ; 1663 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen)
1169                     ; 1664 {
1170                     .text:	section	.text,new
1171  0000               L5_CopyHttpHeader:
1173  0000 89            	pushw	x
1174  0001 5203          	subw	sp,#3
1175       00000003      OFST:	set	3
1178                     ; 1668   nBytes = 0;
1180  0003 5f            	clrw	x
1181  0004 1f02          	ldw	(OFST-1,sp),x
1183                     ; 1670   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
1185  0006 ae1db3        	ldw	x,#L313
1186  0009 89            	pushw	x
1187  000a 96            	ldw	x,sp
1188  000b 1c0006        	addw	x,#OFST+3
1189  000e cd0000        	call	L3_CopyStringP
1191  0011 5b02          	addw	sp,#2
1192  0013 72fb02        	addw	x,(OFST-1,sp)
1193  0016 1f02          	ldw	(OFST-1,sp),x
1195                     ; 1671   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1197  0018 ae1db0        	ldw	x,#L513
1198  001b 89            	pushw	x
1199  001c 96            	ldw	x,sp
1200  001d 1c0006        	addw	x,#OFST+3
1201  0020 cd0000        	call	L3_CopyStringP
1203  0023 5b02          	addw	sp,#2
1204  0025 72fb02        	addw	x,(OFST-1,sp)
1205  0028 1f02          	ldw	(OFST-1,sp),x
1207                     ; 1673   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
1209  002a ae1da0        	ldw	x,#L713
1210  002d 89            	pushw	x
1211  002e 96            	ldw	x,sp
1212  002f 1c0006        	addw	x,#OFST+3
1213  0032 cd0000        	call	L3_CopyStringP
1215  0035 5b02          	addw	sp,#2
1216  0037 72fb02        	addw	x,(OFST-1,sp)
1217  003a 1f02          	ldw	(OFST-1,sp),x
1219                     ; 1677   emb_itoa(nDataLen, OctetArray, 10, 5);
1221  003c 4b05          	push	#5
1222  003e 4b0a          	push	#10
1223  0040 ae0045        	ldw	x,#_OctetArray
1224  0043 89            	pushw	x
1225  0044 1e0c          	ldw	x,(OFST+9,sp)
1226  0046 cd0000        	call	c_uitolx
1228  0049 be02          	ldw	x,c_lreg+2
1229  004b 89            	pushw	x
1230  004c be00          	ldw	x,c_lreg
1231  004e 89            	pushw	x
1232  004f cd0000        	call	_emb_itoa
1234  0052 5b08          	addw	sp,#8
1235                     ; 1678   for (i=0; i<5; i++) {
1237  0054 4f            	clr	a
1238  0055 6b01          	ld	(OFST-2,sp),a
1240  0057               L123:
1241                     ; 1679     *pBuffer = (uint8_t)OctetArray[i];
1243  0057 5f            	clrw	x
1244  0058 97            	ld	xl,a
1245  0059 d60045        	ld	a,(_OctetArray,x)
1246  005c 1e04          	ldw	x,(OFST+1,sp)
1247  005e f7            	ld	(x),a
1248                     ; 1680     pBuffer = pBuffer + 1;
1250  005f 5c            	incw	x
1251  0060 1f04          	ldw	(OFST+1,sp),x
1252                     ; 1678   for (i=0; i<5; i++) {
1254  0062 0c01          	inc	(OFST-2,sp)
1258  0064 7b01          	ld	a,(OFST-2,sp)
1259  0066 a105          	cp	a,#5
1260  0068 25ed          	jrult	L123
1261                     ; 1682   nBytes += 5;
1263  006a 1e02          	ldw	x,(OFST-1,sp)
1264  006c 1c0005        	addw	x,#5
1265  006f 1f02          	ldw	(OFST-1,sp),x
1267                     ; 1684   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1269  0071 ae1db0        	ldw	x,#L513
1270  0074 89            	pushw	x
1271  0075 96            	ldw	x,sp
1272  0076 1c0006        	addw	x,#OFST+3
1273  0079 cd0000        	call	L3_CopyStringP
1275  007c 5b02          	addw	sp,#2
1276  007e 72fb02        	addw	x,(OFST-1,sp)
1277  0081 1f02          	ldw	(OFST-1,sp),x
1279                     ; 1687   nBytes += CopyStringP(&pBuffer, (const char *)("Cache-Control: no-cache, no-store\r\n"));
1281  0083 ae1d7c        	ldw	x,#L723
1282  0086 89            	pushw	x
1283  0087 96            	ldw	x,sp
1284  0088 1c0006        	addw	x,#OFST+3
1285  008b cd0000        	call	L3_CopyStringP
1287  008e 5b02          	addw	sp,#2
1288  0090 72fb02        	addw	x,(OFST-1,sp)
1289  0093 1f02          	ldw	(OFST-1,sp),x
1291                     ; 1689   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type: text/html; charset=utf-8\r\n"));
1293  0095 ae1d53        	ldw	x,#L133
1294  0098 89            	pushw	x
1295  0099 96            	ldw	x,sp
1296  009a 1c0006        	addw	x,#OFST+3
1297  009d cd0000        	call	L3_CopyStringP
1299  00a0 5b02          	addw	sp,#2
1300  00a2 72fb02        	addw	x,(OFST-1,sp)
1301  00a5 1f02          	ldw	(OFST-1,sp),x
1303                     ; 1691   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
1305  00a7 ae1d40        	ldw	x,#L333
1306  00aa 89            	pushw	x
1307  00ab 96            	ldw	x,sp
1308  00ac 1c0006        	addw	x,#OFST+3
1309  00af cd0000        	call	L3_CopyStringP
1311  00b2 5b02          	addw	sp,#2
1312  00b4 72fb02        	addw	x,(OFST-1,sp)
1313  00b7 1f02          	ldw	(OFST-1,sp),x
1315                     ; 1692   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1317  00b9 ae1db0        	ldw	x,#L513
1318  00bc 89            	pushw	x
1319  00bd 96            	ldw	x,sp
1320  00be 1c0006        	addw	x,#OFST+3
1321  00c1 cd0000        	call	L3_CopyStringP
1323  00c4 5b02          	addw	sp,#2
1324  00c6 72fb02        	addw	x,(OFST-1,sp)
1326                     ; 1694   return nBytes;
1330  00c9 5b05          	addw	sp,#5
1331  00cb 81            	ret	
1487                     	switch	.const
1488  1cc0               L431:
1489  1cc0 01ad          	dc.w	L533
1490  1cc2 01bb          	dc.w	L733
1491  1cc4 01c9          	dc.w	L143
1492  1cc6 01d7          	dc.w	L343
1493  1cc8 01e5          	dc.w	L543
1494  1cca 01f3          	dc.w	L743
1495  1ccc 0201          	dc.w	L153
1496  1cce 020e          	dc.w	L353
1497  1cd0 021b          	dc.w	L553
1498  1cd2 0228          	dc.w	L753
1499  1cd4 0235          	dc.w	L163
1500  1cd6 0242          	dc.w	L363
1501  1cd8 024f          	dc.w	L563
1502  1cda 025c          	dc.w	L763
1503  1cdc 0269          	dc.w	L173
1504  1cde 0276          	dc.w	L373
1505                     ; 1698 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
1505                     ; 1699 {
1506                     .text:	section	.text,new
1507  0000               L7_CopyHttpData:
1509  0000 89            	pushw	x
1510  0001 5208          	subw	sp,#8
1511       00000008      OFST:	set	8
1514                     ; 1718   nBytes = 0;
1516  0003 5f            	clrw	x
1517  0004 1f05          	ldw	(OFST-3,sp),x
1519                     ; 1719   nParsedNum = 0;
1521  0006 0f07          	clr	(OFST-1,sp)
1523                     ; 1720   nParsedMode = 0;
1525  0008 0f04          	clr	(OFST-4,sp)
1527                     ; 1775   nMaxBytes = UIP_TCP_MSS - 25;
1529  000a ae019f        	ldw	x,#415
1530  000d 1f11          	ldw	(OFST+9,sp),x
1532  000f cc05cb        	jra	L315
1533  0012               L115:
1534                     ; 1809     if (*pDataLeft > 0) {
1536  0012 1e0f          	ldw	x,(OFST+7,sp)
1537  0014 e601          	ld	a,(1,x)
1538  0016 fa            	or	a,(x)
1539  0017 2603cc05d4    	jreq	L515
1540                     ; 1816       if (insertion_flag[0] != 0) {
1542  001c c60000        	ld	a,_insertion_flag
1543  001f 2711          	jreq	L125
1544                     ; 1825         nParsedMode = insertion_flag[1];
1546  0021 c60001        	ld	a,_insertion_flag+1
1547  0024 6b04          	ld	(OFST-4,sp),a
1549                     ; 1826         nParsedNum = insertion_flag[2];
1551  0026 c60002        	ld	a,_insertion_flag+2
1552  0029 6b07          	ld	(OFST-1,sp),a
1554                     ; 1827 	nByte = '0'; // Need to set nByte to something other than '%' so we
1556  002b a630          	ld	a,#48
1557  002d 6b02          	ld	(OFST-6,sp),a
1560  002f cc00f1        	jra	L325
1561  0032               L125:
1562                     ; 1840         memcpy(&nByte, *ppData, 1);
1564  0032 96            	ldw	x,sp
1565  0033 1c0002        	addw	x,#OFST-6
1566  0036 bf00          	ldw	c_x,x
1567  0038 160d          	ldw	y,(OFST+5,sp)
1568  003a 90fe          	ldw	y,(y)
1569  003c 90bf00        	ldw	c_y,y
1570  003f ae0001        	ldw	x,#1
1571  0042               L25:
1572  0042 5a            	decw	x
1573  0043 92d600        	ld	a,([c_y.w],x)
1574  0046 92d700        	ld	([c_x.w],x),a
1575  0049 5d            	tnzw	x
1576  004a 26f6          	jrne	L25
1577                     ; 1883         if (nByte == '%') {
1579  004c 7b02          	ld	a,(OFST-6,sp)
1580  004e a125          	cp	a,#37
1581  0050 26dd          	jrne	L325
1582                     ; 1884           *ppData = *ppData + 1;
1584  0052 1e0d          	ldw	x,(OFST+5,sp)
1585  0054 9093          	ldw	y,x
1586  0056 fe            	ldw	x,(x)
1587  0057 5c            	incw	x
1588  0058 90ff          	ldw	(y),x
1589                     ; 1885           *pDataLeft = *pDataLeft - 1;
1591  005a 1e0f          	ldw	x,(OFST+7,sp)
1592  005c 9093          	ldw	y,x
1593  005e fe            	ldw	x,(x)
1594  005f 5a            	decw	x
1595  0060 90ff          	ldw	(y),x
1596                     ; 1890           memcpy(&nParsedMode, *ppData, 1);
1598  0062 96            	ldw	x,sp
1599  0063 1c0004        	addw	x,#OFST-4
1600  0066 bf00          	ldw	c_x,x
1601  0068 160d          	ldw	y,(OFST+5,sp)
1602  006a 90fe          	ldw	y,(y)
1603  006c 90bf00        	ldw	c_y,y
1604  006f ae0001        	ldw	x,#1
1605  0072               L45:
1606  0072 5a            	decw	x
1607  0073 92d600        	ld	a,([c_y.w],x)
1608  0076 92d700        	ld	([c_x.w],x),a
1609  0079 5d            	tnzw	x
1610  007a 26f6          	jrne	L45
1611                     ; 1891           *ppData = *ppData + 1;
1613  007c 1e0d          	ldw	x,(OFST+5,sp)
1614  007e 9093          	ldw	y,x
1615  0080 fe            	ldw	x,(x)
1616  0081 5c            	incw	x
1617  0082 90ff          	ldw	(y),x
1618                     ; 1892           *pDataLeft = *pDataLeft - 1;
1620  0084 1e0f          	ldw	x,(OFST+7,sp)
1621  0086 9093          	ldw	y,x
1622  0088 fe            	ldw	x,(x)
1623  0089 5a            	decw	x
1624  008a 90ff          	ldw	(y),x
1625                     ; 1897           memcpy(&temp, *ppData, 1);
1627  008c 96            	ldw	x,sp
1628  008d 5c            	incw	x
1629  008e bf00          	ldw	c_x,x
1630  0090 160d          	ldw	y,(OFST+5,sp)
1631  0092 90fe          	ldw	y,(y)
1632  0094 90bf00        	ldw	c_y,y
1633  0097 ae0001        	ldw	x,#1
1634  009a               L65:
1635  009a 5a            	decw	x
1636  009b 92d600        	ld	a,([c_y.w],x)
1637  009e 92d700        	ld	([c_x.w],x),a
1638  00a1 5d            	tnzw	x
1639  00a2 26f6          	jrne	L65
1640                     ; 1898           nParsedNum = (uint8_t)((temp - '0') * 10);
1642  00a4 7b01          	ld	a,(OFST-7,sp)
1643  00a6 97            	ld	xl,a
1644  00a7 a60a          	ld	a,#10
1645  00a9 42            	mul	x,a
1646  00aa 9f            	ld	a,xl
1647  00ab a0e0          	sub	a,#224
1648  00ad 6b07          	ld	(OFST-1,sp),a
1650                     ; 1899           *ppData = *ppData + 1;
1652  00af 1e0d          	ldw	x,(OFST+5,sp)
1653  00b1 9093          	ldw	y,x
1654  00b3 fe            	ldw	x,(x)
1655  00b4 5c            	incw	x
1656  00b5 90ff          	ldw	(y),x
1657                     ; 1900           *pDataLeft = *pDataLeft - 1;
1659  00b7 1e0f          	ldw	x,(OFST+7,sp)
1660  00b9 9093          	ldw	y,x
1661  00bb fe            	ldw	x,(x)
1662  00bc 5a            	decw	x
1663  00bd 90ff          	ldw	(y),x
1664                     ; 1905           memcpy(&temp, *ppData, 1);
1666  00bf 96            	ldw	x,sp
1667  00c0 5c            	incw	x
1668  00c1 bf00          	ldw	c_x,x
1669  00c3 160d          	ldw	y,(OFST+5,sp)
1670  00c5 90fe          	ldw	y,(y)
1671  00c7 90bf00        	ldw	c_y,y
1672  00ca ae0001        	ldw	x,#1
1673  00cd               L06:
1674  00cd 5a            	decw	x
1675  00ce 92d600        	ld	a,([c_y.w],x)
1676  00d1 92d700        	ld	([c_x.w],x),a
1677  00d4 5d            	tnzw	x
1678  00d5 26f6          	jrne	L06
1679                     ; 1906           nParsedNum = (uint8_t)(nParsedNum + temp - '0');
1681  00d7 7b07          	ld	a,(OFST-1,sp)
1682  00d9 1b01          	add	a,(OFST-7,sp)
1683  00db a030          	sub	a,#48
1684  00dd 6b07          	ld	(OFST-1,sp),a
1686                     ; 1907           *ppData = *ppData + 1;
1688  00df 1e0d          	ldw	x,(OFST+5,sp)
1689  00e1 9093          	ldw	y,x
1690  00e3 fe            	ldw	x,(x)
1691  00e4 5c            	incw	x
1692  00e5 90ff          	ldw	(y),x
1693                     ; 1908           *pDataLeft = *pDataLeft - 1;
1695  00e7 1e0f          	ldw	x,(OFST+7,sp)
1696  00e9 9093          	ldw	y,x
1697  00eb fe            	ldw	x,(x)
1698  00ec 5a            	decw	x
1699  00ed 90ff          	ldw	(y),x
1700  00ef 7b02          	ld	a,(OFST-6,sp)
1701  00f1               L325:
1702                     ; 1912       if ((nByte == '%') || (insertion_flag[0] != 0)) {
1704  00f1 a125          	cp	a,#37
1705  00f3 2709          	jreq	L135
1707  00f5 725d0000      	tnz	_insertion_flag
1708  00f9 2603cc05ae    	jreq	L725
1709  00fe               L135:
1710                     ; 1922         if (nParsedMode == 'i') {
1712  00fe 7b04          	ld	a,(OFST-4,sp)
1713  0100 a169          	cp	a,#105
1714  0102 262b          	jrne	L335
1715                     ; 1936           if (nParsedNum > 7) {
1717  0104 7b07          	ld	a,(OFST-1,sp)
1718  0106 a108          	cp	a,#8
1719  0108 2520          	jrult	L535
1720                     ; 1938 	    i = GpioGetPin(nParsedNum);
1722  010a cd0000        	call	_GpioGetPin
1724  010d 6b08          	ld	(OFST+0,sp),a
1726                     ; 1939 	    if (invert_input == 0x00) *pBuffer = (uint8_t)(i + '0');
1728  010f 725d0000      	tnz	_invert_input
1729  0113 2607          	jrne	L735
1732  0115               LC012:
1733  0115 ab30          	add	a,#48
1734  0117 1e09          	ldw	x,(OFST+1,sp)
1736  0119 cc04e4        	jra	L7101
1737  011c               L735:
1738                     ; 1941 	      if (i == 0) *pBuffer = (uint8_t)('1');
1740  011c 7b08          	ld	a,(OFST+0,sp)
1741  011e 2703cc04e0    	jrne	L5101
1744  0123 1e09          	ldw	x,(OFST+1,sp)
1745  0125 a631          	ld	a,#49
1747  0127 cc04e4        	jra	L7101
1748                     ; 1942 	      else *pBuffer = (uint8_t)('0');
1749                     ; 1944             pBuffer++;
1750                     ; 1945             nBytes++;
1752  012a               L535:
1753                     ; 1949 	    *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
1755  012a cd0000        	call	_GpioGetPin
1757                     ; 1950             pBuffer++;
1758                     ; 1951             nBytes++;
1759  012d 20e6          	jp	LC012
1760  012f               L335:
1761                     ; 1969         else if ((nParsedMode == 'o' && ((uint8_t)(GpioGetPin(nParsedNum) == 1)))
1761                     ; 1970 	      || (nParsedMode == 'p' && ((uint8_t)(GpioGetPin(nParsedNum) == 0)))) { 
1763  012f a16f          	cp	a,#111
1764  0131 260a          	jrne	L755
1766  0133 7b07          	ld	a,(OFST-1,sp)
1767  0135 cd0000        	call	_GpioGetPin
1769  0138 4a            	dec	a
1770  0139 270e          	jreq	L555
1771  013b 7b04          	ld	a,(OFST-4,sp)
1772  013d               L755:
1774  013d a170          	cp	a,#112
1775  013f 2626          	jrne	L355
1777  0141 7b07          	ld	a,(OFST-1,sp)
1778  0143 cd0000        	call	_GpioGetPin
1780  0146 4d            	tnz	a
1781  0147 261e          	jrne	L355
1782  0149               L555:
1783                     ; 1975           for(i=0; i<7; i++) {
1785  0149 4f            	clr	a
1786  014a 6b08          	ld	(OFST+0,sp),a
1788  014c               L165:
1789                     ; 1976             *pBuffer = checked[i];
1791  014c 5f            	clrw	x
1792  014d 97            	ld	xl,a
1793  014e d60000        	ld	a,(L11_checked,x)
1794  0151 1e09          	ldw	x,(OFST+1,sp)
1795  0153 f7            	ld	(x),a
1796                     ; 1977             pBuffer++;
1798  0154 5c            	incw	x
1799  0155 1f09          	ldw	(OFST+1,sp),x
1800                     ; 1975           for(i=0; i<7; i++) {
1802  0157 0c08          	inc	(OFST+0,sp)
1806  0159 7b08          	ld	a,(OFST+0,sp)
1807  015b a107          	cp	a,#7
1808  015d 25ed          	jrult	L165
1809                     ; 1979 	  nBytes += 7;
1811  015f 1e05          	ldw	x,(OFST-3,sp)
1812  0161 1c0007        	addw	x,#7
1814  0164 cc05c9        	jp	LC006
1815  0167               L355:
1816                     ; 1982         else if (nParsedMode == 'a') {
1818  0167 7b04          	ld	a,(OFST-4,sp)
1819  0169 a161          	cp	a,#97
1820  016b 2629          	jrne	L175
1821                     ; 1984 	  for(i=0; i<19; i++) {
1823  016d 4f            	clr	a
1824  016e 6b08          	ld	(OFST+0,sp),a
1826  0170               L375:
1827                     ; 1985 	    if (stored_devicename[i] != '\0') {
1829  0170 5f            	clrw	x
1830  0171 97            	ld	xl,a
1831  0172 724d0000      	tnz	(_stored_devicename,x)
1832  0176 2603cc05cb    	jreq	L315
1833                     ; 1986               *pBuffer = (uint8_t)(stored_devicename[i]);
1835  017b 5f            	clrw	x
1836  017c 97            	ld	xl,a
1837  017d d60000        	ld	a,(_stored_devicename,x)
1838  0180 1e09          	ldw	x,(OFST+1,sp)
1839  0182 f7            	ld	(x),a
1840                     ; 1987               pBuffer++;
1842  0183 5c            	incw	x
1843  0184 1f09          	ldw	(OFST+1,sp),x
1844                     ; 1988               nBytes++;
1846  0186 1e05          	ldw	x,(OFST-3,sp)
1847  0188 5c            	incw	x
1848  0189 1f05          	ldw	(OFST-3,sp),x
1851                     ; 1984 	  for(i=0; i<19; i++) {
1853  018b 0c08          	inc	(OFST+0,sp)
1857  018d 7b08          	ld	a,(OFST+0,sp)
1858  018f a113          	cp	a,#19
1859  0191 25dd          	jrult	L375
1860  0193 cc05cb        	jra	L315
1861  0196               L175:
1862                     ; 1994         else if (nParsedMode == 'b') {
1864  0196 a162          	cp	a,#98
1865  0198 2703cc02b2    	jrne	L706
1866                     ; 1999           switch (nParsedNum)
1868  019d 7b07          	ld	a,(OFST-1,sp)
1870                     ; 2020 	    default: break;
1871  019f a110          	cp	a,#16
1872  01a1 2503cc0294    	jruge	L316
1873  01a6 5f            	clrw	x
1874  01a7 97            	ld	xl,a
1875  01a8 58            	sllw	x
1876  01a9 de1cc0        	ldw	x,(L431,x)
1877  01ac fc            	jp	(x)
1878  01ad               L533:
1879                     ; 2002 	    case 0:  emb_itoa(stored_hostaddr[3], OctetArray, 10, 3); break;
1881  01ad 4b03          	push	#3
1882  01af 4b0a          	push	#10
1883  01b1 ae0045        	ldw	x,#_OctetArray
1884  01b4 89            	pushw	x
1885  01b5 c60003        	ld	a,_stored_hostaddr+3
1889  01b8 cc0281        	jp	LC001
1890  01bb               L733:
1891                     ; 2003 	    case 1:  emb_itoa(stored_hostaddr[2], OctetArray, 10, 3); break;
1893  01bb 4b03          	push	#3
1894  01bd 4b0a          	push	#10
1895  01bf ae0045        	ldw	x,#_OctetArray
1896  01c2 89            	pushw	x
1897  01c3 c60002        	ld	a,_stored_hostaddr+2
1901  01c6 cc0281        	jp	LC001
1902  01c9               L143:
1903                     ; 2004 	    case 2:  emb_itoa(stored_hostaddr[1], OctetArray, 10, 3); break;
1905  01c9 4b03          	push	#3
1906  01cb 4b0a          	push	#10
1907  01cd ae0045        	ldw	x,#_OctetArray
1908  01d0 89            	pushw	x
1909  01d1 c60001        	ld	a,_stored_hostaddr+1
1913  01d4 cc0281        	jp	LC001
1914  01d7               L343:
1915                     ; 2005 	    case 3:  emb_itoa(stored_hostaddr[0], OctetArray, 10, 3); break;
1917  01d7 4b03          	push	#3
1918  01d9 4b0a          	push	#10
1919  01db ae0045        	ldw	x,#_OctetArray
1920  01de 89            	pushw	x
1921  01df c60000        	ld	a,_stored_hostaddr
1925  01e2 cc0281        	jp	LC001
1926  01e5               L543:
1927                     ; 2006 	    case 4:  emb_itoa(stored_draddr[3],   OctetArray, 10, 3); break;
1929  01e5 4b03          	push	#3
1930  01e7 4b0a          	push	#10
1931  01e9 ae0045        	ldw	x,#_OctetArray
1932  01ec 89            	pushw	x
1933  01ed c60003        	ld	a,_stored_draddr+3
1937  01f0 cc0281        	jp	LC001
1938  01f3               L743:
1939                     ; 2007 	    case 5:  emb_itoa(stored_draddr[2],   OctetArray, 10, 3); break;
1941  01f3 4b03          	push	#3
1942  01f5 4b0a          	push	#10
1943  01f7 ae0045        	ldw	x,#_OctetArray
1944  01fa 89            	pushw	x
1945  01fb c60002        	ld	a,_stored_draddr+2
1949  01fe cc0281        	jp	LC001
1950  0201               L153:
1951                     ; 2008 	    case 6:  emb_itoa(stored_draddr[1],   OctetArray, 10, 3); break;
1953  0201 4b03          	push	#3
1954  0203 4b0a          	push	#10
1955  0205 ae0045        	ldw	x,#_OctetArray
1956  0208 89            	pushw	x
1957  0209 c60001        	ld	a,_stored_draddr+1
1961  020c 2073          	jp	LC001
1962  020e               L353:
1963                     ; 2009 	    case 7:  emb_itoa(stored_draddr[0],   OctetArray, 10, 3); break;
1965  020e 4b03          	push	#3
1966  0210 4b0a          	push	#10
1967  0212 ae0045        	ldw	x,#_OctetArray
1968  0215 89            	pushw	x
1969  0216 c60000        	ld	a,_stored_draddr
1973  0219 2066          	jp	LC001
1974  021b               L553:
1975                     ; 2010 	    case 8:  emb_itoa(stored_netmask[3],  OctetArray, 10, 3); break;
1977  021b 4b03          	push	#3
1978  021d 4b0a          	push	#10
1979  021f ae0045        	ldw	x,#_OctetArray
1980  0222 89            	pushw	x
1981  0223 c60003        	ld	a,_stored_netmask+3
1985  0226 2059          	jp	LC001
1986  0228               L753:
1987                     ; 2011 	    case 9:  emb_itoa(stored_netmask[2],  OctetArray, 10, 3); break;
1989  0228 4b03          	push	#3
1990  022a 4b0a          	push	#10
1991  022c ae0045        	ldw	x,#_OctetArray
1992  022f 89            	pushw	x
1993  0230 c60002        	ld	a,_stored_netmask+2
1997  0233 204c          	jp	LC001
1998  0235               L163:
1999                     ; 2012 	    case 10: emb_itoa(stored_netmask[1],  OctetArray, 10, 3); break;
2001  0235 4b03          	push	#3
2002  0237 4b0a          	push	#10
2003  0239 ae0045        	ldw	x,#_OctetArray
2004  023c 89            	pushw	x
2005  023d c60001        	ld	a,_stored_netmask+1
2009  0240 203f          	jp	LC001
2010  0242               L363:
2011                     ; 2013 	    case 11: emb_itoa(stored_netmask[0],  OctetArray, 10, 3); break;
2013  0242 4b03          	push	#3
2014  0244 4b0a          	push	#10
2015  0246 ae0045        	ldw	x,#_OctetArray
2016  0249 89            	pushw	x
2017  024a c60000        	ld	a,_stored_netmask
2021  024d 2032          	jp	LC001
2022  024f               L563:
2023                     ; 2015 	    case 12: emb_itoa(stored_mqttserveraddr[3], OctetArray, 10, 3); break;
2025  024f 4b03          	push	#3
2026  0251 4b0a          	push	#10
2027  0253 ae0045        	ldw	x,#_OctetArray
2028  0256 89            	pushw	x
2029  0257 c60003        	ld	a,_stored_mqttserveraddr+3
2033  025a 2025          	jp	LC001
2034  025c               L763:
2035                     ; 2016 	    case 13: emb_itoa(stored_mqttserveraddr[2], OctetArray, 10, 3); break;
2037  025c 4b03          	push	#3
2038  025e 4b0a          	push	#10
2039  0260 ae0045        	ldw	x,#_OctetArray
2040  0263 89            	pushw	x
2041  0264 c60002        	ld	a,_stored_mqttserveraddr+2
2045  0267 2018          	jp	LC001
2046  0269               L173:
2047                     ; 2017 	    case 14: emb_itoa(stored_mqttserveraddr[1], OctetArray, 10, 3); break;
2049  0269 4b03          	push	#3
2050  026b 4b0a          	push	#10
2051  026d ae0045        	ldw	x,#_OctetArray
2052  0270 89            	pushw	x
2053  0271 c60001        	ld	a,_stored_mqttserveraddr+1
2057  0274 200b          	jp	LC001
2058  0276               L373:
2059                     ; 2018 	    case 15: emb_itoa(stored_mqttserveraddr[0], OctetArray, 10, 3); break;
2061  0276 4b03          	push	#3
2062  0278 4b0a          	push	#10
2063  027a ae0045        	ldw	x,#_OctetArray
2064  027d 89            	pushw	x
2065  027e c60000        	ld	a,_stored_mqttserveraddr
2067  0281               LC001:
2068  0281 b703          	ld	c_lreg+3,a
2069  0283 3f02          	clr	c_lreg+2
2070  0285 3f01          	clr	c_lreg+1
2071  0287 3f00          	clr	c_lreg
2072  0289 be02          	ldw	x,c_lreg+2
2073  028b 89            	pushw	x
2074  028c be00          	ldw	x,c_lreg
2075  028e 89            	pushw	x
2076  028f cd0000        	call	_emb_itoa
2077  0292 5b08          	addw	sp,#8
2080                     ; 2020 	    default: break;
2082  0294               L316:
2083                     ; 2024 	  for(i=0; i<3; i++) {
2085  0294 4f            	clr	a
2086  0295 6b08          	ld	(OFST+0,sp),a
2088  0297               L516:
2089                     ; 2025 	    *pBuffer = (uint8_t)OctetArray[i];
2091  0297 5f            	clrw	x
2092  0298 97            	ld	xl,a
2093  0299 d60045        	ld	a,(_OctetArray,x)
2094  029c 1e09          	ldw	x,(OFST+1,sp)
2095  029e f7            	ld	(x),a
2096                     ; 2026             pBuffer++;
2098  029f 5c            	incw	x
2099  02a0 1f09          	ldw	(OFST+1,sp),x
2100                     ; 2024 	  for(i=0; i<3; i++) {
2102  02a2 0c08          	inc	(OFST+0,sp)
2106  02a4 7b08          	ld	a,(OFST+0,sp)
2107  02a6 a103          	cp	a,#3
2108  02a8 25ed          	jrult	L516
2109                     ; 2028 	  nBytes += 3;
2111  02aa 1e05          	ldw	x,(OFST-3,sp)
2112  02ac 1c0003        	addw	x,#3
2114  02af cc05c9        	jp	LC006
2115  02b2               L706:
2116                     ; 2031         else if (nParsedMode == 'c') {
2118  02b2 a163          	cp	a,#99
2119  02b4 2648          	jrne	L526
2120                     ; 2040 	  if (nParsedNum == 0) emb_itoa(stored_port, OctetArray, 10, 5);
2122  02b6 7b07          	ld	a,(OFST-1,sp)
2123  02b8 260d          	jrne	L726
2126  02ba 4b05          	push	#5
2127  02bc 4b0a          	push	#10
2128  02be ae0045        	ldw	x,#_OctetArray
2129  02c1 89            	pushw	x
2130  02c2 ce0000        	ldw	x,_stored_port
2134  02c5 200b          	jra	L136
2135  02c7               L726:
2136                     ; 2042 	  else emb_itoa(stored_mqttport, OctetArray, 10, 5);
2138  02c7 4b05          	push	#5
2139  02c9 4b0a          	push	#10
2140  02cb ae0045        	ldw	x,#_OctetArray
2141  02ce 89            	pushw	x
2142  02cf ce0000        	ldw	x,_stored_mqttport
2145  02d2               L136:
2146  02d2 cd0000        	call	c_uitolx
2147  02d5 be02          	ldw	x,c_lreg+2
2148  02d7 89            	pushw	x
2149  02d8 be00          	ldw	x,c_lreg
2150  02da 89            	pushw	x
2151  02db cd0000        	call	_emb_itoa
2152  02de 5b08          	addw	sp,#8
2153                     ; 2046 	  for(i=0; i<5; i++) {
2155  02e0 4f            	clr	a
2156  02e1 6b08          	ld	(OFST+0,sp),a
2158  02e3               L336:
2159                     ; 2047             *pBuffer = (uint8_t)OctetArray[i];
2161  02e3 5f            	clrw	x
2162  02e4 97            	ld	xl,a
2163  02e5 d60045        	ld	a,(_OctetArray,x)
2164  02e8 1e09          	ldw	x,(OFST+1,sp)
2165  02ea f7            	ld	(x),a
2166                     ; 2048             pBuffer++;
2168  02eb 5c            	incw	x
2169  02ec 1f09          	ldw	(OFST+1,sp),x
2170                     ; 2046 	  for(i=0; i<5; i++) {
2172  02ee 0c08          	inc	(OFST+0,sp)
2176  02f0 7b08          	ld	a,(OFST+0,sp)
2177  02f2 a105          	cp	a,#5
2178  02f4 25ed          	jrult	L336
2179                     ; 2050 	  nBytes += 5;
2181  02f6 1e05          	ldw	x,(OFST-3,sp)
2182  02f8 1c0005        	addw	x,#5
2184  02fb cc05c9        	jp	LC006
2185  02fe               L526:
2186                     ; 2053         else if (nParsedMode == 'd') {
2188  02fe a164          	cp	a,#100
2189  0300 266a          	jrne	L346
2190                     ; 2058 	  if (nParsedNum == 0) { OctetArray[0] = mac_string[0]; OctetArray[1] = mac_string[1]; }
2192  0302 7b07          	ld	a,(OFST-1,sp)
2193  0304 260a          	jrne	L546
2196  0306 5500000045    	mov	_OctetArray,_mac_string
2199  030b 5500010046    	mov	_OctetArray+1,_mac_string+1
2200  0310               L546:
2201                     ; 2059 	  if (nParsedNum == 1) { OctetArray[0] = mac_string[2]; OctetArray[1] = mac_string[3]; }
2203  0310 a101          	cp	a,#1
2204  0312 260a          	jrne	L746
2207  0314 5500020045    	mov	_OctetArray,_mac_string+2
2210  0319 5500030046    	mov	_OctetArray+1,_mac_string+3
2211  031e               L746:
2212                     ; 2060 	  if (nParsedNum == 2) { OctetArray[0] = mac_string[4]; OctetArray[1] = mac_string[5]; }
2214  031e a102          	cp	a,#2
2215  0320 260a          	jrne	L156
2218  0322 5500040045    	mov	_OctetArray,_mac_string+4
2221  0327 5500050046    	mov	_OctetArray+1,_mac_string+5
2222  032c               L156:
2223                     ; 2061 	  if (nParsedNum == 3) { OctetArray[0] = mac_string[6]; OctetArray[1] = mac_string[7]; }
2225  032c a103          	cp	a,#3
2226  032e 260a          	jrne	L356
2229  0330 5500060045    	mov	_OctetArray,_mac_string+6
2232  0335 5500070046    	mov	_OctetArray+1,_mac_string+7
2233  033a               L356:
2234                     ; 2062 	  if (nParsedNum == 4) { OctetArray[0] = mac_string[8]; OctetArray[1] = mac_string[9]; }
2236  033a a104          	cp	a,#4
2237  033c 260a          	jrne	L556
2240  033e 5500080045    	mov	_OctetArray,_mac_string+8
2243  0343 5500090046    	mov	_OctetArray+1,_mac_string+9
2244  0348               L556:
2245                     ; 2063 	  if (nParsedNum == 5) { OctetArray[0] = mac_string[10]; OctetArray[1] = mac_string[11]; }
2247  0348 a105          	cp	a,#5
2248  034a 260a          	jrne	L756
2251  034c 55000a0045    	mov	_OctetArray,_mac_string+10
2254  0351 55000b0046    	mov	_OctetArray+1,_mac_string+11
2255  0356               L756:
2256                     ; 2065           *pBuffer = OctetArray[0];
2258  0356 1e09          	ldw	x,(OFST+1,sp)
2259  0358 c60045        	ld	a,_OctetArray
2260  035b f7            	ld	(x),a
2261                     ; 2066           pBuffer++;
2263  035c 5c            	incw	x
2264  035d 1f09          	ldw	(OFST+1,sp),x
2265                     ; 2067           nBytes++;
2267  035f 1e05          	ldw	x,(OFST-3,sp)
2268  0361 5c            	incw	x
2269  0362 1f05          	ldw	(OFST-3,sp),x
2271                     ; 2069           *pBuffer = OctetArray[1];
2273  0364 c60046        	ld	a,_OctetArray+1
2274  0367 1e09          	ldw	x,(OFST+1,sp)
2275                     ; 2070           pBuffer++;
2276                     ; 2071           nBytes++;
2278  0369 cc04e4        	jp	L7101
2279  036c               L346:
2280                     ; 2139         else if (nParsedMode == 'e') {
2282  036c a165          	cp	a,#101
2283  036e 2663          	jrne	L366
2284                     ; 2140           switch (nParsedNum)
2286  0370 7b07          	ld	a,(OFST-1,sp)
2288                     ; 2146 	    case 28:  emb_itoa(TXERIF_counter, OctetArray, 10, 10); break;
2289  0372 a01a          	sub	a,#26
2290  0374 2708          	jreq	L773
2291  0376 4a            	dec	a
2292  0377 2716          	jreq	L104
2293  0379 4a            	dec	a
2294  037a 2724          	jreq	L304
2295  037c 2037          	jra	L766
2296  037e               L773:
2297                     ; 2144 	    case 26:  emb_itoa(second_counter, OctetArray, 10, 10); break;
2299  037e 4b0a          	push	#10
2300  0380 4b0a          	push	#10
2301  0382 ae0045        	ldw	x,#_OctetArray
2302  0385 89            	pushw	x
2303  0386 ce0002        	ldw	x,_second_counter+2
2304  0389 89            	pushw	x
2305  038a ce0000        	ldw	x,_second_counter
2309  038d 2020          	jp	LC002
2310  038f               L104:
2311                     ; 2145 	    case 27:  emb_itoa(RXERIF_counter, OctetArray, 10, 10); break;
2313  038f 4b0a          	push	#10
2314  0391 4b0a          	push	#10
2315  0393 ae0045        	ldw	x,#_OctetArray
2316  0396 89            	pushw	x
2317  0397 ce0002        	ldw	x,_RXERIF_counter+2
2318  039a 89            	pushw	x
2319  039b ce0000        	ldw	x,_RXERIF_counter
2323  039e 200f          	jp	LC002
2324  03a0               L304:
2325                     ; 2146 	    case 28:  emb_itoa(TXERIF_counter, OctetArray, 10, 10); break;
2327  03a0 4b0a          	push	#10
2328  03a2 4b0a          	push	#10
2329  03a4 ae0045        	ldw	x,#_OctetArray
2330  03a7 89            	pushw	x
2331  03a8 ce0002        	ldw	x,_TXERIF_counter+2
2332  03ab 89            	pushw	x
2333  03ac ce0000        	ldw	x,_TXERIF_counter
2335  03af               LC002:
2336  03af 89            	pushw	x
2337  03b0 cd0000        	call	_emb_itoa
2338  03b3 5b08          	addw	sp,#8
2341  03b5               L766:
2342                     ; 2148 	  for (i=0; i<10; i++) {
2344  03b5 4f            	clr	a
2345  03b6 6b08          	ld	(OFST+0,sp),a
2347  03b8               L176:
2348                     ; 2149             *pBuffer = OctetArray[i];
2350  03b8 5f            	clrw	x
2351  03b9 97            	ld	xl,a
2352  03ba d60045        	ld	a,(_OctetArray,x)
2353  03bd 1e09          	ldw	x,(OFST+1,sp)
2354  03bf f7            	ld	(x),a
2355                     ; 2150             pBuffer++;
2357  03c0 5c            	incw	x
2358  03c1 1f09          	ldw	(OFST+1,sp),x
2359                     ; 2148 	  for (i=0; i<10; i++) {
2361  03c3 0c08          	inc	(OFST+0,sp)
2365  03c5 7b08          	ld	a,(OFST+0,sp)
2366  03c7 a10a          	cp	a,#10
2367  03c9 25ed          	jrult	L176
2368                     ; 2152 	  nBytes += 10;
2370  03cb 1e05          	ldw	x,(OFST-3,sp)
2371  03cd 1c000a        	addw	x,#10
2373  03d0 cc05c9        	jp	LC006
2374  03d3               L366:
2375                     ; 2156         else if (nParsedMode == 'f') {
2377  03d3 a166          	cp	a,#102
2378  03d5 263d          	jrne	L107
2379                     ; 2171 	  for(i=0; i<16; i++) {
2381  03d7 4f            	clr	a
2382  03d8 6b08          	ld	(OFST+0,sp),a
2384  03da               L307:
2385                     ; 2172             if (i > 7) {
2387  03da a108          	cp	a,#8
2388  03dc 251b          	jrult	L117
2389                     ; 2174               j = GpioGetPin(i);
2391  03de cd0000        	call	_GpioGetPin
2393  03e1 6b03          	ld	(OFST-5,sp),a
2395                     ; 2175               if (invert_input == 0x00) *pBuffer = (uint8_t)(j + '0');
2397  03e3 725d0000      	tnz	_invert_input
2400  03e7 2713          	jreq	LC010
2401                     ; 2177                 if (j == 0) *pBuffer = (uint8_t)('1'); 
2403  03e9 7b03          	ld	a,(OFST-5,sp)
2404  03eb 2606          	jrne	L717
2407  03ed 1e09          	ldw	x,(OFST+1,sp)
2408  03ef a631          	ld	a,#49
2410  03f1 200d          	jra	L327
2411  03f3               L717:
2412                     ; 2178                 else *pBuffer = (uint8_t)('0');
2414  03f3 1e09          	ldw	x,(OFST+1,sp)
2415  03f5 a630          	ld	a,#48
2416                     ; 2180               pBuffer++;
2418  03f7 2007          	jra	L327
2419  03f9               L117:
2420                     ; 2184               *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
2422  03f9 cd0000        	call	_GpioGetPin
2424  03fc               LC010:
2426  03fc ab30          	add	a,#48
2427  03fe 1e09          	ldw	x,(OFST+1,sp)
2428                     ; 2185               pBuffer++;
2430  0400               L327:
2431  0400 f7            	ld	(x),a
2433  0401 5c            	incw	x
2434  0402 1f09          	ldw	(OFST+1,sp),x
2435                     ; 2171 	  for(i=0; i<16; i++) {
2437  0404 0c08          	inc	(OFST+0,sp)
2441  0406 7b08          	ld	a,(OFST+0,sp)
2442  0408 a110          	cp	a,#16
2443  040a 25ce          	jrult	L307
2444                     ; 2188 	  nBytes += 16;
2446  040c 1e05          	ldw	x,(OFST-3,sp)
2447  040e 1c0010        	addw	x,#16
2449  0411 cc05c9        	jp	LC006
2450  0414               L107:
2451                     ; 2207 else if (nParsedMode == 'g') {
2453  0414 a167          	cp	a,#103
2454  0416 261e          	jrne	L727
2455                     ; 2220 	  for(i = 0; i < 6; i++) {
2457  0418 4f            	clr	a
2458  0419 6b08          	ld	(OFST+0,sp),a
2460  041b               L137:
2461                     ; 2221             *pBuffer = stored_config_settings[i];
2463  041b 5f            	clrw	x
2464  041c 97            	ld	xl,a
2465  041d d60000        	ld	a,(_stored_config_settings,x)
2466  0420 1e09          	ldw	x,(OFST+1,sp)
2467  0422 f7            	ld	(x),a
2468                     ; 2222             pBuffer++;
2470  0423 5c            	incw	x
2471  0424 1f09          	ldw	(OFST+1,sp),x
2472                     ; 2220 	  for(i = 0; i < 6; i++) {
2474  0426 0c08          	inc	(OFST+0,sp)
2478  0428 7b08          	ld	a,(OFST+0,sp)
2479  042a a106          	cp	a,#6
2480  042c 25ed          	jrult	L137
2481                     ; 2224           nBytes += 6;
2483  042e 1e05          	ldw	x,(OFST-3,sp)
2484  0430 1c0006        	addw	x,#6
2486  0433 cc05c9        	jp	LC006
2487  0436               L727:
2488                     ; 2228         else if (nParsedMode == 'l') {
2490  0436 a16c          	cp	a,#108
2491  0438 2629          	jrne	L147
2492                     ; 2231           for(i=0; i<10; i++) {
2494  043a 4f            	clr	a
2495  043b 6b08          	ld	(OFST+0,sp),a
2497  043d               L347:
2498                     ; 2232 	    if (stored_mqtt_username[i] != '\0') {
2500  043d 5f            	clrw	x
2501  043e 97            	ld	xl,a
2502  043f 724d0000      	tnz	(_stored_mqtt_username,x)
2503  0443 2603cc05cb    	jreq	L315
2504                     ; 2233               *pBuffer = (uint8_t)(stored_mqtt_username[i]);
2506  0448 5f            	clrw	x
2507  0449 97            	ld	xl,a
2508  044a d60000        	ld	a,(_stored_mqtt_username,x)
2509  044d 1e09          	ldw	x,(OFST+1,sp)
2510  044f f7            	ld	(x),a
2511                     ; 2234               pBuffer++;
2513  0450 5c            	incw	x
2514  0451 1f09          	ldw	(OFST+1,sp),x
2515                     ; 2235               nBytes++;
2517  0453 1e05          	ldw	x,(OFST-3,sp)
2518  0455 5c            	incw	x
2519  0456 1f05          	ldw	(OFST-3,sp),x
2522                     ; 2231           for(i=0; i<10; i++) {
2524  0458 0c08          	inc	(OFST+0,sp)
2528  045a 7b08          	ld	a,(OFST+0,sp)
2529  045c a10a          	cp	a,#10
2530  045e 25dd          	jrult	L347
2531  0460 cc05cb        	jra	L315
2532  0463               L147:
2533                     ; 2241         else if (nParsedMode == 'm') {
2535  0463 a16d          	cp	a,#109
2536  0465 2626          	jrne	L757
2537                     ; 2244           for(i=0; i<10; i++) {
2539  0467 4f            	clr	a
2540  0468 6b08          	ld	(OFST+0,sp),a
2542  046a               L167:
2543                     ; 2245 	    if (stored_mqtt_password[i] != '\0') {
2545  046a 5f            	clrw	x
2546  046b 97            	ld	xl,a
2547  046c 724d0000      	tnz	(_stored_mqtt_password,x)
2548  0470 27ee          	jreq	L315
2549                     ; 2246               *pBuffer = (uint8_t)(stored_mqtt_password[i]);
2551  0472 5f            	clrw	x
2552  0473 97            	ld	xl,a
2553  0474 d60000        	ld	a,(_stored_mqtt_password,x)
2554  0477 1e09          	ldw	x,(OFST+1,sp)
2555  0479 f7            	ld	(x),a
2556                     ; 2247               pBuffer++;
2558  047a 5c            	incw	x
2559  047b 1f09          	ldw	(OFST+1,sp),x
2560                     ; 2248               nBytes++;
2562  047d 1e05          	ldw	x,(OFST-3,sp)
2563  047f 5c            	incw	x
2564  0480 1f05          	ldw	(OFST-3,sp),x
2567                     ; 2244           for(i=0; i<10; i++) {
2569  0482 0c08          	inc	(OFST+0,sp)
2573  0484 7b08          	ld	a,(OFST+0,sp)
2574  0486 a10a          	cp	a,#10
2575  0488 25e0          	jrult	L167
2576  048a cc05cb        	jra	L315
2577  048d               L757:
2578                     ; 2254         else if (nParsedMode == 'n') {
2580  048d a16e          	cp	a,#110
2581  048f 2657          	jrne	L577
2582                     ; 2258 	  no_err = 0;
2584  0491 0f08          	clr	(OFST+0,sp)
2586                     ; 2259           switch (nParsedNum)
2588  0493 7b07          	ld	a,(OFST-1,sp)
2590                     ; 2281 	    default:
2590                     ; 2282 	      break;
2591  0495 270e          	jreq	L504
2592  0497 4a            	dec	a
2593  0498 2712          	jreq	L704
2594  049a 4a            	dec	a
2595  049b 2716          	jreq	L114
2596  049d 4a            	dec	a
2597  049e 271a          	jreq	L314
2598  04a0 4a            	dec	a
2599  04a1 271f          	jreq	L514
2600  04a3 2030          	jra	L1001
2601  04a5               L504:
2602                     ; 2261 	    case 0:
2602                     ; 2262               // Connection request status
2602                     ; 2263 	      if (mqtt_start_status & MQTT_START_CONNECTIONS_GOOD) no_err = 1;
2604  04a5 720900002b    	btjf	_mqtt_start_status,#4,L1001
2606  04aa 2013          	jp	LC004
2607  04ac               L704:
2608                     ; 2265 	    case 1:
2608                     ; 2266 	      // ARP request status
2608                     ; 2267 	      if (mqtt_start_status & MQTT_START_ARP_REQUEST_GOOD) no_err = 1;
2610  04ac 720b000024    	btjf	_mqtt_start_status,#5,L1001
2612  04b1 200c          	jp	LC004
2613  04b3               L114:
2614                     ; 2269 	    case 2:
2614                     ; 2270 	      // TCP connection status
2614                     ; 2271 	      if (mqtt_start_status & MQTT_START_TCP_CONNECT_GOOD) no_err = 1;
2616  04b3 720d00001d    	btjf	_mqtt_start_status,#6,L1001
2618  04b8 2005          	jp	LC004
2619  04ba               L314:
2620                     ; 2273 	    case 3:
2620                     ; 2274 	      // MQTT Connection status 1
2620                     ; 2275 	      if (mqtt_start_status & MQTT_START_MQTT_CONNECT_GOOD) no_err = 1;
2622  04ba 720f000016    	btjf	_mqtt_start_status,#7,L1001
2625  04bf               LC004:
2629  04bf 4c            	inc	a
2630  04c0 2011          	jp	LC003
2631  04c2               L514:
2632                     ; 2277 	    case 4:
2632                     ; 2278 	      // MQTT start complete with no errors
2632                     ; 2279 	      if ((MQTT_error_status == 1) && ((mqtt_start_status & 0xf0) == 0xf0) ) no_err = 1;
2634  04c2 c60000        	ld	a,_MQTT_error_status
2635  04c5 4a            	dec	a
2636  04c6 260d          	jrne	L1001
2638  04c8 c60000        	ld	a,_mqtt_start_status
2639  04cb a4f0          	and	a,#240
2640  04cd a1f0          	cp	a,#240
2641  04cf 2604          	jrne	L1001
2644  04d1 a601          	ld	a,#1
2645  04d3               LC003:
2646  04d3 6b08          	ld	(OFST+0,sp),a
2648                     ; 2281 	    default:
2648                     ; 2282 	      break;
2650  04d5               L1001:
2651                     ; 2284 	  if (no_err == 1) *pBuffer = '1'; // Paint a green square
2653  04d5 7b08          	ld	a,(OFST+0,sp)
2654  04d7 4a            	dec	a
2655  04d8 2606          	jrne	L5101
2658  04da 1e09          	ldw	x,(OFST+1,sp)
2659  04dc a631          	ld	a,#49
2661  04de 2004          	jra	L7101
2662  04e0               L5101:
2663                     ; 2285 	  else *pBuffer = '0'; // Paint a red square
2666  04e0 1e09          	ldw	x,(OFST+1,sp)
2667  04e2 a630          	ld	a,#48
2668  04e4               L7101:
2669  04e4 f7            	ld	(x),a
2670                     ; 2286           pBuffer++;
2671                     ; 2287           nBytes++;
2673  04e5 cc05c3        	jp	LC007
2674  04e8               L577:
2675                     ; 2291         else if (nParsedMode == 'y') {
2677  04e8 a179          	cp	a,#121
2678  04ea 269e          	jrne	L315
2679                     ; 2336 	  i = insertion_flag[0];
2681  04ec c60000        	ld	a,_insertion_flag
2682  04ef 6b08          	ld	(OFST+0,sp),a
2684                     ; 2337 	  insertion_flag[1] = nParsedMode;
2686  04f1 7b04          	ld	a,(OFST-4,sp)
2687  04f3 c70001        	ld	_insertion_flag+1,a
2688                     ; 2338 	  insertion_flag[2] = nParsedNum;
2690  04f6 7b07          	ld	a,(OFST-1,sp)
2691  04f8 c70002        	ld	_insertion_flag+2,a
2692                     ; 2340           switch (nParsedNum)
2695                     ; 2388 	    default: break;
2696  04fb 2718          	jreq	L124
2697  04fd 4a            	dec	a
2698  04fe 272a          	jreq	L324
2699  0500 4a            	dec	a
2700  0501 273c          	jreq	L524
2701  0503 4a            	dec	a
2702  0504 274e          	jreq	L724
2703  0506 4a            	dec	a
2704  0507 2760          	jreq	L134
2705  0509 4a            	dec	a
2706  050a 2772          	jreq	L334
2707  050c 4a            	dec	a
2708  050d 2603cc0593    	jreq	L534
2709  0512 cc05c1        	jra	LC008
2710  0515               L124:
2711                     ; 2342 	    case 0:
2711                     ; 2343 	      // %y00 replaced with string 
2711                     ; 2344 	      // page_string00[] = "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'";
2711                     ; 2345               *pBuffer = (uint8_t)page_string00[i];
2713  0515 7b08          	ld	a,(OFST+0,sp)
2714  0517 5f            	clrw	x
2715  0518 97            	ld	xl,a
2716  0519 d61a45        	ld	a,(L32_page_string00,x)
2717  051c 1e09          	ldw	x,(OFST+1,sp)
2718  051e f7            	ld	(x),a
2719                     ; 2346 	      insertion_flag[0]++;
2721  051f 725c0000      	inc	_insertion_flag
2722                     ; 2347 	      if (insertion_flag[0] == page_string00_len) insertion_flag[0] = 0;
2724  0523 c60000        	ld	a,_insertion_flag
2725  0526 a13f          	cp	a,#63
2727  0528 207c          	jp	LC005
2728  052a               L324:
2729                     ; 2349 	    case 1:
2729                     ; 2350 	      // %y01 replaced with string 
2729                     ; 2351               // page_string01[] = "pattern='[0-9a-f]{2}' title='Enter 00 to ff' maxlength='2'";
2729                     ; 2352               *pBuffer = (uint8_t)page_string01[i];
2731  052a 7b08          	ld	a,(OFST+0,sp)
2732  052c 5f            	clrw	x
2733  052d 97            	ld	xl,a
2734  052e d61a87        	ld	a,(L13_page_string01,x)
2735  0531 1e09          	ldw	x,(OFST+1,sp)
2736  0533 f7            	ld	(x),a
2737                     ; 2353 	      insertion_flag[0]++;
2739  0534 725c0000      	inc	_insertion_flag
2740                     ; 2354 	      if (insertion_flag[0] == page_string01_len) insertion_flag[0] = 0;
2742  0538 c60000        	ld	a,_insertion_flag
2743  053b a140          	cp	a,#64
2745  053d 2067          	jp	LC005
2746  053f               L524:
2747                     ; 2356 	    case 2:
2747                     ; 2357 	      // %y02 replaced with string 
2747                     ; 2358               // page_string02[] = "<button title='Save first! This button will not save your changes'>";
2747                     ; 2359               *pBuffer = (uint8_t)page_string02[i];
2749  053f 7b08          	ld	a,(OFST+0,sp)
2750  0541 5f            	clrw	x
2751  0542 97            	ld	xl,a
2752  0543 d61aca        	ld	a,(L73_page_string02,x)
2753  0546 1e09          	ldw	x,(OFST+1,sp)
2754  0548 f7            	ld	(x),a
2755                     ; 2360 	      insertion_flag[0]++;
2757  0549 725c0000      	inc	_insertion_flag
2758                     ; 2361 	      if (insertion_flag[0] == page_string02_len) insertion_flag[0] = 0;
2760  054d c60000        	ld	a,_insertion_flag
2761  0550 a152          	cp	a,#82
2763  0552 2052          	jp	LC005
2764  0554               L724:
2765                     ; 2363 	    case 3:
2765                     ; 2364 	      // %y03 replaced with string 
2765                     ; 2365               // page_string03[] = "<form style='display: inline' action='http://";
2765                     ; 2366               *pBuffer = (uint8_t)page_string03[i];
2767  0554 7b08          	ld	a,(OFST+0,sp)
2768  0556 5f            	clrw	x
2769  0557 97            	ld	xl,a
2770  0558 d61b1f        	ld	a,(L54_page_string03,x)
2771  055b 1e09          	ldw	x,(OFST+1,sp)
2772  055d f7            	ld	(x),a
2773                     ; 2367 	      insertion_flag[0]++;
2775  055e 725c0000      	inc	_insertion_flag
2776                     ; 2368 	      if (insertion_flag[0] == page_string03_len) insertion_flag[0] = 0;
2778  0562 c60000        	ld	a,_insertion_flag
2779  0565 a126          	cp	a,#38
2781  0567 203d          	jp	LC005
2782  0569               L134:
2783                     ; 2370 	    case 4:
2783                     ; 2371 	      // %y04 replaced with first header string 
2783                     ; 2372               *pBuffer = (uint8_t)page_string04[i];
2785  0569 7b08          	ld	a,(OFST+0,sp)
2786  056b 5f            	clrw	x
2787  056c 97            	ld	xl,a
2788  056d d61b48        	ld	a,(L35_page_string04,x)
2789  0570 1e09          	ldw	x,(OFST+1,sp)
2790  0572 f7            	ld	(x),a
2791                     ; 2373 	      insertion_flag[0]++;
2793  0573 725c0000      	inc	_insertion_flag
2794                     ; 2374 	      if (insertion_flag[0] == page_string04_len) insertion_flag[0] = 0;
2796  0577 c60000        	ld	a,_insertion_flag
2797  057a a147          	cp	a,#71
2799  057c 2028          	jp	LC005
2800  057e               L334:
2801                     ; 2376 	    case 5:
2801                     ; 2377 	      // %y05 replaced with second header string 
2801                     ; 2378               *pBuffer = (uint8_t)page_string05[i];
2803  057e 7b08          	ld	a,(OFST+0,sp)
2804  0580 5f            	clrw	x
2805  0581 97            	ld	xl,a
2806  0582 d61b92        	ld	a,(L16_page_string05,x)
2807  0585 1e09          	ldw	x,(OFST+1,sp)
2808  0587 f7            	ld	(x),a
2809                     ; 2379 	      insertion_flag[0]++;
2811  0588 725c0000      	inc	_insertion_flag
2812                     ; 2380 	      if (insertion_flag[0] == page_string05_len) insertion_flag[0] = 0;
2814  058c c60000        	ld	a,_insertion_flag
2815  058f a1ed          	cp	a,#237
2817  0591 2013          	jp	LC005
2818  0593               L534:
2819                     ; 2382 	    case 6:
2819                     ; 2383 	      // %y06 replaced with third header string 
2819                     ; 2384               *pBuffer = (uint8_t)page_string06[i];
2821  0593 7b08          	ld	a,(OFST+0,sp)
2822  0595 5f            	clrw	x
2823  0596 97            	ld	xl,a
2824  0597 d61c82        	ld	a,(L76_page_string06,x)
2825  059a 1e09          	ldw	x,(OFST+1,sp)
2826  059c f7            	ld	(x),a
2827                     ; 2385 	      insertion_flag[0]++;
2829  059d 725c0000      	inc	_insertion_flag
2830                     ; 2386 	      if (insertion_flag[0] == page_string06_len) insertion_flag[0] = 0;
2832  05a1 c60000        	ld	a,_insertion_flag
2833  05a4 a13b          	cp	a,#59
2836  05a6               LC005:
2837  05a6 2619          	jrne	LC008
2844  05a8 725f0000      	clr	_insertion_flag
2845                     ; 2388 	    default: break;
2847                     ; 2390           pBuffer++;
2848                     ; 2391           nBytes++;
2849  05ac 2013          	jp	LC008
2850  05ae               L725:
2851                     ; 2399         *pBuffer = nByte;
2853  05ae 1e09          	ldw	x,(OFST+1,sp)
2854  05b0 f7            	ld	(x),a
2855                     ; 2400         *ppData = *ppData + 1;
2857  05b1 1e0d          	ldw	x,(OFST+5,sp)
2858  05b3 9093          	ldw	y,x
2859  05b5 fe            	ldw	x,(x)
2860  05b6 5c            	incw	x
2861  05b7 90ff          	ldw	(y),x
2862                     ; 2401         *pDataLeft = *pDataLeft - 1;
2864  05b9 1e0f          	ldw	x,(OFST+7,sp)
2865  05bb 9093          	ldw	y,x
2866  05bd fe            	ldw	x,(x)
2867  05be 5a            	decw	x
2868  05bf 90ff          	ldw	(y),x
2869                     ; 2402         pBuffer++;
2871  05c1               LC008:
2873  05c1 1e09          	ldw	x,(OFST+1,sp)
2874                     ; 2403         nBytes++;
2876  05c3               LC007:
2881  05c3 5c            	incw	x
2882  05c4 1f09          	ldw	(OFST+1,sp),x
2888  05c6 1e05          	ldw	x,(OFST-3,sp)
2889  05c8 5c            	incw	x
2890  05c9               LC006:
2891  05c9 1f05          	ldw	(OFST-3,sp),x
2893  05cb               L315:
2894                     ; 1778   while (nBytes < nMaxBytes) {
2896  05cb 1e05          	ldw	x,(OFST-3,sp)
2897  05cd 1311          	cpw	x,(OFST+9,sp)
2898  05cf 2403cc0012    	jrult	L115
2899  05d4               L515:
2900                     ; 2408   return nBytes;
2902  05d4 1e05          	ldw	x,(OFST-3,sp)
2905  05d6 5b0a          	addw	sp,#10
2906  05d8 81            	ret	
2938                     ; 2412 void HttpDInit()
2938                     ; 2413 {
2939                     .text:	section	.text,new
2940  0000               _HttpDInit:
2944                     ; 2415   uip_listen(htons(Port_Httpd));
2946  0000 ce0000        	ldw	x,_Port_Httpd
2947  0003 cd0000        	call	_htons
2949  0006 cd0000        	call	_uip_listen
2951                     ; 2416   current_webpage = WEBPAGE_IOCONTROL;
2953  0009 725f0003      	clr	_current_webpage
2954                     ; 2419   insertion_flag[0] = 0;
2956  000d 725f0000      	clr	_insertion_flag
2957                     ; 2420   insertion_flag[1] = 0;
2959  0011 725f0001      	clr	_insertion_flag+1
2960                     ; 2421   insertion_flag[2] = 0;
2962  0015 725f0002      	clr	_insertion_flag+2
2963                     ; 2424   saved_nstate = STATE_NULL;
2965  0019 357f0044      	mov	_saved_nstate,#127
2966                     ; 2425   saved_parsestate = PARSE_CMD;
2968  001d 725f0043      	clr	_saved_parsestate
2969                     ; 2426   saved_nparseleft = 0;
2971  0021 725f0042      	clr	_saved_nparseleft
2972                     ; 2427   clear_saved_postpartial_all();
2975                     ; 2428 }
2978  0025 cc0000        	jp	_clear_saved_postpartial_all
3170                     	switch	.const
3171  1ce0               L422:
3172  1ce0 08ac          	dc.w	L7601
3173  1ce2 08b3          	dc.w	L1701
3174  1ce4 08ba          	dc.w	L3701
3175  1ce6 08c1          	dc.w	L5701
3176  1ce8 08c8          	dc.w	L7701
3177  1cea 08cf          	dc.w	L1011
3178  1cec 08d6          	dc.w	L3011
3179  1cee 08dd          	dc.w	L5011
3180  1cf0 08e4          	dc.w	L7011
3181  1cf2 08eb          	dc.w	L1111
3182  1cf4 08f2          	dc.w	L3111
3183  1cf6 08f9          	dc.w	L5111
3184  1cf8 0900          	dc.w	L7111
3185  1cfa 0907          	dc.w	L1211
3186  1cfc 090e          	dc.w	L3211
3187  1cfe 0915          	dc.w	L5211
3188                     ; 2431 void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
3188                     ; 2432 {
3189                     .text:	section	.text,new
3190  0000               _HttpDCall:
3192  0000 89            	pushw	x
3193  0001 5204          	subw	sp,#4
3194       00000004      OFST:	set	4
3197                     ; 2436   i = 0;
3199  0003 0f04          	clr	(OFST+0,sp)
3201                     ; 2438   if (uip_connected()) {
3203  0005 720d000055    	btjf	_uip_flags,#6,L3421
3204                     ; 2440     if (current_webpage == WEBPAGE_IOCONTROL) {
3206  000a c60003        	ld	a,_current_webpage
3207  000d 260e          	jrne	L5421
3208                     ; 2441       pSocket->pData = g_HtmlPageIOControl;
3210  000f 1e0b          	ldw	x,(OFST+7,sp)
3211  0011 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
3212  0015 ef01          	ldw	(1,x),y
3213                     ; 2442       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
3215  0017 90ae0c06      	ldw	y,#3078
3217  001b 2034          	jp	LC013
3218  001d               L5421:
3219                     ; 2446     else if (current_webpage == WEBPAGE_CONFIGURATION) {
3221  001d a101          	cp	a,#1
3222  001f 260e          	jrne	L1521
3223                     ; 2447       pSocket->pData = g_HtmlPageConfiguration;
3225  0021 1e0b          	ldw	x,(OFST+7,sp)
3226  0023 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
3227  0027 ef01          	ldw	(1,x),y
3228                     ; 2448       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
3230  0029 90ae0c5c      	ldw	y,#3164
3232  002d 2022          	jp	LC013
3233  002f               L1521:
3234                     ; 2463     else if (current_webpage == WEBPAGE_STATS) {
3236  002f a105          	cp	a,#5
3237  0031 260e          	jrne	L5521
3238                     ; 2464       pSocket->pData = g_HtmlPageStats;
3240  0033 1e0b          	ldw	x,(OFST+7,sp)
3241  0035 90ae186c      	ldw	y,#L71_g_HtmlPageStats
3242  0039 ef01          	ldw	(1,x),y
3243                     ; 2465       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
3245  003b 90ae0150      	ldw	y,#336
3247  003f 2010          	jp	LC013
3248  0041               L5521:
3249                     ; 2469     else if (current_webpage == WEBPAGE_RSTATE) {
3251  0041 a106          	cp	a,#6
3252  0043 260e          	jrne	L7421
3253                     ; 2470       pSocket->pData = g_HtmlPageRstate;
3255  0045 1e0b          	ldw	x,(OFST+7,sp)
3256  0047 90ae19bd      	ldw	y,#L12_g_HtmlPageRstate
3257  004b ef01          	ldw	(1,x),y
3258                     ; 2471       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
3260  004d 90ae0087      	ldw	y,#135
3261  0051               LC013:
3262  0051 ef03          	ldw	(3,x),y
3263  0053               L7421:
3264                     ; 2474     pSocket->nState = STATE_CONNECTED;
3266  0053 1e0b          	ldw	x,(OFST+7,sp)
3267                     ; 2475     pSocket->nPrevBytes = 0xFFFF;
3269  0055 90aeffff      	ldw	y,#65535
3270  0059 7f            	clr	(x)
3271  005a ef0b          	ldw	(11,x),y
3273  005c cc012f        	jra	L252
3274  005f               L3421:
3275                     ; 2484   else if (uip_newdata() || uip_acked()) {
3277  005f 7202000008    	btjt	_uip_flags,#1,L7621
3279  0064 7200000003cc  	btjf	_uip_flags,#0,L5621
3280  006c               L7621:
3281                     ; 2485     if (uip_acked()) {
3283  006c 7201000003cc  	btjt	_uip_flags,#0,L3511
3284                     ; 2488       goto senddata;
3286                     ; 2558     if (saved_nstate != STATE_NULL) {
3288  0074 c60044        	ld	a,_saved_nstate
3289  0077 a17f          	cp	a,#127
3290  0079 2603cc00fb    	jreq	L1231
3291                     ; 2564       pSocket->nState = saved_nstate;
3293  007e 1e0b          	ldw	x,(OFST+7,sp)
3294  0080 f7            	ld	(x),a
3295                     ; 2571       pSocket->ParseState = saved_parsestate;
3297  0081 c60043        	ld	a,_saved_parsestate
3298  0084 e70a          	ld	(10,x),a
3299                     ; 2575       pSocket->nParseLeft = saved_nparseleft;
3301  0086 c60042        	ld	a,_saved_nparseleft
3302  0089 e706          	ld	(6,x),a
3303                     ; 2577       pSocket->nNewlines = saved_newlines;
3305  008b c60011        	ld	a,_saved_newlines
3306  008e e705          	ld	(5,x),a
3307                     ; 2589       for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i];
3309  0090 4f            	clr	a
3310  0091 6b04          	ld	(OFST+0,sp),a
3312  0093               L5721:
3315  0093 5f            	clrw	x
3316  0094 97            	ld	xl,a
3317  0095 d6002a        	ld	a,(_saved_postpartial,x)
3318  0098 d70012        	ld	(_saved_postpartial_previous,x),a
3321  009b 0c04          	inc	(OFST+0,sp)
3325  009d 7b04          	ld	a,(OFST+0,sp)
3326  009f a118          	cp	a,#24
3327  00a1 25f0          	jrult	L5721
3328                     ; 2594       if (saved_nstate == STATE_PARSEPOST) {
3330  00a3 c60044        	ld	a,_saved_nstate
3331  00a6 a10a          	cp	a,#10
3332  00a8 2651          	jrne	L1231
3333                     ; 2595         if (saved_parsestate == PARSE_CMD) {
3335  00aa c60043        	ld	a,_saved_parsestate
3336  00ad 274c          	jreq	L1231
3338                     ; 2598         else if (saved_parsestate == PARSE_NUM10) {
3340  00af a101          	cp	a,#1
3341  00b1 2609          	jrne	L1131
3342                     ; 2600 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3344  00b3 1e0b          	ldw	x,(OFST+7,sp)
3345  00b5 c60012        	ld	a,_saved_postpartial_previous
3346  00b8 e708          	ld	(8,x),a
3348  00ba 203f          	jra	L1231
3349  00bc               L1131:
3350                     ; 2602         else if (saved_parsestate == PARSE_NUM1) {
3352  00bc a102          	cp	a,#2
3353  00be 2615          	jrne	L5131
3354                     ; 2604 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3356  00c0 1e0b          	ldw	x,(OFST+7,sp)
3357  00c2 c60012        	ld	a,_saved_postpartial_previous
3358  00c5 e708          	ld	(8,x),a
3359                     ; 2605           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3361  00c7 c60013        	ld	a,_saved_postpartial_previous+1
3362  00ca 97            	ld	xl,a
3363  00cb a60a          	ld	a,#10
3364  00cd 42            	mul	x,a
3365  00ce 9f            	ld	a,xl
3366  00cf a0e0          	sub	a,#224
3367  00d1 1e0b          	ldw	x,(OFST+7,sp)
3369  00d3 2024          	jp	LC014
3370  00d5               L5131:
3371                     ; 2607         else if (saved_parsestate == PARSE_EQUAL || saved_parsestate == PARSE_VAL) {
3373  00d5 a103          	cp	a,#3
3374  00d7 2704          	jreq	L3231
3376  00d9 a104          	cp	a,#4
3377  00db 261e          	jrne	L1231
3378  00dd               L3231:
3379                     ; 2609 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3381  00dd 1e0b          	ldw	x,(OFST+7,sp)
3382  00df c60012        	ld	a,_saved_postpartial_previous
3383  00e2 e708          	ld	(8,x),a
3384                     ; 2610           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3386  00e4 c60013        	ld	a,_saved_postpartial_previous+1
3387  00e7 97            	ld	xl,a
3388  00e8 a60a          	ld	a,#10
3389  00ea 42            	mul	x,a
3390  00eb 9f            	ld	a,xl
3391  00ec 1e0b          	ldw	x,(OFST+7,sp)
3392  00ee a0e0          	sub	a,#224
3393  00f0 e709          	ld	(9,x),a
3394                     ; 2611           pSocket->ParseNum += (uint8_t)(saved_postpartial_previous[2] - '0');
3396  00f2 c60014        	ld	a,_saved_postpartial_previous+2
3397  00f5 a030          	sub	a,#48
3398  00f7 eb09          	add	a,(9,x)
3399  00f9               LC014:
3400  00f9 e709          	ld	(9,x),a
3402  00fb               L1231:
3403                     ; 2613 	else if (saved_parsestate == PARSE_DELIM) {
3405                     ; 2633     if (pSocket->nState == STATE_CONNECTED) {
3407  00fb 1e0b          	ldw	x,(OFST+7,sp)
3408  00fd f6            	ld	a,(x)
3409  00fe 2627          	jrne	L1331
3410                     ; 2634       if (nBytes == 0) return;
3412  0100 1e09          	ldw	x,(OFST+5,sp)
3413  0102 272b          	jreq	L252
3416                     ; 2635       if (*pBuffer == 'G') {
3418  0104 1e05          	ldw	x,(OFST+1,sp)
3419  0106 f6            	ld	a,(x)
3420  0107 a147          	cp	a,#71
3421  0109 2606          	jrne	L5331
3422                     ; 2636         pSocket->nState = STATE_GET_G;
3424  010b 1e0b          	ldw	x,(OFST+7,sp)
3425  010d a601          	ld	a,#1
3427  010f 2008          	jp	LC015
3428  0111               L5331:
3429                     ; 2638       else if (*pBuffer == 'P') {
3431  0111 a150          	cp	a,#80
3432  0113 2605          	jrne	L7331
3433                     ; 2639         pSocket->nState = STATE_POST_P;
3435  0115 1e0b          	ldw	x,(OFST+7,sp)
3436  0117 a604          	ld	a,#4
3437  0119               LC015:
3438  0119 f7            	ld	(x),a
3439  011a               L7331:
3440                     ; 2641       nBytes--;
3442  011a 1e09          	ldw	x,(OFST+5,sp)
3443  011c 5a            	decw	x
3444  011d 1f09          	ldw	(OFST+5,sp),x
3445                     ; 2642       pBuffer++;
3447  011f 1e05          	ldw	x,(OFST+1,sp)
3448  0121 5c            	incw	x
3449  0122 1f05          	ldw	(OFST+1,sp),x
3450  0124 1e0b          	ldw	x,(OFST+7,sp)
3451  0126 f6            	ld	a,(x)
3452  0127               L1331:
3453                     ; 2645     if (pSocket->nState == STATE_GET_G) {
3455  0127 a101          	cp	a,#1
3456  0129 2620          	jrne	L3431
3457                     ; 2646       if (nBytes == 0) return;
3459  012b 1e09          	ldw	x,(OFST+5,sp)
3460  012d 2603          	jrne	L5431
3462  012f               L252:
3465  012f 5b06          	addw	sp,#6
3466  0131 81            	ret	
3467  0132               L5431:
3468                     ; 2647       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
3470  0132 1e05          	ldw	x,(OFST+1,sp)
3471  0134 f6            	ld	a,(x)
3472  0135 a145          	cp	a,#69
3473  0137 2605          	jrne	L7431
3476  0139 1e0b          	ldw	x,(OFST+7,sp)
3477  013b a602          	ld	a,#2
3478  013d f7            	ld	(x),a
3479  013e               L7431:
3480                     ; 2648       nBytes--;
3482  013e 1e09          	ldw	x,(OFST+5,sp)
3483  0140 5a            	decw	x
3484  0141 1f09          	ldw	(OFST+5,sp),x
3485                     ; 2649       pBuffer++;
3487  0143 1e05          	ldw	x,(OFST+1,sp)
3488  0145 5c            	incw	x
3489  0146 1f05          	ldw	(OFST+1,sp),x
3490  0148 1e0b          	ldw	x,(OFST+7,sp)
3491  014a f6            	ld	a,(x)
3492  014b               L3431:
3493                     ; 2652     if (pSocket->nState == STATE_GET_GE) {
3495  014b a102          	cp	a,#2
3496  014d 261d          	jrne	L1531
3497                     ; 2653       if (nBytes == 0) return;
3499  014f 1e09          	ldw	x,(OFST+5,sp)
3500  0151 27dc          	jreq	L252
3503                     ; 2654       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
3505  0153 1e05          	ldw	x,(OFST+1,sp)
3506  0155 f6            	ld	a,(x)
3507  0156 a154          	cp	a,#84
3508  0158 2605          	jrne	L5531
3511  015a 1e0b          	ldw	x,(OFST+7,sp)
3512  015c a603          	ld	a,#3
3513  015e f7            	ld	(x),a
3514  015f               L5531:
3515                     ; 2655       nBytes--;
3517  015f 1e09          	ldw	x,(OFST+5,sp)
3518  0161 5a            	decw	x
3519  0162 1f09          	ldw	(OFST+5,sp),x
3520                     ; 2656       pBuffer++;
3522  0164 1e05          	ldw	x,(OFST+1,sp)
3523  0166 5c            	incw	x
3524  0167 1f05          	ldw	(OFST+1,sp),x
3525  0169 1e0b          	ldw	x,(OFST+7,sp)
3526  016b f6            	ld	a,(x)
3527  016c               L1531:
3528                     ; 2659     if (pSocket->nState == STATE_GET_GET) {
3530  016c a103          	cp	a,#3
3531  016e 261d          	jrne	L7531
3532                     ; 2660       if (nBytes == 0) return;
3534  0170 1e09          	ldw	x,(OFST+5,sp)
3535  0172 27bb          	jreq	L252
3538                     ; 2661       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
3540  0174 1e05          	ldw	x,(OFST+1,sp)
3541  0176 f6            	ld	a,(x)
3542  0177 a120          	cp	a,#32
3543  0179 2605          	jrne	L3631
3546  017b 1e0b          	ldw	x,(OFST+7,sp)
3547  017d a608          	ld	a,#8
3548  017f f7            	ld	(x),a
3549  0180               L3631:
3550                     ; 2662       nBytes--;
3552  0180 1e09          	ldw	x,(OFST+5,sp)
3553  0182 5a            	decw	x
3554  0183 1f09          	ldw	(OFST+5,sp),x
3555                     ; 2663       pBuffer++;
3557  0185 1e05          	ldw	x,(OFST+1,sp)
3558  0187 5c            	incw	x
3559  0188 1f05          	ldw	(OFST+1,sp),x
3560  018a 1e0b          	ldw	x,(OFST+7,sp)
3561  018c f6            	ld	a,(x)
3562  018d               L7531:
3563                     ; 2666     if (pSocket->nState == STATE_POST_P) {
3565  018d a104          	cp	a,#4
3566  018f 261d          	jrne	L5631
3567                     ; 2667       if (nBytes == 0) return;
3569  0191 1e09          	ldw	x,(OFST+5,sp)
3570  0193 279a          	jreq	L252
3573                     ; 2668       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
3575  0195 1e05          	ldw	x,(OFST+1,sp)
3576  0197 f6            	ld	a,(x)
3577  0198 a14f          	cp	a,#79
3578  019a 2605          	jrne	L1731
3581  019c 1e0b          	ldw	x,(OFST+7,sp)
3582  019e a605          	ld	a,#5
3583  01a0 f7            	ld	(x),a
3584  01a1               L1731:
3585                     ; 2669       nBytes--;
3587  01a1 1e09          	ldw	x,(OFST+5,sp)
3588  01a3 5a            	decw	x
3589  01a4 1f09          	ldw	(OFST+5,sp),x
3590                     ; 2670       pBuffer++;
3592  01a6 1e05          	ldw	x,(OFST+1,sp)
3593  01a8 5c            	incw	x
3594  01a9 1f05          	ldw	(OFST+1,sp),x
3595  01ab 1e0b          	ldw	x,(OFST+7,sp)
3596  01ad f6            	ld	a,(x)
3597  01ae               L5631:
3598                     ; 2673     if (pSocket->nState == STATE_POST_PO) {
3600  01ae a105          	cp	a,#5
3601  01b0 2620          	jrne	L3731
3602                     ; 2674       if (nBytes == 0) return;
3604  01b2 1e09          	ldw	x,(OFST+5,sp)
3605  01b4 2603cc012f    	jreq	L252
3608                     ; 2675       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
3610  01b9 1e05          	ldw	x,(OFST+1,sp)
3611  01bb f6            	ld	a,(x)
3612  01bc a153          	cp	a,#83
3613  01be 2605          	jrne	L7731
3616  01c0 1e0b          	ldw	x,(OFST+7,sp)
3617  01c2 a606          	ld	a,#6
3618  01c4 f7            	ld	(x),a
3619  01c5               L7731:
3620                     ; 2676       nBytes--;
3622  01c5 1e09          	ldw	x,(OFST+5,sp)
3623  01c7 5a            	decw	x
3624  01c8 1f09          	ldw	(OFST+5,sp),x
3625                     ; 2677       pBuffer++;
3627  01ca 1e05          	ldw	x,(OFST+1,sp)
3628  01cc 5c            	incw	x
3629  01cd 1f05          	ldw	(OFST+1,sp),x
3630  01cf 1e0b          	ldw	x,(OFST+7,sp)
3631  01d1 f6            	ld	a,(x)
3632  01d2               L3731:
3633                     ; 2680     if (pSocket->nState == STATE_POST_POS) {
3635  01d2 a106          	cp	a,#6
3636  01d4 261d          	jrne	L1041
3637                     ; 2681       if (nBytes == 0) return;
3639  01d6 1e09          	ldw	x,(OFST+5,sp)
3640  01d8 27dc          	jreq	L252
3643                     ; 2682       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
3645  01da 1e05          	ldw	x,(OFST+1,sp)
3646  01dc f6            	ld	a,(x)
3647  01dd a154          	cp	a,#84
3648  01df 2605          	jrne	L5041
3651  01e1 1e0b          	ldw	x,(OFST+7,sp)
3652  01e3 a607          	ld	a,#7
3653  01e5 f7            	ld	(x),a
3654  01e6               L5041:
3655                     ; 2683       nBytes--;
3657  01e6 1e09          	ldw	x,(OFST+5,sp)
3658  01e8 5a            	decw	x
3659  01e9 1f09          	ldw	(OFST+5,sp),x
3660                     ; 2684       pBuffer++;
3662  01eb 1e05          	ldw	x,(OFST+1,sp)
3663  01ed 5c            	incw	x
3664  01ee 1f05          	ldw	(OFST+1,sp),x
3665  01f0 1e0b          	ldw	x,(OFST+7,sp)
3666  01f2 f6            	ld	a,(x)
3667  01f3               L1041:
3668                     ; 2687     if (pSocket->nState == STATE_POST_POST) {
3670  01f3 a107          	cp	a,#7
3671  01f5 261d          	jrne	L7041
3672                     ; 2688       if (nBytes == 0) return;
3674  01f7 1e09          	ldw	x,(OFST+5,sp)
3675  01f9 27bb          	jreq	L252
3678                     ; 2689       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
3680  01fb 1e05          	ldw	x,(OFST+1,sp)
3681  01fd f6            	ld	a,(x)
3682  01fe a120          	cp	a,#32
3683  0200 2605          	jrne	L3141
3686  0202 1e0b          	ldw	x,(OFST+7,sp)
3687  0204 a609          	ld	a,#9
3688  0206 f7            	ld	(x),a
3689  0207               L3141:
3690                     ; 2690       nBytes--;
3692  0207 1e09          	ldw	x,(OFST+5,sp)
3693  0209 5a            	decw	x
3694  020a 1f09          	ldw	(OFST+5,sp),x
3695                     ; 2691       pBuffer++;
3697  020c 1e05          	ldw	x,(OFST+1,sp)
3698  020e 5c            	incw	x
3699  020f 1f05          	ldw	(OFST+1,sp),x
3700  0211 1e0b          	ldw	x,(OFST+7,sp)
3701  0213 f6            	ld	a,(x)
3702  0214               L7041:
3703                     ; 2694     if (pSocket->nState == STATE_GOTPOST) {
3705  0214 a109          	cp	a,#9
3706  0216 2703cc029d    	jrne	L5141
3707                     ; 2696       saved_nstate = STATE_GOTPOST;
3709  021b 35090044      	mov	_saved_nstate,#9
3710                     ; 2697       if (nBytes == 0) {
3712  021f 1e09          	ldw	x,(OFST+5,sp)
3713  0221 2676          	jrne	L3241
3714                     ; 2700 	saved_newlines = pSocket->nNewlines;
3716  0223 1e0b          	ldw	x,(OFST+7,sp)
3717  0225 e605          	ld	a,(5,x)
3718  0227 c70011        	ld	_saved_newlines,a
3719                     ; 2701         return;
3721  022a cc012f        	jra	L252
3722  022d               L1241:
3723                     ; 2709 	if (saved_newlines == 2) {
3725  022d c60011        	ld	a,_saved_newlines
3726  0230 a102          	cp	a,#2
3727  0232 272b          	jreq	L1341
3729                     ; 2714           if (*pBuffer == '\n') pSocket->nNewlines++;
3731  0234 1e05          	ldw	x,(OFST+1,sp)
3732  0236 f6            	ld	a,(x)
3733  0237 a10a          	cp	a,#10
3734  0239 2606          	jrne	L3341
3737  023b 1e0b          	ldw	x,(OFST+7,sp)
3738  023d 6c05          	inc	(5,x)
3740  023f 2008          	jra	L5341
3741  0241               L3341:
3742                     ; 2715           else if (*pBuffer == '\r') { }
3744  0241 a10d          	cp	a,#13
3745  0243 2704          	jreq	L5341
3747                     ; 2716           else pSocket->nNewlines = 0;
3749  0245 1e0b          	ldw	x,(OFST+7,sp)
3750  0247 6f05          	clr	(5,x)
3751  0249               L5341:
3752                     ; 2717           pBuffer++;
3754  0249 1e05          	ldw	x,(OFST+1,sp)
3755  024b 5c            	incw	x
3756  024c 1f05          	ldw	(OFST+1,sp),x
3757                     ; 2718           nBytes--;
3759  024e 1e09          	ldw	x,(OFST+5,sp)
3760  0250 5a            	decw	x
3761  0251 1f09          	ldw	(OFST+5,sp),x
3762                     ; 2719           if (nBytes == 0) {
3764  0253 260a          	jrne	L1341
3765                     ; 2722             saved_newlines = pSocket->nNewlines;
3767  0255 1e0b          	ldw	x,(OFST+7,sp)
3768  0257 e605          	ld	a,(5,x)
3769  0259 c70011        	ld	_saved_newlines,a
3770                     ; 2723             return;
3772  025c cc012f        	jra	L252
3773  025f               L1341:
3774                     ; 2731         if (pSocket->nNewlines == 2) {
3776  025f 1e0b          	ldw	x,(OFST+7,sp)
3777  0261 e605          	ld	a,(5,x)
3778  0263 a102          	cp	a,#2
3779  0265 2632          	jrne	L3241
3780                     ; 2734           if (current_webpage == WEBPAGE_IOCONTROL) {
3782  0267 c60003        	ld	a,_current_webpage
3783  026a 2609          	jrne	L7441
3784                     ; 2735 	    pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
3786  026c a635          	ld	a,#53
3787  026e e706          	ld	(6,x),a
3788                     ; 2736 	    pSocket->nParseLeftAddl = PARSEBYTES_IOCONTROL_ADDL;
3790  0270 6f07          	clr	(7,x)
3791  0272 c60003        	ld	a,_current_webpage
3792  0275               L7441:
3793                     ; 2738           if (current_webpage == WEBPAGE_CONFIGURATION) {
3795  0275 4a            	dec	a
3796  0276 2608          	jrne	L1541
3797                     ; 2739 	    pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
3799  0278 a6ec          	ld	a,#236
3800  027a e706          	ld	(6,x),a
3801                     ; 2740 	    pSocket->nParseLeftAddl = PARSEBYTES_CONFIGURATION_ADDL;
3803  027c a618          	ld	a,#24
3804  027e e707          	ld	(7,x),a
3805  0280               L1541:
3806                     ; 2742           pSocket->ParseState = saved_parsestate = PARSE_CMD;
3808  0280 725f0043      	clr	_saved_parsestate
3809  0284 6f0a          	clr	(10,x)
3810                     ; 2743 	  saved_nparseleft = pSocket->nParseLeft;
3812  0286 e606          	ld	a,(6,x)
3813  0288 c70042        	ld	_saved_nparseleft,a
3814                     ; 2745           pSocket->nState = STATE_PARSEPOST;
3816  028b a60a          	ld	a,#10
3817  028d f7            	ld	(x),a
3818                     ; 2746 	  saved_nstate = STATE_PARSEPOST;
3820  028e 350a0044      	mov	_saved_nstate,#10
3821                     ; 2747 	  if (nBytes == 0) {
3823  0292 1e09          	ldw	x,(OFST+5,sp)
3824  0294 2607          	jrne	L5141
3825                     ; 2750 	    return;
3827  0296 cc012f        	jra	L252
3828  0299               L3241:
3829                     ; 2704       while (nBytes != 0) {
3831  0299 1e09          	ldw	x,(OFST+5,sp)
3832  029b 2690          	jrne	L1241
3833  029d               L5141:
3834                     ; 2757     if (pSocket->nState == STATE_GOTGET) {
3836  029d 1e0b          	ldw	x,(OFST+7,sp)
3837  029f f6            	ld	a,(x)
3838  02a0 a108          	cp	a,#8
3839  02a2 2609          	jrne	L5541
3840                     ; 2761       pSocket->nParseLeft = 6;
3842  02a4 a606          	ld	a,#6
3843  02a6 e706          	ld	(6,x),a
3844                     ; 2762       pSocket->ParseState = PARSE_SLASH1;
3846  02a8 e70a          	ld	(10,x),a
3847                     ; 2764       pSocket->nState = STATE_PARSEGET;
3849  02aa a60d          	ld	a,#13
3850  02ac f7            	ld	(x),a
3851  02ad               L5541:
3852                     ; 2767     if (pSocket->nState == STATE_PARSEPOST) {
3854  02ad a10a          	cp	a,#10
3855  02af 2703cc078d    	jrne	L7541
3856  02b4               L1641:
3857                     ; 2781         if (pSocket->ParseState == PARSE_CMD) {
3859  02b4 1e0b          	ldw	x,(OFST+7,sp)
3860  02b6 e60a          	ld	a,(10,x)
3861  02b8 2664          	jrne	L5641
3862                     ; 2782           pSocket->ParseCmd = *pBuffer;
3864  02ba 1e05          	ldw	x,(OFST+1,sp)
3865  02bc f6            	ld	a,(x)
3866  02bd 1e0b          	ldw	x,(OFST+7,sp)
3867  02bf e708          	ld	(8,x),a
3868                     ; 2783 	  saved_postpartial[0] = *pBuffer;
3870  02c1 1e05          	ldw	x,(OFST+1,sp)
3871  02c3 f6            	ld	a,(x)
3872  02c4 c7002a        	ld	_saved_postpartial,a
3873                     ; 2784           pSocket->ParseState = saved_parsestate = PARSE_NUM10;
3875  02c7 a601          	ld	a,#1
3876  02c9 c70043        	ld	_saved_parsestate,a
3877  02cc 1e0b          	ldw	x,(OFST+7,sp)
3878  02ce e70a          	ld	(10,x),a
3879                     ; 2785 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3881  02d0 e606          	ld	a,(6,x)
3882  02d2 2704          	jreq	L7641
3883                     ; 2786 	    pSocket->nParseLeft--;
3885  02d4 6a06          	dec	(6,x)
3887  02d6 2004          	jra	L1741
3888  02d8               L7641:
3889                     ; 2790 	    pSocket->ParseState = PARSE_DELIM;
3891  02d8 a605          	ld	a,#5
3892  02da e70a          	ld	(10,x),a
3893  02dc               L1741:
3894                     ; 2792 	  saved_nparseleft = pSocket->nParseLeft;
3896  02dc e606          	ld	a,(6,x)
3897  02de c70042        	ld	_saved_nparseleft,a
3898                     ; 2793           pBuffer++;
3900  02e1 1e05          	ldw	x,(OFST+1,sp)
3901  02e3 5c            	incw	x
3902  02e4 1f05          	ldw	(OFST+1,sp),x
3903                     ; 2794 	  nBytes --;
3905  02e6 1e09          	ldw	x,(OFST+5,sp)
3906  02e8 5a            	decw	x
3907  02e9 1f09          	ldw	(OFST+5,sp),x
3908                     ; 2796 	  if (pSocket->ParseCmd == 'o' ||
3908                     ; 2797 	      pSocket->ParseCmd == 'a' ||
3908                     ; 2798 	      pSocket->ParseCmd == 'b' ||
3908                     ; 2799 	      pSocket->ParseCmd == 'c' ||
3908                     ; 2800 	      pSocket->ParseCmd == 'd' ||
3908                     ; 2801 	      pSocket->ParseCmd == 'g' ||
3908                     ; 2802 	      pSocket->ParseCmd == 'l' ||
3908                     ; 2803 	      pSocket->ParseCmd == 'm' ||
3908                     ; 2804 	      pSocket->ParseCmd == 'z') { }
3910  02eb 1e0b          	ldw	x,(OFST+7,sp)
3911  02ed e608          	ld	a,(8,x)
3912  02ef a16f          	cp	a,#111
3913  02f1 2724          	jreq	L5151
3915  02f3 a161          	cp	a,#97
3916  02f5 2720          	jreq	L5151
3918  02f7 a162          	cp	a,#98
3919  02f9 271c          	jreq	L5151
3921  02fb a163          	cp	a,#99
3922  02fd 2718          	jreq	L5151
3924  02ff a164          	cp	a,#100
3925  0301 2714          	jreq	L5151
3927  0303 a167          	cp	a,#103
3928  0305 2710          	jreq	L5151
3930  0307 a16c          	cp	a,#108
3931  0309 270c          	jreq	L5151
3933  030b a16d          	cp	a,#109
3934  030d 2708          	jreq	L5151
3936  030f a17a          	cp	a,#122
3937  0311 2704          	jreq	L5151
3938                     ; 2807 	    pSocket->ParseState = PARSE_DELIM;
3940  0313 a605          	ld	a,#5
3941  0315 e70a          	ld	(10,x),a
3942  0317               L5151:
3943                     ; 2809 	  if (nBytes == 0) { // Hit end of fragment. Break out of while()
3945  0317 1e09          	ldw	x,(OFST+5,sp)
3946  0319 2699          	jrne	L1641
3947                     ; 2811 	    break;
3949  031b cc0735        	jra	L3641
3950  031e               L5641:
3951                     ; 2815         else if (pSocket->ParseState == PARSE_NUM10) {
3953  031e a101          	cp	a,#1
3954  0320 2640          	jrne	L3251
3955                     ; 2816           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
3957  0322 1e05          	ldw	x,(OFST+1,sp)
3958  0324 f6            	ld	a,(x)
3959  0325 97            	ld	xl,a
3960  0326 a60a          	ld	a,#10
3961  0328 42            	mul	x,a
3962  0329 9f            	ld	a,xl
3963  032a 1e0b          	ldw	x,(OFST+7,sp)
3964  032c a0e0          	sub	a,#224
3965  032e e709          	ld	(9,x),a
3966                     ; 2817 	  saved_postpartial[1] = *pBuffer;
3968  0330 1e05          	ldw	x,(OFST+1,sp)
3969  0332 f6            	ld	a,(x)
3970  0333 c7002b        	ld	_saved_postpartial+1,a
3971                     ; 2818           pSocket->ParseState = saved_parsestate = PARSE_NUM1;
3973  0336 a602          	ld	a,#2
3974  0338 c70043        	ld	_saved_parsestate,a
3975  033b 1e0b          	ldw	x,(OFST+7,sp)
3976  033d e70a          	ld	(10,x),a
3977                     ; 2819 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3979  033f e606          	ld	a,(6,x)
3980  0341 2704          	jreq	L5251
3981                     ; 2820 	    pSocket->nParseLeft--;
3983  0343 6a06          	dec	(6,x)
3985  0345 2004          	jra	L7251
3986  0347               L5251:
3987                     ; 2824 	    pSocket->ParseState = PARSE_DELIM;
3989  0347 a605          	ld	a,#5
3990  0349 e70a          	ld	(10,x),a
3991  034b               L7251:
3992                     ; 2826 	  saved_nparseleft = pSocket->nParseLeft;
3994  034b e606          	ld	a,(6,x)
3995  034d c70042        	ld	_saved_nparseleft,a
3996                     ; 2827           pBuffer++;
3998  0350 1e05          	ldw	x,(OFST+1,sp)
3999  0352 5c            	incw	x
4000  0353 1f05          	ldw	(OFST+1,sp),x
4001                     ; 2828 	  nBytes--;
4003  0355 1e09          	ldw	x,(OFST+5,sp)
4004  0357 5a            	decw	x
4005  0358 1f09          	ldw	(OFST+5,sp),x
4006                     ; 2829 	  if (nBytes == 0) {
4008  035a 2703cc02b4    	jrne	L1641
4009                     ; 2831 	    break;
4011  035f cc0735        	jra	L3641
4012  0362               L3251:
4013                     ; 2835         else if (pSocket->ParseState == PARSE_NUM1) {
4015  0362 a102          	cp	a,#2
4016  0364 2638          	jrne	L5351
4017                     ; 2836           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
4019  0366 1605          	ldw	y,(OFST+1,sp)
4020  0368 90f6          	ld	a,(y)
4021  036a a030          	sub	a,#48
4022  036c eb09          	add	a,(9,x)
4023  036e e709          	ld	(9,x),a
4024                     ; 2837 	  saved_postpartial[2] = *pBuffer;
4026  0370 93            	ldw	x,y
4027  0371 f6            	ld	a,(x)
4028  0372 c7002c        	ld	_saved_postpartial+2,a
4029                     ; 2838           pSocket->ParseState = saved_parsestate = PARSE_EQUAL;
4031  0375 a603          	ld	a,#3
4032  0377 c70043        	ld	_saved_parsestate,a
4033  037a 1e0b          	ldw	x,(OFST+7,sp)
4034  037c e70a          	ld	(10,x),a
4035                     ; 2839 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
4037  037e e606          	ld	a,(6,x)
4038  0380 2704          	jreq	L7351
4039                     ; 2840 	    pSocket->nParseLeft--;
4041  0382 6a06          	dec	(6,x)
4043  0384 2004          	jra	L1451
4044  0386               L7351:
4045                     ; 2844 	    pSocket->ParseState = PARSE_DELIM;
4047  0386 a605          	ld	a,#5
4048  0388 e70a          	ld	(10,x),a
4049  038a               L1451:
4050                     ; 2846 	  saved_nparseleft = pSocket->nParseLeft;
4052  038a e606          	ld	a,(6,x)
4053  038c c70042        	ld	_saved_nparseleft,a
4054                     ; 2847           pBuffer++;
4056  038f 1e05          	ldw	x,(OFST+1,sp)
4057  0391 5c            	incw	x
4058  0392 1f05          	ldw	(OFST+1,sp),x
4059                     ; 2848 	  nBytes--;
4061  0394 1e09          	ldw	x,(OFST+5,sp)
4062  0396 5a            	decw	x
4063  0397 1f09          	ldw	(OFST+5,sp),x
4064                     ; 2849 	  if (nBytes == 0) {
4066  0399 26c1          	jrne	L1641
4067                     ; 2851 	    break;
4069  039b cc0735        	jra	L3641
4070  039e               L5351:
4071                     ; 2855         else if (pSocket->ParseState == PARSE_EQUAL) {
4073  039e a103          	cp	a,#3
4074  03a0 262f          	jrne	L7451
4075                     ; 2856           pSocket->ParseState = saved_parsestate = PARSE_VAL;
4077  03a2 a604          	ld	a,#4
4078  03a4 c70043        	ld	_saved_parsestate,a
4079  03a7 e70a          	ld	(10,x),a
4080                     ; 2857 	  saved_postpartial[3] = *pBuffer;
4082  03a9 1e05          	ldw	x,(OFST+1,sp)
4083  03ab f6            	ld	a,(x)
4084  03ac c7002d        	ld	_saved_postpartial+3,a
4085                     ; 2858 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
4087  03af 1e0b          	ldw	x,(OFST+7,sp)
4088  03b1 e606          	ld	a,(6,x)
4089  03b3 2704          	jreq	L1551
4090                     ; 2859 	    pSocket->nParseLeft--;
4092  03b5 6a06          	dec	(6,x)
4094  03b7 2004          	jra	L3551
4095  03b9               L1551:
4096                     ; 2863 	    pSocket->ParseState = PARSE_DELIM;
4098  03b9 a605          	ld	a,#5
4099  03bb e70a          	ld	(10,x),a
4100  03bd               L3551:
4101                     ; 2865 	  saved_nparseleft = pSocket->nParseLeft;
4103  03bd e606          	ld	a,(6,x)
4104  03bf c70042        	ld	_saved_nparseleft,a
4105                     ; 2866           pBuffer++;
4107  03c2 1e05          	ldw	x,(OFST+1,sp)
4108  03c4 5c            	incw	x
4109  03c5 1f05          	ldw	(OFST+1,sp),x
4110                     ; 2867 	  nBytes--;
4112  03c7 1e09          	ldw	x,(OFST+5,sp)
4113  03c9 5a            	decw	x
4114  03ca 1f09          	ldw	(OFST+5,sp),x
4115                     ; 2868 	  if (nBytes == 0) {
4117  03cc 268e          	jrne	L1641
4118                     ; 2870 	    break;
4120  03ce cc0735        	jra	L3641
4121  03d1               L7451:
4122                     ; 2874         else if (pSocket->ParseState == PARSE_VAL) {
4124  03d1 a104          	cp	a,#4
4125  03d3 2703cc0708    	jrne	L1651
4126                     ; 2887           if (pSocket->ParseCmd == 'o') {
4128  03d8 e608          	ld	a,(8,x)
4129  03da a16f          	cp	a,#111
4130  03dc 2640          	jrne	L3651
4131                     ; 2901               if ((uint8_t)(*pBuffer) == '1') pin_value = 1;
4133  03de 1e05          	ldw	x,(OFST+1,sp)
4134  03e0 f6            	ld	a,(x)
4135  03e1 a131          	cp	a,#49
4136  03e3 2604          	jrne	L5651
4139  03e5 a601          	ld	a,#1
4141  03e7 2001          	jra	L7651
4142  03e9               L5651:
4143                     ; 2902 	      else pin_value = 0;
4145  03e9 4f            	clr	a
4146  03ea               L7651:
4147  03ea 6b01          	ld	(OFST-3,sp),a
4149                     ; 2903 	      GpioSetPin(pSocket->ParseNum, (uint8_t)pin_value);
4151  03ec 160b          	ldw	y,(OFST+7,sp)
4152  03ee 97            	ld	xl,a
4153  03ef 90e609        	ld	a,(9,y)
4154  03f2 95            	ld	xh,a
4155  03f3 cd0000        	call	_GpioSetPin
4157                     ; 2905 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent
4159  03f6 1e0b          	ldw	x,(OFST+7,sp)
4160  03f8 e606          	ld	a,(6,x)
4161  03fa 2704          	jreq	L1751
4164  03fc 6a06          	dec	(6,x)
4165  03fe e606          	ld	a,(6,x)
4166  0400               L1751:
4167                     ; 2907             saved_nparseleft = pSocket->nParseLeft;
4169  0400 c70042        	ld	_saved_nparseleft,a
4170                     ; 2908             pBuffer++;
4172  0403 1e05          	ldw	x,(OFST+1,sp)
4173  0405 5c            	incw	x
4174  0406 1f05          	ldw	(OFST+1,sp),x
4175                     ; 2909 	    nBytes--;
4177  0408 1e09          	ldw	x,(OFST+5,sp)
4178  040a 5a            	decw	x
4179  040b 1f09          	ldw	(OFST+5,sp),x
4180                     ; 2910 	    if (nBytes == 0) {
4182  040d 2703cc06e6    	jrne	L5751
4183                     ; 2913 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4185  0412 a605          	ld	a,#5
4186  0414 c70043        	ld	_saved_parsestate,a
4187  0417 1e0b          	ldw	x,(OFST+7,sp)
4188  0419 e70a          	ld	(10,x),a
4189                     ; 2914 	      break;
4191  041b cc0735        	jra	L3641
4192  041e               L3651:
4193                     ; 2921           else if (pSocket->ParseCmd == 'a'
4193                     ; 2922                 || pSocket->ParseCmd == 'l'
4193                     ; 2923                 || pSocket->ParseCmd == 'm' ) {
4195  041e a161          	cp	a,#97
4196  0420 2708          	jreq	L1061
4198  0422 a16c          	cp	a,#108
4199  0424 2704          	jreq	L1061
4201  0426 a16d          	cp	a,#109
4202  0428 2657          	jrne	L7751
4203  042a               L1061:
4204                     ; 2927 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4206  042a 725f000a      	clr	_break_while
4207                     ; 2929             tmp_pBuffer = pBuffer;
4209  042e 1e05          	ldw	x,(OFST+1,sp)
4210  0430 cf000e        	ldw	_tmp_pBuffer,x
4211                     ; 2930             tmp_nBytes = nBytes;
4213  0433 1e09          	ldw	x,(OFST+5,sp)
4214  0435 cf000c        	ldw	_tmp_nBytes,x
4215                     ; 2931 	    tmp_nParseLeft = pSocket->nParseLeft;
4217  0438 1e0b          	ldw	x,(OFST+7,sp)
4218  043a e606          	ld	a,(6,x)
4219  043c c7000b        	ld	_tmp_nParseLeft,a
4220                     ; 2932             switch (pSocket->ParseCmd) {
4222  043f e608          	ld	a,(8,x)
4224                     ; 2935               case 'm': i = 10; break;
4225  0441 a061          	sub	a,#97
4226  0443 270b          	jreq	L3601
4227  0445 a00b          	sub	a,#11
4228  0447 270b          	jreq	L5601
4229  0449 4a            	dec	a
4230  044a 2708          	jreq	L5601
4231  044c 7b04          	ld	a,(OFST+0,sp)
4232  044e 2008          	jra	L7061
4233  0450               L3601:
4234                     ; 2933               case 'a': i = 19; break;
4236  0450 a613          	ld	a,#19
4239  0452 2002          	jp	LC018
4240  0454               L5601:
4241                     ; 2934               case 'l':
4241                     ; 2935               case 'm': i = 10; break;
4243  0454 a60a          	ld	a,#10
4244  0456               LC018:
4245  0456 6b04          	ld	(OFST+0,sp),a
4249  0458               L7061:
4250                     ; 2937             parse_POST_string(pSocket->ParseCmd, i);
4252  0458 160b          	ldw	y,(OFST+7,sp)
4253  045a 97            	ld	xl,a
4254  045b 90e608        	ld	a,(8,y)
4255  045e 95            	ld	xh,a
4256  045f cd0000        	call	_parse_POST_string
4258                     ; 2938             pBuffer = tmp_pBuffer;
4260  0462 ce000e        	ldw	x,_tmp_pBuffer
4261  0465 1f05          	ldw	(OFST+1,sp),x
4262                     ; 2939             nBytes = tmp_nBytes;
4264  0467 ce000c        	ldw	x,_tmp_nBytes
4265  046a 1f09          	ldw	(OFST+5,sp),x
4266                     ; 2940 	    pSocket->nParseLeft = tmp_nParseLeft;
4268  046c 1e0b          	ldw	x,(OFST+7,sp)
4269  046e c6000b        	ld	a,_tmp_nParseLeft
4270  0471 e706          	ld	(6,x),a
4271                     ; 2941             if (break_while == 1) {
4273  0473 c6000a        	ld	a,_break_while
4274  0476 4a            	dec	a
4275  0477 2696          	jrne	L5751
4276                     ; 2945 	      pSocket->ParseState = saved_parsestate;
4278  0479 c60043        	ld	a,_saved_parsestate
4279  047c e70a          	ld	(10,x),a
4280                     ; 2946 	      break;
4282  047e cc0735        	jra	L3641
4283  0481               L7751:
4284                     ; 2953           else if (pSocket->ParseCmd == 'b') {
4286  0481 a162          	cp	a,#98
4287  0483 2654          	jrne	L5161
4288                     ; 2961 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4290  0485 725f000a      	clr	_break_while
4291                     ; 2963             tmp_pBuffer = pBuffer;
4293  0489 1e05          	ldw	x,(OFST+1,sp)
4294  048b cf000e        	ldw	_tmp_pBuffer,x
4295                     ; 2964             tmp_nBytes = nBytes;
4297  048e 1e09          	ldw	x,(OFST+5,sp)
4298  0490 cf000c        	ldw	_tmp_nBytes,x
4299                     ; 2965 	    tmp_nParseLeft = pSocket->nParseLeft;
4301  0493 1e0b          	ldw	x,(OFST+7,sp)
4302  0495 e606          	ld	a,(6,x)
4303  0497 c7000b        	ld	_tmp_nParseLeft,a
4304                     ; 2966             parse_POST_address(pSocket->ParseCmd, pSocket->ParseNum);
4306  049a e609          	ld	a,(9,x)
4307  049c 160b          	ldw	y,(OFST+7,sp)
4308  049e 97            	ld	xl,a
4309  049f 90e608        	ld	a,(8,y)
4310  04a2 95            	ld	xh,a
4311  04a3 cd0000        	call	_parse_POST_address
4313                     ; 2967             pBuffer = tmp_pBuffer;
4315  04a6 ce000e        	ldw	x,_tmp_pBuffer
4316  04a9 1f05          	ldw	(OFST+1,sp),x
4317                     ; 2968             nBytes = tmp_nBytes;
4319  04ab ce000c        	ldw	x,_tmp_nBytes
4320  04ae 1f09          	ldw	(OFST+5,sp),x
4321                     ; 2969 	    pSocket->nParseLeft = tmp_nParseLeft;
4323  04b0 1e0b          	ldw	x,(OFST+7,sp)
4324  04b2 c6000b        	ld	a,_tmp_nParseLeft
4325  04b5 e706          	ld	(6,x),a
4326                     ; 2970             if (break_while == 1) {
4328  04b7 c6000a        	ld	a,_break_while
4329  04ba a101          	cp	a,#1
4330  04bc 260a          	jrne	L7161
4331                     ; 2974               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4333  04be a604          	ld	a,#4
4334  04c0 c70043        	ld	_saved_parsestate,a
4335  04c3 e70a          	ld	(10,x),a
4336                     ; 2975 	      break;
4338  04c5 cc0735        	jra	L3641
4339  04c8               L7161:
4340                     ; 2977             if (break_while == 2) {
4342  04c8 a102          	cp	a,#2
4343  04ca 2703cc06e6    	jrne	L5751
4344                     ; 2980               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4346  04cf a605          	ld	a,#5
4347  04d1 c70043        	ld	_saved_parsestate,a
4348  04d4 e70a          	ld	(10,x),a
4349                     ; 2981 	      break;
4351  04d6 cc0735        	jra	L3641
4352  04d9               L5161:
4353                     ; 2988           else if (pSocket->ParseCmd == 'c') {
4355  04d9 a163          	cp	a,#99
4356  04db 2651          	jrne	L5261
4357                     ; 2997 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4359  04dd 725f000a      	clr	_break_while
4360                     ; 2999             tmp_pBuffer = pBuffer;
4362  04e1 1e05          	ldw	x,(OFST+1,sp)
4363  04e3 cf000e        	ldw	_tmp_pBuffer,x
4364                     ; 3000             tmp_nBytes = nBytes;
4366  04e6 1e09          	ldw	x,(OFST+5,sp)
4367  04e8 cf000c        	ldw	_tmp_nBytes,x
4368                     ; 3001 	    tmp_nParseLeft = pSocket->nParseLeft;
4370  04eb 1e0b          	ldw	x,(OFST+7,sp)
4371  04ed e606          	ld	a,(6,x)
4372  04ef c7000b        	ld	_tmp_nParseLeft,a
4373                     ; 3002             parse_POST_port(pSocket->ParseCmd, pSocket->ParseNum);
4375  04f2 e609          	ld	a,(9,x)
4376  04f4 160b          	ldw	y,(OFST+7,sp)
4377  04f6 97            	ld	xl,a
4378  04f7 90e608        	ld	a,(8,y)
4379  04fa 95            	ld	xh,a
4380  04fb cd0000        	call	_parse_POST_port
4382                     ; 3003             pBuffer = tmp_pBuffer;
4384  04fe ce000e        	ldw	x,_tmp_pBuffer
4385  0501 1f05          	ldw	(OFST+1,sp),x
4386                     ; 3004             nBytes = tmp_nBytes;
4388  0503 ce000c        	ldw	x,_tmp_nBytes
4389  0506 1f09          	ldw	(OFST+5,sp),x
4390                     ; 3005 	    pSocket->nParseLeft = tmp_nParseLeft;
4392  0508 1e0b          	ldw	x,(OFST+7,sp)
4393  050a c6000b        	ld	a,_tmp_nParseLeft
4394  050d e706          	ld	(6,x),a
4395                     ; 3006             if (break_while == 1) {
4397  050f c6000a        	ld	a,_break_while
4398  0512 a101          	cp	a,#1
4399  0514 260a          	jrne	L7261
4400                     ; 3009               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4402  0516 a604          	ld	a,#4
4403  0518 c70043        	ld	_saved_parsestate,a
4404  051b e70a          	ld	(10,x),a
4405                     ; 3010 	      break;
4407  051d cc0735        	jra	L3641
4408  0520               L7261:
4409                     ; 3012             if (break_while == 2) {
4411  0520 a102          	cp	a,#2
4412  0522 26a8          	jrne	L5751
4413                     ; 3015               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4415  0524 a605          	ld	a,#5
4416  0526 c70043        	ld	_saved_parsestate,a
4417  0529 e70a          	ld	(10,x),a
4418                     ; 3016 	      break;
4420  052b cc0735        	jra	L3641
4421  052e               L5261:
4422                     ; 3023           else if (pSocket->ParseCmd == 'd') {
4424  052e a164          	cp	a,#100
4425  0530 2703cc05d0    	jrne	L5361
4426                     ; 3029 	    alpha[0] = '-';
4428  0535 352d0004      	mov	_alpha,#45
4429                     ; 3030 	    alpha[1] = '-';
4431  0539 352d0005      	mov	_alpha+1,#45
4432                     ; 3032 	    if (saved_postpartial_previous[0] == 'd') {
4434  053d c60012        	ld	a,_saved_postpartial_previous
4435  0540 a164          	cp	a,#100
4436  0542 261a          	jrne	L7361
4437                     ; 3036 	      saved_postpartial_previous[0] = '\0';
4439  0544 725f0012      	clr	_saved_postpartial_previous
4440                     ; 3042 	      if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
4442  0548 c60016        	ld	a,_saved_postpartial_previous+4
4443  054b 2705          	jreq	L1461
4446  054d 5500160004    	mov	_alpha,_saved_postpartial_previous+4
4447  0552               L1461:
4448                     ; 3043 	      if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
4450  0552 c60017        	ld	a,_saved_postpartial_previous+5
4451  0555 270a          	jreq	L5461
4454  0557 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
4455  055c 2003          	jra	L5461
4456  055e               L7361:
4457                     ; 3050               clear_saved_postpartial_data(); // Clear [4] and higher
4459  055e cd0000        	call	_clear_saved_postpartial_data
4461  0561               L5461:
4462                     ; 3053             if (alpha[0] == '-') {
4464  0561 c60004        	ld	a,_alpha
4465  0564 a12d          	cp	a,#45
4466  0566 261e          	jrne	L7461
4467                     ; 3054 	      alpha[0] = (uint8_t)(*pBuffer);
4469  0568 1e05          	ldw	x,(OFST+1,sp)
4470  056a f6            	ld	a,(x)
4471  056b c70004        	ld	_alpha,a
4472                     ; 3055               saved_postpartial[4] = *pBuffer;
4474  056e c7002e        	ld	_saved_postpartial+4,a
4475                     ; 3056               pSocket->nParseLeft--;
4477  0571 1e0b          	ldw	x,(OFST+7,sp)
4478  0573 6a06          	dec	(6,x)
4479                     ; 3057               saved_nparseleft = pSocket->nParseLeft;
4481  0575 e606          	ld	a,(6,x)
4482  0577 c70042        	ld	_saved_nparseleft,a
4483                     ; 3058               pBuffer++;
4485  057a 1e05          	ldw	x,(OFST+1,sp)
4486  057c 5c            	incw	x
4487  057d 1f05          	ldw	(OFST+1,sp),x
4488                     ; 3059 	      nBytes--;
4490  057f 1e09          	ldw	x,(OFST+5,sp)
4491  0581 5a            	decw	x
4492  0582 1f09          	ldw	(OFST+5,sp),x
4493                     ; 3060               if (nBytes == 0) break; // Hit end of fragment. Break out of
4495  0584 27a5          	jreq	L3641
4498  0586               L7461:
4499                     ; 3064             if (alpha[1] == '-') {
4501  0586 c60005        	ld	a,_alpha+1
4502  0589 a12d          	cp	a,#45
4503  058b 261c          	jrne	L3561
4504                     ; 3065 	      alpha[1] = (uint8_t)(*pBuffer);
4506  058d 1e05          	ldw	x,(OFST+1,sp)
4507  058f f6            	ld	a,(x)
4508  0590 c70005        	ld	_alpha+1,a
4509                     ; 3066               saved_postpartial[5] = *pBuffer;
4511  0593 c7002f        	ld	_saved_postpartial+5,a
4512                     ; 3067               pSocket->nParseLeft--;
4514  0596 1e0b          	ldw	x,(OFST+7,sp)
4515  0598 6a06          	dec	(6,x)
4516                     ; 3068               saved_nparseleft = pSocket->nParseLeft;
4518  059a e606          	ld	a,(6,x)
4519  059c c70042        	ld	_saved_nparseleft,a
4520                     ; 3069               pBuffer++;
4522  059f 1e05          	ldw	x,(OFST+1,sp)
4523  05a1 5c            	incw	x
4524  05a2 1f05          	ldw	(OFST+1,sp),x
4525                     ; 3070 	      nBytes--;
4527  05a4 1e09          	ldw	x,(OFST+5,sp)
4528  05a6 5a            	decw	x
4529  05a7 1f09          	ldw	(OFST+5,sp),x
4530  05a9               L3561:
4531                     ; 3076             clear_saved_postpartial_all();
4533  05a9 cd0000        	call	_clear_saved_postpartial_all
4535                     ; 3078             SetMAC(pSocket->ParseNum, alpha[0], alpha[1]);
4537  05ac 3b0005        	push	_alpha+1
4538  05af c60004        	ld	a,_alpha
4539  05b2 160c          	ldw	y,(OFST+8,sp)
4540  05b4 97            	ld	xl,a
4541  05b5 90e609        	ld	a,(9,y)
4542  05b8 95            	ld	xh,a
4543  05b9 cd0000        	call	_SetMAC
4545  05bc 84            	pop	a
4546                     ; 3080             if (nBytes == 0) {
4548  05bd 1e09          	ldw	x,(OFST+5,sp)
4549  05bf 2703cc06e6    	jrne	L5751
4550                     ; 3083 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4552  05c4 a605          	ld	a,#5
4553  05c6 c70043        	ld	_saved_parsestate,a
4554  05c9 1e0b          	ldw	x,(OFST+7,sp)
4555  05cb e70a          	ld	(10,x),a
4556                     ; 3084 	      break;
4558  05cd cc0735        	jra	L3641
4559  05d0               L5361:
4560                     ; 3091 	  else if (pSocket->ParseCmd == 'g') {
4562  05d0 a167          	cp	a,#103
4563  05d2 2703cc06d9    	jrne	L1661
4564                     ; 3102             for (i=0; i<6; i++) alpha[i] = '-';
4566  05d7 4f            	clr	a
4567  05d8 6b04          	ld	(OFST+0,sp),a
4569  05da               L3661:
4572  05da 5f            	clrw	x
4573  05db 97            	ld	xl,a
4574  05dc a62d          	ld	a,#45
4575  05de d70004        	ld	(_alpha,x),a
4578  05e1 0c04          	inc	(OFST+0,sp)
4582  05e3 7b04          	ld	a,(OFST+0,sp)
4583  05e5 a106          	cp	a,#6
4584  05e7 25f1          	jrult	L3661
4585                     ; 3104 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4587  05e9 725f000a      	clr	_break_while
4588                     ; 3107 	    if (saved_postpartial_previous[0] == 'g') {
4590  05ed c60012        	ld	a,_saved_postpartial_previous
4591  05f0 a167          	cp	a,#103
4592  05f2 2621          	jrne	L1761
4593                     ; 3111 	      saved_postpartial_previous[0] = '\0';
4595  05f4 725f0012      	clr	_saved_postpartial_previous
4596                     ; 3117               for (i=0; i<6; i++) {
4598  05f8 4f            	clr	a
4599  05f9 6b04          	ld	(OFST+0,sp),a
4601  05fb               L3761:
4602                     ; 3118                 if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
4604  05fb 5f            	clrw	x
4605  05fc 97            	ld	xl,a
4606  05fd 724d0016      	tnz	(_saved_postpartial_previous+4,x)
4607  0601 2708          	jreq	L1071
4610  0603 5f            	clrw	x
4611  0604 97            	ld	xl,a
4612  0605 d60016        	ld	a,(_saved_postpartial_previous+4,x)
4613  0608 d70004        	ld	(_alpha,x),a
4614  060b               L1071:
4615                     ; 3117               for (i=0; i<6; i++) {
4617  060b 0c04          	inc	(OFST+0,sp)
4621  060d 7b04          	ld	a,(OFST+0,sp)
4622  060f a106          	cp	a,#6
4623  0611 25e8          	jrult	L3761
4625  0613 2003          	jra	L3071
4626  0615               L1761:
4627                     ; 3126               clear_saved_postpartial_data(); // Clear [4] and higher
4629  0615 cd0000        	call	_clear_saved_postpartial_data
4631  0618               L3071:
4632                     ; 3129             for (i=0; i<6; i++) {
4634  0618 4f            	clr	a
4635  0619 6b04          	ld	(OFST+0,sp),a
4637  061b               L5071:
4638                     ; 3135               if (alpha[i] == '-') {
4640  061b 5f            	clrw	x
4641  061c 97            	ld	xl,a
4642  061d d60004        	ld	a,(_alpha,x)
4643  0620 a12d          	cp	a,#45
4644  0622 2636          	jrne	L3171
4645                     ; 3136 	        alpha[i] = (uint8_t)(*pBuffer);
4647  0624 7b04          	ld	a,(OFST+0,sp)
4648  0626 5f            	clrw	x
4649  0627 1605          	ldw	y,(OFST+1,sp)
4650  0629 97            	ld	xl,a
4651  062a 90f6          	ld	a,(y)
4652  062c d70004        	ld	(_alpha,x),a
4653                     ; 3137                 saved_postpartial[i+4] = *pBuffer;
4655  062f 5f            	clrw	x
4656  0630 7b04          	ld	a,(OFST+0,sp)
4657  0632 97            	ld	xl,a
4658  0633 90f6          	ld	a,(y)
4659  0635 d7002e        	ld	(_saved_postpartial+4,x),a
4660                     ; 3138                 pSocket->nParseLeft--;
4662  0638 1e0b          	ldw	x,(OFST+7,sp)
4663  063a 6a06          	dec	(6,x)
4664                     ; 3139                 saved_nparseleft = pSocket->nParseLeft;
4666  063c e606          	ld	a,(6,x)
4667  063e c70042        	ld	_saved_nparseleft,a
4668                     ; 3140                 pBuffer++;
4670  0641 93            	ldw	x,y
4671  0642 5c            	incw	x
4672  0643 1f05          	ldw	(OFST+1,sp),x
4673                     ; 3141 	        nBytes--;
4675  0645 1e09          	ldw	x,(OFST+5,sp)
4676  0647 5a            	decw	x
4677  0648 1f09          	ldw	(OFST+5,sp),x
4678                     ; 3142                 if (i != 5 && nBytes == 0) {
4680  064a 7b04          	ld	a,(OFST+0,sp)
4681  064c a105          	cp	a,#5
4682  064e 270a          	jreq	L3171
4684  0650 1e09          	ldw	x,(OFST+5,sp)
4685  0652 2606          	jrne	L3171
4686                     ; 3143 		  break_while = 1; // Hit end of fragment. Break out of
4688  0654 3501000a      	mov	_break_while,#1
4689                     ; 3145 		  break; // Break out of for() loop
4691  0658 2008          	jra	L1171
4692  065a               L3171:
4693                     ; 3129             for (i=0; i<6; i++) {
4695  065a 0c04          	inc	(OFST+0,sp)
4699  065c 7b04          	ld	a,(OFST+0,sp)
4700  065e a106          	cp	a,#6
4701  0660 25b9          	jrult	L5071
4702  0662               L1171:
4703                     ; 3149 	    if (break_while == 1) {
4705  0662 c6000a        	ld	a,_break_while
4706  0665 4a            	dec	a
4707  0666 2603cc0735    	jreq	L3641
4708                     ; 3151 	      break;
4710                     ; 3157             clear_saved_postpartial_all();
4712  066b cd0000        	call	_clear_saved_postpartial_all
4714                     ; 3160 	    if (alpha[0] != '0' && alpha[0] != '1') alpha[0] = '0';
4716  066e c60004        	ld	a,_alpha
4717  0671 a130          	cp	a,#48
4718  0673 2708          	jreq	L1271
4720  0675 a131          	cp	a,#49
4721  0677 2704          	jreq	L1271
4724  0679 35300004      	mov	_alpha,#48
4725  067d               L1271:
4726                     ; 3161 	    if (alpha[1] != '0' && alpha[1] != '1') alpha[1] = '0';
4728  067d c60005        	ld	a,_alpha+1
4729  0680 a130          	cp	a,#48
4730  0682 2708          	jreq	L3271
4732  0684 a131          	cp	a,#49
4733  0686 2704          	jreq	L3271
4736  0688 35300005      	mov	_alpha+1,#48
4737  068c               L3271:
4738                     ; 3162 	    if (alpha[2] != '0' && alpha[2] != '1' && alpha[2] != '2') alpha[2] = '2';
4740  068c c60006        	ld	a,_alpha+2
4741  068f a130          	cp	a,#48
4742  0691 270c          	jreq	L5271
4744  0693 a131          	cp	a,#49
4745  0695 2708          	jreq	L5271
4747  0697 a132          	cp	a,#50
4748  0699 2704          	jreq	L5271
4751  069b 35320006      	mov	_alpha+2,#50
4752  069f               L5271:
4753                     ; 3163 	    if (alpha[3] != '0' && alpha[3] != '1') alpha[3] = '0';
4755  069f c60007        	ld	a,_alpha+3
4756  06a2 a130          	cp	a,#48
4757  06a4 2708          	jreq	L7271
4759  06a6 a131          	cp	a,#49
4760  06a8 2704          	jreq	L7271
4763  06aa 35300007      	mov	_alpha+3,#48
4764  06ae               L7271:
4765                     ; 3165 	    Pending_config_settings[0] = (uint8_t)alpha[0];
4767  06ae 5500040000    	mov	_Pending_config_settings,_alpha
4768                     ; 3166             Pending_config_settings[1] = (uint8_t)alpha[1];
4770  06b3 5500050001    	mov	_Pending_config_settings+1,_alpha+1
4771                     ; 3167             Pending_config_settings[2] = (uint8_t)alpha[2];
4773  06b8 5500060002    	mov	_Pending_config_settings+2,_alpha+2
4774                     ; 3168             Pending_config_settings[3] = (uint8_t)alpha[3];
4776  06bd 5500070003    	mov	_Pending_config_settings+3,_alpha+3
4777                     ; 3169             Pending_config_settings[4] = '0';
4779  06c2 35300004      	mov	_Pending_config_settings+4,#48
4780                     ; 3170             Pending_config_settings[5] = '0';
4782  06c6 35300005      	mov	_Pending_config_settings+5,#48
4783                     ; 3172             if (nBytes == 0) {
4785  06ca 1e09          	ldw	x,(OFST+5,sp)
4786  06cc 2618          	jrne	L5751
4787                     ; 3175 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4789  06ce a605          	ld	a,#5
4790  06d0 c70043        	ld	_saved_parsestate,a
4791  06d3 1e0b          	ldw	x,(OFST+7,sp)
4792  06d5 e70a          	ld	(10,x),a
4793                     ; 3176 	      break;
4795  06d7 205c          	jra	L3641
4796  06d9               L1661:
4797                     ; 3183 	  else if (pSocket->ParseCmd == 'z') {
4799  06d9 a17a          	cp	a,#122
4800  06db 2609          	jrne	L5751
4801                     ; 3208 	    nBytes = 0;
4803  06dd 5f            	clrw	x
4804  06de 1f09          	ldw	(OFST+5,sp),x
4805                     ; 3209 	    pSocket->nParseLeft = 0;
4807  06e0 1e0b          	ldw	x,(OFST+7,sp)
4808  06e2 6f06          	clr	(6,x)
4809                     ; 3210             break; // Break out of the while loop. We're done with POST.
4811  06e4 204f          	jra	L3641
4812  06e6               L5751:
4813                     ; 3221           pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4815  06e6 a605          	ld	a,#5
4816  06e8 c70043        	ld	_saved_parsestate,a
4817  06eb 1e0b          	ldw	x,(OFST+7,sp)
4818  06ed e70a          	ld	(10,x),a
4819                     ; 3223           if (pSocket->nParseLeft < 30) {
4821  06ef e606          	ld	a,(6,x)
4822  06f1 a11e          	cp	a,#30
4823  06f3 2503cc02b4    	jruge	L1641
4824                     ; 3238 	    if (pSocket->nParseLeftAddl > 0) {
4826  06f8 6d07          	tnz	(7,x)
4827  06fa 27f9          	jreq	L1641
4828                     ; 3239 	      pSocket->nParseLeft += pSocket->nParseLeftAddl;
4830  06fc eb07          	add	a,(7,x)
4831  06fe e706          	ld	(6,x),a
4832                     ; 3240 	      pSocket->nParseLeftAddl = 0;
4834  0700 6f07          	clr	(7,x)
4835                     ; 3241 	      saved_nparseleft = pSocket->nParseLeft;
4837  0702 c70042        	ld	_saved_nparseleft,a
4838  0705 cc02b4        	jra	L1641
4839  0708               L1651:
4840                     ; 3246         else if (pSocket->ParseState == PARSE_DELIM) {
4842  0708 a105          	cp	a,#5
4843  070a 26f9          	jrne	L1641
4844                     ; 3247           if (pSocket->nParseLeft > 0) {
4846  070c e606          	ld	a,(6,x)
4847  070e 2720          	jreq	L7471
4848                     ; 3250             pSocket->ParseState = saved_parsestate = PARSE_CMD;
4850  0710 725f0043      	clr	_saved_parsestate
4851  0714 6f0a          	clr	(10,x)
4852                     ; 3251             pSocket->nParseLeft--;
4854  0716 6a06          	dec	(6,x)
4855                     ; 3252             saved_nparseleft = pSocket->nParseLeft;
4857  0718 e606          	ld	a,(6,x)
4858  071a c70042        	ld	_saved_nparseleft,a
4859                     ; 3253             pBuffer++;
4861  071d 1e05          	ldw	x,(OFST+1,sp)
4862  071f 5c            	incw	x
4863  0720 1f05          	ldw	(OFST+1,sp),x
4864                     ; 3254 	    nBytes--;
4866  0722 1e09          	ldw	x,(OFST+5,sp)
4867  0724 5a            	decw	x
4868  0725 1f09          	ldw	(OFST+5,sp),x
4869                     ; 3256 	    clear_saved_postpartial_all();
4871  0727 cd0000        	call	_clear_saved_postpartial_all
4873                     ; 3260             if (nBytes == 0) {
4875  072a 1e09          	ldw	x,(OFST+5,sp)
4876  072c 26d7          	jrne	L1641
4877                     ; 3261 	      break; // Hit end of fragment but still have more to parse in
4879  072e 2005          	jra	L3641
4880  0730               L7471:
4881                     ; 3271             pSocket->nParseLeft = 0; // End the parsing
4883  0730 e706          	ld	(6,x),a
4884                     ; 3272 	    nBytes = 0;
4886  0732 5f            	clrw	x
4887  0733 1f09          	ldw	(OFST+5,sp),x
4888                     ; 3273 	    break; // Exit parsing
4889  0735               L3641:
4890                     ; 3300       if (pSocket->nParseLeft == 0) {
4892  0735 1e0b          	ldw	x,(OFST+7,sp)
4893  0737 e606          	ld	a,(6,x)
4894  0739 264e          	jrne	L5571
4895                     ; 3303 	saved_nstate = STATE_NULL;
4897  073b 357f0044      	mov	_saved_nstate,#127
4898                     ; 3304 	saved_parsestate = PARSE_CMD;
4900  073f c70043        	ld	_saved_parsestate,a
4901                     ; 3305         saved_nparseleft = 0;
4903  0742 c70042        	ld	_saved_nparseleft,a
4904                     ; 3306         saved_newlines = 0;
4906  0745 c70011        	ld	_saved_newlines,a
4907                     ; 3307 	for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i] = '\0';
4909  0748 6b04          	ld	(OFST+0,sp),a
4911  074a               L7571:
4914  074a 5f            	clrw	x
4915  074b 97            	ld	xl,a
4916  074c 724f002a      	clr	(_saved_postpartial,x)
4917  0750 5f            	clrw	x
4918  0751 97            	ld	xl,a
4919  0752 724f0012      	clr	(_saved_postpartial_previous,x)
4922  0756 0c04          	inc	(OFST+0,sp)
4926  0758 7b04          	ld	a,(OFST+0,sp)
4927  075a a118          	cp	a,#24
4928  075c 25ec          	jrult	L7571
4929                     ; 3313 	parse_complete = 1;
4931  075e 35010000      	mov	_parse_complete,#1
4932                     ; 3314 	pSocket->nState = STATE_SENDHEADER;
4934  0762 1e0b          	ldw	x,(OFST+7,sp)
4935  0764 a60b          	ld	a,#11
4936  0766 f7            	ld	(x),a
4937                     ; 3326         if (current_webpage == WEBPAGE_IOCONTROL) {
4939  0767 c60003        	ld	a,_current_webpage
4940  076a 260c          	jrne	L5671
4941                     ; 3327           pSocket->pData = g_HtmlPageIOControl;
4943  076c 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4944  0770 ef01          	ldw	(1,x),y
4945                     ; 3328           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4947  0772 90ae0c06      	ldw	y,#3078
4948  0776 ef03          	ldw	(3,x),y
4949  0778               L5671:
4950                     ; 3330         if (current_webpage == WEBPAGE_CONFIGURATION) {
4952  0778 4a            	dec	a
4953  0779 2612          	jrne	L7541
4954                     ; 3331           pSocket->pData = g_HtmlPageConfiguration;
4956  077b 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
4957  077f ef01          	ldw	(1,x),y
4958                     ; 3332           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
4960  0781 90ae0c5c      	ldw	y,#3164
4961  0785 ef03          	ldw	(3,x),y
4962  0787 2004          	jra	L7541
4963  0789               L5571:
4964                     ; 3352 	uip_len = 0;
4966  0789 5f            	clrw	x
4967  078a cf0000        	ldw	_uip_len,x
4968  078d               L7541:
4969                     ; 3356     if (pSocket->nState == STATE_PARSEGET) {
4971  078d 1e0b          	ldw	x,(OFST+7,sp)
4972  078f f6            	ld	a,(x)
4973  0790 a10d          	cp	a,#13
4974  0792 2703cc09c4    	jrne	L3771
4976  0797 cc09bd        	jra	L7771
4977  079a               L5771:
4978                     ; 3385         if (pSocket->ParseState == PARSE_SLASH1) {
4980  079a 1e0b          	ldw	x,(OFST+7,sp)
4981  079c e60a          	ld	a,(10,x)
4982  079e a106          	cp	a,#6
4983  07a0 263c          	jrne	L3002
4984                     ; 3388           pSocket->ParseCmd = *pBuffer;
4986  07a2 1e05          	ldw	x,(OFST+1,sp)
4987  07a4 f6            	ld	a,(x)
4988  07a5 1e0b          	ldw	x,(OFST+7,sp)
4989  07a7 e708          	ld	(8,x),a
4990                     ; 3389           pSocket->nParseLeft--;
4992  07a9 6a06          	dec	(6,x)
4993                     ; 3390           pBuffer++;
4995  07ab 1e05          	ldw	x,(OFST+1,sp)
4996  07ad 5c            	incw	x
4997  07ae 1f05          	ldw	(OFST+1,sp),x
4998                     ; 3391 	  nBytes--;
5000  07b0 1e09          	ldw	x,(OFST+5,sp)
5001  07b2 5a            	decw	x
5002  07b3 1f09          	ldw	(OFST+5,sp),x
5003                     ; 3392 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5005  07b5 1e0b          	ldw	x,(OFST+7,sp)
5006  07b7 e608          	ld	a,(8,x)
5007  07b9 a12f          	cp	a,#47
5008  07bb 2605          	jrne	L5002
5009                     ; 3393 	    pSocket->ParseState = PARSE_NUM10;
5011  07bd a601          	ld	a,#1
5013  07bf cc0858        	jp	LC022
5014  07c2               L5002:
5015                     ; 3397 	    current_webpage = WEBPAGE_IOCONTROL;
5017  07c2 725f0003      	clr	_current_webpage
5018                     ; 3398             pSocket->pData = g_HtmlPageIOControl;
5020  07c6 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5021  07ca ef01          	ldw	(1,x),y
5022                     ; 3399             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5024  07cc 90ae0c06      	ldw	y,#3078
5025  07d0 ef03          	ldw	(3,x),y
5026                     ; 3400             pSocket->nParseLeft = 0; // This will cause the while() to exit
5028  07d2 6f06          	clr	(6,x)
5029                     ; 3402             pSocket->nState = STATE_CONNECTED;
5031  07d4 7f            	clr	(x)
5032                     ; 3403             pSocket->nPrevBytes = 0xFFFF;
5034  07d5 90aeffff      	ldw	y,#65535
5035  07d9 ef0b          	ldw	(11,x),y
5036  07db cc09ac        	jra	L1102
5037  07de               L3002:
5038                     ; 3407         else if (pSocket->ParseState == PARSE_NUM10) {
5040  07de a101          	cp	a,#1
5041  07e0 2640          	jrne	L3102
5042                     ; 3412 	  if (*pBuffer == ' ') {
5044  07e2 1e05          	ldw	x,(OFST+1,sp)
5045  07e4 f6            	ld	a,(x)
5046  07e5 a120          	cp	a,#32
5047  07e7 261e          	jrne	L5102
5048                     ; 3413 	    current_webpage = WEBPAGE_IOCONTROL;
5050  07e9 725f0003      	clr	_current_webpage
5051                     ; 3414             pSocket->pData = g_HtmlPageIOControl;
5053  07ed 1e0b          	ldw	x,(OFST+7,sp)
5054  07ef 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5055  07f3 ef01          	ldw	(1,x),y
5056                     ; 3415             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5058  07f5 90ae0c06      	ldw	y,#3078
5059  07f9 ef03          	ldw	(3,x),y
5060                     ; 3416             pSocket->nParseLeft = 0;
5062  07fb 6f06          	clr	(6,x)
5063                     ; 3418             pSocket->nState = STATE_CONNECTED;
5065  07fd 7f            	clr	(x)
5066                     ; 3419             pSocket->nPrevBytes = 0xFFFF;
5068  07fe 90aeffff      	ldw	y,#65535
5069  0802 ef0b          	ldw	(11,x),y
5071  0804 cc09ac        	jra	L1102
5072  0807               L5102:
5073                     ; 3423 	  else if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
5075  0807 a130          	cp	a,#48
5076  0809 2547          	jrult	L1302
5078  080b a13a          	cp	a,#58
5079  080d 2443          	jruge	L1302
5080                     ; 3425             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5082  080f 97            	ld	xl,a
5083  0810 a60a          	ld	a,#10
5084  0812 42            	mul	x,a
5085  0813 9f            	ld	a,xl
5086  0814 1e0b          	ldw	x,(OFST+7,sp)
5087  0816 a0e0          	sub	a,#224
5088  0818 e709          	ld	(9,x),a
5089                     ; 3426 	    pSocket->ParseState = PARSE_NUM1;
5091  081a a602          	ld	a,#2
5092  081c e70a          	ld	(10,x),a
5093                     ; 3427             pSocket->nParseLeft--;
5095  081e 6a06          	dec	(6,x)
5096                     ; 3428             pBuffer++;
5097                     ; 3429 	    nBytes--;
5099  0820 2023          	jp	LC024
5100                     ; 3434             pSocket->nParseLeft = 0;
5101                     ; 3435             pSocket->ParseState = PARSE_FAIL;
5102  0822               L3102:
5103                     ; 3440         else if (pSocket->ParseState == PARSE_NUM1) {
5105  0822 a102          	cp	a,#2
5106  0824 2637          	jrne	L7202
5107                     ; 3441 	  if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
5109  0826 1e05          	ldw	x,(OFST+1,sp)
5110  0828 f6            	ld	a,(x)
5111  0829 a130          	cp	a,#48
5112  082b 2525          	jrult	L1302
5114  082d a13a          	cp	a,#58
5115  082f 2421          	jruge	L1302
5116                     ; 3443             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5118  0831 1605          	ldw	y,(OFST+1,sp)
5119  0833 1e0b          	ldw	x,(OFST+7,sp)
5120  0835 90f6          	ld	a,(y)
5121  0837 a030          	sub	a,#48
5122  0839 eb09          	add	a,(9,x)
5123  083b e709          	ld	(9,x),a
5124                     ; 3444             pSocket->ParseState = PARSE_VAL;
5126  083d a604          	ld	a,#4
5127  083f e70a          	ld	(10,x),a
5128                     ; 3445             pSocket->nParseLeft = 1; // Set to 1 so PARSE_VAL will be called
5130  0841 a601          	ld	a,#1
5131  0843 e706          	ld	(6,x),a
5132                     ; 3446             pBuffer++;
5134                     ; 3447 	    nBytes--;
5136  0845               LC024:
5138  0845 1e05          	ldw	x,(OFST+1,sp)
5139  0847 5c            	incw	x
5140  0848 1f05          	ldw	(OFST+1,sp),x
5142  084a 1e09          	ldw	x,(OFST+5,sp)
5143  084c 5a            	decw	x
5144  084d 1f09          	ldw	(OFST+5,sp),x
5146  084f cc09ac        	jra	L1102
5147  0852               L1302:
5148                     ; 3452             pSocket->nParseLeft = 0;
5150                     ; 3453             pSocket->ParseState = PARSE_FAIL;
5153  0852 1e0b          	ldw	x,(OFST+7,sp)
5155  0854 a607          	ld	a,#7
5156  0856 6f06          	clr	(6,x)
5157  0858               LC022:
5158  0858 e70a          	ld	(10,x),a
5159  085a cc09ac        	jra	L1102
5160  085d               L7202:
5161                     ; 3457         else if (pSocket->ParseState == PARSE_VAL) {
5163  085d a104          	cp	a,#4
5164  085f 26f9          	jrne	L1102
5165                     ; 3523           switch(pSocket->ParseNum)
5167  0861 e609          	ld	a,(9,x)
5169                     ; 3698 	      break;
5170  0863 a110          	cp	a,#16
5171  0865 2407          	jruge	L222
5172  0867 5f            	clrw	x
5173  0868 97            	ld	xl,a
5174  0869 58            	sllw	x
5175  086a de1ce0        	ldw	x,(L422,x)
5176  086d fc            	jp	(x)
5177  086e               L222:
5178  086e a037          	sub	a,#55
5179  0870 2603cc091c    	jreq	L7211
5180  0875 4a            	dec	a
5181  0876 2603cc0923    	jreq	L1311
5182  087b a004          	sub	a,#4
5183  087d 2603cc0929    	jreq	L3311
5184  0882 4a            	dec	a
5185  0883 2603cc0938    	jreq	L5311
5186  0888 a004          	sub	a,#4
5187  088a 2603cc0948    	jreq	L7311
5188  088f 4a            	dec	a
5189  0890 2603cc0953    	jreq	L1411
5190  0895 4a            	dec	a
5191  0896 2603cc0966    	jreq	L3411
5192  089b a018          	sub	a,#24
5193  089d 2603cc097b    	jreq	L5411
5194  08a2 a008          	sub	a,#8
5195  08a4 2603cc0981    	jreq	L7411
5196  08a9 cc0991        	jra	L1511
5197  08ac               L7601:
5198                     ; 3571 	    case 0:  IO_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
5200  08ac 72110000      	bres	_IO_8to1,#0
5203  08b0 cc09a8        	jra	L3402
5204  08b3               L1701:
5205                     ; 3572 	    case 1:  IO_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
5207  08b3 72100000      	bset	_IO_8to1,#0
5210  08b7 cc09a8        	jra	L3402
5211  08ba               L3701:
5212                     ; 3573 	    case 2:  IO_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
5214  08ba 72130000      	bres	_IO_8to1,#1
5217  08be cc09a8        	jra	L3402
5218  08c1               L5701:
5219                     ; 3574 	    case 3:  IO_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
5221  08c1 72120000      	bset	_IO_8to1,#1
5224  08c5 cc09a8        	jra	L3402
5225  08c8               L7701:
5226                     ; 3575 	    case 4:  IO_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
5228  08c8 72150000      	bres	_IO_8to1,#2
5231  08cc cc09a8        	jra	L3402
5232  08cf               L1011:
5233                     ; 3576 	    case 5:  IO_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
5235  08cf 72140000      	bset	_IO_8to1,#2
5238  08d3 cc09a8        	jra	L3402
5239  08d6               L3011:
5240                     ; 3577 	    case 6:  IO_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
5242  08d6 72170000      	bres	_IO_8to1,#3
5245  08da cc09a8        	jra	L3402
5246  08dd               L5011:
5247                     ; 3578 	    case 7:  IO_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
5249  08dd 72160000      	bset	_IO_8to1,#3
5252  08e1 cc09a8        	jra	L3402
5253  08e4               L7011:
5254                     ; 3579 	    case 8:  IO_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
5256  08e4 72190000      	bres	_IO_8to1,#4
5259  08e8 cc09a8        	jra	L3402
5260  08eb               L1111:
5261                     ; 3580 	    case 9:  IO_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
5263  08eb 72180000      	bset	_IO_8to1,#4
5266  08ef cc09a8        	jra	L3402
5267  08f2               L3111:
5268                     ; 3581 	    case 10: IO_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
5270  08f2 721b0000      	bres	_IO_8to1,#5
5273  08f6 cc09a8        	jra	L3402
5274  08f9               L5111:
5275                     ; 3582 	    case 11: IO_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
5277  08f9 721a0000      	bset	_IO_8to1,#5
5280  08fd cc09a8        	jra	L3402
5281  0900               L7111:
5282                     ; 3583 	    case 12: IO_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
5284  0900 721d0000      	bres	_IO_8to1,#6
5287  0904 cc09a8        	jra	L3402
5288  0907               L1211:
5289                     ; 3584 	    case 13: IO_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
5291  0907 721c0000      	bset	_IO_8to1,#6
5294  090b cc09a8        	jra	L3402
5295  090e               L3211:
5296                     ; 3585 	    case 14: IO_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
5298  090e 721f0000      	bres	_IO_8to1,#7
5301  0912 cc09a8        	jra	L3402
5302  0915               L5211:
5303                     ; 3586 	    case 15: IO_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
5305  0915 721e0000      	bset	_IO_8to1,#7
5308  0919 cc09a8        	jra	L3402
5309  091c               L7211:
5310                     ; 3588 	    case 55:
5310                     ; 3589   	      IO_8to1 = (uint8_t)0xff; // Relays 1-8 ON
5312  091c 35ff0000      	mov	_IO_8to1,#255
5313                     ; 3590 	      break;
5315  0920 cc09a8        	jra	L3402
5316  0923               L1311:
5317                     ; 3592 	    case 56:
5317                     ; 3593               IO_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
5319  0923 c70000        	ld	_IO_8to1,a
5320                     ; 3594 	      break;
5322  0926 cc09a8        	jra	L3402
5323  0929               L3311:
5324                     ; 3601 	    case 60: // Show IO Control page
5324                     ; 3602 	      current_webpage = WEBPAGE_IOCONTROL;
5326  0929 c70003        	ld	_current_webpage,a
5327                     ; 3603               pSocket->pData = g_HtmlPageIOControl;
5329  092c 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5330  0930 ef01          	ldw	(1,x),y
5331                     ; 3604               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5333  0932 90ae0c06      	ldw	y,#3078
5334                     ; 3605               pSocket->nState = STATE_CONNECTED;
5335                     ; 3606               pSocket->nPrevBytes = 0xFFFF;
5336                     ; 3607 	      break;
5338  0936 2029          	jp	LC021
5339  0938               L5311:
5340                     ; 3609 	    case 61: // Show Configuration page
5340                     ; 3610 	      current_webpage = WEBPAGE_CONFIGURATION;
5342  0938 35010003      	mov	_current_webpage,#1
5343                     ; 3611               pSocket->pData = g_HtmlPageConfiguration;
5345  093c 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
5346  0940 ef01          	ldw	(1,x),y
5347                     ; 3612               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
5349  0942 90ae0c5c      	ldw	y,#3164
5350                     ; 3613               pSocket->nState = STATE_CONNECTED;
5351                     ; 3614               pSocket->nPrevBytes = 0xFFFF;
5352                     ; 3615 	      break;
5354  0946 2019          	jp	LC021
5355  0948               L7311:
5356                     ; 3635 	    case 65: // Flash LED for diagnostics
5356                     ; 3636 	      // XXXXXXXXXXXXXXXXXXXXXX
5356                     ; 3637 	      // XXXXXXXXXXXXXXXXXXXXXX
5356                     ; 3638 	      // XXXXXXXXXXXXXXXXXXXXXX
5356                     ; 3639 	      debugflash();
5358  0948 cd0000        	call	_debugflash
5360                     ; 3640 	      debugflash();
5362  094b cd0000        	call	_debugflash
5364                     ; 3641 	      debugflash();
5366  094e cd0000        	call	_debugflash
5368                     ; 3645 	      break;
5370  0951 2055          	jra	L3402
5371  0953               L1411:
5372                     ; 3648             case 66: // Show statistics page
5372                     ; 3649 	      current_webpage = WEBPAGE_STATS;
5374  0953 35050003      	mov	_current_webpage,#5
5375                     ; 3650               pSocket->pData = g_HtmlPageStats;
5377  0957 90ae186c      	ldw	y,#L71_g_HtmlPageStats
5378  095b ef01          	ldw	(1,x),y
5379                     ; 3651               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
5381  095d 90ae0150      	ldw	y,#336
5382                     ; 3652               pSocket->nState = STATE_CONNECTED;
5384  0961               LC021:
5385  0961 ef03          	ldw	(3,x),y
5389  0963 f7            	ld	(x),a
5390                     ; 3653               pSocket->nPrevBytes = 0xFFFF;
5391                     ; 3654 	      break;
5393  0964 203c          	jp	LC019
5394  0966               L3411:
5395                     ; 3656             case 67: // Clear statistics
5395                     ; 3657 	      uip_init_stats();
5397  0966 cd0000        	call	_uip_init_stats
5399                     ; 3672 	      current_webpage = WEBPAGE_STATS;
5401  0969 35050003      	mov	_current_webpage,#5
5402                     ; 3673               pSocket->pData = g_HtmlPageStats;
5404  096d 1e0b          	ldw	x,(OFST+7,sp)
5405  096f 90ae186c      	ldw	y,#L71_g_HtmlPageStats
5406  0973 ef01          	ldw	(1,x),y
5407                     ; 3674               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
5409  0975 90ae0150      	ldw	y,#336
5410                     ; 3675               pSocket->nState = STATE_CONNECTED;
5411                     ; 3676               pSocket->nPrevBytes = 0xFFFF;
5412                     ; 3677 	      break;
5414  0979 2024          	jp	LC020
5415  097b               L5411:
5416                     ; 3680 	    case 91: // Reboot
5416                     ; 3681 	      user_reboot_request = 1;
5418  097b 35010000      	mov	_user_reboot_request,#1
5419                     ; 3682 	      break;
5421  097f 2027          	jra	L3402
5422  0981               L7411:
5423                     ; 3684             case 99: // Show simplified IO state page
5423                     ; 3685 	      current_webpage = WEBPAGE_RSTATE;
5425  0981 35060003      	mov	_current_webpage,#6
5426                     ; 3686               pSocket->pData = g_HtmlPageRstate;
5428  0985 90ae19bd      	ldw	y,#L12_g_HtmlPageRstate
5429  0989 ef01          	ldw	(1,x),y
5430                     ; 3687               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
5432  098b 90ae0087      	ldw	y,#135
5433                     ; 3688               pSocket->nState = STATE_CONNECTED;
5434                     ; 3689               pSocket->nPrevBytes = 0xFFFF;
5435                     ; 3690 	      break;
5437  098f 20d0          	jp	LC021
5438  0991               L1511:
5439                     ; 3692 	    default: // Show IO Control page
5439                     ; 3693 	      current_webpage = WEBPAGE_IOCONTROL;
5441  0991 725f0003      	clr	_current_webpage
5442                     ; 3694               pSocket->pData = g_HtmlPageIOControl;
5444  0995 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5445  0999 ef01          	ldw	(1,x),y
5446                     ; 3695               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5448  099b 90ae0c06      	ldw	y,#3078
5449                     ; 3696               pSocket->nState = STATE_CONNECTED;
5451  099f               LC020:
5452  099f ef03          	ldw	(3,x),y
5454  09a1 7f            	clr	(x)
5455                     ; 3697               pSocket->nPrevBytes = 0xFFFF;
5457  09a2               LC019:
5463  09a2 90aeffff      	ldw	y,#65535
5464  09a6 ef0b          	ldw	(11,x),y
5465                     ; 3698 	      break;
5467  09a8               L3402:
5468                     ; 3700           pSocket->nParseLeft = 0;
5470  09a8 1e0b          	ldw	x,(OFST+7,sp)
5471  09aa 6f06          	clr	(6,x)
5472  09ac               L1102:
5473                     ; 3703         if (pSocket->ParseState == PARSE_FAIL) {
5475  09ac 1e0b          	ldw	x,(OFST+7,sp)
5476  09ae e60a          	ld	a,(10,x)
5477  09b0 a107          	cp	a,#7
5478                     ; 3708           pSocket->nState = STATE_SENDHEADER;
5479                     ; 3709 	  break;
5481  09b2 2704          	jreq	LC025
5482                     ; 3712         if (pSocket->nParseLeft == 0) {
5484  09b4 e606          	ld	a,(6,x)
5485  09b6 2605          	jrne	L7771
5486                     ; 3715           pSocket->nState = STATE_SENDHEADER;
5488  09b8               LC025:
5490  09b8 a60b          	ld	a,#11
5491  09ba f7            	ld	(x),a
5492                     ; 3716           break;
5494  09bb 2007          	jra	L3771
5495  09bd               L7771:
5496                     ; 3384       while (nBytes != 0) {
5498  09bd 1e09          	ldw	x,(OFST+5,sp)
5499  09bf 2703cc079a    	jrne	L5771
5500  09c4               L3771:
5501                     ; 3721     if (pSocket->nState == STATE_SENDHEADER) {
5503  09c4 1e0b          	ldw	x,(OFST+7,sp)
5504  09c6 f6            	ld	a,(x)
5505  09c7 a10b          	cp	a,#11
5506  09c9 261c          	jrne	L3511
5507                     ; 3727       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5509  09cb cd0000        	call	_adjust_template_size
5511  09ce 89            	pushw	x
5512  09cf ce0000        	ldw	x,_uip_appdata
5513  09d2 cd0000        	call	L5_CopyHttpHeader
5515  09d5 5b02          	addw	sp,#2
5516  09d7 89            	pushw	x
5517  09d8 ce0000        	ldw	x,_uip_appdata
5518  09db cd0000        	call	_uip_send
5520  09de 85            	popw	x
5521                     ; 3728       pSocket->nState = STATE_SENDDATA;
5523  09df 1e0b          	ldw	x,(OFST+7,sp)
5524  09e1 a60c          	ld	a,#12
5525  09e3 f7            	ld	(x),a
5526                     ; 3729       return;
5528  09e4 cc012f        	jra	L252
5529  09e7               L3511:
5530                     ; 3732     senddata:
5530                     ; 3733     if (pSocket->nState == STATE_SENDDATA) {
5532  09e7 1e0b          	ldw	x,(OFST+7,sp)
5533  09e9 f6            	ld	a,(x)
5534  09ea a10c          	cp	a,#12
5535  09ec 26f6          	jrne	L252
5536                     ; 3740       if (pSocket->nDataLeft == 0) {
5538  09ee e604          	ld	a,(4,x)
5539  09f0 ea03          	or	a,(3,x)
5540  09f2 2605          	jrne	L5502
5541                     ; 3742         nBufSize = 0;
5543  09f4 5f            	clrw	x
5544  09f5 1f02          	ldw	(OFST-2,sp),x
5547  09f7 202f          	jra	L7502
5548  09f9               L5502:
5549                     ; 3745         pSocket->nPrevBytes = pSocket->nDataLeft;
5551  09f9 9093          	ldw	y,x
5552  09fb 90ee03        	ldw	y,(3,y)
5553  09fe ef0b          	ldw	(11,x),y
5554                     ; 3746         nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5556  0a00 ce0000        	ldw	x,_uip_conn
5557  0a03 ee12          	ldw	x,(18,x)
5558  0a05 89            	pushw	x
5559  0a06 1e0d          	ldw	x,(OFST+9,sp)
5560  0a08 1c0003        	addw	x,#3
5561  0a0b 89            	pushw	x
5562  0a0c 1e0f          	ldw	x,(OFST+11,sp)
5563  0a0e 5c            	incw	x
5564  0a0f 89            	pushw	x
5565  0a10 ce0000        	ldw	x,_uip_appdata
5566  0a13 cd0000        	call	L7_CopyHttpData
5568  0a16 5b06          	addw	sp,#6
5569  0a18 1f02          	ldw	(OFST-2,sp),x
5571                     ; 3747         pSocket->nPrevBytes -= pSocket->nDataLeft;
5573  0a1a 1e0b          	ldw	x,(OFST+7,sp)
5574  0a1c e60c          	ld	a,(12,x)
5575  0a1e e004          	sub	a,(4,x)
5576  0a20 e70c          	ld	(12,x),a
5577  0a22 e60b          	ld	a,(11,x)
5578  0a24 e203          	sbc	a,(3,x)
5579  0a26 e70b          	ld	(11,x),a
5580  0a28               L7502:
5581                     ; 3750       if (nBufSize == 0) {
5583  0a28 1e02          	ldw	x,(OFST-2,sp)
5584  0a2a 2621          	jrne	LC016
5585                     ; 3752         uip_close();
5587  0a2c               LC017:
5589  0a2c 35100000      	mov	_uip_flags,#16
5591  0a30 cc012f        	jra	L252
5592                     ; 3756         uip_send(uip_appdata, nBufSize);
5594                     ; 3758       return;
5596  0a33               L5621:
5597                     ; 3762   else if (uip_rexmit()) {
5599  0a33 7205000075    	btjf	_uip_flags,#2,L3621
5600                     ; 3763     if (pSocket->nPrevBytes == 0xFFFF) {
5602  0a38 160b          	ldw	y,(OFST+7,sp)
5603  0a3a 90ee0b        	ldw	y,(11,y)
5604  0a3d 905c          	incw	y
5605  0a3f 2617          	jrne	L1702
5606                     ; 3765       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5608  0a41 cd0000        	call	_adjust_template_size
5610  0a44 89            	pushw	x
5611  0a45 ce0000        	ldw	x,_uip_appdata
5612  0a48 cd0000        	call	L5_CopyHttpHeader
5614  0a4b 5b02          	addw	sp,#2
5616  0a4d               LC016:
5618  0a4d 89            	pushw	x
5619  0a4e ce0000        	ldw	x,_uip_appdata
5620  0a51 cd0000        	call	_uip_send
5621  0a54 85            	popw	x
5623  0a55 cc012f        	jra	L252
5624  0a58               L1702:
5625                     ; 3768       pSocket->pData -= pSocket->nPrevBytes;
5627  0a58 1e0b          	ldw	x,(OFST+7,sp)
5628  0a5a e602          	ld	a,(2,x)
5629  0a5c e00c          	sub	a,(12,x)
5630  0a5e e702          	ld	(2,x),a
5631  0a60 e601          	ld	a,(1,x)
5632  0a62 e20b          	sbc	a,(11,x)
5633  0a64 e701          	ld	(1,x),a
5634                     ; 3769       pSocket->nDataLeft += pSocket->nPrevBytes;
5636  0a66 e604          	ld	a,(4,x)
5637  0a68 eb0c          	add	a,(12,x)
5638  0a6a e704          	ld	(4,x),a
5639  0a6c e603          	ld	a,(3,x)
5640  0a6e e90b          	adc	a,(11,x)
5641                     ; 3770       pSocket->nPrevBytes = pSocket->nDataLeft;
5643  0a70 9093          	ldw	y,x
5644  0a72 e703          	ld	(3,x),a
5645  0a74 90ee03        	ldw	y,(3,y)
5646  0a77 ef0b          	ldw	(11,x),y
5647                     ; 3771       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5649  0a79 ce0000        	ldw	x,_uip_conn
5650  0a7c ee12          	ldw	x,(18,x)
5651  0a7e 89            	pushw	x
5652  0a7f 1e0d          	ldw	x,(OFST+9,sp)
5653  0a81 1c0003        	addw	x,#3
5654  0a84 89            	pushw	x
5655  0a85 1e0f          	ldw	x,(OFST+11,sp)
5656  0a87 5c            	incw	x
5657  0a88 89            	pushw	x
5658  0a89 ce0000        	ldw	x,_uip_appdata
5659  0a8c cd0000        	call	L7_CopyHttpData
5661  0a8f 5b06          	addw	sp,#6
5662  0a91 1f02          	ldw	(OFST-2,sp),x
5664                     ; 3772       pSocket->nPrevBytes -= pSocket->nDataLeft;
5666  0a93 1e0b          	ldw	x,(OFST+7,sp)
5667  0a95 e60c          	ld	a,(12,x)
5668  0a97 e004          	sub	a,(4,x)
5669  0a99 e70c          	ld	(12,x),a
5670  0a9b e60b          	ld	a,(11,x)
5671  0a9d e203          	sbc	a,(3,x)
5672  0a9f e70b          	ld	(11,x),a
5673                     ; 3773       if (nBufSize == 0) {
5675  0aa1 1e02          	ldw	x,(OFST-2,sp)
5676                     ; 3775         uip_close();
5678  0aa3 2787          	jreq	LC017
5679                     ; 3779         uip_send(uip_appdata, nBufSize);
5681  0aa5 89            	pushw	x
5682  0aa6 ce0000        	ldw	x,_uip_appdata
5683  0aa9 cd0000        	call	_uip_send
5685  0aac 85            	popw	x
5686                     ; 3782     return;
5688  0aad               L3621:
5689                     ; 3784 }
5691  0aad cc012f        	jra	L252
5725                     ; 3787 void clear_saved_postpartial_all(void)
5725                     ; 3788 {
5726                     .text:	section	.text,new
5727  0000               _clear_saved_postpartial_all:
5729  0000 88            	push	a
5730       00000001      OFST:	set	1
5733                     ; 3790   for (i=0; i<24; i++) saved_postpartial[i] = '\0';
5735  0001 4f            	clr	a
5736  0002 6b01          	ld	(OFST+0,sp),a
5738  0004               L5112:
5741  0004 5f            	clrw	x
5742  0005 97            	ld	xl,a
5743  0006 724f002a      	clr	(_saved_postpartial,x)
5746  000a 0c01          	inc	(OFST+0,sp)
5750  000c 7b01          	ld	a,(OFST+0,sp)
5751  000e a118          	cp	a,#24
5752  0010 25f2          	jrult	L5112
5753                     ; 3791 }
5756  0012 84            	pop	a
5757  0013 81            	ret	
5791                     ; 3794 void clear_saved_postpartial_data(void)
5791                     ; 3795 {
5792                     .text:	section	.text,new
5793  0000               _clear_saved_postpartial_data:
5795  0000 88            	push	a
5796       00000001      OFST:	set	1
5799                     ; 3797   for (i=4; i<24; i++) saved_postpartial[i] = '\0';
5801  0001 a604          	ld	a,#4
5802  0003 6b01          	ld	(OFST+0,sp),a
5804  0005               L7312:
5807  0005 5f            	clrw	x
5808  0006 97            	ld	xl,a
5809  0007 724f002a      	clr	(_saved_postpartial,x)
5812  000b 0c01          	inc	(OFST+0,sp)
5816  000d 7b01          	ld	a,(OFST+0,sp)
5817  000f a118          	cp	a,#24
5818  0011 25f2          	jrult	L7312
5819                     ; 3798 }
5822  0013 84            	pop	a
5823  0014 81            	ret	
5857                     ; 3801 void clear_saved_postpartial_previous(void)
5857                     ; 3802 {
5858                     .text:	section	.text,new
5859  0000               _clear_saved_postpartial_previous:
5861  0000 88            	push	a
5862       00000001      OFST:	set	1
5865                     ; 3804   for (i=0; i<24; i++) saved_postpartial_previous[i] = '\0';
5867  0001 4f            	clr	a
5868  0002 6b01          	ld	(OFST+0,sp),a
5870  0004               L1612:
5873  0004 5f            	clrw	x
5874  0005 97            	ld	xl,a
5875  0006 724f0012      	clr	(_saved_postpartial_previous,x)
5878  000a 0c01          	inc	(OFST+0,sp)
5882  000c 7b01          	ld	a,(OFST+0,sp)
5883  000e a118          	cp	a,#24
5884  0010 25f2          	jrult	L1612
5885                     ; 3805 }
5888  0012 84            	pop	a
5889  0013 81            	ret	
5979                     ; 3808 void parse_POST_string(uint8_t curr_ParseCmd, uint8_t num_chars)
5979                     ; 3809 {
5980                     .text:	section	.text,new
5981  0000               _parse_POST_string:
5983  0000 89            	pushw	x
5984  0001 5217          	subw	sp,#23
5985       00000017      OFST:	set	23
5988                     ; 3832   amp_found = 0;
5990  0003 0f02          	clr	(OFST-21,sp)
5992                     ; 3833   for (i=0; i<20; i++) tmp_Pending[i] = '\0';
5994  0005 0f17          	clr	(OFST+0,sp)
5996  0007               L1222:
5999  0007 96            	ldw	x,sp
6000  0008 1c0003        	addw	x,#OFST-20
6001  000b 9f            	ld	a,xl
6002  000c 5e            	swapw	x
6003  000d 1b17          	add	a,(OFST+0,sp)
6004  000f 2401          	jrnc	L462
6005  0011 5c            	incw	x
6006  0012               L462:
6007  0012 02            	rlwa	x,a
6008  0013 7f            	clr	(x)
6011  0014 0c17          	inc	(OFST+0,sp)
6015  0016 7b17          	ld	a,(OFST+0,sp)
6016  0018 a114          	cp	a,#20
6017  001a 25eb          	jrult	L1222
6018                     ; 3835   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6020  001c c60012        	ld	a,_saved_postpartial_previous
6021  001f 1118          	cp	a,(OFST+1,sp)
6022  0021 260a          	jrne	L7222
6023                     ; 3838     saved_postpartial_previous[0] = '\0';
6025  0023 725f0012      	clr	_saved_postpartial_previous
6026                     ; 3844     frag_flag = 1; // frag_flag is used to manage the TCP Fragment restore
6028  0027 a601          	ld	a,#1
6029  0029 6b17          	ld	(OFST+0,sp),a
6032  002b 2005          	jra	L1322
6033  002d               L7222:
6034                     ; 3848     frag_flag = 0;
6036  002d 0f17          	clr	(OFST+0,sp)
6038                     ; 3852     clear_saved_postpartial_data(); // Clear [4] and higher
6040  002f cd0000        	call	_clear_saved_postpartial_data
6042  0032               L1322:
6043                     ; 3873   resume = 0;
6045  0032 0f01          	clr	(OFST-22,sp)
6047                     ; 3874   if (frag_flag == 1) {
6049  0034 7b17          	ld	a,(OFST+0,sp)
6050  0036 4a            	dec	a
6051  0037 263f          	jrne	L3322
6052                     ; 3876     for (i = 0; i < num_chars; i++) {
6054  0039 6b17          	ld	(OFST+0,sp),a
6057  003b 2033          	jra	L1422
6058  003d               L5322:
6059                     ; 3885       if (saved_postpartial_previous[4+i] != '\0') {
6061  003d 5f            	clrw	x
6062  003e 97            	ld	xl,a
6063  003f 724d0016      	tnz	(_saved_postpartial_previous+4,x)
6064  0043 271b          	jreq	L5422
6065                     ; 3886         tmp_Pending[i] = saved_postpartial_previous[4+i];
6067  0045 96            	ldw	x,sp
6068  0046 1c0003        	addw	x,#OFST-20
6069  0049 9f            	ld	a,xl
6070  004a 5e            	swapw	x
6071  004b 1b17          	add	a,(OFST+0,sp)
6072  004d 2401          	jrnc	L072
6073  004f 5c            	incw	x
6074  0050               L072:
6075  0050 02            	rlwa	x,a
6076  0051 7b17          	ld	a,(OFST+0,sp)
6077  0053 905f          	clrw	y
6078  0055 9097          	ld	yl,a
6079  0057 90d60016      	ld	a,(_saved_postpartial_previous+4,y)
6080  005b f7            	ld	(x),a
6082                     ; 3876     for (i = 0; i < num_chars; i++) {
6084  005c 0c17          	inc	(OFST+0,sp)
6086  005e 2010          	jra	L1422
6087  0060               L5422:
6088                     ; 3889         resume = i;
6090  0060 6b01          	ld	(OFST-22,sp),a
6092                     ; 3890         break;
6093  0062               L3422:
6094                     ; 3893     if (*tmp_pBuffer == '&') {
6096  0062 72c6000e      	ld	a,[_tmp_pBuffer.w]
6097  0066 a126          	cp	a,#38
6098  0068 260e          	jrne	L3322
6099                     ; 3897       amp_found = 1;
6101  006a a601          	ld	a,#1
6102  006c 6b02          	ld	(OFST-21,sp),a
6104  006e 2008          	jra	L3322
6105  0070               L1422:
6106                     ; 3876     for (i = 0; i < num_chars; i++) {
6108  0070 7b17          	ld	a,(OFST+0,sp)
6109  0072 1119          	cp	a,(OFST+2,sp)
6110  0074 25c7          	jrult	L5322
6111  0076 20ea          	jra	L3422
6112  0078               L3322:
6113                     ; 3909   if (amp_found == 0) {
6115  0078 7b02          	ld	a,(OFST-21,sp)
6116  007a 2703cc0104    	jrne	L3522
6117                     ; 3910     for (i = resume; i < num_chars; i++) {
6119  007f 7b01          	ld	a,(OFST-22,sp)
6120  0081 6b17          	ld	(OFST+0,sp),a
6123  0083 207b          	jra	L1622
6124  0085               L5522:
6125                     ; 3913       if (amp_found == 0) {
6127  0085 7b02          	ld	a,(OFST-21,sp)
6128  0087 265d          	jrne	L5622
6129                     ; 3916         if (*tmp_pBuffer == '&') {
6131  0089 72c6000e      	ld	a,[_tmp_pBuffer.w]
6132  008d a126          	cp	a,#38
6133  008f 2606          	jrne	L7622
6134                     ; 3919           amp_found = 1;
6136  0091 a601          	ld	a,#1
6137  0093 6b02          	ld	(OFST-21,sp),a
6140  0095 204f          	jra	L5622
6141  0097               L7622:
6142                     ; 3922           tmp_Pending[i] = *tmp_pBuffer;
6144  0097 96            	ldw	x,sp
6145  0098 1c0003        	addw	x,#OFST-20
6146  009b 9f            	ld	a,xl
6147  009c 5e            	swapw	x
6148  009d 1b17          	add	a,(OFST+0,sp)
6149  009f 2401          	jrnc	L272
6150  00a1 5c            	incw	x
6151  00a2               L272:
6152  00a2 90ce000e      	ldw	y,_tmp_pBuffer
6153  00a6 02            	rlwa	x,a
6154  00a7 90f6          	ld	a,(y)
6155  00a9 f7            	ld	(x),a
6156                     ; 3923           saved_postpartial[4+i] = *tmp_pBuffer;
6158  00aa 5f            	clrw	x
6159  00ab 7b17          	ld	a,(OFST+0,sp)
6160  00ad 97            	ld	xl,a
6161  00ae 90f6          	ld	a,(y)
6162  00b0 d7002e        	ld	(_saved_postpartial+4,x),a
6163                     ; 3924           tmp_nParseLeft--;
6165  00b3 725a000b      	dec	_tmp_nParseLeft
6166                     ; 3925           saved_nparseleft = tmp_nParseLeft;
6168                     ; 3926           tmp_pBuffer++;
6170  00b7 93            	ldw	x,y
6171  00b8 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6172  00bd 5c            	incw	x
6173  00be cf000e        	ldw	_tmp_pBuffer,x
6174                     ; 3927           tmp_nBytes--;
6176  00c1 ce000c        	ldw	x,_tmp_nBytes
6177  00c4 5a            	decw	x
6178  00c5 cf000c        	ldw	_tmp_nBytes,x
6179                     ; 3928           if (tmp_nBytes == 0) {
6181  00c8 261c          	jrne	L5622
6182                     ; 3932             if (i == (num_chars - 1)) {
6184  00ca 7b19          	ld	a,(OFST+2,sp)
6185  00cc 5f            	clrw	x
6186  00cd 97            	ld	xl,a
6187  00ce 5a            	decw	x
6188  00cf 7b17          	ld	a,(OFST+0,sp)
6189  00d1 905f          	clrw	y
6190  00d3 9097          	ld	yl,a
6191  00d5 90bf00        	ldw	c_y,y
6192  00d8 b300          	cpw	x,c_y
6193  00da 2604          	jrne	L5722
6194                     ; 3937               saved_parsestate = PARSE_DELIM;
6196  00dc 35050043      	mov	_saved_parsestate,#5
6197  00e0               L5722:
6198                     ; 3939             break_while = 1;
6200  00e0 3501000a      	mov	_break_while,#1
6201                     ; 3940             break; // This will break the for() loop. But we need to break the
6203  00e4 201e          	jra	L3522
6204  00e6               L5622:
6205                     ; 3946       if (amp_found == 1) {
6207  00e6 7b02          	ld	a,(OFST-21,sp)
6208  00e8 4a            	dec	a
6209  00e9 2611          	jrne	L7722
6210                     ; 3949         tmp_Pending[i] = '\0';
6212  00eb 96            	ldw	x,sp
6213  00ec 1c0003        	addw	x,#OFST-20
6214  00ef 9f            	ld	a,xl
6215  00f0 5e            	swapw	x
6216  00f1 1b17          	add	a,(OFST+0,sp)
6217  00f3 2401          	jrnc	L472
6218  00f5 5c            	incw	x
6219  00f6               L472:
6220  00f6 02            	rlwa	x,a
6221  00f7 7f            	clr	(x)
6222                     ; 3958         tmp_nParseLeft--;
6224  00f8 725a000b      	dec	_tmp_nParseLeft
6225  00fc               L7722:
6226                     ; 3910     for (i = resume; i < num_chars; i++) {
6228  00fc 0c17          	inc	(OFST+0,sp)
6230  00fe 7b17          	ld	a,(OFST+0,sp)
6231  0100               L1622:
6234  0100 1119          	cp	a,(OFST+2,sp)
6235  0102 2581          	jrult	L5522
6236  0104               L3522:
6237                     ; 3979   if (break_while == 0) clear_saved_postpartial_all();
6239  0104 c6000a        	ld	a,_break_while
6240  0107 2603          	jrne	L1032
6243  0109 cd0000        	call	_clear_saved_postpartial_all
6245  010c               L1032:
6246                     ; 3982   if (curr_ParseCmd == 'a') {
6248  010c 7b18          	ld	a,(OFST+1,sp)
6249  010e a161          	cp	a,#97
6250  0110 2622          	jrne	L3032
6251                     ; 3983     for (i=0; i<num_chars; i++) Pending_devicename[i] = tmp_Pending[i];
6253  0112 0f17          	clr	(OFST+0,sp)
6256  0114 2016          	jra	L1132
6257  0116               L5032:
6260  0116 5f            	clrw	x
6261  0117 97            	ld	xl,a
6262  0118 89            	pushw	x
6263  0119 96            	ldw	x,sp
6264  011a 1c0005        	addw	x,#OFST-18
6265  011d 9f            	ld	a,xl
6266  011e 5e            	swapw	x
6267  011f 1b19          	add	a,(OFST+2,sp)
6268  0121 2401          	jrnc	L003
6269  0123 5c            	incw	x
6270  0124               L003:
6271  0124 02            	rlwa	x,a
6272  0125 f6            	ld	a,(x)
6273  0126 85            	popw	x
6274  0127 d70000        	ld	(_Pending_devicename,x),a
6277  012a 0c17          	inc	(OFST+0,sp)
6279  012c               L1132:
6282  012c 7b17          	ld	a,(OFST+0,sp)
6283  012e 1119          	cp	a,(OFST+2,sp)
6284  0130 25e4          	jrult	L5032
6286  0132 204a          	jra	L5132
6287  0134               L3032:
6288                     ; 3988   else if (curr_ParseCmd == 'l') {
6290  0134 a16c          	cp	a,#108
6291  0136 2622          	jrne	L7132
6292                     ; 3989     for (i=0; i<num_chars; i++) Pending_mqtt_username[i] = tmp_Pending[i];
6294  0138 0f17          	clr	(OFST+0,sp)
6297  013a 2016          	jra	L5232
6298  013c               L1232:
6301  013c 5f            	clrw	x
6302  013d 97            	ld	xl,a
6303  013e 89            	pushw	x
6304  013f 96            	ldw	x,sp
6305  0140 1c0005        	addw	x,#OFST-18
6306  0143 9f            	ld	a,xl
6307  0144 5e            	swapw	x
6308  0145 1b19          	add	a,(OFST+2,sp)
6309  0147 2401          	jrnc	L203
6310  0149 5c            	incw	x
6311  014a               L203:
6312  014a 02            	rlwa	x,a
6313  014b f6            	ld	a,(x)
6314  014c 85            	popw	x
6315  014d d70000        	ld	(_Pending_mqtt_username,x),a
6318  0150 0c17          	inc	(OFST+0,sp)
6320  0152               L5232:
6323  0152 7b17          	ld	a,(OFST+0,sp)
6324  0154 1119          	cp	a,(OFST+2,sp)
6325  0156 25e4          	jrult	L1232
6327  0158 2024          	jra	L5132
6328  015a               L7132:
6329                     ; 3993   else if (curr_ParseCmd == 'm') {
6331  015a a16d          	cp	a,#109
6332  015c 2620          	jrne	L5132
6333                     ; 3994     for (i=0; i<num_chars; i++) Pending_mqtt_password[i] = tmp_Pending[i];
6335  015e 0f17          	clr	(OFST+0,sp)
6338  0160 2016          	jra	L1432
6339  0162               L5332:
6342  0162 5f            	clrw	x
6343  0163 97            	ld	xl,a
6344  0164 89            	pushw	x
6345  0165 96            	ldw	x,sp
6346  0166 1c0005        	addw	x,#OFST-18
6347  0169 9f            	ld	a,xl
6348  016a 5e            	swapw	x
6349  016b 1b19          	add	a,(OFST+2,sp)
6350  016d 2401          	jrnc	L403
6351  016f 5c            	incw	x
6352  0170               L403:
6353  0170 02            	rlwa	x,a
6354  0171 f6            	ld	a,(x)
6355  0172 85            	popw	x
6356  0173 d70000        	ld	(_Pending_mqtt_password,x),a
6359  0176 0c17          	inc	(OFST+0,sp)
6361  0178               L1432:
6364  0178 7b17          	ld	a,(OFST+0,sp)
6365  017a 1119          	cp	a,(OFST+2,sp)
6366  017c 25e4          	jrult	L5332
6367  017e               L5132:
6368                     ; 3997 }
6371  017e 5b19          	addw	sp,#25
6372  0180 81            	ret	
6446                     	switch	.const
6447  1d00               L613:
6448  1d00 00de          	dc.w	L5432
6449  1d02 00e5          	dc.w	L7432
6450  1d04 00ec          	dc.w	L1532
6451  1d06 00f3          	dc.w	L3532
6452  1d08 00fa          	dc.w	L5532
6453  1d0a 0101          	dc.w	L7532
6454  1d0c 0108          	dc.w	L1632
6455  1d0e 010f          	dc.w	L3632
6456  1d10 0116          	dc.w	L5632
6457  1d12 011d          	dc.w	L7632
6458  1d14 0124          	dc.w	L1732
6459  1d16 012b          	dc.w	L3732
6460  1d18 0132          	dc.w	L5732
6461  1d1a 0139          	dc.w	L7732
6462  1d1c 0140          	dc.w	L1042
6463  1d1e 0147          	dc.w	L3042
6464                     ; 4000 void parse_POST_address(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6464                     ; 4001 {
6465                     .text:	section	.text,new
6466  0000               _parse_POST_address:
6468  0000 89            	pushw	x
6469  0001 89            	pushw	x
6470       00000002      OFST:	set	2
6473                     ; 4004   alpha[0] = '-';
6475  0002 352d0004      	mov	_alpha,#45
6476                     ; 4005   alpha[1] = '-';
6478  0006 352d0005      	mov	_alpha+1,#45
6479                     ; 4006   alpha[2] = '-';
6481  000a 352d0006      	mov	_alpha+2,#45
6482                     ; 4009   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6484  000e 9e            	ld	a,xh
6485  000f c10012        	cp	a,_saved_postpartial_previous
6486  0012 2624          	jrne	L3342
6487                     ; 4012     saved_postpartial_previous[0] = '\0';
6489  0014 725f0012      	clr	_saved_postpartial_previous
6490                     ; 4019     if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
6492  0018 c60016        	ld	a,_saved_postpartial_previous+4
6493  001b 2705          	jreq	L5342
6496  001d 5500160004    	mov	_alpha,_saved_postpartial_previous+4
6497  0022               L5342:
6498                     ; 4020     if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
6500  0022 c60017        	ld	a,_saved_postpartial_previous+5
6501  0025 2705          	jreq	L7342
6504  0027 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
6505  002c               L7342:
6506                     ; 4021     if (saved_postpartial_previous[6] != '\0') alpha[2] = saved_postpartial_previous[6];
6508  002c c60018        	ld	a,_saved_postpartial_previous+6
6509  002f 270a          	jreq	L3442
6512  0031 5500180006    	mov	_alpha+2,_saved_postpartial_previous+6
6513  0036 2003          	jra	L3442
6514  0038               L3342:
6515                     ; 4027     clear_saved_postpartial_data(); // Clear [4] and higher
6517  0038 cd0000        	call	_clear_saved_postpartial_data
6519  003b               L3442:
6520                     ; 4030   for (i=0; i<3; i++) {
6522  003b 4f            	clr	a
6523  003c 6b02          	ld	(OFST+0,sp),a
6525  003e               L5442:
6526                     ; 4036     if (alpha[i] == '-') {
6528  003e 5f            	clrw	x
6529  003f 97            	ld	xl,a
6530  0040 d60004        	ld	a,(_alpha,x)
6531  0043 a12d          	cp	a,#45
6532  0045 263c          	jrne	L3542
6533                     ; 4037       alpha[i] = (uint8_t)(*tmp_pBuffer);
6535  0047 7b02          	ld	a,(OFST+0,sp)
6536  0049 5f            	clrw	x
6537  004a 90ce000e      	ldw	y,_tmp_pBuffer
6538  004e 97            	ld	xl,a
6539  004f 90f6          	ld	a,(y)
6540  0051 d70004        	ld	(_alpha,x),a
6541                     ; 4038       saved_postpartial[i+4] = (uint8_t)(*tmp_pBuffer);
6543  0054 5f            	clrw	x
6544  0055 7b02          	ld	a,(OFST+0,sp)
6545  0057 97            	ld	xl,a
6546  0058 90f6          	ld	a,(y)
6547  005a d7002e        	ld	(_saved_postpartial+4,x),a
6548                     ; 4039       tmp_nParseLeft--;
6550  005d 725a000b      	dec	_tmp_nParseLeft
6551                     ; 4040       saved_nparseleft = tmp_nParseLeft;
6553                     ; 4041       tmp_pBuffer++;
6555  0061 93            	ldw	x,y
6556  0062 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6557  0067 5c            	incw	x
6558  0068 cf000e        	ldw	_tmp_pBuffer,x
6559                     ; 4042       tmp_nBytes--;
6561  006b ce000c        	ldw	x,_tmp_nBytes
6562  006e 5a            	decw	x
6563  006f cf000c        	ldw	_tmp_nBytes,x
6564                     ; 4043       if (i != 2 && tmp_nBytes == 0) {
6566  0072 7b02          	ld	a,(OFST+0,sp)
6567  0074 a102          	cp	a,#2
6568  0076 270b          	jreq	L3542
6570  0078 ce000c        	ldw	x,_tmp_nBytes
6571  007b 2606          	jrne	L3542
6572                     ; 4044         break_while = 1; // Hit end of fragment but still have characters to
6574  007d 3501000a      	mov	_break_while,#1
6575                     ; 4048         break; // Break out of for() loop.
6577  0081 2008          	jra	L1542
6578  0083               L3542:
6579                     ; 4030   for (i=0; i<3; i++) {
6581  0083 0c02          	inc	(OFST+0,sp)
6585  0085 7b02          	ld	a,(OFST+0,sp)
6586  0087 a103          	cp	a,#3
6587  0089 25b3          	jrult	L5442
6588  008b               L1542:
6589                     ; 4052   if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
6591  008b c6000a        	ld	a,_break_while
6592  008e 4a            	dec	a
6593  008f 2603cc0155    	jreq	L023
6596                     ; 4056   clear_saved_postpartial_all();
6598  0094 cd0000        	call	_clear_saved_postpartial_all
6600                     ; 4069     invalid = 0;
6602  0097 0f01          	clr	(OFST-1,sp)
6604                     ; 4071     temp = (uint8_t)(       (alpha[2] - '0'));
6606  0099 c60006        	ld	a,_alpha+2
6607  009c a030          	sub	a,#48
6608  009e 6b02          	ld	(OFST+0,sp),a
6610                     ; 4072     temp = (uint8_t)(temp + (alpha[1] - '0') * 10);
6612  00a0 c60005        	ld	a,_alpha+1
6613  00a3 97            	ld	xl,a
6614  00a4 a60a          	ld	a,#10
6615  00a6 42            	mul	x,a
6616  00a7 9f            	ld	a,xl
6617  00a8 a0e0          	sub	a,#224
6618  00aa 1b02          	add	a,(OFST+0,sp)
6619  00ac 6b02          	ld	(OFST+0,sp),a
6621                     ; 4073     if (temp > 55 && alpha[0] > '1') invalid = 1;
6623  00ae a138          	cp	a,#56
6624  00b0 250d          	jrult	L1642
6626  00b2 c60004        	ld	a,_alpha
6627  00b5 a132          	cp	a,#50
6628  00b7 2506          	jrult	L1642
6631  00b9 a601          	ld	a,#1
6632  00bb 6b01          	ld	(OFST-1,sp),a
6635  00bd 200e          	jra	L3642
6636  00bf               L1642:
6637                     ; 4074     else temp = (uint8_t)(temp + (alpha[0] - '0') * 100);
6639  00bf c60004        	ld	a,_alpha
6640  00c2 97            	ld	xl,a
6641  00c3 a664          	ld	a,#100
6642  00c5 42            	mul	x,a
6643  00c6 9f            	ld	a,xl
6644  00c7 a0c0          	sub	a,#192
6645  00c9 1b02          	add	a,(OFST+0,sp)
6646  00cb 6b02          	ld	(OFST+0,sp),a
6648  00cd               L3642:
6649                     ; 4075     if (invalid == 0) { // Make change only if valid entry
6651  00cd 7b01          	ld	a,(OFST-1,sp)
6652  00cf 267b          	jrne	L5642
6653                     ; 4076       switch(curr_ParseNum)
6655  00d1 7b04          	ld	a,(OFST+2,sp)
6657                     ; 4099         default: break;
6658  00d3 a110          	cp	a,#16
6659  00d5 2475          	jruge	L5642
6660  00d7 5f            	clrw	x
6661  00d8 97            	ld	xl,a
6662  00d9 58            	sllw	x
6663  00da de1d00        	ldw	x,(L613,x)
6664  00dd fc            	jp	(x)
6665  00de               L5432:
6666                     ; 4078         case 0:  Pending_hostaddr[3] = (uint8_t)temp; break;
6668  00de 7b02          	ld	a,(OFST+0,sp)
6669  00e0 c70003        	ld	_Pending_hostaddr+3,a
6672  00e3 2067          	jra	L5642
6673  00e5               L7432:
6674                     ; 4079         case 1:  Pending_hostaddr[2] = (uint8_t)temp; break;
6676  00e5 7b02          	ld	a,(OFST+0,sp)
6677  00e7 c70002        	ld	_Pending_hostaddr+2,a
6680  00ea 2060          	jra	L5642
6681  00ec               L1532:
6682                     ; 4080         case 2:  Pending_hostaddr[1] = (uint8_t)temp; break;
6684  00ec 7b02          	ld	a,(OFST+0,sp)
6685  00ee c70001        	ld	_Pending_hostaddr+1,a
6688  00f1 2059          	jra	L5642
6689  00f3               L3532:
6690                     ; 4081         case 3:  Pending_hostaddr[0] = (uint8_t)temp; break;
6692  00f3 7b02          	ld	a,(OFST+0,sp)
6693  00f5 c70000        	ld	_Pending_hostaddr,a
6696  00f8 2052          	jra	L5642
6697  00fa               L5532:
6698                     ; 4082         case 4:  Pending_draddr[3] = (uint8_t)temp; break;
6700  00fa 7b02          	ld	a,(OFST+0,sp)
6701  00fc c70003        	ld	_Pending_draddr+3,a
6704  00ff 204b          	jra	L5642
6705  0101               L7532:
6706                     ; 4083         case 5:  Pending_draddr[2] = (uint8_t)temp; break;
6708  0101 7b02          	ld	a,(OFST+0,sp)
6709  0103 c70002        	ld	_Pending_draddr+2,a
6712  0106 2044          	jra	L5642
6713  0108               L1632:
6714                     ; 4084         case 6:  Pending_draddr[1] = (uint8_t)temp; break;
6716  0108 7b02          	ld	a,(OFST+0,sp)
6717  010a c70001        	ld	_Pending_draddr+1,a
6720  010d 203d          	jra	L5642
6721  010f               L3632:
6722                     ; 4085         case 7:  Pending_draddr[0] = (uint8_t)temp; break;
6724  010f 7b02          	ld	a,(OFST+0,sp)
6725  0111 c70000        	ld	_Pending_draddr,a
6728  0114 2036          	jra	L5642
6729  0116               L5632:
6730                     ; 4086         case 8:  Pending_netmask[3] = (uint8_t)temp; break;
6732  0116 7b02          	ld	a,(OFST+0,sp)
6733  0118 c70003        	ld	_Pending_netmask+3,a
6736  011b 202f          	jra	L5642
6737  011d               L7632:
6738                     ; 4087         case 9:  Pending_netmask[2] = (uint8_t)temp; break;
6740  011d 7b02          	ld	a,(OFST+0,sp)
6741  011f c70002        	ld	_Pending_netmask+2,a
6744  0122 2028          	jra	L5642
6745  0124               L1732:
6746                     ; 4088         case 10: Pending_netmask[1] = (uint8_t)temp; break;
6748  0124 7b02          	ld	a,(OFST+0,sp)
6749  0126 c70001        	ld	_Pending_netmask+1,a
6752  0129 2021          	jra	L5642
6753  012b               L3732:
6754                     ; 4089         case 11: Pending_netmask[0] = (uint8_t)temp; break;
6756  012b 7b02          	ld	a,(OFST+0,sp)
6757  012d c70000        	ld	_Pending_netmask,a
6760  0130 201a          	jra	L5642
6761  0132               L5732:
6762                     ; 4092 	  Pending_mqttserveraddr[3] = (uint8_t)temp;
6764  0132 7b02          	ld	a,(OFST+0,sp)
6765  0134 c70003        	ld	_Pending_mqttserveraddr+3,a
6766                     ; 4093 	  break;
6768  0137 2013          	jra	L5642
6769  0139               L7732:
6770                     ; 4095         case 13: Pending_mqttserveraddr[2] = (uint8_t)temp; break;
6772  0139 7b02          	ld	a,(OFST+0,sp)
6773  013b c70002        	ld	_Pending_mqttserveraddr+2,a
6776  013e 200c          	jra	L5642
6777  0140               L1042:
6778                     ; 4096         case 14: Pending_mqttserveraddr[1] = (uint8_t)temp; break;
6780  0140 7b02          	ld	a,(OFST+0,sp)
6781  0142 c70001        	ld	_Pending_mqttserveraddr+1,a
6784  0145 2005          	jra	L5642
6785  0147               L3042:
6786                     ; 4097         case 15: Pending_mqttserveraddr[0] = (uint8_t)temp; break;
6788  0147 7b02          	ld	a,(OFST+0,sp)
6789  0149 c70000        	ld	_Pending_mqttserveraddr,a
6792                     ; 4099         default: break;
6794  014c               L5642:
6795                     ; 4104   if (tmp_nBytes == 0) {
6797  014c ce000c        	ldw	x,_tmp_nBytes
6798  014f 2604          	jrne	L023
6799                     ; 4107     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
6801  0151 3502000a      	mov	_break_while,#2
6802                     ; 4110     return;
6803  0155               L023:
6806  0155 5b04          	addw	sp,#4
6807  0157 81            	ret	
6808                     ; 4112 }
6888                     ; 4115 void parse_POST_port(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6888                     ; 4116 {
6889                     .text:	section	.text,new
6890  0000               _parse_POST_port:
6892  0000 89            	pushw	x
6893  0001 5203          	subw	sp,#3
6894       00000003      OFST:	set	3
6897                     ; 4119   for (i=0; i<5; i++) alpha[i] = '-';
6899  0003 4f            	clr	a
6900  0004 6b03          	ld	(OFST+0,sp),a
6902  0006               L3252:
6905  0006 5f            	clrw	x
6906  0007 97            	ld	xl,a
6907  0008 a62d          	ld	a,#45
6908  000a d70004        	ld	(_alpha,x),a
6911  000d 0c03          	inc	(OFST+0,sp)
6915  000f 7b03          	ld	a,(OFST+0,sp)
6916  0011 a105          	cp	a,#5
6917  0013 25f1          	jrult	L3252
6918                     ; 4121   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6920  0015 c60012        	ld	a,_saved_postpartial_previous
6921  0018 1104          	cp	a,(OFST+1,sp)
6922  001a 2621          	jrne	L1352
6923                     ; 4124     saved_postpartial_previous[0] = '\0';
6925  001c 725f0012      	clr	_saved_postpartial_previous
6926                     ; 4131     for (i=0; i<5; i++) {
6928  0020 4f            	clr	a
6929  0021 6b03          	ld	(OFST+0,sp),a
6931  0023               L3352:
6932                     ; 4132       if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
6934  0023 5f            	clrw	x
6935  0024 97            	ld	xl,a
6936  0025 724d0016      	tnz	(_saved_postpartial_previous+4,x)
6937  0029 2708          	jreq	L1452
6940  002b 5f            	clrw	x
6941  002c 97            	ld	xl,a
6942  002d d60016        	ld	a,(_saved_postpartial_previous+4,x)
6943  0030 d70004        	ld	(_alpha,x),a
6944  0033               L1452:
6945                     ; 4131     for (i=0; i<5; i++) {
6947  0033 0c03          	inc	(OFST+0,sp)
6951  0035 7b03          	ld	a,(OFST+0,sp)
6952  0037 a105          	cp	a,#5
6953  0039 25e8          	jrult	L3352
6955  003b 2003          	jra	L3452
6956  003d               L1352:
6957                     ; 4139     clear_saved_postpartial_data(); // Clear [4] and higher
6959  003d cd0000        	call	_clear_saved_postpartial_data
6961  0040               L3452:
6962                     ; 4144     for (i=0; i<5; i++) {
6964  0040 4f            	clr	a
6965  0041 6b03          	ld	(OFST+0,sp),a
6967  0043               L5452:
6968                     ; 4150       if (alpha[i] == '-') {
6970  0043 5f            	clrw	x
6971  0044 97            	ld	xl,a
6972  0045 d60004        	ld	a,(_alpha,x)
6973  0048 a12d          	cp	a,#45
6974  004a 263c          	jrne	L3552
6975                     ; 4151         alpha[i] = (uint8_t)(*tmp_pBuffer);
6977  004c 7b03          	ld	a,(OFST+0,sp)
6978  004e 5f            	clrw	x
6979  004f 90ce000e      	ldw	y,_tmp_pBuffer
6980  0053 97            	ld	xl,a
6981  0054 90f6          	ld	a,(y)
6982  0056 d70004        	ld	(_alpha,x),a
6983                     ; 4152         saved_postpartial[i+4] = *tmp_pBuffer;
6985  0059 5f            	clrw	x
6986  005a 7b03          	ld	a,(OFST+0,sp)
6987  005c 97            	ld	xl,a
6988  005d 90f6          	ld	a,(y)
6989  005f d7002e        	ld	(_saved_postpartial+4,x),a
6990                     ; 4153         tmp_nParseLeft--;
6992  0062 725a000b      	dec	_tmp_nParseLeft
6993                     ; 4154         saved_nparseleft = tmp_nParseLeft;
6995                     ; 4155         tmp_pBuffer++;
6997  0066 93            	ldw	x,y
6998  0067 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6999  006c 5c            	incw	x
7000  006d cf000e        	ldw	_tmp_pBuffer,x
7001                     ; 4156         tmp_nBytes--;
7003  0070 ce000c        	ldw	x,_tmp_nBytes
7004  0073 5a            	decw	x
7005  0074 cf000c        	ldw	_tmp_nBytes,x
7006                     ; 4157         if (i != 4 && tmp_nBytes == 0) {
7008  0077 7b03          	ld	a,(OFST+0,sp)
7009  0079 a104          	cp	a,#4
7010  007b 270b          	jreq	L3552
7012  007d ce000c        	ldw	x,_tmp_nBytes
7013  0080 2606          	jrne	L3552
7014                     ; 4158           break_while = 1; // Hit end of fragment but still have characters to
7016  0082 3501000a      	mov	_break_while,#1
7017                     ; 4162    	break; // Break out of for() loop.
7019  0086 2008          	jra	L1552
7020  0088               L3552:
7021                     ; 4144     for (i=0; i<5; i++) {
7023  0088 0c03          	inc	(OFST+0,sp)
7027  008a 7b03          	ld	a,(OFST+0,sp)
7028  008c a105          	cp	a,#5
7029  008e 25b3          	jrult	L5452
7030  0090               L1552:
7031                     ; 4166     if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
7033  0090 c6000a        	ld	a,_break_while
7034  0093 4a            	dec	a
7035  0094 2603cc0122    	jreq	L033
7038                     ; 4171   clear_saved_postpartial_all();
7040  0099 cd0000        	call	_clear_saved_postpartial_all
7042                     ; 4180     invalid = 0;
7044  009c 0f03          	clr	(OFST+0,sp)
7046                     ; 4182     temp = (uint16_t)(       (alpha[4] - '0'));
7048  009e 5f            	clrw	x
7049  009f c60008        	ld	a,_alpha+4
7050  00a2 97            	ld	xl,a
7051  00a3 1d0030        	subw	x,#48
7052  00a6 1f01          	ldw	(OFST-2,sp),x
7054                     ; 4183     temp = (uint16_t)(temp + (alpha[3] - '0') * 10);
7056  00a8 c60007        	ld	a,_alpha+3
7057  00ab 97            	ld	xl,a
7058  00ac a60a          	ld	a,#10
7059  00ae 42            	mul	x,a
7060  00af 1d01e0        	subw	x,#480
7061  00b2 72fb01        	addw	x,(OFST-2,sp)
7062  00b5 1f01          	ldw	(OFST-2,sp),x
7064                     ; 4184     temp = (uint16_t)(temp + (alpha[2] - '0') * 100);
7066  00b7 c60006        	ld	a,_alpha+2
7067  00ba 97            	ld	xl,a
7068  00bb a664          	ld	a,#100
7069  00bd 42            	mul	x,a
7070  00be 1d12c0        	subw	x,#4800
7071  00c1 72fb01        	addw	x,(OFST-2,sp)
7072  00c4 1f01          	ldw	(OFST-2,sp),x
7074                     ; 4185     temp = (uint16_t)(temp + (alpha[1] - '0') * 1000);
7076  00c6 5f            	clrw	x
7077  00c7 c60005        	ld	a,_alpha+1
7078  00ca 97            	ld	xl,a
7079  00cb 90ae03e8      	ldw	y,#1000
7080  00cf cd0000        	call	c_imul
7082  00d2 1dbb80        	subw	x,#48000
7083  00d5 72fb01        	addw	x,(OFST-2,sp)
7084  00d8 1f01          	ldw	(OFST-2,sp),x
7086                     ; 4186     if (temp > 5535 && alpha[0] > '5') invalid = 1;
7088  00da a315a0        	cpw	x,#5536
7089  00dd 250d          	jrult	L1652
7091  00df c60004        	ld	a,_alpha
7092  00e2 a136          	cp	a,#54
7093  00e4 2506          	jrult	L1652
7096  00e6 a601          	ld	a,#1
7097  00e8 6b03          	ld	(OFST+0,sp),a
7100  00ea 2014          	jra	L3652
7101  00ec               L1652:
7102                     ; 4187     else temp = (uint16_t)(temp + (alpha[0] - '0') * 10000);
7104  00ec c60004        	ld	a,_alpha
7105  00ef 5f            	clrw	x
7106  00f0 97            	ld	xl,a
7107  00f1 90ae2710      	ldw	y,#10000
7108  00f5 cd0000        	call	c_imul
7110  00f8 1d5300        	subw	x,#21248
7111  00fb 72fb01        	addw	x,(OFST-2,sp)
7112  00fe 1f01          	ldw	(OFST-2,sp),x
7114  0100               L3652:
7115                     ; 4188     if (temp < 10) invalid = 1;
7117  0100 a3000a        	cpw	x,#10
7118  0103 2404          	jruge	L5652
7121  0105 a601          	ld	a,#1
7122  0107 6b03          	ld	(OFST+0,sp),a
7124  0109               L5652:
7125                     ; 4189     if (invalid == 0) {
7127  0109 7b03          	ld	a,(OFST+0,sp)
7128  010b 260c          	jrne	L7652
7129                     ; 4190       if (curr_ParseNum == 0) Pending_port = (uint16_t)temp;
7131  010d 7b05          	ld	a,(OFST+2,sp)
7132  010f 2605          	jrne	L1752
7135  0111 cf0000        	ldw	_Pending_port,x
7137  0114 2003          	jra	L7652
7138  0116               L1752:
7139                     ; 4192       else Pending_mqttport = (uint16_t)temp;
7141  0116 cf0000        	ldw	_Pending_mqttport,x
7142  0119               L7652:
7143                     ; 4197   if (tmp_nBytes == 0) {
7145  0119 ce000c        	ldw	x,_tmp_nBytes
7146  011c 2604          	jrne	L033
7147                     ; 4200     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
7149  011e 3502000a      	mov	_break_while,#2
7150                     ; 4203     return;
7151  0122               L033:
7154  0122 5b05          	addw	sp,#5
7155  0124 81            	ret	
7156                     ; 4205 }
7191                     	switch	.const
7192  1d20               L633:
7193  1d20 000e          	dc.w	L7752
7194  1d22 0016          	dc.w	L1062
7195  1d24 001e          	dc.w	L3062
7196  1d26 0026          	dc.w	L5062
7197  1d28 002e          	dc.w	L7062
7198  1d2a 0036          	dc.w	L1162
7199  1d2c 003e          	dc.w	L3162
7200  1d2e 0046          	dc.w	L5162
7201  1d30 004e          	dc.w	L7162
7202  1d32 0056          	dc.w	L1262
7203  1d34 005e          	dc.w	L3262
7204  1d36 0066          	dc.w	L5262
7205  1d38 006e          	dc.w	L7262
7206  1d3a 0076          	dc.w	L1362
7207  1d3c 007e          	dc.w	L3362
7208  1d3e 0086          	dc.w	L5362
7209                     ; 4208 uint8_t GpioGetPin(uint8_t nGpio)
7209                     ; 4209 {
7210                     .text:	section	.text,new
7211  0000               _GpioGetPin:
7215                     ; 4214   switch (nGpio) {
7218                     ; 4230     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7219  0000 a110          	cp	a,#16
7220  0002 2503cc008e    	jruge	L5562
7221  0007 5f            	clrw	x
7222  0008 97            	ld	xl,a
7223  0009 58            	sllw	x
7224  000a de1d20        	ldw	x,(L633,x)
7225  000d fc            	jp	(x)
7226  000e               L7752:
7227                     ; 4215     case 0:  if (IO_8to1  & (uint8_t)(0x01)) return 1; break;
7229  000e 720100007b    	btjf	_IO_8to1,#0,L5562
7232  0013 a601          	ld	a,#1
7235  0015 81            	ret	
7236  0016               L1062:
7237                     ; 4216     case 1:  if (IO_8to1  & (uint8_t)(0x02)) return 1; break;
7239  0016 7203000073    	btjf	_IO_8to1,#1,L5562
7242  001b a601          	ld	a,#1
7245  001d 81            	ret	
7246  001e               L3062:
7247                     ; 4217     case 2:  if (IO_8to1  & (uint8_t)(0x04)) return 1; break;
7249  001e 720500006b    	btjf	_IO_8to1,#2,L5562
7252  0023 a601          	ld	a,#1
7255  0025 81            	ret	
7256  0026               L5062:
7257                     ; 4218     case 3:  if (IO_8to1  & (uint8_t)(0x08)) return 1; break;
7259  0026 7207000063    	btjf	_IO_8to1,#3,L5562
7262  002b a601          	ld	a,#1
7265  002d 81            	ret	
7266  002e               L7062:
7267                     ; 4219     case 4:  if (IO_8to1  & (uint8_t)(0x10)) return 1; break;
7269  002e 720900005b    	btjf	_IO_8to1,#4,L5562
7272  0033 a601          	ld	a,#1
7275  0035 81            	ret	
7276  0036               L1162:
7277                     ; 4220     case 5:  if (IO_8to1  & (uint8_t)(0x20)) return 1; break;
7279  0036 720b000053    	btjf	_IO_8to1,#5,L5562
7282  003b a601          	ld	a,#1
7285  003d 81            	ret	
7286  003e               L3162:
7287                     ; 4221     case 6:  if (IO_8to1  & (uint8_t)(0x40)) return 1; break;
7289  003e 720d00004b    	btjf	_IO_8to1,#6,L5562
7292  0043 a601          	ld	a,#1
7295  0045 81            	ret	
7296  0046               L5162:
7297                     ; 4222     case 7:  if (IO_8to1  & (uint8_t)(0x80)) return 1; break;
7299  0046 720f000043    	btjf	_IO_8to1,#7,L5562
7302  004b a601          	ld	a,#1
7305  004d 81            	ret	
7306  004e               L7162:
7307                     ; 4223     case 8:  if (IO_16to9 & (uint8_t)(0x01)) return 1; break;
7309  004e 720100003b    	btjf	_IO_16to9,#0,L5562
7312  0053 a601          	ld	a,#1
7315  0055 81            	ret	
7316  0056               L1262:
7317                     ; 4224     case 9:  if (IO_16to9 & (uint8_t)(0x02)) return 1; break;
7319  0056 7203000033    	btjf	_IO_16to9,#1,L5562
7322  005b a601          	ld	a,#1
7325  005d 81            	ret	
7326  005e               L3262:
7327                     ; 4225     case 10: if (IO_16to9 & (uint8_t)(0x04)) return 1; break;
7329  005e 720500002b    	btjf	_IO_16to9,#2,L5562
7332  0063 a601          	ld	a,#1
7335  0065 81            	ret	
7336  0066               L5262:
7337                     ; 4226     case 11: if (IO_16to9 & (uint8_t)(0x08)) return 1; break;
7339  0066 7207000023    	btjf	_IO_16to9,#3,L5562
7342  006b a601          	ld	a,#1
7345  006d 81            	ret	
7346  006e               L7262:
7347                     ; 4227     case 12: if (IO_16to9 & (uint8_t)(0x10)) return 1; break;
7349  006e 720900001b    	btjf	_IO_16to9,#4,L5562
7352  0073 a601          	ld	a,#1
7355  0075 81            	ret	
7356  0076               L1362:
7357                     ; 4228     case 13: if (IO_16to9 & (uint8_t)(0x20)) return 1; break;
7359  0076 720b000013    	btjf	_IO_16to9,#5,L5562
7362  007b a601          	ld	a,#1
7365  007d 81            	ret	
7366  007e               L3362:
7367                     ; 4229     case 14: if (IO_16to9 & (uint8_t)(0x40)) return 1; break;
7369  007e 720d00000b    	btjf	_IO_16to9,#6,L5562
7372  0083 a601          	ld	a,#1
7375  0085 81            	ret	
7376  0086               L5362:
7377                     ; 4230     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7379  0086 720f000003    	btjf	_IO_16to9,#7,L5562
7382  008b a601          	ld	a,#1
7385  008d 81            	ret	
7386  008e               L5562:
7387                     ; 4232   return 0;
7389  008e 4f            	clr	a
7392  008f 81            	ret	
7439                     ; 4281 void GpioSetPin(uint8_t nGpio, uint8_t nState)
7439                     ; 4282 {
7440                     .text:	section	.text,new
7441  0000               _GpioSetPin:
7443  0000 89            	pushw	x
7444  0001 88            	push	a
7445       00000001      OFST:	set	1
7448                     ; 4289   mask = 0;
7450  0002 0f01          	clr	(OFST+0,sp)
7452                     ; 4291   switch(nGpio) {
7454  0004 9e            	ld	a,xh
7456                     ; 4300     default: break;
7457  0005 4d            	tnz	a
7458  0006 2717          	jreq	L7172
7459  0008 4a            	dec	a
7460  0009 2717          	jreq	L1272
7461  000b 4a            	dec	a
7462  000c 2718          	jreq	L3272
7463  000e 4a            	dec	a
7464  000f 2719          	jreq	L5272
7465  0011 4a            	dec	a
7466  0012 271a          	jreq	L7272
7467  0014 4a            	dec	a
7468  0015 271b          	jreq	L1372
7469  0017 4a            	dec	a
7470  0018 271c          	jreq	L3372
7471  001a 4a            	dec	a
7472  001b 271d          	jreq	L5372
7473  001d 201f          	jra	L3672
7474  001f               L7172:
7475                     ; 4292     case 0: mask = 0x01; break;
7477  001f 4c            	inc	a
7480  0020 201a          	jp	LC026
7481  0022               L1272:
7482                     ; 4293     case 1: mask = 0x02; break;
7484  0022 a602          	ld	a,#2
7487  0024 2016          	jp	LC026
7488  0026               L3272:
7489                     ; 4294     case 2: mask = 0x04; break;
7491  0026 a604          	ld	a,#4
7494  0028 2012          	jp	LC026
7495  002a               L5272:
7496                     ; 4295     case 3: mask = 0x08; break;
7498  002a a608          	ld	a,#8
7501  002c 200e          	jp	LC026
7502  002e               L7272:
7503                     ; 4296     case 4: mask = 0x10; break;
7505  002e a610          	ld	a,#16
7508  0030 200a          	jp	LC026
7509  0032               L1372:
7510                     ; 4297     case 5: mask = 0x20; break;
7512  0032 a620          	ld	a,#32
7515  0034 2006          	jp	LC026
7516  0036               L3372:
7517                     ; 4298     case 6: mask = 0x40; break;
7519  0036 a640          	ld	a,#64
7522  0038 2002          	jp	LC026
7523  003a               L5372:
7524                     ; 4299     case 7: mask = 0x80; break;
7526  003a a680          	ld	a,#128
7527  003c               LC026:
7528  003c 6b01          	ld	(OFST+0,sp),a
7532                     ; 4300     default: break;
7534  003e               L3672:
7535                     ; 4303   if (nState) IO_8to1 |= mask;
7537  003e 7b03          	ld	a,(OFST+2,sp)
7538  0040 2707          	jreq	L5672
7541  0042 c60000        	ld	a,_IO_8to1
7542  0045 1a01          	or	a,(OFST+0,sp)
7544  0047 2006          	jra	L7672
7545  0049               L5672:
7546                     ; 4304   else IO_8to1 &= (uint8_t)~mask;
7548  0049 7b01          	ld	a,(OFST+0,sp)
7549  004b 43            	cpl	a
7550  004c c40000        	and	a,_IO_8to1
7551  004f               L7672:
7552  004f c70000        	ld	_IO_8to1,a
7553                     ; 4306 }
7556  0052 5b03          	addw	sp,#3
7557  0054 81            	ret	
7618                     ; 4318 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7618                     ; 4319 {
7619                     .text:	section	.text,new
7620  0000               _SetMAC:
7622  0000 89            	pushw	x
7623  0001 5203          	subw	sp,#3
7624       00000003      OFST:	set	3
7627                     ; 4333   temp = 0;
7629                     ; 4334   invalid = 0;
7631  0003 0f01          	clr	(OFST-2,sp)
7633                     ; 4337   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7635  0005 9f            	ld	a,xl
7636  0006 a130          	cp	a,#48
7637  0008 250b          	jrult	L3303
7639  000a 9f            	ld	a,xl
7640  000b a13a          	cp	a,#58
7641  000d 2406          	jruge	L3303
7644  000f 7b05          	ld	a,(OFST+2,sp)
7645  0011 a030          	sub	a,#48
7647  0013 200c          	jp	LC027
7648  0015               L3303:
7649                     ; 4338   else if (alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7651  0015 7b05          	ld	a,(OFST+2,sp)
7652  0017 a161          	cp	a,#97
7653  0019 250a          	jrult	L7303
7655  001b a167          	cp	a,#103
7656  001d 2406          	jruge	L7303
7659  001f a057          	sub	a,#87
7660  0021               LC027:
7661  0021 6b05          	ld	(OFST+2,sp),a
7663  0023 2004          	jra	L5303
7664  0025               L7303:
7665                     ; 4339   else invalid = 1; // If an invalid entry set indicator
7667  0025 a601          	ld	a,#1
7668  0027 6b01          	ld	(OFST-2,sp),a
7670  0029               L5303:
7671                     ; 4341   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7673  0029 7b08          	ld	a,(OFST+5,sp)
7674  002b a130          	cp	a,#48
7675  002d 2508          	jrult	L3403
7677  002f a13a          	cp	a,#58
7678  0031 2404          	jruge	L3403
7681  0033 a030          	sub	a,#48
7683  0035 200a          	jp	LC028
7684  0037               L3403:
7685                     ; 4342   else if (alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7687  0037 a161          	cp	a,#97
7688  0039 250a          	jrult	L7403
7690  003b a167          	cp	a,#103
7691  003d 2406          	jruge	L7403
7694  003f a057          	sub	a,#87
7695  0041               LC028:
7696  0041 6b08          	ld	(OFST+5,sp),a
7698  0043 2004          	jra	L5403
7699  0045               L7403:
7700                     ; 4343   else invalid = 1; // If an invalid entry set indicator
7702  0045 a601          	ld	a,#1
7703  0047 6b01          	ld	(OFST-2,sp),a
7705  0049               L5403:
7706                     ; 4345   if (invalid == 0) { // Change value only if valid entry
7708  0049 7b01          	ld	a,(OFST-2,sp)
7709  004b 264a          	jrne	L3503
7710                     ; 4346     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7712  004d 7b05          	ld	a,(OFST+2,sp)
7713  004f 97            	ld	xl,a
7714  0050 a610          	ld	a,#16
7715  0052 42            	mul	x,a
7716  0053 01            	rrwa	x,a
7717  0054 1b08          	add	a,(OFST+5,sp)
7718  0056 5f            	clrw	x
7719  0057 97            	ld	xl,a
7720  0058 1f02          	ldw	(OFST-1,sp),x
7722                     ; 4347     switch(itemnum)
7724  005a 7b04          	ld	a,(OFST+1,sp)
7726                     ; 4355     default: break;
7727  005c 2711          	jreq	L1772
7728  005e 4a            	dec	a
7729  005f 2715          	jreq	L3772
7730  0061 4a            	dec	a
7731  0062 2719          	jreq	L5772
7732  0064 4a            	dec	a
7733  0065 271d          	jreq	L7772
7734  0067 4a            	dec	a
7735  0068 2721          	jreq	L1003
7736  006a 4a            	dec	a
7737  006b 2725          	jreq	L3003
7738  006d 2028          	jra	L3503
7739  006f               L1772:
7740                     ; 4349     case 0: Pending_uip_ethaddr_oct[5] = (uint8_t)temp; break;
7742  006f 7b03          	ld	a,(OFST+0,sp)
7743  0071 c70005        	ld	_Pending_uip_ethaddr_oct+5,a
7746  0074 2021          	jra	L3503
7747  0076               L3772:
7748                     ; 4350     case 1: Pending_uip_ethaddr_oct[4] = (uint8_t)temp; break;
7750  0076 7b03          	ld	a,(OFST+0,sp)
7751  0078 c70004        	ld	_Pending_uip_ethaddr_oct+4,a
7754  007b 201a          	jra	L3503
7755  007d               L5772:
7756                     ; 4351     case 2: Pending_uip_ethaddr_oct[3] = (uint8_t)temp; break;
7758  007d 7b03          	ld	a,(OFST+0,sp)
7759  007f c70003        	ld	_Pending_uip_ethaddr_oct+3,a
7762  0082 2013          	jra	L3503
7763  0084               L7772:
7764                     ; 4352     case 3: Pending_uip_ethaddr_oct[2] = (uint8_t)temp; break;
7766  0084 7b03          	ld	a,(OFST+0,sp)
7767  0086 c70002        	ld	_Pending_uip_ethaddr_oct+2,a
7770  0089 200c          	jra	L3503
7771  008b               L1003:
7772                     ; 4353     case 4: Pending_uip_ethaddr_oct[1] = (uint8_t)temp; break;
7774  008b 7b03          	ld	a,(OFST+0,sp)
7775  008d c70001        	ld	_Pending_uip_ethaddr_oct+1,a
7778  0090 2005          	jra	L3503
7779  0092               L3003:
7780                     ; 4354     case 5: Pending_uip_ethaddr_oct[0] = (uint8_t)temp; break;
7782  0092 7b03          	ld	a,(OFST+0,sp)
7783  0094 c70000        	ld	_Pending_uip_ethaddr_oct,a
7786                     ; 4355     default: break;
7788  0097               L3503:
7789                     ; 4358 }
7792  0097 5b05          	addw	sp,#5
7793  0099 81            	ret	
8187                     	switch	.bss
8188  0000               _insertion_flag:
8189  0000 000000        	ds.b	3
8190                     	xdef	_insertion_flag
8191                     	xref	_second_counter
8192                     	xref	_RXERIF_counter
8193                     	xref	_TXERIF_counter
8194                     	xref	_MQTT_error_status
8195                     	xref	_mqtt_start_status
8196                     	xref	_Pending_mqtt_password
8197                     	xref	_Pending_mqtt_username
8198                     	xref	_Pending_mqttport
8199                     	xref	_Pending_mqttserveraddr
8200                     	xref	_stored_mqtt_password
8201                     	xref	_stored_mqtt_username
8202                     	xref	_stored_mqttport
8203                     	xref	_stored_mqttserveraddr
8204  0003               _current_webpage:
8205  0003 00            	ds.b	1
8206                     	xdef	_current_webpage
8207  0004               _alpha:
8208  0004 000000000000  	ds.b	6
8209                     	xdef	_alpha
8210  000a               _break_while:
8211  000a 00            	ds.b	1
8212                     	xdef	_break_while
8213  000b               _tmp_nParseLeft:
8214  000b 00            	ds.b	1
8215                     	xdef	_tmp_nParseLeft
8216  000c               _tmp_nBytes:
8217  000c 0000          	ds.b	2
8218                     	xdef	_tmp_nBytes
8219  000e               _tmp_pBuffer:
8220  000e 0000          	ds.b	2
8221                     	xdef	_tmp_pBuffer
8222  0010               _z_diag:
8223  0010 00            	ds.b	1
8224                     	xdef	_z_diag
8225  0011               _saved_newlines:
8226  0011 00            	ds.b	1
8227                     	xdef	_saved_newlines
8228  0012               _saved_postpartial_previous:
8229  0012 000000000000  	ds.b	24
8230                     	xdef	_saved_postpartial_previous
8231  002a               _saved_postpartial:
8232  002a 000000000000  	ds.b	24
8233                     	xdef	_saved_postpartial
8234  0042               _saved_nparseleft:
8235  0042 00            	ds.b	1
8236                     	xdef	_saved_nparseleft
8237  0043               _saved_parsestate:
8238  0043 00            	ds.b	1
8239                     	xdef	_saved_parsestate
8240  0044               _saved_nstate:
8241  0044 00            	ds.b	1
8242                     	xdef	_saved_nstate
8243  0045               _OctetArray:
8244  0045 000000000000  	ds.b	11
8245                     	xdef	_OctetArray
8246                     	xref	_user_reboot_request
8247                     	xref	_parse_complete
8248                     	xref	_mac_string
8249                     	xref	_stored_config_settings
8250                     	xref	_stored_devicename
8251                     	xref	_stored_port
8252                     	xref	_stored_netmask
8253                     	xref	_stored_draddr
8254                     	xref	_stored_hostaddr
8255                     	xref	_Pending_uip_ethaddr_oct
8256                     	xref	_Pending_config_settings
8257                     	xref	_Pending_devicename
8258                     	xref	_Pending_port
8259                     	xref	_Pending_netmask
8260                     	xref	_Pending_draddr
8261                     	xref	_Pending_hostaddr
8262                     	xref	_invert_input
8263                     	xref	_IO_8to1
8264                     	xref	_IO_16to9
8265                     	xref	_Port_Httpd
8266                     	xref	_strlen
8267                     	xref	_debugflash
8268                     	xref	_uip_flags
8269                     	xref	_uip_conn
8270                     	xref	_uip_len
8271                     	xref	_uip_appdata
8272                     	xref	_htons
8273                     	xref	_uip_send
8274                     	xref	_uip_listen
8275                     	xref	_uip_init_stats
8276                     	xdef	_SetMAC
8277                     	xdef	_clear_saved_postpartial_previous
8278                     	xdef	_clear_saved_postpartial_data
8279                     	xdef	_clear_saved_postpartial_all
8280                     	xdef	_GpioSetPin
8281                     	xdef	_GpioGetPin
8282                     	xdef	_parse_POST_port
8283                     	xdef	_parse_POST_address
8284                     	xdef	_parse_POST_string
8285                     	xdef	_HttpDCall
8286                     	xdef	_HttpDInit
8287                     	xdef	_emb_itoa
8288                     	xdef	_adjust_template_size
8289                     	switch	.const
8290  1d40               L333:
8291  1d40 436f6e6e6563  	dc.b	"Connection:close",13
8292  1d51 0a00          	dc.b	10,0
8293  1d53               L133:
8294  1d53 436f6e74656e  	dc.b	"Content-Type: text"
8295  1d65 2f68746d6c3b  	dc.b	"/html; charset=utf"
8296  1d77 2d380d        	dc.b	"-8",13
8297  1d7a 0a00          	dc.b	10,0
8298  1d7c               L723:
8299  1d7c 43616368652d  	dc.b	"Cache-Control: no-"
8300  1d8e 63616368652c  	dc.b	"cache, no-store",13
8301  1d9e 0a00          	dc.b	10,0
8302  1da0               L713:
8303  1da0 436f6e74656e  	dc.b	"Content-Length:",0
8304  1db0               L513:
8305  1db0 0d0a00        	dc.b	13,10,0
8306  1db3               L313:
8307  1db3 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8308                     	xref.b	c_lreg
8309                     	xref.b	c_x
8310                     	xref.b	c_y
8330                     	xref	c_imul
8331                     	xref	c_uitolx
8332                     	xref	c_ludv
8333                     	xref	c_lumd
8334                     	xref	c_rtol
8335                     	xref	c_ltor
8336                     	xref	c_lzmp
8337                     	end
