# Servlet
## Servlet的继承关系
- 继承关系
	- `javax.servlet.Servlet`接口
		- `javax.servlet.GenericServlet`抽象类
			- `javax.servlet.http.HttpServlet`抽象子类
- 相关方法
	- `javax.servlet.Servlet`接口
		- `void init(config)` - 初始化方法
		- `void service(request,response)` - 服务方法
		- `void destory()` - 销毁方法
	- `javax.servlet.GenericServlet`抽象类
		- `void service(request, response)` 仍然为抽象
	- `javax.servlet.http.HttpServlet`抽象子类
		- `void service(request,response)` - 不是抽象的
			- 获得请求方式
			- 判断请求方式
			- 执行请求方式
	- 核心方法：`init()`、`service()`、`destroy()`
> 在新建Servlet时，我们需要考虑请求方法，从而决定重写哪个do方法

## Servlet的生命周期
- 生命周期：从出生到死亡的过程成为生命周期
	- 对应三个方法：`init()`、`service()`、`destroy()`
- 默认生命周期
	- 第一次接受请求时
		1. 对Servlet进行实例化（调用构造方法）
		2. 进行初始化（调用`init()`）
		3. 然后进行服务
	- 从第二次请求开始，每一次都是服务
	- 当容器关闭时，其中所有的servlet实例都会被销毁，调用`destroy()`
- 修改初始化时机：
	- 通过`<load-on-startup>`（在Tomcat容器启动时初始化）来设置servlet启动的先后顺序
		- 数字越小，启动越靠前
- 如果我们想要在Servlet初始化时做一些准备工作，可以自行重写`init()`方法
	- 获取初始化设置的数据：
		- 获取`config`对象：`ServletConfig config = getServletConfig()`
		- 获取初始化参数值：`config.getInitParameter(key)`
- Servlet的配置：
	- xml文件：
	```xml
    <servlet>
        <servlet-name>Demo01Servlet</servlet-name>
        <servlet-class>com.atguigu.servlet.Demo01Servlet</servlet-class>
        <init-param>
            <param-name>hello</param-name>
            <param-value>world</param-value>
        </init-param>
        <init-param>
            <param-name>uname</param-name>
            <param-value>jim</param-value>
        </init-param>
    </servlet>
    <servlet-mapping>
        <servlet-name>Demo01Servlet</servlet-name>
        <url-pattern>/demo01</url-pattern>
    </servlet-mapping>	
	```
	- 注解：
	```java
	@WebServlet(urlPattern={"/demo01"},
		initParams={
			@WebInitParam(name="hello", value="world"),
			@WebInitParam(name="cjd", value="lalala")
		}
	)
	```
- Servlet在容器中是：**单例的、线程不安全的**
	- 单例：所有的请求都是同一个实例去响应
	- 线程不安全：一个线程需要根据这个实例中的某个成员变量值去做逻辑判断，但是在中间某个时机，另一个线程改变了这个成员变量的值，从而导致第一个线程的执行路径发生了变化
	- 启发：尽量不要再servlet中定义成员变量
		- 如果不得不定义成员变量
			1. 不要修改成员变量的值
			2. 不要根据成员变量的值做一些判断
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221013200347.png)
- `ServletContext`
	- 获取`ServletContext`的方法：
		- 在初始化方法中：`ServletContext servletcontext = getServletContext()`
		- 在服务方法中也可以通过`request`对象获取，也可以通过`session`获取
			- `request.getServletContext()`
			- `session.getServletContext()`
	- 获取初始化值：
		- `servletContext.getInitParameter()`

## Http协议
- 超文本传输协议
- Http是无状态的
### 请求
- 三个部分：
	- 请求行
	- 请求消息头
	- 请求主体
#### 请求行
- 三个信息：
	- 请求的方式
	- 请求的URL
	- 请求的协议（一般都是**HTTP1.1**）
#### 请求消息头
- 包含了很多需要告诉服务器的信息

#### 请求体
- 三种情况
	- get方式
		- 没有请求体，但是有一个queryString
	- post方式
		- 有请求体，form data
	- json格式
		- 有请求体，request payload
### 响应
- 三个部分
	- 响应行
	- 响应头
	- 响应体
#### 响应行
- 三个信息：
	- 协议
	- 相应状态码（200）
	- 响应状态
#### 响应头
- 包含了服务器的信息，服务器发给浏览器的信息（内容的媒体类型、编码、内容长度等等）

#### 响应体
- 响应的实际内容

## 会话（Session)
> Http为无状态的
> 服务器无法判断这两次请求是同一个客户端发过来的，还是不同客户端发过来的
> 无状态带来的现实问题：第一次请求是添加商品到购物车，第二次请求是结账；如果这两次请求服务器无法区分是同一个用户的，那么就会导致混乱
> **通过会话跟踪技术解决无状态的问题**

### 会话跟踪技术
- 客户端第一次发送请求给服务器，服务器获取session，如果无session，则创建一个新的session，并响应给客户端
- 后续客户端向服务器发送请求时，则会把sessionID带给服务器，服务器则根据sessionID判断这一次请求和某次请求的是同一个客户端
- 常用的API
	- `request.getSession()` -> 获取当前的会话，没有则创建一个新的会话
	- `request.getSession(true)` -> 效果和不带参数相同
	- `request.getSession(false)` -> 获取当前会话，没有则返回`null`，不会创建新的
	- `session.getId()` -> 获取sessionID
	- `session.isNew()` -> 判断当前session是否是新的
	- `session.getMaxInactiveInterval()` -> session的非激活（无操作）间隔时长，默认1800秒
	- `session.setMaxInactiveInterval()` -> 设置session的非激活（无操作）间隔时长
	- `session.invalidate()` -> 强制性让会话立即失效

### Session的保存作用域
- session的保存作用域是和具体的某一个session对应的
- 常用的API：
	- `void session.setAttribute(k,v)`
	- `Object session.getAttribute(k)`
	- `void removeAttribute(k)`
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221013200424.png)


## 服务器内部转发客户端重定向
- 服务器内部转发：`request.getRequestDispatcher("...").forward(request, response)`
	- 一次请求过程
	- 对于客户端而言，内部经过了多少次转发，客户端不知道
- 客户端重定向：`response.sendRedirect("...")`
	- 两次请求过程
	- 客户端的url发生了变化
> 状态码302表示重定向



## Thymeleaf——视图模板技术
1. 添加thymeleaf包
2. 新建一个Servlet类`ViewBaseServlet`
3. 添加`web.iml`配置
	1. 配置前缀：`view-prefix`
	2. 配置后缀：`view-suffix`
4. 使得我们的Servlet继承`ViewBaseServlet`
5. 根据逻辑视图名称得到物理视图名称
	- 物理视图名称=`view-prefix` + 逻辑视图名称 + `view-suffix`
6. 使用thymeleaf标签
	- `th:if`
	- `th:unless`
	- `th:each`
	- `th:text`

> 作用域的保存范围
> - request：一次请求响应范围
> - session：一次会话有效范围
> - application：一次应用程序范围有效