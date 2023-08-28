; Execute Command
; Compile: nasm -f elf execute.asm
; Link: ld -m elf_i386 execute.o -o execute
; Run: ./execute

%include "functions.asm"

section .data
  cmd db "/bin/echo", 0h ; command to execute
  arg1 db "Hello World!", 0h
  args dd cmd  ; arguments to pass to the command line
       dd arg1 ; array of pointers (contains address, that why we use dd here)
       dd 0h   ; end the struct (array)
               ; another form: args dd cmd, arg1, 0h
  envs dd 0h   ; arguments to pass to the environment variables (in this case none) end the struct

section .text
  global _start

_start:
  mov edx, envs ; address of environment variables
  mov ecx, args ; address of command line arguments
  mov ebx, cmd  ; address of the command to execute
  mov eax, 11   ; invoke SYS_EXECVE (kernel opcode 11)
  int 80h

  call quit
