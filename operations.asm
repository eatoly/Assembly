.text

#PROGRAM BY ETHAN TOLY FOR CPSC 3615 ASSN #2

main:

la $a0, prompt_input
li $v0, 4
syscall

li $v0, 5
syscall

addiu $t0, $v0, 0

li $v0, 5
syscall

addiu $t1, $v0, 0
#########################

la $a0, prompt_add
li $v0, 4
syscall

add $a0, $t0, $t1

li $v0, 1
syscall

la $a0, prompt_newline
li $v0, 4
syscall
#########################

la $a0, prompt_sub
li $v0, 4
syscall

sub $a0, $t0, $t1

li $v0, 1
syscall

la $a0, prompt_newline
li $v0, 4
syscall
#########################

la $a0, prompt_mult
li $v0, 4
syscall

mul $a0, $t0, $t1

li $v0, 1
syscall

la $a0, prompt_newline
li $v0, 4
syscall
#########################

la $a0, prompt_div
li $v0, 4
syscall

div $a0, $t0, $t1

li $v0, 1
syscall

la $a0, prompt_newline
li $v0, 4
syscall
#########################

#end program
li $v0, 10
syscall

.data
size: .word 0

prompt_newline: .asciiz "\n"
prompt_input: .asciiz "Please input two numbers: "
prompt_add: .asciiz "The addition result is: "
prompt_sub: .asciiz "The subtraction result is: "
prompt_mult: .asciiz "The multiplication result is: "
prompt_div: .asciiz "The division result is: "