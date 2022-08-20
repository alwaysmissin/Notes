# DFS与BFS
- 由数据结构的视角
	- DFS：stack
	- BFS：queue
- 空间
	- DFS：$O(h)$
	- BFS: $O(2^h)$
- BFS可搜最短路径
## DFS
1. 回溯：利用递归栈（递归本身就是基于方法调用栈来实现）
- 全排列
```C++
#include <iostream>
using namespace std;
const int N = 10;

int path[N];      //存储路径
int n;
bool st[N];

void dfs(int u){       //u用于记录步数
    if(u == n){     //如果步数等于n
        for(int i = 0;i < n;i++) printf("%d ", path[i]);        //打印
        puts("");
        return;
    }
    for(int i = 1;i <= n;i++){
        if(!st[i]){
            path[u] = i;        //命名路径点
            st[i] = true;       //标记使用过的数字
            dfs(u + 1);         //下一步
            st[i] = false;      //恢复标记
        }
    }
}

int main(){
    cin >> n;
    
    dfs(0);
    
    return 0;
}
```
2. 剪枝：提前判断当前情况是否成立，及时止损
- n皇后
```C++

//第一种搜索顺序
#include <iostream>
using namespace std;


const int N = 20;       //对角线数量是两倍
int n;
int chess[N];
bool col[N], mp[N], np[N];      //行，主对角线，副对角线


void dfs(int u){
    if(u == n){     //打印
        for(int i = 0;i < n;i++){
            for(int j = 1;j <= n;j++){
                if(j == chess[i]) printf("Q");
                else printf(".");
            }
            puts("");
        }
        puts("");
    }
    
    for(int i = 1;i <= n;i++){
        if(!(col[i]) && !(mp[u + i]) && !(np[n - u + i])){
            chess[u] = i;
            col[i] = mp[u + i] = np[n - u + i] = true;      //标记
            dfs(u+1);
            col[i] = mp[u + i] = np[n - u + i] = false;     //恢复标记
        }
    }
}

int main(){
    cin >> n;
    
    dfs(0);
    
    return 0;
}

```

```C++
//第二种解法
#include <iostream>
using namespace std;


const int N = 20;       //对角线数量是两倍
int n;
char chess[N][N];
bool row[N], col[N], mp[N], np[N];      //行，主对角线，副对角线


void dfs(int x, int y, int cnt){
    if(y == n){
        y = 0;
        x ++;
    }
    
    if(x == n){
        if(cnt == n){     //打印
            for(int i = 0;i < n;i++){
                puts(chess[i]);
            }
            puts("");
        }
        return;
    }

    if(!row[x] && !(col[y]) && !(mp[x + y]) && !(np[x - y + n])){
        chess[x][y] = 'Q';
        row[x] = col[y] = mp[x + y] = np[x - y + n] = true;      //标记
        dfs(x, y + 1, cnt + 1);
        row[x] = col[y] = mp[x + y] = np[x - y + n] = false;
        chess[x][y] = '.';
    }
    
    dfs(x, y + 1, cnt);
}

int main(){
    cin >> n;
    
    for(int i = 0;i < n;i++){
        for(int j = 0;j < n;j++){
            chess[i][j] = '.';
        }
    }
    
    dfs(0, 0, 0);
    
    return 0;
}

```

- 使用位运算优化：
```C++
void nQueenModified(int row, int cur, int llimit, int rlimit){

    if(row > n){        //放置完毕后，打印棋盘

        printChess();

        cnt ++;

        return;

    }

    int ban = cur | llimit | rlimit;        //求解当前行不可放置的地方

    for(int i = 1;i <= n;i++){

        if(ban & (1 << i)) continue;        //如果当前位置不可放置，直接进行下一轮循环    

        chess[row][i] = 'Q';                //放置皇后

        //根据放置情况，进入下一行进行皇后的放置

        nQueenModified(row + 1, cur | (1 << i), (llimit | (1 << i)) << 1, (rlimit | (1 << i)) >> 1);

        chess[row][i] = '.';                //恢复状态

    }

}
```
## BFS
- 应用：最短路（边权为1）
- 重点：
	- 队列
	- 距离记录
- 一般有：
	- `d[N]`用于储存步数
- 模板
```C++
queue <—— 初始化
while(!queue.empty()){
	queue.pop();
	queue.push();
}
```

- 走迷宫问题
```C++
#include <iostream>
using namespace std;


const int N = 20;       //对角线数量是两倍
int n;
char chess[N][N];
bool row[N], col[N], mp[N], np[N];      //行，主对角线，副对角线


void dfs(int x, int y, int cnt){
    if(y == n){
        y = 0;
        x ++;
    }
    
    if(x == n){
        if(cnt == n){     //打印
            for(int i = 0;i < n;i++){
                puts(chess[i]);
            }
            puts("");
        }
        return;
    }

    if(!row[x] && !(col[y]) && !(mp[x + y]) && !(np[x - y + n])){
        chess[x][y] = 'Q';
        row[x] = col[y] = mp[x + y] = np[x - y + n] = true;      //标记
        dfs(x, y + 1, cnt + 1);
        row[x] = col[y] = mp[x + y] = np[x - y + n] = false;
        chess[x][y] = '.';
    }
    
    dfs(x, y + 1, cnt);
}

int main(){
    cin >> n;
    
    for(int i = 0;i < n;i++){
        for(int j = 0;j < n;j++){
            chess[i][j] = '.';
        }
    }
    
    dfs(0, 0, 0);
    
    return 0;
}

```

- 八数码
- 难点：
	1. 状态表示复杂：使用字符串记录，(`queue<string>`)
	2.  如何记录每一个状态的距离：哈希表`unordered_map<string,int> dst`
```C++
#include <iostream>
#include <cstring>
#include <algorithm>
#include <queue>
#include <unordered_map>
using namespace std;

queue<string> q;
unordered_map<string, int> dst;
string start;

int bfs(string start){
    q.push(start);
    dst[start] = 0;
    
    string end = "12345678x";
    int d[4] = {1, -1, 3, -3};      //这样表示错误，可能出现跨行的情况
    int dx[4] = {-1, 0, 1, 0};
    int dy[4] = {0, 1, 0, -1};
     
    while(q.size()){
        string t = q.front();
        q.pop();
        
        if(t == end) return dst[t];
        
        int step = dst[t];
        
        int k = t.find('x');        //返回x的下标
        int x = k / 3, y = k % 3;
        
        for(int i = 0;i < 4;i++){
            int a = x + dx[i], b = y + dy[i];
            if(a >= 0 && a < 3 && b >= 0 && b < 3){
                swap(t[k], t[a * 3 + b]);
                
                if(!dst.count(t)){
                    dst[t] = step + 1;
                    q.push(t);
                }
                swap(t[k], t[a * 3 + b]);       //回复状态，避免对下一个状态产生影响
            }
        }
    }
    return -1;
}

int main(){
    
    for(int i = 0;i < 9;i++){
        char c;
        cin >> c;
        start += c;
    }
    
    //cout << start << endl;
    cout << bfs(start) << endl;
    
    return 0;
}

```