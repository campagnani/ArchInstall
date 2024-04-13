#!/bin/bash

echo """
###############################################################
###############################################################
######                                                   ######
######  Instalação do Sistema Operacional GNU para UFMG  ######
######                                                   ######
######                                                   ######
######          Distribuição: ArchLinux Rolling          ######
######                                                   ######
######         Autor: Thalles Oliveira Campagnani        ######
######                                                   ######
###############################################################
###############################################################
######                                                   ######
######                     PARTE 4:                      ######
######         Instalação do Ambiente de Desktop         ######
######               e outros programas                  ######
######                                                   ######
###############################################################
###############################################################


"""
read -p "Pressione enter para iniciar... "

# Instalação do Ambiente de Desktop
echo "{[( Instalação de Ambiente Desktop )]}"
read -p "Instalar ambiente de desktop KDE Plasma? [y/N]: " plasma
if [[ $plasma == "y" || $plasma == "Y" ]]; then
    pacman -Sy plasma kde-applications firefox
    systemctl enable sddm.service
fi

read -p "Instalar ambiente de desktop LXDE? [y/N]: " lxde
if [[ $lxde == "y" || $lxde == "Y" ]]; then
    pacman -Sy lxde lxdm obconf xfce4-power-manager network-manager-applet deepin-icon-theme gnome-screenshot vlc xarchiver gedit firefox
    systemctl enable lxdm.service
fi

# Instalação de programas extras
echo "{[( Instalação de programas extras )]}"

read -p """Instalar programas extras? Lista:
grub-customizer
code
qbittorrent 
gimp
inkscape 
gparted 
obs-studio 
torbrowser-launcher 
unrar 
zip 
discord
[y/N]: """ extras
if [[ $extras == "y" || $extras == "Y" ]]; then
    pacman -Sy grub-customizer code qbittorrent gimp inkscape gparted obs-studio torbrowser-launcher unrar zip discord
fi

# Instalação de chaotic-aur
echo "{[( Instalação de programas do chaoric-aur )]}"
read -p """Deseja adicionar repositório chaoric-aur e instalar mais programas? Lista:
visual-studio-code-bin
google-chrome
wps-office
realvnc-vnc-viewer
[y/N]: """ chaoric
if [[ $chaoric == "y" || $chaoric == "Y" ]]; then
    pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    pacman-key --lsign-key 3056513887B78AEB
    pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    echo """

    [chaotic-aur]
    Include = /etc/pacman.d/chaotic-mirrorlist
    
    """ >> /etc/pacman.conf
    pacman -Sy visual-studio-code-bin google-chrome wps-office realvnc-vnc-viewer
fi

