---
tags:
  - ysyx
  - 段错误
  - 调试
  - npc
  - gdb
---
# 在npc模拟中的出现 segmentation fault的调试方法
这两天遇到了两次的 segmentation fault, 第一次通过在程序中 `printf` 找到了导致段错误的位置, 第二次则完全没有头绪, 最后使用了 gdb 才找到
在 Makefile 中需要开启在 `CFLAGS` 中添加 ` -g ` 选项, 生成调试信息, 然后使用 gdb 运行生成的可执行文件, 在启动 gdb 后使用 `set args ...` 设置参数信息, 运行, 然后就可以看到程序在什么时候出现的 segmentation fault