SELECT V.NM_PACIENTE,
       V.DT_NASCIMENTO,
       V.CD_PACIENTE,
       V.CD_ATENDIMENTO,
       DBAMV.FN_IDADE(V.DT_NASCIMENTO) IDADE,
       V.NM_PRESTADOR,
       V.PRE_ATENDIMENTO,
       V.CHAMADA_CLASSIFICACAO,
       V.HR_ATENDIMENTO,
       V.DS_SENHA,
       V.DT_ATENDIMENTO,
       V.DT_ALTA,
       V.CD_FILA_SENHA,
       V.DS_FILA,
       V.CD_ORI_ATE,
       V.DS_ORI_ATE,
       /*REPLACE(TO_CHAR(NVL(V.TEMPO1, 0) / 60, '999999.99'), '.', ',') AS "01.Senha > Classif.(Min)", --TEMPO1(01.Senha Chamada >  Classificação (Min)),
       REPLACE(TO_CHAR(NVL(V.TEMPO2, 0) / 60, '999999.99'), '.', ',') AS "02.Classif In. > Fim(Min)", --TEMPO2 (02.Início Classificação > Final Classificação (Min)),
       REPLACE(TO_CHAR(NVL(V.TEMPO3, 0) / 60, '999999.99'), '.', ',') AS "03.F_Classif. > At_Recep(Min)", --TEMPO3 (03. Fim Classificação > Chamada Atendimento Recepção (Min)),
       REPLACE(TO_CHAR(NVL(V.TEMPO4, 0) / 60, '999999.99'), '.', ',') AS "04.Recep In. > Fim(Min)", --TEMPO4 (04. Início  > Fim Atendimento Recepção (min)),
       REPLACE(TO_CHAR(NVL(V.TEMPO5, 0) / 60, '999999.99'), '.', ',') AS "05.F_Atend > Chamada Méd(Min)", --TEMPO5 (05. Fim Atendimento > Chamada Médico (min)),
       REPLACE(TO_CHAR(NVL(V.TEMPO6, 0) / 60, '999999.99'), '.', ',') AS "06.Lab Pedido > Coleta(Min)", --TEMPO6 (06. Laboratório Pedido > Coleta (min)),
       REPLACE(TO_CHAR(NVL(V.TEMPO7, 0) / 60, '999999.99'), '.', ',') AS "07.Img: RX Ped. > Coleta(Min)", --TEMPO7 (07. Imagem: RX Pedido > Coleta (min)),
       REPLACE(TO_CHAR(NVL(V.TEMPO8, 0) / 60, '999999.99'), '.', ',') AS "08.Tomo: RX Ped > Coleta(Min)", --TEMPO8 (08. Tomografia: RX Pedido > Coleta (min)),
       REPLACE(TO_CHAR(NVL(V.TEMPO9, 0) / 60, '999999.99'), '.', ',') AS "09.Ultra: RX Ped > Coleta(Min)", --TEMPO9 (09. Ultrassom: RX Pedido > Coleta (min)),*/
       --To_Number (NVL(V.TEMPO1, 0)) AS "01.Senha > Classif.(Min)", --TEMPO1(01.Senha Chamada >  Classificação (Min)),
       --To_Number (NVL(V.TEMPO2, 0)) AS "02.Classif In. > Fim(Min)", --TEMPO2 (02.Início Classificação > Final Classificação (Min)),
       To_Number (NVL(V.TEMPO3, 0)) AS "03.F_Classif. > At_Recep(Min)", --TEMPO3 (03. Fim Classificação > Chamada Atendimento Recepção (Min)),
       --To_Number (NVL(V.TEMPO4, 0)) AS "04.Recep In. > Fim(Min)", --TEMPO4 (04. Início  > Fim Atendimento Recepção (min)),
       --To_Number (NVL(V.TEMPO5, 0)) AS "05.F_Atend > Chamada Méd(Min)", --TEMPO5 (05. Fim Atendimento > Chamada Médico (min)),
       --To_Number (NVL(V.TEMPO6, 0)) AS "06.Lab Pedido > Coleta(Min)", --TEMPO6 (06. Laboratório Pedido > Coleta (min)),
       --To_Number (NVL(V.TEMPO7, 0)) AS "07.Img: RX Ped. > Coleta(Min)", --TEMPO7 (07. Imagem: RX Pedido > Coleta (min)),
       --To_Number (NVL(V.TEMPO8, 0)) AS "08.Tomo: RX Ped > Coleta(Min)", --TEMPO8 (08. Tomografia: RX Pedido > Coleta (min)),
       --To_Number (NVL(V.TEMPO9, 0)) AS "09.Ultra: RX Ped > Coleta(Min)", --TEMPO9 (09. Ultrassom: RX Pedido > Coleta (min)),
       TO_NUMBER (SUM(NVL(V.TEMPO1, 0) + NVL(V.TEMPO2, 0) + NVL(V.TEMPO3, 0) + NVL(V.TEMPO4, 0) + NVL(V.TEMPO5, 0) + NVL(V.TEMPO6, 0) + NVL(V.TEMPO7, 0)+ NVL(V.TEMPO8, 0)+ NVL(V.TEMPO9, 0))) AS TOTAL_GERAL,
       CASE WHEN V.CD_FILA_SENHA = 19  THEN 'Real Vida - ATENDIMENTO PREFERENCIAL'   
            WHEN V.CD_FILA_SENHA = 29  THEN 'Real Vida - ATENDIMENTO NORMAL'
            WHEN V.CD_FILA_SENHA = 182 THEN 'Real Vida - CONVOCAÇÃO DE TRANSPLANTE'
            WHEN V.CD_FILA_SENHA = 244 THEN 'Real Vida - PACIENTE COM DEFICIÊNCIA'
            WHEN V.CD_FILA_SENHA = 246 THEN 'Real Vida - PACIENTE AVC'
            WHEN V.CD_FILA_SENHA = 248 THEN 'Real Vida - SUPER IDOSO 80+'
            WHEN V.CD_FILA_SENHA = 161 THEN 'Real Vida - VIAGEM INTERNACIONAL RECENTE'
            WHEN V.CD_FILA_SENHA = 196 THEN 'Real Vida - NEUROLOGIA'
            WHEN V.CD_FILA_SENHA = 210 THEN 'Real Vida - PACIENTE EM CURSO DE QT/RT'
            WHEN V.CD_FILA_SENHA = 220 THEN 'Real Vida - SÍNDROME GRIPAL'
            WHEN V.CD_FILA_SENHA = 221 THEN 'Real Vida - ORTOPEDIA'
            WHEN V.CD_FILA_SENHA = 222 THEN 'Real Vida - OTORRINOLARINGOLOGIA'
            WHEN V.CD_FILA_SENHA = 245 THEN 'Real Vida - PACIENTE GESTANTE'
            WHEN V.CD_FILA_SENHA = 247 THEN 'Real Vida - PACIENTE DOR TORÁCIC'
            WHEN V.CD_FILA_SENHA = 335 THEN 'Real Vida - TEA'
            WHEN V.CD_FILA_SENHA = 136 THEN 'Real Vida - CARDIOLOGIA'
            WHEN V.CD_FILA_SENHA = 17  THEN 'Infante - ATENDIMENTO'
            WHEN V.CD_FILA_SENHA = 99  THEN 'Infante - PREFERENCIAL- PESSOA COM DEFICIÊNCIA'
            WHEN V.CD_FILA_SENHA = 100 THEN 'Infante - PREFERENCIAL - GENITORA GRÁVIDA'
            WHEN V.CD_FILA_SENHA = 168 THEN 'Infante - VIAGEM RECENTE PARA CHINA'
            WHEN V.CD_FILA_SENHA = 97  THEN 'Infante - PREFERENCIAL - PACIENTE ONCOPEDIATRIA'
            WHEN V.CD_FILA_SENHA = 162 THEN 'Infante - VIAGEM INTERNACIONAL RECENTE'
            WHEN V.CD_FILA_SENHA = 175 THEN 'Infante - SÍNDROME GRIPAL'
            WHEN V.CD_FILA_SENHA = 98  THEN 'Infante - PREFERENCIAL - RECÉM NASCIDO'
            WHEN V.CD_FILA_SENHA = 198 THEN 'Infante - VIAGEM RECENTE PARA REGIÃO NORTE BR'
            WHEN V.CD_FILA_SENHA = 22 THEN 'RM - ATENDIMENTO URGÊNCIA /GESTANTE'
            WHEN V.CD_FILA_SENHA = 60 THEN 'RM - INTERNAMENTO'
            WHEN V.CD_FILA_SENHA = 61 THEN 'RM - ATENDIMENTO URGÊNCIA /GINECOLÓGICO'
            WHEN V.CD_FILA_SENHA = 170 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
            WHEN V.CD_FILA_SENHA = 172 THEN 'RM - VIAGEM INTERNACIONAL RECENTE'
            WHEN V.CD_FILA_SENHA = 178 THEN 'RM - FEBRE E SINTOMAS RESPIRATÓRIOS'
            WHEN V.CD_FILA_SENHA = 24THEN 'BV - ATENDIMENTO NORMAL'
            WHEN V.CD_FILA_SENHA = 25THEN 'BV - ATENDIMENTO PREFERENCIAL'
            WHEN V.CD_FILA_SENHA = 26THEN 'BV - EXAMES DE IMAGEM'
            WHEN V.CD_FILA_SENHA = 27THEN 'BV - EXAMES LABORATORIAIS'
            WHEN V.CD_FILA_SENHA = 43THEN 'BV - RESSONÂNCIA MAGNÉTICA'
            WHEN V.CD_FILA_SENHA = 44THEN 'BV - ULTRASSONOGRAFIA'
            WHEN V.CD_FILA_SENHA = 45THEN 'BV - ATENDIMENTO PEDIATRIA'
            WHEN V.CD_FILA_SENHA = 53THEN 'BV - ATENDIMENTO PREFERENCIAL'
            WHEN V.CD_FILA_SENHA = 54THEN 'BV - TOMOGRAFIA'
            WHEN V.CD_FILA_SENHA = 55THEN 'BV - EXAMES LABORATORIAIS'
            WHEN V.CD_FILA_SENHA = 56THEN 'BV - ATENDIMENTO NORMAL'
            WHEN V.CD_FILA_SENHA = 57THEN 'BV - EXAMES DE IMAGEM'
            WHEN V.CD_FILA_SENHA = 58THEN 'BV - ATENDIMENTO PEDIATRIA'
            WHEN V.CD_FILA_SENHA = 59THEN 'BV - ULTRASSONOGRAFIA'
            WHEN V.CD_FILA_SENHA = 164THEN 'BV - VIAGEM INTERNACIONAL RECENTE'
            WHEN V.CD_FILA_SENHA = 165THEN 'BV - VIAGEM INTERNACIONAL RECENTE'
            WHEN V.CD_FILA_SENHA = 171THEN 'BV - VIAGEM RECENTE PARA CHINA'
            WHEN V.CD_FILA_SENHA = 174THEN 'BV - FEBRE E SINTOMAS RESPIRATÓRIOS'
            WHEN V.CD_FILA_SENHA = 228THEN 'BV - RESSONÂNCIA / TOMOGRAFIA'
            WHEN V.CD_FILA_SENHA = 229THEN 'BV - RAIO X / USG / MAMOGRAFIA'
            WHEN V.CD_FILA_SENHA = 230THEN 'BV - SÍNDROME GRIPAL'
            WHEN V.CD_FILA_SENHA = 233THEN 'BV - EXAMES AGENDADOS REAL IMAGEM'
            WHEN V.CD_FILA_SENHA = 234THEN 'BV - MARCAÇÃO DE EXAMES REAL IMAGEM'
            WHEN V.CD_FILA_SENHA = 235THEN 'BV - EXAMES DE IMAGEM PREFERENCIAL'
            WHEN V.CD_FILA_SENHA = 278THEN 'BV - ATENDIMENTO PREFERENCIAL'
            WHEN V.CD_FILA_SENHA = 332THEN 'BV - SINDROME GRIPAL'
            WHEN V.CD_FILA_SENHA = 343THEN 'BV - TEA'
	        END DESC_FILA,
          
       CASE WHEN V.CD_FILA_SENHA = 19 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 29 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 182 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 244 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 246 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 248 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 161 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 196 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 210 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 220 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 221 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 222 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 245 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 247 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 335 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 136 THEN 'Real Vida'
            WHEN V.CD_FILA_SENHA = 17 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 99 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 100 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 168 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 97 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 162 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 175 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 98 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 198 THEN 'Infante'
            WHEN V.CD_FILA_SENHA = 22 THEN 'RM'
            WHEN V.CD_FILA_SENHA = 60 THEN 'RM'
            WHEN V.CD_FILA_SENHA = 61 THEN 'RM'
            WHEN V.CD_FILA_SENHA = 170 THEN 'RM'
            WHEN V.CD_FILA_SENHA = 172 THEN 'RM'
            WHEN V.CD_FILA_SENHA = 178 THEN 'RM'
            ELSE 'BV'
          END EMERGENCIA,
        CON.NM_CONVENIO
