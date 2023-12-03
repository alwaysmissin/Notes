# ARM微处理器工作状态
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518103124.png)
## ARM指令集与Thumb指令集
- ARM指令集：
	- 指令固定宽度32位，进行4字节对齐
	- 在有限的存储空间中，存放的指令少，代码密度低
- Thumb指令集
	- 为了减少代码量而提出
	- 仅支持一些通用功能，可理解为ARM指令压缩形式的子集
	- 必要时仍然需要ARM指令集支持
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518103449.png)

- 区别：![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518105950.png)

- 切换方法：
	- 当寄存器`Rm`的状态为`bit[0]=1`时，通过执行`BX Rm`指令，从ARM->Thumb
	- 当寄存器`Rm`的状态为`bit[0]=0`时，通过执行`BX Rm`指令，从Thumb->ARM
```arm32
// ARM->Thumb
		CODE32
		LDR R0, =Label + 1
		BX  R0
		CODE16
Label   MOV R1, #12

// Thumb -> ARM
		CODE16
		LDR R0, =Label
		BX  R0
		CODE32
Label   MOV R1, #10
```
> 由于在ARM中，每一条指令的长度都是4字节（ARM）或2字节（Thumb），并且由于对齐的存在，在执行跳转指令时，最后一位，即`bit[0]`均为`0`，则使用这一位作为标志位，进行转态切换，并且，这样的行为不会影响到跳转目标的位置。