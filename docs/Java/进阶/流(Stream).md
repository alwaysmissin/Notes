# 流(Stream)
- 与集合相比，流提供了一种可以让我们在更高的概念级别上指定计算任务的数据视图
- 通过使用流，我们可以说明想要完成什么任务，而不是说明如何去实现它

## 从迭代到流的操作
- 迭代器：一般使用遍历的方式，对每一个元素进行操作
	- 需要非常详细的指定操作的顺序
- 流：仅需描述需要做什么
	- 能够以想要的任何方式来进行调度，只要结果是正确的即可
	- 仅将`stream`修改为`parallelStream`就可以让流库以并行的方式来执行过滤和计数
```java
// 使用迭代
int count = 0;
for (String w:words){
	if (w.lenght() > 12) count ++;
}

// 使用流
int count = words.stream()
	.filter(w->w.length()>12).count();

// 使用并行
int count = words.parallelStream()
	.filter(w->w.length()>12).count();
```
- **流**与**集合**
	- 共同点
		- 都可以让我们**转换**和**获取**数据
	- 不同点
		- 流并不存储其元素
			- 元素可能存储在底层的集合中
			- 或者是按需生成
		- 流的操作不会修改其数据源
			- 在filter方法中，流不会移除元素，而是生成一个新的流（不包含被过滤掉的元素）
		- 流的操作是尽可能惰性执行的
			- 直至需要其结果时，操作才会执行
- 流的工作流程
	- 创建一个流
	- 指定将初始流转换为其他流的中间操作
	- 应用终止流，从而产生结果

## 流的创建
- 使用Collection接口的stream方法将任何集合转换为一个流
- 如果有一个数组，可以使用静态的`Stream.of`方法
	- 示例：`Stream<String> words = Stream.of(contents.split(" "));`
	- `Stream.of`方法具有可变长参数，我们可以使用任意数量引元的流
		- `Stream<String> song = Stream.of("gentle", "down", "the", "stream");`
- 为了创建一个不包含任何元素的流，可以使用静态的`Stream.empty`方法
	- `Stream<String> empty = Stream.empty();`
- `Stream`接口中的两个用于创建无限流的静态方法
	- `generate`
		- 生成
		- `generate`方法接受一个**不包含任何引元的函数**（即`Supllier<T>`接口的对象）
		- 无论何时，只需要一个流类型的值，该函数就会被调用以产生一个这样的值
		- 产生常量的流：`Stream<String> echos = Stream.generate(() -> "Echo");`
		- 一个产生随机数的流：`Stream<Double> randoms = Stream.generate(Math::random)`
	- `iterate`
		- 产生一个顺序序列
		- `iterate`方法接受一个“**种子**”值，以及一个**函数**（为`UnaryOperation<T>`）
		- 递增：`Stream<Integer> integers = Stream.iterate(BigInteger.ZERO, n -> n.add(BigIngeter.ONE))`
		- 如果要产生一个有限序列，则需要添加一个谓词来描述迭代该如何结束
			- `Stream<BigInteger> integers = Stream.iterate(BigInteger.ZERO, n->n.compareTo(new BigInteger("100000")), n->n.add(BigInteger.ONE)`
			- 只要谓词拒绝了某个迭代产生的值，这个流即结束
- `Stream.ofNullable`
	- 如果对象**为null**，那么这个流的长度为**0**
	- 如果对象**不为null**，那么这个流的长度为**1**，且仅包含**该对象**
- 其他API可以产生流的方法
	- `Pattern.splitAsStream`
		- 按照某个正则表达式来分割一个`CharSequence`对象
		- `Stream<String> words = Pattern.complie("\\PL+").splitAsStream(contents)`
	- `Scanner.tokens`
		- 产生一个扫描器的符号流
		- `Stream<String> words = new Scanner(contents).tokens()`
	- `Files.lines`
		- 返回包含文件中所有行的Stream
		- `Stream<String> lines = File.lines(path))`
## filter、map和flatmap方法
### filter方法
- `filter`转换回产生一个新流，他的元素与某种条件相匹配
- 将一个字符串流转换为只包含长单词的另一个流：
	- `filter`的引元是`Predicate<T>`，即从`T`到`boolean`的函数
```java
List<String> words = "...";
Stream<String> longwords = words.stream.filter(w->w.length() > 12);
```
### map方法
- 使用`map`方法，可以让我们按照某种方式来转换流中的值
	- 使用`map`时，会有一个函数应用到每一个元素上，并且其结果时包含了应用该函数后所产生结果的流
- 将单词转换为小写：
```java
Stream<String> lowerwords = words.stream.map(String::lowerCase);
```
- 通常来说，也可以使用[Lambda](Lambda表达式.md)表达式替换
```java
Stream<String> firstletter = words.stream.map(s->s.subString(0,1));
```
### flatmap方法
 ```java
 public static Stream<String> codePoints(String s){
	 var result = new ArrayList<String>();
	 int i = 0;
	 while(i < s.length()){
		 int j = s.offsetByCodePoints(i,1);
		 result.add(s.subString(i,j));
		 i = j;
	 }
	 return result.stream();
 }
 ```
- 为了**摊平**(降维)单个流，可以使用`flatmap`方法
```java
Stream<String> flatResult = words.stream.flatmap(w->codePoints(w));
```

## 抽取子流和组合流
- `stream.limit(n)`
	- 会返回一个新的流
	- 在`n`个元素后结束
	- 适用于裁剪无限流的尺寸
	- `Stream<Double> randoms = Stream.generate(Math::random).limit(100);`
- `stream.skip(n)`
	- 会返回一个新的流
	- 丢弃前`n`个元素
	- `Stream<String> words = Stream.of(contents.split("regex").skip(1);`
- `stream.takeWhile(predicate)`
	- 会在谓词为真时获取流中的所有元素
	- 收集所有数字字符
		- `Stream<String> nums = codePoints(str).takeWhile(s->"0123456789".contains(s));`
- `dropWhile`
	- 与`takeWhile`相反，在条件为真时丢弃元素
	- 并产生一个由第一个使该条件为假的字符开始的所有元素构成的流
	- `Stream<String> withoutInitialWhiteSpace = codePoints(str).dropWhile(s->s.trim().length() == 0);`
- `static concat`
	- 连接两个流
	- 第一个流不应该是无限的，否则永远不会处理第二个流

## 其他的流转换
- `distinct`
	- 返回一个流，他的元素是从原有流中产生的，按同样的**顺序剔除重复的元素**后产生的
- `sort`
	- 排序
- `peek`
	- 产生另一个流，元素与原流中的元素相同，但是每次获取一个元素时，都会调用一个函数
	- 适合用于调试