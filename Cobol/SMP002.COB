       IDENTIFICATION DIVISION.
       PROGRAM-ID.               SMP002.
       AUTHOR.                   VITOR JOSE PAZ RODRIGUES.
      *RA:                       1110481913003 
      ********************************************************
      *               CADASTRO DE DOENCAS                    *
      *            DATA CRIACAO : 04/10/2020                 *
      ********************************************************
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
                  DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
                    SELECT CADCID ASSIGN TO DISK
                    ORGANIZATION IS INDEXED
                    ACCESS MODE  IS DYNAMIC
                    RECORD KEY   IS CODIGO
                    FILE STATUS  IS ST-ERRO
                    ALTERNATE RECORD KEY IS DENOMINACAO
                                                      WITH DUPLICATES.
      *
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
       FD CADCID
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADCID.DAT".
       01 REGCID.
           03 CODIGO               PIC 9(04).
           03 DENOMINACAO          PIC X(30).
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
       01 TXSEXO                 PIC X(12) VALUE SPACES.
       01 TXESPEC                PIC X(20) VALUE SPACES.
       01 MENSAGEM.
            03 MENSAGEM1         PIC X(30) VALUE SPACES.
            03 COD-MENS          PIC 9(02) VALUE ZEROS.
      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT002.
           05  BLANK SCREEN.
           05  LINE 03  COLUMN 01 
               VALUE  "                         *** CADASTRO DE".
           05  LINE 03  COLUMN 41 
               VALUE  " DOENCAS(CID) ***".

           05  LINE 06  COLUMN 01 
               VALUE  "     CODIGO             :".

           05  LINE 08  COLUMN 01 
               VALUE  "     DENOMINACAO            :".

           05  TCODIGO
               LINE 06  COLUMN 24  PIC X(04)
               USING  CODIGO
               HIGHLIGHT.

           05  TDENOMINACAO
               LINE 08  COLUMN 24  PIC X(30)
               USING  DENOMINACAO
               HIGHLIGHT.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.
      *------------[ ROTINA DE ABERTURA ARQUIVO ]------------------
       ABRIR-ARQ.
           OPEN I-O CADCID
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   OPEN OUTPUT CADCID
                   CLOSE CADCID
                   GO TO ABRIR-ARQ
               ELSE
                   MOVE "ERRO NA ABERTURA ARQUIVO = " TO MENSAGEM1 
                   MOVE ST-ERRO TO COD-MENS
                   MOVE MENSAGEM  TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO ROT-FIM.
      *--------------------[ INICIALIAR VARIAVEIS ]-----------------
       ROT-INIC.
           MOVE 0 TO CODIGO.
           MOVE SPACES TO DENOMINACAO.
      *--------------------[ VISUALIZAR TELA INICIAL ]-----------------
       PASSO-0.
           DISPLAY SMT002.
      *--------------------[ DIGITAR CAMPO CHAVE  ]-----------------
       PASSO-1.
           ACCEPT TCODIGO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   CLOSE CADCID
                   GO TO ROT-FIM.
           IF CODIGO = ZEROS
                MOVE "NUMERO DE CODIGO INVALIDO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-1.
      *--------------------[ LER CAMPO  CHAVE  ]-----------------
       LER-ARQ. 
           READ CADCID
           IF ST-ERRO NOT = "23"
               IF ST-ERRO = "00"
                   DISPLAY SMT002
                   MOVE "*** DOENCA JA CADASTRADA ***"     TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   MOVE "I" TO W-SEL
                   GO TO ACE-001
               ELSE
                   MOVE "ERRO NA LEITURA ARQUIVO CADCID"   TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO ROT-FIM
           ELSE
               MOVE "*** DOENCA NAO ESTA CADASTRADO ***"   TO W-MSG 
               PERFORM ROT-MENS THRU ROT-MENS2.
       PASSO-2.
           ACCEPT TDENOMINACAO.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-1.
           IF DENOMINACAO = SPACES
                MOVE "DENOMINACAO NAO PODE FICAR EM BRANCO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-2.
       
       VALID-OPCAO.
           MOVE "S" TO W-OPCAO
           DISPLAY (23, 40) "GRAVAR (S/N) : ".
           ACCEPT (23, 57) W-OPCAO WITH UPDATE
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02 GO TO PASSO-2.
           IF W-OPCAO = "N" OR "n"
              MOVE "*** REGISTRO RECUSADO PELO USUARIO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND W-OPCAO NOT = "s"
              MOVE "*** DIGITE APENAS S=SIM e N=NAO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO VALID-OPCAO.
       GRAVAR-REGISTRO.
           WRITE REGCID
           IF ST-ERRO = "00" OR "02"
               MOVE "** DADOS GRAVADOS COM SUCESSO **" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-INIC.
           IF ST-ERRO = "22"
               MOVE "*** NOTA JA EXISTENTE ***       " TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-INIC
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO CADCID" TO W-MSG
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
           DELETE CADCID RECORD
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
           IF W-ACT = 02 GO TO PASSO-2.
           IF W-OPCAO = "N" OR "n"
              MOVE "* INFORMACOES NAO ALTERADAS * " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "* DIGITE APENAS S=SIM  e  N=NAO *" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ALT-OPC.
       ALT-RW1.
           REWRITE REGCID
           IF ST-ERRO = "00" OR "02"
              MOVE "*** REGISTRO ALTERADO ***         " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           MOVE "ERRO NA EXCLUSAO DO REGISTRO CADCID" TO W-MSG
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