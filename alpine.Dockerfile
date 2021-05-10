FROM alpine:3.13
LABEL maintainer="tw@travis.wang"

# 改为中国科技大的镜像源，提速！
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
