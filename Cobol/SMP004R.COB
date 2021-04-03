       IDENTIFICATION DIVISION.
       PROGRAM-ID. SMP004R.
      ***************************************
      *  GERACAO DE RELATORIO DE PACIENTES  *
      ***************************************
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
           SELECT CADPACI ASSIGN TO DISK
               ORGANIZATION IS INDEXED
               ACCESS MODE  IS DYNAMIC
               RECORD KEY   IS P-CODIGO
               FILE STATUS  IS ST-ERRO
               ALTERNATE RECORD KEY IS P-NOME
                                          WITH DUPLICATES.
           
           SELECT CADPACIRL ASSIGN TO DISK
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS  IS ST-ERRO.
      *
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
       FD CADPACI
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADPACI.DAT".
       01 REGPACI.
           03 P-CODIGO               PIC 9(04).
           03 P-NOME                 PIC X(30).
           03 P-DATANASC.
               05 P-DIA              PIC 99.
               05 P-MES              PIC 99.
               05 P-ANO              PIC 9(04).
           03 P-SEXO                 PIC X(01).
           03 P-GENERO               PIC X(01).
           03 P-CONVENIO             PIC 9(04).
           03 P-PLANO                PIC 9(02).
           03 P-CEP                  PIC 9(08).
           03 P-NUM-END              PIC 9(04).
           03 P-COMPLEM              PIC X(10).
           03 P-TELEFONE             PIC 9(11).
           03 P-EMAIL                PIC X(30).
      *
       FD CADPACIRL
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADPACIRL.DOC".
       01 REGPACIRL    PIC X(100).
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
           "* PROGRAMACAO PARA MAINFRAME          RELATORIO DE PACIEN".
           05  FILLER                 PIC X(042) VALUE
           "TES                                      *".

       01  CABECALHO-2.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".

       01  CABECALHO-3.
           05  FILLER                 PIC X(057) VALUE
           "* COD. NOME                           CONV PL CEP      TE".
           05  FILLER                 PIC X(042) VALUE
           "L.        EMAIL                          *".

       01  DETALHE-DADOS.
           05  FILLER                 PIC X(002) VALUE
           "* ".
           05  DET-CODIGO  VALUE ZEROS  PIC 9(004).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-NOME  VALUE SPACES PIC X(030).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-CONVENIO  VALUE ZEROS  PIC 9(004).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-PLANO  VALUE ZEROS  PIC 9(002).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-CEP  VALUE ZEROS  PIC 9(008).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-TELEFONE  VALUE ZEROS  PIC 9(011).
           05  FILLER                 PIC X(001) VALUE
           " ".
           05  DET-EMAIL  VALUE SPACES PIC X(030).
           05  FILLER                 PIC X(002) VALUE
           " *".

       01  LINHA-FINAL.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".

      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT004R.
           05  BLANK SCREEN.
           05  LINE 02  COLUMN 01 
               VALUE  "                  *** GERANDO RELATORIO ".
           05  LINE 02  COLUMN 41 
               VALUE  " DE PACIENTES ***".
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
           MOVE SPACES TO P-NOME P-SEXO P-GENERO P-COMPLEM P-EMAIL.
           MOVE ZEROS  TO P-CODIGO P-DIA P-MES P-ANO P-CONVENIO 
                          P-PLANO P-CEP P-NUM-END P-TELEFONE.

           DISPLAY SMT004R.

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
           OPEN INPUT CADPACI
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   MOVE "* ARQUIVO CADPACI NAO EXISTE *" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA ABERTURA DO ARQUIVO CADPACI" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
               NEXT SENTENCE.
      *
           OPEN OUTPUT CADPACIRL
           IF ST-ERRO NOT = "00"
                      MOVE "ERRO ABERTURA DO ARQUIVO CADPACIRL" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO ROT-FIM.
           
           WRITE REGPACIRL FROM CABECALHO-0.
           WRITE REGPACIRL FROM CABECALHO-1.
           WRITE REGPACIRL FROM CABECALHO-2.
           WRITE REGPACIRL FROM CABECALHO-3.
      *
       LER-CONV.
           READ CADPACI NEXT
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "10"
                   WRITE REGPACIRL FROM LINHA-FINAL
                   MOVE "*** FIM DO CADPACI ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA LEITURA CADPACI" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
              NEXT SENTENCE.
       INC-003.
           MOVE P-CODIGO               TO DET-CODIGO.
           MOVE P-NOME                 TO DET-NOME.
           MOVE P-CONVENIO             TO DET-CONVENIO.
           MOVE P-PLANO                TO DET-PLANO.
           MOVE P-CEP                  TO DET-CEP.
           MOVE P-TELEFONE             TO DET-TELEFONE.
           MOVE P-EMAIL                TO DET-EMAIL.
           MOVE DETALHE-DADOS          TO REGPACIRL.

       INC-WR1.
           WRITE REGPACIRL
           IF ST-ERRO = "00" OR "02"
               MOVE "*** DADOS GRAVADOS *** " TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO LER-CONV
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO CADPACIRL"
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
           CLOSE CADPACI CADPACIRL.
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