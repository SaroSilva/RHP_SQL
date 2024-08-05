prompt CREATE OR REPLACE PROCEDURE prc_des_insere_reg_ocorrencia
CREATE OR REPLACE PROCEDURE prc_des_insere_reg_ocorrencia (

   p_CD_ORGANIZACAO_REGISTRANTE    IN dbaportal.registro_ocorrencia.CD_ORGANIZACAO_REGISTRANTE%type,
    p_CD_CENTRO_CUSTO_REGISTRANTE   IN dbaportal.registro_ocorrencia.CD_CENTRO_CUSTO_REGISTRANTE%type,
    p_ID_USUARIO_REGISTRANTE        IN dbaportal.registro_ocorrencia.ID_USUARIO_REGISTRANTE%type,
    p_CD_ORGANIZACAO_RELATOR        IN dbaportal.registro_ocorrencia.CD_ORGANIZACAO_RELATOR%type,
    p_CD_CENTRO_CUSTO_RELATOR       IN dbaportal.registro_ocorrencia.CD_CENTRO_CUSTO_RELATOR%type,
    p_ID_USUARIO_RELATOR            IN dbaportal.registro_ocorrencia.ID_USUARIO_RELATOR%type,
    p_CD_OCORRENCIA                 IN dbaportal.ocorrencia.CD_OCORRENCIA%type,
    p_DS_RESUMO                     IN dbaportal.registro_ocorrencia.DS_RESUMO%type,
    p_DS_REGISTRO                   IN dbaportal.registro_ocorrencia.DS_REGISTRO%type,
    p_CD_METODO_DETECCAO_OCOR       IN dbaportal.registro_ocorrencia.CD_METODO_DETECCAO_OCORRENCIA%type,
    p_CD_ACAO_IMEDIATA_OCOR         IN dbaportal.registro_ocorrencia.CD_ACAO_IMEDIATA_OCORRENCIA%type,
    p_CD_ATENDIMENTO                IN dbaportal.registro_ocorrencia.CD_ATENDIMENTO%type,
    p_HR_OCORRIDO                   IN dbaportal.registro_ocorrencia.HR_OCORRIDO%type,
    p_DH_OCORRIDO                   IN dbaportal.registro_ocorrencia.dh_ocorrido%type
) IS
v_cd_registro_ocorrencia    dbaportal.registro_ocorrencia.cd_registro_ocorrencia%type;
v_id_usuario_responsavel    dbaportal.tipo_fluxo_ocorrencia.id_usuario_responsavel%type;
v_cd_papel_responsavel      dbaportal.tipo_fluxo_ocorrencia.cd_papel_responsavel%type;
v_tp_setor_responsavel      dbaportal.tipo_fluxo_ocorrencia.tp_setor_responsavel%type;
v_qt_sla                    dbaportal.tipo_fluxo_ocorrencia.qt_sla%type;
v_sn_email                  dbaportal.tipo_fluxo_ocorrencia.sn_email%type;
v_tem_fluxo                 number;

BEGIN

