SELECT*FROM admissao_co
WHERE cd_admissao_co = 4196;

SELECT
CD_ADMISSAO_CO,
CD_RECEM_NASCIDO,
NM_RECEM_NASCIDO,
HR_NASCIMENTO,
CD_ATENDIMENTO FROM recem_nascido
WHERE cd_admissao_co = 4196
OR nm_recem_nascido like '%GABRIELA%'
ORDER BY HR_NASCIMENTO DESC;

SELECT
CD_CAD_RECEM_NASCIDO,
CD_ADMISSAO_CO,
CD_RECEM_NASCIDO,
NM_RECEM_NASCIDO,
HR_NASCIMENTO,
CD_ATENDIMENTO FROM cad_recem_nascido
WHERE nm_recem_nascido like '%FERRARI%'
OR CD_ADMISSAO_CO = 4196
ORDER BY HR_NASCIMENTO DESC;

