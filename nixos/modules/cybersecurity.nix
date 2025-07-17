{ config, pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    # 🔍 Reconnaissance — Outils pour collecter des infos sur la cible
    nmap           # Scan de ports et détection de services
    amass          # Cartographie d'infrastructure DNS (reconnaissance passive et active)
    masscan        # Scan de ports ultra-rapide (comme nmap mais en + rapide)
    whatweb        # Détection des technologies web utilisées par un site
    theharvester   # Collecte d’emails, sous-domaines, noms d’utilisateurs via sources publiques
    dnsenum        # Enumeration DNS (brute-force, transfert de zone, etc.)
    dnsrecon       # Reconnaissance DNS avec différents types de tests

    # 🧪 Web Pentest — Pour tester les failles dans les applis web
    sqlmap         # Injection SQL automatique
    ffuf           # Fuzzer d’URL (brute-force de fichiers/répertoires)
    httpx          # Probing HTTP rapide (status code, titres, technologies…)
    burpsuite      # Proxy d’interception, scan de vulnérabilités web
    zap            # Zed Attack Proxy (OWASP) — audit automatisé des sites

    # 🧠 Auth / Bruteforce — Test d’authentification ou de hash
    hydra          # Bruteforce de mots de passe sur services réseau (FTP, SSH, HTTP, etc.)
    john           # John the Ripper — Cracker de mots de passe/hashs
    hashcat        # Cracker de hash GPU-accéléré (ultra puissant)

    # 🛠️ Exploitation / Post-exploitation — Pour exploiter les failles et prendre la main
    metasploit     # Framework d’exploitation automatisée
    armitage       #Graphical cyber attack management tool for Metasploit
    exploitdb      # Base de données locale d’exploits connus (via `searchsploit`)
    netcat         # Shell réseau (écoute/envoi de données, reverse shell)
    socat          # Comme netcat mais plus flexible (redirections réseau complexes)

    # 📡 Sniffing / MITM — Surveillance du trafic réseau
    wireshark      # Analyse graphique des paquets réseau
    tcpdump        # Analyse en ligne de commande du trafic réseau
    ettercap       # Attaques de type MITM, spoof ARP, sniffing, etc.

    # 📦 VPN / Réseau — Accès distant sécurisé
    openvpn        # Client/serveur VPN

    # 🧰 Utils / Bonus — Outils utiles ou complémentaires
    seclists       # Collection de wordlists pour tests bruteforce et fuzzing
    jq             # Manipulation de JSON en ligne de commande
    xmlstarlet     # Manipulation de XML en ligne de commande
  ];
}

