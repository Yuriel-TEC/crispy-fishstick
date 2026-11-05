section .data
    filename db 'receipt.txt', 0
    
    ; Menu headers and layouts
    menu_head db '---------- Georgette EATERY ----------', 0xA
    menu_a    db 'A. Rice  : Plain Rice        Php 5.00', 0xA
    menu_b    db 'B. Rice  : Java Rice         Php 10.00', 0xA
    menu_c    db 'C. Ulam 1: (Fish)            Php 35.00', 0xA
    menu_d    db 'D. Ulam 2: (Pork)            Php 50.00', 0xA
    menu_e    db 'E. Ulam 3: (Vegetables)      Php 20.00', 0xA
    menu_f    db 'F. Desert: Saging con yelo   Php 60.00', 0xA
    menu_line db '--------------------------------------', 0xA
    menu_len  equ $ - menu_head

    ; Prompts
    prompt_order db 'Enter your order: '
    p_order_len  equ $ - prompt_order

    prompt_again db 'Do you want to order again? [Y/N]: '
    p_again_len  equ $ - prompt_again

    msg_thanks   db 'Thank you! Please come again!', 0xA
    thanks_len   equ $ - msg_thanks

    receipt_title db 'Receipt', 0xA
    rec_title_len equ $ - receipt_title

    ; Receipt line items (strings written to screen and file)
    str_a     db 'Plain Rice    Php 5.00', 0xA
    len_a     equ $ - str_a
    str_b     db 'Java Rice     Php 10.00', 0xA
    len_b     equ $ - str_b
    str_c     db 'Fish          Php 35.00', 0xA
    len_c     equ $ - str_c
    str_d     db 'Pork          Php 50.00', 0xA
    len_d     equ $ - str_d
    str_e     db 'Vegetables    Php 20.00', 0xA
    len_e     equ $ - str_e
    str_f     db 'Saging con yelo Php 60.00', 0xA
    len_f     equ $ - str_f

    prefix    db 'You ordered '
    pfx_len   equ $ - prefix

section .bss
    fd       resd 1
    input    resb 2
    buffer   resb 1024

section .text
    global _start

_start:
    ; 1. CREATE / TRUNCATE FILE 'receipt.txt'
    mov eax, 8              
    mov ebx, filename       
    mov ecx, 0644o          
    int 0x80
    mov [fd], eax           

    ; Write "Receipt\n" title line to the file initially
    mov eax, 4              
    mov ebx, [fd]
    mov ecx, receipt_title
    mov edx, rec_title_len
    int 0x80

.display_menu:
    ; 2. DISPLAY MENU TO SCREEN
    mov eax, 4              
    mov ebx, 1              
    mov ecx, menu_head
    mov edx, menu_len
    int 0x80

    ; 3. GET ORDER INPUT
    mov eax, 4              
    mov ebx, 1              
    mov ecx, prompt_order
    mov edx, p_order_len
    int 0x80

    mov eax, 3              
    mov ebx, 0              
    mov ecx, input
    mov edx, 2              
    int 0x80

    ; Process food item selection
    mov al, [input]
    cmp al, 'A'
    je .order_a
    cmp al, 'B'
    je .order_b
    cmp al, 'C'
    je .order_c
    cmp al, 'D'
    je .order_d
    cmp al, 'E'
    je .order_e
    cmp al, 'F'
    je .order_f
    jmp .ask_again         

.order_a:
    mov ecx, str_a
    mov edx, len_a
    jmp .process_order
.order_b:
    mov ecx, str_b
    mov edx, len_b
    jmp .process_order
.order_c:
    mov ecx, str_c
    mov edx, len_c
    jmp .process_order
.order_d:
    mov ecx, str_d
    mov edx, len_d
    jmp .process_order
.order_e:
    mov ecx, str_e
    mov edx, len_e
    jmp .process_order
.order_f:
    mov ecx, str_f
    mov edx, len_f
    jmp .process_order

.process_order:
    ; Preserve item pointer registers
    push ecx
    push edx

    ; Print "You ordered " to terminal console
    mov eax, 4
    mov ebx, 1
    mov ecx, prefix
    mov edx, pfx_len
    int 0x80

    ; Print item name and value string to terminal console
    pop edx
    pop ecx
    push ecx
    push edx
    mov eax, 4
    mov ebx, 1
    int 0x80

    ; Write item name and value string down to receipt.txt
    pop edx
    pop ecx
    mov eax, 4
    mov ebx, [fd]
    int 0x80

.ask_again:
    ; 4. ASK USER IF THEY WANT TO ORDER AGAIN
    mov eax, 4              
    mov ebx, 1              
    mov ecx, prompt_again
    mov edx, p_again_len
    int 0x80

    mov eax, 3              
    mov ebx, 0              
    mov ecx, input
    mov edx, 2              
    int 0x80

    mov al, [input]
    cmp al, 'Y'
    je .display_menu
    cmp al, 'y'
    je .display_menu

    ; 5. EXITING PROCEDURES & PRINT RECEIPT FILE CONTENTS
    mov eax, 4              
    mov ebx, 1              
    mov ecx, msg_thanks
    mov edx, thanks_len
    int 0x80

    ; Close writing file handle stream clean
    mov eax, 6              
    mov ebx, [fd]
    int 0x80

    ; Re-open receipt.txt in Read-Only Mode (O_RDONLY = 0)
    mov eax, 5              
    mov ebx, filename
    mov ecx, 0
    mov edx, 0
    int 0x80
    mov [fd], eax

    ; Read complete text from file into data buffer space
    mov eax, 3              
    mov ebx, [fd]
    mov ecx, buffer
    mov edx, 1024
    int 0x80
    push eax                

    ; Close file handle stream cleanly
    mov eax, 6              
    mov ebx, [fd]
    int 0x80

    ; Stream the full read contents of buffer out onto console screen
    pop edx                
    mov eax, 4         
    mov ebx, 1              
    mov ecx, buffer
    int 0x80

    ; 6. PROGRAM HALT TERMINATION EXIT
    mov eax, 1              
    xor ebx, ebx            
    int 0x80