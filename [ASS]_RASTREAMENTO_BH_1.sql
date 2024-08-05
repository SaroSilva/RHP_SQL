
SELECT * FROM balanco_hidrico
WHERE cd_atendimento = '304404';

SELECT * FROM  dbamv.balanco_hidrico_fechamento
WHERE CD_ATENDIMENTO LIKE '%304%' ;

SELECT cd_balanco_hidrico FROM pw_balanco_hidrico
WHERE cd_paciente LIKE '%380015%'
ORDER BY hr_fechamento DESC;

SELECT * FROM pw_balanco_hidrico_fechamento
WHERE cd_paciente LIKE '%380015%'
ORDER BY hr_fechamento DESC;

-- buscar apenas balanço hidricos que tenha sidos finalizados
SELECT * FROM pw_balanco_hidrico
WHERE cd_paciente LIKE '%380015%'
AND cd_balanco_hidrico in (SELECT cd_balanco_hidrico FROM pw_balanco_hidrico_fechamento)
ORDER BY hr_fechamento DESC;




