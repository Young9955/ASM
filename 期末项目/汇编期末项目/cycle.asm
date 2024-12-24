mov ecx, 1000
mov esi, 0
loop_start:
 mov eax, [array + esi*4]
 add eax, eax
 mov [array + esi*4], eax
 add esi, 1
 mov eax, [array + esi*4]
 add eax, eax
 mov [array + esi*4], eax
 add esi, 1
 cmp esi, ecx
 jl loop_start
