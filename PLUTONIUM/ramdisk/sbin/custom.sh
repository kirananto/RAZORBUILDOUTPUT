#!/system/bin/sh

busybox mount -o remount,rw /system
busybox mount -t rootfs -o remount,rw rootfs

# Synapse
busybox chown 0.0 /res/synapse/*
busybox chown 0.0 /res/synapse/actions/*
busybox chmod -R 755 /res/synapse
busybox ln -fs /res/synapse/uci /sbin/uci
/sbin/uci

# Tweaks
echo 0 > /proc/sys/kernel/randomize_va_space;
echo "20" > /proc/sys/vm/vfs_cache_pressure;
echo "5" > /proc/sys/vm/dirty_background_ratio;
echo "3000" > /proc/sys/vm/dirty_writeback_centisecs;
echo "500" > /proc/sys/vm/dirty_expire_centisecs;
echo "5120000" > /proc/sys/vm/dirty_background_bytes;

# Change SELINUX policy to permissive
setenforce 0;

busybox mount -t rootfs -o remount,ro rootfs
busybox mount -o remount,ro /system

