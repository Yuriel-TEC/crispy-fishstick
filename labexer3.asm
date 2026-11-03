BITS 32
%define SYS_EXIT 1
%define SYS_READ 3
%define SYS_WRITE 4
%define SYS_OPEN 5
%define SYS_CLOSE 6
%define NON_LAB_UNITS 17
%define LAB_UNITS 4

%macro PRINT 2
    pushad
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    call write_all
    popad
%endmacro

%macro APPEND 2
    mov ecx, %1
    mov edx, %2
    call append_proc
%endmacro

%macro INPUT_FIELD 1
%%retry:
    PRINT prompt_%{1}, prompt_%{1}_len
    mov ecx, in_%{1}
    mov edx, 127
    call read_line
    cmp eax, -2
    jne %%check
    PRINT bad_line, bad_line_len
    jmp %%retry
%%check:
    test eax, eax
    js exit_program
    test eax, eax
    jz %%retry
    mov [len_%{1}], eax
%endmacro

section .data
menu db 10
    db '===============================',10
    db '              COR',10
    db '===============================',10
    db '1. Input  - Enter student details and tuition rates',10
    db '2. Output - Display the full COR',10
    db '3. Write  - Save full COR to labexer3.txt',10
    db '4. Read   - Display the saved file',10
    db '5. Exit',10
    db 'Enter your choice: '
menu_len equ $ - menu
prompt_status db 'Enter Enrollment Status: '
prompt_status_len equ $ - prompt_status
label_status db 'Enrollment Status : '
label_status_len equ $ - label_status
prompt_snum db 'Enter Student #: '
prompt_snum_len equ $ - prompt_snum
label_snum db 'Student # : '
label_snum_len equ $ - label_snum
prompt_name db 'Enter Name (LAST, FIRST MIDDLE): '
prompt_name_len equ $ - prompt_name
label_name db 'Name (LAST, FIRST MIDDLE) : '
label_name_len equ $ - label_name
prompt_phone db 'Enter Phone: '
prompt_phone_len equ $ - prompt_phone
label_phone db 'Phone : '
label_phone_len equ $ - label_phone
prompt_zip db 'Enter Zip Code: '
prompt_zip_len equ $ - prompt_zip
label_zip db 'Zip Code : '
label_zip_len equ $ - label_zip
prompt_coll db 'Enter College: '
prompt_coll_len equ $ - prompt_coll
label_coll db 'College : '
label_coll_len equ $ - label_coll
prompt_prog db 'Enter Program: '
prompt_prog_len equ $ - prompt_prog
label_prog db 'Program : '
label_prog_len equ $ - label_prog
prompt_year db 'Enter Year Level: '
prompt_year_len equ $ - prompt_year
label_year db 'Year Level : '
label_year_len equ $ - label_year
prompt_term db 'Enter Term / School Year: '
prompt_term_len equ $ - prompt_term
label_term db 'Term / School Year : '
label_term_len equ $ - label_term
prompt_addr db 'Enter Address: '
prompt_addr_len equ $ - prompt_addr
label_addr db 'Address : '
label_addr_len equ $ - label_addr
label_class db 'Classification : '
label_class_len equ $ - label_class
p_rate db 'Enter non-lab rate per unit in PHP (example 1000): '
p_rate_len equ $ - p_rate
p_lab db 'Enter lab rate per unit in PHP (example 4000): '
p_lab_len equ $ - p_lab
bad_rate db 'Enter a whole-peso amount from 0 to 1000000.',10
bad_rate_len equ $ - bad_rate
bad_line db 'Input too long (maximum 127 characters). Please re-enter.',10
bad_line_len equ $ - bad_line
bad_choice db 'Invalid choice. Enter 1 to 5.',10
bad_choice_len equ $ - bad_choice
no_data db 'Use option 1 to input the COR details first.',10
no_data_len equ $ - no_data
entered db 'Details stored. Use option 2 to display or option 3 to save.',10
entered_len equ $ - entered
saved db 'Full COR written to labexer3.txt.',10
saved_len equ $ - saved
file_error db 'File operation failed. Check the file or folder permissions.',10
file_error_len equ $ - file_error
read_title db 10
    db '--- Saved COR file ---',10
