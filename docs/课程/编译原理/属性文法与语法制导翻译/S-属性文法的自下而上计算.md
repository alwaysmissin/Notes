# S-属性文法的自下而上计算
> [!tip] S-属性文法
> ![[属性文法#^4e6ede]]

- 综合属性可以在分析输入符号串的**同时**由自下而上的分析器来计算
- 在分析器中，可以保存**与栈中文法符号有关的综合属性值**
	- 每当进行归约时，**新的属性值**则由栈中正在归约的**产生式右边符号的属性值来计算**
> [!hint] 
> 因此，在分析栈中，我们需要使用一个附加的域来存放综合属性值
> 假设语义规则$A.a := f(X.x, Y.y, Z.z)$是对应于产生式$A\rightarrow XYZ$：![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230604155638.png)

![S-属性文法的自下而上计算.gif](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2FS-%E5%B1%9E%E6%80%A7%E6%96%87%E6%B3%95%E7%9A%84%E8%87%AA%E4%B8%8B%E8%80%8C%E4%B8%8A%E8%AE%A1%E7%AE%97.gif)