-- INSERT NA TABELA REGISTRO_OCORRENCIA;
    -- BUSCAR PROXIMO VALOR DA SEQUENCE
    SELECT DBAPORTAL.SEQ_REGISTRO_OCORRENCIA.NEXTVAL INTO V_CD_REGISTRO_OCORRENCIA FROM DUAL;

    INSERT INTO DBAPORTAL.REGISTRO_OCORRENCIA  (CD_REGISTRO_OCORRENCIA,
                                                CD_ORGANIZACAO_REGISTRANTE,
                                                CD_CENTRO_CUSTO_REGISTRANTE,
                                                ID_USUARIO_REGISTRANTE,
                                                CD_ORGANIZACAO_RELATOR,
                                                CD_CENTRO_CUSTO_RELATOR,
                                                ID_USUARIO_RELATOR,
                                                CD_OCORRENCIA,
                                                DS_RESUMO,
                                                DS_REGISTRO,
                                                CD_METODO_DETECCAO_OCORRENCIA,
                                                CD_ACAO_IMEDIATA_OCORRENCIA,
                                                CD_ATENDIMENTO,
                                                DH_OCORRIDO,
                                                HR_OCORRIDO,
                                                DT_REGISTRO)
    SELECT  V_CD_REGISTRO_OCORRENCIA,
            p_CD_ORGANIZACAO_REGISTRANTE,
            p_CD_CENTRO_CUSTO_REGISTRANTE,
            p_ID_USUARIO_REGISTRANTE,
            p_CD_ORGANIZACAO_RELATOR,
            p_CD_CENTRO_CUSTO_RELATOR,
            p_ID_USUARIO_RELATOR,
            p_CD_OCORRENCIA,
            p_DS_RESUMO,
            p_DS_REGISTRO,
            p_CD_METODO_DETECCAO_OCOR,
            p_CD_ACAO_IMEDIATA_OCOR,
            p_CD_ATENDIMENTO,
            p_DH_OCORRIDO,
            p_HR_OCORRIDO,
            sysdate FROM DUAL;
-- BUSCAR O RESPONSAVEL PELA PROXIMA FASE

    EXECUTE IMMEDIATE ' select count(*) from dbaportal.ocorrencia o, dbaportal.ocorrencia_workflow_formulario owf,
     dbaportal.workflow_ocorrencia o, dbaportal.tipo_fluxo_ocorrencia tf
    where o.cd_ocorrencia = owf.cd_ocorrencia
      and o.cd_ocorrencia = ' || p_CD_OCORRENCIA ||
     ' and owf.cd_organizacao = ' || p_CD_ORGANIZACAO_RELATOR ||
     ' and owf.cd_workflow_ocorrencia = tf.cd_workflow_ocorrencia
      and tf.cd_fluxo_ocorrencia = 2'
    INTO v_tem_fluxo;

    if (v_tem_fluxo > 0) then

        select distinct tf.id_usuario_responsavel, tf.cd_papel_responsavel, tf.tp_setor_responsavel, tf.qt_sla, tf.sn_email
        into v_id_usuario_responsavel, v_cd_papel_responsavel, v_tp_setor_responsavel, v_qt_sla, v_sn_email
         from dbaportal.ocorrencia o, dbaportal.ocorrencia_workflow_formulario owf,
         dbaportal.workflow_ocorrencia o, dbaportal.tipo_fluxo_ocorrencia tf
        where o.cd_ocorrencia = owf.cd_ocorrencia
          and o.cd_ocorrencia = p_CD_OCORRENCIA
          and owf.cd_organizacao = p_CD_ORGANIZACAO_RELATOR
          and owf.cd_workflow_ocorrencia = tf.cd_workflow_ocorrencia
          and tf.cd_fluxo_ocorrencia = 2;
    else
            select distinct tf.id_usuario_responsavel, tf.cd_papel_responsavel, tf.tp_setor_responsavel, tf.qt_sla, tf.sn_email
            into v_id_usuario_responsavel, v_cd_papel_responsavel, v_tp_setor_responsavel, v_qt_sla, v_sn_email
             from dbaportal.ocorrencia o, dbaportal.ocorrencia_workflow_formulario owf,
             dbaportal.workflow_ocorrencia o, dbaportal.tipo_fluxo_ocorrencia tf
            where o.cd_ocorrencia = owf.cd_ocorrencia
              and o.cd_ocorrencia = p_CD_OCORRENCIA
              and owf.cd_organizacao is null
              and owf.cd_workflow_ocorrencia = tf.cd_workflow_ocorrencia
              and tf.cd_fluxo_ocorrencia = 2;
    end if;

