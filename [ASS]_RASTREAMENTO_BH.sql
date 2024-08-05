SELECT*FROM balanco_hidrico
WHERE cd_atendimento = 2763683;

SELECT*FROM balanco_hidrico_fechamento;

--identificar balanços existentes

SELECT
CD_BALANCO_HIDRICO,
CD_PACIENTE,
DT_REFERENCIA,
DH_CRIACAO
FROM pw_balanco_hidrico
WHERE cd_atendimento = 2763683
ORDER BY dt_referencia desc;

--verificar regstro de fechamento
SELECT*FROM pw_balanco_hidrico_fechamento
WHERE cd_balanco_hidrico IN (
428444,428140,
428043,427763,
427354,427183,
426822,426580,
426235,425894,
425554,425262,
424966,424513,
424351,423887,
423629,423317,
423045,422715,
422382,422149,
421959,421547,
421185,420820
)
ORDER BY dt_referencia desc;