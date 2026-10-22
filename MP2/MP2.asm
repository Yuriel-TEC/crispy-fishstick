
; ============================================================
; MACHINE PROBLEM 2: NEBULA OF THE LOST FLEET
; Space Adventure Game
; NASM x86 32-bit Assembly - Linux (int 0x80)
; ============================================================

section .data

; ============================================================
; ASCII ART SECTION
; Replace the artwork below with your own ASCII art.
; Every artwork must end with 0.
; Use 10 to create a new line.
; ============================================================

welcome_art:
db 10
db "========================================", 10
db " NEBULA OF THE LOST FLEET ", 10
db "========================================", 10
db " SPACE ADVENTURE GAME ", 10
db "========================================", 10, 0

alien_art:
db 10
db "  /        \ ", 10
db " /_        _\", 10
db "// \      / \\", 10
db "|\__\    /__/|", 10
db " \    ||    /", 10
db "  \        / ", 10
db "   \  __  / ", 10
db "    '.__.' ", 10
db "     |  | ", 10
db " HOSTILE ALIEN! ", 10, 0

pod_art:
db 10
db "   _________________", 10
db "  /\                \", 10
db " /  \                \", 10
db "/    \________________\", 10
db "\    /                /", 10
db " \  /                /", 10
db "  \/________________/", 10
db "     ||          ||", 10
db "     ||          ||", 10
db "____/ |__________/ |____", 10
db "/_______________________/", 10



mothership_art:
db 10
db "                        .____ .--. ____.", 10
db "                       .'_.- (    ) -._'.", 10
db "                     .'.'    |'..'|    '.'.", 10
db "              .-.  .' /'--.__|____|__.--'\ '.  .-.", 10
db "               (O).)-| |  \    |    |    /  | |-(.(O)", 10
db "              `-'  '-'-._'-./      \.-'_.-'-'  `-'", 10
db "                 _ | |   '-.________.-'   | | _ ", 10
db "              .' _ | |     |   __   |     | | _ '. ", 10
db "             / .' ''.|     | /    \ |     |.'' '. \", 10
db "             | |( )| '.    ||      ||    .' |( )| |", 10
db "             \ '._.'   '.  | \    / |  .'   '._.' /", 10
db "              '.__ ______'.|__'--'__|.'______ __.'", 10
db "             .'_.-|         |------|         |-._'.", 10
db "              '.__ ______'.|__'--'__|.'______ __.'", 10
db "            //\\  |         |--::--|         |  //\\", 10
db "           //  \\ |         |--::--|         | //  \\", 10
db "          //    \\|        /|--::--|\        |//    \\", 10
db "         / '._.-'/|_______/ |--::--| \_______|\`-._.' \", 10
db "        / __..--'        /__|--::--|__\        `--..__ \", 10
db "       / /               '-.|--::--|.-'               \ \", 10
db "      / /                   |--::--|                   \ \", 10
db "     / /                    |--::--|                    \ \", 10
db " _.-'  `-._                 _..||.._                  _.-` '-._", 10
db "'--..__..--'               '-.____.-'                '--..__..-'", 10




; ============================================================
; GAME MESSAGES
; ============================================================

prompt_name:
db "Enter your operative callsign: ", 0

prompt_class:
db 10, "Choose your starship class:", 10
db "[1] The Vanguard", 10
db " Shields: 100 | Laser: 20 | Nano-Cells: 2", 10
db "[2] The Infiltrator", 10
db " Shields: 70 | Laser: 30 | Nano-Cells: 3", 10
db "[3] The Technomancer", 10
db " Shields: 85 | Laser: 25 | Nano-Cells: 2", 10
db "Enter choice: ", 0

err_cls:
db "Invalid class choice! Try again.", 10, 0

main_menu_str:
db 10, "========== COMMAND DECK ==========", 10
db "[1] Explore Sector", 10
db "[2] View Operative Status", 10
db "[3] Use Nano-Cell Stimulant", 10
db "[4] View Cargo Inventory", 10
db "[5] Abort Mission", 10
db "Enter choice: ", 0

err_option:
db "Invalid choice! Please try again.", 10, 0

alien_msg:
db 10, "A HOSTILE ALIEN INTERCEPTS YOU!", 10, 0

pod_msg:
db 10, "YOU DISCOVERED AN ABANDONED SUPPLY POD!", 10
db "[1] Salvage Pod", 10
db "[2] Ignore Pod", 10
db "Choice: ", 0

mothership_msg:
db 10, "THE ALIEN MOTHERSHIP APPROACHES!", 10, 0

combat_menu:
db 10, "---------- COMBAT MENU ----------", 10
db "[1] Fire Lasers", 10
db "[2] Deflector Shields", 10
db "[3] Use Nano-Cell", 10
db "[4] Warp Escape", 10
db "Action: ", 0

