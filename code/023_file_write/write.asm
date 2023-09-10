; Write
; Compile: nasm -f elf write.asm
; Link: ld -m elf_i386 write.o -o write
; Run: ./write

%include "functions.asm"

section .data
  filename: db "readme.txt", 0h
  contents: db "Hello world!", 0h
  contents_len: equ $-contents

section .text
  global _start

_start:
  mov ecx, 0777o    ; read, write and execute permissions
  mov ebx, filename ; filename to create
  mov eax, 8        ; invoke SYS_CREAT (kernel opcode 8)
  int 80h           ; call the kernel

  mov edx, contents_len ; number of bytes to write
  mov ecx, contents     ; memory address of contents string
  mov ebx, eax          ; file descriptor of created file
  mov eax, 4            ; invoke SYS_WRITE (kernel opcode 4)
  int 80h               ; call the kernel

  call quit ; exit program
