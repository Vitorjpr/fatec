       IDENTIFICATION DIVISION.
       PROGRAM-ID.               SMP003.
       AUTHOR.                   VITOR JOSE PAZ RODRIGUES.
      *RA:                       1110481913003 
      ********************************************************
      *               CADASTRO DE CONVENIOS                  *
      *            DATA CRIACAO : 04/10/2020                 *
      ********************************************************
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
                  DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
                    SELECT CADCONV ASSIGN TO DISK
                    ORGANIZATION IS INDEXED
                    ACCESS MODE  IS DYNAMIC
                    RECORD KEY   IS CV-CODIGO
                    FILE STATUS  IS ST-ERRO
                    ALTERNATE RECORD KEY IS CV-NOME
                                                      WITH DUPLICATES.
      *
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
       FD CADCONV
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADCONV.DAT".
       01 REGCONV.
           03 CV-CODIGO               PIC 9(04).
           03 CV-NOME                 PIC X(30).
           03 CV-PLANO                PIC 9(02).
      *
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 COUNTER                PIC 9(06) VALUE ZEROS.
       01 W-MSG                  PIC X(50) VALUE SPACES.
       01 W-LIMPA                PIC X(50) VALUE SPACES.
       01 W-SEL                  PIC X(01) VALUE SPACES.
       01 W-OPCAO                PIC X(01) VALUE SPACES.
       01 ST-ERRO                PIC X(02) VALUE "00".
       01 W-ACT                  PIC 9(02) VALUE ZEROS.
       01 TXPLANO                PIC X(30) VALUE SPACES.
       01 MENSAGEM.
            03 MENSAGEM1         PIC X(30) VALUE SPACES.
            03 COD-MENS          PIC 9(02) VALUE ZEROS.
      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT003.
           05  BLANK SCREEN.
           05  LINE 03  COLUMN 01 
               VALUE  "                         *** CADASTRO DE".
           05  LINE 03  COLUMN 41 
               VALUE  " CONVENIOS ***".

           05  LINE 06  COLUMN 01 
               VALUE  "     CODIGO          :".

           05  LINE 08  COLUMN 01 
               VALUE  "     NOME            :".

           05  LINE 10  COLUMN 01 
               VALUE  "     PLANO           :".

           05  TCODIGO
               LINE 06  COLUMN 24  PIC 9(04)
               USING  CV-CODIGO
               HIGHLIGHT.

           05  TNOME
               LINE 08  COLUMN 24  PIC X(30)
               USING  CV-NOME
               HIGHLIGHT.

           05  TPLANO
               LINE 10  COLUMN 24  PIC 99
               USING  CV-PLANO
               HIGHLIGHT.
           
           05  TTXPLANO
               LINE 10  COLUMN 27  PIC X(30)
               USING  TXPLANO
               HIGHLIGHT.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.
      *------------[ ROTINA DE ABERTURA ARQUIVO ]------------------
       ABRIR-ARQ.
           OPEN I-O CADCONV
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   OPEN OUTPUT CADCONV
                   CLOSE CADCONV
                   GO TO ABRIR-ARQ
               ELSE
                   MOVE "ERRO NA ABERTURA ARQUIVO = " TO MENSAGEM1 
                   MOVE ST-ERRO TO COD-MENS
                   MOVE MENSAGEM  TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO ROT-FIM.
      *--------------------[ INICIALIAR VARIAVEIS ]-----------------
       ROT-INIC.
           MOVE 0 TO CV-CODIGO CV-PLANO.
           MOVE SPACES TO CV-NOME.
      *--------------------[ VISUALIZAR TELA INICIAL ]-----------------
       PASSO-0.
           DISPLAY SMT003.
      *--------------------[ DIGITAR CAMPO CHAVE  ]-----------------
       PASSO-1.
           ACCEPT TCODIGO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   CLOSE CADCONV
                   GO TO ROT-FIM.
           IF CV-CODIGO = ZEROS
                MOVE "NUMERO DE CV-CODIGO INVALIDO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-1.
      *--------------------[ LER CAMPO  CHAVE  ]-----------------
       LER-ARQ. 
           READ CADCONV
           IF ST-ERRO NOT = "23"
               IF ST-ERRO = "00"
                   DISPLAY SMT003
                   MOVE "*** CONVENIO JA CADASTRADO ***"     TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   MOVE "I" TO W-SEL
                   GO TO ACE-001
               ELSE
                   MOVE "ERRO NA LEITURA ARQUIVO CADCONV"    TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO ROT-FIM
           ELSE
               MOVE "*** CONVENIO NAO ESTA CADASTRADO ***"   TO W-MSG 
               PERFORM ROT-MENS THRU ROT-MENS2.
       PASSO-2.
           ACCEPT TNOME.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-1.
           IF CV-NOME = SPACES
                MOVE "CV-NOME NAO PODE FICAR EM BRANCO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-2.
       
       PASSO-3.
           ACCEPT TPLANO.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-2.
           IF CV-PLANO = ZEROS
                MOVE "CONVENIO NAO PODE FICAR EM BRANCO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-3.

       PASSO-3-A.
           IF CV-PLANO = 01
             MOVE " ENFERMARIA REGINAL" TO TXPLANO
           ELSE
             IF CV-PLANO = 02
               MOVE " ENFERMARIA NACIONAL" TO TXPLANO
             ELSE
               IF CV-PLANO = 03
                 MOVE " ENFERMARIA INTERNACIONAL" TO TXPLANO
               ELSE
                 IF CV-PLANO = 04
                   MOVE " APTO PADRAO REGINAL" TO TXPLANO
                 ELSE
                   IF CV-PLANO = 05
                     MOVE " APTO PADRAO NACIONAL" TO TXPLANO
                   ELSE
                     IF CV-PLANO = 06
                       MOVE " APTO PADRAO INTERNACIONAL" TO TXPLANO
                     ELSE
                       IF CV-PLANO = 07
                         MOVE " EMERGENCIA REGIONAL" TO TXPLANO
                       ELSE
                         IF CV-PLANO = 08
                           MOVE " EMERGENCIA NACIONAL" TO TXPLANO
                         ELSE
                           IF CV-PLANO = 09
                             MOVE " EMERGENCIA INTERNACIONAL" TO TXPLANO
                           ELSE
                             IF CV-PLANO = 10
                               MOVE " CV-PLANO GLOBAL" TO TXPLANO
                             ELSE
                               MOVE "ESPECIALIDADE NAO EXISTE" TO W-MSG
                               PERFORM ROT-MENS THRU ROT-MENS2
                               GO TO PASSO-3.
           DISPLAY TXPLANO.
       
       VALID-OPCAO.
           MOVE "S" TO W-OPCAO
           DISPLAY (23, 40) "GRAVAR (S/N) : ".
           ACCEPT (23, 57) W-OPCAO WITH UPDATE
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02 GO TO PASSO-3.
           IF W-OPCAO = "N" OR W-OPCAO = "n"
              MOVE "*** REGISTRO RECUSADO PELO USUARIO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "*** DIGITE APENAS S=SIM e N=NAO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO VALID-OPCAO.
       GRAVAR-REGISTRO.
           WRITE REGCONV
           IF ST-ERRO = "00" OR "02"
               MOVE "** DADOS GRAVADOS COM SUCESSO **" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-INIC.
           IF ST-ERRO = "22"
               MOVE "*** NOTA JA EXISTENTE ***       " TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-INIC
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO CADCONV" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-FIM.
      *--------------------[ FIM DA ROTINA DE INCLUSAO ]--------------------
      *
      *****************************************
      * ROTINA DE CONSULTA/ALTERACAO/EXCLUSAO *
      *****************************************
      *
       ACE-001.
           DISPLAY (23, 13)
                "N=NOVO REGISTRO   A=ALTERAR   E=EXCLUIR"
           ACCEPT (23, 55) W-OPCAO
           IF W-OPCAO NOT = "N" AND W-OPCAO NOT = "A" 
                              AND W-OPCAO NOT = "E" GO TO ACE-001.
           MOVE SPACES TO W-MSG
           DISPLAY (23, 12) W-MSG
           IF W-OPCAO = "A"
                  MOVE "A" TO W-SEL
                  GO TO PASSO-2.
           IF W-OPCAO  = "N"
                    GO TO ROT-INIC.
      *
       EXC-OPC.
           DISPLAY (23, 40) "EXCLUIR   (S/N) : ".
           ACCEPT (23, 57) W-OPCAO
           IF W-OPCAO = "N" OR "n"
              MOVE "*** REGISTRO NAO EXCLUIDO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "* DIGITE APENAS S=SIM  e  N=NAO *" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO EXC-OPC.
       EXC-DL1.
           DELETE CADCONV RECORD
           IF ST-ERRO = "00"
              MOVE "*** REGISTRO EXCLUIDO ***           " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           MOVE "ERRO NA EXCLUSAO DO REGISTRO " TO W-MSG
           PERFORM ROT-MENS THRU ROT-MENS-FIM
           GO TO ROT-FIM.
      *
       ALT-OPC.
           DISPLAY (23, 40) "ALTERAR  (S/N) : ".
           ACCEPT (23, 57) W-OPCAO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02 GO TO PASSO-3.
           IF W-OPCAO = "N" OR "n"
              MOVE "* INFORMACOES NAO ALTERADAS * " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "* DIGITE APENAS S=SIM  e  N=NAO *" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ALT-OPC.
       ALT-RW1.
           REWRITE REGCONV
           IF ST-ERRO = "00" OR "02"
              MOVE "*** REGISTRO ALTERADO ***         " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           MOVE "ERRO NA EXCLUSAO DO REGISTRO CADCONV" TO W-MSG
           PERFORM ROT-MENS THRU ROT-MENS-FIM
           GO TO ROT-FIM.
      *--------------------[ ROTINA DE MENSAGEM ]--------------------
       ROT-MENS.
           MOVE ZEROS TO COUNTER.
       ROT-MENS1.
           DISPLAY (23, 12) W-MSG.
       ROT-MENS2.
           ADD 1 TO COUNTER
           IF COUNTER < 1500
              GO TO ROT-MENS2
           ELSE
              MOVE SPACES TO W-MSG
              DISPLAY (23, 12) W-MSG.
       ROT-MENS-FIM.
           EXIT.

       ROT-FIM.
           DISPLAY (01, 01) ERASE
           EXIT PROGRAM.
       ROT-FIMP.
           EXIT PROGRAM.
       ROT-FIMS.
           STOP RUN.