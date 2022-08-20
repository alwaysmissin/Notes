# Huffman
## 哈夫曼树
1. **构建思想**：**反复选择两个最小的元素**，合并，直到只剩下一个元素
	- 一般情况下使用优先队列来执行这种策略
	- 我们无需真的去构建一颗哈夫曼树，只需要能的到最终的带权路径长度计科
1. 对于同一组叶子结点来说，哈夫曼树可以是不唯一的，但是**最小带权路径长度(WPL)一定是唯一**的
### [148. 合并果子](https://www.acwing.com/problem/content/150/)
- 代表小根堆的优先队列：`priority_queue<int, vector<int>, greater<int>>`
#### 代码：
```C++
#include <iostream>
#include <algorithm>
#include <queue>
using namespace std;
int main(){
    int n;
    cin >> n;
    
    priority_queue<int, vector<int>, greater<int>> p;       //构建小根堆
    while(n --){
        int x;
        cin >> x;
        p.push(x);
    }
    
    int sum = 0;
    while(p.size() > 1){    //堆中最少剩余一个元素（结果）
        int a = p.top(); p.pop();//取出两个最小的元素
        int b = p.top(); p.pop();
        p.push(a + b);      //新值入堆
        sum += a + b;   
    }
    
    cout << sum << endl;
    return 0;
}
```

## 哈夫曼编码
> 如果对任意一颗二叉树的所有分支进行编号（左分支标记为0，右分支标记为1），则对于树上的任意一个结点，都可以根据中根结点出发到达它的分支顺序得到一个唯一的编号，并且，**对于任何一个叶子结点，其编号一定不会称为其他任何一个结点编号的前缀（前缀编码）**
> ![](https://s2.loli.net/2022/05/05/rmgQSkd9tByYuNV.png)
- 前缀编码的意义：不产生混淆，让解码正常进行
- 将每一个字符出现的次数作为各自叶子节点的权值，则**字符串编码成01串后的长度实际上就是这棵树的带权路径长度**
- 哈夫曼编码是针对确定的字符串
- 每个步骤将频率最低的两棵树合并（构建哈夫曼树）
