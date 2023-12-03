# WSL安装与基本配置

[TOC]

## 什么是WSL

**WSL(Windows Subsystem of Linux)**，是一个运行在windows上的linux子系统，可以让开发人员在windows上直接运行linux的环境，包括大多数的命令行工具、使用工具和应用程序，且不**会产生传统虚拟机的开销或双系统风险**

WSL是基于微软开发的虚拟机平台Hyper-V，同样是虚拟机，**相对VMware或其他虚拟机平台有什么优势呢**？

- 在文件系统上，可以直接**与windows互通**，可以在windows下打开wsl中的文件，可以在wsl中使用windows文件
  - 在ubuntu中的mnt（外部挂载设备）目录访问windows中的文件
  - 在windows中通过`\\wsl$`访问wsl中的文件，在各种软件中可以直接访问wsl中的文件，微软官方的开发软件和jetbrains公司开发的开发软件**对wsl的支持**更是完善
- 在wsl中，cpu、gpu的**性能**比vmware好得多，vmware的核心数受限，无法使用全部的cpu核心（与windows系统分配资源）

- wsl2可以与vmware共存而不产生冲突

甚至，在wsl2中进行机器学习，比在windows下**效率更高**（在cpu、gpu性能几乎相同的情况下，linux系统的性能更好）[Wsl2 Cuda性能测试_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV16r4y1H77n/?spm_id_from=333.788.recommend_more_video.-1&vd_source=104ff9cc1b7010d178a8d3c0d37be81e)

## 启用WSL

1. 在windows自带的搜索中找到**Windows功能**![image-20221120233903330](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221120233903330.png)

2. 向下翻页，打开`适用于Linux的Windows子系统`和`虚拟机平台`选项，接下来按照要求重启电脑![image-20221120233954234](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221120233954234.png)
3. 重启后使用`wsl_update_x64.msi`程序**更新wsl至wsl2**，直接点击`next`即可

## 在WSL中安装Ubuntu

> 这一步需要导入的包已经为你们提供，但是直接导入会导致无法在windows终端中直接使用`ubuntu`命令来进入ubuntu环境，所以后续需要再自行在微软商店中安装一次ubuntu来开启这个命令

1. 打开windows下的终端命令行，输入如下指令，等待完成即可
    ```cmd
    wsl --import <分发名> <想要将ubuntu安装至的目录> <所下载的ubuntu导入包> --version 2
    ```
	- 比如我的导入命令为：`wsl --import UbuntuTutorial D:/Ubuntu D:/Ubuntu/export.tar --version 2`
	- `Ubuntu`：你想要导入的分发版命名，可以自定义
	- **注意同时要将`<>`替换**，后面命令中的替换方法也一样
	
2. 安装完成后，使用`wsl --list -v`命令就可以看到刚刚安装的Ubuntu环境，并且wsl的版本为2![image-20221120235804338](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221120235804338.png)

    ## 进入Ubuntu环境

    1. 重新开启终端![image-20221125193101974](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221125193101974.png)
    2. 在这里就可以看到刚刚装好的wsl下的ubuntu环境了

    ## ubuntu环境的基本配置

1. 输入指令`passwd root`，设置root用户密码![image-20221122233130180](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221122233130180.png)

> 密码需要输入两次，并且输入的密码会被隐藏，并不是没有输入

> root用户是超级管理员，拥有linux系统的最高权限，正常使用时候我们不使用root用户对系统进行操作，但你也可以在普通用户的模式下，随时切换到root用户或是使用sudo来进行更高权限的操作

2. **添加一个自己的用户**：`adduser <你需要新建的用户名>`![image-20221122233434698](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221122233434698.png)

> 在linux的使用中，尽可能地避免直接使用root用户（因为root用户的权限较高，避免root用户误操作带来的损失，比如`rm -rf`），使用普通用户也不需要担心权限不够的问题，我们可以通过sudo命令来解决

3. 删除用户（一个我原本创建的用户）：`userdel -r jiunian`

4. **将用户添加到sudo组**中：`usermod -G sudo <用户名>`

> 将普通用户添加到sudo组后，可以允许普通用户执行一些或全部的root用户的命令，比如使用apt命令安装软件时，修改文件权限时，都需要用到sudo命令，这样无需切换至root用户，也可以进行一些root用户的操作

