 .data
n: .word 10
 .text
 .globl main
main:
 la t0, n
 lw t1, 0(t0) # t1 = n
 li t2, 0 # t2 = sum = 0
 li t3, 1 # t3 = i = 1
loop:
 blt t1, t3, done # continue-condition was (i <= n); inverted exit is (n < i) -> exit
 add t2, t2, t3 # sum += i
 addi t3, t3, 1 # i++
 j loop
done:
 mv a0, t2
 li a7, 1
 ecall
 li a7, 10
 ecall