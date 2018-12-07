# Do We TRUST the 'FROM' Images? 

FROM trawor/alpine as builder

RUN apk add --no-cache fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev \
  && wget -qO- https://github.com/aliyun/ossfs/archive/master.tar.gz |tar xz \
  && cd ossfs-master \
  && ./autogen.sh \
  && ./configure --prefix=/usr \
  && make \
  && make install 
#########################################
FROM trawor/alpine
LABEL maintainer="tw@travis.wang"

RUN apk add --no-cache fuse curl libxml2 openssl libstdc++ libgcc
COPY --from=builder /usr/bin/ossfs /usr/bin
##########
ENV OSS_MOUNT_PATH="/var/ossfs"

ENV OSS_ENDPOINT="http://oss-cn-beijing.aliyuncs.com"
ENV OSS_BUCKET="" OSS_KEY_ID="" OSS_KEY_SECRET=""

WORKDIR $OSS_MOUNT_PATH
VOLUME [ $OSS_MOUNT_PATH ]
RUN echo $'\n\
  if [ -z "$OSS_BUCKET" ]; then echo "no ENV for OSS_BUCKET"; exit 1;fi \n\
  if [ -z "$OSS_KEY_ID" ]; then echo "no ENV for OSS_KEY_ID"; exit 1;fi \n\
  if [ -z "$OSS_KEY_SECRET" ]; then echo "no ENV for OSS_KEY_SECRET"; exit 1;fi \n\
  echo ${OSS_BUCKET}:${OSS_KEY_ID}:${OSS_KEY_SECRET} > /etc/passwd-ossfs \n\
  chmod 640 /etc/passwd-ossfs \n\
  mkdir -p $OSS_MOUNT_PATH \n\
  ossfs $OSS_BUCKET $OSS_MOUNT_PATH -ourl=$OSS_ENDPOINT \n\
  exec "$@"' > /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "/bin/sh","/usr/local/bin/docker-entrypoint.sh" ]
CMD ["tail","-f","/dev/null"]