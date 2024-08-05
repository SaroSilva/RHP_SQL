SELECT 
NM_SET_EXA
, CD_ATENDIMENTO
, DT_ALTA_MEDICA
, CD_PED_LAB
, CD_EXA_LAB
, DS_EXA_LAB
, DH_ATENDIMENTO
, DH_PED_LAB_01
, DH_PED_LAB
, DH_COLETA_LAB
--, NR_EXA_COLETADOS
--, NR_TUBO_COLETADOS
, NR_PEDIDO_REALIZADOS
--, NR_EXA_COLETADOS2
--, NR_TUBO_COLETADOS2

, ROUND(((NVL(NVL(MAX(DH_COLETA_LAB),NVL((SELECT MAX(DH_FECHAMENTO) FROM DBAMV.PW_DOCUMENTO_CLINICO
                                           WHERE CD_ATENDIMENTO = BASE.CD_ATENDIMENTO AND CD_TIPO_DOCUMENTO = 12),DT_ALTA_MEDICA)),SYSDATE) - MAX (DH_PED_LAB))*24 *60),0) AS TEMPO_08
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((NVL(NVL(MAX(DH_COLETA_LAB),DT_ALTA_MEDICA),SYSDATE) - MAX (DH_PED_LAB))*24 *60),0), 'MINUTE'), 'HH24:MI') AS HM_TEMPO8

, DH_CONFIRMA_LAB
, ROUND(((NVL(NVL(MAX(DH_CONFIRMA_LAB),NVL((SELECT MAX(DH_FECHAMENTO) FROM DBAMV.PW_DOCUMENTO_CLINICO
                                            WHERE CD_ATENDIMENTO = BASE.CD_ATENDIMENTO AND CD_TIPO_DOCUMENTO = 12),DT_ALTA_MEDICA)),SYSDATE) - MAX (DH_COLETA_LAB))*24 *60),0) AS TEMPO_21
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((NVL(NVL(MAX(DH_CONFIRMA_LAB),DT_ALTA_MEDICA),SYSDATE) - MAX (DH_COLETA_LAB))*24 *60),0), 'MINUTE'), 'HH24:MI') AS HM_TEMPO21

, DH_BANCADA
, ROUND(((NVL(NVL(MAX(DH_BANCADA),NVL((SELECT MAX(DH_FECHAMENTO) FROM DBAMV.PW_DOCUMENTO_CLINICO
                                        WHERE CD_ATENDIMENTO = BASE.CD_ATENDIMENTO AND CD_TIPO_DOCUMENTO = 12),DT_ALTA_MEDICA)),SYSDATE) - NVL(MAX(DH_CONFIRMA_LAB),MAX(DH_COLETA_LAB)))*24 *60),0) AS TEMPO_22
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((NVL(NVL(MAX(DH_BANCADA),DT_ALTA_MEDICA),SYSDATE) - MAX (DH_CONFIRMA_LAB))*24 *60),0), 'MINUTE'), 'HH24:MI') AS HM_TEMPO22

, DH_RESULTADO_LAB
, ROUND(((NVL(NVL(MAX(DH_RESULTADO_LAB),NVL((SELECT MAX(DH_FECHAMENTO) FROM DBAMV.PW_DOCUMENTO_CLINICO
                                              WHERE CD_ATENDIMENTO = BASE.CD_ATENDIMENTO AND CD_TIPO_DOCUMENTO = 12),DT_ALTA_MEDICA)),SYSDATE) - MAX (DH_BANCADA))*24 *60),0) AS TEMPO_13
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((NVL(NVL(MAX(DH_RESULTADO_LAB),DT_ALTA_MEDICA),SYSDATE) - MAX (DH_BANCADA))*24 *60),0), 'MINUTE'), 'HH24:MI') AS HM_TEMPO13

, DH_LIBERADO_LAB
, ROUND(((NVL(NVL(MAX(DH_LIBERADO_LAB),NVL((SELECT MAX(DH_FECHAMENTO) FROM DBAMV.PW_DOCUMENTO_CLINICO
                                              WHERE CD_ATENDIMENTO = BASE.CD_ATENDIMENTO AND CD_TIPO_DOCUMENTO = 12),DT_ALTA_MEDICA)),SYSDATE) - MAX (DH_RESULTADO_LAB))*24 *60),0) AS TEMPO_14
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((NVL(NVL(MAX(DH_LIBERADO_LAB),DT_ALTA_MEDICA),SYSDATE) - MAX (DH_RESULTADO_LAB))*24 *60),0), 'MINUTE'), 'HH24:MI') AS HM_TEMPO14

