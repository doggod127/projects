#!/bin/bash

# set time zone 
ln -sf /usr/share/zoneinfo/Europe/Moscow

# set system clock
hwckock --systohc

# set locale TBD: ADD CYRILLIC LOCALE
echo >> /etc/locale.gen "en_US.UTF-8 UTF-8"
locale-gen

# set hostname
touch /etc/hostname
echo > /etc/hostname "hp14s"

# set hosts
echo >> /etc/hosts "127.0.0.1   localhost"
echo >> /etc/hosts "::1         localhost"
echo >> /etc/hosts "127.0.1.1   hp14s.localdomain hp14s"

# create user and set password
passwd
useradd -m doggot 
passwd doggot
usermod -aG wheel,audio,video,optical,storage doggot

# install sudo and user to sudo group
pacman -S sudo
echo >> /etc/sudoers.tmp %wheel ALL=(ALL) ALL

# install grub
pacman -Sy grub efibootmgr os-prober dosfstools mtools
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# install miscellenious
pacman -S networkmanager vim

# start network manager
systemctl enable NetworkManager