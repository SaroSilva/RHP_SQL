
SELECT  
LEITOS.Cd_Leito
,LEITOS.Cd_Unid_Int
,LEITOS.Ds_Resumo Leito
,MOVIMENTO.Registro
,MOVIMENTO.CD_PRONTUARIO
,MOVIMENTO.Paciente
,MOVIMENTO.DN
,MOVIMENTO.Medico
,MOVIMENTO.Convenio
,MOVIMENTO.Internacao
,MOVIMENTO.Prev_Alta
,MOVIMENTO.Dias_Intern
,MOVIMENTO.Dias_Alta
,MOVIMENTO.Dia_no_Leito
,MOVIMENTO.entrada_deterioracao
,MOVIMENTO.saida_deterioracao
,MOVIMENTO.hemodialise
,MOVIMENTO.entrada_avc
,MOVIMENTO.saida_avc
,MOVIMENTO.sca
,MOVIMENTO.AgendaBlocoCirurgico
,MOVIMENTO.AgendaHemodinamica
,MOVIMENTO.AgendaEndoscopia
,MOVIMENTO.ChecagemMedicacao
,MOVIMENTO.PedidoFarmaciaPendente
,MOvimento.PedidoFarmaciaAtrasado
,MOVIMENTO.PrescricaoMedica
,MOVIMENTO.PrescricaoAberta
,MOVIMENTO.ProximoHorario
,MOVIMENTO.ParecerMedico
,MOVIMENTO.Aprazamento
,MOVIMENTO.EvolucaoEnfermagem
,MOVIMENTO.ProtocoloTev
,MOVIMENTO.ProtocoloQueda
,MOVIMENTO.ProtocoloBronco
,MOVIMENTO.ProtocoloDor
,MOVIMENTO.VlrScoreEnfermagem
--,MOVIMENTO.CatCentral
--,MOVIMENTO.SondaVesical
,MOVIMENTO.VlrScoreMedico
,MOVIMENTO.PrecaucaoGoticula
,MOVIMENTO.PrecaucaoContato
,MOVIMENTO.PrecaucaoAr
,MOVIMENTO.PrecaucaoMaxima
,MOVIMENTO.PrecaucaoPadrao
,MOVIMENTO.AvisoAlergia
,MOVIMENTO.ResultadoExames
,MOVIMENTO.ResultadoImagens
,MOVIMENTO.PedidoFarmaciaDevolucao
,MOVIMENTO.BalancoHidrico
,MOVIMENTO.Monitoramento
,MOVIMENTO.AuditoriaChecagem
,MOVIMENTO.Hint
,MOVIMENTO.AltaMedica
,MOVIMENTO.cd_atendimento
,MOVIMENTO.LocalPaciente
,LEITOS.Tp_Ocupacao
,MOVIMENTO.ItensApagar
,LEITOS.Cd_Leito_Aih
,LEITOS.StatusLimpeza

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
        ,Leito.Cd_Leito_Aih Cd_Leito_Aih
        ,Leito.Cd_leito Cd_leito
        
    FROM Dbamv.Atendime , Dbamv.Leito , Dbamv.Paciente , Dbamv.Prestador , Dbamv.Convenio
    WHERE Atendime.Cd_Leito = Leito.Cd_Leito
    AND Atendime.Cd_Paciente = paciente.cd_paciente
    AND atendime.cd_prestador = prestador.cd_prestador
    AND Atendime.Cd_convenio = Convenio.Cd_Convenio
    AND Atendime.Tp_Atendimento = 'U' -- MODIFICADO POR 26521
    AND Atendime.Dt_Alta is NULL
    AND Atendime.Cd_Multi_Empresa IN (1,2)
    --AND Leito.Cd_Unid_Int IN (1,2,3,4,5,22)
    AND Atendime.CD_ORI_ATE IN (1,2,3,4,5,22)
    AND leito.cd_unid_int is null
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
    ) MOVIMENTO
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
      AND Leito.Dt_Desativacao is null 
    ) LEITOS
    WHERE LEITOS.Cd_leito = MOVIMENTO.Cd_leito(+)
    AND Decode(LEITOS.Sn_Extra, 'S', MOVIMENTO.Registro, LEITOS.Cd_Leito) Is Not NULL
    ORDER BY Leito
    