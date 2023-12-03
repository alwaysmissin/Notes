# Review
## 基础知识
### 对象模型
- python中一切都是对象
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102151233.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102151248.png)
### 变量
- **不需要事先声明变量名及其类型**，直接赋值即可创建
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102151339.png)
- python属于**强类型编程语言**，数据类型将通过python解释器自动推断
- 允许多个变量指向同一个值：![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102151516.png)![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102151623.png)
- Python采用的是**基于值的内存管理方法**
	- 相同的值在内存中只有一份，多个变量指向同一块内存地址
- 变量名规则：
	- 字母或下划线开头
	- 中不能有空格及标点符号
	- 不能使用关键字
	- 不建议使用系统内置的模块名
	- 大小写敏感
- Python中的**变量**并不直接存储值，而是存储了值的**内存地址或引用**
> 赋值语句的执行过程：计算等号右侧的表达式，然后创建，并指向
- Python具有**自动内存管理功能**：自动删除不再有变量指向的值
	- 使用`del`手动删除

### 数字类型
- 数字是不可变对象，可以表示任意大小的数字![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102152450.png)
- 三类：整数、浮点、复数
	- 整数：![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102152535.png)
	- 浮点：![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102152555.png)
	- 复数：![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102152612.png)
- 可在数字中间位置使用单个下划线提高数字的可读性
### 字符串
- 字符串属于**不可变序列**
- 使用多种形式实现复杂字符串
- 空字符串：`''|""`
- 可换行字符串：`""" """|''' '''`
- 字符串之间的连接：
	- `+`：将两个字符串连接成为一个新的字符串
	- `*`：生成一个由其本身字符串重复连接而成的字符串
- `len()`
- 支持转义字符
- 字符串界定符前加字母`r/R`便是原始字符串，其中的特殊字符不进行转义
### 运算符
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102153617.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102154307.png)
- `and|or`惰性求值
- 特殊说明：
	- `,`不是运算符![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102154433.png)
	- 不支持`++|--`
### 常用内置函数
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102154547.png)![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102154825.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102154919.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102154926.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102154932.png)

- 迭代器
	- 基本方法：`iter()`、`next()`
	- 迭代器对象可以使用常规的for语句进行遍历![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102154755.png)
- `sorted()`返回排序后的新列表
- `zip()`：
	- 返回一个zip对象（可转）
	- 元素个数与最短的列表一致
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102155609.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102155619.png)
### 模型的导入与使用
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102155756.png)
### Python文件
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102155829.png)
### `__name__`
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102155905.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102155923.png)
## 序列
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102160050.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102160104.png)
### 列表
- 有序、可变
- 增删元素时，对象自动进行拓展或收缩内存
- 列表中的数据类型可以不同
- 常用方法![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102160324.png)
- 列表元素的添加：
	- `+`：创建一个新列表
	- `append()`：尾部追加
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102160545.png)
- 列表中包含的是元素值的引用，而非其本身
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102161041.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102161448.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102162209.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102162236.png)

#### 切片
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102162357.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102162434.png)
- 用来原地修改![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102162534.png)
- 结合`del`删除列表元素![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102162558.png)
- 切片返回的是列表元素的浅复制，**左开右闭**
	- 浅复制：生成一个**新的列表**，并且把原列表元素的**引用**都复制到新的列表中![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102162807.png)
	- 修改任何一个都会对原列表产生影响
> 深复制：使用copy.deepcopy()函数实现
> 对原列表中的元素进行递归，把所有值都复制到新列表中，对嵌套的子列表不再是复制引用
> 新列表与原列表相互独立，修改任何一个都不会影响原列表
> ![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102163043.png)
#### 列表排序
- `sorted()`：返回一个新列表
- `reserse()`：原地逆序
- `reversed()`：返回逆序序列并返回迭代器（一次性）
#### sum
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102163850.png)
1. 看：求 数值和 或 集合和
2. 脱：一层方括号 判断 类型匹配 再运算
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102163908.png)
#### 列表推导式
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102163927.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102164001.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102164109.png)
### 元组
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102192800.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102193113.png)
### 字典
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102193315.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102193338.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102193743.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102193838.png)
#### 读取
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102193904.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102200919.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102201002.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102201115.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102201155.png)
### 集合
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102203213.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102203227.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102204338.png)
## 程序控制结构
- **局部变量的查询和访问速度比全局变量略快**

## 字符串与正则表达式
- 默认UTF8
- 在统计字符串长度时，中英文都按照一个字符对待和处理
- 字符串属于不可变序列
- Python字符串驻留机制：对于短字符串，将其赋值给多个不同对象时，**内存中只有一个副本**，多个对象共享该副本
### 字符串格式化
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102231529.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102231754.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102231848.png)
- `format()`方法
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102231926.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102232036.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102232252.png)
- `f''`
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102232429.png)
### 常用方法
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102232450.png)
- 查找
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102233028.png)
- 分割
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102233237.png)
- 连接
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102233415.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102233450.png)
> 不推荐使用+，效率低

- 其他
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102233758.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102234015.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221102234146.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103085115.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103085238.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103085250.png)
> Python的许多内置函数也可以对字符串进行操作
> 切片同样适用于字符串，但仅限于读取其中的元素，不支持字符串修改

### 正则表达式
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103091151.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103091158.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103091243.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103091356.png)
- re![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103091431.png)
	- re.sub()![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103092029.png)![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103092107.png)![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103092345.png)

## 函数
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103094555.png)
- 对于绝大多数情况下，在函数内部直接修改形参的值不会影响实参，而是创建一个新的变量
- 如果传递给函数的实参是可变序列，并且在函数内部使用下表或可变序列自身的方法增加或删除或修改元素时，实参也得到响应的修改
- 默认值参数的赋值只会在函数定义时被解释一次，当使用可变序列作为参数默认值时，需要谨慎![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103095518.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103095622.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103095832.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103095856.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103100103.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103100259.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103100357.png)
- return语句及变量作用域
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103100735.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103100754.png)

### lambda表达式
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103100856.png)
- 实例：
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103100952.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103101022.png)
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20221103101311.png)
