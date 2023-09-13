# Valgrind
> [!note] Valgrind
> - 无论什么时候运行C程序并且使它工作，都应该使用`Valgrind`重新运行它来检查
> - 对于得到的每个错误，找到“源码：行数”提示的位置，然后修复它
> 	- 可以上网搜索错误信息，来弄清楚它的意思
> - 直到程序在`Vajjjjlgrind`中不出现任何错误信息
- 工具：
	- 内存检查：memcheck
	- cachegrind
	- callgrind
	- 竞争条件检查：helgrind
	- drd
	- massif
	- dhat
	- lackey
	- none
	- exp-bbv
> 参数--track-origins=yes，使用源代码的行数
## memcheck
- 检查内存安全
## helgrind
- 检测线程安全问题