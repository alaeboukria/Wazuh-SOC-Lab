#!/bin/bash
# Script de déploiement automatisé d'Agent Wazuh (Blue Team Lab)
# Auteur: Alae-Eddine Boukria

WAZUH_MANAGER_IP="192.168.1.100" # Remplacer par l'IP du Manager
AGENT_GROUP="linux-servers"

echo "[*] Début de l'installation de l'Agent Wazuh..."

# 1. Ajout de la clé GPG et du dépôt
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list

# 2. Installation de l'agent
apt-get update
WAZUH_MANAGER="$WAZUH_MANAGER_IP" WAZUH_AGENT_GROUP="$AGENT_GROUP" apt-get install wazuh-agent -y

# 3. Démarrage du service
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent

echo "[+] Agent installé et connecté au Manager ($WAZUH_MANAGER_IP) avec succès."