SELECT 
A.CD_PACIENTE
, A.NM_PACIENTE
, A.DT_NASCIMENTO
, A.IDADE
, A.CD_ATENDIMENTO
, A.NM_CONVENIO
, A.DH_ADMISSAO
, A.ESCALA
, A.INTENSIDADE
, A.DS_DOR
, A.DATA_COLETA AS DATA_COLETA_01
, B.DATA_COLETA AS DATA_COLETA_02
, ROUND(((A.DATA_COLETA-B.DATA_COLETA)*24*60),0) AS TMP
, A.DS_UNID_INT
FROM(
Select * from (
SELECT 
CD_PACIENTE,
NM_PACIENTE,
DT_NASCIMENTO,
IDADE,
CD_ATENDIMENTO,
NM_CONVENIO,
DH_ADMISSAO,
ESCALA,
INTENSIDADE, 
DS_DOR,
DATA_COLETA,
DS_UNID_INT,
dense_rank() over (partition by CD_ATENDIMENTO order by CD_COLETA_SINAL_VITAL desc) ordem
 
FROM(
    SELECT DISTINCT 
        CSV.CD_ATENDIMENTO,
        DBAMV.FNC_MV_RECUPERA_DATA_HORA(ATE.DT_ATENDIMENTO, ATE.HR_ATENDIMENTO)DH_ADMISSAO,
        CSV.CD_COLETA_SINAL_VITAL,
        PAC.CD_PACIENTE,
        PAC.NM_PACIENTE,
        CNV.NM_CONVENIO,
        to_char (pac.DT_NASCIMENTO, 'dd/mm/yyyy') DT_NASCIMENTO,
        FN_IDADE(PAC.DT_NASCIMENTO, 'a') IDADE,
        DECODE(AVA.CD_FORMULA, 23, 'EVA', 49, 'NIPS', 50, 'BPS', 51, 'PAINAD', 52, 'FLACC', 56, 'COMFORT')ESCALA,
        --INTENSIDADES
        --EVA
        CASE 
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (4,5,6) THEN TO_CHAR(AVA.VL_RESULTADO) --DOR MODERADA
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR INTENSA
        --NIPS 
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (1,2) THEN NULL
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (3,4,5) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR MODERADA
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (6,7) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR INTENSA
        --BPS 
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (0,1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (4,5,6) THEN NULL
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (7,8) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR MODERADA
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (9,10,11,12) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR INTENSA
        --PAINAD 
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (4,5,6) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR MODERADA
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN TO_CHAR(AVA.VL_RESULTADO) --DOR INTENSA
        --FLACC 
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (4,5,6) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR MODERADA
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR INTENSA
        --COMFORT
        WHEN AVA.CD_FORMULA = 56 AND AVA.VL_RESULTADO BETWEEN 8 AND 20 THEN NULL
        WHEN AVA.CD_FORMULA = 56 AND AVA.VL_RESULTADO BETWEEN 21 AND 40 THEN TO_CHAR(AVA.VL_RESULTADO)--PRESEN�A DE DOR
        END INTENSIDADE,
        AVA.VL_RESULTADO,

        --DESCRI��O DA DOR
        --EVA
        CASE 
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (4,5,6) THEN 'Moderada' --DOR MODERADA
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN 'Intensa'--DOR INTENSA
        --NIPS 
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (1,2) THEN NULL
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (3,4,5) THEN 'Moderada'--DOR MODERADA
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (6,7) THEN 'Intensa'--DOR INTENSA
        --BPS 
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (0,1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (4,5,6) THEN NULL
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (7,8) THEN 'Moderada'--DOR MODERADA
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (9,10,11,12) THEN 'Intensa'--DOR INTENSA
        --PAINAD 
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (4,5,6) THEN 'Moderada'--DOR MODERADA
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN 'Intensa' --DOR INTENSA
        --FLACC 
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (4,5,6) THEN 'Moderada'--DOR MODERADA
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN 'Intensa'--DOR INTENSA
        --COMFORT
        WHEN AVA.CD_FORMULA = 56 AND AVA.VL_RESULTADO BETWEEN 8 AND 20 THEN NULL
        WHEN AVA.CD_FORMULA = 56 AND AVA.VL_RESULTADO BETWEEN 21 AND 40 THEN 'Presen�a de dor'--PRESEN�A DE DOR
        END DS_DOR,
        CSV.DATA_COLETA,

        --DESCRI��O DA UNIDADE DE INTERNA��O ONDE A AVALIA��O DA DOR FOI FEITA
        (SELECT U.DS_UNID_INT
        FROM DBAMV.UNID_INT U,
        DBAMV.LEITO L
        WHERE U.CD_UNID_INT = L.CD_UNID_INT
        AND L.CD_LEITO = DBAMV.FNCDES_REP_LEITO_ATENDIMENTO
        (CSV.CD_ATENDIMENTO,CSV.DATA_COLETA)) DS_UNID_INT

        FROM DBAMV.PAGU_AVALIACAO AVA,
        DBAMV.ATENDIME ATE,
        DBAMV.PACIENTE PAC,
        DBAMV.PW_DOCUMENTO_CLINICO PDC,
        DBAMV.COLETA_SINAL_VITAL CSV,
        DBAMV.CONVENIO CNV
        WHERE AVA.CD_COLETA_SINAL_VITAL = CSV.CD_COLETA_SINAL_VITAL
        AND CSV.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO
        AND ATE.CD_CONVENIO = CNV.CD_CONVENIO
        AND CSV.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
        AND ATE.CD_PACIENTE = PAC.CD_PACIENTE
        AND AVA.CD_FORMULA IN (
        23, --EVA
        49, --NIPS
        50, --BPS
        51, --PAINAD
        52, --FLACC
        56 --COMFORT
        )
        AND AVA.VL_RESULTADO IS NOT NULL --SOMENTE SINAIS VITAIS COM RESULTADOS DE DOR PREENCHIDOS
        AND PDC.TP_STATUS = 'FECHADO' --SOMENTE SINAIS VITAIS FECHADOS
        AND ATE.TP_ATENDIMENTO = 'I' --SOMENTE PACIENTES INTERNADOS
    )
WHERE DATA_COLETA >= SYSDATE - INTERVAL '1' DAY --olhar apenas para ultimas 24hrs
)base

WHERE ordem in (1)
--AND INTENSIDADE IS NOT NULL

order by NM_PACIENTE, ORDEM
)A
,(
Select * from (
SELECT 
CD_PACIENTE,
NM_PACIENTE,
DT_NASCIMENTO,
IDADE,
CD_ATENDIMENTO,
NM_CONVENIO,
DH_ADMISSAO,
ESCALA,
INTENSIDADE, 
DS_DOR,
DATA_COLETA,
DS_UNID_INT,
dense_rank() over (partition by CD_ATENDIMENTO order by CD_COLETA_SINAL_VITAL desc) ordem
 
FROM(
    SELECT DISTINCT 
        CSV.CD_ATENDIMENTO,
        DBAMV.FNC_MV_RECUPERA_DATA_HORA(ATE.DT_ATENDIMENTO, ATE.HR_ATENDIMENTO)DH_ADMISSAO,
        CSV.CD_COLETA_SINAL_VITAL,
        PAC.CD_PACIENTE,
        PAC.NM_PACIENTE,
        CNV.NM_CONVENIO,
        to_char (pac.DT_NASCIMENTO, 'dd/mm/yyyy') DT_NASCIMENTO,
        FN_IDADE(PAC.DT_NASCIMENTO, 'a') IDADE,
        DECODE(AVA.CD_FORMULA, 23, 'EVA', 49, 'NIPS', 50, 'BPS', 51, 'PAINAD', 52, 'FLACC', 56, 'COMFORT')ESCALA,
        --INTENSIDADES
        --EVA
        CASE 
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (4,5,6) THEN TO_CHAR(AVA.VL_RESULTADO) --DOR MODERADA
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR INTENSA
        --NIPS 
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (1,2) THEN NULL
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (3,4,5) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR MODERADA
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (6,7) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR INTENSA
        --BPS 
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (0,1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (4,5,6) THEN NULL
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (7,8) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR MODERADA
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (9,10,11,12) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR INTENSA
        --PAINAD 
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (4,5,6) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR MODERADA
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN TO_CHAR(AVA.VL_RESULTADO) --DOR INTENSA
        --FLACC 
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (4,5,6) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR MODERADA
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN TO_CHAR(AVA.VL_RESULTADO)--DOR INTENSA
        --COMFORT
        WHEN AVA.CD_FORMULA = 56 AND AVA.VL_RESULTADO BETWEEN 8 AND 20 THEN NULL
        WHEN AVA.CD_FORMULA = 56 AND AVA.VL_RESULTADO BETWEEN 21 AND 40 THEN TO_CHAR(AVA.VL_RESULTADO)--PRESEN�A DE DOR
        END INTENSIDADE,
        AVA.VL_RESULTADO,

        --DESCRI��O DA DOR
        --EVA
        CASE 
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (4,5,6) THEN 'Moderada' --DOR MODERADA
        WHEN AVA.CD_FORMULA = 23 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN 'Intensa'--DOR INTENSA
        --NIPS 
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (1,2) THEN NULL
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (3,4,5) THEN 'Moderada'--DOR MODERADA
        WHEN AVA.CD_FORMULA = 49 AND AVA.VL_RESULTADO IN (6,7) THEN 'Intensa'--DOR INTENSA
        --BPS 
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (0,1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (4,5,6) THEN NULL
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (7,8) THEN 'Moderada'--DOR MODERADA
        WHEN AVA.CD_FORMULA = 50 AND AVA.VL_RESULTADO IN (9,10,11,12) THEN 'Intensa'--DOR INTENSA
        --PAINAD 
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (4,5,6) THEN 'Moderada'--DOR MODERADA
        WHEN AVA.CD_FORMULA = 51 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN 'Intensa' --DOR INTENSA
        --FLACC 
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (0) THEN NULL
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (1,2,3) THEN NULL
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (4,5,6) THEN 'Moderada'--DOR MODERADA
        WHEN AVA.CD_FORMULA = 52 AND AVA.VL_RESULTADO IN (7,8,9,10) THEN 'Intensa'--DOR INTENSA
        --COMFORT
        WHEN AVA.CD_FORMULA = 56 AND AVA.VL_RESULTADO BETWEEN 8 AND 20 THEN NULL
        WHEN AVA.CD_FORMULA = 56 AND AVA.VL_RESULTADO BETWEEN 21 AND 40 THEN 'Presen�a de dor'--PRESEN�A DE DOR
        END DS_DOR,
        CSV.DATA_COLETA,

        --DESCRI��O DA UNIDADE DE INTERNA��O ONDE A AVALIA��O DA DOR FOI FEITA
        (SELECT U.DS_UNID_INT
        FROM DBAMV.UNID_INT U,
        DBAMV.LEITO L
        WHERE U.CD_UNID_INT = L.CD_UNID_INT
        AND L.CD_LEITO = DBAMV.FNCDES_REP_LEITO_ATENDIMENTO
        (CSV.CD_ATENDIMENTO,CSV.DATA_COLETA)) DS_UNID_INT

        FROM DBAMV.PAGU_AVALIACAO AVA,
        DBAMV.ATENDIME ATE,
        DBAMV.PACIENTE PAC,
        DBAMV.PW_DOCUMENTO_CLINICO PDC,
        DBAMV.COLETA_SINAL_VITAL CSV,
        DBAMV.CONVENIO CNV
        WHERE AVA.CD_COLETA_SINAL_VITAL = CSV.CD_COLETA_SINAL_VITAL
        AND CSV.CD_ATENDIMENTO = ATE.CD_ATENDIMENTO
        AND ATE.CD_CONVENIO = CNV.CD_CONVENIO
        AND CSV.CD_DOCUMENTO_CLINICO = PDC.CD_DOCUMENTO_CLINICO
        AND ATE.CD_PACIENTE = PAC.CD_PACIENTE
        AND AVA.CD_FORMULA IN (
        23, --EVA
        49, --NIPS
        50, --BPS
        51, --PAINAD
        52, --FLACC
        56 --COMFORT
        )
        AND AVA.VL_RESULTADO IS NOT NULL --SOMENTE SINAIS VITAIS COM RESULTADOS DE DOR PREENCHIDOS
        AND PDC.TP_STATUS = 'FECHADO' --SOMENTE SINAIS VITAIS FECHADOS
        AND ATE.TP_ATENDIMENTO = 'I' --SOMENTE PACIENTES INTERNADOS
    )
WHERE DATA_COLETA >= SYSDATE - INTERVAL '1' DAY --olhar apenas para ultimas 24hrs
)base

WHERE ordem in (2)
--AND INTENSIDADE IS NOT NULL

order by NM_PACIENTE, ORDEM
)B

WHERE A.CD_ATENDIMENTO = B.CD_ATENDIMENTO
AND A.INTENSIDADE IS NOT NULL