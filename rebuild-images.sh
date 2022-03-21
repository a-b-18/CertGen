# Rebuild all docker images with their respective tags
docker build root/build/ -t alex2222/certificate-authority
docker-compose down
docker-compose up -d
