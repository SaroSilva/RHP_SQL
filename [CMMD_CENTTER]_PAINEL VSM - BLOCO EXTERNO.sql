/*BLOCO EXTERNO*/
SELECT  P_Unidade
    ,P_Linha
    ,Leito
    ,Paciente
    ,DN
    ,Registro
    ,Medico
    ,Convenio
    ,Internacao
    ,Dias
    ,Prev_Alta
    ,Dias_Alta
    ,Dias_Alta_Status
    ,Dia_no_Leito
    ,deterioracao
    ,hemodialise_status
    ,avc
    ,sca
    ,EXA
    ,IMG
    ,BLC
    ,HMD
    ,END
    ,EVE
    ,PRM
    ,PRA
    ,APZ
    ,APRAZADO_NEW
    ,CKG
    ,NULL CHECAGEM -- *
    ,PAM
    ,AUD
    ,PXH
    ,PROXIMA_HORA
    ,BLH
    ,NULL AS TEV
    ,QUE
    ,RISCO_QUEDA
    ,BCP
    ,BRONCOASPIRACAO_NEW
    ,DOR
    ,null as DOR_NEW -- *
    ,TRIM(SCE) AS SCE
    ,SCORE_ENFERMAGEM_NEW
    ,NULL AS CVC --*
    ,CVC_NEW
    ,NULL AS SDV
    ,SCM
    ,Nvl(PRECAUCAO_AEROSSOIS_NEW,PAR) AS PAR
    ,PRECAUCAO_AEROSSOIS_NEW
    ,Nvl(PRECAUCAO_CONTATO_NEW,PCT) AS PCT
    ,PRECAUCAO_CONTATO_NEW
    ,Nvl(PRECAUCAO_GOTICULA_NEW,PGT) AS PGT
    ,PRECAUCAO_GOTICULA_NEW
    ,ALE
    ,MON
    ,PED
    ,DEV
    ,SIT
    ,HINT
    ,TQT_NEW
    ,DIETA_ZERO
