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
 379  17b8 362031353237  	dc.b	"6 1527</p>%y03/91%"
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
 416  1a06 6561643e3c74  	dc.b	"ead><title>Help Pa"
 417  1a18 676520323c2f  	dc.b	"ge 2</title><link "
 418  1a2a 72656c3d2769  	dc.b	"rel='icon' href='d"
 419  1a3c 6174613a2c27  	dc.b	"ata:,'></head><bod"
 420  1a4e 793e3c703e25  	dc.b	"y><p>%f00</p></bod"
 421  1a60 793e3c2f6874  	dc.b	"y></html>",0
 422  1a6a               L32_page_string00:
 423  1a6a 706174746572  	dc.b	"pattern='[0-9]{3}'"
 424  1a7c 207469746c65  	dc.b	" title='Enter 000 "
 425  1a8e 746f20323535  	dc.b	"to 255' maxlength="
 426  1aa0 2733273e3c2f  	dc.b	"'3'></td>",0
 427  1aaa               L52_page_string00_len:
 428  1aaa 3f            	dc.b	63
 429  1aab               L72_page_string00_len_less4:
 430  1aab 3b            	dc.b	59
 431  1aac               L13_page_string01:
 432  1aac 706174746572  	dc.b	"pattern='[0-9a-f]{"
 433  1abe 327d27207469  	dc.b	"2}' title='Enter 0"
 434  1ad0 3020746f2066  	dc.b	"0 to ff' maxlength"
 435  1ae2 3d2732273e3c  	dc.b	"='2'></td>",0
 436  1aed               L33_page_string01_len:
 437  1aed 40            	dc.b	64
 438  1aee               L53_page_string01_len_less4:
 439  1aee 3c            	dc.b	60
 440  1aef               L73_page_string02:
 441  1aef 27206d657468  	dc.b	"' method='GET'><bu"
 442  1b01 74746f6e2074  	dc.b	"tton title='Save f"
 443  1b13 697273742120  	dc.b	"irst! This button "
 444  1b25 77696c6c206e  	dc.b	"will not save your"
 445  1b37 206368616e67  	dc.b	" changes'>",0
 446  1b42               L14_page_string02_len:
 447  1b42 52            	dc.b	82
 448  1b43               L34_page_string02_len_less4:
 449  1b43 4e            	dc.b	78
 450  1b44               L54_page_string03:
 451  1b44 3c666f726d20  	dc.b	"<form style='displ"
 452  1b56 61793a20696e  	dc.b	"ay: inline' action"
 453  1b68 3d2700        	dc.b	"='",0
 454  1b6b               L74_page_string03_len:
 455  1b6b 26            	dc.b	38
 456  1b6c               L15_page_string03_len_less4:
 457  1b6c 22            	dc.b	34
 458  1b6d               L35_page_string04:
 459  1b6d 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 460  1b7f 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 461  1b91 6561643e3c6c  	dc.b	"ead><link rel='ico"
 462  1ba3 6e2720687265  	dc.b	"n' href='data:,'>",0
 463  1bb5               L55_page_string04_len:
 464  1bb5 47            	dc.b	71
 465  1bb6               L75_page_string04_len_less4:
 466  1bb6 43            	dc.b	67
 467  1bb7               L16_page_string05:
 468  1bb7 3c7374796c65  	dc.b	"<style>.s0 { backg"
 469  1bc9 726f756e642d  	dc.b	"round-color: red; "
 470  1bdb 77696474683a  	dc.b	"width: 30px; }.s1 "
 471  1bed 7b206261636b  	dc.b	"{ background-color"
 472  1bff 3a2067726565  	dc.b	": green; width: 30"
 473  1c11 70783b207d2e  	dc.b	"px; }.t1 { width: "
 474  1c23 31323070783b  	dc.b	"120px; }.t2 { widt"
 475  1c35 683a20313438  	dc.b	"h: 148px; }.t3 { w"
 476  1c47 696474683a20  	dc.b	"idth: 30px; }.t5 {"
 477  1c59 207769647468  	dc.b	" width: 60px; }.t6"
 478  1c6b 207b20776964  	dc.b	" { width: 25px; }."
 479  1c7d 7437207b2077  	dc.b	"t7 { width: 18px; "
 480  1c8f 7d2e7438207b  	dc.b	"}.t8 { width: 40px"
 481  1ca1 3b207d00      	dc.b	"; }",0
 482  1ca5               L36_page_string05_len:
 483  1ca5 ed            	dc.b	237
 484  1ca6               L56_page_string05_len_less4:
 485  1ca6 e9            	dc.b	233
 486  1ca7               L76_page_string06:
 487  1ca7 7464207b2074  	dc.b	"td { text-align: c"
 488  1cb9 656e7465723b  	dc.b	"enter; border: 1px"
 489  1ccb 20626c61636b  	dc.b	" black solid; }</s"
 490  1cdd 74796c653e00  	dc.b	"tyle>",0
 491  1ce3               L17_page_string06_len:
 492  1ce3 3b            	dc.b	59
 493  1ce4               L37_page_string06_len_less4:
 494  1ce4 37            	dc.b	55
 549                     ; 1206 uint16_t adjust_template_size()
 549                     ; 1207 {
 551                     .text:	section	.text,new
 552  0000               _adjust_template_size:
 554  0000 89            	pushw	x
 555       00000002      OFST:	set	2
 558                     ; 1225   size = 0;
 560  0001 5f            	clrw	x
 561  0002 1f01          	ldw	(OFST-1,sp),x
 563                     ; 1230   if (current_webpage == WEBPAGE_IOCONTROL) {
 565  0004 c60003        	ld	a,_current_webpage
 566  0007 2613          	jrne	L711
 567                     ; 1231     size = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
 569                     ; 1234     size = size + page_string04_len_less4
 569                     ; 1235                 + page_string05_len_less4
 569                     ; 1236 		+ page_string06_len_less4;
 571  0009 ae0d69        	ldw	x,#3433
 572  000c 1f01          	ldw	(OFST-1,sp),x
 574                     ; 1241     size = size + strlen(stored_devicename) - 4 ;
 576  000e ae0000        	ldw	x,#_stored_devicename
 577  0011 cd0000        	call	_strlen
 579  0014 72fb01        	addw	x,(OFST-1,sp)
 580  0017 1c00a4        	addw	x,#164
 582                     ; 1248     size = size - 48;
 585                     ; 1264     size = size - 8;
 588                     ; 1278     size = size + (2 * page_string03_len_less4);
 591                     ; 1307     size = size + (2 * (page_string02_len_less4));
 595  001a 2046          	jra	L121
 596  001c               L711:
 597                     ; 1326   else if (current_webpage == WEBPAGE_CONFIGURATION) {
 599  001c a101          	cp	a,#1
 600  001e 2632          	jrne	L321
 601                     ; 1327     size = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
 603                     ; 1330     size = size + page_string04_len_less4
 603                     ; 1331                 + page_string05_len_less4
 603                     ; 1332 		+ page_string06_len_less4;
 605  0020 ae0dbf        	ldw	x,#3519
 606  0023 1f01          	ldw	(OFST-1,sp),x
 608                     ; 1337     size = size + strlen(stored_devicename) - 4 ;
 610  0025 ae0000        	ldw	x,#_stored_devicename
 611  0028 cd0000        	call	_strlen
 613  002b 72fb01        	addw	x,(OFST-1,sp)
 614  002e 1d001c        	subw	x,#28
 616                     ; 1344     size = size - 12;
 619                     ; 1351     size = size + 1;
 622                     ; 1358     size = size - 12;
 625                     ; 1366     size = size + 2;
 628                     ; 1374     size = size - 4;
 631                     ; 1381     size = size + 1;
 633  0031 1f01          	ldw	(OFST-1,sp),x
 635                     ; 1386     size = size + (strlen(stored_mqtt_username) - 4);
 637  0033 ae0000        	ldw	x,#_stored_mqtt_username
 638  0036 cd0000        	call	_strlen
 640  0039 1d0004        	subw	x,#4
 641  003c 72fb01        	addw	x,(OFST-1,sp)
 642  003f 1f01          	ldw	(OFST-1,sp),x
 644                     ; 1391     size = size + (strlen(stored_mqtt_password) - 4);
 646  0041 ae0000        	ldw	x,#_stored_mqtt_password
 647  0044 cd0000        	call	_strlen
 649  0047 1d0004        	subw	x,#4
 650  004a 72fb01        	addw	x,(OFST-1,sp)
 652                     ; 1398     size = size - 15;
 654  004d 1c06c9        	addw	x,#1737
 656                     ; 1412     size = size + (3 * page_string03_len_less4);
 659                     ; 1418     size = size + page_string03_len_less4;
 662                     ; 1441     size = size + (12 * (page_string00_len_less4));
 665                     ; 1450     size = size + (4 * (page_string00_len_less4));
 668                     ; 1460     size = size + (6 * (page_string01_len_less4));
 671                     ; 1469     size = size + (3 * (page_string02_len_less4));
 674                     ; 1484     size = size + page_string02_len_less4;
 678  0050 2010          	jra	L121
 679  0052               L321:
 680                     ; 1558   else if (current_webpage == WEBPAGE_STATS) {
 682  0052 a105          	cp	a,#5
 683  0054 2605          	jrne	L721
 684                     ; 1559     size = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
 686                     ; 1566     size = size + 24;
 688                     ; 1575     size = size + (2 * page_string03_len_less4);
 690  0056 ae01d1        	ldw	x,#465
 693  0059 2007          	jra	L121
 694  005b               L721:
 695                     ; 1583   else if (current_webpage == WEBPAGE_RSTATE) {
 697  005b a106          	cp	a,#6
 698  005d 2603          	jrne	L121
 699                     ; 1584     size = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
 701                     ; 1589     size = size + 12;
 703  005f ae0093        	ldw	x,#147
 705  0062               L121:
 706                     ; 1592   return size;
 710  0062 5b02          	addw	sp,#2
 711  0064 81            	ret	
 802                     ; 1596 void emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
 802                     ; 1597 {
 803                     .text:	section	.text,new
 804  0000               _emb_itoa:
 806  0000 5207          	subw	sp,#7
 807       00000007      OFST:	set	7
 810                     ; 1615   for (i=0; i < pad; i++) str[i] = '0';
 812  0002 0f07          	clr	(OFST+0,sp)
 815  0004 200a          	jra	L771
 816  0006               L371:
 819  0006 5f            	clrw	x
 820  0007 97            	ld	xl,a
 821  0008 72fb0e        	addw	x,(OFST+7,sp)
 822  000b a630          	ld	a,#48
 823  000d f7            	ld	(x),a
 826  000e 0c07          	inc	(OFST+0,sp)
 828  0010               L771:
 831  0010 7b07          	ld	a,(OFST+0,sp)
 832  0012 1111          	cp	a,(OFST+10,sp)
 833  0014 25f0          	jrult	L371
 834                     ; 1616   str[pad] = '\0';
 836  0016 7b11          	ld	a,(OFST+10,sp)
 837  0018 5f            	clrw	x
 838  0019 97            	ld	xl,a
 839  001a 72fb0e        	addw	x,(OFST+7,sp)
 840  001d 7f            	clr	(x)
 841                     ; 1617   if (num == 0) return;
 843  001e 96            	ldw	x,sp
 844  001f 1c000a        	addw	x,#OFST+3
 845  0022 cd0000        	call	c_lzmp
 847  0025 2603cc00cf    	jreq	L02
 850                     ; 1620   i = 0;
 852  002a 0f07          	clr	(OFST+0,sp)
 855  002c 2060          	jra	L112
 856  002e               L502:
 857                     ; 1622     rem = (uint8_t)(num % base);
 859  002e 7b10          	ld	a,(OFST+9,sp)
 860  0030 b703          	ld	c_lreg+3,a
 861  0032 3f02          	clr	c_lreg+2
 862  0034 3f01          	clr	c_lreg+1
 863  0036 3f00          	clr	c_lreg
 864  0038 96            	ldw	x,sp
 865  0039 5c            	incw	x
 866  003a cd0000        	call	c_rtol
 869  003d 96            	ldw	x,sp
 870  003e 1c000a        	addw	x,#OFST+3
 871  0041 cd0000        	call	c_ltor
 873  0044 96            	ldw	x,sp
 874  0045 5c            	incw	x
 875  0046 cd0000        	call	c_lumd
 877  0049 b603          	ld	a,c_lreg+3
 878  004b 6b06          	ld	(OFST-1,sp),a
 880                     ; 1623     if (rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
 882  004d a10a          	cp	a,#10
 883  004f 7b07          	ld	a,(OFST+0,sp)
 884  0051 250d          	jrult	L512
 887  0053 0c07          	inc	(OFST+0,sp)
 889  0055 5f            	clrw	x
 890  0056 97            	ld	xl,a
 891  0057 72fb0e        	addw	x,(OFST+7,sp)
 892  005a 7b06          	ld	a,(OFST-1,sp)
 893  005c ab57          	add	a,#87
 895  005e 200b          	jra	L712
 896  0060               L512:
 897                     ; 1624     else str[i++] = (uint8_t)(rem + '0');
 899  0060 0c07          	inc	(OFST+0,sp)
 901  0062 5f            	clrw	x
 902  0063 97            	ld	xl,a
 903  0064 72fb0e        	addw	x,(OFST+7,sp)
 904  0067 7b06          	ld	a,(OFST-1,sp)
 905  0069 ab30          	add	a,#48
 906  006b               L712:
 907  006b f7            	ld	(x),a
 908                     ; 1625     num = num/base;
 910  006c 7b10          	ld	a,(OFST+9,sp)
 911  006e b703          	ld	c_lreg+3,a
 912  0070 3f02          	clr	c_lreg+2
 913  0072 3f01          	clr	c_lreg+1
 914  0074 3f00          	clr	c_lreg
 915  0076 96            	ldw	x,sp
 916  0077 5c            	incw	x
 917  0078 cd0000        	call	c_rtol
 920  007b 96            	ldw	x,sp
 921  007c 1c000a        	addw	x,#OFST+3
 922  007f cd0000        	call	c_ltor
 924  0082 96            	ldw	x,sp
 925  0083 5c            	incw	x
 926  0084 cd0000        	call	c_ludv
 928  0087 96            	ldw	x,sp
 929  0088 1c000a        	addw	x,#OFST+3
 930  008b cd0000        	call	c_rtol
 932  008e               L112:
 933                     ; 1621   while (num != 0) {
 935  008e 96            	ldw	x,sp
 936  008f 1c000a        	addw	x,#OFST+3
 937  0092 cd0000        	call	c_lzmp
 939  0095 2697          	jrne	L502
 940                     ; 1634     start = 0;
 942  0097 0f06          	clr	(OFST-1,sp)
 944                     ; 1635     end = (uint8_t)(pad - 1);
 946  0099 7b11          	ld	a,(OFST+10,sp)
 947  009b 4a            	dec	a
 948  009c 6b07          	ld	(OFST+0,sp),a
 951  009e 2029          	jra	L522
 952  00a0               L122:
 953                     ; 1638       temp = str[start];
 955  00a0 5f            	clrw	x
 956  00a1 97            	ld	xl,a
 957  00a2 72fb0e        	addw	x,(OFST+7,sp)
 958  00a5 f6            	ld	a,(x)
 959  00a6 6b05          	ld	(OFST-2,sp),a
 961                     ; 1639       str[start] = str[end];
 963  00a8 5f            	clrw	x
 964  00a9 7b06          	ld	a,(OFST-1,sp)
 965  00ab 97            	ld	xl,a
 966  00ac 72fb0e        	addw	x,(OFST+7,sp)
 967  00af 7b07          	ld	a,(OFST+0,sp)
 968  00b1 905f          	clrw	y
 969  00b3 9097          	ld	yl,a
 970  00b5 72f90e        	addw	y,(OFST+7,sp)
 971  00b8 90f6          	ld	a,(y)
 972  00ba f7            	ld	(x),a
 973                     ; 1640       str[end] = temp;
 975  00bb 5f            	clrw	x
 976  00bc 7b07          	ld	a,(OFST+0,sp)
 977  00be 97            	ld	xl,a
 978  00bf 72fb0e        	addw	x,(OFST+7,sp)
 979  00c2 7b05          	ld	a,(OFST-2,sp)
 980  00c4 f7            	ld	(x),a
 981                     ; 1641       start++;
 983  00c5 0c06          	inc	(OFST-1,sp)
 985                     ; 1642       end--;
 987  00c7 0a07          	dec	(OFST+0,sp)
 989  00c9               L522:
 990                     ; 1637     while (start < end) {
 990                     ; 1638       temp = str[start];
 990                     ; 1639       str[start] = str[end];
 990                     ; 1640       str[end] = temp;
 990                     ; 1641       start++;
 990                     ; 1642       end--;
 992  00c9 7b06          	ld	a,(OFST-1,sp)
 993  00cb 1107          	cp	a,(OFST+0,sp)
 994  00cd 25d1          	jrult	L122
 995                     ; 1645 }
 996  00cf               L02:
 999  00cf 5b07          	addw	sp,#7
1000  00d1 81            	ret	
1060                     ; 1648 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1060                     ; 1649 {
1061                     .text:	section	.text,new
1062  0000               L3_CopyStringP:
1064  0000 89            	pushw	x
1065  0001 5203          	subw	sp,#3
1066       00000003      OFST:	set	3
1069                     ; 1654   nBytes = 0;
1071  0003 5f            	clrw	x
1073  0004 2014          	jra	L362
1074  0006               L752:
1075                     ; 1656     **ppBuffer = Character;
1077  0006 1e04          	ldw	x,(OFST+1,sp)
1078  0008 fe            	ldw	x,(x)
1079  0009 f7            	ld	(x),a
1080                     ; 1657     *ppBuffer = *ppBuffer + 1;
1082  000a 1e04          	ldw	x,(OFST+1,sp)
1083  000c 9093          	ldw	y,x
1084  000e fe            	ldw	x,(x)
1085  000f 5c            	incw	x
1086  0010 90ff          	ldw	(y),x
1087                     ; 1658     pString = pString + 1;
1089  0012 1e08          	ldw	x,(OFST+5,sp)
1090  0014 5c            	incw	x
1091  0015 1f08          	ldw	(OFST+5,sp),x
1092                     ; 1659     nBytes++;
1094  0017 1e01          	ldw	x,(OFST-2,sp)
1095  0019 5c            	incw	x
1096  001a               L362:
1097  001a 1f01          	ldw	(OFST-2,sp),x
1099                     ; 1655   while ((Character = pString[0]) != '\0') {
1099                     ; 1656     **ppBuffer = Character;
1099                     ; 1657     *ppBuffer = *ppBuffer + 1;
1099                     ; 1658     pString = pString + 1;
1099                     ; 1659     nBytes++;
1101  001c 1e08          	ldw	x,(OFST+5,sp)
1102  001e f6            	ld	a,(x)
1103  001f 6b03          	ld	(OFST+0,sp),a
1105  0021 26e3          	jrne	L752
1106                     ; 1661   return nBytes;
1108  0023 1e01          	ldw	x,(OFST-2,sp)
1111  0025 5b05          	addw	sp,#5
1112  0027 81            	ret	
1171                     ; 1665 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint16_t nDataLen)
1171                     ; 1666 {
1172                     .text:	section	.text,new
1173  0000               L5_CopyHttpHeader:
1175  0000 89            	pushw	x
1176  0001 5203          	subw	sp,#3
1177       00000003      OFST:	set	3
1180                     ; 1670   nBytes = 0;
1182  0003 5f            	clrw	x
1183  0004 1f02          	ldw	(OFST-1,sp),x
1185                     ; 1672   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
1187  0006 ae1dd8        	ldw	x,#L313
1188  0009 89            	pushw	x
1189  000a 96            	ldw	x,sp
1190  000b 1c0006        	addw	x,#OFST+3
1191  000e cd0000        	call	L3_CopyStringP
1193  0011 5b02          	addw	sp,#2
1194  0013 72fb02        	addw	x,(OFST-1,sp)
1195  0016 1f02          	ldw	(OFST-1,sp),x
1197                     ; 1673   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1199  0018 ae1dd5        	ldw	x,#L513
1200  001b 89            	pushw	x
1201  001c 96            	ldw	x,sp
1202  001d 1c0006        	addw	x,#OFST+3
1203  0020 cd0000        	call	L3_CopyStringP
1205  0023 5b02          	addw	sp,#2
1206  0025 72fb02        	addw	x,(OFST-1,sp)
1207  0028 1f02          	ldw	(OFST-1,sp),x
1209                     ; 1675   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
1211  002a ae1dc5        	ldw	x,#L713
1212  002d 89            	pushw	x
1213  002e 96            	ldw	x,sp
1214  002f 1c0006        	addw	x,#OFST+3
1215  0032 cd0000        	call	L3_CopyStringP
1217  0035 5b02          	addw	sp,#2
1218  0037 72fb02        	addw	x,(OFST-1,sp)
1219  003a 1f02          	ldw	(OFST-1,sp),x
1221                     ; 1679   emb_itoa(nDataLen, OctetArray, 10, 5);
1223  003c 4b05          	push	#5
1224  003e 4b0a          	push	#10
1225  0040 ae0045        	ldw	x,#_OctetArray
1226  0043 89            	pushw	x
1227  0044 1e0c          	ldw	x,(OFST+9,sp)
1228  0046 cd0000        	call	c_uitolx
1230  0049 be02          	ldw	x,c_lreg+2
1231  004b 89            	pushw	x
1232  004c be00          	ldw	x,c_lreg
1233  004e 89            	pushw	x
1234  004f cd0000        	call	_emb_itoa
1236  0052 5b08          	addw	sp,#8
1237                     ; 1680   for (i=0; i<5; i++) {
1239  0054 4f            	clr	a
1240  0055 6b01          	ld	(OFST-2,sp),a
1242  0057               L123:
1243                     ; 1681     *pBuffer = (uint8_t)OctetArray[i];
1245  0057 5f            	clrw	x
1246  0058 97            	ld	xl,a
1247  0059 d60045        	ld	a,(_OctetArray,x)
1248  005c 1e04          	ldw	x,(OFST+1,sp)
1249  005e f7            	ld	(x),a
1250                     ; 1682     pBuffer = pBuffer + 1;
1252  005f 5c            	incw	x
1253  0060 1f04          	ldw	(OFST+1,sp),x
1254                     ; 1680   for (i=0; i<5; i++) {
1256  0062 0c01          	inc	(OFST-2,sp)
1260  0064 7b01          	ld	a,(OFST-2,sp)
1261  0066 a105          	cp	a,#5
1262  0068 25ed          	jrult	L123
1263                     ; 1684   nBytes += 5;
1265  006a 1e02          	ldw	x,(OFST-1,sp)
1266  006c 1c0005        	addw	x,#5
1267  006f 1f02          	ldw	(OFST-1,sp),x
1269                     ; 1686   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1271  0071 ae1dd5        	ldw	x,#L513
1272  0074 89            	pushw	x
1273  0075 96            	ldw	x,sp
1274  0076 1c0006        	addw	x,#OFST+3
1275  0079 cd0000        	call	L3_CopyStringP
1277  007c 5b02          	addw	sp,#2
1278  007e 72fb02        	addw	x,(OFST-1,sp)
1279  0081 1f02          	ldw	(OFST-1,sp),x
1281                     ; 1689   nBytes += CopyStringP(&pBuffer, (const char *)("Cache-Control: no-cache, no-store\r\n"));
1283  0083 ae1da1        	ldw	x,#L723
1284  0086 89            	pushw	x
1285  0087 96            	ldw	x,sp
1286  0088 1c0006        	addw	x,#OFST+3
1287  008b cd0000        	call	L3_CopyStringP
1289  008e 5b02          	addw	sp,#2
1290  0090 72fb02        	addw	x,(OFST-1,sp)
1291  0093 1f02          	ldw	(OFST-1,sp),x
1293                     ; 1691   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type: text/html; charset=utf-8\r\n"));
1295  0095 ae1d78        	ldw	x,#L133
1296  0098 89            	pushw	x
1297  0099 96            	ldw	x,sp
1298  009a 1c0006        	addw	x,#OFST+3
1299  009d cd0000        	call	L3_CopyStringP
1301  00a0 5b02          	addw	sp,#2
1302  00a2 72fb02        	addw	x,(OFST-1,sp)
1303  00a5 1f02          	ldw	(OFST-1,sp),x
1305                     ; 1693   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
1307  00a7 ae1d65        	ldw	x,#L333
1308  00aa 89            	pushw	x
1309  00ab 96            	ldw	x,sp
1310  00ac 1c0006        	addw	x,#OFST+3
1311  00af cd0000        	call	L3_CopyStringP
1313  00b2 5b02          	addw	sp,#2
1314  00b4 72fb02        	addw	x,(OFST-1,sp)
1315  00b7 1f02          	ldw	(OFST-1,sp),x
1317                     ; 1694   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1319  00b9 ae1dd5        	ldw	x,#L513
1320  00bc 89            	pushw	x
1321  00bd 96            	ldw	x,sp
1322  00be 1c0006        	addw	x,#OFST+3
1323  00c1 cd0000        	call	L3_CopyStringP
1325  00c4 5b02          	addw	sp,#2
1326  00c6 72fb02        	addw	x,(OFST-1,sp)
1328                     ; 1696   return nBytes;
1332  00c9 5b05          	addw	sp,#5
1333  00cb 81            	ret	
1490                     	switch	.const
1491  1ce5               L431:
1492  1ce5 01ad          	dc.w	L533
1493  1ce7 01bb          	dc.w	L733
1494  1ce9 01c9          	dc.w	L143
1495  1ceb 01d7          	dc.w	L343
1496  1ced 01e5          	dc.w	L543
1497  1cef 01f3          	dc.w	L743
1498  1cf1 0201          	dc.w	L153
1499  1cf3 020e          	dc.w	L353
1500  1cf5 021b          	dc.w	L553
1501  1cf7 0228          	dc.w	L753
1502  1cf9 0235          	dc.w	L163
1503  1cfb 0242          	dc.w	L363
1504  1cfd 024f          	dc.w	L563
1505  1cff 025c          	dc.w	L763
1506  1d01 0269          	dc.w	L173
1507  1d03 0276          	dc.w	L373
1508                     ; 1700 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
1508                     ; 1701 {
1509                     .text:	section	.text,new
1510  0000               L7_CopyHttpData:
1512  0000 89            	pushw	x
1513  0001 5208          	subw	sp,#8
1514       00000008      OFST:	set	8
1517                     ; 1720   nBytes = 0;
1519  0003 5f            	clrw	x
1520  0004 1f05          	ldw	(OFST-3,sp),x
1522                     ; 1721   nParsedNum = 0;
1524  0006 0f07          	clr	(OFST-1,sp)
1526                     ; 1722   nParsedMode = 0;
1528  0008 0f04          	clr	(OFST-4,sp)
1530                     ; 1777   nMaxBytes = UIP_TCP_MSS - 25;
1532  000a ae019f        	ldw	x,#415
1533  000d 1f11          	ldw	(OFST+9,sp),x
1535  000f cc05df        	jra	L515
1536  0012               L315:
1537                     ; 1811     if (*pDataLeft > 0) {
1539  0012 1e0f          	ldw	x,(OFST+7,sp)
1540  0014 e601          	ld	a,(1,x)
1541  0016 fa            	or	a,(x)
1542  0017 2603cc05e8    	jreq	L715
1543                     ; 1818       if (insertion_flag[0] != 0) {
1545  001c c60000        	ld	a,_insertion_flag
1546  001f 2711          	jreq	L325
1547                     ; 1827         nParsedMode = insertion_flag[1];
1549  0021 c60001        	ld	a,_insertion_flag+1
1550  0024 6b04          	ld	(OFST-4,sp),a
1552                     ; 1828         nParsedNum = insertion_flag[2];
1554  0026 c60002        	ld	a,_insertion_flag+2
1555  0029 6b07          	ld	(OFST-1,sp),a
1557                     ; 1829 	nByte = '0'; // Need to set nByte to something other than '%' so we
1559  002b a630          	ld	a,#48
1560  002d 6b02          	ld	(OFST-6,sp),a
1563  002f cc00f1        	jra	L525
1564  0032               L325:
1565                     ; 1842         memcpy(&nByte, *ppData, 1);
1567  0032 96            	ldw	x,sp
1568  0033 1c0002        	addw	x,#OFST-6
1569  0036 bf00          	ldw	c_x,x
1570  0038 160d          	ldw	y,(OFST+5,sp)
1571  003a 90fe          	ldw	y,(y)
1572  003c 90bf00        	ldw	c_y,y
1573  003f ae0001        	ldw	x,#1
1574  0042               L25:
1575  0042 5a            	decw	x
1576  0043 92d600        	ld	a,([c_y.w],x)
1577  0046 92d700        	ld	([c_x.w],x),a
1578  0049 5d            	tnzw	x
1579  004a 26f6          	jrne	L25
1580                     ; 1885         if (nByte == '%') {
1582  004c 7b02          	ld	a,(OFST-6,sp)
1583  004e a125          	cp	a,#37
1584  0050 26dd          	jrne	L525
1585                     ; 1886           *ppData = *ppData + 1;
1587  0052 1e0d          	ldw	x,(OFST+5,sp)
1588  0054 9093          	ldw	y,x
1589  0056 fe            	ldw	x,(x)
1590  0057 5c            	incw	x
1591  0058 90ff          	ldw	(y),x
1592                     ; 1887           *pDataLeft = *pDataLeft - 1;
1594  005a 1e0f          	ldw	x,(OFST+7,sp)
1595  005c 9093          	ldw	y,x
1596  005e fe            	ldw	x,(x)
1597  005f 5a            	decw	x
1598  0060 90ff          	ldw	(y),x
1599                     ; 1892           memcpy(&nParsedMode, *ppData, 1);
1601  0062 96            	ldw	x,sp
1602  0063 1c0004        	addw	x,#OFST-4
1603  0066 bf00          	ldw	c_x,x
1604  0068 160d          	ldw	y,(OFST+5,sp)
1605  006a 90fe          	ldw	y,(y)
1606  006c 90bf00        	ldw	c_y,y
1607  006f ae0001        	ldw	x,#1
1608  0072               L45:
1609  0072 5a            	decw	x
1610  0073 92d600        	ld	a,([c_y.w],x)
1611  0076 92d700        	ld	([c_x.w],x),a
1612  0079 5d            	tnzw	x
1613  007a 26f6          	jrne	L45
1614                     ; 1893           *ppData = *ppData + 1;
1616  007c 1e0d          	ldw	x,(OFST+5,sp)
1617  007e 9093          	ldw	y,x
1618  0080 fe            	ldw	x,(x)
1619  0081 5c            	incw	x
1620  0082 90ff          	ldw	(y),x
1621                     ; 1894           *pDataLeft = *pDataLeft - 1;
1623  0084 1e0f          	ldw	x,(OFST+7,sp)
1624  0086 9093          	ldw	y,x
1625  0088 fe            	ldw	x,(x)
1626  0089 5a            	decw	x
1627  008a 90ff          	ldw	(y),x
1628                     ; 1899           memcpy(&temp, *ppData, 1);
1630  008c 96            	ldw	x,sp
1631  008d 5c            	incw	x
1632  008e bf00          	ldw	c_x,x
1633  0090 160d          	ldw	y,(OFST+5,sp)
1634  0092 90fe          	ldw	y,(y)
1635  0094 90bf00        	ldw	c_y,y
1636  0097 ae0001        	ldw	x,#1
1637  009a               L65:
1638  009a 5a            	decw	x
1639  009b 92d600        	ld	a,([c_y.w],x)
1640  009e 92d700        	ld	([c_x.w],x),a
1641  00a1 5d            	tnzw	x
1642  00a2 26f6          	jrne	L65
1643                     ; 1900           nParsedNum = (uint8_t)((temp - '0') * 10);
1645  00a4 7b01          	ld	a,(OFST-7,sp)
1646  00a6 97            	ld	xl,a
1647  00a7 a60a          	ld	a,#10
1648  00a9 42            	mul	x,a
1649  00aa 9f            	ld	a,xl
1650  00ab a0e0          	sub	a,#224
1651  00ad 6b07          	ld	(OFST-1,sp),a
1653                     ; 1901           *ppData = *ppData + 1;
1655  00af 1e0d          	ldw	x,(OFST+5,sp)
1656  00b1 9093          	ldw	y,x
1657  00b3 fe            	ldw	x,(x)
1658  00b4 5c            	incw	x
1659  00b5 90ff          	ldw	(y),x
1660                     ; 1902           *pDataLeft = *pDataLeft - 1;
1662  00b7 1e0f          	ldw	x,(OFST+7,sp)
1663  00b9 9093          	ldw	y,x
1664  00bb fe            	ldw	x,(x)
1665  00bc 5a            	decw	x
1666  00bd 90ff          	ldw	(y),x
1667                     ; 1907           memcpy(&temp, *ppData, 1);
1669  00bf 96            	ldw	x,sp
1670  00c0 5c            	incw	x
1671  00c1 bf00          	ldw	c_x,x
1672  00c3 160d          	ldw	y,(OFST+5,sp)
1673  00c5 90fe          	ldw	y,(y)
1674  00c7 90bf00        	ldw	c_y,y
1675  00ca ae0001        	ldw	x,#1
1676  00cd               L06:
1677  00cd 5a            	decw	x
1678  00ce 92d600        	ld	a,([c_y.w],x)
1679  00d1 92d700        	ld	([c_x.w],x),a
1680  00d4 5d            	tnzw	x
1681  00d5 26f6          	jrne	L06
1682                     ; 1908           nParsedNum = (uint8_t)(nParsedNum + temp - '0');
1684  00d7 7b07          	ld	a,(OFST-1,sp)
1685  00d9 1b01          	add	a,(OFST-7,sp)
1686  00db a030          	sub	a,#48
1687  00dd 6b07          	ld	(OFST-1,sp),a
1689                     ; 1909           *ppData = *ppData + 1;
1691  00df 1e0d          	ldw	x,(OFST+5,sp)
1692  00e1 9093          	ldw	y,x
1693  00e3 fe            	ldw	x,(x)
1694  00e4 5c            	incw	x
1695  00e5 90ff          	ldw	(y),x
1696                     ; 1910           *pDataLeft = *pDataLeft - 1;
1698  00e7 1e0f          	ldw	x,(OFST+7,sp)
1699  00e9 9093          	ldw	y,x
1700  00eb fe            	ldw	x,(x)
1701  00ec 5a            	decw	x
1702  00ed 90ff          	ldw	(y),x
1703  00ef 7b02          	ld	a,(OFST-6,sp)
1704  00f1               L525:
1705                     ; 1914       if ((nByte == '%') || (insertion_flag[0] != 0)) {
1707  00f1 a125          	cp	a,#37
1708  00f3 2709          	jreq	L335
1710  00f5 725d0000      	tnz	_insertion_flag
1711  00f9 2603cc05c2    	jreq	L135
1712  00fe               L335:
1713                     ; 1924         if (nParsedMode == 'i') {
1715  00fe 7b04          	ld	a,(OFST-4,sp)
1716  0100 a169          	cp	a,#105
1717  0102 262b          	jrne	L535
1718                     ; 1938           if (nParsedNum > 7) {
1720  0104 7b07          	ld	a,(OFST-1,sp)
1721  0106 a108          	cp	a,#8
1722  0108 2520          	jrult	L735
1723                     ; 1940 	    i = GpioGetPin(nParsedNum);
1725  010a cd0000        	call	_GpioGetPin
1727  010d 6b08          	ld	(OFST+0,sp),a
1729                     ; 1941 	    if (invert_input == 0x00) *pBuffer = (uint8_t)(i + '0');
1731  010f 725d0000      	tnz	_invert_input
1732  0113 2607          	jrne	L145
1735  0115               LC012:
1736  0115 ab30          	add	a,#48
1737  0117 1e09          	ldw	x,(OFST+1,sp)
1739  0119 cc04f8        	jra	L1201
1740  011c               L145:
1741                     ; 1943 	      if (i == 0) *pBuffer = (uint8_t)('1');
1743  011c 7b08          	ld	a,(OFST+0,sp)
1744  011e 2703cc04f4    	jrne	L7101
1747  0123 1e09          	ldw	x,(OFST+1,sp)
1748  0125 a631          	ld	a,#49
1750  0127 cc04f8        	jra	L1201
1751                     ; 1944 	      else *pBuffer = (uint8_t)('0');
1752                     ; 1946             pBuffer++;
1753                     ; 1947             nBytes++;
1755  012a               L735:
1756                     ; 1951 	    *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
1758  012a cd0000        	call	_GpioGetPin
1760                     ; 1952             pBuffer++;
1761                     ; 1953             nBytes++;
1762  012d 20e6          	jp	LC012
1763  012f               L535:
1764                     ; 1971         else if ((nParsedMode == 'o' && ((uint8_t)(GpioGetPin(nParsedNum) == 1)))
1764                     ; 1972 	      || (nParsedMode == 'p' && ((uint8_t)(GpioGetPin(nParsedNum) == 0)))) { 
1766  012f a16f          	cp	a,#111
1767  0131 260a          	jrne	L165
1769  0133 7b07          	ld	a,(OFST-1,sp)
1770  0135 cd0000        	call	_GpioGetPin
1772  0138 4a            	dec	a
1773  0139 270e          	jreq	L755
1774  013b 7b04          	ld	a,(OFST-4,sp)
1775  013d               L165:
1777  013d a170          	cp	a,#112
1778  013f 2626          	jrne	L555
1780  0141 7b07          	ld	a,(OFST-1,sp)
1781  0143 cd0000        	call	_GpioGetPin
1783  0146 4d            	tnz	a
1784  0147 261e          	jrne	L555
1785  0149               L755:
1786                     ; 1977           for(i=0; i<7; i++) {
1788  0149 4f            	clr	a
1789  014a 6b08          	ld	(OFST+0,sp),a
1791  014c               L365:
1792                     ; 1978             *pBuffer = checked[i];
1794  014c 5f            	clrw	x
1795  014d 97            	ld	xl,a
1796  014e d60000        	ld	a,(L11_checked,x)
1797  0151 1e09          	ldw	x,(OFST+1,sp)
1798  0153 f7            	ld	(x),a
1799                     ; 1979             pBuffer++;
1801  0154 5c            	incw	x
1802  0155 1f09          	ldw	(OFST+1,sp),x
1803                     ; 1977           for(i=0; i<7; i++) {
1805  0157 0c08          	inc	(OFST+0,sp)
1809  0159 7b08          	ld	a,(OFST+0,sp)
1810  015b a107          	cp	a,#7
1811  015d 25ed          	jrult	L365
1812                     ; 1981 	  nBytes += 7;
1814  015f 1e05          	ldw	x,(OFST-3,sp)
1815  0161 1c0007        	addw	x,#7
1817  0164 cc05dd        	jp	LC006
1818  0167               L555:
1819                     ; 1984         else if (nParsedMode == 'a') {
1821  0167 7b04          	ld	a,(OFST-4,sp)
1822  0169 a161          	cp	a,#97
1823  016b 2629          	jrne	L375
1824                     ; 1986 	  for(i=0; i<19; i++) {
1826  016d 4f            	clr	a
1827  016e 6b08          	ld	(OFST+0,sp),a
1829  0170               L575:
1830                     ; 1987 	    if (stored_devicename[i] != '\0') {
1832  0170 5f            	clrw	x
1833  0171 97            	ld	xl,a
1834  0172 724d0000      	tnz	(_stored_devicename,x)
1835  0176 2603cc05df    	jreq	L515
1836                     ; 1988               *pBuffer = (uint8_t)(stored_devicename[i]);
1838  017b 5f            	clrw	x
1839  017c 97            	ld	xl,a
1840  017d d60000        	ld	a,(_stored_devicename,x)
1841  0180 1e09          	ldw	x,(OFST+1,sp)
1842  0182 f7            	ld	(x),a
1843                     ; 1989               pBuffer++;
1845  0183 5c            	incw	x
1846  0184 1f09          	ldw	(OFST+1,sp),x
1847                     ; 1990               nBytes++;
1849  0186 1e05          	ldw	x,(OFST-3,sp)
1850  0188 5c            	incw	x
1851  0189 1f05          	ldw	(OFST-3,sp),x
1854                     ; 1986 	  for(i=0; i<19; i++) {
1856  018b 0c08          	inc	(OFST+0,sp)
1860  018d 7b08          	ld	a,(OFST+0,sp)
1861  018f a113          	cp	a,#19
1862  0191 25dd          	jrult	L575
1863  0193 cc05df        	jra	L515
1864  0196               L375:
1865                     ; 1996         else if (nParsedMode == 'b') {
1867  0196 a162          	cp	a,#98
1868  0198 2703cc02b2    	jrne	L116
1869                     ; 2001           switch (nParsedNum)
1871  019d 7b07          	ld	a,(OFST-1,sp)
1873                     ; 2022 	    default: break;
1874  019f a110          	cp	a,#16
1875  01a1 2503cc0294    	jruge	L516
1876  01a6 5f            	clrw	x
1877  01a7 97            	ld	xl,a
1878  01a8 58            	sllw	x
1879  01a9 de1ce5        	ldw	x,(L431,x)
1880  01ac fc            	jp	(x)
1881  01ad               L533:
1882                     ; 2004 	    case 0:  emb_itoa(stored_hostaddr[3], OctetArray, 10, 3); break;
1884  01ad 4b03          	push	#3
1885  01af 4b0a          	push	#10
1886  01b1 ae0045        	ldw	x,#_OctetArray
1887  01b4 89            	pushw	x
1888  01b5 c60003        	ld	a,_stored_hostaddr+3
1892  01b8 cc0281        	jp	LC001
1893  01bb               L733:
1894                     ; 2005 	    case 1:  emb_itoa(stored_hostaddr[2], OctetArray, 10, 3); break;
1896  01bb 4b03          	push	#3
1897  01bd 4b0a          	push	#10
1898  01bf ae0045        	ldw	x,#_OctetArray
1899  01c2 89            	pushw	x
1900  01c3 c60002        	ld	a,_stored_hostaddr+2
1904  01c6 cc0281        	jp	LC001
1905  01c9               L143:
1906                     ; 2006 	    case 2:  emb_itoa(stored_hostaddr[1], OctetArray, 10, 3); break;
1908  01c9 4b03          	push	#3
1909  01cb 4b0a          	push	#10
1910  01cd ae0045        	ldw	x,#_OctetArray
1911  01d0 89            	pushw	x
1912  01d1 c60001        	ld	a,_stored_hostaddr+1
1916  01d4 cc0281        	jp	LC001
1917  01d7               L343:
1918                     ; 2007 	    case 3:  emb_itoa(stored_hostaddr[0], OctetArray, 10, 3); break;
1920  01d7 4b03          	push	#3
1921  01d9 4b0a          	push	#10
1922  01db ae0045        	ldw	x,#_OctetArray
1923  01de 89            	pushw	x
1924  01df c60000        	ld	a,_stored_hostaddr
1928  01e2 cc0281        	jp	LC001
1929  01e5               L543:
1930                     ; 2008 	    case 4:  emb_itoa(stored_draddr[3],   OctetArray, 10, 3); break;
1932  01e5 4b03          	push	#3
1933  01e7 4b0a          	push	#10
1934  01e9 ae0045        	ldw	x,#_OctetArray
1935  01ec 89            	pushw	x
1936  01ed c60003        	ld	a,_stored_draddr+3
1940  01f0 cc0281        	jp	LC001
1941  01f3               L743:
1942                     ; 2009 	    case 5:  emb_itoa(stored_draddr[2],   OctetArray, 10, 3); break;
1944  01f3 4b03          	push	#3
1945  01f5 4b0a          	push	#10
1946  01f7 ae0045        	ldw	x,#_OctetArray
1947  01fa 89            	pushw	x
1948  01fb c60002        	ld	a,_stored_draddr+2
1952  01fe cc0281        	jp	LC001
1953  0201               L153:
1954                     ; 2010 	    case 6:  emb_itoa(stored_draddr[1],   OctetArray, 10, 3); break;
1956  0201 4b03          	push	#3
1957  0203 4b0a          	push	#10
1958  0205 ae0045        	ldw	x,#_OctetArray
1959  0208 89            	pushw	x
1960  0209 c60001        	ld	a,_stored_draddr+1
1964  020c 2073          	jp	LC001
1965  020e               L353:
1966                     ; 2011 	    case 7:  emb_itoa(stored_draddr[0],   OctetArray, 10, 3); break;
1968  020e 4b03          	push	#3
1969  0210 4b0a          	push	#10
1970  0212 ae0045        	ldw	x,#_OctetArray
1971  0215 89            	pushw	x
1972  0216 c60000        	ld	a,_stored_draddr
1976  0219 2066          	jp	LC001
1977  021b               L553:
1978                     ; 2012 	    case 8:  emb_itoa(stored_netmask[3],  OctetArray, 10, 3); break;
1980  021b 4b03          	push	#3
1981  021d 4b0a          	push	#10
1982  021f ae0045        	ldw	x,#_OctetArray
1983  0222 89            	pushw	x
1984  0223 c60003        	ld	a,_stored_netmask+3
1988  0226 2059          	jp	LC001
1989  0228               L753:
1990                     ; 2013 	    case 9:  emb_itoa(stored_netmask[2],  OctetArray, 10, 3); break;
1992  0228 4b03          	push	#3
1993  022a 4b0a          	push	#10
1994  022c ae0045        	ldw	x,#_OctetArray
1995  022f 89            	pushw	x
1996  0230 c60002        	ld	a,_stored_netmask+2
2000  0233 204c          	jp	LC001
2001  0235               L163:
2002                     ; 2014 	    case 10: emb_itoa(stored_netmask[1],  OctetArray, 10, 3); break;
2004  0235 4b03          	push	#3
2005  0237 4b0a          	push	#10
2006  0239 ae0045        	ldw	x,#_OctetArray
2007  023c 89            	pushw	x
2008  023d c60001        	ld	a,_stored_netmask+1
2012  0240 203f          	jp	LC001
2013  0242               L363:
2014                     ; 2015 	    case 11: emb_itoa(stored_netmask[0],  OctetArray, 10, 3); break;
2016  0242 4b03          	push	#3
2017  0244 4b0a          	push	#10
2018  0246 ae0045        	ldw	x,#_OctetArray
2019  0249 89            	pushw	x
2020  024a c60000        	ld	a,_stored_netmask
2024  024d 2032          	jp	LC001
2025  024f               L563:
2026                     ; 2017 	    case 12: emb_itoa(stored_mqttserveraddr[3], OctetArray, 10, 3); break;
2028  024f 4b03          	push	#3
2029  0251 4b0a          	push	#10
2030  0253 ae0045        	ldw	x,#_OctetArray
2031  0256 89            	pushw	x
2032  0257 c60003        	ld	a,_stored_mqttserveraddr+3
2036  025a 2025          	jp	LC001
2037  025c               L763:
2038                     ; 2018 	    case 13: emb_itoa(stored_mqttserveraddr[2], OctetArray, 10, 3); break;
2040  025c 4b03          	push	#3
2041  025e 4b0a          	push	#10
2042  0260 ae0045        	ldw	x,#_OctetArray
2043  0263 89            	pushw	x
2044  0264 c60002        	ld	a,_stored_mqttserveraddr+2
2048  0267 2018          	jp	LC001
2049  0269               L173:
2050                     ; 2019 	    case 14: emb_itoa(stored_mqttserveraddr[1], OctetArray, 10, 3); break;
2052  0269 4b03          	push	#3
2053  026b 4b0a          	push	#10
2054  026d ae0045        	ldw	x,#_OctetArray
2055  0270 89            	pushw	x
2056  0271 c60001        	ld	a,_stored_mqttserveraddr+1
2060  0274 200b          	jp	LC001
2061  0276               L373:
2062                     ; 2020 	    case 15: emb_itoa(stored_mqttserveraddr[0], OctetArray, 10, 3); break;
2064  0276 4b03          	push	#3
2065  0278 4b0a          	push	#10
2066  027a ae0045        	ldw	x,#_OctetArray
2067  027d 89            	pushw	x
2068  027e c60000        	ld	a,_stored_mqttserveraddr
2070  0281               LC001:
2071  0281 b703          	ld	c_lreg+3,a
2072  0283 3f02          	clr	c_lreg+2
2073  0285 3f01          	clr	c_lreg+1
2074  0287 3f00          	clr	c_lreg
2075  0289 be02          	ldw	x,c_lreg+2
2076  028b 89            	pushw	x
2077  028c be00          	ldw	x,c_lreg
2078  028e 89            	pushw	x
2079  028f cd0000        	call	_emb_itoa
2080  0292 5b08          	addw	sp,#8
2083                     ; 2022 	    default: break;
2085  0294               L516:
2086                     ; 2026 	  for(i=0; i<3; i++) {
2088  0294 4f            	clr	a
2089  0295 6b08          	ld	(OFST+0,sp),a
2091  0297               L716:
2092                     ; 2027 	    *pBuffer = (uint8_t)OctetArray[i];
2094  0297 5f            	clrw	x
2095  0298 97            	ld	xl,a
2096  0299 d60045        	ld	a,(_OctetArray,x)
2097  029c 1e09          	ldw	x,(OFST+1,sp)
2098  029e f7            	ld	(x),a
2099                     ; 2028             pBuffer++;
2101  029f 5c            	incw	x
2102  02a0 1f09          	ldw	(OFST+1,sp),x
2103                     ; 2026 	  for(i=0; i<3; i++) {
2105  02a2 0c08          	inc	(OFST+0,sp)
2109  02a4 7b08          	ld	a,(OFST+0,sp)
2110  02a6 a103          	cp	a,#3
2111  02a8 25ed          	jrult	L716
2112                     ; 2030 	  nBytes += 3;
2114  02aa 1e05          	ldw	x,(OFST-3,sp)
2115  02ac 1c0003        	addw	x,#3
2117  02af cc05dd        	jp	LC006
2118  02b2               L116:
2119                     ; 2033         else if (nParsedMode == 'c') {
2121  02b2 a163          	cp	a,#99
2122  02b4 2648          	jrne	L726
2123                     ; 2042 	  if (nParsedNum == 0) emb_itoa(stored_port, OctetArray, 10, 5);
2125  02b6 7b07          	ld	a,(OFST-1,sp)
2126  02b8 260d          	jrne	L136
2129  02ba 4b05          	push	#5
2130  02bc 4b0a          	push	#10
2131  02be ae0045        	ldw	x,#_OctetArray
2132  02c1 89            	pushw	x
2133  02c2 ce0000        	ldw	x,_stored_port
2137  02c5 200b          	jra	L336
2138  02c7               L136:
2139                     ; 2044 	  else emb_itoa(stored_mqttport, OctetArray, 10, 5);
2141  02c7 4b05          	push	#5
2142  02c9 4b0a          	push	#10
2143  02cb ae0045        	ldw	x,#_OctetArray
2144  02ce 89            	pushw	x
2145  02cf ce0000        	ldw	x,_stored_mqttport
2148  02d2               L336:
2149  02d2 cd0000        	call	c_uitolx
2150  02d5 be02          	ldw	x,c_lreg+2
2151  02d7 89            	pushw	x
2152  02d8 be00          	ldw	x,c_lreg
2153  02da 89            	pushw	x
2154  02db cd0000        	call	_emb_itoa
2155  02de 5b08          	addw	sp,#8
2156                     ; 2048 	  for(i=0; i<5; i++) {
2158  02e0 4f            	clr	a
2159  02e1 6b08          	ld	(OFST+0,sp),a
2161  02e3               L536:
2162                     ; 2049             *pBuffer = (uint8_t)OctetArray[i];
2164  02e3 5f            	clrw	x
2165  02e4 97            	ld	xl,a
2166  02e5 d60045        	ld	a,(_OctetArray,x)
2167  02e8 1e09          	ldw	x,(OFST+1,sp)
2168  02ea f7            	ld	(x),a
2169                     ; 2050             pBuffer++;
2171  02eb 5c            	incw	x
2172  02ec 1f09          	ldw	(OFST+1,sp),x
2173                     ; 2048 	  for(i=0; i<5; i++) {
2175  02ee 0c08          	inc	(OFST+0,sp)
2179  02f0 7b08          	ld	a,(OFST+0,sp)
2180  02f2 a105          	cp	a,#5
2181  02f4 25ed          	jrult	L536
2182                     ; 2052 	  nBytes += 5;
2184  02f6 1e05          	ldw	x,(OFST-3,sp)
2185  02f8 1c0005        	addw	x,#5
2187  02fb cc05dd        	jp	LC006
2188  02fe               L726:
2189                     ; 2055         else if (nParsedMode == 'd') {
2191  02fe a164          	cp	a,#100
2192  0300 266a          	jrne	L546
2193                     ; 2060 	  if (nParsedNum == 0) { OctetArray[0] = mac_string[0]; OctetArray[1] = mac_string[1]; }
2195  0302 7b07          	ld	a,(OFST-1,sp)
2196  0304 260a          	jrne	L746
2199  0306 5500000045    	mov	_OctetArray,_mac_string
2202  030b 5500010046    	mov	_OctetArray+1,_mac_string+1
2203  0310               L746:
2204                     ; 2061 	  if (nParsedNum == 1) { OctetArray[0] = mac_string[2]; OctetArray[1] = mac_string[3]; }
2206  0310 a101          	cp	a,#1
2207  0312 260a          	jrne	L156
2210  0314 5500020045    	mov	_OctetArray,_mac_string+2
2213  0319 5500030046    	mov	_OctetArray+1,_mac_string+3
2214  031e               L156:
2215                     ; 2062 	  if (nParsedNum == 2) { OctetArray[0] = mac_string[4]; OctetArray[1] = mac_string[5]; }
2217  031e a102          	cp	a,#2
2218  0320 260a          	jrne	L356
2221  0322 5500040045    	mov	_OctetArray,_mac_string+4
2224  0327 5500050046    	mov	_OctetArray+1,_mac_string+5
2225  032c               L356:
2226                     ; 2063 	  if (nParsedNum == 3) { OctetArray[0] = mac_string[6]; OctetArray[1] = mac_string[7]; }
2228  032c a103          	cp	a,#3
2229  032e 260a          	jrne	L556
2232  0330 5500060045    	mov	_OctetArray,_mac_string+6
2235  0335 5500070046    	mov	_OctetArray+1,_mac_string+7
2236  033a               L556:
2237                     ; 2064 	  if (nParsedNum == 4) { OctetArray[0] = mac_string[8]; OctetArray[1] = mac_string[9]; }
2239  033a a104          	cp	a,#4
2240  033c 260a          	jrne	L756
2243  033e 5500080045    	mov	_OctetArray,_mac_string+8
2246  0343 5500090046    	mov	_OctetArray+1,_mac_string+9
2247  0348               L756:
2248                     ; 2065 	  if (nParsedNum == 5) { OctetArray[0] = mac_string[10]; OctetArray[1] = mac_string[11]; }
2250  0348 a105          	cp	a,#5
2251  034a 260a          	jrne	L166
2254  034c 55000a0045    	mov	_OctetArray,_mac_string+10
2257  0351 55000b0046    	mov	_OctetArray+1,_mac_string+11
2258  0356               L166:
2259                     ; 2067           *pBuffer = OctetArray[0];
2261  0356 1e09          	ldw	x,(OFST+1,sp)
2262  0358 c60045        	ld	a,_OctetArray
2263  035b f7            	ld	(x),a
2264                     ; 2068           pBuffer++;
2266  035c 5c            	incw	x
2267  035d 1f09          	ldw	(OFST+1,sp),x
2268                     ; 2069           nBytes++;
2270  035f 1e05          	ldw	x,(OFST-3,sp)
2271  0361 5c            	incw	x
2272  0362 1f05          	ldw	(OFST-3,sp),x
2274                     ; 2071           *pBuffer = OctetArray[1];
2276  0364 c60046        	ld	a,_OctetArray+1
2277  0367 1e09          	ldw	x,(OFST+1,sp)
2278                     ; 2072           pBuffer++;
2279                     ; 2073           nBytes++;
2281  0369 cc04f8        	jp	L1201
2282  036c               L546:
2283                     ; 2141         else if (nParsedMode == 'e') {
2285  036c a165          	cp	a,#101
2286  036e 2677          	jrne	L566
2287                     ; 2142           switch (nParsedNum)
2289  0370 7b07          	ld	a,(OFST-1,sp)
2291                     ; 2149 	    case 29:  emb_itoa(TRANSMIT_counter, OctetArray, 10, 10); break;
2292  0372 a01a          	sub	a,#26
2293  0374 270b          	jreq	L773
2294  0376 4a            	dec	a
2295  0377 2719          	jreq	L104
2296  0379 4a            	dec	a
2297  037a 2727          	jreq	L304
2298  037c 4a            	dec	a
2299  037d 2735          	jreq	L504
2300  037f 2048          	jra	L176
2301  0381               L773:
2302                     ; 2146 	    case 26:  emb_itoa(second_counter, OctetArray, 10, 10); break;
2304  0381 4b0a          	push	#10
2305  0383 4b0a          	push	#10
2306  0385 ae0045        	ldw	x,#_OctetArray
2307  0388 89            	pushw	x
2308  0389 ce0002        	ldw	x,_second_counter+2
2309  038c 89            	pushw	x
2310  038d ce0000        	ldw	x,_second_counter
2314  0390 2031          	jp	LC002
2315  0392               L104:
2316                     ; 2147 	    case 27:  emb_itoa(RXERIF_counter, OctetArray, 10, 10); break;
2318  0392 4b0a          	push	#10
2319  0394 4b0a          	push	#10
2320  0396 ae0045        	ldw	x,#_OctetArray
2321  0399 89            	pushw	x
2322  039a ce0002        	ldw	x,_RXERIF_counter+2
2323  039d 89            	pushw	x
2324  039e ce0000        	ldw	x,_RXERIF_counter
2328  03a1 2020          	jp	LC002
2329  03a3               L304:
2330                     ; 2148 	    case 28:  emb_itoa(TXERIF_counter, OctetArray, 10, 10); break;
2332  03a3 4b0a          	push	#10
2333  03a5 4b0a          	push	#10
2334  03a7 ae0045        	ldw	x,#_OctetArray
2335  03aa 89            	pushw	x
2336  03ab ce0002        	ldw	x,_TXERIF_counter+2
2337  03ae 89            	pushw	x
2338  03af ce0000        	ldw	x,_TXERIF_counter
2342  03b2 200f          	jp	LC002
2343  03b4               L504:
2344                     ; 2149 	    case 29:  emb_itoa(TRANSMIT_counter, OctetArray, 10, 10); break;
2346  03b4 4b0a          	push	#10
2347  03b6 4b0a          	push	#10
2348  03b8 ae0045        	ldw	x,#_OctetArray
2349  03bb 89            	pushw	x
2350  03bc ce0002        	ldw	x,_TRANSMIT_counter+2
2351  03bf 89            	pushw	x
2352  03c0 ce0000        	ldw	x,_TRANSMIT_counter
2354  03c3               LC002:
2355  03c3 89            	pushw	x
2356  03c4 cd0000        	call	_emb_itoa
2357  03c7 5b08          	addw	sp,#8
2360  03c9               L176:
2361                     ; 2151 	  for (i=0; i<10; i++) {
2363  03c9 4f            	clr	a
2364  03ca 6b08          	ld	(OFST+0,sp),a
2366  03cc               L376:
2367                     ; 2152             *pBuffer = OctetArray[i];
2369  03cc 5f            	clrw	x
2370  03cd 97            	ld	xl,a
2371  03ce d60045        	ld	a,(_OctetArray,x)
2372  03d1 1e09          	ldw	x,(OFST+1,sp)
2373  03d3 f7            	ld	(x),a
2374                     ; 2153             pBuffer++;
2376  03d4 5c            	incw	x
2377  03d5 1f09          	ldw	(OFST+1,sp),x
2378                     ; 2151 	  for (i=0; i<10; i++) {
2380  03d7 0c08          	inc	(OFST+0,sp)
2384  03d9 7b08          	ld	a,(OFST+0,sp)
2385  03db a10a          	cp	a,#10
2386  03dd 25ed          	jrult	L376
2387                     ; 2155 	  nBytes += 10;
2389  03df 1e05          	ldw	x,(OFST-3,sp)
2390  03e1 1c000a        	addw	x,#10
2392  03e4 cc05dd        	jp	LC006
2393  03e7               L566:
2394                     ; 2159         else if (nParsedMode == 'f') {
2396  03e7 a166          	cp	a,#102
2397  03e9 263d          	jrne	L307
2398                     ; 2174 	  for(i=0; i<16; i++) {
2400  03eb 4f            	clr	a
2401  03ec 6b08          	ld	(OFST+0,sp),a
2403  03ee               L507:
2404                     ; 2175             if (i > 7) {
2406  03ee a108          	cp	a,#8
2407  03f0 251b          	jrult	L317
2408                     ; 2177               j = GpioGetPin(i);
2410  03f2 cd0000        	call	_GpioGetPin
2412  03f5 6b03          	ld	(OFST-5,sp),a
2414                     ; 2178               if (invert_input == 0x00) *pBuffer = (uint8_t)(j + '0');
2416  03f7 725d0000      	tnz	_invert_input
2419  03fb 2713          	jreq	LC010
2420                     ; 2180                 if (j == 0) *pBuffer = (uint8_t)('1'); 
2422  03fd 7b03          	ld	a,(OFST-5,sp)
2423  03ff 2606          	jrne	L127
2426  0401 1e09          	ldw	x,(OFST+1,sp)
2427  0403 a631          	ld	a,#49
2429  0405 200d          	jra	L527
2430  0407               L127:
2431                     ; 2181                 else *pBuffer = (uint8_t)('0');
2433  0407 1e09          	ldw	x,(OFST+1,sp)
2434  0409 a630          	ld	a,#48
2435                     ; 2183               pBuffer++;
2437  040b 2007          	jra	L527
2438  040d               L317:
2439                     ; 2187               *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
2441  040d cd0000        	call	_GpioGetPin
2443  0410               LC010:
2445  0410 ab30          	add	a,#48
2446  0412 1e09          	ldw	x,(OFST+1,sp)
2447                     ; 2188               pBuffer++;
2449  0414               L527:
2450  0414 f7            	ld	(x),a
2452  0415 5c            	incw	x
2453  0416 1f09          	ldw	(OFST+1,sp),x
2454                     ; 2174 	  for(i=0; i<16; i++) {
2456  0418 0c08          	inc	(OFST+0,sp)
2460  041a 7b08          	ld	a,(OFST+0,sp)
2461  041c a110          	cp	a,#16
2462  041e 25ce          	jrult	L507
2463                     ; 2191 	  nBytes += 16;
2465  0420 1e05          	ldw	x,(OFST-3,sp)
2466  0422 1c0010        	addw	x,#16
2468  0425 cc05dd        	jp	LC006
2469  0428               L307:
2470                     ; 2210 else if (nParsedMode == 'g') {
2472  0428 a167          	cp	a,#103
2473  042a 261e          	jrne	L137
2474                     ; 2223 	  for(i = 0; i < 6; i++) {
2476  042c 4f            	clr	a
2477  042d 6b08          	ld	(OFST+0,sp),a
2479  042f               L337:
2480                     ; 2224             *pBuffer = stored_config_settings[i];
2482  042f 5f            	clrw	x
2483  0430 97            	ld	xl,a
2484  0431 d60000        	ld	a,(_stored_config_settings,x)
2485  0434 1e09          	ldw	x,(OFST+1,sp)
2486  0436 f7            	ld	(x),a
2487                     ; 2225             pBuffer++;
2489  0437 5c            	incw	x
2490  0438 1f09          	ldw	(OFST+1,sp),x
2491                     ; 2223 	  for(i = 0; i < 6; i++) {
2493  043a 0c08          	inc	(OFST+0,sp)
2497  043c 7b08          	ld	a,(OFST+0,sp)
2498  043e a106          	cp	a,#6
2499  0440 25ed          	jrult	L337
2500                     ; 2227           nBytes += 6;
2502  0442 1e05          	ldw	x,(OFST-3,sp)
2503  0444 1c0006        	addw	x,#6
2505  0447 cc05dd        	jp	LC006
2506  044a               L137:
2507                     ; 2231         else if (nParsedMode == 'l') {
2509  044a a16c          	cp	a,#108
2510  044c 2629          	jrne	L347
2511                     ; 2234           for(i=0; i<10; i++) {
2513  044e 4f            	clr	a
2514  044f 6b08          	ld	(OFST+0,sp),a
2516  0451               L547:
2517                     ; 2235 	    if (stored_mqtt_username[i] != '\0') {
2519  0451 5f            	clrw	x
2520  0452 97            	ld	xl,a
2521  0453 724d0000      	tnz	(_stored_mqtt_username,x)
2522  0457 2603cc05df    	jreq	L515
2523                     ; 2236               *pBuffer = (uint8_t)(stored_mqtt_username[i]);
2525  045c 5f            	clrw	x
2526  045d 97            	ld	xl,a
2527  045e d60000        	ld	a,(_stored_mqtt_username,x)
2528  0461 1e09          	ldw	x,(OFST+1,sp)
2529  0463 f7            	ld	(x),a
2530                     ; 2237               pBuffer++;
2532  0464 5c            	incw	x
2533  0465 1f09          	ldw	(OFST+1,sp),x
2534                     ; 2238               nBytes++;
2536  0467 1e05          	ldw	x,(OFST-3,sp)
2537  0469 5c            	incw	x
2538  046a 1f05          	ldw	(OFST-3,sp),x
2541                     ; 2234           for(i=0; i<10; i++) {
2543  046c 0c08          	inc	(OFST+0,sp)
2547  046e 7b08          	ld	a,(OFST+0,sp)
2548  0470 a10a          	cp	a,#10
2549  0472 25dd          	jrult	L547
2550  0474 cc05df        	jra	L515
2551  0477               L347:
2552                     ; 2244         else if (nParsedMode == 'm') {
2554  0477 a16d          	cp	a,#109
2555  0479 2626          	jrne	L167
2556                     ; 2247           for(i=0; i<10; i++) {
2558  047b 4f            	clr	a
2559  047c 6b08          	ld	(OFST+0,sp),a
2561  047e               L367:
2562                     ; 2248 	    if (stored_mqtt_password[i] != '\0') {
2564  047e 5f            	clrw	x
2565  047f 97            	ld	xl,a
2566  0480 724d0000      	tnz	(_stored_mqtt_password,x)
2567  0484 27ee          	jreq	L515
2568                     ; 2249               *pBuffer = (uint8_t)(stored_mqtt_password[i]);
2570  0486 5f            	clrw	x
2571  0487 97            	ld	xl,a
2572  0488 d60000        	ld	a,(_stored_mqtt_password,x)
2573  048b 1e09          	ldw	x,(OFST+1,sp)
2574  048d f7            	ld	(x),a
2575                     ; 2250               pBuffer++;
2577  048e 5c            	incw	x
2578  048f 1f09          	ldw	(OFST+1,sp),x
2579                     ; 2251               nBytes++;
2581  0491 1e05          	ldw	x,(OFST-3,sp)
2582  0493 5c            	incw	x
2583  0494 1f05          	ldw	(OFST-3,sp),x
2586                     ; 2247           for(i=0; i<10; i++) {
2588  0496 0c08          	inc	(OFST+0,sp)
2592  0498 7b08          	ld	a,(OFST+0,sp)
2593  049a a10a          	cp	a,#10
2594  049c 25e0          	jrult	L367
2595  049e cc05df        	jra	L515
2596  04a1               L167:
2597                     ; 2257         else if (nParsedMode == 'n') {
2599  04a1 a16e          	cp	a,#110
2600  04a3 2657          	jrne	L777
2601                     ; 2261 	  no_err = 0;
2603  04a5 0f08          	clr	(OFST+0,sp)
2605                     ; 2262           switch (nParsedNum)
2607  04a7 7b07          	ld	a,(OFST-1,sp)
2609                     ; 2284 	    default:
2609                     ; 2285 	      break;
2610  04a9 270e          	jreq	L704
2611  04ab 4a            	dec	a
2612  04ac 2712          	jreq	L114
2613  04ae 4a            	dec	a
2614  04af 2716          	jreq	L314
2615  04b1 4a            	dec	a
2616  04b2 271a          	jreq	L514
2617  04b4 4a            	dec	a
2618  04b5 271f          	jreq	L714
2619  04b7 2030          	jra	L3001
2620  04b9               L704:
2621                     ; 2264 	    case 0:
2621                     ; 2265               // Connection request status
2621                     ; 2266 	      if (mqtt_start_status & MQTT_START_CONNECTIONS_GOOD) no_err = 1;
2623  04b9 720900002b    	btjf	_mqtt_start_status,#4,L3001
2625  04be 2013          	jp	LC004
2626  04c0               L114:
2627                     ; 2268 	    case 1:
2627                     ; 2269 	      // ARP request status
2627                     ; 2270 	      if (mqtt_start_status & MQTT_START_ARP_REQUEST_GOOD) no_err = 1;
2629  04c0 720b000024    	btjf	_mqtt_start_status,#5,L3001
2631  04c5 200c          	jp	LC004
2632  04c7               L314:
2633                     ; 2272 	    case 2:
2633                     ; 2273 	      // TCP connection status
2633                     ; 2274 	      if (mqtt_start_status & MQTT_START_TCP_CONNECT_GOOD) no_err = 1;
2635  04c7 720d00001d    	btjf	_mqtt_start_status,#6,L3001
2637  04cc 2005          	jp	LC004
2638  04ce               L514:
2639                     ; 2276 	    case 3:
2639                     ; 2277 	      // MQTT Connection status 1
2639                     ; 2278 	      if (mqtt_start_status & MQTT_START_MQTT_CONNECT_GOOD) no_err = 1;
2641  04ce 720f000016    	btjf	_mqtt_start_status,#7,L3001
2644  04d3               LC004:
2648  04d3 4c            	inc	a
2649  04d4 2011          	jp	LC003
2650  04d6               L714:
2651                     ; 2280 	    case 4:
2651                     ; 2281 	      // MQTT start complete with no errors
2651                     ; 2282 	      if ((MQTT_error_status == 1) && ((mqtt_start_status & 0xf0) == 0xf0) ) no_err = 1;
2653  04d6 c60000        	ld	a,_MQTT_error_status
2654  04d9 4a            	dec	a
2655  04da 260d          	jrne	L3001
2657  04dc c60000        	ld	a,_mqtt_start_status
2658  04df a4f0          	and	a,#240
2659  04e1 a1f0          	cp	a,#240
2660  04e3 2604          	jrne	L3001
2663  04e5 a601          	ld	a,#1
2664  04e7               LC003:
2665  04e7 6b08          	ld	(OFST+0,sp),a
2667                     ; 2284 	    default:
2667                     ; 2285 	      break;
2669  04e9               L3001:
2670                     ; 2287 	  if (no_err == 1) *pBuffer = '1'; // Paint a green square
2672  04e9 7b08          	ld	a,(OFST+0,sp)
2673  04eb 4a            	dec	a
2674  04ec 2606          	jrne	L7101
2677  04ee 1e09          	ldw	x,(OFST+1,sp)
2678  04f0 a631          	ld	a,#49
2680  04f2 2004          	jra	L1201
2681  04f4               L7101:
2682                     ; 2288 	  else *pBuffer = '0'; // Paint a red square
2685  04f4 1e09          	ldw	x,(OFST+1,sp)
2686  04f6 a630          	ld	a,#48
2687  04f8               L1201:
2688  04f8 f7            	ld	(x),a
2689                     ; 2289           pBuffer++;
2690                     ; 2290           nBytes++;
2692  04f9 cc05d7        	jp	LC007
2693  04fc               L777:
2694                     ; 2294         else if (nParsedMode == 'y') {
2696  04fc a179          	cp	a,#121
2697  04fe 269e          	jrne	L515
2698                     ; 2339 	  i = insertion_flag[0];
2700  0500 c60000        	ld	a,_insertion_flag
2701  0503 6b08          	ld	(OFST+0,sp),a
2703                     ; 2340 	  insertion_flag[1] = nParsedMode;
2705  0505 7b04          	ld	a,(OFST-4,sp)
2706  0507 c70001        	ld	_insertion_flag+1,a
2707                     ; 2341 	  insertion_flag[2] = nParsedNum;
2709  050a 7b07          	ld	a,(OFST-1,sp)
2710  050c c70002        	ld	_insertion_flag+2,a
2711                     ; 2343           switch (nParsedNum)
2714                     ; 2391 	    default: break;
2715  050f 2718          	jreq	L324
2716  0511 4a            	dec	a
2717  0512 272a          	jreq	L524
2718  0514 4a            	dec	a
2719  0515 273c          	jreq	L724
2720  0517 4a            	dec	a
2721  0518 274e          	jreq	L134
2722  051a 4a            	dec	a
2723  051b 2760          	jreq	L334
2724  051d 4a            	dec	a
2725  051e 2772          	jreq	L534
2726  0520 4a            	dec	a
2727  0521 2603cc05a7    	jreq	L734
2728  0526 cc05d5        	jra	LC008
2729  0529               L324:
2730                     ; 2345 	    case 0:
2730                     ; 2346 	      // %y00 replaced with string 
2730                     ; 2347 	      // page_string00[] = "pattern='[0-9]{3}' title='Enter 000 to 255' maxlength='3'";
2730                     ; 2348               *pBuffer = (uint8_t)page_string00[i];
2732  0529 7b08          	ld	a,(OFST+0,sp)
2733  052b 5f            	clrw	x
2734  052c 97            	ld	xl,a
2735  052d d61a6a        	ld	a,(L32_page_string00,x)
2736  0530 1e09          	ldw	x,(OFST+1,sp)
2737  0532 f7            	ld	(x),a
2738                     ; 2349 	      insertion_flag[0]++;
2740  0533 725c0000      	inc	_insertion_flag
2741                     ; 2350 	      if (insertion_flag[0] == page_string00_len) insertion_flag[0] = 0;
2743  0537 c60000        	ld	a,_insertion_flag
2744  053a a13f          	cp	a,#63
2746  053c 207c          	jp	LC005
2747  053e               L524:
2748                     ; 2352 	    case 1:
2748                     ; 2353 	      // %y01 replaced with string 
2748                     ; 2354               // page_string01[] = "pattern='[0-9a-f]{2}' title='Enter 00 to ff' maxlength='2'";
2748                     ; 2355               *pBuffer = (uint8_t)page_string01[i];
2750  053e 7b08          	ld	a,(OFST+0,sp)
2751  0540 5f            	clrw	x
2752  0541 97            	ld	xl,a
2753  0542 d61aac        	ld	a,(L13_page_string01,x)
2754  0545 1e09          	ldw	x,(OFST+1,sp)
2755  0547 f7            	ld	(x),a
2756                     ; 2356 	      insertion_flag[0]++;
2758  0548 725c0000      	inc	_insertion_flag
2759                     ; 2357 	      if (insertion_flag[0] == page_string01_len) insertion_flag[0] = 0;
2761  054c c60000        	ld	a,_insertion_flag
2762  054f a140          	cp	a,#64
2764  0551 2067          	jp	LC005
2765  0553               L724:
2766                     ; 2359 	    case 2:
2766                     ; 2360 	      // %y02 replaced with string 
2766                     ; 2361               // page_string02[] = "<button title='Save first! This button will not save your changes'>";
2766                     ; 2362               *pBuffer = (uint8_t)page_string02[i];
2768  0553 7b08          	ld	a,(OFST+0,sp)
2769  0555 5f            	clrw	x
2770  0556 97            	ld	xl,a
2771  0557 d61aef        	ld	a,(L73_page_string02,x)
2772  055a 1e09          	ldw	x,(OFST+1,sp)
2773  055c f7            	ld	(x),a
2774                     ; 2363 	      insertion_flag[0]++;
2776  055d 725c0000      	inc	_insertion_flag
2777                     ; 2364 	      if (insertion_flag[0] == page_string02_len) insertion_flag[0] = 0;
2779  0561 c60000        	ld	a,_insertion_flag
2780  0564 a152          	cp	a,#82
2782  0566 2052          	jp	LC005
2783  0568               L134:
2784                     ; 2366 	    case 3:
2784                     ; 2367 	      // %y03 replaced with string 
2784                     ; 2368               // page_string03[] = "<form style='display: inline' action='http://";
2784                     ; 2369               *pBuffer = (uint8_t)page_string03[i];
2786  0568 7b08          	ld	a,(OFST+0,sp)
2787  056a 5f            	clrw	x
2788  056b 97            	ld	xl,a
2789  056c d61b44        	ld	a,(L54_page_string03,x)
2790  056f 1e09          	ldw	x,(OFST+1,sp)
2791  0571 f7            	ld	(x),a
2792                     ; 2370 	      insertion_flag[0]++;
2794  0572 725c0000      	inc	_insertion_flag
2795                     ; 2371 	      if (insertion_flag[0] == page_string03_len) insertion_flag[0] = 0;
2797  0576 c60000        	ld	a,_insertion_flag
2798  0579 a126          	cp	a,#38
2800  057b 203d          	jp	LC005
2801  057d               L334:
2802                     ; 2373 	    case 4:
2802                     ; 2374 	      // %y04 replaced with first header string 
2802                     ; 2375               *pBuffer = (uint8_t)page_string04[i];
2804  057d 7b08          	ld	a,(OFST+0,sp)
2805  057f 5f            	clrw	x
2806  0580 97            	ld	xl,a
2807  0581 d61b6d        	ld	a,(L35_page_string04,x)
2808  0584 1e09          	ldw	x,(OFST+1,sp)
2809  0586 f7            	ld	(x),a
2810                     ; 2376 	      insertion_flag[0]++;
2812  0587 725c0000      	inc	_insertion_flag
2813                     ; 2377 	      if (insertion_flag[0] == page_string04_len) insertion_flag[0] = 0;
2815  058b c60000        	ld	a,_insertion_flag
2816  058e a147          	cp	a,#71
2818  0590 2028          	jp	LC005
2819  0592               L534:
2820                     ; 2379 	    case 5:
2820                     ; 2380 	      // %y05 replaced with second header string 
2820                     ; 2381               *pBuffer = (uint8_t)page_string05[i];
2822  0592 7b08          	ld	a,(OFST+0,sp)
2823  0594 5f            	clrw	x
2824  0595 97            	ld	xl,a
2825  0596 d61bb7        	ld	a,(L16_page_string05,x)
2826  0599 1e09          	ldw	x,(OFST+1,sp)
2827  059b f7            	ld	(x),a
2828                     ; 2382 	      insertion_flag[0]++;
2830  059c 725c0000      	inc	_insertion_flag
2831                     ; 2383 	      if (insertion_flag[0] == page_string05_len) insertion_flag[0] = 0;
2833  05a0 c60000        	ld	a,_insertion_flag
2834  05a3 a1ed          	cp	a,#237
2836  05a5 2013          	jp	LC005
2837  05a7               L734:
2838                     ; 2385 	    case 6:
2838                     ; 2386 	      // %y06 replaced with third header string 
2838                     ; 2387               *pBuffer = (uint8_t)page_string06[i];
2840  05a7 7b08          	ld	a,(OFST+0,sp)
2841  05a9 5f            	clrw	x
2842  05aa 97            	ld	xl,a
2843  05ab d61ca7        	ld	a,(L76_page_string06,x)
2844  05ae 1e09          	ldw	x,(OFST+1,sp)
2845  05b0 f7            	ld	(x),a
2846                     ; 2388 	      insertion_flag[0]++;
2848  05b1 725c0000      	inc	_insertion_flag
2849                     ; 2389 	      if (insertion_flag[0] == page_string06_len) insertion_flag[0] = 0;
2851  05b5 c60000        	ld	a,_insertion_flag
2852  05b8 a13b          	cp	a,#59
2855  05ba               LC005:
2856  05ba 2619          	jrne	LC008
2863  05bc 725f0000      	clr	_insertion_flag
2864                     ; 2391 	    default: break;
2866                     ; 2393           pBuffer++;
2867                     ; 2394           nBytes++;
2868  05c0 2013          	jp	LC008
2869  05c2               L135:
2870                     ; 2402         *pBuffer = nByte;
2872  05c2 1e09          	ldw	x,(OFST+1,sp)
2873  05c4 f7            	ld	(x),a
2874                     ; 2403         *ppData = *ppData + 1;
2876  05c5 1e0d          	ldw	x,(OFST+5,sp)
2877  05c7 9093          	ldw	y,x
2878  05c9 fe            	ldw	x,(x)
2879  05ca 5c            	incw	x
2880  05cb 90ff          	ldw	(y),x
2881                     ; 2404         *pDataLeft = *pDataLeft - 1;
2883  05cd 1e0f          	ldw	x,(OFST+7,sp)
2884  05cf 9093          	ldw	y,x
2885  05d1 fe            	ldw	x,(x)
2886  05d2 5a            	decw	x
2887  05d3 90ff          	ldw	(y),x
2888                     ; 2405         pBuffer++;
2890  05d5               LC008:
2892  05d5 1e09          	ldw	x,(OFST+1,sp)
2893                     ; 2406         nBytes++;
2895  05d7               LC007:
2900  05d7 5c            	incw	x
2901  05d8 1f09          	ldw	(OFST+1,sp),x
2907  05da 1e05          	ldw	x,(OFST-3,sp)
2908  05dc 5c            	incw	x
2909  05dd               LC006:
2910  05dd 1f05          	ldw	(OFST-3,sp),x
2912  05df               L515:
2913                     ; 1780   while (nBytes < nMaxBytes) {
2915  05df 1e05          	ldw	x,(OFST-3,sp)
2916  05e1 1311          	cpw	x,(OFST+9,sp)
2917  05e3 2403cc0012    	jrult	L315
2918  05e8               L715:
2919                     ; 2411   return nBytes;
2921  05e8 1e05          	ldw	x,(OFST-3,sp)
2924  05ea 5b0a          	addw	sp,#10
2925  05ec 81            	ret	
2957                     ; 2415 void HttpDInit()
2957                     ; 2416 {
2958                     .text:	section	.text,new
2959  0000               _HttpDInit:
2963                     ; 2418   uip_listen(htons(Port_Httpd));
2965  0000 ce0000        	ldw	x,_Port_Httpd
2966  0003 cd0000        	call	_htons
2968  0006 cd0000        	call	_uip_listen
2970                     ; 2419   current_webpage = WEBPAGE_IOCONTROL;
2972  0009 725f0003      	clr	_current_webpage
2973                     ; 2422   insertion_flag[0] = 0;
2975  000d 725f0000      	clr	_insertion_flag
2976                     ; 2423   insertion_flag[1] = 0;
2978  0011 725f0001      	clr	_insertion_flag+1
2979                     ; 2424   insertion_flag[2] = 0;
2981  0015 725f0002      	clr	_insertion_flag+2
2982                     ; 2427   saved_nstate = STATE_NULL;
2984  0019 357f0044      	mov	_saved_nstate,#127
2985                     ; 2428   saved_parsestate = PARSE_CMD;
2987  001d 725f0043      	clr	_saved_parsestate
2988                     ; 2429   saved_nparseleft = 0;
2990  0021 725f0042      	clr	_saved_nparseleft
2991                     ; 2430   clear_saved_postpartial_all();
2994                     ; 2431 }
2997  0025 cc0000        	jp	_clear_saved_postpartial_all
3189                     	switch	.const
3190  1d05               L622:
3191  1d05 08ac          	dc.w	L1701
3192  1d07 08b3          	dc.w	L3701
3193  1d09 08ba          	dc.w	L5701
3194  1d0b 08c1          	dc.w	L7701
3195  1d0d 08c8          	dc.w	L1011
3196  1d0f 08cf          	dc.w	L3011
3197  1d11 08d6          	dc.w	L5011
3198  1d13 08dd          	dc.w	L7011
3199  1d15 08e4          	dc.w	L1111
3200  1d17 08eb          	dc.w	L3111
3201  1d19 08f2          	dc.w	L5111
3202  1d1b 08f9          	dc.w	L7111
3203  1d1d 0900          	dc.w	L1211
3204  1d1f 0907          	dc.w	L3211
3205  1d21 090e          	dc.w	L5211
3206  1d23 0915          	dc.w	L7211
3207                     ; 2434 void HttpDCall(uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
3207                     ; 2435 {
3208                     .text:	section	.text,new
3209  0000               _HttpDCall:
3211  0000 89            	pushw	x
3212  0001 5204          	subw	sp,#4
3213       00000004      OFST:	set	4
3216                     ; 2439   i = 0;
3218  0003 0f04          	clr	(OFST+0,sp)
3220                     ; 2441   if (uip_connected()) {
3222  0005 720d000055    	btjf	_uip_flags,#6,L5421
3223                     ; 2443     if (current_webpage == WEBPAGE_IOCONTROL) {
3225  000a c60003        	ld	a,_current_webpage
3226  000d 260e          	jrne	L7421
3227                     ; 2444       pSocket->pData = g_HtmlPageIOControl;
3229  000f 1e0b          	ldw	x,(OFST+7,sp)
3230  0011 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
3231  0015 ef01          	ldw	(1,x),y
3232                     ; 2445       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
3234  0017 90ae0c06      	ldw	y,#3078
3236  001b 2034          	jp	LC013
3237  001d               L7421:
3238                     ; 2449     else if (current_webpage == WEBPAGE_CONFIGURATION) {
3240  001d a101          	cp	a,#1
3241  001f 260e          	jrne	L3521
3242                     ; 2450       pSocket->pData = g_HtmlPageConfiguration;
3244  0021 1e0b          	ldw	x,(OFST+7,sp)
3245  0023 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
3246  0027 ef01          	ldw	(1,x),y
3247                     ; 2451       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
3249  0029 90ae0c5c      	ldw	y,#3164
3251  002d 2022          	jp	LC013
3252  002f               L3521:
3253                     ; 2466     else if (current_webpage == WEBPAGE_STATS) {
3255  002f a105          	cp	a,#5
3256  0031 260e          	jrne	L7521
3257                     ; 2467       pSocket->pData = g_HtmlPageStats;
3259  0033 1e0b          	ldw	x,(OFST+7,sp)
3260  0035 90ae186c      	ldw	y,#L71_g_HtmlPageStats
3261  0039 ef01          	ldw	(1,x),y
3262                     ; 2468       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
3264  003b 90ae0175      	ldw	y,#373
3266  003f 2010          	jp	LC013
3267  0041               L7521:
3268                     ; 2472     else if (current_webpage == WEBPAGE_RSTATE) {
3270  0041 a106          	cp	a,#6
3271  0043 260e          	jrne	L1521
3272                     ; 2473       pSocket->pData = g_HtmlPageRstate;
3274  0045 1e0b          	ldw	x,(OFST+7,sp)
3275  0047 90ae19e2      	ldw	y,#L12_g_HtmlPageRstate
3276  004b ef01          	ldw	(1,x),y
3277                     ; 2474       pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
3279  004d 90ae0087      	ldw	y,#135
3280  0051               LC013:
3281  0051 ef03          	ldw	(3,x),y
3282  0053               L1521:
3283                     ; 2477     pSocket->nState = STATE_CONNECTED;
3285  0053 1e0b          	ldw	x,(OFST+7,sp)
3286                     ; 2478     pSocket->nPrevBytes = 0xFFFF;
3288  0055 90aeffff      	ldw	y,#65535
3289  0059 7f            	clr	(x)
3290  005a ef0b          	ldw	(11,x),y
3292  005c cc012f        	jra	L452
3293  005f               L5421:
3294                     ; 2487   else if (uip_newdata() || uip_acked()) {
3296  005f 7202000008    	btjt	_uip_flags,#1,L1721
3298  0064 7200000003cc  	btjf	_uip_flags,#0,L7621
3299  006c               L1721:
3300                     ; 2488     if (uip_acked()) {
3302  006c 7201000003cc  	btjt	_uip_flags,#0,L5511
3303                     ; 2491       goto senddata;
3305                     ; 2561     if (saved_nstate != STATE_NULL) {
3307  0074 c60044        	ld	a,_saved_nstate
3308  0077 a17f          	cp	a,#127
3309  0079 2603cc00fb    	jreq	L3231
3310                     ; 2567       pSocket->nState = saved_nstate;
3312  007e 1e0b          	ldw	x,(OFST+7,sp)
3313  0080 f7            	ld	(x),a
3314                     ; 2574       pSocket->ParseState = saved_parsestate;
3316  0081 c60043        	ld	a,_saved_parsestate
3317  0084 e70a          	ld	(10,x),a
3318                     ; 2578       pSocket->nParseLeft = saved_nparseleft;
3320  0086 c60042        	ld	a,_saved_nparseleft
3321  0089 e706          	ld	(6,x),a
3322                     ; 2580       pSocket->nNewlines = saved_newlines;
3324  008b c60011        	ld	a,_saved_newlines
3325  008e e705          	ld	(5,x),a
3326                     ; 2592       for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i];
3328  0090 4f            	clr	a
3329  0091 6b04          	ld	(OFST+0,sp),a
3331  0093               L7721:
3334  0093 5f            	clrw	x
3335  0094 97            	ld	xl,a
3336  0095 d6002a        	ld	a,(_saved_postpartial,x)
3337  0098 d70012        	ld	(_saved_postpartial_previous,x),a
3340  009b 0c04          	inc	(OFST+0,sp)
3344  009d 7b04          	ld	a,(OFST+0,sp)
3345  009f a118          	cp	a,#24
3346  00a1 25f0          	jrult	L7721
3347                     ; 2597       if (saved_nstate == STATE_PARSEPOST) {
3349  00a3 c60044        	ld	a,_saved_nstate
3350  00a6 a10a          	cp	a,#10
3351  00a8 2651          	jrne	L3231
3352                     ; 2598         if (saved_parsestate == PARSE_CMD) {
3354  00aa c60043        	ld	a,_saved_parsestate
3355  00ad 274c          	jreq	L3231
3357                     ; 2601         else if (saved_parsestate == PARSE_NUM10) {
3359  00af a101          	cp	a,#1
3360  00b1 2609          	jrne	L3131
3361                     ; 2603 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3363  00b3 1e0b          	ldw	x,(OFST+7,sp)
3364  00b5 c60012        	ld	a,_saved_postpartial_previous
3365  00b8 e708          	ld	(8,x),a
3367  00ba 203f          	jra	L3231
3368  00bc               L3131:
3369                     ; 2605         else if (saved_parsestate == PARSE_NUM1) {
3371  00bc a102          	cp	a,#2
3372  00be 2615          	jrne	L7131
3373                     ; 2607 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3375  00c0 1e0b          	ldw	x,(OFST+7,sp)
3376  00c2 c60012        	ld	a,_saved_postpartial_previous
3377  00c5 e708          	ld	(8,x),a
3378                     ; 2608           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3380  00c7 c60013        	ld	a,_saved_postpartial_previous+1
3381  00ca 97            	ld	xl,a
3382  00cb a60a          	ld	a,#10
3383  00cd 42            	mul	x,a
3384  00ce 9f            	ld	a,xl
3385  00cf a0e0          	sub	a,#224
3386  00d1 1e0b          	ldw	x,(OFST+7,sp)
3388  00d3 2024          	jp	LC014
3389  00d5               L7131:
3390                     ; 2610         else if (saved_parsestate == PARSE_EQUAL || saved_parsestate == PARSE_VAL) {
3392  00d5 a103          	cp	a,#3
3393  00d7 2704          	jreq	L5231
3395  00d9 a104          	cp	a,#4
3396  00db 261e          	jrne	L3231
3397  00dd               L5231:
3398                     ; 2612 	  pSocket->ParseCmd = saved_postpartial_previous[0];
3400  00dd 1e0b          	ldw	x,(OFST+7,sp)
3401  00df c60012        	ld	a,_saved_postpartial_previous
3402  00e2 e708          	ld	(8,x),a
3403                     ; 2613           pSocket->ParseNum = (uint8_t)((saved_postpartial_previous[1] - '0') * 10);
3405  00e4 c60013        	ld	a,_saved_postpartial_previous+1
3406  00e7 97            	ld	xl,a
3407  00e8 a60a          	ld	a,#10
3408  00ea 42            	mul	x,a
3409  00eb 9f            	ld	a,xl
3410  00ec 1e0b          	ldw	x,(OFST+7,sp)
3411  00ee a0e0          	sub	a,#224
3412  00f0 e709          	ld	(9,x),a
3413                     ; 2614           pSocket->ParseNum += (uint8_t)(saved_postpartial_previous[2] - '0');
3415  00f2 c60014        	ld	a,_saved_postpartial_previous+2
3416  00f5 a030          	sub	a,#48
3417  00f7 eb09          	add	a,(9,x)
3418  00f9               LC014:
3419  00f9 e709          	ld	(9,x),a
3421  00fb               L3231:
3422                     ; 2616 	else if (saved_parsestate == PARSE_DELIM) {
3424                     ; 2636     if (pSocket->nState == STATE_CONNECTED) {
3426  00fb 1e0b          	ldw	x,(OFST+7,sp)
3427  00fd f6            	ld	a,(x)
3428  00fe 2627          	jrne	L3331
3429                     ; 2637       if (nBytes == 0) return;
3431  0100 1e09          	ldw	x,(OFST+5,sp)
3432  0102 272b          	jreq	L452
3435                     ; 2638       if (*pBuffer == 'G') {
3437  0104 1e05          	ldw	x,(OFST+1,sp)
3438  0106 f6            	ld	a,(x)
3439  0107 a147          	cp	a,#71
3440  0109 2606          	jrne	L7331
3441                     ; 2639         pSocket->nState = STATE_GET_G;
3443  010b 1e0b          	ldw	x,(OFST+7,sp)
3444  010d a601          	ld	a,#1
3446  010f 2008          	jp	LC015
3447  0111               L7331:
3448                     ; 2641       else if (*pBuffer == 'P') {
3450  0111 a150          	cp	a,#80
3451  0113 2605          	jrne	L1431
3452                     ; 2642         pSocket->nState = STATE_POST_P;
3454  0115 1e0b          	ldw	x,(OFST+7,sp)
3455  0117 a604          	ld	a,#4
3456  0119               LC015:
3457  0119 f7            	ld	(x),a
3458  011a               L1431:
3459                     ; 2644       nBytes--;
3461  011a 1e09          	ldw	x,(OFST+5,sp)
3462  011c 5a            	decw	x
3463  011d 1f09          	ldw	(OFST+5,sp),x
3464                     ; 2645       pBuffer++;
3466  011f 1e05          	ldw	x,(OFST+1,sp)
3467  0121 5c            	incw	x
3468  0122 1f05          	ldw	(OFST+1,sp),x
3469  0124 1e0b          	ldw	x,(OFST+7,sp)
3470  0126 f6            	ld	a,(x)
3471  0127               L3331:
3472                     ; 2648     if (pSocket->nState == STATE_GET_G) {
3474  0127 a101          	cp	a,#1
3475  0129 2620          	jrne	L5431
3476                     ; 2649       if (nBytes == 0) return;
3478  012b 1e09          	ldw	x,(OFST+5,sp)
3479  012d 2603          	jrne	L7431
3481  012f               L452:
3484  012f 5b06          	addw	sp,#6
3485  0131 81            	ret	
3486  0132               L7431:
3487                     ; 2650       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
3489  0132 1e05          	ldw	x,(OFST+1,sp)
3490  0134 f6            	ld	a,(x)
3491  0135 a145          	cp	a,#69
3492  0137 2605          	jrne	L1531
3495  0139 1e0b          	ldw	x,(OFST+7,sp)
3496  013b a602          	ld	a,#2
3497  013d f7            	ld	(x),a
3498  013e               L1531:
3499                     ; 2651       nBytes--;
3501  013e 1e09          	ldw	x,(OFST+5,sp)
3502  0140 5a            	decw	x
3503  0141 1f09          	ldw	(OFST+5,sp),x
3504                     ; 2652       pBuffer++;
3506  0143 1e05          	ldw	x,(OFST+1,sp)
3507  0145 5c            	incw	x
3508  0146 1f05          	ldw	(OFST+1,sp),x
3509  0148 1e0b          	ldw	x,(OFST+7,sp)
3510  014a f6            	ld	a,(x)
3511  014b               L5431:
3512                     ; 2655     if (pSocket->nState == STATE_GET_GE) {
3514  014b a102          	cp	a,#2
3515  014d 261d          	jrne	L3531
3516                     ; 2656       if (nBytes == 0) return;
3518  014f 1e09          	ldw	x,(OFST+5,sp)
3519  0151 27dc          	jreq	L452
3522                     ; 2657       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
3524  0153 1e05          	ldw	x,(OFST+1,sp)
3525  0155 f6            	ld	a,(x)
3526  0156 a154          	cp	a,#84
3527  0158 2605          	jrne	L7531
3530  015a 1e0b          	ldw	x,(OFST+7,sp)
3531  015c a603          	ld	a,#3
3532  015e f7            	ld	(x),a
3533  015f               L7531:
3534                     ; 2658       nBytes--;
3536  015f 1e09          	ldw	x,(OFST+5,sp)
3537  0161 5a            	decw	x
3538  0162 1f09          	ldw	(OFST+5,sp),x
3539                     ; 2659       pBuffer++;
3541  0164 1e05          	ldw	x,(OFST+1,sp)
3542  0166 5c            	incw	x
3543  0167 1f05          	ldw	(OFST+1,sp),x
3544  0169 1e0b          	ldw	x,(OFST+7,sp)
3545  016b f6            	ld	a,(x)
3546  016c               L3531:
3547                     ; 2662     if (pSocket->nState == STATE_GET_GET) {
3549  016c a103          	cp	a,#3
3550  016e 261d          	jrne	L1631
3551                     ; 2663       if (nBytes == 0) return;
3553  0170 1e09          	ldw	x,(OFST+5,sp)
3554  0172 27bb          	jreq	L452
3557                     ; 2664       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
3559  0174 1e05          	ldw	x,(OFST+1,sp)
3560  0176 f6            	ld	a,(x)
3561  0177 a120          	cp	a,#32
3562  0179 2605          	jrne	L5631
3565  017b 1e0b          	ldw	x,(OFST+7,sp)
3566  017d a608          	ld	a,#8
3567  017f f7            	ld	(x),a
3568  0180               L5631:
3569                     ; 2665       nBytes--;
3571  0180 1e09          	ldw	x,(OFST+5,sp)
3572  0182 5a            	decw	x
3573  0183 1f09          	ldw	(OFST+5,sp),x
3574                     ; 2666       pBuffer++;
3576  0185 1e05          	ldw	x,(OFST+1,sp)
3577  0187 5c            	incw	x
3578  0188 1f05          	ldw	(OFST+1,sp),x
3579  018a 1e0b          	ldw	x,(OFST+7,sp)
3580  018c f6            	ld	a,(x)
3581  018d               L1631:
3582                     ; 2669     if (pSocket->nState == STATE_POST_P) {
3584  018d a104          	cp	a,#4
3585  018f 261d          	jrne	L7631
3586                     ; 2670       if (nBytes == 0) return;
3588  0191 1e09          	ldw	x,(OFST+5,sp)
3589  0193 279a          	jreq	L452
3592                     ; 2671       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
3594  0195 1e05          	ldw	x,(OFST+1,sp)
3595  0197 f6            	ld	a,(x)
3596  0198 a14f          	cp	a,#79
3597  019a 2605          	jrne	L3731
3600  019c 1e0b          	ldw	x,(OFST+7,sp)
3601  019e a605          	ld	a,#5
3602  01a0 f7            	ld	(x),a
3603  01a1               L3731:
3604                     ; 2672       nBytes--;
3606  01a1 1e09          	ldw	x,(OFST+5,sp)
3607  01a3 5a            	decw	x
3608  01a4 1f09          	ldw	(OFST+5,sp),x
3609                     ; 2673       pBuffer++;
3611  01a6 1e05          	ldw	x,(OFST+1,sp)
3612  01a8 5c            	incw	x
3613  01a9 1f05          	ldw	(OFST+1,sp),x
3614  01ab 1e0b          	ldw	x,(OFST+7,sp)
3615  01ad f6            	ld	a,(x)
3616  01ae               L7631:
3617                     ; 2676     if (pSocket->nState == STATE_POST_PO) {
3619  01ae a105          	cp	a,#5
3620  01b0 2620          	jrne	L5731
3621                     ; 2677       if (nBytes == 0) return;
3623  01b2 1e09          	ldw	x,(OFST+5,sp)
3624  01b4 2603cc012f    	jreq	L452
3627                     ; 2678       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
3629  01b9 1e05          	ldw	x,(OFST+1,sp)
3630  01bb f6            	ld	a,(x)
3631  01bc a153          	cp	a,#83
3632  01be 2605          	jrne	L1041
3635  01c0 1e0b          	ldw	x,(OFST+7,sp)
3636  01c2 a606          	ld	a,#6
3637  01c4 f7            	ld	(x),a
3638  01c5               L1041:
3639                     ; 2679       nBytes--;
3641  01c5 1e09          	ldw	x,(OFST+5,sp)
3642  01c7 5a            	decw	x
3643  01c8 1f09          	ldw	(OFST+5,sp),x
3644                     ; 2680       pBuffer++;
3646  01ca 1e05          	ldw	x,(OFST+1,sp)
3647  01cc 5c            	incw	x
3648  01cd 1f05          	ldw	(OFST+1,sp),x
3649  01cf 1e0b          	ldw	x,(OFST+7,sp)
3650  01d1 f6            	ld	a,(x)
3651  01d2               L5731:
3652                     ; 2683     if (pSocket->nState == STATE_POST_POS) {
3654  01d2 a106          	cp	a,#6
3655  01d4 261d          	jrne	L3041
3656                     ; 2684       if (nBytes == 0) return;
3658  01d6 1e09          	ldw	x,(OFST+5,sp)
3659  01d8 27dc          	jreq	L452
3662                     ; 2685       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
3664  01da 1e05          	ldw	x,(OFST+1,sp)
3665  01dc f6            	ld	a,(x)
3666  01dd a154          	cp	a,#84
3667  01df 2605          	jrne	L7041
3670  01e1 1e0b          	ldw	x,(OFST+7,sp)
3671  01e3 a607          	ld	a,#7
3672  01e5 f7            	ld	(x),a
3673  01e6               L7041:
3674                     ; 2686       nBytes--;
3676  01e6 1e09          	ldw	x,(OFST+5,sp)
3677  01e8 5a            	decw	x
3678  01e9 1f09          	ldw	(OFST+5,sp),x
3679                     ; 2687       pBuffer++;
3681  01eb 1e05          	ldw	x,(OFST+1,sp)
3682  01ed 5c            	incw	x
3683  01ee 1f05          	ldw	(OFST+1,sp),x
3684  01f0 1e0b          	ldw	x,(OFST+7,sp)
3685  01f2 f6            	ld	a,(x)
3686  01f3               L3041:
3687                     ; 2690     if (pSocket->nState == STATE_POST_POST) {
3689  01f3 a107          	cp	a,#7
3690  01f5 261d          	jrne	L1141
3691                     ; 2691       if (nBytes == 0) return;
3693  01f7 1e09          	ldw	x,(OFST+5,sp)
3694  01f9 27bb          	jreq	L452
3697                     ; 2692       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
3699  01fb 1e05          	ldw	x,(OFST+1,sp)
3700  01fd f6            	ld	a,(x)
3701  01fe a120          	cp	a,#32
3702  0200 2605          	jrne	L5141
3705  0202 1e0b          	ldw	x,(OFST+7,sp)
3706  0204 a609          	ld	a,#9
3707  0206 f7            	ld	(x),a
3708  0207               L5141:
3709                     ; 2693       nBytes--;
3711  0207 1e09          	ldw	x,(OFST+5,sp)
3712  0209 5a            	decw	x
3713  020a 1f09          	ldw	(OFST+5,sp),x
3714                     ; 2694       pBuffer++;
3716  020c 1e05          	ldw	x,(OFST+1,sp)
3717  020e 5c            	incw	x
3718  020f 1f05          	ldw	(OFST+1,sp),x
3719  0211 1e0b          	ldw	x,(OFST+7,sp)
3720  0213 f6            	ld	a,(x)
3721  0214               L1141:
3722                     ; 2697     if (pSocket->nState == STATE_GOTPOST) {
3724  0214 a109          	cp	a,#9
3725  0216 2703cc029d    	jrne	L7141
3726                     ; 2699       saved_nstate = STATE_GOTPOST;
3728  021b 35090044      	mov	_saved_nstate,#9
3729                     ; 2700       if (nBytes == 0) {
3731  021f 1e09          	ldw	x,(OFST+5,sp)
3732  0221 2676          	jrne	L5241
3733                     ; 2703 	saved_newlines = pSocket->nNewlines;
3735  0223 1e0b          	ldw	x,(OFST+7,sp)
3736  0225 e605          	ld	a,(5,x)
3737  0227 c70011        	ld	_saved_newlines,a
3738                     ; 2704         return;
3740  022a cc012f        	jra	L452
3741  022d               L3241:
3742                     ; 2712 	if (saved_newlines == 2) {
3744  022d c60011        	ld	a,_saved_newlines
3745  0230 a102          	cp	a,#2
3746  0232 272b          	jreq	L3341
3748                     ; 2717           if (*pBuffer == '\n') pSocket->nNewlines++;
3750  0234 1e05          	ldw	x,(OFST+1,sp)
3751  0236 f6            	ld	a,(x)
3752  0237 a10a          	cp	a,#10
3753  0239 2606          	jrne	L5341
3756  023b 1e0b          	ldw	x,(OFST+7,sp)
3757  023d 6c05          	inc	(5,x)
3759  023f 2008          	jra	L7341
3760  0241               L5341:
3761                     ; 2718           else if (*pBuffer == '\r') { }
3763  0241 a10d          	cp	a,#13
3764  0243 2704          	jreq	L7341
3766                     ; 2719           else pSocket->nNewlines = 0;
3768  0245 1e0b          	ldw	x,(OFST+7,sp)
3769  0247 6f05          	clr	(5,x)
3770  0249               L7341:
3771                     ; 2720           pBuffer++;
3773  0249 1e05          	ldw	x,(OFST+1,sp)
3774  024b 5c            	incw	x
3775  024c 1f05          	ldw	(OFST+1,sp),x
3776                     ; 2721           nBytes--;
3778  024e 1e09          	ldw	x,(OFST+5,sp)
3779  0250 5a            	decw	x
3780  0251 1f09          	ldw	(OFST+5,sp),x
3781                     ; 2722           if (nBytes == 0) {
3783  0253 260a          	jrne	L3341
3784                     ; 2725             saved_newlines = pSocket->nNewlines;
3786  0255 1e0b          	ldw	x,(OFST+7,sp)
3787  0257 e605          	ld	a,(5,x)
3788  0259 c70011        	ld	_saved_newlines,a
3789                     ; 2726             return;
3791  025c cc012f        	jra	L452
3792  025f               L3341:
3793                     ; 2734         if (pSocket->nNewlines == 2) {
3795  025f 1e0b          	ldw	x,(OFST+7,sp)
3796  0261 e605          	ld	a,(5,x)
3797  0263 a102          	cp	a,#2
3798  0265 2632          	jrne	L5241
3799                     ; 2737           if (current_webpage == WEBPAGE_IOCONTROL) {
3801  0267 c60003        	ld	a,_current_webpage
3802  026a 2609          	jrne	L1541
3803                     ; 2738 	    pSocket->nParseLeft = PARSEBYTES_IOCONTROL;
3805  026c a635          	ld	a,#53
3806  026e e706          	ld	(6,x),a
3807                     ; 2739 	    pSocket->nParseLeftAddl = PARSEBYTES_IOCONTROL_ADDL;
3809  0270 6f07          	clr	(7,x)
3810  0272 c60003        	ld	a,_current_webpage
3811  0275               L1541:
3812                     ; 2741           if (current_webpage == WEBPAGE_CONFIGURATION) {
3814  0275 4a            	dec	a
3815  0276 2608          	jrne	L3541
3816                     ; 2742 	    pSocket->nParseLeft = PARSEBYTES_CONFIGURATION;
3818  0278 a6ec          	ld	a,#236
3819  027a e706          	ld	(6,x),a
3820                     ; 2743 	    pSocket->nParseLeftAddl = PARSEBYTES_CONFIGURATION_ADDL;
3822  027c a618          	ld	a,#24
3823  027e e707          	ld	(7,x),a
3824  0280               L3541:
3825                     ; 2745           pSocket->ParseState = saved_parsestate = PARSE_CMD;
3827  0280 725f0043      	clr	_saved_parsestate
3828  0284 6f0a          	clr	(10,x)
3829                     ; 2746 	  saved_nparseleft = pSocket->nParseLeft;
3831  0286 e606          	ld	a,(6,x)
3832  0288 c70042        	ld	_saved_nparseleft,a
3833                     ; 2748           pSocket->nState = STATE_PARSEPOST;
3835  028b a60a          	ld	a,#10
3836  028d f7            	ld	(x),a
3837                     ; 2749 	  saved_nstate = STATE_PARSEPOST;
3839  028e 350a0044      	mov	_saved_nstate,#10
3840                     ; 2750 	  if (nBytes == 0) {
3842  0292 1e09          	ldw	x,(OFST+5,sp)
3843  0294 2607          	jrne	L7141
3844                     ; 2753 	    return;
3846  0296 cc012f        	jra	L452
3847  0299               L5241:
3848                     ; 2707       while (nBytes != 0) {
3850  0299 1e09          	ldw	x,(OFST+5,sp)
3851  029b 2690          	jrne	L3241
3852  029d               L7141:
3853                     ; 2760     if (pSocket->nState == STATE_GOTGET) {
3855  029d 1e0b          	ldw	x,(OFST+7,sp)
3856  029f f6            	ld	a,(x)
3857  02a0 a108          	cp	a,#8
3858  02a2 2609          	jrne	L7541
3859                     ; 2764       pSocket->nParseLeft = 6;
3861  02a4 a606          	ld	a,#6
3862  02a6 e706          	ld	(6,x),a
3863                     ; 2765       pSocket->ParseState = PARSE_SLASH1;
3865  02a8 e70a          	ld	(10,x),a
3866                     ; 2767       pSocket->nState = STATE_PARSEGET;
3868  02aa a60d          	ld	a,#13
3869  02ac f7            	ld	(x),a
3870  02ad               L7541:
3871                     ; 2770     if (pSocket->nState == STATE_PARSEPOST) {
3873  02ad a10a          	cp	a,#10
3874  02af 2703cc078d    	jrne	L1641
3875  02b4               L3641:
3876                     ; 2784         if (pSocket->ParseState == PARSE_CMD) {
3878  02b4 1e0b          	ldw	x,(OFST+7,sp)
3879  02b6 e60a          	ld	a,(10,x)
3880  02b8 2664          	jrne	L7641
3881                     ; 2785           pSocket->ParseCmd = *pBuffer;
3883  02ba 1e05          	ldw	x,(OFST+1,sp)
3884  02bc f6            	ld	a,(x)
3885  02bd 1e0b          	ldw	x,(OFST+7,sp)
3886  02bf e708          	ld	(8,x),a
3887                     ; 2786 	  saved_postpartial[0] = *pBuffer;
3889  02c1 1e05          	ldw	x,(OFST+1,sp)
3890  02c3 f6            	ld	a,(x)
3891  02c4 c7002a        	ld	_saved_postpartial,a
3892                     ; 2787           pSocket->ParseState = saved_parsestate = PARSE_NUM10;
3894  02c7 a601          	ld	a,#1
3895  02c9 c70043        	ld	_saved_parsestate,a
3896  02cc 1e0b          	ldw	x,(OFST+7,sp)
3897  02ce e70a          	ld	(10,x),a
3898                     ; 2788 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3900  02d0 e606          	ld	a,(6,x)
3901  02d2 2704          	jreq	L1741
3902                     ; 2789 	    pSocket->nParseLeft--;
3904  02d4 6a06          	dec	(6,x)
3906  02d6 2004          	jra	L3741
3907  02d8               L1741:
3908                     ; 2793 	    pSocket->ParseState = PARSE_DELIM;
3910  02d8 a605          	ld	a,#5
3911  02da e70a          	ld	(10,x),a
3912  02dc               L3741:
3913                     ; 2795 	  saved_nparseleft = pSocket->nParseLeft;
3915  02dc e606          	ld	a,(6,x)
3916  02de c70042        	ld	_saved_nparseleft,a
3917                     ; 2796           pBuffer++;
3919  02e1 1e05          	ldw	x,(OFST+1,sp)
3920  02e3 5c            	incw	x
3921  02e4 1f05          	ldw	(OFST+1,sp),x
3922                     ; 2797 	  nBytes --;
3924  02e6 1e09          	ldw	x,(OFST+5,sp)
3925  02e8 5a            	decw	x
3926  02e9 1f09          	ldw	(OFST+5,sp),x
3927                     ; 2799 	  if (pSocket->ParseCmd == 'o' ||
3927                     ; 2800 	      pSocket->ParseCmd == 'a' ||
3927                     ; 2801 	      pSocket->ParseCmd == 'b' ||
3927                     ; 2802 	      pSocket->ParseCmd == 'c' ||
3927                     ; 2803 	      pSocket->ParseCmd == 'd' ||
3927                     ; 2804 	      pSocket->ParseCmd == 'g' ||
3927                     ; 2805 	      pSocket->ParseCmd == 'l' ||
3927                     ; 2806 	      pSocket->ParseCmd == 'm' ||
3927                     ; 2807 	      pSocket->ParseCmd == 'z') { }
3929  02eb 1e0b          	ldw	x,(OFST+7,sp)
3930  02ed e608          	ld	a,(8,x)
3931  02ef a16f          	cp	a,#111
3932  02f1 2724          	jreq	L7151
3934  02f3 a161          	cp	a,#97
3935  02f5 2720          	jreq	L7151
3937  02f7 a162          	cp	a,#98
3938  02f9 271c          	jreq	L7151
3940  02fb a163          	cp	a,#99
3941  02fd 2718          	jreq	L7151
3943  02ff a164          	cp	a,#100
3944  0301 2714          	jreq	L7151
3946  0303 a167          	cp	a,#103
3947  0305 2710          	jreq	L7151
3949  0307 a16c          	cp	a,#108
3950  0309 270c          	jreq	L7151
3952  030b a16d          	cp	a,#109
3953  030d 2708          	jreq	L7151
3955  030f a17a          	cp	a,#122
3956  0311 2704          	jreq	L7151
3957                     ; 2810 	    pSocket->ParseState = PARSE_DELIM;
3959  0313 a605          	ld	a,#5
3960  0315 e70a          	ld	(10,x),a
3961  0317               L7151:
3962                     ; 2812 	  if (nBytes == 0) { // Hit end of fragment. Break out of while()
3964  0317 1e09          	ldw	x,(OFST+5,sp)
3965  0319 2699          	jrne	L3641
3966                     ; 2814 	    break;
3968  031b cc0735        	jra	L5641
3969  031e               L7641:
3970                     ; 2818         else if (pSocket->ParseState == PARSE_NUM10) {
3972  031e a101          	cp	a,#1
3973  0320 2640          	jrne	L5251
3974                     ; 2819           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
3976  0322 1e05          	ldw	x,(OFST+1,sp)
3977  0324 f6            	ld	a,(x)
3978  0325 97            	ld	xl,a
3979  0326 a60a          	ld	a,#10
3980  0328 42            	mul	x,a
3981  0329 9f            	ld	a,xl
3982  032a 1e0b          	ldw	x,(OFST+7,sp)
3983  032c a0e0          	sub	a,#224
3984  032e e709          	ld	(9,x),a
3985                     ; 2820 	  saved_postpartial[1] = *pBuffer;
3987  0330 1e05          	ldw	x,(OFST+1,sp)
3988  0332 f6            	ld	a,(x)
3989  0333 c7002b        	ld	_saved_postpartial+1,a
3990                     ; 2821           pSocket->ParseState = saved_parsestate = PARSE_NUM1;
3992  0336 a602          	ld	a,#2
3993  0338 c70043        	ld	_saved_parsestate,a
3994  033b 1e0b          	ldw	x,(OFST+7,sp)
3995  033d e70a          	ld	(10,x),a
3996                     ; 2822 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
3998  033f e606          	ld	a,(6,x)
3999  0341 2704          	jreq	L7251
4000                     ; 2823 	    pSocket->nParseLeft--;
4002  0343 6a06          	dec	(6,x)
4004  0345 2004          	jra	L1351
4005  0347               L7251:
4006                     ; 2827 	    pSocket->ParseState = PARSE_DELIM;
4008  0347 a605          	ld	a,#5
4009  0349 e70a          	ld	(10,x),a
4010  034b               L1351:
4011                     ; 2829 	  saved_nparseleft = pSocket->nParseLeft;
4013  034b e606          	ld	a,(6,x)
4014  034d c70042        	ld	_saved_nparseleft,a
4015                     ; 2830           pBuffer++;
4017  0350 1e05          	ldw	x,(OFST+1,sp)
4018  0352 5c            	incw	x
4019  0353 1f05          	ldw	(OFST+1,sp),x
4020                     ; 2831 	  nBytes--;
4022  0355 1e09          	ldw	x,(OFST+5,sp)
4023  0357 5a            	decw	x
4024  0358 1f09          	ldw	(OFST+5,sp),x
4025                     ; 2832 	  if (nBytes == 0) {
4027  035a 2703cc02b4    	jrne	L3641
4028                     ; 2834 	    break;
4030  035f cc0735        	jra	L5641
4031  0362               L5251:
4032                     ; 2838         else if (pSocket->ParseState == PARSE_NUM1) {
4034  0362 a102          	cp	a,#2
4035  0364 2638          	jrne	L7351
4036                     ; 2839           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
4038  0366 1605          	ldw	y,(OFST+1,sp)
4039  0368 90f6          	ld	a,(y)
4040  036a a030          	sub	a,#48
4041  036c eb09          	add	a,(9,x)
4042  036e e709          	ld	(9,x),a
4043                     ; 2840 	  saved_postpartial[2] = *pBuffer;
4045  0370 93            	ldw	x,y
4046  0371 f6            	ld	a,(x)
4047  0372 c7002c        	ld	_saved_postpartial+2,a
4048                     ; 2841           pSocket->ParseState = saved_parsestate = PARSE_EQUAL;
4050  0375 a603          	ld	a,#3
4051  0377 c70043        	ld	_saved_parsestate,a
4052  037a 1e0b          	ldw	x,(OFST+7,sp)
4053  037c e70a          	ld	(10,x),a
4054                     ; 2842 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
4056  037e e606          	ld	a,(6,x)
4057  0380 2704          	jreq	L1451
4058                     ; 2843 	    pSocket->nParseLeft--;
4060  0382 6a06          	dec	(6,x)
4062  0384 2004          	jra	L3451
4063  0386               L1451:
4064                     ; 2847 	    pSocket->ParseState = PARSE_DELIM;
4066  0386 a605          	ld	a,#5
4067  0388 e70a          	ld	(10,x),a
4068  038a               L3451:
4069                     ; 2849 	  saved_nparseleft = pSocket->nParseLeft;
4071  038a e606          	ld	a,(6,x)
4072  038c c70042        	ld	_saved_nparseleft,a
4073                     ; 2850           pBuffer++;
4075  038f 1e05          	ldw	x,(OFST+1,sp)
4076  0391 5c            	incw	x
4077  0392 1f05          	ldw	(OFST+1,sp),x
4078                     ; 2851 	  nBytes--;
4080  0394 1e09          	ldw	x,(OFST+5,sp)
4081  0396 5a            	decw	x
4082  0397 1f09          	ldw	(OFST+5,sp),x
4083                     ; 2852 	  if (nBytes == 0) {
4085  0399 26c1          	jrne	L3641
4086                     ; 2854 	    break;
4088  039b cc0735        	jra	L5641
4089  039e               L7351:
4090                     ; 2858         else if (pSocket->ParseState == PARSE_EQUAL) {
4092  039e a103          	cp	a,#3
4093  03a0 262f          	jrne	L1551
4094                     ; 2859           pSocket->ParseState = saved_parsestate = PARSE_VAL;
4096  03a2 a604          	ld	a,#4
4097  03a4 c70043        	ld	_saved_parsestate,a
4098  03a7 e70a          	ld	(10,x),a
4099                     ; 2860 	  saved_postpartial[3] = *pBuffer;
4101  03a9 1e05          	ldw	x,(OFST+1,sp)
4102  03ab f6            	ld	a,(x)
4103  03ac c7002d        	ld	_saved_postpartial+3,a
4104                     ; 2861 	  if (pSocket->nParseLeft > 0) { // Prevent underflow
4106  03af 1e0b          	ldw	x,(OFST+7,sp)
4107  03b1 e606          	ld	a,(6,x)
4108  03b3 2704          	jreq	L3551
4109                     ; 2862 	    pSocket->nParseLeft--;
4111  03b5 6a06          	dec	(6,x)
4113  03b7 2004          	jra	L5551
4114  03b9               L3551:
4115                     ; 2866 	    pSocket->ParseState = PARSE_DELIM;
4117  03b9 a605          	ld	a,#5
4118  03bb e70a          	ld	(10,x),a
4119  03bd               L5551:
4120                     ; 2868 	  saved_nparseleft = pSocket->nParseLeft;
4122  03bd e606          	ld	a,(6,x)
4123  03bf c70042        	ld	_saved_nparseleft,a
4124                     ; 2869           pBuffer++;
4126  03c2 1e05          	ldw	x,(OFST+1,sp)
4127  03c4 5c            	incw	x
4128  03c5 1f05          	ldw	(OFST+1,sp),x
4129                     ; 2870 	  nBytes--;
4131  03c7 1e09          	ldw	x,(OFST+5,sp)
4132  03c9 5a            	decw	x
4133  03ca 1f09          	ldw	(OFST+5,sp),x
4134                     ; 2871 	  if (nBytes == 0) {
4136  03cc 268e          	jrne	L3641
4137                     ; 2873 	    break;
4139  03ce cc0735        	jra	L5641
4140  03d1               L1551:
4141                     ; 2877         else if (pSocket->ParseState == PARSE_VAL) {
4143  03d1 a104          	cp	a,#4
4144  03d3 2703cc0708    	jrne	L3651
4145                     ; 2890           if (pSocket->ParseCmd == 'o') {
4147  03d8 e608          	ld	a,(8,x)
4148  03da a16f          	cp	a,#111
4149  03dc 2640          	jrne	L5651
4150                     ; 2904               if ((uint8_t)(*pBuffer) == '1') pin_value = 1;
4152  03de 1e05          	ldw	x,(OFST+1,sp)
4153  03e0 f6            	ld	a,(x)
4154  03e1 a131          	cp	a,#49
4155  03e3 2604          	jrne	L7651
4158  03e5 a601          	ld	a,#1
4160  03e7 2001          	jra	L1751
4161  03e9               L7651:
4162                     ; 2905 	      else pin_value = 0;
4164  03e9 4f            	clr	a
4165  03ea               L1751:
4166  03ea 6b01          	ld	(OFST-3,sp),a
4168                     ; 2906 	      GpioSetPin(pSocket->ParseNum, (uint8_t)pin_value);
4170  03ec 160b          	ldw	y,(OFST+7,sp)
4171  03ee 97            	ld	xl,a
4172  03ef 90e609        	ld	a,(9,y)
4173  03f2 95            	ld	xh,a
4174  03f3 cd0000        	call	_GpioSetPin
4176                     ; 2908 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent
4178  03f6 1e0b          	ldw	x,(OFST+7,sp)
4179  03f8 e606          	ld	a,(6,x)
4180  03fa 2704          	jreq	L3751
4183  03fc 6a06          	dec	(6,x)
4184  03fe e606          	ld	a,(6,x)
4185  0400               L3751:
4186                     ; 2910             saved_nparseleft = pSocket->nParseLeft;
4188  0400 c70042        	ld	_saved_nparseleft,a
4189                     ; 2911             pBuffer++;
4191  0403 1e05          	ldw	x,(OFST+1,sp)
4192  0405 5c            	incw	x
4193  0406 1f05          	ldw	(OFST+1,sp),x
4194                     ; 2912 	    nBytes--;
4196  0408 1e09          	ldw	x,(OFST+5,sp)
4197  040a 5a            	decw	x
4198  040b 1f09          	ldw	(OFST+5,sp),x
4199                     ; 2913 	    if (nBytes == 0) {
4201  040d 2703cc06e6    	jrne	L7751
4202                     ; 2916 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4204  0412 a605          	ld	a,#5
4205  0414 c70043        	ld	_saved_parsestate,a
4206  0417 1e0b          	ldw	x,(OFST+7,sp)
4207  0419 e70a          	ld	(10,x),a
4208                     ; 2917 	      break;
4210  041b cc0735        	jra	L5641
4211  041e               L5651:
4212                     ; 2924           else if (pSocket->ParseCmd == 'a'
4212                     ; 2925                 || pSocket->ParseCmd == 'l'
4212                     ; 2926                 || pSocket->ParseCmd == 'm' ) {
4214  041e a161          	cp	a,#97
4215  0420 2708          	jreq	L3061
4217  0422 a16c          	cp	a,#108
4218  0424 2704          	jreq	L3061
4220  0426 a16d          	cp	a,#109
4221  0428 2657          	jrne	L1061
4222  042a               L3061:
4223                     ; 2930 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4225  042a 725f000a      	clr	_break_while
4226                     ; 2932             tmp_pBuffer = pBuffer;
4228  042e 1e05          	ldw	x,(OFST+1,sp)
4229  0430 cf000e        	ldw	_tmp_pBuffer,x
4230                     ; 2933             tmp_nBytes = nBytes;
4232  0433 1e09          	ldw	x,(OFST+5,sp)
4233  0435 cf000c        	ldw	_tmp_nBytes,x
4234                     ; 2934 	    tmp_nParseLeft = pSocket->nParseLeft;
4236  0438 1e0b          	ldw	x,(OFST+7,sp)
4237  043a e606          	ld	a,(6,x)
4238  043c c7000b        	ld	_tmp_nParseLeft,a
4239                     ; 2935             switch (pSocket->ParseCmd) {
4241  043f e608          	ld	a,(8,x)
4243                     ; 2938               case 'm': i = 10; break;
4244  0441 a061          	sub	a,#97
4245  0443 270b          	jreq	L5601
4246  0445 a00b          	sub	a,#11
4247  0447 270b          	jreq	L7601
4248  0449 4a            	dec	a
4249  044a 2708          	jreq	L7601
4250  044c 7b04          	ld	a,(OFST+0,sp)
4251  044e 2008          	jra	L1161
4252  0450               L5601:
4253                     ; 2936               case 'a': i = 19; break;
4255  0450 a613          	ld	a,#19
4258  0452 2002          	jp	LC018
4259  0454               L7601:
4260                     ; 2937               case 'l':
4260                     ; 2938               case 'm': i = 10; break;
4262  0454 a60a          	ld	a,#10
4263  0456               LC018:
4264  0456 6b04          	ld	(OFST+0,sp),a
4268  0458               L1161:
4269                     ; 2940             parse_POST_string(pSocket->ParseCmd, i);
4271  0458 160b          	ldw	y,(OFST+7,sp)
4272  045a 97            	ld	xl,a
4273  045b 90e608        	ld	a,(8,y)
4274  045e 95            	ld	xh,a
4275  045f cd0000        	call	_parse_POST_string
4277                     ; 2941             pBuffer = tmp_pBuffer;
4279  0462 ce000e        	ldw	x,_tmp_pBuffer
4280  0465 1f05          	ldw	(OFST+1,sp),x
4281                     ; 2942             nBytes = tmp_nBytes;
4283  0467 ce000c        	ldw	x,_tmp_nBytes
4284  046a 1f09          	ldw	(OFST+5,sp),x
4285                     ; 2943 	    pSocket->nParseLeft = tmp_nParseLeft;
4287  046c 1e0b          	ldw	x,(OFST+7,sp)
4288  046e c6000b        	ld	a,_tmp_nParseLeft
4289  0471 e706          	ld	(6,x),a
4290                     ; 2944             if (break_while == 1) {
4292  0473 c6000a        	ld	a,_break_while
4293  0476 4a            	dec	a
4294  0477 2696          	jrne	L7751
4295                     ; 2948 	      pSocket->ParseState = saved_parsestate;
4297  0479 c60043        	ld	a,_saved_parsestate
4298  047c e70a          	ld	(10,x),a
4299                     ; 2949 	      break;
4301  047e cc0735        	jra	L5641
4302  0481               L1061:
4303                     ; 2956           else if (pSocket->ParseCmd == 'b') {
4305  0481 a162          	cp	a,#98
4306  0483 2654          	jrne	L7161
4307                     ; 2964 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4309  0485 725f000a      	clr	_break_while
4310                     ; 2966             tmp_pBuffer = pBuffer;
4312  0489 1e05          	ldw	x,(OFST+1,sp)
4313  048b cf000e        	ldw	_tmp_pBuffer,x
4314                     ; 2967             tmp_nBytes = nBytes;
4316  048e 1e09          	ldw	x,(OFST+5,sp)
4317  0490 cf000c        	ldw	_tmp_nBytes,x
4318                     ; 2968 	    tmp_nParseLeft = pSocket->nParseLeft;
4320  0493 1e0b          	ldw	x,(OFST+7,sp)
4321  0495 e606          	ld	a,(6,x)
4322  0497 c7000b        	ld	_tmp_nParseLeft,a
4323                     ; 2969             parse_POST_address(pSocket->ParseCmd, pSocket->ParseNum);
4325  049a e609          	ld	a,(9,x)
4326  049c 160b          	ldw	y,(OFST+7,sp)
4327  049e 97            	ld	xl,a
4328  049f 90e608        	ld	a,(8,y)
4329  04a2 95            	ld	xh,a
4330  04a3 cd0000        	call	_parse_POST_address
4332                     ; 2970             pBuffer = tmp_pBuffer;
4334  04a6 ce000e        	ldw	x,_tmp_pBuffer
4335  04a9 1f05          	ldw	(OFST+1,sp),x
4336                     ; 2971             nBytes = tmp_nBytes;
4338  04ab ce000c        	ldw	x,_tmp_nBytes
4339  04ae 1f09          	ldw	(OFST+5,sp),x
4340                     ; 2972 	    pSocket->nParseLeft = tmp_nParseLeft;
4342  04b0 1e0b          	ldw	x,(OFST+7,sp)
4343  04b2 c6000b        	ld	a,_tmp_nParseLeft
4344  04b5 e706          	ld	(6,x),a
4345                     ; 2973             if (break_while == 1) {
4347  04b7 c6000a        	ld	a,_break_while
4348  04ba a101          	cp	a,#1
4349  04bc 260a          	jrne	L1261
4350                     ; 2977               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4352  04be a604          	ld	a,#4
4353  04c0 c70043        	ld	_saved_parsestate,a
4354  04c3 e70a          	ld	(10,x),a
4355                     ; 2978 	      break;
4357  04c5 cc0735        	jra	L5641
4358  04c8               L1261:
4359                     ; 2980             if (break_while == 2) {
4361  04c8 a102          	cp	a,#2
4362  04ca 2703cc06e6    	jrne	L7751
4363                     ; 2983               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4365  04cf a605          	ld	a,#5
4366  04d1 c70043        	ld	_saved_parsestate,a
4367  04d4 e70a          	ld	(10,x),a
4368                     ; 2984 	      break;
4370  04d6 cc0735        	jra	L5641
4371  04d9               L7161:
4372                     ; 2991           else if (pSocket->ParseCmd == 'c') {
4374  04d9 a163          	cp	a,#99
4375  04db 2651          	jrne	L7261
4376                     ; 3000 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4378  04dd 725f000a      	clr	_break_while
4379                     ; 3002             tmp_pBuffer = pBuffer;
4381  04e1 1e05          	ldw	x,(OFST+1,sp)
4382  04e3 cf000e        	ldw	_tmp_pBuffer,x
4383                     ; 3003             tmp_nBytes = nBytes;
4385  04e6 1e09          	ldw	x,(OFST+5,sp)
4386  04e8 cf000c        	ldw	_tmp_nBytes,x
4387                     ; 3004 	    tmp_nParseLeft = pSocket->nParseLeft;
4389  04eb 1e0b          	ldw	x,(OFST+7,sp)
4390  04ed e606          	ld	a,(6,x)
4391  04ef c7000b        	ld	_tmp_nParseLeft,a
4392                     ; 3005             parse_POST_port(pSocket->ParseCmd, pSocket->ParseNum);
4394  04f2 e609          	ld	a,(9,x)
4395  04f4 160b          	ldw	y,(OFST+7,sp)
4396  04f6 97            	ld	xl,a
4397  04f7 90e608        	ld	a,(8,y)
4398  04fa 95            	ld	xh,a
4399  04fb cd0000        	call	_parse_POST_port
4401                     ; 3006             pBuffer = tmp_pBuffer;
4403  04fe ce000e        	ldw	x,_tmp_pBuffer
4404  0501 1f05          	ldw	(OFST+1,sp),x
4405                     ; 3007             nBytes = tmp_nBytes;
4407  0503 ce000c        	ldw	x,_tmp_nBytes
4408  0506 1f09          	ldw	(OFST+5,sp),x
4409                     ; 3008 	    pSocket->nParseLeft = tmp_nParseLeft;
4411  0508 1e0b          	ldw	x,(OFST+7,sp)
4412  050a c6000b        	ld	a,_tmp_nParseLeft
4413  050d e706          	ld	(6,x),a
4414                     ; 3009             if (break_while == 1) {
4416  050f c6000a        	ld	a,_break_while
4417  0512 a101          	cp	a,#1
4418  0514 260a          	jrne	L1361
4419                     ; 3012               pSocket->ParseState = saved_parsestate = PARSE_VAL;
4421  0516 a604          	ld	a,#4
4422  0518 c70043        	ld	_saved_parsestate,a
4423  051b e70a          	ld	(10,x),a
4424                     ; 3013 	      break;
4426  051d cc0735        	jra	L5641
4427  0520               L1361:
4428                     ; 3015             if (break_while == 2) {
4430  0520 a102          	cp	a,#2
4431  0522 26a8          	jrne	L7751
4432                     ; 3018               pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4434  0524 a605          	ld	a,#5
4435  0526 c70043        	ld	_saved_parsestate,a
4436  0529 e70a          	ld	(10,x),a
4437                     ; 3019 	      break;
4439  052b cc0735        	jra	L5641
4440  052e               L7261:
4441                     ; 3026           else if (pSocket->ParseCmd == 'd') {
4443  052e a164          	cp	a,#100
4444  0530 2703cc05d0    	jrne	L7361
4445                     ; 3032 	    alpha[0] = '-';
4447  0535 352d0004      	mov	_alpha,#45
4448                     ; 3033 	    alpha[1] = '-';
4450  0539 352d0005      	mov	_alpha+1,#45
4451                     ; 3035 	    if (saved_postpartial_previous[0] == 'd') {
4453  053d c60012        	ld	a,_saved_postpartial_previous
4454  0540 a164          	cp	a,#100
4455  0542 261a          	jrne	L1461
4456                     ; 3039 	      saved_postpartial_previous[0] = '\0';
4458  0544 725f0012      	clr	_saved_postpartial_previous
4459                     ; 3045 	      if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
4461  0548 c60016        	ld	a,_saved_postpartial_previous+4
4462  054b 2705          	jreq	L3461
4465  054d 5500160004    	mov	_alpha,_saved_postpartial_previous+4
4466  0552               L3461:
4467                     ; 3046 	      if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
4469  0552 c60017        	ld	a,_saved_postpartial_previous+5
4470  0555 270a          	jreq	L7461
4473  0557 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
4474  055c 2003          	jra	L7461
4475  055e               L1461:
4476                     ; 3053               clear_saved_postpartial_data(); // Clear [4] and higher
4478  055e cd0000        	call	_clear_saved_postpartial_data
4480  0561               L7461:
4481                     ; 3056             if (alpha[0] == '-') {
4483  0561 c60004        	ld	a,_alpha
4484  0564 a12d          	cp	a,#45
4485  0566 261e          	jrne	L1561
4486                     ; 3057 	      alpha[0] = (uint8_t)(*pBuffer);
4488  0568 1e05          	ldw	x,(OFST+1,sp)
4489  056a f6            	ld	a,(x)
4490  056b c70004        	ld	_alpha,a
4491                     ; 3058               saved_postpartial[4] = *pBuffer;
4493  056e c7002e        	ld	_saved_postpartial+4,a
4494                     ; 3059               pSocket->nParseLeft--;
4496  0571 1e0b          	ldw	x,(OFST+7,sp)
4497  0573 6a06          	dec	(6,x)
4498                     ; 3060               saved_nparseleft = pSocket->nParseLeft;
4500  0575 e606          	ld	a,(6,x)
4501  0577 c70042        	ld	_saved_nparseleft,a
4502                     ; 3061               pBuffer++;
4504  057a 1e05          	ldw	x,(OFST+1,sp)
4505  057c 5c            	incw	x
4506  057d 1f05          	ldw	(OFST+1,sp),x
4507                     ; 3062 	      nBytes--;
4509  057f 1e09          	ldw	x,(OFST+5,sp)
4510  0581 5a            	decw	x
4511  0582 1f09          	ldw	(OFST+5,sp),x
4512                     ; 3063               if (nBytes == 0) break; // Hit end of fragment. Break out of
4514  0584 27a5          	jreq	L5641
4517  0586               L1561:
4518                     ; 3067             if (alpha[1] == '-') {
4520  0586 c60005        	ld	a,_alpha+1
4521  0589 a12d          	cp	a,#45
4522  058b 261c          	jrne	L5561
4523                     ; 3068 	      alpha[1] = (uint8_t)(*pBuffer);
4525  058d 1e05          	ldw	x,(OFST+1,sp)
4526  058f f6            	ld	a,(x)
4527  0590 c70005        	ld	_alpha+1,a
4528                     ; 3069               saved_postpartial[5] = *pBuffer;
4530  0593 c7002f        	ld	_saved_postpartial+5,a
4531                     ; 3070               pSocket->nParseLeft--;
4533  0596 1e0b          	ldw	x,(OFST+7,sp)
4534  0598 6a06          	dec	(6,x)
4535                     ; 3071               saved_nparseleft = pSocket->nParseLeft;
4537  059a e606          	ld	a,(6,x)
4538  059c c70042        	ld	_saved_nparseleft,a
4539                     ; 3072               pBuffer++;
4541  059f 1e05          	ldw	x,(OFST+1,sp)
4542  05a1 5c            	incw	x
4543  05a2 1f05          	ldw	(OFST+1,sp),x
4544                     ; 3073 	      nBytes--;
4546  05a4 1e09          	ldw	x,(OFST+5,sp)
4547  05a6 5a            	decw	x
4548  05a7 1f09          	ldw	(OFST+5,sp),x
4549  05a9               L5561:
4550                     ; 3079             clear_saved_postpartial_all();
4552  05a9 cd0000        	call	_clear_saved_postpartial_all
4554                     ; 3081             SetMAC(pSocket->ParseNum, alpha[0], alpha[1]);
4556  05ac 3b0005        	push	_alpha+1
4557  05af c60004        	ld	a,_alpha
4558  05b2 160c          	ldw	y,(OFST+8,sp)
4559  05b4 97            	ld	xl,a
4560  05b5 90e609        	ld	a,(9,y)
4561  05b8 95            	ld	xh,a
4562  05b9 cd0000        	call	_SetMAC
4564  05bc 84            	pop	a
4565                     ; 3083             if (nBytes == 0) {
4567  05bd 1e09          	ldw	x,(OFST+5,sp)
4568  05bf 2703cc06e6    	jrne	L7751
4569                     ; 3086 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4571  05c4 a605          	ld	a,#5
4572  05c6 c70043        	ld	_saved_parsestate,a
4573  05c9 1e0b          	ldw	x,(OFST+7,sp)
4574  05cb e70a          	ld	(10,x),a
4575                     ; 3087 	      break;
4577  05cd cc0735        	jra	L5641
4578  05d0               L7361:
4579                     ; 3094 	  else if (pSocket->ParseCmd == 'g') {
4581  05d0 a167          	cp	a,#103
4582  05d2 2703cc06d9    	jrne	L3661
4583                     ; 3105             for (i=0; i<6; i++) alpha[i] = '-';
4585  05d7 4f            	clr	a
4586  05d8 6b04          	ld	(OFST+0,sp),a
4588  05da               L5661:
4591  05da 5f            	clrw	x
4592  05db 97            	ld	xl,a
4593  05dc a62d          	ld	a,#45
4594  05de d70004        	ld	(_alpha,x),a
4597  05e1 0c04          	inc	(OFST+0,sp)
4601  05e3 7b04          	ld	a,(OFST+0,sp)
4602  05e5 a106          	cp	a,#6
4603  05e7 25f1          	jrult	L5661
4604                     ; 3107 	    break_while = 0; // Clear the break switch in case a TCP Fragment
4606  05e9 725f000a      	clr	_break_while
4607                     ; 3110 	    if (saved_postpartial_previous[0] == 'g') {
4609  05ed c60012        	ld	a,_saved_postpartial_previous
4610  05f0 a167          	cp	a,#103
4611  05f2 2621          	jrne	L3761
4612                     ; 3114 	      saved_postpartial_previous[0] = '\0';
4614  05f4 725f0012      	clr	_saved_postpartial_previous
4615                     ; 3120               for (i=0; i<6; i++) {
4617  05f8 4f            	clr	a
4618  05f9 6b04          	ld	(OFST+0,sp),a
4620  05fb               L5761:
4621                     ; 3121                 if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
4623  05fb 5f            	clrw	x
4624  05fc 97            	ld	xl,a
4625  05fd 724d0016      	tnz	(_saved_postpartial_previous+4,x)
4626  0601 2708          	jreq	L3071
4629  0603 5f            	clrw	x
4630  0604 97            	ld	xl,a
4631  0605 d60016        	ld	a,(_saved_postpartial_previous+4,x)
4632  0608 d70004        	ld	(_alpha,x),a
4633  060b               L3071:
4634                     ; 3120               for (i=0; i<6; i++) {
4636  060b 0c04          	inc	(OFST+0,sp)
4640  060d 7b04          	ld	a,(OFST+0,sp)
4641  060f a106          	cp	a,#6
4642  0611 25e8          	jrult	L5761
4644  0613 2003          	jra	L5071
4645  0615               L3761:
4646                     ; 3129               clear_saved_postpartial_data(); // Clear [4] and higher
4648  0615 cd0000        	call	_clear_saved_postpartial_data
4650  0618               L5071:
4651                     ; 3132             for (i=0; i<6; i++) {
4653  0618 4f            	clr	a
4654  0619 6b04          	ld	(OFST+0,sp),a
4656  061b               L7071:
4657                     ; 3138               if (alpha[i] == '-') {
4659  061b 5f            	clrw	x
4660  061c 97            	ld	xl,a
4661  061d d60004        	ld	a,(_alpha,x)
4662  0620 a12d          	cp	a,#45
4663  0622 2636          	jrne	L5171
4664                     ; 3139 	        alpha[i] = (uint8_t)(*pBuffer);
4666  0624 7b04          	ld	a,(OFST+0,sp)
4667  0626 5f            	clrw	x
4668  0627 1605          	ldw	y,(OFST+1,sp)
4669  0629 97            	ld	xl,a
4670  062a 90f6          	ld	a,(y)
4671  062c d70004        	ld	(_alpha,x),a
4672                     ; 3140                 saved_postpartial[i+4] = *pBuffer;
4674  062f 5f            	clrw	x
4675  0630 7b04          	ld	a,(OFST+0,sp)
4676  0632 97            	ld	xl,a
4677  0633 90f6          	ld	a,(y)
4678  0635 d7002e        	ld	(_saved_postpartial+4,x),a
4679                     ; 3141                 pSocket->nParseLeft--;
4681  0638 1e0b          	ldw	x,(OFST+7,sp)
4682  063a 6a06          	dec	(6,x)
4683                     ; 3142                 saved_nparseleft = pSocket->nParseLeft;
4685  063c e606          	ld	a,(6,x)
4686  063e c70042        	ld	_saved_nparseleft,a
4687                     ; 3143                 pBuffer++;
4689  0641 93            	ldw	x,y
4690  0642 5c            	incw	x
4691  0643 1f05          	ldw	(OFST+1,sp),x
4692                     ; 3144 	        nBytes--;
4694  0645 1e09          	ldw	x,(OFST+5,sp)
4695  0647 5a            	decw	x
4696  0648 1f09          	ldw	(OFST+5,sp),x
4697                     ; 3145                 if (i != 5 && nBytes == 0) {
4699  064a 7b04          	ld	a,(OFST+0,sp)
4700  064c a105          	cp	a,#5
4701  064e 270a          	jreq	L5171
4703  0650 1e09          	ldw	x,(OFST+5,sp)
4704  0652 2606          	jrne	L5171
4705                     ; 3146 		  break_while = 1; // Hit end of fragment. Break out of
4707  0654 3501000a      	mov	_break_while,#1
4708                     ; 3148 		  break; // Break out of for() loop
4710  0658 2008          	jra	L3171
4711  065a               L5171:
4712                     ; 3132             for (i=0; i<6; i++) {
4714  065a 0c04          	inc	(OFST+0,sp)
4718  065c 7b04          	ld	a,(OFST+0,sp)
4719  065e a106          	cp	a,#6
4720  0660 25b9          	jrult	L7071
4721  0662               L3171:
4722                     ; 3152 	    if (break_while == 1) {
4724  0662 c6000a        	ld	a,_break_while
4725  0665 4a            	dec	a
4726  0666 2603cc0735    	jreq	L5641
4727                     ; 3154 	      break;
4729                     ; 3160             clear_saved_postpartial_all();
4731  066b cd0000        	call	_clear_saved_postpartial_all
4733                     ; 3163 	    if (alpha[0] != '0' && alpha[0] != '1') alpha[0] = '0';
4735  066e c60004        	ld	a,_alpha
4736  0671 a130          	cp	a,#48
4737  0673 2708          	jreq	L3271
4739  0675 a131          	cp	a,#49
4740  0677 2704          	jreq	L3271
4743  0679 35300004      	mov	_alpha,#48
4744  067d               L3271:
4745                     ; 3164 	    if (alpha[1] != '0' && alpha[1] != '1') alpha[1] = '0';
4747  067d c60005        	ld	a,_alpha+1
4748  0680 a130          	cp	a,#48
4749  0682 2708          	jreq	L5271
4751  0684 a131          	cp	a,#49
4752  0686 2704          	jreq	L5271
4755  0688 35300005      	mov	_alpha+1,#48
4756  068c               L5271:
4757                     ; 3165 	    if (alpha[2] != '0' && alpha[2] != '1' && alpha[2] != '2') alpha[2] = '2';
4759  068c c60006        	ld	a,_alpha+2
4760  068f a130          	cp	a,#48
4761  0691 270c          	jreq	L7271
4763  0693 a131          	cp	a,#49
4764  0695 2708          	jreq	L7271
4766  0697 a132          	cp	a,#50
4767  0699 2704          	jreq	L7271
4770  069b 35320006      	mov	_alpha+2,#50
4771  069f               L7271:
4772                     ; 3166 	    if (alpha[3] != '0' && alpha[3] != '1') alpha[3] = '0';
4774  069f c60007        	ld	a,_alpha+3
4775  06a2 a130          	cp	a,#48
4776  06a4 2708          	jreq	L1371
4778  06a6 a131          	cp	a,#49
4779  06a8 2704          	jreq	L1371
4782  06aa 35300007      	mov	_alpha+3,#48
4783  06ae               L1371:
4784                     ; 3168 	    Pending_config_settings[0] = (uint8_t)alpha[0];
4786  06ae 5500040000    	mov	_Pending_config_settings,_alpha
4787                     ; 3169             Pending_config_settings[1] = (uint8_t)alpha[1];
4789  06b3 5500050001    	mov	_Pending_config_settings+1,_alpha+1
4790                     ; 3170             Pending_config_settings[2] = (uint8_t)alpha[2];
4792  06b8 5500060002    	mov	_Pending_config_settings+2,_alpha+2
4793                     ; 3171             Pending_config_settings[3] = (uint8_t)alpha[3];
4795  06bd 5500070003    	mov	_Pending_config_settings+3,_alpha+3
4796                     ; 3172             Pending_config_settings[4] = '0';
4798  06c2 35300004      	mov	_Pending_config_settings+4,#48
4799                     ; 3173             Pending_config_settings[5] = '0';
4801  06c6 35300005      	mov	_Pending_config_settings+5,#48
4802                     ; 3175             if (nBytes == 0) {
4804  06ca 1e09          	ldw	x,(OFST+5,sp)
4805  06cc 2618          	jrne	L7751
4806                     ; 3178 	      pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4808  06ce a605          	ld	a,#5
4809  06d0 c70043        	ld	_saved_parsestate,a
4810  06d3 1e0b          	ldw	x,(OFST+7,sp)
4811  06d5 e70a          	ld	(10,x),a
4812                     ; 3179 	      break;
4814  06d7 205c          	jra	L5641
4815  06d9               L3661:
4816                     ; 3186 	  else if (pSocket->ParseCmd == 'z') {
4818  06d9 a17a          	cp	a,#122
4819  06db 2609          	jrne	L7751
4820                     ; 3211 	    nBytes = 0;
4822  06dd 5f            	clrw	x
4823  06de 1f09          	ldw	(OFST+5,sp),x
4824                     ; 3212 	    pSocket->nParseLeft = 0;
4826  06e0 1e0b          	ldw	x,(OFST+7,sp)
4827  06e2 6f06          	clr	(6,x)
4828                     ; 3213             break; // Break out of the while loop. We're done with POST.
4830  06e4 204f          	jra	L5641
4831  06e6               L7751:
4832                     ; 3224           pSocket->ParseState = saved_parsestate = PARSE_DELIM;
4834  06e6 a605          	ld	a,#5
4835  06e8 c70043        	ld	_saved_parsestate,a
4836  06eb 1e0b          	ldw	x,(OFST+7,sp)
4837  06ed e70a          	ld	(10,x),a
4838                     ; 3226           if (pSocket->nParseLeft < 30) {
4840  06ef e606          	ld	a,(6,x)
4841  06f1 a11e          	cp	a,#30
4842  06f3 2503cc02b4    	jruge	L3641
4843                     ; 3241 	    if (pSocket->nParseLeftAddl > 0) {
4845  06f8 6d07          	tnz	(7,x)
4846  06fa 27f9          	jreq	L3641
4847                     ; 3242 	      pSocket->nParseLeft += pSocket->nParseLeftAddl;
4849  06fc eb07          	add	a,(7,x)
4850  06fe e706          	ld	(6,x),a
4851                     ; 3243 	      pSocket->nParseLeftAddl = 0;
4853  0700 6f07          	clr	(7,x)
4854                     ; 3244 	      saved_nparseleft = pSocket->nParseLeft;
4856  0702 c70042        	ld	_saved_nparseleft,a
4857  0705 cc02b4        	jra	L3641
4858  0708               L3651:
4859                     ; 3249         else if (pSocket->ParseState == PARSE_DELIM) {
4861  0708 a105          	cp	a,#5
4862  070a 26f9          	jrne	L3641
4863                     ; 3250           if (pSocket->nParseLeft > 0) {
4865  070c e606          	ld	a,(6,x)
4866  070e 2720          	jreq	L1571
4867                     ; 3253             pSocket->ParseState = saved_parsestate = PARSE_CMD;
4869  0710 725f0043      	clr	_saved_parsestate
4870  0714 6f0a          	clr	(10,x)
4871                     ; 3254             pSocket->nParseLeft--;
4873  0716 6a06          	dec	(6,x)
4874                     ; 3255             saved_nparseleft = pSocket->nParseLeft;
4876  0718 e606          	ld	a,(6,x)
4877  071a c70042        	ld	_saved_nparseleft,a
4878                     ; 3256             pBuffer++;
4880  071d 1e05          	ldw	x,(OFST+1,sp)
4881  071f 5c            	incw	x
4882  0720 1f05          	ldw	(OFST+1,sp),x
4883                     ; 3257 	    nBytes--;
4885  0722 1e09          	ldw	x,(OFST+5,sp)
4886  0724 5a            	decw	x
4887  0725 1f09          	ldw	(OFST+5,sp),x
4888                     ; 3259 	    clear_saved_postpartial_all();
4890  0727 cd0000        	call	_clear_saved_postpartial_all
4892                     ; 3263             if (nBytes == 0) {
4894  072a 1e09          	ldw	x,(OFST+5,sp)
4895  072c 26d7          	jrne	L3641
4896                     ; 3264 	      break; // Hit end of fragment but still have more to parse in
4898  072e 2005          	jra	L5641
4899  0730               L1571:
4900                     ; 3274             pSocket->nParseLeft = 0; // End the parsing
4902  0730 e706          	ld	(6,x),a
4903                     ; 3275 	    nBytes = 0;
4905  0732 5f            	clrw	x
4906  0733 1f09          	ldw	(OFST+5,sp),x
4907                     ; 3276 	    break; // Exit parsing
4908  0735               L5641:
4909                     ; 3303       if (pSocket->nParseLeft == 0) {
4911  0735 1e0b          	ldw	x,(OFST+7,sp)
4912  0737 e606          	ld	a,(6,x)
4913  0739 264e          	jrne	L7571
4914                     ; 3306 	saved_nstate = STATE_NULL;
4916  073b 357f0044      	mov	_saved_nstate,#127
4917                     ; 3307 	saved_parsestate = PARSE_CMD;
4919  073f c70043        	ld	_saved_parsestate,a
4920                     ; 3308         saved_nparseleft = 0;
4922  0742 c70042        	ld	_saved_nparseleft,a
4923                     ; 3309         saved_newlines = 0;
4925  0745 c70011        	ld	_saved_newlines,a
4926                     ; 3310 	for (i=0; i<24; i++) saved_postpartial_previous[i] = saved_postpartial[i] = '\0';
4928  0748 6b04          	ld	(OFST+0,sp),a
4930  074a               L1671:
4933  074a 5f            	clrw	x
4934  074b 97            	ld	xl,a
4935  074c 724f002a      	clr	(_saved_postpartial,x)
4936  0750 5f            	clrw	x
4937  0751 97            	ld	xl,a
4938  0752 724f0012      	clr	(_saved_postpartial_previous,x)
4941  0756 0c04          	inc	(OFST+0,sp)
4945  0758 7b04          	ld	a,(OFST+0,sp)
4946  075a a118          	cp	a,#24
4947  075c 25ec          	jrult	L1671
4948                     ; 3316 	parse_complete = 1;
4950  075e 35010000      	mov	_parse_complete,#1
4951                     ; 3317 	pSocket->nState = STATE_SENDHEADER;
4953  0762 1e0b          	ldw	x,(OFST+7,sp)
4954  0764 a60b          	ld	a,#11
4955  0766 f7            	ld	(x),a
4956                     ; 3329         if (current_webpage == WEBPAGE_IOCONTROL) {
4958  0767 c60003        	ld	a,_current_webpage
4959  076a 260c          	jrne	L7671
4960                     ; 3330           pSocket->pData = g_HtmlPageIOControl;
4962  076c 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
4963  0770 ef01          	ldw	(1,x),y
4964                     ; 3331           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
4966  0772 90ae0c06      	ldw	y,#3078
4967  0776 ef03          	ldw	(3,x),y
4968  0778               L7671:
4969                     ; 3333         if (current_webpage == WEBPAGE_CONFIGURATION) {
4971  0778 4a            	dec	a
4972  0779 2612          	jrne	L1641
4973                     ; 3334           pSocket->pData = g_HtmlPageConfiguration;
4975  077b 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
4976  077f ef01          	ldw	(1,x),y
4977                     ; 3335           pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
4979  0781 90ae0c5c      	ldw	y,#3164
4980  0785 ef03          	ldw	(3,x),y
4981  0787 2004          	jra	L1641
4982  0789               L7571:
4983                     ; 3355 	uip_len = 0;
4985  0789 5f            	clrw	x
4986  078a cf0000        	ldw	_uip_len,x
4987  078d               L1641:
4988                     ; 3359     if (pSocket->nState == STATE_PARSEGET) {
4990  078d 1e0b          	ldw	x,(OFST+7,sp)
4991  078f f6            	ld	a,(x)
4992  0790 a10d          	cp	a,#13
4993  0792 2703cc09c4    	jrne	L5771
4995  0797 cc09bd        	jra	L1002
4996  079a               L7771:
4997                     ; 3388         if (pSocket->ParseState == PARSE_SLASH1) {
4999  079a 1e0b          	ldw	x,(OFST+7,sp)
5000  079c e60a          	ld	a,(10,x)
5001  079e a106          	cp	a,#6
5002  07a0 263c          	jrne	L5002
5003                     ; 3391           pSocket->ParseCmd = *pBuffer;
5005  07a2 1e05          	ldw	x,(OFST+1,sp)
5006  07a4 f6            	ld	a,(x)
5007  07a5 1e0b          	ldw	x,(OFST+7,sp)
5008  07a7 e708          	ld	(8,x),a
5009                     ; 3392           pSocket->nParseLeft--;
5011  07a9 6a06          	dec	(6,x)
5012                     ; 3393           pBuffer++;
5014  07ab 1e05          	ldw	x,(OFST+1,sp)
5015  07ad 5c            	incw	x
5016  07ae 1f05          	ldw	(OFST+1,sp),x
5017                     ; 3394 	  nBytes--;
5019  07b0 1e09          	ldw	x,(OFST+5,sp)
5020  07b2 5a            	decw	x
5021  07b3 1f09          	ldw	(OFST+5,sp),x
5022                     ; 3395 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5024  07b5 1e0b          	ldw	x,(OFST+7,sp)
5025  07b7 e608          	ld	a,(8,x)
5026  07b9 a12f          	cp	a,#47
5027  07bb 2605          	jrne	L7002
5028                     ; 3396 	    pSocket->ParseState = PARSE_NUM10;
5030  07bd a601          	ld	a,#1
5032  07bf cc0858        	jp	LC022
5033  07c2               L7002:
5034                     ; 3400 	    current_webpage = WEBPAGE_IOCONTROL;
5036  07c2 725f0003      	clr	_current_webpage
5037                     ; 3401             pSocket->pData = g_HtmlPageIOControl;
5039  07c6 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5040  07ca ef01          	ldw	(1,x),y
5041                     ; 3402             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5043  07cc 90ae0c06      	ldw	y,#3078
5044  07d0 ef03          	ldw	(3,x),y
5045                     ; 3403             pSocket->nParseLeft = 0; // This will cause the while() to exit
5047  07d2 6f06          	clr	(6,x)
5048                     ; 3405             pSocket->nState = STATE_CONNECTED;
5050  07d4 7f            	clr	(x)
5051                     ; 3406             pSocket->nPrevBytes = 0xFFFF;
5053  07d5 90aeffff      	ldw	y,#65535
5054  07d9 ef0b          	ldw	(11,x),y
5055  07db cc09ac        	jra	L3102
5056  07de               L5002:
5057                     ; 3410         else if (pSocket->ParseState == PARSE_NUM10) {
5059  07de a101          	cp	a,#1
5060  07e0 2640          	jrne	L5102
5061                     ; 3415 	  if (*pBuffer == ' ') {
5063  07e2 1e05          	ldw	x,(OFST+1,sp)
5064  07e4 f6            	ld	a,(x)
5065  07e5 a120          	cp	a,#32
5066  07e7 261e          	jrne	L7102
5067                     ; 3416 	    current_webpage = WEBPAGE_IOCONTROL;
5069  07e9 725f0003      	clr	_current_webpage
5070                     ; 3417             pSocket->pData = g_HtmlPageIOControl;
5072  07ed 1e0b          	ldw	x,(OFST+7,sp)
5073  07ef 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5074  07f3 ef01          	ldw	(1,x),y
5075                     ; 3418             pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5077  07f5 90ae0c06      	ldw	y,#3078
5078  07f9 ef03          	ldw	(3,x),y
5079                     ; 3419             pSocket->nParseLeft = 0;
5081  07fb 6f06          	clr	(6,x)
5082                     ; 3421             pSocket->nState = STATE_CONNECTED;
5084  07fd 7f            	clr	(x)
5085                     ; 3422             pSocket->nPrevBytes = 0xFFFF;
5087  07fe 90aeffff      	ldw	y,#65535
5088  0802 ef0b          	ldw	(11,x),y
5090  0804 cc09ac        	jra	L3102
5091  0807               L7102:
5092                     ; 3426 	  else if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
5094  0807 a130          	cp	a,#48
5095  0809 2547          	jrult	L3302
5097  080b a13a          	cp	a,#58
5098  080d 2443          	jruge	L3302
5099                     ; 3428             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5101  080f 97            	ld	xl,a
5102  0810 a60a          	ld	a,#10
5103  0812 42            	mul	x,a
5104  0813 9f            	ld	a,xl
5105  0814 1e0b          	ldw	x,(OFST+7,sp)
5106  0816 a0e0          	sub	a,#224
5107  0818 e709          	ld	(9,x),a
5108                     ; 3429 	    pSocket->ParseState = PARSE_NUM1;
5110  081a a602          	ld	a,#2
5111  081c e70a          	ld	(10,x),a
5112                     ; 3430             pSocket->nParseLeft--;
5114  081e 6a06          	dec	(6,x)
5115                     ; 3431             pBuffer++;
5116                     ; 3432 	    nBytes--;
5118  0820 2023          	jp	LC024
5119                     ; 3437             pSocket->nParseLeft = 0;
5120                     ; 3438             pSocket->ParseState = PARSE_FAIL;
5121  0822               L5102:
5122                     ; 3443         else if (pSocket->ParseState == PARSE_NUM1) {
5124  0822 a102          	cp	a,#2
5125  0824 2637          	jrne	L1302
5126                     ; 3444 	  if (*pBuffer >= '0' && *pBuffer <= '9') { // Check for user entry error
5128  0826 1e05          	ldw	x,(OFST+1,sp)
5129  0828 f6            	ld	a,(x)
5130  0829 a130          	cp	a,#48
5131  082b 2525          	jrult	L3302
5133  082d a13a          	cp	a,#58
5134  082f 2421          	jruge	L3302
5135                     ; 3446             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5137  0831 1605          	ldw	y,(OFST+1,sp)
5138  0833 1e0b          	ldw	x,(OFST+7,sp)
5139  0835 90f6          	ld	a,(y)
5140  0837 a030          	sub	a,#48
5141  0839 eb09          	add	a,(9,x)
5142  083b e709          	ld	(9,x),a
5143                     ; 3447             pSocket->ParseState = PARSE_VAL;
5145  083d a604          	ld	a,#4
5146  083f e70a          	ld	(10,x),a
5147                     ; 3448             pSocket->nParseLeft = 1; // Set to 1 so PARSE_VAL will be called
5149  0841 a601          	ld	a,#1
5150  0843 e706          	ld	(6,x),a
5151                     ; 3449             pBuffer++;
5153                     ; 3450 	    nBytes--;
5155  0845               LC024:
5157  0845 1e05          	ldw	x,(OFST+1,sp)
5158  0847 5c            	incw	x
5159  0848 1f05          	ldw	(OFST+1,sp),x
5161  084a 1e09          	ldw	x,(OFST+5,sp)
5162  084c 5a            	decw	x
5163  084d 1f09          	ldw	(OFST+5,sp),x
5165  084f cc09ac        	jra	L3102
5166  0852               L3302:
5167                     ; 3455             pSocket->nParseLeft = 0;
5169                     ; 3456             pSocket->ParseState = PARSE_FAIL;
5172  0852 1e0b          	ldw	x,(OFST+7,sp)
5174  0854 a607          	ld	a,#7
5175  0856 6f06          	clr	(6,x)
5176  0858               LC022:
5177  0858 e70a          	ld	(10,x),a
5178  085a cc09ac        	jra	L3102
5179  085d               L1302:
5180                     ; 3460         else if (pSocket->ParseState == PARSE_VAL) {
5182  085d a104          	cp	a,#4
5183  085f 26f9          	jrne	L3102
5184                     ; 3526           switch(pSocket->ParseNum)
5186  0861 e609          	ld	a,(9,x)
5188                     ; 3701 	      break;
5189  0863 a110          	cp	a,#16
5190  0865 2407          	jruge	L422
5191  0867 5f            	clrw	x
5192  0868 97            	ld	xl,a
5193  0869 58            	sllw	x
5194  086a de1d05        	ldw	x,(L622,x)
5195  086d fc            	jp	(x)
5196  086e               L422:
5197  086e a037          	sub	a,#55
5198  0870 2603cc091c    	jreq	L1311
5199  0875 4a            	dec	a
5200  0876 2603cc0923    	jreq	L3311
5201  087b a004          	sub	a,#4
5202  087d 2603cc0929    	jreq	L5311
5203  0882 4a            	dec	a
5204  0883 2603cc0938    	jreq	L7311
5205  0888 a004          	sub	a,#4
5206  088a 2603cc0948    	jreq	L1411
5207  088f 4a            	dec	a
5208  0890 2603cc0953    	jreq	L3411
5209  0895 4a            	dec	a
5210  0896 2603cc0966    	jreq	L5411
5211  089b a018          	sub	a,#24
5212  089d 2603cc097b    	jreq	L7411
5213  08a2 a008          	sub	a,#8
5214  08a4 2603cc0981    	jreq	L1511
5215  08a9 cc0991        	jra	L3511
5216  08ac               L1701:
5217                     ; 3574 	    case 0:  IO_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
5219  08ac 72110000      	bres	_IO_8to1,#0
5222  08b0 cc09a8        	jra	L5402
5223  08b3               L3701:
5224                     ; 3575 	    case 1:  IO_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
5226  08b3 72100000      	bset	_IO_8to1,#0
5229  08b7 cc09a8        	jra	L5402
5230  08ba               L5701:
5231                     ; 3576 	    case 2:  IO_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
5233  08ba 72130000      	bres	_IO_8to1,#1
5236  08be cc09a8        	jra	L5402
5237  08c1               L7701:
5238                     ; 3577 	    case 3:  IO_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
5240  08c1 72120000      	bset	_IO_8to1,#1
5243  08c5 cc09a8        	jra	L5402
5244  08c8               L1011:
5245                     ; 3578 	    case 4:  IO_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
5247  08c8 72150000      	bres	_IO_8to1,#2
5250  08cc cc09a8        	jra	L5402
5251  08cf               L3011:
5252                     ; 3579 	    case 5:  IO_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
5254  08cf 72140000      	bset	_IO_8to1,#2
5257  08d3 cc09a8        	jra	L5402
5258  08d6               L5011:
5259                     ; 3580 	    case 6:  IO_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
5261  08d6 72170000      	bres	_IO_8to1,#3
5264  08da cc09a8        	jra	L5402
5265  08dd               L7011:
5266                     ; 3581 	    case 7:  IO_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
5268  08dd 72160000      	bset	_IO_8to1,#3
5271  08e1 cc09a8        	jra	L5402
5272  08e4               L1111:
5273                     ; 3582 	    case 8:  IO_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
5275  08e4 72190000      	bres	_IO_8to1,#4
5278  08e8 cc09a8        	jra	L5402
5279  08eb               L3111:
5280                     ; 3583 	    case 9:  IO_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
5282  08eb 72180000      	bset	_IO_8to1,#4
5285  08ef cc09a8        	jra	L5402
5286  08f2               L5111:
5287                     ; 3584 	    case 10: IO_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
5289  08f2 721b0000      	bres	_IO_8to1,#5
5292  08f6 cc09a8        	jra	L5402
5293  08f9               L7111:
5294                     ; 3585 	    case 11: IO_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
5296  08f9 721a0000      	bset	_IO_8to1,#5
5299  08fd cc09a8        	jra	L5402
5300  0900               L1211:
5301                     ; 3586 	    case 12: IO_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
5303  0900 721d0000      	bres	_IO_8to1,#6
5306  0904 cc09a8        	jra	L5402
5307  0907               L3211:
5308                     ; 3587 	    case 13: IO_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
5310  0907 721c0000      	bset	_IO_8to1,#6
5313  090b cc09a8        	jra	L5402
5314  090e               L5211:
5315                     ; 3588 	    case 14: IO_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
5317  090e 721f0000      	bres	_IO_8to1,#7
5320  0912 cc09a8        	jra	L5402
5321  0915               L7211:
5322                     ; 3589 	    case 15: IO_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
5324  0915 721e0000      	bset	_IO_8to1,#7
5327  0919 cc09a8        	jra	L5402
5328  091c               L1311:
5329                     ; 3591 	    case 55:
5329                     ; 3592   	      IO_8to1 = (uint8_t)0xff; // Relays 1-8 ON
5331  091c 35ff0000      	mov	_IO_8to1,#255
5332                     ; 3593 	      break;
5334  0920 cc09a8        	jra	L5402
5335  0923               L3311:
5336                     ; 3595 	    case 56:
5336                     ; 3596               IO_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
5338  0923 c70000        	ld	_IO_8to1,a
5339                     ; 3597 	      break;
5341  0926 cc09a8        	jra	L5402
5342  0929               L5311:
5343                     ; 3604 	    case 60: // Show IO Control page
5343                     ; 3605 	      current_webpage = WEBPAGE_IOCONTROL;
5345  0929 c70003        	ld	_current_webpage,a
5346                     ; 3606               pSocket->pData = g_HtmlPageIOControl;
5348  092c 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5349  0930 ef01          	ldw	(1,x),y
5350                     ; 3607               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5352  0932 90ae0c06      	ldw	y,#3078
5353                     ; 3608               pSocket->nState = STATE_CONNECTED;
5354                     ; 3609               pSocket->nPrevBytes = 0xFFFF;
5355                     ; 3610 	      break;
5357  0936 2029          	jp	LC021
5358  0938               L7311:
5359                     ; 3612 	    case 61: // Show Configuration page
5359                     ; 3613 	      current_webpage = WEBPAGE_CONFIGURATION;
5361  0938 35010003      	mov	_current_webpage,#1
5362                     ; 3614               pSocket->pData = g_HtmlPageConfiguration;
5364  093c 90ae0c0f      	ldw	y,#L51_g_HtmlPageConfiguration
5365  0940 ef01          	ldw	(1,x),y
5366                     ; 3615               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageConfiguration) - 1);
5368  0942 90ae0c5c      	ldw	y,#3164
5369                     ; 3616               pSocket->nState = STATE_CONNECTED;
5370                     ; 3617               pSocket->nPrevBytes = 0xFFFF;
5371                     ; 3618 	      break;
5373  0946 2019          	jp	LC021
5374  0948               L1411:
5375                     ; 3638 	    case 65: // Flash LED for diagnostics
5375                     ; 3639 	      // XXXXXXXXXXXXXXXXXXXXXX
5375                     ; 3640 	      // XXXXXXXXXXXXXXXXXXXXXX
5375                     ; 3641 	      // XXXXXXXXXXXXXXXXXXXXXX
5375                     ; 3642 	      debugflash();
5377  0948 cd0000        	call	_debugflash
5379                     ; 3643 	      debugflash();
5381  094b cd0000        	call	_debugflash
5383                     ; 3644 	      debugflash();
5385  094e cd0000        	call	_debugflash
5387                     ; 3648 	      break;
5389  0951 2055          	jra	L5402
5390  0953               L3411:
5391                     ; 3651             case 66: // Show statistics page
5391                     ; 3652 	      current_webpage = WEBPAGE_STATS;
5393  0953 35050003      	mov	_current_webpage,#5
5394                     ; 3653               pSocket->pData = g_HtmlPageStats;
5396  0957 90ae186c      	ldw	y,#L71_g_HtmlPageStats
5397  095b ef01          	ldw	(1,x),y
5398                     ; 3654               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
5400  095d 90ae0175      	ldw	y,#373
5401                     ; 3655               pSocket->nState = STATE_CONNECTED;
5403  0961               LC021:
5404  0961 ef03          	ldw	(3,x),y
5408  0963 f7            	ld	(x),a
5409                     ; 3656               pSocket->nPrevBytes = 0xFFFF;
5410                     ; 3657 	      break;
5412  0964 203c          	jp	LC019
5413  0966               L5411:
5414                     ; 3659             case 67: // Clear statistics
5414                     ; 3660 	      uip_init_stats();
5416  0966 cd0000        	call	_uip_init_stats
5418                     ; 3675 	      current_webpage = WEBPAGE_STATS;
5420  0969 35050003      	mov	_current_webpage,#5
5421                     ; 3676               pSocket->pData = g_HtmlPageStats;
5423  096d 1e0b          	ldw	x,(OFST+7,sp)
5424  096f 90ae186c      	ldw	y,#L71_g_HtmlPageStats
5425  0973 ef01          	ldw	(1,x),y
5426                     ; 3677               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageStats) - 1);
5428  0975 90ae0175      	ldw	y,#373
5429                     ; 3678               pSocket->nState = STATE_CONNECTED;
5430                     ; 3679               pSocket->nPrevBytes = 0xFFFF;
5431                     ; 3680 	      break;
5433  0979 2024          	jp	LC020
5434  097b               L7411:
5435                     ; 3683 	    case 91: // Reboot
5435                     ; 3684 	      user_reboot_request = 1;
5437  097b 35010000      	mov	_user_reboot_request,#1
5438                     ; 3685 	      break;
5440  097f 2027          	jra	L5402
5441  0981               L1511:
5442                     ; 3687             case 99: // Show simplified IO state page
5442                     ; 3688 	      current_webpage = WEBPAGE_RSTATE;
5444  0981 35060003      	mov	_current_webpage,#6
5445                     ; 3689               pSocket->pData = g_HtmlPageRstate;
5447  0985 90ae19e2      	ldw	y,#L12_g_HtmlPageRstate
5448  0989 ef01          	ldw	(1,x),y
5449                     ; 3690               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageRstate) - 1);
5451  098b 90ae0087      	ldw	y,#135
5452                     ; 3691               pSocket->nState = STATE_CONNECTED;
5453                     ; 3692               pSocket->nPrevBytes = 0xFFFF;
5454                     ; 3693 	      break;
5456  098f 20d0          	jp	LC021
5457  0991               L3511:
5458                     ; 3695 	    default: // Show IO Control page
5458                     ; 3696 	      current_webpage = WEBPAGE_IOCONTROL;
5460  0991 725f0003      	clr	_current_webpage
5461                     ; 3697               pSocket->pData = g_HtmlPageIOControl;
5463  0995 90ae0008      	ldw	y,#L31_g_HtmlPageIOControl
5464  0999 ef01          	ldw	(1,x),y
5465                     ; 3698               pSocket->nDataLeft = (uint16_t)(sizeof(g_HtmlPageIOControl) - 1);
5467  099b 90ae0c06      	ldw	y,#3078
5468                     ; 3699               pSocket->nState = STATE_CONNECTED;
5470  099f               LC020:
5471  099f ef03          	ldw	(3,x),y
5473  09a1 7f            	clr	(x)
5474                     ; 3700               pSocket->nPrevBytes = 0xFFFF;
5476  09a2               LC019:
5482  09a2 90aeffff      	ldw	y,#65535
5483  09a6 ef0b          	ldw	(11,x),y
5484                     ; 3701 	      break;
5486  09a8               L5402:
5487                     ; 3703           pSocket->nParseLeft = 0;
5489  09a8 1e0b          	ldw	x,(OFST+7,sp)
5490  09aa 6f06          	clr	(6,x)
5491  09ac               L3102:
5492                     ; 3706         if (pSocket->ParseState == PARSE_FAIL) {
5494  09ac 1e0b          	ldw	x,(OFST+7,sp)
5495  09ae e60a          	ld	a,(10,x)
5496  09b0 a107          	cp	a,#7
5497                     ; 3711           pSocket->nState = STATE_SENDHEADER;
5498                     ; 3712 	  break;
5500  09b2 2704          	jreq	LC025
5501                     ; 3715         if (pSocket->nParseLeft == 0) {
5503  09b4 e606          	ld	a,(6,x)
5504  09b6 2605          	jrne	L1002
5505                     ; 3718           pSocket->nState = STATE_SENDHEADER;
5507  09b8               LC025:
5509  09b8 a60b          	ld	a,#11
5510  09ba f7            	ld	(x),a
5511                     ; 3719           break;
5513  09bb 2007          	jra	L5771
5514  09bd               L1002:
5515                     ; 3387       while (nBytes != 0) {
5517  09bd 1e09          	ldw	x,(OFST+5,sp)
5518  09bf 2703cc079a    	jrne	L7771
5519  09c4               L5771:
5520                     ; 3724     if (pSocket->nState == STATE_SENDHEADER) {
5522  09c4 1e0b          	ldw	x,(OFST+7,sp)
5523  09c6 f6            	ld	a,(x)
5524  09c7 a10b          	cp	a,#11
5525  09c9 261c          	jrne	L5511
5526                     ; 3730       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5528  09cb cd0000        	call	_adjust_template_size
5530  09ce 89            	pushw	x
5531  09cf ce0000        	ldw	x,_uip_appdata
5532  09d2 cd0000        	call	L5_CopyHttpHeader
5534  09d5 5b02          	addw	sp,#2
5535  09d7 89            	pushw	x
5536  09d8 ce0000        	ldw	x,_uip_appdata
5537  09db cd0000        	call	_uip_send
5539  09de 85            	popw	x
5540                     ; 3731       pSocket->nState = STATE_SENDDATA;
5542  09df 1e0b          	ldw	x,(OFST+7,sp)
5543  09e1 a60c          	ld	a,#12
5544  09e3 f7            	ld	(x),a
5545                     ; 3732       return;
5547  09e4 cc012f        	jra	L452
5548  09e7               L5511:
5549                     ; 3735     senddata:
5549                     ; 3736     if (pSocket->nState == STATE_SENDDATA) {
5551  09e7 1e0b          	ldw	x,(OFST+7,sp)
5552  09e9 f6            	ld	a,(x)
5553  09ea a10c          	cp	a,#12
5554  09ec 26f6          	jrne	L452
5555                     ; 3743       if (pSocket->nDataLeft == 0) {
5557  09ee e604          	ld	a,(4,x)
5558  09f0 ea03          	or	a,(3,x)
5559  09f2 2605          	jrne	L7502
5560                     ; 3745         nBufSize = 0;
5562  09f4 5f            	clrw	x
5563  09f5 1f02          	ldw	(OFST-2,sp),x
5566  09f7 202f          	jra	L1602
5567  09f9               L7502:
5568                     ; 3748         pSocket->nPrevBytes = pSocket->nDataLeft;
5570  09f9 9093          	ldw	y,x
5571  09fb 90ee03        	ldw	y,(3,y)
5572  09fe ef0b          	ldw	(11,x),y
5573                     ; 3749         nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5575  0a00 ce0000        	ldw	x,_uip_conn
5576  0a03 ee12          	ldw	x,(18,x)
5577  0a05 89            	pushw	x
5578  0a06 1e0d          	ldw	x,(OFST+9,sp)
5579  0a08 1c0003        	addw	x,#3
5580  0a0b 89            	pushw	x
5581  0a0c 1e0f          	ldw	x,(OFST+11,sp)
5582  0a0e 5c            	incw	x
5583  0a0f 89            	pushw	x
5584  0a10 ce0000        	ldw	x,_uip_appdata
5585  0a13 cd0000        	call	L7_CopyHttpData
5587  0a16 5b06          	addw	sp,#6
5588  0a18 1f02          	ldw	(OFST-2,sp),x
5590                     ; 3750         pSocket->nPrevBytes -= pSocket->nDataLeft;
5592  0a1a 1e0b          	ldw	x,(OFST+7,sp)
5593  0a1c e60c          	ld	a,(12,x)
5594  0a1e e004          	sub	a,(4,x)
5595  0a20 e70c          	ld	(12,x),a
5596  0a22 e60b          	ld	a,(11,x)
5597  0a24 e203          	sbc	a,(3,x)
5598  0a26 e70b          	ld	(11,x),a
5599  0a28               L1602:
5600                     ; 3753       if (nBufSize == 0) {
5602  0a28 1e02          	ldw	x,(OFST-2,sp)
5603  0a2a 2621          	jrne	LC016
5604                     ; 3755         uip_close();
5606  0a2c               LC017:
5608  0a2c 35100000      	mov	_uip_flags,#16
5610  0a30 cc012f        	jra	L452
5611                     ; 3759         uip_send(uip_appdata, nBufSize);
5613                     ; 3761       return;
5615  0a33               L7621:
5616                     ; 3765   else if (uip_rexmit()) {
5618  0a33 7205000075    	btjf	_uip_flags,#2,L5621
5619                     ; 3766     if (pSocket->nPrevBytes == 0xFFFF) {
5621  0a38 160b          	ldw	y,(OFST+7,sp)
5622  0a3a 90ee0b        	ldw	y,(11,y)
5623  0a3d 905c          	incw	y
5624  0a3f 2617          	jrne	L3702
5625                     ; 3768       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, adjust_template_size()));
5627  0a41 cd0000        	call	_adjust_template_size
5629  0a44 89            	pushw	x
5630  0a45 ce0000        	ldw	x,_uip_appdata
5631  0a48 cd0000        	call	L5_CopyHttpHeader
5633  0a4b 5b02          	addw	sp,#2
5635  0a4d               LC016:
5637  0a4d 89            	pushw	x
5638  0a4e ce0000        	ldw	x,_uip_appdata
5639  0a51 cd0000        	call	_uip_send
5640  0a54 85            	popw	x
5642  0a55 cc012f        	jra	L452
5643  0a58               L3702:
5644                     ; 3771       pSocket->pData -= pSocket->nPrevBytes;
5646  0a58 1e0b          	ldw	x,(OFST+7,sp)
5647  0a5a e602          	ld	a,(2,x)
5648  0a5c e00c          	sub	a,(12,x)
5649  0a5e e702          	ld	(2,x),a
5650  0a60 e601          	ld	a,(1,x)
5651  0a62 e20b          	sbc	a,(11,x)
5652  0a64 e701          	ld	(1,x),a
5653                     ; 3772       pSocket->nDataLeft += pSocket->nPrevBytes;
5655  0a66 e604          	ld	a,(4,x)
5656  0a68 eb0c          	add	a,(12,x)
5657  0a6a e704          	ld	(4,x),a
5658  0a6c e603          	ld	a,(3,x)
5659  0a6e e90b          	adc	a,(11,x)
5660                     ; 3773       pSocket->nPrevBytes = pSocket->nDataLeft;
5662  0a70 9093          	ldw	y,x
5663  0a72 e703          	ld	(3,x),a
5664  0a74 90ee03        	ldw	y,(3,y)
5665  0a77 ef0b          	ldw	(11,x),y
5666                     ; 3774       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
5668  0a79 ce0000        	ldw	x,_uip_conn
5669  0a7c ee12          	ldw	x,(18,x)
5670  0a7e 89            	pushw	x
5671  0a7f 1e0d          	ldw	x,(OFST+9,sp)
5672  0a81 1c0003        	addw	x,#3
5673  0a84 89            	pushw	x
5674  0a85 1e0f          	ldw	x,(OFST+11,sp)
5675  0a87 5c            	incw	x
5676  0a88 89            	pushw	x
5677  0a89 ce0000        	ldw	x,_uip_appdata
5678  0a8c cd0000        	call	L7_CopyHttpData
5680  0a8f 5b06          	addw	sp,#6
5681  0a91 1f02          	ldw	(OFST-2,sp),x
5683                     ; 3775       pSocket->nPrevBytes -= pSocket->nDataLeft;
5685  0a93 1e0b          	ldw	x,(OFST+7,sp)
5686  0a95 e60c          	ld	a,(12,x)
5687  0a97 e004          	sub	a,(4,x)
5688  0a99 e70c          	ld	(12,x),a
5689  0a9b e60b          	ld	a,(11,x)
5690  0a9d e203          	sbc	a,(3,x)
5691  0a9f e70b          	ld	(11,x),a
5692                     ; 3776       if (nBufSize == 0) {
5694  0aa1 1e02          	ldw	x,(OFST-2,sp)
5695                     ; 3778         uip_close();
5697  0aa3 2787          	jreq	LC017
5698                     ; 3782         uip_send(uip_appdata, nBufSize);
5700  0aa5 89            	pushw	x
5701  0aa6 ce0000        	ldw	x,_uip_appdata
5702  0aa9 cd0000        	call	_uip_send
5704  0aac 85            	popw	x
5705                     ; 3785     return;
5707  0aad               L5621:
5708                     ; 3787 }
5710  0aad cc012f        	jra	L452
5744                     ; 3790 void clear_saved_postpartial_all(void)
5744                     ; 3791 {
5745                     .text:	section	.text,new
5746  0000               _clear_saved_postpartial_all:
5748  0000 88            	push	a
5749       00000001      OFST:	set	1
5752                     ; 3793   for (i=0; i<24; i++) saved_postpartial[i] = '\0';
5754  0001 4f            	clr	a
5755  0002 6b01          	ld	(OFST+0,sp),a
5757  0004               L7112:
5760  0004 5f            	clrw	x
5761  0005 97            	ld	xl,a
5762  0006 724f002a      	clr	(_saved_postpartial,x)
5765  000a 0c01          	inc	(OFST+0,sp)
5769  000c 7b01          	ld	a,(OFST+0,sp)
5770  000e a118          	cp	a,#24
5771  0010 25f2          	jrult	L7112
5772                     ; 3794 }
5775  0012 84            	pop	a
5776  0013 81            	ret	
5810                     ; 3797 void clear_saved_postpartial_data(void)
5810                     ; 3798 {
5811                     .text:	section	.text,new
5812  0000               _clear_saved_postpartial_data:
5814  0000 88            	push	a
5815       00000001      OFST:	set	1
5818                     ; 3800   for (i=4; i<24; i++) saved_postpartial[i] = '\0';
5820  0001 a604          	ld	a,#4
5821  0003 6b01          	ld	(OFST+0,sp),a
5823  0005               L1412:
5826  0005 5f            	clrw	x
5827  0006 97            	ld	xl,a
5828  0007 724f002a      	clr	(_saved_postpartial,x)
5831  000b 0c01          	inc	(OFST+0,sp)
5835  000d 7b01          	ld	a,(OFST+0,sp)
5836  000f a118          	cp	a,#24
5837  0011 25f2          	jrult	L1412
5838                     ; 3801 }
5841  0013 84            	pop	a
5842  0014 81            	ret	
5876                     ; 3804 void clear_saved_postpartial_previous(void)
5876                     ; 3805 {
5877                     .text:	section	.text,new
5878  0000               _clear_saved_postpartial_previous:
5880  0000 88            	push	a
5881       00000001      OFST:	set	1
5884                     ; 3807   for (i=0; i<24; i++) saved_postpartial_previous[i] = '\0';
5886  0001 4f            	clr	a
5887  0002 6b01          	ld	(OFST+0,sp),a
5889  0004               L3612:
5892  0004 5f            	clrw	x
5893  0005 97            	ld	xl,a
5894  0006 724f0012      	clr	(_saved_postpartial_previous,x)
5897  000a 0c01          	inc	(OFST+0,sp)
5901  000c 7b01          	ld	a,(OFST+0,sp)
5902  000e a118          	cp	a,#24
5903  0010 25f2          	jrult	L3612
5904                     ; 3808 }
5907  0012 84            	pop	a
5908  0013 81            	ret	
5998                     ; 3811 void parse_POST_string(uint8_t curr_ParseCmd, uint8_t num_chars)
5998                     ; 3812 {
5999                     .text:	section	.text,new
6000  0000               _parse_POST_string:
6002  0000 89            	pushw	x
6003  0001 5217          	subw	sp,#23
6004       00000017      OFST:	set	23
6007                     ; 3835   amp_found = 0;
6009  0003 0f02          	clr	(OFST-21,sp)
6011                     ; 3836   for (i=0; i<20; i++) tmp_Pending[i] = '\0';
6013  0005 0f17          	clr	(OFST+0,sp)
6015  0007               L3222:
6018  0007 96            	ldw	x,sp
6019  0008 1c0003        	addw	x,#OFST-20
6020  000b 9f            	ld	a,xl
6021  000c 5e            	swapw	x
6022  000d 1b17          	add	a,(OFST+0,sp)
6023  000f 2401          	jrnc	L662
6024  0011 5c            	incw	x
6025  0012               L662:
6026  0012 02            	rlwa	x,a
6027  0013 7f            	clr	(x)
6030  0014 0c17          	inc	(OFST+0,sp)
6034  0016 7b17          	ld	a,(OFST+0,sp)
6035  0018 a114          	cp	a,#20
6036  001a 25eb          	jrult	L3222
6037                     ; 3838   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6039  001c c60012        	ld	a,_saved_postpartial_previous
6040  001f 1118          	cp	a,(OFST+1,sp)
6041  0021 260a          	jrne	L1322
6042                     ; 3841     saved_postpartial_previous[0] = '\0';
6044  0023 725f0012      	clr	_saved_postpartial_previous
6045                     ; 3847     frag_flag = 1; // frag_flag is used to manage the TCP Fragment restore
6047  0027 a601          	ld	a,#1
6048  0029 6b17          	ld	(OFST+0,sp),a
6051  002b 2005          	jra	L3322
6052  002d               L1322:
6053                     ; 3851     frag_flag = 0;
6055  002d 0f17          	clr	(OFST+0,sp)
6057                     ; 3855     clear_saved_postpartial_data(); // Clear [4] and higher
6059  002f cd0000        	call	_clear_saved_postpartial_data
6061  0032               L3322:
6062                     ; 3876   resume = 0;
6064  0032 0f01          	clr	(OFST-22,sp)
6066                     ; 3877   if (frag_flag == 1) {
6068  0034 7b17          	ld	a,(OFST+0,sp)
6069  0036 4a            	dec	a
6070  0037 263f          	jrne	L5322
6071                     ; 3879     for (i = 0; i < num_chars; i++) {
6073  0039 6b17          	ld	(OFST+0,sp),a
6076  003b 2033          	jra	L3422
6077  003d               L7322:
6078                     ; 3888       if (saved_postpartial_previous[4+i] != '\0') {
6080  003d 5f            	clrw	x
6081  003e 97            	ld	xl,a
6082  003f 724d0016      	tnz	(_saved_postpartial_previous+4,x)
6083  0043 271b          	jreq	L7422
6084                     ; 3889         tmp_Pending[i] = saved_postpartial_previous[4+i];
6086  0045 96            	ldw	x,sp
6087  0046 1c0003        	addw	x,#OFST-20
6088  0049 9f            	ld	a,xl
6089  004a 5e            	swapw	x
6090  004b 1b17          	add	a,(OFST+0,sp)
6091  004d 2401          	jrnc	L272
6092  004f 5c            	incw	x
6093  0050               L272:
6094  0050 02            	rlwa	x,a
6095  0051 7b17          	ld	a,(OFST+0,sp)
6096  0053 905f          	clrw	y
6097  0055 9097          	ld	yl,a
6098  0057 90d60016      	ld	a,(_saved_postpartial_previous+4,y)
6099  005b f7            	ld	(x),a
6101                     ; 3879     for (i = 0; i < num_chars; i++) {
6103  005c 0c17          	inc	(OFST+0,sp)
6105  005e 2010          	jra	L3422
6106  0060               L7422:
6107                     ; 3892         resume = i;
6109  0060 6b01          	ld	(OFST-22,sp),a
6111                     ; 3893         break;
6112  0062               L5422:
6113                     ; 3896     if (*tmp_pBuffer == '&') {
6115  0062 72c6000e      	ld	a,[_tmp_pBuffer.w]
6116  0066 a126          	cp	a,#38
6117  0068 260e          	jrne	L5322
6118                     ; 3900       amp_found = 1;
6120  006a a601          	ld	a,#1
6121  006c 6b02          	ld	(OFST-21,sp),a
6123  006e 2008          	jra	L5322
6124  0070               L3422:
6125                     ; 3879     for (i = 0; i < num_chars; i++) {
6127  0070 7b17          	ld	a,(OFST+0,sp)
6128  0072 1119          	cp	a,(OFST+2,sp)
6129  0074 25c7          	jrult	L7322
6130  0076 20ea          	jra	L5422
6131  0078               L5322:
6132                     ; 3912   if (amp_found == 0) {
6134  0078 7b02          	ld	a,(OFST-21,sp)
6135  007a 2703cc0104    	jrne	L5522
6136                     ; 3913     for (i = resume; i < num_chars; i++) {
6138  007f 7b01          	ld	a,(OFST-22,sp)
6139  0081 6b17          	ld	(OFST+0,sp),a
6142  0083 207b          	jra	L3622
6143  0085               L7522:
6144                     ; 3916       if (amp_found == 0) {
6146  0085 7b02          	ld	a,(OFST-21,sp)
6147  0087 265d          	jrne	L7622
6148                     ; 3919         if (*tmp_pBuffer == '&') {
6150  0089 72c6000e      	ld	a,[_tmp_pBuffer.w]
6151  008d a126          	cp	a,#38
6152  008f 2606          	jrne	L1722
6153                     ; 3922           amp_found = 1;
6155  0091 a601          	ld	a,#1
6156  0093 6b02          	ld	(OFST-21,sp),a
6159  0095 204f          	jra	L7622
6160  0097               L1722:
6161                     ; 3925           tmp_Pending[i] = *tmp_pBuffer;
6163  0097 96            	ldw	x,sp
6164  0098 1c0003        	addw	x,#OFST-20
6165  009b 9f            	ld	a,xl
6166  009c 5e            	swapw	x
6167  009d 1b17          	add	a,(OFST+0,sp)
6168  009f 2401          	jrnc	L472
6169  00a1 5c            	incw	x
6170  00a2               L472:
6171  00a2 90ce000e      	ldw	y,_tmp_pBuffer
6172  00a6 02            	rlwa	x,a
6173  00a7 90f6          	ld	a,(y)
6174  00a9 f7            	ld	(x),a
6175                     ; 3926           saved_postpartial[4+i] = *tmp_pBuffer;
6177  00aa 5f            	clrw	x
6178  00ab 7b17          	ld	a,(OFST+0,sp)
6179  00ad 97            	ld	xl,a
6180  00ae 90f6          	ld	a,(y)
6181  00b0 d7002e        	ld	(_saved_postpartial+4,x),a
6182                     ; 3927           tmp_nParseLeft--;
6184  00b3 725a000b      	dec	_tmp_nParseLeft
6185                     ; 3928           saved_nparseleft = tmp_nParseLeft;
6187                     ; 3929           tmp_pBuffer++;
6189  00b7 93            	ldw	x,y
6190  00b8 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6191  00bd 5c            	incw	x
6192  00be cf000e        	ldw	_tmp_pBuffer,x
6193                     ; 3930           tmp_nBytes--;
6195  00c1 ce000c        	ldw	x,_tmp_nBytes
6196  00c4 5a            	decw	x
6197  00c5 cf000c        	ldw	_tmp_nBytes,x
6198                     ; 3931           if (tmp_nBytes == 0) {
6200  00c8 261c          	jrne	L7622
6201                     ; 3935             if (i == (num_chars - 1)) {
6203  00ca 7b19          	ld	a,(OFST+2,sp)
6204  00cc 5f            	clrw	x
6205  00cd 97            	ld	xl,a
6206  00ce 5a            	decw	x
6207  00cf 7b17          	ld	a,(OFST+0,sp)
6208  00d1 905f          	clrw	y
6209  00d3 9097          	ld	yl,a
6210  00d5 90bf00        	ldw	c_y,y
6211  00d8 b300          	cpw	x,c_y
6212  00da 2604          	jrne	L7722
6213                     ; 3940               saved_parsestate = PARSE_DELIM;
6215  00dc 35050043      	mov	_saved_parsestate,#5
6216  00e0               L7722:
6217                     ; 3942             break_while = 1;
6219  00e0 3501000a      	mov	_break_while,#1
6220                     ; 3943             break; // This will break the for() loop. But we need to break the
6222  00e4 201e          	jra	L5522
6223  00e6               L7622:
6224                     ; 3949       if (amp_found == 1) {
6226  00e6 7b02          	ld	a,(OFST-21,sp)
6227  00e8 4a            	dec	a
6228  00e9 2611          	jrne	L1032
6229                     ; 3952         tmp_Pending[i] = '\0';
6231  00eb 96            	ldw	x,sp
6232  00ec 1c0003        	addw	x,#OFST-20
6233  00ef 9f            	ld	a,xl
6234  00f0 5e            	swapw	x
6235  00f1 1b17          	add	a,(OFST+0,sp)
6236  00f3 2401          	jrnc	L672
6237  00f5 5c            	incw	x
6238  00f6               L672:
6239  00f6 02            	rlwa	x,a
6240  00f7 7f            	clr	(x)
6241                     ; 3961         tmp_nParseLeft--;
6243  00f8 725a000b      	dec	_tmp_nParseLeft
6244  00fc               L1032:
6245                     ; 3913     for (i = resume; i < num_chars; i++) {
6247  00fc 0c17          	inc	(OFST+0,sp)
6249  00fe 7b17          	ld	a,(OFST+0,sp)
6250  0100               L3622:
6253  0100 1119          	cp	a,(OFST+2,sp)
6254  0102 2581          	jrult	L7522
6255  0104               L5522:
6256                     ; 3982   if (break_while == 0) clear_saved_postpartial_all();
6258  0104 c6000a        	ld	a,_break_while
6259  0107 2603          	jrne	L3032
6262  0109 cd0000        	call	_clear_saved_postpartial_all
6264  010c               L3032:
6265                     ; 3985   if (curr_ParseCmd == 'a') {
6267  010c 7b18          	ld	a,(OFST+1,sp)
6268  010e a161          	cp	a,#97
6269  0110 2622          	jrne	L5032
6270                     ; 3986     for (i=0; i<num_chars; i++) Pending_devicename[i] = tmp_Pending[i];
6272  0112 0f17          	clr	(OFST+0,sp)
6275  0114 2016          	jra	L3132
6276  0116               L7032:
6279  0116 5f            	clrw	x
6280  0117 97            	ld	xl,a
6281  0118 89            	pushw	x
6282  0119 96            	ldw	x,sp
6283  011a 1c0005        	addw	x,#OFST-18
6284  011d 9f            	ld	a,xl
6285  011e 5e            	swapw	x
6286  011f 1b19          	add	a,(OFST+2,sp)
6287  0121 2401          	jrnc	L203
6288  0123 5c            	incw	x
6289  0124               L203:
6290  0124 02            	rlwa	x,a
6291  0125 f6            	ld	a,(x)
6292  0126 85            	popw	x
6293  0127 d70000        	ld	(_Pending_devicename,x),a
6296  012a 0c17          	inc	(OFST+0,sp)
6298  012c               L3132:
6301  012c 7b17          	ld	a,(OFST+0,sp)
6302  012e 1119          	cp	a,(OFST+2,sp)
6303  0130 25e4          	jrult	L7032
6305  0132 204a          	jra	L7132
6306  0134               L5032:
6307                     ; 3991   else if (curr_ParseCmd == 'l') {
6309  0134 a16c          	cp	a,#108
6310  0136 2622          	jrne	L1232
6311                     ; 3992     for (i=0; i<num_chars; i++) Pending_mqtt_username[i] = tmp_Pending[i];
6313  0138 0f17          	clr	(OFST+0,sp)
6316  013a 2016          	jra	L7232
6317  013c               L3232:
6320  013c 5f            	clrw	x
6321  013d 97            	ld	xl,a
6322  013e 89            	pushw	x
6323  013f 96            	ldw	x,sp
6324  0140 1c0005        	addw	x,#OFST-18
6325  0143 9f            	ld	a,xl
6326  0144 5e            	swapw	x
6327  0145 1b19          	add	a,(OFST+2,sp)
6328  0147 2401          	jrnc	L403
6329  0149 5c            	incw	x
6330  014a               L403:
6331  014a 02            	rlwa	x,a
6332  014b f6            	ld	a,(x)
6333  014c 85            	popw	x
6334  014d d70000        	ld	(_Pending_mqtt_username,x),a
6337  0150 0c17          	inc	(OFST+0,sp)
6339  0152               L7232:
6342  0152 7b17          	ld	a,(OFST+0,sp)
6343  0154 1119          	cp	a,(OFST+2,sp)
6344  0156 25e4          	jrult	L3232
6346  0158 2024          	jra	L7132
6347  015a               L1232:
6348                     ; 3996   else if (curr_ParseCmd == 'm') {
6350  015a a16d          	cp	a,#109
6351  015c 2620          	jrne	L7132
6352                     ; 3997     for (i=0; i<num_chars; i++) Pending_mqtt_password[i] = tmp_Pending[i];
6354  015e 0f17          	clr	(OFST+0,sp)
6357  0160 2016          	jra	L3432
6358  0162               L7332:
6361  0162 5f            	clrw	x
6362  0163 97            	ld	xl,a
6363  0164 89            	pushw	x
6364  0165 96            	ldw	x,sp
6365  0166 1c0005        	addw	x,#OFST-18
6366  0169 9f            	ld	a,xl
6367  016a 5e            	swapw	x
6368  016b 1b19          	add	a,(OFST+2,sp)
6369  016d 2401          	jrnc	L603
6370  016f 5c            	incw	x
6371  0170               L603:
6372  0170 02            	rlwa	x,a
6373  0171 f6            	ld	a,(x)
6374  0172 85            	popw	x
6375  0173 d70000        	ld	(_Pending_mqtt_password,x),a
6378  0176 0c17          	inc	(OFST+0,sp)
6380  0178               L3432:
6383  0178 7b17          	ld	a,(OFST+0,sp)
6384  017a 1119          	cp	a,(OFST+2,sp)
6385  017c 25e4          	jrult	L7332
6386  017e               L7132:
6387                     ; 4000 }
6390  017e 5b19          	addw	sp,#25
6391  0180 81            	ret	
6465                     	switch	.const
6466  1d25               L023:
6467  1d25 00de          	dc.w	L7432
6468  1d27 00e5          	dc.w	L1532
6469  1d29 00ec          	dc.w	L3532
6470  1d2b 00f3          	dc.w	L5532
6471  1d2d 00fa          	dc.w	L7532
6472  1d2f 0101          	dc.w	L1632
6473  1d31 0108          	dc.w	L3632
6474  1d33 010f          	dc.w	L5632
6475  1d35 0116          	dc.w	L7632
6476  1d37 011d          	dc.w	L1732
6477  1d39 0124          	dc.w	L3732
6478  1d3b 012b          	dc.w	L5732
6479  1d3d 0132          	dc.w	L7732
6480  1d3f 0139          	dc.w	L1042
6481  1d41 0140          	dc.w	L3042
6482  1d43 0147          	dc.w	L5042
6483                     ; 4003 void parse_POST_address(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6483                     ; 4004 {
6484                     .text:	section	.text,new
6485  0000               _parse_POST_address:
6487  0000 89            	pushw	x
6488  0001 89            	pushw	x
6489       00000002      OFST:	set	2
6492                     ; 4007   alpha[0] = '-';
6494  0002 352d0004      	mov	_alpha,#45
6495                     ; 4008   alpha[1] = '-';
6497  0006 352d0005      	mov	_alpha+1,#45
6498                     ; 4009   alpha[2] = '-';
6500  000a 352d0006      	mov	_alpha+2,#45
6501                     ; 4012   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6503  000e 9e            	ld	a,xh
6504  000f c10012        	cp	a,_saved_postpartial_previous
6505  0012 2624          	jrne	L5342
6506                     ; 4015     saved_postpartial_previous[0] = '\0';
6508  0014 725f0012      	clr	_saved_postpartial_previous
6509                     ; 4022     if (saved_postpartial_previous[4] != '\0') alpha[0] = saved_postpartial_previous[4];
6511  0018 c60016        	ld	a,_saved_postpartial_previous+4
6512  001b 2705          	jreq	L7342
6515  001d 5500160004    	mov	_alpha,_saved_postpartial_previous+4
6516  0022               L7342:
6517                     ; 4023     if (saved_postpartial_previous[5] != '\0') alpha[1] = saved_postpartial_previous[5];
6519  0022 c60017        	ld	a,_saved_postpartial_previous+5
6520  0025 2705          	jreq	L1442
6523  0027 5500170005    	mov	_alpha+1,_saved_postpartial_previous+5
6524  002c               L1442:
6525                     ; 4024     if (saved_postpartial_previous[6] != '\0') alpha[2] = saved_postpartial_previous[6];
6527  002c c60018        	ld	a,_saved_postpartial_previous+6
6528  002f 270a          	jreq	L5442
6531  0031 5500180006    	mov	_alpha+2,_saved_postpartial_previous+6
6532  0036 2003          	jra	L5442
6533  0038               L5342:
6534                     ; 4030     clear_saved_postpartial_data(); // Clear [4] and higher
6536  0038 cd0000        	call	_clear_saved_postpartial_data
6538  003b               L5442:
6539                     ; 4033   for (i=0; i<3; i++) {
6541  003b 4f            	clr	a
6542  003c 6b02          	ld	(OFST+0,sp),a
6544  003e               L7442:
6545                     ; 4039     if (alpha[i] == '-') {
6547  003e 5f            	clrw	x
6548  003f 97            	ld	xl,a
6549  0040 d60004        	ld	a,(_alpha,x)
6550  0043 a12d          	cp	a,#45
6551  0045 263c          	jrne	L5542
6552                     ; 4040       alpha[i] = (uint8_t)(*tmp_pBuffer);
6554  0047 7b02          	ld	a,(OFST+0,sp)
6555  0049 5f            	clrw	x
6556  004a 90ce000e      	ldw	y,_tmp_pBuffer
6557  004e 97            	ld	xl,a
6558  004f 90f6          	ld	a,(y)
6559  0051 d70004        	ld	(_alpha,x),a
6560                     ; 4041       saved_postpartial[i+4] = (uint8_t)(*tmp_pBuffer);
6562  0054 5f            	clrw	x
6563  0055 7b02          	ld	a,(OFST+0,sp)
6564  0057 97            	ld	xl,a
6565  0058 90f6          	ld	a,(y)
6566  005a d7002e        	ld	(_saved_postpartial+4,x),a
6567                     ; 4042       tmp_nParseLeft--;
6569  005d 725a000b      	dec	_tmp_nParseLeft
6570                     ; 4043       saved_nparseleft = tmp_nParseLeft;
6572                     ; 4044       tmp_pBuffer++;
6574  0061 93            	ldw	x,y
6575  0062 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
6576  0067 5c            	incw	x
6577  0068 cf000e        	ldw	_tmp_pBuffer,x
6578                     ; 4045       tmp_nBytes--;
6580  006b ce000c        	ldw	x,_tmp_nBytes
6581  006e 5a            	decw	x
6582  006f cf000c        	ldw	_tmp_nBytes,x
6583                     ; 4046       if (i != 2 && tmp_nBytes == 0) {
6585  0072 7b02          	ld	a,(OFST+0,sp)
6586  0074 a102          	cp	a,#2
6587  0076 270b          	jreq	L5542
6589  0078 ce000c        	ldw	x,_tmp_nBytes
6590  007b 2606          	jrne	L5542
6591                     ; 4047         break_while = 1; // Hit end of fragment but still have characters to
6593  007d 3501000a      	mov	_break_while,#1
6594                     ; 4051         break; // Break out of for() loop.
6596  0081 2008          	jra	L3542
6597  0083               L5542:
6598                     ; 4033   for (i=0; i<3; i++) {
6600  0083 0c02          	inc	(OFST+0,sp)
6604  0085 7b02          	ld	a,(OFST+0,sp)
6605  0087 a103          	cp	a,#3
6606  0089 25b3          	jrult	L7442
6607  008b               L3542:
6608                     ; 4055   if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
6610  008b c6000a        	ld	a,_break_while
6611  008e 4a            	dec	a
6612  008f 2603cc0155    	jreq	L223
6615                     ; 4059   clear_saved_postpartial_all();
6617  0094 cd0000        	call	_clear_saved_postpartial_all
6619                     ; 4072     invalid = 0;
6621  0097 0f01          	clr	(OFST-1,sp)
6623                     ; 4074     temp = (uint8_t)(       (alpha[2] - '0'));
6625  0099 c60006        	ld	a,_alpha+2
6626  009c a030          	sub	a,#48
6627  009e 6b02          	ld	(OFST+0,sp),a
6629                     ; 4075     temp = (uint8_t)(temp + (alpha[1] - '0') * 10);
6631  00a0 c60005        	ld	a,_alpha+1
6632  00a3 97            	ld	xl,a
6633  00a4 a60a          	ld	a,#10
6634  00a6 42            	mul	x,a
6635  00a7 9f            	ld	a,xl
6636  00a8 a0e0          	sub	a,#224
6637  00aa 1b02          	add	a,(OFST+0,sp)
6638  00ac 6b02          	ld	(OFST+0,sp),a
6640                     ; 4076     if (temp > 55 && alpha[0] > '1') invalid = 1;
6642  00ae a138          	cp	a,#56
6643  00b0 250d          	jrult	L3642
6645  00b2 c60004        	ld	a,_alpha
6646  00b5 a132          	cp	a,#50
6647  00b7 2506          	jrult	L3642
6650  00b9 a601          	ld	a,#1
6651  00bb 6b01          	ld	(OFST-1,sp),a
6654  00bd 200e          	jra	L5642
6655  00bf               L3642:
6656                     ; 4077     else temp = (uint8_t)(temp + (alpha[0] - '0') * 100);
6658  00bf c60004        	ld	a,_alpha
6659  00c2 97            	ld	xl,a
6660  00c3 a664          	ld	a,#100
6661  00c5 42            	mul	x,a
6662  00c6 9f            	ld	a,xl
6663  00c7 a0c0          	sub	a,#192
6664  00c9 1b02          	add	a,(OFST+0,sp)
6665  00cb 6b02          	ld	(OFST+0,sp),a
6667  00cd               L5642:
6668                     ; 4078     if (invalid == 0) { // Make change only if valid entry
6670  00cd 7b01          	ld	a,(OFST-1,sp)
6671  00cf 267b          	jrne	L7642
6672                     ; 4079       switch(curr_ParseNum)
6674  00d1 7b04          	ld	a,(OFST+2,sp)
6676                     ; 4102         default: break;
6677  00d3 a110          	cp	a,#16
6678  00d5 2475          	jruge	L7642
6679  00d7 5f            	clrw	x
6680  00d8 97            	ld	xl,a
6681  00d9 58            	sllw	x
6682  00da de1d25        	ldw	x,(L023,x)
6683  00dd fc            	jp	(x)
6684  00de               L7432:
6685                     ; 4081         case 0:  Pending_hostaddr[3] = (uint8_t)temp; break;
6687  00de 7b02          	ld	a,(OFST+0,sp)
6688  00e0 c70003        	ld	_Pending_hostaddr+3,a
6691  00e3 2067          	jra	L7642
6692  00e5               L1532:
6693                     ; 4082         case 1:  Pending_hostaddr[2] = (uint8_t)temp; break;
6695  00e5 7b02          	ld	a,(OFST+0,sp)
6696  00e7 c70002        	ld	_Pending_hostaddr+2,a
6699  00ea 2060          	jra	L7642
6700  00ec               L3532:
6701                     ; 4083         case 2:  Pending_hostaddr[1] = (uint8_t)temp; break;
6703  00ec 7b02          	ld	a,(OFST+0,sp)
6704  00ee c70001        	ld	_Pending_hostaddr+1,a
6707  00f1 2059          	jra	L7642
6708  00f3               L5532:
6709                     ; 4084         case 3:  Pending_hostaddr[0] = (uint8_t)temp; break;
6711  00f3 7b02          	ld	a,(OFST+0,sp)
6712  00f5 c70000        	ld	_Pending_hostaddr,a
6715  00f8 2052          	jra	L7642
6716  00fa               L7532:
6717                     ; 4085         case 4:  Pending_draddr[3] = (uint8_t)temp; break;
6719  00fa 7b02          	ld	a,(OFST+0,sp)
6720  00fc c70003        	ld	_Pending_draddr+3,a
6723  00ff 204b          	jra	L7642
6724  0101               L1632:
6725                     ; 4086         case 5:  Pending_draddr[2] = (uint8_t)temp; break;
6727  0101 7b02          	ld	a,(OFST+0,sp)
6728  0103 c70002        	ld	_Pending_draddr+2,a
6731  0106 2044          	jra	L7642
6732  0108               L3632:
6733                     ; 4087         case 6:  Pending_draddr[1] = (uint8_t)temp; break;
6735  0108 7b02          	ld	a,(OFST+0,sp)
6736  010a c70001        	ld	_Pending_draddr+1,a
6739  010d 203d          	jra	L7642
6740  010f               L5632:
6741                     ; 4088         case 7:  Pending_draddr[0] = (uint8_t)temp; break;
6743  010f 7b02          	ld	a,(OFST+0,sp)
6744  0111 c70000        	ld	_Pending_draddr,a
6747  0114 2036          	jra	L7642
6748  0116               L7632:
6749                     ; 4089         case 8:  Pending_netmask[3] = (uint8_t)temp; break;
6751  0116 7b02          	ld	a,(OFST+0,sp)
6752  0118 c70003        	ld	_Pending_netmask+3,a
6755  011b 202f          	jra	L7642
6756  011d               L1732:
6757                     ; 4090         case 9:  Pending_netmask[2] = (uint8_t)temp; break;
6759  011d 7b02          	ld	a,(OFST+0,sp)
6760  011f c70002        	ld	_Pending_netmask+2,a
6763  0122 2028          	jra	L7642
6764  0124               L3732:
6765                     ; 4091         case 10: Pending_netmask[1] = (uint8_t)temp; break;
6767  0124 7b02          	ld	a,(OFST+0,sp)
6768  0126 c70001        	ld	_Pending_netmask+1,a
6771  0129 2021          	jra	L7642
6772  012b               L5732:
6773                     ; 4092         case 11: Pending_netmask[0] = (uint8_t)temp; break;
6775  012b 7b02          	ld	a,(OFST+0,sp)
6776  012d c70000        	ld	_Pending_netmask,a
6779  0130 201a          	jra	L7642
6780  0132               L7732:
6781                     ; 4095 	  Pending_mqttserveraddr[3] = (uint8_t)temp;
6783  0132 7b02          	ld	a,(OFST+0,sp)
6784  0134 c70003        	ld	_Pending_mqttserveraddr+3,a
6785                     ; 4096 	  break;
6787  0137 2013          	jra	L7642
6788  0139               L1042:
6789                     ; 4098         case 13: Pending_mqttserveraddr[2] = (uint8_t)temp; break;
6791  0139 7b02          	ld	a,(OFST+0,sp)
6792  013b c70002        	ld	_Pending_mqttserveraddr+2,a
6795  013e 200c          	jra	L7642
6796  0140               L3042:
6797                     ; 4099         case 14: Pending_mqttserveraddr[1] = (uint8_t)temp; break;
6799  0140 7b02          	ld	a,(OFST+0,sp)
6800  0142 c70001        	ld	_Pending_mqttserveraddr+1,a
6803  0145 2005          	jra	L7642
6804  0147               L5042:
6805                     ; 4100         case 15: Pending_mqttserveraddr[0] = (uint8_t)temp; break;
6807  0147 7b02          	ld	a,(OFST+0,sp)
6808  0149 c70000        	ld	_Pending_mqttserveraddr,a
6811                     ; 4102         default: break;
6813  014c               L7642:
6814                     ; 4107   if (tmp_nBytes == 0) {
6816  014c ce000c        	ldw	x,_tmp_nBytes
6817  014f 2604          	jrne	L223
6818                     ; 4110     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
6820  0151 3502000a      	mov	_break_while,#2
6821                     ; 4113     return;
6822  0155               L223:
6825  0155 5b04          	addw	sp,#4
6826  0157 81            	ret	
6827                     ; 4115 }
6907                     ; 4118 void parse_POST_port(uint8_t curr_ParseCmd, uint8_t curr_ParseNum)
6907                     ; 4119 {
6908                     .text:	section	.text,new
6909  0000               _parse_POST_port:
6911  0000 89            	pushw	x
6912  0001 5203          	subw	sp,#3
6913       00000003      OFST:	set	3
6916                     ; 4122   for (i=0; i<5; i++) alpha[i] = '-';
6918  0003 4f            	clr	a
6919  0004 6b03          	ld	(OFST+0,sp),a
6921  0006               L5252:
6924  0006 5f            	clrw	x
6925  0007 97            	ld	xl,a
6926  0008 a62d          	ld	a,#45
6927  000a d70004        	ld	(_alpha,x),a
6930  000d 0c03          	inc	(OFST+0,sp)
6934  000f 7b03          	ld	a,(OFST+0,sp)
6935  0011 a105          	cp	a,#5
6936  0013 25f1          	jrult	L5252
6937                     ; 4124   if (saved_postpartial_previous[0] == curr_ParseCmd) {
6939  0015 c60012        	ld	a,_saved_postpartial_previous
6940  0018 1104          	cp	a,(OFST+1,sp)
6941  001a 2621          	jrne	L3352
6942                     ; 4127     saved_postpartial_previous[0] = '\0';
6944  001c 725f0012      	clr	_saved_postpartial_previous
6945                     ; 4134     for (i=0; i<5; i++) {
6947  0020 4f            	clr	a
6948  0021 6b03          	ld	(OFST+0,sp),a
6950  0023               L5352:
6951                     ; 4135       if (saved_postpartial_previous[i+4] != '\0') alpha[i] = saved_postpartial_previous[i+4];
6953  0023 5f            	clrw	x
6954  0024 97            	ld	xl,a
6955  0025 724d0016      	tnz	(_saved_postpartial_previous+4,x)
6956  0029 2708          	jreq	L3452
6959  002b 5f            	clrw	x
6960  002c 97            	ld	xl,a
6961  002d d60016        	ld	a,(_saved_postpartial_previous+4,x)
6962  0030 d70004        	ld	(_alpha,x),a
6963  0033               L3452:
6964                     ; 4134     for (i=0; i<5; i++) {
6966  0033 0c03          	inc	(OFST+0,sp)
6970  0035 7b03          	ld	a,(OFST+0,sp)
6971  0037 a105          	cp	a,#5
6972  0039 25e8          	jrult	L5352
6974  003b 2003          	jra	L5452
6975  003d               L3352:
6976                     ; 4142     clear_saved_postpartial_data(); // Clear [4] and higher
6978  003d cd0000        	call	_clear_saved_postpartial_data
6980  0040               L5452:
6981                     ; 4147     for (i=0; i<5; i++) {
6983  0040 4f            	clr	a
6984  0041 6b03          	ld	(OFST+0,sp),a
6986  0043               L7452:
6987                     ; 4153       if (alpha[i] == '-') {
6989  0043 5f            	clrw	x
6990  0044 97            	ld	xl,a
6991  0045 d60004        	ld	a,(_alpha,x)
6992  0048 a12d          	cp	a,#45
6993  004a 263c          	jrne	L5552
6994                     ; 4154         alpha[i] = (uint8_t)(*tmp_pBuffer);
6996  004c 7b03          	ld	a,(OFST+0,sp)
6997  004e 5f            	clrw	x
6998  004f 90ce000e      	ldw	y,_tmp_pBuffer
6999  0053 97            	ld	xl,a
7000  0054 90f6          	ld	a,(y)
7001  0056 d70004        	ld	(_alpha,x),a
7002                     ; 4155         saved_postpartial[i+4] = *tmp_pBuffer;
7004  0059 5f            	clrw	x
7005  005a 7b03          	ld	a,(OFST+0,sp)
7006  005c 97            	ld	xl,a
7007  005d 90f6          	ld	a,(y)
7008  005f d7002e        	ld	(_saved_postpartial+4,x),a
7009                     ; 4156         tmp_nParseLeft--;
7011  0062 725a000b      	dec	_tmp_nParseLeft
7012                     ; 4157         saved_nparseleft = tmp_nParseLeft;
7014                     ; 4158         tmp_pBuffer++;
7016  0066 93            	ldw	x,y
7017  0067 55000b0042    	mov	_saved_nparseleft,_tmp_nParseLeft
7018  006c 5c            	incw	x
7019  006d cf000e        	ldw	_tmp_pBuffer,x
7020                     ; 4159         tmp_nBytes--;
7022  0070 ce000c        	ldw	x,_tmp_nBytes
7023  0073 5a            	decw	x
7024  0074 cf000c        	ldw	_tmp_nBytes,x
7025                     ; 4160         if (i != 4 && tmp_nBytes == 0) {
7027  0077 7b03          	ld	a,(OFST+0,sp)
7028  0079 a104          	cp	a,#4
7029  007b 270b          	jreq	L5552
7031  007d ce000c        	ldw	x,_tmp_nBytes
7032  0080 2606          	jrne	L5552
7033                     ; 4161           break_while = 1; // Hit end of fragment but still have characters to
7035  0082 3501000a      	mov	_break_while,#1
7036                     ; 4165    	break; // Break out of for() loop.
7038  0086 2008          	jra	L3552
7039  0088               L5552:
7040                     ; 4147     for (i=0; i<5; i++) {
7042  0088 0c03          	inc	(OFST+0,sp)
7046  008a 7b03          	ld	a,(OFST+0,sp)
7047  008c a105          	cp	a,#5
7048  008e 25b3          	jrult	L7452
7049  0090               L3552:
7050                     ; 4169     if (break_while == 1) return; // Hit end of fragment. Break out of while() loop.
7052  0090 c6000a        	ld	a,_break_while
7053  0093 4a            	dec	a
7054  0094 2603cc0122    	jreq	L233
7057                     ; 4174   clear_saved_postpartial_all();
7059  0099 cd0000        	call	_clear_saved_postpartial_all
7061                     ; 4183     invalid = 0;
7063  009c 0f03          	clr	(OFST+0,sp)
7065                     ; 4185     temp = (uint16_t)(       (alpha[4] - '0'));
7067  009e 5f            	clrw	x
7068  009f c60008        	ld	a,_alpha+4
7069  00a2 97            	ld	xl,a
7070  00a3 1d0030        	subw	x,#48
7071  00a6 1f01          	ldw	(OFST-2,sp),x
7073                     ; 4186     temp = (uint16_t)(temp + (alpha[3] - '0') * 10);
7075  00a8 c60007        	ld	a,_alpha+3
7076  00ab 97            	ld	xl,a
7077  00ac a60a          	ld	a,#10
7078  00ae 42            	mul	x,a
7079  00af 1d01e0        	subw	x,#480
7080  00b2 72fb01        	addw	x,(OFST-2,sp)
7081  00b5 1f01          	ldw	(OFST-2,sp),x
7083                     ; 4187     temp = (uint16_t)(temp + (alpha[2] - '0') * 100);
7085  00b7 c60006        	ld	a,_alpha+2
7086  00ba 97            	ld	xl,a
7087  00bb a664          	ld	a,#100
7088  00bd 42            	mul	x,a
7089  00be 1d12c0        	subw	x,#4800
7090  00c1 72fb01        	addw	x,(OFST-2,sp)
7091  00c4 1f01          	ldw	(OFST-2,sp),x
7093                     ; 4188     temp = (uint16_t)(temp + (alpha[1] - '0') * 1000);
7095  00c6 5f            	clrw	x
7096  00c7 c60005        	ld	a,_alpha+1
7097  00ca 97            	ld	xl,a
7098  00cb 90ae03e8      	ldw	y,#1000
7099  00cf cd0000        	call	c_imul
7101  00d2 1dbb80        	subw	x,#48000
7102  00d5 72fb01        	addw	x,(OFST-2,sp)
7103  00d8 1f01          	ldw	(OFST-2,sp),x
7105                     ; 4189     if (temp > 5535 && alpha[0] > '5') invalid = 1;
7107  00da a315a0        	cpw	x,#5536
7108  00dd 250d          	jrult	L3652
7110  00df c60004        	ld	a,_alpha
7111  00e2 a136          	cp	a,#54
7112  00e4 2506          	jrult	L3652
7115  00e6 a601          	ld	a,#1
7116  00e8 6b03          	ld	(OFST+0,sp),a
7119  00ea 2014          	jra	L5652
7120  00ec               L3652:
7121                     ; 4190     else temp = (uint16_t)(temp + (alpha[0] - '0') * 10000);
7123  00ec c60004        	ld	a,_alpha
7124  00ef 5f            	clrw	x
7125  00f0 97            	ld	xl,a
7126  00f1 90ae2710      	ldw	y,#10000
7127  00f5 cd0000        	call	c_imul
7129  00f8 1d5300        	subw	x,#21248
7130  00fb 72fb01        	addw	x,(OFST-2,sp)
7131  00fe 1f01          	ldw	(OFST-2,sp),x
7133  0100               L5652:
7134                     ; 4191     if (temp < 10) invalid = 1;
7136  0100 a3000a        	cpw	x,#10
7137  0103 2404          	jruge	L7652
7140  0105 a601          	ld	a,#1
7141  0107 6b03          	ld	(OFST+0,sp),a
7143  0109               L7652:
7144                     ; 4192     if (invalid == 0) {
7146  0109 7b03          	ld	a,(OFST+0,sp)
7147  010b 260c          	jrne	L1752
7148                     ; 4193       if (curr_ParseNum == 0) Pending_port = (uint16_t)temp;
7150  010d 7b05          	ld	a,(OFST+2,sp)
7151  010f 2605          	jrne	L3752
7154  0111 cf0000        	ldw	_Pending_port,x
7156  0114 2003          	jra	L1752
7157  0116               L3752:
7158                     ; 4195       else Pending_mqttport = (uint16_t)temp;
7160  0116 cf0000        	ldw	_Pending_mqttport,x
7161  0119               L1752:
7162                     ; 4200   if (tmp_nBytes == 0) {
7164  0119 ce000c        	ldw	x,_tmp_nBytes
7165  011c 2604          	jrne	L233
7166                     ; 4203     break_while = 2; // Hit end of fragment. Set break_while to 2 so that
7168  011e 3502000a      	mov	_break_while,#2
7169                     ; 4206     return;
7170  0122               L233:
7173  0122 5b05          	addw	sp,#5
7174  0124 81            	ret	
7175                     ; 4208 }
7210                     	switch	.const
7211  1d45               L043:
7212  1d45 000e          	dc.w	L1062
7213  1d47 0016          	dc.w	L3062
7214  1d49 001e          	dc.w	L5062
7215  1d4b 0026          	dc.w	L7062
7216  1d4d 002e          	dc.w	L1162
7217  1d4f 0036          	dc.w	L3162
7218  1d51 003e          	dc.w	L5162
7219  1d53 0046          	dc.w	L7162
7220  1d55 004e          	dc.w	L1262
7221  1d57 0056          	dc.w	L3262
7222  1d59 005e          	dc.w	L5262
7223  1d5b 0066          	dc.w	L7262
7224  1d5d 006e          	dc.w	L1362
7225  1d5f 0076          	dc.w	L3362
7226  1d61 007e          	dc.w	L5362
7227  1d63 0086          	dc.w	L7362
7228                     ; 4211 uint8_t GpioGetPin(uint8_t nGpio)
7228                     ; 4212 {
7229                     .text:	section	.text,new
7230  0000               _GpioGetPin:
7234                     ; 4217   switch (nGpio) {
7237                     ; 4233     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7238  0000 a110          	cp	a,#16
7239  0002 2503cc008e    	jruge	L7562
7240  0007 5f            	clrw	x
7241  0008 97            	ld	xl,a
7242  0009 58            	sllw	x
7243  000a de1d45        	ldw	x,(L043,x)
7244  000d fc            	jp	(x)
7245  000e               L1062:
7246                     ; 4218     case 0:  if (IO_8to1  & (uint8_t)(0x01)) return 1; break;
7248  000e 720100007b    	btjf	_IO_8to1,#0,L7562
7251  0013 a601          	ld	a,#1
7254  0015 81            	ret	
7255  0016               L3062:
7256                     ; 4219     case 1:  if (IO_8to1  & (uint8_t)(0x02)) return 1; break;
7258  0016 7203000073    	btjf	_IO_8to1,#1,L7562
7261  001b a601          	ld	a,#1
7264  001d 81            	ret	
7265  001e               L5062:
7266                     ; 4220     case 2:  if (IO_8to1  & (uint8_t)(0x04)) return 1; break;
7268  001e 720500006b    	btjf	_IO_8to1,#2,L7562
7271  0023 a601          	ld	a,#1
7274  0025 81            	ret	
7275  0026               L7062:
7276                     ; 4221     case 3:  if (IO_8to1  & (uint8_t)(0x08)) return 1; break;
7278  0026 7207000063    	btjf	_IO_8to1,#3,L7562
7281  002b a601          	ld	a,#1
7284  002d 81            	ret	
7285  002e               L1162:
7286                     ; 4222     case 4:  if (IO_8to1  & (uint8_t)(0x10)) return 1; break;
7288  002e 720900005b    	btjf	_IO_8to1,#4,L7562
7291  0033 a601          	ld	a,#1
7294  0035 81            	ret	
7295  0036               L3162:
7296                     ; 4223     case 5:  if (IO_8to1  & (uint8_t)(0x20)) return 1; break;
7298  0036 720b000053    	btjf	_IO_8to1,#5,L7562
7301  003b a601          	ld	a,#1
7304  003d 81            	ret	
7305  003e               L5162:
7306                     ; 4224     case 6:  if (IO_8to1  & (uint8_t)(0x40)) return 1; break;
7308  003e 720d00004b    	btjf	_IO_8to1,#6,L7562
7311  0043 a601          	ld	a,#1
7314  0045 81            	ret	
7315  0046               L7162:
7316                     ; 4225     case 7:  if (IO_8to1  & (uint8_t)(0x80)) return 1; break;
7318  0046 720f000043    	btjf	_IO_8to1,#7,L7562
7321  004b a601          	ld	a,#1
7324  004d 81            	ret	
7325  004e               L1262:
7326                     ; 4226     case 8:  if (IO_16to9 & (uint8_t)(0x01)) return 1; break;
7328  004e 720100003b    	btjf	_IO_16to9,#0,L7562
7331  0053 a601          	ld	a,#1
7334  0055 81            	ret	
7335  0056               L3262:
7336                     ; 4227     case 9:  if (IO_16to9 & (uint8_t)(0x02)) return 1; break;
7338  0056 7203000033    	btjf	_IO_16to9,#1,L7562
7341  005b a601          	ld	a,#1
7344  005d 81            	ret	
7345  005e               L5262:
7346                     ; 4228     case 10: if (IO_16to9 & (uint8_t)(0x04)) return 1; break;
7348  005e 720500002b    	btjf	_IO_16to9,#2,L7562
7351  0063 a601          	ld	a,#1
7354  0065 81            	ret	
7355  0066               L7262:
7356                     ; 4229     case 11: if (IO_16to9 & (uint8_t)(0x08)) return 1; break;
7358  0066 7207000023    	btjf	_IO_16to9,#3,L7562
7361  006b a601          	ld	a,#1
7364  006d 81            	ret	
7365  006e               L1362:
7366                     ; 4230     case 12: if (IO_16to9 & (uint8_t)(0x10)) return 1; break;
7368  006e 720900001b    	btjf	_IO_16to9,#4,L7562
7371  0073 a601          	ld	a,#1
7374  0075 81            	ret	
7375  0076               L3362:
7376                     ; 4231     case 13: if (IO_16to9 & (uint8_t)(0x20)) return 1; break;
7378  0076 720b000013    	btjf	_IO_16to9,#5,L7562
7381  007b a601          	ld	a,#1
7384  007d 81            	ret	
7385  007e               L5362:
7386                     ; 4232     case 14: if (IO_16to9 & (uint8_t)(0x40)) return 1; break;
7388  007e 720d00000b    	btjf	_IO_16to9,#6,L7562
7391  0083 a601          	ld	a,#1
7394  0085 81            	ret	
7395  0086               L7362:
7396                     ; 4233     case 15: if (IO_16to9 & (uint8_t)(0x80)) return 1; break;
7398  0086 720f000003    	btjf	_IO_16to9,#7,L7562
7401  008b a601          	ld	a,#1
7404  008d 81            	ret	
7405  008e               L7562:
7406                     ; 4235   return 0;
7408  008e 4f            	clr	a
7411  008f 81            	ret	
7458                     ; 4284 void GpioSetPin(uint8_t nGpio, uint8_t nState)
7458                     ; 4285 {
7459                     .text:	section	.text,new
7460  0000               _GpioSetPin:
7462  0000 89            	pushw	x
7463  0001 88            	push	a
7464       00000001      OFST:	set	1
7467                     ; 4292   mask = 0;
7469  0002 0f01          	clr	(OFST+0,sp)
7471                     ; 4294   switch(nGpio) {
7473  0004 9e            	ld	a,xh
7475                     ; 4303     default: break;
7476  0005 4d            	tnz	a
7477  0006 2717          	jreq	L1272
7478  0008 4a            	dec	a
7479  0009 2717          	jreq	L3272
7480  000b 4a            	dec	a
7481  000c 2718          	jreq	L5272
7482  000e 4a            	dec	a
7483  000f 2719          	jreq	L7272
7484  0011 4a            	dec	a
7485  0012 271a          	jreq	L1372
7486  0014 4a            	dec	a
7487  0015 271b          	jreq	L3372
7488  0017 4a            	dec	a
7489  0018 271c          	jreq	L5372
7490  001a 4a            	dec	a
7491  001b 271d          	jreq	L7372
7492  001d 201f          	jra	L5672
7493  001f               L1272:
7494                     ; 4295     case 0: mask = 0x01; break;
7496  001f 4c            	inc	a
7499  0020 201a          	jp	LC026
7500  0022               L3272:
7501                     ; 4296     case 1: mask = 0x02; break;
7503  0022 a602          	ld	a,#2
7506  0024 2016          	jp	LC026
7507  0026               L5272:
7508                     ; 4297     case 2: mask = 0x04; break;
7510  0026 a604          	ld	a,#4
7513  0028 2012          	jp	LC026
7514  002a               L7272:
7515                     ; 4298     case 3: mask = 0x08; break;
7517  002a a608          	ld	a,#8
7520  002c 200e          	jp	LC026
7521  002e               L1372:
7522                     ; 4299     case 4: mask = 0x10; break;
7524  002e a610          	ld	a,#16
7527  0030 200a          	jp	LC026
7528  0032               L3372:
7529                     ; 4300     case 5: mask = 0x20; break;
7531  0032 a620          	ld	a,#32
7534  0034 2006          	jp	LC026
7535  0036               L5372:
7536                     ; 4301     case 6: mask = 0x40; break;
7538  0036 a640          	ld	a,#64
7541  0038 2002          	jp	LC026
7542  003a               L7372:
7543                     ; 4302     case 7: mask = 0x80; break;
7545  003a a680          	ld	a,#128
7546  003c               LC026:
7547  003c 6b01          	ld	(OFST+0,sp),a
7551                     ; 4303     default: break;
7553  003e               L5672:
7554                     ; 4306   if (nState) IO_8to1 |= mask;
7556  003e 7b03          	ld	a,(OFST+2,sp)
7557  0040 2707          	jreq	L7672
7560  0042 c60000        	ld	a,_IO_8to1
7561  0045 1a01          	or	a,(OFST+0,sp)
7563  0047 2006          	jra	L1772
7564  0049               L7672:
7565                     ; 4307   else IO_8to1 &= (uint8_t)~mask;
7567  0049 7b01          	ld	a,(OFST+0,sp)
7568  004b 43            	cpl	a
7569  004c c40000        	and	a,_IO_8to1
7570  004f               L1772:
7571  004f c70000        	ld	_IO_8to1,a
7572                     ; 4309 }
7575  0052 5b03          	addw	sp,#3
7576  0054 81            	ret	
7637                     ; 4321 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7637                     ; 4322 {
7638                     .text:	section	.text,new
7639  0000               _SetMAC:
7641  0000 89            	pushw	x
7642  0001 5203          	subw	sp,#3
7643       00000003      OFST:	set	3
7646                     ; 4336   temp = 0;
7648                     ; 4337   invalid = 0;
7650  0003 0f01          	clr	(OFST-2,sp)
7652                     ; 4340   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7654  0005 9f            	ld	a,xl
7655  0006 a130          	cp	a,#48
7656  0008 250b          	jrult	L5303
7658  000a 9f            	ld	a,xl
7659  000b a13a          	cp	a,#58
7660  000d 2406          	jruge	L5303
7663  000f 7b05          	ld	a,(OFST+2,sp)
7664  0011 a030          	sub	a,#48
7666  0013 200c          	jp	LC027
7667  0015               L5303:
7668                     ; 4341   else if (alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7670  0015 7b05          	ld	a,(OFST+2,sp)
7671  0017 a161          	cp	a,#97
7672  0019 250a          	jrult	L1403
7674  001b a167          	cp	a,#103
7675  001d 2406          	jruge	L1403
7678  001f a057          	sub	a,#87
7679  0021               LC027:
7680  0021 6b05          	ld	(OFST+2,sp),a
7682  0023 2004          	jra	L7303
7683  0025               L1403:
7684                     ; 4342   else invalid = 1; // If an invalid entry set indicator
7686  0025 a601          	ld	a,#1
7687  0027 6b01          	ld	(OFST-2,sp),a
7689  0029               L7303:
7690                     ; 4344   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7692  0029 7b08          	ld	a,(OFST+5,sp)
7693  002b a130          	cp	a,#48
7694  002d 2508          	jrult	L5403
7696  002f a13a          	cp	a,#58
7697  0031 2404          	jruge	L5403
7700  0033 a030          	sub	a,#48
7702  0035 200a          	jp	LC028
7703  0037               L5403:
7704                     ; 4345   else if (alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7706  0037 a161          	cp	a,#97
7707  0039 250a          	jrult	L1503
7709  003b a167          	cp	a,#103
7710  003d 2406          	jruge	L1503
7713  003f a057          	sub	a,#87
7714  0041               LC028:
7715  0041 6b08          	ld	(OFST+5,sp),a
7717  0043 2004          	jra	L7403
7718  0045               L1503:
7719                     ; 4346   else invalid = 1; // If an invalid entry set indicator
7721  0045 a601          	ld	a,#1
7722  0047 6b01          	ld	(OFST-2,sp),a
7724  0049               L7403:
7725                     ; 4348   if (invalid == 0) { // Change value only if valid entry
7727  0049 7b01          	ld	a,(OFST-2,sp)
7728  004b 264a          	jrne	L5503
7729                     ; 4349     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7731  004d 7b05          	ld	a,(OFST+2,sp)
7732  004f 97            	ld	xl,a
7733  0050 a610          	ld	a,#16
7734  0052 42            	mul	x,a
7735  0053 01            	rrwa	x,a
7736  0054 1b08          	add	a,(OFST+5,sp)
7737  0056 5f            	clrw	x
7738  0057 97            	ld	xl,a
7739  0058 1f02          	ldw	(OFST-1,sp),x
7741                     ; 4350     switch(itemnum)
7743  005a 7b04          	ld	a,(OFST+1,sp)
7745                     ; 4358     default: break;
7746  005c 2711          	jreq	L3772
7747  005e 4a            	dec	a
7748  005f 2715          	jreq	L5772
7749  0061 4a            	dec	a
7750  0062 2719          	jreq	L7772
7751  0064 4a            	dec	a
7752  0065 271d          	jreq	L1003
7753  0067 4a            	dec	a
7754  0068 2721          	jreq	L3003
7755  006a 4a            	dec	a
7756  006b 2725          	jreq	L5003
7757  006d 2028          	jra	L5503
7758  006f               L3772:
7759                     ; 4352     case 0: Pending_uip_ethaddr_oct[5] = (uint8_t)temp; break;
7761  006f 7b03          	ld	a,(OFST+0,sp)
7762  0071 c70005        	ld	_Pending_uip_ethaddr_oct+5,a
7765  0074 2021          	jra	L5503
7766  0076               L5772:
7767                     ; 4353     case 1: Pending_uip_ethaddr_oct[4] = (uint8_t)temp; break;
7769  0076 7b03          	ld	a,(OFST+0,sp)
7770  0078 c70004        	ld	_Pending_uip_ethaddr_oct+4,a
7773  007b 201a          	jra	L5503
7774  007d               L7772:
7775                     ; 4354     case 2: Pending_uip_ethaddr_oct[3] = (uint8_t)temp; break;
7777  007d 7b03          	ld	a,(OFST+0,sp)
7778  007f c70003        	ld	_Pending_uip_ethaddr_oct+3,a
7781  0082 2013          	jra	L5503
7782  0084               L1003:
7783                     ; 4355     case 3: Pending_uip_ethaddr_oct[2] = (uint8_t)temp; break;
7785  0084 7b03          	ld	a,(OFST+0,sp)
7786  0086 c70002        	ld	_Pending_uip_ethaddr_oct+2,a
7789  0089 200c          	jra	L5503
7790  008b               L3003:
7791                     ; 4356     case 4: Pending_uip_ethaddr_oct[1] = (uint8_t)temp; break;
7793  008b 7b03          	ld	a,(OFST+0,sp)
7794  008d c70001        	ld	_Pending_uip_ethaddr_oct+1,a
7797  0090 2005          	jra	L5503
7798  0092               L5003:
7799                     ; 4357     case 5: Pending_uip_ethaddr_oct[0] = (uint8_t)temp; break;
7801  0092 7b03          	ld	a,(OFST+0,sp)
7802  0094 c70000        	ld	_Pending_uip_ethaddr_oct,a
7805                     ; 4358     default: break;
7807  0097               L5503:
7808                     ; 4361 }
7811  0097 5b05          	addw	sp,#5
7812  0099 81            	ret	
8206                     	switch	.bss
8207  0000               _insertion_flag:
8208  0000 000000        	ds.b	3
8209                     	xdef	_insertion_flag
8210                     	xref	_second_counter
8211                     	xref	_TRANSMIT_counter
8212                     	xref	_TXERIF_counter
8213                     	xref	_RXERIF_counter
8214                     	xref	_MQTT_error_status
8215                     	xref	_mqtt_start_status
8216                     	xref	_Pending_mqtt_password
8217                     	xref	_Pending_mqtt_username
8218                     	xref	_Pending_mqttport
8219                     	xref	_Pending_mqttserveraddr
8220                     	xref	_stored_mqtt_password
8221                     	xref	_stored_mqtt_username
8222                     	xref	_stored_mqttport
8223                     	xref	_stored_mqttserveraddr
8224  0003               _current_webpage:
8225  0003 00            	ds.b	1
8226                     	xdef	_current_webpage
8227  0004               _alpha:
8228  0004 000000000000  	ds.b	6
8229                     	xdef	_alpha
8230  000a               _break_while:
8231  000a 00            	ds.b	1
8232                     	xdef	_break_while
8233  000b               _tmp_nParseLeft:
8234  000b 00            	ds.b	1
8235                     	xdef	_tmp_nParseLeft
8236  000c               _tmp_nBytes:
8237  000c 0000          	ds.b	2
8238                     	xdef	_tmp_nBytes
8239  000e               _tmp_pBuffer:
8240  000e 0000          	ds.b	2
8241                     	xdef	_tmp_pBuffer
8242  0010               _z_diag:
8243  0010 00            	ds.b	1
8244                     	xdef	_z_diag
8245  0011               _saved_newlines:
8246  0011 00            	ds.b	1
8247                     	xdef	_saved_newlines
8248  0012               _saved_postpartial_previous:
8249  0012 000000000000  	ds.b	24
8250                     	xdef	_saved_postpartial_previous
8251  002a               _saved_postpartial:
8252  002a 000000000000  	ds.b	24
8253                     	xdef	_saved_postpartial
8254  0042               _saved_nparseleft:
8255  0042 00            	ds.b	1
8256                     	xdef	_saved_nparseleft
8257  0043               _saved_parsestate:
8258  0043 00            	ds.b	1
8259                     	xdef	_saved_parsestate
8260  0044               _saved_nstate:
8261  0044 00            	ds.b	1
8262                     	xdef	_saved_nstate
8263  0045               _OctetArray:
8264  0045 000000000000  	ds.b	11
8265                     	xdef	_OctetArray
8266                     	xref	_user_reboot_request
8267                     	xref	_parse_complete
8268                     	xref	_mac_string
8269                     	xref	_stored_config_settings
8270                     	xref	_stored_devicename
8271                     	xref	_stored_port
8272                     	xref	_stored_netmask
8273                     	xref	_stored_draddr
8274                     	xref	_stored_hostaddr
8275                     	xref	_Pending_uip_ethaddr_oct
8276                     	xref	_Pending_config_settings
8277                     	xref	_Pending_devicename
8278                     	xref	_Pending_port
8279                     	xref	_Pending_netmask
8280                     	xref	_Pending_draddr
8281                     	xref	_Pending_hostaddr
8282                     	xref	_invert_input
8283                     	xref	_IO_8to1
8284                     	xref	_IO_16to9
8285                     	xref	_Port_Httpd
8286                     	xref	_strlen
8287                     	xref	_debugflash
8288                     	xref	_uip_flags
8289                     	xref	_uip_conn
8290                     	xref	_uip_len
8291                     	xref	_uip_appdata
8292                     	xref	_htons
8293                     	xref	_uip_send
8294                     	xref	_uip_listen
8295                     	xref	_uip_init_stats
8296                     	xdef	_SetMAC
8297                     	xdef	_clear_saved_postpartial_previous
8298                     	xdef	_clear_saved_postpartial_data
8299                     	xdef	_clear_saved_postpartial_all
8300                     	xdef	_GpioSetPin
8301                     	xdef	_GpioGetPin
8302                     	xdef	_parse_POST_port
8303                     	xdef	_parse_POST_address
8304                     	xdef	_parse_POST_string
8305                     	xdef	_HttpDCall
8306                     	xdef	_HttpDInit
8307                     	xdef	_emb_itoa
8308                     	xdef	_adjust_template_size
8309                     	switch	.const
8310  1d65               L333:
8311  1d65 436f6e6e6563  	dc.b	"Connection:close",13
8312  1d76 0a00          	dc.b	10,0
8313  1d78               L133:
8314  1d78 436f6e74656e  	dc.b	"Content-Type: text"
8315  1d8a 2f68746d6c3b  	dc.b	"/html; charset=utf"
8316  1d9c 2d380d        	dc.b	"-8",13
8317  1d9f 0a00          	dc.b	10,0
8318  1da1               L723:
8319  1da1 43616368652d  	dc.b	"Cache-Control: no-"
8320  1db3 63616368652c  	dc.b	"cache, no-store",13
8321  1dc3 0a00          	dc.b	10,0
8322  1dc5               L713:
8323  1dc5 436f6e74656e  	dc.b	"Content-Length:",0
8324  1dd5               L513:
8325  1dd5 0d0a00        	dc.b	13,10,0
8326  1dd8               L313:
8327  1dd8 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8328                     	xref.b	c_lreg
8329                     	xref.b	c_x
8330                     	xref.b	c_y
8350                     	xref	c_imul
8351                     	xref	c_uitolx
8352                     	xref	c_ludv
8353                     	xref	c_lumd
8354                     	xref	c_rtol
8355                     	xref	c_ltor
8356                     	xref	c_lzmp
8357                     	end
