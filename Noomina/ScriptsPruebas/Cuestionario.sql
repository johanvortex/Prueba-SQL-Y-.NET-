--1)	Cuál es el último REGISTRO y su fecha creación de la tabla Nom_nomina_definitiva
USE [Nomina]
GO

SELECT * FROM [dbo].[NOM_NOMINA_DEFINITIVA]
  WHERE FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])

GO

--2)	Considere el siguiente esquema: 
--Del ultimo registro de de Nom_nomina_definitiva traiga la siguiente información: 
 
 --NOM_CONCEPTOS_NOMINA.cod_concepto
USE [Nomina]
GO

SELECT nd.REGISTRO,nd.FCH_CRE,nd.ID_CONCEPTO,cn.ID_CONCEPTO FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd INNER JOIN [dbo].[NOM_CONCEPTOS_NOMINA] as cn
on nd.ID_CONCEPTO =cn.ID_CONCEPTO
  WHERE FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])
GO

--NOM_CONCEPTOS_NOMINA.DESC_CONCEPTO

USE [Nomina]
GO

SELECT cn.DESC_CONCEPTO FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd INNER JOIN [dbo].[NOM_CONCEPTOS_NOMINA] as cn
on nd.ID_CONCEPTO =cn.ID_CONCEPTO
  WHERE FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])
GO

--NOM_EMPLEADOS.ID_EMPLEADO

USE [Nomina]
GO

SELECT nd.REGISTRO,nd.FCH_CRE,nm.ID_EMPLEDOS FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd
INNER JOIN [dbo].NOM_EMPLEADO as nm 
on nd.ID_EMPLEADOS = nm.ID_EMPLEDOS
  WHERE FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])
GO

--REG_SOLICITUDES_INGRESO.NUM_DOC_IDENTIDAD
USE [Nomina]
GO

SELECT nd.REGISTRO,nd.FCH_CRE,rsi.DOCUMENTO FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd INNER JOIN [dbo].NOM_EMPLEADO as nm 
on nd.ID_EMPLEADOS= nm.ID_EMPLEDOS
 INNER JOIN [dbo].REG_SOLICITUDES_INGRESOS as rsi
 on nm.ID_SOLICITUD = rsi.ID_SOLICITUD
  WHERE  FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])
GO

--REG_SOLICITUDES_INGRESO.APELLIDOS

USE [Nomina]
GO

SELECT nd.REGISTRO,nd.FCH_CRE,rsi.APELLIDOS FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd INNER JOIN [dbo].NOM_EMPLEADO as nm 
on nd.ID_EMPLEADOS= nm.ID_EMPLEDOS
 INNER JOIN [dbo].REG_SOLICITUDES_INGRESOS as rsi
 on nm.ID_SOLICITUD = rsi.ID_SOLICITUD
  WHERE  FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])
GO

--REG_SOLICITUDES_INGRESO.NOMBRES 
USE [Nomina]
GO

SELECT nd.REGISTRO,nd.FCH_CRE,rsi.NOMBRES FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd INNER JOIN [dbo].NOM_EMPLEADO as nm 
on nd.ID_EMPLEADOS= nm.ID_EMPLEDOS
 INNER JOIN [dbo].REG_SOLICITUDES_INGRESOS as rsi
 on nm.ID_SOLICITUD = rsi.ID_SOLICITUD
  WHERE  FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])
GO

--NOM_NOMINA_DEFINITIVA.VAL_NOMINA

USE [Nomina]
GO

SELECT nd.REGISTRO,nd.FCH_CRE,nd.VAL_NOMINA FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd 
  WHERE  FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])
GO

--NOM_NOMINA_DEFINITIVA.CANTIDAD 

USE [Nomina]
GO
SELECT nd.REGISTRO,nd.FCH_CRE,nd.CANTIDAD FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd 
  WHERE  FCH_CRE =(SELECT MAX(FCH_CRE) FROM [dbo].[NOM_NOMINA_DEFINITIVA])
GO

--3)Cree una tabla llamada log_consulta_nom_nomina_definitiva con los siguientes campos: 

USE [Nomina]
GO
	CREATE TABLE [dbo].[log_consulta_nom_nomina_definitiva](
	[ID_REGISTRO] [int]identity(1,1) NOT NULL,
	[USUARIO] [nvarchar](30)  NOT NULL,
	[FECHA] [datetime] NOT NULL,
	[OPERACION] [nvarchar] (10) NOT NULL,
	[DESCRIPCION_DE_EVENTO] [nvarchar](50) NOT NULL,
  ) ON [PRIMARY]

GO

