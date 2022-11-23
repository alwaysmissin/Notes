# Dockerfile
- Dockerfile是用来构建Docker镜像的文本文件
	- 由一条条构建镜像所需的指令和参数构成的脚本
![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20221113154129.png)
- 构建三步骤：
	- 编写Dockerfile文件
	- `docker build` 命令构建镜像
	- `docker run` 镜像运行容器实例
> 官网：[Dockerfile reference | Docker Documentation](https://docs.docker.com/engine/reference/builder/)

## Dockerfile构建过程解析
### 基础知识
1. 每一条指令都必须为**大写字母**且后面至少跟随一个参数
2. 指令按照顺序执行
3. `#`表示注释
4. 每条指令都会创建一个新的镜像层并对镜像层进行提交
### 执行的大致流程
1. docker从基础镜像运行一个容器
2. 执行一条指令并对容器作出修改
3. 执行类似`docker commit`的操作提交一个新的镜像层
4. docker再基于刚刚提交的镜像运行一个新的容器
5. 执行Dockerfile中的下一条指令知道所有的指令都执行完成
> [!NOTE]
> 从应用软件的角度来看，Dockerfile、Docker镜像与Docker容器分别代表软件的三个不同阶段：
> - Dockerfile：软件的原材料
> - Docker镜像：软件的交付品
> - Docker容器：软件镜像的运行态
> Dockerfile面向开发，Docker镜像成为交付标准，Docker设计部署与运维
> ![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20221113155025.png)
### 上下文路径
- 上下文路径，是指 docker 在构建镜像，有时候想要使用到本机的文件（比如复制），docker build 命令得知这个路径后，会将路径下的所有内容打包。
## Dockerfile的常用保留字指令
### FROM
- 基础镜像，指定一个已经存在的镜像作为模板
- 第一条必须是`FROM`
### MAINTAINER
- 镜像维护者的姓名和邮箱地址
### RUN
- 容器构建时需要运行的命令
- 两种格式：
	- shell
		- `RUN <命令行命令>`
		- `RUN apt install vim`
	- exec
		- `RUN ["可执行文件", "参数1", "参数2", ...]`
		- `RUN ["./FaceTrack.py", "1", "0"]`
- `RUN`是在`docker build`时运行
- 注意：Dockerfile的指令每执行一次就会在docker上新建一层，使用`&&`符号链接买； ，执行之后只会创建一层镜像![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20221113155809.png)
### EXPOSE
- 当前容器对外暴露出的端口
### WORKDIR
- 指定在创建容器后，终端默认登陆进来的工作目录
### USER
- 指定该镜像以什么样的用户去执行
- 默认为root
### ENV
- 用来在构建镜像过程中设置环境变量
- 格式：
```Dockerfile
ENV <key> <value>
ENV <key1>=<value1> <key2>=<value2>...
```
### ARG
- 构建参数，与ENV作用一致，但是作用域不同
- ARG设置的环境变量仅对Dockerfile内有效，即仅在`docker build`的过程中有效，构建完成的镜像内不存在此环境变量
### ADD
- 将宿主机目录下的文件拷贝进镜像
- 会自动处理URL和解压tar压缩包
### COPY
- 类似于ADD，拷贝文件和目录到镜像中，但更推荐`COPY`
- 将构建上下文目录中的`<源路径>`的文件/目录复制到新的一层镜像内的`<目标路径>`
- 格式：`COPY [--chown=<user>:<group>] <源路径> <目标路径>`
	- `[--chown=<user>:<group>]`：可选参数，用户改变复制到容器内文件的**拥有者和属组**
	- `<源路径>`：源文件或者源目录，这里可以是通配符表达式，其通配符规则要满足 Go 的 `filepath.Match` 规则
	- 
### VOLUME
- 定义匿名数据卷
- 在启动容器时忘记挂在数据卷，会自动挂载到匿名卷
- 作用：
	- 避免重要的数据，因容器重启而丢失
	- 避免容器不断变大
- 在启动容器`docker run`的时候，可以通过`-v`参数修改挂载点
### CMD
- 指定容器启动后要干的事情
- 格式：
```Dockerfile
CMD <shell 命令> 
CMD ["<可执行文件或命令>","<param1>","<param2>",...] 
CMD ["<param1>","<param2>",...]  # 该写法是为 ENTRYPOINT 指令指定的程序提供默认参数
```
> [!注意]
> Dockerfile中可以有多个CMD指令，但是只有最后一个生效，且CMD会被`docker run`之后的参数替换

> [!与RUN的区别]
> - CMD是在docker run时运行
> - RUN是在docker build时运行
### ENTRYPOINT
- 同样是用来指定一个容器启动时要运行的命令
- 类似`CMD`指令，但是ENTRYPOINT不会被`docker run`后的命令覆盖，而且**这些命令行参数会被当做参数送给ENTRYPOINT指令指定的程序**![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20221113161145.png)
- 优点：在执行`docker run`的时候可以指定ENTRYPOINT运行所需的参数
> [!注意]
> Dockerfile中可以有多个ENTRYPOINT指令，但是只有最后一个生效
### HEALETHCHECK
- 用于指定某个程序或指令来监控docker容器服务的运行状态
- 格式：
```Dockerfile
HEALTHCHECK [选项] CMD <命令>：设置检查容器健康状况的命令
HEALTHCHECK NONE：如果基础镜像有健康检查指令，使用这行可以屏蔽掉其健康检查指令

HEALTHCHECK [选项] CMD <命令> : 这边 CMD 后面跟随的命令使用，可以参考 CMD 的用法。
```

