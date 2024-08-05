SELECT * FROM DBAMV.AVISO_CIRURGIA WHERE CD_AVISO_CIRURGIA = 151261
;
SELECT * FROM ALL_COL_COMMENTS 
WHERE OWNER LIKE '%DBAMV'
AND TABLE_NAME = 'IT_GUIA' 
--COLUMN_NAME = 'AUDIT_TP_REGISTRO'
ORDER BY OWNER, TABLE_NAME, COLUMN_NAME
;
SELECT 
  AG.AUDIT_DT_REGISTRO,
  DECODE (AG.AUDIT_TP_ACAO,'I','INSERT','A','UPDATE') AS AUDIT_TP_ACAO,
  DECODE (AG.AUDIT_TP_REGISTRO,'N','NOVA','A','ALTERA��O') AS AUDIT_TP_REGISTRO,
  AG.AUDIT_CD_MODULO,
  AG.AUDIT_CD_USUARIO,
  G.CD_GUIA,
  IG.CD_IT_GUIA,--C�digo sequencial do item da guia
  G.NR_GUIA,
  IG.CD_PRO_FAT,--C�digo do procedimento (pode ser nulo se a guia for de OPME)
  IG.CD_SETOR, --Setor de origem do Lan�amento autom�tico.
  DECODE (G.TP_GUIA,'I','INTERNA��O','O','OPME') AS TP_GUIA,
  IG.CD_USU_GERACAO AS CD_OPERADOR,--C�digo do usu�rio que criou esta linha de �tem.
  IG.DS_OBSERVACAO AS DS_OBS_ITEM,--Observa��o ref ao item
  IG.DS_PROCEDIMENTO, --Descri��o alternativa de procedimentos (para casos de pro_fat n�o cadastrados).
  IG.DT_GERACAO AS DT_CRIA_ITEM, --Data da Gera��o do Registro
  IG.DT_AUTORIZOU AS DT_AUT_ITEM,--Data de autoriza��o do item da guia.
  IG.DT_NEGACAO AS DT_NEG_ITEM,--Data de nega��o do item
  IG.NM_USUARIO_NEGACAO AS NM_USU_ITEMNEG,--Usu�rio da nega��o do item
  IG.QT_AUTORIZADO AS NR_SOLICITADO, --Quantidade Solicitada ao conv�nio, para autoriza��o.
  IG.QT_AUTORIZADA_CONVENIO AS NR_AUT_CONVENIO, --Quantidade Total Autorizada pelo Conv�nio.
  IG.QT_UTILIZADA AS NR_UTILIZADOS, --Quantidade realmente utilizada pelo Paciente.
  IG.TP_PRE_POS_CIRURGICO, --Indica se o procedimento foi solicitado no Pr� ou P�s cir�rgico (apenas guias de OPME)
  IG.CD_MVTO, --C�digo da movimenta��o de Lan�amento autom�tico.
  G.CD_ATENDIMENTO,
  G.CD_PACIENTE,
  G.CD_CONVENIO,
  G.DT_SOLICITACAO,
  G.DT_AUTORIZACAO,
  G.NR_DIAS_SOLICITADOS,
  G.NR_DIAS_AUTORIZADOS,
  G.CD_SENHA,
  G.CD_SENHA_OLD, --Informa��o anterior que foi limpa porque a validade da senha venceu.
  G.DS_OBSERVACAO,
  G.CD_RES_LEI,
  G.DT_GERACAO,
  G.CD_AVISO_CIRURGIA,
  G.NM_AUTORIZADOR_CONV, --Nome do funcion�rio do conv�nio que autorizou a guia.
  G.NM_USUARIO_AUTORIZOU_LOCAL, --Usu�rio que autorizou localmente a Guia (pr�_autoriza��o)
  G.NM_USUARIO_NEGACAO,
  G.NM_USUARIO_RESP, --Usu�rio respons�vel pela guia, na nova tela de Guias do Atendimento.
  G.SN_ALTERADA, --Identifica se os itens da guia sofreram alteracoes devido a altercao no agendamento cirurgico
  DECODE (G.TP_SITUACAO,'P','PENDENTE','A','AUTIRIZADO','N','NEGADO','G','NEGOCIA��O') AS TP_SITUACAO
FROM 
  DBAMV.GUIA G,
  AUDIT_DBAMV.GUIA AG,
  DBAMV.IT_GUIA IG,
  AUDIT_DBAMV.IT_GUIA AIG
  
WHERE G.CD_GUIA = AG.CD_GUIA
AND IG.CD_GUIA = AG.CD_GUIA
AND IG.CD_IT_GUIA = AIG.CD_IT_GUIA

AND G.CD_AVISO_CIRURGIA = 151261
AND TRUNC(AG.AUDIT_DT_REGISTRO) = '20/02/2024'

ORDER BY 1, CD_GUIA
;
SELECT * FROM AUDIT_DBAMV.IT_GUIA
WHERE CD_GUIA IN (3721656,3721651)
AND TRUNC(AUDIT_DT_REGISTRO) = '20/02/2024'
ORDER BY 1
