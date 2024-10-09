code segment
    assume cs:code
start:
    mov ah,02h  ;输出方式
    mov dx,1    ;当前加数
    mov bx,0    ;和
    mov cx,100  ;计数器
loop1:          ;循环开始
    add bx,dx   ;加
    inc dx      ;自增
    loop loop1  ;循环结束
;以下代码将bx中的值分解成千、百、十、个位，以字符形式输出
    mov cx,1000d;千位
    mov ax,bx   ;拷贝一份
    mov dx,0    ;清空
    div cx      ;ax/cx
    mov bx,dx   ;余数给dx
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,100d ;百位
    mov ax,bx   ;拷贝一份
    mov dx,0    ;清空
    div cx      ;ax/cx
    mov bx,dx   ;余数给dx
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,10d  ;十位
    mov ax,bx   ;拷贝一份
    mov dx,0    ;清空
    div cx      ;ax/cx
    mov bx,dx   ;余数给dx
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,1d   ;个位
    mov ax,bx   ;拷贝一份
    mov dx,0    ;清空
    div cx      ;ax/cx
    mov bx,dx   ;余数给dx
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov ah,4ch
    int 21h
code ends
    end start