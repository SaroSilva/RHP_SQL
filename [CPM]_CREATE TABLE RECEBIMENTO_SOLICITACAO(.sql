CREATE TABLE EDITOR_CUSTOM.RECEBIMENTO_SOLICITACAO(
CD_SOLICITANTE  VARCHAR2 (2000) NULL
,NM_SOLICITANTE VARCHAR2 (2000) NULL
,CD_USLOGADO    VARCHAR2 (2000) NOT NULL
,CD_REG_ANVISA  VARCHAR2 (2000) NULL
,DS_PRODUTO     VARCHAR2 (2000) NULL
,TP_PRODUTO     VARCHAR2 (2000) NULL
,DS_MOTIVO      VARCHAR2 (2000) NULL
,NM_AMOSTRA     VARCHAR2 (2000) NULL
,TP_CONT_FORNEC VARCHAR2 (2000) NULL
,DS_FORNECEDOR  VARCHAR2 (2000) NULL
,DS_MARCA       VARCHAR2 (2000) NULL
,DS_PROD_SUB    VARCHAR2 (2000) NULL
,TP_VALIDACAO   VARCHAR2 (2000) NULL
,CD_USCOMP      VARCHAR2 (2000) NULL
,TP_ACEITE_COMP VARCHAR2 (2000) NULL
,DS_OBSCOMP     VARCHAR2 (2000) NULL
,CD_USDIR       VARCHAR2 (2000) NULL
,TP_ACEITE_DIR  VARCHAR2 (2000) NULL
,DS_OBSDIR      VARCHAR2 (2000) NULL
)
  TABLESPACE mveditor_custom_d
  STORAGE (
    NEXT       1024 K
  )
  LOGGING
/

call editor_custom.RECEBIMENTO_SOLICITACAO
;

CREATE OR REPLACE PROCEDURE PRC_RECEBIMENTO_SOLICITACAO(
CD_SOLICITANTE  VARCHAR2  
,NM_SOLICITANTE VARCHAR2  
,CD_USLOGADO    VARCHAR2  
,CD_REG_ANVISA  VARCHAR2  
,DS_PRODUTO     VARCHAR2  
,TP_PRODUTO     VARCHAR2  
,DS_MOTIVO      VARCHAR2  
,NM_AMOSTRA     VARCHAR2  
,TP_CONT_FORNEC VARCHAR2  
,DS_FORNECEDOR  VARCHAR2  
,DS_MARCA       VARCHAR2  
,DS_PROD_SUB    VARCHAR2  
,TP_VALIDACAO   VARCHAR2  
,CD_USCOMP      VARCHAR2  
,TP_ACEITE_COMP VARCHAR2  
,DS_OBSCOMP     VARCHAR2  
,CD_USDIR       VARCHAR2  
,TP_ACEITE_DIR  VARCHAR2  
,DS_OBSDIR      VARCHAR2     
)

IS 

BEGIN
 INSERT INTO EDITOR_CUSTOM.RECEBIMENTO_SOLICITACAO
 VALUES(
CD_SOLICITANTE       
,NM_SOLICITANTE   
,CD_USLOGADO      
,CD_REG_ANVISA    
,DS_PRODUTO       
,TP_PRODUTO       
,DS_MOTIVO        
,NM_AMOSTRA       
,TP_CONT_FORNEC   
,DS_FORNECEDOR    
,DS_MARCA         
,DS_PROD_SUB      
,TP_VALIDACAO     
,CD_USCOMP        
,TP_ACEITE_COMP   
,DS_OBSCOMP       
,CD_USDIR         
,TP_ACEITE_DIR    
,DS_OBSDIR       
 );
 COMMIT;
 END;
 /
 ---------------------------
 CALL EDITOR_CUSTOM.PRC_RECEBIMENTO_SOLICITACAO(
'&<83771:DRT170___V10>'
,'&<83776:SOLICITANTE823___V9>'
,'&<83796:STATUS_COMPRADOR___V7>'
,'&<83769:REG_ANVISA434___V9>'
,'&<83795:NM_PRODUTO4___V9>'
,'&<83764:MOTIVO_DA_DEMANDA623___V9>'
,'&<83787:CPMI_NR_AMOSTRAS___V7>'
,'&<83773:SN_CONTATO_FORNEC720___V7>'
,'&<83797:NM_FORNEC361___V7>'
,'&<83781:NM_MARCA472___V7>'
,'&<83783:CPM_PROD_SUBS953___V4>'
,'&<83792:DUPLA_VALIDACAO949___V2>'
,'&<83799:DRT_COMPRADOR295___V2>'
,'&<83793:CPM_ACEITE_SOLICITACAO61___V4>'
,'&<83768:OBS_COMPRADOR236___V2>'
,'&<83785:DRT_DIRETOR967___V2>'
,'&<83777:CPM_ACEITE_SOLICITACAO_2212___V2>'
,'&<83774:OBS_DIRETOR565___V2>'
)