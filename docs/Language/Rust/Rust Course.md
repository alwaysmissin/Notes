# Rust Course
# Rust 基础入门

## 变量绑定与解构

### 变量绑定

- 变量绑定的过程：`var a = "hello world"`
- 为何是绑定而不称为赋值？
  - Rust的核心原则——**所有权**：任何内存对象都是有主人的，绑定即将这个对象绑定给一个变量，让这个变量成为它的主人

### 变量可变性

- Rust的变量在默认情况下是不可变的，需要通过 `mut`关键字来声明可变的变量
- 不可变变量与可变变量的选择：
  - 不可变具有安全性，但是丧失了灵活性和性能
    - 性能差：如要改变，则需要重新创建一个新的变量，涉及内存对象的再分配
    - 使用较小的数据结构时，使用不可变变量以具有更具函数式风格来编写程序，可能会更容易理解
  - 可变变量具有灵活性和性能
    - 在同一位置对变量进行更新，而不是再分配一个实例

### 使用下划线开头忽略未使用的变量

```rust
fn main(){
    let _x = 5;
    let y = 10;  // warning
}
```


### 变量解构

- 解构：从相对复杂的变量中，匹配出该变量的一部分内容

```rust
fn main(){
    let (a, mut b):(bool, bool) = (true, false);
}
```

#### 解构式赋值

```rust
struct Struct {
    e: i32
}

fn main() {
    let (a, b, c, d, e);
    (a, b) = (1, 2);
    [c, .., d, _] = [1, 2, 3, 4, 5];
    Struct {e, ..} = Struct {e: 5};
  
    assert_eq!([1, 2, 1, 4, 5], [a, b, c, d, e]);
}
```

### 变量与常量之间的差异

- 常量(constant)与变量的差异：`const MAX_POINTS: u32 = 100_000;`
  - 常量默认不可变，使用 `const`关键字声明而不是 `let`，且不允许使用 `mut`关键字
  - 常量的类型必须标注
- 常量同样存在作用域的概念

> 在实际使用中，最好将程序中用到的硬编码值都声明为常量，对于代码后续的维护有莫大的帮助。如果将来需要更改硬编码的值，你也只需要在代码中更改一处即可。

### 变量遮蔽（shadowing)

- Rust允许声明相同的变量名，后声明的变量会遮蔽调前面声明的
  - 这样的方式与 `mut`变量的使用不同，第二次进行 `let`时候生成了完全不同的变量，只是恰好拥有相同的名字，**涉及一次内存对象的再分配**
  - 既然是完全不同的变量，变量类型自然也可以不同
- 变量遮蔽的作用：在另一个作用域中可以重复使用其他作用域中的变量名

```rust
fn variable_shadow(){
    let x = 5;
    let x = x + 1;
    {
        let x = x * 2;
        println!("inner x: {}", x);
    }
    println!("outer final x: {}", x);
}
/**
 * output:
 * inner x: 12
 * outer final x: 6
 */
```

## 基本类型
### 数值类型
### 字符、布尔、单元类型
#### 单元类型
- 单元类型为：`()`
- `fn main()` 即返回一个单元类型，类似于这样的函数称为**发散函数** (diverge function)，即无法收敛的函数
- 可以使用 `()` 作为 `map` 的值，表示不关注具体的值
- **单元类型完全不占用任何内存**

#### 语句与表达式
- Rust 的函数体是**由一系列语句(statement)组成，最后由一个表达式(expression)来返回**
	- 语句完成一个具体操作，但是不会返回值
		- Error: `let b = (let a = 3);`
	- 表达式一定会返回一个值
		- 表达式不能包含 `;`，否则变为语句
		- 表达式如果部返回任何值，则会返回一个 `()`
```rust
fn function(x:i32, y:i32)->i32{
	let x = x + 1; // 语句
	let y = y + 1; // 语句
	x + y; // 表达式
}
```
```rust
fn main(){
	let y = {
		let x = 3;
		x + 3
	}
}
```

