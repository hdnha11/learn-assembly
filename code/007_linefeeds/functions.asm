; ----------------------------------------
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

; ----------------------------------------
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

; ----------------------------------------
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

; ----------------------------------------
; void quit()
; Exit program and restore resources
quit:
  mov ebx, 0
  mov eax, 1
  int 80h
  ret
