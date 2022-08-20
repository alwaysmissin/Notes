# 常用STL

## vector容器
1. 定义
	1. `vector<typename> name`
2. 元素的访问
	1. 通过下标
	2. 通过迭代器
		1. 迭代器可以理解为类似指针的东西
3. 常用函数
	1. `push_back()`
	2. `pop_back()`
	3. `size()`
	4. `clear()`：清空`vector`中的所有元素
	5. `insert(it, x)`：向it处插入一个元素
	6. `erase()`
		1. `erase(n)`：剔除n处的元素
		2. `erase(beg, end)`：剔除从beg到end - 1处的元素
4. 常见用途：
	1. 存储数据
	2. 用邻接表存储图(具体见算法笔记10.2.2节)


## set
- set是**内部自动有序(递增)** 且**不含重复元素**的容器
1. 定义
	1. `set<typename> name;`
2. set内元素的访问
	1. 只能通过迭代器访问`set<typename>::iterator it`
	2. 遍历方式：
		```C++
		for(set<int>::iterator it = st.begin();it != st.end();it++){
			cout << *it << endl;
		}
		```
3. 常用函数
	1. `insert(x)`：将x插入到容器中
	2. `find(x)`：返回x对应的迭代器
	3. `erase()`
		1. `erase(it)`：删除迭代器it所指的元素
		2. `erase(x)`：删除x值（时间复杂度O(logN)）
		3. `erase(beg, end)`
	4. `size()`
	5. `clear()`