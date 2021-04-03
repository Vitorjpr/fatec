       IDENTIFICATION DIVISION.
       PROGRAM-ID. SMP002R.
      ****************************************
      *   GERACAO DE RELATORIO DE DOENCAS    *
      ****************************************
      *-----------------------------------------------------------------
      * AUTHOR:  VITOR JOSE PAZ RODRIGUES
      * RA:      1110481913003
      * MATERIA: PROGRAMACAO PARA MAINFRAME
      * TURMA:   SABADO DE MANHA
      *-----------------------------------------------------------------
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
           
           SELECT CADCIDRL ASSIGN TO DISK
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL
             FILE STATUS  IS ST-ERRO.
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
       FD CADCIDRL
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADCIDRL.DOC".
       01 REGCIDRL    PIC X(100).
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       77 W-SEL      PIC 9(01) VALUE ZEROS.
       77 W-CONT     PIC 9(06) VALUE ZEROS.
       77 W-OPCAO    PIC X(01) VALUE SPACES.
       77 ST-ERRO    PIC X(02) VALUE "00". 
       77 W-ACT      PIC 9(02) VALUE ZEROS.
       77 MENS       PIC X(50) VALUE SPACES.
       77 LIMPA      PIC X(50) VALUE SPACES.
      *
       
       
       01  CABECALHO-0.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".

       01  CABECALHO-1.
           05  FILLER                 PIC X(057) VALUE
           "* PROGRAMACAO PARA MAINFRAME           RELATORIO DE DOENC".
           05  FILLER                 PIC X(042) VALUE
           "AS                                       *".

       01  CABECALHO-2.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".

       01  CABECALHO-3.
           05  FILLER                 PIC X(057) VALUE
           "* CODIGO    DENOMINACAO                                  ".
           05  FILLER                 PIC X(042) VALUE
           "                                         *".

       01  DETALHE-DADOS.
           05  FILLER                 PIC X(002) VALUE
           "* ".
           05  DET-CODIGO  VALUE ZEROS  PIC 9(004).
           05  FILLER                 PIC X(006) VALUE
           "      ".
           05  DET-DENOMINACAO  VALUE SPACES PIC X(030).
           05  FILLER                 PIC X(057) VALUE
           "                                                        *".

       01  LINHA-FINAL.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".


      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT002R.
           05  BLANK SCREEN.
           05  LINE 02  COLUMN 01 
               VALUE  "                  *** GERANDO RELATORIO ".
           05  LINE 02  COLUMN 41 
               VALUE  " DE DOENCAS ***".
           05  LINE 12  COLUMN 01 
               VALUE  "                         CONFIRMA GERACA".
           05  LINE 12  COLUMN 41 
               VALUE  "O (S ou N ) :".
           05  LINE 24  COLUMN 01 
               VALUE  " MENSAGEM :".
           05  T-OPCAO
               LINE 12  COLUMN 57  PIC X(01)
               USING  W-OPCAO
               HIGHLIGHT.

      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.
      
       INC-001.
           MOVE SPACES TO DENOMINACAO.
           MOVE ZEROS  TO CODIGO.

           DISPLAY SMT002R.

       INC-OPC.
           ACCEPT T-OPCAO
           IF W-OPCAO = "N" OR "n"
               MOVE "* RELATORIO RECUSADO PELO USUARIO *" TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-FIM.

           IF W-OPCAO NOT = "S" AND "s"
               MOVE "*** DIGITE APENAS S=SIM e N=NAO ***" TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO INC-OPC.
      *
       INC-OP0.
           OPEN INPUT CADCID
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   MOVE "* ARQUIVO CADCID NAO EXISTE *" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA ABERTURA DO ARQUIVO CADCID" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
               NEXT SENTENCE.
      *
           OPEN OUTPUT CADCIDRL
           IF ST-ERRO NOT = "00"
                      MOVE "ERRO ABERTURA DO ARQUIVO CADCIDRL" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO ROT-FIM.
           
           WRITE REGCIDRL FROM CABECALHO-0.
           WRITE REGCIDRL FROM CABECALHO-1.
           WRITE REGCIDRL FROM CABECALHO-2.
           WRITE REGCIDRL FROM CABECALHO-3.
      *
       LER-CID.
           READ CADCID NEXT
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "10"
                   WRITE REGCIDRL FROM LINHA-FINAL
                   MOVE "*** FIM DO CADCID ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA LEITURA CADCID" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
              NEXT SENTENCE.
       INC-003.
           MOVE CODIGO           TO DET-CODIGO.
           MOVE DENOMINACAO      TO DET-DENOMINACAO.
           MOVE DETALHE-DADOS    TO REGCIDRL.

       INC-WR1.
           WRITE REGCIDRL
           IF ST-ERRO = "00" OR "02"
               MOVE "*** DADOS GRAVADOS *** " TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO LER-CID
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO CADCIDRL"
                                                TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-FIM.
      *
      **********************
      * ROTINA DE FIM      *
      **********************
      *
       ROT-FIM.
           DISPLAY (01, 01) ERASE
           CLOSE CADCID CADCIDRL.
       ROT-FIMP.
           EXIT PROGRAM.

       ROT-FIMS.
           STOP RUN.
      *
      **********************
      * ROTINA DE MENSAGEM *
      **********************
      *
       ROT-MENS.
           MOVE ZEROS TO W-CONT.
       ROT-MENS1.
           DISPLAY (23, 12) MENS.
       ROT-MENS2.
           ADD 1 TO W-CONT
           IF W-CONT < 3000
               GO TO ROT-MENS2
           ELSE
               DISPLAY (23, 12) LIMPA.
       ROT-MENS-FIM.
           EXIT.
       FIM-ROT-TEMPO.