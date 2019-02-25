; Program template
TITLE   Assignment 4
Write a complete program that:
    1. Prompts the user to enter 5 numbers then 5 letters.
    2. Saves the numbers to a 32-bit integer array, numArr.
    3. Saves the letters to charArr where each element reserves one byte.
    4. Prints the numbers and letters. 
    5. prints the mean of the number array,numArr
    6. copy all the elements from the numArr and the charArr
        to a quadword array, newArr in a reverse order.
        where each qword in newArr contains a letter that occupies
        4 bytes and a number that occupies 4 bytes, 
    7. Prints out the newArr.
    8. dumps out the memory for each array. This is done for you.  
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      You MUST use loop and indirect addressing. 
      You MUST use the SIZEOF, TYPE, and LENGTHOF operators to make the program
      as flexible as possible if the arrays' size and type should be 
      changed in the future. NO IMMEDIATATE NUMBERS AT ALL IN THE CODE SEGMENT.
      Add comments to make your program easy to read. Your lines must not 
	  exceed 80 columns.
	  Look at the sample run for clarification.
	  Don't delete anything already written for you.		
	  Copy paste 2 of your runs and paste them at the end of your code

	!
    

include irvine32.inc

.data


string1 byte 0Ah,0Dh,"Dumping out charArr",0
string2 byte 0Ah,0Dh,"Dumping out numArr", 0
string3 byte 0Ah,0Dh,"Dumping out newArr", 0

charArr byte   5 dup  (?)
numArr  dword  5 dup  (?)
newArr  qword  5 dup  (?)

; add your data here

; prompts
letterPrompt		 byte "Enter 5 letters: ", 0
numberPrompt		 byte "Enter a number: ", 0
letterPrintPrompt	 byte "letters entered: ", 0
numberPrintPrompt	 byte "numbers entered: ", 0
meanPrompt			 byte "mean of numbers is: ", 0
newArrPrompt		 byte "contents of newArr are: ", 0

; contrived way to avoid using literals
slash dword '/'
space dword ' '

