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

/****** Object:  StoredProcedure [Arquivo].[SAISP006_CSV_283]    Script Date: 14/09/2017 13:03:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
 =====================================================================================
 Migrado por:			<Renato Ferreira>
 data criacao:			<17/08/2017>
 Descricao :			pkgMOVIMENTOS_Producao_REINC_TP150
 Arquivo (VeraCruz):	REINCBH_TP150_
 Peridiocidade:			Diario
 Dependencias : 

						[DB5693_SIACI].[MOVIMENTO].[ACITB001_PEDIDO_ATIVO] 
						[DB5693_SIACI].[PARAMETRO].[ACITBC01_CARTEIRA_ORIGEM_REGISTRO]

=======================================================================================

*/


ALTER PROCEDURE [Arquivo].[SAISP006_CSV_283]
AS
BEGIN

SELECT
      siglaSistemaOrigem =  CR.SG_CARTEIRA_ORIGEM_REGISTRO 
    , idTipoPedido =		TP.NU_TIPO_PEDIDO 
    , dtEvento =			CONVERT(VARCHAR,TP.DT_EVENTO,103) 
    , idContrato =			TP.NU_CONTRATO
    , Produto =				TP.NU_PRODUTO 
    , VlrEvento =			REPLACE(TP.VR_EVENTO,'.',',')

FROM 
   [DB5693_SIACI].[MOVIMENTO].[ACITB001_PEDIDO_ATIVO] as TP

LEFT OUTER JOIN [DB5693_SIACI].[PARAMETRO].[ACITBC01_CARTEIRA_ORIGEM_REGISTRO] as CR
  ON TP.NU_CARTEIRA_ORIGEM_REGISTRO = CR.NU_CARTEIRA_ORIGEM_REGISTRO

WHERE

        TP.NU_TIPO_PEDIDO = 150
   AND  TP.NU_ESTADO_PEDIDO = 1

ORDER BY SG_CARTEIRA_ORIGEM_REGISTRO,PRODUTO,DT_EVENTO
END 
GO

