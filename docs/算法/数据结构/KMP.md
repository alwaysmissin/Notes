# KMP
## next数组
- 包含了与自身的偏移进行匹配的信息
- 用处：在朴素的字符匹配中避免对无用偏移进行检测
- `next[i]`表示子串`s[0...i]` 的前缀`s[0...j]`等于后缀`s[i - j...i]` 的最大j
![图解](https://s2.loli.net/2022/04/28/edLDtWwGlc7MVX3.png)

![ne数组求法](https://s2.loli.net/2022/04/29/zWUHtmA84DFGK2E.png)


```C++
#include <iostream>
#include <algorithm>
#include <cstring>
using namespace std;
const int N = 100010;
int n, m;
char q[N], s[N * 10];
int ne[N];

int main(){
    cin >> n >> q + 1 >> m >> s + 1;
    //求ne数组，实质上与下的KMP匹配一致
    for(int i = 2, j = 0;i <= n;i++){       //ne[1] = 0，直接从ne[2]开始
        //**尝试**用p[j + 1]与p[i]比较
        while(j != 0 && q[j + 1] != q[i]) j = ne[j];    //如果不满足条件，退求其次
        if(q[j + 1] == q[i]) j++;           //如果满足q[j + 1] == q[i]，说明满足条件的字符串长度加一
        ne[i] = j;
    }
    //KMP字符串匹配
    for(int i = 1, j = 0;i <= m;i++){
        //**尝试**用p[j + 1]与s[i]比较
        while(j != 0 && q[j + 1] != s[i]) j = ne[j];
        if(q[j + 1] == s[i]) j++;   //继续下一位匹配
        if(j == n){                 //匹配成功
            printf("%d ", i - n);
        }
    }
    
    return 0;
}
```


> 趣学数据结构 KMP P129
> 算法笔记 KMP P455
> 算法导论 KMP P588