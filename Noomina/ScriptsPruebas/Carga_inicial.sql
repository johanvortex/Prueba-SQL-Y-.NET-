--Insertar en la tabla de REG_SOLICITUDES_INGRESOS
USE [Nomina]
GO
INSERT INTO [dbo].[REG_SOLICITUDES_INGRESOS]
           
           ([DOCUMENTO],[APELLIDOS],[NOMBRES])
     VALUES
           (1.000,'Romero Ocaño','Johan Camilo'),
           (2.000,'Romero Medina','Johan Andres'),
           (3.000,' Medina',' Andres'),
	       (4.000,'Romero ','Johan '),
	       (5.000,'Martinez','Sebastian')
GO

USE [Nomina]
GO

INSERT INTO [dbo].[NOM_CONCEPTOS_NOMINA]
           ([DESC_CONCEPTO],[COD_CONCEPTO])
     VALUES
           (10,'Concepto 1'),
           (20,'Concepto 2'),
		   (30,'Concepto 3'),
		   (40,'Concepto 4'),
		   (50,'Concepto 5')
         
GO

USE [Nomina]
GO

INSERT INTO [dbo].[NOM_NOMINA_DEFINITIVA]
           ([FCH_CRE],[ID_CONCEPTO],[ID_EMPLEADOS],[VAL_NOMINA],[CANTIDAD])
     VALUES
           ('2022-04-28',1,1,5000,2),
           ('2022-04-27',2,2,5000,2),
		   ('2022-04-26',3,3,6000,5),
		   ('2022-04-25',4,4,7000,6),
		   ('2022-04-24',5,5,3000,7)
GO

USE [Nomina]
GO

INSERT INTO [dbo].[NOM_EMPLEADO]
           ([ID_EMPLEDOS]
           ,[ID_SOLICITUD])
     VALUES
           (1,1),
           (3,3),
		   (4,4),
		   (5,5)
GO