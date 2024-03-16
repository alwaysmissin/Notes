# GCC 扩展: 标签变量 (Labels as Values)
使用 gcc 编译器, 可以使用 `&&` 一元操作符获得一个指向标签的 `void *` 类型的值, 这个值是一个常数, 只要在这种类型的常量值有效的情况下, 就可以使用.
```
void *ptr;
/* ... */
ptr = &&foo;
```
在后续, 可以使用 `goto` 和 `ptr` 跳转到 `foo` 标签位置
```c
goto *ptr;
```
甚至, 可以使用这种方法构建一个跳转表: 
```c
static void *array[] = {&&foo, &&bar, &&hack};
goto *array[i];
```
但是要注意的是, 数组越界在 c 语言中是未定义行为, 如果出现了数组越界, 你很可能会跳转到一个奇怪的地方. 如果你对于 `switch` 了解的话, 就知道这个行为与 `switch` 的行为非常相似, 在对 `switch` 编译过后, 也会生成类似的汇编代码, 所以在能够使用 `switch` 的情况下, 就不要使用这种方式来实现跳转表.
不能使用该机制跳转到其他的函数中, 这会导致无法预料的事情发生. 避免这种情况的最佳方法是将标签地址存储在自动变量中, 并且不用将其用于传参.
## 参考
- [Labels as Values (Using the GNU Compiler Collection (GCC))](https://gcc.gnu.org/onlinedocs/gcc/Labels-as-Values.html)