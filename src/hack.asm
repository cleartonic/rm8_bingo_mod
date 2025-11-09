.psx

.open "../build/SLPS_006_VANILLA.30", "../build/SLPS_006.30", 0x800C0000-0x800


; these areas are places in RAM, past the end of the SLPS file (at 0x925D0 in HxD/0x151D70 in debugger), where the game doesn't appear to employ these RAM spaces. if things start crashing, check these areas first to see if the game is overwriting them
; remember that the game seemingly loads ROM into RAM at first, then may freely overwrite it later 

AREA1 equ 0x80153700
AREA2 equ 0x80153730
AREA3 equ 0x80153780
AREA4 equ 0x80154300
AREA5 equ 0x80154150
AREA6 equ 0x80154380
; 1543F0 starts area where Forte battle uses RAM

ID_INTRO equ 0x00
ID_FROST equ 0x01
ID_CLOWN equ 0x02
ID_TENGU equ 0x03
ID_GRENADE equ 0x04
ID_SWORD equ 0x05
ID_AQUA equ 0x06
ID_ASTRO equ 0x07
ID_SEARCH equ 0x08
ID_DUO equ 0x09
ID_WILY equ 0x0A



; at 001B...
RM_GET_MEGA_BALL equ 0x1304
RM_DEFEATED_GRENADE equ 0x1308
RM_DEFEATED_CLOWN equ 0x130C
RM_DEFEATED_FROST equ 0x1310
RM_DEFEATED_TENGU equ 0x1314
RM_DEFEATED_AQUA equ 0x1318
RM_DEFEATED_SWORD equ 0x131C
RM_DEFEATED_SEARCH equ 0x1320
RM_DEFEATED_ASTRO equ 0x1324

;0016
HYPER_SLIDER equ 0xC746 
RUSH_BIKE equ 0xC754
RUSH_QUESTION equ 0xC755
RUSH_BOMBER equ 0xC756
RUSH_CHARGER equ 0xC757

; Macros for replacing existing code and then jumping back to cave org
.macro replace,dest
	.org dest
.endmacro
.macro endreplace,nextlabel
	.org org(nextlabel)
.endmacro

; Stack macros
.macro push,reg
	addiu sp,sp,-4
	sw reg,(sp)
.endmacro
.macro pop,reg
	lw reg,(sp)
	addiu sp,sp,4
.endmacro

; new macro
.macro addw,address
    ori v1,$zero, 0x0001
    lui at, 0x801B
    sb v1, address(at)
.endmacro
.macro remw,address
    ori v1,$zero, 0x0000
    lui at, 0x801B
    sb v1, address(at)
.endmacro

;slider is actually always setting 0x04 for exit part functionality
.macro addslider
    push at
    push v1
    lui at, 0x8017
    ori v1,$zero, 0x000F
    sb v1, HYPER_SLIDER(at)
    pop v1
    pop at
.endmacro
.macro removeslider
    push at
    push v1
    lui at, 0x8017
    ori v1,$zero, 0x0004
    sb v1, HYPER_SLIDER(at)
    pop v1
    pop at
.endmacro


.macro addrush,address
    lui at, 0x8017
    ori v1,$zero, 0x0001
    sb v1, address(at)
.endmacro
.macro removerush,address
    lui at, 0x8017
    ori v1,$zero, 0x0000
    sb v1, address(at)
.endmacro



.macro setpostduo
lui at, 0x801c
ori v0,$zero, 0x0005
sb v0, 0x27c0(at)
.endmacro

.macro setatduo
lui at, 0x801c
ori v0,$zero, 0x0003
sb v0, 0x27c0(at)
.endmacro




@go_to_stage_select_on_game_start:
replace 0x80100AF0
addw RM_GET_MEGA_BALL
j 0x80100B88
endreplace @go_to_stage_select_on_game_start


@stage_select_allow_second_page_hook:
replace 0x800FFF04
j 0x800FFF30
endreplace @stage_select_allow_second_page_hook

; 801c27C0 duo


@stage_select_allow_second_page_hook2:
replace 0x800ffb6C
lbu v0, 0x01
nop
sb v0, 0x3(s0)

endreplace @stage_select_allow_second_page_hook2


@stage_select_allow_wily_stage:
replace 0x800FFD60
j AREA1
endreplace @stage_select_allow_wily_stage

@stage_select_allow_wily_stage_return:
replace AREA1
; lbu v0, 0x27c0(v0)
; nop
; sltiu v0, v0, 5
lbu v0, 0x01
nop
nop

bne v0, zero, @@resume_wily_function
andi v0, a0, 0x08a0
ori v0, zero, 0x000a
bne v1, v0, @@resume_wily_function
nop
addrush RUSH_BIKE
addrush RUSH_QUESTION
addrush RUSH_BOMBER
addrush RUSH_CHARGER
addw RM_DEFEATED_GRENADE
addw RM_DEFEATED_CLOWN
addw RM_DEFEATED_FROST
addw RM_DEFEATED_TENGU
addw RM_DEFEATED_AQUA
addw RM_DEFEATED_SWORD
addw RM_DEFEATED_SEARCH
addw RM_DEFEATED_ASTRO
j 0x800FFD7C
nop

@@resume_wily_function:
j 0x800FFE48
nop
endreplace @stage_select_allow_wily_stage_return



; 0x801D8560
; C0 27 42 90 38 00 07 92
; 1625E4A8


; @stage_select_allow_second_page_return:
; replace AREA1
; addw RM_GET_MEGA_BALL
; setpostduo
; ori v0,$zero, 0x0002
; j 0x80100A9C
; nop
; endreplace @stage_select_allow_second_page_return


.close
