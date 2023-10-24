# 命令行环境 
## 任务控制

## 终端多路复用（tmux）
- 命令的基本使用：
	- `tmux a`：打开上一个session
	- `tmux new -s <session-name>`：新建一个名为`session-name`的`session`
- `ctrl-b`
	- `c`：新建一个窗口
	- `z`：全屏当前的pane
	- 方向键：切换pane
	- `,`：重命名当前窗口
- `ctrl-d`：关闭窗口
> 配置教程：https://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
## 别名
```shell
# 创建常用命令的缩写
alias ll="ls -lh"

# 能够少输入很多
alias gs="git status"
alias gc="git commit"
alias v="vim"

# 手误打错命令也没关系
alias sl=ls

# 重新定义一些命令行的默认行为
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format

# 别名可以组合使用
alias la="ls -A"
alias lla="la -l"

# 在忽略某个别名
\ls
# 或者禁用别名
unalias la

# 获取别名的定义
alias ll
# 会打印 ll='ls -lh'
```
## 配置文件

## 远程设备

