# SpinalHDL 学习日志
## 2024/4/19
- `case class` 与 `class` 之间的区别: 
	- 不需要使用 `new` 来实例化
- 在 spinalhdl 中, 建议使用 `case class`, 以减少代码量, 提高一致性
- 伴生对象: [Companion Objects | Scala Book | Scala Documentation](https://docs.scala-lang.org/overviews/scala-book/companion-objects.html)
	- declared in the same file as a `class`,  has the same name as the class
	- benefits
		- a companion object and its class can access each other’s private members (fields and methods)
		- Creating new instances without the `new` keyword

## 2024/4/20
[组件和层次结构 — SpinalHDL 文档](https://spinalhdl.github.io/SpinalDoc-RTD/zh_CN/SpinalHDL/Structuring/components_hierarchy.html)
- 若有多个参数, 最好使用专用的配置类, 可以在配置中添加功能以及对配置属性的要求

[Area — SpinalHDL 文档](https://spinalhdl.github.io/SpinalDoc-RTD/zh_CN/SpinalHDL/Structuring/area.html)
- 使用 `Area` 来定义一组信号/逻辑
```scala
class UartCtrl extends Component {
  ...
  val timer = new Area {
    val counter = Reg(UInt(8 bits))
    val tick = counter === 0
    counter := counter - 1
    when(tick) {
      counter := 100
    }
  }

  val tickCounter = new Area {
    val value = Reg(UInt(3 bits))
    val reset = False
    when(timer.tick) {          // Refer to the tick from timer area
      value := value + 1
    }
    when(reset) {
      value := 0
    }
  }

  val stateMachine = new Area {
    ...
  }
}
```

## 2024/4/22
> pipeline
- `Payload` 不是硬件数据/信号实例，而是用于检索流水线在节点中数据/信号的关键，并且流水线构建器随后将在节点之间的每次给定 `Payload` 出现时自动互连/流水线。