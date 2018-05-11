.text

main:

####################
#read input
####################

input:

#prints input prompt
la $a0, prompt_input
li $v0, 4
syscall

#gets number
li $v0, 5
syscall

#checks if num is > 0 and < 12
li $t0, 0
ble $v0, $t0, input
li $t0, 12
bge $v0, $t0, input

sw $v0, num 

j func_factorial
exit_func_factorial:


####################
#write output
####################


#prints output prompt
lw $a0, num
li $v0, 1
syscall

la $a0, prompt_output
li $v0, 4
syscall

#prints result
addiu $a0, $t1, 0
li $v0, 1
syscall

#end program
li $v0, 10
syscall

##############
#functions
##############

##############
#factorial
##############

func_factorial:
lw $t0, num

li $t1, 1

loop: 
mul $t1, $t1, $t0 
addi $t0, $t0, -1 
bgtz $t0, loop 

j exit_func_factorial

##############
#data
##############

.data
num: .word 0

prompt_space: .asciiz " "
prompt_input: .asciiz "Please enter a number between 0 and 12 to compute the factorial of: "
prompt_newline: .asciiz "\n"
prompt_output: .asciiz " factorial is: "