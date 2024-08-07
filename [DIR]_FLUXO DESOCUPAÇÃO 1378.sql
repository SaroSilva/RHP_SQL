SELECT
  CD_ATENDIMENTO,
  CD_PACIENTE2 AS PACIENTE,
  (SELECT MAX (NM_PACIENTE) FROM DBAMV.PACIENTE WHERE CD_PACIENTE = CD_PACIENTE2) NM_PACIENTE,
  CD_USUARIO,
  NM_PRESTADOR,
  DS_CID_PRINC,
  DS_CID_SECUND,
  DS_ENDERECO_TERMO,
  DT_HR_ENVIO,
  --ANTECEDENTES
  DECODE (TP_DEMENCIA,'true','POSITIVO','false','NEGATIVO') AS TP_DEMENCIA,
  DECODE (TP_PARKINSON,'true','POSITIVO','false','NEGATIVO') AS TP_PARKINSON,
  DECODE (TP_HAS,'true','POSITIVO','false','NEGATIVO') AS TP_HAS,
  DECODE (TP_ICC,'true','POSITIVO','false','NEGATIVO') AS TP_ICC,
  DECODE (TP_DPOC,'true','POSITIVO','false','NEGATIVO') AS TP_DPOC,
  DECODE (TP_FIBROSE_PULMO,'true','POSITIVO','false','NEGATIVO') AS TP_FIBROSE_PULMO,
  DECODE (TP_IRC_DIALI,'true','POSITIVO','false','NEGATIVO') AS TP_IRC_DIALI,
  DECODE (TP_IRC_SEM_DIALI,'true','POSITIVO','false','NEGATIVO') AS TP_IRC_SEM_DIALI,
  DECODE (TP_DM,'true','POSITIVO','false','NEGATIVO') AS TP_DM,
  DECODE (TP_AVEI_AVEH,'true','POSITIVO','false','NEGATIVO') AS TP_AVEI_AVEH,
  DECODE (TP_NEOPLASIA,'true','POSITIVO','false','NEGATIVO') AS TP_NEOPLASIA,
  TX_NEOPLASIA,
  DECODE (TP_OUTROS_ANTECEDENTE,'true','POSITIVO','false','NEGATIVO') AS TP_OUTROS_ANTECEDENTE,
  TX_ANTECEDENTES,
  --NIVEL DE CONCIENCIA DO PACIENTE
  DECODE (TP_RADIO_01,'true','CONFUS�O MENTAL','false','CONCIENTE E ORIENTADO') AS TP_NV_CONCIENCIA,
  DECODE (TP_RADIO_02,'true','COMATOSO / INCOCIENTE','false','SONOLENTO') AS TP_NV_CONCIENCIA2,
  --SUPORTE VETILATORIO
  DECODE (TP_O2,'true','SEM SUPORTE DE O2','false',NULL) AS TP_O2,
  DECODE (TP_AVM,'true','ASSIST�NCIA VENTILAT�RIA MEC�NICA','false',NULL) AS TP_AVM,
  DECODE (TP_VM_N_INVASIVA,'true','VENTILA��O N�O INVASIVA','false',NULL) AS TP_VM_N_INVASIVA,
  DECODE (TP_OX_INTERMITENTE,'true','OXIG�NIO INTERMITENTE','false',NULL) AS TP_OX_INTERMITENTE,
  DECODE (TP_OX_CONTINUO,'true','OXIG�NIO  CONT�NUO','false',NULL) AS TP_OX_CONTINUO,
  --OSTOMIAS
  DECODE (TP_OSMONIA_NAO,'true','SEM OSMONIA','false',NULL) AS TP_OSMONIA_NAO,
  DECODE (TP_TRAQUEO,'true','TRAQUEOSTOMIA','false',NULL) AS TP_TRAQUEO,
  DECODE (TP_GASTROMIA_JEJUN,'true','GASTROTOMIA \ JEJUNOSTOMIA','false',NULL) AS TP_GASTROMIA_JEJUN,
  DECODE (TP_COLOSTOMIA,'true','COLONOSTOMIA','false',NULL) AS TP_COLOSTOMIA,
  DECODE (TP_CISTOSTOMIA,'true','CISTOSTOMIA','false',NULL) AS TP_CISTOSTOMIA,
  DECODE (TP_OUTRA_OSTOMIA,'true','OUTROS','false',NULL) AS TP_OUTRA_OSTOMIA,
  --ASPIRA��O
  DECODE (TP_ASPIRAR_NAO,'true','SEM ASPIRA��O','false',NULL) AS TP_ASPIRAR_NAO,
  DECODE (TP_ASPIRAR_SIM,'true','OUTROS','false',NULL) AS TP_ASPIRAR_SIM,
  TX_ASPIRACAO_FREQ,
  --CATETER VESICAL
  DECODE (TP_ASPIRAR_SIM,'true','OUTROS','false',NULL) AS TP_ASPIRAR_SIM,
  DECODE (TP_ASPIRAR_SIM,'true','OUTROS','false',NULL) AS TP_ASPIRAR_SIM,
  --CURATIVOS
  DECODE (TP_ASPIRAR_SIM,'true','OUTROS','false',NULL) AS TP_ASPIRAR_SIM,

  TX_CAT_VESICAL_ALIVIO,
  DS_OBSERVACAO,
  DS_TEXTO,
  DT_MEDIC_INICIAL_01,
  DT_MEDIC_TERMINO_01,
  DT_MEDIC_INICIAL_02,
  DT_MEDIC_TERMINO_02,
  DT_ULT_CURATIVO,
  CD_DOCUMENTO,
  CD_EDITOR
  
