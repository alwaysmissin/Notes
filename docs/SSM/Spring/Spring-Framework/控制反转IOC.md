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

## 依赖注入
- 配置类所对应的bean，即将对象交给Spring的IOC容器管理
	- `<bean id="" class=""></bean>`![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20221226095303.png)
> Spring底层默认通过反射技术调用组件类的无参构造器来创建组件对象
> 如果没有无参构造器，则会抛出异常
- 获取bean的方式：
	- 根据id获取
	- **根据class获取**
	- 根据id和class获取
- setter注入：配置bean时使用property标签来为对象设置属性值
	- property会调用对象的setter方法来进行赋值
```xml
<bean id="userService" class="tech.pdai.springframework.service.UserServiceImpl">
   <property name="userDao" ref="userDao"/> <!-- additional collaborators and configuration for this bean go here -->
</bean> <!-- more bean definitions for services go here --> 
```
- 构造器注入：
```xml
<bean id="studentThree" class="com.cjd.spring.pojo.Student">  
    <constructor-arg value="23"/>  
    <constructor-arg value="旧念"/>  
    <constructor-arg value="33"/>  
    <constructor-arg value="男"/>  
</bean>
```
- 特殊值的处理：
	- 使用`null`标签来设置属性值为`null`而不能直接通过使`value="null"`
	- 特殊符号需要使用xml实体来代替
	- `CDATA`表示纯文本数据：`<![CDATA[content]]>`
- 为对象中的自定义类属性赋值的方法：
	- 使用`ref`属性，引用外部已声明的`bean`：
	```xml
	<bean id="clazz" class="com.cjd.spring.pojo.Clazz">  
	    <property name="clazzId" value="15"/>  
	    <property name="clazzName" value="test"/>  
	</bean>

	<bean id="studentFour" class="com.cjd.spring.pojo.Student">  
	    <property name="sid" value="1004"/>  
	    <property name="clazz" ref="clazz"/>
	</bean>
	```
	- 使用内部`bean`：
	```xml
	<bean id="studentFour" class="com.cjd.spring.pojo.Student">  
	    <property name="sid" value="1004"/>  
	    <property name="clazz">  
	        <bean class="com.cjd.spring.pojo.Clazz">  
	            <property name="clazzId" value="15"/>  
	            <property name="clazzName" value="test"/>  
	        </bean>  
	    </property>  
	</bean>
	```
	- 使用级联属性赋值：
	```xml
	<bean id="studentSeven" class="com.cjd.spring.pojo.Student">  
	    <property name="age" value="14"/>  
	    <property name="sname" value="cjd"/>  
	    <property name="clazz" ref="clazz"/>  
	    <property name="clazz.clazzName" value="111"/>  
	    <property name="clazz.clazzId" value="222"/>  
	</bean>
	```
- 为数组类型属性赋值
```xml
<bean id="studentFive" class="com.cjd.spring.pojo.Student">  
    <property name="hobby">  
        <array>  
            <value>badminton</value>  
            <value>basketball</value>  
        </array>  
    </property>  
    <property name="teacherMap" ref="map"/>  
</bean>
```
- 为集合类型属性赋值
	- `List`集合：
	```xml
	<bean id="studentEight" class="com.cjd.spring.pojo.Clazz">  
	    <property name="clazzName" value="cjd"/>  
	    <property name="students">  
	        <list>  
	            <ref bean="studentSeven"/>  
	            <ref bean="studentFour"/>  
	        </list>  
	    </property>  
	</bean>
	```
	- Set集合：只需要将`list`标签改为`set`标签
	- Map集合：
	```xml
	<bean id="classwithstudent" class="com.cjd.spring.pojo.Student">  
	    <property name="teacherMap">  
	        <map>  
	            <entry key="111" value="teacher1"/>  
	            <entry key="333" value="teacher2"/>  
	        </map>  
	    </property>  
	</bean>
	```
	- 引用集合类型的`bean`：
	```xml
	<bean id="classwithstudent" class="com.cjd.spring.pojo.Clazz">  
	    <property name="students">  
	        <ref bean="listFactoryBean"/>  
	    </property>  
	</bean>  
	  
	<util:list id="listFactoryBean" value-type="com.cjd.spring.pojo.Student">  
	    <ref bean="studentOne"/>  
	    <ref bean="studentTwo"/>  
	    <ref bean="studentThree"/>  
	    <ref bean="studentFour"/>  
	    <ref bean="studentFive"/>  
	</util:list>
	```
