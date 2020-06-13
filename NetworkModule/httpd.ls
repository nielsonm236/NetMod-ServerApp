   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  17                     .const:	section	.text
  18  0000               L31_checked:
  19  0000 636865636b65  	dc.b	"checked",0
  20  0008               L51_g_HtmlPageDefault:
  21  0008 3c21444f4354  	dc.b	"<!DOCTYPE HTML PUB"
  22  001a 4c49432022    	dc.b	"LIC ",34
  23  001f 2d2f2f573343  	dc.b	"-//W3C//DTD HTML 4"
  24  0031 2e3031205472  	dc.b	".01 Transitional//"
  25  0043 454e22        	dc.b	"EN",34
  26  0046 3e3c68746d6c  	dc.b	"><html><head><titl"
  27  0058 653e52656c61  	dc.b	"e>Relay Control</t"
  28  006a 69746c653e3c  	dc.b	"itle><style type='"
  29  007c 746578742f63  	dc.b	"text/css'>.s0 { ba"
  30  008e 636b67726f75  	dc.b	"ckground-color: re"
  31  00a0 643b207d2e73  	dc.b	"d; }.s1 { backgrou"
  32  00b2 6e642d636f6c  	dc.b	"nd-color: green; }"
  33  00c4 7464207b2074  	dc.b	"td { text-align: c"
  34  00d6 656e7465723b  	dc.b	"enter; }.tclass { "
  35  00e8 77696474683a  	dc.b	"width: 145px; }</s"
  36  00fa 74796c653e3c  	dc.b	"tyle></head><"
  37  0107 626f64793e3c  	dc.b	"body><h1>Relay Con"
  38  0119 74726f6c3c2f  	dc.b	"trol</h1><form met"
  39  012b 686f643d2750  	dc.b	"hod='POST' action="
  40  013d 272f273e3c74  	dc.b	"'/'><table border="
  41  014f 27317078273e  	dc.b	"'1px'><colgroup><c"
  42  0161 6f6c20776964  	dc.b	"ol width='100px'><"
  43  0173 636f6c207769  	dc.b	"col width='152px'>"
  44  0185 3c2f636f6c67  	dc.b	"</colgroup><tr><td"
  45  0197 3e4e616d653a  	dc.b	">Name:</td><td><in"
  46  01a9 707574207479  	dc.b	"put type='text' na"
  47  01bb 6d653d276130  	dc.b	"me='a00' class='tc"
  48  01cd 6c6173732720  	dc.b	"lass' value='%a00x"
  49  01df 787878787878  	dc.b	"xxxxxxxxxxxxxxxxxx"
  50  01f1 782720706174  	dc.b	"x' pattern='[0-9a-"
  51  0203 7a412d        	dc.b	"zA-"
  52  0206 5a2d5f2a2e5d  	dc.b	"Z-_*.]{1,20}' titl"
  53  0218 653d27312074  	dc.b	"e='1 to 20 letters"
  54  022a 2c206e756d62  	dc.b	", numbers, and -_*"
  55  023c 2e206e6f2073  	dc.b	". no spaces' maxle"
  56  024e 6e6774683d27  	dc.b	"ngth='20' size='20"
  57  0260 273e3c2f7464  	dc.b	"'></td></tr></tabl"
  58  0272 653e3c746162  	dc.b	"e><table border='1"
  59  0284 7078273e3c63  	dc.b	"px'><colgroup><col"
  60  0296 207769647468  	dc.b	" width='100px'><co"
  61  02a8 6c2077696474  	dc.b	"l width='30px'><co"
  62  02ba 6c2077696474  	dc.b	"l width='120px'></"
  63  02cc 636f6c67726f  	dc.b	"colgroup><tr><td><"
  64  02de 2f74643e3c74  	dc.b	"/td><td></td><td>S"
  65  02f0 45543c2f7464  	dc.b	"ET</td></tr><tr><t"
  66  0302 643e52        	dc.b	"d>R"
  67  0305 656c61793031  	dc.b	"elay01</td><td cla"
  68  0317 73733d277325  	dc.b	"ss='s%i00'></td><t"
  69  0329 643e3c696e70  	dc.b	"d><input type='rad"
  70  033b 696f27206964  	dc.b	"io' id='relay01on'"
  71  034d 206e616d653d  	dc.b	" name='o00' value="
  72  035f 27312720256f  	dc.b	"'1' %o00><label fo"
  73  0371 723d2772656c  	dc.b	"r='relay01on'>ON</"
  74  0383 6c6162656c3e  	dc.b	"label><input type="
  75  0395 27726164696f  	dc.b	"'radio' id='relay0"
  76  03a7 316f66662720  	dc.b	"1off' name='o00' v"
  77  03b9 616c75653d27  	dc.b	"alue='0' %p00><lab"
  78  03cb 656c20666f72  	dc.b	"el for='relay01off"
  79  03dd 273e4f46463c  	dc.b	"'>OFF</label></td>"
  80  03ef 3c2f74723e3c  	dc.b	"</tr><tr><td>Relay"
  81  0401 30323c        	dc.b	"02<"
  82  0404 2f74643e3c74  	dc.b	"/td><td class='s%i"
  83  0416 3031273e3c2f  	dc.b	"01'></td><td><inpu"
  84  0428 742074797065  	dc.b	"t type='radio' id="
  85  043a 2772656c6179  	dc.b	"'relay02on' name='"
  86  044c 6f3031272076  	dc.b	"o01' value='1' %o0"
  87  045e 313e3c6c6162  	dc.b	"1><label for='rela"
  88  0470 7930326f6e27  	dc.b	"y02on'>ON</label><"
  89  0482 696e70757420  	dc.b	"input type='radio'"
  90  0494 2069643d2772  	dc.b	" id='relay02off' n"
  91  04a6 616d653d276f  	dc.b	"ame='o01' value='0"
  92  04b8 272025703031  	dc.b	"' %p01><label for="
  93  04ca 2772656c6179  	dc.b	"'relay02off'>OFF</"
  94  04dc 6c6162656c3e  	dc.b	"label></td></tr><t"
  95  04ee 723e3c74643e  	dc.b	"r><td>Relay03</td>"
  96  0500 3c7464        	dc.b	"<td"
  97  0503 20636c617373  	dc.b	" class='s%i02'></t"
  98  0515 643e3c74643e  	dc.b	"d><td><input type="
  99  0527 27726164696f  	dc.b	"'radio' id='relay0"
 100  0539 336f6e27206e  	dc.b	"3on' name='o02' va"
 101  054b 6c75653d2731  	dc.b	"lue='1' %o02><labe"
 102  055d 6c20666f723d  	dc.b	"l for='relay03on'>"
 103  056f 4f4e3c2f6c61  	dc.b	"ON</label><input t"
 104  0581 7970653d2772  	dc.b	"ype='radio' id='re"
 105  0593 6c617930336f  	dc.b	"lay03off' name='o0"
 106  05a5 32272076616c  	dc.b	"2' value='0' %p02>"
 107  05b7 3c6c6162656c  	dc.b	"<label for='relay0"
 108  05c9 336f6666273e  	dc.b	"3off'>OFF</label><"
 109  05db 2f74643e3c2f  	dc.b	"/td></tr><tr><td>R"
 110  05ed 656c61793034  	dc.b	"elay04</td><td cla"
 111  05ff 73733d        	dc.b	"ss="
 112  0602 277325693033  	dc.b	"'s%i03'></td><td><"
 113  0614 696e70757420  	dc.b	"input type='radio'"
 114  0626 2069643d2772  	dc.b	" id='relay04on' na"
 115  0638 6d653d276f30  	dc.b	"me='o03' value='1'"
 116  064a 20256f30333e  	dc.b	" %o03><label for='"
 117  065c 72656c617930  	dc.b	"relay04on'>ON</lab"
 118  066e 656c3e3c696e  	dc.b	"el><input type='ra"
 119  0680 64696f272069  	dc.b	"dio' id='relay04of"
 120  0692 6627206e616d  	dc.b	"f' name='o03' valu"
 121  06a4 653d27302720  	dc.b	"e='0' %p03><label "
 122  06b6 666f723d2772  	dc.b	"for='relay04off'>O"
 123  06c8 46463c2f6c61  	dc.b	"FF</label></td></t"
 124  06da 723e3c74723e  	dc.b	"r><tr><td>Relay05<"
 125  06ec 2f74643e3c74  	dc.b	"/td><td class='s%i"
 126  06fe 303427        	dc.b	"04'"
 127  0701 3e3c2f74643e  	dc.b	"></td><td><input t"
 128  0713 7970653d2772  	dc.b	"ype='radio' id='re"
 129  0725 6c617930356f  	dc.b	"lay05on' name='o04"
 130  0737 272076616c75  	dc.b	"' value='1' %o04><"
 131  0749 6c6162656c20  	dc.b	"label for='relay05"
 132  075b 6f6e273e4f4e  	dc.b	"on'>ON</label><inp"
 133  076d 757420747970  	dc.b	"ut type='radio' id"
 134  077f 3d2772656c61  	dc.b	"='relay05off' name"
 135  0791 3d276f303427  	dc.b	"='o04' value='0' %"
 136  07a3 7030343e3c6c  	dc.b	"p04><label for='re"
 137  07b5 6c617930356f  	dc.b	"lay05off'>OFF</lab"
 138  07c7 656c3e3c2f74  	dc.b	"el></td></tr><tr><"
 139  07d9 74643e52656c  	dc.b	"td>Relay06</td><td"
 140  07eb 20636c617373  	dc.b	" class='s%i05'></t"
 141  07fd 643e3c        	dc.b	"d><"
 142  0800 74643e3c696e  	dc.b	"td><input type='ra"
 143  0812 64696f272069  	dc.b	"dio' id='relay06on"
 144  0824 27206e616d65  	dc.b	"' name='o05' value"
 145  0836 3d2731272025  	dc.b	"='1' %o05><label f"
 146  0848 6f723d277265  	dc.b	"or='relay06on'>ON<"
 147  085a 2f6c6162656c  	dc.b	"/label><input type"
 148  086c 3d2772616469  	dc.b	"='radio' id='relay"
 149  087e 30366f666627  	dc.b	"06off' name='o05' "
 150  0890 76616c75653d  	dc.b	"value='0' %p05><la"
 151  08a2 62656c20666f  	dc.b	"bel for='relay06of"
 152  08b4 66273e4f4646  	dc.b	"f'>OFF</label></td"
 153  08c6 3e3c2f74723e  	dc.b	"></tr><tr><td>Rela"
 154  08d8 7930373c2f74  	dc.b	"y07</td><td class="
 155  08ea 277325693036  	dc.b	"'s%i06'></td><td><"
 156  08fc 696e70        	dc.b	"inp"
 157  08ff 757420747970  	dc.b	"ut type='radio' id"
 158  0911 3d2772656c61  	dc.b	"='relay07on' name="
 159  0923 276f30362720  	dc.b	"'o06' value='1' %o"
 160  0935 30363e3c6c61  	dc.b	"06><label for='rel"
 161  0947 617930376f6e  	dc.b	"ay07on'>ON</label>"
 162  0959 3c696e707574  	dc.b	"<input type='radio"
 163  096b 272069643d27  	dc.b	"' id='relay07off' "
 164  097d 6e616d653d27  	dc.b	"name='o06' value='"
 165  098f 302720257030  	dc.b	"0' %p06><label for"
 166  09a1 3d2772656c61  	dc.b	"='relay07off'>OFF<"
 167  09b3 2f6c6162656c  	dc.b	"/label></td></tr><"
 168  09c5 74723e3c7464  	dc.b	"tr><td>Relay08</td"
 169  09d7 3e3c74642063  	dc.b	"><td class='s%i07'"
 170  09e9 3e3c2f74643e  	dc.b	"></td><td><input t"
 171  09fb 797065        	dc.b	"ype"
 172  09fe 3d2772616469  	dc.b	"='radio' id='relay"
 173  0a10 30386f6e2720  	dc.b	"08on' name='o07' v"
 174  0a22 616c75653d27  	dc.b	"alue='1' %o07><lab"
 175  0a34 656c20666f72  	dc.b	"el for='relay08on'"
 176  0a46 3e4f4e3c2f6c  	dc.b	">ON</label><input "
 177  0a58 747970653d27  	dc.b	"type='radio' id='r"
 178  0a6a 656c61793038  	dc.b	"elay08off' name='o"
 179  0a7c 303727207661  	dc.b	"07' value='0' %p07"
 180  0a8e 3e3c6c616265  	dc.b	"><label for='relay"
 181  0aa0 30386f666627  	dc.b	"08off'>OFF</label>"
 182  0ab2 3c2f74643e3c  	dc.b	"</td></tr><tr><td>"
 183  0ac4 52656c617930  	dc.b	"Relay09</td><td cl"
 184  0ad6 6173733d2773  	dc.b	"ass='s%i08'></td><"
 185  0ae8 74643e3c696e  	dc.b	"td><input type='ra"
 186  0afa 64696f        	dc.b	"dio"
 187  0afd 272069643d27  	dc.b	"' id='relay09on' n"
 188  0b0f 616d653d276f  	dc.b	"ame='o08' value='1"
 189  0b21 2720256f3038  	dc.b	"' %o08><label for="
 190  0b33 2772656c6179  	dc.b	"'relay09on'>ON</la"
 191  0b45 62656c3e3c69  	dc.b	"bel><input type='r"
 192  0b57 6164696f2720  	dc.b	"adio' id='relay09o"
 193  0b69 666627206e61  	dc.b	"ff' name='o08' val"
 194  0b7b 75653d273027  	dc.b	"ue='0' %p08><label"
 195  0b8d 20666f723d27  	dc.b	" for='relay09off'>"
 196  0b9f 4f46463c2f6c  	dc.b	"OFF</label></td></"
 197  0bb1 74723e3c7472  	dc.b	"tr><tr><td>Relay10"
 198  0bc3 3c2f74643e3c  	dc.b	"</td><td class='s%"
 199  0bd5 693039273e3c  	dc.b	"i09'></td><td><inp"
 200  0be7 757420747970  	dc.b	"ut type='radio' id"
 201  0bf9 3d2772        	dc.b	"='r"
 202  0bfc 656c61793130  	dc.b	"elay10on' name='o0"
 203  0c0e 39272076616c  	dc.b	"9' value='1' %o09>"
 204  0c20 3c6c6162656c  	dc.b	"<label for='relay1"
 205  0c32 306f6e273e4f  	dc.b	"0on'>ON</label><in"
 206  0c44 707574207479  	dc.b	"put type='radio' i"
 207  0c56 643d2772656c  	dc.b	"d='relay10off' nam"
 208  0c68 653d276f3039  	dc.b	"e='o09' value='0' "
 209  0c7a 257030393e3c  	dc.b	"%p09><label for='r"
 210  0c8c 656c61793130  	dc.b	"elay10off'>OFF</la"
 211  0c9e 62656c3e3c2f  	dc.b	"bel></td></tr><tr>"
 212  0cb0 3c74643e5265  	dc.b	"<td>Relay11</td><t"
 213  0cc2 6420636c6173  	dc.b	"d class='s%i10'></"
 214  0cd4 74643e3c7464  	dc.b	"td><td><input type"
 215  0ce6 3d2772616469  	dc.b	"='radio' id='relay"
 216  0cf8 31316f        	dc.b	"11o"
 217  0cfb 6e27206e616d  	dc.b	"n' name='o10' valu"
 218  0d0d 653d27312720  	dc.b	"e='1' %o10><label "
 219  0d1f 666f723d2772  	dc.b	"for='relay11on'>ON"
 220  0d31 3c2f6c616265  	dc.b	"</label><input typ"
 221  0d43 653d27726164  	dc.b	"e='radio' id='rela"
 222  0d55 7931316f6666  	dc.b	"y11off' name='o10'"
 223  0d67 2076616c7565  	dc.b	" value='0' %p10><l"
 224  0d79 6162656c2066  	dc.b	"abel for='relay11o"
 225  0d8b 6666273e4f46  	dc.b	"ff'>OFF</label></t"
 226  0d9d 643e3c2f7472  	dc.b	"d></tr><tr><td>Rel"
 227  0daf 617931323c2f  	dc.b	"ay12</td><td class"
 228  0dc1 3d2773256931  	dc.b	"='s%i11'></td><td>"
 229  0dd3 3c696e707574  	dc.b	"<input type='radio"
 230  0de5 272069643d27  	dc.b	"' id='relay12on' n"
 231  0df7 616d65        	dc.b	"ame"
 232  0dfa 3d276f313127  	dc.b	"='o11' value='1' %"
 233  0e0c 6f31313e3c6c  	dc.b	"o11><label for='re"
 234  0e1e 6c617931326f  	dc.b	"lay12on'>ON</label"
 235  0e30 3e3c696e7075  	dc.b	"><input type='radi"
 236  0e42 6f272069643d  	dc.b	"o' id='relay12off'"
 237  0e54 206e616d653d  	dc.b	" name='o11' value="
 238  0e66 273027202570  	dc.b	"'0' %p11><label fo"
 239  0e78 723d2772656c  	dc.b	"r='relay12off'>OFF"
 240  0e8a 3c2f6c616265  	dc.b	"</label></td></tr>"
 241  0e9c 3c74723e3c74  	dc.b	"<tr><td>Relay13</t"
 242  0eae 643e3c746420  	dc.b	"d><td class='s%i12"
 243  0ec0 273e3c2f7464  	dc.b	"'></td><td><input "
 244  0ed2 747970653d27  	dc.b	"type='radio' id='r"
 245  0ee4 656c61793133  	dc.b	"elay13on' name='o1"
 246  0ef6 322720        	dc.b	"2' "
 247  0ef9 76616c75653d  	dc.b	"value='1' %o12><la"
 248  0f0b 62656c20666f  	dc.b	"bel for='relay13on"
 249  0f1d 273e4f4e3c2f  	dc.b	"'>ON</label><input"
 250  0f2f 20747970653d  	dc.b	" type='radio' id='"
 251  0f41 72656c617931  	dc.b	"relay13off' name='"
 252  0f53 6f3132272076  	dc.b	"o12' value='0' %p1"
 253  0f65 323e3c6c6162  	dc.b	"2><label for='rela"
 254  0f77 7931336f6666  	dc.b	"y13off'>OFF</label"
 255  0f89 3e3c2f74643e  	dc.b	"></td></tr><tr><td"
 256  0f9b 3e52656c6179  	dc.b	">Relay14</td><td c"
 257  0fad 6c6173733d27  	dc.b	"lass='s%i13'></td>"
 258  0fbf 3c74643e3c69  	dc.b	"<td><input type='r"
 259  0fd1 6164696f2720  	dc.b	"adio' id='relay14o"
 260  0fe3 6e27206e616d  	dc.b	"n' name='o13' valu"
 261  0ff5 653d27        	dc.b	"e='"
 262  0ff8 312720256f31  	dc.b	"1' %o13><label for"
 263  100a 3d2772656c61  	dc.b	"='relay14on'>ON</l"
 264  101c 6162656c3e3c  	dc.b	"abel><input type='"
 265  102e 726164696f27  	dc.b	"radio' id='relay14"
 266  1040 6f666627206e  	dc.b	"off' name='o13' va"
 267  1052 6c75653d2730  	dc.b	"lue='0' %p13><labe"
 268  1064 6c20666f723d  	dc.b	"l for='relay14off'"
 269  1076 3e4f46463c2f  	dc.b	">OFF</label></td><"
 270  1088 2f74723e3c74  	dc.b	"/tr><tr><td>Relay1"
 271  109a 353c2f74643e  	dc.b	"5</td><td class='s"
 272  10ac 25693134273e  	dc.b	"%i14'></td><td><in"
 273  10be 707574207479  	dc.b	"put type='radio' i"
 274  10d0 643d2772656c  	dc.b	"d='relay15on' name"
 275  10e2 3d276f313427  	dc.b	"='o14' value='1' %"
 276  10f4 6f3134        	dc.b	"o14"
 277  10f7 3e3c6c616265  	dc.b	"><label for='relay"
 278  1109 31356f6e273e  	dc.b	"15on'>ON</label><i"
 279  111b 6e7075742074  	dc.b	"nput type='radio' "
 280  112d 69643d277265  	dc.b	"id='relay15off' na"
 281  113f 6d653d276f31  	dc.b	"me='o14' value='0'"
 282  1151 20257031343e  	dc.b	" %p14><label for='"
 283  1163 72656c617931  	dc.b	"relay15off'>OFF</l"
 284  1175 6162656c3e3c  	dc.b	"abel></td></tr><tr"
 285  1187 3e3c74643e52  	dc.b	"><td>Relay16</td><"
 286  1199 746420636c61  	dc.b	"td class='s%i15'><"
 287  11ab 2f74643e3c74  	dc.b	"/td><td><input typ"
 288  11bd 653d27726164  	dc.b	"e='radio' id='rela"
 289  11cf 7931366f6e27  	dc.b	"y16on' name='o15' "
 290  11e1 76616c75653d  	dc.b	"value='1' %o15><la"
 291  11f3 62656c        	dc.b	"bel"
 292  11f6 20666f723d27  	dc.b	" for='relay16on'>O"
 293  1208 4e3c2f6c6162  	dc.b	"N</label><input ty"
 294  121a 70653d277261  	dc.b	"pe='radio' id='rel"
 295  122c 617931366f66  	dc.b	"ay16off' name='o15"
 296  123e 272076616c75  	dc.b	"' value='0' %p15><"
 297  1250 6c6162656c20  	dc.b	"label for='relay16"
 298  1262 6f6666273e4f  	dc.b	"off'>OFF</label></"
 299  1274 74643e3c2f74  	dc.b	"td></tr><tr><td>In"
 300  1286 766572743c2f  	dc.b	"vert</td><td></td>"
 301  1298 3c74643e3c69  	dc.b	"<td><input type='r"
 302  12aa 6164696f2720  	dc.b	"adio' id='invertOn"
 303  12bc 27206e616d65  	dc.b	"' name='g00' value"
 304  12ce 3d2731272025  	dc.b	"='1' %g00><label f"
 305  12e0 6f723d27696e  	dc.b	"or='invertOn'>ON</"
 306  12f2 6c6162        	dc.b	"lab"
 307  12f5 656c3e3c696e  	dc.b	"el><input type='ra"
 308  1307 64696f272069  	dc.b	"dio' id='invertOff"
 309  1319 27206e616d65  	dc.b	"' name='g00' value"
 310  132b 3d2730272025  	dc.b	"='0' %h00><label f"
 311  133d 6f723d27696e  	dc.b	"or='invertOff'>OFF"
 312  134f 3c2f6c616265  	dc.b	"</label></td></tr>"
 313  1361 3c2f7461626c  	dc.b	"</table><button ty"
 314  1373 70653d277375  	dc.b	"pe='submit' title="
 315  1385 275361766573  	dc.b	"'Saves your change"
 316  1397 73202d20646f  	dc.b	"s - does not resta"
 317  13a9 727420746865  	dc.b	"rt the Network Mod"
 318  13bb 756c65273e53  	dc.b	"ule'>Save</button>"
 319  13cd 3c627574746f  	dc.b	"<button type='rese"
 320  13df 742720746974  	dc.b	"t' title='Un-does "
 321  13f1 616e79        	dc.b	"any"
 322  13f4 206368616e67  	dc.b	" changes that have"
 323  1406 206e6f742062  	dc.b	" not been saved'>U"
 324  1418 6e646f20416c  	dc.b	"ndo All</button></"
 325  142a 666f726d3e3c  	dc.b	"form><a href='%x00"
 326  143c 687474703a2f  	dc.b	"http://192.168.001"
 327  144e 2e3030343a30  	dc.b	".004:08080/61'><bu"
 328  1460 74746f6e2074  	dc.b	"tton title='Save f"
 329  1472 697273742120  	dc.b	"irst! This button "
 330  1484 77696c6c206e  	dc.b	"will not save your"
 331  1496 206368616e67  	dc.b	" changes'>Address "
 332  14a8 53657474696e  	dc.b	"Settings</button><"
 333  14ba 2f613e3c6120  	dc.b	"/a><a href='%x00ht"
 334  14cc 74703a2f2f31  	dc.b	"tp://192.168.001.0"
 335  14de 30343a303830  	dc.b	"04:08080/66'><butt"
 336  14f0 6f6e20        	dc.b	"on "
 337  14f3 7469746c653d  	dc.b	"title='Save first!"
 338  1505 205468697320  	dc.b	" This button will "
 339  1517 6e6f74207361  	dc.b	"not save your chan"
 340  1529 676573273e4e  	dc.b	"ges'>Network Stati"
 341  153b 73746963733c  	dc.b	"stics</button></a>"
 342  154d 3c6120687265  	dc.b	"<a href='%x00http:"
 343  155f 2f2f3139322e  	dc.b	"//192.168.001.004:"
 344  1571 30383038302f  	dc.b	"08080/63'><button "
 345  1583 7469746c653d  	dc.b	"title='Save first!"
 346  1595 205468697320  	dc.b	" This button will "
 347  15a7 6e6f74207361  	dc.b	"not save your chan"
 348  15b9 676573273e48  	dc.b	"ges'>Help</button>"
 349  15cb 3c2f613e3c2f  	dc.b	"</a></body></html>",0
 350  15de               L71_g_HtmlPageAddress:
 351  15de 3c21444f4354  	dc.b	"<!DOCTYPE HTML PUB"
 352  15f0 4c49432022    	dc.b	"LIC ",34
 353  15f5 2d2f2f573343  	dc.b	"-//W3C//DTD HTML 4"
 354  1607 2e3031205472  	dc.b	".01 Transitional//"
 355  1619 454e22        	dc.b	"EN",34
 356  161c 3e3c68746d6c  	dc.b	"><html><head><titl"
 357  162e 653e41646472  	dc.b	"e>Address Settings"
 358  1640 3c2f7469746c  	dc.b	"</title><style typ"
 359  1652 653d27746578  	dc.b	"e='text/css'>td { "
 360  1664 746578742d61  	dc.b	"text-align: center"
 361  1676 3b207d2e7463  	dc.b	"; }.tclass { width"
 362  1688 3a2032357078  	dc.b	": 25px; }.tclass1 "
 363  169a 7b2077696474  	dc.b	"{ width: 30px; }.t"
 364  16ac 636c61737332  	dc.b	"class2 { width: 46"
 365  16be 70783b207d3c  	dc.b	"px; }</style></hea"
 366  16d0 643e3c626f64  	dc.b	"d><body><h1>A"
 367  16dd 646472657373  	dc.b	"ddress Settings</h"
 368  16ef 313e3c666f72  	dc.b	"1><form method='PO"
 369  1701 535427206163  	dc.b	"ST' action='/'><ta"
 370  1713 626c6520626f  	dc.b	"ble border='1px'><"
 371  1725 636f6c67726f  	dc.b	"colgroup><col widt"
 372  1737 683d27313030  	dc.b	"h='100px'><col wid"
 373  1749 74683d273435  	dc.b	"th='45px'><col wid"
 374  175b 74683d273435  	dc.b	"th='45px'><col wid"
 375  176d 74683d273435  	dc.b	"th='45px'><col wid"
 376  177f 74683d273434  	dc.b	"th='44px'></colgro"
 377  1791 75703e3c7472  	dc.b	"up><tr><td>IP Addr"
 378  17a3 3c2f74643e3c  	dc.b	"</td><td><input ty"
 379  17b5 70653d277465  	dc.b	"pe='text' name='b0"
 380  17c7 302720636c61  	dc.b	"0' class='tclass1'"
 381  17d9 207661        	dc.b	" va"
 382  17dc 6c75653d2725  	dc.b	"lue='%b00' pattern"
 383  17ee 3d275b302d39  	dc.b	"='[0-9]{3}' title="
 384  1800 275468726565  	dc.b	"'Three digits from"
 385  1812 203030302074  	dc.b	" 000 to 255' maxle"
 386  1824 6e6774683d27  	dc.b	"ngth='3' size='3'>"
 387  1836 3c2f74643e3c  	dc.b	"</td><td><input ty"
 388  1848 70653d277465  	dc.b	"pe='text' name='b0"
 389  185a 312720636c61  	dc.b	"1' class='tclass1'"
 390  186c 2076616c7565  	dc.b	" value='%b01' patt"
 391  187e 65726e3d275b  	dc.b	"ern='[0-9]{3}' tit"
 392  1890 6c653d275468  	dc.b	"le='Three digits f"
 393  18a2 726f6d203030  	dc.b	"rom 000 to 255' ma"
 394  18b4 786c656e6774  	dc.b	"xlength='3' size='"
 395  18c6 33273e3c2f74  	dc.b	"3'></td><td><input"
 396  18d8 207479        	dc.b	" ty"
 397  18db 70653d277465  	dc.b	"pe='text' name='b0"
 398  18ed 322720636c61  	dc.b	"2' class='tclass1'"
 399  18ff 2076616c7565  	dc.b	" value='%b02' patt"
 400  1911 65726e3d275b  	dc.b	"ern='[0-9]{3}' tit"
 401  1923 6c653d275468  	dc.b	"le='Three digits f"
 402  1935 726f6d203030  	dc.b	"rom 000 to 255' ma"
 403  1947 786c656e6774  	dc.b	"xlength='3' size='"
 404  1959 33273e3c2f74  	dc.b	"3'></td><td><input"
 405  196b 20747970653d  	dc.b	" type='text' name="
 406  197d 276230332720  	dc.b	"'b03' class='tclas"
 407  198f 733127207661  	dc.b	"s1' value='%b03' p"
 408  19a1 61747465726e  	dc.b	"attern='[0-9]{3}' "
 409  19b3 7469746c653d  	dc.b	"title='Three digit"
 410  19c5 732066726f6d  	dc.b	"s from 000 to 255'"
 411  19d7 206d61        	dc.b	" ma"
 412  19da 786c656e6774  	dc.b	"xlength='3' size='"
 413  19ec 33273e3c2f74  	dc.b	"3'></td></tr><tr><"
 414  19fe 74643e476174  	dc.b	"td>Gateway</td><td"
 415  1a10 3e3c696e7075  	dc.b	"><input type='text"
 416  1a22 27206e616d65  	dc.b	"' name='b04' class"
 417  1a34 3d2774636c61  	dc.b	"='tclass1' value='"
 418  1a46 256230342720  	dc.b	"%b04' pattern='[0-"
 419  1a58 395d7b337d27  	dc.b	"9]{3}' title='Thre"
 420  1a6a 652064696769  	dc.b	"e digits from 000 "
 421  1a7c 746f20323535  	dc.b	"to 255' maxlength="
 422  1a8e 273327207369  	dc.b	"'3' size='3'></td>"
 423  1aa0 3c74643e3c69  	dc.b	"<td><input type='t"
 424  1ab2 65787427206e  	dc.b	"ext' name='b05' cl"
 425  1ac4 6173733d2774  	dc.b	"ass='tclass1' valu"
 426  1ad6 653d27        	dc.b	"e='"
 427  1ad9 256230352720  	dc.b	"%b05' pattern='[0-"
 428  1aeb 395d7b337d27  	dc.b	"9]{3}' title='Thre"
 429  1afd 652064696769  	dc.b	"e digits from 000 "
 430  1b0f 746f20323535  	dc.b	"to 255' maxlength="
 431  1b21 273327207369  	dc.b	"'3' size='3'></td>"
 432  1b33 3c74643e3c69  	dc.b	"<td><input type='t"
 433  1b45 65787427206e  	dc.b	"ext' name='b06' cl"
 434  1b57 6173733d2774  	dc.b	"ass='tclass1' valu"
 435  1b69 653d27256230  	dc.b	"e='%b06' pattern='"
 436  1b7b 5b302d395d7b  	dc.b	"[0-9]{3}' title='T"
 437  1b8d 687265652064  	dc.b	"hree digits from 0"
 438  1b9f 303020746f20  	dc.b	"00 to 255' maxleng"
 439  1bb1 74683d273327  	dc.b	"th='3' size='3'></"
 440  1bc3 74643e3c7464  	dc.b	"td><td><input type"
 441  1bd5 3d2774        	dc.b	"='t"
 442  1bd8 65787427206e  	dc.b	"ext' name='b07' cl"
 443  1bea 6173733d2774  	dc.b	"ass='tclass1' valu"
 444  1bfc 653d27256230  	dc.b	"e='%b07' pattern='"
 445  1c0e 5b302d395d7b  	dc.b	"[0-9]{3}' title='T"
 446  1c20 687265652064  	dc.b	"hree digits from 0"
 447  1c32 303020746f20  	dc.b	"00 to 255' maxleng"
 448  1c44 74683d273327  	dc.b	"th='3' size='3'></"
 449  1c56 74643e3c2f74  	dc.b	"td></tr><tr><td>Ne"
 450  1c68 746d61736b3c  	dc.b	"tmask</td><td><inp"
 451  1c7a 757420747970  	dc.b	"ut type='text' nam"
 452  1c8c 653d27623038  	dc.b	"e='b08' class='tcl"
 453  1c9e 617373312720  	dc.b	"ass1' value='%b08'"
 454  1cb0 207061747465  	dc.b	" pattern='[0-9]{3}"
 455  1cc2 27207469746c  	dc.b	"' title='Three dig"
 456  1cd4 697473        	dc.b	"its"
 457  1cd7 2066726f6d20  	dc.b	" from 000 to 255' "
 458  1ce9 6d61786c656e  	dc.b	"maxlength='3' size"
 459  1cfb 3d2733273e3c  	dc.b	"='3'></td><td><inp"
 460  1d0d 757420747970  	dc.b	"ut type='text' nam"
 461  1d1f 653d27623039  	dc.b	"e='b09' class='tcl"
 462  1d31 617373312720  	dc.b	"ass1' value='%b09'"
 463  1d43 207061747465  	dc.b	" pattern='[0-9]{3}"
 464  1d55 27207469746c  	dc.b	"' title='Three dig"
 465  1d67 697473206672  	dc.b	"its from 000 to 25"
 466  1d79 3527206d6178  	dc.b	"5' maxlength='3' s"
 467  1d8b 697a653d2733  	dc.b	"ize='3'></td><td><"
 468  1d9d 696e70757420  	dc.b	"input type='text' "
 469  1daf 6e616d653d27  	dc.b	"name='b10' class='"
 470  1dc1 74636c617373  	dc.b	"tclass1' value='%b"
 471  1dd3 313027        	dc.b	"10'"
 472  1dd6 207061747465  	dc.b	" pattern='[0-9]{3}"
 473  1de8 27207469746c  	dc.b	"' title='Three dig"
 474  1dfa 697473206672  	dc.b	"its from 000 to 25"
 475  1e0c 3527206d6178  	dc.b	"5' maxlength='3' s"
 476  1e1e 697a653d2733  	dc.b	"ize='3'></td><td><"
 477  1e30 696e70757420  	dc.b	"input type='text' "
 478  1e42 6e616d653d27  	dc.b	"name='b11' class='"
 479  1e54 74636c617373  	dc.b	"tclass1' value='%b"
 480  1e66 313127207061  	dc.b	"11' pattern='[0-9]"
 481  1e78 7b337d272074  	dc.b	"{3}' title='Three "
 482  1e8a 646967697473  	dc.b	"digits from 000 to"
 483  1e9c 203235352720  	dc.b	" 255' maxlength='3"
 484  1eae 272073697a65  	dc.b	"' size='3'></td></"
 485  1ec0 74723e3c7472  	dc.b	"tr><tr><td>Port   "
 486  1ed2 3c2f74        	dc.b	"</t"
 487  1ed5 643e3c74643e  	dc.b	"d><td><input type="
 488  1ee7 277465787427  	dc.b	"'text' name='c00' "
 489  1ef9 636c6173733d  	dc.b	"class='tclass2' va"
 490  1f0b 6c75653d2725  	dc.b	"lue='%c00' pattern"
 491  1f1d 3d275b302d39  	dc.b	"='[0-9]{5}' title="
 492  1f2f 274669766520  	dc.b	"'Five digits from "
 493  1f41 303030303020  	dc.b	"00000 to 65536' ma"
 494  1f53 786c656e6774  	dc.b	"xlength='5' size='"
 495  1f65 35273e3c2f74  	dc.b	"5'></td></tr></tab"
 496  1f77 6c653e3c7461  	dc.b	"le><table border='"
 497  1f89 317078273e3c  	dc.b	"1px'><colgroup><co"
 498  1f9b 6c2077696474  	dc.b	"l width='100px'><c"
 499  1fad 6f6c20776964  	dc.b	"ol width='30px'><c"
 500  1fbf 6f6c20776964  	dc.b	"ol width='30px'><c"
 501  1fd1 6f6c20        	dc.b	"ol "
 502  1fd4 77696474683d  	dc.b	"width='30px'><col "
 503  1fe6 77696474683d  	dc.b	"width='30px'><col "
 504  1ff8 77696474683d  	dc.b	"width='30px'><col "
 505  200a 77696474683d  	dc.b	"width='30px'></col"
 506  201c 67726f75703e  	dc.b	"group><tr><td>MAC "
 507  202e 416464726573  	dc.b	"Address</td><td><i"
 508  2040 6e7075742074  	dc.b	"nput type='text' n"
 509  2052 616d653d2764  	dc.b	"ame='d00' class='t"
 510  2064 636c61737327  	dc.b	"class' value='%d00"
 511  2076 272070617474  	dc.b	"' pattern='[0-9a-f"
 512  2088 5d7b327d2720  	dc.b	"]{2}' title='Two h"
 513  209a 657820646967  	dc.b	"ex digits from 00 "
 514  20ac 746f20666627  	dc.b	"to ff' maxlength='"
 515  20be 32272073697a  	dc.b	"2' size='2'></td><"
 516  20d0 74643e        	dc.b	"td>"
 517  20d3 3c696e707574  	dc.b	"<input type='text'"
 518  20e5 206e616d653d  	dc.b	" name='d01' class="
 519  20f7 2774636c6173  	dc.b	"'tclass' value='%d"
 520  2109 303127207061  	dc.b	"01' pattern='[0-9a"
 521  211b 2d665d7b327d  	dc.b	"-f]{2}' title='Two"
 522  212d 206865782064  	dc.b	" hex digits from 0"
 523  213f 3020746f2066  	dc.b	"0 to ff' maxlength"
 524  2151 3d2732272073  	dc.b	"='2' size='2'></td"
 525  2163 3e3c74643e3c  	dc.b	"><td><input type='"
 526  2175 746578742720  	dc.b	"text' name='d02' c"
 527  2187 6c6173733d27  	dc.b	"lass='tclass' valu"
 528  2199 653d27256430  	dc.b	"e='%d02' pattern='"
 529  21ab 5b302d39612d  	dc.b	"[0-9a-f]{2}' title"
 530  21bd 3d2754776f20  	dc.b	"='Two hex digits f"
 531  21cf 726f6d        	dc.b	"rom"
 532  21d2 20303020746f  	dc.b	" 00 to ff' maxleng"
 533  21e4 74683d273227  	dc.b	"th='2' size='2'></"
 534  21f6 74643e3c7464  	dc.b	"td><td><input type"
 535  2208 3d2774657874  	dc.b	"='text' name='d03'"
 536  221a 20636c617373  	dc.b	" class='tclass' va"
 537  222c 6c75653d2725  	dc.b	"lue='%d03' pattern"
 538  223e 3d275b302d39  	dc.b	"='[0-9a-f]{2}' tit"
 539  2250 6c653d275477  	dc.b	"le='Two hex digits"
 540  2262 2066726f6d20  	dc.b	" from 00 to ff' ma"
 541  2274 786c656e6774  	dc.b	"xlength='2' size='"
 542  2286 32273e3c2f74  	dc.b	"2'></td><td><input"
 543  2298 20747970653d  	dc.b	" type='text' name="
 544  22aa 276430342720  	dc.b	"'d04' class='tclas"
 545  22bc 73272076616c  	dc.b	"s' value='%d04' pa"
 546  22ce 747465        	dc.b	"tte"
 547  22d1 726e3d275b30  	dc.b	"rn='[0-9a-f]{2}' t"
 548  22e3 69746c653d27  	dc.b	"itle='Two hex digi"
 549  22f5 74732066726f  	dc.b	"ts from 00 to ff' "
 550  2307 6d61786c656e  	dc.b	"maxlength='2' size"
 551  2319 3d2732273e3c  	dc.b	"='2'></td><td><inp"
 552  232b 757420747970  	dc.b	"ut type='text' nam"
 553  233d 653d27643035  	dc.b	"e='d05' class='tcl"
 554  234f 617373272076  	dc.b	"ass' value='%d05' "
 555  2361 706174746572  	dc.b	"pattern='[0-9a-f]{"
 556  2373 327d27207469  	dc.b	"2}' title='Two hex"
 557  2385 206469676974  	dc.b	" digits from 00 to"
 558  2397 20666627206d  	dc.b	" ff' maxlength='2'"
 559  23a9 2073697a653d  	dc.b	" size='2'></td></t"
 560  23bb 723e3c2f7461  	dc.b	"r></table><button "
 561  23cd 747970        	dc.b	"typ"
 562  23d0 653d27737562  	dc.b	"e='submit' title='"
 563  23e2 536176657320  	dc.b	"Saves your changes"
 564  23f4 207468656e20  	dc.b	" then restarts the"
 565  2406 204e6574776f  	dc.b	" Network Module'>S"
 566  2418 6176653c2f62  	dc.b	"ave</button><butto"
 567  242a 6e2074797065  	dc.b	"n type='reset' tit"
 568  243c 6c653d27556e  	dc.b	"le='Un-does any ch"
 569  244e 616e67657320  	dc.b	"anges that have no"
 570  2460 74206265656e  	dc.b	"t been saved'>Undo"
 571  2472 20416c6c3c2f  	dc.b	" All</button></for"
 572  2484 6d3e3c70206c  	dc.b	"m><p line-height 2"
 573  2496 3070783e5573  	dc.b	"0px>Use caution wh"
 574  24a8 656e20636861  	dc.b	"en changing the ab"
 575  24ba 6f76652e2049  	dc.b	"ove. If you make a"
 576  24cc 206d69        	dc.b	" mi"
 577  24cf 7374616b6520  	dc.b	"stake you may have"
 578  24e1 20746f3c6272  	dc.b	" to<br>restore fac"
 579  24f3 746f72792064  	dc.b	"tory defaults by h"
 580  2505 6f6c64696e67  	dc.b	"olding down the re"
 581  2517 736574206275  	dc.b	"set button for 10 "
 582  2529 7365636f6e64  	dc.b	"seconds.<br><br>Ma"
 583  253b 6b6520737572  	dc.b	"ke sure the MAC yo"
 584  254d 752061737369  	dc.b	"u assign is unique"
 585  255f 20746f20796f  	dc.b	" to your local net"
 586  2571 776f726b2e20  	dc.b	"work. Recommended<"
 587  2583 62723e697320  	dc.b	"br>is that you jus"
 588  2595 7420696e6372  	dc.b	"t increment the lo"
 589  25a7 77657374206f  	dc.b	"west octet and the"
 590  25b9 6e206c616265  	dc.b	"n label your devic"
 591  25cb 657320        	dc.b	"es "
 592  25ce 666f723c6272  	dc.b	"for<br>future refe"
 593  25e0 72656e63652e  	dc.b	"rence.<br><br>If y"
 594  25f2 6f7520636861  	dc.b	"ou change the high"
 595  2604 657374206f63  	dc.b	"est octet of the M"
 596  2616 414320796f75  	dc.b	"AC you MUST use an"
 597  2628 206576656e20  	dc.b	" even number to<br"
 598  263a 3e666f726d20  	dc.b	">form a unicast ad"
 599  264c 64726573732e  	dc.b	"dress. 00, 02, ..."
 600  265e 2066632c2066  	dc.b	" fc, fe etc work f"
 601  2670 696e652e2030  	dc.b	"ine. 01, 03 ... fd"
 602  2682 2c2066662061  	dc.b	", ff are for<br>mu"
 603  2694 6c7469636173  	dc.b	"lticast and will n"
 604  26a6 6f7420776f72  	dc.b	"ot work.</p><a hre"
 605  26b8 663d27257830  	dc.b	"f='%x00http://192."
 606  26ca 313638        	dc.b	"168"
 607  26cd 2e3030312e30  	dc.b	".001.004:08080/91'"
 608  26df 3e3c62757474  	dc.b	"><button title='Sa"
 609  26f1 766520666972  	dc.b	"ve first! This but"
 610  2703 746f6e207769  	dc.b	"ton will not save "
 611  2715 796f75722063  	dc.b	"your changes'>Rebo"
 612  2727 6f743c2f6275  	dc.b	"ot</button></a>&nb"
 613  2739 7370266e6273  	dc.b	"sp&nbspNOTE: Reboo"
 614  274b 74206d617920  	dc.b	"t may cause the re"
 615  275d 6c6179732074  	dc.b	"lays to cycle.<br>"
 616  276f 3c62723e3c61  	dc.b	"<br><a href='%x00h"
 617  2781 7474703a2f2f  	dc.b	"ttp://192.168.001."
 618  2793 3030343a3038  	dc.b	"004:08080/60'><but"
 619  27a5 746f6e207469  	dc.b	"ton title='Save fi"
 620  27b7 727374212054  	dc.b	"rst! This button w"
 621  27c9 696c6c        	dc.b	"ill"
 622  27cc 206e6f742073  	dc.b	" not save your cha"
 623  27de 6e676573273e  	dc.b	"nges'>Relay Contro"
 624  27f0 6c733c2f6275  	dc.b	"ls</button></a><a "
 625  2802 687265663d27  	dc.b	"href='%x00http://1"
 626  2814 39322e313638  	dc.b	"92.168.001.004:080"
 627  2826 38302f363627  	dc.b	"80/66'><button tit"
 628  2838 6c653d275361  	dc.b	"le='Save first! Th"
 629  284a 697320627574  	dc.b	"is button will not"
 630  285c 207361766520  	dc.b	" save your changes"
 631  286e 273e4e657477  	dc.b	"'>Network Statisti"
 632  2880 63733c2f6275  	dc.b	"cs</button></a><a "
 633  2892 687265663d27  	dc.b	"href='%x00http://1"
 634  28a4 39322e313638  	dc.b	"92.168.001.004:080"
 635  28b6 38302f363327  	dc.b	"80/63'><button tit"
 636  28c8 6c653d        	dc.b	"le="
 637  28cb 275361766520  	dc.b	"'Save first! This "
 638  28dd 627574746f6e  	dc.b	"button will not sa"
 639  28ef 766520796f75  	dc.b	"ve your changes'>H"
 640  2901 656c703c2f62  	dc.b	"elp</button></a></"
 641  2913 626f64793e3c  	dc.b	"body></html>",0
 642  2920               L12_g_HtmlPageHelp:
 643  2920 3c21444f4354  	dc.b	"<!DOCTYPE HTML PUB"
 644  2932 4c49432022    	dc.b	"LIC ",34
 645  2937 2d2f2f573343  	dc.b	"-//W3C//DTD HTML 4"
 646  2949 2e3031205472  	dc.b	".01 Transitional//"
 647  295b 454e22        	dc.b	"EN",34
 648  295e 3e3c68746d6c  	dc.b	"><html><head><titl"
 649  2970 653e48656c70  	dc.b	"e>Help Page</title"
 650  2982 3e3c7374796c  	dc.b	"><style type='text"
 651  2994 2f637373273e  	dc.b	"/css'>td { width: "
 652  29a6 31343070783b  	dc.b	"140px; padding: 0p"
 653  29b8 783b207d3c2f  	dc.b	"x; }</style></head"
 654  29ca 3e3c626f6479  	dc.b	"><body><h1>Help Pa"
 655  29dc 676520313c2f  	dc.b	"ge 1</h1><p line-h"
 656  29ee 656967687420  	dc.b	"eight 20px>An alte"
 657  2a00 726e61746976  	dc.b	"rnative to using t"
 658  2a12 686520776562  	dc.b	"he web interf"
 659  2a1f 61636520666f  	dc.b	"ace for changing r"
 660  2a31 656c61792073  	dc.b	"elay states is to "
 661  2a43 73656e642072  	dc.b	"send relay<br>spec"
 662  2a55 696669632068  	dc.b	"ific html commands"
 663  2a67 2e20456e7465  	dc.b	". Enter http://IP:"
 664  2a79 506f72742f78  	dc.b	"Port/xx where<br>-"
 665  2a8b 204950203d20  	dc.b	" IP = the device I"
 666  2a9d 502041646472  	dc.b	"P Address, for exa"
 667  2aaf 6d706c652031  	dc.b	"mple 192.168.1.4<b"
 668  2ac1 723e2d20506f  	dc.b	"r>- Port = the dev"
 669  2ad3 69636520506f  	dc.b	"ice Port number, f"
 670  2ae5 6f7220657861  	dc.b	"or example 8080<br"
 671  2af7 3e2d20787820  	dc.b	">- xx = one of the"
 672  2b09 20636f646573  	dc.b	" codes below:<br><"
 673  2b1b 746162        	dc.b	"tab"
 674  2b1e 6c653e3c7472  	dc.b	"le><tr><td>00 = Re"
 675  2b30 6c61792d3031  	dc.b	"lay-01 OFF</td><td"
 676  2b42 3e3039203d20  	dc.b	">09 = Relay-05 OFF"
 677  2b54 3c2f74643e3c  	dc.b	"</td><td>17 = Rela"
 678  2b66 792d3039204f  	dc.b	"y-09 OFF</td><td>2"
 679  2b78 35203d205265  	dc.b	"5 = Relay-13 OFF<b"
 680  2b8a 723e3c2f7464  	dc.b	"r></td></tr><tr><t"
 681  2b9c 643e3031203d  	dc.b	"d>01 = Relay-01  O"
 682  2bae 4e3c2f74643e  	dc.b	"N</td><td>10 = Rel"
 683  2bc0 61792d303520  	dc.b	"ay-05  ON</td><td>"
 684  2bd2 3138203d2052  	dc.b	"18 = Relay-09  ON<"
 685  2be4 2f74643e3c74  	dc.b	"/td><td>26 = Relay"
 686  2bf6 2d313320204f  	dc.b	"-13  ON<br></td></"
 687  2c08 74723e3c7472  	dc.b	"tr><tr><td>02 = Re"
 688  2c1a 6c6179        	dc.b	"lay"
 689  2c1d 2d3032204f46  	dc.b	"-02 OFF</td><td>11"
 690  2c2f 203d2052656c  	dc.b	" = Relay-06 OFF</t"
 691  2c41 643e3c74643e  	dc.b	"d><td>19 = Relay-1"
 692  2c53 30204f46463c  	dc.b	"0 OFF</td><td>27 ="
 693  2c65 2052656c6179  	dc.b	" Relay-14 OFF<br><"
 694  2c77 2f74643e3c2f  	dc.b	"/td></tr><tr><td>0"
 695  2c89 33203d205265  	dc.b	"3 = Relay-02  ON</"
 696  2c9b 74643e3c7464  	dc.b	"td><td>12 = Relay-"
 697  2cad 303620204f4e  	dc.b	"06  ON</td><td>20 "
 698  2cbf 3d2052656c61  	dc.b	"= Relay-10  ON</td"
 699  2cd1 3e3c74643e32  	dc.b	"><td>28 = Relay-14"
 700  2ce3 20204f4e3c62  	dc.b	"  ON<br></td></tr>"
 701  2cf5 3c74723e3c74  	dc.b	"<tr><td>04 = Relay"
 702  2d07 2d3033204f46  	dc.b	"-03 OFF</td><td>13"
 703  2d19 203d20        	dc.b	" = "
 704  2d1c 52656c61792d  	dc.b	"Relay-07 OFF</td><"
 705  2d2e 74643e323120  	dc.b	"td>21 = Relay-11 O"
 706  2d40 46463c2f7464  	dc.b	"FF</td><td>29 = Re"
 707  2d52 6c61792d3135  	dc.b	"lay-15 OFF<br></td"
 708  2d64 3e3c2f74723e  	dc.b	"></tr><tr><td>05 ="
 709  2d76 2052656c6179  	dc.b	" Relay-03  ON</td>"
 710  2d88 3c74643e3134  	dc.b	"<td>14 = Relay-07 "
 711  2d9a 204f4e3c2f74  	dc.b	" ON</td><td>22 = R"
 712  2dac 656c61792d31  	dc.b	"elay-11  ON</td><t"
 713  2dbe 643e3330203d  	dc.b	"d>30 = Relay-15  O"
 714  2dd0 4e3c62723e3c  	dc.b	"N<br></td></tr><tr"
 715  2de2 3e3c74643e30  	dc.b	"><td>07 = Relay-04"
 716  2df4 204f46463c2f  	dc.b	" OFF</td><td>15 = "
 717  2e06 52656c61792d  	dc.b	"Relay-08 OFF</td><"
 718  2e18 74643e        	dc.b	"td>"
 719  2e1b 3233203d2052  	dc.b	"23 = Relay-12 OFF<"
 720  2e2d 2f74643e3c74  	dc.b	"/td><td>31 = Relay"
 721  2e3f 2d3136204f46  	dc.b	"-16 OFF<br></td></"
 722  2e51 74723e3c7472  	dc.b	"tr><tr><td>08 = Re"
 723  2e63 6c61792d3034  	dc.b	"lay-04  ON</td><td"
 724  2e75 3e3136203d20  	dc.b	">16 = Relay-08  ON"
 725  2e87 3c2f74643e3c  	dc.b	"</td><td>24 = Rela"
 726  2e99 792d31322020  	dc.b	"y-12  ON</td><td>3"
 727  2eab 32203d205265  	dc.b	"2 = Relay-16  ON<b"
 728  2ebd 723e3c2f7464  	dc.b	"r></td></tr></tabl"
 729  2ecf 653e3535203d  	dc.b	"e>55 = All Relays "
 730  2ee1 4f4e3c62723e  	dc.b	"ON<br>56 = All Rel"
 731  2ef3 617973204f46  	dc.b	"ays OFF<br><br>The"
 732  2f05 20666f6c6c6f  	dc.b	" following are als"
 733  2f17 6f2061        	dc.b	"o a"
 734  2f1a 7661696c6162  	dc.b	"vailable:<br>60 = "
 735  2f2c 53686f772052  	dc.b	"Show Relay Control"
 736  2f3e 20706167653c  	dc.b	" page<br>61 = Show"
 737  2f50 204164647265  	dc.b	" Address Settings "
 738  2f62 706167653c62  	dc.b	"page<br>63 = Show "
 739  2f74 48656c702050  	dc.b	"Help Page 1<br>64 "
 740  2f86 3d2053686f77  	dc.b	"= Show Help Page 2"
 741  2f98 3c62723e3635  	dc.b	"<br>65 = Flash LED"
 742  2faa 3c62723e3636  	dc.b	"<br>66 = Show Stat"
 743  2fbc 697374696373  	dc.b	"istics<br>91 = Reb"
 744  2fce 6f6f743c6272  	dc.b	"oot<br>99 = Show S"
 745  2fe0 686f72742046  	dc.b	"hort Form Relay Se"
 746  2ff2 7474696e6773  	dc.b	"ttings<br></p><a h"
 747  3004 7265663d2725  	dc.b	"ref='%x00http://19"
 748  3016 322e31        	dc.b	"2.1"
 749  3019 36382e303031  	dc.b	"68.001.004:08080/6"
 750  302b 34273e3c6275  	dc.b	"4'><button title='"
 751  303d 476f20746f20  	dc.b	"Go to next Help pa"
 752  304f 6765273e4e65  	dc.b	"ge'>Next Help Page"
 753  3061 3c2f62757474  	dc.b	"</button></a></bod"
 754  3073 793e3c2f6874  	dc.b	"y></html>",0
 755  307d               L32_g_HtmlPageHelp2:
 756  307d 3c21444f4354  	dc.b	"<!DOCTYPE HTML PUB"
 757  308f 4c49432022    	dc.b	"LIC ",34
 758  3094 2d2f2f573343  	dc.b	"-//W3C//DTD HTML 4"
 759  30a6 2e3031205472  	dc.b	".01 Transitional//"
 760  30b8 454e22        	dc.b	"EN",34
 761  30bb 3e3c68746d6c  	dc.b	"><html><head><titl"
 762  30cd 653e48656c70  	dc.b	"e>Help Page</title"
 763  30df 3e3c7374796c  	dc.b	"><style type='text"
 764  30f1 2f637373273e  	dc.b	"/css'></style></he"
 765  3103 61643e3c626f  	dc.b	"ad><body><h1>Help "
 766  3115 506167652032  	dc.b	"Page 2</h1><p line"
 767  3127 2d6865696768  	dc.b	"-height 20px>IP Ad"
 768  3139 64726573732c  	dc.b	"dress, Gateway Add"
 769  314b 726573732c20  	dc.b	"ress, Netmask, Por"
 770  315d 742c20616e64  	dc.b	"t, and MAC Address"
 771  316f 2063616e206f  	dc.b	" can only be<"
 772  317c 62723e636861  	dc.b	"br>changed via the"
 773  318e 207765622069  	dc.b	" web interface. If"
 774  31a0 207468652064  	dc.b	" the device become"
 775  31b2 7320696e6163  	dc.b	"s inaccessible you"
 776  31c4 2063616e3c62  	dc.b	" can<br>reset to f"
 777  31d6 6163746f7279  	dc.b	"actory defaults by"
 778  31e8 20686f6c6469  	dc.b	" holding the reset"
 779  31fa 20627574746f  	dc.b	" button down for 1"
 780  320c 30207365636f  	dc.b	"0 seconds.<br>Defa"
 781  321e 756c74733a3c  	dc.b	"ults:<br> IP 192.1"
 782  3230 36382e312e34  	dc.b	"68.1.4<br> Gateway"
 783  3242 203139322e31  	dc.b	" 192.168.1.1<br> N"
 784  3254 65746d61736b  	dc.b	"etmask 255.255.255"
 785  3266 2e303c62723e  	dc.b	".0<br> Port 08080<"
 786  3278 62723e        	dc.b	"br>"
 787  327b 204d41432063  	dc.b	" MAC c2-4d-69-6b-6"
 788  328d 352d30303c62  	dc.b	"5-00<br><br>Code R"
 789  329f 65766973696f  	dc.b	"evision 20200612 0"
 790  32b1 3830303c2f70  	dc.b	"800</p><a href='%x"
 791  32c3 303068747470  	dc.b	"00http://192.168.0"
 792  32d5 30312e303034  	dc.b	"01.004:08080/60'><"
 793  32e7 627574746f6e  	dc.b	"button title='Go t"
 794  32f9 6f2052656c61  	dc.b	"o Relay Control Pa"
 795  330b 6765273e5265  	dc.b	"ge'>Relay Controls"
 796  331d 3c2f62757474  	dc.b	"</button></a></bod"
 797  332f 793e3c2f6874  	dc.b	"y></html>",0
 798  3339               L52_g_HtmlPageStats:
 799  3339 3c21444f4354  	dc.b	"<!DOCTYPE HTML PUB"
 800  334b 4c49432022    	dc.b	"LIC ",34
 801  3350 2d2f2f573343  	dc.b	"-//W3C//DTD HTML 4"
 802  3362 2e3031205472  	dc.b	".01 Transitional//"
 803  3374 454e22        	dc.b	"EN",34
 804  3377 3e3c68746d6c  	dc.b	"><html><head><titl"
 805  3389 653e53746174  	dc.b	"e>Statistics</titl"
 806  339b 653e3c737479  	dc.b	"e><style type='tex"
 807  33ad 742f63737327  	dc.b	"t/css'>.tclass { w"
 808  33bf 696474683a20  	dc.b	"idth: 450px; }</st"
 809  33d1 796c653e3c2f  	dc.b	"yle></head><body><"
 810  33e3 68313e4e6574  	dc.b	"h1>Network Statist"
 811  33f5 6963733c2f68  	dc.b	"ics</h1><p>Values "
 812  3407 73686f776e20  	dc.b	"shown are since la"
 813  3419 737420706f77  	dc.b	"st power on or res"
 814  342b 65743c2f703e  	dc.b	"et</p><table "
 815  3438 626f72646572  	dc.b	"border='1px'><colg"
 816  344a 726f75703e3c  	dc.b	"roup><col width='1"
 817  345c 30307078273e  	dc.b	"00px'><col width='"
 818  346e 343530707827  	dc.b	"450px'></colgroup>"
 819  3480 3c74723e3c74  	dc.b	"<tr><td>%e00xxxxxx"
 820  3492 787878783c2f  	dc.b	"xxxx</td><td class"
 821  34a4 3d2774636c61  	dc.b	"='tclass'>Dropped "
 822  34b6 7061636b6574  	dc.b	"packets at the IP "
 823  34c8 6c617965723c  	dc.b	"layer</td></tr><tr"
 824  34da 3e3c74643e25  	dc.b	"><td>%e01xxxxxxxxx"
 825  34ec 783c2f74643e  	dc.b	"x</td><td class='t"
 826  34fe 636c61737327  	dc.b	"class'>Received pa"
 827  3510 636b65747320  	dc.b	"ckets at the IP la"
 828  3522 7965723c2f74  	dc.b	"yer</td></tr><tr><"
 829  3534 74643e        	dc.b	"td>"
 830  3537 256530327878  	dc.b	"%e02xxxxxxxxxx</td"
 831  3549 3e3c74642063  	dc.b	"><td class='tclass"
 832  355b 273e53656e74  	dc.b	"'>Sent packets at "
 833  356d 746865204950  	dc.b	"the IP layer</td><"
 834  357f 2f74723e3c74  	dc.b	"/tr><tr><td>%e03xx"
 835  3591 787878787878  	dc.b	"xxxxxxxx</td><td c"
 836  35a3 6c6173733d27  	dc.b	"lass='tclass'>Pack"
 837  35b5 657473206472  	dc.b	"ets dropped due to"
 838  35c7 2077726f6e67  	dc.b	" wrong IP version "
 839  35d9 6f7220686561  	dc.b	"or header length</"
 840  35eb 74643e3c2f74  	dc.b	"td></tr><tr><td>%e"
 841  35fd 303478787878  	dc.b	"04xxxxxxxxxx</td><"
 842  360f 746420636c61  	dc.b	"td class='tclass'>"
 843  3621 5061636b6574  	dc.b	"Packets dropped du"
 844  3633 652074        	dc.b	"e t"
 845  3636 6f2077726f6e  	dc.b	"o wrong IP length,"
 846  3648 206869676820  	dc.b	" high byte</td></t"
 847  365a 723e3c74723e  	dc.b	"r><tr><td>%e05xxxx"
 848  366c 787878787878  	dc.b	"xxxxxx</td><td cla"
 849  367e 73733d277463  	dc.b	"ss='tclass'>Packet"
 850  3690 732064726f70  	dc.b	"s dropped due to w"
 851  36a2 726f6e672049  	dc.b	"rong IP length, lo"
 852  36b4 772062797465  	dc.b	"w byte</td></tr><t"
 853  36c6 723e3c74643e  	dc.b	"r><td>%e06xxxxxxxx"
 854  36d8 78783c2f7464  	dc.b	"xx</td><td class='"
 855  36ea 74636c617373  	dc.b	"tclass'>Packets dr"
 856  36fc 6f7070656420  	dc.b	"opped since they w"
 857  370e 657265204950  	dc.b	"ere IP fragments</"
 858  3720 74643e3c2f74  	dc.b	"td></tr><tr><td>%e"
 859  3732 303778        	dc.b	"07x"
 860  3735 787878787878  	dc.b	"xxxxxxxxx</td><td "
 861  3747 636c6173733d  	dc.b	"class='tclass'>Pac"
 862  3759 6b6574732064  	dc.b	"kets dropped due t"
 863  376b 6f2049502063  	dc.b	"o IP checksum erro"
 864  377d 72733c2f7464  	dc.b	"rs</td></tr><tr><t"
 865  378f 643e25653038  	dc.b	"d>%e08xxxxxxxxxx</"
 866  37a1 74643e3c7464  	dc.b	"td><td class='tcla"
 867  37b3 7373273e5061  	dc.b	"ss'>Packets droppe"
 868  37c5 642073696e63  	dc.b	"d since they were "
 869  37d7 6e6f74204943  	dc.b	"not ICMP or TCP</t"
 870  37e9 643e3c2f7472  	dc.b	"d></tr><tr><td>%e0"
 871  37fb 397878787878  	dc.b	"9xxxxxxxxxx</td><t"
 872  380d 6420636c6173  	dc.b	"d class='tclass'>D"
 873  381f 726f70706564  	dc.b	"ropped ICMP packet"
 874  3831 733c2f        	dc.b	"s</"
 875  3834 74643e3c2f74  	dc.b	"td></tr><tr><td>%e"
 876  3846 313078787878  	dc.b	"10xxxxxxxxxx</td><"
 877  3858 746420636c61  	dc.b	"td class='tclass'>"
 878  386a 526563656976  	dc.b	"Received ICMP pack"
 879  387c 6574733c2f74  	dc.b	"ets</td></tr><tr><"
 880  388e 74643e256531  	dc.b	"td>%e11xxxxxxxxxx<"
 881  38a0 2f74643e3c74  	dc.b	"/td><td class='tcl"
 882  38b2 617373273e53  	dc.b	"ass'>Sent ICMP pac"
 883  38c4 6b6574733c2f  	dc.b	"kets</td></tr><tr>"
 884  38d6 3c74643e2565  	dc.b	"<td>%e12xxxxxxxxxx"
 885  38e8 3c2f74643e3c  	dc.b	"</td><td class='tc"
 886  38fa 6c617373273e  	dc.b	"lass'>ICMP packets"
 887  390c 207769746820  	dc.b	" with a wrong type"
 888  391e 3c2f74643e3c  	dc.b	"</td></tr><tr><td>"
 889  3930 256531        	dc.b	"%e1"
 890  3933 337878787878  	dc.b	"3xxxxxxxxxx</td><t"
 891  3945 6420636c6173  	dc.b	"d class='tclass'>D"
 892  3957 726f70706564  	dc.b	"ropped TCP segment"
 893  3969 733c2f74643e  	dc.b	"s</td></tr><tr><td"
 894  397b 3e2565313478  	dc.b	">%e14xxxxxxxxxx</t"
 895  398d 643e3c746420  	dc.b	"d><td class='tclas"
 896  399f 73273e526563  	dc.b	"s'>Received TCP se"
 897  39b1 676d656e7473  	dc.b	"gments</td></tr><t"
 898  39c3 723e3c74643e  	dc.b	"r><td>%e15xxxxxxxx"
 899  39d5 78783c2f7464  	dc.b	"xx</td><td class='"
 900  39e7 74636c617373  	dc.b	"tclass'>Sent TCP s"
 901  39f9 65676d656e74  	dc.b	"egments</td></tr><"
 902  3a0b 74723e3c7464  	dc.b	"tr><td>%e16xxxxxxx"
 903  3a1d 7878783c2f74  	dc.b	"xxx</td><td class="
 904  3a2f 277463        	dc.b	"'tc"
 905  3a32 6c617373273e  	dc.b	"lass'>TCP segments"
 906  3a44 207769746820  	dc.b	" with a bad checks"
 907  3a56 756d3c2f7464  	dc.b	"um</td></tr><tr><t"
 908  3a68 643e25653137  	dc.b	"d>%e17xxxxxxxxxx</"
 909  3a7a 74643e3c7464  	dc.b	"td><td class='tcla"
 910  3a8c 7373273e5443  	dc.b	"ss'>TCP segments w"
 911  3a9e 697468206120  	dc.b	"ith a bad ACK numb"
 912  3ab0 65723c2f7464  	dc.b	"er</td></tr><tr><t"
 913  3ac2 643e25653138  	dc.b	"d>%e18xxxxxxxxxx</"
 914  3ad4 74643e3c7464  	dc.b	"td><td class='tcla"
 915  3ae6 7373273e5265  	dc.b	"ss'>Received TCP R"
 916  3af8 535420287265  	dc.b	"ST (reset) segment"
 917  3b0a 733c2f74643e  	dc.b	"s</td></tr><tr><td"
 918  3b1c 3e2565313978  	dc.b	">%e19xxxxxxxxxx</t"
 919  3b2e 643e3c        	dc.b	"d><"
 920  3b31 746420636c61  	dc.b	"td class='tclass'>"
 921  3b43 52657472616e  	dc.b	"Retransmitted TCP "
 922  3b55 7365676d656e  	dc.b	"segments</td></tr>"
 923  3b67 3c74723e3c74  	dc.b	"<tr><td>%e20xxxxxx"
 924  3b79 787878783c2f  	dc.b	"xxxx</td><td class"
 925  3b8b 3d2774636c61  	dc.b	"='tclass'>Dropped "
 926  3b9d 53594e732064  	dc.b	"SYNs due to too fe"
 927  3baf 7720636f6e6e  	dc.b	"w connections aval"
 928  3bc1 6961626c653c  	dc.b	"iable</td></tr><tr"
 929  3bd3 3e3c74643e25  	dc.b	"><td>%e21xxxxxxxxx"
 930  3be5 783c2f74643e  	dc.b	"x</td><td class='t"
 931  3bf7 636c61737327  	dc.b	"class'>SYNs for cl"
 932  3c09 6f7365642070  	dc.b	"osed ports, trigge"
 933  3c1b 72696e672061  	dc.b	"ring a RST</td></t"
 934  3c2d 723e3c        	dc.b	"r><"
 935  3c30 2f7461626c65  	dc.b	"/table><a href='%x"
 936  3c42 303068747470  	dc.b	"00http://192.168.0"
 937  3c54 30312e303034  	dc.b	"01.004:08080/60'><"
 938  3c66 627574746f6e  	dc.b	"button title='Go t"
 939  3c78 6f2052656c61  	dc.b	"o Relay Control Pa"
 940  3c8a 6765273e5265  	dc.b	"ge'>Relay Controls"
 941  3c9c 3c2f62757474  	dc.b	"</button></a></bod"
 942  3cae 793e3c2f6874  	dc.b	"y></html>",0
 943  3cb8               L72_g_HtmlPageRstate:
 944  3cb8 3c21444f4354  	dc.b	"<!DOCTYPE HTML PUB"
 945  3cca 4c49432022    	dc.b	"LIC ",34
 946  3ccf 2d2f2f573343  	dc.b	"-//W3C//DTD HTML 4"
 947  3ce1 2e3031205472  	dc.b	".01 Transitional//"
 948  3cf3 454e22        	dc.b	"EN",34
 949  3cf6 3e3c68746d6c  	dc.b	"><html><head><styl"
 950  3d08 652074797065  	dc.b	"e type='text/css'>"
 951  3d1a 3c2f7374796c  	dc.b	"</style></head><bo"
 952  3d2c 64793e3c703e  	dc.b	"dy><p>%f00xxxxxxxx"
 953  3d3e 787878787878  	dc.b	"xxxxxxxx</p></body"
 954  3d50 3e3c2f68746d  	dc.b	"></html>",0
