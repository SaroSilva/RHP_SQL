SELECT *
FROM(
SELECT * FROM
(
SELECT 
*
FROM(
    SELECT
        DISTINCT 
        --UPPER (C.DS_CAMPO) DS_CAMPO
        'TELA 1' TIPO
        , C.CD_METADADO
        ,RC.CD_REGISTRO
        ,DBMS_LOB.SUBSTR(RC.lo_conteudo,4000,1) DADO
 
        FROM
         EDITOR.EDITOR_REGISTRO_CAMPO RC
        ,EDITOR.EDITOR_CAMPO C
        ,EDITOR.EDITOR_REGISTRO R
        ,EDITOR.EDITOR_LAYOUT L
        ,EDITOR.EDITOR_VERSAO_DOCUMENTO VD
 
 
        WHERE RC.CD_CAMPO = C.CD_CAMPO
        AND RC.CD_REGISTRO = R.CD_REGISTRO
        AND R.CD_LAYOUT = L.CD_LAYOUT
        AND L.CD_VERSAO_DOCUMENTO = VD.CD_VERSAO_DOCUMENTO
 
        AND VD.CD_DOCUMENTO = 1
        AND CD_METADADO IN ('83', '67', '64505', '76', '66057', '66451', '66669', '66680', '64401', '66060', '64798', '64801', '64804', '68', '78', '51', '55', '52', '74', 
        '66648', '66663', '66691', '66685', '72', '100', '77', '64', '58', '71', '75', '86', '95', '73', '101', '80', '97', '57', '60', '61', '98', '87', '63', '68834', '99', '66651', '66666', '66677', '66688', '69','179887','179891'
)
 
        --ORDER BY 4 DESC
)
    PIVOT (MAX(DADO) FOR CD_METADADO IN (
                                        '83'    AS CD_USU_RESP_AVALIACAO,
                                        '67'    AS CD_PRESCRICAO,
                                        '64505' AS NM_PAC,
                                        '76'    AS COD_ITEM1,
                                        '66057' AS CD_ITEM2,
                                        '66451' AS CD_ITEM3,
                                        '66669' AS CD_ITEM4,
                                        '66680' AS CD_ITEM5,
                                        '64401' AS DS_MEDIC1,
                                        '66060' AS DS_MEDIC2,
                                        '64798' AS DS_MEDIC3,
                                        '64801' AS DS_MEDIC4,
                                        '64804' AS DS_MEDIC5,
                                        '68'    AS DOMINIO_PRIMARIO_PROBLEMA1,
                                        '78'    AS DOMINIO_PRIMARIO_PROBLEMA2,
                                        '51'    AS DOMINIO_PRIMARIO_PROBLEMA3,
                                        '55'    AS DOMINIO_PRIMARIO_PROBLEMA4,
                                        '52'    AS DOMINIO_PRIMARIO_PROBLEMA5,
                                        '74'    AS SUB_COD1,
                                        '66648' AS SUB_COD2,
                                        '66663' AS SUB_COD3,
                                        '66691' AS SUB_COD4,
                                        '66685' AS SUB_COD5,
                                        '72'    AS DESCRICAO_PRAT1,
                                        '100'   AS DESCRICAO_PRAT2,
                                        '77'    AS DESCRICAO_PRAT3,
                                        '64'    AS DESCRICAO_PRAT4,
                                        '58'    AS DESCRICAO_PRAT5,
                                        '71'    AS CLASSIFICACAO1,
                                        '75'    AS CLASSIFICACAO2,
                                        '86'    AS CLASSIFICACAO3,
                                        '95'    AS CLASSIFICACAO4,
                                        '73'    AS CLASSIFICACAO5,
                                        '101'   AS CLASSIFICAR_OUTRO_ITEM1,
                                        '80'    AS CLASSIFICAR_OUTRO_ITEM2,
                                        '97'    AS CLASSIFICAR_OUTRO_ITEM3,
                                        '57'    AS CLASSIFICAR_OUTRO_ITEM4,
                                        '60'    AS CLASSIFICAR_OUTRO_ITEM5,
                                        '61'    AS INTERVENCAO_FOI_ACEITA1,
                                        '98'    AS INTERVENCAO_FOI_ACEITA2,
                                        '87'    AS INTERVENCAO_FOI_ACEITA3,
                                        '63'    AS INTERVENCAO_FOI_ACEITA4,
                                        '68834' AS INTERVENCAO_FOI_ACEITA5,
                                        '99'    AS COMENTARIOS1,
                                        '66651' AS COMENTARIOS2,
                                        '66666' AS COMENTARIOS3,
                                        '66677' AS COMENTARIOS4,
                                        '66688' AS COMENTARIOS5,
                                        '69'    AS FICARAM_ITENS_PEDENTES_AJUSTES,
                                        '179887'AS NM_PRESCRITOR,
                                        '179891'AS NM_SETOR
)
)
 
) INTERVENCAO_FARM,
 
      (
       SELECT 
  NAME_
,TO_DATE(TO_CHAR(TIME_,'DD/MM/RRRR'), 'DD/MM/RRRR') AS DATA
,CASE WHEN VAR_TYPE_ IS NULL THEN 'Aguardando' ELSE 'Finalizado' END STATUS
,CASE  
  WHEN EXTRACT (month FROM TIME_) = 1 THEN '01.JANEIRO' 
  WHEN  EXTRACT (month FROM TIME_)  = 2 THEN '02.FEVEREIRO' 
  WHEN  EXTRACT (month FROM TIME_)  = 3 THEN '03.MAR?O' 
  WHEN  EXTRACT (month FROM TIME_)  = 4 THEN '04.ABRIL' 
  WHEN  EXTRACT (month FROM TIME_)  = 5 THEN '05.MAIO' 
  WHEN  EXTRACT (month FROM TIME_)  = 6 THEN '06.JUNHO' 
  WHEN  EXTRACT (month FROM TIME_)  = 7 THEN '07.JULHO' 
  WHEN  EXTRACT (month FROM TIME_)  = 8 THEN '08.AGOSTO' 
  WHEN  EXTRACT (month FROM TIME_)  = 9 THEN '09.SETEMBRO' 
  WHEN  EXTRACT (month FROM TIME_)  = 10 THEN '10.OUTUBRO' 
  WHEN  EXTRACT (month FROM TIME_)  = 11 THEN '11.NOVEMBRO' 
  ELSE '12.DEZEMBRO' 
END MESES
,TO_CHAR (TIME_,'HH24:MI') AS HORA
,TEXT_ CD_PRESC
, SEQUENCE_COUNTER_  AS ORDEM
FROM ENGINE.ACT_HI_DETAIL
WHERE NAME_ = 'RHP2'
ORDER BY 4, 7 , 5 ) HISTORICO_DATA

       WHERE
           INTERVENCAO_FARM.CD_PRESCRICAO = HISTORICO_DATA.CD_PRESC
      -- AND INTERVENCAO_FARM.CD_PRESC = '8384749'

    UNION ALL
    SELECT * FROM
 
(
SELECT 
*
FROM(
    SELECT
        DISTINCT 
        --UPPER (C.DS_CAMPO) DS_CAMPO
        'TELA 2' TIPO
        ,C.CD_METADADO
      --  ,C.DS_CAMPO
        ,RC.CD_REGISTRO
        ,DBMS_LOB.SUBSTR(RC.lo_conteudo,4000,1) DADO
 
        FROM
         EDITOR.EDITOR_REGISTRO_CAMPO RC
        ,EDITOR.EDITOR_CAMPO C
        ,EDITOR.EDITOR_REGISTRO R
        ,EDITOR.EDITOR_LAYOUT L
        ,EDITOR.EDITOR_VERSAO_DOCUMENTO VD
 
 
        WHERE RC.CD_CAMPO = C.CD_CAMPO
        AND RC.CD_REGISTRO = R.CD_REGISTRO
        AND R.CD_LAYOUT = L.CD_LAYOUT
        AND L.CD_VERSAO_DOCUMENTO = VD.CD_VERSAO_DOCUMENTO
 
        AND VD.CD_DOCUMENTO = 1261
        AND CD_METADADO IN ('83', '67', '64505', '76', '66057', '66451', '66669', '66680', '64401', '66060', '64798', '64801', '64804', '65953', '66694', '66901', '66906',
        '67448', '74', '66648', '66663', '66691', '66685', '65956', '67310', '67313', '67318', '67324', '71', '75', '86', '95', '73', '65959', '66887', '66890', '66893', '66896', '61', '98', '87', '63', 
        '68834', '99', '66651', '66666', '66677', '66688', '69','179887','179891'
 
)
 
        --ORDER BY 4 DESC
)
    PIVOT (MAX(DADO) FOR CD_METADADO IN (
                                        '83'    AS CD_USU_RESP_AVALIACAO,  -- ok
                                        '67'    AS CD_PRESCRICAO, -- ok
                                        '64505' AS NM_PAC, -- ok
                                        '76'    AS COD_ITEM1, -- ok
                                        '66057' AS CD_ITEM2, -- ok
                                        '66451' AS CD_ITEM3, -- ok
                                        '66669' AS CD_ITEM4, -- ok
                                        '66680' AS CD_ITEM5, -- ok
                                        '64401' AS DS_MEDIC1, -- ok
                                        '66060' AS DS_MEDIC2,
                                        '64798' AS DS_MEDIC3,
                                        '64801' AS DS_MEDIC4,
                                        '64804' AS DS_MEDIC5,
                                        '65953' AS DOMINIO_PRIMARIO_PROBLEMA1, -- ok
                                        '66694' AS DOMINIO_PRIMARIO_PROBLEMA2, -- ok
                                        '66901' AS DOMINIO_PRIMARIO_PROBLEMA3, -- ok
                                        '66906' AS DOMINIO_PRIMARIO_PROBLEMA4, -- ok
                                        '67448' AS DOMINIO_PRIMARIO_PROBLEMA5, -- ok
                                        '74'    AS SUB_COD1, -- ok
                                        '66648' AS SUB_COD2, -- ok
                                        '66663' AS SUB_COD3, -- ok
                                        '66691' AS SUB_COD4, -- ok
                                        '66685' AS SUB_COD5, -- ok
                                        '65956' AS DESCRICAO_PRAT1, -- ok
                                        '67310' AS DESCRICAO_PRAT2, -- ok
                                        '67313' AS DESCRICAO_PRAT3, -- ok
                                        '67318' AS DESCRICAO_PRAT4, -- ok
                                        '67324' AS DESCRICAO_PRAT5, -- ok
                                        '71'    AS CLASSIFICACAO1, -- ok
                                        '75'    AS CLASSIFICACAO2, -- ok
                                        '86'    AS CLASSIFICACAO3, -- ok
                                        '95'    AS CLASSIFICACAO4, -- ok
                                        '73'    AS CLASSIFICACAO5, -- ok
                                        '65959' AS CLASSIFICAR_OUTRO_ITEM1, -- ok
                                        '66887' AS CLASSIFICAR_OUTRO_ITEM2, -- ok
                                        '66890' AS CLASSIFICAR_OUTRO_ITEM3, -- ok
                                        '66893' AS CLASSIFICAR_OUTRO_ITEM4, -- ok
                                        '66896' AS CLASSIFICAR_OUTRO_ITEM5, -- ok 
                                        '61'    AS INTERVENCAO_FOI_ACEITA1, -- ok 
                                        '98'    AS INTERVENCAO_FOI_ACEITA2, -- ok
                                        '87'    AS INTERVENCAO_FOI_ACEITA3, -- ok
                                        '63'    AS INTERVENCAO_FOI_ACEITA4, -- ok
                                        '68834' AS INTERVENCAO_FOI_ACEITA5, -- ok
                                        '99'    AS COMENTARIOS1,
                                        '66651' AS COMENTARIOS2,
                                        '66666' AS COMENTARIOS3,
                                        '66677' AS COMENTARIOS4,
                                        '66688' AS COMENTARIOS5,
                                        '69'    AS FICARAM_ITENS_PEDENTES_AJUSTES,
                                        '179887' AS NM_PRESCRITOR,
                                        '179891' AS NM_SETOR
)
)
 
) INTERVENCAO_FARM,
 
(
  SELECT 
  NAME_
,TO_DATE(TO_CHAR(TIME_,'DD/MM/RRRR'), 'DD/MM/RRRR') AS DATA
,CASE WHEN VAR_TYPE_ IS NULL THEN 'Aguardando' ELSE 'Finalizado' END STATUS
,CASE  
  WHEN EXTRACT (month FROM TIME_) = 1 THEN '01.JANEIRO' 
  WHEN  EXTRACT (month FROM TIME_)  = 2 THEN '02.FEVEREIRO' 
  WHEN  EXTRACT (month FROM TIME_)  = 3 THEN '03.MAR?O' 
  WHEN  EXTRACT (month FROM TIME_)  = 4 THEN '04.ABRIL' 
  WHEN  EXTRACT (month FROM TIME_)  = 5 THEN '05.MAIO' 
  WHEN  EXTRACT (month FROM TIME_)  = 6 THEN '06.JUNHO' 
  WHEN  EXTRACT (month FROM TIME_)  = 7 THEN '07.JULHO' 
  WHEN  EXTRACT (month FROM TIME_)  = 8 THEN '08.AGOSTO' 
  WHEN  EXTRACT (month FROM TIME_)  = 9 THEN '09.SETEMBRO' 
  WHEN  EXTRACT (month FROM TIME_)  = 10 THEN '10.OUTUBRO' 
  WHEN  EXTRACT (month FROM TIME_)  = 11 THEN '11.NOVEMBRO' 
  ELSE '12.DEZEMBRO' 
END MESES
,TO_CHAR (TIME_,'HH24:MI') AS HORA
,TEXT_ CD_PRESC
, SEQUENCE_COUNTER_  AS ORDEM
FROM ENGINE.ACT_HI_DETAIL
WHERE NAME_ = 'RHP2'
AND VAR_TYPE_ = 'string'
ORDER BY 4, 7 , 5 ) HISTORICO_DATA

       WHERE
       INTERVENCAO_FARM.CD_PRESCRICAO = HISTORICO_DATA.CD_PRESC
       )
      -- AND INTERVENCAO_FARM.CD_PRESC = '8392176'
     WHERE TRUNC(DATA) BETWEEN '01/JAN/2023' AND TRUNC(SYSDATE)+1
     --AND CD_REGISTRO = 20073