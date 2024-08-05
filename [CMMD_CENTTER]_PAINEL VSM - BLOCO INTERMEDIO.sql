/*BLOCO INTERMEDIARIO*/
(
SELECT  
Cd_Unid_Int P_Unidade
,Rownum P_Linha
,Cd_Leito
,Leito
,Paciente
,DN
,Registro
,CD_PRONTUARIO
,Medico
,Convenio
,Internacao
,Prev_Alta
,Dias_Intern
,Dias_Alta
,Dia_no_Leito
,entrada_deterioracao
,saida_deterioracao
,hemodialise
,entrada_avc
,saida_avc
,sca
,Decode(Paciente,null,null,Decode(AgendaBlocoCirurgico,1,'BLOCO',null)) BLC
,Decode(Paciente,null,null,Decode(AgendaHemodinamica,1,'TRUE',null)) HMD
,Decode(Paciente,null,null,Decode(AgendaEndoscopia,1,'TRUE',null)) END
,Decode(Paciente,null,null,Decode(EvolucaoEnfermagem,1,'RED',2,'YELLOW','GREEN')) EVE
,Decode(Paciente,null,null,Decode(PrescricaoMedica,1,'RED',2,'YELLOW','GREEN')) PRM
,Decode(Paciente,null,null,Decode(PrescricaoAberta,1,'RED','GREEN')) PRA
,Decode(Paciente,null,null,Decode(ChecagemMedicacao,1,'RED','GREEN')) CKG
,Decode(Paciente,null,null,Decode(ParecerMedico,1,'RED',2,'YELLOW',3,'GREEN')) PAM
,Decode(Paciente,null,null,Proximohorario) PXH
,Decode(Paciente,null,null,Decode(Aprazamento,1,'RED','GREEN')) APZ
,Decode(Paciente,null,null,Decode(ProtocoloTev,1,'TRUE',null)) TEV
,Decode(Paciente,null,null,Decode(ProtocoloQueda,1,'YELLOW',2,'RED',5,'GREEN')) QUE
,Decode(Paciente,null,null,Decode(ProtocoloBronco,1,'YELLOW',2,'RED',5,'GREEN')) BCP
,Decode(Paciente,null,null,Decode(ProtocoloDor,1,'YELLOW',2,'RED',5,'GREEN')) DOR
,Decode(Paciente,null,null,VlrScoreEnfermagem) SCE
--,Decode(Paciente,null,null,CatCentral) CVC
--,Decode(Paciente,null,null,SondaVesical) SDV
,Decode(Paciente,null,null,VlrScoreMedico) SCM
,Decode(Paciente,null,null,Decode(PrecaucaoAr,1,'GREEN',null)) PAR
,Decode(Paciente,null,null,Decode(PrecaucaoContato,1,'GREEN',null)) PCT
,Decode(Paciente,null,null,Decode(PrecaucaoGoticula,1,'GREEN',null)) PGT
,Decode(Paciente,null,null,Decode(PrecaucaoMaxima,1,'GREEN',null)) PMX
,Decode(Paciente,null,null,Decode(PrecaucaoPadrao,1,'GREEN',null)) PPD
,Decode(Paciente,null,null,Decode(AvisoAlergia,1,'GREEN',null)) ALE
,Decode(Paciente,null,null,Decode(Monitoramento,1,'YELLOW','GREEN')) MON
,Decode(Paciente,null,null,Decode(BalancoHidrico,1,'RED','GREEN')) BLH
,Decode(Paciente,null,null,Decode(ResultadoExames,1,'RESULTADO_EXAME',3,'DOC_PREENCHIDO')) EXA
,Decode(Paciente,null,null,Decode(ResultadoImagens,1,'RESULTADO_IMAGEM',3,'DOC_PREENCHIDO')) IMG
,Decode(Paciente,null,null,Decode(PedidoFarmaciaAtrasado,1,'RED',Decode(PedidoFarmaciaPendente,1,'ESTOQUE','GREEN'))) PED
,Decode(Paciente,null,null,Decode(PedidoFarmaciaDevolucao,1,'ESTOQUE',2,'RED','GREEN')) DEV
,Decode(Paciente,NULL,NULL,Decode(AuditoriaChecagem,1,'RED','GREEN')) AUD
,Decode(LocalPaciente,1,'BLOCO',2,'SRPA' ,Decode(AltaMedica,1,'ALTA' ,Decode(Tp_Ocupacao,'O','OCUPADO','R','RESERVADO','M','MANUTENCAO','I','INFECTADO','A','ACOMPANHANTE','V','VAGO' ,Decode(StatusLimpeza,'L','HIGIENIZACAO','H','LIMPEZA','C','CAMAREIRA','P','POS_LIMPEZA',Decode(TP_ocupacao,'L','HIGIENIZACAO'))))) Sit
,Decode(Paciente,null,NULL,Hint) Hint
FROM(
    SELECT  
    Leitos.Cd_Leito
    ,Leitos.Cd_Unid_Int
    ,Leitos.Ds_Resumo Leito
    ,Movimento.Registro
    ,MOVIMENTO.CD_PRONTUARIO
    ,Movimento.Paciente
    ,Movimento.DN
    ,Movimento.Medico
    ,Movimento.Convenio
    ,Movimento.Internacao
    ,Movimento.Prev_Alta
    ,Movimento.Dias_Intern
    ,Movimento.Dias_Alta
    ,Movimento.Dia_no_Leito
    ,Movimento.entrada_deterioracao
    ,Movimento.saida_deterioracao
    ,Movimento.hemodialise
    ,Movimento.entrada_avc
    ,Movimento.saida_avc
    ,Movimento.sca
    ,Movimento.AgendaBlocoCirurgico
    ,Movimento.AgendaHemodinamica
    ,Movimento.AgendaEndoscopia
    ,Movimento.ChecagemMedicacao
    ,Movimento.PedidoFarmaciaPendente
    ,MOvimento.PedidoFarmaciaAtrasado
    ,Movimento.PrescricaoMedica
    ,Movimento.PrescricaoAberta
    ,Movimento.ProximoHorario
    ,Movimento.ParecerMedico
    ,Movimento.Aprazamento
    ,Movimento.EvolucaoEnfermagem
    ,Movimento.ProtocoloTev
    ,Movimento.ProtocoloQueda
    ,Movimento.ProtocoloBronco
    ,Movimento.ProtocoloDor
    ,Movimento.VlrScoreEnfermagem
    --,Movimento.CatCentral
    --,Movimento.SondaVesical
    ,Movimento.VlrScoreMedico
    ,Movimento.PrecaucaoGoticula
    ,Movimento.PrecaucaoContato
    ,Movimento.PrecaucaoAr
    ,Movimento.PrecaucaoMaxima
    ,Movimento.PrecaucaoPadrao
    ,Movimento.AvisoAlergia
    ,Movimento.ResultadoExames
    ,Movimento.ResultadoImagens
    ,Movimento.PedidoFarmaciaDevolucao
    ,Movimento.BalancoHidrico
    ,Movimento.Monitoramento
    ,Movimento.AuditoriaChecagem
    ,Movimento.Hint
    ,Movimento.AltaMedica
    ,Movimento.cd_atendimento
    ,Movimento.LocalPaciente
    ,Leitos.Tp_Ocupacao
    ,Movimento.ItensApagar
    ,Leitos.Cd_Leito_Aih
    ,Leitos.StatusLimpeza
    
    FROM 
        (
        SELECT  
            DBAMV.FNC_DES_OBTER_INICIAIS(Paciente.nm_paciente,1) Paciente
            ,LPad(atendime.cd_atendimento,7,0) Registro
            ,ATENDIME.CD_PACIENTE AS CD_PRONTUARIO
            ,Decode(Substr(Prestador.nm_prestador,9,12),null,prestador.nm_prestador,Substr(prestador.nm_prestador,1,8)||'...') Medico
            ,REGEXP_REPLACE(Prestador.nm_prestador, '\s([A-Za-z])[A-Za-z]+', ' \1.') Medico1
            ,Decode(Substr(Convenio.Nm_Convenio,7,10),NULL,Convenio.Nm_Convenio,Substr(Convenio.Nm_Convenio,1,6)||'...') Convenio
            ,To_Char(Atendime.Dt_Atendimento,'DD/MM/YYYY')||'-'||To_Char(Atendime.Hr_Atendimento,'hh24:mi') Internacao
            ,To_Char(Paciente.dt_nascimento,'DD/MM/YYYY') DN
            ,(SELECT VIE.ds_resposta 
                FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VIE
                WHERE VIE.CD_DOCUMENTO IN (1106)
                AND VIE.TP_STATUS = 'FECHADO'
                AND VIE.ds_identificador_filho = 'dt_pre_alta_1'
                AND VIE.DH_FECHAMENTO IN (
                                            SELECT Max(VDIC.DH_FECHAMENTO)
                                            FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC
                                            WHERE VDIC.CD_DOCUMENTO IN (1106)
                                            AND VDIC.TP_STATUS = 'FECHADO'
                                            AND VDIC.ds_identificador_filho = 'dt_pre_alta_1'
                                            and VDIC.cd_atendimento = Atendime.cd_atendimento
                                        )
                AND VIE.CD_ATENDIMENTO = Atendime.cd_atendimento) as Prev_Alta --Ajuste 1.0
            --,To_Char(Atendime.Dt_Prevista_Alta,'dd/mm/yy') Prev_Alta
            ,trunc(sysdate-Atendime.dt_atendimento) Dias_Intern
            ,trunc (nvl(to_date (Atendime.dt_prevista_alta, 'dd/mm/rrrr hh24:mi'),trunc(sysdate))-trunc(sysdate)) Dias_Alta
            ,(SELECT Trunc(sysdate - dt_mov_int) FROM mov_int WHERE cd_leito = Atendime.cd_leito AND cd_atendimento = Atendime.cd_atendimento AND dt_lib_mov IS NULL) AS Dia_no_Leito
            ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (1291)  AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS entrada_deterioracao
            ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (1292)  AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS saida_deterioracao
            ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (1408)  AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS hemodialise /*--WHERE VDIC.CD_DOCUMENTO IN (1488)*/
            ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (886,809) AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS entrada_avc
            ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (961)   AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS saida_avc
            ,(SELECT Max(VDIC.DH_FECHAMENTO) FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC WHERE VDIC.CD_DOCUMENTO IN (835)   AND VDIC.TP_STATUS = 'FECHADO' and VDIC.cd_atendimento = Atendime.cd_atendimento) AS sca
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'CHECAGEMMEDICACAO',Atendime.Cd_Multi_Empresa) ChecagemMedicacao
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROXIMOHORARIO',Atendime.Cd_Multi_Empresa) ProximoHorario
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'APRAZAMENTO',Atendime.Cd_Multi_Empresa) Aprazamento
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PEDIDOFARMACIAPENDENTE',Atendime.Cd_Multi_Empresa) PedidoFarmaciaPendente
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PEDIDOFARMACIAATRASADO',Atendime.Cd_Multi_Empresa) PedidoFarmaciaAtrasado
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PRESCRICAOMEDICA',Atendime.Cd_Multi_Empresa) PrescricaoMedica
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PRESCRICAOABERTA',Atendime.Cd_Multi_Empresa) PrescricaoAberta
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PARECERMEDICO',Atendime.Cd_Multi_Empresa) ParecerMedico
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'EVOLUCAOENFERMAGEM',Atendime.Cd_Multi_Empresa) EvolucaoEnfermagem
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROTOCOLOTEV_SEMINDICE',Atendime.Cd_Multi_Empresa) ProtocoloTev
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROTOCOLOQUEDA',Atendime.Cd_Multi_Empresa) ProtocoloQueda
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROTOCOLOBRONCO',Atendime.Cd_Multi_Empresa) ProtocoloBronco
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROTOCOLODOR',Atendime.Cd_Multi_Empresa) ProtocoloDor
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'VLRSCOREENFERMAGEM',Atendime.Cd_Multi_Empresa) VlrScoreEnfermagem
            --,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'CATCENTRAL',Atendime.Cd_Multi_Empresa) CatCentral
            --,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'SONDAVESICAL',Atendime.Cd_Multi_Empresa) SondaVesical
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'VLRSCOREMEDICO',Atendime.Cd_Multi_Empresa) VlrScoreMedico
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AGENDABLOCOCIRURGICO',Atendime.Cd_Multi_Empresa) AgendaBlocoCirurgico
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AGENDAHEMODINAMICA',Atendime.Cd_Multi_Empresa) AgendaHemodinamica
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AGENDAENDOSCOPIA',Atendime.Cd_Multi_Empresa) AgendaEndoscopia
            ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOGOTICULA',Atendime.Cd_Multi_Empresa) PrecaucaoGoticula
            ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOCONTATO',Atendime.Cd_Multi_Empresa) PrecaucaoContato
            ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOAR',Atendime.Cd_Multi_Empresa) PrecaucaoAr
            ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOMAXIMA',Atendime.Cd_Multi_Empresa) PrecaucaoMaxima
            ,Dbamv.Fnc_Painel_Vigilancia_Epidemio(Atendime.cd_atendimento,'PRECAUCAOPADRAO',Atendime.Cd_Multi_Empresa) PrecaucaoPadrao
            ,Nvl(Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AVISOALERGIATELA',Atendime.Cd_Multi_Empresa),Dbamv.Fnc_Painel_Assistencial(cd_atendimento,'AVISOALERGIATELA',Atendime.Cd_Multi_Empresa)) AvisoAlergia
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'RESULTADOEXAMES',Atendime.Cd_Multi_Empresa) ResultadoExames
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PEDIDOFARMACIADEVOLUCAO',Atendime.Cd_Multi_Empresa) PedidoFarmaciaDevolucao
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'BALANCOHIDRICO',Atendime.Cd_Multi_Empresa) BalancoHidrico
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'ALTAMEDICA',Atendime.Cd_Multi_Empresa) AltaMedica
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'RESULTADOIMAGENS',Atendime.Cd_Multi_Empresa) ResultadoImagens
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'MONITORAMENTO',Atendime.Cd_Multi_Empresa) Monitoramento
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'AUDITORIACHECAGEM',Atendime.Cd_Multi_Empresa) AuditoriaChecagem
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'LOCALPACIENTE',Atendime.Cd_Multi_Empresa) LocalPaciente
            ,Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'ITENSAPAGAR',Atendime.Cd_Multi_Empresa) ItensApagar
            ,Rtrim(Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PROXIMAMEDICACAO',Atendime.Cd_Multi_Empresa))||' '|| Rtrim(Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'PEDIDOMEDICACAOATRASADA',Atendime.Cd_Multi_Empresa))||' '|| Rtrim(Dbamv.Fnc_Painel_Assistencial(Atendime.cd_atendimento,'MEDICACAOATRASADA',Atendime.Cd_Multi_Empresa)) Hint
            ,Atendime.cd_atendimento Cd_atendimento
            ,Leito.Cd_Leito_Aih Cd_Laito_Aih
            ,Leito.Cd_leito Cd_leito
            
        FROM Dbamv.Atendime , Dbamv.Leito , Dbamv.Paciente , Dbamv.Prestador , Dbamv.Convenio
        WHERE Atendime.Cd_Leito = Leito.Cd_Leito
        AND Atendime.Cd_Paciente = paciente.cd_paciente
        AND atendime.cd_prestador = prestador.cd_prestador
        AND Atendime.Cd_convenio = Convenio.Cd_Convenio
        AND Atendime.Tp_Atendimento = 'I' -- MODIFICADO POR 26521
        AND Atendime.Dt_Alta is NULL
        AND Atendime.Cd_Multi_Empresa = 1
        --AND Leito.Cd_Unid_Int IN (1,2,3,4,5,22)
        AND Atendime.CD_ORI_ATE IN (1,2,3,4,5,22)
        AND leito.cd_unid_int is not null
        AND (SELECT VIE.ds_resposta 
                FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VIE
                WHERE VIE.CD_DOCUMENTO IN (1106)
                AND VIE.TP_STATUS = 'FECHADO'
                AND VIE.ds_identificador_filho = 'dt_pre_alta_1'
                AND VIE.DH_FECHAMENTO IN (
                                            SELECT Max(VDIC.DH_FECHAMENTO)
                                            FROM DBAMV.VDIC_PW_RESPOSTA_DOCUMENTO VDIC
                                            WHERE VDIC.CD_DOCUMENTO IN (1106)
                                            AND VDIC.TP_STATUS = 'FECHADO'
                                            AND VDIC.ds_identificador_filho = 'dt_pre_alta_1'
                                            and VDIC.cd_atendimento = Atendime.cd_atendimento
                                        )
                AND VIE.CD_ATENDIMENTO = Atendime.cd_atendimento) = TRUNC(SYSDATE)
        ) Movimento
         ,(
        SELECT  Leito.Cd_leito
        ,Leito.Cd_Leito_Aih
        ,Leito.Cd_Unid_Int
        ,Leito.Sn_Extra
        ,Leito.Ds_Resumo
        ,Leito.Tp_Ocupacao
        ,SolicLimpeza.StatusLimpeza
        ,leito.cd_tip_acom
        FROM Dbamv.Leito ,
        (
        SELECT  Solic_Limpeza.Cd_Leito
        ,Decode(Solic_Limpeza.Dt_Inicio_Higieniza,NULL,'H',Decode(solic_limpeza.dt_hr_fim_higieniza,NULL,'L',Decode(Solic_Limpeza.Dt_Hr_Fim_Rouparia,NULL,'C',Decode(Solic_Limpeza.Dt_Hr_Fim_Pos_higieniza,NULL,'P',Decode(Solic_Limpeza.Dt_Realizado,NULL,'L'))))) StatusLimpeza
        FROM Dbamv.Solic_Limpeza
        WHERE To_Char(Solic_Limpeza.Dt_Solic_Limpeza, 'dd/mm/rrrr')||' '||To_Char(Solic_Limpeza.Hr_Solic_Limpeza, 'hh24:mi') IS NOT NULL
        AND To_Char(Solic_Limpeza.Dt_Hr_Fim_pos_higieniza, 'dd/mm/rrrr hh24:mi') IS null
        AND (Solic_Limpeza.Cd_Leito, To_Date(To_Char(Solic_Limpeza.Dt_Solic_Limpeza, 'dd/mm/rrrr')||' '||To_Char(Solic_Limpeza.Hr_Solic_Limpeza, 'hh24:mi'), 'dd/mm/yyyy hh24:mi')) IN ( SELECT Solic_Limpeza.Cd_Leito , MAX(To_Date(To_Char(Solic_Limpeza.Dt_Solic_Limpeza, 'dd/mm/rrrr')||' '||To_Char(Solic_Limpeza.Hr_Solic_Limpeza, 'hh24:mi'), 'dd/mm/yyyy hh24:mi')) DtInicioLimpeza FROM Dbamv.solic_limpeza GROUP BY Solic_limpeza.cd_leito )
        ) SolicLimpeza
        WHERE Leito.Cd_Leito = SolicLimpeza.Cd_Leito(+)
        AND Leito.Dt_Desativacao is null ) Leitos
        WHERE Leitos.Cd_leito = Movimento.Cd_leito(+)
        AND Decode(Leitos.Sn_Extra, 'S', Movimento.Registro, Leitos.Cd_Leito) Is Not NULL
        ORDER BY Leito
)
WHERE Cd_Unid_Int IN (1,2,3,4,5,22)
)