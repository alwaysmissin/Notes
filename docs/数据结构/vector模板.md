# vector模板

## 一、STL编程

1. 核心：
   1. 容器(Container)：用于管理一类对象的集合(deque、list、vector、map)
   2. 算法(Algoritms)：算法作用于容器(排序、初始化、搜索、转换)
   3. 迭代器(iterators)：用于遍历对象集合（**容器、容器的子集**）的元素
2. 拥有丰富的预定义函数



## 二、vector容器

1. 动态大小数组的顺序容器
2. 特性：
   1. 顺序序列
   2. 动态
   3. 感知内存分配器



## 三、基本函数

1. 构造函数
   1. `vector`创建空vector
   2. `vector(int Size)` 创建Size个元素的vecotr
   3. `vector(int Size, const t& t)` 创建Size个元素的vecotr，且元素均为t
   4. `vector(const vector&)` 拷贝构造函数
   5. `vecotr(begin,end)`复制$[begin,end)$ 区间内另一个数组元素到vector中
2. 增加函数
   1. `push_back()` 尾部添加一个元素
3. 删除函数
   1. `pop_back()` 尾部删除一个元素
4. 遍历函数
   1. `ilterator begin()` 返回向量头指针
   2. `ilterator end()` 返回向量尾指针（指向最后一个元素的下一个位置）
5. 判断函数
6. 大小函数
7. 其他函数



## 四、迭代器(ilterator)

1. 遍历存储空间连续的数据结构
2. 实质：**指针**
3. 可用容器：vector、deque、list、set、multiset、map、multimap
4. 分类：前向迭代器、双向迭代器、随机访问迭代器
5. 对于`vector`容器的三种遍历

```c++
#include <iostream>
#include <vector>
using namespace std;
int main(){
    vector<int> x{1,2,3,4,5,6,7,8,9,10};
    //遍历一
    for(int i = 0;i < 10;i++){
        cout << v[i] << " ";
    }
    cout << endl;
    //遍历二
    for(int *p = v.begin();p != v.end();p++){
        cout << *p << " ";
    }
    cout << endl;
    //遍历三
    vector<int>::ilterator i;
    for(i = v.begin();i != v.end();i++){
        cout << *i << " ";
    }
    cout << endl;
}
```
