# LL(1)分析法
- 构造不带回溯的自上而下分析算法
	- 消除文法的左递归性
	- 克服回溯
- #编译原理重点 LL(1)
	- L：表示从左向右扫描输入串
	- L：最左推导
	- 1：向前看1步
## 左递归的消除
- 直接消除在产生式中的左递归：
	- 如非终结符P的规则为：$P\rightarrow P\alpha | \beta$
		- 其中$\beta$不以$P$为开头
	- #编译原理重点 我们可以把$P$的规则等价的改写为如下的非直接左递归形式：
		- $P\rightarrow\beta P^\prime$
		- $P^\prime \rightarrow \alpha P^\prime | \varepsilon$
> 将左递归变为了**右递归**
- #编译原理重点 一般而言，假定$P$关于的全部产生式是：$$P\rightarrow P\alpha_1 | P\alpha_2 | \cdots|P\alpha_m|\beta_1|\beta_2|\cdots|\beta_n$$
	- 消除$P$的直接左递归性即将规则改写为：$$\begin{array}\\P\rightarrow \beta_1P^\prime|\beta_2P^\prime|\cdots|\beta_nP^\prime\\P^\prime\rightarrow\alpha_1P^\prime|\alpha_2P^\prime|\cdots|\alpha_mP^\prime|\varepsilon\end{array}$$
- 有的文法可能没有直接左递归，但也可能是左递归的：
- 一个文法消除左递归的条件：
	- 不含以$\varepsilon$为右部的产生式
	- 不含回路：
- 消除左递归的算法：
	- 将文法$G$的所有非终结符按照某一种顺序排列，并逐个执行：
	- ![image.png](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230513205246.png)
	- 化简所得到的文法，去除从开始符号出发永远无法到达的非终结符的产生规则
- 算法的注意事项：
	- 适用于：消除了$P\rightarrow P$产生式和不以$\varepsilon$为右部的产生式文法
	- 第二步中所作的工作：
		- 若为直接左递归，则消除直接左递归
		- 若右部的最左符号是非终结符且**序号大于左部**的非终结符，则不进行替换
		- 若**序号小于左部**的非终结符，则将序号小的非终结符用其右部的串进行替换，然后消除新的直接左递归
		- 这样，每次替换的非终结符均为前面已经处理过的非终结符

## 消除回溯，提取左公因子
- 产生回溯的原因：推导时，若产生式存在多个候选式，选择哪个进行推导存在不确定性
- #编译原理重点 提取左公因子：
![image.png](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230614234746.png)

## LL(1)分析条件
- #编译原理重点 如果一个文法是LL(1)文法，则满足：
	- 文法不含左递归
	- 对于文法中每个非终结符A的各个产生是的候选首符集两两不相交
		- 若$A\rightarrow \alpha_1|\alpha_2|\cdots|\alpha_n$
		- 则$FIRST(\alpha_i)\cap FIRST(\alpha_j)=\varnothing$
	- 对于文法中的每个非终结符A，存在某个候选首符集包含$\varepsilon$，则$FIRST(\alpha_i)\cap FOLLOW(A)=\varnothing$

### #编译原理重点 FIRST
- $FIRST(\alpha)$：可以从$\alpha$推导得到的串的首符号的集合$$FIRST(\alpha)=\{a|a\stackrel{*}{\Rightarrow}a\cdots.a\in V_T\}$$
- 算法：
	- 如果$X$是一个终结符号，那么$FIRST(X)=X$
	- 如果$X$是一个非终结符号，且$X\rightarrow Y_1Y_2\cdots Y_k$
		- 如果对于某个$i$，$\alpha$在$FIRST(Y_i)$中，且$\varepsilon$在所有的$FIRST(Y_1)$、$FIRST(Y_2)$、$\cdots$、$FIRST(Y_{i -1 })$中，则将a添加到$FIRST(X)$中
	- 如果$X\rightarrow\varepsilon$是一个产生式，则将$\varepsilon$添加到$FIRST(X)$中
- 主要看产生式左边
- 自下而上求

### #编译原理重点 FOLLOW
- $FOLLOW(A)$：可能在某些句型中紧跟在A右边的终结符号集合$$FOLLOW(A)=\{a|S\stackrel{*}{\Rightarrow}\cdots Aa\cdots,a\in V_T\}$$
- 算法：
	- 将$\$$添加到$FOLLOW(S)$中，其中$S$是开始符号，$\$$是右端的结束标记
	- 如果存在产生式$A\rightarrow\alpha B\beta$，则$FIRST(\beta)$中除了$\varepsilon$之外的所有符号都在$FOLLOW(B)$中
	- 如果存在$A\rightarrow \alpha B$或存在产生式$A\rightarrow\alpha B\beta$且$FIRST(\beta)$中包含了$\varepsilon$（**可以理解为同一种情况$A\rightarrow \alpha B$**），则将$FOLLOW(A)$中的所有符号都放在$FOLLOW(B)$中
- 只看产生式右边
- 自上而下求
![image.png](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230513213945.png)

