# destrier-os
加入了Makefile，
ipl.bin:ipl.nas Makefile
	../z_tools/nask.exe ipl.nas ipl.bin ipl.lst

helloos.img:ipl.bin Makefile
	..\z_tools\edimg.exe imgin:../z_tools/fdimg0at.tek wbinimg src:ipl.bin len:512 from:0 to:0 imgout:helloos.img
	
可以进行的操作：

make -r ipl :生成启动区文件

make -r helloos.img 生成软盘文件
