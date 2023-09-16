; Unlink
; Compile: nasm -f elf unlink.asm
; Link: ld -m elf_i386 unlink.o -o unlink
; Run: ./unlink

%include "functions.asm"

section .data
  filename: db "readme.txt", 0h

section .text
  global _start

_start:
  mov ebx, filename ; filename we will delete
  mov eax, 10       ; invoke SYS_UNLINK (kernel opcode 10)
  int 80h           ; call the kernel

  call quit ; exit program
