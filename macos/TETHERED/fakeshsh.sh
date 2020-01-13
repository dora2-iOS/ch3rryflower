#!/bin/sh

bin/partialZipBrowser -g BuildManifest.plist http://appldnld.apple.com/ios10.3.3/091-23384-20170719-CA966D80-6977-11E7-9F96-3E9100BA0AE3/iPhone_4.0_32bit_10.3.3_14G60_Restore.ipsw
zip fake.ipsw -r0 BuildManifest.plist