,ROUND(((NVL(NVL(MAX(DH_LIBERADO_LAB),NVL((SELECT MAX(DH_FECHAMENTO) FROM DBAMV.PW_DOCUMENTO_CLINICO
                                              WHERE CD_ATENDIMENTO = BASE.CD_ATENDIMENTO AND CD_TIPO_DOCUMENTO = 12),DT_ALTA_MEDICA)),SYSDATE) - MAX (DH_COLETA_LAB))*24 *60),0) AS TEMPO_23
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((NVL(NVL(MAX(DH_LIBERADO_LAB),DT_ALTA_MEDICA),SYSDATE) - MAX (DH_COLETA_LAB))*24 *60),0), 'MINUTE'), 'HH24:MI') AS HM_TEMPO23

/*,CASE
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NOT NULL THEN 1
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NULL AND DH_DISPENSACAO_FARM IS NULL THEN 1
    ELSE 0 
    END AS SN_LABORATORIO
,NVL(CASE 
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NULL AND DH_DISPENSACAO_FARM IS NULL THEN ROUND(((NVL(NVL(MAX(DH_COLETA_LAB),DT_ALTA_MEDICA),sysdate) - MAX (DH_PED_LAB))*24 *60),0) 
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NULL THEN ROUND(((NVL(NVL(MAX(DH_COLETA_LAB),DT_ALTA_MEDICA),sysdate) - MAX (DH_PED_LAB))*24 *60),0)
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NOT NULL  THEN ROUND((((NVL(NVL(MAX(DH_COLETA_LAB),DT_ALTA_MEDICA), sysdate) - MAX(DH_PED_LAB)) - (NVL(MAX(DH_DISPENSACAO_FARM), sysdate) - MAX (HR_SOLSAI_PRO))) * 24 * 60),0)
    ELSE ROUND((((NVL(MAX(DH_DISPENSACAO_FARM), sysdate) - MAX(HR_SOLSAI_PRO)) - (NVL(MAX(DH_COLETA_LAB), sysdate) - MAX (DH_PED_LAB))) * 24 * 60),0) END,ROUND(((NVL(MAX(DH_COLETA_LAB),SYSDATE) - MAX (DH_PED_LAB))*24 *60),0)) AS TEMPO_08
, TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(
NVL(CASE 
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NULL AND DH_DISPENSACAO_FARM IS NULL THEN ROUND(((NVL(MAX(DH_COLETA_LAB),sysdate) - MAX (DH_PED_LAB))*24 *60),0) 
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NULL THEN ROUND(((NVL(MAX(DH_COLETA_LAB),sysdate) - MAX (DH_PED_LAB))*24 *60),0)
    WHEN DH_PED_LAB IS NOT NULL AND HR_SOLSAI_PRO IS NOT NULL AND DH_DISPENSACAO_FARM IS NOT NULL  THEN ROUND((((NVL(MAX(DH_COLETA_LAB), sysdate) - MAX(DH_PED_LAB)) - (NVL(MAX(DH_DISPENSACAO_FARM), sysdate) - MAX (HR_SOLSAI_PRO))) * 24 * 60),0)
    ELSE ROUND((((NVL(MAX(DH_DISPENSACAO_FARM), sysdate) - MAX(HR_SOLSAI_PRO)) - (NVL(MAX(DH_COLETA_LAB), sysdate) - MAX (DH_PED_LAB))) * 24 * 60),0) END,ROUND(((NVL(MAX(DH_COLETA_LAB),SYSDATE) - MAX (DH_PED_LAB))*24 *60),0))
, 'MINUTE'), 'HH24:MI') AS HM_TEMPO8*/
FROM
    (
      SELECT 
        A.CD_ATENDIMENTO,
        MAX(DBAMV.FNC_MV_RECUPERA_DATA_HORA(A.DT_ATENDIMENTO, A.HR_ATENDIMENTO)) AS DH_ATENDIMENTO,
        MAX(P.CD_PED_LAB) AS CD_PED_LAB,
        IPL.CD_EXA_LAB,
        (SELECT COUNT (DISTINCT (CD_EXA_LAB)) FROM DBAMV.ITPED_LAB WHERE CD_PED_LAB = P.CD_PED_LAB) AS NR_EXA_COLETADOS, --CONTAMGE POR PEDI REALIZADO
        (SELECT COUNT (DISTINCT (CD_TUBO_COLETA)) FROM DBAMV.ITPED_LAB WHERE CD_PED_LAB = P.CD_PED_LAB) AS NR_TUBO_COLETADOS, --CONTAGEM POR PEDIDO REALIZADO
        (SELECT SUM (COUNT (DISTINCT (PL.CD_PED_LAB)))AS NR_EXA_COLETADOS FROM DBAMV.PED_LAB PL WHERE PL.CD_ATENDIMENTO = A.CD_ATENDIMENTO GROUP BY CD_PED_LAB) AS NR_PEDIDO_REALIZADOS, --CONTAGEM POR ATENDIMENTO
        (SELECT SUM (COUNT (DISTINCT (CD_EXA_LAB)))AS NR_EXA_COLETADOS FROM DBAMV.ITPED_LAB IL, DBAMV.PED_LAB PL WHERE PL.CD_PED_LAB = IL.CD_PED_LAB AND PL.CD_ATENDIMENTO = A.CD_ATENDIMENTO GROUP BY CD_EXA_LAB) AS NR_EXA_COLETADOS2, --CONTAGEM POR ATENDIMENTO
        (SELECT SUM (COUNT (DISTINCT (CD_TUBO_COLETA)))AS NR_EXA_COLETADOS FROM DBAMV.ITPED_LAB IL, DBAMV.PED_LAB PL WHERE PL.CD_PED_LAB = IL.CD_PED_LAB AND PL.CD_ATENDIMENTO = A.CD_ATENDIMENTO GROUP BY CD_TUBO_COLETA) AS NR_TUBO_COLETADOS2, --CONTAGEM POR ATENDIMENTO
        (SELECT NM_EXA_LAB FROM DBAMV.EXA_LAB WHERE CD_EXA_LAB = IPL.CD_EXA_LAB) AS DS_EXA_LAB,
        (SELECT NM_SET_EXA FROM DBAMV.SET_EXA WHERE CD_SET_EXA = IPL.CD_SET_EXA) AS NM_SET_EXA,
--        MAX((SELECT MAX(ELB.CD_EXA_LAB) FROM ITPED_LAB IPL, DBAMV.EXA_LAB ELB WHERE IPL.CD_EXA_LAB = ELB.CD_EXA_LAB AND IPL.CD_PED_LAB = P.CD_PED_LAB)) AS CD_EXA_LAB,
--        MAX((SELECT MAX(NM_EXA_LAB) FROM ITPED_LAB IPL, DBAMV.EXA_LAB ELB WHERE IPL.CD_EXA_LAB = ELB.CD_EXA_LAB AND IPL.CD_PED_LAB = P.CD_PED_LAB)) AS DS_EXA_LAB,
--        MAX((SELECT MAX(NM_SET_EXA) FROM ITPED_LAB IPL, DBAMV.SET_EXA SE WHERE SE.CD_SET_EXA = IPL.CD_SET_EXA AND IPL.CD_PED_LAB = P.CD_PED_LAB)) AS NM_SET_EXA,
        (SELECT MIN(DBAMV.FNC_MV_RECUPERA_DATA_HORA(DT_PEDIDO, HR_PED_LAB)) AS DH_01_PED_LAB FROM DBAMV.PED_LAB WHERE CD_ATENDIMENTO = A.CD_ATENDIMENTO) AS DH_PED_LAB_01, -- RETORNAR O PRIMEIRO PEDIDO DO ATENDIMENTO
        MAX(DBAMV.FNC_MV_RECUPERA_DATA_HORA(P.DT_PEDIDO, P.HR_PED_LAB)) AS DH_PED_LAB,
        MAX(A.DT_ALTA_MEDICA) AS DT_ALTA_MEDICA,
        
        (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
            WHERE lme.DT_MOVIMENTO >= '01/JAN/2024'
            AND lme.DT_MOVIMENTO < TRUNC(SYSDATE)+INTERVAL '24' HOUR
            AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
            AND CD_PED_LAB_RX = P.CD_PED_LAB
            AND CD_ITPED_LAB_RX = IPL.CD_ITPED_LAB
            AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%'
              ) AS DH_COLETA_LAB,
        
        (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
            WHERE lme.DT_MOVIMENTO >= '01/JAN/2024'-->= TRUNC(SYSDATE)- INTERVAL '24' HOUR
            AND lme.DT_MOVIMENTO < TRUNC(SYSDATE)+INTERVAL '24' HOUR
            AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
            AND CD_PED_LAB_RX = P.CD_PED_LAB
            AND CD_ITPED_LAB_RX = IPL.CD_ITPED_LAB
            AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi recepcionada/colhida pelo Laboratório%'
              ) AS DH_CONFIRMA_LAB,
        
        (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
            WHERE lme.DT_MOVIMENTO >= '01/JAN/2024'-->= TRUNC(SYSDATE)- INTERVAL '24' HOUR
            AND lme.DT_MOVIMENTO < TRUNC(SYSDATE)+INTERVAL '24' HOUR
            AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
            AND CD_PED_LAB_RX = P.CD_PED_LAB
            AND CD_ITPED_LAB_RX = IPL.CD_ITPED_LAB
            AND DS_MOVIMENTO LIKE '%Exame movimentado pela Bancada%'
              ) AS DH_BANCADA,
        
        (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
            WHERE lme.DT_MOVIMENTO >= '01/JAN/2024'-->= TRUNC(SYSDATE)- INTERVAL '24' HOUR
            AND lme.DT_MOVIMENTO < TRUNC(SYSDATE)+INTERVAL '24' HOUR
            AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
            AND CD_PED_LAB_RX = P.CD_PED_LAB
            AND CD_ITPED_LAB_RX = IPL.CD_ITPED_LAB
            AND DS_MOVIMENTO LIKE '%Exame revisado%'
              ) AS DH_RESULTADO_LAB,
        
        (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
            WHERE lme.DT_MOVIMENTO >= '01/JAN/2024'-->= TRUNC(SYSDATE)- INTERVAL '24' HOUR
            AND lme.DT_MOVIMENTO < TRUNC(SYSDATE)+INTERVAL '24' HOUR
            AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
            AND CD_PED_LAB_RX = P.CD_PED_LAB
            AND CD_ITPED_LAB_RX = IPL.CD_ITPED_LAB
            AND DS_MOVIMENTO LIKE '%Exame Assinado%'
              ) AS DH_LIBERADO_LAB,
                
        (SELECT MAX(HR_SOLSAI_PRO) FROM DBAMV.SOLSAI_PRO WHERE CD_ATENDIMENTO = A.CD_ATENDIMENTO) AS HR_SOLSAI_PRO,
        --(SELECT MAX(HR_MVTO_ESTOQUE) FROM DBAMV.MVTO_ESTOQUE WHERE CD_ATENDIMENTO = A.CD_ATENDIMENTO) AS DH_DISPENSACAO_FARM,
        CASE 
          WHEN A.CD_ORI_ATE = 4 THEN (SELECT MAX(HR_MVTO_ESTOQUE) FROM DBAMV.MVTO_ESTOQUE WHERE CD_ATENDIMENTO = A.CD_ATENDIMENTO) 
          ELSE NVL((SELECT  MAX(HR_MVTO_ESTOQUE) FROM DBAMV.MVTO_ESTOQUE MVE, DBAMV.SOLSAI_PRO SSP WHERE MVE.CD_SOLSAI_PRO = SSP.CD_SOLSAI_PRO AND SSP.CD_ATENDIMENTO = A.CD_ATENDIMENTO),SYSDATE) END AS DH_DISPENSACAO_FARM,
        RANK() OVER (PARTITION BY A.CD_ATENDIMENTO ORDER BY P.CD_PED_LAB DESC, P.HR_PED_LAB DESC) AS NR_ORD_PED,
        RANK() OVER (PARTITION BY P.CD_PED_LAB ORDER BY IPL.DT_ASSINADO DESC, IPL.CD_EXA_LAB DESC) AS NR_ORD_EXA

    FROM DBAMV.ATENDIME A,
         DBAMV.PED_LAB P,
         DBAMV.SET_EXA S,
         DBAMV.ITPED_LAB IPL
                    
    WHERE A.CD_ATENDIMENTO = P.CD_ATENDIMENTO
    AND P.CD_PED_LAB = IPL.CD_PED_LAB
    AND S.CD_SET_EXA(+) = P.CD_SET_EXA
    
    AND A.TP_ATENDIMENTO = 'U'
    --AND P.DT_PEDIDO >= TRUNC(SYSDATE)--INTERVAL '24' HOUR
    --AND P.DT_PEDIDO < TRUNC(SYSDATE)+INTERVAL '01' HOUR
   -- AND P.CD_PED_LAB = 240202965
    AND A.CD_ATENDIMENTO =  4543973 --4776698
    --AND   A.DT_ALTA_MEDICA IS NULL
    --AND IPL.CD_EXA_LAB NOT IN (209,560)

    
    group by A.CD_ATENDIMENTO,P.DT_PEDIDO,P.CD_PED_LAB/*, PAC.NM_PACIENTE*/,P.HR_PED_LAB, P.CD_PED_LAB,A.CD_ORI_ATE, IPL.CD_EXA_LAB, IPL.DT_ASSINADO, IPL.CD_SET_EXA, IPL.CD_ITPED_LAB
) base
WHERE NR_ORD_PED = 1
AND NR_ORD_EXA = 1
GROUP BY 
NM_SET_EXA
, CD_ATENDIMENTO
, DH_PED_LAB
, DH_COLETA_LAB
, HR_SOLSAI_PRO
, DH_DISPENSACAO_FARM
, CD_PED_LAB
, DS_EXA_LAB
, DT_ALTA_MEDICA
, DH_RESULTADO_LAB
, DH_LIBERADO_LAB
, DH_BANCADA
, DH_CONFIRMA_LAB
, CD_EXA_LAB
, DH_ATENDIMENTO
, DH_PED_LAB_01
, DH_COLETA_LAB
, NR_EXA_COLETADOS
, NR_TUBO_COLETADOS
, NR_EXA_COLETADOS2
, NR_TUBO_COLETADOS2
, NR_PEDIDO_REALIZADOS