.text

main:

#PROGRAM WRITEN BY ETHAN TOLY FOR CPSC 3615 IN LAB ASSINGNMENT

####################
#writing
####################

#prints list size prompt
la $a0, prompt_input_size
li $v0, 4
syscall

#gets list size
li $v0, 5
syscall

sw $v0, size

#move size to $t1
addiu $t1, $v0, 0

#set loop counter($t0) to 0
li $t0, 0

la $t2, list #loads address of start of list

loop:
beq $t0, $t1, exit #checks that loop counter($t0) is strictly less than elements($t1) 

#prints prompt
la $a0, prompt_input_element
li $v0, 4
syscall

li $v0, 5 #gets input number
syscall


sll $t3, $t0, 2  #multiplies loop counter by 4 and stores in $t3
add $t3, $t3, $t2 #adds $t3 to start of list
sw $v0, 0($t3) #input($v0) is stored at $t3

addiu $t0, $t0, 1 #update loop counter
j loop
exit:

j func_sort
exit_func_sort:


####################
#reading
####################

#prints prompt
la $a0, prompt_output
li $v0, 4
syscall

li $t0, 0 #set loop counter($t0) to 0
lw $t1, size #set elements($t1)

loop_write:
beq $t0, $t1, exit_write #checks that loop counter($t0) is strictly less than elements($t1) 

sll $t3, $t0, 2  #multiplies loop counter by 4 and stores in $t3
add $t3, $t3, $t2 #adds $t3 to start of list($t2)
lw $a0, 0($t3) #element is stored at $t3

#prints element
li $v0, 1
syscall

#prints space
la $a0, prompt_space
li $v0, 4
syscall

addiu $t0, $t0, 1 #update loop counter

j loop_write
exit_write:

#end program
li $v0, 10
syscall

##############
#functions
##############

###################
#max
###################

func_max:

addiu $t4, $a1, 0 #move size($a1) to $t4
addiu $t5, $a2, 0 #load start address to $t5

#set loop counter($t3) to 0
li $t3, 0

lw $t6, 0($t5) #set running max to first element

loop1:
beq $t3, $t4, exit1 #checks that loop counter($t3) is strictly less than elements($t4)

sll $t7, $t3, 2  #multiplies loop counter by 4 and stores in $t7
add $t8, $t7, $t5 #adds $t7 to start of list

lw $t7, 0($t8)

bgt $t6, $t7, notgreater #check if current element is greater than max
addiu $t6, $t7, 0
addiu $a1, $t8, 0 # save address of max element
notgreater:

addiu $t3, $t3, 1 #update loop counter

j loop1
exit1:

addi $t4, $t4, -1
sll $a0, $t4, 2 #multiplies size-1 by 4 and stores in $a0
add $a0, $t5, $a0 #add start address to store last address in $a0 

j exit_func_max

###################
#swap
###################

func_swap:
#a0 is address of first elememt
#a1 is address of second elememt

lw $t6, 0($a0)
lw $t7, 0($a1)

sw $t6, 0($a1)
sw $t7, 0($a0)
j exit_func_swap

###################
#sorting
###################

func_sort:

la $t1, size #set size
lw $t1, 0($t1)
la $t2, list #set start address 
addiu $t0, $t1, 0 #set loop counter to size

loop3:
beq $t0, $zero, done_sort

#load arguments here
addiu $a1, $t0, 0 #move counter size($t0) to $a1
la $a2, list #load start address to $a2

j func_max
exit_func_max:

j func_swap
exit_func_swap:

addi $t0, $t0, -1
j loop3

done_sort:

j exit_func_sort

.data
list: .space 100
size: .word 0

prompt_space: .asciiz " "
prompt_max: .asciiz "The greatest element is: "
prompt_newline: .asciiz "\n"
prompt_output: .asciiz "The elements in the list sorted are: \n"
prompt_input_size: .asciiz "Please enter the size of the list: \n"
prompt_input_element: .asciiz "Please enter the element\n"