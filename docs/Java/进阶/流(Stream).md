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