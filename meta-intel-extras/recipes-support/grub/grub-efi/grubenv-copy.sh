#!/bin/sh

if [ ! -f /boot/EFI/BOOT/grubenv ]; then
    cp /usr/share/grubenv /boot/EFI/BOOT/grubenv
fi
