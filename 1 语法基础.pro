;+
; :Author: max
;-date: 2018/12/19  

1 变量
  1.1 有自定义变量和系统变量两种；
  自定义变量：(1)开头第一个字符必须为英文(2)只能由字母，数字，下划线以及$组成(3)不能有空格(4)不区分大小写
  系统变量：以！开始，例如!PI 为圆周率Π
  1.2 数据类型，包括数字型数据类型和非数值型数据类型(都可以作为一维或者多维数组的元素)
  数值型类型包括byte(1字节),int(2字节),uint(2字节)，long(4字节)，ulong(4字节)，long64(8字节)，ulong64(8字节)，float(4字节)
  double(8字节)，complex(8字节)，dcomplex(16字节)
  非数值数据类型 string(0~32767个字符)，struct(结构体)，pointer(指针)，object(对象)，list(链表)，hash(哈希表)
  注意：变量不需要声明，也不需要定义类型
  1.3基本操作
  数据类型转化，注意高精度转为低精度注意越界。
  浮点型或者其他转为整形，注意使用fix()越界问题，常用函数
    round()四舍五入取整
    floor()去尾取整
    ceil()进一取整
2 数组
  2.1 定义数组 直接定义和函数定义(数组在IDL中先列后行)
  直接定义：a=[a,x],b=[[3,2,1],[4,3,2]]
  函数定义：有两种函数，一种是直接所有元素赋值为0，有bytarr(),intarr(),uintarr(),long64arr(),fltarr(),dblarr(),strarr()
  另一种是所有元素初始化为该元素在数组中的索引值(下标值)bindgen(),indgen(),lindgen(),findgen(),sindgen()
  其他两种创建数组
  (1)创建所有值相同的数组result=replicate(value,d1,...,d8)d1,...,d8为数组
  (2)result=make_array([d1[d2,...,d8]],[dimension=vector][,value=value][,size=vector][,/index][,type=type_code])
  2.2 数组下标
   为了避免和函数混淆，数组访问一般用中括号[].
   (1)从idl 8.0开始，支持负下标，其中-1表示最后一个元素下标，a[-1]
   (2)向量访问，比如访问数组中第1，3，6，8元素，先定义数组b=[0,2,5,7],之后a[b]即可
   (3)访问数组中第10~12列，第9-10行元素，则可以a[9:11,8:9]
   (4)*提取某一列或者某一行数据，比如提取第四行数字，则a[*,3]
  2.3 数组操作******
  (1)数组元素的数目(n_elements)统计数组中所有元素的数目，若数组未定义则返回零值。result=n_elements(arr)
  (2)数组的大小和类型(size)，结果为一个长整型数组。包含了数组的维数、大小和类型等信息。result=size(expression [,/n_dimensions|,/dimension|,/type|,/tname|,/n_elements])
  其中，n_dimensions返回数组维数，dimension返回每一维的大小，type返回数组类型，tname返回数组类型(float),n_elements返回数组元素
  (3)数组的最值 result=max(arr,[max_subscript|index][,dimension=1 or 2]) max_subscript为最大值的下标，dimension为维数，1维代表列，2代表行
  (4)数组的均值，方差，标准差result=mean(arr[,dimension=value]),result=variance(arr[,dimension=value]),result=stddev(array[,dimension=value])dimension为维数，1维代表列，2代表行
  (5)数组求和 result=total(arr[,dimension=value][,/cumulative])，cumulative为累加值。
  (6)数组元素的查找*****  result=where(arr_expression[,count][,complement=variable][ncomplement=variable]),返回值为数组元素的索引，complement为不满足条件的数组元素下标，ncomplement为不满足条件的元素个数
  (7)数组的重排列
      (1)reform 不改变元素数目的前提下改变数组维数，result=reform(arr,d1[],...,d8)
      (2)transpose 对数组进行转置运算result=transpose(arr)  ;转置的意义是什么?对于遥感图像就是旋转了90°?
      (3)sort 对数组元素进行升序排列，返回值为数组中各个元素的下标。
      (4)reverse 用于对数组进行翻转，返回值为翻转后的数组result=reverse(array)
      (5)shift用于对数组元素进行平移，result=shift(arr,s1,...,sn)s1,..sn为数组各维的平移数，正值表示向前平移
