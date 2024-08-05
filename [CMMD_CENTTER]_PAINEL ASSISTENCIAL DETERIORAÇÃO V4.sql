/*Query realizada por Massáro Júnio - 26521 com base no painel de Gestão Deteriorização Clínica*/
SELECT 
/*PCP.CD_ALERTA_PROTOCOLO
,*/PAP.DS_ALERTA_PROTOCOLO
--,PCP.CD_ETAPA_PROTOCOLO
,PEP.DS_ETAPA
,PCP.CD_ATENDIMENTO
,PCP.CD_PACIENTE
,PAC.NM_PACIENTE
,FN_IDADE(PAC.DT_NASCIMENTO, 'a') as Idade
,UNI.DS_UNID_INT
,LEI.DS_LEITO
,CON.NM_CONVENIO
--,PPEP.CD_DOCUMENTO --Validar qual o documento de entrada utilizado para sinalizar a entrada do protocolo
,SCOR.DS_RESPOSTA AS SCORE_NEWS --Verificado o ultimo score realizado para o paciente nas ultimas 24hrs
,SUBSTR (SCOR.DS_RESPOSTA, INSTR(SCOR.DS_RESPOSTA,'-',1,1)+2) DS_SCOR
,SCOR.DH_FECHAMENTO AS DT_ULTIMO_SCORE --Verificado o ultimo score realizado para o paciente nas ultimas 24hrs
,ROUND (((SYSDATE - SCOR.DH_FECHAMENTO) * 1440),0) AS TMP_ULTIMO_SCORE
,TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((SYSDATE-SCOR.DH_FECHAMENTO)*24*60),0), 'MINUTE'), 'HH24:MI') AS HM_TMP_ULTIMO_SCORE
,ENTRADA.DH_FECHAMENTO AS ENTRADA_DETERIORACAO --Verificado o ultimo documento 1921 que foi preenchido para o paciente
,CASE WHEN ENTRADA.DH_FECHAMENTO IS NULL THEN ROUND (((SYSDATE - NVL (ENTRADA.DH_FECHAMENTO,SCOR.DH_FECHAMENTO)) * 1440),0) ELSE 0 END AS TMP_ENTRADA_DETERIORACAO
,TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND (((SYSDATE - NVL (ENTRADA.DH_FECHAMENTO,SCOR.DH_FECHAMENTO)) * 1440),0), 'MINUTE'), 'HH24:MI') AS HM_TMP_ENT_DETERIORA
,DECODE(ENTRADA.DS_RESPOSTA,'true','SIM','false','NÃO') AS DS_RESP_ENTRADA /*Utilizado para validar se a última resposta registrada da enfermagem foi SIM*/
,SAIDA.DH_FECHAMENTO AS SAIDA_DETERIORACAO
--,MAX(PECP.DS_OBSERVACAO) AS DS_OBSERVACAO
--,MAX(PECP.DT_INICIO) AS DT_INICIO_EVOLUC --QUANDO FOI INICIADO A ULTIMA EVOLUÇÃO DO PROTOCOLO
--,MAX(PECP.DT_FIM) AS DT_FINAL_EVOLUC --QUANDO FOI FINALIZADO A ULTIMA EVOLUÇÃO DO PROTOCOLO


