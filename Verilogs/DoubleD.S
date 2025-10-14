 # Codigo ensamblador update Double Dabble 

 .section .text
    .globl _start

_start:
    # Entrada: X en a0
    li a0, 81          # ejemplo: binario 81 (0x51)
    li t0, 0           # n = 0
    li t1, 0           # Y = 0
    li t2, 8           # N = 8 (bits a recorrer)

loop:
    beq t0, t2, end    # si n == N, salir

    # Extraer bit n de X: (X >> (N-1-n)) & 1
    li t3, 7
    sub t3, t3, t0     # (N-1-n)
    srl t4, a0, t3     # X >> (N-1-n)
    andi t4, t4, 1     # X[n]

    # if (Y >= 5) -> Y = (Y+3)<<1 + bit
    li t5, 5
    blt t1, t5, no_add # if Y < 5, skip add

    addi t1, t1, 3     # Y = Y + 3

no_add:
    slli t1, t1, 1     # Y << 1
    add t1, t1, t4     # + bit

    addi t0, t0, 1     # n = n + 1
    j loop

end:
    mv a1, t1          # salida en a1 (BCD)
    # aquí puedes hacer ecall o loop infinito
    j end
