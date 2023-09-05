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



ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG = pt_BR.UTF-8" >> /etc/locale.conf
echo "LANGUAGE = pt_BR.UTF-8"  >> /etc/locale.conf
echo "LC_ALL = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_ADDRESS = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_COLLATE = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_CTYPE = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_IDENTIFICATION = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_MEASUREMENT = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_MESSAGES = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_MONETARY = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_NAME = pt_BR.UTF-8" >> /etc/locale.conf 
echo "LC_NUMERIC = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_PAPER = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_TELEPHONE = pt_BR.UTF-8" >> /etc/locale.conf
echo "LC_TIME = pt_BR.UTF-8" >> /etc/locale.conf

echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf

echo "x2640" >> /etc/hostname

pacman -Sy grub efibootmgr intel-ucode
/etc/default/grub
GRUB_TIMEOUT=2
GRUB_CMDLINE_LINUX_DEFAULT=
GRUB_DISABLE_OS_PROBER=false
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

pacman -Sy openssh networkmanager
systemctl enable NetworkManager.service
systemctl enable sshd.service

pacman -S sudo
useradd -m -G wheel -s /bin/bash thalles
passwd 
passwd thalles

reboot
