; FizzBuzz
; Compile: nasm -f elf fizzbuzz.asm
; Link: ld -m elf_i386 fizzbuzz.o -o fizzbuzz
; Run: ./fizzbuzz

%include "functions.asm"

section .data
  fizz db "Fizz", 0h
  buzz db "Buzz", 0h

section .text
  global _start

_start:
  mov ecx, 0 ; i counter (1-100)
  mov edi, 0 ; is_fizz flag
  mov esi, 0 ; is_buzz flag

nexti:
  inc ecx

.check_fizz:
  mov edx, 0        ; clear edx (the remainder)
  mov ebx, 3
  mov eax, ecx
  div ebx           ; i / 3
  mov edi, edx      ; store the remainder in edi
  cmp edi, 0        ; check if divisible by 3
  jne .check_buzz
  mov eax, fizz     ; print Fizz
  call sprint       ; defer printing LF for .check_int

.check_buzz:
  mov edx, 0        ; clear edx (the remainder)
  mov ebx, 5
  mov eax, ecx
  div ebx           ; i / 5
  mov esi, edx      ; store the remainder in esi
  cmp esi, 0        ; check if divisible by 5
  jne .check_int
  mov eax, buzz     ; print Buzz
  call sprint       ; defer printing LF for .check_int

.check_int:
  cmp edi, 0        ; check is_fizz
  je .continue      ; skip if is_fizz
  cmp esi, 0        ; check_buzz
  je .continue      ; skip if is_buzz
  mov eax, ecx
  call iprint       ; print i without LF

.continue:
  mov eax, 0Ah      ; ASCII LF
  push eax          ; push LF onto the stack
  mov eax, esp      ; LF address on the stack
  call sprint       ; print LF (only print LF here)
  pop eax           ; clean up resource in the stack
  cmp ecx, 100      ; are we there yet
  jne nexti         ; not yet

  call quit
