# CSDN习题

## 0202 然后是几点

```c
#include <stdio.h>
int main(void)
{
	int a, b, c, d;
	scanf("%d %d", &a, &b);
	
	c = a / 100 * 60 + a % 100 + b ;
	d = c / 60 * 100 + c % 60;
	
	printf ("%d", d);
	
	return 0;
}
```

标答

```c
#include <stdio.h>
int main()
{
	int i, j, x = 0, y, z;
	scanf("%d%d", &i, &j);
	if(i >= 1000)
	{
	       x = i / 1000;
	       y = (i % 1000) / 100;
	       z = (i %1000) %100;
	}
	else
	{
	       y = i / 100;
	       z = i % 100; 
	}
	int s = (10*x + y) * 60 + z;
	int n = s + j;
	i = n / 60 *100 + (n - ((n / 60 )* 60));
	printf("%d", i); 
	return 0;
}
```

## 0203 逆序的三位数

```c
#include <stdio.h>
int main(void)
{
    int a, b, c, d, e;
    scanf ("%d", &a);
    c = a / 100, e = a % 10, d = ( a - c * 100 ) / 10;
    b = c + d * 10 + e * 100;
    printf ("%d", b);
    
    return 0;
}
```

标答

```c
#include <stdio.h>
 
int main()
 {
 	int i;
 	scanf("%d", &i);
 	int a = i % 100 %10;
 	int b = i / 100;
 	int c = i %100 / 10;
 	i = a*100 + b + c*10;
 	printf("%d", i);
 	return  0;
 }
```

## 0204 BCD解密

标答

```c
 #include <stdio.h>
 
int main()
 {
 	int i;
 	scanf("%d", &i);
 	int t = i % 16 + i / 16 * 10;
 	printf("%d", t);
 	return 0;
 }
```

## 0300 超速判断

```c
#include <stdio.h>
int main(void)
{
    unsigned int V;
    scanf ("%d",&V);
    if (V>60)
        printf("Speed:%d - Speeding",V);
    else
        printf("Speed:%d - OK",V);
    
    return 0;
}
```

标答

```c
#include <stdio.h>
 
int main()
{
  int i;
  scanf("%d", &i);
  if(i <= 60)
    printf("Speed: %d - OK", i);
  else
    printf("Speed: %d - Speeding", i);
  return 0;
}
```

## 0301 三天打鱼两天晒网

```c
#include <stdio.h>
int main(void)
{
    int N;
    scanf("%d",&N);
    if (N % 5<=3 && N % 5 > 0)
        printf("Fishing in day %d",N);
    else
        printf("Drying in day %d",N);
    return 0;
}
```

标答

```c
#include <stdio.h>
 
int main()
{
	int i;
	scanf("%d", &i);	
	if(i%5 <= 3 && i%5 != 0)
	     printf("Fishing in day %d", i);
	else 
	     printf("Drying in day %d", i);
	return 0;
} 
```



## 0302 用天平找小球

```c
#include <stdio.h>
int main(void)
{
    int A, B, C;
    scanf("%d %d %d",&A,&B,&C);
    if (A == B, B != C)		//注意逻辑符号==
        printf("C");
    else if (B==C,A!=B)
        printf("A");
    else if (A == C && B != A)
        printf("B");
    return 0;
}
```

```c
# include <stdio.h>
 
int main()
{
     int A, B, C;
     scanf("%d%d%d",&A, &B, &C);
     if(A != B && B ==C)
           printf("A");
     else if(B != A && A == C)
           printf("B");
     else if(C != A && A == B)
           printf("C");
    return 0;
}
```

## 0303 12-24小时制

```c
#include <stdio.h>
int main(void)
{
    int h1,m,h2;
    scanf("%d:%d",&h1,&m);
    if (h1 > 12)
        printf("%d:%d PM",h2 = h1 - 12, m);
    if else (h1 = 12)
        printf("%d:%d PM",h1, m);
    if else (h1 < 12)
        printf("%d:%d AM",h1, m);
    
    
}
```

