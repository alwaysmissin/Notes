///# GUI


## Java Swing 概述
1. 两个概念：
	1. 组件类
	2. 容器类
2. 基本知识点
	1. Component相关对象称为组件
	2. Container相关对象称为容器
	3. 向容器添加组件（`add()`方法）
	4. 使用`remove()`方法移除组件
![层级关系](https://s2.loli.net/2022/03/17/5Bgkn8tcSIeG37l.png)



## 窗口
- JFrame类的实例，即底层容器，被称为窗口
- 窗口默认被添加到显示器的屏幕上，不允许将一个窗口添加到另一个容器中
1. JFrame常用方法
	1. `JFrame()`创建一个无标题的窗口
	2. `JFrame(String s)` 创建一个标题为s的窗口
	3. `seBounds(int a, int b, int width, int height)` 设置初始位置和大小
	4. `setSize(int width, int height)`
	5. `setLocation()`
	6. `setVisible(boolean b)`
	7. `setResizable(boolean b)`
	8. `dispose()` 撤销当前窗口并释放资源
	9. `setExtendedState(int state)` 设置窗口的拓展状态
		1. `MAXIMIZED_HORIZ` 水平方向最大化
		2. `MAXIMIZED_VERT` 
		3. `MAXIMIZED_BOTH`
	10. `setDefaultCloseOperation(int operation)`关闭后贼oiudeckzo
		1. `DO_NOTHING_ON_CLOSE`
		2. `HIDE_ON_CLOSE`
		3. `EXIT_ON_CLOSE`
		4. `DISPOSE_ON_CLOSE` 退出并释放资源
2. 菜单条、菜单、菜单项
	1. 菜单条：只能向窗口添加一个菜单条`JMenuBar`
	2. 菜单：`JMenu`实例对象
	3. 菜单项：`JMenuItem`对象
	4. 嵌入子菜单使用`add(sth)` 方法
	5. 菜单上的图标
		1. 使用图标类Icon声明一个图标，再使用其子类创建一个图标，如`Icon icon = new ImageIcon("a.gif")`


## 常用组件与布局
- 都是JComponent的子类
1. 常用组件
	1. `JTextField`：单行文本文本框
	2. `JTextArea`：多行文本文本框
	3. `JButton`：按钮
	4. `JLabel`
	5. `JCheckBox`：复选框
	6. `JRadioButtom` ：单选框
	7. `JCombaBox`：下拉列表
	8. `JPasswordField`：密码框
2. 常用容器
	- Container的子类
    1. Jpanel面板
    2. JTabbedPane




[[处理事件]]