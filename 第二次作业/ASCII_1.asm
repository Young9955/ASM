code segment
         assume cs:code
start:
        mov bl,2    ;外圈循环次数
        mov cx,13   ;内圈循环次数
        mov ah,02h
        mov dl,'a'  ;字符a
loop2:              ;外圈循环开始
        mov cx,13   ;第二次要重新初始化次数
loop1:              ;内圈循环开始
        int 21h     ;打印字符
        add dl,1    ;ASCII+1
        loop loop1  ;内圈循环结束
        mov bh,dl   ;暂存当前字符
        mov dl,0ah  ;存入回车
        int 21h     ;打印回车
        mov dl,bh   ;恢复当前字符
        mov cl,bl   ;计数器更新外圈循环次数
        sub bl,1    ;外圈循环次数-1
        loop loop2  ;外圈循环结束
        mov ah,4ch
        int 21h
code ends
       end start