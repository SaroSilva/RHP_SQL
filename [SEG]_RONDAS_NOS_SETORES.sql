SELECT
    SUBSTR(AHP.BUSINESS_KEY_, 22) AS CD_REGISTRO,
    TO_CHAR(AHP.START_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_INICIO,
    TO_CHAR(AHP.END_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_FINAL,
    TRUNC(AHP.DURATION_ / (1000 * 60 * 60)) || ':' || LPAD(TRUNC(AHP.DURATION_ / (1000 * 60)), 2, '0') || ':' || LPAD(MOD(AHP.DURATION_, (1000 * 60)), 2, '0') AS SLA,
    AHV.*
FROM
    (
        SELECT
            *
        FROM
            (
                SELECT
                    PROC_INST_ID_,
                    name_,
                    TEXT_
                FROM
                    engine.act_hi_varinst
                ORDER BY
                    2
            ) ahv PIVOT (
                MAX(TEXT_) FOR name_ IN (
                    'PAR_REGISTRY_ID' AS CD_DOCUMENTO,
                    'ASSINADO_POR_DRT873' AS CD_DRT_ENTREVISTADO,
                    'NM_USUARIO_ASSINADO217' AS NM_ENTREVISTADO,
                    'INSTANCE_USER' AS CD_DRT_REGISTRANTE,
                    'DRT357' AS NM_REGISTRANTE,
                    'SETOR_D_ORIGEM881' AS DS_LOCAL,
                    'OK_QRU_ALERT_AUDIO847' AS TP_ALERTA_AUDIO,
                    'OK_QRU_BIO547' AS TP_BIOMETRIA,
                    'OK_OU_QRU667' AS TP_CATRACA,
                    'OK_QRU_CH_EMER88' AS TP_CHAVES_EMERG,
                    'OK_QRU_CS_MAQ323' AS TP_CS_MAQUINA,
                    'OK_QRU_PT_BASTAO37' AS TP_PONTO_BASTAO,
                    'OK_QRU_PORTAS723' AS TP_PORTA,
                    'OK_QRU_SHAFTS193' AS TP_SHAFT,
                    'OUTROS59' AS TP_OUTROS,
                    'OBS_OCORRENCIAS936' AS DS_OBS_OCORRENCIA
                )
            )
    ) AHV,
    ENGINE.ACT_HI_PROCINST AHP
WHERE
    AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
    AND AHP.START_TIME_ BETWEEN TO_DATE('01/09/2023', 'DD/MM/YYYY') AND SYSDATE + 1
    AND AHP.BUSINESS_KEY_ LIKE 'CHECKLIST_DE_VISITAS%'
ORDER BY
    AHP.START_TIME_ DESC;
