       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONSPACI.
      **************************************************
      *               CONSULTA DE PACIENTES            *
      **************************************************
      *----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
                    DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *
       SELECT CADPACI ASSIGN TO DISK
                    ORGANIZATION IS INDEXED
                    ACCESS MODE  IS DYNAMIC
                    RECORD KEY   IS P-CODIGO
                    FILE STATUS  IS ST-ERRO
                    ALTERNATE RECORD KEY IS P-NOME
                                   WITH DUPLICATES.
      *
      *-----------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
      *
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
      *-----------------------------------------------------------------
       WORKING-STORAGE SECTION.
       01 W-SEL                  PIC 9(01) VALUE ZEROS.
       01 W-CONT                 PIC 9(04) VALUE ZEROS.
       01 W-OPCAO                PIC X(01) VALUE SPACES.
       01 ST-ERRO                PIC X(02) VALUE "00".
       01 W-ACT                  PIC 9(02) VALUE ZEROS.
       01 MENS                   PIC X(50) VALUE SPACES.
       01 LIMPA                  PIC X(55) VALUE SPACES.
       01 SOLIC                  PIC X(20) VALUE SPACES.
       01 CONLIN                 PIC 9(03) VALUE 001.
       01 TXGENERO               PIC X(13) VALUE SPACES.
       01 IND                    PIC 9(05) VALUE ZEROS.
       01 TABPACI.
          03 TBPACI              PIC 9(08) OCCURS 1000 TIMES.
       01 NUMREG                 PIC 9(04) VALUE ZEROS.  
      *-----------------------------------------------------------------
      *
      ******************
      * ROTINA DE TELA *
      ******************
      *
       SCREEN SECTION.
       01  SMT040.
           05  BLANK SCREEN.
           05  LINE 03  COLUMN 01 
               VALUE  "                         *** CONSULTA DE".
           05  LINE 03  COLUMN 41 
               VALUE  " PACIENTES ***".

           05  LINE 05  COLUMN 01 
               VALUE  "     CODIGO          :".

           05  LINE 06  COLUMN 01 
               VALUE  "     NOME            :".

           05  LINE 07  COLUMN 01 
               VALUE  "     DATA NASC       :".

           05  LINE 08  COLUMN 01 
               VALUE  "     SEXO            :".

           05  LINE 09  COLUMN 01 
               VALUE  "     GENERO          :".

           05  LINE 10  COLUMN 01 
               VALUE  "     CONVENIO        :".

           05  LINE 10  COLUMN 30 
               VALUE  "NOME: ".

           05  LINE 11  COLUMN 01 
               VALUE  "     PLANO           :".

           05  LINE 12  COLUMN 01 
               VALUE  "     CEP             :".

           05  LINE 13  COLUMN 01 
               VALUE  "     RUA             :".

           05  LINE 14  COLUMN 01 
               VALUE  "     NUM             :".

           05  LINE 15  COLUMN 01 
               VALUE  "     COMPLEMENTO     :".

           05  LINE 16  COLUMN 01 
               VALUE  "     TELEFONE        :".

           05  LINE 17  COLUMN 01 
               VALUE  "     EMAIL           :".
               VALUE  "              OPCAO :   (E=ENCERRA     P".
           05  LINE 21  COLUMN 41 
               VALUE  "=PROXIMO     A=ANTERIOR )".
           05  LINE 22  COLUMN 41 
               VALUE  "   ==>            <==".
           05  LINE 23  COLUMN 01 
               VALUE  " MENSAGEM :".
           05  LINE 23  COLUMN 41 
               VALUE  "                                 SMP040".

           05  TPCODIGO
               LINE 05  COLUMN 24  PIC 9(04)
               USING  P-CODIGO
               HIGHLIGHT.

           05  TPNOME
               LINE 06  COLUMN 24  PIC X(30)
               USING  P-NOME
               HIGHLIGHT.

           05  TPDATANASC
               LINE 07  COLUMN 24  PIC 99.99.9999
               USING  P-DATANASC
               HIGHLIGHT.

           05  TPSEXO
               LINE 08  COLUMN 24  PIC X(01)
               USING  P-SEXO
               HIGHLIGHT.

           05  TTXSEXO
               LINE 08  COLUMN 26  PIC X(12)
               USING  TXSEXO
               HIGHLIGHT.

           05  TPGENERO
               LINE 09  COLUMN 24  PIC X(01)
               USING  P-GENERO
               HIGHLIGHT.

           05  TTXGENERO
               LINE 09  COLUMN 26  PIC X(13)
               USING  TXGENERO
               HIGHLIGHT.

           05  TPCONVENIO
               LINE 10  COLUMN 24  PIC 9(04)
               USING  P-CONVENIO
               HIGHLIGHT.

           05  TPNOMECONV
               LINE 10  COLUMN 37  PIC X(30)
               USING  CV-NOME
               HIGHLIGHT.

           05  TPPLANO
               LINE 11  COLUMN 24  PIC 9(02)
               USING  CV-PLANO
               HIGHLIGHT.

           05  TPCEP
               LINE 12  COLUMN 24  PIC 9(08)
               USING  P-CEP
               HIGHLIGHT.

           05  TPRUA
               LINE 13  COLUMN 24  PIC X(30)
               USING  ENDERECO
               HIGHLIGHT.

           05  TPBAIRRO
               LINE 13  COLUMN 55  PIC X(20)
               USING  BAIRRO
               HIGHLIGHT.

           05  TPNUM
               LINE 14  COLUMN 24  PIC 9(04)
               USING  P-NUM-END
               HIGHLIGHT.

           05  TPCOMPL
               LINE 15  COLUMN 24  PIC X(10)
               USING  P-COMPLEM
               HIGHLIGHT.

           05  TPTELEFONE
               LINE 16  COLUMN 24  PIC 99.9999.9999
               USING  P-TELEFONE
               HIGHLIGHT.

           05  TPEMAIL
               LINE 17  COLUMN 24  PIC X(30)
               USING  P-EMAIL
               HIGHLIGHT.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.
      *
       INC-OP1.
           OPEN INPUT  CADPACI
           IF ST-ERRO NOT = "00"
              IF ST-ERRO = "30"
                 MOVE "ARQUIVO DE CADPACI NAO EXISTE" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM2
              ELSE
                 MOVE "ERRO ABERTURA DO ARQUIVO CADPACI"  TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM2.
           MOVE 1 TO IND
           MOVE ZEROS TO P-CODIGO NUMREG.
           START CADPACI KEY IS NOT LESS P-CODIGO INVALID KEY
                 MOVE "*** CHAVE NAO ENCONTRADA ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM.

       LER-PACIENTE.           
           READ CADPACI NEXT
           IF ST-ERRO NOT = "00"
              IF ST-ERRO = "10"
                 MOVE IND TO NUMREG
                 ADD -1 TO NUMREG
                 MOVE "*** FIM DO ARQUIVO  ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-001
              ELSE
                 MOVE "ERRO NA LEITURA DO ARQUIVO CADPACI"  TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM
           ELSE
              MOVE P-CODIGO TO TBPACI(IND)
              ADD 1 TO IND              
              IF IND > 1000
                 MOVE "*** TABELA ESTOURADA ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-001
              ELSE
                 GO TO LER-PACIENTE.

      *
       INC-001.
           MOVE 0 TO P-CODIGO P-DIA P-MES P-ANO P-CONVENIO
                     P-PLANO P-CEP P-NUM-END P-TELEFONE.

           MOVE SPACES TO P-NOME P-SEXO P-GENERO P-COMPLEM
                          P-EMAIL.

           DISPLAY  SMT040.
       INC-001A.
           ACCEPT TPCODIGO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02
                      CLOSE CADPACI
                      GO TO ROT-FIM.
           IF W-ACT > 02
                      MOVE "*** FUNCAO NAO DEFINIDA ***" TO MENS
                      PERFORM ROT-MENS THRU ROT-MENS-FIM   
                      GO TO INC-001A.
           MOVE 1 TO IND.

       R111.
           IF TBPACI(IND) < P-CODIGO
              ADD 1 TO IND
              IF IND > 1000
                 MOVE "*** CEP NAO ENCONTRADO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-001A
              ELSE
                 GO TO R111.
       R112.
           MOVE TBPACI(IND) TO P-CODIGO.

       INC-RD2.
           READ CADPACI 
           IF ST-ERRO NOT = "00"
              IF ST-ERRO = "23"
                 MOVE "*** REGISTRO NAO ENCONTRADO ***" TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO INC-001
              ELSE
                 MOVE "ERRO NA LEITURA DO ARQUIVO CADPACI"  TO MENS
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM
           ELSE
              NEXT SENTENCE.

       ROT-MONTAR.
              DISPLAY SMT040.

       ROT-SOL.
           ACCEPT  TW-OPCAO  
           IF W-OPCAO = "E"
                  GO TO ROT-FIM 
           ELSE
             IF W-OPCAO = "P"
                 IF IND < NUMREG
                   ADD 1 TO IND
                   GO TO R112
                 ELSE
                   MOVE "*** ULTIMO REGISTRO ***" TO MENS
                           PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-SOL
             ELSE
                IF W-OPCAO = "A"
                    IF IND > 1
                       ADD -1 TO IND
                       GO TO R112
                    ELSE
                       MOVE "*** PRIMEIRO REGISTRO ***" TO MENS
                           PERFORM ROT-MENS THRU ROT-MENS-FIM
                       GO TO ROT-SOL
                ELSE
                
                     MOVE "*** OPCAO NAO DISPONIVEL ***" TO MENS
                     PERFORM ROT-MENS THRU ROT-MENS-FIM
                     GO TO ROT-SOL.

      *
      **********************
      * ROTINA DE FIM      *
      **********************
      *
       ROT-FIM.

           CLOSE CADPACI.
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