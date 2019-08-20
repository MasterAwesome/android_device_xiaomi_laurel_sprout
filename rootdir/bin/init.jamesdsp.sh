#!/system/bin/sh

mount -o remount,rw /vendor
touch /vendor/lib/soundfx/libjamesdsp.so
mount -o remount,ro /vendor
