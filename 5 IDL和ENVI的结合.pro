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
        语法：envi_file_query,fid[,ns=variable][,nl=variable][nb=variable][,dims=variable][,data_type=variable][,interleave=variable][,bnames=variable][,fname=variable][,sname=variable]
        [,offset=variable][,xstart=variable][,ystart=variable][,file_type=variable][,descript=variable][,data_gains=variable][,data_offsets=variable][,wl=variable][,wavelength_units=value]
        [,num_class=variable][,class_names=variable][,lookup=variable]
        其中，参数ns,nl,nb分别用于返回envi文件的列数，行数，波段数。关键字dims用于返回文件的空间范围；关键字data_type用于返回文件的数据类型；interleave为数据的存储顺序，0表示bsq存储，1表示bil存储，2表示bip存储；关键字bnames用于返回文件各波段的名称；
        关键字fname用于返回文件的名称(含绝对路径)；关键字sname用于返回文件的短文件名，即不含路径的文件名；关键字offset返回文件的头文件偏移字节数；关键字xstart和ystart用于返回文件左上角顶点像元的行号和列号，关键字file_type返回文件类型；关键字descrip返回文件的描述字符串信息；
        关键字data_gains和data_offsets返回各个波段定标系数中的增益值和偏移值；关键字wl用于返回文件各个波段的波长；关键字wavelength_units用于返回文件波长值的单位；关键字num_classes用于返回分类文件的类别数目；class_names返回分类文件的各类别名称；
        关键字lookup用于返回分类文件各个类别的颜色值，为一个二位数组【3，num_classes】
        (2)envi_file_query过程能够查询处envi文件的头文件的几乎所有信息，除了投影坐标信息map_infor
        envi_get_map_info 函数获取投影信息，返回值为结构体
        result=envi_get_map_info(fid=file id)
        3 读取数据
        数据量较大的时候不适合利用IDL的readu命令将遥感数据整个读入到内存中。envi提供了了两种方式读取envi文件的部分内容，分别读取一个波段或者一行的数据。
        函数 envi_get_data 用于从一个打开的envi文件中读取一个波段的数据。
        result=envi_get_data(fid=file id,dims=array,pos=long interger)
        其中，关键字fid为envi文件fid号；关键字diMs读取数据的空间范围；关键字pos读取数据所在的波段位置。由于envi_get_data函数只能读取一个波段的数据，关键字pos必须为单个数值。
        函数envi_get_slice用于从打开的envi文件中读取一行的数据。
        reuslt=envi_get_slice(fid=file id,line=integer,pos=array,xs=value,xe=value,[/bil][,/bip])
        关键字line用于设置读取数据所在的行号；关键字pos用于设置读取数据所在的波段位置，如果该关键字未设置这默认读取该行的所有波段；关键字xs和xe分别用于设置读取数据起始和终止列号；
        关键字bil和bip分别设置返回结果为bil和bip格式，如果这两个关键字均未设置默认为BIL格式。
        4 保存文件
        envi的文件格式包含两个文件：头文件和数据文件。头文件(后缀名为hdr)为ascii码文件，数据文件(通常无后缀)为二进制格式文件。
        过程envi_write_file用于将内存中IDL变量写为硬盘上或者内存中的envi格式文件，除了数据文件之外，还写入对应的头文件，写入的信息包括列数，行数，波段书，头文件偏移，数据类型，数据存放顺序等。
        语法：envi_write_envi_file,data,out_name=varibale,/in_memory,[,/no_copy][,/no_write][,r_fid=variable][,/no_open],ns=variable,nl=variable,nb=variable,
        out_dt={1|2|3|4|5|6|9|12|13|14|15},interleave={0|1|2}[,map_info=structure][,bnames=string array][,offset=value][,xstart=variable][,ystart=variable]
        [,file_type=variable][,descript=variable][,wl=variable][,wavelength_units=value][,num_classes=variable][,class_names=variable][,lookup=variable]
        其中，关键字data为待写入envi文件的IDL变量；关键字out_name用于设置输出envi文件名称；关键字in_memory用于设置将envi文件保存在内存中；关键字no_copy用于设置在将IDL变量写入envi文件后在内存中删除该变量；如果未设置则在内存中保留该变量；
        关键字no_write用于设置不将envi头文件写入硬盘，如果该关键字未设置则默认将头文件写入硬盘；关键字r_fid返回所写入文件的fid号；关键字no_open用于设置不将envi文件打开显示，如果该关键字未设置则默认打开文件并加入aviable bands list;
        关键字out_dt用于设置文件的数据类型；关键字interleave用于设置文件的数据存储顺序，0表示BSQ顺序，1表示BIL顺序，2表示BIP顺序；关键字bnames用于设置文件各波段的名称；关键字descrip用于设置文件的描述字符串信息；关键字wl用于设置文件各个波段的波长；
        关键字wavelength_units用于设置文件波长值的单位；关键字num_classes用于设置分类文件的类别数目；关键字class_names用于设置分类文件的各类别名称；关键字lookup用于设置分类文件各个类别的颜色值，为一个二维数组[3,num_classes]
        
        也可以分两步来保存envi格式文件；保存数据文件和保存头文件。首先通过writeu过程写入envi数据文件；然后通过envi_setup_head过程写入envi头文件，写入的信息包括列数，行数，波段数，头文件偏移，数据类型，数据存放顺序以及定标系数等。
        envi_setup_head,fname=variable[,/write][,/open],ns=variable,nl=variable,nb=variable,data_type=variable,interleave={0|1|2}[,map_info=structure][,bnames=string array][,offset=value][,xstart=variable]
        [,ystart=variable][,file_type=variable][,descrip=variable][,data_gains=variable][,data_offsets=variable][,wl=variable][,wavelength_units=value][,num_classes=variable][,class_names=variable][,lookup=variable]
        其中，关键字fname用于设置头文件所对应的envi数据文件名称；关键字write用于设置将头文件写入硬盘，如果未设置则默认在内存中创建该头文件而不将其写入硬盘；关键字open用于设置将头文件对应的envi文件打开并显示在envi的avaliable bands list中，如果该关键字未设置则默认不打开文件；
         关键字data_gains和data_offsets分别用于设置文件各个波段的增益值和偏移值；
         
         envi_write_envi_file 过程只能把IDL当前某个变量整个写入一个envi文件吗，而writeu过程则可以向一个文件中逐步添加内容，两种方法各有优劣。如果数据量较小，那么直接用envi_write_envi_file写入文件更为简单方便；如果数据量比较大，可以用envi_get_data或者envi_get_slice的方法
         逐波段或者逐行读入数据进行处理，然后利用writeu逐波段或者逐行写入envi数据文件，最后使用envi_setup_head写入头文件，这样占用系统内存较少
        