FROM
(
    SELECT  P_Unidade
        ,P_Linha
        ,Leito
        ,Paciente
        ,DN
        ,Registro
        ,Medico
        ,Convenio
        ,Internacao
        ,Dias
        ,Prev_Alta
        ,Dias_Alta
        ,CASE WHEN Dias_Alta BETWEEN 1 AND 3 THEN 'YELLOW'
              WHEN Dias_Alta <= 0 THEN 'RED' ELSE NULL END AS Dias_Alta_Status
        ,Dia_no_Leito
        ,CASE WHEN entrada_deterioracao IS NULL THEN NULL
              WHEN entrada_deterioracao IS NOT NULL AND saida_deterioracao IS NULL THEN 'RED'
              WHEN saida_deterioracao > entrada_deterioracao THEN NULL END deterioracao
        ,CASE WHEN hemodialise IS NOT NULL THEN 'TRUE' ELSE 'FALSE' END hemodialise_status
        ,CASE WHEN entrada_avc IS NULL THEN NULL
              WHEN entrada_avc IS NOT NULL AND saida_avc IS NULL THEN 'RED'
              WHEN saida_avc > entrada_avc THEN NULL END avc
        ,CASE WHEN sca IS NOT NULL THEN 'TRUE' ELSE 'FALSE' END sca
        ,EXA
        ,IMG
        ,BLC
        ,HMD
        ,END
        ,EVE
        ,PRM
        ,PRA
        ,APZ
        ,CKG
        ,PAM
        ,AUD
        ,PXH
        ,BLH
        ,TEV
        ,QUE
        ,BCP
        ,DOR
        ,SCE
        ,CVC
        ,SDV
        ,SCM
        ,PAR
        ,PCT
        ,PGT
        ,ALE
        ,MON
        ,PED
        ,DEV
        ,SIT
        ,HINT
        ,(
    SELECT  DECODE(DESCRICAO,'TRUE','RED','FALSE','GREEN') AS BRONCOASPIRACAO
    FROM
    (
        SELECT  EC.DS_IDENTIFICADOR
            ,REPLACE(SUBSTR(UPPER(DBMS_LOB.SUBSTR(ERC.LO_VALOR,4000,1)),INSTR(UPPER(DBMS_LOB.SUBSTR(ERC.LO_VALOR,4000,1)),'||')),'|','') AS DESCRICAO
        FROM DBAMV.PW_DOCUMENTO_CLINICO PWD, DBAMV.PW_EDITOR_CLINICO PEC, DBAMV.EDITOR_REGISTRO_CAMPO ERC, DBAMV.EDITOR_CAMPO EC
        WHERE PEC.CD_DOCUMENTO_CLINICO(+) = PWD.CD_DOCUMENTO_CLINICO
        AND ERC.CD_REGISTRO (+) = PEC.CD_EDITOR_REGISTRO
        AND EC.CD_CAMPO(+) = ERC.CD_CAMPO
        AND PEC.CD_DOCUMENTO = 909
        AND PWD.TP_STATUS = 'FECHADO'
        AND PWD.CD_ATENDIMENTO (+) = REGISTRO
        AND EC.DS_IDENTIFICADOR = 'SN_FATOR_RISCO_BRONCO_SIM_1'
        ORDER BY PWD.DH_FECHAMENTO DESC FETCH FIRST 1 ROW ONLY
    )) AS BRONCOASPIRACAO_NEW , (
    SELECT  PARAMETROS
    FROM
    (
        SELECT  CD_COLETA_SINAL_VITAL
            ,DATA_COLETA
            ,INTERVALO_90
            ,INTERVALO_60
            ,CD_SINAL_VITAL
            ,DATA_ATUAL
            ,DOR
            ,INTERVALO2
            ,ATUAL2
            ,CONDICAO
            ,CRONOMETRO
            ,CASE   WHEN CD_SINAL_VITAL = 65 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL > INTERVALO_90 THEN TO_CHAR(CRONOMETRO)
                    WHEN CD_SINAL_VITAL = 65 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL > INTERVALO_60 THEN 'RED'
                    WHEN CD_SINAL_VITAL = 65 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL < INTERVALO_60 THEN 'YELLOW'
                    WHEN CD_SINAL_VITAL = 66 AND DOR BETWEEN 7 AND 12 AND DATA_ATUAL > INTERVALO_90 THEN TO_CHAR(CRONOMETRO)
                    WHEN CD_SINAL_VITAL = 66 AND DOR BETWEEN 7 AND 12 AND DATA_ATUAL > INTERVALO_90 THEN 'RED'
                    WHEN CD_SINAL_VITAL = 66 AND DOR BETWEEN 7 AND 12 AND DATA_ATUAL < INTERVALO_60 THEN 'YELLOW'
                    WHEN CD_SINAL_VITAL = 64 AND DOR BETWEEN 3 AND 7 AND DATA_ATUAL > INTERVALO_90 THEN TO_CHAR(CRONOMETRO)
                    WHEN CD_SINAL_VITAL = 64 AND DOR BETWEEN 3 AND 7 AND DATA_ATUAL > INTERVALO_90 THEN 'RED'
                    WHEN CD_SINAL_VITAL = 64 AND DOR BETWEEN 3 AND 7 AND DATA_ATUAL < INTERVALO_60 THEN 'YELLOW'
                    WHEN CD_SINAL_VITAL = 67 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL > INTERVALO_90 THEN TO_CHAR(CRONOMETRO)
                    WHEN CD_SINAL_VITAL = 67 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL > INTERVALO_60 THEN 'RED'
                    WHEN CD_SINAL_VITAL = 67 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL < INTERVALO_60 THEN 'YELLOW'
                    WHEN CD_SINAL_VITAL = 70 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL > INTERVALO_90 THEN TO_CHAR(CRONOMETRO)
                    WHEN CD_SINAL_VITAL = 70 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL > INTERVALO_60 THEN 'RED'
                    WHEN CD_SINAL_VITAL = 70 AND DOR BETWEEN 4 AND 10 AND DATA_ATUAL < INTERVALO_60 THEN 'YELLOW'
                    WHEN CD_SINAL_VITAL = 71 AND DOR BETWEEN 21 AND 40 AND DATA_ATUAL > INTERVALO_90 THEN TO_CHAR(CRONOMETRO)
                    WHEN CD_SINAL_VITAL = 71 AND DOR BETWEEN 21 AND 40 AND DATA_ATUAL > INTERVALO_60 THEN 'RED'
                    WHEN CD_SINAL_VITAL = 71 AND DOR BETWEEN 21 AND 40 AND DATA_ATUAL < INTERVALO_60 THEN 'YELLOW' END AS PARAMETROS
        FROM
        (
            SELECT  CD_COLETA_SINAL_VITAL
                ,DATA_COLETA
                ,INTERVALO_90
                ,INTERVALO_60
                ,CD_SINAL_VITAL
                ,DATA_ATUAL
                ,DOR
                ,TO_DATE(TO_CHAR(INTERVALO_90,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') AS INTERVALO2
                ,TO_DATE(TO_CHAR(DATA_ATUAL,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')   AS ATUAL2
                ,CASE WHEN DATA_ATUAL BETWEEN DATA_COLETA AND INTERVALO_90 THEN 'DENTRO DO PERÍODO'
                        WHEN DATA_ATUAL > INTERVALO_90 AND DOR > 1 THEN (
            SELECT  (TOTAL_HORA - DIAS) || ':' || TOTAL_MM_SS AS INTERVALO_90
            FROM
            (
                SELECT  EXTRACT(HOUR
                FROM NUMTODSINTERVAL
                (MAX(TEMPO_AVF), 'MINUTE'
                )) + (EXTRACT(DAY
                FROM NUMTODSINTERVAL
                (MAX(TEMPO_AVF), 'MINUTE'
                )) * 24) AS TOTAL_HORA, TO_CHAR(TRUNC(SYSDATE) + NUMTODSINTERVAL(MAX(TEMPO_AVF), 'MINUTE'), 'MI:SS') AS TOTAL_MM_SS
                FROM
                (
                    SELECT  ((FINAL_DATA - INICIO_DATA) * 1440) + ((
                    SELECT  ROUND((SUBSTR(FINAL_DATA,0,2) * 60) + (SUBSTR(FINAL_DATA,4,2) * 60 / 60) + (SUBSTR(FINAL_DATA,7,2) / 60),2) AS MINUTOS_TOTAIS
                    FROM DUAL) - (
                    SELECT  ROUND((SUBSTR(INICIO_DATA,0,2) * 60) + (SUBSTR(INICIO_DATA,4,2) * 60 / 60) + (SUBSTR(INICIO_DATA,7,2) / 60),2) AS MINUTOS_TOTAIS
                    FROM DUAL)) AS TEMPO_AVF, CAST((
                    SELECT  TO_DATE(FINAL_DATA) - TO_DATE(INICIO_DATA)
                    FROM DUAL) AS INT) AS DIAS
                    FROM
                    (
                        SELECT  TO_DATE(TO_CHAR(DATA_ATUAL,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')   AS FINAL_DATA
                            ,TO_DATE(TO_CHAR(INTERVALO_90,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') AS INICIO_DATA
                        FROM DUAL
                    )
                )
            ) TB1, (
            SELECT  CAST((
            SELECT  TO_DATE(FINAL_DATA) - TO_DATE(INICIO_DATA)
            FROM DUAL) AS INT) AS DIAS
            FROM
            (
                SELECT  TO_DATE(TO_CHAR(DATA_ATUAL,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')   AS FINAL_DATA
                    ,TO_DATE(TO_CHAR(INTERVALO_90,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') AS INICIO_DATA
                FROM DUAL
            )) TB2 ) END AS CONDICAO , (
            SELECT  (TOTAL_HORA - DIAS) || ':' || TOTAL_MM_SS AS INTERVALO_90
            FROM
            (
                SELECT  EXTRACT(HOUR
                FROM NUMTODSINTERVAL
                (MAX(TEMPO_AVF), 'MINUTE'
                )) + (EXTRACT(DAY
                FROM NUMTODSINTERVAL
                (MAX(TEMPO_AVF), 'MINUTE'
                )) * 24) AS TOTAL_HORA, TO_CHAR(TRUNC(SYSDATE) + NUMTODSINTERVAL(MAX(TEMPO_AVF), 'MINUTE'), 'MI:SS') AS TOTAL_MM_SS
                FROM
                (
                    SELECT  ((FINAL_DATA - INICIO_DATA) * 1440) + ((
                    SELECT  ROUND((SUBSTR(FINAL_DATA,0,2) * 60) + (SUBSTR(FINAL_DATA,4,2) * 60 / 60) + (SUBSTR(FINAL_DATA,7,2) / 60),2) AS MINUTOS_TOTAIS
                    FROM DUAL) - (
                    SELECT  ROUND((SUBSTR(INICIO_DATA,0,2) * 60) + (SUBSTR(INICIO_DATA,4,2) * 60 / 60) + (SUBSTR(INICIO_DATA,7,2) / 60),2) AS MINUTOS_TOTAIS
                    FROM DUAL)) AS TEMPO_AVF, CAST((
                    SELECT  TO_DATE(FINAL_DATA) - TO_DATE(INICIO_DATA)
                    FROM DUAL) AS INT) AS DIAS
                    FROM
                    (
                        SELECT  TO_DATE(TO_CHAR(DATA_ATUAL,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')   AS FINAL_DATA
                            ,TO_DATE(TO_CHAR(INTERVALO_90,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') AS INICIO_DATA
                        FROM DUAL
                    )
                )
            ) TB1, (
            SELECT  CAST((
            SELECT  TO_DATE(FINAL_DATA) - TO_DATE(INICIO_DATA)
            FROM DUAL) AS INT) AS DIAS
            FROM
            (
                SELECT  TO_DATE(TO_CHAR(DATA_ATUAL,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')   AS FINAL_DATA
                    ,TO_DATE(TO_CHAR(INTERVALO_90,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') AS INICIO_DATA
                FROM DUAL
            )) TB2 ) AS CRONOMETRO
            FROM
            (
                SELECT  DISTINCT CSV.CD_COLETA_SINAL_VITAL
                    ,CSV.DATA_COLETA
                    ,(TO_DATE(TO_CHAR(CSV.DATA_COLETA,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') + INTERVAL '90' MINUTE)  AS INTERVALO_90
                    ,(TO_DATE(TO_CHAR(CSV.DATA_COLETA,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') + INTERVAL '60' MINUTE)  AS INTERVALO_60
                    ,SV.CD_SINAL_VITAL
                    ,TO_DATE(TO_CHAR(SYSDATE,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')                                   AS DATA_ATUAL
                    ,TRUNC(SUM(PI.VL_RESPOSTA) OVER (PARTITION BY CSV.CD_COLETA_SINAL_VITAL ORDER BY CSV.CD_COLETA_SINAL_VITAL)) AS DOR
                FROM COLETA_SINAL_VITAL CSV, ITCOLETA_SINAL_VITAL ICSV, SINAL_VITAL SV, PAGU_AVALIACAO PA, PAGU_ITAVALIACAO PI
                WHERE CSV.CD_COLETA_SINAL_VITAL = ICSV.CD_COLETA_SINAL_VITAL
                AND SV.CD_SINAL_VITAL (+) = ICSV.CD_SINAL_VITAL
                AND PA.CD_AVALIACAO (+) = ICSV.CD_AVALIACAO
                AND PI.CD_AVALIACAO (+) = PA.CD_AVALIACAO
                AND CSV.CD_ATENDIMENTO (+) = REGISTRO
                AND SV.CD_SINAL_VITAL IN (65, 66, 64, 67, 70, 71)
                ORDER BY CSV.CD_COLETA_SINAL_VITAL DESC
            )FETCH FIRST 1 ROW ONLY
        )
    )) AS DOR_NEW , (
    SELECT  CASE WHEN DESCRICAO IN ('0 - BAIXO RISCO','1 - BAIXO RISCO','2 - BAIXO RISCO','3 - BAIXO RISCO','4 - BAIXO RISCO') THEN 'GREEN'
                WHEN DESCRICAO IN ('3 - MÉDIO RISCO','5 - MÉDIO RISCO','6 - MÉDIO RISCO') THEN 'YELLOW'
                WHEN DESCRICAO IN ('7 - ALTO RISCO','8 - ALTO RISCO','9 - ALTO RISCO','10 - ALTO RISCO','11 - ALTO RISCO','12 - ALTO RISCO','13 - ALTO RISCO') THEN 'RED' END AS SCORE_ENF
    FROM
    (
        SELECT  DISTINCT REPLACE(SUBSTR(UPPER(DBMS_LOB.SUBSTR(ERC.LO_VALOR,4000,1)),INSTR(UPPER(DBMS_LOB.SUBSTR(ERC.LO_VALOR,4000,1)),'||')),'|','') AS DESCRICAO
        FROM DBAMV.PW_DOCUMENTO_CLINICO PWD, DBAMV.PW_EDITOR_CLINICO PEC, DBAMV.EDITOR_REGISTRO_CAMPO ERC, DBAMV.EDITOR_CAMPO EC
        WHERE PEC.CD_DOCUMENTO_CLINICO(+) = PWD.CD_DOCUMENTO_CLINICO
        AND ERC.CD_REGISTRO (+) = PEC.CD_EDITOR_REGISTRO
        AND EC.CD_CAMPO(+) = ERC.CD_CAMPO
        AND PEC.CD_DOCUMENTO = 1296
        AND PWD.TP_STATUS = 'FECHADO'
        AND PWD.CD_ATENDIMENTO (+) = REGISTRO
        AND EC.DS_IDENTIFICADOR = 'VALOR_DETERIORIZACAO_8'
        ORDER BY PWD.DH_FECHAMENTO DESC FETCH FIRST 1 ROW ONLY
    )) AS SCORE_ENFERMAGEM_NEW , (
    SELECT  CASE WHEN PA.VL_RESULTADO BETWEEN 0 AND 24 THEN 'GREEN'
                WHEN PA.VL_RESULTADO BETWEEN 25 AND 50 THEN 'YELLOW'
                WHEN PA.VL_RESULTADO >= 51 THEN 'RED' END AS RISCO_QUEDA
    FROM PAGU_AVALIACAO PA
    WHERE PA.CD_ATENDIMENTO (+) = REGISTRO
    AND PA.CD_FORMULA = 31
    ORDER BY PA.CD_AVALIACAO DESC FETCH FIRST 1 ROW ONLY) AS RISCO_QUEDA , (
    SELECT  DS_CATEGORIA
    FROM
    (
        SELECT  LCP.CD_LOG_CATEGORIA_PACIENTE
            ,CASE WHEN LCP.DS_ACAO = 'Retirada' THEN NULL
                    WHEN LCP.DS_ACAO = 'Inclus¿o' THEN CT.DS_CATEGORIA END AS DS_CATEGORIA
        FROM DBAMV.LOG_CATEGORIA_PACIENTE LCP, CATEGORIA CT
        WHERE CT.CD_CATEGORIA (+) = LCP.CD_CATEGORIA
        AND LCP.CD_PACIENTE (+) = CD_PRONTUARIO
        ORDER BY LCP.CD_LOG_CATEGORIA_PACIENTE DESC
    ) FETCH FIRST 1 ROW ONLY ) AS PRECAUCAO_NEW , (
    SELECT  CASE WHEN DS_CATEGORIA IS NULL THEN NULL
                WHEN DS_CATEGORIA IS NOT NULL THEN AEROSSOL END AS AEROSSOL
    FROM
    (
        SELECT  LCP.CD_LOG_CATEGORIA_PACIENTE
            ,CASE WHEN CT.CD_CATEGORIA IN (2,4,5,7,8,71,72) THEN 'GREEN' END AS AEROSSOL
            ,CASE WHEN LCP.DS_ACAO = 'Retirada' THEN NULL
                    WHEN LCP.DS_ACAO = 'Inclus¿o' THEN CT.DS_CATEGORIA END     AS DS_CATEGORIA
            ,CT.CD_CATEGORIA
        FROM DBAMV.LOG_CATEGORIA_PACIENTE LCP, CATEGORIA CT
        WHERE CT.CD_CATEGORIA (+) = LCP.CD_CATEGORIA
        AND LCP.CD_PACIENTE (+) = CD_PRONTUARIO
        ORDER BY LCP.CD_LOG_CATEGORIA_PACIENTE DESC
    ) FETCH FIRST 1 ROW ONLY ) AS PRECAUCAO_AEROSSOIS_NEW , (
    SELECT  CASE WHEN DS_CATEGORIA IS NULL THEN NULL
                WHEN DS_CATEGORIA IS NOT NULL THEN GOTICULA END AS GOTICULA
    FROM
    (
        SELECT  LCP.CD_LOG_CATEGORIA_PACIENTE
            ,CASE WHEN CT.CD_CATEGORIA IN (1,3,10,17,23) THEN 'GREEN' END AS GOTICULA
            ,CASE WHEN LCP.DS_ACAO = 'Retirada' THEN NULL
                    WHEN LCP.DS_ACAO = 'Inclus¿o' THEN CT.DS_CATEGORIA END  AS DS_CATEGORIA
            ,CT.CD_CATEGORIA
        FROM DBAMV.LOG_CATEGORIA_PACIENTE LCP, CATEGORIA CT
        WHERE CT.CD_CATEGORIA (+) = LCP.CD_CATEGORIA
        AND LCP.CD_PACIENTE (+) = CD_PRONTUARIO
        ORDER BY LCP.CD_LOG_CATEGORIA_PACIENTE DESC
    ) FETCH FIRST 1 ROW ONLY ) AS PRECAUCAO_GOTICULA_NEW , (
    SELECT  CASE WHEN DS_CATEGORIA IS NULL THEN NULL
                WHEN DS_CATEGORIA IS NOT NULL THEN CONTATO END AS CONTATO
    FROM
    (
        SELECT  LCP.CD_LOG_CATEGORIA_PACIENTE
            ,CASE WHEN CT.CD_CATEGORIA IN (1,2,3,4,6,8,10,83,71,72) THEN 'GREEN' END AS CONTATO
            ,CASE WHEN LCP.DS_ACAO = 'Retirada' THEN NULL
                    WHEN LCP.DS_ACAO = 'Inclus¿o' THEN CT.DS_CATEGORIA END             AS DS_CATEGORIA
            ,CT.CD_CATEGORIA
        FROM DBAMV.LOG_CATEGORIA_PACIENTE LCP, CATEGORIA CT
        WHERE CT.CD_CATEGORIA (+) = LCP.CD_CATEGORIA
        AND LCP.CD_PACIENTE (+) = CD_PRONTUARIO
        ORDER BY LCP.CD_LOG_CATEGORIA_PACIENTE DESC
    ) FETCH FIRST 1 ROW ONLY ) AS PRECAUCAO_CONTATO_NEW , (
    SELECT  PROXIMA_HORA
    FROM
    (
        SELECT  HIPM.DH_MEDICACAO
            ,TO_CHAR(HIPM.DH_MEDICACAO,'HH24:MI') AS PROXIMA_HORA
        FROM PRE_MED PM, ITPRE_MED IPM, HRITPRE_MED HIPM, TIP_ESQ TE
        WHERE IPM.CD_PRE_MED = PM.CD_PRE_MED
        AND HIPM.CD_ITPRE_MED (+) = IPM.CD_ITPRE_MED
        AND TE.CD_TIP_ESQ (+) = IPM.CD_TIP_ESQ
        AND PM.CD_ATENDIMENTO (+) = REGISTRO
        AND PM.TP_PRE_MED = 'M'
        AND TE.TP_CHECAGEM = 'CC'
        AND NVL(IPM.SN_CANCELADO, 'N') = 'N'
        AND NVL(IPM.TP_SITUACAO, 'N') = 'N'
        AND NVL(TE.SN_TIPO, 'N') = 'S'
        AND TO_DATE(TO_CHAR(HIPM.DH_MEDICACAO, 'DD/MM/RRRR HH24:MI'), 'DD/MM/RRRR HH24:MI') >= TO_DATE(TO_CHAR(SYSDATE, 'DD/MM/RRRR HH24:MI'), 'DD/MM/RRRR HH24:MI')
        ORDER BY HIPM.DH_MEDICACAO ASC
    ) FETCH FIRST 1 ROW ONLY) AS PROXIMA_HORA , (
    SELECT  CASE WHEN INICIO_ACESSO > RETIRADA_ACESSO THEN (TO_DATE(SYSDATE) - TO_DATE(INICIO_ACESSO))
                WHEN INICIO_ACESSO < RETIRADA_ACESSO THEN (TO_DATE(RETIRADA_ACESSO) - TO_DATE(INICIO_ACESSO)) END AS DIAS
    FROM
    (
        SELECT  INICIO_ACESSO
            ,NVL(RETIRADA_ACESSO,SYSDATE) AS RETIRADA_ACESSO
        FROM
        (
            SELECT  DH_CRIACAO
                ,CD_DOCUMENTO
            FROM
            (
                SELECT  PWD.DH_CRIACAO
                    ,DENSE_RANK() OVER (PARTITION BY PEC.CD_DOCUMENTO ORDER BY PWD.DH_CRIACAO DESC) AS LAST
                    ,PEC.CD_DOCUMENTO
                FROM PW_DOCUMENTO_CLINICO PWD , PW_EDITOR_CLINICO PEC
                WHERE PEC.CD_DOCUMENTO_CLINICO = PWD.CD_DOCUMENTO_CLINICO
                AND PEC.CD_DOCUMENTO IN (769, 445)
                AND PWD.TP_STATUS IN ('FECHADO', 'ASSINADO')
                AND PWD.CD_ATENDIMENTO (+) = REGISTRO
            )WHERE LAST = 1
        ) PIVOT(MAX(DH_CRIACAO) FOR CD_DOCUMENTO IN(769 AS INICIO_ACESSO, 445 AS RETIRADA_ACESSO))
    )) AS CVC_NEW , (
    SELECT  REGRA
    FROM
    (
        SELECT  PWD.CD_ATENDIMENTO
            ,PWD.CD_DOCUMENTO_CLINICO
            ,PWD.DH_CRIACAO
            ,CASE WHEN SPHE.CD_GRUPO = 45 AND SRHE.TP_RESPOSTA = 'CHECK' AND SRHE.DS_RESPOSTA = 'TQT' THEN 'GREEN'  ELSE NULL END AS REGRA
            ,DENSE_RANK() OVER (PARTITION BY PWD.CD_ATENDIMENTO ORDER BY PWD.CD_DOCUMENTO_CLINICO DESC)                           AS ORDEM
            ,SPHE.CD_GRUPO
            ,SRHE.TP_RESPOSTA
            ,SRHE.DS_RESPOSTA
        FROM DBAMV.PW_DOCUMENTO_CLINICO PWD , DBAMV.SAE_HISTORICO_ENFERMAGEM SHE , DBAMV.SAE_RESP_SELCND_HIST_ENFERMG SRSHE , DBAMV.SAE_PERGUNTA_HISTORICO_ENFERMG SPHE , DBAMV.SAE_RESPOSTA_HISTORICO_ENFERMG SRHE
        WHERE SHE.CD_DOCUMENTO_CLINICO (+) = PWD.CD_DOCUMENTO_CLINICO
        AND SRSHE.CD_HISTORICO_ENFERMAGEM (+) = SHE.CD_HISTORICO_ENFERMAGEM
        AND SPHE.CD_PERGUNTA (+) = SRSHE.CD_PERGUNTA_HISTORICO
        AND SRHE.CD_PERGUNTA (+) = SRSHE.CD_PERGUNTA_HISTORICO
        AND SRHE.CD_RESPOSTA (+) = SRSHE.CD_RESPOSTA_HISTORICO
        AND PWD.TP_STATUS IN ('FECHADO', 'ASSINADO')
        AND PWD.CD_ATENDIMENTO (+) = REGISTRO
        AND PWD.CD_OBJETO = 444
        AND SPHE.CD_GRUPO = 45
        AND SRHE.TP_RESPOSTA = 'CHECK'
        ORDER BY PWD.CD_DOCUMENTO_CLINICO DESC, CASE WHEN SPHE.CD_GRUPO = 45
        AND SRHE.TP_RESPOSTA = 'CHECK'
        AND SRHE.DS_RESPOSTA = 'TQT' THEN 'TQT' ELSE NULL END ASC
    )FETCH FIRST 1 ROW ONLY) AS TQT_NEW , (
    SELECT  CASE WHEN TP_SITUACAO_S IS NULL AND TP_SITUACAO_N IS NULL THEN NULL
                WHEN TP_SITUACAO_S IS NULL AND TP_SITUACAO_N IS NOT NULL THEN 'GREEN'
                WHEN TP_SITUACAO_S IS NOT NULL THEN 'RED' END AS APRAZADO
    FROM
    (
        SELECT  SUM(TP_SITUACAO_S) AS TP_SITUACAO_S
            ,SUM(TP_SITUACAO_N) AS TP_SITUACAO_N
        FROM
        (
            SELECT  IPM.CD_ITPRE_MED
                ,IPM.TP_SITUACAO
                ,DECODE(IPM.TP_SITUACAO,'S','1') AS TP_SITUACAO_S
                ,DECODE(IPM.TP_SITUACAO,'N','1') AS TP_SITUACAO_N
            FROM ATENDIME AT, PRE_MED PM, ITPRE_MED IPM, TIP_ESQ TE, TIP_PRESC TP
            WHERE PM.CD_ATENDIMENTO (+) = AT.CD_ATENDIMENTO
            AND IPM.CD_PRE_MED = PM.CD_PRE_MED
            AND TE.CD_TIP_ESQ (+) = IPM.CD_TIP_ESQ
            AND TP.CD_TIP_PRESC (+) = IPM.CD_TIP_PRESC
            AND PM.TP_PRE_MED = 'M'
            AND TE.TP_CHECAGEM = 'CC'
            AND PM.CD_ATENDIMENTO (+) = REGISTRO
            AND TO_DATE(TO_CHAR(SYSDATE, 'DD/MM/RRRR HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS') BETWEEN TO_DATE(TO_CHAR(PM.DT_PRE_MED, 'DD/MM/RRRR')||' '||TO_CHAR(PM.HR_PRE_MED, 'HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS') AND TO_DATE(TO_CHAR(PM.DT_VALIDADE, 'DD/MM/RRRR HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS')
            ORDER BY PM.CD_PRE_MED DESC
        )
    )) AS APRAZADO_NEW , (
    SELECT  STATUS
    FROM
    (
        SELECT  DH_MEDICACAO
            ,DH_VALIDADE
            ,DH_CHECAGEM
            ,SN_SUSPENSO
            ,AGORA
            ,ANTES
            ,DEPOIS
            ,REGRA
            ,CRONOMETRO
            ,CASE WHEN REGRA = 'RED' THEN REGRA ||' ('||CRONOMETRO||')'  ELSE REGRA END AS STATUS
        FROM
        (
            SELECT  DH_MEDICACAO
                ,DH_VALIDADE
                ,DH_CHECAGEM
                ,SN_SUSPENSO
                ,AGORA
                ,ANTES
                ,DEPOIS
                ,CASE WHEN DH_CHECAGEM IS NULL AND AGORA < ANTES THEN 'GREEN'
                        WHEN DH_CHECAGEM IS NULL AND AGORA BETWEEN ANTES AND DEPOIS THEN 'YELLOW'
                        WHEN DH_CHECAGEM IS NULL AND AGORA > DEPOIS THEN 'RED'
                        WHEN DH_CHECAGEM IS NOT NULL THEN 'GREEN' END AS REGRA
                ,(
            SELECT  (TOTAL_HORA - DIAS) || ':' || TOTAL_MM_SS AS INTERVALO_90
            FROM
            (
                SELECT  EXTRACT(HOUR FROM NUMTODSINTERVAL
                (MAX(TEMPO_AVF), 'MINUTE'
                )) + (EXTRACT(DAY
                FROM NUMTODSINTERVAL
                (MAX(TEMPO_AVF), 'MINUTE'
                )) * 24) AS TOTAL_HORA, TO_CHAR(TRUNC(SYSDATE) + NUMTODSINTERVAL(MAX(TEMPO_AVF), 'MINUTE'), 'MI:SS') AS TOTAL_MM_SS
                FROM
                (
                    SELECT  ((FINAL_DATA - INICIO_DATA) * 1440) + ((
                    SELECT  ROUND((SUBSTR(FINAL_DATA,0,2) * 60) + (SUBSTR(FINAL_DATA,4,2) * 60 / 60) + (SUBSTR(FINAL_DATA,7,2) / 60),2) AS MINUTOS_TOTAIS
                    FROM DUAL) - (
                    SELECT  ROUND((SUBSTR(INICIO_DATA,0,2) * 60) + (SUBSTR(INICIO_DATA,4,2) * 60 / 60) + (SUBSTR(INICIO_DATA,7,2) / 60),2) AS MINUTOS_TOTAIS
                    FROM DUAL)) AS TEMPO_AVF, CAST((
                    SELECT  TO_DATE(FINAL_DATA) - TO_DATE(INICIO_DATA)
                    FROM DUAL) AS INT) AS DIAS
                    FROM
                    (
                        SELECT  TO_DATE(TO_CHAR(AGORA,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')        AS FINAL_DATA
                            ,TO_DATE(TO_CHAR(DH_MEDICACAO,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') AS INICIO_DATA
                        FROM DUAL
                    )
                )
            ) TB1, (
            SELECT  CAST((
            SELECT  (FINAL_DATA) - (INICIO_DATA)
            FROM DUAL) AS INT) AS DIAS
            FROM
            (
                SELECT  TO_DATE(TO_CHAR(AGORA,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')        AS FINAL_DATA
                    ,TO_DATE(TO_CHAR(DH_MEDICACAO,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') AS INICIO_DATA
                FROM DUAL
            )) TB2 ) AS CRONOMETRO
            FROM
            (
                SELECT  TP.DS_TIP_PRESC
                    ,HIPM.DH_MEDICACAO
                    ,TO_DATE(TO_CHAR(PM.DT_VALIDADE,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')                             AS DH_VALIDADE
                    ,HIPC.DH_CHECAGEM
                    ,HIPC.SN_SUSPENSO
                    ,TO_DATE(TO_CHAR(SYSDATE,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS')                                    AS AGORA
                    ,(TO_DATE(TO_CHAR(HIPM.DH_MEDICACAO,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') - INTERVAL '30' MINUTE) AS ANTES
                    ,(TO_DATE(TO_CHAR(HIPM.DH_MEDICACAO,'DD/MM/RRRR HH24:MI:SS'),'DD/MM/RRRR HH24:MI:SS') + INTERVAL '30' MINUTE) AS DEPOIS
                FROM ATENDIME AT, PRE_MED PM, ITPRE_MED IPM, HRITPRE_MED HIPM, HRITPRE_CONS HIPC, TIP_ESQ TE, TIP_PRESC TP
                WHERE PM.CD_ATENDIMENTO (+) = AT.CD_ATENDIMENTO
                AND IPM.CD_PRE_MED = PM.CD_PRE_MED
                AND HIPM.CD_ITPRE_MED (+) = IPM.CD_ITPRE_MED
                AND HIPC.CD_ITPRE_MED (+) = IPM.CD_ITPRE_MED
                AND TE.CD_TIP_ESQ (+) = IPM.CD_TIP_ESQ
                AND TP.CD_TIP_PRESC (+) = IPM.CD_TIP_PRESC
                AND PM.TP_PRE_MED = 'M'
                AND TE.TP_CHECAGEM = 'CC'
                AND NVL(IPM.SN_CANCELADO, 'N') = 'N'
                AND NVL(IPM.TP_SITUACAO, 'N') = 'N'
                AND NVL(TE.SN_TIPO, 'N') = 'S'
                AND NVL(HIPC.SN_SUSPENSO, 'N') = 'N'
                AND PM.CD_ATENDIMENTO (+) = REGISTRO
                AND TO_DATE(TO_CHAR(SYSDATE, 'DD/MM/RRRR')||' '||TO_CHAR(PM.HR_PRE_MED, 'HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS') <= TO_DATE(TO_CHAR(PM.DT_VALIDADE, 'DD/MM/RRRR HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS')
                AND TO_DATE(TO_CHAR(SYSDATE, 'DD/MM/RRRR HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS') BETWEEN TO_DATE(TO_CHAR(PM.DT_PRE_MED, 'DD/MM/RRRR')||' '||TO_CHAR(PM.HR_PRE_MED, 'HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS') AND TO_DATE(TO_CHAR(PM.DT_VALIDADE, 'DD/MM/RRRR HH24:MI:SS'), 'DD/MM/RRRR HH24:MI:SS')
                ORDER BY PM.CD_PRE_MED DESC
            )
        )ORDER BY DECODE(REGRA, 'RED', 1, 'YELLOW', 2, 'GREEN', 3) ASC, DH_MEDICACAO ASC
    )FETCH FIRST 1 ROW ONLY) AS CHECAGEM , (
    SELECT  Max (horas_minutos) horas_minutos
    FROM
    (
        SELECT  cd_pre_med
            ,cd_atendimento
            ,dh_criacao
            ,TO_CHAR(TRUNC((HORAS_ABERTO_MINUTO * 60) / 3600),'FM9900') || ':' || TO_CHAR(TRUNC(MOD((HORAS_ABERTO_MINUTO * 60),3600) / 60),'FM00') || ':' || TO_CHAR(MOD((HORAS_ABERTO_MINUTO * 60),60),'FM00') horas_minutos
        FROM
        (
            SELECT  PRE_MED.cd_pre_med
                ,PRE_MED.cd_atendimento
                ,dh_criacao
                ,pre_med.hr_pre_med
                ,tip_presc.cd_tip_esq
                ,pre_med.tp_pre_med
                ,(SYSDATE - dh_criacao )*24*60 HORAS_ABERTO_MINUTO
            FROM pre_med , itpre_med , ATENDIME , tip_presc
            WHERE pre_med.cd_pre_med = itpre_med.cd_pre_med
            AND PRE_MED.CD_ATENDIMENTO = REGISTRO
            AND itpre_med.cd_tip_presc = tip_presc.cd_tip_presc
            AND pre_med.fl_impresso = 'S'
            AND itpre_med.cd_tip_esq IN ( 'DII' )
            AND pre_med.cd_objeto = 418
            AND itpre_med.cd_tip_presc = 5919
            AND dh_cancelado IS NULL
            AND ATENDIME.DT_ALTA IS NULL
            AND NOT EXISTS (
            SELECT  PRE_MED.cd_atendimento
            FROM pre_med P , itpre_med , ATENDIME A , tip_presc
            WHERE P.cd_pre_med = itpre_med.cd_pre_med
            AND P.CD_ATENDIMENTO = A.CD_ATENDIMENTO
            AND itpre_med.cd_tip_presc = tip_presc.cd_tip_presc
            AND P.fl_impresso = 'S'
            AND itpre_med.cd_tip_esq IN ( 'DIE' )
            AND dh_cancelado IS NULL
            AND A.DT_ALTA IS NULL
            AND A.cd_atendimento = REGISTRO
            AND P.hr_pre_med > pre_med.hr_pre_med )
            ORDER BY DH_CRIACAO
        )
    )
    GROUP BY  CD_ATENDIMENTO ) AS DIETA_ZERO
    FROM(
          /*BLOCO INTERMEDIARIO*/
        (
        SELECT  
        Cd_Unid_Int P_Unidade
        ,Rownum P_Linha
        ,Cd_Leito
        ,Leito
        ,Paciente
        ,DN
        ,Registro
        ,CD_PRONTUARIO
        ,Medico
        ,Convenio
        ,Internacao
        ,Prev_Alta
        ,Dias
        ,Dias_Alta
        ,Dia_no_Leito
        ,entrada_deterioracao
        ,saida_deterioracao
        ,hemodialise
        ,entrada_avc
        ,saida_avc
        ,sca
        ,Decode(Paciente,null,null,Decode(AgendaBlocoCirurgico,1,'BLOCO',null)) BLC
        ,Decode(Paciente,null,null,Decode(AgendaHemodinamica,1,'TRUE',null)) HMD
        ,Decode(Paciente,null,null,Decode(AgendaEndoscopia,1,'TRUE',null)) END
        ,Decode(Paciente,null,null,Decode(EvolucaoEnfermagem,1,'RED',2,'YELLOW','GREEN')) EVE
        ,Decode(Paciente,null,null,Decode(PrescricaoMedica,1,'RED',2,'YELLOW','GREEN')) PRM
        ,Decode(Paciente,null,null,Decode(PrescricaoAberta,1,'RED','GREEN')) PRA
        ,Decode(Paciente,null,null,Decode(ChecagemMedicacao,1,'RED','GREEN')) CKG
        ,Decode(Paciente,null,null,Decode(ParecerMedico,1,'RED',2,'YELLOW',3,'GREEN')) PAM
        ,Decode(Paciente,null,null,Proximohorario) PXH
        ,Decode(Paciente,null,null,Decode(Aprazamento,1,'RED','GREEN')) APZ
        ,Decode(Paciente,null,null,Decode(ProtocoloTev,1,'TRUE',null)) TEV
        ,Decode(Paciente,null,null,Decode(ProtocoloQueda,1,'YELLOW',2,'RED',5,'GREEN')) QUE
        
        ,Decode(Paciente,null,null,Decode(ProtocoloBronco,1,'YELLOW',2,'RED',5,'GREEN')) BCP
        ,Decode(Paciente,null,null,Decode(ProtocoloDor,1,'YELLOW',2,'RED',5,'GREEN')) DOR
        ,Decode(Paciente,null,null,VlrScoreEnfermagem) SCE
        ,Decode(Paciente,null,null,CatCentral) CVC
        ,Decode(Paciente,null,null,SondaVesical) SDV
        ,Decode(Paciente,null,null,VlrScoreMedico) SCM
        ,Decode(Paciente,null,null,Decode(PrecaucaoAr,1,'GREEN',null)) PAR
        ,Decode(Paciente,null,null,Decode(PrecaucaoContato,1,'GREEN',null)) PCT
        ,Decode(Paciente,null,null,Decode(PrecaucaoGoticula,1,'GREEN',null)) PGT
        ,Decode(Paciente,null,null,Decode(PrecaucaoMaxima,1,'GREEN',null)) PMX
        ,Decode(Paciente,null,null,Decode(PrecaucaoPadrao,1,'GREEN',null)) PPD
        ,Decode(Paciente,null,null,Decode(AvisoAlergia,1,'GREEN',null)) ALE
        ,Decode(Paciente,null,null,Decode(Monitoramento,1,'YELLOW','GREEN')) MON
        ,Decode(Paciente,null,null,Decode(BalancoHidrico,1,'RED','GREEN')) BLH
        ,Decode(Paciente,null,null,Decode(ResultadoExames,1,'RESULTADO_EXAME',3,'DOC_PREENCHIDO')) EXA
        ,Decode(Paciente,null,null,Decode(ResultadoImagens,1,'RESULTADO_IMAGEM',3,'DOC_PREENCHIDO')) IMG
        ,Decode(Paciente,null,null,Decode(PedidoFarmaciaAtrasado,1,'RED',Decode(PedidoFarmaciaPendente,1,'ESTOQUE','GREEN'))) PED
        ,Decode(Paciente,null,null,Decode(PedidoFarmaciaDevolucao,1,'ESTOQUE',2,'RED','GREEN')) DEV
        ,Decode(Paciente,NULL,NULL,Decode(AuditoriaChecagem,1,'RED','GREEN')) AUD
        ,Decode(LocalPaciente,1,'BLOCO',2,'SRPA' ,Decode(AltaMedica,1,'ALTA' ,Decode(Tp_Ocupacao,'O','OCUPADO','R','RESERVADO','M','MANUTENCAO','I','INFECTADO','A','ACOMPANHANTE','V','VAGO' ,Decode(StatusLimpeza,'L','HIGIENIZACAO','H','LIMPEZA','C','CAMAREIRA','P','POS_LIMPEZA',Decode(TP_ocupacao,'L','HIGIENIZACAO'))))) Sit
        ,Decode(Paciente,null,NULL,Hint) Hint
        FROM(
            SELECT  
            Leitos.Cd_Leito
            ,Leitos.Cd_Unid_Int
            ,Leitos.Ds_Resumo Leito
            ,Movimento.Registro
            ,MOVIMENTO.CD_PRONTUARIO
            ,Movimento.Paciente
            ,Movimento.DN
            ,Movimento.Medico
            ,Movimento.Convenio
            ,Movimento.Internacao
            ,Movimento.Prev_Alta
            ,Movimento.Dias
            ,Movimento.Dias_Alta
            ,Movimento.Dia_no_Leito
            ,Movimento.entrada_deterioracao
            ,Movimento.saida_deterioracao
            ,Movimento.hemodialise
            ,Movimento.entrada_avc
            ,Movimento.saida_avc
            ,Movimento.sca
            ,Movimento.AgendaBlocoCirurgico
            ,Movimento.AgendaHemodinamica
            ,Movimento.AgendaEndoscopia
            ,Movimento.ChecagemMedicacao
            ,Movimento.PedidoFarmaciaPendente
            ,MOvimento.PedidoFarmaciaAtrasado
            ,Movimento.PrescricaoMedica
            ,Movimento.PrescricaoAberta
            ,Movimento.ProximoHorario
            ,Movimento.ParecerMedico
            ,Movimento.Aprazamento
            ,Movimento.EvolucaoEnfermagem
            ,Movimento.ProtocoloTev
            ,Movimento.ProtocoloQueda
            ,Movimento.ProtocoloBronco
            ,Movimento.ProtocoloDor
            ,Movimento.VlrScoreEnfermagem
            ,Movimento.CatCentral
            ,Movimento.SondaVesical
            ,Movimento.VlrScoreMedico
            ,Movimento.PrecaucaoGoticula
            ,Movimento.PrecaucaoContato
            ,Movimento.PrecaucaoAr
            ,Movimento.PrecaucaoMaxima
            ,Movimento.PrecaucaoPadrao
            ,Movimento.AvisoAlergia
            ,Movimento.ResultadoExames
            ,Movimento.ResultadoImagens
            ,Movimento.PedidoFarmaciaDevolucao
            ,Movimento.BalancoHidrico
            ,Movimento.Monitoramento
            ,Movimento.AuditoriaChecagem
            ,Movimento.Hint
            ,Movimento.AltaMedica
            ,Movimento.cd_atendimento
            ,Movimento.LocalPaciente
            ,Leitos.Tp_Ocupacao
            ,Movimento.ItensApagar
            ,Leitos.Cd_Leito_Aih
            ,Leitos.StatusLimpeza
            
            FROM 
                (
                SELECT  
                    DBAMV.FNC_DES_OBTER_INICIAIS(Paciente.nm_paciente,1) Paciente
                    ,LPad(atendime.cd_atendimento,7,0) Registro
                    ,ATENDIME.CD_PACIENTE AS CD_PRONTUARIO
                    ,Decode(Substr(Prestador.nm_prestador,9,12),null,prestador.nm_prestador,Substr(prestador.nm_prestador,1,8)||'...') Medico
                    ,REGEXP_REPLACE(Prestador.nm_prestador, '\s([A-Za-z])[A-Za-z]+', ' \1.') Medico1
                    ,Decode(Substr(Convenio.Nm_Convenio,7,10),NULL,Convenio.Nm_Convenio,Substr(Convenio.Nm_Convenio,1,6)||'...') Convenio
                    ,To_Char(Atendime.Dt_Atendimento,'DD/MM/YYYY')||'-'||To_Char(Atendime.Hr_Atendimento,'hh24:mi') Internacao
                    ,To_Char(Paciente.dt_nascimento,'DD/MM/YYYY') DN
                    ,(SELECT VIE.ds_resposta 
                        FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VIE
                        WHERE VIE.CD_DOCUMENTO IN (1106)
                        AND VIE.TP_STATUS = 'FECHADO'
                        AND VIE.ds_identificador_filho = 'dt_pre_alta_1'
                        AND VIE.DH_FECHAMENTO IN (
                                                    SELECT Max(VDIC.DH_FECHAMENTO)
                                                    FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC
                                                    WHERE VDIC.CD_DOCUMENTO IN (1106)
                                                    AND VDIC.TP_STATUS = 'FECHADO'
                                                    AND VDIC.ds_identificador_filho = 'dt_pre_alta_1'
                                                    and VDIC.cd_atendimento = Atendime.cd_atendimento
                                                )
                        AND VIE.CD_ATENDIMENTO = Atendime.cd_atendimento) as Prev_Alta --Ajuste 1.0
                    --,To_Char(Atendime.Dt_Prevista_Alta,'dd/mm/yy') Prev_Alta
                    ,trunc(sysdate-Atendime.dt_atendimento) Dias
                    ,trunc (nvl(to_date (Atendime.dt_prevista_alta, 'dd/mm/rrrr hh24:mi'),trunc(sysdate))-trunc(sysdate)) Dias_Alta
                    ,(SELECT Trunc(sysdate - dt_mov_int) FROM mov_int WHERE cd_leito = Atendime.cd_leito AND cd_atendimento = Atendime.cd_atendimento AND dt_lib_mov IS NULL) AS Dia_no_Leito
                    ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (1291)  AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS entrada_deterioracao
                    ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (1292)  AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS saida_deterioracao
                    ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (1408)  AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS hemodialise /*--WHERE VDIC.CD_DOCUMENTO IN (1488)*/
                    ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (886,809) AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS entrada_avc
                    ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (961)   AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS saida_avc
                    ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (835)   AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS sca
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'CHECAGEMMEDICACAO',Atendime.Cd_Multi_Empresa) ChecagemMedicacao
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROXIMOHORARIO',Atendime.Cd_Multi_Empresa) ProximoHorario
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'APRAZAMENTO',Atendime.Cd_Multi_Empresa) Aprazamento
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PEDIDOFARMACIAPENDENTE',Atendime.Cd_Multi_Empresa) PedidoFarmaciaPendente
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PEDIDOFARMACIAATRASADO',Atendime.Cd_Multi_Empresa) PedidoFarmaciaAtrasado
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PRESCRICAOMEDICA',Atendime.Cd_Multi_Empresa) PrescricaoMedica
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PRESCRICAOABERTA',Atendime.Cd_Multi_Empresa) PrescricaoAberta
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PARECERMEDICO',Atendime.Cd_Multi_Empresa) ParecerMedico
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'EVOLUCAOENFERMAGEM',Atendime.Cd_Multi_Empresa) EvolucaoEnfermagem
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROTOCOLOTEV_SEMINDICE',Atendime.Cd_Multi_Empresa) ProtocoloTev
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROTOCOLOQUEDA',Atendime.Cd_Multi_Empresa) ProtocoloQueda
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROTOCOLOBRONCO',Atendime.Cd_Multi_Empresa) ProtocoloBronco
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROTOCOLODOR',Atendime.Cd_Multi_Empresa) ProtocoloDor
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'VLRSCOREENFERMAGEM',Atendime.Cd_Multi_Empresa) VlrScoreEnfermagem
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'CATCENTRAL',Atendime.Cd_Multi_Empresa) CatCentral
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'SONDAVESICAL',Atendime.Cd_Multi_Empresa) SondaVesical
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'VLRSCOREMEDICO',Atendime.Cd_Multi_Empresa) VlrScoreMedico
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AGENDABLOCOCIRURGICO',Atendime.Cd_Multi_Empresa) AgendaBlocoCirurgico
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AGENDAHEMODINAMICA',Atendime.Cd_Multi_Empresa) AgendaHemodinamica
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AGENDAENDOSCOPIA',Atendime.Cd_Multi_Empresa) AgendaEndoscopia
                    ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOGOTICULA',Atendime.Cd_Multi_Empresa) PrecaucaoGoticula
                    ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOCONTATO',Atendime.Cd_Multi_Empresa) PrecaucaoContato
                    ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOAR',Atendime.Cd_Multi_Empresa) PrecaucaoAr
                    ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOMAXIMA',Atendime.Cd_Multi_Empresa) PrecaucaoMaxima
                    ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOPADRAO',Atendime.Cd_Multi_Empresa) PrecaucaoPadrao
                    ,Nvl(Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AVISOALERGIATELA',Atendime.Cd_Multi_Empresa),Dbamv.Fnc_Painel_Assistencial(cd_atendimento,'AVISOALERGIATELA',Atendime.Cd_Multi_Empresa)) AvisoAlergia
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'RESULTADOEXAMES',Atendime.Cd_Multi_Empresa) ResultadoExames
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PEDIDOFARMACIADEVOLUCAO',Atendime.Cd_Multi_Empresa) PedidoFarmaciaDevolucao
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'BALANCOHIDRICO',Atendime.Cd_Multi_Empresa) BalancoHidrico
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'ALTAMEDICA',Atendime.Cd_Multi_Empresa) AltaMedica
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'RESULTADOIMAGENS',Atendime.Cd_Multi_Empresa) ResultadoImagens
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'MONITORAMENTO',Atendime.Cd_Multi_Empresa) Monitoramento
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AUDITORIACHECAGEM',Atendime.Cd_Multi_Empresa) AuditoriaChecagem
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'LOCALPACIENTE',Atendime.Cd_Multi_Empresa) LocalPaciente
                    ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'ITENSAPAGAR',Atendime.Cd_Multi_Empresa) ItensApagar
                    ,Rtrim(Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROXIMAMEDICACAO',Atendime.Cd_Multi_Empresa))||' '|| Rtrim(Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PEDIDOMEDICACAOATRASADA',Atendime.Cd_Multi_Empresa))||' '|| Rtrim(Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'MEDICACAOATRASADA',Atendime.Cd_Multi_Empresa)) Hint
                    ,Atendime.cd_atendimento Cd_atendimento
                    ,Leito.Cd_Leito_Aih Cd_Laito_Aih
                    ,Leito.Cd_leito Cd_leito
                    
                FROM Dbamv.Atendime , Dbamv.Leito , Dbamv.Paciente , Dbamv.Prestador , Dbamv.Convenio
                WHERE Atendime.Cd_Leito = Leito.Cd_Leito
                AND Atendime.Cd_Paciente = paciente.cd_paciente
                AND atendime.cd_prestador = prestador.cd_prestador
                AND Atendime.Cd_convenio = Convenio.Cd_Convenio
                AND Atendime.Tp_Atendimento = 'I' -- MODIFICADO POR 26521
                AND Atendime.Dt_Alta is NULL
                AND Atendime.Cd_Multi_Empresa IN (1)
                --AND Leito.Cd_Unid_Int IN (1,2,3,4,5,22)
                --AND Atendime.CD_ORI_ATE IN (1,2,3,4,5,22)
                --AND leito.cd_unid_int is not null
                AND (SELECT VIE.ds_resposta 
                        FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VIE
                        WHERE VIE.CD_DOCUMENTO IN (1106)
                        AND VIE.TP_STATUS = 'FECHADO'
                        AND VIE.ds_identificador_filho = 'dt_pre_alta_1'
                        AND VIE.DH_FECHAMENTO IN (
                                                    SELECT Max(VDIC.DH_FECHAMENTO)
                                                    FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC
                                                    WHERE VDIC.CD_DOCUMENTO IN (1106)
                                                    AND VDIC.TP_STATUS = 'FECHADO'
                                                    AND VDIC.ds_identificador_filho = 'dt_pre_alta_1'
                                                    and VDIC.cd_atendimento = Atendime.cd_atendimento
                                                )
                        AND VIE.CD_ATENDIMENTO = Atendime.cd_atendimento) >= TRUNC(SYSDATE)
                ) Movimento
                 ,(
                SELECT  Leito.Cd_leito
                ,Leito.Cd_Leito_Aih
                ,Leito.Cd_Unid_Int
                ,Leito.Sn_Extra
                ,Leito.Ds_Resumo
                ,Leito.Tp_Ocupacao
                ,SolicLimpeza.StatusLimpeza
                ,leito.cd_tip_acom
                FROM Dbamv.Leito ,
                (
                SELECT  Solic_Limpeza.Cd_Leito
                ,Decode(Solic_Limpeza.Dt_Inicio_Higieniza,NULL,'H',Decode(solic_limpeza.dt_hr_fim_higieniza,NULL,'L',Decode(Solic_Limpeza.Dt_Hr_Fim_Rouparia,NULL,'C',Decode(Solic_Limpeza.Dt_Hr_Fim_Pos_higieniza,NULL,'P',Decode(Solic_Limpeza.Dt_Realizado,NULL,'L'))))) StatusLimpeza
                FROM Dbamv.Solic_Limpeza
                WHERE To_Char(Solic_Limpeza.Dt_Solic_Limpeza, 'dd/mm/rrrr')||' '||To_Char(Solic_Limpeza.Hr_Solic_Limpeza, 'hh24:mi') IS NOT NULL
                AND To_Char(Solic_Limpeza.Dt_Hr_Fim_pos_higieniza, 'dd/mm/rrrr hh24:mi') IS null
                AND (Solic_Limpeza.Cd_Leito, To_Date(To_Char(Solic_Limpeza.Dt_Solic_Limpeza, 'dd/mm/rrrr')||' '||To_Char(Solic_Limpeza.Hr_Solic_Limpeza, 'hh24:mi'), 'dd/mm/yyyy hh24:mi')) IN ( SELECT Solic_Limpeza.Cd_Leito , MAX(To_Date(To_Char(Solic_Limpeza.Dt_Solic_Limpeza, 'dd/mm/rrrr')||' '||To_Char(Solic_Limpeza.Hr_Solic_Limpeza, 'hh24:mi'), 'dd/mm/yyyy hh24:mi')) DtInicioLimpeza FROM Dbamv.solic_limpeza GROUP BY Solic_limpeza.cd_leito )
                ) SolicLimpeza
                WHERE Leito.Cd_Leito = SolicLimpeza.Cd_Leito(+)
                AND Leito.Dt_Desativacao is null ) Leitos
                WHERE Leitos.Cd_leito = Movimento.Cd_leito(+)
                AND Decode(Leitos.Sn_Extra, 'S', Movimento.Registro, Leitos.Cd_Leito) Is Not NULL
                ORDER BY Leito
        )
        --WHERE Cd_Unid_Int IN (1,2,3,4,5,22)
        )
    )    
)