msg_enemy_hp:
db "Enemy Health: ", 0

msg_hero_atk:
db "Your laser strike hits for ", 0

msg_dmg_pts:
db " damage!", 10, 0

msg_ene_retal:
db "The enemy fires back, dealing ", 0

msg_def_prep:
db "Deflector shields activated!", 10, 0

msg_run_away:
db "You successfully warped away!", 10, 0

msg_open_pod:
db "You salvaged 50 Credits!", 10, 0

msg_skip_pod:
db "You left the pod drifting.", 10, 0

msg_pot_used:
db "Nano-Cell injected! Shields restored.", 10, 0

err_no_pot:
db "Error: No Nano-Cells left!", 10, 0

msg_full_hp:
db "Shields already at maximum!", 10, 0

msg_enemy_defeated:
db "Enemy defeated! Sector cleared!", 10, 0

msg_invalid_combat:
db "Invalid combat action!", 10, 0

msg_invalid_pod:
db "Invalid pod choice! Try again.", 10, 0

msg_sector:
db "Current Sector: ", 0

lbl_status_hdr:
db 10, "========== OPERATIVE STATUS ==========", 10, 0

lbl_name:
db "Operative Callsign: ", 0

lbl_class:
db "Starship Class: ", 0

class_v:
db "The Vanguard", 10, 0

class_i:
db "The Infiltrator", 10, 0

class_t:
db "The Technomancer", 10, 0

lbl_hp:
db "Shield Integrity: ", 0

lbl_slash:
db "/", 0

lbl_atk:
db "Laser Output: ", 0

lbl_gold:
db "Credits: ", 0

lbl_potions:
db "Nano-Cells: ", 0

lbl_inventory:
db 10, "========== CARGO INVENTORY ==========", 10, 0

newline:
db 10, 0

msg_victory:
db 10
db "========================================", 10
db " MISSION VICTORY! ", 10
db " THE MOTHERSHIP IS DESTROYED! ", 10
db "========================================", 10, 0

msg_gameover:
db 10
db "========================================", 10
db " GAME OVER ", 10
db " YOUR SHIP WAS DESTROYED! ", 10
db "========================================", 10, 0

msg_abort:
db 10, "Mission aborted. Goodbye, operative!", 10, 0

; ============================================================
; UNINITIALIZED VARIABLES
; ============================================================

section .bss

player_name resb 64
input_buf resb 16

char_class resd 1
cur_hp resd 1
max_hp resd 1
atk_power resd 1
potions resd 1
gold resd 1

current_room resd 1
enemy_hp resd 1
enemy_atk resd 1
is_defending resd 1

battle_result resd 1
potion_result resd 1

num_str resb 16

; ============================================================
; MAIN PROGRAM
; ============================================================

section .text
global _start

_start:

mov esi, welcome_art
call print_string

call get_player_info
call initialize_character

game_loop:

call display_main_menu
jmp game_loop

; ============================================================
; GET PLAYER INFORMATION
; ============================================================

get_player_info:

mov esi, prompt_name
call print_string

mov eax, 3
mov ebx, 0
mov ecx, player_name
mov edx, 63
int 0x80

cmp eax, 0
jle exit_program

; Replace the newline with a null terminator.
mov ecx, eax
mov esi, player_name

name_clean_loop:

cmp byte [esi], 10
je name_clean_done

cmp byte [esi], 13
je name_clean_done

inc esi
dec ecx
jnz name_clean_loop

name_clean_done:

mov byte [esi], 0

class_selection:

mov esi, prompt_class
call print_string

call read_choice

cmp eax, 1
jl class_error

cmp eax, 3
jg class_error

mov [char_class], eax
ret

class_error:

mov esi, err_cls
call print_string

jmp class_selection

; ============================================================
; INITIALIZE CHARACTER
; ============================================================

initialize_character:

mov dword [gold], 0
mov dword [current_room], 1
mov dword [battle_result], 0
mov dword [is_defending], 0

mov eax, [char_class]

cmp eax, 1
je init_vanguard

cmp eax, 2
je init_infiltrator

jmp init_technomancer

init_vanguard:

mov dword [cur_hp], 100
mov dword [max_hp], 100
mov dword [atk_power], 20
mov dword [potions], 2
ret

init_infiltrator:

mov dword [cur_hp], 70
mov dword [max_hp], 70
mov dword [atk_power], 30
mov dword [potions], 3
ret

init_technomancer:

mov dword [cur_hp], 85
mov dword [max_hp], 85
mov dword [atk_power], 25
mov dword [potions], 2
ret

; ============================================================
; MAIN MENU
; ============================================================

display_main_menu:

mov esi, main_menu_str
call print_string

