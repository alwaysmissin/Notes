# pip 离线安装依赖
使用 `pip download`, 可以下载目标包和其依赖至本地, 然后可以通过其他的存储介质转移到无法连接网络的设备上进行安装
- `--platform <arch>` 用于指定平台, 如 `--platform linux_aarch64`, 需要注意: 
	- 使用 `--platform` 的话需要结合其他参数(`--only-binary=:all:`)使用, 否则会报错, 看到了报错信息应该就知道如何使用了
		- 报错: `ERROR: When restricting platform and interpreter constraints using --python-version, --platform, --abi, or --implementation, either --no-deps must be set, or --only-binary=:all: must be set and --no-binary must not be set (or must be set to :none:).`
	- 需要确保下载的目标包有目标平台的实现
- `-d <directory>` 指定下载目录
使用举例: `pip download cos-python-sdk-v5 --platform linux_aarch64 --only-binary=:all: -d ./cos-python-sdk-packages`
目标设备上的安装方法: 
1. 解压至目标目录
2. 执行: `pip install cos-python-sdk-v5 --no-index -f cos-python-sdk-packages`