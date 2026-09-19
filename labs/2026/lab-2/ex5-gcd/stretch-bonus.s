.data
x: .word 48
y: .word 18

.text
.globl main
main:
    la t0, x
    lw a0, 0(t0)        # argument #1: a
    la t0, y
    lw a1, 0(t0)        # argument #2: b
    jal ra, gcd
    li a7, 1
    ecall
    li a7, 10
    ecall

gcd:                      # NON-leaf now: calls itself, so ra must be protected
    beqz a1, gcd_base
    addi sp, sp, -4
    sw ra, 0(sp)
    rem t0, a0, a1
    mv a0, a1
    mv a1, t0
    jal ra, gcd
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
gcd_base:
    ret