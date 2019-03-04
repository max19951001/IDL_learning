;+
; :Author: 15845
;-
;******************envi_doit函数***************
;
过程envi_doit提供了大量的envi处理功能，包括定标、增强、镶嵌、融合、统计、主成分变化、分类等
语法：envi_doit,'routine_name'[,/invisible][,/no_realize],invisible关键字用于设置例程结果不可见，no_realize用于设置Available bands list
窗口不可见。
1 文件统计
  envi_stats_doit 用于对envi文件进行统计，统计的信息包括最小值、最大值、平均值、标准差、协方差、特征值、特征向量和直方图等。
  语法：envi_doit,'envi_stats_doit',fid=file id,dims=array,pos=array,m_fid=file id,m_pos=long integer,comp_flag=value[,dmin=variable] [,dmax=variable][,mean=variable]
  [,stdv=variable][,hist=variable][,cov=variable][,eval=variable][,evec=variable][,sta_name=string][,/to_screen][,prec=array]
  其中，dims用于设置数据的空间范围；关键字pos用于设置数据的波段位置；关键字comp_flag用于设置统计哪些信息；关键字dmin,dmax,mean和stdv分别统计各波段的最小值，最大值，均值和标准差；关键字hist用于返回统计得到的直方图
2 文件储存顺序转换
  过程convert_doit用于转换envi文件的数据存储顺序(BSQ、BIL、BIP)
  envi_doit,"conver_doit",fid=fid ID,dims=array,pos=array,r_fid=variable,out_name=string,o_interleave={0|1|2}
  其中，关键字fid为ENVI文件的fid号数组，数组中的元素即待转换文件的fid号；关键字dims用于设置待转换数据的空间范围；关键字pos为待转换数据的波段位置；关键字r_fid返回转换结果文件的fid号；关键字out_name用于设置转换结果文件的输出文件名；
  关键字o_interleave用于设置转换结果文件的存储顺序，0表示BSQ顺序，1表示BIL顺序，2表示BIP顺序。
3 影像重采样 resize_doit用于对envi文件进行空间重采样处理
  envi_doit,'resize_doit',fid=file id,dims=array,pos=array,r_fid=variable,out_name=string,/in_memory,interp={0|1|2|3},rfact=array,out_bname=string array
  其中，关键字fid为envi文件的fid号；关键字dims用于设置数据的空间范围(重采样后数据的空间范围)；关键字pos用于设置数据的波段位置；关键字r_fid返回重采样结果文件的fid号；关键字out_name用于设置结果的输出文件名；关键字in_memory用于设置将重采样结果保存到内存中；
  关键字interp用于设置重采样方法，0为最邻近法，1为双线性插值法，2为立方卷积法，3为像元聚合法，当进行缩减像素采样时只能采用最邻近法或者像元聚合法，此时即使设定为双线性内插法或者立方卷积法仍然按照最邻近法进行重采样；关键字rfact用于设置x和y方向上的缩放系数，为二维数组，值小于1表示缩放图像，大于1
  表示缩小图像；关键字out_bname用于设置重采样结果各波段的名称。
