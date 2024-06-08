# StringBuffer和StringBuilder

## 一、StringBuilder

1. 速度快（建议使用）
2. 与StringBuffer的区别：非线程安全
3. 构造器
   1. 
4. 方法：
   1. `append(String s)`：在尾部添加s字符串
   2. `insert(int location, String s)`：在location位置添加s字符串
   3. `delete(int begin, int end)`：删除从begin开始到end的字符串



## 二、StringBuffer

1. 方法
   1. `append(String s)`：在尾部添加s字符串
   2. `insert(int location, String s)`：在location位置添加s字符串
   3. `delete(int begin, int end)`：删除从begin开始到end的字符串
   4. `reverse()`：将字符串翻转
   5. `replace(int begin, int end, String s)`：从begin开始到end替换为s字符串
   6. `capacity()`：返回容量
   7. `charAt(int index)`：返回index处的字符
   8. 