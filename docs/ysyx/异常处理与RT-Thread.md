# 异常处理与 RT-Thread
需要实现的
- [x] csr 寄存器: 只需要实例化需要用到的 CSR, 然后根据 CSR 地址对它们进行读写即可(使用 `case`)
	- [x] mstatus
	- [x] mcause
	- [x] mept
	- [x] mtvec
- [ ] csr 指令
	- [ ] ecall ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240428174459.png)
	- [ ] mret: 根据mepc寄存器恢复PC
	- [ ] csrrw ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240428174317.png)
	- [ ] csrrc ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240429144923.png)
	- [ ] csrrs ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo20240428174404.png)
