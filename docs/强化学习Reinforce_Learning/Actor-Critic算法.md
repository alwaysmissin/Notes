# Actor-Critic算法
> 在之前的内容中，我们学习了基于值函数的方法和基于策略的方法，其中基于值函数的方法只学习一个价值函数，而基于策略的方法只学习一个策略函数。那么一个很自然的问题，有没有什么方法及学习价值函数，又学习策略函数呢？那就是Actor-Critic算法。
> Actor-Critic是一系列算法，目前前沿的许多高效算法都是属于Actor-Critic。
> Actor-Critic算法本质上是基于策略的算法，因为这系列算法都是去优化一个餐参数的策略，只是其中会额外学习价值函数来帮助策略函数的学习。

## Actor-Critic算法
- 通过拟合一个值函数来指导策略进行学习（**Critic**）
> 在REINFORCE中，使用的蒙特卡洛采样方法对梯度的估计是无偏的，但是方差非常大，我们需要引入其他因子来减小方差
- 梯度的表达形式：$$
g=\mathbb{E}\left[\sum_{t=0}^{\infty} \psi_t \nabla_\theta \log \pi_\theta\left(a_t \mid s_t\right)\right]
$$
	- 其中$\psi_t$可以有很多种形式：
		- $\sum_{t^{\prime}=0}^{\infty} \gamma^t r_{t^{\prime}}$：轨迹的总回报
		- $\sum_{t^{\prime}=t}^{\infty} \gamma^{t^{\prime}-t} r_{t^{\prime}}$：动作$a_t$之后的回报
		- $\sum^{\infty}_{t^\prime=t} r_{t^{\prime}}-b\left(s_t\right)$：基准线版本的改进
			- 通过引入基线$b(s_t)$来减小方差
		- $Q^{\pi_\theta}\left(s_t, a_t\right)$：动作价值函数
			- 估计一个动作价值函数来代替蒙特卡洛采样得到的回报
		- $A^{\pi_\theta}\left(s_t, a_t\right)$：优势函数
		- $r_t+\gamma V^{\pi_\theta}\left(s_{t+1}\right)-V^{\pi \theta}\left(s_t\right)$：**时序差分残差**
			- 由$Q=r+\gamma V\quad A=Q-V$进一步得到
- Actor-Critic的方法可以在每一步之后都进行更新![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230105160313.png)
- Actor-Critic：
	- Critic：通过Actor与环境交互手机的数据学习一个价值函数，这个价值函数会用于帮助Actor进行策略更新
		- 使用时序差分的方法进行学习，损失函数为：$$\mathcal{L}(\omega) = \frac{1}{2} (r + \gamma V_\omega(s_{t+1}) - V_\omega(s_t))^2$$
			- 其中，$r + \gamma V_\omega(s_{t+1}) - V_\omega(s_t)$为时序差分目标
		- 价值函数的梯度：$$\nabla_\omega \mathcal{L}(\omega) = -  (r + \gamma V_\omega(s_{t+1}) - V_\omega(s_t)) \nabla_\omega V_\omega(s_t)$$
	- Actor：与环境交互，并利用价值函数来用**策略梯度**学习一个更好的策略
- 算法流程：![](https://raw.githubusercontent.com/alwaysmissin/picgo/main/20230105160300.png)
