FROM ubuntu:18.04 AS IntermediateAuthority

# Install needed packages
RUN apt update && apt install openssh-server sudo -y && apt install nano

# Create SSH user
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 user 
RUN  echo 'user:password' | chpasswd
RUN service ssh start

# CA Directory Setup
RUN mkdir /root/ca-intermediate && cd /root/ca-intermediate
RUN mkdir /root/ca-intermediate/newcerts /root/ca-intermediate/certs /root/ca-intermediate/crl /root/ca-intermediate/private /root/ca-intermediate/requests && touch /root/ca-intermediate/index.txt && echo '1234' >> /root/ca-intermediate/serial

# Certificate Creation/Signing
COPY . .

# Create intermediate private key
RUN openssl genrsa -aes256 -passout pass:1234 -out /root/ca-intermediate/private/intermediatekey.pem 4096

# Create intermediate certificate signing request
RUN openssl req -new -key /root/ca-intermediate/private/intermediatekey.pem -passin pass:1234 -out /root/ca-intermediate/requests/intermediate.csr\
        -subj "/C=AU/ST=Queensland/L=Brisbane/O=AlexsSubsidary/OU=Sample Department/CN=admin.alextrusteddomain.com"

# Allow file access
RUN chown user -R /root

# Expose SSH and persistent service
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
