; ==========================================================
; MACRO DEFINITIONS
; ==========================================================
%macro print_text 2
    mov ecx, %1         
    mov edx, %2         
    call print_proc
%endmacro

section .data
    ; Prompts for keyboard inputs
    p_snum    db 'Enter Student #: '
    l_snum    equ $ - p_snum
    p_name    db 'Enter Name (LAST, FIRST MIDDLE): '
    l_name    equ $ - p_name
    p_phone   db 'Enter Phone #: '
    l_phone   equ $ - p_phone
    p_zip     db 'Enter Zip Code: '
    l_zip     equ $ - p_zip
    p_coll    db 'Enter College: '
    l_coll    equ $ - p_coll
    p_prog    db 'Enter Program: '
    l_prog    equ $ - p_prog
    p_year    db 'Enter Year Level: '
    l_year    equ $ - p_year
    p_addr    db 'Enter Address: '
    l_addr    equ $ - p_addr

    ; Structural Static Labels 
    lbl_status db 'Enrollment Status : ENROLLED', 0xA, 0xD
    len_status equ $ - lbl_status

    lbl_snum   db 'Student # : '
    len_snum   equ $ - lbl_snum

    lbl_coll   db '   College : '
    len_coll   equ $ - lbl_coll

    lbl_prog   db '   Program : '
    len_prog   equ $ - lbl_prog

    lbl_name   db 'Name : '
    len_name   equ $ - lbl_name

    lbl_year   db '   Year Level : '
    len_year   equ $ - lbl_year

    lbl_term   db '   1st term, SY 26-27', 0xA, 0xD
    len_term   equ $ - lbl_term

    lbl_phone  db 'Phone : '
    len_phone  equ $ - lbl_phone

    lbl_zip    db '   Zip Code : '
    len_zip    equ $ - lbl_zip

    lbl_addr   db '   Address : '
    len_addr   equ $ - lbl_addr

    lbl_class  db 'Classification : ', 0xA, 0xD, 0xA, 0xD
    len_class  equ $ - lbl_class

    spaces     db '                                                                ' 
    newline    db 0xA, 0xD
    len_newline equ $ - newline

    ; Table Rows Structure
    line db '+----------+---------------------------------------+---------+-------+-------+-------------------------+-------------+', 0xA, 0xD
    len_line equ $ - line

    head db '| Courses  | Title                                 | Section | Units | Days  | Time                    | Room        |', 0xA, 0xD
    len_head equ $ - head

    row1 db '| CCS0021  | INFORMATION MANAGEMENT (LEC)          | TN24    |   2   | T     | 16:00:00-18:40:00       | ONLINE      |', 0xA, 0xD
    len_row1 equ $ - row1

    row2 db '| CCS0021L | INFORMATION MANAGEMENT (LAB)          | TN24    |   1   | F     | 16:00:00-18:50:00       | ONLINE      |', 0xA, 0xD
    len_row2 equ $ - row2

    row3a db '| CS0001   | DISCRETE STRUCTURES 1                 | TN24    |   3   | S / W | 15:00:00-16:50:00 /     | F710 / F710 |', 0xA, 0xD
    len_row3a equ $ - row3a

    row3b db '|          |                                       |         |       |       | 15:00:00-16:50:00       |             |', 0xA, 0xD
    len_row3b equ $ - row3b

    row4 db '| CS0003   | COMPUTER SYSTEMS & ARCHITECTURE       | TN24    |   2   | F     | 10:00:00-12:40:00       | ONLINE      |', 0xA, 0xD
    len_row4 equ $ - row4

    row5 db '| CS0003L  | COMPUTER SYSTEMS & ARCHITECTURE (LAB) | TN24    |   1   | TH    | 10:00:00-12:50:00       | E610        |', 0xA, 0xD
    len_row5 equ $ - row5

    row6 db '| CS0070   | OBJECT ORIENTED PROGRAMMING           | TN24    |   2   | F     | 07:00:00-09:40:00       | ONLINE      |', 0xA, 0xD
    len_row6 equ $ - row6

    row7 db '| CS0070L  | OBJECT ORIENTED PROGRAMMING-LAB       | TN24    |   1   | TH    | 07:00:00-09:50:00       | E609        |', 0xA, 0xD
    len_row7 equ $ - row7

    row8a db '| GED0021  | SPECIALIZED ENGLISH PROGRAM 2         | TN24    |   3   | S / W | 11:00:00-12:50:00 /     | F607 / F607 |', 0xA, 0xD
    len_row8a equ $ - row8a

    row8b db '|          |                                       |         |       |       | 11:00:00-12:50:00       |             |', 0xA, 0xD
    len_row8b equ $ - row8b

    row9a db '| GED0055  | MATHEMATICAL ANALYSIS                 | M551    |   3   | M / TH| 13:00:00-14:50:00 /     | F504 / F504 |', 0xA, 0xD
    len_row9a equ $ - row9a

    row9b db '|          |                                       |         |       |       | 13:00:00-14:50:00       |             |', 0xA, 0xD
    len_row9b equ $ - row9b

    row10 db '| GED0081  | COLLEGE PHYSICS 1 LECTURE             | TN24    |   2   | T     | 07:00:00-09:40:00       | ONLINE      |', 0xA, 0xD
    len_row10 equ $ - row10

    row11 db '| GED0081L | COLLEGE PHYSICS 1 LABORATORY          | TN24    |   1   | S     | 07:00:00-09:50:00       | F1003       |', 0xA, 0xD
    len_row11 equ $ - row11

    total db '| TOTAL UNITS: 21                                                                                                    |', 0xA, 0xD
    len_total equ $ - total

    fee_msg db '| TOTAL TUITION FEE: PHP '
    len_fee_msg equ $ - fee_msg

    fee_close db '                                                                                   |', 0xA, 0xD
    len_fee_close equ $ - fee_close

    SYS_EXIT  equ 1
    SYS_READ  equ 3
    SYS_WRITE equ 4
    STDIN     equ 0
    STDOUT    equ 1
    
    NON_LAB_UNITS equ 17
    NON_LAB_RATE  equ 1000
    LAB_UNITS     equ 4
    LAB_RATE      equ 4000

