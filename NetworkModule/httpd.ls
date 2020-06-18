   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  17                     .const:	section	.text
  18  0000               L31_checked:
  19  0000 636865636b65  	dc.b	"checked",0
  20  0008               L51_g_HtmlPageDefault:
  21  0008 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
  22  001a 6d6c206c616e  	dc.b	"ml lang='en'><head"
  23  002c 3e3c7469746c  	dc.b	"><title>Relay Cont"
  24  003e 726f6c3c2f74  	dc.b	"rol</title><style>"
  25  0050 2e7330207b20  	dc.b	".s0 { background-c"
  26  0062 6f6c6f723a20  	dc.b	"olor: red; width: "
  27  0074 333070783b20  	dc.b	"30px; }.s1 { backg"
  28  0086 726f756e642d  	dc.b	"round-color: green"
  29  0098 3b2077696474  	dc.b	"; width: 30px; }.t"
  30  00aa 31636c617373  	dc.b	"1class { width: 10"
  31  00bc 3070783b207d  	dc.b	"0px; }.t2class { w"
  32  00ce 696474683a20  	dc.b	"idth: 148px; }.t3c"
  33  00e0 6c617373207b  	dc.b	"lass { width: 30px"
  34  00f2 3b207d2e7434  	dc.b	"; }.t4class { widt"
  35  0104 683a20        	dc.b	"h: "
  36  0107 31323070783b  	dc.b	"120px; }td { text-"
  37  0119 616c69676e3a  	dc.b	"align: center; bor"
  38  012b 6465723a2031  	dc.b	"der: 1px black sol"
  39  013d 69643b207d3c  	dc.b	"id; }</style></hea"
  40  014f 643e3c626f64  	dc.b	"d><body><h1>Relay "
  41  0161 436f6e74726f  	dc.b	"Control</h1><form "
  42  0173 6d6574686f64  	dc.b	"method='POST' acti"
  43  0185 6f6e3d272f27  	dc.b	"on='/'><table><tr>"
  44  0197 3c746420636c  	dc.b	"<td class='t1class"
  45  01a9 273e4e616d65  	dc.b	"'>Name:</td><td><i"
  46  01bb 6e7075742074  	dc.b	"nput type='text' n"
  47  01cd 616d653d2761  	dc.b	"ame='a00' class='t"
  48  01df 32636c617373  	dc.b	"2class' value='%a0"
  49  01f1 307878787878  	dc.b	"0xxxxxxxxxxxxxxxxx"
  50  0203 787878        	dc.b	"xxx"
  51  0206 272070617474  	dc.b	"' pattern='[0-9a-z"
  52  0218 412d5a2d5f2a  	dc.b	"A-Z-_*.]{1,20}' ti"
  53  022a 746c653d2731  	dc.b	"tle='1 to 20 lette"
  54  023c 72732c206e75  	dc.b	"rs, numbers, and -"
  55  024e 5f2a2e206e6f  	dc.b	"_*. no spaces' max"
  56  0260 6c656e677468  	dc.b	"length='20' size='"
  57  0272 3230273e3c2f  	dc.b	"20'></td></tr></ta"
  58  0284 626c653e3c74  	dc.b	"ble><table><tr><td"
  59  0296 20636c617373  	dc.b	" class='t1class'><"
  60  02a8 2f74643e3c74  	dc.b	"/td><td class='t3c"
  61  02ba 6c617373273e  	dc.b	"lass'></td><td cla"
  62  02cc 73733d277434  	dc.b	"ss='t4class'>SET</"
  63  02de 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
  64  02f0 6173733d2774  	dc.b	"ass='t1class'>Rela"
  65  0302 793031        	dc.b	"y01"
  66  0305 3c2f74643e3c  	dc.b	"</td><td class='s%"
  67  0317 693030273e3c  	dc.b	"i00'></td><td clas"
  68  0329 733d27743463  	dc.b	"s='t4class'><input"
  69  033b 20747970653d  	dc.b	" type='radio' id='"
  70  034d 72656c617930  	dc.b	"relay01on' name='o"
  71  035f 303027207661  	dc.b	"00' value='1' %o00"
  72  0371 3e3c6c616265  	dc.b	"><label for='relay"
  73  0383 30316f6e273e  	dc.b	"01on'>ON</label><i"
  74  0395 6e7075742074  	dc.b	"nput type='radio' "
  75  03a7 69643d277265  	dc.b	"id='relay01off' na"
  76  03b9 6d653d276f30  	dc.b	"me='o00' value='0'"
  77  03cb 20257030303e  	dc.b	" %p00><label for='"
  78  03dd 72656c617930  	dc.b	"relay01off'>OFF</l"
  79  03ef 6162656c3e3c  	dc.b	"abel></td></tr><tr"
  80  0401 3e3c74        	dc.b	"><t"
  81  0404 6420636c6173  	dc.b	"d class='t1class'>"
  82  0416 52656c617930  	dc.b	"Relay02</td><td cl"
  83  0428 6173733d2773  	dc.b	"ass='s%i01'></td><"
  84  043a 746420636c61  	dc.b	"td class='t4class'"
  85  044c 3e3c696e7075  	dc.b	"><input type='radi"
  86  045e 6f272069643d  	dc.b	"o' id='relay02on' "
  87  0470 6e616d653d27  	dc.b	"name='o01' value='"
  88  0482 312720256f30  	dc.b	"1' %o01><label for"
  89  0494 3d2772656c61  	dc.b	"='relay02on'>ON</l"
  90  04a6 6162656c3e3c  	dc.b	"abel><input type='"
  91  04b8 726164696f27  	dc.b	"radio' id='relay02"
  92  04ca 6f666627206e  	dc.b	"off' name='o01' va"
  93  04dc 6c75653d2730  	dc.b	"lue='0' %p01><labe"
  94  04ee 6c20666f723d  	dc.b	"l for='relay02off'"
  95  0500 3e4f46        	dc.b	">OF"
  96  0503 463c2f6c6162  	dc.b	"F</label></td></tr"
  97  0515 3e3c74723e3c  	dc.b	"><tr><td class='t1"
  98  0527 636c61737327  	dc.b	"class'>Relay03</td"
  99  0539 3e3c74642063  	dc.b	"><td class='s%i02'"
 100  054b 3e3c2f74643e  	dc.b	"></td><td class='t"
 101  055d 34636c617373  	dc.b	"4class'><input typ"
 102  056f 653d27726164  	dc.b	"e='radio' id='rela"
 103  0581 7930336f6e27  	dc.b	"y03on' name='o02' "
 104  0593 76616c75653d  	dc.b	"value='1' %o02><la"
 105  05a5 62656c20666f  	dc.b	"bel for='relay03on"
 106  05b7 273e4f4e3c2f  	dc.b	"'>ON</label><input"
 107  05c9 20747970653d  	dc.b	" type='radio' id='"
 108  05db 72656c617930  	dc.b	"relay03off' name='"
 109  05ed 6f3032272076  	dc.b	"o02' value='0' %p0"
 110  05ff 323e3c        	dc.b	"2><"
 111  0602 6c6162656c20  	dc.b	"label for='relay03"
 112  0614 6f6666273e4f  	dc.b	"off'>OFF</label></"
 113  0626 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
 114  0638 6173733d2774  	dc.b	"ass='t1class'>Rela"
 115  064a 7930343c2f74  	dc.b	"y04</td><td class="
 116  065c 277325693033  	dc.b	"'s%i03'></td><td c"
 117  066e 6c6173733d27  	dc.b	"lass='t4class'><in"
 118  0680 707574207479  	dc.b	"put type='radio' i"
 119  0692 643d2772656c  	dc.b	"d='relay04on' name"
 120  06a4 3d276f303327  	dc.b	"='o03' value='1' %"
 121  06b6 6f30333e3c6c  	dc.b	"o03><label for='re"
 122  06c8 6c617930346f  	dc.b	"lay04on'>ON</label"
 123  06da 3e3c696e7075  	dc.b	"><input type='radi"
 124  06ec 6f272069643d  	dc.b	"o' id='relay04off'"
 125  06fe 206e61        	dc.b	" na"
 126  0701 6d653d276f30  	dc.b	"me='o03' value='0'"
 127  0713 20257030333e  	dc.b	" %p03><label for='"
 128  0725 72656c617930  	dc.b	"relay04off'>OFF</l"
 129  0737 6162656c3e3c  	dc.b	"abel></td></tr><tr"
 130  0749 3e3c74642063  	dc.b	"><td class='t1clas"
 131  075b 73273e52656c  	dc.b	"s'>Relay05</td><td"
 132  076d 20636c617373  	dc.b	" class='s%i04'></t"
 133  077f 643e3c746420  	dc.b	"d><td class='t4cla"
 134  0791 7373273e3c69  	dc.b	"ss'><input type='r"
 135  07a3 6164696f2720  	dc.b	"adio' id='relay05o"
 136  07b5 6e27206e616d  	dc.b	"n' name='o04' valu"
 137  07c7 653d27312720  	dc.b	"e='1' %o04><label "
 138  07d9 666f723d2772  	dc.b	"for='relay05on'>ON"
 139  07eb 3c2f6c616265  	dc.b	"</label><input typ"
 140  07fd 653d27        	dc.b	"e='"
 141  0800 726164696f27  	dc.b	"radio' id='relay05"
 142  0812 6f666627206e  	dc.b	"off' name='o04' va"
 143  0824 6c75653d2730  	dc.b	"lue='0' %p04><labe"
 144  0836 6c20666f723d  	dc.b	"l for='relay05off'"
 145  0848 3e4f46463c2f  	dc.b	">OFF</label></td><"
 146  085a 2f74723e3c74  	dc.b	"/tr><tr><td class="
 147  086c 277431636c61  	dc.b	"'t1class'>Relay06<"
 148  087e 2f74643e3c74  	dc.b	"/td><td class='s%i"
 149  0890 3035273e3c2f  	dc.b	"05'></td><td class"
 150  08a2 3d277434636c  	dc.b	"='t4class'><input "
 151  08b4 747970653d27  	dc.b	"type='radio' id='r"
 152  08c6 656c61793036  	dc.b	"elay06on' name='o0"
 153  08d8 35272076616c  	dc.b	"5' value='1' %o05>"
 154  08ea 3c6c6162656c  	dc.b	"<label for='relay0"
 155  08fc 366f6e        	dc.b	"6on"
 156  08ff 273e4f4e3c2f  	dc.b	"'>ON</label><input"
 157  0911 20747970653d  	dc.b	" type='radio' id='"
 158  0923 72656c617930  	dc.b	"relay06off' name='"
 159  0935 6f3035272076  	dc.b	"o05' value='0' %p0"
 160  0947 353e3c6c6162  	dc.b	"5><label for='rela"
 161  0959 7930366f6666  	dc.b	"y06off'>OFF</label"
 162  096b 3e3c2f74643e  	dc.b	"></td></tr><tr><td"
 163  097d 20636c617373  	dc.b	" class='t1class'>R"
 164  098f 656c61793037  	dc.b	"elay07</td><td cla"
 165  09a1 73733d277325  	dc.b	"ss='s%i06'></td><t"
 166  09b3 6420636c6173  	dc.b	"d class='t4class'>"
 167  09c5 3c696e707574  	dc.b	"<input type='radio"
 168  09d7 272069643d27  	dc.b	"' id='relay07on' n"
 169  09e9 616d653d276f  	dc.b	"ame='o06' value='1"
 170  09fb 272025        	dc.b	"' %"
 171  09fe 6f30363e3c6c  	dc.b	"o06><label for='re"
 172  0a10 6c617930376f  	dc.b	"lay07on'>ON</label"
 173  0a22 3e3c696e7075  	dc.b	"><input type='radi"
 174  0a34 6f272069643d  	dc.b	"o' id='relay07off'"
 175  0a46 206e616d653d  	dc.b	" name='o06' value="
 176  0a58 273027202570  	dc.b	"'0' %p06><label fo"
 177  0a6a 723d2772656c  	dc.b	"r='relay07off'>OFF"
 178  0a7c 3c2f6c616265  	dc.b	"</label></td></tr>"
 179  0a8e 3c74723e3c74  	dc.b	"<tr><td class='t1c"
 180  0aa0 6c617373273e  	dc.b	"lass'>Relay08</td>"
 181  0ab2 3c746420636c  	dc.b	"<td class='s%i07'>"
 182  0ac4 3c2f74643e3c  	dc.b	"</td><td class='t4"
 183  0ad6 636c61737327  	dc.b	"class'><input type"
 184  0ae8 3d2772616469  	dc.b	"='radio' id='relay"
 185  0afa 30386f        	dc.b	"08o"
 186  0afd 6e27206e616d  	dc.b	"n' name='o07' valu"
 187  0b0f 653d27312720  	dc.b	"e='1' %o07><label "
 188  0b21 666f723d2772  	dc.b	"for='relay08on'>ON"
 189  0b33 3c2f6c616265  	dc.b	"</label><input typ"
 190  0b45 653d27726164  	dc.b	"e='radio' id='rela"
 191  0b57 7930386f6666  	dc.b	"y08off' name='o07'"
 192  0b69 2076616c7565  	dc.b	" value='0' %p07><l"
 193  0b7b 6162656c2066  	dc.b	"abel for='relay08o"
 194  0b8d 6666273e4f46  	dc.b	"ff'>OFF</label></t"
 195  0b9f 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
 196  0bb1 73733d277431  	dc.b	"ss='t1class'>Relay"
 197  0bc3 30393c2f7464  	dc.b	"09</td><td class='"
 198  0bd5 732569303827  	dc.b	"s%i08'></td><td cl"
 199  0be7 6173733d2774  	dc.b	"ass='t4class'><inp"
 200  0bf9 757420        	dc.b	"ut "
 201  0bfc 747970653d27  	dc.b	"type='radio' id='r"
 202  0c0e 656c61793039  	dc.b	"elay09on' name='o0"
 203  0c20 38272076616c  	dc.b	"8' value='1' %o08>"
 204  0c32 3c6c6162656c  	dc.b	"<label for='relay0"
 205  0c44 396f6e273e4f  	dc.b	"9on'>ON</label><in"
 206  0c56 707574207479  	dc.b	"put type='radio' i"
 207  0c68 643d2772656c  	dc.b	"d='relay09off' nam"
 208  0c7a 653d276f3038  	dc.b	"e='o08' value='0' "
 209  0c8c 257030383e3c  	dc.b	"%p08><label for='r"
 210  0c9e 656c61793039  	dc.b	"elay09off'>OFF</la"
 211  0cb0 62656c3e3c2f  	dc.b	"bel></td></tr><tr>"
 212  0cc2 3c746420636c  	dc.b	"<td class='t1class"
 213  0cd4 273e52656c61  	dc.b	"'>Relay10</td><td "
 214  0ce6 636c6173733d  	dc.b	"class='s%i09'></td"
 215  0cf8 3e3c74        	dc.b	"><t"
 216  0cfb 6420636c6173  	dc.b	"d class='t4class'>"
 217  0d0d 3c696e707574  	dc.b	"<input type='radio"
 218  0d1f 272069643d27  	dc.b	"' id='relay10on' n"
 219  0d31 616d653d276f  	dc.b	"ame='o09' value='1"
 220  0d43 2720256f3039  	dc.b	"' %o09><label for="
 221  0d55 2772656c6179  	dc.b	"'relay10on'>ON</la"
 222  0d67 62656c3e3c69  	dc.b	"bel><input type='r"
 223  0d79 6164696f2720  	dc.b	"adio' id='relay10o"
 224  0d8b 666627206e61  	dc.b	"ff' name='o09' val"
 225  0d9d 75653d273027  	dc.b	"ue='0' %p09><label"
 226  0daf 20666f723d27  	dc.b	" for='relay10off'>"
 227  0dc1 4f46463c2f6c  	dc.b	"OFF</label></td></"
 228  0dd3 74723e3c7472  	dc.b	"tr><tr><td class='"
 229  0de5 7431636c6173  	dc.b	"t1class'>Relay11</"
 230  0df7 74643e        	dc.b	"td>"
 231  0dfa 3c746420636c  	dc.b	"<td class='s%i10'>"
 232  0e0c 3c2f74643e3c  	dc.b	"</td><td class='t4"
 233  0e1e 636c61737327  	dc.b	"class'><input type"
 234  0e30 3d2772616469  	dc.b	"='radio' id='relay"
 235  0e42 31316f6e2720  	dc.b	"11on' name='o10' v"
 236  0e54 616c75653d27  	dc.b	"alue='1' %o10><lab"
 237  0e66 656c20666f72  	dc.b	"el for='relay11on'"
 238  0e78 3e4f4e3c2f6c  	dc.b	">ON</label><input "
 239  0e8a 747970653d27  	dc.b	"type='radio' id='r"
 240  0e9c 656c61793131  	dc.b	"elay11off' name='o"
 241  0eae 313027207661  	dc.b	"10' value='0' %p10"
 242  0ec0 3e3c6c616265  	dc.b	"><label for='relay"
 243  0ed2 31316f666627  	dc.b	"11off'>OFF</label>"
 244  0ee4 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 245  0ef6 636c61        	dc.b	"cla"
 246  0ef9 73733d277431  	dc.b	"ss='t1class'>Relay"
 247  0f0b 31323c2f7464  	dc.b	"12</td><td class='"
 248  0f1d 732569313127  	dc.b	"s%i11'></td><td cl"
 249  0f2f 6173733d2774  	dc.b	"ass='t4class'><inp"
 250  0f41 757420747970  	dc.b	"ut type='radio' id"
 251  0f53 3d2772656c61  	dc.b	"='relay12on' name="
 252  0f65 276f31312720  	dc.b	"'o11' value='1' %o"
 253  0f77 31313e3c6c61  	dc.b	"11><label for='rel"
 254  0f89 617931326f6e  	dc.b	"ay12on'>ON</label>"
 255  0f9b 3c696e707574  	dc.b	"<input type='radio"
 256  0fad 272069643d27  	dc.b	"' id='relay12off' "
 257  0fbf 6e616d653d27  	dc.b	"name='o11' value='"
 258  0fd1 302720257031  	dc.b	"0' %p11><label for"
 259  0fe3 3d2772656c61  	dc.b	"='relay12off'>OFF<"
 260  0ff5 2f6c61        	dc.b	"/la"
 261  0ff8 62656c3e3c2f  	dc.b	"bel></td></tr><tr>"
 262  100a 3c746420636c  	dc.b	"<td class='t1class"
 263  101c 273e52656c61  	dc.b	"'>Relay13</td><td "
 264  102e 636c6173733d  	dc.b	"class='s%i12'></td"
 265  1040 3e3c74642063  	dc.b	"><td class='t4clas"
 266  1052 73273e3c696e  	dc.b	"s'><input type='ra"
 267  1064 64696f272069  	dc.b	"dio' id='relay13on"
 268  1076 27206e616d65  	dc.b	"' name='o12' value"
 269  1088 3d2731272025  	dc.b	"='1' %o12><label f"
 270  109a 6f723d277265  	dc.b	"or='relay13on'>ON<"
 271  10ac 2f6c6162656c  	dc.b	"/label><input type"
 272  10be 3d2772616469  	dc.b	"='radio' id='relay"
 273  10d0 31336f666627  	dc.b	"13off' name='o12' "
 274  10e2 76616c75653d  	dc.b	"value='0' %p12><la"
 275  10f4 62656c        	dc.b	"bel"
 276  10f7 20666f723d27  	dc.b	" for='relay13off'>"
 277  1109 4f46463c2f6c  	dc.b	"OFF</label></td></"
 278  111b 74723e3c7472  	dc.b	"tr><tr><td class='"
 279  112d 7431636c6173  	dc.b	"t1class'>Relay14</"
 280  113f 74643e3c7464  	dc.b	"td><td class='s%i1"
 281  1151 33273e3c2f74  	dc.b	"3'></td><td class="
 282  1163 277434636c61  	dc.b	"'t4class'><input t"
 283  1175 7970653d2772  	dc.b	"ype='radio' id='re"
 284  1187 6c617931346f  	dc.b	"lay14on' name='o13"
 285  1199 272076616c75  	dc.b	"' value='1' %o13><"
 286  11ab 6c6162656c20  	dc.b	"label for='relay14"
 287  11bd 6f6e273e4f4e  	dc.b	"on'>ON</label><inp"
 288  11cf 757420747970  	dc.b	"ut type='radio' id"
 289  11e1 3d2772656c61  	dc.b	"='relay14off' name"
 290  11f3 3d276f        	dc.b	"='o"
 291  11f6 313327207661  	dc.b	"13' value='0' %p13"
 292  1208 3e3c6c616265  	dc.b	"><label for='relay"
 293  121a 31346f666627  	dc.b	"14off'>OFF</label>"
 294  122c 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 295  123e 636c6173733d  	dc.b	"class='t1class'>Re"
 296  1250 6c617931353c  	dc.b	"lay15</td><td clas"
 297  1262 733d27732569  	dc.b	"s='s%i14'></td><td"
 298  1274 20636c617373  	dc.b	" class='t4class'><"
 299  1286 696e70757420  	dc.b	"input type='radio'"
 300  1298 2069643d2772  	dc.b	" id='relay15on' na"
 301  12aa 6d653d276f31  	dc.b	"me='o14' value='1'"
 302  12bc 20256f31343e  	dc.b	" %o14><label for='"
 303  12ce 72656c617931  	dc.b	"relay15on'>ON</lab"
 304  12e0 656c3e3c696e  	dc.b	"el><input type='ra"
 305  12f2 64696f        	dc.b	"dio"
 306  12f5 272069643d27  	dc.b	"' id='relay15off' "
 307  1307 6e616d653d27  	dc.b	"name='o14' value='"
 308  1319 302720257031  	dc.b	"0' %p14><label for"
 309  132b 3d2772656c61  	dc.b	"='relay15off'>OFF<"
 310  133d 2f6c6162656c  	dc.b	"/label></td></tr><"
 311  134f 74723e3c7464  	dc.b	"tr><td class='t1cl"
 312  1361 617373273e52  	dc.b	"ass'>Relay16</td><"
 313  1373 746420636c61  	dc.b	"td class='s%i15'><"
 314  1385 2f74643e3c74  	dc.b	"/td><td class='t4c"
 315  1397 6c617373273e  	dc.b	"lass'><input type="
 316  13a9 27726164696f  	dc.b	"'radio' id='relay1"
 317  13bb 366f6e27206e  	dc.b	"6on' name='o15' va"
 318  13cd 6c75653d2731  	dc.b	"lue='1' %o15><labe"
 319  13df 6c20666f723d  	dc.b	"l for='relay16on'>"
 320  13f1 4f4e3c        	dc.b	"ON<"
 321  13f4 2f6c6162656c  	dc.b	"/label><input type"
 322  1406 3d2772616469  	dc.b	"='radio' id='relay"
 323  1418 31366f666627  	dc.b	"16off' name='o15' "
 324  142a 76616c75653d  	dc.b	"value='0' %p15><la"
 325  143c 62656c20666f  	dc.b	"bel for='relay16of"
 326  144e 66273e4f4646  	dc.b	"f'>OFF</label></td"
 327  1460 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 328  1472 733d27743163  	dc.b	"s='t1class'>Invert"
 329  1484 3c2f74643e3c  	dc.b	"</td><td class='t3"
 330  1496 636c61737327  	dc.b	"class'></td><td cl"
 331  14a8 6173733d2774  	dc.b	"ass='t4class'><inp"
 332  14ba 757420747970  	dc.b	"ut type='radio' id"
 333  14cc 3d27696e7665  	dc.b	"='invertOn' name='"
 334  14de 673030272076  	dc.b	"g00' value='1' %g0"
 335  14f0 303e3c        	dc.b	"0><"
 336  14f3 6c6162656c20  	dc.b	"label for='invertO"
 337  1505 6e273e4f4e3c  	dc.b	"n'>ON</label><inpu"
 338  1517 742074797065  	dc.b	"t type='radio' id="
 339  1529 27696e766572  	dc.b	"'invertOff' name='"
 340  153b 673030272076  	dc.b	"g00' value='0' %h0"
 341  154d 303e3c6c6162  	dc.b	"0><label for='inve"
 342  155f 72744f666627  	dc.b	"rtOff'>OFF</label>"
 343  1571 3c2f74643e3c  	dc.b	"</td></tr></table>"
 344  1583 3c627574746f  	dc.b	"<button type='subm"
 345  1595 697427207469  	dc.b	"it' title='Saves y"
 346  15a7 6f7572206368  	dc.b	"our changes - does"
 347  15b9 206e6f742072  	dc.b	" not restart the N"
 348  15cb 6574776f726b  	dc.b	"etwork Module'>Sav"
 349  15dd 653c2f627574  	dc.b	"e</button><button "
 350  15ef 747970        	dc.b	"typ"
 351  15f2 653d27726573  	dc.b	"e='reset' title='U"
 352  1604 6e2d646f6573  	dc.b	"n-does any changes"
 353  1616 207468617420  	dc.b	" that have not bee"
 354  1628 6e2073617665  	dc.b	"n saved'>Undo All<"
 355  163a 2f627574746f  	dc.b	"/button></form><fo"
 356  164c 726d20737479  	dc.b	"rm style='display:"
 357  165e 20696e6c696e  	dc.b	" inline' action='%"
 358  1670 783030687474  	dc.b	"x00http://192.168."
 359  1682 3030312e3030  	dc.b	"001.004:08080/61' "
 360  1694 6d6574686f64  	dc.b	"method='get'><butt"
 361  16a6 6f6e20746974  	dc.b	"on title='Save fir"
 362  16b8 737421205468  	dc.b	"st! This button wi"
 363  16ca 6c6c206e6f74  	dc.b	"ll not save your c"
 364  16dc 68616e676573  	dc.b	"hanges'>Address Se"
 365  16ee 747469        	dc.b	"tti"
 366  16f1 6e67733c2f62  	dc.b	"ngs</button></form"
 367  1703 3e3c666f726d  	dc.b	"><form style='disp"
 368  1715 6c61793a2069  	dc.b	"lay: inline' actio"
 369  1727 6e3d27257830  	dc.b	"n='%x00http://192."
 370  1739 3136382e3030  	dc.b	"168.001.004:08080/"
 371  174b 363627206d65  	dc.b	"66' method='get'><"
 372  175d 627574746f6e  	dc.b	"button title='Save"
 373  176f 206669727374  	dc.b	" first! This butto"
 374  1781 6e2077696c6c  	dc.b	"n will not save yo"
 375  1793 757220636861  	dc.b	"ur changes'>Networ"
 376  17a5 6b2053746174  	dc.b	"k Statistics</butt"
 377  17b7 6f6e3e3c2f66  	dc.b	"on></form><form st"
 378  17c9 796c653d2764  	dc.b	"yle='display: inli"
 379  17db 6e6527206163  	dc.b	"ne' action='%x00ht"
 380  17ed 74703a        	dc.b	"tp:"
 381  17f0 2f2f3139322e  	dc.b	"//192.168.001.004:"
 382  1802 30383038302f  	dc.b	"08080/63' method='"
 383  1814 676574273e3c  	dc.b	"get'><button title"
 384  1826 3d2753617665  	dc.b	"='Save first! This"
 385  1838 20627574746f  	dc.b	" button will not s"
 386  184a 61766520796f  	dc.b	"ave your changes'>"
 387  185c 48656c703c2f  	dc.b	"Help</button></for"
 388  186e 6d3e3c2f626f  	dc.b	"m></body></html>",0
 389  187f               L71_g_HtmlPageAddress:
 390  187f 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 391  1891 6d6c206c616e  	dc.b	"ml lang='en'><head"
 392  18a3 3e3c7469746c  	dc.b	"><title>Address Se"
 393  18b5 7474696e6773  	dc.b	"ttings</title><sty"
 394  18c7 6c653e2e7431  	dc.b	"le>.t1class { widt"
 395  18d9 683a20313030  	dc.b	"h: 100px; }.t2clas"
 396  18eb 73207b207769  	dc.b	"s { width: 25px; }"
 397  18fd 2e7433636c61  	dc.b	".t3class { width: "
 398  190f 313870783b20  	dc.b	"18px; }.t4class { "
 399  1921 77696474683a  	dc.b	"width: 40px; }td {"
 400  1933 20746578742d  	dc.b	" text-align: cente"
 401  1945 723b20626f72  	dc.b	"r; border: 1px bla"
 402  1957 636b20736f6c  	dc.b	"ck solid; }</style"
 403  1969 3e3c2f686561  	dc.b	"></head><body><h1>"
 404  197b 416464        	dc.b	"Add"
 405  197e 726573732053  	dc.b	"ress Settings</h1>"
 406  1990 3c666f726d20  	dc.b	"<form method='POST"
 407  19a2 272061637469  	dc.b	"' action='/'><tabl"
 408  19b4 653e3c74723e  	dc.b	"e><tr><td class='t"
 409  19c6 31636c617373  	dc.b	"1class'>IP Addr</t"
 410  19d8 643e3c74643e  	dc.b	"d><td><input type="
 411  19ea 277465787427  	dc.b	"'text' name='b00' "
 412  19fc 636c6173733d  	dc.b	"class='t2class' va"
 413  1a0e 6c75653d2725  	dc.b	"lue='%b00' pattern"
 414  1a20 3d275b302d39  	dc.b	"='[0-9]{3}' title="
 415  1a32 275468726565  	dc.b	"'Three digits from"
 416  1a44 203030302074  	dc.b	" 000 to 255' maxle"
 417  1a56 6e6774683d27  	dc.b	"ngth='3' size='3'>"
 418  1a68 3c2f74643e3c  	dc.b	"</td><td><input ty"
 419  1a7a 70653d        	dc.b	"pe="
 420  1a7d 277465787427  	dc.b	"'text' name='b01' "
 421  1a8f 636c6173733d  	dc.b	"class='t2class' va"
 422  1aa1 6c75653d2725  	dc.b	"lue='%b01' pattern"
 423  1ab3 3d275b302d39  	dc.b	"='[0-9]{3}' title="
 424  1ac5 275468726565  	dc.b	"'Three digits from"
 425  1ad7 203030302074  	dc.b	" 000 to 255' maxle"
 426  1ae9 6e6774683d27  	dc.b	"ngth='3' size='3'>"
 427  1afb 3c2f74643e3c  	dc.b	"</td><td><input ty"
 428  1b0d 70653d277465  	dc.b	"pe='text' name='b0"
 429  1b1f 322720636c61  	dc.b	"2' class='t2class'"
 430  1b31 2076616c7565  	dc.b	" value='%b02' patt"
 431  1b43 65726e3d275b  	dc.b	"ern='[0-9]{3}' tit"
 432  1b55 6c653d275468  	dc.b	"le='Three digits f"
 433  1b67 726f6d203030  	dc.b	"rom 000 to 255' ma"
 434  1b79 786c65        	dc.b	"xle"
 435  1b7c 6e6774683d27  	dc.b	"ngth='3' size='3'>"
 436  1b8e 3c2f74643e3c  	dc.b	"</td><td><input ty"
 437  1ba0 70653d277465  	dc.b	"pe='text' name='b0"
 438  1bb2 332720636c61  	dc.b	"3' class='t2class'"
 439  1bc4 2076616c7565  	dc.b	" value='%b03' patt"
 440  1bd6 65726e3d275b  	dc.b	"ern='[0-9]{3}' tit"
 441  1be8 6c653d275468  	dc.b	"le='Three digits f"
 442  1bfa 726f6d203030  	dc.b	"rom 000 to 255' ma"
 443  1c0c 786c656e6774  	dc.b	"xlength='3' size='"
 444  1c1e 33273e3c2f74  	dc.b	"3'></td></tr><tr><"
 445  1c30 746420636c61  	dc.b	"td class='t1class'"
 446  1c42 3e4761746577  	dc.b	">Gateway</td><td><"
 447  1c54 696e70757420  	dc.b	"input type='text' "
 448  1c66 6e616d653d27  	dc.b	"name='b04' class='"
 449  1c78 743263        	dc.b	"t2c"
 450  1c7b 6c6173732720  	dc.b	"lass' value='%b04'"
 451  1c8d 207061747465  	dc.b	" pattern='[0-9]{3}"
 452  1c9f 27207469746c  	dc.b	"' title='Three dig"
 453  1cb1 697473206672  	dc.b	"its from 000 to 25"
 454  1cc3 3527206d6178  	dc.b	"5' maxlength='3' s"
 455  1cd5 697a653d2733  	dc.b	"ize='3'></td><td><"
 456  1ce7 696e70757420  	dc.b	"input type='text' "
 457  1cf9 6e616d653d27  	dc.b	"name='b05' class='"
 458  1d0b 7432636c6173  	dc.b	"t2class' value='%b"
 459  1d1d 303527207061  	dc.b	"05' pattern='[0-9]"
 460  1d2f 7b337d272074  	dc.b	"{3}' title='Three "
 461  1d41 646967697473  	dc.b	"digits from 000 to"
 462  1d53 203235352720  	dc.b	" 255' maxlength='3"
 463  1d65 272073697a65  	dc.b	"' size='3'></td><t"
 464  1d77 643e3c        	dc.b	"d><"
 465  1d7a 696e70757420  	dc.b	"input type='text' "
 466  1d8c 6e616d653d27  	dc.b	"name='b06' class='"
 467  1d9e 7432636c6173  	dc.b	"t2class' value='%b"
 468  1db0 303627207061  	dc.b	"06' pattern='[0-9]"
 469  1dc2 7b337d272074  	dc.b	"{3}' title='Three "
 470  1dd4 646967697473  	dc.b	"digits from 000 to"
 471  1de6 203235352720  	dc.b	" 255' maxlength='3"
 472  1df8 272073697a65  	dc.b	"' size='3'></td><t"
 473  1e0a 643e3c696e70  	dc.b	"d><input type='tex"
 474  1e1c 7427206e616d  	dc.b	"t' name='b07' clas"
 475  1e2e 733d27743263  	dc.b	"s='t2class' value="
 476  1e40 272562303727  	dc.b	"'%b07' pattern='[0"
 477  1e52 2d395d7b337d  	dc.b	"-9]{3}' title='Thr"
 478  1e64 656520646967  	dc.b	"ee digits from 000"
 479  1e76 20746f        	dc.b	" to"
 480  1e79 203235352720  	dc.b	" 255' maxlength='3"
 481  1e8b 272073697a65  	dc.b	"' size='3'></td></"
 482  1e9d 74723e3c7472  	dc.b	"tr><tr><td class='"
 483  1eaf 7431636c6173  	dc.b	"t1class'>Netmask</"
 484  1ec1 74643e3c7464  	dc.b	"td><td><input type"
 485  1ed3 3d2774657874  	dc.b	"='text' name='b08'"
 486  1ee5 20636c617373  	dc.b	" class='t2class' v"
 487  1ef7 616c75653d27  	dc.b	"alue='%b08' patter"
 488  1f09 6e3d275b302d  	dc.b	"n='[0-9]{3}' title"
 489  1f1b 3d2754687265  	dc.b	"='Three digits fro"
 490  1f2d 6d2030303020  	dc.b	"m 000 to 255' maxl"
 491  1f3f 656e6774683d  	dc.b	"ength='3' size='3'"
 492  1f51 3e3c2f74643e  	dc.b	"></td><td><input t"
 493  1f63 7970653d2774  	dc.b	"ype='text' name='b"
 494  1f75 303927        	dc.b	"09'"
 495  1f78 20636c617373  	dc.b	" class='t2class' v"
 496  1f8a 616c75653d27  	dc.b	"alue='%b09' patter"
 497  1f9c 6e3d275b302d  	dc.b	"n='[0-9]{3}' title"
 498  1fae 3d2754687265  	dc.b	"='Three digits fro"
 499  1fc0 6d2030303020  	dc.b	"m 000 to 255' maxl"
 500  1fd2 656e6774683d  	dc.b	"ength='3' size='3'"
 501  1fe4 3e3c2f74643e  	dc.b	"></td><td><input t"
 502  1ff6 7970653d2774  	dc.b	"ype='text' name='b"
 503  2008 31302720636c  	dc.b	"10' class='t2class"
 504  201a 272076616c75  	dc.b	"' value='%b10' pat"
 505  202c 7465726e3d27  	dc.b	"tern='[0-9]{3}' ti"
 506  203e 746c653d2754  	dc.b	"tle='Three digits "
 507  2050 66726f6d2030  	dc.b	"from 000 to 255' m"
 508  2062 61786c656e67  	dc.b	"axlength='3' size="
 509  2074 273327        	dc.b	"'3'"
 510  2077 3e3c2f74643e  	dc.b	"></td><td><input t"
 511  2089 7970653d2774  	dc.b	"ype='text' name='b"
 512  209b 31312720636c  	dc.b	"11' class='t2class"
 513  20ad 272076616c75  	dc.b	"' value='%b11' pat"
 514  20bf 7465726e3d27  	dc.b	"tern='[0-9]{3}' ti"
 515  20d1 746c653d2754  	dc.b	"tle='Three digits "
 516  20e3 66726f6d2030  	dc.b	"from 000 to 255' m"
 517  20f5 61786c656e67  	dc.b	"axlength='3' size="
 518  2107 2733273e3c2f  	dc.b	"'3'></td></tr></ta"
 519  2119 626c653e3c74  	dc.b	"ble><table><tr><td"
 520  212b 20636c617373  	dc.b	" class='t1class'>P"
 521  213d 6f7274202020  	dc.b	"ort   </td><td><in"
 522  214f 707574207479  	dc.b	"put type='text' na"
 523  2161 6d653d276330  	dc.b	"me='c00' class='t4"
 524  2173 636c61        	dc.b	"cla"
 525  2176 737327207661  	dc.b	"ss' value='%c00' p"
 526  2188 61747465726e  	dc.b	"attern='[0-9]{5}' "
 527  219a 7469746c653d  	dc.b	"title='Five digits"
 528  21ac 2066726f6d20  	dc.b	" from 00000 to 655"
 529  21be 333627206d61  	dc.b	"36' maxlength='5' "
 530  21d0 73697a653d27  	dc.b	"size='5'></td></tr"
 531  21e2 3e3c2f746162  	dc.b	"></table><table><t"
 532  21f4 723e3c746420  	dc.b	"r><td class='t1cla"
 533  2206 7373273e4d41  	dc.b	"ss'>MAC Address</t"
 534  2218 643e3c74643e  	dc.b	"d><td><input type="
 535  222a 277465787427  	dc.b	"'text' name='d00' "
 536  223c 636c6173733d  	dc.b	"class='t3class' va"
 537  224e 6c75653d2725  	dc.b	"lue='%d00' pattern"
 538  2260 3d275b302d39  	dc.b	"='[0-9a-f]{2}' tit"
 539  2272 6c653d        	dc.b	"le="
 540  2275 2754776f2068  	dc.b	"'Two hex digits fr"
 541  2287 6f6d20303020  	dc.b	"om 00 to ff' maxle"
 542  2299 6e6774683d27  	dc.b	"ngth='2' size='2'>"
 543  22ab 3c2f74643e3c  	dc.b	"</td><td><input ty"
 544  22bd 70653d277465  	dc.b	"pe='text' name='d0"
 545  22cf 312720636c61  	dc.b	"1' class='t3class'"
 546  22e1 2076616c7565  	dc.b	" value='%d01' patt"
 547  22f3 65726e3d275b  	dc.b	"ern='[0-9a-f]{2}' "
 548  2305 7469746c653d  	dc.b	"title='Two hex dig"
 549  2317 697473206672  	dc.b	"its from 00 to ff'"
 550  2329 206d61786c65  	dc.b	" maxlength='2' siz"
 551  233b 653d2732273e  	dc.b	"e='2'></td><td><in"
 552  234d 707574207479  	dc.b	"put type='text' na"
 553  235f 6d653d276430  	dc.b	"me='d02' class='t3"
 554  2371 636c61        	dc.b	"cla"
 555  2374 737327207661  	dc.b	"ss' value='%d02' p"
 556  2386 61747465726e  	dc.b	"attern='[0-9a-f]{2"
 557  2398 7d2720746974  	dc.b	"}' title='Two hex "
 558  23aa 646967697473  	dc.b	"digits from 00 to "
 559  23bc 666627206d61  	dc.b	"ff' maxlength='2' "
 560  23ce 73697a653d27  	dc.b	"size='2'></td><td>"
 561  23e0 3c696e707574  	dc.b	"<input type='text'"
 562  23f2 206e616d653d  	dc.b	" name='d03' class="
 563  2404 277433636c61  	dc.b	"'t3class' value='%"
 564  2416 643033272070  	dc.b	"d03' pattern='[0-9"
 565  2428 612d665d7b32  	dc.b	"a-f]{2}' title='Tw"
 566  243a 6f2068657820  	dc.b	"o hex digits from "
 567  244c 303020746f20  	dc.b	"00 to ff' maxlengt"
 568  245e 683d27322720  	dc.b	"h='2' size='2'></t"
 569  2470 643e3c        	dc.b	"d><"
 570  2473 74643e3c696e  	dc.b	"td><input type='te"
 571  2485 787427206e61  	dc.b	"xt' name='d04' cla"
 572  2497 73733d277433  	dc.b	"ss='t3class' value"
 573  24a9 3d2725643034  	dc.b	"='%d04' pattern='["
 574  24bb 302d39612d66  	dc.b	"0-9a-f]{2}' title="
 575  24cd 2754776f2068  	dc.b	"'Two hex digits fr"
 576  24df 6f6d20303020  	dc.b	"om 00 to ff' maxle"
 577  24f1 6e6774683d27  	dc.b	"ngth='2' size='2'>"
 578  2503 3c2f74643e3c  	dc.b	"</td><td><input ty"
 579  2515 70653d277465  	dc.b	"pe='text' name='d0"
 580  2527 352720636c61  	dc.b	"5' class='t3class'"
 581  2539 2076616c7565  	dc.b	" value='%d05' patt"
 582  254b 65726e3d275b  	dc.b	"ern='[0-9a-f]{2}' "
 583  255d 7469746c653d  	dc.b	"title='Two hex dig"
 584  256f 697473        	dc.b	"its"
 585  2572 2066726f6d20  	dc.b	" from 00 to ff' ma"
 586  2584 786c656e6774  	dc.b	"xlength='2' size='"
 587  2596 32273e3c2f74  	dc.b	"2'></td></tr></tab"
 588  25a8 6c653e3c6275  	dc.b	"le><button type='s"
 589  25ba 75626d697427  	dc.b	"ubmit' title='Save"
 590  25cc 7320796f7572  	dc.b	"s your changes the"
 591  25de 6e2072657374  	dc.b	"n restarts the Net"
 592  25f0 776f726b204d  	dc.b	"work Module'>Save<"
 593  2602 2f627574746f  	dc.b	"/button><button ty"
 594  2614 70653d277265  	dc.b	"pe='reset' title='"
 595  2626 556e2d646f65  	dc.b	"Un-does any change"
 596  2638 732074686174  	dc.b	"s that have not be"
 597  264a 656e20736176  	dc.b	"en saved'>Undo All"
 598  265c 3c2f62757474  	dc.b	"</button></form><p"
 599  266e 206c69        	dc.b	" li"
 600  2671 6e652d686569  	dc.b	"ne-height 20px>Use"
 601  2683 206361757469  	dc.b	" caution when chan"
 602  2695 67696e672074  	dc.b	"ging the above. If"
 603  26a7 20796f75206d  	dc.b	" you make a mistak"
 604  26b9 6520796f7520  	dc.b	"e you may have to<"
 605  26cb 62723e726573  	dc.b	"br>restore factory"
 606  26dd 206465666175  	dc.b	" defaults by holdi"
 607  26ef 6e6720646f77  	dc.b	"ng down the reset "
 608  2701 627574746f6e  	dc.b	"button for 10 seco"
 609  2713 6e64732e3c62  	dc.b	"nds.<br><br>Make s"
 610  2725 757265207468  	dc.b	"ure the MAC you as"
 611  2737 7369676e2069  	dc.b	"sign is unique to "
 612  2749 796f7572206c  	dc.b	"your local network"
 613  275b 2e205265636f  	dc.b	". Recommended<br>i"
 614  276d 732074        	dc.b	"s t"
 615  2770 68617420796f  	dc.b	"hat you just incre"
 616  2782 6d656e742074  	dc.b	"ment the lowest oc"
 617  2794 74657420616e  	dc.b	"tet and then label"
 618  27a6 20796f757220  	dc.b	" your devices for<"
 619  27b8 62723e667574  	dc.b	"br>future referenc"
 620  27ca 652e3c62723e  	dc.b	"e.<br><br>If you c"
 621  27dc 68616e676520  	dc.b	"hange the highest "
 622  27ee 6f6374657420  	dc.b	"octet of the MAC y"
 623  2800 6f75204d5553  	dc.b	"ou MUST use an eve"
 624  2812 6e206e756d62  	dc.b	"n number to<br>for"
 625  2824 6d206120756e  	dc.b	"m a unicast addres"
 626  2836 732e2030302c  	dc.b	"s. 00, 02, ... fc,"
 627  2848 206665206574  	dc.b	" fe etc work fine."
 628  285a 2030312c2030  	dc.b	" 01, 03 ... fd, ff"
 629  286c 206172        	dc.b	" ar"
 630  286f 6520666f723c  	dc.b	"e for<br>multicast"
 631  2881 20616e642077  	dc.b	" and will not work"
 632  2893 2e3c2f703e3c  	dc.b	".</p><form style='"
 633  28a5 646973706c61  	dc.b	"display: inline' a"
 634  28b7 6374696f6e3d  	dc.b	"ction='%x00http://"
 635  28c9 3139322e3136  	dc.b	"192.168.001.004:08"
 636  28db 3038302f3931  	dc.b	"080/91' method='ge"
 637  28ed 74273e3c6275  	dc.b	"t'><button title='"
 638  28ff 536176652066  	dc.b	"Save first! This b"
 639  2911 7574746f6e20  	dc.b	"utton will not sav"
 640  2923 6520796f7572  	dc.b	"e your changes'>Re"
 641  2935 626f6f743c2f  	dc.b	"boot</button></for"
 642  2947 6d3e266e6273  	dc.b	"m>&nbsp&nbspNOTE: "
 643  2959 5265626f6f74  	dc.b	"Reboot may cause t"
 644  296b 686520        	dc.b	"he "
 645  296e 72656c617973  	dc.b	"relays to cycle.<b"
 646  2980 723e3c62723e  	dc.b	"r><br><form style="
 647  2992 27646973706c  	dc.b	"'display: inline' "
 648  29a4 616374696f6e  	dc.b	"action='%x00http:/"
 649  29b6 2f3139322e31  	dc.b	"/192.168.001.004:0"
 650  29c8 383038302f36  	dc.b	"8080/60' method='g"
 651  29da 6574273e3c62  	dc.b	"et'><button title="
 652  29ec 275361766520  	dc.b	"'Save first! This "
 653  29fe 627574746f6e  	dc.b	"button will not sa"
 654  2a10 766520796f75  	dc.b	"ve your changes'>R"
 655  2a22 656c61792043  	dc.b	"elay Controls</but"
 656  2a34 746f6e3e3c2f  	dc.b	"ton></form><form s"
 657  2a46 74796c653d27  	dc.b	"tyle='display: inl"
 658  2a58 696e65272061  	dc.b	"ine' action='%x00h"
 659  2a6a 747470        	dc.b	"ttp"
 660  2a6d 3a2f2f313932  	dc.b	"://192.168.001.004"
 661  2a7f 3a3038303830  	dc.b	":08080/66' method="
 662  2a91 27676574273e  	dc.b	"'get'><button titl"
 663  2aa3 653d27536176  	dc.b	"e='Save first! Thi"
 664  2ab5 732062757474  	dc.b	"s button will not "
 665  2ac7 736176652079  	dc.b	"save your changes'"
 666  2ad9 3e4e6574776f  	dc.b	">Network Statistic"
 667  2aeb 733c2f627574  	dc.b	"s</button></form><"
 668  2afd 666f726d2073  	dc.b	"form style='displa"
 669  2b0f 793a20696e6c  	dc.b	"y: inline' action="
 670  2b21 272578303068  	dc.b	"'%x00http://192.16"
 671  2b33 382e3030312e  	dc.b	"8.001.004:08080/63"
 672  2b45 27206d657468  	dc.b	"' method='get'><bu"
 673  2b57 74746f6e2074  	dc.b	"tton title='Save f"
 674  2b69 697273        	dc.b	"irs"
 675  2b6c 742120546869  	dc.b	"t! This button wil"
 676  2b7e 6c206e6f7420  	dc.b	"l not save your ch"
 677  2b90 616e67657327  	dc.b	"anges'>Help</butto"
 678  2ba2 6e3e3c2f666f  	dc.b	"n></form></body></"
 679  2bb4 68746d6c3e00  	dc.b	"html>",0
 680  2bba               L12_g_HtmlPageHelp:
 681  2bba 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 682  2bcc 6d6c206c616e  	dc.b	"ml lang='en'><head"
 683  2bde 3e3c7469746c  	dc.b	"><title>Help Page<"
 684  2bf0 2f7469746c65  	dc.b	"/title><style>td {"
 685  2c02 207769647468  	dc.b	" width: 140px; pad"
 686  2c14 64696e673a20  	dc.b	"ding: 0px; }</styl"
 687  2c26 653e3c2f6865  	dc.b	"e></head><body><h1"
 688  2c38 3e48656c7020  	dc.b	">Help Page 1</h1><"
 689  2c4a 70206c696e65  	dc.b	"p line-height 20px"
 690  2c5c 3e416e20616c  	dc.b	">An alternative to"
 691  2c6e 207573696e67  	dc.b	" using the web int"
 692  2c80 657266616365  	dc.b	"erface for changin"
 693  2c92 672072656c61  	dc.b	"g relay states is "
 694  2ca4 746f2073656e  	dc.b	"to send relay<br>s"
 695  2cb6 706563        	dc.b	"pec"
 696  2cb9 696669632068  	dc.b	"ific html commands"
 697  2ccb 2e20456e7465  	dc.b	". Enter http://IP:"
 698  2cdd 506f72742f78  	dc.b	"Port/xx where<br>-"
 699  2cef 204950203d20  	dc.b	" IP = the device I"
 700  2d01 502041646472  	dc.b	"P Address, for exa"
 701  2d13 6d706c652031  	dc.b	"mple 192.168.1.4<b"
 702  2d25 723e2d20506f  	dc.b	"r>- Port = the dev"
 703  2d37 69636520506f  	dc.b	"ice Port number, f"
 704  2d49 6f7220657861  	dc.b	"or example 8080<br"
 705  2d5b 3e2d20787820  	dc.b	">- xx = one of the"
 706  2d6d 20636f646573  	dc.b	" codes below:<br><"
 707  2d7f 7461626c653e  	dc.b	"table><tr><td>00 ="
 708  2d91 2052656c6179  	dc.b	" Relay-01 OFF</td>"
 709  2da3 3c74643e3039  	dc.b	"<td>09 = Relay-05 "
 710  2db5 4f4646        	dc.b	"OFF"
 711  2db8 3c2f74643e3c  	dc.b	"</td><td>17 = Rela"
 712  2dca 792d3039204f  	dc.b	"y-09 OFF</td><td>2"
 713  2ddc 35203d205265  	dc.b	"5 = Relay-13 OFF<b"
 714  2dee 723e3c2f7464  	dc.b	"r></td></tr><tr><t"
 715  2e00 643e3031203d  	dc.b	"d>01 = Relay-01  O"
 716  2e12 4e3c2f74643e  	dc.b	"N</td><td>10 = Rel"
 717  2e24 61792d303520  	dc.b	"ay-05  ON</td><td>"
 718  2e36 3138203d2052  	dc.b	"18 = Relay-09  ON<"
 719  2e48 2f74643e3c74  	dc.b	"/td><td>26 = Relay"
 720  2e5a 2d313320204f  	dc.b	"-13  ON<br></td></"
 721  2e6c 74723e3c7472  	dc.b	"tr><tr><td>02 = Re"
 722  2e7e 6c61792d3032  	dc.b	"lay-02 OFF</td><td"
 723  2e90 3e3131203d20  	dc.b	">11 = Relay-06 OFF"
 724  2ea2 3c2f74643e3c  	dc.b	"</td><td>19 = Rela"
 725  2eb4 792d31        	dc.b	"y-1"
 726  2eb7 30204f46463c  	dc.b	"0 OFF</td><td>27 ="
 727  2ec9 2052656c6179  	dc.b	" Relay-14 OFF<br><"
 728  2edb 2f74643e3c2f  	dc.b	"/td></tr><tr><td>0"
 729  2eed 33203d205265  	dc.b	"3 = Relay-02  ON</"
 730  2eff 74643e3c7464  	dc.b	"td><td>12 = Relay-"
 731  2f11 303620204f4e  	dc.b	"06  ON</td><td>20 "
 732  2f23 3d2052656c61  	dc.b	"= Relay-10  ON</td"
 733  2f35 3e3c74643e32  	dc.b	"><td>28 = Relay-14"
 734  2f47 20204f4e3c62  	dc.b	"  ON<br></td></tr>"
 735  2f59 3c74723e3c74  	dc.b	"<tr><td>04 = Relay"
 736  2f6b 2d3033204f46  	dc.b	"-03 OFF</td><td>13"
 737  2f7d 203d2052656c  	dc.b	" = Relay-07 OFF</t"
 738  2f8f 643e3c74643e  	dc.b	"d><td>21 = Relay-1"
 739  2fa1 31204f46463c  	dc.b	"1 OFF</td><td>29 ="
 740  2fb3 205265        	dc.b	" Re"
 741  2fb6 6c61792d3135  	dc.b	"lay-15 OFF<br></td"
 742  2fc8 3e3c2f74723e  	dc.b	"></tr><tr><td>05 ="
 743  2fda 2052656c6179  	dc.b	" Relay-03  ON</td>"
 744  2fec 3c74643e3134  	dc.b	"<td>14 = Relay-07 "
 745  2ffe 204f4e3c2f74  	dc.b	" ON</td><td>22 = R"
 746  3010 656c61792d31  	dc.b	"elay-11  ON</td><t"
 747  3022 643e3330203d  	dc.b	"d>30 = Relay-15  O"
 748  3034 4e3c62723e3c  	dc.b	"N<br></td></tr><tr"
 749  3046 3e3c74643e30  	dc.b	"><td>07 = Relay-04"
 750  3058 204f46463c2f  	dc.b	" OFF</td><td>15 = "
 751  306a 52656c61792d  	dc.b	"Relay-08 OFF</td><"
 752  307c 74643e323320  	dc.b	"td>23 = Relay-12 O"
 753  308e 46463c2f7464  	dc.b	"FF</td><td>31 = Re"
 754  30a0 6c61792d3136  	dc.b	"lay-16 OFF<br></td"
 755  30b2 3e3c2f        	dc.b	"></"
 756  30b5 74723e3c7472  	dc.b	"tr><tr><td>08 = Re"
 757  30c7 6c61792d3034  	dc.b	"lay-04  ON</td><td"
 758  30d9 3e3136203d20  	dc.b	">16 = Relay-08  ON"
 759  30eb 3c2f74643e3c  	dc.b	"</td><td>24 = Rela"
 760  30fd 792d31322020  	dc.b	"y-12  ON</td><td>3"
 761  310f 32203d205265  	dc.b	"2 = Relay-16  ON<b"
 762  3121 723e3c2f7464  	dc.b	"r></td></tr></tabl"
 763  3133 653e3535203d  	dc.b	"e>55 = All Relays "
 764  3145 4f4e3c62723e  	dc.b	"ON<br>56 = All Rel"
 765  3157 617973204f46  	dc.b	"ays OFF<br><br>The"
 766  3169 20666f6c6c6f  	dc.b	" following are als"
 767  317b 6f2061766169  	dc.b	"o available:<br>60"
 768  318d 203d2053686f  	dc.b	" = Show Relay Cont"
 769  319f 726f6c207061  	dc.b	"rol page<br>61 = S"
 770  31b1 686f77        	dc.b	"how"
 771  31b4 204164647265  	dc.b	" Address Settings "
 772  31c6 706167653c62  	dc.b	"page<br>63 = Show "
 773  31d8 48656c702050  	dc.b	"Help Page 1<br>64 "
 774  31ea 3d2053686f77  	dc.b	"= Show Help Page 2"
 775  31fc 3c62723e3635  	dc.b	"<br>65 = Flash LED"
 776  320e 3c62723e3636  	dc.b	"<br>66 = Show Stat"
 777  3220 697374696373  	dc.b	"istics<br>91 = Reb"
 778  3232 6f6f743c6272  	dc.b	"oot<br>99 = Show S"
 779  3244 686f72742046  	dc.b	"hort Form Relay Se"
 780  3256 7474696e6773  	dc.b	"ttings<br></p><for"
 781  3268 6d207374796c  	dc.b	"m style='display: "
 782  327a 696e6c696e65  	dc.b	"inline' action='%x"
 783  328c 303068747470  	dc.b	"00http://192.168.0"
 784  329e 30312e303034  	dc.b	"01.004:08080/64' m"
 785  32b0 657468        	dc.b	"eth"
 786  32b3 6f643d276765  	dc.b	"od='get'><button t"
 787  32c5 69746c653d27  	dc.b	"itle='Go to next H"
 788  32d7 656c70207061  	dc.b	"elp page'>Next Hel"
 789  32e9 702050616765  	dc.b	"p Page</button></f"
 790  32fb 6f726d3e3c2f  	dc.b	"orm></body></html>",0
 791  330e               L32_g_HtmlPageHelp2:
 792  330e 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 793  3320 6d6c206c616e  	dc.b	"ml lang='en'><head"
 794  3332 3e3c7469746c  	dc.b	"><title>Help Page "
 795  3344 323c2f746974  	dc.b	"2</title><style></"
 796  3356 7374796c653e  	dc.b	"style></head><body"
 797  3368 3e3c68313e48  	dc.b	"><h1>Help Page 2</"
 798  337a 68313e3c7020  	dc.b	"h1><p line-height "
 799  338c 323070783e49  	dc.b	"20px>IP Address, G"
 800  339e 617465776179  	dc.b	"ateway Address, Ne"
 801  33b0 746d61736b2c  	dc.b	"tmask, Port, and M"
 802  33c2 414320416464  	dc.b	"AC Address can onl"
 803  33d4 792062653c62  	dc.b	"y be<br>changed vi"
 804  33e6 612074686520  	dc.b	"a the web interfac"
 805  33f8 652e20496620  	dc.b	"e. If the device b"
 806  340a 65636f        	dc.b	"eco"
 807  340d 6d657320696e  	dc.b	"mes inaccessible y"
 808  341f 6f752063616e  	dc.b	"ou can<br>reset to"
 809  3431 20666163746f  	dc.b	" factory defaults "
 810  3443 627920686f6c  	dc.b	"by holding the res"
 811  3455 657420627574  	dc.b	"et button down for"
 812  3467 203130207365  	dc.b	" 10 seconds.<br>De"
 813  3479 6661756c7473  	dc.b	"faults:<br> IP 192"
 814  348b 2e3136382e31  	dc.b	".168.1.4<br> Gatew"
 815  349d 617920313932  	dc.b	"ay 192.168.1.1<br>"
 816  34af 204e65746d61  	dc.b	" Netmask 255.255.2"
 817  34c1 35352e303c62  	dc.b	"55.0<br> Port 0808"
 818  34d3 303c62723e20  	dc.b	"0<br> MAC c2-4d-69"
 819  34e5 2d36622d3635  	dc.b	"-6b-65-00<br><br>C"
 820  34f7 6f6465205265  	dc.b	"ode Revision 20200"
 821  3509 363137        	dc.b	"617"
 822  350c 20323131303c  	dc.b	" 2110</p><form sty"
 823  351e 6c653d276469  	dc.b	"le='display: inlin"
 824  3530 652720616374  	dc.b	"e' action='%x00htt"
 825  3542 703a2f2f3139  	dc.b	"p://192.168.001.00"
 826  3554 343a30383038  	dc.b	"4:08080/60' method"
 827  3566 3d2767657427  	dc.b	"='get'><button tit"
 828  3578 6c653d27476f  	dc.b	"le='Go to Relay Co"
 829  358a 6e74726f6c20  	dc.b	"ntrol Page'>Relay "
 830  359c 436f6e74726f  	dc.b	"Controls</button><"
 831  35ae 2f666f726d3e  	dc.b	"/form></body></htm"
 832  35c0 6c3e00        	dc.b	"l>",0
 833  35c3               L52_g_HtmlPageStats:
 834  35c3 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 835  35d5 6d6c206c616e  	dc.b	"ml lang='en'><head"
 836  35e7 3e3c7469746c  	dc.b	"><title>Network St"
 837  35f9 617469737469  	dc.b	"atistics</title><s"
 838  360b 74796c653e2e  	dc.b	"tyle>.t1class { wi"
 839  361d 6474683a2031  	dc.b	"dth: 100px; }.t2cl"
 840  362f 617373207b20  	dc.b	"ass { width: 450px"
 841  3641 3b207d746420  	dc.b	"; }td { border: 1p"
 842  3653 7820626c6163  	dc.b	"x black solid; }</"
 843  3665 7374796c653e  	dc.b	"style></head><body"
 844  3677 3e3c68313e4e  	dc.b	"><h1>Network Stati"
 845  3689 73746963733c  	dc.b	"stics</h1><p>Value"
 846  369b 732073686f77  	dc.b	"s shown are since "
 847  36ad 6c6173742070  	dc.b	"last power on or r"
 848  36bf 657365        	dc.b	"ese"
 849  36c2 743c2f703e3c  	dc.b	"t</p><table><tr><t"
 850  36d4 6420636c6173  	dc.b	"d class='t1class'>"
 851  36e6 256530307878  	dc.b	"%e00xxxxxxxxxx</td"
 852  36f8 3e3c74642063  	dc.b	"><td class='t2clas"
 853  370a 73273e44726f  	dc.b	"s'>Dropped packets"
 854  371c 206174207468  	dc.b	" at the IP layer</"
 855  372e 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
 856  3740 6173733d2774  	dc.b	"ass='t1class'>%e01"
 857  3752 787878787878  	dc.b	"xxxxxxxxxx</td><td"
 858  3764 20636c617373  	dc.b	" class='t2class'>R"
 859  3776 656365697665  	dc.b	"eceived packets at"
 860  3788 207468652049  	dc.b	" the IP layer</td>"
 861  379a 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 862  37ac 3d277431636c  	dc.b	"='t1class'>%e02xxx"
 863  37be 787878        	dc.b	"xxx"
 864  37c1 787878783c2f  	dc.b	"xxxx</td><td class"
 865  37d3 3d277432636c  	dc.b	"='t2class'>Sent pa"
 866  37e5 636b65747320  	dc.b	"ckets at the IP la"
 867  37f7 7965723c2f74  	dc.b	"yer</td></tr><tr><"
 868  3809 746420636c61  	dc.b	"td class='t1class'"
 869  381b 3e2565303378  	dc.b	">%e03xxxxxxxxxx</t"
 870  382d 643e3c746420  	dc.b	"d><td class='t2cla"
 871  383f 7373273e5061  	dc.b	"ss'>Packets droppe"
 872  3851 642064756520  	dc.b	"d due to wrong IP "
 873  3863 76657273696f  	dc.b	"version or header "
 874  3875 6c656e677468  	dc.b	"length</td></tr><t"
 875  3887 723e3c746420  	dc.b	"r><td class='t1cla"
 876  3899 7373273e2565  	dc.b	"ss'>%e04xxxxxxxxxx"
 877  38ab 3c2f74643e3c  	dc.b	"</td><td class='t2"
 878  38bd 636c61        	dc.b	"cla"
 879  38c0 7373273e5061  	dc.b	"ss'>Packets droppe"
 880  38d2 642064756520  	dc.b	"d due to wrong IP "
 881  38e4 6c656e677468  	dc.b	"length, high byte<"
 882  38f6 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 883  3908 6c6173733d27  	dc.b	"lass='t1class'>%e0"
 884  391a 357878787878  	dc.b	"5xxxxxxxxxx</td><t"
 885  392c 6420636c6173  	dc.b	"d class='t2class'>"
 886  393e 5061636b6574  	dc.b	"Packets dropped du"
 887  3950 6520746f2077  	dc.b	"e to wrong IP leng"
 888  3962 74682c206c6f  	dc.b	"th, low byte</td><"
 889  3974 2f74723e3c74  	dc.b	"/tr><tr><td class="
 890  3986 277431636c61  	dc.b	"'t1class'>%e06xxxx"
 891  3998 787878787878  	dc.b	"xxxxxx</td><td cla"
 892  39aa 73733d277432  	dc.b	"ss='t2class'>Packe"
 893  39bc 747320        	dc.b	"ts "
 894  39bf 64726f707065  	dc.b	"dropped since they"
 895  39d1 207765726520  	dc.b	" were IP fragments"
 896  39e3 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 897  39f5 636c6173733d  	dc.b	"class='t1class'>%e"
 898  3a07 303778787878  	dc.b	"07xxxxxxxxxx</td><"
 899  3a19 746420636c61  	dc.b	"td class='t2class'"
 900  3a2b 3e5061636b65  	dc.b	">Packets dropped d"
 901  3a3d 756520746f20  	dc.b	"ue to IP checksum "
 902  3a4f 6572726f7273  	dc.b	"errors</td></tr><t"
 903  3a61 723e3c746420  	dc.b	"r><td class='t1cla"
 904  3a73 7373273e2565  	dc.b	"ss'>%e08xxxxxxxxxx"
 905  3a85 3c2f74643e3c  	dc.b	"</td><td class='t2"
 906  3a97 636c61737327  	dc.b	"class'>Packets dro"
 907  3aa9 707065642073  	dc.b	"pped since they we"
 908  3abb 726520        	dc.b	"re "
 909  3abe 6e6f74204943  	dc.b	"not ICMP or TCP</t"
 910  3ad0 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
 911  3ae2 73733d277431  	dc.b	"ss='t1class'>%e09x"
 912  3af4 787878787878  	dc.b	"xxxxxxxxx</td><td "
 913  3b06 636c6173733d  	dc.b	"class='t2class'>Dr"
 914  3b18 6f7070656420  	dc.b	"opped ICMP packets"
 915  3b2a 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 916  3b3c 636c6173733d  	dc.b	"class='t1class'>%e"
 917  3b4e 313078787878  	dc.b	"10xxxxxxxxxx</td><"
 918  3b60 746420636c61  	dc.b	"td class='t2class'"
 919  3b72 3e5265636569  	dc.b	">Received ICMP pac"
 920  3b84 6b6574733c2f  	dc.b	"kets</td></tr><tr>"
 921  3b96 3c746420636c  	dc.b	"<td class='t1class"
 922  3ba8 273e25653131  	dc.b	"'>%e11xxxxxxxxxx</"
 923  3bba 74643e        	dc.b	"td>"
 924  3bbd 3c746420636c  	dc.b	"<td class='t2class"
 925  3bcf 273e53656e74  	dc.b	"'>Sent ICMP packet"
 926  3be1 733c2f74643e  	dc.b	"s</td></tr><tr><td"
 927  3bf3 20636c617373  	dc.b	" class='t1class'>%"
 928  3c05 653132787878  	dc.b	"e12xxxxxxxxxx</td>"
 929  3c17 3c746420636c  	dc.b	"<td class='t2class"
 930  3c29 273e49434d50  	dc.b	"'>ICMP packets wit"
 931  3c3b 682061207772  	dc.b	"h a wrong type</td"
 932  3c4d 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 933  3c5f 733d27743163  	dc.b	"s='t1class'>%e13xx"
 934  3c71 787878787878  	dc.b	"xxxxxxxx</td><td c"
 935  3c83 6c6173733d27  	dc.b	"lass='t2class'>Dro"
 936  3c95 707065642054  	dc.b	"pped TCP segments<"
 937  3ca7 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 938  3cb9 6c6173        	dc.b	"las"
 939  3cbc 733d27743163  	dc.b	"s='t1class'>%e14xx"
 940  3cce 787878787878  	dc.b	"xxxxxxxx</td><td c"
 941  3ce0 6c6173733d27  	dc.b	"lass='t2class'>Rec"
 942  3cf2 656976656420  	dc.b	"eived TCP segments"
 943  3d04 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 944  3d16 636c6173733d  	dc.b	"class='t1class'>%e"
 945  3d28 313578787878  	dc.b	"15xxxxxxxxxx</td><"
 946  3d3a 746420636c61  	dc.b	"td class='t2class'"
 947  3d4c 3e53656e7420  	dc.b	">Sent TCP segments"
 948  3d5e 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 949  3d70 636c6173733d  	dc.b	"class='t1class'>%e"
 950  3d82 313678787878  	dc.b	"16xxxxxxxxxx</td><"
 951  3d94 746420636c61  	dc.b	"td class='t2class'"
 952  3da6 3e5443502073  	dc.b	">TCP segments with"
 953  3db8 206120        	dc.b	" a "
 954  3dbb 626164206368  	dc.b	"bad checksum</td><"
 955  3dcd 2f74723e3c74  	dc.b	"/tr><tr><td class="
 956  3ddf 277431636c61  	dc.b	"'t1class'>%e17xxxx"
 957  3df1 787878787878  	dc.b	"xxxxxx</td><td cla"
 958  3e03 73733d277432  	dc.b	"ss='t2class'>TCP s"
 959  3e15 65676d656e74  	dc.b	"egments with a bad"
 960  3e27 2041434b206e  	dc.b	" ACK number</td></"
 961  3e39 74723e3c7472  	dc.b	"tr><tr><td class='"
 962  3e4b 7431636c6173  	dc.b	"t1class'>%e18xxxxx"
 963  3e5d 78787878783c  	dc.b	"xxxxx</td><td clas"
 964  3e6f 733d27743263  	dc.b	"s='t2class'>Receiv"
 965  3e81 656420544350  	dc.b	"ed TCP RST (reset)"
 966  3e93 207365676d65  	dc.b	" segments</td></tr"
 967  3ea5 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 968  3eb7 636c61        	dc.b	"cla"
 969  3eba 7373273e2565  	dc.b	"ss'>%e19xxxxxxxxxx"
 970  3ecc 3c2f74643e3c  	dc.b	"</td><td class='t2"
 971  3ede 636c61737327  	dc.b	"class'>Retransmitt"
 972  3ef0 656420544350  	dc.b	"ed TCP segments</t"
 973  3f02 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
 974  3f14 73733d277431  	dc.b	"ss='t1class'>%e20x"
 975  3f26 787878787878  	dc.b	"xxxxxxxxx</td><td "
 976  3f38 636c6173733d  	dc.b	"class='t2class'>Dr"
 977  3f4a 6f7070656420  	dc.b	"opped SYNs due to "
 978  3f5c 746f6f206665  	dc.b	"too few connection"
 979  3f6e 73206176616c  	dc.b	"s avaliable</td></"
 980  3f80 74723e3c7472  	dc.b	"tr><tr><td class='"
 981  3f92 7431636c6173  	dc.b	"t1class'>%e21xxxxx"
 982  3fa4 78787878783c  	dc.b	"xxxxx</td><td clas"
 983  3fb6 733d27        	dc.b	"s='"
 984  3fb9 7432636c6173  	dc.b	"t2class'>SYNs for "
 985  3fcb 636c6f736564  	dc.b	"closed ports, trig"
 986  3fdd 676572696e67  	dc.b	"gering a RST</td><"
 987  3fef 2f74723e3c2f  	dc.b	"/tr></table><form "
 988  4001 7374796c653d  	dc.b	"style='display: in"
 989  4013 6c696e652720  	dc.b	"line' action='%x00"
 990  4025 687474703a2f  	dc.b	"http://192.168.001"
 991  4037 2e3030343a30  	dc.b	".004:08080/60' met"
 992  4049 686f643d2767  	dc.b	"hod='get'><button "
 993  405b 7469746c653d  	dc.b	"title='Go to Relay"
 994  406d 20436f6e7472  	dc.b	" Control Page'>Rel"
 995  407f 617920436f6e  	dc.b	"ay Controls</butto"
 996  4091 6e3e3c2f666f  	dc.b	"n></form></body></"
 997  40a3 68746d6c3e00  	dc.b	"html>",0
 998  40a9               L72_g_HtmlPageRstate:
 999  40a9 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
