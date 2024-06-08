# JDBC
## 编写代码步骤
- 创建工程，导入驱动jar包
- 注册驱动
```java
// mysql5及更高版本使用
Class.forName("com.mysql.cj.jdbc.Driver");
// mysql5更老的版本
Class.forName("com.mysql.jdbc.Driver");
```
- 获取连接
```java
Connection conn = DriverManager.getConnection(url, username, password);
```
- 定义SQL语句
```java
String sql = "....";
```
- 获取执行SQL对象
```java
Statement stmt = conn.createStatement();
```
- 执行SQL
```java
stmt.executeUpdate(sql);
```
- 处理返回结果
- 释放资源

## JDBC API详解
### DriverManager
- 注册驱动
	- `registerDriver`方法是用于注册驱动的，`com.mysql.jdbc.Driver`源码：![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221011211054.png)
		- 在该静态代码块中已经执行了`DriverManager`中的`registerDriver`方法进行驱动的加载了
- 获取数据库连接
	- `Connection getConnection(url, user, password);`
		- 连接路径：
			- 语法：`jdbc:mysql://ip地址:端口号/数据库名称?参数键值对1&参数键值对2...`
### Connection
- 作用：
	- 获取执行SQL的对象
	- 管理事务
- 获取执行对象
	- 普通执行SQL对象：`Statement createStatement()`
	- 预编译SQL的执行SQL对象：`PreparedStatement prepareStatement(sql)`
		- 作用：防止SQL注入
	- 执行存储过程的对象：`CallableStatement prepareCall(sql)`
- 事务管理
	- 开启事务：`setAutoCommit(boolean autoCommit)`
		- `true`：表示自动提交事务
		- `false`：表示手动提交事务，开启事务需要将该参数设为`false`
	- 提交事务：`commit()`
	- 回滚事务：`rollback()`

### Statement
- 执行DML语句
- 执行DDL语句

### ResultSet
- 作用：封装了SQL查询语句的结果，可以从ResultSet对象中获取我们想要的数据
- 方法：
	- `boolean next()`
		- 将光标从当前位置向前移动一行
		- 判断当前行是否为有效行
	- `datatype getXxxx(parameter)`
		- `int getInt|String getString`
		- 参数：
			- `int`类型：根据列的编号返回结果
			- `String`类型：列的名称

### PreparedStatement
- 作用：预防SQL注入问题
#### SQL注入
- SQL注入是通过操作输入来修改事先定义好的SQL语句，用以达到执行代码对服务器进行攻击的目的
#### 概述
- 获取PreparedStatement对象
	- `?`为占位符
```java
String sql = "select * from user where username = ? and password = ?*";
PreparedStatement pstmt = conn.prepareStatement(sql);
```
- 设置参数值
	- `setXxx(index, value)`
- 执行SQL语句：
	- `executeUpdate()`：执行DDL语句和DML语句
	- `executeQuery()`：执行DQL语句
> 执行SQL语句时不需要传递SQL语句，因为获取SQL语句执行对象时已经对SQL语句进行预编译了

#### 预编译功能开启
- 在url后添加`useServerPrepStmts=true`