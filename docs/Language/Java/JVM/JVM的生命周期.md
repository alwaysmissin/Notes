# JVM的生命周期
## 虚拟机的启动
Java虚拟机的启动是通过引导类加载器（bootstrap class loader）**创建一个初始类**来完成的，这个类是有虚拟机的具体实现指定的

## 虚拟机的执行
- 一个运行中的Java虚拟机有着一个清晰地任务：**执行Java程序**
- 程序开始执行时他才运行，程序结束时停止
- **执行一个所谓的Java程序的时候，真真正正在执行的是一个叫做Java虚拟机的进程**

> `jps`查看当前运行的Java进程

## 虚拟机的退出
以下几种情况：
- 程序正常执行结束
- 程序在执行的过程中遇到了异常或错误而异常终止
- 由于操作系统出现错误而导致Java虚拟机进程终止
- 某线程调用Runtime类或System类的exit方法，或Runtime类的halt方法，并且Java安全管理器也允许这次exit或halt操作
- 除此之外JNI(Java Natice Interface)规范描述了用JNI Invocation API来加载或卸载Java虚拟机时，Java虚拟机的退出情况