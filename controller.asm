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
