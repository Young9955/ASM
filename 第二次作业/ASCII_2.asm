code segment
         assume cs:code
start:
        mov cx,26
        mov ah,02h
        mov dl,'a'  ;字符a
row1:               ;打印第一行
        sub cx,1    ;次数-1
        int 21h     ;打印字符
        add dl,1    ;ASCII+1
        cmp cx,13   ;比较
        jne row1    ;不等跳转
        mov bl,dl   ;暂存当前字符
        mov dl,0ah  ;存入回车
        int 21h     ;打印回车
        mov dl,bl   ;恢复当前字符
row2:               ;打印第二行
        sub cx,1    ;次数-1
        int 21h     ;打印字符
        add dl,1    ;ASCII+1
        cmp cx,0    ;比较
        jne row2    ;不等跳转
        mov ah,4ch
        int 21h
code ends
       end start