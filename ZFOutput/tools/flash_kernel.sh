#!/sbin/sh
 # 
 #
 # Live ramdisk patching script
 #
 # This software is licensed under the terms of the GNU General Public
 # License version 2, as published by the Free Software Foundation, and
 # may be copied, distributed, and modified under those terms.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # Please maintain this if you use this script or any part of it
 #
cd /tmp/
/sbin/busybox dd if=/dev/block/by-name/boot of=./boot.img
./unpackbootimg -i /tmp/boot.img
./mkbootimg --kernel /tmp/bzImage --ramdisk /tmp/boot.img-ramdisk.gz --cmdline "init=/init pci=noearly loglevel=0 vmalloc=256M androidboot.hardware=mofd_v1 watchdog.watchdog_thresh=60 androidboot.spid=xxxx:xxxx:xxxx:xxxx:xxxx:xxxx androidboot.serialno=01234567890123456789 snd_pcm.maximum_substreams=8 ip=50.0.0.2:50.0.0.1::255.255.255.0::usb0:on debug_locks=0 bootboost=1 androidboot.selinux=permissive"  --base 0x10000000 --pagesize 2048 --ramdisk_offset 0x01000000 --tags_offset 0x00000100 --second /tmp/second.img -o /tmp/newboot.img
/sbin/busybox dd if=/tmp/newboot.img of=/dev/block/by-name/boot
