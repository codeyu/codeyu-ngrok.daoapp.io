#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

if [ ! -d "${NGROK_VOLUME}" ]; then
    mkdir ${NGROK_VOLUME}
    exit 1
fi

if [ ! -f "${NGROK_VOLUME}/bin/ngrokd" ]; then
    echo "ngrokd is not build,will be build it now..."
    /bin/sh /build.sh
fi


${NGROK_VOLUME}/bin/ngrokd -tlsKey=${NGROK_VOLUME}/device.key -tlsCrt=${NGROK_VOLUME}/device.crt -domain="${DOMAIN}" -httpAddr="${HTTP_ADDR}" -httpsAddr="${HTTPS_ADDR}" -tunnelAddr=${TUNNEL_ADDR}