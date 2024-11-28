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