section .bss
    in_snum   resb 16
    l_snum_in resd 1
    in_name   resb 64
    l_name_in resd 1
    in_phone  resb 16
    l_phone_in resd 1
    in_zip    resb 8
    l_zip_in  resd 1
    in_coll   resb 32
    l_coll_in resd 1
    in_prog   resb 16
    l_prog_in resd 1
    in_year   resb 4
    l_year_in resd 1
    in_addr   resb 64
    l_addr_in resd 1
    
    fee_string resb 10

section .text
    global _start

_start:
    ; ==========================================================
    ; CALL INPUT PROCEDURES
    ; ==========================================================
    print_text p_snum, l_snum
    mov ecx, in_snum
    mov edx, 16
    call read_input_proc
    mov [l_snum_in], eax

    print_text p_name, l_name
    mov ecx, in_name
    mov edx, 64
    call read_input_proc
    mov [l_name_in], eax

    print_text p_phone, l_phone
    mov ecx, in_phone
    mov edx, 16
    call read_input_proc
    mov [l_phone_in], eax

    print_text p_zip, l_zip
    mov ecx, in_zip
    mov edx, 8
    call read_input_proc
    mov [l_zip_in], eax

    print_text p_coll, l_coll
    mov ecx, in_coll
    mov edx, 32
    call read_input_proc
    mov [l_coll_in], eax

    print_text p_prog, l_prog
    mov ecx, in_prog
    mov edx, 16
    call read_input_proc
    mov [l_prog_in], eax

    print_text p_year, l_year
    mov ecx, in_year
    mov edx, 4
    call read_input_proc
    mov [l_year_in], eax

    print_text p_addr, l_addr
    mov ecx, in_addr
    mov edx, 64
    call read_input_proc
    mov [l_addr_in], eax

    ; Execute run-time computation procedure
    call calculate_tuition_proc

    ; ==========================================================
    ; OUTPUT DISPLAY GENERATION VIA MACROS
    ; ==========================================================
    print_text newline, len_newline
    print_text lbl_status, len_status

    ; Profile Block: Row 1
    print_text lbl_snum, len_snum
    print_text in_snum, [l_snum_in]
    mov eax, 15
    sub eax, [l_snum_in]
    call print_padding_spaces

    print_text lbl_coll, len_coll
    print_text in_coll, [l_coll_in]
    mov eax, 25
    sub eax, [l_coll_in]
    call print_padding_spaces

    print_text lbl_prog, len_prog
    print_text in_prog, [l_prog_in]
    print_text newline, len_newline

    ; Profile Block: Row 2
    print_text lbl_name, len_name
    print_text in_name, [l_name_in]
    mov eax, 42
    sub eax, [l_name_in]
    call print_padding_spaces

    print_text lbl_year, len_year
    print_text in_year, [l_year_in]
    print_text lbl_term, len_term

    ; Profile Block: Row 3
    print_text lbl_phone, len_phone
    print_text in_phone, [l_phone_in]
    mov eax, 16
    sub eax, [l_phone_in]
    call print_padding_spaces

    print_text lbl_zip, len_zip
    print_text in_zip, [l_zip_in]
    mov eax, 10
    sub eax, [l_zip_in]
    call print_padding_spaces

    print_text lbl_addr, len_addr
    print_text in_addr, [l_addr_in]
    print_text newline, len_newline

    print_text lbl_class, len_class

    ; Table Printing
    print_text line, len_line
    print_text head, len_head
    print_text line, len_line
    print_text row1, len_row1
    print_text line, len_line
    print_text row2, len_row2
    print_text line, len_line
    print_text row3a, len_row3a
    print_text row3b, len_row3b
    print_text line, len_line
    print_text row4, len_row4
    print_text line, len_line
    print_text row5, len_row5
    print_text line, len_line
    print_text row6, len_row6
    print_text line, len_line
    print_text row7, len_row7
    print_text line, len_line
    print_text row8a, len_row8a
    print_text row8b, len_row8b
    print_text line, len_line
    print_text row9a, len_row9a
    print_text row9b, len_row9b
    print_text line, len_line
    print_text row10, len_row10
    print_text line, len_line
    print_text row11, len_row11
    print_text line, len_line

    ; EAF Totals Footer Summary
    print_text total, len_total
    print_text line, len_line
    print_text fee_msg, len_fee_msg
    print_text fee_string, 5             
    print_text fee_close, len_fee_close
    print_text line, len_line

    ; Program Exit
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80

