.section .data
menu_msg:
    .asciz "menu:\n"
msg_a:
    .asciz "a. Hola Mundo!!!\n"
msg_b:
    .asciz "b. Feliz Dia del Amor y la Amistad!!!\n"
msg_c:
    .asciz "c. Feliz Navidad!!!\n"
msg_d:
    .asciz "d. Feliz Dia de la Independencia!!!\n"
msg_e:
    .asciz "e. Otro (ingrese su propio mensaje)\n"
msg_f:
    .asciz "f. Finalizar el Programa.\n"
prompt_msg:
    .asciz "  Ingrese su opcion: \n"
goodbye_msg:
    .asciz "¡Adios!\n"
continue_msg:
    .asciz "Presione cualquier tecla excepto la f para continuar:\n"

.section .bss
.option:
    .lcomm option, 2
custom_msg:
    .lcomm custom_msg, 64

.section .text
.globl _start

_start:

    jmp print_menu

print_menu:
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
    mov $0, %rax            # syscall number for sys_read
    mov $0, %rdi            # file descriptor 0 (stdin)
    mov $option, %rsi       # store input
    mov $2, %rdx            # number of bytes to read
    syscall

select_option:
    mov (%option), %al
    cmp $'f', %al
    je exit_program
    cmp $'e', %al
    je custom_messageFunc
    cmp $'a', %al
    je print_hello_world
    cmp $'b', %al
    je print_valentines_day
    cmp $'c', %al
    je print_christmas
    cmp $'d', %al
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

custom_messageFunc:
    mov $msg_e, %rsi
    mov $37, %rdx
    call print_message

# Solicitar mensaje personalizado
    mov $prompt_msg, %rsi
    mov $22, %rdx
    call print_message

    # Leer el mensaje personalizado
    mov $0, %rax
    mov $0, %rdi
    mov $custom_msg, %rsi
    mov $64, %rdx
    syscall

    # Imprimir el mensaje personalizado
    call print_message
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
    mov $option, %rsi
    mov $2, %rdx
    syscall

    cmpb $'f', (%option)
    jne print_menu
    jmp exit_program

invalid_option:
    # Mensaje de opción inválida
    jmp print_menu

exit_program:
    # Mensaje de despedida
    mov $goodbye_msg, %rsi
    mov $8, %rdx
    call print_message

    # Salir del programa
    mov $60, %rax         # syscall number for sys_exit
    xor %rdi, %rdi        # exit code 0
    syscall


