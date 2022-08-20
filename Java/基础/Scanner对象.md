# Scanner对象

## 一、Scanner对象

1. 通过Scanner类来获取用户的输入
2. 基本语法：`Scanner s = new Scanner(System.in);`
3. 通过Scanner类的`next()`与`nextLine()`方法获取输入的字符串，
4. 在读取前我们一般需要使用`hasNext()`与`hasNextLine()`判断是否还有输入的数据

```java
public class scanner方法 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("使用next方法接接受");

        //判断用户有没有输入字符串
        if(scanner.hasNext()){
            String str = scanner.next();
            System.out.println("输入的内容为" + str);
        }
        else{
            System.out.println("用户没有输入")
        }
        
        //凡是IO流的类如果不关闭就会一直占用资源
        scanner.close();
    }
}
```

5. 两种输入方式的区别
   1. next():
      1. 一定要读取到有效字符后才可以结束输入
      2. 对输入有效字符之前遇到的空白，next()方法会将其自动去掉
      3. 只有输入有效字符后才将其后面输入的空白作为分隔符或者结束符
      4. **next()不能得到带有空格的字符串**
   2. nextLine():
      1. 以Enter作为结束符，可以读取一行文本
      2. 可以获得空白

## 二、Scanner进阶使用

`Scanner对象名.hasNext数据类型`