read_title_len equ $ - read_title
nl db 10
nl_len equ $ - nl
heading db 10
    db '================ CERTIFICATE OF REGISTRATION ================',10
heading_len equ $ - heading
lecture_label db 'Non-lab tuition: 17 units x PHP '
lecture_label_len equ $ - lecture_label
lab_label db 'Lab tuition:      4 units x PHP '
lab_label_len equ $ - lab_label
times_result db ' = PHP '
times_result_len equ $ - times_result
total_label db 'TOTAL TUITION FEE: PHP '
total_label_len equ $ - total_label
filename db 'labexer3.txt',0
schedule db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| Courses    | Title                                    | Section | Units | Days   | Time                    | Room          |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| CCS0021    | INFORMATION MANAGEMENT (LEC)             | TN24    | 2     | T      | 16:00:00-18:40:00       | ONLINE        |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| CCS0021L   | INFORMATION MANAGEMENT (LAB)             | TN24    | 1     | F      | 16:00:00-18:50:00       | ONLINE        |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| CS0001     | DISCRETE STRUCTURES 1                    | TN24    | 3     | S / W  | 15:00:00-16:50:00       | F710 / F710   |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| CS0003     | COMPUTER SYSTEMS & ARCHITECTURE          | TN24    | 2     | F      | 10:00:00-12:40:00       | ONLINE        |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| CS0003L    | COMPUTER SYSTEMS & ARCHITECTURE (LAB)    | TN24    | 1     | TH     | 10:00:00-12:50:00       | E610          |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| CS0070     | OBJECT ORIENTED PROGRAMMING              | TN24    | 2     | F      | 07:00:00-09:40:00       | ONLINE        |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| CS0070L    | OBJECT ORIENTED PROGRAMMING-LAB          | TN24    | 1     | TH     | 07:00:00-09:50:00       | E609          |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| GED0021    | SPECIALIZED ENGLISH PROGRAM 2            | TN24    | 3     | S / W  | 11:00:00-12:50:00       | F607 / F607   |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| GED0055    | MATHEMATICAL ANALYSIS                    | M551    | 3     | M / TH | 13:00:00-14:50:00       | F504 / F504   |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| GED0081    | COLLEGE PHYSICS 1 LECTURE                | TN24    | 2     | T      | 07:00:00-09:40:00       | ONLINE        |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db '| GED0081L   | COLLEGE PHYSICS 1 LABORATORY             | TN24    | 1     | S      | 07:00:00-09:50:00       | F1003         |',10
    db '+------------+------------------------------------------+---------+-------+--------+-------------------------+---------------+',10
    db 'TOTAL UNITS: 21 (17 non-lab + 4 lab)',10
    db 'For S / W and M / TH, the listed time applies on both days.',10
    db 10
schedule_len equ $ - schedule

section .bss
    ready resd 1
    choice resb 128
    scratch resb 128
    input_byte resb 1
    nonlab_rate resd 1
    lab_rate resd 1
    nonlab_fee resd 1
    lab_fee resd 1
    tuition resd 1
    number_buffer resb 16
    cor_buffer resb 16384
    cor_length resd 1
    file_buffer resb 4096
    in_status resb 128
    len_status resd 1
    in_snum resb 128
    len_snum resd 1
    in_name resb 128
    len_name resd 1
    in_phone resb 128
    len_phone resd 1
    in_zip resb 128
    len_zip resd 1
    in_coll resb 128
    len_coll resd 1
    in_prog resb 128
    len_prog resd 1
    in_year resb 128
    len_year resd 1
    in_term resb 128
    len_term resd 1
    in_addr resb 128
    len_addr resd 1

section .text
global _start
_start:
    cld