; ==========================================================
; RUN-TIME PROCEDURES
; ==========================================================

; Procedure: Base IO write driver used by macro expansion
print_proc:
    push eax
    push ebx
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    int 0x80
    pop ebx
    pop eax
    ret

; Procedure: Dynamic keyboard string reading & newline scrubbing
read_input_proc:
    push ebx
    mov eax, SYS_READ
    mov ebx, STDIN
    int 0x80
    
    push eax            
    mov ebx, ecx        

    mov ecx, eax        
.clean_loop:
cmp ecx, 0
je .done_clean
dec ecx
cmp byte [ebx + ecx], 0xA ; 
je .strip_char
cmp byte [ebx + ecx], 0xD ; 
je .strip_char
jmp .clean_loop
.strip_char:
mov byte [ebx + ecx], 0
pop eax
dec eax             
push eax
jmp .clean_loop
.done_clean:
pop eax             
pop ebx
ret
; Procedure: Screen spatial alignment block renderer
print_padding_spaces:
push eax
push ebx
push ecx
push edx
cmp eax, 0
jle .skip_padding
mov edx, eax
mov eax, SYS_WRITE
mov ebx, STDOUT
mov ecx, spaces
int 0x80
.skip_padding:
pop edx
pop ecx
pop ebx
pop eax
ret
; Procedure: Compound tuition rate calculation engine
calculate_tuition_proc:
mov eax, NON_LAB_UNITS
mov ebx, NON_LAB_RATE
mul ebx
mov ecx, eax
mov eax, LAB_UNITS
mov ebx, LAB_RATE
mul ebx
add eax, ecx                        
; Hex to decimal string conversion routine
mov ecx, 10
mov edi, fee_string + 4
.convert_loop:
xor edx, edx
div ecx
add dl, '0'
mov [edi], dl
dec edi
cmp edi, fee_string - 1
jne .convert_loop
ret