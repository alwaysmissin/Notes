# MyBatis基础
## 从XML中构建SqlSessionFactory
- 每一个基于MyBatis的应用都是以一个`SqlSessionFactory`的实例为核心的
	- `SqlSessionFactory`的实例可以通过`SqlSessionFactoryBuilder`来获得
	- `SqlSessionFactoryBuilder`可以通过XML配置文件或一个预先配置的`Configuration`实例来构建出`SqlSessionFactory`实例
- 构建过程
	```java
	String resource = "path_to_xml_file";
	InputStream inputstream = Resources.getResourcesAsStream(resource);
	SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
	```
- XML配置文件中包含对MyBatis系统的核心设置
	- `dataSource`：获取数据库连接实例的数据源
	- 决定事务作用域和控制方式
	- `TransactionManager`：事务管理器
- 简单实例：
	- 头部声明：用来验证XML文档的正确性
	- environment元素体：包含了事务管理和连接池的配置
	- mappers元素体：包含了一组映射器
		- 映射器的XML映射文件包含了SQL代码和映射定义信息
	```xml
	<?xml version="1.0" encoding="UTF-8" ?>
	<!DOCTYPE configuration
	  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
	  "http://mybatis.org/dtd/mybatis-3-config.dtd">
	<configuration>
	  <environments default="development">
	    <environment id="development">
	      <transactionManager type="JDBC"/>
	      <dataSource type="POOLED">
	        <property name="driver" value="${driver}"/>
	        <property name="url" value="${url}"/>
	        <property name="username" value="${username}"/>
	        <property name="password" value="${password}"/>
	      </dataSource>
	    </environment>
	  </environments>
	  <mappers>
	    <mapper resource="org/mybatis/example/BlogMapper.xml"/>
	  </mappers>
	</configuration>
	```
- 标签顺序：`properties?,settings?,typeAliases?,typeHandlers?,objectFactory?,objectWrapperFactory?,refl ectorFactory?,plugins?,environments?,databaseIdProvider?,mappers?`
- `typeAliases`：设置某个类型的别名
	- 元素：
		- `typeAlias`
			- `type`：设置需要设置别名的类型
			- `alias`：设置某个类型的别名
				- 若不设置该属性，则**默认的别名为类名**，且不区分大小写
			- eg：`<typeAlias type="com.cjd.mybatis.pojo.User"/>`
		- `package`
			- 以包为单位，将包下所有的类型设置默认的别名：
			- eg：`<package name="com.cjd.mybatis.pojo"/>`
- `environments`：配置多个连接数据库的环境
	- 属性：
		- `default`：设置默认使用的环境的id
	- 元素
		- `environment`：配置某个具体的环境
			- 属性：
				- `id`：表示连接数据库的环境的唯一标识，不能重复
			- 元素：
				- `transactionManager`：设置事务管理的方式
					- 属性：
						- `type`：JDBC|MANAGED
							- JDBC：使用JDBC原生的事务管理方式
							- MANAGED：被管理，例如Spring
				- `dataSource`：配置数据源
					- 属性：
						- `type`：POOLED|UNPOOLED|JNDI
							- POOLED：表示使用数据库连接池缓存数据库连接
							- UNPOOLED：表示不适用数据库连接池
							- JNDI：表示使用上下文中的数据源
					- 元素：
						- `property`：
							- 设置数据库的驱动
							- 设置数据库的连接地址
							- 设置数据库的连接用户名
							- 设置数据库的密码
- `mappers`：
	- 元素：
		- `mapper`：以类为单位引入映射文件
			- 属性：
				- `resource`：
		- `package`：以包为单位引入映射文件
## 从SqlSessionFactory中获取SqlSession
```java
try(SqlSession session = sqlSessionFactory.openSession()){
	Usermapper mapper = session.getMapper(Usermapper.class);
	User user = mapper.getUserById();
}
```
- 不依赖于字符串的字面值
## 探究已映射的SQL语句
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="org.mybatis.example.UserMapper">
  <select id="selectUser" resultType="User">
    select * from t_user where id = #{id}
  </select>
</mapper>
```
- 命名空间：
	- 作用：
		- 利用更长的全限定名来将不同的语句隔离开来
		- 实现了接口绑定
	- 命名解析
		- **全限定名**
		- 短名称如果全局唯一也可以作为一个单独的引用
- 使用注解映射
	```java
	public interface UserMapper{
		@Select("SELECT * FROM t_user WHERE id = #{id}*")
		User selectUser(int id);
	}
	```
	- 优点：映射简单语句会使代码更加简洁
	- 缺点：对于复杂的语句，Java注解显得力不从心，是原本复杂的SQL语句更加混乱
## 作用域(Scope)与生命周期