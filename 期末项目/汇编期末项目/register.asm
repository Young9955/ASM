mov ecx, 1000
mov esi, 0
loop_start:
 mov eax, esi
 shl eax, 1             ; 替代乘法操作
 mov [array + esi*4], eax
 add esi, 1
 cmp esi, ecx
 jl loop_start
