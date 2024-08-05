SELECT * FROM (
        SELECT 
        CD_REGISTRO
        ,LISTAGG(CD_SOLICITANTE,';') WITHIN GROUP (ORDER BY CD_SOLICITANTE) CD_SOLICITANTE
        ,LISTAGG(NM_SOLICITANTE,';') WITHIN GROUP (ORDER BY NM_SOLICITANTE) NM_SOLICITANTE
        ,LISTAGG(CD_USLOGADO,';') WITHIN GROUP (ORDER BY CD_USLOGADO) CD_USLOGADO
        ,LISTAGG(CD_REG_ANVISA,';') WITHIN GROUP (ORDER BY CD_REG_ANVISA) CD_REG_ANVISA
        ,LISTAGG(DS_PRODUTO,';') WITHIN GROUP (ORDER BY DS_PRODUTO) DS_PRODUTO
        ,LISTAGG(TP_PRODUTO,';') WITHIN GROUP (ORDER BY TP_PRODUTO) TP_PRODUTO
        ,LISTAGG(DS_MOTIVO,';') WITHIN GROUP (ORDER BY DS_MOTIVO) DS_MOTIVO
        ,LISTAGG(NM_AMOSTRA,';') WITHIN GROUP (ORDER BY NM_AMOSTRA) NM_AMOSTRA
        ,LISTAGG(TP_CONT_FORNEC,';') WITHIN GROUP (ORDER BY TP_CONT_FORNEC) TP_CONT_FORNEC
        ,LISTAGG(DS_FORNECEDOR,';') WITHIN GROUP (ORDER BY DS_FORNECEDOR) DS_FORNECEDOR
        ,LISTAGG(DS_MARCA,';') WITHIN GROUP (ORDER BY DS_MARCA) DS_MARCA
        ,LISTAGG(DS_PROD_SUB,';') WITHIN GROUP (ORDER BY DS_PROD_SUB) DS_PROD_SUB
        ,LISTAGG(TP_VALIDACAO,';') WITHIN GROUP (ORDER BY TP_VALIDACAO) TP_VALIDACAO
        ,LISTAGG(CD_USCOMP,';') WITHIN GROUP (ORDER BY CD_USCOMP) CD_USCOMP
        ,LISTAGG(TP_ACEITE_COMP,';') WITHIN GROUP (ORDER BY TP_ACEITE_COMP) TP_ACEITE_COMP
        ,LISTAGG(DS_OBSCOMP,';') WITHIN GROUP (ORDER BY DS_OBSCOMP) DS_OBSCOMP
        ,LISTAGG(CD_USDIR,';') WITHIN GROUP (ORDER BY CD_USDIR) CD_USDIR
        ,LISTAGG(TP_ACEITE_DIR,';') WITHIN GROUP (ORDER BY TP_ACEITE_DIR) TP_ACEITE_DIR
        ,LISTAGG(DS_OBSDIR,';') WITHIN GROUP (ORDER BY DS_OBSDIR) DS_OBSDIR
            FROM(
                SELECT * FROM (
                    SELECT
                            DISTINCT UPPER (C.DS_CAMPO) DS_CAMPO
                            ,C.CD_METADADO
                            ,VD.CD_DOCUMENTO
                            ,RC.CD_REGISTRO
                            ,DBMS_LOB.SUBSTR(RC.lo_conteudo,4000,1) DADO
                            ,DENSE_RANK () OVER (ORDER BY RC.CD_REGISTRO ASC) AS RANKING
                            ,ROW_NUMBER () OVER (PARTITION BY (RC.CD_REGISTRO) ORDER BY RC.CD_REGISTRO) AS SUB_RANKING
                            FROM
                                EDITOR.EDITOR_REGISTRO_CAMPO RC
                                ,EDITOR.EDITOR_CAMPO C
                                ,EDITOR.EDITOR_REGISTRO R
                                ,EDITOR.EDITOR_LAYOUT L
                                ,EDITOR.EDITOR_VERSAO_DOCUMENTO VD
                            
                                WHERE R.CD_REGISTRO = RC.CD_REGISTRO
                                AND L.CD_LAYOUT = R.CD_LAYOUT
                                AND RC.CD_CAMPO = C.CD_CAMPO
                                AND R.CD_LAYOUT = L.CD_LAYOUT
                                AND L.CD_VERSAO_DOCUMENTO = VD.CD_VERSAO_DOCUMENTO
                                AND VD.CD_DOCUMENTO = 1324
                                
                                ORDER BY 4 DESC
                            )
                    PIVOT (MAX(DADO) FOR CD_METADADO IN (
                                                    '16427' AS CD_SOLICITANTE
                                                    ,'16436' AS NM_SOLICITANTE
                                                    ,'16813' AS CD_USLOGADO
                                                    ,'16430' AS CD_REG_ANVISA
                                                    ,'16434' AS DS_PRODUTO
                                                    ,'16433' AS TP_PRODUTO
                                                    ,'16435' AS DS_MOTIVO
                                                    ,'16437' AS NM_AMOSTRA
                                                    ,'16803' AS TP_CONT_FORNEC
                                                    ,'16806' AS DS_FORNECEDOR
                                                    ,'16809' AS DS_MARCA
                                                    ,'70538' AS DS_PROD_SUB
                                                    ,'83222' AS TP_VALIDACAO
                                                    ,'83269' AS CD_USCOMP
                                                    ,'70409' AS TP_ACEITE_COMP
                                                    ,'82980' AS DS_OBSCOMP
                                                    ,'83272' AS CD_USDIR
                                                    ,'82848' AS TP_ACEITE_DIR
                                                    ,'83098' AS DS_OBSDIR
                                                    )
                                )       
            )
            GROUP BY CD_REGISTRO
            ORDER BY CD_REGISTRO
)
WHERE CD_SOLICITANTE <> 'null'