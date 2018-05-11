#PROGRAM BY ETHAN TOLY

.text

main:

####################
#reading
####################

#prints name prompt
la $a0, prompt_input_name
li $v0, 4
syscall

#gets name string
li $v0, 8
la $a0, full_name
li $a1, 100
syscall

####################
#get position of space
####################

#set address counter($t0) to start of full_name
la $t0, full_name

li $a3, 0x20 #loads value of space into $a3

loop:
lb $t1, 0($t0) #$t0 is put into $t1

beq $t1, $a3, exit #checks that #t1 is not the space

addiu $t0, $t0, 1 #increment address counter
j loop
exit:

sw $t0, space_address #store address of space

####################
#get position of newline
####################

#set address counter($t0) to start of full_name
la $t0, full_name

li $a3, 0x0a  #loads value of newline into $a3

loop1:
lb $t1, 0($t0) #$t0 is put into $t1

beq $t1, $a3, exit1 #checks that #t1 is not the newline

addiu $t0, $t0, 1 #increment address counter
j loop1
exit1:

sw $t0, newline_address #puts the address of the newline into newline_address

####################
#printing first name backwards
####################

#set address counter($t0) to space address
lw $t0, space_address
addi $t0, $t0, -1

la $a3, full_name

loop2:

lb $a0, 0($t0) #char at $t0 is put into $a0

li $v0, 11 #print char
syscall

beq $t0, $a3, exit2 #checks that #t1 is not the start

addi $t0, $t0, -1 #decrement address counter
j loop2
exit2:

####################
#printing space
####################

li $a0, 0x20 #loads value of space into $a3
li $v0, 11 #print char
syscall

####################
#printing last name backwards
####################

#set address counter($t0) to end address
lw $t0, newline_address
addi $t0, $t0, -1

#set $a3 to space address
lw $a3, space_address

loop3:
beq $t0, $a3, exit3 #checks that #t0 is not the space

lb $a0, 0($t0) #char at $t0 is put into $a0

li $v0, 11 #print char
syscall

addi $t0, $t0, -1 #decrement address counter
j loop3
exit3:

#end program
li $v0, 10
syscall

.data
full_name: .space 100
space_address: .word 0
newline_address: .word 0

prompt_input_name: .asciiz "Please enter your first and last name seperated by a space: \n"