call read_choice

cmp eax, 1
je menu_explore

cmp eax, 2
je menu_status

cmp eax, 3
je menu_potion

cmp eax, 4
je menu_inventory

cmp eax, 5
je menu_exit

mov esi, err_option
call print_string
ret

menu_explore:

call explore_sector
ret

menu_status:

call display_status
ret

menu_potion:

call use_potion
ret

menu_inventory:

call display_inventory
ret

menu_exit:

mov esi, msg_abort
call print_string
jmp exit_program

; ============================================================
; SECTOR EXPLORATION
; ============================================================

explore_sector:

mov eax, [current_room]

cmp eax, 1
je sector_one

cmp eax, 2
je sector_two

cmp eax, 3
je sector_three

ret

; ============================================================
; SECTOR 1 - ALIEN
; ============================================================

sector_one:

mov esi, alien_art
call print_string

mov esi, alien_msg
call print_string

mov dword [enemy_hp], 30
mov dword [enemy_atk], 10

call battle_enemy

; Result 1 means the alien was defeated.
cmp dword [battle_result], 1
je alien_defeated

; Result 2 means the player escaped.
cmp dword [battle_result], 2
je alien_escaped

; Otherwise the player died.
jmp player_dead

alien_defeated:

mov esi, msg_enemy_defeated
call print_string

mov dword [current_room], 2
ret

alien_escaped:

; Stay in Sector 1.
ret

; ============================================================
; SECTOR 2 - SUPPLY POD
; ============================================================

sector_two:

mov esi, pod_art
call print_string

pod_choice:

mov esi, pod_msg
call print_string

call read_choice

cmp eax, 1
je salvage_pod

cmp eax, 2
je ignore_pod

mov esi, msg_invalid_pod
call print_string

jmp pod_choice

salvage_pod:

add dword [gold], 50

mov esi, msg_open_pod
call print_string

jmp next_sector

ignore_pod:

mov esi, msg_skip_pod
call print_string

next_sector:

mov dword [current_room], 3
ret

; ============================================================
; SECTOR 3 - MOTHERSHIP
; ============================================================

sector_three:

mov esi, mothership_art
call print_string

mov esi, mothership_msg
call print_string

mov dword [enemy_hp], 60
mov dword [enemy_atk], 15

call battle_enemy

cmp dword [battle_result], 1
je mission_victory

cmp dword [battle_result], 2
je mothership_escaped

jmp player_dead

mothership_escaped:

; Stay in Sector 3.
ret

mission_victory:

mov esi, msg_victory
call print_string

jmp exit_program

player_dead:

mov esi, msg_gameover
call print_string

jmp exit_program

; ============================================================
; COMBAT SYSTEM
; ============================================================

battle_enemy:

mov dword [battle_result], 0

battle_loop:

mov dword [is_defending], 0

; Display enemy HP.
mov esi, msg_enemy_hp
call print_string

mov eax, [enemy_hp]
call print_int

mov esi, newline
call print_string

; Display combat choices.
mov esi, combat_menu
call print_string

call read_choice

cmp eax, 1
je battle_attack

cmp eax, 2
je battle_defend

cmp eax, 3
je battle_potion

cmp eax, 4
je battle_escape

mov esi, msg_invalid_combat
call print_string

jmp battle_loop

; ============================================================
; PLAYER ATTACK
; ============================================================

battle_attack:

mov eax, [atk_power]
sub dword [enemy_hp], eax

cmp dword [enemy_hp], 0
jge attack_message

mov dword [enemy_hp], 0

attack_message:

mov esi, msg_hero_atk
call print_string

mov eax, [atk_power]
call print_int

mov esi, msg_dmg_pts
call print_string

cmp dword [enemy_hp], 0
jle enemy_defeated

jmp enemy_turn

; ============================================================
; DEFEND
; ============================================================

battle_defend:

mov dword [is_defending], 1

mov esi, msg_def_prep
call print_string

jmp enemy_turn

; ============================================================
; USE NANO-CELL DURING COMBAT
; ============================================================

battle_potion:

call use_potion

; Only consume a combat turn if healing succeeded.
cmp dword [potion_result], 1
je enemy_turn

jmp battle_loop

; ============================================================
; WARP ESCAPE
; ============================================================

battle_escape:

mov esi, msg_run_away
call print_string

mov dword [battle_result], 2
ret

; ============================================================
; ENEMY TURN
; ============================================================

enemy_turn:

mov eax, [enemy_atk]

cmp dword [is_defending], 1
jne take_damage

sub eax, 5

cmp eax, 0
jge take_damage

mov eax, 0

take_damage:

sub dword [cur_hp], eax

; Preserve damage value while printing.
push eax

mov esi, msg_ene_retal
call print_string

