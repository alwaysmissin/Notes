# 自定义映射resultMap

 - 字段名和属性名不一致的情况，如何处理映射关系
	 1. 为查询的字段设置别名，和属性名保持一致
	 2. 当字段符合MySQL的要求使用`_`，而属性符合java的要求使驼峰，此时可以在MyBatis的核心配置文件中设置一个全局置，可以自动将下划线映射为驼峰
	 3. `使用resultMap自定义映射处理`
## resultMap
- `resultMap`：设置自定义的映射关系
	- 属性
		- `id`：唯一标识
		- `type`：处理映射关系的实体类的类型
	- 元素：
		- `id`：处理主键和实体类中属性的元素关系
			- 属性：
				- `property`：设置映射关系中**实体类中的属性名**
				- `column`：设置映射关系中**表中的字段名**
		- `result`：处理普通字段和实体类中属性的元素关系
			- 属性：
				- `property`：设置映射关系中**实体类中的属性名**
				- `column`：设置映射关系中**表中的字段名**
		- `association`：设置多对一的映射关系
		- `collection`：设置一对多的映射关系

## 多对一映射处理
### 级联方式处理
```xml
<resultMap id="empAndDeptResultMapOne" type="Emp">  
    <id column="emp_id" property="empId"/>  
    <result column="emp_name" property="empName"/>  
    <result column="age" property="age"/>  
    <result column="gender" property="gender"/>  
    <result column="dept_id" property="dept.deptId"/>  
    <result column="dept_name" property="dept.deptName"/>  
</resultMap>
```
### association
- `association`：处理多对一的映射关系（**处理实体类类型的属性**）
	- 属性：
		- `property`：设置需**要处理映射关系的属性的属性名**
		- `javaType`：设置**要处理的属性类型**
```xml
    <resultMap id="empAndDeptResultMap" type="Emp">  
        <id column="emp_id" property="empId"/>  
        <result column="emp_name" property="empName"/>  
        <result column="age" property="age"/>  
        <result column="gender" property="gender"/>  
        <association property="dept" javaType="Dept">  
            <id column="dept_id" property="deptId"/>  
            <result column="dept_name" property="deptName"/>  
        </association>  
    </resultMap>  
<!--    Emp getEmpAndDeptByEmpId(@Param("empId")Integer empId);-->  
    <select id="getEmpAndDeptByEmpId" resultMap="empAndDeptResultMap">  
        select * from t_emp inner join t_dept on t_emp.dept_id = t_dept.dept_id where emp_id=#{empId}  
    </select>
```
### 分步查询
- `association`：处理多对一的映射关系（**处理实体类类型的属性**）
	- 属性：
		- `property`：设置需**要处理映射关系的属性的属性名**
		- `select`：设置分布查询的sql的唯一标识
		- `column`：将查询出的某个字段作为分布查询的sql的条件
```xml
<resultMap id="empAndDeptResultByStepMap" type="Emp">  
        <id column="emp_id" property="empId"/>  
        <result column="emp_name" property="empName"/>  
        <result column="age" property="age"/>  
        <result column="gender" property="gender"/>  
        <association property="dept" fetchType="eager"  
                     select="com.cjd.mybatis.mapper.DeptMapper.getDeptById"  
                     column="dept_id">  
        </association>  
    </resultMap>  
  
<!--    Emp getEmpAndDeptByStep(@Param("empId")Integer empId);-->  
    <select id="getEmpAndDeptByStep" resultMap="empAndDeptResultByStepMap">  
        select * from t_emp where emp_id = #{empId}  
    </select>
```
## 延迟加载
- 需要在`mybatis-config.xml`中添加设置标签
- `lazyLoadingEnabled`：
	- 延迟加载的全局开关
	- 特定关联关系中可通过设置`fetchType`属性来覆盖该项的开关状态
- `aggressiveLazyLoading`：
	- 开启时，任一方法的对用都会加载该对象的所有延迟加载属性

## 一对多映射处理
### collection
- `collection`：处理一对多的映射关系
	- 属性：
		- `property`：设置需要处理映射关系属性的属性名
		- `ofType`：设置`collection`标签所处的集合属性中存储数据的类型
```xml
<resultMap id="getDeptAndEmpByDeptIdMap" type="Dept">  
        <constructor>  
            <idArg column="dept_id" javaType="int"/>  
            <idArg column="dept_name" javaType="String"/>  
        </constructor>  
        <id column="dept_id" property="deptId"/>  
        <result column="dept_name" property="deptName"/>  
        <collection property="emps" ofType="Emp">  
            <id column="emp_id" property="empId"/>  
            <result column="emp_name" property="empName"/>  
            <result column="age" property="age"/>  
            <result column="gender" property="gender"/>  
        </collection>  
    </resultMap>  
<!--    Dept getDeptAndEmpByDeptId(@Param("deptId")Integer deptId);-->  
    <select id="getDeptAndEmpByDeptId" resultMap="getDeptAndEmpByDeptIdMap">  
        SELECT *  
        FROM t_dept                 LEFT JOIN t_emp                           ON t_dept.dept_id = t_emp.dept_id        WHERE t_dept.dept_id = #{deptId}    </select>
```
### 分步查询
- `collection`：处理多对一的映射关系（**处理实体类类型的属性**）
	- 属性：
		- `property`：设置需**要处理映射关系的属性的属性名**
		- `select`：设置分布查询的sql的唯一标识
		- `column`：将查询出的某个字段作为分布查询的sql的条件
```xml
<resultMap id="getDeptAndEmpByStepMap" type="Dept">  
        <constructor>  
            <idArg column="dept_id" javaType="int"/>  
            <idArg column="dept_name" javaType="String"/>  
        </constructor>  
        <id column="dept_id" property="deptId"/>  
        <result column="dept_name" property="deptName"/>  
        <collection property="emps"  
                    select="com.cjd.mybatis.mapper.EmpMapper.getEmpInTheSameDept"  
                    column="dept_id">  
        </collection>  
    </resultMap>  
<!--    Dept getDeptAndEmpByStep(@Param("deptId")Integer deptId);-->  
    <select id="getDeptAndEmpByStep" resultMap="getDeptAndEmpByStepMap">  
        select * from t_dept where dept_id=#{deptId}  
    </select>
```