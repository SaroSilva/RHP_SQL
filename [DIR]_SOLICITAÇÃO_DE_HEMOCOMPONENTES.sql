select 
PM.CD_PRE_MED "Nº DA PRESCRIÇÃO"
,PM.NM_USUARIO "DRT"
,PM.CD_PRESTADOR "COD INTERNO"
,P.NM_PRESTADOR "NOME MÉDICO"
,PM.CD_SETOR "COD. SETOR"
,S.NM_SETOR "NOME DO SETOR"
,PM.DT_PRE_MED "DATA PRESCRIÇÃO"
,DECODE (PM.TP_PRE_MED,'M','MÉD','A',' ','E','ENF','F',' ','V',' ') TIPO 
,IPM.CD_ITPRE_MED "COD ITEM"
,TP.DS_TIP_PRESC "NOME DO ITEM"
from 
      pre_med PM, 
      ITPRE_MED IPM,
      TIP_PRESC TP,
      PRESTADOR P,
      SETOR S
                  where PM.CD_PRE_MED = IPM.CD_PRE_MED
                  AND IPM.CD_TIP_PRESC = TP.CD_TIP_PRESC
                  AND PM.CD_PRESTADOR = P.CD_PRESTADOR
                  AND PM.CD_SETOR = S.CD_SETOR
                  AND PM.tp_pre_med = 'M'
                  AND IPM.CD_TIP_ESQ = 'HEM'
                  AND PM.DT_PRE_MED BETWEEN TO_DATE('01012023','DD/MM/YYYY')
                  AND TO_DATE ('31052023','DD/MM/YYYY')
                  order by PM.cd_pre_med desc
;