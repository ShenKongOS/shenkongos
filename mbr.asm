;ShenKong OS 1.0

SECTION mbr align=16 vstart=0x7c00




;读取内存测试
xor ax,ax
mov ds,ax
mov ax,ds:[data+0x1]
mov ds:[data+0x3],ax

;显示字符
mov ax,0b800h
mov es,ax
mov byte es:[0],'w'

;显示数字
mov ax,4564
mov di,160+40
call showNumber

;显示字符的asiic
mov ax,'a'
mov di,160*2+40
call showNumber

mov byte es:[2],'o'
mov byte es:[4],'r'
mov byte es:[6],'k'

mov ax,0
mov ds,ax
mov si,text
mov ax,0xb800
mov es,ax
mov di,160*2
cld
mov cx,(textend-text)/2
rep movsw

;表示负数
mov al,9
neg al
cbw
cwd




x:
hlt
jmp x


;-------------------------------------------------------------


;展示数字
;ax目标数字
;di显示偏移
showNumber:
push si
push cx
push dx


;拆分位数
mov si,0
mov cx,10					;除数
CFSW:
mov dx,0					;初始化dx用于被除数，ax中有目标数
div cx
;push dx
mov ds:[data2 +si],dl	;在data2存储余数(8bits)(结果会小于8bits)
inc si						
cmp ax,0					;除到ax为0
jne CFSW

dec si					;减去最后一次增加的1
;显示十进制
TENC:
mov al,ds:[data2+si]
;pop ax
add al,0x30
mov es:[di],al
add di,2
dec si
mov ax,si
cmp ax,-1
jne TENC


pop dx
pop cx
pop si
ret



data db 0,1,0,0
data2 db 0,2,2,2,0
data3 db 'attation'
text: db 'hhehlhlhoh'
textend:
times 510-( $-$$ ) db 0
db 0x55, 0xaa