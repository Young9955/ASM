data segment
    msg  db "The 9*9 table:", 0ah, 0dh, '$'
    num  dw ?,?,?,? ;声明一个字（16位）数组num，该数组有四个元素，但初始化为问号?，表示这些值将在程序运行时被填充
    res  db ?,?,?,? ;声明一个字节（8位）数组
data ends

code segment
    assume cs:code, ds:data

start:
    mov  cx, 9      ;外圈循环次数
    mov  ax, data   ;将数据段的地址存储在寄存器AX中
    mov  ds, ax     ;将数据段寄存器DS设置为数据段的地址，这样程序可以访问数据段中的数据
    lea  dx, msg    ;打印提示语
    mov  ah, 09h    ;将寄存器AH设置为09h，这是DOS的功能号，表示要执行字符串输出
    int  21h        ;触发DOS中断21h，以执行字符串输出操作，输出提示语
    call PrintMultiplication ; 调用过程打印乘法表
    mov ah, 4ch
    int 21h

PrintMultiplication proc
    push cx         ;保存外层计数
    mov  cx, 9      ;外圈循环次数
outer_loop:
    mov  [num], cx  ;存放乘数
    push cx         ;保存外层计数
    mov  cx, 9      ;内圈循环次数
inner_loop:
    mov  [num+1], cx ;存放第二个乘数
    push cx         ;第二个乘数进栈
    mov  dx, cx     ;将第二个乘数加载到寄存器DX中
    add  dx, 30h    ;转换到ASCII
    mov  ah, 02h    ;将寄存器AH设置为2，表示要执行字符输出操作
    int  21h        ;触发DOS中断21h，以输出第二个乘数
    ; ... 省略中间代码，与原程序相同 ...
    mov  dl, 09h    ;把水平制表栏移动到DX寄存器低八位
    mov  ah, 02h    ;将寄存器AH设置为2，表示要执行字符输出操作
    int  21h        ;触发DOS中断21h，以输出水平制表栏
    loop inner_loop ;内层循环结束
    mov  dx, 0ah    ;把换行移动到DX寄存器低八位
    mov  ah, 02h    ;将寄存器AH设置为2，表示要执行字符输出操作
    int  21h        ;触发DOS中断21h，以输出换行
    pop  cx         ;内层计数
    loop outer_loop ;外层循环结束
    pop  cx         ;还原外层计数
    ret
PrintMultiplication endp

code ends
    end start