section .data
    menu_msg db 'menu:', 0xA, 0xD
    msg_a db 'a. Hola Mundo!!!', 0xA, 0xD
    msg_b db 'b. Feliz Dia del Amor y la Amistad!!!', 0xA, 0xD
    msg_c db 'c. Feliz Navidad!!!', 0xA, 0xD
    msg_d db 'd. Feliz Dia de la Independencia!!!', 0xA, 0xD
    msg_e db 'e. Otro (ingrese su propio mensaje)', 0xA, 0xD
    msg_f db 'f. Finalizar el Programa.', 0xA, 0xD
    prompt_msg db '  Ingrese su opcion: ', 0xA, 0xD
    goodbye_msg db '¡Adios!', 0xA, 0xD
    continue_msg db "Presione cualquier tecla excepto la f para continuar:", 0xA, 0xD

section .bss
    option resb 2
    custom_msg resb 64

section .text
    global _start

_start:

	jmp print_menu

    print_menu:
        mov rax, 1
        mov rdi, 1
        mov rsi, menu_msg
        mov rdx, 6
        syscall

        mov rsi, msg_a
        mov rdx, 17
        call print_message

        mov rsi, msg_b
        mov rdx, 39
        call print_message
        
        mov rsi, msg_c
        mov rdx, 21
        call print_message
        
        mov rsi, msg_d
        mov rdx, 37
        call print_message
        
        mov rsi, msg_e
        mov rdx, 37
        call print_message
        
        mov rsi, msg_f
        mov rdx, 26
        call print_message
        
        mov rsi, prompt_msg
        mov rdx, 22
        call print_message
        
        jmp input_option
        
    input_option:
        mov rax, 0          ; syscall number for sys_read
        mov rdi, 0          ; file descriptor 0 (stdin)
        mov rsi, option     ; store input
        mov rdx, 2          ; number of bytes to read
        syscall

    select_option:
        mov al, [option]
        cmp al, 'f'
        je exit_program
        cmp al, 'e'
        je custom_message
        cmp al, 'a'
        je print_hello_world
        cmp al, 'b'
        je print_valentines_day
        cmp al, 'c'
        je print_christmas
        cmp al, 'd'
        je print_independence_day
        jmp invalid_option

    print_hello_world:
        mov rsi, msg_a
        mov rdx, 17
        call print_message
        jmp ask_continue

    print_valentines_day:
        mov rsi, msg_b
        mov rdx, 39
        call print_message
        jmp ask_continue

    print_christmas:
        mov rsi, msg_c
        mov rdx, 21
        call print_message
        jmp ask_continue

    print_independence_day:
        mov rsi, msg_d
        mov rdx, 37
        call print_message
        jmp ask_continue

    custom_message:
        mov rsi, msg_e
        mov rdx, 37
        call print_message
        
        
        ; Solicitar mensaje personalizado
        mov rsi, prompt_msg
        mov rdx, 22
        call print_message

        ; Leer el mensaje personalizado
        mov rax, 0
        mov rdi, 0
        mov rsi, custom_msg
        mov rdx, 64
        syscall

        ; Imprimir el mensaje personalizado
        call print_message
        jmp ask_continue

    print_message:
        mov rax, 1
        mov rdi, 1
        syscall
        ret

    ask_continue:
        mov rsi, continue_msg
	mov rdx, 54
	call print_message
        
        jmp input_continue

    input_continue:
        mov rax, 0
        mov rdi, 0
        mov rsi, option
        mov rdx, 2
        syscall

        cmp byte [option], 'f'
        jne print_menu
        jmp exit_program

    invalid_option:
        ; Mensaje de opción inválida
        jmp print_menu

    exit_program:
        ; Mensaje de despedida
        mov rsi, goodbye_msg
        mov rdx, 8
        call print_message

        ; Salir del programa
        mov rax, 60         ; syscall number for sys_exit
        xor rdi, rdi        ; exit code 0
        syscall
