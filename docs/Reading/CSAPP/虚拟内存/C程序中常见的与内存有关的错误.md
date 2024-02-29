# C 程序中常见的与内存有关的错误
C 程序中, 与内存相关的错误经常在距错误源一段距离之后才表现出来: 将错误的数据写到错误额位置, 程序可能在最终失败之前运行了很久, 且使得程序终止的位置距离错误的位置已经很远了

## 间接引用坏指针
- 坏指针: 
	- 指向**空洞**
		- 在进程的虚拟地址空间中有较大的洞, **没有映射到任何有意义的数据**
		- 此时会出现**段错误**
	- 指向**只读**内存: 
		- 由于权限的问题, 会以保护异常中止这个程序
- 最坏的情况: 我们成功的将数据写入到野指针所指向的位置, 这通常会在相当长的一段时候后造成灾难性的, 令人疑惑的错误

## 读未初始化的内存
```c
int *matvec(int **A, int *x, int n){
	int i, j;

	int *y = (int *)malloc(n * sizeof(int));

	for (i = 0; i < n; i++){
		for(j = 0; j < n; j++){
			y[i] += A[i][j] * x[j];
		}
	}

	return y;
}
```
- 在上面这个例子中, 错误的认为分配在对内存中的 `y` 被初始化为 `0`, 导致程序出现了预期之外的结果
- 正确的实现方式: 显式的将 `y[i]` 设置为零, 或使用 `calloc`
> [!note] calloc
> The  `calloc ()`  function  allocates memory for an array of `nmemb` elements of `size` bytes each and returns a pointer to the allocated memory. ** The memory is set to zero.  ** If `nmemb` or `size` is `0`, then `calloc ()` returns either `NULL`, or a unique pointer value that can later be successfully passed to `free ()`.  If the multiplication of `nmemb` and `size` would  result  in integer  overflow,  then  calloc () returns an error.  By contrast, an integer overflow would not be detected in the following call to `malloc ()`, with the result that an incorrectly sized block of memory would be allocated: `malloc(nmemb * size)`

## 允许栈缓冲区溢出
- 如果一个程序不检查输入串的大小就写入栈中的目标缓冲区, 则这个程序可能会有缓冲区溢出错误
```c
void bufoverflow(){
	char buf[64];
	gets(buf);
	return;
}
```
- 在上面这个程序中, 会出现缓冲区溢出错误: `gets` 函数赋值一个任意长度的串到缓冲区
	- 应该使用 `fgets` 函数, 限制输入串的大小

## 假设指针和他们指向的对象是相同大小的
```c
int **makeArray1(int n, int m){
	int i;
	int **A = (int **)malloc(n * sizeof(int));

	for (i = 0; i < n; i ++){
		A[i] = (int *)malloc(m * sizeof(int));
	}
	return A;
}
```
- 程序的目的: 创建一个由 `n` 个指针组成的数组, 每个指针都指向一个包含 `m` 个 `int` 的数组. 而在第 3 行中, 将 `sizeof(int *)` 写成了 `sizeof(int)`, 导致代码实际上创建了一个 `int` 数组
	- 这一段程序在 `int` 与指针大小一致的机器上将会正常运行, 无法发现错误
	- 而若大小不一致, 则出现错误

## 错位错误
```c
int **makeArray2(int n, int m){
	int i;
	int **A = (int **)malloc(n * sizeof(int *));

	for (i = 0; i <= n; i ++){
		A[i] = (int *)malloc(m * sizeof(int));
	}
	return A;
}
```
- 注意第 5 行的循环错误

## 引用指针, 而不是其所指向的对象
```c
int *binheapDelete(int **binheap, int *size){
	int *packet = binheap[0];
	binheap[0] = binheap[*size - 1];
	*size--;
	heapify(binheap, *size, 0);
	return(packet);
}
```
- 在上面这段代码的第 4 行中, 由于一元运算符 `--` 和 `*` 的优先级相同, 会从右向左进行结合, 导致实际减少的是 `size` 指针的值, 而不是想要的 `size` 指针指向的值

## 误解指针运算
- 指针的算数操作是以它们指向的对象的大小为单位来进行的, 这个单位不一定是字节

## 引用不存在的变量
```c
int *stackref(){
	int val;
	return &val;
}
```
- 上面的函数返回一个指针, 指向栈中的一个局部变量. 即使这个内存地址合法, 但是在函数返回后, `val` 不再是一个合法的变量, 而是被释放掉
- 在后面的程序中调用其他函数时, 内存将重新分配其栈帧. 若在其他程序中使用了上面函数返回的指针, 则会带来错误

## 引用空闲堆块中的数据
- 与上面的错误类似, 引用了一个已经被释放的堆中的数据

## 引起内存泄漏
- 程序没有释放分配的内存就返回