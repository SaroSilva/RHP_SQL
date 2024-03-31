SELECT 
AHP.PROC_INST_ID_, 
SUBSTR (AHP.BUSINESS_KEY_,21) ID_,
DECODE (AHP.PROC_DEF_KEY_,'HXiWnXlbEUN7lRF_0gMKJ6','WHATSAPP - NOTIFICAÇÃO AGENDAMENTO COM SEDAÇÃO') FLUXO,
TO_DATE (TRUNC(AHP.START_TIME_)) AS DATE_,
AHP.START_TIME_, 
AHP.END_TIME_, 
AHP.STATE_,
AHV.WAGEXSED_SN_EXPIRADO,
AHV.WAGEXSED_DS_ITEM_AGENDAMENTO,
AHV.WAGEXSED_NR_FONE_CONTATO,
AHV.WAGEXSED_HR_AGENDA,
AHV.WAGEXSED_NM_SETOR,
AHV.WAGEXSED_BOT_API_QUIZ_ID,
AHV.WAGEXSED_BOT_API_PHONE
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
                    'SN_EXPIRADO' AS WAGEXSED_SN_EXPIRADO,
                    'DS_ITEM_AGENDAMENTO' AS WAGEXSED_DS_ITEM_AGENDAMENTO,
                    'NR_FONE_CONTATO' AS WAGEXSED_NR_FONE_CONTATO,
                    'HR_AGENDA' AS WAGEXSED_HR_AGENDA,
                    'NM_SETOR' AS WAGEXSED_NM_SETOR,
                    'BOT_API_QUIZ_ID' AS WAGEXSED_BOT_API_QUIZ_ID,
                    'BOT_API_PHONE' AS WAGEXSED_BOT_API_PHONE
                        )
                     )
    ) AHV, ENGINE.ACT_HI_PROCINST AHP
        WHERE AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
        AND AHP.PROC_DEF_KEY_ IN('HXiWnXlbEUN7lRF_0gMKJ6') --whatsapp_agendamento_sedacao
                
order by AHP.START_TIME_ desc , AHP.END_TIME_ desc