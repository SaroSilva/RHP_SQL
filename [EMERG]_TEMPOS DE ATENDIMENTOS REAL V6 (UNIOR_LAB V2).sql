/*
CONDIÇÕES DE TEMPO DE ATENDIMENTO
TEMPO NO TOTEM = TOTEM <> BLANK() && CLASS_CHAMADA = BLANK()
TEMPO CLASSIFICACAO = CLASS_CHAMADA <> BLANK() && AT_ADM_CHAMADA = BLANK()
TEMPO DA RECEPÇÃO = AT_ADM_CHAMADA <> BLANK() && AT_ADM_FINAL = BLANK()
TEMPO AGUARDANDO CHAMADA DO MEDICO = AT_ADM_FINAL <> BLANK() && AT_MÉDICO_CHAMADA = BLANK()
TEMPO EM ATENDIMENTO MÉDICO = AT_MÉDICO_CHAMADA <> BLANK() && AT_MÉDICO_ALTA = BLANK()
*/
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
, NVL (A.CLASS_INÍCIO,B.CLASS_INÍCIO) AS CLASS_INÍCIO
, NVL (A.CLASS_FINAL,B.CLASS_FINAL) AS CLASS_FINAL
, CASE WHEN (A.TEMPO_1 = 0 OR A.TEMPO_1 IS NULL) THEN B.TEMPO_1 ELSE A.TEMPO_1 END AS TEMPO_1
, CASE WHEN (A.TEMPO_2 = 0 OR A.TEMPO_2 IS NULL) THEN B.TEMPO_2 ELSE A.TEMPO_2 END AS TEMPO_2
, NVL (A.AT_ADM_CHAMADA,B.AT_ADM_CHAMADA) AS AT_ADM_CHAMADA
, NVL (A.AT_ADM_INÍCIO,B.AT_ADM_INÍCIO) AS AT_ADM_INÍCIO
, NVL (A.AT_ADM_FINAL,B.AT_ADM_FINAL) AS AT_ADM_FINAL
, CASE WHEN (A.TEMPO_3 = 0 OR A.TEMPO_3 IS NULL) THEN B.TEMPO_3 ELSE A.TEMPO_3 END AS TEMPO_3
, CASE WHEN (A.TEMPO_4 <= 0 OR A.TEMPO_4 IS NULL) THEN B.TEMPO_4 ELSE A.TEMPO_4 END AS TEMPO_4
, NVL (B.AT_MÉDICO_CHAMADA,A.AT_MÉDICO_CHAMADA) AS AT_MÉDICO_CHAMADA
, NVL (B.AT_MÉDICO_INÍCIO,A.AT_MÉDICO_INÍCIO) AS AT_MÉDICO_INÍCIO
, NVL (B.AT_MÉDICO_FINAL,A.AT_MÉDICO_FINAL) AS AT_MÉDICO_FINAL
, NVL (B.AT_MÉDICO_ALTA,A.AT_MÉDICO_ALTA) AS AT_MÉDICO_ALTA
, CASE WHEN (A.TEMPO_5 <= 0 OR A.TEMPO_5 IS NULL) THEN B.TEMPO_5 ELSE A.TEMPO_5 END AS TEMPO_5
, A.SN_ATENDIMENTO_MED
, NVL (A.DH_DISPENSACAO_FARM,B.DH_DISPENSACAO_FARM) AS DH_DISPENSACAO_FARM
, NVL (A.DH_CHECAGEM,B.DH_CHECAGEM) AS DH_CHECAGEM
, CASE WHEN (A.TEMPO_6 <= 0 OR A.TEMPO_6 IS NULL) THEN B.TEMPO_6 ELSE A.TEMPO_6 END AS TEMPO_6
, NVL (A.HR_PED_LAB,B.HR_PED_LAB) AS HR_PED_LAB
, NVL (A.HR_COLETA_LAB,B.HR_COLETA_LAB) AS HR_COLETA_LAB
, CASE WHEN (A.TEMPO_7 <= 0 OR A.TEMPO_7 IS NULL) THEN B.TEMPO_7 ELSE A.TEMPO_7 END AS TEMPO_7
, A.SN_REAVALIA_MED
, CASE WHEN (A.TEMPO_9 <= 0 OR A.TEMPO_9 IS NULL) THEN B.TEMPO_9 ELSE A.TEMPO_9 END AS TEMPO_9


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
        WHEN CD_FILA_SENHA = 182 THEN 'Real Vida - CONVOCAÇÃO DE TRANSPLANTE'
        WHEN CD_FILA_SENHA = 244 THEN 'Real Vida - PACIENTE COM DEFICIÊNCIA'
        WHEN CD_FILA_SENHA = 246 THEN 'Real Vida - PACIENTE AVC' 
        WHEN CD_FILA_SENHA = 248 THEN 'Real Vida - SUPER IDOSO 80+'
        WHEN CD_FILA_SENHA = 161 THEN 'Real Vida - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 196 THEN 'Real Vida - NEUROLOGIA'
        WHEN CD_FILA_SENHA = 210 THEN 'Real Vida - PACIENTE EM CURSO DE QT/RT'
        WHEN CD_FILA_SENHA = 220 THEN 'Real Vida - SÍNDROME GRIPAL' 
        WHEN CD_FILA_SENHA = 221 THEN 'Real Vida - ORTOPEDIA'
        WHEN CD_FILA_SENHA = 222 THEN 'Real Vida - OTORRINOLARINGOLOGIA'
        WHEN CD_FILA_SENHA = 245 THEN 'Real Vida - PACIENTE GESTANTE'
        WHEN CD_FILA_SENHA = 247 THEN 'Real Vida - PACIENTE DOR TORÁCIC'
        WHEN CD_FILA_SENHA = 335 THEN 'Real Vida - TEA'
        WHEN CD_FILA_SENHA = 136 THEN 'Real Vida - CARDIOLOGIA'
        WHEN CD_FILA_SENHA = 17  THEN 'Infante - ATENDIMENTO'
        WHEN CD_FILA_SENHA = 99  THEN 'Infante - PREFERENCIAL- PESSOA COM DEFICIÊNCIA'
        WHEN CD_FILA_SENHA = 100 THEN 'Infante - PREFERENCIAL - GENITORA GRÁVIDA'
        WHEN CD_FILA_SENHA = 168 THEN 'Infante - VIAGEM RECENTE PARA CHINA'
        WHEN CD_FILA_SENHA = 97  THEN 'Infante - PREFERENCIAL - PACIENTE ONCOPEDIATRIA'
        WHEN CD_FILA_SENHA = 162 THEN 'Infante - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 175 THEN 'Infante - SÍNDROME GRIPAL' 
        WHEN CD_FILA_SENHA = 98  THEN 'Infante - PREFERENCIAL - RECÉM NASCIDO'
        WHEN CD_FILA_SENHA = 198 THEN 'Infante - VIAGEM RECENTE PARA REGIÃO NORTE BR'
        WHEN CD_FILA_SENHA = 22 THEN 'RM - ATENDIMENTO URGÊNCIA /GESTANTE'
        WHEN CD_FILA_SENHA = 60 THEN 'RM - INTERNAMENTO'
        WHEN CD_FILA_SENHA = 61 THEN 'RM - ATENDIMENTO URGÊNCIA /GINECOLÓGICO'
        WHEN CD_FILA_SENHA = 170 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 172 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 178 THEN 'RM - FEBRE E SINTOMAS RESPIRATÓRIOS'
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
        WHEN CD_FILA_SENHA = 174 THEN 'BV - FEBRE E SINTOMAS RESPIRATÓRIOS'
        WHEN CD_FILA_SENHA = 228 THEN 'BV - RESSONÂNCIA / TOMOGRAFIA' 
        WHEN CD_FILA_SENHA = 229 THEN 'BV - RAIO X / USG / MAMOGRAFIA'
        WHEN CD_FILA_SENHA = 230 THEN 'BV - SÍNDROME GRIPAL'
        WHEN CD_FILA_SENHA = 233 THEN 'BV - EXAMES AGENDADOS REAL IMAGEM'
        WHEN CD_FILA_SENHA = 234 THEN 'BV - MARCAÇÃO DE EXAMES REAL IMAGEM'
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
        NVL (MAX(CLASS_CHAMADA),MAX(CLASS_INÍCIO)) AS CLASS_CHAMADA,
        MAX(CLASS_INÍCIO) AS CLASS_INÍCIO,
        MAX(CLASS_FINAL) AS CLASS_FINAL,
        ROUND(((nvl(MAX(CLASS_FINAL),sysdate) - MAX (TOTEM))*24 *60),0) AS TEMPO_1, --SENHA ATÉ O FIM DA CLASSIFICAÇÃO
        
        ROUND(((NVL(NVL (MAX(AT_ADM_CHAMADA), MAX(AT_ADM_INÍCIO)), SYSDATE)- NVL(MAX(CLASS_FINAL),SYSDATE)) * 24 * 60),0) AS TEMPO_2, --AGUARDANDO RECEPÇÃO CHAMAR
        
        NVL (MAX(AT_ADM_CHAMADA),MAX(AT_ADM_INÍCIO)) AS AT_ADM_CHAMADA,
        MAX(AT_ADM_INÍCIO) AS AT_ADM_INÍCIO,
        MAX(AT_ADM_FINAL) AS AT_ADM_FINAL,
        ROUND(((NVL(MAX(AT_ADM_FINAL),SYSDATE) - NVL(NVL(MAX(AT_ADM_CHAMADA),MAX(AT_ADM_INÍCIO)),SYSDATE))*24*60),0) AS TEMPO_3, -- ATENDIMENTO DA RECEPÇÃO
        
        ROUND((((NVL(NVL(MAX(AT_MÉDICO_CHAMADA), MAX(AT_MÉDICO_INÍCIO)),SYSDATE) - NVL (MAX(AT_ADM_FINAL),SYSDATE))) * 24 * 60),0) AS TEMPO_4, -- AGUARDANDO CHAMADA DO MEDICO
        NVL (MAX(AT_MÉDICO_CHAMADA),MAX(AT_MÉDICO_INÍCIO)) AS AT_MÉDICO_CHAMADA,
        MAX(AT_MÉDICO_INÍCIO) AS AT_MÉDICO_INÍCIO,
        MAX(AT_MÉDICO_FINAL) AS AT_MÉDICO_FINAL,
        MAX(AT_MÉDICO_ALTA) AS AT_MÉDICO_ALTA,
        --ROUND((((SYSDATE - NVL(MAX(AT_MÉDICO_INÍCIO),SYSDATE)))*24*60),0) AS TEMPO_5 -- EM ATENDIMENTO MEDICO
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
                                AND PEC.CD_DOCUMENTO IN (730,566,1130,1131,1298) --DOCUMENTOS DE EVOLUÇÃO MEDICA
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                ), SYSDATE) - NVL(MAX(AT_MÉDICO_INÍCIO),SYSDATE)))*24*60),0) AS TEMPO_5, -- EM ATENDIMENTO MEDICO
                                                            
        CASE WHEN MAX(AT_MÉDICO_INÍCIO) IS NULL THEN NULL                       
        WHEN MAX(AT_MÉDICO_INÍCIO) IS NOT NULL AND 
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
                                AND PE.CD_DOCUMENTO IN (730,566,1130,1131,1298) --DOCUMENTOS DE EVOLUÇÃO MEDICA
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
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
                                                            ) 
                                                            ) IS NULL THEN 'N' ELSE 'S' END SN_ATENDIMENTO_MED,
        MAX(DH_DISPENSACAO_FARM) AS DH_DISPENSACAO_FARM,
        MAX(DH_CHECAGEM)AS DH_CHECAGEM,
        ROUND(((nvl(MAX(DH_CHECAGEM),sysdate) - MAX(DH_DISPENSACAO_FARM))*24 *60),0) AS TEMPO_6,
        HR_PED_LAB,
        HR_COLETA_LAB,
        CASE WHEN HR_PED_LAB IS NOT NULL THEN ROUND(((NVL(MAX(HR_COLETA_LAB),sysdate) - MAX (HR_PED_LAB))*24 *60),0) END AS TEMPO_7,
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
                                AND PEC.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZAÇÃO
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                ), SYSDATE) - NVL(MAX(AT_MÉDICO_INÍCIO),SYSDATE)))*24*60),0) AS TEMPO_9,                                                  
        CASE 
            WHEN MAX(AT_MÉDICO_INÍCIO) IS NULL THEN NULL                       
            WHEN MAX(AT_MÉDICO_INÍCIO) IS NOT NULL AND                                                 
        (SELECT MAX(PDC.DH_FECHAMENTO) 
                    FROM 
                        DBAMV.PW_DOCUMENTO_CLINICO PDC, 
                        DBAMV.PW_EDITOR_CLINICO PE,
                        DBAMV.PRESTADOR PRD, 
                        DBAMV.CONSELHO COS
                    WHERE PDC.CD_DOCUMENTO_CLINICO = PE.CD_DOCUMENTO_CLINICO
                        AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
                        AND PRD.CD_CONSELHO = COS.CD_CONSELHO
                        AND COS.TP_CONSELHO = 1 --CRM
                        AND PE.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZAÇÃO
                        AND PDC.CD_ATENDIMENTO = ATENDIMENTO
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
                                                    ) 
                                                    ) IS NULL THEN 'N' ELSE 'S' END SN_REAVALIA_MED

