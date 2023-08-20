; Hello World program (Passing arguments from the command line)
; Compile: nasm -f elf hello_world_args.asm
; Link: ld -m elf_i386 hello_world_args.o -o hello_world_args
; Run: ./hello_world_args "This is one argument" "This is another"

%include "functions.asm"

section .text
  global _start

_start:
  pop ecx ; first value on the stack is the number of arguments

nextarg:
  cmp ecx, 0h     ; check if we have any arguments left
  jz no_more_args ; jump if no more arguments
  pop eax         ; get the next arg
  call sprintLF   ; print next arg with LF
  dec ecx         ; decrease ecx by 1
  jmp nextarg     ; repeat

no_more_args:
  call quit
