# `const` 限定符


## 使用 `const` 修饰普通类型的变量
```c++
const int a = 2;
```
在上面的代码中, `int` 类型的 `a` 被修饰为了 `const`, 因此, `a` 的值是无法被改变的.
即使通过其他方法强制改变 `a` 的值, 编译器依然会认为 `a` 的值是 `2`, 虽然实际上 `a` 所在地址上的值已经被改变.
见如下的代码:
```c++
#include <iostream>
#include <assert.h>
using namespace std;

int main(){
	const int a = 7;
	int *b = (int *)a;
	*b = 8;
	cout << a << " " << *b << endl;
	assert(&a == b);
	return 0;
}

// ---------- output ----------
> g++ const-test.cpp -o const-test
> const-test
7 8
```
可以看到输出的 `a` 为 ` 7 ` , ` b ` 为 ` 8 `, 并且没有触发 ` assert `, 说明 ` a ` 所在的地址和 ` b ` 所指向的地址是一致的.
如果实在想要修改 `a` 的值, 可以再使用 `volatile` 关键字修饰: `volatile const a = 7`, 此时的输出结果就变成了 `8 8`, 因为被 `volatile` 修饰的变量, 在每一次使用前, 都会从内存中重新读取.

## 使用 `const` 修饰引用
引用的实质是别名, 并不会在内存中开辟新的空间, 使用引用, 实际上就是在使用原对象. 
即使是对于普通的引用, 在声明后, 也无法修改其引用对象.
```c++
const int a = 7;
const int &b = a;
```

## 使用 `const` 修饰指针变量
使用 `const` 修饰指针变量存在三种情况: 
1. `const` 修饰指针所指向的内容: `(const int)* (p)`
2. `const` 所修饰指针的值: `(int)* const p` -> 可以理解为这是一种特殊的 `const` 用法, 所
3. `const` 修饰指针和指针指向的内容: `const int* const p`
可以理解为, 把 `*` 放在 `const` 前, 表明指针是一个常量, 总之可以理解为: **左定值, 右定向**