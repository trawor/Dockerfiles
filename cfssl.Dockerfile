FROM trawor/alpine

RUN apk add --no-cache sqlite

# TODO: will remove this line after cfssl is in stable repo of alpine
RUN apk add --no-cache cfssl --repository https://mirrors.aliyun.com/alpine/edge/testing

RUN mkdir -p /etc/cfssl
WORKDIR /etc/cfssl

# Exose ports & volumes
VOLUME ["/etc/cfssl", "/cfssl_trust"]
EXPOSE 8080


CMD ["cfssl", \
  "serve", \
  "-address=0.0.0.0", \
  "-port=8080", \
  "-ca=/etc/cfssl/ca.pem", \
  "-ca-key=/etc/cfssl/ca-key.pem", \
  "-db-config=/etc/cfssl/dbconfig.json" \
  ]