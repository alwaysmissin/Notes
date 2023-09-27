# Procedures
## Always
- two types of always blocks
	- Combinational: `alaways @(*)`
	- Clocked: `always @(posedge clk)`
- Combinational always blocks **equals to assign statements**
	- `assign out1 = a & b | c ^ d` == `always @(*) out2 = a & b | c ^ d`
	- the syntax for code inside a procedural block is different from code that is outside
- Clock always blocks
	- it create a blob of combinational logic just like combinational always blocks, but also **creates a set of flip-flops at the output of the blob of combinaional logic**
		- and the outputs are visible only immediately after the next (posedge clk).
- 敏感事件列表
	- `*`：自动包含always语句块中语句或条件表达式右边出现的所有信号
> [!note] wire vs reg
> The left-hand-side of an assign statement must be a **wire**, while the left-hand-side of a procedural assignment must be a variable(reg).
> These types have nothing to do with what hardware is synthesized, and is just syntax left over from Verilog's use as a hardware simulation language.

> [!note] blocking vs Non-Blocking Assignment
> - **Continuous** assignments (assign x = y;). Can only be used when **not** inside a procedure ("always block").
> - Procedural **blocking** assignment: (x = y;). Can only be used inside a procedure.
> - Procedural **non-blocking** assignment: (x <= y;). Can only be used inside a procedure.

> [!note] Verilog语句的执行
> 在Verilog中,各语句是并发执行的,模块中所有的assign语句、always语句块和实例化语句，其执行顺序不分先后。
> 而if语句是顺序执行的语句，需要逐个判断条件
> Verilog语法规定，顺序执行的语句必须包含在always块中，always块中的语句按照他们在代码中出现的顺序执行。

> [!note] Latch
> 如果if语句在使用时没有else语句与其配对则会发生这样的情况：编译器判断if后面的条件表达式是否满足，如果满足则执行其后的语句，那如果条件表达式不满足呢？这时，编译器就会自动产生一个寄存器来寄存当前的值，在条件不满足时保输出的过去值。这样就会产生用户没有设计的多余的寄存器出来。因此建议读者在使用if语句的时候要加上else语句与其配对。防止产生多余的寄存器。