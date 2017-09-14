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

/****** Object:  StoredProcedure [Arquivo].[SAISP004_CSV_281]    Script Date: 14/09/2017 13:02:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 =====================================================================================
 Migrado por:			<Renato Ferreira>
 data criacao:			<17/08/2017>
 Pacote VeraCruz :		PkgDEF326_Producao_REINCBH_DEF326
 Arquivo(veracruz):		REINCBH_DEF326_AAAAMMDD
 Peridiocidade:			Mensal
 Dependencias :			[DB5693_SIACI].[DEF326].[ACITB001_DEMONSTRATIVO_FINANCEIRO]
 						DB5693_SIACI].[parametro].[ACITBR02_REGENCIA_EVOLUCAO] X
 
			 
=====================================================================================
*/


ALTER PROCEDURE [Arquivo].[SAISP004_CSV_281]
AS
BEGIN
/********************************* SCRIPT MIGRADO PARA DF7436SR319 *************************************************
*/



--pkgdef326_producao_reincbh_def326

SELECT 
	 NU_IDENTIFICACAO_REGISTRO 					as codigo  --- ERRADO NO DE PARA 
	--,idagrupamento 			as agp
	,NU_AGRUPAMENTO_SUBTITULO 					as subtitulo
	--,idAGRUPAMENTOsubtitulosegregado 	as stc_segreg 
	,CO_SEGMENTO_CARTEIRA_MUTUARIO 				as classe 
	,NU_UNIDADE_OPERACIONAL 					as uno  
	,A.NU_ADMINISTRADOR 						as administr 
	,A.NU_CREDOR  								as credor 
	,NU_CONTRATO   								as contrato  
	,NO_MUTUARIO   								as nome  
	,'MENSAIS'   		    					as   per_parc  
	,QT_PRESTACAO_ATRASO   						as num_prest 
	,PZ_FINANCIAMENTO 							as prazo 
	,PZ_REMANESCENTE  							as prazo_rem 
	,QT_DIA_ATRASO  							as atrasos 
	,QT_DIA_ATRASO_REAL  						as atr_real 
	,DD_VENCIMENTO_PRESTACAO  					as dia_ref 
	,DD_CORRECAO_SALDO_DEVEDOR  				as dia_cor 
	,A.NU_ORIGEM_RECURSO  						as orr  
	,NU_MASSA  									as ind_massa 
	,NU_RENEGOCIACAO  							as ind_reneg 
	---,NU_			as tipo_pess  NAO EXISTE NA DEF
	,A.NU_LINHA_FINANCIAMENTO  					as linha_fin  
	,NU_ORDEM_MUTUARIO   						as mut_ordem 
	,IC_SITUACAO_ESPECIAL_EM_DIA   				as sit_emdia  
	,NULL AS curso_ctr  			  
	,NU_SITUACAO_ESPECIAL_010  			
	,NU_SITUACAO_ESPECIAL_020  			 
	,NU_SITUACAO_ESPECIAL_030  			  
	,NU_SITUACAO_ESPECIAL_040  			  
	,NU_SITUACAO_ESPECIAL_050  			  
	,NU_SITUACAO_ESPECIAL_060  			 
	,NU_SITUACAO_ESPECIAL_070  			  
	,NU_SITUACAO_ESPECIAL_080  			 
	,NU_SITUACAO_ESPECIAL_090  			  
	,NU_SITUACAO_ESPECIAL_100  			  
	,NU_SITUACAO_ESPECIAL_110  			 
	,NU_SITUACAO_ESPECIAL_120  			  
	,NU_SITUACAO_ESPECIAL_130  			  
	,NU_SITUACAO_ESPECIAL_140  			  
	,NU_SITUACAO_ESPECIAL_150  			  
	,NU_SITUACAO_ESPECIAL_160   
	,NU_SITUACAO_ESPECIAL_170    			
	,NU_SITUACAO_ESPECIAL_180    
	,NU_SITUACAO_ESPECIAL_190    
	,NU_SITUACAO_ESPECIAL_200    
	,NU_SITUACAO_ESPECIAL_210    
	,NU_SITUACAO_ESPECIAL_220    
	,NU_SITUACAO_ESPECIAL_230    
	,NU_SITUACAO_ESPECIAL_240    
	,NU_SITUACAO_ESPECIAL_250    
	,NU_SITUACAO_ESPECIAL_260    
	,NU_SITUACAO_ESPECIAL_270    
	,NU_SITUACAO_ESPECIAL_280    
	,NU_SITUACAO_ESPECIAL_290    
	,NU_SITUACAO_ESPECIAL_300    
	,NU_SITUACAO_ESPECIAL_310	 			   
	,NU_SITUACAO_ESPECIAL_320    
	,NU_SITUACAO_ESPECIAL_330    
	,NU_SITUACAO_ESPECIAL_340    
	,NU_SITUACAO_ESPECIAL_350    
	,NU_SITUACAO_ESPECIAL_360    
	,NU_SITUACAO_ESPECIAL_370    
	,NU_SITUACAO_ESPECIAL_380    
	,NU_SITUACAO_ESPECIAL_390    
	,IN_SALDO_DEVEDOR_UPC  						as  sd_dev_upc 
	,NU_PLANO_FINANCIAMENTO  					as  plano 
	,C.NO_INDICE_REAJUSTE_SALDO_DEVEDOR   		as  ind_corr  --(ESTA NA TABELA DE RCR)
	,VR_FINANCIAMENTO  							as  valor_fin 
	,NU_MODO_IMPLANTACAO  						as  modo_impl 
	,VR_FINANCIAMENTO 							as  valfin_upc  -- VERIFICAR
	,DT_ASSINATURA  							as  dta_escrit 
	,NU_ANO_MES_FIM_CONTRATO   					as  dt_fim_ctr 
	,DT_ULTIMA_EVOLUCAO_PARALIZACAO 			as  dta_venc 
	,DT_PARALIZACAO  							as  dta_paral 
	,DT_ORIGEM   								as  dta_ate 
	,NU_TRANCAMENTO  							as  cod_tranca 
	,DT_TRANCAMENTO   							as  dta_tranca 
	,NU_RENEGOCIACAO_INCORPORACAO_PRESTACAO 	as  chrenincor 
	,DT_ULTIMA_RENEGOCIACAO_INCORPORACAO_PRESTACAO    as  dtrenincor 
	,DT_ULTIMA_EVOLUCAO   						as  dta_evol 
	,NU_ANO_MES_PROXIMO_REAJUSTE_CONTRATO   	as  dt_proreaj 
	,DT_POSICAO_SALDO_DEVEDOR_INICIAL   		as  dt_p0_dat 
	,DT_CONTRATACAO  							as  dta_contr 
	,DT_VENCIMENTO_PRIMEIRA_PRESTACAO   		as  dt_p0_venc 
	,DT_ATRASO_SEM_PRESTACAO_PULADA   			as  dt_pri_abr 
	,DT_APROPRIACAO_PRESTACAO  					as  dta_apro 
	,VR_AMORTIZACAO_PRESTACAO   				as  amortiz 
	,VR_JUROS_PRESTACAO  						as  juros 
	,VR_SEGURO_PRESTACAO  						as  seguros 
	,VR_TAXA_PRESTACAO 							as  taxas 
	,VR_FCVS_PRESTACAO   						as  fcvs 
	,VR_DIFERENCA_PRESTACAO   					as  dif_prest 
	,VR_FGTS_PRESTACAO   						as  fgts 
	,VR_ENCARGO_TOTAL_PRESTACAO  				as  encargo 
	, VR_TAXA_RISCO_CREDITO_PRESTACAO			as  taxas_trc
	,VR_JUROS_MORATORIO_PRESTACAO				as  jr_morator 
	,VR_JUROS_REMUNERATORIO_PRESTACAO   		as  jr_remun 
	,VR_CORRECAO_MONETARIA_MORA_PRESTACAO   	as  mora_cm 
	,VR_MORA_PRESTACAO   						as  mora 
	,VR_SALDO_DEVEDOR   						as  saldo_dev 
	,VR_SALDO_PRO_RATA   						as  saldo_pro 
	,VR_SALDO_DEVEDOR_REMANESCENTE  			as  saldo_ren 
	,VR_DIFERENCA_PRESTACAO_PRO_RATA  			as  dif_prepro 
	,VR_DIFERENCA_PRESTACAO_ATUALIZACAO_MONETARIA_PRO_RATA   	as  difatmprat 
	,VR_JUROS_PRO_RATA  						as  juros_pro 
	,VR_RAP_CORRECAO_MONETARIA_ACUMULADA   		as  rap_cmacum 
	,VR_RAP_CORRECAO_MONETARIA_ACUMULADA_CREDITO_RESIDUAL_1748   		as  rap_cm1748 
	,VR_RAP_ATUALIZACAO_DIFERENCA_PAGAMENTO    	as  rap_difpre 
	,VR_RAP_JUROS_ENCARGO_ACUMULADO   			as  rap_juros 
	,VR_RAP_TAXA   								as  rap_taxas 
	,VR_RAP_JUROS_SALDO_DEVEDOR_CONTRATUAL		as rap_taxas_trc
	,VR_RAP_AMORTIZACAO_NEGATIVA   				as  rap_amneg 
	,VR_A_APROVISIONAR   						as  prov_atr 
	,VR_DIVIDA_VENCIDA   						as  vencidas 
	,VR_DIVIDA_VINCENDA_CURTO_PRAZO  			as  vinccurtpz 
	,VR_DIVIDA_VINCENDA_LONGO_PRAZO  			as  vinclongpz 
	,VR_DIVIDA_VINCENDA   						as  vincENDas 
	,VR_RAP_DIVIDA_VENCIDA   					as  rap_vencid 
	,VR_RAP_DIVIDA_VINCENDA   					as  rap_vincen 
	,VR_PROVISAO_LIQUIDACAO_DUVIDOSA   			as  prvlduvitc 
	,VR_JUROS_SALDO_DEVEDOR_TAXA_CONTRATUAL   	as  jrcont1296 
	,VR_JUROS_SALDO_DEVEDOR_TAXA_MP1520  		as  jr15201296 
	,VR_DIFERENCIAL_JUROS   					as  dif_jr1520 
	,VR_JUROS_SALDO_DEVEDOR_TAXA_CONTRATUAL   	as  jrcontapro 
	,VR_RAP_JUROS_SALDO_DEVEDOR_MP1520   		as  jr1520apro 
	,VR_RAP_DIFERENCIAL_JUROS   				as  rapdifjrap 
	,VR_DESCONTO_DL97222   						as  sd_dl97222 
	,VR_RAP_DESCONTO_DL97222   					as  rap_sd9722 
	,VR_ENCARGO_SEM_RAP_000_A_014   			as  vcpf000014 
	,VR_ENCARGO_SEM_RAP_015_A_030   			as  vcpf015030 
	,VR_ENCARGO_SEM_RAP_031_A_060   			as  vcpf031060 
	,VR_ENCARGO_SEM_RAP_061_A_090   			as  vcpf061090 
	,VR_ENCARGO_SEM_RAP_091_A_120   			as  vcpf091120 
	,VR_ENCARGO_SEM_RAP_121_A_150   			as  vcpf121150 
	,VR_ENCARGO_SEM_RAP_151_A_180   			as  vcpf151180 
	,VR_ENCARGO_SEM_RAP_181_A_240   			as  vcpf181240 
	,VR_ENCARGO_SEM_RAP_241_A_300   			as  vcpf241300 
	,VR_ENCARGO_SEM_RAP_301_A_360   			as  vcpf301360 
	,VR_ENCARGO_SEM_RAP_361_A_540   			as  vcpf361540 
	,VR_ENCARGO_SEM_RAP_ACIMA_540   			as  vcpfmai540 
	,PC_TAXA_JUROS_ANUAL  						as  jurosa 
	,NU_FILIAL  								as  sureg 
	,NU_NEGOCIO   								as  cod_negoc  
	,NU_GRUPO_HABITACIONAL  					as  grupo_hab 
	,NU_LEGISLACAO_REGENTE  					as  cod_legisl 
	,IC_COBERTURA_FCVS   						as  cob_fcvs  
	,A.NU_REGENCIA_EVOLUCAO  					as  rge_codigo  
	,A.NU_REGENCIA_CRITICA  					as  rcr_codigo  
	,VR_ULTIMO_ENCARGO   						as  ult_encarg 
	,VR_ULTIMA_PRESTACAO   						as  ult_prest 
	,QT_PRESTACAO_PULADA  						as  qtdprespul 
	,VR_PRESTACAO_PULADA   						as  vl_prespul 
	,MM_BASE_CATEGORIA_PROFISSIONAL  			as  mes_base 
	,NU_CATEGORIA_PROFISSIONAL   				as  categoria 
	,CO_CATEGORIA_PROFISSIONAL_COMPLEMENTO 		as  cat_compl  
	,NU_PRODUTO  								as  produto 
	,VR_SALDO_DIFERENCIAL_TAXA_ADMINISTRACAO    as  sald_ta 
	,VR_SALDO_DIFERENCIAL_JUROS   				as  sald_djur
	, VR_PROVISAO_TA_JUROS_A_DEVOLVER			as  prov_ta_dj
	, NU_LEGISLACAO_REGENTE						as cod_legis
	, NU_TIPO_GARANTIA							as tip_gar
	, VR_GARANTIA								as val_garantia
	--,DT_MOVIMENTO     
	--,NU_CARTEIRA_ORIGEM_REGISTRO    

FROM
[DB5693_SIACI].[DEF326].[ACITB001_DEMONSTRATIVO_FINANCEIRO] A

INNER JOIN 
	(SELECT X.NU_REGENCIA_EVOLUCAO,Y.NO_INDICE_REAJUSTE_SALDO_DEVEDOR FROM [DB5693_SIACI].[parametro].[ACITBR02_REGENCIA_EVOLUCAO] X
	 INNER JOIN   [DB5693_SIACI].[Parametro].[ACITBI03_INDICE_REAJUSTE_SALDO_DEVEDOR] Y
	    ON X.NU_INDICE_REAJUSTE_SALDO_DEVEDOR=Y.NU_INDICE_REAJUSTE_SALDO_DEVEDOR
		AND X.NU_REGENCIA_EVOLUCAO=X.NU_REGENCIA_EVOLUCAO
		AND X.NU_CREDOR=1102
	  )  AS C
ON A.NU_REGENCIA_EVOLUCAO=C.NU_REGENCIA_EVOLUCAO

WHERE A.NU_CARTEIRA_ORIGEM_REGISTRO NOT IN (58, 12, 3) 
AND   A.NU_CREDOR=1102


END 
GO

