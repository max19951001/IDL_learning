;+
; :Author: max
;date:2019/1/04
;***********************图形绘制*********************************
IDL提供两种绘制图形的方法：直接图形法和对象图形法。直接图形法绘制图形后直接输出到当前图形设备上显示，其显示的内容不能被更改，除非重新绘图。对象图形法首先创建显示图形的窗口对象，
然后再窗口对象中显示图形对象，其图形对象一致保留再内存中，可以修改，重复使用。
1 plot 过程绘曲线图
  1.1 基本曲线图
    过程plot用于绘制曲线图，默认窗口背景为黑色，坐标轴，刻度标注，图形为白色，并自动绘制坐标轴 plot,[x],y
    关键字nodata用于设置再窗口中绘制坐标轴而不绘制曲线。plot,x,y,/nodata\
    plot 过程再绘制新的曲线时会自动删除当前窗口的图形内容。如果想在一个窗口内绘制多个图形，则需要用到oplot过程。
    oplot,[x,]y  或者在plot过程中使用关键字noerase也可以达到同样的目的。
  1.2 线型设置 
    过程plot/oplot提供了一系列关键字用于设置曲线显示效果(符号，线型，线宽等)。其默认是用实线将各个数据点连接起来
    通过设置psym关键字可以修改图形中的符号，1代表+，2代表*，3代表·，4代表菱形，5代表三角形，6代表方形，7代表x,如果psym关键字设置为负值的话，那么除了在数据点处绘制对应符号之外，还用线将各个符号连接起来
    关键字symsize用于设置绘图符号的大小，默认为1.0
    关键字linestyle用于改变曲线的线型，0代表实线，1代表点线，2代表虚线，3代表划点线，4代表划 划点线，5代表长虚线
    关键字thick用于设置曲线的宽度，默认的线宽为1.0           
  1.3 坐标轴设置(包括标题，范围，字体大小等 )
    关键字{x|y}title用于设置图形(以及x,y轴)标题
    关键字{x|y}charsize用于设置图形(以及x,y轴)的字体大小，默认的字体大小为1.0.如果直接用charsize，则对所有字体进行设置，xcharsize对x轴设置
    关键字{x|y}range用于设置图形坐标轴的范围。xrange=[0,0.7],有时虽然设置了x,y的坐标轴范围，但是IDL并不严格按照所设置的坐标轴范围来显示
    此时需要用{x|y}style关键字强行设定坐标轴范围。其值对应格式如下：1代表强制设定坐标轴范围，2代表坐标轴范围边上留出空余，4代表隐藏这个坐标轴，8隐藏外边框(只显示某一边的坐标轴)，16不将y轴的起始值设置为0(只对y轴有效)
    {x|ystyle}关键字的值并非一次只能设定一个。可通过相加的方式同时调整坐标轴的几类格式
    关键字{x|y}ticks和{x|y}minor分别用于设置x,y轴的主刻度和最小刻度间隔的数目。
    关键字{x|y}tickinterval用于设置x,y轴的主刻度间隔，优先级高于{x|y}ticks
    关键字{x|y}ticklen、{x|y}tickv、{x|y}tickname、{x|y}tickformat分别用于设置x,y轴的刻度长度、值、名称和格式等。
  1.4 颜色设置
    关键字color和background分别设置图形和背景的颜色
    关键字color将坐标轴和曲线绘制为相同颜色，如果显然坐标轴和曲线表现为不同颜色，比如坐标轴为黑色，曲线为蓝色。则需要用到nodata,首先利用nodata关键字绘制处没有曲线只有坐标轴的图形，然后再利用oplot添加蓝色曲线。
  1.5 添加标注 过程xyouts用于再图形窗口内添加标注信息
    xyouts,x,y,string [,alignment=value][,color=value][,charsize=value][,/data,/device,/normal]
    其中，参数x,y用于设置标注的位置；参数string为标准的字符串内容；关键字alignment用于设置标注的对齐方式，默认值0为左对齐，0.5为居中对齐，1为右对齐；关键字color用于设置标准的颜色，关键字charsize用于设置标注的字体大小；关键字data、device和normal分别用于设置参数
    x,y的坐标值为数据坐标，设备坐标和归一化坐标，如果都没设置默认为数据坐标
    过程xyouts还可以同时添加几组标注，此时参数string 为数组，参数x,y至少有一个也是数组，否则所有标注都会出现在相同位置。
  1.6 绘制多幅图形
    (1)过程window用于设置当前图形窗口的基本属性或者打开新的图形窗口
    window[,index][,xsize=pixels][,ysize=pixels] 参数index为窗口索引号，IDL给每个新打开的窗口分配一个索引号，从0开始；关键字xsize和ysize用于设置图形窗口的宽度和长度(单位为像素)
    (2)过程plot的关键字position用于设置所绘图形在图形窗口中的位置。该关键字是一个由四个元素组成的数组[x0,y0,x1,y1],x0,y0为左下角坐标值，x1,y1为右上角坐标值。默认坐标值为归一化坐标值。关键字position不能采用数据坐标值
  1.7 图形保存为文件
    IDl当前图形设备的相关属性存储在系统变量!d中，!d为一个结构体变量，包含name,xsize,ysize,window等表征图形设备属性的域。window为当前图形窗口的索引号
    过程set_plot用于选择IDL的图形设备，语法：set_plot,device,device为图形设备名称，IDL可用的其他图形设备包括postscript,打印机，wmf文件等
    过程device用于对当前图形设备的属性进行设置，
    device[,/close_file{cgm,metafile,ps}][,filename=filename{cgm,metafile,ps}][,/index_color{metafile,printer}][,/true_color{metafile,printer}][,xsize=width{metafile,printer,ps}][ysize=height{metafile,printer,ps}]
    其中，关键字close_file用于关闭文件；关键字filename用于设置图形输出的文件名
    此外，通过tvrd函数抓取窗口内容，然后再写入图像文件。tvrd 函数用于将当前图形设备窗口内容保存问数组。
    result=tvrd(x0，[,y0[,nx[,ny[,channel]]]])[,channel=value][,/order][,true={1|2|3}]
    其中，参数x0和y0用于设置读取的起始列号和行号，默认值均为0，参数nx和ny用于设置读取的列数和行数；关键字channel用于设置读取的波段，如果设备显示的是24位真彩色图像，而该关键字和true关键字均没有设置的话默认返回RGB3个波段中的最高值；关键字order用于设置图像纵坐标从上往下算，不设置的话默认从下往上算；
    关键字true用于设置图像像元的存放顺序，1表示BIP,2表示BIL,3表示BSQ