menu_loop:
    PRINT menu, menu_len
    mov ecx, choice
    mov edx, 127
    call read_line
    cmp eax, -2
    je invalid_choice
    test eax, eax
    js exit_program
    cmp eax, 1
    jne invalid_choice
    mov al, [choice]
    cmp al, '1'
    je input_proc
    cmp al, '2'
    je output_proc
    cmp al, '3'
    je save_proc
    cmp al, '4'
    je load_proc
    cmp al, '5'
    je exit_program
invalid_choice:
    PRINT bad_choice, bad_choice_len
    jmp menu_loop

input_proc:
    mov dword [ready], 0
    INPUT_FIELD status
    INPUT_FIELD snum
    INPUT_FIELD name
    INPUT_FIELD phone
    INPUT_FIELD zip
    INPUT_FIELD coll
    INPUT_FIELD prog
    INPUT_FIELD year
    INPUT_FIELD term
    INPUT_FIELD addr
    PRINT p_rate, p_rate_len
    call read_rate
    mov [nonlab_rate], eax
    PRINT p_lab, p_lab_len
    call read_rate
    mov [lab_rate], eax
    call calculate_tuition_proc
    call build_cor_proc
    mov dword [ready], 1
    PRINT entered, entered_len
    jmp menu_loop

output_proc:
    cmp dword [ready], 1
    jne missing_data
    PRINT cor_buffer, [cor_length]
    jmp menu_loop
missing_data:
    PRINT no_data, no_data_len
    jmp menu_loop

save_proc:
    cmp dword [ready], 1
    jne missing_data
    mov eax, SYS_OPEN
    mov ebx, filename
    mov ecx, 577
    mov edx, 384
    int 0x80
    test eax, eax
    js file_failed
    mov ebx, eax
    mov ecx, cor_buffer
    mov edx, [cor_length]
    call write_all
    push eax
    mov eax, SYS_CLOSE
    int 0x80
    pop edx
    test eax, eax
    js file_failed
    test edx, edx
    js file_failed
    PRINT saved, saved_len
    jmp menu_loop

load_proc:
    mov eax, SYS_OPEN
    mov ebx, filename
    xor ecx, ecx
    xor edx, edx
    int 0x80
    test eax, eax
    js file_failed
    mov ebx, eax
    PRINT read_title, read_title_len
.read_chunk:
    mov eax, SYS_READ
    mov ecx, file_buffer
    mov edx, 4096
    int 0x80
    cmp eax, -4
    je .read_chunk
    test eax, eax
    js .read_error
    jz .close_file
    push ebx
    mov ebx, 1
    mov edx, eax
    call write_all
    pop ebx
    test eax, eax
    js .read_error
    jmp .read_chunk
.close_file:
    mov eax, SYS_CLOSE
    int 0x80
    test eax, eax
    js file_failed
    PRINT nl, nl_len
    jmp menu_loop
.read_error:
    mov eax, SYS_CLOSE
    int 0x80
file_failed:
    PRINT file_error, file_error_len
    jmp menu_loop

exit_program:
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80

read_line:
    push ebx
    push esi
    push edi
    push ebp
    mov esi, ecx
    mov edi, edx
    xor ebp, ebp
    xor ebx, ebx
.next_byte:
    push ebx
.retry_byte:
    mov eax, SYS_READ
    xor ebx, ebx
    mov ecx, input_byte
    mov edx, 1
    int 0x80
    cmp eax, -4
    je .retry_byte
    pop ebx
    test eax, eax
    js .failure
    jz .eof
    mov al, [input_byte]
    cmp al, 10
    je .done
    cmp al, 13
    je .next_byte
    cmp ebp, edi
    jae .overflow
    mov [esi+ebp], al
    inc ebp
    jmp .next_byte
.overflow:
    mov ebx, 1
    jmp .next_byte
.eof:
    test ebp, ebp
    jnz .done
.failure:
    mov eax, -1
    jmp .return
.done:
    mov byte [esi+ebp], 0
    mov eax, ebp
    test ebx, ebx
    jz .return
    mov eax, -2
