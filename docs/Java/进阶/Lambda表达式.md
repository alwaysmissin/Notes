# Lambda表达式
- Lambda表达式是一个可以传递的代码块，可以在以后执行一次或多次
## 语法
```java
(String first, String second)
	-> first.length() - second.length()
```
- Lambda表达式就是一个代码块，需要传入代码的变量规范
- Lambda表达式形式：
	- **参数**
		- 无参时要保留参数的括号：`()->{代码块\表达式}`
		- 如果可以推断出lambda表达式的参数类型，则可以忽略其类型：`(first, second)->first.length() - second.length()`
		- 如果仅有一个参数，且参数类型可推导，可以省略括号：`event -> {代码块、表达式}`
	- **箭头**(`->`)
	- **表达式**
		- 或者是完整的代码块，并且包含`return`语句
		- 无需指定表达式的返回类型，自动由上下文推导而出
		- 如果lambda表达式只在某些分支返回一个值，而其他分支不返回值，该lambda表达式不合法：`(int x)->{if (x >= 0) return 1;}`
```java
public class lambdatest {  
    public static void main(String[] args) {  
        String[] planets = new String[] {"Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"};  
        System.out.println("len：" + planets.length);  
          
        System.out.println("Before Sort");  
        System.out.println(Arrays.toString(planets));  
  
        Arrays.sort(planets, (first, second) -> first.length() - second.length()); // Lambda Expression  
        System.out.println("Sorted");  
        System.out.println(Arrays.toString(planets));  
    }  
}
```

## 函数式接口
- 函数式接口：对于只有一个抽象方法的接口，需要这种接口的对象时，就可以提供一个lambda表达式
	- 例：`Arrays.sort(planets, (first, second) -> first.length() - second.length())`
- 与传统的内联类相比，更加高效
> 最好将lambda表达式看作一个函数，而非对象，并且接受lambda表达式可以传递到函数式接口（所能做的也仅是转换为函数式接口）
- java.util.function
	- 该包中定义了很多通用的函数式接口
	- `BiFunction<T,U,R>`
		- 描述了参数类型为T、U，返回类型为R的函数
		- 例：`BiFunction<String, String, Integer> comp = (first, second) -> first.length() - second.length()`
	- `Predicate<T>`
		- `ArrayList.removeIf(Predicate)`
			- 从数组中删除所有null值：`array.removeIf(e -> e == null)`
	- `Supplier<T>`
		- supplier没有参数，调用时会生成一个T类型的值
		- 一般用于实现懒计算

## 方法引用
- 直接将方法传递至构造器
- 以下两种方法等价：
```java
// 出现一个定时器事件就打印这个事件对象
var timer = new Timer(1000, event -> System.out.println(event));
// 直接把println方法传递到Timer构造器中
var timer = new Timer(1000, System.out::println);
```
- System.out::println是一个方法引用(method reference)，它只是编译器生成一个函数式接口的实例，覆盖这个接口的抽象方法来调用给定的方法
	- 在上例中，会生成一个ActionListener，其ActionPerformed方法调用sout
- 调用的三种方法
	1. `object::instanceMethod`
		- 等价于向方法传递参数的lambda表达式
		- 如`System.out::println`等价于`x->System.out.println(x)`（`System.out`为一个`static PrintStream`对象）
	2. `Class::instanceMethod`
		- 第一个参数会成为方法的隐式参数
		- 如`String::compareToIngoreCase`等价于`(x,y)->x.compareToIngoreCase(y)`
	3. `Class::staticMethod`
		- 所有的参数都传递到静态方法
		- 如`Math::pow`等价于`(x,y)->Math.pow(x,y)`
![](https://s2.loli.net/2022/08/21/mpjvcwLb8du1K4o.png)

> 包含对象的方法引用与等价的lambda表达式的一个细微区别：
> 例：
> 1. `separator::equals`：如果separator为null，在构造时立即抛出一个`NullPointerException`异常
> 2. `x->separator.equals(x)`：只在调用时抛出`NullPointerException`异常

- `this`参数：`this::equals`等价于`x->this.equals(x)`
	- 同样的，使用`super`也是合法的

## 构造器引用
- 与方法的引用类似，但方法名为`new`
	- `Person::new`为`Person`构造器的引用
	- 使用哪一个构造器取决于上下文

## 变量作用域
- lambda表达式可以捕获外围作用域中变量的值，但只能**引用值不会改变的变量**
	- 原因：如果在lambda表达式中更改变量，线程是不安全的
- 几种不合法的情况：
	- 在lambda表达式中改变变量的值![image.png](https://s2.loli.net/2022/08/21/2jtA536hiJDnqET.png)
	- 变量在lambda表达式外部发生改变![image.png](https://s2.loli.net/2022/08/21/s1XGE2SDzM4rdab.png)
	- 在lambda表达式中声明一个与局部变量同名的变量或参数![image.png](https://s2.loli.net/2022/08/21/5LCEtZhTXJofDlu.png)
- 在lambda中使用`this`关键字时，指的是创建这个**lambda表达式方法**的`this`参数（即，在lambda表达式中`this`关键字的意义不发生改变）

## 处理lambda表达式
- 特点：延迟执行(defferred execution)
- 希望以后在执行代码的原因：
	- 在一个单独的线程中运行代码
	- 多次运行代码
	- 在算法的适当位置运行代码
		- 排序中的比较操作
	- 发生某种情况时执行代码
		- 点击按钮事件
		- 数据到达
	- 只在必要时运行代码