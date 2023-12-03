# Transactional Style C++ Testbench
## What are transactional testbench
- a testbench that uses transactions that provide an abstraction layer above directly assigning values to input pins and directly checking values of output pins of a DUT
- consists of:
	- transaction generator/**sequence**: a block that generates stimulus data for the DUT
	- **driver**: a block that drives the aforementioned data onto the DUT
	- **monitor**: a block that observes the DUT's outpus and generates result data packets
	- **scoreboard**: a block that collects various data packedts, then compares them for correctness
	- **coverage**: a block that collects various data packets, and calculates functional coverage
- drawbacks: **complexity**, slower to get basic simulations going
	- howerver: **flexibility** and **resuability**

## Basic transactional testybench block diagram
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230802104400.png)
### Transaction and trancation item
- trancation: a high-level data exchange operation
	- trancation item: a data packet(a collection of data or instructions)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230802104609.png)

### Transaction generator
- transaction generator: a class or block of code that generates transaction items
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230802104613.png)

### Drivers
- drivers: take [[transactional style C++ testbench#Transaction and trancation item|transaction item]] and manipulate the physical pins of an input interface with 1's and 0's to **drive data into a DUT**
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230802104907.png)

### Interface
- interface: a collection or a group of pins that are used for a specific function
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230802104948.png)

### Monitor
- monitor: observe what's happening on the interface
	- it is connected to an **output** interface, and check the output of the DUT
	- input: ensure that the associated driver drives the interface correctly
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230802105211.png)

### Scoreboard
- scoreboard: performs checks on the recieved transaction items to make sure the observed input stimuli result in correct outputs, and determines whether the testbench passes or fails
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230802105345.png)

### an analogy
[Verilator Pt.4: Modern transactional (UVM) style C++ testbench :: It's Embedded!#a roasty analogy](https://itsembedded.com/dhd/verilator_4/#a-roasty-analogy)
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/picgo%2F20230802105642.png)
