# ch3rryflower [UNTETHER] - v1.3 beta 4-2  
by @dora2_yuruyi  

# What tool is this?
- This is an untethered downgrade CLI tool for 32-bit iOS devices with iOS 7 SHSH blobs using CFW.  

## Supported devices
- iPhone 4 [iPhone3,1]  
- iPhone 5 [iPhone5,2]  *Require iOS 7.x SHSH  
- iPhone 5c [iPhone5,3] *Require iOS 7.1.x SHSH  

# Supported version  
- iPhone 4 [iPhone3,1]  
    - iOS 4: 4.3, 4.3.3, 4.3.5  
    - iOS 5: 5.0, 5.0.1, 5.1, 5.1.1, 5.1.1r  
    - iOS 6: 6.0, 6.0.1, 6.1, 6.1.2, 6.1.3  
    - iOS 7: 7.0, 7.0.2, 7.0.3, 7.0.4, 7.0.6, 7.1, 7.1.1, 7.1.2  
- iPhone 5 [iPhone5,2]  
    - iOS 6: 6.1.2, 6.1.4  
    - iOS 7: 7.0, 7.0.2, 7.0.3, 7.0.4, 7.0.6, 7.1, 7.1.1, 7.1.2  
    - iOS 8: 8.0.2  
    - iOS 9: 9.0.2, 9.3.4  
- iPhone 5c [iPhone5,3]  
    - iOS 7: 7.1, 7.1.1, 7.1.2  
    - iOS 9: 9.3.4  
    
## Supported environment
- macOS 10.13 or later  
- ubuntu 18.04 LTS (untested, checkm8 on iPhone 5 probably won't work.)  

## Vulnerabilities to use
### BootROM
- limera1n
    - BootROM exploit for run unsigned code via USB by geohot (for iPhone 4)  
- checkm8
    - BootROM exploit for run unsigned code via USB by axi0mX  (for iPhone 4s or later)  

### iBoot
- De Rebus Antiquis
    - iBoot exploit that allows arbitrary code execution on the device untether by xerub  

## Why require iOS 7 SHSH?
- This is based on xerub's De Rebus Antiquis [1]. This shows that iOS 7 iBoot can be applied to downgrade by properly exploiting it. Therefore, iOS 7 LLB and iBoot must be signed by apple.
- After triggering the exploit, the shellcode, including the untethered iBoot patch added by me [2], runs and initiates an unsigned boot.

# How to use
- change directory to ch3rryflower via terminal
## 1, make iBoot
- Create a pwned iBoot.
    - This iBoot is unsigned. It is required to initiate a downgraded ios boot.
    - Patches are customizable. This makes it possible, for example, to debug via serial.
    - You can get the minimum patch by using the following script,
    ```
    ./make_iBoot.sh <ipsw> -iv [iBoot IV] -k [iBoot Key]
    ```
    
    - *iOS 4.3.3*
    ```
    ./make_iBoot.sh <ipsw> -iv [iv] -k [key] -ios433
    ```
    
    - *iOS 4.3.5*
    ```
    ./make_iBoot.sh <ipsw> -iv [iv] -k [key] -ios4
    ```
    
    - *iOS 9/10*
    ```
    ./make_iBoot.sh <ipsw> -iv [iv] -k [key] -ios9
    ```
    
## 2, create CFW
- Create CFW. 
- *-bbupdate* is not required for iPhone 4.
- base-ipsw is required for iBoot exploits. Select the version with SHSH and the presence of De Rebus Antiquis.
    - iPhone 4
    ```
    ./cherry <ipsw> custom.ipsw -memory -derebusantiquis <base-ipsw> iBoot
    ```
    - iPhone 4s or later
    ```
    ./cherry <ipsw> custom.ipsw -bbupdate -memory -derebusantiquis <base-ipsw> iBoot
    ```

### ios4fix
- If using iOS 4, the following patches are required. Please be sure to execute.
```
./ios4fix <iOS 4 ipsw [custom]> -t <iOS 4 ipsw [orig]> <iOS 7.1.2 ipsw>
```

## 3, restore
- Replace the target iOS 7 SHSH with the version you want to restore.  
- Before executing the following command, rename the iOS 7 SHSH in the shsh directory as follows  
**shsh/[ECID]-[device]-[ios-version]-[build].shsh**  
(for iPhone 4: shsh/[ECID]-[device]-[ios-version].shsh)  
*example*  
    ```
    mv -v shsh/123456789-iPhone5,2-7.0.4.shsh shsh/123456789-iPhone5,2-6.1.2-10B146.shsh
    ```

- Put the device in DFU mode, and enter pwned DFU mode.
```
./pwnedDFU -p
```
- Enter device to iBSS (soft) DFU mode (for iPhone 4s or later only)
```
unzip -j custom.ipsw Firmware/dfu/iBSS*
bin/xpwntool iBSS* softdfu
./pwnedDFU -f softdfu
```

- Restore CFW (iPhone 4 only)
```
./idevicerestore -e -w custom.ipsw
```

- Restore CFW (iPhone 4s or later)
```
./idevicererestore -r custom.ipsw
```

## Nature of this iBoot exploit
### nvram
- This tool changes the nvram value and triggers an exploit. Therefore, if this tool is not properly released after use, the normal firmware will trigger a recovery mode.  

## How to cancel a trigger of exploit
### iPhone 4
- Put in device to DFU mode, cd to remove_for_i4 via terminal and execute disable  

### iPhone 4s~iPhone 5c
- Restore to iOS 9.3.5/10.3.4, and jailbreak, and execute "nvram -d boot-ramdisk" via terminal.  

# About Downgrade Party Blobs (for iPhone 4s or later)
**Important notes about blobs acquired at the downgrade party in January 2018**

- If you use my tool to restore with shsh2 using obtained by tsschecker, the baseband update process will be broken. These affected users are some of the users who acquired iOS 7 blobs at the downgrade party in January 2018.

### These users will need to make the following modifications when using my tool.
- backup shsh2.
- Change extension from ".shsh2" to ".plist".
- Delete all items except "APTicket" and "LLB" related.
- Change the extension back to ".shsh".

# How to add device or version support
- To add device support, you need to create an exploit. Exploit can be developed by using xerub's iloader [1].
- There are two ways to add already supported device versions.
    - For iOS 7 and below, just add the ch3rryflower-specific options to the Odysseus Bundle to info.plist. See the existing bundle for details.
    - For iOS 8 or later, Odysseus kernel patch cannot be used because it is incomplete. Sandbox problem. An easy way is to patch sandbox mac policies to zero [3]. Add the tfp0 patch to the Odysseus patch and run sbpatcher [4] before applying the exploit.

# References
[1] https://xerub.github.io/ios/iboot/2018/05/10/de-rebus-antiquis.html  
[2] https://github.com/dora2-iOS/iloader/blob/master/iPhone5,2/dora_yururi/iboot_untether.S  
[3] https://www.blackhat.com/docs/asia-17/materials/asia-17-Bazaliy-Fried-Apples-Jailbreak-DIY.pdf  
[4] https://github.com/dora2-iOS/sbpatcher32  
# Thanks to
See README on top page
