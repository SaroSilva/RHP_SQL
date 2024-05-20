SELECT
  CASE
    WHEN LENGTH(DECODE(INTERVAL_TOTEM_RECEP_FIM,':',NULL,INTERVAL_TOTEM_RECEP_FIM)) = 4
    THEN '0'
      ||DECODE(INTERVAL_TOTEM_RECEP_FIM,':',NULL,INTERVAL_TOTEM_RECEP_FIM)
    ELSE DECODE(INTERVAL_TOTEM_RECEP_FIM,':',NULL,INTERVAL_TOTEM_RECEP_FIM)
  END AS INTERVAL_TOTEM_RECEP_FIM,
  CASE
    WHEN LENGTH(DECODE(INTERVAL_TOTEM_RECEP_INI,':',NULL,INTERVAL_TOTEM_RECEP_INI)) = 4
    THEN '0'
      ||DECODE(INTERVAL_TOTEM_RECEP_INI,':',NULL,INTERVAL_TOTEM_RECEP_INI)
    ELSE DECODE(INTERVAL_TOTEM_RECEP_INI,':',NULL,INTERVAL_TOTEM_RECEP_INI)
  END AS INTERVAL_TOTEM_RECEP_INI,
  CASE
    WHEN LENGTH(DECODE(INTERVAL_RECEP_INI_FIM,':',NULL,INTERVAL_RECEP_INI_FIM)) = 4
    THEN '0'
      ||DECODE(INTERVAL_RECEP_INI_FIM,':',NULL,INTERVAL_RECEP_INI_FIM)
    ELSE DECODE(INTERVAL_RECEP_INI_FIM,':',NULL,INTERVAL_RECEP_INI_FIM)
  END AS INTERVAL_RECEP_INI_FIM,
  CASE
    WHEN LENGTH(DECODE(INTERVAL_MEDIA_TOTEM_RECEP_INI,':',NULL,INTERVAL_MEDIA_TOTEM_RECEP_INI)) = 4
    THEN '0'
      ||DECODE(INTERVAL_MEDIA_TOTEM_RECEP_INI,':',NULL,INTERVAL_MEDIA_TOTEM_RECEP_INI)
    ELSE DECODE(INTERVAL_MEDIA_TOTEM_RECEP_INI,':',NULL,INTERVAL_MEDIA_TOTEM_RECEP_INI)
  END AS INTERVAL_MEDIA_TOTEM_RECEP_INI,
  CASE
    WHEN LENGTH(DECODE(INTERVAL_MEDIA_RECEP_INI_FIM,':',NULL,INTERVAL_MEDIA_RECEP_INI_FIM)) = 4
    THEN '0'
      ||DECODE(INTERVAL_MEDIA_RECEP_INI_FIM,':',NULL,INTERVAL_MEDIA_RECEP_INI_FIM)
    ELSE DECODE(INTERVAL_MEDIA_RECEP_INI_FIM,':',NULL,INTERVAL_MEDIA_RECEP_INI_FIM)
  END AS INTERVAL_MEDIA_RECEP_INI_FIM,
  CASE
    WHEN LENGTH(DECODE(INTERVAL_MEDIA_TOTEM_RECEP_FIM,':',NULL,INTERVAL_MEDIA_TOTEM_RECEP_FIM)) = 4
    THEN '0'
      ||DECODE(INTERVAL_MEDIA_TOTEM_RECEP_FIM,':',NULL,INTERVAL_MEDIA_TOTEM_RECEP_FIM)
    ELSE DECODE(INTERVAL_MEDIA_TOTEM_RECEP_FIM,':',NULL,INTERVAL_MEDIA_TOTEM_RECEP_FIM)
  END AS INTERVAL_MEDIA_TOTEM_RECEP_FIM,
  SOMA_TOTEM_RECEP_INI,
  SOMA_RECEP_INI_FIM,
  SOMA_TOTEM_RECEP_FIM,
  MEDIA_TOTEM_RECEP_INI,
  MEDIA_RECEP_INI_FIM,
  MEDIA_TOTEM_RECEP_FIM,
  TOTAL_S_TOTEM_RECEP_INI,
  TOTAL_S_RECEP_INI_FIM,
  TOTAL_S_TOTEM_RECEP_FIM,
  TOTAL_MMM_TOTEM_RECEP_INI,
  TOTAL_MMM_RECEP_INI_FIM,
  TOTAL_MMM_TOTEM_RECEP_FIM,
  TOTAL_S_TOTEM_RECEP_INI2,
  TOTAL_S_RECEP_INI_FIM2,
  TOTAL_S_TOTEM_RECEP_FIM2,
  TOTAL_MMM_TOTEM_RECEP_INI2,
  TOTAL_MMM_RECEP_INI_FIM2,
  TOTAL_MMM_TOTEM_RECEP_FIM2,
  RECEP_INI_FIM,
  TOTEM_RECEP_INI,
  TOTEM_RECEP_FIM,
  SENHA,
  CD_CLASSIFICACAO,
  CD_FILA_SENHA,
  DS_FILA,
  PACIENTE,
  TRIAGEM,
  DH_REMOVIDO,
  CD_ATENDIMENTO,
  NM_USUARIO,
  DS_LEITO,
  SN_EXTRA,
  DS_ORI_ATE,
  CD_ORI_ATE,
  TP_ATENDIMENTO,
  DS_UNID_INT,
  CD_UNID_INT,
  RETIRADA_TOTEM,
  RECEP_CHAMADA,
  RECEP_INICIO,
  RECEP_FIM,
  LEITO_VIRTUAL,
  SAIDA_LEITO_VIRTUAL,
  MIN_TOTEM_A_RECEP_INICIO,
  RETIRADA_TOTEM_A_RECEP_INICIO,
  RECEP_INICIO_A_RECEP_FIM,
  CHEC_RECEP_INICIO_A_RECEP_FIM,
  RETIRADA_TOTEM_A_RECEP_FIM,
  CHEC_RETIRA_TOTEM_A_RECEP_FIM,
  LEITO_VIRTUAL_Inicio_a_Fim
