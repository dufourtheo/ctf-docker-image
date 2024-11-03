FROM kalilinux/kali-rolling
RUN apt-get update -o Acquire::Retries=3 -o Acquire::http::Timeout="20" \
    && apt-get install -y python3 sudo wordlists python3-pip git iputils-ping nmap hashcat nano mimikatz nikto curl python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN python3 -m venv /home/successful/venv
ENV PATH="/home/successful/venv/bin:$PATH"
RUN pip install --upgrade pip \
    && pip install flask-unsign setuptools
RUN apt-get update \
    && apt-get install -y libgmp-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip install gmpy2
RUN mkdir -p /home/successful/tools \
    && git clone https://github.com/SecureAuthCorp/impacket.git /home/successful/tools/impacket \
    && cd /home/successful/tools/impacket \
    && pip install .
RUN useradd -m successful \
    && echo "successful:boule" | chpasswd \
    && usermod -aG sudo successful
USER successful
WORKDIR /home/successful
CMD ["/bin/bash"]
