; Time
; Compile: nasm -f elf time.asm
; Link: ld -m elf_i386 time.o -o time
; Run: ./time

%include "functions.asm"

section .data
  msg db "Seconds since Jan 01, 1970: ", 0h

section .text
  global _start

_start:
  mov eax, msg
  call sprint

  mov eax, 13 ; invoke SYS_TIME (kernel opcode 13)
  int 80h

  call iprintLF ; print the returned Unix Timestamp
  call quit
