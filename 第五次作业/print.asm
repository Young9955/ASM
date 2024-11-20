assume cs:codesg, ds:datasg, es:table, ss:stacksg

datasg segment
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'
    
    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    
    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800

datasg ends

table segment
    db 21 dup('year summ ne ?? ')
table ends

stacksg segment
    dw 2 dup (0) ;栈段用于保存总收入首地址，也可以不使用栈直接用 ds:54h 表示栈段首地址（因为表格固定）
stacksg ends

codesg segment

start:
    mov ax, datasg
    mov ds, ax
    mov ax, table
    mov es, ax

    ; 设置打印表格的起始地址
    mov bx, 0

print_table:
    ; 检查是否打印完所有行
    cmp bx, 21
    je end_program

    ; 打印年份
    mov si, bx
    mov si, [si] ; 年份
    mov di, table
    mov di, [di + si] ; 年份字符串地址
    mov ah, 09h
    lea dx, [es:di]
    int 21h

    ; 打印总收入
    mov si, bx
    add si, 5 ; 总收入
    mov di, table + 5
    mov di, [di + si] ; 总收入字符串地址
    mov ah, 09h
    lea dx, [es:di]
    int 21h

    ; 打印总人数
    mov si, bx
    add si, 0ah ; 总人数
    mov di, table + 0ah
    mov di, [di + si] ; 总人数字符串地址
    mov ah, 09h
    lea dx, [es:di]
    int 21h

    ; 打印平均值
    mov si, bx
    add si, 0fh ; 平均值
    mov di, table + 0fh
    mov di, [di + si] ; 平均值字符串地址
    mov ah, 09h
    lea dx, [es:di]
    int 21h

    ; 换行
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ; 恢复 BX 并移动到下一行
    inc bx
    jmp print_table

end_program:
    mov ax, 4c00h
    int 21h

codesg ends

end start