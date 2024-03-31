SELECT
    SUBSTR(AHV.CD_REGISTRO, 21)AS CD_REGISTRO,
    AHP.NAME_ AS DESCRICAO_ETAPA,
    TO_CHAR (AHP.START_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_INICIO,
    TO_CHAR (AHP.END_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_FINAL,
    TRUNC(AHP.DURATION_ / (1000 * 60 * 60)) || ':' || LPAD(TRUNC(AHP.DURATION_ / (1000 * 60)), 2, '0') || ':' || LPAD(MOD(AHP.DURATION_, (1000 * 60)), 2, '0') AS SLA,
    AHV.CD_ATENDIMENTO,
    AHV.CD_AVISO,
    AHV.CD_DOCUMENTO,
    AHV.CD_PRONTUARIO,
    AHV.DS_BLOCO,
    AHV.DS_CONVENIO,
    AHV.DS_OBS_PENDENCIA,
    AHV.DS_OBS_SOLICITACAO,
    AHV.DS_RESP_PENDENCIA,
    AHV.DT_AVISO,
    AHV.NM_PACIENTE,
    AHV.NM_SOLICITANTE,
    AHV.NR_DRT_SOLICITANTE,
    AHV.TP_GUIA_AUTORIZADA,
    AHV.TP_PENDENCIA,
    AHV.TP_SOLICITACAO

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
                'BUSINESS_KEY_CASE_INSENSITIVE' AS CD_REGISTRO,
                'AT_OPME_1' AS CD_ATENDIMENTO,
                'AC_OPME_1' AS CD_AVISO,
                'PAR_REGISTRY_ID' AS CD_DOCUMENTO,
                'PAC_OPME_1' AS CD_PRONTUARIO,
                'NMBL_OPME_1' AS DS_BLOCO,
                'CONV_OPME_1' AS DS_CONVENIO,
                'SIN_PEND_OPME_1' AS DS_OBS_PENDENCIA,
                'OBS_OPME_1' AS DS_OBS_SOLICITACAO,
                'OPME_ANX_OBS_PEND45' AS DS_RESP_PENDENCIA,
                'OPME_DT_AVISO_CIRURGIA164' AS DT_AVISO,
                'NM_OPME_1' AS NM_PACIENTE,
                'NMREG_OPME_1' AS NM_SOLICITANTE,
                'REG_OPME_1' AS NR_DRT_SOLICITANTE,
                'AUTORIZADO_TX_GUIA102' AS TP_GUIA_AUTORIZADA,
                'PEND_OPME_1' AS TP_PENDENCIA,
                'OPME_CMP_RE_OR_TG247' AS TP_SOLICITACAO
                )
            )
    ) AHV,
    ENGINE.ACT_HI_TASKINST AHP

WHERE
    AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
    AND AHP.START_TIME_ BETWEEN TO_DATE ('01/09/2023', 'DD/MM/YYYY')
    AND SYSDATE + 1
    AND UPPER (AHV.CD_REGISTRO) LIKE 'OPME E NOTA DE SALA%'
    
ORDER BY
    AHP.START_TIME_ DESC,
    CD_REGISTRO;