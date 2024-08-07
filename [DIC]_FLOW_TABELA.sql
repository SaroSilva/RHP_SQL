
SELECT * FROM ENGINE.ACT_HI_VARINST
WHERE NAME_ = 'BUSINESS_KEY_CASE_INSENSITIVE'
AND TEXT_ LIKE '%rlm%'
ORDER BY CREATE_TIME_ DESC
/

SELECT * FROM ENGINE.ACT_HI_TASKINST
ORDER BY START_TIME_ DESC
/

SELECT * FROM ENGINE.ACT_HI_PROCINST
WHERE BUSINESS_KEY_ LIKE '%RLM%'
ORDER BY START_TIME_ DESC
/

SELECT * FROM ENGINE.ACT_HI_DETAIL
WHERE NAME_ = 'BUSINESS_KEY_CASE_INSENSITIVE'
ORDER BY TIME_ DESC
/

SELECT * FROM ENGINE.ACT_HI_ACTINST
ORDER BY START_TIME_ DESC
/


SELECT * FROM ENGINE.ACT_RU_TASK
WHERE 
--EXECUTION_ID_ LIKE '%602a9699-f97f-11ed-bef0-0242ac12000c%'
--PROC_DEF_ID_ LIKE '%KxkEHkBKNZ66OEFm6RbKZi:22:94bfa5dc-f8b5-11ed-bef0-0242ac12000c%'
PROC_INST_ID_ LIKE '%dc42ab51-f975-11ed-bef0-0242ac12000c%'
ORDER BY CREATE_TIME_ DESC
/

select * from all_tables
/
select * FROM DBAMV.VACINA