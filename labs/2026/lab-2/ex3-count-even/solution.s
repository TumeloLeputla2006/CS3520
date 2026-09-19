 .data
arr: .word 3, 4, 7, 8, 10, 15, 22, 1
n: .word 8
 .text
 .globl main
main:
 la s0, arr # s0 = base address of arr (kept alive whole loop -> saved register)
 la t0, n
 lw s1, 0(t0) # s1 = n (also kept alive whole loop -> saved register)
 li t0, 0 # t0 = i = 0
 li t1, 0 # t1 = count = 0
loop:
 bge t0, s1, done # exit when i >= n
 slli t2, t0, 2 # t2 = i * 4 (word = 4 bytes, so shift left by 2)
 add t3, s0, t2 # t3 = address of arr[i]
 lw t4, 0(t3) # t4 = arr[i]
 andi t5, t4, 1 # t5 = arr[i] & 1 -> the bit test
 bnez t5, skip # if bit is 1 (odd), skip the increment
 addi t1, t1, 1 # even -> count++
skip:
 addi t0, t0, 1 # i++
 j loop
done:
 mv a0, t1
 li a7, 1
 ecall
 li a7, 10
 ecall