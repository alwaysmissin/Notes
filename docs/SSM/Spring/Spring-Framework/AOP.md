# AOP
## 代理模式
### 现有代码的缺陷
- 对于带有日志功能的实现类，我们发现有如下缺陷：
	- 对核心业务功能有干扰，导致程序员在开发核心业务功能时分散精力
	- 附加功能分散在各个业务功能方法中，不利于统一维护
- 解决思路：
	- 解耦：把附加功能从功能代码中提取出来
- 困难：要抽取的代码在方法的内部，靠以前把子类中的重复代码抽取到父类方式没发解决，需要映入心得技术
### 概念
- 代理模式：二十三中设计模式中的一种，属于结构式模式
- 作用：提供一个代理类，让我们在对用目标方法的时候，不再是直接对目标方法进行调用，而是通过代理类间接调用。让不属于目标方法核心逻辑的代码从目标方法中剥离出来一一解耦
	- 调用目标方法时，**先调用代理方法的对象**，减少对目标方法的调用和打扰，同时让附加功能能够几种在一起也有利于统一维护![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230102135445.png)
- 类比：
	- 经纪人
	- 秘书
	- 中介
- 相关术语：
	- 代理：将非核心逻辑剥离出来后，封装这些非核心逻辑的类、对象、方法
	- 目标：被代理”套用“了非核心逻辑代码的类、对象、方法

### 静态代理
```java
public class CalculatorStaticProxy implements Calculator{  
    private Calculator target;  
    public CalculatorStaticProxy(CalculatorImpl target) {  
        this.target = target;  
    }  
    @Override  
    public int add(int i, int j) {  
        System.out.println("log start");  
        int result = target.add(i, j);  
        System.out.println(result);  
        System.out.println("log end");  
        return result;  
    }
}
```
- 问题：动态代理确实实现了解耦，但是由于代码固定，不具有任何灵活性，不同的类需要不同的动态代理类，最后导致代码臃肿
### 动态代理
```java
package com.cjd.spring.proxy;  
  
import java.lang.reflect.Array;  
import java.lang.reflect.InvocationHandler;  
import java.lang.reflect.Method;  
import java.lang.reflect.Proxy;  
import java.util.Arrays;  
  
public class ProxyFactory {  
  
    private Object target;  
  
    public ProxyFactory(Object target) {  
        this.target = target;  
    }  
  
    public Object getProxy(){  

        ClassLoader classLoader = this.getClass().getClassLoader();  
        Class<?>[] interfaces = target.getClass().getInterfaces();  
        InvocationHandler h = new InvocationHandler() {  
            @Override  
            public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {  
                System.out.println("日志， 方法"+method.getName()+",参数："+ Arrays.toString(args));  
                // proxy表示代理对象，method表示要执行的方法，args表示要执行的方法的参数列表  
                Object result = method.invoke(target, args);  
                System.out.println("日志， 方法"+method.getName()+",结果："+ result);  
                return result;  
            }  
        };  
        return Proxy.newProxyInstance(classLoader, interfaces, h);  
    }  
}
```
- `Proxy.newProxyInstance`参数说明：
	- `ClassLoader loader`：指定加载动态生成的代理类的类加载器
		- `ClassLoader clasLoader = this.getClass().getClassLoader()`
	- `Class<?>[] interfaces`：获取目标对象实现的所有接口的Class对象的数组  
		- `Class<?>[] interfaces = target.getClass().getInterfaces()`
	- `java.lang.reflect.InvocationHandler h`：设置代理类中的抽象方法如何重写
		- `InvocationHandler h = new InvocationHandler(){//重写invoke方法}`

## AOP概念与相关术语
### 概述
AOP(Aspect Oriented Programming)是一种设计思想，是软件设计领域中的面向切面编程，它是面向对象编程的一种补充和完善，它以**预编译方式**和**运行期动态代理方式**实现在不修改源代码的情况下给程序**动态统一添加额外功能**的一种技术
### 相关术语
- 横切关注点：从每一个方法中抽取出来的同一类**非核心业务**![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230103103619.png)
- 通知：每一个横切关注点上要做的事情都需要写一个方法来实现，这样的方法叫做通知方法：
	- 前置通知：在被代理的目标方法前执行
	- 返回通知：被代理的目标方法成功结束后执行
	- 异常通知：在被代理的目标方法异常结束后执行
	- 后置通知：在被代理的目标方法最终结束后执行
	- 环绕通知：使用`try...catch...finally`结构围绕整个被代理的目标方法，包括上面四种通知对应的位置![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230103103609.png)
