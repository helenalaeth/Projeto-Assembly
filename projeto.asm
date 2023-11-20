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
    NOMES      DB  10,13,10,13, 'Digite um nome de ate 7 letras e depois digite ENTER',10,13,10,13,'$'
    N_ALUNO1   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o primeiro aluno: $'
    N_ALUNO2   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o segundo aluno: $'
    N_ALUNO3   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o terceiro aluno: $'
    N_ALUNO4   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o quarto aluno: $'
    N_ALUNO5   DB  10,13, 'Digite a nota da P1, P2 e P3, respectivamente, para o quinto aluno: $'
    SELECT     DB  10,13, 'Selecione uma opçao abaixo:', 10,13, '1-Corrigir o nome de um aluno', 10,13, '2-Corrigir alguma nota', 10,13, '3-Imprimir planilha de notas$'   

                                                              

    DADOS  DB 7 DUP (?),?,?,?,?          ;MATRIZ 11X5 QUE POSSUI 1 NOME DE 7 LETRAS + 3 NOTAS + 1 MÉDIA EM CADA LINHA
           DB 7 DUP (?),?,?,?,?
           DB 7 DUP (?),?,?,?,?
           DB 7 DUP (?),?,?,?,?
           DB 7 DUP (?),?,?,?,?,'$'       


           ;?,?,?,?,?,?,?,?,?,?,? 
           ;?,?,?,?,?,?,?,?,?,?,?
           ;?,?,?,?,?,?,?,?,?,?,?  
           ;?,?,?,?,?,?,?,?,?,?,?  
           ;?,?,?,?,?,?,?,?,?,?,?       
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
ADD SI,11                           ;SI VAI PARA PRÓXIMA LINHA
LOOP LEITURA_NOMES                  ;É NECESSÁRIO QUE SE FAÇA O LE_NOME PROC 5 VEZES PARA LER OS 5 NOMES



;MOV AH,09                           ;APÓS SAIR DO LOOP DE LEITURA DE NOMES
;LEA DX,DADOS                        ;IMPRIMI UMA VEZ PARA VER COMO QUE TAVA
;INT 21H
CALL LE_NOTA




MOV AH, 4CH                          ;FINALIZA O PROGRAMA
INT 21H


main ENDP 


LE_NOME PROC                         ;PROCEDIMENTO QUE GUARDA 7 CARACTERES (NOMES) NAS 7 PRIMEIRAS POSIÇÕES DE UMA LINHA DA MATRIZ

PUSH AX                              ;GUARDA OS REGISTRADORES NA PILHA PARA QUE O PROCEDIMENTO NÃO OS ALTERE
PUSH BX
PUSH CX
PUSH DX

MOV CX,7                            ;CONTADOR PARA LOOP 7 VEZES
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
                         CR

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

LEA DX,N_ALUNO1
MOV AH,09                                                      ;MOSTRA MSG2
INT 21H

XOR SI,SI                                                      ;ÍNDICE DA LINHA É ZERADO
XOR BX,BX                                                      ;ÍNDICE DAS COLUNAS É ZERADO

MOV CX,3
GRAVA_NOTA:
ADD BX,7                                                       ;ÍNDICE APONTA PARA A COLUNA 7 (ELEMENTO DA PRIMEIRA NOTA)
MOV AH,01                                                      ;LÊ CARACTERE 
INT 21H                                                        
MOV DADOS[SI][BX], AL                                          ;MOVE CARACTERE LIDO PARA O ELEMENTO 7 DA COLUNA
INC BX
LOOP GRAVA_NOTA


             POP CX                                             ;RETORNA REGISTRADORES
             POP DX
             POP BX
             POP AX



LE_NOTA ENDP


END MAIN


                     










