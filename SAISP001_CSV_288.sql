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

/****** Object:  StoredProcedure [Arquivo].[SAISP012_CSV_288]    Script Date: 14/09/2017 13:04:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 =====================================================================================
 Migrado por :			<Renato Ferreira>
 data criacao:			<17/08/2017>
 Descricao :			pkgMOVIMENTOS_Producao_SEGMENTACAO_TIPO_REGISTRO_LIQUIDACAO
 Arquivo (veracruz) :	MOVIMENTOS_LIQUIDACAO_AAAMMDD.7z
 Peridiocidade :		Diario
 Dependencias : 
     					[DB5693_SIACI].[Movimento].[ACITB001_PEDIDO_ATIVO] A 
						[DB5693_SIACI].[Siger].[ACITB001_PAGAMENTO] B


=======================================================================================



  contratacao ->> 	A.NU_CATEGORIA_PEDIDO=1 
  amortizacao ->>	 A.NU_CATEGORIA_PEDIDO=6
  liquidacao ->> 	A.NU_CATEGORIA_PEDIDO=2
  Renegociacao ->>	 A.NU_CATEGORIA_PEDIDO=5
  Transferencia ->> A.NU_CATEGORIA_PEDIDO=4
  termino_obra -->> A.NU_CATEGORIA_PEDIDO=3
  

*/

ALTER PROCEDURE [Arquivo].[SAISP012_CSV_288]
AS
BEGIN


DECLARE @nu_categoria_pedido as tinyint
SET @nu_categoria_pedido=2


