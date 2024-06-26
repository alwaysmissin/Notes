 - HTML基础
	
	  - **标记语言**而非编程语言
	  - 由一系列**element**组成
	
	  ## HTML
	
	  ### 元素详解
	
	  ![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20220906094458.png)
	
	  - **开始标签**（Opening tag）：
	    - 包含元素的名称（本例为 p->段落）
	    - 被大于号、小于号所包围
	      - 表示元素从这里开始或者开始起作用 —— 在本例中即段落由此开始。
	  - **结束标签**（Closing tag）：
	    - 与开始标签相似，只是其在元素名之前包含了一个斜杠
	      - 表示着元素的结尾 —— 在本例中即段落在此结束。
	  - **内容**（Content）：
	    - 元素的内容，本例中就是所输入的文本本身。
	  - **元素**（Element）：
	    - 开始标签、结束标签与内容相结合，便是一个完整的元素。
	    - 可以具有属性（Attribute）![](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20220906094747.png)
	      - `class`是**属性名称**，为元素提供一个标识名称，以便进一步为元素指定样式或进行其他操作时使用
	      - 一个空格，在属性和元素名称之间（如果已经有一个或多个属性，就与前一个属性之间有一个空格）。
	      - 属性名称，后面跟着一个$=$号。
	      - 一个属性值，由一对引号`""`引起来。
	
	  ### 嵌套元素
	
	  - 将一个元素嵌套于其他元素中
	  - 使用`<strong>content</strong>`对文本进行加粗
	  - 使用`<em>content</em>`将文本设为斜体
	  - 元素必须正确的开始和结束
	
	  ### 空元素
	
	  - 不含任何内容的元素(img元素)
	    - `<img src="image-path" alt="name">`
	    - 包含属性却没有结束标签
	
	  ### 文档详解
	
	  ```html
	  <!DOCTYPE html>
	  <html>
	    <head>
	      <meta charset="utf-8">
	      <title>My test page</title>
	    </head>
	    <body>
	      <img src="images/firefox-icon.png" alt="My test image">
	    </body>
	  </html>
	  ```
	
	  - `<!DOCTYPE html>`
	    - 文档类型
	    - 仅用于保证文档正常读取
	    - 不区分大小写
	  - `<html></html>` — `<html>` 元素
	    - 该元素包含整个页面的内容，也称作**根元素**。
	  - `<head></head>` — `<head>` 元素
	    - 该元素的内容对用户**不可见**
	    - 包含
	      - 面向搜索引擎的搜索关键字（keywords）
	      - 页面描述
	      - CSS 样式表
	      - 字符编码声明
	      - 等......
	  - `<meta charset="utf-8">` 
	    - 指定文档使用 UTF-8 字符编码
	  - `<title></title>` — `<title>` 元素
	    - 该元素设置页面的标题，显示在浏览器标签页上，也作为收藏网页的描述文字。
	  - `<body></body>` — `<body>` 元素
	    - 该元素包含期望让用户在访问页面时**看到的内容**
	    - 包括
	      - 文本
	      - 图像
	      - 视频
	      - 游戏
	      - 可播放的音轨
	      - 其他内容
	  - 注释：`<!--content-->`
	
	  ## 多媒体
	
	  - `<img src="image_path" alt="description">`
	    - `src`：图像文件路径
	    - `alt`：图像的描述内容
	      - 用于当图像不能被用户看见时显示
	      - 不可见的原因：
	        - 视觉障碍
	        - 错误导致无法显示
	  - `<video src="video_path" alt="description">`
	  - `<audio src="audio_path" alt="description">`
	
	  ## 标记文本
	
	  ### 标题
	
	  - `<h>content</h>`
	    - 共六级标题
	
	  ### 段落
	
	  - `<p>content</p>`
	
	  ### 列表
	
	  - 标记列表通常包括至少两个元素
	  - 常用的列表类型：
	    - 无序列表
	      - 使用`<ul>`元素包围
	    - 有序列表
	      - 使用`<ol>`元素包围
	
	  ## 链接
	
	  - `<a>content</a>`
	    - a->anchor
	  - 属性
	    - `href`：链接地址hyper refference
	    - `title`：超链接声明额外的信息，当树表置于其上时显示该信息
	    - `target`：指定连接如何呈现出来
	      - 在新标签页：`target = "_blank"`
	      - 原标签页
	
	
	  ## 表单
	
	  - 作用：收集数据，提交给服务器
	  - 语法：
	
	  ```HTML
	  <form action = "服务器地址" method = "请求方式" enctype = "数据格式">
	  	<!--表单项-->
	  	<input type = "submit" value = "提交按钮">
	  </form>
	  ```
	
	  - `type`：
	    - 文本框：`text`
	    - 密码框：`password`
	    - 隐藏框：`hidden`
	    - 日期框：`date`
	    - 单选：`radio`
	    - 多选：`checkbox`
	    - 文件上传：`file`
	  - `method`请求方式
	    - `get`：（默认）提交时，数据跟在url地址后
	    - post：提交时，数据在请求体内