FROM (
            SELECT 
                STTP.DS_TIPO_TEMPO_PROCESSO,
                NVL(SCP.CD_CATEGORIA_PROCESSO,'0')CD_CATEGORIA_PROCESSO,
                NVL(SCP.ds_categoria_processo,'ALTA MÉDICA')ds_categoria_processo,
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
                OA.DS_ORI_ATE,
                TMP_MED.DH_DISPENSACAO_FARM,
                TMP_MED.DH_CHECAGEM,
                LAB.HR_PED_LAB,
                LAB.HR_COLETA_LAB
                
            FROM 
                SACR_TEMPO_PROCESSO STP,
                SACR_TIPO_TEMPO_PROCESSO STTP,
                SACR_CATEGORIA_PROCESSO SCP,
                DBAMV.ATENDIME ATE,
                DBAMV.TRIAGEM_ATENDIMENTO TMA,
                DBAMV.ORI_ATE OA,
                DBAMV.CONVENIO CON,
                        (SELECT * FROM
            (SELECT * FROM
                (SELECT
                    ATE.CD_ATENDIMENTO,
                    PAC.NM_PACIENTE,
                    ATE.CD_ORI_ATE,
                    ATE.CD_CONVENIO,
                    ATE.DT_ATENDIMENTO,
                    MAX(PMD.CD_PRE_MED) AS CD_PRE_MED,
                    MAX(PMD.HR_PRE_MED) AS HR_PRE_MED,
                    MAX(SSP.CD_SOLSAI_PRO) AS CD_SOLSAI_PRO,
                    MAX(SSP.HR_SOLSAI_PRO) AS HR_SOLSAI_PRO,
                    --SSP.TP_SITUACAO,
                    MAX(MES.HR_MVTO_ESTOQUE) AS DH_DISPENSACAO_FARM,
                    MAX(HIPC.DH_CHECAGEM) AS DH_CHECAGEM,
                    (
                        RANK() OVER (
                            PARTITION BY ATE.CD_ATENDIMENTO
                            ORDER BY
                                PMD.CD_PRE_MED DESC,
                                MES.HR_MVTO_ESTOQUE DESC
                        )
                    ) AS NR_ORD
                FROM
                    DBAMV.ATENDIME ATE,
                    DBAMV.PRE_MED PMD,
                    DBAMV.ITPRE_MED IPM,
                    DBAMV.SOLSAI_PRO SSP,
                    DBAMV.ITSOLSAI_PRO ISSP,
                    DBAMV.MVTO_ESTOQUE MES,
                    DBAMV.HRITPRE_CONS HIPC,
                    DBAMV.ITMVTO_ESTOQUE IME,
                    DBAMV.PACIENTE PAC
                    /*RELACIONAMENTO*/
                WHERE
                    PMD.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO
                    AND SSP.CD_PRE_MED = PMD.CD_PRE_MED
                    AND PMD.CD_PRE_MED = IPM.CD_PRE_MED
                    AND SSP.CD_SOLSAI_PRO = ISSP.CD_SOLSAI_PRO(+)
                    AND SSP.CD_SOLSAI_PRO = MES.CD_SOLSAI_PRO(+)
                    AND IPM.CD_ITPRE_MED = HIPC.CD_ITPRE_MED(+) --AND IPM.CD_ITPRE_MED = IME.CD_ITPRE_MED
                    AND IME.CD_ITSOLSAI_PRO(+) = ISSP.CD_ITSOLSAI_PRO
                    AND PAC.CD_PACIENTE = ATE.CD_PACIENTE
                    /*FILTROS*/
                    AND ATE.DT_ALTA IS NULL
                    AND ATE.DT_ATENDIMENTO >= TRUNC (SYSDATE)
                    AND ATE.TP_ATENDIMENTO = 'U' --AND ATE.CD_ORI_ATE = 2
                GROUP BY
                    ATE.CD_ATENDIMENTO,
                    ATE.CD_ORI_ATE,
                    ATE.CD_CONVENIO,
                    ATE.DT_ATENDIMENTO,
                    PMD.CD_PRE_MED,
                    PMD.HR_PRE_MED,
                    SSP.CD_SOLSAI_PRO,
                    SSP.HR_SOLSAI_PRO,
                    SSP.TP_SITUACAO,
                    PAC.NM_PACIENTE,
                    MES.HR_MVTO_ESTOQUE
                ORDER BY
                    DH_CHECAGEM DESC,
                    1
            ) BASE
        WHERE
            NR_ORD = 1
    ) )TMP_MED
    ,(SELECT * FROM
        (SELECT '1.LABORATORIO' TIPO,
            A.CD_ATENDIMENTO,
            PAC.NM_PACIENTE PACIENTE,
            C.NM_CONVENIO CONVENIO,
            TMA.CD_FILA_SENHA,
            --P.HR_PED_LAB,
            round((sysdate- min(DBAMV.FNC_MV_RECUPERA_DATA_HORA(p.DT_PEDIDO, p.HR_PED_LAB)))*24*60,2) TMP_LAB,
            --PMD.DH_IMPRESSAO AS HR_PED_LAB,
            min(DBAMV.FNC_MV_RECUPERA_DATA_HORA(p.DT_PEDIDO, p.HR_PED_LAB)) AS HR_PED_LAB,
           (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
              WHERE lme.DT_MOVIMENTO >= TRUNC(SYSDATE)
              AND lme.DT_MOVIMENTO < TRUNC(sysdaTE)+1
              AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
              AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%') AS HR_COLETA_LAB
            --HR_COLETA || DT_COLETA
        FROM DBAMV.ATENDIME A,
            DBAMV.PED_LAB P,
            DBAMV.ITPED_LAB IPL,
            DBAMV.EXA_LAB EXA,
            DBAMV.CONVENIO C,
            DBAMV.PACIENTE PAC,
            
            DBAMV.SACR_TEMPO_PROCESSO STP, --ADICIONADO POR 26753 EM 29/05/2024
            DBAMV.TRIAGEM_ATENDIMENTO TMA --ADICIONADO POR 26753 EM 29/05/2024
            
        WHERE A.CD_ATENDIMENTO = P.CD_ATENDIMENTO
        AND P.CD_PED_LAB = IPL.CD_PED_LAB
        AND IPL.CD_EXA_LAB = EXA.CD_EXA_LAB
        AND A.CD_CONVENIO = C.CD_CONVENIO
        AND A.CD_PACIENTE = PAC.CD_PACIENTE

        AND   A.CD_ATENDIMENTO = STP.CD_ATENDIMENTO(+) --ADICIONADO POR 26753 EM 29/05/2024
        AND   STP.CD_TRIAGEM_ATENDIMENTO = TMA.CD_TRIAGEM_ATENDIMENTO(+) --ADICIONADO POR 26753 EM 29/05/2024

        AND   A.TP_ATENDIMENTO = 'U'
        AND   A.DT_ATENDIMENTO >= TRUNC(SYSDATE)
        AND   A.DT_ATENDIMENTO < TRUNC(sysdaTE)+1
        /*AND   NOT EXISTS
        (SELECT 1
        FROM DBAMV.LOG_MOVIMENTO_EXAME lme
        WHERE CD_ITPED_LAB_RX = IPL.CD_ITPED_LAB
        AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%')*/
        group by A.CD_ATENDIMENTO,PAC.NM_PACIENTE,C.NM_CONVENIO,TMA.CD_FILA_SENHA,p.HR_PED_LAB
) 
)LAB
            --LIGAÇÕES
            WHERE STP.CD_TIPO_TEMPO_PROCESSO (+) = STTP.CD_TIPO_TEMPO_PROCESSO
            AND STTP.cd_categoria_processo = SCP.cd_categoria_processo (+)
            AND STP.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO(+)
            AND TMA.CD_TRIAGEM_ATENDIMENTO(+) = STP.CD_TRIAGEM_ATENDIMENTO
            AND OA.CD_ORI_ATE(+) = ATE.CD_ORI_ATE
            AND ATE.CD_CONVENIO = CON.CD_CONVENIO(+)
            AND ATE.CD_ATENDIMENTO = TMP_MED.CD_ATENDIMENTO(+)
            AND ATE.CD_ATENDIMENTO = LAB.CD_ATENDIMENTO(+)
            --FILTROS
            AND DH_PROCESSO >= TRUNC(sysdate)
            and dh_processo < TRUNC(sysdaTE)+1
            AND   (TMA.CD_FILA_SENHA      IN (19,29,182,244,246,248,161,196,210,220,221,222,245,247,335,136,17,99,100,168,97,162,175,98,198,22,60,61,170,172,178)--UNIDADES AGAMENOM
                OR TMA.CD_FILA_SENHA   IN (25,26,27,43,44,45,53,/*54,55,56,57,*/58,/*59,*/164,165,171,174,/*228,229,*/230,/*233,234,235,*/278,332,343,345,346)) --UNIDADES BV)
                --order by cd_atendimento, dh_processo desc 
    ) 
        PIVOT (
            MAX(DH_PROCESSO) 
            FOR DS_TIPO_TEMPO_PROCESSO IN(
                'CADASTRO NO TOTEM' AS TOTEM, 
                'CLASSIFICAÇÃO CHAMADA' AS CLASS_CHAMADA, 
                'CLASSIFICAÇÃO INÍCIO' AS CLASS_INÍCIO, 
                'CLASSIFICAÇÃO FINAL' AS CLASS_FINAL, 
                'ATENDIMENTO ADMINISTRATIVO CHAMADA' AS AT_ADM_CHAMADA, 
                'ATENDIMENTO ADMINISTRATIVO INÍCIO' AS AT_ADM_INÍCIO, 
                'ATENDIMENTO ADMINISTRATIVO FINAL' AS AT_ADM_FINAL, 
                'ATENDIMENTO MÉDICO CHAMADA' AS AT_MÉDICO_CHAMADA, 
                'ATENDIMENTO MÉDICO INÍCIO' AS AT_MÉDICO_INÍCIO,
                'ATENDIMENTO MÉDICO FINAL' AS AT_MÉDICO_FINAL,
                'ATENDIMENTO MÉDICO ALTA' AS AT_MÉDICO_ALTA 
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
        DH_DISPENSACAO_FARM,
        NM_CONVENIO,
        DH_CHECAGEM,
        HR_PED_LAB,
        HR_COLETA_LAB
        
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
        WHEN CD_FILA_SENHA = 182 THEN 'Real Vida - CONVOCAÇÃO DE TRANSPLANTE'
        WHEN CD_FILA_SENHA = 244 THEN 'Real Vida - PACIENTE COM DEFICIÊNCIA'
        WHEN CD_FILA_SENHA = 246 THEN 'Real Vida - PACIENTE AVC' 
        WHEN CD_FILA_SENHA = 248 THEN 'Real Vida - SUPER IDOSO 80+'
        WHEN CD_FILA_SENHA = 161 THEN 'Real Vida - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 196 THEN 'Real Vida - NEUROLOGIA'
        WHEN CD_FILA_SENHA = 210 THEN 'Real Vida - PACIENTE EM CURSO DE QT/RT'
        WHEN CD_FILA_SENHA = 220 THEN 'Real Vida - SÍNDROME GRIPAL' 
        WHEN CD_FILA_SENHA = 221 THEN 'Real Vida - ORTOPEDIA'
        WHEN CD_FILA_SENHA = 222 THEN 'Real Vida - OTORRINOLARINGOLOGIA'
        WHEN CD_FILA_SENHA = 245 THEN 'Real Vida - PACIENTE GESTANTE'
        WHEN CD_FILA_SENHA = 247 THEN 'Real Vida - PACIENTE DOR TORÁCIC'
        WHEN CD_FILA_SENHA = 335 THEN 'Real Vida - TEA'
        WHEN CD_FILA_SENHA = 136 THEN 'Real Vida - CARDIOLOGIA'
        WHEN CD_FILA_SENHA = 17  THEN 'Infante - ATENDIMENTO'
        WHEN CD_FILA_SENHA = 99  THEN 'Infante - PREFERENCIAL- PESSOA COM DEFICIÊNCIA'
        WHEN CD_FILA_SENHA = 100 THEN 'Infante - PREFERENCIAL - GENITORA GRÁVIDA'
        WHEN CD_FILA_SENHA = 168 THEN 'Infante - VIAGEM RECENTE PARA CHINA'
        WHEN CD_FILA_SENHA = 97  THEN 'Infante - PREFERENCIAL - PACIENTE ONCOPEDIATRIA'
        WHEN CD_FILA_SENHA = 162 THEN 'Infante - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 175 THEN 'Infante - SÍNDROME GRIPAL' 
        WHEN CD_FILA_SENHA = 98  THEN 'Infante - PREFERENCIAL - RECÉM NASCIDO'
        WHEN CD_FILA_SENHA = 198 THEN 'Infante - VIAGEM RECENTE PARA REGIÃO NORTE BR'
        WHEN CD_FILA_SENHA = 22 THEN 'RM - ATENDIMENTO URGÊNCIA /GESTANTE'
        WHEN CD_FILA_SENHA = 60 THEN 'RM - INTERNAMENTO'
        WHEN CD_FILA_SENHA = 61 THEN 'RM - ATENDIMENTO URGÊNCIA /GINECOLÓGICO'
        WHEN CD_FILA_SENHA = 170 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 172 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
        WHEN CD_FILA_SENHA = 178 THEN 'RM - FEBRE E SINTOMAS RESPIRATÓRIOS'
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
        WHEN CD_FILA_SENHA = 174 THEN 'BV - FEBRE E SINTOMAS RESPIRATÓRIOS'
        WHEN CD_FILA_SENHA = 228 THEN 'BV - RESSONÂNCIA / TOMOGRAFIA' 
        WHEN CD_FILA_SENHA = 229 THEN 'BV - RAIO X / USG / MAMOGRAFIA'
        WHEN CD_FILA_SENHA = 230 THEN 'BV - SÍNDROME GRIPAL'
        WHEN CD_FILA_SENHA = 233 THEN 'BV - EXAMES AGENDADOS REAL IMAGEM'
        WHEN CD_FILA_SENHA = 234 THEN 'BV - MARCAÇÃO DE EXAMES REAL IMAGEM'
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
        NVL (MAX(CLASS_CHAMADA),MAX(CLASS_INÍCIO)) AS CLASS_CHAMADA,
        MAX(CLASS_INÍCIO) AS CLASS_INÍCIO,
        MAX(CLASS_FINAL) AS CLASS_FINAL,
        ROUND(((nvl(MAX(CLASS_FINAL),sysdate) - MAX (TOTEM))*24 *60),0) AS TEMPO_1, --SENHA ATÉ O FIM DA CLASSIFICAÇÃO
        
        ROUND(((NVL(NVL (MAX(AT_ADM_CHAMADA), MAX(AT_ADM_INÍCIO)), SYSDATE)- NVL(MAX(CLASS_FINAL),SYSDATE)) * 24 * 60),0) AS TEMPO_2, --AGUARDANDO RECEPÇÃO CHAMAR
        
        NVL (MAX(AT_ADM_CHAMADA),MAX(AT_ADM_INÍCIO)) AS AT_ADM_CHAMADA,
        MAX(AT_ADM_INÍCIO) AS AT_ADM_INÍCIO,
        MAX(AT_ADM_FINAL) AS AT_ADM_FINAL,
        ROUND(((NVL(MAX(AT_ADM_FINAL),SYSDATE) - NVL(NVL(MAX(AT_ADM_CHAMADA),MAX(AT_ADM_INÍCIO)),SYSDATE))*24*60),0) AS TEMPO_3, -- ATENDIMENTO DA RECEPÇÃO
        
        ROUND((((NVL(NVL(MAX(AT_MÉDICO_CHAMADA), MAX(AT_MÉDICO_INÍCIO)),SYSDATE) - NVL (MAX(AT_ADM_FINAL),SYSDATE))) * 24 * 60),0) AS TEMPO_4, -- AGUARDANDO CHAMADA DO MEDICO
        NVL (MAX(AT_MÉDICO_CHAMADA),MAX(AT_MÉDICO_INÍCIO)) AS AT_MÉDICO_CHAMADA,
        MAX(AT_MÉDICO_INÍCIO) AS AT_MÉDICO_INÍCIO,
        MAX(AT_MÉDICO_FINAL) AS AT_MÉDICO_FINAL,
        MAX(AT_MÉDICO_ALTA) AS AT_MÉDICO_ALTA,
        --ROUND((((SYSDATE - NVL(MAX(AT_MÉDICO_INÍCIO),SYSDATE)))*24*60),0) AS TEMPO_5 -- EM ATENDIMENTO MEDICO
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
                                AND PEC.CD_DOCUMENTO IN (730,566,1130,1131,1298) --DOCUMENTOS DE EVOLUÇÃO MEDICA
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                ), SYSDATE) - NVL(MAX(AT_MÉDICO_INÍCIO),SYSDATE)))*24*60),0) AS TEMPO_5, -- EM ATENDIMENTO MEDICO
                                                            
        CASE WHEN MAX(AT_MÉDICO_INÍCIO) IS NULL THEN NULL                       
        WHEN MAX(AT_MÉDICO_INÍCIO) IS NOT NULL AND 
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
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                AND PE.CD_DOCUMENTO IN (730,566,1130,1131,1298) --DOCUMENTOS DE EVOLUÇÃO MEDICA
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
                                                            ) 
                                                            ) IS NULL THEN 'N' ELSE 'S' END SN_ATENDIMENTO_MED,
        DH_DISPENSACAO_FARM,
        DH_CHECAGEM,
        ROUND(((nvl(MAX(DH_CHECAGEM),sysdate) - MAX (DH_DISPENSACAO_FARM))*24 *60),0) AS TEMPO_6,
        HR_PED_LAB,
        HR_COLETA_LAB,
        CASE WHEN HR_PED_LAB IS NOT NULL THEN ROUND(((NVL(MAX(HR_COLETA_LAB),sysdate) - MAX (HR_PED_LAB))*24 *60),0) END AS TEMPO_7,
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
                                AND PEC.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZAÇÃO
                                AND PDC.CD_ATENDIMENTO = ATENDIMENTO
                                ), SYSDATE) - NVL(MAX(AT_MÉDICO_INÍCIO),SYSDATE)))*24*60),0) AS TEMPO_9,                                                  
        CASE 
            WHEN MAX(AT_MÉDICO_INÍCIO) IS NULL THEN NULL                       
            WHEN MAX(AT_MÉDICO_INÍCIO) IS NOT NULL AND                                                 
        (SELECT MAX(PDC.DH_FECHAMENTO) 
                    FROM 
                        DBAMV.PW_DOCUMENTO_CLINICO PDC, 
                        DBAMV.PW_EDITOR_CLINICO PE,
                        DBAMV.PRESTADOR PRD, 
                        DBAMV.CONSELHO COS
                    WHERE PDC.CD_DOCUMENTO_CLINICO = PE.CD_DOCUMENTO_CLINICO
                        AND PDC.CD_PRESTADOR = PRD.CD_PRESTADOR
                        AND PRD.CD_CONSELHO = COS.CD_CONSELHO
                        AND COS.TP_CONSELHO = 1 --CRM
                        AND PE.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZAÇÃO 
                        AND PDC.CD_ATENDIMENTO = ATENDIMENTO
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
                                                    ) 
                                                    ) IS NULL THEN 'N' ELSE 'S' END SN_REAVALIA_MED

