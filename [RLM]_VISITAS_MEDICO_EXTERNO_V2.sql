SELECT
    SUBSTR(AHP.BUSINESS_KEY_,26) AS CD_REGISTRO,
    AHP.STATE_,
    --DENSE_RANK() OVER (PARTITION BY TO_DATE(AHV.F_DT_VISITA_FICHA),SUBSTR(AHP.BUSINESS_KEY_,26) ORDER BY SUBSTR(AHP.BUSINESS_KEY_,26)DESC)RANK,
    --AHT.NAME_ AS DESCRICAO_ETAPA,
    TO_CHAR (AHP.START_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_INICIO,
    TO_CHAR (AHP.END_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_FINAL,
    --AGENDAMENTO DA VISITA MEDICA
    AHV.AG_CRM_VISITA,
    AHV.AG_NM_MED_VISITA,
    AHV.AG_DT_VISITA,
    AHV.AG_DS_DIAVISITA,
    AHV.AG_DS_LOCAL_VISITA,
    --MAPEAMENTO DO CADASTRO MEDICO
    AHV.C_CRM_VISITA,
    AHV.C_DIA_ATEND,
    AHV.C_NM_MED_VISITA,
    --FICHA DE REGISTRO MEDICO
    AHV.CD_DOC,
    AHV.DRT_REGISTRANTE,
    AHV.F_CRM_VISITA_FICHA,
    AHV.F_NM_MED_VISITA,
    AHV.F_DT_VISITA_FICHA,
    --AVALIACAO REFERENTE AO RHP
    AHV.F_TP_ATUOU_RHP,
    AHV.F_TP_AVALIA_RHP,
    AHV.F_TP_LOCAL_AT_ESPERANCA,
    AHV.F_TP_LOCAL_AT_JAYME,
    AHV.F_TP_LOCAL_AT_MEMORIALSJ,
    AHV.F_TP_LOCAL_AT_RHP,
    AHV.F_TP_LOCAL_AT_SAOMARCOS,
    AHV.F_TP_LOCAL_AT_STJOANA,
    AHV.F_TP_LOCAL_AT_OUTROS,
    AHV.F_DS_LOCAL_AT_OUTROS,
    --CLASSIFICACAO MEDICA SOBRE A VISITA
    AHV.F_TP_CLASS_ADM,
    AHV.F_TP_CLASS_AGCIR,
    AHV.F_TP_CLASS_ATCIR,
    AHV.F_TP_CLASS_BLCIR,
    AHV.F_TP_CLASS_CADMED,
    AHV.F_TP_CLASS_COM,
    AHV.F_TP_CLASS_NUT,
    AHV.F_TP_CLASS_ORC,
    AHV.F_TP_CLASS_REP,
    AHV.F_TP_CLASS_RLM,
    AHV.F_TP_CLASS_STI,
    AHV.F_TP_CLASS_TRANS,
    --INFORMACOES VISITA
    AHV.F_DS_OBS_VISITA,
    AHV.F_TP_DEMANDA_AREA,
    --DEMANAS POR AREAS
    AHV.F_TP_DEMANTA_BLCIR,
    AHV.F_DS_DEMANDA_BLCIR,
    AHV.F_TP_DEMANDA_COMERC,
    AHV.F_DS_DEMANDA_COMERC,
    AHV.F_TP_DEMANDA_INTMER,
    AHV.F_DS_DEMANDA_INTMER,
    AHV.F_TP_DEMANDA_MATERN,
    AHV.F_DS_DEMANDA_MATERN,
    AHV.F_TP_DEMANDA_REG,
    AHV.F_DS_DEMANDA_REG,
    AHV.F_TP_DEMANDA_REP,
    AHV.F_DS_DEMANDA_REPHON,
    AHV.F_TP_DEMANDA_RLM,
    AHV.F_DS_DEMANDA_RLM,
    AHV.F_TP_DEMANDA_STI,
    AHV.F_DS_DEMANDA_STI,
    --INFORMACOES REFERENTE A REVISITA
    AHV.F_TP_REVISITA,
    AHV.F_DS_JUS_REVISITA,    
    AHV.F_DT_REVISITA,   
    AHV.R_DS_LOCAL_REVISITA,
    AHV.R_DS_RESUMO_ULTIMA_VISITA
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
                    'DVS' AS AG_CRM_VISITA,
                    'DIA_VIST' AS AG_DS_DIAVISITA,
                    'BAIRRO_VISI' AS AG_DS_LOCAL_VISITA,
                    'DT_VISITA' AS AG_DT_VISITA,
                    'NM_MED_VISITA' AS AG_NM_MED_VISITA,
                    'CRM_VISITA' AS C_CRM_VISITA,
                    'NM_MED_VISITA' AS C_NM_MED_VISITA,
                    'DIAS_ATEND' AS C_DIA_ATEND,
                    'PAR_REGISTRY_ID' AS CD_DOC,
                    'INSTANCE_USER' AS DRT_REGISTRANTE,
                    'REL1' AS F_CRM_VISITA_FICHA,
                    'RLM_DS_BLOCO_CIR874' AS F_DS_DEMANDA_BLCIR,
                    'REL31' AS F_DS_DEMANDA_COMERC,
                    'REL34' AS F_DS_DEMANDA_INTMER,
                    'REL29' AS F_DS_DEMANDA_MATERN,
                    'REL33' AS F_DS_DEMANDA_REG,
                    'REL32' AS F_DS_DEMANDA_REPHON,
                    'REL27' AS F_DS_DEMANDA_RLM,
                    'DS_TEC675' AS F_DS_DEMANDA_STI,
                    'RET_VISITA' AS F_DS_JUS_REVISITA,
                    'OUT_TXT' AS F_DS_LOCAL_AT_OUTROS,
                    'CONSID_VISITA' AS F_DS_OBS_VISITA,
                    'DT_REVIS' AS F_DT_REVISITA,
                    'REL3' AS F_DT_VISITA_FICHA,
                    'REL2' AS F_NM_MED_VISITA,
                    'ATUA_SN' AS F_TP_ATUOU_RHP,
                    'AVALIA_RHP' AS F_TP_AVALIA_RHP,
                    'RLM_CLASS_AGV_ADM' AS F_TP_CLASS_ADM,
                    'RLM_CLAS_AGV_AGCIR' AS F_TP_CLASS_AGCIR,
                    'RLM_CLASS_AGV_ATCIR' AS F_TP_CLASS_ATCIR,
                    'RLM_CLASS_AGV_BLCIR' AS F_TP_CLASS_BLCIR,
                    'RLM_CLASS_AGV_CADMED' AS F_TP_CLASS_CADMED,
                    'RLM_CLASS_AGV_COM' AS F_TP_CLASS_COM,
                    'RLM_CLASS_AGV_NUT' AS F_TP_CLASS_NUT,
                    'RLM_CLASS_AGV_ORC' AS F_TP_CLASS_ORC,
                    'RLM_CLASS_AGV_REPHON' AS F_TP_CLASS_REP,
                    'RLM_CLASS_AGV_RLM' AS F_TP_CLASS_RLM,
                    'RLM_SETOR_TECNOLOGIA' AS F_TP_CLASS_STI,
                    'RLM_CLASS_AGV_TRANS' AS F_TP_CLASS_TRANS,
                    'GER' AS F_TP_DEMANDA_AREA,
                    'COMERCIAL_REL' AS F_TP_DEMANDA_COMERC,
                    'INTELIG_REL' AS F_TP_DEMANDA_INTMER,
                    'CADASTRO_PREST' AS F_TP_DEMANDA_MATERN,
                    'REGULA_REL' AS F_TP_DEMANDA_REG,
                    'REPASSE_REL' AS F_TP_DEMANDA_REP,
                    'RELAC_MEDICO' AS F_TP_DEMANDA_RLM,
                    'ST_TEC' AS F_TP_DEMANDA_STI,
                    'ST_BLOCO' AS F_TP_DEMANTA_BLCIR,
                    'H_ESPERANCA' AS F_TP_LOCAL_AT_ESPERANCA,
                    'H_JAYME' AS F_TP_LOCAL_AT_JAYME,
                    'H_JOSE' AS F_TP_LOCAL_AT_MEMORIALSJ,
                    'H_OUTROS' AS F_TP_LOCAL_AT_OUTROS,
                    'H_PORT' AS F_TP_LOCAL_AT_RHP,
                    'H_MARCOS' AS F_TP_LOCAL_AT_SAOMARCOS,
                    'H_JOANA' AS F_TP_LOCAL_AT_STJOANA,
                    'RE_VISITA' AS F_TP_REVISITA,
                    'BAIRROO' AS R_DS_LOCAL_REVISITA,
                    'D_VISITA' AS R_DS_RESUMO_ULTIMA_VISITA

                )
            )
    ) AHV,
    ENGINE.ACT_HI_PROCINST AHP--, ENGINE.ACT_HI_TASKINST AHT
WHERE
    AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
    --AND AHP.PROC_INST_ID_ = AHT.PROC_INST_ID_
    AND AHP.START_TIME_ BETWEEN TO_DATE ('01/01/2020', 'DD/MM/YYYY')
    AND SYSDATE + 1
    --AND AHP.BUSINESS_KEY_ LIKE '[RLM] - VISITAS EXTERNAS-%'
    AND AHP.PROC_DEF_KEY_ = 'xcHGm2i8bFWhx7XNvp4Jpv'
    AND STATE_ NOT IN ('EXTERNALLY_TERMINATED')
    AND AHV.F_CRM_VISITA_FICHA = 10721
ORDER BY
    AHP.START_TIME_ DESC;
    
    select * from EDITOR_CUSTOM.HIST_VISITA_MED
    ORDER BY 1