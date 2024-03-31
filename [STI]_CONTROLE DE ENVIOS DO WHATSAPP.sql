SELECT 
AHP.PROC_INST_ID_, 
AHP.BUSINESS_KEY_,
DECODE (AHP.PROC_DEF_KEY_
,'HXiWnXlbEUN7lRF_0gMKJ6','WHATSAPP - NOTIFICAÇÃO AGENDAMENTO COM SEDAÇÃO'
,'idKUC3AW9CbuSeTsZ2o_kE','WHATSAPP - NOTIFICAÇÃO DE EXAMES PERIÓDICOS'
,'lzKmxgtIrzstPKWDixwDvk','WHATSAPP - NOTIFICAÇÃO DA RESPOSTA TROCA DE MÉDICO'
,'WFZXJvURsopvJRp_t2iCbo','WHATSAPP - NOTIFICAÇÃO DA SOLICITAÇÃO ACOMPANHAMENTO CONJUNTO'
,'NkEjiK01kJLG_LKmvJLfnz','WHATSAPP - NOTIFICAÇÃO DA SOLICITAÇÃO TROCA DE MÉDICO'
,'LZKXm1WMN5vnmxKrtiJxXS','WHATSAPP - NOTIFICAÇÃO DA MOVIMENTAÇÃO DE LEITO DO PACIENTE CIRÚRGICO OFICIAL'
,'szOZGBvt00ZLw7oDw_4N5B','WHATSAPP - CHATBOT') FLUXO,
TO_DATE (TRUNC(AHP.START_TIME_)) AS DATE_,
AHP.START_TIME_, 
AHP.END_TIME_, 
AHP.STATE_,
AHV.WMOVLEI_NR_FONE_CONTATO,
AHV.WMOVLEI_DS_LEITO,
AHV.WMOVLEI_CD_PRESTADOR,
AHV.WMOVLEI_NM_PACIENTE,
AHV.WMOVLEI_DS_UNID_INT,
AHV.WMOVLEI_BOT_API_QUIZ_ID,
AHV.WMOVLEI_BOT_API_PHONE,
AHV.WEXPERIO_NM_PACIENTE,
AHV.WEXPERIO_VNM_FONE_CONTATO,
AHV.WEXPERIO_BOT_API_QUIZ_ID,
AHV.WEXPERIO_BOT_API_PHONE,
AHV.WEXPERIO_SN_EXPIRADO,
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
AHV.WACONJ_BOT_API_PHONE3,
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
                    'NR_FONE_CONTATO' AS WMOVLEI_NR_FONE_CONTATO,
                    'DS_LEITO' AS WMOVLEI_DS_LEITO,
                    'CD_PRESTADOR' AS WMOVLEI_CD_PRESTADOR,
                    'NM_PACIENTE' AS WMOVLEI_NM_PACIENTE,
                    'DS_UNID_INT' AS WMOVLEI_DS_UNID_INT,
                    'BOT_API_QUIZ_ID' AS WMOVLEI_BOT_API_QUIZ_ID,
                    'BOT_API_PHONE' AS WMOVLEI_BOT_API_PHONE,
                    'NM_PACIENTE' AS WEXPERIO_NM_PACIENTE,
                    'VNM_FONE_CONTATO' AS WEXPERIO_VNM_FONE_CONTATO,
                    'BOT_API_QUIZ_ID' AS WEXPERIO_BOT_API_QUIZ_ID,
                    'BOT_API_PHONE' AS WEXPERIO_BOT_API_PHONE,
                    'SN_EXPIRADO' AS WEXPERIO_SN_EXPIRADO,
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
                    'BOT_API_PHONE' AS WACONJ_BOT_API_PHONE3,
                    'SN_EXPIRADO' AS WAGEXSED_SN_EXPIRADO,
                    'DS_ITEM_AGENDAMENTO' AS WAGEXSED_DS_ITEM_AGENDAMENTO,
                    'NR_FONE_CONTATO' AS WAGEXSED_NR_FONE_CONTATO,
                    'HR_AGENDA' AS WAGEXSED_HR_AGENDA,
                    'NM_SETOR' AS WAGEXSED_NM_SETOR,
                    'BOT_API_QUIZ_ID' AS WAGEXSED_BOT_API_QUIZ_ID,
                    'BOT_API_PHONE' AS WAGEXSED_BOT_API_PHONE,
                    'BOT_API_QUIZ_ID' AS WCHAT_BOT_API_QUIZ_ID,
                    'BOT_API_PHONE' AS WCHAT_BOT_API_PHONE,
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
                'HXiWnXlbEUN7lRF_0gMKJ6'  --whatsapp_agendamento_sedacao
                ,'idKUC3AW9CbuSeTsZ2o_kE' --Whatsapp - notificação de exames periodicos
                ,'lzKmxgtIrzstPKWDixwDvk' --Whatsapp_troca_medico_resposta
                ,'WFZXJvURsopvJRp_t2iCbo' --whats_acompanhamento_conjunto
                ,'NkEjiK01kJLG_LKmvJLfnz' --Whatsapp_troca_medico_solicitação 
                ,'LZKXm1WMN5vnmxKrtiJxXS' --LEITO DO PACIENTE CIRÚRGICO OFICIAL
                ,'szOZGBvt00ZLw7oDw_4N5B' --Whatsapp ChatBoot
                )

order by AHP.START_TIME_ desc , AHP.END_TIME_ desc