# ArchInstall

Script de instalação do sistema operacional GNU via distribuição ArchLinux Rolling.

## Procedimento

1. **Baixe a ArchISO**:
   - Acesse o site oficial do Arch Linux em [archlinux.org](https://archlinux.org/download/) e baixe a imagem ISO mais recente.

2. **Crie um Pendrive de Instalação**:
   - Utilize um software de criação de mídia USB, como o Etcher, Rufus ou dd, para gravar a imagem ISO em um pendrive de pelo menos 2GB de capacidade.

3. **Coloque os scripts em OUTRO pendrive**:
   - Baixe todos os arquivos deste repositório e os coloque em um pendrive.

4. **Inicie o Computador a partir do Pendrive de Instalação**:
   - Insira o pendrive de instalação no computador e reinicie-o.
   - Acesse a BIOS ou o menu de inicialização do sistema e configure-o para inicializar a partir do pendrive.

5. **Instalação**:
   - Após inicializar a partir do pendrive, você será recebido com um terminal de comandos. Este é o ambiente de instalação do Arch Linux.
   - Insira o pendrive com os scripts.
   - Monte pendrive de scripts com o comando `mount /dev/sdb1 /pendrive --mkdir`.
   - Acesse o pendrive `cd /pendrive`.
   - De permissão de execução para o primeiro scritp `chmod +x 1-preInstallGNU.sh`.
   - Verifique se você possui uma conexão com a Internet. Você pode testar a conectividade com o comando `ping google.com`.
   - Execute o script `1-preInstallGNU.sh` com o comando `./1-preInstallGNU.sh` e siga o passo a passo.
   - OBS: Caso não tenha conectividade com a internet, este script poderá conectar a internet em caso de IP estático. Outros tipos de conexão serão adicionando futuramente. Caso sua conexão seja IP dinâmico, wifi, etc, acesse a ArchWiki para saber como conectar.
   - OBS2: Os scritps 2, 3 e 4 só funcionam com conexão a internet. 


6. **Reinicie o Computador**:
   - Após concluir a execução de todos os scripts, reinicie o computador e remova o pendrive de instalação.

## Dicas e correções

Corrigindo problemas de acesso em /etc/shadow:

```Bash
sudo chattr -a /etc/shadow
```

Alterando locale para pt_BR:

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
