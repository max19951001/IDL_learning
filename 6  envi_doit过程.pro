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
  语法：envi_doit,'envi_stats_doit',fid=file id,dims=array,pos=array,m_fid=file id

















