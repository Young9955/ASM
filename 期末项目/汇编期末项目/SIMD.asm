mov ecx, 1000
mov esi, 0
loop_start:
 movdqu xmm0, [array + esi*4] ; 加载128位数据
 paddw xmm0, xmm0             ; 两个16位整数相加
 movdqu [array + esi*4], xmm0 ; 存储结果
 add esi, 8                   ; 一次处理8个整数
 cmp esi, ecx
 jl loop_start
