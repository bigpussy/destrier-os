;hello-os
;TAB = 4 
;以下这段是标准FAT12格式软盘专用的代码

DW 1
DB 1
DW 2
ORG 0x7c00
DB 0x11