3 字符串
  3.1 创建字符串
  直接创建 用单引号或者双引号括起来。如果字符串中包含单引号或者双引号时，则需要同时使用单引号和双引号。
  3.2 连接字符串 用"+"将字符串连接
  strjoin 将一个字符串数组连接为一整个字符串。result=strjoin(string[,delimiter]),其中string为字符串数组，delimiter为连接符
  3.3 字符串操作函数***********c
  (1)计算字符串长度strlen,result=strlen(expression)
  (2)字符串大小写，strlowcase()将所有字符串变量转为小写，strupcase()转为大写，result=strlowcase(string)
  (3)字符串移除空格strcompress()用于移除字符串中的空格result=strcompress(string[,/remove_all]),若不设关键字，则移除变量中所有的连续的空格压缩为一个空格
  strtrim()用于移除字符串变量两端的空格。result=strtrim(string,[,flag]),flag设置为0或者不设置，删除字符串右端的所有空格，值为1时将字符串左端的空格删除，值为2时删除所有的空格
  (4)字符串比较，result=strcmp(string1,string2[,n][,/fold_case])，其中n表示比较前n个字符，fold_case表示不区分大小写
  (5)字符串查找 strpos()用于查找字符串在另一个字符串中的位置。返回值为字符串字串在母串中的下标，如果查找不到则返回-1，如果查到的不止一个，只返回第一个字符串所在位置
  result=strpos(expression,search_string[,reverse_search]),reverse_search用于设置从母串的末尾开始向前查询。
  (6)字符串提取字串result=strmid(string,pos[,length]),pos为截取字符串下标，length为截取长度
  (7)字符串拆分strplit,result=strsplit(string[,pattern][,count=variable][,/fold_case][,/extract][,length=variable]) 
  其中，参数pattern为分隔符，可以为单个字符或者若干字符组成的字符串，count返回分割后子字符串的数目
  3.4 字符串与数值的相互转换
  (1)函数string将数值型变量转为字符串，result=string(123),也可以将多个数值转为字符串
  (2)函数fix,long,float等可以将字符串转换为对应的字节型，整形，浮点型变量。
  3.5字符串读取reads,语法为reads,input,var1,...,varn,[format=value]参数var1,...,varn用于按顺序存储从input字符串读入的数据。format用于设置读入数据的格式代码
4 表达式 IDL中的表达式由运算符，函数，变量和常量等组成，运算之后得到一个新的变量。
  4.1 数值型表达式 idl中的数值型运算符包括10种：+(加)、-(减)、*(乘)、/(除)、^(乘方)、MOD(求余)、<(求最小)、>(求最大)、++(自增)、--(自减)。其中前8个运算符为双目运算符，后两个为单目运算符。
  运算优先级最高为^,++,--,其次是*，/，MOD，最后是+，-，<,>
  注意：(1)表达式包含多种类型变量时，其计算结果取决于精度最高的变量类型。(2)相除运算中，如果两个数都是整数，则运算结果也是整数，小数部分被舍弃。
  4.2 字符型表达式，常见的就是"+"
  4.3 关系型表达式，IDL的关系运算符包括6种：eq(等于)、ne(不等于)、gt(大于)、lt(小于)、ge(大于等于)、le(小于等于)
  4.4 逻辑性表达式，IDL的逻辑性运算符包括：&&(逻辑与)、||(逻辑或)、~(逻辑非)
  4.5 条件表达式，语法为：expr1?expr2:expr3 其中，expr1为表达式，如果为真，表达式的值为expr2,否则，为expr3
  注意：常常三个表达式都要加上括号。
  4.6 位运算符********* 针对字节型、整形、或者常量进行操作。IDL种提供四种运算符：and(位与)、or(位或)、xor(位异或)、not(位非)
  位运算符在遥感种应用比较广泛，位运算符and 和or也可以连接若干关系型表达式，起到逻辑运算符&&和||的作用(双目运算符两边必须时关系型运算符)
  4.7 数组运算
  idl数组相加，就是对应数值相加,数值和数组运算，也是数值与数组任何一个元素进行运算
  注意：IDL针对数组提供两种乘法运算符：#(列乘)和##(行乘),列乘是以第一个数组的列乘以第二个数组的行(要求第一个数组的行数等于第二个数组的列数)
  4.8 运算符的优先级(1)()、[](2)*(指针)、^、++、--(3)*(标量乘)、/、mod、#、##(4)+、-、<、>、not(5)EQ、ne、gt、lt、ge、le(6)and、or(7)&&、||、~(8)?:(9)=
  4.9 常用数学运算函数 abs(取绝对值)、sqrt(平方根)、exp(自然指数)、alog(自然对数)、alog10(常用对数)、factorial(阶乘)
