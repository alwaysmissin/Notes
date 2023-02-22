# Numpy
## 概述
1. 特点
	1. 快速节省空间的多维数组ndarray，提供数组化的算术运算和高级的广播功能
	2. 使用标准数学函数对整个数组的数据进行快速运算，而无序编写循环
	3. 读取/写入磁盘上的阵列数据和操作存储器映像的文件工具
	4. 线性代数、随机数生成和傅里叶变换的能力
	5. 集成C、C++、Fortran代码的工具

## 生成Numpy数组
### 1. 从已有的数据中创建数组
1. 将列表转换成ndarray
2. 嵌套列表可以转换为多维数组
- 将列表替换为元组同样适用
### 2. 利用random模块
|      函数      |         描述         |
|:--------------:|:--------------------:|
| random.random  | 生成0~1之间的随机数  |
| random.uniform | 生成均匀分布的随机数 |
|  random.randn  | 生成标准正态的随机数 |
| random.randint |    生成随机的整数    |
| random.normal  |     生成正态分布     |
| random.shuffle |     随机打乱顺序     |
|  random.seed   |     设置随机种子     |
| random_sample  |   生成随机的浮点数   |
### 3. 创建特定形状的多维数组
| 函数                 | 描述                          |
| -------------------- | ----------------------------- |
| np.zeros((3,4))      | 创建3x4全为0的数组            |
| np.ones((3,4))       | 创建3x4全为1的数组            |
| np.empty((3,4))      | 创建空数组（非0）             |
| np.zeros_like(ndarr) | 创建相同维度的0数组           |
| np.ones_like(ndarr)  | 同上                          |
| np.empty_like(ndarr) | 同上                          |
| np.eye(5)            | 创建5x5矩阵（对角为1，其他为0 |
| np.full((3,4),666)   | 创建全为666的3x4数组
### 4. 利用arange、linspace函数生成数组
1. `arange([start,] stop[, step,], dtype = None)`
	1. `start`指定起始：默认0
	2. `stop`指定终末：不可少
	3. `step`指定步长：默认1
2. `linspace(start, stop, num = 50, endpoint = True, retstep = False, dtype = None)`
	- 根据输入的指定数据范围以及等份数量，自动生成一个线性等分**向量**
```jupyter
import numpy as np
print(np.linspace(0, 1, 10))

```
## 获取元素
![](https://s2.loli.net/2022/07/17/imAtFzwQUBqLI5h.png)
1. `[:,:-1]`: This will take all rows and all but the last column.
2. `[:,-1] `: This will take all rows and only the last column.
3. `:`denotes "all", and -1 in indexing means the last row/column.

## 算数运算
1. 逐元乘法：`np.multiply()`
![](https://s2.loli.net/2022/07/17/CY8TQzNjtfh9bkU.png)
2. 点积（内积元素）：`np.dot()`
![](https://s2.loli.net/2022/07/17/XF6alWBRGLvsrxn.png)

## 数组变形
### 1. 更改数组的形状
| 函数          | 描述                           |
| ------------- | ------------------------------ |
| arr.reshape   | 对维度进行改变，产生一个新数组 |
| arr.resize    | 对维度进行改变，在原数组上修改 |
| arr.T         | 转置                           |
| arr.ravel     | 展平，在原数组上修改           |
| arr.flatten   | 展平，产生一个新的数组         |
| arr.squeeze   | 只能对维数为1的维度降维        |
| arr.transpose | 对高维矩阵进行轴对换
1. reshape
	- 指定的维度可以仅指定行或列，但行或列数必须要被整除

### 2. 合并数组
| 函数           | 描述                     |
| -------------- | ------------------------ |
| np.append      | 内存占用大               |
| np.concatenate | 没有内存问题             |
| np.stack       | 沿着新的轴加入一系列数组 |
| np.hstack      | horizon                  |
| np.vstack      | vertical                 |
| np.dstack      | depth                    |
| np.vsplit      | 将数组分解成垂直的多个子数组的列表

## 批量处理

## 通用函数
- 使用C语言级别下实现，相比math库中的函数，计算速度快
- 操作对象为数组

## 广播机制
- 规则
	1. 让所有输入数组都向其中shape最长的数组看齐，不足的部分则通过在前面加1补齐
	2. 输出数组的shape是输入数组shape的各个轴上的最大值
	3. 如果输入数组的某个轴和输出数组的对应轴的长度相同或者某个轴的长度为1时，这个数组能被拿来计算，否则出错
	4. 当输入数组的某个轴的长度为1时，沿着此轴运算时都用（或复制）此轴上的第一组值
![image.png](https://s2.loli.net/2022/07/17/ACQu7GqSy1b9nht.png)