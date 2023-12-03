# C语言拾遗
## IDE的一个键做了什么
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230514133757.png)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230514133805.png)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230514133824.png)

## `#include`指令
- 什么是`#include`：
	- `#include`是告诉预编译器将指定的头文件内容粘贴到当前`include`所在的位置->即进行文本替换
	- 这也意味着`#include`可以出现在代码的任意地方
- `""`与`<>`的区别：
	- `<>`：在预定义的缺省路径下寻找文件
	- `""`：先在当前目录下寻找文件，再到预定义的缺省路径下寻找文件

## 宏定义与宏展开
```C
#include <stdio.h>  
int main() {  
#if aa == bb  
	printf("Yes\n");  
#else  
	printf("No\n");  
#endif  
}
```
- 宏展开：通过复制/粘贴来改变代码的形态
	- `#include`：粘贴文件
	- `aa, bb`：粘贴符号
- 搞垮一个OJ：
```C
#define A "aaaaaaaaaa"  
#define TEN(A) A A A A A A A A A A  
#define B TEN(A)  
#define C TEN(B)  
#define D TEN(C)  
#define E TEN(D)  
#define F TEN(E)  
  
#define G TEN(F)  
int main() { puts(G);}
```
- 躲过OJ的关键字过滤：
- Pros：
	- 提供灵活的用法
	- 接近自然语言的写法
- Cons：
	- 破坏可读性、程序分析