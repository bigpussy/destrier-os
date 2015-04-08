TOOLPATH = ../z_tools/
MAKE = $(TOOLPATH)make.exe -r
NASK = $(TOOLPATH)nask.exe 
EDIMG = $(TOOLPATH)edimg.exe 

default:
	$(MAKE) img

ipl.bin:ipl.nas Makefile
	$(NASK) ipl.nas ipl.bin ipl.lst

helloos.img:ipl.bin haribote.sys Makefile 
	$(EDIMG)   imgin:../z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0 \
		copy from:haribote.sys to:@: \
		imgout:helloos.img
haribote.sys:haribote.nas Makefile
	$(NASK) haribote.nas haribote.sys haribote.lst
	
img:
	$(MAKE) helloos.img
	
asm:
	$(MAKE) ipl.bin

run:
	$(MAKE) img
	copy helloos.img ..\z_tools\qemu\fdimage0.bin
	$(MAKE) -C ../z_tools/qemu
	
run_o:
	$(MAKE) run
	$(MAKE) clean
	
clean:
	del ipl.bin ipl.lst haribote.sys haribote.lst
	
src_o:
	$(MAKE) clean
	del helloos.img
	del haribote.img
	