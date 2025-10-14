# Codigo Ensamblador update Raiz Cuadrada


.section .text
    .global _start

# Programa principal
_start:
    li a0, 81          # N (ejemplo: 81 decimal = 0b1010001)
    jal ra, sqrt_bin   # Llamar función
    # Al terminar, Q queda en a1 (resultado)

end:
    j end              # Loop infinito (detener programa)

# ---------------------------------------------------------
# sqrt_bin: Calcula raíz cuadrada entera en binario
# Entrada : a0 = N
# Salida  : a1 = Q = floor(sqrt(N))
# ---------------------------------------------------------
sqrt_bin:
    mv t0, a0          # t0 = N
    li t1, 0           # Q = 0
    li t2, 0           # R = 0

    # Ajustar longitud de N (si impar, concatenar 0 delante)
    # Para simplificar, asumimos N ya está en binario correcto
    # En femtoRV trabajamos con 32 bits

    li t3, 1 << 30     # máscara inicial (bit par más alto)

sqrt_loop:
    beqz t3, sqrt_done # si ya no hay más pares -> fin

    slli t2, t2, 2     # R = R << 2
    srli t4, t0, 30    # sacar 2 bits más altos de N
    andi t4, t4, 3
    add t2, t2, t4     # R = R + bits extraídos
    slli t0, t0, 2     # desplazar N a la izquierda (usar siguiente par)

    slli t5, t1, 1     # P = (Q << 1) + 1
    addi t5, t5, 1

    blt t2, t5, no_sub # si R < P, no se resta
    sub t2, t2, t5     # R = R - P
    slli t1, t1, 1     # Q = (Q << 1) + 1
    addi t1, t1, 1
    j cont

no_sub:
    slli t1, t1, 1     # Q = (Q << 1) + 0

cont:
    srli t3, t3, 2     # siguiente par de bits
    j sqrt_loop

sqrt_done:
    mv a1, t1          # resultado Q en a1
    jr ra
