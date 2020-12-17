.equ BUTTON_IN, 29
.equ HIGH, 1
.equ LOW, 0
.equ OUTPUT, 1
.equ INPUT, 0
.equ SIZE, 8

.align 4
.section .data
pins:   .word 0, 2, 3, 21, 22, 23, 24, 25
ms:             .word 1000, 800, 600, 400, 350, 300, 260, 220

.align 4
.global main
.text
main:

        push {lr}

        //Setup wiring pi
        mov r9, lr
        bl wiringPiSetup
        mov lr, r9

reset:

        //Delay 1000 ms
        ldr r0, =#1000
        bl delay

        //Setup pins
        ldr r5, =pins
        ldr r6, =ms

        mov r4, #0
pin_loop:
        cmp r4, #SIZE
        beq pin_loop_end

        ldr r0, [r5, +r4, lsl #2]
        mov r1, #OUTPUT
        mov r9, lr
        bl pinMode
        ldr r0, [r5, +r4, lsl #2]
        mov r1, #LOW
        bl digitalWrite
        mov lr, r9

        add r4, #1
        b pin_loop

pin_loop_end:


        //Setup buttons
        mov r9, lr
        mov r0, #BUTTON_IN
        mov r1, #INPUT
        bl pinMode
        mov lr, r9

        //Game loop
        mov r4, #0

game:
        cmp r4, #SIZE
        beq game_end

        //Load round values from array
        ldr r7, [r5, +r4, lsl #2]//Pin


input:


        ldr r8, [r6, +r4, lsl #2]//Time
        bl millis
        add r8, r0

        mov r0, r7
        mov r1, #HIGH
        mov r9, lr
        bl digitalWrite
        mov lr, r9

while_on:
        bl millis
        cmp r0, r8
        bge while_on_end


        mov r0, #BUTTON_IN
        mov r9, lr
        bl digitalRead
        mov lr, r9
        cmp r0, #HIGH
        beq input_end


        b while_on

while_on_end:

        ldr r8, [r6, +r4, lsl #2]//Time
        bl millis
        add r8, r0

        mov r0, r7
        mov r1, #LOW
        mov r9, lr
        bl digitalWrite
        mov lr, r9

while_off:
        bl millis
        cmp r0, r8
        bge while_off_end

        mov r0, #BUTTON_IN
        mov r9, lr
        bl digitalRead
        mov lr, r9
        cmp r0, #HIGH
        beq reset

        b while_off

while_off_end:

        b input

input_end:

        ldr r0, =#1000
        bl delay

        mov r0, r7
        mov r1, #LOW
        mov r9, lr
        bl digitalWrite
        mov lr, r9

        add r4, #1
        b game

game_end:

        pop {pc}


