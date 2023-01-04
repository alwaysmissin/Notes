# 注解(Annotation)
- 注解为我们在代码中添加信息提供了一种形式化的方法，使我们可以在稍后某个时刻非常方便的使用这些数据
- 注解在一定程度上是把元数据与源代码结合
- 注解可以用于生成描述符文件或者是新的类定义，有助于减轻编写样板代码的负担
- 通过注解，可以把这些元数据存储在Java源代码中
- 注解不支持继承
- 优点：
	- 更加干净易读的代码
	- 编译期类型检查
- 内置的三种注解：
	- `@Override`
		- 表示覆盖超类中的方法
	- `@Deprecated`
		- 废弃信息，使用时它注解的元素会发出警告
	- `@SuppressWarnings`
		- 忽略警告信息
## 基本语法
### 定义注解
```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Test{
	public int id();
	public String description() default "no description";
};
```
- 注解的定义**类似于接口的定义**，仅多了一个`@`符号
- 与其他Java接口一样，**注解也会被编译为class文件**
- 元素
	- 无元素的注解被称为**标记注解**
	- `default`后为默认值
- 注解元素使用时表现为**名-值**对的形式，并且置于其声明的括号中
	- `@Test(id = 7393, description = "lalala")`
- 没有任何元素的注解称为**标记注解**
- 注解允许的元素类型：
	- 所有基本类型（`int`、`float`、`boolean`等）
	- `String`
	- `Class`
	- `enum`
	- `Annotation`
	- 以上任何类型的数组
### 元注解
- `@Target`
	- 表示该**注解可以用于什么地方**
	- `ElementType`参数
		- `CONSTURCTOR`：构造器
		- `FIELD`：域
		- `LOCAL_VARIABLE`：局部变量
		- `METHOD`：方法
		- `PACKAGE`：包
		- `PATAMETER`：参数
		- `TYPE`：类、接口或`enum`
- `@Retention`
	- 表示需要**在什么级别保存该注解信息**
	- `RetentionPolicy`
		- `SOURCE`：注解将被编译器丢弃
		- `CLASS`：注解在class文件中可用，但会被VM丢弃
		- `RUNTIME`：VM将在运行期也保留注解，可以通过**反射机制**读取注解信息
- `@Documented`
	- 将次注解包含在**javadoc**中
- `@Ingerited`
	- 允许子类继承父类中的注解
- `@Repeatable`
	- 可以多次应用于同一个声明

## 注解处理器
- 在java中，使用[反射机制](./类型信息.md)读取注解
- 方法：
	- `getAnnotation()`
		- 返回指定类型的注解对象
		- 然后通过具体方法(元素名)提取元素的值
	- `getAnnotations()`
### 默认值的限制
- 所有元素都要有确定的值
	- 一个元素要么有默认值，要么使用该注解来为其赋值
- 不论是在源代码中声明时，还是在注解中定义默认值时，任何值都不能为`null`
	- 这导致了很难让处理器去判断某个元素存在与否，但是可以使用特殊值来替代

