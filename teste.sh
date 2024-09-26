#!/bin/bash

# Atualizar a lista de pacotes e fazer upgrade
sudo apt update && sudo apt upgrade -y

# Instalar pacotes
sudo apt install -y \
    mysql-client \
    iotop \
    ncdu
