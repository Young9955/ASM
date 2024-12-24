mov ecx, 1000      ; 循环计数器
mov esi, 0         ; 数组索引
loop_start:
    mov eax, [array + esi*4] ; 加载数组元素
    add eax, eax             ; 元素值翻倍
    mov [array + esi*4], eax ; 存储结果
    add esi, 1               ; 索引递增
    loop loop_start          ; 循环
