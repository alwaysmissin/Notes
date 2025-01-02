# SDRAM
`16Meg*16`
![Functional Block Diagram](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20241119083540.png)
## 功能描述
读写都是通过突发的方式进行的, 访问是从指定的位置开始, 并访问指定的长度
**每一次的访问都是以 `ACTIVE` 命令后面跟着一个 `READ` 或 `WRITE` 命令**, 首先通过 `ACTIVE` 命令激活想要访问的 bank 中的某一行(选择行), 再通过 `READ` 或 `WRITE` 命令的 `A0-A8` 来设定突发传输开始的位置
再开始访问之前, 必须对 SDRAM 进行初始化

### 初始化
1. 在上电后, 需要等待 100us 来让电路稳定
2. 在电路稳定过后, 需要发出 `PRECHARGE` 命令, 来进行预充电, 从而让所有 `bank` 都处于闲置状态
3. 进行两次自动刷新
4. 写入 `mode` 寄存器, 设定 SDRAM 的工作模式

### `mode` 寄存器
`mode` 寄存器的设定是通过 `LOAD MODE REGISTER` 命令来实现的, `mode` 寄存器中的信息会一直保存到下一次进行 `LOAD MODE REGISTERE` 或下电
`mode` 寄存器可以设定突发长度, 突发类型, CAS 延迟, 操作模式和写突发模式
`mode` 寄存器的设定必须在所有 `bank` 均处于闲置状态下进行, 并且在进行后续操作前, 需要等待一段时间
![Mode Register Definition](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20241119085854.png)

### 突发长度
1、2、4 或 8 个位置的突发长度可用于顺序和交错突发类型，而整页突发可用于顺序类型。整页突发需要通过 `BURST TERMINATE` 指令来结束突发传输

### 突发类型
- **顺序突发（Sequential）**：数据按照物理地址的连续顺序访问。
- **交错突发（Interleaved）**：数据访问按照一定的间隔模式交错进行。
![Burst Definition](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20241119091128.png)

### CAS 延迟
CAS 延迟指的是发出 `READ` 命令后, 到读出第一个数据的延迟, 可以被设定为 2 或 3 个时钟周期
![CAS Latency](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20241119091534.png)

### 操作模式

### 写突发模式
当写突发模式位设定为 `0` 时候, 突发长度为设定的突发长度, 写突发模式位设定为 `1` 时候, 突发长度为 1 (也就是不进行突发)

### 指令
![Truth Table 1 – Commands and DQM Operation](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20241119092048.png)
1. 激活命令 (ACTIVE)
	- **功能**：激活一个指定的行，以便进行读取或写入操作。
	- **用途**：在任何读或写操作之前，必须先通过激活命令选择内存中的一行。
2. 读取命令 (READ)
	- **功能**：从激活的行中读取数据。
	- **特性**：可以指定是否使用自动预充电结束这次访问，即在读取操作完成后自动关闭激活的行。
3. 写入命令 (WRITE)
	- **功能**：向激活的行写入数据。
	- **特性**：与读取命令类似，写入命令也可以指定是否在操作结束时自动预充电。
4. 预充电命令 (PRECHARGE)
	- **功能**：关闭当前激活的行，以便执行其他操作或激活另一行。
	- **特性**：可以单独预充电一个银行或所有银行。
5. 自动刷新命令 (AUTO REFRESH)
	- **功能**：周期性地刷新内存，保持数据的完整性。
	- **说明**：必须定期执行自动刷新以保持存储器中的信息不丢失。
6. 自刷新命令 (SELF REFRESH)
	- **功能**：使SDRAM进入低功耗模式，在此模式下SDRAM自行管理刷新，不需要外部时钟。
	- **用途**：在系统电源节能模式下保持数据完整性，常用于便携设备中。
7. 载入模式寄存器命令 (LOAD MODE REGISTER)
	- **功能**：设置SDRAM的操作参数，如CAS延迟、突发长度和其他特定的模式设置。
	- **用途**：配置或修改SDRAM的性能参数。
8. 无操作命令 (NOP)
	- **功能**：让SDRAM在当前时钟周期内不执行任何操作。
	- **用途**：在不需要内存操作或在等待其他操作完成时使用。
9. 命令禁止 (COMMAND INHIBIT)
	- **功能**：防止任何新命令被执行，用于稳定或控制内存状态。
	- **说明**：此命令不常用，主要用于测试或特定的初始化过程中。
10. 突发终止命令 (BURST TERMINATE)
	- **功能**：提前终止一次突发操作。
	- **用途**：用于控制数据传输长度，尤其是在全页突发模式中。
11. 写使能/输出使能 (WRITE ENABLE / OUTPUT ENABLE)
	- **功能**：确保在写操作中使能数据输入或在读操作中使能数据输出。

## 读 SDRAM
### 一些时序图
![Consecutive READ Bursts](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20241119093119.png)
![Random Read Accesses](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20241119093206.png)

