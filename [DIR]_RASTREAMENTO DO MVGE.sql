SELECT
CASE
          WHEN TP_SITUACAO                                                                                                                                           = 'C'
          AND NM_FLUXO_OCORRENCIA                                                                                                                                    = 'An�lise'
          AND NVL( TO_DATE(DATA_ANALISE, 'DD/MM/RRRR HH24:MI:SS'), TO_DATE(DATA_ATUAL, 'DD/MM/RRRR HH24:MI:SS') ) - TO_DATE(DATA_AVALIACAO, 'DD/MM/RRRR HH24:MI:SS') > QT_SLA
          AND DATA_ANALISE                                                                                                                                          IS NULL
          THEN 'Conclu�do'
          WHEN TP_SITUACAO                                                                                                                                           = 'C'
          AND NM_FLUXO_OCORRENCIA                                                                                                                                    = 'An�lise'
          AND NVL( TO_DATE(DATA_ANALISE, 'DD/MM/RRRR HH24:MI:SS'), TO_DATE(DATA_ATUAL, 'DD/MM/RRRR HH24:MI:SS') ) - TO_DATE(DATA_AVALIACAO, 'DD/MM/RRRR HH24:MI:SS') > QT_SLA
          THEN 'Conclu�do com atraso'
          WHEN TP_SITUACAO                                                                                                                                             = 'C'
          AND NM_FLUXO_OCORRENCIA                                                                                                                                      = 'Verifica��o'
          AND NVL( TO_DATE(DATA_VERIFICACAO, 'DD/MM/RRRR HH24:MI:SS'), TO_DATE(DATA_ATUAL, 'DD/MM/RRRR HH24:MI:SS') ) - TO_DATE(DATA_ANALISE, 'DD/MM/RRRR HH24:MI:SS') > QT_SLA
          THEN 'Conclu�do com atraso'
          WHEN TP_SITUACAO = 'C'
          THEN 'Conclu�do'
          WHEN TP_SITUACAO                                                                                                                                                    = 'D'
          AND TRUNC( NVL( TO_DATE(DATA_ANALISE, 'DD/MM/RRRR HH24:MI:SS'), TO_DATE(DATA_ATUAL, 'DD/MM/RRRR HH24:MI:SS') ) - TO_DATE(DATA_AVALIACAO, 'DD/MM/RRRR HH24:MI:SS') ) < QT_SLA
          THEN 'Dispon�vel para an�lise'
          WHEN TP_SITUACAO                                                                                                                                                    = 'D'
          AND TRUNC( NVL( TO_DATE(DATA_ANALISE, 'DD/MM/RRRR HH24:MI:SS'), TO_DATE(DATA_ATUAL, 'DD/MM/RRRR HH24:MI:SS') ) - TO_DATE(DATA_AVALIACAO, 'DD/MM/RRRR HH24:MI:SS') ) > QT_SLA
          THEN 'Atrasado'
          WHEN TP_SITUACAO = 'A'
          THEN 'Aguardando conclus�o'
          WHEN TP_SITUACAO = 'R'
          THEN 'Recusado'
          ELSE TP_SITUACAO
        END AS STATUS_SITUACAO,
        BASE.*
