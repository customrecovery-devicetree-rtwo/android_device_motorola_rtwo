#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

add_lunch_combo twrp_rtwo-eng
add_lunch_combo omni_rtwo-eng
add_lunch_combo orangefox_rtwo-eng

export ALLOW_MISSING_DEPENDENCIES=true
export FOX_BUILD_DEVICE=rtwo
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export FOX_USE_BASH_SHELL=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_ENABLE_APP_MANAGER=1
export FOX_DELETE_AROMAFM=1
export FOX_VENDOR_BOOT_RECOVERY=0
export FOX_VIRTUAL_AB_DEVICE=0
export FOX_VANILLA_BUILD=1
export FOX_RECOVERY_INSTALL_PARTITION=/dev/block/bootdevice/by-name/recovery
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
export OF_FORCE_PREBUILT_KERNEL=1
export OF_DEFAULT_KEYMASTER_VERSION=4.1
export OF_MAINTAINER=local
