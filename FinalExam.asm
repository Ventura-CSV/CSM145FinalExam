

section .data
    msg_input: db "Enter a character: ", 0
    msg_output: db "ASCII code for '%c' is %d", 10, 0
    new_line db 0x0A, 0

section .bss
    input: resb 1
  

section .text
    global _start

_start:
repeat:

    ; Display prompt for user input
    mov eax, 4             ; sys_write syscall number
    mov ebx, 1             ; file descriptor 1 (stdout)
    mov ecx, msg_input     ; address of the message to write
    mov edx, 18            ; message length
    int 0x80               ; invoke syscall to write message
    
    call readCharacter
    cmp [input] , byte '.'
    jz end_program


    mov al, byte 0
    mov al, [input]
    
    call printASCII
    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, 2
    int 80h
    
    
    mov eax, 4
    mov ebx, 1
    mov ecx, new_line
    mov edx, 1
    int 80h
    
    jmp repeat

readCharacter:
    mov eax,3
    mov ebx,0         
    mov ecx, input      
    mov edx,1   
    int 80h
    ret

printASCII:
    ; Divide character by 10 to get quotient and remainder
    mov bl, 10
    div bl
    ; Convert quotient and remainder to characters and store in strNumber
    add al, '0'
    mov [input], al
    add ah, '0'
    mov [input + 1], ah
    ret

end_program:
    ; Exit the program
    mov eax, 1             ; sys_exit syscall number
    xor ebx, ebx           ; exit status 0
    int 0x80               ; invoke syscall to exit
