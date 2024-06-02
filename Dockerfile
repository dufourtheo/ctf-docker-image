FROM kalilinux/kali-rolling
RUN apt-get update -o Acquire::Retries=3 -o Acquire::http::Timeout="20" \
    && apt-get install -y python3 sudo wordlists python3-pip git iputils-ping nmap hashcat nano mimikatz \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install flask-unsign setuptools
RUN mkdir -p /home/successful/tools \
    && git clone https://github.com/SecureAuthCorp/impacket.git /home/successful/tools/impacket \
    && cd /home/successful/tools/impacket \
    && python3 setup.py install
RUN git clone https://github.com/p0dalirius/ldap2json.git /home/successful/tools/ldap2json \
    && cd /home/successful/tools/ldap2json \
    && pip install -r requirements.txt
RUN useradd -m successful \
    && echo "successful:boule" | chpasswd \
    && usermod -aG sudo successful
USER successful
WORKDIR /home/successful
CMD ["/bin/bash"]
