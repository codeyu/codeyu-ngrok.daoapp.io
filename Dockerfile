FROM golang:1.7.4-alpine
MAINTAINER codeyu

RUN apk add --no-cache git make openssl

RUN git clone https://github.com/codeyu/ngrok.git /ngrok

ADD *.sh /

ENV DOMAIN tenxcloud.net
ENV NGROK_VOLUME /data/ngrok
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :8080
ENV HTTPS_ADDR :8081

EXPOSE 4443
EXPOSE 8080
EXPOSE 8081

RUN chmod +x /*.sh

CMD ["/server.sh"]