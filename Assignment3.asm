; Program template
TITLE   Assignment 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This program prompts the user for 3 values, plugs them into this equation:
; ( (num1 ^ 3) * num2 + 5 * ( num2 ^ 2) ) / num3
; and displays it on the screen.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COMMENT !
a. you need four variables num1, num2, num3 and result. 
   your variables need to be 4 bytes unsigned 
b. you need three prompt strings 
  
c. procedures that you need to call:
   writeString
   readDec
   writeDec 
   crlf
!

INCLUDE Irvine32.inc

.data
	prompt1 byte "num1: ", 0
	prompt2 byte "num2: ", 0
	prompt3 byte "num3: ", 0
	prompt4 byte " R ", 0
	num0 byte 5

.code
main PROC

	; calculation:

	mov edx, offset prompt1
	call writeString
	call readDec
	mov ebx, eax
	mul ebx
	mul ebx
	mov ebx, eax
	
	mov edx, offset prompt2
	call writeString
	call readDec
	mov ecx, eax
	mul ebx
	mov ebx, eax

	mov eax, ecx
	mul ecx
	mul num0
	add ebx, eax
	mov edx, offset prompt3
	call writeString
	call readDec
	mov ecx, eax
	mov eax, ebx
	mov edx, 0
	div ecx

	call writeDec
	
	mov eax, edx
	mov edx, offset prompt4

	call writeString

	call writeDec
	crlf

    exit   
main ENDP
END main

COMMENT !
Test Run:

num1: 1
num2: 2
num3: 3
7 R 1
Press any key to continue . . .

!