-- INSERT NA TABELA FLUXO_QUADRO_OCORRENCIA REFERENTE AO FLUXO REGISTRO
        INSERT INTO DBAPORTAL.FLUXO_QUADRO_OCORRENCIA(CD_FLUXO_QUADRO_OCORRENCIA
                                                    ,CD_FLUXO_OCORRENCIA
                                                    ,CD_REGISTRO_OCORRENCIA
                                                    ,TP_RESPONSAVEL_FLUXO
                                                    ,TP_SITUACAO
                                                    ,DT_CONCLUSAO
                                                    ,DT_ACEITACAO
                                                    ,SN_EMAIL
                                                    ,NR_ORDENACAO
                                                    ,SN_PERSONALIZADO
                                                    ,ID_USUARIO_PORTAL_RESP
                                                    ,ID_USUARIO_EXECUTOR
                                                    ,ID_USUARIO_PORTAL_LOGADO)
        SELECT  DBAPORTAL.SEQ_FLUXO_QUADRO_OCORRENCIA.NEXTVAL,
                1,
                v_cd_registro_ocorrencia,
                'PE',
                'C',
                sysdate,
                sysdate,
                'S',
                1,
                'N',
                p_ID_USUARIO_REGISTRANTE,
                p_ID_USUARIO_REGISTRANTE,
                p_ID_USUARIO_REGISTRANTE FROM DUAL;

-- INSERT NA TABELA FLUXO_QUADRO_OCORRENCIA REFERENTE AO FLUXO AVALIAC?O

        INSERT INTO DBAPORTAL.FLUXO_QUADRO_OCORRENCIA(CD_FLUXO_QUADRO_OCORRENCIA
                                                    ,CD_FLUXO_OCORRENCIA
                                                    ,CD_REGISTRO_OCORRENCIA
                                                    ,TP_RESPONSAVEL_FLUXO
                                                    ,ID_USUARIO_PORTAL_RESP
                                                    ,CD_PAPEL_RESP
                                                    ,CD_CENTRO_CUSTO_RESP
                                                    ,TP_SITUACAO
                                                    ,SN_EMAIL
                                                    ,NR_ORDENACAO
                                                    ,QT_SLA
                                                    ,SN_PERSONALIZADO)
        SELECT  DBAPORTAL.SEQ_FLUXO_QUADRO_OCORRENCIA.NEXTVAL,
                2,
                v_cd_registro_ocorrencia,
                case when v_id_usuario_responsavel is not null then 'PE' else
                    case when v_cd_papel_responsavel is not null then 'PA' else v_tp_setor_responsavel end end,
                v_id_usuario_responsavel,
                v_cd_papel_responsavel,
                case when v_tp_setor_responsavel = '1' then p_cd_centro_custo_registrante else
                    case when v_tp_setor_responsavel = '2' then p_cd_centro_custo_relator else null end end,
                'D',
                v_sn_email,
                2,
                v_qt_sla,
                'N'
        FROM DUAL;

--INSERT NA TABELA HISTORICO_REG_OCORRENCIA REFEFENTE AO HISTORICO DO REGISTRO
              INSERT INTO dbaportal.HISTORICO_REG_OCORRENCIA
                        (CD_HISTORICO_REG_OCORRENCIA
                       , CD_REGISTRO_OCORRENCIA
                       , CD_FLUXO_QUADRO_OCORRENCIA
                       , CD_FLUXO_OCORRENCIA
                       , CD_OCORRENCIA
                       , TP_ACAO
                       , DS_ACAO
                       , DS_COMENTARIO
                       , DT_MUDANCA_FLUXO
                       , DT_ACEITACAO
                        )
              SELECT DBAPORTAL.SEQ_HISTORICO_REG_OCORRENCIA.NEXTVAL
                       , cd_registro_ocorrencia
                       , cd_fluxo_quadro_ocorrencia
                       , cd_fluxo_ocorrencia
                       , p_cd_ocorrencia
                       , 0
                       , 'ROC - Registro de ocorrencia completo automatico foi salvo com sucesso.'
                       , p_ds_resumo
                       , sysdate
                       , sysdate
                FROM dbaportal.fluxo_quadro_ocorrencia where cd_registro_ocorrencia = v_cd_registro_ocorrencia and cd_fluxo_ocorrencia = 1;
    COMMIT;
END;
/

