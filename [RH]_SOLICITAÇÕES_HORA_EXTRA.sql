select
    to_char (data_solicitacao, 'dd/mm/yyyy') Solicitado_em
from
    (
        select
            *
        from
            (
                select
                    PROC_INST_ID_,
                    name_,
                    TEXT_
                from
                    engine.act_hi_varinst
                order by
                    2
            ) ahv PIVOT (
                MAX(TEXT_) FOR name_ IN (
                    'BUSINESS_KEY_CASE_INSENSITIVE' as Identificador,
                    'MATRICULA389' as DRT,
                    'NOME_DO_SUBSTITUIDO_OU_DESLIGADO837' as Nome_Colaborador,
                    'DARA916' as Data_Solicitacao,
                    'CARGO979' as Cargo_Colaborador,
                    'SETOR47' as Setor,
                    'PERIODO558' as Periodo,
                    'INSTANCE_USER' as Id_solicitante,
                    'TIPO_SOLICITANTE68' as Cargo_Solicitante,
                    'EMAIL_SOLICI_HEEXT783' as Email_Solicitante,
                    'EMAIL_GERENTE_IMEDIATO704' as Email_Gestor_Imediato,
                    'EMAIL_DO_APROV' as Email_Superintendente,
                    'HORAS_EXTRAS937' as Total_HR_ExtPer,
                    'APROVA_HORAS_EXTRAS303' as Resp_Imediato,
                    'JUSTIFICATIVA_NAO_HE258' as Justificativa_Recusa,
                    'APROVACAO_DE_HORAS_EXTRAS261' as Resp_Superintendente,
                    'JUSTIFICATIVA_NAO_APRO_HORAS_EXTRAS620' as Justificativa_Recusa_Sup,
                    'DIAS928' as DIA01,
                    'HORA_INICIO1776' as D01HI,
                    'HORA_SAIDA1658' as D01HS,
                    'JUSTIFICATIVA1264' as D01JUS,
                    'DIA_2604' as DIA02,
                    'HORA_INICIO417' as D02HI,
                    'HORA_SAIDA843' as D02HS,
                    'JUSTIFICATIVA12142' as D02JUS,
                    'DIA_HORA_EXTRA1156' as DIA03,
                    'HORA2931' as D03HI,
                    'HORAS2732' as D03HS,
                    'JUSTIFICATIVA4192' as D03JUS,
                    'DIA4295' as DIA04,
                    'HORA_479' as D04HI,
                    'HORAS4297' as D04HS,
                    'JUSTIFICATIVA4458' as D04JUS,
                    'DIA5824' as DIA05,
                    'HORA5361' as D05HI,
                    'HORAS5210' as D05HS,
                    'JUSTIFICATIVA5365' as D05JUS,
                    'DIA6949' as DIA06,
                    'HORA6989' as D06HI,
                    'HORAS6225' as D06HS,
                    'JUSTIFICATIVA6436' as D06JUS,
                    'DIA7662' as DIA07,
                    'HORA7718' as D07HI,
                    'HORAS7354' as D07HS,
                    'JUSTIFICATIVA7804' as D07JUS,
                    'DIA8302' as DIA08,
                    'HORA8497' as D08HI,
                    'HORAS8832' as D08HS,
                    'JUSTIFICATIVA874' as D08JUS,
                    'DIA9148' as DIA09,
                    'HORA9598' as D09HI,
                    'DIAS9153' as D09HS,
                    'JUSTIFICATIVA9163' as D09JUS,
                    'DIA10332' as DIA10,
                    'HORA10975' as D10HI,
                    'HORAS10460' as D10HS,
                    'JUSTIFICATIVA10417' as D10JUS,
                    'DIA_11563' as DIA11,
                    'HORA_11159' as D11HI,
                    'HR_1146' as D11HS,
                    'JUSTIFICATIVA11949' as D11JUS,
                    'DIA_12501' as DIA12,
                    'HORA_12154' as D12HI,
                    'HR2575' as D12HS,
                    'JUT12471' as D12JUS,
                    'DIA_13318' as DIA13,
                    'HORA_13450' as D13HI,
                    'HR_3588' as D13HS,
                    'JUT13977' as D13JUS,
                    'DIA_14490' as DIA14,
                    'HORA_14922' as D14HI,
                    'HR14275' as D14HS,
                    'JUST14792' as D14JUS,
                    'DIA_15765' as DIA15,
                    'HORA_15610' as D15HI,
                    'HR1535' as D15HS,
                    'JUST15729' as D15JUS,
                    'DIA_16815' as DIA16,
                    'HORA_16365' as D16HI,
                    'HR16164' as D16HS,
                    'JUST16887' as D16JUS,
                    'DIA_1785' as DIA17,
                    'HORA_17192' as D17HI,
                    'HR17951' as D17HS,
                    'JUST1761' as D17JUS,
                    'DIA_18304' as DIA18,
                    'HORA_18617' as D18HI,
                    'HR18371' as D18HS,
                    'JUST18901' as D18JUS,
                    'DIA_19314' as DIA19,
                    'HORA_19445' as D19HI,
                    'HRR1912' as D19HS,
                    'JUST19904' as D19JUS,
                    'DIA_20689' as DIA20,
                    'HORA_20539' as D20HI,
                    'HR20322' as D20HS,
                    'JUST20586' as D20JUS
                )
            )
        where
            identificador like 'solicitação de horas extras-%'
    )
order by
    data_solicitacao desc