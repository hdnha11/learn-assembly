; Namespace
; Compile: nasm -f elf namespace.asm
; Link: ld -m elf_i386 namespace.o -o namespace
; Run: ./namespace

%include "functions.asm"

section .data
  msg1 db "Jumping to finished label.", 0h
  msg2 db "Inside subroutine number: ", 0h
  msg3 db 'Inside subroutine "finished".', 0h

section .text
  global _start

_start:

subroutine_one:
  mov eax, msg1  ; printing msg1
  call sprintLF  ; print with LF
  jmp .finished  ; jump to the local label

.finished:
  mov eax, msg2 ; printing msg2
  call sprint   ; print without LF
  mov eax, 1    ; printing 1
  call iprintLF ; print with LF

subroutine_two:
  mov eax, msg1  ; printing msg1
  call sprintLF  ; print with LF
  jmp .finished  ; jump to the local label

.finished:
  mov eax, msg2 ; printing msg2
  call sprint   ; print without LF
  mov eax, 2    ; printing 2
  call iprintLF ; print with LF

  mov eax, msg1  ; printing msg1
  call sprintLF  ; print with LF
  jmp finished   ; jump to the global label

finished:
  mov eax, msg3 ; printing msg3
  call sprintLF ; print with LF
  call quit     ; quit
