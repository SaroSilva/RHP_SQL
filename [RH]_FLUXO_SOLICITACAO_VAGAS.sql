  SELECT
    SUBSTR(AHP.BUSINESS_KEY_, 34)AS CD_REGISTRO,
    --AHP.NAME_ AS DESCRICAO_ETAPA,
    AHP.START_TIME_ AS DT_ABERTURA,
    AHP.END_TIME_ AS DT_FECHAMENTO,
    --AHP.DURATION_ AS SLA,
    --TRUNC(AHP.DURATION_ / (1000 * 60 * 60 * 60)) || ':' || LPAD(TRUNC(AHP.DURATION_ / (1000 * 60 * 60)), 2, '0') || ':' || LPAD(TRUNC(AHP.DURATION_ / (1000 * 60)), 2, '0') || ':'|| LPAD(MOD(AHP.DURATION_, (1000 * 60)), 2, '0') AS SLA,
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
                    'NOME_DO_SUBSTITUIDO_OU_DESLIGADO837' AS colaborador,
                    'COLABORADOR_PROMOVIDO' AS NM_PROMOVIDO,
                    'PAR_REGISTRY_ID' AS CD_DOC,
                    'INSTANCE_USER' AS drt_solicitante,
                    'NOME_DO_SOLICITANTE_VFINAL719' AS nm_solicitante,
                    'SOLICITACAO_HOMOLOGADA547' AS tp_homologacao,
                    'MOTIVO694' AS tp_motivo,
                    'JUSTIFICATIVA473' AS ds_jus_DESLIGAMENTO_SUBS,
                    'JUSTIFICATIVA862' AS ds_jus_PROMOCAO
                )
            )
    ) AHV,
    ENGINE.ACT_HI_PROCINST AHP

WHERE
    AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
    AND AHP.START_TIME_ BETWEEN TO_DATE ('01/01/2023', 'DD/MM/YYYY')
    AND SYSDATE + 1
    AND UPPER (AHP.BUSINESS_KEY_) LIKE 'SOLICITAÇÃO DE ABERTURA DE VAGA%'
    AND DRT_SOLICITANTE = 31209
    
ORDER BY
    AHP.START_TIME_ DESC,
    CD_REGISTRO