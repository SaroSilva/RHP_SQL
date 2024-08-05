        (SELECT * FROM
            (SELECT * FROM
                (SELECT
                    ATE.CD_ATENDIMENTO,
                    PAC.NM_PACIENTE,
                    ATE.CD_ORI_ATE,
                    ATE.CD_CONVENIO,
                    ATE.DT_ATENDIMENTO,
                    PMD.CD_PRE_MED,
                    PMD.HR_PRE_MED,
                    SSP.CD_SOLSAI_PRO,
                    SSP.HR_SOLSAI_PRO,
                    SSP.TP_SITUACAO,
                    MAX(MES.HR_MVTO_ESTOQUE) AS DH_DISPENSACAO_FARM,
                    MAX(HIPC.DH_CHECAGEM) AS DH_CHECAGEM,
                    (
                        RANK() OVER (
                            PARTITION BY ATE.CD_ATENDIMENTO
                            ORDER BY
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
                    AND IPM.CD_ITPRE_MED = HIPC.CD_ITPRE_MED(+) --AND IPM.CD_ITPRE_MED = IME.CD_ITPRE_MED
                    AND IME.CD_ITSOLSAI_PRO(+) = ISSP.CD_ITSOLSAI_PRO
                    AND PAC.CD_PACIENTE = ATE.CD_PACIENTE
                    /*FILTROS*/
                    AND ATE.DT_ALTA IS NULL
                    AND ATE.DT_ATENDIMENTO >= TRUNC (SYSDATE)
                    AND ATE.TP_ATENDIMENTO = 'U' --AND ATE.CD_ORI_ATE = 2
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