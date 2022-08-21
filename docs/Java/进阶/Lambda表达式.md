# Lambda表达式
- Lambda表达式是一个可以传递的代码块，可以在以后执行一次或多次
## 语法
```java
(String first, String second)
	-> first.length() - second.length()
```
- Lambda表达式就是一个代码块，需要传入代码的变量规范
- Lambda表达式形式：
	- 参数
		- 无参时要保留参数的括号：`()->{代码块\表达式}`
		- 如果可以推断出lambda表达式的参数类型，则可以忽略其类型：`(first, second)->first.length() - second.length()`
		- 如果仅有一个参数，且参数类型可推导，可以省略括号：`event -> {代码块、表达式}`
	- 箭头(`->`)
	- 表达式
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