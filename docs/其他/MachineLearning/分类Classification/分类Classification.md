# 分类(Classification)
## 分类
1. $x \rightarrow f(x) \rightarrow Class n$
2. 应用：
	1. 信用评价(Credit Scoring)
	2. 医学诊断(Medical Diagnosis)
	3. 手写体识别(Handwritten Character Recognition)
	4. 人脸识别(Face Recognition)

## 示例：Pokemon Classification(Binary Classification)
### 如果使用Regression
- 在分类聚集时候可能表现较好
- 在远端出现聚集时，Regression会为了降低Loss，而出现偏差（这样的情况不符合分类的要求）
![](https://s2.loli.net/2022/07/22/Yl9LawUfcRH5SJq.png)
### 理想的选择
1. 模型：
$$
y = \begin{cases}
class1\quad g(x) > 0\\
class2 \qquad else
\end{cases}
$$
2. 损失函数:
$$L(f)= \sum _{n} \delta(f(x^n) \neq \hat y^n)$$
- 匹配错误的次数和
3. 最好的函数：Perceptron, SVM
### 贝叶斯
![](https://s2.loli.net/2022/07/22/J8OGovswbfcmHue.png)
- 朴素贝叶斯：
	- 公式：$$p(C|F_1,…,F_n) = \frac{p(C)p(F_1,…,F_n|C)}{p(F_1,…,F_n)}$$
	- 简单表示：$$后验概率 = \frac{先验概率 \times 可能性}{全部可能}$$
- 对于案例：
	- $x$属于某一个集合的概率：$$P(C_1|x)=\frac{P(x|C_1)P(C_1)}{P(x|C_1)P(C_1) + P(x|C_2)P(C_2)}$$
	- 生成模型（朴素贝叶斯）：$P(x)=P(x|C_1)P(C_1) + P(x|C_2)P(C_2)$
### 高斯分布(正态分布)
[正态分布 - 维基百科，自由的百科全书](https://zh.wikipedia.org/zh-cn/%E6%AD%A3%E6%80%81%E5%88%86%E5%B8%83)
$$f_{\mu, \Sigma}(x) = \frac{1}{(2\pi)^{D/2}} \frac{1}{\lvert\Sigma\rvert^{1/2}}exp\{-\frac{1}{2}(x-\mu)^{T}\Sigma^{-1}(x-\mu)\}$$
- 输入：向量$x$
- 输出：$x$属于该类的可能性
- 图的形状取决于$\mu$和$\Sigma$ 
![](https://s2.loli.net/2022/07/22/rW5lUFuRwZizPML.png)
**如何找到$\mu$和$\Sigma$**$\rightarrow$ **极大似然估计(Maximum Likelihood)** 
### 极大似然(Maximum Likelihood)
$$\begin{array}
L(\mu,\Sigma) = f_{\mu,\Sigma}(x^1)f_{\mu,\Sigma}(x^2)f_{\mu,\Sigma}(x^3)…f_{\mu,\Sigma}(x^n)
\\
\Downarrow
\\
\mu^*, \Sigma^* = arg\max_{\mu,\Sigma}L(\mu, \Sigma)
\\
\Downarrow
\\
\mu^*=\frac{1}{n} \sum^{n}_{i}x^i\qquad\Sigma^* = \frac{1}{n} \sum^{n}_{i}(x^n-\mu^*)(x^n-\mu^*)^T
\end{array}$$
![](https://s2.loli.net/2022/07/22/S1vI5cDwmZJuBrl.png)

- 对于$\Sigma$可以使用相同的值，$\Sigma$的值由$\Sigma_1, \Sigma_2…\Sigma_n$共同决定
![](https://s2.loli.net/2022/07/22/3dv7LOsPZbgVR4K.png)
