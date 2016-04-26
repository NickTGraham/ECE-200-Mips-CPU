#Code Based off of example from class.
             addi $a4, $zero, 8 #load data into $a0, should be done at compile time, but...
             addi $ra, $zero, DISPLAY #Set the stack first return address to outside the function
             addi $sp, $zero, 24 #Set initial Stack pointer
factorial:   slti   $t0,  $a0,  1 #Check to see if input is 1, if it is, we can return 1.
             beq   $t0,  $zero,  ELSE
             addi   $v0, $zero, 1
             jr $ra
ELSE:        addi   $a0, $a0,  ‐1 #if its not, store return address, and decrease input, call again.
             addi $sp, $sp,  ‐4
             sw   $ra, 0($sp)
             jal   factorial
             lw $ra, 0($sp) #upon returning, replace stack pointer, increase input
             addi $sp, $sp, 4
             addi $a0, $a0, 1
             mult $zero, $v0, $a0 #multiply result by input
             mflo $v0, $zero, $zero #move result into $v0, ignoring top cause for our purposes wont need
             jr $ra #return
DISPLAY:     or $v0, $v0, $zero #force it to display the final result at the end.
