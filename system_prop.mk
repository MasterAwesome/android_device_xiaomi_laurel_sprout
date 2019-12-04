# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    audio.deep_buffer.media=true \
    audio.offload.buffer.size.kb=32 \
    audio.offload.gapless.enabled=true \
    audio.offload.video=true \
    av.offload.enable=true \
    debug.stagefright.ccodec=1 \
    persist.audio.fluence.speaker=true \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.voicerec=false \
    qcom.hw.aac.encoder=true \
    ro.af.client_heap_size_kbyte=7168 \
    ro.qc.sdk.audio.fluencetype=none \
    ro.qc.sdk.audio.ssr=false \
    tunnel.audio.encode = true \
    use.voice.path.for.pcm.voip=true

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.bluetooth.modem_nv_support=true \
    persist.vendor.btstack.aac_frm_ctl.enabled=true

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.camera.expose.aux=1 \
    vendor.camera.aux.packagelist=org.codeaurora.snapcam,com.android.camera,com.xiaomi.cameratools,com.factory.mmigroup

# CNE and DPM
PRODUCT_PROPERTY_OVERRIDES += \
    persist.dpm.feature=1 \
    persist.vendor.cne.feature=1

# IMS
PRODUCT_PROPERTY_OVERRIDES += \
    persist.dbg.ims_volte_enable=1 \
    persist.dbg.volte_avail_ovr=1 \
    persist.dbg.vt_avail_ovr=1 \
    persist.dbg.wfc_avail_ovr=1

# set lmkd options
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lmk.low_ram=false \
    ro.lmk.kill_heaviest_task=true \
    ro.lmk.kill_timeout_ms=100 \
    ro.lmk.use_minfree_levels=true

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true \
    media.settings.xml=/system/etc/media_profiles_vendor.xml \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-fma2dp=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-player=true \
    media.stagefright.enable-qcp=true \
    media.stagefright.enable-scan=true \
    media.stagefright.thumbnail.prefer_hw_codecs=true \
    mm.enable.smoothstreaming=true \
    mmp.enable.3g2=true \
    persist.mm.enable.prefetch=true \
    vendor.mm.enable.qcom_parser=131071999

# Netflix
PRODUCT_PROPERTY_OVERRIDES += \
    ro.netflix.bsp_rev=Q6125-17995-1

# Data Modules
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.data.mode=concurrent \
    ro.vendor.use_data_netmgrd=true

# RmNet Data
PRODUCT_PROPERTY_OVERRIDES += \
    persist.data.df.agg.dl_pkt=10 \
    persist.data.df.agg.dl_size=4096 \
    persist.data.df.dev_name=rmnet_usb0 \
    persist.data.df.dl_mode=5 \
    persist.data.df.iwlan_mux=9 \
    persist.data.df.mux_count=8 \
    persist.data.df.ul_mode=5 \
    persist.data.wda.enable=true \
    persist.rmnet.data.enable=true

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    DEVICE_PROVISIONED=1 \
    persist.radio.NO_STAPA=1 \
    persist.vendor.ims.dropset_feature=1 \
    persist.vendor.radio.atfwd.start=true \
    persist.vendor.radio.force_on_dc=true \
    persist.vendor.radio.ignore_dom_time=5 \
    ril.subscription.types=RUIM \
    rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so \
    ro.telephony.default_network=9,9 \
    telephony.lteOnCdmaDevice=1

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
    debug.sf.enable_hwc_vds=1 \
    debug.sf.latch_unsignaled=1 \
    persist.sys.force_sw_gles=1 \
    ro.build.display.wtid.ato=SW_S88512AA1_V001_M13_XM_F9S_USR_ATO \
    ro.build.display.wtid.miui=SW_S88512AA1_V001_M13_XM_F9S_USR_MP \
    ro.colorpick_adjust=true \
    ro.hwui.drop_shadow_cache_size=6 \
    ro.hwui.gradient_cache_size=1 \
    ro.hwui.layer_cache_size=48 \
    ro.hwui.path_cache_size=32 \
    ro.hwui.r_buffer_cache_size=8 \
    ro.hwui.text_large_cache_height=1024 \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_small_cache_height=1024 \
    ro.hwui.text_small_cache_width=1024 \
    ro.hwui.texture_cache_flushrate=0.4 \
    ro.hwui.texture_cache_size=72 \
    ro.opengles.version=196610 \
    sys.paper_mode_max_level=255

# GPS
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.overlay.izat.optin=rro

# ETC
PRODUCT_PROPERTY_OVERRIDES += \
    persist.debug.coresight.config=stm-events \
    persist.fuse_sdcard=true \
    ro.df.effect.conflict=1 \
    ro.vendor.qti.va_aosp.support=1 \
    sys.qca1530=detect
