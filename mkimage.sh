#!/bin/sh

# usage: ./mkimage.sh /path/to/buildroot

if [ ! -f $1/output/images/zImage ] ; then
    echo "zImage not found in buildroot/output/images directory."
    echo "Check buildroot path and ensure build is complete."
    exit 1
fi

ROOTUID="0"

if [ "$(id -u)" -ne "$ROOTUID" ] ; then
    echo "This script must be executed with root privileges."
    exit 1
fi

if [ ! -d build ] ; then
    mkdir build
fi

truncate -s 0 build/bridgepi.img
truncate -s 1904M build/bridgepi.img
sfdisk build/bridgepi.img < partitiontable
LOOPDEV=`losetup -f`
losetup -P $LOOPDEV build/bridgepi.img
mkfs.fat -F 32 ${LOOPDEV}p1
mkfs.ext4 ${LOOPDEV}p2
mkdir card1
mkdir card2
mount ${LOOPDEV}p1 card1
mount ${LOOPDEV}p2 card2
cp $1/output/images/rpi-firmware/* card1
cp $1/output/images/*.dtb card1
$1/output/host/usr/bin/mkknlimg $1/output/images/zImage card1/zImage
tar xf $1/output/images/rootfs.tar -C card2
umount card1
umount card2
rmdir card1
rmdir card2
losetup -d $LOOPDEV
