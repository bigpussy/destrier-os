;hello-os
;TAB = 4 
;��������Ǳ�׼FAT12��ʽ����ר�õĴ���
;DB 0xeb,0x4e
;��������
	ORG 0x7c00   ;ָ�������װ�ص�ַ
;���µļ����û���׼FAT12��ʽ������
JMP entry



DB 0x90

DB "HELLOIPL"  ;�����������ƿ�����������ַ���(8�ֽ�)
DW 512  ;ÿ������(sector)�Ĵ�С(����Ϊ512�ֽ�)
DB 1    ;��(cluster)�Ĵ�С(����Ϊ1������)
DW 1    ;FAT����ʼλ��(һ��ӵ�һ��������ʼ)
DB 2    ;FAT�ĸ���(����Ϊ2)
DW 224  ;��Ŀ¼��С(һ�����ó�224��)
DW 2880 ;�ô��̵Ĵ�С(������2880����)
DB 0xf0 ;��������(������0xf0)
DW 9    ;FAT�ĳ���(������9����)
DW 18   ;1���ŵ�(track)�м�������(������18)
DW 2    ;��ͷ��(������2)
DD 0    ;��ʹ�÷�����������0
DD 2880 ;��дһ�δ��̴�С
DB 0,0,0x29  ;���岻�����̶�
DD 0xffffffff ;(������)������
DB "HELLO-OS   " ;���̵�����(11�ֽ�)
DB "FAT12   "    ;���̸�ʽ����(8�ֽ�)
RESB 18  ;�ȿճ�18�ֽ�

 


;�������
entry:
	MOV AX,0     ;��ʼ���Ĵ���
	MOV SS,AX
	MOV SP,0x7c00 
	MOV DS,AX
	MOV ES,AX
	MOV SI,msg
	mov ax , 0x0820
	mov es,ax
	mov ch,0 
	mov dh,0 
	mov cl,2

readloop:
	mov si,0
retry:
	;����
	mov ah,0x02 
	mov al,1 
	mov bx,0 
	mov dl,0x00 
	int 0x13  
	jnc next
	
	add si,1 
	cmp si,5 
	jae error 
	
	mov ah,0x00 
	mov dl,0x00 
	int 0x13 
	jmp retry
	

error:
	mov ah,0x00
	mov dl,0x00 
	int 0x13  
	jmp retry
    
	mov si,msg
	
next:
	mov ax,es 
	add ax,0x020
	mov es,ax
	add cl,1
	cmp cl,18  
	jbe  readloop
	ja   success

putloop:
	MOV AL,[SI]
	ADD SI,1     ;��SI��1
	CMP AL,0 
	
	JE fin
	MOV AH,0x0e  ;��ʾһ������
	MOV BX,16    ;ָ���ַ���ɫ
	INT 0x10     ;�����Կ�BIOS
	JMP putloop

success:
	mov si ,succ
	jmp putloop 
msg:
	DB 0x0a,0x0a ;����2��
	DB "error!"
	DB 0x0a      ;����
	DB 0
	
succ:
	DB "successfully load the disk"
	DB 0
	
fin:
	HLT          ;��CPUֹͣ���ȴ�ָ��
	JMP fin      ;����ѭ��
;��Ϣ��ʾ����

RESB 0x7dfe-$  ;��д0x00,ֱ��0x001fe
DB 0x55,0xaa
