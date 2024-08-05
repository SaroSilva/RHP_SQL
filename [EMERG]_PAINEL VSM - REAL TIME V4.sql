SELECT 
        CD_ATENDIMENTO,
        CD_CID,
        DS_CID,
        DT_ATENDIMENTO,
        DS_SENHA,
        NM_PACIENTE,
        DECODE(SN_VIP,'S','Prontuário Vip','N','Prontuário Normal') as SN_VIP,
        PRESTADO_MED,
        Decode(Substr(NM_CONVENIO,7,10),NULL,NM_CONVENIO,Substr(NM_CONVENIO,1,6)||'...') NM_CONVENIO,
        DS_ESPECIALIDADE,
        SN_PRIORIDADE_CLASSIFICACAO, --Se SIM, o Paciente terá prioridade até o momento da classificação
        DECODE(SN_PRIORIDADE_CLASSIFICACAO,'S',1,'N',0) PRIORIDADE_CLASSIFICA,
        SN_PRIORIDADE_ESPECIAL, --Se SIM, o Paciente terá prioridade na classificação
        DECODE(SN_PRIORIDADE_ESPECIAL,'S',1,'N',0) PRIORIDADE_ESPECIAL,
        SN_PRIORIDADE_OCTO, --Identifica a prioridade para idoso acima de 80 anos
        DECODE(SN_PRIORIDADE_OCTO,'S',1,'N',0) PRIORIDADE_IDOSO80,
        CD_CLASSIFICACAO,
        TP_CLASSIFICACAO,
        TP_SEXO,
        CD_FILA_SENHA,
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
          WHEN CD_FILA_SENHA IN (19,29,136,161,182,196,210,220,221,222,244,245,246,247,248,336) THEN 'Real Vida'
          WHEN CD_FILA_SENHA IN (17,97,98,99,100,162,168,175,198) THEN 'Infante'
          WHEN CD_FILA_SENHA IN (22,60,61,170,172,178) THEN 'RM'
          WHEN CD_FILA_SENHA IN (25,45,53,54,55,56,57,58,59,164,165,171,174,228,229,230,233,234,235,278,332,343) THEN 'BV'
        END as emergencia,
        CASE 
          WHEN CD_FILA_SENHA IN (19,29,136,161,182,196,210,220,221,222,244,245,246,247,248,335,336) THEN 1
          WHEN CD_FILA_SENHA IN (17,97,98,99,100,162,168,175,198) THEN 2
          WHEN CD_FILA_SENHA IN (22,60,61,170,172,178) THEN 3
          WHEN CD_FILA_SENHA IN (25,45,53,54,55,56,57,58,59,164,165,171,174,228,229,230,233,234,235,278,332,343) THEN 4
        END as cd_emergencia,
        CD_ORI_ATE,
        DS_ORI_ATE,
        
        MAX(TOTEM) AS TOTEM,
        MAX (CLASS_RETIRA_SENHA) AS CLASS_RETIRA_SENHA,        
        MAX(NVL(CLASS_CHAMADA,CLASS_INICIO)) AS CLASS_CHAMADA,
        CASE
          WHEN MAX (NVL(CLASS_CHAMADA,CLASS_INICIO)) IS NULL AND MAX(CLASS_FINAL) IS NULL AND MAX(CLASS_INICIO) IS NULL AND CD_FILA_SENHA IN (220,22,136,61,60) THEN ROUND(((NVL(MAX(NVL(CLASS_CHAMADA,CLASS_INICIO)),MAX(TOTEM)) - MAX(TOTEM))*24*60),0)
          ELSE ROUND(((NVL(NVL(MAX(NVL(CLASS_CHAMADA,CLASS_INICIO)),DT_ALTA_MEDICA),SYSDATE) - MAX(TOTEM))*24*60),0) 
        END AS TEMPO_01, --Totem até Triagem (Iniciar registro do paciente)
        
        MAX(CLASS_INICIO) AS CLASS_INICIO,
        MAX(CLASS_FINAL) AS CLASS_FINAL,
        ROUND(((NVL(MAX(CLASS_FINAL),SYSDATE) - MAX(CLASS_INICIO))*24*60),0) AS TEMPO_02, --Triagem (Classificar paciente)
        
        MAX(NVL(AT_ADM_CHAMADA,AT_ADM_INICIO)) AS AT_ADM_CHAMADA,
        MAX(AT_ADM_INICIO) AS AT_ADM_INICIO,
        MAX(AT_ADM_FINAL) AS AT_ADM_FINAL,
        ROUND(((NVL(MAX(AT_ADM_FINAL),SYSDATE) - MAX(NVL(AT_ADM_CHAMADA,AT_ADM_INICIO)))*24*60),0) AS TEMPO_03, --Recepção (Cadastro do paciente)
        
        MAX(NVL(AT_MEDICO_CHAMADA,AT_MEDICO_INICIO)) AS AT_MEDICO_CHAMADA,
        CASE 
          WHEN MAX(NVL(AT_MEDICO_CHAMADA,AT_MEDICO_INICIO)) IS NULL AND DT_ALTA_MEDICA IS NOT NULL THEN ROUND(((NVL(MAX(DT_ALTA_MEDICA),SYSDATE) - MAX(AT_ADM_FINAL))*24*60),0)
          ELSE ROUND(((NVL(MAX(NVL(AT_MEDICO_CHAMADA,AT_MEDICO_INICIO)),SYSDATE) - MAX(AT_ADM_FINAL))*24*60),0) END AS TEMPO_04, --Inicio do Atendimento Médico
        
        NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
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
              ),MAX(AT_MEDICO_FINAL)) DH_EVOL_MED,
        
        CASE
        WHEN 
        ROUND(((NVL(NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
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
                                ),MAX(DT_ALTA_MEDICA)), SYSDATE) - MAX(NVL(AT_MEDICO_CHAMADA,AT_MEDICO_INICIO)))*24*60),0) >= 0
        THEN
        ROUND(((NVL(NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
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
                                ),MAX(DT_ALTA_MEDICA)), SYSDATE) - MAX(NVL(AT_MEDICO_CHAMADA,AT_MEDICO_INICIO)))*24*60),0) 
        ELSE 
        ROUND(((NVL(NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
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
                                ),MAX(DT_ALTA_MEDICA)), SYSDATE) - MAX(NVL(AT_MEDICO_CHAMADA,AT_MEDICO_INICIO)))*24*60),0) * -1
        END AS TEMPO_05, -- Em atendimento médico
                                
        MAX(HR_PRE_MED) AS DH_PRE_MED,
        MAX(HR_SOLSAI_PRO) AS DH_SOLSAI_PRO,
        MAX(DH_DISPENSACAO_FARM) AS DH_DISPENSACAO_FARM,
        CASE
          WHEN MAX(HR_SOLSAI_PRO) IS NOT NULL AND MAX(DH_DISPENSACAO_FARM) IS NULL AND DT_ALTA_MEDICA IS NOT NULL THEN ROUND(((NVL(MAX(DT_ALTA_MEDICA),SYSDATE) - MAX(HR_SOLSAI_PRO))*24*60),0)
          ELSE ROUND(((NVL(MAX(DH_DISPENSACAO_FARM),SYSDATE) - MAX(HR_SOLSAI_PRO))*24*60),0) END AS TEMPO_06, --Dispensação Farmacia
        
        MAX(DH_CHECAGEM)AS DH_CHECAGEM,
        CASE
          WHEN MAX(HR_SOLSAI_PRO) IS NOT NULL AND MAX(DH_DISPENSACAO_FARM) IS NULL AND DT_ALTA_MEDICA IS NOT NULL AND MAX(DH_CHECAGEM) IS NULL THEN ROUND(((NVL(MAX(DT_ALTA_MEDICA),SYSDATE) - NVL(MAX(DH_DISPENSACAO_FARM),MAX(HR_PRE_MED)))*24*60),0)
          ELSE ROUND(((NVL(NVL(MAX(DH_CHECAGEM),DT_ALTA_MEDICA),SYSDATE) - NVL(MAX(DH_DISPENSACAO_FARM),MAX(HR_PRE_MED)))*24*60),0) END AS TEMPO_07, --Administração medicação
        
        /*(SELECT MAX(DBAMV.FNC_MV_RECUPERA_DATA_HORA(DT_PEDIDO, HR_PED_LAB)) 
            FROM DBAMV.PED_LAB WHERE CD_ATENDIMENTO = ATENDIMENTO
        ) DH_PED_LAB,
        (SELECT MAX(DT_MOVIMENTO) FROM DBAMV.LOG_MOVIMENTO_EXAME
            WHERE DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%'
            AND CD_ATENDIMENTO = ATENDIMENTO
         )DH_COLETA_LAB,
         ROUND(((NVL( (SELECT MAX(DT_MOVIMENTO) FROM DBAMV.LOG_MOVIMENTO_EXAME
            WHERE DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%'
            AND CD_ATENDIMENTO = ATENDIMENTO
         ),SYSDATE) - (SELECT MAX(DBAMV.FNC_MV_RECUPERA_DATA_HORA(DT_PEDIDO, HR_PED_LAB)) 
            FROM DBAMV.PED_LAB WHERE CD_ATENDIMENTO = ATENDIMENTO ))*24*60),0) AS TEMPO_08, --Coleta laboratorial
         
        MAX(TIPO_EXA) TIPO_EXA, 
         MAX(CD_PED_RX) CD_PED_RX, 
         MAX(DT_PEDIDO_RX) DT_PEDIDO_RX, 
         MAX(DH_REALIZADO) DH_REALIZADO,
         ROUND(((NVL(MAX(DH_REALIZADO),SYSDATE) - MAX(DT_PEDIDO_RX))*24*60),0) AS TEMPO_09, --Realização Imagem*/
        (SELECT MAX(PDC.DH_FECHAMENTO) 
          FROM DBAMV.PW_DOCUMENTO_CLINICO PDC
          WHERE PDC.CD_OBJETO = 412
          AND PDC.CD_ATENDIMENTO = ATENDIMENTO) DH_START_REAVALIA, -- START DA ENFERMAGEM PARA REAVALIAÇÃO
          
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
              AND PEC.CD_DOCUMENTO IN (731,1132) ----FICHA DE REAVALIZAÇÃO
              AND PDC.CD_ATENDIMENTO = ATENDIMENTO
          ) DH_REAVALIA_MED, -- FINAL DE REAVALIAÇÃO MEDICA
          
          CASE
          WHEN 
          ROUND(((NVL(NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
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
                        ),DT_ALTA_MEDICA),SYSDATE)-(SELECT MAX(PDC.DH_FECHAMENTO) 
                                      FROM DBAMV.PW_DOCUMENTO_CLINICO PDC
                                      WHERE PDC.CD_OBJETO = 412
                                      AND PDC.CD_ATENDIMENTO = ATENDIMENTO))*24*60),0) >= 0
          THEN 
          ROUND(((NVL(NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
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
                        ),DT_ALTA_MEDICA),SYSDATE)-(SELECT MAX(PDC.DH_FECHAMENTO) 
                                      FROM DBAMV.PW_DOCUMENTO_CLINICO PDC
                                      WHERE PDC.CD_OBJETO = 412
                                      AND PDC.CD_ATENDIMENTO = ATENDIMENTO))*24*60),0)
          ELSE 
          ROUND(((NVL(NVL((SELECT MAX(PDC.DH_FECHAMENTO) 
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
                        ),DT_ALTA_MEDICA),SYSDATE)-(SELECT MAX(PDC.DH_FECHAMENTO) 
                                      FROM DBAMV.PW_DOCUMENTO_CLINICO PDC
                                      WHERE PDC.CD_OBJETO = 412
                                      AND PDC.CD_ATENDIMENTO = ATENDIMENTO))*24*60),0) *-1
          END AS TEMPO_10,

          DT_ALTA_MEDICA AS DH_ALTA_MEDICA,

          ROUND(((NVL(DT_ALTA_MEDICA,SYSDATE) - (SELECT MAX(PDC.DH_FECHAMENTO) 
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
                                                  ))*24*60),0) AS TEMPO_11, --Realização de reavaliação
              
          (SELECT MAX(DH_FECHAMENTO)
            FROM DBAMV.PW_DOCUMENTO_CLINICO
            WHERE CD_ATENDIMENTO = ATENDIMENTO
            AND CD_TIPO_DOCUMENTO = 12 
          ) DH_SOLIC_INT,
         CASE 
          WHEN (SELECT MAX(DH_FECHAMENTO)
                  FROM DBAMV.PW_DOCUMENTO_CLINICO
                  WHERE CD_ATENDIMENTO = ATENDIMENTO
                  AND CD_TIPO_DOCUMENTO = 12 
                ) IS NOT NULL THEN 'SIM' ELSE 'NÃO' END AS TP_SOLIC_INT,

          ROUND(((NVL(DT_ALTA_MEDICA,SYSDATE) - (SELECT MAX(DH_FECHAMENTO) FROM DBAMV.PW_DOCUMENTO_CLINICO
                                                  WHERE CD_ATENDIMENTO = ATENDIMENTO AND CD_TIPO_DOCUMENTO = 12))*24*60),0) AS TEMPO_12,
         
          ROUND(((NVL(DT_ALTA_MEDICA,SYSDATE) -  NVL(NVL(MAX(TOTEM),MAX(AT_ADM_INICIO)),MAX(AT_ADM_FINAL)))*24*60),0) AS TEMPO_20,
          TO_CHAR(TO_DATE('00:00', 'HH24:MI') + NUMTODSINTERVAL(ROUND(((NVL(DT_ALTA_MEDICA,SYSDATE) -  NVL(NVL(MAX(TOTEM),MAX(AT_ADM_INICIO)),MAX(AT_ADM_FINAL)))*24*60),0), 'MINUTE'), 'HH24:MI') AS HM_TEMPO20
            

