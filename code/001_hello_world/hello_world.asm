; Hello World program
; Compile: nasm -f elf hello_world.asm
; Link: ld -m elf_i386 hello_world.o -o hello_world
; Run: ./hello_world

section .data
  msg db "Hello World!", 0Ah ; assign msg variable with LF at the end

section .text
  global _start

_start:
  mov edx, 13  ; number of bytes to write
  mov ecx, msg ; move the memory address of msg into ecx register
  mov ebx, 1   ; write to the STDOUT
  mov eax, 4   ; invoke SYS_WRITE (kernel opcode 4)
  int 80h      ; Unix System Call interrupt
