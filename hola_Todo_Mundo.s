.section .data

menu_msg: .ascii "menu:\n\r"
msg_a: .ascii "a. Hola Mundo!!!\n\r"
msg_b: .ascii "b. Feliz Dia del Amor y la Amistad!!!\n\r"
msg_c: .ascii "c. Feliz Navidad!!!\n\r"
msg_d: .ascii "d. Feliz Dia de la Independencia!!!\n\r"
msg_e: .ascii "e. Otro (ingrese su propio mensaje)\n\r"
msg_f: .ascii "f. Finalizar el Programa.\n\r"
prompt_msg: .ascii "  Ingrese su opcion: \n\r"
goodbye_msg: .ascii "¡Adios!\n\r"
continue_msg: .ascii "Presione cualquier tecla excepto la f para continuar:\n\r"
option_length: .quad option_end - option

.section .bss
    option: .space 2
    option_end:
    .lcomm custom_msg, 64

.section .text
.global _start

_start:
    mov $1, %rax
    mov $1, %rdi
    mov $menu_msg, %rsi
    mov $6, %rdx
    syscall

    mov $msg_a, %rsi
    mov $17, %rdx
    call print_message

    mov $msg_b, %rsi
    mov $39, %rdx
    call print_message

    mov $msg_c, %rsi
    mov $21, %rdx
    call print_message

    mov $msg_d, %rsi
    mov $37, %rdx
    call print_message

    mov $msg_e, %rsi
    mov $37, %rdx
    call print_message

    mov $msg_f, %rsi
    mov $26, %rdx
    call print_message

    mov $prompt_msg, %rsi
    mov $22, %rdx
    call print_message

    jmp input_option

input_option:
    mov $0, %rax
    mov $0, %rdi
    lea option, %rsi
    mov $option_length, %rdx
    syscall
    
    jmp select_option

select_option:
    mov option, %al
    cmpb $'f', %al
    je exit_program
    cmpb $'e', %al
    je custom_message
    cmpb $'a', %al
    je print_hello_world
    cmpb $'b', %al
    je print_valentines_day
    cmpb $'c', %al
    je print_christmas
    cmpb $'d', %al
    je print_independence_day
    jmp invalid_option


print_hello_world:
    mov $msg_a, %rsi
    mov $17, %rdx
    call print_message
    jmp ask_continue

print_valentines_day:
    mov $msg_b, %rsi
    mov $39, %rdx
    call print_message
    jmp ask_continue

print_christmas:
    mov $msg_c, %rsi
    mov $21, %rdx
    call print_message
    jmp ask_continue

print_independence_day:
    mov $msg_d, %rsi
    mov $37, %rdx
    call print_message
    jmp ask_continue

custom_message:
    mov $msg_e, %rsi
    mov $37, %rdx
    call print_message

    mov $prompt_msg, %rsi
    mov $22, %rdx
    call print_message

    # Receive custom message
    mov $0, %rax
    mov $0, %rdi
    lea custom_msg, %rsi  
    mov $64, %rdx
    syscall

     # Print debug: Check if custom message is correctly received
    mov $1, %rax
    mov $1, %rdi
    lea custom_msg, %rsi 
    mov $64, %rdx
    syscall

    
    jmp ask_continue


print_message:
    mov $1, %rax
    mov $1, %rdi
    syscall
    ret

ask_continue:
    mov $continue_msg, %rsi
    mov $54, %rdx
    call print_message
    
    jmp input_continue

input_continue:
    mov $0, %rax
    mov $0, %rdi
    lea option, %rsi
    mov $option_length, %rdx
    syscall

    cmpb $'f', option
    jne print_menu
    jmp exit_program

invalid_option:
    # Mensaje de opción inválida
    jmp _start

exit_program:
    # Mensaje de despedida
    mov $goodbye_msg, %rsi
    mov $8, %rdx
    call print_message

    # Salir del programa
    mov $60, %rax        
    xor %rdi, %rdi      
    syscall

