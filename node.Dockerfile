# Do We TRUST the 'FROM' Images? 
# alpine:3.8 <- Offical Node 10.14.1

FROM node:10.14.1-alpine
LABEL maintainer="tw@travis.wang"

RUN yarn config set registry https://registry.npm.taobao.org --global &&\
  yarn config set disturl https://npm.taobao.org/dist --global

RUN npm config set registry https://registry.npm.taobao.org --global &&\
  npm config set disturl https://npm.taobao.org/dist --global

WORKDIR /app
