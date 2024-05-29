
FROM kalilinux/kali-rolling
RUN apt-get update && apt-get install -y python3 sudo wordlists python3-pip git iputils-ping nmap hashcat nano\
    && pip3 install flask-unsign && pip3 install setuptools && pip3 install impacket
RUN useradd -m successful && echo "successful:boule" | chpasswd && usermod -aG sudo successful
USER successful
CMD ["/bin/bash"]
