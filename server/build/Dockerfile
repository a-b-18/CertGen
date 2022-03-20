FROM ubuntu:18.04 AS IntermediateAuthority

# Install needed packages
RUN apt update && apt install openssh-server sudo -y && apt install nano

# Create SSH user
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:password' | chpasswd
RUN service ssh start

# CA Directory Setup
RUN mkdir /root/ca-server && cd /root/ca-server
RUN mkdir /root/ca-server/newcerts /root/ca-server/certs /root/ca-server/crl /root/ca-server/private /root/ca-server/requests && touch /root/ca-server/index.txt && echo '1234' >> /root/ca-server/serial

# Create server private key
RUN openssl genrsa -aes256 -passout pass:1234 -out /root/ca-server/private/serverkey.pem 4096

# Create server certificate signing request
RUN openssl req -new -key /root/ca-server/private/serverkey.pem -passin pass:1234 -out /root/ca-server/requests/server.csr\
        -subj "/C=AU/ST=Queensland/L=Brisbane/O=AlexsSubsidary/OU=Sample Department/CN=admin.alextrusteddomain.com"

# Allow file access
RUN chown user -R /root

# Expose SSH and persistent service
EXPOSE 22
EXPOSE 443
CMD ["/usr/sbin/sshd","-D"]
