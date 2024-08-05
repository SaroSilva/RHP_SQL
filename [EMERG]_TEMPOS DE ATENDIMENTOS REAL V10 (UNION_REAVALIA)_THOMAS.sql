 SELECT 
                STTP.DS_TIPO_TEMPO_PROCESSO,
                STP.DH_PROCESSO,
                tma.DS_SENHA,
                ATE.CD_ATENDIMENTO,
                ATE.CD_ATENDIMENTO ATENDIMENTO,
                ATE.DT_ATENDIMENTO,
                ATE.DT_ALTA_MEDICA,
                TMA.NM_PACIENTE,
                CON.NM_CONVENIO,
                TMA.CD_FILA_SENHA,
                OA.CD_ORI_ATE,
                OA.DS_ORI_ATE,
                TMP_MED.HR_SOLSAI_PRO,
                TMP_MED.DH_DISPENSACAO_FARM,
                LAB.DH_PED_LAB,
                LAB.DH_COLETA_LAB,
                IMAGEM.DT_PEDIDO_RX,
                IMAGEM.TIPO_EXA
                
            FROM 
                SACR_TEMPO_PROCESSO STP,
                SACR_TIPO_TEMPO_PROCESSO STTP,
                SACR_CATEGORIA_PROCESSO SCP,
                DBAMV.ATENDIME ATE,
                DBAMV.TRIAGEM_ATENDIMENTO TMA,
                DBAMV.ORI_ATE OA,
                DBAMV.CONVENIO CON,
                        (SELECT * FROM
            (SELECT * FROM
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
                    --SSP.TP_SITUACAO,
                    MAX(MES.HR_MVTO_ESTOQUE) AS DH_DISPENSACAO_FARM,
                    MAX(HIPC.DH_CHECAGEM) AS DH_CHECAGEM,
                    (
                        RANK() OVER (
                            PARTITION BY ATE.CD_ATENDIMENTO
                            ORDER BY
                                PMD.CD_PRE_MED DESC,
                                MES.HR_MVTO_ESTOQUE DESC
                        )
                    ) AS NR_ORD
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
                    AND SSP.CD_PRE_MED = PMD.CD_PRE_MED
                    AND PMD.CD_PRE_MED = IPM.CD_PRE_MED
                    AND SSP.CD_SOLSAI_PRO = ISSP.CD_SOLSAI_PRO(+)
                    AND SSP.CD_SOLSAI_PRO = MES.CD_SOLSAI_PRO(+)
                    AND IPM.CD_ITPRE_MED = HIPC.CD_ITPRE_MED(+) 
                    --AND IPM.CD_ITPRE_MED = IME.CD_ITPRE_MED
                    AND IME.CD_ITSOLSAI_PRO(+) = ISSP.CD_ITSOLSAI_PRO
                    AND PAC.CD_PACIENTE = ATE.CD_PACIENTE
                    /*FILTROS*/
                    AND ATE.DT_ALTA_MEDICA IS NULL
                    AND ATE.DT_ATENDIMENTO >= TRUNC(SYSDATE)
                    AND ATE.DT_ATENDIMENTO < TRUNC(SYSDATE+1)
                    AND ATE.TP_ATENDIMENTO = 'U' 
                    AND SSP.TP_SITUACAO NOT IN ('A')
                    --AND ATE.CD_ORI_ATE = 2
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
        WHERE
            NR_ORD = 1
    ) )TMP_MED
    ,(SELECT * FROM
        (SELECT '1.LABORATORIO' TIPO,
            A.CD_ATENDIMENTO,
            --PAC.NM_PACIENTE,
            MAX(DBAMV.FNC_MV_RECUPERA_DATA_HORA(P.DT_PEDIDO, P.HR_PED_LAB)) AS DH_PED_LAB,
            (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
              WHERE lme.DT_MOVIMENTO >= TRUNC(SYSDATE)
              AND lme.DT_MOVIMENTO < TRUNC(SYSDATE+1)
              AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
              AND CD_PED_LAB_RX = P.CD_PED_LAB
              AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%'
              )DH_COLETA_LAB,
              (RANK() OVER (PARTITION BY A.CD_ATENDIMENTO ORDER BY P.CD_PED_LAB DESC, P.HR_PED_LAB DESC)) AS NR_ORD

        FROM DBAMV.ATENDIME A,
            DBAMV.PED_LAB P
           -- DBAMV.PACIENTE PAC
                       
        WHERE A.CD_ATENDIMENTO = P.CD_ATENDIMENTO
        --AND A.CD_PACIENTE = PAC.CD_PACIENTE
        
        AND   A.TP_ATENDIMENTO = 'U'
        AND   A.DT_ATENDIMENTO >= TRUNC(SYSDATE)
        AND   A.DT_ATENDIMENTO < TRUNC(SYSDATE+1)
        AND   A.DT_ALTA_MEDICA IS NULL
        --AND   A.CD_ATENDIMENTO in (4698944,4699656,4699465,4699723)
        
        group by A.CD_ATENDIMENTO,P.DT_PEDIDO,P.CD_PED_LAB/*, PAC.NM_PACIENTE*/,P.HR_PED_LAB
) WHERE NR_ORD = 1
)LAB,
(SELECT DISTINCT * FROM (SELECT 
        S.NM_SET_EXA TIPO_EXA,
        A.CD_ATENDIMENTO,
        MIN(DBAMV.FNC_MV_RECUPERA_DATA_HORA(P.DT_PEDIDO, P.HR_PEDIDO)) AS DT_PEDIDO_RX,
        (RANK() OVER (PARTITION BY A.CD_ATENDIMENTO ORDER BY S.NM_SET_EXA DESC, P.HR_PEDIDO DESC)) AS NR_ORD

    FROM 
        DBAMV.PED_RX P,
        DBAMV.ATENDIME A,
        DBAMV.SET_EXA S,

        IDCE.RS_LAU_PEDIDO_EXAME ped,
        IDCE.RS_LAU_EXAME_PEDIDO lau,
        IDCE.RS_EXA_EXAME_UNIDADE exame

    WHERE A.CD_ATENDIMENTO = P.CD_ATENDIMENTO
    AND   P.CD_SET_EXA = S.CD_SET_EXA

    AND   ped.cd_pedido_his = P.CD_PED_RX
    AND   ped.CD_ATENDIMENTO_HIS  = P.CD_ATENDIMENTO
    AND   ped.ID_PEDIDO_EXAME  = lau.ID_PEDIDO_EXAME
    AND   exame.ID_EXAME_UNIDADE  = lau.ID_EXAME_UNIDADE

    AND   LAU.DT_STUDY IS NULL --NÃO TEVE IMAGEM OU LAUDO
    AND   A.DT_ATENDIMENTO >= TRUNC(SYSDATE)
    AND   A.DT_ATENDIMENTO < TRUNC(SYSDATE+1)
    AND   A.DT_ALTA_MEDICA IS NULL
    group by A.CD_ATENDIMENTO,S.NM_SET_EXA,P.HR_PEDIDO
    ORDER BY CD_ATENDIMENTO
)WHERE NR_ORD = 1
)IMAGEM
            --LIGAÇÕES
            WHERE STP.CD_TIPO_TEMPO_PROCESSO (+) = STTP.CD_TIPO_TEMPO_PROCESSO
            AND STTP.cd_categoria_processo = SCP.cd_categoria_processo (+)
            AND STP.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO(+)
            AND TMA.CD_TRIAGEM_ATENDIMENTO(+) = STP.CD_TRIAGEM_ATENDIMENTO
            AND OA.CD_ORI_ATE(+) = ATE.CD_ORI_ATE
            AND ATE.CD_CONVENIO = CON.CD_CONVENIO(+)
            AND ATE.CD_ATENDIMENTO = TMP_MED.CD_ATENDIMENTO(+)
            AND ATE.CD_ATENDIMENTO = LAB.CD_ATENDIMENTO(+)
            AND ATE.CD_ATENDIMENTO = IMAGEM.CD_ATENDIMENTO(+)
            
            --FILTROS
            AND DH_PROCESSO >= TRUNC(SYSDATE)
            AND DH_PROCESSO < TRUNC(SYSDATE+1) --THOMAS
            AND ATE.DT_ALTA_MEDICA IS NULL
            AND   (TMA.CD_FILA_SENHA      IN (19,29,182,244,246,248,161,196,210,220,221,222,245,247,335,136,17,99,100,168,97,162,175,98,198,22,60,61,170,172,178)--UNIDADES AGAMENOM
                OR TMA.CD_FILA_SENHA   IN (25,26,27,43,44,45,53,/*54,55,56,57,*/58,/*59,*/164,165,171,174,/*228,229,*/230,/*233,234,235,*/278,332,343,345,346)) --UNIDADES BV)
            
            ORDER BY ATE.CD_ATENDIMENTO, DH_PROCESSO DESC 