5. 接下来我们就可以使用`su <用户名>`命令来切换到刚刚创建的用户了，接下来的操作都在这个用户下进行操作

   >  同时在其他用户的环境下，也可以使用`su root`或`sudo su`来进入root用户的操作环境

## 设置默认登录用户

> 现在进入wsl中的ubuntu环境时的默认用户为root用户，为了后续方便使用，我们需要将登陆时的默认用户更改为我们新创建的用户

1. 输入命令：`sudo vim /etc/wsl.conf`以进入vim编辑器，创建一个`wsl.conf`并且进行编辑
2. 敲击`i`键进入编辑模式，输入以下内容

```
[user]
default=<你的用户名>
```

3. 输入完成后按下`esc`键退出编辑模式，并且输入命令`:wq`保存并推出vim环境

> vim是ubuntu中自带的一个命令行文本编辑器，是一个非常古老的东西，操作起来比较复杂，但是也是一个必备的工具，这里只简单讲解一下简单的使用，也足够使用了
>
> - 当我们使用`vim`命令时，我们进入的是vim的命令模式，在这个模式下，我们可以通过命令的方式来进入其他的模式
>   - `i`：进入编辑模式
>   - `:w`：保存当前的文件
>   - `:q`：退出vim
>   - `:wq`：保存并退出
>   - `:q!`：强制退出vim（不保存更改）

## 更换镜像源

> 由于ubuntu官方的服务器在国外，为了提高下载软件的速度，我们可以使用国内的镜像源来替代ubuntu的官方服务器

1. 备份镜像源设置文件

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

2. 编辑镜像源设置文件

```bash
sudo vim /etc/apt/sources.list
```

3. 在命令模式下，使用方向键**将光标移动到文本文件开头**，直接输入`dG`删除文件中的全部内容，删除过后，将以下内容全部粘贴到文件中，然后输入`:wq`保存并退出退出vim编辑环境

```
deb https://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
# deb https://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
```

4. 运行命令：`sudo apt update`进行更新
5. 尝试安装应用：`sudo apt install gedit`

> gedit是ubuntu下的一个拥有图形界面的编辑器，
>
> 安装其他应用时同理，但部分应用的安装需要手动进行，具体的过程在对应的官网上都会给出，按照所给出的命令一步步安装也可以很快完成

## Windows中的设置

### 在windows的文件管理器中添加wsl

- 打开windows文件管理器，在地址栏输入`\\wsl$`访问wsl中的文件系统，在这里双击就可以直接打开ubuntu中的文件系统了
- 为了后续方便进入这个文件系统，我们将其映射为盘符或固定到快速访问![image-20221124002003637](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221124002003637.png)
- 对于文件的部分操作我们可以直接在windows下进行

## 图形化界面连接

要在windows下连接至wsl中打开的软件的图形界面，我们需要用到X-Server，所选择的X-Server有两种选择（以下方法选择一种即可）：

