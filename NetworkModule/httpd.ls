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
  30  00aa 7d2e7431207b  	dc.b	"}.t1 { width: 100p"
  31  00bc 783b207d2e74  	dc.b	"x; }.t2 { width: 1"
  32  00ce 343870783b20  	dc.b	"48px; }.t3 { width"
  33  00e0 3a2033307078  	dc.b	": 30px; }.t4 { wid"
  34  00f2 74683a203132  	dc.b	"th: 120px; }td { t"
  35  0104 657874        	dc.b	"ext"
  36  0107 2d616c69676e  	dc.b	"-align: center; bo"
  37  0119 726465723a20  	dc.b	"rder: 1px black so"
  38  012b 6c69643b207d  	dc.b	"lid; }</style></he"
  39  013d 61643e3c626f  	dc.b	"ad><body><h1>Relay"
  40  014f 20436f6e7472  	dc.b	" Control</h1><form"
  41  0161 206d6574686f  	dc.b	" method='POST' act"
  42  0173 696f6e3d272f  	dc.b	"ion='/'><table><tr"
  43  0185 3e3c74642063  	dc.b	"><td class='t1'>Na"
  44  0197 6d653a3c2f74  	dc.b	"me:</td><td><input"
  45  01a9 20747970653d  	dc.b	" type='text' name="
  46  01bb 276130302720  	dc.b	"'a00' class='t2' v"
  47  01cd 616c75653d27  	dc.b	"alue='%a00xxxxxxxx"
  48  01df 787878787878  	dc.b	"xxxxxxxxxxxx' patt"
  49  01f1 65726e3d275b  	dc.b	"ern='[0-9a-zA-Z-_*"
  50  0203 2e5d7b        	dc.b	".]{"
  51  0206 312c32307d27  	dc.b	"1,20}' title='1 to"
  52  0218 203230206c65  	dc.b	" 20 letters, numbe"
  53  022a 72732c20616e  	dc.b	"rs, and -_*. no sp"
  54  023c 616365732720  	dc.b	"aces' maxlength='2"
  55  024e 30273e3c2f74  	dc.b	"0'></td></tr></tab"
  56  0260 6c653e3c7461  	dc.b	"le><table><tr><td "
  57  0272 636c6173733d  	dc.b	"class='t1'></td><t"
  58  0284 6420636c6173  	dc.b	"d class='t3'></td>"
  59  0296 3c746420636c  	dc.b	"<td class='t4'>SET"
  60  02a8 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
  61  02ba 636c6173733d  	dc.b	"class='t1'>Relay01"
  62  02cc 3c2f74643e3c  	dc.b	"</td><td class='s%"
  63  02de 693030273e3c  	dc.b	"i00'></td><td clas"
  64  02f0 733d27743427  	dc.b	"s='t4'><input type"
  65  0302 3d2772        	dc.b	"='r"
  66  0305 6164696f2720  	dc.b	"adio' id='01on' na"
  67  0317 6d653d276f30  	dc.b	"me='o00' value='1'"
  68  0329 20256f30303e  	dc.b	" %o00><label for='"
  69  033b 30316f6e273e  	dc.b	"01on'>ON</label><i"
  70  034d 6e7075742074  	dc.b	"nput type='radio' "
  71  035f 69643d273031  	dc.b	"id='01off' name='o"
  72  0371 303027207661  	dc.b	"00' value='0' %p00"
  73  0383 3e3c6c616265  	dc.b	"><label for='01off"
  74  0395 273e4f46463c  	dc.b	"'>OFF</label></td>"
  75  03a7 3c2f74723e3c  	dc.b	"</tr><tr><td class"
  76  03b9 3d277431273e  	dc.b	"='t1'>Relay02</td>"
  77  03cb 3c746420636c  	dc.b	"<td class='s%i01'>"
  78  03dd 3c2f74643e3c  	dc.b	"</td><td class='t4"
  79  03ef 273e3c696e70  	dc.b	"'><input type='rad"
  80  0401 696f27        	dc.b	"io'"
  81  0404 2069643d2730  	dc.b	" id='02on' name='o"
  82  0416 303127207661  	dc.b	"01' value='1' %o01"
  83  0428 3e3c6c616265  	dc.b	"><label for='02on'"
  84  043a 3e4f4e3c2f6c  	dc.b	">ON</label><input "
  85  044c 747970653d27  	dc.b	"type='radio' id='0"
  86  045e 326f66662720  	dc.b	"2off' name='o01' v"
  87  0470 616c75653d27  	dc.b	"alue='0' %p01><lab"
  88  0482 656c20666f72  	dc.b	"el for='02off'>OFF"
  89  0494 3c2f6c616265  	dc.b	"</label></td></tr>"
  90  04a6 3c74723e3c74  	dc.b	"<tr><td class='t1'"
  91  04b8 3e52656c6179  	dc.b	">Relay03</td><td c"
  92  04ca 6c6173733d27  	dc.b	"lass='s%i02'></td>"
  93  04dc 3c746420636c  	dc.b	"<td class='t4'><in"
  94  04ee 707574207479  	dc.b	"put type='radio' i"
  95  0500 643d27        	dc.b	"d='"
  96  0503 30336f6e2720  	dc.b	"03on' name='o02' v"
  97  0515 616c75653d27  	dc.b	"alue='1' %o02><lab"
  98  0527 656c20666f72  	dc.b	"el for='03on'>ON</"
  99  0539 6c6162656c3e  	dc.b	"label><input type="
 100  054b 27726164696f  	dc.b	"'radio' id='03off'"
 101  055d 206e616d653d  	dc.b	" name='o02' value="
 102  056f 273027202570  	dc.b	"'0' %p02><label fo"
 103  0581 723d2730336f  	dc.b	"r='03off'>OFF</lab"
 104  0593 656c3e3c2f74  	dc.b	"el></td></tr><tr><"
 105  05a5 746420636c61  	dc.b	"td class='t1'>Rela"
 106  05b7 7930343c2f74  	dc.b	"y04</td><td class="
 107  05c9 277325693033  	dc.b	"'s%i03'></td><td c"
 108  05db 6c6173733d27  	dc.b	"lass='t4'><input t"
 109  05ed 7970653d2772  	dc.b	"ype='radio' id='04"
 110  05ff 6f6e27        	dc.b	"on'"
 111  0602 206e616d653d  	dc.b	" name='o03' value="
 112  0614 27312720256f  	dc.b	"'1' %o03><label fo"
 113  0626 723d2730346f  	dc.b	"r='04on'>ON</label"
 114  0638 3e3c696e7075  	dc.b	"><input type='radi"
 115  064a 6f272069643d  	dc.b	"o' id='04off' name"
 116  065c 3d276f303327  	dc.b	"='o03' value='0' %"
 117  066e 7030333e3c6c  	dc.b	"p03><label for='04"
 118  0680 6f6666273e4f  	dc.b	"off'>OFF</label></"
 119  0692 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
 120  06a4 6173733d2774  	dc.b	"ass='t1'>Relay05</"
 121  06b6 74643e3c7464  	dc.b	"td><td class='s%i0"
 122  06c8 34273e3c2f74  	dc.b	"4'></td><td class="
 123  06da 277434273e3c  	dc.b	"'t4'><input type='"
 124  06ec 726164696f27  	dc.b	"radio' id='05on' n"
 125  06fe 616d65        	dc.b	"ame"
 126  0701 3d276f303427  	dc.b	"='o04' value='1' %"
 127  0713 6f30343e3c6c  	dc.b	"o04><label for='05"
 128  0725 6f6e273e4f4e  	dc.b	"on'>ON</label><inp"
 129  0737 757420747970  	dc.b	"ut type='radio' id"
 130  0749 3d2730356f66  	dc.b	"='05off' name='o04"
 131  075b 272076616c75  	dc.b	"' value='0' %p04><"
 132  076d 6c6162656c20  	dc.b	"label for='05off'>"
 133  077f 4f46463c2f6c  	dc.b	"OFF</label></td></"
 134  0791 74723e3c7472  	dc.b	"tr><tr><td class='"
 135  07a3 7431273e5265  	dc.b	"t1'>Relay06</td><t"
 136  07b5 6420636c6173  	dc.b	"d class='s%i05'></"
 137  07c7 74643e3c7464  	dc.b	"td><td class='t4'>"
 138  07d9 3c696e707574  	dc.b	"<input type='radio"
 139  07eb 272069643d27  	dc.b	"' id='06on' name='"
 140  07fd 6f3035        	dc.b	"o05"
 141  0800 272076616c75  	dc.b	"' value='1' %o05><"
 142  0812 6c6162656c20  	dc.b	"label for='06on'>O"
 143  0824 4e3c2f6c6162  	dc.b	"N</label><input ty"
 144  0836 70653d277261  	dc.b	"pe='radio' id='06o"
 145  0848 666627206e61  	dc.b	"ff' name='o05' val"
 146  085a 75653d273027  	dc.b	"ue='0' %p05><label"
 147  086c 20666f723d27  	dc.b	" for='06off'>OFF</"
 148  087e 6c6162656c3e  	dc.b	"label></td></tr><t"
 149  0890 723e3c746420  	dc.b	"r><td class='t1'>R"
 150  08a2 656c61793037  	dc.b	"elay07</td><td cla"
 151  08b4 73733d277325  	dc.b	"ss='s%i06'></td><t"
 152  08c6 6420636c6173  	dc.b	"d class='t4'><inpu"
 153  08d8 742074797065  	dc.b	"t type='radio' id="
 154  08ea 2730376f6e27  	dc.b	"'07on' name='o06' "
 155  08fc 76616c        	dc.b	"val"
 156  08ff 75653d273127  	dc.b	"ue='1' %o06><label"
 157  0911 20666f723d27  	dc.b	" for='07on'>ON</la"
 158  0923 62656c3e3c69  	dc.b	"bel><input type='r"
 159  0935 6164696f2720  	dc.b	"adio' id='07off' n"
 160  0947 616d653d276f  	dc.b	"ame='o06' value='0"
 161  0959 272025703036  	dc.b	"' %p06><label for="
 162  096b 2730376f6666  	dc.b	"'07off'>OFF</label"
 163  097d 3e3c2f74643e  	dc.b	"></td></tr><tr><td"
 164  098f 20636c617373  	dc.b	" class='t1'>Relay0"
 165  09a1 383c2f74643e  	dc.b	"8</td><td class='s"
 166  09b3 25693037273e  	dc.b	"%i07'></td><td cla"
 167  09c5 73733d277434  	dc.b	"ss='t4'><input typ"
 168  09d7 653d27726164  	dc.b	"e='radio' id='08on"
 169  09e9 27206e616d65  	dc.b	"' name='o07' value"
 170  09fb 3d2731        	dc.b	"='1"
 171  09fe 2720256f3037  	dc.b	"' %o07><label for="
 172  0a10 2730386f6e27  	dc.b	"'08on'>ON</label><"
 173  0a22 696e70757420  	dc.b	"input type='radio'"
 174  0a34 2069643d2730  	dc.b	" id='08off' name='"
 175  0a46 6f3037272076  	dc.b	"o07' value='0' %p0"
 176  0a58 373e3c6c6162  	dc.b	"7><label for='08of"
 177  0a6a 66273e4f4646  	dc.b	"f'>OFF</label></td"
 178  0a7c 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 179  0a8e 733d27743127  	dc.b	"s='t1'>Relay09</td"
 180  0aa0 3e3c74642063  	dc.b	"><td class='s%i08'"
 181  0ab2 3e3c2f74643e  	dc.b	"></td><td class='t"
 182  0ac4 34273e3c696e  	dc.b	"4'><input type='ra"
 183  0ad6 64696f272069  	dc.b	"dio' id='09on' nam"
 184  0ae8 653d276f3038  	dc.b	"e='o08' value='1' "
 185  0afa 256f30        	dc.b	"%o0"
 186  0afd 383e3c6c6162  	dc.b	"8><label for='09on"
 187  0b0f 273e4f4e3c2f  	dc.b	"'>ON</label><input"
 188  0b21 20747970653d  	dc.b	" type='radio' id='"
 189  0b33 30396f666627  	dc.b	"09off' name='o08' "
 190  0b45 76616c75653d  	dc.b	"value='0' %p08><la"
 191  0b57 62656c20666f  	dc.b	"bel for='09off'>OF"
 192  0b69 463c2f6c6162  	dc.b	"F</label></td></tr"
 193  0b7b 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 194  0b8d 273e52656c61  	dc.b	"'>Relay10</td><td "
 195  0b9f 636c6173733d  	dc.b	"class='s%i09'></td"
 196  0bb1 3e3c74642063  	dc.b	"><td class='t4'><i"
 197  0bc3 6e7075742074  	dc.b	"nput type='radio' "
 198  0bd5 69643d273130  	dc.b	"id='10on' name='o0"
 199  0be7 39272076616c  	dc.b	"9' value='1' %o09>"
 200  0bf9 3c6c61        	dc.b	"<la"
 201  0bfc 62656c20666f  	dc.b	"bel for='10on'>ON<"
 202  0c0e 2f6c6162656c  	dc.b	"/label><input type"
 203  0c20 3d2772616469  	dc.b	"='radio' id='10off"
 204  0c32 27206e616d65  	dc.b	"' name='o09' value"
 205  0c44 3d2730272025  	dc.b	"='0' %p09><label f"
 206  0c56 6f723d273130  	dc.b	"or='10off'>OFF</la"
 207  0c68 62656c3e3c2f  	dc.b	"bel></td></tr><tr>"
 208  0c7a 3c746420636c  	dc.b	"<td class='t1'>Rel"
 209  0c8c 617931313c2f  	dc.b	"ay11</td><td class"
 210  0c9e 3d2773256931  	dc.b	"='s%i10'></td><td "
 211  0cb0 636c6173733d  	dc.b	"class='t4'><input "
 212  0cc2 747970653d27  	dc.b	"type='radio' id='1"
 213  0cd4 316f6e27206e  	dc.b	"1on' name='o10' va"
 214  0ce6 6c75653d2731  	dc.b	"lue='1' %o10><labe"
 215  0cf8 6c2066        	dc.b	"l f"
 216  0cfb 6f723d273131  	dc.b	"or='11on'>ON</labe"
 217  0d0d 6c3e3c696e70  	dc.b	"l><input type='rad"
 218  0d1f 696f27206964  	dc.b	"io' id='11off' nam"
 219  0d31 653d276f3130  	dc.b	"e='o10' value='0' "
 220  0d43 257031303e3c  	dc.b	"%p10><label for='1"
 221  0d55 316f6666273e  	dc.b	"1off'>OFF</label><"
 222  0d67 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 223  0d79 6c6173733d27  	dc.b	"lass='t1'>Relay12<"
 224  0d8b 2f74643e3c74  	dc.b	"/td><td class='s%i"
 225  0d9d 3131273e3c2f  	dc.b	"11'></td><td class"
 226  0daf 3d277434273e  	dc.b	"='t4'><input type="
 227  0dc1 27726164696f  	dc.b	"'radio' id='12on' "
 228  0dd3 6e616d653d27  	dc.b	"name='o11' value='"
 229  0de5 312720256f31  	dc.b	"1' %o11><label for"
 230  0df7 3d2731        	dc.b	"='1"
 231  0dfa 326f6e273e4f  	dc.b	"2on'>ON</label><in"
 232  0e0c 707574207479  	dc.b	"put type='radio' i"
 233  0e1e 643d2731326f  	dc.b	"d='12off' name='o1"
 234  0e30 31272076616c  	dc.b	"1' value='0' %p11>"
 235  0e42 3c6c6162656c  	dc.b	"<label for='12off'"
 236  0e54 3e4f46463c2f  	dc.b	">OFF</label></td><"
 237  0e66 2f74723e3c74  	dc.b	"/tr><tr><td class="
 238  0e78 277431273e52  	dc.b	"'t1'>Relay13</td><"
 239  0e8a 746420636c61  	dc.b	"td class='s%i12'><"
 240  0e9c 2f74643e3c74  	dc.b	"/td><td class='t4'"
 241  0eae 3e3c696e7075  	dc.b	"><input type='radi"
 242  0ec0 6f272069643d  	dc.b	"o' id='13on' name="
 243  0ed2 276f31322720  	dc.b	"'o12' value='1' %o"
 244  0ee4 31323e3c6c61  	dc.b	"12><label for='13o"
 245  0ef6 6e273e        	dc.b	"n'>"
 246  0ef9 4f4e3c2f6c61  	dc.b	"ON</label><input t"
 247  0f0b 7970653d2772  	dc.b	"ype='radio' id='13"
 248  0f1d 6f666627206e  	dc.b	"off' name='o12' va"
 249  0f2f 6c75653d2730  	dc.b	"lue='0' %p12><labe"
 250  0f41 6c20666f723d  	dc.b	"l for='13off'>OFF<"
 251  0f53 2f6c6162656c  	dc.b	"/label></td></tr><"
 252  0f65 74723e3c7464  	dc.b	"tr><td class='t1'>"
 253  0f77 52656c617931  	dc.b	"Relay14</td><td cl"
 254  0f89 6173733d2773  	dc.b	"ass='s%i13'></td><"
 255  0f9b 746420636c61  	dc.b	"td class='t4'><inp"
 256  0fad 757420747970  	dc.b	"ut type='radio' id"
 257  0fbf 3d2731346f6e  	dc.b	"='14on' name='o13'"
 258  0fd1 2076616c7565  	dc.b	" value='1' %o13><l"
 259  0fe3 6162656c2066  	dc.b	"abel for='14on'>ON"
 260  0ff5 3c2f6c        	dc.b	"</l"
 261  0ff8 6162656c3e3c  	dc.b	"abel><input type='"
 262  100a 726164696f27  	dc.b	"radio' id='14off' "
 263  101c 6e616d653d27  	dc.b	"name='o13' value='"
 264  102e 302720257031  	dc.b	"0' %p13><label for"
 265  1040 3d2731346f66  	dc.b	"='14off'>OFF</labe"
 266  1052 6c3e3c2f7464  	dc.b	"l></td></tr><tr><t"
 267  1064 6420636c6173  	dc.b	"d class='t1'>Relay"
 268  1076 31353c2f7464  	dc.b	"15</td><td class='"
 269  1088 732569313427  	dc.b	"s%i14'></td><td cl"
 270  109a 6173733d2774  	dc.b	"ass='t4'><input ty"
 271  10ac 70653d277261  	dc.b	"pe='radio' id='15o"
 272  10be 6e27206e616d  	dc.b	"n' name='o14' valu"
 273  10d0 653d27312720  	dc.b	"e='1' %o14><label "
 274  10e2 666f723d2731  	dc.b	"for='15on'>ON</lab"
 275  10f4 656c3e        	dc.b	"el>"
 276  10f7 3c696e707574  	dc.b	"<input type='radio"
 277  1109 272069643d27  	dc.b	"' id='15off' name="
 278  111b 276f31342720  	dc.b	"'o14' value='0' %p"
 279  112d 31343e3c6c61  	dc.b	"14><label for='15o"
 280  113f 6666273e4f46  	dc.b	"ff'>OFF</label></t"
 281  1151 643e3c2f7472  	dc.b	"d></tr><tr><td cla"
 282  1163 73733d277431  	dc.b	"ss='t1'>Relay16</t"
 283  1175 643e3c746420  	dc.b	"d><td class='s%i15"
 284  1187 273e3c2f7464  	dc.b	"'></td><td class='"
 285  1199 7434273e3c69  	dc.b	"t4'><input type='r"
 286  11ab 6164696f2720  	dc.b	"adio' id='16on' na"
 287  11bd 6d653d276f31  	dc.b	"me='o15' value='1'"
 288  11cf 20256f31353e  	dc.b	" %o15><label for='"
 289  11e1 31366f6e273e  	dc.b	"16on'>ON</label><i"
 290  11f3 6e7075        	dc.b	"npu"
 291  11f6 742074797065  	dc.b	"t type='radio' id="
 292  1208 2731366f6666  	dc.b	"'16off' name='o15'"
 293  121a 2076616c7565  	dc.b	" value='0' %p15><l"
 294  122c 6162656c2066  	dc.b	"abel for='16off'>O"
 295  123e 46463c2f6c61  	dc.b	"FF</label></td></t"
 296  1250 723e3c74723e  	dc.b	"r><tr><td class='t"
 297  1262 31273e496e76  	dc.b	"1'>Invert</td><td "
 298  1274 636c6173733d  	dc.b	"class='t3'></td><t"
 299  1286 6420636c6173  	dc.b	"d class='t4'><inpu"
 300  1298 742074797065  	dc.b	"t type='radio' id="
 301  12aa 27696e764f6e  	dc.b	"'invOn' name='g00'"
 302  12bc 2076616c7565  	dc.b	" value='1' %g00><l"
 303  12ce 6162656c2066  	dc.b	"abel for='invOn'>O"
 304  12e0 4e3c2f6c6162  	dc.b	"N</label><input ty"
 305  12f2 70653d        	dc.b	"pe="
 306  12f5 27726164696f  	dc.b	"'radio' id='invOff"
 307  1307 27206e616d65  	dc.b	"' name='g00' value"
 308  1319 3d2730272025  	dc.b	"='0' %h00><label f"
 309  132b 6f723d27696e  	dc.b	"or='invOff'>OFF</l"
 310  133d 6162656c3e3c  	dc.b	"abel></td></tr></t"
 311  134f 61626c653e3c  	dc.b	"able><button type="
 312  1361 277375626d69  	dc.b	"'submit' title='Sa"
 313  1373 76657320796f  	dc.b	"ves your changes -"
 314  1385 20646f657320  	dc.b	" does not restart "
 315  1397 746865204e65  	dc.b	"the Network Module"
 316  13a9 273e53617665  	dc.b	"'>Save</button><bu"
 317  13bb 74746f6e2074  	dc.b	"tton type='reset' "
 318  13cd 7469746c653d  	dc.b	"title='Un-does any"
 319  13df 206368616e67  	dc.b	" changes that have"
 320  13f1 206e6f        	dc.b	" no"
 321  13f4 74206265656e  	dc.b	"t been saved'>Undo"
 322  1406 20416c6c3c2f  	dc.b	" All</button></for"
 323  1418 6d3e3c666f72  	dc.b	"m><form style='dis"
 324  142a 706c61793a20  	dc.b	"play: inline' acti"
 325  143c 6f6e3d272578  	dc.b	"on='%x00http://192"
 326  144e 2e3136382e30  	dc.b	".168.001.004:08080"
 327  1460 2f363127206d  	dc.b	"/61' method='GET'>"
 328  1472 3c627574746f  	dc.b	"<button title='Sav"
 329  1484 652066697273  	dc.b	"e first! This butt"
 330  1496 6f6e2077696c  	dc.b	"on will not save y"
 331  14a8 6f7572206368  	dc.b	"our changes'>Addre"
 332  14ba 737320536574  	dc.b	"ss Settings</butto"
 333  14cc 6e3e3c2f666f  	dc.b	"n></form><form sty"
 334  14de 6c653d276469  	dc.b	"le='display: inlin"
 335  14f0 652720        	dc.b	"e' "
 336  14f3 616374696f6e  	dc.b	"action='%x00http:/"
 337  1505 2f3139322e31  	dc.b	"/192.168.001.004:0"
 338  1517 383038302f36  	dc.b	"8080/66' method='G"
 339  1529 4554273e3c62  	dc.b	"ET'><button title="
 340  153b 275361766520  	dc.b	"'Save first! This "
 341  154d 627574746f6e  	dc.b	"button will not sa"
 342  155f 766520796f75  	dc.b	"ve your changes'>N"
 343  1571 6574776f726b  	dc.b	"etwork Statistics<"
 344  1583 2f627574746f  	dc.b	"/button></form><fo"
 345  1595 726d20737479  	dc.b	"rm style='display:"
 346  15a7 20696e6c696e  	dc.b	" inline' action='%"
 347  15b9 783030687474  	dc.b	"x00http://192.168."
 348  15cb 3030312e3030  	dc.b	"001.004:08080/63' "
 349  15dd 6d6574686f64  	dc.b	"method='GET'><butt"
 350  15ef 6f6e20        	dc.b	"on "
 351  15f2 7469746c653d  	dc.b	"title='Save first!"
 352  1604 205468697320  	dc.b	" This button will "
 353  1616 6e6f74207361  	dc.b	"not save your chan"
 354  1628 676573273e48  	dc.b	"ges'>Help</button>"
 355  163a 3c2f666f726d  	dc.b	"</form></body></ht"
 356  164c 6d6c3e00      	dc.b	"ml>",0
 357  1650               L71_g_HtmlPageAddress:
 358  1650 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 359  1662 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 360  1674 6561643e3c74  	dc.b	"ead><title>Address"
 361  1686 205365747469  	dc.b	" Settings</title><"
 362  1698 7374796c653e  	dc.b	"style>.t1 { width:"
 363  16aa 203130307078  	dc.b	" 100px; }.t2 { wid"
 364  16bc 74683a203235  	dc.b	"th: 25px; }.t3 { w"
 365  16ce 696474683a20  	dc.b	"idth: 18px; }.t4 {"
 366  16e0 207769647468  	dc.b	" width: 40px; }td "
 367  16f2 7b2074657874  	dc.b	"{ text-align: cent"
 368  1704 65723b20626f  	dc.b	"er; border: 1px bl"
 369  1716 61636b20736f  	dc.b	"ack solid; }</styl"
 370  1728 653e3c2f6865  	dc.b	"e></head><body><h1"
 371  173a 3e4164647265  	dc.b	">Address Settings<"
 372  174c 2f6831        	dc.b	"/h1"
 373  174f 3e3c666f726d  	dc.b	"><form method='POS"
 374  1761 542720616374  	dc.b	"T' action='/'><tab"
 375  1773 6c653e3c7472  	dc.b	"le><tr><td class='"
 376  1785 7431273e4950  	dc.b	"t1'>IP Addr</td><t"
 377  1797 643e3c696e70  	dc.b	"d><input type='tex"
 378  17a9 7427206e616d  	dc.b	"t' name='b00' clas"
 379  17bb 733d27743227  	dc.b	"s='t2' value='%b00"
 380  17cd 272070617474  	dc.b	"' pattern='[0-9]{3"
 381  17df 7d2720746974  	dc.b	"}' title='Enter 00"
 382  17f1 3020746f2032  	dc.b	"0 to 255' maxlengt"
 383  1803 683d2733273e  	dc.b	"h='3'></td><td><in"
 384  1815 707574207479  	dc.b	"put type='text' na"
 385  1827 6d653d276230  	dc.b	"me='b01' class='t2"
 386  1839 272076616c75  	dc.b	"' value='%b01' pat"
 387  184b 746572        	dc.b	"ter"
 388  184e 6e3d275b302d  	dc.b	"n='[0-9]{3}' title"
 389  1860 3d27456e7465  	dc.b	"='Enter 000 to 255"
 390  1872 27206d61786c  	dc.b	"' maxlength='3'></"
 391  1884 74643e3c7464  	dc.b	"td><td><input type"
 392  1896 3d2774657874  	dc.b	"='text' name='b02'"
 393  18a8 20636c617373  	dc.b	" class='t2' value="
 394  18ba 272562303227  	dc.b	"'%b02' pattern='[0"
 395  18cc 2d395d7b337d  	dc.b	"-9]{3}' title='Ent"
 396  18de 657220303030  	dc.b	"er 000 to 255' max"
 397  18f0 6c656e677468  	dc.b	"length='3'></td><t"
 398  1902 643e3c696e70  	dc.b	"d><input type='tex"
 399  1914 7427206e616d  	dc.b	"t' name='b03' clas"
 400  1926 733d27743227  	dc.b	"s='t2' value='%b03"
 401  1938 272070617474  	dc.b	"' pattern='[0-9]{3"
 402  194a 7d2720        	dc.b	"}' "
 403  194d 7469746c653d  	dc.b	"title='Enter 000 t"
 404  195f 6f2032353527  	dc.b	"o 255' maxlength='"
 405  1971 33273e3c2f74  	dc.b	"3'></td></tr><tr><"
 406  1983 746420636c61  	dc.b	"td class='t1'>Gate"
 407  1995 7761793c2f74  	dc.b	"way</td><td><input"
 408  19a7 20747970653d  	dc.b	" type='text' name="
 409  19b9 276230342720  	dc.b	"'b04' class='t2' v"
 410  19cb 616c75653d27  	dc.b	"alue='%b04' patter"
 411  19dd 6e3d275b302d  	dc.b	"n='[0-9]{3}' title"
 412  19ef 3d27456e7465  	dc.b	"='Enter 000 to 255"
 413  1a01 27206d61786c  	dc.b	"' maxlength='3'></"
 414  1a13 74643e3c7464  	dc.b	"td><td><input type"
 415  1a25 3d2774657874  	dc.b	"='text' name='b05'"
 416  1a37 20636c617373  	dc.b	" class='t2' value="
 417  1a49 272562        	dc.b	"'%b"
 418  1a4c 303527207061  	dc.b	"05' pattern='[0-9]"
 419  1a5e 7b337d272074  	dc.b	"{3}' title='Enter "
 420  1a70 30303020746f  	dc.b	"000 to 255' maxlen"
 421  1a82 6774683d2733  	dc.b	"gth='3'></td><td><"
 422  1a94 696e70757420  	dc.b	"input type='text' "
 423  1aa6 6e616d653d27  	dc.b	"name='b06' class='"
 424  1ab8 743227207661  	dc.b	"t2' value='%b06' p"
 425  1aca 61747465726e  	dc.b	"attern='[0-9]{3}' "
 426  1adc 7469746c653d  	dc.b	"title='Enter 000 t"
 427  1aee 6f2032353527  	dc.b	"o 255' maxlength='"
 428  1b00 33273e3c2f74  	dc.b	"3'></td><td><input"
 429  1b12 20747970653d  	dc.b	" type='text' name="
 430  1b24 276230372720  	dc.b	"'b07' class='t2' v"
 431  1b36 616c75653d27  	dc.b	"alue='%b07' patter"
 432  1b48 6e3d27        	dc.b	"n='"
 433  1b4b 5b302d395d7b  	dc.b	"[0-9]{3}' title='E"
 434  1b5d 6e7465722030  	dc.b	"nter 000 to 255' m"
 435  1b6f 61786c656e67  	dc.b	"axlength='3'></td>"
 436  1b81 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 437  1b93 3d277431273e  	dc.b	"='t1'>Netmask</td>"
 438  1ba5 3c74643e3c69  	dc.b	"<td><input type='t"
 439  1bb7 65787427206e  	dc.b	"ext' name='b08' cl"
 440  1bc9 6173733d2774  	dc.b	"ass='t2' value='%b"
 441  1bdb 303827207061  	dc.b	"08' pattern='[0-9]"
 442  1bed 7b337d272074  	dc.b	"{3}' title='Enter "
 443  1bff 30303020746f  	dc.b	"000 to 255' maxlen"
 444  1c11 6774683d2733  	dc.b	"gth='3'></td><td><"
 445  1c23 696e70757420  	dc.b	"input type='text' "
 446  1c35 6e616d653d27  	dc.b	"name='b09' class='"
 447  1c47 743227        	dc.b	"t2'"
 448  1c4a 2076616c7565  	dc.b	" value='%b09' patt"
 449  1c5c 65726e3d275b  	dc.b	"ern='[0-9]{3}' tit"
 450  1c6e 6c653d27456e  	dc.b	"le='Enter 000 to 2"
 451  1c80 353527206d61  	dc.b	"55' maxlength='3'>"
 452  1c92 3c2f74643e3c  	dc.b	"</td><td><input ty"
 453  1ca4 70653d277465  	dc.b	"pe='text' name='b1"
 454  1cb6 302720636c61  	dc.b	"0' class='t2' valu"
 455  1cc8 653d27256231  	dc.b	"e='%b10' pattern='"
 456  1cda 5b302d395d7b  	dc.b	"[0-9]{3}' title='E"
 457  1cec 6e7465722030  	dc.b	"nter 000 to 255' m"
 458  1cfe 61786c656e67  	dc.b	"axlength='3'></td>"
 459  1d10 3c74643e3c69  	dc.b	"<td><input type='t"
 460  1d22 65787427206e  	dc.b	"ext' name='b11' cl"
 461  1d34 6173733d2774  	dc.b	"ass='t2' value='%b"
 462  1d46 313127        	dc.b	"11'"
 463  1d49 207061747465  	dc.b	" pattern='[0-9]{3}"
 464  1d5b 27207469746c  	dc.b	"' title='Enter 000"
 465  1d6d 20746f203235  	dc.b	" to 255' maxlength"
 466  1d7f 3d2733273e3c  	dc.b	"='3'></td></tr></t"
 467  1d91 61626c653e3c  	dc.b	"able><table><tr><t"
 468  1da3 6420636c6173  	dc.b	"d class='t1'>Port "
 469  1db5 20203c2f7464  	dc.b	"  </td><td><input "
 470  1dc7 747970653d27  	dc.b	"type='text' name='"
 471  1dd9 633030272063  	dc.b	"c00' class='t4' va"
 472  1deb 6c75653d2725  	dc.b	"lue='%c00' pattern"
 473  1dfd 3d275b302d39  	dc.b	"='[0-9]{5}' title="
 474  1e0f 27456e746572  	dc.b	"'Enter 00010 to 65"
 475  1e21 35333627206d  	dc.b	"536' maxlength='5'"
 476  1e33 3e3c2f74643e  	dc.b	"></td></tr></table"
 477  1e45 3e3c74        	dc.b	"><t"
 478  1e48 61626c653e3c  	dc.b	"able><tr><td class"
 479  1e5a 3d277431273e  	dc.b	"='t1'>MAC Address<"
 480  1e6c 2f74643e3c74  	dc.b	"/td><td><input typ"
 481  1e7e 653d27746578  	dc.b	"e='text' name='d00"
 482  1e90 2720636c6173  	dc.b	"' class='t3' value"
 483  1ea2 3d2725643030  	dc.b	"='%d00' pattern='["
 484  1eb4 302d39612d66  	dc.b	"0-9a-f]{2}' title="
 485  1ec6 27456e746572  	dc.b	"'Enter 00 to ff' m"
 486  1ed8 61786c656e67  	dc.b	"axlength='2'></td>"
 487  1eea 3c74643e3c69  	dc.b	"<td><input type='t"
 488  1efc 65787427206e  	dc.b	"ext' name='d01' cl"
 489  1f0e 6173733d2774  	dc.b	"ass='t3' value='%d"
 490  1f20 303127207061  	dc.b	"01' pattern='[0-9a"
 491  1f32 2d665d7b327d  	dc.b	"-f]{2}' title='Ent"
 492  1f44 657220        	dc.b	"er "
 493  1f47 303020746f20  	dc.b	"00 to ff' maxlengt"
 494  1f59 683d2732273e  	dc.b	"h='2'></td><td><in"
 495  1f6b 707574207479  	dc.b	"put type='text' na"
 496  1f7d 6d653d276430  	dc.b	"me='d02' class='t3"
 497  1f8f 272076616c75  	dc.b	"' value='%d02' pat"
 498  1fa1 7465726e3d27  	dc.b	"tern='[0-9a-f]{2}'"
 499  1fb3 207469746c65  	dc.b	" title='Enter 00 t"
 500  1fc5 6f2066662720  	dc.b	"o ff' maxlength='2"
 501  1fd7 273e3c2f7464  	dc.b	"'></td><td><input "
 502  1fe9 747970653d27  	dc.b	"type='text' name='"
 503  1ffb 643033272063  	dc.b	"d03' class='t3' va"
 504  200d 6c75653d2725  	dc.b	"lue='%d03' pattern"
 505  201f 3d275b302d39  	dc.b	"='[0-9a-f]{2}' tit"
 506  2031 6c653d27456e  	dc.b	"le='Enter 00 to ff"
 507  2043 27206d        	dc.b	"' m"
 508  2046 61786c656e67  	dc.b	"axlength='2'></td>"
 509  2058 3c74643e3c69  	dc.b	"<td><input type='t"
 510  206a 65787427206e  	dc.b	"ext' name='d04' cl"
 511  207c 6173733d2774  	dc.b	"ass='t3' value='%d"
 512  208e 303427207061  	dc.b	"04' pattern='[0-9a"
 513  20a0 2d665d7b327d  	dc.b	"-f]{2}' title='Ent"
 514  20b2 657220303020  	dc.b	"er 00 to ff' maxle"
 515  20c4 6e6774683d27  	dc.b	"ngth='2'></td><td>"
 516  20d6 3c696e707574  	dc.b	"<input type='text'"
 517  20e8 206e616d653d  	dc.b	" name='d05' class="
 518  20fa 277433272076  	dc.b	"'t3' value='%d05' "
 519  210c 706174746572  	dc.b	"pattern='[0-9a-f]{"
 520  211e 327d27207469  	dc.b	"2}' title='Enter 0"
 521  2130 3020746f2066  	dc.b	"0 to ff' maxlength"
 522  2142 3d2732        	dc.b	"='2"
 523  2145 273e3c2f7464  	dc.b	"'></td></tr></tabl"
 524  2157 653e3c627574  	dc.b	"e><button type='su"
 525  2169 626d69742720  	dc.b	"bmit' title='Saves"
 526  217b 20796f757220  	dc.b	" your changes then"
 527  218d 207265737461  	dc.b	" restarts the Netw"
 528  219f 6f726b204d6f  	dc.b	"ork Module'>Save</"
 529  21b1 627574746f6e  	dc.b	"button><button typ"
 530  21c3 653d27726573  	dc.b	"e='reset' title='U"
 531  21d5 6e2d646f6573  	dc.b	"n-does any changes"
 532  21e7 207468617420  	dc.b	" that have not bee"
 533  21f9 6e2073617665  	dc.b	"n saved'>Undo All<"
 534  220b 2f627574746f  	dc.b	"/button></form><p "
 535  221d 6c696e652d68  	dc.b	"line-height 20px>U"
 536  222f 736520636175  	dc.b	"se caution when ch"
 537  2241 616e67        	dc.b	"ang"
 538  2244 696e67207468  	dc.b	"ing the above. If "
 539  2256 796f75206d61  	dc.b	"you make a mistake"
 540  2268 20796f75206d  	dc.b	" you may have to<b"
 541  227a 723e72657374  	dc.b	"r>restore factory "
 542  228c 64656661756c  	dc.b	"defaults by holdin"
 543  229e 6720646f776e  	dc.b	"g down the reset b"
 544  22b0 7574746f6e20  	dc.b	"utton for 10 secon"
 545  22c2 64732e3c6272  	dc.b	"ds.<br><br>Make su"
 546  22d4 726520746865  	dc.b	"re the MAC you ass"
 547  22e6 69676e206973  	dc.b	"ign is unique to y"
 548  22f8 6f7572206c6f  	dc.b	"our local network."
 549  230a 205265636f6d  	dc.b	" Recommended<br>is"
 550  231c 207468617420  	dc.b	" that you just inc"
 551  232e 72656d656e74  	dc.b	"rement the lowest "
 552  2340 6f6374        	dc.b	"oct"
 553  2343 657420616e64  	dc.b	"et and then label "
 554  2355 796f75722064  	dc.b	"your devices for<b"
 555  2367 723e66757475  	dc.b	"r>future reference"
 556  2379 2e3c62723e3c  	dc.b	".<br><br>If you ch"
 557  238b 616e67652074  	dc.b	"ange the highest o"
 558  239d 63746574206f  	dc.b	"ctet of the MAC yo"
 559  23af 75204d555354  	dc.b	"u MUST use an even"
 560  23c1 206e756d6265  	dc.b	" number to<br>form"
 561  23d3 206120756e69  	dc.b	" a unicast address"
 562  23e5 2e2030302c20  	dc.b	". 00, 02, ... fc, "
 563  23f7 666520657463  	dc.b	"fe etc work fine. "
 564  2409 30312c203033  	dc.b	"01, 03 ... fd, ff "
 565  241b 61726520666f  	dc.b	"are for<br>multica"
 566  242d 737420616e64  	dc.b	"st and will not wo"
 567  243f 726b2e        	dc.b	"rk."
 568  2442 3c2f703e3c66  	dc.b	"</p><form style='d"
 569  2454 6973706c6179  	dc.b	"isplay: inline' ac"
 570  2466 74696f6e3d27  	dc.b	"tion='%x00http://1"
 571  2478 39322e313638  	dc.b	"92.168.001.004:080"
 572  248a 38302f393127  	dc.b	"80/91' method='GET"
 573  249c 273e3c627574  	dc.b	"'><button title='S"
 574  24ae 617665206669  	dc.b	"ave first! This bu"
 575  24c0 74746f6e2077  	dc.b	"tton will not save"
 576  24d2 20796f757220  	dc.b	" your changes'>Reb"
 577  24e4 6f6f743c2f62  	dc.b	"oot</button></form"
 578  24f6 3e266e627370  	dc.b	">&nbsp&nbspNOTE: R"
 579  2508 65626f6f7420  	dc.b	"eboot may cause th"
 580  251a 652072656c61  	dc.b	"e relays to cycle."
 581  252c 3c62723e3c62  	dc.b	"<br><br><form styl"
 582  253e 653d27        	dc.b	"e='"
 583  2541 646973706c61  	dc.b	"display: inline' a"
 584  2553 6374696f6e3d  	dc.b	"ction='%x00http://"
 585  2565 3139322e3136  	dc.b	"192.168.001.004:08"
 586  2577 3038302f3630  	dc.b	"080/60' method='GE"
 587  2589 54273e3c6275  	dc.b	"T'><button title='"
 588  259b 536176652066  	dc.b	"Save first! This b"
 589  25ad 7574746f6e20  	dc.b	"utton will not sav"
 590  25bf 6520796f7572  	dc.b	"e your changes'>Re"
 591  25d1 6c617920436f  	dc.b	"lay Controls</butt"
 592  25e3 6f6e3e3c2f66  	dc.b	"on></form><form st"
 593  25f5 796c653d2764  	dc.b	"yle='display: inli"
 594  2607 6e6527206163  	dc.b	"ne' action='%x00ht"
 595  2619 74703a2f2f31  	dc.b	"tp://192.168.001.0"
 596  262b 30343a303830  	dc.b	"04:08080/66' metho"
 597  263d 643d27        	dc.b	"d='"
 598  2640 474554273e3c  	dc.b	"GET'><button title"
 599  2652 3d2753617665  	dc.b	"='Save first! This"
 600  2664 20627574746f  	dc.b	" button will not s"
 601  2676 61766520796f  	dc.b	"ave your changes'>"
 602  2688 4e6574776f72  	dc.b	"Network Statistics"
 603  269a 3c2f62757474  	dc.b	"</button></form><f"
 604  26ac 6f726d207374  	dc.b	"orm style='display"
 605  26be 3a20696e6c69  	dc.b	": inline' action='"
 606  26d0 257830306874  	dc.b	"%x00http://192.168"
 607  26e2 2e3030312e30  	dc.b	".001.004:08080/63'"
 608  26f4 206d6574686f  	dc.b	" method='GET'><but"
 609  2706 746f6e207469  	dc.b	"ton title='Save fi"
 610  2718 727374212054  	dc.b	"rst! This button w"
 611  272a 696c6c206e6f  	dc.b	"ill not save your "
 612  273c 636861        	dc.b	"cha"
 613  273f 6e676573273e  	dc.b	"nges'>Help</button"
 614  2751 3e3c2f666f72  	dc.b	"></form></body></h"
 615  2763 746d6c3e00    	dc.b	"tml>",0
 616  2768               L12_g_HtmlPageHelp:
 617  2768 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 618  277a 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 619  278c 6561643e3c74  	dc.b	"ead><title>Help Pa"
 620  279e 67653c2f7469  	dc.b	"ge</title><style>t"
 621  27b0 64207b207769  	dc.b	"d { width: 140px; "
 622  27c2 70616464696e  	dc.b	"padding: 0px; }</s"
 623  27d4 74796c653e3c  	dc.b	"tyle></head><body>"
 624  27e6 3c68313e4865  	dc.b	"<h1>Help Page 1</h"
 625  27f8 313e3c70206c  	dc.b	"1><p line-height 2"
 626  280a 3070783e416e  	dc.b	"0px>An alternative"
 627  281c 20746f207573  	dc.b	" to using the web "
 628  282e 696e74657266  	dc.b	"interface for chan"
 629  2840 67696e672072  	dc.b	"ging relay states "
 630  2852 697320746f20  	dc.b	"is to send relay<b"
 631  2864 723e73        	dc.b	"r>s"
 632  2867 706563696669  	dc.b	"pecific html comma"
 633  2879 6e64732e2045  	dc.b	"nds. Enter http://"
 634  288b 49503a506f72  	dc.b	"IP:Port/xx where<b"
 635  289d 723e2d204950  	dc.b	"r>- IP = the devic"
 636  28af 652049502041  	dc.b	"e IP Address, for "
 637  28c1 6578616d706c  	dc.b	"example 192.168.1."
 638  28d3 343c62723e2d  	dc.b	"4<br>- Port = the "
 639  28e5 646576696365  	dc.b	"device Port number"
 640  28f7 2c20666f7220  	dc.b	", for example 8080"
 641  2909 3c62723e2d20  	dc.b	"<br>- xx = one of "
 642  291b 74686520636f  	dc.b	"the codes below:<b"
 643  292d 723e3c746162  	dc.b	"r><table><tr><td>0"
 644  293f 30203d205265  	dc.b	"0 = Relay-01 OFF</"
 645  2951 74643e3c7464  	dc.b	"td><td>09 = Relay-"
 646  2963 303520        	dc.b	"05 "
 647  2966 4f46463c2f74  	dc.b	"OFF</td><td>17 = R"
 648  2978 656c61792d30  	dc.b	"elay-09 OFF</td><t"
 649  298a 643e3235203d  	dc.b	"d>25 = Relay-13 OF"
 650  299c 463c62723e3c  	dc.b	"F<br></td></tr><tr"
 651  29ae 3e3c74643e30  	dc.b	"><td>01 = Relay-01"
 652  29c0 20204f4e3c2f  	dc.b	"  ON</td><td>10 = "
 653  29d2 52656c61792d  	dc.b	"Relay-05  ON</td><"
 654  29e4 74643e313820  	dc.b	"td>18 = Relay-09  "
 655  29f6 4f4e3c2f7464  	dc.b	"ON</td><td>26 = Re"
 656  2a08 6c61792d3133  	dc.b	"lay-13  ON<br></td"
 657  2a1a 3e3c2f74723e  	dc.b	"></tr><tr><td>02 ="
 658  2a2c 2052656c6179  	dc.b	" Relay-02 OFF</td>"
 659  2a3e 3c74643e3131  	dc.b	"<td>11 = Relay-06 "
 660  2a50 4f46463c2f74  	dc.b	"OFF</td><td>19 = R"
 661  2a62 656c61        	dc.b	"ela"
 662  2a65 792d3130204f  	dc.b	"y-10 OFF</td><td>2"
 663  2a77 37203d205265  	dc.b	"7 = Relay-14 OFF<b"
 664  2a89 723e3c2f7464  	dc.b	"r></td></tr><tr><t"
 665  2a9b 643e3033203d  	dc.b	"d>03 = Relay-02  O"
 666  2aad 4e3c2f74643e  	dc.b	"N</td><td>12 = Rel"
 667  2abf 61792d303620  	dc.b	"ay-06  ON</td><td>"
 668  2ad1 3230203d2052  	dc.b	"20 = Relay-10  ON<"
 669  2ae3 2f74643e3c74  	dc.b	"/td><td>28 = Relay"
 670  2af5 2d313420204f  	dc.b	"-14  ON<br></td></"
 671  2b07 74723e3c7472  	dc.b	"tr><tr><td>04 = Re"
 672  2b19 6c61792d3033  	dc.b	"lay-03 OFF</td><td"
 673  2b2b 3e3133203d20  	dc.b	">13 = Relay-07 OFF"
 674  2b3d 3c2f74643e3c  	dc.b	"</td><td>21 = Rela"
 675  2b4f 792d3131204f  	dc.b	"y-11 OFF</td><td>2"
 676  2b61 39203d        	dc.b	"9 ="
 677  2b64 2052656c6179  	dc.b	" Relay-15 OFF<br><"
 678  2b76 2f74643e3c2f  	dc.b	"/td></tr><tr><td>0"
 679  2b88 35203d205265  	dc.b	"5 = Relay-03  ON</"
 680  2b9a 74643e3c7464  	dc.b	"td><td>14 = Relay-"
 681  2bac 303720204f4e  	dc.b	"07  ON</td><td>22 "
 682  2bbe 3d2052656c61  	dc.b	"= Relay-11  ON</td"
 683  2bd0 3e3c74643e33  	dc.b	"><td>30 = Relay-15"
 684  2be2 20204f4e3c62  	dc.b	"  ON<br></td></tr>"
 685  2bf4 3c74723e3c74  	dc.b	"<tr><td>07 = Relay"
 686  2c06 2d3034204f46  	dc.b	"-04 OFF</td><td>15"
 687  2c18 203d2052656c  	dc.b	" = Relay-08 OFF</t"
 688  2c2a 643e3c74643e  	dc.b	"d><td>23 = Relay-1"
 689  2c3c 32204f46463c  	dc.b	"2 OFF</td><td>31 ="
 690  2c4e 2052656c6179  	dc.b	" Relay-16 OFF<br><"
 691  2c60 2f7464        	dc.b	"/td"
 692  2c63 3e3c2f74723e  	dc.b	"></tr><tr><td>08 ="
 693  2c75 2052656c6179  	dc.b	" Relay-04  ON</td>"
 694  2c87 3c74643e3136  	dc.b	"<td>16 = Relay-08 "
 695  2c99 204f4e3c2f74  	dc.b	" ON</td><td>24 = R"
 696  2cab 656c61792d31  	dc.b	"elay-12  ON</td><t"
 697  2cbd 643e3332203d  	dc.b	"d>32 = Relay-16  O"
 698  2ccf 4e3c62723e3c  	dc.b	"N<br></td></tr></t"
 699  2ce1 61626c653e35  	dc.b	"able>55 = All Rela"
 700  2cf3 7973204f4e3c  	dc.b	"ys ON<br>56 = All "
 701  2d05 52656c617973  	dc.b	"Relays OFF<br><br>"
 702  2d17 54686520666f  	dc.b	"The following are "
 703  2d29 616c736f2061  	dc.b	"also available:<br"
 704  2d3b 3e3630203d20  	dc.b	">60 = Show Relay C"
 705  2d4d 6f6e74726f6c  	dc.b	"ontrol page<br>61 "
 706  2d5f 3d2053        	dc.b	"= S"
 707  2d62 686f77204164  	dc.b	"how Address Settin"
 708  2d74 677320706167  	dc.b	"gs page<br>63 = Sh"
 709  2d86 6f772048656c  	dc.b	"ow Help Page 1<br>"
 710  2d98 3634203d2053  	dc.b	"64 = Show Help Pag"
 711  2daa 6520323c6272  	dc.b	"e 2<br>65 = Flash "
 712  2dbc 4c45443c6272  	dc.b	"LED<br>66 = Show S"
 713  2dce 746174697374  	dc.b	"tatistics<br>67 = "
 714  2de0 436c65617220  	dc.b	"Clear Statistics<b"
 715  2df2 723e3931203d  	dc.b	"r>91 = Reboot<br>9"
 716  2e04 39203d205368  	dc.b	"9 = Show Short For"
 717  2e16 6d2052656c61  	dc.b	"m Relay Settings<b"
 718  2e28 723e3c2f703e  	dc.b	"r></p><form style="
 719  2e3a 27646973706c  	dc.b	"'display: inline' "
 720  2e4c 616374696f6e  	dc.b	"action='%x00http:/"
 721  2e5e 2f3139        	dc.b	"/19"
 722  2e61 322e3136382e  	dc.b	"2.168.001.004:0808"
 723  2e73 302f36342720  	dc.b	"0/64' method='GET'"
 724  2e85 3e3c62757474  	dc.b	"><button title='Go"
 725  2e97 20746f206e65  	dc.b	" to next Help page"
 726  2ea9 273e4e657874  	dc.b	"'>Next Help Page</"
 727  2ebb 627574746f6e  	dc.b	"button></form></bo"
 728  2ecd 64793e3c2f68  	dc.b	"dy></html>",0
 729  2ed8               L32_g_HtmlPageHelp2:
 730  2ed8 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 731  2eea 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 732  2efc 6561643e3c74  	dc.b	"ead><title>Help Pa"
 733  2f0e 676520323c2f  	dc.b	"ge 2</title></head"
 734  2f20 3e3c626f6479  	dc.b	"><body><h1>Help Pa"
 735  2f32 676520323c2f  	dc.b	"ge 2</h1><p line-h"
 736  2f44 656967687420  	dc.b	"eight 20px>IP Addr"
 737  2f56 6573732c2047  	dc.b	"ess, Gateway Addre"
 738  2f68 73732c204e65  	dc.b	"ss, Netmask, Port,"
 739  2f7a 20616e64204d  	dc.b	" and MAC Address c"
 740  2f8c 616e206f6e6c  	dc.b	"an only be<br>chan"
 741  2f9e 676564207669  	dc.b	"ged via the web in"
 742  2fb0 746572666163  	dc.b	"terface. If the de"
 743  2fc2 766963652062  	dc.b	"vice becomes inacc"
 744  2fd4 657373        	dc.b	"ess"
 745  2fd7 69626c652079  	dc.b	"ible you can<br>re"
 746  2fe9 73657420746f  	dc.b	"set to factory def"
 747  2ffb 61756c747320  	dc.b	"aults by holding t"
 748  300d 686520726573  	dc.b	"he reset button do"
 749  301f 776e20666f72  	dc.b	"wn for 10 seconds."
 750  3031 3c62723e4465  	dc.b	"<br>Defaults:<br> "
 751  3043 495020313932  	dc.b	"IP 192.168.1.4<br>"
 752  3055 204761746577  	dc.b	" Gateway 192.168.1"
 753  3067 2e313c62723e  	dc.b	".1<br> Netmask 255"
 754  3079 2e3235352e32  	dc.b	".255.255.0<br> Por"
 755  308b 742030383038  	dc.b	"t 08080<br> MAC c2"
 756  309d 2d34642d3639  	dc.b	"-4d-69-6b-65-00<br"
 757  30af 3e3c62723e43  	dc.b	"><br>Code Revision"
 758  30c1 203230323030  	dc.b	" 20200709 1200</p>"
 759  30d3 3c666f        	dc.b	"<fo"
 760  30d6 726d20737479  	dc.b	"rm style='display:"
 761  30e8 20696e6c696e  	dc.b	" inline' action='%"
 762  30fa 783030687474  	dc.b	"x00http://192.168."
 763  310c 3030312e3030  	dc.b	"001.004:08080/60' "
 764  311e 6d6574686f64  	dc.b	"method='GET'><butt"
 765  3130 6f6e20746974  	dc.b	"on title='Go to Re"
 766  3142 6c617920436f  	dc.b	"lay Control Page'>"
 767  3154 52656c617920  	dc.b	"Relay Controls</bu"
 768  3166 74746f6e3e3c  	dc.b	"tton></form></body"
 769  3178 3e3c2f68746d  	dc.b	"></html>",0
 770  3181               L52_g_HtmlPageStats:
 771  3181 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 772  3193 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 773  31a5 6561643e3c74  	dc.b	"ead><title>Network"
 774  31b7 205374617469  	dc.b	" Statistics</title"
 775  31c9 3e3c7374796c  	dc.b	"><style>.t1 { widt"
 776  31db 683a20313030  	dc.b	"h: 100px; }.t2 { w"
 777  31ed 696474683a20  	dc.b	"idth: 450px; }td {"
 778  31ff 20626f726465  	dc.b	" border: 1px black"
 779  3211 20736f6c6964  	dc.b	" solid; }</style><"
 780  3223 2f686561643e  	dc.b	"/head><body><h1>Ne"
 781  3235 74776f726b20  	dc.b	"twork Statistics</"
 782  3247 68313e3c703e  	dc.b	"h1><p>Values shown"
 783  3259 206172652073  	dc.b	" are since last po"
 784  326b 776572206f6e  	dc.b	"wer on or reset</p"
 785  327d 3e3c74        	dc.b	"><t"
 786  3280 61626c653e3c  	dc.b	"able><tr><td class"
 787  3292 3d277431273e  	dc.b	"='t1'>%e00xxxxxxxx"
 788  32a4 78783c2f7464  	dc.b	"xx</td><td class='"
 789  32b6 7432273e4472  	dc.b	"t2'>Dropped packet"
 790  32c8 732061742074  	dc.b	"s at the IP layer<"
 791  32da 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 792  32ec 6c6173733d27  	dc.b	"lass='t1'>%e01xxxx"
 793  32fe 787878787878  	dc.b	"xxxxxx</td><td cla"
 794  3310 73733d277432  	dc.b	"ss='t2'>Received p"
 795  3322 61636b657473  	dc.b	"ackets at the IP l"
 796  3334 617965723c2f  	dc.b	"ayer</td></tr><tr>"
 797  3346 3c746420636c  	dc.b	"<td class='t1'>%e0"
 798  3358 327878787878  	dc.b	"2xxxxxxxxxx</td><t"
 799  336a 6420636c6173  	dc.b	"d class='t2'>Sent "
 800  337c 706163        	dc.b	"pac"
 801  337f 6b6574732061  	dc.b	"kets at the IP lay"
 802  3391 65723c2f7464  	dc.b	"er</td></tr><tr><t"
 803  33a3 6420636c6173  	dc.b	"d class='t1'>%e03x"
 804  33b5 787878787878  	dc.b	"xxxxxxxxx</td><td "
 805  33c7 636c6173733d  	dc.b	"class='t2'>Packets"
 806  33d9 2064726f7070  	dc.b	" dropped due to wr"
 807  33eb 6f6e67204950  	dc.b	"ong IP version or "
 808  33fd 686561646572  	dc.b	"header length</td>"
 809  340f 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 810  3421 3d277431273e  	dc.b	"='t1'>%e04xxxxxxxx"
 811  3433 78783c2f7464  	dc.b	"xx</td><td class='"
 812  3445 7432273e5061  	dc.b	"t2'>Packets droppe"
 813  3457 642064756520  	dc.b	"d due to wrong IP "
 814  3469 6c656e677468  	dc.b	"length, high byte<"
 815  347b 2f7464        	dc.b	"/td"
 816  347e 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 817  3490 733d27743127  	dc.b	"s='t1'>%e05xxxxxxx"
 818  34a2 7878783c2f74  	dc.b	"xxx</td><td class="
 819  34b4 277432273e50  	dc.b	"'t2'>Packets dropp"
 820  34c6 656420647565  	dc.b	"ed due to wrong IP"
 821  34d8 206c656e6774  	dc.b	" length, low byte<"
 822  34ea 2f74643e3c2f  	dc.b	"/td></tr><tr><td c"
 823  34fc 6c6173733d27  	dc.b	"lass='t1'>%e06xxxx"
 824  350e 787878787878  	dc.b	"xxxxxx</td><td cla"
 825  3520 73733d277432  	dc.b	"ss='t2'>Packets dr"
 826  3532 6f7070656420  	dc.b	"opped since they w"
 827  3544 657265204950  	dc.b	"ere IP fragments</"
 828  3556 74643e3c2f74  	dc.b	"td></tr><tr><td cl"
 829  3568 6173733d2774  	dc.b	"ass='t1'>%e07xxxxx"
 830  357a 787878        	dc.b	"xxx"
 831  357d 78783c2f7464  	dc.b	"xx</td><td class='"
 832  358f 7432273e5061  	dc.b	"t2'>Packets droppe"
 833  35a1 642064756520  	dc.b	"d due to IP checks"
 834  35b3 756d20657272  	dc.b	"um errors</td></tr"
 835  35c5 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 836  35d7 273e25653038  	dc.b	"'>%e08xxxxxxxxxx</"
 837  35e9 74643e3c7464  	dc.b	"td><td class='t2'>"
 838  35fb 5061636b6574  	dc.b	"Packets dropped si"
 839  360d 6e6365207468  	dc.b	"nce they were not "
 840  361f 49434d50206f  	dc.b	"ICMP or TCP</td></"
 841  3631 74723e3c7472  	dc.b	"tr><tr><td class='"
 842  3643 7431273e2565  	dc.b	"t1'>%e09xxxxxxxxxx"
 843  3655 3c2f74643e3c  	dc.b	"</td><td class='t2"
 844  3667 273e44726f70  	dc.b	"'>Dropped ICMP pac"
 845  3679 6b6574        	dc.b	"ket"
 846  367c 733c2f74643e  	dc.b	"s</td></tr><tr><td"
 847  368e 20636c617373  	dc.b	" class='t1'>%e10xx"
 848  36a0 787878787878  	dc.b	"xxxxxxxx</td><td c"
 849  36b2 6c6173733d27  	dc.b	"lass='t2'>Received"
 850  36c4 2049434d5020  	dc.b	" ICMP packets</td>"
 851  36d6 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 852  36e8 3d277431273e  	dc.b	"='t1'>%e11xxxxxxxx"
 853  36fa 78783c2f7464  	dc.b	"xx</td><td class='"
 854  370c 7432273e5365  	dc.b	"t2'>Sent ICMP pack"
 855  371e 6574733c2f74  	dc.b	"ets</td></tr><tr><"
 856  3730 746420636c61  	dc.b	"td class='t1'>%e12"
 857  3742 787878787878  	dc.b	"xxxxxxxxxx</td><td"
 858  3754 20636c617373  	dc.b	" class='t2'>ICMP p"
 859  3766 61636b657473  	dc.b	"ackets with a wron"
 860  3778 672074        	dc.b	"g t"
 861  377b 7970653c2f74  	dc.b	"ype</td></tr><tr><"
 862  378d 746420636c61  	dc.b	"td class='t1'>%e13"
 863  379f 787878787878  	dc.b	"xxxxxxxxxx</td><td"
 864  37b1 20636c617373  	dc.b	" class='t2'>Droppe"
 865  37c3 642054435020  	dc.b	"d TCP segments</td"
 866  37d5 3e3c2f74723e  	dc.b	"></tr><tr><td clas"
 867  37e7 733d27743127  	dc.b	"s='t1'>%e14xxxxxxx"
 868  37f9 7878783c2f74  	dc.b	"xxx</td><td class="
 869  380b 277432273e52  	dc.b	"'t2'>Received TCP "
 870  381d 7365676d656e  	dc.b	"segments</td></tr>"
 871  382f 3c74723e3c74  	dc.b	"<tr><td class='t1'"
 872  3841 3e2565313578  	dc.b	">%e15xxxxxxxxxx</t"
 873  3853 643e3c746420  	dc.b	"d><td class='t2'>S"
 874  3865 656e74205443  	dc.b	"ent TCP segments</"
 875  3877 74643e        	dc.b	"td>"
 876  387a 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 877  388c 3d277431273e  	dc.b	"='t1'>%e16xxxxxxxx"
 878  389e 78783c2f7464  	dc.b	"xx</td><td class='"
 879  38b0 7432273e5443  	dc.b	"t2'>TCP segments w"
 880  38c2 697468206120  	dc.b	"ith a bad checksum"
 881  38d4 3c2f74643e3c  	dc.b	"</td></tr><tr><td "
 882  38e6 636c6173733d  	dc.b	"class='t1'>%e17xxx"
 883  38f8 787878787878  	dc.b	"xxxxxxx</td><td cl"
 884  390a 6173733d2774  	dc.b	"ass='t2'>TCP segme"
 885  391c 6e7473207769  	dc.b	"nts with a bad ACK"
 886  392e 206e756d6265  	dc.b	" number</td></tr><"
 887  3940 74723e3c7464  	dc.b	"tr><td class='t1'>"
 888  3952 256531387878  	dc.b	"%e18xxxxxxxxxx</td"
 889  3964 3e3c74642063  	dc.b	"><td class='t2'>Re"
 890  3976 636569        	dc.b	"cei"
 891  3979 766564205443  	dc.b	"ved TCP RST (reset"
 892  398b 29207365676d  	dc.b	") segments</td></t"
 893  399d 723e3c74723e  	dc.b	"r><tr><td class='t"
 894  39af 31273e256531  	dc.b	"1'>%e19xxxxxxxxxx<"
 895  39c1 2f74643e3c74  	dc.b	"/td><td class='t2'"
 896  39d3 3e5265747261  	dc.b	">Retransmitted TCP"
 897  39e5 207365676d65  	dc.b	" segments</td></tr"
 898  39f7 3e3c74723e3c  	dc.b	"><tr><td class='t1"
 899  3a09 273e25653230  	dc.b	"'>%e20xxxxxxxxxx</"
 900  3a1b 74643e3c7464  	dc.b	"td><td class='t2'>"
 901  3a2d 44726f707065  	dc.b	"Dropped SYNs due t"
 902  3a3f 6f20746f6f20  	dc.b	"o too few connecti"
 903  3a51 6f6e73206176  	dc.b	"ons avaliable</td>"
 904  3a63 3c2f74723e3c  	dc.b	"</tr><tr><td class"
 905  3a75 3d2774        	dc.b	"='t"
 906  3a78 31273e256532  	dc.b	"1'>%e21xxxxxxxxxx<"
 907  3a8a 2f74643e3c74  	dc.b	"/td><td class='t2'"
 908  3a9c 3e53594e7320  	dc.b	">SYNs for closed p"
 909  3aae 6f7274732c20  	dc.b	"orts, triggering a"
 910  3ac0 205253543c2f  	dc.b	" RST</td></tr></ta"
 911  3ad2 626c653e3c66  	dc.b	"ble><form style='d"
 912  3ae4 6973706c6179  	dc.b	"isplay: inline' ac"
 913  3af6 74696f6e3d27  	dc.b	"tion='%x00http://1"
 914  3b08 39322e313638  	dc.b	"92.168.001.004:080"
 915  3b1a 38302f363027  	dc.b	"80/60' method='GET"
 916  3b2c 273e3c627574  	dc.b	"'><button title='G"
 917  3b3e 6f20746f2052  	dc.b	"o to Relay Control"
 918  3b50 205061676527  	dc.b	" Page'>Relay Contr"
 919  3b62 6f6c733c2f62  	dc.b	"ols</button></form"
 920  3b74 3e3c66        	dc.b	"><f"
 921  3b77 6f726d207374  	dc.b	"orm style='display"
 922  3b89 3a20696e6c69  	dc.b	": inline' action='"
 923  3b9b 257830306874  	dc.b	"%x00http://192.168"
 924  3bad 2e3030312e30  	dc.b	".001.004:08080/67'"
 925  3bbf 206d6574686f  	dc.b	" method='GET'><but"
 926  3bd1 746f6e207469  	dc.b	"ton title='Clear S"
 927  3be3 746174697374  	dc.b	"tatistics'>Clear S"
 928  3bf5 746174697374  	dc.b	"tatistics</button>"
 929  3c07 3c2f666f726d  	dc.b	"</form></body></ht"
 930  3c19 6d6c3e00      	dc.b	"ml>",0
 931  3c1d               L72_g_HtmlPageRstate:
 932  3c1d 3c21444f4354  	dc.b	"<!DOCTYPE html><ht"
 933  3c2f 6d6c206c616e  	dc.b	"ml lang='en-US'><h"
 934  3c41 6561643e3c74  	dc.b	"ead><title>Help Pa"
 935  3c53 676520323c2f  	dc.b	"ge 2</title></head"
 936  3c65 3e3c626f6479  	dc.b	"><body><p>%f00xxxx"
 937  3c77 787878787878  	dc.b	"xxxxxxxxxxxx</p></"
 938  3c89 626f64793e3c  	dc.b	"body></html>",0