- 切面：封装通知方法的类![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230103103639.png)
- 目标：被代理的目标对象
- 代理：想目标对象应用通知之后创建的代理对象
	- 无须手动创建，AOP帮助创建
- 连接点：把方法排成一排，每一个横切位置看成x轴方向的，把方法从上到下执行的顺序看做y轴，x轴与y轴交叉的点就是连接点（**抽取横切关注点的位置**）![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230103103818.png)
- 切入点：定位连接点的方式
	- 每个类的方法中都包含多个连接点，所以连接点是类中客观存在的事物
	- 如果把连接点看做数据库中记录的数据，那么切入点就是查询记录的SQL语句
	- Spring的AOP技术可以通过切入点定位到特定的连接点
	- 切点通过`org.springframework.aop.Pointcut`接口进行描述，它使用类和方法为连接点的查询条件

### 作用
- 简化代码：把方法中固定位置的重复代码抽取出来，让被抽取的方法更专注于自己的核心功能，提高内聚性
- 代码增强：把特定的功能封装到切面类中，看哪里有需要，就往上套，被套用了切面逻辑的方法就被切面给增强了

## 基于注解的AOP
### 技术说明
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230103105232.png)
- 具体实现层：
	- 动态代理：使用的是JDK原生的实现方法，需要被代理的目标类必须实现接口
		- 因为这个技术要求**代理对象和目标对象实现同样的接口**
	- cglib：通过继承被代理的目标类来实现代理，不需要目标类实现接口
- AspectJ注解层：本质上是**静态代理**，**将代理逻辑“织入“被代理的目标类编译得到的字节码文件**，所以最终效果是动态的
	- `weaver`是织入器

### 切面类的创建于配置
- **AOP的注意事项**：  
	- 切面类和目标类都需要**交给IOC容器管理**  
	- 切面类必须通过`@Aspect`注解**标识为一个切面**  
	- 在Spring的配置文件中设置`<aop:aspectj-autoproxy/>`以开启基于注解的aop
	- 在切面中，需要通过指定的注解将方法标识为通知方法
		- `@Before`：前置通知，在目标对象方法执行之前执行
		- `@After`：后置通知，在目标对象方法的`finally`字句中执行
		- `@AfterReturning`：返回通知，在目标对象方法返回之后执行
			- 在返回通知中若要获取目标对象的返回值，需要在该注解的`returning`属性，就可以将通知方法的某个参数指定为接收目标对象方法的返回值的参数
		- `@AfterThrowing`：异常通知，在目标对象的`catch`字句中执行
		- `@Around`：环绕同志
			- 环绕通知方法的返回值必须和方法的返回值一致
- **切入点表达式**：设置在标识通知的注解的value属性中![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105101820.png)
	- `@Before("execution(public int com.cjd.spring.aop.annotation.CalculatorImpl.add(int, int))")`
	- `@Before("execution(* com.cjd.spring.aop.annotation.*.*(..))")`
		- 第一个`*`表示任意的访问修饰符和返回值类型
		- 第二个`*`表示类中的任意方法
		- `..`表示任意的参数列表
- **获取通知的相关信息**：
	- 获取连接点信息：在通知方法的参数为止，设置`JoinPoint`类型的参数，就可以获取父节点所对应的方法的信息
	- 获取目标方法的返回值：`@AfterReturning`中的属性`returning`，用来将通知方法的某个形参，接收目标方法的返回值
	- 获取目标方法的异常：`@AfterThrowing`中的属性`throwing`，用来将通知方法的某个形参，接收目标方法的异常
- **切入点表达式的重用**：使用`@Pointcut`声明一个公共的切入点表达式，通过该注解标记的方法名来调用这个切入点表达式
- 切面的优先级：内外嵌套
	- 可以使用`@Order`注解控制注解的优先级
