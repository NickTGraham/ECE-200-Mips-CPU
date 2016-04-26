The tests for this are broken into three different modules. They all run the same logic, however they load different instructions in order to test different functions.
The reason for splitting them is to make it easier to follow what is being tested.

To test all of the basic operations, run the CPU module. Here is what the program does.
Preexisting data:
r1 = 3, r2 = 1

add r3 = r1 + r2
addi r4 = r1 + 7
sub r5 = r1 - r2
and r6 = r1 & r2
andi r7 = r1 & 1
nor r8 = r1 nor r2
or r9 = r1 or r2
ori r10 = r1 or 4
lui r11 = all ones, 4'hffff
slt r12 = r1 < r2
slti r13 = r1 < 10

To test the load and store instructions run the CPU_ls module.

ori r1 = r0 or 1
ori r2 = r0 or 4
ori r3 = r0 or 18441
ori r4 = r0 or 12319
sb from r4 to r2+0
sh from r3 to r1+1
lb from r2 + 0 to r14
or r14 = r14 or 0
lh from r1 + 1 to r15
or r15 = r15 or 0

To test the branch and jump instructions run the CPU_jb module.

addi r4 = r0 + 3
addi r5 = r0 + 1
beq r4 = r0? jump to 2 instruction ahead.
sub r4 = r4 - r5
jump back to the branch test
addi r4 = r0 - 4
add r4 = r4 + r5
bgez r1 >= 0? jump 1 instructions
jump to instruction 6

To test all the bonus instructions except for jal run the CPU_ex module.

#addi r4 = r0 + 3
#addi r5 = r0 + 2
#mul r4*r5
#mfhi to r6
#mflo to r7
# r8 = r5 << 2
# r9 = r5 >> 1
#addi r4 = r0 + 404
#addi r5 = r0 + 4
#mul r4*r5
#mfhi to r6
#mflo to r7
#jr to r8 or 8 in this case

To test jal run the CPU_jal module.

#or r3 = r15 or r0
#jal to the start

To test the factorial program run the CPU_fact module.

The output is printed out as the ALU Result of the last instruction. Due to only being able to have 16 bits the output is 1001110110000000, which if taken as the unsinged value is the result we desire. The upper 16 bits, which are not shown are all 0.
