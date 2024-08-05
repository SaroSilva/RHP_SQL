select 
NVL (A.CD_ATENDIMENTO,B.CD_ATENDIMENTO) AS CD_ATENDIMENTO
, NVL (A.DT_ATENDIMENTO,B.DT_ATENDIMENTO) AS DT_ATENDIMENTO
, NVL (A.NM_PACIENTE,B.NM_PACIENTE) AS NM_PACIENTE
, NVL (A.NM_CONVENIO,B.NM_CONVENIO) AS NM_CONVENIO
, NVL (A.CD_FILA_SENHA,B.CD_FILA_SENHA) AS CD_FILA_SENHA
, NVL (A.DS_SENHA,B.DS_SENHA) AS DS_SENHA
, NVL (A.DESC_FILA,B.DESC_FILA) AS DESC_FILA
, NVL (A.EMERGENCIA,B.EMERGENCIA) AS EMERGENCIA
, NVL (A.CD_ORI_ATE,B.CD_ORI_ATE) AS CD_ORI_ATE
, NVL (A.DS_ORI_ATE,B.DS_ORI_ATE) AS DS_ORI_ATE
, NVL (A.TOTEM,B.TOTEM) AS TOTEM
, NVL (A.CLASS_CHAMADA,B.CLASS_CHAMADA) AS CLASS_CHAMADA
, NVL (A.CLASS_IN�CIO,B.CLASS_IN�CIO) AS CLASS_IN�CIO
, NVL (A.CLASS_RETIRA_SENHA,B.CLASS_RETIRA_SENHA) AS CLASS_RETIRA_SENHA
, NVL (A.CLASS_FINAL,B.CLASS_FINAL) AS CLASS_FINAL
, CASE WHEN (A.TEMPO_1 <= 0 OR A.TEMPO_1 IS NULL) THEN B.TEMPO_1 ELSE A.TEMPO_1 END AS TEMPO_1
, CASE WHEN (A.TEMPO_1 <= 0 OR A.TEMPO_1 IS NULL) THEN TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(B.TEMPO_1, 'MINUTE'), 'HH24:MI') ELSE TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(A.TEMPO_1, 'MINUTE'), 'HH24:MI') END AS HM_TEMPO1
, CASE WHEN (A.TEMPO_2 <= 0 OR A.TEMPO_2 IS NULL) THEN B.TEMPO_2 ELSE A.TEMPO_2 END AS TEMPO_2
, CASE WHEN (A.TEMPO_2 <= 0 OR A.TEMPO_2 IS NULL) THEN TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(B.TEMPO_2, 'MINUTE'), 'HH24:MI') ELSE TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(A.TEMPO_2, 'MINUTE'), 'HH24:MI') END AS HM_TEMPO2

, NVL (A.AT_ADM_CHAMADA,B.AT_ADM_CHAMADA) AS AT_ADM_CHAMADA
, NVL (A.AT_ADM_IN�CIO,B.AT_ADM_IN�CIO) AS AT_ADM_IN�CIO
, NVL (A.AT_ADM_FINAL,B.AT_ADM_FINAL) AS AT_ADM_FINAL
, CASE WHEN (A.TEMPO_3 <= 0 OR A.TEMPO_3 IS NULL) THEN B.TEMPO_3 ELSE A.TEMPO_3 END AS TEMPO_3
, CASE WHEN (A.TEMPO_3 <= 0 OR A.TEMPO_3 IS NULL) THEN TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(B.TEMPO_3, 'MINUTE'), 'HH24:MI') ELSE TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(A.TEMPO_3, 'MINUTE'), 'HH24:MI') END AS HM_TEMPO3
, CASE WHEN (A.TEMPO_4 <= 0 OR A.TEMPO_4 IS NULL) THEN B.TEMPO_4 ELSE A.TEMPO_4 END AS TEMPO_4
, CASE WHEN (A.TEMPO_4 <= 0 OR A.TEMPO_4 IS NULL) THEN TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(B.TEMPO_4, 'MINUTE'), 'HH24:MI') ELSE TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(A.TEMPO_4, 'MINUTE'), 'HH24:MI') END AS HM_TEMPO4

, NVL (B.AT_M�DICO_CHAMADA,A.AT_M�DICO_CHAMADA) AS AT_M�DICO_CHAMADA
, NVL (B.AT_M�DICO_IN�CIO,A.AT_M�DICO_IN�CIO) AS AT_M�DICO_IN�CIO
, NVL (B.AT_M�DICO_FINAL,A.AT_M�DICO_FINAL) AS AT_M�DICO_FINAL
, NVL (B.AT_M�DICO_ALTA,A.AT_M�DICO_ALTA) AS AT_M�DICO_ALTA
, CASE WHEN (A.TEMPO_5 <= 0 OR A.TEMPO_5 IS NULL) THEN B.TEMPO_5 ELSE A.TEMPO_5 END AS TEMPO_5
, CASE WHEN (A.TEMPO_5 <= 0 OR A.TEMPO_5 IS NULL) THEN TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(B.TEMPO_5, 'MINUTE'), 'HH24:MI') ELSE TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(A.TEMPO_5, 'MINUTE'), 'HH24:MI') END AS HM_TEMPO5

, A.SN_ATENDIMENTO_MED

, A.SN_REAVALIA_MED
, NVL(B.DH_START_REAVALIA,A.DH_START_REAVALIA) AS DH_START_REAVALIA
, NVL(B.DH_REAVALIA_MED,A.DH_REAVALIA_MED) AS DH_REAVALIA_MED
, CASE WHEN (A.TEMPO_9 <= 0 OR A.TEMPO_9 IS NULL) THEN B.TEMPO_9 ELSE A.TEMPO_9 END AS TEMPO_9
, CASE WHEN (A.TEMPO_9 <= 0 OR A.TEMPO_9 IS NULL) THEN TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(B.TEMPO_9, 'MINUTE'), 'HH24:MI') ELSE TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(A.TEMPO_9, 'MINUTE'), 'HH24:MI') END AS HM_TEMPO9

