CYLS EQU 0x0FF0           ;设定启动区
LEDS EQU 0xFF1
VMODE EQU 0x0FF2          ;关于颜色数目的信息。颜色的位数
SCRNX EQU 0xFF4           ;分辨率的X
SCRNY EQU 0xFF6           ;分辨率的Y
VRAM EQU 0x0FF8           ;图像缓冲区开始地址

ORG 0xC200

	MOV AL, 0x13
	MOV AH, 0x00
	INT 0x10
	
	MOV BYTE [VMODE], 8
	MOV WORD [SCRNX], 320
	MOV WORD [SCRNY], 200
	MOV DWORD [VRAM], 0x000A000
	
	;用BIOS取得键盘上各种LED指示灯的状态
	
	MOV AH, 0x02
	INT 0x16
	MOV [LEDS], AL
	
fin:
	HLT
	JMP fin
	
	