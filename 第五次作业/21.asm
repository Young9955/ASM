assume cs:codesg,ds:datasg,es:table,ss:stacksg
 
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
 
start:mov ax,datasg   ;初始化数据段、table段、栈段地址
      mov ds,ax
      mov ax,table
      mov es,ax
      mov ax,stacksg
      mov ss,ax
      mov cx,21
      mov bx,0
      mov si,0
      mov di,0
s0:                      ;将年份按列填入表格
      mov ax,[si]
      mov es:[di],ax
      mov ax,[si+2]
      mov es:[di+2],ax
      add di,16
      add si,4
      loop s0
 
      mov di,5
      mov cx,21        ;保存总收入首地址，之后计算平均值要用
      push si
s1:                    ;将总收入按列填入表格
      mov ax,[si]
      mov es:[di],ax
      mov ax,[si+2]
      mov es:[di+2],ax
      add di,16
      add si,4
      loop s1
 
      mov di,0ah
      mov cx,21
s2:                    ;将总人数按列填入表格，同时计算平均值
      mov ax,[si]
      mov es:[di],ax
      ;;;; 将数据段总人数当前地址临时放入栈中，让出si寄存器
      pop bx
      push si
      mov si,bx
      ;;;;; 计算平均值
      mov bx,ax
      mov ax,[si]
      mov dx,[si+2]
      div bx
      ;;;; 将平均值填入表格中，同时栈中si寄存器恢复
      mov es:[di+3],ax
      add si,4
      pop bx
      push si
      mov si,bx
 
      add di,16
      add si,2
      loop s2
 
      mov ax,4c00h
      int 21h
 
codesg ends
 
end start