# robocup预习材料 2



# 什么是编程范式？

编程范式是程序员设计程序时所遵循的 **方法论**。它指导我们

- 应该以怎样的视角去分析一个问题
- 应该以怎样的结构将其表示为一个程序

- 应该以怎样的模型完成对程序的计算



计算机，核心在与 **计算**。什么是计算呢？维基百科给出的解释是：

  计算是基于给定的基本规则进行演化的过程。

# 计算模型

## 顺序模型 1 —— 图灵机

### 什么是图灵机？

[https://zh.wikipedia.org/wiki/%E5%9B%BE%E7%81%B5%E6%9C%BA](https://zh.wikipedia.org/wiki/图灵机)

### 可计算性（Computability）

> **理发师悖论**
>
> 小城里的理发师放出豪言：他要为城里人刮胡子，而且一定只要为城里所有 “不为自己刮胡子的人” 刮胡子。 
>
> 但问题是：**理发师该为自己刮胡子吗？**如果他为自己刮胡子，那么按照他的豪言 “只为城里所有不为自己刮胡子的人刮胡子”，他不应该为自己刮胡子；但如果他不为自己刮胡子，同样按照他的豪言 “一定要为城里所有不为自己刮胡子的人刮胡子” 他又应该为自己刮胡子。 

停机问题

### 什么是图灵完备

能模拟一个图灵机就叫图灵完备。

brainfuck 是最简单的图灵完备的语言。

## 顺序模型 2 —— 有限状态机（FSM）

### 组合逻辑与时序逻辑

状态转移函数：组合逻辑

状态：二进制编码 + 寄存器

### 电路实现 FSM

## 过程式编程

核心：状态

从冯诺伊曼计算机架构的角度看，过程式编程范式不过是汇编语言一层薄薄的抽象，而汇编指令（除了伪指令）的设计直接决定了 CPU 的指令集。



# 函数式编程

## 引用透明

C 语言中的函数和数学上的函数其实是很不一样的。

数学上，函数是 **定义域到值域的一个映射**。对于定义域中任意一个元素，值域中都存在唯一一个元素与之对应。也就是 **给定函数的参数，其返回值应该是唯一确定的**。

但请看下面的 C 语言程序：

```c
int x = 10;

int sub_y(int y) {
    return x - y;
}

sub_y(3); // 7
sub_y(3); // 4
```

两次对 `sub_y` 的调用参数都是 3，但返回值却不同。原因是显然的，因为函数还有一个 “隐式” 的输入 —— 变量 x。

我们把 C 和其他编程语言中，和==数学上的函数一样满足 “不管环境如何，只要给定函数的参数，其返回值应该是唯一确定的” 这一性质的函数称为 **纯函数**==，否则成为 **有副作用的函数**（上面例子中的 `sub_y` 就是）。这一性质称为 **引用透明**。

也就是说，==如果一个函数里有 **需要和 “环境“ 交互的操作**（也就是 **副作用**），那么这个函数就是 **不纯的**==。

## 代换模型

你可能会问，这有什么重要的么？

回忆化简数学式子的过程，我们从内而外不断将一部分表达式求值，并用求值得到的结果替换之。这一简单的化简方法称为 **代换模型**。

以 f(g(3), h(2)) 为例，如果 f,g,h 都是引用透明的，那么我们可以用代换模型求值。注意求值 f(*,*), g(3) 和 h(2) 的顺序是无关紧要的，因为我们知道不管什么时候求值这两个函数，其值都是一样的。

但如果 f,g,h 不是引用透明的，代换模型就不适用了！我们要考虑求值的先后顺序，变量的引用关系等等一大堆问题，为此我们要建立一个比代换模型复杂的多的求值模型。

## 递归的开销

![img](https://cdn.nlark.com/yuque/__latex/5122b752209750225084fc8121268163.svg)

```plain
fact :: Integer -> Integer
fact 1 = 1
fact n = n * (fact (n - 1))

main = do print $ map fact [1..10]

------
Output:
[1,2,6,24,120,720,5040,40320,362880,3628800]
```

![img](https://cdn.nlark.com/yuque/__latex/c20b3253439717e32d4c1aea74685393.svg)

```plain
fib :: Integer -> Integer
fib 1 = 1
fib 2 = 1
fib n = (fib (n - 1)) + (fib (n - 2))

main = do print $ map fib [1..10]
  
------
Output:
[1,1,2,3,5,8,13,21,34,55]
```

## 递归地思考

### 辗转相除法

![img](https://cdn.nlark.com/yuque/__latex/03e995313d3ceafcc2dfc8c0f0f90ae7.svg)

```plain
gcd :: Integer -> Integer -> Integer
gcd a 0 = a
gcd a b = gcd b (mod a b)
```

### 递归快速幂

![img](https://cdn.nlark.com/yuque/__latex/07557577dbe2cdaea2d8ecadc2005af9.svg)

```c
int fast_pow(int x, int a) {
    if (a == 1) return x;
    else if (a % 2 != 0) return x * fast_pow(x, a - 1);
    else {
        // 为什么要引入 t？
        // 直接 return fast_pow(x, a / 2) * fast_pow(x, a / 2) 有什么问题吗？
        int t = fast_pow(x, a / 2);
        return t * t;
    }
}
```

**作业 1. 快速乘**

我们知道，乘法计算可以转化为一系列加法计算。同时，计算机可以用 **移位运算** 非常高效地计算一个数 **乘 2 的幂** 的结果。试参考快速幂的思想，实现快速乘算法。

要求：使用 **递归实现**。(俄罗斯农民乘法)

## 循环与尾递归

尾递归空间

### 尾递归求斐波拉契数列

```c
#include <stdio.h>

int fib(int n) {
	int curr = 0;
	int next = 1;
	while (n > 0) {
		int tmp = curr;
		curr = next;
		next = curr + tmp;
		n--;
	}
	return curr;
}


int main() {
    for (int i=1; i<=10; i++) {
        printf("%d ", fib(i));
    }
    return 0;
}

/********* Output *********
 1 1 2 3 5 8 13 21 34 55
 *************************/
fib :: Integer -> Integer -> Integer -> Integer
fib 0 curr _ = curr
fib n curr next = fib (n - 1) next (curr + next)

main = print $ map (\n -> fib n 0 1) [1..10]

------
Output:
[1,1,2,3,5,8,13,21,34,55]
#include <stdio.h>

int fib(int n, int curr, int next) {
    if (n == 0) return curr;
    else return fib(n - 1, next, curr + next);
}


int main() {
    for (int i=1; i<=10; i++) {
        printf("%d ", fib(i, 0, 1));
    }
    return 0;
}

/********* Output *********
 1 1 2 3 5 8 13 21 34 55
 *************************/
```

**作业 2.** 试用==迭代法计算阶乘==，并用尾递归改写。

### 尾递归快速幂

![img](https://cdn.nlark.com/yuque/__latex/f8471c6c24cf1f43396f6f7b6f29d367.svg)

```c
int fast_pow(int x, int a, int ans) {
	if (a == 0) return ans;
	else if (a % 2 != 0) return fast_pow(x, a - 1, ans * x);
	else return fast_pow(x * x, a >> 1, ans);
}
```

**作业 3**. 试用尾递归改写快速乘算法（作业 1）

### 矩阵快速幂计算斐波拉契数列

回忆迭代法计算斐波拉契数列的过程：迭代中只有两个变量，curr 和 next，每次迭代对这两个变量进行以下变换：curr := next，next := curr + next，现在将这种变换称为 T 变换。从初始状态 curr = fib(0) = 0, next = fib(1) = 1 开始，将 T 反复应用 n 次，则可得到 fib(n) 和 fib(n+1)。

下面引入矩阵语言表述上述过程：

![img](https://cdn.nlark.com/yuque/__latex/5c10850cd04688f0d0737681c14937ef.svg)



![img](https://cdn.nlark.com/yuque/__latex/def091af04593f970c673d019267f32a.svg)



![img](https://cdn.nlark.com/yuque/__latex/179805377ed9da0374b62e8a31e55efb.svg)



![img](https://cdn.nlark.com/yuque/__latex/f5c3e8e39b4bb9cd0c8042f03b092b80.svg)

又由于

![img](https://cdn.nlark.com/yuque/__latex/058fc9ba1566942732d57953ce2876c9.svg)



因此可以使用快速幂的思想计算 ![img](https://cdn.nlark.com/yuque/__latex/b1dbfa575cbf69875c4237ca53ac2875.svg)。

```python
import torch

def fast_matrix_pow(mat: torch.Tensor, a: int) -> torch.Tensor:
    if a == 0:
        return mat
    elif a % 2 != 0:
        return mat @ fast_matrix_pow(mat, a - 1)
    else:
        t = fast_matrix_pow(mat, a / 2)
        return t @ t
    
def fib(n: int) -> int:
    t0 = torch.Tensor([[0], [1]])
    T = torch.Tensor([[0, 1], [1, 1]])
    tn = fast_matrix_pow(T, n) @ t0
    return tn[0][0].item()
```

## 循环不变式

### Hoare 划分算法及其正确性证明

**作业 4. Lomuto 划分算法**

试用循环不变式证明这一算法的正确性。

## 把函数串起来

### 函数组合

数学里我们经常会写 “令 h(x) = f(g(x))” 这样的式子，实际上这就是把两个函数 f(x), g(x) 通过嵌套，组合为了一个新函数 h(x)。

编程中，这种操作也是常见的。假设我们需要把一个列表 l 里的所有元素都乘二后再加一，那么我们可以构造一个函数 op(x) = add1(mult2(x))，然后对列表的每个元素都应用一次这个函数即可。

### 匿名函数

给一个东西命名总是很恼火的！尤其是一些一次性的东西，命名通常是没有必要的。

```plain
add1 :: Int -> Int
add1 x = x + 1

main = do
  print $ map add1 [1..10]
main = do
  print $ map (\x -> x + 1) [1..10]
```

c++ 的 sort 函数需要一个比较器，如果我们在一个程序里面用到多个不同的比较器，那给这些比较器起不同的名字是十分烦人的。因为每个比较器都只在对应的 sort 函数里用一次，根本没有必要命名。

### 柯里化

对于一个接受两个参数的函数，如果指定一个参数的值，所得到的是一个什么东西呢？显然还是一个函数，只不过只需要接受一个参数了。

比如 add(x, y) 是一个接受两个参数的函数，如果指定 x=1，所得到的是一个新函数，只需要一个参数 y，作用是将 y 加一。

### 高阶函数

------

讲到这里应该就差不多了

## 单子（Monad）

**单子（Monad）**是 **自函子（Endofunctor）**范畴上的一个 **幺半群（Monoid）**

# 面向对象编程

## 型变（Variance）

### 三种型变

#### 逆变

#### 协变

#### 不变

### 函数上的型变

### 结构的型变

## 分派 （Dispatch）

### 多态

#### 特设（ad hoc）多态

#### 参数多态

#### 子类型多态

### 静态派发

### 动态派发

### 多重派发

### 消息派发