FROM 
  DBAMV.PW_CASO_PROTOCOLO PCP
  ,DBAMV.PW_ALERTA_PROTOCOLO PAP
  ,DBAMV.PW_ETAPA_PROTOCOLO PEP
  ,DBAMV.PW_PONTO_ENTRADA_PROTOCOLO PPEP
  ,DBAMV.PW_EVOLUCAO_CASO_PROTOCOLO PECP
  ,DBAMV.ATENDIME ATE
  ,DBAMV.PACIENTE PAC
  ,DBAMV.LEITO LEI
  ,DBAMV.UNID_INT UNI
  ,DBAMV.CONVENIO CON

  ,(
    SELECT * FROM(
                  SELECT
                      PDC.CD_ATENDIMENTO,
                      PDC.DH_FECHAMENTO,
                      Dbms_Lob.SubStr(Erc.Lo_Valor, 4000) AS DS_RESPOSTA,--VALIDAÇÃO DE RESPOSTA UTILIZANDO O MAX NO LUGAR DO DENSE RANK - REALIZADO POR 26521
                      Dense_Rank() OVER(PARTITION BY ate.cd_atendimento ORDER BY pec.cd_editor_registro DESC) ordem
                  FROM
                      Dbamv.Pw_Documento_Clinico Pdc,
                      Dbamv.Pw_Editor_Clinico Pec,
                      Dbamv.Editor_Registro_Campo Erc,
                      Dbamv.Atendime Ate,
                      Dbamv.Editor_Campo Ecp,
                      Dbamv.Editor_Campo Epa,
                      Dbamv.Editor_Documento Doc,
                      Dbamv.Paciente Pac
                  
                  WHERE
                      Pec.Cd_Documento_Clinico = Pdc.Cd_Documento_Clinico
                      AND Erc.Cd_Registro = Pec.Cd_Editor_Registro
                      AND Pdc.Cd_Atendimento = Ate.Cd_Atendimento
                      AND Ecp.Cd_Campo = Erc.Cd_campo
                      AND Ecp.Cd_Metadado = Epa.Cd_Campo
                      AND Pec.Cd_Documento = Doc.Cd_Documento
                      AND Ate.Cd_Paciente = Pac.Cd_Paciente
                      
                      AND Pec.Cd_Documento = 1296
                      AND Pdc.Tp_Status = 'FECHADO'
                      AND Ecp.Ds_Identificador IN ('VALOR_DETERIORIZACAO_8')
                      AND PDC.DH_FECHAMENTO >= TRUNC(SYSDATE-1)
                      --AND PDC.CD_ATENDIMENTO = 4591395
                      
                      ORDER BY pec.cd_editor_registro DESC
                  )score_news
                  WHERE ORDEM = 1
            ) SCOR 
  ,(
    SELECT * FROM(
                  SELECT
                      PDC.CD_ATENDIMENTO,
                      PDC.DH_FECHAMENTO,
                      Dbms_Lob.SubStr(Erc.Lo_Valor, 4000) AS DS_RESPOSTA,--VALIDAÇÃO DE RESPOSTA UTILIZANDO O MAX NO LUGAR DO DENSE RANK - REALIZADO POR 26521
                      Dense_Rank() OVER(PARTITION BY ate.cd_atendimento ORDER BY pec.cd_editor_registro DESC) ordem
                  FROM
                      Dbamv.Pw_Documento_Clinico Pdc,
                      Dbamv.Pw_Editor_Clinico Pec,
                      Dbamv.Editor_Registro_Campo Erc,
                      Dbamv.Atendime Ate,
                      Dbamv.Editor_Campo Ecp,
                      Dbamv.Editor_Campo Epa,
                      Dbamv.Editor_Documento Doc,
                      Dbamv.Paciente Pac
                  
                  WHERE
                      Pec.Cd_Documento_Clinico = Pdc.Cd_Documento_Clinico
                      AND Erc.Cd_Registro = Pec.Cd_Editor_Registro
                      AND Pdc.Cd_Atendimento = Ate.Cd_Atendimento
                      AND Ecp.Cd_Campo = Erc.Cd_campo
                      AND Ecp.Cd_Metadado = Epa.Cd_Campo
                      AND Pec.Cd_Documento = Doc.Cd_Documento
                      AND Ate.Cd_Paciente = Pac.Cd_Paciente
                      
                      AND Pec.Cd_Documento = 1291
                      AND Pdc.Tp_Status = 'FECHADO'
                      AND Ecp.Ds_Identificador IN ('Metadado_P_368218_1')
                      --AND PDC.DH_FECHAMENTO >= TRUNC(SYSDATE-1)
                      --AND PDC.CD_ATENDIMENTO = 4591395
                      
                      ORDER BY pec.cd_editor_registro DESC
                  )score_news
                  WHERE ORDEM = 1
            )ENTRADA
  ,(
    SELECT * FROM(
                  SELECT
                      PDC.CD_ATENDIMENTO,
                      PDC.DH_FECHAMENTO,
                      Dbms_Lob.SubStr(Erc.Lo_Valor, 4000) AS DS_RESPOSTA,--VALIDAÇÃO DE RESPOSTA UTILIZANDO O MAX NO LUGAR DO DENSE RANK - REALIZADO POR 26521
                      Dense_Rank() OVER(PARTITION BY ate.cd_atendimento ORDER BY pec.cd_editor_registro DESC) ordem
                  FROM
                      Dbamv.Pw_Documento_Clinico Pdc,
                      Dbamv.Pw_Editor_Clinico Pec,
                      Dbamv.Editor_Registro_Campo Erc,
                      Dbamv.Atendime Ate,
                      Dbamv.Editor_Campo Ecp,
                      Dbamv.Editor_Campo Epa,
                      Dbamv.Editor_Documento Doc,
                      Dbamv.Paciente Pac
                  
                  WHERE
                      Pec.Cd_Documento_Clinico = Pdc.Cd_Documento_Clinico
                      AND Erc.Cd_Registro = Pec.Cd_Editor_Registro
                      AND Pdc.Cd_Atendimento = Ate.Cd_Atendimento
                      AND Ecp.Cd_Campo = Erc.Cd_campo
                      AND Ecp.Cd_Metadado = Epa.Cd_Campo
                      AND Pec.Cd_Documento = Doc.Cd_Documento
                      AND Ate.Cd_Paciente = Pac.Cd_Paciente
                      
                      AND Pec.Cd_Documento = 1296
                      AND Pdc.Tp_Status = 'FECHADO'
                      AND Ecp.Ds_Identificador IN ('Metadado_P_368239_1')
                      AND PDC.DH_FECHAMENTO >= SYSDATE - INTERVAL '1' DAY
                      --AND PDC.CD_ATENDIMENTO = 4591395
                      
                      ORDER BY pec.cd_editor_registro DESC
                  )score_news
                  WHERE ORDEM = 1
            )SAIDA
  
  /*RELACIONAMENTOS*/
  WHERE PCP.CD_ALERTA_PROTOCOLO = PAP.CD_ALERTA_PROTOCOLO
  AND PEP.CD_ETAPA_PROTOCOLO = PCP.CD_ETAPA_PROTOCOLO
  AND PPEP.CD_ALERTA_PROTOCOLO = PCP.CD_ALERTA_PROTOCOLO
  AND PECP.CD_CASO_PROTOCOLO  = PCP.CD_CASO_PROTOCOLO
  AND PCP.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO
  AND SCOR.CD_ATENDIMENTO(+) = PCP.CD_ATENDIMENTO
  AND ENTRADA.CD_ATENDIMENTO(+) = PCP.CD_ATENDIMENTO
  AND SAIDA.CD_ATENDIMENTO(+) = PCP.CD_ATENDIMENTO
  AND PCP.CD_PACIENTE = PAC.CD_PACIENTE
  AND LEI.CD_LEITO = ATE.CD_LEITO
  AND LEI.CD_UNID_INT = UNI.CD_UNID_INT
  AND CON.CD_CONVENIO = ATE.CD_CONVENIO 

  
  
  AND PCP.CD_ALERTA_PROTOCOLO = 134
  AND PCP.CD_ETAPA_PROTOCOLO NOT IN (5)
  --AND PCP.CD_ATENDIMENTO IN (4658534,4655110,4576945,4572438,4411256,4361949,4658678,4576142,4568252,4566522,4560040,4547409,4534978,4530505,4522788,1669079)
  AND ATE.DT_ALTA IS NULL
  AND UNI.CD_SETOR NOT IN (47,	48,	94,	95,	165,	236,	259,	260,	262,	267,	269,	293,	351,	352,	605,	606,	612,	630,	656,	673,	849,	850,	860) --Solicitado pelo Drº Guilherme, retirar os pacientes da UTI
  AND (SCOR.DS_RESPOSTA LIKE '%Médio%' OR SCOR.DS_RESPOSTA LIKE '%Alto%')
  
  GROUP BY 
  PCP.CD_ALERTA_PROTOCOLO
  ,PAP.DS_ALERTA_PROTOCOLO
  ,PCP.CD_ETAPA_PROTOCOLO
  ,PEP.DS_ETAPA
  ,PCP.CD_ATENDIMENTO
  ,PCP.CD_PACIENTE
  ,PAC.NM_PACIENTE
  ,PAC.DT_NASCIMENTO
  ,PPEP.CD_DOCUMENTO
  ,SCOR.DS_RESPOSTA
  ,SCOR.DH_FECHAMENTO
  ,ENTRADA.DH_FECHAMENTO
  ,ENTRADA.DS_RESPOSTA
  ,SAIDA.DH_FECHAMENTO
  ,UNI.DS_UNID_INT
  ,LEI.DS_LEITO
  ,CON.NM_CONVENIO
    
 ORDER BY PCP.CD_ATENDIMENTO