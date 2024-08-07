SELECT 
CD_ATENDIMENTO
, NM_PACIENTE
, CD_ORI_ATE
, CD_CONVENIO
, DT_ATENDIMENTO
, CD_PRE_MED
, HR_PRE_MED
, CD_SOLSAI_PRO
, HR_SOLSAI_PRO
, DH_DISPENSACAO_FARM
, DH_CHECAGEM
, TEMPO_6
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(TEMPO_6, 'MINUTE'), 'HH24:MI') AS HM_TEMPO6

FROM
    (SELECT
    ATE.CD_ATENDIMENTO,
    PAC.NM_PACIENTE,
    ATE.CD_ORI_ATE,
    ATE.CD_CONVENIO,
    ATE.DT_ATENDIMENTO,
    MAX(PMD.CD_PRE_MED) AS CD_PRE_MED,
    MAX(PMD.HR_PRE_MED) AS HR_PRE_MED,
    MAX(SSP.CD_SOLSAI_PRO) AS CD_SOLSAI_PRO,
    MAX(SSP.HR_SOLSAI_PRO) AS HR_SOLSAI_PRO,
    NVL(MAX(MES.HR_MVTO_ESTOQUE),(
    SELECT MAX(DBAMV.FNC_MV_RECUPERA_DATA_HORA(m.DT_MVTO_ESTOQUE, m.HR_MVTO_ESTOQUE)) 
      FROM atendime a, mvto_estoque m
      WHERE m.cd_atendimento = a.cd_atendimento
      AND a.cd_atendimento = ATE.CD_ATENDIMENTO
    ))AS DH_DISPENSACAO_FARM,
    MAX(HIPC.DH_CHECAGEM) AS DH_CHECAGEM,
    ROUND(((NVL(NVL(MAX(MES.HR_MVTO_ESTOQUE),(
    SELECT MAX(DBAMV.FNC_MV_RECUPERA_DATA_HORA(m.DT_MVTO_ESTOQUE, m.HR_MVTO_ESTOQUE)) 
      FROM atendime a, mvto_estoque m
      WHERE m.cd_atendimento = a.cd_atendimento
      AND a.cd_atendimento = ATE.CD_ATENDIMENTO
    )),SYSDATE) - MAX(SSP.HR_SOLSAI_PRO))*24 *60),0) AS TEMPO_6,
    (RANK() OVER (PARTITION BY ATE.CD_ATENDIMENTO ORDER BY PMD.CD_PRE_MED DESC,SSP.CD_SOLSAI_PRO DESC, MES.HR_MVTO_ESTOQUE DESC)) AS NR_ORD
    
FROM
    DBAMV.ATENDIME ATE,
    DBAMV.PRE_MED PMD,
    DBAMV.ITPRE_MED IPM,
    DBAMV.SOLSAI_PRO SSP,
    DBAMV.ITSOLSAI_PRO ISSP,
    DBAMV.MVTO_ESTOQUE MES,
    DBAMV.HRITPRE_CONS HIPC,
    DBAMV.ITMVTO_ESTOQUE IME,
    DBAMV.PACIENTE PAC
    /*RELACIONAMENTO*/
WHERE
    PMD.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO
    AND SSP.CD_PRE_MED = PMD.CD_PRE_MED(+)
    AND PMD.CD_PRE_MED = IPM.CD_PRE_MED
    AND SSP.CD_SOLSAI_PRO = ISSP.CD_SOLSAI_PRO(+)
    AND SSP.CD_SOLSAI_PRO = MES.CD_SOLSAI_PRO(+)
    AND IPM.CD_ITPRE_MED = HIPC.CD_ITPRE_MED(+) 
    --AND IPM.CD_ITPRE_MED = IME.CD_ITPRE_MED
    AND IME.CD_ITSOLSAI_PRO(+) = ISSP.CD_ITSOLSAI_PRO
    AND PAC.CD_PACIENTE = ATE.CD_PACIENTE
    /*FILTROS*/
    --AND ATE.DT_ALTA_MEDICA IS NULL
    AND ATE.DT_ATENDIMENTO >= TRUNC(SYSDATE)
    AND ATE.DT_ATENDIMENTO < TRUNC(SYSDATE)+INTERVAL '24' HOUR
    AND ATE.TP_ATENDIMENTO = 'U' 
    AND SSP.TP_SITUACAO NOT IN ('A')
    --AND ATE.CD_ATENDIMENTO = 4780511

GROUP BY
    ATE.CD_ATENDIMENTO,
    ATE.CD_ORI_ATE,
    ATE.CD_CONVENIO,
    ATE.DT_ATENDIMENTO,
    PMD.CD_PRE_MED,
    PMD.HR_PRE_MED,
    SSP.CD_SOLSAI_PRO,
    SSP.HR_SOLSAI_PRO,
    SSP.TP_SITUACAO,
    PAC.NM_PACIENTE,
    MES.HR_MVTO_ESTOQUE
ORDER BY
    DH_CHECAGEM DESC,
    1
) BASE
WHERE NR_ORD = 1
AND CD_ATENDIMENTO = 4781347
ORDER BY 1