FROM  (SELECT R.CD_PACIENTE,
              R.CD_ATENDIMENTO,
              R.NM_PACIENTE,
              R.PRE_ATENDIMENTO,
              R.NM_PRESTADOR,
              R.CHAMADA_CLASSIFICACAO,
              R.HR_ATENDIMENTO,
              R.DS_SENHA,
              R.CD_ORI_ATE,
              R.DS_ORI_ATE,
              R.CD_FILA_SENHA,
              R.DS_FILA,
              R.DT_ATENDIMENTO,
              R.DT_ALTA,
              R.DT_NASCIMENTO,
              R.TEMPO1,
              R.TEMPO2,
              R.TEMPO3,
              R.TEMPO4,
              R.TEMPO5,
              R.TEMPO6,
              R.TEMPO7,
              R.TEMPO8,
              R.TEMPO9
       FROM  (SELECT T.CD_TRIAGEM_ATENDIMENTO,
                     T.CD_PACIENTE,
                     T.DT_NASCIMENTO,
                     T.CD_ATENDIMENTO,
                     T.NM_PACIENTE,
                     T.CD_FILA_SENHA,
                     F.DS_FILA,
                     A.DT_ATENDIMENTO,
                     P.NM_PRESTADOR,
                     ORI.CD_ORI_ATE,
                     ORI.DS_ORI_ATE,
                     TO_CHAR(T.DH_PRE_ATENDIMENTO, 'DD/MM/RRRR HH24:MI') PRE_ATENDIMENTO,
                     TO_CHAR(T.DH_CHAMADA_CLASSIFICACAO, 'DD/MM/RRRR HH24:MI') AS CHAMADA_CLASSIFICACAO,
                     TO_CHAR(T.DH_PRE_ATENDIMENTO_FIM, 'dd/mm/rrrr hh24:mm') AS PRE_ATENDIMENTO_FIM,
                    -- TO_CHAR(TRUNC(MOD(((ROUND(((MAX(T.DH_CHAMADA_CLASSIFICACAO)) - (MIN(T.DH_PRE_ATENDIMENTO))) * 1440, 2)) * 60), 3600) / 60),'FM00') TEMPO1,
                    -- TO_CHAR(TRUNC(MOD(((ROUND(((MAX(T.DH_PRE_ATENDIMENTO_FIM)) - (MIN(T.DH_CHAMADA_CLASSIFICACAO))) * 1440, 2)) * 60), 3600) / 60),'FM00') TEMPO2,
                      --trunc(((MAX(T.DH_CHAMADA_CLASSIFICACAO)) - (MIN(T.DH_PRE_ATENDIMENTO))) *1440,1) TEMPO1,
                      
                      TRUNC((MAX(T.DH_CHAMADA_CLASSIFICACAO) - MIN(T.DH_PRE_ATENDIMENTO)) * 24 * 60)TEMPO1,
                      
                     -- trunc(((MAX(T.DH_PRE_ATENDIMENTO_FIM)) - (MIN(T.DH_CHAMADA_CLASSIFICACAO))) *1440,1) TEMPO2,
                      
                       TRUNC((MAX(T.DH_PRE_ATENDIMENTO_FIM) - MIN(T.DH_CHAMADA_CLASSIFICACAO)) * 24 * 60)TEMPO2,
                     
                     T.DS_SENHA,
                     TO_CHAR(A.HR_ATENDIMENTO, 'DD/MM/RRRR HH24:MI') AS HR_ATENDIMENTO,
                     
                     TEMP_IA.TEMPO3,
                     TEMP_FA.TEMPO4,
                     TEMP_ME.TEMPO5,
                     TEMP_LAB.TEMPO6,
                     TEMP_IMG_RX.TEMPO7,
                     TEMP_IMG_TC.TEMPO8,
                     TEMP_IMG_US.TEMPO9,
                     TEMP_IMG_RX.NM_SET_EXA_IMG,
                     A.DT_ALTA
              FROM   DBAMV.TRIAGEM_ATENDIMENTO T,
                     DBAMV.ATENDIME            A,
                     DBAMV.FILA_SENHA          F,
                     DBAMV.PRESTADOR           P,
                     DBAMV.ORI_ATE             ORI
                     
                     
             --  WHERE R.CD_ATENDIMENTO = 4598475
              --------------------------------------------------------------------------------------------------------------------------------------------------             
                   ,(SELECT A.CD_ATENDIMENTO,
                            V.CD_TRIAGEM_ATENDIMENTO,
                            V.DS_SENHA,
                            V.DH_PRE_ATENDIMENTO,
                            MAX(TO_CHAR(S.DH_PROCESSO, 'dd/mm/rrrr hh24:mm')) PROCESSO,
                          --  TO_CHAR(TRUNC(MOD(((ROUND(((MAX(S.DH_PROCESSO)) - (MIN(V.DH_PRE_ATENDIMENTO_FIM))) * 1440, 2)) * 60), 3600) / 60),'FM00') TEMPO3
                            
                        --    trunc(((MAX(S.DH_PROCESSO)) - (MIN(V.DH_PRE_ATENDIMENTO_FIM))) *1440,1) TEMPO3
                            
                            TRUNC((MAX(S.DH_PROCESSO) - MIN(V.DH_PRE_ATENDIMENTO_FIM)) * 24 * 60)TEMPO3
                     FROM   DBAMV.TRIAGEM_ATENDIMENTO V,
                            DBAMV.SACR_TEMPO_PROCESSO S,
                            DBAMV.ATENDIME            A
                     WHERE  V.CD_TRIAGEM_ATENDIMENTO =
                            S.CD_TRIAGEM_ATENDIMENTO
                     AND    A.CD_ATENDIMENTO = V.CD_ATENDIMENTO
                     AND    S.CD_TIPO_TEMPO_PROCESSO = 20
                     --AND    A.CD_ATENDIMENTO = 4619250
                     GROUP BY V.CD_TRIAGEM_ATENDIMENTO,
                              V.DS_SENHA,
                              V.DH_PRE_ATENDIMENTO,
                              A.CD_ATENDIMENTO) TEMP_IA
              --------------------------------------------------------------------------------------------------------------------------------------------------                    
                   ,(SELECT A.CD_ATENDIMENTO,
                            V.CD_TRIAGEM_ATENDIMENTO,
                            V.DS_SENHA,
                            V.DH_PRE_ATENDIMENTO,
                            MAX(TO_CHAR(S.DH_PROCESSO, 'dd/mm/rrrr hh24:mi')) PROCESSO,
                           -- TO_CHAR(TRUNC(MOD(((ROUND(((MAX(A.HR_ATENDIMENTO)) - (MIN(S.DH_PROCESSO))) * 1440, 2)) * 60), 3600) / 60),'FM00') TEMPO4
                         --   trunc(((MAX(A.HR_ATENDIMENTO)) - (MIN(S.DH_PROCESSO))) *1440,1) TEMPO4
                              
                            TRUNC((MAX(A.HR_ATENDIMENTO) - MIN(S.DH_PROCESSO)) * 24 * 60)TEMPO4
                     FROM   DBAMV.TRIAGEM_ATENDIMENTO V,
                            DBAMV.SACR_TEMPO_PROCESSO S,
                            DBAMV.ATENDIME            A
                     WHERE  V.CD_TRIAGEM_ATENDIMENTO =
                            S.CD_TRIAGEM_ATENDIMENTO
                     AND    A.CD_ATENDIMENTO = V.CD_ATENDIMENTO
                     AND    S.CD_TIPO_TEMPO_PROCESSO = 20
                     GROUP BY V.CD_TRIAGEM_ATENDIMENTO,
                              V.DS_SENHA,
                              V.DH_PRE_ATENDIMENTO,
                              A.CD_ATENDIMENTO) TEMP_FA
              ---------------------------------------------------------------------------------------------------------------------------------------------------             
                     ,(SELECT A.CD_ATENDIMENTO,
                              V.CD_TRIAGEM_ATENDIMENTO,
                              V.DS_SENHA,
                              V.DH_PRE_ATENDIMENTO,
                              MAX(TO_CHAR(S.DH_PROCESSO, 'dd/mm/rrrr hh24:mi')) PROCESSO,
                             -- TO_CHAR(TRUNC(MOD(((ROUND(((MAX(S.DH_PROCESSO)) - (MIN(A.HR_ATENDIMENTO))) * 1440, 2)) * 60), 3600) / 60), 'FM00') TEMPO5
                            --  trunc(((MAX(S.DH_PROCESSO)) - (MIN(A.HR_ATENDIMENTO))) *1440,1) TEMPO5
                              
                             TRUNC((MAX(S.DH_PROCESSO) - MIN(A.HR_ATENDIMENTO)) * 24 * 60)TEMPO5
                       FROM   DBAMV.TRIAGEM_ATENDIMENTO V,
                              DBAMV.SACR_TEMPO_PROCESSO S,
                              DBAMV.ATENDIME            A
                       WHERE  V.CD_TRIAGEM_ATENDIMENTO = S.CD_TRIAGEM_ATENDIMENTO
                       AND    A.CD_ATENDIMENTO         = V.CD_ATENDIMENTO
                       AND    S.CD_TIPO_TEMPO_PROCESSO = 30
                       GROUP BY V.CD_TRIAGEM_ATENDIMENTO,
                                V.DS_SENHA,
                                V.DH_PRE_ATENDIMENTO,
                                A.CD_ATENDIMENTO) TEMP_ME                             
              -------------------------------------------------------------------------------------------------------------------------------------------------         
                     ,(SELECT LAB.ATENDIME_LAB,
                              --trunc(((MAX(LAB.DH_COLETA)) - (MIN(LAB.DH_PEDIDO))) *1440,1) TEMPO6
                              --trunc(((MAX(LAB.DH_COLETA)) - (MIN(LAB.DH_PEDIDO))) *1440,1)  AS mark
                              
                                   TRUNC((MAX(DT_AMOSTRA) - MAX(LAB.DH_PEDIDO)) * 24 * 60)TEMPO6
                       FROM   (       
                       SELECT ATE.CD_ATENDIMENTO ATENDIME_LAB,
                              ATE.DT_ATENDIMENTO,
                              (SELECT
                              		MAX(TO_DATE(TO_CHAR(DT_MOVIMENTO,'DD/MM/YYYY') || TO_CHAR(HR_MOVIMENTO, 'HH24:MM:SS'),'DD/MM/YYYY HH24:MI:SS'))
                              	FROM DBAMV.LOG_MOVIMENTO_EXAME lme 
                              	WHERE CD_ITPED_LAB_RX = IPL.CD_ITPED_LAB
                              	AND DS_MOVIMENTO LIKE '%Amostra associada ao exame foi colhida no Setor%') AS DT_AMOSTRA,
                              FNC_MV_RECUPERA_DATA_HORA(PED.DT_PEDIDO, PED.HR_PED_LAB) DH_PEDIDO
                              --FNC_MV_RECUPERA_DATA_HORA(PED.DT_COLETA, PED.HR_COLETA)  DH_COLETA
                       FROM   DBAMV.ATENDIME  ATE,
                              DBAMV.PED_LAB   PED,
                              DBAMV.ITPED_LAB IPL
                       WHERE  ATE.CD_ATENDIMENTO = PED.CD_ATENDIMENTO
                       AND PED.CD_PED_LAB = IPL.CD_PED_LAB
                     --  AND ATE.CD_ATENDIMENTO = 4593906
                      -- AND  TO_CHAR(TRUNC(MOD(((ROUND(((MAX(LAB.DH_COLETA)) - (MIN(LAB.DH_PEDIDO))) * 1440, 2)) * 60), 3600) / 60), 'FM00')>60
                       AND    ATE.TP_ATENDIMENTO = 'U') LAB
                       GROUP BY LAB.ATENDIME_LAB) TEMP_LAB
                       
--833781 379932 3829968 3317554 3394053 3182274 2917552 1856154 1860477 1897383 1943873 620404
              -------------------------------------------------------------------------------------------------------------------------------------------------                  
                     ,(SELECT IMG.ATENDIME_IMG,IMG.NM_SET_EXA_IMG,
                            --  TO_CHAR(TRUNC(MOD(((ROUND(((MAX(IMG.DT_REALIZADO)) - (MIN(IMG.DH_PEDIDO))) * 1440, 2)) * 60), 3600) / 60), 'FM00') TEMPO7
                              
                             -- trunc(((MAX(IMG.DT_REALIZADO)) - (MIN(IMG.DH_PEDIDO))) *1440,1) TEMPO7
                                TRUNC((MIN(IMG.DT_REALIZADO) - MIN(IMG.DH_PEDIDO)) * 24 * 60)TEMPO7
                       FROM   (       
                       SELECT ATE.CD_ATENDIMENTO ATENDIME_IMG,
                              ATE.DT_ATENDIMENTO,
                              FNC_MV_RECUPERA_DATA_HORA(IMG.DT_PEDIDO, IMG.HR_PEDIDO) DH_PEDIDO,
                              DT_REALIZADO,
                              SETEXA.NM_SET_EXA  NM_SET_EXA_IMG
                              
                       FROM   DBAMV.ATENDIME  ATE,
                              DBAMV.PED_RX    IMG,
                              DBAMV.SET_EXA   SETEXA,
                              DBAMV.ITPED_RX  IT
                       WHERE  ATE.CD_ATENDIMENTO = IMG.CD_ATENDIMENTO
                       	AND   IMG.CD_SET_EXA =  SETEXA.CD_SET_EXA
                       	AND   IMG.CD_PED_RX = IT.CD_PED_RX
                       	AND   IMG.CD_SET_EXA = 12 --RADIOLOGIA REAL IMAGEM
                       AND    ATE.TP_ATENDIMENTO = 'U'
                      -- AND   ATE.CD_ATENDIMENTO = 4532770
                       ) IMG
                       GROUP BY IMG.ATENDIME_IMG,IMG.NM_SET_EXA_IMG) TEMP_IMG_RX
               -------------------------------------------------------------------------------------------------------------------------------------------------                  
                     ,(SELECT IMG.ATENDIME_IMG,IMG.NM_SET_EXA_IMG,
                             -- TO_CHAR(TRUNC(MOD(((ROUND(((MAX(IMG.DT_REALIZADO)) - (MIN(IMG.DH_PEDIDO))) * 1440, 2)) * 60), 3600) / 60), 'FM00') TEMPO8
                      			--trunc(((MAX(IMG.DT_REALIZADO)) - (MIN(IMG.DH_PEDIDO))) *1440,1) TEMPO8
                      	 		TRUNC((MIN(IMG.DT_REALIZADO) - MIN(IMG.DH_PEDIDO)) * 24 * 60)TEMPO8
                       FROM   (       
                       SELECT ATE.CD_ATENDIMENTO ATENDIME_IMG,
                              ATE.DT_ATENDIMENTO,
                              FNC_MV_RECUPERA_DATA_HORA(IMG.DT_PEDIDO, IMG.HR_PEDIDO) DH_PEDIDO,
                              DT_REALIZADO,
                              SETEXA.NM_SET_EXA  NM_SET_EXA_IMG
                              
                       FROM   DBAMV.ATENDIME  ATE,
                              DBAMV.PED_RX    IMG,
                              DBAMV.SET_EXA   SETEXA,
                              DBAMV.ITPED_RX  IT
                       WHERE  ATE.CD_ATENDIMENTO = IMG.CD_ATENDIMENTO
                       	AND   IMG.CD_SET_EXA =  SETEXA.CD_SET_EXA
                       	AND   IMG.CD_PED_RX = IT.CD_PED_RX
                       	AND   IMG.CD_SET_EXA = 19 --TOMOGRAFIA COMPUTADORIZADA RI
                       AND    ATE.TP_ATENDIMENTO = 'U'
                       ) IMG
                       GROUP BY IMG.ATENDIME_IMG,IMG.NM_SET_EXA_IMG) TEMP_IMG_TC
               -------------------------------------------------------------------------------------------------------------------------------------------------                  
                     ,(SELECT IMG.ATENDIME_IMG,IMG.NM_SET_EXA_IMG,
                              --TO_CHAR(TRUNC(MOD(((ROUND(((MAX(IMG.DT_REALIZADO)) - (MIN(IMG.DH_PEDIDO))) * 1440, 2)) * 60), 3600) / 60), 'FM00') TEMPO9
                        --      trunc(((MAX(IMG.DT_REALIZADO)) - (MIN(IMG.DH_PEDIDO))) *1440,1) TEMPO9
                            TRUNC((MIN(IMG.DT_REALIZADO) - MIN(IMG.DH_PEDIDO)) * 24 * 60)TEMPO9
                       FROM   (       
                       SELECT ATE.CD_ATENDIMENTO ATENDIME_IMG,
                              ATE.DT_ATENDIMENTO,
                              FNC_MV_RECUPERA_DATA_HORA(IMG.DT_PEDIDO, IMG.HR_PEDIDO) DH_PEDIDO,
                              DT_REALIZADO,
                              SETEXA.NM_SET_EXA  NM_SET_EXA_IMG
                              
                       FROM   DBAMV.ATENDIME  ATE,
                              DBAMV.PED_RX    IMG,
                              DBAMV.SET_EXA   SETEXA,
                              DBAMV.ITPED_RX  IT
                       WHERE  ATE.CD_ATENDIMENTO = IMG.CD_ATENDIMENTO
                       	AND   IMG.CD_SET_EXA =  SETEXA.CD_SET_EXA
                       	AND   IMG.CD_PED_RX = IT.CD_PED_RX
                       	AND   IMG.CD_SET_EXA = 27 --ULTRASSONOGRAFIA REAL IMAGEM
                       AND    ATE.TP_ATENDIMENTO = 'U'
                       ) IMG
                       GROUP BY IMG.ATENDIME_IMG,IMG.NM_SET_EXA_IMG) TEMP_IMG_US
              -------------------------------------------------------------------------------------------------------------------------------------------------                  
              WHERE A.CD_ATENDIMENTO          = T.CD_ATENDIMENTO(+)
              AND   T.CD_FILA_SENHA           = F.CD_FILA_SENHA(+)
              AND   TEMP_IA.CD_ATENDIMENTO(+) = T.CD_ATENDIMENTO
              AND   T.CD_ATENDIMENTO          = TEMP_FA.CD_ATENDIMENTO(+)
              AND   TEMP_ME.CD_ATENDIMENTO(+) = T.CD_ATENDIMENTO
              AND   TEMP_LAB.ATENDIME_LAB (+) = T.CD_ATENDIMENTO 
              AND   TEMP_IMG_RX.ATENDIME_IMG (+) = T.CD_ATENDIMENTO
              AND   TEMP_IMG_TC.ATENDIME_IMG (+) = T.CD_ATENDIMENTO
              AND   TEMP_IMG_US.ATENDIME_IMG (+) = T.CD_ATENDIMENTO
              AND   P.CD_PRESTADOR(+)         = A.CD_PRESTADOR
              AND   A.CD_ORI_ATE(+)           = ORI.CD_ORI_ATE
              AND   (F.CD_FILA_SENHA           IN (19,29,182,244,246,248,161,196,210,220,221,222,245,247,335,136,17,99,100,168,97,162,175,98,198,22,60,61,170,172,178)--UNIDADES AGAMENOM
                    OR   F.CD_FILA_SENHA       IN (24,25,26,27,43,44,45,53,54,55,56,57,58,59,164,165,171,174,228,229,230,233,234,235,278,332,343,345,346)) --UNIDADES BV)

              AND   A.DT_ATENDIMENTO  =  TRUNC (SYSDATE) --TO_DATE(SYSDATE, 'DD/MM/RRRR') 
            AND   ori.CD_ORI_ATE = 2
            --AND T.CD_PACIENTE = DECODE ('{V_REG}', 0, T.CD_PACIENTE, NULL, T.CD_PACIENTE, '{V_REG}')  
            --AND T.CD_FILA_SENHA = {V_FILA}
              GROUP BY T.CD_TRIAGEM_ATENDIMENTO,
                       T.DH_PRE_ATENDIMENTO,
                       T.CD_PACIENTE,
                       T.DT_NASCIMENTO,
                       T.NM_PACIENTE,
                       A.DT_ATENDIMENTO,
                       T.CD_ATENDIMENTO,
                       P.NM_PRESTADOR,
                       T.DH_CHAMADA_CLASSIFICACAO,
                       T.DS_SENHA,
                       T.CD_FILA_SENHA,
                       A.CD_ATENDIMENTO,
                       A.HR_ATENDIMENTO,
                       T.DH_PRE_ATENDIMENTO_FIM,
                       TEMP_IA.TEMPO3,
                       TEMP_FA.TEMPO4,
                       TEMP_ME.TEMPO5,
                       TEMP_LAB.TEMPO6,
                       TEMP_IMG_RX.TEMPO7,
                       TEMP_IMG_TC.TEMPO8,
                       TEMP_IMG_US.TEMPO9,
                       TEMP_IMG_RX.NM_SET_EXA_IMG,
                       ORI.CD_ORI_ATE,
                       ORI.DS_ORI_ATE,
                       F.DS_FILA,
                       A.DT_ALTA
              ORDER BY 2 DESC) R
            WHERE R.DT_ATENDIMENTO =  TRUNC (SYSDATE) --TO_DATE(SYSDATE, 'DD/MM/RRRR') 

