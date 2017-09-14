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

/****** Object:  StoredProcedure [Arquivo].[SAISP001_CSV_278]    Script Date: 14/09/2017 13:01:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [Arquivo].[SAISP001_CSV_278]  AS BEGIN


/*
 =====================================================================================
 Migrado por :			<Renato Ferreira>
 Matricula :        <c113327>
 data criacao:			<17/08/2017>
 Descricao :			pkgMOVIMENTOS_SUCOR_RCR
 Arquivo (veraCruz):	SUCOR_RCR_AAAAMMDD
 peridiocidade:			Semanal
 Dependencias :

						[DB5693_SIACI].[PARAMETRO].[ACITBR01_REGENCIA_CRITICA] 
						[DB5693_SIACI].[PARAMETRO].[ACITBT11_TIPO_FINANCIAMENTO] B 
						[DB5693_SIACI].[PARAMETRO].[ACITBT13_TIPO_IMOVEL]  C 
						[DB5693_SIACI].[PARAMETRO].[ACITBT17_TIPO_PESSOA] D 
						[DB5693_SIACI].[PARAMETRO].[ACITBT01_TAXA_MANUTENCAO_COBRANCA]  E
						[DB5693_SIACI].[PARAMETRO].[ACITBS03_SISTEMA_FINANCEIRO] F
						[DB5693_SIACI].[PARAMETRO].[ACITBO02_ORIGEM_RECURSO] G 
						[DB5693_SIACI].[PARAMETRO].[ACITBC04_CATEGORIA_PESSOA]  H 
						[DB5693_SIACI].[PARAMETRO].[ACITBL02_LINHA_FINANCIAMENTO] I 
						[DB5693_SIACI].[PARAMETRO].[ACITBC02_CATEGORIA_IMOVEL] J

=================================================================================================================
*/

SELECT   A.NU_REGENCIA_CRITICA,
           A.NU_CATEGORIA_IMOVEL,
           J.NO_CATEGORIA_IMOVEL, 
           A.NU_CATEGORIA_PESSOA,
           H.NO_CATEGORIA_PESSOA, 
           A.NU_LINHA_FINANCIAMENTO,
           I.NO_LINHA_FINANCIAMENTO,
           A.NU_ORIGEM_RECURSO,
           G.NO_ORIGEM_RECURSO, 
           A.NU_SISTEMA_FINANCEIRO, 
           F.SG_SISTEMA_FINANCEIRO, 
           A.NU_TIPO_FINANCIAMENTO, 
           B.NO_TIPO_FINANCIAMENTO, 
           A.NU_TIPO_IMOVEL,
           C.NO_TIPO_IMOVEL,
           A.NU_TIPO_PESSOA,
           D.NO_TIPO_PESSOA,
           A.NU_TIPO_TAXA_MANUTENCAO_COBRANCA_1,
           A.NU_ARQUIVO_ORIGEM,
           A.DT_MOVIMENTO
FROM       [DB5693_SIACI].[PARAMETRO].[ACITBR01_REGENCIA_CRITICA]  A left outer join

           [DB5693_SIACI].[PARAMETRO].[ACITBT11_TIPO_FINANCIAMENTO] B on  A.NU_TIPO_FINANCIAMENTO = B.NU_TIPO_FINANCIAMENTO left outer join
           [DB5693_SIACI].[PARAMETRO].[ACITBT13_TIPO_IMOVEL]  C on  A.NU_TIPO_IMOVEL = C.NU_TIPO_IMOVEL left outer join
           [DB5693_SIACI].[PARAMETRO].[ACITBT17_TIPO_PESSOA] D on  A.NU_TIPO_PESSOA = D.NU_TIPO_PESSOA left outer join
           [DB5693_SIACI].[PARAMETRO].[ACITBT01_TAXA_MANUTENCAO_COBRANCA]  E on  A.NU_TIPO_TAXA_MANUTENCAO_COBRANCA_1 = E.NU_TAXA_MANUTENCAO left outer join
           [DB5693_SIACI].[PARAMETRO].[ACITBS03_SISTEMA_FINANCEIRO] F on  A.NU_SISTEMA_FINANCEIRO = F.NU_SISTEMA_FINANCEIRO left outer join
           [DB5693_SIACI].[PARAMETRO].[ACITBO02_ORIGEM_RECURSO] G on  A.NU_ORIGEM_RECURSO = G.NU_ORIGEM_RECURSO left outer join
           [DB5693_SIACI].[PARAMETRO].[ACITBC04_CATEGORIA_PESSOA]  H on  A.NU_CATEGORIA_PESSOA = H.NU_CATEGORIA_PESSOA left outer join
           [DB5693_SIACI].[PARAMETRO].[ACITBL02_LINHA_FINANCIAMENTO] I on A.NU_LINHA_FINANCIAMENTO = I.NU_LINHA_FINANCIAMENTO left outer join
           [DB5693_SIACI].[PARAMETRO].[ACITBC02_CATEGORIA_IMOVEL] J on A.NU_CATEGORIA_IMOVEL = J.NU_CATEGORIA_IMOVEL


END
GO

