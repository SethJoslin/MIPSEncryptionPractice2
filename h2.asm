#Checks password for user inputted ID


.data
prompt1:            .asciiz "Enter Your ID: "
prompt2:            .asciiz "Enter Password: "
str1:               .asciiz "Correct!"
str2:               .asciiz "Wrong password!"
newline:            .asciiz "\n"
buffer1:            .space 9
buffer2:            .space 9

.text
main:
    li  $v0, 4        
    la  $a0, prompt1
    syscall           #Prints "Enter Your ID: "
    li  $v0, 8
    la  $a0, buffer1
    li  $a1, 9
    syscall           #Reads up to 9 characters for ID
    li  $v0, 4
    la  $a0, newline
    syscall           #Prints new line
    li  $v0, 4
    la  $a0, prompt2  #Prints "Enter Password: "
    syscall
    li  $v0, 8
    la  $a0, buffer2
    li  $a1, 9
    syscall           #Reads up to 9 character for password
    li  $v0, 4
    la  $a0, newline
    syscall           #Prints new line
    la $a0, buffer1   #Passes ID into label1 as $a0
    la $a1, buffer2   #Passes Password into label1 as $a1
    jal label1        #$v0 is 1
    beq $v0, $zero, label5  #jumps to label5 if false
    li  $v0, 4        
    la  $a0, str1   
    syscall          #Prints "Correct!"
    li  $v0, 4
    la  $a0, newline
    syscall          #Prints new line
    li $v0, 10           
    syscall          #Exits
label5:
    li  $v0, 4
    la  $a0, str2
    syscall          #Prints "Wrong Password!"
    li  $v0, 4
    la  $a0, newline
    syscall          #Prints new line
    li $v0, 10           
    syscall          #Exits
label1:                 
    move    $s0, $a0    
    move    $s1, $a1    
    move    $t0, $zero  
    li      $t1, 8      
    li      $v0, 1      
label2: #First el is +50, increments from there
    sltu    $t5, $t0, $t1 
    beq     $t5, $zero, label4 
    lb	    $t2, 0($s0) 
    lb      $t3, 0($s1) 
    addi    $t2, $t2, 49 
    add     $t2, $t2, $t0 
    addi    $t2, $t2, 1   
    bne     $t2, $t3, label3 #If new ID el and Pass el dont match, jump to label3
    addi    $t0, $t0, 1   
    addi    $s0, $s0, 1   
    addi    $s1, $s1, 1   
    j		label2	      #From the top
label3:
    move    $v0, $zero    
label4:
    jr $ra                #Jumps to line 39, correct answer
                          
    