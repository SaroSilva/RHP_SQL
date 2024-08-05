
SELECT * FROM sinal_vital
;



SELECT * FROM coleta_sinal_vital
WHERE cd_atendimento = 2734935
ORDER BY data_coleta DESC
;



SELECT * FROM coleta_sinal_vital
WHERE CD_COLETA_SINAL_VITAL like '738831%'
ORDER BY CD_COLETA_SINAL_VITAL  desc
                                    ;