FROM (
            SELECT 
                STTP.DS_TIPO_TEMPO_PROCESSO,
                NVL(SCP.CD_CATEGORIA_PROCESSO,'0')CD_CATEGORIA_PROCESSO,
                NVL(SCP.ds_categoria_processo,'ALTA MÉDICA')ds_categoria_processo,
                STP.DH_PROCESSO,
                TMA.DS_SENHA,
                ATE.CD_ATENDIMENTO,
                ATE.CD_ATENDIMENTO AS ATENDIMENTO,
                ATE.DT_ATENDIMENTO,
                ATE.DT_ALTA_MEDICA,
                ATE.SN_REAVALIACAO, 
                ATE.SN_INTERNADO,
                TMA.NM_PACIENTE_ABREV AS NM_PACIENTE,
                (SELECT SN_VIP FROM PACIENTE WHERE CD_PACIENTE = ATE.CD_PACIENTE) AS SN_VIP,
                CON.NM_CONVENIO,
                TMA.CD_FILA_SENHA,
                OA.CD_ORI_ATE,
                OA.DS_ORI_ATE,
                TMP_MED.DH_DISPENSACAO_FARM,
                TMP_MED.DH_CHECAGEM,
                TMP_MED.HR_PRE_MED,
                TMP_MED.HR_SOLSAI_PRO,
                REGEXP_REPLACE(PRE.NM_PRESTADOR, '\s([A-Za-z])[A-Za-z]+', ' \1.') AS PRESTADO_MED,
                (SELECT DS_ESPECIALID FROM DBAMV.ESPECIALID WHERE CD_ESPECIALID = TMA.CD_ESPECIALID) AS DS_ESPECIALIDADE,
                TMA.SN_PRIORIDADE_CLASSIFICACAO,
                TMA.SN_PRIORIDADE_ESPECIAL,
                TMA.SN_PRIORIDADE_OCTO,
                TMA.CD_CLASSIFICACAO, --descrição do tipo de risco
                (SELECT DS_TIPO_RISCO FROM DBAMV.SACR_CLASSIFICACAO WHERE CD_CLASSIFICACAO = TMA.CD_CLASSIFICACAO) AS TP_CLASSIFICACAO, --descrição do tipo de risco
                DECODE (TMA.TP_SEXO,'M','MASCULINO','F','FEMININO') AS TP_SEXO,
                ATE.CD_CID,
                (SELECT DS_CID FROM DBAMV.CID WHERE CD_CID = ATE.CD_CID) AS DS_CID
                
            FROM 
                SACR_TEMPO_PROCESSO STP,
                SACR_TIPO_TEMPO_PROCESSO STTP,
                SACR_CATEGORIA_PROCESSO SCP,
                DBAMV.ATENDIME ATE,
                DBAMV.PRESTADOR PRE,
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
                            --AND ATE.DT_ALTA IS NULL
                    AND ATE.DT_ATENDIMENTO >= '01/JUL/2024'
                    AND ATE.DT_ATENDIMENTO < TRUNC(SYSDATE)+INTERVAL '24' HOUR
                    AND ATE.TP_ATENDIMENTO = 'U' 
                    --AND ATE.CD_ORI_ATE = 2
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
      ) 
    )TMP_MED

            --LIGAÇÕES
            WHERE STP.CD_TIPO_TEMPO_PROCESSO (+) = STTP.CD_TIPO_TEMPO_PROCESSO
            AND STTP.cd_categoria_processo = SCP.cd_categoria_processo (+)
            AND STP.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO(+)
            AND TMA.CD_TRIAGEM_ATENDIMENTO(+) = STP.CD_TRIAGEM_ATENDIMENTO
            AND OA.CD_ORI_ATE(+) = ATE.CD_ORI_ATE
            AND ATE.CD_CONVENIO = CON.CD_CONVENIO(+)
            AND ATE.CD_ATENDIMENTO = TMP_MED.CD_ATENDIMENTO(+)
            AND ATE.CD_PRESTADOR = PRE.CD_PRESTADOR(+)

            --FILTROS
            --AND DH_PROCESSO >= '01/JUL/2024'
            --AND DH_PROCESSO < TRUNC(SYSDATE) + INTERVAL '24' HOUR
            AND ATE.DT_ATENDIMENTO >= '01/JAN/2024'
            AND ATE.DT_ATENDIMENTO < TRUNC(SYSDATE)+INTERVAL '24' HOUR
            AND ATE.CD_ATENDIMENTO = 4268845
            --AND ATE.DT_ALTA_MEDICA IS NULL
            AND   (TMA.CD_FILA_SENHA      IN (19,29,182,244,246,248,161,196,210,220,221,222,245,247,335,136,17,99,100,168,97,162,175,98,198,22,60,61,170,172,178)--UNIDADES AGAMENOM
                OR TMA.CD_FILA_SENHA   IN (25,26,27,43,44,45,53,/*54,55,56,57,*/58,/*59,*/164,165,171,174,/*228,229,*/230,/*233,234,235,*/278,332,343,345,346)) --UNIDADES BV)
    ) 
        PIVOT (
            MAX(DH_PROCESSO) 
            FOR DS_TIPO_TEMPO_PROCESSO IN(
                'CADASTRO NO TOTEM' AS TOTEM, 
                'REMOVIDO DA LISTA' AS CLASS_RETIRA_SENHA,                
                'CLASSIFICAÇÃO CHAMADA' AS CLASS_CHAMADA, 
                'CLASSIFICAÇÃO INÍCIO' AS CLASS_INICIO, 
                'CLASSIFICAÇÃO FINAL' AS CLASS_FINAL, 
                'ATENDIMENTO ADMINISTRATIVO CHAMADA' AS AT_ADM_CHAMADA, 
                'ATENDIMENTO ADMINISTRATIVO INÍCIO' AS AT_ADM_INICIO, 
                'ATENDIMENTO ADMINISTRATIVO FINAL' AS AT_ADM_FINAL, 
                'ATENDIMENTO MÉDICO CHAMADA' AS AT_MEDICO_CHAMADA, 
                'ATENDIMENTO MÉDICO INÍCIO' AS AT_MEDICO_INICIO,
                'ATENDIMENTO MÉDICO FINAL' AS AT_MEDICO_FINAL,
                'ATENDIMENTO MÉDICO ALTA' AS AT_MEDICO_ALTA 
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
        HR_PRE_MED,
        HR_SOLSAI_PRO,
        PRESTADO_MED,
        DS_ESPECIALIDADE,
        SN_PRIORIDADE_CLASSIFICACAO,
        SN_PRIORIDADE_ESPECIAL,
        SN_PRIORIDADE_OCTO,
        TP_CLASSIFICACAO,
        CD_CID,
        DS_CID,
        TP_SEXO,
        CD_CLASSIFICACAO,
        SN_VIP

    ORDER BY DT_ATENDIMENTO ASC, TOTEM DESC, EMERGENCIA DESC