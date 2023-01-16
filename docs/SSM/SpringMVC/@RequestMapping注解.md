# @RequsetMapping注解
## 功能
- 将请求和处理请求的控制器方法关联起来，建立映射关系
- SpringMVC接收到指定的请求，就会来找到在映射关系中对应的控制器方法来处理这个请求

## 位置
- `@RequsetMapping`标识一个类：设置映射请求的请求路径的初始信息
- `@RequsetMapping`标识一个方法：设置映射请求请求路径的具体信息
```java
@Controller
@RequestMapping("/test")
public class RequestMappingCOntroller{
//此时请求映射所映射的请求的请求路径为：/test/success
	@RequestMapping("/success")
	public String success(){
		return "success";
	}
}
```

## value属性
- `@RequsetMapping`注解的`value`属性通过请求地址匹配请求映射
- `value`属性是一个**字符串类型的数组**，标识该请求映射能够匹配多个请求地址所对应的请求
- `value`属性**必须设置**
```java
@RequestMapping({"/hello", "/success"})  
public String hello(){  
    return "success";  
}
```

## method属性
- `@RequsetMapping`注解的`method`属性通过请求的请求方式(`get/post`)匹配请求映射
- 同样是一个`RequestMethod`类型的数组，标识该请求映射能够匹配**多种请求方式的请求**
![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230108113011.png)

> [!注]
> 1. 对于处理指定请求方式的控制器方法，SpringMVC中提供了`@RequestMapping`的派生注解
> 	- 处理`get`请求的映射：`@GetMapping`
> 	- 处理`post`请求的映射：`@PostMapping`
> 	- 处理`put`请求的映射：`@PutMapping`
> 	- 处理`delete`请求的映射：`@DeleteMapping`
> 2. 常见的请求方式有：`get`，`post`，`put`，`delete`
> 	- 目前浏览器只支持`get`和`post`，若在form表单提交时，为method设置了其他请求方式的字符串，则按照默认的请求方式`get`处理
> 	- 若要发送`put`和`delete`请求，则需要通过spring提供的过滤器`HidenHttpMethodFilter`，在`RESTful`部分讲到


## params属性
- `@RequestMapping`注解的params属性通过请求的请求参数匹配请求映射
- 同样是字符串类型的数组，可以通过四种表达式设置请求参数和请求映射的匹配关系：
	- `"param"`：要求请求映射所匹配的请求**必须携带**param请求参数
	- `"!param"`：要求请求映射所匹配的请求**必须不能携带**param请求参数
	- 同样的，可以通过`=`限制参数的值
![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230108112957.png)


## headers属性
- `@RequestMapping`注解的`headers`属性；通过请求的请求头信息匹配请求映射
- 用法同[[@RequestMapping注解#params属性|params属性]]

## ant风格的路径支持
- `?`：表示任意的单个字符
- `*`：表示任意的0个或多个字符
- `**`：表示任意层数的任意目录

## 路径中的占位符
- rest方式：/user/delete/1
- SpringMVC路径中的占位符常用语RESTful风格中，当请求路径中将某些数据通过路径的方式传输到服务器中，就可以在相应的`@RequestMapping`注解的value属性中通过占位符`{xxx}`表示传输的数据，在方法中获取参数
![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230109100609.png)
