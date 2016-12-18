# Lucy Tran
# 10-24-16
# Hw 7: Height Conversion

		.data
# *intialize doubles
feetToMeters: .double 0.3048
inToMeters:   .double 0.0254
metersToCent: .double 100.0

# intialization of phrases to console
phrase:	 .asciiz "Enter the height in feet: "
phrase2: .asciiz "Enter the height in inches: "
phrase3: .asciiz "Height is "
phrase4: .asciiz " meters"
phrase5: .asciiz "\nHeight is "
phrase6: .asciiz " centimeters"

		.text

main:

	# Prompt for height in feet
	li	$v0, 4 		       # print_string $a0 = string
	la	$a0, phrase	       # Print to console
	syscall 		       # call operating system to perform print operation
	
	# Get first double from user
	li	$v0, 7		       # read_double
	syscall
	mov.d $f2, $f0         # f2/f3 = f0/f1 
	
	# Prompt for height in inches
	li $v0, 4
	la $a0, phrase2
	syscall
	
	# Get second double from user
	li $v0, 7		       # read_double 
	syscall
	mov.d $f4, $f0	       # f4/f5 = f0/f1 

	# push to stack
    addi $sp, $sp, -4      # Stack moved up by one word
    sw $ra, 0($sp)         # save return address to stack

	# HEIGHT IN METERS
	jal Convert_to_Meters  # Compute height in meters
	
	# Message before answer
	li	$v0, 4 		       # print_string $a0 = string
	la	$a0, phrase3	   # Print to console
	syscall 		       # call operating system to perform print operation
	
	# Answer in meters
	li	$v0, 3 		       # print_double ($f12 double to be printed)
	mov.d $f12, $f8        # Value to be printed out
	syscall 		       # call operating system to perform print operation
	
	# Message after answer
	li	$v0, 4 		       # print_string $a0 = string
	la	$a0, phrase4	   # Print to console
	syscall 		       # call operating system to perform print operation
	
	# HEIGHT IN CENTIMETERS
	jal Convert_to_Centimeters    # Compute height in centimeters
	
	# Message before answer
	li	$v0, 4 		       # print_string $a0 = string
	la	$a0, phrase5	   # Print to console
	syscall 		       # call operating system to perform print operation
	
	# Answer in meters
	li	$v0, 3 		       # print_double ($f12 double to be printed)
	mov.d $f12, $f8        # Value to be printed out
	syscall 		       # call operating system to perform print operation
	
	# Message after answer
	li	$v0, 4 		       # print_string $a0 = string
	la	$a0, phrase6	   # Print to console
	syscall 		       # call operating system to perform print operation
	
Exit:
    # pop from stack
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    #jr $ra
	
	# Exit whole program
	li  $v0, 10            # system call code for exit = 10
	syscall				   # call operating sys
	
# FUNCTION TO CONVERT FEET AND INCHES TO METERS
Convert_to_Meters:
	# push to stack
    addi $sp, $sp, -4 # Stack moved up by one word
    sw $ra, 0($sp) # save return address to stack
	
	# Feet to meters
	ldc1 $f6, feetToMeters # load f6/f7 = 0.3048
	mul.d $f6, $f2, $f6    # convert feet to meters
	
	# Inches to meters
	ldc1 $f8, inToMeters   # load f8/f9 = 0.0254
	mul.d $f8, $f4, $f8    # convert inches to meters
	
	# Add values to get total meters
	add.d $f8, $f6, $f8    # Sum of meters
	
	# pop from stack and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
	
Convert_to_Centimeters:
	# push to stack
    addi $sp, $sp, -4      # Stack moved up by one word
    sw $ra, 0($sp)         # save return address to stack

	# Meters to Centimters
	ldc1 $f6, metersToCent # load f6/f7 = 100.0
	mul.d $f8, $f8, $f6    # convert meters to centimeters
	
	# pop from stack and return
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra