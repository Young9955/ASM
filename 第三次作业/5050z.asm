stk segment
    dw 0h
stk ends
code segment
    assume cs:code, ss:stk
start:
    mov bx,stk  ;段地址送入bx
    mov ss,bx   ;存放段地址
    mov sp,0    ;栈指针
    mov ah,02h  ;输出方式
    mov dx,1    ;当前加数
    mov bx,0    ;和
    push bx     ;把和推入栈段
    mov cx,100  ;计数器
loop1:          ;循环开始
    pop bx      ;弹出当前和
    add bx,dx   ;加
    push bx     ;把和推入栈段
    inc dx      ;自增
    loop loop1  ;循环结束
;以下代码将栈顶的值分解成千、百、十、个位，以字符形式输出
    mov cx,1000d;千位
    pop ax      ;和放入ax
    mov dx,0    ;清空
    div cx      ;ax/cx
    push dx     ;余数给dx，推入栈段
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,100d ;百位
    pop ax      ;和放入ax
    mov dx,0    ;清空
    div cx      ;ax/cx
    push dx     ;余数给dx，推入栈段
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,10d  ;十位
    pop ax      ;和放入ax
    mov dx,0    ;清空
    div cx      ;ax/cx
    push dx     ;余数给dx，推入栈段
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov cx,1d   ;个位
    pop ax      ;和放入ax
    mov dx,0    ;清空
    div cx      ;ax/cx
    push dx     ;余数给dx，推入栈段
    mov dl,al   ;一位数字
    add dl,30h  ;变成ASCII
    mov ah,02   ;输出形式
    int 21h     ;打印
    mov ah,4ch
    int 21h
code ends
       end start