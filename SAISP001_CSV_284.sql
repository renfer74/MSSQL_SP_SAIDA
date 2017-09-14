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

/****** Object:  StoredProcedure [Arquivo].[SAISP007_CSV_284]    Script Date: 14/09/2017 13:03:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 =====================================================================================
 Migrado por :			<Renato Ferreira>
 data criacao:			<17/08/2017>
 Descricao :			pkgMOVIMENTOS_Producao_SEGMENTACAO_TIPO_REGISTRO_CONTRATACAO
 Arquivo (veracruz) :	MOVIMENTOS_CONTRATACAO_AAAMMDD.7z
 Peridiocidade :		Diario
 Dependencias : 
     					[DB5693_SIACI].[Movimento].[ACITB001_PEDIDO_ATIVO] A 
						[DB5693_SIACI].[Siger].[ACITB001_PAGAMENTO] B
=======================================================================================

*/


ALTER PROCEDURE [Arquivo].[SAISP007_CSV_284]
AS
BEGIN
/*


  contratacao ->> 	A.NU_CATEGORIA_PEDIDO=1 
  amortizacao ->>	 A.NU_CATEGORIA_PEDIDO=6
  liquidacao ->> 	A.NU_CATEGORIA_PEDIDO=2
  Renegociacao ->>	 A.NU_CATEGORIA_PEDIDO=5
  Transferencia ->> A.NU_CATEGORIA_PEDIDO=4
  termino_obra -->> A.NU_CATEGORIA_PEDIDO=3


*/

--- CONTRATACAO 

DECLARE @nu_categoria_pedido as tinyint
SET @nu_categoria_pedido=1


SELECT  ---TOP 100
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
  

