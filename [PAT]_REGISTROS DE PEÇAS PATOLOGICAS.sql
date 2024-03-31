SELECT 
    SUBSTR(AHP.BUSINESS_KEY_, 36) AS CD_REGISTRO,
    STATE_,
    --AHP.PROC_DEF_KEY_,
    --AHP.BUSINESS_KEY_ AS DESCRICAO_ETAPA,
    TO_CHAR (AHP.START_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_INICIO,
    TO_CHAR (AHP.END_TIME_, 'DD/MM/YYYY HH24:MI:ss') AS DT_FINAL,
    TRUNC(AHP.DURATION_ / (1000 * 60 * 60)) || ':' || LPAD(TRUNC(AHP.DURATION_ / (1000 * 60)), 2, '0') || ':' || LPAD(MOD(AHP.DURATION_, (1000 * 60)), 2, '0') AS SLA,
    AHV.CD_DOC,
    AHV.CD_ATENDIMENTO,
    --PDR.CD_PED_RX,
    --PDR.CD_SET_EXA,
    AHV.CD_REG_PAC,
    AHV.NM_PACIENTE,
    AHV.DT_NASC,
    AHV.CD_AVISO_CIR,
    AHV.DT_CIR,
    AHV.DS_PROCED_PRIN,
    AHV.NM_CIRURGIAO,
    --AHV.CD_REGISTRO,
    NVL (AHV.DS_LABEXT,AHV.DS_LABOUT) DS_LABEXT,
    AHV.TP_CONGELACAO,
    AHV.NM_PECA1,
    CASE WHEN AHV.TP_PECA1 = 'true' THEN 'SIM' ELSE 'NÃO' END TP_OUTRA_PECA1,
    AHV.NM_PECA2,
    CASE WHEN AHV.TP_PECA2 = 'true' THEN 'SIM' ELSE 'NÃO' END TP_OUTRA_PECA2,
    AHV.NM_PECA3,
    CASE WHEN AHV.TP_PECA3 = 'true' THEN 'SIM' ELSE 'NÃO' END TP_OUTRA_PECA3,
    AHV.NM_PECA4,
    CASE WHEN AHV.TP_PECA4 = 'true' THEN 'SIM' ELSE 'NÃO' END TP_OUTRA_PECA4,
    AHV.NM_PECA5,
    CASE WHEN AHV.TP_PECA5 = 'true' THEN 'SIM' ELSE 'NÃO' END TP_OUTRA_PECA5,
    AHV.NM_PECA6,
    AHV.NM_RECEBEDOR,
    NVL (AHV.NR_CPF,AHV.NR_RG) CD_DOCUMENTO_IDENTIF,
    AHV.CD_DRT_REGISTRANTE,
    AHV.NM_REGISTRANTE,
    CASE WHEN AHV.TP_PECA6 = 'true' THEN 'REALIZADO' ELSE 'CADASTRADO' END TP_CADASTRO,
    AHV.TP_LOCAL
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
                    'PPE_ATENDIMENTO_1' AS CD_ATENDIMENTO,
                    'PPE_AVISO_CIR_1' AS CD_AVISO_CIR,
                    'PAR_REGISTRY_ID' AS CD_DOC,
                    'INSTANCE_USER' AS CD_DRT_REGISTRANTE,
                    'PPE_REG_PAC_1' AS CD_REG_PAC,
                    'BUSINESS_KEY_CASE_INSENSITIVE' AS CD_REGISTRO,
                    'PPE_LAB_EXTERNO_1' AS DS_LABEXT,
                    'PPE_LABEXT_OUTROS_1' AS DS_LABOUT,
                    'PPE_PROCEDIMENTO_CIR_1' AS DS_PROCED_PRIN,
                    'PPE_DT_CIR_1' AS DT_CIR,
                    'PPE_DT_NASC_1' AS DT_NASC,
                    'PPE_CIRURGIAO_1' AS NM_CIRURGIAO,
                    'PPE_NOME_PAC_1' AS NM_PACIENTE,
                    'PEP_NOME_PECA_1' AS NM_PECA1,
                    'PEP_NOME_PECA_2' AS NM_PECA2,
                    'PEP_NOME_PECA_3' AS NM_PECA3,
                    'PEP_NOME_PECA_4' AS NM_PECA4,
                    'PEP_NOME_PECA_5' AS NM_PECA5,
                    'PEP_NOME_PECA_6' AS NM_PECA6,
                    'PPE_NOME_ENTREGADOR_1' AS NM_RECEBEDOR,
                    'PPE_COLABORADOR_1' AS NM_REGISTRANTE,
                    'PPE_ID_ENTREGADOR_1' AS NR_CPF,
                    'PPE_ID_ENTREGADOR_2' AS NR_RG,
                    'PPE_TIPO_CONGELACAO_1' AS TP_CONGELACAO,
                    'PPE_NOVA_PECA_1' AS TP_PECA1,
                    'PPE_NOVA_PECA_2' AS TP_PECA2,
                    'PPE_NOVA_PECA_3' AS TP_PECA3,
                    'PPE_NOVA_PECA_4' AS TP_PECA4,
                    'PPE_NOVA_PECA_5' AS TP_PECA5,
                    'PPE_NOVA_PECA_6' AS TP_PECA6,
                    'PPE_LOCAL_PROC_' AS TP_LOCAL
                )
            )
    ) AHV,
    ENGINE.ACT_HI_PROCINST AHP--, DBAMV.PED_RX PDR
WHERE
    AHP.PROC_INST_ID_ = AHV.PROC_INST_ID_
    --AND AHV.CD_ATENDIMENTO = PDR.CD_ATENDIMENTO(+)
    AND AHP.START_TIME_ BETWEEN TO_DATE ('01/01/2024', 'DD/MM/YYYY')
    AND SYSDATE + 1
    AND AHP.PROC_DEF_KEY_ IN ('ejB1NhZ0e8Gumu8Due9IBm')
    
ORDER BY AHP.START_TIME_ DESC