### 函数
![]( https://pic2.zhimg.com/80/v2-54b3a6d435d2482243edc4be9ab98153_1440w.png )
- 同样可以使用 `return`提前返回
- 永不返回的发散函数：使用 `!` 作为函数返回类型
```rust
fn forever() -> !{
	loop{
	
	}
}
```

## 所有权与借用
### 所有权
- 通过所有权来管理内存, 编译器再编译时根据一系列规则进行检查, 对于程序运行时, 不会有任何性能上的损失
#### 所有权原则
- 所有权的规则: 
	- Rust 中每个值都被一个变量所拥有的, 该变量称为该值得所有者
	- 一个值同时只能被一个变量所拥有的, 
	- 当所有者离开作用于范围时, 这个值将被丢弃
- 字符串值 `&str` 与字符串 `String`
	- `let s = "hello"` 中的 `s` 是字符串值 `&str`
		- 由于值被硬编码到程序代码中, 字符串的字面值不可变
	- `let s = String::from("hello")` 中的 `s` 是动态字符串类型, **被分配到堆上**, 可动态伸缩

#### 变量绑定背后的数据交互
##### 转移所有权
```rust
let x = 5;
let y = x;
```
- 上述的代码中并没有发生所有权的转移, 整数是 Rust 中的基本数据类型, 这两个值是通过自动拷贝的方式来赋值的, 都存在于**栈**中
> [!note] 拷贝的速度
> 在栈上进行简单的数据拷贝速度非常快
> Rust 的基本类型都是通过自动拷贝的方式来赋值的
```Rust
let s1 = String::from("hello");
let s2 = s1;
```
-  `String` 类型不是基本类型, 所以是存储在**堆**上的, 无法进行自动拷贝
	- `String` 类型是**复杂类型**, 由存储在栈中的**堆指针, 字符串长度, 字符串容量共同组成**
		- 堆指针, 指向真实存储字符串内容的堆内存
- 现在对于以上的拷贝行为进行讨论: 
	- 拷贝 `String` (栈)和字节数组(堆)->大量需要拷贝的数据
	- 拷贝 `String` (栈)->一个值拥有了两个所有者
		- 问题: 当变量离开作用域后, Rust 调用 `drop` 函数病清理变量的堆内存, 此时两个 `String` 指向了同一个位置, 就会在离开作用域时候尝试释放相同的内存 (二次释放 double free) 错误, 会导致**内存污染**
		- Rust 的解决方法: **当 `s1` 被赋予 `s2` 后, Rust 认为 `s1` 不再有效, 将所有权从 `s1` 转移给 `s2`**, 且无法再将所有权转移给原所有者![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240604070647.png)
- Rust 不会自动创建数据的深拷贝, 自动进行的复制都不可能是深拷贝, 用户可以手动使用 `clone` 方法进行深拷贝
```rust
let s1 = String::from("hello");
let s2 = s1.clone();
```
- 可 `Copy` 的类型 (`Copy` 指在栈中存储, 在进行赋值时候直接通过拷贝实现)
	- 基本类型
	- 包含基本类型的元组
	- 不可变引用 `&T`

#### 函数传值
- 将值传递给函数和函数返回时候, 同样会发生 `移动` 或 `复制`
```rust
fn main() {
	let s = String::from("hello");  // s 进入作用域

	takes_ownership(s);             // s 的值移动到函数里 ...
									// ... 所以到这里不再有效

	let x = 5;                      // x 进入作用域

	makes_copy(x);                  // x 应该移动函数里，
									// 但 i32 是 Copy 的，所以在后面可继续使用 x

} // 这里, x 先移出了作用域，然后是 s。但因为 s 的值已被移走，
  // 所以不会有特殊操作

fn takes_ownership(some_string: String) { // some_string 进入作用域
	println!("{}", some_string);
} // 这里，some_string 移出作用域并调用 `drop` 方法。占用的内存被释放

fn makes_copy(some_integer: i32) { // some_integer 进入作用域
	println!("{}", some_integer);
} // 这里，some_integer 移出作用域。不会有特殊操作
```

### 引用与借用
- 通过借用获得变量的引用

#### 引用与解引用
```rust
fn main() {
	let x = 5;
	let y = &x;

	assert_eq!(5, x);
	assert_eq!(5, *y);
}
```

#### 不可变引用
```rust
fn main() {
	let s1 = String::from("hello");

	let len = calculate_length(&s1);

	println!("The length of '{}' is {}.", s1, len);
}

fn calculate_length(s: &String) -> usize {
	s.len()
}
```
- `&` 符号是引用, **允许使用其值, 而不是获得其所有权, 无法对其进行修改**

#### 可变引用
```rust
fn main() {
    let mut s = String::from("hello");

    change(&mut s);
}

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}
```
- 想要在使用其值的同时, 又可以修改其值需要使用可变引用 `&mut`
- 可变引用的限制: 在一个作用域内, 特定数据只能有一个可变引用
	- 下列代码中的错误: 在一个作用域中, 使用了一个变量的两个可变引用
	```rust
	let mut s = String::from("hello");
	
	let r1 = &mut s;
	let r2 = &mut s;
	
	println!("{}, {}", r1, r2);
	
	```
	- 新版的编译器的优化: **引用作用域的结束位置从花括号变为最后一次使用的位置**
- **可变引用与不可变引用不能同时存在**: 正在使用不可变引用的变量不希望自己使用的不可变引用被改变

##### 悬垂引用 (Dangling References)
```rust
// 错误的代码
fn main() {
    let reference_to_nothing = dangle();
}

fn dangle() -> &String {
    let s = String::from("hello");

    &s
}
```
- 悬垂引用: 指针指向某个值后，这个值被释放掉了，而指针仍然存在，其指向的内存可能不存在任何值或已被其它变量重新使用
- 这与 [[Rust Course#认识生命周期|生命周期]] 有关
## 复合类型
### 字符串
```rust
// 错误代码
fn main() {
  let my_name = "Pascal"; // type is &str
  greet(my_name); // expeted type is String
}

fn greet(name: String) {
  println!("Hello, {}!", name);
}
```

#### 切片
#### 什么是字符串
- Rust 中的字符是 Unicode, 每个字符占 4 个字节; 在字符串中, 是由 UTF-8 编码, **字符串中的字符所占的字节数是变化的**
#### `String` 与 `&str` 的转换
- `&str` -> `String`
	- `String::from("hello world")`
	- `"hello world!".to_string()`
- `String` -> `&str` (隐式强制转换)
	- `&string`
	- `&string[..]`
	- `string.as_str()`
#### 字符串索引
- **在 Rust 中, 不允许索引字符串**

#### 字符串切片
- 通过索引区间访问字符串时候, 需要格外小心

#### 操作字符串
- 追加 (push)
	- `push(char)`
	- `push_str(&str)`
- 插入 (insert)
	- `insert(index, char)`
	- `insert_str(index, &str)`
- 替换 (replace)
	- `replace(&str, &str)`
	- `replacen(&str, &str, int)`
	- `replace(range, &str)`

### 元组
```rust
fn main() {
    let tup: (i32, f64, u8) = (500, 6.4, 1);
}
```
- 可以使用元组从函数返回多个值

### 结构体
- 结构体可以为内部的每个字段起一个有意义的名称
#### 结构体语法
##### 定义结构体
- 结构体的组成部分
	- 关键字 `struct`
	- 结构体**名称**
	- 结构体**字段**
```rust
struct User{
	active: bool,
	username: String,
	email, String,
	sign_in_count: u84
}
```
##### 创建结构体实例
```rust
let user1 = User{
	email: String::from("jiunianwa@outlook.com"),
	username: String::from("jiunian"),
	active: true,
	sign_in_count: 1
};
```
- 注意点: 
	- 初始化时候每个字段都需要进行初始化
	- 初始化的顺序不必与定义时的顺序一致
- 简化的创建方法: 当函数参数和结构体字段同名时候, 可以直接使用缩略的方法进行初始化
```rust
fn build_user(email: String, username: String) -> User{
	User {
		email,
		username,
		active: true,
		sign_in_count: 1
	}
}
```
- 结构体更新语法: 自动获取, `..` 表明范式我们没有显式声明的字段, 全部自动获取
	- 必须在尾部使用
```rust
let user2 = User{
	email: String::from("lalal@outlook.com"),
	..user1
};
```
##### 访问结构体字段
- 必须要将结构体实例声明为可变, 才能够修改其中的字段
	- 不支持将某个结构的的某个字段标记为可变

#### 结构体的内存排列
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240606155340.png)

#### 元组结构体
```rust
    struct Color(i32, i32, i32);
    struct Point(i32, i32, i32);

    let black = Color(0, 0, 0);
    let origin = Point(0, 0, 0);

```

### 枚举
```rust
enum PokerSui {
    Clubs,
    Spades,
    Diamods,
    Hearts
}
```
- 成员实例的创建: `let heart = PokerSuit::Hearts;`
- 任何数据都可以放入枚举成员中
```rust
enum PokerCard{
	Clubs(u8),
	Spades(u8),
	Diamonds(char),
	Hearts(char),
}

enum Message{
	Quit,
	Move {x: i32, y: i32},
	Write(String),
	ChangeColor(i32, i32, i32),
}

fn main(){
	let c1 = PokerCard::Spades(5);
	let c2 = PokerCard::Diamonds('A');

	let m1 = Message::Quit;
	let m2 = Message::Move{x: 1, y: 1};
	let m3 = Message::ChangeColor(255, 255, 0);
}
```
- 枚举成员中的值可以使用模式匹配来获取: 
```rust
// 仅填空并修复错误
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

fn main() {
    let msg = Message::Move{x: 1, y: 1};

    if let Message::Move{x: a, y: b} = msg {
        assert_eq!(a, b);
    } else {
        panic!("不要让这行代码运行！");
    }
} 
```
#### 同一化类型

#### Option 枚举用于处理空值
- `Option` 的两个成员: 
	- `Some(T)`: 成员有值
	- `None`: 成员没有值
		- 使用 `None` 时候需要告诉编译器, 其包裹的是什么类型的
```rust
let some_number = Some(5);
let some_string = Some("a string");
let absent_number: Option<i32> = None;
```
- 为什么 `Option<T>` 比空值好? 
	- 在下方的代码中, Rust 不知道如何将 `Option<i8>` 与 `i8` 相加, 在对 `Option<T>` 进行 `T` 的运算之前必须将其转换为 `T`
	- 因此, 在为了拥有一个可能为空的值时候, 必须要显示将其放入对应类型的 `Option<T>`
```rust
let x: i8 = 5;
let y: Option<i8> = Some(5);
let sum = x + y;
-----------------------
error[E0277]: the trait bound `i8: std::ops::Add<std::option::Option<i8>>` is
not satisfied
 -->
  |
5 |     let sum = x + y;
  |                 ^ no implementation for `i8 + std::option::Option<i8>`
  |

```
- 为了使用 `Option<T>` 值, 需要编写处理每个成员的代码
```rust
fn plus_one(x: Option<i32>) -> Option<i32> {
	match x {
		None => None,
		Some(i) => Some(i + 1),
	}
}
```

### 数组
- `array` -> 数组, `Vector` -> 动态数组
- 数组声明: 
	- `let a = [1, 2, 3, 4];`
	- `let a: [i32; 5] = [1, 2, 3, 4, 5];`
	- `let a = [3; 5];`
		- 底层是不断使用 `Copy` 得到的
- 越界访问会导致运行时错误
- 复杂类型的数组: `let array: [String; 8] = std::array::from_fn(|_i| String::from("rust is good!"));`
	- 不能使用 `let array = [String::from("hello"); 5]`
- 可以对数组使用切片
```rust
fn main() {
  // 编译器自动推导出one的类型
  let one             = [1, 2, 3];
  // 显式类型标注
  let two: [u8; 3]    = [1, 2, 3];
  let blank1          = [0; 3];
  let blank2: [u8; 3] = [0; 3];

  // arrays是一个二维数组，其中每一个元素都是一个数组，元素类型是[u8; 3]
  let arrays: [[u8; 3]; 4]  = [one, two, blank1, blank2];

  // 借用arrays的元素用作循环中
  for a in &arrays {
    print!("{:?}: ", a);
    // 将a变成一个迭代器，用于循环
    // 你也可以直接用for n in a {}来进行循环
    for n in a.iter() {
      print!("\t{} + 10 = {}", n, n+10);
    }

    let mut sum = 0;
    // 0..a.len,是一个 Rust 的语法糖，其实就等于一个数组，元素是从0,1,2一直增加到到a.len-1
    for i in 0..a.len() {
      sum += a[i];
    }
    println!("\t({:?} = {})", a, sum);
  }
}
```
## 流程控制
[流程控制 - Rust语言圣经(Rust Course)](https://course.rs/basic/flow-control.html)
## 模式匹配
### `match` 匹配
```rust
match target {
	pattern1 => expression1,
	pattern2 => {
		statement1;
		statement2;
		expression2
	},
	_ => expression3
}
```
- example:
```rust
enum Coin{
    Penny,
    Nickel,
    Dime,
    Quarter
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => {
            println!("Lucky");
            1
        },
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}
```
- `match` 本身就是个表达式, 可以利用 `match` 来赋值
- **模式绑定**: 从模式中取出绑定的值
```rust
#[derive(Debug)]
enum UsState{
    Alabama,
    Alaska
    // --snip--
}

enum Coin{
    Penny,
    Nickel,
    Dime,
    Quarter(UsState)
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => {
            println!("Lucky");
            1
        },
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter(state) =>{
            println!("State quarter from {:?}", state);
            25
        }
    }
}
```
- 穷尽匹配: `match` 的匹配必须穷尽所有的情况, 否则会报错
- `if let` 匹配: 如果只有一个模式的值需要被处理, 可以直接使用 `if let` 来简化 ([match 和 if let - Rust语言圣经(Rust Course)](https://course.rs/basic/match-pattern/match-if-let.html#if-let-%E5%8C%B9%E9%85%8D))
```rust
if let Some(3) = v {
	println!("three");
}
```
- `matches!(expression, pattern)` 宏: 将表达式与模式进行匹配, 然后返回结果 `true` 或 `false`
- 变量遮蔽: 模式匹配时一个新的代码块, 如果使用了同名变量, 会发生变量遮蔽

### 结构 Option
[解构 Option - Rust语言圣经(Rust Course)](https://course.rs/basic/match-pattern/option.html)

### 模式使用场景
[模式适用场景 - Rust语言圣经(Rust Course)](https://course.rs/basic/match-pattern/pattern-match.html)
- 模式可以由以下内容组成: 
	- 字面值
	- 结构的数组, 枚举, 结构体或元组
	- 变量
	- 通配符
	- 占位符
- `let` 语句也是模式匹配
	- `let Some(x) = some_option_value` 报错: 没有穷尽所有的情况
- 函数参数也是模式匹配
## 方法 Method

## 泛型和特征

## 集合类型

## 认识生命周期

## 返回值和错误处理

## 包和模块

## 注释和文档

## 格式化输出
