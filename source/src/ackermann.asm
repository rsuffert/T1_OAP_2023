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

move $a0, $s0
move $a1, $s1
jal ackermann
move, $s2, $v0

# Exibindo o resultado
la $a0, str5 #Resultado
li $v0,4
syscall

li $v0, 1
move $a0, $s2
syscall

exit:
li $v0, 10
syscall

ackermann:
# Salvamento de contexto na pilha
addi $sp, $sp, -16
sw $t0, 12($sp) # resultado da funcao
sw $ra, 8($sp) # endereco de retorno
sw $a0, 4($sp) # valor de m
sw $a1, 0($sp) # valor de n

# if m = 0
bnez $a0, cond1 # (if m == 0)
addi $a1, $a1, 1 # n = n + 1
move $t0, $a1

cond1: 
blez $a0, cond2 # (if m > 0)
bnez $a1, cond2 # (if n == 0)
sub $a0, $a0, 1 # m = m-1
li  $a1, 1	# n = 1
jal ackermann
move $t0, $v0

cond2:
blez $a0, done
blez $a1, done
subi $a1, $a1, 1
jal ackermann
move $a1, $v0
subi $a0, $a0, 1
jal ackermann
move $t0, $v0

done: move $v0, $t0

# Recuperacao de contexto na pilha
lw $t0, 12($sp) # resultado da funcao
lw $ra, 8($sp) # endereco de retorno
lw $a0, 4($sp) # valor de m
lw $a1, 0($sp) # valor de n
addi $sp, $sp, 16

.data
n:		.word 0 			
m:		.word 0
str1:		.asciiz "Programa Ackermann:\n"
str2:		.asciiz	"Para qualquer um dos parametros, digite um numero negativo para encerrar.:\n"
str3:		.asciiz "Digite o valor de 'm': " 
str4:		.asciiz "Digite o valor de 'n': "
str5:		.asciiz "Resultado: "