4 影像镶嵌
  mosaic_doit用于对envi文件进行镶嵌
  envi_doit,'mosaic_doit',fid=array,dims=array,pos=array,r_fid=variable,out_name=string,/in_memory,/georef,map_info=structure,see_through_val=array,use_see_through=array,background=integer,pixel_size=array,xsize=value,ysize=value
  x0=value,y0=value,out_dt={1|2|3|4|5|6|9|12|13|14|15},out_bname=string array
  其中，关键字fid为envi文件的fid号数组，数组中的元素即待镶嵌文件的fid号；关键字dims用于设置待镶嵌数据的空间范围，需要注意的是，此处的dims关键字为5*n的二维数组，每一行对应一个待镶嵌数据的dims数值；关键字pos为待镶嵌数据的波段位置，同样为二维数组；关键字r_fid返回镶嵌结果文件的fid号；关键字out_name用于设置结果的输出文件名；关键字in_memory用于设置将镶嵌结果保存在内存中；
  关键字georef用于设置进行基于地理坐标的镶嵌，如果该关键字设置则必须同时设置map_info关键字；map_info用于设置镶嵌结果文件的mapinfo信息；关键字see_through_val用于设置镶嵌过程中待忽略的背景值，为一维数组，各元素分别为各个待镶嵌数据待忽略的背景值；关键字use_see_throuth用于设置是否忽略see_through_val背景值，1表示忽略，0表示不忽略，同样为一维数组，各元素分别设定待镶嵌数据
  是否忽略背景值；关键字background用于设置镶嵌结果文件的背景值，默认为0；关键字pixel_size用于设置镶嵌结果文件的像元分辨率，为包含两个元素的双精度浮点型数组，两元素值分别x，y方向的像元分辨率，关键字xsize和ysize分别用于设置镶嵌结果文件x和y方向的尺寸；关键字x0和y0分别用于设置每个待镶嵌数据左上角像元在镶嵌结果文件中的分作和纵坐标(均为文件坐标)；关键字out_dt用于设置镶嵌结果的数据类型；
  关键字out_bname用于设置配准结果各波段的名称。
5 直方图拉伸
  stretch_doit用于对envi进行直方图拉伸
  envi_doit,"stretch_doit",fid=file id,dims=array,pos=array,r_fid=variable,out_name=string,/in_memory,method={1|2|3|4},out_dt={1|2|3|4|5|6|9|12|13|14|15},range_by={0|1},i_min=value,i_max=value,out_min=value,out_max=value,out_bname=string array
  其中，关键字fid为envi文件的fid号，r_fid返回拉伸结果文件的fid号；关键字out_name为其名字，in_memory保存为内存中，method用于设置拉伸方式，1为线性，2为均衡，3为高斯，4为平方根；关键字out_dt为数据类型；range_by哦那个与设置拉伸的类型，0为按最小最大值的百分比进行拉伸，1为按最小最大值拉伸；关键字i_min和i_max分别设置拉伸的最小值/最小值百分比和最大值/最大值百分比，out_min和out_max
  分别为拉伸结果的最小值和最大值；关键字out_name用于设置拉伸结果各波段的名称。
6 影像配准
  envi_register_doit用于对envi文件进行影像到影像或者影像到地图的配准
  envi_doit,"envi_register_doit",w_fid=file id,w_dims=array,w_pos=array,r_fid=variable,out_name=string,/in_memory,pts=array,b_fid=file id,proj=structure,method={0|1|2|3|4|5|6|7|8},degree=value,/zero_edge,background=integer,pixel_size=array,xsize=value,ysize=value,x0=value,y0=value,out_bname=string array
  其中，w_fid为待配准文件对应的fid号；关键字w_dims用于设置待配准数据的空间范围；关键字w_pos为待配准数据的波段位置；关键字r_fid返回配准结果文件的fid号；关键字out_name用于设置结果的输出文件名，in_memory设置将配准结果保存在内存中；关键字pts为控制点数组，为4列的双精度浮点型数组。关键字b_fid为基准图像文件的fid号，该关键字仅仅在影像到影像的配准时有效；关键字proj为pts关键字中地图坐标所属投影，在关键字仅在影像到地图的配准
  时有效；method用于设置配准方法，默认为3，即多项式转换坐标并采用最邻近法重采样；degree设置多项式的阶数，默认值为1；关键字background设置配准结果文件的背景值，默认值为0；关键字pixel_size设置配准结果文件的像元分辨率，该值尽在影像到地图的配准时有效；xsize和ysize设置配准结果x和y方向的尺寸；x0和y0设置配准结果图像左上角的坐标值，out_bname设置配准结果各波段的名称。
7 影像融合
  sharpen_doit 用于进行hsv融合或颜色归一化(brovey融合)







