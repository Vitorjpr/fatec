; Descricao do exercicio
; Receber 2 numeros inteiros e verificar se o mesmo é par ou impar e exibir o resultado.

.data
	msg1: .asciiz"\nDigite um num. int.: "
	msg2: .asciiz"\nPar"
	msg3: .asciiz"\nImpar"
.text
main:
	#mostra(msg1)
	li $v0, 4                       #v0 recebe cód 4
	la $a0, msg1                    #a0 recebe msg1
	syscall                         #chamada de sistema
	
	#ler(t0)
	li $v0, 5                       #$v0 recebe 5
	syscall                         #chamada de sistema
	add $t0, $v0, $zero             #também podia ser add $t0, $v0, 0 - Estou colocando o valor de v0 em t0
	
	rem $t1, $t0, 2                 #t1 recebe t0 mod 2
	
	#Se t1 == 0 va para label se
	beq $t1, 0, se
	j senao
	
	se:
	#mostra(msg2)
	li $v0, 4
	la $a0, msg2
	syscall
	j fimse
	
	
	senao:
	#mostra(msg3)
	li $v0, 4
	la $a0, msg3
	syscall
	
	fimse: