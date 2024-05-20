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
,'szOZGBvt00ZLw7oDw_4N5B','WHATSAPP - CHATBOT'
,'MGv_R8VVwCzbwz9jIBPZrJ','WHATSAPP - ENVIO DE TOKEN AO PACIENTE'
,'kbXsjKGB5bHcCnjMhhLArU','WHATSAPP - TESTE CENTRAL DE CADASTRO - DADOS'
,'mMkcXPWc1kBugcA4KDDuKD','WHATSAPP - TESTE STI - QUESTIONARIO'
,'ohX2ZW75eHwgOkbvvrUxrr','WHATSAPP - TESTE CENTRAL DE CADASTRO - DADOS2'
,'PurJLn61K5Opl7DnIw4UAH','WHATSAPP - TESTE CENTRAL DE CADASTRO - DADOS3'
,'rCeGFv4VbubIfOG4bU4LB1','WHATSAPP - TESTE CENTRAL DE CADASTRO - LEITO CIRURGICO'
,'rSG8OnSrO0MKRkWbsaOO2G','WHATSAPP - TESTE MV'
,'SdW087JXnKWp8cdVkavKzb','WHATSAPP - TESTE CENTRAL DE CADASTRO - PESQUISA DE ATOR EXTERNO'
,'xjkjnbU7s4gORiGNJ31ZGT','WHATSAPP - TESTE STI - OLD TROCA DE MEDICO'
,'zdaZIkkWbr00a_Lhvel954','WHATSAPP - TESTE STI - OLD EXAMES PERIODICOS'
) FLUXO,
TO_DATE (TRUNC(AHP.START_TIME_)) AS DATE_,
AHP.START_TIME_, 
AHP.END_TIME_, 
AHP.STATE_,
AHV.FLOW_BOT_API_PHONE,
AHV.FLOW_BOT_API_QUIZ_ID,
AHV.FLOW_SN_EXPIRADO,
AHV.W_NM_PACIENTE,
--NVL (NVL (AHV.W_NR_FONE_CONTATO,AHV.W_FONE),AHV.W_VNM_FONE_CONTATO) AS W_NR_FONE_CONTATO,
AHV.W_PRESTADOR_CRIACAO,
AHV.WACONJ_DH_FECHAMENTO,
AHV.WACONJ_PRESTADOR_FINAL,
AHV.WAGEXSED_DS_ITEM_AGENDAMENTO,
AHV.WAGEXSED_HR_AGENDA,
AHV.WAGEXSED_NM_SETOR,
AHV.WMOVLEI_CD_PRESTADOR,
AHV.WMOVLEI_DS_LEITO,
AHV.WMOVLEI_DS_UNID_INT,
AHV.WTMREP_APROVADO,
AHV.WTMREP_CD_ATENDIMENTO,
AHV.WTMREP_PRESTADOR_RESPOSTA,
AHV.WTMSOL_ESPECIALIDADE,
AHV.WTOKEN_DS_PACIENTE,
AHV.WTOKEN_DS_TOKEN

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
                      'BOT_API_PHONE' AS FLOW_BOT_API_PHONE,
                      'BOT_API_QUIZ_ID' AS FLOW_BOT_API_QUIZ_ID,
                      'SN_EXPIRADO' AS FLOW_SN_EXPIRADO,
                      'FONE' AS W_FONE,
                      'NM_PACIENTE' AS W_NM_PACIENTE,
                      'NR_FONE_CONTATO' AS W_NR_FONE_CONTATO,
                      'PRESTADOR_CRIACAO' AS W_PRESTADOR_CRIACAO,
                      'VNM_FONE_CONTATO' AS W_VNM_FONE_CONTATO,
                      'DH_FECHAMENTO' AS WACONJ_DH_FECHAMENTO,
                      'PRESTADOR_FINAL' AS WACONJ_PRESTADOR_FINAL,
                      'DS_ITEM_AGENDAMENTO' AS WAGEXSED_DS_ITEM_AGENDAMENTO,
                      'HR_AGENDA' AS WAGEXSED_HR_AGENDA,
                      'NM_SETOR' AS WAGEXSED_NM_SETOR,
                      'CD_PRESTADOR' AS WMOVLEI_CD_PRESTADOR,
                      'DS_LEITO' AS WMOVLEI_DS_LEITO,
                      'DS_UNID_INT' AS WMOVLEI_DS_UNID_INT,
                      'APROVADO' AS WTMREP_APROVADO,
                      'CD_ATENDIMENTO' AS WTMREP_CD_ATENDIMENTO,
                      'PRESTADOR_RESPOSTA' AS WTMREP_PRESTADOR_RESPOSTA,
                      'ESPECIALIDADE' AS WTMSOL_ESPECIALIDADE,
                      'DS_PACIENTE' AS WTOKEN_DS_PACIENTE,
                      'DS_TOKEN' AS WTOKEN_DS_TOKEN
            
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
                ,'MGv_R8VVwCzbwz9jIBPZrJ' --WHATSAPP - ENVIO DE TOKEN AO PACIENTE
                ,'kbXsjKGB5bHcCnjMhhLArU' --WHATSAPP - DADOS
                ,'mMkcXPWc1kBugcA4KDDuKD' --WHATSAPP - TESTE STI QUESTIONARIO
                ,'ohX2ZW75eHwgOkbvvrUxrr' --WHATSAPP - DADOS 2
                ,'PurJLn61K5Opl7DnIw4UAH' --WHATSAPP - DADOS 3
                ,'rCeGFv4VbubIfOG4bU4LB1' --WHATSAPP - LEITO CIRURGICO TESTE
                ,'rSG8OnSrO0MKRkWbsaOO2G' --WHATSAPP - TESTE MV
                ,'SdW087JXnKWp8cdVkavKzb' --WHATSAPP - PESQUISA DE ATOR EXTERNO
                ,'xjkjnbU7s4gORiGNJ31ZGT' --WHATSAPP - OLD TROCA DE MEDICO
                ,'zdaZIkkWbr00a_Lhvel954' --WHATSAPP - OLD EXAMES PERIODICOS
                )
        

order by AHP.START_TIME_ DESC , AHP.END_TIME_ desc
;
SELECT * FROM ENGINE.ACT_HI_VARINST
WHERE PROC_INST_ID_= 'fdad73e3-f08a-11ee-9252-0242ac120016'