--4)Teniendo en cuenta el esquema de base de datos trabajado en el punto 2,
-- cree un procedimiento almacenado que cumpla las siguientes características:
-- Objetivo 1: EL procedimiento almacenado debe permitir consultar o modificar o eliminar registros.
---	Objetivo 2: EL procedimiento almacenado debe recibir un numero de documento digitado por el usuario y un evento a realizar los cuales pueden ser consultar, modificar o eliminar y el usuario que está realizando el evento. 
--Objetivo 3: para el evento consultar, el sistema debe mostrar la información de nómina del documento de identidad donde la FCH_CRE de Nom_nomina_definitiva sea superior al 01/01/2014. 
--Debe traer la siguiente información
--Objetivo 4:  adapte el procedimiento almacenado para los eventos de eliminar y actualizar
--Objetivo5: Cada vez que se consulte información debe crear un registro en la tabla: log_consulta_nom_nomina_definitiva.

USE [Nomina]
GO
CREATE PROCEDURE USP_CONSULTA_NOMINA_POR_DOCUMENTO
	@DOC_IDENTIDAD VARCHAR(50),
	@Evento NUMERIC (5),
	@Usuario VARCHAR(50) = ADMIN,
	@REGISTRO_NOM_NOMINA_DEFINITIVA NUMERIC(18) = NULL
	AS
	BEGIN 
	--DECLARE @Evento NUMERIC(5)
	IF (@Evento = 1) 
	begin 
	SELECT nd.REGISTRO,ncn.COD_CONCEPTO,ncn.DESC_CONCEPTO,nm.ID_EMPLEADOS,
	rsi.DOCUMENTO,rsi.APELLIDOS,rsi.NOMBRES,nd.VAL_NOMINA,nd.CANTIDAD  FROM [dbo].[NOM_NOMINA_DEFINITIVA] as nd 
	INNER JOIN [dbo].NOM_EMPLEADO as nm 
      on nd.ID_EMPLEADOS= nm.ID_EMPLEADOS
          INNER JOIN [dbo].REG_SOLICITUDES_INGRESOS as rsi
          on nm.ID_SOLICITUD = rsi.ID_SOLICITUD
		  INNER JOIN [dbo].NOM_CONCEPTOS_NOMINA as ncn
		  on nd.ID_CONCEPTO = ncn.ID_CONCEPTO
		   WHERE  FCH_CRE > '01/01/2014'
		  INSERT INTO [dbo].[log_consulta_nom_nomina_definitiva]
           ([USUARIO],[FECHA],[OPERACION],[DESCRIPCION_DE_EVENTO])
     VALUES (@Usuario,GETDATE(),@Evento,'Ver registro')
	end
	ELSE IF (@Evento = 2)
	begin
	INSERT INTO [dbo].[NOM_CONCEPTOS_NOMINA] ([DESC_CONCEPTO],[COD_CONCEPTO])
     VALUES (10,'Inserto PA ')
   INSERT INTO [dbo].[log_consulta_nom_nomina_definitiva] ([USUARIO],[FECHA],[OPERACION],[DESCRIPCION_DE_EVENTO])
     VALUES (@Usuario,GETDATE(),@Evento,'Inserto registro ')
	end
	ELSE IF (@Evento = 3)
	begin 
	UPDATE [dbo].[NOM_CONCEPTOS_NOMINA]
   SET 
      [DESC_CONCEPTO] = 'Cambio',
      [COD_CONCEPTO] = 'Cambio'
 WHERE ID_CONCEPTO = 1 
  INSERT INTO [dbo].[log_consulta_nom_nomina_definitiva] ([USUARIO],[FECHA],[OPERACION],[DESCRIPCION_DE_EVENTO])
     VALUES (@Usuario,GETDATE(),@Evento,'Actualizo registro ')
	end 
ELSE IF (@Evento = 4)
	begin 
	UPDATE [dbo].[NOM_CONCEPTOS_NOMINA]
   SET 
      [DESC_CONCEPTO] = 'Cambio',
      [COD_CONCEPTO] = 'Cambio'
 WHERE ID_CONCEPTO = 1 
  INSERT INTO [dbo].[log_consulta_nom_nomina_definitiva] ([USUARIO],[FECHA],[OPERACION],[DESCRIPCION_DE_EVENTO])
     VALUES (@Usuario,GETDATE(),@Evento,'Actualizo registro ')
	end 
	
	END 
GO

--Sentencia para ejecutar el procedimiento almacenado de listar 1 , crear 2 y actualizar 3

EXEC USP_CONSULTA_NOMINA_POR_DOCUMENTO '1.000.153',1,'ADMIN',15







