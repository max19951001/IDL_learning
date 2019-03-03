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
  其中，关键字fid为envi文件的fid号数组，数组中的元素即待镶嵌文件的fid号；关键字dims用于设置待镶嵌数据额空间范围











