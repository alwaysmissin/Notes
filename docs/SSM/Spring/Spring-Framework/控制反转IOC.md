# 控制反转IOC
## IOC
> IOC-Inversion of Control，即“控制反转”，是一种设计思想，在Java开发过程中，IOC意味着将你设计好的对象交给容器来控制管理，而不是传统的在对象内部直接控制
- 谁控制谁，控制什么？
	- 在IOC中，有一个容器来创建这些对象，即由IOC容器来控制对象的创建
	- IOC容器控制了对象
	- 控制了外部资源的获取（不仅仅是对象，包括文件）
- 为何是反转，哪些方面反转了
	- 传统应用程序：有我们自己在对象中主动控制区直接获取以来对象（**正转**）
	- IOC：由容器来帮忙创建及注入以来对象
		- 反转：由容器帮我们查找以及注入依赖对象，对象只是被动地接收以来对象
![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20221224144917.png)
**![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20221224144921.png)
## IOC能做什么
- 解耦合：
	- 把创建和查找依赖对象的控制权交给了容器，由容器进行注入组合对象，所以对象之间是松散耦合
	- 方便测试，利于功能复用
	- 使得程序的整个体系结构变得灵活
## IOC与DI(Dependency Injection)
- DI(Dependency Injection)
	- 组件之间的依赖关系由容器动态的将某个依赖关系注入到组件中
> 依赖注入的目的并非为软件系统带来更多功能，而是为了提升组件重用的频率，并未系统搭建一个灵活的、可拓展的平台。
> 通过依赖注入机制，我们只需要通过简单地配置，而无须任何代码就可以指定目标所需要的资源，完成自身业务逻辑，而不需要关心具体的资源来自何处，由谁实现。
- 谁依赖于谁：应用程序依赖于IOC容器
- 为什么需要依赖：应用程序需要IOC容器来提供对象需要的外部资源
- 谁注入谁：IOC容器注入应用程序的某个对象，应用程序依赖的对象
- 注入了什么：注入某个对象所需要的外部资源（对象、资源、常量数据等）
- IOC与DI的关系：同一个概念的不同角度描述

## IOC的三种配置方式
### xml配置
- 将bean的信息配置在xml文件中，通过Spring加载文件来创建bean
- 优缺点：
	- 优点：适用于任何场景，结构清晰，通俗易懂
	- 缺点：配置繁琐，不易维护，拓展性差
```xml
<?xml version="1.0" encoding="UTF-8"?> 
<beans xmlns="http://www.springframework.org/schema/beans" 
	   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	   xsi:schemaLocation="http://www.springframework.org/schema/beans 
	   http://www.springframework.org/schema/beans/spring-beans.xsd"> <!-- services --> 
	   <bean id="userService" class="tech.pdai.springframework.service.UserServiceImpl">
		   <property name="userDao" ref="userDao"/> <!-- additional collaborators and configuration for this bean go here -->
		</bean> <!-- more bean definitions for services go here --> 
</beans>
```
### Java配置
### 注解配置

## 依赖注入的方式
### setter方式
- 在`xml`配置方式中，`property`都是`setter`方式注入