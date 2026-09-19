.data
n: .word 5

.text
.globl main
main:
    la t0, n
    lw a0, 0(t0)        # argument #1 goes in a0: n
    jal ra, factorial   # call: jumps to factorial, saves return address in ra
    # factorial's answer comes back in a0 by convention
    li a7, 1
    ecall
    li a7, 10
    ecall

factorial:              # LEAF procedure: calls nothing else, so ra is never at risk
    li t0, 1            # t0 = result = 1
    li t1, 1            # t1 = i = 1
fact_loop:
    blt a0, t1, fact_done   # exit when n < i (i.e. i > n)
    mul t0, t0, t1
    addi t1, t1, 1
    j fact_loop
fact_done:
    mv a0, t0           # put the answer where the caller expects it
    ret                 # return: jump to the address saved in ra