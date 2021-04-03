#ler 2 números e calcular a área de um retangulo
.data
	msg1: .asciiz"\nDigite o primeiro numero: "
	msg2: .asciiz"\nDigite o segundo numero: "
	msg3: .asciiz"\nA area do retangulo e: "
.text
main:
	#mostra(msg1)
	li $v0, 4                       #v0 recebe cód 4
	la $a0, msg1                    #a0 recebe msg1
	syscall                         #chamada de sistema
	
	#ler($t0)
	li $v0, 5                       #$v0 recebe 5
	syscall                         #chamada de sistema
	add $t0, $v0, $zero 
	
	#mostra(msg2)
	li $v0, 4                       #v0 recebe cód 4
	la $a0, msg2                    #a0 recebe msg1
	syscall                         #chamada de sistema
	
	#ler($t1)
	li $v0, 5                       #$v0 recebe 5
	syscall                         #chamada de sistema
	add $t1, $v0, $zero 
	
	mul $t2, $t1, $t0
	
	#mostra(msg3)
	li $v0, 4                       #v0 recebe cód 4
	la $a0, msg3                    #a0 recebe msg1
	syscall
	
	#mostra $t2
	li $v0, 1
	add $a0, $t2, $zero
	syscall