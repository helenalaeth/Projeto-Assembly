TITLE PROJETO
.MODEL SMALL
.STACK 100H
.DATA
    MSG1   DB 10,13,'Digite um nome E DEPOIS DIGITE ENTER: $'
    MSG2   DB 10,13,'Digite a nota: $'
    DADOS  DB 7 DUP (?),?,?,?,?
           DB 7 DUP (?),?,?,?,?
           DB 7 DUP (?),?,?,?,?
           DB 7 DUP (?),?,?,?,?
           DB 7 DUP (?),?,?,?,?,'$'
.CODE

main PROC

MOV AX, @DATA
MOV DS, AX
XOR SI,SI
xor bx,bx
MOV CX,5
LEITURA_NOMES:
CALL LE_NOME
ADD SI,11
LOOP LEITURA_NOMES

MOV AH,09
LEA DX,DADOS
INT 21H


MOV AH, 4CH
INT 21H


main ENDP 


LE_NOME PROC                       ;PROCEDIMENTO QUE GUARDA 7 CARACTERES (NOMES) NAS 7 PRIMEIRAS POSIÇÕES DE UMA LINHA DA MATRIZ

PUSH AX
PUSH BX
PUSH CX
PUSH DX

MOV CX,7
XOR BX,BX
MOV AH,09
LEA DX, MSG1
INT 21H
MOV AH,01
               GRAVA_NOME:

                                   INT 21H
                                   CMP AL,0Dh
                                   JE TERMINOU_NOME
                                   
                                   MOV DADOS[SI][BX],AL                                         
                                   INC BX
                                   LOOP GRAVA_NOME
                                   mov dl,10
                                   mov ah,02
                                   int 21h
              TERMINOU_NOME:
              POP DX
              POP CX
              POP BX
              POP AX

 RET
LE_NOME ENDP









END MAIN


                     











IMPRIMIR PROC

XOR SI,SI
MOV CH,4

LACO_FORA:
MOV AH, 2 
MOV CL, 4
XOR BX, BX

LACO_DENTRO:
MOV DL, NOMES[SI+BX]
ADD DL, 30H
INT 21H

MOV DL,20H
INT 21H

INC BX
DEC CL

JNZ LACO_DENTRO
CALL PULA_LINHA

ADD SI, 4
DEC CH

JNZ LACO_FORA

RET

IMPRIME ENDP