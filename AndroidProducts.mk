#
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_rtwo.mk \
    $(LOCAL_DIR)/omni_rtwo.mk \
    $(LOCAL_DIR)/orangefox_rtwo.mk

COMMON_LUNCH_CHOICES := \
    twrp_rtwo-eng \
    omni_rtwo-eng \
    orangefox_rtwo-eng
