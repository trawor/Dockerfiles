# Do We TRUST the 'FROM' Images? 

FROM productionwentdown/caddy as builder

FROM trawor/alpine

ENV ACME_AGREE=true
EXPOSE 80 443

# copy binary and ca certs
COPY --from=builder /bin/caddy /bin/caddy
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# set default caddypath
ENV CADDYPATH=/etc/.caddy
ENV VHOSTS_PATH=${CADDYPATH}/vhosts

RUN mkdir -p ${VHOSTS_PATH} && \
  echo "Hello Caddy" > /srv/index.html && \
  echo $'0.0.0.0:80 {\n  root /srv \n}' > ${VHOSTS_PATH}/default.conf && \
  echo $'import {%VHOSTS_PATH%}/*.conf' > /etc/Caddyfile

VOLUME ${CADDYPATH}
WORKDIR /srv

RUN echo $'#!/bin/sh\nmkdir -p ${VHOSTS_PATH}\nexec "$@"' > /bin/entrypoint.sh && chmod +x /bin/entrypoint.sh
ENTRYPOINT [ "/bin/entrypoint.sh" ]
CMD [ "caddy","--agree","--conf","/etc/Caddyfile","--log","stdout" ]


