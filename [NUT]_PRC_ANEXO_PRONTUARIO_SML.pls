PROMPT CREATE OR REPLACE PROCEDURE mvapi.prc_anexo_prontuario
CREATE OR REPLACE PROCEDURE mvapi.prc_anexo_prontuario (
	pPaciente NUMBER,
	pAtendimento NUMBER,
	pUsuario VARCHAR2,
	pArquivoBlob BLOB,
	pArquivoNome VARCHAR2,
	pArquivoExtensao VARCHAR2
)
IS
   CURSOR c_sequence
   IS
      SELECT dbamv.seq_pw_documento_clinico.NEXTVAL
        FROM DUAL;

   CURSOR c_tipo
   IS
      SELECT cd_tipo_documento
        FROM dbamv.pw_tipo_documento
       WHERE tp_documento = 'ANEXO'
         AND ROWNUM = 1;

   CURSOR c_objeto (ptipo NUMBER)
   IS
      SELECT cd_objeto
        FROM dbamv.pagu_objeto
       WHERE cd_tipo_documento = ptipo
         AND cd_objeto = 594;

   CURSOR c_status
   IS
      SELECT cd_status_arquivo_atendimento
        FROM dbamv.status_arquivo_atendimento
       WHERE sn_padrao = 'S'
         AND sn_ativo = 'S'
         AND ROWNUM = 1;

	CURSOR c_atendimento (p_cd_atendimento NUMBER) -- CURSOR VALIDA ATENDIMENTO
	IS
		SELECT  *
		  FROM   dbamv.atendime
		WHERE dbamv.atendime.cd_atendimento = p_cd_atendimento;

   CURSOR c_sequence_arquivo
   IS
      SELECT dbamv.seq_arquivo_documento.NEXTVAL
        FROM DUAL;
    CURSOR c_cd_prestador
    IS
        SELECT P.CD_PRESTADOR
        FROM DBASGU.USUARIOS U,
        DBAMV.PRESTADOR P
        WHERE P.CD_PRESTADOR = U.CD_PRESTADOR
        AND U.CD_USUARIO = pUsuario;

   vblob                            dbamv.arquivo_documento%ROWTYPE;
   blobber                          CLOB;
   vcd_tipo_documento               dbamv.pw_tipo_documento.cd_tipo_documento%TYPE;
   vcd_objeto                       dbamv.pagu_objeto.cd_objeto%TYPE;
   vcd_documento_clinico            dbamv.pw_documento_clinico.cd_documento_clinico%TYPE;
   vcd_status_arquivo_atendimento   dbamv.status_arquivo_atendimento.cd_status_arquivo_atendimento%TYPE;
   vcd_arquivo_documento            dbamv.arquivo_documento.cd_arquivo_documento%TYPE;
   vcd_atendimento                  dbamv.atendime%ROWTYPE;
   v_cd_prestador 					dbamv.prestador.cd_prestador%TYPE;

BEGIN

   OPEN c_atendimento (pAtendimento);
   FETCH c_atendimento
    INTO vcd_atendimento;
   IF c_atendimento%NotFound Then
          CLOSE c_atendimento;
         Raise_Application_Error(-20001,'#ERRO: O ATENDIMENTO N?O FOI ENCONTRADO:[' ||pAtendimento||'].');
      END IF;


   OPEN c_sequence;

   FETCH c_sequence
    INTO vcd_documento_clinico;

   CLOSE c_sequence;

   OPEN c_tipo;

   FETCH c_tipo
    INTO vcd_tipo_documento;

   CLOSE c_tipo;

   OPEN c_objeto (vcd_tipo_documento);

   FETCH c_objeto
    INTO vcd_objeto;

   CLOSE c_objeto;

   OPEN c_cd_prestador;
    FETCH c_cd_prestador INTO v_cd_prestador;
    CLOSE c_cd_prestador;

   INSERT INTO dbamv.pw_documento_clinico
               (cd_documento_clinico,
                cd_tipo_documento,
                cd_paciente,
                cd_atendimento,
                cd_usuario,
                tp_status,
                dh_referencia,
                dh_criacao,
                tp_extensao,
                cd_objeto,
                dh_documento,
                nm_documento,
                CD_PRESTADOR -- ADICIONADO POR JO?O DANIEL
               )
        VALUES (vcd_documento_clinico,
                vcd_tipo_documento,
                pPaciente,
                pAtendimento,
                pUsuario,
                'FECHADO',
                SYSDATE,
                SYSDATE,
                'PDF_ANEXO',
                vcd_objeto,
                SYSDATE,
                pArquivoNome,
                v_cd_prestador -- ADICIONADO POR JO?O DANIEL --alterado por CAIO
               );

   OPEN c_sequence_arquivo;

   FETCH c_sequence_arquivo
    INTO vcd_arquivo_documento;

   CLOSE c_sequence_arquivo;

   --btgb
   --vBlob.LO_ARQUIVO_DOCUMENTO := mvapi.base64decode(pArquivoBlob);


   INSERT INTO dbamv.arquivo_documento
               (cd_arquivo_documento,
                lo_arquivo_documento,
                tp_extensao,
                ds_nome_arquivo,
                DT_DOCUMENTO -- ADICIONADO POR JO?O DANIEL
               )
        VALUES (vcd_arquivo_documento,
                pArquivoBlob,--vBlob.LO_ARQUIVO_DOCUMENTO,--btgbpArquivoBlob,
                pArquivoExtensao,
                pArquivoNome,
                SYSDATE -- ADICIONADO POR JO?O DANIEL
               );

   --vBlob.LO_ARQUIVO_DOCUMENTO := mvintegra.base64decode(pParametroBlob);
   OPEN c_status;

   FETCH c_status
    INTO vcd_status_arquivo_atendimento;

   CLOSE c_status;

   INSERT INTO dbamv.arquivo_atendimento
               (cd_arquivo_atendimento,
                cd_arquivo_documento,
                cd_atendimento,
                dh_criacao,
                nm_usuario,
                cd_paciente,
                cd_pw_tipo_documento,
                cd_documento_clinico,
                cd_status_arquivo_atendimento,
                CD_OBJETO_SELECIONADO -- ADICIONADO POR JO?O DANIEL
               )
        VALUES (dbamv.seq_arquivo_atendimento.NEXTVAL,
                vcd_arquivo_documento,
                pAtendimento,
                SYSDATE,
                pUsuario,
                pPaciente,
                vcd_tipo_documento,
                vcd_documento_clinico,
                vcd_status_arquivo_atendimento,
                vcd_objeto -- ADICIONADO POR JO?O DANIEL
               );
END;
/

