1. 

In C++, the loop keeps going while the condition (i < n) is true. But a CPU branch instruction jumps when its
condition is true. If a loop body sits after the branch, and you branched on "keep going", you'd need a branch,
then unconditional jump back past it, then a target — extra instructions. The efficient pattern flips the logic: test
for the condition that means "I should stop" (i >= n), and branch out of the loop when that's true. So the C++
continue-condition (i < n) and the assembly exit-condition (i >= n) are logical opposites of each other — that's
the "inversion". It's not a different algorithm, it's the same one, phrased in terms of "when do I leave" instead of
"when do I continue".

2.

These are pseudo-instructions — convenient names the assembler understands, but the actual CPU
hardware has no such instruction. The assembler quietly rewrites them into one or more real instructions before
the machine ever sees them. In Ripes, if you switch on the instruction/machine-code view, you can watch this
translation happen line by line. Typical expansions:
li rd, imm (load immediate) → becomes addi rd, x0, imm for small values, or a lui + addi pair for values too
big to fit in 12 bits.
mv rd, rs (move/copy a register) → becomes addi rd, rs, 0 — "add zero to rs and store in rd", which is just a
copy.
la rd, label (load address) → becomes a auipc + addi pair (or lui+addi), because RISC-V instructions can't
hold a full 32-bit address in one immediate field, so it's built in two pieces.
ble rs1, rs2, label (branch if rs1 <= rs2) → becomes bge rs2, rs1, label — the assembler just swaps the
operand order, because "rs1 <= rs2" and "rs2 >= rs1" mean the same thing, and bge is a real instruction
while ble is not.
Why bother? Because the real RISC-V instruction set is deliberately minimal (this is the whole point of "RISC"
— reduced instruction set). Fewer real instructions means simpler, cheaper, faster hardware. But minimal
hardware makes assembly tedious to hand-write. Pseudo-instructions are the assembler's compromise: keep
the hardware simple, but let the programmer write friendlier code, and let a piece of software (the assembler)
do the tedious translation instead of a human.

3. 

s1 is a "saved" register: the calling convention promises the caller that s1 will hold the same value after a
procedure returns as it did before the call. If find_max wants to use s1 internally (e.g. to hold the running
maximum across loop iterations), it must save the caller's old s1 value on the stack first, and restore it before
returning — otherwise it silently breaks that promise to the caller.
ra holds the return address — where to jump back to when this procedure finishes. find_max never calls
another procedure itself (it only loops), so ra is never overwritten while find_max is running. If nothing clobbers
ra, there's nothing to protect — saving it would just waste a stack push and pop for no reason. This is exactly
what makes find_max a leaf procedure: a procedure that doesn't call anything else, and so never needs to
save ra.