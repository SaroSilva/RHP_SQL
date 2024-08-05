---------------------------------------------------------- --Desenvolvido por: João Daniel --Data: 14/08/2017 ---------------------------------------------------------- 
select 
    cd_fila_senha,
    ds_fila,
    cd_atendimento, 
    cd_paciente, 
    nm_paciente, 
    cd_triagem_atendimento, 
    --cd_classificacao, 
    ds_tipo_risco, 
    totem,
    recepcao_chamada, 
    case 
        when recepcao_chamada > totem 
            then TO_CHAR(TRUNC(((recepcao_chamada-totem)*24 * 3600) / 3600), 'FM9900') || ':' || TO_CHAR(TRUNC(MOD(((recepcao_chamada-totem)*24 * 3600), 3600) / 60), 'FM00') || ':' || TO_CHAR(TRUNC(MOD(((recepcao_chamada-totem)*24 * 3600), 60)), 'FM00') 
        else null 
    end TEMPO_TOTEM_RECEPCAO_chamada, 
    recepcao_inicio, 
        case when recepcao_inicio > recepcao_chamada 
            then TO_CHAR(TRUNC(((recepcao_inicio-recepcao_chamada)*24 * 3600) / 3600), 'FM9900') || ':' || TO_CHAR(TRUNC(MOD(((recepcao_inicio-recepcao_chamada)*24 * 3600), 3600) / 60), 'FM00') || ':' || TO_CHAR(TRUNC(MOD(((recepcao_inicio-recepcao_chamada)*24 * 3600), 60)), 'FM00') 
        else null 
    end TEMPO_RECep_chamada_recp_ini, 
    recepcao_fim, 
    case 
        when recepcao_fim > recepcao_inicio 
            then TO_CHAR(TRUNC(((recepcao_fim-recepcao_inicio)*24 * 3600) / 3600), 'FM9900') || ':' || TO_CHAR(TRUNC(MOD(((recepcao_fim-recepcao_inicio)*24 * 3600), 3600) / 60), 'FM00') || ':' || TO_CHAR(TRUNC(MOD(((recepcao_fim-recepcao_inicio)*24 * 3600), 60)), 'FM00') 
        else null 
    end TEMPO_RECEp_fim_recep_ini, 
    consultorio_inicio, 
    case 
        when consultorio_inicio > totem 
            then TO_CHAR(TRUNC(((consultorio_inicio-totem)*24 * 3600) / 3600), 'FM9900') || ':' || TO_CHAR(TRUNC(MOD(((consultorio_inicio-totem)*24 * 3600), 3600) / 60), 'FM00') || ':' || TO_CHAR(TRUNC(MOD(((consultorio_inicio-totem)*24 * 3600), 60)), 'FM00') 
        else null 
    end TEMPO_TOTAL 
        from ( 
            SELECT 
                q2.cd_fila_senha, 
                q2.ds_fila, 
                q2.cd_atendimento, 
                q2.cd_paciente, 
                p.nm_paciente, 
                q2.cd_triagem_atendimento, 
                s.cd_classificacao, 
                sc.ds_tipo_risco, 
                CASE 
                    WHEN q2.totem IS NULL 
                        THEN NULL 
                    ELSE TO_DATE (LPAD (q2.totem, 14, '0'), 'DD/MM/YYYY HH24:MI:SS') 
                END totem, 
                CASE 
                    WHEN q2.recepcao_chamada IS NULL 
                        THEN NULL 
                    ELSE TO_DATE (LPAD (q2.recepcao_chamada, 14, '0'), 'DD/MM/YYYY HH24:MI:SS') 
                END recepcao_chamada, 
                CASE 
                    WHEN q2.recepcao_inicio IS NULL 
                        THEN NULL 
                    ELSE TO_DATE (LPAD (q2.recepcao_inicio, 14, '0'), 'DD/MM/YYYY HH24:MI:SS') 
                END recepcao_inicio, 
                CASE 
                    WHEN q2.recepcao_fim IS NULL 
                        THEN NULL 
                    ELSE TO_DATE (LPAD (q2.recepcao_fim, 14, '0'), 'DD/MM/YYYY HH24:MI:SS') 
                END recepcao_fim, 
                CASE 
                    WHEN q2.consultorio_inicio IS NULL 
                        THEN NULL 
                    ELSE TO_DATE (LPAD (q2.consultorio_inicio, 14, '0'), 'DD/MM/YYYY HH24:MI:SS') 
                END consultorio_inicio, 
                CASE 
                    WHEN q2.consultorio_final IS NULL 
                        THEN NULL 
                    ELSE TO_DATE (LPAD (q2.consultorio_final, 14, '0'), 'DD/MM/YYYY HH24:MI:SS') 
                END consultorio_final 
                FROM sacr_classificacao_risco s, 
                (
                Select 
                        cd_triagem_atendimento, 
                        max(Dh_Classificacao_Risco) Dh_Classificacao_Risco 
                    from sacr_classificacao_risco 
                        group by cd_triagem_atendimento
                ) q1, 
                Sacr_Classificacao sc, 
                paciente p, 
                atendime a, 
                (
                SELECT 
                    fs.cd_fila_senha, 
                    fs.ds_fila, 
                    stp.cd_atendimento, 
                    sta.cd_triagem_atendimento, 
                    sta.cd_paciente, 
                    SUM (DECODE (stp.cd_tipo_tempo_processo, 1, NVL (TO_CHAR (stp.dh_processo, 'DDMMYYYYHH24MISS' ), '00000000000000' ) ) ) totem, 
                    SUM (DECODE (stp.cd_tipo_tempo_processo, 20, NVL (TO_CHAR (stp.dh_processo, 'DDMMYYYYHH24MISS' ), '00000000000000' ) ) ) recepcao_chamada, 
                    SUM (DECODE (stp.cd_tipo_tempo_processo, 21, NVL (TO_CHAR (stp.dh_processo, 'DDMMYYYYHH24MISS' ), '00000000000000' ) ) ) recepcao_inicio, 
                    SUM (DECODE (stp.cd_tipo_tempo_processo, 22, NVL (TO_CHAR (stp.dh_processo, 'DDMMYYYYHH24MISS' ), '00000000000000' ) ) ) recepcao_fim, 
                    SUM (DECODE (stp.cd_tipo_tempo_processo, 31, NVL (TO_CHAR (stp.dh_processo, 'DDMMYYYYHH24MISS' ), '00000000000000' ) ) ) consultorio_inicio, 
                    SUM (DECODE (stp.cd_tipo_tempo_processo, 32, NVL (TO_CHAR (stp.dh_processo, 'DDMMYYYYHH24MISS' ), '00000000000000' ) ) ) consultorio_final 
                    FROM    dbamv.sacr_tempo_processo stp, 
                            dbamv.sacr_tipo_tempo_processo sttp, 
                            dbamv.triagem_atendimento sta, 
                            dbamv.fila_senha fs, 
                        ( 
                        Select 
                                CD_TIPO_TEMPO_PROCESSO, 
                                CD_TRIAGEM_ATENDIMENTO, 
                                CD_ATENDIMENTO, 
                                min(DH_PROCESSO) DH_PROCESSO 
                            from sacr_tempo_processo 
                            where trunc(dh_processo) = TRUNC(SYSDATE) 
                            --where cd_triagem_atendimento = 2781439 
                            group by CD_TIPO_TEMPO_PROCESSO, 
                                    CD_TRIAGEM_ATENDIMENTO, 
                                    CD_ATENDIMENTO) base 
                    WHERE stp.CD_TRIAGEM_ATENDIMENTO = base.CD_TRIAGEM_ATENDIMENTO 
                    and stp.DH_PROCESSO = base.DH_PROCESSO 
                    and trunc(stp.dh_processo) = TRUNC(SYSDATE) --between $DataInicioFormatada$ and $DataFimFormatada$ 
                    AND stp.cd_tipo_tempo_processo = sttp.cd_tipo_tempo_processo 
                    AND stp.cd_triagem_atendimento = sta.cd_triagem_atendimento 
                    AND sta.cd_fila_senha = fs.cd_fila_senha 
                    AND stp.cd_atendimento IS NOT NULL 
                    --and stp.cd_atendimento in (select cd_atendimento from dbamv.atendime where cd_ori_ate = 67) 
                    AND sta.dh_removido IS NULL AND sta.cd_fila_senha IN (279) 
                    --and stp.cd_triagem_atendimento in (2781439) 
                    GROUP BY fs.cd_fila_senha, 
                    fs.ds_fila, 
                    stp.cd_atendimento, 
                    sta.cd_triagem_atendimento, 
                    sta.cd_paciente
                ) q2
            ) 
            where s.cd_triagem_atendimento = q1.cd_triagem_atendimento (+) 
            and s.Dh_Classificacao_Risco = q1.Dh_Classificacao_Risco (+) 
            and s.cd_triagem_atendimento (+) = q2.cd_triagem_atendimento 
            and S.Cd_Classificacao = sc.Cd_Classificacao (+) 
            and q2.cd_paciente = p.cd_paciente 
            and q2.cd_atendimento = a.cd_atendimento 
            --and totem IS NOT NULL -- APENAS PACIENTES COM SENHA 
            --AND consultorio_inicio IS NULL 
            -- apenas pacientes que não foram atendidos por médicos ) 
            order by cd_fila_senha, totem ; 
            
select * from triagem_atendimento 
    where cd_fila_senha IN (279) 
    and trunc(DH_PRE_ATENDIMENTO) = trunc(sysdate); 

-- 3 atendimetos nulos 
select 
    cd_tipo_tempo_processo, 
    count(*) qtd 
    from sacr_tempo_processo 
        where cd_triagem_atendimento in ( 
                                        select cd_triagem_atendimento 
                                        from triagem_atendimento 
                                        where cd_fila_senha IN (279) 
                                        and trunc(DH_PRE_ATENDIMENTO) = trunc(sysdate) ) 
        group by cd_tipo_tempo_processo; 

select * from sacr_tipo_tempo_processo 
where cd_tipo_tempo_processo in ( 1, 30, 22, 20, 31, 21, 90, 32, 99 )