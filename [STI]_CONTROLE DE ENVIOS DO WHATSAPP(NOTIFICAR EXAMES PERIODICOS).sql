SELECT 
AHP.PROC_INST_ID_, 
SUBSTR(AHP.BUSINESS_KEY_,21) ID_,
DECODE (AHP.PROC_DEF_KEY_,'idKUC3AW9CbuSeTsZ2o_kE','WHATSAPP - NOTIFICAÇÃO DE EXAMES PERIÓDICOS') FLUXO,
TO_DATE (TRUNC(AHP.START_TIME_)) AS DATE_,
AHP.START_TIME_, 
AHP.END_TIME_, 
AHP.STATE_,
AHV.WEXPERIO_NM_PACIENTE,
AHV.WEXPERIO_VNM_FONE_CONTATO,
AHV.WEXPERIO_BOT_API_QUIZ_ID,
AHV.WEXPERIO_BOT_API_PHONE,
AHV.WEXPERIO_SN_EXPIRADO
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
                    'NM_PACIENTE' AS WEXPERIO_NM_PACIENTE,
                    'VNM_FONE_CONTATO' AS WEXPERIO_VNM_FONE_CONTATO,
                    'BOT_API_QUIZ_ID' AS WEXPERIO_BOT_API_QUIZ_ID,
                    'BOT_API_PHONE' AS WEXPERIO_BOT_API_PHONE,
                    'SN_EXPIRADO' AS WEXPERIO_SN_EXPIRADO
                        )
                     )
    ) AHV, ENGINE.ACT_HI_PROCINST AHP
        WHERE AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
        AND AHP.PROC_DEF_KEY_ IN('idKUC3AW9CbuSeTsZ2o_kE') --Whatsapp - notificação de exames periodicos

order by AHP.START_TIME_ desc , AHP.END_TIME_ desc