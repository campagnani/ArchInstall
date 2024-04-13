# ArchInstall

Script de instalação do sistema operacional GNU via distribuição ArchLinux Rolling.

Script baseado no guia de instalação official disponível na ArchWiki.

OBS: Locale, conexão a internet e particionamento de disco são coisas muito pessoais, esse script está configurado respectivamente para:
   - pt_BR
   - IP fixo
   - Partição home separada, com 1° patição para sistema EFI.

Caso suas necessidades forem diferente disto, modifique o script baseando-se na ArchWiki antes de partir para o processo de instalação.

## Passo a passo

1. **Baixe a ArchISO**:
   - Acesse o site oficial do Arch Linux em [archlinux.org](https://archlinux.org/download/) e baixe a imagem ISO mais recente.

2. **Crie um Pendrive de Instalação**:
   - Utilize um software de criação de mídia USB, como o Etcher, Rufus ou dd, para gravar a imagem ISO em um pendrive de pelo menos 2GB de capacidade.

3. **Coloque os scripts em OUTRO pendrive**:
   - Baixe todos os arquivos deste repositório e os coloque em um pendrive, modifique os scripts conforme suas necessidades.

4. **Inicie o Computador a partir do Pendrive de Instalação**:
   - Insira o pendrive de instalação no computador e reinicie-o.
   - Acesse a BIOS ou o menu de inicialização do sistema e configure-o para inicializar a partir do pendrive.
   - Após inicializar a partir do pendrive, você será recebido com um terminal de comandos. Este é o ambiente de instalação do Arch Linux.

5. **Instalação**:
   - Insira o pendrive com os scripts.
   - Monte pendrive de scripts e acesse a pasta montada com o comando (talvez seu pendrive tenha outro nome de dispositivo, virifique com `fdisk -l`):
    ```Bash
    mount /dev/sdb1 /pendrive --mkdir && cd /pendrive
    ```
   - De permissão de execução e execute o primeiro script com o comando:
    ```Bash
    chmod +x 1-preInstallGNU.sh && ./1-preInstallGNU.sh
    ```
   - Agora só seguir o passo a passo do script.

6. **Reinicie o Computador**:
   - Após concluir a execução de todos os scripts, reinicie o computador e remova o pendrive de instalação.

## Dicas e correções

Algumas dicas e também correções de alguns problemas que eventualmente pode surgir.

### Dicas

Alterando locale completo para pt_BR:

```Bash
echo """
LANG=pt_BR.UTF-8
LANGUAGE=pt_BR.UTF-8
LC_ALL=pt_BR.UTF-8
LC_ADDRESS=pt_BR.UTF-8
LC_COLLATE=pt_BR.UTF-8
LC_CTYPE=pt_BR.UTF-8
LC_IDENTIFICATION=pt_BR.UTF-8
LC_MEASUREMENT=pt_BR.UTF-8
LC_MESSAGES=pt_BR.UTF-8
LC_MONETARY=pt_BR.UTF-8
LC_NAME=pt_BR.UTF-8
LC_NUMERIC=pt_BR.UTF-8
LC_PAPER=pt_BR.UTF-8
LC_TELEPHONE=pt_BR.UTF-8
LC_TIME=pt_BR.UTF-8
""" > locale.conf
sudo mv locale.conf /etc/locale.conf
```

Alguns programas úteis:

```Bash
sudo pacman -Syu grub-customizer code qbittorrent gimp inkscape gparted obs-studio torbrowser-launcher unrar zip discord
```

Instalando ChaoticAUR:

```Bash
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

```Bash
sudo pacman -Syu visual-studio-code-bin google-chrome wps-office realvnc-vnc-viewer
```

Adicionando usuário com sudo:

```Bash
ADDUSER=user #Coloque seu nome aqui
sudo useradd -m $ADDUSER && sudo usermod -aG wheel $ADDUSER && sudo passwd $ADDUSER
```

### Correções

Corrigindo problemas de acesso em /etc/shadow:

```Bash
sudo chattr -a /etc/shadow
```

Corrigindo problema de chaves em uma grande atualização:

```Bash
sudo pacman -Sy archlinux-keyring
sudo pacman -Syu
```

Corrigindo "possible missing firmware":

```Bash
#https://wiki.archlinux.org/title/mkinitcpio
sudo pacman -Syu mkinitcpio-firmware
```

Atualizando instalação do GRUB:

```Bash
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
