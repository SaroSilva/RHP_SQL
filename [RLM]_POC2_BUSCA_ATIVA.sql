SELECT ATUANTE FROM (
SELECT 
CD_REGISTRO
,LISTAGG(ATUANTE,';') WITHIN GROUP (ORDER BY ATUANTE) ATUANTE
,LISTAGG(CRM,';') WITHIN GROUP (ORDER BY CRM) CRM
,LISTAGG(DT_VISITA,';') WITHIN GROUP (ORDER BY DT_VISITA) DT_VISITA
,LISTAGG(NM_MED,';') WITHIN GROUP (ORDER BY NM_MED) NM_MED
,LISTAGG(ESPEC,';') WITHIN GROUP (ORDER BY ESPEC) ESPEC
FROM (
    SELECT
        DISTINCT UPPER (EC.DS_CAMPO) DS_CAMPO
        ,EC.CD_METADADO
        ,RC.CD_REGISTRO
        ,RC.CD_CAMPO
        ,DBMS_LOB.SUBSTR(RC.lo_conteudo,4000,1) DADO  
        FROM 
            EDITOR.EDITOR_REGISTRO_CAMPO RC
            ,EDITOR.EDITOR_CAMPO EC  

        WHERE RC.CD_CAMPO = EC.CD_CAMPO
        AND CD_METADADO IN ('80782','690','708','702','69957')
        --ATUANTE || CRM || DATA VISITA || MEDICO || ESPECIALIDADE
        ORDER BY 4 DESC
)
    PIVOT (MAX (DADO) FOR CD_METADADO IN (
        '80782'AS ATUANTE
        ,'690' AS CRM
        ,'708' AS DT_VISITA
        ,'702' AS NM_MED
        ,'69957' AS ESPEC 
    ))
GROUP BY CD_REGISTRO
ORDER BY CD_REGISTRO DESC   
)
WHERE CRM IN ()
AND NM_MED IN ()
AND DT_VISITA IN ()