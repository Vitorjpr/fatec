       IDENTIFICATION DIVISION.
       PROGRAM-ID. INICIO.
      ****************************************
      *   MENU PARA CONSULTAS E RELATORIOS   *
      ****************************************
      * AUTHOR:  VITOR JOSE PAZ RODRIGUES
      * RA:      1110481913003
      * MATERIA: PROGRAMACAO PARA MAINFRAME
      * TURMA:   SABADO DE MANHA
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
                    DECIMAL-POINT IS COMMA.
      *-----------------------------------------------------------------
       DATA DIVISION.
      *
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 W-CONT       PIC 9(04) VALUE ZEROS.
       01 W-OPCAO      PIC 9(02) VALUE ZEROS.
       01 W-ACT        PIC 9(02) VALUE ZEROS.
       01 ST-ERRO      PIC X(02) VALUE "00".
       01 MENS         PIC X(50) VALUE SPACES.
       01 LIMPA        PIC X(50) VALUE SPACES.
       01 PROG-SEL      PIC X(07) VALUE SPACES.

      *-----------------------------------------------------------------
       01 TAB-PROG-DISP.
           03 FILLER PIC X(07) VALUE "SMP001".
           03 FILLER PIC X(07) VALUE "SMP002".
           03 FILLER PIC X(07) VALUE "SMP003".
           03 FILLER PIC X(07) VALUE "SMP004".
           03 FILLER PIC X(07) VALUE "SMP005".
           03 FILLER PIC X(07) VALUE "SMP001R".
           03 FILLER PIC X(07) VALUE "SMP002R".
           03 FILLER PIC X(07) VALUE "SMP003R".
           03 FILLER PIC X(07) VALUE "SMP004R".
           03 FILLER PIC X(07) VALUE "SMP005R".
      *
       01 TAB-PROGR REDEFINES TAB-PROG-DISP.
          03 TAB-PROG PIC X(07) OCCURS 10 TIMES.
      *
      ******************
      * ROTINA DE TELA *
      ******************
      *
       SCREEN SECTION.
       01  TELA-INIC.
           05  BLANK SCREEN.
           05  LINE 02  COLUMN 01 
               VALUE  "                             MENU INICIAL".
           05  LINE 05  COLUMN 01 
               VALUE  "              1  - CADASTRO DE MEDICOS    ".

           05  LINE 06  COLUMN 01 
               VALUE  "              2  - CADASTRO DE DOENCAS    ".

           05  LINE 07  COLUMN 01 
               VALUE  "              3  - CADASTRO DE CONVENIOS  ".
           
           05  LINE 08  COLUMN 01 
               VALUE  "              4  - CADASTRO DE PACIENTES  ".
           
           05  LINE 09  COLUMN 01 
               VALUE  "              5  - CADASTRO DE CEP        ".

           05  LINE 10  COLUMN 01 
               VALUE  "              6  - RELATORIO DE MEDICOS   ".

           05  LINE 11  COLUMN 01 
               VALUE  "              7  - RELATORIO DE DOENCAS   ".

           05  LINE 12  COLUMN 01 
               VALUE  "              8  - RELATORIO DE CONVENIOS ".
           
           05  LINE 13  COLUMN 01 
               VALUE  "              9  - RELATORIO DE PACIENTES ".
           
           05  LINE 14  COLUMN 01 
               VALUE  "              10 - RELATORIO DE CEP      ".
           
           05  LINE 20  COLUMN 01 
               VALUE  "                             OPCAO :".
           05  LINE 20  COLUMN 41 
               VALUE  " ( 00 - ENCERRA )".
           05  LINE 23  COLUMN 01 
               VALUE  " MENSAGEM :".
           05  T-OPCAO
               LINE 20  COLUMN 38  PIC 9(02)
               USING  W-OPCAO
               HIGHLIGHT.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.

      ****************************
      *   SELECAO DE PROGRAMA    *
      ****************************
      
       MENU-PRINCIPAL.
           DISPLAY TELA-INIC.
           
           ACCEPT T-OPCAO.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
               GO TO ROT-FIM.

           IF W-OPCAO = 00
               GO TO ROT-FIM.

           IF W-OPCAO > 10
               MOVE "* PROGRAMA NAO DISPONIVEL *" TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO MENU-PRINCIPAL.

           IF W-OPCAO = SPACES
               MOVE "* VALOR INVALIDO *" TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO MENU-PRINCIPAL.

           MOVE TAB-PROG(W-OPCAO) TO PROG-SEL
      *
       ROT-EXEC.
           CALL PROG-SEL ON OVERFLOW
               MOVE "* ERRO NA ABERTURA DO PROGRAMA *" TO MENS
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO MENU-PRINCIPAL.
           CANCEL PROG-SEL.
           GO TO MENU-PRINCIPAL.
      *
      **********************
      * ROTINA DE FIM      *
      **********************
      *
       ROT-FIM.
           EXIT PROGRAM.
       ROT-FIM1.
           DISPLAY (01, 01) ERASE.
           STOP RUN.
      *
      **********************
      * ROTINA DE MENSAGEM *
      **********************
      *
       ROT-MENS.
           MOVE ZEROS TO W-CONT.
       ROT-MENS1.
           DISPLAY (23 12) MENS.
       ROT-MENS2.
           ADD 1 TO W-CONT
           IF W-CONT < 3000
              GO TO ROT-MENS2
           ELSE
              DISPLAY (23 12) LIMPA.
       ROT-MENS-FIM.
      *
      *---------------------*** FIM DE PROGRAMA ***--------------------*