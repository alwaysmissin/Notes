# Floyd
- 可以求解任意两个顶点间的最短路径
- 又名：插点法
	- 在顶点$i$和顶点$j$之间插入顶点$k$，看能否缩短$i$和$j$之间的距离

## 算法步骤
1. 数据结构：带权邻接矩阵`Edge[][]`，两个辅助数组：`dist[i][j]`，记录从$i$到$j$的最短路径，前驱数组`p[i][j]`，记录$i$到$j$的最短路径上$i$顶点的前驱
2. 初始化：`dist[i][j] = Edge[i][j]`，如果顶点i到j有边，则初始化`p[i][j] = i`，否则`p[i][j] = -1` 
3. 插点：松弛操作：如果`dist[i][j]=min(dist[i][j],dist[i][k]+dist[k][j])` 记录`p[i][j] = p[k][j]`

## [Floyd求最短路](https://www.acwing.com/problem/content/856/)

- 疑问：
	- 为什么floyd中的顺序为k i j
```C++
#include <iostream>
#include <algorithm>
#include <cstring>
using namespace std;
const int N = 210, INF = 1e9;

int dist[N][N];
int n, m, k;

void Floyd(){               //为什么是这种顺序？？？？
    for(int k = 1;k <= n;k++){
        for(int i = 1;i <= n;i++){
            for(int j = 1;j <= n;j++){
                dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);     //更新距离
            }
        }
    }
}


int main(){
    cin >> n >> m >> k;
    int a, b, c;
    
    for(int i = 1;i <= n;i++){          //初始化距离
        for(int j = 1;j <= n;j++){
            if(i == j) dist[i][j] = 0;
            else dist[i][j] = INF;
        }
    }
    
    while(m--){         //读取距离
        cin >> a >> b >> c;
        dist[a][b] = min(dist[a][b], c);
    }
    
    Floyd();        //floyd
    
    while(k--){     //询问
        cin >> a >> b;
        if(dist[a][b] > (INF >> 1)) cout << "impossible" << endl;       //可能存在负权边
        else cout << dist[a][b] << endl;
    }
    
    return 0;
}

```

## 复杂度分析
#### 时间复杂度
3层for循环->$O(n^3)$
#### 空间复杂度
$O(n^2)$