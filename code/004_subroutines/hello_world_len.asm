; Hello World program (Subroutines)
; Compile: nasm -f elf hello_world_len.asm
; Link: ld -m elf_i386 hello_world_len.o -o hello_world_len
; Run: ./hello_world_len

section .data
  msg db "Hello, brave new world!", 0Ah

section .text
  global _start

_start:
  mov eax, msg ; string that need to calculate the length
  call strlen  ; call strlen function to calculate the string length

  mov edx, eax ; the return length is in eax
  mov ecx, msg
  mov ebx, 1
  mov eax, 4
  int 80h

  mov ebx, 0
  mov eax, 1
  int 80h

strlen:    ; this is our first function
  push ebx ; preserve ebx in the stack memory
  mov ebx, eax

.nextchar: ; local label start with a period
  cmp byte [eax], 0
  jz .finished
  inc eax
  jmp .nextchar

.finished:
  sub eax, ebx ; push the return length into eax
  pop ebx      ; restore ebx
  ret          ; return to where the function was called
