# 🛡️ SIEM Home Lab : Déploiement et Configuration Wazuh (XDR)

Ce dépôt documente la mise en place d'un environnement de détection d'intrusions (SOC / Blue Team) utilisant **Wazuh** et la suite **Elastic (ELK)**. Il contient mes scripts d'automatisation et mes règles de détection personnalisées.

## 🏗️ Architecture du Lab

* **Wazuh Manager :** Hébergé sur une machine virtuelle locale (ou instance AWS). Centralise la collecte et l'analyse des logs.
* **Wazuh Agents :** Déployés sur des terminaux Linux/Windows pour la surveillance en temps réel (File Integrity Monitoring, Rootkit detection).

## 🚀 Contenu du Dépôt

1.  **`/scripts/`** : Scripts de déploiement "Infrastructure as Code". (ex: `install_agent.sh` pour automatiser l'intégration d'un nouveau serveur au SIEM).
2.  **`/custom_rules/`** : Règles XML personnalisées écrites pour affiner la détection.
3.  **`/screenshots/`** : Preuves de concept et tableaux de bord d'analyse.

## 🎯 Scénario d'Attaque & Détection (Proof of Concept)

**Scénario :** Une attaque par Force Brute SSH (MITRE ATT&CK T1110) est lancée contre un serveur surveillé.

**Réponse du SOC :**
1. L'agent collecte les logs `/var/log/auth.log` et les envoie au Manager.
2. La règle personnalisée `100002` (voir dossier `custom_rules`) est déclenchée après 5 tentatives infructueuses en moins de 120 secondes.
3. Une alerte de niveau 12 (Critique) remonte sur le Dashboard Kibana.
*(Mettre ici un faux lien d'image en attendant : `![Alerte Kibana](screenshots/kibana_alert.png)`)*

## 💡 Prochaines Étapes (Active Response)
* Implémentation d'un script Bash déclenché par le Manager pour ajouter automatiquement l'IP attaquante dans les règles `iptables` du pare-feu local (Remédiation automatisée).