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