--              WHERE TRUNC(R.DT_ATENDIMENTO) BETWEEN TO_DATE('01/01/2024', 'DD/MM/RRRR') AND TO_DATE('31/12/2024', 'DD/MM/RRRR')
     --AND R.CD_FILA_SENHA = {V_FILA}
     --R.CD_PACIENTE = DECODE ('{V_REG}', 0, R.CD_PACIENTE, NULL, R.CD_PACIENTE, '{V_REG}')
       GROUP BY R.CD_PACIENTE,
                R.CD_ATENDIMENTO,
                R.NM_PACIENTE,
                R.DT_NASCIMENTO,
                R.DS_SENHA,
                R.CD_FILA_SENHA,
                R.DT_ATENDIMENTO,
                R.NM_PRESTADOR,
                R.HR_ATENDIMENTO,
                R.PRE_ATENDIMENTO,
                R.CHAMADA_CLASSIFICACAO,
                R.TEMPO1,
                R.TEMPO2,
                R.TEMPO3,
                R.TEMPO4,
                R.TEMPO5,
                R.TEMPO6,
                R.TEMPO7,
                R.TEMPO8,
                R.TEMPO9,
                R.CD_ORI_ATE,
                R.DS_ORI_ATE,
                R.DS_FILA,
                R.DT_ALTA) V,
	DBAMV.ATENDIME ATE,
	DBAMV.CONVENIO CON
