; Socket
; Compile: nasm -f elf socket.asm
; Link: ld -m elf_i386 socket.o -o socket
; Run: ./socket

%include "functions.asm"

section .text
  global _start

_start:
  ; syscalls (/usr/include/asm/unistd_32.h)
  ; socketcall numbers (/usr/include/linux/net.h)

  xor eax, eax ; init eax 0
  xor ebx, ebx ; init ebx 0
  xor edi, edi ; init edi 0
  xor esi, esi ; init esi 0

; Creating the socket file descriptor
; int socket(int domain, int type, int protocol);
; socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
_socket:
  ; socket arguments (bits/socket.h, netinet/in.h)
  push byte 6 ; push 6 onto the stack (IPPROTO_TCP)
  push byte 1 ; push 1 onto the stack (SOCK_STREAM)
  push byte 2 ; push 2 onto the stack (PF_INET)

  mov ecx, esp ; move address of arguments into ecx

  mov ebx, 1   ; invoke subroutine SOCKET (1)
  mov eax, 102 ; invoke SYS_SOCKETCALL (kernel opcode 102)
  int 80h      ; call the kernel

  call iprintLF ; print the file descriptor of created socket or -1 on error

_exit:
  call quit ; exit the program
