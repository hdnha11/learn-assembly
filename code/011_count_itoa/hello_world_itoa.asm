; Hello World program (Count to 100 itoa)
; Compile: nasm -f elf hello_world_itoa.asm
; Link: ld -m elf_i386 hello_world_itoa.o -o hello_world_itoa
; Run: ./hello_world_itoa

%include "functions.asm"

section .text
  global _start

_start:
  mov ecx, 0

nexti:
  inc ecx
  mov eax, ecx
  call iprintLF ; call new integer printing function
  cmp ecx, 100
  jne nexti

  call quit
