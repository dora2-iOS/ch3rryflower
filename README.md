# ch3rryflower - v1.3 beta 4-2
by @dora2_yuruyi


# What tool is this?
- This is a CLI tool to restore/downgrade 32-bit iOS device with CFW.


## Supported devices
- iPhone 4 (iPhone3,1)
- iPhone 5
- iPhone 5c


## Supported environment
- macOS 10.13 or later
- ubuntu 18.04 LTS (untested, checkm8 on iPhone 5 probably won't work.)


## Supported downgrades
- Untethered
	- iPhone3,1
	- iPhone5,2 (Require iOS 7.x SHSH)
	- iPhone5,3 (Require iOS 7.1.x SHSH)
- Tethered
	- iPhone5,2
	- iPhone5,4


## Vulnerabilities to use
### BootROM
- limera1n
	- BootROM exploit for running unsigned code via USB by geohot
- SHAtter
	- BootROM exploit for running unsigned code via USB by posixninja and pod2g
- checkm8
	- BootROM exploit for running unsigned code via USB by axi0mX

### iBoot
- De Rebus Antiquis
	- iBoot exploit that allows arbitrary code execution on the device (untether) by xerub  


# List of tools
### UNTETHERED
- A tool that untethered-downgrade devices by De Rebus Antiquis without SHSH (or using SHSH of iOS 7).
- This is exploited at iBoot level, so you can perform all of CFW restore, booting with verbose, apply custom bootlogo, untethered-jailbreak, etc.

### TETHERED
- A tool that tethered-downgrade by BootROM exploit.
- "Just boot" is required for every reboot.

### pwnedDFU
	The binary "pwnedDFU" stored in the tool can be used to put the following devices into pwned DFU mode.
		s5l8920x: limera1n
		s5l8922x: limera1n
		s5l8930x: limera1n or SHAtter
		s5l8950x: checkm8


# Thanks to
- axi0mX for checkm8 exploit, ipwndfu
- geohot for limera1n exploit
- posixninja and pod2g for SHAtter exploit
- xerub for De Rebus Antiquis, more FirmwareBundles
- iH8sn0w for iBoot32Patcher
- tihmstar, nyan_satan, Ralph0045, Merculous, and a8q for Improvement of iBoot32Patcher
- tihmstar for partialZipBrowser
- libimobiledevice for idevicerestore, libirecovery
- alitek12, Trevor, and Jon for idevicererestore
- planetbeing for xpwn
- dayt0n by Odysseus
- synackuk for n1ghtshade (belladonna)
- FriedAppleTeam for Jailbreak DIY
