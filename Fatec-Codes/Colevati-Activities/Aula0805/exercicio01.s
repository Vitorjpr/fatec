#Fazer em assembly MIPS um algoritmo que leia um número inteiro (n) e exiba o resultado da expressao abaixo (1 <= n >= 50)
#Formula Exp = n^3 + n^2 + n^1 + n^0

.data
	msg1: .asciiz"Por favor, digite um numero inteiro: \n"
	msg2: .asciiz"O resultado da conta é: \n"	
.text
main:
	#Mostrando msg1
	li $v0, 4
	la $a0, msg1
	syscall
	
	#Lendo numero 
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	
	
