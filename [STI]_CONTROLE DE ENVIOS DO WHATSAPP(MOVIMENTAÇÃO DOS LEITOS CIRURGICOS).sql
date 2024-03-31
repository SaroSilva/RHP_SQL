SELECT 
AHP.PROC_INST_ID_, 
SUBSTR (AHP.BUSINESS_KEY_,21) ID_,
DECODE (AHP.PROC_DEF_KEY_,'LZKXm1WMN5vnmxKrtiJxXS','WHATSAPP - NOTIFICAÇÃO DA MOVIMENTAÇÃO DE LEITO DO PACIENTE CIRÚRGICO OFICIAL') FLUXO,
TO_DATE (TRUNC(AHP.START_TIME_)) AS DATE_,
AHP.START_TIME_, 
AHP.END_TIME_, 
AHP.STATE_,
AHV.WMOVLEI_NR_FONE_CONTATO,
AHV.WMOVLEI_DS_LEITO,
AHV.WMOVLEI_CD_PRESTADOR,
(SELECT NM_PRESTADOR FROM PRESTADOR WHERE CD_PRESTADOR = AHV.WMOVLEI_CD_PRESTADOR) NM_PRESTADOR,
AHV.WMOVLEI_NM_PACIENTE,
AHV.WMOVLEI_DS_UNID_INT,
AHV.WMOVLEI_BOT_API_QUIZ_ID,
AHV.WMOVLEI_BOT_API_PHONE
FROM
    (
        select * From(
                select
                    PROC_INST_ID_,
                    name_,
                    TEXT_
                from
                    engine.act_hi_varinst
                order by
                    2
            ) ahv 
            PIVOT (
                MAX(TEXT_) FOR name_ IN (
                    'NR_FONE_CONTATO' AS WMOVLEI_NR_FONE_CONTATO,
                    'DS_LEITO' AS WMOVLEI_DS_LEITO,
                    'CD_PRESTADOR' AS WMOVLEI_CD_PRESTADOR,
                    'NM_PACIENTE' AS WMOVLEI_NM_PACIENTE,
                    'DS_UNID_INT' AS WMOVLEI_DS_UNID_INT,
                    'BOT_API_QUIZ_ID' AS WMOVLEI_BOT_API_QUIZ_ID,
                    'BOT_API_PHONE' AS WMOVLEI_BOT_API_PHONE
                        )
                     )
    ) AHV, ENGINE.ACT_HI_PROCINST AHP
        WHERE AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
        AND AHP.PROC_DEF_KEY_ IN('LZKXm1WMN5vnmxKrtiJxXS')--LEITO DO PACIENTE CIRÚRGICO OFICIAL                

order by AHP.START_TIME_ desc , AHP.END_TIME_ desc