data segment
    dw 0h
data ends
code segment
    assume cs:code, ds:data
start:
    mov bx,data ;段地址送入bx
    mov ds,bx   ;存放段地址
    mov ah,02h  ;输出方式
    mov dx,1    ;当前加数
    mov bx,0    ;和
    mov ds:[0],bx;把和放入数据段
    mov cx,100  ;计数器
loop1:          ;循环开始
    add bx,dx   ;加
    mov ds:[0],bx;把和放入数据段
    inc dx      ;自增
    loop loop1  ;循环结束
;以下代码将bx中的值分解成千、百、十、个位，以字符形式输出
    mov cx,1000d;千位
    mov ax,ds:[0];内存直接寻址放入ax
    mov dx,0    ;清空
    div cx      ;ax/cx
    mov ds:[0],dx;余数给dx，放入数据段
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,100d ;百位
    mov ax,ds:[0];内存直接寻址放入ax
    mov dx,0    ;清空
    div cx      ;ax/cx
    mov ds:[0],dx;余数给dx，放入数据段
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,10d  ;十位
    mov ax,ds:[0];内存直接寻址放入ax
    mov dx,0    ;清空
    div cx      ;ax/cx
    mov ds:[0],dx;余数给dx，放入数据段
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,1d   ;个位
    mov ax,ds:[0];内存直接寻址放入ax
    mov dx,0    ;清空
    div cx      ;ax/cx
    mov ds:[0],dx;余数给dx，放入数据段
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov ah,4ch
    int 21h
code ends
       end start