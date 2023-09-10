; Create
; Compile: nasm -f elf create.asm
; Link: ld -m elf_i386 create.o -o create
; Run: ./create

%include "functions.asm"

section .data
  filename: db "readme.txt", 0h

section .text
  global _start

_start:
  mov ecx, 0777o    ; read, write and execute permissions
  mov ebx, filename ; filename to create
  mov eax, 8        ; invoke SYS_CREAT (kernel opcode 8)
  int 80h           ; call the kernel

  call quit ; exit program
