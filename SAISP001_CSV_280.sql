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

/****** Object:  StoredProcedure [Arquivo].[SAISP003_CSV_280]    Script Date: 14/09/2017 13:02:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 =====================================================================================
 Migrado por:		<Renato Ferreira>
 data Migracao:		<17/08/2017>
 Descricao :		pkgSILIQ_Producao_GEIFI_Lastro_LCI

 Dependencias : 
				[DB5693_SIACI].[Siliq].[ACITB001_SILIQ] SILIQ
				[DB5693_SIACI].[Def326].[ACITB001_DEMONSTRATIVO_FINANCEIRO]
				[DB5693_SIACI].[PARAMETRO].[ACITBR01_REGENCIA_CRITICA]
				[DB5693_SIACI].[Siger].[ACITB002_INADIMPLENCIA]  
				[DB5693_SIACI].[MOVIMENTO].[ACITB001_PEDIDO_ATIVO] 
				[DB5693_SAIDA].[dbo].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI]  (*)
  
  Temporarias :  
   [DB5693_TMP].ACITBT002_CONTRATO_LASTRO_LCI_SAIDA  -  ARQUIVO DE SAIDA - CONTRATOS SELECIONADOS PARA LASTRO DE LCI PARA O MES CONSIDERADO (somatorio de saldo devedores ate o valor informado pela tabela [DB5693_SAIDA].[dbo].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI] (*))
   [DB5693_TMP].ACITBT001_CONTRATO_LASTRO_LCI		  - BASE DE CONTRATOS PASSIVEIS DE SEREM ENCAMINADOS PARA LASTRO DE LCI (todos os contratos)	 
=====================================================================================

(*) -- > Valores Para lastro informados mensalmente pela GEIFI

*/


ALTER PROCEDURE [Arquivo].[SAISP003_CSV_280]
AS
BEGIN

/*


PARAMETROS(FILTROS) PARA PRODUCAO: 

Lastro LCI Habitacional
Tipo Registro: 1
Origem de Recurso: 15 – SBPE;
Prazo remanescente: > 3 meses;
Em Atraso: < 150 dias;
Tipo_Garantia: 561, 426, 427,425(*)
Índice de Massa: 1 massa nova
Campos do leiaute: 
Tipo_registro;Nr_contrato;Saldo_devedor;Produto_SIICO;dscSistemaFinanceiro

Lastro LCI Comercial – produtos 4569 e 4568
Tipo Registro: 2
Origem de Recurso: 65 – CIP
Prazo remanescente: > 3 meses;
Em Atraso: < 150 dias;
Tipo_Garantia: 426, 427, 425(*)
Índice de Massa: 1 massa nova
Campos do leiaute:
Tipo_registro;Nr_contrato;Saldo_devedor;Produto_SIICO;TP_GARANTIA;


(*) 425=426 São iguais, há contratos marcados com 425 no def e 426 no siliq 

 */

/*
 1. Criar tabela (se nao existir) de parametros SFH/SFI informado pela GEIFI para producao do arquivo de lastro comercial/habitacional
 obs: se NULL a base inteira sera enviada
*/

/* 
-- TABELA DE PARAMETROS PARA A PRODUCAO
IF NOT EXISTS (SELECT * FROM DB5693_SAIDA.INFORMATION_SCHEMA.TABLES  WHERE TABLE_NAME = N'ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI')
BEGIN

CREATE TABLE	[DB5693_SAIDA].[parametro].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI] (
				[NU_TIPO_REGISTRO] [tinyint] NOT NULL ,
				[VR_LASTRO_LCI_SFH] decimal(18,2) NULL ,
				[VR_LASTRO_LCI_SFI] decimal(18,2) NULL ,
				[AAMM_LASTRO_LCI] [int] NOT NULL 
) 

END

*/
SET NOCOUNT ON

--- Parametros (filtros) de producao informados pela GEIFI/GELIT
DECLARE @pz_remanescente as smallint
DECLARE @qt_dia_atraso as smallint
DECLARE @nu_massa as tinyint
DECLARE @nu_carteira_origem_registro TABLE (nu_carteira_origem_registro  tinyint NOT NULL)
DECLARE @nu_origem_recurso table (nu_origem_recurso tinyint NOT NULL)
DECLARE @nu_tipo_garantia  table (nu_tipo_garantia smallint NOT NULL)

SET @pz_remanescente=3
SET @qt_dia_atraso=150
SET @nu_massa=1

INSERT INTO  @nu_carteira_origem_registro  VALUES (57)
INSERT INTO  @nu_origem_recurso VALUES (15),(65)
INSERT INTO  @nu_tipo_garantia VALUES (425),(426),(427),(561)

DECLARE 
 @nomearquivo varchar(50)