1020                     ; 459 static uint16_t CopyStringP(uint8_t** ppBuffer, const char* pString)
1020                     ; 460 {
1022                     	switch	.text
1023  0000               L3_CopyStringP:
1025  0000 89            	pushw	x
1026  0001 5203          	subw	sp,#3
1027       00000003      OFST:	set	3
1030                     ; 465   nBytes = 0;
1032  0003 5f            	clrw	x
1034  0004 2014          	jra	L17
1035  0006               L56:
1036                     ; 467     **ppBuffer = Character;
1038  0006 1e04          	ldw	x,(OFST+1,sp)
1039  0008 fe            	ldw	x,(x)
1040  0009 f7            	ld	(x),a
1041                     ; 468     *ppBuffer = *ppBuffer + 1;
1043  000a 1e04          	ldw	x,(OFST+1,sp)
1044  000c 9093          	ldw	y,x
1045  000e fe            	ldw	x,(x)
1046  000f 5c            	incw	x
1047  0010 90ff          	ldw	(y),x
1048                     ; 469     pString = pString + 1;
1050  0012 1e08          	ldw	x,(OFST+5,sp)
1051  0014 5c            	incw	x
1052  0015 1f08          	ldw	(OFST+5,sp),x
1053                     ; 470     nBytes++;
1055  0017 1e01          	ldw	x,(OFST-2,sp)
1056  0019 5c            	incw	x
1057  001a               L17:
1058  001a 1f01          	ldw	(OFST-2,sp),x
1060                     ; 466   while ((Character = pString[0]) != '\0') {
1060                     ; 467     **ppBuffer = Character;
1060                     ; 468     *ppBuffer = *ppBuffer + 1;
1060                     ; 469     pString = pString + 1;
1060                     ; 470     nBytes++;
1062  001c 1e08          	ldw	x,(OFST+5,sp)
1063  001e f6            	ld	a,(x)
1064  001f 6b03          	ld	(OFST+0,sp),a
1066  0021 26e3          	jrne	L56
1067                     ; 472   return nBytes;
1069  0023 1e01          	ldw	x,(OFST-2,sp)
1072  0025 5b05          	addw	sp,#5
1073  0027 81            	ret	
1118                     ; 476 static uint16_t CopyValue(uint8_t** ppBuffer, uint32_t nValue)
1118                     ; 477 {
1119                     	switch	.text
1120  0028               L5_CopyValue:
1122  0028 89            	pushw	x
1123       00000000      OFST:	set	0
1126                     ; 485   emb_itoa(nValue, OctetArray, 10, 5);
1128  0029 4b05          	push	#5
1129  002b 4b0a          	push	#10
1130  002d ae0000        	ldw	x,#_OctetArray
1131  0030 89            	pushw	x
1132  0031 1e0b          	ldw	x,(OFST+11,sp)
1133  0033 89            	pushw	x
1134  0034 1e0b          	ldw	x,(OFST+11,sp)
1135  0036 89            	pushw	x
1136  0037 ad53          	call	_emb_itoa
1138  0039 5b08          	addw	sp,#8
1139                     ; 487   **ppBuffer = OctetArray[0];
1141  003b 1e01          	ldw	x,(OFST+1,sp)
1142  003d fe            	ldw	x,(x)
1143  003e c60000        	ld	a,_OctetArray
1144  0041 f7            	ld	(x),a
1145                     ; 488   *ppBuffer = *ppBuffer + 1;
1147  0042 1e01          	ldw	x,(OFST+1,sp)
1148  0044 9093          	ldw	y,x
1149  0046 fe            	ldw	x,(x)
1150  0047 5c            	incw	x
1151  0048 90ff          	ldw	(y),x
1152                     ; 490   **ppBuffer = OctetArray[1];
1154  004a 1e01          	ldw	x,(OFST+1,sp)
1155  004c fe            	ldw	x,(x)
1156  004d c60001        	ld	a,_OctetArray+1
1157  0050 f7            	ld	(x),a
1158                     ; 491   *ppBuffer = *ppBuffer + 1;
1160  0051 1e01          	ldw	x,(OFST+1,sp)
1161  0053 9093          	ldw	y,x
1162  0055 fe            	ldw	x,(x)
1163  0056 5c            	incw	x
1164  0057 90ff          	ldw	(y),x
1165                     ; 493   **ppBuffer = OctetArray[2];
1167  0059 1e01          	ldw	x,(OFST+1,sp)
1168  005b fe            	ldw	x,(x)
1169  005c c60002        	ld	a,_OctetArray+2
1170  005f f7            	ld	(x),a
1171                     ; 494   *ppBuffer = *ppBuffer + 1;
1173  0060 1e01          	ldw	x,(OFST+1,sp)
1174  0062 9093          	ldw	y,x
1175  0064 fe            	ldw	x,(x)
1176  0065 5c            	incw	x
1177  0066 90ff          	ldw	(y),x
1178                     ; 496   **ppBuffer = OctetArray[3];
1180  0068 1e01          	ldw	x,(OFST+1,sp)
1181  006a fe            	ldw	x,(x)
1182  006b c60003        	ld	a,_OctetArray+3
1183  006e f7            	ld	(x),a
1184                     ; 497   *ppBuffer = *ppBuffer + 1;
1186  006f 1e01          	ldw	x,(OFST+1,sp)
1187  0071 9093          	ldw	y,x
1188  0073 fe            	ldw	x,(x)
1189  0074 5c            	incw	x
1190  0075 90ff          	ldw	(y),x
1191                     ; 499   **ppBuffer = OctetArray[4];
1193  0077 1e01          	ldw	x,(OFST+1,sp)
1194  0079 fe            	ldw	x,(x)
1195  007a c60004        	ld	a,_OctetArray+4
1196  007d f7            	ld	(x),a
1197                     ; 500   *ppBuffer = *ppBuffer + 1;
1199  007e 1e01          	ldw	x,(OFST+1,sp)
1200  0080 9093          	ldw	y,x
1201  0082 fe            	ldw	x,(x)
1202  0083 5c            	incw	x
1203  0084 90ff          	ldw	(y),x
1204                     ; 502   return 5;
1206  0086 ae0005        	ldw	x,#5
1209  0089 5b02          	addw	sp,#2
1210  008b 81            	ret	
1282                     ; 506 char* emb_itoa(uint32_t num, char* str, uint8_t base, uint8_t pad)
1282                     ; 507 {
1283                     	switch	.text
1284  008c               _emb_itoa:
1286  008c 5206          	subw	sp,#6
1287       00000006      OFST:	set	6
1290                     ; 522   for (i=0; i < 10; i++) str[i] = '0';
1292  008e 4f            	clr	a
1293  008f 6b06          	ld	(OFST+0,sp),a
1295  0091               L541:
1298  0091 5f            	clrw	x
1299  0092 97            	ld	xl,a
1300  0093 72fb0d        	addw	x,(OFST+7,sp)
1301  0096 a630          	ld	a,#48
1302  0098 f7            	ld	(x),a
1305  0099 0c06          	inc	(OFST+0,sp)
1309  009b 7b06          	ld	a,(OFST+0,sp)
1310  009d a10a          	cp	a,#10
1311  009f 25f0          	jrult	L541
1312                     ; 523   str[pad] = '\0';
1314  00a1 7b10          	ld	a,(OFST+10,sp)
1315  00a3 5f            	clrw	x
1316  00a4 97            	ld	xl,a
1317  00a5 72fb0d        	addw	x,(OFST+7,sp)
1318  00a8 7f            	clr	(x)
1319                     ; 524   if (num == 0) return str;
1321  00a9 96            	ldw	x,sp
1322  00aa 1c0009        	addw	x,#OFST+3
1323  00ad cd0000        	call	c_lzmp
1327  00b0 2775          	jreq	L61
1328                     ; 527   i = 0;
1330  00b2 0f06          	clr	(OFST+0,sp)
1333  00b4 2060          	jra	L161
1334  00b6               L551:
1335                     ; 529     rem = (uint8_t)(num % base);
1337  00b6 7b0f          	ld	a,(OFST+9,sp)
1338  00b8 b703          	ld	c_lreg+3,a
1339  00ba 3f02          	clr	c_lreg+2
1340  00bc 3f01          	clr	c_lreg+1
1341  00be 3f00          	clr	c_lreg
1342  00c0 96            	ldw	x,sp
1343  00c1 5c            	incw	x
1344  00c2 cd0000        	call	c_rtol
1347  00c5 96            	ldw	x,sp
1348  00c6 1c0009        	addw	x,#OFST+3
1349  00c9 cd0000        	call	c_ltor
1351  00cc 96            	ldw	x,sp
1352  00cd 5c            	incw	x
1353  00ce cd0000        	call	c_lumd
1355  00d1 b603          	ld	a,c_lreg+3
1356  00d3 6b05          	ld	(OFST-1,sp),a
1358                     ; 530     if(rem > 9) str[i++] = (uint8_t)(rem - 10 + 'a');
1360  00d5 a10a          	cp	a,#10
1361  00d7 7b06          	ld	a,(OFST+0,sp)
1362  00d9 250d          	jrult	L561
1365  00db 0c06          	inc	(OFST+0,sp)
1367  00dd 5f            	clrw	x
1368  00de 97            	ld	xl,a
1369  00df 72fb0d        	addw	x,(OFST+7,sp)
1370  00e2 7b05          	ld	a,(OFST-1,sp)
1371  00e4 ab57          	add	a,#87
1373  00e6 200b          	jra	L761
1374  00e8               L561:
1375                     ; 531     else str[i++] = (uint8_t)(rem + '0');
1377  00e8 0c06          	inc	(OFST+0,sp)
1379  00ea 5f            	clrw	x
1380  00eb 97            	ld	xl,a
1381  00ec 72fb0d        	addw	x,(OFST+7,sp)
1382  00ef 7b05          	ld	a,(OFST-1,sp)
1383  00f1 ab30          	add	a,#48
1384  00f3               L761:
1385  00f3 f7            	ld	(x),a
1386                     ; 532     num = num/base;
1388  00f4 7b0f          	ld	a,(OFST+9,sp)
1389  00f6 b703          	ld	c_lreg+3,a
1390  00f8 3f02          	clr	c_lreg+2
1391  00fa 3f01          	clr	c_lreg+1
1392  00fc 3f00          	clr	c_lreg
1393  00fe 96            	ldw	x,sp
1394  00ff 5c            	incw	x
1395  0100 cd0000        	call	c_rtol
1398  0103 96            	ldw	x,sp
1399  0104 1c0009        	addw	x,#OFST+3
1400  0107 cd0000        	call	c_ltor
1402  010a 96            	ldw	x,sp
1403  010b 5c            	incw	x
1404  010c cd0000        	call	c_ludv
1406  010f 96            	ldw	x,sp
1407  0110 1c0009        	addw	x,#OFST+3
1408  0113 cd0000        	call	c_rtol
1410  0116               L161:
1411                     ; 528   while (num != 0) {
1413  0116 96            	ldw	x,sp
1414  0117 1c0009        	addw	x,#OFST+3
1415  011a cd0000        	call	c_lzmp
1417  011d 2697          	jrne	L551
1418                     ; 536   reverse(str, pad);
1420  011f 7b10          	ld	a,(OFST+10,sp)
1421  0121 88            	push	a
1422  0122 1e0e          	ldw	x,(OFST+8,sp)
1423  0124 ad06          	call	_reverse
1425  0126 84            	pop	a
1426                     ; 538   return str;
1429  0127               L61:
1431  0127 1e0d          	ldw	x,(OFST+7,sp)
1433  0129 5b06          	addw	sp,#6
1434  012b 81            	ret	
1497                     ; 543 void reverse(char str[], uint8_t length)
1497                     ; 544 {
1498                     	switch	.text
1499  012c               _reverse:
1501  012c 89            	pushw	x
1502  012d 5203          	subw	sp,#3
1503       00000003      OFST:	set	3
1506                     ; 549   start = 0;
1508  012f 0f02          	clr	(OFST-1,sp)
1510                     ; 550   end = (uint8_t)(length - 1);
1512  0131 7b08          	ld	a,(OFST+5,sp)
1513  0133 4a            	dec	a
1514  0134 6b03          	ld	(OFST+0,sp),a
1517  0136 2029          	jra	L322
1518  0138               L712:
1519                     ; 553     temp = str[start];
1521  0138 5f            	clrw	x
1522  0139 97            	ld	xl,a
1523  013a 72fb04        	addw	x,(OFST+1,sp)
1524  013d f6            	ld	a,(x)
1525  013e 6b01          	ld	(OFST-2,sp),a
1527                     ; 554     str[start] = str[end];
1529  0140 5f            	clrw	x
1530  0141 7b02          	ld	a,(OFST-1,sp)
1531  0143 97            	ld	xl,a
1532  0144 72fb04        	addw	x,(OFST+1,sp)
1533  0147 7b03          	ld	a,(OFST+0,sp)
1534  0149 905f          	clrw	y
1535  014b 9097          	ld	yl,a
1536  014d 72f904        	addw	y,(OFST+1,sp)
1537  0150 90f6          	ld	a,(y)
1538  0152 f7            	ld	(x),a
1539                     ; 555     str[end] = temp;
1541  0153 5f            	clrw	x
1542  0154 7b03          	ld	a,(OFST+0,sp)
1543  0156 97            	ld	xl,a
1544  0157 72fb04        	addw	x,(OFST+1,sp)
1545  015a 7b01          	ld	a,(OFST-2,sp)
1546  015c f7            	ld	(x),a
1547                     ; 556     start++;
1549  015d 0c02          	inc	(OFST-1,sp)
1551                     ; 557     end--;
1553  015f 0a03          	dec	(OFST+0,sp)
1555  0161               L322:
1556                     ; 552   while (start < end) {
1556                     ; 553     temp = str[start];
1556                     ; 554     str[start] = str[end];
1556                     ; 555     str[end] = temp;
1556                     ; 556     start++;
1556                     ; 557     end--;
1558  0161 7b02          	ld	a,(OFST-1,sp)
1559  0163 1103          	cp	a,(OFST+0,sp)
1560  0165 25d1          	jrult	L712
1561                     ; 559 }
1564  0167 5b05          	addw	sp,#5
1565  0169 81            	ret	
1626                     ; 562 uint8_t three_alpha_to_uint(uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
1626                     ; 563 {
1627                     	switch	.text
1628  016a               _three_alpha_to_uint:
1630  016a 89            	pushw	x
1631  016b 89            	pushw	x
1632       00000002      OFST:	set	2
1635                     ; 571   value = (uint8_t)((alpha1 - '0') *100);
1637  016c 9e            	ld	a,xh
1638  016d 97            	ld	xl,a
1639  016e a664          	ld	a,#100
1640  0170 42            	mul	x,a
1641  0171 9f            	ld	a,xl
1642  0172 a0c0          	sub	a,#192
1643  0174 6b02          	ld	(OFST+0,sp),a
1645                     ; 572   digit = (uint8_t)((alpha2 - '0') * 10);
1647  0176 7b04          	ld	a,(OFST+2,sp)
1648  0178 97            	ld	xl,a
1649  0179 a60a          	ld	a,#10
1650  017b 42            	mul	x,a
1651  017c 9f            	ld	a,xl
1652  017d a0e0          	sub	a,#224
1654                     ; 573   value = (uint8_t)(value + digit);
1656  017f 1b02          	add	a,(OFST+0,sp)
1657  0181 6b02          	ld	(OFST+0,sp),a
1659                     ; 574   digit = (uint8_t)(alpha3 - '0');
1661  0183 7b07          	ld	a,(OFST+5,sp)
1662  0185 a030          	sub	a,#48
1663  0187 6b01          	ld	(OFST-1,sp),a
1665                     ; 575   value = (uint8_t)(value + digit);
1667  0189 1b02          	add	a,(OFST+0,sp)
1669                     ; 577   if(value >= 255) value = 0;
1671  018b a1ff          	cp	a,#255
1672  018d 2501          	jrult	L352
1675  018f 4f            	clr	a
1677  0190               L352:
1678                     ; 579   return value;
1682  0190 5b04          	addw	sp,#4
1683  0192 81            	ret	
1729                     ; 583 uint8_t two_alpha_to_uint(uint8_t alpha1, uint8_t alpha2)
1729                     ; 584 {
1730                     	switch	.text
1731  0193               _two_alpha_to_uint:
1733  0193 89            	pushw	x
1734  0194 88            	push	a
1735       00000001      OFST:	set	1
1738                     ; 591   if (alpha1 >= '0' && alpha1 <= '9') value = (uint8_t)((alpha1 - '0') << 4);
1740  0195 9e            	ld	a,xh
1741  0196 a130          	cp	a,#48
1742  0198 250f          	jrult	L572
1744  019a 9e            	ld	a,xh
1745  019b a13a          	cp	a,#58
1746  019d 240a          	jruge	L572
1749  019f 9e            	ld	a,xh
1750  01a0 97            	ld	xl,a
1751  01a1 a610          	ld	a,#16
1752  01a3 42            	mul	x,a
1753  01a4 9f            	ld	a,xl
1754  01a5 a000          	sub	a,#0
1756  01a7 2030          	jp	LC001
1757  01a9               L572:
1758                     ; 592   else if(alpha1 == 'a') value = 0xa0;
1760  01a9 7b02          	ld	a,(OFST+1,sp)
1761  01ab a161          	cp	a,#97
1762  01ad 2604          	jrne	L103
1765  01af a6a0          	ld	a,#160
1767  01b1 2026          	jp	LC001
1768  01b3               L103:
1769                     ; 593   else if(alpha1 == 'b') value = 0xb0;
1771  01b3 a162          	cp	a,#98
1772  01b5 2604          	jrne	L503
1775  01b7 a6b0          	ld	a,#176
1777  01b9 201e          	jp	LC001
1778  01bb               L503:
1779                     ; 594   else if(alpha1 == 'c') value = 0xc0;
1781  01bb a163          	cp	a,#99
1782  01bd 2604          	jrne	L113
1785  01bf a6c0          	ld	a,#192
1787  01c1 2016          	jp	LC001
1788  01c3               L113:
1789                     ; 595   else if(alpha1 == 'd') value = 0xd0;
1791  01c3 a164          	cp	a,#100
1792  01c5 2604          	jrne	L513
1795  01c7 a6d0          	ld	a,#208
1797  01c9 200e          	jp	LC001
1798  01cb               L513:
1799                     ; 596   else if(alpha1 == 'e') value = 0xe0;
1801  01cb a165          	cp	a,#101
1802  01cd 2604          	jrne	L123
1805  01cf a6e0          	ld	a,#224
1807  01d1 2006          	jp	LC001
1808  01d3               L123:
1809                     ; 597   else if(alpha1 == 'f') value = 0xf0;
1811  01d3 a166          	cp	a,#102
1812  01d5 2606          	jrne	L523
1815  01d7 a6f0          	ld	a,#240
1816  01d9               LC001:
1817  01d9 6b01          	ld	(OFST+0,sp),a
1820  01db 2002          	jra	L772
1821  01dd               L523:
1822                     ; 598   else value = 0; // If an invalid entry is made convert it to 0
1824  01dd 0f01          	clr	(OFST+0,sp)
1826  01df               L772:
1827                     ; 600   if (alpha2 >= '0' && alpha2 <= '9') value = (uint8_t)(value + alpha2 - '0');
1829  01df 7b03          	ld	a,(OFST+2,sp)
1830  01e1 a130          	cp	a,#48
1831  01e3 250c          	jrult	L133
1833  01e5 a13a          	cp	a,#58
1834  01e7 2408          	jruge	L133
1837  01e9 7b01          	ld	a,(OFST+0,sp)
1838  01eb 1b03          	add	a,(OFST+2,sp)
1839  01ed a030          	sub	a,#48
1841  01ef 203d          	jp	L333
1842  01f1               L133:
1843                     ; 601   else if(alpha2 == 'a') value = (uint8_t)(value + 0x0a);
1845  01f1 a161          	cp	a,#97
1846  01f3 2606          	jrne	L533
1849  01f5 7b01          	ld	a,(OFST+0,sp)
1850  01f7 ab0a          	add	a,#10
1852  01f9 2033          	jp	L333
1853  01fb               L533:
1854                     ; 602   else if(alpha2 == 'b') value = (uint8_t)(value + 0x0b);
1856  01fb a162          	cp	a,#98
1857  01fd 2606          	jrne	L143
1860  01ff 7b01          	ld	a,(OFST+0,sp)
1861  0201 ab0b          	add	a,#11
1863  0203 2029          	jp	L333
1864  0205               L143:
1865                     ; 603   else if(alpha2 == 'c') value = (uint8_t)(value + 0x0c);
1867  0205 a163          	cp	a,#99
1868  0207 2606          	jrne	L543
1871  0209 7b01          	ld	a,(OFST+0,sp)
1872  020b ab0c          	add	a,#12
1874  020d 201f          	jp	L333
1875  020f               L543:
1876                     ; 604   else if(alpha2 == 'd') value = (uint8_t)(value + 0x0d);
1878  020f a164          	cp	a,#100
1879  0211 2606          	jrne	L153
1882  0213 7b01          	ld	a,(OFST+0,sp)
1883  0215 ab0d          	add	a,#13
1885  0217 2015          	jp	L333
1886  0219               L153:
1887                     ; 605   else if(alpha2 == 'e') value = (uint8_t)(value + 0x0e);
1889  0219 a165          	cp	a,#101
1890  021b 2606          	jrne	L553
1893  021d 7b01          	ld	a,(OFST+0,sp)
1894  021f ab0e          	add	a,#14
1896  0221 200b          	jp	L333
1897  0223               L553:
1898                     ; 606   else if(alpha2 == 'f') value = (uint8_t)(value + 0x0f);
1900  0223 a166          	cp	a,#102
1901  0225 2606          	jrne	L163
1904  0227 7b01          	ld	a,(OFST+0,sp)
1905  0229 ab0f          	add	a,#15
1908  022b 2001          	jra	L333
1909  022d               L163:
1910                     ; 607   else value = 0; // If an invalid entry is made convert it to 0
1912  022d 4f            	clr	a
1914  022e               L333:
1915                     ; 609   return value;
1919  022e 5b03          	addw	sp,#3
1920  0230 81            	ret	
1971                     ; 613 static uint16_t CopyHttpHeader(uint8_t* pBuffer, uint32_t nDataLen)
1971                     ; 614 {
1972                     	switch	.text
1973  0231               L7_CopyHttpHeader:
1975  0231 89            	pushw	x
1976  0232 89            	pushw	x
1977       00000002      OFST:	set	2
1980                     ; 617   nBytes = 0;
1982  0233 5f            	clrw	x
1983  0234 1f01          	ldw	(OFST-1,sp),x
1985                     ; 619   nBytes += CopyStringP(&pBuffer, (const char *)("HTTP/1.1 200 OK"));
1987  0236 ae3e9a        	ldw	x,#L704
1988  0239 89            	pushw	x
1989  023a 96            	ldw	x,sp
1990  023b 1c0005        	addw	x,#OFST+3
1991  023e cd0000        	call	L3_CopyStringP
1993  0241 5b02          	addw	sp,#2
1994  0243 72fb01        	addw	x,(OFST-1,sp)
1995  0246 1f01          	ldw	(OFST-1,sp),x
1997                     ; 620   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
1999  0248 ae3e97        	ldw	x,#L114
2000  024b 89            	pushw	x
2001  024c 96            	ldw	x,sp
2002  024d 1c0005        	addw	x,#OFST+3
2003  0250 cd0000        	call	L3_CopyStringP
2005  0253 5b02          	addw	sp,#2
2006  0255 72fb01        	addw	x,(OFST-1,sp)
2007  0258 1f01          	ldw	(OFST-1,sp),x
2009                     ; 622   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Length:"));
2011  025a ae3e87        	ldw	x,#L314
2012  025d 89            	pushw	x
2013  025e 96            	ldw	x,sp
2014  025f 1c0005        	addw	x,#OFST+3
2015  0262 cd0000        	call	L3_CopyStringP
2017  0265 5b02          	addw	sp,#2
2018  0267 72fb01        	addw	x,(OFST-1,sp)
2019  026a 1f01          	ldw	(OFST-1,sp),x
2021                     ; 623   nBytes += CopyValue(&pBuffer, nDataLen);
2023  026c 1e09          	ldw	x,(OFST+7,sp)
2024  026e 89            	pushw	x
2025  026f 1e09          	ldw	x,(OFST+7,sp)
2026  0271 89            	pushw	x
2027  0272 96            	ldw	x,sp
2028  0273 1c0007        	addw	x,#OFST+5
2029  0276 cd0028        	call	L5_CopyValue
2031  0279 5b04          	addw	sp,#4
2032  027b 72fb01        	addw	x,(OFST-1,sp)
2033  027e 1f01          	ldw	(OFST-1,sp),x
2035                     ; 624   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2037  0280 ae3e97        	ldw	x,#L114
2038  0283 89            	pushw	x
2039  0284 96            	ldw	x,sp
2040  0285 1c0005        	addw	x,#OFST+3
2041  0288 cd0000        	call	L3_CopyStringP
2043  028b 5b02          	addw	sp,#2
2044  028d 72fb01        	addw	x,(OFST-1,sp)
2045  0290 1f01          	ldw	(OFST-1,sp),x
2047                     ; 626   nBytes += CopyStringP(&pBuffer, (const char *)("Content-Type:text/html\r\n"));
2049  0292 ae3e6e        	ldw	x,#L514
2050  0295 89            	pushw	x
2051  0296 96            	ldw	x,sp
2052  0297 1c0005        	addw	x,#OFST+3
2053  029a cd0000        	call	L3_CopyStringP
2055  029d 5b02          	addw	sp,#2
2056  029f 72fb01        	addw	x,(OFST-1,sp)
2057  02a2 1f01          	ldw	(OFST-1,sp),x
2059                     ; 627   nBytes += CopyStringP(&pBuffer, (const char *)("Connection:close\r\n"));
2061  02a4 ae3e5b        	ldw	x,#L714
2062  02a7 89            	pushw	x
2063  02a8 96            	ldw	x,sp
2064  02a9 1c0005        	addw	x,#OFST+3
2065  02ac cd0000        	call	L3_CopyStringP
2067  02af 5b02          	addw	sp,#2
2068  02b1 72fb01        	addw	x,(OFST-1,sp)
2069  02b4 1f01          	ldw	(OFST-1,sp),x
2071                     ; 628   nBytes += CopyStringP(&pBuffer, (const char *)("\r\n"));
2073  02b6 ae3e97        	ldw	x,#L114
2074  02b9 89            	pushw	x
2075  02ba 96            	ldw	x,sp
2076  02bb 1c0005        	addw	x,#OFST+3
2077  02be cd0000        	call	L3_CopyStringP
2079  02c1 5b02          	addw	sp,#2
2080  02c3 72fb01        	addw	x,(OFST-1,sp)
2082                     ; 630   return nBytes;
2086  02c6 5b04          	addw	sp,#4
2087  02c8 81            	ret	
2226                     	switch	.const
2227  3d59               L421:
2228  3d59 046d          	dc.w	L124
2229  3d5b 047b          	dc.w	L324
2230  3d5d 0489          	dc.w	L524
2231  3d5f 0496          	dc.w	L724
2232  3d61 04a3          	dc.w	L134
2233  3d63 04b0          	dc.w	L334
2234  3d65 04bd          	dc.w	L534
2235  3d67 04ca          	dc.w	L734
2236  3d69 04d7          	dc.w	L144
2237  3d6b 04e4          	dc.w	L344
2238  3d6d 04f1          	dc.w	L544
2239  3d6f 04fe          	dc.w	L744
2240  3d71               L422:
2241  3d71 063d          	dc.w	L354
2242  3d73 064f          	dc.w	L554
2243  3d75 0661          	dc.w	L754
2244  3d77 0673          	dc.w	L164
2245  3d79 0685          	dc.w	L364
2246  3d7b 0697          	dc.w	L564
2247  3d7d 06a9          	dc.w	L764
2248  3d7f 06bb          	dc.w	L174
2249  3d81 06cd          	dc.w	L374
2250  3d83 06df          	dc.w	L574
2251  3d85 06f1          	dc.w	L774
2252  3d87 0703          	dc.w	L105
2253  3d89 0715          	dc.w	L305
2254  3d8b 0727          	dc.w	L505
2255  3d8d 0739          	dc.w	L705
2256  3d8f 074b          	dc.w	L115
2257  3d91 075c          	dc.w	L315
2258  3d93 076d          	dc.w	L515
2259  3d95 077e          	dc.w	L715
2260  3d97 078f          	dc.w	L125
2261  3d99 07a0          	dc.w	L325
2262  3d9b 07b1          	dc.w	L525
2263                     ; 634 static uint16_t CopyHttpData(uint8_t* pBuffer, const char** ppData, uint16_t* pDataLeft, uint16_t nMaxBytes)
2263                     ; 635 {
2264                     	switch	.text
2265  02c9               L11_CopyHttpData:
2267  02c9 89            	pushw	x
2268  02ca 5207          	subw	sp,#7
2269       00000007      OFST:	set	7
2272                     ; 651   nBytes = 0;
2274  02cc 5f            	clrw	x
2275  02cd 1f05          	ldw	(OFST-2,sp),x
2277                     ; 687   if(nMaxBytes > 400) nMaxBytes = 400; // limit just in case
2279  02cf 1e10          	ldw	x,(OFST+9,sp)
2280  02d1 a30191        	cpw	x,#401
2281  02d4 2403cc0a5d    	jrult	L306
2284  02d9 ae0190        	ldw	x,#400
2285  02dc 1f10          	ldw	(OFST+9,sp),x
2286  02de cc0a5d        	jra	L306
2287  02e1               L106:
2288                     ; 710     if (*pDataLeft > 0) {
2290  02e1 1e0e          	ldw	x,(OFST+7,sp)
2291  02e3 e601          	ld	a,(1,x)
2292  02e5 fa            	or	a,(x)
2293  02e6 2603cc0a66    	jreq	L506
2294                     ; 714       memcpy(&nByte, *ppData, 1);
2296  02eb 96            	ldw	x,sp
2297  02ec 5c            	incw	x
2298  02ed bf00          	ldw	c_x,x
2299  02ef 160c          	ldw	y,(OFST+5,sp)
2300  02f1 90fe          	ldw	y,(y)
2301  02f3 90bf00        	ldw	c_y,y
2302  02f6 ae0001        	ldw	x,#1
2303  02f9               L25:
2304  02f9 5a            	decw	x
2305  02fa 92d600        	ld	a,([c_y.w],x)
2306  02fd 92d700        	ld	([c_x.w],x),a
2307  0300 5d            	tnzw	x
2308  0301 26f6          	jrne	L25
2309                     ; 740       if (nByte == '%') {
2311  0303 7b01          	ld	a,(OFST-6,sp)
2312  0305 a125          	cp	a,#37
2313  0307 2703cc0a40    	jrne	L116
2314                     ; 741         *ppData = *ppData + 1;
2316  030c 1e0c          	ldw	x,(OFST+5,sp)
2317  030e 9093          	ldw	y,x
2318  0310 fe            	ldw	x,(x)
2319  0311 5c            	incw	x
2320  0312 90ff          	ldw	(y),x
2321                     ; 742         *pDataLeft = *pDataLeft - 1;
2323  0314 1e0e          	ldw	x,(OFST+7,sp)
2324  0316 9093          	ldw	y,x
2325  0318 fe            	ldw	x,(x)
2326  0319 5a            	decw	x
2327  031a 90ff          	ldw	(y),x
2328                     ; 747         memcpy(&nParsedMode, *ppData, 1);
2330  031c 96            	ldw	x,sp
2331  031d 1c0003        	addw	x,#OFST-4
2332  0320 bf00          	ldw	c_x,x
2333  0322 160c          	ldw	y,(OFST+5,sp)
2334  0324 90fe          	ldw	y,(y)
2335  0326 90bf00        	ldw	c_y,y
2336  0329 ae0001        	ldw	x,#1
2337  032c               L45:
2338  032c 5a            	decw	x
2339  032d 92d600        	ld	a,([c_y.w],x)
2340  0330 92d700        	ld	([c_x.w],x),a
2341  0333 5d            	tnzw	x
2342  0334 26f6          	jrne	L45
2343                     ; 748         *ppData = *ppData + 1;
2345  0336 1e0c          	ldw	x,(OFST+5,sp)
2346  0338 9093          	ldw	y,x
2347  033a fe            	ldw	x,(x)
2348  033b 5c            	incw	x
2349  033c 90ff          	ldw	(y),x
2350                     ; 749         *pDataLeft = *pDataLeft - 1;
2352  033e 1e0e          	ldw	x,(OFST+7,sp)
2353  0340 9093          	ldw	y,x
2354  0342 fe            	ldw	x,(x)
2355  0343 5a            	decw	x
2356  0344 90ff          	ldw	(y),x
2357                     ; 753         memcpy(&temp, *ppData, 1);
2359  0346 96            	ldw	x,sp
2360  0347 1c0002        	addw	x,#OFST-5
2361  034a bf00          	ldw	c_x,x
2362  034c 160c          	ldw	y,(OFST+5,sp)
2363  034e 90fe          	ldw	y,(y)
2364  0350 90bf00        	ldw	c_y,y
2365  0353 ae0001        	ldw	x,#1
2366  0356               L65:
2367  0356 5a            	decw	x
2368  0357 92d600        	ld	a,([c_y.w],x)
2369  035a 92d700        	ld	([c_x.w],x),a
2370  035d 5d            	tnzw	x
2371  035e 26f6          	jrne	L65
2372                     ; 754 	nParsedNum = (uint8_t)((temp - '0') * 10);
2374  0360 7b02          	ld	a,(OFST-5,sp)
2375  0362 97            	ld	xl,a
2376  0363 a60a          	ld	a,#10
2377  0365 42            	mul	x,a
2378  0366 9f            	ld	a,xl
2379  0367 a0e0          	sub	a,#224
2380  0369 6b04          	ld	(OFST-3,sp),a
2382                     ; 755         *ppData = *ppData + 1;
2384  036b 1e0c          	ldw	x,(OFST+5,sp)
2385  036d 9093          	ldw	y,x
2386  036f fe            	ldw	x,(x)
2387  0370 5c            	incw	x
2388  0371 90ff          	ldw	(y),x
2389                     ; 756         *pDataLeft = *pDataLeft - 1;
2391  0373 1e0e          	ldw	x,(OFST+7,sp)
2392  0375 9093          	ldw	y,x
2393  0377 fe            	ldw	x,(x)
2394  0378 5a            	decw	x
2395  0379 90ff          	ldw	(y),x
2396                     ; 760         memcpy(&temp, *ppData, 1);
2398  037b 96            	ldw	x,sp
2399  037c 1c0002        	addw	x,#OFST-5
2400  037f bf00          	ldw	c_x,x
2401  0381 160c          	ldw	y,(OFST+5,sp)
2402  0383 90fe          	ldw	y,(y)
2403  0385 90bf00        	ldw	c_y,y
2404  0388 ae0001        	ldw	x,#1
2405  038b               L06:
2406  038b 5a            	decw	x
2407  038c 92d600        	ld	a,([c_y.w],x)
2408  038f 92d700        	ld	([c_x.w],x),a
2409  0392 5d            	tnzw	x
2410  0393 26f6          	jrne	L06
2411                     ; 761 	nParsedNum = (uint8_t)(nParsedNum + temp - '0');
2413  0395 7b04          	ld	a,(OFST-3,sp)
2414  0397 1b02          	add	a,(OFST-5,sp)
2415  0399 a030          	sub	a,#48
2416  039b 6b04          	ld	(OFST-3,sp),a
2418                     ; 762         *ppData = *ppData + 1;
2420  039d 1e0c          	ldw	x,(OFST+5,sp)
2421  039f 9093          	ldw	y,x
2422  03a1 fe            	ldw	x,(x)
2423  03a2 5c            	incw	x
2424  03a3 90ff          	ldw	(y),x
2425                     ; 763         *pDataLeft = *pDataLeft - 1;
2427  03a5 1e0e          	ldw	x,(OFST+7,sp)
2428  03a7 9093          	ldw	y,x
2429  03a9 fe            	ldw	x,(x)
2430  03aa 5a            	decw	x
2431  03ab 90ff          	ldw	(y),x
2432                     ; 773         if (nParsedMode == 'i') {
2434  03ad 7b03          	ld	a,(OFST-4,sp)
2435  03af a169          	cp	a,#105
2436  03b1 2614          	jrne	L316
2437                     ; 775 	  *pBuffer = (uint8_t)(GpioGetPin(nParsedNum) + '0');
2439  03b3 7b04          	ld	a,(OFST-3,sp)
2440  03b5 cd129a        	call	_GpioGetPin
2442  03b8 1e08          	ldw	x,(OFST+1,sp)
2443  03ba ab30          	add	a,#48
2444  03bc f7            	ld	(x),a
2445                     ; 776           pBuffer++;
2447  03bd 5c            	incw	x
2448  03be 1f08          	ldw	(OFST+1,sp),x
2449                     ; 777           nBytes++;
2451  03c0 1e05          	ldw	x,(OFST-2,sp)
2452  03c2 5c            	incw	x
2453  03c3 1f05          	ldw	(OFST-2,sp),x
2456  03c5 204e          	jra	L516
2457  03c7               L316:
2458                     ; 780         else if (nParsedMode == 'o') {
2460  03c7 a16f          	cp	a,#111
2461  03c9 2624          	jrne	L716
2462                     ; 783           if((uint8_t)(GpioGetPin(nParsedNum) == 1)) { // Insert 'checked'
2464  03cb 7b04          	ld	a,(OFST-3,sp)
2465  03cd cd129a        	call	_GpioGetPin
2467  03d0 4a            	dec	a
2468  03d1 2642          	jrne	L516
2469                     ; 784             for(i=0; i<7; i++) {
2471  03d3 6b07          	ld	(OFST+0,sp),a
2473  03d5               L326:
2474                     ; 785               *pBuffer = checked[i];
2476  03d5 5f            	clrw	x
2477  03d6 97            	ld	xl,a
2478  03d7 d60000        	ld	a,(L31_checked,x)
2479  03da 1e08          	ldw	x,(OFST+1,sp)
2480  03dc f7            	ld	(x),a
2481                     ; 786               pBuffer++;
2483  03dd 5c            	incw	x
2484  03de 1f08          	ldw	(OFST+1,sp),x
2485                     ; 787               nBytes++;
2487  03e0 1e05          	ldw	x,(OFST-2,sp)
2488  03e2 5c            	incw	x
2489  03e3 1f05          	ldw	(OFST-2,sp),x
2491                     ; 784             for(i=0; i<7; i++) {
2493  03e5 0c07          	inc	(OFST+0,sp)
2497  03e7 7b07          	ld	a,(OFST+0,sp)
2498  03e9 a107          	cp	a,#7
2499  03eb 25e8          	jrult	L326
2501  03ed 2026          	jra	L516
2502  03ef               L716:
2503                     ; 794         else if (nParsedMode == 'p') {
2505  03ef a170          	cp	a,#112
2506  03f1 2622          	jrne	L516
2507                     ; 797           if((uint8_t)(GpioGetPin(nParsedNum) == 0)) { // Insert 'checked'
2509  03f3 7b04          	ld	a,(OFST-3,sp)
2510  03f5 cd129a        	call	_GpioGetPin
2512  03f8 4d            	tnz	a
2513  03f9 261a          	jrne	L516
2514                     ; 798             for(i=0; i<7; i++) {
2516  03fb 6b07          	ld	(OFST+0,sp),a
2518  03fd               L146:
2519                     ; 799               *pBuffer = checked[i];
2521  03fd 5f            	clrw	x
2522  03fe 97            	ld	xl,a
2523  03ff d60000        	ld	a,(L31_checked,x)
2524  0402 1e08          	ldw	x,(OFST+1,sp)
2525  0404 f7            	ld	(x),a
2526                     ; 800               pBuffer++;
2528  0405 5c            	incw	x
2529  0406 1f08          	ldw	(OFST+1,sp),x
2530                     ; 801               nBytes++;
2532  0408 1e05          	ldw	x,(OFST-2,sp)
2533  040a 5c            	incw	x
2534  040b 1f05          	ldw	(OFST-2,sp),x
2536                     ; 798             for(i=0; i<7; i++) {
2538  040d 0c07          	inc	(OFST+0,sp)
2542  040f 7b07          	ld	a,(OFST+0,sp)
2543  0411 a107          	cp	a,#7
2544  0413 25e8          	jrult	L146
2546  0415               L516:
2547                     ; 808         if (nParsedMode == 'a') {
2549  0415 7b03          	ld	a,(OFST-4,sp)
2550  0417 a161          	cp	a,#97
2551  0419 263b          	jrne	L156
2552                     ; 810 	  for(i=0; i<20; i++) {
2554  041b 4f            	clr	a
2555  041c 6b07          	ld	(OFST+0,sp),a
2557  041e               L356:
2558                     ; 811 	    if(ex_stored_devicename[i] != ' ') { // Don't write spaces out - confuses the
2560  041e 5f            	clrw	x
2561  041f 97            	ld	xl,a
2562  0420 d60000        	ld	a,(_ex_stored_devicename,x)
2563  0423 a120          	cp	a,#32
2564  0425 2712          	jreq	L166
2565                     ; 813               *pBuffer = (uint8_t)(ex_stored_devicename[i]);
2567  0427 7b07          	ld	a,(OFST+0,sp)
2568  0429 5f            	clrw	x
2569  042a 97            	ld	xl,a
2570  042b d60000        	ld	a,(_ex_stored_devicename,x)
2571  042e 1e08          	ldw	x,(OFST+1,sp)
2572  0430 f7            	ld	(x),a
2573                     ; 814               pBuffer++;
2575  0431 5c            	incw	x
2576  0432 1f08          	ldw	(OFST+1,sp),x
2577                     ; 815               nBytes++;
2579  0434 1e05          	ldw	x,(OFST-2,sp)
2580  0436 5c            	incw	x
2581  0437 1f05          	ldw	(OFST-2,sp),x
2583  0439               L166:
2584                     ; 810 	  for(i=0; i<20; i++) {
2586  0439 0c07          	inc	(OFST+0,sp)
2590  043b 7b07          	ld	a,(OFST+0,sp)
2591  043d a114          	cp	a,#20
2592  043f 25dd          	jrult	L356
2593                     ; 830           *ppData = *ppData + 20;
2595  0441 1e0c          	ldw	x,(OFST+5,sp)
2596  0443 9093          	ldw	y,x
2597  0445 fe            	ldw	x,(x)
2598  0446 1c0014        	addw	x,#20
2599  0449 90ff          	ldw	(y),x
2600                     ; 831           *pDataLeft = *pDataLeft - 20;
2602  044b 1e0e          	ldw	x,(OFST+7,sp)
2603  044d 9093          	ldw	y,x
2604  044f fe            	ldw	x,(x)
2605  0450 1d0014        	subw	x,#20
2607  0453 cc0832        	jp	LC007
2608  0456               L156:
2609                     ; 834         else if (nParsedMode == 'b') {
2611  0456 a162          	cp	a,#98
2612  0458 2703cc0556    	jrne	L566
2613                     ; 839 	  advanceptrs = 0;
2615                     ; 841           switch (nParsedNum)
2617  045d 7b04          	ld	a,(OFST-3,sp)
2619                     ; 856 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2620  045f a10c          	cp	a,#12
2621  0461 2503cc0518    	jruge	L154
2622  0466 5f            	clrw	x
2623  0467 97            	ld	xl,a
2624  0468 58            	sllw	x
2625  0469 de3d59        	ldw	x,(L421,x)
2626  046c fc            	jp	(x)
2627  046d               L124:
2628                     ; 844 	    case 0:  emb_itoa(ex_stored_hostaddr4, OctetArray, 10, 3); advanceptrs = 1; break;
2630  046d 4b03          	push	#3
2631  046f 4b0a          	push	#10
2632  0471 ae0000        	ldw	x,#_OctetArray
2633  0474 89            	pushw	x
2634  0475 c60000        	ld	a,_ex_stored_hostaddr4
2639  0478 cc0509        	jp	LC003
2640  047b               L324:
2641                     ; 845 	    case 1:  emb_itoa(ex_stored_hostaddr3, OctetArray, 10, 3); advanceptrs = 1; break;
2643  047b 4b03          	push	#3
2644  047d 4b0a          	push	#10
2645  047f ae0000        	ldw	x,#_OctetArray
2646  0482 89            	pushw	x
2647  0483 c60000        	ld	a,_ex_stored_hostaddr3
2652  0486 cc0509        	jp	LC003
2653  0489               L524:
2654                     ; 846 	    case 2:  emb_itoa(ex_stored_hostaddr2, OctetArray, 10, 3); advanceptrs = 1; break;
2656  0489 4b03          	push	#3
2657  048b 4b0a          	push	#10
2658  048d ae0000        	ldw	x,#_OctetArray
2659  0490 89            	pushw	x
2660  0491 c60000        	ld	a,_ex_stored_hostaddr2
2665  0494 2073          	jp	LC003
2666  0496               L724:
2667                     ; 847 	    case 3:  emb_itoa(ex_stored_hostaddr1, OctetArray, 10, 3); advanceptrs = 1; break;
2669  0496 4b03          	push	#3
2670  0498 4b0a          	push	#10
2671  049a ae0000        	ldw	x,#_OctetArray
2672  049d 89            	pushw	x
2673  049e c60000        	ld	a,_ex_stored_hostaddr1
2678  04a1 2066          	jp	LC003
2679  04a3               L134:
2680                     ; 848 	    case 4:  emb_itoa(ex_stored_draddr4,   OctetArray, 10, 3); advanceptrs = 1; break;
2682  04a3 4b03          	push	#3
2683  04a5 4b0a          	push	#10
2684  04a7 ae0000        	ldw	x,#_OctetArray
2685  04aa 89            	pushw	x
2686  04ab c60000        	ld	a,_ex_stored_draddr4
2691  04ae 2059          	jp	LC003
2692  04b0               L334:
2693                     ; 849 	    case 5:  emb_itoa(ex_stored_draddr3,   OctetArray, 10, 3); advanceptrs = 1; break;
2695  04b0 4b03          	push	#3
2696  04b2 4b0a          	push	#10
2697  04b4 ae0000        	ldw	x,#_OctetArray
2698  04b7 89            	pushw	x
2699  04b8 c60000        	ld	a,_ex_stored_draddr3
2704  04bb 204c          	jp	LC003
2705  04bd               L534:
2706                     ; 850 	    case 6:  emb_itoa(ex_stored_draddr2,   OctetArray, 10, 3); advanceptrs = 1; break;
2708  04bd 4b03          	push	#3
2709  04bf 4b0a          	push	#10
2710  04c1 ae0000        	ldw	x,#_OctetArray
2711  04c4 89            	pushw	x
2712  04c5 c60000        	ld	a,_ex_stored_draddr2
2717  04c8 203f          	jp	LC003
2718  04ca               L734:
2719                     ; 851 	    case 7:  emb_itoa(ex_stored_draddr1,   OctetArray, 10, 3); advanceptrs = 1; break;
2721  04ca 4b03          	push	#3
2722  04cc 4b0a          	push	#10
2723  04ce ae0000        	ldw	x,#_OctetArray
2724  04d1 89            	pushw	x
2725  04d2 c60000        	ld	a,_ex_stored_draddr1
2730  04d5 2032          	jp	LC003
2731  04d7               L144:
2732                     ; 852 	    case 8:  emb_itoa(ex_stored_netmask4,  OctetArray, 10, 3); advanceptrs = 1; break;
2734  04d7 4b03          	push	#3
2735  04d9 4b0a          	push	#10
2736  04db ae0000        	ldw	x,#_OctetArray
2737  04de 89            	pushw	x
2738  04df c60000        	ld	a,_ex_stored_netmask4
2743  04e2 2025          	jp	LC003
2744  04e4               L344:
2745                     ; 853 	    case 9:  emb_itoa(ex_stored_netmask3,  OctetArray, 10, 3); advanceptrs = 1; break;
2747  04e4 4b03          	push	#3
2748  04e6 4b0a          	push	#10
2749  04e8 ae0000        	ldw	x,#_OctetArray
2750  04eb 89            	pushw	x
2751  04ec c60000        	ld	a,_ex_stored_netmask3
2756  04ef 2018          	jp	LC003
2757  04f1               L544:
2758                     ; 854 	    case 10: emb_itoa(ex_stored_netmask2,  OctetArray, 10, 3); advanceptrs = 1; break;
2760  04f1 4b03          	push	#3
2761  04f3 4b0a          	push	#10
2762  04f5 ae0000        	ldw	x,#_OctetArray
2763  04f8 89            	pushw	x
2764  04f9 c60000        	ld	a,_ex_stored_netmask2
2769  04fc 200b          	jp	LC003
2770  04fe               L744:
2771                     ; 855 	    case 11: emb_itoa(ex_stored_netmask1,  OctetArray, 10, 3); advanceptrs = 1; break;
2773  04fe 4b03          	push	#3
2774  0500 4b0a          	push	#10
2775  0502 ae0000        	ldw	x,#_OctetArray
2776  0505 89            	pushw	x
2777  0506 c60000        	ld	a,_ex_stored_netmask1
2778  0509               LC003:
2779  0509 b703          	ld	c_lreg+3,a
2780  050b 3f02          	clr	c_lreg+2
2781  050d 3f01          	clr	c_lreg+1
2782  050f 3f00          	clr	c_lreg
2783  0511 be02          	ldw	x,c_lreg+2
2784  0513 89            	pushw	x
2785  0514 be00          	ldw	x,c_lreg
2790  0516 200a          	jra	L176
2791  0518               L154:
2792                     ; 856 	    default: emb_itoa(0,                   OctetArray, 10, 3); advanceptrs = 1; break;
2794  0518 4b03          	push	#3
2795  051a 4b0a          	push	#10
2796  051c ae0000        	ldw	x,#_OctetArray
2797  051f 89            	pushw	x
2798  0520 5f            	clrw	x
2799  0521 89            	pushw	x
2805  0522               L176:
2806  0522 89            	pushw	x
2807  0523 cd008c        	call	_emb_itoa
2808  0526 5b08          	addw	sp,#8
2821  0528 a601          	ld	a,#1
2822  052a 6b07          	ld	(OFST+0,sp),a
2824                     ; 859 	  if(advanceptrs == 1) { // Copy OctetArray and advance pointers if one of the above
2826  052c 4a            	dec	a
2827  052d 2703cc0a5d    	jrne	L306
2828                     ; 861             *pBuffer = (uint8_t)OctetArray[0];
2830  0532 1e08          	ldw	x,(OFST+1,sp)
2831  0534 c60000        	ld	a,_OctetArray
2832  0537 f7            	ld	(x),a
2833                     ; 862             pBuffer++;
2835  0538 5c            	incw	x
2836  0539 1f08          	ldw	(OFST+1,sp),x
2837                     ; 863             nBytes++;
2839  053b 1e05          	ldw	x,(OFST-2,sp)
2840  053d 5c            	incw	x
2841  053e 1f05          	ldw	(OFST-2,sp),x
2843                     ; 865             *pBuffer = (uint8_t)OctetArray[1];
2845  0540 1e08          	ldw	x,(OFST+1,sp)
2846  0542 c60001        	ld	a,_OctetArray+1
2847  0545 f7            	ld	(x),a
2848                     ; 866             pBuffer++;
2850  0546 5c            	incw	x
2851  0547 1f08          	ldw	(OFST+1,sp),x
2852                     ; 867             nBytes++;
2854  0549 1e05          	ldw	x,(OFST-2,sp)
2855  054b 5c            	incw	x
2856  054c 1f05          	ldw	(OFST-2,sp),x
2858                     ; 869             *pBuffer = (uint8_t)OctetArray[2];
2860  054e c60002        	ld	a,_OctetArray+2
2861  0551 1e08          	ldw	x,(OFST+1,sp)
2862                     ; 870             pBuffer++;
2863                     ; 871             nBytes++;
2864  0553 cc0622        	jp	LC006
2865  0556               L566:
2866                     ; 875         else if (nParsedMode == 'c') {
2868  0556 a163          	cp	a,#99
2869  0558 2637          	jrne	L776
2870                     ; 881           emb_itoa(ex_stored_port, OctetArray, 10, 5);
2872  055a 4b05          	push	#5
2873  055c 4b0a          	push	#10
2874  055e ae0000        	ldw	x,#_OctetArray
2875  0561 89            	pushw	x
2876  0562 ce0000        	ldw	x,_ex_stored_port
2877  0565 cd0000        	call	c_uitolx
2879  0568 be02          	ldw	x,c_lreg+2
2880  056a 89            	pushw	x
2881  056b be00          	ldw	x,c_lreg
2882  056d 89            	pushw	x
2883  056e cd008c        	call	_emb_itoa
2885  0571 5b08          	addw	sp,#8
2886                     ; 883 	  for(i=0; i<5; i++) {
2888  0573 4f            	clr	a
2889  0574 6b07          	ld	(OFST+0,sp),a
2891  0576               L107:
2892                     ; 884             *pBuffer = (uint8_t)OctetArray[i];
2894  0576 5f            	clrw	x
2895  0577 97            	ld	xl,a
2896  0578 d60000        	ld	a,(_OctetArray,x)
2897  057b 1e08          	ldw	x,(OFST+1,sp)
2898  057d f7            	ld	(x),a
2899                     ; 885             pBuffer++;
2901  057e 5c            	incw	x
2902  057f 1f08          	ldw	(OFST+1,sp),x
2903                     ; 886             nBytes++;
2905  0581 1e05          	ldw	x,(OFST-2,sp)
2906  0583 5c            	incw	x
2907  0584 1f05          	ldw	(OFST-2,sp),x
2909                     ; 883 	  for(i=0; i<5; i++) {
2911  0586 0c07          	inc	(OFST+0,sp)
2915  0588 7b07          	ld	a,(OFST+0,sp)
2916  058a a105          	cp	a,#5
2917  058c 25e8          	jrult	L107
2919  058e cc0a5d        	jra	L306
2920  0591               L776:
2921                     ; 890         else if (nParsedMode == 'd') {
2923  0591 a164          	cp	a,#100
2924  0593 2703cc0626    	jrne	L117
2925                     ; 895 	  if(nParsedNum == 0)      emb_itoa(uip_ethaddr1, OctetArray, 16, 2);
2927  0598 7b04          	ld	a,(OFST-3,sp)
2928  059a 260d          	jrne	L317
2931  059c 4b02          	push	#2
2932  059e 4b10          	push	#16
2933  05a0 ae0000        	ldw	x,#_OctetArray
2934  05a3 89            	pushw	x
2935  05a4 c60000        	ld	a,_uip_ethaddr1
2938  05a7 2053          	jp	LC004
2939  05a9               L317:
2940                     ; 896 	  else if(nParsedNum == 1) emb_itoa(uip_ethaddr2, OctetArray, 16, 2);
2942  05a9 a101          	cp	a,#1
2943  05ab 260d          	jrne	L717
2946  05ad 4b02          	push	#2
2947  05af 4b10          	push	#16
2948  05b1 ae0000        	ldw	x,#_OctetArray
2949  05b4 89            	pushw	x
2950  05b5 c60000        	ld	a,_uip_ethaddr2
2953  05b8 2042          	jp	LC004
2954  05ba               L717:
2955                     ; 897 	  else if(nParsedNum == 2) emb_itoa(uip_ethaddr3, OctetArray, 16, 2);
2957  05ba a102          	cp	a,#2
2958  05bc 260d          	jrne	L327
2961  05be 4b02          	push	#2
2962  05c0 4b10          	push	#16
2963  05c2 ae0000        	ldw	x,#_OctetArray
2964  05c5 89            	pushw	x
2965  05c6 c60000        	ld	a,_uip_ethaddr3
2968  05c9 2031          	jp	LC004
2969  05cb               L327:
2970                     ; 898 	  else if(nParsedNum == 3) emb_itoa(uip_ethaddr4, OctetArray, 16, 2);
2972  05cb a103          	cp	a,#3
2973  05cd 260d          	jrne	L727
2976  05cf 4b02          	push	#2
2977  05d1 4b10          	push	#16
2978  05d3 ae0000        	ldw	x,#_OctetArray
2979  05d6 89            	pushw	x
2980  05d7 c60000        	ld	a,_uip_ethaddr4
2983  05da 2020          	jp	LC004
2984  05dc               L727:
2985                     ; 899 	  else if(nParsedNum == 4) emb_itoa(uip_ethaddr5, OctetArray, 16, 2);
2987  05dc a104          	cp	a,#4
2988  05de 260d          	jrne	L337
2991  05e0 4b02          	push	#2
2992  05e2 4b10          	push	#16
2993  05e4 ae0000        	ldw	x,#_OctetArray
2994  05e7 89            	pushw	x
2995  05e8 c60000        	ld	a,_uip_ethaddr5
2998  05eb 200f          	jp	LC004
2999  05ed               L337:
3000                     ; 900 	  else if(nParsedNum == 5) emb_itoa(uip_ethaddr6, OctetArray, 16, 2);
3002  05ed a105          	cp	a,#5
3003  05ef 261e          	jrne	L517
3006  05f1 4b02          	push	#2
3007  05f3 4b10          	push	#16
3008  05f5 ae0000        	ldw	x,#_OctetArray
3009  05f8 89            	pushw	x
3010  05f9 c60000        	ld	a,_uip_ethaddr6
3012  05fc               LC004:
3013  05fc b703          	ld	c_lreg+3,a
3014  05fe 3f02          	clr	c_lreg+2
3015  0600 3f01          	clr	c_lreg+1
3016  0602 3f00          	clr	c_lreg
3017  0604 be02          	ldw	x,c_lreg+2
3018  0606 89            	pushw	x
3019  0607 be00          	ldw	x,c_lreg
3020  0609 89            	pushw	x
3021  060a cd008c        	call	_emb_itoa
3022  060d 5b08          	addw	sp,#8
3023  060f               L517:
3024                     ; 902           *pBuffer = OctetArray[0];
3026  060f 1e08          	ldw	x,(OFST+1,sp)
3027  0611 c60000        	ld	a,_OctetArray
3028  0614 f7            	ld	(x),a
3029                     ; 903           pBuffer++;
3031  0615 5c            	incw	x
3032  0616 1f08          	ldw	(OFST+1,sp),x
3033                     ; 904           nBytes++;
3035  0618 1e05          	ldw	x,(OFST-2,sp)
3036  061a 5c            	incw	x
3037  061b 1f05          	ldw	(OFST-2,sp),x
3039                     ; 906           *pBuffer = OctetArray[1];
3041  061d c60001        	ld	a,_OctetArray+1
3042  0620 1e08          	ldw	x,(OFST+1,sp)
3043  0622               LC006:
3044  0622 f7            	ld	(x),a
3045                     ; 907           pBuffer++;
3046                     ; 908           nBytes++;
3048  0623 cc0a55        	jp	LC005
3049  0626               L117:
3050                     ; 913         else if (nParsedMode == 'e') {
3052  0626 a165          	cp	a,#101
3053  0628 2703cc0801    	jrne	L347
3054                     ; 940           switch (nParsedNum)
3056  062d 7b04          	ld	a,(OFST-3,sp)
3058                     ; 965 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3059  062f a116          	cp	a,#22
3060  0631 2503cc07c2    	jruge	L725
3061  0636 5f            	clrw	x
3062  0637 97            	ld	xl,a
3063  0638 58            	sllw	x
3064  0639 de3d71        	ldw	x,(L422,x)
3065  063c fc            	jp	(x)
3066  063d               L354:
3067                     ; 943 	    case 0:  emb_itoa(uip_stat.ip.drop,      OctetArray, 10, 10); break;
3069  063d 4b0a          	push	#10
3070  063f 4b0a          	push	#10
3071  0641 ae0000        	ldw	x,#_OctetArray
3072  0644 89            	pushw	x
3073  0645 ce0002        	ldw	x,_uip_stat+2
3074  0648 89            	pushw	x
3075  0649 ce0000        	ldw	x,_uip_stat
3079  064c cc07cc        	jra	L747
3080  064f               L554:
3081                     ; 944 	    case 1:  emb_itoa(uip_stat.ip.recv,      OctetArray, 10, 10); break;
3083  064f 4b0a          	push	#10
3084  0651 4b0a          	push	#10
3085  0653 ae0000        	ldw	x,#_OctetArray
3086  0656 89            	pushw	x
3087  0657 ce0006        	ldw	x,_uip_stat+6
3088  065a 89            	pushw	x
3089  065b ce0004        	ldw	x,_uip_stat+4
3093  065e cc07cc        	jra	L747
3094  0661               L754:
3095                     ; 945 	    case 2:  emb_itoa(uip_stat.ip.sent,      OctetArray, 10, 10); break;
3097  0661 4b0a          	push	#10
3098  0663 4b0a          	push	#10
3099  0665 ae0000        	ldw	x,#_OctetArray
3100  0668 89            	pushw	x
3101  0669 ce000a        	ldw	x,_uip_stat+10
3102  066c 89            	pushw	x
3103  066d ce0008        	ldw	x,_uip_stat+8
3107  0670 cc07cc        	jra	L747
3108  0673               L164:
3109                     ; 946 	    case 3:  emb_itoa(uip_stat.ip.vhlerr,    OctetArray, 10, 10); break;
3111  0673 4b0a          	push	#10
3112  0675 4b0a          	push	#10
3113  0677 ae0000        	ldw	x,#_OctetArray
3114  067a 89            	pushw	x
3115  067b ce000e        	ldw	x,_uip_stat+14
3116  067e 89            	pushw	x
3117  067f ce000c        	ldw	x,_uip_stat+12
3121  0682 cc07cc        	jra	L747
3122  0685               L364:
3123                     ; 947 	    case 4:  emb_itoa(uip_stat.ip.hblenerr,  OctetArray, 10, 10); break;
3125  0685 4b0a          	push	#10
3126  0687 4b0a          	push	#10
3127  0689 ae0000        	ldw	x,#_OctetArray
3128  068c 89            	pushw	x
3129  068d ce0012        	ldw	x,_uip_stat+18
3130  0690 89            	pushw	x
3131  0691 ce0010        	ldw	x,_uip_stat+16
3135  0694 cc07cc        	jra	L747
3136  0697               L564:
3137                     ; 948 	    case 5:  emb_itoa(uip_stat.ip.lblenerr,  OctetArray, 10, 10); break;
3139  0697 4b0a          	push	#10
3140  0699 4b0a          	push	#10
3141  069b ae0000        	ldw	x,#_OctetArray
3142  069e 89            	pushw	x
3143  069f ce0016        	ldw	x,_uip_stat+22
3144  06a2 89            	pushw	x
3145  06a3 ce0014        	ldw	x,_uip_stat+20
3149  06a6 cc07cc        	jra	L747
3150  06a9               L764:
3151                     ; 949 	    case 6:  emb_itoa(uip_stat.ip.fragerr,   OctetArray, 10, 10); break;
3153  06a9 4b0a          	push	#10
3154  06ab 4b0a          	push	#10
3155  06ad ae0000        	ldw	x,#_OctetArray
3156  06b0 89            	pushw	x
3157  06b1 ce001a        	ldw	x,_uip_stat+26
3158  06b4 89            	pushw	x
3159  06b5 ce0018        	ldw	x,_uip_stat+24
3163  06b8 cc07cc        	jra	L747
3164  06bb               L174:
3165                     ; 950 	    case 7:  emb_itoa(uip_stat.ip.chkerr,    OctetArray, 10, 10); break;
3167  06bb 4b0a          	push	#10
3168  06bd 4b0a          	push	#10
3169  06bf ae0000        	ldw	x,#_OctetArray
3170  06c2 89            	pushw	x
3171  06c3 ce001e        	ldw	x,_uip_stat+30
3172  06c6 89            	pushw	x
3173  06c7 ce001c        	ldw	x,_uip_stat+28
3177  06ca cc07cc        	jra	L747
3178  06cd               L374:
3179                     ; 951 	    case 8:  emb_itoa(uip_stat.ip.protoerr,  OctetArray, 10, 10); break;
3181  06cd 4b0a          	push	#10
3182  06cf 4b0a          	push	#10
3183  06d1 ae0000        	ldw	x,#_OctetArray
3184  06d4 89            	pushw	x
3185  06d5 ce0022        	ldw	x,_uip_stat+34
3186  06d8 89            	pushw	x
3187  06d9 ce0020        	ldw	x,_uip_stat+32
3191  06dc cc07cc        	jra	L747
3192  06df               L574:
3193                     ; 952 	    case 9:  emb_itoa(uip_stat.icmp.drop,    OctetArray, 10, 10); break;
3195  06df 4b0a          	push	#10
3196  06e1 4b0a          	push	#10
3197  06e3 ae0000        	ldw	x,#_OctetArray
3198  06e6 89            	pushw	x
3199  06e7 ce0026        	ldw	x,_uip_stat+38
3200  06ea 89            	pushw	x
3201  06eb ce0024        	ldw	x,_uip_stat+36
3205  06ee cc07cc        	jra	L747
3206  06f1               L774:
3207                     ; 953 	    case 10: emb_itoa(uip_stat.icmp.recv,    OctetArray, 10, 10); break;
3209  06f1 4b0a          	push	#10
3210  06f3 4b0a          	push	#10
3211  06f5 ae0000        	ldw	x,#_OctetArray
3212  06f8 89            	pushw	x
3213  06f9 ce002a        	ldw	x,_uip_stat+42
3214  06fc 89            	pushw	x
3215  06fd ce0028        	ldw	x,_uip_stat+40
3219  0700 cc07cc        	jra	L747
3220  0703               L105:
3221                     ; 954 	    case 11: emb_itoa(uip_stat.icmp.sent,    OctetArray, 10, 10); break;
3223  0703 4b0a          	push	#10
3224  0705 4b0a          	push	#10
3225  0707 ae0000        	ldw	x,#_OctetArray
3226  070a 89            	pushw	x
3227  070b ce002e        	ldw	x,_uip_stat+46
3228  070e 89            	pushw	x
3229  070f ce002c        	ldw	x,_uip_stat+44
3233  0712 cc07cc        	jra	L747
3234  0715               L305:
3235                     ; 955 	    case 12: emb_itoa(uip_stat.icmp.typeerr, OctetArray, 10, 10); break;
3237  0715 4b0a          	push	#10
3238  0717 4b0a          	push	#10
3239  0719 ae0000        	ldw	x,#_OctetArray
3240  071c 89            	pushw	x
3241  071d ce0032        	ldw	x,_uip_stat+50
3242  0720 89            	pushw	x
3243  0721 ce0030        	ldw	x,_uip_stat+48
3247  0724 cc07cc        	jra	L747
3248  0727               L505:
3249                     ; 956 	    case 13: emb_itoa(uip_stat.tcp.drop,     OctetArray, 10, 10); break;
3251  0727 4b0a          	push	#10
3252  0729 4b0a          	push	#10
3253  072b ae0000        	ldw	x,#_OctetArray
3254  072e 89            	pushw	x
3255  072f ce0036        	ldw	x,_uip_stat+54
3256  0732 89            	pushw	x
3257  0733 ce0034        	ldw	x,_uip_stat+52
3261  0736 cc07cc        	jra	L747
3262  0739               L705:
3263                     ; 957 	    case 14: emb_itoa(uip_stat.tcp.recv,     OctetArray, 10, 10); break;
3265  0739 4b0a          	push	#10
3266  073b 4b0a          	push	#10
3267  073d ae0000        	ldw	x,#_OctetArray
3268  0740 89            	pushw	x
3269  0741 ce003a        	ldw	x,_uip_stat+58
3270  0744 89            	pushw	x
3271  0745 ce0038        	ldw	x,_uip_stat+56
3275  0748 cc07cc        	jra	L747
3276  074b               L115:
3277                     ; 958 	    case 15: emb_itoa(uip_stat.tcp.sent,     OctetArray, 10, 10); break;
3279  074b 4b0a          	push	#10
3280  074d 4b0a          	push	#10
3281  074f ae0000        	ldw	x,#_OctetArray
3282  0752 89            	pushw	x
3283  0753 ce003e        	ldw	x,_uip_stat+62
3284  0756 89            	pushw	x
3285  0757 ce003c        	ldw	x,_uip_stat+60
3289  075a 2070          	jra	L747
3290  075c               L315:
3291                     ; 959 	    case 16: emb_itoa(uip_stat.tcp.chkerr,   OctetArray, 10, 10); break;
3293  075c 4b0a          	push	#10
3294  075e 4b0a          	push	#10
3295  0760 ae0000        	ldw	x,#_OctetArray
3296  0763 89            	pushw	x
3297  0764 ce0042        	ldw	x,_uip_stat+66
3298  0767 89            	pushw	x
3299  0768 ce0040        	ldw	x,_uip_stat+64
3303  076b 205f          	jra	L747
3304  076d               L515:
3305                     ; 960 	    case 17: emb_itoa(uip_stat.tcp.ackerr,   OctetArray, 10, 10); break;
3307  076d 4b0a          	push	#10
3308  076f 4b0a          	push	#10
3309  0771 ae0000        	ldw	x,#_OctetArray
3310  0774 89            	pushw	x
3311  0775 ce0046        	ldw	x,_uip_stat+70
3312  0778 89            	pushw	x
3313  0779 ce0044        	ldw	x,_uip_stat+68
3317  077c 204e          	jra	L747
3318  077e               L715:
3319                     ; 961 	    case 18: emb_itoa(uip_stat.tcp.rst,      OctetArray, 10, 10); break;
3321  077e 4b0a          	push	#10
3322  0780 4b0a          	push	#10
3323  0782 ae0000        	ldw	x,#_OctetArray
3324  0785 89            	pushw	x
3325  0786 ce004a        	ldw	x,_uip_stat+74
3326  0789 89            	pushw	x
3327  078a ce0048        	ldw	x,_uip_stat+72
3331  078d 203d          	jra	L747
3332  078f               L125:
3333                     ; 962 	    case 19: emb_itoa(uip_stat.tcp.rexmit,   OctetArray, 10, 10); break;
3335  078f 4b0a          	push	#10
3336  0791 4b0a          	push	#10
3337  0793 ae0000        	ldw	x,#_OctetArray
3338  0796 89            	pushw	x
3339  0797 ce004e        	ldw	x,_uip_stat+78
3340  079a 89            	pushw	x
3341  079b ce004c        	ldw	x,_uip_stat+76
3345  079e 202c          	jra	L747
3346  07a0               L325:
3347                     ; 963 	    case 20: emb_itoa(uip_stat.tcp.syndrop,  OctetArray, 10, 10); break;
3349  07a0 4b0a          	push	#10
3350  07a2 4b0a          	push	#10
3351  07a4 ae0000        	ldw	x,#_OctetArray
3352  07a7 89            	pushw	x
3353  07a8 ce0052        	ldw	x,_uip_stat+82
3354  07ab 89            	pushw	x
3355  07ac ce0050        	ldw	x,_uip_stat+80
3359  07af 201b          	jra	L747
3360  07b1               L525:
3361                     ; 964 	    case 21: emb_itoa(uip_stat.tcp.synrst,   OctetArray, 10, 10); break;
3363  07b1 4b0a          	push	#10
3364  07b3 4b0a          	push	#10
3365  07b5 ae0000        	ldw	x,#_OctetArray
3366  07b8 89            	pushw	x
3367  07b9 ce0056        	ldw	x,_uip_stat+86
3368  07bc 89            	pushw	x
3369  07bd ce0054        	ldw	x,_uip_stat+84
3373  07c0 200a          	jra	L747
3374  07c2               L725:
3375                     ; 965 	    default: emb_itoa(0,                     OctetArray, 10, 10); break;
3377  07c2 4b0a          	push	#10
3378  07c4 4b0a          	push	#10
3379  07c6 ae0000        	ldw	x,#_OctetArray
3380  07c9 89            	pushw	x
3381  07ca 5f            	clrw	x
3382  07cb 89            	pushw	x
3386  07cc               L747:
3387  07cc 89            	pushw	x
3388  07cd cd008c        	call	_emb_itoa
3389  07d0 5b08          	addw	sp,#8
3390                     ; 968 	  for (i=0; i<10; i++) {
3392  07d2 4f            	clr	a
3393  07d3 6b07          	ld	(OFST+0,sp),a
3395  07d5               L157:
3396                     ; 969             *pBuffer = OctetArray[i];
3398  07d5 5f            	clrw	x
3399  07d6 97            	ld	xl,a
3400  07d7 d60000        	ld	a,(_OctetArray,x)
3401  07da 1e08          	ldw	x,(OFST+1,sp)
3402  07dc f7            	ld	(x),a
3403                     ; 970             pBuffer++;
3405  07dd 5c            	incw	x
3406  07de 1f08          	ldw	(OFST+1,sp),x
3407                     ; 971             nBytes++;
3409  07e0 1e05          	ldw	x,(OFST-2,sp)
3410  07e2 5c            	incw	x
3411  07e3 1f05          	ldw	(OFST-2,sp),x
3413                     ; 968 	  for (i=0; i<10; i++) {
3415  07e5 0c07          	inc	(OFST+0,sp)
3419  07e7 7b07          	ld	a,(OFST+0,sp)
3420  07e9 a10a          	cp	a,#10
3421  07eb 25e8          	jrult	L157
3422                     ; 976           *ppData = *ppData + 10;
3424  07ed 1e0c          	ldw	x,(OFST+5,sp)
3425  07ef 9093          	ldw	y,x
3426  07f1 fe            	ldw	x,(x)
3427  07f2 1c000a        	addw	x,#10
3428  07f5 90ff          	ldw	(y),x
3429                     ; 977           *pDataLeft = *pDataLeft - 10;
3431  07f7 1e0e          	ldw	x,(OFST+7,sp)
3432  07f9 9093          	ldw	y,x
3433  07fb fe            	ldw	x,(x)
3434  07fc 1d000a        	subw	x,#10
3436  07ff 2031          	jp	LC007
3437  0801               L347:
3438                     ; 982         else if (nParsedMode == 'f') {
3440  0801 a166          	cp	a,#102
3441  0803 2632          	jrne	L167
3442                     ; 985 	  for(i=0; i<16; i++) {
3444  0805 4f            	clr	a
3445  0806 6b07          	ld	(OFST+0,sp),a
3447  0808               L367:
3448                     ; 986 	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
3450  0808 cd129a        	call	_GpioGetPin
3452  080b 1e08          	ldw	x,(OFST+1,sp)
3453  080d ab30          	add	a,#48
3454  080f f7            	ld	(x),a
3455                     ; 987             pBuffer++;
3457  0810 5c            	incw	x
3458  0811 1f08          	ldw	(OFST+1,sp),x
3459                     ; 988             nBytes++;
3461  0813 1e05          	ldw	x,(OFST-2,sp)
3462  0815 5c            	incw	x
3463  0816 1f05          	ldw	(OFST-2,sp),x
3465                     ; 985 	  for(i=0; i<16; i++) {
3467  0818 0c07          	inc	(OFST+0,sp)
3471  081a 7b07          	ld	a,(OFST+0,sp)
3472  081c a110          	cp	a,#16
3473  081e 25e8          	jrult	L367
3474                     ; 992           *ppData = *ppData + 16;
3476  0820 1e0c          	ldw	x,(OFST+5,sp)
3477  0822 9093          	ldw	y,x
3478  0824 fe            	ldw	x,(x)
3479  0825 1c0010        	addw	x,#16
3480  0828 90ff          	ldw	(y),x
3481                     ; 993           *pDataLeft = *pDataLeft - 16;
3483  082a 1e0e          	ldw	x,(OFST+7,sp)
3484  082c 9093          	ldw	y,x
3485  082e fe            	ldw	x,(x)
3486  082f 1d0010        	subw	x,#16
3487  0832               LC007:
3488  0832 90ff          	ldw	(y),x
3490  0834 cc0a5d        	jra	L306
3491  0837               L167:
3492                     ; 996         else if (nParsedMode == 'g') {
3494  0837 a167          	cp	a,#103
3495  0839 2623          	jrne	L377
3496                     ; 1000 	  if (invert_output == 1) {  // Insert 'checked'
3498  083b c60000        	ld	a,_invert_output
3499  083e 4a            	dec	a
3500  083f 26f3          	jrne	L306
3501                     ; 1001             for(i=0; i<7; i++) {
3503  0841 6b07          	ld	(OFST+0,sp),a
3505  0843               L777:
3506                     ; 1002               *pBuffer = checked[i];
3508  0843 5f            	clrw	x
3509  0844 97            	ld	xl,a
3510  0845 d60000        	ld	a,(L31_checked,x)
3511  0848 1e08          	ldw	x,(OFST+1,sp)
3512  084a f7            	ld	(x),a
3513                     ; 1003               pBuffer++;
3515  084b 5c            	incw	x
3516  084c 1f08          	ldw	(OFST+1,sp),x
3517                     ; 1004               nBytes++;
3519  084e 1e05          	ldw	x,(OFST-2,sp)
3520  0850 5c            	incw	x
3521  0851 1f05          	ldw	(OFST-2,sp),x
3523                     ; 1001             for(i=0; i<7; i++) {
3525  0853 0c07          	inc	(OFST+0,sp)
3529  0855 7b07          	ld	a,(OFST+0,sp)
3530  0857 a107          	cp	a,#7
3531  0859 25e8          	jrult	L777
3532  085b cc0a5d        	jra	L306
3533  085e               L377:
3534                     ; 1009         else if (nParsedMode == 'h') {
3536  085e a168          	cp	a,#104
3537  0860 2622          	jrne	L7001
3538                     ; 1014 	  if (invert_output == 0) {  // Insert 'checked'
3540  0862 c60000        	ld	a,_invert_output
3541  0865 26f4          	jrne	L306
3542                     ; 1015             for(i=0; i<7; i++) {
3544  0867 6b07          	ld	(OFST+0,sp),a
3546  0869               L3101:
3547                     ; 1016               *pBuffer = checked[i];
3549  0869 5f            	clrw	x
3550  086a 97            	ld	xl,a
3551  086b d60000        	ld	a,(L31_checked,x)
3552  086e 1e08          	ldw	x,(OFST+1,sp)
3553  0870 f7            	ld	(x),a
3554                     ; 1017               pBuffer++;
3556  0871 5c            	incw	x
3557  0872 1f08          	ldw	(OFST+1,sp),x
3558                     ; 1018               nBytes++;
3560  0874 1e05          	ldw	x,(OFST-2,sp)
3561  0876 5c            	incw	x
3562  0877 1f05          	ldw	(OFST-2,sp),x
3564                     ; 1015             for(i=0; i<7; i++) {
3566  0879 0c07          	inc	(OFST+0,sp)
3570  087b 7b07          	ld	a,(OFST+0,sp)
3571  087d a107          	cp	a,#7
3572  087f 25e8          	jrult	L3101
3573  0881 cc0a5d        	jra	L306
3574  0884               L7001:
3575                     ; 1023         else if (nParsedMode == 'x') {
3577  0884 a178          	cp	a,#120
3578  0886 26f9          	jrne	L306
3579                     ; 1033           *pBuffer = 'h'; pBuffer++; nBytes++;
3581  0888 1e08          	ldw	x,(OFST+1,sp)
3582  088a a668          	ld	a,#104
3583  088c f7            	ld	(x),a
3586  088d 5c            	incw	x
3587  088e 1f08          	ldw	(OFST+1,sp),x
3590  0890 1e05          	ldw	x,(OFST-2,sp)
3591  0892 5c            	incw	x
3592  0893 1f05          	ldw	(OFST-2,sp),x
3594                     ; 1034           *pBuffer = 't'; pBuffer++; nBytes++;
3596  0895 1e08          	ldw	x,(OFST+1,sp)
3597  0897 a674          	ld	a,#116
3598  0899 f7            	ld	(x),a
3601  089a 5c            	incw	x
3602  089b 1f08          	ldw	(OFST+1,sp),x
3605  089d 1e05          	ldw	x,(OFST-2,sp)
3606  089f 5c            	incw	x
3607  08a0 1f05          	ldw	(OFST-2,sp),x
3609                     ; 1035           *pBuffer = 't'; pBuffer++; nBytes++;
3611  08a2 1e08          	ldw	x,(OFST+1,sp)
3612  08a4 f7            	ld	(x),a
3615  08a5 5c            	incw	x
3616  08a6 1f08          	ldw	(OFST+1,sp),x
3619  08a8 1e05          	ldw	x,(OFST-2,sp)
3620  08aa 5c            	incw	x
3621  08ab 1f05          	ldw	(OFST-2,sp),x
3623                     ; 1036           *pBuffer = 'p'; pBuffer++; nBytes++;
3625  08ad 1e08          	ldw	x,(OFST+1,sp)
3626  08af a670          	ld	a,#112
3627  08b1 f7            	ld	(x),a
3630  08b2 5c            	incw	x
3631  08b3 1f08          	ldw	(OFST+1,sp),x
3634  08b5 1e05          	ldw	x,(OFST-2,sp)
3635  08b7 5c            	incw	x
3636  08b8 1f05          	ldw	(OFST-2,sp),x
3638                     ; 1037           *pBuffer = ':'; pBuffer++; nBytes++;
3640  08ba 1e08          	ldw	x,(OFST+1,sp)
3641  08bc a63a          	ld	a,#58
3642  08be f7            	ld	(x),a
3645  08bf 5c            	incw	x
3646  08c0 1f08          	ldw	(OFST+1,sp),x
3649  08c2 1e05          	ldw	x,(OFST-2,sp)
3650  08c4 5c            	incw	x
3651  08c5 1f05          	ldw	(OFST-2,sp),x
3653                     ; 1038           *pBuffer = '/'; pBuffer++; nBytes++;
3655  08c7 1e08          	ldw	x,(OFST+1,sp)
3656  08c9 a62f          	ld	a,#47
3657  08cb f7            	ld	(x),a
3660  08cc 5c            	incw	x
3661  08cd 1f08          	ldw	(OFST+1,sp),x
3664  08cf 1e05          	ldw	x,(OFST-2,sp)
3665  08d1 5c            	incw	x
3666  08d2 1f05          	ldw	(OFST-2,sp),x
3668                     ; 1039           *pBuffer = '/'; pBuffer++; nBytes++;
3670  08d4 1e08          	ldw	x,(OFST+1,sp)
3671  08d6 f7            	ld	(x),a
3674  08d7 5c            	incw	x
3675  08d8 1f08          	ldw	(OFST+1,sp),x
3678  08da 1e05          	ldw	x,(OFST-2,sp)
3679  08dc 5c            	incw	x
3680  08dd 1f05          	ldw	(OFST-2,sp),x
3682                     ; 1042 	  emb_itoa(ex_stored_hostaddr4,  OctetArray, 10, 3); // First IP Address Octet
3684  08df 4b03          	push	#3
3685  08e1 4b0a          	push	#10
3686  08e3 ae0000        	ldw	x,#_OctetArray
3687  08e6 89            	pushw	x
3688  08e7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr4
3689  08ec 3f02          	clr	c_lreg+2
3690  08ee 3f01          	clr	c_lreg+1
3691  08f0 3f00          	clr	c_lreg
3692  08f2 be02          	ldw	x,c_lreg+2
3693  08f4 89            	pushw	x
3694  08f5 be00          	ldw	x,c_lreg
3695  08f7 89            	pushw	x
3696  08f8 cd008c        	call	_emb_itoa
3698  08fb 5b08          	addw	sp,#8
3699                     ; 1043 	  for(i=0; i<3; i++) { *pBuffer = OctetArray[i]; pBuffer++; nBytes++; }
3701  08fd 4f            	clr	a
3702  08fe 6b07          	ld	(OFST+0,sp),a
3704  0900               L5201:
3707  0900 5f            	clrw	x
3708  0901 97            	ld	xl,a
3709  0902 d60000        	ld	a,(_OctetArray,x)
3710  0905 1e08          	ldw	x,(OFST+1,sp)
3711  0907 f7            	ld	(x),a
3714  0908 5c            	incw	x
3715  0909 1f08          	ldw	(OFST+1,sp),x
3718  090b 1e05          	ldw	x,(OFST-2,sp)
3719  090d 5c            	incw	x
3720  090e 1f05          	ldw	(OFST-2,sp),x
3724  0910 0c07          	inc	(OFST+0,sp)
3728  0912 7b07          	ld	a,(OFST+0,sp)
3729  0914 a103          	cp	a,#3
3730  0916 25e8          	jrult	L5201
3731                     ; 1044           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3733  0918 1e08          	ldw	x,(OFST+1,sp)
3734  091a a62e          	ld	a,#46
3735  091c f7            	ld	(x),a
3738  091d 5c            	incw	x
3739  091e 1f08          	ldw	(OFST+1,sp),x
3742  0920 1e05          	ldw	x,(OFST-2,sp)
3743  0922 5c            	incw	x
3744  0923 1f05          	ldw	(OFST-2,sp),x
3746                     ; 1046 	  emb_itoa(ex_stored_hostaddr3,  OctetArray, 10, 3); // Second IP Address Octet
3748  0925 4b03          	push	#3
3749  0927 4b0a          	push	#10
3750  0929 ae0000        	ldw	x,#_OctetArray
3751  092c 89            	pushw	x
3752  092d 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr3
3753  0932 3f02          	clr	c_lreg+2
3754  0934 3f01          	clr	c_lreg+1
3755  0936 3f00          	clr	c_lreg
3756  0938 be02          	ldw	x,c_lreg+2
3757  093a 89            	pushw	x
3758  093b be00          	ldw	x,c_lreg
3759  093d 89            	pushw	x
3760  093e cd008c        	call	_emb_itoa
3762  0941 5b08          	addw	sp,#8
3763                     ; 1047 	  for(i=0; i<3; i++) { *pBuffer = OctetArray[i]; pBuffer++; nBytes++; }
3765  0943 4f            	clr	a
3766  0944 6b07          	ld	(OFST+0,sp),a
3768  0946               L3301:
3771  0946 5f            	clrw	x
3772  0947 97            	ld	xl,a
3773  0948 d60000        	ld	a,(_OctetArray,x)
3774  094b 1e08          	ldw	x,(OFST+1,sp)
3775  094d f7            	ld	(x),a
3778  094e 5c            	incw	x
3779  094f 1f08          	ldw	(OFST+1,sp),x
3782  0951 1e05          	ldw	x,(OFST-2,sp)
3783  0953 5c            	incw	x
3784  0954 1f05          	ldw	(OFST-2,sp),x
3788  0956 0c07          	inc	(OFST+0,sp)
3792  0958 7b07          	ld	a,(OFST+0,sp)
3793  095a a103          	cp	a,#3
3794  095c 25e8          	jrult	L3301
3795                     ; 1048           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3797  095e 1e08          	ldw	x,(OFST+1,sp)
3798  0960 a62e          	ld	a,#46
3799  0962 f7            	ld	(x),a
3802  0963 5c            	incw	x
3803  0964 1f08          	ldw	(OFST+1,sp),x
3806  0966 1e05          	ldw	x,(OFST-2,sp)
3807  0968 5c            	incw	x
3808  0969 1f05          	ldw	(OFST-2,sp),x
3810                     ; 1050 	  emb_itoa(ex_stored_hostaddr2,  OctetArray, 10, 3); // Third IP Address Octet
3812  096b 4b03          	push	#3
3813  096d 4b0a          	push	#10
3814  096f ae0000        	ldw	x,#_OctetArray
3815  0972 89            	pushw	x
3816  0973 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr2
3817  0978 3f02          	clr	c_lreg+2
3818  097a 3f01          	clr	c_lreg+1
3819  097c 3f00          	clr	c_lreg
3820  097e be02          	ldw	x,c_lreg+2
3821  0980 89            	pushw	x
3822  0981 be00          	ldw	x,c_lreg
3823  0983 89            	pushw	x
3824  0984 cd008c        	call	_emb_itoa
3826  0987 5b08          	addw	sp,#8
3827                     ; 1051 	  for(i=0; i<3; i++) { *pBuffer = OctetArray[i]; pBuffer++; nBytes++; }
3829  0989 4f            	clr	a
3830  098a 6b07          	ld	(OFST+0,sp),a
3832  098c               L1401:
3835  098c 5f            	clrw	x
3836  098d 97            	ld	xl,a
3837  098e d60000        	ld	a,(_OctetArray,x)
3838  0991 1e08          	ldw	x,(OFST+1,sp)
3839  0993 f7            	ld	(x),a
3842  0994 5c            	incw	x
3843  0995 1f08          	ldw	(OFST+1,sp),x
3846  0997 1e05          	ldw	x,(OFST-2,sp)
3847  0999 5c            	incw	x
3848  099a 1f05          	ldw	(OFST-2,sp),x
3852  099c 0c07          	inc	(OFST+0,sp)
3856  099e 7b07          	ld	a,(OFST+0,sp)
3857  09a0 a103          	cp	a,#3
3858  09a2 25e8          	jrult	L1401
3859                     ; 1052           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3861  09a4 1e08          	ldw	x,(OFST+1,sp)
3862  09a6 a62e          	ld	a,#46
3863  09a8 f7            	ld	(x),a
3866  09a9 5c            	incw	x
3867  09aa 1f08          	ldw	(OFST+1,sp),x
3870  09ac 1e05          	ldw	x,(OFST-2,sp)
3871  09ae 5c            	incw	x
3872  09af 1f05          	ldw	(OFST-2,sp),x
3874                     ; 1054 	  emb_itoa(ex_stored_hostaddr1,  OctetArray, 10, 3); // Fourth IP Address Octet
3876  09b1 4b03          	push	#3
3877  09b3 4b0a          	push	#10
3878  09b5 ae0000        	ldw	x,#_OctetArray
3879  09b8 89            	pushw	x
3880  09b9 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr1
3881  09be 3f02          	clr	c_lreg+2
3882  09c0 3f01          	clr	c_lreg+1
3883  09c2 3f00          	clr	c_lreg
3884  09c4 be02          	ldw	x,c_lreg+2
3885  09c6 89            	pushw	x
3886  09c7 be00          	ldw	x,c_lreg
3887  09c9 89            	pushw	x
3888  09ca cd008c        	call	_emb_itoa
3890  09cd 5b08          	addw	sp,#8
3891                     ; 1055 	  for(i=0; i<3; i++) { *pBuffer = OctetArray[i]; pBuffer++; nBytes++; }
3893  09cf 4f            	clr	a
3894  09d0 6b07          	ld	(OFST+0,sp),a
3896  09d2               L7401:
3899  09d2 5f            	clrw	x
3900  09d3 97            	ld	xl,a
3901  09d4 d60000        	ld	a,(_OctetArray,x)
3902  09d7 1e08          	ldw	x,(OFST+1,sp)
3903  09d9 f7            	ld	(x),a
3906  09da 5c            	incw	x
3907  09db 1f08          	ldw	(OFST+1,sp),x
3910  09dd 1e05          	ldw	x,(OFST-2,sp)
3911  09df 5c            	incw	x
3912  09e0 1f05          	ldw	(OFST-2,sp),x
3916  09e2 0c07          	inc	(OFST+0,sp)
3920  09e4 7b07          	ld	a,(OFST+0,sp)
3921  09e6 a103          	cp	a,#3
3922  09e8 25e8          	jrult	L7401
3923                     ; 1056           *pBuffer = ':'; pBuffer++; nBytes++; // Output ':'
3925  09ea 1e08          	ldw	x,(OFST+1,sp)
3926  09ec a63a          	ld	a,#58
3927  09ee f7            	ld	(x),a
3930  09ef 5c            	incw	x
3931  09f0 1f08          	ldw	(OFST+1,sp),x
3934  09f2 1e05          	ldw	x,(OFST-2,sp)
3935  09f4 5c            	incw	x
3936  09f5 1f05          	ldw	(OFST-2,sp),x
3938                     ; 1058 	  emb_itoa(ex_stored_port, OctetArray, 10, 5); // Now output the Port number
3940  09f7 4b05          	push	#5
3941  09f9 4b0a          	push	#10
3942  09fb ae0000        	ldw	x,#_OctetArray
3943  09fe 89            	pushw	x
3944  09ff ce0000        	ldw	x,_ex_stored_port
3945  0a02 cd0000        	call	c_uitolx
3947  0a05 be02          	ldw	x,c_lreg+2
3948  0a07 89            	pushw	x
3949  0a08 be00          	ldw	x,c_lreg
3950  0a0a 89            	pushw	x
3951  0a0b cd008c        	call	_emb_itoa
3953  0a0e 5b08          	addw	sp,#8
3954                     ; 1059 	  for(i=0; i<5; i++) { *pBuffer = OctetArray[i]; pBuffer++; nBytes++; }
3956  0a10 4f            	clr	a
3957  0a11 6b07          	ld	(OFST+0,sp),a
3959  0a13               L5501:
3962  0a13 5f            	clrw	x
3963  0a14 97            	ld	xl,a
3964  0a15 d60000        	ld	a,(_OctetArray,x)
3965  0a18 1e08          	ldw	x,(OFST+1,sp)
3966  0a1a f7            	ld	(x),a
3969  0a1b 5c            	incw	x
3970  0a1c 1f08          	ldw	(OFST+1,sp),x
3973  0a1e 1e05          	ldw	x,(OFST-2,sp)
3974  0a20 5c            	incw	x
3975  0a21 1f05          	ldw	(OFST-2,sp),x
3979  0a23 0c07          	inc	(OFST+0,sp)
3983  0a25 7b07          	ld	a,(OFST+0,sp)
3984  0a27 a105          	cp	a,#5
3985  0a29 25e8          	jrult	L5501
3986                     ; 1063           *ppData = *ppData + 28;
3988  0a2b 1e0c          	ldw	x,(OFST+5,sp)
3989  0a2d 9093          	ldw	y,x
3990  0a2f fe            	ldw	x,(x)
3991  0a30 1c001c        	addw	x,#28
3992  0a33 90ff          	ldw	(y),x
3993                     ; 1064           *pDataLeft = *pDataLeft - 28;
3995  0a35 1e0e          	ldw	x,(OFST+7,sp)
3996  0a37 9093          	ldw	y,x
3997  0a39 fe            	ldw	x,(x)
3998  0a3a 1d001c        	subw	x,#28
3999  0a3d cc0832        	jp	LC007
4000  0a40               L116:
4001                     ; 1068         *pBuffer = nByte;
4003  0a40 1e08          	ldw	x,(OFST+1,sp)
4004  0a42 f7            	ld	(x),a
4005                     ; 1069         *ppData = *ppData + 1;
4007  0a43 1e0c          	ldw	x,(OFST+5,sp)
4008  0a45 9093          	ldw	y,x
4009  0a47 fe            	ldw	x,(x)
4010  0a48 5c            	incw	x
4011  0a49 90ff          	ldw	(y),x
4012                     ; 1070         *pDataLeft = *pDataLeft - 1;
4014  0a4b 1e0e          	ldw	x,(OFST+7,sp)
4015  0a4d 9093          	ldw	y,x
4016  0a4f fe            	ldw	x,(x)
4017  0a50 5a            	decw	x
4018  0a51 90ff          	ldw	(y),x
4019                     ; 1071         pBuffer++;
4021  0a53 1e08          	ldw	x,(OFST+1,sp)
4022                     ; 1072         nBytes++;
4024  0a55               LC005:
4027  0a55 5c            	incw	x
4028  0a56 1f08          	ldw	(OFST+1,sp),x
4031  0a58 1e05          	ldw	x,(OFST-2,sp)
4032  0a5a 5c            	incw	x
4033  0a5b 1f05          	ldw	(OFST-2,sp),x
4035  0a5d               L306:
4036                     ; 689   while (nBytes < nMaxBytes) {
4038  0a5d 1e05          	ldw	x,(OFST-2,sp)
4039  0a5f 1310          	cpw	x,(OFST+9,sp)
4040  0a61 2403cc02e1    	jrult	L106
4041  0a66               L506:
4042                     ; 1077   return nBytes;
4044  0a66 1e05          	ldw	x,(OFST-2,sp)
4047  0a68 5b09          	addw	sp,#9
4048  0a6a 81            	ret	
4075                     ; 1081 void HttpDInit()
4075                     ; 1082 {
4076                     	switch	.text
4077  0a6b               _HttpDInit:
4081                     ; 1084   uip_listen(htons(Port_Httpd));
4083  0a6b ce0000        	ldw	x,_Port_Httpd
4084  0a6e cd0000        	call	_htons
4086  0a71 cd0000        	call	_uip_listen
4088                     ; 1085   current_webpage = WEBPAGE_DEFAULT;
4090  0a74 725f000b      	clr	_current_webpage
4091                     ; 1086 }
4094  0a78 81            	ret	
4300                     	switch	.const
4301  3d9d               L472:
4302  3d9d 0ff2          	dc.w	L7701
4303  3d9f 0ff9          	dc.w	L1011
4304  3da1 1000          	dc.w	L3011
4305  3da3 1007          	dc.w	L5011
4306  3da5 100e          	dc.w	L7011
4307  3da7 1015          	dc.w	L1111
4308  3da9 101c          	dc.w	L3111
4309  3dab 1023          	dc.w	L5111
4310  3dad 102a          	dc.w	L7111
4311  3daf 1031          	dc.w	L1211
4312  3db1 1038          	dc.w	L3211
4313  3db3 103f          	dc.w	L5211
4314  3db5 1046          	dc.w	L7211
4315  3db7 104d          	dc.w	L1311
4316  3db9 1054          	dc.w	L3311
4317  3dbb 105b          	dc.w	L5311
4318  3dbd 1062          	dc.w	L7311
4319  3dbf 1069          	dc.w	L1411
4320  3dc1 1070          	dc.w	L3411
4321  3dc3 1077          	dc.w	L5411
4322  3dc5 107e          	dc.w	L7411
4323  3dc7 1085          	dc.w	L1511
4324  3dc9 108c          	dc.w	L3511
4325  3dcb 1093          	dc.w	L5511
4326  3dcd 109a          	dc.w	L7511
4327  3dcf 10a1          	dc.w	L1611
4328  3dd1 10a8          	dc.w	L3611
4329  3dd3 10af          	dc.w	L5611
4330  3dd5 10b6          	dc.w	L7611
4331  3dd7 10bd          	dc.w	L1711
4332  3dd9 10c4          	dc.w	L3711
4333  3ddb 10cb          	dc.w	L5711
4334  3ddd 1158          	dc.w	L3221
4335  3ddf 1158          	dc.w	L3221
4336  3de1 1158          	dc.w	L3221
4337  3de3 1158          	dc.w	L3221
4338  3de5 1158          	dc.w	L3221
4339  3de7 1158          	dc.w	L3221
4340  3de9 1158          	dc.w	L3221
4341  3deb 1158          	dc.w	L3221
4342  3ded 1158          	dc.w	L3221
4343  3def 1158          	dc.w	L3221
4344  3df1 1158          	dc.w	L3221
4345  3df3 1158          	dc.w	L3221
4346  3df5 1158          	dc.w	L3221
4347  3df7 1158          	dc.w	L3221
4348  3df9 1158          	dc.w	L3221
4349  3dfb 1158          	dc.w	L3221
4350  3dfd 1158          	dc.w	L3221
4351  3dff 1158          	dc.w	L3221
4352  3e01 1158          	dc.w	L3221
4353  3e03 1158          	dc.w	L3221
4354  3e05 1158          	dc.w	L3221
4355  3e07 1158          	dc.w	L3221
4356  3e09 1158          	dc.w	L3221
4357  3e0b 10d2          	dc.w	L7711
4358  3e0d 10dd          	dc.w	L1021
4359  3e0f 1158          	dc.w	L3221
4360  3e11 1158          	dc.w	L3221
4361  3e13 1158          	dc.w	L3221
4362  3e15 10e8          	dc.w	L3021
4363  3e17 10ea          	dc.w	L5021
4364  3e19 1158          	dc.w	L3221
4365  3e1b 10fc          	dc.w	L7021
4366  3e1d 110e          	dc.w	L1121
4367  3e1f 1120          	dc.w	L3121
4368  3e21 112b          	dc.w	L5121
4369                     ; 1089 void HttpDCall(	uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
4369                     ; 1090 {
4370                     	switch	.text
4371  0a79               _HttpDCall:
4373  0a79 89            	pushw	x
4374  0a7a 5207          	subw	sp,#7
4375       00000007      OFST:	set	7
4378                     ; 1100   alpha_1 = '0';
4380                     ; 1101   alpha_2 = '0';
4382                     ; 1102   alpha_3 = '0';
4384                     ; 1103   alpha_4 = '0';
4386                     ; 1104   alpha_5 = '0';
4388                     ; 1106   if(uip_connected()) {
4390  0a7c 720d00007a    	btjf	_uip_flags,#6,L3231
4391                     ; 1108     if(current_webpage == WEBPAGE_DEFAULT) {
4393  0a81 c6000b        	ld	a,_current_webpage
4394  0a84 260e          	jrne	L5231
4395                     ; 1109       pSocket->pData = g_HtmlPageDefault;
4397  0a86 1e0e          	ldw	x,(OFST+7,sp)
4398  0a88 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
4399  0a8c ef01          	ldw	(1,x),y
4400                     ; 1110       pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
4402  0a8e 90ae15d5      	ldw	y,#5589
4404  0a92 2058          	jp	LC008
4405  0a94               L5231:
4406                     ; 1114     else if(current_webpage == WEBPAGE_ADDRESS) {
4408  0a94 a101          	cp	a,#1
4409  0a96 260e          	jrne	L1331
4410                     ; 1115       pSocket->pData = g_HtmlPageAddress;
4412  0a98 1e0e          	ldw	x,(OFST+7,sp)
4413  0a9a 90ae15de      	ldw	y,#L71_g_HtmlPageAddress
4414  0a9e ef01          	ldw	(1,x),y
4415                     ; 1116       pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
4417  0aa0 90ae1341      	ldw	y,#4929
4419  0aa4 2046          	jp	LC008
4420  0aa6               L1331:
4421                     ; 1120     else if(current_webpage == WEBPAGE_HELP) {
4423  0aa6 a103          	cp	a,#3
4424  0aa8 260e          	jrne	L5331
4425                     ; 1121       pSocket->pData = g_HtmlPageHelp;
4427  0aaa 1e0e          	ldw	x,(OFST+7,sp)
4428  0aac 90ae2920      	ldw	y,#L12_g_HtmlPageHelp
4429  0ab0 ef01          	ldw	(1,x),y
4430                     ; 1122       pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
4432  0ab2 90ae075c      	ldw	y,#1884
4434  0ab6 2034          	jp	LC008
4435  0ab8               L5331:
4436                     ; 1124     else if(current_webpage == WEBPAGE_HELP2) {
4438  0ab8 a104          	cp	a,#4
4439  0aba 260e          	jrne	L1431
4440                     ; 1125       pSocket->pData = g_HtmlPageHelp2;
4442  0abc 1e0e          	ldw	x,(OFST+7,sp)
4443  0abe 90ae307d      	ldw	y,#L32_g_HtmlPageHelp2
4444  0ac2 ef01          	ldw	(1,x),y
4445                     ; 1126       pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
4447  0ac4 90ae02bb      	ldw	y,#699
4449  0ac8 2022          	jp	LC008
4450  0aca               L1431:
4451                     ; 1131     else if(current_webpage == WEBPAGE_STATS) {
4453  0aca a105          	cp	a,#5
4454  0acc 260e          	jrne	L5431
4455                     ; 1132       pSocket->pData = g_HtmlPageStats;
4457  0ace 1e0e          	ldw	x,(OFST+7,sp)
4458  0ad0 90ae3339      	ldw	y,#L52_g_HtmlPageStats
4459  0ad4 ef01          	ldw	(1,x),y
4460                     ; 1133       pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
4462  0ad6 90ae097e      	ldw	y,#2430
4464  0ada 2010          	jp	LC008
4465  0adc               L5431:
4466                     ; 1136     else if(current_webpage == WEBPAGE_RSTATE) {
4468  0adc a106          	cp	a,#6
4469  0ade 260e          	jrne	L7231
4470                     ; 1137       pSocket->pData = g_HtmlPageRstate;
4472  0ae0 1e0e          	ldw	x,(OFST+7,sp)
4473  0ae2 90ae3cb8      	ldw	y,#L72_g_HtmlPageRstate
4474  0ae6 ef01          	ldw	(1,x),y
4475                     ; 1138       pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
4477  0ae8 90ae00a0      	ldw	y,#160
4478  0aec               LC008:
4479  0aec ef03          	ldw	(3,x),y
4480  0aee               L7231:
4481                     ; 1140     pSocket->nNewlines = 0;
4483  0aee 1e0e          	ldw	x,(OFST+7,sp)
4484                     ; 1141     pSocket->nState = STATE_CONNECTED;
4486  0af0 7f            	clr	(x)
4487  0af1 6f05          	clr	(5,x)
4488                     ; 1142     pSocket->nPrevBytes = 0xFFFF;
4490  0af3 90aeffff      	ldw	y,#65535
4491  0af7 ef0a          	ldw	(10,x),y
4493  0af9 2041          	jra	L613
4494  0afb               L3231:
4495                     ; 1144   else if (uip_newdata() || uip_acked()) {
4497  0afb 7202000008    	btjt	_uip_flags,#1,L7531
4499  0b00 7200000003cc  	btjf	_uip_flags,#0,L5531
4500  0b08               L7531:
4501                     ; 1145     if (pSocket->nState == STATE_CONNECTED) {
4503  0b08 1e0e          	ldw	x,(OFST+7,sp)
4504  0b0a f6            	ld	a,(x)
4505  0b0b 2627          	jrne	L1631
4506                     ; 1146       if (nBytes == 0) return;
4508  0b0d 1e0c          	ldw	x,(OFST+5,sp)
4509  0b0f 272b          	jreq	L613
4512                     ; 1147       if (*pBuffer == 'G') pSocket->nState = STATE_GET_G;
4514  0b11 1e08          	ldw	x,(OFST+1,sp)
4515  0b13 f6            	ld	a,(x)
4516  0b14 a147          	cp	a,#71
4517  0b16 2606          	jrne	L5631
4520  0b18 1e0e          	ldw	x,(OFST+7,sp)
4521  0b1a a601          	ld	a,#1
4523  0b1c 2008          	jp	LC009
4524  0b1e               L5631:
4525                     ; 1148       else if (*pBuffer == 'P') pSocket->nState = STATE_POST_P;
4527  0b1e a150          	cp	a,#80
4528  0b20 2605          	jrne	L7631
4531  0b22 1e0e          	ldw	x,(OFST+7,sp)
4532  0b24 a604          	ld	a,#4
4533  0b26               LC009:
4534  0b26 f7            	ld	(x),a
4535  0b27               L7631:
4536                     ; 1149       nBytes--;
4538  0b27 1e0c          	ldw	x,(OFST+5,sp)
4539  0b29 5a            	decw	x
4540  0b2a 1f0c          	ldw	(OFST+5,sp),x
4541                     ; 1150       pBuffer++;
4543  0b2c 1e08          	ldw	x,(OFST+1,sp)
4544  0b2e 5c            	incw	x
4545  0b2f 1f08          	ldw	(OFST+1,sp),x
4546  0b31 1e0e          	ldw	x,(OFST+7,sp)
4547  0b33 f6            	ld	a,(x)
4548  0b34               L1631:
4549                     ; 1153     if (pSocket->nState == STATE_GET_G) {
4551  0b34 a101          	cp	a,#1
4552  0b36 2620          	jrne	L3731
4553                     ; 1154       if (nBytes == 0) return;
4555  0b38 1e0c          	ldw	x,(OFST+5,sp)
4556  0b3a 2603          	jrne	L5731
4558  0b3c               L613:
4561  0b3c 5b09          	addw	sp,#9
4562  0b3e 81            	ret	
4563  0b3f               L5731:
4564                     ; 1155       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
4566  0b3f 1e08          	ldw	x,(OFST+1,sp)
4567  0b41 f6            	ld	a,(x)
4568  0b42 a145          	cp	a,#69
4569  0b44 2605          	jrne	L7731
4572  0b46 1e0e          	ldw	x,(OFST+7,sp)
4573  0b48 a602          	ld	a,#2
4574  0b4a f7            	ld	(x),a
4575  0b4b               L7731:
4576                     ; 1156       nBytes--;
4578  0b4b 1e0c          	ldw	x,(OFST+5,sp)
4579  0b4d 5a            	decw	x
4580  0b4e 1f0c          	ldw	(OFST+5,sp),x
4581                     ; 1157       pBuffer++;
4583  0b50 1e08          	ldw	x,(OFST+1,sp)
4584  0b52 5c            	incw	x
4585  0b53 1f08          	ldw	(OFST+1,sp),x
4586  0b55 1e0e          	ldw	x,(OFST+7,sp)
4587  0b57 f6            	ld	a,(x)
4588  0b58               L3731:
4589                     ; 1160     if (pSocket->nState == STATE_GET_GE) {
4591  0b58 a102          	cp	a,#2
4592  0b5a 261d          	jrne	L1041
4593                     ; 1161       if (nBytes == 0) return;
4595  0b5c 1e0c          	ldw	x,(OFST+5,sp)
4596  0b5e 27dc          	jreq	L613
4599                     ; 1162       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
4601  0b60 1e08          	ldw	x,(OFST+1,sp)
4602  0b62 f6            	ld	a,(x)
4603  0b63 a154          	cp	a,#84
4604  0b65 2605          	jrne	L5041
4607  0b67 1e0e          	ldw	x,(OFST+7,sp)
4608  0b69 a603          	ld	a,#3
4609  0b6b f7            	ld	(x),a
4610  0b6c               L5041:
4611                     ; 1163       nBytes--;
4613  0b6c 1e0c          	ldw	x,(OFST+5,sp)
4614  0b6e 5a            	decw	x
4615  0b6f 1f0c          	ldw	(OFST+5,sp),x
4616                     ; 1164       pBuffer++;
4618  0b71 1e08          	ldw	x,(OFST+1,sp)
4619  0b73 5c            	incw	x
4620  0b74 1f08          	ldw	(OFST+1,sp),x
4621  0b76 1e0e          	ldw	x,(OFST+7,sp)
4622  0b78 f6            	ld	a,(x)
4623  0b79               L1041:
4624                     ; 1167     if (pSocket->nState == STATE_GET_GET) {
4626  0b79 a103          	cp	a,#3
4627  0b7b 261d          	jrne	L7041
4628                     ; 1168       if (nBytes == 0) return;
4630  0b7d 1e0c          	ldw	x,(OFST+5,sp)
4631  0b7f 27bb          	jreq	L613
4634                     ; 1169       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
4636  0b81 1e08          	ldw	x,(OFST+1,sp)
4637  0b83 f6            	ld	a,(x)
4638  0b84 a120          	cp	a,#32
4639  0b86 2605          	jrne	L3141
4642  0b88 1e0e          	ldw	x,(OFST+7,sp)
4643  0b8a a608          	ld	a,#8
4644  0b8c f7            	ld	(x),a
4645  0b8d               L3141:
4646                     ; 1170       nBytes--;
4648  0b8d 1e0c          	ldw	x,(OFST+5,sp)
4649  0b8f 5a            	decw	x
4650  0b90 1f0c          	ldw	(OFST+5,sp),x
4651                     ; 1171       pBuffer++;
4653  0b92 1e08          	ldw	x,(OFST+1,sp)
4654  0b94 5c            	incw	x
4655  0b95 1f08          	ldw	(OFST+1,sp),x
4656  0b97 1e0e          	ldw	x,(OFST+7,sp)
4657  0b99 f6            	ld	a,(x)
4658  0b9a               L7041:
4659                     ; 1174     if (pSocket->nState == STATE_POST_P) {
4661  0b9a a104          	cp	a,#4
4662  0b9c 261d          	jrne	L5141
4663                     ; 1175       if (nBytes == 0) return;
4665  0b9e 1e0c          	ldw	x,(OFST+5,sp)
4666  0ba0 279a          	jreq	L613
4669                     ; 1176       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
4671  0ba2 1e08          	ldw	x,(OFST+1,sp)
4672  0ba4 f6            	ld	a,(x)
4673  0ba5 a14f          	cp	a,#79
4674  0ba7 2605          	jrne	L1241
4677  0ba9 1e0e          	ldw	x,(OFST+7,sp)
4678  0bab a605          	ld	a,#5
4679  0bad f7            	ld	(x),a
4680  0bae               L1241:
4681                     ; 1177       nBytes--;
4683  0bae 1e0c          	ldw	x,(OFST+5,sp)
4684  0bb0 5a            	decw	x
4685  0bb1 1f0c          	ldw	(OFST+5,sp),x
4686                     ; 1178       pBuffer++;
4688  0bb3 1e08          	ldw	x,(OFST+1,sp)
4689  0bb5 5c            	incw	x
4690  0bb6 1f08          	ldw	(OFST+1,sp),x
4691  0bb8 1e0e          	ldw	x,(OFST+7,sp)
4692  0bba f6            	ld	a,(x)
4693  0bbb               L5141:
4694                     ; 1181     if (pSocket->nState == STATE_POST_PO) {
4696  0bbb a105          	cp	a,#5
4697  0bbd 2620          	jrne	L3241
4698                     ; 1182       if (nBytes == 0) return;
4700  0bbf 1e0c          	ldw	x,(OFST+5,sp)
4701  0bc1 2603cc0b3c    	jreq	L613
4704                     ; 1183       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
4706  0bc6 1e08          	ldw	x,(OFST+1,sp)
4707  0bc8 f6            	ld	a,(x)
4708  0bc9 a153          	cp	a,#83
4709  0bcb 2605          	jrne	L7241
4712  0bcd 1e0e          	ldw	x,(OFST+7,sp)
4713  0bcf a606          	ld	a,#6
4714  0bd1 f7            	ld	(x),a
4715  0bd2               L7241:
4716                     ; 1184       nBytes--;
4718  0bd2 1e0c          	ldw	x,(OFST+5,sp)
4719  0bd4 5a            	decw	x
4720  0bd5 1f0c          	ldw	(OFST+5,sp),x
4721                     ; 1185       pBuffer++;
4723  0bd7 1e08          	ldw	x,(OFST+1,sp)
4724  0bd9 5c            	incw	x
4725  0bda 1f08          	ldw	(OFST+1,sp),x
4726  0bdc 1e0e          	ldw	x,(OFST+7,sp)
4727  0bde f6            	ld	a,(x)
4728  0bdf               L3241:
4729                     ; 1188     if (pSocket->nState == STATE_POST_POS) {
4731  0bdf a106          	cp	a,#6
4732  0be1 261d          	jrne	L1341
4733                     ; 1189       if (nBytes == 0) return;
4735  0be3 1e0c          	ldw	x,(OFST+5,sp)
4736  0be5 27dc          	jreq	L613
4739                     ; 1190       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
4741  0be7 1e08          	ldw	x,(OFST+1,sp)
4742  0be9 f6            	ld	a,(x)
4743  0bea a154          	cp	a,#84
4744  0bec 2605          	jrne	L5341
4747  0bee 1e0e          	ldw	x,(OFST+7,sp)
4748  0bf0 a607          	ld	a,#7
4749  0bf2 f7            	ld	(x),a
4750  0bf3               L5341:
4751                     ; 1191       nBytes--;
4753  0bf3 1e0c          	ldw	x,(OFST+5,sp)
4754  0bf5 5a            	decw	x
4755  0bf6 1f0c          	ldw	(OFST+5,sp),x
4756                     ; 1192       pBuffer++;
4758  0bf8 1e08          	ldw	x,(OFST+1,sp)
4759  0bfa 5c            	incw	x
4760  0bfb 1f08          	ldw	(OFST+1,sp),x
4761  0bfd 1e0e          	ldw	x,(OFST+7,sp)
4762  0bff f6            	ld	a,(x)
4763  0c00               L1341:
4764                     ; 1195     if (pSocket->nState == STATE_POST_POST) {
4766  0c00 a107          	cp	a,#7
4767  0c02 261d          	jrne	L7341
4768                     ; 1196       if (nBytes == 0) return;
4770  0c04 1e0c          	ldw	x,(OFST+5,sp)
4771  0c06 27bb          	jreq	L613
4774                     ; 1197       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
4776  0c08 1e08          	ldw	x,(OFST+1,sp)
4777  0c0a f6            	ld	a,(x)
4778  0c0b a120          	cp	a,#32
4779  0c0d 2605          	jrne	L3441
4782  0c0f 1e0e          	ldw	x,(OFST+7,sp)
4783  0c11 a609          	ld	a,#9
4784  0c13 f7            	ld	(x),a
4785  0c14               L3441:
4786                     ; 1198       nBytes--;
4788  0c14 1e0c          	ldw	x,(OFST+5,sp)
4789  0c16 5a            	decw	x
4790  0c17 1f0c          	ldw	(OFST+5,sp),x
4791                     ; 1199       pBuffer++;
4793  0c19 1e08          	ldw	x,(OFST+1,sp)
4794  0c1b 5c            	incw	x
4795  0c1c 1f08          	ldw	(OFST+1,sp),x
4796  0c1e 1e0e          	ldw	x,(OFST+7,sp)
4797  0c20 f6            	ld	a,(x)
4798  0c21               L7341:
4799                     ; 1202     if (pSocket->nState == STATE_GOTPOST) {
4801  0c21 a109          	cp	a,#9
4802  0c23 264c          	jrne	L5441
4804  0c25 2046          	jra	L1541
4805  0c27               L7441:
4806                     ; 1205         if (*pBuffer == '\n') {
4808  0c27 1e08          	ldw	x,(OFST+1,sp)
4809  0c29 f6            	ld	a,(x)
4810  0c2a a10a          	cp	a,#10
4811  0c2c 2606          	jrne	L5541
4812                     ; 1206           pSocket->nNewlines++;
4814  0c2e 1e0e          	ldw	x,(OFST+7,sp)
4815  0c30 6c05          	inc	(5,x)
4817  0c32 2008          	jra	L7541
4818  0c34               L5541:
4819                     ; 1208         else if (*pBuffer == '\r') {
4821  0c34 a10d          	cp	a,#13
4822  0c36 2704          	jreq	L7541
4824                     ; 1211           pSocket->nNewlines = 0;
4826  0c38 1e0e          	ldw	x,(OFST+7,sp)
4827  0c3a 6f05          	clr	(5,x)
4828  0c3c               L7541:
4829                     ; 1213         pBuffer++;
4831  0c3c 1e08          	ldw	x,(OFST+1,sp)
4832  0c3e 5c            	incw	x
4833  0c3f 1f08          	ldw	(OFST+1,sp),x
4834                     ; 1214         nBytes--;
4836  0c41 1e0c          	ldw	x,(OFST+5,sp)
4837  0c43 5a            	decw	x
4838  0c44 1f0c          	ldw	(OFST+5,sp),x
4839                     ; 1215         if (pSocket->nNewlines == 2) {
4841  0c46 1e0e          	ldw	x,(OFST+7,sp)
4842  0c48 e605          	ld	a,(5,x)
4843  0c4a a102          	cp	a,#2
4844  0c4c 261f          	jrne	L1541
4845                     ; 1217           if (pSocket->nState == STATE_GOTPOST) {
4847  0c4e f6            	ld	a,(x)
4848  0c4f a109          	cp	a,#9
4849  0c51 261e          	jrne	L5441
4850                     ; 1219             if(current_webpage == WEBPAGE_DEFAULT) pSocket->nParseLeft = PARSEBYTES_DEFAULT;
4852  0c53 c6000b        	ld	a,_current_webpage
4853  0c56 2607          	jrne	L1741
4856  0c58 a67e          	ld	a,#126
4857  0c5a e706          	ld	(6,x),a
4858  0c5c c6000b        	ld	a,_current_webpage
4859  0c5f               L1741:
4860                     ; 1220             if(current_webpage == WEBPAGE_ADDRESS) pSocket->nParseLeft = PARSEBYTES_ADDRESS;
4862  0c5f 4a            	dec	a
4863  0c60 2604          	jrne	L3741
4866  0c62 a693          	ld	a,#147
4867  0c64 e706          	ld	(6,x),a
4868  0c66               L3741:
4869                     ; 1221             pSocket->ParseState = PARSE_CMD;
4871  0c66 6f09          	clr	(9,x)
4872                     ; 1223             pSocket->nState = STATE_PARSEPOST;
4874  0c68 a60a          	ld	a,#10
4875  0c6a f7            	ld	(x),a
4876  0c6b 2004          	jra	L5441
4877  0c6d               L1541:
4878                     ; 1204       while (nBytes != 0) {
4880  0c6d 1e0c          	ldw	x,(OFST+5,sp)
4881  0c6f 26b6          	jrne	L7441
4882  0c71               L5441:
4883                     ; 1230     if (pSocket->nState == STATE_GOTGET) {
4885  0c71 1e0e          	ldw	x,(OFST+7,sp)
4886  0c73 f6            	ld	a,(x)
4887  0c74 a108          	cp	a,#8
4888  0c76 2609          	jrne	L5741
4889                     ; 1233       pSocket->nParseLeft = 6; // Small parse number since we should have short
4891  0c78 a606          	ld	a,#6
4892  0c7a e706          	ld	(6,x),a
4893                     ; 1235       pSocket->ParseState = PARSE_SLASH1;
4895  0c7c e709          	ld	(9,x),a
4896                     ; 1237       pSocket->nState = STATE_PARSEGET;
4898  0c7e a60d          	ld	a,#13
4899  0c80 f7            	ld	(x),a
4900  0c81               L5741:
4901                     ; 1240     if (pSocket->nState == STATE_PARSEPOST) {
4903  0c81 a10a          	cp	a,#10
4904  0c83 2703cc0ef3    	jrne	L7741
4906  0c88 cc0ee4        	jra	L3051
4907  0c8b               L1051:
4908                     ; 1250         if (pSocket->ParseState == PARSE_CMD) {
4910  0c8b 1e0e          	ldw	x,(OFST+7,sp)
4911  0c8d e609          	ld	a,(9,x)
4912  0c8f 263e          	jrne	L7051
4913                     ; 1251           pSocket->ParseCmd = *pBuffer;
4915  0c91 1e08          	ldw	x,(OFST+1,sp)
4916  0c93 f6            	ld	a,(x)
4917  0c94 1e0e          	ldw	x,(OFST+7,sp)
4918  0c96 e707          	ld	(7,x),a
4919                     ; 1252           pSocket->ParseState = PARSE_NUM10;
4921  0c98 a601          	ld	a,#1
4922  0c9a e709          	ld	(9,x),a
4923                     ; 1253 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
4925  0c9c e606          	ld	a,(6,x)
4926  0c9e 2704          	jreq	L1151
4929  0ca0 6a06          	dec	(6,x)
4931  0ca2 2004          	jra	L3151
4932  0ca4               L1151:
4933                     ; 1254 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
4935  0ca4 a605          	ld	a,#5
4936  0ca6 e709          	ld	(9,x),a
4937  0ca8               L3151:
4938                     ; 1255           pBuffer++;
4940  0ca8 1e08          	ldw	x,(OFST+1,sp)
4941  0caa 5c            	incw	x
4942  0cab 1f08          	ldw	(OFST+1,sp),x
4943                     ; 1257 	  if (pSocket->ParseCmd == 'o' ||
4943                     ; 1258 	      pSocket->ParseCmd == 'a' ||
4943                     ; 1259 	      pSocket->ParseCmd == 'b' ||
4943                     ; 1260 	      pSocket->ParseCmd == 'c' ||
4943                     ; 1261 	      pSocket->ParseCmd == 'd' ||
4943                     ; 1262 	      pSocket->ParseCmd == 'g') { }
4945  0cad 1e0e          	ldw	x,(OFST+7,sp)
4946  0caf e607          	ld	a,(7,x)
4947  0cb1 a16f          	cp	a,#111
4948  0cb3 2603cc0ed6    	jreq	L3351
4950  0cb8 a161          	cp	a,#97
4951  0cba 27f9          	jreq	L3351
4953  0cbc a162          	cp	a,#98
4954  0cbe 27f5          	jreq	L3351
4956  0cc0 a163          	cp	a,#99
4957  0cc2 27f1          	jreq	L3351
4959  0cc4 a164          	cp	a,#100
4960  0cc6 27ed          	jreq	L3351
4962  0cc8 a167          	cp	a,#103
4963  0cca 27e9          	jreq	L3351
4964                     ; 1263 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
4965  0ccc cc0ebb        	jp	LC014
4966  0ccf               L7051:
4967                     ; 1265         else if (pSocket->ParseState == PARSE_NUM10) {
4969  0ccf a101          	cp	a,#1
4970  0cd1 2619          	jrne	L5351
4971                     ; 1266           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
4973  0cd3 1e08          	ldw	x,(OFST+1,sp)
4974  0cd5 f6            	ld	a,(x)
4975  0cd6 97            	ld	xl,a
4976  0cd7 a60a          	ld	a,#10
4977  0cd9 42            	mul	x,a
4978  0cda 9f            	ld	a,xl
4979  0cdb 1e0e          	ldw	x,(OFST+7,sp)
4980  0cdd a0e0          	sub	a,#224
4981  0cdf e708          	ld	(8,x),a
4982                     ; 1267           pSocket->ParseState = PARSE_NUM1;
4984  0ce1 a602          	ld	a,#2
4985  0ce3 e709          	ld	(9,x),a
4986                     ; 1268 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
4988  0ce5 e606          	ld	a,(6,x)
4989  0ce7 2719          	jreq	L7451
4992  0ce9 cc0ecb        	jp	LC021
4993                     ; 1269 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
4994                     ; 1270           pBuffer++;
4996  0cec               L5351:
4997                     ; 1272         else if (pSocket->ParseState == PARSE_NUM1) {
4999  0cec a102          	cp	a,#2
5000  0cee 2616          	jrne	L5451
5001                     ; 1273           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5003  0cf0 1608          	ldw	y,(OFST+1,sp)
5004  0cf2 90f6          	ld	a,(y)
5005  0cf4 a030          	sub	a,#48
5006  0cf6 eb08          	add	a,(8,x)
5007  0cf8 e708          	ld	(8,x),a
5008                     ; 1274           pSocket->ParseState = PARSE_EQUAL;
5010  0cfa a603          	ld	a,#3
5011  0cfc e709          	ld	(9,x),a
5012                     ; 1275 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5014  0cfe e606          	ld	a,(6,x)
5017  0d00 26e7          	jrne	LC021
5018  0d02               L7451:
5019                     ; 1276 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5022  0d02 a605          	ld	a,#5
5023                     ; 1277           pBuffer++;
5025  0d04 200d          	jp	LC022
5026  0d06               L5451:
5027                     ; 1279         else if (pSocket->ParseState == PARSE_EQUAL) {
5029  0d06 a103          	cp	a,#3
5030  0d08 260e          	jrne	L5551
5031                     ; 1280           pSocket->ParseState = PARSE_VAL;
5033  0d0a a604          	ld	a,#4
5034  0d0c e709          	ld	(9,x),a
5035                     ; 1281 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5037  0d0e 6d06          	tnz	(6,x)
5040  0d10 26d7          	jrne	LC021
5041                     ; 1282 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5043  0d12 4c            	inc	a
5044  0d13               LC022:
5045  0d13 e709          	ld	(9,x),a
5046                     ; 1283           pBuffer++;
5048  0d15 cc0ecd        	jp	LC013
5049  0d18               L5551:
5050                     ; 1285         else if (pSocket->ParseState == PARSE_VAL) {
5052  0d18 a104          	cp	a,#4
5053  0d1a 2703cc0ec1    	jrne	L5651
5054                     ; 1293           if (pSocket->ParseCmd == 'o') {
5056  0d1f e607          	ld	a,(7,x)
5057  0d21 a16f          	cp	a,#111
5058  0d23 2625          	jrne	L7651
5059                     ; 1296             if ((uint8_t)(*pBuffer) == '1') GpioSetPin(pSocket->ParseNum, (uint8_t)1);
5061  0d25 1e08          	ldw	x,(OFST+1,sp)
5062  0d27 f6            	ld	a,(x)
5063  0d28 a131          	cp	a,#49
5064  0d2a 2609          	jrne	L1751
5067  0d2c 1e0e          	ldw	x,(OFST+7,sp)
5068  0d2e e608          	ld	a,(8,x)
5069  0d30 ae0001        	ldw	x,#1
5072  0d33 2005          	jra	L3751
5073  0d35               L1751:
5074                     ; 1297             else GpioSetPin(pSocket->ParseNum, (uint8_t)0);
5076  0d35 1e0e          	ldw	x,(OFST+7,sp)
5077  0d37 e608          	ld	a,(8,x)
5078  0d39 5f            	clrw	x
5080  0d3a               L3751:
5081  0d3a 95            	ld	xh,a
5082  0d3b cd135a        	call	_GpioSetPin
5083                     ; 1298 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5085  0d3e 1e0e          	ldw	x,(OFST+7,sp)
5086  0d40 e606          	ld	a,(6,x)
5087  0d42 2603cc0eb4    	jreq	L5461
5089                     ; 1299             pBuffer++;
5091  0d47 cc0eb2        	jp	LC020
5092  0d4a               L7651:
5093                     ; 1302           else if (pSocket->ParseCmd == 'a') {
5095  0d4a a161          	cp	a,#97
5096  0d4c 2656          	jrne	L1061
5097                     ; 1312             ex_stored_devicename[0] = (uint8_t)(*pBuffer);
5099  0d4e 1e08          	ldw	x,(OFST+1,sp)
5100  0d50 f6            	ld	a,(x)
5101  0d51 c70000        	ld	_ex_stored_devicename,a
5102                     ; 1313             pSocket->nParseLeft--;
5104  0d54 1e0e          	ldw	x,(OFST+7,sp)
5105  0d56 6a06          	dec	(6,x)
5106                     ; 1314             pBuffer++; // nBytes already decremented for first char
5108  0d58 1e08          	ldw	x,(OFST+1,sp)
5109  0d5a 5c            	incw	x
5110  0d5b 1f08          	ldw	(OFST+1,sp),x
5111                     ; 1318 	    amp_found = 0;
5113  0d5d 0f06          	clr	(OFST-1,sp)
5115                     ; 1319 	    for(i=1; i<20; i++) {
5117  0d5f a601          	ld	a,#1
5118  0d61 6b07          	ld	(OFST+0,sp),a
5120  0d63               L3061:
5121                     ; 1320 	      if((uint8_t)(*pBuffer) == 38) amp_found = 1;
5123  0d63 1e08          	ldw	x,(OFST+1,sp)
5124  0d65 f6            	ld	a,(x)
5125  0d66 a126          	cp	a,#38
5126  0d68 2604          	jrne	L1161
5129  0d6a a601          	ld	a,#1
5130  0d6c 6b06          	ld	(OFST-1,sp),a
5132  0d6e               L1161:
5133                     ; 1321 	      if(amp_found == 0) {
5135  0d6e 7b06          	ld	a,(OFST-1,sp)
5136  0d70 261a          	jrne	L3161
5137                     ; 1323                 ex_stored_devicename[i] = (uint8_t)(*pBuffer);
5139  0d72 7b07          	ld	a,(OFST+0,sp)
5140  0d74 5f            	clrw	x
5141  0d75 1608          	ldw	y,(OFST+1,sp)
5142  0d77 97            	ld	xl,a
5143  0d78 90f6          	ld	a,(y)
5144  0d7a d70000        	ld	(_ex_stored_devicename,x),a
5145                     ; 1324                 pSocket->nParseLeft--;
5147  0d7d 1e0e          	ldw	x,(OFST+7,sp)
5148  0d7f 6a06          	dec	(6,x)
5149                     ; 1325                 pBuffer++;
5151  0d81 93            	ldw	x,y
5152  0d82 5c            	incw	x
5153  0d83 1f08          	ldw	(OFST+1,sp),x
5154                     ; 1326                 nBytes--; // Must subtract 1 from nBytes for extra byte read
5156  0d85 1e0c          	ldw	x,(OFST+5,sp)
5157  0d87 5a            	decw	x
5158  0d88 1f0c          	ldw	(OFST+5,sp),x
5160  0d8a 200d          	jra	L5161
5161  0d8c               L3161:
5162                     ; 1330 	        ex_stored_devicename[i] = ' ';
5164  0d8c 7b07          	ld	a,(OFST+0,sp)
5165  0d8e 5f            	clrw	x
5166  0d8f 97            	ld	xl,a
5167  0d90 a620          	ld	a,#32
5168  0d92 d70000        	ld	(_ex_stored_devicename,x),a
5169                     ; 1339                 pSocket->nParseLeft--;
5171  0d95 1e0e          	ldw	x,(OFST+7,sp)
5172  0d97 6a06          	dec	(6,x)
5173  0d99               L5161:
5174                     ; 1319 	    for(i=1; i<20; i++) {
5176  0d99 0c07          	inc	(OFST+0,sp)
5180  0d9b 7b07          	ld	a,(OFST+0,sp)
5181  0d9d a114          	cp	a,#20
5182  0d9f 25c2          	jrult	L3061
5184  0da1 cc0eb9        	jra	L7751
5185  0da4               L1061:
5186                     ; 1344           else if (pSocket->ParseCmd == 'b') {
5188  0da4 a162          	cp	a,#98
5189  0da6 2646          	jrne	L1261
5190                     ; 1351 	    alpha_1 = '-';
5192                     ; 1352 	    alpha_2 = '-';
5194                     ; 1353 	    alpha_3 = '-';
5196                     ; 1355             alpha_1 = (uint8_t)(*pBuffer);
5198  0da8 1e08          	ldw	x,(OFST+1,sp)
5199  0daa f6            	ld	a,(x)
5200  0dab 6b07          	ld	(OFST+0,sp),a
5202                     ; 1356             pSocket->nParseLeft--;
5204  0dad 1e0e          	ldw	x,(OFST+7,sp)
5205  0daf 6a06          	dec	(6,x)
5206                     ; 1357             pBuffer++; // nBytes already decremented for first char
5208  0db1 1e08          	ldw	x,(OFST+1,sp)
5209  0db3 5c            	incw	x
5210  0db4 1f08          	ldw	(OFST+1,sp),x
5211                     ; 1359 	    alpha_2 = (uint8_t)(*pBuffer);
5213  0db6 f6            	ld	a,(x)
5214  0db7 6b05          	ld	(OFST-2,sp),a
5216                     ; 1360             pSocket->nParseLeft--;
5218  0db9 1e0e          	ldw	x,(OFST+7,sp)
5219  0dbb 6a06          	dec	(6,x)
5220                     ; 1361             pBuffer++;
5222  0dbd 1e08          	ldw	x,(OFST+1,sp)
5223  0dbf 5c            	incw	x
5224  0dc0 1f08          	ldw	(OFST+1,sp),x
5225                     ; 1362 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5227  0dc2 1e0c          	ldw	x,(OFST+5,sp)
5228  0dc4 5a            	decw	x
5229  0dc5 1f0c          	ldw	(OFST+5,sp),x
5230                     ; 1364 	    alpha_3 = (uint8_t)(*pBuffer);
5232  0dc7 1e08          	ldw	x,(OFST+1,sp)
5233  0dc9 f6            	ld	a,(x)
5234  0dca 6b06          	ld	(OFST-1,sp),a
5236                     ; 1365             pSocket->nParseLeft--;
5238  0dcc 1e0e          	ldw	x,(OFST+7,sp)
5239  0dce 6a06          	dec	(6,x)
5240                     ; 1366             pBuffer++;
5242  0dd0 1e08          	ldw	x,(OFST+1,sp)
5243  0dd2 5c            	incw	x
5244  0dd3 1f08          	ldw	(OFST+1,sp),x
5245                     ; 1367 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5247  0dd5 1e0c          	ldw	x,(OFST+5,sp)
5248  0dd7 5a            	decw	x
5249  0dd8 1f0c          	ldw	(OFST+5,sp),x
5250                     ; 1369 	    SetAddresses(pSocket->ParseNum, (uint8_t)alpha_1, (uint8_t)alpha_2, (uint8_t)alpha_3);
5252  0dda 88            	push	a
5253  0ddb 7b06          	ld	a,(OFST-1,sp)
5254  0ddd 88            	push	a
5255  0dde 7b09          	ld	a,(OFST+2,sp)
5256  0de0 1610          	ldw	y,(OFST+9,sp)
5257  0de2 97            	ld	xl,a
5258  0de3 90e608        	ld	a,(8,y)
5259  0de6 95            	ld	xh,a
5260  0de7 cd1486        	call	_SetAddresses
5262  0dea 85            	popw	x
5264  0deb cc0eb9        	jra	L7751
5265  0dee               L1261:
5266                     ; 1372           else if (pSocket->ParseCmd == 'c') {
5268  0dee a163          	cp	a,#99
5269  0df0 2672          	jrne	L5261
5270                     ; 1378 	    alpha_1 = '-';
5272                     ; 1379 	    alpha_2 = '-';
5274                     ; 1380 	    alpha_3 = '-';
5276                     ; 1381 	    alpha_4 = '-';
5278                     ; 1382 	    alpha_5 = '-';
5280                     ; 1385   	    alpha_1 = (uint8_t)(*pBuffer);
5282  0df2 1e08          	ldw	x,(OFST+1,sp)
5283  0df4 f6            	ld	a,(x)
5284  0df5 6b07          	ld	(OFST+0,sp),a
5286                     ; 1386             pSocket->nParseLeft--;
5288  0df7 1e0e          	ldw	x,(OFST+7,sp)
5289  0df9 6a06          	dec	(6,x)
5290                     ; 1387             pBuffer++; // nBytes already decremented for first char
5292  0dfb 1e08          	ldw	x,(OFST+1,sp)
5293  0dfd 5c            	incw	x
5294  0dfe 1f08          	ldw	(OFST+1,sp),x
5295                     ; 1389 	    alpha_2 = (uint8_t)(*pBuffer);
5297  0e00 f6            	ld	a,(x)
5298  0e01 6b05          	ld	(OFST-2,sp),a
5300                     ; 1390             pSocket->nParseLeft--;
5302  0e03 1e0e          	ldw	x,(OFST+7,sp)
5303  0e05 6a06          	dec	(6,x)
5304                     ; 1391             pBuffer++;
5306  0e07 1e08          	ldw	x,(OFST+1,sp)
5307  0e09 5c            	incw	x
5308  0e0a 1f08          	ldw	(OFST+1,sp),x
5309                     ; 1392 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5311  0e0c 1e0c          	ldw	x,(OFST+5,sp)
5312  0e0e 5a            	decw	x
5313  0e0f 1f0c          	ldw	(OFST+5,sp),x
5314                     ; 1394 	    alpha_3 = (uint8_t)(*pBuffer);
5316  0e11 1e08          	ldw	x,(OFST+1,sp)
5317  0e13 f6            	ld	a,(x)
5318  0e14 6b06          	ld	(OFST-1,sp),a
5320                     ; 1395             pSocket->nParseLeft--;
5322  0e16 1e0e          	ldw	x,(OFST+7,sp)
5323  0e18 6a06          	dec	(6,x)
5324                     ; 1396             pBuffer++;
5326  0e1a 1e08          	ldw	x,(OFST+1,sp)
5327  0e1c 5c            	incw	x
5328  0e1d 1f08          	ldw	(OFST+1,sp),x
5329                     ; 1397 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5331  0e1f 1e0c          	ldw	x,(OFST+5,sp)
5332  0e21 5a            	decw	x
5333  0e22 1f0c          	ldw	(OFST+5,sp),x
5334                     ; 1399 	    alpha_4 = (uint8_t)(*pBuffer);
5336  0e24 1e08          	ldw	x,(OFST+1,sp)
5337  0e26 f6            	ld	a,(x)
5338  0e27 6b03          	ld	(OFST-4,sp),a
5340                     ; 1400             pSocket->nParseLeft--;
5342  0e29 1e0e          	ldw	x,(OFST+7,sp)
5343  0e2b 6a06          	dec	(6,x)
5344                     ; 1401             pBuffer++;
5346  0e2d 1e08          	ldw	x,(OFST+1,sp)
5347  0e2f 5c            	incw	x
5348  0e30 1f08          	ldw	(OFST+1,sp),x
5349                     ; 1402 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5351  0e32 1e0c          	ldw	x,(OFST+5,sp)
5352  0e34 5a            	decw	x
5353  0e35 1f0c          	ldw	(OFST+5,sp),x
5354                     ; 1404             alpha_5 = (uint8_t)(*pBuffer);
5356  0e37 1e08          	ldw	x,(OFST+1,sp)
5357  0e39 f6            	ld	a,(x)
5358  0e3a 6b04          	ld	(OFST-3,sp),a
5360                     ; 1405             pSocket->nParseLeft--;
5362  0e3c 1e0e          	ldw	x,(OFST+7,sp)
5363  0e3e 6a06          	dec	(6,x)
5364                     ; 1406             pBuffer++;
5366  0e40 1e08          	ldw	x,(OFST+1,sp)
5367  0e42 5c            	incw	x
5368  0e43 1f08          	ldw	(OFST+1,sp),x
5369                     ; 1407 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5371  0e45 1e0c          	ldw	x,(OFST+5,sp)
5372  0e47 5a            	decw	x
5373  0e48 1f0c          	ldw	(OFST+5,sp),x
5374                     ; 1409 	    SetPort(pSocket->ParseNum,
5374                     ; 1410 	            (uint8_t)alpha_1,
5374                     ; 1411 		    (uint8_t)alpha_2,
5374                     ; 1412 		    (uint8_t)alpha_3,
5374                     ; 1413 		    (uint8_t)alpha_4,
5374                     ; 1414 		    (uint8_t)alpha_5);
5376  0e4a 88            	push	a
5377  0e4b 7b04          	ld	a,(OFST-3,sp)
5378  0e4d 88            	push	a
5379  0e4e 7b08          	ld	a,(OFST+1,sp)
5380  0e50 88            	push	a
5381  0e51 7b08          	ld	a,(OFST+1,sp)
5382  0e53 88            	push	a
5383  0e54 7b0b          	ld	a,(OFST+4,sp)
5384  0e56 1612          	ldw	y,(OFST+11,sp)
5385  0e58 97            	ld	xl,a
5386  0e59 90e608        	ld	a,(8,y)
5387  0e5c 95            	ld	xh,a
5388  0e5d cd1510        	call	_SetPort
5390  0e60 5b04          	addw	sp,#4
5392  0e62 2055          	jra	L7751
5393  0e64               L5261:
5394                     ; 1417           else if (pSocket->ParseCmd == 'd') {
5396  0e64 a164          	cp	a,#100
5397  0e66 262f          	jrne	L1361
5398                     ; 1423 	    alpha_1 = (uint8_t)(*pBuffer);
5400  0e68 1e08          	ldw	x,(OFST+1,sp)
5401  0e6a f6            	ld	a,(x)
5402  0e6b 6b07          	ld	(OFST+0,sp),a
5404                     ; 1424             pSocket->nParseLeft--;
5406  0e6d 1e0e          	ldw	x,(OFST+7,sp)
5407  0e6f 6a06          	dec	(6,x)
5408                     ; 1425             pBuffer++; // nBytes already decremented for first char
5410  0e71 1e08          	ldw	x,(OFST+1,sp)
5411  0e73 5c            	incw	x
5412  0e74 1f08          	ldw	(OFST+1,sp),x
5413                     ; 1427 	    alpha_2 = (uint8_t)(*pBuffer);
5415  0e76 f6            	ld	a,(x)
5416  0e77 6b05          	ld	(OFST-2,sp),a
5418                     ; 1428             pSocket->nParseLeft--;
5420  0e79 1e0e          	ldw	x,(OFST+7,sp)
5421  0e7b 6a06          	dec	(6,x)
5422                     ; 1429             pBuffer++;
5424  0e7d 1e08          	ldw	x,(OFST+1,sp)
5425  0e7f 5c            	incw	x
5426  0e80 1f08          	ldw	(OFST+1,sp),x
5427                     ; 1430 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5429  0e82 1e0c          	ldw	x,(OFST+5,sp)
5430  0e84 5a            	decw	x
5431  0e85 1f0c          	ldw	(OFST+5,sp),x
5432                     ; 1432 	    SetMAC(pSocket->ParseNum, alpha_1, alpha_2);
5434  0e87 88            	push	a
5435  0e88 7b08          	ld	a,(OFST+1,sp)
5436  0e8a 160f          	ldw	y,(OFST+8,sp)
5437  0e8c 97            	ld	xl,a
5438  0e8d 90e608        	ld	a,(8,y)
5439  0e90 95            	ld	xh,a
5440  0e91 cd154b        	call	_SetMAC
5442  0e94 84            	pop	a
5444  0e95 2022          	jra	L7751
5445  0e97               L1361:
5446                     ; 1435 	  else if (pSocket->ParseCmd == 'g') {
5448  0e97 a167          	cp	a,#103
5449  0e99 261e          	jrne	L7751
5450                     ; 1438             if ((uint8_t)(*pBuffer) == '1') invert_output = 1;
5452  0e9b 1e08          	ldw	x,(OFST+1,sp)
5453  0e9d f6            	ld	a,(x)
5454  0e9e a131          	cp	a,#49
5455  0ea0 2606          	jrne	L7361
5458  0ea2 35010000      	mov	_invert_output,#1
5460  0ea6 2004          	jra	L1461
5461  0ea8               L7361:
5462                     ; 1439             else invert_output = 0;
5464  0ea8 725f0000      	clr	_invert_output
5465  0eac               L1461:
5466                     ; 1440 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--;
5468  0eac 1e0e          	ldw	x,(OFST+7,sp)
5469  0eae e606          	ld	a,(6,x)
5470  0eb0 2702          	jreq	L5461
5473  0eb2               LC020:
5475  0eb2 6a06          	dec	(6,x)
5477  0eb4               L5461:
5478                     ; 1442             pBuffer++;
5481  0eb4 1e08          	ldw	x,(OFST+1,sp)
5482  0eb6 5c            	incw	x
5483  0eb7 1f08          	ldw	(OFST+1,sp),x
5484  0eb9               L7751:
5485                     ; 1445           pSocket->ParseState = PARSE_DELIM;
5487  0eb9 1e0e          	ldw	x,(OFST+7,sp)
5488  0ebb               LC014:
5490  0ebb a605          	ld	a,#5
5491  0ebd e709          	ld	(9,x),a
5493  0ebf 2015          	jra	L3351
5494  0ec1               L5651:
5495                     ; 1448         else if (pSocket->ParseState == PARSE_DELIM) {
5497  0ec1 a105          	cp	a,#5
5498  0ec3 2611          	jrne	L3351
5499                     ; 1449           if(pSocket->nParseLeft > 0) {
5501  0ec5 e606          	ld	a,(6,x)
5502  0ec7 270b          	jreq	L3561
5503                     ; 1450             pSocket->ParseState = PARSE_CMD;
5505  0ec9 6f09          	clr	(9,x)
5506                     ; 1451             pSocket->nParseLeft--;
5508  0ecb               LC021:
5512  0ecb 6a06          	dec	(6,x)
5513                     ; 1452             pBuffer++;
5515  0ecd               LC013:
5519  0ecd 1e08          	ldw	x,(OFST+1,sp)
5520  0ecf 5c            	incw	x
5521  0ed0 1f08          	ldw	(OFST+1,sp),x
5523  0ed2 2002          	jra	L3351
5524  0ed4               L3561:
5525                     ; 1455             pSocket->nParseLeft = 0; // Something out of sync - end the parsing
5527  0ed4 e706          	ld	(6,x),a
5528  0ed6               L3351:
5529                     ; 1459         if (pSocket->nParseLeft == 0) {
5531  0ed6 1e0e          	ldw	x,(OFST+7,sp)
5532  0ed8 e606          	ld	a,(6,x)
5533  0eda 2608          	jrne	L3051
5534                     ; 1461           pSocket->nState = STATE_SENDHEADER;
5536  0edc a60b          	ld	a,#11
5537  0ede f7            	ld	(x),a
5538                     ; 1462           break;
5539  0edf               L5051:
5540                     ; 1466       pSocket->nState = STATE_SENDHEADER;
5542  0edf 1e0e          	ldw	x,(OFST+7,sp)
5543  0ee1 f7            	ld	(x),a
5544  0ee2 200f          	jra	L7741
5545  0ee4               L3051:
5546                     ; 1249       while (nBytes--) {
5548  0ee4 1e0c          	ldw	x,(OFST+5,sp)
5549  0ee6 5a            	decw	x
5550  0ee7 1f0c          	ldw	(OFST+5,sp),x
5551  0ee9 5c            	incw	x
5552  0eea 2703cc0c8b    	jrne	L1051
5553  0eef a60b          	ld	a,#11
5554  0ef1 20ec          	jra	L5051
5555  0ef3               L7741:
5556                     ; 1469     if (pSocket->nState == STATE_PARSEGET) {
5558  0ef3 a10d          	cp	a,#13
5559  0ef5 2703cc11a6    	jrne	L1661
5561  0efa cc119b        	jra	L5661
5562  0efd               L3661:
5563                     ; 1483         if (pSocket->ParseState == PARSE_SLASH1) {
5565  0efd 1e0e          	ldw	x,(OFST+7,sp)
5566  0eff e609          	ld	a,(9,x)
5567  0f01 a106          	cp	a,#6
5568  0f03 263e          	jrne	L1761
5569                     ; 1486           pSocket->ParseCmd = *pBuffer;
5571  0f05 1e08          	ldw	x,(OFST+1,sp)
5572  0f07 f6            	ld	a,(x)
5573  0f08 1e0e          	ldw	x,(OFST+7,sp)
5574  0f0a e707          	ld	(7,x),a
5575                     ; 1487           pSocket->nParseLeft--;
5577  0f0c 6a06          	dec	(6,x)
5578                     ; 1488           pBuffer++;
5580  0f0e 1e08          	ldw	x,(OFST+1,sp)
5581  0f10 5c            	incw	x
5582  0f11 1f08          	ldw	(OFST+1,sp),x
5583                     ; 1489 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5585  0f13 1e0e          	ldw	x,(OFST+7,sp)
5586  0f15 e607          	ld	a,(7,x)
5587  0f17 a12f          	cp	a,#47
5588  0f19 2604          	jrne	L3761
5589                     ; 1490 	    pSocket->ParseState = PARSE_NUM10;
5591  0f1b a601          	ld	a,#1
5592  0f1d e709          	ld	(9,x),a
5593  0f1f               L3761:
5594                     ; 1492 	  if (pSocket->nParseLeft == 0) {
5596  0f1f e606          	ld	a,(6,x)
5597  0f21 2703cc1179    	jrne	L7761
5598                     ; 1494 	    current_webpage = WEBPAGE_DEFAULT;
5600  0f26 c7000b        	ld	_current_webpage,a
5601                     ; 1495             pSocket->pData = g_HtmlPageDefault;
5603  0f29 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5604  0f2d ef01          	ldw	(1,x),y
5605                     ; 1496             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5607  0f2f 90ae15d5      	ldw	y,#5589
5608  0f33 ef03          	ldw	(3,x),y
5609                     ; 1497             pSocket->nNewlines = 0;
5611  0f35 e705          	ld	(5,x),a
5612                     ; 1498             pSocket->nState = STATE_SENDHEADER;
5614  0f37 a60b          	ld	a,#11
5615  0f39 f7            	ld	(x),a
5616                     ; 1499             pSocket->nPrevBytes = 0xFFFF;
5618  0f3a 90aeffff      	ldw	y,#65535
5619  0f3e ef0a          	ldw	(10,x),y
5620                     ; 1500             break;
5622  0f40 cc11a6        	jra	L1661
5623  0f43               L1761:
5624                     ; 1503         else if (pSocket->ParseState == PARSE_NUM10) {
5626  0f43 a101          	cp	a,#1
5627  0f45 264e          	jrne	L1071
5628                     ; 1508 	  if(*pBuffer == ' ') {
5630  0f47 1e08          	ldw	x,(OFST+1,sp)
5631  0f49 f6            	ld	a,(x)
5632  0f4a a120          	cp	a,#32
5633  0f4c 2620          	jrne	L3071
5634                     ; 1509 	    current_webpage = WEBPAGE_DEFAULT;
5636  0f4e 725f000b      	clr	_current_webpage
5637                     ; 1510             pSocket->pData = g_HtmlPageDefault;
5639  0f52 1e0e          	ldw	x,(OFST+7,sp)
5640  0f54 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5641  0f58 ef01          	ldw	(1,x),y
5642                     ; 1511             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5644  0f5a 90ae15d5      	ldw	y,#5589
5645  0f5e ef03          	ldw	(3,x),y
5646                     ; 1512             pSocket->nNewlines = 0;
5648  0f60 6f05          	clr	(5,x)
5649                     ; 1513             pSocket->nState = STATE_SENDHEADER;
5651  0f62 a60b          	ld	a,#11
5652  0f64 f7            	ld	(x),a
5653                     ; 1514             pSocket->nPrevBytes = 0xFFFF;
5655  0f65 90aeffff      	ldw	y,#65535
5656  0f69 ef0a          	ldw	(10,x),y
5657                     ; 1515 	    break;
5659  0f6b cc11a6        	jra	L1661
5660  0f6e               L3071:
5661                     ; 1518 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5663  0f6e a130          	cp	a,#48
5664  0f70 2504          	jrult	L5071
5666  0f72 a13a          	cp	a,#58
5667  0f74 2506          	jrult	L7071
5669  0f76               L5071:
5670                     ; 1519 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5672  0f76 1e0e          	ldw	x,(OFST+7,sp)
5673  0f78 a605          	ld	a,#5
5674  0f7a e709          	ld	(9,x),a
5675  0f7c               L7071:
5676                     ; 1520           if (pSocket->ParseState == PARSE_NUM10) {      // Still good - parse number
5678  0f7c 1e0e          	ldw	x,(OFST+7,sp)
5679  0f7e e609          	ld	a,(9,x)
5680  0f80 4a            	dec	a
5681  0f81 26a0          	jrne	L7761
5682                     ; 1521             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5684  0f83 1e08          	ldw	x,(OFST+1,sp)
5685  0f85 f6            	ld	a,(x)
5686  0f86 97            	ld	xl,a
5687  0f87 a60a          	ld	a,#10
5688  0f89 42            	mul	x,a
5689  0f8a 9f            	ld	a,xl
5690  0f8b 1e0e          	ldw	x,(OFST+7,sp)
5691  0f8d a0e0          	sub	a,#224
5692  0f8f e708          	ld	(8,x),a
5693                     ; 1522 	    pSocket->ParseState = PARSE_NUM1;
5695  0f91 a602          	ld	a,#2
5696                     ; 1523             pSocket->nParseLeft--;
5697                     ; 1524             pBuffer++;
5698  0f93 202c          	jp	LC018
5699  0f95               L1071:
5700                     ; 1528         else if (pSocket->ParseState == PARSE_NUM1) {
5702  0f95 a102          	cp	a,#2
5703  0f97 2634          	jrne	L5171
5704                     ; 1529 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5706  0f99 1e08          	ldw	x,(OFST+1,sp)
5707  0f9b f6            	ld	a,(x)
5708  0f9c a130          	cp	a,#48
5709  0f9e 2504          	jrult	L7171
5711  0fa0 a13a          	cp	a,#58
5712  0fa2 2506          	jrult	L1271
5714  0fa4               L7171:
5715                     ; 1530 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5717  0fa4 1e0e          	ldw	x,(OFST+7,sp)
5718  0fa6 a605          	ld	a,#5
5719  0fa8 e709          	ld	(9,x),a
5720  0faa               L1271:
5721                     ; 1531           if (pSocket->ParseState == PARSE_NUM1) {       // Still good - parse number
5723  0faa 1e0e          	ldw	x,(OFST+7,sp)
5724  0fac e609          	ld	a,(9,x)
5725  0fae a102          	cp	a,#2
5726  0fb0 2703cc1179    	jrne	L7761
5727                     ; 1532             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5729  0fb5 1608          	ldw	y,(OFST+1,sp)
5730  0fb7 90f6          	ld	a,(y)
5731  0fb9 a030          	sub	a,#48
5732  0fbb eb08          	add	a,(8,x)
5733  0fbd e708          	ld	(8,x),a
5734                     ; 1533             pSocket->ParseState = PARSE_VAL;
5736  0fbf a604          	ld	a,#4
5737                     ; 1534             pSocket->nParseLeft--;
5739                     ; 1535             pBuffer++;
5741  0fc1               LC018:
5742  0fc1 e709          	ld	(9,x),a
5744  0fc3 6a06          	dec	(6,x)
5746  0fc5 1e08          	ldw	x,(OFST+1,sp)
5747  0fc7 5c            	incw	x
5748  0fc8 1f08          	ldw	(OFST+1,sp),x
5749  0fca cc1179        	jra	L7761
5750  0fcd               L5171:
5751                     ; 1538         else if (pSocket->ParseState == PARSE_VAL) {
5753  0fcd a104          	cp	a,#4
5754  0fcf 2703cc1181    	jrne	L7271
5755                     ; 1589           switch(pSocket->ParseNum)
5757  0fd4 e608          	ld	a,(8,x)
5759                     ; 1713 	      break;
5760  0fd6 a143          	cp	a,#67
5761  0fd8 2407          	jruge	L272
5762  0fda 5f            	clrw	x
5763  0fdb 97            	ld	xl,a
5764  0fdc 58            	sllw	x
5765  0fdd de3d9d        	ldw	x,(L472,x)
5766  0fe0 fc            	jp	(x)
5767  0fe1               L272:
5768  0fe1 a05b          	sub	a,#91
5769  0fe3 2603cc113d    	jreq	L7121
5770  0fe8 a008          	sub	a,#8
5771  0fea 2603cc1143    	jreq	L1221
5772  0fef cc1158        	jra	L3221
5773  0ff2               L7701:
5774                     ; 1591 	    case 0:  Relays_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
5776  0ff2 72110000      	bres	_Relays_8to1,#0
5779  0ff6 cc1173        	jra	L3371
5780  0ff9               L1011:
5781                     ; 1592 	    case 1:  Relays_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
5783  0ff9 72100000      	bset	_Relays_8to1,#0
5786  0ffd cc1173        	jra	L3371
5787  1000               L3011:
5788                     ; 1593 	    case 2:  Relays_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
5790  1000 72130000      	bres	_Relays_8to1,#1
5793  1004 cc1173        	jra	L3371
5794  1007               L5011:
5795                     ; 1594 	    case 3:  Relays_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
5797  1007 72120000      	bset	_Relays_8to1,#1
5800  100b cc1173        	jra	L3371
5801  100e               L7011:
5802                     ; 1595 	    case 4:  Relays_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
5804  100e 72150000      	bres	_Relays_8to1,#2
5807  1012 cc1173        	jra	L3371
5808  1015               L1111:
5809                     ; 1596 	    case 5:  Relays_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
5811  1015 72140000      	bset	_Relays_8to1,#2
5814  1019 cc1173        	jra	L3371
5815  101c               L3111:
5816                     ; 1597 	    case 6:  Relays_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
5818  101c 72170000      	bres	_Relays_8to1,#3
5821  1020 cc1173        	jra	L3371
5822  1023               L5111:
5823                     ; 1598 	    case 7:  Relays_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
5825  1023 72160000      	bset	_Relays_8to1,#3
5828  1027 cc1173        	jra	L3371
5829  102a               L7111:
5830                     ; 1599 	    case 8:  Relays_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
5832  102a 72190000      	bres	_Relays_8to1,#4
5835  102e cc1173        	jra	L3371
5836  1031               L1211:
5837                     ; 1600 	    case 9:  Relays_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
5839  1031 72180000      	bset	_Relays_8to1,#4
5842  1035 cc1173        	jra	L3371
5843  1038               L3211:
5844                     ; 1601 	    case 10: Relays_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
5846  1038 721b0000      	bres	_Relays_8to1,#5
5849  103c cc1173        	jra	L3371
5850  103f               L5211:
5851                     ; 1602 	    case 11: Relays_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
5853  103f 721a0000      	bset	_Relays_8to1,#5
5856  1043 cc1173        	jra	L3371
5857  1046               L7211:
5858                     ; 1603 	    case 12: Relays_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
5860  1046 721d0000      	bres	_Relays_8to1,#6
5863  104a cc1173        	jra	L3371
5864  104d               L1311:
5865                     ; 1604 	    case 13: Relays_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
5867  104d 721c0000      	bset	_Relays_8to1,#6
5870  1051 cc1173        	jra	L3371
5871  1054               L3311:
5872                     ; 1605 	    case 14: Relays_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
5874  1054 721f0000      	bres	_Relays_8to1,#7
5877  1058 cc1173        	jra	L3371
5878  105b               L5311:
5879                     ; 1606 	    case 15: Relays_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
5881  105b 721e0000      	bset	_Relays_8to1,#7
5884  105f cc1173        	jra	L3371
5885  1062               L7311:
5886                     ; 1607 	    case 16: Relays_16to9 &= (uint8_t)(~0x01); break; // Relay-09 OFF
5888  1062 72110000      	bres	_Relays_16to9,#0
5891  1066 cc1173        	jra	L3371
5892  1069               L1411:
5893                     ; 1608 	    case 17: Relays_16to9 |= (uint8_t)0x01;    break; // Relay-09 ON
5895  1069 72100000      	bset	_Relays_16to9,#0
5898  106d cc1173        	jra	L3371
5899  1070               L3411:
5900                     ; 1609 	    case 18: Relays_16to9 &= (uint8_t)(~0x02); break; // Relay-10 OFF
5902  1070 72130000      	bres	_Relays_16to9,#1
5905  1074 cc1173        	jra	L3371
5906  1077               L5411:
5907                     ; 1610 	    case 19: Relays_16to9 |= (uint8_t)0x02;    break; // Relay-10 ON
5909  1077 72120000      	bset	_Relays_16to9,#1
5912  107b cc1173        	jra	L3371
5913  107e               L7411:
5914                     ; 1611 	    case 20: Relays_16to9 &= (uint8_t)(~0x04); break; // Relay-11 OFF
5916  107e 72150000      	bres	_Relays_16to9,#2
5919  1082 cc1173        	jra	L3371
5920  1085               L1511:
5921                     ; 1612 	    case 21: Relays_16to9 |= (uint8_t)0x04;    break; // Relay-11 ON
5923  1085 72140000      	bset	_Relays_16to9,#2
5926  1089 cc1173        	jra	L3371
5927  108c               L3511:
5928                     ; 1613 	    case 22: Relays_16to9 &= (uint8_t)(~0x08); break; // Relay-12 OFF
5930  108c 72170000      	bres	_Relays_16to9,#3
5933  1090 cc1173        	jra	L3371
5934  1093               L5511:
5935                     ; 1614 	    case 23: Relays_16to9 |= (uint8_t)0x08;    break; // Relay-12 ON
5937  1093 72160000      	bset	_Relays_16to9,#3
5940  1097 cc1173        	jra	L3371
5941  109a               L7511:
5942                     ; 1615 	    case 24: Relays_16to9 &= (uint8_t)(~0x10); break; // Relay-13 OFF
5944  109a 72190000      	bres	_Relays_16to9,#4
5947  109e cc1173        	jra	L3371
5948  10a1               L1611:
5949                     ; 1616 	    case 25: Relays_16to9 |= (uint8_t)0x10;    break; // Relay-13 ON
5951  10a1 72180000      	bset	_Relays_16to9,#4
5954  10a5 cc1173        	jra	L3371
5955  10a8               L3611:
5956                     ; 1617 	    case 26: Relays_16to9 &= (uint8_t)(~0x20); break; // Relay-14 OFF
5958  10a8 721b0000      	bres	_Relays_16to9,#5
5961  10ac cc1173        	jra	L3371
5962  10af               L5611:
5963                     ; 1618 	    case 27: Relays_16to9 |= (uint8_t)0x20;    break; // Relay-14 ON
5965  10af 721a0000      	bset	_Relays_16to9,#5
5968  10b3 cc1173        	jra	L3371
5969  10b6               L7611:
5970                     ; 1619 	    case 28: Relays_16to9 &= (uint8_t)(~0x40); break; // Relay-15 OFF
5972  10b6 721d0000      	bres	_Relays_16to9,#6
5975  10ba cc1173        	jra	L3371
5976  10bd               L1711:
5977                     ; 1620 	    case 29: Relays_16to9 |= (uint8_t)0x40;    break; // Relay-15 ON
5979  10bd 721c0000      	bset	_Relays_16to9,#6
5982  10c1 cc1173        	jra	L3371
5983  10c4               L3711:
5984                     ; 1621 	    case 30: Relays_16to9 &= (uint8_t)(~0x80); break; // Relay-16 OFF
5986  10c4 721f0000      	bres	_Relays_16to9,#7
5989  10c8 cc1173        	jra	L3371
5990  10cb               L5711:
5991                     ; 1622 	    case 31: Relays_16to9 |= (uint8_t)0x80;    break; // Relay-16 ON
5993  10cb 721e0000      	bset	_Relays_16to9,#7
5996  10cf cc1173        	jra	L3371
5997  10d2               L7711:
5998                     ; 1623 	    case 55:
5998                     ; 1624   	      Relays_8to1 = (uint8_t)0xff; // Relays 1-8 ON
6000  10d2 35ff0000      	mov	_Relays_8to1,#255
6001                     ; 1625   	      Relays_16to9 = (uint8_t)0xff; // Relays 9-16 ON
6003  10d6 35ff0000      	mov	_Relays_16to9,#255
6004                     ; 1626 	      break;
6006  10da cc1173        	jra	L3371
6007  10dd               L1021:
6008                     ; 1627 	    case 56:
6008                     ; 1628               Relays_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
6010  10dd 725f0000      	clr	_Relays_8to1
6011                     ; 1629               Relays_16to9 = (uint8_t)0x00; // Relays 9-16 OFF
6013  10e1 725f0000      	clr	_Relays_16to9
6014                     ; 1630 	      break;
6016  10e5 cc1173        	jra	L3371
6017  10e8               L3021:
6018                     ; 1632 	    case 60: // Show relay states page
6018                     ; 1633 	      current_webpage = WEBPAGE_DEFAULT;
6019                     ; 1634               pSocket->pData = g_HtmlPageDefault;
6020                     ; 1635               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6021                     ; 1636               pSocket->nNewlines = 0;
6022                     ; 1637               pSocket->nState = STATE_CONNECTED;
6023                     ; 1638               pSocket->nPrevBytes = 0xFFFF;
6024                     ; 1639 	      break;
6026  10e8 206e          	jp	L3221
6027  10ea               L5021:
6028                     ; 1641 	    case 61: // Show address settings page
6028                     ; 1642 	      current_webpage = WEBPAGE_ADDRESS;
6030  10ea 3501000b      	mov	_current_webpage,#1
6031                     ; 1643               pSocket->pData = g_HtmlPageAddress;
6033  10ee 1e0e          	ldw	x,(OFST+7,sp)
6034  10f0 90ae15de      	ldw	y,#L71_g_HtmlPageAddress
6035  10f4 ef01          	ldw	(1,x),y
6036                     ; 1644               pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
6038  10f6 90ae1341      	ldw	y,#4929
6039                     ; 1645               pSocket->nNewlines = 0;
6040                     ; 1646               pSocket->nState = STATE_CONNECTED;
6041                     ; 1647               pSocket->nPrevBytes = 0xFFFF;
6042                     ; 1648 	      break;
6044  10fa 206c          	jp	LC016
6045  10fc               L7021:
6046                     ; 1651 	    case 63: // Show help page 1
6046                     ; 1652 	      current_webpage = WEBPAGE_HELP;
6048  10fc 3503000b      	mov	_current_webpage,#3
6049                     ; 1653               pSocket->pData = g_HtmlPageHelp;
6051  1100 1e0e          	ldw	x,(OFST+7,sp)
6052  1102 90ae2920      	ldw	y,#L12_g_HtmlPageHelp
6053  1106 ef01          	ldw	(1,x),y
6054                     ; 1654               pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
6056  1108 90ae075c      	ldw	y,#1884
6057                     ; 1655               pSocket->nNewlines = 0;
6058                     ; 1656               pSocket->nState = STATE_CONNECTED;
6059                     ; 1657               pSocket->nPrevBytes = 0xFFFF;
6060                     ; 1658 	      break;
6062  110c 205a          	jp	LC016
6063  110e               L1121:
6064                     ; 1660 	    case 64: // Show help page 2
6064                     ; 1661 	      current_webpage = WEBPAGE_HELP2;
6066  110e 3504000b      	mov	_current_webpage,#4
6067                     ; 1662               pSocket->pData = g_HtmlPageHelp2;
6069  1112 1e0e          	ldw	x,(OFST+7,sp)
6070  1114 90ae307d      	ldw	y,#L32_g_HtmlPageHelp2
6071  1118 ef01          	ldw	(1,x),y
6072                     ; 1663               pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
6074  111a 90ae02bb      	ldw	y,#699
6075                     ; 1664               pSocket->nNewlines = 0;
6076                     ; 1665               pSocket->nState = STATE_CONNECTED;
6077                     ; 1666               pSocket->nPrevBytes = 0xFFFF;
6078                     ; 1667 	      break;
6080  111e 2048          	jp	LC016
6081  1120               L3121:
6082                     ; 1670 	    case 65: // Flash LED for diagnostics
6082                     ; 1671 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6082                     ; 1672 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6082                     ; 1673 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6082                     ; 1674 	      debugflash();
6084  1120 cd0000        	call	_debugflash
6086                     ; 1675 	      debugflash();
6088  1123 cd0000        	call	_debugflash
6090                     ; 1676 	      debugflash();
6092  1126 cd0000        	call	_debugflash
6094                     ; 1680 	      break;
6096  1129 2048          	jra	L3371
6097  112b               L5121:
6098                     ; 1683             case 66: // Show statistics page
6098                     ; 1684 	      current_webpage = WEBPAGE_STATS;
6100  112b 3505000b      	mov	_current_webpage,#5
6101                     ; 1685               pSocket->pData = g_HtmlPageStats;
6103  112f 1e0e          	ldw	x,(OFST+7,sp)
6104  1131 90ae3339      	ldw	y,#L52_g_HtmlPageStats
6105  1135 ef01          	ldw	(1,x),y
6106                     ; 1686               pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
6108  1137 90ae097e      	ldw	y,#2430
6109                     ; 1687               pSocket->nNewlines = 0;
6110                     ; 1688               pSocket->nState = STATE_CONNECTED;
6111                     ; 1689               pSocket->nPrevBytes = 0xFFFF;
6112                     ; 1690 	      break;
6114  113b 202b          	jp	LC016
6115  113d               L7121:
6116                     ; 1693 	    case 91: // Reboot
6116                     ; 1694 	      submit_changes = 2;
6118  113d 35020000      	mov	_submit_changes,#2
6119                     ; 1695 	      break;
6121  1141 2030          	jra	L3371
6122  1143               L1221:
6123                     ; 1697             case 99: // Show simplified relay state page
6123                     ; 1698 	      current_webpage = WEBPAGE_RSTATE;
6125  1143 3506000b      	mov	_current_webpage,#6
6126                     ; 1699               pSocket->pData = g_HtmlPageRstate;
6128  1147 90ae3cb8      	ldw	y,#L72_g_HtmlPageRstate
6129  114b ef01          	ldw	(1,x),y
6130                     ; 1700               pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
6132  114d 90ae00a0      	ldw	y,#160
6133  1151 ef03          	ldw	(3,x),y
6134                     ; 1701               pSocket->nNewlines = 0;
6136  1153 e705          	ld	(5,x),a
6137                     ; 1702               pSocket->nState = STATE_CONNECTED;
6139  1155 f7            	ld	(x),a
6140                     ; 1703               pSocket->nPrevBytes = 0xFFFF;
6141                     ; 1704 	      break;
6143  1156 2015          	jp	LC015
6144  1158               L3221:
6145                     ; 1706 	    default: // Show relay state page
6145                     ; 1707 	      current_webpage = WEBPAGE_DEFAULT;
6147                     ; 1708               pSocket->pData = g_HtmlPageDefault;
6149                     ; 1709               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6152  1158 725f000b      	clr	_current_webpage
6154  115c 1e0e          	ldw	x,(OFST+7,sp)
6155  115e 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
6156  1162 ef01          	ldw	(1,x),y
6158  1164 90ae15d5      	ldw	y,#5589
6159                     ; 1710               pSocket->nNewlines = 0;
6161                     ; 1711               pSocket->nState = STATE_CONNECTED;
6163  1168               LC016:
6164  1168 ef03          	ldw	(3,x),y
6170  116a 6f05          	clr	(5,x)
6176  116c 7f            	clr	(x)
6177                     ; 1712               pSocket->nPrevBytes = 0xFFFF;
6179  116d               LC015:
6186  116d 90aeffff      	ldw	y,#65535
6187  1171 ef0a          	ldw	(10,x),y
6188                     ; 1713 	      break;
6190  1173               L3371:
6191                     ; 1715           pSocket->ParseState = PARSE_DELIM;
6193  1173 1e0e          	ldw	x,(OFST+7,sp)
6194  1175 a605          	ld	a,#5
6195  1177 e709          	ld	(9,x),a
6197  1179               L7761:
6198                     ; 1729         if (pSocket->nParseLeft == 0) {
6200  1179 1e0e          	ldw	x,(OFST+7,sp)
6201  117b e606          	ld	a,(6,x)
6202  117d 261c          	jrne	L5661
6203                     ; 1731           pSocket->nState = STATE_SENDHEADER;
6204                     ; 1732           break;
6206  117f 2015          	jp	LC019
6207  1181               L7271:
6208                     ; 1718         else if (pSocket->ParseState == PARSE_DELIM) {
6210  1181 a105          	cp	a,#5
6211  1183 26f4          	jrne	L7761
6212                     ; 1720           pSocket->ParseState = PARSE_DELIM;
6214  1185 a605          	ld	a,#5
6215  1187 e709          	ld	(9,x),a
6216                     ; 1721           pSocket->nParseLeft--;
6218  1189 6a06          	dec	(6,x)
6219                     ; 1722           pBuffer++;
6221  118b 1e08          	ldw	x,(OFST+1,sp)
6222  118d 5c            	incw	x
6223  118e 1f08          	ldw	(OFST+1,sp),x
6224                     ; 1723 	  if (pSocket->nParseLeft == 0) {
6226  1190 1e0e          	ldw	x,(OFST+7,sp)
6227  1192 e606          	ld	a,(6,x)
6228  1194 26e3          	jrne	L7761
6229                     ; 1725             pSocket->nState = STATE_SENDHEADER;
6231  1196               LC019:
6233  1196 a60b          	ld	a,#11
6234  1198 f7            	ld	(x),a
6235                     ; 1726             break;
6237  1199 200b          	jra	L1661
6238  119b               L5661:
6239                     ; 1482       while (nBytes--) {
6241  119b 1e0c          	ldw	x,(OFST+5,sp)
6242  119d 5a            	decw	x
6243  119e 1f0c          	ldw	(OFST+5,sp),x
6244  11a0 5c            	incw	x
6245  11a1 2703cc0efd    	jrne	L3661
6246  11a6               L1661:
6247                     ; 1737     if (pSocket->nState == STATE_SENDHEADER) {
6249  11a6 1e0e          	ldw	x,(OFST+7,sp)
6250  11a8 f6            	ld	a,(x)
6251  11a9 a10b          	cp	a,#11
6252  11ab 2623          	jrne	L5471
6253                     ; 1738       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6255  11ad ee03          	ldw	x,(3,x)
6256  11af cd0000        	call	c_uitolx
6258  11b2 be02          	ldw	x,c_lreg+2
6259  11b4 89            	pushw	x
6260  11b5 be00          	ldw	x,c_lreg
6261  11b7 89            	pushw	x
6262  11b8 ce0000        	ldw	x,_uip_appdata
6263  11bb cd0231        	call	L7_CopyHttpHeader
6265  11be 5b04          	addw	sp,#4
6266  11c0 89            	pushw	x
6267  11c1 ce0000        	ldw	x,_uip_appdata
6268  11c4 cd0000        	call	_uip_send
6270  11c7 85            	popw	x
6271                     ; 1739       pSocket->nState = STATE_SENDDATA;
6273  11c8 1e0e          	ldw	x,(OFST+7,sp)
6274  11ca a60c          	ld	a,#12
6275  11cc f7            	ld	(x),a
6276                     ; 1740       return;
6278  11cd cc0b3c        	jra	L613
6279  11d0               L5471:
6280                     ; 1743     if (pSocket->nState == STATE_SENDDATA) {
6282  11d0 a10c          	cp	a,#12
6283  11d2 26f9          	jrne	L613
6284                     ; 1747       pSocket->nPrevBytes = pSocket->nDataLeft;
6286  11d4 9093          	ldw	y,x
6287  11d6 90ee03        	ldw	y,(3,y)
6288  11d9 ef0a          	ldw	(10,x),y
6289                     ; 1748       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6291  11db ce0000        	ldw	x,_uip_conn
6292  11de ee12          	ldw	x,(18,x)
6293  11e0 89            	pushw	x
6294  11e1 1e10          	ldw	x,(OFST+9,sp)
6295  11e3 1c0003        	addw	x,#3
6296  11e6 89            	pushw	x
6297  11e7 1e12          	ldw	x,(OFST+11,sp)
6298  11e9 5c            	incw	x
6299  11ea 89            	pushw	x
6300  11eb ce0000        	ldw	x,_uip_appdata
6301  11ee cd02c9        	call	L11_CopyHttpData
6303  11f1 5b06          	addw	sp,#6
6304  11f3 1f01          	ldw	(OFST-6,sp),x
6306                     ; 1749       pSocket->nPrevBytes -= pSocket->nDataLeft;
6308  11f5 1e0e          	ldw	x,(OFST+7,sp)
6309  11f7 e60b          	ld	a,(11,x)
6310  11f9 e004          	sub	a,(4,x)
6311  11fb e70b          	ld	(11,x),a
6312  11fd e60a          	ld	a,(10,x)
6313  11ff e203          	sbc	a,(3,x)
6314  1201 e70a          	ld	(10,x),a
6315                     ; 1751       if (nBufSize == 0) {
6317  1203 1e01          	ldw	x,(OFST-6,sp)
6318  1205 262d          	jrne	LC010
6319                     ; 1753         uip_close();
6321  1207               LC011:
6323  1207 35100000      	mov	_uip_flags,#16
6325  120b cc0b3c        	jra	L613
6326                     ; 1757         uip_send(uip_appdata, nBufSize);
6328                     ; 1759       return;
6330  120e               L5531:
6331                     ; 1763   else if (uip_rexmit()) {
6333  120e 7204000003cc  	btjf	_uip_flags,#2,L3531
6334                     ; 1764     if (pSocket->nPrevBytes == 0xFFFF) {
6336  1216 160e          	ldw	y,(OFST+7,sp)
6337  1218 90ee0a        	ldw	y,(10,y)
6338  121b 905c          	incw	y
6339  121d 2620          	jrne	L1671
6340                     ; 1766       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6342  121f 1e0e          	ldw	x,(OFST+7,sp)
6343  1221 ee03          	ldw	x,(3,x)
6344  1223 cd0000        	call	c_uitolx
6346  1226 be02          	ldw	x,c_lreg+2
6347  1228 89            	pushw	x
6348  1229 be00          	ldw	x,c_lreg
6349  122b 89            	pushw	x
6350  122c ce0000        	ldw	x,_uip_appdata
6351  122f cd0231        	call	L7_CopyHttpHeader
6353  1232 5b04          	addw	sp,#4
6355  1234               LC010:
6357  1234 89            	pushw	x
6358  1235 ce0000        	ldw	x,_uip_appdata
6359  1238 cd0000        	call	_uip_send
6360  123b 85            	popw	x
6362  123c cc0b3c        	jra	L613
6363  123f               L1671:
6364                     ; 1769       pSocket->pData -= pSocket->nPrevBytes;
6366  123f 1e0e          	ldw	x,(OFST+7,sp)
6367  1241 e602          	ld	a,(2,x)
6368  1243 e00b          	sub	a,(11,x)
6369  1245 e702          	ld	(2,x),a
6370  1247 e601          	ld	a,(1,x)
6371  1249 e20a          	sbc	a,(10,x)
6372  124b e701          	ld	(1,x),a
6373                     ; 1770       pSocket->nDataLeft += pSocket->nPrevBytes;
6375  124d e604          	ld	a,(4,x)
6376  124f eb0b          	add	a,(11,x)
6377  1251 e704          	ld	(4,x),a
6378  1253 e603          	ld	a,(3,x)
6379  1255 e90a          	adc	a,(10,x)
6380                     ; 1771       pSocket->nPrevBytes = pSocket->nDataLeft;
6382  1257 9093          	ldw	y,x
6383  1259 e703          	ld	(3,x),a
6384  125b 90ee03        	ldw	y,(3,y)
6385  125e ef0a          	ldw	(10,x),y
6386                     ; 1772       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6388  1260 ce0000        	ldw	x,_uip_conn
6389  1263 ee12          	ldw	x,(18,x)
6390  1265 89            	pushw	x
6391  1266 1e10          	ldw	x,(OFST+9,sp)
6392  1268 1c0003        	addw	x,#3
6393  126b 89            	pushw	x
6394  126c 1e12          	ldw	x,(OFST+11,sp)
6395  126e 5c            	incw	x
6396  126f 89            	pushw	x
6397  1270 ce0000        	ldw	x,_uip_appdata
6398  1273 cd02c9        	call	L11_CopyHttpData
6400  1276 5b06          	addw	sp,#6
6401  1278 1f01          	ldw	(OFST-6,sp),x
6403                     ; 1773       pSocket->nPrevBytes -= pSocket->nDataLeft;
6405  127a 1e0e          	ldw	x,(OFST+7,sp)
6406  127c e60b          	ld	a,(11,x)
6407  127e e004          	sub	a,(4,x)
6408  1280 e70b          	ld	(11,x),a
6409  1282 e60a          	ld	a,(10,x)
6410  1284 e203          	sbc	a,(3,x)
6411  1286 e70a          	ld	(10,x),a
6412                     ; 1774       if (nBufSize == 0) {
6414  1288 1e01          	ldw	x,(OFST-6,sp)
6415                     ; 1776         uip_close();
6417  128a 2603cc1207    	jreq	LC011
6418                     ; 1780         uip_send(uip_appdata, nBufSize);
6420  128f 89            	pushw	x
6421  1290 ce0000        	ldw	x,_uip_appdata
6422  1293 cd0000        	call	_uip_send
6424  1296 85            	popw	x
6425                     ; 1783     return;
6427  1297               L3531:
6428                     ; 1785 }
6430  1297 cc0b3c        	jra	L613
6464                     ; 1788 uint8_t GpioGetPin(uint8_t nGpio)
6464                     ; 1789 {
6465                     	switch	.text
6466  129a               _GpioGetPin:
6468       00000000      OFST:	set	0
6471                     ; 1791   if(nGpio == 0       && (Relays_8to1  & (uint8_t)(0x01))) return 1; // Relay-01 is ON
6473  129a 4d            	tnz	a
6474  129b 2607          	jrne	L5002
6476  129d 7201000002    	btjf	_Relays_8to1,#0,L5002
6479  12a2 4c            	inc	a
6482  12a3 81            	ret	
6483  12a4               L5002:
6484                     ; 1792   else if(nGpio == 1  && (Relays_8to1  & (uint8_t)(0x02))) return 1; // Relay-02 is ON
6486  12a4 a101          	cp	a,#1
6487  12a6 2608          	jrne	L1102
6489  12a8 7203000003    	btjf	_Relays_8to1,#1,L1102
6492  12ad a601          	ld	a,#1
6495  12af 81            	ret	
6496  12b0               L1102:
6497                     ; 1793   else if(nGpio == 2  && (Relays_8to1  & (uint8_t)(0x04))) return 1; // Relay-03 is ON
6499  12b0 a102          	cp	a,#2
6500  12b2 2608          	jrne	L5102
6502  12b4 7205000003    	btjf	_Relays_8to1,#2,L5102
6505  12b9 a601          	ld	a,#1
6508  12bb 81            	ret	
6509  12bc               L5102:
6510                     ; 1794   else if(nGpio == 3  && (Relays_8to1  & (uint8_t)(0x08))) return 1; // Relay-04 is ON
6512  12bc a103          	cp	a,#3
6513  12be 2608          	jrne	L1202
6515  12c0 7207000003    	btjf	_Relays_8to1,#3,L1202
6518  12c5 a601          	ld	a,#1
6521  12c7 81            	ret	
6522  12c8               L1202:
6523                     ; 1795   else if(nGpio == 4  && (Relays_8to1  & (uint8_t)(0x10))) return 1; // Relay-05 is ON
6525  12c8 a104          	cp	a,#4
6526  12ca 2608          	jrne	L5202
6528  12cc 7209000003    	btjf	_Relays_8to1,#4,L5202
6531  12d1 a601          	ld	a,#1
6534  12d3 81            	ret	
6535  12d4               L5202:
6536                     ; 1796   else if(nGpio == 5  && (Relays_8to1  & (uint8_t)(0x20))) return 1; // Relay-06 is ON
6538  12d4 a105          	cp	a,#5
6539  12d6 2608          	jrne	L1302
6541  12d8 720b000003    	btjf	_Relays_8to1,#5,L1302
6544  12dd a601          	ld	a,#1
6547  12df 81            	ret	
6548  12e0               L1302:
6549                     ; 1797   else if(nGpio == 6  && (Relays_8to1  & (uint8_t)(0x40))) return 1; // Relay-07 is ON
6551  12e0 a106          	cp	a,#6
6552  12e2 2608          	jrne	L5302
6554  12e4 720d000003    	btjf	_Relays_8to1,#6,L5302
6557  12e9 a601          	ld	a,#1
6560  12eb 81            	ret	
6561  12ec               L5302:
6562                     ; 1798   else if(nGpio == 7  && (Relays_8to1  & (uint8_t)(0x80))) return 1; // Relay-08 is ON
6564  12ec a107          	cp	a,#7
6565  12ee 2608          	jrne	L1402
6567  12f0 720f000003    	btjf	_Relays_8to1,#7,L1402
6570  12f5 a601          	ld	a,#1
6573  12f7 81            	ret	
6574  12f8               L1402:
6575                     ; 1799   else if(nGpio == 8  && (Relays_16to9 & (uint8_t)(0x01))) return 1; // Relay-09 is ON
6577  12f8 a108          	cp	a,#8
6578  12fa 2608          	jrne	L5402
6580  12fc 7201000003    	btjf	_Relays_16to9,#0,L5402
6583  1301 a601          	ld	a,#1
6586  1303 81            	ret	
6587  1304               L5402:
6588                     ; 1800   else if(nGpio == 9  && (Relays_16to9 & (uint8_t)(0x02))) return 1; // Relay-10 is ON
6590  1304 a109          	cp	a,#9
6591  1306 2608          	jrne	L1502
6593  1308 7203000003    	btjf	_Relays_16to9,#1,L1502
6596  130d a601          	ld	a,#1
6599  130f 81            	ret	
6600  1310               L1502:
6601                     ; 1801   else if(nGpio == 10 && (Relays_16to9 & (uint8_t)(0x04))) return 1; // Relay-11 is ON
6603  1310 a10a          	cp	a,#10
6604  1312 2608          	jrne	L5502
6606  1314 7205000003    	btjf	_Relays_16to9,#2,L5502
6609  1319 a601          	ld	a,#1
6612  131b 81            	ret	
6613  131c               L5502:
6614                     ; 1802   else if(nGpio == 11 && (Relays_16to9 & (uint8_t)(0x08))) return 1; // Relay-12 is ON
6616  131c a10b          	cp	a,#11
6617  131e 2608          	jrne	L1602
6619  1320 7207000003    	btjf	_Relays_16to9,#3,L1602
6622  1325 a601          	ld	a,#1
6625  1327 81            	ret	
6626  1328               L1602:
6627                     ; 1803   else if(nGpio == 12 && (Relays_16to9 & (uint8_t)(0x10))) return 1; // Relay-13 is ON
6629  1328 a10c          	cp	a,#12
6630  132a 2608          	jrne	L5602
6632  132c 7209000003    	btjf	_Relays_16to9,#4,L5602
6635  1331 a601          	ld	a,#1
6638  1333 81            	ret	
6639  1334               L5602:
6640                     ; 1804   else if(nGpio == 13 && (Relays_16to9 & (uint8_t)(0x20))) return 1; // Relay-14 is ON
6642  1334 a10d          	cp	a,#13
6643  1336 2608          	jrne	L1702
6645  1338 720b000003    	btjf	_Relays_16to9,#5,L1702
6648  133d a601          	ld	a,#1
6651  133f 81            	ret	
6652  1340               L1702:
6653                     ; 1805   else if(nGpio == 14 && (Relays_16to9 & (uint8_t)(0x40))) return 1; // Relay-15 is ON
6655  1340 a10e          	cp	a,#14
6656  1342 2608          	jrne	L5702
6658  1344 720d000003    	btjf	_Relays_16to9,#6,L5702
6661  1349 a601          	ld	a,#1
6664  134b 81            	ret	
6665  134c               L5702:
6666                     ; 1806   else if(nGpio == 15 && (Relays_16to9 & (uint8_t)(0x80))) return 1; // Relay-16 is ON
6668  134c a10f          	cp	a,#15
6669  134e 2608          	jrne	L7002
6671  1350 720f000003    	btjf	_Relays_16to9,#7,L7002
6674  1355 a601          	ld	a,#1
6677  1357 81            	ret	
6678  1358               L7002:
6679                     ; 1807   return 0;
6681  1358 4f            	clr	a
6684  1359 81            	ret	
6725                     	switch	.const
6726  3e23               L623:
6727  3e23 1377          	dc.w	L3012
6728  3e25 1389          	dc.w	L5012
6729  3e27 139b          	dc.w	L7012
6730  3e29 13ad          	dc.w	L1112
6731  3e2b 13bf          	dc.w	L3112
6732  3e2d 13d1          	dc.w	L5112
6733  3e2f 13e3          	dc.w	L7112
6734  3e31 13f5          	dc.w	L1212
6735  3e33 1406          	dc.w	L3212
6736  3e35 1416          	dc.w	L5212
6737  3e37 1426          	dc.w	L7212
6738  3e39 1436          	dc.w	L1312
6739  3e3b 1446          	dc.w	L3312
6740  3e3d 1456          	dc.w	L5312
6741  3e3f 1466          	dc.w	L7312
6742  3e41 1476          	dc.w	L1412
6743                     ; 1811 void GpioSetPin(uint8_t nGpio, uint8_t nState)
6743                     ; 1812 {
6744                     	switch	.text
6745  135a               _GpioSetPin:
6747  135a 89            	pushw	x
6748       00000000      OFST:	set	0
6751                     ; 1816   if(nState != 0 && nState != 1) nState = 1;
6753  135b 9f            	ld	a,xl
6754  135c 4d            	tnz	a
6755  135d 2708          	jreq	L3612
6757  135f 9f            	ld	a,xl
6758  1360 4a            	dec	a
6759  1361 2704          	jreq	L3612
6762  1363 a601          	ld	a,#1
6763  1365 6b02          	ld	(OFST+2,sp),a
6764  1367               L3612:
6765                     ; 1818   switch(nGpio)
6767  1367 7b01          	ld	a,(OFST+1,sp)
6769                     ; 1884   default: break;
6770  1369 a110          	cp	a,#16
6771  136b 2503cc1484    	jruge	L7612
6772  1370 5f            	clrw	x
6773  1371 97            	ld	xl,a
6774  1372 58            	sllw	x
6775  1373 de3e23        	ldw	x,(L623,x)
6776  1376 fc            	jp	(x)
6777  1377               L3012:
6778                     ; 1820   case 0:
6778                     ; 1821     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x01); // Relay-01 OFF
6780  1377 7b02          	ld	a,(OFST+2,sp)
6781  1379 2607          	jrne	L1712
6784  137b 72110000      	bres	_Relays_8to1,#0
6786  137f cc1484        	jra	L7612
6787  1382               L1712:
6788                     ; 1822     else Relays_8to1 |= (uint8_t)0x01; // Relay-01 ON
6790  1382 72100000      	bset	_Relays_8to1,#0
6791  1386 cc1484        	jra	L7612
6792  1389               L5012:
6793                     ; 1824   case 1:
6793                     ; 1825     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x02); // Relay-02 OFF
6795  1389 7b02          	ld	a,(OFST+2,sp)
6796  138b 2607          	jrne	L5712
6799  138d 72130000      	bres	_Relays_8to1,#1
6801  1391 cc1484        	jra	L7612
6802  1394               L5712:
6803                     ; 1826     else Relays_8to1 |= (uint8_t)0x02; // Relay-02 ON
6805  1394 72120000      	bset	_Relays_8to1,#1
6806  1398 cc1484        	jra	L7612
6807  139b               L7012:
6808                     ; 1828   case 2:
6808                     ; 1829     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x04); // Relay-03 OFF
6810  139b 7b02          	ld	a,(OFST+2,sp)
6811  139d 2607          	jrne	L1022
6814  139f 72150000      	bres	_Relays_8to1,#2
6816  13a3 cc1484        	jra	L7612
6817  13a6               L1022:
6818                     ; 1830     else Relays_8to1 |= (uint8_t)0x04; // Relay-03 ON
6820  13a6 72140000      	bset	_Relays_8to1,#2
6821  13aa cc1484        	jra	L7612
6822  13ad               L1112:
6823                     ; 1832   case 3:
6823                     ; 1833     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x08); // Relay-04 OFF
6825  13ad 7b02          	ld	a,(OFST+2,sp)
6826  13af 2607          	jrne	L5022
6829  13b1 72170000      	bres	_Relays_8to1,#3
6831  13b5 cc1484        	jra	L7612
6832  13b8               L5022:
6833                     ; 1834     else Relays_8to1 |= (uint8_t)0x08; // Relay-04 ON
6835  13b8 72160000      	bset	_Relays_8to1,#3
6836  13bc cc1484        	jra	L7612
6837  13bf               L3112:
6838                     ; 1836   case 4:
6838                     ; 1837     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x10); // Relay-05 OFF
6840  13bf 7b02          	ld	a,(OFST+2,sp)
6841  13c1 2607          	jrne	L1122
6844  13c3 72190000      	bres	_Relays_8to1,#4
6846  13c7 cc1484        	jra	L7612
6847  13ca               L1122:
6848                     ; 1838     else Relays_8to1 |= (uint8_t)0x10; // Relay-05 ON
6850  13ca 72180000      	bset	_Relays_8to1,#4
6851  13ce cc1484        	jra	L7612
6852  13d1               L5112:
6853                     ; 1840   case 5:
6853                     ; 1841     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x20); // Relay-06 OFF
6855  13d1 7b02          	ld	a,(OFST+2,sp)
6856  13d3 2607          	jrne	L5122
6859  13d5 721b0000      	bres	_Relays_8to1,#5
6861  13d9 cc1484        	jra	L7612
6862  13dc               L5122:
6863                     ; 1842     else Relays_8to1 |= (uint8_t)0x20; // Relay-06 ON
6865  13dc 721a0000      	bset	_Relays_8to1,#5
6866  13e0 cc1484        	jra	L7612
6867  13e3               L7112:
6868                     ; 1844   case 6:
6868                     ; 1845     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x40); // Relay-07 OFF
6870  13e3 7b02          	ld	a,(OFST+2,sp)
6871  13e5 2607          	jrne	L1222
6874  13e7 721d0000      	bres	_Relays_8to1,#6
6876  13eb cc1484        	jra	L7612
6877  13ee               L1222:
6878                     ; 1846     else Relays_8to1 |= (uint8_t)0x40; // Relay-07 ON
6880  13ee 721c0000      	bset	_Relays_8to1,#6
6881  13f2 cc1484        	jra	L7612
6882  13f5               L1212:
6883                     ; 1848   case 7:
6883                     ; 1849     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x80); // Relay-08 OFF
6885  13f5 7b02          	ld	a,(OFST+2,sp)
6886  13f7 2607          	jrne	L5222
6889  13f9 721f0000      	bres	_Relays_8to1,#7
6891  13fd cc1484        	jra	L7612
6892  1400               L5222:
6893                     ; 1850     else Relays_8to1 |= (uint8_t)0x80; // Relay-08 ON
6895  1400 721e0000      	bset	_Relays_8to1,#7
6896  1404 207e          	jra	L7612
6897  1406               L3212:
6898                     ; 1852   case 8:
6898                     ; 1853     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x01); // Relay-09 OFF
6900  1406 7b02          	ld	a,(OFST+2,sp)
6901  1408 2606          	jrne	L1322
6904  140a 72110000      	bres	_Relays_16to9,#0
6906  140e 2074          	jra	L7612
6907  1410               L1322:
6908                     ; 1854     else Relays_16to9 |= (uint8_t)0x01; // Relay-09 ON
6910  1410 72100000      	bset	_Relays_16to9,#0
6911  1414 206e          	jra	L7612
6912  1416               L5212:
6913                     ; 1856   case 9:
6913                     ; 1857     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x02); // Relay-10 OFF
6915  1416 7b02          	ld	a,(OFST+2,sp)
6916  1418 2606          	jrne	L5322
6919  141a 72130000      	bres	_Relays_16to9,#1
6921  141e 2064          	jra	L7612
6922  1420               L5322:
6923                     ; 1858     else Relays_16to9 |= (uint8_t)0x02; // Relay-10 ON
6925  1420 72120000      	bset	_Relays_16to9,#1
6926  1424 205e          	jra	L7612
6927  1426               L7212:
6928                     ; 1860   case 10:
6928                     ; 1861     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x04); // Relay-11 OFF
6930  1426 7b02          	ld	a,(OFST+2,sp)
6931  1428 2606          	jrne	L1422
6934  142a 72150000      	bres	_Relays_16to9,#2
6936  142e 2054          	jra	L7612
6937  1430               L1422:
6938                     ; 1862     else Relays_16to9 |= (uint8_t)0x04; // Relay-11 ON
6940  1430 72140000      	bset	_Relays_16to9,#2
6941  1434 204e          	jra	L7612
6942  1436               L1312:
6943                     ; 1864   case 11:
6943                     ; 1865     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x08); // Relay-12 OFF
6945  1436 7b02          	ld	a,(OFST+2,sp)
6946  1438 2606          	jrne	L5422
6949  143a 72170000      	bres	_Relays_16to9,#3
6951  143e 2044          	jra	L7612
6952  1440               L5422:
6953                     ; 1866     else Relays_16to9 |= (uint8_t)0x08; // Relay-12 ON
6955  1440 72160000      	bset	_Relays_16to9,#3
6956  1444 203e          	jra	L7612
6957  1446               L3312:
6958                     ; 1868   case 12:
6958                     ; 1869     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x10); // Relay-13 OFF
6960  1446 7b02          	ld	a,(OFST+2,sp)
6961  1448 2606          	jrne	L1522
6964  144a 72190000      	bres	_Relays_16to9,#4
6966  144e 2034          	jra	L7612
6967  1450               L1522:
6968                     ; 1870     else Relays_16to9 |= (uint8_t)0x10; // Relay-13 ON
6970  1450 72180000      	bset	_Relays_16to9,#4
6971  1454 202e          	jra	L7612
6972  1456               L5312:
6973                     ; 1872   case 13:
6973                     ; 1873     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x20); // Relay-14 OFF
6975  1456 7b02          	ld	a,(OFST+2,sp)
6976  1458 2606          	jrne	L5522
6979  145a 721b0000      	bres	_Relays_16to9,#5
6981  145e 2024          	jra	L7612
6982  1460               L5522:
6983                     ; 1874     else Relays_16to9 |= (uint8_t)0x20; // Relay-14 ON
6985  1460 721a0000      	bset	_Relays_16to9,#5
6986  1464 201e          	jra	L7612
6987  1466               L7312:
6988                     ; 1876   case 14:
6988                     ; 1877     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x40); // Relay-15 OFF
6990  1466 7b02          	ld	a,(OFST+2,sp)
6991  1468 2606          	jrne	L1622
6994  146a 721d0000      	bres	_Relays_16to9,#6
6996  146e 2014          	jra	L7612
6997  1470               L1622:
6998                     ; 1878     else Relays_16to9 |= (uint8_t)0x40; // Relay-15 ON
7000  1470 721c0000      	bset	_Relays_16to9,#6
7001  1474 200e          	jra	L7612
7002  1476               L1412:
7003                     ; 1880   case 15:
7003                     ; 1881     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x80); // Relay-16 OFF
7005  1476 7b02          	ld	a,(OFST+2,sp)
7006  1478 2606          	jrne	L5622
7009  147a 721f0000      	bres	_Relays_16to9,#7
7011  147e 2004          	jra	L7612
7012  1480               L5622:
7013                     ; 1882     else Relays_16to9 |= (uint8_t)0x80; // Relay-16 ON
7015  1480 721e0000      	bset	_Relays_16to9,#7
7016                     ; 1884   default: break;
7018  1484               L7612:
7019                     ; 1886 }
7022  1484 85            	popw	x
7023  1485 81            	ret	
7113                     	switch	.const
7114  3e43               L633:
7115  3e43 14bb          	dc.w	L1722
7116  3e45 14c2          	dc.w	L3722
7117  3e47 14c9          	dc.w	L5722
7118  3e49 14d0          	dc.w	L7722
7119  3e4b 14d7          	dc.w	L1032
7120  3e4d 14de          	dc.w	L3032
7121  3e4f 14e5          	dc.w	L5032
7122  3e51 14ec          	dc.w	L7032
7123  3e53 14f3          	dc.w	L1132
7124  3e55 14fa          	dc.w	L3132
7125  3e57 1501          	dc.w	L5132
7126  3e59 1508          	dc.w	L7132
7127                     ; 1889 void SetAddresses(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
7127                     ; 1890 {
7128                     	switch	.text
7129  1486               _SetAddresses:
7131  1486 89            	pushw	x
7132  1487 5207          	subw	sp,#7
7133       00000007      OFST:	set	7
7136                     ; 1903   temp = 0;
7138                     ; 1904   invalid = 0;
7140  1489 0f01          	clr	(OFST-6,sp)
7142                     ; 1907   str[0] = (uint8_t)alpha1;
7144  148b 9f            	ld	a,xl
7145  148c 6b02          	ld	(OFST-5,sp),a
7147                     ; 1908   str[1] = (uint8_t)alpha2;
7149  148e 7b0c          	ld	a,(OFST+5,sp)
7150  1490 6b03          	ld	(OFST-4,sp),a
7152                     ; 1909   str[2] = (uint8_t)alpha3;
7154  1492 7b0d          	ld	a,(OFST+6,sp)
7155  1494 6b04          	ld	(OFST-3,sp),a
7157                     ; 1910   str[3] = 0;
7159  1496 0f05          	clr	(OFST-2,sp)
7161                     ; 1911   temp = atoi(str);
7163  1498 96            	ldw	x,sp
7164  1499 1c0002        	addw	x,#OFST-5
7165  149c cd0000        	call	_atoi
7167  149f 1f06          	ldw	(OFST-1,sp),x
7169                     ; 1912   if (temp > 255) invalid = 1; // If an invalid entry set indicator
7171  14a1 a30100        	cpw	x,#256
7172  14a4 2504          	jrult	L5532
7175  14a6 a601          	ld	a,#1
7176  14a8 6b01          	ld	(OFST-6,sp),a
7178  14aa               L5532:
7179                     ; 1914   if(invalid == 0) { // Make change only if valid entry
7181  14aa 7b01          	ld	a,(OFST-6,sp)
7182  14ac 265f          	jrne	L7532
7183                     ; 1915     switch(itemnum)
7185  14ae 7b08          	ld	a,(OFST+1,sp)
7187                     ; 1929     default: break;
7188  14b0 a10c          	cp	a,#12
7189  14b2 2459          	jruge	L7532
7190  14b4 5f            	clrw	x
7191  14b5 97            	ld	xl,a
7192  14b6 58            	sllw	x
7193  14b7 de3e43        	ldw	x,(L633,x)
7194  14ba fc            	jp	(x)
7195  14bb               L1722:
7196                     ; 1917     case 0:  Pending_hostaddr4 = (uint8_t)temp; break;
7198  14bb 7b07          	ld	a,(OFST+0,sp)
7199  14bd c70000        	ld	_Pending_hostaddr4,a
7202  14c0 204b          	jra	L7532
7203  14c2               L3722:
7204                     ; 1918     case 1:  Pending_hostaddr3 = (uint8_t)temp; break;
7206  14c2 7b07          	ld	a,(OFST+0,sp)
7207  14c4 c70000        	ld	_Pending_hostaddr3,a
7210  14c7 2044          	jra	L7532
7211  14c9               L5722:
7212                     ; 1919     case 2:  Pending_hostaddr2 = (uint8_t)temp; break;
7214  14c9 7b07          	ld	a,(OFST+0,sp)
7215  14cb c70000        	ld	_Pending_hostaddr2,a
7218  14ce 203d          	jra	L7532
7219  14d0               L7722:
7220                     ; 1920     case 3:  Pending_hostaddr1 = (uint8_t)temp; break;
7222  14d0 7b07          	ld	a,(OFST+0,sp)
7223  14d2 c70000        	ld	_Pending_hostaddr1,a
7226  14d5 2036          	jra	L7532
7227  14d7               L1032:
7228                     ; 1921     case 4:  Pending_draddr4 = (uint8_t)temp; break;
7230  14d7 7b07          	ld	a,(OFST+0,sp)
7231  14d9 c70000        	ld	_Pending_draddr4,a
7234  14dc 202f          	jra	L7532
7235  14de               L3032:
7236                     ; 1922     case 5:  Pending_draddr3 = (uint8_t)temp; break;
7238  14de 7b07          	ld	a,(OFST+0,sp)
7239  14e0 c70000        	ld	_Pending_draddr3,a
7242  14e3 2028          	jra	L7532
7243  14e5               L5032:
7244                     ; 1923     case 6:  Pending_draddr2 = (uint8_t)temp; break;
7246  14e5 7b07          	ld	a,(OFST+0,sp)
7247  14e7 c70000        	ld	_Pending_draddr2,a
7250  14ea 2021          	jra	L7532
7251  14ec               L7032:
7252                     ; 1924     case 7:  Pending_draddr1 = (uint8_t)temp; break;
7254  14ec 7b07          	ld	a,(OFST+0,sp)
7255  14ee c70000        	ld	_Pending_draddr1,a
7258  14f1 201a          	jra	L7532
7259  14f3               L1132:
7260                     ; 1925     case 8:  Pending_netmask4 = (uint8_t)temp; break;
7262  14f3 7b07          	ld	a,(OFST+0,sp)
7263  14f5 c70000        	ld	_Pending_netmask4,a
7266  14f8 2013          	jra	L7532
7267  14fa               L3132:
7268                     ; 1926     case 9:  Pending_netmask3 = (uint8_t)temp; break;
7270  14fa 7b07          	ld	a,(OFST+0,sp)
7271  14fc c70000        	ld	_Pending_netmask3,a
7274  14ff 200c          	jra	L7532
7275  1501               L5132:
7276                     ; 1927     case 10: Pending_netmask2 = (uint8_t)temp; break;
7278  1501 7b07          	ld	a,(OFST+0,sp)
7279  1503 c70000        	ld	_Pending_netmask2,a
7282  1506 2005          	jra	L7532
7283  1508               L7132:
7284                     ; 1928     case 11: Pending_netmask1 = (uint8_t)temp; break;
7286  1508 7b07          	ld	a,(OFST+0,sp)
7287  150a c70000        	ld	_Pending_netmask1,a
7290                     ; 1929     default: break;
7292  150d               L7532:
7293                     ; 1932 }
7296  150d 5b09          	addw	sp,#9
7297  150f 81            	ret	
7390                     ; 1935 void SetPort(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3, uint8_t alpha4, uint8_t alpha5)
7390                     ; 1936 {
7391                     	switch	.text
7392  1510               _SetPort:
7394  1510 89            	pushw	x
7395  1511 5209          	subw	sp,#9
7396       00000009      OFST:	set	9
7399                     ; 1949   temp = 0;
7401  1513 5f            	clrw	x
7402  1514 1f01          	ldw	(OFST-8,sp),x
7404                     ; 1950   invalid = 0;
7406  1516 0f03          	clr	(OFST-6,sp)
7408                     ; 1953   if(alpha1 > '6') invalid = 1;
7410  1518 7b0b          	ld	a,(OFST+2,sp)
7411  151a a137          	cp	a,#55
7412  151c 2506          	jrult	L3242
7415  151e a601          	ld	a,#1
7416  1520 6b03          	ld	(OFST-6,sp),a
7419  1522 201d          	jra	L5242
7420  1524               L3242:
7421                     ; 1955     str[0] = (uint8_t)alpha1;
7423  1524 6b04          	ld	(OFST-5,sp),a
7425                     ; 1956     str[1] = (uint8_t)alpha2;
7427  1526 7b0e          	ld	a,(OFST+5,sp)
7428  1528 6b05          	ld	(OFST-4,sp),a
7430                     ; 1957     str[2] = (uint8_t)alpha3;
7432  152a 7b0f          	ld	a,(OFST+6,sp)
7433  152c 6b06          	ld	(OFST-3,sp),a
7435                     ; 1958     str[3] = (uint8_t)alpha4;
7437  152e 7b10          	ld	a,(OFST+7,sp)
7438  1530 6b07          	ld	(OFST-2,sp),a
7440                     ; 1959     str[4] = (uint8_t)alpha5;
7442  1532 7b11          	ld	a,(OFST+8,sp)
7443  1534 6b08          	ld	(OFST-1,sp),a
7445                     ; 1960     str[5] = 0;
7447  1536 0f09          	clr	(OFST+0,sp)
7449                     ; 1961     temp = atoi(str);
7451  1538 96            	ldw	x,sp
7452  1539 1c0004        	addw	x,#OFST-5
7453  153c cd0000        	call	_atoi
7455  153f 1f01          	ldw	(OFST-8,sp),x
7457  1541               L5242:
7458                     ; 1964   if(invalid == 0) { // Make change only if valid entry
7460  1541 7b03          	ld	a,(OFST-6,sp)
7461  1543 2603          	jrne	L7242
7462                     ; 1965     Pending_port = (uint16_t)temp;
7464  1545 cf0000        	ldw	_Pending_port,x
7465  1548               L7242:
7466                     ; 1967 }
7469  1548 5b0b          	addw	sp,#11
7470  154a 81            	ret	
7536                     ; 1970 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7536                     ; 1971 {
7537                     	switch	.text
7538  154b               _SetMAC:
7540  154b 89            	pushw	x
7541  154c 5203          	subw	sp,#3
7542       00000003      OFST:	set	3
7545                     ; 1983   temp = 0;
7547                     ; 1984   invalid = 0;
7549  154e 0f01          	clr	(OFST-2,sp)
7551                     ; 1987   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7553  1550 9f            	ld	a,xl
7554  1551 a130          	cp	a,#48
7555  1553 250b          	jrult	L3742
7557  1555 9f            	ld	a,xl
7558  1556 a13a          	cp	a,#58
7559  1558 2406          	jruge	L3742
7562  155a 7b05          	ld	a,(OFST+2,sp)
7563  155c a030          	sub	a,#48
7565  155e 200c          	jp	LC024
7566  1560               L3742:
7567                     ; 1988   else if(alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7569  1560 7b05          	ld	a,(OFST+2,sp)
7570  1562 a161          	cp	a,#97
7571  1564 250a          	jrult	L7742
7573  1566 a167          	cp	a,#103
7574  1568 2406          	jruge	L7742
7577  156a a057          	sub	a,#87
7578  156c               LC024:
7579  156c 6b05          	ld	(OFST+2,sp),a
7581  156e 2004          	jra	L5742
7582  1570               L7742:
7583                     ; 1989   else invalid = 1; // If an invalid entry set indicator
7585  1570 a601          	ld	a,#1
7586  1572 6b01          	ld	(OFST-2,sp),a
7588  1574               L5742:
7589                     ; 1991   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7591  1574 7b08          	ld	a,(OFST+5,sp)
7592  1576 a130          	cp	a,#48
7593  1578 2508          	jrult	L3052
7595  157a a13a          	cp	a,#58
7596  157c 2404          	jruge	L3052
7599  157e a030          	sub	a,#48
7601  1580 200a          	jp	LC025
7602  1582               L3052:
7603                     ; 1992   else if(alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7605  1582 a161          	cp	a,#97
7606  1584 250a          	jrult	L7052
7608  1586 a167          	cp	a,#103
7609  1588 2406          	jruge	L7052
7612  158a a057          	sub	a,#87
7613  158c               LC025:
7614  158c 6b08          	ld	(OFST+5,sp),a
7616  158e 2004          	jra	L5052
7617  1590               L7052:
7618                     ; 1993   else invalid = 1; // If an invalid entry set indicator
7620  1590 a601          	ld	a,#1
7621  1592 6b01          	ld	(OFST-2,sp),a
7623  1594               L5052:
7624                     ; 1995   if (invalid == 0) { // Change value only if valid entry
7626  1594 7b01          	ld	a,(OFST-2,sp)
7627  1596 264a          	jrne	L3152
7628                     ; 1996     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7630  1598 7b05          	ld	a,(OFST+2,sp)
7631  159a 97            	ld	xl,a
7632  159b a610          	ld	a,#16
7633  159d 42            	mul	x,a
7634  159e 01            	rrwa	x,a
7635  159f 1b08          	add	a,(OFST+5,sp)
7636  15a1 5f            	clrw	x
7637  15a2 97            	ld	xl,a
7638  15a3 1f02          	ldw	(OFST-1,sp),x
7640                     ; 1997     switch(itemnum)
7642  15a5 7b04          	ld	a,(OFST+1,sp)
7644                     ; 2005     default: break;
7645  15a7 2711          	jreq	L1342
7646  15a9 4a            	dec	a
7647  15aa 2715          	jreq	L3342
7648  15ac 4a            	dec	a
7649  15ad 2719          	jreq	L5342
7650  15af 4a            	dec	a
7651  15b0 271d          	jreq	L7342
7652  15b2 4a            	dec	a
7653  15b3 2721          	jreq	L1442
7654  15b5 4a            	dec	a
7655  15b6 2725          	jreq	L3442
7656  15b8 2028          	jra	L3152
7657  15ba               L1342:
7658                     ; 1999     case 0: Pending_uip_ethaddr1 = (uint8_t)temp; break;
7660  15ba 7b03          	ld	a,(OFST+0,sp)
7661  15bc c70000        	ld	_Pending_uip_ethaddr1,a
7664  15bf 2021          	jra	L3152
7665  15c1               L3342:
7666                     ; 2000     case 1: Pending_uip_ethaddr2 = (uint8_t)temp; break;
7668  15c1 7b03          	ld	a,(OFST+0,sp)
7669  15c3 c70000        	ld	_Pending_uip_ethaddr2,a
7672  15c6 201a          	jra	L3152
7673  15c8               L5342:
7674                     ; 2001     case 2: Pending_uip_ethaddr3 = (uint8_t)temp; break;
7676  15c8 7b03          	ld	a,(OFST+0,sp)
7677  15ca c70000        	ld	_Pending_uip_ethaddr3,a
7680  15cd 2013          	jra	L3152
7681  15cf               L7342:
7682                     ; 2002     case 3: Pending_uip_ethaddr4 = (uint8_t)temp; break;
7684  15cf 7b03          	ld	a,(OFST+0,sp)
7685  15d1 c70000        	ld	_Pending_uip_ethaddr4,a
7688  15d4 200c          	jra	L3152
7689  15d6               L1442:
7690                     ; 2003     case 4: Pending_uip_ethaddr5 = (uint8_t)temp; break;
7692  15d6 7b03          	ld	a,(OFST+0,sp)
7693  15d8 c70000        	ld	_Pending_uip_ethaddr5,a
7696  15db 2005          	jra	L3152
7697  15dd               L3442:
7698                     ; 2004     case 5: Pending_uip_ethaddr6 = (uint8_t)temp; break;
7700  15dd 7b03          	ld	a,(OFST+0,sp)
7701  15df c70000        	ld	_Pending_uip_ethaddr6,a
7704                     ; 2005     default: break;
7706  15e2               L3152:
7707                     ; 2008 }
7710  15e2 5b05          	addw	sp,#5
7711  15e4 81            	ret	
7813                     	switch	.bss
7814  0000               _OctetArray:
7815  0000 000000000000  	ds.b	11
7816                     	xdef	_OctetArray
7817                     	xref	_submit_changes
7818                     	xref	_ex_stored_devicename
7819                     	xref	_uip_ethaddr6
7820                     	xref	_uip_ethaddr5
7821                     	xref	_uip_ethaddr4
7822                     	xref	_uip_ethaddr3
7823                     	xref	_uip_ethaddr2
7824                     	xref	_uip_ethaddr1
7825                     	xref	_ex_stored_port
7826                     	xref	_ex_stored_netmask1
7827                     	xref	_ex_stored_netmask2
7828                     	xref	_ex_stored_netmask3
7829                     	xref	_ex_stored_netmask4
7830                     	xref	_ex_stored_draddr1
7831                     	xref	_ex_stored_draddr2
7832                     	xref	_ex_stored_draddr3
7833                     	xref	_ex_stored_draddr4
7834                     	xref	_ex_stored_hostaddr1
7835                     	xref	_ex_stored_hostaddr2
7836                     	xref	_ex_stored_hostaddr3
7837                     	xref	_ex_stored_hostaddr4
7838                     	xref	_Pending_uip_ethaddr6
7839                     	xref	_Pending_uip_ethaddr5
7840                     	xref	_Pending_uip_ethaddr4
7841                     	xref	_Pending_uip_ethaddr3
7842                     	xref	_Pending_uip_ethaddr2
7843                     	xref	_Pending_uip_ethaddr1
7844                     	xref	_Pending_port
7845                     	xref	_Pending_netmask1
7846                     	xref	_Pending_netmask2
7847                     	xref	_Pending_netmask3
7848                     	xref	_Pending_netmask4
7849                     	xref	_Pending_draddr1
7850                     	xref	_Pending_draddr2
7851                     	xref	_Pending_draddr3
7852                     	xref	_Pending_draddr4
7853                     	xref	_Pending_hostaddr1
7854                     	xref	_Pending_hostaddr2
7855                     	xref	_Pending_hostaddr3
7856                     	xref	_Pending_hostaddr4
7857                     	xref	_invert_output
7858                     	xref	_Relays_8to1
7859                     	xref	_Relays_16to9
7860                     	xref	_Port_Httpd
7861  000b               _current_webpage:
7862  000b 00            	ds.b	1
7863                     	xdef	_current_webpage
7864                     	xref	_atoi
7865                     	xref	_debugflash
7866                     	xref	_uip_flags
7867                     	xref	_uip_stat
7868                     	xref	_uip_conn
7869                     	xref	_uip_appdata
7870                     	xref	_htons
7871                     	xref	_uip_send
7872                     	xref	_uip_listen
7873                     	xdef	_SetMAC
7874                     	xdef	_SetPort
7875                     	xdef	_SetAddresses
7876                     	xdef	_GpioSetPin
7877                     	xdef	_GpioGetPin
7878                     	xdef	_HttpDCall
7879                     	xdef	_HttpDInit
7880                     	xdef	_reverse
7881                     	xdef	_emb_itoa
7882                     	xdef	_two_alpha_to_uint
7883                     	xdef	_three_alpha_to_uint
7884                     	switch	.const
7885  3e5b               L714:
7886  3e5b 436f6e6e6563  	dc.b	"Connection:close",13
7887  3e6c 0a00          	dc.b	10,0
7888  3e6e               L514:
7889  3e6e 436f6e74656e  	dc.b	"Content-Type:text/"
7890  3e80 68746d6c0d    	dc.b	"html",13
7891  3e85 0a00          	dc.b	10,0
7892  3e87               L314:
7893  3e87 436f6e74656e  	dc.b	"Content-Length:",0
7894  3e97               L114:
7895  3e97 0d0a00        	dc.b	13,10,0
7896  3e9a               L704:
7897  3e9a 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
7898                     	xref.b	c_lreg
7899                     	xref.b	c_x
7900                     	xref.b	c_y
7920                     	xref	c_uitolx
7921                     	xref	c_ludv
7922                     	xref	c_lumd
7923                     	xref	c_rtol
7924                     	xref	c_ltor
7925                     	xref	c_lzmp
7926                     	end
