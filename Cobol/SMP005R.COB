       IDENTIFICATION DIVISION.
       PROGRAM-ID. SMP005R.
      ****************************************
      *   GERACAO DE RELATORIO DE CEPs       *
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
           SELECT CADCEP ASSIGN TO DISK
               ORGANIZATION IS INDEXED
               ACCESS MODE  IS DYNAMIC
               RECORD KEY   IS CODIGO
               FILE STATUS  IS ST-ERRO
               ALTERNATE RECORD KEY IS ENDERECO
                                          WITH DUPLICATES.
           
           SELECT CADCEPRL ASSIGN TO DISK
               ORGANIZATION IS LINE SEQUENTIAL
               ACCESS MODE IS SEQUENTIAL
               FILE STATUS  IS ST-ERRO.
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
       FD CADCEPRL
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADCEPRL.DOC".
       01 REGCEPRL    PIC X(100).
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
           "* PROGRAMACAO PARA MAINFRAME          RELATORIO DE CEPs  ".
           05  FILLER                 PIC X(042) VALUE
           "                                         *".

       01  CABECALHO-2.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".

       01  CABECALHO-3.
           05  FILLER                 PIC X(057) VALUE
           "* CODIGO     ENDERECO                           BAIRRO   ".
           05  FILLER                 PIC X(042) VALUE
           "              CIDADE                UF   *".

       01  DETALHE-DADOS.
           05  FILLER                 PIC X(002) VALUE
           "* ".
           05  DET-CODIGO  VALUE ZEROS  PIC 9(008).
           05  FILLER                 PIC X(003) VALUE
           "   ".
           05  DET-ENDERECO  VALUE SPACES PIC X(030).
           05  FILLER                 PIC X(005) VALUE
           "     ".
           05  DET-BAIRRO  VALUE SPACES PIC X(020).
           05  FILLER                 PIC X(003) VALUE
           "   ".
           05  DET-CIDADE  VALUE SPACES PIC X(020).
           05  FILLER                 PIC X(002) VALUE
           "  ".
           05  DET-ESTADO  VALUE SPACES PIC X(002).
           05  FILLER                 PIC X(004) VALUE
           "   *".

       01  LINHA-FINAL.
           05  FILLER                 PIC X(057) VALUE
           "*********************************************************".
           05  FILLER                 PIC X(042) VALUE
           "******************************************".


      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT005R.
           05  BLANK SCREEN.
           05  LINE 02  COLUMN 01 
               VALUE  "                  *** GERANDO RELATORIO ".
           05  LINE 02  COLUMN 41 
               VALUE  " DE CEPs ***".
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
           MOVE SPACES TO ENDERECO CIDADE BAIRRO ESTADO.
           MOVE ZEROS  TO CODIGO.

           DISPLAY SMT005R.

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
           OPEN INPUT CADCEP
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   MOVE "* ARQUIVO CADCEP NAO EXISTE *" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA ABERTURA DO ARQUIVO CADCEP" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
               NEXT SENTENCE.
      *
           OPEN OUTPUT CADCEPRL
           IF ST-ERRO NOT = "00"
                      MOVE "ERRO ABERTURA DO ARQUIVO CADCEPRL" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM
                      GO TO ROT-FIM.
           
           WRITE REGCEPRL FROM CABECALHO-0.
           WRITE REGCEPRL FROM CABECALHO-1.
           WRITE REGCEPRL FROM CABECALHO-2.
           WRITE REGCEPRL FROM CABECALHO-3.
      *
       LER-CONV.
           READ CADCEP NEXT
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "10"
                   WRITE REGCEPRL FROM LINHA-FINAL
                   MOVE "*** FIM DO CADCEP ***" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
               ELSE
                   MOVE "ERRO NA LEITURA CADCEP" TO MENS
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
              NEXT SENTENCE.
       INC-003.
           MOVE CODIGO               TO DET-CODIGO.
           MOVE ENDERECO             TO DET-ENDERECO.
           MOVE BAIRRO               TO DET-BAIRRO.
           MOVE CIDADE               TO DET-CIDADE.
           MOVE ESTADO               TO DET-ESTADO.
           MOVE DETALHE-DADOS        TO REGCEPRL.

       INC-WR1.
           WRITE REGCEPRL
           IF ST-ERRO = "00" OR "02"
               MOVE "*** DADOS GRAVADOS *** " TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO LER-CONV
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO CADCEPRL"
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
           CLOSE CADCEP CADCEPRL.
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