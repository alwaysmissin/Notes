# 一个安装Nvidia驱动后无法回到图形界面的问题
> Ubuntu在安装Nvidia驱动后，重新使用lightdm无法回到图形化界面中，以下是一种解决方法，由于带来了许多时间上的浪费，特此记录。

通过上面的路径（方式）`Advanced options for ubuntu`-`*-recovery mode`-`root Drop to root shell prompt`，在修复模式下，进入root，直接删除`/etc/X11/xorg.conf`文件
```shell
sudo rm /etc/X11/xorg.conf
```
重启后就可以重新进入图形界面

> 可能在tty命令行下，也可以？没有尝试过

- 出现该问题的原因：安装Nvidia驱动后，出现独显和集显冲突的问题或者是驱动的安装不匹配
  - 具体见参考文章：[安装Nvidia GPU专属驱动后Xorg的变化](https://zhuanlan.zhihu.com/p/33983810?utm_id=0)


> 解决方案来源：[ubuntu无法进入图形界面 怎么搞定?](https://www.zhihu.com/question/499184842?utm_id=0)
