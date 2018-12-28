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
    3.3.1函数read_csv用于读取CSV格式文件，返回结果为结构体变量 
    result=read_csv(fname[,count=variable][,header=variable][,num_records=value][,record_start=value])
    其中，参数fname为csv文件名；关键字count用于返回文件的数据行数；关键字header用于返回每一列的字段名，若没有字段名，则返回空字符串值；关键字num_records用于设置读取几行数据，如果该
    关键字未设置则默认读取所有行的数据；关键字record_start用于设置从第几行开始读取数据。
    3.3.2函数 write_csv 用于写入csv文件。语法：write_csv,fanme,data1[,...,datan][,header=variable] 关键字header为字符串数组，用于设置CSV文件各个列的字段名，fname为csv文件名
4 读写二进制文件
    与ASCII码文件相比，二进制数据要紧凑的多，节约存储空间，常用于存储大数据文件。读取二进制文件之前必须要知道二进制文件的维数，数据类型以及存储顺序，否则无法正确读取文件的内容。
    4.1 读取二进制文件，过程readu用于读取二进制码文件
    readu,lun,var1,...,varn 其中，参数lun为二进制对应的逻辑设备号，参数var1,varn用于按顺序存储从文件中读入的数据。
    4.2 写入二进制文件 过程writeu用于写入二进制文件
    writeu,lun,var1,..,varn
5 读写图像文件 IDL提供了常用的图像如BMP，GIF,JPEG,JPEG2000,PNG,PPM,SRF,TIFF和DICOM格式文件的查询，读取与写入等操作功能。
    5.1 图像文件查询 函数query_image用于查询IDL支持的图像文件，返回图像文件的基本信息。如果该文件能够被IDL识别为图像文件，返回1，否则返回0
    result=query_image(fname [,info][,channels=variable][,dimensions=variable][,pixel_type=variable][,type=variable]$
     [,has_palette=variable][,image_index=index][,num_images=variable])
    其中，参数fname为图像文件名；参数info返回图像的基本信息，为一结构体，和下面介绍的几个关键字是一回事；channels为图像波段数，dimensions为图像的列数和行数
    pixel_type为图像像元值的数据类型；type为图像文件的类型，has_palette返回图像为真彩色还是伪彩色，真彩色值为0，伪彩色值为1，image_index为图像在文件中的索引号，
    num_images为文件所包含的图像数目。
    除了query_image函数之外，IDL还提供了query_bmp、query_gif、query_jpeg、query_jpeg2000、query_png、query_ppm、query_srf、query_tiff和query_dicom等函数指针对相应格式进行查询。
    5.2 读取图像文件 read_image 用于读取IDL所支持的任何图像文件，结果为函数所读取的图像数组，如果该文件不是IDL所支持的图像文件，则返回-1.
    如果是灰度图像，函数read_image返回的结果为二位数组，如果是真彩色图像，函数read_image返回的结果为三位数组。常用的图像文件多采用BIP格式存储(波段按行交叉格式)，而常用的遥感文件多采用BSQ格式存储(波段顺序格式)
    函数 dialog_read_image 用于通过图形界面对话框来读取IDL支持的任何图像文件。用户点击"open"按钮，函数返回1，点击"cancel"按钮，则返回0
    result=dialog_read_image([image=variable][,query=variable][,file=variable][,filter_type=string][,get_path=variable][,path=string][,title=string])
    其中，关键字image用于存储所读取的图像；关键字query用于获取图像的的基本信息(和query_image中的info参数相同)；关键字file用于返回通过对话框所选择的文件名；关键字filter_type用于设置文件类型过滤条件，如'.bmp'、'.jpg'、'.png'等
    关键字get_path用于获取所选文件所在的路径名；关键字path用于设置选择文件的初始所在路径；关键字title用于设置对话框的标题。
    5.3 写入图像文件 过程write_image用于写入IDL所支持的任何图像文件
    write_image,fname,format,data[,order] 其中，参数fname为图像文件名，参数format为字符串形式表达的图像文件格式，包括bmp,gif...等，参数data为待写入图像的数据；关键字order用于设置图像纵坐标从上往下算，该关键字不设置则默认从下往上算。
    dialog_write_image 用于通过图形界面来写入图像文件。用户点击对话框的"save"按钮，返回1，如果用户点击的是对话框的"cancel"按钮则返回0
    result=dialog_write_image(image[,filename=string][,type=variable][,/fix_type][,path=string][,title=string][,/warn_exist])
    其中，image为待写入图像文件的数据；关键字filename用于返回对话框所选择的文件名；type用于设置保存文件类型，fix_type用于设置限定用户只能保存为关键字type所设定的类型；关键字path用于设置选择文件的初始所在路径；关键字title设置对话框标题，
    warn_exist设置当前保存文件名在硬盘上已存在时是否提醒，未设置则默认操作不提醒而直接替换。
6 读取HDF文件 HDF文件格式(Hierarchical Data Format,层次型数据格式)。一个HDF文件能够包含不同数据类型的大数据量的科学数据，包括图像、多维数组、指针以及文本数据等。目前用的比较多的HDF文件格式为HDF4和HDF5。
    6.1 读取HDF4文件
      6.1.1 HDF4文件的打开与查询
      (1)函数hdf_sd_start(fname[,/read|,/rdwr][,/create]) read为HDF只读，rdwr为读写操作，create用于设置创建一个新的HDF文件
      (2)过程 hdf_sd_fileinfo 用于获取HDF文件中科学数据集和全局属性的数目 hdf_sd_fileinfo,hd_id,nsds,natts,其中参数hd_id 为HDF文件标识符，即hdf_sd_start返回的结果，参数nsds返回HDF文件包含的科学数据集数目；参数natts返回HDF文件包含的全局属性数目
    6.2 HDF4数据集操作
      6.2.1 函数 hdf_sd_nametoindex 用于根据科学数据集的名称获取对应数据集索引号 result=hdf_sd_nametoindex(hd_id,sds_name)
      其中，参数 hd_id 为HDF文件标识符，参数sds_name为数据集的名称。 
      6.2.2 函数 hdf_sd_select 用于根据索引号选择科学数据集，返回一个科学数据集标识符 result=hdf_sd_select(hd_id,index)，其中，参数hd_id为HDF文件标识符，参数index为数据集的索引号
      6.2.3 过程 hdf_sd_getinfo 用于查询已打开的HDF文件中某个科学数据集的基本信息(变量名称、描述、数据类型、维度数目、各个温度、有效值范围、单位等)
      hdf_sd_getinfo,sd_id[,name=name][,natts=natts][,label=label][ndims=ndims][,dims=dism][,range=range][,type=type][,unit=unit]
      其中，sd_id为科学数据集标识符，即hdf_sd_select的返回结果，name返回科学数据集的名称，natts返回科学数据集属性数目，参数label返回科学数据集描述，ndims返回科学数据集维度数目，参数dims返回科学数据集各个维度，range
      返回科学数据集的有效值范围，type返回科学数据集数据类型，unit返回数据集单位





    