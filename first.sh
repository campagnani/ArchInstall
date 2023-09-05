#!/bin/bash

# Configuração das partições:
#/dev/nvme0n1p1 - EFI
#/dev/nvme0n1p2 - Windows
#/dev/nvme0n1p3 - Debian
#/dev/nvme0n1p4 - Arch
#/dev/nvme0n1p5 - Home

mount /dev/nvme0n1p4 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot/efi
mount --mkdir /dev/nvme0n1p5 /mnt/home
pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