1000  40bb 6d6c206c616e  	dc.b	"ml lang='en'><head"
1001  40cd 3e3c7469746c  	dc.b	"><title>Help Page "
1002  40df 323c2f746974  	dc.b	"2</title><style></"
1003  40f1 7374796c653e  	dc.b	"style></head><body"
1004  4103 3e3c703e2566  	dc.b	"><p>%f00xxxxxxxxxx"
1005  4115 787878787878  	dc.b	"xxxxxx</p></body><"
1006  4127 2f68746d6c3e  	dc.b	"/html>",0
1072                     ; 484 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1072                     ; 485 {
1074                     	switch	.text
1075  0000               L3_CopyStringP:
1077  0000 89            	pushw	x
1078  0001 5203          	subw	sp,#3
1079       00000003      OFST:	set	3
1082                     ; 490   nBytes = 0;
1084  0003 5f            	clrw	x
1086  0004 2014          	jra	L17
1087  0006               L56:
1088                     ; 492     **ppBuffer = Character;
1090  0006 1e04          	ldw	x,(OFST+1,sp)
1091  0008 fe            	ldw	x,(x)
1092  0009 f7            	ld	(x),a
1093                     ; 493     *ppBuffer = *ppBuffer + 1;
1095  000a 1e04          	ldw	x,(OFST+1,sp)
1096  000c 9093          	ldw	y,x
1097  000e fe            	ldw	x,(x)
1098  000f 5c            	incw	x
1099  0010 90ff          	ldw	(y),x
1100                     ; 494     pString = pString + 1;
1102  0012 1e08          	ldw	x,(OFST+5,sp)
1103  0014 5c            	incw	x
1104  0015 1f08          	ldw	(OFST+5,sp),x
1105                     ; 495     nBytes++;
1107  0017 1e01          	ldw	x,(OFST-2,sp)
1108  0019 5c            	incw	x
1109  001a               L17:
1110  001a 1f01          	ldw	(OFST-2,sp),x
1112                     ; 491   while ((Character = pString[0]) != '\0') {
1112                     ; 492     **ppBuffer = Character;
1112                     ; 493     *ppBuffer = *ppBuffer + 1;
1112                     ; 494     pString = pString + 1;
1112                     ; 495     nBytes++;
1114  001c 1e08          	ldw	x,(OFST+5,sp)
1115  001e f6            	ld	a,(x)
1116  001f 6b03          	ld	(OFST+0,sp),a
1118  0021 26e3          	jrne	L56
1119                     ; 497   return nBytes;
1121  0023 1e01          	ldw	x,(OFST-2,sp)
1124  0025 5b05          	addw	sp,#5
1125  0027 81            	ret	
1170                     ; 501 static uint16_t CopyValue(uint8_t** ppBuffer, uint32_t nValue)
1170                     ; 502 {
1171                     	switch	.text
1172  0028               L5_CopyValue:
1174  0028 89            	pushw	x
1175       00000000      OFST:	set	0
1178                     ; 510   emb_itoa(nValue, OctetArray, 10, 5);
1180  0029 4b05          	push	#5
1181  002b 4b0a          	push	#10
1182  002d ae0000        	ldw	x,#_OctetArray
1183  0030 89            	pushw	x
1184  0031 1e0b          	ldw	x,(OFST+11,sp)
1185  0033 89            	pushw	x
1186  0034 1e0b          	ldw	x,(OFST+11,sp)
1187  0036 89            	pushw	x
1188  0037 ad53          	call	_emb_itoa
1190  0039 5b08          	addw	sp,#8
1191                     ; 512   **ppBuffer = OctetArray[0];
1193  003b 1e01          	ldw	x,(OFST+1,sp)
1194  003d fe            	ldw	x,(x)
1195  003e c60000        	ld	a,_OctetArray
1196  0041 f7            	ld	(x),a
1197                     ; 513   *ppBuffer = *ppBuffer + 1;
1199  0042 1e01          	ldw	x,(OFST+1,sp)
1200  0044 9093          	ldw	y,x
1201  0046 fe            	ldw	x,(x)
1202  0047 5c            	incw	x
1203  0048 90ff          	ldw	(y),x
1204                     ; 515   **ppBuffer = OctetArray[1];
1206  004a 1e01          	ldw	x,(OFST+1,sp)
1207  004c fe            	ldw	x,(x)
1208  004d c60001        	ld	a,_OctetArray+1
1209  0050 f7            	ld	(x),a
1210                     ; 516   *ppBuffer = *ppBuffer + 1;
1212  0051 1e01          	ldw	x,(OFST+1,sp)
1213  0053 9093          	ldw	y,x
1214  0055 fe            	ldw	x,(x)
1215  0056 5c            	incw	x
1216  0057 90ff          	ldw	(y),x
1217                     ; 518   **ppBuffer = OctetArray[2];
1219  0059 1e01          	ldw	x,(OFST+1,sp)
1220  005b fe            	ldw	x,(x)
1221  005c c60002        	ld	a,_OctetArray+2
1222  005f f7            	ld	(x),a
1223                     ; 519   *ppBuffer = *ppBuffer + 1;
1225  0060 1e01          	ldw	x,(OFST+1,sp)
1226  0062 9093          	ldw	y,x
1227  0064 fe            	ldw	x,(x)
1228  0065 5c            	incw	x
1229  0066 90ff          	ldw	(y),x
1230                     ; 521   **ppBuffer = OctetArray[3];
1232  0068 1e01          	ldw	x,(OFST+1,sp)
1233  006a fe            	ldw	x,(x)
1234  006b c60003        	ld	a,_OctetArray+3
1235  006e f7            	ld	(x),a
1236                     ; 522   *ppBuffer = *ppBuffer + 1;
1238  006f 1e01          	ldw	x,(OFST+1,sp)
1239  0071 9093          	ldw	y,x
1240  0073 fe            	ldw	x,(x)
1241  0074 5c            	incw	x
1242  0075 90ff          	ldw	(y),x
1243                     ; 524   **ppBuffer = OctetArray[4];
1245  0077 1e01          	ldw	x,(OFST+1,sp)
1246  0079 fe            	ldw	x,(x)
1247  007a c60004        	ld	a,_OctetArray+4
1248  007d f7            	ld	(x),a
1249                     ; 525   *ppBuffer = *ppBuffer + 1;
1251  007e 1e01          	ldw	x,(OFST+1,sp)
1252  0080 9093          	ldw	y,x
1253  0082 fe            	ldw	x,(x)
1254  0083 5c            	incw	x
1255  0084 90ff          	ldw	(y),x
1256                     ; 527   return 5;
1258  0086 ae0005        	ldw	x,#5
1261  0089 5b02          	addw	sp,#2
1262  008b 81            	ret	
1334                     ; 531 char* emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
1334                     ; 532 {
1335                     	switch	.text
1336  008c               _emb_itoa:
1338  008c 5206          	subw	sp,#6
1339       00000006      OFST:	set	6
1342                     ; 547   for (i=0; i < 10; i++) str[i] = '0';
1344  008e 4f            	clr	a
1345  008f 6b06          	ld	(OFST+0,sp),a
1347  0091               L541:
1350  0091 5f            	clrw	x
1351  0092 97            	ld	xl,a
1352  0093 72fb0d        	addw	x,(OFST+7,sp)
1353  0096 a630          	ld	a,#48
1354  0098 f7            	ld	(x),a
1357  0099 0c06          	inc	(OFST+0,sp)
1361  009b 7b06          	ld	a,(OFST+0,sp)
1362  009d a10a          	cp	a,#10
1363  009f 25f0          	jrult	L541
1364                     ; 548   str[pad] = '\0';
1366  00a1 7b10          	ld	a,(OFST+10,sp)
1367  00a3 5f            	clrw	x
1368  00a4 97            	ld	xl,a
1369  00a5 72fb0d        	addw	x,(OFST+7,sp)
1370  00a8 7f            	clr	(x)
1371                     ; 549   if (num == 0) return str;
1373  00a9 96            	ldw	x,sp
1374  00aa 1c0009        	addw	x,#OFST+3
1375  00ad cd0000        	call	c_lzmp
1379  00b0 2775          	jreq	L61
1380                     ; 552   i = 0;
1382  00b2 0f06          	clr	(OFST+0,sp)
1385  00b4 2060          	jra	L161
1386  00b6               L551:
1387                     ; 554     rem = (uint8_t)(num % base);
1389  00b6 7b0f          	ld	a,(OFST+9,sp)
1390  00b8 b703          	ld	c_lreg+3,a
1391  00ba 3f02          	clr	c_lreg+2
1392  00bc 3f01          	clr	c_lreg+1
1393  00be 3f00          	clr	c_lreg
1394  00c0 96            	ldw	x,sp
1395  00c1 5c            	incw	x
1396  00c2 cd0000        	call	c_rtol
1399  00c5 96            	ldw	x,sp
1400  00c6 1c0009        	addw	x,#OFST+3
1401  00c9 cd0000        	call	c_ltor
1403  00cc 96            	ldw	x,sp
1404  00cd 5c            	incw	x
1405  00ce cd0000        	call	c_lumd
1407  00d1 b603          	ld	a,c_lreg+3
1408  00d3 6b05          	ld	(OFST-1,sp),a
1410                     ; 555     if(rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
1412  00d5 a10a          	cp	a,#10
1413  00d7 7b06          	ld	a,(OFST+0,sp)
1414  00d9 250d          	jrult	L561
1417  00db 0c06          	inc	(OFST+0,sp)
1419  00dd 5f            	clrw	x
1420  00de 97            	ld	xl,a
1421  00df 72fb0d        	addw	x,(OFST+7,sp)
1422  00e2 7b05          	ld	a,(OFST-1,sp)
1423  00e4 ab57          	add	a,#87
1425  00e6 200b          	jra	L761
1426  00e8               L561:
1427                     ; 556     else str[i++] = (uint8_t)(rem + '0');
1429  00e8 0c06          	inc	(OFST+0,sp)
1431  00ea 5f            	clrw	x
1432  00eb 97            	ld	xl,a
1433  00ec 72fb0d        	addw	x,(OFST+7,sp)
1434  00ef 7b05          	ld	a,(OFST-1,sp)
1435  00f1 ab30          	add	a,#48
1436  00f3               L761:
1437  00f3 f7            	ld	(x),a
1438                     ; 557     num = num/base;
1440  00f4 7b0f          	ld	a,(OFST+9,sp)
1441  00f6 b703          	ld	c_lreg+3,a
1442  00f8 3f02          	clr	c_lreg+2
1443  00fa 3f01          	clr	c_lreg+1
1444  00fc 3f00          	clr	c_lreg
1445  00fe 96            	ldw	x,sp
1446  00ff 5c            	incw	x
1447  0100 cd0000        	call	c_rtol
1450  0103 96            	ldw	x,sp
1451  0104 1c0009        	addw	x,#OFST+3
1452  0107 cd0000        	call	c_ltor
1454  010a 96            	ldw	x,sp
1455  010b 5c            	incw	x
1456  010c cd0000        	call	c_ludv
1458  010f 96            	ldw	x,sp
1459  0110 1c0009        	addw	x,#OFST+3
1460  0113 cd0000        	call	c_rtol
1462  0116               L161:
1463                     ; 553   while (num != 0) {
1465  0116 96            	ldw	x,sp
1466  0117 1c0009        	addw	x,#OFST+3
1467  011a cd0000        	call	c_lzmp
1469  011d 2697          	jrne	L551
1470                     ; 561   reverse(str, pad);
1472  011f 7b10          	ld	a,(OFST+10,sp)
1473  0121 88            	push	a
1474  0122 1e0e          	ldw	x,(OFST+8,sp)
1475  0124 ad06          	call	_reverse
1477  0126 84            	pop	a
1478                     ; 563   return str;
1481  0127               L61:
1483  0127 1e0d          	ldw	x,(OFST+7,sp)
1485  0129 5b06          	addw	sp,#6
1486  012b 81            	ret	
1549                     ; 568 void reverse(char str[], uint8_t length)
1549                     ; 569 {
1550                     	switch	.text
1551  012c               _reverse:
1553  012c 89            	pushw	x
1554  012d 5203          	subw	sp,#3
1555       00000003      OFST:	set	3
1558                     ; 574   start = 0;
1560  012f 0f02          	clr	(OFST-1,sp)
1562                     ; 575   end = (uint8_t)(length - 1);
1564  0131 7b08          	ld	a,(OFST+5,sp)
1565  0133 4a            	dec	a
1566  0134 6b03          	ld	(OFST+0,sp),a
1569  0136 2029          	jra	L322
1570  0138               L712:
1571                     ; 578     temp = str[start];
1573  0138 5f            	clrw	x
1574  0139 97            	ld	xl,a
1575  013a 72fb04        	addw	x,(OFST+1,sp)
1576  013d f6            	ld	a,(x)
1577  013e 6b01          	ld	(OFST-2,sp),a
1579                     ; 579     str[start] = str[end];
1581  0140 5f            	clrw	x
1582  0141 7b02          	ld	a,(OFST-1,sp)
1583  0143 97            	ld	xl,a
1584  0144 72fb04        	addw	x,(OFST+1,sp)
1585  0147 7b03          	ld	a,(OFST+0,sp)
1586  0149 905f          	clrw	y
1587  014b 9097          	ld	yl,a
1588  014d 72f904        	addw	y,(OFST+1,sp)
1589  0150 90f6          	ld	a,(y)
1590  0152 f7            	ld	(x),a
1591                     ; 580     str[end] = temp;
1593  0153 5f            	clrw	x
1594  0154 7b03          	ld	a,(OFST+0,sp)
1595  0156 97            	ld	xl,a
1596  0157 72fb04        	addw	x,(OFST+1,sp)
1597  015a 7b01          	ld	a,(OFST-2,sp)
1598  015c f7            	ld	(x),a
1599                     ; 581     start++;
1601  015d 0c02          	inc	(OFST-1,sp)
1603                     ; 582     end--;
1605  015f 0a03          	dec	(OFST+0,sp)
1607  0161               L322:
1608                     ; 577   while (start < end) {
1608                     ; 578     temp = str[start];
1608                     ; 579     str[start] = str[end];
1608                     ; 580     str[end] = temp;
1608                     ; 581     start++;
1608                     ; 582     end--;
1610  0161 7b02          	ld	a,(OFST-1,sp)
1611  0163 1103          	cp	a,(OFST+0,sp)
1612  0165 25d1          	jrult	L712
1613                     ; 584 }
1616  0167 5b05          	addw	sp,#5
1617  0169 81            	ret	
1678                     ; 587 uint8_t three_alpha_to_uint(uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
1678                     ; 588 {
1679                     	switch	.text
1680  016a               _three_alpha_to_uint:
1682  016a 89            	pushw	x
1683  016b 89            	pushw	x
1684       00000002      OFST:	set	2
1687                     ; 596   value = (uint8_t)((alpha1 - '0') *100);
1689  016c 9e            	ld	a,xh
1690  016d 97            	ld	xl,a
1691  016e a664          	ld	a,#100
1692  0170 42            	mul	x,a
1693  0171 9f            	ld	a,xl
1694  0172 a0c0          	sub	a,#192
1695  0174 6b02          	ld	(OFST+0,sp),a
1697                     ; 597   digit = (uint8_t)((alpha2 - '0') * 10);
1699  0176 7b04          	ld	a,(OFST+2,sp)
1700  0178 97            	ld	xl,a
1701  0179 a60a          	ld	a,#10
1702  017b 42            	mul	x,a
1703  017c 9f            	ld	a,xl
1704  017d a0e0          	sub	a,#224
1706                     ; 598   value = (uint8_t)(value + digit);
1708  017f 1b02          	add	a,(OFST+0,sp)
1709  0181 6b02          	ld	(OFST+0,sp),a
1711                     ; 599   digit = (uint8_t)(alpha3 - '0');
1713  0183 7b07          	ld	a,(OFST+5,sp)
1714  0185 a030          	sub	a,#48
1715  0187 6b01          	ld	(OFST-1,sp),a
1717                     ; 600   value = (uint8_t)(value + digit);
1719  0189 1b02          	add	a,(OFST+0,sp)
1721                     ; 602   if(value >= 255) value = 0;
1723  018b a1ff          	cp	a,#255
1724  018d 2501          	jrult	L352
1727  018f 4f            	clr	a
1729  0190               L352:
1730                     ; 604   return value;
1734  0190 5b04          	addw	sp,#4
1735  0192 81            	ret	
1781                     ; 608 uint8_t two_alpha_to_uint(uint8_t alpha1, uint8_t alpha2)
1781                     ; 609 {
1782                     	switch	.text
1783  0193               _two_alpha_to_uint:
1785  0193 89            	pushw	x
1786  0194 88            	push	a
1787       00000001      OFST:	set	1
1790                     ; 616   if (alpha1 >= '0' && alpha1 <= '9') value = (uint8_t)((alpha1 - '0') << 4);
1792  0195 9e            	ld	a,xh
1793  0196 a130          	cp	a,#48
1794  0198 250f          	jrult	L572
1796  019a 9e            	ld	a,xh
1797  019b a13a          	cp	a,#58
1798  019d 240a          	jruge	L572
1801  019f 9e            	ld	a,xh
1802  01a0 97            	ld	xl,a
1803  01a1 a610          	ld	a,#16
1804  01a3 42            	mul	x,a
1805  01a4 9f            	ld	a,xl
1806  01a5 a000          	sub	a,#0
1808  01a7 2030          	jp	LC001
1809  01a9               L572:
1810                     ; 617   else if(alpha1 == 'a') value = 0xa0;
1812  01a9 7b02          	ld	a,(OFST+1,sp)
1813  01ab a161          	cp	a,#97
1814  01ad 2604          	jrne	L103
1817  01af a6a0          	ld	a,#160
1819  01b1 2026          	jp	LC001
1820  01b3               L103:
1821                     ; 618   else if(alpha1 == 'b') value = 0xb0;
1823  01b3 a162          	cp	a,#98
1824  01b5 2604          	jrne	L503
1827  01b7 a6b0          	ld	a,#176
1829  01b9 201e          	jp	LC001
1830  01bb               L503:
1831                     ; 619   else if(alpha1 == 'c') value = 0xc0;
1833  01bb a163          	cp	a,#99
1834  01bd 2604          	jrne	L113
1837  01bf a6c0          	ld	a,#192
1839  01c1 2016          	jp	LC001
1840  01c3               L113:
1841                     ; 620   else if(alpha1 == 'd') value = 0xd0;
1843  01c3 a164          	cp	a,#100
1844  01c5 2604          	jrne	L513
1847  01c7 a6d0          	ld	a,#208
1849  01c9 200e          	jp	LC001
1850  01cb               L513:
1851                     ; 621   else if(alpha1 == 'e') value = 0xe0;
1853  01cb a165          	cp	a,#101
1854  01cd 2604          	jrne	L123
1857  01cf a6e0          	ld	a,#224
1859  01d1 2006          	jp	LC001
1860  01d3               L123:
1861                     ; 622   else if(alpha1 == 'f') value = 0xf0;
1863  01d3 a166          	cp	a,#102
1864  01d5 2606          	jrne	L523
1867  01d7 a6f0          	ld	a,#240
1868  01d9               LC001:
1869  01d9 6b01          	ld	(OFST+0,sp),a
1872  01db 2002          	jra	L772
1873  01dd               L523:
1874                     ; 623   else value = 0; // If an invalid entry is made convert it to 0
1876  01dd 0f01          	clr	(OFST+0,sp)
1878  01df               L772:
1879                     ; 625   if (alpha2 >= '0' && alpha2 <= '9') value = (uint8_t)(value + alpha2 - '0');
1881  01df 7b03          	ld	a,(OFST+2,sp)
1882  01e1 a130          	cp	a,#48
1883  01e3 250c          	jrult	L133
1885  01e5 a13a          	cp	a,#58
1886  01e7 2408          	jruge	L133
1889  01e9 7b01          	ld	a,(OFST+0,sp)
1890  01eb 1b03          	add	a,(OFST+2,sp)
1891  01ed a030          	sub	a,#48
1893  01ef 203d          	jp	L333
1894  01f1               L133:
1895                     ; 626   else if(alpha2 == 'a') value = (uint8_t)(value + 0x0a);
1897  01f1 a161          	cp	a,#97
1898  01f3 2606          	jrne	L533
1901  01f5 7b01          	ld	a,(OFST+0,sp)
1902  01f7 ab0a          	add	a,#10
1904  01f9 2033          	jp	L333
1905  01fb               L533:
1906                     ; 627   else if(alpha2 == 'b') value = (uint8_t)(value + 0x0b);
1908  01fb a162          	cp	a,#98
1909  01fd 2606          	jrne	L143
1912  01ff 7b01          	ld	a,(OFST+0,sp)
1913  0201 ab0b          	add	a,#11
1915  0203 2029          	jp	L333
1916  0205               L143:
1917                     ; 628   else if(alpha2 == 'c') value = (uint8_t)(value + 0x0c);
1919  0205 a163          	cp	a,#99
1920  0207 2606          	jrne	L543
1923  0209 7b01          	ld	a,(OFST+0,sp)
1924  020b ab0c          	add	a,#12
1926  020d 201f          	jp	L333
1927  020f               L543:
1928                     ; 629   else if(alpha2 == 'd') value = (uint8_t)(value + 0x0d);
1930  020f a164          	cp	a,#100
1931  0211 2606          	jrne	L153
1934  0213 7b01          	ld	a,(OFST+0,sp)
1935  0215 ab0d          	add	a,#13
1937  0217 2015          	jp	L333
1938  0219               L153:
1939                     ; 630   else if(alpha2 == 'e') value = (uint8_t)(value + 0x0e);
1941  0219 a165          	cp	a,#101
1942  021b 2606          	jrne	L553
1945  021d 7b01          	ld	a,(OFST+0,sp)
1946  021f ab0e          	add	a,#14
1948  0221 200b          	jp	L333
1949  0223               L553:
1950                     ; 631   else if(alpha2 == 'f') value = (uint8_t)(value + 0x0f);
1952  0223 a166          	cp	a,#102
1953  0225 2606          	jrne	L163
1956  0227 7b01          	ld	a,(OFST+0,sp)
1957  0229 ab0f          	add	a,#15
1960  022b 2001          	jra	L333
1961  022d               L163:
1962                     ; 632   else value = 0; // If an invalid entry is made convert it to 0
1964  022d 4f            	clr	a
1966  022e               L333:
1967                     ; 634   return value;
1971  022e 5b03          	addw	sp,#3
1972  0230 81            	ret	
2023                     ; 638 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint32_t nDataLen)
2023                     ; 639 {
2024                     	switch	.text
2025  0231               L7_CopyHttpHeader:
2027  0231 89            	pushw	x
2028  0232 89            	pushw	x
2029       00000002      OFST:	set	2
2032                     ; 642   nBytes = 0;
2034  0233 5f            	clrw	x
2035  0234 1f01          	ldw	(OFST-1,sp),x
2037                     ; 644   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
2039  0236 ae426f        	ldw	x,#L704
2040  0239 89            	pushw	x
2041  023a 96            	ldw	x,sp
2042  023b 1c0005        	addw	x,#OFST+3
2043  023e cd0000        	call	L3_CopyStringP
2045  0241 5b02          	addw	sp,#2
2046  0243 72fb01        	addw	x,(OFST-1,sp)
2047  0246 1f01          	ldw	(OFST-1,sp),x
2049                     ; 645   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2051  0248 ae426c        	ldw	x,#L114
2052  024b 89            	pushw	x
2053  024c 96            	ldw	x,sp
2054  024d 1c0005        	addw	x,#OFST+3
2055  0250 cd0000        	call	L3_CopyStringP
2057  0253 5b02          	addw	sp,#2
2058  0255 72fb01        	addw	x,(OFST-1,sp)
2059  0258 1f01          	ldw	(OFST-1,sp),x
2061                     ; 647   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
2063  025a ae425c        	ldw	x,#L314
2064  025d 89            	pushw	x
2065  025e 96            	ldw	x,sp
2066  025f 1c0005        	addw	x,#OFST+3
2067  0262 cd0000        	call	L3_CopyStringP
2069  0265 5b02          	addw	sp,#2
2070  0267 72fb01        	addw	x,(OFST-1,sp)
2071  026a 1f01          	ldw	(OFST-1,sp),x
2073                     ; 648   nBytes += CopyValue(&pBuffer, nDataLen);
2075  026c 1e09          	ldw	x,(OFST+7,sp)
2076  026e 89            	pushw	x
2077  026f 1e09          	ldw	x,(OFST+7,sp)
2078  0271 89            	pushw	x
2079  0272 96            	ldw	x,sp
2080  0273 1c0007        	addw	x,#OFST+5
2081  0276 cd0028        	call	L5_CopyValue
2083  0279 5b04          	addw	sp,#4
2084  027b 72fb01        	addw	x,(OFST-1,sp)
2085  027e 1f01          	ldw	(OFST-1,sp),x
2087                     ; 649   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2089  0280 ae426c        	ldw	x,#L114
2090  0283 89            	pushw	x
2091  0284 96            	ldw	x,sp
2092  0285 1c0005        	addw	x,#OFST+3
2093  0288 cd0000        	call	L3_CopyStringP
2095  028b 5b02          	addw	sp,#2
2096  028d 72fb01        	addw	x,(OFST-1,sp)
2097  0290 1f01          	ldw	(OFST-1,sp),x
2099                     ; 651   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type:text/html\r\n"));
2101  0292 ae4243        	ldw	x,#L514
2102  0295 89            	pushw	x
2103  0296 96            	ldw	x,sp
2104  0297 1c0005        	addw	x,#OFST+3
2105  029a cd0000        	call	L3_CopyStringP
2107  029d 5b02          	addw	sp,#2
2108  029f 72fb01        	addw	x,(OFST-1,sp)
2109  02a2 1f01          	ldw	(OFST-1,sp),x
2111                     ; 652   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
2113  02a4 ae4230        	ldw	x,#L714
2114  02a7 89            	pushw	x
2115  02a8 96            	ldw	x,sp
2116  02a9 1c0005        	addw	x,#OFST+3
2117  02ac cd0000        	call	L3_CopyStringP
2119  02af 5b02          	addw	sp,#2
2120  02b1 72fb01        	addw	x,(OFST-1,sp)
2121  02b4 1f01          	ldw	(OFST-1,sp),x
2123                     ; 653   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2125  02b6 ae426c        	ldw	x,#L114
2126  02b9 89            	pushw	x
2127  02ba 96            	ldw	x,sp
2128  02bb 1c0005        	addw	x,#OFST+3
2129  02be cd0000        	call	L3_CopyStringP
2131  02c1 5b02          	addw	sp,#2
2132  02c3 72fb01        	addw	x,(OFST-1,sp)
2134                     ; 655   return nBytes;
2138  02c6 5b04          	addw	sp,#4
2139  02c8 81            	ret	
2278                     	switch	.const
2279  412e               L421:
2280  412e 046d          	dc.w	L124
2281  4130 047b          	dc.w	L324
2282  4132 0489          	dc.w	L524
2283  4134 0496          	dc.w	L724
2284  4136 04a3          	dc.w	L134
2285  4138 04b0          	dc.w	L334
2286  413a 04bd          	dc.w	L534
2287  413c 04ca          	dc.w	L734
2288  413e 04d7          	dc.w	L144
2289  4140 04e4          	dc.w	L344
2290  4142 04f1          	dc.w	L544
2291  4144 04fe          	dc.w	L744
2292  4146               L422:
2293  4146 063d          	dc.w	L354
2294  4148 064f          	dc.w	L554
2295  414a 0661          	dc.w	L754
2296  414c 0673          	dc.w	L164
2297  414e 0685          	dc.w	L364
2298  4150 0697          	dc.w	L564
2299  4152 06a9          	dc.w	L764
2300  4154 06bb          	dc.w	L174
2301  4156 06cd          	dc.w	L374
2302  4158 06df          	dc.w	L574
2303  415a 06f1          	dc.w	L774
2304  415c 0703          	dc.w	L105
2305  415e 0715          	dc.w	L305
2306  4160 0727          	dc.w	L505
2307  4162 0739          	dc.w	L705
2308  4164 074b          	dc.w	L115
2309  4166 075c          	dc.w	L315
2310  4168 076d          	dc.w	L515
2311  416a 077e          	dc.w	L715
2312  416c 078f          	dc.w	L125
2313  416e 07a0          	dc.w	L325
2314  4170 07b1          	dc.w	L525
2315                     ; 659 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
2315                     ; 660 {
2316                     	switch	.text
2317  02c9               L11_CopyHttpData:
2319  02c9 89            	pushw	x
2320  02ca 5207          	subw	sp,#7
2321       00000007      OFST:	set	7
2324                     ; 676   nBytes = 0;
2326  02cc 5f            	clrw	x
2327  02cd 1f05          	ldw	(OFST-2,sp),x
2329                     ; 712   if(nMaxBytes > 400) nMaxBytes = 400; // limit just in case
2331  02cf 1e10          	ldw	x,(OFST+9,sp)
2332  02d1 a30191        	cpw	x,#401
2333  02d4 2403cc0af8    	jrult	L306
2336  02d9 ae0190        	ldw	x,#400
2337  02dc 1f10          	ldw	(OFST+9,sp),x
2338  02de cc0af8        	jra	L306
2339  02e1               L106:
2340                     ; 735     if (*pDataLeft > 0) {
2342  02e1 1e0e          	ldw	x,(OFST+7,sp)
2343  02e3 e601          	ld	a,(1,x)
2344  02e5 fa            	or	a,(x)
2345  02e6 2603cc0b01    	jreq	L506
2346                     ; 739       memcpy(&nByte, *ppData, 1);
2348  02eb 96            	ldw	x,sp
2349  02ec 5c            	incw	x
2350  02ed bf00          	ldw	c_x,x
2351  02ef 160c          	ldw	y,(OFST+5,sp)
2352  02f1 90fe          	ldw	y,(y)
2353  02f3 90bf00        	ldw	c_y,y
2354  02f6 ae0001        	ldw	x,#1
2355  02f9               L25:
2356  02f9 5a            	decw	x
2357  02fa 92d600        	ld	a,([c_y.w],x)
2358  02fd 92d700        	ld	([c_x.w],x),a
2359  0300 5d            	tnzw	x
2360  0301 26f6          	jrne	L25
2361                     ; 765       if (nByte == '%') {
2363  0303 7b01          	ld	a,(OFST-6,sp)
2364  0305 a125          	cp	a,#37
2365  0307 2703cc0adb    	jrne	L116
2366                     ; 766         *ppData = *ppData + 1;
2368  030c 1e0c          	ldw	x,(OFST+5,sp)
2369  030e 9093          	ldw	y,x
2370  0310 fe            	ldw	x,(x)
2371  0311 5c            	incw	x
2372  0312 90ff          	ldw	(y),x
2373                     ; 767         *pDataLeft = *pDataLeft - 1;
2375  0314 1e0e          	ldw	x,(OFST+7,sp)
2376  0316 9093          	ldw	y,x
2377  0318 fe            	ldw	x,(x)
2378  0319 5a            	decw	x
2379  031a 90ff          	ldw	(y),x
2380                     ; 772         memcpy(&nParsedMode, *ppData, 1);
2382  031c 96            	ldw	x,sp
2383  031d 1c0003        	addw	x,#OFST-4
2384  0320 bf00          	ldw	c_x,x
2385  0322 160c          	ldw	y,(OFST+5,sp)
2386  0324 90fe          	ldw	y,(y)
2387  0326 90bf00        	ldw	c_y,y
2388  0329 ae0001        	ldw	x,#1
2389  032c               L45:
2390  032c 5a            	decw	x
2391  032d 92d600        	ld	a,([c_y.w],x)
2392  0330 92d700        	ld	([c_x.w],x),a
2393  0333 5d            	tnzw	x
2394  0334 26f6          	jrne	L45
2395                     ; 773         *ppData = *ppData + 1;
2397  0336 1e0c          	ldw	x,(OFST+5,sp)
2398  0338 9093          	ldw	y,x
2399  033a fe            	ldw	x,(x)
2400  033b 5c            	incw	x
2401  033c 90ff          	ldw	(y),x
2402                     ; 774         *pDataLeft = *pDataLeft - 1;
2404  033e 1e0e          	ldw	x,(OFST+7,sp)
2405  0340 9093          	ldw	y,x
2406  0342 fe            	ldw	x,(x)
2407  0343 5a            	decw	x
2408  0344 90ff          	ldw	(y),x
2409                     ; 778         memcpy(&temp, *ppData, 1);
2411  0346 96            	ldw	x,sp
2412  0347 1c0002        	addw	x,#OFST-5
2413  034a bf00          	ldw	c_x,x
2414  034c 160c          	ldw	y,(OFST+5,sp)
2415  034e 90fe          	ldw	y,(y)
2416  0350 90bf00        	ldw	c_y,y
2417  0353 ae0001        	ldw	x,#1
2418  0356               L65:
2419  0356 5a            	decw	x
2420  0357 92d600        	ld	a,([c_y.w],x)
2421  035a 92d700        	ld	([c_x.w],x),a
2422  035d 5d            	tnzw	x
2423  035e 26f6          	jrne	L65
2424                     ; 779 	nParsedNum = (uint8_t)((temp - '0') * 10);
2426  0360 7b02          	ld	a,(OFST-5,sp)
2427  0362 97            	ld	xl,a
2428  0363 a60a          	ld	a,#10
2429  0365 42            	mul	x,a
2430  0366 9f            	ld	a,xl
2431  0367 a0e0          	sub	a,#224
2432  0369 6b04          	ld	(OFST-3,sp),a
2434                     ; 780         *ppData = *ppData + 1;
2436  036b 1e0c          	ldw	x,(OFST+5,sp)
2437  036d 9093          	ldw	y,x
2438  036f fe            	ldw	x,(x)
2439  0370 5c            	incw	x
2440  0371 90ff          	ldw	(y),x
2441                     ; 781         *pDataLeft = *pDataLeft - 1;
2443  0373 1e0e          	ldw	x,(OFST+7,sp)
2444  0375 9093          	ldw	y,x
2445  0377 fe            	ldw	x,(x)
2446  0378 5a            	decw	x
2447  0379 90ff          	ldw	(y),x
2448                     ; 785         memcpy(&temp, *ppData, 1);
2450  037b 96            	ldw	x,sp
2451  037c 1c0002        	addw	x,#OFST-5
2452  037f bf00          	ldw	c_x,x
2453  0381 160c          	ldw	y,(OFST+5,sp)
2454  0383 90fe          	ldw	y,(y)
2455  0385 90bf00        	ldw	c_y,y
2456  0388 ae0001        	ldw	x,#1
2457  038b               L06:
2458  038b 5a            	decw	x
2459  038c 92d600        	ld	a,([c_y.w],x)
2460  038f 92d700        	ld	([c_x.w],x),a
2461  0392 5d            	tnzw	x
2462  0393 26f6          	jrne	L06
2463                     ; 786 	nParsedNum = (uint8_t)(nParsedNum + temp - '0');
2465  0395 7b04          	ld	a,(OFST-3,sp)
2466  0397 1b02          	add	a,(OFST-5,sp)
2467  0399 a030          	sub	a,#48
2468  039b 6b04          	ld	(OFST-3,sp),a
2470                     ; 787         *ppData = *ppData + 1;
2472  039d 1e0c          	ldw	x,(OFST+5,sp)
2473  039f 9093          	ldw	y,x
2474  03a1 fe            	ldw	x,(x)
2475  03a2 5c            	incw	x
2476  03a3 90ff          	ldw	(y),x
2477                     ; 788         *pDataLeft = *pDataLeft - 1;
2479  03a5 1e0e          	ldw	x,(OFST+7,sp)
2480  03a7 9093          	ldw	y,x
2481  03a9 fe            	ldw	x,(x)
2482  03aa 5a            	decw	x
2483  03ab 90ff          	ldw	(y),x
2484                     ; 798         if (nParsedMode == 'i') {
2486  03ad 7b03          	ld	a,(OFST-4,sp)
2487  03af a169          	cp	a,#105
2488  03b1 2614          	jrne	L316
2489                     ; 800 	  *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
2491  03b3 7b04          	ld	a,(OFST-3,sp)
2492  03b5 cd1335        	call	_GpioGetPin
2494  03b8 1e08          	ldw	x,(OFST+1,sp)
2495  03ba ab30          	add	a,#48
2496  03bc f7            	ld	(x),a
2497                     ; 801           pBuffer++;
2499  03bd 5c            	incw	x
2500  03be 1f08          	ldw	(OFST+1,sp),x
2501                     ; 802           nBytes++;
2503  03c0 1e05          	ldw	x,(OFST-2,sp)
2504  03c2 5c            	incw	x
2505  03c3 1f05          	ldw	(OFST-2,sp),x
2508  03c5 204e          	jra	L516
2509  03c7               L316:
2510                     ; 805         else if (nParsedMode == 'o') {
2512  03c7 a16f          	cp	a,#111
2513  03c9 2624          	jrne	L716
2514                     ; 808           if((uint8_t)(GpioGetPin(nParsedNum) == 1)) { // Insert 'checked'
2516  03cb 7b04          	ld	a,(OFST-3,sp)
2517  03cd cd1335        	call	_GpioGetPin
2519  03d0 4a            	dec	a
2520  03d1 2642          	jrne	L516
2521                     ; 809             for(i=0; i<7; i++) {
2523  03d3 6b07          	ld	(OFST+0,sp),a
2525  03d5               L326:
2526                     ; 810               *pBuffer = checked[i];
2528  03d5 5f            	clrw	x
2529  03d6 97            	ld	xl,a
2530  03d7 d60000        	ld	a,(L31_checked,x)
2531  03da 1e08          	ldw	x,(OFST+1,sp)
2532  03dc f7            	ld	(x),a
2533                     ; 811               pBuffer++;
2535  03dd 5c            	incw	x
2536  03de 1f08          	ldw	(OFST+1,sp),x
2537                     ; 812               nBytes++;
2539  03e0 1e05          	ldw	x,(OFST-2,sp)
2540  03e2 5c            	incw	x
2541  03e3 1f05          	ldw	(OFST-2,sp),x
2543                     ; 809             for(i=0; i<7; i++) {
2545  03e5 0c07          	inc	(OFST+0,sp)
2549  03e7 7b07          	ld	a,(OFST+0,sp)
2550  03e9 a107          	cp	a,#7
2551  03eb 25e8          	jrult	L326
2553  03ed 2026          	jra	L516
2554  03ef               L716:
2555                     ; 819         else if (nParsedMode == 'p') {
2557  03ef a170          	cp	a,#112
2558  03f1 2622          	jrne	L516
2559                     ; 822           if((uint8_t)(GpioGetPin(nParsedNum) == 0)) { // Insert 'checked'
2561  03f3 7b04          	ld	a,(OFST-3,sp)
2562  03f5 cd1335        	call	_GpioGetPin
2564  03f8 4d            	tnz	a
2565  03f9 261a          	jrne	L516
2566                     ; 823             for(i=0; i<7; i++) {
2568  03fb 6b07          	ld	(OFST+0,sp),a
2570  03fd               L146:
2571                     ; 824               *pBuffer = checked[i];
2573  03fd 5f            	clrw	x
2574  03fe 97            	ld	xl,a
2575  03ff d60000        	ld	a,(L31_checked,x)
2576  0402 1e08          	ldw	x,(OFST+1,sp)
2577  0404 f7            	ld	(x),a
2578                     ; 825               pBuffer++;
2580  0405 5c            	incw	x
2581  0406 1f08          	ldw	(OFST+1,sp),x
2582                     ; 826               nBytes++;
2584  0408 1e05          	ldw	x,(OFST-2,sp)
2585  040a 5c            	incw	x
2586  040b 1f05          	ldw	(OFST-2,sp),x
2588                     ; 823             for(i=0; i<7; i++) {
2590  040d 0c07          	inc	(OFST+0,sp)
2594  040f 7b07          	ld	a,(OFST+0,sp)
2595  0411 a107          	cp	a,#7
2596  0413 25e8          	jrult	L146
2598  0415               L516:
2599                     ; 833         if (nParsedMode == 'a') {
2601  0415 7b03          	ld	a,(OFST-4,sp)
2602  0417 a161          	cp	a,#97
2603  0419 263b          	jrne	L156
2604                     ; 835 	  for(i=0; i<20; i++) {
2606  041b 4f            	clr	a
2607  041c 6b07          	ld	(OFST+0,sp),a
2609  041e               L356:
2610                     ; 836 	    if(ex_stored_devicename[i] != ' ') { // Don't write spaces out - confuses the
2612  041e 5f            	clrw	x
2613  041f 97            	ld	xl,a
2614  0420 d60000        	ld	a,(_ex_stored_devicename,x)
2615  0423 a120          	cp	a,#32
2616  0425 2712          	jreq	L166
2617                     ; 838               *pBuffer = (uint8_t)(ex_stored_devicename[i]);
2619  0427 7b07          	ld	a,(OFST+0,sp)
2620  0429 5f            	clrw	x
2621  042a 97            	ld	xl,a
2622  042b d60000        	ld	a,(_ex_stored_devicename,x)
2623  042e 1e08          	ldw	x,(OFST+1,sp)
2624  0430 f7            	ld	(x),a
2625                     ; 839               pBuffer++;
2627  0431 5c            	incw	x
2628  0432 1f08          	ldw	(OFST+1,sp),x
2629                     ; 840               nBytes++;
2631  0434 1e05          	ldw	x,(OFST-2,sp)
2632  0436 5c            	incw	x
2633  0437 1f05          	ldw	(OFST-2,sp),x
2635  0439               L166:
2636                     ; 835 	  for(i=0; i<20; i++) {
2638  0439 0c07          	inc	(OFST+0,sp)
2642  043b 7b07          	ld	a,(OFST+0,sp)
2643  043d a114          	cp	a,#20
2644  043f 25dd          	jrult	L356
2645                     ; 855           *ppData = *ppData + 20;
2647  0441 1e0c          	ldw	x,(OFST+5,sp)
2648  0443 9093          	ldw	y,x
2649  0445 fe            	ldw	x,(x)
2650  0446 1c0014        	addw	x,#20
2651  0449 90ff          	ldw	(y),x
2652                     ; 856           *pDataLeft = *pDataLeft - 20;
2654  044b 1e0e          	ldw	x,(OFST+7,sp)
2655  044d 9093          	ldw	y,x
2656  044f fe            	ldw	x,(x)
2657  0450 1d0014        	subw	x,#20
2659  0453 cc0832        	jp	LC011
2660  0456               L156:
2661                     ; 859         else if (nParsedMode == 'b') {
2663  0456 a162          	cp	a,#98
2664  0458 2703cc0556    	jrne	L566
2665                     ; 864 	  advanceptrs = 0;
2667                     ; 866           switch (nParsedNum)
2669  045d 7b04          	ld	a,(OFST-3,sp)
2671                     ; 881 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2672  045f a10c          	cp	a,#12
2673  0461 2503cc0518    	jruge	L154
2674  0466 5f            	clrw	x
2675  0467 97            	ld	xl,a
2676  0468 58            	sllw	x
2677  0469 de412e        	ldw	x,(L421,x)
2678  046c fc            	jp	(x)
2679  046d               L124:
2680                     ; 869 	    case 0:  emb_itoa(ex_stored_hostaddr4, OctetArray, 10, 3); advanceptrs = 1; break;
2682  046d 4b03          	push	#3
2683  046f 4b0a          	push	#10
2684  0471 ae0000        	ldw	x,#_OctetArray
2685  0474 89            	pushw	x
2686  0475 c60000        	ld	a,_ex_stored_hostaddr4
2691  0478 cc0509        	jp	LC003
2692  047b               L324:
2693                     ; 870 	    case 1:  emb_itoa(ex_stored_hostaddr3, OctetArray, 10, 3); advanceptrs = 1; break;
2695  047b 4b03          	push	#3
2696  047d 4b0a          	push	#10
2697  047f ae0000        	ldw	x,#_OctetArray
2698  0482 89            	pushw	x
2699  0483 c60000        	ld	a,_ex_stored_hostaddr3
2704  0486 cc0509        	jp	LC003
2705  0489               L524:
2706                     ; 871 	    case 2:  emb_itoa(ex_stored_hostaddr2, OctetArray, 10, 3); advanceptrs = 1; break;
2708  0489 4b03          	push	#3
2709  048b 4b0a          	push	#10
2710  048d ae0000        	ldw	x,#_OctetArray
2711  0490 89            	pushw	x
2712  0491 c60000        	ld	a,_ex_stored_hostaddr2
2717  0494 2073          	jp	LC003
2718  0496               L724:
2719                     ; 872 	    case 3:  emb_itoa(ex_stored_hostaddr1, OctetArray, 10, 3); advanceptrs = 1; break;
2721  0496 4b03          	push	#3
2722  0498 4b0a          	push	#10
2723  049a ae0000        	ldw	x,#_OctetArray
2724  049d 89            	pushw	x
2725  049e c60000        	ld	a,_ex_stored_hostaddr1
2730  04a1 2066          	jp	LC003
2731  04a3               L134:
2732                     ; 873 	    case 4:  emb_itoa(ex_stored_draddr4,   OctetArray, 10, 3); advanceptrs = 1; break;
2734  04a3 4b03          	push	#3
2735  04a5 4b0a          	push	#10
2736  04a7 ae0000        	ldw	x,#_OctetArray
2737  04aa 89            	pushw	x
2738  04ab c60000        	ld	a,_ex_stored_draddr4
2743  04ae 2059          	jp	LC003
2744  04b0               L334:
2745                     ; 874 	    case 5:  emb_itoa(ex_stored_draddr3,   OctetArray, 10, 3); advanceptrs = 1; break;
2747  04b0 4b03          	push	#3
2748  04b2 4b0a          	push	#10
2749  04b4 ae0000        	ldw	x,#_OctetArray
2750  04b7 89            	pushw	x
2751  04b8 c60000        	ld	a,_ex_stored_draddr3
2756  04bb 204c          	jp	LC003
2757  04bd               L534:
2758                     ; 875 	    case 6:  emb_itoa(ex_stored_draddr2,   OctetArray, 10, 3); advanceptrs = 1; break;
2760  04bd 4b03          	push	#3
2761  04bf 4b0a          	push	#10
2762  04c1 ae0000        	ldw	x,#_OctetArray
2763  04c4 89            	pushw	x
2764  04c5 c60000        	ld	a,_ex_stored_draddr2
2769  04c8 203f          	jp	LC003
2770  04ca               L734:
2771                     ; 876 	    case 7:  emb_itoa(ex_stored_draddr1,   OctetArray, 10, 3); advanceptrs = 1; break;
2773  04ca 4b03          	push	#3
2774  04cc 4b0a          	push	#10
2775  04ce ae0000        	ldw	x,#_OctetArray
2776  04d1 89            	pushw	x
2777  04d2 c60000        	ld	a,_ex_stored_draddr1
2782  04d5 2032          	jp	LC003
2783  04d7               L144:
2784                     ; 877 	    case 8:  emb_itoa(ex_stored_netmask4,  OctetArray, 10, 3); advanceptrs = 1; break;
2786  04d7 4b03          	push	#3
2787  04d9 4b0a          	push	#10
2788  04db ae0000        	ldw	x,#_OctetArray
2789  04de 89            	pushw	x
2790  04df c60000        	ld	a,_ex_stored_netmask4
2795  04e2 2025          	jp	LC003
2796  04e4               L344:
2797                     ; 878 	    case 9:  emb_itoa(ex_stored_netmask3,  OctetArray, 10, 3); advanceptrs = 1; break;
2799  04e4 4b03          	push	#3
2800  04e6 4b0a          	push	#10
2801  04e8 ae0000        	ldw	x,#_OctetArray
2802  04eb 89            	pushw	x
2803  04ec c60000        	ld	a,_ex_stored_netmask3
2808  04ef 2018          	jp	LC003
2809  04f1               L544:
2810                     ; 879 	    case 10: emb_itoa(ex_stored_netmask2,  OctetArray, 10, 3); advanceptrs = 1; break;
2812  04f1 4b03          	push	#3
2813  04f3 4b0a          	push	#10
2814  04f5 ae0000        	ldw	x,#_OctetArray
2815  04f8 89            	pushw	x
2816  04f9 c60000        	ld	a,_ex_stored_netmask2
2821  04fc 200b          	jp	LC003
2822  04fe               L744:
2823                     ; 880 	    case 11: emb_itoa(ex_stored_netmask1,  OctetArray, 10, 3); advanceptrs = 1; break;
2825  04fe 4b03          	push	#3
2826  0500 4b0a          	push	#10
2827  0502 ae0000        	ldw	x,#_OctetArray
2828  0505 89            	pushw	x
2829  0506 c60000        	ld	a,_ex_stored_netmask1
2830  0509               LC003:
2831  0509 b703          	ld	c_lreg+3,a
2832  050b 3f02          	clr	c_lreg+2
2833  050d 3f01          	clr	c_lreg+1
2834  050f 3f00          	clr	c_lreg
2835  0511 be02          	ldw	x,c_lreg+2
2836  0513 89            	pushw	x
2837  0514 be00          	ldw	x,c_lreg
2842  0516 200a          	jra	L176
2843  0518               L154:
2844                     ; 881 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2846  0518 4b03          	push	#3
2847  051a 4b0a          	push	#10
2848  051c ae0000        	ldw	x,#_OctetArray
2849  051f 89            	pushw	x
2850  0520 5f            	clrw	x
2851  0521 89            	pushw	x
2857  0522               L176:
2858  0522 89            	pushw	x
2859  0523 cd008c        	call	_emb_itoa
2860  0526 5b08          	addw	sp,#8
2873  0528 a601          	ld	a,#1
2874  052a 6b07          	ld	(OFST+0,sp),a
2876                     ; 884 	  if(advanceptrs == 1) { // Copy OctetArray and advance pointers if one of the above
2878  052c 4a            	dec	a
2879  052d 2703cc0af8    	jrne	L306
2880                     ; 886             *pBuffer = (uint8_t)OctetArray[0];
2882  0532 1e08          	ldw	x,(OFST+1,sp)
2883  0534 c60000        	ld	a,_OctetArray
2884  0537 f7            	ld	(x),a
2885                     ; 887             pBuffer++;
2887  0538 5c            	incw	x
2888  0539 1f08          	ldw	(OFST+1,sp),x
2889                     ; 888             nBytes++;
2891  053b 1e05          	ldw	x,(OFST-2,sp)
2892  053d 5c            	incw	x
2893  053e 1f05          	ldw	(OFST-2,sp),x
2895                     ; 890             *pBuffer = (uint8_t)OctetArray[1];
2897  0540 1e08          	ldw	x,(OFST+1,sp)
2898  0542 c60001        	ld	a,_OctetArray+1
2899  0545 f7            	ld	(x),a
2900                     ; 891             pBuffer++;
2902  0546 5c            	incw	x
2903  0547 1f08          	ldw	(OFST+1,sp),x
2904                     ; 892             nBytes++;
2906  0549 1e05          	ldw	x,(OFST-2,sp)
2907  054b 5c            	incw	x
2908  054c 1f05          	ldw	(OFST-2,sp),x
2910                     ; 894             *pBuffer = (uint8_t)OctetArray[2];
2912  054e c60002        	ld	a,_OctetArray+2
2913  0551 1e08          	ldw	x,(OFST+1,sp)
2914                     ; 895             pBuffer++;
2915                     ; 896             nBytes++;
2916  0553 cc0622        	jp	LC010
2917  0556               L566:
2918                     ; 900         else if (nParsedMode == 'c') {
2920  0556 a163          	cp	a,#99
2921  0558 2637          	jrne	L776
2922                     ; 906           emb_itoa(ex_stored_port, OctetArray, 10, 5);
2924  055a 4b05          	push	#5
2925  055c 4b0a          	push	#10
2926  055e ae0000        	ldw	x,#_OctetArray
2927  0561 89            	pushw	x
2928  0562 ce0000        	ldw	x,_ex_stored_port
2929  0565 cd0000        	call	c_uitolx
2931  0568 be02          	ldw	x,c_lreg+2
2932  056a 89            	pushw	x
2933  056b be00          	ldw	x,c_lreg
2934  056d 89            	pushw	x
2935  056e cd008c        	call	_emb_itoa
2937  0571 5b08          	addw	sp,#8
2938                     ; 908 	  for(i=0; i<5; i++) {
2940  0573 4f            	clr	a
2941  0574 6b07          	ld	(OFST+0,sp),a
2943  0576               L107:
2944                     ; 909             *pBuffer = (uint8_t)OctetArray[i];
2946  0576 5f            	clrw	x
2947  0577 97            	ld	xl,a
2948  0578 d60000        	ld	a,(_OctetArray,x)
2949  057b 1e08          	ldw	x,(OFST+1,sp)
2950  057d f7            	ld	(x),a
2951                     ; 910             pBuffer++;
2953  057e 5c            	incw	x
2954  057f 1f08          	ldw	(OFST+1,sp),x
2955                     ; 911             nBytes++;
2957  0581 1e05          	ldw	x,(OFST-2,sp)
2958  0583 5c            	incw	x
2959  0584 1f05          	ldw	(OFST-2,sp),x
2961                     ; 908 	  for(i=0; i<5; i++) {
2963  0586 0c07          	inc	(OFST+0,sp)
2967  0588 7b07          	ld	a,(OFST+0,sp)
2968  058a a105          	cp	a,#5
2969  058c 25e8          	jrult	L107
2971  058e cc0af8        	jra	L306
2972  0591               L776:
2973                     ; 915         else if (nParsedMode == 'd') {
2975  0591 a164          	cp	a,#100
2976  0593 2703cc0626    	jrne	L117
2977                     ; 920 	  if(nParsedNum == 0)      emb_itoa(uip_ethaddr1, OctetArray, 16, 2);
2979  0598 7b04          	ld	a,(OFST-3,sp)
2980  059a 260d          	jrne	L317
2983  059c 4b02          	push	#2
2984  059e 4b10          	push	#16
2985  05a0 ae0000        	ldw	x,#_OctetArray
2986  05a3 89            	pushw	x
2987  05a4 c60000        	ld	a,_uip_ethaddr1
2990  05a7 2053          	jp	LC004
2991  05a9               L317:
2992                     ; 921 	  else if(nParsedNum == 1) emb_itoa(uip_ethaddr2, OctetArray, 16, 2);
2994  05a9 a101          	cp	a,#1
2995  05ab 260d          	jrne	L717
2998  05ad 4b02          	push	#2
2999  05af 4b10          	push	#16
3000  05b1 ae0000        	ldw	x,#_OctetArray
3001  05b4 89            	pushw	x
3002  05b5 c60000        	ld	a,_uip_ethaddr2
3005  05b8 2042          	jp	LC004
3006  05ba               L717:
3007                     ; 922 	  else if(nParsedNum == 2) emb_itoa(uip_ethaddr3, OctetArray, 16, 2);
3009  05ba a102          	cp	a,#2
3010  05bc 260d          	jrne	L327
3013  05be 4b02          	push	#2
3014  05c0 4b10          	push	#16
3015  05c2 ae0000        	ldw	x,#_OctetArray
3016  05c5 89            	pushw	x
3017  05c6 c60000        	ld	a,_uip_ethaddr3
3020  05c9 2031          	jp	LC004
3021  05cb               L327:
3022                     ; 923 	  else if(nParsedNum == 3) emb_itoa(uip_ethaddr4, OctetArray, 16, 2);
3024  05cb a103          	cp	a,#3
3025  05cd 260d          	jrne	L727
3028  05cf 4b02          	push	#2
3029  05d1 4b10          	push	#16
3030  05d3 ae0000        	ldw	x,#_OctetArray
3031  05d6 89            	pushw	x
3032  05d7 c60000        	ld	a,_uip_ethaddr4
3035  05da 2020          	jp	LC004
3036  05dc               L727:
3037                     ; 924 	  else if(nParsedNum == 4) emb_itoa(uip_ethaddr5, OctetArray, 16, 2);
3039  05dc a104          	cp	a,#4
3040  05de 260d          	jrne	L337
3043  05e0 4b02          	push	#2
3044  05e2 4b10          	push	#16
3045  05e4 ae0000        	ldw	x,#_OctetArray
3046  05e7 89            	pushw	x
3047  05e8 c60000        	ld	a,_uip_ethaddr5
3050  05eb 200f          	jp	LC004
3051  05ed               L337:
3052                     ; 925 	  else if(nParsedNum == 5) emb_itoa(uip_ethaddr6, OctetArray, 16, 2);
3054  05ed a105          	cp	a,#5
3055  05ef 261e          	jrne	L517
3058  05f1 4b02          	push	#2
3059  05f3 4b10          	push	#16
3060  05f5 ae0000        	ldw	x,#_OctetArray
3061  05f8 89            	pushw	x
3062  05f9 c60000        	ld	a,_uip_ethaddr6
3064  05fc               LC004:
3065  05fc b703          	ld	c_lreg+3,a
3066  05fe 3f02          	clr	c_lreg+2
3067  0600 3f01          	clr	c_lreg+1
3068  0602 3f00          	clr	c_lreg
3069  0604 be02          	ldw	x,c_lreg+2
3070  0606 89            	pushw	x
3071  0607 be00          	ldw	x,c_lreg
3072  0609 89            	pushw	x
3073  060a cd008c        	call	_emb_itoa
3074  060d 5b08          	addw	sp,#8
3075  060f               L517:
3076                     ; 927           *pBuffer = OctetArray[0];
3078  060f 1e08          	ldw	x,(OFST+1,sp)
3079  0611 c60000        	ld	a,_OctetArray
3080  0614 f7            	ld	(x),a
3081                     ; 928           pBuffer++;
3083  0615 5c            	incw	x
3084  0616 1f08          	ldw	(OFST+1,sp),x
3085                     ; 929           nBytes++;
3087  0618 1e05          	ldw	x,(OFST-2,sp)
3088  061a 5c            	incw	x
3089  061b 1f05          	ldw	(OFST-2,sp),x
3091                     ; 931           *pBuffer = OctetArray[1];
3093  061d c60001        	ld	a,_OctetArray+1
3094  0620 1e08          	ldw	x,(OFST+1,sp)
3095  0622               LC010:
3096  0622 f7            	ld	(x),a
3097                     ; 932           pBuffer++;
3098                     ; 933           nBytes++;
3100  0623 cc0af0        	jp	LC009
3101  0626               L117:
3102                     ; 938         else if (nParsedMode == 'e') {
3104  0626 a165          	cp	a,#101
3105  0628 2703cc0801    	jrne	L347
3106                     ; 965           switch (nParsedNum)
3108  062d 7b04          	ld	a,(OFST-3,sp)
3110                     ; 990 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3111  062f a116          	cp	a,#22
3112  0631 2503cc07c2    	jruge	L725
3113  0636 5f            	clrw	x
3114  0637 97            	ld	xl,a
3115  0638 58            	sllw	x
3116  0639 de4146        	ldw	x,(L422,x)
3117  063c fc            	jp	(x)
3118  063d               L354:
3119                     ; 968 	    case 0:  emb_itoa(uip_stat.ip.drop,      OctetArray, 10, 10); break;
3121  063d 4b0a          	push	#10
3122  063f 4b0a          	push	#10
3123  0641 ae0000        	ldw	x,#_OctetArray
3124  0644 89            	pushw	x
3125  0645 ce0002        	ldw	x,_uip_stat+2
3126  0648 89            	pushw	x
3127  0649 ce0000        	ldw	x,_uip_stat
3131  064c cc07cc        	jra	L747
3132  064f               L554:
3133                     ; 969 	    case 1:  emb_itoa(uip_stat.ip.recv,      OctetArray, 10, 10); break;
3135  064f 4b0a          	push	#10
3136  0651 4b0a          	push	#10
3137  0653 ae0000        	ldw	x,#_OctetArray
3138  0656 89            	pushw	x
3139  0657 ce0006        	ldw	x,_uip_stat+6
3140  065a 89            	pushw	x
3141  065b ce0004        	ldw	x,_uip_stat+4
3145  065e cc07cc        	jra	L747
3146  0661               L754:
3147                     ; 970 	    case 2:  emb_itoa(uip_stat.ip.sent,      OctetArray, 10, 10); break;
3149  0661 4b0a          	push	#10
3150  0663 4b0a          	push	#10
3151  0665 ae0000        	ldw	x,#_OctetArray
3152  0668 89            	pushw	x
3153  0669 ce000a        	ldw	x,_uip_stat+10
3154  066c 89            	pushw	x
3155  066d ce0008        	ldw	x,_uip_stat+8
3159  0670 cc07cc        	jra	L747
3160  0673               L164:
3161                     ; 971 	    case 3:  emb_itoa(uip_stat.ip.vhlerr,    OctetArray, 10, 10); break;
3163  0673 4b0a          	push	#10
3164  0675 4b0a          	push	#10
3165  0677 ae0000        	ldw	x,#_OctetArray
3166  067a 89            	pushw	x
3167  067b ce000e        	ldw	x,_uip_stat+14
3168  067e 89            	pushw	x
3169  067f ce000c        	ldw	x,_uip_stat+12
3173  0682 cc07cc        	jra	L747
3174  0685               L364:
3175                     ; 972 	    case 4:  emb_itoa(uip_stat.ip.hblenerr,  OctetArray, 10, 10); break;
3177  0685 4b0a          	push	#10
3178  0687 4b0a          	push	#10
3179  0689 ae0000        	ldw	x,#_OctetArray
3180  068c 89            	pushw	x
3181  068d ce0012        	ldw	x,_uip_stat+18
3182  0690 89            	pushw	x
3183  0691 ce0010        	ldw	x,_uip_stat+16
3187  0694 cc07cc        	jra	L747
3188  0697               L564:
3189                     ; 973 	    case 5:  emb_itoa(uip_stat.ip.lblenerr,  OctetArray, 10, 10); break;
3191  0697 4b0a          	push	#10
3192  0699 4b0a          	push	#10
3193  069b ae0000        	ldw	x,#_OctetArray
3194  069e 89            	pushw	x
3195  069f ce0016        	ldw	x,_uip_stat+22
3196  06a2 89            	pushw	x
3197  06a3 ce0014        	ldw	x,_uip_stat+20
3201  06a6 cc07cc        	jra	L747
3202  06a9               L764:
3203                     ; 974 	    case 6:  emb_itoa(uip_stat.ip.fragerr,   OctetArray, 10, 10); break;
3205  06a9 4b0a          	push	#10
3206  06ab 4b0a          	push	#10
3207  06ad ae0000        	ldw	x,#_OctetArray
3208  06b0 89            	pushw	x
3209  06b1 ce001a        	ldw	x,_uip_stat+26
3210  06b4 89            	pushw	x
3211  06b5 ce0018        	ldw	x,_uip_stat+24
3215  06b8 cc07cc        	jra	L747
3216  06bb               L174:
3217                     ; 975 	    case 7:  emb_itoa(uip_stat.ip.chkerr,    OctetArray, 10, 10); break;
3219  06bb 4b0a          	push	#10
3220  06bd 4b0a          	push	#10
3221  06bf ae0000        	ldw	x,#_OctetArray
3222  06c2 89            	pushw	x
3223  06c3 ce001e        	ldw	x,_uip_stat+30
3224  06c6 89            	pushw	x
3225  06c7 ce001c        	ldw	x,_uip_stat+28
3229  06ca cc07cc        	jra	L747
3230  06cd               L374:
3231                     ; 976 	    case 8:  emb_itoa(uip_stat.ip.protoerr,  OctetArray, 10, 10); break;
3233  06cd 4b0a          	push	#10
3234  06cf 4b0a          	push	#10
3235  06d1 ae0000        	ldw	x,#_OctetArray
3236  06d4 89            	pushw	x
3237  06d5 ce0022        	ldw	x,_uip_stat+34
3238  06d8 89            	pushw	x
3239  06d9 ce0020        	ldw	x,_uip_stat+32
3243  06dc cc07cc        	jra	L747
3244  06df               L574:
3245                     ; 977 	    case 9:  emb_itoa(uip_stat.icmp.drop,    OctetArray, 10, 10); break;
3247  06df 4b0a          	push	#10
3248  06e1 4b0a          	push	#10
3249  06e3 ae0000        	ldw	x,#_OctetArray
3250  06e6 89            	pushw	x
3251  06e7 ce0026        	ldw	x,_uip_stat+38
3252  06ea 89            	pushw	x
3253  06eb ce0024        	ldw	x,_uip_stat+36
3257  06ee cc07cc        	jra	L747
3258  06f1               L774:
3259                     ; 978 	    case 10: emb_itoa(uip_stat.icmp.recv,    OctetArray, 10, 10); break;
3261  06f1 4b0a          	push	#10
3262  06f3 4b0a          	push	#10
3263  06f5 ae0000        	ldw	x,#_OctetArray
3264  06f8 89            	pushw	x
3265  06f9 ce002a        	ldw	x,_uip_stat+42
3266  06fc 89            	pushw	x
3267  06fd ce0028        	ldw	x,_uip_stat+40
3271  0700 cc07cc        	jra	L747
3272  0703               L105:
3273                     ; 979 	    case 11: emb_itoa(uip_stat.icmp.sent,    OctetArray, 10, 10); break;
3275  0703 4b0a          	push	#10
3276  0705 4b0a          	push	#10
3277  0707 ae0000        	ldw	x,#_OctetArray
3278  070a 89            	pushw	x
3279  070b ce002e        	ldw	x,_uip_stat+46
3280  070e 89            	pushw	x
3281  070f ce002c        	ldw	x,_uip_stat+44
3285  0712 cc07cc        	jra	L747
3286  0715               L305:
3287                     ; 980 	    case 12: emb_itoa(uip_stat.icmp.typeerr, OctetArray, 10, 10); break;
3289  0715 4b0a          	push	#10
3290  0717 4b0a          	push	#10
3291  0719 ae0000        	ldw	x,#_OctetArray
3292  071c 89            	pushw	x
3293  071d ce0032        	ldw	x,_uip_stat+50
3294  0720 89            	pushw	x
3295  0721 ce0030        	ldw	x,_uip_stat+48
3299  0724 cc07cc        	jra	L747
3300  0727               L505:
3301                     ; 981 	    case 13: emb_itoa(uip_stat.tcp.drop,     OctetArray, 10, 10); break;
3303  0727 4b0a          	push	#10
3304  0729 4b0a          	push	#10
3305  072b ae0000        	ldw	x,#_OctetArray
3306  072e 89            	pushw	x
3307  072f ce0036        	ldw	x,_uip_stat+54
3308  0732 89            	pushw	x
3309  0733 ce0034        	ldw	x,_uip_stat+52
3313  0736 cc07cc        	jra	L747
3314  0739               L705:
3315                     ; 982 	    case 14: emb_itoa(uip_stat.tcp.recv,     OctetArray, 10, 10); break;
3317  0739 4b0a          	push	#10
3318  073b 4b0a          	push	#10
3319  073d ae0000        	ldw	x,#_OctetArray
3320  0740 89            	pushw	x
3321  0741 ce003a        	ldw	x,_uip_stat+58
3322  0744 89            	pushw	x
3323  0745 ce0038        	ldw	x,_uip_stat+56
3327  0748 cc07cc        	jra	L747
3328  074b               L115:
3329                     ; 983 	    case 15: emb_itoa(uip_stat.tcp.sent,     OctetArray, 10, 10); break;
3331  074b 4b0a          	push	#10
3332  074d 4b0a          	push	#10
3333  074f ae0000        	ldw	x,#_OctetArray
3334  0752 89            	pushw	x
3335  0753 ce003e        	ldw	x,_uip_stat+62
3336  0756 89            	pushw	x
3337  0757 ce003c        	ldw	x,_uip_stat+60
3341  075a 2070          	jra	L747
3342  075c               L315:
3343                     ; 984 	    case 16: emb_itoa(uip_stat.tcp.chkerr,   OctetArray, 10, 10); break;
3345  075c 4b0a          	push	#10
3346  075e 4b0a          	push	#10
3347  0760 ae0000        	ldw	x,#_OctetArray
3348  0763 89            	pushw	x
3349  0764 ce0042        	ldw	x,_uip_stat+66
3350  0767 89            	pushw	x
3351  0768 ce0040        	ldw	x,_uip_stat+64
3355  076b 205f          	jra	L747
3356  076d               L515:
3357                     ; 985 	    case 17: emb_itoa(uip_stat.tcp.ackerr,   OctetArray, 10, 10); break;
3359  076d 4b0a          	push	#10
3360  076f 4b0a          	push	#10
3361  0771 ae0000        	ldw	x,#_OctetArray
3362  0774 89            	pushw	x
3363  0775 ce0046        	ldw	x,_uip_stat+70
3364  0778 89            	pushw	x
3365  0779 ce0044        	ldw	x,_uip_stat+68
3369  077c 204e          	jra	L747
3370  077e               L715:
3371                     ; 986 	    case 18: emb_itoa(uip_stat.tcp.rst,      OctetArray, 10, 10); break;
3373  077e 4b0a          	push	#10
3374  0780 4b0a          	push	#10
3375  0782 ae0000        	ldw	x,#_OctetArray
3376  0785 89            	pushw	x
3377  0786 ce004a        	ldw	x,_uip_stat+74
3378  0789 89            	pushw	x
3379  078a ce0048        	ldw	x,_uip_stat+72
3383  078d 203d          	jra	L747
3384  078f               L125:
3385                     ; 987 	    case 19: emb_itoa(uip_stat.tcp.rexmit,   OctetArray, 10, 10); break;
3387  078f 4b0a          	push	#10
3388  0791 4b0a          	push	#10
3389  0793 ae0000        	ldw	x,#_OctetArray
3390  0796 89            	pushw	x
3391  0797 ce004e        	ldw	x,_uip_stat+78
3392  079a 89            	pushw	x
3393  079b ce004c        	ldw	x,_uip_stat+76
3397  079e 202c          	jra	L747
3398  07a0               L325:
3399                     ; 988 	    case 20: emb_itoa(uip_stat.tcp.syndrop,  OctetArray, 10, 10); break;
3401  07a0 4b0a          	push	#10
3402  07a2 4b0a          	push	#10
3403  07a4 ae0000        	ldw	x,#_OctetArray
3404  07a7 89            	pushw	x
3405  07a8 ce0052        	ldw	x,_uip_stat+82
3406  07ab 89            	pushw	x
3407  07ac ce0050        	ldw	x,_uip_stat+80
3411  07af 201b          	jra	L747
3412  07b1               L525:
3413                     ; 989 	    case 21: emb_itoa(uip_stat.tcp.synrst,   OctetArray, 10, 10); break;
3415  07b1 4b0a          	push	#10
3416  07b3 4b0a          	push	#10
3417  07b5 ae0000        	ldw	x,#_OctetArray
3418  07b8 89            	pushw	x
3419  07b9 ce0056        	ldw	x,_uip_stat+86
3420  07bc 89            	pushw	x
3421  07bd ce0054        	ldw	x,_uip_stat+84
3425  07c0 200a          	jra	L747
3426  07c2               L725:
3427                     ; 990 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3429  07c2 4b0a          	push	#10
3430  07c4 4b0a          	push	#10
3431  07c6 ae0000        	ldw	x,#_OctetArray
3432  07c9 89            	pushw	x
3433  07ca 5f            	clrw	x
3434  07cb 89            	pushw	x
3438  07cc               L747:
3439  07cc 89            	pushw	x
3440  07cd cd008c        	call	_emb_itoa
3441  07d0 5b08          	addw	sp,#8
3442                     ; 993 	  for (i=0; i<10; i++) {
3444  07d2 4f            	clr	a
3445  07d3 6b07          	ld	(OFST+0,sp),a
3447  07d5               L157:
3448                     ; 994             *pBuffer = OctetArray[i];
3450  07d5 5f            	clrw	x
3451  07d6 97            	ld	xl,a
3452  07d7 d60000        	ld	a,(_OctetArray,x)
3453  07da 1e08          	ldw	x,(OFST+1,sp)
3454  07dc f7            	ld	(x),a
3455                     ; 995             pBuffer++;
3457  07dd 5c            	incw	x
3458  07de 1f08          	ldw	(OFST+1,sp),x
3459                     ; 996             nBytes++;
3461  07e0 1e05          	ldw	x,(OFST-2,sp)
3462  07e2 5c            	incw	x
3463  07e3 1f05          	ldw	(OFST-2,sp),x
3465                     ; 993 	  for (i=0; i<10; i++) {
3467  07e5 0c07          	inc	(OFST+0,sp)
3471  07e7 7b07          	ld	a,(OFST+0,sp)
3472  07e9 a10a          	cp	a,#10
3473  07eb 25e8          	jrult	L157
3474                     ; 1001           *ppData = *ppData + 10;
3476  07ed 1e0c          	ldw	x,(OFST+5,sp)
3477  07ef 9093          	ldw	y,x
3478  07f1 fe            	ldw	x,(x)
3479  07f2 1c000a        	addw	x,#10
3480  07f5 90ff          	ldw	(y),x
3481                     ; 1002           *pDataLeft = *pDataLeft - 10;
3483  07f7 1e0e          	ldw	x,(OFST+7,sp)
3484  07f9 9093          	ldw	y,x
3485  07fb fe            	ldw	x,(x)
3486  07fc 1d000a        	subw	x,#10
3488  07ff 2031          	jp	LC011
3489  0801               L347:
3490                     ; 1007         else if (nParsedMode == 'f') {
3492  0801 a166          	cp	a,#102
3493  0803 2632          	jrne	L167
3494                     ; 1010 	  for(i=0; i<16; i++) {
3496  0805 4f            	clr	a
3497  0806 6b07          	ld	(OFST+0,sp),a
3499  0808               L367:
3500                     ; 1011 	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
3502  0808 cd1335        	call	_GpioGetPin
3504  080b 1e08          	ldw	x,(OFST+1,sp)
3505  080d ab30          	add	a,#48
3506  080f f7            	ld	(x),a
3507                     ; 1012             pBuffer++;
3509  0810 5c            	incw	x
3510  0811 1f08          	ldw	(OFST+1,sp),x
3511                     ; 1013             nBytes++;
3513  0813 1e05          	ldw	x,(OFST-2,sp)
3514  0815 5c            	incw	x
3515  0816 1f05          	ldw	(OFST-2,sp),x
3517                     ; 1010 	  for(i=0; i<16; i++) {
3519  0818 0c07          	inc	(OFST+0,sp)
3523  081a 7b07          	ld	a,(OFST+0,sp)
3524  081c a110          	cp	a,#16
3525  081e 25e8          	jrult	L367
3526                     ; 1017           *ppData = *ppData + 16;
3528  0820 1e0c          	ldw	x,(OFST+5,sp)
3529  0822 9093          	ldw	y,x
3530  0824 fe            	ldw	x,(x)
3531  0825 1c0010        	addw	x,#16
3532  0828 90ff          	ldw	(y),x
3533                     ; 1018           *pDataLeft = *pDataLeft - 16;
3535  082a 1e0e          	ldw	x,(OFST+7,sp)
3536  082c 9093          	ldw	y,x
3537  082e fe            	ldw	x,(x)
3538  082f 1d0010        	subw	x,#16
3539  0832               LC011:
3540  0832 90ff          	ldw	(y),x
3542  0834 cc0af8        	jra	L306
3543  0837               L167:
3544                     ; 1021         else if (nParsedMode == 'g') {
3546  0837 a167          	cp	a,#103
3547  0839 2623          	jrne	L377
3548                     ; 1025 	  if (invert_output == 1) {  // Insert 'checked'
3550  083b c60000        	ld	a,_invert_output
3551  083e 4a            	dec	a
3552  083f 26f3          	jrne	L306
3553                     ; 1026             for(i=0; i<7; i++) {
3555  0841 6b07          	ld	(OFST+0,sp),a
3557  0843               L777:
3558                     ; 1027               *pBuffer = checked[i];
3560  0843 5f            	clrw	x
3561  0844 97            	ld	xl,a
3562  0845 d60000        	ld	a,(L31_checked,x)
3563  0848 1e08          	ldw	x,(OFST+1,sp)
3564  084a f7            	ld	(x),a
3565                     ; 1028               pBuffer++;
3567  084b 5c            	incw	x
3568  084c 1f08          	ldw	(OFST+1,sp),x
3569                     ; 1029               nBytes++;
3571  084e 1e05          	ldw	x,(OFST-2,sp)
3572  0850 5c            	incw	x
3573  0851 1f05          	ldw	(OFST-2,sp),x
3575                     ; 1026             for(i=0; i<7; i++) {
3577  0853 0c07          	inc	(OFST+0,sp)
3581  0855 7b07          	ld	a,(OFST+0,sp)
3582  0857 a107          	cp	a,#7
3583  0859 25e8          	jrult	L777
3584  085b cc0af8        	jra	L306
3585  085e               L377:
3586                     ; 1034         else if (nParsedMode == 'h') {
3588  085e a168          	cp	a,#104
3589  0860 2622          	jrne	L7001
3590                     ; 1039 	  if (invert_output == 0) {  // Insert 'checked'
3592  0862 c60000        	ld	a,_invert_output
3593  0865 26f4          	jrne	L306
3594                     ; 1040             for(i=0; i<7; i++) {
3596  0867 6b07          	ld	(OFST+0,sp),a
3598  0869               L3101:
3599                     ; 1041               *pBuffer = checked[i];
3601  0869 5f            	clrw	x
3602  086a 97            	ld	xl,a
3603  086b d60000        	ld	a,(L31_checked,x)
3604  086e 1e08          	ldw	x,(OFST+1,sp)
3605  0870 f7            	ld	(x),a
3606                     ; 1042               pBuffer++;
3608  0871 5c            	incw	x
3609  0872 1f08          	ldw	(OFST+1,sp),x
3610                     ; 1043               nBytes++;
3612  0874 1e05          	ldw	x,(OFST-2,sp)
3613  0876 5c            	incw	x
3614  0877 1f05          	ldw	(OFST-2,sp),x
3616                     ; 1040             for(i=0; i<7; i++) {
3618  0879 0c07          	inc	(OFST+0,sp)
3622  087b 7b07          	ld	a,(OFST+0,sp)
3623  087d a107          	cp	a,#7
3624  087f 25e8          	jrult	L3101
3625  0881 cc0af8        	jra	L306
3626  0884               L7001:
3627                     ; 1048         else if (nParsedMode == 'x') {
3629  0884 a178          	cp	a,#120
3630  0886 26f9          	jrne	L306
3631                     ; 1058           *pBuffer = 'h'; pBuffer++; nBytes++;
3633  0888 1e08          	ldw	x,(OFST+1,sp)
3634  088a a668          	ld	a,#104
3635  088c f7            	ld	(x),a
3638  088d 5c            	incw	x
3639  088e 1f08          	ldw	(OFST+1,sp),x
3642  0890 1e05          	ldw	x,(OFST-2,sp)
3643  0892 5c            	incw	x
3644  0893 1f05          	ldw	(OFST-2,sp),x
3646                     ; 1059           *pBuffer = 't'; pBuffer++; nBytes++;
3648  0895 1e08          	ldw	x,(OFST+1,sp)
3649  0897 a674          	ld	a,#116
3650  0899 f7            	ld	(x),a
3653  089a 5c            	incw	x
3654  089b 1f08          	ldw	(OFST+1,sp),x
3657  089d 1e05          	ldw	x,(OFST-2,sp)
3658  089f 5c            	incw	x
3659  08a0 1f05          	ldw	(OFST-2,sp),x
3661                     ; 1060           *pBuffer = 't'; pBuffer++; nBytes++;
3663  08a2 1e08          	ldw	x,(OFST+1,sp)
3664  08a4 f7            	ld	(x),a
3667  08a5 5c            	incw	x
3668  08a6 1f08          	ldw	(OFST+1,sp),x
3671  08a8 1e05          	ldw	x,(OFST-2,sp)
3672  08aa 5c            	incw	x
3673  08ab 1f05          	ldw	(OFST-2,sp),x
3675                     ; 1061           *pBuffer = 'p'; pBuffer++; nBytes++;
3677  08ad 1e08          	ldw	x,(OFST+1,sp)
3678  08af a670          	ld	a,#112
3679  08b1 f7            	ld	(x),a
3682  08b2 5c            	incw	x
3683  08b3 1f08          	ldw	(OFST+1,sp),x
3686  08b5 1e05          	ldw	x,(OFST-2,sp)
3687  08b7 5c            	incw	x
3688  08b8 1f05          	ldw	(OFST-2,sp),x
3690                     ; 1062           *pBuffer = ':'; pBuffer++; nBytes++;
3692  08ba 1e08          	ldw	x,(OFST+1,sp)
3693  08bc a63a          	ld	a,#58
3694  08be f7            	ld	(x),a
3697  08bf 5c            	incw	x
3698  08c0 1f08          	ldw	(OFST+1,sp),x
3701  08c2 1e05          	ldw	x,(OFST-2,sp)
3702  08c4 5c            	incw	x
3703  08c5 1f05          	ldw	(OFST-2,sp),x
3705                     ; 1063           *pBuffer = '/'; pBuffer++; nBytes++;
3707  08c7 1e08          	ldw	x,(OFST+1,sp)
3708  08c9 a62f          	ld	a,#47
3709  08cb f7            	ld	(x),a
3712  08cc 5c            	incw	x
3713  08cd 1f08          	ldw	(OFST+1,sp),x
3716  08cf 1e05          	ldw	x,(OFST-2,sp)
3717  08d1 5c            	incw	x
3718  08d2 1f05          	ldw	(OFST-2,sp),x
3720                     ; 1064           *pBuffer = '/'; pBuffer++; nBytes++;
3722  08d4 1e08          	ldw	x,(OFST+1,sp)
3723  08d6 f7            	ld	(x),a
3726  08d7 5c            	incw	x
3727  08d8 1f08          	ldw	(OFST+1,sp),x
3730  08da 1e05          	ldw	x,(OFST-2,sp)
3731  08dc 5c            	incw	x
3732  08dd 1f05          	ldw	(OFST-2,sp),x
3734                     ; 1068           emb_itoa(ex_stored_hostaddr4,  OctetArray, 10, 3);
3736  08df 4b03          	push	#3
3737  08e1 4b0a          	push	#10
3738  08e3 ae0000        	ldw	x,#_OctetArray
3739  08e6 89            	pushw	x
3740  08e7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr4
3741  08ec 3f02          	clr	c_lreg+2
3742  08ee 3f01          	clr	c_lreg+1
3743  08f0 3f00          	clr	c_lreg
3744  08f2 be02          	ldw	x,c_lreg+2
3745  08f4 89            	pushw	x
3746  08f5 be00          	ldw	x,c_lreg
3747  08f7 89            	pushw	x
3748  08f8 cd008c        	call	_emb_itoa
3750  08fb 5b08          	addw	sp,#8
3751                     ; 1070 	  if (OctetArray[0] != '0') {
3753  08fd c60000        	ld	a,_OctetArray
3754  0900 a130          	cp	a,#48
3755  0902 270b          	jreq	L5201
3756                     ; 1071 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3758  0904 1e08          	ldw	x,(OFST+1,sp)
3759  0906 f7            	ld	(x),a
3762  0907 5c            	incw	x
3763  0908 1f08          	ldw	(OFST+1,sp),x
3766  090a 1e05          	ldw	x,(OFST-2,sp)
3767  090c 5c            	incw	x
3768  090d 1f05          	ldw	(OFST-2,sp),x
3770  090f               L5201:
3771                     ; 1073 	  if (OctetArray[0] != '0') {
3773  090f a130          	cp	a,#48
3774  0911 2707          	jreq	L7201
3775                     ; 1074             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3777  0913 1e08          	ldw	x,(OFST+1,sp)
3778  0915 c60001        	ld	a,_OctetArray+1
3782  0918 2009          	jp	LC005
3783  091a               L7201:
3784                     ; 1076 	  else if (OctetArray[1] != '0') {
3786  091a c60001        	ld	a,_OctetArray+1
3787  091d a130          	cp	a,#48
3788  091f 270b          	jreq	L1301
3789                     ; 1077             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3791  0921 1e08          	ldw	x,(OFST+1,sp)
3796  0923               LC005:
3797  0923 f7            	ld	(x),a
3799  0924 5c            	incw	x
3800  0925 1f08          	ldw	(OFST+1,sp),x
3802  0927 1e05          	ldw	x,(OFST-2,sp)
3803  0929 5c            	incw	x
3804  092a 1f05          	ldw	(OFST-2,sp),x
3806  092c               L1301:
3807                     ; 1079           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3809  092c 1e08          	ldw	x,(OFST+1,sp)
3810  092e c60002        	ld	a,_OctetArray+2
3811  0931 f7            	ld	(x),a
3814  0932 5c            	incw	x
3815  0933 1f08          	ldw	(OFST+1,sp),x
3818  0935 1e05          	ldw	x,(OFST-2,sp)
3819  0937 5c            	incw	x
3820  0938 1f05          	ldw	(OFST-2,sp),x
3822                     ; 1081           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3824  093a 1e08          	ldw	x,(OFST+1,sp)
3825  093c a62e          	ld	a,#46
3826  093e f7            	ld	(x),a
3829  093f 5c            	incw	x
3830  0940 1f08          	ldw	(OFST+1,sp),x
3833  0942 1e05          	ldw	x,(OFST-2,sp)
3834  0944 5c            	incw	x
3835  0945 1f05          	ldw	(OFST-2,sp),x
3837                     ; 1084           emb_itoa(ex_stored_hostaddr3,  OctetArray, 10, 3);
3839  0947 4b03          	push	#3
3840  0949 4b0a          	push	#10
3841  094b ae0000        	ldw	x,#_OctetArray
3842  094e 89            	pushw	x
3843  094f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr3
3844  0954 3f02          	clr	c_lreg+2
3845  0956 3f01          	clr	c_lreg+1
3846  0958 3f00          	clr	c_lreg
3847  095a be02          	ldw	x,c_lreg+2
3848  095c 89            	pushw	x
3849  095d be00          	ldw	x,c_lreg
3850  095f 89            	pushw	x
3851  0960 cd008c        	call	_emb_itoa
3853  0963 5b08          	addw	sp,#8
3854                     ; 1086 	  if (OctetArray[0] != '0') {
3856  0965 c60000        	ld	a,_OctetArray
3857  0968 a130          	cp	a,#48
3858  096a 270b          	jreq	L5301
3859                     ; 1087 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3861  096c 1e08          	ldw	x,(OFST+1,sp)
3862  096e f7            	ld	(x),a
3865  096f 5c            	incw	x
3866  0970 1f08          	ldw	(OFST+1,sp),x
3869  0972 1e05          	ldw	x,(OFST-2,sp)
3870  0974 5c            	incw	x
3871  0975 1f05          	ldw	(OFST-2,sp),x
3873  0977               L5301:
3874                     ; 1089 	  if (OctetArray[0] != '0') {
3876  0977 a130          	cp	a,#48
3877  0979 2707          	jreq	L7301
3878                     ; 1090             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3880  097b 1e08          	ldw	x,(OFST+1,sp)
3881  097d c60001        	ld	a,_OctetArray+1
3885  0980 2009          	jp	LC006
3886  0982               L7301:
3887                     ; 1092 	  else if (OctetArray[1] != '0') {
3889  0982 c60001        	ld	a,_OctetArray+1
3890  0985 a130          	cp	a,#48
3891  0987 270b          	jreq	L1401
3892                     ; 1093             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3894  0989 1e08          	ldw	x,(OFST+1,sp)
3899  098b               LC006:
3900  098b f7            	ld	(x),a
3902  098c 5c            	incw	x
3903  098d 1f08          	ldw	(OFST+1,sp),x
3905  098f 1e05          	ldw	x,(OFST-2,sp)
3906  0991 5c            	incw	x
3907  0992 1f05          	ldw	(OFST-2,sp),x
3909  0994               L1401:
3910                     ; 1095           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3912  0994 1e08          	ldw	x,(OFST+1,sp)
3913  0996 c60002        	ld	a,_OctetArray+2
3914  0999 f7            	ld	(x),a
3917  099a 5c            	incw	x
3918  099b 1f08          	ldw	(OFST+1,sp),x
3921  099d 1e05          	ldw	x,(OFST-2,sp)
3922  099f 5c            	incw	x
3923  09a0 1f05          	ldw	(OFST-2,sp),x
3925                     ; 1097           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3927  09a2 1e08          	ldw	x,(OFST+1,sp)
3928  09a4 a62e          	ld	a,#46
3929  09a6 f7            	ld	(x),a
3932  09a7 5c            	incw	x
3933  09a8 1f08          	ldw	(OFST+1,sp),x
3936  09aa 1e05          	ldw	x,(OFST-2,sp)
3937  09ac 5c            	incw	x
3938  09ad 1f05          	ldw	(OFST-2,sp),x
3940                     ; 1100           emb_itoa(ex_stored_hostaddr2,  OctetArray, 10, 3);
3942  09af 4b03          	push	#3
3943  09b1 4b0a          	push	#10
3944  09b3 ae0000        	ldw	x,#_OctetArray
3945  09b6 89            	pushw	x
3946  09b7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr2
3947  09bc 3f02          	clr	c_lreg+2
3948  09be 3f01          	clr	c_lreg+1
3949  09c0 3f00          	clr	c_lreg
3950  09c2 be02          	ldw	x,c_lreg+2
3951  09c4 89            	pushw	x
3952  09c5 be00          	ldw	x,c_lreg
3953  09c7 89            	pushw	x
3954  09c8 cd008c        	call	_emb_itoa
3956  09cb 5b08          	addw	sp,#8
3957                     ; 1102 	  if (OctetArray[0] != '0') {
3959  09cd c60000        	ld	a,_OctetArray
3960  09d0 a130          	cp	a,#48
3961  09d2 270b          	jreq	L5401
3962                     ; 1103 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3964  09d4 1e08          	ldw	x,(OFST+1,sp)
3965  09d6 f7            	ld	(x),a
3968  09d7 5c            	incw	x
3969  09d8 1f08          	ldw	(OFST+1,sp),x
3972  09da 1e05          	ldw	x,(OFST-2,sp)
3973  09dc 5c            	incw	x
3974  09dd 1f05          	ldw	(OFST-2,sp),x
3976  09df               L5401:
3977                     ; 1105 	  if (OctetArray[0] != '0') {
3979  09df a130          	cp	a,#48
3980  09e1 2707          	jreq	L7401
3981                     ; 1106             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3983  09e3 1e08          	ldw	x,(OFST+1,sp)
3984  09e5 c60001        	ld	a,_OctetArray+1
3988  09e8 2009          	jp	LC007
3989  09ea               L7401:
3990                     ; 1108 	  else if (OctetArray[1] != '0') {
3992  09ea c60001        	ld	a,_OctetArray+1
3993  09ed a130          	cp	a,#48
3994  09ef 270b          	jreq	L1501
3995                     ; 1109             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3997  09f1 1e08          	ldw	x,(OFST+1,sp)
4002  09f3               LC007:
4003  09f3 f7            	ld	(x),a
4005  09f4 5c            	incw	x
4006  09f5 1f08          	ldw	(OFST+1,sp),x
4008  09f7 1e05          	ldw	x,(OFST-2,sp)
4009  09f9 5c            	incw	x
4010  09fa 1f05          	ldw	(OFST-2,sp),x
4012  09fc               L1501:
4013                     ; 1111           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
4015  09fc 1e08          	ldw	x,(OFST+1,sp)
4016  09fe c60002        	ld	a,_OctetArray+2
4017  0a01 f7            	ld	(x),a
4020  0a02 5c            	incw	x
4021  0a03 1f08          	ldw	(OFST+1,sp),x
4024  0a05 1e05          	ldw	x,(OFST-2,sp)
4025  0a07 5c            	incw	x
4026  0a08 1f05          	ldw	(OFST-2,sp),x
4028                     ; 1113           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
4030  0a0a 1e08          	ldw	x,(OFST+1,sp)
4031  0a0c a62e          	ld	a,#46
4032  0a0e f7            	ld	(x),a
4035  0a0f 5c            	incw	x
4036  0a10 1f08          	ldw	(OFST+1,sp),x
4039  0a12 1e05          	ldw	x,(OFST-2,sp)
4040  0a14 5c            	incw	x
4041  0a15 1f05          	ldw	(OFST-2,sp),x
4043                     ; 1116           emb_itoa(ex_stored_hostaddr1,  OctetArray, 10, 3);
4045  0a17 4b03          	push	#3
4046  0a19 4b0a          	push	#10
4047  0a1b ae0000        	ldw	x,#_OctetArray
4048  0a1e 89            	pushw	x
4049  0a1f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr1
4050  0a24 3f02          	clr	c_lreg+2
4051  0a26 3f01          	clr	c_lreg+1
4052  0a28 3f00          	clr	c_lreg
4053  0a2a be02          	ldw	x,c_lreg+2
4054  0a2c 89            	pushw	x
4055  0a2d be00          	ldw	x,c_lreg
4056  0a2f 89            	pushw	x
4057  0a30 cd008c        	call	_emb_itoa
4059  0a33 5b08          	addw	sp,#8
4060                     ; 1118 	  if (OctetArray[0] != '0') {
4062  0a35 c60000        	ld	a,_OctetArray
4063  0a38 a130          	cp	a,#48
4064  0a3a 270b          	jreq	L5501
4065                     ; 1119 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
4067  0a3c 1e08          	ldw	x,(OFST+1,sp)
4068  0a3e f7            	ld	(x),a
4071  0a3f 5c            	incw	x
4072  0a40 1f08          	ldw	(OFST+1,sp),x
4075  0a42 1e05          	ldw	x,(OFST-2,sp)
4076  0a44 5c            	incw	x
4077  0a45 1f05          	ldw	(OFST-2,sp),x
4079  0a47               L5501:
4080                     ; 1121 	  if (OctetArray[0] != '0') {
4082  0a47 a130          	cp	a,#48
4083  0a49 2707          	jreq	L7501
4084                     ; 1122             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
4086  0a4b 1e08          	ldw	x,(OFST+1,sp)
4087  0a4d c60001        	ld	a,_OctetArray+1
4091  0a50 2009          	jp	LC008
4092  0a52               L7501:
4093                     ; 1124 	  else if (OctetArray[1] != '0') {
4095  0a52 c60001        	ld	a,_OctetArray+1
4096  0a55 a130          	cp	a,#48
4097  0a57 270b          	jreq	L1601
4098                     ; 1125             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
4100  0a59 1e08          	ldw	x,(OFST+1,sp)
4105  0a5b               LC008:
4106  0a5b f7            	ld	(x),a
4108  0a5c 5c            	incw	x
4109  0a5d 1f08          	ldw	(OFST+1,sp),x
4111  0a5f 1e05          	ldw	x,(OFST-2,sp)
4112  0a61 5c            	incw	x
4113  0a62 1f05          	ldw	(OFST-2,sp),x
4115  0a64               L1601:
4116                     ; 1127           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
4118  0a64 1e08          	ldw	x,(OFST+1,sp)
4119  0a66 c60002        	ld	a,_OctetArray+2
4120  0a69 f7            	ld	(x),a
4123  0a6a 5c            	incw	x
4124  0a6b 1f08          	ldw	(OFST+1,sp),x
4127  0a6d 1e05          	ldw	x,(OFST-2,sp)
4128  0a6f 5c            	incw	x
4129  0a70 1f05          	ldw	(OFST-2,sp),x
4131                     ; 1129           *pBuffer = ':'; pBuffer++; nBytes++; // Output ':'
4133  0a72 1e08          	ldw	x,(OFST+1,sp)
4134  0a74 a63a          	ld	a,#58
4135  0a76 f7            	ld	(x),a
4138  0a77 5c            	incw	x
4139  0a78 1f08          	ldw	(OFST+1,sp),x
4142  0a7a 1e05          	ldw	x,(OFST-2,sp)
4143  0a7c 5c            	incw	x
4144  0a7d 1f05          	ldw	(OFST-2,sp),x
4146                     ; 1132   	  emb_itoa(ex_stored_port, OctetArray, 10, 5);
4148  0a7f 4b05          	push	#5
4149  0a81 4b0a          	push	#10
4150  0a83 ae0000        	ldw	x,#_OctetArray
4151  0a86 89            	pushw	x
4152  0a87 ce0000        	ldw	x,_ex_stored_port
4153  0a8a cd0000        	call	c_uitolx
4155  0a8d be02          	ldw	x,c_lreg+2
4156  0a8f 89            	pushw	x
4157  0a90 be00          	ldw	x,c_lreg
4158  0a92 89            	pushw	x
4159  0a93 cd008c        	call	_emb_itoa
4161  0a96 5b08          	addw	sp,#8
4162                     ; 1134 	  for(i=0; i<5; i++) {
4164  0a98 4f            	clr	a
4165  0a99 6b07          	ld	(OFST+0,sp),a
4167  0a9b               L5601:
4168                     ; 1135 	    if (OctetArray[i] != '0') break;
4170  0a9b 5f            	clrw	x
4171  0a9c 97            	ld	xl,a
4172  0a9d d60000        	ld	a,(_OctetArray,x)
4173  0aa0 a130          	cp	a,#48
4174  0aa2 261c          	jrne	L7701
4177                     ; 1134 	  for(i=0; i<5; i++) {
4179  0aa4 0c07          	inc	(OFST+0,sp)
4183  0aa6 7b07          	ld	a,(OFST+0,sp)
4184  0aa8 a105          	cp	a,#5
4185  0aaa 25ef          	jrult	L5601
4186  0aac 2012          	jra	L7701
4187  0aae               L5701:
4188                     ; 1138 	    *pBuffer = OctetArray[i]; pBuffer++; nBytes++;
4190  0aae 5f            	clrw	x
4191  0aaf 97            	ld	xl,a
4192  0ab0 d60000        	ld	a,(_OctetArray,x)
4193  0ab3 1e08          	ldw	x,(OFST+1,sp)
4194  0ab5 f7            	ld	(x),a
4197  0ab6 5c            	incw	x
4198  0ab7 1f08          	ldw	(OFST+1,sp),x
4201  0ab9 1e05          	ldw	x,(OFST-2,sp)
4202  0abb 5c            	incw	x
4203  0abc 1f05          	ldw	(OFST-2,sp),x
4205                     ; 1139 	    i++;
4207  0abe 0c07          	inc	(OFST+0,sp)
4209  0ac0               L7701:
4210                     ; 1137 	  while(i<5) {
4212  0ac0 7b07          	ld	a,(OFST+0,sp)
4213  0ac2 a105          	cp	a,#5
4214  0ac4 25e8          	jrult	L5701
4215                     ; 1144           *ppData = *ppData + 28;
4217  0ac6 1e0c          	ldw	x,(OFST+5,sp)
4218  0ac8 9093          	ldw	y,x
4219  0aca fe            	ldw	x,(x)
4220  0acb 1c001c        	addw	x,#28
4221  0ace 90ff          	ldw	(y),x
4222                     ; 1145           *pDataLeft = *pDataLeft - 28;
4224  0ad0 1e0e          	ldw	x,(OFST+7,sp)
4225  0ad2 9093          	ldw	y,x
4226  0ad4 fe            	ldw	x,(x)
4227  0ad5 1d001c        	subw	x,#28
4228  0ad8 cc0832        	jp	LC011
4229  0adb               L116:
4230                     ; 1149         *pBuffer = nByte;
4232  0adb 1e08          	ldw	x,(OFST+1,sp)
4233  0add f7            	ld	(x),a
4234                     ; 1150         *ppData = *ppData + 1;
4236  0ade 1e0c          	ldw	x,(OFST+5,sp)
4237  0ae0 9093          	ldw	y,x
4238  0ae2 fe            	ldw	x,(x)
4239  0ae3 5c            	incw	x
4240  0ae4 90ff          	ldw	(y),x
4241                     ; 1151         *pDataLeft = *pDataLeft - 1;
4243  0ae6 1e0e          	ldw	x,(OFST+7,sp)
4244  0ae8 9093          	ldw	y,x
4245  0aea fe            	ldw	x,(x)
4246  0aeb 5a            	decw	x
4247  0aec 90ff          	ldw	(y),x
4248                     ; 1152         pBuffer++;
4250  0aee 1e08          	ldw	x,(OFST+1,sp)
4251                     ; 1153         nBytes++;
4253  0af0               LC009:
4256  0af0 5c            	incw	x
4257  0af1 1f08          	ldw	(OFST+1,sp),x
4260  0af3 1e05          	ldw	x,(OFST-2,sp)
4261  0af5 5c            	incw	x
4262  0af6 1f05          	ldw	(OFST-2,sp),x
4264  0af8               L306:
4265                     ; 714   while (nBytes < nMaxBytes) {
4267  0af8 1e05          	ldw	x,(OFST-2,sp)
4268  0afa 1310          	cpw	x,(OFST+9,sp)
4269  0afc 2403cc02e1    	jrult	L106
4270  0b01               L506:
4271                     ; 1158   return nBytes;
4273  0b01 1e05          	ldw	x,(OFST-2,sp)
4276  0b03 5b09          	addw	sp,#9
4277  0b05 81            	ret	
4304                     ; 1162 void HttpDInit()
4304                     ; 1163 {
4305                     	switch	.text
4306  0b06               _HttpDInit:
4310                     ; 1165   uip_listen(htons(Port_Httpd));
4312  0b06 ce0000        	ldw	x,_Port_Httpd
4313  0b09 cd0000        	call	_htons
4315  0b0c cd0000        	call	_uip_listen
4317                     ; 1166   current_webpage = WEBPAGE_DEFAULT;
4319  0b0f 725f000b      	clr	_current_webpage
4320                     ; 1167 }
4323  0b13 81            	ret	
4529                     	switch	.const
4530  4172               L472:
4531  4172 108d          	dc.w	L7111
4532  4174 1094          	dc.w	L1211
4533  4176 109b          	dc.w	L3211
4534  4178 10a2          	dc.w	L5211
4535  417a 10a9          	dc.w	L7211
4536  417c 10b0          	dc.w	L1311
4537  417e 10b7          	dc.w	L3311
4538  4180 10be          	dc.w	L5311
4539  4182 10c5          	dc.w	L7311
4540  4184 10cc          	dc.w	L1411
4541  4186 10d3          	dc.w	L3411
4542  4188 10da          	dc.w	L5411
4543  418a 10e1          	dc.w	L7411
4544  418c 10e8          	dc.w	L1511
4545  418e 10ef          	dc.w	L3511
4546  4190 10f6          	dc.w	L5511
4547  4192 10fd          	dc.w	L7511
4548  4194 1104          	dc.w	L1611
4549  4196 110b          	dc.w	L3611
4550  4198 1112          	dc.w	L5611
4551  419a 1119          	dc.w	L7611
4552  419c 1120          	dc.w	L1711
4553  419e 1127          	dc.w	L3711
4554  41a0 112e          	dc.w	L5711
4555  41a2 1135          	dc.w	L7711
4556  41a4 113c          	dc.w	L1021
4557  41a6 1143          	dc.w	L3021
4558  41a8 114a          	dc.w	L5021
4559  41aa 1151          	dc.w	L7021
4560  41ac 1158          	dc.w	L1121
4561  41ae 115f          	dc.w	L3121
4562  41b0 1166          	dc.w	L5121
4563  41b2 11f3          	dc.w	L3421
4564  41b4 11f3          	dc.w	L3421
4565  41b6 11f3          	dc.w	L3421
4566  41b8 11f3          	dc.w	L3421
4567  41ba 11f3          	dc.w	L3421
4568  41bc 11f3          	dc.w	L3421
4569  41be 11f3          	dc.w	L3421
4570  41c0 11f3          	dc.w	L3421
4571  41c2 11f3          	dc.w	L3421
4572  41c4 11f3          	dc.w	L3421
4573  41c6 11f3          	dc.w	L3421
4574  41c8 11f3          	dc.w	L3421
4575  41ca 11f3          	dc.w	L3421
4576  41cc 11f3          	dc.w	L3421
4577  41ce 11f3          	dc.w	L3421
4578  41d0 11f3          	dc.w	L3421
4579  41d2 11f3          	dc.w	L3421
4580  41d4 11f3          	dc.w	L3421
4581  41d6 11f3          	dc.w	L3421
4582  41d8 11f3          	dc.w	L3421
4583  41da 11f3          	dc.w	L3421
4584  41dc 11f3          	dc.w	L3421
4585  41de 11f3          	dc.w	L3421
4586  41e0 116d          	dc.w	L7121
4587  41e2 1178          	dc.w	L1221
4588  41e4 11f3          	dc.w	L3421
4589  41e6 11f3          	dc.w	L3421
4590  41e8 11f3          	dc.w	L3421
4591  41ea 1183          	dc.w	L3221
4592  41ec 1185          	dc.w	L5221
4593  41ee 11f3          	dc.w	L3421
4594  41f0 1197          	dc.w	L7221
4595  41f2 11a9          	dc.w	L1321
4596  41f4 11bb          	dc.w	L3321
4597  41f6 11c6          	dc.w	L5321
4598                     ; 1170 void HttpDCall(	uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
4598                     ; 1171 {
4599                     	switch	.text
4600  0b14               _HttpDCall:
4602  0b14 89            	pushw	x
4603  0b15 5207          	subw	sp,#7
4604       00000007      OFST:	set	7
4607                     ; 1181   alpha_1 = '0';
4609                     ; 1182   alpha_2 = '0';
4611                     ; 1183   alpha_3 = '0';
4613                     ; 1184   alpha_4 = '0';
4615                     ; 1185   alpha_5 = '0';
4617                     ; 1187   if(uip_connected()) {
4619  0b17 720d00007a    	btjf	_uip_flags,#6,L3431
4620                     ; 1189     if(current_webpage == WEBPAGE_DEFAULT) {
4622  0b1c c6000b        	ld	a,_current_webpage
4623  0b1f 260e          	jrne	L5431
4624                     ; 1190       pSocket->pData = g_HtmlPageDefault;
4626  0b21 1e0e          	ldw	x,(OFST+7,sp)
4627  0b23 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
4628  0b27 ef01          	ldw	(1,x),y
4629                     ; 1191       pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
4631  0b29 90ae1876      	ldw	y,#6262
4633  0b2d 2058          	jp	LC012
4634  0b2f               L5431:
4635                     ; 1195     else if(current_webpage == WEBPAGE_ADDRESS) {
4637  0b2f a101          	cp	a,#1
4638  0b31 260e          	jrne	L1531
4639                     ; 1196       pSocket->pData = g_HtmlPageAddress;
4641  0b33 1e0e          	ldw	x,(OFST+7,sp)
4642  0b35 90ae187f      	ldw	y,#L71_g_HtmlPageAddress
4643  0b39 ef01          	ldw	(1,x),y
4644                     ; 1197       pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
4646  0b3b 90ae133a      	ldw	y,#4922
4648  0b3f 2046          	jp	LC012
4649  0b41               L1531:
4650                     ; 1201     else if(current_webpage == WEBPAGE_HELP) {
4652  0b41 a103          	cp	a,#3
4653  0b43 260e          	jrne	L5531
4654                     ; 1202       pSocket->pData = g_HtmlPageHelp;
4656  0b45 1e0e          	ldw	x,(OFST+7,sp)
4657  0b47 90ae2bba      	ldw	y,#L12_g_HtmlPageHelp
4658  0b4b ef01          	ldw	(1,x),y
4659                     ; 1203       pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
4661  0b4d 90ae0753      	ldw	y,#1875
4663  0b51 2034          	jp	LC012
4664  0b53               L5531:
4665                     ; 1205     else if(current_webpage == WEBPAGE_HELP2) {
4667  0b53 a104          	cp	a,#4
4668  0b55 260e          	jrne	L1631
4669                     ; 1206       pSocket->pData = g_HtmlPageHelp2;
4671  0b57 1e0e          	ldw	x,(OFST+7,sp)
4672  0b59 90ae330e      	ldw	y,#L32_g_HtmlPageHelp2
4673  0b5d ef01          	ldw	(1,x),y
4674                     ; 1207       pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
4676  0b5f 90ae02b4      	ldw	y,#692
4678  0b63 2022          	jp	LC012
4679  0b65               L1631:
4680                     ; 1212     else if(current_webpage == WEBPAGE_STATS) {
4682  0b65 a105          	cp	a,#5
4683  0b67 260e          	jrne	L5631
4684                     ; 1213       pSocket->pData = g_HtmlPageStats;
4686  0b69 1e0e          	ldw	x,(OFST+7,sp)
4687  0b6b 90ae35c3      	ldw	y,#L52_g_HtmlPageStats
4688  0b6f ef01          	ldw	(1,x),y
4689                     ; 1214       pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
4691  0b71 90ae0ae5      	ldw	y,#2789
4693  0b75 2010          	jp	LC012
4694  0b77               L5631:
4695                     ; 1217     else if(current_webpage == WEBPAGE_RSTATE) {
4697  0b77 a106          	cp	a,#6
4698  0b79 260e          	jrne	L7431
4699                     ; 1218       pSocket->pData = g_HtmlPageRstate;
4701  0b7b 1e0e          	ldw	x,(OFST+7,sp)
4702  0b7d 90ae40a9      	ldw	y,#L72_g_HtmlPageRstate
4703  0b81 ef01          	ldw	(1,x),y
4704                     ; 1219       pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
4706  0b83 90ae0084      	ldw	y,#132
4707  0b87               LC012:
4708  0b87 ef03          	ldw	(3,x),y
4709  0b89               L7431:
4710                     ; 1221     pSocket->nNewlines = 0;
4712  0b89 1e0e          	ldw	x,(OFST+7,sp)
4713                     ; 1222     pSocket->nState = STATE_CONNECTED;
4715  0b8b 7f            	clr	(x)
4716  0b8c 6f05          	clr	(5,x)
4717                     ; 1223     pSocket->nPrevBytes = 0xFFFF;
4719  0b8e 90aeffff      	ldw	y,#65535
4720  0b92 ef0a          	ldw	(10,x),y
4722  0b94 2041          	jra	L613
4723  0b96               L3431:
4724                     ; 1225   else if (uip_newdata() || uip_acked()) {
4726  0b96 7202000008    	btjt	_uip_flags,#1,L7731
4728  0b9b 7200000003cc  	btjf	_uip_flags,#0,L5731
4729  0ba3               L7731:
4730                     ; 1226     if (pSocket->nState == STATE_CONNECTED) {
4732  0ba3 1e0e          	ldw	x,(OFST+7,sp)
4733  0ba5 f6            	ld	a,(x)
4734  0ba6 2627          	jrne	L1041
4735                     ; 1227       if (nBytes == 0) return;
4737  0ba8 1e0c          	ldw	x,(OFST+5,sp)
4738  0baa 272b          	jreq	L613
4741                     ; 1228       if (*pBuffer == 'G') pSocket->nState = STATE_GET_G;
4743  0bac 1e08          	ldw	x,(OFST+1,sp)
4744  0bae f6            	ld	a,(x)
4745  0baf a147          	cp	a,#71
4746  0bb1 2606          	jrne	L5041
4749  0bb3 1e0e          	ldw	x,(OFST+7,sp)
4750  0bb5 a601          	ld	a,#1
4752  0bb7 2008          	jp	LC013
4753  0bb9               L5041:
4754                     ; 1229       else if (*pBuffer == 'P') pSocket->nState = STATE_POST_P;
4756  0bb9 a150          	cp	a,#80
4757  0bbb 2605          	jrne	L7041
4760  0bbd 1e0e          	ldw	x,(OFST+7,sp)
4761  0bbf a604          	ld	a,#4
4762  0bc1               LC013:
4763  0bc1 f7            	ld	(x),a
4764  0bc2               L7041:
4765                     ; 1230       nBytes--;
4767  0bc2 1e0c          	ldw	x,(OFST+5,sp)
4768  0bc4 5a            	decw	x
4769  0bc5 1f0c          	ldw	(OFST+5,sp),x
4770                     ; 1231       pBuffer++;
4772  0bc7 1e08          	ldw	x,(OFST+1,sp)
4773  0bc9 5c            	incw	x
4774  0bca 1f08          	ldw	(OFST+1,sp),x
4775  0bcc 1e0e          	ldw	x,(OFST+7,sp)
4776  0bce f6            	ld	a,(x)
4777  0bcf               L1041:
4778                     ; 1234     if (pSocket->nState == STATE_GET_G) {
4780  0bcf a101          	cp	a,#1
4781  0bd1 2620          	jrne	L3141
4782                     ; 1235       if (nBytes == 0) return;
4784  0bd3 1e0c          	ldw	x,(OFST+5,sp)
4785  0bd5 2603          	jrne	L5141
4787  0bd7               L613:
4790  0bd7 5b09          	addw	sp,#9
4791  0bd9 81            	ret	
4792  0bda               L5141:
4793                     ; 1236       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
4795  0bda 1e08          	ldw	x,(OFST+1,sp)
4796  0bdc f6            	ld	a,(x)
4797  0bdd a145          	cp	a,#69
4798  0bdf 2605          	jrne	L7141
4801  0be1 1e0e          	ldw	x,(OFST+7,sp)
4802  0be3 a602          	ld	a,#2
4803  0be5 f7            	ld	(x),a
4804  0be6               L7141:
4805                     ; 1237       nBytes--;
4807  0be6 1e0c          	ldw	x,(OFST+5,sp)
4808  0be8 5a            	decw	x
4809  0be9 1f0c          	ldw	(OFST+5,sp),x
4810                     ; 1238       pBuffer++;
4812  0beb 1e08          	ldw	x,(OFST+1,sp)
4813  0bed 5c            	incw	x
4814  0bee 1f08          	ldw	(OFST+1,sp),x
4815  0bf0 1e0e          	ldw	x,(OFST+7,sp)
4816  0bf2 f6            	ld	a,(x)
4817  0bf3               L3141:
4818                     ; 1241     if (pSocket->nState == STATE_GET_GE) {
4820  0bf3 a102          	cp	a,#2
4821  0bf5 261d          	jrne	L1241
4822                     ; 1242       if (nBytes == 0) return;
4824  0bf7 1e0c          	ldw	x,(OFST+5,sp)
4825  0bf9 27dc          	jreq	L613
4828                     ; 1243       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
4830  0bfb 1e08          	ldw	x,(OFST+1,sp)
4831  0bfd f6            	ld	a,(x)
4832  0bfe a154          	cp	a,#84
4833  0c00 2605          	jrne	L5241
4836  0c02 1e0e          	ldw	x,(OFST+7,sp)
4837  0c04 a603          	ld	a,#3
4838  0c06 f7            	ld	(x),a
4839  0c07               L5241:
4840                     ; 1244       nBytes--;
4842  0c07 1e0c          	ldw	x,(OFST+5,sp)
4843  0c09 5a            	decw	x
4844  0c0a 1f0c          	ldw	(OFST+5,sp),x
4845                     ; 1245       pBuffer++;
4847  0c0c 1e08          	ldw	x,(OFST+1,sp)
4848  0c0e 5c            	incw	x
4849  0c0f 1f08          	ldw	(OFST+1,sp),x
4850  0c11 1e0e          	ldw	x,(OFST+7,sp)
4851  0c13 f6            	ld	a,(x)
4852  0c14               L1241:
4853                     ; 1248     if (pSocket->nState == STATE_GET_GET) {
4855  0c14 a103          	cp	a,#3
4856  0c16 261d          	jrne	L7241
4857                     ; 1249       if (nBytes == 0) return;
4859  0c18 1e0c          	ldw	x,(OFST+5,sp)
4860  0c1a 27bb          	jreq	L613
4863                     ; 1250       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
4865  0c1c 1e08          	ldw	x,(OFST+1,sp)
4866  0c1e f6            	ld	a,(x)
4867  0c1f a120          	cp	a,#32
4868  0c21 2605          	jrne	L3341
4871  0c23 1e0e          	ldw	x,(OFST+7,sp)
4872  0c25 a608          	ld	a,#8
4873  0c27 f7            	ld	(x),a
4874  0c28               L3341:
4875                     ; 1251       nBytes--;
4877  0c28 1e0c          	ldw	x,(OFST+5,sp)
4878  0c2a 5a            	decw	x
4879  0c2b 1f0c          	ldw	(OFST+5,sp),x
4880                     ; 1252       pBuffer++;
4882  0c2d 1e08          	ldw	x,(OFST+1,sp)
4883  0c2f 5c            	incw	x
4884  0c30 1f08          	ldw	(OFST+1,sp),x
4885  0c32 1e0e          	ldw	x,(OFST+7,sp)
4886  0c34 f6            	ld	a,(x)
4887  0c35               L7241:
4888                     ; 1255     if (pSocket->nState == STATE_POST_P) {
4890  0c35 a104          	cp	a,#4
4891  0c37 261d          	jrne	L5341
4892                     ; 1256       if (nBytes == 0) return;
4894  0c39 1e0c          	ldw	x,(OFST+5,sp)
4895  0c3b 279a          	jreq	L613
4898                     ; 1257       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
4900  0c3d 1e08          	ldw	x,(OFST+1,sp)
4901  0c3f f6            	ld	a,(x)
4902  0c40 a14f          	cp	a,#79
4903  0c42 2605          	jrne	L1441
4906  0c44 1e0e          	ldw	x,(OFST+7,sp)
4907  0c46 a605          	ld	a,#5
4908  0c48 f7            	ld	(x),a
4909  0c49               L1441:
4910                     ; 1258       nBytes--;
4912  0c49 1e0c          	ldw	x,(OFST+5,sp)
4913  0c4b 5a            	decw	x
4914  0c4c 1f0c          	ldw	(OFST+5,sp),x
4915                     ; 1259       pBuffer++;
4917  0c4e 1e08          	ldw	x,(OFST+1,sp)
4918  0c50 5c            	incw	x
4919  0c51 1f08          	ldw	(OFST+1,sp),x
4920  0c53 1e0e          	ldw	x,(OFST+7,sp)
4921  0c55 f6            	ld	a,(x)
4922  0c56               L5341:
4923                     ; 1262     if (pSocket->nState == STATE_POST_PO) {
4925  0c56 a105          	cp	a,#5
4926  0c58 2620          	jrne	L3441
4927                     ; 1263       if (nBytes == 0) return;
4929  0c5a 1e0c          	ldw	x,(OFST+5,sp)
4930  0c5c 2603cc0bd7    	jreq	L613
4933                     ; 1264       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
4935  0c61 1e08          	ldw	x,(OFST+1,sp)
4936  0c63 f6            	ld	a,(x)
4937  0c64 a153          	cp	a,#83
4938  0c66 2605          	jrne	L7441
4941  0c68 1e0e          	ldw	x,(OFST+7,sp)
4942  0c6a a606          	ld	a,#6
4943  0c6c f7            	ld	(x),a
4944  0c6d               L7441:
4945                     ; 1265       nBytes--;
4947  0c6d 1e0c          	ldw	x,(OFST+5,sp)
4948  0c6f 5a            	decw	x
4949  0c70 1f0c          	ldw	(OFST+5,sp),x
4950                     ; 1266       pBuffer++;
4952  0c72 1e08          	ldw	x,(OFST+1,sp)
4953  0c74 5c            	incw	x
4954  0c75 1f08          	ldw	(OFST+1,sp),x
4955  0c77 1e0e          	ldw	x,(OFST+7,sp)
4956  0c79 f6            	ld	a,(x)
4957  0c7a               L3441:
4958                     ; 1269     if (pSocket->nState == STATE_POST_POS) {
4960  0c7a a106          	cp	a,#6
4961  0c7c 261d          	jrne	L1541
4962                     ; 1270       if (nBytes == 0) return;
4964  0c7e 1e0c          	ldw	x,(OFST+5,sp)
4965  0c80 27dc          	jreq	L613
4968                     ; 1271       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
4970  0c82 1e08          	ldw	x,(OFST+1,sp)
4971  0c84 f6            	ld	a,(x)
4972  0c85 a154          	cp	a,#84
4973  0c87 2605          	jrne	L5541
4976  0c89 1e0e          	ldw	x,(OFST+7,sp)
4977  0c8b a607          	ld	a,#7
4978  0c8d f7            	ld	(x),a
4979  0c8e               L5541:
4980                     ; 1272       nBytes--;
4982  0c8e 1e0c          	ldw	x,(OFST+5,sp)
4983  0c90 5a            	decw	x
4984  0c91 1f0c          	ldw	(OFST+5,sp),x
4985                     ; 1273       pBuffer++;
4987  0c93 1e08          	ldw	x,(OFST+1,sp)
4988  0c95 5c            	incw	x
4989  0c96 1f08          	ldw	(OFST+1,sp),x
4990  0c98 1e0e          	ldw	x,(OFST+7,sp)
4991  0c9a f6            	ld	a,(x)
4992  0c9b               L1541:
4993                     ; 1276     if (pSocket->nState == STATE_POST_POST) {
4995  0c9b a107          	cp	a,#7
4996  0c9d 261d          	jrne	L7541
4997                     ; 1277       if (nBytes == 0) return;
4999  0c9f 1e0c          	ldw	x,(OFST+5,sp)
5000  0ca1 27bb          	jreq	L613
5003                     ; 1278       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
5005  0ca3 1e08          	ldw	x,(OFST+1,sp)
5006  0ca5 f6            	ld	a,(x)
5007  0ca6 a120          	cp	a,#32
5008  0ca8 2605          	jrne	L3641
5011  0caa 1e0e          	ldw	x,(OFST+7,sp)
5012  0cac a609          	ld	a,#9
5013  0cae f7            	ld	(x),a
5014  0caf               L3641:
5015                     ; 1279       nBytes--;
5017  0caf 1e0c          	ldw	x,(OFST+5,sp)
5018  0cb1 5a            	decw	x
5019  0cb2 1f0c          	ldw	(OFST+5,sp),x
5020                     ; 1280       pBuffer++;
5022  0cb4 1e08          	ldw	x,(OFST+1,sp)
5023  0cb6 5c            	incw	x
5024  0cb7 1f08          	ldw	(OFST+1,sp),x
5025  0cb9 1e0e          	ldw	x,(OFST+7,sp)
5026  0cbb f6            	ld	a,(x)
5027  0cbc               L7541:
5028                     ; 1283     if (pSocket->nState == STATE_GOTPOST) {
5030  0cbc a109          	cp	a,#9
5031  0cbe 264c          	jrne	L5641
5033  0cc0 2046          	jra	L1741
5034  0cc2               L7641:
5035                     ; 1286         if (*pBuffer == '\n') {
5037  0cc2 1e08          	ldw	x,(OFST+1,sp)
5038  0cc4 f6            	ld	a,(x)
5039  0cc5 a10a          	cp	a,#10
5040  0cc7 2606          	jrne	L5741
5041                     ; 1287           pSocket->nNewlines++;
5043  0cc9 1e0e          	ldw	x,(OFST+7,sp)
5044  0ccb 6c05          	inc	(5,x)
5046  0ccd 2008          	jra	L7741
5047  0ccf               L5741:
5048                     ; 1289         else if (*pBuffer == '\r') {
5050  0ccf a10d          	cp	a,#13
5051  0cd1 2704          	jreq	L7741
5053                     ; 1292           pSocket->nNewlines = 0;
5055  0cd3 1e0e          	ldw	x,(OFST+7,sp)
5056  0cd5 6f05          	clr	(5,x)
5057  0cd7               L7741:
5058                     ; 1294         pBuffer++;
5060  0cd7 1e08          	ldw	x,(OFST+1,sp)
5061  0cd9 5c            	incw	x
5062  0cda 1f08          	ldw	(OFST+1,sp),x
5063                     ; 1295         nBytes--;
5065  0cdc 1e0c          	ldw	x,(OFST+5,sp)
5066  0cde 5a            	decw	x
5067  0cdf 1f0c          	ldw	(OFST+5,sp),x
5068                     ; 1296         if (pSocket->nNewlines == 2) {
5070  0ce1 1e0e          	ldw	x,(OFST+7,sp)
5071  0ce3 e605          	ld	a,(5,x)
5072  0ce5 a102          	cp	a,#2
5073  0ce7 261f          	jrne	L1741
5074                     ; 1298           if (pSocket->nState == STATE_GOTPOST) {
5076  0ce9 f6            	ld	a,(x)
5077  0cea a109          	cp	a,#9
5078  0cec 261e          	jrne	L5641
5079                     ; 1300             if(current_webpage == WEBPAGE_DEFAULT) pSocket->nParseLeft = PARSEBYTES_DEFAULT;
5081  0cee c6000b        	ld	a,_current_webpage
5082  0cf1 2607          	jrne	L1151
5085  0cf3 a67e          	ld	a,#126
5086  0cf5 e706          	ld	(6,x),a
5087  0cf7 c6000b        	ld	a,_current_webpage
5088  0cfa               L1151:
5089                     ; 1301             if(current_webpage == WEBPAGE_ADDRESS) pSocket->nParseLeft = PARSEBYTES_ADDRESS;
5091  0cfa 4a            	dec	a
5092  0cfb 2604          	jrne	L3151
5095  0cfd a693          	ld	a,#147
5096  0cff e706          	ld	(6,x),a
5097  0d01               L3151:
5098                     ; 1302             pSocket->ParseState = PARSE_CMD;
5100  0d01 6f09          	clr	(9,x)
5101                     ; 1304             pSocket->nState = STATE_PARSEPOST;
5103  0d03 a60a          	ld	a,#10
5104  0d05 f7            	ld	(x),a
5105  0d06 2004          	jra	L5641
5106  0d08               L1741:
5107                     ; 1285       while (nBytes != 0) {
5109  0d08 1e0c          	ldw	x,(OFST+5,sp)
5110  0d0a 26b6          	jrne	L7641
5111  0d0c               L5641:
5112                     ; 1311     if (pSocket->nState == STATE_GOTGET) {
5114  0d0c 1e0e          	ldw	x,(OFST+7,sp)
5115  0d0e f6            	ld	a,(x)
5116  0d0f a108          	cp	a,#8
5117  0d11 2609          	jrne	L5151
5118                     ; 1314       pSocket->nParseLeft = 6; // Small parse number since we should have short
5120  0d13 a606          	ld	a,#6
5121  0d15 e706          	ld	(6,x),a
5122                     ; 1316       pSocket->ParseState = PARSE_SLASH1;
5124  0d17 e709          	ld	(9,x),a
5125                     ; 1318       pSocket->nState = STATE_PARSEGET;
5127  0d19 a60d          	ld	a,#13
5128  0d1b f7            	ld	(x),a
5129  0d1c               L5151:
5130                     ; 1321     if (pSocket->nState == STATE_PARSEPOST) {
5132  0d1c a10a          	cp	a,#10
5133  0d1e 2703cc0f8e    	jrne	L7151
5135  0d23 cc0f7f        	jra	L3251
5136  0d26               L1251:
5137                     ; 1331         if (pSocket->ParseState == PARSE_CMD) {
5139  0d26 1e0e          	ldw	x,(OFST+7,sp)
5140  0d28 e609          	ld	a,(9,x)
5141  0d2a 263e          	jrne	L7251
5142                     ; 1332           pSocket->ParseCmd = *pBuffer;
5144  0d2c 1e08          	ldw	x,(OFST+1,sp)
5145  0d2e f6            	ld	a,(x)
5146  0d2f 1e0e          	ldw	x,(OFST+7,sp)
5147  0d31 e707          	ld	(7,x),a
5148                     ; 1333           pSocket->ParseState = PARSE_NUM10;
5150  0d33 a601          	ld	a,#1
5151  0d35 e709          	ld	(9,x),a
5152                     ; 1334 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5154  0d37 e606          	ld	a,(6,x)
5155  0d39 2704          	jreq	L1351
5158  0d3b 6a06          	dec	(6,x)
5160  0d3d 2004          	jra	L3351
5161  0d3f               L1351:
5162                     ; 1335 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5164  0d3f a605          	ld	a,#5
5165  0d41 e709          	ld	(9,x),a
5166  0d43               L3351:
5167                     ; 1336           pBuffer++;
5169  0d43 1e08          	ldw	x,(OFST+1,sp)
5170  0d45 5c            	incw	x
5171  0d46 1f08          	ldw	(OFST+1,sp),x
5172                     ; 1338 	  if (pSocket->ParseCmd == 'o' ||
5172                     ; 1339 	      pSocket->ParseCmd == 'a' ||
5172                     ; 1340 	      pSocket->ParseCmd == 'b' ||
5172                     ; 1341 	      pSocket->ParseCmd == 'c' ||
5172                     ; 1342 	      pSocket->ParseCmd == 'd' ||
5172                     ; 1343 	      pSocket->ParseCmd == 'g') { }
5174  0d48 1e0e          	ldw	x,(OFST+7,sp)
5175  0d4a e607          	ld	a,(7,x)
5176  0d4c a16f          	cp	a,#111
5177  0d4e 2603cc0f71    	jreq	L3551
5179  0d53 a161          	cp	a,#97
5180  0d55 27f9          	jreq	L3551
5182  0d57 a162          	cp	a,#98
5183  0d59 27f5          	jreq	L3551
5185  0d5b a163          	cp	a,#99
5186  0d5d 27f1          	jreq	L3551
5188  0d5f a164          	cp	a,#100
5189  0d61 27ed          	jreq	L3551
5191  0d63 a167          	cp	a,#103
5192  0d65 27e9          	jreq	L3551
5193                     ; 1344 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5194  0d67 cc0f56        	jp	LC018
5195  0d6a               L7251:
5196                     ; 1346         else if (pSocket->ParseState == PARSE_NUM10) {
5198  0d6a a101          	cp	a,#1
5199  0d6c 2619          	jrne	L5551
5200                     ; 1347           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5202  0d6e 1e08          	ldw	x,(OFST+1,sp)
5203  0d70 f6            	ld	a,(x)
5204  0d71 97            	ld	xl,a
5205  0d72 a60a          	ld	a,#10
5206  0d74 42            	mul	x,a
5207  0d75 9f            	ld	a,xl
5208  0d76 1e0e          	ldw	x,(OFST+7,sp)
5209  0d78 a0e0          	sub	a,#224
5210  0d7a e708          	ld	(8,x),a
5211                     ; 1348           pSocket->ParseState = PARSE_NUM1;
5213  0d7c a602          	ld	a,#2
5214  0d7e e709          	ld	(9,x),a
5215                     ; 1349 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5217  0d80 e606          	ld	a,(6,x)
5218  0d82 2719          	jreq	L7651
5221  0d84 cc0f66        	jp	LC025
5222                     ; 1350 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5223                     ; 1351           pBuffer++;
5225  0d87               L5551:
5226                     ; 1353         else if (pSocket->ParseState == PARSE_NUM1) {
5228  0d87 a102          	cp	a,#2
5229  0d89 2616          	jrne	L5651
5230                     ; 1354           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5232  0d8b 1608          	ldw	y,(OFST+1,sp)
5233  0d8d 90f6          	ld	a,(y)
5234  0d8f a030          	sub	a,#48
5235  0d91 eb08          	add	a,(8,x)
5236  0d93 e708          	ld	(8,x),a
5237                     ; 1355           pSocket->ParseState = PARSE_EQUAL;
5239  0d95 a603          	ld	a,#3
5240  0d97 e709          	ld	(9,x),a
5241                     ; 1356 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5243  0d99 e606          	ld	a,(6,x)
5246  0d9b 26e7          	jrne	LC025
5247  0d9d               L7651:
5248                     ; 1357 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5251  0d9d a605          	ld	a,#5
5252                     ; 1358           pBuffer++;
5254  0d9f 200d          	jp	LC026
5255  0da1               L5651:
5256                     ; 1360         else if (pSocket->ParseState == PARSE_EQUAL) {
5258  0da1 a103          	cp	a,#3
5259  0da3 260e          	jrne	L5751
5260                     ; 1361           pSocket->ParseState = PARSE_VAL;
5262  0da5 a604          	ld	a,#4
5263  0da7 e709          	ld	(9,x),a
5264                     ; 1362 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5266  0da9 6d06          	tnz	(6,x)
5269  0dab 26d7          	jrne	LC025
5270                     ; 1363 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5272  0dad 4c            	inc	a
5273  0dae               LC026:
5274  0dae e709          	ld	(9,x),a
5275                     ; 1364           pBuffer++;
5277  0db0 cc0f68        	jp	LC017
5278  0db3               L5751:
5279                     ; 1366         else if (pSocket->ParseState == PARSE_VAL) {
5281  0db3 a104          	cp	a,#4
5282  0db5 2703cc0f5c    	jrne	L5061
5283                     ; 1374           if (pSocket->ParseCmd == 'o') {
5285  0dba e607          	ld	a,(7,x)
5286  0dbc a16f          	cp	a,#111
5287  0dbe 2625          	jrne	L7061
5288                     ; 1377             if ((uint8_t)(*pBuffer) == '1') GpioSetPin(pSocket->ParseNum, (uint8_t)1);
5290  0dc0 1e08          	ldw	x,(OFST+1,sp)
5291  0dc2 f6            	ld	a,(x)
5292  0dc3 a131          	cp	a,#49
5293  0dc5 2609          	jrne	L1161
5296  0dc7 1e0e          	ldw	x,(OFST+7,sp)
5297  0dc9 e608          	ld	a,(8,x)
5298  0dcb ae0001        	ldw	x,#1
5301  0dce 2005          	jra	L3161
5302  0dd0               L1161:
5303                     ; 1378             else GpioSetPin(pSocket->ParseNum, (uint8_t)0);
5305  0dd0 1e0e          	ldw	x,(OFST+7,sp)
5306  0dd2 e608          	ld	a,(8,x)
5307  0dd4 5f            	clrw	x
5309  0dd5               L3161:
5310  0dd5 95            	ld	xh,a
5311  0dd6 cd13f5        	call	_GpioSetPin
5312                     ; 1379 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5314  0dd9 1e0e          	ldw	x,(OFST+7,sp)
5315  0ddb e606          	ld	a,(6,x)
5316  0ddd 2603cc0f4f    	jreq	L5661
5318                     ; 1380             pBuffer++;
5320  0de2 cc0f4d        	jp	LC024
5321  0de5               L7061:
5322                     ; 1383           else if (pSocket->ParseCmd == 'a') {
5324  0de5 a161          	cp	a,#97
5325  0de7 2656          	jrne	L1261
5326                     ; 1393             ex_stored_devicename[0] = (uint8_t)(*pBuffer);
5328  0de9 1e08          	ldw	x,(OFST+1,sp)
5329  0deb f6            	ld	a,(x)
5330  0dec c70000        	ld	_ex_stored_devicename,a
5331                     ; 1394             pSocket->nParseLeft--;
5333  0def 1e0e          	ldw	x,(OFST+7,sp)
5334  0df1 6a06          	dec	(6,x)
5335                     ; 1395             pBuffer++; // nBytes already decremented for first char
5337  0df3 1e08          	ldw	x,(OFST+1,sp)
5338  0df5 5c            	incw	x
5339  0df6 1f08          	ldw	(OFST+1,sp),x
5340                     ; 1399 	    amp_found = 0;
5342  0df8 0f06          	clr	(OFST-1,sp)
5344                     ; 1400 	    for(i=1; i<20; i++) {
5346  0dfa a601          	ld	a,#1
5347  0dfc 6b07          	ld	(OFST+0,sp),a
5349  0dfe               L3261:
5350                     ; 1401 	      if((uint8_t)(*pBuffer) == 38) amp_found = 1;
5352  0dfe 1e08          	ldw	x,(OFST+1,sp)
5353  0e00 f6            	ld	a,(x)
5354  0e01 a126          	cp	a,#38
5355  0e03 2604          	jrne	L1361
5358  0e05 a601          	ld	a,#1
5359  0e07 6b06          	ld	(OFST-1,sp),a
5361  0e09               L1361:
5362                     ; 1402 	      if(amp_found == 0) {
5364  0e09 7b06          	ld	a,(OFST-1,sp)
5365  0e0b 261a          	jrne	L3361
5366                     ; 1404                 ex_stored_devicename[i] = (uint8_t)(*pBuffer);
5368  0e0d 7b07          	ld	a,(OFST+0,sp)
5369  0e0f 5f            	clrw	x
5370  0e10 1608          	ldw	y,(OFST+1,sp)
5371  0e12 97            	ld	xl,a
5372  0e13 90f6          	ld	a,(y)
5373  0e15 d70000        	ld	(_ex_stored_devicename,x),a
5374                     ; 1405                 pSocket->nParseLeft--;
5376  0e18 1e0e          	ldw	x,(OFST+7,sp)
5377  0e1a 6a06          	dec	(6,x)
5378                     ; 1406                 pBuffer++;
5380  0e1c 93            	ldw	x,y
5381  0e1d 5c            	incw	x
5382  0e1e 1f08          	ldw	(OFST+1,sp),x
5383                     ; 1407                 nBytes--; // Must subtract 1 from nBytes for extra byte read
5385  0e20 1e0c          	ldw	x,(OFST+5,sp)
5386  0e22 5a            	decw	x
5387  0e23 1f0c          	ldw	(OFST+5,sp),x
5389  0e25 200d          	jra	L5361
5390  0e27               L3361:
5391                     ; 1411 	        ex_stored_devicename[i] = ' ';
5393  0e27 7b07          	ld	a,(OFST+0,sp)
5394  0e29 5f            	clrw	x
5395  0e2a 97            	ld	xl,a
5396  0e2b a620          	ld	a,#32
5397  0e2d d70000        	ld	(_ex_stored_devicename,x),a
5398                     ; 1420                 pSocket->nParseLeft--;
5400  0e30 1e0e          	ldw	x,(OFST+7,sp)
5401  0e32 6a06          	dec	(6,x)
5402  0e34               L5361:
5403                     ; 1400 	    for(i=1; i<20; i++) {
5405  0e34 0c07          	inc	(OFST+0,sp)
5409  0e36 7b07          	ld	a,(OFST+0,sp)
5410  0e38 a114          	cp	a,#20
5411  0e3a 25c2          	jrult	L3261
5413  0e3c cc0f54        	jra	L7161
5414  0e3f               L1261:
5415                     ; 1425           else if (pSocket->ParseCmd == 'b') {
5417  0e3f a162          	cp	a,#98
5418  0e41 2646          	jrne	L1461
5419                     ; 1432 	    alpha_1 = '-';
5421                     ; 1433 	    alpha_2 = '-';
5423                     ; 1434 	    alpha_3 = '-';
5425                     ; 1436             alpha_1 = (uint8_t)(*pBuffer);
5427  0e43 1e08          	ldw	x,(OFST+1,sp)
5428  0e45 f6            	ld	a,(x)
5429  0e46 6b07          	ld	(OFST+0,sp),a
5431                     ; 1437             pSocket->nParseLeft--;
5433  0e48 1e0e          	ldw	x,(OFST+7,sp)
5434  0e4a 6a06          	dec	(6,x)
5435                     ; 1438             pBuffer++; // nBytes already decremented for first char
5437  0e4c 1e08          	ldw	x,(OFST+1,sp)
5438  0e4e 5c            	incw	x
5439  0e4f 1f08          	ldw	(OFST+1,sp),x
5440                     ; 1440 	    alpha_2 = (uint8_t)(*pBuffer);
5442  0e51 f6            	ld	a,(x)
5443  0e52 6b05          	ld	(OFST-2,sp),a
5445                     ; 1441             pSocket->nParseLeft--;
5447  0e54 1e0e          	ldw	x,(OFST+7,sp)
5448  0e56 6a06          	dec	(6,x)
5449                     ; 1442             pBuffer++;
5451  0e58 1e08          	ldw	x,(OFST+1,sp)
5452  0e5a 5c            	incw	x
5453  0e5b 1f08          	ldw	(OFST+1,sp),x
5454                     ; 1443 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5456  0e5d 1e0c          	ldw	x,(OFST+5,sp)
5457  0e5f 5a            	decw	x
5458  0e60 1f0c          	ldw	(OFST+5,sp),x
5459                     ; 1445 	    alpha_3 = (uint8_t)(*pBuffer);
5461  0e62 1e08          	ldw	x,(OFST+1,sp)
5462  0e64 f6            	ld	a,(x)
5463  0e65 6b06          	ld	(OFST-1,sp),a
5465                     ; 1446             pSocket->nParseLeft--;
5467  0e67 1e0e          	ldw	x,(OFST+7,sp)
5468  0e69 6a06          	dec	(6,x)
5469                     ; 1447             pBuffer++;
5471  0e6b 1e08          	ldw	x,(OFST+1,sp)
5472  0e6d 5c            	incw	x
5473  0e6e 1f08          	ldw	(OFST+1,sp),x
5474                     ; 1448 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5476  0e70 1e0c          	ldw	x,(OFST+5,sp)
5477  0e72 5a            	decw	x
5478  0e73 1f0c          	ldw	(OFST+5,sp),x
5479                     ; 1450 	    SetAddresses(pSocket->ParseNum, (uint8_t)alpha_1, (uint8_t)alpha_2, (uint8_t)alpha_3);
5481  0e75 88            	push	a
5482  0e76 7b06          	ld	a,(OFST-1,sp)
5483  0e78 88            	push	a
5484  0e79 7b09          	ld	a,(OFST+2,sp)
5485  0e7b 1610          	ldw	y,(OFST+9,sp)
5486  0e7d 97            	ld	xl,a
5487  0e7e 90e608        	ld	a,(8,y)
5488  0e81 95            	ld	xh,a
5489  0e82 cd1521        	call	_SetAddresses
5491  0e85 85            	popw	x
5493  0e86 cc0f54        	jra	L7161
5494  0e89               L1461:
5495                     ; 1453           else if (pSocket->ParseCmd == 'c') {
5497  0e89 a163          	cp	a,#99
5498  0e8b 2672          	jrne	L5461
5499                     ; 1459 	    alpha_1 = '-';
5501                     ; 1460 	    alpha_2 = '-';
5503                     ; 1461 	    alpha_3 = '-';
5505                     ; 1462 	    alpha_4 = '-';
5507                     ; 1463 	    alpha_5 = '-';
5509                     ; 1466   	    alpha_1 = (uint8_t)(*pBuffer);
5511  0e8d 1e08          	ldw	x,(OFST+1,sp)
5512  0e8f f6            	ld	a,(x)
5513  0e90 6b07          	ld	(OFST+0,sp),a
5515                     ; 1467             pSocket->nParseLeft--;
5517  0e92 1e0e          	ldw	x,(OFST+7,sp)
5518  0e94 6a06          	dec	(6,x)
5519                     ; 1468             pBuffer++; // nBytes already decremented for first char
5521  0e96 1e08          	ldw	x,(OFST+1,sp)
5522  0e98 5c            	incw	x
5523  0e99 1f08          	ldw	(OFST+1,sp),x
5524                     ; 1470 	    alpha_2 = (uint8_t)(*pBuffer);
5526  0e9b f6            	ld	a,(x)
5527  0e9c 6b05          	ld	(OFST-2,sp),a
5529                     ; 1471             pSocket->nParseLeft--;
5531  0e9e 1e0e          	ldw	x,(OFST+7,sp)
5532  0ea0 6a06          	dec	(6,x)
5533                     ; 1472             pBuffer++;
5535  0ea2 1e08          	ldw	x,(OFST+1,sp)
5536  0ea4 5c            	incw	x
5537  0ea5 1f08          	ldw	(OFST+1,sp),x
5538                     ; 1473 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5540  0ea7 1e0c          	ldw	x,(OFST+5,sp)
5541  0ea9 5a            	decw	x
5542  0eaa 1f0c          	ldw	(OFST+5,sp),x
5543                     ; 1475 	    alpha_3 = (uint8_t)(*pBuffer);
5545  0eac 1e08          	ldw	x,(OFST+1,sp)
5546  0eae f6            	ld	a,(x)
5547  0eaf 6b06          	ld	(OFST-1,sp),a
5549                     ; 1476             pSocket->nParseLeft--;
5551  0eb1 1e0e          	ldw	x,(OFST+7,sp)
5552  0eb3 6a06          	dec	(6,x)
5553                     ; 1477             pBuffer++;
5555  0eb5 1e08          	ldw	x,(OFST+1,sp)
5556  0eb7 5c            	incw	x
5557  0eb8 1f08          	ldw	(OFST+1,sp),x
5558                     ; 1478 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5560  0eba 1e0c          	ldw	x,(OFST+5,sp)
5561  0ebc 5a            	decw	x
5562  0ebd 1f0c          	ldw	(OFST+5,sp),x
5563                     ; 1480 	    alpha_4 = (uint8_t)(*pBuffer);
5565  0ebf 1e08          	ldw	x,(OFST+1,sp)
5566  0ec1 f6            	ld	a,(x)
5567  0ec2 6b03          	ld	(OFST-4,sp),a
5569                     ; 1481             pSocket->nParseLeft--;
5571  0ec4 1e0e          	ldw	x,(OFST+7,sp)
5572  0ec6 6a06          	dec	(6,x)
5573                     ; 1482             pBuffer++;
5575  0ec8 1e08          	ldw	x,(OFST+1,sp)
5576  0eca 5c            	incw	x
5577  0ecb 1f08          	ldw	(OFST+1,sp),x
5578                     ; 1483 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5580  0ecd 1e0c          	ldw	x,(OFST+5,sp)
5581  0ecf 5a            	decw	x
5582  0ed0 1f0c          	ldw	(OFST+5,sp),x
5583                     ; 1485             alpha_5 = (uint8_t)(*pBuffer);
5585  0ed2 1e08          	ldw	x,(OFST+1,sp)
5586  0ed4 f6            	ld	a,(x)
5587  0ed5 6b04          	ld	(OFST-3,sp),a
5589                     ; 1486             pSocket->nParseLeft--;
5591  0ed7 1e0e          	ldw	x,(OFST+7,sp)
5592  0ed9 6a06          	dec	(6,x)
5593                     ; 1487             pBuffer++;
5595  0edb 1e08          	ldw	x,(OFST+1,sp)
5596  0edd 5c            	incw	x
5597  0ede 1f08          	ldw	(OFST+1,sp),x
5598                     ; 1488 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5600  0ee0 1e0c          	ldw	x,(OFST+5,sp)
5601  0ee2 5a            	decw	x
5602  0ee3 1f0c          	ldw	(OFST+5,sp),x
5603                     ; 1490 	    SetPort(pSocket->ParseNum,
5603                     ; 1491 	            (uint8_t)alpha_1,
5603                     ; 1492 		    (uint8_t)alpha_2,
5603                     ; 1493 		    (uint8_t)alpha_3,
5603                     ; 1494 		    (uint8_t)alpha_4,
5603                     ; 1495 		    (uint8_t)alpha_5);
5605  0ee5 88            	push	a
5606  0ee6 7b04          	ld	a,(OFST-3,sp)
5607  0ee8 88            	push	a
5608  0ee9 7b08          	ld	a,(OFST+1,sp)
5609  0eeb 88            	push	a
5610  0eec 7b08          	ld	a,(OFST+1,sp)
5611  0eee 88            	push	a
5612  0eef 7b0b          	ld	a,(OFST+4,sp)
5613  0ef1 1612          	ldw	y,(OFST+11,sp)
5614  0ef3 97            	ld	xl,a
5615  0ef4 90e608        	ld	a,(8,y)
5616  0ef7 95            	ld	xh,a
5617  0ef8 cd15ab        	call	_SetPort
5619  0efb 5b04          	addw	sp,#4
5621  0efd 2055          	jra	L7161
5622  0eff               L5461:
5623                     ; 1498           else if (pSocket->ParseCmd == 'd') {
5625  0eff a164          	cp	a,#100
5626  0f01 262f          	jrne	L1561
5627                     ; 1504 	    alpha_1 = (uint8_t)(*pBuffer);
5629  0f03 1e08          	ldw	x,(OFST+1,sp)
5630  0f05 f6            	ld	a,(x)
5631  0f06 6b07          	ld	(OFST+0,sp),a
5633                     ; 1505             pSocket->nParseLeft--;
5635  0f08 1e0e          	ldw	x,(OFST+7,sp)
5636  0f0a 6a06          	dec	(6,x)
5637                     ; 1506             pBuffer++; // nBytes already decremented for first char
5639  0f0c 1e08          	ldw	x,(OFST+1,sp)
5640  0f0e 5c            	incw	x
5641  0f0f 1f08          	ldw	(OFST+1,sp),x
5642                     ; 1508 	    alpha_2 = (uint8_t)(*pBuffer);
5644  0f11 f6            	ld	a,(x)
5645  0f12 6b05          	ld	(OFST-2,sp),a
5647                     ; 1509             pSocket->nParseLeft--;
5649  0f14 1e0e          	ldw	x,(OFST+7,sp)
5650  0f16 6a06          	dec	(6,x)
5651                     ; 1510             pBuffer++;
5653  0f18 1e08          	ldw	x,(OFST+1,sp)
5654  0f1a 5c            	incw	x
5655  0f1b 1f08          	ldw	(OFST+1,sp),x
5656                     ; 1511 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5658  0f1d 1e0c          	ldw	x,(OFST+5,sp)
5659  0f1f 5a            	decw	x
5660  0f20 1f0c          	ldw	(OFST+5,sp),x
5661                     ; 1513 	    SetMAC(pSocket->ParseNum, alpha_1, alpha_2);
5663  0f22 88            	push	a
5664  0f23 7b08          	ld	a,(OFST+1,sp)
5665  0f25 160f          	ldw	y,(OFST+8,sp)
5666  0f27 97            	ld	xl,a
5667  0f28 90e608        	ld	a,(8,y)
5668  0f2b 95            	ld	xh,a
5669  0f2c cd15e6        	call	_SetMAC
5671  0f2f 84            	pop	a
5673  0f30 2022          	jra	L7161
5674  0f32               L1561:
5675                     ; 1516 	  else if (pSocket->ParseCmd == 'g') {
5677  0f32 a167          	cp	a,#103
5678  0f34 261e          	jrne	L7161
5679                     ; 1519             if ((uint8_t)(*pBuffer) == '1') invert_output = 1;
5681  0f36 1e08          	ldw	x,(OFST+1,sp)
5682  0f38 f6            	ld	a,(x)
5683  0f39 a131          	cp	a,#49
5684  0f3b 2606          	jrne	L7561
5687  0f3d 35010000      	mov	_invert_output,#1
5689  0f41 2004          	jra	L1661
5690  0f43               L7561:
5691                     ; 1520             else invert_output = 0;
5693  0f43 725f0000      	clr	_invert_output
5694  0f47               L1661:
5695                     ; 1521 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--;
5697  0f47 1e0e          	ldw	x,(OFST+7,sp)
5698  0f49 e606          	ld	a,(6,x)
5699  0f4b 2702          	jreq	L5661
5702  0f4d               LC024:
5704  0f4d 6a06          	dec	(6,x)
5706  0f4f               L5661:
5707                     ; 1523             pBuffer++;
5710  0f4f 1e08          	ldw	x,(OFST+1,sp)
5711  0f51 5c            	incw	x
5712  0f52 1f08          	ldw	(OFST+1,sp),x
5713  0f54               L7161:
5714                     ; 1526           pSocket->ParseState = PARSE_DELIM;
5716  0f54 1e0e          	ldw	x,(OFST+7,sp)
5717  0f56               LC018:
5719  0f56 a605          	ld	a,#5
5720  0f58 e709          	ld	(9,x),a
5722  0f5a 2015          	jra	L3551
5723  0f5c               L5061:
5724                     ; 1529         else if (pSocket->ParseState == PARSE_DELIM) {
5726  0f5c a105          	cp	a,#5
5727  0f5e 2611          	jrne	L3551
5728                     ; 1530           if(pSocket->nParseLeft > 0) {
5730  0f60 e606          	ld	a,(6,x)
5731  0f62 270b          	jreq	L3761
5732                     ; 1531             pSocket->ParseState = PARSE_CMD;
5734  0f64 6f09          	clr	(9,x)
5735                     ; 1532             pSocket->nParseLeft--;
5737  0f66               LC025:
5741  0f66 6a06          	dec	(6,x)
5742                     ; 1533             pBuffer++;
5744  0f68               LC017:
5748  0f68 1e08          	ldw	x,(OFST+1,sp)
5749  0f6a 5c            	incw	x
5750  0f6b 1f08          	ldw	(OFST+1,sp),x
5752  0f6d 2002          	jra	L3551
5753  0f6f               L3761:
5754                     ; 1536             pSocket->nParseLeft = 0; // Something out of sync - end the parsing
5756  0f6f e706          	ld	(6,x),a
5757  0f71               L3551:
5758                     ; 1540         if (pSocket->nParseLeft == 0) {
5760  0f71 1e0e          	ldw	x,(OFST+7,sp)
5761  0f73 e606          	ld	a,(6,x)
5762  0f75 2608          	jrne	L3251
5763                     ; 1542           pSocket->nState = STATE_SENDHEADER;
5765  0f77 a60b          	ld	a,#11
5766  0f79 f7            	ld	(x),a
5767                     ; 1543           break;
5768  0f7a               L5251:
5769                     ; 1547       pSocket->nState = STATE_SENDHEADER;
5771  0f7a 1e0e          	ldw	x,(OFST+7,sp)
5772  0f7c f7            	ld	(x),a
5773  0f7d 200f          	jra	L7151
5774  0f7f               L3251:
5775                     ; 1330       while (nBytes--) {
5777  0f7f 1e0c          	ldw	x,(OFST+5,sp)
5778  0f81 5a            	decw	x
5779  0f82 1f0c          	ldw	(OFST+5,sp),x
5780  0f84 5c            	incw	x
5781  0f85 2703cc0d26    	jrne	L1251
5782  0f8a a60b          	ld	a,#11
5783  0f8c 20ec          	jra	L5251
5784  0f8e               L7151:
5785                     ; 1550     if (pSocket->nState == STATE_PARSEGET) {
5787  0f8e a10d          	cp	a,#13
5788  0f90 2703cc1241    	jrne	L1071
5790  0f95 cc1236        	jra	L5071
5791  0f98               L3071:
5792                     ; 1564         if (pSocket->ParseState == PARSE_SLASH1) {
5794  0f98 1e0e          	ldw	x,(OFST+7,sp)
5795  0f9a e609          	ld	a,(9,x)
5796  0f9c a106          	cp	a,#6
5797  0f9e 263e          	jrne	L1171
5798                     ; 1567           pSocket->ParseCmd = *pBuffer;
5800  0fa0 1e08          	ldw	x,(OFST+1,sp)
5801  0fa2 f6            	ld	a,(x)
5802  0fa3 1e0e          	ldw	x,(OFST+7,sp)
5803  0fa5 e707          	ld	(7,x),a
5804                     ; 1568           pSocket->nParseLeft--;
5806  0fa7 6a06          	dec	(6,x)
5807                     ; 1569           pBuffer++;
5809  0fa9 1e08          	ldw	x,(OFST+1,sp)
5810  0fab 5c            	incw	x
5811  0fac 1f08          	ldw	(OFST+1,sp),x
5812                     ; 1570 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5814  0fae 1e0e          	ldw	x,(OFST+7,sp)
5815  0fb0 e607          	ld	a,(7,x)
5816  0fb2 a12f          	cp	a,#47
5817  0fb4 2604          	jrne	L3171
5818                     ; 1571 	    pSocket->ParseState = PARSE_NUM10;
5820  0fb6 a601          	ld	a,#1
5821  0fb8 e709          	ld	(9,x),a
5822  0fba               L3171:
5823                     ; 1573 	  if (pSocket->nParseLeft == 0) {
5825  0fba e606          	ld	a,(6,x)
5826  0fbc 2703cc1214    	jrne	L7171
5827                     ; 1575 	    current_webpage = WEBPAGE_DEFAULT;
5829  0fc1 c7000b        	ld	_current_webpage,a
5830                     ; 1576             pSocket->pData = g_HtmlPageDefault;
5832  0fc4 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5833  0fc8 ef01          	ldw	(1,x),y
5834                     ; 1577             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5836  0fca 90ae1876      	ldw	y,#6262
5837  0fce ef03          	ldw	(3,x),y
5838                     ; 1578             pSocket->nNewlines = 0;
5840  0fd0 e705          	ld	(5,x),a
5841                     ; 1579             pSocket->nState = STATE_SENDHEADER;
5843  0fd2 a60b          	ld	a,#11
5844  0fd4 f7            	ld	(x),a
5845                     ; 1580             pSocket->nPrevBytes = 0xFFFF;
5847  0fd5 90aeffff      	ldw	y,#65535
5848  0fd9 ef0a          	ldw	(10,x),y
5849                     ; 1581             break;
5851  0fdb cc1241        	jra	L1071
5852  0fde               L1171:
5853                     ; 1584         else if (pSocket->ParseState == PARSE_NUM10) {
5855  0fde a101          	cp	a,#1
5856  0fe0 264e          	jrne	L1271
5857                     ; 1589 	  if(*pBuffer == ' ') {
5859  0fe2 1e08          	ldw	x,(OFST+1,sp)
5860  0fe4 f6            	ld	a,(x)
5861  0fe5 a120          	cp	a,#32
5862  0fe7 2620          	jrne	L3271
5863                     ; 1590 	    current_webpage = WEBPAGE_DEFAULT;
5865  0fe9 725f000b      	clr	_current_webpage
5866                     ; 1591             pSocket->pData = g_HtmlPageDefault;
5868  0fed 1e0e          	ldw	x,(OFST+7,sp)
5869  0fef 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5870  0ff3 ef01          	ldw	(1,x),y
5871                     ; 1592             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5873  0ff5 90ae1876      	ldw	y,#6262
5874  0ff9 ef03          	ldw	(3,x),y
5875                     ; 1593             pSocket->nNewlines = 0;
5877  0ffb 6f05          	clr	(5,x)
5878                     ; 1594             pSocket->nState = STATE_SENDHEADER;
5880  0ffd a60b          	ld	a,#11
5881  0fff f7            	ld	(x),a
5882                     ; 1595             pSocket->nPrevBytes = 0xFFFF;
5884  1000 90aeffff      	ldw	y,#65535
5885  1004 ef0a          	ldw	(10,x),y
5886                     ; 1596 	    break;
5888  1006 cc1241        	jra	L1071
5889  1009               L3271:
5890                     ; 1599 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5892  1009 a130          	cp	a,#48
5893  100b 2504          	jrult	L5271
5895  100d a13a          	cp	a,#58
5896  100f 2506          	jrult	L7271
5898  1011               L5271:
5899                     ; 1600 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5901  1011 1e0e          	ldw	x,(OFST+7,sp)
5902  1013 a605          	ld	a,#5
5903  1015 e709          	ld	(9,x),a
5904  1017               L7271:
5905                     ; 1601           if (pSocket->ParseState == PARSE_NUM10) {      // Still good - parse number
5907  1017 1e0e          	ldw	x,(OFST+7,sp)
5908  1019 e609          	ld	a,(9,x)
5909  101b 4a            	dec	a
5910  101c 26a0          	jrne	L7171
5911                     ; 1602             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5913  101e 1e08          	ldw	x,(OFST+1,sp)
5914  1020 f6            	ld	a,(x)
5915  1021 97            	ld	xl,a
5916  1022 a60a          	ld	a,#10
5917  1024 42            	mul	x,a
5918  1025 9f            	ld	a,xl
5919  1026 1e0e          	ldw	x,(OFST+7,sp)
5920  1028 a0e0          	sub	a,#224
5921  102a e708          	ld	(8,x),a
5922                     ; 1603 	    pSocket->ParseState = PARSE_NUM1;
5924  102c a602          	ld	a,#2
5925                     ; 1604             pSocket->nParseLeft--;
5926                     ; 1605             pBuffer++;
5927  102e 202c          	jp	LC022
5928  1030               L1271:
5929                     ; 1609         else if (pSocket->ParseState == PARSE_NUM1) {
5931  1030 a102          	cp	a,#2
5932  1032 2634          	jrne	L5371
5933                     ; 1610 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5935  1034 1e08          	ldw	x,(OFST+1,sp)
5936  1036 f6            	ld	a,(x)
5937  1037 a130          	cp	a,#48
5938  1039 2504          	jrult	L7371
5940  103b a13a          	cp	a,#58
5941  103d 2506          	jrult	L1471
5943  103f               L7371:
5944                     ; 1611 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5946  103f 1e0e          	ldw	x,(OFST+7,sp)
5947  1041 a605          	ld	a,#5
5948  1043 e709          	ld	(9,x),a
5949  1045               L1471:
5950                     ; 1612           if (pSocket->ParseState == PARSE_NUM1) {       // Still good - parse number
5952  1045 1e0e          	ldw	x,(OFST+7,sp)
5953  1047 e609          	ld	a,(9,x)
5954  1049 a102          	cp	a,#2
5955  104b 2703cc1214    	jrne	L7171
5956                     ; 1613             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5958  1050 1608          	ldw	y,(OFST+1,sp)
5959  1052 90f6          	ld	a,(y)
5960  1054 a030          	sub	a,#48
5961  1056 eb08          	add	a,(8,x)
5962  1058 e708          	ld	(8,x),a
5963                     ; 1614             pSocket->ParseState = PARSE_VAL;
5965  105a a604          	ld	a,#4
5966                     ; 1615             pSocket->nParseLeft--;
5968                     ; 1616             pBuffer++;
5970  105c               LC022:
5971  105c e709          	ld	(9,x),a
5973  105e 6a06          	dec	(6,x)
5975  1060 1e08          	ldw	x,(OFST+1,sp)
5976  1062 5c            	incw	x
5977  1063 1f08          	ldw	(OFST+1,sp),x
5978  1065 cc1214        	jra	L7171
5979  1068               L5371:
5980                     ; 1619         else if (pSocket->ParseState == PARSE_VAL) {
5982  1068 a104          	cp	a,#4
5983  106a 2703cc121c    	jrne	L7471
5984                     ; 1670           switch(pSocket->ParseNum)
5986  106f e608          	ld	a,(8,x)
5988                     ; 1794 	      break;
5989  1071 a143          	cp	a,#67
5990  1073 2407          	jruge	L272
5991  1075 5f            	clrw	x
5992  1076 97            	ld	xl,a
5993  1077 58            	sllw	x
5994  1078 de4172        	ldw	x,(L472,x)
5995  107b fc            	jp	(x)
5996  107c               L272:
5997  107c a05b          	sub	a,#91
5998  107e 2603cc11d8    	jreq	L7321
5999  1083 a008          	sub	a,#8
6000  1085 2603cc11de    	jreq	L1421
6001  108a cc11f3        	jra	L3421
6002  108d               L7111:
6003                     ; 1672 	    case 0:  Relays_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
6005  108d 72110000      	bres	_Relays_8to1,#0
6008  1091 cc120e        	jra	L3571
6009  1094               L1211:
6010                     ; 1673 	    case 1:  Relays_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
6012  1094 72100000      	bset	_Relays_8to1,#0
6015  1098 cc120e        	jra	L3571
6016  109b               L3211:
6017                     ; 1674 	    case 2:  Relays_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
6019  109b 72130000      	bres	_Relays_8to1,#1
6022  109f cc120e        	jra	L3571
6023  10a2               L5211:
6024                     ; 1675 	    case 3:  Relays_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
6026  10a2 72120000      	bset	_Relays_8to1,#1
6029  10a6 cc120e        	jra	L3571
6030  10a9               L7211:
6031                     ; 1676 	    case 4:  Relays_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
6033  10a9 72150000      	bres	_Relays_8to1,#2
6036  10ad cc120e        	jra	L3571
6037  10b0               L1311:
6038                     ; 1677 	    case 5:  Relays_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
6040  10b0 72140000      	bset	_Relays_8to1,#2
6043  10b4 cc120e        	jra	L3571
6044  10b7               L3311:
6045                     ; 1678 	    case 6:  Relays_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
6047  10b7 72170000      	bres	_Relays_8to1,#3
6050  10bb cc120e        	jra	L3571
6051  10be               L5311:
6052                     ; 1679 	    case 7:  Relays_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
6054  10be 72160000      	bset	_Relays_8to1,#3
6057  10c2 cc120e        	jra	L3571
6058  10c5               L7311:
6059                     ; 1680 	    case 8:  Relays_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
6061  10c5 72190000      	bres	_Relays_8to1,#4
6064  10c9 cc120e        	jra	L3571
6065  10cc               L1411:
6066                     ; 1681 	    case 9:  Relays_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
6068  10cc 72180000      	bset	_Relays_8to1,#4
6071  10d0 cc120e        	jra	L3571
6072  10d3               L3411:
6073                     ; 1682 	    case 10: Relays_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
6075  10d3 721b0000      	bres	_Relays_8to1,#5
6078  10d7 cc120e        	jra	L3571
6079  10da               L5411:
6080                     ; 1683 	    case 11: Relays_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
6082  10da 721a0000      	bset	_Relays_8to1,#5
6085  10de cc120e        	jra	L3571
6086  10e1               L7411:
6087                     ; 1684 	    case 12: Relays_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
6089  10e1 721d0000      	bres	_Relays_8to1,#6
6092  10e5 cc120e        	jra	L3571
6093  10e8               L1511:
6094                     ; 1685 	    case 13: Relays_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
6096  10e8 721c0000      	bset	_Relays_8to1,#6
6099  10ec cc120e        	jra	L3571
6100  10ef               L3511:
6101                     ; 1686 	    case 14: Relays_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
6103  10ef 721f0000      	bres	_Relays_8to1,#7
6106  10f3 cc120e        	jra	L3571
6107  10f6               L5511:
6108                     ; 1687 	    case 15: Relays_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
6110  10f6 721e0000      	bset	_Relays_8to1,#7
6113  10fa cc120e        	jra	L3571
6114  10fd               L7511:
6115                     ; 1688 	    case 16: Relays_16to9 &= (uint8_t)(~0x01); break; // Relay-09 OFF
6117  10fd 72110000      	bres	_Relays_16to9,#0
6120  1101 cc120e        	jra	L3571
6121  1104               L1611:
6122                     ; 1689 	    case 17: Relays_16to9 |= (uint8_t)0x01;    break; // Relay-09 ON
6124  1104 72100000      	bset	_Relays_16to9,#0
6127  1108 cc120e        	jra	L3571
6128  110b               L3611:
6129                     ; 1690 	    case 18: Relays_16to9 &= (uint8_t)(~0x02); break; // Relay-10 OFF
6131  110b 72130000      	bres	_Relays_16to9,#1
6134  110f cc120e        	jra	L3571
6135  1112               L5611:
6136                     ; 1691 	    case 19: Relays_16to9 |= (uint8_t)0x02;    break; // Relay-10 ON
6138  1112 72120000      	bset	_Relays_16to9,#1
6141  1116 cc120e        	jra	L3571
6142  1119               L7611:
6143                     ; 1692 	    case 20: Relays_16to9 &= (uint8_t)(~0x04); break; // Relay-11 OFF
6145  1119 72150000      	bres	_Relays_16to9,#2
6148  111d cc120e        	jra	L3571
6149  1120               L1711:
6150                     ; 1693 	    case 21: Relays_16to9 |= (uint8_t)0x04;    break; // Relay-11 ON
6152  1120 72140000      	bset	_Relays_16to9,#2
6155  1124 cc120e        	jra	L3571
6156  1127               L3711:
6157                     ; 1694 	    case 22: Relays_16to9 &= (uint8_t)(~0x08); break; // Relay-12 OFF
6159  1127 72170000      	bres	_Relays_16to9,#3
6162  112b cc120e        	jra	L3571
6163  112e               L5711:
6164                     ; 1695 	    case 23: Relays_16to9 |= (uint8_t)0x08;    break; // Relay-12 ON
6166  112e 72160000      	bset	_Relays_16to9,#3
6169  1132 cc120e        	jra	L3571
6170  1135               L7711:
6171                     ; 1696 	    case 24: Relays_16to9 &= (uint8_t)(~0x10); break; // Relay-13 OFF
6173  1135 72190000      	bres	_Relays_16to9,#4
6176  1139 cc120e        	jra	L3571
6177  113c               L1021:
6178                     ; 1697 	    case 25: Relays_16to9 |= (uint8_t)0x10;    break; // Relay-13 ON
6180  113c 72180000      	bset	_Relays_16to9,#4
6183  1140 cc120e        	jra	L3571
6184  1143               L3021:
6185                     ; 1698 	    case 26: Relays_16to9 &= (uint8_t)(~0x20); break; // Relay-14 OFF
6187  1143 721b0000      	bres	_Relays_16to9,#5
6190  1147 cc120e        	jra	L3571
6191  114a               L5021:
6192                     ; 1699 	    case 27: Relays_16to9 |= (uint8_t)0x20;    break; // Relay-14 ON
6194  114a 721a0000      	bset	_Relays_16to9,#5
6197  114e cc120e        	jra	L3571
6198  1151               L7021:
6199                     ; 1700 	    case 28: Relays_16to9 &= (uint8_t)(~0x40); break; // Relay-15 OFF
6201  1151 721d0000      	bres	_Relays_16to9,#6
6204  1155 cc120e        	jra	L3571
6205  1158               L1121:
6206                     ; 1701 	    case 29: Relays_16to9 |= (uint8_t)0x40;    break; // Relay-15 ON
6208  1158 721c0000      	bset	_Relays_16to9,#6
6211  115c cc120e        	jra	L3571
6212  115f               L3121:
6213                     ; 1702 	    case 30: Relays_16to9 &= (uint8_t)(~0x80); break; // Relay-16 OFF
6215  115f 721f0000      	bres	_Relays_16to9,#7
6218  1163 cc120e        	jra	L3571
6219  1166               L5121:
6220                     ; 1703 	    case 31: Relays_16to9 |= (uint8_t)0x80;    break; // Relay-16 ON
6222  1166 721e0000      	bset	_Relays_16to9,#7
6225  116a cc120e        	jra	L3571
6226  116d               L7121:
6227                     ; 1704 	    case 55:
6227                     ; 1705   	      Relays_8to1 = (uint8_t)0xff; // Relays 1-8 ON
6229  116d 35ff0000      	mov	_Relays_8to1,#255
6230                     ; 1706   	      Relays_16to9 = (uint8_t)0xff; // Relays 9-16 ON
6232  1171 35ff0000      	mov	_Relays_16to9,#255
6233                     ; 1707 	      break;
6235  1175 cc120e        	jra	L3571
6236  1178               L1221:
6237                     ; 1708 	    case 56:
6237                     ; 1709               Relays_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
6239  1178 725f0000      	clr	_Relays_8to1
6240                     ; 1710               Relays_16to9 = (uint8_t)0x00; // Relays 9-16 OFF
6242  117c 725f0000      	clr	_Relays_16to9
6243                     ; 1711 	      break;
6245  1180 cc120e        	jra	L3571
6246  1183               L3221:
6247                     ; 1713 	    case 60: // Show relay states page
6247                     ; 1714 	      current_webpage = WEBPAGE_DEFAULT;
6248                     ; 1715               pSocket->pData = g_HtmlPageDefault;
6249                     ; 1716               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6250                     ; 1717               pSocket->nNewlines = 0;
6251                     ; 1718               pSocket->nState = STATE_CONNECTED;
6252                     ; 1719               pSocket->nPrevBytes = 0xFFFF;
6253                     ; 1720 	      break;
6255  1183 206e          	jp	L3421
6256  1185               L5221:
6257                     ; 1722 	    case 61: // Show address settings page
6257                     ; 1723 	      current_webpage = WEBPAGE_ADDRESS;
6259  1185 3501000b      	mov	_current_webpage,#1
6260                     ; 1724               pSocket->pData = g_HtmlPageAddress;
6262  1189 1e0e          	ldw	x,(OFST+7,sp)
6263  118b 90ae187f      	ldw	y,#L71_g_HtmlPageAddress
6264  118f ef01          	ldw	(1,x),y
6265                     ; 1725               pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
6267  1191 90ae133a      	ldw	y,#4922
6268                     ; 1726               pSocket->nNewlines = 0;
6269                     ; 1727               pSocket->nState = STATE_CONNECTED;
6270                     ; 1728               pSocket->nPrevBytes = 0xFFFF;
6271                     ; 1729 	      break;
6273  1195 206c          	jp	LC020
6274  1197               L7221:
6275                     ; 1732 	    case 63: // Show help page 1
6275                     ; 1733 	      current_webpage = WEBPAGE_HELP;
6277  1197 3503000b      	mov	_current_webpage,#3
6278                     ; 1734               pSocket->pData = g_HtmlPageHelp;
6280  119b 1e0e          	ldw	x,(OFST+7,sp)
6281  119d 90ae2bba      	ldw	y,#L12_g_HtmlPageHelp
6282  11a1 ef01          	ldw	(1,x),y
6283                     ; 1735               pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
6285  11a3 90ae0753      	ldw	y,#1875
6286                     ; 1736               pSocket->nNewlines = 0;
6287                     ; 1737               pSocket->nState = STATE_CONNECTED;
6288                     ; 1738               pSocket->nPrevBytes = 0xFFFF;
6289                     ; 1739 	      break;
6291  11a7 205a          	jp	LC020
6292  11a9               L1321:
6293                     ; 1741 	    case 64: // Show help page 2
6293                     ; 1742 	      current_webpage = WEBPAGE_HELP2;
6295  11a9 3504000b      	mov	_current_webpage,#4
6296                     ; 1743               pSocket->pData = g_HtmlPageHelp2;
6298  11ad 1e0e          	ldw	x,(OFST+7,sp)
6299  11af 90ae330e      	ldw	y,#L32_g_HtmlPageHelp2
6300  11b3 ef01          	ldw	(1,x),y
6301                     ; 1744               pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
6303  11b5 90ae02b4      	ldw	y,#692
6304                     ; 1745               pSocket->nNewlines = 0;
6305                     ; 1746               pSocket->nState = STATE_CONNECTED;
6306                     ; 1747               pSocket->nPrevBytes = 0xFFFF;
6307                     ; 1748 	      break;
6309  11b9 2048          	jp	LC020
6310  11bb               L3321:
6311                     ; 1751 	    case 65: // Flash LED for diagnostics
6311                     ; 1752 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6311                     ; 1753 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6311                     ; 1754 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6311                     ; 1755 	      debugflash();
6313  11bb cd0000        	call	_debugflash
6315                     ; 1756 	      debugflash();
6317  11be cd0000        	call	_debugflash
6319                     ; 1757 	      debugflash();
6321  11c1 cd0000        	call	_debugflash
6323                     ; 1761 	      break;
6325  11c4 2048          	jra	L3571
6326  11c6               L5321:
6327                     ; 1764             case 66: // Show statistics page
6327                     ; 1765 	      current_webpage = WEBPAGE_STATS;
6329  11c6 3505000b      	mov	_current_webpage,#5
6330                     ; 1766               pSocket->pData = g_HtmlPageStats;
6332  11ca 1e0e          	ldw	x,(OFST+7,sp)
6333  11cc 90ae35c3      	ldw	y,#L52_g_HtmlPageStats
6334  11d0 ef01          	ldw	(1,x),y
6335                     ; 1767               pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
6337  11d2 90ae0ae5      	ldw	y,#2789
6338                     ; 1768               pSocket->nNewlines = 0;
6339                     ; 1769               pSocket->nState = STATE_CONNECTED;
6340                     ; 1770               pSocket->nPrevBytes = 0xFFFF;
6341                     ; 1771 	      break;
6343  11d6 202b          	jp	LC020
6344  11d8               L7321:
6345                     ; 1774 	    case 91: // Reboot
6345                     ; 1775 	      submit_changes = 2;
6347  11d8 35020000      	mov	_submit_changes,#2
6348                     ; 1776 	      break;
6350  11dc 2030          	jra	L3571
6351  11de               L1421:
6352                     ; 1778             case 99: // Show simplified relay state page
6352                     ; 1779 	      current_webpage = WEBPAGE_RSTATE;
6354  11de 3506000b      	mov	_current_webpage,#6
6355                     ; 1780               pSocket->pData = g_HtmlPageRstate;
6357  11e2 90ae40a9      	ldw	y,#L72_g_HtmlPageRstate
6358  11e6 ef01          	ldw	(1,x),y
6359                     ; 1781               pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
6361  11e8 90ae0084      	ldw	y,#132
6362  11ec ef03          	ldw	(3,x),y
6363                     ; 1782               pSocket->nNewlines = 0;
6365  11ee e705          	ld	(5,x),a
6366                     ; 1783               pSocket->nState = STATE_CONNECTED;
6368  11f0 f7            	ld	(x),a
6369                     ; 1784               pSocket->nPrevBytes = 0xFFFF;
6370                     ; 1785 	      break;
6372  11f1 2015          	jp	LC019
6373  11f3               L3421:
6374                     ; 1787 	    default: // Show relay state page
6374                     ; 1788 	      current_webpage = WEBPAGE_DEFAULT;
6376                     ; 1789               pSocket->pData = g_HtmlPageDefault;
6378                     ; 1790               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6381  11f3 725f000b      	clr	_current_webpage
6383  11f7 1e0e          	ldw	x,(OFST+7,sp)
6384  11f9 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
6385  11fd ef01          	ldw	(1,x),y
6387  11ff 90ae1876      	ldw	y,#6262
6388                     ; 1791               pSocket->nNewlines = 0;
6390                     ; 1792               pSocket->nState = STATE_CONNECTED;
6392  1203               LC020:
6393  1203 ef03          	ldw	(3,x),y
6399  1205 6f05          	clr	(5,x)
6405  1207 7f            	clr	(x)
6406                     ; 1793               pSocket->nPrevBytes = 0xFFFF;
6408  1208               LC019:
6415  1208 90aeffff      	ldw	y,#65535
6416  120c ef0a          	ldw	(10,x),y
6417                     ; 1794 	      break;
6419  120e               L3571:
6420                     ; 1796           pSocket->ParseState = PARSE_DELIM;
6422  120e 1e0e          	ldw	x,(OFST+7,sp)
6423  1210 a605          	ld	a,#5
6424  1212 e709          	ld	(9,x),a
6426  1214               L7171:
6427                     ; 1810         if (pSocket->nParseLeft == 0) {
6429  1214 1e0e          	ldw	x,(OFST+7,sp)
6430  1216 e606          	ld	a,(6,x)
6431  1218 261c          	jrne	L5071
6432                     ; 1812           pSocket->nState = STATE_SENDHEADER;
6433                     ; 1813           break;
6435  121a 2015          	jp	LC023
6436  121c               L7471:
6437                     ; 1799         else if (pSocket->ParseState == PARSE_DELIM) {
6439  121c a105          	cp	a,#5
6440  121e 26f4          	jrne	L7171
6441                     ; 1801           pSocket->ParseState = PARSE_DELIM;
6443  1220 a605          	ld	a,#5
6444  1222 e709          	ld	(9,x),a
6445                     ; 1802           pSocket->nParseLeft--;
6447  1224 6a06          	dec	(6,x)
6448                     ; 1803           pBuffer++;
6450  1226 1e08          	ldw	x,(OFST+1,sp)
6451  1228 5c            	incw	x
6452  1229 1f08          	ldw	(OFST+1,sp),x
6453                     ; 1804 	  if (pSocket->nParseLeft == 0) {
6455  122b 1e0e          	ldw	x,(OFST+7,sp)
6456  122d e606          	ld	a,(6,x)
6457  122f 26e3          	jrne	L7171
6458                     ; 1806             pSocket->nState = STATE_SENDHEADER;
6460  1231               LC023:
6462  1231 a60b          	ld	a,#11
6463  1233 f7            	ld	(x),a
6464                     ; 1807             break;
6466  1234 200b          	jra	L1071
6467  1236               L5071:
6468                     ; 1563       while (nBytes--) {
6470  1236 1e0c          	ldw	x,(OFST+5,sp)
6471  1238 5a            	decw	x
6472  1239 1f0c          	ldw	(OFST+5,sp),x
6473  123b 5c            	incw	x
6474  123c 2703cc0f98    	jrne	L3071
6475  1241               L1071:
6476                     ; 1818     if (pSocket->nState == STATE_SENDHEADER) {
6478  1241 1e0e          	ldw	x,(OFST+7,sp)
6479  1243 f6            	ld	a,(x)
6480  1244 a10b          	cp	a,#11
6481  1246 2623          	jrne	L5671
6482                     ; 1819       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6484  1248 ee03          	ldw	x,(3,x)
6485  124a cd0000        	call	c_uitolx
6487  124d be02          	ldw	x,c_lreg+2
6488  124f 89            	pushw	x
6489  1250 be00          	ldw	x,c_lreg
6490  1252 89            	pushw	x
6491  1253 ce0000        	ldw	x,_uip_appdata
6492  1256 cd0231        	call	L7_CopyHttpHeader
6494  1259 5b04          	addw	sp,#4
6495  125b 89            	pushw	x
6496  125c ce0000        	ldw	x,_uip_appdata
6497  125f cd0000        	call	_uip_send
6499  1262 85            	popw	x
6500                     ; 1820       pSocket->nState = STATE_SENDDATA;
6502  1263 1e0e          	ldw	x,(OFST+7,sp)
6503  1265 a60c          	ld	a,#12
6504  1267 f7            	ld	(x),a
6505                     ; 1821       return;
6507  1268 cc0bd7        	jra	L613
6508  126b               L5671:
6509                     ; 1824     if (pSocket->nState == STATE_SENDDATA) {
6511  126b a10c          	cp	a,#12
6512  126d 26f9          	jrne	L613
6513                     ; 1828       pSocket->nPrevBytes = pSocket->nDataLeft;
6515  126f 9093          	ldw	y,x
6516  1271 90ee03        	ldw	y,(3,y)
6517  1274 ef0a          	ldw	(10,x),y
6518                     ; 1829       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6520  1276 ce0000        	ldw	x,_uip_conn
6521  1279 ee12          	ldw	x,(18,x)
6522  127b 89            	pushw	x
6523  127c 1e10          	ldw	x,(OFST+9,sp)
6524  127e 1c0003        	addw	x,#3
6525  1281 89            	pushw	x
6526  1282 1e12          	ldw	x,(OFST+11,sp)
6527  1284 5c            	incw	x
6528  1285 89            	pushw	x
6529  1286 ce0000        	ldw	x,_uip_appdata
6530  1289 cd02c9        	call	L11_CopyHttpData
6532  128c 5b06          	addw	sp,#6
6533  128e 1f01          	ldw	(OFST-6,sp),x
6535                     ; 1830       pSocket->nPrevBytes -= pSocket->nDataLeft;
6537  1290 1e0e          	ldw	x,(OFST+7,sp)
6538  1292 e60b          	ld	a,(11,x)
6539  1294 e004          	sub	a,(4,x)
6540  1296 e70b          	ld	(11,x),a
6541  1298 e60a          	ld	a,(10,x)
6542  129a e203          	sbc	a,(3,x)
6543  129c e70a          	ld	(10,x),a
6544                     ; 1832       if (nBufSize == 0) {
6546  129e 1e01          	ldw	x,(OFST-6,sp)
6547  12a0 262d          	jrne	LC014
6548                     ; 1834         uip_close();
6550  12a2               LC015:
6552  12a2 35100000      	mov	_uip_flags,#16
6554  12a6 cc0bd7        	jra	L613
6555                     ; 1838         uip_send(uip_appdata, nBufSize);
6557                     ; 1840       return;
6559  12a9               L5731:
6560                     ; 1844   else if (uip_rexmit()) {
6562  12a9 7204000003cc  	btjf	_uip_flags,#2,L3731
6563                     ; 1845     if (pSocket->nPrevBytes == 0xFFFF) {
6565  12b1 160e          	ldw	y,(OFST+7,sp)
6566  12b3 90ee0a        	ldw	y,(10,y)
6567  12b6 905c          	incw	y
6568  12b8 2620          	jrne	L1002
6569                     ; 1847       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6571  12ba 1e0e          	ldw	x,(OFST+7,sp)
6572  12bc ee03          	ldw	x,(3,x)
6573  12be cd0000        	call	c_uitolx
6575  12c1 be02          	ldw	x,c_lreg+2
6576  12c3 89            	pushw	x
6577  12c4 be00          	ldw	x,c_lreg
6578  12c6 89            	pushw	x
6579  12c7 ce0000        	ldw	x,_uip_appdata
6580  12ca cd0231        	call	L7_CopyHttpHeader
6582  12cd 5b04          	addw	sp,#4
6584  12cf               LC014:
6586  12cf 89            	pushw	x
6587  12d0 ce0000        	ldw	x,_uip_appdata
6588  12d3 cd0000        	call	_uip_send
6589  12d6 85            	popw	x
6591  12d7 cc0bd7        	jra	L613
6592  12da               L1002:
6593                     ; 1850       pSocket->pData -= pSocket->nPrevBytes;
6595  12da 1e0e          	ldw	x,(OFST+7,sp)
6596  12dc e602          	ld	a,(2,x)
6597  12de e00b          	sub	a,(11,x)
6598  12e0 e702          	ld	(2,x),a
6599  12e2 e601          	ld	a,(1,x)
6600  12e4 e20a          	sbc	a,(10,x)
6601  12e6 e701          	ld	(1,x),a
6602                     ; 1851       pSocket->nDataLeft += pSocket->nPrevBytes;
6604  12e8 e604          	ld	a,(4,x)
6605  12ea eb0b          	add	a,(11,x)
6606  12ec e704          	ld	(4,x),a
6607  12ee e603          	ld	a,(3,x)
6608  12f0 e90a          	adc	a,(10,x)
6609                     ; 1852       pSocket->nPrevBytes = pSocket->nDataLeft;
6611  12f2 9093          	ldw	y,x
6612  12f4 e703          	ld	(3,x),a
6613  12f6 90ee03        	ldw	y,(3,y)
6614  12f9 ef0a          	ldw	(10,x),y
6615                     ; 1853       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6617  12fb ce0000        	ldw	x,_uip_conn
6618  12fe ee12          	ldw	x,(18,x)
6619  1300 89            	pushw	x
6620  1301 1e10          	ldw	x,(OFST+9,sp)
6621  1303 1c0003        	addw	x,#3
6622  1306 89            	pushw	x
6623  1307 1e12          	ldw	x,(OFST+11,sp)
6624  1309 5c            	incw	x
6625  130a 89            	pushw	x
6626  130b ce0000        	ldw	x,_uip_appdata
6627  130e cd02c9        	call	L11_CopyHttpData
6629  1311 5b06          	addw	sp,#6
6630  1313 1f01          	ldw	(OFST-6,sp),x
6632                     ; 1854       pSocket->nPrevBytes -= pSocket->nDataLeft;
6634  1315 1e0e          	ldw	x,(OFST+7,sp)
6635  1317 e60b          	ld	a,(11,x)
6636  1319 e004          	sub	a,(4,x)
6637  131b e70b          	ld	(11,x),a
6638  131d e60a          	ld	a,(10,x)
6639  131f e203          	sbc	a,(3,x)
6640  1321 e70a          	ld	(10,x),a
6641                     ; 1855       if (nBufSize == 0) {
6643  1323 1e01          	ldw	x,(OFST-6,sp)
6644                     ; 1857         uip_close();
6646  1325 2603cc12a2    	jreq	LC015
6647                     ; 1861         uip_send(uip_appdata, nBufSize);
6649  132a 89            	pushw	x
6650  132b ce0000        	ldw	x,_uip_appdata
6651  132e cd0000        	call	_uip_send
6653  1331 85            	popw	x
6654                     ; 1864     return;
6656  1332               L3731:
6657                     ; 1866 }
6659  1332 cc0bd7        	jra	L613
6693                     ; 1869 uint8_t GpioGetPin(uint8_t nGpio)
6693                     ; 1870 {
6694                     	switch	.text
6695  1335               _GpioGetPin:
6697       00000000      OFST:	set	0
6700                     ; 1872   if(nGpio == 0       && (Relays_8to1  & (uint8_t)(0x01))) return 1; // Relay-01 is ON
6702  1335 4d            	tnz	a
6703  1336 2607          	jrne	L5202
6705  1338 7201000002    	btjf	_Relays_8to1,#0,L5202
6708  133d 4c            	inc	a
6711  133e 81            	ret	
6712  133f               L5202:
6713                     ; 1873   else if(nGpio == 1  && (Relays_8to1  & (uint8_t)(0x02))) return 1; // Relay-02 is ON
6715  133f a101          	cp	a,#1
6716  1341 2608          	jrne	L1302
6718  1343 7203000003    	btjf	_Relays_8to1,#1,L1302
6721  1348 a601          	ld	a,#1
6724  134a 81            	ret	
6725  134b               L1302:
6726                     ; 1874   else if(nGpio == 2  && (Relays_8to1  & (uint8_t)(0x04))) return 1; // Relay-03 is ON
6728  134b a102          	cp	a,#2
6729  134d 2608          	jrne	L5302
6731  134f 7205000003    	btjf	_Relays_8to1,#2,L5302
6734  1354 a601          	ld	a,#1
6737  1356 81            	ret	
6738  1357               L5302:
6739                     ; 1875   else if(nGpio == 3  && (Relays_8to1  & (uint8_t)(0x08))) return 1; // Relay-04 is ON
6741  1357 a103          	cp	a,#3
6742  1359 2608          	jrne	L1402
6744  135b 7207000003    	btjf	_Relays_8to1,#3,L1402
6747  1360 a601          	ld	a,#1
6750  1362 81            	ret	
6751  1363               L1402:
6752                     ; 1876   else if(nGpio == 4  && (Relays_8to1  & (uint8_t)(0x10))) return 1; // Relay-05 is ON
6754  1363 a104          	cp	a,#4
6755  1365 2608          	jrne	L5402
6757  1367 7209000003    	btjf	_Relays_8to1,#4,L5402
6760  136c a601          	ld	a,#1
6763  136e 81            	ret	
6764  136f               L5402:
6765                     ; 1877   else if(nGpio == 5  && (Relays_8to1  & (uint8_t)(0x20))) return 1; // Relay-06 is ON
6767  136f a105          	cp	a,#5
6768  1371 2608          	jrne	L1502
6770  1373 720b000003    	btjf	_Relays_8to1,#5,L1502
6773  1378 a601          	ld	a,#1
6776  137a 81            	ret	
6777  137b               L1502:
6778                     ; 1878   else if(nGpio == 6  && (Relays_8to1  & (uint8_t)(0x40))) return 1; // Relay-07 is ON
6780  137b a106          	cp	a,#6
6781  137d 2608          	jrne	L5502
6783  137f 720d000003    	btjf	_Relays_8to1,#6,L5502
6786  1384 a601          	ld	a,#1
6789  1386 81            	ret	
6790  1387               L5502:
6791                     ; 1879   else if(nGpio == 7  && (Relays_8to1  & (uint8_t)(0x80))) return 1; // Relay-08 is ON
6793  1387 a107          	cp	a,#7
6794  1389 2608          	jrne	L1602
6796  138b 720f000003    	btjf	_Relays_8to1,#7,L1602
6799  1390 a601          	ld	a,#1
6802  1392 81            	ret	
6803  1393               L1602:
6804                     ; 1880   else if(nGpio == 8  && (Relays_16to9 & (uint8_t)(0x01))) return 1; // Relay-09 is ON
6806  1393 a108          	cp	a,#8
6807  1395 2608          	jrne	L5602
6809  1397 7201000003    	btjf	_Relays_16to9,#0,L5602
6812  139c a601          	ld	a,#1
6815  139e 81            	ret	
6816  139f               L5602:
6817                     ; 1881   else if(nGpio == 9  && (Relays_16to9 & (uint8_t)(0x02))) return 1; // Relay-10 is ON
6819  139f a109          	cp	a,#9
6820  13a1 2608          	jrne	L1702
6822  13a3 7203000003    	btjf	_Relays_16to9,#1,L1702
6825  13a8 a601          	ld	a,#1
6828  13aa 81            	ret	
6829  13ab               L1702:
6830                     ; 1882   else if(nGpio == 10 && (Relays_16to9 & (uint8_t)(0x04))) return 1; // Relay-11 is ON
6832  13ab a10a          	cp	a,#10
6833  13ad 2608          	jrne	L5702
6835  13af 7205000003    	btjf	_Relays_16to9,#2,L5702
6838  13b4 a601          	ld	a,#1
6841  13b6 81            	ret	
6842  13b7               L5702:
6843                     ; 1883   else if(nGpio == 11 && (Relays_16to9 & (uint8_t)(0x08))) return 1; // Relay-12 is ON
6845  13b7 a10b          	cp	a,#11
6846  13b9 2608          	jrne	L1012
6848  13bb 7207000003    	btjf	_Relays_16to9,#3,L1012
6851  13c0 a601          	ld	a,#1
6854  13c2 81            	ret	
6855  13c3               L1012:
6856                     ; 1884   else if(nGpio == 12 && (Relays_16to9 & (uint8_t)(0x10))) return 1; // Relay-13 is ON
6858  13c3 a10c          	cp	a,#12
6859  13c5 2608          	jrne	L5012
6861  13c7 7209000003    	btjf	_Relays_16to9,#4,L5012
6864  13cc a601          	ld	a,#1
6867  13ce 81            	ret	
6868  13cf               L5012:
6869                     ; 1885   else if(nGpio == 13 && (Relays_16to9 & (uint8_t)(0x20))) return 1; // Relay-14 is ON
6871  13cf a10d          	cp	a,#13
6872  13d1 2608          	jrne	L1112
6874  13d3 720b000003    	btjf	_Relays_16to9,#5,L1112
6877  13d8 a601          	ld	a,#1
6880  13da 81            	ret	
6881  13db               L1112:
6882                     ; 1886   else if(nGpio == 14 && (Relays_16to9 & (uint8_t)(0x40))) return 1; // Relay-15 is ON
6884  13db a10e          	cp	a,#14
6885  13dd 2608          	jrne	L5112
6887  13df 720d000003    	btjf	_Relays_16to9,#6,L5112
6890  13e4 a601          	ld	a,#1
6893  13e6 81            	ret	
6894  13e7               L5112:
6895                     ; 1887   else if(nGpio == 15 && (Relays_16to9 & (uint8_t)(0x80))) return 1; // Relay-16 is ON
6897  13e7 a10f          	cp	a,#15
6898  13e9 2608          	jrne	L7202
6900  13eb 720f000003    	btjf	_Relays_16to9,#7,L7202
6903  13f0 a601          	ld	a,#1
6906  13f2 81            	ret	
6907  13f3               L7202:
6908                     ; 1888   return 0;
6910  13f3 4f            	clr	a
6913  13f4 81            	ret	
6954                     	switch	.const
6955  41f8               L623:
6956  41f8 1412          	dc.w	L3212
6957  41fa 1424          	dc.w	L5212
6958  41fc 1436          	dc.w	L7212
6959  41fe 1448          	dc.w	L1312
6960  4200 145a          	dc.w	L3312
6961  4202 146c          	dc.w	L5312
6962  4204 147e          	dc.w	L7312
6963  4206 1490          	dc.w	L1412
6964  4208 14a1          	dc.w	L3412
6965  420a 14b1          	dc.w	L5412
6966  420c 14c1          	dc.w	L7412
6967  420e 14d1          	dc.w	L1512
6968  4210 14e1          	dc.w	L3512
6969  4212 14f1          	dc.w	L5512
6970  4214 1501          	dc.w	L7512
6971  4216 1511          	dc.w	L1612
6972                     ; 1892 void GpioSetPin(uint8_t nGpio, uint8_t nState)
6972                     ; 1893 {
6973                     	switch	.text
6974  13f5               _GpioSetPin:
6976  13f5 89            	pushw	x
6977       00000000      OFST:	set	0
6980                     ; 1897   if(nState != 0 && nState != 1) nState = 1;
6982  13f6 9f            	ld	a,xl
6983  13f7 4d            	tnz	a
6984  13f8 2708          	jreq	L3022
6986  13fa 9f            	ld	a,xl
6987  13fb 4a            	dec	a
6988  13fc 2704          	jreq	L3022
6991  13fe a601          	ld	a,#1
6992  1400 6b02          	ld	(OFST+2,sp),a
6993  1402               L3022:
6994                     ; 1899   switch(nGpio)
6996  1402 7b01          	ld	a,(OFST+1,sp)
6998                     ; 1965   default: break;
6999  1404 a110          	cp	a,#16
7000  1406 2503cc151f    	jruge	L7022
7001  140b 5f            	clrw	x
7002  140c 97            	ld	xl,a
7003  140d 58            	sllw	x
7004  140e de41f8        	ldw	x,(L623,x)
7005  1411 fc            	jp	(x)
7006  1412               L3212:
7007                     ; 1901   case 0:
7007                     ; 1902     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x01); // Relay-01 OFF
7009  1412 7b02          	ld	a,(OFST+2,sp)
7010  1414 2607          	jrne	L1122
7013  1416 72110000      	bres	_Relays_8to1,#0
7015  141a cc151f        	jra	L7022
7016  141d               L1122:
7017                     ; 1903     else Relays_8to1 |= (uint8_t)0x01; // Relay-01 ON
7019  141d 72100000      	bset	_Relays_8to1,#0
7020  1421 cc151f        	jra	L7022
7021  1424               L5212:
7022                     ; 1905   case 1:
7022                     ; 1906     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x02); // Relay-02 OFF
7024  1424 7b02          	ld	a,(OFST+2,sp)
7025  1426 2607          	jrne	L5122
7028  1428 72130000      	bres	_Relays_8to1,#1
7030  142c cc151f        	jra	L7022
7031  142f               L5122:
7032                     ; 1907     else Relays_8to1 |= (uint8_t)0x02; // Relay-02 ON
7034  142f 72120000      	bset	_Relays_8to1,#1
7035  1433 cc151f        	jra	L7022
7036  1436               L7212:
7037                     ; 1909   case 2:
7037                     ; 1910     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x04); // Relay-03 OFF
7039  1436 7b02          	ld	a,(OFST+2,sp)
7040  1438 2607          	jrne	L1222
7043  143a 72150000      	bres	_Relays_8to1,#2
7045  143e cc151f        	jra	L7022
7046  1441               L1222:
7047                     ; 1911     else Relays_8to1 |= (uint8_t)0x04; // Relay-03 ON
7049  1441 72140000      	bset	_Relays_8to1,#2
7050  1445 cc151f        	jra	L7022
7051  1448               L1312:
7052                     ; 1913   case 3:
7052                     ; 1914     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x08); // Relay-04 OFF
7054  1448 7b02          	ld	a,(OFST+2,sp)
7055  144a 2607          	jrne	L5222
7058  144c 72170000      	bres	_Relays_8to1,#3
7060  1450 cc151f        	jra	L7022
7061  1453               L5222:
7062                     ; 1915     else Relays_8to1 |= (uint8_t)0x08; // Relay-04 ON
7064  1453 72160000      	bset	_Relays_8to1,#3
7065  1457 cc151f        	jra	L7022
7066  145a               L3312:
7067                     ; 1917   case 4:
7067                     ; 1918     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x10); // Relay-05 OFF
7069  145a 7b02          	ld	a,(OFST+2,sp)
7070  145c 2607          	jrne	L1322
7073  145e 72190000      	bres	_Relays_8to1,#4
7075  1462 cc151f        	jra	L7022
7076  1465               L1322:
7077                     ; 1919     else Relays_8to1 |= (uint8_t)0x10; // Relay-05 ON
7079  1465 72180000      	bset	_Relays_8to1,#4
7080  1469 cc151f        	jra	L7022
7081  146c               L5312:
7082                     ; 1921   case 5:
7082                     ; 1922     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x20); // Relay-06 OFF
7084  146c 7b02          	ld	a,(OFST+2,sp)
7085  146e 2607          	jrne	L5322
7088  1470 721b0000      	bres	_Relays_8to1,#5
7090  1474 cc151f        	jra	L7022
7091  1477               L5322:
7092                     ; 1923     else Relays_8to1 |= (uint8_t)0x20; // Relay-06 ON
7094  1477 721a0000      	bset	_Relays_8to1,#5
7095  147b cc151f        	jra	L7022
7096  147e               L7312:
7097                     ; 1925   case 6:
7097                     ; 1926     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x40); // Relay-07 OFF
7099  147e 7b02          	ld	a,(OFST+2,sp)
7100  1480 2607          	jrne	L1422
7103  1482 721d0000      	bres	_Relays_8to1,#6
7105  1486 cc151f        	jra	L7022
7106  1489               L1422:
7107                     ; 1927     else Relays_8to1 |= (uint8_t)0x40; // Relay-07 ON
7109  1489 721c0000      	bset	_Relays_8to1,#6
7110  148d cc151f        	jra	L7022
7111  1490               L1412:
7112                     ; 1929   case 7:
7112                     ; 1930     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x80); // Relay-08 OFF
7114  1490 7b02          	ld	a,(OFST+2,sp)
7115  1492 2607          	jrne	L5422
7118  1494 721f0000      	bres	_Relays_8to1,#7
7120  1498 cc151f        	jra	L7022
7121  149b               L5422:
7122                     ; 1931     else Relays_8to1 |= (uint8_t)0x80; // Relay-08 ON
7124  149b 721e0000      	bset	_Relays_8to1,#7
7125  149f 207e          	jra	L7022
7126  14a1               L3412:
7127                     ; 1933   case 8:
7127                     ; 1934     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x01); // Relay-09 OFF
7129  14a1 7b02          	ld	a,(OFST+2,sp)
7130  14a3 2606          	jrne	L1522
7133  14a5 72110000      	bres	_Relays_16to9,#0
7135  14a9 2074          	jra	L7022
7136  14ab               L1522:
7137                     ; 1935     else Relays_16to9 |= (uint8_t)0x01; // Relay-09 ON
7139  14ab 72100000      	bset	_Relays_16to9,#0
7140  14af 206e          	jra	L7022
7141  14b1               L5412:
7142                     ; 1937   case 9:
7142                     ; 1938     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x02); // Relay-10 OFF
7144  14b1 7b02          	ld	a,(OFST+2,sp)
7145  14b3 2606          	jrne	L5522
7148  14b5 72130000      	bres	_Relays_16to9,#1
7150  14b9 2064          	jra	L7022
7151  14bb               L5522:
7152                     ; 1939     else Relays_16to9 |= (uint8_t)0x02; // Relay-10 ON
7154  14bb 72120000      	bset	_Relays_16to9,#1
7155  14bf 205e          	jra	L7022
7156  14c1               L7412:
7157                     ; 1941   case 10:
7157                     ; 1942     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x04); // Relay-11 OFF
7159  14c1 7b02          	ld	a,(OFST+2,sp)
7160  14c3 2606          	jrne	L1622
7163  14c5 72150000      	bres	_Relays_16to9,#2
7165  14c9 2054          	jra	L7022
7166  14cb               L1622:
7167                     ; 1943     else Relays_16to9 |= (uint8_t)0x04; // Relay-11 ON
7169  14cb 72140000      	bset	_Relays_16to9,#2
7170  14cf 204e          	jra	L7022
7171  14d1               L1512:
7172                     ; 1945   case 11:
7172                     ; 1946     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x08); // Relay-12 OFF
7174  14d1 7b02          	ld	a,(OFST+2,sp)
7175  14d3 2606          	jrne	L5622
7178  14d5 72170000      	bres	_Relays_16to9,#3
7180  14d9 2044          	jra	L7022
7181  14db               L5622:
7182                     ; 1947     else Relays_16to9 |= (uint8_t)0x08; // Relay-12 ON
7184  14db 72160000      	bset	_Relays_16to9,#3
7185  14df 203e          	jra	L7022
7186  14e1               L3512:
7187                     ; 1949   case 12:
7187                     ; 1950     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x10); // Relay-13 OFF
7189  14e1 7b02          	ld	a,(OFST+2,sp)
7190  14e3 2606          	jrne	L1722
7193  14e5 72190000      	bres	_Relays_16to9,#4
7195  14e9 2034          	jra	L7022
7196  14eb               L1722:
7197                     ; 1951     else Relays_16to9 |= (uint8_t)0x10; // Relay-13 ON
7199  14eb 72180000      	bset	_Relays_16to9,#4
7200  14ef 202e          	jra	L7022
7201  14f1               L5512:
7202                     ; 1953   case 13:
7202                     ; 1954     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x20); // Relay-14 OFF
7204  14f1 7b02          	ld	a,(OFST+2,sp)
7205  14f3 2606          	jrne	L5722
7208  14f5 721b0000      	bres	_Relays_16to9,#5
7210  14f9 2024          	jra	L7022
7211  14fb               L5722:
7212                     ; 1955     else Relays_16to9 |= (uint8_t)0x20; // Relay-14 ON
7214  14fb 721a0000      	bset	_Relays_16to9,#5
7215  14ff 201e          	jra	L7022
7216  1501               L7512:
7217                     ; 1957   case 14:
7217                     ; 1958     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x40); // Relay-15 OFF
7219  1501 7b02          	ld	a,(OFST+2,sp)
7220  1503 2606          	jrne	L1032
7223  1505 721d0000      	bres	_Relays_16to9,#6
7225  1509 2014          	jra	L7022
7226  150b               L1032:
7227                     ; 1959     else Relays_16to9 |= (uint8_t)0x40; // Relay-15 ON
7229  150b 721c0000      	bset	_Relays_16to9,#6
7230  150f 200e          	jra	L7022
7231  1511               L1612:
7232                     ; 1961   case 15:
7232                     ; 1962     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x80); // Relay-16 OFF
7234  1511 7b02          	ld	a,(OFST+2,sp)
7235  1513 2606          	jrne	L5032
7238  1515 721f0000      	bres	_Relays_16to9,#7
7240  1519 2004          	jra	L7022
7241  151b               L5032:
7242                     ; 1963     else Relays_16to9 |= (uint8_t)0x80; // Relay-16 ON
7244  151b 721e0000      	bset	_Relays_16to9,#7
7245                     ; 1965   default: break;
7247  151f               L7022:
7248                     ; 1967 }
7251  151f 85            	popw	x
7252  1520 81            	ret	
7342                     	switch	.const
7343  4218               L633:
7344  4218 1556          	dc.w	L1132
7345  421a 155d          	dc.w	L3132
7346  421c 1564          	dc.w	L5132
7347  421e 156b          	dc.w	L7132
7348  4220 1572          	dc.w	L1232
7349  4222 1579          	dc.w	L3232
7350  4224 1580          	dc.w	L5232
7351  4226 1587          	dc.w	L7232
7352  4228 158e          	dc.w	L1332
7353  422a 1595          	dc.w	L3332
7354  422c 159c          	dc.w	L5332
7355  422e 15a3          	dc.w	L7332
7356                     ; 1970 void SetAddresses(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
7356                     ; 1971 {
7357                     	switch	.text
7358  1521               _SetAddresses:
7360  1521 89            	pushw	x
7361  1522 5207          	subw	sp,#7
7362       00000007      OFST:	set	7
7365                     ; 1984   temp = 0;
7367                     ; 1985   invalid = 0;
7369  1524 0f01          	clr	(OFST-6,sp)
7371                     ; 1988   str[0] = (uint8_t)alpha1;
7373  1526 9f            	ld	a,xl
7374  1527 6b02          	ld	(OFST-5,sp),a
7376                     ; 1989   str[1] = (uint8_t)alpha2;
7378  1529 7b0c          	ld	a,(OFST+5,sp)
7379  152b 6b03          	ld	(OFST-4,sp),a
7381                     ; 1990   str[2] = (uint8_t)alpha3;
7383  152d 7b0d          	ld	a,(OFST+6,sp)
7384  152f 6b04          	ld	(OFST-3,sp),a
7386                     ; 1991   str[3] = 0;
7388  1531 0f05          	clr	(OFST-2,sp)
7390                     ; 1992   temp = atoi(str);
7392  1533 96            	ldw	x,sp
7393  1534 1c0002        	addw	x,#OFST-5
7394  1537 cd0000        	call	_atoi
7396  153a 1f06          	ldw	(OFST-1,sp),x
7398                     ; 1993   if (temp > 255) invalid = 1; // If an invalid entry set indicator
7400  153c a30100        	cpw	x,#256
7401  153f 2504          	jrult	L5732
7404  1541 a601          	ld	a,#1
7405  1543 6b01          	ld	(OFST-6,sp),a
7407  1545               L5732:
7408                     ; 1995   if(invalid == 0) { // Make change only if valid entry
7410  1545 7b01          	ld	a,(OFST-6,sp)
7411  1547 265f          	jrne	L7732
7412                     ; 1996     switch(itemnum)
7414  1549 7b08          	ld	a,(OFST+1,sp)
7416                     ; 2010     default: break;
7417  154b a10c          	cp	a,#12
7418  154d 2459          	jruge	L7732
7419  154f 5f            	clrw	x
7420  1550 97            	ld	xl,a
7421  1551 58            	sllw	x
7422  1552 de4218        	ldw	x,(L633,x)
7423  1555 fc            	jp	(x)
7424  1556               L1132:
7425                     ; 1998     case 0:  Pending_hostaddr4 = (uint8_t)temp; break;
7427  1556 7b07          	ld	a,(OFST+0,sp)
7428  1558 c70000        	ld	_Pending_hostaddr4,a
7431  155b 204b          	jra	L7732
7432  155d               L3132:
7433                     ; 1999     case 1:  Pending_hostaddr3 = (uint8_t)temp; break;
7435  155d 7b07          	ld	a,(OFST+0,sp)
7436  155f c70000        	ld	_Pending_hostaddr3,a
7439  1562 2044          	jra	L7732
7440  1564               L5132:
7441                     ; 2000     case 2:  Pending_hostaddr2 = (uint8_t)temp; break;
7443  1564 7b07          	ld	a,(OFST+0,sp)
7444  1566 c70000        	ld	_Pending_hostaddr2,a
7447  1569 203d          	jra	L7732
7448  156b               L7132:
7449                     ; 2001     case 3:  Pending_hostaddr1 = (uint8_t)temp; break;
7451  156b 7b07          	ld	a,(OFST+0,sp)
7452  156d c70000        	ld	_Pending_hostaddr1,a
7455  1570 2036          	jra	L7732
7456  1572               L1232:
7457                     ; 2002     case 4:  Pending_draddr4 = (uint8_t)temp; break;
7459  1572 7b07          	ld	a,(OFST+0,sp)
7460  1574 c70000        	ld	_Pending_draddr4,a
7463  1577 202f          	jra	L7732
7464  1579               L3232:
7465                     ; 2003     case 5:  Pending_draddr3 = (uint8_t)temp; break;
7467  1579 7b07          	ld	a,(OFST+0,sp)
7468  157b c70000        	ld	_Pending_draddr3,a
7471  157e 2028          	jra	L7732
7472  1580               L5232:
7473                     ; 2004     case 6:  Pending_draddr2 = (uint8_t)temp; break;
7475  1580 7b07          	ld	a,(OFST+0,sp)
7476  1582 c70000        	ld	_Pending_draddr2,a
7479  1585 2021          	jra	L7732
7480  1587               L7232:
7481                     ; 2005     case 7:  Pending_draddr1 = (uint8_t)temp; break;
7483  1587 7b07          	ld	a,(OFST+0,sp)
7484  1589 c70000        	ld	_Pending_draddr1,a
7487  158c 201a          	jra	L7732
7488  158e               L1332:
7489                     ; 2006     case 8:  Pending_netmask4 = (uint8_t)temp; break;
7491  158e 7b07          	ld	a,(OFST+0,sp)
7492  1590 c70000        	ld	_Pending_netmask4,a
7495  1593 2013          	jra	L7732
7496  1595               L3332:
7497                     ; 2007     case 9:  Pending_netmask3 = (uint8_t)temp; break;
7499  1595 7b07          	ld	a,(OFST+0,sp)
7500  1597 c70000        	ld	_Pending_netmask3,a
7503  159a 200c          	jra	L7732
7504  159c               L5332:
7505                     ; 2008     case 10: Pending_netmask2 = (uint8_t)temp; break;
7507  159c 7b07          	ld	a,(OFST+0,sp)
7508  159e c70000        	ld	_Pending_netmask2,a
7511  15a1 2005          	jra	L7732
7512  15a3               L7332:
7513                     ; 2009     case 11: Pending_netmask1 = (uint8_t)temp; break;
7515  15a3 7b07          	ld	a,(OFST+0,sp)
7516  15a5 c70000        	ld	_Pending_netmask1,a
7519                     ; 2010     default: break;
7521  15a8               L7732:
7522                     ; 2013 }
7525  15a8 5b09          	addw	sp,#9
7526  15aa 81            	ret	
7619                     ; 2016 void SetPort(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3, uint8_t alpha4, uint8_t alpha5)
7619                     ; 2017 {
7620                     	switch	.text
7621  15ab               _SetPort:
7623  15ab 89            	pushw	x
7624  15ac 5209          	subw	sp,#9
7625       00000009      OFST:	set	9
7628                     ; 2030   temp = 0;
7630  15ae 5f            	clrw	x
7631  15af 1f01          	ldw	(OFST-8,sp),x
7633                     ; 2031   invalid = 0;
7635  15b1 0f03          	clr	(OFST-6,sp)
7637                     ; 2034   if(alpha1 > '6') invalid = 1;
7639  15b3 7b0b          	ld	a,(OFST+2,sp)
7640  15b5 a137          	cp	a,#55
7641  15b7 2506          	jrult	L3442
7644  15b9 a601          	ld	a,#1
7645  15bb 6b03          	ld	(OFST-6,sp),a
7648  15bd 201d          	jra	L5442
7649  15bf               L3442:
7650                     ; 2036     str[0] = (uint8_t)alpha1;
7652  15bf 6b04          	ld	(OFST-5,sp),a
7654                     ; 2037     str[1] = (uint8_t)alpha2;
7656  15c1 7b0e          	ld	a,(OFST+5,sp)
7657  15c3 6b05          	ld	(OFST-4,sp),a
7659                     ; 2038     str[2] = (uint8_t)alpha3;
7661  15c5 7b0f          	ld	a,(OFST+6,sp)
7662  15c7 6b06          	ld	(OFST-3,sp),a
7664                     ; 2039     str[3] = (uint8_t)alpha4;
7666  15c9 7b10          	ld	a,(OFST+7,sp)
7667  15cb 6b07          	ld	(OFST-2,sp),a
7669                     ; 2040     str[4] = (uint8_t)alpha5;
7671  15cd 7b11          	ld	a,(OFST+8,sp)
7672  15cf 6b08          	ld	(OFST-1,sp),a
7674                     ; 2041     str[5] = 0;
7676  15d1 0f09          	clr	(OFST+0,sp)
7678                     ; 2042     temp = atoi(str);
7680  15d3 96            	ldw	x,sp
7681  15d4 1c0004        	addw	x,#OFST-5
7682  15d7 cd0000        	call	_atoi
7684  15da 1f01          	ldw	(OFST-8,sp),x
7686  15dc               L5442:
7687                     ; 2045   if(invalid == 0) { // Make change only if valid entry
7689  15dc 7b03          	ld	a,(OFST-6,sp)
7690  15de 2603          	jrne	L7442
7691                     ; 2046     Pending_port = (uint16_t)temp;
7693  15e0 cf0000        	ldw	_Pending_port,x
7694  15e3               L7442:
7695                     ; 2048 }
7698  15e3 5b0b          	addw	sp,#11
7699  15e5 81            	ret	
7765                     ; 2051 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7765                     ; 2052 {
7766                     	switch	.text
7767  15e6               _SetMAC:
7769  15e6 89            	pushw	x
7770  15e7 5203          	subw	sp,#3
7771       00000003      OFST:	set	3
7774                     ; 2064   temp = 0;
7776                     ; 2065   invalid = 0;
7778  15e9 0f01          	clr	(OFST-2,sp)
7780                     ; 2068   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7782  15eb 9f            	ld	a,xl
7783  15ec a130          	cp	a,#48
7784  15ee 250b          	jrult	L3152
7786  15f0 9f            	ld	a,xl
7787  15f1 a13a          	cp	a,#58
7788  15f3 2406          	jruge	L3152
7791  15f5 7b05          	ld	a,(OFST+2,sp)
7792  15f7 a030          	sub	a,#48
7794  15f9 200c          	jp	LC028
7795  15fb               L3152:
7796                     ; 2069   else if(alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7798  15fb 7b05          	ld	a,(OFST+2,sp)
7799  15fd a161          	cp	a,#97
7800  15ff 250a          	jrult	L7152
7802  1601 a167          	cp	a,#103
7803  1603 2406          	jruge	L7152
7806  1605 a057          	sub	a,#87
7807  1607               LC028:
7808  1607 6b05          	ld	(OFST+2,sp),a
7810  1609 2004          	jra	L5152
7811  160b               L7152:
7812                     ; 2070   else invalid = 1; // If an invalid entry set indicator
7814  160b a601          	ld	a,#1
7815  160d 6b01          	ld	(OFST-2,sp),a
7817  160f               L5152:
7818                     ; 2072   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7820  160f 7b08          	ld	a,(OFST+5,sp)
7821  1611 a130          	cp	a,#48
7822  1613 2508          	jrult	L3252
7824  1615 a13a          	cp	a,#58
7825  1617 2404          	jruge	L3252
7828  1619 a030          	sub	a,#48
7830  161b 200a          	jp	LC029
7831  161d               L3252:
7832                     ; 2073   else if(alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7834  161d a161          	cp	a,#97
7835  161f 250a          	jrult	L7252
7837  1621 a167          	cp	a,#103
7838  1623 2406          	jruge	L7252
7841  1625 a057          	sub	a,#87
7842  1627               LC029:
7843  1627 6b08          	ld	(OFST+5,sp),a
7845  1629 2004          	jra	L5252
7846  162b               L7252:
7847                     ; 2074   else invalid = 1; // If an invalid entry set indicator
7849  162b a601          	ld	a,#1
7850  162d 6b01          	ld	(OFST-2,sp),a
7852  162f               L5252:
7853                     ; 2076   if (invalid == 0) { // Change value only if valid entry
7855  162f 7b01          	ld	a,(OFST-2,sp)
7856  1631 264a          	jrne	L3352
7857                     ; 2077     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7859  1633 7b05          	ld	a,(OFST+2,sp)
7860  1635 97            	ld	xl,a
7861  1636 a610          	ld	a,#16
7862  1638 42            	mul	x,a
7863  1639 01            	rrwa	x,a
7864  163a 1b08          	add	a,(OFST+5,sp)
7865  163c 5f            	clrw	x
7866  163d 97            	ld	xl,a
7867  163e 1f02          	ldw	(OFST-1,sp),x
7869                     ; 2078     switch(itemnum)
7871  1640 7b04          	ld	a,(OFST+1,sp)
7873                     ; 2086     default: break;
7874  1642 2711          	jreq	L1542
7875  1644 4a            	dec	a
7876  1645 2715          	jreq	L3542
7877  1647 4a            	dec	a
7878  1648 2719          	jreq	L5542
7879  164a 4a            	dec	a
7880  164b 271d          	jreq	L7542
7881  164d 4a            	dec	a
7882  164e 2721          	jreq	L1642
7883  1650 4a            	dec	a
7884  1651 2725          	jreq	L3642
7885  1653 2028          	jra	L3352
7886  1655               L1542:
7887                     ; 2080     case 0: Pending_uip_ethaddr1 = (uint8_t)temp; break;
7889  1655 7b03          	ld	a,(OFST+0,sp)
7890  1657 c70000        	ld	_Pending_uip_ethaddr1,a
7893  165a 2021          	jra	L3352
7894  165c               L3542:
7895                     ; 2081     case 1: Pending_uip_ethaddr2 = (uint8_t)temp; break;
7897  165c 7b03          	ld	a,(OFST+0,sp)
7898  165e c70000        	ld	_Pending_uip_ethaddr2,a
7901  1661 201a          	jra	L3352
7902  1663               L5542:
7903                     ; 2082     case 2: Pending_uip_ethaddr3 = (uint8_t)temp; break;
7905  1663 7b03          	ld	a,(OFST+0,sp)
7906  1665 c70000        	ld	_Pending_uip_ethaddr3,a
7909  1668 2013          	jra	L3352
7910  166a               L7542:
7911                     ; 2083     case 3: Pending_uip_ethaddr4 = (uint8_t)temp; break;
7913  166a 7b03          	ld	a,(OFST+0,sp)
7914  166c c70000        	ld	_Pending_uip_ethaddr4,a
7917  166f 200c          	jra	L3352
7918  1671               L1642:
7919                     ; 2084     case 4: Pending_uip_ethaddr5 = (uint8_t)temp; break;
7921  1671 7b03          	ld	a,(OFST+0,sp)
7922  1673 c70000        	ld	_Pending_uip_ethaddr5,a
7925  1676 2005          	jra	L3352
7926  1678               L3642:
7927                     ; 2085     case 5: Pending_uip_ethaddr6 = (uint8_t)temp; break;
7929  1678 7b03          	ld	a,(OFST+0,sp)
7930  167a c70000        	ld	_Pending_uip_ethaddr6,a
7933                     ; 2086     default: break;
7935  167d               L3352:
7936                     ; 2089 }
7939  167d 5b05          	addw	sp,#5
7940  167f 81            	ret	
8042                     	switch	.bss
8043  0000               _OctetArray:
8044  0000 000000000000  	ds.b	11
8045                     	xdef	_OctetArray
8046                     	xref	_submit_changes
8047                     	xref	_ex_stored_devicename
8048                     	xref	_uip_ethaddr6
8049                     	xref	_uip_ethaddr5
8050                     	xref	_uip_ethaddr4
8051                     	xref	_uip_ethaddr3
8052                     	xref	_uip_ethaddr2
8053                     	xref	_uip_ethaddr1
8054                     	xref	_ex_stored_port
8055                     	xref	_ex_stored_netmask1
8056                     	xref	_ex_stored_netmask2
8057                     	xref	_ex_stored_netmask3
8058                     	xref	_ex_stored_netmask4
8059                     	xref	_ex_stored_draddr1
8060                     	xref	_ex_stored_draddr2
8061                     	xref	_ex_stored_draddr3
8062                     	xref	_ex_stored_draddr4
8063                     	xref	_ex_stored_hostaddr1
8064                     	xref	_ex_stored_hostaddr2
8065                     	xref	_ex_stored_hostaddr3
8066                     	xref	_ex_stored_hostaddr4
8067                     	xref	_Pending_uip_ethaddr6
8068                     	xref	_Pending_uip_ethaddr5
8069                     	xref	_Pending_uip_ethaddr4
8070                     	xref	_Pending_uip_ethaddr3
8071                     	xref	_Pending_uip_ethaddr2
8072                     	xref	_Pending_uip_ethaddr1
8073                     	xref	_Pending_port
8074                     	xref	_Pending_netmask1
8075                     	xref	_Pending_netmask2
8076                     	xref	_Pending_netmask3
8077                     	xref	_Pending_netmask4
8078                     	xref	_Pending_draddr1
8079                     	xref	_Pending_draddr2
8080                     	xref	_Pending_draddr3
8081                     	xref	_Pending_draddr4
8082                     	xref	_Pending_hostaddr1
8083                     	xref	_Pending_hostaddr2
8084                     	xref	_Pending_hostaddr3
8085                     	xref	_Pending_hostaddr4
8086                     	xref	_invert_output
8087                     	xref	_Relays_8to1
8088                     	xref	_Relays_16to9
8089                     	xref	_Port_Httpd
8090  000b               _current_webpage:
8091  000b 00            	ds.b	1
8092                     	xdef	_current_webpage
8093                     	xref	_atoi
8094                     	xref	_debugflash
8095                     	xref	_uip_flags
8096                     	xref	_uip_stat
8097                     	xref	_uip_conn
8098                     	xref	_uip_appdata
8099                     	xref	_htons
8100                     	xref	_uip_send
8101                     	xref	_uip_listen
8102                     	xdef	_SetMAC
8103                     	xdef	_SetPort
8104                     	xdef	_SetAddresses
8105                     	xdef	_GpioSetPin
8106                     	xdef	_GpioGetPin
8107                     	xdef	_HttpDCall
8108                     	xdef	_HttpDInit
8109                     	xdef	_reverse
8110                     	xdef	_emb_itoa
8111                     	xdef	_two_alpha_to_uint
8112                     	xdef	_three_alpha_to_uint
8113                     	switch	.const
8114  4230               L714:
8115  4230 436f6e6e6563  	dc.b	"Connection:close",13
8116  4241 0a00          	dc.b	10,0
8117  4243               L514:
8118  4243 436f6e74656e  	dc.b	"Content-Type:text/"
8119  4255 68746d6c0d    	dc.b	"html",13
8120  425a 0a00          	dc.b	10,0
8121  425c               L314:
8122  425c 436f6e74656e  	dc.b	"Content-Length:",0
8123  426c               L114:
8124  426c 0d0a00        	dc.b	13,10,0
8125  426f               L704:
8126  426f 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8127                     	xref.b	c_lreg
8128                     	xref.b	c_x
8129                     	xref.b	c_y
8149                     	xref	c_uitolx
8150                     	xref	c_ludv
8151                     	xref	c_lumd
8152                     	xref	c_rtol
8153                     	xref	c_ltor
8154                     	xref	c_lzmp
8155                     	end
