#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

cd ${NGROK_VOLUME}
if [ ! -f "${NGROK_VOLUME}/base.pem" ]; then
    openssl genrsa -out base.key 2048
    openssl req -new -x509 -nodes -key base.key -days 10000 -subj "/CN=${DOMAIN}" -out base.pem
    openssl genrsa -out device.key 2048
    openssl req -new -key device.key -subj "/CN=${DOMAIN}" -out device.csr
    openssl x509 -req -in device.csr -CA base.pem -CAkey base.key -CAcreateserial -days 10000 -out device.crt
fi
cp -r base.pem /ngrok/assets/client/tls/ngrokroot.crt

cd /ngrok
make release-server

cp -r /ngrok/bin ${NGROK_VOLUME}/bin

echo "build ok !"