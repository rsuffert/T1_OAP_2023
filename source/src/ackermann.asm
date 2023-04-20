.text
.globl main
main:
#print("Programa Ackermann")
la $a0, str1
li $v0, 4
syscall 

#print("Para qualquer um dos parametros, digite um numero negativo para encerrar:")
la $a0, str2
li $v0, 4
syscall 

#print("Digite o valor de 'm': ")
la $a0, str3
li $v0, 4
syscall
# m = in.nextInt() (lendo 'm' do teclado)
li $v0, 5
syscall
move $s0, $v0
bltz $s0, exit
la   $t0, m
sw   $v0, 0($t0)

#print("Digite o valor de 'n': ")
la $a0, str4
li $v0, 4
syscall 
# n = in.nextInt() (lendo 'n' do teclado)
li $v0, 5
syscall
move $s1, $v0
bltz $s1, exit
la   $t0, n
sw   $v0, 0($t0)

move $a0, $s1  # movendo 'n' para $a0 (parametro)
move $a1, $s0  # movendo 'm' para $a1 (parametro)
jal  ackermann # chamada da funcao
move $s2, $v0  # movendo o resultado (retorno) da funcao para $s2

#print("Resultado: ")
la $a0, str5
li $v0, 4
syscall

#print(ackermann(m, n))
li   $v0, 1
move $a0, $s2
syscall

exit:
li $v0, 10
syscall

#--------------------------------- DEFINICAO DA FUNCAO ACKERMANN -------------------------------------------------
ackermann:
# Salvamento de contexto na pilha
addi $sp, $sp, -16
sw   $t0, 12($sp) # $t0 - resultado da funcao
sw   $ra, 8($sp)  # $ra - endereco de retorno
sw   $a0, 4($sp)  # $a0 - valor de m
sw   $a1, 0($sp)  # $a1 - valor de n

# if (m == 0)
bnez $a0, condicao1
addi $a1, $a1, 1     # n = n + 1
move $t0, $a1
j    fim

condicao1: 
blez $a0, condicao2  # (if m > 0)
bnez $a1, condicao2  # (if n == 0)
sub  $a0, $a0, 1     # m = m-1
li   $a1, 1	      # n = 1
jal  ackermann
move $t0, $v0        # $t0 = ackermann(m-1, 1)

condicao2:
blez $a0, fim     #if (m > 0)
blez $a1, fim     #if (n > 0)
subi $a1, $a1, 1  #n = n-1
jal  ackermann
move $a1, $v0     #n = ackermann(m, n-1)
subi $a0, $a0, 1  #m = m-1
jal  ackermann
move $t0, $v0     #$t0 = ackermann(m-1, ackermann(m, n-1))

fim: move $v0, $t0

# Recuperacao de contexto na pilha
lw   $a1, 0($sp) # valor de n
lw   $a0, 4($sp) # valor de m
lw   $ra, 8($sp) # endereco de retorno
lw   $t0, 12($sp) # resultado da funcao
addi $sp, $sp, 16

jr   $ra

.data
n:		.word 0 			
m:		.word 0
str1:		.asciiz "PROGRAMA ACKERMANN\n"
str2:		.asciiz	"Para qualquer um dos parametros, digite um numero negativo para encerrar:\n"
str3:		.asciiz "Digite o valor de 'm': " 
str4:		.asciiz "Digite o valor de 'n': "
str5:		.asciiz "Resultado: "
