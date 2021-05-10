FROM node:12-alpine
LABEL maintainer="tw@travis.wang"

# 改为中国科技大的镜像源，提速！
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# 改为淘宝的镜像源，提速！
RUN yarn config set registry https://registry.npm.taobao.org --global &&\
  yarn config set disturl https://npm.taobao.org/dist --global

RUN npm config set registry https://registry.npm.taobao.org --global &&\
  npm config set disturl https://npm.taobao.org/dist --global

WORKDIR /app