FROM (
            SELECT 
                STTP.DS_TIPO_TEMPO_PROCESSO,
                NVL(SCP.CD_CATEGORIA_PROCESSO,'0')CD_CATEGORIA_PROCESSO,
                NVL(SCP.ds_categoria_processo,'ALTA MÉDICA')ds_categoria_processo,
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
                OA.DS_ORI_ATE,
                TMP_MED.DH_DISPENSACAO_FARM,
                TMP_MED.DH_CHECAGEM,
                LAB.HR_PED_LAB,
                LAB.HR_COLETA_LAB
                
            FROM 
                SACR_TEMPO_PROCESSO STP,
                SACR_TIPO_TEMPO_PROCESSO STTP,
                SACR_CATEGORIA_PROCESSO SCP,
                DBAMV.ATENDIME ATE,
                DBAMV.TRIAGEM_ATENDIMENTO TMA,
                DBAMV.ORI_ATE OA,
                DBAMV.CONVENIO CON,
                        (SELECT * FROM
            (SELECT * FROM
                (SELECT
                    ATE.CD_ATENDIMENTO,
                    PAC.NM_PACIENTE,
                    ATE.CD_ORI_ATE,
                    ATE.CD_CONVENIO,
                    ATE.DT_ATENDIMENTO,
                    PMD.CD_PRE_MED,
                    PMD.HR_PRE_MED,
                    SSP.CD_SOLSAI_PRO,
                    SSP.HR_SOLSAI_PRO,
                    SSP.TP_SITUACAO,
                    MAX(MES.HR_MVTO_ESTOQUE) AS DH_DISPENSACAO_FARM,
                    MAX(HIPC.DH_CHECAGEM) AS DH_CHECAGEM,
                    (
                        RANK() OVER (
                            PARTITION BY ATE.CD_ATENDIMENTO
                            ORDER BY
                                PMD.CD_PRE_MED DESC,
                                MES.HR_MVTO_ESTOQUE DESC
                        )
                    ) AS NR_ORD
                FROM
                    DBAMV.ATENDIME ATE,
                    DBAMV.PRE_MED PMD,
                    DBAMV.ITPRE_MED IPM,
                    DBAMV.SOLSAI_PRO SSP,
                    DBAMV.ITSOLSAI_PRO ISSP,
                    DBAMV.MVTO_ESTOQUE MES,
                    DBAMV.HRITPRE_CONS HIPC,
                    DBAMV.ITMVTO_ESTOQUE IME,
                    DBAMV.PACIENTE PAC
                    /*RELACIONAMENTO*/
                WHERE
                    PMD.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO
                    AND SSP.CD_PRE_MED = PMD.CD_PRE_MED
                    AND PMD.CD_PRE_MED = IPM.CD_PRE_MED
                    AND SSP.CD_SOLSAI_PRO = ISSP.CD_SOLSAI_PRO(+)
                    AND SSP.CD_SOLSAI_PRO = MES.CD_SOLSAI_PRO(+)
                    AND IPM.CD_ITPRE_MED = HIPC.CD_ITPRE_MED(+) --AND IPM.CD_ITPRE_MED = IME.CD_ITPRE_MED
                    AND IME.CD_ITSOLSAI_PRO(+) = ISSP.CD_ITSOLSAI_PRO
                    AND PAC.CD_PACIENTE = ATE.CD_PACIENTE
                    /*FILTROS*/
                    AND ATE.DT_ALTA IS NULL
                    AND ATE.DT_ATENDIMENTO >= TRUNC (SYSDATE)
                    AND ATE.TP_ATENDIMENTO = 'U' --AND ATE.CD_ORI_ATE = 2
                GROUP BY
                    ATE.CD_ATENDIMENTO,
                    ATE.CD_ORI_ATE,
                    ATE.CD_CONVENIO,
                    ATE.DT_ATENDIMENTO,
                    PMD.CD_PRE_MED,
                    PMD.HR_PRE_MED,
                    SSP.CD_SOLSAI_PRO,
                    SSP.HR_SOLSAI_PRO,
                    SSP.TP_SITUACAO,
                    PAC.NM_PACIENTE,
                    MES.HR_MVTO_ESTOQUE
                ORDER BY
                    DH_CHECAGEM DESC,
                    1
            ) BASE
        WHERE NR_ORD = 1
    ) )TMP_MED
    ,(SELECT * FROM
        (SELECT '1.LABORATORIO' TIPO,
            A.CD_ATENDIMENTO,
            PAC.NM_PACIENTE PACIENTE,
            C.NM_CONVENIO CONVENIO,
            TMA.CD_FILA_SENHA,
            --P.HR_PED_LAB,
            round((sysdate- min(DBAMV.FNC_MV_RECUPERA_DATA_HORA(p.DT_PEDIDO, p.HR_PED_LAB)))*24*60,2) TMP_LAB,
            --PMD.DH_IMPRESSAO AS HR_PED_LAB,
            min(DBAMV.FNC_MV_RECUPERA_DATA_HORA(p.DT_PEDIDO, p.HR_PED_LAB)) AS HR_PED_LAB,
           (SELECT MAX(DT_MOVIMENTO) AS DT_MOVIMENTO FROM DBAMV.LOG_MOVIMENTO_EXAME lme
              WHERE lme.DT_MOVIMENTO >= TRUNC(SYSDATE)
              AND lme.DT_MOVIMENTO < TRUNC(sysdaTE)+1
              AND CD_ATENDIMENTO = A.CD_ATENDIMENTO
              AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%') AS HR_COLETA_LAB
            --HR_COLETA || DT_COLETA
        FROM DBAMV.ATENDIME A,
            DBAMV.PED_LAB P,
            DBAMV.ITPED_LAB IPL,
            DBAMV.EXA_LAB EXA,
            DBAMV.CONVENIO C,
            DBAMV.PACIENTE PAC,
            
            DBAMV.SACR_TEMPO_PROCESSO STP, --ADICIONADO POR 26753 EM 29/05/2024
            DBAMV.TRIAGEM_ATENDIMENTO TMA --ADICIONADO POR 26753 EM 29/05/2024
            
        WHERE A.CD_ATENDIMENTO = P.CD_ATENDIMENTO
        AND P.CD_PED_LAB = IPL.CD_PED_LAB
        AND IPL.CD_EXA_LAB = EXA.CD_EXA_LAB
        AND A.CD_CONVENIO = C.CD_CONVENIO
        AND A.CD_PACIENTE = PAC.CD_PACIENTE

        AND   A.CD_ATENDIMENTO = STP.CD_ATENDIMENTO(+) --ADICIONADO POR 26753 EM 29/05/2024
        AND   STP.CD_TRIAGEM_ATENDIMENTO = TMA.CD_TRIAGEM_ATENDIMENTO(+) --ADICIONADO POR 26753 EM 29/05/2024

        AND   A.TP_ATENDIMENTO = 'U'
        AND   A.DT_ATENDIMENTO >= TRUNC(SYSDATE)
        AND   A.DT_ATENDIMENTO < TRUNC(sysdaTE)+1
        /*AND   NOT EXISTS
        (SELECT 1
        FROM DBAMV.LOG_MOVIMENTO_EXAME lme
        WHERE CD_ITPED_LAB_RX = IPL.CD_ITPED_LAB
        AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%')*/
        group by A.CD_ATENDIMENTO,PAC.NM_PACIENTE,C.NM_CONVENIO,TMA.CD_FILA_SENHA,p.HR_PED_LAB
)
)LAB
            --LIGAÇÕES
            WHERE STP.CD_TIPO_TEMPO_PROCESSO (+) = STTP.CD_TIPO_TEMPO_PROCESSO
            AND STTP.cd_categoria_processo = SCP.cd_categoria_processo (+)
            AND STP.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO(+)
            AND TMA.CD_TRIAGEM_ATENDIMENTO(+) = STP.CD_TRIAGEM_ATENDIMENTO
            AND OA.CD_ORI_ATE(+) = ATE.CD_ORI_ATE
            AND ATE.CD_CONVENIO = CON.CD_CONVENIO(+)
            AND ATE.CD_ATENDIMENTO = TMP_MED.CD_ATENDIMENTO(+)
            AND ATE.CD_ATENDIMENTO = LAB.CD_ATENDIMENTO(+)
            --FILTROS
            AND DH_PROCESSO >= TRUNC(sysdate)-1
            and dh_processo < TRUNC(sysdaTE)
            AND   (TMA.CD_FILA_SENHA      IN (19,29,182,244,246,248,161,196,210,220,221,222,245,247,335,136,17,99,100,168,97,162,175,98,198,22,60,61,170,172,178)--UNIDADES AGAMENOM
                OR TMA.CD_FILA_SENHA   IN (25,26,27,43,44,45,53,/*54,55,56,57,*/58,/*59,*/164,165,171,174,/*228,229,*/230,/*233,234,235,*/278,332,343,345,346)) --UNIDADES BV)
                --order by cd_atendimento, dh_processo desc 
    ) 
        PIVOT (
            MAX(DH_PROCESSO) 
            FOR DS_TIPO_TEMPO_PROCESSO IN(
                'CADASTRO NO TOTEM' AS TOTEM, 
                'CLASSIFICAÇÃO CHAMADA' AS CLASS_CHAMADA, 
                'CLASSIFICAÇÃO INÍCIO' AS CLASS_INÍCIO, 
                'CLASSIFICAÇÃO FINAL' AS CLASS_FINAL, 
                'ATENDIMENTO ADMINISTRATIVO CHAMADA' AS AT_ADM_CHAMADA, 
                'ATENDIMENTO ADMINISTRATIVO INÍCIO' AS AT_ADM_INÍCIO, 
                'ATENDIMENTO ADMINISTRATIVO FINAL' AS AT_ADM_FINAL, 
                'ATENDIMENTO MÉDICO CHAMADA' AS AT_MÉDICO_CHAMADA, 
                'ATENDIMENTO MÉDICO INÍCIO' AS AT_MÉDICO_INÍCIO,
                'ATENDIMENTO MÉDICO FINAL' AS AT_MÉDICO_FINAL,
                'ATENDIMENTO MÉDICO ALTA' AS AT_MÉDICO_ALTA 
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
        DH_DISPENSACAO_FARM,
        NM_CONVENIO,
        DH_CHECAGEM,
        HR_PED_LAB,
        HR_COLETA_LAB
        
    ORDER BY CD_ATENDIMENTO DESC
)B
WHERE A.CD_ATENDIMENTO = B.CD_ATENDIMENTO(+)
AND (A.DT_ALTA_MEDICA IS NULL AND B.DT_ALTA_MEDICA IS NULL)
AND (A.CD_ORI_ATE in (2,4))
--AND (A.CD_ORI_ATE = 2 OR A.CD_ORI_ATE IS NULL)
AND A.CD_FILA_SENHA NOT IN(246,220,175,230,182)
--AND (A.CD_ATENDIMENTO = 4694275)
--AND OA.CD_ORI_ATE IN (2,4,5,22) -- REAL VIDA = 02 || INFANTE EMERG = 04 || REAL MATER = 05 ||UABV EMERG = 22
--AND STP.CD_ATENDIMENTO in (4627381,4626784,4628097,4627069)--4627764 --4625679
--4638498 paciente evadiu dia 21/05 dando entrada dia 20/05 
ORDER BY NM_PACIENTE, 6 DESC, TOTEM DESC