SELECT 
AHP.PROC_INST_ID_, 
SUBSTR (AHP.BUSINESS_KEY_,25) ID_,
DECODE (AHP.PROC_DEF_KEY_,'WFZXJvURsopvJRp_t2iCbo','WHATSAPP - NOTIFICAÇÃO DA SOLICITAÇÃO ACOMPANHAMENTO CONJUNTO') FLUXO,
TO_DATE (TRUNC(AHP.START_TIME_)) AS DATE_,
AHP.START_TIME_, 
AHP.END_TIME_, 
AHP.STATE_,
AHV.WACONJ_SN_EXPIRADO,
AHV.WACONJ_PRESTADOR_FINAL,
AHV.WACONJ_NM_PACIENTE,
AHV.WACONJ_DH_FECHAMENTO,
AHV.WACONJ_PRESTADOR_CRIACAO,
AHV.WACONJ_BOT_API_QUIZ_ID1,
AHV.WACONJ_BOT_API_PHONE1,
AHV.WACONJ_BOT_API_QUIZ_ID2,
AHV.WACONJ_BOT_API_PHONE2,
AHV.WACONJ_BOT_API_QUIZ_ID3,
AHV.WACONJ_BOT_API_PHONE3
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
                    'SN_EXPIRADO' AS WACONJ_SN_EXPIRADO,
                    'PRESTADOR_FINAL' AS WACONJ_PRESTADOR_FINAL,
                    'NM_PACIENTE' AS WACONJ_NM_PACIENTE,
                    'DH_FECHAMENTO' AS WACONJ_DH_FECHAMENTO,
                    'PRESTADOR_CRIACAO' AS WACONJ_PRESTADOR_CRIACAO,
                    'BOT_API_QUIZ_ID' AS WACONJ_BOT_API_QUIZ_ID1,
                    'BOT_API_PHONE' AS WACONJ_BOT_API_PHONE1,
                    'BOT_API_QUIZ_ID' AS WACONJ_BOT_API_QUIZ_ID2,
                    'BOT_API_PHONE' AS WACONJ_BOT_API_PHONE2,
                    'BOT_API_QUIZ_ID' AS WACONJ_BOT_API_QUIZ_ID3,
                    'BOT_API_PHONE' AS WACONJ_BOT_API_PHONE3
                        )
                     )
    ) AHV, ENGINE.ACT_HI_PROCINST AHP
        WHERE AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
        AND AHP.PROC_DEF_KEY_ IN('WFZXJvURsopvJRp_t2iCbo') --whats_acompanhamento_conjunto
                

order by AHP.START_TIME_ desc , AHP.END_TIME_ desc