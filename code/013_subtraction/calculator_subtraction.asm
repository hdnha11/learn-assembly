; Calculator (Subtraction)
; Compile: nasm -f elf calculator_subtraction.asm
; Link: ld -m elf_i386 calculator_subtraction.o -o calculator_subtraction
; Run: ./calculator_subtraction

%include "functions.asm"

section .text
  global _start

_start:
  mov eax, 42  ; first operand
  mov ebx, 7   ; second operand
  sub eax, ebx ; sub ebx from eax
  call iprintLF

  call quit
