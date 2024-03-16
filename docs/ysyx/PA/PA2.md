# PA2
## RTFM
> [!note] riscv32 如何处理 32 位的立即数?
> 可以使用两个指令: `addi`, `lui`
> - `lui`: load upper immediate,加载立即数的高位 (20 位)
> 首先利用 lui 加载立即数的高 20 位, 在使用 `addi` 指令, 将立即数的低 12 位加到目标立即数 (寄存器)上
> ```risc-v
> lui x3, 0x12345
> addi x3, x3, 0x678
> ```

- 一条指令在 nemu 中的执行过程:
	- 取指: 将 pc 存储在 `Decode *s` 结构体中, 传入 `decode_exec` 进行译码工作
	- 译码: 利用 `INSTPAT` 宏和模式识别来进行译码工作, 首先使用 `pattern_decode` 识别当前的指令, 然后从指令中提取出操作码, 再使用对应 isa 的 `decode_operand` 函数提取出对应指令所需要的操作数 (统一类别指令的操作数提取方法是固定的, 所以针对不同的类型定制了不同的提取方法, 相比 x86方便不少)
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

## RTFSC
### 打字游戏
- 主函数框架: 
```c
int main(){
	初始化设备;
	while(1){
		更新游戏逻辑;
		读取键盘输入;
		渲染画面;
	}
}
```
- 相关的数据结构
	- 字符结构体: 
		- `ch`: 字符
		- `x, y`: 位置
		- `v`: 速度, 每一帧下落的距离
		- `t`: 
	- `texture`: 26 个字母对应的材质, 包括了三种颜色, 为白绿红三色
	- `blank`: 空白区域, 紫色
- 键盘按键到字符的 lut: 
```
char lut[256] = {
  [AM_KEY_A] = 'A', [AM_KEY_B] = 'B', [AM_KEY_C] = 'C', [AM_KEY_D] = 'D',
  [AM_KEY_E] = 'E', [AM_KEY_F] = 'F', [AM_KEY_G] = 'G', [AM_KEY_H] = 'H',
  [AM_KEY_I] = 'I', [AM_KEY_J] = 'J', [AM_KEY_K] = 'K', [AM_KEY_L] = 'L',
  [AM_KEY_M] = 'M', [AM_KEY_N] = 'N', [AM_KEY_O] = 'O', [AM_KEY_P] = 'P',
  [AM_KEY_Q] = 'Q', [AM_KEY_R] = 'R', [AM_KEY_S] = 'S', [AM_KEY_T] = 'T',
  [AM_KEY_U] = 'U', [AM_KEY_V] = 'V', [AM_KEY_W] = 'W', [AM_KEY_X] = 'X',
  [AM_KEY_Y] = 'Y', [AM_KEY_Z] = 'Z',
};
```
- 函数: 
	- `video_init`: 初始化每个字母的材质和空白格, 并且将画面铺满空白
	- `check_hit`: 根据键盘的输入找到屏幕上匹配的字符, 如果没有找到, `wrong++`, 否则, 找出 `y` 坐标轴最低的字符 (屏幕上可能同时出现多个相同字母), 且 `hit ++`, 且修改字符的速度, 使其向上
- 运行过程: 
	- 通过 `nemu` 运行编译链接过后的打字游戏
	- 在打字游戏中调用 `ioe_init` 对 `am` 中的输入输出扩展进行初始化, 
	- 画面输出部分: 
		- 在打字游戏的程序中调用 `io_write`, 调用 `__am_gpu_fbdraw` 修改 `nemu` 中的 `vmem` 写入像素数据, 并且置 `sync` 为高, 然后在 `nemu` 的设备更新时候, 会检查到 `sync` 为高, 使用 sdl 库更新输出的画面
	- 按键: 键盘的事件使用了 sdl 来实现, 在 `update_device` 时候, 会监测是否有按下键盘的事件发生, 若发生了键盘按下的事件, 则会将按下的键通过 `send_key` 将其放入一个队列中, 当应用程序通过 `io_read` 读取键盘输入时候, 就用调用 `am` 中的 `__am_input_keybrd` 函数, 在这个函数中, 首先读取 `KBD_ADDR` 寄存器, 对这个寄存器的访问会触发回调函数的执行, 在对应的回调函数中, 会将键盘队列中的队头出队, 存储在 `i8042_data_port_base[0]` 位置上, 此时程序就可以读取到键盘被按下的键了, 接下来返回到应用程序就可以了, 剩余的处理交给应用程序进行处理.
> [!note] SDL 事件
> 在 SDL 中, 会维护一个事件的队列, 当我们调用 `SDL_PollEvent` 时候会取出这个队列中队头的事件, 这样我们就可以针对不同的事件对程序进行处理了, 详情请见 `man SDL_Event`