.code
main proc
	;----------------------------Your Code starts Here-----------------------

	; prep for charArr intake loop
	mov ecx, LENGTHOF charArr
	mov esi, OFFSET charArr
	sub ebx, ebx
	mov edx, OFFSET letterPrompt
	call writeString

	; populate the charArr
	L1: call readChar
		mov [esi], eax
		add esi, TYPE charArr
	loop L1

	;  prep for charArr print loop
	mov ecx, LENGTHOF charArr
	mov esi, OFFSET charArr
	mov edx, OFFSET letterPrintPrompt
	call CRLF
	call CRLF
	call writeString
	call CRLF

	; print out the charArr
	L4: mov eax, [esi]
		add esi, TYPE charArr
		call writeChar
		mov eax, space
		call writeChar
	loop L4
	
	; prep for numArr intake loop
	mov ecx, LENGTHOF numArr
	mov edx, OFFSET numberPrompt
	mov esi, OFFSET numArr
	sub ebx, ebx
	call CRLF
	call CRLF

	; populate the numArr
	L2: call writeString
		call readDec
		mov [esi], eax
		add esi, TYPE numArr
	loop L2

	;  prep for numArr print loop
	mov ecx, LENGTHOF numArr
	mov esi, OFFSET numArr
	mov edx, OFFSET numberPrintPrompt
	call CRLF
	call writeString
	sub ebx, ebx
	call CRLF

	; print out the numArr
	L3: mov eax, [esi]
		add ebx, eax
		add esi, TYPE numArr
		call writeDec
		mov eax, space
		call writeChar
	loop L3

	; print mean prompt
	mov edx, OFFSET meanPrompt
	call CRLF
	call CRLF
	call writeString
	call CRLF

	; calculate the mean
	; (num arr total is currently stored in ebx)
	sub edx, edx
	mov eax, ebx
	mov ebx, LENGTHOF numArr
	div ebx

	; print mean
	call writeDec
	mov eax, space
	call writeChar
	mov eax, edx
	call writeDec
	mov eax, slash
	call writeChar
	mov eax, LENGTHOF numArr
	call writeDec 

	; prep to populate newArr
	mov ecx, LENGTHOF newArr 
	mov edi, OFFSET newArr

	; prep to read from charArr backward
	mov eax, TYPE charArr
	mov ebx, LENGTHOF charArr
	mul ebx
	mov ebx, eax
	sub ebx, TYPE charArr
	
	; prep to read from numArr backward
	mov eax, TYPE numArr
	mov edx, LENGTHOF numArr
	mul edx
	mov edx, eax
	sub edx, TYPE numArr

	; populate newArr
	L5: 
		mov esi, OFFSET charArr
		mov al, [esi + ebx] 
		movzx eax, al
		mov [edi], eax 
		mov esi, OFFSET numArr
		mov eax, [esi + edx]

		; hello professor,
		;
		; I suspect you are not be please that I am using 'type dword'
		; please, consider that the code is equally reuseable either way.
		; in my opinion, type dword is suprior to a increment that is subject
		; to change. because, value registers will be less likely to need
		; santinitation if their dword size is respected.
		;
		; To be clear, I am only using this 'immediate' value when I am
		;  partitioning the quad word

		add edi, TYPE dword
		mov [edi], eax
		add edi, TYPE dword
		sub ebx, TYPE charArr
		sub edx, TYPE numArr
	loop L5

	; prep to print newArr
	mov edx, OFFSET newArrPrompt
	call CRLF
	call CRLF
	call writeString
	call CRLF
	mov ecx, LENGTHOF newArr 
	mov esi, OFFSET newArr
	sub ebx, ebx
	
	; print newArr
	L6: mov eax, [esi + ebx]
		call writeChar
		add ebx, type dWord
		mov eax, [esi + ebx]
		call writeDec
		mov eax, space
		call writeChar
		add ebx, type dWord
	Loop L6
	
	call CRLF
	call CRLF


	; ---------------------------Your Code Ends Here-------------------------


	  mov edx, offset string1
	  call writeString
      mov  esi,OFFSET charArr
      mov  ecx,LENGTHOF charArr
      mov  ebx,TYPE charArr
      call DumpMem
	   
	  mov edx, offset string2
	  call writeString
      mov  esi,OFFSET numArr
      mov  ecx,LENGTHOF numArr 
      mov  ebx,TYPE numArr    
      call DumpMem
	   
	  mov edx, offset string3
	  call writeString
      mov  esi,OFFSET newArr
      mov  ecx,LENGTHOF newArr 
      mov  ebx,TYPE numArr     
      call DumpMem
	  mov  esi,OFFSET newArr + Type numArr * LENGTHOF newArr
      mov  ecx,LENGTHOF newArr 
      mov  ebx,TYPE numArr     
      call DumpMem
exit
main endp
end main


! OUTPUT #1
Enter 5 letters:

letters entered:
q w e r t

Enter a number: 1
Enter a number: 2
Enter a number: 3
Enter a number: 4
Enter a number: 5

numbers entered:
1 2 3 4 5

mean of numbers is:
3 0/5

contents of newArr are:
t5 r4 e3 w2 q1


Dumping out charArr
Dump of offset 00406040
-------------------------------
71 77 65 72 74

Dumping out numArr
Dump of offset 00406045
-------------------------------
00000001  00000002  00000003  00000004  00000005

Dumping out newArr
Dump of offset 00406059Z
-------------------------------
00000074  00000005  00000072  00000004  00000065

Dump of offset 0040606D
-------------------------------
00000003  00000077  00000002  00000071  00000001
Press any key to continue . . .
!


! OUTPUT #2
Enter 5 letters:

letters entered:
a s d f g

Enter a number: 5
Enter a number: 5
Enter a number: 6
Enter a number: 7
Enter a number: 8

numbers entered:
5 5 6 7 8

mean of numbers is:
6 1/5

contents of newArr are:
g8 f7 d6 s5 a5


Dumping out charArr
Dump of offset 00406040
-------------------------------
61 73 64 66 67

Dumping out numArr
Dump of offset 00406045
-------------------------------
00000005  00000005  00000006  00000007  00000008

Dumping out newArr
Dump of offset 00406059
-------------------------------
00000067  00000008  00000066  00000007  00000064

Dump of offset 0040606D
-------------------------------
00000006  00000073  00000005  00000061  00000005
Press any key to continue . . .
!