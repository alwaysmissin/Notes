# SpringApplication
[核心特性](https://springdoc.cn/spring-boot/features.html#features.spring-application)
通过 `SpringApplication` 类，你可以从 `main()` 方法中启动Spring应用程序。 在许多情况下，你可以直接调动 `SpringApplication.run` 静态方法，如以下例子所示。
```java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MyApplication {

    public static void main(String[] args) {
        SpringApplication.run(MyApplication.class, args);
    }

}
```

## 启用失败
- 提供专门的错误信息提示和具体的解决办法

## 懒初始化
- 懒初始化：bean在需要时被创建，而不是在启动应用程序时创建
	- 可以减少应用程序的启动时间
> 在Web应用程序中，启用懒初始化后将导致许多与Web相关的Bean在收到HTTP请求之后才进行初始化
- 缺点：
	- 延迟发现应用程序的问题
		- 在启动的过程中不会出现故障，只有在Bean被初始化时候才会显现出来
	- 必须确保JVM有足够的内存来容纳应用程序的所有Bean，而不仅仅是那些在启动期间被初始化的Bean
		- 因此建议在启用懒初始化之前，对JVM的堆大小进行微调
- 启用方法：
	- `SpringApplicationBuilder.lazyInitialization()`
	- `SpringApplication.setLazyInitialization()`
	- 启用`spring.main.lazy-initialization`属性
> [!tip] 
> 可以使用注解`@Lazy(false)`来禁止某些Bean的懒初始化

## 自定义 Banner
> Banner是指应用程序启动时，在控制台显示的艺术图形
- 类路径下的`banner.txt`

## 自定义SpringApplication
- 如果`SpringApplication`的默认值不符合需求，可以自己创建一个实例，并进行自定义
```java
import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MyApplication {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(Myapplication.class);
        application.setBannerMode(Banner.Mode.OFF);
        application.run(args);
    }
}
```
- 也可以使用`application.properties`文件来配置`SpringApplication`
	- [外部配置](https://springdoc.cn/spring-boot/features.html#features.external-config)


## Builder API
```java
new SpringApplicationBuilder()
		.sources(Parent.class)
		.child(Application.class)
		.banner(Banner.Mode.OFF)
		.run(args);
```


## Application可用性
- `Liveness State`：告诉我们它的内部状态是否允许它正常工作
	- `broken`：意味着应用程序处于一个无法回复的状态，基础设施应该重新启动应用程序
- `Readiness State`：告诉平台，该应用是否准备好处理流量
	- `falling`：不应该将流量发送到该应用程序
		- 通常发生在启动期间
			- 或负载已经到了极限
```java
@Component
public class MyReadinessStateExporter{
	@EventListerner
	public void onStateChange(AvailabilitiyChangeEvent<ReadinessState> event){
		switch (event.getState()){
			case ACCEPTING_TRAFFIC:
				//
				break;
			case REFUSING_TRAFFIC:
				//
				break;
		}
	}
}
```


## Application事件和监听器
> 由于有些事件是在`ApplicationContext`创建之前触发的，所以不能使用`@Bean`的方式注册监听器
> 需要使用`Application.addListeners(...)`或`SpringApplicationBuilder.listeners(...)`来注册
> 如果想要监听器自动注册，则在项目中添加一个`META-INF/spring.plants`文件，并通过`org.springframework.context.ApplicationListener`属性来配置监听器：`org.springframework.context.ApplicationListener=com.example.project.MyListener`

> 什么是Application事件？
> 在Spring框架中，Application事件是一种用于在应用程序中发布和处理事件的机制。
> 它基于观察者模式，通过定义和发布自定义事件，从而实现了不同组件之间的解耦和通信。
> 通常，事件由事件发布者（Event Publisher）发送，而事件监听器（Event Listener）则负责接收并处理事件。
- Application event的场景：
	- 应用程序的状态变化
	- 应用程序中的业务逻辑触发的时间
	- 外部资源的变化
- Application event的发布顺序
	1.  一个 `ApplicationStartingEvent` 在运行开始时被发布，但在任何处理之前，除了注册监听器和初始化器之外。
	2.  当在上下文中使用的 `Environment` 已知，但在创建上下文之前，将发布 `ApplicationEnvironmentPreparedEvent`。
	3.  当 `ApplicationContext` 已准备好并且 `ApplicationContextInitializers` 被调用，但在任何Bean定义被加载之前，`ApplicationContextInitializedEvent` 被发布。
	4.  一个 `ApplicationPreparedEvent` 将在刷新开始前但在Bean定义加载后被发布。
	5.  在上下文被刷新之后，但在任何应用程序和命令行运行程序被调用之前，将发布一个 `ApplicationStartedEvent`。
	6.  紧接着发布 `LivenessState.CORRECT` 状态的 `AvailabilityChangeEvent`，表明应用程序被认为是存活的。
	7.  在任何[ApplicationRunner 和 CommandLineRunner](https://springdoc.cn/spring-boot/features.html#features.spring-application.command-line-runner)被调用后，将发布一个 `ApplicationReadyEvent`。
	8.  紧接着发布 `ReadinessState.ACCEPTING_TRAFFIC` 状态的 `AvailabilityChangeEvent`，表明应用程序已经准备好为请求提供服务。
	9.  如果启动时出现异常，将发布一个 `ApplicationFailedEvent`。

## 访问应用参数
- 通过注入一个`org.springframework.boot.ApplicationArguments`的bean，来访问传递给`SpringApplication.run()`的命令行参数
```java
@Component
public class MyBean{
	public MyBean(ApplicationArguments args){
		boolean debug = args.containsOptions("debug");
		List<String> files = args.getNonOptionArgs();
		if(debug){
			System.out.println(files);
		}
	}
}
```

## 使用ApplicationRunner或CommandLineRunner
- 如果需要在`SpringApplication`启动后运行一些特定的代码，可以实现`ApplicationRunner`或`CommandLineRunner`接口，并提供单一的`run()`方法
```java
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
@Component
public class MyCommandLineRunner implements CommandLineRunner {
    @Override
    public void run(String... args) {
        // Do something...
    }
}
```

## 程序退出
- 每个`SpringApplication`都在JVM中注册了一个`shutdown hook`，以确保`ApplicationContext`在退出时优雅的关闭
> [!note] 
> `shutdown hook`是java虚拟机关闭时执行的一段代码
> 允许应用程序在JVM关闭时执行一些清理或关闭操作
> shutdown hook可以在通过注册一个实现了`java.lang.Runnable`接口的对象来实现
> ```java
> Runtime.getRuntime().addShutdownHook(new Thread(() -> {
> 	System.out.println("Shutdown");
> }));
> ```
- 样例：如果希望在结束时候返回特定的退出代码：
```java
import org.springframework.boot.ExitCodeGenerator;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class MyApplication {

    @Bean
    public ExitCodeGenerator exitCodeGenerator() {
        return () -> 42;
    }

    public static void main(String[] args) {
System.exit(SpringApplication.exit(SpringApplication.run(MyApplication.class, args)));
    }
}
```
