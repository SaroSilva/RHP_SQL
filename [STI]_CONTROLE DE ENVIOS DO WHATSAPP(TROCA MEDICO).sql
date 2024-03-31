SELECT 
AHP.PROC_INST_ID_, 
AHP.BUSINESS_KEY_,
DECODE (AHP.PROC_DEF_KEY_
,'lzKmxgtIrzstPKWDixwDvk','WHATSAPP - NOTIFICAÇÃO DA RESPOSTA TROCA DE MÉDICO'
,'NkEjiK01kJLG_LKmvJLfnz','WHATSAPP - NOTIFICAÇÃO DA SOLICITAÇÃO TROCA DE MÉDICO') FLUXO,
TO_DATE (TRUNC(AHP.START_TIME_)) AS DATE_,
AHP.START_TIME_, 
AHP.END_TIME_, 
AHP.STATE_,
AHV.WTRM_BOT_API_QUIZ_ID,
AHV.WTRM_BOT_API_PHONE,
AHV.WTRM_CD_ATENDIMENTO,
AHV.WTRM_ESPECIALIDADE,
AHV.WTRM_CONTATO_FONE,
AHV.WTRM_PACIENTE,
AHV.WTRM_SOLICITANTE,
AHV.WTRM_SN_EXPIRADO
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
                    1,2
            ) ahv 
            PIVOT (
                MAX(TEXT_) FOR name_ IN (
                    'BOT_API_QUIZ_ID' AS WTRM_BOT_API_QUIZ_ID,
                    'BOT_API_PHONE'   AS WTRM_BOT_API_PHONE,
                    'CD_ATENDIMENTO'  AS WTRM_CD_ATENDIMENTO,
                    'ESPECIALIDADE'   AS WTRM_ESPECIALIDADE,
                    'FONE'            AS WTRM_CONTATO_FONE,
                    'NM_PACIENTE'     AS WTRM_PACIENTE,
                    'PRESTADOR_CRIACAO' AS WTRM_SOLICITANTE,
                    'SN_EXPIRADO'     AS WTRM_SN_EXPIRADO
                    
                        )
                     )
    ) AHV, ENGINE.ACT_HI_PROCINST AHP
        WHERE AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
        AND AHP.PROC_DEF_KEY_ IN(
                'lzKmxgtIrzstPKWDixwDvk' --Whatsapp_troca_medico_resposta
                ,'NkEjiK01kJLG_LKmvJLfnz' --Whatsapp_troca_medico_solicitação 

                )

order by AHP.START_TIME_ desc , AHP.END_TIME_ desc