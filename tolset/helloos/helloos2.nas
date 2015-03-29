

mov si , msg + 0x7c00 + 1
output:
	MOV AL,[si]
	
	
	
	add si , 1
	
	MOV AH,0x0e
	mov bl,0x0a
	INT 0x10
	
	cmp al,'o'
	jne end
	je  end
	
	jmp output



msg:
	DB "ooooooooooooooomputer:Hello, master ,where shall my blood be spilled?"
	DB 0x0a      ;换行
	DB 0x0a      ;换行
	DB "Me:Do you have blood?"
	DB 0x0a      ;换行
	DB 0x0a      ;换行
	DB "Computer:Of course , I am a CODE MONKEY , MONkey, MOnkey, monkey , mon. ."
	DB 0xaa
end:
	MOV AL,'E'
	MOV AH,0x0e
	mov bl,0x0a
	INT 0x10
	jmp fin
	
fin:
	
	
	HLT          ;让CPU停止，等待指令
	JMP fin      ;无限循环
	
RESB 0x1fe-$
DB 0x55,0xaa


