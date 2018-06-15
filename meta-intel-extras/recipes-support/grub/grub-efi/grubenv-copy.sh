#!/bin/sh

if [ ! -d /boot/EFI/BOOT/ ]; then
    mount /dev/sda1 /boot
fi

if [ ! -f /boot/EFI/BOOT/grubenv ]; then
    cp /usr/share/grubenv /boot/EFI/BOOT/grubenv
fi
