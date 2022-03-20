# Transfer intermediate certificate signing request

# Sign intermediate certificate
ssh -p 1880 user@127.0.0.1 
openssl ca -in /root/ca-root/requests/intermediate.csr -passin pass:1234 -out /root/ca-root/newcerts/intermediatecert.pem

# Transfer signed intermediate certificate

# Transfer server certificate signing request

# Sign server certificate
ssh -p 1881 user@127.0.0.1 
openssl ca -in /root/ca-intermediate/requests/server.csr -passin pass:1234 -out /root/ca-intermediate/newcerts/servercert.pem

# Transfer signed server certificate

# Transfer server certificate signing request

# Create certificate export
ssh -p 1882 user@127.0.0.1 
openssl pkcs12 -export -out /root/ca-server/newcerts/servercert.pfx -inkey /root/ca-server/private/serverkey.pem -in /root/ca-server/servercert.pem -certfile /root/ca-server/servercert.pem -passin pass:1234 -passout pass:1234

# Transfer signed server certificate
