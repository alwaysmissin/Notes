# UML类图
## 类图
### 具体类
- 具体类在类图中用矩形框表示
	- 第一层：名字
	- 第二层：类的成员变量![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105172220.png)
		- `+`：表示`public`
		- `-`：表示`private`
		- `#`：表示`protected`
		- 不带符号的表示`default`
	- 第三层：类的方法
		- 与类的成员变量的表示方法一致

### 抽象类
- 抽象类在类图中同样用矩形框表示
	- 不同之处在于，抽象类的类名以及抽象方法的名字都使用斜体字来表示![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105172357.png)

### 接口
- 接口在类图中同样使用矩形框表示![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105173314.png)

	- 第一层：`<<interface>>+类名`
	- 第二层：方法
> 接口的另一种表达方式是在方框上加一根“棒棒糖”

### 包
- 类和接口一般都出现在包中：![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105173445.png)

### 类之间的关系
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105173623.png)
#### 实现关系(implements)
- 接口与实现类之间的关系
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105173701.png)

#### 泛化关系(extends)
- 泛化关系指的是对象与对象之间的继承关系
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105173922.png)

#### 关联关系
- 关联关系：指对象与对象之间的连接
	- 它使一个对象知道另一个对象的属性和方法
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105174207.png)
- 三种关联关系：
	- 依赖关系
	- 聚合关系
	- 组合关系
> [!多重性表达式]
> 一个对象可以持有其他对象的数组或者集合。在UML中，通过防止多重性表达式在关联线的末端来表示。多重性表达式可以使一个数字、一段范围或者是他们的组合。
> - 数字：精确的数量
> - `*`或`0..*`：表示0~多个
> - `0..1`：0或1个
> - `1..*`：1~多个

#### 依赖关系
- 依赖关系(use a)：一种弱关联关系
	- 如果对象A用到对象B，但是与B的关系不是太明显，即依赖关系
	- 例子：驾驶员和汽车的关系
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105174716.png)
> [!依赖关系在Java中的体现]
> B为A的构造器
> B为A方法中的局部变量、方法或构造器的参数、方法的返回值
> A调用B的静态方法
> ```java
> public class A{
> 	public void method1(){
> 		//依赖的第一种表现形式：B为A的局部变量
> 		B b = new B();
> 		b.method1();
> 	}
> 	public void method2(){
> 		//依赖的第二种表现形式：调用B的静态方法
> 		B.method2();
> 	}
> 	public void method3(B b){
> 		//依赖的第三种表现形式：B作为A的方法参数
> 		String s = b.field1;
> 	}
> 	public B method4(){
> 		//依赖的第四种表现形式：B作为A的方法返回值
> 		return new B();
> 	}
> }
> ```
#### 聚合关系
- 聚合关系(has a)：体现整体与部分的拥有关系
	- 此时的整体与部分是可以分离的，他们可以拥有各自的生命周期
	- 部分可以属于多个整体对象，也可以为多个对象共享
	- 例子：公司部门与员工的关系，一个员工可以属于多个部门![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105190934.png)

#### 组合关系
- 组合关系(contain a)：同样体现整体与部分的包含关系
	- 此时的整体与部分是不可分的，部分也不能给其他整体共享
	- 作为整体的对象负责部分对象的生命周期
	- 也被称为**强聚合**
	- 例子：人与肢体的关系![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230105191159.png)
> 在Java的代码形式上，聚合和组合关系中的部分对象是整体的一个成员变量。但是，在实际应用开发时，两个对象之间的关系到底是聚合还是组合，有时候很难区别。在Java中，仅从类代码本身是区分不了聚合和组合的。如果一定要区分，那么如果在删除整体对象的时候，必须删掉的部分对象，那么就是组合关系，否则可能就是聚合关系。
> 从业务角度上来看，如果作为整体的对象必须要部分对象的参与，才能完成自己的职责，那么二者之间就是组合关系，否则就是聚合关系
