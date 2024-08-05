SELECT
    nm_paciente,
    cd_atendimento,
    ds_unid_int,
    ds_leito,
    idade,
    score_news,
    dt_score_news,
    entrada_deterioracao,
    nm_convenio,
    saida_deterioracao
FROM(
SELECT  
p.nm_paciente
,a.cd_atendimento
,u.ds_unid_int
,l.ds_leito
,FN_IDADE(P.DT_NASCIMENTO, 'a') AS idade
,inter.Dh_Fechamento AS entrada_deterioracao
,c.nm_convenio
,(
SELECT DS_RESPOSTA FROM(
SELECT
    PDC.Cd_Atendimento,
    Pac.nm_paciente,
    Pec.cd_editor_registro,
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
    --AND Ate.cd_atendimento = a.cd_atendimento
    AND Pec.Cd_Documento = 1296
    AND Ecp.Ds_Identificador = 'VALOR_DETERIORIZACAO_8'
    AND PDC.DH_FECHAMENTO >= TRUNC(SYSDATE-1)
    --AND PDC.CD_ATENDIMENTO = 4591395
    
    ORDER BY pec.cd_editor_registro DESC
)
WHERE ORDEM = 1
) score_news
,(
SELECT Dh_Fechamento FROM(
  SELECT
      Ate.Cd_Atendimento,
      Pec.cd_editor_registro,
      Pdc.Dh_Fechamento,
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
      AND Ate.cd_atendimento = a.cd_atendimento
      AND Pec.Cd_Documento = 1296
      AND Ecp.Ds_Identificador = 'VALOR_DETERIORIZACAO_8'
      AND PDC.DH_FECHAMENTO >= TRUNC(SYSDATE-2)
      --AND PDC.CD_ATENDIMENTO = 4591395
)
WHERE ORDEM = 1
) dt_score_news
,(
SELECT
    MAX(PD.DH_FECHAMENTO)
FROM
    PW_DOCUMENTO_CLINICO PD,
    PW_EDITOR_CLINICO PEC,
    EDITOR_REGISTRO_CAMPO ERC,
    EDITOR_CAMPO EC
WHERE
    PEC.CD_DOCUMENTO_CLINICO(+) = PD.CD_DOCUMENTO_ClINICO
    AND PEC.CD_EDITOR_REGISTRO = ERC.CD_REGISTRO(+)
    AND EC.CD_CAMPO(+) = ERC.CD_CAMPO
    AND PEC.CD_DOCUMENTO = 1292 --Protocolo de Deterioração - Saida
    AND PD.TP_STATUS = 'FECHADO'
    AND EC.DS_IDENTIFICADOR IN ('Metadado_P_368239_1')
    AND DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000, 1) = 'true'
    AND PD.DH_FECHAMENTO >= TRUNC(SYSDATE-2)
    AND PD.CD_ATENDIMENTO = a.CD_ATENDIMENTO
    AND PD.DH_FECHAMENTO >= inter.DH_FECHAMENTO --ADICIONADO POR 26753 EM 22/02/2022
) SAIDA_DETERIORACAO

FROM atendime a

INNER JOIN paciente p ON a.cd_paciente = p.cd_paciente
INNER JOIN leito l ON a.cd_leito = l.cd_leito
INNER JOIN unid_int u ON l.cd_unid_int = u.cd_unid_int
INNER JOIN convenio c ON a.cd_convenio = c.cd_convenio
INNER JOIN (SELECT * FROM (
                        SELECT
                            Ate.Cd_Atendimento,
                            Pec.cd_editor_registro,
                            Doc.Ds_Documento,
                            Ecp.Cd_Campo AS cd_campo1,
                            Ecp.Ds_Campo AS ds_campo1,
                            Ecp.Ds_Identificador AS Ds_Identificador1,
                            Epa.Cd_Campo AS cd_campo2,
                            Epa.Ds_Campo AS ds_campo2,
                            Epa.Ds_Identificador AS Ds_Identificador2,
                            Pdc.Dh_Fechamento,
                            Dbms_Lob.SubStr(Erc.Lo_Valor, 4000) as ds_resposta,
                            Dense_Rank() OVER(PARTITION BY ate.cd_atendimento ORDER BY Pec.cd_editor_registro DESC) ordem
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
                            AND Pec.Cd_Documento = 460
                            AND Pdc.Tp_Status IN ('FECHADO', 'ASSINADO')
                            AND Ecp.Ds_Identificador = 'RB_PAI_DET_CLI_SIM_1'
                            AND Dbms_Lob.SubStr(Erc.Lo_Valor, 4000) LIKE 'true'
                    )
                WHERE ordem = 1
            ) inter ON a.cd_atendimento = inter.cd_atendimento
 )           

WHERE saida_deterioracao is null
AND entrada_deterioracao >= TRUNC(SYSDATE-7)
--AND a.CD_ATENDIMENTO LIKE '%%'
--AND u.CD_UNID_INT IN (92,72,6,49,48,7,10,59,74,52,57,54,36,63,37,21,91,18,15,86,31,33,93,38,90,75,4,89,42,8,9,14,19,20,60,23,66,26,27,28,29,30,69,70)
   --3593 -3503         