```c
#include <stdio.h>
 
int main()
{
	int i, j;
	scanf("%d:%d", &i, &j);
	if(i >= 0 && i < 12)
		printf("%d:%d AM", i, j);
	else if(i == 12)
		printf("%d:%d PM", i, j);
	else if(i == 24)
		printf("%d:%d AM", i-24, j);
	else
		printf("%d:%d PM", i-12, j);
		
	return 0;
}
```

## 0304成绩转换

①

```c
#include <stdio.h>
int main(void)
{
    int score;
    scanf("%d",&score);
    if (score >= 90)
        printf("A");
    else if (score>=80 && score < 90)
        printf ("B");
    else if (score >=70 && score <80)
        printf("C");
    else if (score >= 60 && score <70)
        printf("D");
    else 
        printf("E");
    
    return 0;
}
```

 

②

```c
#include <stdio.h>
int main()
{
    int score, a;
    scanf("%d",&score);
    a = score / 10;
    
    switch (a){
        case 9:
            printf("A");
            break;
        case 8:
            printf("B");
            break;
        case 7:
            printf("C");
            break;
            
        case 6:
            printf("D");
            break;
        default:
            printf("E");
            break;
    }
    return 0;
}
```

## 0400 求符合给定条件的整数集

```c
#include <stdio.h>
int main()
{
    int A,B,C,i=0,m;
    scanf("%d",&A);
    m = A;
    for(;A < m + 4;A++)
        for(B = m;B < m + 4;B++)
            for(C = m;C < m + 4;C++){
                if( A != B && A != C && B != C){
                    printf("%d%d%d",A,B,C);
                	i++;
					if (i % 6 == 0){
                		printf("\n");
					}else {
						printf(" ");}                
				}
            }
			   
    return 0;
}
```

```c
#include <stdio.h>
 
int main()
{
	int A, i, j, k, p = 0;
	scanf("%d", &A);
	for(i=A; i<A+4; ++i)
		for(j=A; j<A+4; ++j)
			for(k=A; k<A+4; ++k)
			{
				if(i != j && i != k && j != k)
				{
	
					printf("%d", i*100+10*j+k);
					p++;
					if(p%6 == 0)
						printf("\n");
					else 
						printf(" ");
				}
			}
	
	return 0; 
}
```

## 0401 水仙花数

```c
#include <stdio.h>
#include <math.h>
//pow(float x,float y)	计算x的y次方
int main()
{
    int n, num, a, sum = 0, digit;
    scanf("%d",&n);
    num = pow(10,n-1);
    
    for(;num < pow(10,n)-1;num++){
        a = num;
        for(;num > 0;num /= 10){
            digit = pow(num % 10,n);
            sum = sum + digit;
        }
        if (a == sum)
            printf("%d\n",a);
        num = a;
        sum = 0;
        
    }
    return 0;
    
}
```

```c
#include <stdio.h>
 
int main()
{
	int n = 0, m = 0, l = 0, k = 0, roll = 0;
	int min = 1, t = 0, sum = 0, sum1 = 0;
	scanf("%d", &n);
	m=n;
	while(m > 1)   //built the minimum for n digit
	{
		min*=10;
		m--;
	}
	t=min;
	while(t < 10*min)  //all the number for n digit
	{
		roll = t;		
		m = n;
		sum = 1;
		while(m > 0)
		{
			sum = sum*(roll%10);		
			m--;
		}
		l = n;
		while(l > 0)
		{
			roll = roll / 10;
			k = roll % 10;
			m = n;
			sum1 = 1;
			while(m > 0)
			{
				sum1 = sum1 * k;
				m--;
			}
			sum = sum + sum1;
			l--;
		}	
		if(t == sum)
		{
			printf("%d\n", t);
		}
		t++;
	}
	return 0;
}
```

## 0402 打印九九口诀表

```c
#include <stdio.h>
int main()
{
    int N, a=1, b=1;
    scanf("%d",&N);
    for(;a<=9N;a++){
        for(;b<=a;b++){
            printf("%d*%d=%d\t",a,b,a*b);
        }
        printf("\n");
        b = 1;
    }
    return 0;
}
```

