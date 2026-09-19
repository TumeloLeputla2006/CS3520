 .data
a: .word 15
b: .word 27
 .text
 .globl main
main:
 la t0, a
 lw t1, 0(t0) # t1 = a
 la t0, b
 lw t2, 0(t0) # t2 = b
 bge t1, t2, a_is_larger # if a >= b, jump; else fall through to "b is larger"
 mv a0, t2 # b was larger
 j print_result
a_is_larger:
 mv a0, t1 # a was larger (or equal)
print_result:
 li a7, 1 # print-integer syscall
 ecall
 li a7, 10 # e