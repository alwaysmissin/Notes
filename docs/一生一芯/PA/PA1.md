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
	- 针对函数的一些未定义行为：![image.png](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230823101338.png)
	- 针对singed integer与unsigned integer的：![image.png](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230823101851.png)
	- 则`cpu_exec(-1)`不属于未定义行为

- `main`函数返回后，还会执行`atexit()`函数，来执行一些清理任务，
	- `int atexit(void(* function*) (void))`
	- 在运行时，将一个函数的指针传递给`atexit`函数，则会在`main`函数执行完毕后，执行这个函数