FROM
  (SELECT EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(SOMA_TOTEM_RECEP_FIM), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(SOMA_TOTEM_RECEP_FIM), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE)                                              + NUMTODSINTERVAL (MAX(SOMA_TOTEM_RECEP_FIM), 'MINUTE'),'MI') AS INTERVAL_TOTEM_RECEP_FIM,
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(SOMA_TOTEM_RECEP_INI), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(SOMA_TOTEM_RECEP_INI), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE)                                            + NUMTODSINTERVAL (MAX(SOMA_TOTEM_RECEP_INI), 'MINUTE'),'MI') AS INTERVAL_TOTEM_RECEP_INI,
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(SOMA_RECEP_INI_FIM), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(SOMA_RECEP_INI_FIM), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE) + NUMTODSINTERVAL (MAX(SOMA_RECEP_INI_FIM), 'MINUTE'),'MI') AS INTERVAL_RECEP_INI_FIM,
    ----------------------------------------
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(MEDIA_TOTEM_RECEP_INI), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(MEDIA_TOTEM_RECEP_INI), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE)                                             + NUMTODSINTERVAL (MAX(MEDIA_TOTEM_RECEP_INI), 'MINUTE'),'MI') AS INTERVAL_MEDIA_TOTEM_RECEP_INI,
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(MEDIA_RECEP_INI_FIM), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(MEDIA_RECEP_INI_FIM), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE)                                               + NUMTODSINTERVAL (MAX(MEDIA_RECEP_INI_FIM), 'MINUTE'),'MI') AS INTERVAL_MEDIA_RECEP_INI_FIM,
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(MEDIA_TOTEM_RECEP_FIM), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(MEDIA_TOTEM_RECEP_FIM), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE) + NUMTODSINTERVAL (MAX(MEDIA_TOTEM_RECEP_FIM), 'MINUTE'),'MI') AS INTERVAL_MEDIA_TOTEM_RECEP_FIM,
    -----------------------------------------
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(TOTAL_S_TOTEM_RECEP_INI), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(TOTAL_S_TOTEM_RECEP_INI), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE)                                               + NUMTODSINTERVAL (MAX(TOTAL_S_TOTEM_RECEP_INI), 'MINUTE'),'MI') AS TOTAL_S_TOTEM_RECEP_INI,
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(TOTAL_S_RECEP_INI_FIM), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(TOTAL_S_RECEP_INI_FIM), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE)                                                 + NUMTODSINTERVAL (MAX(TOTAL_S_RECEP_INI_FIM), 'MINUTE'),'MI') AS TOTAL_S_RECEP_INI_FIM,
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(TOTAL_S_TOTEM_RECEP_FIM), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(TOTAL_S_TOTEM_RECEP_FIM), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE) + NUMTODSINTERVAL (MAX(TOTAL_S_TOTEM_RECEP_FIM), 'MINUTE'),'MI') AS TOTAL_S_TOTEM_RECEP_FIM,
    -----------------------------------------
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(TOTAL_MMM_TOTEM_RECEP_INI), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(TOTAL_MMM_TOTEM_RECEP_INI), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE)                                                 + NUMTODSINTERVAL (MAX(TOTAL_MMM_TOTEM_RECEP_INI), 'MINUTE'),'MI') AS TOTAL_MMM_TOTEM_RECEP_INI,
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(TOTAL_MMM_RECEP_INI_FIM), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(TOTAL_MMM_RECEP_INI_FIM), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE)                                                   + NUMTODSINTERVAL (MAX(TOTAL_MMM_RECEP_INI_FIM), 'MINUTE'),'MI') AS TOTAL_MMM_RECEP_INI_FIM,
    EXTRACT(HOUR FROM NUMTODSINTERVAL (MAX(TOTAL_MMM_TOTEM_RECEP_FIM), 'MINUTE')) + (EXTRACT(DAY FROM NUMTODSINTERVAL (MAX(TOTAL_MMM_TOTEM_RECEP_FIM), 'MINUTE'))*24)
    || ':'
    || TO_CHAR (TRUNC (SYSDATE) + NUMTODSINTERVAL (MAX(TOTAL_MMM_TOTEM_RECEP_FIM), 'MINUTE'),'MI') AS TOTAL_MMM_TOTEM_RECEP_FIM,
    RECEP_INI_FIM,
    TOTEM_RECEP_INI,
    TOTEM_RECEP_FIM,
    SENHA,
    CD_CLASSIFICACAO,
    CD_FILA_SENHA,
    DS_FILA,
    PACIENTE,
    TRIAGEM,
    DH_REMOVIDO,
    CD_ATENDIMENTO,
    NM_USUARIO,
    DS_LEITO,
    SN_EXTRA,
    DS_ORI_ATE,
    CD_ORI_ATE,
    TP_ATENDIMENTO,
    DS_UNID_INT,
    CD_UNID_INT,
    RETIRADA_TOTEM,
    RECEP_CHAMADA,
    RECEP_INICIO,
    RECEP_FIM,
    LEITO_VIRTUAL,
    SAIDA_LEITO_VIRTUAL,
    MIN_TOTEM_A_RECEP_INICIO,
    RETIRADA_TOTEM_A_RECEP_INICIO,
    RECEP_INICIO_A_RECEP_FIM,
    CHEC_RECEP_INICIO_A_RECEP_FIM,
    RETIRADA_TOTEM_A_RECEP_FIM,
    CHEC_RETIRA_TOTEM_A_RECEP_FIM,
    LEITO_VIRTUAL_Inicio_a_Fim,
    SOMA_TOTEM_RECEP_INI,
    SOMA_RECEP_INI_FIM,
    SOMA_TOTEM_RECEP_FIM,
    MEDIA_TOTEM_RECEP_INI,
    MEDIA_RECEP_INI_FIM,
    MEDIA_TOTEM_RECEP_FIM,
    TOTAL_S_TOTEM_RECEP_INI   AS TOTAL_S_TOTEM_RECEP_INI2,
    TOTAL_S_RECEP_INI_FIM     AS TOTAL_S_RECEP_INI_FIM2,
    TOTAL_S_TOTEM_RECEP_FIM   AS TOTAL_S_TOTEM_RECEP_FIM2,
    TOTAL_MMM_TOTEM_RECEP_INI AS TOTAL_MMM_TOTEM_RECEP_INI2,
    TOTAL_MMM_RECEP_INI_FIM   AS TOTAL_MMM_RECEP_INI_FIM2,
    TOTAL_MMM_TOTEM_RECEP_FIM AS TOTAL_MMM_TOTEM_RECEP_FIM2
  FROM
    (SELECT RECEP_INI_FIM,
      TOTEM_RECEP_INI,
      TOTEM_RECEP_FIM,
      SENHA,
      CD_CLASSIFICACAO,
      CD_FILA_SENHA,
      DS_FILA,
      PACIENTE,
      TRIAGEM,
      DH_REMOVIDO,
      CD_ATENDIMENTO,
      NM_USUARIO,
      DS_LEITO,
      SN_EXTRA,
      DS_ORI_ATE,
      CD_ORI_ATE,
      TP_ATENDIMENTO,
      DS_UNID_INT,
      CD_UNID_INT,
      RETIRADA_TOTEM,
      RECEP_CHAMADA,
      RECEP_INICIO,
      RECEP_FIM,
      LEITO_VIRTUAL,
      SAIDA_LEITO_VIRTUAL,
      MIN_TOTEM_A_RECEP_INICIO,
      RETIRADA_TOTEM_A_RECEP_INICIO,
      RECEP_INICIO_A_RECEP_FIM,
      CHEC_RECEP_INICIO_A_RECEP_FIM,
      RETIRADA_TOTEM_A_RECEP_FIM,
      CHEC_RETIRA_TOTEM_A_RECEP_FIM,
      LEITO_VIRTUAL_Inicio_a_Fim,
      SUM(TOTEM_RECEP_INI) OVER (PARTITION BY DS_FILA ORDER BY DS_FILA)          AS SOMA_TOTEM_RECEP_INI,
      SUM(RECEP_INI_FIM) OVER (PARTITION BY DS_FILA ORDER BY DS_FILA)            AS SOMA_RECEP_INI_FIM,
      SUM(TOTEM_RECEP_FIM) OVER (PARTITION BY DS_FILA ORDER BY DS_FILA)          AS SOMA_TOTEM_RECEP_FIM,
      ROUND(AVG(TOTEM_RECEP_INI) OVER (PARTITION BY DS_FILA ORDER BY DS_FILA),0) AS MEDIA_TOTEM_RECEP_INI,
      ROUND(AVG(RECEP_INI_FIM) OVER (PARTITION BY DS_FILA ORDER BY DS_FILA),0)   AS MEDIA_RECEP_INI_FIM,
      ROUND(AVG(TOTEM_RECEP_FIM) OVER (PARTITION BY DS_FILA ORDER BY DS_FILA),0) AS MEDIA_TOTEM_RECEP_FIM,
      SUM(TOTEM_RECEP_INI) OVER (PARTITION BY tt ORDER BY tt)                    AS TOTAL_S_TOTEM_RECEP_INI,
      SUM(RECEP_INI_FIM) OVER (PARTITION BY tt ORDER BY tt)                      AS TOTAL_S_RECEP_INI_FIM,
      SUM(TOTEM_RECEP_FIM) OVER (PARTITION BY tt ORDER BY tt)                    AS TOTAL_S_TOTEM_RECEP_FIM,
      ROUND(AVG(TOTEM_RECEP_INI) OVER (PARTITION BY tt ORDER BY tt),0)           AS TOTAL_MMM_TOTEM_RECEP_INI,
      ROUND(AVG(RECEP_INI_FIM) OVER (PARTITION BY tt ORDER BY tt),0)             AS TOTAL_MMM_RECEP_INI_FIM,
      ROUND(AVG(TOTEM_RECEP_FIM) OVER (PARTITION BY tt ORDER BY tt),0)           AS TOTAL_MMM_TOTEM_RECEP_FIM
    FROM
      (SELECT SENHA,
        CD_CLASSIFICACAO,
        CD_FILA_SENHA,
        DS_FILA,
        PACIENTE,
        TRIAGEM,
        DH_REMOVIDO,
        CD_ATENDIMENTO,
        NM_USUARIO,
        NOMEUSU,
        DS_LEITO,
        SN_EXTRA,
        DS_ORI_ATE,
        CD_ORI_ATE,
        TP_ATENDIMENTO,
        DS_UNID_INT,
        CD_UNID_INT,
        RETIRADA_TOTEM,
        --recep_class_chamada,
        --recep_class_ini,
        --recep_class_final,
        RECEP_CHAMADA,
        RECEP_INICIO,
        RECEP_FIM,
        LEITO_VIRTUAL,
        SAIDA_LEITO_VIRTUAL,
        1 AS tt,
        --atend_med_chamada,
        --atend_med_inicio,
        --atend_med_final,
        ((recep_inicio                         - Retirada_Totem) * 1440)+ (
        (SELECT ROUND((SUBSTR(recep_inicio,0,2)*60)+(SUBSTR(recep_inicio,4,2)*60/60)+(SUBSTR(recep_inicio,7,2)/60),2) AS MINUTOS_TOTAIS
        FROM DUAL
        )                                        -
        (SELECT ROUND((SUBSTR(Retirada_Totem,0,2)*60)+(SUBSTR(Retirada_Totem,4,2)*60/60)+(SUBSTR(Retirada_Totem,7,2)/60),2) AS MINUTOS_TOTAIS
        FROM DUAL
        )) AS TOTEM_RECEP_INI,
        ((recep_fim                         - recep_inicio) * 1440)+ (
        (SELECT ROUND((SUBSTR(recep_fim,0,2)*60)+(SUBSTR(recep_fim,4,2)*60/60)+(SUBSTR(recep_fim,7,2)/60),2) AS MINUTOS_TOTAIS
        FROM DUAL
        )                                      -
        (SELECT ROUND((SUBSTR(recep_inicio,0,2)*60)+(SUBSTR(recep_inicio,4,2)*60/60)+(SUBSTR(recep_inicio,7,2)/60),2) AS MINUTOS_TOTAIS
        FROM DUAL
        )) AS RECEP_INI_FIM,
        ((recep_fim                         - Retirada_Totem) * 1440)+ (
        (SELECT ROUND((SUBSTR(recep_fim,0,2)*60)+(SUBSTR(recep_fim,4,2)*60/60)+(SUBSTR(recep_fim,7,2)/60),2) AS MINUTOS_TOTAIS
        FROM DUAL
        )                                        -
        (SELECT ROUND((SUBSTR(Retirada_Totem,0,2)*60)+(SUBSTR(Retirada_Totem,4,2)*60/60)+(SUBSTR(Retirada_Totem,7,2)/60),2) AS MINUTOS_TOTAIS
        FROM DUAL
        )) AS TOTEM_RECEP_FIM,
        --Pegando tempo de Atendimento
        --Para poder calcular a média
        ROUND((recep_inicio                 - Retirada_Totem)*24*60) min_Totem_a_Recep_Inicio,
        ((recep_fim                         - recep_inicio) * 1440)+ (
        (SELECT ROUND((SUBSTR(recep_fim,0,2)*60)+(SUBSTR(recep_fim,4,2)*60/60)+(SUBSTR(recep_fim,7,2)/60),2) AS MINUTOS_TOTAIS
        FROM DUAL
        )                                      -
        (SELECT ROUND((SUBSTR(recep_inicio,0,2)*60)+(SUBSTR(recep_inicio,4,2)*60/60)+(SUBSTR(recep_inicio,7,2)/60),2) AS MINUTOS_TOTAIS
        FROM DUAL
        )) AS MINUTOS_TOTAIS,
        CASE
          WHEN recep_inicio  IS NOT NULL
          AND Retirada_Totem IS NOT NULL
          THEN (SUBSTR(CAST(recep_inicio AS TIMESTAMP)- CAST ( Retirada_Totem AS TIMESTAMP) ,12,2 )
            || ':'
            || SUBSTR(CAST(recep_inicio AS TIMESTAMP)- CAST ( Retirada_Totem AS TIMESTAMP) ,15,2) )
        END AS Retirada_Totem_a_Recep_Inicio,
        CASE
          WHEN recep_fim   IS NOT NULL
          AND recep_inicio IS NOT NULL
          THEN (SUBSTR(CAST(recep_fim AS TIMESTAMP)- CAST ( recep_inicio AS TIMESTAMP) ,12,2 )
            || ':'
            || SUBSTR(CAST(recep_fim AS TIMESTAMP)- CAST ( recep_inicio AS TIMESTAMP) ,15,2) )
        END AS Recep_Inicio_a_Recep_Fim,
        CASE
          WHEN (SUBSTR(CAST(recep_fim AS TIMESTAMP)- CAST ( recep_inicio AS TIMESTAMP) ,12,2 )
            || ':'
            || SUBSTR(CAST(recep_fim AS TIMESTAMP)- CAST ( recep_inicio AS TIMESTAMP) ,15,2) ) >= '00:05'
          AND (recep_fim                                                                       IS NOT NULL
          AND recep_inicio                                                                     IS NOT NULL)
          THEN 1
          ELSE 0
        END AS chec_Recep_Inicio_a_Recep_Fim,
        CASE
          WHEN recep_fim     IS NOT NULL
          AND Retirada_Totem IS NOT NULL
          THEN (SUBSTR(CAST(recep_fim AS TIMESTAMP)- CAST ( Retirada_Totem AS TIMESTAMP) ,12,2 )
            || ':'
            || SUBSTR(CAST(recep_fim AS TIMESTAMP)- CAST ( Retirada_Totem AS TIMESTAMP) ,15,2) )
        END AS Retirada_Totem_a_Recep_Fim,
        CASE
          WHEN (SUBSTR(CAST(recep_fim AS TIMESTAMP)- CAST ( Retirada_Totem AS TIMESTAMP) ,12,2 )
            || ':'
            || SUBSTR(CAST(recep_fim AS TIMESTAMP)- CAST ( Retirada_Totem AS TIMESTAMP) ,15,2) ) >= '00:10'
          AND (recep_fim                                                                         IS NOT NULL
          AND Retirada_Totem                                                                     IS NOT NULL)
          THEN 1
          ELSE 0
        END AS chec_Retira_Totem_a_Recep_Fim,
        SUBSTR(CAST(SAIDA_LEITO_VIRTUAL AS TIMESTAMP)- CAST ( LEITO_VIRTUAL AS TIMESTAMP) ,12,2 )
        || ':'
        || SUBSTR(CAST(SAIDA_LEITO_VIRTUAL AS TIMESTAMP)- CAST ( LEITO_VIRTUAL AS TIMESTAMP) ,15,2) LEITO_VIRTUAL_Inicio_a_Fim
      FROM
        (SELECT TA.DS_SENHA SENHA,
          TA.CD_CLASSIFICACAO,
          TA.CD_FILA_SENHA,
          FS.DS_FILA,
          TA.NM_PACIENTE PACIENTE,
          TA.CD_TRIAGEM_ATENDIMENTO TRIAGEM,
          TA.DH_REMOVIDO,
          TA.CD_ATENDIMENTO,
          ATE.NM_USUARIO,
          USU.NM_USUARIO NOMEUSU,
          L.DS_LEITO,
          L.SN_EXTRA,
          OA.DS_ORI_ATE,
          OA.CD_ORI_ATE,
          ATE.TP_ATENDIMENTO,
          U.DS_UNID_INT,
          U.CD_UNID_INT,
          TO_DATE( (TO_CHAR(dh_pre_atendimento,'DD/MM/YYYY')
          || ' '
          || TO_CHAR(dh_pre_atendimento,'HH24:MI')),'DD/MM/YYYY HH24:MI' )AS Retirada_Totem,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (10)
          ) AS recep_class_chamada,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (11)
          ) AS recep_class_ini,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (12)
          ) AS recep_class_final,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (20)
          ) AS recep_chamada,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (21)
          ) AS recep_inicio,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (22)
          ) AS recep_fim,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (30)
          ) AS atend_med_chamada,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (31)
          ) AS atend_med_inicio,
          (SELECT TO_DATE( (TO_CHAR(clas_chm.dh_processo,'DD/MM/YYYY')
            || ' '
            || TO_CHAR(clas_chm.dh_processo,'HH24:MI')),'DD/MM/YYYY HH24:MI' )
          FROM sacr_tempo_processo clas_chm
          WHERE clas_chm.cd_atendimento        = ate.cd_atendimento
          AND clas_chm.cd_tipo_tempo_processo IN (32)
          ) AS atend_med_final,
          FNC_MV_RECUPERA_DATA_HORA (MI.DT_MOV_INT, MI.HR_MOV_INT ) LEITO_VIRTUAL,
          FNC_MV_RECUPERA_DATA_HORA (MI.DT_LIB_MOV, MI.HR_LIB_MOV ) SAIDA_LEITO_VIRTUAL
        FROM DBAMV.SACR_TEMPO_PROCESSO ST1,
          DBAMV.TRIAGEM_ATENDIMENTO TA,
          DBAMV.FILA_SENHA FS,
          DBAMV.VDES_USUARIOS USU,
          DBAMV.ATENDIME ATE,
          DBAMV.LEITO L,
          DBAMV.ORI_ATE OA,
          DBAMV.UNID_INT U,
          DBAMV.MOV_INT MI
        WHERE TA.CD_TRIAGEM_ATENDIMENTO = ST1.CD_TRIAGEM_ATENDIMENTO(+)
        AND TA.CD_ATENDIMENTO(+)        = ATE.CD_ATENDIMENTO
        AND ATE.CD_ATENDIMENTO          = MI.CD_ATENDIMENTO
        AND ATE.NM_USUARIO              = USU.CD_USUARIO
        AND TA.CD_FILA_SENHA            = FS.CD_FILA_SENHA(+)
        AND L.CD_LEITO(+)               = MI.CD_LEITO
        AND OA.CD_ORI_ATE               = ATE.CD_ORI_ATE
        AND U.CD_UNID_INT(+)            = L.CD_UNID_INT
        AND MI.TP_MOV                  IN ('I','O')
          ----FILTROS----
        AND TA.DS_OBSERVACAO_REMOVIDO IS NULL
        AND TA.CD_USUARIO_REMOVEU     IS NULL
        AND ATE.TP_ATENDIMENTO        IN ('I')
        AND L.SN_EXTRA                 = 'S'
        AND U.CD_UNID_INT             IN (1,2,45,46,91)
        AND U.CD_SETOR                IN (234,286,283,250,874)
          -- AND TA.CD_FILA_SENHA IN({AUX_FILA})
          --AND TO_DATE(TA.DH_PRE_ATENDIMENTO,'DD/MM/RRRR ') BETWEEN TO_DATE(@DATA_INI,'DD/MM/RRRR')AND  TO_DATE(@DATA_FIM,'DD/MM/RRRR')
        --AND TRUNC(TA.DH_PRE_ATENDIMENTO) > SYSDATE-1
        AND ST1.CD_TIPO_TEMPO_PROCESSO IN (1) -- CADASTRO TOTEM
        )
      WHERE CD_ATENDIMENTO IS NOT NUL
      )
    )
  GROUP BY RECEP_INI_FIM,
    TOTEM_RECEP_INI,
    TOTEM_RECEP_FIM,
    SENHA,
    CD_CLASSIFICACAO,
    CD_FILA_SENHA,
    DS_FILA,
    PACIENTE,
    TRIAGEM,
    DH_REMOVIDO,
    CD_ATENDIMENTO,
    NM_USUARIO,
    DS_LEITO,
    SN_EXTRA,
    DS_ORI_ATE,
    CD_ORI_ATE,
    TP_ATENDIMENTO,
    DS_UNID_INT,
    CD_UNID_INT,
    RETIRADA_TOTEM,
    RECEP_CHAMADA,
    RECEP_INICIO,
    RECEP_FIM,
    LEITO_VIRTUAL,
    SAIDA_LEITO_VIRTUAL,
    MIN_TOTEM_A_RECEP_INICIO,
    RETIRADA_TOTEM_A_RECEP_INICIO,
    RECEP_INICIO_A_RECEP_FIM,
    CHEC_RECEP_INICIO_A_RECEP_FIM,
    RETIRADA_TOTEM_A_RECEP_FIM,
    CHEC_RETIRA_TOTEM_A_RECEP_FIM,
    LEITO_VIRTUAL_Inicio_a_Fim,
    SOMA_TOTEM_RECEP_INI,
    SOMA_RECEP_INI_FIM,
    SOMA_TOTEM_RECEP_FIM,
    MEDIA_TOTEM_RECEP_INI,
    MEDIA_RECEP_INI_FIM,
    MEDIA_TOTEM_RECEP_FIM,
    TOTAL_S_TOTEM_RECEP_INI,
    TOTAL_S_RECEP_INI_FIM,
    TOTAL_S_TOTEM_RECEP_FIM,
    TOTAL_MMM_TOTEM_RECEP_INI,
    TOTAL_MMM_RECEP_INI_FIM,
    TOTAL_MMM_TOTEM_RECEP_FIM
  )
ORDER BY CD_ATENDIMENTO DESC