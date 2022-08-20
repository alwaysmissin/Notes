# OpenCV初探
## 头文件
- 见学习OpenCV 3 P19
- `cv`命名空间

## 显示图片
1. `cv::imread(图像文件名称, 加载图像类型)`
2. 图像文件名称包括文件路径
3. 加载图像类型参数
   1. $＜ 0$：加载原图，不做改变
   2. $=0$：作为灰度图像加载
   3. $> 0$: 作为RGB图像加载 （方便处理）
4. 显示图像（`namedWindos`与`imshow`)
   1. `namedWindow`：创建一个OpenCV窗口，自动创建与释放
      1. 用法：`cv::namedWindow("Windos title",WINDOW_AUTOSIZE)`
      2. `WINDOW_AUTOSIZE`：根据图像自动调整窗口大小，无法人为修改
      3. `WINDOW_NORMAL`：与QT集成时使用，允许修改窗口大小
   2. `imshow`：显示到指定的窗口
      1. 用法：`imshow("窗口名称",Mat对象)`
5. `cv::waikKey(0)`：告诉系统暂停并且等待键盘事件
	1. 如果参数$>0$，则等待相同的毫秒时间
	2. 如果参数$<0$，则无限等待至有按键按下
6. `destroyWindow()`：关闭窗口并且释放关联的空间

## 视频
1. 视频读取结构：`cv::VideoCapture`
	1. 包含了视频文件所有可读取的属性
	2. `cap.open(filepath)`：打开目录对应的视频文件
	3. `cap >> frame`：帧以流的方式读取

## 从摄像头读取
1. `VideoCapture`对磁盘上的文件和摄像头拥有一致的接口
2. `cap.open(CamreaID)`
	1. 如果仅一个摄像头连接，CameraID通常为$0$
	2. CameraID为$-1$时，随机选择

## 写入AVI文件
1. 将每一帧图像输入到`cv::VideoWriter`中
2. 写入完成后，使用`cv::VideoWriter.release()`写入文件