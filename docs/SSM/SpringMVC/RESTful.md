# RESTful
- REST：Representational State Transfer，表现层资源状态转移
- 资源：
	- 一种看待服务器的方式
	- 每个资源是服务器上一个可命名的抽象概念，不仅仅代表文件
	- 一个资源可以由一个或多个URI来标识
		- URI既是资源的名称，也是资源在Web上的地址
- 资源的表述：
	- 一段对于资源在某个特定时刻的状态的描述
	- 可以再客户端-服务器端之间转移
	- 表述的方式：HTML、XML、JSON、纯文本、图片、视频、音频等等
- 状态转移：在客户端和服务器端之间转移代表资源状态的表述
	- 通过转移和操作资源的表述，来间接实现操作资源的目的

## RESTful的实现
- 四个表示操作的动词：
	- `GET`：获取资源
	- `POST`：新建资源
	- `PUT`：更新资源
	- `DELETE`：删除资源
> REST风格提倡URL地址使用统一的风格设计，从前到后各个单词使用斜杆分开，不使用问号键值对方式携带请求参数，而是将要发送给服务器的数据作为URL地址的一部分，以保证整体风格的一致性

| 操作     | 传统方式         | REST风格                  |
| -------- | ---------------- | ------------------------- |
| 查询操作 | getUserById?id=1 | user/1-->get请求方式      |
| 保存操作 | saveUser         | user --> post请求方式     |
| 删除操作 | deleteUser?id=1  | user/1 --> delete请求方式 |
| 更新操作 | updateUser       | user --> put请求方式                          |

## HiddenHttpMethodFIlter
- 由于浏览器只支持发送get和post请求，想要发送其他类型的请求需要使用`HiddenHttpMethodFilter`
- 配置方式：
	1. 在web.xml中配置过滤器
	2. 设置**请求方法（并非最后的请求方式）为post**
	3. 设置当前请求必须传输请求参数`_method`，并**设置其值为真正的请求方式**

> [!注]
> 目前为止，SPringMVC中提供了两个过滤器：`CharacterEncodingFilter`和`HiddenHttpMethodFilter`
> 在web.xml中注册时，必须先注册`CharacterEncodingFilter`，在注册`HiddenHttpMethodFIlter`
> 原因：
> - 在`CharacterEncodingFilter`中通过`request.setCharacterEncoding(encoding)`方法设置字符集
> - `request.setCharacterEncoding(encoding)`方法要求前面不能有任何获取请求参数的操作
> - 而`HiddenHttpMethodFilter`恰恰有一个获取请求方式的操作：
> 	- `String paramValue = request.getParameter(this.methodParam)`