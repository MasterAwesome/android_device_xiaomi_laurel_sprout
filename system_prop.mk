# Audio
PRODUCT_PROPERTY_OVERRIDES += \
	ro.qc.sdk.audio.ssr=false \
	ro.qc.sdk.audio.fluencetype=none \
	persist.audio.fluence.voicecall=true \
	persist.audio.fluence.voicerec=false \
	persist.audio.fluence.speaker=true \
	audio.offload.video=true \
	audio.deep_buffer.media=true \
	ro.af.client_heap_size_kbyte=7168 \
	tunnel.audio.encode = true \
	audio.offload.buffer.size.kb=32 \
	av.offload.enable=true \
	audio.offload.gapless.enabled=true \
	qcom.hw.aac.encoder=true \
	debug.stagefright.ccodec=1

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.btstack.aac_frm_ctl.enabled=true \
	persist.vendor.bluetooth.modem_nv_support=true

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
	vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.xiaomi.cameratools,com.factory.mmigroup \
	persist.vendor.camera.expose.aux=1

# CNE and DPM
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.cne.feature=1 \
	persist.dpm.feature=1

# Media
PRODUCT_PROPERTY_OVERRIDES += \
	media.stagefright.enable-player=true \
	media.stagefright.enable-http=true \
	media.stagefright.enable-aac=true \
	media.stagefright.enable-qcp=true \
	media.stagefright.enable-fma2dp=true \
	media.stagefright.enable-scan=true \
	media.stagefright.thumbnail.prefer_hw_codecs=true \
	media.settings.xml=/system/etc/media_profiles_vendor.xml \
	mmp.enable.3g2=true \
	media.aac_51_output_enabled=true \
	mm.enable.smoothstreaming=true \
	vendor.mm.enable.qcom_parser=131071999 \
	persist.mm.enable.prefetch=true

# Netflix
PRODUCT_PROPERTY_OVERRIDES += \
	ro.netflix.bsp_rev=Q6125-17995-1

# Data Modules
PRODUCT_PROPERTY_OVERRIDES += \
	ro.vendor.use_data_netmgrd=true \
	persist.vendor.data.mode=concurrent

# RmNet Data
PRODUCT_PROPERTY_OVERRIDES += \
	persist.rmnet.data.enable=true \
	persist.data.wda.enable=true \
	persist.data.df.dl_mode=5 \
	persist.data.df.ul_mode=5 \
	persist.data.df.agg.dl_pkt=10 \
	persist.data.df.agg.dl_size=4096 \
	persist.data.df.mux_count=8 \
	persist.data.df.iwlan_mux=9 \
	persist.data.df.dev_name=rmnet_usb0

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
	rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so \
	ril.subscription.types=RUIM \
	DEVICE_PROVISIONED=1 \
	ro.telephony.default_network=9,9 \
	persist.vendor.radio.atfwd.start=true \
	persist.radio.NO_STAPA=1 \
	persist.vendor.radio.ignore_dom_time=5 \
	telephony.lteOnCdmaDevice=1 \
	persist.vendor.radio.force_on_dc=true \
	persist.vendor.ims.dropset_feature=1

# RCS
PRODUCT_PROPERTY_OVERRIDES += \
	ro.com.google.acsa=true \
	persist.rcs.supported=0

# Sensors
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.sensors.enable.mag_filter=true

# Time services
PRODUCT_PROPERTY_OVERRIDES += \
	persist.timed.enable=true

# WFD
PRODUCT_PROPERTY_OVERRIDES += \
	persist.debug.wfd.enable=1 \
	persist.sys.wfd.virtual=0

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
	ro.hwui.texture_cache_size=72 \
	ro.hwui.layer_cache_size=48 \
	ro.hwui.r_buffer_cache_size=8 \
	ro.hwui.path_cache_size=32 \
	ro.hwui.gradient_cache_size=1 \
	ro.hwui.drop_shadow_cache_size=6 \
	ro.hwui.texture_cache_flushrate=0.4 \
	ro.hwui.text_small_cache_width=1024 \
	ro.hwui.text_small_cache_height=1024 \
	ro.hwui.text_large_cache_width=2048 \
	ro.hwui.text_large_cache_height=1024 \
	ro.opengles.version=196610 \
	debug.sf.enable_hwc_vds=1 \
	debug.sf.latch_unsignaled=1 \
	persist.sys.force_sw_gles=1 \
	ro.build.display.wtid.miui=SW_S88512AA1_V001_M13_XM_F9S_USR_MP \
	ro.build.display.wtid.ato=SW_S88512AA1_V001_M13_XM_F9S_USR_ATO

# GPS
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.overlay.izat.optin=rro

# ETC
PRODUCT_PROPERTY_OVERRIDES += \
	ro.colorpick_adjust=true \
	sys.paper_mode_max_level=255 \
	ro.df.effect.conflict=1 \
	ro.vendor.qti.va_aosp.support=1 \
	persist.fuse_sdcard=true \
	use.voice.path.for.pcm.voip=true \
	sys.qca1530=detect \
	persist.debug.coresight.config=stm-events


