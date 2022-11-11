 .model  small
 .stack
 .data
 
SOURCE        dw  1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
DESTINATION   dw  16 dup (?)
ROWSIZE       EQU 4
USER          EQU 4 

.code
.startup

    mov   bl, ROWSIZE
    mov   ax, USER
    cmp   ax, ROWSIZE

    jg    mod        ;if greater than 4, need modulus operation
    jmp   nomod      ;if not greater, we can use what the user have choose                                           

mod: 
    div bl           ;divide ax (user choice) by 4 (put in bl register). AH will store the remainder
    mov al, ROWSIZE  ;move 4 to al for multiplication                
    mul ah           ;multiply the remainder by four for the final start counter                                 
    mov bl, 2
    mul bl
    mov di, ax       ;dx is the start counter for the destination matrix
    jmp start
    
nomod:
    mov ah, 4
    mul ah
    mov bl, 2
    mul bl
    mov di, ax       ;dx is the start counter for the destination matrix
    
    
    ; starting the loop for destination matrix 
start:    
    mov cx, 15
    mov si, 0
    jmp cycle


zerocounter:
    mov di, 0               ;i am at the end of destination matrix
cycle:
    mov dx, source[si]      ;copy the source element into dx
    mov DESTINATION[di], dx ;copy the source element into the destination matrix
    add si, 2               
    add di, 2
    cmp di, 32              ;am i at the end of destination matrix?
    jz zerocounter          ;jump if i am at the end for restart the counter
    
    loop cycle
    



                           
.exit
END