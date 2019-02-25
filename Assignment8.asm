;Assignment 8

include irvine32.inc
MAXELEM = 40
.data
	string1 byte "Enter how many elements in your array (less than 40): ",0
	string2 byte "Enter the row size: ",0
	string3 byte "Enter the type of your array.",0Dh, 0Ah
			byte " 1 for byte.",0Dh, 0Ah
			byte " 2 for word.",0Dh, 0Ah
			byte " 4 for doubleword.",0
	string4 byte "Enter an element in your array, ",0
	string5 byte "Enter row number that you want me to sum: ",0
	string6 byte "The sum is: ",0
	
	arrByte dword MAXELEM dup (?)
	arrWord dword MAXELEM dup (?)
	arrDword dword MAXELEM dup (?)
	numRows dword ?
  ; Fill your data here

; =================================================
.code
main proc
	
	L01:
	mov edx, offset string1
	call writeString
	call readdec
	cmp eax, 40
	JG L01

	mov ecx, eax
	mov edx, offset string2
	call writeString
	call readdec
	mov numRows, eax

	mov edx, offset string3
	call writeString
	call crlf
	call readDec
	cld

	cmp eax, 1
	JE byteloop
	cmp eax, 2
	JE wordloop
	cmp eax, 4
	JE dwordloop

byteloop:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov edi, offset arrByte
	L1:
		mov edx, offset string4
		call writeString
		call readdec
		STOSB
	Loop L1


	mov edx, offset string5
	call writeString
	call readdec

	mov edx, offset string6
	call writeString

	sub esp, 4
	push offset arrByte
	push numRows
	push eax
	call sumByte
jmp endif01

wordloop:
	mov edi, offset arrWord
	L2:
		mov edx, offset string4
		call writeString
		call readdec
		STOSW
	Loop L2


	mov edx, offset string5
	call writeString
	call readdec

	mov edx, offset string6
	call writeString

	sub esp, 4
	push offset arrWord
	push numRows
	push eax
	call sumWord

jmp endif01

dwordloop:
	mov edi, offset arrDword
	L3:
		mov edx, offset string4
		call writeString
		call readdec
		stosd
	Loop L3


	mov edx, offset string5
	call writeString
	call readdec

	mov edx, offset string6
	call writeString

	sub esp, 4
	push offset arrDword
	push numRows
	push eax
	call sumDword

endif01:

	pop eax
	call writeHex
	call crlf

   exit
main endp



sumByte proc
	push ebp
	mov ebp, esp
	push esi
	push eax
	push ecx
	push edx
	
	mov eax, [ebp + 8]; column
	mov ecx, [ebp + 12]

	mul ecx

	mov esi, [ebp + 16]
	add esi, eax
	xor edx, edx

	L1:
		LODSB
		add edx, eax
	Loop L1
	
	mov [ebp+20], edx

	pop edx
	pop ecx
	pop eax
	pop esi
	pop ebp

ret 12
sumByte endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

sumWord proc
	
	push ebp
	mov ebp, esp
	push esi
	push eax
	push ecx
	push edx
	push ebx

	mov eax, [ebp + 8]; column
	mov ebx, 2
	mov ecx, [ebp + 12]

	mul ecx
	mul ebx

	mov esi, [ebp + 16]
	add esi, eax
	xor edx, edx

	L1:
		LODSW
		add edx, eax
	Loop L1
	
	mov [ebp+20], edx

	pop ebx
	pop edx
	pop ecx
	pop eax
	pop esi
	pop ebp

ret 12
sumWord endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

sumDword proc
	
	push ebp
	mov ebp, esp
	push esi
	push eax
	push ecx
	push edx
	push ebx

	mov eax, [ebp + 8]; column
	mov ebx, 4
	mov ecx, [ebp + 12]

	mul ecx
	mul ebx

	mov esi, [ebp + 16]
	add esi, eax
	xor edx, edx

	L1:
		LODSD
		add edx, eax
	Loop L1
	
	mov [ebp+20], edx

	pop ebx
	pop edx
	pop ecx
	pop eax
	pop esi
	pop ebp

ret 12
sumDword endp


end main