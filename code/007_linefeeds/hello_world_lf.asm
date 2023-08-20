; Hello World program (Print with line feed)
; Compile: nasm -f elf hello_world_lf.asm
; Link: ld -m elf_i386 hello_world_lf.o -o hello_world_lf
; Run: ./hello_world_lf

%include "functions.asm"

section .data
  msg1 db "Hello, brave new world!", 0h         ; without the LF character 0Ah
  msg2 db "This is how we recycle in NASM.", 0h ; without the LF character 0Ah

section .text
  global _start

_start:
  mov eax, msg1
  call sprintLF ; calling the new print with linefeed function

  mov eax, msg2
  call sprintLF ; calling the new print with linefeed function

  call quit
