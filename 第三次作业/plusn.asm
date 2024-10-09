.model small
.stack 100h
.data
    prompt db 'Please enter a positive integer: $'
    result_msg db 'The sum is: $'
    newline db 0Dh, 0Ah, '$'
    num db 5 dup(0)  ; 存储用户输入
    sum dw 0         ; 累加和
    digit db ?       ; 存储每个数字字符
.code
main:
    ; 初始化段寄存器
    mov ax, @data
    mov ds, ax

    ; 提示用户输入
    mov ah, 09h
    lea dx, prompt
    int 21h

    ; 读取输入 (最多允许5个数字)
    mov bx, 0        ; BX 用作索引

input_loop:
    mov ah, 01h      ; 等待并读取单个字符
    int 21h
    cmp al, 0Dh      ; 检查是否是回车
    je end_input     ; 如果是回车，结束输入

    ; 存储非回车字符
    sub al, '0'                ; 将字符转为数字
    mov num[bx], al            ; 存入缓冲区
    inc bx                     ; 增加索引
    cmp bx, 5                  ; 检查是否超过输入长度
    je end_input
    jmp input_loop

end_input:
    ; 转换字符串为整数
    mov cx, 0                  ; 清空cx (cx将存储n)
    mov bx, 0                  ; 重新设置索引为0
next_digit:
    cmp bx, 5                  ; 检查是否处理完所有字符
    je calculate_sum
    mov al, num[bx]            ; 取出下一个数字
    inc bx
    mov ah, 0
    mov si, 10
    mul si                     ; 乘以10
    add cx, ax                 ; 累加到CX
    jmp next_digit

calculate_sum:
    ; 计算1到n的累加和
    mov bx, cx                 ; 保存n
    mov ax, 0                  ; 初始化累加和
    mov si, 1                  ; 从1开始
sum_loop:
    add ax, si                 ; 累加当前的si
    inc si                     ; 增加si
    cmp si, bx                 ; 检查是否超过n
    jg display_sum             ; 如果si > n，跳转到显示结果
    jmp sum_loop               ; 否则继续循环

display_sum:
    ; 输出结果
    mov ah, 09h
    lea dx, result_msg
    int 21h

    ; 输出累加和
    call print_number

    ; 换行
    mov ah, 09h
    lea dx, newline
    int 21h

    ; 返回到 DOS
    mov ah, 4Ch
    int 21h

print_number: ; 输出AX中的值 (最多5位)
    mov bx, 10       ; 用于除法
    mov cx, 0        ; 清空CX用于存储数字的位数
print_loop:
    xor dx, dx       ; 清空DX
    div bx           ; AX / 10
    push dx          ; 保存余数
    inc cx           ; 统计位数
    test ax, ax
    jnz print_loop

output_digits:
    pop dx           ; 取出数字
    add dl, '0'      ; 转换为字符
    mov ah, 02h      ; 输出单个字符
    int 21h
    loop output_digits
    ret
end main
