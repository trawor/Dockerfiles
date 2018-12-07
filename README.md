Docker的优势不再罗列，把平时常用的一些Docker镜像整理一下：

1. [trawor/node](https://hub.docker.com/r/trawor/node/) NodeJS
2. [trawor/caddy](https://hub.docker.com/r/trawor/caddy/) Caddy，一个用Go开发的高性能反向代理（类似nginx），配置简单，插件功能非常强大，自带免费HTTPS证书申请（Let's Encrypted）
3. [trawor/ossfs](https://hub.docker.com/r/trawor/ossfs/) OSS FS, 把阿里云OSS挂载到本地文件系统（这样就可以直接使用ls、rm、cp等）
4. [trawor/cfssl](https://hub.docker.com/r/trawor/cfssl/) cfssl, 接口化的证书签发管理工具

## 目的

1. 方便使用
2. 更好的控制版本（在自己的docker账号下）
3. 方便评估每个镜像的安全风险，安全问题越来越严重，镜像本来就有封装的作用，一不小心就被“挖矿”被“脱裤”

## 编译

直接添加 `xx.Dockerfile` 的文件即可。

1. `./build.sh`  //编译全部镜像
2. `./build.sh xxxx` //编译某一个镜像（xxxx为去掉后缀.Dockerfile的文件名）
3. 使用环境变量：`DOCKER_NS=example ./build.sh xxxx`, 则镜像名称会变成 `example/xxxx`, 默认是`trawor`. 如果你的私有镜像仓库在阿里云，这个NS可以写成`registry.cn-beijing.aliyuncs.com/你的ns`，方便push

