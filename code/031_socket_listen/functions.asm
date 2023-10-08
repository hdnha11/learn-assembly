;------------------------------------------------------------
; int atoi(Integer number)
; ASCII to integer function (atoi)
atoi:
  push esi
  push ecx
  push ebx
  push edx

  mov esi, eax ; keep the number to convert inside esi, pointer to first char
  mov eax, 0   ; the return value (converted number)
  mov ecx, 0   ; counter

.mutiply_loop:
  xor ebx, ebx      ; reset ebx (both lower and upper halfs)
  mov bl, [esi+ecx] ; load next char to bl (ebx lower half)
  cmp bl, 48        ; check if the char is >= char '0' (ASCII 48)
  jl .finished
  cmp bl, 57        ; check if the char is <= char '9' (ASCII 57)
  jg .finished

  sub bl, 48        ; ASCII to integer
  add eax, ebx      ; add current digit to the result at unit position (eax is always ending with zero e.g., 0, x0, xx0...)
  mov ebx, 10       ; base 10
  mul ebx           ; multiply eax by 10, make room for the unit position
  inc ecx           ; increase our counter
  jmp .mutiply_loop ; continute

.finished:
  cmp ecx, 0  ; check if anything was parsed
  je .restore ; no digits was parsed, return 0
  mov ebx, 10 ; base 10
  mov edx, 0  ; ensure no extended for eax (edx:eax pair) when dividing
  div ebx     ; remove the last zero in the result (we multiplied more than expected 1 time)

.restore:
  pop edx
  pop ebx
  pop ecx
  pop esi
  ret

;------------------------------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
  push eax
  push ecx
  push edx
  push esi

  mov ecx, 0  ; counter
  mov esi, 10 ; base 10

.divide_loop:
  inc ecx
  mov edx, 0 ; empty edx, otherwise edx:eax (64-bit) / esi (32-bit) will cause overflow error
  idiv esi   ; eax = eax / esi, edx = eax % esi

  add edx, 48 ; to ASCII
  push edx    ; push current digit onto stack, need to print in the reverse order

  cmp eax, 0 ; can be divided anymore?
  jne .divide_loop

.print_loop:
  dec ecx

  mov eax, esp ; get the digit from stack
  call sprint
  pop eax      ; remove last digit from the stack

  cmp ecx, 0 ; have we printed all digits we pushed onto the stack?
  jne .print_loop

  pop esi
  pop edx
  pop ecx
  pop eax
  ret

;------------------------------------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
  call iprint

  push eax
  mov eax, 0Ah ; LF
  push eax
  mov eax, esp
  call sprint
  pop eax
  pop eax

  ret

;------------------------------------------------------------
; int slen(String message)
; String length calculation function
slen:
  push ebx
  mov ebx, eax

.nextchar:
  cmp byte [eax], 0
  jz .finished
  inc eax
  jmp .nextchar

.finished:
  sub eax, ebx
  pop ebx
  ret

;------------------------------------------------------------
; void sprint(String message)
; String printing function
sprint:
  push edx
  push ecx
  push ebx
  push eax

  push eax
  call slen
  mov edx, eax
  pop eax

  mov ecx, eax
  mov ebx, 1
  mov eax, 4
  int 80h

  pop eax
  pop ebx
  pop ecx
  pop edx
  ret

;------------------------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
  push eax ; preserve eax

  call sprint

  mov eax, 0Ah ; move the LF character into eax
  push eax     ; push the LF character onto the stack
  mov eax, esp ; get the current stack pointer address
  call sprint  ; print LF
  pop eax      ; remove LF from the stack

  pop eax ; restore eax
  ret

;------------------------------------------------------------
; void quit()
; Exit program and restore resources
quit:
  mov ebx, 0
  mov eax, 1
  int 80h
  ret