```java
@Pointcut("execution(* com.cjd.spring.aop.annotation.CalculatorImpl.*(..))")  
public void pointCut(){}
```
```java
@Component
@Aspect //将当前组件标识为切面
public class LoggerAspect {

    @Pointcut("execution(* com.atguigu.spring.aop.annotation.CalculatorImpl.*(..))")
    public void pointCut(){}

    //@Before("execution(public int com.atguigu.spring.aop.annotation.CalculatorImpl.add(int, int))")
    //@Before("execution(* com.atguigu.spring.aop.annotation.CalculatorImpl.*(..))")
    @Before("pointCut()")
    public void beforeAdviceMethod(JoinPoint joinPoint) {
        //获取连接点所对应方法的签名信息
        Signature signature = joinPoint.getSignature();
        //获取连接点所对应方法的参数
        Object[] args = joinPoint.getArgs();
        System.out.println("LoggerAspect，方法："+signature.getName()+"，参数："+ Arrays.toString(args));
    }

    @After("pointCut()")
    public void afterAdviceMethod(JoinPoint joinPoint){
        //获取连接点所对应方法的签名信息
        Signature signature = joinPoint.getSignature();
        System.out.println("LoggerAspect，方法："+signature.getName()+"，执行完毕");
    }

    /**
     * 在返回通知中若要获取目标对象方法的返回值
     * 只需要通过@AfterReturning注解的returning属性
     * 就可以将通知方法的某个参数指定为接收目标对象方法的返回值的参数
     */
    @AfterReturning(value = "pointCut()", returning = "result")
    public void afterReturningAdviceMethod(JoinPoint joinPoint, Object result){
        //获取连接点所对应方法的签名信息
        Signature signature = joinPoint.getSignature();
        System.out.println("LoggerAspect，方法："+signature.getName()+"，结果："+result);
    }

    /**
     * 在异常通知中若要获取目标对象方法的异常
     * 只需要通过AfterThrowing注解的throwing属性
     * 就可以将通知方法的某个参数指定为接收目标对象方法出现的异常的参数
     */
    @AfterThrowing(value = "pointCut()", throwing = "ex")
    public void afterThrowingAdviceMethod(JoinPoint joinPoint, Throwable ex){
        //获取连接点所对应方法的签名信息
        Signature signature = joinPoint.getSignature();
        System.out.println("LoggerAspect，方法："+signature.getName()+"，异常："+ex);
    }

    @Around("pointCut()")
    //环绕通知的方法的返回值一定要和目标对象方法的返回值一致
    public Object aroundAdviceMethod(ProceedingJoinPoint joinPoint){
        Object result = null;
        try {
            System.out.println("环绕通知-->前置通知");
            //表示目标对象方法的执行
            result = joinPoint.proceed();
            System.out.println("环绕通知-->返回通知");
        } catch (Throwable throwable) {
            throwable.printStackTrace();
            System.out.println("环绕通知-->异常通知");
        } finally {
            System.out.println("环绕通知-->后置通知");
        }
        return result;
    }
}
```
- 各种通知的执行顺序：
	- 前置通知
	- 目标操作
	- 返回通知或异常通知
	- 后置通知

## 基于XML的AOP
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/aop https://www.springframework.org/schema/aop/spring-aop.xsd">

    <!--扫描组件-->
    <context:component-scan base-package="com.atguigu.spring.aop.xml"></context:component-scan>

    <aop:config>
        <!--设置一个公共的切入点表达式-->
        <aop:pointcut id="pointCut" expression="execution(* com.atguigu.spring.aop.xml.CalculatorImpl.*(..))"/>
        <!--将IOC容器中的某个bean设置为切面-->
        <aop:aspect ref="loggerAspect">
            <aop:before method="beforeAdviceMethod" pointcut-ref="pointCut"></aop:before>
            <aop:after method="afterAdviceMethod" pointcut-ref="pointCut"></aop:after>
            <aop:after-returning method="afterReturningAdviceMethod" returning="result" pointcut-ref="pointCut"></aop:after-returning>
            <aop:after-throwing method="afterThrowingAdviceMethod" throwing="ex" pointcut-ref="pointCut"></aop:after-throwing>
            <aop:around method="aroundAdviceMethod" pointcut-ref="pointCut"></aop:around>
        </aop:aspect>
        <aop:aspect ref="validateAspect" order="1">
            <aop:before method="beforeMethod" pointcut-ref="pointCut"></aop:before>
        </aop:aspect>
    </aop:config>

</beans>
```
