.section .data
	menu_msg: .asciz 'menu:', 0xA, 0xD
	msg_a: .asciz 'a. Hola Mundo!!!', 0xA, 0xD
	msg_b: .asciz 'b. Feliz Dia del Amor y la Amistad!!!', 0xA, 0xD
	msg_c: .asciz 'c. Feliz Navidad!!!', 0xA, 0xD
	msg_d: .asciz 'd. Feliz Dia de la Independencia!!!', 0xA, 0xD
	msg_e: .asciz 'e. Otro (ingrese su propio mensaje)', 0xA, 0xD
	msg_f: .asciz 'f. Finalizar el Programa.', 0xA, 0xD
	prompt_msg: .asciz '  Ingrese su opcion: ', 0xA, 0xD
	goodbye_msg: .asciz '¡Adios!', 0xA, 0xD
	continue_msg: .asciz "Presione cualquier tecla excepto la f para continuar:", 0xA, 0xD
.section .bss
	.lcomm option, 2
	.lcomm custom_msg, 64
.section .text
	.globl _start
	_start:
	jmp print_menu
print_menu:
	mov 1, rax
	mov 1, rdi
	mov menu_msg, rsi
	mov 6, rdx
	syscall
	mov msg_a, rsi
	mov 17, rdx
	call print_message
	mov msg_b, rsi
	mov 39, rdx
	call print_message
	mov msg_c, rsi
	mov 21, rdx
	call print_message
	mov msg_d, rsi
	mov 37, rdx
	call print_message
	mov msg_e, rsi
	mov 37, rdx
	call print_message
	mov msg_f, rsi
	mov 26, rdx
	call print_message
	mov prompt_msg, rsi
	mov 22, rdx
	call print_message
	jmp input_option
input_option:
	mov 0, rax
	mov 0, rdi
	mov option, rsi
	mov 2, rdx
	syscall
select_option:
	mov [option], al
	cmp 'f', al
	je exit_program
	cmp 'e', al
	je custom_message
	cmp 'a', al
	je print_hello_world
	cmp 'b', al
	je print_valentines_day
	cmp 'c', al
	je print_christmas
	cmp 'd', al
	je print_independence_day
	jmp invalid_option
	print_hello_world:
	mov msg_a, rsi
	mov 17, rdx
	call print_message
	jmp ask_continue
	print_valentines_day:
	mov msg_b, rsi
	mov 39, rdx
	call print_message
	jmp ask_continue
	print_christmas:
	mov msg_c, rsi
	mov 21, rdx
	call print_message
	jmp ask_continue
	print_independence_day:
	mov msg_d, rsi
	mov 37, rdx
	call print_message
	jmp ask_continue
custom_message:
	mov msg_e, rsi
	mov 37, rdx
	call print_message
	mov prompt_msg, rsi
	mov 22, rdx
call print_message
	mov 0, rax
	mov 0, rdi
	mov custom_msg, rsi
	mov 64, rdx
	syscall
	call print_message
	jmp ask_continue
print_message:
	mov 1, rax
	mov 1, rdi
	syscall
	ret
	ask_continue:
	mov continue_msg, rsi
	mov 54, rdx
	call print_message
	jmp input_continue
	input_continue:
	mov 0, rax
	mov 0, rdi
	mov option, rsi
	mov 2, rdx
	syscall
	cmp 'f', [option], byte
	jne print_menu
	jmp exit_program
invalid_option:
	jmp print_menu
exit_program:
	mov goodbye_msg, rsi
	mov 8, rdx
	call print_message
	mov 60, rax
	xor rdi, rdi
	syscall
