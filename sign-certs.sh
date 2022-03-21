# Transfer intermediate certificate signing request

# Sign intermediate certificate
ssh -p 1880 user@127.0.0.1 
openssl ca -in /root/ca-root/requests/server.txt -passin pass:1234 -out /root/ca-root/newcerts/server.cer

# Transfer signed intermediate certificate
