; Hello World program (External file include)
; Compile: nasm -f elf hello_world_inc.asm
; Link: ld -m elf_i386 hello_world_inc.o -o hello_world_inc
; Run: ./hello_world_inc

%include "functions.asm" ; include our external file

section .data
  msg1 db "Hello, brave new world!", 0Ah         ; our first message
  msg2 db "This is how we recycle in NASM.", 0Ah ; our second message

section .text
  global _start

_start:
  mov eax, msg1 ; move the address of our first message into eax
  call sprint   ; call our string printing function

  mov eax, msg2 ; move the address of our second message into eax
  call sprint   ; call our string printing function

  call quit ; call our quit function
