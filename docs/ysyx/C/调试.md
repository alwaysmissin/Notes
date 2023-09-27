# 调试
- 调试的建议：
	- 总是使用`-Wall`和`-Werror`
	- 在代码中尽可能多地插入`assert()`
	- 调试时候优先启用sanitizer
	- `assert()`无法捕捉到error时, 通过`printf()`输出可疑的变量, 期望能观测到error
	- `printf()`不易观测error时, 通过GDB理解程序的精确行为