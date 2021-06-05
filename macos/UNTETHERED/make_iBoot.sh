#!/bin/bash
ios4=0
ios9=0
ibothook=0
if [ $# != 5 ]&&[ $# != 6 ]; then
echo "./make_iBoot.sh <ipsw(target)> -iv [iBoot-iv] -k [iBoot-key] <args>"
echo "argument list: [-ios9] [-ios4] [-ios433]"
exit
fi

if [ $2 != "-iv" ]||[ $4 != "-k" ]; then
echo "bad args"
exit
fi

if [ $# == 6 ]&&[ $6 == "-ios9" ]; then
ios9=1
fi
if [ $# == 6 ]&&[ $6 == "-ios4" ]; then
ios4=1
fi
if [ $# == 6 ]&&[ $6 == "-ios433" ]; then
ios4=1
ibothook=1
fi

device=$(unzip -l $1 | grep .production/manifest | cut -d '.' -f 2)
echo $device

mkdir iboottmp/
cd iboottmp/

unzip -j ../$1 Firmware/all_flash/all_flash.$device.production/iBoot*
mv -v iBoot* tmp
../bin/xpwntool tmp ibot.dec -iv $3 -k $5
if [ $ios4 == 1 ]&&[ $ibothook == 0 ]; then
../bin/iBoot32Patcher ibot.dec ibot.pwned --rsa -b "-v" --boot-partition --boot-ramdisk --logo4
fi
if [ $ios4 == 1 ]&&[ $ibothook == 1 ]; then
../bin/iBoot32Patcher ibot.dec ibot.pwned --rsa -b "-v" --boot-partition --boot-ramdisk --logo4 --433
fi
if [ $ios9 == 1 ]; then
../bin/iBoot32Patcher ibot.dec ibot.pwned --rsa -b "-v" --boot-partition9 --boot-ramdisk
fi
if [ $ios9 == 0 ]&&[ $ios4 == 0 ]&&[ $ibothook == 0 ]; then
../bin/iBoot32Patcher ibot.dec ibot.pwned --rsa -b "-v" --boot-partition --boot-ramdisk
fi
../bin/xpwntool ibot.pwned iBoot -t tmp
echo "0000010: 6365" | xxd -r - iBoot
echo "0000020: 6365" | xxd -r - iBoot
mv -v iBoot ..
cd ..
rm -r iboottmp
