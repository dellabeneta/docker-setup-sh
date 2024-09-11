#!/bin/bash

# Definindo códigos de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem cor

# Função para exibir uma mensagem e aguardar o usuário pressionar Enter
pause() {
  echo -e "${YELLOW}$1${NC}"
  read -p "Pressione Enter para continuar..."
}

# Etapa 1: Adicionar a chave GPG oficial do Docker
pause "Etapa 1: Adicionar a chave GPG oficial do Docker."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Etapa 2: Adicionar o repositório do Docker às fontes do Apt
pause "Etapa 2: Adicionar o repositório do Docker às fontes do Apt."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

# Etapa 3: Instalar o Docker
pause "Etapa 3: Instalar o Docker."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Etapa 4: Adicionar seu usuário ao grupo Docker
pause "Etapa 4: Adicionar seu usuário ao grupo Docker."
sudo usermod -aG docker $USER

# Perguntar ao usuário se deseja reiniciar o sistema
echo -e "${GREEN}Instalação concluída. É necessário reiniciar a sessão para aplicar as mudanças no grupo.${NC}"
read -p "Deseja reiniciar o sistema agora? (s/n): " resposta

if [[ "$resposta" =~ ^[Ss]$ ]]; then
  echo -e "${RED}Reiniciando o sistema...${NC}"
  sudo reboot
else
  echo -e "${GREEN}Você pode reiniciar o sistema mais tarde para aplicar as mudanças.${NC}"
fi

