/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2012 (11.0.5058)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2012
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [DB5693_SAIDA]
GO

/****** Object:  StoredProcedure [Arquivo].[SAISP005_CSV_282]    Script Date: 14/09/2017 13:03:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 =====================================================================================
 Migrado por :		<Renato Ferreira>
 Data criacao:		<17/08/2017>
 pacote VeraCruz :  pkgMOVIMENTOS_Producao_PEOPI_CTR_Subsidio
 Arquivo (VeraCruz): PEOPI_Movimentos_CTR_Subsidio_AAAAMMDD.ZIP
 Dependencias : 

					[DB5693_SIACI].[MOVIMENTO].[ACITB001_PEDIDO_ATIVO] 
					[DB5693_SIACI].[Parametro].[ACITBC01_CARTEIRA_ORIGEM_REGISTRO]  
					[DB5693_SIACI].[Siger].[ACITB001_PAGAMENTO] 

=======================================================================================



*/


ALTER PROCEDURE [Arquivo].[SAISP005_CSV_282]
AS
BEGIN

SELECT 
     TP.NU_ADMINISTRADOR                                             as ADMINISTRADOR
   , TP.NU_CREDOR                                                    as CREDOR
   , TP.NU_CONTRATO                                                  as IDENT
   , TP.NU_CATEGORIA_PEDIDO                                          as TP_REG
   , TP.DT_EVENTO                                                    as DATA
   , TP.NU_ESTADO_PEDIDO                                             as STATUS_PEDIDO
   , TP.NU_FASE_PEDIDO                                               as SISTEMA
   , TP.NU_UNIDADE_CENTRALIZADORA                                    as UNIDADE_CENTRALIZADORA
   , TP.NU_UNIDADE_MOVIMENTO                                         as UNIDADE_MOVIMENTO
   , TP.NU_UNIDADE_OPERACIONAL                                       as UNIDADE_OPERACIONAL
   , TP.NU_CONTRATO_DV                                               as DIGITO_CONTRATO
   , TP.NO_MUTUARIO                                                  as NOME_MUTUARIO
   , TP.NU_CPF_CNPJ_MUTUARIO                                         as CPF
   , TP.VR_EVENTO                                                    as VALOR
   , TP.NU_TIPO_FINANCIAMENTO                                        as TIPO_FINANCIAMENTO
   , TP.NU_LINHA_FINANCIAMENTO                                       as LINHA_FINACIAMENTO
   , TP.PC_TAXA_JUROS_NOMINAL_INICIAL                                as TAXA_INICIAL
   , TP.NO_MUNICIPIO_IMOVEL                                          as CIDADE_IMOVEL
   , TP.NU_MUNICIPIO_IMOVEL                                          as CODIGO_MUNICIPIO
   , TP.SG_UF_IMOVEL                                                 as UF
   , TP.VR_RENDA_FAMILIAR_COMPROVADA                                 as RENDA
   , TP.NU_TIPO_PEDIDO                                               as PEDIDO_CODIGO
   , TP.VR_SALDO_DEVEDOR_ANTERIOR                                    as SALDO_DEVEDOR_ANTERIOR
   , TP.PZ_FINANCIAMENTO                                             as PRAZO
   , TP.NU_CATEGORIA_IMOVEL                                          as CATEGORIA_IMOVEL
   , TP.NU_ORIGEM_RECURSO                                            as ORIGEM_RECURSO
   , TP.NU_SUBTITULO_CONTABIL                                        As SUBTITULO_CONTABIL
  ,  TP.NU_TIPO_CONCESSAO_1                                          as TAXA_FINAL
   , TP.PC_TAXA_CONCESSAO_1                                          as TIPO_CONCESSAO
   , TP.NU_LEGISLACAO                                                as CODIGO_LEGISLACAO
   , TP.DT_REMESSA                                                   as DATA_REMESSA
   , TP.NU_TIPO_REPASSE                                              as TIPO_REPASSE
   , TP.NU_AGENTE_REPASSE                                            as AGENTE_CEDENTE
   , TP.NU_CONTRATO_REPASSE                                          as CONTRATAO_REPASSE
   , TP.NU_TIPO_COMANDO                                              as CODIGO_ATUALIZACAO
   , TP.VR_DESCONTO_LIQUIDACAO_TRANSFERENCIA                         as FIN_DESC                    
   , TP.VR_DISPENSA_MORA                                             as DISPENSA_MORA
   , TP.NU_GRUPO_HABITACIONAL_GRH                                    as GRUPO_HAB
   , TP.VR_FGTS_UTILIZADO                                            as FGTS
   , TP.VR_DESCONTO_PARTICIPACAO_CAIXA                               as PART_CEF
   , TP.VR_DESCONTO_PARTICIPACAO_FCVS                                as FCVS
   , TP.VR_SALDO_DEVEDOR_POSTERIOR_PEDIDO                            As SALDO_DEVDOR_APOS_PED
   , TP.IC_RENDA_COMPROMETIDA_ACIMA_LIMITE                           as FLAG_RENDA
   , TP.NU_TIPO_SEXO                                                 as SEXO
   , TP.DT_NASCIMENTO_MUTUARIO                                       as DATA_NASCIMENTO
   , TP.NU_MODO_IMPLANTACAO                                          as MODO_IMPLANTACAO
   , TP.NU_REGENCIA_CRITICA                                          as RCR
   , TP.NU_REGENCIA_EVOLUCAO                                         as RGE
   , TP.NU_REGENCIA_EVOLUCAO_ANTERIOR                                as RGE_ANT
   , TP.VR_PRESTACAO_INICIAL                                         as VAL_PREST
   , TP.VR_GARANTIA                                                  AS VAL_GARANT
   , TP.DT_CONTRATACAO                                               as DT_FINANC
   , TP.NU_TIPO_CONCESSAO_2                                          as PERC_DESC
   , TP.DT_PROCESSAMENTO_PEDIDO_SIACI                                as DATA_ATUALIZACAO
   , TP.NU_CONTRATO_EMPREENDIMENTO                                   as EPR_IDENTIFICACAO
   , TP.VR_TAXA_MENSAL_COBRANCA_ADMINISTRACAO_TCA                    as TAXA_TCA
   , TP.VR_TAXA_MANUTENCAO_COBRANCA_TMC1                             as TAXA_TCM1
   , TP.VR_TAXA_MANUTENCAO_COBRANCA_TMC2                             as TAXA_TCM2
   , TP.VR_TAXA_MENSAL_ACOMPANHAMENTO_OBRA_TAO                       as TAXA_TAO
   , TP.VR_TAXA_MENSAL_RISCO_CREDITO_TRC                             as TAXA_TRC
   , TP.VR_TAXA_ABERTURA_CREDITO_PARCELADA_TA                        as TAXA_PARCELA
   , TP.VR_TAXA_MENSAL_ADMINISTRACAO_TA                              as TAXA_TA
   , TP.VR_TAXA_ABERTURA_CREDITO_PARCELADA_TA                        as TAXA_A_VISTA
   , TP.VR_SUBSIDIO_EQUILIBRIO                                       as SUBSIDIO_AGENTE
   , TP.VR_SUBSIDIO_COMPLEMENTO                                      as SUBSIDIO_CONCESSAO
   , TP.DT_CARGA                                                     as DATA_CARGA
   , TP.VR_DIVIDA_TOTAL_ANTERIOR_PEDIDO                              as DIVIDA_VENCIDA
   , TP.VR_ENCARGO_ATRASO_ANTERIOR_PEDIDO                            as ENCARGO_ANTERIROR
   , PG.VR_CORRECAO_MONETARIA                                        as ATUALIZ_MONET_ANT_COMANDO
   , PG.VR_JUROS_MORATORIO                                           as JUROS_MORA_ANT_COMANDO
   , PG.VR_JUROS_REMUNERATORIO                                       as JUROS_REM_ANT_COMANDO 
   , TP.VR_PRESTACAO_LIQUIDA_ATUAL                                   as PREST_APOS_COMANDO 
   , TP.NU_VOTO                                                      as CODIGO_VOTO
   , TP.VR_PAGAMENTO_SEGURO                                          as SOMATORIO_SEGURO
   , TP.VR_PAGAMENTO_JUROS                                           as SOMATORIO_JUROS
   , TP.VR_PAGAMENTO_AMORTIZACAO                                     as SOMATORIO_AMORTIZACAO
   , TP.VR_PAGAMENTO_TOTAL_TAXA                                      as SOMATORIO_TAXAS_PREST
   , TP.VR_TOTAL_TAXA_A_VISTA_TP22                                   as SOMATORIO_TAXA_A_VISTA_TP22
   , TP.VR_TOTAL_DIFERENCA_LIQUIDACAO_TP23                           as SOMATORIO_DIF_LIQ_TP23
   , TP.VR_DIVIDA_TOTAL_ANTERIOR_PEDIDO                              as TOTAL_DIVIDA
   , TP.VR_DESCONTO_PARTICIPACAO_FCVS                                as DESCONTO_LEGAL
   , TP.VR_DIFERENCA_DESCONTO_ADICIONAL_EMGEA                        as DIFERENCA_DESCONTO_ADICIONAL_EMGEA
   , TP.VR_DIFERENCA_DESCONTO_ADICIONAL_FGTS                         as DIFERENCA_DESCONTO_ADICIONAL_FGTS
   , TP.VR_TAXA_ADMINISTRACAO_FGTS                                   as TAXA_ADMINISTRACAO_FGTS
   , TP.VR_DIFERENCIAL_JUROS_FGTS                                    as VR_DIFERENCIAL_JUROS_FGTS
   , TP.NU_SEQUENCIAL_PEDIDO                                         as SEGUENCIAL_PEDIDO
   , TP.NU_SEQUENCIAL_PEDIDO_AUTOMATICO                              as SEQUENCIAL_PEDIDO_AUTOMATICO
   , TP.NU_SEQUENCIAL_VOTO                                           as SEQUENCIAL_VOTO
   , TP.VR_INVESTIMENTO                                              as VALOR_INVESTIMENTO
   , TP.VR_CONTRAPARTIDA                                             as VALOR_CONTRAPARTIDA_GARANTIA
   , TP.NU_TIPO_GARANTIA                                             as TIPO_GARANTIA
   , TP.NU_PRODUTO                                                   as CODIGO_PRODUTO
   , TP.VR_APORTE_CONSTRUTORA                                        as VALOR_APORTE_CONSTRUTORA
   , TP.VR_DESCONTO_RESOLUCAO_460                                    as VALOR_DESCONTO_460
   , TP.NU_SISTEMA_FINANCEIRO                                        as CODIGO_SITEMA_FINANCEIRO
   , NULL                                                            as CODIGO_PRODUTO
   , NULL                                                            as SUBCODIGO_PRODUTO
   , TP.QT_SALARIO_MINIMO_RENDA_FAMILIAR_CONTRATACAO                 as RENDA_SALARIO_MINIMO

FROM     

[DB5693_SIACI].[MOVIMENTO].[ACITB001_PEDIDO_ATIVO] TP
INNER JOIN [DB5693_SIACI].[Parametro].[ACITBC01_CARTEIRA_ORIGEM_REGISTRO] CO 
   on TP.NU_CARTEIRA_ORIGEM_REGISTRO = CO.NU_CARTEIRA_ORIGEM_REGISTRO

LEFT OUTER JOIN [DB5693_SIACI].[Siger].[ACITB001_PAGAMENTO] PG
   on TP.NU_CONTRATO = PG.NU_CONTRATO

WHERE 
(TP.NU_TIPO_PEDIDO IN (1, 5) 
AND 
(TP.NU_ESTADO_PEDIDO = 1) 

AND 
(
   TP.NU_ORIGEM_RECURSO IN (40,35,26,27,28,44)
   or
   TP.VR_SUBSIDIO_EQUILIBRIO<> 0
   or 
   TP.VR_SUBSIDIO_COMPLEMENTO <> 0
)
)

--OPTION (MAXDROP 1)

END 
GO

