; Seek
; Compile: nasm -f elf seek.asm
; Link: ld -m elf_i386 seek.o -o seek
; Run: ./seek

%include "functions.asm"

section .data
  filename: db "readme.txt", 0h
  contents: db "-updated-", 0h
  contents_len: equ $-contents

section .text
  global _start

_start:
  mov ecx, 1        ; O_WRONLY
  mov ebx, filename ; file to open
  mov eax, 5        ; invoke SYS_OPEN (kernel opcode 5)
  int 80h           ; call the kernel

  mov edx, 2   ; whence argument (SEEK_SET: 0, SEEK_CUR: 1, SEEK_END: 2)
  mov ecx, 0   ; move the cursor 0 bytes (offset)
  mov ebx, eax ; opened file descriptor
  mov eax, 19  ; invoke SYS_LSEEK (kernel opcode 19)
  int 80h      ; call the kernel

  mov edx, contents_len ; number of bytes to write
  mov ecx, contents     ; contents string memory address
  mov ebx, ebx          ; opened file descriptor (not required)
  mov eax, 4            ; invoke SYS_WRIRE (kernel opcode 4)
  int 80h               ; call the kernel

  call quit ; exit program
