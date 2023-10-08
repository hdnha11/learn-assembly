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

; Binding the socket with an address type
; int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
; bind(sockfd, [AF_INET, 9001, INADDR_ANY], 16)
_bind:
  mov edi, eax ; move return value of SYS_SOCKETCALL into edi (file descriptor for new socket, or -1 on error) for saving the returned socket file descriptor

  ; building the sockaddr_in struct (sys/socket.h, netinet/in.h and bits/sockaddr.h)
  push dword 0x00000000 ; push 0 decimal onto the stack IP ADDRESS (0.0.0.0), INADDR_ANY = 0 (uint32_t)
  push word 0x2923      ; push 9001 decimal onto the stack PORT (reverse byte order) (uint16_t)
  push word 2           ; push 2 decimal onto stack AF_INET = 2 (unsigned short int)
  mov ecx, esp          ; move address of stack pointer into ecx (struct pointer)

  ; bind arguments (sys/socket.h)
  push byte 16 ; push 16 decimal onto stack (arguments length), sockaddr struct size = sizeof(struct sockaddr) = 16 (socklen_t)
  push ecx     ; push the address of arguments onto stack, sockaddr_in struct pointer (struct sockaddr *)
  push edi     ; push the file descriptor onto stack, socket fd (int)

  mov ecx, esp ; move address of arguments into ecx (ptr to argument array)

  mov ebx, 2   ; invoke subroutine BIND (sys_bind 2)
  mov eax, 102 ; invoke SYS_SOCKETCALL (kernel opcode 102)

  int 80h ; call the kernel

; Preparing to listen the incoming connection (passive socket)
; int listen(int sockfd, int backlog);
; listen(sockfd, 0);
_listen:
  ; listen arguments
  push byte 1  ; move 1 onto stack (backlog - max queue length argument)
  push edi     ; push the file descriptor onto stack (socket fd)

  mov ecx, esp ; move address of arguments into ecx (ptr to argument array)

  mov ebx, 4   ; invoke subroutine LISTEN (sys_listen 4)
  mov eax, 102 ; invoke SYS_SOCKETCALL (kernel opcode 102)

  int 80h ; call the kernel

_exit:
  call quit ; exit the program
