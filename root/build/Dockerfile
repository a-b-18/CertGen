FROM ubuntu:18.04 AS RootAuthority

# Install needed packages
RUN apt update && apt install openssh-server sudo -y && apt install nano

# Create SSH user
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:password' | chpasswd
RUN service ssh start

# CA Directory Setup
RUN mkdir /root/ca-root && cd /root/ca-root
RUN mkdir /root/ca-root/newcerts /root/ca-root/certs /root/ca-root/crl /root/ca-root/private /root/ca-root/requests && touch /root/ca-root/index.txt && echo '1234' >> /root/ca-root/serial

# Certificate Creation/Signing
COPY . .

# Create root private key
RUN openssl genrsa -aes256 -passout pass:1234 -out /root/ca-root/private/cakey.pem 4096

# Self-sign root certificate
RUN openssl req -new -x509 -key /root/ca-root/private/cakey.pem -out /root/ca-root/cacert.cer -passin pass:1234 -days 3650 -set_serial 0\
        -subj "/C=AU/ST=NewSouthWales/L=Sydney/O=AlexsCompany/OU=Alex's Department/CN=ca.alexrootdomain.com"

# Allow file access
RUN chown user -R /root

# Expose SSH and persistent service
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
