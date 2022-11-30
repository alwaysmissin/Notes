# 动态SQL
[动态 SQL_MyBatis中文网](https://mybatis.net.cn/dynamic-sql.html)
## if
- 通过`test`属性中的表达式判断标签中的内容是否有效
	- 有效则自动拼接至sql语句
```xml
<select id="getEmpByCondition" resultMap="getEmpByConditionMap" >  
    select * from t_emp where
	<if test="empName != null and empName != ''">  
		emp_name = #{empName}  
	</if>  
	<if test="age != null and age != ''">  
		and age = #{age}  
	</if>  
	<if test="gender != null and gender != ''">  
		and gender = #{gender}  
	</if> 
</select>
```
## where
> where和if一般结合使用

- 如果where中的if条件都不满足，则where标签没有任何功能，也不会添加where关键字
- 如果where中的if条件满足，则where标签会**自动添加where关键字**，并**去除多余的and**
```xml
<select id="getEmpByCondition" resultMap="getEmpByConditionMap" >  
    select * from t_emp  
    <where>  
        <if test="empName != null and empName != ''">  
            emp_name = #{empName}  
        </if>  
        <if test="age != null and age != ''">  
            and age = #{age}  
        </if>  
        <if test="gender != null and gender != ''">  
            and gender = #{gender}  
        </if>  
    </where>  
</select>
```
## trim
- `trim`用于**去掉或添加标签中的内容**
- 属性：
	- `prefix`：在`trim`标签中的内容前添加某些内容
	- `prefixOverrides`：在`trim`标签的内容前去掉某些内容
	- `suffix`：在`trim`标签中的内容后添加某些内容
	- `suffixOverrides`：在`trim`标签内容后区队某些内容
```xml
<select id="getEmpByCondition" resultMap="getEmpByConditionMap" >  
    select * from t_emp  
    <trim prefix="where" suffixOverrides="and">  
        <if test="empName != null and empName != ''">  
            emp_name = #{empName}  
        </if>  
        <if test="age != null and age != ''">  
            age = #{age}  
        </if>  
        <if test="gender != null and gender != ''">  
            gender = #{gender}  
        </if>  
    </trim>  
</select>
```
## choose、when、otherwise
> 类似于java中的switch语句
```xml
<select id="getByChoose" resultMap="getEmpByConditionMap">  
    select * from t_emp  
    <where>  
        <choose>  
            <when test="empName != null and empName != ''">  
                emp_name = #{empName}  
            </when>  
            <when test="age != null and age != ''">  
                age = #{age}  
            </when>  
            <when test="gender != null and gender != ''">  
                gender = #{gender}  
            </when>  
        </choose>  
    </where>  
</select>
```
## foreach
- 对集合进行遍历
	- 声明可以在元素体内使用的**集合项`item`和索引`index`变量**
	- 指定**开头与结尾的字符串**以及**集合迭代项之间的分隔符**
```xml
<insert id="insertMoreEmp">  
    insert into t_emp values  
    <foreach collection="emps" item="emp" separator=",">  
        (null, #{emp.empName}, #{emp.age}, #{emp.gender}, null)  
    </foreach>  
</insert>
```
> [!提示]
> 可以**将任何可迭代对象、Map对象或者数组对象**作为集合参数传递给`foreach`