; Hello World program (Calculating string length)
; Compile: nasm -f elf hello_world_len.asm
; Link: ld -m elf_i386 hello_world_len.o -o hello_world_len
; Run: ./hello_world_len

section .data
  msg db "Hello, brave new world!", 0Ah

section .text
  global _start

_start:
  mov ebx, msg ; move msg address into ebx
  mov eax, ebx ; move the address in ebx into eax as well

nextchar:
  cmp byte [eax], 0 ; compare the byte pointed to by eax at this address against zero (\NULL)
  jz finished       ; jump (if the zero flagged has been set) to the label "finished"
  inc eax           ; increment the address in eax by one byte
  jmp nextchar      ; jump to "nextchar" label

finished:
  sub eax, ebx ; subtract the address in ebx from the address in eax, store the result to eax

  mov edx, eax ; move the number of bytes into edx
  mov ecx, msg
  mov ebx, 1
  mov eax, 4
  int 80h

  mov ebx, 0
  mov eax, 1
  int 80h
