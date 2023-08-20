; Calculator (Addition)
; Compile: nasm -f elf calculator_addition.asm
; Link: ld -m elf_i386 calculator_addition.o -o calculator_addition
; Run: ./calculator_addition

%include "functions.asm"

section .text
  global _start

_start:
  mov eax, 42  ; first operand
  mov ebx, 7   ; second operand
  add eax, ebx ; add ebx to eax
  call iprintLF

  call quit
