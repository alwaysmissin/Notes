# initial&always
## initial
- `initial`语句从0时刻开始执行，只执行一次
- 多个`initial`语句之间是**互相独立**的
- 如果`initial`块内包含多个语句，需要使用关键字`begin`和`end`组成一个块语句
- 如果`initial`块内只有一条语句，关键字`begin`和`end`可省略
> `initial`理论上来讲是不可综合的，多用于初始化、信号检测等
```verilog
`timescale 1ns/1ns  
   
module test ;  
    reg  ai, bi ;  
   
    initial begin  
        ai         = 0 ;  
        #25 ;      ai        = 1 ;  
        #35 ;      ai        = 0 ;        //absolute 60ns  
        #40 ;      ai        = 1 ;        //absolute 100ns  
        #10 ;      ai        = 0 ;        //absolute 110ns  
    end  
   
    initial begin  
        bi         = 1 ;  
        #70 ;      bi        = 0 ;        //absolute 70ns  
        #20 ;      bi        = 1 ;        //absolute 90ns  
    end  
   
    //at proper time stop the simulation  
    initial begin  
        forever begin  
            #100;  
            //$display("---gyc---%d", $time);  
            if ($time >= 1000) begin  
                $finish ;  
            end  
        end  
   end  
   
endmodule
```

## always
- `always`语句是**重复执行**的
- 一般用于仿真时钟的产生，信号行为的检测等
```verilog
`timescale 1ns/1ns

module test;
	parameter CLK_FREQ = 100;
	parameter CLK_CYCLE = 1e9;
	reg clk;
	initial clk = 1'b0;
	always # (CLK_CYCLE/2) clk = ~clk;
	always begin
		#10;
		if($time >= 1000) begin
			$finish;
		end
	end
	
endmodule
```