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

/****** Object:  StoredProcedure [Arquivo].[SAISP002_CSV_279]    Script Date: 14/09/2017 13:02:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 ===================================================================================================================
 Migrado por :			<Renato Ferreira>
 data criacao:			<17/08/2017>
 Utima alteracao:       <04/09/2017>  - Substitucao da antiga tbGenac por view criada no banco [DB5693_SIACI]
 Descricao :			pkgsiliq_producao_siliq_cehma_bancoin  
 Arquivo (veraCruz):	SILIQ_CEHMA_BancoIN_AAAMMDD
 peridiocidade:			Mensal
 Dependencias :			[DB5693_SIACI].[MOVIMENTO].[ACITB001_PEDIDO_ATIVO] 
						[DB5693_SIACI].[SILIQ].[ACITB001_SILIQ] 
====================================================================================================================
*/


ALTER PROCEDURE [Arquivo].[SAISP002_CSV_279]
AS
BEGIN





SELECT --TOP 1000   
     TBS.DT_MOVIMENTO  dt_Movimento
   , TBS.NU_CONTRATO ctr
   , TBS.NU_DV_CONTRATO   dv_ctr
   , TBS.NU_TRANCAMENTO   sit_ctr
   , TBS.NU_SR  en
   , TBS.NU_UNIDADE_OPERACIONAL uno
   , TBS.DT_ASSINATURA_CONTRATO dt_ass
   , TBGENAC.PZ_AMORTIZACAO_AJUSTADO pz_amor
   , TBGENAC.PZ_REMANESCENTE_AJUSTADO pz_rem
   , TBS.PC_TAXA_JUROS_INICIAL tx_anual
   , TBS.PC_TAXA_JUROS_ATUAL tx_atual
   , TBS.VR_PRESTACAO_MES prest
   , TBS.VR_TAXA_TOM_MES tca
   , TBS.VR_FCVS  vlr_fcvs
   , TBS.VR_SEGURO_MES seguro
   , (TBS.VR_PRESTACAO_MES + TBS.VR_FCVS + TBS.VR_SEGURO_MES + TBS.VR_TAXA_TOM_MES) enc
   , TBS.QT_PRESTACAO_ATRASO qtd_prest_atr
   , TBS.QT_DIA_ATRASO qtd_dias_atr
   , TBS.VR_ENCARGO_TOTAL_ATRASO enc_atr
   , TBS.VR_MORA_TOTAL mora_tot
   , TBS.VR_DIFERENCA_PRESTACAO dif_prest
   , (VR_ENCARGO_TOTAL_ATRASO + TBS.VR_MORA_TOTAL + TBS.VR_DIFERENCA_PRESTACAO) div_vencida --ok, porém diferente do sifob que não está considerANDo a multa
   , TBS.VR_SALDO_DEVEDOR_ATUAL sd
   , (TBS.VR_ENCARGO_TOTAL_ATRASO + TBS.VR_MORA_TOTAL + TBS.VR_DIFERENCA_PRESTACAO +TBS.VR_SALDO_DEVEDOR_ATUAL) div_tot --ok, porém diferente do sifob que não está considerANDo a multa
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_010 sit_esp1
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_020 sit_esp2
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_030 sit_esp3
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_040 sit_esp4
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_050 sit_esp5
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_060 sit_esp6
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_070 sit_esp7
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_080 sit_esp8
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_090 sit_esp9
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_090 sit_esp10
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_110 sit_esp11
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_120 sit_esp12
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_130 sit_esp13
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_140 sit_esp14
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_150 sit_esp15
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_160 sit_esp16
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_170 sit_esp17
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_180 sit_esp18
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_190 sit_esp19
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_200 sit_esp20
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_210 sit_esp21
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_220 sit_esp22
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_230 sit_esp23
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_240 sit_esp24
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_250 sit_esp25
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_260 sit_esp26
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_270 sit_esp27
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_280 sit_esp28
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_290 sit_esp29
   , TBS.NU_SITUACAO_ESPECIAL_GRUPO_300 sit_esp30
   , TBS.NU_SUBTITULO_CONTABIL stc
   , TBS.DE_OPCAO_GRH op_grh
   , TBS.NU_GRH grh
   , TBS.NU_REGENCIA_CRITICA rcr
   , TBS.NU_ORIGEM_RECURSO orr
   , TBS.NU_LINHA_FINANCIAMENTO lf
   , TBS.NU_TIPO_FINANCIAMENTO tf
   , TBS.NU_REGENCIA_EVOLUCAO rge
   , TBS.IC_COBERTURA_FCVS cob_fcvs
   , TBS.NO_MUTUARIO nome
   , TBS.NU_CPF_CNPJ_MUTUARIO cpf_cgc
   , TBS.ED_LOGRADOURO_IMOVEL abr_logr_imo
   , TBS.ED_TIPO_LOGRADOURO_IMOVEL logr_imo
   , TBS.ED_NUMERO_IMOVEL nu_imo
   , TBS.ED_COMPLEMENTO_IMOVEL compl_imo
   , TBS.ED_BAIRRO_IMOVEL bair_imo
   , TBS.ED_CIDADE_IMOVEL cidade_imo
   , TBS.ED_UF_IMOVEL uf_imo
   , TBS.ED_CEP_IMOVEL cep_imo
   , TBS.ED_TIPO_LOGRADOURO_CORRESPONDENCIA abr_logr_cor
   , TBS.ED_TIPO_LOGRADOURO_CORRESPONDENCIA logr_cor
   , TBS.ED_NUMERO_IMOVEL_CORRESPONDENCIA nu_cor
   , TBS.ED_COMPLEMENTO_CORRESPONDENCIA compl_cor
   , TBS.ED_BAIRRO_CORRESPONDENCIA bair_cor
   , TBS.ED_CIDADE_CORRESPONDENCIA cidade_cor
   , TBS.ED_UF_CORRESPONDENCIA uf_cor
   , TBS.ED_CEP_CORRESPONDENCIA cep_cor
   , TBS.DT_NASCIMENTO dt_nasc
   , CONVERT(char,TBS.NU_DDD) + convert(char,TBS.NU_TELEFONE) tel
   , TBS.VR_RAZAO_ACRESCIMO_DECRESCIMO razao_acr_dec
   , TBS.NU_TIPO_PESSOA tipo_pessoa
   , TBS.DT_VENCIMENTO dt_ult_prest
   , TBS.NU_PRODUTO nu_produto
   , TBS.DT_ASSINATURA_CONTRATO dt_contratacao
   , TBS.NU_MASSA ind_massa
   , TBS.NU_TIPO_CREDITO tp_cred
   , TBS.NU_TIPO_APOLICE_SEGURO apolice_seg
   , TBS.MM_RECALCULO mes_recalc
   , TBS.DT_ULTIMO_RECALCULO dt_recalc
   , TBS.VR_JUROS_MORATORIO jur_mora
   , TBS.VR_JUROS_REMUNERATORIO jur_remun
   , TBS.VR_ATUALIZACAO_MONETARIA atu_monet
   , TBS.VR_GARANTIA_ATUAL vr_garantia_atual
   , TBS.NU_CREDOR nu_credor_contrato
   , TBS.NU_TIPO_GARANTIA tp_garantia
   , TBS.NO_EMPREENDIMENTO Empreendimento
   , TBS.NU_CARTEIRA_ORIGEM_REGISTRO idSistemaOrigem
                      
FROM 
        
   [DB5693_SIACI].[SILIQ].[ACITB001_SILIQ] TBS

	INNER JOIN [DB5693_SIACI].[Siliq].[ACIVW002_SILIQ_AJUSTADO] AS TBGENAC
		 ON 
			TBS.NU_CONTRATO = TBGENAC.NU_CONTRATO
		 AND
			TBGENAC.DT_MOVIMENTO = TBS.DT_MOVIMENTO

WHERE
NU_CARTEIRA_ORIGEM_REGISTRO = 98

END

GO

