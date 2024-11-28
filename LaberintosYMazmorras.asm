.data
display: .space 1024
prompt: .asciiz "Elija entre el mapa 1 � el mapa 2: "
WASDprompt: .asciiz "Use W, A, S ó D para moverse, ó B para salir:\n"
winnerprompt: .asciiz "\n¡Felicidades! Has completado el laberinto. ¡Eres un maestro del escape!"


.text

li $t0 0xffffff #white color
li $t1 0xff0000 #red color
li $t2 0x008000 #green color
li $t6 0x00bfff #blue color

li $t3, 0
li $t7, 1020 #jugador
li $t9, 0 #joystick

li $t8, 1 #mapa


main:

	li $v0, 4 
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t8, $v0
	

selector:
	beq $t8, 1, liner1
	j liner2



liner1:
	li $t4, 0
	beq $t3, 1024, exit

map1:
	beq $t4, 14, walls1
	sw $t0, display($t3)
	addi $t4, $t4, 1
	addi $t3, $t3, 4
	beq $t3, 1024, tunnel1
	
	j map1
	
walls1:
	beq $t4, 0, liner1
	sw $t2, display($t3)
	sub $t4, $t4, 1
	addi $t3, $t3, 4
	beq $t3, 1024, tunnel1
	
	j walls1

tunnel1:
	li $t5, 92
	sw $t0, display($t5)
	li $t5, 192
	sw $t0, display($t5)
	li $t5, 400
	sw $t0, display($t5)
	li $t5, 628
	sw $t0, display($t5)
	li $t5, 644
	sw $t0, display($t5)
	li $t5, 852
	sw $t0, display($t5)
	li $t5, 0
	sw $t6, display($t5)
	sw $t1, display($t7)

	li $v0, 4
	la $a0, WASDprompt
	syscall

	j controller

liner2:
	li $t4, 0
	beq $t3, 1024, exit
	
map2:
	beq $t4, 16, walls2
	sw $t0, display($t3)
	addi $t4, $t4, 1
	addi $t3, $t3, 4
	beq $t3, 1024, tunnel2
	
	j map2
	
walls2:
	beq $t4, 0, liner2
	sw $t2, display($t3)
	sub $t4, $t4, 1
	addi $t3, $t3, 4
	beq $t3, 1024, tunnel2
	
	j walls2

tunnel2:
	li $t5, 124
	sw $t0, display($t5)
	li $t5, 184
	sw $t2, display($t5)
	li $t5, 252
	sw $t0, display($t5)
	li $t5, 312
	sw $t2, display($t5)
	li $t5, 380
	sw $t0, display($t5)
	li $t5, 440
	sw $t2, display($t5)
	li $t5, 508
	sw $t0, display($t5)
	li $t5, 548
	sw $t2, display($t5)
	li $t5, 488
	sw $t0, display($t5)
	li $t5, 480
	sw $t0, display($t5)
	li $t5, 420
	sw $t2, display($t5)
	li $t5, 372
	sw $t0, display($t5)
	li $t5, 244
	sw $t0, display($t5)
	li $t5, 304
	sw $t2, display($t5)
	li $t5, 192
	sw $t0, display($t5)
	li $t5, 352
	sw $t0, display($t5)
	li $t5, 580
	sw $t0, display($t5)
	li $t5, 744
	sw $t0, display($t5)
	li $t5, 844
	sw $t0, display($t5)
	
	li $t5, 0
	sw $t6, display($t5)
	sw $t1, display($t7)


	li $v0, 4
	la $a0, WASDprompt
	syscall


	j controller


controller:
	li $v0, 12
	syscall
	
	move $t9, $v0
	
	li $t5, 32

	beq $t9, 119, up #W
	beq $t9, 97, left #A
	beq $t9, 115, down #S
	beq $t9, 100, right #d
	beq $t9, 98, exit #b para terminar le juego
	
	j controller
	
up:
	sub $t8, $t7, 64
	lw $t5, display($t8)
	beq $t5, $t6, winner
	bne $t5, $t0, controller
	sw $t0, display($t7)
	move $t7, $t8
	
	j reframe
	
left:
	sub $t8, $t7, 4
	lw $t5, display($t8)
	beq $t5, $t6, winner
	bne $t5, $t0, controller
	sw $t0, display($t7)
	move $t7, $t8
	
	j reframe

down:
	add $t8, $t7, 64
	lw $t5, display($t8)
	beq $t5, $t6, winner
	bne $t5, $t0, controller
	sw $t0, display($t7)
	move $t7, $t8
	
	j reframe	
	
right:
	add $t8, $t7, 4
	
	lw $t5, display($t8)
	beq $t5, $t6, winner
	bne $t5, $t0, controller
	sw $t0, display($t7)
	move $t7, $t8
	
	j reframe

reframe:
	sw $t1, display($t7)
	j controller

winner:

	li $t2 0xffff00 #yellow color
	sw $t2, display($t8)
	sw $t0, display($t7)
	
	li $v0, 4
	la $a0, winnerprompt
	syscall

	li $v0 10
	syscall

exit:
	li $v0 10
	syscall
