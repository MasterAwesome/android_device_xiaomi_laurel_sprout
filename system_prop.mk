# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
	vendor.bluetooth.soc=cherokee \
	persist.vendor.btstack.enable.splita2dp=true \
	persist.vendor.btstack.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac \
	persist.vendor.bluetooth.modem_nv_support=true \
	ro.bluetooth.emb_wp_mode=true \
	ro.bluetooth.wipower=true \
	bt.max.hfpclient.connections=1

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
	vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.factory.mmigroup,com.xiaomi.cameratools \
	persist.vendor.camera.expose.aux=1 \
	persist.vendor.camera.privapp.list=org.codeaurora.snapcam \
	persist.camera.privapp.list=org.codeaurora.snapcam \
	persist.vendor.camera.stats.test=0

# CNE and DPM
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.cne.feature=1 \
	persist.vendor.dpm.feature=1

# Data Modules
PRODUCT_PROPERTY_OVERRIDES += \
	ro.vendor.use_data_netmgrd=true \
	persist.vendor.data.mode=concurrent

# Disable priv-app permissions whitelist
PRODUCT_PROPERTY_OVERRIDES += \
    ro.control_privapp_permissions=log

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
	debug.sf.enable_hwc_vds=1

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
	vendor.iop.enable_uxe=1 \
	vendor.perf.iop_v3.enable=true \
	vendor.perf.gestureflingboost.enable=true \
	vendor.perf.workloadclassifier.enable=true

# Media
PRODUCT_PROPERTY_OVERRIDES += \
	media.stagefright.enable-player=true \
	media.stagefright.enable-http=true \
	media.stagefright.enable-aac=true \
	media.stagefright.enable-qcp=true \
	media.stagefright.enable-fma2dp=true \
	media.stagefright.enable-scan=true \
	mmp.enable.3g2=true \
	media.aac_51_output_enabled=true \
	mm.enable.smoothstreaming=true \
	media.settings.xml=/system/etc/media_profiles_vendor.xml \
	vendor.mm.enable.qcom_parser=63963135

# Netflix
PRODUCT_PROPERTY_OVERRIDES += \
	ro.netflix.bsp_rev=Q6125-17995-1

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
	rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so \
	ril.subscription.types=RUIM \
	DEVICE_PROVISIONED=1 \
	ro.telephony.default_network=22,22 \
	persist.radio.NO_STAPA=1 \
	persist.vendor.radio.ignore_dom_time=5 \
	persist.radio.atfwd.start=false \
	telephony.lteOnCdmaDevice=1

# RCS
PRODUCT_PROPERTY_OVERRIDES += \
	ro.com.google.acsa=true \
	persist.rcs.supported=0

# Sensors
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.debug.sensors.hal=i \
	persist.vendor.debug.sensors.daemon=i

PRODUCT_PROPERTY_OVERRIDES += \
	debug.sf.early_phase_offset_ns=1500000 \
	debug.sf.early_app_phase_offset_ns=1500000 \
	debug.sf.early_gl_phase_offset_ns=3000000 \
	debug.sf.early_gl_app_phase_offset_ns=15000000
