CREATE TABLE EDITOR_CUSTOM.CAD_LABEXT_PAT(
CD_LABEXT VARCHAR2 (10) NOT NULL PRIMARY KEY
,NM_LABEXT VARCHAR2 (200) NOT NULL
)
  TABLESPACE mveditor_custom_d
  STORAGE (
    NEXT       1024 K
  )
  LOGGING
/
;
--CRIAR SEQUENCIAL PARA TABELA  DE LABORATORIOS EXTERNOS
CREATE SEQUENCE EDITOR_CUSTOM.SEQ_LABEXT_PAT
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;
  
--CRIAR PROCEDURE PARA ALIMENTAR
CREATE OR REPLACE PROCEDURE EDITOR_CUSTOM.PRC_LABEXT_PAT (NM_LABEXT_IN VARCHAR2)
IS
    V_CD_LABEXT VARCHAR2(10);
BEGIN
    -- Obt�m o pr�ximo valor da sequ�ncia para CD_LABEXT
    SELECT 'LABEXT_' || TO_CHAR(SEQ_LABEXT_PAT.NEXTVAL, 'FM00000000') INTO V_CD_LABEXT FROM DUAL;

    -- Insere na tabela usando o valor da sequ�ncia
    INSERT INTO EDITOR_CUSTOM.CAD_LABEXT_PAT (CD_LABEXT, NM_LABEXT)
    VALUES (V_CD_LABEXT, NM_LABEXT_IN);
    
    -- Confirma a transa��o
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        -- Se ocorrer algum erro, mostra a mensagem de erro
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
        -- Desfaz qualquer transa��o pendente
        ROLLBACK;
END;
;
SELECT * FROM EDITOR_CUTOM.CAD_LABEXT_PAT