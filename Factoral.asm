#Code Based off of example from class.
             addi $a0, $zero, 8 #load data into $a0, should be done at compile time, but...
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

I Could not get the online assembler to work at all, so doing this by hand.

001000 00000 00100 00000 00000 001000 #addi $r4 = 8
001000 00000 01111 00000 00000 001000 #addi $15 = 8 TODO: Set to actual end result location.
001000 00000 01101 00000 00000 011000 #addi $r13 = 24
001010 00100 01000 00000 00000 000001 #$r8 = ($r4 < 1)
000100 00000 01000 00000 00000 000010 #go to else (2 instructions ahead)
001000 00000 00010 00000 00000 000001 #$r2 = 1
000000 01111 00000 00000 00000 001000 #jr $r15
001000 00100 00100 11111 11111 111111 #$r4 = $r4 - 1
001000 01101 00101 11111 11111 111100 #$r13 = $r23 - 4
101001 01101 01111 00000 00000 000000 #store $ra into mem
000011 00000 00000 00000 00000 010000 #jal back to factorial
100001 01101 01111 00000 00000 000000 #load $ra from mem
001000 00000 00100 00000 00000 000001 #$r4 = $r4 + 1
001000 00000 01101 00000 00000 000100 #$r13 = $r13 + 4
000000 00010 00100 00000 00000 011000 #mult $r2 * $r4
000000 00000 00000 00010 00000 010010 #move lower result into $r2
000000 01111 00000 00000 00000 001000 #jr $r15
000000 00000 00010 00010 00000 100101 #or $v0 and $zero to display output
