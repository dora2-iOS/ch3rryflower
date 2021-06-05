#!/bin/sh

if [ $# != 1 ]; then
echo "./fakeshsh.sh device"
echo "  [EX] ./fakeshsh.sh iPhone5,2"
exit
fi

if [ $1 = "iPhone5,1" ]||[ $1 = "iPhone5,2" ]; then
bin/partialZipBrowser -g BuildManifest.plist https://updates.cdn-apple.com/2019/ios/091-25277-20190722-0C1B94DE-992C-11E9-A2EE-E2C9A77C2E40/iPhone_4.0_32bit_10.3.4_14G61_Restore.ipsw
zip iPhone5_fake.ipsw -r0 BuildManifest.plist
exit
fi

if [ $1 = "iPhone5,3" ]||[ $1 = "iPhone5,4" ]; then
bin/partialZipBrowser -g BuildManifest.plist http://appldnld.apple.com/ios10.3.3/091-23384-20170719-CA966D80-6977-11E7-9F96-3E9100BA0AE3/iPhone_4.0_32bit_10.3.3_14G60_Restore.ipsw
zip iPhone5b_fake.ipsw -r0 BuildManifest.plist
exit
fi

echo "failed!"