.return:
    pop ebp
    pop edi
    pop esi
    pop ebx
    ret

read_rate:
.retry:
    mov ecx, scratch
    mov edx, 127
    call read_line
    cmp eax, -2
    je .invalid
    test eax, eax
    js exit_program
    jz .invalid
    mov ecx, eax
    mov esi, scratch
    xor eax, eax
.digit:
    movzx edx, byte [esi]
    sub edx, '0'
    cmp edx, 9
    ja .invalid
    imul eax, eax, 10
    add eax, edx
    cmp eax, 1000000
    ja .invalid
    inc esi
    loop .digit
    ret
.invalid:
    PRINT bad_rate, bad_rate_len
    jmp .retry

calculate_tuition_proc:
    mov eax, [nonlab_rate]
    imul eax, NON_LAB_UNITS
    mov [nonlab_fee], eax
    mov edx, [lab_rate]
    imul edx, LAB_UNITS
    mov [lab_fee], edx
    add eax, edx
    mov [tuition], eax
    ret

build_cor_proc:
    mov dword [cor_length], 0
    APPEND heading, heading_len
    APPEND label_status, label_status_len
    APPEND in_status, [len_status]
    APPEND nl, nl_len
    APPEND label_snum, label_snum_len
    APPEND in_snum, [len_snum]
    APPEND nl, nl_len
    APPEND label_name, label_name_len
    APPEND in_name, [len_name]
    APPEND nl, nl_len
    APPEND label_phone, label_phone_len
    APPEND in_phone, [len_phone]
    APPEND nl, nl_len
    APPEND label_zip, label_zip_len
    APPEND in_zip, [len_zip]
    APPEND nl, nl_len
    APPEND label_coll, label_coll_len
    APPEND in_coll, [len_coll]
    APPEND nl, nl_len
    APPEND label_prog, label_prog_len
    APPEND in_prog, [len_prog]
    APPEND nl, nl_len
    APPEND label_year, label_year_len
    APPEND in_year, [len_year]
    APPEND nl, nl_len
    APPEND label_term, label_term_len
    APPEND in_term, [len_term]
    APPEND nl, nl_len
    APPEND label_addr, label_addr_len
    APPEND in_addr, [len_addr]
    APPEND nl, nl_len

    APPEND label_class, label_class_len
    APPEND nl, nl_len
    APPEND nl, nl_len
    APPEND schedule, schedule_len
    APPEND lecture_label, lecture_label_len
    mov eax, [nonlab_rate]
    call append_number
    APPEND times_result, times_result_len
    mov eax, [nonlab_fee]
    call append_number
    APPEND nl, nl_len
    APPEND lab_label, lab_label_len
    mov eax, [lab_rate]
    call append_number
    APPEND times_result, times_result_len
    mov eax, [lab_fee]
    call append_number
    APPEND nl, nl_len
    APPEND total_label, total_label_len
    mov eax, [tuition]
    call append_number
    APPEND nl, nl_len
    ret

append_proc:
    pushad
    mov esi, ecx
    mov edi, cor_buffer
    add edi, [cor_length]
    mov ecx, edx
    rep movsb
    add [cor_length], edx
    popad
    ret

append_number:
    pushad
    mov edi, number_buffer+16
    mov ebx, 10
    xor ecx, ecx
.convert:
    xor edx, edx
    div ebx
    add dl, '0'
    dec edi
    mov [edi], dl
    inc ecx
    test eax, eax
    jnz .convert
    mov edx, ecx
    mov ecx, edi
    call append_proc
    popad
    ret

write_all:
    push ecx
    push edx
.next:
    test edx, edx
    jz .success
    mov eax, SYS_WRITE
    int 0x80
    cmp eax, -4
    je .next
    test eax, eax
    js .return
    jz .zero_write
    add ecx, eax
    sub edx, eax
    jmp .next
.zero_write:
    mov eax, -5
    jmp .return
.success:
    xor eax, eax
.return:
    pop edx
    pop ecx
    ret
