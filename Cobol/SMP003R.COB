       IDENTIFICATION DIVISION.
       PROGRAM-ID. SMP003R.
      ****************************************
      *   GERACAO DE RELATORIO DE CONVENIOS  *
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
           SELECT CADCONV ASSIGN TO DISK
           ORGANIZATION IS INDEXED
           ACCESS MODE  IS DYNAMIC
           RECORD KEY   IS CV-CODIGO
           FILE STATUS  IS ST-ERRO
           ALTERNATE RECORD KEY IS CV-NOME
                                          WITH DUPLICATES.
           
           SELECT CADCONVRL ASSIGN TO DISK
             ORGANIZATION IS LINE SEQUENTIAL
             ACCESS MODE IS SEQUENTIAL
             FILE STATUS  IS ST-ERRO.
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
       FD CADCONVRL
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADCONVRL.DOC".
       01 REGCONVRL    PIC X(100).
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
           "* PROGRAMACAO PARA MAINFRAME          RELATORIO DE CONVEN".
           05  FILLER                 PIC X(042) VALUE
           "IOS                                      *".

       01  CABECALHO-2.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".

       01  CABECALHO-3.
           05  FILLER                 PIC X(057) VALUE
           "* CODIGO     NOME                               PLANO    ".
           05  FILLER                 PIC X(042) VALUE
           "                                         *".

       01  DETALHE-DADOS.
           05  FILLER                 PIC X(002) VALUE
           "* ".
           05  DET-CODIGO  VALUE ZEROS  PIC 9(004).
           05  FILLER                 PIC X(007) VALUE
           "       ".
           05  DET-NOME  VALUE SPACES PIC X(030).
           05  FILLER                 PIC X(005) VALUE
           "     ".
           05  DET-PLANO  VALUE ZEROS  PIC 9(002).
           05  FILLER                 PIC X(049) VALUE
           "                                                *".

       01  LINHA-FINAL.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".

      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT003R.
           05  BLANK SCREEN.
           05  LINE 02  COLUMN 01 
               VALUE  "                  *** GERANDO RELATORIO ".
           05  LINE 02  COLUMN 41 
               VALUE  " DE CONVENIOS ***".
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
           MOVE SPACES TO CV-NOME.
           MOVE ZEROS  TO CV-CODIGO CV-PLANO.

           DISPLAY SMT003R.

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
           OPEN INPUT CADCONV
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   MOVE "* ARQUIVO CADCONV NAO EXISTE *" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA ABERTURA DO ARQUIVO CADCONV" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
               NEXT SENTENCE.
      *
           OPEN OUTPUT CADCONVRL
           IF ST-ERRO NOT = "00"
                      MOVE "ERRO ABERTURA DO ARQUIVO CADCONVRL" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO ROT-FIM.
           
           WRITE REGCONVRL FROM CABECALHO-0.
           WRITE REGCONVRL FROM CABECALHO-1.
           WRITE REGCONVRL FROM CABECALHO-2.
           WRITE REGCONVRL FROM CABECALHO-3.
      *
       LER-CONV.
           READ CADCONV NEXT
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "10"
                   WRITE REGCONVRL FROM LINHA-FINAL
                   MOVE "*** FIM DO CADCONV ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA LEITURA CADCONV" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
              NEXT SENTENCE.
       INC-003.
           MOVE CV-CODIGO           TO DET-CODIGO.
           MOVE CV-NOME             TO DET-NOME.
           MOVE CV-PLANO            TO DET-PLANO.
           MOVE DETALHE-DADOS       TO REGCONVRL.

       INC-WR1.
           WRITE REGCONVRL
           IF ST-ERRO = "00" OR "02"
               MOVE "*** DADOS GRAVADOS *** " TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO LER-CONV
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO CADCONVRL"
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
           CLOSE CADCONV CADCONVRL.
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