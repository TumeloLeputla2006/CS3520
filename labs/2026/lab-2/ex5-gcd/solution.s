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

gcd:                     # LEAF procedure: loops, but calls nothing else
    beqz a1, gcd_done     # while (b != 0) -- inverted: exit when b == 0
    mv t0, a1             # t0 = b (temp = b, from the C++)
    rem t1, a0, a1        # t1 = a % b
    mv a0, t0             # a = old b
    mv a1, t1             # b = remainder
    j gcd
gcd_done:
    ret                   # a already holds the answer, in a0