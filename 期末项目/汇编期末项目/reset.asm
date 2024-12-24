mov ecx, 1000
mov esi, 0
loop_start:
 mov eax, esi
 add esi, 1
 shl eax, 1
 mov [array + esi*4 - 4], eax
 cmp esi, ecx
 jl loop_start
