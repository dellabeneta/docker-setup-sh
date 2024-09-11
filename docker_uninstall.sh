#!/bin/bash

# Definindo códigos de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sem cor

# Função para exibir uma mensagem e aguardar o usuário pressionar Enter
pause() {
  echo -e "${RED}$1${NC}"
  read -p "Pressione Enter para continuar..."
}

# Etapa única: Remover o Docker e seus componentes
pause "Etapa única: Remover o Docker e seus componentes."
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Perguntar ao usuário se deseja reiniciar o sistema
echo -e "${GREEN}Remoção concluída. Você pode reiniciar o sistema para atualizar essas mudanças no grupo.${NC}"
read -p "Deseja reiniciar o sistema agora? (s/n): " resposta

if [[ "$resposta" =~ ^[Ss]$ ]]; then
  echo -e "${RED}Reiniciando o sistema...${NC}"
  sudo reboot
else
  echo -e "${GREEN}Você pode reiniciar o sistema mais tarde para aplicar as mudanças.${NC}"
fi

