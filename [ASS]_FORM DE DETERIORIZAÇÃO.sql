SELECT nm_paciente, cd_atendimento, ds_unid_int, ds_leito, idade, score_news, dt_score_news, entrada_deterioracao, nm_convenio, saida_deterioracao--, lk
FROM (
SELECT tds.* /*,
'<a href="http://hdprd-mvpep-01.rhp.com.br/mvpep/5/#/d/234/MVPEP_LISTA_PACIENTE/1488/LISTA_PACIENTES/h/'||tds.cd_atendimento||'" target="new"/>'||tds.cd_atendimento||'</a>' AS lk*/
 
FROM 
(
SELECT DISTINCT
PAC.NM_PACIENTE,
PDC.CD_ATENDIMENTO, 
UNI.DS_UNID_INT,
LEI.DS_LEITO,
FN_IDADE(PAC.DT_NASCIMENTO, 'a') as Idade,
(SELECT SCORE_NEWS 
FROM(SELECT 
DISTINCT
DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000,1) AS SCORE_NEWS, 
DENSE_RANK() OVER(PARTITION BY PD.CD_ATENDIMENTO ORDER BY PD.DH_FECHAMENTO DESC) AUX
FROM 
PW_DOCUMENTO_CLINICO PD,
PW_EDITOR_CLINICO PEC,
EDITOR_REGISTRO_CAMPO ERC,
EDITOR_CAMPO EC
WHERE 
PEC.CD_DOCUMENTO_CLINICO(+) = PD.CD_DOCUMENTO_ClINICO
AND PEC.CD_EDITOR_REGISTRO = ERC.CD_REGISTRO(+)
AND EC.CD_CAMPO(+) = ERC.CD_CAMPO 
AND PEC.CD_DOCUMENTO = 1296 --PROTOCOLO DE DETERIORIZAÇÃO
AND PD.TP_STATUS = 'FECHADO'
AND EC.DS_IDENTIFICADOR IN ('VALOR_DETERIORIZACAO_8')
--AND DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000,1) NOT LIKE ('%Baixo%')
AND PD.CD_ATENDIMENTO = PDC.CD_ATENDIMENTO
 
)WHERE AUX = 1
) AS SCORE_NEWS,
(SELECT 
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
AND PEC.CD_DOCUMENTO = 1296 --SCORE NEWS
AND PD.TP_STATUS = 'FECHADO'
AND EC.DS_IDENTIFICADOR IN ('VALOR_DETERIORIZACAO_8')
--AND DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000,1) NOT LIKE ('%Baixo%')
AND PD.CD_ATENDIMENTO = PDC.CD_ATENDIMENTO
) AS DT_SCORE_NEWS,
PDC.DH_FECHAMENTO ENTRADA_DETERIORACAO,
CON.NM_CONVENIO, 
(SELECT 
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
AND DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000,1) = 'true'
AND PD.CD_ATENDIMENTO = PDC.CD_ATENDIMENTO
AND PD.DH_FECHAMENTO >= PDC.DH_FECHAMENTO --ADICIONADO POR 26753 EM 22/02/2022
) AS SAIDA_DETERIORACAO
FROM 
PW_DOCUMENTO_CLINICO PDC,
PW_EDITOR_CLINICO PEC,
EDITOR_REGISTRO_CAMPO ERC,
EDITOR_CAMPO EC,
ATENDIME ATE, 
PACIENTE PAC,
LEITO LEI,
UNID_INT UNI,
CONVENIO CON
WHERE 
PEC.CD_DOCUMENTO_CLINICO(+) = PDC.CD_DOCUMENTO_ClINICO
AND PEC.CD_EDITOR_REGISTRO = ERC.CD_REGISTRO(+)
AND EC.CD_CAMPO(+) = ERC.CD_CAMPO 
AND ATE.CD_ATENDIMENTO = PDC.CD_ATENDIMENTO 
AND PAC.CD_PACIENTE = ATE.CD_PACIENTE
AND LEI.CD_LEITO = ATE.CD_LEITO
AND LEI.CD_UNID_INT = UNI.CD_UNID_INT
AND CON.CD_CONVENIO = ATE.CD_CONVENIO
AND PEC.CD_DOCUMENTO = 1291 --Protocolo de Deterioração - Entrada
AND PDC.TP_STATUS = 'FECHADO'
AND EC.DS_IDENTIFICADOR IN ('Metadado_P_368218_1')
AND DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000,1) = 'true'
--and ate.cd_atendimento = 1960371
AND ATE.DT_ALTA IS NULL
AND PDC.CD_ATENDIMENTO LIKE '%%' 
AND UNI.CD_UNID_INT IN (92,72,6,49,48,7,10,59,74,52,57,54,36,63,37,21,91,18,15,86,31,33,93,38,90,75,4,89,42,8,9,14,19,20,60,23,66,26,27,28,29,30,69,70) 
) tds
WHERE tds.SAIDA_DETERIORACAO IS NULL
ORDER BY 1,2
)
UNION
SELECT nm_paciente, cd_atendimento, ds_unid_int, ds_leito, idade, score_news, dt_score_news, entrada_deterioracao, nm_convenio, saida_deterioracao--, lk
FROM (
SELECT p.nm_paciente
,a.cd_atendimento
,u.ds_unid_int
,l.ds_leito
,FN_IDADE(P.DT_NASCIMENTO, 'a') AS idade
/*-----Resultado Score News-----*/
,(SELECT ds_resposta
FROM (
SELECT Ate.Cd_Atendimento
, Pec.cd_editor_registro 
,Dbms_Lob.SubStr(Erc.Lo_Valor,4000) as ds_resposta
,Dense_Rank() OVER(PARTITION BY ate.cd_atendimento ORDER BY pec.cd_editor_registro DESC) ordem
FROM 
Dbamv.Pw_Documento_Clinico Pdc
,Dbamv.Pw_Editor_Clinico Pec
,Dbamv.Editor_Registro_Campo Erc
,Dbamv.Atendime Ate
,Dbamv.Editor_Campo Ecp
,Dbamv.Editor_Campo Epa
,Dbamv.Editor_Documento Doc
,Dbamv.Paciente Pac
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
AND Ecp.Ds_Identificador LIKE 'VALOR_DETERIORIZACAO_8'
) WHERE ordem = 1) AS score_news
/*-------Data Score News------------*/
,(SELECT DISTINCT Dh_Fechamento
FROM (
SELECT Ate.Cd_Atendimento
,Ate.dt_atendimento
, Pec.cd_editor_registro 
,Pdc.Dh_Fechamento
,Dense_Rank() OVER(PARTITION BY ate.cd_atendimento ORDER BY pec.cd_editor_registro DESC) ordem
FROM 
Dbamv.Pw_Documento_Clinico Pdc
,Dbamv.Pw_Editor_Clinico Pec
,Dbamv.Editor_Registro_Campo Erc
,Dbamv.Atendime Ate
,Dbamv.Editor_Campo Ecp
,Dbamv.Editor_Campo Epa
,Dbamv.Editor_Documento Doc
,Dbamv.Paciente Pac
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
AND Ecp.Ds_Identificador LIKE 'VALOR_DETERIORIZACAO_8'
) WHERE ordem = 1) AS dt_score_news
,inter.Dh_Fechamento AS entrada_deterioracao
,c.nm_convenio
,(SELECT 
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
AND DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000,1) = 'true'
AND PD.CD_ATENDIMENTO = a.CD_ATENDIMENTO
AND PD.DH_FECHAMENTO >= inter.DH_FECHAMENTO --ADICIONADO POR 26753 EM 22/02/2022
) AS SAIDA_DETERIORACAO
/*,'<a href="http://hdprd-mvpep-01.rhp.com.br/mvpep/5/#/d/234/MVPEP_LISTA_PACIENTE/1488/LISTA_PACIENTES/h/'||a.cd_atendimento||'" target="new"/>'||a.cd_atendimento||'</a>' AS lk*/

 
FROM atendime a
INNER JOIN paciente p ON a.cd_paciente = p.cd_paciente AND a.CD_ATENDIMENTO LIKE '%%' 
INNER JOIN leito l ON a.cd_leito = l.cd_leito
INNER JOIN unid_int u ON l.cd_unid_int = u.cd_unid_int AND u.CD_UNID_INT IN (92,72,6,49,48,7,10,59,74,52,57,54,36,63,37,21,91,18,15,86,31,33,93,38,90,75,4,89,42,8,9,14,19,20,60,23,66,26,27,28,29,30,69,70) 
INNER JOIN convenio c ON a.cd_convenio = c.cd_convenio
INNER JOIN (SELECT * FROM (
SELECT Ate.Cd_Atendimento
, Pec.cd_editor_registro 
, Doc.Ds_Documento 
, Ecp.Cd_Campo AS cd_campo1
, Ecp.Ds_Campo AS ds_campo1
, Ecp.Ds_Identificador AS Ds_Identificador1
, Epa.Cd_Campo AS cd_campo2
, Epa.Ds_Campo AS ds_campo2
, Epa.Ds_Identificador AS Ds_Identificador2
, Pdc.Dh_Fechamento
,Dbms_Lob.SubStr(Erc.Lo_Valor,4000) as ds_resposta
,Dense_Rank() OVER(PARTITION BY ate.cd_atendimento ORDER BY Pec.cd_editor_registro DESC) ordem
FROM 
Dbamv.Pw_Documento_Clinico Pdc
,Dbamv.Pw_Editor_Clinico Pec
,Dbamv.Editor_Registro_Campo Erc
,Dbamv.Atendime Ate
,Dbamv.Editor_Campo Ecp
,Dbamv.Editor_Campo Epa
,Dbamv.Editor_Documento Doc
,Dbamv.Paciente Pac
WHERE 
Pec.Cd_Documento_Clinico = Pdc.Cd_Documento_Clinico
AND Erc.Cd_Registro = Pec.Cd_Editor_Registro
AND Pdc.Cd_Atendimento = Ate.Cd_Atendimento
AND Ecp.Cd_Campo = Erc.Cd_campo
AND Ecp.Cd_Metadado = Epa.Cd_Campo
AND Pec.Cd_Documento = Doc.Cd_Documento
AND Ate.Cd_Paciente = Pac.Cd_Paciente
AND Pec.Cd_Documento = 460
AND Pdc.Tp_Status IN ('FECHADO','ASSINADO') 
AND Ecp.Ds_Identificador LIKE 'RB_PAI_DET_CLI_SIM_1'
AND Dbms_Lob.SubStr(Erc.Lo_Valor,4000) LIKE 'true'
)WHERE ordem = 1) inter ON a.cd_atendimento = inter.cd_atendimento
) 
where saida_deterioracao is null