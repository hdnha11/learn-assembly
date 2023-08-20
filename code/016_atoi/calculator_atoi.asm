; Calculator (atoi)
; Compile: nasm -f elf calculator_atoi.asm
; Link: ld -m elf_i386 calculator_atoi.o -o calculator_atoi
; Run: ./calculator_atoi 20 42 2024

%include "functions.asm"

section .text
  global _start

_start:
  pop ecx    ; number of arguments
  pop edx    ; program name (will be discarded)
  sub ecx, 1 ; number of arguments without program name
  mov edx, 0 ; storing sum in the data register

nextarg:
  cmp ecx, 0h     ; any arguments left
  jz no_more_args
  pop eax         ; next argument
  call atoi       ; convert input ASCII string to decimal integer
  add edx, eax    ; calculate sum
  dec ecx
  jmp nextarg
  
no_more_args:
  mov eax, edx ; for printing
  call iprintLF
  call quit