5 时间 IDL提供三种表达时间的方法：字符串、秒和儒略日。字符串方式以“星期几 月 日 时：分：秒 年”的形式表达；秒方式从UTC(世界标准时间)1970年1月1日0时起以秒为单位计算，为双精度浮点型数据类型。比如8.8367842e+008，
儒略日方式以UTC公元前4713年1月1日12时起计算，以天为单位，为双精度浮点型数据，例如：2450814.9
  5.1 系统时间，systime()用于获取操作系统当前时间，有三种方式分别为:
  (1)获取字符串格式当前时间 result=systime([0][,/UTC]),其中0为缺省值；关键字UTC用于设置返回的时间为世界标准时间，不设置默认为系统当前时区的时间。
  (2)获取秒格式当前时间result=systime(1|/seconds)
  (3)获取儒略日格式当前时间result=systime(julian[,/utc])
  5.2 时间格式转化
  (1)函数bin_date()将字符串格式转为年、月、日、时、分、秒这6个值。语法为result=bin_date(string_time)
  (2)过程caldat用于将儒略日格式的时间转化为年、月、日、时、分、秒这几个分量。语法caldat,julian,month[,day[,year[,hour[,minute[,second]]]]],其中参数julian为儒略日格式的时间
  (3)函数julday用于将年，月，日，时，分，秒这几个分量转化为对应的儒略日格式的时间。result=julday(month,day，year[,hour[,minute[,second]]])
6 结构体 将不同类型不同大小的数据(常量，标量，数组，指针，结构体等)存储在一个变量中，分为匿名结构体和署名结构体
  6.1 匿名结构体 匿名结构体指省略结构体名称而直接定义的结构体，创建匿名结构体变量的是否直接把结构体内容用大括号括起来
  student1={name:'xx',age:17}。studen1包括两个域，分别为name和age,结构体的成员成为域，调用其成员可用结构体名后面加上变量名实现。也可以用下标来访问，不同于数组，此处用(1)而不是[1]
  其中，域的变量类型和大小不能改变，但可以改变其值。在读取HDF文件时会用到结构体
  6.2 署名结构体 一旦结构体名称被创建，那么该结构体就不能随便更改。署名结构体的名称定义在大括号里面
  student2={student,name:"zhangsan",age:17}
  6.3 结构体数组，使用replicate函数创建结构体数组(具体用的时候在看)
  6.4 结构体操作函数
  (1)创建结构体 create_struct result=create_struct([tag1,values1,...,tagn,valuesn][,structuresn][,name=string])
  其中tag1为结构体域名称，values为结构体域内容，structuresn为待加入新创建结构体的结构体变量，name用于定义新创建的结构体变量为署名结构体，其值即为署名结构体的名称。
  (2)结构体域名 tag_names用于获取结构体变量中所有域的名称。result=tag_names(expression[,/structure_name])参数expression为结构体变量，关键字structure_name用于设置函数返回结构体的名称而不是结构体中域的名称。
  (3)结构体域的数目 n_tags result=n_tags(expression)
7 指针 用于存储内存单元的地址，其指向另一个变量地址的变量。其指向的变量可以时任意数据类型。
  7.1 指针的创建ptr_new() result=ptr_new([initexpr])initexpr为函数创建的指针所指向的变量或者表达式。如果该参数没有设置函数将返回一个未指向任何变量的空指针
  7.2 指针的提取 在指针变量前加入一个*表示该指针说指向的变量
  7.3 指针的释放 ptr_free可以用于释放指针所指向的内存。ptr_free,p1,....pn 其中p1,..pn为指针变量。
  7.4 指针的验证 ptr_valid 用于验证指针的有效性，当指针变量为有效指针时，函数返回值为真。否则为假
  7.5 指针数组 函数ptrarr()用于创建指针数组，数组中每一个元素均为一个指针变量。result=ptrarr(d1,..,dn)