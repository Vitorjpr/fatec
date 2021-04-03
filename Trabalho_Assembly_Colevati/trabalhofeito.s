.data

   msg1: .asciiz"\nDigite um numero entre 1 e 50000: "
   msg2: .asciiz"\nO valor que voce digitou esta incorreto digite novamente."
   msg3: .asciiz"\nNao ha numero primo antes desse valor. "
   msg4: .asciiz"\nO primo anterior foi : "
   msg5: .asciiz"\nO primo posterior foi : "
   
.text

main:
	#mostra(msg1)
	li $v0, 4
	la $a0, msg1
	syscall
   
	#ler(msg1)
	li $v0, 5
	syscall
   
	add $t1, $0, $v0 #t1 é o numero digitado		
   
	#Validação do numero digitado:

	blt $t1, 1, se1
	bgt $t1, 50000, se1
	beq $t1, 2, qfor2

	j comeco
 
se1:
	#mostra(msg2)
	li $v0, 4
	la $a0, msg2
	syscall
   
	j main
   
qfor2:
	#mostra(msg3)
	li $v0, 4
	la $a0, msg3
	syscall
   
	j depois
comeco:
	add $t0, $zero, 2
for1:
	#$t0 = i
	#$t2 = cont
	#$t3 = j
	#$t4 = resto
	add $t2, $zero, 0
	add $t3, $zero, 1
for2:
	rem $t4, $t0, $t3
	beq $t4, 0, contsoma
	possoma:
	add $t3, $t3, 1
ble $t3, $t0, for2
	beq $t2, 2, antes
	dantes:	
	add $t0, $t0, 1 
blt $t0, $t1, for1

	#mostrar o antes
	li $v0, 4
	la $a0, msg4
	syscall
	
	li $v0, 1
	add $a0, $t5, $zero
	syscall
	
	j depois
	
contsoma:

add $t2, $t2, 1
j possoma

antes:
	#$t5 = antes
	add $t5, $t0, $zero 
	j dantes

depois:
	#t0 = x
	#t2 = cont
	#t3 = i
	#t4 = resto
	#t1 = n
	#t5 = j
	#t6 = n - 1
	#t7 = depois
	add $t0, $zero, 1
forx:
	add $t1, $t1, 1
	sub $t6, $t1, 1
	move $t3, $t6
fori:
	add $t2, $zero, 0
	add $t5, $zero, 1
forj:
	rem $t4, $t3, $t5
	beq $t4, 0, somacont2
	possoma2:
blt $t5, $t3, forj
	beq $t2, 2, ndepois
	posdepois:
blt $t0, $t6, fori
blt $t0, $t1, forx

	#mostrar primo depois
	li $v0, 4
	la $a0, msg5
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	j fim
somacont2:
	add $t2, $t2, 1
	j possoma2
	
ndepois:
	add $t7, $t3, $zero
	move $t0, $t1
	j posdepois

fim: