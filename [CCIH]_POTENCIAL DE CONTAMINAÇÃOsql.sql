SELECT
    DISTINCT -- 'NOVO' TIPO,
    DECODE(
        DOCUMENTO.GRAU_DE_CONTAMINACAO,
        '2||Potencialmente Contaminada',
        'POTENCIALMENTE CONTAMINADA',
        '3||Contaminada',
        'CONTAMINADA',
        '4||Infectada',
        'INFECTADA',
        '1||Limpa',
        'LIMPA',
        'NÃO REALIZADO'
    ) DS_POTENCIAL_CONTAMINACAO,
    DBAMV.AVISO_CIRURGIA.CD_AVISO_CIRURGIA,
    COUNT(DISTINCT(AVISO_CIRURGIA.CD_AVISO_CIRURGIA)) QTDE_CIRURGIA,
    NVL(SUM(QTD_INFEC), 0) QTDE_INFECCAO,
    ROUND((NVL(SUM(QTD_INFEC), 0) / COUNT(*)) * 100, 2) PERC
FROM
    (
        SELECT
            'DOCUMENTO' TIPO,
            -- COUNT(CD_ATENDIMENTO) TESTE
            GRAU_DE_CONTAMINACAO,
            CD_ATENDIMENTO,
            DH_CRIACAO
        FROM
            (
                SELECT
                    DISTINCT TRUNC(DC.DH_CRIACAO) DH_CRIACAO,
                    DC.CD_ATENDIMENTO,
                    DBMS_LOB.SUBSTR(ERC.LO_VALOR, 4000, 1) AS GRAU_DE_CONTAMINACAO
                FROM
                    PW_DOCUMENTO_CLINICO DC,
                    PW_EDITOR_CLINICO PEC,
                    EDITOR_REGISTRO_CAMPO ERC,
                    EDITOR_CAMPO EC
                WHERE
                    DC.CD_DOCUMENTO_CLINICO = PEC.CD_DOCUMENTO_CLINICO
                    AND PEC.CD_EDITOR_REGISTRO = ERC.CD_REGISTRO
                    AND ERC.CD_CAMPO = EC.CD_CAMPO
                    AND PEC.CD_DOCUMENTO = 564 --RELATÓRIO DE CIRURGIA
                    AND DC.TP_STATUS = 'FECHADO' -- AND TRUNC(DC.DH_CRIACAO) BETWEEN '01/06/2023' /*@P_DATAINICIAL*/
                    -- AND '12/08/2023'
                    AND TRUNC(DC.DH_CRIACAO) BETWEEN To_Date('01/04/2024', 'dd/mm/rrrr')
                    AND To_Date('30/04/2024', 'dd/mm/rrrr') + 0.99999 --AND DC.CD_ATENDIMENTO = 3747834
                    AND EC.DS_IDENTIFICADOR IN ('CB_graudecontaminacao_1')
                    AND ERC.LO_VALOR IS NOT NULL
            ) --GROUP BY GRAU_DE_CONTAMINAÇÃO
    ) DOCUMENTO,
    DBAMV.AVISO_CIRURGIA,
    DBAMV.CIRURGIA_AVISO,
    DBAMV.REG_INF RI,
    (
        SELECT
            AVISO_CIRURGIA.CD_ATENDIMENTO,
            AVISO_CIRURGIA.CD_AVISO_CIRURGIA,
            CIRURGIA_AVISO.TP_NATUREZA,
            COUNT(DISTINCT REG_INF.CD_REG_INF) QTD_INFEC
        FROM
            DBAMV.REG_INF,
            DBAMV.AVISO_CIRURGIA,
            DBAMV.CIRURGIA_AVISO
        WHERE
            REG_INF.CD_AVISO_CIRURGIA = AVISO_CIRURGIA.CD_AVISO_CIRURGIA
            AND AVISO_CIRURGIA.CD_AVISO_CIRURGIA = CIRURGIA_AVISO.CD_AVISO_CIRURGIA
            AND REG_INF.TP_SIT IN ('T', 'S', 'N', 'C')
            AND AVISO_CIRURGIA.TP_SITUACAO = 'R'
            AND CIRURGIA_AVISO.SN_PRINCIPAL = 'S' --AND AVISO_CIRURGIA.CD_ATENDIMENTO = 3747834
            /* AND REG_INF.DT_REG_INF BETWEEN
             TO_DATE('01/06/2023', 'dd/mm/rrrr') AND
             TO_DATE('12/08/2023', 'dd/mm/rrrr') + 0.99999 */
            AND Reg_Inf.Dt_Reg_Inf BETWEEN To_Date('01/04/2024', 'dd/mm/rrrr')
            AND To_Date('30/04/2024', 'dd/mm/rrrr') + 0.99999
        GROUP BY
            AVISO_CIRURGIA.CD_ATENDIMENTO,
            AVISO_CIRURGIA.CD_AVISO_CIRURGIA,
            CIRURGIA_AVISO.TP_NATUREZA
    ) INFEC_NATUREZA
WHERE
    DOCUMENTO.CD_ATENDIMENTO(+) = AVISO_CIRURGIA.CD_ATENDIMENTO
    AND AVISO_CIRURGIA.CD_AVISO_CIRURGIA = CIRURGIA_AVISO.CD_AVISO_CIRURGIA --AND AVISO_CIRURGIA.CD_ATENDIMENTO = 3747834
    --AND TRUNC(AVISO_CIRURGIA.DT_REALIZACAO) = DOCUMENTO.DH_CRIACAO(+)
    AND AVISO_CIRURGIA.CD_AVISO_CIRURGIA = INFEC_NATUREZA.CD_AVISO_CIRURGIA(+)
    AND AVISO_CIRURGIA.CD_ATENDIMENTO = INFEC_NATUREZA.CD_ATENDIMENTO(+)
    AND CIRURGIA_AVISO.TP_NATUREZA = INFEC_NATUREZA.TP_NATUREZA(+) --AND DOCUMENTO.CD_ATENDIMENTO = 3747834
    AND AVISO_CIRURGIA.TP_SITUACAO = 'R'
    AND CIRURGIA_AVISO.SN_PRINCIPAL = 'S'
    /* AND AVISO_CIRURGIA.CD_MULTI_EMPRESA IN (1)
     AND CIRURGIA_AVISO.CD_ESPECIALID IN (47,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,50,51,52,18,17,54,48,49,53,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,55,72,73,0,99,79,83,85,86,81,87,92,94,95,88,74,75,76,77,78,80,82,91,84,93,90)
     AND NVL(CIRURGIA_AVISO.TP_NATUREZA,'N') IN ('C','I','L','N','P')
     AND (AVISO_CIRURGIA.DT_REALIZACAO BETWEEN TO_DATE('01/06/2023', 'dd/mm/rrrr') AND TO_DATE('12/08/2023', 'dd/mm/rrrr') + 0.99999 ) */
    AND aviso_cirurgia.cd_multi_empresa IN (1)
    AND cirurgia_aviso.cd_especialid IN (
        47,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        19,
        20,
        21,
        22,
        23,
        24,
        25,
        26,
        27,
        28,
        29,
        30,
        31,
        32,
        33,
        34,
        35,
        36,
        37,
        38,
        39,
        40,
        41,
        42,
        43,
        44,
        45,
        46,
        50,
        51,
        52,
        18,
        17,
        54,
        48,
        49,
        53,
        56,
        57,
        58,
        59,
        60,
        61,
        62,
        63,
        64,
        65,
        66,
        67,
        68,
        69,
        70,
        71,
        55,
        72,
        73,
        0,
        99,
        79,
        83,
        85,
        86,
        96,
        97,
        98,
        81,
        87,
        92,
        94,
        95,
        88,
        89,
        74,
        75,
        76,
        77,
        78,
        80,
        82,
        91,
        84,
        93,
        90
    )
    AND NVL(cirurgia_aviso.tp_natureza, 'N') IN ('C', 'I', 'L', 'N', 'P')
    AND aviso_cirurgia.dt_realizacao BETWEEN To_Date('01/04/2024', 'dd/mm/rrrr')
    AND To_Date('30/04/2024', 'dd/mm/rrrr') + 0.99999 -- AND DOCUMENTO.CD_ATENDIMENTO IS NULL
GROUP BY
    DECODE(
        DOCUMENTO.GRAU_DE_CONTAMINACAO,
        '2||Potencialmente Contaminada',
        'POTENCIALMENTE CONTAMINADA',
        '3||Contaminada',
        'CONTAMINADA',
        '4||Infectada',
        'INFECTADA',
        '1||Limpa',
        'LIMPA',
        'NÃO REALIZADO'
    ),
    DBAMV.AVISO_CIRURGIA.CD_AVISO_CIRURGIA