,@errorlevel  as smallint
,@cmd as varchar(500)
,@no_local_origem as varchar(1000)
,@tipo_registro as int
,@nr_contrato as bigint
,@saldo_devedor as decimal (16,2)
,@produto_siico as int
,@tp_garantia as int
,@somatorio as decimal (16,2)
,@Valor as decimal (16,2)
,@anomes as int
,@dscsistemafinanceiro as char(3) 


BEGIN TRY  

/*  Criar tabela (temporaria) geradora  da saida (arquivo de lastro)   

*/
	IF EXISTS (SELECT * FROM DB5693_TMP.INFORMATION_SCHEMA.TABLES  WHERE TABLE_NAME = N'ACITBT002_CONTRATO_LASTRO_LCI_SAIDA')
	BEGIN
		DROP TABLE [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA]
	END

	CREATE TABLE [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA] (
		[nr_contrato] [bigint] NOT NULL ,
		[tipo_registro] [tinyint] NULL ,
		[orr] [tinyint] NULL ,
		[saldo_devedor] [decimal](17,2) NULL ,
		[sit_ctr] [tinyint] NULL ,
		[qtd_dias_atr] [smallint] NULL ,
		[tp_garantia] [smallint] NULL ,
		[pz_amor] [smallint] NULL ,
		[pz_rem] [smallint] NULL ,
		[nu_credor_contrato] [smallint] NULL ,
		[produto_siico] [smallint] NULL ,
		[dscsistemafinanceiro] [varchar] (3) collate sql_latin1_general_cp1_ci_as NULL ,
		[ind_massa] [tinyint] NULL ,
		[dt_movimento] [smalldatetime] NULL 
	) ON [primary]



IF EXISTS (SELECT * FROM DB5693_TMP.INFORMATION_SCHEMA.TABLES  WHERE TABLE_NAME = N'ACITBT001_CONTRATO_LASTRO_LCI')
BEGIN
	DROP TABLE [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI]
END


SELECT  
              NR_contrato=DEF.NU_CONTRATO,
              Tipo_Registro = CASE WHEN  DEF.NU_ORIGEM_RECURSO=15 AND DEF.NU_TIPO_GARANTIA IN (561,425,426, 427)                                	 THEN 1
                         	 	   WHEN  DEF.NU_ORIGEM_RECURSO=65 AND DEF.NU_TIPO_GARANTIA IN (425,426,427) AND  DEF.NU_PRODUTO IN (4568,4569)       THEN 2 
                              ELSE NULL
              END,
              Orr=DEF.NU_ORIGEM_RECURSO ,
              Saldo_Devedor = DEF.VR_SALDO_DEVEDOR,
	     	  Sit_contrato = CASE 	WHEN LIQUIDADO.NU_CONTRATO is NULL THEN DEF.NU_TRANCAMENTO 
	     	  		  		 ELSE 2 
	     	         	 END, 							 			 --  Corrige codigo de trancamento pela tabela de movimentos (diario) (0=ativo, 2=liquidado)
   	      	  Qtd_Dias_Atr = ISNULL(INADIMPLENCIA.QT_DIA_ATRASO,0),	 --  Corrige dias em atraso tbsiliq (mensal) pela tbinadimplencia (semanal)		
              Tp_Garantia = DEF.NU_TIPO_GARANTIA ,
              Pz_Amor = DEF.PZ_FINANCIAMENTO,
              Pz_Rem = DEF.PZ_REMANESCENTE,
              Nu_Credor_Contrato = DEF.NU_CREDOR,
              Produto_SIICO =DEF.NU_PRODUTO,
              DscSistemaFinanceiro = CASE  --(1=sfh , 2 = sfi)
              							WHEN RCR.NU_SISTEMA_FINANCEIRO=1 THEN 'SFH' 
              							WHEN RCR.NU_SISTEMA_FINANCEIRO=2 THEN 'SFI' 
              							ELSE NULL 
              				     	  END, 
              Ind_massa =    DEF.NU_MASSA,
              Dt_Movimento = DEF.DT_MOVIMENTO  

INTO 	[DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI]

FROM 	[DB5693_SIACI].[Def326].[ACITB001_DEMONSTRATIVO_FINANCEIRO] DEF
		
INNER JOIN 	[DB5693_SIACI].[PARAMETRO].[ACITBR01_REGENCIA_CRITICA] RCR
		ON  RCR.NU_REGENCIA_CRITICA = DEF.NU_REGENCIA_CRITICA
		AND DEF.NU_CREDOR = RCR.NU_CREDOR
		
LEFT JOIN [DB5693_SIACI].[Siger].[ACITB002_INADIMPLENCIA]  INADIMPLENCIA
		ON DEF.NU_CONTRATO = INADIMPLENCIA.NU_CONTRATO 
		AND INADIMPLENCIA.NU_TRANCAMENTO = 99 
		AND INADIMPLENCIA.QT_DIA_ATRASO < @qt_dia_atraso OR  INADIMPLENCIA.QT_DIA_ATRASO IS NULL

