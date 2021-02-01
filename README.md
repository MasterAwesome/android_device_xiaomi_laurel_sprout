Device configuration for Xiaomi Mi A3
=========================================

The Xiaomi Mi A3 (codenamed _"laurel_sprout"_) is a entry-level smartphone from Xiaomi.

Basic   | Spec Sheet
-------:|:----------
CPU     | 8x2GHz Kryo 260
Chipset | Qualcomm Snapdragon 665
GPU     | Adreno 610
ROM     | 64/128 UFS 2.1
RAM     | 4GB
Android | 9.0
Battery | 4030 mAh
Display | 720x1560 pixels, 6.0
Rear Camera  | 48MP/2MP/8MP
Front Camera | 32MP

## Device picture
![Xiaomi Mi A3](https://i01.appmifile.com/webfile/globalimg/products/pc/mi-a3/MIA3_02.jpg "Xiaomi Mi A3")

## Device manifest

```xml
<?xml version="1.0" encoding="UTF-8"?>

<manifest>
	<!-- DEVICE TREE -->
	<project name="MasterAwesome/android_device_xiaomi_laurel_sprout" path="device/xiaomi/laurel_sprout" remote="github" />

	<!-- VENDOR TREE -->
	<project name="MasterAwesome/android_vendor_xiaomi_laurel_sprout" path="vendor/xiaomi/laurel_sprout" remote="github" />
	<project name="MasterAwesome/android_vendor_xiaomi_laurel_sprout-images" path="vendor/xiaomi/laurel_sprout-images" remote="github" />

	<!-- KERNEL TREE -->
	<project name="MasterAwesome/android_kernel_xiaomi_laurel_sprout" path="kernel/xiaomi/laurel_sprout" remote="github" />
</manifest>
```

## Builds
Builds for this tree is at: https://gitlab.com/MasterAwesome/laurel_sprout-builds. Please refer to commit-id to know the latest commit