1004                     ; 612 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1004                     ; 613 {
1006                     	switch	.text
1007  0000               L3_CopyStringP:
1009  0000 89            	pushw	x
1010  0001 5203          	subw	sp,#3
1011       00000003      OFST:	set	3
1014                     ; 618   nBytes = 0;
1016  0003 5f            	clrw	x
1018  0004 2014          	jra	L17
1019  0006               L56:
1020                     ; 620     **ppBuffer = Character;
1022  0006 1e04          	ldw	x,(OFST+1,sp)
1023  0008 fe            	ldw	x,(x)
1024  0009 f7            	ld	(x),a
1025                     ; 621     *ppBuffer = *ppBuffer + 1;
1027  000a 1e04          	ldw	x,(OFST+1,sp)
1028  000c 9093          	ldw	y,x
1029  000e fe            	ldw	x,(x)
1030  000f 5c            	incw	x
1031  0010 90ff          	ldw	(y),x
1032                     ; 622     pString = pString + 1;
1034  0012 1e08          	ldw	x,(OFST+5,sp)
1035  0014 5c            	incw	x
1036  0015 1f08          	ldw	(OFST+5,sp),x
1037                     ; 623     nBytes++;
1039  0017 1e01          	ldw	x,(OFST-2,sp)
1040  0019 5c            	incw	x
1041  001a               L17:
1042  001a 1f01          	ldw	(OFST-2,sp),x
1044                     ; 619   while ((Character = pString[0]) != '\0') {
1044                     ; 620     **ppBuffer = Character;
1044                     ; 621     *ppBuffer = *ppBuffer + 1;
1044                     ; 622     pString = pString + 1;
1044                     ; 623     nBytes++;
1046  001c 1e08          	ldw	x,(OFST+5,sp)
1047  001e f6            	ld	a,(x)
1048  001f 6b03          	ld	(OFST+0,sp),a
1050  0021 26e3          	jrne	L56
1051                     ; 625   return nBytes;
1053  0023 1e01          	ldw	x,(OFST-2,sp)
1056  0025 5b05          	addw	sp,#5
1057  0027 81            	ret	
1102                     ; 629 static uint16_t CopyValue(uint8_t** ppBuffer, uint32_t nValue)
1102                     ; 630 {
1103                     	switch	.text
1104  0028               L5_CopyValue:
1106  0028 89            	pushw	x
1107       00000000      OFST:	set	0
1110                     ; 638   emb_itoa(nValue, OctetArray, 10, 5);
1112  0029 4b05          	push	#5
1113  002b 4b0a          	push	#10
1114  002d ae0000        	ldw	x,#_OctetArray
1115  0030 89            	pushw	x
1116  0031 1e0b          	ldw	x,(OFST+11,sp)
1117  0033 89            	pushw	x
1118  0034 1e0b          	ldw	x,(OFST+11,sp)
1119  0036 89            	pushw	x
1120  0037 ad53          	call	_emb_itoa
1122  0039 5b08          	addw	sp,#8
1123                     ; 640   **ppBuffer = OctetArray[0];
1125  003b 1e01          	ldw	x,(OFST+1,sp)
1126  003d fe            	ldw	x,(x)
1127  003e c60000        	ld	a,_OctetArray
1128  0041 f7            	ld	(x),a
1129                     ; 641   *ppBuffer = *ppBuffer + 1;
1131  0042 1e01          	ldw	x,(OFST+1,sp)
1132  0044 9093          	ldw	y,x
1133  0046 fe            	ldw	x,(x)
1134  0047 5c            	incw	x
1135  0048 90ff          	ldw	(y),x
1136                     ; 643   **ppBuffer = OctetArray[1];
1138  004a 1e01          	ldw	x,(OFST+1,sp)
1139  004c fe            	ldw	x,(x)
1140  004d c60001        	ld	a,_OctetArray+1
1141  0050 f7            	ld	(x),a
1142                     ; 644   *ppBuffer = *ppBuffer + 1;
1144  0051 1e01          	ldw	x,(OFST+1,sp)
1145  0053 9093          	ldw	y,x
1146  0055 fe            	ldw	x,(x)
1147  0056 5c            	incw	x
1148  0057 90ff          	ldw	(y),x
1149                     ; 646   **ppBuffer = OctetArray[2];
1151  0059 1e01          	ldw	x,(OFST+1,sp)
1152  005b fe            	ldw	x,(x)
1153  005c c60002        	ld	a,_OctetArray+2
1154  005f f7            	ld	(x),a
1155                     ; 647   *ppBuffer = *ppBuffer + 1;
1157  0060 1e01          	ldw	x,(OFST+1,sp)
1158  0062 9093          	ldw	y,x
1159  0064 fe            	ldw	x,(x)
1160  0065 5c            	incw	x
1161  0066 90ff          	ldw	(y),x
1162                     ; 649   **ppBuffer = OctetArray[3];
1164  0068 1e01          	ldw	x,(OFST+1,sp)
1165  006a fe            	ldw	x,(x)
1166  006b c60003        	ld	a,_OctetArray+3
1167  006e f7            	ld	(x),a
1168                     ; 650   *ppBuffer = *ppBuffer + 1;
1170  006f 1e01          	ldw	x,(OFST+1,sp)
1171  0071 9093          	ldw	y,x
1172  0073 fe            	ldw	x,(x)
1173  0074 5c            	incw	x
1174  0075 90ff          	ldw	(y),x
1175                     ; 652   **ppBuffer = OctetArray[4];
1177  0077 1e01          	ldw	x,(OFST+1,sp)
1178  0079 fe            	ldw	x,(x)
1179  007a c60004        	ld	a,_OctetArray+4
1180  007d f7            	ld	(x),a
1181                     ; 653   *ppBuffer = *ppBuffer + 1;
1183  007e 1e01          	ldw	x,(OFST+1,sp)
1184  0080 9093          	ldw	y,x
1185  0082 fe            	ldw	x,(x)
1186  0083 5c            	incw	x
1187  0084 90ff          	ldw	(y),x
1188                     ; 655   return 5;
1190  0086 ae0005        	ldw	x,#5
1193  0089 5b02          	addw	sp,#2
1194  008b 81            	ret	
1266                     ; 659 char* emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
1266                     ; 660 {
1267                     	switch	.text
1268  008c               _emb_itoa:
1270  008c 5206          	subw	sp,#6
1271       00000006      OFST:	set	6
1274                     ; 675   for (i=0; i < 10; i++) str[i] = '0';
1276  008e 4f            	clr	a
1277  008f 6b06          	ld	(OFST+0,sp),a
1279  0091               L541:
1282  0091 5f            	clrw	x
1283  0092 97            	ld	xl,a
1284  0093 72fb0d        	addw	x,(OFST+7,sp)
1285  0096 a630          	ld	a,#48
1286  0098 f7            	ld	(x),a
1289  0099 0c06          	inc	(OFST+0,sp)
1293  009b 7b06          	ld	a,(OFST+0,sp)
1294  009d a10a          	cp	a,#10
1295  009f 25f0          	jrult	L541
1296                     ; 676   str[pad] = '\0';
1298  00a1 7b10          	ld	a,(OFST+10,sp)
1299  00a3 5f            	clrw	x
1300  00a4 97            	ld	xl,a
1301  00a5 72fb0d        	addw	x,(OFST+7,sp)
1302  00a8 7f            	clr	(x)
1303                     ; 677   if (num == 0) return str;
1305  00a9 96            	ldw	x,sp
1306  00aa 1c0009        	addw	x,#OFST+3
1307  00ad cd0000        	call	c_lzmp
1311  00b0 2775          	jreq	L61
1312                     ; 680   i = 0;
1314  00b2 0f06          	clr	(OFST+0,sp)
1317  00b4 2060          	jra	L161
1318  00b6               L551:
1319                     ; 682     rem = (uint8_t)(num % base);
1321  00b6 7b0f          	ld	a,(OFST+9,sp)
1322  00b8 b703          	ld	c_lreg+3,a
1323  00ba 3f02          	clr	c_lreg+2
1324  00bc 3f01          	clr	c_lreg+1
1325  00be 3f00          	clr	c_lreg
1326  00c0 96            	ldw	x,sp
1327  00c1 5c            	incw	x
1328  00c2 cd0000        	call	c_rtol
1331  00c5 96            	ldw	x,sp
1332  00c6 1c0009        	addw	x,#OFST+3
1333  00c9 cd0000        	call	c_ltor
1335  00cc 96            	ldw	x,sp
1336  00cd 5c            	incw	x
1337  00ce cd0000        	call	c_lumd
1339  00d1 b603          	ld	a,c_lreg+3
1340  00d3 6b05          	ld	(OFST-1,sp),a
1342                     ; 683     if (rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
1344  00d5 a10a          	cp	a,#10
1345  00d7 7b06          	ld	a,(OFST+0,sp)
1346  00d9 250d          	jrult	L561
1349  00db 0c06          	inc	(OFST+0,sp)
1351  00dd 5f            	clrw	x
1352  00de 97            	ld	xl,a
1353  00df 72fb0d        	addw	x,(OFST+7,sp)
1354  00e2 7b05          	ld	a,(OFST-1,sp)
1355  00e4 ab57          	add	a,#87
1357  00e6 200b          	jra	L761
1358  00e8               L561:
1359                     ; 684     else str[i++] = (uint8_t)(rem + '0');
1361  00e8 0c06          	inc	(OFST+0,sp)
1363  00ea 5f            	clrw	x
1364  00eb 97            	ld	xl,a
1365  00ec 72fb0d        	addw	x,(OFST+7,sp)
1366  00ef 7b05          	ld	a,(OFST-1,sp)
1367  00f1 ab30          	add	a,#48
1368  00f3               L761:
1369  00f3 f7            	ld	(x),a
1370                     ; 685     num = num/base;
1372  00f4 7b0f          	ld	a,(OFST+9,sp)
1373  00f6 b703          	ld	c_lreg+3,a
1374  00f8 3f02          	clr	c_lreg+2
1375  00fa 3f01          	clr	c_lreg+1
1376  00fc 3f00          	clr	c_lreg
1377  00fe 96            	ldw	x,sp
1378  00ff 5c            	incw	x
1379  0100 cd0000        	call	c_rtol
1382  0103 96            	ldw	x,sp
1383  0104 1c0009        	addw	x,#OFST+3
1384  0107 cd0000        	call	c_ltor
1386  010a 96            	ldw	x,sp
1387  010b 5c            	incw	x
1388  010c cd0000        	call	c_ludv
1390  010f 96            	ldw	x,sp
1391  0110 1c0009        	addw	x,#OFST+3
1392  0113 cd0000        	call	c_rtol
1394  0116               L161:
1395                     ; 681   while (num != 0) {
1397  0116 96            	ldw	x,sp
1398  0117 1c0009        	addw	x,#OFST+3
1399  011a cd0000        	call	c_lzmp
1401  011d 2697          	jrne	L551
1402                     ; 689   reverse(str, pad);
1404  011f 7b10          	ld	a,(OFST+10,sp)
1405  0121 88            	push	a
1406  0122 1e0e          	ldw	x,(OFST+8,sp)
1407  0124 ad06          	call	_reverse
1409  0126 84            	pop	a
1410                     ; 691   return str;
1413  0127               L61:
1415  0127 1e0d          	ldw	x,(OFST+7,sp)
1417  0129 5b06          	addw	sp,#6
1418  012b 81            	ret	
1481                     ; 696 void reverse(char str[], uint8_t length)
1481                     ; 697 {
1482                     	switch	.text
1483  012c               _reverse:
1485  012c 89            	pushw	x
1486  012d 5203          	subw	sp,#3
1487       00000003      OFST:	set	3
1490                     ; 702   start = 0;
1492  012f 0f02          	clr	(OFST-1,sp)
1494                     ; 703   end = (uint8_t)(length - 1);
1496  0131 7b08          	ld	a,(OFST+5,sp)
1497  0133 4a            	dec	a
1498  0134 6b03          	ld	(OFST+0,sp),a
1501  0136 2029          	jra	L322
1502  0138               L712:
1503                     ; 706     temp = str[start];
1505  0138 5f            	clrw	x
1506  0139 97            	ld	xl,a
1507  013a 72fb04        	addw	x,(OFST+1,sp)
1508  013d f6            	ld	a,(x)
1509  013e 6b01          	ld	(OFST-2,sp),a
1511                     ; 707     str[start] = str[end];
1513  0140 5f            	clrw	x
1514  0141 7b02          	ld	a,(OFST-1,sp)
1515  0143 97            	ld	xl,a
1516  0144 72fb04        	addw	x,(OFST+1,sp)
1517  0147 7b03          	ld	a,(OFST+0,sp)
1518  0149 905f          	clrw	y
1519  014b 9097          	ld	yl,a
1520  014d 72f904        	addw	y,(OFST+1,sp)
1521  0150 90f6          	ld	a,(y)
1522  0152 f7            	ld	(x),a
1523                     ; 708     str[end] = temp;
1525  0153 5f            	clrw	x
1526  0154 7b03          	ld	a,(OFST+0,sp)
1527  0156 97            	ld	xl,a
1528  0157 72fb04        	addw	x,(OFST+1,sp)
1529  015a 7b01          	ld	a,(OFST-2,sp)
1530  015c f7            	ld	(x),a
1531                     ; 709     start++;
1533  015d 0c02          	inc	(OFST-1,sp)
1535                     ; 710     end--;
1537  015f 0a03          	dec	(OFST+0,sp)
1539  0161               L322:
1540                     ; 705   while (start < end) {
1540                     ; 706     temp = str[start];
1540                     ; 707     str[start] = str[end];
1540                     ; 708     str[end] = temp;
1540                     ; 709     start++;
1540                     ; 710     end--;
1542  0161 7b02          	ld	a,(OFST-1,sp)
1543  0163 1103          	cp	a,(OFST+0,sp)
1544  0165 25d1          	jrult	L712
1545                     ; 712 }
1548  0167 5b05          	addw	sp,#5
1549  0169 81            	ret	
1610                     ; 715 uint8_t three_alpha_to_uint(uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
1610                     ; 716 {
1611                     	switch	.text
1612  016a               _three_alpha_to_uint:
1614  016a 89            	pushw	x
1615  016b 89            	pushw	x
1616       00000002      OFST:	set	2
1619                     ; 724   value = (uint8_t)((alpha1 - '0') *100);
1621  016c 9e            	ld	a,xh
1622  016d 97            	ld	xl,a
1623  016e a664          	ld	a,#100
1624  0170 42            	mul	x,a
1625  0171 9f            	ld	a,xl
1626  0172 a0c0          	sub	a,#192
1627  0174 6b02          	ld	(OFST+0,sp),a
1629                     ; 725   digit = (uint8_t)((alpha2 - '0') * 10);
1631  0176 7b04          	ld	a,(OFST+2,sp)
1632  0178 97            	ld	xl,a
1633  0179 a60a          	ld	a,#10
1634  017b 42            	mul	x,a
1635  017c 9f            	ld	a,xl
1636  017d a0e0          	sub	a,#224
1638                     ; 726   value = (uint8_t)(value + digit);
1640  017f 1b02          	add	a,(OFST+0,sp)
1641  0181 6b02          	ld	(OFST+0,sp),a
1643                     ; 727   digit = (uint8_t)(alpha3 - '0');
1645  0183 7b07          	ld	a,(OFST+5,sp)
1646  0185 a030          	sub	a,#48
1647  0187 6b01          	ld	(OFST-1,sp),a
1649                     ; 728   value = (uint8_t)(value + digit);
1651  0189 1b02          	add	a,(OFST+0,sp)
1653                     ; 730   if (value >= 255) value = 0;
1655  018b a1ff          	cp	a,#255
1656  018d 2501          	jrult	L352
1659  018f 4f            	clr	a
1661  0190               L352:
1662                     ; 732   return value;
1666  0190 5b04          	addw	sp,#4
1667  0192 81            	ret	
1713                     ; 736 uint8_t two_alpha_to_uint(uint8_t alpha1, uint8_t alpha2)
1713                     ; 737 {
1714                     	switch	.text
1715  0193               _two_alpha_to_uint:
1717  0193 89            	pushw	x
1718  0194 88            	push	a
1719       00000001      OFST:	set	1
1722                     ; 744   if (alpha1 >= '0' && alpha1 <= '9') value = (uint8_t)((alpha1 - '0') << 4);
1724  0195 9e            	ld	a,xh
1725  0196 a130          	cp	a,#48
1726  0198 250f          	jrult	L572
1728  019a 9e            	ld	a,xh
1729  019b a13a          	cp	a,#58
1730  019d 240a          	jruge	L572
1733  019f 9e            	ld	a,xh
1734  01a0 97            	ld	xl,a
1735  01a1 a610          	ld	a,#16
1736  01a3 42            	mul	x,a
1737  01a4 9f            	ld	a,xl
1738  01a5 a000          	sub	a,#0
1740  01a7 2030          	jp	LC001
1741  01a9               L572:
1742                     ; 745   else if (alpha1 == 'a') value = 0xa0;
1744  01a9 7b02          	ld	a,(OFST+1,sp)
1745  01ab a161          	cp	a,#97
1746  01ad 2604          	jrne	L103
1749  01af a6a0          	ld	a,#160
1751  01b1 2026          	jp	LC001
1752  01b3               L103:
1753                     ; 746   else if (alpha1 == 'b') value = 0xb0;
1755  01b3 a162          	cp	a,#98
1756  01b5 2604          	jrne	L503
1759  01b7 a6b0          	ld	a,#176
1761  01b9 201e          	jp	LC001
1762  01bb               L503:
1763                     ; 747   else if (alpha1 == 'c') value = 0xc0;
1765  01bb a163          	cp	a,#99
1766  01bd 2604          	jrne	L113
1769  01bf a6c0          	ld	a,#192
1771  01c1 2016          	jp	LC001
1772  01c3               L113:
1773                     ; 748   else if (alpha1 == 'd') value = 0xd0;
1775  01c3 a164          	cp	a,#100
1776  01c5 2604          	jrne	L513
1779  01c7 a6d0          	ld	a,#208
1781  01c9 200e          	jp	LC001
1782  01cb               L513:
1783                     ; 749   else if (alpha1 == 'e') value = 0xe0;
1785  01cb a165          	cp	a,#101
1786  01cd 2604          	jrne	L123
1789  01cf a6e0          	ld	a,#224
1791  01d1 2006          	jp	LC001
1792  01d3               L123:
1793                     ; 750   else if (alpha1 == 'f') value = 0xf0;
1795  01d3 a166          	cp	a,#102
1796  01d5 2606          	jrne	L523
1799  01d7 a6f0          	ld	a,#240
1800  01d9               LC001:
1801  01d9 6b01          	ld	(OFST+0,sp),a
1804  01db 2002          	jra	L772
1805  01dd               L523:
1806                     ; 751   else value = 0; // If an invalid entry is made convert it to 0
1808  01dd 0f01          	clr	(OFST+0,sp)
1810  01df               L772:
1811                     ; 753   if (alpha2 >= '0' && alpha2 <= '9') value = (uint8_t)(value + alpha2 - '0');
1813  01df 7b03          	ld	a,(OFST+2,sp)
1814  01e1 a130          	cp	a,#48
1815  01e3 250c          	jrult	L133
1817  01e5 a13a          	cp	a,#58
1818  01e7 2408          	jruge	L133
1821  01e9 7b01          	ld	a,(OFST+0,sp)
1822  01eb 1b03          	add	a,(OFST+2,sp)
1823  01ed a030          	sub	a,#48
1825  01ef 203d          	jp	L333
1826  01f1               L133:
1827                     ; 754   else if (alpha2 == 'a') value = (uint8_t)(value + 0x0a);
1829  01f1 a161          	cp	a,#97
1830  01f3 2606          	jrne	L533
1833  01f5 7b01          	ld	a,(OFST+0,sp)
1834  01f7 ab0a          	add	a,#10
1836  01f9 2033          	jp	L333
1837  01fb               L533:
1838                     ; 755   else if (alpha2 == 'b') value = (uint8_t)(value + 0x0b);
1840  01fb a162          	cp	a,#98
1841  01fd 2606          	jrne	L143
1844  01ff 7b01          	ld	a,(OFST+0,sp)
1845  0201 ab0b          	add	a,#11
1847  0203 2029          	jp	L333
1848  0205               L143:
1849                     ; 756   else if (alpha2 == 'c') value = (uint8_t)(value + 0x0c);
1851  0205 a163          	cp	a,#99
1852  0207 2606          	jrne	L543
1855  0209 7b01          	ld	a,(OFST+0,sp)
1856  020b ab0c          	add	a,#12
1858  020d 201f          	jp	L333
1859  020f               L543:
1860                     ; 757   else if (alpha2 == 'd') value = (uint8_t)(value + 0x0d);
1862  020f a164          	cp	a,#100
1863  0211 2606          	jrne	L153
1866  0213 7b01          	ld	a,(OFST+0,sp)
1867  0215 ab0d          	add	a,#13
1869  0217 2015          	jp	L333
1870  0219               L153:
1871                     ; 758   else if (alpha2 == 'e') value = (uint8_t)(value + 0x0e);
1873  0219 a165          	cp	a,#101
1874  021b 2606          	jrne	L553
1877  021d 7b01          	ld	a,(OFST+0,sp)
1878  021f ab0e          	add	a,#14
1880  0221 200b          	jp	L333
1881  0223               L553:
1882                     ; 759   else if (alpha2 == 'f') value = (uint8_t)(value + 0x0f);
1884  0223 a166          	cp	a,#102
1885  0225 2606          	jrne	L163
1888  0227 7b01          	ld	a,(OFST+0,sp)
1889  0229 ab0f          	add	a,#15
1892  022b 2001          	jra	L333
1893  022d               L163:
1894                     ; 760   else value = 0; // If an invalid entry is made convert it to 0
1896  022d 4f            	clr	a
1898  022e               L333:
1899                     ; 762   return value;
1903  022e 5b03          	addw	sp,#3
1904  0230 81            	ret	
1955                     ; 766 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint32_t nDataLen)
1955                     ; 767 {
1956                     	switch	.text
1957  0231               L7_CopyHttpHeader:
1959  0231 89            	pushw	x
1960  0232 89            	pushw	x
1961       00000002      OFST:	set	2
1964                     ; 770   nBytes = 0;
1966  0233 5f            	clrw	x
1967  0234 1f01          	ldw	(OFST-1,sp),x
1969                     ; 772   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
1971  0236 ae3dd9        	ldw	x,#L704
1972  0239 89            	pushw	x
1973  023a 96            	ldw	x,sp
1974  023b 1c0005        	addw	x,#OFST+3
1975  023e cd0000        	call	L3_CopyStringP
1977  0241 5b02          	addw	sp,#2
1978  0243 72fb01        	addw	x,(OFST-1,sp)
1979  0246 1f01          	ldw	(OFST-1,sp),x
1981                     ; 773   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1983  0248 ae3dd6        	ldw	x,#L114
1984  024b 89            	pushw	x
1985  024c 96            	ldw	x,sp
1986  024d 1c0005        	addw	x,#OFST+3
1987  0250 cd0000        	call	L3_CopyStringP
1989  0253 5b02          	addw	sp,#2
1990  0255 72fb01        	addw	x,(OFST-1,sp)
1991  0258 1f01          	ldw	(OFST-1,sp),x
1993                     ; 775   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
1995  025a ae3dc6        	ldw	x,#L314
1996  025d 89            	pushw	x
1997  025e 96            	ldw	x,sp
1998  025f 1c0005        	addw	x,#OFST+3
1999  0262 cd0000        	call	L3_CopyStringP
2001  0265 5b02          	addw	sp,#2
2002  0267 72fb01        	addw	x,(OFST-1,sp)
2003  026a 1f01          	ldw	(OFST-1,sp),x
2005                     ; 776   nBytes += CopyValue(&pBuffer, nDataLen);
2007  026c 1e09          	ldw	x,(OFST+7,sp)
2008  026e 89            	pushw	x
2009  026f 1e09          	ldw	x,(OFST+7,sp)
2010  0271 89            	pushw	x
2011  0272 96            	ldw	x,sp
2012  0273 1c0007        	addw	x,#OFST+5
2013  0276 cd0028        	call	L5_CopyValue
2015  0279 5b04          	addw	sp,#4
2016  027b 72fb01        	addw	x,(OFST-1,sp)
2017  027e 1f01          	ldw	(OFST-1,sp),x
2019                     ; 777   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2021  0280 ae3dd6        	ldw	x,#L114
2022  0283 89            	pushw	x
2023  0284 96            	ldw	x,sp
2024  0285 1c0005        	addw	x,#OFST+3
2025  0288 cd0000        	call	L3_CopyStringP
2027  028b 5b02          	addw	sp,#2
2028  028d 72fb01        	addw	x,(OFST-1,sp)
2029  0290 1f01          	ldw	(OFST-1,sp),x
2031                     ; 779   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type:text/html\r\n"));
2033  0292 ae3dad        	ldw	x,#L514
2034  0295 89            	pushw	x
2035  0296 96            	ldw	x,sp
2036  0297 1c0005        	addw	x,#OFST+3
2037  029a cd0000        	call	L3_CopyStringP
2039  029d 5b02          	addw	sp,#2
2040  029f 72fb01        	addw	x,(OFST-1,sp)
2041  02a2 1f01          	ldw	(OFST-1,sp),x
2043                     ; 780   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
2045  02a4 ae3d9a        	ldw	x,#L714
2046  02a7 89            	pushw	x
2047  02a8 96            	ldw	x,sp
2048  02a9 1c0005        	addw	x,#OFST+3
2049  02ac cd0000        	call	L3_CopyStringP
2051  02af 5b02          	addw	sp,#2
2052  02b1 72fb01        	addw	x,(OFST-1,sp)
2053  02b4 1f01          	ldw	(OFST-1,sp),x
2055                     ; 781   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2057  02b6 ae3dd6        	ldw	x,#L114
2058  02b9 89            	pushw	x
2059  02ba 96            	ldw	x,sp
2060  02bb 1c0005        	addw	x,#OFST+3
2061  02be cd0000        	call	L3_CopyStringP
2063  02c1 5b02          	addw	sp,#2
2064  02c3 72fb01        	addw	x,(OFST-1,sp)
2066                     ; 783   return nBytes;
2070  02c6 5b04          	addw	sp,#4
2071  02c8 81            	ret	
2210                     	switch	.const
2211  3c96               L421:
2212  3c96 046d          	dc.w	L124
2213  3c98 047b          	dc.w	L324
2214  3c9a 0489          	dc.w	L524
2215  3c9c 0496          	dc.w	L724
2216  3c9e 04a3          	dc.w	L134
2217  3ca0 04b0          	dc.w	L334
2218  3ca2 04bd          	dc.w	L534
2219  3ca4 04ca          	dc.w	L734
2220  3ca6 04d7          	dc.w	L144
2221  3ca8 04e4          	dc.w	L344
2222  3caa 04f1          	dc.w	L544
2223  3cac 04fe          	dc.w	L744
2224  3cae               L422:
2225  3cae 063d          	dc.w	L354
2226  3cb0 064f          	dc.w	L554
2227  3cb2 0661          	dc.w	L754
2228  3cb4 0673          	dc.w	L164
2229  3cb6 0685          	dc.w	L364
2230  3cb8 0697          	dc.w	L564
2231  3cba 06a9          	dc.w	L764
2232  3cbc 06bb          	dc.w	L174
2233  3cbe 06cd          	dc.w	L374
2234  3cc0 06df          	dc.w	L574
2235  3cc2 06f1          	dc.w	L774
2236  3cc4 0703          	dc.w	L105
2237  3cc6 0715          	dc.w	L305
2238  3cc8 0727          	dc.w	L505
2239  3cca 0739          	dc.w	L705
2240  3ccc 074b          	dc.w	L115
2241  3cce 075c          	dc.w	L315
2242  3cd0 076d          	dc.w	L515
2243  3cd2 077e          	dc.w	L715
2244  3cd4 078f          	dc.w	L125
2245  3cd6 07a0          	dc.w	L325
2246  3cd8 07b1          	dc.w	L525
2247                     ; 787 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
2247                     ; 788 {
2248                     	switch	.text
2249  02c9               L11_CopyHttpData:
2251  02c9 89            	pushw	x
2252  02ca 5207          	subw	sp,#7
2253       00000007      OFST:	set	7
2256                     ; 804   nBytes = 0;
2258  02cc 5f            	clrw	x
2259  02cd 1f05          	ldw	(OFST-2,sp),x
2261                     ; 840   if (nMaxBytes > 400) nMaxBytes = 400; // limit just in case
2263  02cf 1e10          	ldw	x,(OFST+9,sp)
2264  02d1 a30191        	cpw	x,#401
2265  02d4 2403cc0af8    	jrult	L306
2268  02d9 ae0190        	ldw	x,#400
2269  02dc 1f10          	ldw	(OFST+9,sp),x
2270  02de cc0af8        	jra	L306
2271  02e1               L106:
2272                     ; 863     if (*pDataLeft > 0) {
2274  02e1 1e0e          	ldw	x,(OFST+7,sp)
2275  02e3 e601          	ld	a,(1,x)
2276  02e5 fa            	or	a,(x)
2277  02e6 2603cc0b01    	jreq	L506
2278                     ; 867       memcpy(&nByte, *ppData, 1);
2280  02eb 96            	ldw	x,sp
2281  02ec 5c            	incw	x
2282  02ed bf00          	ldw	c_x,x
2283  02ef 160c          	ldw	y,(OFST+5,sp)
2284  02f1 90fe          	ldw	y,(y)
2285  02f3 90bf00        	ldw	c_y,y
2286  02f6 ae0001        	ldw	x,#1
2287  02f9               L25:
2288  02f9 5a            	decw	x
2289  02fa 92d600        	ld	a,([c_y.w],x)
2290  02fd 92d700        	ld	([c_x.w],x),a
2291  0300 5d            	tnzw	x
2292  0301 26f6          	jrne	L25
2293                     ; 893       if (nByte == '%') {
2295  0303 7b01          	ld	a,(OFST-6,sp)
2296  0305 a125          	cp	a,#37
2297  0307 2703cc0adb    	jrne	L116
2298                     ; 894         *ppData = *ppData + 1;
2300  030c 1e0c          	ldw	x,(OFST+5,sp)
2301  030e 9093          	ldw	y,x
2302  0310 fe            	ldw	x,(x)
2303  0311 5c            	incw	x
2304  0312 90ff          	ldw	(y),x
2305                     ; 895         *pDataLeft = *pDataLeft - 1;
2307  0314 1e0e          	ldw	x,(OFST+7,sp)
2308  0316 9093          	ldw	y,x
2309  0318 fe            	ldw	x,(x)
2310  0319 5a            	decw	x
2311  031a 90ff          	ldw	(y),x
2312                     ; 900         memcpy(&nParsedMode, *ppData, 1);
2314  031c 96            	ldw	x,sp
2315  031d 1c0003        	addw	x,#OFST-4
2316  0320 bf00          	ldw	c_x,x
2317  0322 160c          	ldw	y,(OFST+5,sp)
2318  0324 90fe          	ldw	y,(y)
2319  0326 90bf00        	ldw	c_y,y
2320  0329 ae0001        	ldw	x,#1
2321  032c               L45:
2322  032c 5a            	decw	x
2323  032d 92d600        	ld	a,([c_y.w],x)
2324  0330 92d700        	ld	([c_x.w],x),a
2325  0333 5d            	tnzw	x
2326  0334 26f6          	jrne	L45
2327                     ; 901         *ppData = *ppData + 1;
2329  0336 1e0c          	ldw	x,(OFST+5,sp)
2330  0338 9093          	ldw	y,x
2331  033a fe            	ldw	x,(x)
2332  033b 5c            	incw	x
2333  033c 90ff          	ldw	(y),x
2334                     ; 902         *pDataLeft = *pDataLeft - 1;
2336  033e 1e0e          	ldw	x,(OFST+7,sp)
2337  0340 9093          	ldw	y,x
2338  0342 fe            	ldw	x,(x)
2339  0343 5a            	decw	x
2340  0344 90ff          	ldw	(y),x
2341                     ; 906         memcpy(&temp, *ppData, 1);
2343  0346 96            	ldw	x,sp
2344  0347 1c0002        	addw	x,#OFST-5
2345  034a bf00          	ldw	c_x,x
2346  034c 160c          	ldw	y,(OFST+5,sp)
2347  034e 90fe          	ldw	y,(y)
2348  0350 90bf00        	ldw	c_y,y
2349  0353 ae0001        	ldw	x,#1
2350  0356               L65:
2351  0356 5a            	decw	x
2352  0357 92d600        	ld	a,([c_y.w],x)
2353  035a 92d700        	ld	([c_x.w],x),a
2354  035d 5d            	tnzw	x
2355  035e 26f6          	jrne	L65
2356                     ; 907 	nParsedNum = (uint8_t)((temp - '0') * 10);
2358  0360 7b02          	ld	a,(OFST-5,sp)
2359  0362 97            	ld	xl,a
2360  0363 a60a          	ld	a,#10
2361  0365 42            	mul	x,a
2362  0366 9f            	ld	a,xl
2363  0367 a0e0          	sub	a,#224
2364  0369 6b04          	ld	(OFST-3,sp),a
2366                     ; 908         *ppData = *ppData + 1;
2368  036b 1e0c          	ldw	x,(OFST+5,sp)
2369  036d 9093          	ldw	y,x
2370  036f fe            	ldw	x,(x)
2371  0370 5c            	incw	x
2372  0371 90ff          	ldw	(y),x
2373                     ; 909         *pDataLeft = *pDataLeft - 1;
2375  0373 1e0e          	ldw	x,(OFST+7,sp)
2376  0375 9093          	ldw	y,x
2377  0377 fe            	ldw	x,(x)
2378  0378 5a            	decw	x
2379  0379 90ff          	ldw	(y),x
2380                     ; 913         memcpy(&temp, *ppData, 1);
2382  037b 96            	ldw	x,sp
2383  037c 1c0002        	addw	x,#OFST-5
2384  037f bf00          	ldw	c_x,x
2385  0381 160c          	ldw	y,(OFST+5,sp)
2386  0383 90fe          	ldw	y,(y)
2387  0385 90bf00        	ldw	c_y,y
2388  0388 ae0001        	ldw	x,#1
2389  038b               L06:
2390  038b 5a            	decw	x
2391  038c 92d600        	ld	a,([c_y.w],x)
2392  038f 92d700        	ld	([c_x.w],x),a
2393  0392 5d            	tnzw	x
2394  0393 26f6          	jrne	L06
2395                     ; 914 	nParsedNum = (uint8_t)(nParsedNum + temp - '0');
2397  0395 7b04          	ld	a,(OFST-3,sp)
2398  0397 1b02          	add	a,(OFST-5,sp)
2399  0399 a030          	sub	a,#48
2400  039b 6b04          	ld	(OFST-3,sp),a
2402                     ; 915         *ppData = *ppData + 1;
2404  039d 1e0c          	ldw	x,(OFST+5,sp)
2405  039f 9093          	ldw	y,x
2406  03a1 fe            	ldw	x,(x)
2407  03a2 5c            	incw	x
2408  03a3 90ff          	ldw	(y),x
2409                     ; 916         *pDataLeft = *pDataLeft - 1;
2411  03a5 1e0e          	ldw	x,(OFST+7,sp)
2412  03a7 9093          	ldw	y,x
2413  03a9 fe            	ldw	x,(x)
2414  03aa 5a            	decw	x
2415  03ab 90ff          	ldw	(y),x
2416                     ; 926         if (nParsedMode == 'i') {
2418  03ad 7b03          	ld	a,(OFST-4,sp)
2419  03af a169          	cp	a,#105
2420  03b1 2614          	jrne	L316
2421                     ; 930 	  *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
2423  03b3 7b04          	ld	a,(OFST-3,sp)
2424  03b5 cd1335        	call	_GpioGetPin
2426  03b8 1e08          	ldw	x,(OFST+1,sp)
2427  03ba ab30          	add	a,#48
2428  03bc f7            	ld	(x),a
2429                     ; 931           pBuffer++;
2431  03bd 5c            	incw	x
2432  03be 1f08          	ldw	(OFST+1,sp),x
2433                     ; 932           nBytes++;
2435  03c0 1e05          	ldw	x,(OFST-2,sp)
2436  03c2 5c            	incw	x
2437  03c3 1f05          	ldw	(OFST-2,sp),x
2440  03c5 204e          	jra	L516
2441  03c7               L316:
2442                     ; 956         else if (nParsedMode == 'o') {
2444  03c7 a16f          	cp	a,#111
2445  03c9 2624          	jrne	L716
2446                     ; 959           if ((uint8_t)(GpioGetPin(nParsedNum) == 1)) { // Insert 'checked'
2448  03cb 7b04          	ld	a,(OFST-3,sp)
2449  03cd cd1335        	call	_GpioGetPin
2451  03d0 4a            	dec	a
2452  03d1 2642          	jrne	L516
2453                     ; 960             for(i=0; i<7; i++) {
2455  03d3 6b07          	ld	(OFST+0,sp),a
2457  03d5               L326:
2458                     ; 961               *pBuffer = checked[i];
2460  03d5 5f            	clrw	x
2461  03d6 97            	ld	xl,a
2462  03d7 d60000        	ld	a,(L31_checked,x)
2463  03da 1e08          	ldw	x,(OFST+1,sp)
2464  03dc f7            	ld	(x),a
2465                     ; 962               pBuffer++;
2467  03dd 5c            	incw	x
2468  03de 1f08          	ldw	(OFST+1,sp),x
2469                     ; 963               nBytes++;
2471  03e0 1e05          	ldw	x,(OFST-2,sp)
2472  03e2 5c            	incw	x
2473  03e3 1f05          	ldw	(OFST-2,sp),x
2475                     ; 960             for(i=0; i<7; i++) {
2477  03e5 0c07          	inc	(OFST+0,sp)
2481  03e7 7b07          	ld	a,(OFST+0,sp)
2482  03e9 a107          	cp	a,#7
2483  03eb 25e8          	jrult	L326
2485  03ed 2026          	jra	L516
2486  03ef               L716:
2487                     ; 970         else if (nParsedMode == 'p') {
2489  03ef a170          	cp	a,#112
2490  03f1 2622          	jrne	L516
2491                     ; 973           if ((uint8_t)(GpioGetPin(nParsedNum) == 0)) { // Insert 'checked'
2493  03f3 7b04          	ld	a,(OFST-3,sp)
2494  03f5 cd1335        	call	_GpioGetPin
2496  03f8 4d            	tnz	a
2497  03f9 261a          	jrne	L516
2498                     ; 974             for(i=0; i<7; i++) {
2500  03fb 6b07          	ld	(OFST+0,sp),a
2502  03fd               L146:
2503                     ; 975               *pBuffer = checked[i];
2505  03fd 5f            	clrw	x
2506  03fe 97            	ld	xl,a
2507  03ff d60000        	ld	a,(L31_checked,x)
2508  0402 1e08          	ldw	x,(OFST+1,sp)
2509  0404 f7            	ld	(x),a
2510                     ; 976               pBuffer++;
2512  0405 5c            	incw	x
2513  0406 1f08          	ldw	(OFST+1,sp),x
2514                     ; 977               nBytes++;
2516  0408 1e05          	ldw	x,(OFST-2,sp)
2517  040a 5c            	incw	x
2518  040b 1f05          	ldw	(OFST-2,sp),x
2520                     ; 974             for(i=0; i<7; i++) {
2522  040d 0c07          	inc	(OFST+0,sp)
2526  040f 7b07          	ld	a,(OFST+0,sp)
2527  0411 a107          	cp	a,#7
2528  0413 25e8          	jrult	L146
2530  0415               L516:
2531                     ; 984         if (nParsedMode == 'a') {
2533  0415 7b03          	ld	a,(OFST-4,sp)
2534  0417 a161          	cp	a,#97
2535  0419 263b          	jrne	L156
2536                     ; 986 	  for(i=0; i<20; i++) {
2538  041b 4f            	clr	a
2539  041c 6b07          	ld	(OFST+0,sp),a
2541  041e               L356:
2542                     ; 987 	    if (ex_stored_devicename[i] != ' ') { // Don't write spaces out - confuses the
2544  041e 5f            	clrw	x
2545  041f 97            	ld	xl,a
2546  0420 d60000        	ld	a,(_ex_stored_devicename,x)
2547  0423 a120          	cp	a,#32
2548  0425 2712          	jreq	L166
2549                     ; 989               *pBuffer = (uint8_t)(ex_stored_devicename[i]);
2551  0427 7b07          	ld	a,(OFST+0,sp)
2552  0429 5f            	clrw	x
2553  042a 97            	ld	xl,a
2554  042b d60000        	ld	a,(_ex_stored_devicename,x)
2555  042e 1e08          	ldw	x,(OFST+1,sp)
2556  0430 f7            	ld	(x),a
2557                     ; 990               pBuffer++;
2559  0431 5c            	incw	x
2560  0432 1f08          	ldw	(OFST+1,sp),x
2561                     ; 991               nBytes++;
2563  0434 1e05          	ldw	x,(OFST-2,sp)
2564  0436 5c            	incw	x
2565  0437 1f05          	ldw	(OFST-2,sp),x
2567  0439               L166:
2568                     ; 986 	  for(i=0; i<20; i++) {
2570  0439 0c07          	inc	(OFST+0,sp)
2574  043b 7b07          	ld	a,(OFST+0,sp)
2575  043d a114          	cp	a,#20
2576  043f 25dd          	jrult	L356
2577                     ; 1006           *ppData = *ppData + 20;
2579  0441 1e0c          	ldw	x,(OFST+5,sp)
2580  0443 9093          	ldw	y,x
2581  0445 fe            	ldw	x,(x)
2582  0446 1c0014        	addw	x,#20
2583  0449 90ff          	ldw	(y),x
2584                     ; 1007           *pDataLeft = *pDataLeft - 20;
2586  044b 1e0e          	ldw	x,(OFST+7,sp)
2587  044d 9093          	ldw	y,x
2588  044f fe            	ldw	x,(x)
2589  0450 1d0014        	subw	x,#20
2591  0453 cc0832        	jp	LC011
2592  0456               L156:
2593                     ; 1010         else if (nParsedMode == 'b') {
2595  0456 a162          	cp	a,#98
2596  0458 2703cc0556    	jrne	L566
2597                     ; 1015 	  advanceptrs = 0;
2599                     ; 1017           switch (nParsedNum)
2601  045d 7b04          	ld	a,(OFST-3,sp)
2603                     ; 1032 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2604  045f a10c          	cp	a,#12
2605  0461 2503cc0518    	jruge	L154
2606  0466 5f            	clrw	x
2607  0467 97            	ld	xl,a
2608  0468 58            	sllw	x
2609  0469 de3c96        	ldw	x,(L421,x)
2610  046c fc            	jp	(x)
2611  046d               L124:
2612                     ; 1020 	    case 0:  emb_itoa(ex_stored_hostaddr4, OctetArray, 10, 3); advanceptrs = 1; break;
2614  046d 4b03          	push	#3
2615  046f 4b0a          	push	#10
2616  0471 ae0000        	ldw	x,#_OctetArray
2617  0474 89            	pushw	x
2618  0475 c60000        	ld	a,_ex_stored_hostaddr4
2623  0478 cc0509        	jp	LC003
2624  047b               L324:
2625                     ; 1021 	    case 1:  emb_itoa(ex_stored_hostaddr3, OctetArray, 10, 3); advanceptrs = 1; break;
2627  047b 4b03          	push	#3
2628  047d 4b0a          	push	#10
2629  047f ae0000        	ldw	x,#_OctetArray
2630  0482 89            	pushw	x
2631  0483 c60000        	ld	a,_ex_stored_hostaddr3
2636  0486 cc0509        	jp	LC003
2637  0489               L524:
2638                     ; 1022 	    case 2:  emb_itoa(ex_stored_hostaddr2, OctetArray, 10, 3); advanceptrs = 1; break;
2640  0489 4b03          	push	#3
2641  048b 4b0a          	push	#10
2642  048d ae0000        	ldw	x,#_OctetArray
2643  0490 89            	pushw	x
2644  0491 c60000        	ld	a,_ex_stored_hostaddr2
2649  0494 2073          	jp	LC003
2650  0496               L724:
2651                     ; 1023 	    case 3:  emb_itoa(ex_stored_hostaddr1, OctetArray, 10, 3); advanceptrs = 1; break;
2653  0496 4b03          	push	#3
2654  0498 4b0a          	push	#10
2655  049a ae0000        	ldw	x,#_OctetArray
2656  049d 89            	pushw	x
2657  049e c60000        	ld	a,_ex_stored_hostaddr1
2662  04a1 2066          	jp	LC003
2663  04a3               L134:
2664                     ; 1024 	    case 4:  emb_itoa(ex_stored_draddr4,   OctetArray, 10, 3); advanceptrs = 1; break;
2666  04a3 4b03          	push	#3
2667  04a5 4b0a          	push	#10
2668  04a7 ae0000        	ldw	x,#_OctetArray
2669  04aa 89            	pushw	x
2670  04ab c60000        	ld	a,_ex_stored_draddr4
2675  04ae 2059          	jp	LC003
2676  04b0               L334:
2677                     ; 1025 	    case 5:  emb_itoa(ex_stored_draddr3,   OctetArray, 10, 3); advanceptrs = 1; break;
2679  04b0 4b03          	push	#3
2680  04b2 4b0a          	push	#10
2681  04b4 ae0000        	ldw	x,#_OctetArray
2682  04b7 89            	pushw	x
2683  04b8 c60000        	ld	a,_ex_stored_draddr3
2688  04bb 204c          	jp	LC003
2689  04bd               L534:
2690                     ; 1026 	    case 6:  emb_itoa(ex_stored_draddr2,   OctetArray, 10, 3); advanceptrs = 1; break;
2692  04bd 4b03          	push	#3
2693  04bf 4b0a          	push	#10
2694  04c1 ae0000        	ldw	x,#_OctetArray
2695  04c4 89            	pushw	x
2696  04c5 c60000        	ld	a,_ex_stored_draddr2
2701  04c8 203f          	jp	LC003
2702  04ca               L734:
2703                     ; 1027 	    case 7:  emb_itoa(ex_stored_draddr1,   OctetArray, 10, 3); advanceptrs = 1; break;
2705  04ca 4b03          	push	#3
2706  04cc 4b0a          	push	#10
2707  04ce ae0000        	ldw	x,#_OctetArray
2708  04d1 89            	pushw	x
2709  04d2 c60000        	ld	a,_ex_stored_draddr1
2714  04d5 2032          	jp	LC003
2715  04d7               L144:
2716                     ; 1028 	    case 8:  emb_itoa(ex_stored_netmask4,  OctetArray, 10, 3); advanceptrs = 1; break;
2718  04d7 4b03          	push	#3
2719  04d9 4b0a          	push	#10
2720  04db ae0000        	ldw	x,#_OctetArray
2721  04de 89            	pushw	x
2722  04df c60000        	ld	a,_ex_stored_netmask4
2727  04e2 2025          	jp	LC003
2728  04e4               L344:
2729                     ; 1029 	    case 9:  emb_itoa(ex_stored_netmask3,  OctetArray, 10, 3); advanceptrs = 1; break;
2731  04e4 4b03          	push	#3
2732  04e6 4b0a          	push	#10
2733  04e8 ae0000        	ldw	x,#_OctetArray
2734  04eb 89            	pushw	x
2735  04ec c60000        	ld	a,_ex_stored_netmask3
2740  04ef 2018          	jp	LC003
2741  04f1               L544:
2742                     ; 1030 	    case 10: emb_itoa(ex_stored_netmask2,  OctetArray, 10, 3); advanceptrs = 1; break;
2744  04f1 4b03          	push	#3
2745  04f3 4b0a          	push	#10
2746  04f5 ae0000        	ldw	x,#_OctetArray
2747  04f8 89            	pushw	x
2748  04f9 c60000        	ld	a,_ex_stored_netmask2
2753  04fc 200b          	jp	LC003
2754  04fe               L744:
2755                     ; 1031 	    case 11: emb_itoa(ex_stored_netmask1,  OctetArray, 10, 3); advanceptrs = 1; break;
2757  04fe 4b03          	push	#3
2758  0500 4b0a          	push	#10
2759  0502 ae0000        	ldw	x,#_OctetArray
2760  0505 89            	pushw	x
2761  0506 c60000        	ld	a,_ex_stored_netmask1
2762  0509               LC003:
2763  0509 b703          	ld	c_lreg+3,a
2764  050b 3f02          	clr	c_lreg+2
2765  050d 3f01          	clr	c_lreg+1
2766  050f 3f00          	clr	c_lreg
2767  0511 be02          	ldw	x,c_lreg+2
2768  0513 89            	pushw	x
2769  0514 be00          	ldw	x,c_lreg
2774  0516 200a          	jra	L176
2775  0518               L154:
2776                     ; 1032 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2778  0518 4b03          	push	#3
2779  051a 4b0a          	push	#10
2780  051c ae0000        	ldw	x,#_OctetArray
2781  051f 89            	pushw	x
2782  0520 5f            	clrw	x
2783  0521 89            	pushw	x
2789  0522               L176:
2790  0522 89            	pushw	x
2791  0523 cd008c        	call	_emb_itoa
2792  0526 5b08          	addw	sp,#8
2805  0528 a601          	ld	a,#1
2806  052a 6b07          	ld	(OFST+0,sp),a
2808                     ; 1035 	  if (advanceptrs == 1) { // Copy OctetArray and advance pointers if one of the above
2810  052c 4a            	dec	a
2811  052d 2703cc0af8    	jrne	L306
2812                     ; 1037             *pBuffer = (uint8_t)OctetArray[0];
2814  0532 1e08          	ldw	x,(OFST+1,sp)
2815  0534 c60000        	ld	a,_OctetArray
2816  0537 f7            	ld	(x),a
2817                     ; 1038             pBuffer++;
2819  0538 5c            	incw	x
2820  0539 1f08          	ldw	(OFST+1,sp),x
2821                     ; 1039             nBytes++;
2823  053b 1e05          	ldw	x,(OFST-2,sp)
2824  053d 5c            	incw	x
2825  053e 1f05          	ldw	(OFST-2,sp),x
2827                     ; 1041             *pBuffer = (uint8_t)OctetArray[1];
2829  0540 1e08          	ldw	x,(OFST+1,sp)
2830  0542 c60001        	ld	a,_OctetArray+1
2831  0545 f7            	ld	(x),a
2832                     ; 1042             pBuffer++;
2834  0546 5c            	incw	x
2835  0547 1f08          	ldw	(OFST+1,sp),x
2836                     ; 1043             nBytes++;
2838  0549 1e05          	ldw	x,(OFST-2,sp)
2839  054b 5c            	incw	x
2840  054c 1f05          	ldw	(OFST-2,sp),x
2842                     ; 1045             *pBuffer = (uint8_t)OctetArray[2];
2844  054e c60002        	ld	a,_OctetArray+2
2845  0551 1e08          	ldw	x,(OFST+1,sp)
2846                     ; 1046             pBuffer++;
2847                     ; 1047             nBytes++;
2848  0553 cc0622        	jp	LC010
2849  0556               L566:
2850                     ; 1051         else if (nParsedMode == 'c') {
2852  0556 a163          	cp	a,#99
2853  0558 2637          	jrne	L776
2854                     ; 1057           emb_itoa(ex_stored_port, OctetArray, 10, 5);
2856  055a 4b05          	push	#5
2857  055c 4b0a          	push	#10
2858  055e ae0000        	ldw	x,#_OctetArray
2859  0561 89            	pushw	x
2860  0562 ce0000        	ldw	x,_ex_stored_port
2861  0565 cd0000        	call	c_uitolx
2863  0568 be02          	ldw	x,c_lreg+2
2864  056a 89            	pushw	x
2865  056b be00          	ldw	x,c_lreg
2866  056d 89            	pushw	x
2867  056e cd008c        	call	_emb_itoa
2869  0571 5b08          	addw	sp,#8
2870                     ; 1059 	  for(i=0; i<5; i++) {
2872  0573 4f            	clr	a
2873  0574 6b07          	ld	(OFST+0,sp),a
2875  0576               L107:
2876                     ; 1060             *pBuffer = (uint8_t)OctetArray[i];
2878  0576 5f            	clrw	x
2879  0577 97            	ld	xl,a
2880  0578 d60000        	ld	a,(_OctetArray,x)
2881  057b 1e08          	ldw	x,(OFST+1,sp)
2882  057d f7            	ld	(x),a
2883                     ; 1061             pBuffer++;
2885  057e 5c            	incw	x
2886  057f 1f08          	ldw	(OFST+1,sp),x
2887                     ; 1062             nBytes++;
2889  0581 1e05          	ldw	x,(OFST-2,sp)
2890  0583 5c            	incw	x
2891  0584 1f05          	ldw	(OFST-2,sp),x
2893                     ; 1059 	  for(i=0; i<5; i++) {
2895  0586 0c07          	inc	(OFST+0,sp)
2899  0588 7b07          	ld	a,(OFST+0,sp)
2900  058a a105          	cp	a,#5
2901  058c 25e8          	jrult	L107
2903  058e cc0af8        	jra	L306
2904  0591               L776:
2905                     ; 1066         else if (nParsedMode == 'd') {
2907  0591 a164          	cp	a,#100
2908  0593 2703cc0626    	jrne	L117
2909                     ; 1071 	  if (nParsedNum == 0)      emb_itoa(uip_ethaddr1, OctetArray, 16, 2);
2911  0598 7b04          	ld	a,(OFST-3,sp)
2912  059a 260d          	jrne	L317
2915  059c 4b02          	push	#2
2916  059e 4b10          	push	#16
2917  05a0 ae0000        	ldw	x,#_OctetArray
2918  05a3 89            	pushw	x
2919  05a4 c60000        	ld	a,_uip_ethaddr1
2922  05a7 2053          	jp	LC004
2923  05a9               L317:
2924                     ; 1072 	  else if (nParsedNum == 1) emb_itoa(uip_ethaddr2, OctetArray, 16, 2);
2926  05a9 a101          	cp	a,#1
2927  05ab 260d          	jrne	L717
2930  05ad 4b02          	push	#2
2931  05af 4b10          	push	#16
2932  05b1 ae0000        	ldw	x,#_OctetArray
2933  05b4 89            	pushw	x
2934  05b5 c60000        	ld	a,_uip_ethaddr2
2937  05b8 2042          	jp	LC004
2938  05ba               L717:
2939                     ; 1073 	  else if (nParsedNum == 2) emb_itoa(uip_ethaddr3, OctetArray, 16, 2);
2941  05ba a102          	cp	a,#2
2942  05bc 260d          	jrne	L327
2945  05be 4b02          	push	#2
2946  05c0 4b10          	push	#16
2947  05c2 ae0000        	ldw	x,#_OctetArray
2948  05c5 89            	pushw	x
2949  05c6 c60000        	ld	a,_uip_ethaddr3
2952  05c9 2031          	jp	LC004
2953  05cb               L327:
2954                     ; 1074 	  else if (nParsedNum == 3) emb_itoa(uip_ethaddr4, OctetArray, 16, 2);
2956  05cb a103          	cp	a,#3
2957  05cd 260d          	jrne	L727
2960  05cf 4b02          	push	#2
2961  05d1 4b10          	push	#16
2962  05d3 ae0000        	ldw	x,#_OctetArray
2963  05d6 89            	pushw	x
2964  05d7 c60000        	ld	a,_uip_ethaddr4
2967  05da 2020          	jp	LC004
2968  05dc               L727:
2969                     ; 1075 	  else if (nParsedNum == 4) emb_itoa(uip_ethaddr5, OctetArray, 16, 2);
2971  05dc a104          	cp	a,#4
2972  05de 260d          	jrne	L337
2975  05e0 4b02          	push	#2
2976  05e2 4b10          	push	#16
2977  05e4 ae0000        	ldw	x,#_OctetArray
2978  05e7 89            	pushw	x
2979  05e8 c60000        	ld	a,_uip_ethaddr5
2982  05eb 200f          	jp	LC004
2983  05ed               L337:
2984                     ; 1076 	  else if (nParsedNum == 5) emb_itoa(uip_ethaddr6, OctetArray, 16, 2);
2986  05ed a105          	cp	a,#5
2987  05ef 261e          	jrne	L517
2990  05f1 4b02          	push	#2
2991  05f3 4b10          	push	#16
2992  05f5 ae0000        	ldw	x,#_OctetArray
2993  05f8 89            	pushw	x
2994  05f9 c60000        	ld	a,_uip_ethaddr6
2996  05fc               LC004:
2997  05fc b703          	ld	c_lreg+3,a
2998  05fe 3f02          	clr	c_lreg+2
2999  0600 3f01          	clr	c_lreg+1
3000  0602 3f00          	clr	c_lreg
3001  0604 be02          	ldw	x,c_lreg+2
3002  0606 89            	pushw	x
3003  0607 be00          	ldw	x,c_lreg
3004  0609 89            	pushw	x
3005  060a cd008c        	call	_emb_itoa
3006  060d 5b08          	addw	sp,#8
3007  060f               L517:
3008                     ; 1078           *pBuffer = OctetArray[0];
3010  060f 1e08          	ldw	x,(OFST+1,sp)
3011  0611 c60000        	ld	a,_OctetArray
3012  0614 f7            	ld	(x),a
3013                     ; 1079           pBuffer++;
3015  0615 5c            	incw	x
3016  0616 1f08          	ldw	(OFST+1,sp),x
3017                     ; 1080           nBytes++;
3019  0618 1e05          	ldw	x,(OFST-2,sp)
3020  061a 5c            	incw	x
3021  061b 1f05          	ldw	(OFST-2,sp),x
3023                     ; 1082           *pBuffer = OctetArray[1];
3025  061d c60001        	ld	a,_OctetArray+1
3026  0620 1e08          	ldw	x,(OFST+1,sp)
3027  0622               LC010:
3028  0622 f7            	ld	(x),a
3029                     ; 1083           pBuffer++;
3030                     ; 1084           nBytes++;
3032  0623 cc0af0        	jp	LC009
3033  0626               L117:
3034                     ; 1089         else if (nParsedMode == 'e') {
3036  0626 a165          	cp	a,#101
3037  0628 2703cc0801    	jrne	L347
3038                     ; 1116           switch (nParsedNum)
3040  062d 7b04          	ld	a,(OFST-3,sp)
3042                     ; 1141 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3043  062f a116          	cp	a,#22
3044  0631 2503cc07c2    	jruge	L725
3045  0636 5f            	clrw	x
3046  0637 97            	ld	xl,a
3047  0638 58            	sllw	x
3048  0639 de3cae        	ldw	x,(L422,x)
3049  063c fc            	jp	(x)
3050  063d               L354:
3051                     ; 1119 	    case 0:  emb_itoa(uip_stat.ip.drop,      OctetArray, 10, 10); break;
3053  063d 4b0a          	push	#10
3054  063f 4b0a          	push	#10
3055  0641 ae0000        	ldw	x,#_OctetArray
3056  0644 89            	pushw	x
3057  0645 ce0002        	ldw	x,_uip_stat+2
3058  0648 89            	pushw	x
3059  0649 ce0000        	ldw	x,_uip_stat
3063  064c cc07cc        	jra	L747
3064  064f               L554:
3065                     ; 1120 	    case 1:  emb_itoa(uip_stat.ip.recv,      OctetArray, 10, 10); break;
3067  064f 4b0a          	push	#10
3068  0651 4b0a          	push	#10
3069  0653 ae0000        	ldw	x,#_OctetArray
3070  0656 89            	pushw	x
3071  0657 ce0006        	ldw	x,_uip_stat+6
3072  065a 89            	pushw	x
3073  065b ce0004        	ldw	x,_uip_stat+4
3077  065e cc07cc        	jra	L747
3078  0661               L754:
3079                     ; 1121 	    case 2:  emb_itoa(uip_stat.ip.sent,      OctetArray, 10, 10); break;
3081  0661 4b0a          	push	#10
3082  0663 4b0a          	push	#10
3083  0665 ae0000        	ldw	x,#_OctetArray
3084  0668 89            	pushw	x
3085  0669 ce000a        	ldw	x,_uip_stat+10
3086  066c 89            	pushw	x
3087  066d ce0008        	ldw	x,_uip_stat+8
3091  0670 cc07cc        	jra	L747
3092  0673               L164:
3093                     ; 1122 	    case 3:  emb_itoa(uip_stat.ip.vhlerr,    OctetArray, 10, 10); break;
3095  0673 4b0a          	push	#10
3096  0675 4b0a          	push	#10
3097  0677 ae0000        	ldw	x,#_OctetArray
3098  067a 89            	pushw	x
3099  067b ce000e        	ldw	x,_uip_stat+14
3100  067e 89            	pushw	x
3101  067f ce000c        	ldw	x,_uip_stat+12
3105  0682 cc07cc        	jra	L747
3106  0685               L364:
3107                     ; 1123 	    case 4:  emb_itoa(uip_stat.ip.hblenerr,  OctetArray, 10, 10); break;
3109  0685 4b0a          	push	#10
3110  0687 4b0a          	push	#10
3111  0689 ae0000        	ldw	x,#_OctetArray
3112  068c 89            	pushw	x
3113  068d ce0012        	ldw	x,_uip_stat+18
3114  0690 89            	pushw	x
3115  0691 ce0010        	ldw	x,_uip_stat+16
3119  0694 cc07cc        	jra	L747
3120  0697               L564:
3121                     ; 1124 	    case 5:  emb_itoa(uip_stat.ip.lblenerr,  OctetArray, 10, 10); break;
3123  0697 4b0a          	push	#10
3124  0699 4b0a          	push	#10
3125  069b ae0000        	ldw	x,#_OctetArray
3126  069e 89            	pushw	x
3127  069f ce0016        	ldw	x,_uip_stat+22
3128  06a2 89            	pushw	x
3129  06a3 ce0014        	ldw	x,_uip_stat+20
3133  06a6 cc07cc        	jra	L747
3134  06a9               L764:
3135                     ; 1125 	    case 6:  emb_itoa(uip_stat.ip.fragerr,   OctetArray, 10, 10); break;
3137  06a9 4b0a          	push	#10
3138  06ab 4b0a          	push	#10
3139  06ad ae0000        	ldw	x,#_OctetArray
3140  06b0 89            	pushw	x
3141  06b1 ce001a        	ldw	x,_uip_stat+26
3142  06b4 89            	pushw	x
3143  06b5 ce0018        	ldw	x,_uip_stat+24
3147  06b8 cc07cc        	jra	L747
3148  06bb               L174:
3149                     ; 1126 	    case 7:  emb_itoa(uip_stat.ip.chkerr,    OctetArray, 10, 10); break;
3151  06bb 4b0a          	push	#10
3152  06bd 4b0a          	push	#10
3153  06bf ae0000        	ldw	x,#_OctetArray
3154  06c2 89            	pushw	x
3155  06c3 ce001e        	ldw	x,_uip_stat+30
3156  06c6 89            	pushw	x
3157  06c7 ce001c        	ldw	x,_uip_stat+28
3161  06ca cc07cc        	jra	L747
3162  06cd               L374:
3163                     ; 1127 	    case 8:  emb_itoa(uip_stat.ip.protoerr,  OctetArray, 10, 10); break;
3165  06cd 4b0a          	push	#10
3166  06cf 4b0a          	push	#10
3167  06d1 ae0000        	ldw	x,#_OctetArray
3168  06d4 89            	pushw	x
3169  06d5 ce0022        	ldw	x,_uip_stat+34
3170  06d8 89            	pushw	x
3171  06d9 ce0020        	ldw	x,_uip_stat+32
3175  06dc cc07cc        	jra	L747
3176  06df               L574:
3177                     ; 1128 	    case 9:  emb_itoa(uip_stat.icmp.drop,    OctetArray, 10, 10); break;
3179  06df 4b0a          	push	#10
3180  06e1 4b0a          	push	#10
3181  06e3 ae0000        	ldw	x,#_OctetArray
3182  06e6 89            	pushw	x
3183  06e7 ce0026        	ldw	x,_uip_stat+38
3184  06ea 89            	pushw	x
3185  06eb ce0024        	ldw	x,_uip_stat+36
3189  06ee cc07cc        	jra	L747
3190  06f1               L774:
3191                     ; 1129 	    case 10: emb_itoa(uip_stat.icmp.recv,    OctetArray, 10, 10); break;
3193  06f1 4b0a          	push	#10
3194  06f3 4b0a          	push	#10
3195  06f5 ae0000        	ldw	x,#_OctetArray
3196  06f8 89            	pushw	x
3197  06f9 ce002a        	ldw	x,_uip_stat+42
3198  06fc 89            	pushw	x
3199  06fd ce0028        	ldw	x,_uip_stat+40
3203  0700 cc07cc        	jra	L747
3204  0703               L105:
3205                     ; 1130 	    case 11: emb_itoa(uip_stat.icmp.sent,    OctetArray, 10, 10); break;
3207  0703 4b0a          	push	#10
3208  0705 4b0a          	push	#10
3209  0707 ae0000        	ldw	x,#_OctetArray
3210  070a 89            	pushw	x
3211  070b ce002e        	ldw	x,_uip_stat+46
3212  070e 89            	pushw	x
3213  070f ce002c        	ldw	x,_uip_stat+44
3217  0712 cc07cc        	jra	L747
3218  0715               L305:
3219                     ; 1131 	    case 12: emb_itoa(uip_stat.icmp.typeerr, OctetArray, 10, 10); break;
3221  0715 4b0a          	push	#10
3222  0717 4b0a          	push	#10
3223  0719 ae0000        	ldw	x,#_OctetArray
3224  071c 89            	pushw	x
3225  071d ce0032        	ldw	x,_uip_stat+50
3226  0720 89            	pushw	x
3227  0721 ce0030        	ldw	x,_uip_stat+48
3231  0724 cc07cc        	jra	L747
3232  0727               L505:
3233                     ; 1132 	    case 13: emb_itoa(uip_stat.tcp.drop,     OctetArray, 10, 10); break;
3235  0727 4b0a          	push	#10
3236  0729 4b0a          	push	#10
3237  072b ae0000        	ldw	x,#_OctetArray
3238  072e 89            	pushw	x
3239  072f ce0036        	ldw	x,_uip_stat+54
3240  0732 89            	pushw	x
3241  0733 ce0034        	ldw	x,_uip_stat+52
3245  0736 cc07cc        	jra	L747
3246  0739               L705:
3247                     ; 1133 	    case 14: emb_itoa(uip_stat.tcp.recv,     OctetArray, 10, 10); break;
3249  0739 4b0a          	push	#10
3250  073b 4b0a          	push	#10
3251  073d ae0000        	ldw	x,#_OctetArray
3252  0740 89            	pushw	x
3253  0741 ce003a        	ldw	x,_uip_stat+58
3254  0744 89            	pushw	x
3255  0745 ce0038        	ldw	x,_uip_stat+56
3259  0748 cc07cc        	jra	L747
3260  074b               L115:
3261                     ; 1134 	    case 15: emb_itoa(uip_stat.tcp.sent,     OctetArray, 10, 10); break;
3263  074b 4b0a          	push	#10
3264  074d 4b0a          	push	#10
3265  074f ae0000        	ldw	x,#_OctetArray
3266  0752 89            	pushw	x
3267  0753 ce003e        	ldw	x,_uip_stat+62
3268  0756 89            	pushw	x
3269  0757 ce003c        	ldw	x,_uip_stat+60
3273  075a 2070          	jra	L747
3274  075c               L315:
3275                     ; 1135 	    case 16: emb_itoa(uip_stat.tcp.chkerr,   OctetArray, 10, 10); break;
3277  075c 4b0a          	push	#10
3278  075e 4b0a          	push	#10
3279  0760 ae0000        	ldw	x,#_OctetArray
3280  0763 89            	pushw	x
3281  0764 ce0042        	ldw	x,_uip_stat+66
3282  0767 89            	pushw	x
3283  0768 ce0040        	ldw	x,_uip_stat+64
3287  076b 205f          	jra	L747
3288  076d               L515:
3289                     ; 1136 	    case 17: emb_itoa(uip_stat.tcp.ackerr,   OctetArray, 10, 10); break;
3291  076d 4b0a          	push	#10
3292  076f 4b0a          	push	#10
3293  0771 ae0000        	ldw	x,#_OctetArray
3294  0774 89            	pushw	x
3295  0775 ce0046        	ldw	x,_uip_stat+70
3296  0778 89            	pushw	x
3297  0779 ce0044        	ldw	x,_uip_stat+68
3301  077c 204e          	jra	L747
3302  077e               L715:
3303                     ; 1137 	    case 18: emb_itoa(uip_stat.tcp.rst,      OctetArray, 10, 10); break;
3305  077e 4b0a          	push	#10
3306  0780 4b0a          	push	#10
3307  0782 ae0000        	ldw	x,#_OctetArray
3308  0785 89            	pushw	x
3309  0786 ce004a        	ldw	x,_uip_stat+74
3310  0789 89            	pushw	x
3311  078a ce0048        	ldw	x,_uip_stat+72
3315  078d 203d          	jra	L747
3316  078f               L125:
3317                     ; 1138 	    case 19: emb_itoa(uip_stat.tcp.rexmit,   OctetArray, 10, 10); break;
3319  078f 4b0a          	push	#10
3320  0791 4b0a          	push	#10
3321  0793 ae0000        	ldw	x,#_OctetArray
3322  0796 89            	pushw	x
3323  0797 ce004e        	ldw	x,_uip_stat+78
3324  079a 89            	pushw	x
3325  079b ce004c        	ldw	x,_uip_stat+76
3329  079e 202c          	jra	L747
3330  07a0               L325:
3331                     ; 1139 	    case 20: emb_itoa(uip_stat.tcp.syndrop,  OctetArray, 10, 10); break;
3333  07a0 4b0a          	push	#10
3334  07a2 4b0a          	push	#10
3335  07a4 ae0000        	ldw	x,#_OctetArray
3336  07a7 89            	pushw	x
3337  07a8 ce0052        	ldw	x,_uip_stat+82
3338  07ab 89            	pushw	x
3339  07ac ce0050        	ldw	x,_uip_stat+80
3343  07af 201b          	jra	L747
3344  07b1               L525:
3345                     ; 1140 	    case 21: emb_itoa(uip_stat.tcp.synrst,   OctetArray, 10, 10); break;
3347  07b1 4b0a          	push	#10
3348  07b3 4b0a          	push	#10
3349  07b5 ae0000        	ldw	x,#_OctetArray
3350  07b8 89            	pushw	x
3351  07b9 ce0056        	ldw	x,_uip_stat+86
3352  07bc 89            	pushw	x
3353  07bd ce0054        	ldw	x,_uip_stat+84
3357  07c0 200a          	jra	L747
3358  07c2               L725:
3359                     ; 1141 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3361  07c2 4b0a          	push	#10
3362  07c4 4b0a          	push	#10
3363  07c6 ae0000        	ldw	x,#_OctetArray
3364  07c9 89            	pushw	x
3365  07ca 5f            	clrw	x
3366  07cb 89            	pushw	x
3370  07cc               L747:
3371  07cc 89            	pushw	x
3372  07cd cd008c        	call	_emb_itoa
3373  07d0 5b08          	addw	sp,#8
3374                     ; 1144 	  for (i=0; i<10; i++) {
3376  07d2 4f            	clr	a
3377  07d3 6b07          	ld	(OFST+0,sp),a
3379  07d5               L157:
3380                     ; 1145             *pBuffer = OctetArray[i];
3382  07d5 5f            	clrw	x
3383  07d6 97            	ld	xl,a
3384  07d7 d60000        	ld	a,(_OctetArray,x)
3385  07da 1e08          	ldw	x,(OFST+1,sp)
3386  07dc f7            	ld	(x),a
3387                     ; 1146             pBuffer++;
3389  07dd 5c            	incw	x
3390  07de 1f08          	ldw	(OFST+1,sp),x
3391                     ; 1147             nBytes++;
3393  07e0 1e05          	ldw	x,(OFST-2,sp)
3394  07e2 5c            	incw	x
3395  07e3 1f05          	ldw	(OFST-2,sp),x
3397                     ; 1144 	  for (i=0; i<10; i++) {
3399  07e5 0c07          	inc	(OFST+0,sp)
3403  07e7 7b07          	ld	a,(OFST+0,sp)
3404  07e9 a10a          	cp	a,#10
3405  07eb 25e8          	jrult	L157
3406                     ; 1152           *ppData = *ppData + 10;
3408  07ed 1e0c          	ldw	x,(OFST+5,sp)
3409  07ef 9093          	ldw	y,x
3410  07f1 fe            	ldw	x,(x)
3411  07f2 1c000a        	addw	x,#10
3412  07f5 90ff          	ldw	(y),x
3413                     ; 1153           *pDataLeft = *pDataLeft - 10;
3415  07f7 1e0e          	ldw	x,(OFST+7,sp)
3416  07f9 9093          	ldw	y,x
3417  07fb fe            	ldw	x,(x)
3418  07fc 1d000a        	subw	x,#10
3420  07ff 2031          	jp	LC011
3421  0801               L347:
3422                     ; 1158         else if (nParsedMode == 'f') {
3424  0801 a166          	cp	a,#102
3425  0803 2632          	jrne	L167
3426                     ; 1161 	  for(i=0; i<16; i++) {
3428  0805 4f            	clr	a
3429  0806 6b07          	ld	(OFST+0,sp),a
3431  0808               L367:
3432                     ; 1162 	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
3434  0808 cd1335        	call	_GpioGetPin
3436  080b 1e08          	ldw	x,(OFST+1,sp)
3437  080d ab30          	add	a,#48
3438  080f f7            	ld	(x),a
3439                     ; 1163             pBuffer++;
3441  0810 5c            	incw	x
3442  0811 1f08          	ldw	(OFST+1,sp),x
3443                     ; 1164             nBytes++;
3445  0813 1e05          	ldw	x,(OFST-2,sp)
3446  0815 5c            	incw	x
3447  0816 1f05          	ldw	(OFST-2,sp),x
3449                     ; 1161 	  for(i=0; i<16; i++) {
3451  0818 0c07          	inc	(OFST+0,sp)
3455  081a 7b07          	ld	a,(OFST+0,sp)
3456  081c a110          	cp	a,#16
3457  081e 25e8          	jrult	L367
3458                     ; 1168           *ppData = *ppData + 16;
3460  0820 1e0c          	ldw	x,(OFST+5,sp)
3461  0822 9093          	ldw	y,x
3462  0824 fe            	ldw	x,(x)
3463  0825 1c0010        	addw	x,#16
3464  0828 90ff          	ldw	(y),x
3465                     ; 1169           *pDataLeft = *pDataLeft - 16;
3467  082a 1e0e          	ldw	x,(OFST+7,sp)
3468  082c 9093          	ldw	y,x
3469  082e fe            	ldw	x,(x)
3470  082f 1d0010        	subw	x,#16
3471  0832               LC011:
3472  0832 90ff          	ldw	(y),x
3474  0834 cc0af8        	jra	L306
3475  0837               L167:
3476                     ; 1172         else if (nParsedMode == 'g') {
3478  0837 a167          	cp	a,#103
3479  0839 2623          	jrne	L377
3480                     ; 1176 	  if (invert_output == 1) {  // Insert 'checked'
3482  083b c60000        	ld	a,_invert_output
3483  083e 4a            	dec	a
3484  083f 26f3          	jrne	L306
3485                     ; 1177             for(i=0; i<7; i++) {
3487  0841 6b07          	ld	(OFST+0,sp),a
3489  0843               L777:
3490                     ; 1178               *pBuffer = checked[i];
3492  0843 5f            	clrw	x
3493  0844 97            	ld	xl,a
3494  0845 d60000        	ld	a,(L31_checked,x)
3495  0848 1e08          	ldw	x,(OFST+1,sp)
3496  084a f7            	ld	(x),a
3497                     ; 1179               pBuffer++;
3499  084b 5c            	incw	x
3500  084c 1f08          	ldw	(OFST+1,sp),x
3501                     ; 1180               nBytes++;
3503  084e 1e05          	ldw	x,(OFST-2,sp)
3504  0850 5c            	incw	x
3505  0851 1f05          	ldw	(OFST-2,sp),x
3507                     ; 1177             for(i=0; i<7; i++) {
3509  0853 0c07          	inc	(OFST+0,sp)
3513  0855 7b07          	ld	a,(OFST+0,sp)
3514  0857 a107          	cp	a,#7
3515  0859 25e8          	jrult	L777
3516  085b cc0af8        	jra	L306
3517  085e               L377:
3518                     ; 1185         else if (nParsedMode == 'h') {
3520  085e a168          	cp	a,#104
3521  0860 2622          	jrne	L7001
3522                     ; 1190 	  if (invert_output == 0) {  // Insert 'checked'
3524  0862 c60000        	ld	a,_invert_output
3525  0865 26f4          	jrne	L306
3526                     ; 1191             for(i=0; i<7; i++) {
3528  0867 6b07          	ld	(OFST+0,sp),a
3530  0869               L3101:
3531                     ; 1192               *pBuffer = checked[i];
3533  0869 5f            	clrw	x
3534  086a 97            	ld	xl,a
3535  086b d60000        	ld	a,(L31_checked,x)
3536  086e 1e08          	ldw	x,(OFST+1,sp)
3537  0870 f7            	ld	(x),a
3538                     ; 1193               pBuffer++;
3540  0871 5c            	incw	x
3541  0872 1f08          	ldw	(OFST+1,sp),x
3542                     ; 1194               nBytes++;
3544  0874 1e05          	ldw	x,(OFST-2,sp)
3545  0876 5c            	incw	x
3546  0877 1f05          	ldw	(OFST-2,sp),x
3548                     ; 1191             for(i=0; i<7; i++) {
3550  0879 0c07          	inc	(OFST+0,sp)
3554  087b 7b07          	ld	a,(OFST+0,sp)
3555  087d a107          	cp	a,#7
3556  087f 25e8          	jrult	L3101
3557  0881 cc0af8        	jra	L306
3558  0884               L7001:
3559                     ; 1199         else if (nParsedMode == 'x') {
3561  0884 a178          	cp	a,#120
3562  0886 26f9          	jrne	L306
3563                     ; 1209           *pBuffer = 'h'; pBuffer++; nBytes++;
3565  0888 1e08          	ldw	x,(OFST+1,sp)
3566  088a a668          	ld	a,#104
3567  088c f7            	ld	(x),a
3570  088d 5c            	incw	x
3571  088e 1f08          	ldw	(OFST+1,sp),x
3574  0890 1e05          	ldw	x,(OFST-2,sp)
3575  0892 5c            	incw	x
3576  0893 1f05          	ldw	(OFST-2,sp),x
3578                     ; 1210           *pBuffer = 't'; pBuffer++; nBytes++;
3580  0895 1e08          	ldw	x,(OFST+1,sp)
3581  0897 a674          	ld	a,#116
3582  0899 f7            	ld	(x),a
3585  089a 5c            	incw	x
3586  089b 1f08          	ldw	(OFST+1,sp),x
3589  089d 1e05          	ldw	x,(OFST-2,sp)
3590  089f 5c            	incw	x
3591  08a0 1f05          	ldw	(OFST-2,sp),x
3593                     ; 1211           *pBuffer = 't'; pBuffer++; nBytes++;
3595  08a2 1e08          	ldw	x,(OFST+1,sp)
3596  08a4 f7            	ld	(x),a
3599  08a5 5c            	incw	x
3600  08a6 1f08          	ldw	(OFST+1,sp),x
3603  08a8 1e05          	ldw	x,(OFST-2,sp)
3604  08aa 5c            	incw	x
3605  08ab 1f05          	ldw	(OFST-2,sp),x
3607                     ; 1212           *pBuffer = 'p'; pBuffer++; nBytes++;
3609  08ad 1e08          	ldw	x,(OFST+1,sp)
3610  08af a670          	ld	a,#112
3611  08b1 f7            	ld	(x),a
3614  08b2 5c            	incw	x
3615  08b3 1f08          	ldw	(OFST+1,sp),x
3618  08b5 1e05          	ldw	x,(OFST-2,sp)
3619  08b7 5c            	incw	x
3620  08b8 1f05          	ldw	(OFST-2,sp),x
3622                     ; 1213           *pBuffer = ':'; pBuffer++; nBytes++;
3624  08ba 1e08          	ldw	x,(OFST+1,sp)
3625  08bc a63a          	ld	a,#58
3626  08be f7            	ld	(x),a
3629  08bf 5c            	incw	x
3630  08c0 1f08          	ldw	(OFST+1,sp),x
3633  08c2 1e05          	ldw	x,(OFST-2,sp)
3634  08c4 5c            	incw	x
3635  08c5 1f05          	ldw	(OFST-2,sp),x
3637                     ; 1214           *pBuffer = '/'; pBuffer++; nBytes++;
3639  08c7 1e08          	ldw	x,(OFST+1,sp)
3640  08c9 a62f          	ld	a,#47
3641  08cb f7            	ld	(x),a
3644  08cc 5c            	incw	x
3645  08cd 1f08          	ldw	(OFST+1,sp),x
3648  08cf 1e05          	ldw	x,(OFST-2,sp)
3649  08d1 5c            	incw	x
3650  08d2 1f05          	ldw	(OFST-2,sp),x
3652                     ; 1215           *pBuffer = '/'; pBuffer++; nBytes++;
3654  08d4 1e08          	ldw	x,(OFST+1,sp)
3655  08d6 f7            	ld	(x),a
3658  08d7 5c            	incw	x
3659  08d8 1f08          	ldw	(OFST+1,sp),x
3662  08da 1e05          	ldw	x,(OFST-2,sp)
3663  08dc 5c            	incw	x
3664  08dd 1f05          	ldw	(OFST-2,sp),x
3666                     ; 1219           emb_itoa(ex_stored_hostaddr4,  OctetArray, 10, 3);
3668  08df 4b03          	push	#3
3669  08e1 4b0a          	push	#10
3670  08e3 ae0000        	ldw	x,#_OctetArray
3671  08e6 89            	pushw	x
3672  08e7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr4
3673  08ec 3f02          	clr	c_lreg+2
3674  08ee 3f01          	clr	c_lreg+1
3675  08f0 3f00          	clr	c_lreg
3676  08f2 be02          	ldw	x,c_lreg+2
3677  08f4 89            	pushw	x
3678  08f5 be00          	ldw	x,c_lreg
3679  08f7 89            	pushw	x
3680  08f8 cd008c        	call	_emb_itoa
3682  08fb 5b08          	addw	sp,#8
3683                     ; 1221 	  if (OctetArray[0] != '0') {
3685  08fd c60000        	ld	a,_OctetArray
3686  0900 a130          	cp	a,#48
3687  0902 270b          	jreq	L5201
3688                     ; 1222 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3690  0904 1e08          	ldw	x,(OFST+1,sp)
3691  0906 f7            	ld	(x),a
3694  0907 5c            	incw	x
3695  0908 1f08          	ldw	(OFST+1,sp),x
3698  090a 1e05          	ldw	x,(OFST-2,sp)
3699  090c 5c            	incw	x
3700  090d 1f05          	ldw	(OFST-2,sp),x
3702  090f               L5201:
3703                     ; 1224 	  if (OctetArray[0] != '0') {
3705  090f a130          	cp	a,#48
3706  0911 2707          	jreq	L7201
3707                     ; 1225             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3709  0913 1e08          	ldw	x,(OFST+1,sp)
3710  0915 c60001        	ld	a,_OctetArray+1
3714  0918 2009          	jp	LC005
3715  091a               L7201:
3716                     ; 1227 	  else if (OctetArray[1] != '0') {
3718  091a c60001        	ld	a,_OctetArray+1
3719  091d a130          	cp	a,#48
3720  091f 270b          	jreq	L1301
3721                     ; 1228             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3723  0921 1e08          	ldw	x,(OFST+1,sp)
3728  0923               LC005:
3729  0923 f7            	ld	(x),a
3731  0924 5c            	incw	x
3732  0925 1f08          	ldw	(OFST+1,sp),x
3734  0927 1e05          	ldw	x,(OFST-2,sp)
3735  0929 5c            	incw	x
3736  092a 1f05          	ldw	(OFST-2,sp),x
3738  092c               L1301:
3739                     ; 1230           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3741  092c 1e08          	ldw	x,(OFST+1,sp)
3742  092e c60002        	ld	a,_OctetArray+2
3743  0931 f7            	ld	(x),a
3746  0932 5c            	incw	x
3747  0933 1f08          	ldw	(OFST+1,sp),x
3750  0935 1e05          	ldw	x,(OFST-2,sp)
3751  0937 5c            	incw	x
3752  0938 1f05          	ldw	(OFST-2,sp),x
3754                     ; 1232           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3756  093a 1e08          	ldw	x,(OFST+1,sp)
3757  093c a62e          	ld	a,#46
3758  093e f7            	ld	(x),a
3761  093f 5c            	incw	x
3762  0940 1f08          	ldw	(OFST+1,sp),x
3765  0942 1e05          	ldw	x,(OFST-2,sp)
3766  0944 5c            	incw	x
3767  0945 1f05          	ldw	(OFST-2,sp),x
3769                     ; 1235           emb_itoa(ex_stored_hostaddr3,  OctetArray, 10, 3);
3771  0947 4b03          	push	#3
3772  0949 4b0a          	push	#10
3773  094b ae0000        	ldw	x,#_OctetArray
3774  094e 89            	pushw	x
3775  094f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr3
3776  0954 3f02          	clr	c_lreg+2
3777  0956 3f01          	clr	c_lreg+1
3778  0958 3f00          	clr	c_lreg
3779  095a be02          	ldw	x,c_lreg+2
3780  095c 89            	pushw	x
3781  095d be00          	ldw	x,c_lreg
3782  095f 89            	pushw	x
3783  0960 cd008c        	call	_emb_itoa
3785  0963 5b08          	addw	sp,#8
3786                     ; 1237 	  if (OctetArray[0] != '0') {
3788  0965 c60000        	ld	a,_OctetArray
3789  0968 a130          	cp	a,#48
3790  096a 270b          	jreq	L5301
3791                     ; 1238 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3793  096c 1e08          	ldw	x,(OFST+1,sp)
3794  096e f7            	ld	(x),a
3797  096f 5c            	incw	x
3798  0970 1f08          	ldw	(OFST+1,sp),x
3801  0972 1e05          	ldw	x,(OFST-2,sp)
3802  0974 5c            	incw	x
3803  0975 1f05          	ldw	(OFST-2,sp),x
3805  0977               L5301:
3806                     ; 1240 	  if (OctetArray[0] != '0') {
3808  0977 a130          	cp	a,#48
3809  0979 2707          	jreq	L7301
3810                     ; 1241             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3812  097b 1e08          	ldw	x,(OFST+1,sp)
3813  097d c60001        	ld	a,_OctetArray+1
3817  0980 2009          	jp	LC006
3818  0982               L7301:
3819                     ; 1243 	  else if (OctetArray[1] != '0') {
3821  0982 c60001        	ld	a,_OctetArray+1
3822  0985 a130          	cp	a,#48
3823  0987 270b          	jreq	L1401
3824                     ; 1244             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3826  0989 1e08          	ldw	x,(OFST+1,sp)
3831  098b               LC006:
3832  098b f7            	ld	(x),a
3834  098c 5c            	incw	x
3835  098d 1f08          	ldw	(OFST+1,sp),x
3837  098f 1e05          	ldw	x,(OFST-2,sp)
3838  0991 5c            	incw	x
3839  0992 1f05          	ldw	(OFST-2,sp),x
3841  0994               L1401:
3842                     ; 1246           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3844  0994 1e08          	ldw	x,(OFST+1,sp)
3845  0996 c60002        	ld	a,_OctetArray+2
3846  0999 f7            	ld	(x),a
3849  099a 5c            	incw	x
3850  099b 1f08          	ldw	(OFST+1,sp),x
3853  099d 1e05          	ldw	x,(OFST-2,sp)
3854  099f 5c            	incw	x
3855  09a0 1f05          	ldw	(OFST-2,sp),x
3857                     ; 1248           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3859  09a2 1e08          	ldw	x,(OFST+1,sp)
3860  09a4 a62e          	ld	a,#46
3861  09a6 f7            	ld	(x),a
3864  09a7 5c            	incw	x
3865  09a8 1f08          	ldw	(OFST+1,sp),x
3868  09aa 1e05          	ldw	x,(OFST-2,sp)
3869  09ac 5c            	incw	x
3870  09ad 1f05          	ldw	(OFST-2,sp),x
3872                     ; 1251           emb_itoa(ex_stored_hostaddr2,  OctetArray, 10, 3);
3874  09af 4b03          	push	#3
3875  09b1 4b0a          	push	#10
3876  09b3 ae0000        	ldw	x,#_OctetArray
3877  09b6 89            	pushw	x
3878  09b7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr2
3879  09bc 3f02          	clr	c_lreg+2
3880  09be 3f01          	clr	c_lreg+1
3881  09c0 3f00          	clr	c_lreg
3882  09c2 be02          	ldw	x,c_lreg+2
3883  09c4 89            	pushw	x
3884  09c5 be00          	ldw	x,c_lreg
3885  09c7 89            	pushw	x
3886  09c8 cd008c        	call	_emb_itoa
3888  09cb 5b08          	addw	sp,#8
3889                     ; 1253 	  if (OctetArray[0] != '0') {
3891  09cd c60000        	ld	a,_OctetArray
3892  09d0 a130          	cp	a,#48
3893  09d2 270b          	jreq	L5401
3894                     ; 1254 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3896  09d4 1e08          	ldw	x,(OFST+1,sp)
3897  09d6 f7            	ld	(x),a
3900  09d7 5c            	incw	x
3901  09d8 1f08          	ldw	(OFST+1,sp),x
3904  09da 1e05          	ldw	x,(OFST-2,sp)
3905  09dc 5c            	incw	x
3906  09dd 1f05          	ldw	(OFST-2,sp),x
3908  09df               L5401:
3909                     ; 1256 	  if (OctetArray[0] != '0') {
3911  09df a130          	cp	a,#48
3912  09e1 2707          	jreq	L7401
3913                     ; 1257             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3915  09e3 1e08          	ldw	x,(OFST+1,sp)
3916  09e5 c60001        	ld	a,_OctetArray+1
3920  09e8 2009          	jp	LC007
3921  09ea               L7401:
3922                     ; 1259 	  else if (OctetArray[1] != '0') {
3924  09ea c60001        	ld	a,_OctetArray+1
3925  09ed a130          	cp	a,#48
3926  09ef 270b          	jreq	L1501
3927                     ; 1260             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3929  09f1 1e08          	ldw	x,(OFST+1,sp)
3934  09f3               LC007:
3935  09f3 f7            	ld	(x),a
3937  09f4 5c            	incw	x
3938  09f5 1f08          	ldw	(OFST+1,sp),x
3940  09f7 1e05          	ldw	x,(OFST-2,sp)
3941  09f9 5c            	incw	x
3942  09fa 1f05          	ldw	(OFST-2,sp),x
3944  09fc               L1501:
3945                     ; 1262           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3947  09fc 1e08          	ldw	x,(OFST+1,sp)
3948  09fe c60002        	ld	a,_OctetArray+2
3949  0a01 f7            	ld	(x),a
3952  0a02 5c            	incw	x
3953  0a03 1f08          	ldw	(OFST+1,sp),x
3956  0a05 1e05          	ldw	x,(OFST-2,sp)
3957  0a07 5c            	incw	x
3958  0a08 1f05          	ldw	(OFST-2,sp),x
3960                     ; 1264           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3962  0a0a 1e08          	ldw	x,(OFST+1,sp)
3963  0a0c a62e          	ld	a,#46
3964  0a0e f7            	ld	(x),a
3967  0a0f 5c            	incw	x
3968  0a10 1f08          	ldw	(OFST+1,sp),x
3971  0a12 1e05          	ldw	x,(OFST-2,sp)
3972  0a14 5c            	incw	x
3973  0a15 1f05          	ldw	(OFST-2,sp),x
3975                     ; 1267           emb_itoa(ex_stored_hostaddr1,  OctetArray, 10, 3);
3977  0a17 4b03          	push	#3
3978  0a19 4b0a          	push	#10
3979  0a1b ae0000        	ldw	x,#_OctetArray
3980  0a1e 89            	pushw	x
3981  0a1f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr1
3982  0a24 3f02          	clr	c_lreg+2
3983  0a26 3f01          	clr	c_lreg+1
3984  0a28 3f00          	clr	c_lreg
3985  0a2a be02          	ldw	x,c_lreg+2
3986  0a2c 89            	pushw	x
3987  0a2d be00          	ldw	x,c_lreg
3988  0a2f 89            	pushw	x
3989  0a30 cd008c        	call	_emb_itoa
3991  0a33 5b08          	addw	sp,#8
3992                     ; 1269 	  if (OctetArray[0] != '0') {
3994  0a35 c60000        	ld	a,_OctetArray
3995  0a38 a130          	cp	a,#48
3996  0a3a 270b          	jreq	L5501
3997                     ; 1270 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3999  0a3c 1e08          	ldw	x,(OFST+1,sp)
4000  0a3e f7            	ld	(x),a
4003  0a3f 5c            	incw	x
4004  0a40 1f08          	ldw	(OFST+1,sp),x
4007  0a42 1e05          	ldw	x,(OFST-2,sp)
4008  0a44 5c            	incw	x
4009  0a45 1f05          	ldw	(OFST-2,sp),x
4011  0a47               L5501:
4012                     ; 1272 	  if (OctetArray[0] != '0') {
4014  0a47 a130          	cp	a,#48
4015  0a49 2707          	jreq	L7501
4016                     ; 1273             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
4018  0a4b 1e08          	ldw	x,(OFST+1,sp)
4019  0a4d c60001        	ld	a,_OctetArray+1
4023  0a50 2009          	jp	LC008
4024  0a52               L7501:
4025                     ; 1275 	  else if (OctetArray[1] != '0') {
4027  0a52 c60001        	ld	a,_OctetArray+1
4028  0a55 a130          	cp	a,#48
4029  0a57 270b          	jreq	L1601
4030                     ; 1276             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
4032  0a59 1e08          	ldw	x,(OFST+1,sp)
4037  0a5b               LC008:
4038  0a5b f7            	ld	(x),a
4040  0a5c 5c            	incw	x
4041  0a5d 1f08          	ldw	(OFST+1,sp),x
4043  0a5f 1e05          	ldw	x,(OFST-2,sp)
4044  0a61 5c            	incw	x
4045  0a62 1f05          	ldw	(OFST-2,sp),x
4047  0a64               L1601:
4048                     ; 1278           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
4050  0a64 1e08          	ldw	x,(OFST+1,sp)
4051  0a66 c60002        	ld	a,_OctetArray+2
4052  0a69 f7            	ld	(x),a
4055  0a6a 5c            	incw	x
4056  0a6b 1f08          	ldw	(OFST+1,sp),x
4059  0a6d 1e05          	ldw	x,(OFST-2,sp)
4060  0a6f 5c            	incw	x
4061  0a70 1f05          	ldw	(OFST-2,sp),x
4063                     ; 1280           *pBuffer = ':'; pBuffer++; nBytes++; // Output ':'
4065  0a72 1e08          	ldw	x,(OFST+1,sp)
4066  0a74 a63a          	ld	a,#58
4067  0a76 f7            	ld	(x),a
4070  0a77 5c            	incw	x
4071  0a78 1f08          	ldw	(OFST+1,sp),x
4074  0a7a 1e05          	ldw	x,(OFST-2,sp)
4075  0a7c 5c            	incw	x
4076  0a7d 1f05          	ldw	(OFST-2,sp),x
4078                     ; 1283   	  emb_itoa(ex_stored_port, OctetArray, 10, 5);
4080  0a7f 4b05          	push	#5
4081  0a81 4b0a          	push	#10
4082  0a83 ae0000        	ldw	x,#_OctetArray
4083  0a86 89            	pushw	x
4084  0a87 ce0000        	ldw	x,_ex_stored_port
4085  0a8a cd0000        	call	c_uitolx
4087  0a8d be02          	ldw	x,c_lreg+2
4088  0a8f 89            	pushw	x
4089  0a90 be00          	ldw	x,c_lreg
4090  0a92 89            	pushw	x
4091  0a93 cd008c        	call	_emb_itoa
4093  0a96 5b08          	addw	sp,#8
4094                     ; 1285 	  for(i=0; i<5; i++) {
4096  0a98 4f            	clr	a
4097  0a99 6b07          	ld	(OFST+0,sp),a
4099  0a9b               L5601:
4100                     ; 1286 	    if (OctetArray[i] != '0') break;
4102  0a9b 5f            	clrw	x
4103  0a9c 97            	ld	xl,a
4104  0a9d d60000        	ld	a,(_OctetArray,x)
4105  0aa0 a130          	cp	a,#48
4106  0aa2 261c          	jrne	L7701
4109                     ; 1285 	  for(i=0; i<5; i++) {
4111  0aa4 0c07          	inc	(OFST+0,sp)
4115  0aa6 7b07          	ld	a,(OFST+0,sp)
4116  0aa8 a105          	cp	a,#5
4117  0aaa 25ef          	jrult	L5601
4118  0aac 2012          	jra	L7701
4119  0aae               L5701:
4120                     ; 1289 	    *pBuffer = OctetArray[i]; pBuffer++; nBytes++;
4122  0aae 5f            	clrw	x
4123  0aaf 97            	ld	xl,a
4124  0ab0 d60000        	ld	a,(_OctetArray,x)
4125  0ab3 1e08          	ldw	x,(OFST+1,sp)
4126  0ab5 f7            	ld	(x),a
4129  0ab6 5c            	incw	x
4130  0ab7 1f08          	ldw	(OFST+1,sp),x
4133  0ab9 1e05          	ldw	x,(OFST-2,sp)
4134  0abb 5c            	incw	x
4135  0abc 1f05          	ldw	(OFST-2,sp),x
4137                     ; 1290 	    i++;
4139  0abe 0c07          	inc	(OFST+0,sp)
4141  0ac0               L7701:
4142                     ; 1288 	  while(i<5) {
4144  0ac0 7b07          	ld	a,(OFST+0,sp)
4145  0ac2 a105          	cp	a,#5
4146  0ac4 25e8          	jrult	L5701
4147                     ; 1295           *ppData = *ppData + 28;
4149  0ac6 1e0c          	ldw	x,(OFST+5,sp)
4150  0ac8 9093          	ldw	y,x
4151  0aca fe            	ldw	x,(x)
4152  0acb 1c001c        	addw	x,#28
4153  0ace 90ff          	ldw	(y),x
4154                     ; 1296           *pDataLeft = *pDataLeft - 28;
4156  0ad0 1e0e          	ldw	x,(OFST+7,sp)
4157  0ad2 9093          	ldw	y,x
4158  0ad4 fe            	ldw	x,(x)
4159  0ad5 1d001c        	subw	x,#28
4160  0ad8 cc0832        	jp	LC011
4161  0adb               L116:
4162                     ; 1300         *pBuffer = nByte;
4164  0adb 1e08          	ldw	x,(OFST+1,sp)
4165  0add f7            	ld	(x),a
4166                     ; 1301         *ppData = *ppData + 1;
4168  0ade 1e0c          	ldw	x,(OFST+5,sp)
4169  0ae0 9093          	ldw	y,x
4170  0ae2 fe            	ldw	x,(x)
4171  0ae3 5c            	incw	x
4172  0ae4 90ff          	ldw	(y),x
4173                     ; 1302         *pDataLeft = *pDataLeft - 1;
4175  0ae6 1e0e          	ldw	x,(OFST+7,sp)
4176  0ae8 9093          	ldw	y,x
4177  0aea fe            	ldw	x,(x)
4178  0aeb 5a            	decw	x
4179  0aec 90ff          	ldw	(y),x
4180                     ; 1303         pBuffer++;
4182  0aee 1e08          	ldw	x,(OFST+1,sp)
4183                     ; 1304         nBytes++;
4185  0af0               LC009:
4188  0af0 5c            	incw	x
4189  0af1 1f08          	ldw	(OFST+1,sp),x
4192  0af3 1e05          	ldw	x,(OFST-2,sp)
4193  0af5 5c            	incw	x
4194  0af6 1f05          	ldw	(OFST-2,sp),x
4196  0af8               L306:
4197                     ; 842   while (nBytes < nMaxBytes) {
4199  0af8 1e05          	ldw	x,(OFST-2,sp)
4200  0afa 1310          	cpw	x,(OFST+9,sp)
4201  0afc 2403cc02e1    	jrult	L106
4202  0b01               L506:
4203                     ; 1309   return nBytes;
4205  0b01 1e05          	ldw	x,(OFST-2,sp)
4208  0b03 5b09          	addw	sp,#9
4209  0b05 81            	ret	
4236                     ; 1313 void HttpDInit()
4236                     ; 1314 {
4237                     	switch	.text
4238  0b06               _HttpDInit:
4242                     ; 1316   uip_listen(htons(Port_Httpd));
4244  0b06 ce0000        	ldw	x,_Port_Httpd
4245  0b09 cd0000        	call	_htons
4247  0b0c cd0000        	call	_uip_listen
4249                     ; 1317   current_webpage = WEBPAGE_DEFAULT;
4251  0b0f 725f000b      	clr	_current_webpage
4252                     ; 1318 }
4255  0b13 81            	ret	
4462                     	switch	.const
4463  3cda               L672:
4464  3cda 1088          	dc.w	L7111
4465  3cdc 108f          	dc.w	L1211
4466  3cde 1096          	dc.w	L3211
4467  3ce0 109d          	dc.w	L5211
4468  3ce2 10a4          	dc.w	L7211
4469  3ce4 10ab          	dc.w	L1311
4470  3ce6 10b2          	dc.w	L3311
4471  3ce8 10b9          	dc.w	L5311
4472  3cea 10c0          	dc.w	L7311
4473  3cec 10c7          	dc.w	L1411
4474  3cee 10ce          	dc.w	L3411
4475  3cf0 10d5          	dc.w	L5411
4476  3cf2 10dc          	dc.w	L7411
4477  3cf4 10e3          	dc.w	L1511
4478  3cf6 10ea          	dc.w	L3511
4479  3cf8 10f1          	dc.w	L5511
4480  3cfa 10f8          	dc.w	L7511
4481  3cfc 10ff          	dc.w	L1611
4482  3cfe 1106          	dc.w	L3611
4483  3d00 110d          	dc.w	L5611
4484  3d02 1114          	dc.w	L7611
4485  3d04 111b          	dc.w	L1711
4486  3d06 1122          	dc.w	L3711
4487  3d08 1129          	dc.w	L5711
4488  3d0a 1130          	dc.w	L7711
4489  3d0c 1137          	dc.w	L1021
4490  3d0e 113e          	dc.w	L3021
4491  3d10 1145          	dc.w	L5021
4492  3d12 114c          	dc.w	L7021
4493  3d14 1153          	dc.w	L1121
4494  3d16 115a          	dc.w	L3121
4495  3d18 1161          	dc.w	L5121
4496  3d1a 11f3          	dc.w	L5421
4497  3d1c 11f3          	dc.w	L5421
4498  3d1e 11f3          	dc.w	L5421
4499  3d20 11f3          	dc.w	L5421
4500  3d22 11f3          	dc.w	L5421
4501  3d24 11f3          	dc.w	L5421
4502  3d26 11f3          	dc.w	L5421
4503  3d28 11f3          	dc.w	L5421
4504  3d2a 11f3          	dc.w	L5421
4505  3d2c 11f3          	dc.w	L5421
4506  3d2e 11f3          	dc.w	L5421
4507  3d30 11f3          	dc.w	L5421
4508  3d32 11f3          	dc.w	L5421
4509  3d34 11f3          	dc.w	L5421
4510  3d36 11f3          	dc.w	L5421
4511  3d38 11f3          	dc.w	L5421
4512  3d3a 11f3          	dc.w	L5421
4513  3d3c 11f3          	dc.w	L5421
4514  3d3e 11f3          	dc.w	L5421
4515  3d40 11f3          	dc.w	L5421
4516  3d42 11f3          	dc.w	L5421
4517  3d44 11f3          	dc.w	L5421
4518  3d46 11f3          	dc.w	L5421
4519  3d48 1168          	dc.w	L7121
4520  3d4a 1173          	dc.w	L1221
4521  3d4c 11f3          	dc.w	L5421
4522  3d4e 11f3          	dc.w	L5421
4523  3d50 11f3          	dc.w	L5421
4524  3d52 117e          	dc.w	L3221
4525  3d54 1180          	dc.w	L5221
4526  3d56 11f3          	dc.w	L5421
4527  3d58 1192          	dc.w	L7221
4528  3d5a 11a4          	dc.w	L1321
4529  3d5c 11b6          	dc.w	L3321
4530  3d5e 11c1          	dc.w	L5321
4531  3d60 11c3          	dc.w	L7321
4532                     ; 1321 void HttpDCall(	uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
4532                     ; 1322 {
4533                     	switch	.text
4534  0b14               _HttpDCall:
4536  0b14 89            	pushw	x
4537  0b15 5207          	subw	sp,#7
4538       00000007      OFST:	set	7
4541                     ; 1332   alpha_1 = '0';
4543                     ; 1333   alpha_2 = '0';
4545                     ; 1334   alpha_3 = '0';
4547                     ; 1335   alpha_4 = '0';
4549                     ; 1336   alpha_5 = '0';
4551                     ; 1338   if (uip_connected()) {
4553  0b17 720d00007a    	btjf	_uip_flags,#6,L5431
4554                     ; 1340     if (current_webpage == WEBPAGE_DEFAULT) {
4556  0b1c c6000b        	ld	a,_current_webpage
4557  0b1f 260e          	jrne	L7431
4558                     ; 1341       pSocket->pData = g_HtmlPageDefault;
4560  0b21 1e0e          	ldw	x,(OFST+7,sp)
4561  0b23 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
4562  0b27 ef01          	ldw	(1,x),y
4563                     ; 1342       pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
4565  0b29 90ae1647      	ldw	y,#5703
4567  0b2d 2058          	jp	LC012
4568  0b2f               L7431:
4569                     ; 1346     else if (current_webpage == WEBPAGE_ADDRESS) {
4571  0b2f a101          	cp	a,#1
4572  0b31 260e          	jrne	L3531
4573                     ; 1347       pSocket->pData = g_HtmlPageAddress;
4575  0b33 1e0e          	ldw	x,(OFST+7,sp)
4576  0b35 90ae1650      	ldw	y,#L71_g_HtmlPageAddress
4577  0b39 ef01          	ldw	(1,x),y
4578                     ; 1348       pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
4580  0b3b 90ae1117      	ldw	y,#4375
4582  0b3f 2046          	jp	LC012
4583  0b41               L3531:
4584                     ; 1352     else if (current_webpage == WEBPAGE_HELP) {
4586  0b41 a103          	cp	a,#3
4587  0b43 260e          	jrne	L7531
4588                     ; 1353       pSocket->pData = g_HtmlPageHelp;
4590  0b45 1e0e          	ldw	x,(OFST+7,sp)
4591  0b47 90ae2768      	ldw	y,#L12_g_HtmlPageHelp
4592  0b4b ef01          	ldw	(1,x),y
4593                     ; 1354       pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
4595  0b4d 90ae076f      	ldw	y,#1903
4597  0b51 2034          	jp	LC012
4598  0b53               L7531:
4599                     ; 1356     else if (current_webpage == WEBPAGE_HELP2) {
4601  0b53 a104          	cp	a,#4
4602  0b55 260e          	jrne	L3631
4603                     ; 1357       pSocket->pData = g_HtmlPageHelp2;
4605  0b57 1e0e          	ldw	x,(OFST+7,sp)
4606  0b59 90ae2ed8      	ldw	y,#L32_g_HtmlPageHelp2
4607  0b5d ef01          	ldw	(1,x),y
4608                     ; 1358       pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
4610  0b5f 90ae02a8      	ldw	y,#680
4612  0b63 2022          	jp	LC012
4613  0b65               L3631:
4614                     ; 1363     else if (current_webpage == WEBPAGE_STATS) {
4616  0b65 a105          	cp	a,#5
4617  0b67 260e          	jrne	L7631
4618                     ; 1364       pSocket->pData = g_HtmlPageStats;
4620  0b69 1e0e          	ldw	x,(OFST+7,sp)
4621  0b6b 90ae3181      	ldw	y,#L52_g_HtmlPageStats
4622  0b6f ef01          	ldw	(1,x),y
4623                     ; 1365       pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
4625  0b71 90ae0a9b      	ldw	y,#2715
4627  0b75 2010          	jp	LC012
4628  0b77               L7631:
4629                     ; 1368     else if (current_webpage == WEBPAGE_RSTATE) {
4631  0b77 a106          	cp	a,#6
4632  0b79 260e          	jrne	L1531
4633                     ; 1369       pSocket->pData = g_HtmlPageRstate;
4635  0b7b 1e0e          	ldw	x,(OFST+7,sp)
4636  0b7d 90ae3c1d      	ldw	y,#L72_g_HtmlPageRstate
4637  0b81 ef01          	ldw	(1,x),y
4638                     ; 1370       pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
4640  0b83 90ae0078      	ldw	y,#120
4641  0b87               LC012:
4642  0b87 ef03          	ldw	(3,x),y
4643  0b89               L1531:
4644                     ; 1372     pSocket->nNewlines = 0;
4646  0b89 1e0e          	ldw	x,(OFST+7,sp)
4647                     ; 1373     pSocket->nState = STATE_CONNECTED;
4649  0b8b 7f            	clr	(x)
4650  0b8c 6f05          	clr	(5,x)
4651                     ; 1374     pSocket->nPrevBytes = 0xFFFF;
4653  0b8e 90aeffff      	ldw	y,#65535
4654  0b92 ef0a          	ldw	(10,x),y
4656  0b94 2041          	jra	L023
4657  0b96               L5431:
4658                     ; 1376   else if (uip_newdata() || uip_acked()) {
4660  0b96 7202000008    	btjt	_uip_flags,#1,L1041
4662  0b9b 7200000003cc  	btjf	_uip_flags,#0,L7731
4663  0ba3               L1041:
4664                     ; 1377     if (pSocket->nState == STATE_CONNECTED) {
4666  0ba3 1e0e          	ldw	x,(OFST+7,sp)
4667  0ba5 f6            	ld	a,(x)
4668  0ba6 2627          	jrne	L3041
4669                     ; 1378       if (nBytes == 0) return;
4671  0ba8 1e0c          	ldw	x,(OFST+5,sp)
4672  0baa 272b          	jreq	L023
4675                     ; 1379       if (*pBuffer == 'G') pSocket->nState = STATE_GET_G;
4677  0bac 1e08          	ldw	x,(OFST+1,sp)
4678  0bae f6            	ld	a,(x)
4679  0baf a147          	cp	a,#71
4680  0bb1 2606          	jrne	L7041
4683  0bb3 1e0e          	ldw	x,(OFST+7,sp)
4684  0bb5 a601          	ld	a,#1
4686  0bb7 2008          	jp	LC013
4687  0bb9               L7041:
4688                     ; 1380       else if (*pBuffer == 'P') pSocket->nState = STATE_POST_P;
4690  0bb9 a150          	cp	a,#80
4691  0bbb 2605          	jrne	L1141
4694  0bbd 1e0e          	ldw	x,(OFST+7,sp)
4695  0bbf a604          	ld	a,#4
4696  0bc1               LC013:
4697  0bc1 f7            	ld	(x),a
4698  0bc2               L1141:
4699                     ; 1381       nBytes--;
4701  0bc2 1e0c          	ldw	x,(OFST+5,sp)
4702  0bc4 5a            	decw	x
4703  0bc5 1f0c          	ldw	(OFST+5,sp),x
4704                     ; 1382       pBuffer++;
4706  0bc7 1e08          	ldw	x,(OFST+1,sp)
4707  0bc9 5c            	incw	x
4708  0bca 1f08          	ldw	(OFST+1,sp),x
4709  0bcc 1e0e          	ldw	x,(OFST+7,sp)
4710  0bce f6            	ld	a,(x)
4711  0bcf               L3041:
4712                     ; 1385     if (pSocket->nState == STATE_GET_G) {
4714  0bcf a101          	cp	a,#1
4715  0bd1 2620          	jrne	L5141
4716                     ; 1386       if (nBytes == 0) return;
4718  0bd3 1e0c          	ldw	x,(OFST+5,sp)
4719  0bd5 2603          	jrne	L7141
4721  0bd7               L023:
4724  0bd7 5b09          	addw	sp,#9
4725  0bd9 81            	ret	
4726  0bda               L7141:
4727                     ; 1387       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
4729  0bda 1e08          	ldw	x,(OFST+1,sp)
4730  0bdc f6            	ld	a,(x)
4731  0bdd a145          	cp	a,#69
4732  0bdf 2605          	jrne	L1241
4735  0be1 1e0e          	ldw	x,(OFST+7,sp)
4736  0be3 a602          	ld	a,#2
4737  0be5 f7            	ld	(x),a
4738  0be6               L1241:
4739                     ; 1388       nBytes--;
4741  0be6 1e0c          	ldw	x,(OFST+5,sp)
4742  0be8 5a            	decw	x
4743  0be9 1f0c          	ldw	(OFST+5,sp),x
4744                     ; 1389       pBuffer++;
4746  0beb 1e08          	ldw	x,(OFST+1,sp)
4747  0bed 5c            	incw	x
4748  0bee 1f08          	ldw	(OFST+1,sp),x
4749  0bf0 1e0e          	ldw	x,(OFST+7,sp)
4750  0bf2 f6            	ld	a,(x)
4751  0bf3               L5141:
4752                     ; 1392     if (pSocket->nState == STATE_GET_GE) {
4754  0bf3 a102          	cp	a,#2
4755  0bf5 261d          	jrne	L3241
4756                     ; 1393       if (nBytes == 0) return;
4758  0bf7 1e0c          	ldw	x,(OFST+5,sp)
4759  0bf9 27dc          	jreq	L023
4762                     ; 1394       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
4764  0bfb 1e08          	ldw	x,(OFST+1,sp)
4765  0bfd f6            	ld	a,(x)
4766  0bfe a154          	cp	a,#84
4767  0c00 2605          	jrne	L7241
4770  0c02 1e0e          	ldw	x,(OFST+7,sp)
4771  0c04 a603          	ld	a,#3
4772  0c06 f7            	ld	(x),a
4773  0c07               L7241:
4774                     ; 1395       nBytes--;
4776  0c07 1e0c          	ldw	x,(OFST+5,sp)
4777  0c09 5a            	decw	x
4778  0c0a 1f0c          	ldw	(OFST+5,sp),x
4779                     ; 1396       pBuffer++;
4781  0c0c 1e08          	ldw	x,(OFST+1,sp)
4782  0c0e 5c            	incw	x
4783  0c0f 1f08          	ldw	(OFST+1,sp),x
4784  0c11 1e0e          	ldw	x,(OFST+7,sp)
4785  0c13 f6            	ld	a,(x)
4786  0c14               L3241:
4787                     ; 1399     if (pSocket->nState == STATE_GET_GET) {
4789  0c14 a103          	cp	a,#3
4790  0c16 261d          	jrne	L1341
4791                     ; 1400       if (nBytes == 0) return;
4793  0c18 1e0c          	ldw	x,(OFST+5,sp)
4794  0c1a 27bb          	jreq	L023
4797                     ; 1401       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
4799  0c1c 1e08          	ldw	x,(OFST+1,sp)
4800  0c1e f6            	ld	a,(x)
4801  0c1f a120          	cp	a,#32
4802  0c21 2605          	jrne	L5341
4805  0c23 1e0e          	ldw	x,(OFST+7,sp)
4806  0c25 a608          	ld	a,#8
4807  0c27 f7            	ld	(x),a
4808  0c28               L5341:
4809                     ; 1402       nBytes--;
4811  0c28 1e0c          	ldw	x,(OFST+5,sp)
4812  0c2a 5a            	decw	x
4813  0c2b 1f0c          	ldw	(OFST+5,sp),x
4814                     ; 1403       pBuffer++;
4816  0c2d 1e08          	ldw	x,(OFST+1,sp)
4817  0c2f 5c            	incw	x
4818  0c30 1f08          	ldw	(OFST+1,sp),x
4819  0c32 1e0e          	ldw	x,(OFST+7,sp)
4820  0c34 f6            	ld	a,(x)
4821  0c35               L1341:
4822                     ; 1406     if (pSocket->nState == STATE_POST_P) {
4824  0c35 a104          	cp	a,#4
4825  0c37 261d          	jrne	L7341
4826                     ; 1407       if (nBytes == 0) return;
4828  0c39 1e0c          	ldw	x,(OFST+5,sp)
4829  0c3b 279a          	jreq	L023
4832                     ; 1408       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
4834  0c3d 1e08          	ldw	x,(OFST+1,sp)
4835  0c3f f6            	ld	a,(x)
4836  0c40 a14f          	cp	a,#79
4837  0c42 2605          	jrne	L3441
4840  0c44 1e0e          	ldw	x,(OFST+7,sp)
4841  0c46 a605          	ld	a,#5
4842  0c48 f7            	ld	(x),a
4843  0c49               L3441:
4844                     ; 1409       nBytes--;
4846  0c49 1e0c          	ldw	x,(OFST+5,sp)
4847  0c4b 5a            	decw	x
4848  0c4c 1f0c          	ldw	(OFST+5,sp),x
4849                     ; 1410       pBuffer++;
4851  0c4e 1e08          	ldw	x,(OFST+1,sp)
4852  0c50 5c            	incw	x
4853  0c51 1f08          	ldw	(OFST+1,sp),x
4854  0c53 1e0e          	ldw	x,(OFST+7,sp)
4855  0c55 f6            	ld	a,(x)
4856  0c56               L7341:
4857                     ; 1413     if (pSocket->nState == STATE_POST_PO) {
4859  0c56 a105          	cp	a,#5
4860  0c58 2620          	jrne	L5441
4861                     ; 1414       if (nBytes == 0) return;
4863  0c5a 1e0c          	ldw	x,(OFST+5,sp)
4864  0c5c 2603cc0bd7    	jreq	L023
4867                     ; 1415       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
4869  0c61 1e08          	ldw	x,(OFST+1,sp)
4870  0c63 f6            	ld	a,(x)
4871  0c64 a153          	cp	a,#83
4872  0c66 2605          	jrne	L1541
4875  0c68 1e0e          	ldw	x,(OFST+7,sp)
4876  0c6a a606          	ld	a,#6
4877  0c6c f7            	ld	(x),a
4878  0c6d               L1541:
4879                     ; 1416       nBytes--;
4881  0c6d 1e0c          	ldw	x,(OFST+5,sp)
4882  0c6f 5a            	decw	x
4883  0c70 1f0c          	ldw	(OFST+5,sp),x
4884                     ; 1417       pBuffer++;
4886  0c72 1e08          	ldw	x,(OFST+1,sp)
4887  0c74 5c            	incw	x
4888  0c75 1f08          	ldw	(OFST+1,sp),x
4889  0c77 1e0e          	ldw	x,(OFST+7,sp)
4890  0c79 f6            	ld	a,(x)
4891  0c7a               L5441:
4892                     ; 1420     if (pSocket->nState == STATE_POST_POS) {
4894  0c7a a106          	cp	a,#6
4895  0c7c 261d          	jrne	L3541
4896                     ; 1421       if (nBytes == 0) return;
4898  0c7e 1e0c          	ldw	x,(OFST+5,sp)
4899  0c80 27dc          	jreq	L023
4902                     ; 1422       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
4904  0c82 1e08          	ldw	x,(OFST+1,sp)
4905  0c84 f6            	ld	a,(x)
4906  0c85 a154          	cp	a,#84
4907  0c87 2605          	jrne	L7541
4910  0c89 1e0e          	ldw	x,(OFST+7,sp)
4911  0c8b a607          	ld	a,#7
4912  0c8d f7            	ld	(x),a
4913  0c8e               L7541:
4914                     ; 1423       nBytes--;
4916  0c8e 1e0c          	ldw	x,(OFST+5,sp)
4917  0c90 5a            	decw	x
4918  0c91 1f0c          	ldw	(OFST+5,sp),x
4919                     ; 1424       pBuffer++;
4921  0c93 1e08          	ldw	x,(OFST+1,sp)
4922  0c95 5c            	incw	x
4923  0c96 1f08          	ldw	(OFST+1,sp),x
4924  0c98 1e0e          	ldw	x,(OFST+7,sp)
4925  0c9a f6            	ld	a,(x)
4926  0c9b               L3541:
4927                     ; 1427     if (pSocket->nState == STATE_POST_POST) {
4929  0c9b a107          	cp	a,#7
4930  0c9d 261d          	jrne	L1641
4931                     ; 1428       if (nBytes == 0) return;
4933  0c9f 1e0c          	ldw	x,(OFST+5,sp)
4934  0ca1 27bb          	jreq	L023
4937                     ; 1429       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
4939  0ca3 1e08          	ldw	x,(OFST+1,sp)
4940  0ca5 f6            	ld	a,(x)
4941  0ca6 a120          	cp	a,#32
4942  0ca8 2605          	jrne	L5641
4945  0caa 1e0e          	ldw	x,(OFST+7,sp)
4946  0cac a609          	ld	a,#9
4947  0cae f7            	ld	(x),a
4948  0caf               L5641:
4949                     ; 1430       nBytes--;
4951  0caf 1e0c          	ldw	x,(OFST+5,sp)
4952  0cb1 5a            	decw	x
4953  0cb2 1f0c          	ldw	(OFST+5,sp),x
4954                     ; 1431       pBuffer++;
4956  0cb4 1e08          	ldw	x,(OFST+1,sp)
4957  0cb6 5c            	incw	x
4958  0cb7 1f08          	ldw	(OFST+1,sp),x
4959  0cb9 1e0e          	ldw	x,(OFST+7,sp)
4960  0cbb f6            	ld	a,(x)
4961  0cbc               L1641:
4962                     ; 1434     if (pSocket->nState == STATE_GOTPOST) {
4964  0cbc a109          	cp	a,#9
4965  0cbe 2647          	jrne	L7641
4967  0cc0 2041          	jra	L3741
4968  0cc2               L1741:
4969                     ; 1437         if (*pBuffer == '\n') pSocket->nNewlines++;
4971  0cc2 1e08          	ldw	x,(OFST+1,sp)
4972  0cc4 f6            	ld	a,(x)
4973  0cc5 a10a          	cp	a,#10
4974  0cc7 2606          	jrne	L7741
4977  0cc9 1e0e          	ldw	x,(OFST+7,sp)
4978  0ccb 6c05          	inc	(5,x)
4980  0ccd 2008          	jra	L1051
4981  0ccf               L7741:
4982                     ; 1438         else if (*pBuffer == '\r') { }
4984  0ccf a10d          	cp	a,#13
4985  0cd1 2704          	jreq	L1051
4987                     ; 1439         else pSocket->nNewlines = 0;
4989  0cd3 1e0e          	ldw	x,(OFST+7,sp)
4990  0cd5 6f05          	clr	(5,x)
4991  0cd7               L1051:
4992                     ; 1440         pBuffer++;
4994  0cd7 1e08          	ldw	x,(OFST+1,sp)
4995  0cd9 5c            	incw	x
4996  0cda 1f08          	ldw	(OFST+1,sp),x
4997                     ; 1441         nBytes--;
4999  0cdc 1e0c          	ldw	x,(OFST+5,sp)
5000  0cde 5a            	decw	x
5001  0cdf 1f0c          	ldw	(OFST+5,sp),x
5002                     ; 1442         if (pSocket->nNewlines == 2) {
5004  0ce1 1e0e          	ldw	x,(OFST+7,sp)
5005  0ce3 e605          	ld	a,(5,x)
5006  0ce5 a102          	cp	a,#2
5007  0ce7 261a          	jrne	L3741
5008                     ; 1445           if (current_webpage == WEBPAGE_DEFAULT) pSocket->nParseLeft = PARSEBYTES_DEFAULT;
5010  0ce9 c6000b        	ld	a,_current_webpage
5011  0cec 2607          	jrne	L1151
5014  0cee a67e          	ld	a,#126
5015  0cf0 e706          	ld	(6,x),a
5016  0cf2 c6000b        	ld	a,_current_webpage
5017  0cf5               L1151:
5018                     ; 1446           if (current_webpage == WEBPAGE_ADDRESS) pSocket->nParseLeft = PARSEBYTES_ADDRESS;
5020  0cf5 4a            	dec	a
5021  0cf6 2604          	jrne	L3151
5024  0cf8 a693          	ld	a,#147
5025  0cfa e706          	ld	(6,x),a
5026  0cfc               L3151:
5027                     ; 1447           pSocket->ParseState = PARSE_CMD;
5029  0cfc 6f09          	clr	(9,x)
5030                     ; 1449           pSocket->nState = STATE_PARSEPOST;
5032  0cfe a60a          	ld	a,#10
5033  0d00 f7            	ld	(x),a
5034                     ; 1450           break;
5036  0d01 2004          	jra	L7641
5037  0d03               L3741:
5038                     ; 1436       while (nBytes != 0) {
5040  0d03 1e0c          	ldw	x,(OFST+5,sp)
5041  0d05 26bb          	jrne	L1741
5042  0d07               L7641:
5043                     ; 1455     if (pSocket->nState == STATE_GOTGET) {
5045  0d07 1e0e          	ldw	x,(OFST+7,sp)
5046  0d09 f6            	ld	a,(x)
5047  0d0a a108          	cp	a,#8
5048  0d0c 2609          	jrne	L5151
5049                     ; 1459       pSocket->nParseLeft = 6;
5051  0d0e a606          	ld	a,#6
5052  0d10 e706          	ld	(6,x),a
5053                     ; 1460       pSocket->ParseState = PARSE_SLASH1;
5055  0d12 e709          	ld	(9,x),a
5056                     ; 1462       pSocket->nState = STATE_PARSEGET;
5058  0d14 a60d          	ld	a,#13
5059  0d16 f7            	ld	(x),a
5060  0d17               L5151:
5061                     ; 1465     if (pSocket->nState == STATE_PARSEPOST) {
5063  0d17 a10a          	cp	a,#10
5064  0d19 2703cc0f89    	jrne	L7151
5066  0d1e cc0f7a        	jra	L3251
5067  0d21               L1251:
5068                     ; 1475         if (pSocket->ParseState == PARSE_CMD) {
5070  0d21 1e0e          	ldw	x,(OFST+7,sp)
5071  0d23 e609          	ld	a,(9,x)
5072  0d25 263e          	jrne	L7251
5073                     ; 1476           pSocket->ParseCmd = *pBuffer;
5075  0d27 1e08          	ldw	x,(OFST+1,sp)
5076  0d29 f6            	ld	a,(x)
5077  0d2a 1e0e          	ldw	x,(OFST+7,sp)
5078  0d2c e707          	ld	(7,x),a
5079                     ; 1477           pSocket->ParseState = PARSE_NUM10;
5081  0d2e a601          	ld	a,#1
5082  0d30 e709          	ld	(9,x),a
5083                     ; 1478 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5085  0d32 e606          	ld	a,(6,x)
5086  0d34 2704          	jreq	L1351
5089  0d36 6a06          	dec	(6,x)
5091  0d38 2004          	jra	L3351
5092  0d3a               L1351:
5093                     ; 1479 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5095  0d3a a605          	ld	a,#5
5096  0d3c e709          	ld	(9,x),a
5097  0d3e               L3351:
5098                     ; 1480           pBuffer++;
5100  0d3e 1e08          	ldw	x,(OFST+1,sp)
5101  0d40 5c            	incw	x
5102  0d41 1f08          	ldw	(OFST+1,sp),x
5103                     ; 1482 	  if (pSocket->ParseCmd == 'o' ||
5103                     ; 1483 	      pSocket->ParseCmd == 'a' ||
5103                     ; 1484 	      pSocket->ParseCmd == 'b' ||
5103                     ; 1485 	      pSocket->ParseCmd == 'c' ||
5103                     ; 1486 	      pSocket->ParseCmd == 'd' ||
5103                     ; 1487 	      pSocket->ParseCmd == 'g') { }
5105  0d43 1e0e          	ldw	x,(OFST+7,sp)
5106  0d45 e607          	ld	a,(7,x)
5107  0d47 a16f          	cp	a,#111
5108  0d49 2603cc0f6c    	jreq	L3551
5110  0d4e a161          	cp	a,#97
5111  0d50 27f9          	jreq	L3551
5113  0d52 a162          	cp	a,#98
5114  0d54 27f5          	jreq	L3551
5116  0d56 a163          	cp	a,#99
5117  0d58 27f1          	jreq	L3551
5119  0d5a a164          	cp	a,#100
5120  0d5c 27ed          	jreq	L3551
5122  0d5e a167          	cp	a,#103
5123  0d60 27e9          	jreq	L3551
5124                     ; 1488 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5125  0d62 cc0f51        	jp	LC018
5126  0d65               L7251:
5127                     ; 1490         else if (pSocket->ParseState == PARSE_NUM10) {
5129  0d65 a101          	cp	a,#1
5130  0d67 2619          	jrne	L5551
5131                     ; 1491           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5133  0d69 1e08          	ldw	x,(OFST+1,sp)
5134  0d6b f6            	ld	a,(x)
5135  0d6c 97            	ld	xl,a
5136  0d6d a60a          	ld	a,#10
5137  0d6f 42            	mul	x,a
5138  0d70 9f            	ld	a,xl
5139  0d71 1e0e          	ldw	x,(OFST+7,sp)
5140  0d73 a0e0          	sub	a,#224
5141  0d75 e708          	ld	(8,x),a
5142                     ; 1492           pSocket->ParseState = PARSE_NUM1;
5144  0d77 a602          	ld	a,#2
5145  0d79 e709          	ld	(9,x),a
5146                     ; 1493 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5148  0d7b e606          	ld	a,(6,x)
5149  0d7d 2719          	jreq	L7651
5152  0d7f cc0f61        	jp	LC026
5153                     ; 1494 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5154                     ; 1495           pBuffer++;
5156  0d82               L5551:
5157                     ; 1497         else if (pSocket->ParseState == PARSE_NUM1) {
5159  0d82 a102          	cp	a,#2
5160  0d84 2616          	jrne	L5651
5161                     ; 1498           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5163  0d86 1608          	ldw	y,(OFST+1,sp)
5164  0d88 90f6          	ld	a,(y)
5165  0d8a a030          	sub	a,#48
5166  0d8c eb08          	add	a,(8,x)
5167  0d8e e708          	ld	(8,x),a
5168                     ; 1499           pSocket->ParseState = PARSE_EQUAL;
5170  0d90 a603          	ld	a,#3
5171  0d92 e709          	ld	(9,x),a
5172                     ; 1500 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5174  0d94 e606          	ld	a,(6,x)
5177  0d96 26e7          	jrne	LC026
5178  0d98               L7651:
5179                     ; 1501 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5182  0d98 a605          	ld	a,#5
5183                     ; 1502           pBuffer++;
5185  0d9a 200d          	jp	LC027
5186  0d9c               L5651:
5187                     ; 1504         else if (pSocket->ParseState == PARSE_EQUAL) {
5189  0d9c a103          	cp	a,#3
5190  0d9e 260e          	jrne	L5751
5191                     ; 1505           pSocket->ParseState = PARSE_VAL;
5193  0da0 a604          	ld	a,#4
5194  0da2 e709          	ld	(9,x),a
5195                     ; 1506 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5197  0da4 6d06          	tnz	(6,x)
5200  0da6 26d7          	jrne	LC026
5201                     ; 1507 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5203  0da8 4c            	inc	a
5204  0da9               LC027:
5205  0da9 e709          	ld	(9,x),a
5206                     ; 1508           pBuffer++;
5208  0dab cc0f63        	jp	LC017
5209  0dae               L5751:
5210                     ; 1510         else if (pSocket->ParseState == PARSE_VAL) {
5212  0dae a104          	cp	a,#4
5213  0db0 2703cc0f57    	jrne	L5061
5214                     ; 1518           if (pSocket->ParseCmd == 'o') {
5216  0db5 e607          	ld	a,(7,x)
5217  0db7 a16f          	cp	a,#111
5218  0db9 2625          	jrne	L7061
5219                     ; 1521             if ((uint8_t)(*pBuffer) == '1') GpioSetPin(pSocket->ParseNum, (uint8_t)1);
5221  0dbb 1e08          	ldw	x,(OFST+1,sp)
5222  0dbd f6            	ld	a,(x)
5223  0dbe a131          	cp	a,#49
5224  0dc0 2609          	jrne	L1161
5227  0dc2 1e0e          	ldw	x,(OFST+7,sp)
5228  0dc4 e608          	ld	a,(8,x)
5229  0dc6 ae0001        	ldw	x,#1
5232  0dc9 2005          	jra	L3161
5233  0dcb               L1161:
5234                     ; 1522             else GpioSetPin(pSocket->ParseNum, (uint8_t)0);
5236  0dcb 1e0e          	ldw	x,(OFST+7,sp)
5237  0dcd e608          	ld	a,(8,x)
5238  0dcf 5f            	clrw	x
5240  0dd0               L3161:
5241  0dd0 95            	ld	xh,a
5242  0dd1 cd13f5        	call	_GpioSetPin
5243                     ; 1523 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5245  0dd4 1e0e          	ldw	x,(OFST+7,sp)
5246  0dd6 e606          	ld	a,(6,x)
5247  0dd8 2603cc0f4a    	jreq	L5661
5249                     ; 1524             pBuffer++;
5251  0ddd cc0f48        	jp	LC025
5252  0de0               L7061:
5253                     ; 1527           else if (pSocket->ParseCmd == 'a') {
5255  0de0 a161          	cp	a,#97
5256  0de2 2656          	jrne	L1261
5257                     ; 1537             ex_stored_devicename[0] = (uint8_t)(*pBuffer);
5259  0de4 1e08          	ldw	x,(OFST+1,sp)
5260  0de6 f6            	ld	a,(x)
5261  0de7 c70000        	ld	_ex_stored_devicename,a
5262                     ; 1538             pSocket->nParseLeft--;
5264  0dea 1e0e          	ldw	x,(OFST+7,sp)
5265  0dec 6a06          	dec	(6,x)
5266                     ; 1539             pBuffer++; // nBytes already decremented for first char
5268  0dee 1e08          	ldw	x,(OFST+1,sp)
5269  0df0 5c            	incw	x
5270  0df1 1f08          	ldw	(OFST+1,sp),x
5271                     ; 1543 	    amp_found = 0;
5273  0df3 0f06          	clr	(OFST-1,sp)
5275                     ; 1544 	    for(i=1; i<20; i++) {
5277  0df5 a601          	ld	a,#1
5278  0df7 6b07          	ld	(OFST+0,sp),a
5280  0df9               L3261:
5281                     ; 1545 	      if ((uint8_t)(*pBuffer) == 38) amp_found = 1;
5283  0df9 1e08          	ldw	x,(OFST+1,sp)
5284  0dfb f6            	ld	a,(x)
5285  0dfc a126          	cp	a,#38
5286  0dfe 2604          	jrne	L1361
5289  0e00 a601          	ld	a,#1
5290  0e02 6b06          	ld	(OFST-1,sp),a
5292  0e04               L1361:
5293                     ; 1546 	      if (amp_found == 0) {
5295  0e04 7b06          	ld	a,(OFST-1,sp)
5296  0e06 261a          	jrne	L3361
5297                     ; 1548                 ex_stored_devicename[i] = (uint8_t)(*pBuffer);
5299  0e08 7b07          	ld	a,(OFST+0,sp)
5300  0e0a 5f            	clrw	x
5301  0e0b 1608          	ldw	y,(OFST+1,sp)
5302  0e0d 97            	ld	xl,a
5303  0e0e 90f6          	ld	a,(y)
5304  0e10 d70000        	ld	(_ex_stored_devicename,x),a
5305                     ; 1549                 pSocket->nParseLeft--;
5307  0e13 1e0e          	ldw	x,(OFST+7,sp)
5308  0e15 6a06          	dec	(6,x)
5309                     ; 1550                 pBuffer++;
5311  0e17 93            	ldw	x,y
5312  0e18 5c            	incw	x
5313  0e19 1f08          	ldw	(OFST+1,sp),x
5314                     ; 1551                 nBytes--; // Must subtract 1 from nBytes for extra byte read
5316  0e1b 1e0c          	ldw	x,(OFST+5,sp)
5317  0e1d 5a            	decw	x
5318  0e1e 1f0c          	ldw	(OFST+5,sp),x
5320  0e20 200d          	jra	L5361
5321  0e22               L3361:
5322                     ; 1555 	        ex_stored_devicename[i] = ' ';
5324  0e22 7b07          	ld	a,(OFST+0,sp)
5325  0e24 5f            	clrw	x
5326  0e25 97            	ld	xl,a
5327  0e26 a620          	ld	a,#32
5328  0e28 d70000        	ld	(_ex_stored_devicename,x),a
5329                     ; 1564                 pSocket->nParseLeft--;
5331  0e2b 1e0e          	ldw	x,(OFST+7,sp)
5332  0e2d 6a06          	dec	(6,x)
5333  0e2f               L5361:
5334                     ; 1544 	    for(i=1; i<20; i++) {
5336  0e2f 0c07          	inc	(OFST+0,sp)
5340  0e31 7b07          	ld	a,(OFST+0,sp)
5341  0e33 a114          	cp	a,#20
5342  0e35 25c2          	jrult	L3261
5344  0e37 cc0f4f        	jra	L7161
5345  0e3a               L1261:
5346                     ; 1569           else if (pSocket->ParseCmd == 'b') {
5348  0e3a a162          	cp	a,#98
5349  0e3c 2646          	jrne	L1461
5350                     ; 1576 	    alpha_1 = '-';
5352                     ; 1577 	    alpha_2 = '-';
5354                     ; 1578 	    alpha_3 = '-';
5356                     ; 1580             alpha_1 = (uint8_t)(*pBuffer);
5358  0e3e 1e08          	ldw	x,(OFST+1,sp)
5359  0e40 f6            	ld	a,(x)
5360  0e41 6b07          	ld	(OFST+0,sp),a
5362                     ; 1581             pSocket->nParseLeft--;
5364  0e43 1e0e          	ldw	x,(OFST+7,sp)
5365  0e45 6a06          	dec	(6,x)
5366                     ; 1582             pBuffer++; // nBytes already decremented for first char
5368  0e47 1e08          	ldw	x,(OFST+1,sp)
5369  0e49 5c            	incw	x
5370  0e4a 1f08          	ldw	(OFST+1,sp),x
5371                     ; 1584 	    alpha_2 = (uint8_t)(*pBuffer);
5373  0e4c f6            	ld	a,(x)
5374  0e4d 6b05          	ld	(OFST-2,sp),a
5376                     ; 1585             pSocket->nParseLeft--;
5378  0e4f 1e0e          	ldw	x,(OFST+7,sp)
5379  0e51 6a06          	dec	(6,x)
5380                     ; 1586             pBuffer++;
5382  0e53 1e08          	ldw	x,(OFST+1,sp)
5383  0e55 5c            	incw	x
5384  0e56 1f08          	ldw	(OFST+1,sp),x
5385                     ; 1587 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5387  0e58 1e0c          	ldw	x,(OFST+5,sp)
5388  0e5a 5a            	decw	x
5389  0e5b 1f0c          	ldw	(OFST+5,sp),x
5390                     ; 1589 	    alpha_3 = (uint8_t)(*pBuffer);
5392  0e5d 1e08          	ldw	x,(OFST+1,sp)
5393  0e5f f6            	ld	a,(x)
5394  0e60 6b06          	ld	(OFST-1,sp),a
5396                     ; 1590             pSocket->nParseLeft--;
5398  0e62 1e0e          	ldw	x,(OFST+7,sp)
5399  0e64 6a06          	dec	(6,x)
5400                     ; 1591             pBuffer++;
5402  0e66 1e08          	ldw	x,(OFST+1,sp)
5403  0e68 5c            	incw	x
5404  0e69 1f08          	ldw	(OFST+1,sp),x
5405                     ; 1592 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5407  0e6b 1e0c          	ldw	x,(OFST+5,sp)
5408  0e6d 5a            	decw	x
5409  0e6e 1f0c          	ldw	(OFST+5,sp),x
5410                     ; 1594 	    SetAddresses(pSocket->ParseNum, (uint8_t)alpha_1, (uint8_t)alpha_2, (uint8_t)alpha_3);
5412  0e70 88            	push	a
5413  0e71 7b06          	ld	a,(OFST-1,sp)
5414  0e73 88            	push	a
5415  0e74 7b09          	ld	a,(OFST+2,sp)
5416  0e76 1610          	ldw	y,(OFST+9,sp)
5417  0e78 97            	ld	xl,a
5418  0e79 90e608        	ld	a,(8,y)
5419  0e7c 95            	ld	xh,a
5420  0e7d cd1521        	call	_SetAddresses
5422  0e80 85            	popw	x
5424  0e81 cc0f4f        	jra	L7161
5425  0e84               L1461:
5426                     ; 1597           else if (pSocket->ParseCmd == 'c') {
5428  0e84 a163          	cp	a,#99
5429  0e86 2672          	jrne	L5461
5430                     ; 1603 	    alpha_1 = '-';
5432                     ; 1604 	    alpha_2 = '-';
5434                     ; 1605 	    alpha_3 = '-';
5436                     ; 1606 	    alpha_4 = '-';
5438                     ; 1607 	    alpha_5 = '-';
5440                     ; 1610   	    alpha_1 = (uint8_t)(*pBuffer);
5442  0e88 1e08          	ldw	x,(OFST+1,sp)
5443  0e8a f6            	ld	a,(x)
5444  0e8b 6b07          	ld	(OFST+0,sp),a
5446                     ; 1611             pSocket->nParseLeft--;
5448  0e8d 1e0e          	ldw	x,(OFST+7,sp)
5449  0e8f 6a06          	dec	(6,x)
5450                     ; 1612             pBuffer++; // nBytes already decremented for first char
5452  0e91 1e08          	ldw	x,(OFST+1,sp)
5453  0e93 5c            	incw	x
5454  0e94 1f08          	ldw	(OFST+1,sp),x
5455                     ; 1614 	    alpha_2 = (uint8_t)(*pBuffer);
5457  0e96 f6            	ld	a,(x)
5458  0e97 6b05          	ld	(OFST-2,sp),a
5460                     ; 1615             pSocket->nParseLeft--;
5462  0e99 1e0e          	ldw	x,(OFST+7,sp)
5463  0e9b 6a06          	dec	(6,x)
5464                     ; 1616             pBuffer++;
5466  0e9d 1e08          	ldw	x,(OFST+1,sp)
5467  0e9f 5c            	incw	x
5468  0ea0 1f08          	ldw	(OFST+1,sp),x
5469                     ; 1617 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5471  0ea2 1e0c          	ldw	x,(OFST+5,sp)
5472  0ea4 5a            	decw	x
5473  0ea5 1f0c          	ldw	(OFST+5,sp),x
5474                     ; 1619 	    alpha_3 = (uint8_t)(*pBuffer);
5476  0ea7 1e08          	ldw	x,(OFST+1,sp)
5477  0ea9 f6            	ld	a,(x)
5478  0eaa 6b06          	ld	(OFST-1,sp),a
5480                     ; 1620             pSocket->nParseLeft--;
5482  0eac 1e0e          	ldw	x,(OFST+7,sp)
5483  0eae 6a06          	dec	(6,x)
5484                     ; 1621             pBuffer++;
5486  0eb0 1e08          	ldw	x,(OFST+1,sp)
5487  0eb2 5c            	incw	x
5488  0eb3 1f08          	ldw	(OFST+1,sp),x
5489                     ; 1622 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5491  0eb5 1e0c          	ldw	x,(OFST+5,sp)
5492  0eb7 5a            	decw	x
5493  0eb8 1f0c          	ldw	(OFST+5,sp),x
5494                     ; 1624 	    alpha_4 = (uint8_t)(*pBuffer);
5496  0eba 1e08          	ldw	x,(OFST+1,sp)
5497  0ebc f6            	ld	a,(x)
5498  0ebd 6b03          	ld	(OFST-4,sp),a
5500                     ; 1625             pSocket->nParseLeft--;
5502  0ebf 1e0e          	ldw	x,(OFST+7,sp)
5503  0ec1 6a06          	dec	(6,x)
5504                     ; 1626             pBuffer++;
5506  0ec3 1e08          	ldw	x,(OFST+1,sp)
5507  0ec5 5c            	incw	x
5508  0ec6 1f08          	ldw	(OFST+1,sp),x
5509                     ; 1627 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5511  0ec8 1e0c          	ldw	x,(OFST+5,sp)
5512  0eca 5a            	decw	x
5513  0ecb 1f0c          	ldw	(OFST+5,sp),x
5514                     ; 1629             alpha_5 = (uint8_t)(*pBuffer);
5516  0ecd 1e08          	ldw	x,(OFST+1,sp)
5517  0ecf f6            	ld	a,(x)
5518  0ed0 6b04          	ld	(OFST-3,sp),a
5520                     ; 1630             pSocket->nParseLeft--;
5522  0ed2 1e0e          	ldw	x,(OFST+7,sp)
5523  0ed4 6a06          	dec	(6,x)
5524                     ; 1631             pBuffer++;
5526  0ed6 1e08          	ldw	x,(OFST+1,sp)
5527  0ed8 5c            	incw	x
5528  0ed9 1f08          	ldw	(OFST+1,sp),x
5529                     ; 1632 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5531  0edb 1e0c          	ldw	x,(OFST+5,sp)
5532  0edd 5a            	decw	x
5533  0ede 1f0c          	ldw	(OFST+5,sp),x
5534                     ; 1634 	    SetPort(pSocket->ParseNum,
5534                     ; 1635 	            (uint8_t)alpha_1,
5534                     ; 1636 		    (uint8_t)alpha_2,
5534                     ; 1637 		    (uint8_t)alpha_3,
5534                     ; 1638 		    (uint8_t)alpha_4,
5534                     ; 1639 		    (uint8_t)alpha_5);
5536  0ee0 88            	push	a
5537  0ee1 7b04          	ld	a,(OFST-3,sp)
5538  0ee3 88            	push	a
5539  0ee4 7b08          	ld	a,(OFST+1,sp)
5540  0ee6 88            	push	a
5541  0ee7 7b08          	ld	a,(OFST+1,sp)
5542  0ee9 88            	push	a
5543  0eea 7b0b          	ld	a,(OFST+4,sp)
5544  0eec 1612          	ldw	y,(OFST+11,sp)
5545  0eee 97            	ld	xl,a
5546  0eef 90e608        	ld	a,(8,y)
5547  0ef2 95            	ld	xh,a
5548  0ef3 cd15ab        	call	_SetPort
5550  0ef6 5b04          	addw	sp,#4
5552  0ef8 2055          	jra	L7161
5553  0efa               L5461:
5554                     ; 1642           else if (pSocket->ParseCmd == 'd') {
5556  0efa a164          	cp	a,#100
5557  0efc 262f          	jrne	L1561
5558                     ; 1648 	    alpha_1 = (uint8_t)(*pBuffer);
5560  0efe 1e08          	ldw	x,(OFST+1,sp)
5561  0f00 f6            	ld	a,(x)
5562  0f01 6b07          	ld	(OFST+0,sp),a
5564                     ; 1649             pSocket->nParseLeft--;
5566  0f03 1e0e          	ldw	x,(OFST+7,sp)
5567  0f05 6a06          	dec	(6,x)
5568                     ; 1650             pBuffer++; // nBytes already decremented for first char
5570  0f07 1e08          	ldw	x,(OFST+1,sp)
5571  0f09 5c            	incw	x
5572  0f0a 1f08          	ldw	(OFST+1,sp),x
5573                     ; 1652 	    alpha_2 = (uint8_t)(*pBuffer);
5575  0f0c f6            	ld	a,(x)
5576  0f0d 6b05          	ld	(OFST-2,sp),a
5578                     ; 1653             pSocket->nParseLeft--;
5580  0f0f 1e0e          	ldw	x,(OFST+7,sp)
5581  0f11 6a06          	dec	(6,x)
5582                     ; 1654             pBuffer++;
5584  0f13 1e08          	ldw	x,(OFST+1,sp)
5585  0f15 5c            	incw	x
5586  0f16 1f08          	ldw	(OFST+1,sp),x
5587                     ; 1655 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5589  0f18 1e0c          	ldw	x,(OFST+5,sp)
5590  0f1a 5a            	decw	x
5591  0f1b 1f0c          	ldw	(OFST+5,sp),x
5592                     ; 1657 	    SetMAC(pSocket->ParseNum, alpha_1, alpha_2);
5594  0f1d 88            	push	a
5595  0f1e 7b08          	ld	a,(OFST+1,sp)
5596  0f20 160f          	ldw	y,(OFST+8,sp)
5597  0f22 97            	ld	xl,a
5598  0f23 90e608        	ld	a,(8,y)
5599  0f26 95            	ld	xh,a
5600  0f27 cd15ef        	call	_SetMAC
5602  0f2a 84            	pop	a
5604  0f2b 2022          	jra	L7161
5605  0f2d               L1561:
5606                     ; 1660 	  else if (pSocket->ParseCmd == 'g') {
5608  0f2d a167          	cp	a,#103
5609  0f2f 261e          	jrne	L7161
5610                     ; 1663             if ((uint8_t)(*pBuffer) == '1') invert_output = 1;
5612  0f31 1e08          	ldw	x,(OFST+1,sp)
5613  0f33 f6            	ld	a,(x)
5614  0f34 a131          	cp	a,#49
5615  0f36 2606          	jrne	L7561
5618  0f38 35010000      	mov	_invert_output,#1
5620  0f3c 2004          	jra	L1661
5621  0f3e               L7561:
5622                     ; 1664             else invert_output = 0;
5624  0f3e 725f0000      	clr	_invert_output
5625  0f42               L1661:
5626                     ; 1665 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--;
5628  0f42 1e0e          	ldw	x,(OFST+7,sp)
5629  0f44 e606          	ld	a,(6,x)
5630  0f46 2702          	jreq	L5661
5633  0f48               LC025:
5635  0f48 6a06          	dec	(6,x)
5637  0f4a               L5661:
5638                     ; 1667             pBuffer++;
5641  0f4a 1e08          	ldw	x,(OFST+1,sp)
5642  0f4c 5c            	incw	x
5643  0f4d 1f08          	ldw	(OFST+1,sp),x
5644  0f4f               L7161:
5645                     ; 1670           pSocket->ParseState = PARSE_DELIM;
5647  0f4f 1e0e          	ldw	x,(OFST+7,sp)
5648  0f51               LC018:
5650  0f51 a605          	ld	a,#5
5651  0f53 e709          	ld	(9,x),a
5653  0f55 2015          	jra	L3551
5654  0f57               L5061:
5655                     ; 1673         else if (pSocket->ParseState == PARSE_DELIM) {
5657  0f57 a105          	cp	a,#5
5658  0f59 2611          	jrne	L3551
5659                     ; 1674           if (pSocket->nParseLeft > 0) {
5661  0f5b e606          	ld	a,(6,x)
5662  0f5d 270b          	jreq	L3761
5663                     ; 1675             pSocket->ParseState = PARSE_CMD;
5665  0f5f 6f09          	clr	(9,x)
5666                     ; 1676             pSocket->nParseLeft--;
5668  0f61               LC026:
5672  0f61 6a06          	dec	(6,x)
5673                     ; 1677             pBuffer++;
5675  0f63               LC017:
5679  0f63 1e08          	ldw	x,(OFST+1,sp)
5680  0f65 5c            	incw	x
5681  0f66 1f08          	ldw	(OFST+1,sp),x
5683  0f68 2002          	jra	L3551
5684  0f6a               L3761:
5685                     ; 1680             pSocket->nParseLeft = 0; // Something out of sync - end the parsing
5687  0f6a e706          	ld	(6,x),a
5688  0f6c               L3551:
5689                     ; 1684         if (pSocket->nParseLeft == 0) {
5691  0f6c 1e0e          	ldw	x,(OFST+7,sp)
5692  0f6e e606          	ld	a,(6,x)
5693  0f70 2608          	jrne	L3251
5694                     ; 1686           pSocket->nState = STATE_SENDHEADER;
5696  0f72 a60b          	ld	a,#11
5697  0f74 f7            	ld	(x),a
5698                     ; 1687           break;
5699  0f75               L5251:
5700                     ; 1691       pSocket->nState = STATE_SENDHEADER;
5702  0f75 1e0e          	ldw	x,(OFST+7,sp)
5703  0f77 f7            	ld	(x),a
5704  0f78 200f          	jra	L7151
5705  0f7a               L3251:
5706                     ; 1474       while (nBytes--) {
5708  0f7a 1e0c          	ldw	x,(OFST+5,sp)
5709  0f7c 5a            	decw	x
5710  0f7d 1f0c          	ldw	(OFST+5,sp),x
5711  0f7f 5c            	incw	x
5712  0f80 2703cc0d21    	jrne	L1251
5713  0f85 a60b          	ld	a,#11
5714  0f87 20ec          	jra	L5251
5715  0f89               L7151:
5716                     ; 1694     if (pSocket->nState == STATE_PARSEGET) {
5718  0f89 a10d          	cp	a,#13
5719  0f8b 2703cc1241    	jrne	L1071
5721  0f90 cc1236        	jra	L5071
5722  0f93               L3071:
5723                     ; 1708         if (pSocket->ParseState == PARSE_SLASH1) {
5725  0f93 1e0e          	ldw	x,(OFST+7,sp)
5726  0f95 e609          	ld	a,(9,x)
5727  0f97 a106          	cp	a,#6
5728  0f99 263e          	jrne	L1171
5729                     ; 1711           pSocket->ParseCmd = *pBuffer;
5731  0f9b 1e08          	ldw	x,(OFST+1,sp)
5732  0f9d f6            	ld	a,(x)
5733  0f9e 1e0e          	ldw	x,(OFST+7,sp)
5734  0fa0 e707          	ld	(7,x),a
5735                     ; 1712           pSocket->nParseLeft--;
5737  0fa2 6a06          	dec	(6,x)
5738                     ; 1713           pBuffer++;
5740  0fa4 1e08          	ldw	x,(OFST+1,sp)
5741  0fa6 5c            	incw	x
5742  0fa7 1f08          	ldw	(OFST+1,sp),x
5743                     ; 1714 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5745  0fa9 1e0e          	ldw	x,(OFST+7,sp)
5746  0fab e607          	ld	a,(7,x)
5747  0fad a12f          	cp	a,#47
5748  0faf 2604          	jrne	L3171
5749                     ; 1715 	    pSocket->ParseState = PARSE_NUM10;
5751  0fb1 a601          	ld	a,#1
5752  0fb3 e709          	ld	(9,x),a
5753  0fb5               L3171:
5754                     ; 1717 	  if (pSocket->nParseLeft == 0) {
5756  0fb5 e606          	ld	a,(6,x)
5757  0fb7 2703cc1214    	jrne	L7171
5758                     ; 1719 	    current_webpage = WEBPAGE_DEFAULT;
5760  0fbc c7000b        	ld	_current_webpage,a
5761                     ; 1720             pSocket->pData = g_HtmlPageDefault;
5763  0fbf 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5764  0fc3 ef01          	ldw	(1,x),y
5765                     ; 1721             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5767  0fc5 90ae1647      	ldw	y,#5703
5768  0fc9 ef03          	ldw	(3,x),y
5769                     ; 1722             pSocket->nNewlines = 0;
5771  0fcb e705          	ld	(5,x),a
5772                     ; 1723             pSocket->nState = STATE_SENDHEADER;
5774  0fcd a60b          	ld	a,#11
5775  0fcf f7            	ld	(x),a
5776                     ; 1724             pSocket->nPrevBytes = 0xFFFF;
5778  0fd0 90aeffff      	ldw	y,#65535
5779  0fd4 ef0a          	ldw	(10,x),y
5780                     ; 1725             break;
5782  0fd6 cc1241        	jra	L1071
5783  0fd9               L1171:
5784                     ; 1728         else if (pSocket->ParseState == PARSE_NUM10) {
5786  0fd9 a101          	cp	a,#1
5787  0fdb 264e          	jrne	L1271
5788                     ; 1733 	  if (*pBuffer == ' ') {
5790  0fdd 1e08          	ldw	x,(OFST+1,sp)
5791  0fdf f6            	ld	a,(x)
5792  0fe0 a120          	cp	a,#32
5793  0fe2 2620          	jrne	L3271
5794                     ; 1734 	    current_webpage = WEBPAGE_DEFAULT;
5796  0fe4 725f000b      	clr	_current_webpage
5797                     ; 1735             pSocket->pData = g_HtmlPageDefault;
5799  0fe8 1e0e          	ldw	x,(OFST+7,sp)
5800  0fea 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5801  0fee ef01          	ldw	(1,x),y
5802                     ; 1736             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5804  0ff0 90ae1647      	ldw	y,#5703
5805  0ff4 ef03          	ldw	(3,x),y
5806                     ; 1737             pSocket->nNewlines = 0;
5808  0ff6 6f05          	clr	(5,x)
5809                     ; 1738             pSocket->nState = STATE_SENDHEADER;
5811  0ff8 a60b          	ld	a,#11
5812  0ffa f7            	ld	(x),a
5813                     ; 1739             pSocket->nPrevBytes = 0xFFFF;
5815  0ffb 90aeffff      	ldw	y,#65535
5816  0fff ef0a          	ldw	(10,x),y
5817                     ; 1740 	    break;
5819  1001 cc1241        	jra	L1071
5820  1004               L3271:
5821                     ; 1743 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5823  1004 a130          	cp	a,#48
5824  1006 2504          	jrult	L5271
5826  1008 a13a          	cp	a,#58
5827  100a 2506          	jrult	L7271
5829  100c               L5271:
5830                     ; 1744 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5832  100c 1e0e          	ldw	x,(OFST+7,sp)
5833  100e a605          	ld	a,#5
5834  1010 e709          	ld	(9,x),a
5835  1012               L7271:
5836                     ; 1745           if (pSocket->ParseState == PARSE_NUM10) {      // Still good - parse number
5838  1012 1e0e          	ldw	x,(OFST+7,sp)
5839  1014 e609          	ld	a,(9,x)
5840  1016 4a            	dec	a
5841  1017 26a0          	jrne	L7171
5842                     ; 1746             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5844  1019 1e08          	ldw	x,(OFST+1,sp)
5845  101b f6            	ld	a,(x)
5846  101c 97            	ld	xl,a
5847  101d a60a          	ld	a,#10
5848  101f 42            	mul	x,a
5849  1020 9f            	ld	a,xl
5850  1021 1e0e          	ldw	x,(OFST+7,sp)
5851  1023 a0e0          	sub	a,#224
5852  1025 e708          	ld	(8,x),a
5853                     ; 1747 	    pSocket->ParseState = PARSE_NUM1;
5855  1027 a602          	ld	a,#2
5856                     ; 1748             pSocket->nParseLeft--;
5857                     ; 1749             pBuffer++;
5858  1029 202c          	jp	LC023
5859  102b               L1271:
5860                     ; 1753         else if (pSocket->ParseState == PARSE_NUM1) {
5862  102b a102          	cp	a,#2
5863  102d 2634          	jrne	L5371
5864                     ; 1754 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5866  102f 1e08          	ldw	x,(OFST+1,sp)
5867  1031 f6            	ld	a,(x)
5868  1032 a130          	cp	a,#48
5869  1034 2504          	jrult	L7371
5871  1036 a13a          	cp	a,#58
5872  1038 2506          	jrult	L1471
5874  103a               L7371:
5875                     ; 1755 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5877  103a 1e0e          	ldw	x,(OFST+7,sp)
5878  103c a605          	ld	a,#5
5879  103e e709          	ld	(9,x),a
5880  1040               L1471:
5881                     ; 1756           if (pSocket->ParseState == PARSE_NUM1) {       // Still good - parse number
5883  1040 1e0e          	ldw	x,(OFST+7,sp)
5884  1042 e609          	ld	a,(9,x)
5885  1044 a102          	cp	a,#2
5886  1046 2703cc1214    	jrne	L7171
5887                     ; 1757             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5889  104b 1608          	ldw	y,(OFST+1,sp)
5890  104d 90f6          	ld	a,(y)
5891  104f a030          	sub	a,#48
5892  1051 eb08          	add	a,(8,x)
5893  1053 e708          	ld	(8,x),a
5894                     ; 1758             pSocket->ParseState = PARSE_VAL;
5896  1055 a604          	ld	a,#4
5897                     ; 1759             pSocket->nParseLeft--;
5899                     ; 1760             pBuffer++;
5901  1057               LC023:
5902  1057 e709          	ld	(9,x),a
5904  1059 6a06          	dec	(6,x)
5906  105b 1e08          	ldw	x,(OFST+1,sp)
5907  105d 5c            	incw	x
5908  105e 1f08          	ldw	(OFST+1,sp),x
5909  1060 cc1214        	jra	L7171
5910  1063               L5371:
5911                     ; 1763         else if (pSocket->ParseState == PARSE_VAL) {
5913  1063 a104          	cp	a,#4
5914  1065 2703cc121c    	jrne	L7471
5915                     ; 1815           switch(pSocket->ParseNum)
5917  106a e608          	ld	a,(8,x)
5919                     ; 1949 	      break;
5920  106c a144          	cp	a,#68
5921  106e 2407          	jruge	L472
5922  1070 5f            	clrw	x
5923  1071 97            	ld	xl,a
5924  1072 58            	sllw	x
5925  1073 de3cda        	ldw	x,(L672,x)
5926  1076 fc            	jp	(x)
5927  1077               L472:
5928  1077 a05b          	sub	a,#91
5929  1079 2603cc11d8    	jreq	L1421
5930  107e a008          	sub	a,#8
5931  1080 2603cc11de    	jreq	L3421
5932  1085 cc11f3        	jra	L5421
5933  1088               L7111:
5934                     ; 1817 	    case 0:  Relays_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
5936  1088 72110000      	bres	_Relays_8to1,#0
5939  108c cc120e        	jra	L3571
5940  108f               L1211:
5941                     ; 1818 	    case 1:  Relays_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
5943  108f 72100000      	bset	_Relays_8to1,#0
5946  1093 cc120e        	jra	L3571
5947  1096               L3211:
5948                     ; 1819 	    case 2:  Relays_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
5950  1096 72130000      	bres	_Relays_8to1,#1
5953  109a cc120e        	jra	L3571
5954  109d               L5211:
5955                     ; 1820 	    case 3:  Relays_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
5957  109d 72120000      	bset	_Relays_8to1,#1
5960  10a1 cc120e        	jra	L3571
5961  10a4               L7211:
5962                     ; 1821 	    case 4:  Relays_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
5964  10a4 72150000      	bres	_Relays_8to1,#2
5967  10a8 cc120e        	jra	L3571
5968  10ab               L1311:
5969                     ; 1822 	    case 5:  Relays_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
5971  10ab 72140000      	bset	_Relays_8to1,#2
5974  10af cc120e        	jra	L3571
5975  10b2               L3311:
5976                     ; 1823 	    case 6:  Relays_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
5978  10b2 72170000      	bres	_Relays_8to1,#3
5981  10b6 cc120e        	jra	L3571
5982  10b9               L5311:
5983                     ; 1824 	    case 7:  Relays_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
5985  10b9 72160000      	bset	_Relays_8to1,#3
5988  10bd cc120e        	jra	L3571
5989  10c0               L7311:
5990                     ; 1825 	    case 8:  Relays_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
5992  10c0 72190000      	bres	_Relays_8to1,#4
5995  10c4 cc120e        	jra	L3571
5996  10c7               L1411:
5997                     ; 1826 	    case 9:  Relays_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
5999  10c7 72180000      	bset	_Relays_8to1,#4
6002  10cb cc120e        	jra	L3571
6003  10ce               L3411:
6004                     ; 1827 	    case 10: Relays_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
6006  10ce 721b0000      	bres	_Relays_8to1,#5
6009  10d2 cc120e        	jra	L3571
6010  10d5               L5411:
6011                     ; 1828 	    case 11: Relays_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
6013  10d5 721a0000      	bset	_Relays_8to1,#5
6016  10d9 cc120e        	jra	L3571
6017  10dc               L7411:
6018                     ; 1829 	    case 12: Relays_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
6020  10dc 721d0000      	bres	_Relays_8to1,#6
6023  10e0 cc120e        	jra	L3571
6024  10e3               L1511:
6025                     ; 1830 	    case 13: Relays_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
6027  10e3 721c0000      	bset	_Relays_8to1,#6
6030  10e7 cc120e        	jra	L3571
6031  10ea               L3511:
6032                     ; 1831 	    case 14: Relays_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
6034  10ea 721f0000      	bres	_Relays_8to1,#7
6037  10ee cc120e        	jra	L3571
6038  10f1               L5511:
6039                     ; 1832 	    case 15: Relays_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
6041  10f1 721e0000      	bset	_Relays_8to1,#7
6044  10f5 cc120e        	jra	L3571
6045  10f8               L7511:
6046                     ; 1833 	    case 16: Relays_16to9 &= (uint8_t)(~0x01); break; // Relay-09 OFF
6048  10f8 72110000      	bres	_Relays_16to9,#0
6051  10fc cc120e        	jra	L3571
6052  10ff               L1611:
6053                     ; 1834 	    case 17: Relays_16to9 |= (uint8_t)0x01;    break; // Relay-09 ON
6055  10ff 72100000      	bset	_Relays_16to9,#0
6058  1103 cc120e        	jra	L3571
6059  1106               L3611:
6060                     ; 1835 	    case 18: Relays_16to9 &= (uint8_t)(~0x02); break; // Relay-10 OFF
6062  1106 72130000      	bres	_Relays_16to9,#1
6065  110a cc120e        	jra	L3571
6066  110d               L5611:
6067                     ; 1836 	    case 19: Relays_16to9 |= (uint8_t)0x02;    break; // Relay-10 ON
6069  110d 72120000      	bset	_Relays_16to9,#1
6072  1111 cc120e        	jra	L3571
6073  1114               L7611:
6074                     ; 1837 	    case 20: Relays_16to9 &= (uint8_t)(~0x04); break; // Relay-11 OFF
6076  1114 72150000      	bres	_Relays_16to9,#2
6079  1118 cc120e        	jra	L3571
6080  111b               L1711:
6081                     ; 1838 	    case 21: Relays_16to9 |= (uint8_t)0x04;    break; // Relay-11 ON
6083  111b 72140000      	bset	_Relays_16to9,#2
6086  111f cc120e        	jra	L3571
6087  1122               L3711:
6088                     ; 1839 	    case 22: Relays_16to9 &= (uint8_t)(~0x08); break; // Relay-12 OFF
6090  1122 72170000      	bres	_Relays_16to9,#3
6093  1126 cc120e        	jra	L3571
6094  1129               L5711:
6095                     ; 1840 	    case 23: Relays_16to9 |= (uint8_t)0x08;    break; // Relay-12 ON
6097  1129 72160000      	bset	_Relays_16to9,#3
6100  112d cc120e        	jra	L3571
6101  1130               L7711:
6102                     ; 1841 	    case 24: Relays_16to9 &= (uint8_t)(~0x10); break; // Relay-13 OFF
6104  1130 72190000      	bres	_Relays_16to9,#4
6107  1134 cc120e        	jra	L3571
6108  1137               L1021:
6109                     ; 1842 	    case 25: Relays_16to9 |= (uint8_t)0x10;    break; // Relay-13 ON
6111  1137 72180000      	bset	_Relays_16to9,#4
6114  113b cc120e        	jra	L3571
6115  113e               L3021:
6116                     ; 1843 	    case 26: Relays_16to9 &= (uint8_t)(~0x20); break; // Relay-14 OFF
6118  113e 721b0000      	bres	_Relays_16to9,#5
6121  1142 cc120e        	jra	L3571
6122  1145               L5021:
6123                     ; 1844 	    case 27: Relays_16to9 |= (uint8_t)0x20;    break; // Relay-14 ON
6125  1145 721a0000      	bset	_Relays_16to9,#5
6128  1149 cc120e        	jra	L3571
6129  114c               L7021:
6130                     ; 1845 	    case 28: Relays_16to9 &= (uint8_t)(~0x40); break; // Relay-15 OFF
6132  114c 721d0000      	bres	_Relays_16to9,#6
6135  1150 cc120e        	jra	L3571
6136  1153               L1121:
6137                     ; 1846 	    case 29: Relays_16to9 |= (uint8_t)0x40;    break; // Relay-15 ON
6139  1153 721c0000      	bset	_Relays_16to9,#6
6142  1157 cc120e        	jra	L3571
6143  115a               L3121:
6144                     ; 1847 	    case 30: Relays_16to9 &= (uint8_t)(~0x80); break; // Relay-16 OFF
6146  115a 721f0000      	bres	_Relays_16to9,#7
6149  115e cc120e        	jra	L3571
6150  1161               L5121:
6151                     ; 1848 	    case 31: Relays_16to9 |= (uint8_t)0x80;    break; // Relay-16 ON
6153  1161 721e0000      	bset	_Relays_16to9,#7
6156  1165 cc120e        	jra	L3571
6157  1168               L7121:
6158                     ; 1849 	    case 55:
6158                     ; 1850   	      Relays_8to1 = (uint8_t)0xff; // Relays 1-8 ON
6160  1168 35ff0000      	mov	_Relays_8to1,#255
6161                     ; 1851   	      Relays_16to9 = (uint8_t)0xff; // Relays 9-16 ON
6163  116c 35ff0000      	mov	_Relays_16to9,#255
6164                     ; 1852 	      break;
6166  1170 cc120e        	jra	L3571
6167  1173               L1221:
6168                     ; 1853 	    case 56:
6168                     ; 1854               Relays_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
6170  1173 725f0000      	clr	_Relays_8to1
6171                     ; 1855               Relays_16to9 = (uint8_t)0x00; // Relays 9-16 OFF
6173  1177 725f0000      	clr	_Relays_16to9
6174                     ; 1856 	      break;
6176  117b cc120e        	jra	L3571
6177  117e               L3221:
6178                     ; 1858 	    case 60: // Show relay states page
6178                     ; 1859 	      current_webpage = WEBPAGE_DEFAULT;
6179                     ; 1860               pSocket->pData = g_HtmlPageDefault;
6180                     ; 1861               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6181                     ; 1862               pSocket->nNewlines = 0;
6182                     ; 1863               pSocket->nState = STATE_CONNECTED;
6183                     ; 1864               pSocket->nPrevBytes = 0xFFFF;
6184                     ; 1865 	      break;
6186  117e 2073          	jp	L5421
6187  1180               L5221:
6188                     ; 1867 	    case 61: // Show address settings page
6188                     ; 1868 	      current_webpage = WEBPAGE_ADDRESS;
6190  1180 3501000b      	mov	_current_webpage,#1
6191                     ; 1869               pSocket->pData = g_HtmlPageAddress;
6193  1184 1e0e          	ldw	x,(OFST+7,sp)
6194  1186 90ae1650      	ldw	y,#L71_g_HtmlPageAddress
6195  118a ef01          	ldw	(1,x),y
6196                     ; 1870               pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
6198  118c 90ae1117      	ldw	y,#4375
6199                     ; 1871               pSocket->nNewlines = 0;
6200                     ; 1872               pSocket->nState = STATE_CONNECTED;
6201                     ; 1873               pSocket->nPrevBytes = 0xFFFF;
6202                     ; 1874 	      break;
6204  1190 2071          	jp	LC020
6205  1192               L7221:
6206                     ; 1877 	    case 63: // Show help page 1
6206                     ; 1878 	      current_webpage = WEBPAGE_HELP;
6208  1192 3503000b      	mov	_current_webpage,#3
6209                     ; 1879               pSocket->pData = g_HtmlPageHelp;
6211  1196 1e0e          	ldw	x,(OFST+7,sp)
6212  1198 90ae2768      	ldw	y,#L12_g_HtmlPageHelp
6213  119c ef01          	ldw	(1,x),y
6214                     ; 1880               pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
6216  119e 90ae076f      	ldw	y,#1903
6217                     ; 1881               pSocket->nNewlines = 0;
6218                     ; 1882               pSocket->nState = STATE_CONNECTED;
6219                     ; 1883               pSocket->nPrevBytes = 0xFFFF;
6220                     ; 1884 	      break;
6222  11a2 205f          	jp	LC020
6223  11a4               L1321:
6224                     ; 1886 	    case 64: // Show help page 2
6224                     ; 1887 	      current_webpage = WEBPAGE_HELP2;
6226  11a4 3504000b      	mov	_current_webpage,#4
6227                     ; 1888               pSocket->pData = g_HtmlPageHelp2;
6229  11a8 1e0e          	ldw	x,(OFST+7,sp)
6230  11aa 90ae2ed8      	ldw	y,#L32_g_HtmlPageHelp2
6231  11ae ef01          	ldw	(1,x),y
6232                     ; 1889               pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
6234  11b0 90ae02a8      	ldw	y,#680
6235                     ; 1890               pSocket->nNewlines = 0;
6236                     ; 1891               pSocket->nState = STATE_CONNECTED;
6237                     ; 1892               pSocket->nPrevBytes = 0xFFFF;
6238                     ; 1893 	      break;
6240  11b4 204d          	jp	LC020
6241  11b6               L3321:
6242                     ; 1896 	    case 65: // Flash LED for diagnostics
6242                     ; 1897 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6242                     ; 1898 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6242                     ; 1899 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6242                     ; 1900 	      debugflash();
6244  11b6 cd0000        	call	_debugflash
6246                     ; 1901 	      debugflash();
6248  11b9 cd0000        	call	_debugflash
6250                     ; 1902 	      debugflash();
6252  11bc cd0000        	call	_debugflash
6254                     ; 1906 	      break;
6256  11bf 204d          	jra	L3571
6257  11c1               L5321:
6258                     ; 1909             case 66: // Show statistics page
6258                     ; 1910 	      current_webpage = WEBPAGE_STATS;
6259                     ; 1911               pSocket->pData = g_HtmlPageStats;
6260                     ; 1912               pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
6261                     ; 1913               pSocket->nNewlines = 0;
6262                     ; 1914               pSocket->nState = STATE_CONNECTED;
6263                     ; 1915               pSocket->nPrevBytes = 0xFFFF;
6264                     ; 1916 	      break;
6266  11c1 2003          	jp	LC022
6267  11c3               L7321:
6268                     ; 1918             case 67: // Clear statistics
6268                     ; 1919 	      uip_init_stats();
6270  11c3 cd0000        	call	_uip_init_stats
6272                     ; 1920 	      current_webpage = WEBPAGE_STATS;
6274                     ; 1921               pSocket->pData = g_HtmlPageStats;
6276                     ; 1922               pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
6278  11c6               LC022:
6280  11c6 3505000b      	mov	_current_webpage,#5
6282  11ca 1e0e          	ldw	x,(OFST+7,sp)
6283  11cc 90ae3181      	ldw	y,#L52_g_HtmlPageStats
6284  11d0 ef01          	ldw	(1,x),y
6286  11d2 90ae0a9b      	ldw	y,#2715
6287                     ; 1923               pSocket->nNewlines = 0;
6288                     ; 1924               pSocket->nState = STATE_CONNECTED;
6289                     ; 1925               pSocket->nPrevBytes = 0xFFFF;
6290                     ; 1926 	      break;
6292  11d6 202b          	jp	LC020
6293  11d8               L1421:
6294                     ; 1929 	    case 91: // Reboot
6294                     ; 1930 	      submit_changes = 2;
6296  11d8 35020000      	mov	_submit_changes,#2
6297                     ; 1931 	      break;
6299  11dc 2030          	jra	L3571
6300  11de               L3421:
6301                     ; 1933             case 99: // Show simplified relay state page
6301                     ; 1934 	      current_webpage = WEBPAGE_RSTATE;
6303  11de 3506000b      	mov	_current_webpage,#6
6304                     ; 1935               pSocket->pData = g_HtmlPageRstate;
6306  11e2 90ae3c1d      	ldw	y,#L72_g_HtmlPageRstate
6307  11e6 ef01          	ldw	(1,x),y
6308                     ; 1936               pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
6310  11e8 90ae0078      	ldw	y,#120
6311  11ec ef03          	ldw	(3,x),y
6312                     ; 1937               pSocket->nNewlines = 0;
6314  11ee e705          	ld	(5,x),a
6315                     ; 1938               pSocket->nState = STATE_CONNECTED;
6317  11f0 f7            	ld	(x),a
6318                     ; 1939               pSocket->nPrevBytes = 0xFFFF;
6319                     ; 1940 	      break;
6321  11f1 2015          	jp	LC019
6322  11f3               L5421:
6323                     ; 1942 	    default: // Show relay state page
6323                     ; 1943 	      current_webpage = WEBPAGE_DEFAULT;
6325                     ; 1944               pSocket->pData = g_HtmlPageDefault;
6327                     ; 1945               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6330  11f3 725f000b      	clr	_current_webpage
6332  11f7 1e0e          	ldw	x,(OFST+7,sp)
6333  11f9 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
6334  11fd ef01          	ldw	(1,x),y
6336  11ff 90ae1647      	ldw	y,#5703
6337                     ; 1946               pSocket->nNewlines = 0;
6339                     ; 1947               pSocket->nState = STATE_CONNECTED;
6341  1203               LC020:
6342  1203 ef03          	ldw	(3,x),y
6349  1205 6f05          	clr	(5,x)
6356  1207 7f            	clr	(x)
6357                     ; 1948               pSocket->nPrevBytes = 0xFFFF;
6359  1208               LC019:
6367  1208 90aeffff      	ldw	y,#65535
6368  120c ef0a          	ldw	(10,x),y
6369                     ; 1949 	      break;
6371  120e               L3571:
6372                     ; 1951           pSocket->ParseState = PARSE_DELIM;
6374  120e 1e0e          	ldw	x,(OFST+7,sp)
6375  1210 a605          	ld	a,#5
6376  1212 e709          	ld	(9,x),a
6378  1214               L7171:
6379                     ; 1965         if (pSocket->nParseLeft == 0) {
6381  1214 1e0e          	ldw	x,(OFST+7,sp)
6382  1216 e606          	ld	a,(6,x)
6383  1218 261c          	jrne	L5071
6384                     ; 1967           pSocket->nState = STATE_SENDHEADER;
6385                     ; 1968           break;
6387  121a 2015          	jp	LC024
6388  121c               L7471:
6389                     ; 1954         else if (pSocket->ParseState == PARSE_DELIM) {
6391  121c a105          	cp	a,#5
6392  121e 26f4          	jrne	L7171
6393                     ; 1956           pSocket->ParseState = PARSE_DELIM;
6395  1220 a605          	ld	a,#5
6396  1222 e709          	ld	(9,x),a
6397                     ; 1957           pSocket->nParseLeft--;
6399  1224 6a06          	dec	(6,x)
6400                     ; 1958           pBuffer++;
6402  1226 1e08          	ldw	x,(OFST+1,sp)
6403  1228 5c            	incw	x
6404  1229 1f08          	ldw	(OFST+1,sp),x
6405                     ; 1959 	  if (pSocket->nParseLeft == 0) {
6407  122b 1e0e          	ldw	x,(OFST+7,sp)
6408  122d e606          	ld	a,(6,x)
6409  122f 26e3          	jrne	L7171
6410                     ; 1961             pSocket->nState = STATE_SENDHEADER;
6412  1231               LC024:
6414  1231 a60b          	ld	a,#11
6415  1233 f7            	ld	(x),a
6416                     ; 1962             break;
6418  1234 200b          	jra	L1071
6419  1236               L5071:
6420                     ; 1707       while (nBytes--) {
6422  1236 1e0c          	ldw	x,(OFST+5,sp)
6423  1238 5a            	decw	x
6424  1239 1f0c          	ldw	(OFST+5,sp),x
6425  123b 5c            	incw	x
6426  123c 2703cc0f93    	jrne	L3071
6427  1241               L1071:
6428                     ; 1973     if (pSocket->nState == STATE_SENDHEADER) {
6430  1241 1e0e          	ldw	x,(OFST+7,sp)
6431  1243 f6            	ld	a,(x)
6432  1244 a10b          	cp	a,#11
6433  1246 2623          	jrne	L5671
6434                     ; 1974       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6436  1248 ee03          	ldw	x,(3,x)
6437  124a cd0000        	call	c_uitolx
6439  124d be02          	ldw	x,c_lreg+2
6440  124f 89            	pushw	x
6441  1250 be00          	ldw	x,c_lreg
6442  1252 89            	pushw	x
6443  1253 ce0000        	ldw	x,_uip_appdata
6444  1256 cd0231        	call	L7_CopyHttpHeader
6446  1259 5b04          	addw	sp,#4
6447  125b 89            	pushw	x
6448  125c ce0000        	ldw	x,_uip_appdata
6449  125f cd0000        	call	_uip_send
6451  1262 85            	popw	x
6452                     ; 1975       pSocket->nState = STATE_SENDDATA;
6454  1263 1e0e          	ldw	x,(OFST+7,sp)
6455  1265 a60c          	ld	a,#12
6456  1267 f7            	ld	(x),a
6457                     ; 1976       return;
6459  1268 cc0bd7        	jra	L023
6460  126b               L5671:
6461                     ; 1979     if (pSocket->nState == STATE_SENDDATA) {
6463  126b a10c          	cp	a,#12
6464  126d 26f9          	jrne	L023
6465                     ; 1983       pSocket->nPrevBytes = pSocket->nDataLeft;
6467  126f 9093          	ldw	y,x
6468  1271 90ee03        	ldw	y,(3,y)
6469  1274 ef0a          	ldw	(10,x),y
6470                     ; 1984       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6472  1276 ce0000        	ldw	x,_uip_conn
6473  1279 ee12          	ldw	x,(18,x)
6474  127b 89            	pushw	x
6475  127c 1e10          	ldw	x,(OFST+9,sp)
6476  127e 1c0003        	addw	x,#3
6477  1281 89            	pushw	x
6478  1282 1e12          	ldw	x,(OFST+11,sp)
6479  1284 5c            	incw	x
6480  1285 89            	pushw	x
6481  1286 ce0000        	ldw	x,_uip_appdata
6482  1289 cd02c9        	call	L11_CopyHttpData
6484  128c 5b06          	addw	sp,#6
6485  128e 1f01          	ldw	(OFST-6,sp),x
6487                     ; 1985       pSocket->nPrevBytes -= pSocket->nDataLeft;
6489  1290 1e0e          	ldw	x,(OFST+7,sp)
6490  1292 e60b          	ld	a,(11,x)
6491  1294 e004          	sub	a,(4,x)
6492  1296 e70b          	ld	(11,x),a
6493  1298 e60a          	ld	a,(10,x)
6494  129a e203          	sbc	a,(3,x)
6495  129c e70a          	ld	(10,x),a
6496                     ; 1987       if (nBufSize == 0) {
6498  129e 1e01          	ldw	x,(OFST-6,sp)
6499  12a0 262d          	jrne	LC014
6500                     ; 1989         uip_close();
6502  12a2               LC015:
6504  12a2 35100000      	mov	_uip_flags,#16
6506  12a6 cc0bd7        	jra	L023
6507                     ; 1993         uip_send(uip_appdata, nBufSize);
6509                     ; 1995       return;
6511  12a9               L7731:
6512                     ; 1999   else if (uip_rexmit()) {
6514  12a9 7204000003cc  	btjf	_uip_flags,#2,L5731
6515                     ; 2000     if (pSocket->nPrevBytes == 0xFFFF) {
6517  12b1 160e          	ldw	y,(OFST+7,sp)
6518  12b3 90ee0a        	ldw	y,(10,y)
6519  12b6 905c          	incw	y
6520  12b8 2620          	jrne	L1002
6521                     ; 2002       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6523  12ba 1e0e          	ldw	x,(OFST+7,sp)
6524  12bc ee03          	ldw	x,(3,x)
6525  12be cd0000        	call	c_uitolx
6527  12c1 be02          	ldw	x,c_lreg+2
6528  12c3 89            	pushw	x
6529  12c4 be00          	ldw	x,c_lreg
6530  12c6 89            	pushw	x
6531  12c7 ce0000        	ldw	x,_uip_appdata
6532  12ca cd0231        	call	L7_CopyHttpHeader
6534  12cd 5b04          	addw	sp,#4
6536  12cf               LC014:
6538  12cf 89            	pushw	x
6539  12d0 ce0000        	ldw	x,_uip_appdata
6540  12d3 cd0000        	call	_uip_send
6541  12d6 85            	popw	x
6543  12d7 cc0bd7        	jra	L023
6544  12da               L1002:
6545                     ; 2005       pSocket->pData -= pSocket->nPrevBytes;
6547  12da 1e0e          	ldw	x,(OFST+7,sp)
6548  12dc e602          	ld	a,(2,x)
6549  12de e00b          	sub	a,(11,x)
6550  12e0 e702          	ld	(2,x),a
6551  12e2 e601          	ld	a,(1,x)
6552  12e4 e20a          	sbc	a,(10,x)
6553  12e6 e701          	ld	(1,x),a
6554                     ; 2006       pSocket->nDataLeft += pSocket->nPrevBytes;
6556  12e8 e604          	ld	a,(4,x)
6557  12ea eb0b          	add	a,(11,x)
6558  12ec e704          	ld	(4,x),a
6559  12ee e603          	ld	a,(3,x)
6560  12f0 e90a          	adc	a,(10,x)
6561                     ; 2007       pSocket->nPrevBytes = pSocket->nDataLeft;
6563  12f2 9093          	ldw	y,x
6564  12f4 e703          	ld	(3,x),a
6565  12f6 90ee03        	ldw	y,(3,y)
6566  12f9 ef0a          	ldw	(10,x),y
6567                     ; 2008       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6569  12fb ce0000        	ldw	x,_uip_conn
6570  12fe ee12          	ldw	x,(18,x)
6571  1300 89            	pushw	x
6572  1301 1e10          	ldw	x,(OFST+9,sp)
6573  1303 1c0003        	addw	x,#3
6574  1306 89            	pushw	x
6575  1307 1e12          	ldw	x,(OFST+11,sp)
6576  1309 5c            	incw	x
6577  130a 89            	pushw	x
6578  130b ce0000        	ldw	x,_uip_appdata
6579  130e cd02c9        	call	L11_CopyHttpData
6581  1311 5b06          	addw	sp,#6
6582  1313 1f01          	ldw	(OFST-6,sp),x
6584                     ; 2009       pSocket->nPrevBytes -= pSocket->nDataLeft;
6586  1315 1e0e          	ldw	x,(OFST+7,sp)
6587  1317 e60b          	ld	a,(11,x)
6588  1319 e004          	sub	a,(4,x)
6589  131b e70b          	ld	(11,x),a
6590  131d e60a          	ld	a,(10,x)
6591  131f e203          	sbc	a,(3,x)
6592  1321 e70a          	ld	(10,x),a
6593                     ; 2010       if (nBufSize == 0) {
6595  1323 1e01          	ldw	x,(OFST-6,sp)
6596                     ; 2012         uip_close();
6598  1325 2603cc12a2    	jreq	LC015
6599                     ; 2016         uip_send(uip_appdata, nBufSize);
6601  132a 89            	pushw	x
6602  132b ce0000        	ldw	x,_uip_appdata
6603  132e cd0000        	call	_uip_send
6605  1331 85            	popw	x
6606                     ; 2019     return;
6608  1332               L5731:
6609                     ; 2021 }
6611  1332 cc0bd7        	jra	L023
6645                     ; 2024 uint8_t GpioGetPin(uint8_t nGpio)
6645                     ; 2025 {
6646                     	switch	.text
6647  1335               _GpioGetPin:
6649       00000000      OFST:	set	0
6652                     ; 2027   if (nGpio == 0       && (Relays_8to1  & (uint8_t)(0x01))) return 1; // Relay-01 is ON
6654  1335 4d            	tnz	a
6655  1336 2607          	jrne	L5202
6657  1338 7201000002    	btjf	_Relays_8to1,#0,L5202
6660  133d 4c            	inc	a
6663  133e 81            	ret	
6664  133f               L5202:
6665                     ; 2028   else if (nGpio == 1  && (Relays_8to1  & (uint8_t)(0x02))) return 1; // Relay-02 is ON
6667  133f a101          	cp	a,#1
6668  1341 2608          	jrne	L1302
6670  1343 7203000003    	btjf	_Relays_8to1,#1,L1302
6673  1348 a601          	ld	a,#1
6676  134a 81            	ret	
6677  134b               L1302:
6678                     ; 2029   else if (nGpio == 2  && (Relays_8to1  & (uint8_t)(0x04))) return 1; // Relay-03 is ON
6680  134b a102          	cp	a,#2
6681  134d 2608          	jrne	L5302
6683  134f 7205000003    	btjf	_Relays_8to1,#2,L5302
6686  1354 a601          	ld	a,#1
6689  1356 81            	ret	
6690  1357               L5302:
6691                     ; 2030   else if (nGpio == 3  && (Relays_8to1  & (uint8_t)(0x08))) return 1; // Relay-04 is ON
6693  1357 a103          	cp	a,#3
6694  1359 2608          	jrne	L1402
6696  135b 7207000003    	btjf	_Relays_8to1,#3,L1402
6699  1360 a601          	ld	a,#1
6702  1362 81            	ret	
6703  1363               L1402:
6704                     ; 2031   else if (nGpio == 4  && (Relays_8to1  & (uint8_t)(0x10))) return 1; // Relay-05 is ON
6706  1363 a104          	cp	a,#4
6707  1365 2608          	jrne	L5402
6709  1367 7209000003    	btjf	_Relays_8to1,#4,L5402
6712  136c a601          	ld	a,#1
6715  136e 81            	ret	
6716  136f               L5402:
6717                     ; 2032   else if (nGpio == 5  && (Relays_8to1  & (uint8_t)(0x20))) return 1; // Relay-06 is ON
6719  136f a105          	cp	a,#5
6720  1371 2608          	jrne	L1502
6722  1373 720b000003    	btjf	_Relays_8to1,#5,L1502
6725  1378 a601          	ld	a,#1
6728  137a 81            	ret	
6729  137b               L1502:
6730                     ; 2033   else if (nGpio == 6  && (Relays_8to1  & (uint8_t)(0x40))) return 1; // Relay-07 is ON
6732  137b a106          	cp	a,#6
6733  137d 2608          	jrne	L5502
6735  137f 720d000003    	btjf	_Relays_8to1,#6,L5502
6738  1384 a601          	ld	a,#1
6741  1386 81            	ret	
6742  1387               L5502:
6743                     ; 2034   else if (nGpio == 7  && (Relays_8to1  & (uint8_t)(0x80))) return 1; // Relay-08 is ON
6745  1387 a107          	cp	a,#7
6746  1389 2608          	jrne	L1602
6748  138b 720f000003    	btjf	_Relays_8to1,#7,L1602
6751  1390 a601          	ld	a,#1
6754  1392 81            	ret	
6755  1393               L1602:
6756                     ; 2035   else if (nGpio == 8  && (Relays_16to9 & (uint8_t)(0x01))) return 1; // Relay-09 is ON
6758  1393 a108          	cp	a,#8
6759  1395 2608          	jrne	L5602
6761  1397 7201000003    	btjf	_Relays_16to9,#0,L5602
6764  139c a601          	ld	a,#1
6767  139e 81            	ret	
6768  139f               L5602:
6769                     ; 2036   else if (nGpio == 9  && (Relays_16to9 & (uint8_t)(0x02))) return 1; // Relay-10 is ON
6771  139f a109          	cp	a,#9
6772  13a1 2608          	jrne	L1702
6774  13a3 7203000003    	btjf	_Relays_16to9,#1,L1702
6777  13a8 a601          	ld	a,#1
6780  13aa 81            	ret	
6781  13ab               L1702:
6782                     ; 2037   else if (nGpio == 10 && (Relays_16to9 & (uint8_t)(0x04))) return 1; // Relay-11 is ON
6784  13ab a10a          	cp	a,#10
6785  13ad 2608          	jrne	L5702
6787  13af 7205000003    	btjf	_Relays_16to9,#2,L5702
6790  13b4 a601          	ld	a,#1
6793  13b6 81            	ret	
6794  13b7               L5702:
6795                     ; 2038   else if (nGpio == 11 && (Relays_16to9 & (uint8_t)(0x08))) return 1; // Relay-12 is ON
6797  13b7 a10b          	cp	a,#11
6798  13b9 2608          	jrne	L1012
6800  13bb 7207000003    	btjf	_Relays_16to9,#3,L1012
6803  13c0 a601          	ld	a,#1
6806  13c2 81            	ret	
6807  13c3               L1012:
6808                     ; 2039   else if (nGpio == 12 && (Relays_16to9 & (uint8_t)(0x10))) return 1; // Relay-13 is ON
6810  13c3 a10c          	cp	a,#12
6811  13c5 2608          	jrne	L5012
6813  13c7 7209000003    	btjf	_Relays_16to9,#4,L5012
6816  13cc a601          	ld	a,#1
6819  13ce 81            	ret	
6820  13cf               L5012:
6821                     ; 2040   else if (nGpio == 13 && (Relays_16to9 & (uint8_t)(0x20))) return 1; // Relay-14 is ON
6823  13cf a10d          	cp	a,#13
6824  13d1 2608          	jrne	L1112
6826  13d3 720b000003    	btjf	_Relays_16to9,#5,L1112
6829  13d8 a601          	ld	a,#1
6832  13da 81            	ret	
6833  13db               L1112:
6834                     ; 2041   else if (nGpio == 14 && (Relays_16to9 & (uint8_t)(0x40))) return 1; // Relay-15 is ON
6836  13db a10e          	cp	a,#14
6837  13dd 2608          	jrne	L5112
6839  13df 720d000003    	btjf	_Relays_16to9,#6,L5112
6842  13e4 a601          	ld	a,#1
6845  13e6 81            	ret	
6846  13e7               L5112:
6847                     ; 2042   else if (nGpio == 15 && (Relays_16to9 & (uint8_t)(0x80))) return 1; // Relay-16 is ON
6849  13e7 a10f          	cp	a,#15
6850  13e9 2608          	jrne	L7202
6852  13eb 720f000003    	btjf	_Relays_16to9,#7,L7202
6855  13f0 a601          	ld	a,#1
6858  13f2 81            	ret	
6859  13f3               L7202:
6860                     ; 2043   return 0;
6862  13f3 4f            	clr	a
6865  13f4 81            	ret	
6906                     	switch	.const
6907  3d62               L033:
6908  3d62 1412          	dc.w	L3212
6909  3d64 1424          	dc.w	L5212
6910  3d66 1436          	dc.w	L7212
6911  3d68 1448          	dc.w	L1312
6912  3d6a 145a          	dc.w	L3312
6913  3d6c 146c          	dc.w	L5312
6914  3d6e 147e          	dc.w	L7312
6915  3d70 1490          	dc.w	L1412
6916  3d72 14a1          	dc.w	L3412
6917  3d74 14b1          	dc.w	L5412
6918  3d76 14c1          	dc.w	L7412
6919  3d78 14d1          	dc.w	L1512
6920  3d7a 14e1          	dc.w	L3512
6921  3d7c 14f1          	dc.w	L5512
6922  3d7e 1501          	dc.w	L7512
6923  3d80 1511          	dc.w	L1612
6924                     ; 2047 void GpioSetPin(uint8_t nGpio, uint8_t nState)
6924                     ; 2048 {
6925                     	switch	.text
6926  13f5               _GpioSetPin:
6928  13f5 89            	pushw	x
6929       00000000      OFST:	set	0
6932                     ; 2052   if (nState != 0 && nState != 1) nState = 1;
6934  13f6 9f            	ld	a,xl
6935  13f7 4d            	tnz	a
6936  13f8 2708          	jreq	L3022
6938  13fa 9f            	ld	a,xl
6939  13fb 4a            	dec	a
6940  13fc 2704          	jreq	L3022
6943  13fe a601          	ld	a,#1
6944  1400 6b02          	ld	(OFST+2,sp),a
6945  1402               L3022:
6946                     ; 2054   switch(nGpio)
6948  1402 7b01          	ld	a,(OFST+1,sp)
6950                     ; 2120   default: break;
6951  1404 a110          	cp	a,#16
6952  1406 2503cc151f    	jruge	L7022
6953  140b 5f            	clrw	x
6954  140c 97            	ld	xl,a
6955  140d 58            	sllw	x
6956  140e de3d62        	ldw	x,(L033,x)
6957  1411 fc            	jp	(x)
6958  1412               L3212:
6959                     ; 2056   case 0:
6959                     ; 2057     if (nState == 0) Relays_8to1 &= (uint8_t)(~0x01); // Relay-01 OFF
6961  1412 7b02          	ld	a,(OFST+2,sp)
6962  1414 2607          	jrne	L1122
6965  1416 72110000      	bres	_Relays_8to1,#0
6967  141a cc151f        	jra	L7022
6968  141d               L1122:
6969                     ; 2058     else Relays_8to1 |= (uint8_t)0x01; // Relay-01 ON
6971  141d 72100000      	bset	_Relays_8to1,#0
6972  1421 cc151f        	jra	L7022
6973  1424               L5212:
6974                     ; 2060   case 1:
6974                     ; 2061     if (nState == 0) Relays_8to1 &= (uint8_t)(~0x02); // Relay-02 OFF
6976  1424 7b02          	ld	a,(OFST+2,sp)
6977  1426 2607          	jrne	L5122
6980  1428 72130000      	bres	_Relays_8to1,#1
6982  142c cc151f        	jra	L7022
6983  142f               L5122:
6984                     ; 2062     else Relays_8to1 |= (uint8_t)0x02; // Relay-02 ON
6986  142f 72120000      	bset	_Relays_8to1,#1
6987  1433 cc151f        	jra	L7022
6988  1436               L7212:
6989                     ; 2064   case 2:
6989                     ; 2065     if (nState == 0) Relays_8to1 &= (uint8_t)(~0x04); // Relay-03 OFF
6991  1436 7b02          	ld	a,(OFST+2,sp)
6992  1438 2607          	jrne	L1222
6995  143a 72150000      	bres	_Relays_8to1,#2
6997  143e cc151f        	jra	L7022
6998  1441               L1222:
6999                     ; 2066     else Relays_8to1 |= (uint8_t)0x04; // Relay-03 ON
7001  1441 72140000      	bset	_Relays_8to1,#2
7002  1445 cc151f        	jra	L7022
7003  1448               L1312:
7004                     ; 2068   case 3:
7004                     ; 2069     if (nState == 0) Relays_8to1 &= (uint8_t)(~0x08); // Relay-04 OFF
7006  1448 7b02          	ld	a,(OFST+2,sp)
7007  144a 2607          	jrne	L5222
7010  144c 72170000      	bres	_Relays_8to1,#3
7012  1450 cc151f        	jra	L7022
7013  1453               L5222:
7014                     ; 2070     else Relays_8to1 |= (uint8_t)0x08; // Relay-04 ON
7016  1453 72160000      	bset	_Relays_8to1,#3
7017  1457 cc151f        	jra	L7022
7018  145a               L3312:
7019                     ; 2072   case 4:
7019                     ; 2073     if (nState == 0) Relays_8to1 &= (uint8_t)(~0x10); // Relay-05 OFF
7021  145a 7b02          	ld	a,(OFST+2,sp)
7022  145c 2607          	jrne	L1322
7025  145e 72190000      	bres	_Relays_8to1,#4
7027  1462 cc151f        	jra	L7022
7028  1465               L1322:
7029                     ; 2074     else Relays_8to1 |= (uint8_t)0x10; // Relay-05 ON
7031  1465 72180000      	bset	_Relays_8to1,#4
7032  1469 cc151f        	jra	L7022
7033  146c               L5312:
7034                     ; 2076   case 5:
7034                     ; 2077     if (nState == 0) Relays_8to1 &= (uint8_t)(~0x20); // Relay-06 OFF
7036  146c 7b02          	ld	a,(OFST+2,sp)
7037  146e 2607          	jrne	L5322
7040  1470 721b0000      	bres	_Relays_8to1,#5
7042  1474 cc151f        	jra	L7022
7043  1477               L5322:
7044                     ; 2078     else Relays_8to1 |= (uint8_t)0x20; // Relay-06 ON
7046  1477 721a0000      	bset	_Relays_8to1,#5
7047  147b cc151f        	jra	L7022
7048  147e               L7312:
7049                     ; 2080   case 6:
7049                     ; 2081     if (nState == 0) Relays_8to1 &= (uint8_t)(~0x40); // Relay-07 OFF
7051  147e 7b02          	ld	a,(OFST+2,sp)
7052  1480 2607          	jrne	L1422
7055  1482 721d0000      	bres	_Relays_8to1,#6
7057  1486 cc151f        	jra	L7022
7058  1489               L1422:
7059                     ; 2082     else Relays_8to1 |= (uint8_t)0x40; // Relay-07 ON
7061  1489 721c0000      	bset	_Relays_8to1,#6
7062  148d cc151f        	jra	L7022
7063  1490               L1412:
7064                     ; 2084   case 7:
7064                     ; 2085     if (nState == 0) Relays_8to1 &= (uint8_t)(~0x80); // Relay-08 OFF
7066  1490 7b02          	ld	a,(OFST+2,sp)
7067  1492 2607          	jrne	L5422
7070  1494 721f0000      	bres	_Relays_8to1,#7
7072  1498 cc151f        	jra	L7022
7073  149b               L5422:
7074                     ; 2086     else Relays_8to1 |= (uint8_t)0x80; // Relay-08 ON
7076  149b 721e0000      	bset	_Relays_8to1,#7
7077  149f 207e          	jra	L7022
7078  14a1               L3412:
7079                     ; 2088   case 8:
7079                     ; 2089     if (nState == 0) Relays_16to9 &= (uint8_t)(~0x01); // Relay-09 OFF
7081  14a1 7b02          	ld	a,(OFST+2,sp)
7082  14a3 2606          	jrne	L1522
7085  14a5 72110000      	bres	_Relays_16to9,#0
7087  14a9 2074          	jra	L7022
7088  14ab               L1522:
7089                     ; 2090     else Relays_16to9 |= (uint8_t)0x01; // Relay-09 ON
7091  14ab 72100000      	bset	_Relays_16to9,#0
7092  14af 206e          	jra	L7022
7093  14b1               L5412:
7094                     ; 2092   case 9:
7094                     ; 2093     if (nState == 0) Relays_16to9 &= (uint8_t)(~0x02); // Relay-10 OFF
7096  14b1 7b02          	ld	a,(OFST+2,sp)
7097  14b3 2606          	jrne	L5522
7100  14b5 72130000      	bres	_Relays_16to9,#1
7102  14b9 2064          	jra	L7022
7103  14bb               L5522:
7104                     ; 2094     else Relays_16to9 |= (uint8_t)0x02; // Relay-10 ON
7106  14bb 72120000      	bset	_Relays_16to9,#1
7107  14bf 205e          	jra	L7022
7108  14c1               L7412:
7109                     ; 2096   case 10:
7109                     ; 2097     if (nState == 0) Relays_16to9 &= (uint8_t)(~0x04); // Relay-11 OFF
7111  14c1 7b02          	ld	a,(OFST+2,sp)
7112  14c3 2606          	jrne	L1622
7115  14c5 72150000      	bres	_Relays_16to9,#2
7117  14c9 2054          	jra	L7022
7118  14cb               L1622:
7119                     ; 2098     else Relays_16to9 |= (uint8_t)0x04; // Relay-11 ON
7121  14cb 72140000      	bset	_Relays_16to9,#2
7122  14cf 204e          	jra	L7022
7123  14d1               L1512:
7124                     ; 2100   case 11:
7124                     ; 2101     if (nState == 0) Relays_16to9 &= (uint8_t)(~0x08); // Relay-12 OFF
7126  14d1 7b02          	ld	a,(OFST+2,sp)
7127  14d3 2606          	jrne	L5622
7130  14d5 72170000      	bres	_Relays_16to9,#3
7132  14d9 2044          	jra	L7022
7133  14db               L5622:
7134                     ; 2102     else Relays_16to9 |= (uint8_t)0x08; // Relay-12 ON
7136  14db 72160000      	bset	_Relays_16to9,#3
7137  14df 203e          	jra	L7022
7138  14e1               L3512:
7139                     ; 2104   case 12:
7139                     ; 2105     if (nState == 0) Relays_16to9 &= (uint8_t)(~0x10); // Relay-13 OFF
7141  14e1 7b02          	ld	a,(OFST+2,sp)
7142  14e3 2606          	jrne	L1722
7145  14e5 72190000      	bres	_Relays_16to9,#4
7147  14e9 2034          	jra	L7022
7148  14eb               L1722:
7149                     ; 2106     else Relays_16to9 |= (uint8_t)0x10; // Relay-13 ON
7151  14eb 72180000      	bset	_Relays_16to9,#4
7152  14ef 202e          	jra	L7022
7153  14f1               L5512:
7154                     ; 2108   case 13:
7154                     ; 2109     if (nState == 0) Relays_16to9 &= (uint8_t)(~0x20); // Relay-14 OFF
7156  14f1 7b02          	ld	a,(OFST+2,sp)
7157  14f3 2606          	jrne	L5722
7160  14f5 721b0000      	bres	_Relays_16to9,#5
7162  14f9 2024          	jra	L7022
7163  14fb               L5722:
7164                     ; 2110     else Relays_16to9 |= (uint8_t)0x20; // Relay-14 ON
7166  14fb 721a0000      	bset	_Relays_16to9,#5
7167  14ff 201e          	jra	L7022
7168  1501               L7512:
7169                     ; 2112   case 14:
7169                     ; 2113     if (nState == 0) Relays_16to9 &= (uint8_t)(~0x40); // Relay-15 OFF
7171  1501 7b02          	ld	a,(OFST+2,sp)
7172  1503 2606          	jrne	L1032
7175  1505 721d0000      	bres	_Relays_16to9,#6
7177  1509 2014          	jra	L7022
7178  150b               L1032:
7179                     ; 2114     else Relays_16to9 |= (uint8_t)0x40; // Relay-15 ON
7181  150b 721c0000      	bset	_Relays_16to9,#6
7182  150f 200e          	jra	L7022
7183  1511               L1612:
7184                     ; 2116   case 15:
7184                     ; 2117     if (nState == 0) Relays_16to9 &= (uint8_t)(~0x80); // Relay-16 OFF
7186  1511 7b02          	ld	a,(OFST+2,sp)
7187  1513 2606          	jrne	L5032
7190  1515 721f0000      	bres	_Relays_16to9,#7
7192  1519 2004          	jra	L7022
7193  151b               L5032:
7194                     ; 2118     else Relays_16to9 |= (uint8_t)0x80; // Relay-16 ON
7196  151b 721e0000      	bset	_Relays_16to9,#7
7197                     ; 2120   default: break;
7199  151f               L7022:
7200                     ; 2122 }
7203  151f 85            	popw	x
7204  1520 81            	ret	
7294                     	switch	.const
7295  3d82               L043:
7296  3d82 1556          	dc.w	L1132
7297  3d84 155d          	dc.w	L3132
7298  3d86 1564          	dc.w	L5132
7299  3d88 156b          	dc.w	L7132
7300  3d8a 1572          	dc.w	L1232
7301  3d8c 1579          	dc.w	L3232
7302  3d8e 1580          	dc.w	L5232
7303  3d90 1587          	dc.w	L7232
7304  3d92 158e          	dc.w	L1332
7305  3d94 1595          	dc.w	L3332
7306  3d96 159c          	dc.w	L5332
7307  3d98 15a3          	dc.w	L7332
7308                     ; 2125 void SetAddresses(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
7308                     ; 2126 {
7309                     	switch	.text
7310  1521               _SetAddresses:
7312  1521 89            	pushw	x
7313  1522 5207          	subw	sp,#7
7314       00000007      OFST:	set	7
7317                     ; 2139   temp = 0;
7319                     ; 2140   invalid = 0;
7321  1524 0f01          	clr	(OFST-6,sp)
7323                     ; 2143   str[0] = (uint8_t)alpha1;
7325  1526 9f            	ld	a,xl
7326  1527 6b02          	ld	(OFST-5,sp),a
7328                     ; 2144   str[1] = (uint8_t)alpha2;
7330  1529 7b0c          	ld	a,(OFST+5,sp)
7331  152b 6b03          	ld	(OFST-4,sp),a
7333                     ; 2145   str[2] = (uint8_t)alpha3;
7335  152d 7b0d          	ld	a,(OFST+6,sp)
7336  152f 6b04          	ld	(OFST-3,sp),a
7338                     ; 2146   str[3] = 0;
7340  1531 0f05          	clr	(OFST-2,sp)
7342                     ; 2147   temp = atoi(str);
7344  1533 96            	ldw	x,sp
7345  1534 1c0002        	addw	x,#OFST-5
7346  1537 cd0000        	call	_atoi
7348  153a 1f06          	ldw	(OFST-1,sp),x
7350                     ; 2148   if (temp > 255) invalid = 1; // If an invalid entry set indicator
7352  153c a30100        	cpw	x,#256
7353  153f 2504          	jrult	L5732
7356  1541 a601          	ld	a,#1
7357  1543 6b01          	ld	(OFST-6,sp),a
7359  1545               L5732:
7360                     ; 2150   if (invalid == 0) { // Make change only if valid entry
7362  1545 7b01          	ld	a,(OFST-6,sp)
7363  1547 265f          	jrne	L7732
7364                     ; 2151     switch(itemnum)
7366  1549 7b08          	ld	a,(OFST+1,sp)
7368                     ; 2165     default: break;
7369  154b a10c          	cp	a,#12
7370  154d 2459          	jruge	L7732
7371  154f 5f            	clrw	x
7372  1550 97            	ld	xl,a
7373  1551 58            	sllw	x
7374  1552 de3d82        	ldw	x,(L043,x)
7375  1555 fc            	jp	(x)
7376  1556               L1132:
7377                     ; 2153     case 0:  Pending_hostaddr4 = (uint8_t)temp; break;
7379  1556 7b07          	ld	a,(OFST+0,sp)
7380  1558 c70000        	ld	_Pending_hostaddr4,a
7383  155b 204b          	jra	L7732
7384  155d               L3132:
7385                     ; 2154     case 1:  Pending_hostaddr3 = (uint8_t)temp; break;
7387  155d 7b07          	ld	a,(OFST+0,sp)
7388  155f c70000        	ld	_Pending_hostaddr3,a
7391  1562 2044          	jra	L7732
7392  1564               L5132:
7393                     ; 2155     case 2:  Pending_hostaddr2 = (uint8_t)temp; break;
7395  1564 7b07          	ld	a,(OFST+0,sp)
7396  1566 c70000        	ld	_Pending_hostaddr2,a
7399  1569 203d          	jra	L7732
7400  156b               L7132:
7401                     ; 2156     case 3:  Pending_hostaddr1 = (uint8_t)temp; break;
7403  156b 7b07          	ld	a,(OFST+0,sp)
7404  156d c70000        	ld	_Pending_hostaddr1,a
7407  1570 2036          	jra	L7732
7408  1572               L1232:
7409                     ; 2157     case 4:  Pending_draddr4 = (uint8_t)temp; break;
7411  1572 7b07          	ld	a,(OFST+0,sp)
7412  1574 c70000        	ld	_Pending_draddr4,a
7415  1577 202f          	jra	L7732
7416  1579               L3232:
7417                     ; 2158     case 5:  Pending_draddr3 = (uint8_t)temp; break;
7419  1579 7b07          	ld	a,(OFST+0,sp)
7420  157b c70000        	ld	_Pending_draddr3,a
7423  157e 2028          	jra	L7732
7424  1580               L5232:
7425                     ; 2159     case 6:  Pending_draddr2 = (uint8_t)temp; break;
7427  1580 7b07          	ld	a,(OFST+0,sp)
7428  1582 c70000        	ld	_Pending_draddr2,a
7431  1585 2021          	jra	L7732
7432  1587               L7232:
7433                     ; 2160     case 7:  Pending_draddr1 = (uint8_t)temp; break;
7435  1587 7b07          	ld	a,(OFST+0,sp)
7436  1589 c70000        	ld	_Pending_draddr1,a
7439  158c 201a          	jra	L7732
7440  158e               L1332:
7441                     ; 2161     case 8:  Pending_netmask4 = (uint8_t)temp; break;
7443  158e 7b07          	ld	a,(OFST+0,sp)
7444  1590 c70000        	ld	_Pending_netmask4,a
7447  1593 2013          	jra	L7732
7448  1595               L3332:
7449                     ; 2162     case 9:  Pending_netmask3 = (uint8_t)temp; break;
7451  1595 7b07          	ld	a,(OFST+0,sp)
7452  1597 c70000        	ld	_Pending_netmask3,a
7455  159a 200c          	jra	L7732
7456  159c               L5332:
7457                     ; 2163     case 10: Pending_netmask2 = (uint8_t)temp; break;
7459  159c 7b07          	ld	a,(OFST+0,sp)
7460  159e c70000        	ld	_Pending_netmask2,a
7463  15a1 2005          	jra	L7732
7464  15a3               L7332:
7465                     ; 2164     case 11: Pending_netmask1 = (uint8_t)temp; break;
7467  15a3 7b07          	ld	a,(OFST+0,sp)
7468  15a5 c70000        	ld	_Pending_netmask1,a
7471                     ; 2165     default: break;
7473  15a8               L7732:
7474                     ; 2168 }
7477  15a8 5b09          	addw	sp,#9
7478  15aa 81            	ret	
7571                     ; 2171 void SetPort(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3, uint8_t alpha4, uint8_t alpha5)
7571                     ; 2172 {
7572                     	switch	.text
7573  15ab               _SetPort:
7575  15ab 89            	pushw	x
7576  15ac 5209          	subw	sp,#9
7577       00000009      OFST:	set	9
7580                     ; 2185   temp = 0;
7582  15ae 5f            	clrw	x
7583  15af 1f01          	ldw	(OFST-8,sp),x
7585                     ; 2186   invalid = 0;
7587  15b1 0f03          	clr	(OFST-6,sp)
7589                     ; 2189   if (alpha1 > '6') invalid = 1;
7591  15b3 7b0b          	ld	a,(OFST+2,sp)
7592  15b5 a137          	cp	a,#55
7593  15b7 2506          	jrult	L3442
7596  15b9 a601          	ld	a,#1
7597  15bb 6b03          	ld	(OFST-6,sp),a
7600  15bd 201d          	jra	L5442
7601  15bf               L3442:
7602                     ; 2191     str[0] = (uint8_t)alpha1;
7604  15bf 6b04          	ld	(OFST-5,sp),a
7606                     ; 2192     str[1] = (uint8_t)alpha2;
7608  15c1 7b0e          	ld	a,(OFST+5,sp)
7609  15c3 6b05          	ld	(OFST-4,sp),a
7611                     ; 2193     str[2] = (uint8_t)alpha3;
7613  15c5 7b0f          	ld	a,(OFST+6,sp)
7614  15c7 6b06          	ld	(OFST-3,sp),a
7616                     ; 2194     str[3] = (uint8_t)alpha4;
7618  15c9 7b10          	ld	a,(OFST+7,sp)
7619  15cb 6b07          	ld	(OFST-2,sp),a
7621                     ; 2195     str[4] = (uint8_t)alpha5;
7623  15cd 7b11          	ld	a,(OFST+8,sp)
7624  15cf 6b08          	ld	(OFST-1,sp),a
7626                     ; 2196     str[5] = 0;
7628  15d1 0f09          	clr	(OFST+0,sp)
7630                     ; 2197     temp = atoi(str);
7632  15d3 96            	ldw	x,sp
7633  15d4 1c0004        	addw	x,#OFST-5
7634  15d7 cd0000        	call	_atoi
7636  15da 1f01          	ldw	(OFST-8,sp),x
7638  15dc               L5442:
7639                     ; 2200   if (temp < 10) invalid = 1;
7641  15dc a3000a        	cpw	x,#10
7642  15df 2404          	jruge	L7442
7645  15e1 a601          	ld	a,#1
7646  15e3 6b03          	ld	(OFST-6,sp),a
7648  15e5               L7442:
7649                     ; 2202   if (invalid == 0) { // Make change only if valid entry
7651  15e5 7b03          	ld	a,(OFST-6,sp)
7652  15e7 2603          	jrne	L1542
7653                     ; 2203     Pending_port = (uint16_t)temp;
7655  15e9 cf0000        	ldw	_Pending_port,x
7656  15ec               L1542:
7657                     ; 2205 }
7660  15ec 5b0b          	addw	sp,#11
7661  15ee 81            	ret	
7727                     ; 2208 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7727                     ; 2209 {
7728                     	switch	.text
7729  15ef               _SetMAC:
7731  15ef 89            	pushw	x
7732  15f0 5203          	subw	sp,#3
7733       00000003      OFST:	set	3
7736                     ; 2221   temp = 0;
7738                     ; 2222   invalid = 0;
7740  15f2 0f01          	clr	(OFST-2,sp)
7742                     ; 2225   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7744  15f4 9f            	ld	a,xl
7745  15f5 a130          	cp	a,#48
7746  15f7 250b          	jrult	L5152
7748  15f9 9f            	ld	a,xl
7749  15fa a13a          	cp	a,#58
7750  15fc 2406          	jruge	L5152
7753  15fe 7b05          	ld	a,(OFST+2,sp)
7754  1600 a030          	sub	a,#48
7756  1602 200c          	jp	LC029
7757  1604               L5152:
7758                     ; 2226   else if (alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7760  1604 7b05          	ld	a,(OFST+2,sp)
7761  1606 a161          	cp	a,#97
7762  1608 250a          	jrult	L1252
7764  160a a167          	cp	a,#103
7765  160c 2406          	jruge	L1252
7768  160e a057          	sub	a,#87
7769  1610               LC029:
7770  1610 6b05          	ld	(OFST+2,sp),a
7772  1612 2004          	jra	L7152
7773  1614               L1252:
7774                     ; 2227   else invalid = 1; // If an invalid entry set indicator
7776  1614 a601          	ld	a,#1
7777  1616 6b01          	ld	(OFST-2,sp),a
7779  1618               L7152:
7780                     ; 2229   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7782  1618 7b08          	ld	a,(OFST+5,sp)
7783  161a a130          	cp	a,#48
7784  161c 2508          	jrult	L5252
7786  161e a13a          	cp	a,#58
7787  1620 2404          	jruge	L5252
7790  1622 a030          	sub	a,#48
7792  1624 200a          	jp	LC030
7793  1626               L5252:
7794                     ; 2230   else if (alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7796  1626 a161          	cp	a,#97
7797  1628 250a          	jrult	L1352
7799  162a a167          	cp	a,#103
7800  162c 2406          	jruge	L1352
7803  162e a057          	sub	a,#87
7804  1630               LC030:
7805  1630 6b08          	ld	(OFST+5,sp),a
7807  1632 2004          	jra	L7252
7808  1634               L1352:
7809                     ; 2231   else invalid = 1; // If an invalid entry set indicator
7811  1634 a601          	ld	a,#1
7812  1636 6b01          	ld	(OFST-2,sp),a
7814  1638               L7252:
7815                     ; 2233   if (invalid == 0) { // Change value only if valid entry
7817  1638 7b01          	ld	a,(OFST-2,sp)
7818  163a 264a          	jrne	L5352
7819                     ; 2234     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7821  163c 7b05          	ld	a,(OFST+2,sp)
7822  163e 97            	ld	xl,a
7823  163f a610          	ld	a,#16
7824  1641 42            	mul	x,a
7825  1642 01            	rrwa	x,a
7826  1643 1b08          	add	a,(OFST+5,sp)
7827  1645 5f            	clrw	x
7828  1646 97            	ld	xl,a
7829  1647 1f02          	ldw	(OFST-1,sp),x
7831                     ; 2235     switch(itemnum)
7833  1649 7b04          	ld	a,(OFST+1,sp)
7835                     ; 2243     default: break;
7836  164b 2711          	jreq	L3542
7837  164d 4a            	dec	a
7838  164e 2715          	jreq	L5542
7839  1650 4a            	dec	a
7840  1651 2719          	jreq	L7542
7841  1653 4a            	dec	a
7842  1654 271d          	jreq	L1642
7843  1656 4a            	dec	a
7844  1657 2721          	jreq	L3642
7845  1659 4a            	dec	a
7846  165a 2725          	jreq	L5642
7847  165c 2028          	jra	L5352
7848  165e               L3542:
7849                     ; 2237     case 0: Pending_uip_ethaddr1 = (uint8_t)temp; break;
7851  165e 7b03          	ld	a,(OFST+0,sp)
7852  1660 c70000        	ld	_Pending_uip_ethaddr1,a
7855  1663 2021          	jra	L5352
7856  1665               L5542:
7857                     ; 2238     case 1: Pending_uip_ethaddr2 = (uint8_t)temp; break;
7859  1665 7b03          	ld	a,(OFST+0,sp)
7860  1667 c70000        	ld	_Pending_uip_ethaddr2,a
7863  166a 201a          	jra	L5352
7864  166c               L7542:
7865                     ; 2239     case 2: Pending_uip_ethaddr3 = (uint8_t)temp; break;
7867  166c 7b03          	ld	a,(OFST+0,sp)
7868  166e c70000        	ld	_Pending_uip_ethaddr3,a
7871  1671 2013          	jra	L5352
7872  1673               L1642:
7873                     ; 2240     case 3: Pending_uip_ethaddr4 = (uint8_t)temp; break;
7875  1673 7b03          	ld	a,(OFST+0,sp)
7876  1675 c70000        	ld	_Pending_uip_ethaddr4,a
7879  1678 200c          	jra	L5352
7880  167a               L3642:
7881                     ; 2241     case 4: Pending_uip_ethaddr5 = (uint8_t)temp; break;
7883  167a 7b03          	ld	a,(OFST+0,sp)
7884  167c c70000        	ld	_Pending_uip_ethaddr5,a
7887  167f 2005          	jra	L5352
7888  1681               L5642:
7889                     ; 2242     case 5: Pending_uip_ethaddr6 = (uint8_t)temp; break;
7891  1681 7b03          	ld	a,(OFST+0,sp)
7892  1683 c70000        	ld	_Pending_uip_ethaddr6,a
7895                     ; 2243     default: break;
7897  1686               L5352:
7898                     ; 2246 }
7901  1686 5b05          	addw	sp,#5
7902  1688 81            	ret	
8004                     	switch	.bss
8005  0000               _OctetArray:
8006  0000 000000000000  	ds.b	11
8007                     	xdef	_OctetArray
8008                     	xref	_submit_changes
8009                     	xref	_ex_stored_devicename
8010                     	xref	_uip_ethaddr6
8011                     	xref	_uip_ethaddr5
8012                     	xref	_uip_ethaddr4
8013                     	xref	_uip_ethaddr3
8014                     	xref	_uip_ethaddr2
8015                     	xref	_uip_ethaddr1
8016                     	xref	_ex_stored_port
8017                     	xref	_ex_stored_netmask1
8018                     	xref	_ex_stored_netmask2
8019                     	xref	_ex_stored_netmask3
8020                     	xref	_ex_stored_netmask4
8021                     	xref	_ex_stored_draddr1
8022                     	xref	_ex_stored_draddr2
8023                     	xref	_ex_stored_draddr3
8024                     	xref	_ex_stored_draddr4
8025                     	xref	_ex_stored_hostaddr1
8026                     	xref	_ex_stored_hostaddr2
8027                     	xref	_ex_stored_hostaddr3
8028                     	xref	_ex_stored_hostaddr4
8029                     	xref	_Pending_uip_ethaddr6
8030                     	xref	_Pending_uip_ethaddr5
8031                     	xref	_Pending_uip_ethaddr4
8032                     	xref	_Pending_uip_ethaddr3
8033                     	xref	_Pending_uip_ethaddr2
8034                     	xref	_Pending_uip_ethaddr1
8035                     	xref	_Pending_port
8036                     	xref	_Pending_netmask1
8037                     	xref	_Pending_netmask2
8038                     	xref	_Pending_netmask3
8039                     	xref	_Pending_netmask4
8040                     	xref	_Pending_draddr1
8041                     	xref	_Pending_draddr2
8042                     	xref	_Pending_draddr3
8043                     	xref	_Pending_draddr4
8044                     	xref	_Pending_hostaddr1
8045                     	xref	_Pending_hostaddr2
8046                     	xref	_Pending_hostaddr3
8047                     	xref	_Pending_hostaddr4
8048                     	xref	_invert_output
8049                     	xref	_Relays_8to1
8050                     	xref	_Relays_16to9
8051                     	xref	_Port_Httpd
8052  000b               _current_webpage:
8053  000b 00            	ds.b	1
8054                     	xdef	_current_webpage
8055                     	xref	_atoi
8056                     	xref	_debugflash
8057                     	xref	_uip_flags
8058                     	xref	_uip_stat
8059                     	xref	_uip_conn
8060                     	xref	_uip_appdata
8061                     	xref	_htons
8062                     	xref	_uip_send
8063                     	xref	_uip_listen
8064                     	xref	_uip_init_stats
8065                     	xdef	_SetMAC
8066                     	xdef	_SetPort
8067                     	xdef	_SetAddresses
8068                     	xdef	_GpioSetPin
8069                     	xdef	_GpioGetPin
8070                     	xdef	_HttpDCall
8071                     	xdef	_HttpDInit
8072                     	xdef	_reverse
8073                     	xdef	_emb_itoa
8074                     	xdef	_two_alpha_to_uint
8075                     	xdef	_three_alpha_to_uint
8076                     	switch	.const
8077  3d9a               L714:
8078  3d9a 436f6e6e6563  	dc.b	"Connection:close",13
8079  3dab 0a00          	dc.b	10,0
8080  3dad               L514:
8081  3dad 436f6e74656e  	dc.b	"Content-Type:text/"
8082  3dbf 68746d6c0d    	dc.b	"html",13
8083  3dc4 0a00          	dc.b	10,0
8084  3dc6               L314:
8085  3dc6 436f6e74656e  	dc.b	"Content-Length:",0
8086  3dd6               L114:
8087  3dd6 0d0a00        	dc.b	13,10,0
8088  3dd9               L704:
8089  3dd9 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8090                     	xref.b	c_lreg
8091                     	xref.b	c_x
8092                     	xref.b	c_y
8112                     	xref	c_uitolx
8113                     	xref	c_ludv
8114                     	xref	c_lumd
8115                     	xref	c_rtol
8116                     	xref	c_ltor
8117                     	xref	c_lzmp
8118                     	end
