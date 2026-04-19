
.section .text
    .global _start
    .align  4

_start:
    j _main

.literal_position

.literal .L_Watchdog, 0x60000900
# MUX REGISTERS

.literal .L_GPIO2_MUX, 0x60000838
.literal .L_GPIO4_MUX, 0x6000083C
.literal .L_GPIO5_MUX, 0x60000840
.literal .L_GPIO12_MUX, 0x60000804
.literal .L_GPIO13_MUX, 0x60000808
.literal .L_GPIO14_MUX, 0x6000080C
.literal .L_GPIO15_MUX, 0x60000810


.literal .L_GPIO_ENABLE_W1TS, 0x60000310
.literal .L_GPIO_ENABLE_W1TC, 0x60000314
.literal .L_GPIO_OUTPUT_W1TS, 0x60000304
.literal .L_GPIO_OUTPUT_W1TC, 0x60000308
.literal .L_GPIO_IN, 0x60000318

.literal .L_GPIO2_MASK, 0x04
.literal .L_GPIO4_MASK, 0x10
.literal .L_GPIO5_MASK, 0x20
.literal .L_GPIO12_MASK, 0x1000
.literal .L_GPIO13_MASK, 0x2000
.literal .L_GPIO14_MASK, 0x4000
.literal .L_GPIO15_MASK, 0x8000
.literal .L_Delay, 2000000



_main:
    # disable watchdog
    l32r a2, .L_Watchdog
    movi a3, 0
    s32i a3, a2, 0

    l32r a2, .L_GPIO4_MUX
    movi a3, 0x00
    s32i a3, a2, 0

    l32r a2, .L_GPIO12_MUX
    movi a3, 0x31
    s32i a3, a2, 0

    l32r a2, .L_GPIO_ENABLE_W1TS
    l32r a3, .L_GPIO4_MASK
    s32i a3, a2, 0
    
    l32r a2, .L_GPIO_ENABLE_W1TS
    l32r a3, .L_GPIO12_MASK
    s32i a3, a2, 0

read:
    l32r a2, .L_GPIO_IN
    l32i a4, a2, 0
    l32r a3, .L_GPIO4_MASK
    and a5, a4, a3
    bnez a5, read
    j blink
    

blink:
    l32r a2, .L_GPIO_OUTPUT_W1TS
    l32r a3, .L_GPIO12_MASK
    s32i a3, a2, 0
    l32r a4, .L_Delay

    call0 delay

    l32r a2, .L_GPIO_OUTPUT_W1TC
    l32r a3, .L_GPIO12_MASK
    s32i a3, a2, 0
    l32r a4, .L_Delay

    call0 delay

    j read

delay:
    addi a4, a4, -1
    bnez a4, delay
    ret
