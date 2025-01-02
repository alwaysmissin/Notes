# FIlter
- Filter也属于Servlet规范
- 开发步骤:
	- 新建类实现Filter接口，然后实现方法：
		- `init()`
		- `doFilter()`
		- `destory()`
	- 配置Filter：`@WebFilter()`
> 配置过程中同样可以使用通配符
- 过滤器链：
	- 如果采用注解方式进行配置，则过滤器链的拦截顺序是按照**全类名的先后顺序**排序的
	- 如果采用的是xml方式进行配置，则按照**配置的先后顺序**进行排序