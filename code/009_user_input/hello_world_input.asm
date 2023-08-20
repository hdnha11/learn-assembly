; Hello World program (Getting intput)
; Compile: nasm -f elf hello_world_input.asm
; Link: ld -m elf_i386 hello_world_input.o -o hello_world_input
; Run: ./hello_world_input

%include "functions.asm"

section .data
  msg1 db "Please enter your name: ", 0h
  msg2 db "Hello, ", 0h

section .bss
  sinput resb 255 ; reserve a 255 byte space in memory for the users input string

section .text
  global _start

_start:
  mov eax, msg1
  call sprint

  mov edx, 255    ; number of bytes to read
  mov ecx, sinput ; reserved space to store our input (known as a buffer)
  mov ebx, 0      ; read from the STDIN
  mov eax, 3      ; invoke SYS_READ (kernel opcode 3)
  int 80h

  mov eax, msg2
  call sprint

  mov eax, sinput ; move our buffer into eax (Note: input contains a linefeed)
  call sprint

  call quit
