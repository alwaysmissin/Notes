# PA2
## RTFM
> [!note] riscv32如何处理32位的立即数?
> 可以使用两个指令:`addi`,`lui`
> - `lui`:load upper immediate,加载立即数的高位(20位)
> 首先利用lui加载立即数的高20位,在使用`addi`指令,将立即数的低12位加到目标立即数(寄存器)上
> ```risc-v
> lui x3, 0x12345
> addi x3, x3, 0x678
> ```

- 一条指令在nemu中的执行过程:
	- 取指: 将pc存储在`Decode *s`结构体中, 传入`decode_exec`进行译码工作
	- 译码: 利用`INSTPAT`宏和模式识别来进行译码工作, 首先使用`pattern_decode`识别当前的指令, 然后从指令中提取出操作码, 再使用对应isa的`decode_operand`函数提取出对应指令所需要的操作数(统一类别指令的操作数提取方法是固定的, 所以针对不同的类型定制了不同的提取方法, 相比x86方便不少)
	- 执行: 通过 C 代码进行执行

## 基础设施
### elf 文件

### 符号表
[[链接#符号和符号表]]

### 符号解析
[[链接#符号解析]]

![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240128194324.png)

## 与 cpu-tests 相关的编译执行过程解析
> 以 cpu-tests 中的 `add-longlong` 测试点为例

在 `ysyx-workbench/am-kernels/tests/cpu-tests` 目录下执行命令 `make ARCH=riscv32-nemu ALL=add-longlong run`, 其执行的内容为: 
```
/bin/echo -e "NAME = add-longlong\nSRCS = tests/add-longlong.c\ninclude ${AM_HOME}/Makefile" > Makefile.add-longlong
if make -s -f Makefile.add-longlong ARCH=riscv32-nemu run; then \
        printf "[%14s] \033[1;32mPASS!\033[0m\n" add-longlong >> .result; \
else \
        printf "[%14s] \033[1;31mFAIL!\033[0m\n" add-longlong >> .result; \
fi
rm -f Makefile.add-longlong
echo "" add-longlong
cat .result
rm .result
```
首先是利用简单的管道方式生成一个新的 Makefile 文件, 其中的内容为: 
```Makefile
NAME = add-longlong
SRCS = tests/add-longlong.c
include /home/jiunian/Program/ysyx-workbench/abstract-machine/Makefile
```
这里定义了测试点的名称和测试点的 c 源程序, 并且将 `am` 目录下的 Makefile 包含进来
生成该 Makefile 后, 即通过执行命令 `make -s -f Makefile.add-longlong ARCH=riscv32-nemu run` 来进行编译操作, 其中: 
- `-s`: 静默操作
- `-f`: 指定目标 Makefile
若该命令执行成功, 则打印测试成功
接下来看看, 这个命令具体做了什么
- 相关的 Makefile:  在 `abstract-machine` 中的 `Makefile` 中, `-include $(AM_HOME)/scripts/$(ARCH).mk` 将 `riscv32-nemu.mk` 包含进来, 而在 `riscv32-nemu.mk` 中又包含了 `isa/riscv32.mk` 和 `platform/nemu.mk` 这两个 Makefile
- 以 `nemu.mk` 中的 `run` 为目标, 而 `run` 目标依赖于 `image`, `image` 依赖于 `$(IMG).elf` 和 `image-dep`,  `image-dep` 依赖于 `$(OBJS) am $(LIBS)`, 依赖链如下: ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240206153052.png)
当我们执行了 `make -s -f Makefile.add-longlong ARCH=riscv32-nemu run` 命令后, `SRCS = tests/add-longlong.c`, 可以看到仅有一个 `add-longlong.c` 文件, 根据以上的依赖关系, 我们在执行目标 `run` 时候, 需要先获得 `$(OBJS)`, `am` 和 `$(LIBS)` 这三个依赖内容: 
- `$(OBJS)`: object file, 编译获得, 根据以下规则编译获得: ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240206153418.png)
- `am`: abstract machine
- `$(LIBS)`: 链接库, 根据以下一连串规则获得链接库: ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240206153808.png)
	- 其中: `$(LIBS): %:` 中所执行的目标 `archive` 依赖于 `$(ARCHIVE)`

根据依赖的顺序, 会先将 `$(OBJS)` 编译获得, 此时仅有一个源文件, 则编译获得 `add-longlong.o`. 
接着执行 `$(LIBS): %:` 中的命令 `@$(MAKE) -s -C $(AM_HOME)/$* archive`, 其中, 参数 `-C` 会在执行之前 `cd` 到目标目录, 也就是执行目标目录下的 `Makefile`. 执行该命令后, 会转移到 `$(AM_HOME)/$*` 目录下执行 `archive` 目标, 在对应的 Makfile 中, 会将 `SRCS` 修改为其源文件, 而不是 `add-longlong` 了, 执行 `archive` 目标后, 就会将其归档为库文件, 供后续的链接使用.
以上工作是依赖关系 `image-dep -> $(OBJS), am, $(LIBS)` 所完成的工作.
归档文件创建完成后, 开始使用链接器生成 `elf` 文件, 即 `$(IMAGE).elf` 文件,  该工作是由依赖关系 `$(IMAGE).elf -> $(OBJS), am, $(LIBS)` 所完成的工作.
现在就具备了生成 `image` 的条件了, 执行 `riscv32-nemu.mk` Makefile 中 `image -> $(IMAGE).elf` 依赖关系所指定的命令了, 执行命令: `riscv64-linux-gnu-objcopy -S --set-section-flags .bss=alloc,contents -O binary /home/jiunian/Program/ysyx-workbench/am-kernels/tests/cpu-tests/build/add-longlong-riscv32-nemu.elf /home/jiunian/Program/ysyx-workbench/am-kernels/tests/cpu-tests/build/add-longlong-riscv32-nemu.bin`. 该命令提取出 elf 文件中的代码段和全局变量保存到 `bin` 文件中, 供 `nemu` 读取.
接下来的操作就是在 `nemu` 目录下执行 `make -C /home/jiunian/Program/ysyx-workbench/nemu ISA=riscv32 run ARGS="-l /home/jiunian/Program/ysyx-workbench/am-kernels/tests/cpu-tests/build/nemu-log.txt -b" IMG=/home/jiunian/Program/ysyx-workbench/am-kernels/tests/cpu-tests/build/add-longlong-riscv32-nemu.bin` 来对 `nemu` 进行编译

## 输入输出
- 理解 `mainargs`: 
	- `$ISA-nemu`: 通过 `-DMAINARGS=""` 向 `main` 传参 ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240226101343.png) ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240226101425.png)
	- `native`: 使用 `getenv` 在程序中获得环境变量 ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240226101311.png)
