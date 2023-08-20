; Hello World program
; Compile: nasm -f elf hello_world.asm
; Link: ld -m elf_i386 hello_world.o -o hello_world
; Run: ./hello_world

section .data
  msg db "Hello World!", 0Ah

section .text
  global _start

_start:
  mov edx, 13
  mov ecx, msg
  mov ebx, 1
  mov eax, 4
  int 80h

  mov ebx, 0 ; return 0 as error code
  mov eax, 1 ; invoke SYS_EXIT (kernel opcode 1)
  int 80h
