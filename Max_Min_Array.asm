.text

#PROGRAM BY ETHAN TOLY FOR CPSC 3615 ASSN #1

main:
#prints list size prompt
la $a0, prompt_input_size
li $v0, 4
syscall

#gets list size
li $v0, 5
syscall

#move size to $t1
addiu $t1, $v0, 0

#set loop counter($t2) to 0
li $t2, 0

la $t0, list #loads address of start of list

loop:
beq $t2, $t1, exit #checks that loop counter($t2) is strictly less than elements($t1) 

#prints prompt
la $a0, prompt_input_element
li $v0, 4
syscall

li $v0, 5 #gets input number
syscall

addiu $t3, $t0, 0 #stores start of list($t0) to $t3

sll $t3, $t2, 2  #multiplies loop counter by 4 and stores in $t3
add $t3, $t3, $t0 #adds $t3 to start of list
sw $v0, 0($t3) #input($v0) is stored at $t3

addiu $t2, $t2, 1 #update loop counter
j loop
exit:

###########################
#load arguments here
addiu $a1, $t1, 0 #move size($t1) to $a1
la $a2, list #load start address to $a2

j func_max
exit_func_max:

#load arguments here
addiu $a1, $t1, 0 #move size($t1) to $a1
la $a2, list #load start address to $a2

j func_min
exit_func_min:
###################################

#prints prompt
la $a0, prompt_output
li $v0, 4
syscall

#set loop counter($t2) to 0
li $t2, 0

loop_write:
beq $t2, $t1, exit_write #checks that loop counter($t2) is strictly less than elements($t1) 

addiu $t3, $t0, 0 #stores start of list($t0) to $t3

sll $t3, $t2, 2  #multiplies loop counter by 4 and stores in $t3
add $t3, $t3, $t0 #adds $a1 to start of list
lw $a0, 0($t3) #element is stored at $t3

#prints element
li $v0, 1
syscall

#prints space
la $a0, prompt_space
li $v0, 4
syscall

addiu $t2, $t2, 1 #update loop counter

j loop_write
exit_write:

#end program
li $v0, 10
syscall



################
#ROUTINES
################

func_max:

#set loop counter($t2) to 0
li $t2, 0

lw $v1, 0($a2) #set running max to first element

loop1:
beq $t2, $a1, exit1 #checks that loop counter($t2) is strictly less than elements($t1)

addiu $t3, $a2, 0 #stores start of list($a2) to $t3

sll $t3, $t2, 2  #multiplies loop counter by 4 and stores in $t3
add $t3, $t3, $a2 #adds $t3 to start of list

lw $t4, 0($t3)

bgt $v1, $t4, notgreater #check if current element is greater than max
addiu $v1, $t4, 0
notgreater:

addiu $t2, $t2, 1 #update loop counter

j loop1
exit1:

#print the prompt and the max
la $a0, prompt_max
li $v0, 4
syscall

addiu $a0, $v1, 0
li $v0, 1
syscall

la $a0, prompt_newline
li $v0, 4
syscall

j exit_func_max





func_min:

#set loop counter($t2) to 0
li $t2, 0

lw $v1, 0($a2) #set running min to first element

loop2:
beq $t2, $a1, exit2 #checks that loop counter($t2) is strictly less than elements($t1)

addiu $t3, $a2, 0 #stores start of list($a2) to $t3

sll $t3, $t2, 2  #multiplies loop counter by 4 and stores in $t3
add $t3, $t3, $a2 #adds $t3 to start of list

lw $t4, 0($t3)

blt $v1, $t4, notless #check if current element is greater than max
addiu $v1, $t4, 0
notless:

addiu $t2, $t2, 1 #update loop counter

j loop2
exit2:

#print the prompt and the max
la $a0, prompt_min
li $v0, 4
syscall

addiu $a0, $v1, 0
li $v0, 1
syscall

la $a0, prompt_newline
li $v0, 4
syscall

j exit_func_min



.data
list: .space 100
size: .word 0

dataflag1: .word 0x12345678
charflag1: .ascii "abc"
dataflag4: .word 0x22227890
prompt_space: .asciiz " "
prompt_max: .asciiz "The greatest element is: "
prompt_min: .asciiz "The smallest element is: "
prompt_newline: .asciiz "\n"
prompt_output: .asciiz "The elements in the list are: \n"
prompt_input_size: .asciiz "Please enter the size of the list: \n"
prompt_input_element: .asciiz "Please enter the element\n"
dataflag2: .word 0x99996666