SELECT 
		A.NU_ADMINISTRADOR AS ADMINISTRADOR,
		A.NU_CREDOR AS CREDOR,
		A.NU_CONTRATO AS IDENT,
		A.NU_CATEGORIA_PEDIDO AS TP_REG,
		A.DT_EVENTO AS DATA,
		A.NU_ESTADO_PEDIDO AS STATUS,
		A.NU_FASE_PEDIDO  AS SISTEMA,
		A.NU_UNIDADE_CENTRALIZADORA AS EN, 
		A.NU_UNIDADE_MOVIMENTO AS UMO,
		A.NU_UNIDADE_MOVIMENTO AS UNO,
		A.NU_CONTRATO_DV AS DIGITO,
		A.NO_MUTUARIO AS MUT,
		A.NU_CPF_CNPJ_MUTUARIO AS CPF,
		A.VR_EVENTO AS VALOR,
		A.NU_TIPO_FINANCIAMENTO AS TF,
		A.NU_LINHA_FINANCIAMENTO AS LF,
		A.PC_TAXA_JUROS_NOMINAL_INICIAL AS TX_INIC,
		A.NO_MUNICIPIO_IMOVEL AS CIDADE,
		A.NU_MUNICIPIO_IMOVEL AS CODMUN,
		A.SG_UF_IMOVEL AS UF,
		A.VR_RENDA_FAMILIAR_COMPROVADA AS RENDA,
		A.NU_TIPO_PEDIDO AS PED_COD,
		A.VR_SALDO_DEVEDOR_ANTERIOR AS SALDO_DEV_ANT,
		A.PZ_FINANCIAMENTO AS PRAZO,
		A.NU_CATEGORIA_IMOVEL AS CAT_IMO,
		A.NU_ORIGEM_RECURSO AS ORR_COD,
		A.NU_SUBTITULO_CONTABIL SUBTITULO_CONT,
		A.PC_TAXA_CONCESSAO_1 AS TX_FINAL, 
		A.NU_TIPO_CONCESSAO_1 AS TIPO_CONCESSAO,
		A.NU_LEGISLACAO AS 	COD_LEGISL,
		A.DT_REMESSA AS DT_REMESSA, 
		A.NU_TIPO_REPASSE AS TIPO_REPASSE,  
		A.NU_AGENTE_REPASSE AS AGENTE_CEDENTE,
		A.NU_CONTRATO_REPASSE AS CNT_REPASSE,
		A.NU_TIPO_COMANDO COD_ATU,
		A.VR_DESCONTO_LIQUIDACAO_TRANSFERENCIA AS FIN_DESC,
		A.VR_DISPENSA_MORA AS DISPENSA_MORA,
		A.NU_GRUPO_HABITACIONAL_GRH AS GRUPO_HAB,
		A.VR_FGTS_UTILIZADO AS FGTS,
		A.VR_DESCONTO_PARTICIPACAO_CAIXA as PART_CEF,
		A.VR_DESCONTO_LEGAL_FCVS AS FCVS,
		A.VR_SALDO_DEVEDOR_POSTERIOR_PEDIDO,
		A.IC_RENDA_COMPROMETIDA_ACIMA_LIMITE AS FLAG_RENDA,                         
		A.NU_TIPO_SEXO,
		A.DT_NASCIMENTO_MUTUARIO 	DT_NASC,
		A.NU_MODO_IMPLANTACAO AS MODO_IMPL,
		A.NU_REGENCIA_CRITICA AS RCR,
		A.NU_REGENCIA_EVOLUCAO AS RGE,
		A.NU_REGENCIA_EVOLUCAO_ANTERIOR AS RGE_ANT,
		A.VR_PRESTACAO_INICIAL AS 		VAL_PREST,
		A.DT_CONTRATACAO AS DT_FINC,
		A.PC_TAXA_CONCESSAO_2 AS 	PERC_DESC,
		A.DT_PROCESSAMENTO_PEDIDO_SIACI AS DATA_ATUALIZACAO,
		A.NU_CONTRATO_EMPREENDIMENTO AS EPR_IDENTIFICACAO,
		A.VR_TAXA_MENSAL_COBRANCA_ADMINISTRACAO_TCA AS TAXA_TCA,
		A.VR_TAXA_MANUTENCAO_COBRANCA_TMC1 AS TAXA_TMC1,
		A.VR_TAXA_MANUTENCAO_COBRANCA_TMC2 AS TAXA_TMC2,
		A.VR_TAXA_MENSAL_ACOMPANHAMENTO_OBRA_TAO AS TAXA_TAO,
		A.VR_TAXA_MENSAL_RISCO_CREDITO_TRC AS TAXA_TRC,
		A.VR_TAXA_ABERTURA_CREDITO_PARCELADA_TA AS TAXA_PARCELA,
		A.VR_TAXA_ADMINISTRACAO_FGTS AS TAXA_TA,
		A.VR_TAXA_ABERTURA_CREDITO AS TAXA_A_VISTA,
		A.VR_SUBSIDIO_COMPLEMENTO AS SUBSIDIO_AGENTE,
		A.VR_SUBSIDIO_EQUILIBRIO AS SUBSIDIO_CONCESSAO,
		A.DT_CARGA AS       DATA_CARGA,
		A.VR_DIVIDA_TOTAL_ANTERIOR_PEDIDO AS  DIVIDA_VENCIDA,
		A.VR_DIVIDA_VENCIDA_ANTERIOR_PEDIDO AS ENCARGOS_ANTERIOR,
		B.VR_CORRECAO_MONETARIA AS  ATUALIZ_MONET_ANT_COMANDO, --- VERFIFICAR
		B.VR_JUROS_MORATORIO AS JUROS_MORA_ANT_COMANDO,
		B.VR_JUROS_REMUNERATORIO AS JUROS_REM_ANT_COMANDO, 
		B.VR_PRESTACAO AS  PREST_APOS_COMANDO,
		A.NU_VOTO AS CODIGO_VOTO, 
		(B.VR_SEGURO_CREDITO+B.VR_SEGURO_DFI+B.VR_SEGURO_MIP)  AS SOMAT_SEGUROS,-- VERIFICAR
		B.VR_PARCELA_JUROS AS SOMAT_JUROS, 
		B.VR_PARCELA_AMORTIZACAO AS SOMAT_AMORTIZACAO,
		(B.VR_TAXA_ARRENDAMENTO_MENSAL+B.VR_TAXA_OCIOSIDADE_MENSAL+B.VR_TAXA_OCUPACAO_MENSAL+B.VR_TAXA1+B.VR_TAXA2+B.VR_TAXA3+B.VR_TAXA4)  AS SOMAT_TAXAS_PREST, --- VERIFICAR
		A.VR_TOTAL_TAXA_A_VISTA_TP22 AS SOMAT_TAXAVIS_TP22, 
		A.VR_TOTAL_DIFERENCA_LIQUIDACAO_TP23  AS SOMAT_DIFLIQ_TP23,
		A.VR_DIVIDA_TOTAL_ANTERIOR_PEDIDO  AS TOTAL_DIVIDA,
		A.VR_DESCONTO_LEGAL_FCVS  AS DESC_LEGAL,
		A.VR_DIFERENCA_DESCONTO_ADICIONAL_EMGEA  AS DIF_DESC_ADICIONAL, 
		A.VR_DIFERENCA_DESCONTO_ADICIONAL_FGTS AS  DESC_ADIC_FGTS,
		A.VR_TAXA_ADMINISTRACAO_FGTS AS TAXA_ADM,
		A.VR_DIFERENCIAL_JUROS_FGTS AS DIF_JUROS,
		A.NU_SEQUENCIAL_PEDIDO        AS  SEQ_PED, 
		A.NU_SEQUENCIAL_PEDIDO_AUTOMATICO AS SEQ_PED_AUT, 
		A.NU_SEQUENCIAL_VOTO  AS SEQ_VOTO, 
		A.VR_INVESTIMENTO AS  VLR_INVESTIMENTO, 
		A.VR_CONTRAPARTIDA AS  VLR_CONTRAPARTIDA,
		A.NU_TIPO_GARANTIA AS TIP_GARANTIA,
		A.NU_PRODUTO AS COD_PRODUTO,
		A.VR_APORTE_CONSTRUTORA AS VLR_APORTE_CONSTRUTORA, 
		A.VR_DESCONTO_RESOLUCAO_460 AS VLR_DESCONTO_460 ,
		A.NU_SISTEMA_FINANCEIRO AS COD_SISTEMA_FINANCEIRO,
		CODIGO_PRODUTO=NULL,  -- Do Script original
        SUBCODIGO_PRODUTO = NULL, -- do script original
	    A.QT_SALARIO_MINIMO_RENDA_FAMILIAR_CONTRATACAO AS RENDA_SM,
		A.IC_ORIGEM_SICAQ AS idFlagSICAQ

FROM     		[DB5693_SIACI].[Movimento].[ACITB001_PEDIDO_ATIVO] A 
LEFT OUTER JOIN [DB5693_SIACI].[Siger].[ACITB001_PAGAMENTO] B
					ON A.NU_CONTRATO = B.NU_CONTRATO 
WHERE    			A.NU_CATEGORIA_PEDIDO=@nu_categoria_pedido
			    AND A.NU_CREDOR=1102
  
END 
GO
