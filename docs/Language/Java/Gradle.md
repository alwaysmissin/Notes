# Gradle
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221010213415.png)
## Gradle项目目录结构
- `build`：封装编译后的字节码，打成的包、测试报告等信息
- `gradle`：封装包装器的文件夹
	- `wrapper`
		- `gradle-wrapper.jar`
		- `graddle-wrapper.propreties`
	- `src`
		- `main`
		- `test`
	- `gradlew`
	- `gradlew.bat`：包装器启动脚本
	- `build.gradle`：构建脚本
	- `setting.graddle`：设置文件，定义项目及子项目名称信息，和项目是一一对应关系

## 常用指令
- `gradle clean`：清空build目录
- `gradle classes`：编译业务代码和配置文件
- `gradle test`：编译测试代码，生成测试报告
- `gradle build` ：构建项目
- `gradle build -x test`：推过测试构建项目
> gradle 指令要在含有`build.gradle`的目录执行

## Warpper包装器
- Gradle Wrapper实际上就是对Gradle的一层包装
	- 用于解决实际开发中可能遇到的不同项目需要不同版本的Gradle问题
- Gradle指令和gradlew指令所使用的gradle**版本可能是不一样的**
- 在终端执行gradlew指令时，指定一些参数来控制Wrapper的生成，比如依赖的版本
	- `--gradle-version`：用于指定使用的Gradle版本
	- `--gradle-distribution-url`：用于指定下载Gradle发行版的url地址
- 具体操作
```cmd
gradle wrapper --gradle-version=4.4
gradle wrapper --gradle-version-version 5.2.1 --distribution-type all:
```

## Groovy基本语法
- Groovy是基于Java与语言的，完全兼容java语法
	- 可作为面向对象语言
	- 也可以用作脚本型语言
- 在一个groovy文件中可以混合类的定义和脚本定义
- groovy中使用`def`定义变量、方法，不建议使用具体的数据类型
- groovy语句末尾的分号可以是省略的
- 默认类、方法、字段都是public修饰的
- 对象属性操作
	- 为对象属性赋值
		- `对象.属性名=xxx`
		- `对象的setter方法`
		- `具名构造器`
	- 对象属性读取操作
		- `对象.属性名`
		- `对象["属性名"]`
		- `对象.getter方法`
	- 对类属性的操作本质是通过属性对应的getter\setter方法完成的