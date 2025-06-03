FROM kalilinux/kali-rolling

# Mise à jour et installation des paquets nécessaires
RUN apt-get update -o Acquire::Retries=3 -o Acquire::http::Timeout="20" \
    && apt-get install -y python3 sudo wordlists python3-pip git iputils-ping nmap wpscan hashcat dirbuster nano mimikatz nikto curl python3-venv sqlmap finalrecon sherlock \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configuration de l'environnement Python
RUN python3 -m venv /home/successful/venv
ENV PATH="/home/successful/venv/bin:$PATH"
RUN pip install --upgrade pip \
    && pip install flask-unsign setuptools

RUN apt-get update \
    && apt-get install -y libgmp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip install gmpy2

# Création de l'utilisateur "successful"
RUN useradd -m successful \
    && echo "successful:boule" | chpasswd \
    && usermod -aG sudo successful

# Installation des outils nécessaires
RUN mkdir -p /home/successful/tools \
    && git clone https://github.com/SecureAuthCorp/impacket.git /home/successful/tools/impacket \
    && cd /home/successful/tools/impacket \
    && pip install .

RUN git clone https://github.com/ticarpi/jwt_tool /home/successful/tools/jwt_tool \
    && cd /home/successful/tools/jwt_tool \
    && pip install -r requirements.txt \
    && chown -R successful:successful /home/successful/tools/jwt_tool

# Installation de VSCodium, semgrep, uuidtool
RUN apt-get update \
    && apt-get install -y wget gnupg software-properties-common \
    && wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
        | gpg --dearmor \
        | tee /usr/share/keyrings/vscodium-archive-keyring.gpg > /dev/null \
    && echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' \
        > /etc/apt/sources.list.d/vscodium.list \
    && apt-get update \
    && apt-get install -y codium pipx git \
    && pipx ensurepath \
    && pipx install semgrep \
    && git clone https://github.com/semgrep/semgrep-rules.git /home/successful/semgrep-rules \
    && pipx install git+https://github.com/crazycat256/uuidtool \
    && ln -s /root/.local/bin/uuidtool /usr/local/bin/uuidtool \
    && chown -R successful:successful /home/successful/semgrep-rules

# Configuration pour permettre l'accès root
USER root
WORKDIR /root
CMD ["/bin/bash"]