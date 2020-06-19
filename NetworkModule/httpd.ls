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
  23  002c 6561643e3c74  	dc.b	"ead><title>Relay C"
  24  003e 6f6e74726f6c  	dc.b	"ontrol</title><sty"
  25  0050 6c653e2e7330  	dc.b	"le>.s0 { backgroun"
  26  0062 642d636f6c6f  	dc.b	"d-color: red; widt"
  27  0074 683a20333070  	dc.b	"h: 30px; }.s1 { ba"
  28  0086 636b67726f75  	dc.b	"ckground-color: gr"
  29  0098 65656e3b2077  	dc.b	"een; width: 30px; "
  30  00aa 7d2e7431636c  	dc.b	"}.t1class { width:"
  31  00bc 203130307078  	dc.b	" 100px; }.t2class "
  32  00ce 7b2077696474  	dc.b	"{ width: 148px; }."
  33  00e0 7433636c6173  	dc.b	"t3class { width: 3"
  34  00f2 3070783b207d  	dc.b	"0px; }.t4class { w"
  35  0104 696474        	dc.b	"idt"
  36  0107 683a20313230  	dc.b	"h: 120px; }td { te"
  37  0119 78742d616c69  	dc.b	"xt-align: center; "
  38  012b 626f72646572  	dc.b	"border: 1px black "
  39  013d 736f6c69643b  	dc.b	"solid; }</style></"
  40  014f 686561643e3c  	dc.b	"head><body><h1>Rel"
  41  0161 617920436f6e  	dc.b	"ay Control</h1><fo"
  42  0173 726d206d6574  	dc.b	"rm method='POST' a"
  43  0185 6374696f6e3d  	dc.b	"ction='/'><table><"
  44  0197 74723e3c7464  	dc.b	"tr><td class='t1cl"
  45  01a9 617373273e4e  	dc.b	"ass'>Name:</td><td"
  46  01bb 3e3c696e7075  	dc.b	"><input type='text"
  47  01cd 27206e616d65  	dc.b	"' name='a00' class"
  48  01df 3d277432636c  	dc.b	"='t2class' value='"
  49  01f1 256130307878  	dc.b	"%a00xxxxxxxxxxxxxx"
  50  0203 787878        	dc.b	"xxx"
  51  0206 787878272070  	dc.b	"xxx' pattern='[0-9"
  52  0218 612d7a412d5a  	dc.b	"a-zA-Z-_*.]{1,20}'"
  53  022a 207469746c65  	dc.b	" title='1 to 20 le"
  54  023c 74746572732c  	dc.b	"tters, numbers, an"
  55  024e 64202d5f2a2e  	dc.b	"d -_*. no spaces' "
  56  0260 6d61786c656e  	dc.b	"maxlength='20' siz"
  57  0272 653d27323027  	dc.b	"e='20'></td></tr><"
  58  0284 2f7461626c65  	dc.b	"/table><table><tr>"
  59  0296 3c746420636c  	dc.b	"<td class='t1class"
  60  02a8 273e3c2f7464  	dc.b	"'></td><td class='"
  61  02ba 7433636c6173  	dc.b	"t3class'></td><td "
  62  02cc 636c6173733d  	dc.b	"class='t4class'>SE"
  63  02de 543c2f74643e  	dc.b	"T</td></tr><tr><td"
  64  02f0 20636c617373  	dc.b	" class='t1class'>R"
  65  0302 656c61        	dc.b	"ela"
  66  0305 7930313c2f74  	dc.b	"y01</td><td class="
  67  0317 277325693030  	dc.b	"'s%i00'></td><td c"
  68  0329 6c6173733d27  	dc.b	"lass='t4class'><in"
  69  033b 707574207479  	dc.b	"put type='radio' i"
  70  034d 643d2772656c  	dc.b	"d='relay01on' name"
  71  035f 3d276f303027  	dc.b	"='o00' value='1' %"
  72  0371 6f30303e3c6c  	dc.b	"o00><label for='re"
  73  0383 6c617930316f  	dc.b	"lay01on'>ON</label"
  74  0395 3e3c696e7075  	dc.b	"><input type='radi"
  75  03a7 6f272069643d  	dc.b	"o' id='relay01off'"
  76  03b9 206e616d653d  	dc.b	" name='o00' value="
  77  03cb 273027202570  	dc.b	"'0' %p00><label fo"
  78  03dd 723d2772656c  	dc.b	"r='relay01off'>OFF"
  79  03ef 3c2f6c616265  	dc.b	"</label></td></tr>"
  80  0401 3c7472        	dc.b	"<tr"
  81  0404 3e3c74642063  	dc.b	"><td class='t1clas"
  82  0416 73273e52656c  	dc.b	"s'>Relay02</td><td"
  83  0428 20636c617373  	dc.b	" class='s%i01'></t"
  84  043a 643e3c746420  	dc.b	"d><td class='t4cla"
  85  044c 7373273e3c69  	dc.b	"ss'><input type='r"
  86  045e 6164696f2720  	dc.b	"adio' id='relay02o"
  87  0470 6e27206e616d  	dc.b	"n' name='o01' valu"
  88  0482 653d27312720  	dc.b	"e='1' %o01><label "
  89  0494 666f723d2772  	dc.b	"for='relay02on'>ON"
  90  04a6 3c2f6c616265  	dc.b	"</label><input typ"
  91  04b8 653d27726164  	dc.b	"e='radio' id='rela"
  92  04ca 7930326f6666  	dc.b	"y02off' name='o01'"
  93  04dc 2076616c7565  	dc.b	" value='0' %p01><l"
  94  04ee 6162656c2066  	dc.b	"abel for='relay02o"
  95  0500 666627        	dc.b	"ff'"
  96  0503 3e4f46463c2f  	dc.b	">OFF</label></td><"
  97  0515 2f74723e3c74  	dc.b	"/tr><tr><td class="
  98  0527 277431636c61  	dc.b	"'t1class'>Relay03<"
  99  0539 2f74643e3c74  	dc.b	"/td><td class='s%i"
 100  054b 3032273e3c2f  	dc.b	"02'></td><td class"
 101  055d 3d277434636c  	dc.b	"='t4class'><input "
 102  056f 747970653d27  	dc.b	"type='radio' id='r"
 103  0581 656c61793033  	dc.b	"elay03on' name='o0"
 104  0593 32272076616c  	dc.b	"2' value='1' %o02>"
 105  05a5 3c6c6162656c  	dc.b	"<label for='relay0"
 106  05b7 336f6e273e4f  	dc.b	"3on'>ON</label><in"
 107  05c9 707574207479  	dc.b	"put type='radio' i"
 108  05db 643d2772656c  	dc.b	"d='relay03off' nam"
 109  05ed 653d276f3032  	dc.b	"e='o02' value='0' "
 110  05ff 257030        	dc.b	"%p0"
 111  0602 323e3c6c6162  	dc.b	"2><label for='rela"
 112  0614 7930336f6666  	dc.b	"y03off'>OFF</label"
 113  0626 3e3c2f74643e  	dc.b	"></td></tr><tr><td"
 114  0638 20636c617373  	dc.b	" class='t1class'>R"
 115  064a 656c61793034  	dc.b	"elay04</td><td cla"
 116  065c 73733d277325  	dc.b	"ss='s%i03'></td><t"
 117  066e 6420636c6173  	dc.b	"d class='t4class'>"
 118  0680 3c696e707574  	dc.b	"<input type='radio"
 119  0692 272069643d27  	dc.b	"' id='relay04on' n"
 120  06a4 616d653d276f  	dc.b	"ame='o03' value='1"
 121  06b6 2720256f3033  	dc.b	"' %o03><label for="
 122  06c8 2772656c6179  	dc.b	"'relay04on'>ON</la"
 123  06da 62656c3e3c69  	dc.b	"bel><input type='r"
 124  06ec 6164696f2720  	dc.b	"adio' id='relay04o"
 125  06fe 666627        	dc.b	"ff'"
 126  0701 206e616d653d  	dc.b	" name='o03' value="
 127  0713 273027202570  	dc.b	"'0' %p03><label fo"
 128  0725 723d2772656c  	dc.b	"r='relay04off'>OFF"
 129  0737 3c2f6c616265  	dc.b	"</label></td></tr>"
 130  0749 3c74723e3c74  	dc.b	"<tr><td class='t1c"
 131  075b 6c617373273e  	dc.b	"lass'>Relay05</td>"
 132  076d 3c746420636c  	dc.b	"<td class='s%i04'>"
 133  077f 3c2f74643e3c  	dc.b	"</td><td class='t4"
 134  0791 636c61737327  	dc.b	"class'><input type"
 135  07a3 3d2772616469  	dc.b	"='radio' id='relay"
 136  07b5 30356f6e2720  	dc.b	"05on' name='o04' v"
 137  07c7 616c75653d27  	dc.b	"alue='1' %o04><lab"
 138  07d9 656c20666f72  	dc.b	"el for='relay05on'"
 139  07eb 3e4f4e3c2f6c  	dc.b	">ON</label><input "
 140  07fd 747970        	dc.b	"typ"
 141  0800 653d27726164  	dc.b	"e='radio' id='rela"
 142  0812 7930356f6666  	dc.b	"y05off' name='o04'"
 143  0824 2076616c7565  	dc.b	" value='0' %p04><l"
 144  0836 6162656c2066  	dc.b	"abel for='relay05o"
 145  0848 6666273e4f46  	dc.b	"ff'>OFF</label></t"
 146  085a 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
 147  086c 73733d277431  	dc.b	"ss='t1class'>Relay"
 148  087e 30363c2f7464  	dc.b	"06</td><td class='"
 149  0890 732569303527  	dc.b	"s%i05'></td><td cl"
 150  08a2 6173733d2774  	dc.b	"ass='t4class'><inp"
 151  08b4 757420747970  	dc.b	"ut type='radio' id"
 152  08c6 3d2772656c61  	dc.b	"='relay06on' name="
 153  08d8 276f30352720  	dc.b	"'o05' value='1' %o"
 154  08ea 30353e3c6c61  	dc.b	"05><label for='rel"
 155  08fc 617930        	dc.b	"ay0"
 156  08ff 366f6e273e4f  	dc.b	"6on'>ON</label><in"
 157  0911 707574207479  	dc.b	"put type='radio' i"
 158  0923 643d2772656c  	dc.b	"d='relay06off' nam"
 159  0935 653d276f3035  	dc.b	"e='o05' value='0' "
 160  0947 257030353e3c  	dc.b	"%p05><label for='r"
 161  0959 656c61793036  	dc.b	"elay06off'>OFF</la"
 162  096b 62656c3e3c2f  	dc.b	"bel></td></tr><tr>"
 163  097d 3c746420636c  	dc.b	"<td class='t1class"
 164  098f 273e52656c61  	dc.b	"'>Relay07</td><td "
 165  09a1 636c6173733d  	dc.b	"class='s%i06'></td"
 166  09b3 3e3c74642063  	dc.b	"><td class='t4clas"
 167  09c5 73273e3c696e  	dc.b	"s'><input type='ra"
 168  09d7 64696f272069  	dc.b	"dio' id='relay07on"
 169  09e9 27206e616d65  	dc.b	"' name='o06' value"
 170  09fb 3d2731        	dc.b	"='1"
 171  09fe 2720256f3036  	dc.b	"' %o06><label for="
 172  0a10 2772656c6179  	dc.b	"'relay07on'>ON</la"
 173  0a22 62656c3e3c69  	dc.b	"bel><input type='r"
 174  0a34 6164696f2720  	dc.b	"adio' id='relay07o"
 175  0a46 666627206e61  	dc.b	"ff' name='o06' val"
 176  0a58 75653d273027  	dc.b	"ue='0' %p06><label"
 177  0a6a 20666f723d27  	dc.b	" for='relay07off'>"
 178  0a7c 4f46463c2f6c  	dc.b	"OFF</label></td></"
 179  0a8e 74723e3c7472  	dc.b	"tr><tr><td class='"
 180  0aa0 7431636c6173  	dc.b	"t1class'>Relay08</"
 181  0ab2 74643e3c7464  	dc.b	"td><td class='s%i0"
 182  0ac4 37273e3c2f74  	dc.b	"7'></td><td class="
 183  0ad6 277434636c61  	dc.b	"'t4class'><input t"
 184  0ae8 7970653d2772  	dc.b	"ype='radio' id='re"
 185  0afa 6c6179        	dc.b	"lay"
 186  0afd 30386f6e2720  	dc.b	"08on' name='o07' v"
 187  0b0f 616c75653d27  	dc.b	"alue='1' %o07><lab"
 188  0b21 656c20666f72  	dc.b	"el for='relay08on'"
 189  0b33 3e4f4e3c2f6c  	dc.b	">ON</label><input "
 190  0b45 747970653d27  	dc.b	"type='radio' id='r"
 191  0b57 656c61793038  	dc.b	"elay08off' name='o"
 192  0b69 303727207661  	dc.b	"07' value='0' %p07"
 193  0b7b 3e3c6c616265  	dc.b	"><label for='relay"
 194  0b8d 30386f666627  	dc.b	"08off'>OFF</label>"
 195  0b9f 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 196  0bb1 636c6173733d  	dc.b	"class='t1class'>Re"
 197  0bc3 6c617930393c  	dc.b	"lay09</td><td clas"
 198  0bd5 733d27732569  	dc.b	"s='s%i08'></td><td"
 199  0be7 20636c617373  	dc.b	" class='t4class'><"
 200  0bf9 696e70        	dc.b	"inp"
 201  0bfc 757420747970  	dc.b	"ut type='radio' id"
 202  0c0e 3d2772656c61  	dc.b	"='relay09on' name="
 203  0c20 276f30382720  	dc.b	"'o08' value='1' %o"
 204  0c32 30383e3c6c61  	dc.b	"08><label for='rel"
 205  0c44 617930396f6e  	dc.b	"ay09on'>ON</label>"
 206  0c56 3c696e707574  	dc.b	"<input type='radio"
 207  0c68 272069643d27  	dc.b	"' id='relay09off' "
 208  0c7a 6e616d653d27  	dc.b	"name='o08' value='"
 209  0c8c 302720257030  	dc.b	"0' %p08><label for"
 210  0c9e 3d2772656c61  	dc.b	"='relay09off'>OFF<"
 211  0cb0 2f6c6162656c  	dc.b	"/label></td></tr><"
 212  0cc2 74723e3c7464  	dc.b	"tr><td class='t1cl"
 213  0cd4 617373273e52  	dc.b	"ass'>Relay10</td><"
 214  0ce6 746420636c61  	dc.b	"td class='s%i09'><"
 215  0cf8 2f7464        	dc.b	"/td"
 216  0cfb 3e3c74642063  	dc.b	"><td class='t4clas"
 217  0d0d 73273e3c696e  	dc.b	"s'><input type='ra"
 218  0d1f 64696f272069  	dc.b	"dio' id='relay10on"
 219  0d31 27206e616d65  	dc.b	"' name='o09' value"
 220  0d43 3d2731272025  	dc.b	"='1' %o09><label f"
 221  0d55 6f723d277265  	dc.b	"or='relay10on'>ON<"
 222  0d67 2f6c6162656c  	dc.b	"/label><input type"
 223  0d79 3d2772616469  	dc.b	"='radio' id='relay"
 224  0d8b 31306f666627  	dc.b	"10off' name='o09' "
 225  0d9d 76616c75653d  	dc.b	"value='0' %p09><la"
 226  0daf 62656c20666f  	dc.b	"bel for='relay10of"
 227  0dc1 66273e4f4646  	dc.b	"f'>OFF</label></td"
 228  0dd3 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 229  0de5 733d27743163  	dc.b	"s='t1class'>Relay1"
 230  0df7 313c2f        	dc.b	"1</"
 231  0dfa 74643e3c7464  	dc.b	"td><td class='s%i1"
 232  0e0c 30273e3c2f74  	dc.b	"0'></td><td class="
 233  0e1e 277434636c61  	dc.b	"'t4class'><input t"
 234  0e30 7970653d2772  	dc.b	"ype='radio' id='re"
 235  0e42 6c617931316f  	dc.b	"lay11on' name='o10"
 236  0e54 272076616c75  	dc.b	"' value='1' %o10><"
 237  0e66 6c6162656c20  	dc.b	"label for='relay11"
 238  0e78 6f6e273e4f4e  	dc.b	"on'>ON</label><inp"
 239  0e8a 757420747970  	dc.b	"ut type='radio' id"
 240  0e9c 3d2772656c61  	dc.b	"='relay11off' name"
 241  0eae 3d276f313027  	dc.b	"='o10' value='0' %"
 242  0ec0 7031303e3c6c  	dc.b	"p10><label for='re"
 243  0ed2 6c617931316f  	dc.b	"lay11off'>OFF</lab"
 244  0ee4 656c3e3c2f74  	dc.b	"el></td></tr><tr><"
 245  0ef6 746420        	dc.b	"td "
 246  0ef9 636c6173733d  	dc.b	"class='t1class'>Re"
 247  0f0b 6c617931323c  	dc.b	"lay12</td><td clas"
 248  0f1d 733d27732569  	dc.b	"s='s%i11'></td><td"
 249  0f2f 20636c617373  	dc.b	" class='t4class'><"
 250  0f41 696e70757420  	dc.b	"input type='radio'"
 251  0f53 2069643d2772  	dc.b	" id='relay12on' na"
 252  0f65 6d653d276f31  	dc.b	"me='o11' value='1'"
 253  0f77 20256f31313e  	dc.b	" %o11><label for='"
 254  0f89 72656c617931  	dc.b	"relay12on'>ON</lab"
 255  0f9b 656c3e3c696e  	dc.b	"el><input type='ra"
 256  0fad 64696f272069  	dc.b	"dio' id='relay12of"
 257  0fbf 6627206e616d  	dc.b	"f' name='o11' valu"
 258  0fd1 653d27302720  	dc.b	"e='0' %p11><label "
 259  0fe3 666f723d2772  	dc.b	"for='relay12off'>O"
 260  0ff5 46463c        	dc.b	"FF<"
 261  0ff8 2f6c6162656c  	dc.b	"/label></td></tr><"
 262  100a 74723e3c7464  	dc.b	"tr><td class='t1cl"
 263  101c 617373273e52  	dc.b	"ass'>Relay13</td><"
 264  102e 746420636c61  	dc.b	"td class='s%i12'><"
 265  1040 2f74643e3c74  	dc.b	"/td><td class='t4c"
 266  1052 6c617373273e  	dc.b	"lass'><input type="
 267  1064 27726164696f  	dc.b	"'radio' id='relay1"
 268  1076 336f6e27206e  	dc.b	"3on' name='o12' va"
 269  1088 6c75653d2731  	dc.b	"lue='1' %o12><labe"
 270  109a 6c20666f723d  	dc.b	"l for='relay13on'>"
 271  10ac 4f4e3c2f6c61  	dc.b	"ON</label><input t"
 272  10be 7970653d2772  	dc.b	"ype='radio' id='re"
 273  10d0 6c617931336f  	dc.b	"lay13off' name='o1"
 274  10e2 32272076616c  	dc.b	"2' value='0' %p12>"
 275  10f4 3c6c61        	dc.b	"<la"
 276  10f7 62656c20666f  	dc.b	"bel for='relay13of"
 277  1109 66273e4f4646  	dc.b	"f'>OFF</label></td"
 278  111b 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 279  112d 733d27743163  	dc.b	"s='t1class'>Relay1"
 280  113f 343c2f74643e  	dc.b	"4</td><td class='s"
 281  1151 25693133273e  	dc.b	"%i13'></td><td cla"
 282  1163 73733d277434  	dc.b	"ss='t4class'><inpu"
 283  1175 742074797065  	dc.b	"t type='radio' id="
 284  1187 2772656c6179  	dc.b	"'relay14on' name='"
 285  1199 6f3133272076  	dc.b	"o13' value='1' %o1"
 286  11ab 333e3c6c6162  	dc.b	"3><label for='rela"
 287  11bd 7931346f6e27  	dc.b	"y14on'>ON</label><"
 288  11cf 696e70757420  	dc.b	"input type='radio'"
 289  11e1 2069643d2772  	dc.b	" id='relay14off' n"
 290  11f3 616d65        	dc.b	"ame"
 291  11f6 3d276f313327  	dc.b	"='o13' value='0' %"
 292  1208 7031333e3c6c  	dc.b	"p13><label for='re"
 293  121a 6c617931346f  	dc.b	"lay14off'>OFF</lab"
 294  122c 656c3e3c2f74  	dc.b	"el></td></tr><tr><"
 295  123e 746420636c61  	dc.b	"td class='t1class'"
 296  1250 3e52656c6179  	dc.b	">Relay15</td><td c"
 297  1262 6c6173733d27  	dc.b	"lass='s%i14'></td>"
 298  1274 3c746420636c  	dc.b	"<td class='t4class"
 299  1286 273e3c696e70  	dc.b	"'><input type='rad"
 300  1298 696f27206964  	dc.b	"io' id='relay15on'"
 301  12aa 206e616d653d  	dc.b	" name='o14' value="
 302  12bc 27312720256f  	dc.b	"'1' %o14><label fo"
 303  12ce 723d2772656c  	dc.b	"r='relay15on'>ON</"
 304  12e0 6c6162656c3e  	dc.b	"label><input type="
 305  12f2 277261        	dc.b	"'ra"
 306  12f5 64696f272069  	dc.b	"dio' id='relay15of"
 307  1307 6627206e616d  	dc.b	"f' name='o14' valu"
 308  1319 653d27302720  	dc.b	"e='0' %p14><label "
 309  132b 666f723d2772  	dc.b	"for='relay15off'>O"
 310  133d 46463c2f6c61  	dc.b	"FF</label></td></t"
 311  134f 723e3c74723e  	dc.b	"r><tr><td class='t"
 312  1361 31636c617373  	dc.b	"1class'>Relay16</t"
 313  1373 643e3c746420  	dc.b	"d><td class='s%i15"
 314  1385 273e3c2f7464  	dc.b	"'></td><td class='"
 315  1397 7434636c6173  	dc.b	"t4class'><input ty"
 316  13a9 70653d277261  	dc.b	"pe='radio' id='rel"
 317  13bb 617931366f6e  	dc.b	"ay16on' name='o15'"
 318  13cd 2076616c7565  	dc.b	" value='1' %o15><l"
 319  13df 6162656c2066  	dc.b	"abel for='relay16o"
 320  13f1 6e273e        	dc.b	"n'>"
 321  13f4 4f4e3c2f6c61  	dc.b	"ON</label><input t"
 322  1406 7970653d2772  	dc.b	"ype='radio' id='re"
 323  1418 6c617931366f  	dc.b	"lay16off' name='o1"
 324  142a 35272076616c  	dc.b	"5' value='0' %p15>"
 325  143c 3c6c6162656c  	dc.b	"<label for='relay1"
 326  144e 366f6666273e  	dc.b	"6off'>OFF</label><"
 327  1460 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 328  1472 6c6173733d27  	dc.b	"lass='t1class'>Inv"
 329  1484 6572743c2f74  	dc.b	"ert</td><td class="
 330  1496 277433636c61  	dc.b	"'t3class'></td><td"
 331  14a8 20636c617373  	dc.b	" class='t4class'><"
 332  14ba 696e70757420  	dc.b	"input type='radio'"
 333  14cc 2069643d2769  	dc.b	" id='invertOn' nam"
 334  14de 653d27673030  	dc.b	"e='g00' value='1' "
 335  14f0 256730        	dc.b	"%g0"
 336  14f3 303e3c6c6162  	dc.b	"0><label for='inve"
 337  1505 72744f6e273e  	dc.b	"rtOn'>ON</label><i"
 338  1517 6e7075742074  	dc.b	"nput type='radio' "
 339  1529 69643d27696e  	dc.b	"id='invertOff' nam"
 340  153b 653d27673030  	dc.b	"e='g00' value='0' "
 341  154d 256830303e3c  	dc.b	"%h00><label for='i"
 342  155f 6e766572744f  	dc.b	"nvertOff'>OFF</lab"
 343  1571 656c3e3c2f74  	dc.b	"el></td></tr></tab"
 344  1583 6c653e3c6275  	dc.b	"le><button type='s"
 345  1595 75626d697427  	dc.b	"ubmit' title='Save"
 346  15a7 7320796f7572  	dc.b	"s your changes - d"
 347  15b9 6f6573206e6f  	dc.b	"oes not restart th"
 348  15cb 65204e657477  	dc.b	"e Network Module'>"
 349  15dd 536176653c2f  	dc.b	"Save</button><butt"
 350  15ef 6f6e20        	dc.b	"on "
 351  15f2 747970653d27  	dc.b	"type='reset' title"
 352  1604 3d27556e2d64  	dc.b	"='Un-does any chan"
 353  1616 676573207468  	dc.b	"ges that have not "
 354  1628 6265656e2073  	dc.b	"been saved'>Undo A"
 355  163a 6c6c3c2f6275  	dc.b	"ll</button></form>"
 356  164c 3c666f726d20  	dc.b	"<form style='displ"
 357  165e 61793a20696e  	dc.b	"ay: inline' action"
 358  1670 3d2725783030  	dc.b	"='%x00http://192.1"
 359  1682 36382e303031  	dc.b	"68.001.004:08080/6"
 360  1694 3127206d6574  	dc.b	"1' method='GET'><b"
 361  16a6 7574746f6e20  	dc.b	"utton title='Save "
 362  16b8 666972737421  	dc.b	"first! This button"
 363  16ca 2077696c6c20  	dc.b	" will not save you"
 364  16dc 72206368616e  	dc.b	"r changes'>Address"
 365  16ee 205365        	dc.b	" Se"
 366  16f1 7474696e6773  	dc.b	"ttings</button></f"
 367  1703 6f726d3e3c66  	dc.b	"orm><form style='d"
 368  1715 6973706c6179  	dc.b	"isplay: inline' ac"
 369  1727 74696f6e3d27  	dc.b	"tion='%x00http://1"
 370  1739 39322e313638  	dc.b	"92.168.001.004:080"
 371  174b 38302f363627  	dc.b	"80/66' method='GET"
 372  175d 273e3c627574  	dc.b	"'><button title='S"
 373  176f 617665206669  	dc.b	"ave first! This bu"
 374  1781 74746f6e2077  	dc.b	"tton will not save"
 375  1793 20796f757220  	dc.b	" your changes'>Net"
 376  17a5 776f726b2053  	dc.b	"work Statistics</b"
 377  17b7 7574746f6e3e  	dc.b	"utton></form><form"
 378  17c9 207374796c65  	dc.b	" style='display: i"
 379  17db 6e6c696e6527  	dc.b	"nline' action='%x0"
 380  17ed 306874        	dc.b	"0ht"
 381  17f0 74703a2f2f31  	dc.b	"tp://192.168.001.0"
 382  1802 30343a303830  	dc.b	"04:08080/63' metho"
 383  1814 643d27474554  	dc.b	"d='GET'><button ti"
 384  1826 746c653d2753  	dc.b	"tle='Save first! T"
 385  1838 686973206275  	dc.b	"his button will no"
 386  184a 742073617665  	dc.b	"t save your change"
 387  185c 73273e48656c  	dc.b	"s'>Help</button></"
 388  186e 666f726d3e3c  	dc.b	"form></body></html"
 389  1880 3e00          	dc.b	">",0
 390  1882               L71_g_HtmlPageAddress:
 391  1882 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 392  1894 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 393  18a6 6561643e3c74  	dc.b	"ead><title>Address"
 394  18b8 205365747469  	dc.b	" Settings</title><"
 395  18ca 7374796c653e  	dc.b	"style>.t1class { w"
 396  18dc 696474683a20  	dc.b	"idth: 100px; }.t2c"
 397  18ee 6c617373207b  	dc.b	"lass { width: 25px"
 398  1900 3b207d2e7433  	dc.b	"; }.t3class { widt"
 399  1912 683a20313870  	dc.b	"h: 18px; }.t4class"
 400  1924 207b20776964  	dc.b	" { width: 40px; }t"
 401  1936 64207b207465  	dc.b	"d { text-align: ce"
 402  1948 6e7465723b20  	dc.b	"nter; border: 1px "
 403  195a 626c61636b20  	dc.b	"black solid; }</st"
 404  196c 796c653e3c2f  	dc.b	"yle></head><body><"
 405  197e 68313e        	dc.b	"h1>"
 406  1981 416464726573  	dc.b	"Address Settings</"
 407  1993 68313e3c666f  	dc.b	"h1><form method='P"
 408  19a5 4f5354272061  	dc.b	"OST' action='/'><t"
 409  19b7 61626c653e3c  	dc.b	"able><tr><td class"
 410  19c9 3d277431636c  	dc.b	"='t1class'>IP Addr"
 411  19db 3c2f74643e3c  	dc.b	"</td><td><input ty"
 412  19ed 70653d277465  	dc.b	"pe='text' name='b0"
 413  19ff 302720636c61  	dc.b	"0' class='t2class'"
 414  1a11 2076616c7565  	dc.b	" value='%b00' patt"
 415  1a23 65726e3d275b  	dc.b	"ern='[0-9]{3}' tit"
 416  1a35 6c653d275468  	dc.b	"le='Three digits f"
 417  1a47 726f6d203030  	dc.b	"rom 000 to 255' ma"
 418  1a59 786c656e6774  	dc.b	"xlength='3' size='"
 419  1a6b 33273e3c2f74  	dc.b	"3'></td><td><input"
 420  1a7d 207479        	dc.b	" ty"
 421  1a80 70653d277465  	dc.b	"pe='text' name='b0"
 422  1a92 312720636c61  	dc.b	"1' class='t2class'"
 423  1aa4 2076616c7565  	dc.b	" value='%b01' patt"
 424  1ab6 65726e3d275b  	dc.b	"ern='[0-9]{3}' tit"
 425  1ac8 6c653d275468  	dc.b	"le='Three digits f"
 426  1ada 726f6d203030  	dc.b	"rom 000 to 255' ma"
 427  1aec 786c656e6774  	dc.b	"xlength='3' size='"
 428  1afe 33273e3c2f74  	dc.b	"3'></td><td><input"
 429  1b10 20747970653d  	dc.b	" type='text' name="
 430  1b22 276230322720  	dc.b	"'b02' class='t2cla"
 431  1b34 737327207661  	dc.b	"ss' value='%b02' p"
 432  1b46 61747465726e  	dc.b	"attern='[0-9]{3}' "
 433  1b58 7469746c653d  	dc.b	"title='Three digit"
 434  1b6a 732066726f6d  	dc.b	"s from 000 to 255'"
 435  1b7c 206d61        	dc.b	" ma"
 436  1b7f 786c656e6774  	dc.b	"xlength='3' size='"
 437  1b91 33273e3c2f74  	dc.b	"3'></td><td><input"
 438  1ba3 20747970653d  	dc.b	" type='text' name="
 439  1bb5 276230332720  	dc.b	"'b03' class='t2cla"
 440  1bc7 737327207661  	dc.b	"ss' value='%b03' p"
 441  1bd9 61747465726e  	dc.b	"attern='[0-9]{3}' "
 442  1beb 7469746c653d  	dc.b	"title='Three digit"
 443  1bfd 732066726f6d  	dc.b	"s from 000 to 255'"
 444  1c0f 206d61786c65  	dc.b	" maxlength='3' siz"
 445  1c21 653d2733273e  	dc.b	"e='3'></td></tr><t"
 446  1c33 723e3c746420  	dc.b	"r><td class='t1cla"
 447  1c45 7373273e4761  	dc.b	"ss'>Gateway</td><t"
 448  1c57 643e3c696e70  	dc.b	"d><input type='tex"
 449  1c69 7427206e616d  	dc.b	"t' name='b04' clas"
 450  1c7b 733d27        	dc.b	"s='"
 451  1c7e 7432636c6173  	dc.b	"t2class' value='%b"
 452  1c90 303427207061  	dc.b	"04' pattern='[0-9]"
 453  1ca2 7b337d272074  	dc.b	"{3}' title='Three "
 454  1cb4 646967697473  	dc.b	"digits from 000 to"
 455  1cc6 203235352720  	dc.b	" 255' maxlength='3"
 456  1cd8 272073697a65  	dc.b	"' size='3'></td><t"
 457  1cea 643e3c696e70  	dc.b	"d><input type='tex"
 458  1cfc 7427206e616d  	dc.b	"t' name='b05' clas"
 459  1d0e 733d27743263  	dc.b	"s='t2class' value="
 460  1d20 272562303527  	dc.b	"'%b05' pattern='[0"
 461  1d32 2d395d7b337d  	dc.b	"-9]{3}' title='Thr"
 462  1d44 656520646967  	dc.b	"ee digits from 000"
 463  1d56 20746f203235  	dc.b	" to 255' maxlength"
 464  1d68 3d2733272073  	dc.b	"='3' size='3'></td"
 465  1d7a 3e3c74        	dc.b	"><t"
 466  1d7d 643e3c696e70  	dc.b	"d><input type='tex"
 467  1d8f 7427206e616d  	dc.b	"t' name='b06' clas"
 468  1da1 733d27743263  	dc.b	"s='t2class' value="
 469  1db3 272562303627  	dc.b	"'%b06' pattern='[0"
 470  1dc5 2d395d7b337d  	dc.b	"-9]{3}' title='Thr"
 471  1dd7 656520646967  	dc.b	"ee digits from 000"
 472  1de9 20746f203235  	dc.b	" to 255' maxlength"
 473  1dfb 3d2733272073  	dc.b	"='3' size='3'></td"
 474  1e0d 3e3c74643e3c  	dc.b	"><td><input type='"
 475  1e1f 746578742720  	dc.b	"text' name='b07' c"
 476  1e31 6c6173733d27  	dc.b	"lass='t2class' val"
 477  1e43 75653d272562  	dc.b	"ue='%b07' pattern="
 478  1e55 275b302d395d  	dc.b	"'[0-9]{3}' title='"
 479  1e67 546872656520  	dc.b	"Three digits from "
 480  1e79 303030        	dc.b	"000"
 481  1e7c 20746f203235  	dc.b	" to 255' maxlength"
 482  1e8e 3d2733272073  	dc.b	"='3' size='3'></td"
 483  1ea0 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 484  1eb2 733d27743163  	dc.b	"s='t1class'>Netmas"
 485  1ec4 6b3c2f74643e  	dc.b	"k</td><td><input t"
 486  1ed6 7970653d2774  	dc.b	"ype='text' name='b"
 487  1ee8 30382720636c  	dc.b	"08' class='t2class"
 488  1efa 272076616c75  	dc.b	"' value='%b08' pat"
 489  1f0c 7465726e3d27  	dc.b	"tern='[0-9]{3}' ti"
 490  1f1e 746c653d2754  	dc.b	"tle='Three digits "
 491  1f30 66726f6d2030  	dc.b	"from 000 to 255' m"
 492  1f42 61786c656e67  	dc.b	"axlength='3' size="
 493  1f54 2733273e3c2f  	dc.b	"'3'></td><td><inpu"
 494  1f66 742074797065  	dc.b	"t type='text' name"
 495  1f78 3d2762        	dc.b	"='b"
 496  1f7b 30392720636c  	dc.b	"09' class='t2class"
 497  1f8d 272076616c75  	dc.b	"' value='%b09' pat"
 498  1f9f 7465726e3d27  	dc.b	"tern='[0-9]{3}' ti"
 499  1fb1 746c653d2754  	dc.b	"tle='Three digits "
 500  1fc3 66726f6d2030  	dc.b	"from 000 to 255' m"
 501  1fd5 61786c656e67  	dc.b	"axlength='3' size="
 502  1fe7 2733273e3c2f  	dc.b	"'3'></td><td><inpu"
 503  1ff9 742074797065  	dc.b	"t type='text' name"
 504  200b 3d2762313027  	dc.b	"='b10' class='t2cl"
 505  201d 617373272076  	dc.b	"ass' value='%b10' "
 506  202f 706174746572  	dc.b	"pattern='[0-9]{3}'"
 507  2041 207469746c65  	dc.b	" title='Three digi"
 508  2053 74732066726f  	dc.b	"ts from 000 to 255"
 509  2065 27206d61786c  	dc.b	"' maxlength='3' si"
 510  2077 7a653d        	dc.b	"ze="
 511  207a 2733273e3c2f  	dc.b	"'3'></td><td><inpu"
 512  208c 742074797065  	dc.b	"t type='text' name"
 513  209e 3d2762313127  	dc.b	"='b11' class='t2cl"
 514  20b0 617373272076  	dc.b	"ass' value='%b11' "
 515  20c2 706174746572  	dc.b	"pattern='[0-9]{3}'"
 516  20d4 207469746c65  	dc.b	" title='Three digi"
 517  20e6 74732066726f  	dc.b	"ts from 000 to 255"
 518  20f8 27206d61786c  	dc.b	"' maxlength='3' si"
 519  210a 7a653d273327  	dc.b	"ze='3'></td></tr><"
 520  211c 2f7461626c65  	dc.b	"/table><table><tr>"
 521  212e 3c746420636c  	dc.b	"<td class='t1class"
 522  2140 273e506f7274  	dc.b	"'>Port   </td><td>"
 523  2152 3c696e707574  	dc.b	"<input type='text'"
 524  2164 206e616d653d  	dc.b	" name='c00' class="
 525  2176 277434        	dc.b	"'t4"
 526  2179 636c61737327  	dc.b	"class' value='%c00"
 527  218b 272070617474  	dc.b	"' pattern='[0-9]{5"
 528  219d 7d2720746974  	dc.b	"}' title='Five dig"
 529  21af 697473206672  	dc.b	"its from 00010 to "
 530  21c1 363535333627  	dc.b	"65536' maxlength='"
 531  21d3 35272073697a  	dc.b	"5' size='5'></td><"
 532  21e5 2f74723e3c2f  	dc.b	"/tr></table><table"
 533  21f7 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 534  2209 636c61737327  	dc.b	"class'>MAC Address"
 535  221b 3c2f74643e3c  	dc.b	"</td><td><input ty"
 536  222d 70653d277465  	dc.b	"pe='text' name='d0"
 537  223f 302720636c61  	dc.b	"0' class='t3class'"
 538  2251 2076616c7565  	dc.b	" value='%d00' patt"
 539  2263 65726e3d275b  	dc.b	"ern='[0-9a-f]{2}' "
 540  2275 746974        	dc.b	"tit"
 541  2278 6c653d275477  	dc.b	"le='Two hex digits"
 542  228a 2066726f6d20  	dc.b	" from 00 to ff' ma"
 543  229c 786c656e6774  	dc.b	"xlength='2' size='"
 544  22ae 32273e3c2f74  	dc.b	"2'></td><td><input"
 545  22c0 20747970653d  	dc.b	" type='text' name="
 546  22d2 276430312720  	dc.b	"'d01' class='t3cla"
 547  22e4 737327207661  	dc.b	"ss' value='%d01' p"
 548  22f6 61747465726e  	dc.b	"attern='[0-9a-f]{2"
 549  2308 7d2720746974  	dc.b	"}' title='Two hex "
 550  231a 646967697473  	dc.b	"digits from 00 to "
 551  232c 666627206d61  	dc.b	"ff' maxlength='2' "
 552  233e 73697a653d27  	dc.b	"size='2'></td><td>"
 553  2350 3c696e707574  	dc.b	"<input type='text'"
 554  2362 206e616d653d  	dc.b	" name='d02' class="
 555  2374 277433        	dc.b	"'t3"
 556  2377 636c61737327  	dc.b	"class' value='%d02"
 557  2389 272070617474  	dc.b	"' pattern='[0-9a-f"
 558  239b 5d7b327d2720  	dc.b	"]{2}' title='Two h"
 559  23ad 657820646967  	dc.b	"ex digits from 00 "
 560  23bf 746f20666627  	dc.b	"to ff' maxlength='"
 561  23d1 32272073697a  	dc.b	"2' size='2'></td><"
 562  23e3 74643e3c696e  	dc.b	"td><input type='te"
 563  23f5 787427206e61  	dc.b	"xt' name='d03' cla"
 564  2407 73733d277433  	dc.b	"ss='t3class' value"
 565  2419 3d2725643033  	dc.b	"='%d03' pattern='["
 566  242b 302d39612d66  	dc.b	"0-9a-f]{2}' title="
 567  243d 2754776f2068  	dc.b	"'Two hex digits fr"
 568  244f 6f6d20303020  	dc.b	"om 00 to ff' maxle"
 569  2461 6e6774683d27  	dc.b	"ngth='2' size='2'>"
 570  2473 3c2f74        	dc.b	"</t"
 571  2476 643e3c74643e  	dc.b	"d><td><input type="
 572  2488 277465787427  	dc.b	"'text' name='d04' "
 573  249a 636c6173733d  	dc.b	"class='t3class' va"
 574  24ac 6c75653d2725  	dc.b	"lue='%d04' pattern"
 575  24be 3d275b302d39  	dc.b	"='[0-9a-f]{2}' tit"
 576  24d0 6c653d275477  	dc.b	"le='Two hex digits"
 577  24e2 2066726f6d20  	dc.b	" from 00 to ff' ma"
 578  24f4 786c656e6774  	dc.b	"xlength='2' size='"
 579  2506 32273e3c2f74  	dc.b	"2'></td><td><input"
 580  2518 20747970653d  	dc.b	" type='text' name="
 581  252a 276430352720  	dc.b	"'d05' class='t3cla"
 582  253c 737327207661  	dc.b	"ss' value='%d05' p"
 583  254e 61747465726e  	dc.b	"attern='[0-9a-f]{2"
 584  2560 7d2720746974  	dc.b	"}' title='Two hex "
 585  2572 646967        	dc.b	"dig"
 586  2575 697473206672  	dc.b	"its from 00 to ff'"
 587  2587 206d61786c65  	dc.b	" maxlength='2' siz"
 588  2599 653d2732273e  	dc.b	"e='2'></td></tr></"
 589  25ab 7461626c653e  	dc.b	"table><button type"
 590  25bd 3d277375626d  	dc.b	"='submit' title='S"
 591  25cf 617665732079  	dc.b	"aves your changes "
 592  25e1 7468656e2072  	dc.b	"then restarts the "
 593  25f3 4e6574776f72  	dc.b	"Network Module'>Sa"
 594  2605 76653c2f6275  	dc.b	"ve</button><button"
 595  2617 20747970653d  	dc.b	" type='reset' titl"
 596  2629 653d27556e2d  	dc.b	"e='Un-does any cha"
 597  263b 6e6765732074  	dc.b	"nges that have not"
 598  264d 206265656e20  	dc.b	" been saved'>Undo "
 599  265f 416c6c3c2f62  	dc.b	"All</button></form"
 600  2671 3e3c70        	dc.b	"><p"
 601  2674 206c696e652d  	dc.b	" line-height 20px>"
 602  2686 557365206361  	dc.b	"Use caution when c"
 603  2698 68616e67696e  	dc.b	"hanging the above."
 604  26aa 20496620796f  	dc.b	" If you make a mis"
 605  26bc 74616b652079  	dc.b	"take you may have "
 606  26ce 746f3c62723e  	dc.b	"to<br>restore fact"
 607  26e0 6f7279206465  	dc.b	"ory defaults by ho"
 608  26f2 6c64696e6720  	dc.b	"lding down the res"
 609  2704 657420627574  	dc.b	"et button for 10 s"
 610  2716 65636f6e6473  	dc.b	"econds.<br><br>Mak"
 611  2728 652073757265  	dc.b	"e sure the MAC you"
 612  273a 206173736967  	dc.b	" assign is unique "
 613  274c 746f20796f75  	dc.b	"to your local netw"
 614  275e 6f726b2e2052  	dc.b	"ork. Recommended<b"
 615  2770 723e69        	dc.b	"r>i"
 616  2773 732074686174  	dc.b	"s that you just in"
 617  2785 6372656d656e  	dc.b	"crement the lowest"
 618  2797 206f63746574  	dc.b	" octet and then la"
 619  27a9 62656c20796f  	dc.b	"bel your devices f"
 620  27bb 6f723c62723e  	dc.b	"or<br>future refer"
 621  27cd 656e63652e3c  	dc.b	"ence.<br><br>If yo"
 622  27df 75206368616e  	dc.b	"u change the highe"
 623  27f1 7374206f6374  	dc.b	"st octet of the MA"
 624  2803 4320796f7520  	dc.b	"C you MUST use an "
 625  2815 6576656e206e  	dc.b	"even number to<br>"
 626  2827 666f726d2061  	dc.b	"form a unicast add"
 627  2839 726573732e20  	dc.b	"ress. 00, 02, ... "
 628  284b 66632c206665  	dc.b	"fc, fe etc work fi"
 629  285d 6e652e203031  	dc.b	"ne. 01, 03 ... fd,"
 630  286f 206666        	dc.b	" ff"
 631  2872 206172652066  	dc.b	" are for<br>multic"
 632  2884 61737420616e  	dc.b	"ast and will not w"
 633  2896 6f726b2e3c2f  	dc.b	"ork.</p><form styl"
 634  28a8 653d27646973  	dc.b	"e='display: inline"
 635  28ba 272061637469  	dc.b	"' action='%x00http"
 636  28cc 3a2f2f313932  	dc.b	"://192.168.001.004"
 637  28de 3a3038303830  	dc.b	":08080/91' method="
 638  28f0 27474554273e  	dc.b	"'GET'><button titl"
 639  2902 653d27536176  	dc.b	"e='Save first! Thi"
 640  2914 732062757474  	dc.b	"s button will not "
 641  2926 736176652079  	dc.b	"save your changes'"
 642  2938 3e5265626f6f  	dc.b	">Reboot</button></"
 643  294a 666f726d3e26  	dc.b	"form>&nbsp&nbspNOT"
 644  295c 453a20526562  	dc.b	"E: Reboot may caus"
 645  296e 652074        	dc.b	"e t"
 646  2971 68652072656c  	dc.b	"he relays to cycle"
 647  2983 2e3c62723e3c  	dc.b	".<br><br><form sty"
 648  2995 6c653d276469  	dc.b	"le='display: inlin"
 649  29a7 652720616374  	dc.b	"e' action='%x00htt"
 650  29b9 703a2f2f3139  	dc.b	"p://192.168.001.00"
 651  29cb 343a30383038  	dc.b	"4:08080/60' method"
 652  29dd 3d2747455427  	dc.b	"='GET'><button tit"
 653  29ef 6c653d275361  	dc.b	"le='Save first! Th"
 654  2a01 697320627574  	dc.b	"is button will not"
 655  2a13 207361766520  	dc.b	" save your changes"
 656  2a25 273e52656c61  	dc.b	"'>Relay Controls</"
 657  2a37 627574746f6e  	dc.b	"button></form><for"
 658  2a49 6d207374796c  	dc.b	"m style='display: "
 659  2a5b 696e6c696e65  	dc.b	"inline' action='%x"
 660  2a6d 303068        	dc.b	"00h"
 661  2a70 7474703a2f2f  	dc.b	"ttp://192.168.001."
 662  2a82 3030343a3038  	dc.b	"004:08080/66' meth"
 663  2a94 6f643d274745  	dc.b	"od='GET'><button t"
 664  2aa6 69746c653d27  	dc.b	"itle='Save first! "
 665  2ab8 546869732062  	dc.b	"This button will n"
 666  2aca 6f7420736176  	dc.b	"ot save your chang"
 667  2adc 6573273e4e65  	dc.b	"es'>Network Statis"
 668  2aee 746963733c2f  	dc.b	"tics</button></for"
 669  2b00 6d3e3c666f72  	dc.b	"m><form style='dis"
 670  2b12 706c61793a20  	dc.b	"play: inline' acti"
 671  2b24 6f6e3d272578  	dc.b	"on='%x00http://192"
 672  2b36 2e3136382e30  	dc.b	".168.001.004:08080"
 673  2b48 2f363327206d  	dc.b	"/63' method='GET'>"
 674  2b5a 3c627574746f  	dc.b	"<button title='Sav"
 675  2b6c 652066        	dc.b	"e f"
 676  2b6f 697273742120  	dc.b	"irst! This button "
 677  2b81 77696c6c206e  	dc.b	"will not save your"
 678  2b93 206368616e67  	dc.b	" changes'>Help</bu"
 679  2ba5 74746f6e3e3c  	dc.b	"tton></form></body"
 680  2bb7 3e3c2f68746d  	dc.b	"></html>",0
 681  2bc0               L12_g_HtmlPageHelp:
 682  2bc0 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 683  2bd2 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 684  2be4 6561643e3c74  	dc.b	"ead><title>Help Pa"
 685  2bf6 67653c2f7469  	dc.b	"ge</title><style>t"
 686  2c08 64207b207769  	dc.b	"d { width: 140px; "
 687  2c1a 70616464696e  	dc.b	"padding: 0px; }</s"
 688  2c2c 74796c653e3c  	dc.b	"tyle></head><body>"
 689  2c3e 3c68313e4865  	dc.b	"<h1>Help Page 1</h"
 690  2c50 313e3c70206c  	dc.b	"1><p line-height 2"
 691  2c62 3070783e416e  	dc.b	"0px>An alternative"
 692  2c74 20746f207573  	dc.b	" to using the web "
 693  2c86 696e74657266  	dc.b	"interface for chan"
 694  2c98 67696e672072  	dc.b	"ging relay states "
 695  2caa 697320746f20  	dc.b	"is to send relay<b"
 696  2cbc 723e73        	dc.b	"r>s"
 697  2cbf 706563696669  	dc.b	"pecific html comma"
 698  2cd1 6e64732e2045  	dc.b	"nds. Enter http://"
 699  2ce3 49503a506f72  	dc.b	"IP:Port/xx where<b"
 700  2cf5 723e2d204950  	dc.b	"r>- IP = the devic"
 701  2d07 652049502041  	dc.b	"e IP Address, for "
 702  2d19 6578616d706c  	dc.b	"example 192.168.1."
 703  2d2b 343c62723e2d  	dc.b	"4<br>- Port = the "
 704  2d3d 646576696365  	dc.b	"device Port number"
 705  2d4f 2c20666f7220  	dc.b	", for example 8080"
 706  2d61 3c62723e2d20  	dc.b	"<br>- xx = one of "
 707  2d73 74686520636f  	dc.b	"the codes below:<b"
 708  2d85 723e3c746162  	dc.b	"r><table><tr><td>0"
 709  2d97 30203d205265  	dc.b	"0 = Relay-01 OFF</"
 710  2da9 74643e3c7464  	dc.b	"td><td>09 = Relay-"
 711  2dbb 303520        	dc.b	"05 "
 712  2dbe 4f46463c2f74  	dc.b	"OFF</td><td>17 = R"
 713  2dd0 656c61792d30  	dc.b	"elay-09 OFF</td><t"
 714  2de2 643e3235203d  	dc.b	"d>25 = Relay-13 OF"
 715  2df4 463c62723e3c  	dc.b	"F<br></td></tr><tr"
 716  2e06 3e3c74643e30  	dc.b	"><td>01 = Relay-01"
 717  2e18 20204f4e3c2f  	dc.b	"  ON</td><td>10 = "
 718  2e2a 52656c61792d  	dc.b	"Relay-05  ON</td><"
 719  2e3c 74643e313820  	dc.b	"td>18 = Relay-09  "
 720  2e4e 4f4e3c2f7464  	dc.b	"ON</td><td>26 = Re"
 721  2e60 6c61792d3133  	dc.b	"lay-13  ON<br></td"
 722  2e72 3e3c2f74723e  	dc.b	"></tr><tr><td>02 ="
 723  2e84 2052656c6179  	dc.b	" Relay-02 OFF</td>"
 724  2e96 3c74643e3131  	dc.b	"<td>11 = Relay-06 "
 725  2ea8 4f46463c2f74  	dc.b	"OFF</td><td>19 = R"
 726  2eba 656c61        	dc.b	"ela"
 727  2ebd 792d3130204f  	dc.b	"y-10 OFF</td><td>2"
 728  2ecf 37203d205265  	dc.b	"7 = Relay-14 OFF<b"
 729  2ee1 723e3c2f7464  	dc.b	"r></td></tr><tr><t"
 730  2ef3 643e3033203d  	dc.b	"d>03 = Relay-02  O"
 731  2f05 4e3c2f74643e  	dc.b	"N</td><td>12 = Rel"
 732  2f17 61792d303620  	dc.b	"ay-06  ON</td><td>"
 733  2f29 3230203d2052  	dc.b	"20 = Relay-10  ON<"
 734  2f3b 2f74643e3c74  	dc.b	"/td><td>28 = Relay"
 735  2f4d 2d313420204f  	dc.b	"-14  ON<br></td></"
 736  2f5f 74723e3c7472  	dc.b	"tr><tr><td>04 = Re"
 737  2f71 6c61792d3033  	dc.b	"lay-03 OFF</td><td"
 738  2f83 3e3133203d20  	dc.b	">13 = Relay-07 OFF"
 739  2f95 3c2f74643e3c  	dc.b	"</td><td>21 = Rela"
 740  2fa7 792d3131204f  	dc.b	"y-11 OFF</td><td>2"
 741  2fb9 39203d        	dc.b	"9 ="
 742  2fbc 2052656c6179  	dc.b	" Relay-15 OFF<br><"
 743  2fce 2f74643e3c2f  	dc.b	"/td></tr><tr><td>0"
 744  2fe0 35203d205265  	dc.b	"5 = Relay-03  ON</"
 745  2ff2 74643e3c7464  	dc.b	"td><td>14 = Relay-"
 746  3004 303720204f4e  	dc.b	"07  ON</td><td>22 "
 747  3016 3d2052656c61  	dc.b	"= Relay-11  ON</td"
 748  3028 3e3c74643e33  	dc.b	"><td>30 = Relay-15"
 749  303a 20204f4e3c62  	dc.b	"  ON<br></td></tr>"
 750  304c 3c74723e3c74  	dc.b	"<tr><td>07 = Relay"
 751  305e 2d3034204f46  	dc.b	"-04 OFF</td><td>15"
 752  3070 203d2052656c  	dc.b	" = Relay-08 OFF</t"
 753  3082 643e3c74643e  	dc.b	"d><td>23 = Relay-1"
 754  3094 32204f46463c  	dc.b	"2 OFF</td><td>31 ="
 755  30a6 2052656c6179  	dc.b	" Relay-16 OFF<br><"
 756  30b8 2f7464        	dc.b	"/td"
 757  30bb 3e3c2f74723e  	dc.b	"></tr><tr><td>08 ="
 758  30cd 2052656c6179  	dc.b	" Relay-04  ON</td>"
 759  30df 3c74643e3136  	dc.b	"<td>16 = Relay-08 "
 760  30f1 204f4e3c2f74  	dc.b	" ON</td><td>24 = R"
 761  3103 656c61792d31  	dc.b	"elay-12  ON</td><t"
 762  3115 643e3332203d  	dc.b	"d>32 = Relay-16  O"
 763  3127 4e3c62723e3c  	dc.b	"N<br></td></tr></t"
 764  3139 61626c653e35  	dc.b	"able>55 = All Rela"
 765  314b 7973204f4e3c  	dc.b	"ys ON<br>56 = All "
 766  315d 52656c617973  	dc.b	"Relays OFF<br><br>"
 767  316f 54686520666f  	dc.b	"The following are "
 768  3181 616c736f2061  	dc.b	"also available:<br"
 769  3193 3e3630203d20  	dc.b	">60 = Show Relay C"
 770  31a5 6f6e74726f6c  	dc.b	"ontrol page<br>61 "
 771  31b7 3d2053        	dc.b	"= S"
 772  31ba 686f77204164  	dc.b	"how Address Settin"
 773  31cc 677320706167  	dc.b	"gs page<br>63 = Sh"
 774  31de 6f772048656c  	dc.b	"ow Help Page 1<br>"
 775  31f0 3634203d2053  	dc.b	"64 = Show Help Pag"
 776  3202 6520323c6272  	dc.b	"e 2<br>65 = Flash "
 777  3214 4c45443c6272  	dc.b	"LED<br>66 = Show S"
 778  3226 746174697374  	dc.b	"tatistics<br>91 = "
 779  3238 5265626f6f74  	dc.b	"Reboot<br>99 = Sho"
 780  324a 772053686f72  	dc.b	"w Short Form Relay"
 781  325c 205365747469  	dc.b	" Settings<br></p><"
 782  326e 666f726d2073  	dc.b	"form style='displa"
 783  3280 793a20696e6c  	dc.b	"y: inline' action="
 784  3292 272578303068  	dc.b	"'%x00http://192.16"
 785  32a4 382e3030312e  	dc.b	"8.001.004:08080/64"
 786  32b6 27206d        	dc.b	"' m"
 787  32b9 6574686f643d  	dc.b	"ethod='GET'><butto"
 788  32cb 6e207469746c  	dc.b	"n title='Go to nex"
 789  32dd 742048656c70  	dc.b	"t Help page'>Next "
 790  32ef 48656c702050  	dc.b	"Help Page</button>"
 791  3301 3c2f666f726d  	dc.b	"</form></body></ht"
 792  3313 6d6c3e00      	dc.b	"ml>",0
 793  3317               L32_g_HtmlPageHelp2:
 794  3317 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 795  3329 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 796  333b 6561643e3c74  	dc.b	"ead><title>Help Pa"
 797  334d 676520323c2f  	dc.b	"ge 2</title><style"
 798  335f 3e3c2f737479  	dc.b	"></style></head><b"
 799  3371 6f64793e3c68  	dc.b	"ody><h1>Help Page "
 800  3383 323c2f68313e  	dc.b	"2</h1><p line-heig"
 801  3395 687420323070  	dc.b	"ht 20px>IP Address"
 802  33a7 2c2047617465  	dc.b	", Gateway Address,"
 803  33b9 204e65746d61  	dc.b	" Netmask, Port, an"
 804  33cb 64204d414320  	dc.b	"d MAC Address can "
 805  33dd 6f6e6c792062  	dc.b	"only be<br>changed"
 806  33ef 207669612074  	dc.b	" via the web inter"
 807  3401 666163652e20  	dc.b	"face. If the devic"
 808  3413 652062        	dc.b	"e b"
 809  3416 65636f6d6573  	dc.b	"ecomes inaccessibl"
 810  3428 6520796f7520  	dc.b	"e you can<br>reset"
 811  343a 20746f206661  	dc.b	" to factory defaul"
 812  344c 747320627920  	dc.b	"ts by holding the "
 813  345e 726573657420  	dc.b	"reset button down "
 814  3470 666f72203130  	dc.b	"for 10 seconds.<br"
 815  3482 3e4465666175  	dc.b	">Defaults:<br> IP "
 816  3494 3139322e3136  	dc.b	"192.168.1.4<br> Ga"
 817  34a6 746577617920  	dc.b	"teway 192.168.1.1<"
 818  34b8 62723e204e65  	dc.b	"br> Netmask 255.25"
 819  34ca 352e3235352e  	dc.b	"5.255.0<br> Port 0"
 820  34dc 383038303c62  	dc.b	"8080<br> MAC c2-4d"
 821  34ee 2d36392d3662  	dc.b	"-69-6b-65-00<br><b"
 822  3500 723e436f6465  	dc.b	"r>Code Revision 20"
 823  3512 323030        	dc.b	"200"
 824  3515 363139203133  	dc.b	"619 1346</p><form "
 825  3527 7374796c653d  	dc.b	"style='display: in"
 826  3539 6c696e652720  	dc.b	"line' action='%x00"
 827  354b 687474703a2f  	dc.b	"http://192.168.001"
 828  355d 2e3030343a30  	dc.b	".004:08080/60' met"
 829  356f 686f643d2747  	dc.b	"hod='GET'><button "
 830  3581 7469746c653d  	dc.b	"title='Go to Relay"
 831  3593 20436f6e7472  	dc.b	" Control Page'>Rel"
 832  35a5 617920436f6e  	dc.b	"ay Controls</butto"
 833  35b7 6e3e3c2f666f  	dc.b	"n></form></body></"
 834  35c9 68746d6c3e00  	dc.b	"html>",0
 835  35cf               L52_g_HtmlPageStats:
 836  35cf 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 837  35e1 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 838  35f3 6561643e3c74  	dc.b	"ead><title>Network"
 839  3605 205374617469  	dc.b	" Statistics</title"
 840  3617 3e3c7374796c  	dc.b	"><style>.t1class {"
 841  3629 207769647468  	dc.b	" width: 100px; }.t"
 842  363b 32636c617373  	dc.b	"2class { width: 45"
 843  364d 3070783b207d  	dc.b	"0px; }td { border:"
 844  365f 203170782062  	dc.b	" 1px black solid; "
 845  3671 7d3c2f737479  	dc.b	"}</style></head><b"
 846  3683 6f64793e3c68  	dc.b	"ody><h1>Network St"
 847  3695 617469737469  	dc.b	"atistics</h1><p>Va"
 848  36a7 6c7565732073  	dc.b	"lues shown are sin"
 849  36b9 6365206c6173  	dc.b	"ce last power on o"
 850  36cb 722072        	dc.b	"r r"
 851  36ce 657365743c2f  	dc.b	"eset</p><table><tr"
 852  36e0 3e3c74642063  	dc.b	"><td class='t1clas"
 853  36f2 73273e256530  	dc.b	"s'>%e00xxxxxxxxxx<"
 854  3704 2f74643e3c74  	dc.b	"/td><td class='t2c"
 855  3716 6c617373273e  	dc.b	"lass'>Dropped pack"
 856  3728 657473206174  	dc.b	"ets at the IP laye"
 857  373a 723c2f74643e  	dc.b	"r</td></tr><tr><td"
 858  374c 20636c617373  	dc.b	" class='t1class'>%"
 859  375e 653031787878  	dc.b	"e01xxxxxxxxxx</td>"
 860  3770 3c746420636c  	dc.b	"<td class='t2class"
 861  3782 273e52656365  	dc.b	"'>Received packets"
 862  3794 206174207468  	dc.b	" at the IP layer</"
 863  37a6 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
 864  37b8 6173733d2774  	dc.b	"ass='t1class'>%e02"
 865  37ca 787878        	dc.b	"xxx"
 866  37cd 787878787878  	dc.b	"xxxxxxx</td><td cl"
 867  37df 6173733d2774  	dc.b	"ass='t2class'>Sent"
 868  37f1 207061636b65  	dc.b	" packets at the IP"
 869  3803 206c61796572  	dc.b	" layer</td></tr><t"
 870  3815 723e3c746420  	dc.b	"r><td class='t1cla"
 871  3827 7373273e2565  	dc.b	"ss'>%e03xxxxxxxxxx"
 872  3839 3c2f74643e3c  	dc.b	"</td><td class='t2"
 873  384b 636c61737327  	dc.b	"class'>Packets dro"
 874  385d 707065642064  	dc.b	"pped due to wrong "
 875  386f 495020766572  	dc.b	"IP version or head"
 876  3881 6572206c656e  	dc.b	"er length</td></tr"
 877  3893 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 878  38a5 636c61737327  	dc.b	"class'>%e04xxxxxxx"
 879  38b7 7878783c2f74  	dc.b	"xxx</td><td class="
 880  38c9 277432        	dc.b	"'t2"
 881  38cc 636c61737327  	dc.b	"class'>Packets dro"
 882  38de 707065642064  	dc.b	"pped due to wrong "
 883  38f0 4950206c656e  	dc.b	"IP length, high by"
 884  3902 74653c2f7464  	dc.b	"te</td></tr><tr><t"
 885  3914 6420636c6173  	dc.b	"d class='t1class'>"
 886  3926 256530357878  	dc.b	"%e05xxxxxxxxxx</td"
 887  3938 3e3c74642063  	dc.b	"><td class='t2clas"
 888  394a 73273e506163  	dc.b	"s'>Packets dropped"
 889  395c 206475652074  	dc.b	" due to wrong IP l"
 890  396e 656e6774682c  	dc.b	"ength, low byte</t"
 891  3980 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
 892  3992 73733d277431  	dc.b	"ss='t1class'>%e06x"
 893  39a4 787878787878  	dc.b	"xxxxxxxxx</td><td "
 894  39b6 636c6173733d  	dc.b	"class='t2class'>Pa"
 895  39c8 636b65        	dc.b	"cke"
 896  39cb 74732064726f  	dc.b	"ts dropped since t"
 897  39dd 686579207765  	dc.b	"hey were IP fragme"
 898  39ef 6e74733c2f74  	dc.b	"nts</td></tr><tr><"
 899  3a01 746420636c61  	dc.b	"td class='t1class'"
 900  3a13 3e2565303778  	dc.b	">%e07xxxxxxxxxx</t"
 901  3a25 643e3c746420  	dc.b	"d><td class='t2cla"
 902  3a37 7373273e5061  	dc.b	"ss'>Packets droppe"
 903  3a49 642064756520  	dc.b	"d due to IP checks"
 904  3a5b 756d20657272  	dc.b	"um errors</td></tr"
 905  3a6d 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 906  3a7f 636c61737327  	dc.b	"class'>%e08xxxxxxx"
 907  3a91 7878783c2f74  	dc.b	"xxx</td><td class="
 908  3aa3 277432636c61  	dc.b	"'t2class'>Packets "
 909  3ab5 64726f707065  	dc.b	"dropped since they"
 910  3ac7 207765        	dc.b	" we"
 911  3aca 7265206e6f74  	dc.b	"re not ICMP or TCP"
 912  3adc 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 913  3aee 636c6173733d  	dc.b	"class='t1class'>%e"
 914  3b00 303978787878  	dc.b	"09xxxxxxxxxx</td><"
 915  3b12 746420636c61  	dc.b	"td class='t2class'"
 916  3b24 3e44726f7070  	dc.b	">Dropped ICMP pack"
 917  3b36 6574733c2f74  	dc.b	"ets</td></tr><tr><"
 918  3b48 746420636c61  	dc.b	"td class='t1class'"
 919  3b5a 3e2565313078  	dc.b	">%e10xxxxxxxxxx</t"
 920  3b6c 643e3c746420  	dc.b	"d><td class='t2cla"
 921  3b7e 7373273e5265  	dc.b	"ss'>Received ICMP "
 922  3b90 7061636b6574  	dc.b	"packets</td></tr><"
 923  3ba2 74723e3c7464  	dc.b	"tr><td class='t1cl"
 924  3bb4 617373273e25  	dc.b	"ass'>%e11xxxxxxxxx"
 925  3bc6 783c2f        	dc.b	"x</"
 926  3bc9 74643e3c7464  	dc.b	"td><td class='t2cl"
 927  3bdb 617373273e53  	dc.b	"ass'>Sent ICMP pac"
 928  3bed 6b6574733c2f  	dc.b	"kets</td></tr><tr>"
 929  3bff 3c746420636c  	dc.b	"<td class='t1class"
 930  3c11 273e25653132  	dc.b	"'>%e12xxxxxxxxxx</"
 931  3c23 74643e3c7464  	dc.b	"td><td class='t2cl"
 932  3c35 617373273e49  	dc.b	"ass'>ICMP packets "
 933  3c47 776974682061  	dc.b	"with a wrong type<"
 934  3c59 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 935  3c6b 6c6173733d27  	dc.b	"lass='t1class'>%e1"
 936  3c7d 337878787878  	dc.b	"3xxxxxxxxxx</td><t"
 937  3c8f 6420636c6173  	dc.b	"d class='t2class'>"
 938  3ca1 44726f707065  	dc.b	"Dropped TCP segmen"
 939  3cb3 74733c2f7464  	dc.b	"ts</td></tr><tr><t"
 940  3cc5 642063        	dc.b	"d c"
 941  3cc8 6c6173733d27  	dc.b	"lass='t1class'>%e1"
 942  3cda 347878787878  	dc.b	"4xxxxxxxxxx</td><t"
 943  3cec 6420636c6173  	dc.b	"d class='t2class'>"
 944  3cfe 526563656976  	dc.b	"Received TCP segme"
 945  3d10 6e74733c2f74  	dc.b	"nts</td></tr><tr><"
 946  3d22 746420636c61  	dc.b	"td class='t1class'"
 947  3d34 3e2565313578  	dc.b	">%e15xxxxxxxxxx</t"
 948  3d46 643e3c746420  	dc.b	"d><td class='t2cla"
 949  3d58 7373273e5365  	dc.b	"ss'>Sent TCP segme"
 950  3d6a 6e74733c2f74  	dc.b	"nts</td></tr><tr><"
 951  3d7c 746420636c61  	dc.b	"td class='t1class'"
 952  3d8e 3e2565313678  	dc.b	">%e16xxxxxxxxxx</t"
 953  3da0 643e3c746420  	dc.b	"d><td class='t2cla"
 954  3db2 7373273e5443  	dc.b	"ss'>TCP segments w"
 955  3dc4 697468        	dc.b	"ith"
 956  3dc7 206120626164  	dc.b	" a bad checksum</t"
 957  3dd9 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
 958  3deb 73733d277431  	dc.b	"ss='t1class'>%e17x"
 959  3dfd 787878787878  	dc.b	"xxxxxxxxx</td><td "
 960  3e0f 636c6173733d  	dc.b	"class='t2class'>TC"
 961  3e21 50207365676d  	dc.b	"P segments with a "
 962  3e33 626164204143  	dc.b	"bad ACK number</td"
 963  3e45 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 964  3e57 733d27743163  	dc.b	"s='t1class'>%e18xx"
 965  3e69 787878787878  	dc.b	"xxxxxxxx</td><td c"
 966  3e7b 6c6173733d27  	dc.b	"lass='t2class'>Rec"
 967  3e8d 656976656420  	dc.b	"eived TCP RST (res"
 968  3e9f 657429207365  	dc.b	"et) segments</td><"
 969  3eb1 2f74723e3c74  	dc.b	"/tr><tr><td class="
 970  3ec3 277431        	dc.b	"'t1"
 971  3ec6 636c61737327  	dc.b	"class'>%e19xxxxxxx"
 972  3ed8 7878783c2f74  	dc.b	"xxx</td><td class="
 973  3eea 277432636c61  	dc.b	"'t2class'>Retransm"
 974  3efc 697474656420  	dc.b	"itted TCP segments"
 975  3f0e 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 976  3f20 636c6173733d  	dc.b	"class='t1class'>%e"
 977  3f32 323078787878  	dc.b	"20xxxxxxxxxx</td><"
 978  3f44 746420636c61  	dc.b	"td class='t2class'"
 979  3f56 3e44726f7070  	dc.b	">Dropped SYNs due "
 980  3f68 746f20746f6f  	dc.b	"to too few connect"
 981  3f7a 696f6e732061  	dc.b	"ions avaliable</td"
 982  3f8c 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 983  3f9e 733d27743163  	dc.b	"s='t1class'>%e21xx"
 984  3fb0 787878787878  	dc.b	"xxxxxxxx</td><td c"
 985  3fc2 6c6173        	dc.b	"las"
 986  3fc5 733d27743263  	dc.b	"s='t2class'>SYNs f"
 987  3fd7 6f7220636c6f  	dc.b	"or closed ports, t"
 988  3fe9 726967676572  	dc.b	"riggering a RST</t"
 989  3ffb 643e3c2f7472  	dc.b	"d></tr></table><fo"
 990  400d 726d20737479  	dc.b	"rm style='display:"
 991  401f 20696e6c696e  	dc.b	" inline' action='%"
 992  4031 783030687474  	dc.b	"x00http://192.168."
 993  4043 3030312e3030  	dc.b	"001.004:08080/60' "
 994  4055 6d6574686f64  	dc.b	"method='GET'><butt"
 995  4067 6f6e20746974  	dc.b	"on title='Go to Re"
 996  4079 6c617920436f  	dc.b	"lay Control Page'>"
 997  408b 52656c617920  	dc.b	"Relay Controls</bu"
 998  409d 74746f6e3e3c  	dc.b	"tton></form></body"
 999  40af 3e3c2f68746d  	dc.b	"></html>",0
