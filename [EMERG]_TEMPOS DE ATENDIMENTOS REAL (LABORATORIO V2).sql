SELECT 
TIPO
, NM_SET_EXA
, CD_ATENDIMENTO
, CD_PED_LAB
, DS_EXA_LAB
, HR_SOLSAI_PRO
, DH_DISPENSACAO_FARM
, DH_PED_LAB
, DH_COLETA_LAB
/*, ROUND(((NVL(MAX(DH_COLETA_LAB),SYSDATE) - MAX (DH_PED_LAB))*24 *60),0) AS TEMPO_7
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((NVL(MAX(DH_COLETA_LAB),SYSDATE) - MAX (DH_PED_LAB))*24 *60),0), 'MINUTE'), 'HH24:MI') AS HM_TEMPO7*/
,CASE
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NOT NULL THEN 1
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NULL AND DH_DISPENSACAO_FARM IS NULL THEN 1
    ELSE 0 
    END AS SN_LABORATORIO
,NVL(CASE 
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NULL AND DH_DISPENSACAO_FARM IS NULL THEN ROUND(((NVL(MAX(DH_COLETA_LAB),sysdate) - MAX (DH_PED_LAB))*24 *60),0) 
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NULL THEN ROUND(((NVL(MAX(DH_COLETA_LAB),sysdate) - MAX (DH_PED_LAB))*24 *60),0)
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NOT NULL  THEN ROUND((((NVL(MAX(DH_COLETA_LAB), sysdate) - MAX(DH_PED_LAB)) - (NVL(MAX(DH_DISPENSACAO_FARM), sysdate) - MAX (HR_SOLSAI_PRO))) * 24 * 60),0)
    ELSE ROUND((((NVL(MAX(DH_DISPENSACAO_FARM), sysdate) - MAX(HR_SOLSAI_PRO)) - (NVL(MAX(DH_COLETA_LAB), sysdate) - MAX (DH_PED_LAB))) * 24 * 60),0) END,ROUND(((NVL(MAX(DH_COLETA_LAB),SYSDATE) - MAX (DH_PED_LAB))*24 *60),0)) AS TEMPO_7
    
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(
NVL(CASE 
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NULL AND DH_DISPENSACAO_FARM IS NULL THEN ROUND(((NVL(MAX(DH_COLETA_LAB),sysdate) - MAX (DH_PED_LAB))*24 *60),0) 
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NULL THEN ROUND(((NVL(MAX(DH_COLETA_LAB),sysdate) - MAX (DH_PED_LAB))*24 *60),0)
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NOT NULL  THEN ROUND((((NVL(MAX(DH_COLETA_LAB), sysdate) - MAX(DH_PED_LAB)) - (NVL(MAX(DH_DISPENSACAO_FARM), sysdate) - MAX (HR_SOLSAI_PRO))) * 24 * 60),0)
    ELSE ROUND((((NVL(MAX(DH_DISPENSACAO_FARM), sysdate) - MAX(HR_SOLSAI_PRO)) - (NVL(MAX(DH_COLETA_LAB), sysdate) - MAX (DH_PED_LAB))) * 24 * 60),0) END,ROUND(((NVL(MAX(DH_COLETA_LAB),SYSDATE) - MAX (DH_PED_LAB))*24 *60),0))
, 'MINUTE'), 'HH24:MI') AS HM_TEMPO7
FROM
    (SELECT '1.LABORATORIO' TIPO,
        A.CD_ATENDIMENTO,
        MAX(P.CD_PED_LAB) AS CD_PED_LAB,
        MAX((SELECT MAX(NM_EXA_LAB) FROM ITPED_LAB IPL, DBAMV.EXA_LAB ELB WHERE IPL.CD_EXA_LAB = ELB.CD_EXA_LAB AND IPL.CD_PED_LAB = P.CD_PED_LAB)) AS DS_EXA_LAB,
        MAX((SELECT MAX(NM_SET_EXA) FROM ITPED_LAB IPL, DBAMV.SET_EXA SE WHERE SE.CD_SET_EXA = IPL.CD_SET_EXA AND IPL.CD_PED_LAB = P.CD_PED_LAB)) AS NM_SET_EXA,
        MAX(DBAMV.FNC_MV_RECUPERA_DATA_HORA(P.DT_PEDIDO, P.HR_PED_LAB)) AS DH_PED_LAB,
        (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
            WHERE lme.DT_MOVIMENTO >= TRUNC(SYSDATE)
            AND lme.DT_MOVIMENTO < TRUNC(SYSDATE+1)
            AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
            AND CD_PED_LAB_RX = P.CD_PED_LAB
            AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%'
        )DH_COLETA_LAB,
        (SELECT MAX(HR_SOLSAI_PRO) FROM DBAMV.SOLSAI_PRO WHERE CD_ATENDIMENTO = A.CD_ATENDIMENTO) AS HR_SOLSAI_PRO,
        CASE 
          WHEN A.CD_ORI_ATE = 4 THEN (SELECT MAX(HR_MVTO_ESTOQUE) FROM DBAMV.MVTO_ESTOQUE WHERE CD_ATENDIMENTO = A.CD_ATENDIMENTO) 
          ELSE NVL((SELECT  MAX(HR_MVTO_ESTOQUE) FROM DBAMV.MVTO_ESTOQUE MVE, DBAMV.SOLSAI_PRO SSP WHERE MVE.CD_SOLSAI_PRO = SSP.CD_SOLSAI_PRO AND SSP.CD_ATENDIMENTO = A.CD_ATENDIMENTO),SYSDATE) END AS DH_DISPENSACAO_FARM,
        (RANK() OVER (PARTITION BY A.CD_ATENDIMENTO ORDER BY P.CD_PED_LAB DESC, P.HR_PED_LAB DESC)) AS NR_ORD

    FROM DBAMV.ATENDIME A,
        DBAMV.PED_LAB P
                    
    WHERE A.CD_ATENDIMENTO = P.CD_ATENDIMENTO
    
    AND   A.TP_ATENDIMENTO = 'U'
    AND   A.DT_ATENDIMENTO >= TRUNC(SYSDATE)
    AND   A.DT_ATENDIMENTO < TRUNC(SYSDATE+1)
    AND   A.DT_ALTA_MEDICA IS NULL
    
    group by A.CD_ATENDIMENTO,P.DT_PEDIDO,P.CD_PED_LAB/*, PAC.NM_PACIENTE*/,P.HR_PED_LAB, A.CD_ORI_ATE
) WHERE NR_ORD = 1
AND CD_ATENDIMENTO = 4781347
GROUP BY 
TIPO
, CD_ATENDIMENTO
, DH_PED_LAB
, DH_COLETA_LAB
, HR_SOLSAI_PRO
, DH_DISPENSACAO_FARM
, CD_PED_LAB
, DS_EXA_LAB
, NM_SET_EXA