FROM
  (
    SELECT
      EC.DS_CAMPO,
      ERC.CD_REGISTRO,
      DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000, 1) DADO
    FROM
      DBAMV.PW_DOCUMENTO_CLINICO PDC,
      DBAMV.PW_EDITOR_CLINICO PEC,
      DBAMV.EDITOR_REGISTRO_CAMPO ERC,
      DBAMV.EDITOR_CAMPO EC
    WHERE
      PDC.CD_DOCUMENTO_CLINICO = PEC.CD_DOCUMENTO_ClINICO
      AND PEC.CD_EDITOR_REGISTRO = ERC.CD_REGISTRO
      AND EC.CD_CAMPO = ERC.CD_CAMPO 
      --FILTROS
      AND PEC.CD_DOCUMENTO = 1378
  ) PIVOT (
    MAX(DADO) FOR DS_CAMPO IN(
      'C�digo do Atendimento' AS CD_ATENDIMENTO,
      'C�digo do Documento' AS CD_DOCUMENTO,
      'Registro do editor' AS CD_EDITOR,
      'C�digo do Paciente' AS CD_PACIENTE2,
      'C�digo do Usu�rio' AS CD_USUARIO,
      'CID 10 - Principal' AS DS_CID_PRINC,
      'CID 10 - Segund�rio' AS DS_CID_SECUND,
      'TX_ENDERECO_PAC_TERMO' AS DS_ENDERECO_TERMO,
      'N�o' AS TP_ASPIRAR_NAO,
      'CT_observacaoo' AS DS_OBSERVACAO,
      'Sim' AS TP_ASPIRAR_SIM,
      'Sistema respons�vel' AS DS_SISTEMA,
      'texto' AS DS_TEXTO,
      'DATA_HR_ENVIO' AS DT_HR_ENVIO,
      'DATA_MEDIC1_INICIO' AS DT_MEDIC_INICIAL_01,
      'DATA_MEDIC2_INICIO' AS DT_MEDIC_INICIAL_02,
      'DATA_MEDIC1_TERMINO' AS DT_MEDIC_TERMINO_01,
      'DATA_MEDIC2_TERMINO' AS DT_MEDIC_TERMINO_02,
      'Data de Registro' AS DT_REGISTRO,
      'DATA_ULTIMO_CURATIVO' AS DT_ULT_CURATIVO,
      'NOME DO USUARIO CONSELHO E CODIGO ' AS NM_PRESTADOR,
      'CB_AVEI_AVEH' AS TP_AVEI_AVEH,
      'CB_ASSISTENCIA_VENTILATORIA_MECANICA' AS TP_AVM,
      'CB_CISTOSTOMIA' AS TP_CISTOSTOMIA,
      'CB_COLOSTOMIA' AS TP_COLOSTOMIA,
      'CB_DEMENCIA' AS TP_DEMENCIA,
      'CB_DM' AS TP_DM,
      'CB_DPOC' AS TP_DPOC,
      'CB_FIBROSE_PULMONAR' AS TP_FIBROSE_PULMO,
      'CB_GASTROMIA_JEJUNOSTOMIA' AS TP_GASTROMIA_JEJUN,
      'CB_HAS' AS TP_HAS,
      'CB_ICC' AS TP_ICC,
      'CB_IRC_DIALITICA' AS TP_IRC_DIALI,
      'CB_IRC_N_DIALITICA' AS TP_IRC_SEM_DIALI,
      'CB_NAO' AS TP_OSMONIA_NAO,
      'CB_NEOPLASIA' AS TP_NEOPLASIA,
      'CB_S_SUPORTE_02' AS TP_O2,
      'CB_OUTROS' AS TP_OUTRA_OSTOMIA,
      'CB_OUROS_ANTECEDENTES' AS TP_OUTROS_ANTECEDENTE,
      'CB_OXIGENIO_CONTINUO' AS TP_OX_CONTINUO,
      'CB_OXIGENIO_INTERMITENTE' AS TP_OX_INTERMITENTE,
      'CB_PARKINSON' AS TP_PARKINSON,
      'radio_button' AS TP_RADIO_01,
      'radiobutton' AS TP_RADIO_02,
      'CB_TRAQUEOSTOMIA' AS TP_TRAQUEO,
      'CB_VENTILACAO_N_INVASIVA' AS TP_VM_N_INVASIVA,
      'TX_ANTECEDENTES_OUTROS' AS TX_ANTECEDENTES,
      'TX_ASPIRACAO_FREQUENCIA' AS TX_ASPIRACAO_FREQ,
      'TX_CATETER_VESICAL_ALIVIO' AS TX_CAT_VESICAL_ALIVIO,
      'TX_NEOPLASIA' AS TX_NEOPLASIA
    )
  )
  order by 1 desc
  ;
  select * from DBAMV.PW_DOCUMENTO_OBJETO
  where CD_DOCUMENTO in (1377,1378)
  ;
  SELECT * FROM SYS.ALL_TAB_COLUMNS
  WHERE OWNER = 'DBAMV'
  --AND TABLE_NAME LIKE 'DOCUM%'
  AND COLUMN_NAME LIKE 'CD_DOCUMENTO'
  ORDER BY 2,3;
  
