SELECT 
p.nm_paciente
,a.cd_atendimento
,u.ds_unid_int
,l.ds_leito
,FN_IDADE(P.DT_NASCIMENTO, 'a') AS idade
,c.nm_convenio
,scor.DH_FECHAMENTO
,scor.DS_RESPOSTA

FROM ATENDIME A
INNER JOIN paciente p ON a.cd_paciente = p.cd_paciente
INNER JOIN leito l ON a.cd_leito = l.cd_leito
INNER JOIN unid_int u ON l.cd_unid_int = u.cd_unid_int
INNER JOIN convenio c ON a.cd_convenio = c.cd_convenio
INNER JOIN (SELECT * FROM 
(
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
) SCOR ON SCOR.CD_ATENDIMENTO = A.CD_ATENDIMENTO

WHERE a.DT_ALTA IS NULL
AND (DS_RESPOSTA LIKE '%Médio%' OR DS_RESPOSTA LIKE '%Alto%')