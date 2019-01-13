;+
; :Author: max
;-date:2019/1/13
;********************************* envi和idl的结合**************************************
1 IDL和ENVI能投实现数据的相互传输。可以将IDL数据导入ENVI进行处理，或者将ENVI数据导入IDL进行处理。
2 ENVI 调用IDL函数
      ENVI的band math和Spectral math 工具能够调用IDL程序直接进行波段运算和光谱运算，结果同常规的波段运算和光谱运算一样保存为ENVI格式文件或者保存在内存中。
      2.1 波段运算函数
      在envi+idl运行模式下，利用IDL编写波段运算函数并编译，可在ENVI的band math功能下直接调用该函数进行波段运算
      2.2 波谱运算函数 spectral math
      ENVI的波谱运算功能能够将波谱作为变量直接进行计算，输入变量必须以字符s或者S加上数值的方式命名，如S1,S2
3 IDL调用ENVI功能 ******************
      ENVI提供了很多可以在IDL中直接调用的函数，为了能够调用ENVI的功能函数，不能单独打开IDL进程，必须以ENVI+IDL混合模式运行，或者在IDL进程中先启动一个没有图形界面的ENVI进程(即批处理模式)
      启动没有图形界面的ENVI进程分为两个步骤：首先利用过程ENVI载入ENVI的核心SAVE文件，包括envi的基本功能函数，动态运行函数以及envi运行所需的内部变量；然后通过过程envi_batch_init初始化批处理模式
      语法：envi,/restore_base_save_files。其中，关键字restore_base_save_files用于载入ENVI的核心save文件，如果该关键字未设置则启动完整的ENVI进程
      过程envi_batch_init用于初始化批处理模式。envi_batch_init
      使用envi_batch_exit终止批处理模式，已删除这些变量并释放内存。
      3.1 常用的envi函数
        1 打开文件
        (1)函数 envi_pickfile 打开一个图形对话框来选择文件名，返回的是所选择文件的带绝对路径的文件名。该函数与 dialog_pickfile 函数的作用类似
        语法：result=envi_pickfile([,/directory][,filter=string][,/multiple_files][,title=string])
        其中，关键字directory将打开的选择目录名。关键multiple_files用于设置ctrl或者shift键同时选择多个文件。
        (2)过程 envi_select 用于打开一个对话框让用户从envi中已经打开的文件列表中选择一个文件。为envi标准的文件选择对话框，还可以在此对话框中通过直接打开新的envi文件
        语法：envi_select[,fid=variable][,dims=variable][,pos=variable][,/mask][,m_fid=variable][,m_pos=variable][,/no_dims][,title=string]
        其中，关键字fid用于返回所选文件的id号，文件id时envi指向数据文件的指针，为长整型的标量；关键字dims用于返回数据的空间范围，为一个包含5个元素的长整型数组，5个元素分别为指向ROI的指针
        (不指定ROI的时候为-1)、起始列号、终止列号、起始行号、终止行号，行列号下标从0开始；关键字pos用于返回数据的波段位置，是一个变长的长整型数组，从0开始，如第2和第三波段其对应的pos关键字为[1,2];
        关键字mask用于允许设置掩膜数据；关键字m_fid用于返回掩膜数据的fid号；关键字m_pos用于返回掩膜数据的波段位置；关键字no_dims用于设置取消空间子集选项；关键字no_space用于设置取消波段子集选项。
        (3)envi_get_file_ids 返回所有当前在envi中打开的文件的fid号
        result=envi_get_file_ids()
        (4)过程envi_open_file用于在envi中打开一个envi文件，并返回文件的fid号。
        envi_open_file,fname,r_fid=variable[,/invisible],其中fname为envi文件名，关键字r_fid返回所打开文件的fid号；关键字invisible用于设置在envi的avaiable bands list窗口张不显示打开的文件
        (5)过程 envi_open_data_file 用于在 envi中打开一个envi所支持的外部格式文件(如hdf、geotif)，并返回文件的fid号
        语法：envi_open_data_file,fname,r_fid=varibale[,/bmp][,/jpeg][,/jp2][,/png]][,/tiff][,/hdf_sd][,hdfsd_dataset=value][hdfsd_interleave={0|1|2}][,/ermapper]
        [,/imagine][,/pci][,/eosat_tm][,esa_tm][,/landsat_metadata][,/nlaps][,/aster][,/avhrr][,/modis][,/radarsat][,/seawifs][/spot][,/vegetation][,/nitf][,/invisible]
        其中，参数fname为文件名；关键字r_fid返回打开文件的fid号，关键字hdf_sd用于设置打开的文件为HDF科学数据集；关键字hdfsd_dataset用于设置当文件为HDF格式时指定要打开的数据集名称，如果该关键字未设置则弹出HDF Dataset Selection
        对话框让用户选择要打开的数据集；关键字hdfsd_interleave用于设置当文件为HDF格式时指定以哪种顺序存储，默认值0表示BSQ顺序，1表示BIL，2表示BIP顺序，invisible用于设置在envi窗口中不显示打开的文件。
        2 查询文件信息
        (1)过程envi_file_query用于对打开的envi文件进行查询，就获取该文件的列数、行数、波段数、头文件偏移、数据类型、数据存放顺序、定标系数等相关信息
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        











