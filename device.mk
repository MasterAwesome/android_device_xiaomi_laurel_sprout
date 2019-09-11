#
# Copyright 2018 The Android Open Source Project
# Copyright 2019 The PixelExperience Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/xiaomi/laurel_sprout/laurel_sprout-vendor.mk)

PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    $(LOCAL_PATH)/permissions/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    vbmeta
	
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true
	
#A/B related packages
PRODUCT_PACKAGES += \
    update_engine_client

#Boot control HAL test app
PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    update_engine_client

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.trinket \
    libcutils \
    libgptutils \
    libz
	
# Bluetooth
PRODUCT_PACKAGES += \
    BluetoothResCommon
	
# Board
PRODUCT_USES_QCOM_HARDWARE := true
PRODUCT_BOARD_PLATFORM := trinket

# Boot animation
TARGET_SCREEN_HEIGHT := 1560
TARGET_SCREEN_WIDTH := 720

# Some GSI builds enable dexpreopt, whitelist these preopt files
PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST += %.odex %.vdex %.art

# Exclude GSI specific files
PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST += \
    system/etc/init/config/skip_mount.cfg

# Exclude all files under system/product and system/product_services
PRODUCT_ARTIFACT_PATH_REQUIREMENT_WHITELIST += \
    system/product/% \
    system/product_services/%
	
# GSI specific tasks on boot
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/skip_mount.cfg:system/etc/init/config/skip_mount.cfg

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-beast

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    libaacwrapper
	
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml

# ANT+
PRODUCT_PACKAGES += \
    AntHalService \

# Display
PRODUCT_PACKAGES += \
    libdisplayconfig \
    libqdMetaData.system \
    libvulkan
	
# FM
#PRODUCT_PACKAGES += \
    FM2 \
    libqcomfm_jni \
    qcom.fmradio
	
#PRODUCT_BOOT_JARS += \
    qcom.fmradio

# Fingerprint
PRODUCT_PACKAGES += \
    lineage.biometrics.fingerprint.inscreen@1.0-service.xiaomi_trinket

#Hotspot
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/hostapd.accept:system/etc/hostapd/hostapd.accept \
    $(LOCAL_PATH)/configs/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    $(LOCAL_PATH)/configs/hostapd.deny:system/etc/hostapd/hostapd.deny

# Init
PRODUCT_PACKAGES += \
    init.qcom.rc \
    init.recovery.qcom.rc

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.xiaomi_trinket
	
# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles_vendor.xml:system/etc/media_profiles_vendor.xml

# Net
PRODUCT_PACKAGES += \
    netutils-wrapper-1.0

# OTA
#PRODUCT_PACKAGES += \
    Updates
	
# Placeholder
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/placeholder:system/etc/placeholder

# Power
PRODUCT_PACKAGES += \
    power.qcom:64

# Soong
PRODUCT_SOONG_NAMESPACES += \
    device/xiaomi/laurel_sprout

# Telephony
#PRODUCT_PACKAGES += \
    telephony-ext

#PRODUCT_BOOT_JARS += \
    telephony-ext