1000  40b8               L72_g_HtmlPageRstate:
1001  40b8 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
1002  40ca 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
1003  40dc 6561643e3c74  	dc.b	"ead><title>Help Pa"
1004  40ee 676520323c2f  	dc.b	"ge 2</title><style"
1005  4100 3e3c2f737479  	dc.b	"></style></head><b"
1006  4112 6f64793e3c70  	dc.b	"ody><p>%f00xxxxxxx"
1007  4124 787878787878  	dc.b	"xxxxxxxxx</p></bod"
1008  4136 793e3c2f6874  	dc.b	"y></html>",0
1074                     ; 612 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1074                     ; 613 {
1076                     	switch	.text
1077  0000               L3_CopyStringP:
1079  0000 89            	pushw	x
1080  0001 5203          	subw	sp,#3
1081       00000003      OFST:	set	3
1084                     ; 618   nBytes = 0;
1086  0003 5f            	clrw	x
1088  0004 2014          	jra	L17
1089  0006               L56:
1090                     ; 620     **ppBuffer = Character;
1092  0006 1e04          	ldw	x,(OFST+1,sp)
1093  0008 fe            	ldw	x,(x)
1094  0009 f7            	ld	(x),a
1095                     ; 621     *ppBuffer = *ppBuffer + 1;
1097  000a 1e04          	ldw	x,(OFST+1,sp)
1098  000c 9093          	ldw	y,x
1099  000e fe            	ldw	x,(x)
1100  000f 5c            	incw	x
1101  0010 90ff          	ldw	(y),x
1102                     ; 622     pString = pString + 1;
1104  0012 1e08          	ldw	x,(OFST+5,sp)
1105  0014 5c            	incw	x
1106  0015 1f08          	ldw	(OFST+5,sp),x
1107                     ; 623     nBytes++;
1109  0017 1e01          	ldw	x,(OFST-2,sp)
1110  0019 5c            	incw	x
1111  001a               L17:
1112  001a 1f01          	ldw	(OFST-2,sp),x
1114                     ; 619   while ((Character = pString[0]) != '\0') {
1114                     ; 620     **ppBuffer = Character;
1114                     ; 621     *ppBuffer = *ppBuffer + 1;
1114                     ; 622     pString = pString + 1;
1114                     ; 623     nBytes++;
1116  001c 1e08          	ldw	x,(OFST+5,sp)
1117  001e f6            	ld	a,(x)
1118  001f 6b03          	ld	(OFST+0,sp),a
1120  0021 26e3          	jrne	L56
1121                     ; 625   return nBytes;
1123  0023 1e01          	ldw	x,(OFST-2,sp)
1126  0025 5b05          	addw	sp,#5
1127  0027 81            	ret	
1172                     ; 629 static uint16_t CopyValue(uint8_t** ppBuffer, uint32_t nValue)
1172                     ; 630 {
1173                     	switch	.text
1174  0028               L5_CopyValue:
1176  0028 89            	pushw	x
1177       00000000      OFST:	set	0
1180                     ; 638   emb_itoa(nValue, OctetArray, 10, 5);
1182  0029 4b05          	push	#5
1183  002b 4b0a          	push	#10
1184  002d ae0000        	ldw	x,#_OctetArray
1185  0030 89            	pushw	x
1186  0031 1e0b          	ldw	x,(OFST+11,sp)
1187  0033 89            	pushw	x
1188  0034 1e0b          	ldw	x,(OFST+11,sp)
1189  0036 89            	pushw	x
1190  0037 ad53          	call	_emb_itoa
1192  0039 5b08          	addw	sp,#8
1193                     ; 640   **ppBuffer = OctetArray[0];
1195  003b 1e01          	ldw	x,(OFST+1,sp)
1196  003d fe            	ldw	x,(x)
1197  003e c60000        	ld	a,_OctetArray
1198  0041 f7            	ld	(x),a
1199                     ; 641   *ppBuffer = *ppBuffer + 1;
1201  0042 1e01          	ldw	x,(OFST+1,sp)
1202  0044 9093          	ldw	y,x
1203  0046 fe            	ldw	x,(x)
1204  0047 5c            	incw	x
1205  0048 90ff          	ldw	(y),x
1206                     ; 643   **ppBuffer = OctetArray[1];
1208  004a 1e01          	ldw	x,(OFST+1,sp)
1209  004c fe            	ldw	x,(x)
1210  004d c60001        	ld	a,_OctetArray+1
1211  0050 f7            	ld	(x),a
1212                     ; 644   *ppBuffer = *ppBuffer + 1;
1214  0051 1e01          	ldw	x,(OFST+1,sp)
1215  0053 9093          	ldw	y,x
1216  0055 fe            	ldw	x,(x)
1217  0056 5c            	incw	x
1218  0057 90ff          	ldw	(y),x
1219                     ; 646   **ppBuffer = OctetArray[2];
1221  0059 1e01          	ldw	x,(OFST+1,sp)
1222  005b fe            	ldw	x,(x)
1223  005c c60002        	ld	a,_OctetArray+2
1224  005f f7            	ld	(x),a
1225                     ; 647   *ppBuffer = *ppBuffer + 1;
1227  0060 1e01          	ldw	x,(OFST+1,sp)
1228  0062 9093          	ldw	y,x
1229  0064 fe            	ldw	x,(x)
1230  0065 5c            	incw	x
1231  0066 90ff          	ldw	(y),x
1232                     ; 649   **ppBuffer = OctetArray[3];
1234  0068 1e01          	ldw	x,(OFST+1,sp)
1235  006a fe            	ldw	x,(x)
1236  006b c60003        	ld	a,_OctetArray+3
1237  006e f7            	ld	(x),a
1238                     ; 650   *ppBuffer = *ppBuffer + 1;
1240  006f 1e01          	ldw	x,(OFST+1,sp)
1241  0071 9093          	ldw	y,x
1242  0073 fe            	ldw	x,(x)
1243  0074 5c            	incw	x
1244  0075 90ff          	ldw	(y),x
1245                     ; 652   **ppBuffer = OctetArray[4];
1247  0077 1e01          	ldw	x,(OFST+1,sp)
1248  0079 fe            	ldw	x,(x)
1249  007a c60004        	ld	a,_OctetArray+4
1250  007d f7            	ld	(x),a
1251                     ; 653   *ppBuffer = *ppBuffer + 1;
1253  007e 1e01          	ldw	x,(OFST+1,sp)
1254  0080 9093          	ldw	y,x
1255  0082 fe            	ldw	x,(x)
1256  0083 5c            	incw	x
1257  0084 90ff          	ldw	(y),x
1258                     ; 655   return 5;
1260  0086 ae0005        	ldw	x,#5
1263  0089 5b02          	addw	sp,#2
1264  008b 81            	ret	
1336                     ; 659 char* emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
1336                     ; 660 {
1337                     	switch	.text
1338  008c               _emb_itoa:
1340  008c 5206          	subw	sp,#6
1341       00000006      OFST:	set	6
1344                     ; 675   for (i=0; i < 10; i++) str[i] = '0';
1346  008e 4f            	clr	a
1347  008f 6b06          	ld	(OFST+0,sp),a
1349  0091               L541:
1352  0091 5f            	clrw	x
1353  0092 97            	ld	xl,a
1354  0093 72fb0d        	addw	x,(OFST+7,sp)
1355  0096 a630          	ld	a,#48
1356  0098 f7            	ld	(x),a
1359  0099 0c06          	inc	(OFST+0,sp)
1363  009b 7b06          	ld	a,(OFST+0,sp)
1364  009d a10a          	cp	a,#10
1365  009f 25f0          	jrult	L541
1366                     ; 676   str[pad] = '\0';
1368  00a1 7b10          	ld	a,(OFST+10,sp)
1369  00a3 5f            	clrw	x
1370  00a4 97            	ld	xl,a
1371  00a5 72fb0d        	addw	x,(OFST+7,sp)
1372  00a8 7f            	clr	(x)
1373                     ; 677   if (num == 0) return str;
1375  00a9 96            	ldw	x,sp
1376  00aa 1c0009        	addw	x,#OFST+3
1377  00ad cd0000        	call	c_lzmp
1381  00b0 2775          	jreq	L61
1382                     ; 680   i = 0;
1384  00b2 0f06          	clr	(OFST+0,sp)
1387  00b4 2060          	jra	L161
1388  00b6               L551:
1389                     ; 682     rem = (uint8_t)(num % base);
1391  00b6 7b0f          	ld	a,(OFST+9,sp)
1392  00b8 b703          	ld	c_lreg+3,a
1393  00ba 3f02          	clr	c_lreg+2
1394  00bc 3f01          	clr	c_lreg+1
1395  00be 3f00          	clr	c_lreg
1396  00c0 96            	ldw	x,sp
1397  00c1 5c            	incw	x
1398  00c2 cd0000        	call	c_rtol
1401  00c5 96            	ldw	x,sp
1402  00c6 1c0009        	addw	x,#OFST+3
1403  00c9 cd0000        	call	c_ltor
1405  00cc 96            	ldw	x,sp
1406  00cd 5c            	incw	x
1407  00ce cd0000        	call	c_lumd
1409  00d1 b603          	ld	a,c_lreg+3
1410  00d3 6b05          	ld	(OFST-1,sp),a
1412                     ; 683     if(rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
1414  00d5 a10a          	cp	a,#10
1415  00d7 7b06          	ld	a,(OFST+0,sp)
1416  00d9 250d          	jrult	L561
1419  00db 0c06          	inc	(OFST+0,sp)
1421  00dd 5f            	clrw	x
1422  00de 97            	ld	xl,a
1423  00df 72fb0d        	addw	x,(OFST+7,sp)
1424  00e2 7b05          	ld	a,(OFST-1,sp)
1425  00e4 ab57          	add	a,#87
1427  00e6 200b          	jra	L761
1428  00e8               L561:
1429                     ; 684     else str[i++] = (uint8_t)(rem + '0');
1431  00e8 0c06          	inc	(OFST+0,sp)
1433  00ea 5f            	clrw	x
1434  00eb 97            	ld	xl,a
1435  00ec 72fb0d        	addw	x,(OFST+7,sp)
1436  00ef 7b05          	ld	a,(OFST-1,sp)
1437  00f1 ab30          	add	a,#48
1438  00f3               L761:
1439  00f3 f7            	ld	(x),a
1440                     ; 685     num = num/base;
1442  00f4 7b0f          	ld	a,(OFST+9,sp)
1443  00f6 b703          	ld	c_lreg+3,a
1444  00f8 3f02          	clr	c_lreg+2
1445  00fa 3f01          	clr	c_lreg+1
1446  00fc 3f00          	clr	c_lreg
1447  00fe 96            	ldw	x,sp
1448  00ff 5c            	incw	x
1449  0100 cd0000        	call	c_rtol
1452  0103 96            	ldw	x,sp
1453  0104 1c0009        	addw	x,#OFST+3
1454  0107 cd0000        	call	c_ltor
1456  010a 96            	ldw	x,sp
1457  010b 5c            	incw	x
1458  010c cd0000        	call	c_ludv
1460  010f 96            	ldw	x,sp
1461  0110 1c0009        	addw	x,#OFST+3
1462  0113 cd0000        	call	c_rtol
1464  0116               L161:
1465                     ; 681   while (num != 0) {
1467  0116 96            	ldw	x,sp
1468  0117 1c0009        	addw	x,#OFST+3
1469  011a cd0000        	call	c_lzmp
1471  011d 2697          	jrne	L551
1472                     ; 689   reverse(str, pad);
1474  011f 7b10          	ld	a,(OFST+10,sp)
1475  0121 88            	push	a
1476  0122 1e0e          	ldw	x,(OFST+8,sp)
1477  0124 ad06          	call	_reverse
1479  0126 84            	pop	a
1480                     ; 691   return str;
1483  0127               L61:
1485  0127 1e0d          	ldw	x,(OFST+7,sp)
1487  0129 5b06          	addw	sp,#6
1488  012b 81            	ret	
1551                     ; 696 void reverse(char str[], uint8_t length)
1551                     ; 697 {
1552                     	switch	.text
1553  012c               _reverse:
1555  012c 89            	pushw	x
1556  012d 5203          	subw	sp,#3
1557       00000003      OFST:	set	3
1560                     ; 702   start = 0;
1562  012f 0f02          	clr	(OFST-1,sp)
1564                     ; 703   end = (uint8_t)(length - 1);
1566  0131 7b08          	ld	a,(OFST+5,sp)
1567  0133 4a            	dec	a
1568  0134 6b03          	ld	(OFST+0,sp),a
1571  0136 2029          	jra	L322
1572  0138               L712:
1573                     ; 706     temp = str[start];
1575  0138 5f            	clrw	x
1576  0139 97            	ld	xl,a
1577  013a 72fb04        	addw	x,(OFST+1,sp)
1578  013d f6            	ld	a,(x)
1579  013e 6b01          	ld	(OFST-2,sp),a
1581                     ; 707     str[start] = str[end];
1583  0140 5f            	clrw	x
1584  0141 7b02          	ld	a,(OFST-1,sp)
1585  0143 97            	ld	xl,a
1586  0144 72fb04        	addw	x,(OFST+1,sp)
1587  0147 7b03          	ld	a,(OFST+0,sp)
1588  0149 905f          	clrw	y
1589  014b 9097          	ld	yl,a
1590  014d 72f904        	addw	y,(OFST+1,sp)
1591  0150 90f6          	ld	a,(y)
1592  0152 f7            	ld	(x),a
1593                     ; 708     str[end] = temp;
1595  0153 5f            	clrw	x
1596  0154 7b03          	ld	a,(OFST+0,sp)
1597  0156 97            	ld	xl,a
1598  0157 72fb04        	addw	x,(OFST+1,sp)
1599  015a 7b01          	ld	a,(OFST-2,sp)
1600  015c f7            	ld	(x),a
1601                     ; 709     start++;
1603  015d 0c02          	inc	(OFST-1,sp)
1605                     ; 710     end--;
1607  015f 0a03          	dec	(OFST+0,sp)
1609  0161               L322:
1610                     ; 705   while (start < end) {
1610                     ; 706     temp = str[start];
1610                     ; 707     str[start] = str[end];
1610                     ; 708     str[end] = temp;
1610                     ; 709     start++;
1610                     ; 710     end--;
1612  0161 7b02          	ld	a,(OFST-1,sp)
1613  0163 1103          	cp	a,(OFST+0,sp)
1614  0165 25d1          	jrult	L712
1615                     ; 712 }
1618  0167 5b05          	addw	sp,#5
1619  0169 81            	ret	
1680                     ; 715 uint8_t three_alpha_to_uint(uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
1680                     ; 716 {
1681                     	switch	.text
1682  016a               _three_alpha_to_uint:
1684  016a 89            	pushw	x
1685  016b 89            	pushw	x
1686       00000002      OFST:	set	2
1689                     ; 724   value = (uint8_t)((alpha1 - '0') *100);
1691  016c 9e            	ld	a,xh
1692  016d 97            	ld	xl,a
1693  016e a664          	ld	a,#100
1694  0170 42            	mul	x,a
1695  0171 9f            	ld	a,xl
1696  0172 a0c0          	sub	a,#192
1697  0174 6b02          	ld	(OFST+0,sp),a
1699                     ; 725   digit = (uint8_t)((alpha2 - '0') * 10);
1701  0176 7b04          	ld	a,(OFST+2,sp)
1702  0178 97            	ld	xl,a
1703  0179 a60a          	ld	a,#10
1704  017b 42            	mul	x,a
1705  017c 9f            	ld	a,xl
1706  017d a0e0          	sub	a,#224
1708                     ; 726   value = (uint8_t)(value + digit);
1710  017f 1b02          	add	a,(OFST+0,sp)
1711  0181 6b02          	ld	(OFST+0,sp),a
1713                     ; 727   digit = (uint8_t)(alpha3 - '0');
1715  0183 7b07          	ld	a,(OFST+5,sp)
1716  0185 a030          	sub	a,#48
1717  0187 6b01          	ld	(OFST-1,sp),a
1719                     ; 728   value = (uint8_t)(value + digit);
1721  0189 1b02          	add	a,(OFST+0,sp)
1723                     ; 730   if(value >= 255) value = 0;
1725  018b a1ff          	cp	a,#255
1726  018d 2501          	jrult	L352
1729  018f 4f            	clr	a
1731  0190               L352:
1732                     ; 732   return value;
1736  0190 5b04          	addw	sp,#4
1737  0192 81            	ret	
1783                     ; 736 uint8_t two_alpha_to_uint(uint8_t alpha1, uint8_t alpha2)
1783                     ; 737 {
1784                     	switch	.text
1785  0193               _two_alpha_to_uint:
1787  0193 89            	pushw	x
1788  0194 88            	push	a
1789       00000001      OFST:	set	1
1792                     ; 744   if (alpha1 >= '0' && alpha1 <= '9') value = (uint8_t)((alpha1 - '0') << 4);
1794  0195 9e            	ld	a,xh
1795  0196 a130          	cp	a,#48
1796  0198 250f          	jrult	L572
1798  019a 9e            	ld	a,xh
1799  019b a13a          	cp	a,#58
1800  019d 240a          	jruge	L572
1803  019f 9e            	ld	a,xh
1804  01a0 97            	ld	xl,a
1805  01a1 a610          	ld	a,#16
1806  01a3 42            	mul	x,a
1807  01a4 9f            	ld	a,xl
1808  01a5 a000          	sub	a,#0
1810  01a7 2030          	jp	LC001
1811  01a9               L572:
1812                     ; 745   else if(alpha1 == 'a') value = 0xa0;
1814  01a9 7b02          	ld	a,(OFST+1,sp)
1815  01ab a161          	cp	a,#97
1816  01ad 2604          	jrne	L103
1819  01af a6a0          	ld	a,#160
1821  01b1 2026          	jp	LC001
1822  01b3               L103:
1823                     ; 746   else if(alpha1 == 'b') value = 0xb0;
1825  01b3 a162          	cp	a,#98
1826  01b5 2604          	jrne	L503
1829  01b7 a6b0          	ld	a,#176
1831  01b9 201e          	jp	LC001
1832  01bb               L503:
1833                     ; 747   else if(alpha1 == 'c') value = 0xc0;
1835  01bb a163          	cp	a,#99
1836  01bd 2604          	jrne	L113
1839  01bf a6c0          	ld	a,#192
1841  01c1 2016          	jp	LC001
1842  01c3               L113:
1843                     ; 748   else if(alpha1 == 'd') value = 0xd0;
1845  01c3 a164          	cp	a,#100
1846  01c5 2604          	jrne	L513
1849  01c7 a6d0          	ld	a,#208
1851  01c9 200e          	jp	LC001
1852  01cb               L513:
1853                     ; 749   else if(alpha1 == 'e') value = 0xe0;
1855  01cb a165          	cp	a,#101
1856  01cd 2604          	jrne	L123
1859  01cf a6e0          	ld	a,#224
1861  01d1 2006          	jp	LC001
1862  01d3               L123:
1863                     ; 750   else if(alpha1 == 'f') value = 0xf0;
1865  01d3 a166          	cp	a,#102
1866  01d5 2606          	jrne	L523
1869  01d7 a6f0          	ld	a,#240
1870  01d9               LC001:
1871  01d9 6b01          	ld	(OFST+0,sp),a
1874  01db 2002          	jra	L772
1875  01dd               L523:
1876                     ; 751   else value = 0; // If an invalid entry is made convert it to 0
1878  01dd 0f01          	clr	(OFST+0,sp)
1880  01df               L772:
1881                     ; 753   if (alpha2 >= '0' && alpha2 <= '9') value = (uint8_t)(value + alpha2 - '0');
1883  01df 7b03          	ld	a,(OFST+2,sp)
1884  01e1 a130          	cp	a,#48
1885  01e3 250c          	jrult	L133
1887  01e5 a13a          	cp	a,#58
1888  01e7 2408          	jruge	L133
1891  01e9 7b01          	ld	a,(OFST+0,sp)
1892  01eb 1b03          	add	a,(OFST+2,sp)
1893  01ed a030          	sub	a,#48
1895  01ef 203d          	jp	L333
1896  01f1               L133:
1897                     ; 754   else if(alpha2 == 'a') value = (uint8_t)(value + 0x0a);
1899  01f1 a161          	cp	a,#97
1900  01f3 2606          	jrne	L533
1903  01f5 7b01          	ld	a,(OFST+0,sp)
1904  01f7 ab0a          	add	a,#10
1906  01f9 2033          	jp	L333
1907  01fb               L533:
1908                     ; 755   else if(alpha2 == 'b') value = (uint8_t)(value + 0x0b);
1910  01fb a162          	cp	a,#98
1911  01fd 2606          	jrne	L143
1914  01ff 7b01          	ld	a,(OFST+0,sp)
1915  0201 ab0b          	add	a,#11
1917  0203 2029          	jp	L333
1918  0205               L143:
1919                     ; 756   else if(alpha2 == 'c') value = (uint8_t)(value + 0x0c);
1921  0205 a163          	cp	a,#99
1922  0207 2606          	jrne	L543
1925  0209 7b01          	ld	a,(OFST+0,sp)
1926  020b ab0c          	add	a,#12
1928  020d 201f          	jp	L333
1929  020f               L543:
1930                     ; 757   else if(alpha2 == 'd') value = (uint8_t)(value + 0x0d);
1932  020f a164          	cp	a,#100
1933  0211 2606          	jrne	L153
1936  0213 7b01          	ld	a,(OFST+0,sp)
1937  0215 ab0d          	add	a,#13
1939  0217 2015          	jp	L333
1940  0219               L153:
1941                     ; 758   else if(alpha2 == 'e') value = (uint8_t)(value + 0x0e);
1943  0219 a165          	cp	a,#101
1944  021b 2606          	jrne	L553
1947  021d 7b01          	ld	a,(OFST+0,sp)
1948  021f ab0e          	add	a,#14
1950  0221 200b          	jp	L333
1951  0223               L553:
1952                     ; 759   else if(alpha2 == 'f') value = (uint8_t)(value + 0x0f);
1954  0223 a166          	cp	a,#102
1955  0225 2606          	jrne	L163
1958  0227 7b01          	ld	a,(OFST+0,sp)
1959  0229 ab0f          	add	a,#15
1962  022b 2001          	jra	L333
1963  022d               L163:
1964                     ; 760   else value = 0; // If an invalid entry is made convert it to 0
1966  022d 4f            	clr	a
1968  022e               L333:
1969                     ; 762   return value;
1973  022e 5b03          	addw	sp,#3
1974  0230 81            	ret	
2025                     ; 766 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint32_t nDataLen)
2025                     ; 767 {
2026                     	switch	.text
2027  0231               L7_CopyHttpHeader:
2029  0231 89            	pushw	x
2030  0232 89            	pushw	x
2031       00000002      OFST:	set	2
2034                     ; 770   nBytes = 0;
2036  0233 5f            	clrw	x
2037  0234 1f01          	ldw	(OFST-1,sp),x
2039                     ; 772   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
2041  0236 ae4281        	ldw	x,#L704
2042  0239 89            	pushw	x
2043  023a 96            	ldw	x,sp
2044  023b 1c0005        	addw	x,#OFST+3
2045  023e cd0000        	call	L3_CopyStringP
2047  0241 5b02          	addw	sp,#2
2048  0243 72fb01        	addw	x,(OFST-1,sp)
2049  0246 1f01          	ldw	(OFST-1,sp),x
2051                     ; 773   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2053  0248 ae427e        	ldw	x,#L114
2054  024b 89            	pushw	x
2055  024c 96            	ldw	x,sp
2056  024d 1c0005        	addw	x,#OFST+3
2057  0250 cd0000        	call	L3_CopyStringP
2059  0253 5b02          	addw	sp,#2
2060  0255 72fb01        	addw	x,(OFST-1,sp)
2061  0258 1f01          	ldw	(OFST-1,sp),x
2063                     ; 775   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
2065  025a ae426e        	ldw	x,#L314
2066  025d 89            	pushw	x
2067  025e 96            	ldw	x,sp
2068  025f 1c0005        	addw	x,#OFST+3
2069  0262 cd0000        	call	L3_CopyStringP
2071  0265 5b02          	addw	sp,#2
2072  0267 72fb01        	addw	x,(OFST-1,sp)
2073  026a 1f01          	ldw	(OFST-1,sp),x
2075                     ; 776   nBytes += CopyValue(&pBuffer, nDataLen);
2077  026c 1e09          	ldw	x,(OFST+7,sp)
2078  026e 89            	pushw	x
2079  026f 1e09          	ldw	x,(OFST+7,sp)
2080  0271 89            	pushw	x
2081  0272 96            	ldw	x,sp
2082  0273 1c0007        	addw	x,#OFST+5
2083  0276 cd0028        	call	L5_CopyValue
2085  0279 5b04          	addw	sp,#4
2086  027b 72fb01        	addw	x,(OFST-1,sp)
2087  027e 1f01          	ldw	(OFST-1,sp),x
2089                     ; 777   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2091  0280 ae427e        	ldw	x,#L114
2092  0283 89            	pushw	x
2093  0284 96            	ldw	x,sp
2094  0285 1c0005        	addw	x,#OFST+3
2095  0288 cd0000        	call	L3_CopyStringP
2097  028b 5b02          	addw	sp,#2
2098  028d 72fb01        	addw	x,(OFST-1,sp)
2099  0290 1f01          	ldw	(OFST-1,sp),x
2101                     ; 779   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type:text/html\r\n"));
2103  0292 ae4255        	ldw	x,#L514
2104  0295 89            	pushw	x
2105  0296 96            	ldw	x,sp
2106  0297 1c0005        	addw	x,#OFST+3
2107  029a cd0000        	call	L3_CopyStringP
2109  029d 5b02          	addw	sp,#2
2110  029f 72fb01        	addw	x,(OFST-1,sp)
2111  02a2 1f01          	ldw	(OFST-1,sp),x
2113                     ; 780   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
2115  02a4 ae4242        	ldw	x,#L714
2116  02a7 89            	pushw	x
2117  02a8 96            	ldw	x,sp
2118  02a9 1c0005        	addw	x,#OFST+3
2119  02ac cd0000        	call	L3_CopyStringP
2121  02af 5b02          	addw	sp,#2
2122  02b1 72fb01        	addw	x,(OFST-1,sp)
2123  02b4 1f01          	ldw	(OFST-1,sp),x
2125                     ; 781   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2127  02b6 ae427e        	ldw	x,#L114
2128  02b9 89            	pushw	x
2129  02ba 96            	ldw	x,sp
2130  02bb 1c0005        	addw	x,#OFST+3
2131  02be cd0000        	call	L3_CopyStringP
2133  02c1 5b02          	addw	sp,#2
2134  02c3 72fb01        	addw	x,(OFST-1,sp)
2136                     ; 783   return nBytes;
2140  02c6 5b04          	addw	sp,#4
2141  02c8 81            	ret	
2280                     	switch	.const
2281  4140               L421:
2282  4140 046d          	dc.w	L124
2283  4142 047b          	dc.w	L324
2284  4144 0489          	dc.w	L524
2285  4146 0496          	dc.w	L724
2286  4148 04a3          	dc.w	L134
2287  414a 04b0          	dc.w	L334
2288  414c 04bd          	dc.w	L534
2289  414e 04ca          	dc.w	L734
2290  4150 04d7          	dc.w	L144
2291  4152 04e4          	dc.w	L344
2292  4154 04f1          	dc.w	L544
2293  4156 04fe          	dc.w	L744
2294  4158               L422:
2295  4158 063d          	dc.w	L354
2296  415a 064f          	dc.w	L554
2297  415c 0661          	dc.w	L754
2298  415e 0673          	dc.w	L164
2299  4160 0685          	dc.w	L364
2300  4162 0697          	dc.w	L564
2301  4164 06a9          	dc.w	L764
2302  4166 06bb          	dc.w	L174
2303  4168 06cd          	dc.w	L374
2304  416a 06df          	dc.w	L574
2305  416c 06f1          	dc.w	L774
2306  416e 0703          	dc.w	L105
2307  4170 0715          	dc.w	L305
2308  4172 0727          	dc.w	L505
2309  4174 0739          	dc.w	L705
2310  4176 074b          	dc.w	L115
2311  4178 075c          	dc.w	L315
2312  417a 076d          	dc.w	L515
2313  417c 077e          	dc.w	L715
2314  417e 078f          	dc.w	L125
2315  4180 07a0          	dc.w	L325
2316  4182 07b1          	dc.w	L525
2317                     ; 787 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
2317                     ; 788 {
2318                     	switch	.text
2319  02c9               L11_CopyHttpData:
2321  02c9 89            	pushw	x
2322  02ca 5207          	subw	sp,#7
2323       00000007      OFST:	set	7
2326                     ; 804   nBytes = 0;
2328  02cc 5f            	clrw	x
2329  02cd 1f05          	ldw	(OFST-2,sp),x
2331                     ; 840   if(nMaxBytes > 400) nMaxBytes = 400; // limit just in case
2333  02cf 1e10          	ldw	x,(OFST+9,sp)
2334  02d1 a30191        	cpw	x,#401
2335  02d4 2403cc0af8    	jrult	L306
2338  02d9 ae0190        	ldw	x,#400
2339  02dc 1f10          	ldw	(OFST+9,sp),x
2340  02de cc0af8        	jra	L306
2341  02e1               L106:
2342                     ; 863     if (*pDataLeft > 0) {
2344  02e1 1e0e          	ldw	x,(OFST+7,sp)
2345  02e3 e601          	ld	a,(1,x)
2346  02e5 fa            	or	a,(x)
2347  02e6 2603cc0b01    	jreq	L506
2348                     ; 867       memcpy(&nByte, *ppData, 1);
2350  02eb 96            	ldw	x,sp
2351  02ec 5c            	incw	x
2352  02ed bf00          	ldw	c_x,x
2353  02ef 160c          	ldw	y,(OFST+5,sp)
2354  02f1 90fe          	ldw	y,(y)
2355  02f3 90bf00        	ldw	c_y,y
2356  02f6 ae0001        	ldw	x,#1
2357  02f9               L25:
2358  02f9 5a            	decw	x
2359  02fa 92d600        	ld	a,([c_y.w],x)
2360  02fd 92d700        	ld	([c_x.w],x),a
2361  0300 5d            	tnzw	x
2362  0301 26f6          	jrne	L25
2363                     ; 893       if (nByte == '%') {
2365  0303 7b01          	ld	a,(OFST-6,sp)
2366  0305 a125          	cp	a,#37
2367  0307 2703cc0adb    	jrne	L116
2368                     ; 894         *ppData = *ppData + 1;
2370  030c 1e0c          	ldw	x,(OFST+5,sp)
2371  030e 9093          	ldw	y,x
2372  0310 fe            	ldw	x,(x)
2373  0311 5c            	incw	x
2374  0312 90ff          	ldw	(y),x
2375                     ; 895         *pDataLeft = *pDataLeft - 1;
2377  0314 1e0e          	ldw	x,(OFST+7,sp)
2378  0316 9093          	ldw	y,x
2379  0318 fe            	ldw	x,(x)
2380  0319 5a            	decw	x
2381  031a 90ff          	ldw	(y),x
2382                     ; 900         memcpy(&nParsedMode, *ppData, 1);
2384  031c 96            	ldw	x,sp
2385  031d 1c0003        	addw	x,#OFST-4
2386  0320 bf00          	ldw	c_x,x
2387  0322 160c          	ldw	y,(OFST+5,sp)
2388  0324 90fe          	ldw	y,(y)
2389  0326 90bf00        	ldw	c_y,y
2390  0329 ae0001        	ldw	x,#1
2391  032c               L45:
2392  032c 5a            	decw	x
2393  032d 92d600        	ld	a,([c_y.w],x)
2394  0330 92d700        	ld	([c_x.w],x),a
2395  0333 5d            	tnzw	x
2396  0334 26f6          	jrne	L45
2397                     ; 901         *ppData = *ppData + 1;
2399  0336 1e0c          	ldw	x,(OFST+5,sp)
2400  0338 9093          	ldw	y,x
2401  033a fe            	ldw	x,(x)
2402  033b 5c            	incw	x
2403  033c 90ff          	ldw	(y),x
2404                     ; 902         *pDataLeft = *pDataLeft - 1;
2406  033e 1e0e          	ldw	x,(OFST+7,sp)
2407  0340 9093          	ldw	y,x
2408  0342 fe            	ldw	x,(x)
2409  0343 5a            	decw	x
2410  0344 90ff          	ldw	(y),x
2411                     ; 906         memcpy(&temp, *ppData, 1);
2413  0346 96            	ldw	x,sp
2414  0347 1c0002        	addw	x,#OFST-5
2415  034a bf00          	ldw	c_x,x
2416  034c 160c          	ldw	y,(OFST+5,sp)
2417  034e 90fe          	ldw	y,(y)
2418  0350 90bf00        	ldw	c_y,y
2419  0353 ae0001        	ldw	x,#1
2420  0356               L65:
2421  0356 5a            	decw	x
2422  0357 92d600        	ld	a,([c_y.w],x)
2423  035a 92d700        	ld	([c_x.w],x),a
2424  035d 5d            	tnzw	x
2425  035e 26f6          	jrne	L65
2426                     ; 907 	nParsedNum = (uint8_t)((temp - '0') * 10);
2428  0360 7b02          	ld	a,(OFST-5,sp)
2429  0362 97            	ld	xl,a
2430  0363 a60a          	ld	a,#10
2431  0365 42            	mul	x,a
2432  0366 9f            	ld	a,xl
2433  0367 a0e0          	sub	a,#224
2434  0369 6b04          	ld	(OFST-3,sp),a
2436                     ; 908         *ppData = *ppData + 1;
2438  036b 1e0c          	ldw	x,(OFST+5,sp)
2439  036d 9093          	ldw	y,x
2440  036f fe            	ldw	x,(x)
2441  0370 5c            	incw	x
2442  0371 90ff          	ldw	(y),x
2443                     ; 909         *pDataLeft = *pDataLeft - 1;
2445  0373 1e0e          	ldw	x,(OFST+7,sp)
2446  0375 9093          	ldw	y,x
2447  0377 fe            	ldw	x,(x)
2448  0378 5a            	decw	x
2449  0379 90ff          	ldw	(y),x
2450                     ; 913         memcpy(&temp, *ppData, 1);
2452  037b 96            	ldw	x,sp
2453  037c 1c0002        	addw	x,#OFST-5
2454  037f bf00          	ldw	c_x,x
2455  0381 160c          	ldw	y,(OFST+5,sp)
2456  0383 90fe          	ldw	y,(y)
2457  0385 90bf00        	ldw	c_y,y
2458  0388 ae0001        	ldw	x,#1
2459  038b               L06:
2460  038b 5a            	decw	x
2461  038c 92d600        	ld	a,([c_y.w],x)
2462  038f 92d700        	ld	([c_x.w],x),a
2463  0392 5d            	tnzw	x
2464  0393 26f6          	jrne	L06
2465                     ; 914 	nParsedNum = (uint8_t)(nParsedNum + temp - '0');
2467  0395 7b04          	ld	a,(OFST-3,sp)
2468  0397 1b02          	add	a,(OFST-5,sp)
2469  0399 a030          	sub	a,#48
2470  039b 6b04          	ld	(OFST-3,sp),a
2472                     ; 915         *ppData = *ppData + 1;
2474  039d 1e0c          	ldw	x,(OFST+5,sp)
2475  039f 9093          	ldw	y,x
2476  03a1 fe            	ldw	x,(x)
2477  03a2 5c            	incw	x
2478  03a3 90ff          	ldw	(y),x
2479                     ; 916         *pDataLeft = *pDataLeft - 1;
2481  03a5 1e0e          	ldw	x,(OFST+7,sp)
2482  03a7 9093          	ldw	y,x
2483  03a9 fe            	ldw	x,(x)
2484  03aa 5a            	decw	x
2485  03ab 90ff          	ldw	(y),x
2486                     ; 926         if (nParsedMode == 'i') {
2488  03ad 7b03          	ld	a,(OFST-4,sp)
2489  03af a169          	cp	a,#105
2490  03b1 2614          	jrne	L316
2491                     ; 930 	  *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
2493  03b3 7b04          	ld	a,(OFST-3,sp)
2494  03b5 cd1330        	call	_GpioGetPin
2496  03b8 1e08          	ldw	x,(OFST+1,sp)
2497  03ba ab30          	add	a,#48
2498  03bc f7            	ld	(x),a
2499                     ; 931           pBuffer++;
2501  03bd 5c            	incw	x
2502  03be 1f08          	ldw	(OFST+1,sp),x
2503                     ; 932           nBytes++;
2505  03c0 1e05          	ldw	x,(OFST-2,sp)
2506  03c2 5c            	incw	x
2507  03c3 1f05          	ldw	(OFST-2,sp),x
2510  03c5 204e          	jra	L516
2511  03c7               L316:
2512                     ; 956         else if (nParsedMode == 'o') {
2514  03c7 a16f          	cp	a,#111
2515  03c9 2624          	jrne	L716
2516                     ; 959           if((uint8_t)(GpioGetPin(nParsedNum) == 1)) { // Insert 'checked'
2518  03cb 7b04          	ld	a,(OFST-3,sp)
2519  03cd cd1330        	call	_GpioGetPin
2521  03d0 4a            	dec	a
2522  03d1 2642          	jrne	L516
2523                     ; 960             for(i=0; i<7; i++) {
2525  03d3 6b07          	ld	(OFST+0,sp),a
2527  03d5               L326:
2528                     ; 961               *pBuffer = checked[i];
2530  03d5 5f            	clrw	x
2531  03d6 97            	ld	xl,a
2532  03d7 d60000        	ld	a,(L31_checked,x)
2533  03da 1e08          	ldw	x,(OFST+1,sp)
2534  03dc f7            	ld	(x),a
2535                     ; 962               pBuffer++;
2537  03dd 5c            	incw	x
2538  03de 1f08          	ldw	(OFST+1,sp),x
2539                     ; 963               nBytes++;
2541  03e0 1e05          	ldw	x,(OFST-2,sp)
2542  03e2 5c            	incw	x
2543  03e3 1f05          	ldw	(OFST-2,sp),x
2545                     ; 960             for(i=0; i<7; i++) {
2547  03e5 0c07          	inc	(OFST+0,sp)
2551  03e7 7b07          	ld	a,(OFST+0,sp)
2552  03e9 a107          	cp	a,#7
2553  03eb 25e8          	jrult	L326
2555  03ed 2026          	jra	L516
2556  03ef               L716:
2557                     ; 970         else if (nParsedMode == 'p') {
2559  03ef a170          	cp	a,#112
2560  03f1 2622          	jrne	L516
2561                     ; 973           if((uint8_t)(GpioGetPin(nParsedNum) == 0)) { // Insert 'checked'
2563  03f3 7b04          	ld	a,(OFST-3,sp)
2564  03f5 cd1330        	call	_GpioGetPin
2566  03f8 4d            	tnz	a
2567  03f9 261a          	jrne	L516
2568                     ; 974             for(i=0; i<7; i++) {
2570  03fb 6b07          	ld	(OFST+0,sp),a
2572  03fd               L146:
2573                     ; 975               *pBuffer = checked[i];
2575  03fd 5f            	clrw	x
2576  03fe 97            	ld	xl,a
2577  03ff d60000        	ld	a,(L31_checked,x)
2578  0402 1e08          	ldw	x,(OFST+1,sp)
2579  0404 f7            	ld	(x),a
2580                     ; 976               pBuffer++;
2582  0405 5c            	incw	x
2583  0406 1f08          	ldw	(OFST+1,sp),x
2584                     ; 977               nBytes++;
2586  0408 1e05          	ldw	x,(OFST-2,sp)
2587  040a 5c            	incw	x
2588  040b 1f05          	ldw	(OFST-2,sp),x
2590                     ; 974             for(i=0; i<7; i++) {
2592  040d 0c07          	inc	(OFST+0,sp)
2596  040f 7b07          	ld	a,(OFST+0,sp)
2597  0411 a107          	cp	a,#7
2598  0413 25e8          	jrult	L146
2600  0415               L516:
2601                     ; 984         if (nParsedMode == 'a') {
2603  0415 7b03          	ld	a,(OFST-4,sp)
2604  0417 a161          	cp	a,#97
2605  0419 263b          	jrne	L156
2606                     ; 986 	  for(i=0; i<20; i++) {
2608  041b 4f            	clr	a
2609  041c 6b07          	ld	(OFST+0,sp),a
2611  041e               L356:
2612                     ; 987 	    if(ex_stored_devicename[i] != ' ') { // Don't write spaces out - confuses the
2614  041e 5f            	clrw	x
2615  041f 97            	ld	xl,a
2616  0420 d60000        	ld	a,(_ex_stored_devicename,x)
2617  0423 a120          	cp	a,#32
2618  0425 2712          	jreq	L166
2619                     ; 989               *pBuffer = (uint8_t)(ex_stored_devicename[i]);
2621  0427 7b07          	ld	a,(OFST+0,sp)
2622  0429 5f            	clrw	x
2623  042a 97            	ld	xl,a
2624  042b d60000        	ld	a,(_ex_stored_devicename,x)
2625  042e 1e08          	ldw	x,(OFST+1,sp)
2626  0430 f7            	ld	(x),a
2627                     ; 990               pBuffer++;
2629  0431 5c            	incw	x
2630  0432 1f08          	ldw	(OFST+1,sp),x
2631                     ; 991               nBytes++;
2633  0434 1e05          	ldw	x,(OFST-2,sp)
2634  0436 5c            	incw	x
2635  0437 1f05          	ldw	(OFST-2,sp),x
2637  0439               L166:
2638                     ; 986 	  for(i=0; i<20; i++) {
2640  0439 0c07          	inc	(OFST+0,sp)
2644  043b 7b07          	ld	a,(OFST+0,sp)
2645  043d a114          	cp	a,#20
2646  043f 25dd          	jrult	L356
2647                     ; 1006           *ppData = *ppData + 20;
2649  0441 1e0c          	ldw	x,(OFST+5,sp)
2650  0443 9093          	ldw	y,x
2651  0445 fe            	ldw	x,(x)
2652  0446 1c0014        	addw	x,#20
2653  0449 90ff          	ldw	(y),x
2654                     ; 1007           *pDataLeft = *pDataLeft - 20;
2656  044b 1e0e          	ldw	x,(OFST+7,sp)
2657  044d 9093          	ldw	y,x
2658  044f fe            	ldw	x,(x)
2659  0450 1d0014        	subw	x,#20
2661  0453 cc0832        	jp	LC011
2662  0456               L156:
2663                     ; 1010         else if (nParsedMode == 'b') {
2665  0456 a162          	cp	a,#98
2666  0458 2703cc0556    	jrne	L566
2667                     ; 1015 	  advanceptrs = 0;
2669                     ; 1017           switch (nParsedNum)
2671  045d 7b04          	ld	a,(OFST-3,sp)
2673                     ; 1032 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2674  045f a10c          	cp	a,#12
2675  0461 2503cc0518    	jruge	L154
2676  0466 5f            	clrw	x
2677  0467 97            	ld	xl,a
2678  0468 58            	sllw	x
2679  0469 de4140        	ldw	x,(L421,x)
2680  046c fc            	jp	(x)
2681  046d               L124:
2682                     ; 1020 	    case 0:  emb_itoa(ex_stored_hostaddr4, OctetArray, 10, 3); advanceptrs = 1; break;
2684  046d 4b03          	push	#3
2685  046f 4b0a          	push	#10
2686  0471 ae0000        	ldw	x,#_OctetArray
2687  0474 89            	pushw	x
2688  0475 c60000        	ld	a,_ex_stored_hostaddr4
2693  0478 cc0509        	jp	LC003
2694  047b               L324:
2695                     ; 1021 	    case 1:  emb_itoa(ex_stored_hostaddr3, OctetArray, 10, 3); advanceptrs = 1; break;
2697  047b 4b03          	push	#3
2698  047d 4b0a          	push	#10
2699  047f ae0000        	ldw	x,#_OctetArray
2700  0482 89            	pushw	x
2701  0483 c60000        	ld	a,_ex_stored_hostaddr3
2706  0486 cc0509        	jp	LC003
2707  0489               L524:
2708                     ; 1022 	    case 2:  emb_itoa(ex_stored_hostaddr2, OctetArray, 10, 3); advanceptrs = 1; break;
2710  0489 4b03          	push	#3
2711  048b 4b0a          	push	#10
2712  048d ae0000        	ldw	x,#_OctetArray
2713  0490 89            	pushw	x
2714  0491 c60000        	ld	a,_ex_stored_hostaddr2
2719  0494 2073          	jp	LC003
2720  0496               L724:
2721                     ; 1023 	    case 3:  emb_itoa(ex_stored_hostaddr1, OctetArray, 10, 3); advanceptrs = 1; break;
2723  0496 4b03          	push	#3
2724  0498 4b0a          	push	#10
2725  049a ae0000        	ldw	x,#_OctetArray
2726  049d 89            	pushw	x
2727  049e c60000        	ld	a,_ex_stored_hostaddr1
2732  04a1 2066          	jp	LC003
2733  04a3               L134:
2734                     ; 1024 	    case 4:  emb_itoa(ex_stored_draddr4,   OctetArray, 10, 3); advanceptrs = 1; break;
2736  04a3 4b03          	push	#3
2737  04a5 4b0a          	push	#10
2738  04a7 ae0000        	ldw	x,#_OctetArray
2739  04aa 89            	pushw	x
2740  04ab c60000        	ld	a,_ex_stored_draddr4
2745  04ae 2059          	jp	LC003
2746  04b0               L334:
2747                     ; 1025 	    case 5:  emb_itoa(ex_stored_draddr3,   OctetArray, 10, 3); advanceptrs = 1; break;
2749  04b0 4b03          	push	#3
2750  04b2 4b0a          	push	#10
2751  04b4 ae0000        	ldw	x,#_OctetArray
2752  04b7 89            	pushw	x
2753  04b8 c60000        	ld	a,_ex_stored_draddr3
2758  04bb 204c          	jp	LC003
2759  04bd               L534:
2760                     ; 1026 	    case 6:  emb_itoa(ex_stored_draddr2,   OctetArray, 10, 3); advanceptrs = 1; break;
2762  04bd 4b03          	push	#3
2763  04bf 4b0a          	push	#10
2764  04c1 ae0000        	ldw	x,#_OctetArray
2765  04c4 89            	pushw	x
2766  04c5 c60000        	ld	a,_ex_stored_draddr2
2771  04c8 203f          	jp	LC003
2772  04ca               L734:
2773                     ; 1027 	    case 7:  emb_itoa(ex_stored_draddr1,   OctetArray, 10, 3); advanceptrs = 1; break;
2775  04ca 4b03          	push	#3
2776  04cc 4b0a          	push	#10
2777  04ce ae0000        	ldw	x,#_OctetArray
2778  04d1 89            	pushw	x
2779  04d2 c60000        	ld	a,_ex_stored_draddr1
2784  04d5 2032          	jp	LC003
2785  04d7               L144:
2786                     ; 1028 	    case 8:  emb_itoa(ex_stored_netmask4,  OctetArray, 10, 3); advanceptrs = 1; break;
2788  04d7 4b03          	push	#3
2789  04d9 4b0a          	push	#10
2790  04db ae0000        	ldw	x,#_OctetArray
2791  04de 89            	pushw	x
2792  04df c60000        	ld	a,_ex_stored_netmask4
2797  04e2 2025          	jp	LC003
2798  04e4               L344:
2799                     ; 1029 	    case 9:  emb_itoa(ex_stored_netmask3,  OctetArray, 10, 3); advanceptrs = 1; break;
2801  04e4 4b03          	push	#3
2802  04e6 4b0a          	push	#10
2803  04e8 ae0000        	ldw	x,#_OctetArray
2804  04eb 89            	pushw	x
2805  04ec c60000        	ld	a,_ex_stored_netmask3
2810  04ef 2018          	jp	LC003
2811  04f1               L544:
2812                     ; 1030 	    case 10: emb_itoa(ex_stored_netmask2,  OctetArray, 10, 3); advanceptrs = 1; break;
2814  04f1 4b03          	push	#3
2815  04f3 4b0a          	push	#10
2816  04f5 ae0000        	ldw	x,#_OctetArray
2817  04f8 89            	pushw	x
2818  04f9 c60000        	ld	a,_ex_stored_netmask2
2823  04fc 200b          	jp	LC003
2824  04fe               L744:
2825                     ; 1031 	    case 11: emb_itoa(ex_stored_netmask1,  OctetArray, 10, 3); advanceptrs = 1; break;
2827  04fe 4b03          	push	#3
2828  0500 4b0a          	push	#10
2829  0502 ae0000        	ldw	x,#_OctetArray
2830  0505 89            	pushw	x
2831  0506 c60000        	ld	a,_ex_stored_netmask1
2832  0509               LC003:
2833  0509 b703          	ld	c_lreg+3,a
2834  050b 3f02          	clr	c_lreg+2
2835  050d 3f01          	clr	c_lreg+1
2836  050f 3f00          	clr	c_lreg
2837  0511 be02          	ldw	x,c_lreg+2
2838  0513 89            	pushw	x
2839  0514 be00          	ldw	x,c_lreg
2844  0516 200a          	jra	L176
2845  0518               L154:
2846                     ; 1032 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2848  0518 4b03          	push	#3
2849  051a 4b0a          	push	#10
2850  051c ae0000        	ldw	x,#_OctetArray
2851  051f 89            	pushw	x
2852  0520 5f            	clrw	x
2853  0521 89            	pushw	x
2859  0522               L176:
2860  0522 89            	pushw	x
2861  0523 cd008c        	call	_emb_itoa
2862  0526 5b08          	addw	sp,#8
2875  0528 a601          	ld	a,#1
2876  052a 6b07          	ld	(OFST+0,sp),a
2878                     ; 1035 	  if(advanceptrs == 1) { // Copy OctetArray and advance pointers if one of the above
2880  052c 4a            	dec	a
2881  052d 2703cc0af8    	jrne	L306
2882                     ; 1037             *pBuffer = (uint8_t)OctetArray[0];
2884  0532 1e08          	ldw	x,(OFST+1,sp)
2885  0534 c60000        	ld	a,_OctetArray
2886  0537 f7            	ld	(x),a
2887                     ; 1038             pBuffer++;
2889  0538 5c            	incw	x
2890  0539 1f08          	ldw	(OFST+1,sp),x
2891                     ; 1039             nBytes++;
2893  053b 1e05          	ldw	x,(OFST-2,sp)
2894  053d 5c            	incw	x
2895  053e 1f05          	ldw	(OFST-2,sp),x
2897                     ; 1041             *pBuffer = (uint8_t)OctetArray[1];
2899  0540 1e08          	ldw	x,(OFST+1,sp)
2900  0542 c60001        	ld	a,_OctetArray+1
2901  0545 f7            	ld	(x),a
2902                     ; 1042             pBuffer++;
2904  0546 5c            	incw	x
2905  0547 1f08          	ldw	(OFST+1,sp),x
2906                     ; 1043             nBytes++;
2908  0549 1e05          	ldw	x,(OFST-2,sp)
2909  054b 5c            	incw	x
2910  054c 1f05          	ldw	(OFST-2,sp),x
2912                     ; 1045             *pBuffer = (uint8_t)OctetArray[2];
2914  054e c60002        	ld	a,_OctetArray+2
2915  0551 1e08          	ldw	x,(OFST+1,sp)
2916                     ; 1046             pBuffer++;
2917                     ; 1047             nBytes++;
2918  0553 cc0622        	jp	LC010
2919  0556               L566:
2920                     ; 1051         else if (nParsedMode == 'c') {
2922  0556 a163          	cp	a,#99
2923  0558 2637          	jrne	L776
2924                     ; 1057           emb_itoa(ex_stored_port, OctetArray, 10, 5);
2926  055a 4b05          	push	#5
2927  055c 4b0a          	push	#10
2928  055e ae0000        	ldw	x,#_OctetArray
2929  0561 89            	pushw	x
2930  0562 ce0000        	ldw	x,_ex_stored_port
2931  0565 cd0000        	call	c_uitolx
2933  0568 be02          	ldw	x,c_lreg+2
2934  056a 89            	pushw	x
2935  056b be00          	ldw	x,c_lreg
2936  056d 89            	pushw	x
2937  056e cd008c        	call	_emb_itoa
2939  0571 5b08          	addw	sp,#8
2940                     ; 1059 	  for(i=0; i<5; i++) {
2942  0573 4f            	clr	a
2943  0574 6b07          	ld	(OFST+0,sp),a
2945  0576               L107:
2946                     ; 1060             *pBuffer = (uint8_t)OctetArray[i];
2948  0576 5f            	clrw	x
2949  0577 97            	ld	xl,a
2950  0578 d60000        	ld	a,(_OctetArray,x)
2951  057b 1e08          	ldw	x,(OFST+1,sp)
2952  057d f7            	ld	(x),a
2953                     ; 1061             pBuffer++;
2955  057e 5c            	incw	x
2956  057f 1f08          	ldw	(OFST+1,sp),x
2957                     ; 1062             nBytes++;
2959  0581 1e05          	ldw	x,(OFST-2,sp)
2960  0583 5c            	incw	x
2961  0584 1f05          	ldw	(OFST-2,sp),x
2963                     ; 1059 	  for(i=0; i<5; i++) {
2965  0586 0c07          	inc	(OFST+0,sp)
2969  0588 7b07          	ld	a,(OFST+0,sp)
2970  058a a105          	cp	a,#5
2971  058c 25e8          	jrult	L107
2973  058e cc0af8        	jra	L306
2974  0591               L776:
2975                     ; 1066         else if (nParsedMode == 'd') {
2977  0591 a164          	cp	a,#100
2978  0593 2703cc0626    	jrne	L117
2979                     ; 1071 	  if(nParsedNum == 0)      emb_itoa(uip_ethaddr1, OctetArray, 16, 2);
2981  0598 7b04          	ld	a,(OFST-3,sp)
2982  059a 260d          	jrne	L317
2985  059c 4b02          	push	#2
2986  059e 4b10          	push	#16
2987  05a0 ae0000        	ldw	x,#_OctetArray
2988  05a3 89            	pushw	x
2989  05a4 c60000        	ld	a,_uip_ethaddr1
2992  05a7 2053          	jp	LC004
2993  05a9               L317:
2994                     ; 1072 	  else if(nParsedNum == 1) emb_itoa(uip_ethaddr2, OctetArray, 16, 2);
2996  05a9 a101          	cp	a,#1
2997  05ab 260d          	jrne	L717
3000  05ad 4b02          	push	#2
3001  05af 4b10          	push	#16
3002  05b1 ae0000        	ldw	x,#_OctetArray
3003  05b4 89            	pushw	x
3004  05b5 c60000        	ld	a,_uip_ethaddr2
3007  05b8 2042          	jp	LC004
3008  05ba               L717:
3009                     ; 1073 	  else if(nParsedNum == 2) emb_itoa(uip_ethaddr3, OctetArray, 16, 2);
3011  05ba a102          	cp	a,#2
3012  05bc 260d          	jrne	L327
3015  05be 4b02          	push	#2
3016  05c0 4b10          	push	#16
3017  05c2 ae0000        	ldw	x,#_OctetArray
3018  05c5 89            	pushw	x
3019  05c6 c60000        	ld	a,_uip_ethaddr3
3022  05c9 2031          	jp	LC004
3023  05cb               L327:
3024                     ; 1074 	  else if(nParsedNum == 3) emb_itoa(uip_ethaddr4, OctetArray, 16, 2);
3026  05cb a103          	cp	a,#3
3027  05cd 260d          	jrne	L727
3030  05cf 4b02          	push	#2
3031  05d1 4b10          	push	#16
3032  05d3 ae0000        	ldw	x,#_OctetArray
3033  05d6 89            	pushw	x
3034  05d7 c60000        	ld	a,_uip_ethaddr4
3037  05da 2020          	jp	LC004
3038  05dc               L727:
3039                     ; 1075 	  else if(nParsedNum == 4) emb_itoa(uip_ethaddr5, OctetArray, 16, 2);
3041  05dc a104          	cp	a,#4
3042  05de 260d          	jrne	L337
3045  05e0 4b02          	push	#2
3046  05e2 4b10          	push	#16
3047  05e4 ae0000        	ldw	x,#_OctetArray
3048  05e7 89            	pushw	x
3049  05e8 c60000        	ld	a,_uip_ethaddr5
3052  05eb 200f          	jp	LC004
3053  05ed               L337:
3054                     ; 1076 	  else if(nParsedNum == 5) emb_itoa(uip_ethaddr6, OctetArray, 16, 2);
3056  05ed a105          	cp	a,#5
3057  05ef 261e          	jrne	L517
3060  05f1 4b02          	push	#2
3061  05f3 4b10          	push	#16
3062  05f5 ae0000        	ldw	x,#_OctetArray
3063  05f8 89            	pushw	x
3064  05f9 c60000        	ld	a,_uip_ethaddr6
3066  05fc               LC004:
3067  05fc b703          	ld	c_lreg+3,a
3068  05fe 3f02          	clr	c_lreg+2
3069  0600 3f01          	clr	c_lreg+1
3070  0602 3f00          	clr	c_lreg
3071  0604 be02          	ldw	x,c_lreg+2
3072  0606 89            	pushw	x
3073  0607 be00          	ldw	x,c_lreg
3074  0609 89            	pushw	x
3075  060a cd008c        	call	_emb_itoa
3076  060d 5b08          	addw	sp,#8
3077  060f               L517:
3078                     ; 1078           *pBuffer = OctetArray[0];
3080  060f 1e08          	ldw	x,(OFST+1,sp)
3081  0611 c60000        	ld	a,_OctetArray
3082  0614 f7            	ld	(x),a
3083                     ; 1079           pBuffer++;
3085  0615 5c            	incw	x
3086  0616 1f08          	ldw	(OFST+1,sp),x
3087                     ; 1080           nBytes++;
3089  0618 1e05          	ldw	x,(OFST-2,sp)
3090  061a 5c            	incw	x
3091  061b 1f05          	ldw	(OFST-2,sp),x
3093                     ; 1082           *pBuffer = OctetArray[1];
3095  061d c60001        	ld	a,_OctetArray+1
3096  0620 1e08          	ldw	x,(OFST+1,sp)
3097  0622               LC010:
3098  0622 f7            	ld	(x),a
3099                     ; 1083           pBuffer++;
3100                     ; 1084           nBytes++;
3102  0623 cc0af0        	jp	LC009
3103  0626               L117:
3104                     ; 1089         else if (nParsedMode == 'e') {
3106  0626 a165          	cp	a,#101
3107  0628 2703cc0801    	jrne	L347
3108                     ; 1116           switch (nParsedNum)
3110  062d 7b04          	ld	a,(OFST-3,sp)
3112                     ; 1141 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3113  062f a116          	cp	a,#22
3114  0631 2503cc07c2    	jruge	L725
3115  0636 5f            	clrw	x
3116  0637 97            	ld	xl,a
3117  0638 58            	sllw	x
3118  0639 de4158        	ldw	x,(L422,x)
3119  063c fc            	jp	(x)
3120  063d               L354:
3121                     ; 1119 	    case 0:  emb_itoa(uip_stat.ip.drop,      OctetArray, 10, 10); break;
3123  063d 4b0a          	push	#10
3124  063f 4b0a          	push	#10
3125  0641 ae0000        	ldw	x,#_OctetArray
3126  0644 89            	pushw	x
3127  0645 ce0002        	ldw	x,_uip_stat+2
3128  0648 89            	pushw	x
3129  0649 ce0000        	ldw	x,_uip_stat
3133  064c cc07cc        	jra	L747
3134  064f               L554:
3135                     ; 1120 	    case 1:  emb_itoa(uip_stat.ip.recv,      OctetArray, 10, 10); break;
3137  064f 4b0a          	push	#10
3138  0651 4b0a          	push	#10
3139  0653 ae0000        	ldw	x,#_OctetArray
3140  0656 89            	pushw	x
3141  0657 ce0006        	ldw	x,_uip_stat+6
3142  065a 89            	pushw	x
3143  065b ce0004        	ldw	x,_uip_stat+4
3147  065e cc07cc        	jra	L747
3148  0661               L754:
3149                     ; 1121 	    case 2:  emb_itoa(uip_stat.ip.sent,      OctetArray, 10, 10); break;
3151  0661 4b0a          	push	#10
3152  0663 4b0a          	push	#10
3153  0665 ae0000        	ldw	x,#_OctetArray
3154  0668 89            	pushw	x
3155  0669 ce000a        	ldw	x,_uip_stat+10
3156  066c 89            	pushw	x
3157  066d ce0008        	ldw	x,_uip_stat+8
3161  0670 cc07cc        	jra	L747
3162  0673               L164:
3163                     ; 1122 	    case 3:  emb_itoa(uip_stat.ip.vhlerr,    OctetArray, 10, 10); break;
3165  0673 4b0a          	push	#10
3166  0675 4b0a          	push	#10
3167  0677 ae0000        	ldw	x,#_OctetArray
3168  067a 89            	pushw	x
3169  067b ce000e        	ldw	x,_uip_stat+14
3170  067e 89            	pushw	x
3171  067f ce000c        	ldw	x,_uip_stat+12
3175  0682 cc07cc        	jra	L747
3176  0685               L364:
3177                     ; 1123 	    case 4:  emb_itoa(uip_stat.ip.hblenerr,  OctetArray, 10, 10); break;
3179  0685 4b0a          	push	#10
3180  0687 4b0a          	push	#10
3181  0689 ae0000        	ldw	x,#_OctetArray
3182  068c 89            	pushw	x
3183  068d ce0012        	ldw	x,_uip_stat+18
3184  0690 89            	pushw	x
3185  0691 ce0010        	ldw	x,_uip_stat+16
3189  0694 cc07cc        	jra	L747
3190  0697               L564:
3191                     ; 1124 	    case 5:  emb_itoa(uip_stat.ip.lblenerr,  OctetArray, 10, 10); break;
3193  0697 4b0a          	push	#10
3194  0699 4b0a          	push	#10
3195  069b ae0000        	ldw	x,#_OctetArray
3196  069e 89            	pushw	x
3197  069f ce0016        	ldw	x,_uip_stat+22
3198  06a2 89            	pushw	x
3199  06a3 ce0014        	ldw	x,_uip_stat+20
3203  06a6 cc07cc        	jra	L747
3204  06a9               L764:
3205                     ; 1125 	    case 6:  emb_itoa(uip_stat.ip.fragerr,   OctetArray, 10, 10); break;
3207  06a9 4b0a          	push	#10
3208  06ab 4b0a          	push	#10
3209  06ad ae0000        	ldw	x,#_OctetArray
3210  06b0 89            	pushw	x
3211  06b1 ce001a        	ldw	x,_uip_stat+26
3212  06b4 89            	pushw	x
3213  06b5 ce0018        	ldw	x,_uip_stat+24
3217  06b8 cc07cc        	jra	L747
3218  06bb               L174:
3219                     ; 1126 	    case 7:  emb_itoa(uip_stat.ip.chkerr,    OctetArray, 10, 10); break;
3221  06bb 4b0a          	push	#10
3222  06bd 4b0a          	push	#10
3223  06bf ae0000        	ldw	x,#_OctetArray
3224  06c2 89            	pushw	x
3225  06c3 ce001e        	ldw	x,_uip_stat+30
3226  06c6 89            	pushw	x
3227  06c7 ce001c        	ldw	x,_uip_stat+28
3231  06ca cc07cc        	jra	L747
3232  06cd               L374:
3233                     ; 1127 	    case 8:  emb_itoa(uip_stat.ip.protoerr,  OctetArray, 10, 10); break;
3235  06cd 4b0a          	push	#10
3236  06cf 4b0a          	push	#10
3237  06d1 ae0000        	ldw	x,#_OctetArray
3238  06d4 89            	pushw	x
3239  06d5 ce0022        	ldw	x,_uip_stat+34
3240  06d8 89            	pushw	x
3241  06d9 ce0020        	ldw	x,_uip_stat+32
3245  06dc cc07cc        	jra	L747
3246  06df               L574:
3247                     ; 1128 	    case 9:  emb_itoa(uip_stat.icmp.drop,    OctetArray, 10, 10); break;
3249  06df 4b0a          	push	#10
3250  06e1 4b0a          	push	#10
3251  06e3 ae0000        	ldw	x,#_OctetArray
3252  06e6 89            	pushw	x
3253  06e7 ce0026        	ldw	x,_uip_stat+38
3254  06ea 89            	pushw	x
3255  06eb ce0024        	ldw	x,_uip_stat+36
3259  06ee cc07cc        	jra	L747
3260  06f1               L774:
3261                     ; 1129 	    case 10: emb_itoa(uip_stat.icmp.recv,    OctetArray, 10, 10); break;
3263  06f1 4b0a          	push	#10
3264  06f3 4b0a          	push	#10
3265  06f5 ae0000        	ldw	x,#_OctetArray
3266  06f8 89            	pushw	x
3267  06f9 ce002a        	ldw	x,_uip_stat+42
3268  06fc 89            	pushw	x
3269  06fd ce0028        	ldw	x,_uip_stat+40
3273  0700 cc07cc        	jra	L747
3274  0703               L105:
3275                     ; 1130 	    case 11: emb_itoa(uip_stat.icmp.sent,    OctetArray, 10, 10); break;
3277  0703 4b0a          	push	#10
3278  0705 4b0a          	push	#10
3279  0707 ae0000        	ldw	x,#_OctetArray
3280  070a 89            	pushw	x
3281  070b ce002e        	ldw	x,_uip_stat+46
3282  070e 89            	pushw	x
3283  070f ce002c        	ldw	x,_uip_stat+44
3287  0712 cc07cc        	jra	L747
3288  0715               L305:
3289                     ; 1131 	    case 12: emb_itoa(uip_stat.icmp.typeerr, OctetArray, 10, 10); break;
3291  0715 4b0a          	push	#10
3292  0717 4b0a          	push	#10
3293  0719 ae0000        	ldw	x,#_OctetArray
3294  071c 89            	pushw	x
3295  071d ce0032        	ldw	x,_uip_stat+50
3296  0720 89            	pushw	x
3297  0721 ce0030        	ldw	x,_uip_stat+48
3301  0724 cc07cc        	jra	L747
3302  0727               L505:
3303                     ; 1132 	    case 13: emb_itoa(uip_stat.tcp.drop,     OctetArray, 10, 10); break;
3305  0727 4b0a          	push	#10
3306  0729 4b0a          	push	#10
3307  072b ae0000        	ldw	x,#_OctetArray
3308  072e 89            	pushw	x
3309  072f ce0036        	ldw	x,_uip_stat+54
3310  0732 89            	pushw	x
3311  0733 ce0034        	ldw	x,_uip_stat+52
3315  0736 cc07cc        	jra	L747
3316  0739               L705:
3317                     ; 1133 	    case 14: emb_itoa(uip_stat.tcp.recv,     OctetArray, 10, 10); break;
3319  0739 4b0a          	push	#10
3320  073b 4b0a          	push	#10
3321  073d ae0000        	ldw	x,#_OctetArray
3322  0740 89            	pushw	x
3323  0741 ce003a        	ldw	x,_uip_stat+58
3324  0744 89            	pushw	x
3325  0745 ce0038        	ldw	x,_uip_stat+56
3329  0748 cc07cc        	jra	L747
3330  074b               L115:
3331                     ; 1134 	    case 15: emb_itoa(uip_stat.tcp.sent,     OctetArray, 10, 10); break;
3333  074b 4b0a          	push	#10
3334  074d 4b0a          	push	#10
3335  074f ae0000        	ldw	x,#_OctetArray
3336  0752 89            	pushw	x
3337  0753 ce003e        	ldw	x,_uip_stat+62
3338  0756 89            	pushw	x
3339  0757 ce003c        	ldw	x,_uip_stat+60
3343  075a 2070          	jra	L747
3344  075c               L315:
3345                     ; 1135 	    case 16: emb_itoa(uip_stat.tcp.chkerr,   OctetArray, 10, 10); break;
3347  075c 4b0a          	push	#10
3348  075e 4b0a          	push	#10
3349  0760 ae0000        	ldw	x,#_OctetArray
3350  0763 89            	pushw	x
3351  0764 ce0042        	ldw	x,_uip_stat+66
3352  0767 89            	pushw	x
3353  0768 ce0040        	ldw	x,_uip_stat+64
3357  076b 205f          	jra	L747
3358  076d               L515:
3359                     ; 1136 	    case 17: emb_itoa(uip_stat.tcp.ackerr,   OctetArray, 10, 10); break;
3361  076d 4b0a          	push	#10
3362  076f 4b0a          	push	#10
3363  0771 ae0000        	ldw	x,#_OctetArray
3364  0774 89            	pushw	x
3365  0775 ce0046        	ldw	x,_uip_stat+70
3366  0778 89            	pushw	x
3367  0779 ce0044        	ldw	x,_uip_stat+68
3371  077c 204e          	jra	L747
3372  077e               L715:
3373                     ; 1137 	    case 18: emb_itoa(uip_stat.tcp.rst,      OctetArray, 10, 10); break;
3375  077e 4b0a          	push	#10
3376  0780 4b0a          	push	#10
3377  0782 ae0000        	ldw	x,#_OctetArray
3378  0785 89            	pushw	x
3379  0786 ce004a        	ldw	x,_uip_stat+74
3380  0789 89            	pushw	x
3381  078a ce0048        	ldw	x,_uip_stat+72
3385  078d 203d          	jra	L747
3386  078f               L125:
3387                     ; 1138 	    case 19: emb_itoa(uip_stat.tcp.rexmit,   OctetArray, 10, 10); break;
3389  078f 4b0a          	push	#10
3390  0791 4b0a          	push	#10
3391  0793 ae0000        	ldw	x,#_OctetArray
3392  0796 89            	pushw	x
3393  0797 ce004e        	ldw	x,_uip_stat+78
3394  079a 89            	pushw	x
3395  079b ce004c        	ldw	x,_uip_stat+76
3399  079e 202c          	jra	L747
3400  07a0               L325:
3401                     ; 1139 	    case 20: emb_itoa(uip_stat.tcp.syndrop,  OctetArray, 10, 10); break;
3403  07a0 4b0a          	push	#10
3404  07a2 4b0a          	push	#10
3405  07a4 ae0000        	ldw	x,#_OctetArray
3406  07a7 89            	pushw	x
3407  07a8 ce0052        	ldw	x,_uip_stat+82
3408  07ab 89            	pushw	x
3409  07ac ce0050        	ldw	x,_uip_stat+80
3413  07af 201b          	jra	L747
3414  07b1               L525:
3415                     ; 1140 	    case 21: emb_itoa(uip_stat.tcp.synrst,   OctetArray, 10, 10); break;
3417  07b1 4b0a          	push	#10
3418  07b3 4b0a          	push	#10
3419  07b5 ae0000        	ldw	x,#_OctetArray
3420  07b8 89            	pushw	x
3421  07b9 ce0056        	ldw	x,_uip_stat+86
3422  07bc 89            	pushw	x
3423  07bd ce0054        	ldw	x,_uip_stat+84
3427  07c0 200a          	jra	L747
3428  07c2               L725:
3429                     ; 1141 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3431  07c2 4b0a          	push	#10
3432  07c4 4b0a          	push	#10
3433  07c6 ae0000        	ldw	x,#_OctetArray
3434  07c9 89            	pushw	x
3435  07ca 5f            	clrw	x
3436  07cb 89            	pushw	x
3440  07cc               L747:
3441  07cc 89            	pushw	x
3442  07cd cd008c        	call	_emb_itoa
3443  07d0 5b08          	addw	sp,#8
3444                     ; 1144 	  for (i=0; i<10; i++) {
3446  07d2 4f            	clr	a
3447  07d3 6b07          	ld	(OFST+0,sp),a
3449  07d5               L157:
3450                     ; 1145             *pBuffer = OctetArray[i];
3452  07d5 5f            	clrw	x
3453  07d6 97            	ld	xl,a
3454  07d7 d60000        	ld	a,(_OctetArray,x)
3455  07da 1e08          	ldw	x,(OFST+1,sp)
3456  07dc f7            	ld	(x),a
3457                     ; 1146             pBuffer++;
3459  07dd 5c            	incw	x
3460  07de 1f08          	ldw	(OFST+1,sp),x
3461                     ; 1147             nBytes++;
3463  07e0 1e05          	ldw	x,(OFST-2,sp)
3464  07e2 5c            	incw	x
3465  07e3 1f05          	ldw	(OFST-2,sp),x
3467                     ; 1144 	  for (i=0; i<10; i++) {
3469  07e5 0c07          	inc	(OFST+0,sp)
3473  07e7 7b07          	ld	a,(OFST+0,sp)
3474  07e9 a10a          	cp	a,#10
3475  07eb 25e8          	jrult	L157
3476                     ; 1152           *ppData = *ppData + 10;
3478  07ed 1e0c          	ldw	x,(OFST+5,sp)
3479  07ef 9093          	ldw	y,x
3480  07f1 fe            	ldw	x,(x)
3481  07f2 1c000a        	addw	x,#10
3482  07f5 90ff          	ldw	(y),x
3483                     ; 1153           *pDataLeft = *pDataLeft - 10;
3485  07f7 1e0e          	ldw	x,(OFST+7,sp)
3486  07f9 9093          	ldw	y,x
3487  07fb fe            	ldw	x,(x)
3488  07fc 1d000a        	subw	x,#10
3490  07ff 2031          	jp	LC011
3491  0801               L347:
3492                     ; 1158         else if (nParsedMode == 'f') {
3494  0801 a166          	cp	a,#102
3495  0803 2632          	jrne	L167
3496                     ; 1161 	  for(i=0; i<16; i++) {
3498  0805 4f            	clr	a
3499  0806 6b07          	ld	(OFST+0,sp),a
3501  0808               L367:
3502                     ; 1162 	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
3504  0808 cd1330        	call	_GpioGetPin
3506  080b 1e08          	ldw	x,(OFST+1,sp)
3507  080d ab30          	add	a,#48
3508  080f f7            	ld	(x),a
3509                     ; 1163             pBuffer++;
3511  0810 5c            	incw	x
3512  0811 1f08          	ldw	(OFST+1,sp),x
3513                     ; 1164             nBytes++;
3515  0813 1e05          	ldw	x,(OFST-2,sp)
3516  0815 5c            	incw	x
3517  0816 1f05          	ldw	(OFST-2,sp),x
3519                     ; 1161 	  for(i=0; i<16; i++) {
3521  0818 0c07          	inc	(OFST+0,sp)
3525  081a 7b07          	ld	a,(OFST+0,sp)
3526  081c a110          	cp	a,#16
3527  081e 25e8          	jrult	L367
3528                     ; 1168           *ppData = *ppData + 16;
3530  0820 1e0c          	ldw	x,(OFST+5,sp)
3531  0822 9093          	ldw	y,x
3532  0824 fe            	ldw	x,(x)
3533  0825 1c0010        	addw	x,#16
3534  0828 90ff          	ldw	(y),x
3535                     ; 1169           *pDataLeft = *pDataLeft - 16;
3537  082a 1e0e          	ldw	x,(OFST+7,sp)
3538  082c 9093          	ldw	y,x
3539  082e fe            	ldw	x,(x)
3540  082f 1d0010        	subw	x,#16
3541  0832               LC011:
3542  0832 90ff          	ldw	(y),x
3544  0834 cc0af8        	jra	L306
3545  0837               L167:
3546                     ; 1172         else if (nParsedMode == 'g') {
3548  0837 a167          	cp	a,#103
3549  0839 2623          	jrne	L377
3550                     ; 1176 	  if (invert_output == 1) {  // Insert 'checked'
3552  083b c60000        	ld	a,_invert_output
3553  083e 4a            	dec	a
3554  083f 26f3          	jrne	L306
3555                     ; 1177             for(i=0; i<7; i++) {
3557  0841 6b07          	ld	(OFST+0,sp),a
3559  0843               L777:
3560                     ; 1178               *pBuffer = checked[i];
3562  0843 5f            	clrw	x
3563  0844 97            	ld	xl,a
3564  0845 d60000        	ld	a,(L31_checked,x)
3565  0848 1e08          	ldw	x,(OFST+1,sp)
3566  084a f7            	ld	(x),a
3567                     ; 1179               pBuffer++;
3569  084b 5c            	incw	x
3570  084c 1f08          	ldw	(OFST+1,sp),x
3571                     ; 1180               nBytes++;
3573  084e 1e05          	ldw	x,(OFST-2,sp)
3574  0850 5c            	incw	x
3575  0851 1f05          	ldw	(OFST-2,sp),x
3577                     ; 1177             for(i=0; i<7; i++) {
3579  0853 0c07          	inc	(OFST+0,sp)
3583  0855 7b07          	ld	a,(OFST+0,sp)
3584  0857 a107          	cp	a,#7
3585  0859 25e8          	jrult	L777
3586  085b cc0af8        	jra	L306
3587  085e               L377:
3588                     ; 1185         else if (nParsedMode == 'h') {
3590  085e a168          	cp	a,#104
3591  0860 2622          	jrne	L7001
3592                     ; 1190 	  if (invert_output == 0) {  // Insert 'checked'
3594  0862 c60000        	ld	a,_invert_output
3595  0865 26f4          	jrne	L306
3596                     ; 1191             for(i=0; i<7; i++) {
3598  0867 6b07          	ld	(OFST+0,sp),a
3600  0869               L3101:
3601                     ; 1192               *pBuffer = checked[i];
3603  0869 5f            	clrw	x
3604  086a 97            	ld	xl,a
3605  086b d60000        	ld	a,(L31_checked,x)
3606  086e 1e08          	ldw	x,(OFST+1,sp)
3607  0870 f7            	ld	(x),a
3608                     ; 1193               pBuffer++;
3610  0871 5c            	incw	x
3611  0872 1f08          	ldw	(OFST+1,sp),x
3612                     ; 1194               nBytes++;
3614  0874 1e05          	ldw	x,(OFST-2,sp)
3615  0876 5c            	incw	x
3616  0877 1f05          	ldw	(OFST-2,sp),x
3618                     ; 1191             for(i=0; i<7; i++) {
3620  0879 0c07          	inc	(OFST+0,sp)
3624  087b 7b07          	ld	a,(OFST+0,sp)
3625  087d a107          	cp	a,#7
3626  087f 25e8          	jrult	L3101
3627  0881 cc0af8        	jra	L306
3628  0884               L7001:
3629                     ; 1199         else if (nParsedMode == 'x') {
3631  0884 a178          	cp	a,#120
3632  0886 26f9          	jrne	L306
3633                     ; 1209           *pBuffer = 'h'; pBuffer++; nBytes++;
3635  0888 1e08          	ldw	x,(OFST+1,sp)
3636  088a a668          	ld	a,#104
3637  088c f7            	ld	(x),a
3640  088d 5c            	incw	x
3641  088e 1f08          	ldw	(OFST+1,sp),x
3644  0890 1e05          	ldw	x,(OFST-2,sp)
3645  0892 5c            	incw	x
3646  0893 1f05          	ldw	(OFST-2,sp),x
3648                     ; 1210           *pBuffer = 't'; pBuffer++; nBytes++;
3650  0895 1e08          	ldw	x,(OFST+1,sp)
3651  0897 a674          	ld	a,#116
3652  0899 f7            	ld	(x),a
3655  089a 5c            	incw	x
3656  089b 1f08          	ldw	(OFST+1,sp),x
3659  089d 1e05          	ldw	x,(OFST-2,sp)
3660  089f 5c            	incw	x
3661  08a0 1f05          	ldw	(OFST-2,sp),x
3663                     ; 1211           *pBuffer = 't'; pBuffer++; nBytes++;
3665  08a2 1e08          	ldw	x,(OFST+1,sp)
3666  08a4 f7            	ld	(x),a
3669  08a5 5c            	incw	x
3670  08a6 1f08          	ldw	(OFST+1,sp),x
3673  08a8 1e05          	ldw	x,(OFST-2,sp)
3674  08aa 5c            	incw	x
3675  08ab 1f05          	ldw	(OFST-2,sp),x
3677                     ; 1212           *pBuffer = 'p'; pBuffer++; nBytes++;
3679  08ad 1e08          	ldw	x,(OFST+1,sp)
3680  08af a670          	ld	a,#112
3681  08b1 f7            	ld	(x),a
3684  08b2 5c            	incw	x
3685  08b3 1f08          	ldw	(OFST+1,sp),x
3688  08b5 1e05          	ldw	x,(OFST-2,sp)
3689  08b7 5c            	incw	x
3690  08b8 1f05          	ldw	(OFST-2,sp),x
3692                     ; 1213           *pBuffer = ':'; pBuffer++; nBytes++;
3694  08ba 1e08          	ldw	x,(OFST+1,sp)
3695  08bc a63a          	ld	a,#58
3696  08be f7            	ld	(x),a
3699  08bf 5c            	incw	x
3700  08c0 1f08          	ldw	(OFST+1,sp),x
3703  08c2 1e05          	ldw	x,(OFST-2,sp)
3704  08c4 5c            	incw	x
3705  08c5 1f05          	ldw	(OFST-2,sp),x
3707                     ; 1214           *pBuffer = '/'; pBuffer++; nBytes++;
3709  08c7 1e08          	ldw	x,(OFST+1,sp)
3710  08c9 a62f          	ld	a,#47
3711  08cb f7            	ld	(x),a
3714  08cc 5c            	incw	x
3715  08cd 1f08          	ldw	(OFST+1,sp),x
3718  08cf 1e05          	ldw	x,(OFST-2,sp)
3719  08d1 5c            	incw	x
3720  08d2 1f05          	ldw	(OFST-2,sp),x
3722                     ; 1215           *pBuffer = '/'; pBuffer++; nBytes++;
3724  08d4 1e08          	ldw	x,(OFST+1,sp)
3725  08d6 f7            	ld	(x),a
3728  08d7 5c            	incw	x
3729  08d8 1f08          	ldw	(OFST+1,sp),x
3732  08da 1e05          	ldw	x,(OFST-2,sp)
3733  08dc 5c            	incw	x
3734  08dd 1f05          	ldw	(OFST-2,sp),x
3736                     ; 1219           emb_itoa(ex_stored_hostaddr4,  OctetArray, 10, 3);
3738  08df 4b03          	push	#3
3739  08e1 4b0a          	push	#10
3740  08e3 ae0000        	ldw	x,#_OctetArray
3741  08e6 89            	pushw	x
3742  08e7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr4
3743  08ec 3f02          	clr	c_lreg+2
3744  08ee 3f01          	clr	c_lreg+1
3745  08f0 3f00          	clr	c_lreg
3746  08f2 be02          	ldw	x,c_lreg+2
3747  08f4 89            	pushw	x
3748  08f5 be00          	ldw	x,c_lreg
3749  08f7 89            	pushw	x
3750  08f8 cd008c        	call	_emb_itoa
3752  08fb 5b08          	addw	sp,#8
3753                     ; 1221 	  if (OctetArray[0] != '0') {
3755  08fd c60000        	ld	a,_OctetArray
3756  0900 a130          	cp	a,#48
3757  0902 270b          	jreq	L5201
3758                     ; 1222 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3760  0904 1e08          	ldw	x,(OFST+1,sp)
3761  0906 f7            	ld	(x),a
3764  0907 5c            	incw	x
3765  0908 1f08          	ldw	(OFST+1,sp),x
3768  090a 1e05          	ldw	x,(OFST-2,sp)
3769  090c 5c            	incw	x
3770  090d 1f05          	ldw	(OFST-2,sp),x
3772  090f               L5201:
3773                     ; 1224 	  if (OctetArray[0] != '0') {
3775  090f a130          	cp	a,#48
3776  0911 2707          	jreq	L7201
3777                     ; 1225             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3779  0913 1e08          	ldw	x,(OFST+1,sp)
3780  0915 c60001        	ld	a,_OctetArray+1
3784  0918 2009          	jp	LC005
3785  091a               L7201:
3786                     ; 1227 	  else if (OctetArray[1] != '0') {
3788  091a c60001        	ld	a,_OctetArray+1
3789  091d a130          	cp	a,#48
3790  091f 270b          	jreq	L1301
3791                     ; 1228             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3793  0921 1e08          	ldw	x,(OFST+1,sp)
3798  0923               LC005:
3799  0923 f7            	ld	(x),a
3801  0924 5c            	incw	x
3802  0925 1f08          	ldw	(OFST+1,sp),x
3804  0927 1e05          	ldw	x,(OFST-2,sp)
3805  0929 5c            	incw	x
3806  092a 1f05          	ldw	(OFST-2,sp),x
3808  092c               L1301:
3809                     ; 1230           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3811  092c 1e08          	ldw	x,(OFST+1,sp)
3812  092e c60002        	ld	a,_OctetArray+2
3813  0931 f7            	ld	(x),a
3816  0932 5c            	incw	x
3817  0933 1f08          	ldw	(OFST+1,sp),x
3820  0935 1e05          	ldw	x,(OFST-2,sp)
3821  0937 5c            	incw	x
3822  0938 1f05          	ldw	(OFST-2,sp),x
3824                     ; 1232           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3826  093a 1e08          	ldw	x,(OFST+1,sp)
3827  093c a62e          	ld	a,#46
3828  093e f7            	ld	(x),a
3831  093f 5c            	incw	x
3832  0940 1f08          	ldw	(OFST+1,sp),x
3835  0942 1e05          	ldw	x,(OFST-2,sp)
3836  0944 5c            	incw	x
3837  0945 1f05          	ldw	(OFST-2,sp),x
3839                     ; 1235           emb_itoa(ex_stored_hostaddr3,  OctetArray, 10, 3);
3841  0947 4b03          	push	#3
3842  0949 4b0a          	push	#10
3843  094b ae0000        	ldw	x,#_OctetArray
3844  094e 89            	pushw	x
3845  094f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr3
3846  0954 3f02          	clr	c_lreg+2
3847  0956 3f01          	clr	c_lreg+1
3848  0958 3f00          	clr	c_lreg
3849  095a be02          	ldw	x,c_lreg+2
3850  095c 89            	pushw	x
3851  095d be00          	ldw	x,c_lreg
3852  095f 89            	pushw	x
3853  0960 cd008c        	call	_emb_itoa
3855  0963 5b08          	addw	sp,#8
3856                     ; 1237 	  if (OctetArray[0] != '0') {
3858  0965 c60000        	ld	a,_OctetArray
3859  0968 a130          	cp	a,#48
3860  096a 270b          	jreq	L5301
3861                     ; 1238 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3863  096c 1e08          	ldw	x,(OFST+1,sp)
3864  096e f7            	ld	(x),a
3867  096f 5c            	incw	x
3868  0970 1f08          	ldw	(OFST+1,sp),x
3871  0972 1e05          	ldw	x,(OFST-2,sp)
3872  0974 5c            	incw	x
3873  0975 1f05          	ldw	(OFST-2,sp),x
3875  0977               L5301:
3876                     ; 1240 	  if (OctetArray[0] != '0') {
3878  0977 a130          	cp	a,#48
3879  0979 2707          	jreq	L7301
3880                     ; 1241             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3882  097b 1e08          	ldw	x,(OFST+1,sp)
3883  097d c60001        	ld	a,_OctetArray+1
3887  0980 2009          	jp	LC006
3888  0982               L7301:
3889                     ; 1243 	  else if (OctetArray[1] != '0') {
3891  0982 c60001        	ld	a,_OctetArray+1
3892  0985 a130          	cp	a,#48
3893  0987 270b          	jreq	L1401
3894                     ; 1244             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3896  0989 1e08          	ldw	x,(OFST+1,sp)
3901  098b               LC006:
3902  098b f7            	ld	(x),a
3904  098c 5c            	incw	x
3905  098d 1f08          	ldw	(OFST+1,sp),x
3907  098f 1e05          	ldw	x,(OFST-2,sp)
3908  0991 5c            	incw	x
3909  0992 1f05          	ldw	(OFST-2,sp),x
3911  0994               L1401:
3912                     ; 1246           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3914  0994 1e08          	ldw	x,(OFST+1,sp)
3915  0996 c60002        	ld	a,_OctetArray+2
3916  0999 f7            	ld	(x),a
3919  099a 5c            	incw	x
3920  099b 1f08          	ldw	(OFST+1,sp),x
3923  099d 1e05          	ldw	x,(OFST-2,sp)
3924  099f 5c            	incw	x
3925  09a0 1f05          	ldw	(OFST-2,sp),x
3927                     ; 1248           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3929  09a2 1e08          	ldw	x,(OFST+1,sp)
3930  09a4 a62e          	ld	a,#46
3931  09a6 f7            	ld	(x),a
3934  09a7 5c            	incw	x
3935  09a8 1f08          	ldw	(OFST+1,sp),x
3938  09aa 1e05          	ldw	x,(OFST-2,sp)
3939  09ac 5c            	incw	x
3940  09ad 1f05          	ldw	(OFST-2,sp),x
3942                     ; 1251           emb_itoa(ex_stored_hostaddr2,  OctetArray, 10, 3);
3944  09af 4b03          	push	#3
3945  09b1 4b0a          	push	#10
3946  09b3 ae0000        	ldw	x,#_OctetArray
3947  09b6 89            	pushw	x
3948  09b7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr2
3949  09bc 3f02          	clr	c_lreg+2
3950  09be 3f01          	clr	c_lreg+1
3951  09c0 3f00          	clr	c_lreg
3952  09c2 be02          	ldw	x,c_lreg+2
3953  09c4 89            	pushw	x
3954  09c5 be00          	ldw	x,c_lreg
3955  09c7 89            	pushw	x
3956  09c8 cd008c        	call	_emb_itoa
3958  09cb 5b08          	addw	sp,#8
3959                     ; 1253 	  if (OctetArray[0] != '0') {
3961  09cd c60000        	ld	a,_OctetArray
3962  09d0 a130          	cp	a,#48
3963  09d2 270b          	jreq	L5401
3964                     ; 1254 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3966  09d4 1e08          	ldw	x,(OFST+1,sp)
3967  09d6 f7            	ld	(x),a
3970  09d7 5c            	incw	x
3971  09d8 1f08          	ldw	(OFST+1,sp),x
3974  09da 1e05          	ldw	x,(OFST-2,sp)
3975  09dc 5c            	incw	x
3976  09dd 1f05          	ldw	(OFST-2,sp),x
3978  09df               L5401:
3979                     ; 1256 	  if (OctetArray[0] != '0') {
3981  09df a130          	cp	a,#48
3982  09e1 2707          	jreq	L7401
3983                     ; 1257             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3985  09e3 1e08          	ldw	x,(OFST+1,sp)
3986  09e5 c60001        	ld	a,_OctetArray+1
3990  09e8 2009          	jp	LC007
3991  09ea               L7401:
3992                     ; 1259 	  else if (OctetArray[1] != '0') {
3994  09ea c60001        	ld	a,_OctetArray+1
3995  09ed a130          	cp	a,#48
3996  09ef 270b          	jreq	L1501
3997                     ; 1260             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3999  09f1 1e08          	ldw	x,(OFST+1,sp)
4004  09f3               LC007:
4005  09f3 f7            	ld	(x),a
4007  09f4 5c            	incw	x
4008  09f5 1f08          	ldw	(OFST+1,sp),x
4010  09f7 1e05          	ldw	x,(OFST-2,sp)
4011  09f9 5c            	incw	x
4012  09fa 1f05          	ldw	(OFST-2,sp),x
4014  09fc               L1501:
4015                     ; 1262           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
4017  09fc 1e08          	ldw	x,(OFST+1,sp)
4018  09fe c60002        	ld	a,_OctetArray+2
4019  0a01 f7            	ld	(x),a
4022  0a02 5c            	incw	x
4023  0a03 1f08          	ldw	(OFST+1,sp),x
4026  0a05 1e05          	ldw	x,(OFST-2,sp)
4027  0a07 5c            	incw	x
4028  0a08 1f05          	ldw	(OFST-2,sp),x
4030                     ; 1264           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
4032  0a0a 1e08          	ldw	x,(OFST+1,sp)
4033  0a0c a62e          	ld	a,#46
4034  0a0e f7            	ld	(x),a
4037  0a0f 5c            	incw	x
4038  0a10 1f08          	ldw	(OFST+1,sp),x
4041  0a12 1e05          	ldw	x,(OFST-2,sp)
4042  0a14 5c            	incw	x
4043  0a15 1f05          	ldw	(OFST-2,sp),x
4045                     ; 1267           emb_itoa(ex_stored_hostaddr1,  OctetArray, 10, 3);
4047  0a17 4b03          	push	#3
4048  0a19 4b0a          	push	#10
4049  0a1b ae0000        	ldw	x,#_OctetArray
4050  0a1e 89            	pushw	x
4051  0a1f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr1
4052  0a24 3f02          	clr	c_lreg+2
4053  0a26 3f01          	clr	c_lreg+1
4054  0a28 3f00          	clr	c_lreg
4055  0a2a be02          	ldw	x,c_lreg+2
4056  0a2c 89            	pushw	x
4057  0a2d be00          	ldw	x,c_lreg
4058  0a2f 89            	pushw	x
4059  0a30 cd008c        	call	_emb_itoa
4061  0a33 5b08          	addw	sp,#8
4062                     ; 1269 	  if (OctetArray[0] != '0') {
4064  0a35 c60000        	ld	a,_OctetArray
4065  0a38 a130          	cp	a,#48
4066  0a3a 270b          	jreq	L5501
4067                     ; 1270 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
4069  0a3c 1e08          	ldw	x,(OFST+1,sp)
4070  0a3e f7            	ld	(x),a
4073  0a3f 5c            	incw	x
4074  0a40 1f08          	ldw	(OFST+1,sp),x
4077  0a42 1e05          	ldw	x,(OFST-2,sp)
4078  0a44 5c            	incw	x
4079  0a45 1f05          	ldw	(OFST-2,sp),x
4081  0a47               L5501:
4082                     ; 1272 	  if (OctetArray[0] != '0') {
4084  0a47 a130          	cp	a,#48
4085  0a49 2707          	jreq	L7501
4086                     ; 1273             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
4088  0a4b 1e08          	ldw	x,(OFST+1,sp)
4089  0a4d c60001        	ld	a,_OctetArray+1
4093  0a50 2009          	jp	LC008
4094  0a52               L7501:
4095                     ; 1275 	  else if (OctetArray[1] != '0') {
4097  0a52 c60001        	ld	a,_OctetArray+1
4098  0a55 a130          	cp	a,#48
4099  0a57 270b          	jreq	L1601
4100                     ; 1276             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
4102  0a59 1e08          	ldw	x,(OFST+1,sp)
4107  0a5b               LC008:
4108  0a5b f7            	ld	(x),a
4110  0a5c 5c            	incw	x
4111  0a5d 1f08          	ldw	(OFST+1,sp),x
4113  0a5f 1e05          	ldw	x,(OFST-2,sp)
4114  0a61 5c            	incw	x
4115  0a62 1f05          	ldw	(OFST-2,sp),x
4117  0a64               L1601:
4118                     ; 1278           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
4120  0a64 1e08          	ldw	x,(OFST+1,sp)
4121  0a66 c60002        	ld	a,_OctetArray+2
4122  0a69 f7            	ld	(x),a
4125  0a6a 5c            	incw	x
4126  0a6b 1f08          	ldw	(OFST+1,sp),x
4129  0a6d 1e05          	ldw	x,(OFST-2,sp)
4130  0a6f 5c            	incw	x
4131  0a70 1f05          	ldw	(OFST-2,sp),x
4133                     ; 1280           *pBuffer = ':'; pBuffer++; nBytes++; // Output ':'
4135  0a72 1e08          	ldw	x,(OFST+1,sp)
4136  0a74 a63a          	ld	a,#58
4137  0a76 f7            	ld	(x),a
4140  0a77 5c            	incw	x
4141  0a78 1f08          	ldw	(OFST+1,sp),x
4144  0a7a 1e05          	ldw	x,(OFST-2,sp)
4145  0a7c 5c            	incw	x
4146  0a7d 1f05          	ldw	(OFST-2,sp),x
4148                     ; 1283   	  emb_itoa(ex_stored_port, OctetArray, 10, 5);
4150  0a7f 4b05          	push	#5
4151  0a81 4b0a          	push	#10
4152  0a83 ae0000        	ldw	x,#_OctetArray
4153  0a86 89            	pushw	x
4154  0a87 ce0000        	ldw	x,_ex_stored_port
4155  0a8a cd0000        	call	c_uitolx
4157  0a8d be02          	ldw	x,c_lreg+2
4158  0a8f 89            	pushw	x
4159  0a90 be00          	ldw	x,c_lreg
4160  0a92 89            	pushw	x
4161  0a93 cd008c        	call	_emb_itoa
4163  0a96 5b08          	addw	sp,#8
4164                     ; 1285 	  for(i=0; i<5; i++) {
4166  0a98 4f            	clr	a
4167  0a99 6b07          	ld	(OFST+0,sp),a
4169  0a9b               L5601:
4170                     ; 1286 	    if (OctetArray[i] != '0') break;
4172  0a9b 5f            	clrw	x
4173  0a9c 97            	ld	xl,a
4174  0a9d d60000        	ld	a,(_OctetArray,x)
4175  0aa0 a130          	cp	a,#48
4176  0aa2 261c          	jrne	L7701
4179                     ; 1285 	  for(i=0; i<5; i++) {
4181  0aa4 0c07          	inc	(OFST+0,sp)
4185  0aa6 7b07          	ld	a,(OFST+0,sp)
4186  0aa8 a105          	cp	a,#5
4187  0aaa 25ef          	jrult	L5601
4188  0aac 2012          	jra	L7701
4189  0aae               L5701:
4190                     ; 1289 	    *pBuffer = OctetArray[i]; pBuffer++; nBytes++;
4192  0aae 5f            	clrw	x
4193  0aaf 97            	ld	xl,a
4194  0ab0 d60000        	ld	a,(_OctetArray,x)
4195  0ab3 1e08          	ldw	x,(OFST+1,sp)
4196  0ab5 f7            	ld	(x),a
4199  0ab6 5c            	incw	x
4200  0ab7 1f08          	ldw	(OFST+1,sp),x
4203  0ab9 1e05          	ldw	x,(OFST-2,sp)
4204  0abb 5c            	incw	x
4205  0abc 1f05          	ldw	(OFST-2,sp),x
4207                     ; 1290 	    i++;
4209  0abe 0c07          	inc	(OFST+0,sp)
4211  0ac0               L7701:
4212                     ; 1288 	  while(i<5) {
4214  0ac0 7b07          	ld	a,(OFST+0,sp)
4215  0ac2 a105          	cp	a,#5
4216  0ac4 25e8          	jrult	L5701
4217                     ; 1295           *ppData = *ppData + 28;
4219  0ac6 1e0c          	ldw	x,(OFST+5,sp)
4220  0ac8 9093          	ldw	y,x
4221  0aca fe            	ldw	x,(x)
4222  0acb 1c001c        	addw	x,#28
4223  0ace 90ff          	ldw	(y),x
4224                     ; 1296           *pDataLeft = *pDataLeft - 28;
4226  0ad0 1e0e          	ldw	x,(OFST+7,sp)
4227  0ad2 9093          	ldw	y,x
4228  0ad4 fe            	ldw	x,(x)
4229  0ad5 1d001c        	subw	x,#28
4230  0ad8 cc0832        	jp	LC011
4231  0adb               L116:
4232                     ; 1300         *pBuffer = nByte;
4234  0adb 1e08          	ldw	x,(OFST+1,sp)
4235  0add f7            	ld	(x),a
4236                     ; 1301         *ppData = *ppData + 1;
4238  0ade 1e0c          	ldw	x,(OFST+5,sp)
4239  0ae0 9093          	ldw	y,x
4240  0ae2 fe            	ldw	x,(x)
4241  0ae3 5c            	incw	x
4242  0ae4 90ff          	ldw	(y),x
4243                     ; 1302         *pDataLeft = *pDataLeft - 1;
4245  0ae6 1e0e          	ldw	x,(OFST+7,sp)
4246  0ae8 9093          	ldw	y,x
4247  0aea fe            	ldw	x,(x)
4248  0aeb 5a            	decw	x
4249  0aec 90ff          	ldw	(y),x
4250                     ; 1303         pBuffer++;
4252  0aee 1e08          	ldw	x,(OFST+1,sp)
4253                     ; 1304         nBytes++;
4255  0af0               LC009:
4258  0af0 5c            	incw	x
4259  0af1 1f08          	ldw	(OFST+1,sp),x
4262  0af3 1e05          	ldw	x,(OFST-2,sp)
4263  0af5 5c            	incw	x
4264  0af6 1f05          	ldw	(OFST-2,sp),x
4266  0af8               L306:
4267                     ; 842   while (nBytes < nMaxBytes) {
4269  0af8 1e05          	ldw	x,(OFST-2,sp)
4270  0afa 1310          	cpw	x,(OFST+9,sp)
4271  0afc 2403cc02e1    	jrult	L106
4272  0b01               L506:
4273                     ; 1309   return nBytes;
4275  0b01 1e05          	ldw	x,(OFST-2,sp)
4278  0b03 5b09          	addw	sp,#9
4279  0b05 81            	ret	
4306                     ; 1313 void HttpDInit()
4306                     ; 1314 {
4307                     	switch	.text
4308  0b06               _HttpDInit:
4312                     ; 1316   uip_listen(htons(Port_Httpd));
4314  0b06 ce0000        	ldw	x,_Port_Httpd
4315  0b09 cd0000        	call	_htons
4317  0b0c cd0000        	call	_uip_listen
4319                     ; 1317   current_webpage = WEBPAGE_DEFAULT;
4321  0b0f 725f000b      	clr	_current_webpage
4322                     ; 1318 }
4325  0b13 81            	ret	
4531                     	switch	.const
4532  4184               L472:
4533  4184 1088          	dc.w	L7111
4534  4186 108f          	dc.w	L1211
4535  4188 1096          	dc.w	L3211
4536  418a 109d          	dc.w	L5211
4537  418c 10a4          	dc.w	L7211
4538  418e 10ab          	dc.w	L1311
4539  4190 10b2          	dc.w	L3311
4540  4192 10b9          	dc.w	L5311
4541  4194 10c0          	dc.w	L7311
4542  4196 10c7          	dc.w	L1411
4543  4198 10ce          	dc.w	L3411
4544  419a 10d5          	dc.w	L5411
4545  419c 10dc          	dc.w	L7411
4546  419e 10e3          	dc.w	L1511
4547  41a0 10ea          	dc.w	L3511
4548  41a2 10f1          	dc.w	L5511
4549  41a4 10f8          	dc.w	L7511
4550  41a6 10ff          	dc.w	L1611
4551  41a8 1106          	dc.w	L3611
4552  41aa 110d          	dc.w	L5611
4553  41ac 1114          	dc.w	L7611
4554  41ae 111b          	dc.w	L1711
4555  41b0 1122          	dc.w	L3711
4556  41b2 1129          	dc.w	L5711
4557  41b4 1130          	dc.w	L7711
4558  41b6 1137          	dc.w	L1021
4559  41b8 113e          	dc.w	L3021
4560  41ba 1145          	dc.w	L5021
4561  41bc 114c          	dc.w	L7021
4562  41be 1153          	dc.w	L1121
4563  41c0 115a          	dc.w	L3121
4564  41c2 1161          	dc.w	L5121
4565  41c4 11ee          	dc.w	L3421
4566  41c6 11ee          	dc.w	L3421
4567  41c8 11ee          	dc.w	L3421
4568  41ca 11ee          	dc.w	L3421
4569  41cc 11ee          	dc.w	L3421
4570  41ce 11ee          	dc.w	L3421
4571  41d0 11ee          	dc.w	L3421
4572  41d2 11ee          	dc.w	L3421
4573  41d4 11ee          	dc.w	L3421
4574  41d6 11ee          	dc.w	L3421
4575  41d8 11ee          	dc.w	L3421
4576  41da 11ee          	dc.w	L3421
4577  41dc 11ee          	dc.w	L3421
4578  41de 11ee          	dc.w	L3421
4579  41e0 11ee          	dc.w	L3421
4580  41e2 11ee          	dc.w	L3421
4581  41e4 11ee          	dc.w	L3421
4582  41e6 11ee          	dc.w	L3421
4583  41e8 11ee          	dc.w	L3421
4584  41ea 11ee          	dc.w	L3421
4585  41ec 11ee          	dc.w	L3421
4586  41ee 11ee          	dc.w	L3421
4587  41f0 11ee          	dc.w	L3421
4588  41f2 1168          	dc.w	L7121
4589  41f4 1173          	dc.w	L1221
4590  41f6 11ee          	dc.w	L3421
4591  41f8 11ee          	dc.w	L3421
4592  41fa 11ee          	dc.w	L3421
4593  41fc 117e          	dc.w	L3221
4594  41fe 1180          	dc.w	L5221
4595  4200 11ee          	dc.w	L3421
4596  4202 1192          	dc.w	L7221
4597  4204 11a4          	dc.w	L1321
4598  4206 11b6          	dc.w	L3321
4599  4208 11c1          	dc.w	L5321
4600                     ; 1321 void HttpDCall(	uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
4600                     ; 1322 {
4601                     	switch	.text
4602  0b14               _HttpDCall:
4604  0b14 89            	pushw	x
4605  0b15 5207          	subw	sp,#7
4606       00000007      OFST:	set	7
4609                     ; 1332   alpha_1 = '0';
4611                     ; 1333   alpha_2 = '0';
4613                     ; 1334   alpha_3 = '0';
4615                     ; 1335   alpha_4 = '0';
4617                     ; 1336   alpha_5 = '0';
4619                     ; 1338   if(uip_connected()) {
4621  0b17 720d00007a    	btjf	_uip_flags,#6,L3431
4622                     ; 1340     if(current_webpage == WEBPAGE_DEFAULT) {
4624  0b1c c6000b        	ld	a,_current_webpage
4625  0b1f 260e          	jrne	L5431
4626                     ; 1341       pSocket->pData = g_HtmlPageDefault;
4628  0b21 1e0e          	ldw	x,(OFST+7,sp)
4629  0b23 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
4630  0b27 ef01          	ldw	(1,x),y
4631                     ; 1342       pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
4633  0b29 90ae1879      	ldw	y,#6265
4635  0b2d 2058          	jp	LC012
4636  0b2f               L5431:
4637                     ; 1346     else if(current_webpage == WEBPAGE_ADDRESS) {
4639  0b2f a101          	cp	a,#1
4640  0b31 260e          	jrne	L1531
4641                     ; 1347       pSocket->pData = g_HtmlPageAddress;
4643  0b33 1e0e          	ldw	x,(OFST+7,sp)
4644  0b35 90ae1882      	ldw	y,#L71_g_HtmlPageAddress
4645  0b39 ef01          	ldw	(1,x),y
4646                     ; 1348       pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
4648  0b3b 90ae133d      	ldw	y,#4925
4650  0b3f 2046          	jp	LC012
4651  0b41               L1531:
4652                     ; 1352     else if(current_webpage == WEBPAGE_HELP) {
4654  0b41 a103          	cp	a,#3
4655  0b43 260e          	jrne	L5531
4656                     ; 1353       pSocket->pData = g_HtmlPageHelp;
4658  0b45 1e0e          	ldw	x,(OFST+7,sp)
4659  0b47 90ae2bc0      	ldw	y,#L12_g_HtmlPageHelp
4660  0b4b ef01          	ldw	(1,x),y
4661                     ; 1354       pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
4663  0b4d 90ae0756      	ldw	y,#1878
4665  0b51 2034          	jp	LC012
4666  0b53               L5531:
4667                     ; 1356     else if(current_webpage == WEBPAGE_HELP2) {
4669  0b53 a104          	cp	a,#4
4670  0b55 260e          	jrne	L1631
4671                     ; 1357       pSocket->pData = g_HtmlPageHelp2;
4673  0b57 1e0e          	ldw	x,(OFST+7,sp)
4674  0b59 90ae3317      	ldw	y,#L32_g_HtmlPageHelp2
4675  0b5d ef01          	ldw	(1,x),y
4676                     ; 1358       pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
4678  0b5f 90ae02b7      	ldw	y,#695
4680  0b63 2022          	jp	LC012
4681  0b65               L1631:
4682                     ; 1363     else if(current_webpage == WEBPAGE_STATS) {
4684  0b65 a105          	cp	a,#5
4685  0b67 260e          	jrne	L5631
4686                     ; 1364       pSocket->pData = g_HtmlPageStats;
4688  0b69 1e0e          	ldw	x,(OFST+7,sp)
4689  0b6b 90ae35cf      	ldw	y,#L52_g_HtmlPageStats
4690  0b6f ef01          	ldw	(1,x),y
4691                     ; 1365       pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
4693  0b71 90ae0ae8      	ldw	y,#2792
4695  0b75 2010          	jp	LC012
4696  0b77               L5631:
4697                     ; 1368     else if(current_webpage == WEBPAGE_RSTATE) {
4699  0b77 a106          	cp	a,#6
4700  0b79 260e          	jrne	L7431
4701                     ; 1369       pSocket->pData = g_HtmlPageRstate;
4703  0b7b 1e0e          	ldw	x,(OFST+7,sp)
4704  0b7d 90ae40b8      	ldw	y,#L72_g_HtmlPageRstate
4705  0b81 ef01          	ldw	(1,x),y
4706                     ; 1370       pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
4708  0b83 90ae0087      	ldw	y,#135
4709  0b87               LC012:
4710  0b87 ef03          	ldw	(3,x),y
4711  0b89               L7431:
4712                     ; 1372     pSocket->nNewlines = 0;
4714  0b89 1e0e          	ldw	x,(OFST+7,sp)
4715                     ; 1373     pSocket->nState = STATE_CONNECTED;
4717  0b8b 7f            	clr	(x)
4718  0b8c 6f05          	clr	(5,x)
4719                     ; 1374     pSocket->nPrevBytes = 0xFFFF;
4721  0b8e 90aeffff      	ldw	y,#65535
4722  0b92 ef0a          	ldw	(10,x),y
4724  0b94 2041          	jra	L613
4725  0b96               L3431:
4726                     ; 1376   else if (uip_newdata() || uip_acked()) {
4728  0b96 7202000008    	btjt	_uip_flags,#1,L7731
4730  0b9b 7200000003cc  	btjf	_uip_flags,#0,L5731
4731  0ba3               L7731:
4732                     ; 1377     if (pSocket->nState == STATE_CONNECTED) {
4734  0ba3 1e0e          	ldw	x,(OFST+7,sp)
4735  0ba5 f6            	ld	a,(x)
4736  0ba6 2627          	jrne	L1041
4737                     ; 1378       if (nBytes == 0) return;
4739  0ba8 1e0c          	ldw	x,(OFST+5,sp)
4740  0baa 272b          	jreq	L613
4743                     ; 1379       if (*pBuffer == 'G') pSocket->nState = STATE_GET_G;
4745  0bac 1e08          	ldw	x,(OFST+1,sp)
4746  0bae f6            	ld	a,(x)
4747  0baf a147          	cp	a,#71
4748  0bb1 2606          	jrne	L5041
4751  0bb3 1e0e          	ldw	x,(OFST+7,sp)
4752  0bb5 a601          	ld	a,#1
4754  0bb7 2008          	jp	LC013
4755  0bb9               L5041:
4756                     ; 1380       else if (*pBuffer == 'P') pSocket->nState = STATE_POST_P;
4758  0bb9 a150          	cp	a,#80
4759  0bbb 2605          	jrne	L7041
4762  0bbd 1e0e          	ldw	x,(OFST+7,sp)
4763  0bbf a604          	ld	a,#4
4764  0bc1               LC013:
4765  0bc1 f7            	ld	(x),a
4766  0bc2               L7041:
4767                     ; 1381       nBytes--;
4769  0bc2 1e0c          	ldw	x,(OFST+5,sp)
4770  0bc4 5a            	decw	x
4771  0bc5 1f0c          	ldw	(OFST+5,sp),x
4772                     ; 1382       pBuffer++;
4774  0bc7 1e08          	ldw	x,(OFST+1,sp)
4775  0bc9 5c            	incw	x
4776  0bca 1f08          	ldw	(OFST+1,sp),x
4777  0bcc 1e0e          	ldw	x,(OFST+7,sp)
4778  0bce f6            	ld	a,(x)
4779  0bcf               L1041:
4780                     ; 1385     if (pSocket->nState == STATE_GET_G) {
4782  0bcf a101          	cp	a,#1
4783  0bd1 2620          	jrne	L3141
4784                     ; 1386       if (nBytes == 0) return;
4786  0bd3 1e0c          	ldw	x,(OFST+5,sp)
4787  0bd5 2603          	jrne	L5141
4789  0bd7               L613:
4792  0bd7 5b09          	addw	sp,#9
4793  0bd9 81            	ret	
4794  0bda               L5141:
4795                     ; 1387       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
4797  0bda 1e08          	ldw	x,(OFST+1,sp)
4798  0bdc f6            	ld	a,(x)
4799  0bdd a145          	cp	a,#69
4800  0bdf 2605          	jrne	L7141
4803  0be1 1e0e          	ldw	x,(OFST+7,sp)
4804  0be3 a602          	ld	a,#2
4805  0be5 f7            	ld	(x),a
4806  0be6               L7141:
4807                     ; 1388       nBytes--;
4809  0be6 1e0c          	ldw	x,(OFST+5,sp)
4810  0be8 5a            	decw	x
4811  0be9 1f0c          	ldw	(OFST+5,sp),x
4812                     ; 1389       pBuffer++;
4814  0beb 1e08          	ldw	x,(OFST+1,sp)
4815  0bed 5c            	incw	x
4816  0bee 1f08          	ldw	(OFST+1,sp),x
4817  0bf0 1e0e          	ldw	x,(OFST+7,sp)
4818  0bf2 f6            	ld	a,(x)
4819  0bf3               L3141:
4820                     ; 1392     if (pSocket->nState == STATE_GET_GE) {
4822  0bf3 a102          	cp	a,#2
4823  0bf5 261d          	jrne	L1241
4824                     ; 1393       if (nBytes == 0) return;
4826  0bf7 1e0c          	ldw	x,(OFST+5,sp)
4827  0bf9 27dc          	jreq	L613
4830                     ; 1394       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
4832  0bfb 1e08          	ldw	x,(OFST+1,sp)
4833  0bfd f6            	ld	a,(x)
4834  0bfe a154          	cp	a,#84
4835  0c00 2605          	jrne	L5241
4838  0c02 1e0e          	ldw	x,(OFST+7,sp)
4839  0c04 a603          	ld	a,#3
4840  0c06 f7            	ld	(x),a
4841  0c07               L5241:
4842                     ; 1395       nBytes--;
4844  0c07 1e0c          	ldw	x,(OFST+5,sp)
4845  0c09 5a            	decw	x
4846  0c0a 1f0c          	ldw	(OFST+5,sp),x
4847                     ; 1396       pBuffer++;
4849  0c0c 1e08          	ldw	x,(OFST+1,sp)
4850  0c0e 5c            	incw	x
4851  0c0f 1f08          	ldw	(OFST+1,sp),x
4852  0c11 1e0e          	ldw	x,(OFST+7,sp)
4853  0c13 f6            	ld	a,(x)
4854  0c14               L1241:
4855                     ; 1399     if (pSocket->nState == STATE_GET_GET) {
4857  0c14 a103          	cp	a,#3
4858  0c16 261d          	jrne	L7241
4859                     ; 1400       if (nBytes == 0) return;
4861  0c18 1e0c          	ldw	x,(OFST+5,sp)
4862  0c1a 27bb          	jreq	L613
4865                     ; 1401       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
4867  0c1c 1e08          	ldw	x,(OFST+1,sp)
4868  0c1e f6            	ld	a,(x)
4869  0c1f a120          	cp	a,#32
4870  0c21 2605          	jrne	L3341
4873  0c23 1e0e          	ldw	x,(OFST+7,sp)
4874  0c25 a608          	ld	a,#8
4875  0c27 f7            	ld	(x),a
4876  0c28               L3341:
4877                     ; 1402       nBytes--;
4879  0c28 1e0c          	ldw	x,(OFST+5,sp)
4880  0c2a 5a            	decw	x
4881  0c2b 1f0c          	ldw	(OFST+5,sp),x
4882                     ; 1403       pBuffer++;
4884  0c2d 1e08          	ldw	x,(OFST+1,sp)
4885  0c2f 5c            	incw	x
4886  0c30 1f08          	ldw	(OFST+1,sp),x
4887  0c32 1e0e          	ldw	x,(OFST+7,sp)
4888  0c34 f6            	ld	a,(x)
4889  0c35               L7241:
4890                     ; 1406     if (pSocket->nState == STATE_POST_P) {
4892  0c35 a104          	cp	a,#4
4893  0c37 261d          	jrne	L5341
4894                     ; 1407       if (nBytes == 0) return;
4896  0c39 1e0c          	ldw	x,(OFST+5,sp)
4897  0c3b 279a          	jreq	L613
4900                     ; 1408       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
4902  0c3d 1e08          	ldw	x,(OFST+1,sp)
4903  0c3f f6            	ld	a,(x)
4904  0c40 a14f          	cp	a,#79
4905  0c42 2605          	jrne	L1441
4908  0c44 1e0e          	ldw	x,(OFST+7,sp)
4909  0c46 a605          	ld	a,#5
4910  0c48 f7            	ld	(x),a
4911  0c49               L1441:
4912                     ; 1409       nBytes--;
4914  0c49 1e0c          	ldw	x,(OFST+5,sp)
4915  0c4b 5a            	decw	x
4916  0c4c 1f0c          	ldw	(OFST+5,sp),x
4917                     ; 1410       pBuffer++;
4919  0c4e 1e08          	ldw	x,(OFST+1,sp)
4920  0c50 5c            	incw	x
4921  0c51 1f08          	ldw	(OFST+1,sp),x
4922  0c53 1e0e          	ldw	x,(OFST+7,sp)
4923  0c55 f6            	ld	a,(x)
4924  0c56               L5341:
4925                     ; 1413     if (pSocket->nState == STATE_POST_PO) {
4927  0c56 a105          	cp	a,#5
4928  0c58 2620          	jrne	L3441
4929                     ; 1414       if (nBytes == 0) return;
4931  0c5a 1e0c          	ldw	x,(OFST+5,sp)
4932  0c5c 2603cc0bd7    	jreq	L613
4935                     ; 1415       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
4937  0c61 1e08          	ldw	x,(OFST+1,sp)
4938  0c63 f6            	ld	a,(x)
4939  0c64 a153          	cp	a,#83
4940  0c66 2605          	jrne	L7441
4943  0c68 1e0e          	ldw	x,(OFST+7,sp)
4944  0c6a a606          	ld	a,#6
4945  0c6c f7            	ld	(x),a
4946  0c6d               L7441:
4947                     ; 1416       nBytes--;
4949  0c6d 1e0c          	ldw	x,(OFST+5,sp)
4950  0c6f 5a            	decw	x
4951  0c70 1f0c          	ldw	(OFST+5,sp),x
4952                     ; 1417       pBuffer++;
4954  0c72 1e08          	ldw	x,(OFST+1,sp)
4955  0c74 5c            	incw	x
4956  0c75 1f08          	ldw	(OFST+1,sp),x
4957  0c77 1e0e          	ldw	x,(OFST+7,sp)
4958  0c79 f6            	ld	a,(x)
4959  0c7a               L3441:
4960                     ; 1420     if (pSocket->nState == STATE_POST_POS) {
4962  0c7a a106          	cp	a,#6
4963  0c7c 261d          	jrne	L1541
4964                     ; 1421       if (nBytes == 0) return;
4966  0c7e 1e0c          	ldw	x,(OFST+5,sp)
4967  0c80 27dc          	jreq	L613
4970                     ; 1422       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
4972  0c82 1e08          	ldw	x,(OFST+1,sp)
4973  0c84 f6            	ld	a,(x)
4974  0c85 a154          	cp	a,#84
4975  0c87 2605          	jrne	L5541
4978  0c89 1e0e          	ldw	x,(OFST+7,sp)
4979  0c8b a607          	ld	a,#7
4980  0c8d f7            	ld	(x),a
4981  0c8e               L5541:
4982                     ; 1423       nBytes--;
4984  0c8e 1e0c          	ldw	x,(OFST+5,sp)
4985  0c90 5a            	decw	x
4986  0c91 1f0c          	ldw	(OFST+5,sp),x
4987                     ; 1424       pBuffer++;
4989  0c93 1e08          	ldw	x,(OFST+1,sp)
4990  0c95 5c            	incw	x
4991  0c96 1f08          	ldw	(OFST+1,sp),x
4992  0c98 1e0e          	ldw	x,(OFST+7,sp)
4993  0c9a f6            	ld	a,(x)
4994  0c9b               L1541:
4995                     ; 1427     if (pSocket->nState == STATE_POST_POST) {
4997  0c9b a107          	cp	a,#7
4998  0c9d 261d          	jrne	L7541
4999                     ; 1428       if (nBytes == 0) return;
5001  0c9f 1e0c          	ldw	x,(OFST+5,sp)
5002  0ca1 27bb          	jreq	L613
5005                     ; 1429       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
5007  0ca3 1e08          	ldw	x,(OFST+1,sp)
5008  0ca5 f6            	ld	a,(x)
5009  0ca6 a120          	cp	a,#32
5010  0ca8 2605          	jrne	L3641
5013  0caa 1e0e          	ldw	x,(OFST+7,sp)
5014  0cac a609          	ld	a,#9
5015  0cae f7            	ld	(x),a
5016  0caf               L3641:
5017                     ; 1430       nBytes--;
5019  0caf 1e0c          	ldw	x,(OFST+5,sp)
5020  0cb1 5a            	decw	x
5021  0cb2 1f0c          	ldw	(OFST+5,sp),x
5022                     ; 1431       pBuffer++;
5024  0cb4 1e08          	ldw	x,(OFST+1,sp)
5025  0cb6 5c            	incw	x
5026  0cb7 1f08          	ldw	(OFST+1,sp),x
5027  0cb9 1e0e          	ldw	x,(OFST+7,sp)
5028  0cbb f6            	ld	a,(x)
5029  0cbc               L7541:
5030                     ; 1434     if (pSocket->nState == STATE_GOTPOST) {
5032  0cbc a109          	cp	a,#9
5033  0cbe 2647          	jrne	L5641
5035  0cc0 2041          	jra	L1741
5036  0cc2               L7641:
5037                     ; 1437         if (*pBuffer == '\n') pSocket->nNewlines++;
5039  0cc2 1e08          	ldw	x,(OFST+1,sp)
5040  0cc4 f6            	ld	a,(x)
5041  0cc5 a10a          	cp	a,#10
5042  0cc7 2606          	jrne	L5741
5045  0cc9 1e0e          	ldw	x,(OFST+7,sp)
5046  0ccb 6c05          	inc	(5,x)
5048  0ccd 2008          	jra	L7741
5049  0ccf               L5741:
5050                     ; 1438         else if (*pBuffer == '\r') { }
5052  0ccf a10d          	cp	a,#13
5053  0cd1 2704          	jreq	L7741
5055                     ; 1439         else pSocket->nNewlines = 0;
5057  0cd3 1e0e          	ldw	x,(OFST+7,sp)
5058  0cd5 6f05          	clr	(5,x)
5059  0cd7               L7741:
5060                     ; 1440         pBuffer++;
5062  0cd7 1e08          	ldw	x,(OFST+1,sp)
5063  0cd9 5c            	incw	x
5064  0cda 1f08          	ldw	(OFST+1,sp),x
5065                     ; 1441         nBytes--;
5067  0cdc 1e0c          	ldw	x,(OFST+5,sp)
5068  0cde 5a            	decw	x
5069  0cdf 1f0c          	ldw	(OFST+5,sp),x
5070                     ; 1442         if (pSocket->nNewlines == 2) {
5072  0ce1 1e0e          	ldw	x,(OFST+7,sp)
5073  0ce3 e605          	ld	a,(5,x)
5074  0ce5 a102          	cp	a,#2
5075  0ce7 261a          	jrne	L1741
5076                     ; 1445           if(current_webpage == WEBPAGE_DEFAULT) pSocket->nParseLeft = PARSEBYTES_DEFAULT;
5078  0ce9 c6000b        	ld	a,_current_webpage
5079  0cec 2607          	jrne	L7051
5082  0cee a67e          	ld	a,#126
5083  0cf0 e706          	ld	(6,x),a
5084  0cf2 c6000b        	ld	a,_current_webpage
5085  0cf5               L7051:
5086                     ; 1446           if(current_webpage == WEBPAGE_ADDRESS) pSocket->nParseLeft = PARSEBYTES_ADDRESS;
5088  0cf5 4a            	dec	a
5089  0cf6 2604          	jrne	L1151
5092  0cf8 a693          	ld	a,#147
5093  0cfa e706          	ld	(6,x),a
5094  0cfc               L1151:
5095                     ; 1447           pSocket->ParseState = PARSE_CMD;
5097  0cfc 6f09          	clr	(9,x)
5098                     ; 1449           pSocket->nState = STATE_PARSEPOST;
5100  0cfe a60a          	ld	a,#10
5101  0d00 f7            	ld	(x),a
5102                     ; 1450           break;
5104  0d01 2004          	jra	L5641
5105  0d03               L1741:
5106                     ; 1436       while (nBytes != 0) {
5108  0d03 1e0c          	ldw	x,(OFST+5,sp)
5109  0d05 26bb          	jrne	L7641
5110  0d07               L5641:
5111                     ; 1455     if (pSocket->nState == STATE_GOTGET) {
5113  0d07 1e0e          	ldw	x,(OFST+7,sp)
5114  0d09 f6            	ld	a,(x)
5115  0d0a a108          	cp	a,#8
5116  0d0c 2609          	jrne	L3151
5117                     ; 1459       pSocket->nParseLeft = 6;
5119  0d0e a606          	ld	a,#6
5120  0d10 e706          	ld	(6,x),a
5121                     ; 1460       pSocket->ParseState = PARSE_SLASH1;
5123  0d12 e709          	ld	(9,x),a
5124                     ; 1462       pSocket->nState = STATE_PARSEGET;
5126  0d14 a60d          	ld	a,#13
5127  0d16 f7            	ld	(x),a
5128  0d17               L3151:
5129                     ; 1465     if (pSocket->nState == STATE_PARSEPOST) {
5131  0d17 a10a          	cp	a,#10
5132  0d19 2703cc0f89    	jrne	L5151
5134  0d1e cc0f7a        	jra	L1251
5135  0d21               L7151:
5136                     ; 1475         if (pSocket->ParseState == PARSE_CMD) {
5138  0d21 1e0e          	ldw	x,(OFST+7,sp)
5139  0d23 e609          	ld	a,(9,x)
5140  0d25 263e          	jrne	L5251
5141                     ; 1476           pSocket->ParseCmd = *pBuffer;
5143  0d27 1e08          	ldw	x,(OFST+1,sp)
5144  0d29 f6            	ld	a,(x)
5145  0d2a 1e0e          	ldw	x,(OFST+7,sp)
5146  0d2c e707          	ld	(7,x),a
5147                     ; 1477           pSocket->ParseState = PARSE_NUM10;
5149  0d2e a601          	ld	a,#1
5150  0d30 e709          	ld	(9,x),a
5151                     ; 1478 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5153  0d32 e606          	ld	a,(6,x)
5154  0d34 2704          	jreq	L7251
5157  0d36 6a06          	dec	(6,x)
5159  0d38 2004          	jra	L1351
5160  0d3a               L7251:
5161                     ; 1479 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5163  0d3a a605          	ld	a,#5
5164  0d3c e709          	ld	(9,x),a
5165  0d3e               L1351:
5166                     ; 1480           pBuffer++;
5168  0d3e 1e08          	ldw	x,(OFST+1,sp)
5169  0d40 5c            	incw	x
5170  0d41 1f08          	ldw	(OFST+1,sp),x
5171                     ; 1482 	  if (pSocket->ParseCmd == 'o' ||
5171                     ; 1483 	      pSocket->ParseCmd == 'a' ||
5171                     ; 1484 	      pSocket->ParseCmd == 'b' ||
5171                     ; 1485 	      pSocket->ParseCmd == 'c' ||
5171                     ; 1486 	      pSocket->ParseCmd == 'd' ||
5171                     ; 1487 	      pSocket->ParseCmd == 'g') { }
5173  0d43 1e0e          	ldw	x,(OFST+7,sp)
5174  0d45 e607          	ld	a,(7,x)
5175  0d47 a16f          	cp	a,#111
5176  0d49 2603cc0f6c    	jreq	L1551
5178  0d4e a161          	cp	a,#97
5179  0d50 27f9          	jreq	L1551
5181  0d52 a162          	cp	a,#98
5182  0d54 27f5          	jreq	L1551
5184  0d56 a163          	cp	a,#99
5185  0d58 27f1          	jreq	L1551
5187  0d5a a164          	cp	a,#100
5188  0d5c 27ed          	jreq	L1551
5190  0d5e a167          	cp	a,#103
5191  0d60 27e9          	jreq	L1551
5192                     ; 1488 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5193  0d62 cc0f51        	jp	LC018
5194  0d65               L5251:
5195                     ; 1490         else if (pSocket->ParseState == PARSE_NUM10) {
5197  0d65 a101          	cp	a,#1
5198  0d67 2619          	jrne	L3551
5199                     ; 1491           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5201  0d69 1e08          	ldw	x,(OFST+1,sp)
5202  0d6b f6            	ld	a,(x)
5203  0d6c 97            	ld	xl,a
5204  0d6d a60a          	ld	a,#10
5205  0d6f 42            	mul	x,a
5206  0d70 9f            	ld	a,xl
5207  0d71 1e0e          	ldw	x,(OFST+7,sp)
5208  0d73 a0e0          	sub	a,#224
5209  0d75 e708          	ld	(8,x),a
5210                     ; 1492           pSocket->ParseState = PARSE_NUM1;
5212  0d77 a602          	ld	a,#2
5213  0d79 e709          	ld	(9,x),a
5214                     ; 1493 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5216  0d7b e606          	ld	a,(6,x)
5217  0d7d 2719          	jreq	L5651
5220  0d7f cc0f61        	jp	LC025
5221                     ; 1494 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5222                     ; 1495           pBuffer++;
5224  0d82               L3551:
5225                     ; 1497         else if (pSocket->ParseState == PARSE_NUM1) {
5227  0d82 a102          	cp	a,#2
5228  0d84 2616          	jrne	L3651
5229                     ; 1498           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5231  0d86 1608          	ldw	y,(OFST+1,sp)
5232  0d88 90f6          	ld	a,(y)
5233  0d8a a030          	sub	a,#48
5234  0d8c eb08          	add	a,(8,x)
5235  0d8e e708          	ld	(8,x),a
5236                     ; 1499           pSocket->ParseState = PARSE_EQUAL;
5238  0d90 a603          	ld	a,#3
5239  0d92 e709          	ld	(9,x),a
5240                     ; 1500 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5242  0d94 e606          	ld	a,(6,x)
5245  0d96 26e7          	jrne	LC025
5246  0d98               L5651:
5247                     ; 1501 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5250  0d98 a605          	ld	a,#5
5251                     ; 1502           pBuffer++;
5253  0d9a 200d          	jp	LC026
5254  0d9c               L3651:
5255                     ; 1504         else if (pSocket->ParseState == PARSE_EQUAL) {
5257  0d9c a103          	cp	a,#3
5258  0d9e 260e          	jrne	L3751
5259                     ; 1505           pSocket->ParseState = PARSE_VAL;
5261  0da0 a604          	ld	a,#4
5262  0da2 e709          	ld	(9,x),a
5263                     ; 1506 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5265  0da4 6d06          	tnz	(6,x)
5268  0da6 26d7          	jrne	LC025
5269                     ; 1507 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5271  0da8 4c            	inc	a
5272  0da9               LC026:
5273  0da9 e709          	ld	(9,x),a
5274                     ; 1508           pBuffer++;
5276  0dab cc0f63        	jp	LC017
5277  0dae               L3751:
5278                     ; 1510         else if (pSocket->ParseState == PARSE_VAL) {
5280  0dae a104          	cp	a,#4
5281  0db0 2703cc0f57    	jrne	L3061
5282                     ; 1518           if (pSocket->ParseCmd == 'o') {
5284  0db5 e607          	ld	a,(7,x)
5285  0db7 a16f          	cp	a,#111
5286  0db9 2625          	jrne	L5061
5287                     ; 1521             if ((uint8_t)(*pBuffer) == '1') GpioSetPin(pSocket->ParseNum, (uint8_t)1);
5289  0dbb 1e08          	ldw	x,(OFST+1,sp)
5290  0dbd f6            	ld	a,(x)
5291  0dbe a131          	cp	a,#49
5292  0dc0 2609          	jrne	L7061
5295  0dc2 1e0e          	ldw	x,(OFST+7,sp)
5296  0dc4 e608          	ld	a,(8,x)
5297  0dc6 ae0001        	ldw	x,#1
5300  0dc9 2005          	jra	L1161
5301  0dcb               L7061:
5302                     ; 1522             else GpioSetPin(pSocket->ParseNum, (uint8_t)0);
5304  0dcb 1e0e          	ldw	x,(OFST+7,sp)
5305  0dcd e608          	ld	a,(8,x)
5306  0dcf 5f            	clrw	x
5308  0dd0               L1161:
5309  0dd0 95            	ld	xh,a
5310  0dd1 cd13f0        	call	_GpioSetPin
5311                     ; 1523 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5313  0dd4 1e0e          	ldw	x,(OFST+7,sp)
5314  0dd6 e606          	ld	a,(6,x)
5315  0dd8 2603cc0f4a    	jreq	L3661
5317                     ; 1524             pBuffer++;
5319  0ddd cc0f48        	jp	LC024
5320  0de0               L5061:
5321                     ; 1527           else if (pSocket->ParseCmd == 'a') {
5323  0de0 a161          	cp	a,#97
5324  0de2 2656          	jrne	L7161
5325                     ; 1537             ex_stored_devicename[0] = (uint8_t)(*pBuffer);
5327  0de4 1e08          	ldw	x,(OFST+1,sp)
5328  0de6 f6            	ld	a,(x)
5329  0de7 c70000        	ld	_ex_stored_devicename,a
5330                     ; 1538             pSocket->nParseLeft--;
5332  0dea 1e0e          	ldw	x,(OFST+7,sp)
5333  0dec 6a06          	dec	(6,x)
5334                     ; 1539             pBuffer++; // nBytes already decremented for first char
5336  0dee 1e08          	ldw	x,(OFST+1,sp)
5337  0df0 5c            	incw	x
5338  0df1 1f08          	ldw	(OFST+1,sp),x
5339                     ; 1543 	    amp_found = 0;
5341  0df3 0f06          	clr	(OFST-1,sp)
5343                     ; 1544 	    for(i=1; i<20; i++) {
5345  0df5 a601          	ld	a,#1
5346  0df7 6b07          	ld	(OFST+0,sp),a
5348  0df9               L1261:
5349                     ; 1545 	      if((uint8_t)(*pBuffer) == 38) amp_found = 1;
5351  0df9 1e08          	ldw	x,(OFST+1,sp)
5352  0dfb f6            	ld	a,(x)
5353  0dfc a126          	cp	a,#38
5354  0dfe 2604          	jrne	L7261
5357  0e00 a601          	ld	a,#1
5358  0e02 6b06          	ld	(OFST-1,sp),a
5360  0e04               L7261:
5361                     ; 1546 	      if(amp_found == 0) {
5363  0e04 7b06          	ld	a,(OFST-1,sp)
5364  0e06 261a          	jrne	L1361
5365                     ; 1548                 ex_stored_devicename[i] = (uint8_t)(*pBuffer);
5367  0e08 7b07          	ld	a,(OFST+0,sp)
5368  0e0a 5f            	clrw	x
5369  0e0b 1608          	ldw	y,(OFST+1,sp)
5370  0e0d 97            	ld	xl,a
5371  0e0e 90f6          	ld	a,(y)
5372  0e10 d70000        	ld	(_ex_stored_devicename,x),a
5373                     ; 1549                 pSocket->nParseLeft--;
5375  0e13 1e0e          	ldw	x,(OFST+7,sp)
5376  0e15 6a06          	dec	(6,x)
5377                     ; 1550                 pBuffer++;
5379  0e17 93            	ldw	x,y
5380  0e18 5c            	incw	x
5381  0e19 1f08          	ldw	(OFST+1,sp),x
5382                     ; 1551                 nBytes--; // Must subtract 1 from nBytes for extra byte read
5384  0e1b 1e0c          	ldw	x,(OFST+5,sp)
5385  0e1d 5a            	decw	x
5386  0e1e 1f0c          	ldw	(OFST+5,sp),x
5388  0e20 200d          	jra	L3361
5389  0e22               L1361:
5390                     ; 1555 	        ex_stored_devicename[i] = ' ';
5392  0e22 7b07          	ld	a,(OFST+0,sp)
5393  0e24 5f            	clrw	x
5394  0e25 97            	ld	xl,a
5395  0e26 a620          	ld	a,#32
5396  0e28 d70000        	ld	(_ex_stored_devicename,x),a
5397                     ; 1564                 pSocket->nParseLeft--;
5399  0e2b 1e0e          	ldw	x,(OFST+7,sp)
5400  0e2d 6a06          	dec	(6,x)
5401  0e2f               L3361:
5402                     ; 1544 	    for(i=1; i<20; i++) {
5404  0e2f 0c07          	inc	(OFST+0,sp)
5408  0e31 7b07          	ld	a,(OFST+0,sp)
5409  0e33 a114          	cp	a,#20
5410  0e35 25c2          	jrult	L1261
5412  0e37 cc0f4f        	jra	L5161
5413  0e3a               L7161:
5414                     ; 1569           else if (pSocket->ParseCmd == 'b') {
5416  0e3a a162          	cp	a,#98
5417  0e3c 2646          	jrne	L7361
5418                     ; 1576 	    alpha_1 = '-';
5420                     ; 1577 	    alpha_2 = '-';
5422                     ; 1578 	    alpha_3 = '-';
5424                     ; 1580             alpha_1 = (uint8_t)(*pBuffer);
5426  0e3e 1e08          	ldw	x,(OFST+1,sp)
5427  0e40 f6            	ld	a,(x)
5428  0e41 6b07          	ld	(OFST+0,sp),a
5430                     ; 1581             pSocket->nParseLeft--;
5432  0e43 1e0e          	ldw	x,(OFST+7,sp)
5433  0e45 6a06          	dec	(6,x)
5434                     ; 1582             pBuffer++; // nBytes already decremented for first char
5436  0e47 1e08          	ldw	x,(OFST+1,sp)
5437  0e49 5c            	incw	x
5438  0e4a 1f08          	ldw	(OFST+1,sp),x
5439                     ; 1584 	    alpha_2 = (uint8_t)(*pBuffer);
5441  0e4c f6            	ld	a,(x)
5442  0e4d 6b05          	ld	(OFST-2,sp),a
5444                     ; 1585             pSocket->nParseLeft--;
5446  0e4f 1e0e          	ldw	x,(OFST+7,sp)
5447  0e51 6a06          	dec	(6,x)
5448                     ; 1586             pBuffer++;
5450  0e53 1e08          	ldw	x,(OFST+1,sp)
5451  0e55 5c            	incw	x
5452  0e56 1f08          	ldw	(OFST+1,sp),x
5453                     ; 1587 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5455  0e58 1e0c          	ldw	x,(OFST+5,sp)
5456  0e5a 5a            	decw	x
5457  0e5b 1f0c          	ldw	(OFST+5,sp),x
5458                     ; 1589 	    alpha_3 = (uint8_t)(*pBuffer);
5460  0e5d 1e08          	ldw	x,(OFST+1,sp)
5461  0e5f f6            	ld	a,(x)
5462  0e60 6b06          	ld	(OFST-1,sp),a
5464                     ; 1590             pSocket->nParseLeft--;
5466  0e62 1e0e          	ldw	x,(OFST+7,sp)
5467  0e64 6a06          	dec	(6,x)
5468                     ; 1591             pBuffer++;
5470  0e66 1e08          	ldw	x,(OFST+1,sp)
5471  0e68 5c            	incw	x
5472  0e69 1f08          	ldw	(OFST+1,sp),x
5473                     ; 1592 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5475  0e6b 1e0c          	ldw	x,(OFST+5,sp)
5476  0e6d 5a            	decw	x
5477  0e6e 1f0c          	ldw	(OFST+5,sp),x
5478                     ; 1594 	    SetAddresses(pSocket->ParseNum, (uint8_t)alpha_1, (uint8_t)alpha_2, (uint8_t)alpha_3);
5480  0e70 88            	push	a
5481  0e71 7b06          	ld	a,(OFST-1,sp)
5482  0e73 88            	push	a
5483  0e74 7b09          	ld	a,(OFST+2,sp)
5484  0e76 1610          	ldw	y,(OFST+9,sp)
5485  0e78 97            	ld	xl,a
5486  0e79 90e608        	ld	a,(8,y)
5487  0e7c 95            	ld	xh,a
5488  0e7d cd151c        	call	_SetAddresses
5490  0e80 85            	popw	x
5492  0e81 cc0f4f        	jra	L5161
5493  0e84               L7361:
5494                     ; 1597           else if (pSocket->ParseCmd == 'c') {
5496  0e84 a163          	cp	a,#99
5497  0e86 2672          	jrne	L3461
5498                     ; 1603 	    alpha_1 = '-';
5500                     ; 1604 	    alpha_2 = '-';
5502                     ; 1605 	    alpha_3 = '-';
5504                     ; 1606 	    alpha_4 = '-';
5506                     ; 1607 	    alpha_5 = '-';
5508                     ; 1610   	    alpha_1 = (uint8_t)(*pBuffer);
5510  0e88 1e08          	ldw	x,(OFST+1,sp)
5511  0e8a f6            	ld	a,(x)
5512  0e8b 6b07          	ld	(OFST+0,sp),a
5514                     ; 1611             pSocket->nParseLeft--;
5516  0e8d 1e0e          	ldw	x,(OFST+7,sp)
5517  0e8f 6a06          	dec	(6,x)
5518                     ; 1612             pBuffer++; // nBytes already decremented for first char
5520  0e91 1e08          	ldw	x,(OFST+1,sp)
5521  0e93 5c            	incw	x
5522  0e94 1f08          	ldw	(OFST+1,sp),x
5523                     ; 1614 	    alpha_2 = (uint8_t)(*pBuffer);
5525  0e96 f6            	ld	a,(x)
5526  0e97 6b05          	ld	(OFST-2,sp),a
5528                     ; 1615             pSocket->nParseLeft--;
5530  0e99 1e0e          	ldw	x,(OFST+7,sp)
5531  0e9b 6a06          	dec	(6,x)
5532                     ; 1616             pBuffer++;
5534  0e9d 1e08          	ldw	x,(OFST+1,sp)
5535  0e9f 5c            	incw	x
5536  0ea0 1f08          	ldw	(OFST+1,sp),x
5537                     ; 1617 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5539  0ea2 1e0c          	ldw	x,(OFST+5,sp)
5540  0ea4 5a            	decw	x
5541  0ea5 1f0c          	ldw	(OFST+5,sp),x
5542                     ; 1619 	    alpha_3 = (uint8_t)(*pBuffer);
5544  0ea7 1e08          	ldw	x,(OFST+1,sp)
5545  0ea9 f6            	ld	a,(x)
5546  0eaa 6b06          	ld	(OFST-1,sp),a
5548                     ; 1620             pSocket->nParseLeft--;
5550  0eac 1e0e          	ldw	x,(OFST+7,sp)
5551  0eae 6a06          	dec	(6,x)
5552                     ; 1621             pBuffer++;
5554  0eb0 1e08          	ldw	x,(OFST+1,sp)
5555  0eb2 5c            	incw	x
5556  0eb3 1f08          	ldw	(OFST+1,sp),x
5557                     ; 1622 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5559  0eb5 1e0c          	ldw	x,(OFST+5,sp)
5560  0eb7 5a            	decw	x
5561  0eb8 1f0c          	ldw	(OFST+5,sp),x
5562                     ; 1624 	    alpha_4 = (uint8_t)(*pBuffer);
5564  0eba 1e08          	ldw	x,(OFST+1,sp)
5565  0ebc f6            	ld	a,(x)
5566  0ebd 6b03          	ld	(OFST-4,sp),a
5568                     ; 1625             pSocket->nParseLeft--;
5570  0ebf 1e0e          	ldw	x,(OFST+7,sp)
5571  0ec1 6a06          	dec	(6,x)
5572                     ; 1626             pBuffer++;
5574  0ec3 1e08          	ldw	x,(OFST+1,sp)
5575  0ec5 5c            	incw	x
5576  0ec6 1f08          	ldw	(OFST+1,sp),x
5577                     ; 1627 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5579  0ec8 1e0c          	ldw	x,(OFST+5,sp)
5580  0eca 5a            	decw	x
5581  0ecb 1f0c          	ldw	(OFST+5,sp),x
5582                     ; 1629             alpha_5 = (uint8_t)(*pBuffer);
5584  0ecd 1e08          	ldw	x,(OFST+1,sp)
5585  0ecf f6            	ld	a,(x)
5586  0ed0 6b04          	ld	(OFST-3,sp),a
5588                     ; 1630             pSocket->nParseLeft--;
5590  0ed2 1e0e          	ldw	x,(OFST+7,sp)
5591  0ed4 6a06          	dec	(6,x)
5592                     ; 1631             pBuffer++;
5594  0ed6 1e08          	ldw	x,(OFST+1,sp)
5595  0ed8 5c            	incw	x
5596  0ed9 1f08          	ldw	(OFST+1,sp),x
5597                     ; 1632 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5599  0edb 1e0c          	ldw	x,(OFST+5,sp)
5600  0edd 5a            	decw	x
5601  0ede 1f0c          	ldw	(OFST+5,sp),x
5602                     ; 1634 	    SetPort(pSocket->ParseNum,
5602                     ; 1635 	            (uint8_t)alpha_1,
5602                     ; 1636 		    (uint8_t)alpha_2,
5602                     ; 1637 		    (uint8_t)alpha_3,
5602                     ; 1638 		    (uint8_t)alpha_4,
5602                     ; 1639 		    (uint8_t)alpha_5);
5604  0ee0 88            	push	a
5605  0ee1 7b04          	ld	a,(OFST-3,sp)
5606  0ee3 88            	push	a
5607  0ee4 7b08          	ld	a,(OFST+1,sp)
5608  0ee6 88            	push	a
5609  0ee7 7b08          	ld	a,(OFST+1,sp)
5610  0ee9 88            	push	a
5611  0eea 7b0b          	ld	a,(OFST+4,sp)
5612  0eec 1612          	ldw	y,(OFST+11,sp)
5613  0eee 97            	ld	xl,a
5614  0eef 90e608        	ld	a,(8,y)
5615  0ef2 95            	ld	xh,a
5616  0ef3 cd15a6        	call	_SetPort
5618  0ef6 5b04          	addw	sp,#4
5620  0ef8 2055          	jra	L5161
5621  0efa               L3461:
5622                     ; 1642           else if (pSocket->ParseCmd == 'd') {
5624  0efa a164          	cp	a,#100
5625  0efc 262f          	jrne	L7461
5626                     ; 1648 	    alpha_1 = (uint8_t)(*pBuffer);
5628  0efe 1e08          	ldw	x,(OFST+1,sp)
5629  0f00 f6            	ld	a,(x)
5630  0f01 6b07          	ld	(OFST+0,sp),a
5632                     ; 1649             pSocket->nParseLeft--;
5634  0f03 1e0e          	ldw	x,(OFST+7,sp)
5635  0f05 6a06          	dec	(6,x)
5636                     ; 1650             pBuffer++; // nBytes already decremented for first char
5638  0f07 1e08          	ldw	x,(OFST+1,sp)
5639  0f09 5c            	incw	x
5640  0f0a 1f08          	ldw	(OFST+1,sp),x
5641                     ; 1652 	    alpha_2 = (uint8_t)(*pBuffer);
5643  0f0c f6            	ld	a,(x)
5644  0f0d 6b05          	ld	(OFST-2,sp),a
5646                     ; 1653             pSocket->nParseLeft--;
5648  0f0f 1e0e          	ldw	x,(OFST+7,sp)
5649  0f11 6a06          	dec	(6,x)
5650                     ; 1654             pBuffer++;
5652  0f13 1e08          	ldw	x,(OFST+1,sp)
5653  0f15 5c            	incw	x
5654  0f16 1f08          	ldw	(OFST+1,sp),x
5655                     ; 1655 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5657  0f18 1e0c          	ldw	x,(OFST+5,sp)
5658  0f1a 5a            	decw	x
5659  0f1b 1f0c          	ldw	(OFST+5,sp),x
5660                     ; 1657 	    SetMAC(pSocket->ParseNum, alpha_1, alpha_2);
5662  0f1d 88            	push	a
5663  0f1e 7b08          	ld	a,(OFST+1,sp)
5664  0f20 160f          	ldw	y,(OFST+8,sp)
5665  0f22 97            	ld	xl,a
5666  0f23 90e608        	ld	a,(8,y)
5667  0f26 95            	ld	xh,a
5668  0f27 cd15ea        	call	_SetMAC
5670  0f2a 84            	pop	a
5672  0f2b 2022          	jra	L5161
5673  0f2d               L7461:
5674                     ; 1660 	  else if (pSocket->ParseCmd == 'g') {
5676  0f2d a167          	cp	a,#103
5677  0f2f 261e          	jrne	L5161
5678                     ; 1663             if ((uint8_t)(*pBuffer) == '1') invert_output = 1;
5680  0f31 1e08          	ldw	x,(OFST+1,sp)
5681  0f33 f6            	ld	a,(x)
5682  0f34 a131          	cp	a,#49
5683  0f36 2606          	jrne	L5561
5686  0f38 35010000      	mov	_invert_output,#1
5688  0f3c 2004          	jra	L7561
5689  0f3e               L5561:
5690                     ; 1664             else invert_output = 0;
5692  0f3e 725f0000      	clr	_invert_output
5693  0f42               L7561:
5694                     ; 1665 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--;
5696  0f42 1e0e          	ldw	x,(OFST+7,sp)
5697  0f44 e606          	ld	a,(6,x)
5698  0f46 2702          	jreq	L3661
5701  0f48               LC024:
5703  0f48 6a06          	dec	(6,x)
5705  0f4a               L3661:
5706                     ; 1667             pBuffer++;
5709  0f4a 1e08          	ldw	x,(OFST+1,sp)
5710  0f4c 5c            	incw	x
5711  0f4d 1f08          	ldw	(OFST+1,sp),x
5712  0f4f               L5161:
5713                     ; 1670           pSocket->ParseState = PARSE_DELIM;
5715  0f4f 1e0e          	ldw	x,(OFST+7,sp)
5716  0f51               LC018:
5718  0f51 a605          	ld	a,#5
5719  0f53 e709          	ld	(9,x),a
5721  0f55 2015          	jra	L1551
5722  0f57               L3061:
5723                     ; 1673         else if (pSocket->ParseState == PARSE_DELIM) {
5725  0f57 a105          	cp	a,#5
5726  0f59 2611          	jrne	L1551
5727                     ; 1674           if(pSocket->nParseLeft > 0) {
5729  0f5b e606          	ld	a,(6,x)
5730  0f5d 270b          	jreq	L1761
5731                     ; 1675             pSocket->ParseState = PARSE_CMD;
5733  0f5f 6f09          	clr	(9,x)
5734                     ; 1676             pSocket->nParseLeft--;
5736  0f61               LC025:
5740  0f61 6a06          	dec	(6,x)
5741                     ; 1677             pBuffer++;
5743  0f63               LC017:
5747  0f63 1e08          	ldw	x,(OFST+1,sp)
5748  0f65 5c            	incw	x
5749  0f66 1f08          	ldw	(OFST+1,sp),x
5751  0f68 2002          	jra	L1551
5752  0f6a               L1761:
5753                     ; 1680             pSocket->nParseLeft = 0; // Something out of sync - end the parsing
5755  0f6a e706          	ld	(6,x),a
5756  0f6c               L1551:
5757                     ; 1684         if (pSocket->nParseLeft == 0) {
5759  0f6c 1e0e          	ldw	x,(OFST+7,sp)
5760  0f6e e606          	ld	a,(6,x)
5761  0f70 2608          	jrne	L1251
5762                     ; 1686           pSocket->nState = STATE_SENDHEADER;
5764  0f72 a60b          	ld	a,#11
5765  0f74 f7            	ld	(x),a
5766                     ; 1687           break;
5767  0f75               L3251:
5768                     ; 1691       pSocket->nState = STATE_SENDHEADER;
5770  0f75 1e0e          	ldw	x,(OFST+7,sp)
5771  0f77 f7            	ld	(x),a
5772  0f78 200f          	jra	L5151
5773  0f7a               L1251:
5774                     ; 1474       while (nBytes--) {
5776  0f7a 1e0c          	ldw	x,(OFST+5,sp)
5777  0f7c 5a            	decw	x
5778  0f7d 1f0c          	ldw	(OFST+5,sp),x
5779  0f7f 5c            	incw	x
5780  0f80 2703cc0d21    	jrne	L7151
5781  0f85 a60b          	ld	a,#11
5782  0f87 20ec          	jra	L3251
5783  0f89               L5151:
5784                     ; 1694     if (pSocket->nState == STATE_PARSEGET) {
5786  0f89 a10d          	cp	a,#13
5787  0f8b 2703cc123c    	jrne	L7761
5789  0f90 cc1231        	jra	L3071
5790  0f93               L1071:
5791                     ; 1708         if (pSocket->ParseState == PARSE_SLASH1) {
5793  0f93 1e0e          	ldw	x,(OFST+7,sp)
5794  0f95 e609          	ld	a,(9,x)
5795  0f97 a106          	cp	a,#6
5796  0f99 263e          	jrne	L7071
5797                     ; 1711           pSocket->ParseCmd = *pBuffer;
5799  0f9b 1e08          	ldw	x,(OFST+1,sp)
5800  0f9d f6            	ld	a,(x)
5801  0f9e 1e0e          	ldw	x,(OFST+7,sp)
5802  0fa0 e707          	ld	(7,x),a
5803                     ; 1712           pSocket->nParseLeft--;
5805  0fa2 6a06          	dec	(6,x)
5806                     ; 1713           pBuffer++;
5808  0fa4 1e08          	ldw	x,(OFST+1,sp)
5809  0fa6 5c            	incw	x
5810  0fa7 1f08          	ldw	(OFST+1,sp),x
5811                     ; 1714 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5813  0fa9 1e0e          	ldw	x,(OFST+7,sp)
5814  0fab e607          	ld	a,(7,x)
5815  0fad a12f          	cp	a,#47
5816  0faf 2604          	jrne	L1171
5817                     ; 1715 	    pSocket->ParseState = PARSE_NUM10;
5819  0fb1 a601          	ld	a,#1
5820  0fb3 e709          	ld	(9,x),a
5821  0fb5               L1171:
5822                     ; 1717 	  if (pSocket->nParseLeft == 0) {
5824  0fb5 e606          	ld	a,(6,x)
5825  0fb7 2703cc120f    	jrne	L5171
5826                     ; 1719 	    current_webpage = WEBPAGE_DEFAULT;
5828  0fbc c7000b        	ld	_current_webpage,a
5829                     ; 1720             pSocket->pData = g_HtmlPageDefault;
5831  0fbf 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5832  0fc3 ef01          	ldw	(1,x),y
5833                     ; 1721             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5835  0fc5 90ae1879      	ldw	y,#6265
5836  0fc9 ef03          	ldw	(3,x),y
5837                     ; 1722             pSocket->nNewlines = 0;
5839  0fcb e705          	ld	(5,x),a
5840                     ; 1723             pSocket->nState = STATE_SENDHEADER;
5842  0fcd a60b          	ld	a,#11
5843  0fcf f7            	ld	(x),a
5844                     ; 1724             pSocket->nPrevBytes = 0xFFFF;
5846  0fd0 90aeffff      	ldw	y,#65535
5847  0fd4 ef0a          	ldw	(10,x),y
5848                     ; 1725             break;
5850  0fd6 cc123c        	jra	L7761
5851  0fd9               L7071:
5852                     ; 1728         else if (pSocket->ParseState == PARSE_NUM10) {
5854  0fd9 a101          	cp	a,#1
5855  0fdb 264e          	jrne	L7171
5856                     ; 1733 	  if(*pBuffer == ' ') {
5858  0fdd 1e08          	ldw	x,(OFST+1,sp)
5859  0fdf f6            	ld	a,(x)
5860  0fe0 a120          	cp	a,#32
5861  0fe2 2620          	jrne	L1271
5862                     ; 1734 	    current_webpage = WEBPAGE_DEFAULT;
5864  0fe4 725f000b      	clr	_current_webpage
5865                     ; 1735             pSocket->pData = g_HtmlPageDefault;
5867  0fe8 1e0e          	ldw	x,(OFST+7,sp)
5868  0fea 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5869  0fee ef01          	ldw	(1,x),y
5870                     ; 1736             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5872  0ff0 90ae1879      	ldw	y,#6265
5873  0ff4 ef03          	ldw	(3,x),y
5874                     ; 1737             pSocket->nNewlines = 0;
5876  0ff6 6f05          	clr	(5,x)
5877                     ; 1738             pSocket->nState = STATE_SENDHEADER;
5879  0ff8 a60b          	ld	a,#11
5880  0ffa f7            	ld	(x),a
5881                     ; 1739             pSocket->nPrevBytes = 0xFFFF;
5883  0ffb 90aeffff      	ldw	y,#65535
5884  0fff ef0a          	ldw	(10,x),y
5885                     ; 1740 	    break;
5887  1001 cc123c        	jra	L7761
5888  1004               L1271:
5889                     ; 1743 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5891  1004 a130          	cp	a,#48
5892  1006 2504          	jrult	L3271
5894  1008 a13a          	cp	a,#58
5895  100a 2506          	jrult	L5271
5897  100c               L3271:
5898                     ; 1744 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5900  100c 1e0e          	ldw	x,(OFST+7,sp)
5901  100e a605          	ld	a,#5
5902  1010 e709          	ld	(9,x),a
5903  1012               L5271:
5904                     ; 1745           if (pSocket->ParseState == PARSE_NUM10) {      // Still good - parse number
5906  1012 1e0e          	ldw	x,(OFST+7,sp)
5907  1014 e609          	ld	a,(9,x)
5908  1016 4a            	dec	a
5909  1017 26a0          	jrne	L5171
5910                     ; 1746             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5912  1019 1e08          	ldw	x,(OFST+1,sp)
5913  101b f6            	ld	a,(x)
5914  101c 97            	ld	xl,a
5915  101d a60a          	ld	a,#10
5916  101f 42            	mul	x,a
5917  1020 9f            	ld	a,xl
5918  1021 1e0e          	ldw	x,(OFST+7,sp)
5919  1023 a0e0          	sub	a,#224
5920  1025 e708          	ld	(8,x),a
5921                     ; 1747 	    pSocket->ParseState = PARSE_NUM1;
5923  1027 a602          	ld	a,#2
5924                     ; 1748             pSocket->nParseLeft--;
5925                     ; 1749             pBuffer++;
5926  1029 202c          	jp	LC022
5927  102b               L7171:
5928                     ; 1753         else if (pSocket->ParseState == PARSE_NUM1) {
5930  102b a102          	cp	a,#2
5931  102d 2634          	jrne	L3371
5932                     ; 1754 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5934  102f 1e08          	ldw	x,(OFST+1,sp)
5935  1031 f6            	ld	a,(x)
5936  1032 a130          	cp	a,#48
5937  1034 2504          	jrult	L5371
5939  1036 a13a          	cp	a,#58
5940  1038 2506          	jrult	L7371
5942  103a               L5371:
5943                     ; 1755 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5945  103a 1e0e          	ldw	x,(OFST+7,sp)
5946  103c a605          	ld	a,#5
5947  103e e709          	ld	(9,x),a
5948  1040               L7371:
5949                     ; 1756           if (pSocket->ParseState == PARSE_NUM1) {       // Still good - parse number
5951  1040 1e0e          	ldw	x,(OFST+7,sp)
5952  1042 e609          	ld	a,(9,x)
5953  1044 a102          	cp	a,#2
5954  1046 2703cc120f    	jrne	L5171
5955                     ; 1757             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5957  104b 1608          	ldw	y,(OFST+1,sp)
5958  104d 90f6          	ld	a,(y)
5959  104f a030          	sub	a,#48
5960  1051 eb08          	add	a,(8,x)
5961  1053 e708          	ld	(8,x),a
5962                     ; 1758             pSocket->ParseState = PARSE_VAL;
5964  1055 a604          	ld	a,#4
5965                     ; 1759             pSocket->nParseLeft--;
5967                     ; 1760             pBuffer++;
5969  1057               LC022:
5970  1057 e709          	ld	(9,x),a
5972  1059 6a06          	dec	(6,x)
5974  105b 1e08          	ldw	x,(OFST+1,sp)
5975  105d 5c            	incw	x
5976  105e 1f08          	ldw	(OFST+1,sp),x
5977  1060 cc120f        	jra	L5171
5978  1063               L3371:
5979                     ; 1763         else if (pSocket->ParseState == PARSE_VAL) {
5981  1063 a104          	cp	a,#4
5982  1065 2703cc1217    	jrne	L5471
5983                     ; 1814           switch(pSocket->ParseNum)
5985  106a e608          	ld	a,(8,x)
5987                     ; 1938 	      break;
5988  106c a143          	cp	a,#67
5989  106e 2407          	jruge	L272
5990  1070 5f            	clrw	x
5991  1071 97            	ld	xl,a
5992  1072 58            	sllw	x
5993  1073 de4184        	ldw	x,(L472,x)
5994  1076 fc            	jp	(x)
5995  1077               L272:
5996  1077 a05b          	sub	a,#91
5997  1079 2603cc11d3    	jreq	L7321
5998  107e a008          	sub	a,#8
5999  1080 2603cc11d9    	jreq	L1421
6000  1085 cc11ee        	jra	L3421
6001  1088               L7111:
6002                     ; 1816 	    case 0:  Relays_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
6004  1088 72110000      	bres	_Relays_8to1,#0
6007  108c cc1209        	jra	L1571
6008  108f               L1211:
6009                     ; 1817 	    case 1:  Relays_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
6011  108f 72100000      	bset	_Relays_8to1,#0
6014  1093 cc1209        	jra	L1571
6015  1096               L3211:
6016                     ; 1818 	    case 2:  Relays_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
6018  1096 72130000      	bres	_Relays_8to1,#1
6021  109a cc1209        	jra	L1571
6022  109d               L5211:
6023                     ; 1819 	    case 3:  Relays_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
6025  109d 72120000      	bset	_Relays_8to1,#1
6028  10a1 cc1209        	jra	L1571
6029  10a4               L7211:
6030                     ; 1820 	    case 4:  Relays_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
6032  10a4 72150000      	bres	_Relays_8to1,#2
6035  10a8 cc1209        	jra	L1571
6036  10ab               L1311:
6037                     ; 1821 	    case 5:  Relays_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
6039  10ab 72140000      	bset	_Relays_8to1,#2
6042  10af cc1209        	jra	L1571
6043  10b2               L3311:
6044                     ; 1822 	    case 6:  Relays_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
6046  10b2 72170000      	bres	_Relays_8to1,#3
6049  10b6 cc1209        	jra	L1571
6050  10b9               L5311:
6051                     ; 1823 	    case 7:  Relays_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
6053  10b9 72160000      	bset	_Relays_8to1,#3
6056  10bd cc1209        	jra	L1571
6057  10c0               L7311:
6058                     ; 1824 	    case 8:  Relays_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
6060  10c0 72190000      	bres	_Relays_8to1,#4
6063  10c4 cc1209        	jra	L1571
6064  10c7               L1411:
6065                     ; 1825 	    case 9:  Relays_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
6067  10c7 72180000      	bset	_Relays_8to1,#4
6070  10cb cc1209        	jra	L1571
6071  10ce               L3411:
6072                     ; 1826 	    case 10: Relays_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
6074  10ce 721b0000      	bres	_Relays_8to1,#5
6077  10d2 cc1209        	jra	L1571
6078  10d5               L5411:
6079                     ; 1827 	    case 11: Relays_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
6081  10d5 721a0000      	bset	_Relays_8to1,#5
6084  10d9 cc1209        	jra	L1571
6085  10dc               L7411:
6086                     ; 1828 	    case 12: Relays_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
6088  10dc 721d0000      	bres	_Relays_8to1,#6
6091  10e0 cc1209        	jra	L1571
6092  10e3               L1511:
6093                     ; 1829 	    case 13: Relays_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
6095  10e3 721c0000      	bset	_Relays_8to1,#6
6098  10e7 cc1209        	jra	L1571
6099  10ea               L3511:
6100                     ; 1830 	    case 14: Relays_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
6102  10ea 721f0000      	bres	_Relays_8to1,#7
6105  10ee cc1209        	jra	L1571
6106  10f1               L5511:
6107                     ; 1831 	    case 15: Relays_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
6109  10f1 721e0000      	bset	_Relays_8to1,#7
6112  10f5 cc1209        	jra	L1571
6113  10f8               L7511:
6114                     ; 1832 	    case 16: Relays_16to9 &= (uint8_t)(~0x01); break; // Relay-09 OFF
6116  10f8 72110000      	bres	_Relays_16to9,#0
6119  10fc cc1209        	jra	L1571
6120  10ff               L1611:
6121                     ; 1833 	    case 17: Relays_16to9 |= (uint8_t)0x01;    break; // Relay-09 ON
6123  10ff 72100000      	bset	_Relays_16to9,#0
6126  1103 cc1209        	jra	L1571
6127  1106               L3611:
6128                     ; 1834 	    case 18: Relays_16to9 &= (uint8_t)(~0x02); break; // Relay-10 OFF
6130  1106 72130000      	bres	_Relays_16to9,#1
6133  110a cc1209        	jra	L1571
6134  110d               L5611:
6135                     ; 1835 	    case 19: Relays_16to9 |= (uint8_t)0x02;    break; // Relay-10 ON
6137  110d 72120000      	bset	_Relays_16to9,#1
6140  1111 cc1209        	jra	L1571
6141  1114               L7611:
6142                     ; 1836 	    case 20: Relays_16to9 &= (uint8_t)(~0x04); break; // Relay-11 OFF
6144  1114 72150000      	bres	_Relays_16to9,#2
6147  1118 cc1209        	jra	L1571
6148  111b               L1711:
6149                     ; 1837 	    case 21: Relays_16to9 |= (uint8_t)0x04;    break; // Relay-11 ON
6151  111b 72140000      	bset	_Relays_16to9,#2
6154  111f cc1209        	jra	L1571
6155  1122               L3711:
6156                     ; 1838 	    case 22: Relays_16to9 &= (uint8_t)(~0x08); break; // Relay-12 OFF
6158  1122 72170000      	bres	_Relays_16to9,#3
6161  1126 cc1209        	jra	L1571
6162  1129               L5711:
6163                     ; 1839 	    case 23: Relays_16to9 |= (uint8_t)0x08;    break; // Relay-12 ON
6165  1129 72160000      	bset	_Relays_16to9,#3
6168  112d cc1209        	jra	L1571
6169  1130               L7711:
6170                     ; 1840 	    case 24: Relays_16to9 &= (uint8_t)(~0x10); break; // Relay-13 OFF
6172  1130 72190000      	bres	_Relays_16to9,#4
6175  1134 cc1209        	jra	L1571
6176  1137               L1021:
6177                     ; 1841 	    case 25: Relays_16to9 |= (uint8_t)0x10;    break; // Relay-13 ON
6179  1137 72180000      	bset	_Relays_16to9,#4
6182  113b cc1209        	jra	L1571
6183  113e               L3021:
6184                     ; 1842 	    case 26: Relays_16to9 &= (uint8_t)(~0x20); break; // Relay-14 OFF
6186  113e 721b0000      	bres	_Relays_16to9,#5
6189  1142 cc1209        	jra	L1571
6190  1145               L5021:
6191                     ; 1843 	    case 27: Relays_16to9 |= (uint8_t)0x20;    break; // Relay-14 ON
6193  1145 721a0000      	bset	_Relays_16to9,#5
6196  1149 cc1209        	jra	L1571
6197  114c               L7021:
6198                     ; 1844 	    case 28: Relays_16to9 &= (uint8_t)(~0x40); break; // Relay-15 OFF
6200  114c 721d0000      	bres	_Relays_16to9,#6
6203  1150 cc1209        	jra	L1571
6204  1153               L1121:
6205                     ; 1845 	    case 29: Relays_16to9 |= (uint8_t)0x40;    break; // Relay-15 ON
6207  1153 721c0000      	bset	_Relays_16to9,#6
6210  1157 cc1209        	jra	L1571
6211  115a               L3121:
6212                     ; 1846 	    case 30: Relays_16to9 &= (uint8_t)(~0x80); break; // Relay-16 OFF
6214  115a 721f0000      	bres	_Relays_16to9,#7
6217  115e cc1209        	jra	L1571
6218  1161               L5121:
6219                     ; 1847 	    case 31: Relays_16to9 |= (uint8_t)0x80;    break; // Relay-16 ON
6221  1161 721e0000      	bset	_Relays_16to9,#7
6224  1165 cc1209        	jra	L1571
6225  1168               L7121:
6226                     ; 1848 	    case 55:
6226                     ; 1849   	      Relays_8to1 = (uint8_t)0xff; // Relays 1-8 ON
6228  1168 35ff0000      	mov	_Relays_8to1,#255
6229                     ; 1850   	      Relays_16to9 = (uint8_t)0xff; // Relays 9-16 ON
6231  116c 35ff0000      	mov	_Relays_16to9,#255
6232                     ; 1851 	      break;
6234  1170 cc1209        	jra	L1571
6235  1173               L1221:
6236                     ; 1852 	    case 56:
6236                     ; 1853               Relays_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
6238  1173 725f0000      	clr	_Relays_8to1
6239                     ; 1854               Relays_16to9 = (uint8_t)0x00; // Relays 9-16 OFF
6241  1177 725f0000      	clr	_Relays_16to9
6242                     ; 1855 	      break;
6244  117b cc1209        	jra	L1571
6245  117e               L3221:
6246                     ; 1857 	    case 60: // Show relay states page
6246                     ; 1858 	      current_webpage = WEBPAGE_DEFAULT;
6247                     ; 1859               pSocket->pData = g_HtmlPageDefault;
6248                     ; 1860               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6249                     ; 1861               pSocket->nNewlines = 0;
6250                     ; 1862               pSocket->nState = STATE_CONNECTED;
6251                     ; 1863               pSocket->nPrevBytes = 0xFFFF;
6252                     ; 1864 	      break;
6254  117e 206e          	jp	L3421
6255  1180               L5221:
6256                     ; 1866 	    case 61: // Show address settings page
6256                     ; 1867 	      current_webpage = WEBPAGE_ADDRESS;
6258  1180 3501000b      	mov	_current_webpage,#1
6259                     ; 1868               pSocket->pData = g_HtmlPageAddress;
6261  1184 1e0e          	ldw	x,(OFST+7,sp)
6262  1186 90ae1882      	ldw	y,#L71_g_HtmlPageAddress
6263  118a ef01          	ldw	(1,x),y
6264                     ; 1869               pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
6266  118c 90ae133d      	ldw	y,#4925
6267                     ; 1870               pSocket->nNewlines = 0;
6268                     ; 1871               pSocket->nState = STATE_CONNECTED;
6269                     ; 1872               pSocket->nPrevBytes = 0xFFFF;
6270                     ; 1873 	      break;
6272  1190 206c          	jp	LC020
6273  1192               L7221:
6274                     ; 1876 	    case 63: // Show help page 1
6274                     ; 1877 	      current_webpage = WEBPAGE_HELP;
6276  1192 3503000b      	mov	_current_webpage,#3
6277                     ; 1878               pSocket->pData = g_HtmlPageHelp;
6279  1196 1e0e          	ldw	x,(OFST+7,sp)
6280  1198 90ae2bc0      	ldw	y,#L12_g_HtmlPageHelp
6281  119c ef01          	ldw	(1,x),y
6282                     ; 1879               pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
6284  119e 90ae0756      	ldw	y,#1878
6285                     ; 1880               pSocket->nNewlines = 0;
6286                     ; 1881               pSocket->nState = STATE_CONNECTED;
6287                     ; 1882               pSocket->nPrevBytes = 0xFFFF;
6288                     ; 1883 	      break;
6290  11a2 205a          	jp	LC020
6291  11a4               L1321:
6292                     ; 1885 	    case 64: // Show help page 2
6292                     ; 1886 	      current_webpage = WEBPAGE_HELP2;
6294  11a4 3504000b      	mov	_current_webpage,#4
6295                     ; 1887               pSocket->pData = g_HtmlPageHelp2;
6297  11a8 1e0e          	ldw	x,(OFST+7,sp)
6298  11aa 90ae3317      	ldw	y,#L32_g_HtmlPageHelp2
6299  11ae ef01          	ldw	(1,x),y
6300                     ; 1888               pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
6302  11b0 90ae02b7      	ldw	y,#695
6303                     ; 1889               pSocket->nNewlines = 0;
6304                     ; 1890               pSocket->nState = STATE_CONNECTED;
6305                     ; 1891               pSocket->nPrevBytes = 0xFFFF;
6306                     ; 1892 	      break;
6308  11b4 2048          	jp	LC020
6309  11b6               L3321:
6310                     ; 1895 	    case 65: // Flash LED for diagnostics
6310                     ; 1896 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6310                     ; 1897 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6310                     ; 1898 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6310                     ; 1899 	      debugflash();
6312  11b6 cd0000        	call	_debugflash
6314                     ; 1900 	      debugflash();
6316  11b9 cd0000        	call	_debugflash
6318                     ; 1901 	      debugflash();
6320  11bc cd0000        	call	_debugflash
6322                     ; 1905 	      break;
6324  11bf 2048          	jra	L1571
6325  11c1               L5321:
6326                     ; 1908             case 66: // Show statistics page
6326                     ; 1909 	      current_webpage = WEBPAGE_STATS;
6328  11c1 3505000b      	mov	_current_webpage,#5
6329                     ; 1910               pSocket->pData = g_HtmlPageStats;
6331  11c5 1e0e          	ldw	x,(OFST+7,sp)
6332  11c7 90ae35cf      	ldw	y,#L52_g_HtmlPageStats
6333  11cb ef01          	ldw	(1,x),y
6334                     ; 1911               pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
6336  11cd 90ae0ae8      	ldw	y,#2792
6337                     ; 1912               pSocket->nNewlines = 0;
6338                     ; 1913               pSocket->nState = STATE_CONNECTED;
6339                     ; 1914               pSocket->nPrevBytes = 0xFFFF;
6340                     ; 1915 	      break;
6342  11d1 202b          	jp	LC020
6343  11d3               L7321:
6344                     ; 1918 	    case 91: // Reboot
6344                     ; 1919 	      submit_changes = 2;
6346  11d3 35020000      	mov	_submit_changes,#2
6347                     ; 1920 	      break;
6349  11d7 2030          	jra	L1571
6350  11d9               L1421:
6351                     ; 1922             case 99: // Show simplified relay state page
6351                     ; 1923 	      current_webpage = WEBPAGE_RSTATE;
6353  11d9 3506000b      	mov	_current_webpage,#6
6354                     ; 1924               pSocket->pData = g_HtmlPageRstate;
6356  11dd 90ae40b8      	ldw	y,#L72_g_HtmlPageRstate
6357  11e1 ef01          	ldw	(1,x),y
6358                     ; 1925               pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
6360  11e3 90ae0087      	ldw	y,#135
6361  11e7 ef03          	ldw	(3,x),y
6362                     ; 1926               pSocket->nNewlines = 0;
6364  11e9 e705          	ld	(5,x),a
6365                     ; 1927               pSocket->nState = STATE_CONNECTED;
6367  11eb f7            	ld	(x),a
6368                     ; 1928               pSocket->nPrevBytes = 0xFFFF;
6369                     ; 1929 	      break;
6371  11ec 2015          	jp	LC019
6372  11ee               L3421:
6373                     ; 1931 	    default: // Show relay state page
6373                     ; 1932 	      current_webpage = WEBPAGE_DEFAULT;
6375                     ; 1933               pSocket->pData = g_HtmlPageDefault;
6377                     ; 1934               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6380  11ee 725f000b      	clr	_current_webpage
6382  11f2 1e0e          	ldw	x,(OFST+7,sp)
6383  11f4 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
6384  11f8 ef01          	ldw	(1,x),y
6386  11fa 90ae1879      	ldw	y,#6265
6387                     ; 1935               pSocket->nNewlines = 0;
6389                     ; 1936               pSocket->nState = STATE_CONNECTED;
6391  11fe               LC020:
6392  11fe ef03          	ldw	(3,x),y
6398  1200 6f05          	clr	(5,x)
6404  1202 7f            	clr	(x)
6405                     ; 1937               pSocket->nPrevBytes = 0xFFFF;
6407  1203               LC019:
6414  1203 90aeffff      	ldw	y,#65535
6415  1207 ef0a          	ldw	(10,x),y
6416                     ; 1938 	      break;
6418  1209               L1571:
6419                     ; 1940           pSocket->ParseState = PARSE_DELIM;
6421  1209 1e0e          	ldw	x,(OFST+7,sp)
6422  120b a605          	ld	a,#5
6423  120d e709          	ld	(9,x),a
6425  120f               L5171:
6426                     ; 1954         if (pSocket->nParseLeft == 0) {
6428  120f 1e0e          	ldw	x,(OFST+7,sp)
6429  1211 e606          	ld	a,(6,x)
6430  1213 261c          	jrne	L3071
6431                     ; 1956           pSocket->nState = STATE_SENDHEADER;
6432                     ; 1957           break;
6434  1215 2015          	jp	LC023
6435  1217               L5471:
6436                     ; 1943         else if (pSocket->ParseState == PARSE_DELIM) {
6438  1217 a105          	cp	a,#5
6439  1219 26f4          	jrne	L5171
6440                     ; 1945           pSocket->ParseState = PARSE_DELIM;
6442  121b a605          	ld	a,#5
6443  121d e709          	ld	(9,x),a
6444                     ; 1946           pSocket->nParseLeft--;
6446  121f 6a06          	dec	(6,x)
6447                     ; 1947           pBuffer++;
6449  1221 1e08          	ldw	x,(OFST+1,sp)
6450  1223 5c            	incw	x
6451  1224 1f08          	ldw	(OFST+1,sp),x
6452                     ; 1948 	  if (pSocket->nParseLeft == 0) {
6454  1226 1e0e          	ldw	x,(OFST+7,sp)
6455  1228 e606          	ld	a,(6,x)
6456  122a 26e3          	jrne	L5171
6457                     ; 1950             pSocket->nState = STATE_SENDHEADER;
6459  122c               LC023:
6461  122c a60b          	ld	a,#11
6462  122e f7            	ld	(x),a
6463                     ; 1951             break;
6465  122f 200b          	jra	L7761
6466  1231               L3071:
6467                     ; 1707       while (nBytes--) {
6469  1231 1e0c          	ldw	x,(OFST+5,sp)
6470  1233 5a            	decw	x
6471  1234 1f0c          	ldw	(OFST+5,sp),x
6472  1236 5c            	incw	x
6473  1237 2703cc0f93    	jrne	L1071
6474  123c               L7761:
6475                     ; 1962     if (pSocket->nState == STATE_SENDHEADER) {
6477  123c 1e0e          	ldw	x,(OFST+7,sp)
6478  123e f6            	ld	a,(x)
6479  123f a10b          	cp	a,#11
6480  1241 2623          	jrne	L3671
6481                     ; 1963       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6483  1243 ee03          	ldw	x,(3,x)
6484  1245 cd0000        	call	c_uitolx
6486  1248 be02          	ldw	x,c_lreg+2
6487  124a 89            	pushw	x
6488  124b be00          	ldw	x,c_lreg
6489  124d 89            	pushw	x
6490  124e ce0000        	ldw	x,_uip_appdata
6491  1251 cd0231        	call	L7_CopyHttpHeader
6493  1254 5b04          	addw	sp,#4
6494  1256 89            	pushw	x
6495  1257 ce0000        	ldw	x,_uip_appdata
6496  125a cd0000        	call	_uip_send
6498  125d 85            	popw	x
6499                     ; 1964       pSocket->nState = STATE_SENDDATA;
6501  125e 1e0e          	ldw	x,(OFST+7,sp)
6502  1260 a60c          	ld	a,#12
6503  1262 f7            	ld	(x),a
6504                     ; 1965       return;
6506  1263 cc0bd7        	jra	L613
6507  1266               L3671:
6508                     ; 1968     if (pSocket->nState == STATE_SENDDATA) {
6510  1266 a10c          	cp	a,#12
6511  1268 26f9          	jrne	L613
6512                     ; 1972       pSocket->nPrevBytes = pSocket->nDataLeft;
6514  126a 9093          	ldw	y,x
6515  126c 90ee03        	ldw	y,(3,y)
6516  126f ef0a          	ldw	(10,x),y
6517                     ; 1973       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6519  1271 ce0000        	ldw	x,_uip_conn
6520  1274 ee12          	ldw	x,(18,x)
6521  1276 89            	pushw	x
6522  1277 1e10          	ldw	x,(OFST+9,sp)
6523  1279 1c0003        	addw	x,#3
6524  127c 89            	pushw	x
6525  127d 1e12          	ldw	x,(OFST+11,sp)
6526  127f 5c            	incw	x
6527  1280 89            	pushw	x
6528  1281 ce0000        	ldw	x,_uip_appdata
6529  1284 cd02c9        	call	L11_CopyHttpData
6531  1287 5b06          	addw	sp,#6
6532  1289 1f01          	ldw	(OFST-6,sp),x
6534                     ; 1974       pSocket->nPrevBytes -= pSocket->nDataLeft;
6536  128b 1e0e          	ldw	x,(OFST+7,sp)
6537  128d e60b          	ld	a,(11,x)
6538  128f e004          	sub	a,(4,x)
6539  1291 e70b          	ld	(11,x),a
6540  1293 e60a          	ld	a,(10,x)
6541  1295 e203          	sbc	a,(3,x)
6542  1297 e70a          	ld	(10,x),a
6543                     ; 1976       if (nBufSize == 0) {
6545  1299 1e01          	ldw	x,(OFST-6,sp)
6546  129b 262d          	jrne	LC014
6547                     ; 1978         uip_close();
6549  129d               LC015:
6551  129d 35100000      	mov	_uip_flags,#16
6553  12a1 cc0bd7        	jra	L613
6554                     ; 1982         uip_send(uip_appdata, nBufSize);
6556                     ; 1984       return;
6558  12a4               L5731:
6559                     ; 1988   else if (uip_rexmit()) {
6561  12a4 7204000003cc  	btjf	_uip_flags,#2,L3731
6562                     ; 1989     if (pSocket->nPrevBytes == 0xFFFF) {
6564  12ac 160e          	ldw	y,(OFST+7,sp)
6565  12ae 90ee0a        	ldw	y,(10,y)
6566  12b1 905c          	incw	y
6567  12b3 2620          	jrne	L7771
6568                     ; 1991       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6570  12b5 1e0e          	ldw	x,(OFST+7,sp)
6571  12b7 ee03          	ldw	x,(3,x)
6572  12b9 cd0000        	call	c_uitolx
6574  12bc be02          	ldw	x,c_lreg+2
6575  12be 89            	pushw	x
6576  12bf be00          	ldw	x,c_lreg
6577  12c1 89            	pushw	x
6578  12c2 ce0000        	ldw	x,_uip_appdata
6579  12c5 cd0231        	call	L7_CopyHttpHeader
6581  12c8 5b04          	addw	sp,#4
6583  12ca               LC014:
6585  12ca 89            	pushw	x
6586  12cb ce0000        	ldw	x,_uip_appdata
6587  12ce cd0000        	call	_uip_send
6588  12d1 85            	popw	x
6590  12d2 cc0bd7        	jra	L613
6591  12d5               L7771:
6592                     ; 1994       pSocket->pData -= pSocket->nPrevBytes;
6594  12d5 1e0e          	ldw	x,(OFST+7,sp)
6595  12d7 e602          	ld	a,(2,x)
6596  12d9 e00b          	sub	a,(11,x)
6597  12db e702          	ld	(2,x),a
6598  12dd e601          	ld	a,(1,x)
6599  12df e20a          	sbc	a,(10,x)
6600  12e1 e701          	ld	(1,x),a
6601                     ; 1995       pSocket->nDataLeft += pSocket->nPrevBytes;
6603  12e3 e604          	ld	a,(4,x)
6604  12e5 eb0b          	add	a,(11,x)
6605  12e7 e704          	ld	(4,x),a
6606  12e9 e603          	ld	a,(3,x)
6607  12eb e90a          	adc	a,(10,x)
6608                     ; 1996       pSocket->nPrevBytes = pSocket->nDataLeft;
6610  12ed 9093          	ldw	y,x
6611  12ef e703          	ld	(3,x),a
6612  12f1 90ee03        	ldw	y,(3,y)
6613  12f4 ef0a          	ldw	(10,x),y
6614                     ; 1997       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6616  12f6 ce0000        	ldw	x,_uip_conn
6617  12f9 ee12          	ldw	x,(18,x)
6618  12fb 89            	pushw	x
6619  12fc 1e10          	ldw	x,(OFST+9,sp)
6620  12fe 1c0003        	addw	x,#3
6621  1301 89            	pushw	x
6622  1302 1e12          	ldw	x,(OFST+11,sp)
6623  1304 5c            	incw	x
6624  1305 89            	pushw	x
6625  1306 ce0000        	ldw	x,_uip_appdata
6626  1309 cd02c9        	call	L11_CopyHttpData
6628  130c 5b06          	addw	sp,#6
6629  130e 1f01          	ldw	(OFST-6,sp),x
6631                     ; 1998       pSocket->nPrevBytes -= pSocket->nDataLeft;
6633  1310 1e0e          	ldw	x,(OFST+7,sp)
6634  1312 e60b          	ld	a,(11,x)
6635  1314 e004          	sub	a,(4,x)
6636  1316 e70b          	ld	(11,x),a
6637  1318 e60a          	ld	a,(10,x)
6638  131a e203          	sbc	a,(3,x)
6639  131c e70a          	ld	(10,x),a
6640                     ; 1999       if (nBufSize == 0) {
6642  131e 1e01          	ldw	x,(OFST-6,sp)
6643                     ; 2001         uip_close();
6645  1320 2603cc129d    	jreq	LC015
6646                     ; 2005         uip_send(uip_appdata, nBufSize);
6648  1325 89            	pushw	x
6649  1326 ce0000        	ldw	x,_uip_appdata
6650  1329 cd0000        	call	_uip_send
6652  132c 85            	popw	x
6653                     ; 2008     return;
6655  132d               L3731:
6656                     ; 2010 }
6658  132d cc0bd7        	jra	L613
6692                     ; 2013 uint8_t GpioGetPin(uint8_t nGpio)
6692                     ; 2014 {
6693                     	switch	.text
6694  1330               _GpioGetPin:
6696       00000000      OFST:	set	0
6699                     ; 2016   if(nGpio == 0       && (Relays_8to1  & (uint8_t)(0x01))) return 1; // Relay-01 is ON
6701  1330 4d            	tnz	a
6702  1331 2607          	jrne	L3202
6704  1333 7201000002    	btjf	_Relays_8to1,#0,L3202
6707  1338 4c            	inc	a
6710  1339 81            	ret	
6711  133a               L3202:
6712                     ; 2017   else if(nGpio == 1  && (Relays_8to1  & (uint8_t)(0x02))) return 1; // Relay-02 is ON
6714  133a a101          	cp	a,#1
6715  133c 2608          	jrne	L7202
6717  133e 7203000003    	btjf	_Relays_8to1,#1,L7202
6720  1343 a601          	ld	a,#1
6723  1345 81            	ret	
6724  1346               L7202:
6725                     ; 2018   else if(nGpio == 2  && (Relays_8to1  & (uint8_t)(0x04))) return 1; // Relay-03 is ON
6727  1346 a102          	cp	a,#2
6728  1348 2608          	jrne	L3302
6730  134a 7205000003    	btjf	_Relays_8to1,#2,L3302
6733  134f a601          	ld	a,#1
6736  1351 81            	ret	
6737  1352               L3302:
6738                     ; 2019   else if(nGpio == 3  && (Relays_8to1  & (uint8_t)(0x08))) return 1; // Relay-04 is ON
6740  1352 a103          	cp	a,#3
6741  1354 2608          	jrne	L7302
6743  1356 7207000003    	btjf	_Relays_8to1,#3,L7302
6746  135b a601          	ld	a,#1
6749  135d 81            	ret	
6750  135e               L7302:
6751                     ; 2020   else if(nGpio == 4  && (Relays_8to1  & (uint8_t)(0x10))) return 1; // Relay-05 is ON
6753  135e a104          	cp	a,#4
6754  1360 2608          	jrne	L3402
6756  1362 7209000003    	btjf	_Relays_8to1,#4,L3402
6759  1367 a601          	ld	a,#1
6762  1369 81            	ret	
6763  136a               L3402:
6764                     ; 2021   else if(nGpio == 5  && (Relays_8to1  & (uint8_t)(0x20))) return 1; // Relay-06 is ON
6766  136a a105          	cp	a,#5
6767  136c 2608          	jrne	L7402
6769  136e 720b000003    	btjf	_Relays_8to1,#5,L7402
6772  1373 a601          	ld	a,#1
6775  1375 81            	ret	
6776  1376               L7402:
6777                     ; 2022   else if(nGpio == 6  && (Relays_8to1  & (uint8_t)(0x40))) return 1; // Relay-07 is ON
6779  1376 a106          	cp	a,#6
6780  1378 2608          	jrne	L3502
6782  137a 720d000003    	btjf	_Relays_8to1,#6,L3502
6785  137f a601          	ld	a,#1
6788  1381 81            	ret	
6789  1382               L3502:
6790                     ; 2023   else if(nGpio == 7  && (Relays_8to1  & (uint8_t)(0x80))) return 1; // Relay-08 is ON
6792  1382 a107          	cp	a,#7
6793  1384 2608          	jrne	L7502
6795  1386 720f000003    	btjf	_Relays_8to1,#7,L7502
6798  138b a601          	ld	a,#1
6801  138d 81            	ret	
6802  138e               L7502:
6803                     ; 2024   else if(nGpio == 8  && (Relays_16to9 & (uint8_t)(0x01))) return 1; // Relay-09 is ON
6805  138e a108          	cp	a,#8
6806  1390 2608          	jrne	L3602
6808  1392 7201000003    	btjf	_Relays_16to9,#0,L3602
6811  1397 a601          	ld	a,#1
6814  1399 81            	ret	
6815  139a               L3602:
6816                     ; 2025   else if(nGpio == 9  && (Relays_16to9 & (uint8_t)(0x02))) return 1; // Relay-10 is ON
6818  139a a109          	cp	a,#9
6819  139c 2608          	jrne	L7602
6821  139e 7203000003    	btjf	_Relays_16to9,#1,L7602
6824  13a3 a601          	ld	a,#1
6827  13a5 81            	ret	
6828  13a6               L7602:
6829                     ; 2026   else if(nGpio == 10 && (Relays_16to9 & (uint8_t)(0x04))) return 1; // Relay-11 is ON
6831  13a6 a10a          	cp	a,#10
6832  13a8 2608          	jrne	L3702
6834  13aa 7205000003    	btjf	_Relays_16to9,#2,L3702
6837  13af a601          	ld	a,#1
6840  13b1 81            	ret	
6841  13b2               L3702:
6842                     ; 2027   else if(nGpio == 11 && (Relays_16to9 & (uint8_t)(0x08))) return 1; // Relay-12 is ON
6844  13b2 a10b          	cp	a,#11
6845  13b4 2608          	jrne	L7702
6847  13b6 7207000003    	btjf	_Relays_16to9,#3,L7702
6850  13bb a601          	ld	a,#1
6853  13bd 81            	ret	
6854  13be               L7702:
6855                     ; 2028   else if(nGpio == 12 && (Relays_16to9 & (uint8_t)(0x10))) return 1; // Relay-13 is ON
6857  13be a10c          	cp	a,#12
6858  13c0 2608          	jrne	L3012
6860  13c2 7209000003    	btjf	_Relays_16to9,#4,L3012
6863  13c7 a601          	ld	a,#1
6866  13c9 81            	ret	
6867  13ca               L3012:
6868                     ; 2029   else if(nGpio == 13 && (Relays_16to9 & (uint8_t)(0x20))) return 1; // Relay-14 is ON
6870  13ca a10d          	cp	a,#13
6871  13cc 2608          	jrne	L7012
6873  13ce 720b000003    	btjf	_Relays_16to9,#5,L7012
6876  13d3 a601          	ld	a,#1
6879  13d5 81            	ret	
6880  13d6               L7012:
6881                     ; 2030   else if(nGpio == 14 && (Relays_16to9 & (uint8_t)(0x40))) return 1; // Relay-15 is ON
6883  13d6 a10e          	cp	a,#14
6884  13d8 2608          	jrne	L3112
6886  13da 720d000003    	btjf	_Relays_16to9,#6,L3112
6889  13df a601          	ld	a,#1
6892  13e1 81            	ret	
6893  13e2               L3112:
6894                     ; 2031   else if(nGpio == 15 && (Relays_16to9 & (uint8_t)(0x80))) return 1; // Relay-16 is ON
6896  13e2 a10f          	cp	a,#15
6897  13e4 2608          	jrne	L5202
6899  13e6 720f000003    	btjf	_Relays_16to9,#7,L5202
6902  13eb a601          	ld	a,#1
6905  13ed 81            	ret	
6906  13ee               L5202:
6907                     ; 2032   return 0;
6909  13ee 4f            	clr	a
6912  13ef 81            	ret	
6953                     	switch	.const
6954  420a               L623:
6955  420a 140d          	dc.w	L1212
6956  420c 141f          	dc.w	L3212
6957  420e 1431          	dc.w	L5212
6958  4210 1443          	dc.w	L7212
6959  4212 1455          	dc.w	L1312
6960  4214 1467          	dc.w	L3312
6961  4216 1479          	dc.w	L5312
6962  4218 148b          	dc.w	L7312
6963  421a 149c          	dc.w	L1412
6964  421c 14ac          	dc.w	L3412
6965  421e 14bc          	dc.w	L5412
6966  4220 14cc          	dc.w	L7412
6967  4222 14dc          	dc.w	L1512
6968  4224 14ec          	dc.w	L3512
6969  4226 14fc          	dc.w	L5512
6970  4228 150c          	dc.w	L7512
6971                     ; 2036 void GpioSetPin(uint8_t nGpio, uint8_t nState)
6971                     ; 2037 {
6972                     	switch	.text
6973  13f0               _GpioSetPin:
6975  13f0 89            	pushw	x
6976       00000000      OFST:	set	0
6979                     ; 2041   if(nState != 0 && nState != 1) nState = 1;
6981  13f1 9f            	ld	a,xl
6982  13f2 4d            	tnz	a
6983  13f3 2708          	jreq	L1022
6985  13f5 9f            	ld	a,xl
6986  13f6 4a            	dec	a
6987  13f7 2704          	jreq	L1022
6990  13f9 a601          	ld	a,#1
6991  13fb 6b02          	ld	(OFST+2,sp),a
6992  13fd               L1022:
6993                     ; 2043   switch(nGpio)
6995  13fd 7b01          	ld	a,(OFST+1,sp)
6997                     ; 2109   default: break;
6998  13ff a110          	cp	a,#16
6999  1401 2503cc151a    	jruge	L5022
7000  1406 5f            	clrw	x
7001  1407 97            	ld	xl,a
7002  1408 58            	sllw	x
7003  1409 de420a        	ldw	x,(L623,x)
7004  140c fc            	jp	(x)
7005  140d               L1212:
7006                     ; 2045   case 0:
7006                     ; 2046     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x01); // Relay-01 OFF
7008  140d 7b02          	ld	a,(OFST+2,sp)
7009  140f 2607          	jrne	L7022
7012  1411 72110000      	bres	_Relays_8to1,#0
7014  1415 cc151a        	jra	L5022
7015  1418               L7022:
7016                     ; 2047     else Relays_8to1 |= (uint8_t)0x01; // Relay-01 ON
7018  1418 72100000      	bset	_Relays_8to1,#0
7019  141c cc151a        	jra	L5022
7020  141f               L3212:
7021                     ; 2049   case 1:
7021                     ; 2050     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x02); // Relay-02 OFF
7023  141f 7b02          	ld	a,(OFST+2,sp)
7024  1421 2607          	jrne	L3122
7027  1423 72130000      	bres	_Relays_8to1,#1
7029  1427 cc151a        	jra	L5022
7030  142a               L3122:
7031                     ; 2051     else Relays_8to1 |= (uint8_t)0x02; // Relay-02 ON
7033  142a 72120000      	bset	_Relays_8to1,#1
7034  142e cc151a        	jra	L5022
7035  1431               L5212:
7036                     ; 2053   case 2:
7036                     ; 2054     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x04); // Relay-03 OFF
7038  1431 7b02          	ld	a,(OFST+2,sp)
7039  1433 2607          	jrne	L7122
7042  1435 72150000      	bres	_Relays_8to1,#2
7044  1439 cc151a        	jra	L5022
7045  143c               L7122:
7046                     ; 2055     else Relays_8to1 |= (uint8_t)0x04; // Relay-03 ON
7048  143c 72140000      	bset	_Relays_8to1,#2
7049  1440 cc151a        	jra	L5022
7050  1443               L7212:
7051                     ; 2057   case 3:
7051                     ; 2058     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x08); // Relay-04 OFF
7053  1443 7b02          	ld	a,(OFST+2,sp)
7054  1445 2607          	jrne	L3222
7057  1447 72170000      	bres	_Relays_8to1,#3
7059  144b cc151a        	jra	L5022
7060  144e               L3222:
7061                     ; 2059     else Relays_8to1 |= (uint8_t)0x08; // Relay-04 ON
7063  144e 72160000      	bset	_Relays_8to1,#3
7064  1452 cc151a        	jra	L5022
7065  1455               L1312:
7066                     ; 2061   case 4:
7066                     ; 2062     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x10); // Relay-05 OFF
7068  1455 7b02          	ld	a,(OFST+2,sp)
7069  1457 2607          	jrne	L7222
7072  1459 72190000      	bres	_Relays_8to1,#4
7074  145d cc151a        	jra	L5022
7075  1460               L7222:
7076                     ; 2063     else Relays_8to1 |= (uint8_t)0x10; // Relay-05 ON
7078  1460 72180000      	bset	_Relays_8to1,#4
7079  1464 cc151a        	jra	L5022
7080  1467               L3312:
7081                     ; 2065   case 5:
7081                     ; 2066     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x20); // Relay-06 OFF
7083  1467 7b02          	ld	a,(OFST+2,sp)
7084  1469 2607          	jrne	L3322
7087  146b 721b0000      	bres	_Relays_8to1,#5
7089  146f cc151a        	jra	L5022
7090  1472               L3322:
7091                     ; 2067     else Relays_8to1 |= (uint8_t)0x20; // Relay-06 ON
7093  1472 721a0000      	bset	_Relays_8to1,#5
7094  1476 cc151a        	jra	L5022
7095  1479               L5312:
7096                     ; 2069   case 6:
7096                     ; 2070     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x40); // Relay-07 OFF
7098  1479 7b02          	ld	a,(OFST+2,sp)
7099  147b 2607          	jrne	L7322
7102  147d 721d0000      	bres	_Relays_8to1,#6
7104  1481 cc151a        	jra	L5022
7105  1484               L7322:
7106                     ; 2071     else Relays_8to1 |= (uint8_t)0x40; // Relay-07 ON
7108  1484 721c0000      	bset	_Relays_8to1,#6
7109  1488 cc151a        	jra	L5022
7110  148b               L7312:
7111                     ; 2073   case 7:
7111                     ; 2074     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x80); // Relay-08 OFF
7113  148b 7b02          	ld	a,(OFST+2,sp)
7114  148d 2607          	jrne	L3422
7117  148f 721f0000      	bres	_Relays_8to1,#7
7119  1493 cc151a        	jra	L5022
7120  1496               L3422:
7121                     ; 2075     else Relays_8to1 |= (uint8_t)0x80; // Relay-08 ON
7123  1496 721e0000      	bset	_Relays_8to1,#7
7124  149a 207e          	jra	L5022
7125  149c               L1412:
7126                     ; 2077   case 8:
7126                     ; 2078     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x01); // Relay-09 OFF
7128  149c 7b02          	ld	a,(OFST+2,sp)
7129  149e 2606          	jrne	L7422
7132  14a0 72110000      	bres	_Relays_16to9,#0
7134  14a4 2074          	jra	L5022
7135  14a6               L7422:
7136                     ; 2079     else Relays_16to9 |= (uint8_t)0x01; // Relay-09 ON
7138  14a6 72100000      	bset	_Relays_16to9,#0
7139  14aa 206e          	jra	L5022
7140  14ac               L3412:
7141                     ; 2081   case 9:
7141                     ; 2082     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x02); // Relay-10 OFF
7143  14ac 7b02          	ld	a,(OFST+2,sp)
7144  14ae 2606          	jrne	L3522
7147  14b0 72130000      	bres	_Relays_16to9,#1
7149  14b4 2064          	jra	L5022
7150  14b6               L3522:
7151                     ; 2083     else Relays_16to9 |= (uint8_t)0x02; // Relay-10 ON
7153  14b6 72120000      	bset	_Relays_16to9,#1
7154  14ba 205e          	jra	L5022
7155  14bc               L5412:
7156                     ; 2085   case 10:
7156                     ; 2086     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x04); // Relay-11 OFF
7158  14bc 7b02          	ld	a,(OFST+2,sp)
7159  14be 2606          	jrne	L7522
7162  14c0 72150000      	bres	_Relays_16to9,#2
7164  14c4 2054          	jra	L5022
7165  14c6               L7522:
7166                     ; 2087     else Relays_16to9 |= (uint8_t)0x04; // Relay-11 ON
7168  14c6 72140000      	bset	_Relays_16to9,#2
7169  14ca 204e          	jra	L5022
7170  14cc               L7412:
7171                     ; 2089   case 11:
7171                     ; 2090     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x08); // Relay-12 OFF
7173  14cc 7b02          	ld	a,(OFST+2,sp)
7174  14ce 2606          	jrne	L3622
7177  14d0 72170000      	bres	_Relays_16to9,#3
7179  14d4 2044          	jra	L5022
7180  14d6               L3622:
7181                     ; 2091     else Relays_16to9 |= (uint8_t)0x08; // Relay-12 ON
7183  14d6 72160000      	bset	_Relays_16to9,#3
7184  14da 203e          	jra	L5022
7185  14dc               L1512:
7186                     ; 2093   case 12:
7186                     ; 2094     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x10); // Relay-13 OFF
7188  14dc 7b02          	ld	a,(OFST+2,sp)
7189  14de 2606          	jrne	L7622
7192  14e0 72190000      	bres	_Relays_16to9,#4
7194  14e4 2034          	jra	L5022
7195  14e6               L7622:
7196                     ; 2095     else Relays_16to9 |= (uint8_t)0x10; // Relay-13 ON
7198  14e6 72180000      	bset	_Relays_16to9,#4
7199  14ea 202e          	jra	L5022
7200  14ec               L3512:
7201                     ; 2097   case 13:
7201                     ; 2098     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x20); // Relay-14 OFF
7203  14ec 7b02          	ld	a,(OFST+2,sp)
7204  14ee 2606          	jrne	L3722
7207  14f0 721b0000      	bres	_Relays_16to9,#5
7209  14f4 2024          	jra	L5022
7210  14f6               L3722:
7211                     ; 2099     else Relays_16to9 |= (uint8_t)0x20; // Relay-14 ON
7213  14f6 721a0000      	bset	_Relays_16to9,#5
7214  14fa 201e          	jra	L5022
7215  14fc               L5512:
7216                     ; 2101   case 14:
7216                     ; 2102     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x40); // Relay-15 OFF
7218  14fc 7b02          	ld	a,(OFST+2,sp)
7219  14fe 2606          	jrne	L7722
7222  1500 721d0000      	bres	_Relays_16to9,#6
7224  1504 2014          	jra	L5022
7225  1506               L7722:
7226                     ; 2103     else Relays_16to9 |= (uint8_t)0x40; // Relay-15 ON
7228  1506 721c0000      	bset	_Relays_16to9,#6
7229  150a 200e          	jra	L5022
7230  150c               L7512:
7231                     ; 2105   case 15:
7231                     ; 2106     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x80); // Relay-16 OFF
7233  150c 7b02          	ld	a,(OFST+2,sp)
7234  150e 2606          	jrne	L3032
7237  1510 721f0000      	bres	_Relays_16to9,#7
7239  1514 2004          	jra	L5022
7240  1516               L3032:
7241                     ; 2107     else Relays_16to9 |= (uint8_t)0x80; // Relay-16 ON
7243  1516 721e0000      	bset	_Relays_16to9,#7
7244                     ; 2109   default: break;
7246  151a               L5022:
7247                     ; 2111 }
7250  151a 85            	popw	x
7251  151b 81            	ret	
7341                     	switch	.const
7342  422a               L633:
7343  422a 1551          	dc.w	L7032
7344  422c 1558          	dc.w	L1132
7345  422e 155f          	dc.w	L3132
7346  4230 1566          	dc.w	L5132
7347  4232 156d          	dc.w	L7132
7348  4234 1574          	dc.w	L1232
7349  4236 157b          	dc.w	L3232
7350  4238 1582          	dc.w	L5232
7351  423a 1589          	dc.w	L7232
7352  423c 1590          	dc.w	L1332
7353  423e 1597          	dc.w	L3332
7354  4240 159e          	dc.w	L5332
7355                     ; 2114 void SetAddresses(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
7355                     ; 2115 {
7356                     	switch	.text
7357  151c               _SetAddresses:
7359  151c 89            	pushw	x
7360  151d 5207          	subw	sp,#7
7361       00000007      OFST:	set	7
7364                     ; 2128   temp = 0;
7366                     ; 2129   invalid = 0;
7368  151f 0f01          	clr	(OFST-6,sp)
7370                     ; 2132   str[0] = (uint8_t)alpha1;
7372  1521 9f            	ld	a,xl
7373  1522 6b02          	ld	(OFST-5,sp),a
7375                     ; 2133   str[1] = (uint8_t)alpha2;
7377  1524 7b0c          	ld	a,(OFST+5,sp)
7378  1526 6b03          	ld	(OFST-4,sp),a
7380                     ; 2134   str[2] = (uint8_t)alpha3;
7382  1528 7b0d          	ld	a,(OFST+6,sp)
7383  152a 6b04          	ld	(OFST-3,sp),a
7385                     ; 2135   str[3] = 0;
7387  152c 0f05          	clr	(OFST-2,sp)
7389                     ; 2136   temp = atoi(str);
7391  152e 96            	ldw	x,sp
7392  152f 1c0002        	addw	x,#OFST-5
7393  1532 cd0000        	call	_atoi
7395  1535 1f06          	ldw	(OFST-1,sp),x
7397                     ; 2137   if (temp > 255) invalid = 1; // If an invalid entry set indicator
7399  1537 a30100        	cpw	x,#256
7400  153a 2504          	jrult	L3732
7403  153c a601          	ld	a,#1
7404  153e 6b01          	ld	(OFST-6,sp),a
7406  1540               L3732:
7407                     ; 2139   if(invalid == 0) { // Make change only if valid entry
7409  1540 7b01          	ld	a,(OFST-6,sp)
7410  1542 265f          	jrne	L5732
7411                     ; 2140     switch(itemnum)
7413  1544 7b08          	ld	a,(OFST+1,sp)
7415                     ; 2154     default: break;
7416  1546 a10c          	cp	a,#12
7417  1548 2459          	jruge	L5732
7418  154a 5f            	clrw	x
7419  154b 97            	ld	xl,a
7420  154c 58            	sllw	x
7421  154d de422a        	ldw	x,(L633,x)
7422  1550 fc            	jp	(x)
7423  1551               L7032:
7424                     ; 2142     case 0:  Pending_hostaddr4 = (uint8_t)temp; break;
7426  1551 7b07          	ld	a,(OFST+0,sp)
7427  1553 c70000        	ld	_Pending_hostaddr4,a
7430  1556 204b          	jra	L5732
7431  1558               L1132:
7432                     ; 2143     case 1:  Pending_hostaddr3 = (uint8_t)temp; break;
7434  1558 7b07          	ld	a,(OFST+0,sp)
7435  155a c70000        	ld	_Pending_hostaddr3,a
7438  155d 2044          	jra	L5732
7439  155f               L3132:
7440                     ; 2144     case 2:  Pending_hostaddr2 = (uint8_t)temp; break;
7442  155f 7b07          	ld	a,(OFST+0,sp)
7443  1561 c70000        	ld	_Pending_hostaddr2,a
7446  1564 203d          	jra	L5732
7447  1566               L5132:
7448                     ; 2145     case 3:  Pending_hostaddr1 = (uint8_t)temp; break;
7450  1566 7b07          	ld	a,(OFST+0,sp)
7451  1568 c70000        	ld	_Pending_hostaddr1,a
7454  156b 2036          	jra	L5732
7455  156d               L7132:
7456                     ; 2146     case 4:  Pending_draddr4 = (uint8_t)temp; break;
7458  156d 7b07          	ld	a,(OFST+0,sp)
7459  156f c70000        	ld	_Pending_draddr4,a
7462  1572 202f          	jra	L5732
7463  1574               L1232:
7464                     ; 2147     case 5:  Pending_draddr3 = (uint8_t)temp; break;
7466  1574 7b07          	ld	a,(OFST+0,sp)
7467  1576 c70000        	ld	_Pending_draddr3,a
7470  1579 2028          	jra	L5732
7471  157b               L3232:
7472                     ; 2148     case 6:  Pending_draddr2 = (uint8_t)temp; break;
7474  157b 7b07          	ld	a,(OFST+0,sp)
7475  157d c70000        	ld	_Pending_draddr2,a
7478  1580 2021          	jra	L5732
7479  1582               L5232:
7480                     ; 2149     case 7:  Pending_draddr1 = (uint8_t)temp; break;
7482  1582 7b07          	ld	a,(OFST+0,sp)
7483  1584 c70000        	ld	_Pending_draddr1,a
7486  1587 201a          	jra	L5732
7487  1589               L7232:
7488                     ; 2150     case 8:  Pending_netmask4 = (uint8_t)temp; break;
7490  1589 7b07          	ld	a,(OFST+0,sp)
7491  158b c70000        	ld	_Pending_netmask4,a
7494  158e 2013          	jra	L5732
7495  1590               L1332:
7496                     ; 2151     case 9:  Pending_netmask3 = (uint8_t)temp; break;
7498  1590 7b07          	ld	a,(OFST+0,sp)
7499  1592 c70000        	ld	_Pending_netmask3,a
7502  1595 200c          	jra	L5732
7503  1597               L3332:
7504                     ; 2152     case 10: Pending_netmask2 = (uint8_t)temp; break;
7506  1597 7b07          	ld	a,(OFST+0,sp)
7507  1599 c70000        	ld	_Pending_netmask2,a
7510  159c 2005          	jra	L5732
7511  159e               L5332:
7512                     ; 2153     case 11: Pending_netmask1 = (uint8_t)temp; break;
7514  159e 7b07          	ld	a,(OFST+0,sp)
7515  15a0 c70000        	ld	_Pending_netmask1,a
7518                     ; 2154     default: break;
7520  15a3               L5732:
7521                     ; 2157 }
7524  15a3 5b09          	addw	sp,#9
7525  15a5 81            	ret	
7618                     ; 2160 void SetPort(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3, uint8_t alpha4, uint8_t alpha5)
7618                     ; 2161 {
7619                     	switch	.text
7620  15a6               _SetPort:
7622  15a6 89            	pushw	x
7623  15a7 5209          	subw	sp,#9
7624       00000009      OFST:	set	9
7627                     ; 2174   temp = 0;
7629  15a9 5f            	clrw	x
7630  15aa 1f01          	ldw	(OFST-8,sp),x
7632                     ; 2175   invalid = 0;
7634  15ac 0f03          	clr	(OFST-6,sp)
7636                     ; 2178   if(alpha1 > '6') invalid = 1;
7638  15ae 7b0b          	ld	a,(OFST+2,sp)
7639  15b0 a137          	cp	a,#55
7640  15b2 2506          	jrult	L1442
7643  15b4 a601          	ld	a,#1
7644  15b6 6b03          	ld	(OFST-6,sp),a
7647  15b8 201d          	jra	L3442
7648  15ba               L1442:
7649                     ; 2180     str[0] = (uint8_t)alpha1;
7651  15ba 6b04          	ld	(OFST-5,sp),a
7653                     ; 2181     str[1] = (uint8_t)alpha2;
7655  15bc 7b0e          	ld	a,(OFST+5,sp)
7656  15be 6b05          	ld	(OFST-4,sp),a
7658                     ; 2182     str[2] = (uint8_t)alpha3;
7660  15c0 7b0f          	ld	a,(OFST+6,sp)
7661  15c2 6b06          	ld	(OFST-3,sp),a
7663                     ; 2183     str[3] = (uint8_t)alpha4;
7665  15c4 7b10          	ld	a,(OFST+7,sp)
7666  15c6 6b07          	ld	(OFST-2,sp),a
7668                     ; 2184     str[4] = (uint8_t)alpha5;
7670  15c8 7b11          	ld	a,(OFST+8,sp)
7671  15ca 6b08          	ld	(OFST-1,sp),a
7673                     ; 2185     str[5] = 0;
7675  15cc 0f09          	clr	(OFST+0,sp)
7677                     ; 2186     temp = atoi(str);
7679  15ce 96            	ldw	x,sp
7680  15cf 1c0004        	addw	x,#OFST-5
7681  15d2 cd0000        	call	_atoi
7683  15d5 1f01          	ldw	(OFST-8,sp),x
7685  15d7               L3442:
7686                     ; 2189   if(temp < 10) invalid = 1;
7688  15d7 a3000a        	cpw	x,#10
7689  15da 2404          	jruge	L5442
7692  15dc a601          	ld	a,#1
7693  15de 6b03          	ld	(OFST-6,sp),a
7695  15e0               L5442:
7696                     ; 2191   if(invalid == 0) { // Make change only if valid entry
7698  15e0 7b03          	ld	a,(OFST-6,sp)
7699  15e2 2603          	jrne	L7442
7700                     ; 2192     Pending_port = (uint16_t)temp;
7702  15e4 cf0000        	ldw	_Pending_port,x
7703  15e7               L7442:
7704                     ; 2194 }
7707  15e7 5b0b          	addw	sp,#11
7708  15e9 81            	ret	
7774                     ; 2197 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7774                     ; 2198 {
7775                     	switch	.text
7776  15ea               _SetMAC:
7778  15ea 89            	pushw	x
7779  15eb 5203          	subw	sp,#3
7780       00000003      OFST:	set	3
7783                     ; 2210   temp = 0;
7785                     ; 2211   invalid = 0;
7787  15ed 0f01          	clr	(OFST-2,sp)
7789                     ; 2214   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7791  15ef 9f            	ld	a,xl
7792  15f0 a130          	cp	a,#48
7793  15f2 250b          	jrult	L3152
7795  15f4 9f            	ld	a,xl
7796  15f5 a13a          	cp	a,#58
7797  15f7 2406          	jruge	L3152
7800  15f9 7b05          	ld	a,(OFST+2,sp)
7801  15fb a030          	sub	a,#48
7803  15fd 200c          	jp	LC028
7804  15ff               L3152:
7805                     ; 2215   else if(alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7807  15ff 7b05          	ld	a,(OFST+2,sp)
7808  1601 a161          	cp	a,#97
7809  1603 250a          	jrult	L7152
7811  1605 a167          	cp	a,#103
7812  1607 2406          	jruge	L7152
7815  1609 a057          	sub	a,#87
7816  160b               LC028:
7817  160b 6b05          	ld	(OFST+2,sp),a
7819  160d 2004          	jra	L5152
7820  160f               L7152:
7821                     ; 2216   else invalid = 1; // If an invalid entry set indicator
7823  160f a601          	ld	a,#1
7824  1611 6b01          	ld	(OFST-2,sp),a
7826  1613               L5152:
7827                     ; 2218   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7829  1613 7b08          	ld	a,(OFST+5,sp)
7830  1615 a130          	cp	a,#48
7831  1617 2508          	jrult	L3252
7833  1619 a13a          	cp	a,#58
7834  161b 2404          	jruge	L3252
7837  161d a030          	sub	a,#48
7839  161f 200a          	jp	LC029
7840  1621               L3252:
7841                     ; 2219   else if(alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7843  1621 a161          	cp	a,#97
7844  1623 250a          	jrult	L7252
7846  1625 a167          	cp	a,#103
7847  1627 2406          	jruge	L7252
7850  1629 a057          	sub	a,#87
7851  162b               LC029:
7852  162b 6b08          	ld	(OFST+5,sp),a
7854  162d 2004          	jra	L5252
7855  162f               L7252:
7856                     ; 2220   else invalid = 1; // If an invalid entry set indicator
7858  162f a601          	ld	a,#1
7859  1631 6b01          	ld	(OFST-2,sp),a
7861  1633               L5252:
7862                     ; 2222   if (invalid == 0) { // Change value only if valid entry
7864  1633 7b01          	ld	a,(OFST-2,sp)
7865  1635 264a          	jrne	L3352
7866                     ; 2223     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7868  1637 7b05          	ld	a,(OFST+2,sp)
7869  1639 97            	ld	xl,a
7870  163a a610          	ld	a,#16
7871  163c 42            	mul	x,a
7872  163d 01            	rrwa	x,a
7873  163e 1b08          	add	a,(OFST+5,sp)
7874  1640 5f            	clrw	x
7875  1641 97            	ld	xl,a
7876  1642 1f02          	ldw	(OFST-1,sp),x
7878                     ; 2224     switch(itemnum)
7880  1644 7b04          	ld	a,(OFST+1,sp)
7882                     ; 2232     default: break;
7883  1646 2711          	jreq	L1542
7884  1648 4a            	dec	a
7885  1649 2715          	jreq	L3542
7886  164b 4a            	dec	a
7887  164c 2719          	jreq	L5542
7888  164e 4a            	dec	a
7889  164f 271d          	jreq	L7542
7890  1651 4a            	dec	a
7891  1652 2721          	jreq	L1642
7892  1654 4a            	dec	a
7893  1655 2725          	jreq	L3642
7894  1657 2028          	jra	L3352
7895  1659               L1542:
7896                     ; 2226     case 0: Pending_uip_ethaddr1 = (uint8_t)temp; break;
7898  1659 7b03          	ld	a,(OFST+0,sp)
7899  165b c70000        	ld	_Pending_uip_ethaddr1,a
7902  165e 2021          	jra	L3352
7903  1660               L3542:
7904                     ; 2227     case 1: Pending_uip_ethaddr2 = (uint8_t)temp; break;
7906  1660 7b03          	ld	a,(OFST+0,sp)
7907  1662 c70000        	ld	_Pending_uip_ethaddr2,a
7910  1665 201a          	jra	L3352
7911  1667               L5542:
7912                     ; 2228     case 2: Pending_uip_ethaddr3 = (uint8_t)temp; break;
7914  1667 7b03          	ld	a,(OFST+0,sp)
7915  1669 c70000        	ld	_Pending_uip_ethaddr3,a
7918  166c 2013          	jra	L3352
7919  166e               L7542:
7920                     ; 2229     case 3: Pending_uip_ethaddr4 = (uint8_t)temp; break;
7922  166e 7b03          	ld	a,(OFST+0,sp)
7923  1670 c70000        	ld	_Pending_uip_ethaddr4,a
7926  1673 200c          	jra	L3352
7927  1675               L1642:
7928                     ; 2230     case 4: Pending_uip_ethaddr5 = (uint8_t)temp; break;
7930  1675 7b03          	ld	a,(OFST+0,sp)
7931  1677 c70000        	ld	_Pending_uip_ethaddr5,a
7934  167a 2005          	jra	L3352
7935  167c               L3642:
7936                     ; 2231     case 5: Pending_uip_ethaddr6 = (uint8_t)temp; break;
7938  167c 7b03          	ld	a,(OFST+0,sp)
7939  167e c70000        	ld	_Pending_uip_ethaddr6,a
7942                     ; 2232     default: break;
7944  1681               L3352:
7945                     ; 2235 }
7948  1681 5b05          	addw	sp,#5
7949  1683 81            	ret	
8051                     	switch	.bss
8052  0000               _OctetArray:
8053  0000 000000000000  	ds.b	11
8054                     	xdef	_OctetArray
8055                     	xref	_submit_changes
8056                     	xref	_ex_stored_devicename
8057                     	xref	_uip_ethaddr6
8058                     	xref	_uip_ethaddr5
8059                     	xref	_uip_ethaddr4
8060                     	xref	_uip_ethaddr3
8061                     	xref	_uip_ethaddr2
8062                     	xref	_uip_ethaddr1
8063                     	xref	_ex_stored_port
8064                     	xref	_ex_stored_netmask1
8065                     	xref	_ex_stored_netmask2
8066                     	xref	_ex_stored_netmask3
8067                     	xref	_ex_stored_netmask4
8068                     	xref	_ex_stored_draddr1
8069                     	xref	_ex_stored_draddr2
8070                     	xref	_ex_stored_draddr3
8071                     	xref	_ex_stored_draddr4
8072                     	xref	_ex_stored_hostaddr1
8073                     	xref	_ex_stored_hostaddr2
8074                     	xref	_ex_stored_hostaddr3
8075                     	xref	_ex_stored_hostaddr4
8076                     	xref	_Pending_uip_ethaddr6
8077                     	xref	_Pending_uip_ethaddr5
8078                     	xref	_Pending_uip_ethaddr4
8079                     	xref	_Pending_uip_ethaddr3
8080                     	xref	_Pending_uip_ethaddr2
8081                     	xref	_Pending_uip_ethaddr1
8082                     	xref	_Pending_port
8083                     	xref	_Pending_netmask1
8084                     	xref	_Pending_netmask2
8085                     	xref	_Pending_netmask3
8086                     	xref	_Pending_netmask4
8087                     	xref	_Pending_draddr1
8088                     	xref	_Pending_draddr2
8089                     	xref	_Pending_draddr3
8090                     	xref	_Pending_draddr4
8091                     	xref	_Pending_hostaddr1
8092                     	xref	_Pending_hostaddr2
8093                     	xref	_Pending_hostaddr3
8094                     	xref	_Pending_hostaddr4
8095                     	xref	_invert_output
8096                     	xref	_Relays_8to1
8097                     	xref	_Relays_16to9
8098                     	xref	_Port_Httpd
8099  000b               _current_webpage:
8100  000b 00            	ds.b	1
8101                     	xdef	_current_webpage
8102                     	xref	_atoi
8103                     	xref	_debugflash
8104                     	xref	_uip_flags
8105                     	xref	_uip_stat
8106                     	xref	_uip_conn
8107                     	xref	_uip_appdata
8108                     	xref	_htons
8109                     	xref	_uip_send
8110                     	xref	_uip_listen
8111                     	xdef	_SetMAC
8112                     	xdef	_SetPort
8113                     	xdef	_SetAddresses
8114                     	xdef	_GpioSetPin
8115                     	xdef	_GpioGetPin
8116                     	xdef	_HttpDCall
8117                     	xdef	_HttpDInit
8118                     	xdef	_reverse
8119                     	xdef	_emb_itoa
8120                     	xdef	_two_alpha_to_uint
8121                     	xdef	_three_alpha_to_uint
8122                     	switch	.const
8123  4242               L714:
8124  4242 436f6e6e6563  	dc.b	"Connection:close",13
8125  4253 0a00          	dc.b	10,0
8126  4255               L514:
8127  4255 436f6e74656e  	dc.b	"Content-Type:text/"
8128  4267 68746d6c0d    	dc.b	"html",13
8129  426c 0a00          	dc.b	10,0
8130  426e               L314:
8131  426e 436f6e74656e  	dc.b	"Content-Length:",0
8132  427e               L114:
8133  427e 0d0a00        	dc.b	13,10,0
8134  4281               L704:
8135  4281 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8136                     	xref.b	c_lreg
8137                     	xref.b	c_x
8138                     	xref.b	c_y
8158                     	xref	c_uitolx
8159                     	xref	c_ludv
8160                     	xref	c_lumd
8161                     	xref	c_rtol
8162                     	xref	c_ltor
8163                     	xref	c_lzmp
8164                     	end
