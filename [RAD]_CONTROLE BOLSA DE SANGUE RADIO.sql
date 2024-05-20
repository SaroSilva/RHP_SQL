SELECT * FROM ENGINE.ACT_HI_VARINST
WHERE 
--TEXT_ LIKE '%iahz'
PROC_INST_ID_ = 'd31258b1-ed2d-11ee-9252-0242ac120016'
;
GRANT SELECT ON DBAMV.VDES_USUARIOS TO REMWEB;
GRANT SELECT ON ENGINE.ACT_HI_PROCINST TO REMWEB;
GRANT SELECT ON ENGINE.ACT_HI_VARINST TO REMWEB;

SELECT  
SUBSTR (AHP.BUSINESS_KEY_,32) ID_,
AHT.NAME_,
AHP.START_TIME_, 
AHP.END_TIME_, 
AHP.STATE_,
AHV.NM_BANCO_SANGUE,
AHV.CD_BOLSA_SANGUE,
AHV.NR_SEGMENTO,
AHV.DS_HEMOCOMPONENTE,
AHV.TP_SANGUE,
AHV.TP_FATOR_RH,
AHV.CD_DRT_ABERTURA,
VDU.NM_USUARIO AS NM_USUARIO_ABERTURA,
AHV.HR_RECEBIMENTO,
TO_DATE (SUBSTR (AHV.DT_IRRADIADO,1,10),'YYYY/MM/DD') AS DH_IRRADIADO,
AHV.HR_IRRADIADO,
AHT.ASSIGNEE_ AS CD_DRT_FINALIZADO,
(SELECT NM_USUARIO FROM DBASGU.USUARIOS WHERE CD_USUARIO = AHT.ASSIGNEE_) NM_USUARIO_FINALIZADOR,
CASE
                  WHEN SUBSTR (AHV.HR_IRRADIADO,1,2) < 12 THEN 'MANHA' 
                  WHEN SUBSTR (AHV.HR_IRRADIADO,1,2) < 18 THEN 'TARDE'
                  ELSE 'NOITE' END AS TURNO,
AHV.TP_ACIDENTE,
AHV.TP_STATUS,
AHV.DS_INCIDENTE,
'R$ 50,00' AS NR_CUSTO


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
                    'CBS_NB_1' AS CD_BOLSA_SANGUE,
                    'PAR_REGISTRY_ID' AS CD_DOC,
                    'INSTANCE_USER' AS CD_DRT_ABERTURA,
                    'CBS_HEM_1' AS DS_HEMOCOMPONENTE,
                    'CBS_MA_1' AS DS_INCIDENTE,
                    'CBS_HI_1' AS HR_IRRADIADO,
                    'CBS_HR_1' AS HR_RECEBIMENTO,
                    'CBS_BS_1' AS NM_BANCO_SANGUE,
                    'CBS_NS_1' AS NR_SEGMENTO,
                    'CBS_IDR_1' AS NR_TEMPERATURA,
                    'CBS_AIR_1' AS TP_ACIDENTE,
                    'CBS_FRH_1' AS TP_FATOR_RH,
                    'CBS_TS_1' AS TP_SANGUE,
                    'CBS_DR_1' AS DT_IRRADIADO,
                    'CBS_CIR_1' AS TP_STATUS                    
                        )
                     )
    ) AHV, ENGINE.ACT_HI_PROCINST AHP, DBAMV.VDES_USUARIOS VDU, ENGINE.ACT_HI_TASKINST AHT
        WHERE AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
        AND VDU.CD_USUARIO = AHV.CD_DRT_ABERTURA
        AND AHT.PROC_INST_ID_ = AHV.PROC_INST_ID_
        AND AHP.PROC_DEF_KEY_ IN('jUtkR2P4iSwGoDmj_U6K71')

order by AHP.START_TIME_ desc , AHP.END_TIME_ desc