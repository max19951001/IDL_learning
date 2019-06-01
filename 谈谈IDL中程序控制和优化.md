|      数据类型       |      True(真)      |   False(假)    |
| :-----------------: | :----------------: | :------------: |
| Byte、Integer、Long |        奇数        |      偶数      |
|  Pointer、Objects   | 非空指针或非空对象 | 空指针或空对象 |
|     List、Hash      |  至少包含一个成员  |     无成员     |
|   Float、complex    |       非0值        |      0值       |
|       String        |     非空字符串     |   空字符串“”   |

​                                                                                   **表 5.1  控制条件列表**

#### ! : 没看懂这个表

# 5.2 循环语句

## 5.2.1   for 循环

```idl
（1）for i=v1,v2 do 
		循环语句
	endfor
 (2) for i=v1,v2,v3 do
 		循环语句
 	endfor
 注意：v1为循环起始值，v2为循环最终值，v3为增量，可省略，默认为1
 (3) for i=v1,v2 d0 begin 
 		语句块
 	 endfor
```

## 5.2.2  foreach循环

```idl
(1) foreach element,variable [,key] do 语句
	endforeach
(2) foreach element,variable [,key] do begin 
		语句块
	endforeach
eg： array=[1,2,3]
	 foreach element,array do print,element
	 endforeach
注意：variable 通常为链表，数组或者哈希表
```

### 5.2.3  while循环

```idl
while 条件 do 语句
或
while 条件 do begin
	语句块
endwhile

```

### 5.2.4  Repeat循环

循环中需要一直进行，直到满足才结束，此时可以调用Repeat...Until循环语句。

```idl
repeat 语句 
endrep until 条件满足
或者
repeat begin 
语句块
endrep until 条件满足

eg: i=10
	repeat begin
		i--
	endrep until i lt 0
	print,i

```



##  5.3  条件语句

### 5.3.1  if语句

```idl
if 条件 then 语句
或 if 条件 then 语句 else 语句
或 if 条件 then begin 语句块
endif

if 条件 then begin
	语句块
endif else begin
语句块
endelse
```

### 5.3.2  case语句

```idl
case 表达式 of
情况1：语句
	或
	begin 语句块
	end
情况2：语句
	或
	begin 语句块
	end
endcase

index = 1
case index of 
  0:plot,sin(findgen(100)*0.25)
  1:surface,dist(32)

  else:print,index
endcase
```

### 5.3.3  switch 语句

switch 的调用格式与case一样，但与case的不同之处在于，遇到与条件相一致的情况，它会从此情况开始依次执行下面的各个情况直至endswitch.

```idl
pro test_swith
	x = 2
	switch x of
		1:print,'one'
		2:print,'two'
	endswitch	
	print,'end'
end

result: one
		two
		end
```

## 5.4 跳转语句

### 5.4.1 break

break 提供了一个从循环(for、while和repeat)或case、switch 等状态下快速退出的方法

```idl
pro test_breax
	i= 0
	while i lt 10 do begin
		
		i+= 1
		if i>5 
			break
		print,i
		
```

### 5.4.2  continue

continue 提供了从当前循环的某一步中(for,while和repeat)退出进入下一次循环的方法

```idl
pro test_continue
	for i=1,5 do begin
		if i gt 2 then continue
			print,i
		endif
	endfor
```

### 5.4.3  goto

goto可以使程序跳转到某一标签处，标签的格式为"字符串"

```idl
pro test_goto
	goto,jump1
	print,'hello'
	jump1:print,'do this'
end
```

## 5.5 参数与关键字

idl中过程或者函数中可以使用位置参数和关键字参数进行参数传递。

### 5.5 .1  位置参数

位置参数在过程或函数中用来传递变量或者表达式。

```idl
pro using_parameters,param1,param2
	help,param1,param2
end

调用格式:  using_parameters,'par','par2'
```

* **注意：此时的传入参数与位置顺序依次对应的。程序调用时，位置参数不一定是必须的，部分位置参数是可选的。**

### 5.5.2  关键字参数

* **关键字参数是IDL程序中可选择设置的参数，它的特点是不仅支持变量传入，还支持返回变量。参数传入可以是一个预先定义的参数或一个bool值。可以用来返回所需要的值。**
* **关键字参数在程序调用时不依靠位置，而是依靠名字来确定，故它可以放在函数的任意位置。关键字在调用时有加反斜杠'/'的写法，添加'/'相当于在调用时该关键字传入值为1。**

### 5.5.3  参数继承

IDL下支持关键字继承，这一点与面向对象中类的方法继承类似。

```idl
pro using_extraargm,a,b,_extra =e
	plot,a,b, _extra =e
end

using_extraargm,findgen(200),sin(findgen(200)),color=16777751,thick=2

;解释，其中'_extra=e'将调用时输入参数的'color=16777751,thick=2'全部继承并传入plot命令
```

### 5.5.4  参数传递 (重要)

参数传递分为值传递和地址传递。地址传递，子程序中对变量的修改会在主程序生效；值传递，子程序中对变量的修改在主程序中无效。

