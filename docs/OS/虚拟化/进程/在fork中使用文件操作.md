# 在fork中使用文件操作
```c
// fileOperationInFork.c
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

char str[11];

int main() {
  str[10] = 0;
  int fd = open("test.txt", O_RDWR);
  if (fork() == 0) {
    ssize_t cnt = read(fd, str, 10);
    printf("Child process: %s\n", (char *)str);
  } else {
    ssize_t cnt = read(fd, str, 10);
    printf("Parent process: %s\n", (char *)str);
  }
  return 0;
}
```

```test.txt
abcdefghigklmnopqrstuvwxyz
```

```shell
$ gcc -o fileOperationInFork fileOperationInFork.c
$ fileOperationInFork
# one possible output
Parent process: abcdefghig
Child process: klmnopqrst
# another one
Parent process: klmnopqrst
Child process: abcdefghig
```
- 在进行fork时候, 子进程获得了与父进程完全相同的拷贝, 也包括了打开的文件等PCB中的内容
但是, 无论如何, 都无法使父进程和子进程输出完全一样的字符串, 这里似乎与前面所说的完全相同的拷贝有所冲突, 但实际上, 正是"**拷贝**"的实现导致了这个结果
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20231023193639.png)
每个进程在运行的过程中都会维护一张已经打开文件的**文件描述符(File Descriptor, fd)表**

> [!note] 文件描述符
> 文件描述符是操作系统提供的对于某一文件引用的抽象
> 比如, 文件描述符会使用偏移量记录当前进程读取到某个文件的某个位置.
> 之所以使用文件描述符而非直接指向文件系统中的某个文件, 是因为文件结构可能根据不同的文件系统而变化, 提供单一抽象有利于操作系统统一管理

在`fork`的过程中, 由于fd表示PCB的一部分, 则子进程会获得与父进程完全一样的fd表, 因此都会**指向相同的文件抽象**, 与父进程共用一个偏移量

又因为, linux在使用`read`操作时候会对文件抽象加**锁**, 因此父子进程不可能读到完全一样的字符串