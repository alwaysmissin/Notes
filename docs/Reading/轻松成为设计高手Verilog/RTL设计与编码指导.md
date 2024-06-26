# RTL 设计与编码指导
## 一般性指导原则
- 4 个基本设计原则: 
	- 面积和速度的平衡与互换原则: 对立与统一
	- 硬件原则: 理解 HDL 语言设计的本质
	- 系统原则: 通过全局, 整体上把握设计, 提高设计质量, 优化设计效果
	- 同步设计原则: 是设计时序稳定的基本要求, 也是高速 RTL 设计的通用法则

### 面积和速度的平衡与互换原则
- 指标: 
	- 面积: 一个设计所消耗的目标器件的硬件资源数量
		- 对于 FPGA, 使用所消耗的触发器 (FF) 和查找表 (LUT)来衡量
	- 速度: 指设计在芯片上稳定运行时所能够达到的最高频率

### 硬件原则
- HDL 语言与 C 语言等软件相比的显著区别: **HDL 语言便于描述"互连", "并发", "时间"**
	- 互连 (connectivity): 互连是硬件电路的基本要素, 在 C 语言中, 并没有直接可以用来表示模块间互连的变量; 而 HDL 的网线行变量则专为模块互连而设计, 描述电路连接清晰明确
	- 并发 (concurrency): C 语言天生串行, 不能描述硬件之间并发的特性, C 语言编译后, 其机器指令在 CPU 的高速缓冲队列中基本是顺序执行; 而 verilog 可以有效的描述并行的硬件系统, 硬件系统比软件系统速度快, 实时性高的重要原因是: **硬件系统中各个单元的运算是独立的, 信号流是并行的**
		- 在使用 HDL 建模时候, 如果能够充分理解硬件系统的并行处理的特点, 合理安排数据流的时序, 则可以提高整个设计的效率
	- 时间 (time): C 程序运行的时候, 没有严格的时间概念, 程序运行的长短, 取决于处理器本身的性能; 而 HDL 语言定义了绝对和相对的时间度量, 在仿真时可以通过事件度量与周期关系描述信号之间的时间关系

> [!note] for 循环体
> 在 C 语言的描述中, 为了使代码执行效率提高, 会经常使用到 `for` 语句, 而对于 HDL 语言则不是如此.
> 在 HDL 语言中, 除了描述仿真测试激励时使用 `for` 循环外, RTL 级编码需要慎用 `for` 循环, 因为 `for` 循环会被综合器展开为所有变量情况的执行语句, 每个变量独立占用寄存器资源, 有些情况下不能有效复用硬件逻辑资源, 造成资源浪费.
> 在 RTL 硬件描述中, 遇到类似算法, 常用的方式是先搞清楚设计的时序要求, 做一个 `reg` 型计数器, 在每个时钟沿累加, 并在每个时钟沿判断计数器的情况, 并且做相应的处理, 以此达到复用处理模块的效果