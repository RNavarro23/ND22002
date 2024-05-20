section .data
    msg db 'El resultado es: '
    msglen equ $ - msg
    newline db 10 ; Salto de línea

section .bss
resultado resb 2

section .text
global _start

_start:
    mov al, 4
    mov cl, 2

    mul cl

    add al, 48
    mov [resultado], al

    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msglen
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    mov ebx, 0
    int 0x80