WHERE V.DT_ATENDIMENTO  =  TRUNC (SYSDATE)--TO_DATE(SYSDATE, 'DD/MM/RRRR') 
	AND V.CD_ATENDIMENTO (+) = ATE.CD_ATENDIMENTO
	AND ATE.CD_CONVENIO (+) = CON.CD_CONVENIO
  AND V.DT_ALTA IS NULL
  --AND V.CD_aTENDIMENTO = 4619450
  --AND (NVL(V.TEMPO1, 0)) > 0
  --AND V.CD_FILA_SENHA = {V_FILA}
  --V.CD_PACIENTE = DECODE ('{V_REG}', 0, V.CD_PACIENTE, NULL, V.CD_PACIENTE, '{V_REG}')
  --TRUNC(V.DT_ATENDIMENTO) BETWEEN TO_DATE(@P_DATAINICIAL, 'DD/MM/RRRR')AND TO_DATE(@P_DATAFINAL, 'DD/MM/RRRR') 
GROUP BY  V.CD_PACIENTE,
          V.CD_ATENDIMENTO,
          V.NM_PACIENTE,
          V.DT_NASCIMENTO,
          V.DS_SENHA,
          V.CD_FILA_SENHA,
          V.HR_ATENDIMENTO,
          V.NM_PRESTADOR,
          V.DT_ATENDIMENTO,
          V.PRE_ATENDIMENTO,
          V.CD_ORI_ATE,
          V.DS_ORI_ATE,
          V.CHAMADA_CLASSIFICACAO,
          V.TEMPO1,
          V.TEMPO2,
          V.TEMPO3,
          V.TEMPO4,
          V.TEMPO5,
          V.TEMPO6,
          V.TEMPO7,
          V.TEMPO8,
          V.TEMPO9,
          V.DS_FILA,
          V.DT_ALTA,
          CON.NM_CONVENIO
 ORDER BY HR_ATENDIMENTO DESC, V.DS_SENHA ASC