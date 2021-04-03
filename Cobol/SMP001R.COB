       IDENTIFICATION DIVISION.
       PROGRAM-ID. SMP001R.
      ****************************************
      *   GERACAO DE RELATORIO DE MEDICOS    *
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
           SELECT CADMED ASSIGN TO DISK
             ORGANIZATION IS INDEXED
             ACCESS MODE  IS DYNAMIC
             RECORD KEY   IS CRM
             FILE STATUS  IS ST-ERRO
             ALTERNATE RECORD KEY IS NOME
                                     WITH DUPLICATES.
           
           SELECT CADMEDRL ASSIGN TO DISK
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL
             FILE STATUS  IS ST-ERRO.
      *
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
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
       FD CADMEDRL
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADCEPRL.DOC".
       01 REGMEDRL    PIC X(100).
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
           "---------------------------------------------------------".
           05  FILLER                 PIC X(043) VALUE
           "-------------------------------------------".

       01  CABECALHO-1.
           05  FILLER                 PIC X(057) VALUE
           "- PROGRAMACAO PARA MAINFRAME              RELATORIO DE ME".
           05  FILLER                 PIC X(043) VALUE
           "DICOS                                     -".

       01  CABECALHO-2.
           05  FILLER                 PIC X(057) VALUE
           "---------------------------------------------------------".
           05  FILLER                 PIC X(043) VALUE
           "-------------------------------------------".

       01  CABECALHO-3.
           05  FILLER                 PIC X(057) VALUE
           "- CRM    NOME                           ES  S DATA NASC  ".
           05  FILLER                 PIC X(043) VALUE
           "EMAIL                          TELEFONE   -".

       01  DETALHE-DADOS.
           05  FILLER                 PIC X(002) VALUE
           "- ".
           05  DET-CRM  VALUE ZEROS  PIC 9(006).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-NOME  VALUE SPACES PIC X(030).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-ESPEC  VALUE ZEROS  PIC 9(002).
           05  FILLER                 PIC X(002) VALUE
           "  ".
           05  DET-SEXO  VALUE SPACES PIC X(001).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-DATANASC  VALUE ZEROS  PIC 9(008).
           05  FILLER                 PIC X(003) VALUE
           "   ".
           05  DET-EMAIL  VALUE SPACES PIC X(030).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-TELEFONE  VALUE ZEROS  PIC 9(009).
           05  FILLER                 PIC X(003) VALUE
           "  -".

       01  LINHA-FINAL.
           05  FILLER                 PIC X(057) VALUE
           "---------------------------------------------------------".
           05  FILLER                 PIC X(043) VALUE
           "-------------------------------------------".

      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT001R.
           05  BLANK SCREEN.
           05  LINE 02  COLUMN 01 
               VALUE  "                  *** GERANDO RELATORIO ".
           05  LINE 02  COLUMN 41 
               VALUE  " DE MEDICOS ***".
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
           MOVE SPACES TO NOME EMAIL SEXO.
           MOVE ZEROS  TO CRM DATANASC ESPEC TELEFONE.

           DISPLAY SMT001R.

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
           OPEN INPUT CADMED
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   MOVE "* ARQUIVO CADMED NAO EXISTE *" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA ABERTURA DO ARQUIVO CADMED" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
               NEXT SENTENCE.
      *
           OPEN OUTPUT CADMEDRL
           IF ST-ERRO NOT = "00"
                      MOVE "ERRO ABERTURA DO ARQUIVO CADMEDRL" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO ROT-FIM.
           
           WRITE REGMEDRL FROM CABECALHO-0.
           WRITE REGMEDRL FROM CABECALHO-1.
           WRITE REGMEDRL FROM CABECALHO-2.
           WRITE REGMEDRL FROM CABECALHO-3.
      *
       LER-MED.
           READ CADMED NEXT
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "10"
                   WRITE REGMEDRL FROM LINHA-FINAL
                   MOVE "*** FIM DO CADMED ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA LEITURA CADMED" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
              NEXT SENTENCE.
       INC-003.
           MOVE CRM           TO DET-CRM.
           MOVE NOME          TO DET-NOME.
           MOVE ESPEC         TO DET-ESPEC.
           MOVE SEXO          TO DET-SEXO.
           MOVE DATANASC      TO DET-DATANASC.
           MOVE EMAIL         TO DET-EMAIL.
           MOVE TELEFONE      TO DET-TELEFONE.
           MOVE DETALHE-DADOS TO REGMEDRL.

       INC-WR1.
           WRITE REGMEDRL
           IF ST-ERRO = "00" OR "02"
               MOVE "*** DADOS GRAVADOS *** " TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO LER-MED
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO CADMEDRL"
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
           CLOSE CADMED CADMEDRL.
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