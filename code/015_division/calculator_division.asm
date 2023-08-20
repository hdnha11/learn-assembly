; Calculator (Division)
; Compile: nasm -f elf calculator_division.asm
; Link: ld -m elf_i386 calculator_division.o -o calculator_division
; Run: ./calculator_division

%include "functions.asm"

section .data
  msg db " remainder " ; output message

section .text
  global _start

_start:
  mov eax, 42   ; first operand
  mov ebx, 7    ; second operand
  div ebx       ; divide eax by ebx
  call iprint 
  mov eax, msg
  call sprint
  mov eax, edx  ; move the remainder into eax
  call iprintLF

  call quit
