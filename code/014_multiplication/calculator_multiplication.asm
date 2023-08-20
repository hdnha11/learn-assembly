; Calculator (Multiplication)
; Compile: nasm -f elf calculator_multiplication.asm
; Link: ld -m elf_i386 calculator_multiplication.o -o calculator_multiplication
; Run: ./calculator_multiplication

%include "functions.asm"

section .text
  global _start

_start:
  mov eax, 42  ; first operand
  mov ebx, 7   ; second operand
  mul ebx      ; multiply eax by ebx
  call iprintLF

  call quit
