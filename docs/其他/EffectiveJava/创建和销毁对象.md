# 创建和销毁对象
## 用静态工厂方法替代构造器
- 静态工厂方法：在类的内部提供一个**返回类的实例的静态方法**
```java
public static Boolean valueOf(boolean b){
	return b ? Boolean.TRUE : Boolean.FALSE;
}
```

> [!注]
> 这里指的静态工厂方法与设计模式中的工厂模式不同

- 相比构造器的优势：
	- 他们有**名称**：如果构造器的参数本身没有确切的描述正在被返回的对象，那么具有适当名称（**方法名**）的静态工厂更容易使用
	- 不必在每次调用他们的时候都创建一个新对象：避免了创建重复的对象
	> 如果程序经常请求创建相同的对象，并且创建对象的代价很高，使用这种方式可以极大地提升性能。	
	- 可以返回原类型的任何子类型的对象，使得我们选择返回对象时有了更大的灵活性
		- 这个特性可以用于实现接口的实例化对象生成
	- 所返回的对象的类可以随着每次调用而发生变化
		- 这取决于静态工厂方法的参数值
		- 例子：`EnumSet`会根据元素的数量返回不同类型的实例对象
	- 方法返回的对象所属的类，在编写包含该静态工厂方法的类时可以不存在
		- 这种方法构成了服务提供者框架(Service Provider Framework)的基础，如`JDBC API`
	    > 服务提供者框架：多个服务提供者实现一个服务，系统为服务提供者的客户端提供多个实现，并把他们从多个实现中解耦出来。
-  缺点：
	- 类如果不含共有的或者受保护的构造器，就不能被子类化
	- 程序员难以发现（Javadoc中不会直接标识）
- 一些常用的标识：
	- `from`：类型转换方法
	- `of`：聚合方法，将多个参数合并
	- `valueOf`
	- `instance`或`getInstance`
	- `create`或`newInstance`
	- `getType`

## 遇到多个构造器参数时要考虑使用构造器
- 静态工厂方法和构造器的共同局限性：都不能很好的拓展到大量的可选参数
	- 如果类中包含了大量的属性需要在构造时进行初始化，那么我们就需要大量的参数来描述这些属性
	- 如果简单的使用多个构造器来解决，当有许多参数的时候，客户端的代码会变得难以编写，并且难以阅读
- JavaBeans模式：先调用一个无参构造器来创建一个对象，然后在调用setter方法来设置每一个必要的参数：
	- 问题：
		- 导致了每一个类的不一致，类的组成可能不同
		- 把类做成不可变的可能性不复存在
- 建造者模式：
	- 概念：
		- 它不直接生成想要的对象，而是让客户端利用所有必要的参数构造器，得到一个builder对象
		- 然后客户端在builder对象上调用类似于setter的方法，来设置每个相关的可选参数
		- 最后，客户端调用无参的build方法来生成通常是**不可变的对象**
```java
package CreateDesign.SimpleFactoryPattern.BuilderPattern;  
  
public class NutritionFacts {  
  
    private final int servingSize;  
    private final int servings;  
    private final int calories;  
    private final int fat;  
    private final int sodium;  
    private final int carbohydrate;  
  
    public static class Builder{  
        private final int servingSize;  
        private final int servings;  
        private int calories = 0;  
        private int fat = 0;  
        private int sodium = 0;  
        private int carbohydrate = 0;  
  
        public Builder(int servingSize, int servings){  
            this.servingSize = servingSize;  
            this.servings = servings;  
        }  
        public Builder calories(int val){  
            this.calories = val;  
            return this;        }  
  
        public Builder fat(int val){  
            this.fat = val;  
            return this;        }  
  
        public Builder sodium(int val){  
            this.sodium = val;  
            return this;        }  
  
        public Builder carbohydrate(int val){  
            this.carbohydrate = val;  
            return this;        }  
  
        public NutritionFacts build(){  
            return new NutritionFacts(this);  
        }  
    }  
  
    private NutritionFacts(Builder builder){  
        this.servingSize = builder.servingSize;  
        this.servings = builder.servings;  
        this.calories = builder.calories;  
        this.fat = builder.fat;  
        this.sodium = builder.sodium;  
        this.carbohydrate = builder.carbohydrate;  
    }  
    public static void main(String[] args) {  
        NutritionFacts nutritionFacts = new NutritionFacts.Builder(240,8)  
            .calories(100).sodium(35).carbohydrate(27).build();  
    }  
}
```
- builder相比构造器的优势：可以有多个参数
	- 原因在于builder使用单独的方法来设置参数
	- 另外，构造器还可以将多次调用某一个方法来将传入的参数集中在一个域中，例如`addTopping`方法
- 同样的，可以使用builder方法创建多个对象
- builder对象的不足：
	- 为了创建对象，必须先创建他的构造器
	- Builder模式可能比重叠构造器模式更加冗长

## 使用私有构造器或者枚举类型强化Singleton属性
>Singleton是指仅仅被实例化一次的类
>Singleton通常被用来代表一个无状态的对象，或者那些本质上唯一的系统组件
>但使类称为Singleton会使其客户端测试变得十分困难，因为不可能给Singleton替换模拟实现，除非实现一个充当其类型的接口
- 实现Singleton的常用的两种方法（这两种方法都要**保持构造器私有**）：
	- 公有静态成员是final类
	- 共有的成员是个静态工厂类
### 公有静态成员为final类
```java
public class Elvis{
	public static final Elvis INSTANCE = new Elvis();
	private Elvis(){...}
	public void leaveTheBuilding(){...}
}
```
- 私有构造器仅在初次实例化公有的静态final域`Elvis.INSTANCE`时调用一次
- 由于缺少公有的或者受保护的构造器，保证了Elvis的全局唯一性
> 但是可以通过反射机制的`AccessibleObject.setAcessible`方法来调用私有的构造器
> 如果需要抵御这种攻击，可以修改构造器，让其在被要求创建第二个实例时抛出异常

### 公有的成员是一个静态工厂
```java
public class Elvis{
	private static final Elvis INSTANCE = new Elvis();
	private Elvis(){...}
	public static Elvis getInstance(){return INSTANCE; }
	public void leaveTheBuilding(){...}
}
```
- 对于静态工厂方法的调用，都会返回一个唯一的对象引用
- 优势：
	- 清楚表明这个类为SIngleton
	- 简单
	- 灵活
	- 如果应用程序需要，可以写一个泛型SIngleton工厂
	- 可以通过方法引用作为提供者(Supplier)，比如Elvis::instance 

## 避免创建不必要的对象
- 一般来说，最好能够重用单个对象，而不是在每次需要的时候就创建一个相同功能的新对象
- 对于同事提供了静态工厂方法和构造器的**不可变类，应该优先使用静态工厂方法**，避免创建重复的类
- 案例：`String.match()`
```java
// Before optimize
static boolean isRomanNumeral(String s){
// Every time we judge the s is matched, this will construct a new object
	return s.matches("regex_expression");
}

// Optimized
public class RomanNumerals{
	private static final Pattern ROMAN = Pattern.compile("regex_expression");
	static boolean isRomanNumeral(String s){
		// reuse the same object, there is no need to contstruct a new object
		return s.matches(ROMAN);
	}
}
```