       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONSMED.
       AUTHOR. VITOR JOSE PAZ RODRIGUES
      *******************************
      *     CONSULTA DE MEDICOS     *
      *******************************
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
                    DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *
       SELECT CADMED ASSIGN TO DISK
                    ORGANIZATION IS INDEXED
                    ACCESS MODE  IS DYNAMIC
                    RECORD KEY   IS CRM
                    FILE STATUS  IS ST-ERRO
                    ALTERNATE RECORD KEY IS NOME
                                   WITH DUPLICATES.
      *
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
      *
       FD CADMED
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADMED.DAT".
       01 REGMED.
           03 CRM               PIC 9(06).
           03 NOME              PIC X(30).
           03 ESPEC             PIC 9(02).
           03 SEXO              PIC X(01).
           03 DATANASC.
               05 DIA           PIC 99.
               05 MES           PIC 99.
               05 ANO           PIC 9(04).
           03 EMAIL             PIC X(30).
           03 TELEFONE          PIC 9(11).
      *
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 W-SEL        PIC 9(01) VALUE ZEROS.
       01 W-CONT       PIC 9(04) VALUE ZEROS.
       01 W-OPCAO      PIC X(01) VALUE SPACES.
       01 ST-ERRO      PIC X(02) VALUE "00".
       01 W-ACT        PIC 9(02) VALUE ZEROS.
       01 MENS         PIC X(50) VALUE SPACES.
       01 LIMPA        PIC X(55) VALUE SPACES.
       01 SOLIC        PIC X(20) VALUE SPACES.
       01 CONLIN       PIC 9(03) VALUE 001.
       01 CRMENTR      PIC 9(09) VALUE ZEROS.
       01 NOMEENTR     PIC X(35) VALUE SPACES.
      *-----------------------------------------------------------------
      *
      ******************
      * REPORT SECTION *
      ******************
      *
       01 DET2.
          03 FILLER    PIC X(02) VALUE SPACES.
          03 DETCRM    PIC 999999.
          03 FILLER    PIC X(02) VALUE SPACES.
          03 DETNOME   PIC X(30) VALUE SPACES.
          03 FILLER    PIC X(05) VALUE SPACES.
          03 DETESPEC  PIC X(02) VALUE SPACES.
          03 FILLER    PIC X(14) VALUE SPACES.
          03 DETTEL    PIC 9(11) VALUE SPACES.
      *
      ******************
      * ROTINA DE TELA *
      ******************
      *
       SCREEN SECTION.

       01  TELAMED.
           05  BLANK SCREEN.
           05  LINE 02  COLUMN 01 
               VALUE  " FATEC ZONA LESTE         ***   CONSULTA".
           05  LINE 02  COLUMN 41 
               VALUE  " DE CRM  ***".
           05  LINE 04  COLUMN 01 
               VALUE  "     CRM              NOME".
           05  LINE 04  COLUMN 41 
               VALUE  "ESPECIALIZACAO       TELEFONE".
           05  LINE 23  COLUMN 01 
               VALUE  "  MENSAGEM :".
           05  TCRMENTR
               LINE 06  COLUMN 02  PIC 999999
               USING  CRMENTR.
           05  TNOMEENTR
               LINE 06  COLUMN 13  PIC X(30)
               USING  NOMEENTR.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.
      *
       INC-OP1.
           OPEN INPUT  CADMED
           IF ST-ERRO NOT = "00"
              IF ST-ERRO = "30"
                 MOVE "ARQUIVO DE CADMED NAO EXISTE" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM2
              ELSE
                 MOVE "ERRO ABERTURA DO ARQUIVO CADMED"  TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM2
           ELSE
               NEXT SENTENCE.
      *
       INC-001.
           MOVE ZEROS TO CRMENTR
           MOVE SPACES TO NOMEENTR
           DISPLAY  TELAMED.
       INC-001A.
           DISPLAY (23, 13)
            "SOLIC.=> F1=ENCERRA CONSULTA   F2=CONSULTA P/NOME."
           ACCEPT TCRMENTR
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02
                      CLOSE CADMED
                      GO TO ROT-FIM.
           IF W-ACT = 03
                      GO TO INC-001B.
           IF W-ACT > 03
                      MOVE "*** FUNCAO NAO DEFINIDA ***" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO INC-001A.
           MOVE CRMENTR TO CRM
           START CADMED KEY IS NOT LESS CRM INVALID KEY
                 MOVE "*** FIM DE PROCESSAMENTO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-001.
           GO TO INC-RD2.
       INC-001B.
           DISPLAY (23, 13)
            "SOLIC.=> F1=ENCERRA CONSULTA     F2=CONSULTA P/ CRM "
           ACCEPT TNOMEENTR
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02
                      CLOSE CADMED
                      GO TO ROT-FIM.
           IF W-ACT = 03
                      GO TO INC-001A.
           IF W-ACT > 03
                      MOVE "*** FUNCAO NAO DEFINIDA ***" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO INC-001A.
           MOVE NOMEENTR TO NOME
           START CADMED KEY IS NOT LESS NOME INVALID KEY
                 MOVE "*** FIM DE PROCESSAMENTO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-001B.
       INC-RD2.
           DISPLAY (23, 13) LIMPA
           READ CADMED NEXT
           IF ST-ERRO NOT = "00"
              IF ST-ERRO = "10"
                 MOVE "*** FIM DE PROCESSAMENTO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO NOV-SOL
              ELSE
                 MOVE "ERRO NA LEITURA DO ARQUIVO CADMED"  TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM
           ELSE
              NEXT SENTENCE.
       ROT-MONTAR.
           MOVE CRM           TO DETCRM
           MOVE NOME          TO DETNOME
           MOVE ESPEC         TO DETESPEC
           MOVE TELEFONE      TO DETTEL
           COMPUTE LIN = CONLIN + 5
           DISPLAY (LIN, 01) DET2
           ADD 1 TO CONLIN
           IF CONLIN < 17
                  GO TO INC-RD2.
      *
       ROT-SOL.
           DISPLAY (23, 13) " *** CONTINUA CONSULTA : . ***"
           MOVE "S" TO W-OPCAO
           ACCEPT  (23, 38) W-OPCAO  WITH UPDATE
           IF W-OPCAO = "S"
                  MOVE 01 TO CONLIN
                  DISPLAY TELAMED
                  GO TO INC-RD2.
           IF W-OPCAO NOT = "N"
                  MOVE "*** DIGITE S=SIM   N=NAO ***" TO MENS
                  PERFORM ROT-MENS THRU ROT-MENS-FIM
                  GO TO ROT-SOL.
           MOVE 01 TO CONLIN.
           GO TO INC-001.
      *
       NOV-SOL.
           DISPLAY (23, 13) " *** NOVA CONSULTA : . ***"
           MOVE "S" TO W-OPCAO
           ACCEPT  (23, 34) W-OPCAO WITH UPDATE
           IF W-OPCAO = "S"
                  MOVE 01 TO CONLIN
                  GO TO INC-001.
           IF W-OPCAO NOT = "N"
                  MOVE "*** DIGITE S=SIM   N=NAO ***" TO MENS
                  PERFORM ROT-MENS THRU ROT-MENS-FIM
                  GO TO NOV-SOL.
      *
      **********************
      * ROTINA DE FIM      *
      **********************
      *
       ROT-FIM.
           DISPLAY (01 01) ERASE.
           CLOSE CADMED.
       ROT-FIM2.
           EXIT PROGRAM.
       ROT-FIM3.
           STOP RUN.
      *
      **********************
      * ROTINA DE MENSAGEM *
      **********************
      *
       ROT-MENS.
           MOVE ZEROS TO W-CONT.
       ROT-MENS1.
           DISPLAY (23, 13) MENS.
       ROT-MENS2.
           ADD 1 TO W-CONT
           IF W-CONT < 1000
              GO TO ROT-MENS2
           ELSE
              DISPLAY (23, 12) LIMPA.
       ROT-MENS-FIM.
           EXIT.
       FIM-ROT-MENS.
      *

      *---------------------*** FIM DE PROGRAMA ***--------------------*