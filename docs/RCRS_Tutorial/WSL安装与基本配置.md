# WSL安装与基本配置

[TOC]

## 什么是WSL

WSL(Windows Subsystem of Linux)，是一个运行在windows上的linux子系统，可以让开发人员在windows上直接运行linux的环境，包括大多数的命令行工具、使用工具和应用程序，且不**会产生传统虚拟机的开销或双系统风险**

WSL是基于微软开发的虚拟机平台Hyper-V，同样是虚拟机，**相对VMware或其他虚拟机平台有什么优势呢**？

- 在文件系统上，可以直接与windows互通，可以在windows下打开wsl中的文件，可以在wsl中使用windows文件
  - 在ubuntu中的mnt（外部挂载设备）目录访问windows中的文件
  - 在windows中通过`\\wsl$`访问wsl中的文件，在各种软件中可以直接访问wsl中的文件，jetbrains公司开发的开发软件对wsl的支持更是完善
- 在wsl中，cpu、gpu的性能比vmware好得多，vmware的核心数受限，无法使用全部的cpu核心（与windows系统分配资源）

- wsl2可以与vmware共存而不产生冲突

甚至，在wsl2中进行机器学习，比在windows下效率更高（在cpu、gpu性能几乎相同的情况下，linux系统的性能更好）[Wsl2 Cuda性能测试_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV16r4y1H77n/?spm_id_from=333.788.recommend_more_video.-1&vd_source=104ff9cc1b7010d178a8d3c0d37be81e)

## 启用WSL

1. 在windows自带的搜索中找到**Windows功能**![image-20221120233903330](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221120233903330.png)

2. 向下翻页，打开`适用于Linux的Windows子系统`和`虚拟机平台`选项，接下来按照要求重启电脑![image-20221120233954234](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221120233954234.png)
3. 重启后使用`wsl_update_x64.msi`程序更新wsl至wsl2，直接点击`next`即可

## 在WSL中安装Ubuntu

> 这一步需要导入的包已经为你们提供，但是直接导入会导致无法在windows终端中直接使用`ubuntu`命令来进入ubuntu环境，所以后续需要再自行在微软商店中安装一次ubuntu

1. 打开windows下的终端命令行，输入如下指令，等待完成即可

    ```cmd
    wsl --import Ubuntu <想要将ubuntu安装至的目录> <所下载的ubuntu导入包> --version 2
    ```

	- `Ubuntu`：你想要导入的分发版命名，可以自定义
	
2. 安装完成后，使用`wsl --list -v`命令就可以看到刚刚安装的Ubuntu环境![image-20221120235804338](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221120235804338.png)

3. 接下来在windows商店中下载ubuntu![image-20221121001258878](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221121001258878.png)

    - 下载的目的
      - 开启`ubuntu`指令，可以直接从windows终端通过该命令进入到ubuntu环境中
      - 后续修改默认登录用户需要用到该指令

    ## ubuntu环境的基本配置

1. 输入指令`passwd root`，设置root用户密码![image-20221122233130180](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221122233130180.png)

> 密码需要输入两次，并且输入的密码会被隐藏，并不是没有输入

> root用户是超级管理员，拥有linux系统的最高权限

2. 添加一个自己的用户：`adduser <你需要新建的用户名>`![image-20221122233434698](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221122233434698.png)

> 在linux的使用中，尽可能地避免直接使用root用户（因为root用户的权限较高，避免root用户误操作带来的损失，比如`rm -rf`），使用普通用户也不需要担心权限不够的问题，我们可以通过sudo命令来解决

3. 删除用户（一个我原本创建的用户）：`deluser jiunian`

4. 将用户添加到sudo组中：`usermod -G sudo <用户名>`

> 将普通用户添加到sudo组后，可以允许普通用户执行一些或全部的root用户的命令，比如使用apt命令安装软件时，修改文件权限时，都需要用到sudo命令，这样无需切换至root用户，也可以进行一些root用户的操作

5. 接下来我们就可以使用`su <用户名>`命令来切换到刚刚创建的用户了，接下来的操作都在这个用户下进行操作

   >  同时在其他用户的环境下，也可以使用`su root`或`sudo su`来进入root用户的操作环境

## 图形化界面连接

要在windows下连接至wsl中打开的软件的图形界面，我们需要用到X-Server，所选择的X-Server有两种选择（以下方法选择一种即可）：

1. 自行下载VcXsrv：
   1. 官网（可能需要魔法，你可以在群文件中找到它）：https://sourceforge.net/projects/vcxsrv/
   2. 安装：按照默认设置安装即可
   3. 运行X-Server：
      1. 打开`XLaunch`
      2. 将`Display number`修改为 0
      3. 一直点击`下一步`即可

> 注：在最后一个页面，我们可以选择保存当前的配置文件到桌面，后续需要打开X-Server时，就无需再次进行配置，直接通过保存下的配置文件即可打开X-Server![image-20221122235847420](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221122235847420.png)

2. 使用终端中集成的X-Server
   1. 下载`MobaXterm`（同样的，可以在群文件中找到）：[MobaXterm Xserver with SSH, telnet, RDP, VNC and X11 - Download (mobatek.net)](https://mobaxterm.mobatek.net/download.html)
   2. 正常安装即可
   3. 安装后打开`MobaXterm`，你可以看到刚刚添加的WSL-Ubuntu已经出现在这里了![image-20221123000242837](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221123000242837.png)
   4. 设置`Setting-X11-X11 remote access`为`full`![image-20221123000411871](https://raw.githubusercontent.com/alwaysmissin/picgo/main/image-20221123000411871.png)

接下来在Ubuntu环境中进行配置：

1. 
