; Program template
TITLE   Assignment 6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
include irvine32.inc

.data
string1 byte "Enter a positive number: ",0
string2 byte "This number is divisible by 2 divisors (other than 1 and n): ", 0
string3 byte "Enter positive number please (other than 0)",0

num dword ?

.code
main proc
	while0:	 mov edx, offset string1
			 call writeString
			 mov esi, offset num
			 call readDec
			 cmp eax, 0				;not accepting 0 or negative number for input
			 JLE while1
			 JG outwhile 
	while1 : mov edx, offset string3
			 call writeString
			 call crlf
			 jmp while0 
	outwhile:mov edx, offset string2
			 call writeString
			 call is2divisors
			 call crlf
exit
main ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Check if the input number each one has 2 divisors and return them
;prints all the numbers x below n that have exactly 2 different integral divisors (Besides 1 and n)
is2divisors PROC
start:
	push eax
	sub eax , 1					; upper limit is one less than the value itself
    mov     edi,    eax         ; edi becomes the upper limit.
	pop eax
    mov     esi,    1           ; esi becomes the control variable.
outerLoop:
    inc     esi					; inc control variable
    mov     ebx,    2           ; ebx becomes the divisor and control variable of the inner loop.
    mov     ecx,    0           ; Counts how many division have been possible.
innerLoop:
    xor     edx,    edx			; set edx to zero
    mov     eax,    esi			; move input number to eax so can be divided
    div     ebx					; divide the input number with current divisor

    cmp     edx,    0			; check if the division is valid
	jne     InnerIteration
    inc     ecx					; inc the counter, how many division has been ran
InnerIteration:
    inc     ebx                  ; Increment the divisor.
    cmp     ebx,    esi          ; the control variable acts as the upper limit.
    jl      innerLoop
OuterIteration:
    cmp     ecx,    2			 ; check if has 2 divisors
    jne     goToNextIteration

    cmp     esi,    0            ; In case no number was given. Just a blank.
    je      goToNextIteration
	
	mov al, ' '					 ;space
	call writeChar				 ;print out space
    mov     eax,    esi
    call    writeDec            ; write out the results 
goToNextIteration:
    cmp     esi,   edi		; compare input with upper limit
    jl      outerLoop		; check the next number
	push    0
	call crlf
    call    [ExitProcess]
ret
is2divisors ENDP
END main





































