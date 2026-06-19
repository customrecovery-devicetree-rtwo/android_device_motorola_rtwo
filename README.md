# Motorola Edge 40 Pro/Motorola Edge+ 2023/Moto X40 (rtwo) OrangeFox device tree

This is an OrangeFox recovery device tree for the Motorola Edge 40 Pro/Motorola Edge+ 2023/Moto X40, based on the older rtwo TWRP port.

# Warning

```
/*
* Your warranty is now void.
*
* I am not responsible for bricked devices, total data loss,
* thermonuclear war, or you getting fired because your phone got stuck in a bootloop. Please
* do some research if you have any concerns about this unofficial OrangeFox port
* before flashing it! YOU are choosing to make these modifications, and if
* you point the finger at me for messing up your device, I will laugh at you.
* This tree is experimental,
* so you will be putting your device at risk by using this experimental OrangeFox build.
*/
```

# Note

This family of phones uses boot.img's kernel to boot the recovery (kind of like recovery-on-boot, except recovery is on a second ramdisk). As a result, an empty kernel image is provided as a workaround (the recovery build system needs a kernel image). A special command is included in `bootimg.mk`. Without it, the device will throw you

`No valid operating system found` 

when attempting to boot into recovery mode (Android itself will still boot fine, only recovery is affected until you flash a proper image).

Attempting to boot using `fastboot boot` will not work; it must be flashed to recovery. Since it has no kernel, `fastboot boot recovery.img` will result in the same `No valid operating system found` error.

# Previously working in the base port
- It can boot
- Touchscreen
- File Manager (can browse files and mounted partitions such as `/system`)
- Can read (and possibly write) internal storage (you have to mount from terminal currently). Exception is `/data`, which is encrypted.
- CPU Temperature
- Brightness (there is a default brightness that works in most environments set, but it of course can be adjusted through the slider)
- USB with adb (MTP appears in lsusb, so this should work as well)
- Super partition mapping (dm devices appear in /dev/block, and all match up with Android's numbering).

# Base-port issues targeted by this OrangeFox adaptation
- USB host mode: fstab now uses the common USB mass-storage node, but this still needs on-device testing
- Battery percentage: recovery health HAL is now included and started as `vendor.health-recovery`; sysfs validation is still needed
- fastbootd: disabled intentionally until userspace fastboot is validated safely on-device.
- `/data` partition with FBE: crypto/FBE flags are enabled for testing with the bundled keymint/keymaster/gatekeeper blobs

# Still untested
- Flashing ZIPs/adb sideload (will test with LineageOS upgrade from 21 to 22 soon)
- Factory reset
- Backup/Restore super partition (backup of `/data` is guaranteed not going to work because again, encryption)
- Anything else that needs real-device validation

# Instructions to Build

Use the OrangeFox build notes below. This tree must be located at `device/motorola/rtwo`.

# Credits

- ThEMarD for the LineageOS port (allowed me to find out values from the rtwo device trees, and the command for mkbootimg which can produce working images for rtwo, found from the LineageOS build logs). LineageOS device trees can be found here: https://github.com/moto-sm8550/android_device_motorola_rtwo and here: https://github.com/moto-sm8550/android_device_motorola_sm8550-common
- The person who created the Samsung Galaxy S23 port for TWRP (used as a base, as both phones have the same SoC/Processor): https://github.com/TeamWin/android_device_samsung_dm1q

# OrangeFox build notes

Place this tree at `device/motorola/rtwo` inside an OrangeFox recovery source tree.

Primary OrangeFox build target:

```bash
. build/envsetup.sh
lunch orangefox_rtwo-eng
mka recoveryimage
```

Legacy compatibility targets are kept only to satisfy source trees that expect those product names: `twrp_rtwo-eng` and `omni_rtwo-eng`. If the source tree expects Omni-style product names, use:

```bash
. build/envsetup.sh
lunch omni_rtwo-eng
mka recoveryimage
```

Fastbootd is disabled in this tree on purpose. The original port documents a broken fastbootd flow on rtwo, so it should only be re-enabled after boot, ADB, dynamic partitions, and userspace fastboot are validated on-device.

FBE support is enabled for testing with the bundled keymint/keymaster/gatekeeper blobs and the metadata fstab flags. If `/data` still does not decrypt, collect recovery logs with `adb pull /tmp/recovery.log` and kernel logs with `adb shell dmesg` before changing the crypto flags again.
