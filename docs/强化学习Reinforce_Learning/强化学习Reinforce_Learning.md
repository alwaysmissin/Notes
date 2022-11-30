# 强化学习(Reinforce Learning)
## Offline planning/Online planning
### Offline planning
- 马尔可夫问题得解决就是一个offline planning的例子
	- informed：在解决马尔可夫问题时，**知道**状态转移函数和奖励函数
### Online planning
- 在强化学习中，主要解决的问题是Online planning
	- agent不知道状态转移函数和奖励函数
	- 必须通过探索、执行的过程获得这些信息
![](https://s2.loli.net/2022/07/29/QiEYCXjqRbGp7oU.png)
- 在Online planning过程中的每一步，agent在状态$s$下采取$a$行动转移到了后继状态$s^\prime$，并且获得了奖励$r$，将每一个$(s,a,s^\prime,r)$组合称为一个**样本(sample)**
- 一个从**开始状态不断转移到终止状态**的过程称为一个**episode**

- 强化学习的两个分类：
	- model-based learning
	- model-free learning

## Model-Based Learning
- 在基于模型的强化学习中，agent通过多次尝试，生成一个状态转移函数的估计->$\hat T(s,a,s^\prime)$，然后再利用[[MDP（马尔可夫决策过程）]]找到最优解
- eg：$\gamma=1, noise = 0.2$
1. 地图
![](https://s2.loli.net/2022/07/30/DGe21ixdu8UyqPR.png)
2. 探索：
![](https://s2.loli.net/2022/07/30/GKux2nmyg57S9qL.png)
3. 结果：
![](https://s2.loli.net/2022/07/30/S5sKb43RJcMxaCp.png)
![](https://s2.loli.net/2022/07/30/NIZ69i4anOq2vTj.png)
## Model-Free Learning
- 三种模型：
	- 被动强化学习(Passive Reinforcement Learning)：
		- 在被动强化学习的一个episode中，agent执行所给的策略，并且获得执行策略后的状态的价值<-这正是在T和R已知情况下，MDPs所做的事情
		1. 直接估计(Direct Evaluation)
		2. 时间差分学习(Tempora Difference Learning)
	- 主动强化学习(Active Reinforcement Learning)：
		- agent可以在学习时，使用接收到的反馈来更新策略，直到在足够多的探索后，最终决定最优策略
		1. Q-learning
### 直接评估(Direct Evaluation)
- 根据$\pi$执行
- 每经过一个状态，记下收益和到达的次数
- 求平均值
![](https://s2.loli.net/2022/07/30/iTSlPLFMyVK1UAH.png)
![](https://s2.loli.net/2022/07/30/54kLruYij3eTwzt.png)
![](https://s2.loli.net/2022/07/30/x4l2XdEMWTO1yDb.png)
- 优缺点：
	- 优点：
		- **易于理解**
		- 无需T，R
		- 仅使用样本中的数据，就能计算出正确的平均价值
	- 缺点：
		- **浪费了状态之间的关系**<-使用[[MDP（马尔可夫决策过程）#贝尔曼方程 Bellman Equations|Bellman方程]]，就可以将各个state联系起来->如何在不知道T、R的情况下使用Bellman更新？？->[[强化学习(Reinforce Learning)#时间差分学习 Temporal Difference Learning|TD Learning]]
		- 每一个状态必须独立学习
		- 花费**时间长**
### [[时序差分算法|时间差分学习(Temporal Difference Learning)]]
- 思路：
	- 对于每次$(s,a,s^\prime,r)$都更新一次$V(s)$
	- 可能的结果$s^\prime$将会更加频繁的提供更新
	- 如何用其他的方法求出每个状态的平均价值？？->Exponential Moving Average
- Exponential Moving Average
	- **让最近的sample更加重要**：
$$\bar x_n =\frac{x_n+(1-\alpha)x_{n-1}+(1-\alpha)^{2}x_{n-2}+……}{1+(1-\alpha)+(1-\alpha)^2+……}$$
- 每一次状态转移
	- sample of V(s)：$sample=R(s,\pi(s),s^\prime)+\gamma V^\pi(s^\prime)$
	- 对于$V^\pi(s)$的新的方式：Update to V(s)：$V^\pi(s)\leftarrow(1-\alpha)V^\pi(s)+(\alpha)sample$ 
		- 学习率：$\alpha$
			- $1-\alpha$：指定已存在的模型对$V^\pi(s)$的影响
				- 过去的影响则逐渐收敛至0
			- $\alpha$：指定新的sample对$V^\pi(s)$的影响
		- Same update：$V^\pi(s)\leftarrow V^\pi(s)+\alpha(sample-V^\pi(s))$
		- 原评估方式（加权平均）：$V^\pi(s)=\sum_{s^\prime}T(s,\pi(s),s^\prime)[R(s,\pi(s),s^\prime)+\gamma V^\pi(s^\prime)]$
- 示例：
![image.png](https://s2.loli.net/2022/07/31/JnptsXTAghKEaxM.png)
### Q-Learning
- 被动强化学习中的问题：要找到最优的策略，我们必须知道状态的q-values
- Q-Learning：直接学习状态的q-values（无需其他任何values, T, R)，为每一个q-state找到最佳的q-value
- q-value iteration：$$Q_{k+1}(s,a)\leftarrow\sum_{s^\prime}T(s,a,s^\prime)[R(s,a,s^\prime)+\gamma\max_{a^\prime}Q_k(s^\prime,a^\prime)]$$
- **q-value samples**：$$sample=R(s,a,s^\prime)+\gamma\max_{a^\prime}Q(s^\prime,a^\prime)$$
- 指数**平均效益计算**：$$Q(s,a)\leftarrow(1-\alpha)Q(s,a)+\alpha·sample$$
- 即使一开始选择了其他策略，也可以直接学习到最优策略->**off-policy learning**
- 例子：
![](https://s2.loli.net/2022/07/31/JOzi5KNyPbL2csa.png)
- **警告**：
	- 必须有**足够多的探索**
	- 最后要让learning rate足够小但不能下降过快
![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20220903212124.png)


### ==Approximate Q-Learning==
- Q-learning必须存储所有的状态->**数据量过大**
![](https://s2.loli.net/2022/07/31/zEXYnkor6eVvqu1.png)
- 在Approximate Q-Learning中，我们尝试学习一些通用的情况
	- 关键：学习不同环境之间的相似点
		- 例如：
			- 与最近鬼的距离
			- 与最近的药丸的距离
			- 鬼的数量
			- 是否被困住
	- 优点：
		- 适用范围更加广
		- 存储高效
- 线性价值函数：$$\begin{aligned}
V(s) &=w_{1} \cdot f_{1}(s)+w_{2} \cdot f_{2}(s)+\ldots+w_{n} \cdot f_{n}(s)=\vec{w} \cdot \vec{f}(s) \\
Q(s, a) &=w_{1} \cdot f_{1}(s, a)+w_{2} \cdot f_{2}(s, a)+\ldots+w_{n} \cdot f_{n}(s, a)=\vec{w} \cdot \vec{f}(s, a)
\end{aligned}$$
	- $\vec{f}(s)$：代表状态的特征$$\vec{f}(s)=\left[\begin{matrix}
f_{1}(s) & f_{2}(s) & \ldots & f_{n}(s)
\end{matrix}\right]^{T}$$
	- $\vec f(s,a)$：$$\vec{f}(s, a)=\left[\begin{matrix}
f_{1}(s, a) & f_{2}(s, a) & \ldots & f_{n}(s, a)
\end{matrix}\right]^{T}$$
	- $\vec w$：$$\vec w=\left[\begin{matrix}
w_{1} & w_{2} & \ldots & w_{n}\end{matrix}\right]^{T}$$
	- difference：$$difference = [R(s,a,s^\prime)+\gamma\max_{a^\prime}Q(s^\prime,a^\prime)]-Q(s,a)$$
	- $w_i$：$$w_i\leftarrow w_i+\alpha·difference·f_i(s,a)$$
	- $Q(s,a)$：$$Q(s,a)\leftarrow Q(s,a)+\alpha·difference$$
- eg:
![](https://s2.loli.net/2022/07/31/1QOg4V8vj9pFztM.png)

## Exploration or Exploitation
- 足够的探索在深度学习中是必要的
### $ε$-Greedy Policies
- 每一步都投掷一枚“硬币”
	- $ε$：exploration
	- $1-ε$：act on current policy
### Exploration Function
- modified update function：$$Q(s,a)\leftarrow (1-\alpha)Q(s,a)+\alpha·[R(s,a,s^\prime)+\gamma\max_{a^\prime}f(s^\prime,a^\prime)]$$
- exploration function：$$f(s,a)=Q(s,a)+\frac{k}{N(s,a)}$$
	- $k$：预先决定的值
	- $N(s,a)$：q-state(s,a)被访问的次数
- 随时间推移，探索的次数逐渐减少，更多执行以确定的策略