FROM (
SELECT 
        CD_ATENDIMENTO,
        DT_ATENDIMENTO,
        DT_ALTA_MEDICA,
        NM_PACIENTE,
        NM_CONVENIO,
        CD_FILA_SENHA,
        DS_SENHA,
        CASE 
        WHEN CD_FILA_SENHA = 19  THEN 'Real Vida - ATENDIMENTO PREFERENCIAL'   
        WHEN CD_FILA_SENHA = 29  THEN 'Real Vida - ATENDIMENTO NORMAL'
        WHEN CD_FILA_SENHA = 182 THEN 'Real Vida - CONVOCA��O DE TRANSPLANTE'
        WHEN CD_FILA_SENHA = 244 THEN 'Real Vida - PACIENTE COM DEFICI�NCIA'
        WHEN CD_FILA_SENHA = 246 THEN 'Real Vida - PACIENTE AVC' 
        WHEN CD_FILA_SENHA = 248 THEN 'Real Vida - SUPER IDOSO 80+'
        WHEN CD_FILA_SENHA = 161 THEN 'Real Vida - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 196 THEN 'Real Vida - NEUROLOGIA'
        WHEN CD_FILA_SENHA = 210 THEN 'Real Vida - PACIENTE EM CURSO DE QT/RT'
        WHEN CD_FILA_SENHA = 220 THEN 'Real Vida - S�NDROME GRIPAL' 
        WHEN CD_FILA_SENHA = 221 THEN 'Real Vida - ORTOPEDIA'
        WHEN CD_FILA_SENHA = 222 THEN 'Real Vida - OTORRINOLARINGOLOGIA'
        WHEN CD_FILA_SENHA = 245 THEN 'Real Vida - PACIENTE GESTANTE'
        WHEN CD_FILA_SENHA = 247 THEN 'Real Vida - PACIENTE DOR TOR�CIC'
        WHEN CD_FILA_SENHA = 335 THEN 'Real Vida - TEA'
        WHEN CD_FILA_SENHA = 136 THEN 'Real Vida - CARDIOLOGIA'
        WHEN CD_FILA_SENHA = 17  THEN 'Infante - ATENDIMENTO'
        WHEN CD_FILA_SENHA = 99  THEN 'Infante - PREFERENCIAL- PESSOA COM DEFICI�NCIA'
        WHEN CD_FILA_SENHA = 100 THEN 'Infante - PREFERENCIAL - GENITORA GR�VIDA'
        WHEN CD_FILA_SENHA = 168 THEN 'Infante - VIAGEM RECENTE PARA CHINA'
        WHEN CD_FILA_SENHA = 97  THEN 'Infante - PREFERENCIAL - PACIENTE ONCOPEDIATRIA'
        WHEN CD_FILA_SENHA = 162 THEN 'Infante - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 175 THEN 'Infante - S�NDROME GRIPAL' 
        WHEN CD_FILA_SENHA = 98  THEN 'Infante - PREFERENCIAL - REC�M NASCIDO'
        WHEN CD_FILA_SENHA = 198 THEN 'Infante - VIAGEM RECENTE PARA REGI�O NORTE BR'
        WHEN CD_FILA_SENHA = 22 THEN 'RM - ATENDIMENTO URG�NCIA /GESTANTE'
        WHEN CD_FILA_SENHA = 60 THEN 'RM - INTERNAMENTO'
        WHEN CD_FILA_SENHA = 61 THEN 'RM - ATENDIMENTO URG�NCIA /GINECOL�GICO'
        WHEN CD_FILA_SENHA = 170 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 172 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 178 THEN 'RM - FEBRE E SINTOMAS RESPIRAT�RIOS'
        WHEN CD_FILA_SENHA = 25 THEN 'BV - ATENDIMENTO PREFERENCIAL'
        WHEN CD_FILA_SENHA = 45 THEN 'BV - ATENDIMENTO PEDIATRIA'
        WHEN CD_FILA_SENHA = 53 THEN 'BV - ATENDIMENTO PREFERENCIAL'
        WHEN CD_FILA_SENHA = 54 THEN 'BV - TOMOGRAFIA'
        WHEN CD_FILA_SENHA = 55 THEN 'BV - EXAMES LABORATORIAIS'
        WHEN CD_FILA_SENHA = 56 THEN 'BV - ATENDIMENTO NORMAL'
        WHEN CD_FILA_SENHA = 57 THEN 'BV - EXAMES DE IMAGEM'
        WHEN CD_FILA_SENHA = 58 THEN 'BV - ATENDIMENTO PEDIATRIA'
        WHEN CD_FILA_SENHA = 59 THEN 'BV - ULTRASSONOGRAFIA'
        WHEN CD_FILA_SENHA = 164 THEN 'BV - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 165 THEN 'BV - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 171 THEN 'BV - VIAGEM RECENTE PARA CHINA'
        WHEN CD_FILA_SENHA = 174 THEN 'BV - FEBRE E SINTOMAS RESPIRAT�RIOS'
        WHEN CD_FILA_SENHA = 228 THEN 'BV - RESSON�NCIA / TOMOGRAFIA' 
        WHEN CD_FILA_SENHA = 229 THEN 'BV - RAIO X / USG / MAMOGRAFIA'
        WHEN CD_FILA_SENHA = 230 THEN 'BV - S�NDROME GRIPAL'
        WHEN CD_FILA_SENHA = 233 THEN 'BV - EXAMES AGENDADOS REAL IMAGEM'
        WHEN CD_FILA_SENHA = 234 THEN 'BV - MARCA��O DE EXAMES REAL IMAGEM'
        WHEN CD_FILA_SENHA = 235 THEN 'BV - EXAMES DE IMAGEM PREFERENCIAL'
        WHEN CD_FILA_SENHA = 278 THEN 'BV - ATENDIMENTO PREFERENCIAL'
        WHEN CD_FILA_SENHA = 332 THEN 'BV - SINDROME GRIPAL'
        WHEN CD_FILA_SENHA = 343 THEN 'BV - TEA'
        END DESC_FILA,
        CASE 
        WHEN CD_FILA_SENHA = 19 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 29 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 182 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 244 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 246 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 248 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 161 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 196 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 210 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 220 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 221 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 222 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 245 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 247 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 335 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 136 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 17 THEN 'Infante'
        WHEN CD_FILA_SENHA = 99 THEN 'Infante'
        WHEN CD_FILA_SENHA = 100 THEN 'Infante'
        WHEN CD_FILA_SENHA = 168 THEN 'Infante'
        WHEN CD_FILA_SENHA = 97 THEN 'Infante'
        WHEN CD_FILA_SENHA = 162 THEN 'Infante'
        WHEN CD_FILA_SENHA = 175 THEN 'Infante'
        WHEN CD_FILA_SENHA = 98 THEN 'Infante'
        WHEN CD_FILA_SENHA = 198 THEN 'Infante'
        WHEN CD_FILA_SENHA = 22 THEN 'RM'
        WHEN CD_FILA_SENHA = 60 THEN 'RM'
        WHEN CD_FILA_SENHA = 61 THEN 'RM'
        WHEN CD_FILA_SENHA = 170 THEN 'RM'
        WHEN CD_FILA_SENHA = 172 THEN 'RM'
        WHEN CD_FILA_SENHA = 178 THEN 'RM'
        WHEN CD_FILA_SENHA = 25 THEN 'BV'
        WHEN CD_FILA_SENHA = 45 THEN 'BV'
        WHEN CD_FILA_SENHA = 53 THEN 'BV'
        WHEN CD_FILA_SENHA = 54 THEN 'BV'
        WHEN CD_FILA_SENHA = 55 THEN 'BV'
        WHEN CD_FILA_SENHA = 56 THEN 'BV'
        WHEN CD_FILA_SENHA = 57 THEN 'BV'
        WHEN CD_FILA_SENHA = 58 THEN 'BV'
        WHEN CD_FILA_SENHA = 59 THEN 'BV'
        WHEN CD_FILA_SENHA = 164 THEN 'BV'
        WHEN CD_FILA_SENHA = 165 THEN 'BV'
        WHEN CD_FILA_SENHA = 171 THEN 'BV'
        WHEN CD_FILA_SENHA = 174 THEN 'BV'
        WHEN CD_FILA_SENHA = 228 THEN 'BV'
        WHEN CD_FILA_SENHA = 229 THEN 'BV'
        WHEN CD_FILA_SENHA = 230 THEN 'BV'
        WHEN CD_FILA_SENHA = 233 THEN 'BV'
        WHEN CD_FILA_SENHA = 234 THEN 'BV'
        WHEN CD_FILA_SENHA = 235 THEN 'BV'
        WHEN CD_FILA_SENHA = 278 THEN 'BV'
        WHEN CD_FILA_SENHA = 332 THEN 'BV'
        WHEN CD_FILA_SENHA = 343 THEN 'BV'
    END as emergencia,
        CD_ORI_ATE,
        DS_ORI_ATE,
        MAX (TOTEM) AS TOTEM,
        NVL (MAX(CLASS_CHAMADA),MAX(CLASS_IN�CIO)) AS CLASS_CHAMADA,
        MAX(CLASS_IN�CIO) AS CLASS_IN�CIO,
        MAX (CLASS_RETIRA_SENHA) AS CLASS_RETIRA_SENHA,
        MAX(CLASS_FINAL) AS CLASS_FINAL,
        ROUND(((nvl(MAX(CLASS_FINAL),SYSDATE) - MAX (TOTEM))*24 *60),0) AS TEMPO_1, --SENHA AT� O FIM DA CLASSIFICA��O
        ROUND(((NVL(NVL (MAX(AT_ADM_CHAMADA), MAX(AT_ADM_IN�CIO)), SYSDATE)- NVL(MAX(CLASS_FINAL),SYSDATE)) * 24 * 60),0) AS TEMPO_2, --AGUARDANDO RECEP��O CHAMAR
        NVL (MAX(AT_ADM_CHAMADA),MAX(AT_ADM_IN�CIO)) AS AT_ADM_CHAMADA,
        MAX(AT_ADM_IN�CIO) AS AT_ADM_IN�CIO,
        MAX(AT_ADM_FINAL) AS AT_ADM_FINAL,
        ROUND(((NVL(MAX(AT_ADM_FINAL),SYSDATE) - NVL(NVL(MAX(AT_ADM_CHAMADA),MAX(AT_ADM_IN�CIO)),SYSDATE))*24*60),0) AS TEMPO_3, -- ATENDIMENTO DA RECEP��O
        ROUND((((NVL(NVL(MAX(AT_M�DICO_CHAMADA), MAX(AT_M�DICO_IN�CIO)),SYSDATE) - NVL (MAX(AT_ADM_FINAL),SYSDATE))) * 24 * 60),0) AS TEMPO_4, -- AGUARDANDO CHAMADA DO MEDICO
        NVL (MAX(AT_M�DICO_CHAMADA),MAX(AT_M�DICO_IN�CIO)) AS AT_M�DICO_CHAMADA,
        MAX(AT_M�DICO_IN�CIO) AS AT_M�DICO_IN�CIO,
        MAX(AT_M�DICO_FINAL) AS AT_M�DICO_FINAL,
        MAX(AT_M�DICO_ALTA) AS AT_M�DICO_ALTA,
        --ROUND((((SYSDATE - NVL(MAX(AT_M�DICO_IN�CIO),SYSDATE)))*24*60),0) AS TEMPO_5 -- EM ATENDIMENTO MEDICO
        ROUND((((NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
                            FROM 
                                DBAMV.PW_DOCUMENTO_CLINICO PDC, 
                                DBAMV.PW_EDITOR_CLINICO PEC,
                                DBAMV.PRESTADOR PRD, 
                                DBAMV.CONSELHO COS
                            WHERE PEC.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
                                AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
                                AND PRD.CD_CONSELHO = COS.CD_CONSELHO
                                AND COS.TP_CONSELHO = 1 --CRM
                                AND PEC.CD_DOCUMENTO IN (730,566,1130,1131,1298) --DOCUMENTOS DE EVOLU��O MEDICA
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                AND PDC.DH_CRIACAO >= TRUNC(SYSDATE)-1
                                ), SYSDATE) - NVL(MAX(AT_M�DICO_IN�CIO),SYSDATE)))*24*60),0) AS TEMPO_5, -- EM ATENDIMENTO MEDICO
                                                            
        CASE WHEN MAX(AT_M�DICO_IN�CIO) IS NULL THEN NULL                       
        WHEN MAX(AT_M�DICO_IN�CIO) IS NOT NULL AND 
        ( SELECT MAX(PDC.DH_FECHAMENTO) 
                            FROM 
                                DBAMV.PW_DOCUMENTO_CLINICO PDC, 
                                DBAMV.PW_EDITOR_CLINICO PE,
                                DBAMV.PRESTADOR PRD, 
                                DBAMV.CONSELHO COS
                            WHERE PDC.CD_DOCUMENTO_CLINICO = PE.CD_DOCUMENTO_CLINICO
                                AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
                                AND PRD.CD_CONSELHO = COS.CD_CONSELHO
                                AND COS.TP_CONSELHO = 1 --CRM
                                AND PE.CD_DOCUMENTO IN (730,566,1130,1131,1298) --DOCUMENTOS DE EVOLU��O MEDICA
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                AND PDC.DH_CRIACAO >= TRUNC(SYSDATE)-1
                                AND PDC.DH_FECHAMENTO < (SELECT MIN(PD.DH_CRIACAO) 
                                                        FROM 
                                                            DBAMV.PW_DOCUMENTO_CLINICO PD, 
                                                            DBAMV.PW_EDITOR_CLINICO PE,
                                                            DBAMV.PRESTADOR PR, 
                                                            DBAMV.CONSELHO CO
                                                        WHERE PD.CD_DOCUMENTO_CLINICO = PE.CD_DOCUMENTO_CLINICO
                                                            AND PD.CD_PRESTADOR = PR.CD_PRESTADOR
                                                            AND PR.CD_CONSELHO = CO.CD_CONSELHO
                                                            AND CO.TP_CONSELHO <> 1 --CRM
                                                            AND PD.CD_ATENDIMENTO = PDC.CD_ATENDIMENTO
                                                            AND PD.DH_CRIACAO >= TRUNC(SYSDATE)-1
                                                            ) 
                                                            ) IS NULL THEN 'N' ELSE 'S' END SN_ATENDIMENTO_MED,

        (SELECT PAR_SN_PENDENTE FROM PW_LISTA_REAV_URGENCIA_RHP WHERE PAR_CD_ATENDIMENTO = ATENDIMENTO) AS SN_REAVALIA_MED,
       
       (SELECT MAX(PDC.DH_FECHAMENTO) 
          FROM DBAMV.PW_DOCUMENTO_CLINICO PDC
          WHERE PDC.CD_OBJETO = 412
          AND PDC.CD_ATENDIMENTO = ATENDIMENTO) DH_START_REAVALIA,

        (SELECT MAX(PDC.DH_FECHAMENTO) 
          FROM 
              DBAMV.PW_DOCUMENTO_CLINICO PDC, 
              DBAMV.PW_EDITOR_CLINICO PEC,
              DBAMV.PRESTADOR PRD, 
              DBAMV.CONSELHO COS
          WHERE PEC.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
              AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
              AND PRD.CD_CONSELHO = COS.CD_CONSELHO
              AND COS.TP_CONSELHO = 1 --CRM
              AND PEC.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZA��O
              AND PDC.CD_ATENDIMENTO = ATENDIMENTO
          ) DH_REAVALIA_MED, -- FINAL DE REAVALIA��O MEDICA
          
          
        ROUND(((NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
                        FROM 
                            DBAMV.PW_DOCUMENTO_CLINICO PDC, 
                            DBAMV.PW_EDITOR_CLINICO PEC,
                            DBAMV.PRESTADOR PRD, 
                            DBAMV.CONSELHO COS
                        WHERE PEC.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
                            AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
                            AND PRD.CD_CONSELHO = COS.CD_CONSELHO
                            AND COS.TP_CONSELHO = 1 --CRM
                            AND PEC.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZA��O
                            AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                        ),SYSDATE)-NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
                                      FROM DBAMV.PW_DOCUMENTO_CLINICO PDC
                                      WHERE PDC.CD_OBJETO = 412
                                      AND PDC.CD_ATENDIMENTO = ATENDIMENTO),MAX(AT_M�DICO_FINAL)))*24*60),0) AS TEMPO_9                                                 
        
