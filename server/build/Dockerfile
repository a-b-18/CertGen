FROM ubuntu:18.04 AS IntermediateAuthority

# Install needed packages
RUN apt update && apt install openssh-server sudo -y && apt install nano

# Create SSH user
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:password' | chpasswd
RUN service ssh start

# CA Directory Setup
RUN mkdir /root/ca && cd /root/ca
RUN mkdir /root/ca/newcerts /root/ca/certs /root/ca/crl /root/ca/private /root/ca/requests && touch /root/ca/index.txt && echo '1234' >> /root/ca/serial

# Certificate Creation/Signing
COPY . .
RUN openssl genrsa -aes256 -passout pass:1234 -out /root/ca/private/server.pass.key 4096
RUN openssl rsa -passin pass:1234 -in /root/ca/private/server.pass.key -out /root/ca/private/server.key
RUN rm /root/ca/private/server.pass.key
RUN openssl req -new -key /root/ca/private/server.key -out /root/ca/requests/server.csr \
        -subj "/C=AU/ST=Tasmania/L=Hobart/O=AlexTestServers/OU=Test Department/CN=alex.alexserver.com"
RUN openssl x509 -req -days 365 -in /root/ca/requests/server.csr -signkey /root/ca/private/server.key -out /root/ca/certs/server.crt
RUN openssl pkcs12 -export -out /root/ca/newcerts/cert.pfx -inkey /root/ca/private/server.key -in /root/ca/certs/server.crt -certfile /root/ca/certs/server.crt -passout pass:1234

# Allow file access
RUN chown user -R /root

# Expose SSH and persistent service
EXPOSE 22
EXPOSE 443
CMD ["/usr/sbin/sshd","-D"]