SELECT 
PDC.CD_ATENDIMENTO AS ATENDIMENTO
,PEC.CD_DOCUMENTO||' - '||DS_DOCUMENTO AS FORMULARIO
,PDC.CD_PRESTADOR||' - '||(SELECT NM_PRESTADOR FROM DBAMV.PRESTADOR WHERE CD_PRESTADOR = PDC.CD_PRESTADOR) AS "REALIZADO POR"
,(SELECT MAX (DS_ESPECIALID) FROM DBAMV.ESPECIALID ESP, DBAMV.ESP_MED EMD WHERE ESP.CD_ESPECIALID = EMD.CD_ESPECIALID AND EMD.CD_PRESTADOR = PDC.CD_PRESTADOR AND EMD.SN_ESPECIAL_PRINCIPAL = 'S') ESPECIALIDADE
,PDC.TP_STATUS AS STATUS
,TO_DATE (PDC.DH_CRIACAO,'DD/MM/RRRR HH24:MI:ss') AS CRIADO
,TO_DATE (PDC.DH_FECHAMENTO,'DD/MM/RRRR HH24:MI:ss') AS FINALIZADO
FROM 
DBAMV.PW_DOCUMENTO_CLINICO PDC
, DBAMV.PW_EDITOR_CLINICO PEC
, DBAMV.PW_DOCUMENTO_OBJETO PDO

  WHERE PEC.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
  AND PDO.CD_DOCUMENTO = PEC.CD_DOCUMENTO
  AND PDC.CD_OBJETO = 497
  AND PEC.CD_DOCUMENTO in (1377,1378)
  AND PDC.TP_STATUS NOT IN ('CANCELADO')
  --AND PDC.CD_ATENDIMENTO = 4542819
  ORDER BY 6 DESC, 7 DESC
  ;
  SELECT MAX (DS_ESPECIALID) 
  FROM DBAMV.ESPECIALID ESP, DBAMV.ESP_MED EMD, DBAMV.PRESTADOR PRE
  WHERE ESP.CD_ESPECIALID = EMD.CD_ESPECIALID
  AND EMD.CD_PRESTADOR = PRE.CD_PRESTADOR 
  AND EMD.SN_ESPECIAL_PRINCIPAL = 'S'
 AND 