1. **法一：使用集成终端MobaXterm（推荐：无需手动配置、在窗口下方可以看到资源使用信息、在窗口右侧就可以直接看到当前打开的目录文件）**
   1. 下载`MobaXterm`（同样的，可以在群文件中找到）：[MobaXterm Xserver with SSH, telnet, RDP, VNC and X11 - Download (mobatek.net)](https://mobaxterm.mobatek.net/download.html)
   2. 正常安装即可
   3. 安装后打开`MobaXterm`，你可以看到刚刚添加的WSL-Ubuntu已经出现在这里了![image-20221123000242837](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221123000242837.png)
   4. 法二：设置`Setting-X11-X11 remote access`为`full`![image-20221124231855324](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221124231855324.png)
2. 自行下载VcXsrv（稍麻烦，可以直接使用第一种方法）：
   1. 官网（可能需要魔法，你可以在群文件中找到它）：https://sourceforge.net/projects/vcxsrv/
   2. 安装：按照默认设置安装即可
   3. 运行X-Server：
      1. 打开`XLaunch`
      2. 将`Display number`修改为 `0`
      4. 一直点击`下一步`即可

> 注：在最后一个页面，我们可以选择保存当前的配置文件到桌面，后续需要打开X-Server时，就无需再次进行配置，直接通过保存下的配置文件即可打开X-Server![image-20221122235847420](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221122235847420.png)

### Ubuntu中的gui连接配置

接下来**在Ubuntu环境中进行配置（必须做）**：

1. 运行命令：`vim ~/.bashrc`，进入vim编辑器环境对`~/.bashrc`文件进行编辑

> `~`：是当前用户的默认工作目录
>
> `.bashrc`：在每次打开bash命令行时，都会将其中的shell脚本运行一遍，因此，我们将指令添加到这个文件中的目的就是在每次打开命令行的时候都执行一个连接到X-Server的命令，以此实现自动连接的功能

2. 按下`i`键进入编辑模式，使用方向键将光标移动到文件的**最后一行**，将以下内容添加至文件中（直接使用右键进行粘贴，并且在弹出的窗口中设置右键为粘贴功能）

```bash
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
```

​		然后按下`esc`退出编辑模式，直接输入命令`:wq`并敲击回车，保存并退出vim环境，在命令行中输入`source ~/.bashrc`更新`.bashrc`中的内容

3. 测试：运行命令`gedit test.txt`，看到如下界面则说明图形化安装成功（**注意必须在windows中开启X-Server服务**）![image-20221124001027384](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221124001027384.png)

> 如果安装完gedit后，可以在windows的开始菜单栏中看见`Text Editor`，你也可以尝试打开![image-20221124112348868](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221124112348868.png)
>
> 这是微软在wsl2中添加支持的图形化界面，使用的是xrdp进行连接，也就是微软的远程连接服务来连接到wsl中的图形界面，但相比自己配置的X-Server，不够稳定，经常遇到打不开的情况

## 安装中文字体

1. 生成locale配置文件：

```bas
sudo locale-gen
locale
```

2. 使用windows中的字体

```bash
sudo apt install fontconfig
sudo vim /etc/fonts/local.conf
```

将以下内容粘贴到`local.conf`文件中，输入命令`:wq`后退出

```
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <dir>/mnt/c/Windows/Fonts</dir>
</fontconfig>
```

3. 测试：再次打开刚刚的图形化界面输入`gedit test.txt`，复制一段中文文本，查看效果![image-20221124112105047](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221124112105047.png)

> 安装中文字体是为了让图形界面中的中文显示正常，但还是无法在其图形界面中使用中文输入法，如果有需要，可以自行安装中文输入法

## 配置Java环境

> 复制文件的操作可以直接在windows中的文件管理器中完成

1. 创建`rcrs`目录：`mkdir ~/rcrs`
2. 将提供的`zulujdk17.tar.gz`拖到`rcrs`目录中

3. 解压压缩包，删除压缩包，重命名文件夹

```bash
cd ~/rcrs
tar -xvzf zulujdk17.tar.gz
rm zulujdk17.tar.gz
mv ./zulu17.34.19-ca-jdk17.0.3-linux_x64/ ./zulujdk17
```

4. 设置java环境变量
   1. 使用命令`vim ~/.bashrc`对`.bashrc`文件进行编辑
   1. 在该文件的最后添加以下文本(注意替换`<用户名>`)
   
    ```bash
    export JAVA_HOME="/home/<用户名>/rcrs/zulujdk17"
    export PATH=$JAVA_HOME"/bin:"$PATH
    ```

		3. `source ~/.bashrc`更新`bashrc`文件
		3. 使用`which java`查看java安装目录，使用`java`，出现命令提示，则配置完成

## 使用VSCode连接WSL

1. 在Windows端的VSCode中安装插件：`WSL`![image-20221124215657373](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221124215657373.png)

2. 打开远程资源管理器，并且选择WSL Targets，在这里就可以看到你安装的WSL环境了![image-20221124215751652](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2Fimage-20221124215751652.png)

3. 点击对应分发版旁的`Connect To WSL`即可连接，并且打开了一个连接至WSl中的窗口

### VSCode中的Java环境配置

1. 在拓展页搜索java，安装插件集合`Extension Pack for Java`（**注意要安装到WSL中**，而不是安装到本地机器）

2. 安装后，等待一会，如果前面的环境变量设置正确，系统会自动为你设置

3. 完成后打开一个工作目录，进行测试

   1. 创建文件`test.java`（设置正确的话，这里会为你自动补全代码）
   2. 输入代码

   ```java
   package javatest;
   
   public class test {
       public static void main(String[] args) {
           System.out.println("hello world");
       }
   }
   ```

   3. 点击右上角三角符号，运行代码，命令行输出`hello world`

> 在windows中的vscode的java开发环境配置方式类似，设置好java的环境变量就好了
