       IDENTIFICATION DIVISION.
       PROGRAM-ID.               SMP004.
       AUTHOR.                   VITOR JOSE PAZ RODRIGUES.
      *RA:                       1110481913003 
      ********************************************************
      *               CADASTRO DE PACIENTES                  *
      *            DATA CRIACAO : 04/10/2020                 *
      ********************************************************
      *----------------------------------------------------------------
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

           SELECT CADCEP ASSIGN TO DISK
              ORGANIZATION IS INDEXED
              ACCESS MODE  IS DYNAMIC
              RECORD KEY   IS CODIGO
              FILE STATUS  IS ST-ERRO
              ALTERNATE RECORD KEY IS ENDERECO
                                          WITH DUPLICATES.

           SELECT CADCONV ASSIGN TO DISK
              ORGANIZATION IS INDEXED
              ACCESS MODE  IS DYNAMIC
              RECORD KEY   IS CV-CODIGO
              FILE STATUS  IS ST-ERRO
              ALTERNATE RECORD KEY IS CV-NOME
                                          WITH DUPLICATES.
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
      
       FD CADCEP
           LABEL RECORD IS STANDARD
           VALUE OF FILE-ID IS "CADCEP.DAT".
       01 REGCEP.
            03 CODIGO                PIC 9(08).
            03 ENDERECO              PIC X(30).
            03 BAIRRO                PIC X(20).
            03 CIDADE                PIC X(20).
            03 ESTADO                PIC X(02).
      
       FD CADCONV
               LABEL RECORD IS STANDARD
               VALUE OF FILE-ID IS "CADCONV.DAT".
       01 REGCONV.
           03 CV-CODIGO              PIC 9(04).
           03 CV-NOME                PIC X(30).
           03 CV-PLANO               PIC 9(02).
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
       01 TXGENERO               PIC X(13) VALUE SPACES.
       01 MENSAGEM.
            03 MENSAGEM1         PIC X(30) VALUE SPACES.
            03 COD-MENS          PIC 9(02) VALUE ZEROS.
      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT004.
           05  BLANK SCREEN.
           05  LINE 03  COLUMN 01 
               VALUE  "                         *** CADASTRO DE".
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
      *------------[ ROTINA DE ABERTURA ARQUIVO ]------------------
       ABRIR-CADPACI.
           OPEN I-O CADPACI
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   OPEN OUTPUT CADPACI
                   CLOSE CADPACI
                   GO TO ABRIR-CADPACI
               ELSE
                   MOVE "ERRO NA ABERTURA ARQUIVO = " TO MENSAGEM1 
                   MOVE ST-ERRO TO COD-MENS
                   MOVE MENSAGEM  TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO ROT-FIM.

       ABRIR-CADCEP.
           OPEN INPUT CADCEP
           IF ST-ERRO NOT = "00"  
              IF ST-ERRO = "30"
                 MOVE "*** ARQUIVO CADCEP NAO ENCONTRADO **" TO W-MSG
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM
              ELSE
                 MOVE "ERRO NA ABERTURA DO ARQUIVO CADCEP " TO W-MSG
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM.

       ABRIR-CADCONV.
           OPEN INPUT CADCONV
           IF ST-ERRO NOT = "00"  
              IF ST-ERRO = "30"
                 MOVE "*** ARQUIVO CADCONV NAO ENCONTRADO **" TO W-MSG
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM
              ELSE
                 MOVE "ERRO NA ABERTURA DO ARQUIVO CADCONV " TO W-MSG
                 PERFORM ROT-MENS THRU ROT-MENS-FIM
                 GO TO ROT-FIM.
                                      
      *--------------------[ INICIALIAR VARIAVEIS ]-----------------
       ROT-INIC.
           MOVE 0 TO P-CODIGO P-DIA P-MES P-ANO P-CONVENIO
                     P-PLANO P-CEP P-NUM-END P-TELEFONE
                     CODIGO CV-CODIGO CV-PLANO.

           MOVE SPACES TO P-NOME P-SEXO P-GENERO P-COMPLEM
                          P-EMAIL ENDERECO BAIRRO 
                          CIDADE ESTADO CV-NOME.

      *--------------------[ VISUALIZAR TELA INICIAL ]-----------------
       PASSO-0.
           DISPLAY SMT004.
      *--------------------[ DIGITAR CAMPO CHAVE  ]-----------------
       PASSO-1.
           ACCEPT TPCODIGO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   CLOSE CADPACI
                   GO TO ROT-FIM.
           IF P-CODIGO = ZEROS
                MOVE "NUMERO DE CODIGO INVALIDO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-1.
      *--------------------[ LER CAMPO  CHAVE  ]-----------------
       LER-ARQ. 
           READ CADPACI
           IF ST-ERRO NOT = "23"
               IF ST-ERRO = "00"
                   DISPLAY SMT004
                   MOVE "*** PACIENTE JA CADASTRADO ***"     TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   MOVE "I" TO W-SEL
                   GO TO ACE-001
               ELSE
                   MOVE "ERRO NA LEITURA ARQUIVO CADPACI"    TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO ROT-FIM
           ELSE
               MOVE "*** PACIENTE NAO ESTA CADASTRADO ***"   TO W-MSG 
               PERFORM ROT-MENS THRU ROT-MENS2.
       PASSO-2.
           ACCEPT TPNOME.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-1.
           IF P-NOME = SPACES
                MOVE "NOME NAO PODE FICAR EM BRANCO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-2.
       
       PASSO-3.
           ACCEPT TPDATANASC
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
             GO TO PASSO-2.
           IF P-DATANASC = ZEROS
             MOVE "DATA DE NASCIMENTO INVALIDA" TO W-MSG
             PERFORM ROT-MENS THRU ROT-MENS2
             GO TO PASSO-3
           ELSE
             IF P-DIA < 01 OR P-DIA > 31
               MOVE "DIA INVALIDO. DIGITE NOVAMENTE" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS2
               GO TO PASSO-3
             ELSE
               IF P-MES < 01 OR P-MES > 12
                 MOVE "MES INVALIDO. DIGITE NOVAMENTE" TO W-MSG
                 PERFORM ROT-MENS THRU ROT-MENS2
                 GO TO PASSO-3
               ELSE
                 IF P-ANO < 1940 OR P-ANO > 2002
                   MOVE "ANO INVALIDO. DIGITE NOVAMENTE" TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO PASSO-3.

       PASSO-4.
           ACCEPT TPSEXO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-3.
       PASSO-4-A.
           IF P-SEXO = "M" 
             MOVE "MASCULINO" TO TXSEXO
           ELSE
             IF P-SEXO = "F" 
               MOVE "FEMININO" TO TXSEXO
             ELSE
               MOVE "SEXO => M = MASCULINO F = FEMININO" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS2
               GO TO PASSO-4.
           DISPLAY TTXSEXO.

       PASSO-5.
           ACCEPT TPGENERO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
               GO TO PASSO-4.
       
       PASSO-5-A.
           IF P-GENERO = "H"
               MOVE "HETEROSSEXUAL"              TO TXGENERO
           ELSE 
               IF P-GENERO = "B"
                   MOVE "BISSEXUAL"              TO TXGENERO
               ELSE
                  IF P-GENERO = "O"
                      MOVE "HOMOSSEXUAL"         TO TXGENERO
                  ELSE
                      IF P-GENERO = "N"
                          MOVE "NAO INFORMADO"   TO TXGENERO
                      ELSE
                          MOVE "GENERO INVALIDO" TO W-MSG
                          PERFORM ROT-MENS THRU ROT-MENS2
                          GO TO PASSO-5.
           DISPLAY TTXGENERO.

       PASSO-6.
           ACCEPT TPCONVENIO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
               GO TO PASSO-5.
           IF P-CONVENIO = ZEROS
               MOVE "*** CONVENIO NAO INFORMADO ***" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO PASSO-6.

       PASSO-6-A.
           MOVE P-CONVENIO TO CV-CODIGO.
           READ CADCONV
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "23"
                   MOVE "*** CONVENIO NAO ENCONTRADO ***" TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO PASSO-6
               ELSE
                   MOVE "ERRO NA LEITURA DO ARQUIVO CADCONV" TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
                DISPLAY SMT004.

       PASSO-7.
           ACCEPT TPCEP
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
               GO TO PASSO-6.
           IF P-CEP = ZEROS
               MOVE "*** CEP NAO INFORMADO ***" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO PASSO-7.

       PASSO-7-A.
           MOVE P-CEP TO CODIGO.
           READ CADCEP
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "23"
                   MOVE "*** CEP NAO ENCONTRADO ***" TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO PASSO-7
               ELSE
                   MOVE "ERRO NA LEITURA DO ARQUIVO CADCEP" TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS-FIM
                   GO TO ROT-FIM
           ELSE
                DISPLAY SMT004.
       
       PASSO-8.
           ACCEPT TPNUM.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-7.
           IF P-NUM-END = ZEROS
                MOVE "NUMERO INVALIDO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-8.
       
       PASSO-9.
           ACCEPT TPCOMPL.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-8.
           IF P-COMPLEM = SPACES
                MOVE "COMPLEMENTO INVALIDO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-9.
       
       PASSO-10.
           ACCEPT TPTELEFONE.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-8.
           IF P-TELEFONE = ZEROS
                MOVE "TELEFONE INVALIDO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-10.

       PASSO-11.
           ACCEPT TPEMAIL.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-9.
           IF P-EMAIL = SPACES
                MOVE "EMAIL INVALIDO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-11.
       
       
       VALID-OPCAO.
           MOVE "S" TO W-OPCAO
           DISPLAY (23, 40) "GRAVAR (S/N) : ".
           ACCEPT (23, 57) W-OPCAO WITH UPDATE
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02 GO TO PASSO-11.
           IF W-OPCAO = "N" OR W-OPCAO = "n"
              MOVE "*** REGISTRO RECUSADO PELO USUARIO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "*** DIGITE APENAS S=SIM e N=NAO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO VALID-OPCAO.
       GRAVAR-REGISTRO.
           WRITE REGPACI
           IF ST-ERRO = "00" OR "02"
               MOVE "** DADOS GRAVADOS COM SUCESSO **" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-INIC.
           IF ST-ERRO = "22"
               MOVE "*** PACIENTE JA EXISTENTE ***       " TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-INIC
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO DE PACIENTE" TO W-MSG
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
           DELETE CADPACI RECORD
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
           IF W-ACT = 02 GO TO PASSO-3.
           IF W-OPCAO = "N" OR "n"
              MOVE "* INFORMACOES NAO ALTERADAS * " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "* DIGITE APENAS S=SIM  e  N=NAO *" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ALT-OPC.
       ALT-RW1.
           REWRITE REGPACI
           IF ST-ERRO = "00" OR "02"
              MOVE "*** REGISTRO ALTERADO ***         " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           MOVE "ERRO NA EXCLUSAO DO REGISTRO CADPACI" TO W-MSG
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
           CLOSE CADCONV CADCEP CADPACI.
      *    STOP RUN.
           DISPLAY (01, 01) ERASE
           EXIT PROGRAM.
       ROT-FIMP.
           EXIT PROGRAM.
       ROT-FIMS.
           STOP RUN.