2 plot 函数绘曲线图
    2.1 基本曲线图 IDL(8.0)提供了一个全新的绘图函数plot。函数plot是对象式的绘图，可以替代过程plot,并且可以进行简单的交互操作。
    函数plot用于绘制曲线图，结果返回一个图形对象。
    graphic=plot([x,]y [,/buffer]][,/current][,dimensions=array][,/device][axis_style={0|1|2|3}][,margin=array][,name=string][,title=string][,position=array][,/overplot][,/nodata][,window_title=string])
    其中，参数x位图形横坐标的数据，如果不设该参数则默认参数y的下标为图形横坐标的数据；参数y为图形纵坐标的数据；关键字buffer用于设置将图形保存再缓存中而不是新打开一个窗口；关键字current用于设置在当前窗口中创建图形(重新绘制坐标轴)；关键字dimension是一个两元数组[width,height]用于设置窗口的宽度和高度，
    单位为像素；关键字device用于设置关键字margin和position的值为设备坐标，若未设置，则默认为归一化坐标；关键字axis_style用于设置坐标轴的性质；关键字margin用于设置图形四周空白的宽度；关键字name用于设置图形对象的名称；关键字title用于设置图形的标题；关键字position为一个4元素数组，用于设置图形在宽口的位置；
    关键字overplot用于设置当前图形叠加到现有图形上面(采用现有坐标轴)；关键字nodata用于设置在窗口中，只绘制坐标轴；关键字windows_title用于设置图形窗口的标题。。
    2.2 线型设置 
    关键字symbol用来设置符号类型，可以用关键字值和短名称来设置
    关键字color用于颜色设置，可以用24位整数的色彩值或[R、G、B]的三原色数值，也可以用颜色的color关键字比如"blue"为蓝色，"green"为绿色
    关键字linestyle用于改变曲线的线型，可以用关键字值、关键字字符、或者格式代码
    关键字thick用于改变曲线的线宽度
    2.3 符号设置
    plot函数提供了一系列关键字用于设置符号的性质(大小，颜色，填充颜色，透明度等)
    关键字sym_size和sym_thick分别用于设置符号的大小以及符号的线宽
    关键字sym_color用于设置符号的颜色，可以用24位整数的色彩值，也可以直接用颜色的color关键字特性或者格式代码
    关键字sym_filled用于设置符号位实心填充，如果关键字未设置则默认为空心。
    关键字sym_fill_color用于设置符号为填充颜色，如果该关键字未设置则默认为sym_color关键字定义的颜色
    关键字sys_trnsparency用于设置符号的透明度，取值为0~100的整数，如果该关键字未设置则默认透明度为0
    2.4坐标轴设置
    plot 函数提供了一系列关键字用于设置坐标轴的性质(标题，范围，字体大小等)
    关键字axis_style用于设置坐标轴的类型，取值为0~3的整数，0代表无坐标轴为针对图像的默认值，1代表仅仅绘出x和y最小值的坐标轴(即单边轴)
    关键字{x|y}title用于设置图形(以及x,y轴)标题
    关键字{x|y}range用于设置图形坐标轴的范围，指定坐标轴显示的最小和最大值
    关键字{x|y}tickinterval和{x|y}minor分别用于设置x,y轴的主刻度间隔的宽度和最小刻度间隔的数目。
    关键字{x|y}ticklen,{x|y}tickvalues,{x|y}tickname,{x|y}tickformat分别用于设置x,y轴的刻度长度，值，名称，格式等。
    2.5绘制多幅图形
    关键字diMensions设置图形窗口的尺寸，position关键字用于设置图形的文字。
    2.6 图形对象操作方法
    plot 函数返回的图形对象常用的方法有close,delete,refresh,save,getdata和setdata
    (1)方法close用于关闭图形对象所在的图形窗口以及该窗口中的所有图形
    graphic.close,graphic为图形对象。
    (2)方法delete用于删除图形
    graphic.delete
    (3)方法refresh用于设置图形窗口的刷新功能。
    graphic.reresh[,/disable]关键字disable用于设置关闭刷新功能。
    (4)方法save用于把某个图形对象保存为图像文件。
    graphic.save,fname[,/bitmap][,border=integer][,height=integer][,width=integer][,resolution=integer][,/centimeters]
    参数fname用于设置图形输出的文件名，关键字bitmap仅适用于emf，eps和pdf文件格式，用于设置输出为位图格式文件，如果该关键字未设置则默认输出为矢量格式，关键字border用于设置图形周围的边框范围，如果该关键字未设置则默认保留图形对象中图形周围的所有空白边框区，如果输出文件为矢量格式那么该关键字无效
    关键字height用于设置输出文件的高度，对于图形文件其单位为像素，对于pdf文件其单位为英寸，如果该关键字设置则resolution将被忽略，且输出文件的高度将根据图形窗口的长宽比自动计算。关键字resolution用于设置输出图形文件的分辨率(单位为：DPI，默认值为600)，关键字centimeters仅对pdf文件有效，设置其为厘米
    (5)方法getdata用于从图形对象中获取数据横坐标和纵坐标值。
    graphic.getdata[,x],y
    (6)方法setdata用于将图形对象中现有数据值替换为指定的数据值
    graphic.setdata[,x],y
    2.7添加标注
    函数 text 用于在图形窗口中添加标注信息，结果返回一个图形对象。
    语法：text=text(x,y,string[,target=variable][,color=value][,font_size=value][,alignment=value][,vertical_ailgnment=value][,/data,/device,/normal]) 
    其中，参数x和y用于设置标注的位置(横坐标和纵坐标值)；参数string位标注的内容；关键字target用于设置在哪一个图形对象中添加标注，如果该关键字未设置则默认在当前图形对象中添加标注；关键字color用于设置标注的颜色；关键字font_size用于设置标注的字体大小，默认值为16；关键字alignment用于设置标注的水平对齐方式，默认值0为左对齐，0.5为居中对齐，1为右对齐；
    关键字vertical_alignment用于设置标注的垂直对齐方式，默认值0为底端对齐，0.5为居中对齐，1为顶端对齐；关键字data,device和normal分别设置参数x和y的坐标值为数据坐标，设备坐标和归一化坐标。若都没设置默认为归一化坐标。
    2.8 添加图例
    函数legend用于在图形窗口中添加标注信息，该函数仅适用于图形对象                    
    语法：graphic=legend([target=variable][,label=string][position=array][,sample_width=value][,auto_text_color][,text_color=value][,font_size=value]
    [,color=value][,thick=value][,horizontal_alignment=value][,vertical_alignment=value][,horizontal_spacing=value][,vertical_spacing=value[,/data,/device,/normal]])
    其中，关键字target为字符串数组，用于设置添加哪些图形对象的图例，如果该关键字未设置则默认添加当前图形对象的图例；关键字label用于设置图例要素的显示名称；关键字postion为一个2元素的数组[x,y],用于设置图例左上角在窗口中的位置；关键字smaple_width用于设置图例中曲线的宽度，默认为0.15；关键字auto_text_color用于设置将图例字体颜色修改为其所关联的曲线颜色，
    如果该关键字设置的法text_color将被忽略；关键字text_color用于设置图例字体的颜色；关键字font_size用于设置图例字体的大小，默认值为16；关键字color用于设置图例边框的颜色；关键字thick用于设置图例边框的线宽，关键字horizontal_alignment用于设置图例的水平对齐方式，0为左对齐，0.5为居中对齐，1为右对齐；关键字vertical_alignment用于设置图例的垂直对齐方式，
    0为底端对齐，0.5为居中对齐，1为顶端对齐；关键字horizontal_spacing和vartical_spacing用于设置图例要素之间的水平间隔和垂直间隔(单位为归一化坐标)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    