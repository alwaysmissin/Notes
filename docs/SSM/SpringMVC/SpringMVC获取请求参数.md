# SpringMVC获取请求参数
## 通过ServletAPI获取
将HttpServletRequest作为控制器方法的形参
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230109101701.png)


## 通过控制器方法的形参获取请求参数
- 只需要在控制器方法的形参位置，**设置与请求参数名字相同的形参**即可
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230109101928.png)
> [!注]
> 若请求所传输的请求参数中有多个同名的请求参数，此时可以在控制器方法的形参中设置字符串数组或者字符串类型的形参接收此请求参数
> - 若使用字符串数组类型的形参：此参数的数组中包含了每一个数据
> - 若使用字符串类型的形参：此参数的值为每个数据中间使用逗号拼接的结果

## @RequestParam
- `@RequestParam`是将请求参数和控制器方法的形参创建映射关系
	- `value`：指定为形参赋值的请求参数的参数名
	- `required`：是否必须传输此参数，默认为`true`
	- `defaultValue`：设置形参的默认值

## @RequestHeader
- `@RequestHeader`将请求头的信息和控制器方法的形参创建映射关系
	- 三个参数的使用方法与`@RequestParam`一致

## @CookieValue
- `@CookieValue`将cookie数据和控制器方法的形参创建映射关系
	- 三个参数的使用方法与`@RequestParam`一致

## 通过POJO获取请求参数
- 可以在控制器方法的形参位置设置一个实体类类型的形参
	- 此时浏览器传输的请求参数的参数名和实体类中的属性名一致，那么请求参数就会为此属性赋值


## 解决获取请求参数的乱码问题
- 配置SpringMVC的编码过滤器
```xml
<filter>  
    <filter-name>CharacterEndoingFilter</filter-name>  
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>  
    <init-param>  
        <param-name>encoding</param-name>  
        <param-value>UTF-8</param-value>  
    </init-param>  
    <init-param>  
        <param-name>forceEncoding</param-name>  
        <param-value>true</param-value>  
    </init-param>  
</filter>  
<filter-mapping>  
    <filter-name>CharacterEndoingFilter</filter-name>  
    <url-pattern>/*</url-pattern>  
</filter-mapping>
```
> 在tomcat设置中，如下![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230109112255.png)
> ![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230109112321.png)

