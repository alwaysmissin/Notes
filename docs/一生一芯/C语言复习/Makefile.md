# Makefiles
## 基本规则
> [!note] 依赖图
> ![image.png](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230722083150.png)
> 任何的文件被修改了，文件将会被重新编译
> make会自动选择那些受影响的源文件重新编译，不受影响的源文件则不需要重新编译
- 需要更新的情况：
	- 目标没有生成
	- 某个条件需要更新
	- 某个条件的修改时间比目标晚
- 在一条规则被执行之前，规则的条件可能处于一下三种状态之一：
	- 需要更新：能够找到以该条件作为目标的规则，并且该规则中的目标需要更新
	- 不需要更新：能够找到以该规则为目标的规则，但是该规则中目标不需要更新；或者不能找到以该条件为目标的规则，并且该条件已经生成
	- 错误：不能找到以该条件为目标的规则，并且该条件没有生成
- 执行规则A的步骤：
	1. 检查它的每个条件P
	2. 再检查完A的每个条件过后，检查其目标T，如果属于一下情况之一，则执行其命令列表
		1. 文件T不存在
		2. 文件T存在，但是某个条件的修改时间比它晚
		3. 某个条件P已被更新

- 如果在命令行中指定一个目标，则更新这个目标
	- 如果不指定目标则更新Makefile中的第一条规则的目标
	- 第一条规则的目标则称为**缺省目标**
> [!note] 规则
> 只要执行了命令列表，则认为更新了目标，及时目标并没有产生文件
> 比如clean目标，并不依赖于任何条件，并且执行它的命令列表不会生成claen这个文件

> [!note] @与-字符
> - `@`：不显示命令本身而只显示其结果
> 	- `@echo "cleanning project"`：直接显示`cleanning project`
> - `-`：即使命令出错，make也会执行后续的命令
> 	- `-rm main *.o*`：即使报错，也会继续执行后续的指令
## 内置函数
[Functions (GNU make)](https://www.gnu.org/software/make/manual/html_node/Functions.html)
### 字符串替换
- `$(parsubst pattern, replacement, text)`：在于`pattern`匹配的`text`中查找空格分隔的单词，并将其替换为`replacement`

### foreach
- `$(foreach var, list, text)`：将一个单词列表转换为另一个列表
	- `var`被设置为list中每个单词
	- `text`是针对每一个单词的展开
```makefile
foo := who are you
bar := $(foreach wrd, $(foo), $(wrd)!)
```

### if
- if检查第一个参数是否为非空
	- `true`：运行第二个参数
	- `false`：运行第三个参数
 ```makefile
 foo := $(if this-is-not-empty,then!,else!) 
 empty := 
 bar := $(if $(empty),then!,else!) 
 all: 
	 @echo $(foo) 
	 @echo $(bar)
```

### 函数调用
### shell函数
## 其他规则
### 隐式规则
- 隐含规则的列表：
	- 编译C程序：`$(CC) -c $(CPPFLAGS) $(CFLAGS)`
	- 编译C++程序：`$(CXX) -c $(CPPFLAGS) $(CXXFLAGS)`
	- 连接单个目标文件：`$(CC) $(LDFLAGS) n.o $(LOADLIBES) $(LDLIBS)`
- 隐式规则使用的变量
	- `CC`：编译C程序的程序；默认为`cc`
	- `CXX`：编译C++程序的程序；默认为`gcc`
	- `CFLAGS`：提供给C编译器的额外标志
	- `CXXFLAGS`：提供给C++编译器的额外标志
	- `CPPFLAGS`：提供给C预处理器的额外标志
	- `LDFLAGS`：当编译器应该调用链接器时，提供的额外标志

### 静态模式规则
- 静态模式规则是在Makefile中减少编写量的另一种方式：
```makefile
targets... : target-pattern : prereq-patterns ..
	commands
```
- 本质：给定`target`与`target-pattern`匹配
```makefile
objects = foo.o bar.o all.o
all: $(objects)

# foo.o : foo.c
# bar.o : bar.c
# all.o : all.c
$(obejcts) : %.o : %.c

all.c :
	echo "int main() {return 0;}" > all.c

%.c :
	touch $@

clean:
	rm -f *.c *.o*
```

> [!bug] 痛苦的调试经历
> **在链接测试程序时，确保`liblcthw.a`静态库的链接命令在测试程序源文件`tests/list_tests.c`的后面**，例如：`cc -g -O2 -Wall -Wextra -Isrc -rdynamic -DNDEBUG tests/list_tests.c build/liblcthw.a -o tests/list_tests`
> 对Makefile的修改：
> ```
> - tests: CFLAGS += $(TARGET)
> - tests: $(TESTS)
> + tests: 
> + $(CC) $(CFLAGS) $(TEST_SRC) $(TARGET) -o $(TESTS)
> ```
> ——Learn C The Hard Hard Way ： ex32
