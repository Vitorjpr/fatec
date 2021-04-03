#ler 2 números e calcular a área de um retangulo
.data
	msg1: .asciiz"Por favor, insira um numero entre 0 e 10: "
	msg2: .asciiz"Numero Invalido. "
	msg3: .asciiz"Loop ok"
	msg4: .asciiz"Valor do fatorial e: 1\n"
	msg5: .asciiz"Valor do fatorial e: "
	msg6: .asciiz"Final do programa. "
	quebralinha: .asciiz"\n"
.text
main:
	#mostra(msg1)
	li $v0, 4
	la $a0, msg1
	syscall
	
	#ler(a)
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	
	blt $t0, $zero, msgerro
	bgt $t0, 10, msgerro
	beq $t0, $zero, eum
	j processa
	
	eum:
		#mostra(msg1)
		li $v0, 4
		la $a0, msg4
		syscall
		j fim
		
	msgerro:
		#mostra(msg1)
		li $v0, 4
		la $a0, msg2
		syscall
		j main
	
	processa:
		sub $t1, $t0, 1
		add $t3, $t0, $zero
		
		
		faca:
			mul $t3, $t1, $t3
			sub $t1, $t1, 1
			beq $t1, 1, msgfinal
			j faca
		
		li $v0, 1
		add $a0, $t2, $zero
		syscall
		
		beq $t1, 1, msgfinal
		j processa
		
		
	msgfinal:
		#mostra(msg5)
		li $v0, 4
		la $a0, msg5
		syscall
		
		li $v0, 1
		add $a0, $t3, $zero
		syscall
		
		#mostra(msg5)
		li $v0, 4
		la $a0, quebralinha
		syscall
		
		j fim
	fim:
		#mostra(msg1)
		li $v0, 4
		la $a0, msg6
		syscall