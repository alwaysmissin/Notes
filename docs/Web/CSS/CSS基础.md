# CSS基础
- 层叠样式表是为网页添加样式的代码
	- 是一门样式表语言
	- 可以使用CSS来选择性的为HTML元素添加样式
- 使用`<link href = "css-path" rel = "stylesheet">`添加

## CSS规则集详解
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20220906124049.png)
- **选择器**（Selector）
	- HTML 元素的名称位于规则集开始
		- 选择一个或多个需要添加样式的元素（在这个例子中就是 p 元素）
		- 要给不同元素添加样式只需要更改选择器就行了
- **声明**（Declaration）
	- 一个单独的规则
		- 如 `color: red; `用来指定添加样式元素的属性
- **属性**（Properties）
	- 改变 HTML 元素样式的途径。（本例中 color 就是 `<p>` 元素的属。）
	- CSS 中，由编写人员决定修改哪个属性以改变规则
- **属性的值**（Property value）
	- 在属性的右边，冒号后面即属性的值，它从指定属性的众多外观中选择一个值
- 注意其他重要的语法
	- 每个规则集（除了选择器的部分）都应该**包含在成对的大括号里**（{}）
	- 在每个声明里要用冒号`:`将属性与属性值分隔开
	- 在每个规则集里要用分号`;`将各个声明分隔开
- 如果需要同时修改多个属性，则使用分号隔开
- 如果需要同时修改多个类别的元素，则使用都好隔开
```css
p, h1, h2{
	color:red;
	width:500px;
}
```

## 不同类型的选择器
- 元素选择器：
	- 选择所有指定的HTML元素
- ID选择器：
	- 具有**特定ID**的元素
		- 单一HTML页面中，每个ID只对应一个元素
	- `#my-id`选择id为`my-id`的元素
- 类选择器：
	- 具有特定类的元素
		- 单一页面中，一个类可以有多个实例
	- `.my-class`选择`class="my-class"`
- 属性选择器：
	- 拥有特定属性的元素
	- `img[src]`选择`<img src = "image-path">`而非`<img>`
- 伪类选择器
	- 特定状态下的指定元素
	- `a:hover`仅在鼠标指针悬停在连接上时选择`a`

## 一切皆盒子
- 页面中的HTML元素可以被看作为若干盒子
- CSS的布局主要就是基于盒模型的，每个块都有以下属性
	- `padding`：内边距，围绕着内容的空间
	- `border`：边框，紧接着内边距的线
		- 边框像素值
		- 边框类型：实线/虚线
		- 颜色
	- `margin`：外边距，围绕元素外部的空间
		- 第一个值代表元素的上下方
		- 第二个值代表元素的左右
		- `auto`自动
![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20220906193115.png)
- 同时使用了：
	- `width`：元素的宽度
	- `background-color`：元素内容和内边距底下的颜色
	- `color`：元素内容（文本等）的颜色
	- `text-shadow`：为元素内的文本设置阴影
		1. 设置水平偏移
		2. 设置垂直偏移
		3. 设置模糊半径——值越大阴影越模糊
		4. 设置阴影基色
	- `display`：设置元素的显示模式

### 更改页面颜色
```css
html{
	background-color: #66ccff;
}
```
### 文档体格式设置
```css
body{
	width: 600px;
	margin: 0 auto;
	background-color: #FF9500;
	padding: 0 20px 20px 20px;
	border: 5px solid black;
}
```
### 定位页面主题标并添加样式
```css
h1{
	margin: 0;
	padding: 20px 0;
	color: #00539F;
	text-shadow: 3px 3px 1px black;
}
```
### 图片居中
```css
img{
	display: block;
	margin: 0 auto;
}
```
