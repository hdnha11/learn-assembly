; Hello World program (NULL terminating bytes)
; Compile: nasm -f elf hello_world_inc.asm
; Link: ld -m elf_i386 hello_world_inc.o -o hello_world_inc
; Run: ./hello_world_inc

%include "functions.asm"

section .data
  msg1 db "Hello, brave new world!", 0Ah, 0h         ; \NULL terminated
  msg2 db "This is how we recycle in NASM.", 0Ah, 0h ; \NULL terminated

section .text
  global _start

_start:
  mov eax, msg1
  call sprint

  mov eax, msg2
  call sprint

  call quit