FROM (
SELECT 
  DECODE(FQO.TP_SITUACAO,'C','CONCLUIDO','D','ATRASADO','A','AGUARDANDO CONLUS�O','R','RECUSADO')TP_SITUACAO_ETAPA,
  FQO.TP_SITUACAO,
  HRO.TP_ACAO,
  HRO.DS_ACAO,
  FQO.CD_FLUXO_OCORRENCIA AS N2,
  RO.CD_REGISTRO_OCORRENCIA AS CD_REGISTRO,
  DENSE_RANK() OVER (PARTITION BY RO.CD_REGISTRO_OCORRENCIA ORDER BY HRO.DT_ACEITACAO DESC) AS NR_ORD,
    -- CALCULOS KAKASHI
  FQO.QT_SLA,
  TO_CHAR(SYSDATE, 'DD/MM/RRRR HH24:MI:SS') AS DATA_ATUAL,
  TRUNC (RO.DT_REGISTRO) AS DT_INTEGRA,
  RO.DT_REGISTRO,
  RO.DH_OCORRIDO,
  RO.HR_OCORRIDO,
  HRO.DT_MUDANCA_FLUXO, 
  HRO.DT_ACEITACAO,
  HRO.DS_COMENTARIO,
  FQO.DT_CONCLUSAO,
  (SELECT NVL(DATA_AVALIACAO, DATA_AVALIACAO2) AS DATA_AVALIACAO
          FROM
            (SELECT HRO2.CD_REGISTRO_OCORRENCIA,
              HRO2.DT_ACEITACAO,
              HRO2.DS_ACAO
            FROM DBAPORTAL.HISTORICO_REG_OCORRENCIA HRO2
            WHERE HRO2.CD_REGISTRO_OCORRENCIA       = RO.CD_REGISTRO_OCORRENCIA
            ) PIVOT( MAX(DT_ACEITACAO) FOR DS_ACAO IN ( 'Avalia��o conclu�da.' AS DATA_AVALIACAO, 'Avalia��o conclu�da' AS DATA_AVALIACAO2 ) )
          ) AS DATA_AVALIACAO,
          (SELECT NVL(DATA_ANALISE, DATA_ANALISE2)
          FROM
            (SELECT HRO2.CD_REGISTRO_OCORRENCIA,
              HRO2.DT_ACEITACAO,
              HRO2.DS_ACAO
            FROM DBAPORTAL.HISTORICO_REG_OCORRENCIA HRO2
            WHERE HRO2.CD_REGISTRO_OCORRENCIA       = RO.CD_REGISTRO_OCORRENCIA
            ) PIVOT( MAX(DT_ACEITACAO) FOR DS_ACAO IN ( 'An�lise conclu�da.' AS DATA_ANALISE, 'An�lise conclu�da' AS DATA_ANALISE2 ) )
          ) AS DATA_ANALISE,
          (SELECT DATA_VERIFICACAO
          FROM
            (SELECT HRO2.CD_REGISTRO_OCORRENCIA,
              HRO2.DT_ACEITACAO,
              HRO2.DS_ACAO
            FROM DBAPORTAL.HISTORICO_REG_OCORRENCIA HRO2
            WHERE HRO2.CD_REGISTRO_OCORRENCIA       = RO.CD_REGISTRO_OCORRENCIA
            ) PIVOT( MAX(DT_ACEITACAO) FOR DS_ACAO IN ('Verifica��o conclu�da.' AS DATA_VERIFICACAO) )
          ) AS DATA_VERIFICACAO,
  RO.CD_ORGANIZACAO_REGISTRANTE AS EMPRESA_REGISTRANTE, 
  (SELECT DS_CENTRO_CUSTO FROM DBAPORTAL.CENTRO_CUSTO WHERE CD_CENTRO_CUSTO = RO.CD_CENTRO_CUSTO_REGISTRANTE) AS ST_REGISTRANTE,
  (SELECT CD_USUARIO_PORTAL FROM DBAPORTAL.PESSOA WHERE CD_PESSOA = RO.ID_USUARIO_REGISTRANTE) AS DRT_REGISTRANTE,
  RO.CD_ORGANIZACAO_RELATOR AS EMPRESA_RELATOR, 
  (SELECT DS_CENTRO_CUSTO FROM DBAPORTAL.CENTRO_CUSTO WHERE CD_CENTRO_CUSTO = RO.CD_CENTRO_CUSTO_RELATOR) AS ST_RELATOR, 
  (SELECT CD_USUARIO_PORTAL FROM DBAPORTAL.PESSOA WHERE CD_PESSOA = RO.ID_USUARIO_RELATOR) AS DRT_RELATOR,
  RO.CD_ATENDIMENTO,
  RO.CD_PACIENTE,
  OC.CD_TIPO_OCORRENCIA,
  OC.NM_OCORRENCIA,
  RO.CD_OCORRENCIA,
  OC.DS_OCORRENCIA,
  RO.TP_CRITICIDADE,
  RO.CD_METODO_DETECCAO_OCORRENCIA AS CD_DETECAO, 
  MDO.DS_METODO_DETECCAO AS DS_DETECAO,
  RO.CD_ACAO_IMEDIATA_OCORRENCIA AS CD_ACAO,
  AIO.DS_ACAO_IMEDIATA,
  DECODE(RO.TP_CRITICIDADE, 1,'N�O SE APLICA',2, 'NC-MAIOR', 3, 'NC-MENOR') DS_CRITICIDADE,
  DECODE (RO.SN_PROCEDE,'S','SIM','N','N�O',NULL,'EM ABERTO') SN_PROCEDE,
  FQO.CD_FLUXO_OCORRENCIA,
  FOA.NM_FLUXO_OCORRENCIA,
  NVL (DECODE (RO.TP_INCIDENTE,'C','CIRCUNST�NCIA DE RISCO', 'N','NEAR MISS(Quase Erro',null, 'NENHUM DANO'),
  DECODE (RO.TP_GRAU_NEA, 'N', 'DANO LEVE','0','DANO MODERADO','L','EVENTO SENTINELA','M','N�O PREVEN�VEL','G','DANO GRANDE')) AS TP_INC_NEA,
  (SELECT CD_USUARIO_PORTAL FROM DBAPORTAL.PESSOA WHERE CD_PESSOA = HRO.ID_RESPONSAVEL_FLUXO)AS DRT_RESP_FLUXO,
  NVL((SELECT DS_CENTRO_CUSTO FROM DBAPORTAL.CENTRO_CUSTO WHERE CD_CENTRO_CUSTO = HRO.ID_RESPONSAVEL_FLUXO), 
  (SELECT DS_PESSOA FROM DBAPORTAL.PESSOA WHERE CD_PESSOA = HRO.ID_RESPONSAVEL_FLUXO)) AS DS_RESP_FLUXO,
  HRO.TP_ANALISE,
  NVL((SELECT DS_PAPEL FROM DBAPORTAL.VW_PAPEL WHERE CD_PAPEL = FQO.CD_PAPEL_RESP),
  (SELECT DS_CENTRO_CUSTO FROM DBAPORTAL.CENTRO_CUSTO WHERE CD_CENTRO_CUSTO = FQO.CD_CENTRO_CUSTO_RESP)) AS TP_PAPEL_RESP,
  FQO.TP_RESPONSAVEL_FLUXO,
    RO.DS_RESUMO,
    RO.DS_REGISTRO
FROM 
  DBAPORTAL.REGISTRO_OCORRENCIA RO, 
  DBAPORTAL.OCORRENCIA OC, 
  DBAPORTAL.METODO_DETECCAO_OCORRENCIA MDO, 
  DBAPORTAL.ACAO_IMEDIATA_OCORRENCIA AIO,  
  DBAPORTAL.FLUXO_OCORRENCIA FOA,
  DBAPORTAL.HISTORICO_REG_OCORRENCIA HRO,
  DBAPORTAL.FLUXO_QUADRO_OCORRENCIA FQO

WHERE RO.CD_OCORRENCIA = OC.CD_OCORRENCIA
AND RO.CD_METODO_DETECCAO_OCORRENCIA = MDO.CD_METODO_DETECCAO_OCORRENCIA(+)
AND RO.CD_ACAO_IMEDIATA_OCORRENCIA = AIO.CD_ACAO_IMEDIATA_OCORRENCIA(+)
AND HRO.CD_FLUXO_OCORRENCIA = FOA.CD_FLUXO_OCORRENCIA
AND RO.CD_REGISTRO_OCORRENCIA = HRO.CD_REGISTRO_OCORRENCIA
AND RO.CD_REGISTRO_OCORRENCIA = FQO.CD_REGISTRO_OCORRENCIA

AND RO.DT_REGISTRO BETWEEN TO_DATE ('01/01/2023','DD/MM/RRRR') AND SYSDATE
--AND TP_ACAO NOT IN ('V')
--AND RO.CD_REGISTRO_OCORRENCIA = 32076
--AND OC.CD_TIPO_OCORRENCIA = 101
--AND OC.CD_OCORRENCIA = 242
--AND HRO.CD_FLUXO_OCORRENCIA = 3
AND RO.CD_REGISTRO_OCORRENCIA IN (56158,55434) --54484--54041--54588 --55919--32076
/*
CASE 
  WHEN TP_ACAO = 1 AND NR_ORD = 1 THEN 'FINALIZADA'
  WHEN TP_ACAO = 4 AND NR_ORD = 1 THEN 'ARQUIVADA'
  WHEN 
*/
--AND HRO.CD_FLUXO_OCORRENCIA IN (2,3)
ORDER BY RO.DT_REGISTRO ASC,HRO.CD_FLUXO_OCORRENCIA DESC,NR_ORD
)BASE
GROUP BY 
TP_SITUACAO_ETAPA, TP_SITUACAO, TP_ACAO, DS_ACAO, N2, CD_REGISTRO, NR_ORD, QT_SLA, DATA_ATUAL, DT_INTEGRA, DT_REGISTRO, DH_OCORRIDO, HR_OCORRIDO, DT_MUDANCA_FLUXO, 
DT_ACEITACAO, DS_COMENTARIO, DT_CONCLUSAO, DATA_AVALIACAO, DATA_ANALISE, DATA_VERIFICACAO, EMPRESA_REGISTRANTE, ST_REGISTRANTE, DRT_REGISTRANTE, EMPRESA_RELATOR, ST_RELATOR, DRT_RELATOR, 
CD_ATENDIMENTO, CD_PACIENTE, CD_TIPO_OCORRENCIA, NM_OCORRENCIA, CD_OCORRENCIA, DS_OCORRENCIA, TP_CRITICIDADE, CD_DETECAO, DS_DETECAO, CD_ACAO, DS_ACAO_IMEDIATA, DS_CRITICIDADE, SN_PROCEDE, 
CD_FLUXO_OCORRENCIA, NM_FLUXO_OCORRENCIA, TP_INC_NEA, DRT_RESP_FLUXO, DS_RESP_FLUXO, TP_ANALISE, TP_PAPEL_RESP, TP_RESPONSAVEL_FLUXO, DS_RESUMO, DS_REGISTRO
;
SELECT * FROM ALL_TAB_COLUMNS
WHERE OWNER = 'DBAPORTAL'
AND COLUMN_NAME LIKE '%DT_%'
--AND TABLE_NAME LIKE '%HIST%'
ORDER BY 2,3
;

