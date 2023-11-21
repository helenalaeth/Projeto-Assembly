TITLE PROJETO ;                             / SOPHIA H. A. LEITE  /  ISABELA KATO  /
.MODEL SMALL

CR MACRO
           MOV DL,0Dh                     ;MACRO QUE PRINTA O ENTER
           MOV AH,02
           INT 21H
ENDM

LF MACRO    
           MOV, 0Ah
           MOV AH,02
           INT 21H
ENDM
           
.STACK 100H
.DATA
    NOMES      DB  10,13,10,13, 'Digite um nome de ate 15 letras e depois digite ENTER',10,13,10,13,'$'

    N_ALUNO1   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o primeiro aluno:',10,13,'*(2 digitos!)/*(SPACE apos cada nota): $'
    N_ALUNO2   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o segundo aluno',10,13, '*(2 digitos!)/*(SPACE apos cada nota): $'
    N_ALUNO3   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o terceiro aluno',10,13, '*(2 digitos!)/*(SPACE apos cada nota): $'
    N_ALUNO4   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o quarto aluno ',10,13, '*(2 digitos!)/*(SPACE após cada nota): $'
    N_ALUNO5   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o quinto aluno ',10,13, '*(2 digitos!)/*(SPACE após cada nota): $'
    SELECT     DB  10,13, 'Selecione uma opçao abaixo:', 10,13, '1-Corrigir o nome de um aluno', 10,13, '2-Corrigir alguma nota', 10,13, '3-Imprimir planilha de notas$'   

    ARRAY DB 'NOME', 10 DUP (?), 'P1',?,'P2',?,'P3',?, 'MF$'    ;ARRAY PARA IMPRIMIR ANTES DA MATRIZ                                                       

    DADOS  DB 15 DUP (?),?,?,?,?,?,?,?,?,?,?,?         ;MATRIZ 26X5=> 1 LINHA= 1 NOME DE 7 LETRAS, 3 NOTAS DE 2 DÍG CADA, 1 MF DE 2 DÍG
           DB 15 DUP (?),?,?,?,?,?,?,?,?,?,?,?
           DB 15 DUP (?),?,?,?,?,?,?,?,?,?,?,?
           DB 15 DUP (?),?,?,?,?,?,?,?,?,?,?,?
           DB 15 DUP (?),?,?,?,?,?,?,?,?,?,?,?,'$'       

           ;NOME                          e  P1 e  P2 e  P3 e  MF      
           ;?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?
           ;?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?
           ;?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? 
           ;?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?  
           ;?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?       
.CODE

main PROC

MOV AX,3                            ;AO EXECUTAR O PROGRAMA, NÃO MOSTRARÁ INFORMAÇÕES
INT 10H

MOV AX, @DATA
MOV DS, AX

XOR SI,SI                           ;ZERA OS ÍNDICES
XOR BX,BX


MOV CX,5                            ;CONTADOR PARA O LOOP LEITURA_NOMES 5 VEZES

LEITURA_NOMES:                      
CALL LE_NOME                        ;COMEÇA PROCEDIMENTO PARA LEITURA DOS NOMES
ADD SI,28                           ;SI VAI PARA PRÓXIMA LINHA PARA REGISTRAR O PROXIMO NOME
LOOP LEITURA_NOMES                  ;É NECESSÁRIO QUE SE FAÇA O LE_NOME PROC 5 VEZES PARA LER OS 5 NOMES



                                    ;***APÓS SAIR DO LOOP DE LEITURA DE NOMES***

XOR SI,SI
LEA DX,N_ALUNO1
MOV AH,09                           ;PEDE PARA DIGITAR AS NOTAS DO ALUNO 1
INT 21H

CALL LE_NOTA

;*****PRECISA COLOCAR PARA ELE IR PARA A SEGUNDA LINHA DA MATRIZ
XOR SI,SI
XOR BX,BX
ADD SI,27                           ;SI VAI PARA PRÓXIMA LINHA (POIS É O SEGUNDO ALUNO)


LEA DX,N_ALUNO2
MOV AH,09                           ;PEDE PARA DIGITAR AS NOTAS DO ALUNO 2
INT 21H

CALL LE_NOTA

LEA DX,N_ALUNO3
MOV AH,09                           ;PEDE PARA DIGITAR AS NOTAS DO ALUNO 1
INT 21H

CALL LE_NOTA

LEA DX,N_ALUNO4
MOV AH,09
INT 21H

CALL LE_NOTA

LEA DX,N_ALUNO5
MOV AH,09
INT 21H

CALL LE_NOTA                        ;ÚLTIMA LEITURA DE NOTAS
;.;.;.;.;.;.;.;.;. CONTINUAÇÃO...

MOV AH, 4CH                          ;FINALIZA O PROGRAMA
INT 21H


main ENDP 


LE_NOME PROC                         ;PROCEDIMENTO QUE GUARDA 7 CARACTERES (NOMES) NAS 7 PRIMEIRAS POSIÇÕES DE UMA LINHA DA MATRIZ

PUSH AX                              ;GUARDA OS REGISTRADORES NA PILHA PARA QUE O PROCEDIMENTO NÃO OS ALTERE
PUSH BX
PUSH CX
PUSH DX

MOV CX,15                            ;CONTADOR PARA LOOP 15 VEZES PARA 15 CARACTERES
XOR BX,BX                           ;ZERA O ÍNDICE QUE SERÁ USADO PARA PERCORRER AS COLUNAS DA MATRIZ DADOS
MOV AH,09
LEA DX, NOMES                        ;PRINT MSG1
INT 21H
MOV AH,01                           
               GRAVA_NOME:

                         INT 21H                              ;LÊ UM CARACTERE
                         CMP AL,0Dh                           ;COMPARA ENTRADA COM ENTER
                         JE TERMINOU_NOME                     ;SE FOR, PULA PARA LABEL TERMINOU_NOME
                         
                         MOV DADOS[SI][BX],AL                 ;MOVE CARACTERE DIGITADO PARA A PRIMEIRA POSIÇÃO DA MATRIZ                      
                         INC BX                               ;INCREMENTA O ÍNDICE DAS COLUNAS
                         LOOP GRAVA_NOME                      ;FAZ ISSO 7 VEZES (A QUANTIDADE MÁX PARA O NOME)
                         CR                                   ;PULA UMA LINHA
                         

         TERMINOU_NOME:                                       ;RETORNA OS REGISTRADORES
         POP DX
         POP CX
         POP BX
         POP AX

 RET                                                           ;VOLTA PARA O PROCEDIMENTO PRINCIPAL
LE_NOME ENDP


LE_NOTA PROC

                PUSH AX                                        ;SALVA REGISTRADORES
                PUSH BX
                PUSH DX
                PUSH CX



;XOR SI,SI                                                      ;ÍNDICE DA LINHA É ZERADO
XOR BX,BX                                                      ;ÍNDICE DAS COLUNAS É ZERADO

MOV CX,2                                                       ;VAI FAZER ESSE LOOP 1 VEZ

ADD BX,17                                                      ;BX APONTA PARA A COLUNA 17 (ELEMENTO DA PRIMEIRA NOTA)
MOV AH,01


NOTA_P1:
                                                               ;LÊ CARACTERE 
INT 21H                                                        
CMP AL,20h                                                     ;SE É O ESPAÇO, NÃO GUARDA
JE EH_ESPACO1
MOV DADOS[SI][BX], AL                                          ;MOVE CARACTERE LIDO PARA O ELEMENTO 17 DA COLUNA
INC BX                                                         ;BX NO PROXIMO ELEMENTO
LOOP NOTA_P1

EH_ESPACO1:
XOR CX,CX
MOV CX,2
INC BX                                                        ;BX ACESSA PRIMEIRO ELEMENTO (CARACTERE) DA P2
NOTA_P2:
INT 21H
CMP AL,20h
JE EH_ESPACO2
MOV DADOS[SI][BX],AL
INC BX
LOOP NOTA_P2

EH_ESPACO2:                                                      
XOR CX,CX
MOV CX,2
INC BX                                                         ;BX ACESSA PRIMEIRO ELEMENTO (CARACTERE) DA P3
NOTA_P3:
INT 21H
CMP AL,20h
JE EH_ESPACO3
MOV DADOS[SI][BX],AL
INC BX
LOOP NOTA_P3

EH_ESPACO3:
XOR CX,CX
MOV CX,2
INC BX                                                         ;BX ACESSA PRIMEIRO ELEMENTO (CARACTERE) DA MEDIA
MEDIA:

                                                                     


             POP CX                                             ;RETORNA REGISTRADORES
             POP DX
             POP BX
             POP AX



LE_NOTA ENDP


MOV AH,09 
LEA DX,DADOS
INT 21H
END MAIN


                     










