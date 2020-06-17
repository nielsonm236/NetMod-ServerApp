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
 789  329f 65766973696f  	dc.b	"evision 20200617 1"
 790  32b1 3131333c2f70  	dc.b	"113</p><a href='%x"
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
2281  02d4 2403cc0ae5    	jrult	L306
2284  02d9 ae0190        	ldw	x,#400
2285  02dc 1f10          	ldw	(OFST+9,sp),x
2286  02de cc0ae5        	jra	L306
2287  02e1               L106:
2288                     ; 710     if (*pDataLeft > 0) {
2290  02e1 1e0e          	ldw	x,(OFST+7,sp)
2291  02e3 e601          	ld	a,(1,x)
2292  02e5 fa            	or	a,(x)
2293  02e6 2603cc0aee    	jreq	L506
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
2313  0307 2703cc0ac8    	jrne	L116
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
2440  03b5 cd1322        	call	_GpioGetPin
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
2465  03cd cd1322        	call	_GpioGetPin
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
2510  03f5 cd1322        	call	_GpioGetPin
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
2607  0453 cc0832        	jp	LC011
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
2827  052d 2703cc0ae5    	jrne	L306
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
2864  0553 cc0622        	jp	LC010
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
2919  058e cc0ae5        	jra	L306
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
3043  0622               LC010:
3044  0622 f7            	ld	(x),a
3045                     ; 907           pBuffer++;
3046                     ; 908           nBytes++;
3048  0623 cc0add        	jp	LC009
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
3436  07ff 2031          	jp	LC011
3437  0801               L347:
3438                     ; 982         else if (nParsedMode == 'f') {
3440  0801 a166          	cp	a,#102
3441  0803 2632          	jrne	L167
3442                     ; 985 	  for(i=0; i<16; i++) {
3444  0805 4f            	clr	a
3445  0806 6b07          	ld	(OFST+0,sp),a
3447  0808               L367:
3448                     ; 986 	    *pBuffer = (uint8_t)(GpioGetPin(i) + '0');
3450  0808 cd1322        	call	_GpioGetPin
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
3487  0832               LC011:
3488  0832 90ff          	ldw	(y),x
3490  0834 cc0ae5        	jra	L306
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
3532  085b cc0ae5        	jra	L306
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
3573  0881 cc0ae5        	jra	L306
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
3682                     ; 1043           emb_itoa(ex_stored_hostaddr4,  OctetArray, 10, 3);
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
3699                     ; 1045 	  if (OctetArray[0] != '0') {
3701  08fd c60000        	ld	a,_OctetArray
3702  0900 a130          	cp	a,#48
3703  0902 270b          	jreq	L5201
3704                     ; 1046 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3706  0904 1e08          	ldw	x,(OFST+1,sp)
3707  0906 f7            	ld	(x),a
3710  0907 5c            	incw	x
3711  0908 1f08          	ldw	(OFST+1,sp),x
3714  090a 1e05          	ldw	x,(OFST-2,sp)
3715  090c 5c            	incw	x
3716  090d 1f05          	ldw	(OFST-2,sp),x
3718  090f               L5201:
3719                     ; 1048 	  if (OctetArray[0] != '0') {
3721  090f a130          	cp	a,#48
3722  0911 2707          	jreq	L7201
3723                     ; 1049             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3725  0913 1e08          	ldw	x,(OFST+1,sp)
3726  0915 c60001        	ld	a,_OctetArray+1
3730  0918 2009          	jp	LC005
3731  091a               L7201:
3732                     ; 1051 	  else if (OctetArray[1] != '0') {
3734  091a c60001        	ld	a,_OctetArray+1
3735  091d a130          	cp	a,#48
3736  091f 270b          	jreq	L1301
3737                     ; 1052             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3739  0921 1e08          	ldw	x,(OFST+1,sp)
3744  0923               LC005:
3745  0923 f7            	ld	(x),a
3747  0924 5c            	incw	x
3748  0925 1f08          	ldw	(OFST+1,sp),x
3750  0927 1e05          	ldw	x,(OFST-2,sp)
3751  0929 5c            	incw	x
3752  092a 1f05          	ldw	(OFST-2,sp),x
3754  092c               L1301:
3755                     ; 1054           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3757  092c 1e08          	ldw	x,(OFST+1,sp)
3758  092e c60002        	ld	a,_OctetArray+2
3759  0931 f7            	ld	(x),a
3762  0932 5c            	incw	x
3763  0933 1f08          	ldw	(OFST+1,sp),x
3766  0935 1e05          	ldw	x,(OFST-2,sp)
3767  0937 5c            	incw	x
3768  0938 1f05          	ldw	(OFST-2,sp),x
3770                     ; 1056           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3772  093a 1e08          	ldw	x,(OFST+1,sp)
3773  093c a62e          	ld	a,#46
3774  093e f7            	ld	(x),a
3777  093f 5c            	incw	x
3778  0940 1f08          	ldw	(OFST+1,sp),x
3781  0942 1e05          	ldw	x,(OFST-2,sp)
3782  0944 5c            	incw	x
3783  0945 1f05          	ldw	(OFST-2,sp),x
3785                     ; 1059           emb_itoa(ex_stored_hostaddr3,  OctetArray, 10, 3);
3787  0947 4b03          	push	#3
3788  0949 4b0a          	push	#10
3789  094b ae0000        	ldw	x,#_OctetArray
3790  094e 89            	pushw	x
3791  094f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr3
3792  0954 3f02          	clr	c_lreg+2
3793  0956 3f01          	clr	c_lreg+1
3794  0958 3f00          	clr	c_lreg
3795  095a be02          	ldw	x,c_lreg+2
3796  095c 89            	pushw	x
3797  095d be00          	ldw	x,c_lreg
3798  095f 89            	pushw	x
3799  0960 cd008c        	call	_emb_itoa
3801  0963 5b08          	addw	sp,#8
3802                     ; 1061 	  if (OctetArray[0] != '0') {
3804  0965 c60000        	ld	a,_OctetArray
3805  0968 a130          	cp	a,#48
3806  096a 270b          	jreq	L5301
3807                     ; 1062 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3809  096c 1e08          	ldw	x,(OFST+1,sp)
3810  096e f7            	ld	(x),a
3813  096f 5c            	incw	x
3814  0970 1f08          	ldw	(OFST+1,sp),x
3817  0972 1e05          	ldw	x,(OFST-2,sp)
3818  0974 5c            	incw	x
3819  0975 1f05          	ldw	(OFST-2,sp),x
3821  0977               L5301:
3822                     ; 1064 	  if (OctetArray[0] != '0') {
3824  0977 a130          	cp	a,#48
3825  0979 2707          	jreq	L7301
3826                     ; 1065             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3828  097b 1e08          	ldw	x,(OFST+1,sp)
3829  097d c60001        	ld	a,_OctetArray+1
3833  0980 2009          	jp	LC006
3834  0982               L7301:
3835                     ; 1067 	  else if (OctetArray[1] != '0') {
3837  0982 c60001        	ld	a,_OctetArray+1
3838  0985 a130          	cp	a,#48
3839  0987 270b          	jreq	L1401
3840                     ; 1068             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3842  0989 1e08          	ldw	x,(OFST+1,sp)
3847  098b               LC006:
3848  098b f7            	ld	(x),a
3850  098c 5c            	incw	x
3851  098d 1f08          	ldw	(OFST+1,sp),x
3853  098f 1e05          	ldw	x,(OFST-2,sp)
3854  0991 5c            	incw	x
3855  0992 1f05          	ldw	(OFST-2,sp),x
3857  0994               L1401:
3858                     ; 1070           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3860  0994 1e08          	ldw	x,(OFST+1,sp)
3861  0996 c60002        	ld	a,_OctetArray+2
3862  0999 f7            	ld	(x),a
3865  099a 5c            	incw	x
3866  099b 1f08          	ldw	(OFST+1,sp),x
3869  099d 1e05          	ldw	x,(OFST-2,sp)
3870  099f 5c            	incw	x
3871  09a0 1f05          	ldw	(OFST-2,sp),x
3873                     ; 1072           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3875  09a2 1e08          	ldw	x,(OFST+1,sp)
3876  09a4 a62e          	ld	a,#46
3877  09a6 f7            	ld	(x),a
3880  09a7 5c            	incw	x
3881  09a8 1f08          	ldw	(OFST+1,sp),x
3884  09aa 1e05          	ldw	x,(OFST-2,sp)
3885  09ac 5c            	incw	x
3886  09ad 1f05          	ldw	(OFST-2,sp),x
3888                     ; 1075           emb_itoa(ex_stored_hostaddr2,  OctetArray, 10, 3);
3890  09af 4b03          	push	#3
3891  09b1 4b0a          	push	#10
3892  09b3 ae0000        	ldw	x,#_OctetArray
3893  09b6 89            	pushw	x
3894  09b7 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr2
3895  09bc 3f02          	clr	c_lreg+2
3896  09be 3f01          	clr	c_lreg+1
3897  09c0 3f00          	clr	c_lreg
3898  09c2 be02          	ldw	x,c_lreg+2
3899  09c4 89            	pushw	x
3900  09c5 be00          	ldw	x,c_lreg
3901  09c7 89            	pushw	x
3902  09c8 cd008c        	call	_emb_itoa
3904  09cb 5b08          	addw	sp,#8
3905                     ; 1077 	  if (OctetArray[0] != '0') {
3907  09cd c60000        	ld	a,_OctetArray
3908  09d0 a130          	cp	a,#48
3909  09d2 270b          	jreq	L5401
3910                     ; 1078 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
3912  09d4 1e08          	ldw	x,(OFST+1,sp)
3913  09d6 f7            	ld	(x),a
3916  09d7 5c            	incw	x
3917  09d8 1f08          	ldw	(OFST+1,sp),x
3920  09da 1e05          	ldw	x,(OFST-2,sp)
3921  09dc 5c            	incw	x
3922  09dd 1f05          	ldw	(OFST-2,sp),x
3924  09df               L5401:
3925                     ; 1080 	  if (OctetArray[0] != '0') {
3927  09df a130          	cp	a,#48
3928  09e1 2707          	jreq	L7401
3929                     ; 1081             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3931  09e3 1e08          	ldw	x,(OFST+1,sp)
3932  09e5 c60001        	ld	a,_OctetArray+1
3936  09e8 2009          	jp	LC007
3937  09ea               L7401:
3938                     ; 1083 	  else if (OctetArray[1] != '0') {
3940  09ea c60001        	ld	a,_OctetArray+1
3941  09ed a130          	cp	a,#48
3942  09ef 270b          	jreq	L1501
3943                     ; 1084             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
3945  09f1 1e08          	ldw	x,(OFST+1,sp)
3950  09f3               LC007:
3951  09f3 f7            	ld	(x),a
3953  09f4 5c            	incw	x
3954  09f5 1f08          	ldw	(OFST+1,sp),x
3956  09f7 1e05          	ldw	x,(OFST-2,sp)
3957  09f9 5c            	incw	x
3958  09fa 1f05          	ldw	(OFST-2,sp),x
3960  09fc               L1501:
3961                     ; 1086           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
3963  09fc 1e08          	ldw	x,(OFST+1,sp)
3964  09fe c60002        	ld	a,_OctetArray+2
3965  0a01 f7            	ld	(x),a
3968  0a02 5c            	incw	x
3969  0a03 1f08          	ldw	(OFST+1,sp),x
3972  0a05 1e05          	ldw	x,(OFST-2,sp)
3973  0a07 5c            	incw	x
3974  0a08 1f05          	ldw	(OFST-2,sp),x
3976                     ; 1088           *pBuffer = '.'; pBuffer++; nBytes++; // Output '.'
3978  0a0a 1e08          	ldw	x,(OFST+1,sp)
3979  0a0c a62e          	ld	a,#46
3980  0a0e f7            	ld	(x),a
3983  0a0f 5c            	incw	x
3984  0a10 1f08          	ldw	(OFST+1,sp),x
3987  0a12 1e05          	ldw	x,(OFST-2,sp)
3988  0a14 5c            	incw	x
3989  0a15 1f05          	ldw	(OFST-2,sp),x
3991                     ; 1091           emb_itoa(ex_stored_hostaddr1,  OctetArray, 10, 3);
3993  0a17 4b03          	push	#3
3994  0a19 4b0a          	push	#10
3995  0a1b ae0000        	ldw	x,#_OctetArray
3996  0a1e 89            	pushw	x
3997  0a1f 5500000003    	mov	c_lreg+3,_ex_stored_hostaddr1
3998  0a24 3f02          	clr	c_lreg+2
3999  0a26 3f01          	clr	c_lreg+1
4000  0a28 3f00          	clr	c_lreg
4001  0a2a be02          	ldw	x,c_lreg+2
4002  0a2c 89            	pushw	x
4003  0a2d be00          	ldw	x,c_lreg
4004  0a2f 89            	pushw	x
4005  0a30 cd008c        	call	_emb_itoa
4007  0a33 5b08          	addw	sp,#8
4008                     ; 1093 	  if (OctetArray[0] != '0') {
4010  0a35 c60000        	ld	a,_OctetArray
4011  0a38 a130          	cp	a,#48
4012  0a3a 270b          	jreq	L5501
4013                     ; 1094 	    *pBuffer = OctetArray[0]; pBuffer++; nBytes++;
4015  0a3c 1e08          	ldw	x,(OFST+1,sp)
4016  0a3e f7            	ld	(x),a
4019  0a3f 5c            	incw	x
4020  0a40 1f08          	ldw	(OFST+1,sp),x
4023  0a42 1e05          	ldw	x,(OFST-2,sp)
4024  0a44 5c            	incw	x
4025  0a45 1f05          	ldw	(OFST-2,sp),x
4027  0a47               L5501:
4028                     ; 1096 	  if (OctetArray[0] != '0') {
4030  0a47 a130          	cp	a,#48
4031  0a49 2707          	jreq	L7501
4032                     ; 1097             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
4034  0a4b 1e08          	ldw	x,(OFST+1,sp)
4035  0a4d c60001        	ld	a,_OctetArray+1
4039  0a50 2009          	jp	LC008
4040  0a52               L7501:
4041                     ; 1099 	  else if (OctetArray[1] != '0') {
4043  0a52 c60001        	ld	a,_OctetArray+1
4044  0a55 a130          	cp	a,#48
4045  0a57 270b          	jreq	L1601
4046                     ; 1100             *pBuffer = OctetArray[1]; pBuffer++; nBytes++;
4048  0a59 1e08          	ldw	x,(OFST+1,sp)
4053  0a5b               LC008:
4054  0a5b f7            	ld	(x),a
4056  0a5c 5c            	incw	x
4057  0a5d 1f08          	ldw	(OFST+1,sp),x
4059  0a5f 1e05          	ldw	x,(OFST-2,sp)
4060  0a61 5c            	incw	x
4061  0a62 1f05          	ldw	(OFST-2,sp),x
4063  0a64               L1601:
4064                     ; 1102           *pBuffer = OctetArray[2]; pBuffer++; nBytes++;
4066  0a64 1e08          	ldw	x,(OFST+1,sp)
4067  0a66 c60002        	ld	a,_OctetArray+2
4068  0a69 f7            	ld	(x),a
4071  0a6a 5c            	incw	x
4072  0a6b 1f08          	ldw	(OFST+1,sp),x
4075  0a6d 1e05          	ldw	x,(OFST-2,sp)
4076  0a6f 5c            	incw	x
4077  0a70 1f05          	ldw	(OFST-2,sp),x
4079                     ; 1104           *pBuffer = ':'; pBuffer++; nBytes++; // Output ':'
4081  0a72 1e08          	ldw	x,(OFST+1,sp)
4082  0a74 a63a          	ld	a,#58
4083  0a76 f7            	ld	(x),a
4086  0a77 5c            	incw	x
4087  0a78 1f08          	ldw	(OFST+1,sp),x
4090  0a7a 1e05          	ldw	x,(OFST-2,sp)
4091  0a7c 5c            	incw	x
4092  0a7d 1f05          	ldw	(OFST-2,sp),x
4094                     ; 1106 	  emb_itoa(ex_stored_port, OctetArray, 10, 5); // Now output the Port number
4096  0a7f 4b05          	push	#5
4097  0a81 4b0a          	push	#10
4098  0a83 ae0000        	ldw	x,#_OctetArray
4099  0a86 89            	pushw	x
4100  0a87 ce0000        	ldw	x,_ex_stored_port
4101  0a8a cd0000        	call	c_uitolx
4103  0a8d be02          	ldw	x,c_lreg+2
4104  0a8f 89            	pushw	x
4105  0a90 be00          	ldw	x,c_lreg
4106  0a92 89            	pushw	x
4107  0a93 cd008c        	call	_emb_itoa
4109  0a96 5b08          	addw	sp,#8
4110                     ; 1107 	  for(i=0; i<5; i++) { *pBuffer = OctetArray[i]; pBuffer++; nBytes++; }
4112  0a98 4f            	clr	a
4113  0a99 6b07          	ld	(OFST+0,sp),a
4115  0a9b               L5601:
4118  0a9b 5f            	clrw	x
4119  0a9c 97            	ld	xl,a
4120  0a9d d60000        	ld	a,(_OctetArray,x)
4121  0aa0 1e08          	ldw	x,(OFST+1,sp)
4122  0aa2 f7            	ld	(x),a
4125  0aa3 5c            	incw	x
4126  0aa4 1f08          	ldw	(OFST+1,sp),x
4129  0aa6 1e05          	ldw	x,(OFST-2,sp)
4130  0aa8 5c            	incw	x
4131  0aa9 1f05          	ldw	(OFST-2,sp),x
4135  0aab 0c07          	inc	(OFST+0,sp)
4139  0aad 7b07          	ld	a,(OFST+0,sp)
4140  0aaf a105          	cp	a,#5
4141  0ab1 25e8          	jrult	L5601
4142                     ; 1111           *ppData = *ppData + 28;
4144  0ab3 1e0c          	ldw	x,(OFST+5,sp)
4145  0ab5 9093          	ldw	y,x
4146  0ab7 fe            	ldw	x,(x)
4147  0ab8 1c001c        	addw	x,#28
4148  0abb 90ff          	ldw	(y),x
4149                     ; 1112           *pDataLeft = *pDataLeft - 28;
4151  0abd 1e0e          	ldw	x,(OFST+7,sp)
4152  0abf 9093          	ldw	y,x
4153  0ac1 fe            	ldw	x,(x)
4154  0ac2 1d001c        	subw	x,#28
4155  0ac5 cc0832        	jp	LC011
4156  0ac8               L116:
4157                     ; 1116         *pBuffer = nByte;
4159  0ac8 1e08          	ldw	x,(OFST+1,sp)
4160  0aca f7            	ld	(x),a
4161                     ; 1117         *ppData = *ppData + 1;
4163  0acb 1e0c          	ldw	x,(OFST+5,sp)
4164  0acd 9093          	ldw	y,x
4165  0acf fe            	ldw	x,(x)
4166  0ad0 5c            	incw	x
4167  0ad1 90ff          	ldw	(y),x
4168                     ; 1118         *pDataLeft = *pDataLeft - 1;
4170  0ad3 1e0e          	ldw	x,(OFST+7,sp)
4171  0ad5 9093          	ldw	y,x
4172  0ad7 fe            	ldw	x,(x)
4173  0ad8 5a            	decw	x
4174  0ad9 90ff          	ldw	(y),x
4175                     ; 1119         pBuffer++;
4177  0adb 1e08          	ldw	x,(OFST+1,sp)
4178                     ; 1120         nBytes++;
4180  0add               LC009:
4183  0add 5c            	incw	x
4184  0ade 1f08          	ldw	(OFST+1,sp),x
4187  0ae0 1e05          	ldw	x,(OFST-2,sp)
4188  0ae2 5c            	incw	x
4189  0ae3 1f05          	ldw	(OFST-2,sp),x
4191  0ae5               L306:
4192                     ; 689   while (nBytes < nMaxBytes) {
4194  0ae5 1e05          	ldw	x,(OFST-2,sp)
4195  0ae7 1310          	cpw	x,(OFST+9,sp)
4196  0ae9 2403cc02e1    	jrult	L106
4197  0aee               L506:
4198                     ; 1125   return nBytes;
4200  0aee 1e05          	ldw	x,(OFST-2,sp)
4203  0af0 5b09          	addw	sp,#9
4204  0af2 81            	ret	
4231                     ; 1129 void HttpDInit()
4231                     ; 1130 {
4232                     	switch	.text
4233  0af3               _HttpDInit:
4237                     ; 1132   uip_listen(htons(Port_Httpd));
4239  0af3 ce0000        	ldw	x,_Port_Httpd
4240  0af6 cd0000        	call	_htons
4242  0af9 cd0000        	call	_uip_listen
4244                     ; 1133   current_webpage = WEBPAGE_DEFAULT;
4246  0afc 725f000b      	clr	_current_webpage
4247                     ; 1134 }
4250  0b00 81            	ret	
4456                     	switch	.const
4457  3d9d               L472:
4458  3d9d 107a          	dc.w	L7011
4459  3d9f 1081          	dc.w	L1111
4460  3da1 1088          	dc.w	L3111
4461  3da3 108f          	dc.w	L5111
4462  3da5 1096          	dc.w	L7111
4463  3da7 109d          	dc.w	L1211
4464  3da9 10a4          	dc.w	L3211
4465  3dab 10ab          	dc.w	L5211
4466  3dad 10b2          	dc.w	L7211
4467  3daf 10b9          	dc.w	L1311
4468  3db1 10c0          	dc.w	L3311
4469  3db3 10c7          	dc.w	L5311
4470  3db5 10ce          	dc.w	L7311
4471  3db7 10d5          	dc.w	L1411
4472  3db9 10dc          	dc.w	L3411
4473  3dbb 10e3          	dc.w	L5411
4474  3dbd 10ea          	dc.w	L7411
4475  3dbf 10f1          	dc.w	L1511
4476  3dc1 10f8          	dc.w	L3511
4477  3dc3 10ff          	dc.w	L5511
4478  3dc5 1106          	dc.w	L7511
4479  3dc7 110d          	dc.w	L1611
4480  3dc9 1114          	dc.w	L3611
4481  3dcb 111b          	dc.w	L5611
4482  3dcd 1122          	dc.w	L7611
4483  3dcf 1129          	dc.w	L1711
4484  3dd1 1130          	dc.w	L3711
4485  3dd3 1137          	dc.w	L5711
4486  3dd5 113e          	dc.w	L7711
4487  3dd7 1145          	dc.w	L1021
4488  3dd9 114c          	dc.w	L3021
4489  3ddb 1153          	dc.w	L5021
4490  3ddd 11e0          	dc.w	L3321
4491  3ddf 11e0          	dc.w	L3321
4492  3de1 11e0          	dc.w	L3321
4493  3de3 11e0          	dc.w	L3321
4494  3de5 11e0          	dc.w	L3321
4495  3de7 11e0          	dc.w	L3321
4496  3de9 11e0          	dc.w	L3321
4497  3deb 11e0          	dc.w	L3321
4498  3ded 11e0          	dc.w	L3321
4499  3def 11e0          	dc.w	L3321
4500  3df1 11e0          	dc.w	L3321
4501  3df3 11e0          	dc.w	L3321
4502  3df5 11e0          	dc.w	L3321
4503  3df7 11e0          	dc.w	L3321
4504  3df9 11e0          	dc.w	L3321
4505  3dfb 11e0          	dc.w	L3321
4506  3dfd 11e0          	dc.w	L3321
4507  3dff 11e0          	dc.w	L3321
4508  3e01 11e0          	dc.w	L3321
4509  3e03 11e0          	dc.w	L3321
4510  3e05 11e0          	dc.w	L3321
4511  3e07 11e0          	dc.w	L3321
4512  3e09 11e0          	dc.w	L3321
4513  3e0b 115a          	dc.w	L7021
4514  3e0d 1165          	dc.w	L1121
4515  3e0f 11e0          	dc.w	L3321
4516  3e11 11e0          	dc.w	L3321
4517  3e13 11e0          	dc.w	L3321
4518  3e15 1170          	dc.w	L3121
4519  3e17 1172          	dc.w	L5121
4520  3e19 11e0          	dc.w	L3321
4521  3e1b 1184          	dc.w	L7121
4522  3e1d 1196          	dc.w	L1221
4523  3e1f 11a8          	dc.w	L3221
4524  3e21 11b3          	dc.w	L5221
4525                     ; 1137 void HttpDCall(	uint8_t* pBuffer, uint16_t nBytes, struct tHttpD* pSocket)
4525                     ; 1138 {
4526                     	switch	.text
4527  0b01               _HttpDCall:
4529  0b01 89            	pushw	x
4530  0b02 5207          	subw	sp,#7
4531       00000007      OFST:	set	7
4534                     ; 1148   alpha_1 = '0';
4536                     ; 1149   alpha_2 = '0';
4538                     ; 1150   alpha_3 = '0';
4540                     ; 1151   alpha_4 = '0';
4542                     ; 1152   alpha_5 = '0';
4544                     ; 1154   if(uip_connected()) {
4546  0b04 720d00007a    	btjf	_uip_flags,#6,L3331
4547                     ; 1156     if(current_webpage == WEBPAGE_DEFAULT) {
4549  0b09 c6000b        	ld	a,_current_webpage
4550  0b0c 260e          	jrne	L5331
4551                     ; 1157       pSocket->pData = g_HtmlPageDefault;
4553  0b0e 1e0e          	ldw	x,(OFST+7,sp)
4554  0b10 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
4555  0b14 ef01          	ldw	(1,x),y
4556                     ; 1158       pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
4558  0b16 90ae15d5      	ldw	y,#5589
4560  0b1a 2058          	jp	LC012
4561  0b1c               L5331:
4562                     ; 1162     else if(current_webpage == WEBPAGE_ADDRESS) {
4564  0b1c a101          	cp	a,#1
4565  0b1e 260e          	jrne	L1431
4566                     ; 1163       pSocket->pData = g_HtmlPageAddress;
4568  0b20 1e0e          	ldw	x,(OFST+7,sp)
4569  0b22 90ae15de      	ldw	y,#L71_g_HtmlPageAddress
4570  0b26 ef01          	ldw	(1,x),y
4571                     ; 1164       pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
4573  0b28 90ae1341      	ldw	y,#4929
4575  0b2c 2046          	jp	LC012
4576  0b2e               L1431:
4577                     ; 1168     else if(current_webpage == WEBPAGE_HELP) {
4579  0b2e a103          	cp	a,#3
4580  0b30 260e          	jrne	L5431
4581                     ; 1169       pSocket->pData = g_HtmlPageHelp;
4583  0b32 1e0e          	ldw	x,(OFST+7,sp)
4584  0b34 90ae2920      	ldw	y,#L12_g_HtmlPageHelp
4585  0b38 ef01          	ldw	(1,x),y
4586                     ; 1170       pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
4588  0b3a 90ae075c      	ldw	y,#1884
4590  0b3e 2034          	jp	LC012
4591  0b40               L5431:
4592                     ; 1172     else if(current_webpage == WEBPAGE_HELP2) {
4594  0b40 a104          	cp	a,#4
4595  0b42 260e          	jrne	L1531
4596                     ; 1173       pSocket->pData = g_HtmlPageHelp2;
4598  0b44 1e0e          	ldw	x,(OFST+7,sp)
4599  0b46 90ae307d      	ldw	y,#L32_g_HtmlPageHelp2
4600  0b4a ef01          	ldw	(1,x),y
4601                     ; 1174       pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
4603  0b4c 90ae02bb      	ldw	y,#699
4605  0b50 2022          	jp	LC012
4606  0b52               L1531:
4607                     ; 1179     else if(current_webpage == WEBPAGE_STATS) {
4609  0b52 a105          	cp	a,#5
4610  0b54 260e          	jrne	L5531
4611                     ; 1180       pSocket->pData = g_HtmlPageStats;
4613  0b56 1e0e          	ldw	x,(OFST+7,sp)
4614  0b58 90ae3339      	ldw	y,#L52_g_HtmlPageStats
4615  0b5c ef01          	ldw	(1,x),y
4616                     ; 1181       pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
4618  0b5e 90ae097e      	ldw	y,#2430
4620  0b62 2010          	jp	LC012
4621  0b64               L5531:
4622                     ; 1184     else if(current_webpage == WEBPAGE_RSTATE) {
4624  0b64 a106          	cp	a,#6
4625  0b66 260e          	jrne	L7331
4626                     ; 1185       pSocket->pData = g_HtmlPageRstate;
4628  0b68 1e0e          	ldw	x,(OFST+7,sp)
4629  0b6a 90ae3cb8      	ldw	y,#L72_g_HtmlPageRstate
4630  0b6e ef01          	ldw	(1,x),y
4631                     ; 1186       pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
4633  0b70 90ae00a0      	ldw	y,#160
4634  0b74               LC012:
4635  0b74 ef03          	ldw	(3,x),y
4636  0b76               L7331:
4637                     ; 1188     pSocket->nNewlines = 0;
4639  0b76 1e0e          	ldw	x,(OFST+7,sp)
4640                     ; 1189     pSocket->nState = STATE_CONNECTED;
4642  0b78 7f            	clr	(x)
4643  0b79 6f05          	clr	(5,x)
4644                     ; 1190     pSocket->nPrevBytes = 0xFFFF;
4646  0b7b 90aeffff      	ldw	y,#65535
4647  0b7f ef0a          	ldw	(10,x),y
4649  0b81 2041          	jra	L613
4650  0b83               L3331:
4651                     ; 1192   else if (uip_newdata() || uip_acked()) {
4653  0b83 7202000008    	btjt	_uip_flags,#1,L7631
4655  0b88 7200000003cc  	btjf	_uip_flags,#0,L5631
4656  0b90               L7631:
4657                     ; 1193     if (pSocket->nState == STATE_CONNECTED) {
4659  0b90 1e0e          	ldw	x,(OFST+7,sp)
4660  0b92 f6            	ld	a,(x)
4661  0b93 2627          	jrne	L1731
4662                     ; 1194       if (nBytes == 0) return;
4664  0b95 1e0c          	ldw	x,(OFST+5,sp)
4665  0b97 272b          	jreq	L613
4668                     ; 1195       if (*pBuffer == 'G') pSocket->nState = STATE_GET_G;
4670  0b99 1e08          	ldw	x,(OFST+1,sp)
4671  0b9b f6            	ld	a,(x)
4672  0b9c a147          	cp	a,#71
4673  0b9e 2606          	jrne	L5731
4676  0ba0 1e0e          	ldw	x,(OFST+7,sp)
4677  0ba2 a601          	ld	a,#1
4679  0ba4 2008          	jp	LC013
4680  0ba6               L5731:
4681                     ; 1196       else if (*pBuffer == 'P') pSocket->nState = STATE_POST_P;
4683  0ba6 a150          	cp	a,#80
4684  0ba8 2605          	jrne	L7731
4687  0baa 1e0e          	ldw	x,(OFST+7,sp)
4688  0bac a604          	ld	a,#4
4689  0bae               LC013:
4690  0bae f7            	ld	(x),a
4691  0baf               L7731:
4692                     ; 1197       nBytes--;
4694  0baf 1e0c          	ldw	x,(OFST+5,sp)
4695  0bb1 5a            	decw	x
4696  0bb2 1f0c          	ldw	(OFST+5,sp),x
4697                     ; 1198       pBuffer++;
4699  0bb4 1e08          	ldw	x,(OFST+1,sp)
4700  0bb6 5c            	incw	x
4701  0bb7 1f08          	ldw	(OFST+1,sp),x
4702  0bb9 1e0e          	ldw	x,(OFST+7,sp)
4703  0bbb f6            	ld	a,(x)
4704  0bbc               L1731:
4705                     ; 1201     if (pSocket->nState == STATE_GET_G) {
4707  0bbc a101          	cp	a,#1
4708  0bbe 2620          	jrne	L3041
4709                     ; 1202       if (nBytes == 0) return;
4711  0bc0 1e0c          	ldw	x,(OFST+5,sp)
4712  0bc2 2603          	jrne	L5041
4714  0bc4               L613:
4717  0bc4 5b09          	addw	sp,#9
4718  0bc6 81            	ret	
4719  0bc7               L5041:
4720                     ; 1203       if (*pBuffer == 'E') pSocket->nState = STATE_GET_GE;
4722  0bc7 1e08          	ldw	x,(OFST+1,sp)
4723  0bc9 f6            	ld	a,(x)
4724  0bca a145          	cp	a,#69
4725  0bcc 2605          	jrne	L7041
4728  0bce 1e0e          	ldw	x,(OFST+7,sp)
4729  0bd0 a602          	ld	a,#2
4730  0bd2 f7            	ld	(x),a
4731  0bd3               L7041:
4732                     ; 1204       nBytes--;
4734  0bd3 1e0c          	ldw	x,(OFST+5,sp)
4735  0bd5 5a            	decw	x
4736  0bd6 1f0c          	ldw	(OFST+5,sp),x
4737                     ; 1205       pBuffer++;
4739  0bd8 1e08          	ldw	x,(OFST+1,sp)
4740  0bda 5c            	incw	x
4741  0bdb 1f08          	ldw	(OFST+1,sp),x
4742  0bdd 1e0e          	ldw	x,(OFST+7,sp)
4743  0bdf f6            	ld	a,(x)
4744  0be0               L3041:
4745                     ; 1208     if (pSocket->nState == STATE_GET_GE) {
4747  0be0 a102          	cp	a,#2
4748  0be2 261d          	jrne	L1141
4749                     ; 1209       if (nBytes == 0) return;
4751  0be4 1e0c          	ldw	x,(OFST+5,sp)
4752  0be6 27dc          	jreq	L613
4755                     ; 1210       if (*pBuffer == 'T') pSocket->nState = STATE_GET_GET;
4757  0be8 1e08          	ldw	x,(OFST+1,sp)
4758  0bea f6            	ld	a,(x)
4759  0beb a154          	cp	a,#84
4760  0bed 2605          	jrne	L5141
4763  0bef 1e0e          	ldw	x,(OFST+7,sp)
4764  0bf1 a603          	ld	a,#3
4765  0bf3 f7            	ld	(x),a
4766  0bf4               L5141:
4767                     ; 1211       nBytes--;
4769  0bf4 1e0c          	ldw	x,(OFST+5,sp)
4770  0bf6 5a            	decw	x
4771  0bf7 1f0c          	ldw	(OFST+5,sp),x
4772                     ; 1212       pBuffer++;
4774  0bf9 1e08          	ldw	x,(OFST+1,sp)
4775  0bfb 5c            	incw	x
4776  0bfc 1f08          	ldw	(OFST+1,sp),x
4777  0bfe 1e0e          	ldw	x,(OFST+7,sp)
4778  0c00 f6            	ld	a,(x)
4779  0c01               L1141:
4780                     ; 1215     if (pSocket->nState == STATE_GET_GET) {
4782  0c01 a103          	cp	a,#3
4783  0c03 261d          	jrne	L7141
4784                     ; 1216       if (nBytes == 0) return;
4786  0c05 1e0c          	ldw	x,(OFST+5,sp)
4787  0c07 27bb          	jreq	L613
4790                     ; 1217       if (*pBuffer == ' ') pSocket->nState = STATE_GOTGET;
4792  0c09 1e08          	ldw	x,(OFST+1,sp)
4793  0c0b f6            	ld	a,(x)
4794  0c0c a120          	cp	a,#32
4795  0c0e 2605          	jrne	L3241
4798  0c10 1e0e          	ldw	x,(OFST+7,sp)
4799  0c12 a608          	ld	a,#8
4800  0c14 f7            	ld	(x),a
4801  0c15               L3241:
4802                     ; 1218       nBytes--;
4804  0c15 1e0c          	ldw	x,(OFST+5,sp)
4805  0c17 5a            	decw	x
4806  0c18 1f0c          	ldw	(OFST+5,sp),x
4807                     ; 1219       pBuffer++;
4809  0c1a 1e08          	ldw	x,(OFST+1,sp)
4810  0c1c 5c            	incw	x
4811  0c1d 1f08          	ldw	(OFST+1,sp),x
4812  0c1f 1e0e          	ldw	x,(OFST+7,sp)
4813  0c21 f6            	ld	a,(x)
4814  0c22               L7141:
4815                     ; 1222     if (pSocket->nState == STATE_POST_P) {
4817  0c22 a104          	cp	a,#4
4818  0c24 261d          	jrne	L5241
4819                     ; 1223       if (nBytes == 0) return;
4821  0c26 1e0c          	ldw	x,(OFST+5,sp)
4822  0c28 279a          	jreq	L613
4825                     ; 1224       if (*pBuffer == 'O') pSocket->nState = STATE_POST_PO;
4827  0c2a 1e08          	ldw	x,(OFST+1,sp)
4828  0c2c f6            	ld	a,(x)
4829  0c2d a14f          	cp	a,#79
4830  0c2f 2605          	jrne	L1341
4833  0c31 1e0e          	ldw	x,(OFST+7,sp)
4834  0c33 a605          	ld	a,#5
4835  0c35 f7            	ld	(x),a
4836  0c36               L1341:
4837                     ; 1225       nBytes--;
4839  0c36 1e0c          	ldw	x,(OFST+5,sp)
4840  0c38 5a            	decw	x
4841  0c39 1f0c          	ldw	(OFST+5,sp),x
4842                     ; 1226       pBuffer++;
4844  0c3b 1e08          	ldw	x,(OFST+1,sp)
4845  0c3d 5c            	incw	x
4846  0c3e 1f08          	ldw	(OFST+1,sp),x
4847  0c40 1e0e          	ldw	x,(OFST+7,sp)
4848  0c42 f6            	ld	a,(x)
4849  0c43               L5241:
4850                     ; 1229     if (pSocket->nState == STATE_POST_PO) {
4852  0c43 a105          	cp	a,#5
4853  0c45 2620          	jrne	L3341
4854                     ; 1230       if (nBytes == 0) return;
4856  0c47 1e0c          	ldw	x,(OFST+5,sp)
4857  0c49 2603cc0bc4    	jreq	L613
4860                     ; 1231       if (*pBuffer == 'S') pSocket->nState = STATE_POST_POS;
4862  0c4e 1e08          	ldw	x,(OFST+1,sp)
4863  0c50 f6            	ld	a,(x)
4864  0c51 a153          	cp	a,#83
4865  0c53 2605          	jrne	L7341
4868  0c55 1e0e          	ldw	x,(OFST+7,sp)
4869  0c57 a606          	ld	a,#6
4870  0c59 f7            	ld	(x),a
4871  0c5a               L7341:
4872                     ; 1232       nBytes--;
4874  0c5a 1e0c          	ldw	x,(OFST+5,sp)
4875  0c5c 5a            	decw	x
4876  0c5d 1f0c          	ldw	(OFST+5,sp),x
4877                     ; 1233       pBuffer++;
4879  0c5f 1e08          	ldw	x,(OFST+1,sp)
4880  0c61 5c            	incw	x
4881  0c62 1f08          	ldw	(OFST+1,sp),x
4882  0c64 1e0e          	ldw	x,(OFST+7,sp)
4883  0c66 f6            	ld	a,(x)
4884  0c67               L3341:
4885                     ; 1236     if (pSocket->nState == STATE_POST_POS) {
4887  0c67 a106          	cp	a,#6
4888  0c69 261d          	jrne	L1441
4889                     ; 1237       if (nBytes == 0) return;
4891  0c6b 1e0c          	ldw	x,(OFST+5,sp)
4892  0c6d 27dc          	jreq	L613
4895                     ; 1238       if (*pBuffer == 'T') pSocket->nState = STATE_POST_POST;
4897  0c6f 1e08          	ldw	x,(OFST+1,sp)
4898  0c71 f6            	ld	a,(x)
4899  0c72 a154          	cp	a,#84
4900  0c74 2605          	jrne	L5441
4903  0c76 1e0e          	ldw	x,(OFST+7,sp)
4904  0c78 a607          	ld	a,#7
4905  0c7a f7            	ld	(x),a
4906  0c7b               L5441:
4907                     ; 1239       nBytes--;
4909  0c7b 1e0c          	ldw	x,(OFST+5,sp)
4910  0c7d 5a            	decw	x
4911  0c7e 1f0c          	ldw	(OFST+5,sp),x
4912                     ; 1240       pBuffer++;
4914  0c80 1e08          	ldw	x,(OFST+1,sp)
4915  0c82 5c            	incw	x
4916  0c83 1f08          	ldw	(OFST+1,sp),x
4917  0c85 1e0e          	ldw	x,(OFST+7,sp)
4918  0c87 f6            	ld	a,(x)
4919  0c88               L1441:
4920                     ; 1243     if (pSocket->nState == STATE_POST_POST) {
4922  0c88 a107          	cp	a,#7
4923  0c8a 261d          	jrne	L7441
4924                     ; 1244       if (nBytes == 0) return;
4926  0c8c 1e0c          	ldw	x,(OFST+5,sp)
4927  0c8e 27bb          	jreq	L613
4930                     ; 1245       if (*pBuffer == ' ') pSocket->nState = STATE_GOTPOST;
4932  0c90 1e08          	ldw	x,(OFST+1,sp)
4933  0c92 f6            	ld	a,(x)
4934  0c93 a120          	cp	a,#32
4935  0c95 2605          	jrne	L3541
4938  0c97 1e0e          	ldw	x,(OFST+7,sp)
4939  0c99 a609          	ld	a,#9
4940  0c9b f7            	ld	(x),a
4941  0c9c               L3541:
4942                     ; 1246       nBytes--;
4944  0c9c 1e0c          	ldw	x,(OFST+5,sp)
4945  0c9e 5a            	decw	x
4946  0c9f 1f0c          	ldw	(OFST+5,sp),x
4947                     ; 1247       pBuffer++;
4949  0ca1 1e08          	ldw	x,(OFST+1,sp)
4950  0ca3 5c            	incw	x
4951  0ca4 1f08          	ldw	(OFST+1,sp),x
4952  0ca6 1e0e          	ldw	x,(OFST+7,sp)
4953  0ca8 f6            	ld	a,(x)
4954  0ca9               L7441:
4955                     ; 1250     if (pSocket->nState == STATE_GOTPOST) {
4957  0ca9 a109          	cp	a,#9
4958  0cab 264c          	jrne	L5541
4960  0cad 2046          	jra	L1641
4961  0caf               L7541:
4962                     ; 1253         if (*pBuffer == '\n') {
4964  0caf 1e08          	ldw	x,(OFST+1,sp)
4965  0cb1 f6            	ld	a,(x)
4966  0cb2 a10a          	cp	a,#10
4967  0cb4 2606          	jrne	L5641
4968                     ; 1254           pSocket->nNewlines++;
4970  0cb6 1e0e          	ldw	x,(OFST+7,sp)
4971  0cb8 6c05          	inc	(5,x)
4973  0cba 2008          	jra	L7641
4974  0cbc               L5641:
4975                     ; 1256         else if (*pBuffer == '\r') {
4977  0cbc a10d          	cp	a,#13
4978  0cbe 2704          	jreq	L7641
4980                     ; 1259           pSocket->nNewlines = 0;
4982  0cc0 1e0e          	ldw	x,(OFST+7,sp)
4983  0cc2 6f05          	clr	(5,x)
4984  0cc4               L7641:
4985                     ; 1261         pBuffer++;
4987  0cc4 1e08          	ldw	x,(OFST+1,sp)
4988  0cc6 5c            	incw	x
4989  0cc7 1f08          	ldw	(OFST+1,sp),x
4990                     ; 1262         nBytes--;
4992  0cc9 1e0c          	ldw	x,(OFST+5,sp)
4993  0ccb 5a            	decw	x
4994  0ccc 1f0c          	ldw	(OFST+5,sp),x
4995                     ; 1263         if (pSocket->nNewlines == 2) {
4997  0cce 1e0e          	ldw	x,(OFST+7,sp)
4998  0cd0 e605          	ld	a,(5,x)
4999  0cd2 a102          	cp	a,#2
5000  0cd4 261f          	jrne	L1641
5001                     ; 1265           if (pSocket->nState == STATE_GOTPOST) {
5003  0cd6 f6            	ld	a,(x)
5004  0cd7 a109          	cp	a,#9
5005  0cd9 261e          	jrne	L5541
5006                     ; 1267             if(current_webpage == WEBPAGE_DEFAULT) pSocket->nParseLeft = PARSEBYTES_DEFAULT;
5008  0cdb c6000b        	ld	a,_current_webpage
5009  0cde 2607          	jrne	L1051
5012  0ce0 a67e          	ld	a,#126
5013  0ce2 e706          	ld	(6,x),a
5014  0ce4 c6000b        	ld	a,_current_webpage
5015  0ce7               L1051:
5016                     ; 1268             if(current_webpage == WEBPAGE_ADDRESS) pSocket->nParseLeft = PARSEBYTES_ADDRESS;
5018  0ce7 4a            	dec	a
5019  0ce8 2604          	jrne	L3051
5022  0cea a693          	ld	a,#147
5023  0cec e706          	ld	(6,x),a
5024  0cee               L3051:
5025                     ; 1269             pSocket->ParseState = PARSE_CMD;
5027  0cee 6f09          	clr	(9,x)
5028                     ; 1271             pSocket->nState = STATE_PARSEPOST;
5030  0cf0 a60a          	ld	a,#10
5031  0cf2 f7            	ld	(x),a
5032  0cf3 2004          	jra	L5541
5033  0cf5               L1641:
5034                     ; 1252       while (nBytes != 0) {
5036  0cf5 1e0c          	ldw	x,(OFST+5,sp)
5037  0cf7 26b6          	jrne	L7541
5038  0cf9               L5541:
5039                     ; 1278     if (pSocket->nState == STATE_GOTGET) {
5041  0cf9 1e0e          	ldw	x,(OFST+7,sp)
5042  0cfb f6            	ld	a,(x)
5043  0cfc a108          	cp	a,#8
5044  0cfe 2609          	jrne	L5051
5045                     ; 1281       pSocket->nParseLeft = 6; // Small parse number since we should have short
5047  0d00 a606          	ld	a,#6
5048  0d02 e706          	ld	(6,x),a
5049                     ; 1283       pSocket->ParseState = PARSE_SLASH1;
5051  0d04 e709          	ld	(9,x),a
5052                     ; 1285       pSocket->nState = STATE_PARSEGET;
5054  0d06 a60d          	ld	a,#13
5055  0d08 f7            	ld	(x),a
5056  0d09               L5051:
5057                     ; 1288     if (pSocket->nState == STATE_PARSEPOST) {
5059  0d09 a10a          	cp	a,#10
5060  0d0b 2703cc0f7b    	jrne	L7051
5062  0d10 cc0f6c        	jra	L3151
5063  0d13               L1151:
5064                     ; 1298         if (pSocket->ParseState == PARSE_CMD) {
5066  0d13 1e0e          	ldw	x,(OFST+7,sp)
5067  0d15 e609          	ld	a,(9,x)
5068  0d17 263e          	jrne	L7151
5069                     ; 1299           pSocket->ParseCmd = *pBuffer;
5071  0d19 1e08          	ldw	x,(OFST+1,sp)
5072  0d1b f6            	ld	a,(x)
5073  0d1c 1e0e          	ldw	x,(OFST+7,sp)
5074  0d1e e707          	ld	(7,x),a
5075                     ; 1300           pSocket->ParseState = PARSE_NUM10;
5077  0d20 a601          	ld	a,#1
5078  0d22 e709          	ld	(9,x),a
5079                     ; 1301 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5081  0d24 e606          	ld	a,(6,x)
5082  0d26 2704          	jreq	L1251
5085  0d28 6a06          	dec	(6,x)
5087  0d2a 2004          	jra	L3251
5088  0d2c               L1251:
5089                     ; 1302 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5091  0d2c a605          	ld	a,#5
5092  0d2e e709          	ld	(9,x),a
5093  0d30               L3251:
5094                     ; 1303           pBuffer++;
5096  0d30 1e08          	ldw	x,(OFST+1,sp)
5097  0d32 5c            	incw	x
5098  0d33 1f08          	ldw	(OFST+1,sp),x
5099                     ; 1305 	  if (pSocket->ParseCmd == 'o' ||
5099                     ; 1306 	      pSocket->ParseCmd == 'a' ||
5099                     ; 1307 	      pSocket->ParseCmd == 'b' ||
5099                     ; 1308 	      pSocket->ParseCmd == 'c' ||
5099                     ; 1309 	      pSocket->ParseCmd == 'd' ||
5099                     ; 1310 	      pSocket->ParseCmd == 'g') { }
5101  0d35 1e0e          	ldw	x,(OFST+7,sp)
5102  0d37 e607          	ld	a,(7,x)
5103  0d39 a16f          	cp	a,#111
5104  0d3b 2603cc0f5e    	jreq	L3451
5106  0d40 a161          	cp	a,#97
5107  0d42 27f9          	jreq	L3451
5109  0d44 a162          	cp	a,#98
5110  0d46 27f5          	jreq	L3451
5112  0d48 a163          	cp	a,#99
5113  0d4a 27f1          	jreq	L3451
5115  0d4c a164          	cp	a,#100
5116  0d4e 27ed          	jreq	L3451
5118  0d50 a167          	cp	a,#103
5119  0d52 27e9          	jreq	L3451
5120                     ; 1311 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5121  0d54 cc0f43        	jp	LC018
5122  0d57               L7151:
5123                     ; 1313         else if (pSocket->ParseState == PARSE_NUM10) {
5125  0d57 a101          	cp	a,#1
5126  0d59 2619          	jrne	L5451
5127                     ; 1314           pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5129  0d5b 1e08          	ldw	x,(OFST+1,sp)
5130  0d5d f6            	ld	a,(x)
5131  0d5e 97            	ld	xl,a
5132  0d5f a60a          	ld	a,#10
5133  0d61 42            	mul	x,a
5134  0d62 9f            	ld	a,xl
5135  0d63 1e0e          	ldw	x,(OFST+7,sp)
5136  0d65 a0e0          	sub	a,#224
5137  0d67 e708          	ld	(8,x),a
5138                     ; 1315           pSocket->ParseState = PARSE_NUM1;
5140  0d69 a602          	ld	a,#2
5141  0d6b e709          	ld	(9,x),a
5142                     ; 1316 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5144  0d6d e606          	ld	a,(6,x)
5145  0d6f 2719          	jreq	L7551
5148  0d71 cc0f53        	jp	LC025
5149                     ; 1317 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5150                     ; 1318           pBuffer++;
5152  0d74               L5451:
5153                     ; 1320         else if (pSocket->ParseState == PARSE_NUM1) {
5155  0d74 a102          	cp	a,#2
5156  0d76 2616          	jrne	L5551
5157                     ; 1321           pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5159  0d78 1608          	ldw	y,(OFST+1,sp)
5160  0d7a 90f6          	ld	a,(y)
5161  0d7c a030          	sub	a,#48
5162  0d7e eb08          	add	a,(8,x)
5163  0d80 e708          	ld	(8,x),a
5164                     ; 1322           pSocket->ParseState = PARSE_EQUAL;
5166  0d82 a603          	ld	a,#3
5167  0d84 e709          	ld	(9,x),a
5168                     ; 1323 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5170  0d86 e606          	ld	a,(6,x)
5173  0d88 26e7          	jrne	LC025
5174  0d8a               L7551:
5175                     ; 1324 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5178  0d8a a605          	ld	a,#5
5179                     ; 1325           pBuffer++;
5181  0d8c 200d          	jp	LC026
5182  0d8e               L5551:
5183                     ; 1327         else if (pSocket->ParseState == PARSE_EQUAL) {
5185  0d8e a103          	cp	a,#3
5186  0d90 260e          	jrne	L5651
5187                     ; 1328           pSocket->ParseState = PARSE_VAL;
5189  0d92 a604          	ld	a,#4
5190  0d94 e709          	ld	(9,x),a
5191                     ; 1329 	  if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5193  0d96 6d06          	tnz	(6,x)
5196  0d98 26d7          	jrne	LC025
5197                     ; 1330 	  else { pSocket->ParseState = PARSE_DELIM; } // Something out of sync - escape
5199  0d9a 4c            	inc	a
5200  0d9b               LC026:
5201  0d9b e709          	ld	(9,x),a
5202                     ; 1331           pBuffer++;
5204  0d9d cc0f55        	jp	LC017
5205  0da0               L5651:
5206                     ; 1333         else if (pSocket->ParseState == PARSE_VAL) {
5208  0da0 a104          	cp	a,#4
5209  0da2 2703cc0f49    	jrne	L5751
5210                     ; 1341           if (pSocket->ParseCmd == 'o') {
5212  0da7 e607          	ld	a,(7,x)
5213  0da9 a16f          	cp	a,#111
5214  0dab 2625          	jrne	L7751
5215                     ; 1344             if ((uint8_t)(*pBuffer) == '1') GpioSetPin(pSocket->ParseNum, (uint8_t)1);
5217  0dad 1e08          	ldw	x,(OFST+1,sp)
5218  0daf f6            	ld	a,(x)
5219  0db0 a131          	cp	a,#49
5220  0db2 2609          	jrne	L1061
5223  0db4 1e0e          	ldw	x,(OFST+7,sp)
5224  0db6 e608          	ld	a,(8,x)
5225  0db8 ae0001        	ldw	x,#1
5228  0dbb 2005          	jra	L3061
5229  0dbd               L1061:
5230                     ; 1345             else GpioSetPin(pSocket->ParseNum, (uint8_t)0);
5232  0dbd 1e0e          	ldw	x,(OFST+7,sp)
5233  0dbf e608          	ld	a,(8,x)
5234  0dc1 5f            	clrw	x
5236  0dc2               L3061:
5237  0dc2 95            	ld	xh,a
5238  0dc3 cd13e2        	call	_GpioSetPin
5239                     ; 1346 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--; // Prevent underflow
5241  0dc6 1e0e          	ldw	x,(OFST+7,sp)
5242  0dc8 e606          	ld	a,(6,x)
5243  0dca 2603cc0f3c    	jreq	L5561
5245                     ; 1347             pBuffer++;
5247  0dcf cc0f3a        	jp	LC024
5248  0dd2               L7751:
5249                     ; 1350           else if (pSocket->ParseCmd == 'a') {
5251  0dd2 a161          	cp	a,#97
5252  0dd4 2656          	jrne	L1161
5253                     ; 1360             ex_stored_devicename[0] = (uint8_t)(*pBuffer);
5255  0dd6 1e08          	ldw	x,(OFST+1,sp)
5256  0dd8 f6            	ld	a,(x)
5257  0dd9 c70000        	ld	_ex_stored_devicename,a
5258                     ; 1361             pSocket->nParseLeft--;
5260  0ddc 1e0e          	ldw	x,(OFST+7,sp)
5261  0dde 6a06          	dec	(6,x)
5262                     ; 1362             pBuffer++; // nBytes already decremented for first char
5264  0de0 1e08          	ldw	x,(OFST+1,sp)
5265  0de2 5c            	incw	x
5266  0de3 1f08          	ldw	(OFST+1,sp),x
5267                     ; 1366 	    amp_found = 0;
5269  0de5 0f06          	clr	(OFST-1,sp)
5271                     ; 1367 	    for(i=1; i<20; i++) {
5273  0de7 a601          	ld	a,#1
5274  0de9 6b07          	ld	(OFST+0,sp),a
5276  0deb               L3161:
5277                     ; 1368 	      if((uint8_t)(*pBuffer) == 38) amp_found = 1;
5279  0deb 1e08          	ldw	x,(OFST+1,sp)
5280  0ded f6            	ld	a,(x)
5281  0dee a126          	cp	a,#38
5282  0df0 2604          	jrne	L1261
5285  0df2 a601          	ld	a,#1
5286  0df4 6b06          	ld	(OFST-1,sp),a
5288  0df6               L1261:
5289                     ; 1369 	      if(amp_found == 0) {
5291  0df6 7b06          	ld	a,(OFST-1,sp)
5292  0df8 261a          	jrne	L3261
5293                     ; 1371                 ex_stored_devicename[i] = (uint8_t)(*pBuffer);
5295  0dfa 7b07          	ld	a,(OFST+0,sp)
5296  0dfc 5f            	clrw	x
5297  0dfd 1608          	ldw	y,(OFST+1,sp)
5298  0dff 97            	ld	xl,a
5299  0e00 90f6          	ld	a,(y)
5300  0e02 d70000        	ld	(_ex_stored_devicename,x),a
5301                     ; 1372                 pSocket->nParseLeft--;
5303  0e05 1e0e          	ldw	x,(OFST+7,sp)
5304  0e07 6a06          	dec	(6,x)
5305                     ; 1373                 pBuffer++;
5307  0e09 93            	ldw	x,y
5308  0e0a 5c            	incw	x
5309  0e0b 1f08          	ldw	(OFST+1,sp),x
5310                     ; 1374                 nBytes--; // Must subtract 1 from nBytes for extra byte read
5312  0e0d 1e0c          	ldw	x,(OFST+5,sp)
5313  0e0f 5a            	decw	x
5314  0e10 1f0c          	ldw	(OFST+5,sp),x
5316  0e12 200d          	jra	L5261
5317  0e14               L3261:
5318                     ; 1378 	        ex_stored_devicename[i] = ' ';
5320  0e14 7b07          	ld	a,(OFST+0,sp)
5321  0e16 5f            	clrw	x
5322  0e17 97            	ld	xl,a
5323  0e18 a620          	ld	a,#32
5324  0e1a d70000        	ld	(_ex_stored_devicename,x),a
5325                     ; 1387                 pSocket->nParseLeft--;
5327  0e1d 1e0e          	ldw	x,(OFST+7,sp)
5328  0e1f 6a06          	dec	(6,x)
5329  0e21               L5261:
5330                     ; 1367 	    for(i=1; i<20; i++) {
5332  0e21 0c07          	inc	(OFST+0,sp)
5336  0e23 7b07          	ld	a,(OFST+0,sp)
5337  0e25 a114          	cp	a,#20
5338  0e27 25c2          	jrult	L3161
5340  0e29 cc0f41        	jra	L7061
5341  0e2c               L1161:
5342                     ; 1392           else if (pSocket->ParseCmd == 'b') {
5344  0e2c a162          	cp	a,#98
5345  0e2e 2646          	jrne	L1361
5346                     ; 1399 	    alpha_1 = '-';
5348                     ; 1400 	    alpha_2 = '-';
5350                     ; 1401 	    alpha_3 = '-';
5352                     ; 1403             alpha_1 = (uint8_t)(*pBuffer);
5354  0e30 1e08          	ldw	x,(OFST+1,sp)
5355  0e32 f6            	ld	a,(x)
5356  0e33 6b07          	ld	(OFST+0,sp),a
5358                     ; 1404             pSocket->nParseLeft--;
5360  0e35 1e0e          	ldw	x,(OFST+7,sp)
5361  0e37 6a06          	dec	(6,x)
5362                     ; 1405             pBuffer++; // nBytes already decremented for first char
5364  0e39 1e08          	ldw	x,(OFST+1,sp)
5365  0e3b 5c            	incw	x
5366  0e3c 1f08          	ldw	(OFST+1,sp),x
5367                     ; 1407 	    alpha_2 = (uint8_t)(*pBuffer);
5369  0e3e f6            	ld	a,(x)
5370  0e3f 6b05          	ld	(OFST-2,sp),a
5372                     ; 1408             pSocket->nParseLeft--;
5374  0e41 1e0e          	ldw	x,(OFST+7,sp)
5375  0e43 6a06          	dec	(6,x)
5376                     ; 1409             pBuffer++;
5378  0e45 1e08          	ldw	x,(OFST+1,sp)
5379  0e47 5c            	incw	x
5380  0e48 1f08          	ldw	(OFST+1,sp),x
5381                     ; 1410 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5383  0e4a 1e0c          	ldw	x,(OFST+5,sp)
5384  0e4c 5a            	decw	x
5385  0e4d 1f0c          	ldw	(OFST+5,sp),x
5386                     ; 1412 	    alpha_3 = (uint8_t)(*pBuffer);
5388  0e4f 1e08          	ldw	x,(OFST+1,sp)
5389  0e51 f6            	ld	a,(x)
5390  0e52 6b06          	ld	(OFST-1,sp),a
5392                     ; 1413             pSocket->nParseLeft--;
5394  0e54 1e0e          	ldw	x,(OFST+7,sp)
5395  0e56 6a06          	dec	(6,x)
5396                     ; 1414             pBuffer++;
5398  0e58 1e08          	ldw	x,(OFST+1,sp)
5399  0e5a 5c            	incw	x
5400  0e5b 1f08          	ldw	(OFST+1,sp),x
5401                     ; 1415 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5403  0e5d 1e0c          	ldw	x,(OFST+5,sp)
5404  0e5f 5a            	decw	x
5405  0e60 1f0c          	ldw	(OFST+5,sp),x
5406                     ; 1417 	    SetAddresses(pSocket->ParseNum, (uint8_t)alpha_1, (uint8_t)alpha_2, (uint8_t)alpha_3);
5408  0e62 88            	push	a
5409  0e63 7b06          	ld	a,(OFST-1,sp)
5410  0e65 88            	push	a
5411  0e66 7b09          	ld	a,(OFST+2,sp)
5412  0e68 1610          	ldw	y,(OFST+9,sp)
5413  0e6a 97            	ld	xl,a
5414  0e6b 90e608        	ld	a,(8,y)
5415  0e6e 95            	ld	xh,a
5416  0e6f cd150e        	call	_SetAddresses
5418  0e72 85            	popw	x
5420  0e73 cc0f41        	jra	L7061
5421  0e76               L1361:
5422                     ; 1420           else if (pSocket->ParseCmd == 'c') {
5424  0e76 a163          	cp	a,#99
5425  0e78 2672          	jrne	L5361
5426                     ; 1426 	    alpha_1 = '-';
5428                     ; 1427 	    alpha_2 = '-';
5430                     ; 1428 	    alpha_3 = '-';
5432                     ; 1429 	    alpha_4 = '-';
5434                     ; 1430 	    alpha_5 = '-';
5436                     ; 1433   	    alpha_1 = (uint8_t)(*pBuffer);
5438  0e7a 1e08          	ldw	x,(OFST+1,sp)
5439  0e7c f6            	ld	a,(x)
5440  0e7d 6b07          	ld	(OFST+0,sp),a
5442                     ; 1434             pSocket->nParseLeft--;
5444  0e7f 1e0e          	ldw	x,(OFST+7,sp)
5445  0e81 6a06          	dec	(6,x)
5446                     ; 1435             pBuffer++; // nBytes already decremented for first char
5448  0e83 1e08          	ldw	x,(OFST+1,sp)
5449  0e85 5c            	incw	x
5450  0e86 1f08          	ldw	(OFST+1,sp),x
5451                     ; 1437 	    alpha_2 = (uint8_t)(*pBuffer);
5453  0e88 f6            	ld	a,(x)
5454  0e89 6b05          	ld	(OFST-2,sp),a
5456                     ; 1438             pSocket->nParseLeft--;
5458  0e8b 1e0e          	ldw	x,(OFST+7,sp)
5459  0e8d 6a06          	dec	(6,x)
5460                     ; 1439             pBuffer++;
5462  0e8f 1e08          	ldw	x,(OFST+1,sp)
5463  0e91 5c            	incw	x
5464  0e92 1f08          	ldw	(OFST+1,sp),x
5465                     ; 1440 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5467  0e94 1e0c          	ldw	x,(OFST+5,sp)
5468  0e96 5a            	decw	x
5469  0e97 1f0c          	ldw	(OFST+5,sp),x
5470                     ; 1442 	    alpha_3 = (uint8_t)(*pBuffer);
5472  0e99 1e08          	ldw	x,(OFST+1,sp)
5473  0e9b f6            	ld	a,(x)
5474  0e9c 6b06          	ld	(OFST-1,sp),a
5476                     ; 1443             pSocket->nParseLeft--;
5478  0e9e 1e0e          	ldw	x,(OFST+7,sp)
5479  0ea0 6a06          	dec	(6,x)
5480                     ; 1444             pBuffer++;
5482  0ea2 1e08          	ldw	x,(OFST+1,sp)
5483  0ea4 5c            	incw	x
5484  0ea5 1f08          	ldw	(OFST+1,sp),x
5485                     ; 1445 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5487  0ea7 1e0c          	ldw	x,(OFST+5,sp)
5488  0ea9 5a            	decw	x
5489  0eaa 1f0c          	ldw	(OFST+5,sp),x
5490                     ; 1447 	    alpha_4 = (uint8_t)(*pBuffer);
5492  0eac 1e08          	ldw	x,(OFST+1,sp)
5493  0eae f6            	ld	a,(x)
5494  0eaf 6b03          	ld	(OFST-4,sp),a
5496                     ; 1448             pSocket->nParseLeft--;
5498  0eb1 1e0e          	ldw	x,(OFST+7,sp)
5499  0eb3 6a06          	dec	(6,x)
5500                     ; 1449             pBuffer++;
5502  0eb5 1e08          	ldw	x,(OFST+1,sp)
5503  0eb7 5c            	incw	x
5504  0eb8 1f08          	ldw	(OFST+1,sp),x
5505                     ; 1450 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5507  0eba 1e0c          	ldw	x,(OFST+5,sp)
5508  0ebc 5a            	decw	x
5509  0ebd 1f0c          	ldw	(OFST+5,sp),x
5510                     ; 1452             alpha_5 = (uint8_t)(*pBuffer);
5512  0ebf 1e08          	ldw	x,(OFST+1,sp)
5513  0ec1 f6            	ld	a,(x)
5514  0ec2 6b04          	ld	(OFST-3,sp),a
5516                     ; 1453             pSocket->nParseLeft--;
5518  0ec4 1e0e          	ldw	x,(OFST+7,sp)
5519  0ec6 6a06          	dec	(6,x)
5520                     ; 1454             pBuffer++;
5522  0ec8 1e08          	ldw	x,(OFST+1,sp)
5523  0eca 5c            	incw	x
5524  0ecb 1f08          	ldw	(OFST+1,sp),x
5525                     ; 1455 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5527  0ecd 1e0c          	ldw	x,(OFST+5,sp)
5528  0ecf 5a            	decw	x
5529  0ed0 1f0c          	ldw	(OFST+5,sp),x
5530                     ; 1457 	    SetPort(pSocket->ParseNum,
5530                     ; 1458 	            (uint8_t)alpha_1,
5530                     ; 1459 		    (uint8_t)alpha_2,
5530                     ; 1460 		    (uint8_t)alpha_3,
5530                     ; 1461 		    (uint8_t)alpha_4,
5530                     ; 1462 		    (uint8_t)alpha_5);
5532  0ed2 88            	push	a
5533  0ed3 7b04          	ld	a,(OFST-3,sp)
5534  0ed5 88            	push	a
5535  0ed6 7b08          	ld	a,(OFST+1,sp)
5536  0ed8 88            	push	a
5537  0ed9 7b08          	ld	a,(OFST+1,sp)
5538  0edb 88            	push	a
5539  0edc 7b0b          	ld	a,(OFST+4,sp)
5540  0ede 1612          	ldw	y,(OFST+11,sp)
5541  0ee0 97            	ld	xl,a
5542  0ee1 90e608        	ld	a,(8,y)
5543  0ee4 95            	ld	xh,a
5544  0ee5 cd1598        	call	_SetPort
5546  0ee8 5b04          	addw	sp,#4
5548  0eea 2055          	jra	L7061
5549  0eec               L5361:
5550                     ; 1465           else if (pSocket->ParseCmd == 'd') {
5552  0eec a164          	cp	a,#100
5553  0eee 262f          	jrne	L1461
5554                     ; 1471 	    alpha_1 = (uint8_t)(*pBuffer);
5556  0ef0 1e08          	ldw	x,(OFST+1,sp)
5557  0ef2 f6            	ld	a,(x)
5558  0ef3 6b07          	ld	(OFST+0,sp),a
5560                     ; 1472             pSocket->nParseLeft--;
5562  0ef5 1e0e          	ldw	x,(OFST+7,sp)
5563  0ef7 6a06          	dec	(6,x)
5564                     ; 1473             pBuffer++; // nBytes already decremented for first char
5566  0ef9 1e08          	ldw	x,(OFST+1,sp)
5567  0efb 5c            	incw	x
5568  0efc 1f08          	ldw	(OFST+1,sp),x
5569                     ; 1475 	    alpha_2 = (uint8_t)(*pBuffer);
5571  0efe f6            	ld	a,(x)
5572  0eff 6b05          	ld	(OFST-2,sp),a
5574                     ; 1476             pSocket->nParseLeft--;
5576  0f01 1e0e          	ldw	x,(OFST+7,sp)
5577  0f03 6a06          	dec	(6,x)
5578                     ; 1477             pBuffer++;
5580  0f05 1e08          	ldw	x,(OFST+1,sp)
5581  0f07 5c            	incw	x
5582  0f08 1f08          	ldw	(OFST+1,sp),x
5583                     ; 1478 	    nBytes--; // Must subtract 1 from nBytes for extra byte read
5585  0f0a 1e0c          	ldw	x,(OFST+5,sp)
5586  0f0c 5a            	decw	x
5587  0f0d 1f0c          	ldw	(OFST+5,sp),x
5588                     ; 1480 	    SetMAC(pSocket->ParseNum, alpha_1, alpha_2);
5590  0f0f 88            	push	a
5591  0f10 7b08          	ld	a,(OFST+1,sp)
5592  0f12 160f          	ldw	y,(OFST+8,sp)
5593  0f14 97            	ld	xl,a
5594  0f15 90e608        	ld	a,(8,y)
5595  0f18 95            	ld	xh,a
5596  0f19 cd15d3        	call	_SetMAC
5598  0f1c 84            	pop	a
5600  0f1d 2022          	jra	L7061
5601  0f1f               L1461:
5602                     ; 1483 	  else if (pSocket->ParseCmd == 'g') {
5604  0f1f a167          	cp	a,#103
5605  0f21 261e          	jrne	L7061
5606                     ; 1486             if ((uint8_t)(*pBuffer) == '1') invert_output = 1;
5608  0f23 1e08          	ldw	x,(OFST+1,sp)
5609  0f25 f6            	ld	a,(x)
5610  0f26 a131          	cp	a,#49
5611  0f28 2606          	jrne	L7461
5614  0f2a 35010000      	mov	_invert_output,#1
5616  0f2e 2004          	jra	L1561
5617  0f30               L7461:
5618                     ; 1487             else invert_output = 0;
5620  0f30 725f0000      	clr	_invert_output
5621  0f34               L1561:
5622                     ; 1488 	    if (pSocket->nParseLeft > 0) pSocket->nParseLeft--;
5624  0f34 1e0e          	ldw	x,(OFST+7,sp)
5625  0f36 e606          	ld	a,(6,x)
5626  0f38 2702          	jreq	L5561
5629  0f3a               LC024:
5631  0f3a 6a06          	dec	(6,x)
5633  0f3c               L5561:
5634                     ; 1490             pBuffer++;
5637  0f3c 1e08          	ldw	x,(OFST+1,sp)
5638  0f3e 5c            	incw	x
5639  0f3f 1f08          	ldw	(OFST+1,sp),x
5640  0f41               L7061:
5641                     ; 1493           pSocket->ParseState = PARSE_DELIM;
5643  0f41 1e0e          	ldw	x,(OFST+7,sp)
5644  0f43               LC018:
5646  0f43 a605          	ld	a,#5
5647  0f45 e709          	ld	(9,x),a
5649  0f47 2015          	jra	L3451
5650  0f49               L5751:
5651                     ; 1496         else if (pSocket->ParseState == PARSE_DELIM) {
5653  0f49 a105          	cp	a,#5
5654  0f4b 2611          	jrne	L3451
5655                     ; 1497           if(pSocket->nParseLeft > 0) {
5657  0f4d e606          	ld	a,(6,x)
5658  0f4f 270b          	jreq	L3661
5659                     ; 1498             pSocket->ParseState = PARSE_CMD;
5661  0f51 6f09          	clr	(9,x)
5662                     ; 1499             pSocket->nParseLeft--;
5664  0f53               LC025:
5668  0f53 6a06          	dec	(6,x)
5669                     ; 1500             pBuffer++;
5671  0f55               LC017:
5675  0f55 1e08          	ldw	x,(OFST+1,sp)
5676  0f57 5c            	incw	x
5677  0f58 1f08          	ldw	(OFST+1,sp),x
5679  0f5a 2002          	jra	L3451
5680  0f5c               L3661:
5681                     ; 1503             pSocket->nParseLeft = 0; // Something out of sync - end the parsing
5683  0f5c e706          	ld	(6,x),a
5684  0f5e               L3451:
5685                     ; 1507         if (pSocket->nParseLeft == 0) {
5687  0f5e 1e0e          	ldw	x,(OFST+7,sp)
5688  0f60 e606          	ld	a,(6,x)
5689  0f62 2608          	jrne	L3151
5690                     ; 1509           pSocket->nState = STATE_SENDHEADER;
5692  0f64 a60b          	ld	a,#11
5693  0f66 f7            	ld	(x),a
5694                     ; 1510           break;
5695  0f67               L5151:
5696                     ; 1514       pSocket->nState = STATE_SENDHEADER;
5698  0f67 1e0e          	ldw	x,(OFST+7,sp)
5699  0f69 f7            	ld	(x),a
5700  0f6a 200f          	jra	L7051
5701  0f6c               L3151:
5702                     ; 1297       while (nBytes--) {
5704  0f6c 1e0c          	ldw	x,(OFST+5,sp)
5705  0f6e 5a            	decw	x
5706  0f6f 1f0c          	ldw	(OFST+5,sp),x
5707  0f71 5c            	incw	x
5708  0f72 2703cc0d13    	jrne	L1151
5709  0f77 a60b          	ld	a,#11
5710  0f79 20ec          	jra	L5151
5711  0f7b               L7051:
5712                     ; 1517     if (pSocket->nState == STATE_PARSEGET) {
5714  0f7b a10d          	cp	a,#13
5715  0f7d 2703cc122e    	jrne	L1761
5717  0f82 cc1223        	jra	L5761
5718  0f85               L3761:
5719                     ; 1531         if (pSocket->ParseState == PARSE_SLASH1) {
5721  0f85 1e0e          	ldw	x,(OFST+7,sp)
5722  0f87 e609          	ld	a,(9,x)
5723  0f89 a106          	cp	a,#6
5724  0f8b 263e          	jrne	L1071
5725                     ; 1534           pSocket->ParseCmd = *pBuffer;
5727  0f8d 1e08          	ldw	x,(OFST+1,sp)
5728  0f8f f6            	ld	a,(x)
5729  0f90 1e0e          	ldw	x,(OFST+7,sp)
5730  0f92 e707          	ld	(7,x),a
5731                     ; 1535           pSocket->nParseLeft--;
5733  0f94 6a06          	dec	(6,x)
5734                     ; 1536           pBuffer++;
5736  0f96 1e08          	ldw	x,(OFST+1,sp)
5737  0f98 5c            	incw	x
5738  0f99 1f08          	ldw	(OFST+1,sp),x
5739                     ; 1537 	  if (pSocket->ParseCmd == (uint8_t)0x2f) { // Compare to '/'
5741  0f9b 1e0e          	ldw	x,(OFST+7,sp)
5742  0f9d e607          	ld	a,(7,x)
5743  0f9f a12f          	cp	a,#47
5744  0fa1 2604          	jrne	L3071
5745                     ; 1538 	    pSocket->ParseState = PARSE_NUM10;
5747  0fa3 a601          	ld	a,#1
5748  0fa5 e709          	ld	(9,x),a
5749  0fa7               L3071:
5750                     ; 1540 	  if (pSocket->nParseLeft == 0) {
5752  0fa7 e606          	ld	a,(6,x)
5753  0fa9 2703cc1201    	jrne	L7071
5754                     ; 1542 	    current_webpage = WEBPAGE_DEFAULT;
5756  0fae c7000b        	ld	_current_webpage,a
5757                     ; 1543             pSocket->pData = g_HtmlPageDefault;
5759  0fb1 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5760  0fb5 ef01          	ldw	(1,x),y
5761                     ; 1544             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5763  0fb7 90ae15d5      	ldw	y,#5589
5764  0fbb ef03          	ldw	(3,x),y
5765                     ; 1545             pSocket->nNewlines = 0;
5767  0fbd e705          	ld	(5,x),a
5768                     ; 1546             pSocket->nState = STATE_SENDHEADER;
5770  0fbf a60b          	ld	a,#11
5771  0fc1 f7            	ld	(x),a
5772                     ; 1547             pSocket->nPrevBytes = 0xFFFF;
5774  0fc2 90aeffff      	ldw	y,#65535
5775  0fc6 ef0a          	ldw	(10,x),y
5776                     ; 1548             break;
5778  0fc8 cc122e        	jra	L1761
5779  0fcb               L1071:
5780                     ; 1551         else if (pSocket->ParseState == PARSE_NUM10) {
5782  0fcb a101          	cp	a,#1
5783  0fcd 264e          	jrne	L1171
5784                     ; 1556 	  if(*pBuffer == ' ') {
5786  0fcf 1e08          	ldw	x,(OFST+1,sp)
5787  0fd1 f6            	ld	a,(x)
5788  0fd2 a120          	cp	a,#32
5789  0fd4 2620          	jrne	L3171
5790                     ; 1557 	    current_webpage = WEBPAGE_DEFAULT;
5792  0fd6 725f000b      	clr	_current_webpage
5793                     ; 1558             pSocket->pData = g_HtmlPageDefault;
5795  0fda 1e0e          	ldw	x,(OFST+7,sp)
5796  0fdc 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
5797  0fe0 ef01          	ldw	(1,x),y
5798                     ; 1559             pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
5800  0fe2 90ae15d5      	ldw	y,#5589
5801  0fe6 ef03          	ldw	(3,x),y
5802                     ; 1560             pSocket->nNewlines = 0;
5804  0fe8 6f05          	clr	(5,x)
5805                     ; 1561             pSocket->nState = STATE_SENDHEADER;
5807  0fea a60b          	ld	a,#11
5808  0fec f7            	ld	(x),a
5809                     ; 1562             pSocket->nPrevBytes = 0xFFFF;
5811  0fed 90aeffff      	ldw	y,#65535
5812  0ff1 ef0a          	ldw	(10,x),y
5813                     ; 1563 	    break;
5815  0ff3 cc122e        	jra	L1761
5816  0ff6               L3171:
5817                     ; 1566 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5819  0ff6 a130          	cp	a,#48
5820  0ff8 2504          	jrult	L5171
5822  0ffa a13a          	cp	a,#58
5823  0ffc 2506          	jrult	L7171
5825  0ffe               L5171:
5826                     ; 1567 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5828  0ffe 1e0e          	ldw	x,(OFST+7,sp)
5829  1000 a605          	ld	a,#5
5830  1002 e709          	ld	(9,x),a
5831  1004               L7171:
5832                     ; 1568           if (pSocket->ParseState == PARSE_NUM10) {      // Still good - parse number
5834  1004 1e0e          	ldw	x,(OFST+7,sp)
5835  1006 e609          	ld	a,(9,x)
5836  1008 4a            	dec	a
5837  1009 26a0          	jrne	L7071
5838                     ; 1569             pSocket->ParseNum = (uint8_t)((*pBuffer - '0') * 10);
5840  100b 1e08          	ldw	x,(OFST+1,sp)
5841  100d f6            	ld	a,(x)
5842  100e 97            	ld	xl,a
5843  100f a60a          	ld	a,#10
5844  1011 42            	mul	x,a
5845  1012 9f            	ld	a,xl
5846  1013 1e0e          	ldw	x,(OFST+7,sp)
5847  1015 a0e0          	sub	a,#224
5848  1017 e708          	ld	(8,x),a
5849                     ; 1570 	    pSocket->ParseState = PARSE_NUM1;
5851  1019 a602          	ld	a,#2
5852                     ; 1571             pSocket->nParseLeft--;
5853                     ; 1572             pBuffer++;
5854  101b 202c          	jp	LC022
5855  101d               L1171:
5856                     ; 1576         else if (pSocket->ParseState == PARSE_NUM1) {
5858  101d a102          	cp	a,#2
5859  101f 2634          	jrne	L5271
5860                     ; 1577 	  if (*pBuffer >= '0' && *pBuffer <= '9') { }    // Check for errors - if a digit we're good
5862  1021 1e08          	ldw	x,(OFST+1,sp)
5863  1023 f6            	ld	a,(x)
5864  1024 a130          	cp	a,#48
5865  1026 2504          	jrult	L7271
5867  1028 a13a          	cp	a,#58
5868  102a 2506          	jrult	L1371
5870  102c               L7271:
5871                     ; 1578 	  else { pSocket->ParseState = PARSE_DELIM; }    // Something out of sync - escape
5873  102c 1e0e          	ldw	x,(OFST+7,sp)
5874  102e a605          	ld	a,#5
5875  1030 e709          	ld	(9,x),a
5876  1032               L1371:
5877                     ; 1579           if (pSocket->ParseState == PARSE_NUM1) {       // Still good - parse number
5879  1032 1e0e          	ldw	x,(OFST+7,sp)
5880  1034 e609          	ld	a,(9,x)
5881  1036 a102          	cp	a,#2
5882  1038 2703cc1201    	jrne	L7071
5883                     ; 1580             pSocket->ParseNum += (uint8_t)(*pBuffer - '0');
5885  103d 1608          	ldw	y,(OFST+1,sp)
5886  103f 90f6          	ld	a,(y)
5887  1041 a030          	sub	a,#48
5888  1043 eb08          	add	a,(8,x)
5889  1045 e708          	ld	(8,x),a
5890                     ; 1581             pSocket->ParseState = PARSE_VAL;
5892  1047 a604          	ld	a,#4
5893                     ; 1582             pSocket->nParseLeft--;
5895                     ; 1583             pBuffer++;
5897  1049               LC022:
5898  1049 e709          	ld	(9,x),a
5900  104b 6a06          	dec	(6,x)
5902  104d 1e08          	ldw	x,(OFST+1,sp)
5903  104f 5c            	incw	x
5904  1050 1f08          	ldw	(OFST+1,sp),x
5905  1052 cc1201        	jra	L7071
5906  1055               L5271:
5907                     ; 1586         else if (pSocket->ParseState == PARSE_VAL) {
5909  1055 a104          	cp	a,#4
5910  1057 2703cc1209    	jrne	L7371
5911                     ; 1637           switch(pSocket->ParseNum)
5913  105c e608          	ld	a,(8,x)
5915                     ; 1761 	      break;
5916  105e a143          	cp	a,#67
5917  1060 2407          	jruge	L272
5918  1062 5f            	clrw	x
5919  1063 97            	ld	xl,a
5920  1064 58            	sllw	x
5921  1065 de3d9d        	ldw	x,(L472,x)
5922  1068 fc            	jp	(x)
5923  1069               L272:
5924  1069 a05b          	sub	a,#91
5925  106b 2603cc11c5    	jreq	L7221
5926  1070 a008          	sub	a,#8
5927  1072 2603cc11cb    	jreq	L1321
5928  1077 cc11e0        	jra	L3321
5929  107a               L7011:
5930                     ; 1639 	    case 0:  Relays_8to1 &= (uint8_t)(~0x01);  break; // Relay-01 OFF
5932  107a 72110000      	bres	_Relays_8to1,#0
5935  107e cc11fb        	jra	L3471
5936  1081               L1111:
5937                     ; 1640 	    case 1:  Relays_8to1 |= (uint8_t)0x01;     break; // Relay-01 ON
5939  1081 72100000      	bset	_Relays_8to1,#0
5942  1085 cc11fb        	jra	L3471
5943  1088               L3111:
5944                     ; 1641 	    case 2:  Relays_8to1 &= (uint8_t)(~0x02);  break; // Relay-02 OFF
5946  1088 72130000      	bres	_Relays_8to1,#1
5949  108c cc11fb        	jra	L3471
5950  108f               L5111:
5951                     ; 1642 	    case 3:  Relays_8to1 |= (uint8_t)0x02;     break; // Relay-02 ON
5953  108f 72120000      	bset	_Relays_8to1,#1
5956  1093 cc11fb        	jra	L3471
5957  1096               L7111:
5958                     ; 1643 	    case 4:  Relays_8to1 &= (uint8_t)(~0x04);  break; // Relay-03 OFF
5960  1096 72150000      	bres	_Relays_8to1,#2
5963  109a cc11fb        	jra	L3471
5964  109d               L1211:
5965                     ; 1644 	    case 5:  Relays_8to1 |= (uint8_t)0x04;     break; // Relay-03 ON
5967  109d 72140000      	bset	_Relays_8to1,#2
5970  10a1 cc11fb        	jra	L3471
5971  10a4               L3211:
5972                     ; 1645 	    case 6:  Relays_8to1 &= (uint8_t)(~0x08);  break; // Relay-04 OFF
5974  10a4 72170000      	bres	_Relays_8to1,#3
5977  10a8 cc11fb        	jra	L3471
5978  10ab               L5211:
5979                     ; 1646 	    case 7:  Relays_8to1 |= (uint8_t)0x08;     break; // Relay-04 ON
5981  10ab 72160000      	bset	_Relays_8to1,#3
5984  10af cc11fb        	jra	L3471
5985  10b2               L7211:
5986                     ; 1647 	    case 8:  Relays_8to1 &= (uint8_t)(~0x10);  break; // Relay-05 OFF
5988  10b2 72190000      	bres	_Relays_8to1,#4
5991  10b6 cc11fb        	jra	L3471
5992  10b9               L1311:
5993                     ; 1648 	    case 9:  Relays_8to1 |= (uint8_t)0x10;     break; // Relay-05 ON
5995  10b9 72180000      	bset	_Relays_8to1,#4
5998  10bd cc11fb        	jra	L3471
5999  10c0               L3311:
6000                     ; 1649 	    case 10: Relays_8to1 &= (uint8_t)(~0x20);  break; // Relay-06 OFF
6002  10c0 721b0000      	bres	_Relays_8to1,#5
6005  10c4 cc11fb        	jra	L3471
6006  10c7               L5311:
6007                     ; 1650 	    case 11: Relays_8to1 |= (uint8_t)0x20;     break; // Relay-06 ON
6009  10c7 721a0000      	bset	_Relays_8to1,#5
6012  10cb cc11fb        	jra	L3471
6013  10ce               L7311:
6014                     ; 1651 	    case 12: Relays_8to1 &= (uint8_t)(~0x40);  break; // Relay-07 OFF
6016  10ce 721d0000      	bres	_Relays_8to1,#6
6019  10d2 cc11fb        	jra	L3471
6020  10d5               L1411:
6021                     ; 1652 	    case 13: Relays_8to1 |= (uint8_t)0x40;     break; // Relay-07 ON
6023  10d5 721c0000      	bset	_Relays_8to1,#6
6026  10d9 cc11fb        	jra	L3471
6027  10dc               L3411:
6028                     ; 1653 	    case 14: Relays_8to1 &= (uint8_t)(~0x80);  break; // Relay-08 OFF
6030  10dc 721f0000      	bres	_Relays_8to1,#7
6033  10e0 cc11fb        	jra	L3471
6034  10e3               L5411:
6035                     ; 1654 	    case 15: Relays_8to1 |= (uint8_t)0x80;     break; // Relay-08 ON
6037  10e3 721e0000      	bset	_Relays_8to1,#7
6040  10e7 cc11fb        	jra	L3471
6041  10ea               L7411:
6042                     ; 1655 	    case 16: Relays_16to9 &= (uint8_t)(~0x01); break; // Relay-09 OFF
6044  10ea 72110000      	bres	_Relays_16to9,#0
6047  10ee cc11fb        	jra	L3471
6048  10f1               L1511:
6049                     ; 1656 	    case 17: Relays_16to9 |= (uint8_t)0x01;    break; // Relay-09 ON
6051  10f1 72100000      	bset	_Relays_16to9,#0
6054  10f5 cc11fb        	jra	L3471
6055  10f8               L3511:
6056                     ; 1657 	    case 18: Relays_16to9 &= (uint8_t)(~0x02); break; // Relay-10 OFF
6058  10f8 72130000      	bres	_Relays_16to9,#1
6061  10fc cc11fb        	jra	L3471
6062  10ff               L5511:
6063                     ; 1658 	    case 19: Relays_16to9 |= (uint8_t)0x02;    break; // Relay-10 ON
6065  10ff 72120000      	bset	_Relays_16to9,#1
6068  1103 cc11fb        	jra	L3471
6069  1106               L7511:
6070                     ; 1659 	    case 20: Relays_16to9 &= (uint8_t)(~0x04); break; // Relay-11 OFF
6072  1106 72150000      	bres	_Relays_16to9,#2
6075  110a cc11fb        	jra	L3471
6076  110d               L1611:
6077                     ; 1660 	    case 21: Relays_16to9 |= (uint8_t)0x04;    break; // Relay-11 ON
6079  110d 72140000      	bset	_Relays_16to9,#2
6082  1111 cc11fb        	jra	L3471
6083  1114               L3611:
6084                     ; 1661 	    case 22: Relays_16to9 &= (uint8_t)(~0x08); break; // Relay-12 OFF
6086  1114 72170000      	bres	_Relays_16to9,#3
6089  1118 cc11fb        	jra	L3471
6090  111b               L5611:
6091                     ; 1662 	    case 23: Relays_16to9 |= (uint8_t)0x08;    break; // Relay-12 ON
6093  111b 72160000      	bset	_Relays_16to9,#3
6096  111f cc11fb        	jra	L3471
6097  1122               L7611:
6098                     ; 1663 	    case 24: Relays_16to9 &= (uint8_t)(~0x10); break; // Relay-13 OFF
6100  1122 72190000      	bres	_Relays_16to9,#4
6103  1126 cc11fb        	jra	L3471
6104  1129               L1711:
6105                     ; 1664 	    case 25: Relays_16to9 |= (uint8_t)0x10;    break; // Relay-13 ON
6107  1129 72180000      	bset	_Relays_16to9,#4
6110  112d cc11fb        	jra	L3471
6111  1130               L3711:
6112                     ; 1665 	    case 26: Relays_16to9 &= (uint8_t)(~0x20); break; // Relay-14 OFF
6114  1130 721b0000      	bres	_Relays_16to9,#5
6117  1134 cc11fb        	jra	L3471
6118  1137               L5711:
6119                     ; 1666 	    case 27: Relays_16to9 |= (uint8_t)0x20;    break; // Relay-14 ON
6121  1137 721a0000      	bset	_Relays_16to9,#5
6124  113b cc11fb        	jra	L3471
6125  113e               L7711:
6126                     ; 1667 	    case 28: Relays_16to9 &= (uint8_t)(~0x40); break; // Relay-15 OFF
6128  113e 721d0000      	bres	_Relays_16to9,#6
6131  1142 cc11fb        	jra	L3471
6132  1145               L1021:
6133                     ; 1668 	    case 29: Relays_16to9 |= (uint8_t)0x40;    break; // Relay-15 ON
6135  1145 721c0000      	bset	_Relays_16to9,#6
6138  1149 cc11fb        	jra	L3471
6139  114c               L3021:
6140                     ; 1669 	    case 30: Relays_16to9 &= (uint8_t)(~0x80); break; // Relay-16 OFF
6142  114c 721f0000      	bres	_Relays_16to9,#7
6145  1150 cc11fb        	jra	L3471
6146  1153               L5021:
6147                     ; 1670 	    case 31: Relays_16to9 |= (uint8_t)0x80;    break; // Relay-16 ON
6149  1153 721e0000      	bset	_Relays_16to9,#7
6152  1157 cc11fb        	jra	L3471
6153  115a               L7021:
6154                     ; 1671 	    case 55:
6154                     ; 1672   	      Relays_8to1 = (uint8_t)0xff; // Relays 1-8 ON
6156  115a 35ff0000      	mov	_Relays_8to1,#255
6157                     ; 1673   	      Relays_16to9 = (uint8_t)0xff; // Relays 9-16 ON
6159  115e 35ff0000      	mov	_Relays_16to9,#255
6160                     ; 1674 	      break;
6162  1162 cc11fb        	jra	L3471
6163  1165               L1121:
6164                     ; 1675 	    case 56:
6164                     ; 1676               Relays_8to1 = (uint8_t)0x00; // Relays 1-8 OFF
6166  1165 725f0000      	clr	_Relays_8to1
6167                     ; 1677               Relays_16to9 = (uint8_t)0x00; // Relays 9-16 OFF
6169  1169 725f0000      	clr	_Relays_16to9
6170                     ; 1678 	      break;
6172  116d cc11fb        	jra	L3471
6173  1170               L3121:
6174                     ; 1680 	    case 60: // Show relay states page
6174                     ; 1681 	      current_webpage = WEBPAGE_DEFAULT;
6175                     ; 1682               pSocket->pData = g_HtmlPageDefault;
6176                     ; 1683               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6177                     ; 1684               pSocket->nNewlines = 0;
6178                     ; 1685               pSocket->nState = STATE_CONNECTED;
6179                     ; 1686               pSocket->nPrevBytes = 0xFFFF;
6180                     ; 1687 	      break;
6182  1170 206e          	jp	L3321
6183  1172               L5121:
6184                     ; 1689 	    case 61: // Show address settings page
6184                     ; 1690 	      current_webpage = WEBPAGE_ADDRESS;
6186  1172 3501000b      	mov	_current_webpage,#1
6187                     ; 1691               pSocket->pData = g_HtmlPageAddress;
6189  1176 1e0e          	ldw	x,(OFST+7,sp)
6190  1178 90ae15de      	ldw	y,#L71_g_HtmlPageAddress
6191  117c ef01          	ldw	(1,x),y
6192                     ; 1692               pSocket->nDataLeft = sizeof(g_HtmlPageAddress)-1;
6194  117e 90ae1341      	ldw	y,#4929
6195                     ; 1693               pSocket->nNewlines = 0;
6196                     ; 1694               pSocket->nState = STATE_CONNECTED;
6197                     ; 1695               pSocket->nPrevBytes = 0xFFFF;
6198                     ; 1696 	      break;
6200  1182 206c          	jp	LC020
6201  1184               L7121:
6202                     ; 1699 	    case 63: // Show help page 1
6202                     ; 1700 	      current_webpage = WEBPAGE_HELP;
6204  1184 3503000b      	mov	_current_webpage,#3
6205                     ; 1701               pSocket->pData = g_HtmlPageHelp;
6207  1188 1e0e          	ldw	x,(OFST+7,sp)
6208  118a 90ae2920      	ldw	y,#L12_g_HtmlPageHelp
6209  118e ef01          	ldw	(1,x),y
6210                     ; 1702               pSocket->nDataLeft = sizeof(g_HtmlPageHelp)-1;
6212  1190 90ae075c      	ldw	y,#1884
6213                     ; 1703               pSocket->nNewlines = 0;
6214                     ; 1704               pSocket->nState = STATE_CONNECTED;
6215                     ; 1705               pSocket->nPrevBytes = 0xFFFF;
6216                     ; 1706 	      break;
6218  1194 205a          	jp	LC020
6219  1196               L1221:
6220                     ; 1708 	    case 64: // Show help page 2
6220                     ; 1709 	      current_webpage = WEBPAGE_HELP2;
6222  1196 3504000b      	mov	_current_webpage,#4
6223                     ; 1710               pSocket->pData = g_HtmlPageHelp2;
6225  119a 1e0e          	ldw	x,(OFST+7,sp)
6226  119c 90ae307d      	ldw	y,#L32_g_HtmlPageHelp2
6227  11a0 ef01          	ldw	(1,x),y
6228                     ; 1711               pSocket->nDataLeft = sizeof(g_HtmlPageHelp2)-1;
6230  11a2 90ae02bb      	ldw	y,#699
6231                     ; 1712               pSocket->nNewlines = 0;
6232                     ; 1713               pSocket->nState = STATE_CONNECTED;
6233                     ; 1714               pSocket->nPrevBytes = 0xFFFF;
6234                     ; 1715 	      break;
6236  11a6 2048          	jp	LC020
6237  11a8               L3221:
6238                     ; 1718 	    case 65: // Flash LED for diagnostics
6238                     ; 1719 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6238                     ; 1720 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6238                     ; 1721 	      // XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
6238                     ; 1722 	      debugflash();
6240  11a8 cd0000        	call	_debugflash
6242                     ; 1723 	      debugflash();
6244  11ab cd0000        	call	_debugflash
6246                     ; 1724 	      debugflash();
6248  11ae cd0000        	call	_debugflash
6250                     ; 1728 	      break;
6252  11b1 2048          	jra	L3471
6253  11b3               L5221:
6254                     ; 1731             case 66: // Show statistics page
6254                     ; 1732 	      current_webpage = WEBPAGE_STATS;
6256  11b3 3505000b      	mov	_current_webpage,#5
6257                     ; 1733               pSocket->pData = g_HtmlPageStats;
6259  11b7 1e0e          	ldw	x,(OFST+7,sp)
6260  11b9 90ae3339      	ldw	y,#L52_g_HtmlPageStats
6261  11bd ef01          	ldw	(1,x),y
6262                     ; 1734               pSocket->nDataLeft = sizeof(g_HtmlPageStats)-1;
6264  11bf 90ae097e      	ldw	y,#2430
6265                     ; 1735               pSocket->nNewlines = 0;
6266                     ; 1736               pSocket->nState = STATE_CONNECTED;
6267                     ; 1737               pSocket->nPrevBytes = 0xFFFF;
6268                     ; 1738 	      break;
6270  11c3 202b          	jp	LC020
6271  11c5               L7221:
6272                     ; 1741 	    case 91: // Reboot
6272                     ; 1742 	      submit_changes = 2;
6274  11c5 35020000      	mov	_submit_changes,#2
6275                     ; 1743 	      break;
6277  11c9 2030          	jra	L3471
6278  11cb               L1321:
6279                     ; 1745             case 99: // Show simplified relay state page
6279                     ; 1746 	      current_webpage = WEBPAGE_RSTATE;
6281  11cb 3506000b      	mov	_current_webpage,#6
6282                     ; 1747               pSocket->pData = g_HtmlPageRstate;
6284  11cf 90ae3cb8      	ldw	y,#L72_g_HtmlPageRstate
6285  11d3 ef01          	ldw	(1,x),y
6286                     ; 1748               pSocket->nDataLeft = sizeof(g_HtmlPageRstate)-1;
6288  11d5 90ae00a0      	ldw	y,#160
6289  11d9 ef03          	ldw	(3,x),y
6290                     ; 1749               pSocket->nNewlines = 0;
6292  11db e705          	ld	(5,x),a
6293                     ; 1750               pSocket->nState = STATE_CONNECTED;
6295  11dd f7            	ld	(x),a
6296                     ; 1751               pSocket->nPrevBytes = 0xFFFF;
6297                     ; 1752 	      break;
6299  11de 2015          	jp	LC019
6300  11e0               L3321:
6301                     ; 1754 	    default: // Show relay state page
6301                     ; 1755 	      current_webpage = WEBPAGE_DEFAULT;
6303                     ; 1756               pSocket->pData = g_HtmlPageDefault;
6305                     ; 1757               pSocket->nDataLeft = sizeof(g_HtmlPageDefault)-1;
6308  11e0 725f000b      	clr	_current_webpage
6310  11e4 1e0e          	ldw	x,(OFST+7,sp)
6311  11e6 90ae0008      	ldw	y,#L51_g_HtmlPageDefault
6312  11ea ef01          	ldw	(1,x),y
6314  11ec 90ae15d5      	ldw	y,#5589
6315                     ; 1758               pSocket->nNewlines = 0;
6317                     ; 1759               pSocket->nState = STATE_CONNECTED;
6319  11f0               LC020:
6320  11f0 ef03          	ldw	(3,x),y
6326  11f2 6f05          	clr	(5,x)
6332  11f4 7f            	clr	(x)
6333                     ; 1760               pSocket->nPrevBytes = 0xFFFF;
6335  11f5               LC019:
6342  11f5 90aeffff      	ldw	y,#65535
6343  11f9 ef0a          	ldw	(10,x),y
6344                     ; 1761 	      break;
6346  11fb               L3471:
6347                     ; 1763           pSocket->ParseState = PARSE_DELIM;
6349  11fb 1e0e          	ldw	x,(OFST+7,sp)
6350  11fd a605          	ld	a,#5
6351  11ff e709          	ld	(9,x),a
6353  1201               L7071:
6354                     ; 1777         if (pSocket->nParseLeft == 0) {
6356  1201 1e0e          	ldw	x,(OFST+7,sp)
6357  1203 e606          	ld	a,(6,x)
6358  1205 261c          	jrne	L5761
6359                     ; 1779           pSocket->nState = STATE_SENDHEADER;
6360                     ; 1780           break;
6362  1207 2015          	jp	LC023
6363  1209               L7371:
6364                     ; 1766         else if (pSocket->ParseState == PARSE_DELIM) {
6366  1209 a105          	cp	a,#5
6367  120b 26f4          	jrne	L7071
6368                     ; 1768           pSocket->ParseState = PARSE_DELIM;
6370  120d a605          	ld	a,#5
6371  120f e709          	ld	(9,x),a
6372                     ; 1769           pSocket->nParseLeft--;
6374  1211 6a06          	dec	(6,x)
6375                     ; 1770           pBuffer++;
6377  1213 1e08          	ldw	x,(OFST+1,sp)
6378  1215 5c            	incw	x
6379  1216 1f08          	ldw	(OFST+1,sp),x
6380                     ; 1771 	  if (pSocket->nParseLeft == 0) {
6382  1218 1e0e          	ldw	x,(OFST+7,sp)
6383  121a e606          	ld	a,(6,x)
6384  121c 26e3          	jrne	L7071
6385                     ; 1773             pSocket->nState = STATE_SENDHEADER;
6387  121e               LC023:
6389  121e a60b          	ld	a,#11
6390  1220 f7            	ld	(x),a
6391                     ; 1774             break;
6393  1221 200b          	jra	L1761
6394  1223               L5761:
6395                     ; 1530       while (nBytes--) {
6397  1223 1e0c          	ldw	x,(OFST+5,sp)
6398  1225 5a            	decw	x
6399  1226 1f0c          	ldw	(OFST+5,sp),x
6400  1228 5c            	incw	x
6401  1229 2703cc0f85    	jrne	L3761
6402  122e               L1761:
6403                     ; 1785     if (pSocket->nState == STATE_SENDHEADER) {
6405  122e 1e0e          	ldw	x,(OFST+7,sp)
6406  1230 f6            	ld	a,(x)
6407  1231 a10b          	cp	a,#11
6408  1233 2623          	jrne	L5571
6409                     ; 1786       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6411  1235 ee03          	ldw	x,(3,x)
6412  1237 cd0000        	call	c_uitolx
6414  123a be02          	ldw	x,c_lreg+2
6415  123c 89            	pushw	x
6416  123d be00          	ldw	x,c_lreg
6417  123f 89            	pushw	x
6418  1240 ce0000        	ldw	x,_uip_appdata
6419  1243 cd0231        	call	L7_CopyHttpHeader
6421  1246 5b04          	addw	sp,#4
6422  1248 89            	pushw	x
6423  1249 ce0000        	ldw	x,_uip_appdata
6424  124c cd0000        	call	_uip_send
6426  124f 85            	popw	x
6427                     ; 1787       pSocket->nState = STATE_SENDDATA;
6429  1250 1e0e          	ldw	x,(OFST+7,sp)
6430  1252 a60c          	ld	a,#12
6431  1254 f7            	ld	(x),a
6432                     ; 1788       return;
6434  1255 cc0bc4        	jra	L613
6435  1258               L5571:
6436                     ; 1791     if (pSocket->nState == STATE_SENDDATA) {
6438  1258 a10c          	cp	a,#12
6439  125a 26f9          	jrne	L613
6440                     ; 1795       pSocket->nPrevBytes = pSocket->nDataLeft;
6442  125c 9093          	ldw	y,x
6443  125e 90ee03        	ldw	y,(3,y)
6444  1261 ef0a          	ldw	(10,x),y
6445                     ; 1796       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6447  1263 ce0000        	ldw	x,_uip_conn
6448  1266 ee12          	ldw	x,(18,x)
6449  1268 89            	pushw	x
6450  1269 1e10          	ldw	x,(OFST+9,sp)
6451  126b 1c0003        	addw	x,#3
6452  126e 89            	pushw	x
6453  126f 1e12          	ldw	x,(OFST+11,sp)
6454  1271 5c            	incw	x
6455  1272 89            	pushw	x
6456  1273 ce0000        	ldw	x,_uip_appdata
6457  1276 cd02c9        	call	L11_CopyHttpData
6459  1279 5b06          	addw	sp,#6
6460  127b 1f01          	ldw	(OFST-6,sp),x
6462                     ; 1797       pSocket->nPrevBytes -= pSocket->nDataLeft;
6464  127d 1e0e          	ldw	x,(OFST+7,sp)
6465  127f e60b          	ld	a,(11,x)
6466  1281 e004          	sub	a,(4,x)
6467  1283 e70b          	ld	(11,x),a
6468  1285 e60a          	ld	a,(10,x)
6469  1287 e203          	sbc	a,(3,x)
6470  1289 e70a          	ld	(10,x),a
6471                     ; 1799       if (nBufSize == 0) {
6473  128b 1e01          	ldw	x,(OFST-6,sp)
6474  128d 262d          	jrne	LC014
6475                     ; 1801         uip_close();
6477  128f               LC015:
6479  128f 35100000      	mov	_uip_flags,#16
6481  1293 cc0bc4        	jra	L613
6482                     ; 1805         uip_send(uip_appdata, nBufSize);
6484                     ; 1807       return;
6486  1296               L5631:
6487                     ; 1811   else if (uip_rexmit()) {
6489  1296 7204000003cc  	btjf	_uip_flags,#2,L3631
6490                     ; 1812     if (pSocket->nPrevBytes == 0xFFFF) {
6492  129e 160e          	ldw	y,(OFST+7,sp)
6493  12a0 90ee0a        	ldw	y,(10,y)
6494  12a3 905c          	incw	y
6495  12a5 2620          	jrne	L1771
6496                     ; 1814       uip_send(uip_appdata, CopyHttpHeader(uip_appdata, pSocket->nDataLeft));
6498  12a7 1e0e          	ldw	x,(OFST+7,sp)
6499  12a9 ee03          	ldw	x,(3,x)
6500  12ab cd0000        	call	c_uitolx
6502  12ae be02          	ldw	x,c_lreg+2
6503  12b0 89            	pushw	x
6504  12b1 be00          	ldw	x,c_lreg
6505  12b3 89            	pushw	x
6506  12b4 ce0000        	ldw	x,_uip_appdata
6507  12b7 cd0231        	call	L7_CopyHttpHeader
6509  12ba 5b04          	addw	sp,#4
6511  12bc               LC014:
6513  12bc 89            	pushw	x
6514  12bd ce0000        	ldw	x,_uip_appdata
6515  12c0 cd0000        	call	_uip_send
6516  12c3 85            	popw	x
6518  12c4 cc0bc4        	jra	L613
6519  12c7               L1771:
6520                     ; 1817       pSocket->pData -= pSocket->nPrevBytes;
6522  12c7 1e0e          	ldw	x,(OFST+7,sp)
6523  12c9 e602          	ld	a,(2,x)
6524  12cb e00b          	sub	a,(11,x)
6525  12cd e702          	ld	(2,x),a
6526  12cf e601          	ld	a,(1,x)
6527  12d1 e20a          	sbc	a,(10,x)
6528  12d3 e701          	ld	(1,x),a
6529                     ; 1818       pSocket->nDataLeft += pSocket->nPrevBytes;
6531  12d5 e604          	ld	a,(4,x)
6532  12d7 eb0b          	add	a,(11,x)
6533  12d9 e704          	ld	(4,x),a
6534  12db e603          	ld	a,(3,x)
6535  12dd e90a          	adc	a,(10,x)
6536                     ; 1819       pSocket->nPrevBytes = pSocket->nDataLeft;
6538  12df 9093          	ldw	y,x
6539  12e1 e703          	ld	(3,x),a
6540  12e3 90ee03        	ldw	y,(3,y)
6541  12e6 ef0a          	ldw	(10,x),y
6542                     ; 1820       nBufSize = CopyHttpData(uip_appdata, &pSocket->pData, &pSocket->nDataLeft, uip_mss());
6544  12e8 ce0000        	ldw	x,_uip_conn
6545  12eb ee12          	ldw	x,(18,x)
6546  12ed 89            	pushw	x
6547  12ee 1e10          	ldw	x,(OFST+9,sp)
6548  12f0 1c0003        	addw	x,#3
6549  12f3 89            	pushw	x
6550  12f4 1e12          	ldw	x,(OFST+11,sp)
6551  12f6 5c            	incw	x
6552  12f7 89            	pushw	x
6553  12f8 ce0000        	ldw	x,_uip_appdata
6554  12fb cd02c9        	call	L11_CopyHttpData
6556  12fe 5b06          	addw	sp,#6
6557  1300 1f01          	ldw	(OFST-6,sp),x
6559                     ; 1821       pSocket->nPrevBytes -= pSocket->nDataLeft;
6561  1302 1e0e          	ldw	x,(OFST+7,sp)
6562  1304 e60b          	ld	a,(11,x)
6563  1306 e004          	sub	a,(4,x)
6564  1308 e70b          	ld	(11,x),a
6565  130a e60a          	ld	a,(10,x)
6566  130c e203          	sbc	a,(3,x)
6567  130e e70a          	ld	(10,x),a
6568                     ; 1822       if (nBufSize == 0) {
6570  1310 1e01          	ldw	x,(OFST-6,sp)
6571                     ; 1824         uip_close();
6573  1312 2603cc128f    	jreq	LC015
6574                     ; 1828         uip_send(uip_appdata, nBufSize);
6576  1317 89            	pushw	x
6577  1318 ce0000        	ldw	x,_uip_appdata
6578  131b cd0000        	call	_uip_send
6580  131e 85            	popw	x
6581                     ; 1831     return;
6583  131f               L3631:
6584                     ; 1833 }
6586  131f cc0bc4        	jra	L613
6620                     ; 1836 uint8_t GpioGetPin(uint8_t nGpio)
6620                     ; 1837 {
6621                     	switch	.text
6622  1322               _GpioGetPin:
6624       00000000      OFST:	set	0
6627                     ; 1839   if(nGpio == 0       && (Relays_8to1  & (uint8_t)(0x01))) return 1; // Relay-01 is ON
6629  1322 4d            	tnz	a
6630  1323 2607          	jrne	L5102
6632  1325 7201000002    	btjf	_Relays_8to1,#0,L5102
6635  132a 4c            	inc	a
6638  132b 81            	ret	
6639  132c               L5102:
6640                     ; 1840   else if(nGpio == 1  && (Relays_8to1  & (uint8_t)(0x02))) return 1; // Relay-02 is ON
6642  132c a101          	cp	a,#1
6643  132e 2608          	jrne	L1202
6645  1330 7203000003    	btjf	_Relays_8to1,#1,L1202
6648  1335 a601          	ld	a,#1
6651  1337 81            	ret	
6652  1338               L1202:
6653                     ; 1841   else if(nGpio == 2  && (Relays_8to1  & (uint8_t)(0x04))) return 1; // Relay-03 is ON
6655  1338 a102          	cp	a,#2
6656  133a 2608          	jrne	L5202
6658  133c 7205000003    	btjf	_Relays_8to1,#2,L5202
6661  1341 a601          	ld	a,#1
6664  1343 81            	ret	
6665  1344               L5202:
6666                     ; 1842   else if(nGpio == 3  && (Relays_8to1  & (uint8_t)(0x08))) return 1; // Relay-04 is ON
6668  1344 a103          	cp	a,#3
6669  1346 2608          	jrne	L1302
6671  1348 7207000003    	btjf	_Relays_8to1,#3,L1302
6674  134d a601          	ld	a,#1
6677  134f 81            	ret	
6678  1350               L1302:
6679                     ; 1843   else if(nGpio == 4  && (Relays_8to1  & (uint8_t)(0x10))) return 1; // Relay-05 is ON
6681  1350 a104          	cp	a,#4
6682  1352 2608          	jrne	L5302
6684  1354 7209000003    	btjf	_Relays_8to1,#4,L5302
6687  1359 a601          	ld	a,#1
6690  135b 81            	ret	
6691  135c               L5302:
6692                     ; 1844   else if(nGpio == 5  && (Relays_8to1  & (uint8_t)(0x20))) return 1; // Relay-06 is ON
6694  135c a105          	cp	a,#5
6695  135e 2608          	jrne	L1402
6697  1360 720b000003    	btjf	_Relays_8to1,#5,L1402
6700  1365 a601          	ld	a,#1
6703  1367 81            	ret	
6704  1368               L1402:
6705                     ; 1845   else if(nGpio == 6  && (Relays_8to1  & (uint8_t)(0x40))) return 1; // Relay-07 is ON
6707  1368 a106          	cp	a,#6
6708  136a 2608          	jrne	L5402
6710  136c 720d000003    	btjf	_Relays_8to1,#6,L5402
6713  1371 a601          	ld	a,#1
6716  1373 81            	ret	
6717  1374               L5402:
6718                     ; 1846   else if(nGpio == 7  && (Relays_8to1  & (uint8_t)(0x80))) return 1; // Relay-08 is ON
6720  1374 a107          	cp	a,#7
6721  1376 2608          	jrne	L1502
6723  1378 720f000003    	btjf	_Relays_8to1,#7,L1502
6726  137d a601          	ld	a,#1
6729  137f 81            	ret	
6730  1380               L1502:
6731                     ; 1847   else if(nGpio == 8  && (Relays_16to9 & (uint8_t)(0x01))) return 1; // Relay-09 is ON
6733  1380 a108          	cp	a,#8
6734  1382 2608          	jrne	L5502
6736  1384 7201000003    	btjf	_Relays_16to9,#0,L5502
6739  1389 a601          	ld	a,#1
6742  138b 81            	ret	
6743  138c               L5502:
6744                     ; 1848   else if(nGpio == 9  && (Relays_16to9 & (uint8_t)(0x02))) return 1; // Relay-10 is ON
6746  138c a109          	cp	a,#9
6747  138e 2608          	jrne	L1602
6749  1390 7203000003    	btjf	_Relays_16to9,#1,L1602
6752  1395 a601          	ld	a,#1
6755  1397 81            	ret	
6756  1398               L1602:
6757                     ; 1849   else if(nGpio == 10 && (Relays_16to9 & (uint8_t)(0x04))) return 1; // Relay-11 is ON
6759  1398 a10a          	cp	a,#10
6760  139a 2608          	jrne	L5602
6762  139c 7205000003    	btjf	_Relays_16to9,#2,L5602
6765  13a1 a601          	ld	a,#1
6768  13a3 81            	ret	
6769  13a4               L5602:
6770                     ; 1850   else if(nGpio == 11 && (Relays_16to9 & (uint8_t)(0x08))) return 1; // Relay-12 is ON
6772  13a4 a10b          	cp	a,#11
6773  13a6 2608          	jrne	L1702
6775  13a8 7207000003    	btjf	_Relays_16to9,#3,L1702
6778  13ad a601          	ld	a,#1
6781  13af 81            	ret	
6782  13b0               L1702:
6783                     ; 1851   else if(nGpio == 12 && (Relays_16to9 & (uint8_t)(0x10))) return 1; // Relay-13 is ON
6785  13b0 a10c          	cp	a,#12
6786  13b2 2608          	jrne	L5702
6788  13b4 7209000003    	btjf	_Relays_16to9,#4,L5702
6791  13b9 a601          	ld	a,#1
6794  13bb 81            	ret	
6795  13bc               L5702:
6796                     ; 1852   else if(nGpio == 13 && (Relays_16to9 & (uint8_t)(0x20))) return 1; // Relay-14 is ON
6798  13bc a10d          	cp	a,#13
6799  13be 2608          	jrne	L1012
6801  13c0 720b000003    	btjf	_Relays_16to9,#5,L1012
6804  13c5 a601          	ld	a,#1
6807  13c7 81            	ret	
6808  13c8               L1012:
6809                     ; 1853   else if(nGpio == 14 && (Relays_16to9 & (uint8_t)(0x40))) return 1; // Relay-15 is ON
6811  13c8 a10e          	cp	a,#14
6812  13ca 2608          	jrne	L5012
6814  13cc 720d000003    	btjf	_Relays_16to9,#6,L5012
6817  13d1 a601          	ld	a,#1
6820  13d3 81            	ret	
6821  13d4               L5012:
6822                     ; 1854   else if(nGpio == 15 && (Relays_16to9 & (uint8_t)(0x80))) return 1; // Relay-16 is ON
6824  13d4 a10f          	cp	a,#15
6825  13d6 2608          	jrne	L7102
6827  13d8 720f000003    	btjf	_Relays_16to9,#7,L7102
6830  13dd a601          	ld	a,#1
6833  13df 81            	ret	
6834  13e0               L7102:
6835                     ; 1855   return 0;
6837  13e0 4f            	clr	a
6840  13e1 81            	ret	
6881                     	switch	.const
6882  3e23               L623:
6883  3e23 13ff          	dc.w	L3112
6884  3e25 1411          	dc.w	L5112
6885  3e27 1423          	dc.w	L7112
6886  3e29 1435          	dc.w	L1212
6887  3e2b 1447          	dc.w	L3212
6888  3e2d 1459          	dc.w	L5212
6889  3e2f 146b          	dc.w	L7212
6890  3e31 147d          	dc.w	L1312
6891  3e33 148e          	dc.w	L3312
6892  3e35 149e          	dc.w	L5312
6893  3e37 14ae          	dc.w	L7312
6894  3e39 14be          	dc.w	L1412
6895  3e3b 14ce          	dc.w	L3412
6896  3e3d 14de          	dc.w	L5412
6897  3e3f 14ee          	dc.w	L7412
6898  3e41 14fe          	dc.w	L1512
6899                     ; 1859 void GpioSetPin(uint8_t nGpio, uint8_t nState)
6899                     ; 1860 {
6900                     	switch	.text
6901  13e2               _GpioSetPin:
6903  13e2 89            	pushw	x
6904       00000000      OFST:	set	0
6907                     ; 1864   if(nState != 0 && nState != 1) nState = 1;
6909  13e3 9f            	ld	a,xl
6910  13e4 4d            	tnz	a
6911  13e5 2708          	jreq	L3712
6913  13e7 9f            	ld	a,xl
6914  13e8 4a            	dec	a
6915  13e9 2704          	jreq	L3712
6918  13eb a601          	ld	a,#1
6919  13ed 6b02          	ld	(OFST+2,sp),a
6920  13ef               L3712:
6921                     ; 1866   switch(nGpio)
6923  13ef 7b01          	ld	a,(OFST+1,sp)
6925                     ; 1932   default: break;
6926  13f1 a110          	cp	a,#16
6927  13f3 2503cc150c    	jruge	L7712
6928  13f8 5f            	clrw	x
6929  13f9 97            	ld	xl,a
6930  13fa 58            	sllw	x
6931  13fb de3e23        	ldw	x,(L623,x)
6932  13fe fc            	jp	(x)
6933  13ff               L3112:
6934                     ; 1868   case 0:
6934                     ; 1869     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x01); // Relay-01 OFF
6936  13ff 7b02          	ld	a,(OFST+2,sp)
6937  1401 2607          	jrne	L1022
6940  1403 72110000      	bres	_Relays_8to1,#0
6942  1407 cc150c        	jra	L7712
6943  140a               L1022:
6944                     ; 1870     else Relays_8to1 |= (uint8_t)0x01; // Relay-01 ON
6946  140a 72100000      	bset	_Relays_8to1,#0
6947  140e cc150c        	jra	L7712
6948  1411               L5112:
6949                     ; 1872   case 1:
6949                     ; 1873     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x02); // Relay-02 OFF
6951  1411 7b02          	ld	a,(OFST+2,sp)
6952  1413 2607          	jrne	L5022
6955  1415 72130000      	bres	_Relays_8to1,#1
6957  1419 cc150c        	jra	L7712
6958  141c               L5022:
6959                     ; 1874     else Relays_8to1 |= (uint8_t)0x02; // Relay-02 ON
6961  141c 72120000      	bset	_Relays_8to1,#1
6962  1420 cc150c        	jra	L7712
6963  1423               L7112:
6964                     ; 1876   case 2:
6964                     ; 1877     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x04); // Relay-03 OFF
6966  1423 7b02          	ld	a,(OFST+2,sp)
6967  1425 2607          	jrne	L1122
6970  1427 72150000      	bres	_Relays_8to1,#2
6972  142b cc150c        	jra	L7712
6973  142e               L1122:
6974                     ; 1878     else Relays_8to1 |= (uint8_t)0x04; // Relay-03 ON
6976  142e 72140000      	bset	_Relays_8to1,#2
6977  1432 cc150c        	jra	L7712
6978  1435               L1212:
6979                     ; 1880   case 3:
6979                     ; 1881     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x08); // Relay-04 OFF
6981  1435 7b02          	ld	a,(OFST+2,sp)
6982  1437 2607          	jrne	L5122
6985  1439 72170000      	bres	_Relays_8to1,#3
6987  143d cc150c        	jra	L7712
6988  1440               L5122:
6989                     ; 1882     else Relays_8to1 |= (uint8_t)0x08; // Relay-04 ON
6991  1440 72160000      	bset	_Relays_8to1,#3
6992  1444 cc150c        	jra	L7712
6993  1447               L3212:
6994                     ; 1884   case 4:
6994                     ; 1885     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x10); // Relay-05 OFF
6996  1447 7b02          	ld	a,(OFST+2,sp)
6997  1449 2607          	jrne	L1222
7000  144b 72190000      	bres	_Relays_8to1,#4
7002  144f cc150c        	jra	L7712
7003  1452               L1222:
7004                     ; 1886     else Relays_8to1 |= (uint8_t)0x10; // Relay-05 ON
7006  1452 72180000      	bset	_Relays_8to1,#4
7007  1456 cc150c        	jra	L7712
7008  1459               L5212:
7009                     ; 1888   case 5:
7009                     ; 1889     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x20); // Relay-06 OFF
7011  1459 7b02          	ld	a,(OFST+2,sp)
7012  145b 2607          	jrne	L5222
7015  145d 721b0000      	bres	_Relays_8to1,#5
7017  1461 cc150c        	jra	L7712
7018  1464               L5222:
7019                     ; 1890     else Relays_8to1 |= (uint8_t)0x20; // Relay-06 ON
7021  1464 721a0000      	bset	_Relays_8to1,#5
7022  1468 cc150c        	jra	L7712
7023  146b               L7212:
7024                     ; 1892   case 6:
7024                     ; 1893     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x40); // Relay-07 OFF
7026  146b 7b02          	ld	a,(OFST+2,sp)
7027  146d 2607          	jrne	L1322
7030  146f 721d0000      	bres	_Relays_8to1,#6
7032  1473 cc150c        	jra	L7712
7033  1476               L1322:
7034                     ; 1894     else Relays_8to1 |= (uint8_t)0x40; // Relay-07 ON
7036  1476 721c0000      	bset	_Relays_8to1,#6
7037  147a cc150c        	jra	L7712
7038  147d               L1312:
7039                     ; 1896   case 7:
7039                     ; 1897     if(nState == 0) Relays_8to1 &= (uint8_t)(~0x80); // Relay-08 OFF
7041  147d 7b02          	ld	a,(OFST+2,sp)
7042  147f 2607          	jrne	L5322
7045  1481 721f0000      	bres	_Relays_8to1,#7
7047  1485 cc150c        	jra	L7712
7048  1488               L5322:
7049                     ; 1898     else Relays_8to1 |= (uint8_t)0x80; // Relay-08 ON
7051  1488 721e0000      	bset	_Relays_8to1,#7
7052  148c 207e          	jra	L7712
7053  148e               L3312:
7054                     ; 1900   case 8:
7054                     ; 1901     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x01); // Relay-09 OFF
7056  148e 7b02          	ld	a,(OFST+2,sp)
7057  1490 2606          	jrne	L1422
7060  1492 72110000      	bres	_Relays_16to9,#0
7062  1496 2074          	jra	L7712
7063  1498               L1422:
7064                     ; 1902     else Relays_16to9 |= (uint8_t)0x01; // Relay-09 ON
7066  1498 72100000      	bset	_Relays_16to9,#0
7067  149c 206e          	jra	L7712
7068  149e               L5312:
7069                     ; 1904   case 9:
7069                     ; 1905     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x02); // Relay-10 OFF
7071  149e 7b02          	ld	a,(OFST+2,sp)
7072  14a0 2606          	jrne	L5422
7075  14a2 72130000      	bres	_Relays_16to9,#1
7077  14a6 2064          	jra	L7712
7078  14a8               L5422:
7079                     ; 1906     else Relays_16to9 |= (uint8_t)0x02; // Relay-10 ON
7081  14a8 72120000      	bset	_Relays_16to9,#1
7082  14ac 205e          	jra	L7712
7083  14ae               L7312:
7084                     ; 1908   case 10:
7084                     ; 1909     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x04); // Relay-11 OFF
7086  14ae 7b02          	ld	a,(OFST+2,sp)
7087  14b0 2606          	jrne	L1522
7090  14b2 72150000      	bres	_Relays_16to9,#2
7092  14b6 2054          	jra	L7712
7093  14b8               L1522:
7094                     ; 1910     else Relays_16to9 |= (uint8_t)0x04; // Relay-11 ON
7096  14b8 72140000      	bset	_Relays_16to9,#2
7097  14bc 204e          	jra	L7712
7098  14be               L1412:
7099                     ; 1912   case 11:
7099                     ; 1913     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x08); // Relay-12 OFF
7101  14be 7b02          	ld	a,(OFST+2,sp)
7102  14c0 2606          	jrne	L5522
7105  14c2 72170000      	bres	_Relays_16to9,#3
7107  14c6 2044          	jra	L7712
7108  14c8               L5522:
7109                     ; 1914     else Relays_16to9 |= (uint8_t)0x08; // Relay-12 ON
7111  14c8 72160000      	bset	_Relays_16to9,#3
7112  14cc 203e          	jra	L7712
7113  14ce               L3412:
7114                     ; 1916   case 12:
7114                     ; 1917     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x10); // Relay-13 OFF
7116  14ce 7b02          	ld	a,(OFST+2,sp)
7117  14d0 2606          	jrne	L1622
7120  14d2 72190000      	bres	_Relays_16to9,#4
7122  14d6 2034          	jra	L7712
7123  14d8               L1622:
7124                     ; 1918     else Relays_16to9 |= (uint8_t)0x10; // Relay-13 ON
7126  14d8 72180000      	bset	_Relays_16to9,#4
7127  14dc 202e          	jra	L7712
7128  14de               L5412:
7129                     ; 1920   case 13:
7129                     ; 1921     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x20); // Relay-14 OFF
7131  14de 7b02          	ld	a,(OFST+2,sp)
7132  14e0 2606          	jrne	L5622
7135  14e2 721b0000      	bres	_Relays_16to9,#5
7137  14e6 2024          	jra	L7712
7138  14e8               L5622:
7139                     ; 1922     else Relays_16to9 |= (uint8_t)0x20; // Relay-14 ON
7141  14e8 721a0000      	bset	_Relays_16to9,#5
7142  14ec 201e          	jra	L7712
7143  14ee               L7412:
7144                     ; 1924   case 14:
7144                     ; 1925     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x40); // Relay-15 OFF
7146  14ee 7b02          	ld	a,(OFST+2,sp)
7147  14f0 2606          	jrne	L1722
7150  14f2 721d0000      	bres	_Relays_16to9,#6
7152  14f6 2014          	jra	L7712
7153  14f8               L1722:
7154                     ; 1926     else Relays_16to9 |= (uint8_t)0x40; // Relay-15 ON
7156  14f8 721c0000      	bset	_Relays_16to9,#6
7157  14fc 200e          	jra	L7712
7158  14fe               L1512:
7159                     ; 1928   case 15:
7159                     ; 1929     if(nState == 0) Relays_16to9 &= (uint8_t)(~0x80); // Relay-16 OFF
7161  14fe 7b02          	ld	a,(OFST+2,sp)
7162  1500 2606          	jrne	L5722
7165  1502 721f0000      	bres	_Relays_16to9,#7
7167  1506 2004          	jra	L7712
7168  1508               L5722:
7169                     ; 1930     else Relays_16to9 |= (uint8_t)0x80; // Relay-16 ON
7171  1508 721e0000      	bset	_Relays_16to9,#7
7172                     ; 1932   default: break;
7174  150c               L7712:
7175                     ; 1934 }
7178  150c 85            	popw	x
7179  150d 81            	ret	
7269                     	switch	.const
7270  3e43               L633:
7271  3e43 1543          	dc.w	L1032
7272  3e45 154a          	dc.w	L3032
7273  3e47 1551          	dc.w	L5032
7274  3e49 1558          	dc.w	L7032
7275  3e4b 155f          	dc.w	L1132
7276  3e4d 1566          	dc.w	L3132
7277  3e4f 156d          	dc.w	L5132
7278  3e51 1574          	dc.w	L7132
7279  3e53 157b          	dc.w	L1232
7280  3e55 1582          	dc.w	L3232
7281  3e57 1589          	dc.w	L5232
7282  3e59 1590          	dc.w	L7232
7283                     ; 1937 void SetAddresses(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3)
7283                     ; 1938 {
7284                     	switch	.text
7285  150e               _SetAddresses:
7287  150e 89            	pushw	x
7288  150f 5207          	subw	sp,#7
7289       00000007      OFST:	set	7
7292                     ; 1951   temp = 0;
7294                     ; 1952   invalid = 0;
7296  1511 0f01          	clr	(OFST-6,sp)
7298                     ; 1955   str[0] = (uint8_t)alpha1;
7300  1513 9f            	ld	a,xl
7301  1514 6b02          	ld	(OFST-5,sp),a
7303                     ; 1956   str[1] = (uint8_t)alpha2;
7305  1516 7b0c          	ld	a,(OFST+5,sp)
7306  1518 6b03          	ld	(OFST-4,sp),a
7308                     ; 1957   str[2] = (uint8_t)alpha3;
7310  151a 7b0d          	ld	a,(OFST+6,sp)
7311  151c 6b04          	ld	(OFST-3,sp),a
7313                     ; 1958   str[3] = 0;
7315  151e 0f05          	clr	(OFST-2,sp)
7317                     ; 1959   temp = atoi(str);
7319  1520 96            	ldw	x,sp
7320  1521 1c0002        	addw	x,#OFST-5
7321  1524 cd0000        	call	_atoi
7323  1527 1f06          	ldw	(OFST-1,sp),x
7325                     ; 1960   if (temp > 255) invalid = 1; // If an invalid entry set indicator
7327  1529 a30100        	cpw	x,#256
7328  152c 2504          	jrult	L5632
7331  152e a601          	ld	a,#1
7332  1530 6b01          	ld	(OFST-6,sp),a
7334  1532               L5632:
7335                     ; 1962   if(invalid == 0) { // Make change only if valid entry
7337  1532 7b01          	ld	a,(OFST-6,sp)
7338  1534 265f          	jrne	L7632
7339                     ; 1963     switch(itemnum)
7341  1536 7b08          	ld	a,(OFST+1,sp)
7343                     ; 1977     default: break;
7344  1538 a10c          	cp	a,#12
7345  153a 2459          	jruge	L7632
7346  153c 5f            	clrw	x
7347  153d 97            	ld	xl,a
7348  153e 58            	sllw	x
7349  153f de3e43        	ldw	x,(L633,x)
7350  1542 fc            	jp	(x)
7351  1543               L1032:
7352                     ; 1965     case 0:  Pending_hostaddr4 = (uint8_t)temp; break;
7354  1543 7b07          	ld	a,(OFST+0,sp)
7355  1545 c70000        	ld	_Pending_hostaddr4,a
7358  1548 204b          	jra	L7632
7359  154a               L3032:
7360                     ; 1966     case 1:  Pending_hostaddr3 = (uint8_t)temp; break;
7362  154a 7b07          	ld	a,(OFST+0,sp)
7363  154c c70000        	ld	_Pending_hostaddr3,a
7366  154f 2044          	jra	L7632
7367  1551               L5032:
7368                     ; 1967     case 2:  Pending_hostaddr2 = (uint8_t)temp; break;
7370  1551 7b07          	ld	a,(OFST+0,sp)
7371  1553 c70000        	ld	_Pending_hostaddr2,a
7374  1556 203d          	jra	L7632
7375  1558               L7032:
7376                     ; 1968     case 3:  Pending_hostaddr1 = (uint8_t)temp; break;
7378  1558 7b07          	ld	a,(OFST+0,sp)
7379  155a c70000        	ld	_Pending_hostaddr1,a
7382  155d 2036          	jra	L7632
7383  155f               L1132:
7384                     ; 1969     case 4:  Pending_draddr4 = (uint8_t)temp; break;
7386  155f 7b07          	ld	a,(OFST+0,sp)
7387  1561 c70000        	ld	_Pending_draddr4,a
7390  1564 202f          	jra	L7632
7391  1566               L3132:
7392                     ; 1970     case 5:  Pending_draddr3 = (uint8_t)temp; break;
7394  1566 7b07          	ld	a,(OFST+0,sp)
7395  1568 c70000        	ld	_Pending_draddr3,a
7398  156b 2028          	jra	L7632
7399  156d               L5132:
7400                     ; 1971     case 6:  Pending_draddr2 = (uint8_t)temp; break;
7402  156d 7b07          	ld	a,(OFST+0,sp)
7403  156f c70000        	ld	_Pending_draddr2,a
7406  1572 2021          	jra	L7632
7407  1574               L7132:
7408                     ; 1972     case 7:  Pending_draddr1 = (uint8_t)temp; break;
7410  1574 7b07          	ld	a,(OFST+0,sp)
7411  1576 c70000        	ld	_Pending_draddr1,a
7414  1579 201a          	jra	L7632
7415  157b               L1232:
7416                     ; 1973     case 8:  Pending_netmask4 = (uint8_t)temp; break;
7418  157b 7b07          	ld	a,(OFST+0,sp)
7419  157d c70000        	ld	_Pending_netmask4,a
7422  1580 2013          	jra	L7632
7423  1582               L3232:
7424                     ; 1974     case 9:  Pending_netmask3 = (uint8_t)temp; break;
7426  1582 7b07          	ld	a,(OFST+0,sp)
7427  1584 c70000        	ld	_Pending_netmask3,a
7430  1587 200c          	jra	L7632
7431  1589               L5232:
7432                     ; 1975     case 10: Pending_netmask2 = (uint8_t)temp; break;
7434  1589 7b07          	ld	a,(OFST+0,sp)
7435  158b c70000        	ld	_Pending_netmask2,a
7438  158e 2005          	jra	L7632
7439  1590               L7232:
7440                     ; 1976     case 11: Pending_netmask1 = (uint8_t)temp; break;
7442  1590 7b07          	ld	a,(OFST+0,sp)
7443  1592 c70000        	ld	_Pending_netmask1,a
7446                     ; 1977     default: break;
7448  1595               L7632:
7449                     ; 1980 }
7452  1595 5b09          	addw	sp,#9
7453  1597 81            	ret	
7546                     ; 1983 void SetPort(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2, uint8_t alpha3, uint8_t alpha4, uint8_t alpha5)
7546                     ; 1984 {
7547                     	switch	.text
7548  1598               _SetPort:
7550  1598 89            	pushw	x
7551  1599 5209          	subw	sp,#9
7552       00000009      OFST:	set	9
7555                     ; 1997   temp = 0;
7557  159b 5f            	clrw	x
7558  159c 1f01          	ldw	(OFST-8,sp),x
7560                     ; 1998   invalid = 0;
7562  159e 0f03          	clr	(OFST-6,sp)
7564                     ; 2001   if(alpha1 > '6') invalid = 1;
7566  15a0 7b0b          	ld	a,(OFST+2,sp)
7567  15a2 a137          	cp	a,#55
7568  15a4 2506          	jrult	L3342
7571  15a6 a601          	ld	a,#1
7572  15a8 6b03          	ld	(OFST-6,sp),a
7575  15aa 201d          	jra	L5342
7576  15ac               L3342:
7577                     ; 2003     str[0] = (uint8_t)alpha1;
7579  15ac 6b04          	ld	(OFST-5,sp),a
7581                     ; 2004     str[1] = (uint8_t)alpha2;
7583  15ae 7b0e          	ld	a,(OFST+5,sp)
7584  15b0 6b05          	ld	(OFST-4,sp),a
7586                     ; 2005     str[2] = (uint8_t)alpha3;
7588  15b2 7b0f          	ld	a,(OFST+6,sp)
7589  15b4 6b06          	ld	(OFST-3,sp),a
7591                     ; 2006     str[3] = (uint8_t)alpha4;
7593  15b6 7b10          	ld	a,(OFST+7,sp)
7594  15b8 6b07          	ld	(OFST-2,sp),a
7596                     ; 2007     str[4] = (uint8_t)alpha5;
7598  15ba 7b11          	ld	a,(OFST+8,sp)
7599  15bc 6b08          	ld	(OFST-1,sp),a
7601                     ; 2008     str[5] = 0;
7603  15be 0f09          	clr	(OFST+0,sp)
7605                     ; 2009     temp = atoi(str);
7607  15c0 96            	ldw	x,sp
7608  15c1 1c0004        	addw	x,#OFST-5
7609  15c4 cd0000        	call	_atoi
7611  15c7 1f01          	ldw	(OFST-8,sp),x
7613  15c9               L5342:
7614                     ; 2012   if(invalid == 0) { // Make change only if valid entry
7616  15c9 7b03          	ld	a,(OFST-6,sp)
7617  15cb 2603          	jrne	L7342
7618                     ; 2013     Pending_port = (uint16_t)temp;
7620  15cd cf0000        	ldw	_Pending_port,x
7621  15d0               L7342:
7622                     ; 2015 }
7625  15d0 5b0b          	addw	sp,#11
7626  15d2 81            	ret	
7692                     ; 2018 void SetMAC(uint8_t itemnum, uint8_t alpha1, uint8_t alpha2)
7692                     ; 2019 {
7693                     	switch	.text
7694  15d3               _SetMAC:
7696  15d3 89            	pushw	x
7697  15d4 5203          	subw	sp,#3
7698       00000003      OFST:	set	3
7701                     ; 2031   temp = 0;
7703                     ; 2032   invalid = 0;
7705  15d6 0f01          	clr	(OFST-2,sp)
7707                     ; 2035   if (alpha1 >= '0' && alpha1 <= '9') alpha1 = (uint8_t)(alpha1 - '0');
7709  15d8 9f            	ld	a,xl
7710  15d9 a130          	cp	a,#48
7711  15db 250b          	jrult	L3052
7713  15dd 9f            	ld	a,xl
7714  15de a13a          	cp	a,#58
7715  15e0 2406          	jruge	L3052
7718  15e2 7b05          	ld	a,(OFST+2,sp)
7719  15e4 a030          	sub	a,#48
7721  15e6 200c          	jp	LC028
7722  15e8               L3052:
7723                     ; 2036   else if(alpha1 >= 'a' && alpha1 <= 'f') alpha1 = (uint8_t)(alpha1 - 87);
7725  15e8 7b05          	ld	a,(OFST+2,sp)
7726  15ea a161          	cp	a,#97
7727  15ec 250a          	jrult	L7052
7729  15ee a167          	cp	a,#103
7730  15f0 2406          	jruge	L7052
7733  15f2 a057          	sub	a,#87
7734  15f4               LC028:
7735  15f4 6b05          	ld	(OFST+2,sp),a
7737  15f6 2004          	jra	L5052
7738  15f8               L7052:
7739                     ; 2037   else invalid = 1; // If an invalid entry set indicator
7741  15f8 a601          	ld	a,#1
7742  15fa 6b01          	ld	(OFST-2,sp),a
7744  15fc               L5052:
7745                     ; 2039   if (alpha2 >= '0' && alpha2 <= '9') alpha2 = (uint8_t)(alpha2 - '0');
7747  15fc 7b08          	ld	a,(OFST+5,sp)
7748  15fe a130          	cp	a,#48
7749  1600 2508          	jrult	L3152
7751  1602 a13a          	cp	a,#58
7752  1604 2404          	jruge	L3152
7755  1606 a030          	sub	a,#48
7757  1608 200a          	jp	LC029
7758  160a               L3152:
7759                     ; 2040   else if(alpha2 >= 'a' && alpha2 <= 'f') alpha2 = (uint8_t)(alpha2 - 87);
7761  160a a161          	cp	a,#97
7762  160c 250a          	jrult	L7152
7764  160e a167          	cp	a,#103
7765  1610 2406          	jruge	L7152
7768  1612 a057          	sub	a,#87
7769  1614               LC029:
7770  1614 6b08          	ld	(OFST+5,sp),a
7772  1616 2004          	jra	L5152
7773  1618               L7152:
7774                     ; 2041   else invalid = 1; // If an invalid entry set indicator
7776  1618 a601          	ld	a,#1
7777  161a 6b01          	ld	(OFST-2,sp),a
7779  161c               L5152:
7780                     ; 2043   if (invalid == 0) { // Change value only if valid entry
7782  161c 7b01          	ld	a,(OFST-2,sp)
7783  161e 264a          	jrne	L3252
7784                     ; 2044     temp = (uint8_t)((alpha1<<4) + alpha2); // Convert to single digit
7786  1620 7b05          	ld	a,(OFST+2,sp)
7787  1622 97            	ld	xl,a
7788  1623 a610          	ld	a,#16
7789  1625 42            	mul	x,a
7790  1626 01            	rrwa	x,a
7791  1627 1b08          	add	a,(OFST+5,sp)
7792  1629 5f            	clrw	x
7793  162a 97            	ld	xl,a
7794  162b 1f02          	ldw	(OFST-1,sp),x
7796                     ; 2045     switch(itemnum)
7798  162d 7b04          	ld	a,(OFST+1,sp)
7800                     ; 2053     default: break;
7801  162f 2711          	jreq	L1442
7802  1631 4a            	dec	a
7803  1632 2715          	jreq	L3442
7804  1634 4a            	dec	a
7805  1635 2719          	jreq	L5442
7806  1637 4a            	dec	a
7807  1638 271d          	jreq	L7442
7808  163a 4a            	dec	a
7809  163b 2721          	jreq	L1542
7810  163d 4a            	dec	a
7811  163e 2725          	jreq	L3542
7812  1640 2028          	jra	L3252
7813  1642               L1442:
7814                     ; 2047     case 0: Pending_uip_ethaddr1 = (uint8_t)temp; break;
7816  1642 7b03          	ld	a,(OFST+0,sp)
7817  1644 c70000        	ld	_Pending_uip_ethaddr1,a
7820  1647 2021          	jra	L3252
7821  1649               L3442:
7822                     ; 2048     case 1: Pending_uip_ethaddr2 = (uint8_t)temp; break;
7824  1649 7b03          	ld	a,(OFST+0,sp)
7825  164b c70000        	ld	_Pending_uip_ethaddr2,a
7828  164e 201a          	jra	L3252
7829  1650               L5442:
7830                     ; 2049     case 2: Pending_uip_ethaddr3 = (uint8_t)temp; break;
7832  1650 7b03          	ld	a,(OFST+0,sp)
7833  1652 c70000        	ld	_Pending_uip_ethaddr3,a
7836  1655 2013          	jra	L3252
7837  1657               L7442:
7838                     ; 2050     case 3: Pending_uip_ethaddr4 = (uint8_t)temp; break;
7840  1657 7b03          	ld	a,(OFST+0,sp)
7841  1659 c70000        	ld	_Pending_uip_ethaddr4,a
7844  165c 200c          	jra	L3252
7845  165e               L1542:
7846                     ; 2051     case 4: Pending_uip_ethaddr5 = (uint8_t)temp; break;
7848  165e 7b03          	ld	a,(OFST+0,sp)
7849  1660 c70000        	ld	_Pending_uip_ethaddr5,a
7852  1663 2005          	jra	L3252
7853  1665               L3542:
7854                     ; 2052     case 5: Pending_uip_ethaddr6 = (uint8_t)temp; break;
7856  1665 7b03          	ld	a,(OFST+0,sp)
7857  1667 c70000        	ld	_Pending_uip_ethaddr6,a
7860                     ; 2053     default: break;
7862  166a               L3252:
7863                     ; 2056 }
7866  166a 5b05          	addw	sp,#5
7867  166c 81            	ret	
7969                     	switch	.bss
7970  0000               _OctetArray:
7971  0000 000000000000  	ds.b	11
7972                     	xdef	_OctetArray
7973                     	xref	_submit_changes
7974                     	xref	_ex_stored_devicename
7975                     	xref	_uip_ethaddr6
7976                     	xref	_uip_ethaddr5
7977                     	xref	_uip_ethaddr4
7978                     	xref	_uip_ethaddr3
7979                     	xref	_uip_ethaddr2
7980                     	xref	_uip_ethaddr1
7981                     	xref	_ex_stored_port
7982                     	xref	_ex_stored_netmask1
7983                     	xref	_ex_stored_netmask2
7984                     	xref	_ex_stored_netmask3
7985                     	xref	_ex_stored_netmask4
7986                     	xref	_ex_stored_draddr1
7987                     	xref	_ex_stored_draddr2
7988                     	xref	_ex_stored_draddr3
7989                     	xref	_ex_stored_draddr4
7990                     	xref	_ex_stored_hostaddr1
7991                     	xref	_ex_stored_hostaddr2
7992                     	xref	_ex_stored_hostaddr3
7993                     	xref	_ex_stored_hostaddr4
7994                     	xref	_Pending_uip_ethaddr6
7995                     	xref	_Pending_uip_ethaddr5
7996                     	xref	_Pending_uip_ethaddr4
7997                     	xref	_Pending_uip_ethaddr3
7998                     	xref	_Pending_uip_ethaddr2
7999                     	xref	_Pending_uip_ethaddr1
8000                     	xref	_Pending_port
8001                     	xref	_Pending_netmask1
8002                     	xref	_Pending_netmask2
8003                     	xref	_Pending_netmask3
8004                     	xref	_Pending_netmask4
8005                     	xref	_Pending_draddr1
8006                     	xref	_Pending_draddr2
8007                     	xref	_Pending_draddr3
8008                     	xref	_Pending_draddr4
8009                     	xref	_Pending_hostaddr1
8010                     	xref	_Pending_hostaddr2
8011                     	xref	_Pending_hostaddr3
8012                     	xref	_Pending_hostaddr4
8013                     	xref	_invert_output
8014                     	xref	_Relays_8to1
8015                     	xref	_Relays_16to9
8016                     	xref	_Port_Httpd
8017  000b               _current_webpage:
8018  000b 00            	ds.b	1
8019                     	xdef	_current_webpage
8020                     	xref	_atoi
8021                     	xref	_debugflash
8022                     	xref	_uip_flags
8023                     	xref	_uip_stat
8024                     	xref	_uip_conn
8025                     	xref	_uip_appdata
8026                     	xref	_htons
8027                     	xref	_uip_send
8028                     	xref	_uip_listen
8029                     	xdef	_SetMAC
8030                     	xdef	_SetPort
8031                     	xdef	_SetAddresses
8032                     	xdef	_GpioSetPin
8033                     	xdef	_GpioGetPin
8034                     	xdef	_HttpDCall
8035                     	xdef	_HttpDInit
8036                     	xdef	_reverse
8037                     	xdef	_emb_itoa
8038                     	xdef	_two_alpha_to_uint
8039                     	xdef	_three_alpha_to_uint
8040                     	switch	.const
8041  3e5b               L714:
8042  3e5b 436f6e6e6563  	dc.b	"Connection:close",13
8043  3e6c 0a00          	dc.b	10,0
8044  3e6e               L514:
8045  3e6e 436f6e74656e  	dc.b	"Content-Type:text/"
8046  3e80 68746d6c0d    	dc.b	"html",13
8047  3e85 0a00          	dc.b	10,0
8048  3e87               L314:
8049  3e87 436f6e74656e  	dc.b	"Content-Length:",0
8050  3e97               L114:
8051  3e97 0d0a00        	dc.b	13,10,0
8052  3e9a               L704:
8053  3e9a 485454502f31  	dc.b	"HTTP/1.1 200 OK",0
8054                     	xref.b	c_lreg
8055                     	xref.b	c_x
8056                     	xref.b	c_y
8076                     	xref	c_uitolx
8077                     	xref	c_ludv
8078                     	xref	c_lumd
8079                     	xref	c_rtol
8080                     	xref	c_ltor
8081                     	xref	c_lzmp
8082                     	end