LEFT JOIN 	[DB5693_SIACI].[MOVIMENTO].[ACITB001_PEDIDO_ATIVO] LIQUIDADO  -- CONTRATOS LIQUIDADOS
	 	ON   DEF.NU_CONTRATO = LIQUIDADO.NU_CONTRATO
	 	AND  LIQUIDADO.NU_CATEGORIA_PEDIDO = 2 
	 	AND  LIQUIDADO.NU_ESTADO_PEDIDO=1 
	 	AND  LIQUIDADO.NU_CARTEIRA_ORIGEM_REGISTRO=57
  
WHERE   (DEF.NU_CREDOR <1200 OR  DEF.NU_CREDOR=1440)
		AND DEF.NU_TRANCAMENTO=99
       	AND DEF.NU_ORIGEM_RECURSO IN (SELECT nu_origem_recurso FROM @nu_origem_recurso )
      	AND DEF.NU_MASSA = @nu_massa
       	AND DEF.NU_TIPO_GARANTIA IN ( SELECT nu_tipo_garantia FROM @nu_tipo_garantia ) 
		AND DEF.NU_CARTEIRA_ORIGEM_REGISTRO IN (SELECT nu_carteira_origem_registro FROM @nu_carteira_origem_registro)
		AND DEF.PZ_REMANESCENTE > @pz_remanescente
		AND ((DEF.NU_ORIGEM_RECURSO= 15 AND DEF.NU_TIPO_GARANTIA IN (SELECT nu_tipo_garantia FROM @nu_tipo_garantia)) OR (DEF.NU_ORIGEM_RECURSO= 65 AND DEF.NU_TIPO_GARANTIA IN (425,426,427) AND  DEF.NU_PRODUTO IN (4568,4569)))
		AND LIQUIDADO.NU_CONTRATO IS NULL
		AND DEF.NU_SISTEMA_ORIGEM_REGISTRO<>91 -- incluido para eliminacao de contratos securitizados da base
 /*
 	LCI COMERCIAL 
	tipo_registro =2 
 */
	
SET @somatorio=0.00
SET @Valor=(SELECT VR_LASTRO_LCI_SFI FROM [DB5693_SAIDA].[parametro].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI] WHERE NU_TIPO_REGISTRO=2 AND AAMM_LASTRO_LCI=(SELECT max(AAMM_LASTRO_LCI) FROM [DB5693_SAIDA].[dbo].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI] ))
IF  @Valor is NOT NULL 
BEGIN
	DECLARE cur_ctr CURSOR for SELECT tipo_registro,nr_contrato,saldo_devedor,produto_siico,tp_garantia FROM [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI] WHERE tipo_registro=2 ORDER BY newid()
	OPEN cur_ctr 
	FETCH next FROM cur_ctr INTO @tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@tp_garantia
	WHILE @@FETCH_status = 0
		BEGIN
			IF @somatorio<=@Valor 
				BEGIN
					SET @somatorio=@somatorio+@saldo_devedor
					INSERT  INTO [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA] (tipo_registro,nr_contrato,saldo_devedor,produto_siico,tp_garantia)
						VALUES (@tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@tp_garantia)
		END

	FETCH next FROM cur_ctr INTO @tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@tp_garantia
	END
	CLOSE cur_ctr
	DEALLOCATE cur_ctr
END
ELSE
BEGIN

	INSERT  INTO [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA] (tipo_registro,nr_contrato,saldo_devedor,produto_siico,tp_garantia)
	SELECT tipo_registro,nr_contrato,saldo_devedor,produto_siico,tp_garantia FROM [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI]

END
 /*
 	LCI HABITACIONAL
	tipo_registro =1 
	Sistema_financeiro='SFH' 
 */
	
SET @somatorio=0.00
SET @Valor=(SELECT VR_LASTRO_LCI_SFH FROM [DB5693_SAIDA].[parametro].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI] WHERE NU_TIPO_REGISTRO=1 AND AAMM_LASTRO_LCI=(SELECT max(AAMM_LASTRO_LCI) FROM [DB5693_SAIDA].[dbo].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI] ))


