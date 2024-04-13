#!/bin/bash

echo """
###############################################################
###############################################################
######                                                   ######
######       Instalação do Sistema Operacional GNU       ######
######                                                   ######
######                                                   ######
######          Distribuição: ArchLinux Rolling          ######
######                                                   ######
######         Autor: Thalles Oliveira Campagnani        ######
######                                                   ######
###############################################################
###############################################################
######                                                   ######
######                     PARTE 1:                      ######
######              Configuração do ArchIso              ######
######             (teclado, internet, etc.)             ######
######                                                   ######
###############################################################
###############################################################


"""
read -p "Pressione enter para iniciar... "

set -e

# Fontes, locales e mapa do teclado
echo "{[( Configurando fontes, locales e mapa do teclado )]}"
loadkeys br-abnt2
#setfont ter-132b
echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
export LANG=pt_BR.UTF-8

# Conectar a internet IP estático
echo "{[( Conectando a internet usando IP estático )]}"
read -p "Digite o seu IP (ou deixe em branco para cancelar): " IP
read -p "Digite a máscara de subrede (geralmente 24): " MASK
read -p "Digite o IP do Gateway: " GATEWAY

# Verificar se o IP foi fornecido
if [[ -z $IP ]]; then
    echo "IP não fornecido. Cancelando."
    exit 1
fi

# Verificar se o IP fornecido é válido
if ! [[ $IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "IP inválido. Por favor, forneça um IP válido."
    exit 1
fi

# Verificar se a máscara de subrede é válida
if ! [[ $MASK =~ ^[0-9]+$ ]]; then
    echo "Máscara de subrede inválida. Por favor, forneça um valor numérico."
    exit 1
fi

# Verificar se o Gateway foi fornecido
if [[ -z $GATEWAY ]]; then
    echo "Gateway não fornecido. Cancelando."
    exit 1
fi

# Aplicar configurações de IP e rota
echo "Configurando endereço IP e rota estática..."
ip address add $IP/$MASK broadcast + dev eno1
ip route add default via $GATEWAY dev eno1

# Verificar se as configurações foram aplicadas corretamente
if [[ $? -eq 0 ]]; then
    echo "Conexão estática configurada com sucesso."
else
    echo "Ocorreu um erro ao configurar a conexão estática."
fi

# Dando permição de executar para próximos scripts
echo "{[( Dando permição de executar para próximos scripts )]}"
chmod +x 2-installGNU.sh
chmod +x 3-configGNU.sh
chmod +x 4-posInstall.sh

echo "{[( Verifique a conexão com a internet e execute o segundo script com ./2-installGNU.sh )]}"