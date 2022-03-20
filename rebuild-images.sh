# Rebuild all docker images with their respective tags
docker build intermediate/build -t alex2222/intermediate-authority
docker build root/build/ -t alex2222/certificate-authority
docker build server/build -t alex2222/https-server
docker-compose down
docker-compose up -d
