SELECT 
  RO.CD_REGISTRO_OCORRENCIA AS CD_REGISTRO,
  RO.CD_ORGANIZACAO_REGISTRANTE AS EMPRESA_REGISTRANTE, 
  CC.DS_CENTRO_CUSTO AS SETOR_REGISTRANTE, 
  P.CD_USUARIO_PORTAL AS REGISTRANTE, 
  RO.CD_ORGANIZACAO_RELATOR AS EMPRESA_RELATOR, 
  CO.DS_CENTRO_CUSTO AS SETOR_RELATOR, 
  PA.CD_USUARIO_PORTAL AS RELATOR,
  RO.CD_ATENDIMENTO,
  RO.CD_PACIENTE,
  RO.DT_REGISTRO,
  RO.DH_OCORRIDO,
  RO.HR_OCORRIDO,
  OC.CD_TIPO_OCORRENCIA AS TP_OCORRENCIA,
  OC.NM_OCORRENCIA AS DS_OCORRENCIA,
  RO.CD_OCORRENCIA,
  OC.DS_OCORRENCIA,
  RO.TP_CRITICIDADE,
  RO.CD_METODO_DETECCAO_OCORRENCIA AS CD_DETECAO, 
  MDO.DS_METODO_DETECCAO AS DS_DETECAO,
  RO.CD_ACAO_IMEDIATA_OCORRENCIA AS CD_ACAO,
  AIO.DS_ACAO_IMEDIATA,
  DECODE(RO.TP_CRITICIDADE, 1, 'NC-MAIOR', 2, 'NC-MENOR') DS_CRITICIDADE,
  DECODE (RO.SN_PROCEDE,'S','SIM','N','N�O',NULL,'EM ABERTO') SN_PROCEDE,
  RO.TP_FLUXO,
  DECODE (RO.TP_INCIDENTE,'C','CIRCUNST�NCIA DE RISCO', 'N','NEAR MISS(Quase Erro') TP_INCIDENTE,
  RO.CD_FORMULARIO,
  RO.DS_RESUMO,
  RO.DS_REGISTRO

FROM DBAPORTAL.REGISTRO_OCORRENCIA RO, DBAPORTAL.OCORRENCIA OC, DBAPORTAL.METODO_DETECCAO_OCORRENCIA MDO, DBAPORTAL.ACAO_IMEDIATA_OCORRENCIA AIO, DBAPORTAL.PESSOA P, DBAPORTAL.PESSOA PA, DBAPORTAL.CENTRO_CUSTO CC,  DBAPORTAL.CENTRO_CUSTO CO

WHERE RO.CD_OCORRENCIA = OC.CD_OCORRENCIA
AND RO.CD_METODO_DETECCAO_OCORRENCIA = MDO.CD_METODO_DETECCAO_OCORRENCIA(+)
AND RO.CD_ACAO_IMEDIATA_OCORRENCIA = AIO.CD_ACAO_IMEDIATA_OCORRENCIA(+)
AND RO.ID_USUARIO_REGISTRANTE = P.CD_PESSOA(+)
AND RO.ID_USUARIO_RELATOR = PA.CD_PESSOA(+)
AND RO.CD_CENTRO_CUSTO_REGISTRANTE = CC.CD_CENTRO_CUSTO(+)
AND RO.CD_CENTRO_CUSTO_RELATOR = CO.CD_CENTRO_CUSTO(+)

--AND RO.DT_REGISTRO BETWEEN TO_DATE ('01/01/2023','DD/MM/RRRR') AND SYSDATE + 1
--AND OC.CD_TIPO_OCORRENCIA = 101
--AND OC.CD_OCORRENCIA = 242
AND CD_REGISTRO_OCORRENCIA = 54963
ORDER BY RO.DT_REGISTRO asc
;
SELECT * FROM ALL_TAB_COLUMNS
WHERE OWNER = 'DBAPORTAL'
--AND COLUMN_NAME LIKE '%USU%'
AND TABLE_NAME LIKE '%CENTRO%'
ORDER BY 2,3
;
SELECT * FROM DBAPORTAL.CENTRO_CUSTO 
WHERE UPPER (DS_PESSOA) LIKE '%MASS%'
--AND CD_OCORRENCIA = 242
--AND CD_REGISTRO_OCORRENCIA = 54109