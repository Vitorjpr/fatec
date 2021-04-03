       IDENTIFICATION DIVISION.
       PROGRAM-ID. SMP005.
       AUTHOR. VITOR JOSÉ PAZ RODRIGUES.
      ********************************************************
      *                  CADASTRO DE CEP                     *
      *             DATA CRIACAO : 22/09/2020                *
      ********************************************************
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
                  DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
                    SELECT CADCEP ASSIGN TO DISK
                    ORGANIZATION IS INDEXED
                    ACCESS MODE  IS DYNAMIC
                    RECORD KEY   IS CODIGO
                    FILE STATUS  IS ST-ERRO
                    ALTERNATE RECORD KEY IS ENDERECO
                                                      WITH DUPLICATES.
      *
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
       FD CADCEP
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADCEP.DAT".
       01 REGCEP.
            03 CODIGO            PIC 9(08).
            03 ENDERECO          PIC X(30).
            03 BAIRRO            PIC X(20).
            03 CIDADE            PIC X(20).
            03 ESTADO            PIC X(02).
      *
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 W-CONT         PIC 9(06) VALUE ZEROS.
       01 W-MENS         PIC X(50) VALUE SPACES.
       01 W-LIMPA        PIC X(50) VALUE SPACES.
       01 W-SEL          PIC X(01) VALUE SPACES.
       01 W-OPCAO        PIC X(01) VALUE SPACES.
       01 ST-ERRO        PIC X(02) VALUE "00".
       01 W-ACT          PIC 9(02) VALUE ZEROS.
       01 MENSAGEM.
            03 MENSAGEM1     PIC X(30) VALUE SPACES.
            03 COD-MENS      PIC 9(02) VALUE ZEROS.
      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT005.
           05  BLANK SCREEN.
           05  LINE 03  COLUMN 01 
               VALUE  "                         *** CADASTRO DE".
           05  LINE 03  COLUMN 41 
               VALUE  " CEP ***".
           05  LINE 06  COLUMN 01 
               VALUE  "     CODIGO             :".
           05  LINE 08  COLUMN 01 
               VALUE  "     ENDERECO           :".
           05  LINE 10  COLUMN 01 
               VALUE  "     BAIRRO             :".
           05  LINE 12  COLUMN 01 
               VALUE  "     CIDADE             :".
           05  LINE 14  COLUMN 01 
               VALUE  "     ESTADO             :".
           05  LINE 23  COLUMN 01 
               VALUE  " MENSAGEM :".

           05  TCODIGO
               LINE 06  COLUMN 24  PIC 99999.999
               USING  CODIGO
               HIGHLIGHT.

           05  TENDERECO
               LINE 08  COLUMN 24  PIC X(30)
               USING  ENDERECO
               HIGHLIGHT.

           05  TBAIRRO
               LINE 10  COLUMN 24  PIC X(20)
               USING  BAIRRO
               HIGHLIGHT.

           05  TCIDADE
               LINE 12  COLUMN 24  PIC X(20)
               USING  CIDADE
               HIGHLIGHT.

           05  TESTADO
               LINE 14  COLUMN 24  PIC X(02)
               USING  ESTADO
               HIGHLIGHT.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.
      *------------[ ROTINA DE ABERTURA ARQUIVO ]------------------
       ABRIR-ARQ.
           OPEN I-O CADCEP
           IF ST-ERRO NOT = "00"
              IF ST-ERRO = "30"
                 OPEN OUTPUT CADCEP
                 CLOSE CADCEP
                 GO TO ABRIR-ARQ
              ELSE
                 MOVE "ERRO NA ABERTURA ARQUIVO = " TO MENSAGEM1 
                 MOVE ST-ERRO                       TO COD-MENS
                 MOVE MENSAGEM                      TO W-MENS
                 PERFORM ROT-MENS THRU ROT-MENS2
                 GO TO ROT-FIM.
      *--------------------[ INICIALIAR VARIAVEIS ]-----------------
       COMECO.
           MOVE 0 TO CODIGO.
           MOVE SPACES TO ENDERECO ESTADO CIDADE BAIRRO.
      *--------------------[ VISUALIZAR TELA INICIAL ]-----------------
       PASSO-0.
           DISPLAY SMT005.
      *--------------------[ DIGITAR CAMPO CHAVE  ]-----------------
       PASSO-1.
           ACCEPT TCODIGO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   CLOSE CADCEP
                   GO TO ROT-FIM.
           IF CODIGO = ZEROS
                MOVE "CODIGO NAO PODE SER ZERO" TO W-MENS
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-1.
      *--------------------[ LER CAMPO CHAVE  ]-----------------
       LER-ARQ.
           READ CADCEP
           IF ST-ERRO NOT = "23"
              IF ST-ERRO = "00"
                 DISPLAY SMT005
                 MOVE "*** CODIGO JA CADASTRAD0 ***" TO W-MENS
                 PERFORM ROT-MENS THRU ROT-MENS2
                 MOVE "I" TO W-SEL
                 GO TO ACE-001
              ELSE
                MOVE "ERRO NA LEITURA ARQ CADCEP"   TO W-MENS
                 PERFORM ROT-MENS THRU ROT-MENS2
                 GO TO ROT-FIM
           ELSE
                 MOVE "*** CODIGO NAO ESTA CADASTRAD0 ***" 
                                                     TO W-MENS
                 PERFORM ROT-MENS THRU ROT-MENS2.
       PASSO-2.
           ACCEPT TENDERECO.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-1.
           IF ENDERECO = SPACES
                MOVE "ENDERECO NAO PODE FICAR EM BRANCO" TO W-MENS
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-2.
       PASSO-3.
           ACCEPT TBAIRRO.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-2.
           IF BAIRRO = SPACES
                MOVE "BAIRRO NAO PODE FICAR EM BRANCO" TO W-MENS
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-3.
       PASSO-4.
           ACCEPT TCIDADE
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-3.
           IF CIDADE = SPACES
              MOVE "CIDADE NAO PODE FICAR EM BRANCO" TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS2
              GO TO PASSO-4.
       PASSO-5.
           ACCEPT TESTADO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
              GO TO PASSO-4.
           IF ESTADO = SPACES
              MOVE "ESTADO NAO PODE FICAR EM BRANCO" TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS2
              GO TO PASSO-5.
           IF ESTADO = "PE"
              DISPLAY (14, 27) "PERNAMBUCO".   
           IF ESTADO = "DF"
              DISPLAY (14, 27) "DISTRITO FEDERAL".
           IF ESTADO = "SP"
              DISPLAY (14, 27) "SAO PAULO".   
           IF ESTADO = "BA"
              DISPLAY (14, 27) "BAHIA".
           IF ESTADO = "CE"
              DISPLAY (14, 27) "CEARA".
           IF ESTADO = "PR"
              DISPLAY (14, 27) "PARANA".
           IF ESTADO = "SC"
              DISPLAY (14, 27) "SANTA CATARINA".
           IF ESTADO = "PA"
              DISPLAY (14, 27) "PARA".
       INC-OPC.
           MOVE "S" TO W-OPCAO
           DISPLAY(23, 40) "GRAVAR (S/N) : ".
           ACCEPT (23, 57) W-OPCAO WITH UPDATE
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02 GO TO PASSO-4.
           IF W-OPCAO = "N" OR "n"
              MOVE "*** DADOS RECUSADOS PELO USUARIO ***"    TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO COMECO.
           IF W-OPCAO NOT = "S" AND W-OPCAO NOT = "s"
              MOVE "*** DIGITE APENAS S=SIM e N=NAO ***"     TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO INC-OPC.
       INC-WR1.
           WRITE REGCEP
           IF ST-ERRO = "00" OR ST-ERRO = "02"
              MOVE "** DADOS GRAVADOS COM SUCESSO **"   TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO COMECO.
           IF ST-ERRO = "22"
              MOVE "*** INFORMACAO JA EXISTENTE *** "   TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO COMECO
           ELSE
              MOVE "ERRO NA GRAVACAO DO ARQUIVO DE CEP" TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-FIM.
      *--------------------[ FIM DA ROTINA DE INCLUSAO ]--------------------
      *
      *******************************************************************
      *              ROTINA DE CONSULTA/ALTERACAO/EXCLUSAO              *
      *******************************************************************
      *
       ACE-001.
           DISPLAY (23, 13) "N=NOVO REGISTRO   A=ALTERAR   E=EXCLUIR"
           ACCEPT (23, 55) W-OPCAO
           IF W-OPCAO NOT = "N" AND
              W-OPCAO NOT = "A" AND
              W-OPCAO NOT = "E"
                  GO TO ACE-001.
           MOVE SPACES TO W-MENS
           DISPLAY (23, 12) W-MENS
           IF W-OPCAO = "A"
              MOVE "A" TO W-SEL
              GO TO PASSO-2.
           IF W-OPCAO  = "N"
              GO TO COMECO.
      *
       EXC-OPC.
           DISPLAY (23, 40) "EXCLUIR   (S/N) : ".
           ACCEPT (23, 57) W-OPCAO
           IF W-OPCAO = "N" OR "n"
              MOVE "*** REGISTRO NAO EXCLUIDO ***" TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO COMECO.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "* DIGITE APENAS S=SIM  e  N=NAO *" TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO EXC-OPC.
       EXC-DL1.
           DELETE CADCEP RECORD
           IF ST-ERRO = "00"
              MOVE "*** REGISTRO EXCLUIDO ***"           TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO COMECO.
           MOVE "ERRO NA EXCLUSAO DO REGISTRO "          TO W-MENS
           PERFORM ROT-MENS THRU ROT-MENS-FIM
           GO TO ROT-FIM.
      *
       ALT-OPC.
           DISPLAY (23, 40) "ALTERAR  (S/N) : ".
           ACCEPT (23, 57) W-OPCAO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02 GO TO PASSO-4.
           IF W-OPCAO = "N" OR "n"
              MOVE "* INFORMACOES NAO ALTERADAS * " TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO COMECO.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "* DIGITE APENAS S=SIM  e  N=NAO *" TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ALT-OPC.
       ALT-RW1.
           REWRITE REGCEP
           IF ST-ERRO = "00" OR ST-ERRO = "02"
              MOVE "*** REGISTRO ALTERADO ***         " TO W-MENS
              PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO COMECO.
           MOVE "ERRO NA EXCLUSAO DO REGISTRO CADCEP" TO W-MENS
           PERFORM ROT-MENS THRU ROT-MENS-FIM
           GO TO ROT-FIM.
      *--------------------[ ROTINA DE MENSAGEM ]--------------------
       ROT-MENS.
           MOVE ZEROS TO W-CONT.

       ROT-MENS1.
           DISPLAY (23, 12) W-MENS.

       ROT-MENS2.
           ADD 1 TO W-CONT
           IF W-CONT < 3000
              GO TO ROT-MENS2
           ELSE
              MOVE SPACES TO W-MENS
              DISPLAY (23, 12) W-MENS.

       ROT-MENS-FIM.
           EXIT.

       ROT-FIM.
           DISPLAY (01, 01) ERASE
           EXIT PROGRAM.

       ROT-FIMP.
           EXIT PROGRAM.
                
       ROT-FIMS.
           STOP.