; Execute Command (ls)
; Compile: nasm -f elf executels.asm
; Link: ld -m elf_i386 executels.o -o executels
; Run: ./executels

%include "functions.asm"

section .data
  cmd db "/bin/ls", 0h
  arg1 db "..", 0h
  arg2 db "-la", 0h
  args dd cmd, arg1, arg2, 0h
  envs dd 0h

section .text
  global _start

_start:
  mov edx, envs
  mov ecx, args
  mov ebx, cmd
  mov eax, 11
  int 80h

  call quit
