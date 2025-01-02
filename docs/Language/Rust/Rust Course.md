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
- `enum` 类型实际上相当于 c 中的 `union`, 但是是 exclusive 的 ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240613154958.png)

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
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240613155748.png)

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

### 全模式列表
[全模式列表 - Rust语言圣经(Rust Course)](https://course.rs/basic/match-pattern/all-patterns.html)
- 模式语法: 
	- 字面值
	- 单分支多模式
	- 通过序列 `..=` 匹配值的范围
	- 可以使用
- 使用 `_` 进行通配的话, 不会发生所有权转移
#### 匹配守卫提供额外的条件
- 匹配守卫 (match guard): 位于 `match` 分支模式之后的额外 `if` 条件, 能够为分支模式提供进一步的匹配条件
	- 在匹配守卫中可以使用外部的变量
	- 匹配守卫作用于完整的模式
```rust
let num = Some(4);

match num {
	Some(x) if x < 5 => println!("less than five: {}", x);
	Some(x) => println!("{}", x),
	None => (),
}

-------- Output ---------

less than five: 4
```

#### `@` 绑定
- 如果既想要限定分支范围, 又想要使用分支的变量时, 可以使用 `@` 进行变量绑定
```rust
enum Message {
    Hello { id: i32 },
}

let msg = Message::Hello { id: 5 };

match msg {
// 可以获得匹配的变量
    Message::Hello { id: id_variable @ 3..=7 } => {
        println!("Found an id in range: {}", id_variable)
    },
    // 无法获得匹配此范围的变量
    Message::Hello { id: 10..=12 } => {
        println!("Found an id in another range")
    },
    // 可以获得变量
    Message::Hello { id } => {
        println!("Found some other id: {}", id)
    },
}

```
- 在使用 `@` 时候, 可以进行解构:
```rust
#[derive(Debug)]
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    // 绑定新变量 `p`，同时对 `Point` 进行解构
    let p @ Point {x: px, y: py } = Point {x: 10, y: 23};
    println!("x: {}, y: {}", px, py);
    println!("{:?}", p);


    let point = Point {x: 10, y: 5};
    // 进行解构
    if let p @ Point {x: 10, y} = point {
        println!("x is 10 and y is {} in {:?}", y, p);
    } else {
        println!("x was not 10 :(");
    }
}
```
## 方法 Method
### 定义方法
- rust 将对象定义和方法定义分离, 提供更高的灵活度
```rust
struct Circle{
    x: f64,
    y: f64,
    radius: f64
}

impl Circle {

    fn new(x: f64, y:f64, radius: f64) -> Circle {
        Circle {
            x, y, radius
        }
    }

    fn area(&self) -> f64 {
        std::f64::consts::PI * (self.radius * self.radius)
    }
}
```
- 解释: 
	- `new` 是 `Circle` 的关联函数, 一般用于初始化当前结构体的实例
	- `area` 是 `Circle` 的方法, `&self` 表示**借用**当前的 `Circle` 结构体
- 可以使用多个 `impl` 块来实现不同功能
- 在 rust 中, 同样可以为枚举类型实现方法

#### `self`, `&self` 和 `&mut self`
- 在 `impl` 块内, `Self` 用来指代被实现方法的结构体类型, `self` 用来指代此类型的实例
- `&self` 是 `self: &Self` 的缩写
- `self` 依旧具有所有权的概念: 
	- `self` 表示所有权的转移
	- `&self` 表示其不可变借用
	- `&mut self` 表示可变借用

##### 方法名与结构体字段名相同
- rust 中允许方法名与结构体的字段名相同
> [!note] `->` 运算符到哪里去了?
> Rust 中并没有与 `->` 等效的运算符, 因为 Rust 中有**自动引用和解引用**功能, 而方法调用时 Rust 中少数几个拥有该行为的地方.
> 当使用 `object.something()` 来调用方法的时候, Rust 会自动为 `object` 添加 `&`, `&mut` 或 `*` 以使 `object` 与方法签名匹配, 所以如下的代码是等价的: 
> - `p1.distance(&p2)`
> - `(&p1).distance(&p2)`

#### 关联函数
- 关联函数不能通过 `.` 的方式调用, 应该使用 `::`, 先前用到的 `String::from` 就是关联函数

## 泛型和特征
### 泛型 Generics
- 举例
```rust
fn add<T: std::ops::Add<Output = T>>(a: T, b: T) -> T {
	a + b
}
```
- 错误使用: 不是所有的类型都能够进行比较, 需要对类型进行限制
```rust
fn largest<T>(list: &[T]) -> T {
    let mut largest = list[0];

    for &item in list.iter() {
        if item > largest {
            largest = item;
        }
    }

    largest
}
```
- 在结构体中也可以使用泛型
	- 需要提前声明
	- 一个泛型参数只能是一种类型
```rust
struct Point<T> {
	x: T,
	y: T,
}

struct Point<T, U> {
	x: T,
	y: U,
}
```
- 枚举中使用泛型
- 方法中使用泛型: `impl<T>`
	- 结构体的方法中, 可以定义额外的泛型参数
	- 还可以为特定的具体类型, 进行方法定义, 而对于其他类型, 不能使用该方法
```rust
impl<T> Point<T> {
	fn x(&self) -> T{
		&self.x
	}
}
// 结构体的方法中, 可以定义额外的泛型参数
impl<T, U> Point<T, U> {
	fn mixup<V, W>(self, other: Point<V, W>) -> Point<T, W> {
		Point {
			x: self.x,
			y: other.y,
		}
	}
}
// - 还可以为特定的具体类型, 进行方法定义
impl Point<f32> {
	fn distance_from_origin(&self) -> f32 {
		(self.x.powi(2) + self.y.powi(2)).sqrt()
	}
}
```
#### `const` 泛型
- 泛型的实现一般针对类型, `const` 泛型的实现是**针对值(value)的**,
	- 一般用于用于替代数组的长度
```rust
fn display_array<T: std::fmt::Debug, const N: usize>(arr: [T; N]){
	println!("{:?}", arr);
}

fn main() {
	let arr: [i32; 3] = [1, 2, 3];
	display_array(arr);
	let arr2: [i32; 2] = [1, 2];
	display_array(arr2);
}
```

#### 泛型的性能
- 使用泛型时候, 不需要担心性能上的问题
	- 代价: rust 在编译期为泛型对应的多个类型, 生成各自的代码, 损失了**编译的速度**和**最终生成文件的大小**

### 特征 Trait
- 特征定义了一组可以被共享的行为
> [!note] 已经见过的特征
> `#[derive(Debug)]` 会在定义的类型上自动派生 `Debug` 特征
> 通过 `std::ops::Add` 限制泛型的使用
#### 定义特征
- 把一些方法组合在一起, 目的是**定义**一个实现某些目标所必须的行为的集合
```rust
pub trait Summary{
	fn summarize(&self) -> String;
}
```

#### 实现特征
```rust
pub struct Post{
	pub title: String,
	pub author: String,
	pub content: String,
}

impl Summary for Post{
	fn summarize(&self) -> String{
		format!("文章{}, 作者是{}", self.title, self.author)
	}
}
```
- `impl [Trait] for [Struct]`: 为 `[Struct]` 实现特征 `[Trait]`
- 特征定义与实现的位置 (孤儿规则): 如果想要为类型 `A` 实现特征 `T`, 那么 `A` 或 `T` 至少有一个是在当前作用域中定义的 ^214e91
	- `Post` 在当前的作用域内 -> 可以为上面的 ` Post ` 类型实现标准库中的 ` Display ` 特征
	- `Summary` 定义在当前的作用域内 -> 可以为 `String` 类型实现 `Summary` 特征
	- 无法为 `String` 类型实现 `Display` 特征
- 可以在特征中定义具有**默认实现**的方法, 此时其他类型可以无须再实现该方法
	- 在默认实现中, 可以调用其他没有默认实现的方法, 但是在调用之前, 必须实现对应的方法
```rust
pub trait Summary{
	fn summarize(&self) -> String{
		String::from("hello")
	}
}

impl Summary for Post{}
```

#### 使用特征作为函数参数
```rust
pub fn notify(item: &impl Summary){
	println!("Breaking news!{}", item.summarize());
}
```
- `impl Summary` 指的是实现了 `Summary` 特征的 `item` 参数, 可以使用任何实现了 `Summary` 特征的类型作为该函数的参数

#### 特征约束
- 上面将特征作为函数参数的实际完整形式是特征约束: 
```rust
pub fn notify<T: Summary>(item: &T){
	println!("Breaking news!{}", item.summarize());
}
```
- 多重约束: 
	- `pub fn notify(item: &(impl Summary + Dispaly)){}`
	- `pub fn notity<T: Summary + Display>(item: &T){}`
- `Where` 约束: 
```rust
fn some_function<T, U>(t: &T, u: &U) -> i32
	where T: Display + Clone,
		  U: Clone + Debug
{}
```
- 使用特征约束有条件的实现方法或特征: 在指定类型+特征的条件下实现方法
```rust
use std::fmt::Display;

struct Pair<T>{
	x: T,
	y: Y,
}

impl<T> Pair<T>{
	fn new(x: T, y: T) -> Self{
		Self{
			x, y,
		}
	}
}

// 仅有实现了Display和ParitalOrd特征的Pair<T>才能拥有此方法
impl<T: Display + PartialOrd> Pair<T>{
	fn cmp_display(&self) {
		...
	}
}
```
#### 函数返回中的 `impl Trait`
- 可以通过 `impl Trait` 来说明一个函数返回了一个类型, 该类型实现了某个特征
```rust
fn returns_summarizable() -> impl Summary {
    Weibo {
        username: String::from("sunface"),
        content: String::from(
            "m1 max太厉害了，电脑再也不会卡",
        )
    }
}

```
- 该函数依然只能返回**一个**实现了某个特征的类型, 而不能根据条件的不同返回不同的类型, 如有此需求, 需要使用 [[Rust Course#特征对象]] 解决
#### 修复上一节中的 `largets` 函数
```rust
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T{
	let mut largest = list[0];

	for &item in list.iter() {
		if item > largest {
			largets = item;
		}
	}
	larget
}
```
- `PartialOrd`: 可比较
- `Copy`: 如果 `T` 没有实现 `Copy` 特性, 在 `let mut largest = list[0]` 时候只能把所有权进行转移
	- 也可以指定 `Clone` 特征, 但是会存在大量的数据分配
	- 也可以通过借用实现: 
```rust
fn largest<T: PartialOrd>(list: &[T]) -> &T {
    let mut largest = &list[0];

    for item in list.iter() {
        if item > largest {
            largest = item;
        }
    }

    largest
}
```

#### 通过 `derive` 派生特征
- 被 `derive` 标记的对象会自动实现对应的默认特征代码, 继承相应的功能

### 特征对象
```rust
pub trait Draw {
    fn draw(&self);
}

pub struct Button{
    pub width: u32,
    pub height: u32,
    pub label: String,
}

impl Draw for Button {
    fn draw(&self) {
        
    } 
}

pub struct SelectBox{
    width: u32,
    height: u32,
    options: Vec<String>,
}

impl Draw for SelectBox {
    fn draw(&self) {

    }
}

pub struct Screen {
    pub components: Vec<Box<dyn Draw>>,
}

impl Screen {
    pub fn run(&self) {
        for component in self.components.iter() {
            component.draw();
        }
    }
}

fn main() {
    let screen = Screen {
        components: vec![
            Box::new(SelectBox {
                width: 75,
                height: 10,
                options: vec![
                    String::from("yes"),
                    String::from("no"),
                    String::from("maybe"),
                ],
            }),
            Box::new(Button{
                width: 75,
                height: 10,
                label: String::from("OK"),
            })
        ]
    };
    screen.run();
}
```
- 代码
	- `Screen` 的实现: `components` 是一个动态数组, 其中的元素是 `Draw` 特征对象: `Box<dyn Draw>`
	- `main`: 通过 `Box::new(T)` 的方式创建了两个 `Box<dyn Draw>` 特征对象
- 使用特征对象时候, rust 不会在运行时检查一个值是否实现了特定方法或产生错误, 因为在编译期时即找出问题
- `dyn` 不能单独作为特征对象的定义: 特征对象可以是任意实现了某个特征的类型, 编译器在编译期无法知道该类型的大小, 而 `&dyn` 和 `Box<dyn>` 类型的大小在编译期就是已知的, 所以可以作为特征对象的定义
```rust
10 | fn draw2(x: dyn Draw) {
   |          ^ doesn't have a size known at compile-time
   |
   = help: the trait `Sized` is not implemented for `(dyn Draw + 'static)`
help: function arguments must have a statically known size, borrowed types always have a known size

```
#### 特征对象的动态分发
- 静态分发: 编译器为每个泛型参数对应的具体类型生成一份代码
- **动态分发(dynamic dispatch)**: 知道运行时, 才能确定调用什么方法
	- 在使用特征对象时候, Rust 必须使用动态分发, 编译器步伐知晓所有坑用于特征对象代码的类型, 所以也不知道应该调用那个类型的方法实现
		- 在运行时从 `vtable` 动态查找需要调用的方法
			- `vtable` 中保存了所有类型的实例对于可调用的实现的方法
		- 由下图可以看到: `Box<dyn Trait>` 特征对象中保存了指向实例的指针和指向方法的指针
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240613123307.png)

#### 特征对象的限制
- 不是所有特征都能拥有特征对象, 只有对象安全的特征才行: 
	- 对象安全: 
		- **方法的返回类型不能是 `Self`**
		- **方法没有任何泛型参数**

### 深入了解特征
#### 关联类型
- 在特征定义的语句块中, 申明一个自定义类型, 这样就可以在特征的方法签名中使用该类型
```rust
pub trait Iterator{
	type Item;

	fn next(&mut self) -> Option<Self::Item>;
}
```
- `Self::Item` 用来指代该类型实现中定义的 `Item` 类型
```rust
impl Iterator for Counter{
	type Item = u32;

	fn next(&mut self) -> Option<Self::Item> {
	}
}

fn main() {
	let c = Counter{...};
	c.next();
}
```
- 为什么不使用泛型: 如果使用了泛型, 就需要在所有的地方都写上泛型的声明

#### 默认泛型类型参数
- 在使用泛型类型参数时候, 可以为其指定一个默认的具体类型
```rust
// 若不进行指定, 则`RHS`默认为`Self`类型
trait Add<RHS=Self>{
	type Output;
	fn add(self, rhs: RHS) -> Self::Output;
}
```
```rust
use std::ops::Add;

struct Millimeters(u32);
struct Meters(u32);

// 也可以通过指定`RHS`的类型, 实现不同类型之间的相加
impl Add<Meter> for Millimeters{
	type Output = Millimeters;

	fn add(self, other: Meters) -> Millimeters {
		Millimeters(self.0 + (other.0 * 1000))
	}
}
```

#### 调用同名方法
- 不同的特征可能拥有同名的方法或关联函数
	- 如果该类型也有该方法, 则优先调用类型中实现的方法
	- 对于方法可以通过 `Trait::Method(&self)` 进行调用
	- 对于关联函数可以通过 `(Type as Trait)::Method()` 进行调用
		- 因为关联函数没有 `self` 参数, 无法从中获取到类型信息
- 总而言之都可以归类为: `(Type as Trait)::Method(receiver_if_method, args)`
	- 而关联函数不是 method, 则没有 `receiver_if_method` 字段, `receiver` 则是三类 `self`
```rust
trait Pilot{
	fn fly(&self);
}

trait Wizard{
	fn fly(&self);
}

struct Human;

impl Pilot for Human{
	fn fly(&self) {
		...
	}
	fn new(){
		...
	}
}

impl Wizard for Human{
	fn fly(&self) {
		...
	}
	fn new(){
		...
	}
}

impl Human{
	fn fly(&self) {
	
	}
}

fn main(){
	let person = Human;
	person.fly();
	Pilot::fly(&person);
	Wizard::fly(&person);
	(Human as Pilot)::new();
	(Human as Wizard)::new();
}
```

#### 特征定义中的特征约束
```rust
trait OutlinePrint: Display {

}
```

#### 在外部类型上实现外部特征 (newtype)
- ! 想要打破[[Rust Course#^214e91|孤儿规则]], 可以使用一个包装结构体或元组对外部类型进行包装
```rust
use std::fmt;

struct Wrapper(Vec<String>);

impl fmt::Display for Wrapper {
	fn fmt(&self,f: &mut fmt::Formatter) -> fmt::Result{
		write!(f, "[{}]", self.0.join(", "))
	}
}
```
## 集合类型
### 动态数组 Vector
#### 创建动态数组
- `let v: Vec<i32> = Vec::new()`
- `let v = vec![1, 2, 3]`
- `Vec::from([0,0,0])`
#### 更新 Vector
- `push`

#### Vector 与其元素共存亡
- 当 `Vector` 被删除后, 其内部存储的所有内容也会随之被删除

#### 读取元素
- 两种方法
	- 通过下标索引
	- 使用 `get` 方法 -> 更加安全

#### 同时借用多个数组元素
```rust
let mut v = vec![1, 2, 3, 4, 5];

let first = &v[0];

v.push(6);

println!("The first element is: {first}");

// error
$ cargo run
Compiling collections v0.1.0 (file:///projects/collections)
error[E0502]: cannot borrow `v` as mutable because it is also borrowed as immutable 无法对v进行可变借用，因此之前已经进行了不可变借用
--> src/main.rs:6:5
|
4 |     let first = &v[0];
|                  - immutable borrow occurs here // 不可变借用发生在此处
5 |
6 |     v.push(6);
|     ^^^^^^^^^ mutable borrow occurs here // 可变借用发生在此处
7 |
8 |     println!("The first element is: {}", first);
|                                          ----- immutable borrow later used here // 不可变借用在这里被使用

For more information about this error, try `rustc --explain E0502`.
error: could not compile `collections` due to previous error

```
- ? 一个查询元素, 一个进行尾插, 并不互相影响
	- ! 数组的大小可变, 当旧数组的大小不够用时候, Rust 会重新分配一块更大的内存空间, 将原数组拷贝到新的内存空间上, 这样, 就会导致之前的**引用指向一块无效的内存**

#### 迭代元素
```rust
for i in &v {
	....
}

for i in &mut v{
	....
}
```

#### 存储不同类型的元素
- 可以通过枚举或特征对象
```rust
trait IpAddr {
    fn display(&self);
}

struct V4(String);
impl IpAddr for V4 {
    fn display(&self) {
        println!("ipv4: {:?}",self.0)
    }
}
struct V6(String);
impl IpAddr for V6 {
    fn display(&self) {
        println!("ipv6: {:?}",self.0)
    }
}

fn main() {
    let v: Vec<Box<dyn IpAddr>> = vec![
        Box::new(V4("127.0.0.1".to_string())),
        Box::new(V6("::1".to_string())),
    ];

    for ip in v {
        ip.display();
    }
}
```

#### 常用方法
```rust
let mut v =  vec![1, 2];
assert!(!v.is_empty());         // 检查 v 是否为空

v.insert(2, 3);                 // 在指定索引插入数据，索引值不能大于 v 的长度， v: [1, 2, 3] 
assert_eq!(v.remove(1), 2);     // 移除指定位置的元素并返回, v: [1, 3]
assert_eq!(v.pop(), Some(3));   // 删除并返回 v 尾部的元素，v: [1]
assert_eq!(v.pop(), Some(1));   // v: []
assert_eq!(v.pop(), None);      // 记得 pop 方法返回的是 Option 枚举值
v.clear();                      // 清空 v, v: []

let mut v1 = [11, 22].to_vec(); // append 操作会导致 v1 清空数据，增加可变声明
v.append(&mut v1);              // 将 v1 中的所有元素附加到 v 中, v1: []
v.truncate(1);                  // 截断到指定长度，多余的元素被删除, v: [11]
v.retain(|x| *x > 10);          // 保留满足条件的元素，即删除不满足条件的元素

let mut v = vec![11, 22, 33, 44, 55];
// 删除指定范围的元素，同时获取被删除元素的迭代器, v: [11, 55], m: [22, 33, 44]
let mut m: Vec<_> = v.drain(1..=3).collect();    

let v2 = m.split_off(1);        // 指定索引处切分成两个 vec, m: [22], v2: [33, 44]

```
- ! 也可以通过数组切片的方式获得 `vec` 的部分元素
	- ! 注意：切片和 `&Vec` 是不同的类型，后者仅仅是 `Vec` 的引用，并可以通过解引用直接获取 `Vec`

#### 将 X 类型转换(From/Into 特征)成 Vec
- 只要为 `Vec` 实现了 `From<T>` 特征，那么 `T` 就可以被转换成 `Vec`
```rust
fn main() {
    // array -> Vec
    // impl From<[T; N]> for Vec
    let arr = [1, 2, 3];
    let v1 = Vec::from(arr);
    let v2: Vec<i32> = arr.into();
 
    assert_eq!(v1, v2);
 
    
    // String -> Vec
    // impl From<String> for Vec
    let s = "hello".to_string();
    let v1: Vec<u8> = s.into();

    let s = "hello".to_string();
    let v2 = s.into_bytes();
    assert_eq!(v1, v2);

    // impl<'_> From<&'_ str> for Vec
    let s = "hello";
    let v3 = Vec::from(s);
    assert_eq!(v2, v3);

    // 迭代器 Iterators 可以通过 collect 变成 Vec
    let v4: Vec<i32> = [0; 10].into_iter().collect();
    assert_eq!(v4, vec![0; 10]);

    println!("Success!")
 }
```

### KV 存储 HashMap
[KV 存储 HashMap - Rust语言圣经(Rust Course)](https://course.rs/basic/collections/hashmap.html)
#### 使用迭代器和 collect 方法创建
```rust
fn main(){
	use std::collections::HashMap;

	let teams_list = vec![
		("中国队".to_string(), 100),
		...
	];

	let mut teams_map1 = HashMap::new();
	for team in &teams_list {
		teams_map.insert(&team.0, &team.1);
	}

	let teams_map2: HashMap<_, _> = teams_list.into_iter().collect();

}
```

#### 所有权转移
- 若类型实现了 `Copy` 特征, 该类型会被复制进 `HashMap` 中
- 若类型没有实现, 则会发生所有权转移

#### 查询 HashMap
- 通过 `get` 方法, 返回一个 `Option<&V>` 类型
> [!note] 可以通过 `Some<T>.as_ref()` 将其转换为 `Some<&T>` 类型
- 通过索引返回的是 `V` 类型的

#### 更新 HashMap 中的值
```rust
fn main() {
    use std::collections::HashMap;

    let mut scores = HashMap::new();

    scores.insert("Blue", 10);

    // 覆盖已有的值
    let old = scores.insert("Blue", 20);
    assert_eq!(old, Some(10));

    // 查询新插入的值
    let new = scores.get("Blue");
    assert_eq!(new, Some(&20));

    // 查询Yellow对应的值，若不存在则插入新值
    let v = scores.entry("Yellow").or_insert(5);
    assert_eq!(*v, 5); // 不存在，插入5

    // 查询Yellow对应的值，若不存在则插入新值
    let v = scores.entry("Yellow").or_insert(50);
    assert_eq!(*v, 5); // 已经存在，因此50没有插入
}
```
- `or_insert()` 返回的是 `&mut v` 的引用, 因此可以通过该可变引用直接修改 `map` 中对应的值

#### HashMap key 的限制
- 任何实现了 `Eq` 和 `Hash` 特征的类型都可以用于 `HashMap` 的 key
	- `f32` 和 `f64` 并没有实现 `Hash`

#### 容量
- 在初始化时候, 可以通过 `HashMap::with_capacity(uint)` 来指定初始容量
- 在后续也可以使用 `shrink_to(uint)` 对容量进行收缩
	- ! 锁提供的值仅仅是一个允许的最小值, rust 会根据当前 map 中存储的数据量进行收缩
	- 也可以考虑使用 `shrink_to_fit()`
## 认识生命周期
- 大多数时候无需手动生命生命周期, 编译器会自行进行推导

### 悬垂指针和生命周期
```rust
{
    let r;                // ---------+-- 'a
                          //          |
    {                     //          |
        let x = 5;        // -+-- 'b  |
        r = &x;           //  |       |
    }                     // -+       |
                          //          |
    println!("r: {}", r); //          |
}                         // ---------+

```
- rust 使用借用检查器检查程序中借用的正确性: `r` 变量被赋予了生命周期 `'a`, `x` 被赋予了生命周期 `'b`, **在编译期, rust 会比较两个变量的生命周期**, 结果发现 `r` 引用了一个生命周期比他小得多的变量, 在这种情况下, 编译期会认为程序存在风险
	- 想要使其正确, 就需要引用生命周期比他大的变量
```rust
{
    let x = 5;            // ----------+-- 'b
                          //           |
    let r = &x;           // --+-- 'a  |
                          //   |       |
    println!("r: {}", r); //   |       |
                          // --+       |
}                         // ----------+
```

### 函数中的生命周期
```rust
fn main() {
    let string1 = String::from("abcd");
    let string2 = "xyz";

    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);
}

fn longest(x: &str, y: &str) -> &str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
---
error[E0106]: missing lifetime specifier
 --> src/main.rs:9:33
  |
9 | fn longest(x: &str, y: &str) -> &str {
  |               ----     ----     ^ expected named lifetime parameter // 参数需要一个生命周期
  |
  = help: this function's return type contains a borrowed value, but the signature does not say whether it is
  borrowed from `x` or `y`
  = 帮助： 该函数的返回值是一个引用类型，但是函数签名无法说明，该引用是借用自 `x` 还是 `y`
help: consider introducing a named lifetime parameter // 考虑引入一个生命周期
  |
9 | fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
  |           ^^^^    ^^^^^^^     ^^^^^^^     ^^^

```
- 报错: 在定义函数时候, 无法知道传递给函数的具体值, 也**无法知道传入引用的具体生命周期**, 编译器的借用检查无法推导除返回值得生命周期

### 生命周期标注语法
- **生命周期标注并不会改变任何引用的实际作用域, 而是告诉编译器: 当不满足此约束条件时候, 就拒绝编译通过**
	- 使用生命周期标注的真正作用: 让编译器正确认识到多个引用之间的关系, 帮我们提前规避可能存在的代码风险
- 生命周期标注语法: 
```rust
&i32        // 一个引用
&'a i32     // 具有显式生命周期的引用
&'a mut i32 // 具有显式生命周期的可变引用
```
- 生命周期标注的功能: 告诉编译期多个引用之间的关系, 表明这两个参数 `first` 和 `second` 至少活的和 `'a` 一样久, 至于到底活多久, 无法得知
#### 函数签名中的生命周期标注
```rust
fn longest<'a>(x: &'a str, y:&'a str) -> &'a str{
	if x.len() > y.len(){
		x
	} else {
		y
	}
}
```
- ! 注意
	- 在使用生命周期参数时候, 需要先进行声明: `<'a>`
	- `x`, `y` 和返回值至少活的和 `'a` 一样久 (说明 `'a` 表明的生命周期与参数生命周期中的较小值一致)
```rust
fn main(){
	let string1 = String::from("long string is long");
	{
		let string2 = String::from("xyz");
		let result = longest(string1.as_str(), string2.as_str());
		println!(....);
	}
}
```
- 上面代码调用 `longest` 所返回的 `result` 的生命周期与 `string2` 的生命周期一样久
```rust
fn main() {
    let string1 = String::from("long string is long");
    let result;
    {
        let string2 = String::from("xyz");
        result = longest(string1.as_str(), string2.as_str());
    }
    println!("The longest string is {}", result);
}
---
error[E0597]: `string2` does not live long enough
 --> src/main.rs:6:44
  |
6 |         result = longest(string1.as_str(), string2.as_str());
  |                                            ^^^^^^^ borrowed value does not live long enough
7 |     }
  |     - `string2` dropped here while still borrowed
8 |     println!("The longest string is {}", result);
  |                                          ------ borrow later used here
```
- 在上面的代码中, `result` 无法活到被 `pringln` 的时候

#### 深入思考生命周期标注
- ! 如果函数的返回值是一个引用类型, 那么它的生命周期只会来源于: 
	- 函数参数的生命周期
	- 函数体中某个新建引用的生命周期 -> 悬垂引用
		- 悬垂引用的解决方法: 返回一个所有权, 将所有权转移给函数调用者

### 结构体中的生命周期
> [!question] 为什么不在结构体中使用字符串字面量或字符传切片? 而是统一使用 `String` 类型
> 后者在结构体初始化时候, 只需要转移所有权即可, 而对于引用, 不能为所欲为.
> 但现在已经理解了生命周期, 则可以进行尝试: 为结构体中的每一个引用标注上生命周期.

[认识生命周期 - Rust语言圣经(Rust Course)](https://course.rs/basic/lifetime.html#%E7%BB%93%E6%9E%84%E4%BD%93%E4%B8%AD%E7%9A%84%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F)

### 生命周期消除
- ! 对于编译器来说, 每一个引用类型都有一个生命周期
	- ? 为什么很多时候无需标注生命周期? -> 生命周期消除
		- 对于一个函数来说, 若期返回值是一个引用类型, 则其一般来自参数 (从函数体内部获取会出现悬垂引用问题), 这意味着参数和返回值的生命周期是一致的
> [!attention] 注意
> - 消除规则不是万能的, 若编译器不能确定, 则会直接判定不正确
> - 函数或方法中, 参数的生命周期被称为**输入生命周期**, 返回值得生命周期被称为**输出生命周期**

#### 三条消除规则
- 针对输入生命周期: 每一个引用参数都会获得独自的生命周期
- 针对一般函数的输出生命周期: 若只有一个输入生命周期, 那么该生命周期会被赋给所有输出的生命周期
- 针对方法的输出生命周期: 若存在多个生命周期, 且其中一个是 `&self` 或 `&mut self`, 则 `&self` 的生命周期会赋给所有输出的生命周期

### 静态生命周期
- 特殊的生命周期: `'static`, 拥有该生命周期的引用可以和整个程序活的一样久

## 返回值和错误处理
### `panic` 深入剖析
- 两种触发方式: 
	- 被动触发: Rust 对代码的一种保护
	- 主动调用: 调用 `panic!` 宏

#### `backtrace` 栈展开
- 设置环境变量 `RUST_BACKTRACE=1`
	- linux: `RUST_BACKTRACE=1 cargo run`
	- windows: `$env:RUST_BACKTRACE=1; cargo run`
- 要获得栈回溯信息, 还需要开启 `debug` 标志
	- 该标志在使用 `cargo run` 或 `cargo build` 时候自动开启

#### `panic` 与线程
- 发生 `panic` 时候, 会终止当前线程, 而不是整个程序

#### 何时使用 `panic!`
- 示例, 原型, 测试
- 确切知道程序是正确的
- 可能导致全局有害状态时

#### panic 原理
- 调用 `panic!` 宏
	- 首先, 对 `panic` 的信息进行格式化, 使用该信息作为调用 `std::panic::panic_any()` 的参数
	- `panic_any` 会检查是否使用了 `panic hook` 
		- ? panic hook: 是外部代码设置的一个钩子函数, 用于在 `panic` 触发时候, 执行外部代码所需要的功能
	- `hook` 函数返回过后, 对当前的线程进行**栈展开**
		- 从 `panic_any` 开始, 如果寄存器或栈因为某些原因错乱, 可能会导致展开过程发生异常, 导致线程终止, 无法正常展开
	- 展开的过程会逐帧的回溯整个栈, 每个帧的数据会被随之抛弃 (pop)
		- 如果在栈展开的过程中, 遇到了被用户标记为 `catching` 的帧, 则会停止展开并调用用户提供的 `catch` 函数
			- `catch` 内部可以通过调用 `std::panic::resume_unwind()` 函数, 继续展开
- 栈展开的结果 (结束或终止): 最终的输出取决于 `panic` 的线程
	- `main` 线程的终止, 会调用操作系统提供的终止功能 `core::intrinsics::abort()`, 结束当前的进程
	- 子线程则会简单的终止, 同时信息会稍后通过 `std::thread::join()` 进行收集

### 可恢复的错误
```rust
use std::fs::File;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => {
            panic!("Problem opening the file: {:?}", error)
        },
    };
}
```
#### 对返回的错误进行处理
```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Problem creating the file: {:?}", e),
            },
            other_error => panic!("Problem opening the file: {:?}", other_error),
        },
    };
}
```

#### 失败就 panic: `unwrap` 和 `expect`

#### 传播错误
- 在实际应用中, 可能会把错误层层上传交给调用链的上游函数进行处理
```rust
use std::fs::File;
use std::io::{self, Read};

fn read_username_from_file() -> Result<String, io::Error> {
    // 打开文件，f是`Result<文件句柄,io::Error>`
    let f = File::open("hello.txt");

    let mut f = match f {
        // 打开文件成功，将file句柄赋值给f
        Ok(file) => file,
        // 打开文件失败，将错误返回(向上传播)
        Err(e) => return Err(e),
    };
    // 创建动态字符串s
    let mut s = String::new();
    // 从f文件句柄读取数据并写入s中
    match f.read_to_string(&mut s) {
        // 读取成功，返回Ok封装的字符串
        Ok(_) => Ok(s),
        // 将错误向上传播
        Err(e) => Err(e),
    }
}

```

##### 使用 `?` 简化代码
- `?` 是一个宏, 作用与 `match` 几乎一致
	- 甚至可以自动进行类型转换, `?` 会自动进行隐式类型转换
	- 还可以实现链式调用
```rust
use std::fs::File;
use std::io;
use std::io::Read;

fn read_username_from_file() -> Result<String, io::Error>{
	let mut f = File::open("hello.txt")?;
	let mut s = String::new();
	f.read_to_string(&mut S)?;
	Ok(s)
}

fn read_username_from_file() -> Result<String, io::Error>{
	let mut s = String::new();
	File::open("hello.txt")?.read_to_string(&mut S)?;
	Ok(s)
}

fn open_file() -> Result<File, Box<dyn std::error::Error>>{
	let mut f = File::open("hello.txt")?;
	Ok(f)
}
```
- `?` 还可以用于 `Option` 的传播
```rust
fn last_char_of_first_line(text: &str) -> Option<char>{
	text.lines().next()?.chars().last()
}
```
- 常见错误: 下面的代码无法通过变异, `?` 操作符需要一个便来来承载正确的值, 而对于错误的值, 会直接返回, 因此 `?` 只能用于: 
	- `let v = xxx()?;`
	- `xxx()?.yyy()?;`
```rust
fn first(arr: &[i32]) -> Option<&i32> {
	arr.get(0)?
}
```

##### 带有返回值的 main
```rust
use std::error::Error;
use std::fs::File;

fn main() -> Result<(), Box<dyn Error>>{
	let f = File::open("hello.txt")?;
	OK(())
}
```
## 包和模块
### 包


### 模块


### 使用 use 引入模块及首先可见性

## 注释和文档

## 格式化输出
