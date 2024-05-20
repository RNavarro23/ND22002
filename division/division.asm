section .data
    msg1 db "Ingrese un numero entre 0 y 9: ", 0xA
    len_msg1 equ $-msg1
    msg2 db "Ingrese otro numero entre 0 y 9: ", 0xA
    len_msg2 equ $-msg2
    msg_result db "El resultado de la división es: ", 0xA
    len_msg_result equ $-msg_result
    msg_error db "Error: División por cero.", 0xA
    len_msg_error equ $-msg_error
    newline db 10 ; Salto de línea

section .bss
    dividend resb 6
    divisor resb 6
    result resb 6

section .text
    global _start

_start:
    call capturar_numeros
    call dividir_numeros
    jmp imprimir_resultado

capturar_numeros:
    ; Imprimir mensaje para el dividendo
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len_msg1
    int 80h

    ; Leer el dividendo desde el teclado
    mov eax, 3
    mov ebx, 0
    mov ecx, dividend
    mov edx, 2   ; Leer solo 1 carácter y un byte extra para el null terminator
    int 80h

    ; Imprimir mensaje para el divisor
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len_msg2
    int 80h

    ; Leer el divisor desde el teclado
    mov eax, 3
    mov ebx, 0
    mov ecx, divisor
    mov edx, 2   ; Leer solo 1 carácter y un byte extra para el null terminator
    int 80h

    ret

dividir_numeros:
    ; Convertir los números de ASCII a enteros
    movzx eax, byte [dividend]
    sub eax, '0'
    movzx ebx, byte [divisor]
    sub ebx, '0'

    ; Verificar si el divisor es cero
    cmp ebx, 0
    je divisor_cero

    ; Realizar la división
    xor edx, edx  ; Limpiar edx antes de la división
    div ebx       ; Dividir eax por ebx, cociente en eax, residuo en edx

    ; Convertir el resultado de entero a ASCII
    add eax, '0'

    ; Almacenar el resultado en result
    mov [result], eax

    ret

divisor_cero:
    ; Si el divisor es cero, imprimir mensaje de error y salir del programa
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_error
    mov edx, len_msg_error
    int 80h

    jmp fin_programa

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

    jmp fin_programa

fin_programa:
    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 80h
