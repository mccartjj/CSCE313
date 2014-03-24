#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting Binary File: /acct/s1/mccartjj/CSCE313/myfile.zip to: "../flash/myfile_cfi_flash_0.flash"
#
/usr/local/3rdparty/altera/quartus12/nios2eds/bin/bin2flash --input="/acct/s1/mccartjj/CSCE313/myfile.zip" --output="../flash/myfile_cfi_flash_0.flash" --location=0x0 --verbose 

#
# Programming File: "../flash/myfile_cfi_flash_0.flash" To Device: cfi_flash_0
#
/usr/local/3rdparty/altera/quartus12/nios2eds/bin/nios2-flash-programmer "../flash/myfile_cfi_flash_0.flash" --base=0x1400000 --sidp=0x19030C0 --id=0x0 --accept-bad-sysid --device=1 --instance=0 '--cable=USB-Blaster on localhost [3-2]' --program --verbose 

