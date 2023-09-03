; Fork
; Compile: nasm -f elf fork.asm
; Link: ld -m elf_i386 fork.o -o fork
; Run: ./fork

%include "functions.asm"

section .data
  childmsg db "This is the child process", 0h
  parentmsg db "This is the parent process", 0h

section .text
  global _start

_start:
  mov eax, 2 ; invoke SYS_FORK (kernel opcode 2)
  int 80h

  cmp eax, 0 ; if eax is zero, we are in the child process (otherwise child process PID will be returned to the parent process)
  jz child

parent:
  mov eax, parentmsg
  call sprintLF

  call quit

child:
  mov eax, childmsg
  call sprintLF

  call quit
