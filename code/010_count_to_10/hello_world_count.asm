; Hello World program (Count to 10)
; Compile: nasm -f elf hello_world_count.asm
; Link: ld -m elf_i386 hello_world_count.o -o hello_world_count
; Run: ./hello_world_count

%include "functions.asm"

section .text
  global _start

_start:
  mov ecx, 0 ; init ecx (counter) to zero

nexti:
  inc ecx

  mov eax, ecx
  add eax, 48 ; to ASCII

  push eax
  mov eax, esp ; get the address from the stack, remember SYS_WRITE need string address
  call sprintLF
  pop eax

  cmp ecx, 10 ; have we reached 10 yet?
  jne nexti

  call quit
