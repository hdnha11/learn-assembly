; Read
; Compile: nasm -f elf read.asm
; Link: ld -m elf_i386 read.o -o read
; Run: ./read

%include "functions.asm"

section .data
  filename: db "readme.txt", 0h
  contents: db "Hello world!", 0h
  contents_len: equ $-contents

section .bss
  file_contents: resb 255 ; buffer to store file contents

section .text
  global _start

_start:
  mov ecx, 0777o    ; read, write and execute permissions
  mov ebx, filename ; filename to create
  mov eax, 8        ; invoke SYS_CREAT (kernel opcode 8)
  int 80h           ; call the kernel

  mov edx, contents_len ; number of bytes to write
  mov ecx, contents     ; memory address of contents string
  mov ebx, eax          ; file descriptor of created file
  mov eax, 4            ; invoke SYS_WRITE (kernel opcode 4)
  int 80h               ; call the kernel

  mov ecx, 0        ; flag for readonly access mode (O_RDONLY - 0), other modes: O_WRONLY - 1, O_RDWR - 2
  mov ebx, filename ; filename we created above
  mov eax, 5        ; invoke SYS_OPEN (kernel opcode 5)
  int 80h           ; call the kernel

  mov edx, contents_len  ; number of bytes to read
  mov ecx, file_contents ; buffer memory address
  mov ebx, eax           ; previous opened file descriptor
  mov eax, 3             ; invoke SYS_READ (kernel opcode 3)
  int 80h                ; call the kernel

  mov eax, file_contents ; file contents memory address
  call sprintLF          ; print out the file contents

  call quit ; exit program
