#2. Fazer um algoritmo que receba um número (1 < número <= 50000) e 
# demonstre o primeiro número primo após a ele e o primeiro número primo antes dele.

.data
	msg1: .asciiz"Por favor, insira um numero entre 1 e 50.000: "
	msg2: .asciiz"Validacao ok."
	msgerro: .asciiz"Numero invalido. "
.text
main:
	#mostra a msg1
	li $v0, 4
	la $a0, msg1
	syscall
	
	#recebe ao numero digitado pelo usuario
	li $v0, 5
	syscall
	
	#valida se o numero atende aos criterios do enunciado
	blt $v0, 1, mensagem_erro
	bgt $v0, 50000, mensagem_erro
	
	add $t0, $v0, $zero
	add $t1, $t0, $zero
	div $t2, $t1, 2
	j primo_apos
	
	mensagem_erro:
		#mostra msgerro
		li $v0, 4
		la $a0, msgerro
		syscall
		j main
		
	primo_apos:
		#zera o contador e acumulador
		move $t8, $zero
		move $t9, $zero
		
		