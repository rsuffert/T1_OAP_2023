.text
.globl main
main:
la $a0, str1
li $v0,4 #Programa Ackermann:
syscall 

la $a0, str2 #Para qualquer um dos parametros, digite um numero negativo para encerrar.:
li $v0,4
syscall 

la $a0, str3 #Digite o valor de 'm':
li $v0,4
syscall

 
li $v0, 5 #Le do teclado o valor de m
syscall
move $s0, $v0
bltz $s0, exit
la $t0, m
sw $v0, 0($t0)

la $a0, str4 #Digite o valor de 'n': Resultado: 
li $v0,4
syscall 

li $v0, 5 #Le do teclado o valor de n
syscall
move $s1, $v0
la $t0, n
sw $v0, 0($t0)

la $a0, str5 #Resultado
li $v0,4
syscall

exit:
li $v0, 10
syscall

.data
n:		.word 0 			
m:		.word 0
str1:		.asciiz "Programa Ackermann:\n"
str2:		.asciiz	"Para qualquer um dos parametros, digite um numero negativo para encerrar.:\n"
str3:		.asciiz "Digite o valor de 'm': " 
str4:		.asciiz "Digite o valor de 'n': "
str5:		.asciiz "Resultado: "
  