SELECT
    SUBSTR(AHP.BUSINESS_KEY_, 28) AS CD_REGISTRO,
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
            'REL1' AS CD_CONSELHO,
            'REL2' AS NM_COLABORADOR,
            'REL3' AS DT_REGISTRO,
            'ESPECIALID_PRINCIPAL_MEDICO71' AS DS_ESPECIALIDADE,
            'INSTANCE_USER' AS CD_USER,
            'PAR_REGISTRY_ID' AS CD_DOCUMENTO,
            'RELAC_MEDICO' AS TP_RELACIONAMENTO,
            'REL27' AS DS_RELACIONAMENTO,
            'CADASTRO_PREST' AS TP_MATERNIDADE,
            'REL29' AS DS_MATERNIDADE,
            'COMERCIAL_REL' AS TP_COMERCIAL,
            'REL31' AS DS_COMERCIAL,
            'REGULA_REL' AS TP_REGULACAO,
            'REL33' AS DS_REGULACAO,
            'INTELIG_REL' AS TP_INTELI_MERC,
            'REL34' AS DS_INTELI_MERC,
            'REPASSE_REL' AS TP_REPASSE_MEDICO,
            'REL32' AS DS_REPASSE_MEDICO,
            'ST_BLCIR' AS TP_BLOCO_CIR,
            'RLM_DS_BLOCO_CIR747' AS DS_BLOCO_CIR,
            'ST_TECINF' AS TP_TECNOLOGIA,
            'RLM_DS_TEC28' AS DS_TECNOLOGIA
        )   )
    )AHV,
ENGINE.ACT_HI_PROCINST AHP
WHERE
    AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
    AND AHP.START_TIME_ BETWEEN TO_DATE ('01/09/2023', 'DD/MM/YYYY')AND SYSDATE + 1
    AND  AHP.BUSINESS_KEY_ LIKE '[RLM] REGISTRAR OCORR%'

ORDER BY
    AHP.START_TIME_ DESC;