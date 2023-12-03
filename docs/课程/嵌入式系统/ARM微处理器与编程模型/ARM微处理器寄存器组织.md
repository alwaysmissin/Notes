# ARM微处理器寄存器组织
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518104516.png)
## 通用寄存器
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518105311.png)

### 未分组寄存器
- 未分组寄存器：R0~R7![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518105103.png)
	- 在所有的其中模式下，都只想相同的物理寄存器
	- 用途：保存数据或地址
> [!attention] 
> 需要小心工作模式转换时，可能会造成寄存器中的数据破坏

### 分组寄存器
- 分组寄存器R8~R14
- R8~R12
	- 每次访问的物理寄存器与当前的运行模式有关![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518105354.png)
- R13~R14![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518110510.png)
	- R13堆栈指针
		- 在ARM指令集中,常用作堆栈指针
		- 在Thumb指令集中，某些指令强制性要求使用R13作为堆栈指针
	- R14子程序链接寄存器
		- 又称为链接寄存器LR
		- 当执行子程序调用指令`BL`时，可以用于得到程序计数器`PC（R15）`的值
		- 两种特殊功能:
			- 在每种模式下都可以用于保存子程序的返回地址
			- 发生异常时，用于保存异常处理后的返回地址
				- 如中断处理
	- 程序计数器PC（R15）
		- 所有运行模式通用
		- ARM状态：`bit[1:0]=00`，`bit[31:2]`用于存放PC
			- **PC的值**：当前正在执行的指令地址+8（当前正在执行指令的下两条指令）
				- 原因：ARM的三级流水线
		- Thumb状态：`bit[0]=0`，`bit[31:1]`用于存放PC
> [!tip]
> 当程序运行进入异常模式时，可以将需要保护的寄存器内容放入R13所指向的堆栈中，当程序从异常模式返回时，则可以从对应的堆栈中进行恢复

### 状态寄存器
- 状态寄存器6个
- 当前程序状态寄存器CPSR(Current Program Status Register)
	- 所有运行模式下都指向相同的物理寄存器
- 备份程序状态寄存器SPSR(Saved Program Status Register)
	- 每种异常模式都有自己专用的物理寄存器
	- 异常发生时，用于操作CPSR；退出异常时，进行恢复
	- 用户模式和系统模式下无效
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518111750.png)
- 条件码标志位`N`、`Z`、`C`、`V`：
	- 它们的内容由算术或逻辑运算的结果决定，通常用于决定某条指令是否可以被执行
	- ARM状态：绝大多数的指令都是有条件执行的
	- Thumb状态：仅有分支指令（B指令）是有条件执行的
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518112232.png)
- 保留位：
	- 为了提高程序的可移植性，当改变CPSR标志和控制位时，尽量不改变保留位的值
	- 为了保证程序后续的兼容性，不应该让保留位的值影响程序的运行
- 控制位
	- `I`、`F`、`T`和`M[4:0]`：发生异常时候可以被改变
	- 特别：在特权模式下，可以由程序来修改：
		- 中断禁止位：`I`、`F`
			- `I=1`：禁止`IRQ`中断
			- `F=1`：禁止FIQ中断
		- 模式位`M[4:0]`：决定处理器的运行模式：
			- `10000`：用户模式
			- `10001`：FIQ模式
			- `10010`：IRQ模式
			- `10011`：管理模式
			- `10111`：中止模式
			- `11011`：未定义
			- `11111`：系统模式
	- `T`反映处理器的运行状态：ARM/Thumb

> [!attention] 
> Thumb状态下的寄存器组是ARM状态下寄存器组的一个子集![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518112832.png)