FROM (
            SELECT 
                STTP.DS_TIPO_TEMPO_PROCESSO,
                STP.DH_PROCESSO,
                tma.DS_SENHA,
                ATE.CD_ATENDIMENTO,
                ATE.CD_ATENDIMENTO ATENDIMENTO,
                ATE.DT_ATENDIMENTO,
                ATE.DT_ALTA_MEDICA,
                TMA.NM_PACIENTE,
                CON.NM_CONVENIO,
                TMA.CD_FILA_SENHA,
                OA.CD_ORI_ATE,
                OA.DS_ORI_ATE
                
            FROM 
                SACR_TEMPO_PROCESSO STP,
                SACR_TIPO_TEMPO_PROCESSO STTP,
                SACR_CATEGORIA_PROCESSO SCP,
                DBAMV.ATENDIME ATE,
                DBAMV.TRIAGEM_ATENDIMENTO TMA,
                DBAMV.ORI_ATE OA,
                DBAMV.CONVENIO CON
            --LIGA��ES
            WHERE STP.CD_TIPO_TEMPO_PROCESSO (+) = STTP.CD_TIPO_TEMPO_PROCESSO
            AND STTP.cd_categoria_processo = SCP.cd_categoria_processo (+)
            AND STP.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO(+)
            AND TMA.CD_TRIAGEM_ATENDIMENTO(+) = STP.CD_TRIAGEM_ATENDIMENTO
            AND OA.CD_ORI_ATE(+) = ATE.CD_ORI_ATE
            AND ATE.CD_CONVENIO = CON.CD_CONVENIO(+)
            
            --FILTROS
            AND DH_PROCESSO >= TRUNC(SYSDATE)
            and dh_processo < TRUNC(SYSDATE+1)
            --THOMAS
            AND   (TMA.CD_FILA_SENHA      IN (19,29,182,244,246,248,161,196,210,220,221,222,245,247,335,136,17,99,100,168,97,162,175,98,198,22,60,61,170,172,178)--UNIDADES AGAMENOM
                OR TMA.CD_FILA_SENHA   IN (25,26,27,43,44,45,53,/*54,55,56,57,*/58,/*59,*/164,165,171,174,/*228,229,*/230,/*233,234,235,*/278,332,343,345,346)) --UNIDADES BV)
                --order by cd_atendimento, dh_processo desc 
    ) 
        PIVOT (
            MAX(DH_PROCESSO) 
            FOR DS_TIPO_TEMPO_PROCESSO IN(
                'CADASTRO NO TOTEM' AS TOTEM, 
                'REMOVIDO DA LISTA' AS CLASS_RETIRA_SENHA,
                'CLASSIFICA��O CHAMADA' AS CLASS_CHAMADA, 
                'CLASSIFICA��O IN�CIO' AS CLASS_IN�CIO, 
                'CLASSIFICA��O FINAL' AS CLASS_FINAL, 
                'ATENDIMENTO ADMINISTRATIVO CHAMADA' AS AT_ADM_CHAMADA, 
                'ATENDIMENTO ADMINISTRATIVO IN�CIO' AS AT_ADM_IN�CIO, 
                'ATENDIMENTO ADMINISTRATIVO FINAL' AS AT_ADM_FINAL, 
                'ATENDIMENTO M�DICO CHAMADA' AS AT_M�DICO_CHAMADA, 
                'ATENDIMENTO M�DICO IN�CIO' AS AT_M�DICO_IN�CIO,
                'ATENDIMENTO M�DICO FINAL' AS AT_M�DICO_FINAL,
                'ATENDIMENTO M�DICO ALTA' AS AT_M�DICO_ALTA 
            )
        )
        
        GROUP BY 
        CD_ATENDIMENTO,
        DT_ATENDIMENTO,
        DT_ALTA_MEDICA,
        NM_PACIENTE,
        CD_FILA_SENHA,
        DS_SENHA,
        CD_ORI_ATE,
        DS_ORI_ATE,
        NM_CONVENIO
        
    ORDER BY CD_ATENDIMENTO DESC
)A
,(
SELECT 
        CD_ATENDIMENTO,
        DT_ATENDIMENTO,
        DT_ALTA_MEDICA,
        NM_PACIENTE,
        NM_CONVENIO,
        CD_FILA_SENHA,
        DS_SENHA,
        CASE 
        WHEN CD_FILA_SENHA = 19  THEN 'Real Vida - ATENDIMENTO PREFERENCIAL'   
        WHEN CD_FILA_SENHA = 29  THEN 'Real Vida - ATENDIMENTO NORMAL'
        WHEN CD_FILA_SENHA = 182 THEN 'Real Vida - CONVOCA��O DE TRANSPLANTE'
        WHEN CD_FILA_SENHA = 244 THEN 'Real Vida - PACIENTE COM DEFICI�NCIA'
        WHEN CD_FILA_SENHA = 246 THEN 'Real Vida - PACIENTE AVC' 
        WHEN CD_FILA_SENHA = 248 THEN 'Real Vida - SUPER IDOSO 80+'
        WHEN CD_FILA_SENHA = 161 THEN 'Real Vida - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 196 THEN 'Real Vida - NEUROLOGIA'
        WHEN CD_FILA_SENHA = 210 THEN 'Real Vida - PACIENTE EM CURSO DE QT/RT'
        WHEN CD_FILA_SENHA = 220 THEN 'Real Vida - S�NDROME GRIPAL' 
        WHEN CD_FILA_SENHA = 221 THEN 'Real Vida - ORTOPEDIA'
        WHEN CD_FILA_SENHA = 222 THEN 'Real Vida - OTORRINOLARINGOLOGIA'
        WHEN CD_FILA_SENHA = 245 THEN 'Real Vida - PACIENTE GESTANTE'
        WHEN CD_FILA_SENHA = 247 THEN 'Real Vida - PACIENTE DOR TOR�CIC'
        WHEN CD_FILA_SENHA = 335 THEN 'Real Vida - TEA'
        WHEN CD_FILA_SENHA = 136 THEN 'Real Vida - CARDIOLOGIA'
        WHEN CD_FILA_SENHA = 17  THEN 'Infante - ATENDIMENTO'
        WHEN CD_FILA_SENHA = 99  THEN 'Infante - PREFERENCIAL- PESSOA COM DEFICI�NCIA'
        WHEN CD_FILA_SENHA = 100 THEN 'Infante - PREFERENCIAL - GENITORA GR�VIDA'
        WHEN CD_FILA_SENHA = 168 THEN 'Infante - VIAGEM RECENTE PARA CHINA'
        WHEN CD_FILA_SENHA = 97  THEN 'Infante - PREFERENCIAL - PACIENTE ONCOPEDIATRIA'
        WHEN CD_FILA_SENHA = 162 THEN 'Infante - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 175 THEN 'Infante - S�NDROME GRIPAL' 
        WHEN CD_FILA_SENHA = 98  THEN 'Infante - PREFERENCIAL - REC�M NASCIDO'
        WHEN CD_FILA_SENHA = 198 THEN 'Infante - VIAGEM RECENTE PARA REGI�O NORTE BR'
        WHEN CD_FILA_SENHA = 22 THEN 'RM - ATENDIMENTO URG�NCIA /GESTANTE'
        WHEN CD_FILA_SENHA = 60 THEN 'RM - INTERNAMENTO'
        WHEN CD_FILA_SENHA = 61 THEN 'RM - ATENDIMENTO URG�NCIA /GINECOL�GICO'
        WHEN CD_FILA_SENHA = 170 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 172 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 178 THEN 'RM - FEBRE E SINTOMAS RESPIRAT�RIOS'
        WHEN CD_FILA_SENHA = 25 THEN 'BV - ATENDIMENTO PREFERENCIAL'
        WHEN CD_FILA_SENHA = 45 THEN 'BV - ATENDIMENTO PEDIATRIA'
        WHEN CD_FILA_SENHA = 53 THEN 'BV - ATENDIMENTO PREFERENCIAL'
        WHEN CD_FILA_SENHA = 54 THEN 'BV - TOMOGRAFIA'
        WHEN CD_FILA_SENHA = 55 THEN 'BV - EXAMES LABORATORIAIS'
        WHEN CD_FILA_SENHA = 56 THEN 'BV - ATENDIMENTO NORMAL'
        WHEN CD_FILA_SENHA = 57 THEN 'BV - EXAMES DE IMAGEM'
        WHEN CD_FILA_SENHA = 58 THEN 'BV - ATENDIMENTO PEDIATRIA'
        WHEN CD_FILA_SENHA = 59 THEN 'BV - ULTRASSONOGRAFIA'
        WHEN CD_FILA_SENHA = 164 THEN 'BV - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 165 THEN 'BV - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 171 THEN 'BV - VIAGEM RECENTE PARA CHINA'
        WHEN CD_FILA_SENHA = 174 THEN 'BV - FEBRE E SINTOMAS RESPIRAT�RIOS'
        WHEN CD_FILA_SENHA = 228 THEN 'BV - RESSON�NCIA / TOMOGRAFIA' 
        WHEN CD_FILA_SENHA = 229 THEN 'BV - RAIO X / USG / MAMOGRAFIA'
        WHEN CD_FILA_SENHA = 230 THEN 'BV - S�NDROME GRIPAL'
        WHEN CD_FILA_SENHA = 233 THEN 'BV - EXAMES AGENDADOS REAL IMAGEM'
        WHEN CD_FILA_SENHA = 234 THEN 'BV - MARCA��O DE EXAMES REAL IMAGEM'
        WHEN CD_FILA_SENHA = 235 THEN 'BV - EXAMES DE IMAGEM PREFERENCIAL'
        WHEN CD_FILA_SENHA = 278 THEN 'BV - ATENDIMENTO PREFERENCIAL'
        WHEN CD_FILA_SENHA = 332 THEN 'BV - SINDROME GRIPAL'
        WHEN CD_FILA_SENHA = 343 THEN 'BV - TEA'
        END DESC_FILA,
        CASE 
        WHEN CD_FILA_SENHA = 19 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 29 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 182 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 244 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 246 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 248 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 161 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 196 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 210 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 220 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 221 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 222 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 245 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 247 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 335 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 136 THEN 'Real Vida'
        WHEN CD_FILA_SENHA = 17 THEN 'Infante'
        WHEN CD_FILA_SENHA = 99 THEN 'Infante'
        WHEN CD_FILA_SENHA = 100 THEN 'Infante'
        WHEN CD_FILA_SENHA = 168 THEN 'Infante'
        WHEN CD_FILA_SENHA = 97 THEN 'Infante'
        WHEN CD_FILA_SENHA = 162 THEN 'Infante'
        WHEN CD_FILA_SENHA = 175 THEN 'Infante'
        WHEN CD_FILA_SENHA = 98 THEN 'Infante'
        WHEN CD_FILA_SENHA = 198 THEN 'Infante'
        WHEN CD_FILA_SENHA = 22 THEN 'RM'
        WHEN CD_FILA_SENHA = 60 THEN 'RM'
        WHEN CD_FILA_SENHA = 61 THEN 'RM'
        WHEN CD_FILA_SENHA = 170 THEN 'RM'
        WHEN CD_FILA_SENHA = 172 THEN 'RM'
        WHEN CD_FILA_SENHA = 178 THEN 'RM'
        WHEN CD_FILA_SENHA = 25 THEN 'BV'
        WHEN CD_FILA_SENHA = 45 THEN 'BV'
        WHEN CD_FILA_SENHA = 53 THEN 'BV'
        WHEN CD_FILA_SENHA = 54 THEN 'BV'
        WHEN CD_FILA_SENHA = 55 THEN 'BV'
        WHEN CD_FILA_SENHA = 56 THEN 'BV'
        WHEN CD_FILA_SENHA = 57 THEN 'BV'
        WHEN CD_FILA_SENHA = 58 THEN 'BV'
        WHEN CD_FILA_SENHA = 59 THEN 'BV'
        WHEN CD_FILA_SENHA = 164 THEN 'BV'
        WHEN CD_FILA_SENHA = 165 THEN 'BV'
        WHEN CD_FILA_SENHA = 171 THEN 'BV'
        WHEN CD_FILA_SENHA = 174 THEN 'BV'
        WHEN CD_FILA_SENHA = 228 THEN 'BV'
        WHEN CD_FILA_SENHA = 229 THEN 'BV'
        WHEN CD_FILA_SENHA = 230 THEN 'BV'
        WHEN CD_FILA_SENHA = 233 THEN 'BV'
        WHEN CD_FILA_SENHA = 234 THEN 'BV'
        WHEN CD_FILA_SENHA = 235 THEN 'BV'
        WHEN CD_FILA_SENHA = 278 THEN 'BV'
        WHEN CD_FILA_SENHA = 332 THEN 'BV'
        WHEN CD_FILA_SENHA = 343 THEN 'BV'
    END as emergencia,
        CD_ORI_ATE,
        DS_ORI_ATE,
        
        MAX (TOTEM) AS TOTEM,
        NVL (MAX(CLASS_CHAMADA),MAX(CLASS_IN�CIO)) AS CLASS_CHAMADA,
        MAX(CLASS_IN�CIO) AS CLASS_IN�CIO,
        MAX (CLASS_RETIRA_SENHA) AS CLASS_RETIRA_SENHA,
        MAX(CLASS_FINAL) AS CLASS_FINAL,
        ROUND(((nvl(MAX(CLASS_FINAL),SYSDATE) - MAX (TOTEM))*24 *60),0) AS TEMPO_1, --SENHA AT� O FIM DA CLASSIFICA��O
        
        ROUND(((NVL(NVL (MAX(AT_ADM_CHAMADA), MAX(AT_ADM_IN�CIO)), SYSDATE)- NVL(MAX(CLASS_FINAL),SYSDATE)) * 24 * 60),0) AS TEMPO_2, --AGUARDANDO RECEP��O CHAMAR
        
        NVL (MAX(AT_ADM_CHAMADA),MAX(AT_ADM_IN�CIO)) AS AT_ADM_CHAMADA,
        MAX(AT_ADM_IN�CIO) AS AT_ADM_IN�CIO,
        MAX(AT_ADM_FINAL) AS AT_ADM_FINAL,
        ROUND(((NVL(MAX(AT_ADM_FINAL),SYSDATE) - NVL(NVL(MAX(AT_ADM_CHAMADA),MAX(AT_ADM_IN�CIO)),SYSDATE))*24*60),0) AS TEMPO_3, -- ATENDIMENTO DA RECEP��O
        
        ROUND((((NVL(NVL(MAX(AT_M�DICO_CHAMADA), MAX(AT_M�DICO_IN�CIO)),SYSDATE) - NVL (MAX(AT_ADM_FINAL),SYSDATE))) * 24 * 60),0) AS TEMPO_4, -- AGUARDANDO CHAMADA DO MEDICO
        NVL (MAX(AT_M�DICO_CHAMADA),MAX(AT_M�DICO_IN�CIO)) AS AT_M�DICO_CHAMADA,
        MAX(AT_M�DICO_IN�CIO) AS AT_M�DICO_IN�CIO,
        MAX(AT_M�DICO_FINAL) AS AT_M�DICO_FINAL,
        MAX(AT_M�DICO_ALTA) AS AT_M�DICO_ALTA,
        --ROUND((((SYSDATE - NVL(MAX(AT_M�DICO_IN�CIO),SYSDATE)))*24*60),0) AS TEMPO_5 -- EM ATENDIMENTO MEDICO
        ROUND((((NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
                            FROM 
                                DBAMV.PW_DOCUMENTO_CLINICO PDC, 
                                DBAMV.PW_EDITOR_CLINICO PEC,
                                DBAMV.PRESTADOR PRD, 
                                DBAMV.CONSELHO COS
                            WHERE PEC.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
                                AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
                                AND PRD.CD_CONSELHO = COS.CD_CONSELHO
                                AND COS.TP_CONSELHO = 1 --CRM
                                AND PEC.CD_DOCUMENTO IN (730,566,1130,1131,1298) --DOCUMENTOS DE EVOLU��O MEDICA
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                AND PDC.DH_CRIACAO >= TRUNC(SYSDATE)-1
                                ), SYSDATE) - NVL(MAX(AT_M�DICO_IN�CIO),SYSDATE)))*24*60),0) AS TEMPO_5, -- EM ATENDIMENTO MEDICO
                                                            
        CASE WHEN MAX(AT_M�DICO_IN�CIO) IS NULL THEN NULL                       
        WHEN MAX(AT_M�DICO_IN�CIO) IS NOT NULL AND 
        ( SELECT MAX(PDC.DH_FECHAMENTO) 
                            FROM 
                                DBAMV.PW_DOCUMENTO_CLINICO PDC, 
                                DBAMV.PW_EDITOR_CLINICO PE,
                                DBAMV.PRESTADOR PRD, 
                                DBAMV.CONSELHO COS
                            WHERE PDC.CD_DOCUMENTO_CLINICO = PE.CD_DOCUMENTO_CLINICO
                                AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
                                AND PRD.CD_CONSELHO = COS.CD_CONSELHO
                                AND COS.TP_CONSELHO = 1 --CRM
                                AND PE.CD_DOCUMENTO IN (730,566,1130,1131,1298) --DOCUMENTOS DE EVOLU��O MEDICA
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                AND PDC.DH_CRIACAO >= TRUNC(SYSDATE)-1
                                AND PDC.DH_FECHAMENTO < (SELECT MIN(PD.DH_CRIACAO) 
                                                        FROM 
                                                            DBAMV.PW_DOCUMENTO_CLINICO PD, 
                                                            DBAMV.PW_EDITOR_CLINICO PE,
                                                            DBAMV.PRESTADOR PR, 
                                                            DBAMV.CONSELHO CO
                                                        WHERE PD.CD_DOCUMENTO_CLINICO = PE.CD_DOCUMENTO_CLINICO
                                                            AND PD.CD_PRESTADOR = PR.CD_PRESTADOR
                                                            AND PR.CD_CONSELHO = CO.CD_CONSELHO
                                                            AND CO.TP_CONSELHO <> 1 --CRM
                                                            AND PD.DH_CRIACAO >= TRUNC(SYSDATE)-1
                                                            AND PD.CD_ATENDIMENTO = PDC.CD_ATENDIMENTO
                                                            ) 
                                                            ) IS NULL THEN 'N' ELSE 'S' END SN_ATENDIMENTO_MED,
       
       (SELECT PAR_SN_PENDENTE FROM PW_LISTA_REAV_URGENCIA_RHP WHERE PAR_CD_ATENDIMENTO = ATENDIMENTO) AS SN_REAVALIA_MED,
       
       (SELECT MAX(PDC.DH_FECHAMENTO) 
          FROM DBAMV.PW_DOCUMENTO_CLINICO PDC
          WHERE PDC.CD_OBJETO = 412
          AND PDC.CD_ATENDIMENTO = ATENDIMENTO) DH_START_REAVALIA,
        
        (SELECT MAX(PDC.DH_FECHAMENTO) 
          FROM 
              DBAMV.PW_DOCUMENTO_CLINICO PDC, 
              DBAMV.PW_EDITOR_CLINICO PEC,
              DBAMV.PRESTADOR PRD, 
              DBAMV.CONSELHO COS
          WHERE PEC.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
              AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
              AND PRD.CD_CONSELHO = COS.CD_CONSELHO
              AND COS.TP_CONSELHO = 1 --CRM
              AND PEC.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZA��O
              AND PDC.CD_ATENDIMENTO = ATENDIMENTO
          ) DH_REAVALIA_MED, -- FINAL DE REAVALIA��O MEDICA
          
          
        ROUND(((NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
                        FROM 
                            DBAMV.PW_DOCUMENTO_CLINICO PDC, 
                            DBAMV.PW_EDITOR_CLINICO PEC,
                            DBAMV.PRESTADOR PRD, 
                            DBAMV.CONSELHO COS
                        WHERE PEC.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
                            AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
                            AND PRD.CD_CONSELHO = COS.CD_CONSELHO
                            AND COS.TP_CONSELHO = 1 --CRM
                            AND PEC.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZA��O
                            AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                        ),SYSDATE)-NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
                                      FROM DBAMV.PW_DOCUMENTO_CLINICO PDC
                                      WHERE PDC.CD_OBJETO = 412
                                      AND PDC.CD_ATENDIMENTO = ATENDIMENTO),MAX(AT_M�DICO_FINAL)))*24*60),0) AS TEMPO_9                                                 
        
