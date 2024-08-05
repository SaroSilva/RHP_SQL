SELECT
    SUBSTR(AHV.CD_REGISTRO, 29)AS CD_REGISTRO,
    AHV.PROC_INST_ID_,
    AHT.NAME_ AS DESCRICAO_ETAPA,
    TO_CHAR (AHT.START_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_INICIO,
    TO_CHAR (AHT.END_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_FINAL,
    TRUNC(AHT.DURATION_ / (1000 * 60 * 60)) || ':' || LPAD(TRUNC(AHT.DURATION_ / (1000 * 60)), 2, '0') || ':' || LPAD(MOD(AHT.DURATION_, (1000 * 60)), 2, '0') AS SLA,
    AHV.DRT_REGISTRANTE,
    AHV.NM_REGISTRANTE,
    AHV.DRT_SOLICITANTE,
    AHV.NM_SOLICITANTE,
    AHV.DS_EMAIL_SOL,
    AHV.TP_LICENÇA,
    AHV.TP_STATUS

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
                'BUSINESS_KEY_CASE_INSENSITIVE' AS CD_REGISTRO,
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
    ENGINE.ACT_HI_TASKINST AHT

WHERE
    AHT.PROC_INST_ID_ = AHV.PROC_INST_ID_
    AND AHT.START_TIME_ BETWEEN TO_DATE ('01/01/2024', 'DD/MM/YYYY')
    AND SYSDATE + 1
    AND UPPER (AHV.CD_REGISTRO) LIKE 'SOLICITAÇÃO DO USUÁRIO (BI)%'
    
ORDER BY
 CD_REGISTRO,
    AHT.START_TIME_ DESC
    ;