SELECT DT_REGISTRO,DH_OCORRIDO FROM DBAPORTAL.REGISTRO_OCORRENCIA
where 
--tp_fluxo = 3
CD_REGISTRO_OCORRENCIA = 55346
order by 1 desc
;
--DECODE(TP_SITUACAO,'C','CONCLUIDO','D','DISPON�VEL','A','ABERTA','R','REVISADA')
SELECT * FROM DBAPORTAL.FLUXO_QUADRO_OCORRENCIA
WHERE 
--TP_SITUACAO NOT IN ('C','D','A','R')
CD_REGISTRO_OCORRENCIA = 55346
ORDER BY 1 DESC
;
SELECT CD_FLUXO_QUADRO_OCORRENCIA, CD_REGISTRO_OCORRENCIA, CD_FLUXO_OCORRENCIA, TP_SITUACAO, CD_PAPEL_RESP, CD_CENTRO_CUSTO_RESP, TP_RESPONSAVEL_FLUXO, DT_CONCLUSAO, DT_ACEITACAO, QT_SLA, NR_ORDENACAO 
FROM DBAPORTAL.FLUXO_QUADRO_OCORRENCIA
WHERE CD_REGISTRO_OCORRENCIA IN (56158,55434)
ORDER BY CD_FLUXO_OCORRENCIA DESC
;
SELECT * FROM DBAPORTAL.FLUXO_OCORRENCIA
--CD_PENDENCIA - DBAPORTAL.PENDENCIA