# MyArchInstall

## Tip's and Fix's

Corrigindo problemas de acesso em /etc/shadow:

```
sudo chattr -a /etc/shadow
```

Criando locale pt_BR.UTF-8:

```
echo LANG=pt_BR.UTF-8 > locale.conf
echo LANGUAGE=pt_BR.UTF-8 >> locale.conf
echo LC_ADDRESS=pt_BR.UTF-8 >> locale.conf
echo LC_COLLATE=pt_BR.UTF-8 >> locale.conf
echo LC_CTYPE=pt_BR.UTF-8 >> locale.conf
echo LC_IDENTIFICATION=pt_BR.UTF-8 >> locale.conf
echo LC_MEASUREMENT=pt_BR.UTF-8 >> locale.conf
echo LC_MESSAGES=pt_BR.UTF-8 >> locale.conf
echo LC_MONETARY=pt_BR.UTF-8 >> locale.conf
echo LC_NAME=pt_BR.UTF-8 >> locale.conf
echo LC_NUMERIC=pt_BR.UTF-8 >> locale.conf
echo LC_PAPER=pt_BR.UTF-8 >> locale.conf
echo LC_TELEPHONE=pt_BR.UTF-8 >> locale.conf
echo LC_TIME=pt_BR.UTF-8 >> locale.conf
sudo mv locale.conf /etc/locale.conf
```

Corrigindo problema de chaves em uma grande atualização:

```
sudo pacman -Sy archlinux-keyring
sudo pacman -Syu
```

Corrigindo "possible missing firmware":

```
#https://wiki.archlinux.org/title/mkinitcpio
paru -S wd719x-firmware
sudo pacman -Syu mkinitcpio-firmware
```

Atualizando instalação do GRUB:

```
sudo grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=Arch_Linux
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Alguns programas úteis:

```
sudo pacman -Syu grub-customizer qbittorrent gimp inkscape gedit gparted gnome-screenshot obs-studio torbrowser-launcher unrar unzip discord
```

Instalando ChaoticAUR:

```
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo -e 'echo "" >> /etc/pacman.conf'
sudo -e 'echo "[chaotic-aur]" >> /etc/pacman.conf'
sudo -e 'echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf'
sudo pacman -Syu
```

Alguns programas úteis no ChaoticAUR:

```
sudo pacman -Syu google-chrome wps-office realvnc-vnc-viewer visual-studio-code-bin
```

Adicionando usuário com sudo:

```
ADDUSER=user
sudo useradd -m $ADDUSER && sudo usermod -aG wheel $ADDUSER && sudo passwd $ADDUSER
```
