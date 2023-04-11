# Docker Compose
## Compose
- Compose是用于定义和运行多容器Docker应用程序的工具
- 通过Compose，可以使用YML文件来配置应用程序需要的所有服务
- Compose使用的三个步骤
	1. 使用Dockerfile定义应用程序的环境
	2. 使用`docker-compose.yml`定义构成应用程序的服务
		- 这样他们可以在隔离环境中一起运行
	3. 执行`docker compose up`命令来启动整个应用程序
- 一个示例的配置案例：
```yml
version: '3'
services:
	web:
		build: .
		ports:
			- "5000:5000"
		volumes:
			- .:/code
			- logvolume01:/var/log
		links:
			- redis
	redis:
		image: redis
volumes:
	logvolume01: {}
```

## 安装
[Install Docker Desktop on Linux](https://docs.docker.com/desktop/install/linux-install/)

## 指令参考
[Docker Compose | 菜鸟教程](https://www.runoob.com/docker/docker-compose.html#yml%20%E9%85%8D%E7%BD%AE%E6%8C%87%E4%BB%A4%E5%8F%82%E8%80%83)
### version
- 指定本yml依从的compose哪个版本制定的

### build
- 指定为构建镜像上下文路径
- 如指定`./dir/Dockerfile`所构建的镜像
```yml
version: "3.7"
services:
	webapp:
		build: ./dir
```