IF  @Valor is NOT NULL 
BEGIN
	DECLARE cur_ctr CURSOR for SELECT tipo_registro,nr_contrato,saldo_devedor,produto_siico,dscsistemafinanceiro 
					   FROM [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI] WHERE tipo_registro=1 AND dscsistemafinanceiro='SFH' ORDER BY newid()
	OPEN cur_ctr 
	FETCH next FROM cur_ctr INTO @tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@dscsistemafinanceiro
	WHILE @@FETCH_status = 0
	BEGIN		
			IF @somatorio>=@Valor break		
			IF @somatorio<=@Valor 
				BEGIN
					SET @somatorio=@somatorio+@saldo_devedor
					INSERT  INTO [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA] (tipo_registro,nr_contrato,saldo_devedor,produto_siico,dscsistemafinanceiro)
						VALUES (@tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@dscsistemafinanceiro)
				END
	
	FETCH next FROM cur_ctr INTO @tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@dscsistemafinanceiro
	END
	CLOSE cur_ctr
	DEALLOCATE cur_ctr
END
ELSE
BEGIN

	INSERT  INTO [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA] (tipo_registro,nr_contrato,saldo_devedor,produto_siico,dscsistemafinanceiro)
	SELECT tipo_registro,nr_contrato,saldo_devedor,produto_siico,dscsistemafinanceiro FROM [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI] WHERE tipo_registro=1 AND dscsistemafinanceiro='SFH'

END


 /*
 	LCI HABITACIONAL
	tipo_registro =1 
	Sistema_financeiro='SFI' 
 */
	

SET @somatorio=0.00
SET @Valor=(SELECT VR_LASTRO_LCI_SFI FROM [DB5693_SAIDA].[parametro].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI] WHERE NU_TIPO_REGISTRO=1 AND AAMM_LASTRO_LCI=(SELECT max(AAMM_LASTRO_LCI) FROM [DB5693_SAIDA].[dbo].[ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI][ACITB001_SAIDA_280_LASTRO_COMERCIAL_HABITACIONAL_LCI] ))


IF  @Valor is NOT NULL 
BEGIN
	DECLARE cur_ctr CURSOR for SELECT tipo_registro,nr_contrato,saldo_devedor,produto_siico,dscsistemafinanceiro 
					   FROM [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI] WHERE tipo_registro=1 AND dscsistemafinanceiro='SFI' ORDER BY newid()
	OPEN cur_ctr 
	FETCH next FROM cur_ctr INTO @tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@dscsistemafinanceiro
	WHILE @@FETCH_status = 0
	BEGIN		
			IF @somatorio>=@Valor break		
			IF @somatorio<=@Valor 
				BEGIN
					SET @somatorio=@somatorio+@saldo_devedor
					INSERT  INTO [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA] (tipo_registro,nr_contrato,saldo_devedor,produto_siico,dscsistemafinanceiro)
								VALUES (@tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@dscsistemafinanceiro)
				END
			

	FETCH next FROM cur_ctr INTO @tipo_registro,@nr_contrato,@saldo_devedor,@produto_siico,@dscsistemafinanceiro
	END
	CLOSE cur_ctr
	DEALLOCATE cur_ctr
END
ELSE
BEGIN

	INSERT  INTO  [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA] (tipo_registro,nr_contrato,saldo_devedor,produto_siico,dscsistemafinanceiro)
	SELECT tipo_registro,nr_contrato,saldo_devedor,produto_siico,dscsistemafinanceiro FROM [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI] WHERE tipo_registro=1 AND dscsistemafinanceiro='SFI'

END


	IF EXISTS (SELECT * FROM  DB5693_TMP.INFORMATION_SCHEMA.TABLES  WHERE TABLE_NAME = N'ACITBT001_CONTRATO_LASTRO_LCI')
		BEGIN
			DROP TABLE [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI]
		END
END TRY


BEGIN CATCH 
--SELECT  
 --    ERROR_NUMBER() AS NU_ERRO_SQL_SERVER
   -- ,ERROR_SEVERITY() AS NU_ERRO_GRAVIDADE_SQL_SERVER
    --,ERROR_STATE() AS NU_ESTADO_ERRO_SQL_SERVER
    --,ERROR_PROCEDURE() AS NU_ERRO_PROCEDURE  
    ---,ERROR_LINE() AS NU_ERRO_LINHA
    --,ERROR_MESSAGE() AS ED_ERRO_MENSAGEM_SQL_SERVER


	IF EXISTS (SELECT * FROM DB5693_TMP.INFORMATION_SCHEMA.TABLES  WHERE TABLE_NAME = N'ACITBT001_CONTRATO_LASTRO_LCI')
		BEGIN
			DROP TABLE [DB5693_TMP].[dbo].[ACITBT001_CONTRATO_LASTRO_LCI]
		END

	IF EXISTS (SELECT * FROM  DB5693_TMP.INFORMATION_SCHEMA.TABLES  WHERE TABLE_NAME = N'ACITBT002_CONTRATO_LASTRO_LCI_SAIDA')
		BEGIN
			DROP TABLE [DB5693_TMP].[dbo].[ACITBT002_CONTRATO_LASTRO_LCI_SAIDA]
		END
END CATCH 



END
GO

