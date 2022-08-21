# Java 流(Stream)、文件(File)和IO

# 一、IO

1. Java.io包几乎包含了所有操作输入输出的类
2. 支持的格式：基本类型、对象、本地化字符集

## 二、BufferedReader(从控制台读取字符串)

1. 创建`BufferedReader`的基本语法：`BufferedReader br = new BufferedReader(new InputStreamReader(System.in));`
2. 常用方法
   1. `int read() throws IOException`：读取int长度
   2. `String readLine() throws IOException`：读取一行字符

## 三、读写文件

1. 两个重要流：`FileInputStream` `FileOutputStream`

2. `FileInputStream`

   1. 构造方法：

      1. `InputStream f = new FileInputStream("文件路径")`

      2. 先使用一个File对象

         ```java
         File f = new File("文件路径");
         InputStream in = new File InputStream(f);
         ```

   2. 方法：

      1. `void close() throws IOException`
      2. `void finalize() throws IOException`
      3. `int read(int r) throws IOException`：读入r字节数的数据，返回下一字节数据，如果已经到结尾则返回-1
      4. `int read(byte[] r) throws IOException`：从输入流读取r.length长度的字节，返回读取的字节数，如果是文件结尾则返回-1
      5. `int avaliable() throws IOException`：返回下一次对此输入流调用的方法可以不受阻塞的从此输入流读取的字节数
   
3. `FileOutputStream`

   1. 构造方法类似
   2. 如果目标文件不存在，则自动创建
   3. 方法也类似（read变write）


## 四、文件字节输入流
#### 四个基本步骤
1. 设定输入流的源
2. 创建指向源的输入流
3. 让输入流读取源中的数据
4. 关闭输入流

## 四、实例