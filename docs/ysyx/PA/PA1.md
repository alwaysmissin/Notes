# PA1
## 开天辟地的篇章
### 尝试理解计算机如何计算
计算机所做的事情：
```c
while(1){
	取指;
	译码;
	执行;
	更新PC;
}
```
在执行`1+2+...+100`时候，从第一行取出指令，进行译码工作，执行，更新PC至下一条指令，不断的执行一条条指令，经过一个循环，即可完成一次`1+2+...+100`的计算
每一轮循环的计算过程如下：
1. 将`r2`寄存器上的值`+1`
2. 将`r2`寄存器的值加到`r1`上
3. 如果`r2`的值小于100（边界），则返回再次从1开始执行
4. 否则结束
经过如上的几轮循环，就可以在寄存器`r1`上得到我们想要的结果了
因此，实际上计算机做的只是如此枯燥的工作，但是如果我们实现了一个巨大的状态机模型，计算机就可以通过这样枯燥的工作，完成许多困难的任务，但是无论如何，计算机只是在不断重复这些工作。

### 从状态机的视角理解程序运行
```c
(0, x, x) -> (1, 0, x) -> (2, 0, 0) -> (3, 0, 1) -> (4, 1, 1) -> (3, 1, 2) -> (4, 3, 2) -> (3, 3, 3) -> (4, 6, 3) -> (3, 6, 4) -> (4, 10, 4) -> (3, 10, 5) -> (4, 15, 6) -> (4, 21, 6) -> (3, 21, 7) -> (4, 28, 7) -> ...... -> (3, 4851, 99) -> (4, 4950, 99) -> (3, 4950, 100) -> (4, 5050, 100) -> (5, 5050, 100) -> end
```

## RTFSC
> [!note] 宏是如何工作的
> [Macro (computer science) - Wikipedia](https://en.wikipedia.org/wiki/Macro_(computer_science))
> a macro is a rule or pattern that specifies how a certain input should be mapped to a replacement output.
> "macro" 暗示着将小命令或动作转化为一系列指令
> 宏的用途在于自动化频繁使用的序列或者是获得一种更强大的抽象能力

- 对于riscv
	- MemoryBASE=0x80000000
	- PC_RESET_OFFSET=0x0
- 究竟要执行多久？
	- 参数的类型是uint_64，则传入参数-1（-1的补码表示0xFFFFFFFFFFFFFFFF）时，在经过了隐式转换后，变为了无符号数，可以理解为无限执行，直到遇到了异常或错误
	```c
	#include <stdio.h>
	#include <stdint.h>
	#include <stdbool.h>
	void print(uint64_t n){
	        bool is_positive = (n > 0);
	        printf("%d", is_positive);
	        for(;n > 0;n--){
	                printf("%ld", n);
	        }
	}
	
	int main(){
	        int n = -1;
	        print(n);
	        return 0;
	}
	
	```

- 未定义行为：
	- 针对函数的一些未定义行为：![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230823101338.png)
	- 针对singed integer与unsigned integer的：![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230823101851.png)
	- 则`cpu_exec(-1)`不属于未定义行为

- `main`函数返回后，还会执行`atexit()`函数，来执行一些清理任务，
	- `int atexit(void(* function*) (void))`
	- 在运行时，将一个函数的指针传递给`atexit`函数，则会在`main`函数执行完毕后，执行这个函数

## 监视点
### 断点
- 原理：将目标指令替换为`int 3`指令，使得程序运行到该指令时候，进程暂停
- 一点也不能长？
	- 不可以，因为x86的指令长度不固定，最短的指令可能只有一个字节，如果使用两个字节替换了原指令，可能导致目标断点的下一个指令错误
- 随意的断点：
	- 不可以，出现：SEGEMENTATION FAULT![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829150352.png)
- 模拟器与调试器的区别：
	- 模拟器为程序创造一个适合的运行环境
	- 调试器控制程序的运行

## 如何阅读手册
- 使用目录
- 逐步细化：
	- 如果不知道一个概念，可以先使用搜索引擎
	- 利用小标题、段落开头、图标筛选

## 必答题
- 程序是个状态机：
```c
(0, x, x) -> (1, 0, x) -> (2, 0, 0) -> (3, 0, 1) -> (4, 1, 1) -> (3, 1, 2) -> (4, 3, 2) -> (3, 3, 3) -> (4, 6, 3) -> (3, 6, 4) -> (4, 10, 4) -> (3, 10, 5) -> (4, 15, 6) -> (4, 21, 6) -> (3, 21, 7) -> (4, 28, 7) -> ...... -> (3, 4851, 99) -> (4, 4950, 99) -> (3, 4950, 100) -> (4, 5050, 100) -> (5, 5050, 100) -> end
```
- 理解基础设施：
	- 调试上所花费的时间：
		- 每解决一个bug所需要的时间：600s
		- 如果每次调试都能解决一个bug：`500*90%*600s=270000s=4500min=75h`
	- 实现简易调试器，可节省：`50h`！！！！！
- RTFM：
	- riscv32中有哪几种指令格式(V1: 2.2 Base Instruction Formats   2.3 Immediate Encoding Variants)：
		- 6种：
			- Basic：
				- R-type![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829152847.png)
				- I-type![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829152855.png)
				- S-type![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829153005.png)
				- U-type![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829152908.png)
			- Further：
				- B-type![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829153022.png)
				- J-type![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829153031.png)

	- `LUI`指令的行为是什么(V1: 2.4 Integer Computational Instructions)
		- LUI(Load Upper Immediate): build 32-bit constants
		- U-type：![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829153628.png)
		- 将目标寄存器的高20位替换为U-immediate，低位补0
	- `mstatus`寄存器的结构是怎样的（V2：3.1.6 Machine Status Registers）
		- rv32:![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829154418.png)
		- rv64:![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829154430.png)
- shell命令：
	- 代码行数统计：`find . -name "*.[ch]" | xargs wc -l`
		- 解释：
			- 使用find查找以`.c`或`.h`结尾的文件
			- 通过管道和`xargs`，将参数传给wc，进行统计
		- 比较：
			 - 框架代码数量：23806
			 - 完成PA1后的代码数量：24299
	 - 代码行数统计（过滤空行）：`find . -name "*.[ch]" | xargs cat | grep -v ^$ | wc -l`
		 - 解释：
			- 使用find查找以`.c`或`.h`结尾的文件
			- 使用`cat`读取文件内容
			- 使用`grep -v`过滤其中的空行
			- `wc`进行统计
		 - 比较
			 - 框架代码数量：20631
			 - 完成PA1后的代码数量：21107
- RTFM：
	- 如PA1中的监视点所说：`-Wall`和`-Werror`会在编译时候将一些潜在的fault直接转化为failure，在编译时候直接指出代码中的错误
	- `-Wall`：enables all the warnings about constructions
		- 所启用的警告标志：![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230829155450.png)
	- `-Werror`：make all warnings into errors, any warning will make compile fail