TOOLPATH = ../z_tools/

MAKE = $(TOOLPATH)make.exe -r
EDIMG = $(TOOLPATH)edimg.exe
NASK = $(TOOLPATH)nask.exe
CC1      = $(TOOLPATH)cc1.exe -I$(INCPATH) -Os -Wall -quiet
GAS2NASK = $(TOOLPATH)gas2nask.exe -a
OBJ2BIM  = $(TOOLPATH)obj2bim.exe
BIM2HRB  = $(TOOLPATH)bim2hrb.exe
RULEFILE = $(TOOLPATH)haribote/haribote.rul
IMGTOL   = $(TOOLPATH)imgtol.com
COPY = copy
DEL = del

ipl10.bin:ipl10.nas Makefile
	$(NASK) ipl10.nas ipl10.bin ipl10.lst
	
asmhead.bin:asmhead.nas Makefile
	$(NASK) asmhead.nas asmhead.bin asmhead.lst

bootpack.gas:bootpack.c Makefile
	$(CC1) -o bootpack.gas bootpack.c 
	
bootpack.nas:bootpack.gas Makefile
	$(GAS2NASK) bootpack.gas bootpack.nas
	
bootpack.obj:bootpack.nas Makefile
	$(NASK) bootpack.nas bootpack.obj bootpack.lst 
	
bootpack.bim:bootpack.obj naskfunc.obj Makefile
	$(OBJ2BIM) @$(RULEFILE) out:bootpack.bim stack:3136k map:bootpack.map \
		bootpack.obj naskfunc.obj
		
bootpack.hrb:bootpack.bim Makefile
	$(BIM2HRB) bootpack.bim bootpack.hrb 0
	
naskfunc.obj:naskfunc.nas Makefile
	$(NASK) naskfunc.nas naskfunc.obj naskfunc.lst
	
haribote.sys:asmhead.bin bootpack.hrb Makefile
	copy /B asmhead.bin+bootpack.hrb haribote.sys

helloos.img:ipl10.bin haribote.sys Makefile
	$(EDIMG) imgin:../z_tools/fdimg0at.tek \
		wbinimg src:ipl10.bin len:512 from:0 to:0  \
		copy from:haribote.sys to:@: \
		imgout:helloos.img
	
img:
	$(MAKE) helloos.img
	
asm:
	$(MAKE) ipl.bin 

run:
	$(MAKE) img
	$(COPY) helloos.img ..\z_tools\qemu\fdimage0.bin
	..\z_tools\make.exe -C ../z_tools/qemu
	
run_o:
	$(MAKE) run
	$(MAKE) clean
	
clean:
	-$(DEL) *.bin
	-$(DEL) *.lst
	-$(DEL) *.gas
	-$(DEL) *.obj
	-$(DEL) bootpack.nas
	-$(DEL) bootpack.map
	-$(DEL) bootpack.bim
	-$(DEL) bootpack.hrb
	-$(DEL) haribote.sys
	
src_o:
	$(MAKE) clean
	-$(DEL) helloos.img
	