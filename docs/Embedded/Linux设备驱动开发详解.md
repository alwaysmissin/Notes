# Linux 设备驱动开发详解
## Linux 内核模块
### Linux 内核模块简介
模块的特点: 
1. 模块可以不用在编译时候加入内核, 可以控制内核的大小
2. 模块一旦被加载, 就与内核中的其他部分一样

### Linux 内核模块程序结构
- 内核模块的组成: 
	- **模块加载函数**
	- **模块卸载函数**
	- **模块许可证**
	- 模块参数
	- 模块导出符号
	- 模块作者等

### 模块加载函数
- 使用 `__init` 标识声明
	- 实质: `#define __init __attrubite__((__section__(".init.text")))`
	- 除了函数外, 数据也可以使用 `__initdata` 进行定义, 作为初始化时候使用的数据
- 使用 `module_init(MODULE_INIT_FUNCTION)` 指定
> [!note] 内核中的错误编码
> 内核中的错误编码是一个接近 0 的负值, 在 `<linux/errno.h>` 定义, 在错误的时候返回相应的错误编码是一个好习惯, 只有这样, 用户程序才可以利用 `perror` 等方法将其转换成有意义的错误信息字符串
- 在内核模块中, 可以使用 `request_module(module_name)` 来加载其他内核模块

### 模块卸载函数

### 模块参数
- 使用 `module_param(参数名, 参数类型, 权限)` 为模块定义一个参数
```c
static char *book_name = "linux device driver";
module_param(book_name, charp, S_IRUGO);

static int book_num = 0;
module_param(book_num, int, S_IRUGO);
```
- 用户需要在加载内核模块时候进行传递参数

## Linux 文件系统与设备文件
### Linux 文件系统
#### Linux 文件系统与设备驱动
## udev 用户空间设备管理
- udev 在用户态工作
- udev 利用设备加入或移除时候所发送的热插拔事件来工作, 在热插拔时, 设备的详细信息会由内核通过 `netlink` 套接字发送, 而 udev 会利用从内核收到的信息来创建设备文件节点

## 字符设备驱动
### Linux 字符设备驱动结构
#### `cdev` 结构体
```C
struct cdev {
	struct kobject kobj;  // 内嵌的kobject对象
	struct module *owner; // 所属模块
	const struct file_operations *ops; // 文件操作结构体
	struct list_head list;
	dev_t dev;            // 设备号
	unsigned int count;
};
```
- 获得主设备号和次设备号的方法: 
	- `MAJOR(dev_t dev)`
	- `MINOR(dev_t dev)`
- 通过主设备号与次设备号生成 `dev_t` 的方法: `MKDEV(int major, int minor)`
- 操作 `cdev` 结构体的方法: 
	- `void cdev_init(struct cdev *, const struct file_operations *);` -> 初始化 `cdev` 成员, 并建立 `cdev` 与 `file_operations` 之间的连接
	- `struct cdev *cdev_alloc(void);` -> 动态申请一个 `cdev` 内存
	- `void cdev_put(struct cdev *p);`
	- `int cdev_add(struct cdev *, dev_t, unsigned);` -> `cdev` 设备的注册, 通常发生在字符设备驱动模块的加载函数中
	- `void cdev_del(struct cdev *);` -> 设备的注销, 通常发生在字符设备驱动模块的卸载函数中

#### 分配和释放设备号
在调用 `cdev_add` 来向系统注册字符设备之前, 需要先调用 `register_chrdev_region()` 或 `alloc_chrdev_region()` 函数来向系统申请一个设备号, `register_chrdev_region()` 用于已知其实设备的设备号的情况, `alloc_chrdev_region()` 用于位置的情况, 会向系统动态申请未被占用的设备号
在注销时候, 需要使用 `unregister_chrdev_region` 释放设备号

#### `file_operations` 结构体
`file_operations` 结构体中几乎全是函数指针, 这些都是 linux 在进行 `open()`, `write()`, `read()`, `close()` 等系统调用时候最终被内核调用的函数.
```C
struct file_operations {
		struct module *owner;
		loff_t (*llseek) (struct file *, loff_t, int);
		ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
		ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
		ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
		ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
		int (*iopoll)(struct kiocb *kiocb, bool spin);
		int (*iterate) (struct file *, struct dir_context *);
		int (*iterate_shared) (struct file *, struct dir_context *);
		__poll_t (*poll) (struct file *, struct poll_table_struct *);
		long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
		long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
		int (*mmap) (struct file *, struct vm_area_struct *);
		unsigned long mmap_supported_flags;
		int (*open) (struct inode *, struct file *);
		int (*flush) (struct file *, fl_owner_t id);
		int (*release) (struct inode *, struct file *);
		int (*fsync) (struct file *, loff_t, loff_t, int datasync);
		int (*fasync) (int, struct file *, int);
		int (*lock) (struct file *, int, struct file_lock *);
		ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
		unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
		int (*check_flags)(int);
		int (*flock) (struct file *, int, struct file_lock *);
		ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
		ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
		int (*setlease)(struct file *, long, struct file_lock **, void **);
		long (*fallocate)(struct file *file, int mode, loff_t offset,
				  loff_t len);
		void (*show_fdinfo)(struct seq_file *m, struct file *f);
	#ifndef CONFIG_MMU
		unsigned (*mmap_capabilities)(struct file *);
	#endif
		ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
				loff_t, size_t, unsigned int);
		loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
					   struct file *file_out, loff_t pos_out,
					   loff_t len, unsigned int remap_flags);
		int (*fadvise)(struct file *, loff_t, loff_t, int);
	};
```
> [!note] `ioctl` 命令
> Linux 建议的定义 `ioctl` 命令方式: 
> ![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/20241109103642.png)
> 其中的设备类型字段为一个幻数, 用来标识一个设备
> 方向表示数据传送的方向, 可能为 `_IOC_NONE` (无数据传输), `_IOC_READ` (读), `_IOC_WRITE` (写), `_IOC_READ|_IOC_WRITE` (双向), 这里的数据传送方向是从应用程序的角度来看的
> 在内核中还定义了 `_IO()`, `_IOR()`, `_IOW()` 和 `_IOWR()` 这几个宏来辅助生成命令

#### Linux 字符设备驱动的组成
1. 字符设备驱动模块加载与卸载函数
2. 字符设备驱动的 `file_operations` 结构体中的成员函数
> 在成员函数的实现中, 经常需要用到 `copy_from_user()` 和 `copy_to_user()` 来完成内核空间与用户空间的内存复制
> 虽然内核空间可以访问用户空间的缓冲区, 但是在访问之前, 一般需要检查合法性, 通过 `access_ok(type, addr, size)` 来进行检查, 确保传入的缓冲区属于用户空间
> Linux 内核中的许多安全漏洞都是因为遗忘了这一检查引发的, 攻击者伪造一片内核空间的缓冲区地址传入系统调用的接口, 让内核对这个内核空间填充数据
![image.png](https://jiunian-pic-1310185536.cos.ap-nanjing.myqcloud.com/20241105164540.png)
