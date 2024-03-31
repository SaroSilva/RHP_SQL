SELECT
    SUBSTR(AHP.BUSINESS_KEY_, 29) AS CD_REGISTRO,
    AHT.NAME_ AS DESCRICAO_ETAPA,
    TO_CHAR (AHP.START_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_INICIO,
    TO_CHAR (AHP.END_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_FINAL,
    TRUNC(AHP.DURATION_ / (1000 * 60 * 60)) || ':' || LPAD(TRUNC(AHP.DURATION_ / (1000 * 60)), 2, '0') || ':' || LPAD(MOD(AHP.DURATION_, (1000 * 60)), 2, '0') AS SLA,
    AHV.*
FROM
    (
        select
            *
        from
            (
                select
                    PROC_INST_ID_,
                    name_,
                    TEXT_
                from
                    engine.act_hi_varinst
                order by
                    2
            ) ahv PIVOT (
                MAX(TEXT_) FOR name_ IN (
                'PAR_REGISTRY_ID' AS CD_DOC,
                --'BUSINESS_KEY_CASE_INSENSITIVE' AS CD_REGISTRO,
                'INSTANCE_USER' AS DRT_REGISTRANTE,
                'DRT_INFRA790' AS DRT_SOLICITANTE,
                'EMAIL_INFRA899' AS DS_EMAIL_SOL,
                'SETOR_INFRA115' AS DS_SETOR,
                'BI_USUARIO_LOGADO634' AS NM_REGISTRANTE,
                'NM_INFRA590' AS NM_SOLICITANTE,
                'BI_BIPREMIUM909' AS TP_LICENÇA,
                'BI_APROVADO_NAO_APROVADO231' AS TP_STATUS
                )
            )
    ) AHV,
    ENGINE.ACT_HI_PROCINST AHP, ENGINE.ACT_HI_TASKINST AHT
WHERE
    AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
    AND AHP.PROC_INST_ID_ = AHT.PROC_INST_ID_
    AND AHP.START_TIME_ BETWEEN TO_DATE ('01/01/2024', 'DD/MM/YYYY')
    AND SYSDATE + 1
    AND AHP.BUSINESS_KEY_ LIKE 'SOLICITAÇÃO DO USUÁRIO (BI)%'
ORDER BY
    AHP.START_TIME_ DESC; 