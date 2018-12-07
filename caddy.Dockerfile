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
VOLUME /etc/.caddy

WORKDIR /srv
RUN echo "Hello Caddy" > /srv/index.html
RUN echo $'0.0.0.0:80 {\n  root /srv \n}' > /etc/Caddyfile

ENTRYPOINT ["/bin/caddy", "--conf", "/etc/Caddyfile", "--log", "stdout"]