### bean的作用域
- 在Spring中，可以通过scope属性来指定bean的作用域范围
| 取值      | 含义                                    | 创建对象的时机                          |
| --------- | --------------------------------------- | --------------------------------------- |
| singleton | 在IOC容器中，这个bean的对象始终为单实例 | IOC容器初始化时（使用时无须进行初始化） |
| prototype | 这个bean在IOC容器中可以有多个实例       | 获取bean时                              |
### bean的生命周期
- 具体的声明周期过程
	- bean对象创建（调用无参构造器）
	- 为bean对象设置属性
	- bean对象初始化之前的操作
		- 由bean的后置处理器负责
	- bean对象初始化
		- 在配置bean时指定初始化方法(`initMethod()`)
	- bean对象初始化之后的操作
		- 由bean的后置处理器负责
	- bean对象就绪可以使用
	- bean对象销毁
		- 需要在配置bean时指定销毁方法(`destroyMethod()`)
	- IOC容器关闭
- bean的后置处理器
	- bean的后置处理器会在生命周期初始化前后添加额外的操作
	- 需要实现`BeanPostProcessor`接口，并且配置到IOC容器中
> bean后置处理器不是针对单独一个bean生效，而是针对IOC容器中所有bean都会执行
### FactoryBean
- 与普通的bean不同，配置一个FactoryBean类型的bean，在获取bean的时候得到的并不是class属性中配置的这个类的对象，**而是`getObject()`方法的返回值**
- 通过这种机制，Spring可以帮我们吧复杂组件创建的详细过程和繁琐细节都屏蔽起来，只把最简洁的使用界面展示给我们
> 后续在Spring中整合Mybatis时，Spring就是通过FactoryBean几只来帮我们创建SqlSessionFactory对象
### 基于xml的自动装配
- 自动装配：根据指定的策略，在IOC容器中匹配一个bean，自动为指定的bean中所依赖的类类型或接口类型赋值
- 通过bean标签中的autowire属性设置自动装配的策略
	- `no,default`：表示不进行自动装配
	- `byType`：根据要赋值属性的**类型**，在IOC容器中匹配某个bean，为属性赋值
		- 若无法匹配则使用默认值（不进行装配）
		- 匹配到的结果**必须唯一**，否则报错(`NoUniqueBeanDefinitionException`)
	- `byName`：将自动装配的属性的**属性名**，作为bean的id在IOC容器中匹配对应的bean进行赋值
> 多数情况下，使用基于注解自动装配，这样可以控制部分属性使用自动装配，部分使用默认值
## 基于注解管理bean
- 扫描：Spring需要通过扫描的方式来进行检测，然后根据注解进行后续操作
- 标识组件的常用注解：
	- `@Component`：标识为**普通组件**
	- `@Controller`：标识为**控制层组件**
	- `@Service`：标识为**业务层组件**
	- `@Repository`：标识为**持久层组件**
> 四种注解本质上没有区别，仅仅是给开发人员看，方便分辨组件的作用，提高代码的可读性
### 扫描组件
- 最基本的扫描组件：
```xml
<context:component-scan base-package="com.cjd.spring"></context:component-scan>
```
- 指定要排除的组件`context:exclude-filter`：
	- `type`：设置排除或包括的依据
	- `type="annotation"`：排除指定的注解，需要设置注解的全类名
	- `type="assignable"`：排除指定类型，需要设置类型的全类名
```xml
<context:component-scan base-package="com.cjd.spring">  
    <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller"/>  
    <context:exclude-filter type="assignable" expression="com.cjd.spring.controller.UserController"/>  
</context:component-scan>
```
- 仅扫描指定组件`context:include-filter`：
	- 注意：需要设置`use-default-filters="false"`来关闭默认扫描规则
- 组件对应的`bean`的`id`：
	- 默认情况：类名首字母小写
	- 可以通过标识组件的注解`value`属性设置自定义的`bean`的`id`：`@blabla("beanid")`

### 自动装配
- `@Autowire`注解：直接标记该注解即可完成自动装配，不需要提供`setXXX()`方法
	- `@Autowire`注解可以标记在**构造器和`set`方法**上
- `@Autowire`注解的原理
	- 默认通过`byType`的方式，在IOC容器中通过类型匹配某个bean为属性赋值
	- 如果有多个类型匹配的bean，则通过`byName`方式进行
	- 如果以上两个方法都失败，**错误**
	- 此时可以在要赋值的属性上添加`@Qualifier`注解
		- 通过该注解的`value`属性值，指定某个bean的id，将这个bean为属性
- `@Autowire`的工作流程：![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20221231115434.png)
	- 首先根据所需要的组件类型到IOC容器中查找
		- 能够找到唯一的bean：直接执行装配
		- 如果完全找不到匹配这个类型的bean：装配失败
		- 和所需类型匹配的bean不止一个
			- 没有`@Qualifier`注解：根据`@Autowired`标记未知成员变量的变量名作为bean的id进行匹配
				- 能够找到：执行装配
				- 找不到：装配失败
			- 使用`@Qualifier`注解：根据`@Qualifier`注解中指定的名称作为bean的id进行匹配
				- 能够找到：执行装配
				- 找不到：装配失败
- 可以通过设置`require`属性表示是否必须