pop eax
call print_int

mov esi, msg_dmg_pts
call print_string

cmp dword [cur_hp], 0
jle player_destroyed

jmp battle_loop

player_destroyed:

mov dword [cur_hp], 0
mov dword [battle_result], 0
ret

enemy_defeated:

mov dword [battle_result], 1
ret

; ============================================================
; NANO-CELL SYSTEM
; ============================================================

use_potion:

mov dword [potion_result], 0

mov eax, [potions]

cmp eax, 0
jle no_potions

mov eax, [cur_hp]
cmp eax, [max_hp]
jge full_health

; Consume one Nano-Cell.
dec dword [potions]

; Restore 20 shields.
add dword [cur_hp], 20

mov eax, [cur_hp]
mov ebx, [max_hp]

cmp eax, ebx
jle potion_success

; Do not exceed maximum shields.
mov [cur_hp], ebx

potion_success:

mov dword [potion_result], 1

mov esi, msg_pot_used
call print_string

ret

no_potions:

mov esi, err_no_pot
call print_string

ret

full_health:

mov esi, msg_full_hp
call print_string

ret

; ============================================================
; OPERATIVE STATUS
; ============================================================

display_status:

mov esi, lbl_status_hdr
call print_string

; Player name.
mov esi, lbl_name
call print_string

mov esi, player_name
call print_string

mov esi, newline
call print_string

; Character class.
mov esi, lbl_class
call print_string

mov eax, [char_class]

cmp eax, 1
je status_vanguard

cmp eax, 2
je status_infiltrator

mov esi, class_t
jmp print_class

status_vanguard:

mov esi, class_v
jmp print_class

status_infiltrator:

mov esi, class_i

print_class:

call print_string

; Shield integrity.
mov esi, lbl_hp
call print_string

mov eax, [cur_hp]
call print_int

mov esi, lbl_slash
call print_string

mov eax, [max_hp]
call print_int

mov esi, newline
call print_string

; Laser damage.
mov esi, lbl_atk
call print_string

mov eax, [atk_power]
call print_int

mov esi, newline
call print_string

; Current sector.
mov esi, msg_sector
call print_string

mov eax, [current_room]
call print_int

mov esi, newline
call print_string

ret

; ============================================================
; CARGO INVENTORY
; ============================================================

display_inventory:

mov esi, lbl_inventory
call print_string

mov esi, lbl_gold
call print_string

mov eax, [gold]
call print_int

mov esi, newline
call print_string

mov esi, lbl_potions
call print_string

mov eax, [potions]
call print_int

mov esi, newline
call print_string

ret

; ============================================================
; INPUT HANDLING
; Reads a single-digit menu choice.
; Also discards extra characters until newline.
; ============================================================

read_choice:

push ebx
push ecx
push edx
push esi
push edi

; Default invalid result.
mov edi, -1
xor esi, esi

read_choice_loop:

mov eax, 3
mov ebx, 0
mov ecx, input_buf
mov edx, 1
int 0x80

cmp eax, 0
jle input_eof

mov al, [input_buf]

cmp al, 10
je input_finished

cmp al, 13
je read_choice_loop

; Only accept exactly one digit.
inc esi

cmp esi, 1
jne input_invalid

cmp al, '0'
jb input_invalid

cmp al, '9'
ja input_invalid

movzx edi, al
sub edi, '0'

jmp read_choice_loop

input_invalid:

mov edi, -1
jmp read_choice_loop

input_eof:

; End the program if standard input is closed.
jmp exit_program

input_finished:

mov eax, edi

pop edi
pop esi
pop edx
pop ecx
pop ebx

ret

; ============================================================
; PRINT NULL-TERMINATED STRING
; Input: ESI = address of string
; ============================================================

print_string:

push eax
push ebx
push ecx
push edx

mov ecx, esi
xor edx, edx

print_string_loop:

cmp byte [ecx + edx], 0
je print_string_done

inc edx
jmp print_string_loop

print_string_done:

mov eax, 4
mov ebx, 1
int 0x80

pop edx
pop ecx
pop ebx
pop eax

ret

; ============================================================
; PRINT UNSIGNED INTEGER
; Input: EAX = number to print
; ============================================================

print_int:

push eax
push ebx
push ecx
push edx
push esi

mov ecx, num_str + 15
mov byte [ecx], 0

mov ebx, 10

print_int_loop:

xor edx, edx
div ebx

add dl, '0'

dec ecx
mov [ecx], dl

test eax, eax
jnz print_int_loop

mov esi, ecx
call print_string

pop esi
pop edx
pop ecx
pop ebx
pop eax

ret

; ============================================================
; EXIT PROGRAM
; ============================================================

exit_program:

mov eax, 1
mov ebx, 0
int 0x80