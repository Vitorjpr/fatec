#16. Faça um algoritmo que leia dois valores correspondentes a anos e mostre quais os anos bissextos existem entre eles.
#(A diferença entre os anos não pode ser maior que 1000)
.data
	msg1: .asciiz "\nInsira dois anos para descobrir os anos bissextos entre eles."
	msg2: .asciiz "\nInsira o primeiro ano: "
	msg3: .asciiz "\nInsira o segundo ano: "
	msg4: .asciiz "\nA diferença entre os anos não pode ser maior que 1000. Insira novamente."
    	msg5: .asciiz "\nOs anos bissextos são: "
	pula: .asciiz "\n"
.text
main:
	#Apresentação
	li $v0, 4
	la $a0, msg1
	syscall

	#Leitura do primeiro ano	
	leitura:
	li $v0, 4
	la $a0, msg2
	syscall	

	li $v0, 5
	syscall
	add $t0, $v0, $zero
	
	#Leitura do segundo ano
	li $v0, 4
	la $a0, msg3
	syscall
	
	li $v0, 5
	syscall
	add $t1, $v0, $zero
	j qmaior

	#Diferenca maior que 1000
	difmaior:
	li $v0, 4
	la $a0, msg4
	syscall
	j leitura
	
	#Saber qual o maior valor de ano
	qmaior:
	bgt $t0, $t1, A1		
	j A2

	#Primeiro ano sendo maior
	A1:
	sub $t2, $t0, $t1
	bgt $t2, 1000, difmaior
	
	li $v0, 4
	la $a0, msg5
   	syscall

	#Enquanto A2 for menor que A1
	enquantoA2:
	ble $t1, $t0, contA2
	j Fim
	
	contA2: 
	rem $t3, $t1, 4		# A2 % 4
	rem $t4, $t1, 100	# A2 % 100
	rem $t5, $t1, 400	# A2 % 400
	j Test1A2  

    	#Primeiro teste: A2 % 4 == 0
	Test1A2:
	beqz $t3, Test2A2
	j contadorA2

	#Segundo teste: A2 % 100 != 0
	Test2A2:
	bnez $t4, mostraA2
	j Test3A2
	
	#Terceiro teste: A2 % 400 == 0
	Test3A2:
	beqz $t5, mostraA2
	j contadorA2

	#Contador do A2
	contadorA2:
	add $t1, $t1, 1
	j enquantoA2

	#Mostrar bissextos do A2
	mostraA2:
	li $v0, 4
	la $a0, pula
	syscall
	li $v0, 1
	add $a0, $t1, $zero
	syscall
	j contadorA2
	
	#Segundo ano sendo maior
	A2:
	sub $t2, $t1, $t0
	bgt $t2, 1000, difmaior
	
	li $v0, 4
	la $a0, msg5
   	syscall
   	
   	#Enquanto A1 for menor que A2
	enquantoA1:
	ble $t0, $t1, contA1
	j Fim
	
	contA1: 
	rem $t3, $t0, 4		# A1 % 4
	rem $t4, $t0, 100	# A1 % 100
	rem $t5, $t0, 400	# A1 % 400
	j Test1A1

    	#Primeiro teste: A1 % 4 == 0
	Test1A1:
	beqz $t3, Test2A1
	j contadorA1

	#Segundo teste: A1 % 100 != 0
	Test2A1:
	bnez $t4, mostraA1
	j Test3A1
	
	#Terceiro teste: A1 % 400 == 0
	Test3A1:
	beqz $t5, mostraA1
	j contadorA1

	contadorA1:
	add $t0, $t0, 1
	j enquantoA1

	#Mostrar bissextos do A1
	mostraA1:
	li $v0, 4
	la $a0, pula
	syscall
	li $v0, 1
	add $a0, $t0, $zero
	syscall
	j contadorA1
	
	#Final do programa
	Fim:
	li $v0, 10
	syscall
