# Mat对象

## 一、Mat对象与IplImage

- 自动分配内存（是面向对象的数据结构）

- 分为两个部分：头部与数据部分

## 二、Mat对象使用

1. 常用：
   1. `void copyTo(Mat mat)`：完全拷贝到mat
   2. `void convertTo(Mat dst, int type);`：（转化目标，转化模式）
   3. `Mat clone()`：完全拷贝
   4. `int channels()`：返回图像的通道数
   5. `int depth()`
   6. `bool empty()`
   7. `uchar* ptr(i = 0)`
   7. 
2. 构造函数
   1. `Mat()`
   2. `Mat(int rows, int cols, int type)`
      1. 例：`Mat(3,3,CV_8UC3,Scalar(0,0,255));`
         1. 前两个数字分别表示长和宽
         2. `CV_8UC3`：
            1. 8表示每个通道占8位
            2. U表示无符号
            3. C表示char类型
            4. 3表示通道数目是3

   3. `Mat(Size size, int type)`

3. 使用cout输出Mat对象，会输出每一个像素点的RGB值
4. 复制：
   1. 部分复制： 一般情况下指挥复制Mat对象的头和指针部分，不会复制其他部分
      1. `Mat A = imread("filepath"); Mat B(A);`

   2. 完全复制：如果想把Mat对象的头部和数据部分一起复制，可以通过如下的两个API实现
      1. `Mat F = A.clone()`
      2. `Mat G; A.copyTo(G)`


## 三、Mat定义数组

1. 一般创建二维

2. 通过create方式实现

   ```C++
   Mat M;
   M.create(4,3,CV_8UC2);
   M = Scalar(127,127);
   cout << "M = " << endl << M << endl;
   uchar* firstRow = M.ptr<uchar>(0);
   printf("%d",firstRow);
   ```

3. 定义小数组(掩膜操作里使用过)

   1. ```C++
      Mat C = (Mat_<double>(3,3)<<0,-1,0,-1,5,-1,0,-1,0);
      cout << "C=" << endl << " " << C << endl << endl;
      ```



## 四、其他

1. `Mat::eye()`：使对角线上都是1，其他地方为0
2. `Mat::zeros()`：全为0

```C++
	Mat t = Mat::zeros(2, 2, CV_8UC1);
	cout << "t =" << endl << t << endl;
	Mat t1 = Mat::eye(t.size(), t.type());
	cout << "t1 = " << endl << t1;
```



