section .data
    msg1 db "Ingrese el primer número entre 0 y 9: ", 0xA
    len_msg1 equ $-msg1
    msg2 db "Ingrese el segundo número entre 0 y 9: ", 0xA
    len_msg2 equ $-msg2
    msg3 db "Ingrese el tercer número entre 0 y 9: ", 0xA
    len_msg3 equ $-msg3
    msg_result db "El resultado de la resta es: ", 0xA
    len_msg_result equ $-msg_result
    newline db 10 ; Salto de línea

section .bss
    num1 resb 6
    num2 resb 6
    num3 resb 6
    result resb 6

section .text
    global _start

_start:
    call capturar_numeros
    call restar_numeros
    call imprimir_resultado
    call fin_programa

capturar_numeros:
    ; Imprimir mensaje para el primer número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len_msg1
    int 80h

    ; Leer primer número desde el teclado
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 6   ; Leer hasta 5 caracteres y un byte extra para el null terminator
    int 80h

    ; Imprimir mensaje para el segundo número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len_msg2
    int 80h

    ; Leer segundo número desde el teclado
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 6   ; Leer hasta 5 caracteres y un byte extra para el null terminator
    int 80h

    ; Imprimir mensaje para el tercer número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len_msg3
    int 80h

    ; Leer tercer número desde el teclado
    mov eax, 3
    mov ebx, 0
    mov ecx, num3
    mov edx, 6   ; Leer hasta 5 caracteres y un byte extra para el null terminator
    int 80h

    ret

restar_numeros:
    ; Convertir los números de ASCII a enteros
    movzx ax, byte [num1]
    sub ax, '0'
    movzx bx, byte [num2]
    sub bx, '0'
    movzx cx, byte [num3]
    sub cx, '0'
    ; Restar los tres números
    sub ax, bx
    sub ax, cx

    ; Convertir el resultado de entero a ASCII
    add ax, '0'

    ; Almacenar el resultado en result
    mov [result], ax

    ret

imprimir_resultado:
    ; Imprimir mensaje indicando que se mostrará el resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_result
    mov edx, len_msg_result
    int 80h

    ; Imprimir el resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1   ; Solo un byte, el resultado
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ret

fin_programa:
    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 80h
