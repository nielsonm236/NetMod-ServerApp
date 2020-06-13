##	link command file for STM8S005C6
##	Copyright (c) 2008 by COSMIC Software
##
+seg .vector -b 0x8000 -m 0x8000 -n .vector	# vectors start address
+seg .const -a .vector -n .const		# constants follow vectors
+seg .text -a .const -n .text			# code follow constants
+seg .eeprom -b 0x4000 -m 128			# internal eeprom
+seg .bsct -b 0 -m 0x100 -n .bsct		# internal ram
+seg .ubsct -a .bsct -n .ubsct
+seg .bit -a .ubsct -n .bit -id
+seg .data -a .bit -m 0x800 -n .data
+seg .bss -a .data -n .bss

## interrupt vectors
__STP_VECTORFILE__

## startup file
"crts0.sm8"

## application files
__STP_FILES__

## libraries
"libisl0.sm8"			# C library (if needed)
"libm0.sm8"			# machine library

## symbols
+def __endzp=@.ubsct		# end of zero page
+def __memory=@.bss		# symbol used by library
+def __stack=0x7ff		# stack pointer initial value
