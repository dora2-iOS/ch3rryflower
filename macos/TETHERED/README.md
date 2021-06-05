# ch3rryflower [UNTETHER] - v1.3 beta 4-2  
by @dora2_yuruyi  

**This method is a apply of the conventional Tethered Downgrade method**

# How to use
## 1, Creating CFW
```
./cherry <orininal-ipsw> custom.ipsw -bbupdate -memory -tethered
```

## 2, Acquisition of *fake* SHSH
- Put the device in DFU mode. Get fake SHSH using idevicerestore.
```
./fakeshsh.sh [device]
./idevicerestore -t [fakeipsw]
```
## 3, Restore CFW
### 3-1, Put the device in DFU mode.
- Extract pwnediBSS
```
unzip -j custom.ipsw Firmware/dfu/iBSS*
bin/xpwntool iBSS* softdfu
rm iBSS*
```
- Put the device in DFU mode, and enter pwned DFU mode.
```
./pwnedDFU -p
```

- Enter device to iBSS (soft) DFU mode
```
./pwnedDFU -f softdfu
```

### 3-2, Restore
- Before executing the following command, rename the fake SHSH in the shsh directory as follows  
**shsh/[ECID]-iPhone5,2-[ios-version]-[build].shsh**  

*example*
```
mv -v shsh/123456789-iPhone5,2-8.4.1.shsh shsh/123456789-iPhone5,2-9.0-13A344.shsh
```
- Restore CFW
```
./idevicererestore -r custom.ipsw
```
Restore is successful, it enter into *recovery mode*.  

## 4, justboot
### 4-1, Preparation
- Extract iBSS, iBEC, DeviceTree, RestoreRamdisk, KernelCache from ipsw (original)
- Get FW key from The iPhone Wiki, decrypt and patch iBSS, iBEC as follows. (If you do this once, you can omit it when booting the OS from the second time.)
*The iPhone Wiki*: https://www.theiphonewiki.com/wiki/Firmware_Keys  

    - iBSS
    ```
    bin/xpwntool iBSS_original iBSS_decrypt -iv [iv] -k [key]
    bin/iBoot32patcher iBSS_decrypt pwnediBSS --rsa
    ```
    -> "pwnediBSS" is the target file.

    - iBEC
    ```
    bin/xpwntool iBEC_original iBEC_decrypt -iv [iv] -k [key]
    bin/iBoot32patcher iBEC_decrypt iBEC_pwned --rsa -b "-v"
    bin/xpwntool iBEC_pwned pwnediBEC -t iBEC_original
    ```
    -> "pwnediBEC" is the target file. 

### 4-2, boot
- **This is necessary every time because it is tethered**
- Put the device in DFU mode, and enter pwned DFU mode.

```
./pwnedDFU -p
```

- Enter device to iBSS (soft) DFU mode
```
./pwnedDFU -f softdfu
```

- Enter device to iBEC (recovery) mode
```
./irecovery -f [pwnediBEC]
```

- Just Boot
```
./irecovery -f [DeviceTree]
./irecovery -c devicetree
./irecovery -f [RestoreRamdisk]
./irecovery -c ramdisk
./irecovery -f [KernelCache]
./irecovery -c bootx
```
