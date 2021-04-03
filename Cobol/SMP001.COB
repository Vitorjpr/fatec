       IDENTIFICATION DIVISION.
       PROGRAM-ID.               SMP001.
       AUTHOR.                   VITOR JOSE PAZ RODRIGUES.
      *RA:                       1110481913003 
      ********************************************************
      *               CADASTRO DE MEDICOS                    *
      *            DATA CRIACAO : 23/09/2020                 *
      ********************************************************
      *----------------------------------------------------------------
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
       01 TXESPEC                PIC X(20) VALUE SPACES.
       01 MENSAGEM.
            03 MENSAGEM1         PIC X(30) VALUE SPACES.
            03 CODIGO            PIC 9(02) VALUE ZEROS.
      *-----------------------------------------------------------------
       SCREEN SECTION.
       01  SMT001.
           05  BLANK SCREEN.
           05  LINE 03  COLUMN 01 
               VALUE  "                         *** CADASTRO DE".
           05  LINE 03  COLUMN 41 
               VALUE  " MEDICOS ***".

           05  LINE 06  COLUMN 01 
               VALUE  "     CRM             :".

           05  LINE 08  COLUMN 01 
               VALUE  "     NOME            :".

           05  LINE 10  COLUMN 01 
               VALUE  "     ESPECIALIDADE   :".

           05  LINE 12  COLUMN 01 
               VALUE  "     SEXO            :".

           05  LINE 14  COLUMN 01 
               VALUE  "     DATA NASCIMENTO :".

           05  LINE 16  COLUMN 01 
               VALUE  "     EMAIL           :".

           05  LINE 18  COLUMN 01 
               VALUE  "     TELEFONE        :".

           05  LINE 23  COLUMN 01 
               VALUE  " MENSAGEM :".

           05  TCRM
               LINE 06  COLUMN 24  PIC Z99.999
               USING  CRM
               HIGHLIGHT.

           05  TNOME
               LINE 08  COLUMN 24  PIC X(30)
               USING  NOME
               HIGHLIGHT.

           05  TESPEC
               LINE 10  COLUMN 24  PIC 99
               USING  ESPEC
               HIGHLIGHT.

           05  TTXESPC
               LINE 10  COLUMN 27  PIC X(20)
               USING  TXESPEC
               HIGHLIGHT.

           05  TSEXO
               LINE 12  COLUMN 24  PIC X(01)
               USING  SEXO
               HIGHLIGHT.

           05  TTXSEXO
               LINE 12  COLUMN 26  PIC X(12)
               USING  TXSEXO
               HIGHLIGHT.

           05  TDATANASC
               LINE 14  COLUMN 24  PIC 99.99.9999
               USING  DATANASC
               HIGHLIGHT.
           
           05  TEMAIL
               LINE 16  COLUMN 24  PIC X(30)
               USING  EMAIL
               HIGHLIGHT.

           05  TTELEFONE
               LINE 18  COLUMN 24  PIC 99.99999.9999
               USING  TELEFONE
               HIGHLIGHT.
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
       INICIO.
      *------------[ ROTINA DE ABERTURA ARQUIVO ]------------------
       ABRIR-ARQ.
           OPEN I-O CADMED
           IF ST-ERRO NOT = "00"
               IF ST-ERRO = "30"
                   OPEN OUTPUT CADMED
                   CLOSE CADMED
                   GO TO ABRIR-ARQ
               ELSE
                   MOVE "ERRO NA ABERTURA ARQUIVO = " TO MENSAGEM1 
                   MOVE ST-ERRO TO CODIGO
                   MOVE MENSAGEM  TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO ROT-FIM.
      *--------------------[ INICIALIAR VARIAVEIS ]-----------------
       ROT-INIC.
           MOVE 0 TO CRM DATANASC ESPEC DIA MES 
                     ANO TELEFONE.

           MOVE SPACES TO NOME SEXO TXSEXO TXESPEC EMAIL.
      *--------------------[ VISUALIZAR TELA INICIAL ]-----------------
       PASSO-0.
           DISPLAY SMT001.
      *--------------------[ DIGITAR CAMPO CHAVE  ]-----------------
       PASSO-1.
           ACCEPT TCRM
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   CLOSE CADMED
                   GO TO ROT-FIM.
           IF CRM = ZEROS
                MOVE "NUMERO DE CRM INVALIDO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-1.
      *--------------------[ LER CAMPO  CHAVE  ]-----------------
       LER-ARQ. 
           READ CADMED
           IF ST-ERRO NOT = "23"
               IF ST-ERRO = "00"
                   PERFORM PASSO-3-A
                   PERFORM PASSO-4-A
                   DISPLAY SMT001
                   MOVE "*** MEDICO JA CADASTRADO ***"   TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   MOVE "I" TO W-SEL
                   GO TO ACE-001
               ELSE
                   MOVE "ERRO NA LEITURA ARQUIVO CADMED"   TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO ROT-FIM
           ELSE
               MOVE "*** MEDICO NAO ESTA CADASTRADO ***" TO W-MSG 
               PERFORM ROT-MENS THRU ROT-MENS2.
       PASSO-2.
           ACCEPT TNOME.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-1.
           IF NOME = SPACES
                MOVE "NOME NAO PODE FICAR EM BRANCO" TO W-MSG
                PERFORM ROT-MENS THRU ROT-MENS2
                GO TO PASSO-2.
       PASSO-3.
           ACCEPT TESPEC.
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-2.
       PASSO-3-A.
           IF ESPEC = 01 
             MOVE "CLINICA MEDICA" TO TXESPEC
           ELSE
             IF ESPEC = 02 
               MOVE "UROLOGIA" TO TXESPEC
             ELSE
               IF ESPEC = 03 
                 MOVE "GINECOLOGIA" TO TXESPEC
               ELSE
                 IF ESPEC = 04 
                   MOVE "PEDIATRIA" TO TXESPEC
                 ELSE
                   IF ESPEC = 05 
                     MOVE "CARDIOLOGIA" TO TXESPEC
                   ELSE 
                     IF ESPEC = 06
                       MOVE "NUTROLOGO" TO TXESPEC
                     ELSE 
                       IF ESPEC = 07 
                         MOVE "PSICOLOGO" TO TXESPEC
                       ELSE 
                         IF ESPEC = 08 
                           MOVE "DENTISTA" TO TXESPEC
                         ELSE
                           IF ESPEC = 09 
                             MOVE "ENDOCRINOLOGIA" TO TXESPEC
                           ELSE
                             MOVE "ESPECIALIDADE NAO EXISTE" TO W-MSG
                             PERFORM ROT-MENS THRU ROT-MENS2
                             GO TO PASSO-3.

           DISPLAY TTXESPC.
       PASSO-4.
           ACCEPT TSEXO
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
                   GO TO PASSO-3.
       PASSO-4-A.
           IF SEXO = "M" 
             MOVE "MASCULINO" TO TXSEXO
           ELSE
             IF SEXO = "F" 
               MOVE "FEMININO " TO TXSEXO
             ELSE
               MOVE "SEXO => M = MASCULINO F = FEMININO" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS2
               GO TO PASSO-4.
           DISPLAY TTXSEXO.
       PASSO-5.
           ACCEPT TDATANASC
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
             GO TO PASSO-4.
           IF DATANASC = ZEROS
             MOVE "DATA DE NASCIMENTO INVALIDA" TO W-MSG
             PERFORM ROT-MENS THRU ROT-MENS2
             GO TO PASSO-5
           ELSE
             IF DIA < 01 OR DIA > 31
               MOVE "DIA INVALIDO. DIGITE NOVAMENTE" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS2
               GO TO PASSO-5
             ELSE
               IF MES < 01 OR MES > 12
                 MOVE "MES INVALIDO. DIGITE NOVAMENTE" TO W-MSG
                 PERFORM ROT-MENS THRU ROT-MENS2
                 GO TO PASSO-5
               ELSE
                 IF ANO < 1940 OR ANO > 2002
                   MOVE "ANO INVALIDO. DIGITE NOVAMENTE" TO W-MSG
                   PERFORM ROT-MENS THRU ROT-MENS2
                   GO TO PASSO-5.

       PASSO-6.
           ACCEPT TEMAIL
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
             GO TO PASSO-5.
           IF EMAIL = SPACES
             MOVE "EMAIL NAO PODE ESTAR VAZIO" TO W-MSG
             PERFORM ROT-MENS THRU ROT-MENS2
             GO TO PASSO-6.
           
           IF W-SEL = "A"
               GO TO ALT-OPC.

       PASSO-7.
           ACCEPT TTELEFONE
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 01
             GO TO PASSO-6.
           IF TELEFONE = ZEROS
             MOVE "TELEFONE NAO PODE ESTAR VAZIO" TO W-MSG
             PERFORM ROT-MENS THRU ROT-MENS2
             GO TO PASSO-7.
           
           IF W-SEL = "A"
               GO TO ALT-OPC.

       VALID-OPCAO.
           MOVE "S" TO W-OPCAO
           DISPLAY (23, 40) "GRAVAR (S/N) : ".
           ACCEPT (23, 57) W-OPCAO WITH UPDATE
           ACCEPT W-ACT FROM ESCAPE KEY
           IF W-ACT = 02 GO TO PASSO-4.
           IF W-OPCAO = "N" OR W-OPCAO = "n"
              MOVE "*** REGISTRO RECUSADO PELO USUARIO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "*** DIGITE APENAS S=SIM e N=NAO ***" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO VALID-OPCAO.
       GRAVAR-REGISTRO.
           WRITE REGMED
           IF ST-ERRO = "00" OR "02"
               MOVE "** DADOS GRAVADOS COM SUCESSO **" TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-INIC.
           IF ST-ERRO = "22"
               MOVE "*** NOTA JA EXISTENTE ***       " TO W-MSG
               PERFORM ROT-MENS THRU ROT-MENS-FIM
               GO TO ROT-INIC
           ELSE
               MOVE "ERRO NA GRAVACAO DO ARQUIVO DE MEDICO" TO W-MSG
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
           DELETE CADMED RECORD
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
           IF W-ACT = 02 GO TO PASSO-4.
           IF W-OPCAO = "N" OR "n"
              MOVE "* INFORMACOES NAO ALTERADAS * " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           IF W-OPCAO NOT = "S" AND "s"
              MOVE "* DIGITE APENAS S=SIM  e  N=NAO *" TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ALT-OPC.
       ALT-RW1.
           REWRITE REGMED
           IF ST-ERRO = "00" OR "02"
              MOVE "*** REGISTRO ALTERADO ***         " TO W-MSG
              PERFORM ROT-MENS THRU ROT-MENS-FIM
              GO TO ROT-INIC.
           MOVE "ERRO NA EXCLUSAO DO REGISTRO MEDICO" TO W-MSG
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
           DISPLAY (01, 01) ERASE
           EXIT PROGRAM.
       ROT-FIMP.
           EXIT PROGRAM.
       ROT-FIMS.
           STOP RUN.