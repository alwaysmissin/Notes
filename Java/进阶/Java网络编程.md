# Java网络编程
## URL类
#### 构造方法
- 使用字符串创建一个URL对象

#### 读取URL中的资源
1. 对象调用`InputStream openStream()` 方法可以返回一个输入流
	- 该输入流指向URL对象所包含的资源
	- 


## 套接字
#### 套接字概述
1. 当两个程序需要通信时，可以通过使用Socket类建立套接字对象并连接在一起

#### 客户端套接字
1. 客户端程序使用Socket类建立负责连接到服务器的套接字对象
2. 构造方法：`Socket(String host, int port) throws IOException`
3. 客户端用输入流(`getInputStream()`)可以读取服务器写到输出流(`DataOutputStream`)中的数据
4. 服务器用输入流可以读取客户端写到输出流中的数据

#### ServerSocket对象与服务器端套接字
1. 服务器端必须建立一个ServerSocket对象（类似邮局中的业务员）
2. 服务器的ServerSocket对象建立之后，可以使用`accept()`方法将客户端的套接字和服务器端的套接字连接起来
![套接字连接示意图](https://s2.loli.net/2022/03/20/kqvIXdo6hCYDT3O.png)

![](https://s2.loli.net/2022/04/06/cVrgMYIvAptKEls.png)

- 注意：`accpet()`方法会阻塞线程的执行，直到接收到客户的呼叫，并返回一个Socket对象
3. 建立连接后，服务器端的套接字对象可以调用相关的方法获取客户端的IP地址和端口
4. socket对象使用完毕后需要自行关闭
5. 注意关闭输出流


#### 使用多线程技术
1. 套接字通信中的两个基本原则：
	1. 服务器启动一个专门的线程，在该线程中和客户的套接字建立连接
	2. 客户端和服务端都需要在一个单独的线程中读取信息

## UDP数据报
- 基于UDP的信息传递更快，但不提供可靠性保证
- 基于UDP通信的基本模式：
#### 发送数据包
1. 使用`DatagramPacket`类将数据打包
2. 两个构造方法将数据打包：
	1. `DatagramPacket(byte data[], int length, InetAddress address, int port)`
	2. `DatagramPacket(byte data[], int offset, int length, InetAddress addresss ,int port)`
3. 用`DatagramSocket` 类的对象来发送数据包
	```java
	DatagramSocket mail_out = new DatagramSocket();
	mail_out.send(data_pack);
	```
	
#### 接收数据包
1. 同样使用`DatagramSocket`类的对象
2. 构造方法：`DatagramSocket(int port)`
	- 端口参数必须和待接收的数据包端口相同
3. 使用`receive(DatagramPacket pack)` 接收数据包
	- 提前准备一个数据包以便收取数据包
	```java
	byte data[] = new byte[100];
	int length = 90;
	DatagramPacket pack = new DatagramPacket(data, length);
	mail_in.receive(pack);
	```
	- `receive()` 方法可能会阻塞，直到收到数据包