 # Codigo ensamblador update multiplicacion binaria

.section .text
        .globl _start

_start:
        # Entradas: 
        # a0 = X (multiplicando)
        # a1 = Y (multiplicador)

        li      a0, 9        # Ejemplo: X = 9
        li      a1, 6        # Ejemplo: Y = 6

        li      a2, 0        # n = 0
        li      a3, 0        # P = 0 (producto)

loop:
        beq     a1, x0, done     # Si Y == 0 -> terminar

        andi    t0, a1, 1        # t0 = Y & 1 (bit menos significativo)
        beq     t0, x0, skip     # Si bit == 0 -> saltar suma

        sll     t1, a0, a2       # t1 = X << n
        add     a3, a3, t1       # P = P + t1

skip:
        srli    a1, a1, 1        # Y = Y >> 1 (siguiente bit)
        addi    a2, a2, 1        # n = n + 1
        j       loop

done:
        # Resultado en a3
        nop