FROM (
            SELECT 
                STTP.DS_TIPO_TEMPO_PROCESSO,
                STP.DH_PROCESSO,
                tma.DS_SENHA,
                ATE.CD_ATENDIMENTO,
                ATE.CD_ATENDIMENTO ATENDIMENTO,
                ATE.DT_ATENDIMENTO,
                ATE.DT_ALTA_MEDICA,
                TMA.NM_PACIENTE,
                CON.NM_CONVENIO,
                TMA.CD_FILA_SENHA,
                OA.CD_ORI_ATE,
                OA.DS_ORI_ATE
                
            FROM 
                SACR_TEMPO_PROCESSO STP,
                SACR_TIPO_TEMPO_PROCESSO STTP,
                SACR_CATEGORIA_PROCESSO SCP,
                DBAMV.ATENDIME ATE,
                DBAMV.TRIAGEM_ATENDIMENTO TMA,
                DBAMV.ORI_ATE OA,
                DBAMV.CONVENIO CON
            --LIGA��ES
            WHERE STP.CD_TIPO_TEMPO_PROCESSO (+) = STTP.CD_TIPO_TEMPO_PROCESSO
            AND STTP.cd_categoria_processo = SCP.cd_categoria_processo (+)
            AND STP.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO(+)
            AND TMA.CD_TRIAGEM_ATENDIMENTO(+) = STP.CD_TRIAGEM_ATENDIMENTO
            AND OA.CD_ORI_ATE(+) = ATE.CD_ORI_ATE
            AND ATE.CD_CONVENIO = CON.CD_CONVENIO(+)

            --FILTROS
            AND DH_PROCESSO >= TRUNC(SYSDATE)
            and dh_processo < TRUNC(SYSDATE+1)
            AND   (TMA.CD_FILA_SENHA      IN (19,29,182,244,246,248,161,196,210,220,221,222,245,247,335,136,17,99,100,168,97,162,175,98,198,22,60,61,170,172,178)--UNIDADES AGAMENOM
                OR TMA.CD_FILA_SENHA   IN (25,26,27,43,44,45,53,/*54,55,56,57,*/58,/*59,*/164,165,171,174,/*228,229,*/230,/*233,234,235,*/278,332,343,345,346)) --UNIDADES BV)
                --order by cd_atendimento, dh_processo desc 
    ) 
        PIVOT (
            MAX(DH_PROCESSO) 
            FOR DS_TIPO_TEMPO_PROCESSO IN(
                'CADASTRO NO TOTEM' AS TOTEM, 
                'REMOVIDO DA LISTA' AS CLASS_RETIRA_SENHA,
                'CLASSIFICA��O CHAMADA' AS CLASS_CHAMADA, 
                'CLASSIFICA��O IN�CIO' AS CLASS_IN�CIO, 
                'CLASSIFICA��O FINAL' AS CLASS_FINAL, 
                'ATENDIMENTO ADMINISTRATIVO CHAMADA' AS AT_ADM_CHAMADA, 
                'ATENDIMENTO ADMINISTRATIVO IN�CIO' AS AT_ADM_IN�CIO, 
                'ATENDIMENTO ADMINISTRATIVO FINAL' AS AT_ADM_FINAL, 
                'ATENDIMENTO M�DICO CHAMADA' AS AT_M�DICO_CHAMADA, 
                'ATENDIMENTO M�DICO IN�CIO' AS AT_M�DICO_IN�CIO,
                'ATENDIMENTO M�DICO FINAL' AS AT_M�DICO_FINAL,
                'ATENDIMENTO M�DICO ALTA' AS AT_M�DICO_ALTA 
                
            )
        )
        
        GROUP BY 
        CD_ATENDIMENTO,
        DT_ATENDIMENTO,
        DT_ALTA_MEDICA,
        NM_PACIENTE,
        CD_FILA_SENHA,
        DS_SENHA,
        CD_ORI_ATE,
        DS_ORI_ATE,
        NM_CONVENIO
        
    ORDER BY CD_ATENDIMENTO DESC
)B
WHERE A.CD_ATENDIMENTO = B.CD_ATENDIMENTO(+)
AND (A.DT_ALTA_MEDICA IS NULL AND B.DT_ALTA_MEDICA IS NULL)
--AND A.DS_SENHA = 'SD0023'
--AND A.SN_REAVALIA_MED = 'S'
--AND (A.CD_ORI_ATE in (2,4))
--AND (A.CD_ORI_ATE = 2 OR A.CD_ORI_ATE IS NULL)
--AND A.CD_FILA_SENHA NOT IN(246,220,175,230,182)
  AND A.CD_FILA_SENHA NOT IN(60)
--AND A.CD_ATENDIMENTO in (4706652,4706618,4706610,4706756)
--AND OA.CD_ORI_ATE IN (2,4,5,22) -- REAL VIDA = 02 || INFANTE EMERG = 04 || REAL MATER = 05 ||UABV EMERG = 22
--AND STP.CD_ATENDIMENTO in (4627381,4626784,4628097,4627069)--4627764 --4625679
--4638498 paciente evadiu dia 21/05 dando entrada dia 20/05 
ORDER BY NM_PACIENTE, 6 DESC, TOTEM DESC
