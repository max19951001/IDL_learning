;+
; :Author: max
;-date:2018.12.27
;***********************数据的读写操作************

1 数据的输入输出
    标准输出是指将数据直接输出到标准输出设备(屏幕)显示，而标准输入则是从标准输入设备(键盘)直接输入数据。标准输出用的多，标准输入用的少
    1.1 标准输出 过程 print 用于将数据输出到屏幕上显示。print,expr1,...,exprn[,format=value]
    expr1 可以是常量、变量以及表达式等；关键词format 用于设置输出的格式。format是很关键的一个东西，用的时候查下
    1.2 标准输入 过程read用于从标准输入设备(键盘)中读取数据。语法：read,var1,...,varn[,prompt=string] 关键字prompt用于设置输入数据时的提示信息。
    需要注意的时，如果read过程后的变量没有预先定义，默认其为浮点型。如果想输入其他类型的数据，必须事先创建该变量。
2文件的相关操作***********
    2.1 文件的打开与关闭
    最基本的文件操作就是打开和关闭，IDL对文件的读写通过逻辑设备号完成。IDL中用get_lun和free_lun命令来动态设置逻辑设备号。
    IDL提供三个过程来打开文件：openr打开一个文件进行读操作；openw打开一个文件进行写操作；openu打开一个文件进行读写操作。
    openr语法：openr,lun,fname,/get_lun 其中，参数lun为逻辑设备号变量；参数fname为文件名；关键字get_lun用于分配一个100~128中当前还没有被使用的逻辑设备号存入变量lun中。
    对文件的操作完成之后，需要运用free_lun过程关闭该文件对应的逻辑设备号
    语法：free_lun,[,lun1,...,lunn]
    2.2 文件的其他操作
    IDL的其他文件操作包括文件的选择，查询，删除，文件信息获取，文件指针操作和判断文件是否结束等。
    2.2.1 文件的选择
    过程cd用于改变当前工作路径，语法：cd[,directory][,current=variable],参数directory为路径名；关键字current用于获取当前工作路径名
    函数dialog_pickfile能够调用操作系统所提供的选择文件对话框来选择文件名，返回的是带结对路径的文件名
    result=dialog_pickfile([,/directory][,filter=string/string array][,title=string][,get_path=variable][,path=string])
    关键字directory设置对话框用于选择目录名而不是文件名，返回的结果也是目录名；关键字get_path用于获取所选文件所在的路径名；关键字path用于设置选择文件的初始所在路径
    2.2.2 文件查询 函数file_search用于搜索满足文件名描述的所有文件名。这个函数在对多个文件进行批处理的时候非常有用
    result=file_search(path_specification [,count=variable][,/test_directory][,/test_regular])或者
    result=file_search(dir_specfication,recur_pattern[,count=variable][,/test_directory][,/test_regular])
    当函数file_search只使用一个参数时是标准查询模式，参数path_specification用于设置查询的条件；但使用两个参数时是循环模式，参数dir_specification用于设置查询的目录，
    参数recur_pattern用于设置查询的文件名条件,count用于返回满足查询条件的文件数目；关键字test_directory用于设置只返回查询到的文件夹，不包括文件；关键字test_regular用于设置只返回查询到的文件，不包括文件夹
    注意：在标准查询模式下file_search函数返回的是当前工作路径下的文件名，如果要返回带绝对路径的文件名，需要使用file_search函数的循环查询模式。
    2.2.3 文件删除 过程file_delete用于删除文件或者文件夹
    语法：file_delete,file1[,...,filen][,/recursive][,/quiet]
    参数recursive用于设置允许删除非空文件夹，如果该关键字未设置则默认不能删除非空文件夹，关键字quiet用于设置跳过不能删除的文件夹/文件，如果不设置，在遭遇不能删除的文件会报错。
    2.2.4获取文件信息
    (1)file_lines 用于查询文本文件的行数，result=file_lines(fname)\
    (2)fstat 用于获取文件的基本信息，返回结果为结构体变量，result=fstat(lun)
    2.2.5 判断文件是否结束
    函数eof用于判断文件指针是否已经到了文件的末尾，即判断文件是否已经结束。当文件结束时，eof函数返回1，否则返回0.
3 读写ASCII码文件
    从文件的编码方式来看，文件可分为ASCII码文件和二进制码文件两种。ASCII文件也称为文本文件，这种文件在磁盘中存放时每个字符对应一个字节(8位)
    3.1 读取ASCII文件
    过程readf用于读取ASCII码文件。语法：readf,lun,var1,...,varn其中参数lun为ascii码文件对应的逻辑设备号，参数var用于按顺序存储从文件读入的数据
    如果用于存储读取结果的变量容量超过存放ASCII码文件的所有数据，读取会发生错误。
    如果用于存储读取结果的变量不足以存放ASCII码文件的所有数据，那么存储到满为止。
    3.2 写入ASCII码文件
    过程printf用于将数据写入ASCII码文件。语法：printf,lun,var1,...,varn[,format=value]
    注意：IDL写入ASCII码文件默认每行宽度为80列(80个字符)，若输出的每行超过80个字符，则会自动换行，如果不想换行的话需要加上关键字width
    3.3 读写CSV文件
    CSV文件即逗号分隔值文件，是一种特殊的ASCII码文件，CSV文件以半角逗号","为分隔符，每条记录占一行，如果文件包含字段名，则字段名出现在第一行。
    














    