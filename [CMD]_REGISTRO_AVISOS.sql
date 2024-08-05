SELECT 
  RF.CD_ATENDIMENTO AS "CÓD. ATEND"
  ,RF.CD_REG_FAT AS "Nº DA CONTA"
  ,Decode (RF.SN_FECHADA,'S','Finaizada','N','Aberta') AS "STATUS DA CONTA"
  ,CIR.CD_AVISO_CIRURGIA AS "AVISO CIRURGICO"
  ,CIR.DT_AVISO_CIRURGIA AS "DATA AVISO"
  ,DECODE (CIR.SN_CONFIRMADO,'N','NÃO','S','SIM') AS "CIRURGIA CONFIRMADA?"

  FROM DBAMV.REG_FAT RF
  LEFT JOIN DBAMV.AVISO_CIRURGIA CIR ON RF.CD_ATENDIMENTO = CIR.CD_ATENDIMENTO
  AND RF.CD_ATENDIMENTO = 3876643
  ORDER BY 4 desc
