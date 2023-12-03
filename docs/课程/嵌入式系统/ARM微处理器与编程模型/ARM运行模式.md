# ARM运行模式
- 7种运行模式![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230423091203.png)
- 用户模式与特权模式：
	- 除用户模式外，其余模式均称为特权模式![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518102413.png)

- 用户模式与特权模式比较：
	- 特权模式：
		- 程序可以访问**所有的系统资源**
		- 可以任意切换处理器模式
	- 用户模式：
		- 大多数应用程序都运行在这个模式下
		- 无法访问受保护的系统资源
		- 无法直接切换到其他的特权模式
			- 需要通过异常实现模式切换
- 异常模式：除用户和系统模式外，其余均为异常模式![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230518102453.png)

- 系统模式：
	- OS在该模式下可以访问用户模式的寄存器
	- 特权任务可以**使用该模式访问一些受控的资源**
- 用户模式与系统模式：
	- **使用完全相同的寄存器组**

- 模式的切换
	- 运行模式可以直接或间接的通过程序切换进入
	- **根据不同的异常，处理器进入不同的对应的模式**![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230423091905.png)

