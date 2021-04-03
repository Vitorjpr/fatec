#declarar.
#	a, b, c :
#inteiro;
#inicio.
#	mostra("Digite um numero inteiro: ");
#	ler(a);
#	c = 0
#	faça.
#		b = a * c
#		c = c + 1 
#		mostra (b)
#		enquanto(c <= 10)
#	fim.
#	
	.data
		msg1: .asciiz"\nDigite um num. int.: "
		msg2: .asciiz"\n"
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
		li $t2, 0
		
		enquanto:
		mul $t1, $t0, $t2
		add $t2, $t2, 1
		
		#mostra $t1
		li $v0, 1
		add $a0, $t1, $zero
		syscall
		
		#Inserindo quebra de linha
		li $v0, 4
		la $a0, msg2
		syscall
		
		
		#enquanto(c <= 10)
		ble $t2, 10, enquanto