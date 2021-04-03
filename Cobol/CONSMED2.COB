       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONSMED2.
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
                    ALTERNATE RECORD KEY IS EMAIL
                    ALTERNATE RECORD KEY IS ESPEC
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
       01 CRMENTR      PIC 9(06) VALUE ZEROS.
       01 NOMEENTR     PIC X(30) VALUE SPACES.
       01 EMAILENTR    PIC X(30) VALUE SPACES.
       01 TELEFONEENTR PIC 9(11) VALUE ZEROS.
       01 ESPECENTR    PIC 9(02) VALUE ZEROS.
      *-----------------------------------------------------------------
      *
      ******************
      * REPORT SECTION *
      ******************
      *
       01 DET2.
          03 FILLER           PIC X(05) VALUE "CRM: ".
          03 DETCRM           PIC 999999.
          03 FILLER           PIC X(07) VALUE " ESPEC: ".
          03 DETESPEC         PIC X(02) VALUE SPACES.
          03 FILLER           PIC X(10) VALUE " TELEFONE:".
          03 FILLER           PIC X(01) VALUE SPACES.
          03 DETTELEFONE      PIC X(11).
          
      *
       01 DET3.
          03 FILLER           PIC X(06) VALUE "NOME: ".
          03 DETNOME          PIC X(30) VALUE SPACES.
          03 FILLER           PIC X(07) VALUE "EMAIL: ".
          03 DETEMAIL         PIC X(30).
          
          

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
               VALUE  "CRM        ESPEC    TELEFONE            ".
           05  LINE 05  COLUMN 01 
               VALUE  "NOME                                EMAIL ".
           05  LINE 23  COLUMN 01 
               VALUE  "  MENSAGEM :".

           05  TCRMENTR
               LINE 04  COLUMN 05  PIC 999999
               USING  CRMENTR.

           05  TESPECENTR
               LINE 04  COLUMN 18  PIC X(02)
               USING  ESPECENTR.
           
           05  TTELEFONEENTR
               LINE 04  COLUMN 30  PIC X(11)
               USING  TELEFONEENTR.

           05  TNOMEENTR
               LINE 05  COLUMN 06  PIC X(30)
               USING  NOMEENTR.
           
           05  TEMAILENTR
               LINE 05  COLUMN 48  PIC X(30)
               USING  EMAILENTR.
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
           MOVE ZEROS                  TO CEPENTR
           MOVE ZEROS                  TO TELEFONEENTR
           MOVE ZEROS                  TO ESPECENTR
           MOVE SPACES                 TO NOMEENTR
           MOVE SPACES                 TO EMAILENTR

           DISPLAY TELAMED.

       CONS-CRM.
           DISPLAY (23, 13)
            "SOLIC.=> F1=ENCERRA CONSULTA     F2=CONSULTA P/NOME."
           ACCEPT TCRMENTR
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02
                      CLOSE CADMED
                      GO TO ROT-FIM.
           IF W-ACT = 03
                      GO TO CONS-NOME.
           IF W-ACT > 03
                      MOVE "*** FUNCAO NAO DEFINIDA ***" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO CONS-CRM.
           MOVE CRMENTR TO CRM
           START CADMED KEY IS NOT LESS CRM INVALID KEY
                 MOVE "*** FIM DE PROCESSAMENTO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-001.
           GO TO INC-RD2.
           
       CONS-NOME.
           DISPLAY (23, 13)
            "SOLIC.=> F1=ENCERRA CONSULTA     F2=CONSULTA P/EMAIL"
           ACCEPT TNOMEENTR
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02
                      CLOSE CADMED
                      GO TO ROT-FIM.
           IF W-ACT = 03
                      GO TO CONS-EMAIL.
           IF W-ACT > 03
                      MOVE "*** FUNCAO NAO DEFINIDA ***" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO CONS-NOME.
           MOVE NOMEENTR TO NOME
           START CADMED KEY IS NOT LESS NOME INVALID KEY
                 MOVE "*** FIM DE PROCESSAMENTO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO CONS-NOME.
           GO TO INC-RD2.
       
       CONS-EMAIL.
           DISPLAY (23, 13)
            "SOLIC.=> F1=ENCERRA CONSULTA     F2=CONSULTA P/ESPEC"
           ACCEPT TEMAILENTR
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02
                      CLOSE CADMED
                      GO TO ROT-FIM.
           IF W-ACT = 03
                      GO TO CONS-ESPEC.
           IF W-ACT > 03
                      MOVE "*** FUNCAO NAO DEFINIDA ***" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO CONS-EMAIL.
           MOVE EMAILENTR TO EMAIL
           START CADMED KEY IS NOT LESS EMAIL INVALID KEY
                 MOVE "*** FIM DE PROCESSAMENTO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO CONS-EMAIL.
           GO TO INC-RD2.

       CONS-ESPEC.
           DISPLAY (23, 13)
            "SOLIC.=> F1=ENCERRA CONSULTA     F2=CONSULTA P/TELEFONE"
           ACCEPT TESPECENTR
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02
                      CLOSE CADMED
                      GO TO ROT-FIM.
           IF W-ACT = 03
                      GO TO CONS-CRM.
           IF W-ACT > 03
                      MOVE "*** FUNCAO NAO DEFINIDA ***" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO CONS-ESPEC.
           MOVE ESPECENTR TO ESPEC
           START CADMED KEY IS NOT LESS ESPEC INVALID KEY
                 MOVE "*** FIM DE PROCESSAMENTO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO CONS-ESPEC.

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
           MOVE CRM                    TO DETCRM
           MOVE NOME                   TO DETNOME
           MOVE EMAIL                  TO DETEMAIL
           MOVE TELEFONE               TO DETTELEFONE
           MOVE ESPEC                  TO DETESPEC

           COMPUTE LIN = CONLIN + 3
           DISPLAY (LIN, 01) DET2
           ADD 1 TO CONLIN
           COMPUTE LIN = CONLIN + 3
           DISPLAY (LIN, 01) DET3
           ADD 2 TO CONLIN
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
           IF W-CONT < 3000
              GO TO ROT-MENS2
           ELSE
              DISPLAY (23, 12) LIMPA.
       ROT-MENS-FIM.
           EXIT.
       FIM-ROT-MENS.
      *

      *---------------------*** FIM DE PROGRAMA ***--------------------*