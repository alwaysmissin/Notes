# RISC-V 特权架构
## CSR 寄存器
### CSR 地址映射约定
RISC-V 使用 12bit 来编码 csr 字段, 用来表示最多 4096 个 CSR 寄存器
`csr[11:8]` are used to encode the read and write accessibility of the CSRs according to privilege level as shown in the table below

---
`csr[11:8]` 根据特权等级的不同编码了目标 CSR 的读写权限, 具体如下表所示
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240308105157.png)
- `csr[11:10]`: indicate the write and read accessibility
	- `00`, `01`, `10`: read/write
	- `11`: read only
- `csr[9:8]`: indicate the lowest privilege level that can access the CSR
---
- `csr[11:10]`: 指示读写权限
	- `00`, `01`, `10`: 读/写
	- `11`: 只读
- `csr[9:8]`: 表示能够访问该 CSR 寄存器的最低特权等级

> [!attention] 
> CSR 地址约定**使用 CSR 地址的高位来编码**默认访问权限. 这种方式**简化了硬件的错误检查且提供了更大的 CSR 空间**, 但是**对 CSRs 的地址空间映射带来了一些麻烦**.
- some exception: 
	- attemps to access a non-existent CSR -> illegal instruction exception
	- attemps to access a CSR without appropriate privilege level or to write a read-only register -> illegal instruction exception
---
- 一些异常: 
	- 尝试访问不存在的 CSR -> 非法指令异常
	- 访问没有权限的 CSR (只读或特权等级不够) -> 非法指令异常

### CSR Listing
以下是已经在 CSR 地址空间中分配的列表. 时钟, 计数器和浮点 CSRs 都是标准的非特权 CSRs, 其他的 CSR 寄存器都被用于特权指令.
> [!note] 并不是所有的寄存器都需要实现

![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240309224918.png)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240309224942.png)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240309224954.png)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240309225012.png)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240309225039.png)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240309225049.png)

### CSR Field Specifications
The following definitions and abbreviations are used in specifying the behavior of fields within the CSRs.

---
下面的定义和缩写用于指定 CSR 寄存器中的字段的行为

#### WPRI (Reserved Writes Preserve Values, Reads Ignore Values)
- some whole r/w fields **are reserved for future use**
- software should ignore the values read from these fields, and should preserve the values held in these fields when writing values to other fields of the same register
- for forward compatibility (兼容), implementations that do not furnish these fields must make them read-only zero
---
- 一些完整的读写字段是保留给未来使用的
- 软件需要忽略从这些字段读取到的值, 并且在写同一个寄存器的其他字段时候, 需要保留这些字段的值
- 为了将来的兼容性, 没有使用这些字段的实现必须让它们为只读的

#### WLRL (Write/Read Only Legal Values)
- WLRL:  
	- **specify behavior for only a subset of possible bit encodings, with other bit encodings reserved**
	- software **should not write anything illegal values** to such a field, and **should not assume a read will return a legal value unless the last write was of a legal value, or the register has not been written since another operation set the register to a legal value**
- implementations
	- **permitted but required to raise an illegal instruction exception if an instruction attemps to write a non-supported value to a WLRL field**
	- it can **return arbitrary bit patterns on the read of a WLRL field when the last write was of an illegal value**, but **the value returned shold deterministically depend on the illegal written value and the value of the field prior to the write**
---
- WLRL: 
	- 仅为部分的位编码指定行为, 其余的位编码保留
	- 软件不应该向这些字段写入任何非法的值, 并且只有在上一个写操作时合法的情况下, 才能认为读的时候会返回一个合法的值
- 实现: 
	- 允许一条指令尝试写入一个非法的值, 但是会引发非法指令异常
	- 当上一个写时非法的情况下, 他可以返回一个任意的比特序列作为值, 但是这个值必须取决于被非法写入的值和写入前字段的值

#### WARL (Write Any Values, Read Legal Values)
- WARL: 
	- only **defined for a subset of bit encodings**, but **allow any value to be written** while guaranteeing to **return a legal value whenever read**
	- assuming that writing the CSR has no other side effects, the range of supported values can be determined by attempting to write a desired setting then reading to see if the value was retained
- implementations
	- it will not raise an exception on writes of unsupported values to a WARL field
	- it can return any legal value on the read of a WARL field when the last write was of an illegal value, but the legal value returned should deterministically depend on the illegal written value and the architectural state of the **hart**
---
- WARL: 
	- 只定义了对应比特位编码的子集, 在确保能够在读该字段时候返回合法的值时候允许向其中写入任意的值
	- 假设写入的值没有其他副作用, 支持的值的范围可以通过尝试写入想要的设置然后读取并查看该值是否是保留的来确定
- 实现: 
	- 当向 WARL 字段写入不支持的值时候, 会引发异常
	- 当上一个写入的值是非法值时候, 它可以返回任意合法的值, 但是这个返回的值必须取决于被写入的非法值和硬件线程的体系状态
> [!note] hart
> The term hart was introduced to privide a term to represent an abstract execution resource as opposed to a software thread programming abstraction. The important distinction between a hardware thread (hart) and a software thread context is that the software running inside an execution environment is not responsible for causing progress of each of its harts; that is the responsibility of the outer execution environment. So the environment's harts operate like hardware threads from the perspective of the software inside the execution environment. An execution environment implementation might time-multiplex a set of guest harts onto fewer host harts provided by its own execution environment but must do so in a way that guest harts operate like independent hardware threads. In particular, if there are more guest harts than host harts then the execution environment must be able to preempt the guest harts and must not wait indefinitely for guest software on a guest hart to "yield" control of the guest hart. 
> [如何理解RISC-V中的hart? - 知乎](https://www.zhihu.com/question/562625643)
## Reference
- riscv-privileged-20211203