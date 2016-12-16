#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

if [ ! -d "${MY_FILES}" ]; then
  mkdir ${MY_FILES}
fi

if [ ! -f "${MY_FILES}/bin/ngrokd" ]; then
    echo "ngrokd is not build,will be build it now..."
    /bin/sh /build.sh
fi


${MY_FILES}/bin/ngrokd -tlsKey=${MY_FILES}/device.key -tlsCrt=${MY_FILES}/device.crt -domain="${DOMAIN}" -httpAddr="${HTTP_ADDR}" -httpsAddr="${HTTPS_ADDR}"