/* ORIGINAL
SELECT	ADMINISTRADOR,
		CREDOR,
		IDENT,
		TP_REG,
		DATA,
		STATUS,
		SISTEMA, 
		EN, 
		UMO, 
		UNO, 
		DIGITO, 
		MUT, 
		CPF, 
		VALOR, 
		TF, 
		LF, 
		TX_INIC,
		CIDADE,
		CODMUN,
		UF,
		RENDA,
		PED_COD,
		SALDO_DEV_ANT,
		PRAZO,
		CAT_IMO,
		ORR_COD,
		SUBTITULO_CONT,
		TX_FINAL,
		TIPO_CONCESSAO,
		COD_LEGISL,
		DT_REMESSA,
		TIPO_REPASSE,
		AGENTE_CEDENTE,
		CNT_REPASSE,
		COD_ATU,
		FIN_DESC,
		DISPENSA_MORA,
		GRUPO_HAB,
		FGTS,
		PART_CEF,
		FCVS,
		SALDO_DEV_APO,
		FLAG_RENDA,
		SEXO,
		DT_NASC,
		MODO_IMPL,
		RCR,
		RGE,
		RGE_ANT,
		VAL_PREST,
		VAL_GARANT,
		DT_FINANC,
		PERC_DESC,
		DATA_ATUALIZACAO,
		EPR_IDENTIFICACAO,
		TAXA_TCA,
		TAXA_TMC1,
		TAXA_TMC2,
		TAXA_TAO,
		TAXA_TRC,
		TAXA_PARCELA,
		TAXA_TA,
		TAXA_A_VISTA,
		SUBSIDIO_AGENTE, 
        SUBSIDIO_CONCESSAO,
        DATA_CARGA,
        DIVIDA_VENCIDA,
        ENCARGOS_ANTERIOR,
        ATUALIZ_MONET_ANT_COMANDO,
        JUROS_MORA_ANT_COMANDO,
        JUROS_REM_ANT_COMANDO, 
        PREST_APOS_COMANDO,
        CODIGO_VOTO, 
        SOMAT_SEGUROS,
        SOMAT_JUROS, 
        SOMAT_AMORTIZACAO, 
        SOMAT_TAXAS_PREST, 
        SOMAT_TAXAVIS_TP22, 
         SOMAT_DIFLIQ_TP23, 
       

        TOTAL_DIVIDA,
        DESC_LEGAL,
        DIF_DESC_ADICIONAL, 
        DESC_ADIC_FGTS, 
        TAXA_ADM, 
        DIF_JUROS, 
        SEQ_PED, 
        SEQ_PED_AUT, 
        SEQ_VOTO, 
        VLR_INVESTIMENTO, 
        VLR_CONTRAPARTIDA, 
        TIP_GARANTIA, 
        COD_PRODUTO, 
        VLR_APORTE_CONSTRUTORA, 
        VLR_DESCONTO_460, 
        COD_SISTEMA_FINANCEIRO, 
        LEFT(COD_PROD, 3) AS CODIGO_PRODUTO, 
        LEFT(COD_SUBPROD, 3) AS SUBCODIGO_PRODUTO, 
        RENDA_SM, 
        AS idFlagSICAQ
FROM         
WHERE     idCategoriaPedidoProcessamento=1









SELECT     
	A.idAdministrador AS ADMINISTRADOR, 
	A.idCredor AS CREDOR, 
	A.idContrato AS IDENT, 
	A.idCategoriaPedidoProcessamento AS TP_REG, 
	A.dtEvento AS DATA, 
	A.idEstadoPedido AS STATUS, 
    A.idBancoConstrucao AS SISTEMA, 
	C.idUnidadeCentralizadora AS EN, A.idUnidadeMovimento AS UMO, D.idUnidadeOperacional AS UNO, A.dvContrato AS DIGITO, E.nomeMutuario AS MUT, 
             E.CPFCGCMutuario AS CPF, F.vlrEvento AS VALOR, D.idTipoFinanciamento AS TF, D.idLinhaFinanciamento AS LF, F.percTaxaJurosInicial AS TX_INIC, G.cidadeImovel AS CIDADE, 
             G.idCodigoMunicipioImovel AS CODMUN, G.UFImovel AS UF, E.vlrRendaFamiliarComprovada AS RENDA, A.idTipoPedido AS PED_COD, H.vlrSaldoDevedorAntes AS SALDO_DEV_ANT, 
             F.prazoFinanciamento AS PRAZO, G.idCategoriaImovel AS CAT_IMO, D.idOrigemRecursos AS ORR_COD, D.idSubtituloContabil AS SUBTITULO_CONT, F.taxaConcessao1 AS TX_FINAL, 
             F.idTipoConcessao1 AS TIPO_CONCESSAO, F.idCodigoLegislacao AS COD_LEGISL, A.dtRemessa AS DT_REMESSA, I.repasseTipo AS TIPO_REPASSE, I.repasseAgente AS AGENTE_CEDENTE, 
             I.repasseIdContrato AS CNT_REPASSE, A.idCodigoAtualizacao AS COD_ATU, H.vlrDesconto AS FIN_DESC, J.vlrDispensaMora AS DISPENSA_MORA, G.idGrupoHabitacionalGRH AS GRUPO_HAB, 
             K.vlrFGTSUtilizado AS FGTS, H.vlrDescontoParticipacaoCaixa AS PART_CEF, H.vlrDescontoParticipacaoFCVS AS FCVS, C.vlrSaldoDevedorApos AS SALDO_DEV_APO, 
             E.idComprometimentoRendaAcimaEsperado AS FLAG_RENDA, E.idSexo AS SEXO, E.dtNascimentoMutuario AS DT_NASC, F.idModoImplantacao AS MODO_IMPL, F.idRegenciaCritica AS RCR, 
             F.idRegenciaEvolucao AS RGE, H.idRegenciaEvolucaoAntes AS RGE_ANT, L.vlrPrestacaoInicial AS VAL_PREST, F.vlrAvaliacao AS VAL_GARANT, F.dtContratacao AS DT_FINANC, 
             F.taxaConcessao2 AS PERC_DESC, A.dtAtualizacaoPedidoProcessamento AS DATA_ATUALIZACAO, D.idContratoEmpreendimento AS EPR_IDENTIFICACAO, L.vlrTCA AS TAXA_TCA, 
             L.vlrTMC1 AS TAXA_TMC1, L.vlrTMC2 AS TAXA_TMC2, L.vlrTaxaAcompanhamentoObraTAO AS TAXA_TAO, L.vlrTaxaRiscoCredito AS TAXA_TRC, 
             L.vlrTaxaAberturaCreditoParcelada AS TAXA_PARCELA, L.vlrTaxaAdministracao AS TAXA_TA, M.vlrTaxaAberturaCredito AS TAXA_A_VISTA, F.vlrSubsidioAgenteFinanceiro AS SUBSIDIO_AGENTE, 
             F.vlrSubsidioMutuario AS SUBSIDIO_CONCESSAO, A.dtAtualizacao AS DATA_CARGA, H.vlrDividaAntes AS DIVIDA_VENCIDA, H.vlrTotalEncargosAntes AS ENCARGOS_ANTERIOR, 
             J.vlrPagamentoCorrecaoMonetaria AS ATUALIZ_MONET_ANT_COMANDO, J.vlrPagamentoJurosMora AS JUROS_MORA_ANT_COMANDO, 
             J.vlrPagamentoJurosRemuneratorios AS JUROS_REM_ANT_COMANDO, C.vlrPrestacaoApos AS PREST_APOS_COMANDO, F.idVoto AS CODIGO_VOTO, 
             J.vlrPagamentoSeguros AS SOMAT_SEGUROS, J.vlrPagamentoJuros AS SOMAT_JUROS, J.vlrPagamentoAmortizacao AS SOMAT_AMORTIZACAO, J.vlrPagamentoTaxas AS SOMAT_TAXAS_PREST, 
             J.vlrPagamentoTaxasVistaTP22 AS SOMAT_TAXAVIS_TP22, J.vlrPagamentoDiferencaLiquidacaoTP23 AS SOMAT_DIFLIQ_TP23, H.vlrTotalDividaAntes AS TOTAL_DIVIDA, 
             H.vlrDescontoLegalFCVS AS DESC_LEGAL, H.vlrDescontoAdicionalEMGEA AS DIF_DESC_ADICIONAL, H.vlrDescontoAdicionalFGTS AS DESC_ADIC_FGTS, 
             F.vlrTaxaAdministracaoFGTS AS TAXA_ADM, F.vlrTaxaDiferencialJurosFGTS AS DIF_JUROS, A.sequencialPedido AS SEQ_PED, A.sequencialPedidoAutomatico AS SEQ_PED_AUT, 
             F.sequencialVoto AS SEQ_VOTO, M.vlrInvestimento AS VLR_INVESTIMENTO, M.vlrContrapartida AS VLR_CONTRAPARTIDA, F.idTipoGarantia AS TIP_GARANTIA, 
             D.idCodigoProdutoContabil AS COD_PRODUTO, N.vlrAporteConstrutoraRPA AS VLR_APORTE_CONSTRUTORA, H.vlrDescontoResolucao460 AS VLR_DESCONTO_460, 
             C.idSistemaFinanceiro AS COD_SISTEMA_FINANCEIRO, E.numPIS, H.idCodigoTrancamento, O.vlrTaxaArrendamento, O.vlrTaxaOciosidade, O.vlrTaxaOcupacao, O.idContratoArrendamentoAnterior, 
             C.qtdeSalarioMinimoRendaFamiliar AS RENDA_SM, O.idContratoImovelPAR, O.idEmpreendimentoPAR AS idEmpreendiemtnoPAR, O.idEstadoImovel, N.vlrCompraVenda AS VLR_COMPR_VEN, 
             N.vlrAvaliacaoTerreno AS VLR_AVAL_TERRENO, N.vlrCompraVendaTerreno AS VLR_COMP_VEN_TER, N.vlrFinanciamentoTerreno AS VLR_FINANC_TERR, 
             N.vlrAvaliacaoCustoObra AS VLR_CUSTO_OBRA, N.dtCompetenciaObra AS DT_COMPET_OBRA, F.idCriterioExcepcionalizacao AS COD_EXCEP, F.idCriterioCritica AS COD_CRITERIO_CRITICA, 
             H.idContratoPassivo AS NUM_CTR_PASSIVO, E.vlrPrestacaoMaximaContratar AS VLR_MAX_PRESTACAO, N.dtTerminoObra AS DATA_TERMINO_OBRA, N.prazoConstrucao AS PRAZO_CN, 
             N.vlrRecursosProprios AS VLR_RECURSO_PROPRIO, H.prazoRemanescente AS PRAZO_REM, A.idSolicitante AS COD_SOLICITANTE, E.codigoRating AS COD_RATING, 
             E.idClassificacaoCliente AS COD_CLASSIFICACAO, E.avaliacaoRisco AS COD_AVALIACAO_RISCO, F.idTipoConcessao2 AS TIPO_CONCESS_2, F.percRedutorTaxaJuros AS VLR_IND_REDUTOR, 
             F.percTaxaJurosReduzida AS VLR_TAXA_JURO_REDUZIDO, D.idUnidadeCobrancaContaVinculada AS COD_UNO_VINCULADA, D.numeroContaVinculada AS NUM_CONTA_VINCULADA, NULL 
                      AS COD_PROD, NULL AS COD_SUBPROD, A.idNumeroPedidoSIACI AS PED_NUMERO, A.idFlagSICAQ
FROM         dbo.tbR00Pedido A (nolock) INNER JOIN
                      dbo.tbSistemaOrigem B  (nolock) ON A.idSistemaOrigem = B.idSistemaOrigem LEFT OUTER JOIN
                      dbo.tbPosProcessamento C  (nolock) ON A.idNumeroPedidoGerado = C.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR03CondicoesFinanciamento D  (nolock) ON A.idNumeroPedidoGerado = D.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR01DadosMutuario E  (nolock) ON A.idNumeroPedidoGerado = E.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR06DadosFinanciamento F  (nolock) ON A.idNumeroPedidoGerado = F.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR04DadosImovel G (nolock)  ON A.idNumeroPedidoGerado = G.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbPreProcessamento H (nolock)  ON A.idNumeroPedidoGerado = H.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR11DadosContratoEscritura I (nolock)  ON A.idNumeroPedidoGerado = I.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbPagamentos J (nolock)  ON A.idNumeroPedidoGerado = J.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR10UtilizacaoFGTS K (nolock)  ON A.idNumeroPedidoGerado = K.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR09ComponenteEncargo L (nolock)  ON A.idNumeroPedidoGerado = L.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR07DespesasFinanciamento M (nolock)  ON A.idNumeroPedidoGerado = M.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbR16DadosFinanceirosConstrucao N (nolock)  ON A.idNumeroPedidoGerado = N.idNumeroPedidoGerado LEFT OUTER JOIN
                      dbo.tbPAR O (nolock)  ON A.idNumeroPedidoGerado = O.idNumeroPedidoGerado

WHERE     (A.idSituacaoRegistro = 0)
*/

END 
GO