## 必做题
### 程序是个状态机理解 YEMU 的执行过程
- 状态机与 YEMU: 状态机描述了 YEMU 的执行方式, YEMU 则按照状态机的描述实现

### RTFSC 请整理一条指令在 NEMU 中的执行过程
取指 -> 译码 -> 执行 (写回)
与 isa 相关的定义在 `isa_def.h` 文件中, 包括了 `riscv32_ISADecodeInfo` 和 `riscv32_CPU_state`
执行一条指令的逻辑在对应的 `isa_exec_once` 中:
- 取指: 根据 `pc` 的值从内存中取出指令 (对于 riscv 来说可以忽略参数 `len`, 因为每一条指令都是 4 字节的 (暂不考虑 `rvc`), 每次都是取出 4 个字节的指令), 取指后, 先默认将 `pc += 4` , 并且将取到的指令返回, 并存入到 `s->isa.inst.val` 中, 进行下一步的译码
- 译码: 译码和执行的逻辑一一对应, 因此将其写在一个函数中, 一起处理, 具体实现在 `decode_exec` 中, 先来介绍几个宏和函数: 
	- `INSTPAT_START`: 生成译码开始标号, 这里用到了 gcc 的特性: [[GCC扩展-标签变量(Labels as Values)|标签变量]]
	- `INSTPAT_END`: 展开成译码结束标号, 用于生成标签变量以进行跳转操作, 译码出指令时候, 可以直接通过跳转结束译码
	- `INSTPAT_INST`: 用于从 `Decode *s` 中取出指令
	- `INSTPAT_MATCH`: 调用 `decode_operand` 和 `inline pattern_decode` 对指令进行译码: 
		- `decode_operand`: 根据指令的类型, 从中提取出所需要的字段, 对于寄存器字段, 直接从寄存器中取出对应的值
		- `pattern_decode`: 是一段模式识别的代码, 利用这段代码, 可以获得该指令对应的 `key` 和 `mask` 和 `shift`, 用于后续的比较
	- `INSTPAT`: 在这个宏展开中, 会首先进行 `pattern_decode`, 也就是会先分析模式识别串, 以获得 `key`, `mask` 和 `shift`, 如果模式匹配符合的话, 再使用 `decode_operand` 提取出字段, 并且接下来执行相应的操作.
> [!todo] 问题
> 这样的译码方式的性能似乎有点低, 每次都要重新提取模式识别串以获得 `key`, `mask` 和 `shift` 变量, 但如果有编译器的优化, 这些都是常量, 应该是可以在编译期计算出来的

### 程序如何运行理解打字小游戏如何运行
[[PA2#打字游戏]]

### 编译与链接 1
- 删除 `static`, 剩余 `inline`: 使用 ` inline ` 关键字声明的函数, 实际上并不会被当做一个真正的函数, 而是会被类似的处理为宏, 在编译期展开, 插入到调用"函数"的地方去, 因此, 这样的函数是不会出现在符号表中的. 以下的图片是仅删去了 ` static ` 时, ` inst.o ` 和 ` postcall.o ` 中的符号表, 由于其实际上都没有定义 ` inst_fetch ` 符号, 自然就不会出现重定义的问题: ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240304231337.png)
- 删除 `inline`, 剩余 `static`: 不会报错, 使用 `static` 关键字声明的函数, 相当于 `private`, 只能在当前文件中调用, 属于私有, 即局部的, 不参与符号解析, 不会出现符号重定义问题.
- 删除 `static inline`, 剩余 `nothing`: 由于每个 c 文件都是独立编译的, 所以会产生重复定义的问题 (在独立编译的情况下, 用于避免重定义的 ` #ifndef ` 宏失效了), 在链接时候就会出现重定义的问题 ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240304233217.png) 可以看到, 在最后的链接时候出现了重定义的问题, 我们再来查看 `inst.o` 和 `hostcall.o` 文件可以发现, 在这两个文件的符号表中都定义了 ` inst_fetch ` 符号 ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240304233423.png)

### 编译与链接 2
当我在 `common.h` 和 `debug.h` 中声明 `volatile static int dummy` 但不进行初始化时候, 编译不会出现问题, 并不会出现 `dummy` 变量的实体, 因为声明但不初始化的静态全局变量属于弱符号, 会被添加到一个称为 `COMMON` 的伪节中, 在链接时候, 链接器会从这些弱符号中随机选择一个; 而当我们将 `dummy` 进行初始化时候, 就变为了强符号, 位于 `.bss` 节中, 链接器在链接的时候会检查 `.bss` 节中的符号是否有重定义