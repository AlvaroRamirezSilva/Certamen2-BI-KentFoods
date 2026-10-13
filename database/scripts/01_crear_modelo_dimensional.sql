/* =====================================================================
   Certamen 2 - Inteligencia de Negocios (UTFSM)
   Caso 3: Kent Foods
   Fase 1 - Script de creacion del modelo dimensional (estrella)
   Base de datos destino: KentFoods_DW
   Proceso de negocio : ventas (ordenes de alimentos)
   Granularidad       : una fila por linea de detalle de orden
                        (OrdenID + ProductoID)
   ===================================================================== */

USE master;
GO

IF DB_ID('KentFoods_DW') IS NULL
    CREATE DATABASE KentFoods_DW;
GO

USE KentFoods_DW;
GO

/* Se elimina en orden inverso (primero el hecho) para poder re-ejecutar */
DROP TABLE IF EXISTS H_VENTAS;
DROP TABLE IF EXISTS D_TRANSPORTISTA;
DROP TABLE IF EXISTS D_EMPLEADO;
DROP TABLE IF EXISTS D_PRODUCTO;
DROP TABLE IF EXISTS D_CLIENTE;
DROP TABLE IF EXISTS D_TIEMPO;
GO

CREATE TABLE D_TIEMPO (
    ID_TIEMPO  DATE         NOT NULL PRIMARY KEY,
    DIA        INT          NOT NULL,
    MES        INT          NOT NULL,
    NOM_MES    NVARCHAR(20) NOT NULL,
    TRIMESTRE  INT          NOT NULL,
    ANIO       INT          NOT NULL
);

CREATE TABLE D_CLIENTE (
    ID_CLIENTE  INT          NOT NULL PRIMARY KEY,   -- clave entera generada en el ETL
    COD_CLIENTE NCHAR(5)     NOT NULL,               -- codigo original (ej. ALFKI)
    EMPRESA     NVARCHAR(40),
    CONTACTO    NVARCHAR(30),
    CARGO       NVARCHAR(30),
    CIUDAD      NVARCHAR(15),
    PAIS        NVARCHAR(15)
);

CREATE TABLE D_PRODUCTO (
    ID_PRODUCTO         INT NOT NULL PRIMARY KEY,
    PRODUCTO            NVARCHAR(40),
    CANTIDAD_POR_UNIDAD NVARCHAR(20),
    ID_CATEGORIA        INT,
    CATEGORIA           NVARCHAR(15),
    ID_PROVEEDOR        INT,
    PROVEEDOR           NVARCHAR(40),
    PAIS_PROVEEDOR      NVARCHAR(15)
);

CREATE TABLE D_EMPLEADO (
    ID_EMPLEADO        INT NOT NULL PRIMARY KEY,
    NOMBRE             NVARCHAR(10),
    APELLIDO           NVARCHAR(20),
    NOM_COMPLETO       NVARCHAR(31),
    CARGO              NVARCHAR(30),
    FECHA_NACIMIENTO   DATE,
    FECHA_CONTRATACION DATE,
    CIUDAD             NVARCHAR(15),
    PAIS               NVARCHAR(15)
);

CREATE TABLE D_TRANSPORTISTA (
    ID_TRANSPORTISTA INT NOT NULL PRIMARY KEY,
    TRANSPORTISTA    NVARCHAR(40),
    TELEFONO         NVARCHAR(24)
);

CREATE TABLE H_VENTAS (
    ID_ORDEN         INT      NOT NULL,
    ID_PRODUCTO      INT      NOT NULL,
    ID_CLIENTE       INT      NULL,
    ID_EMPLEADO      INT      NULL,
    ID_TRANSPORTISTA INT      NULL,
    ID_TIEMPO        DATE     NULL,
    PRECIO_UNITARIO  MONEY,
    CANTIDAD         SMALLINT,
    DESCUENTO        REAL,
    VENTA_BRUTA      MONEY,
    VENTA_NETA       MONEY,
    DIAS_ENVIO       INT      NULL,   -- NULL cuando la orden aun no tiene FechaEnvio
    CONSTRAINT PK_H_VENTAS PRIMARY KEY (ID_ORDEN, ID_PRODUCTO),
    CONSTRAINT FK_H_TIEMPO        FOREIGN KEY (ID_TIEMPO)        REFERENCES D_TIEMPO(ID_TIEMPO),
    CONSTRAINT FK_H_CLIENTE       FOREIGN KEY (ID_CLIENTE)       REFERENCES D_CLIENTE(ID_CLIENTE),
    CONSTRAINT FK_H_PRODUCTO      FOREIGN KEY (ID_PRODUCTO)      REFERENCES D_PRODUCTO(ID_PRODUCTO),
    CONSTRAINT FK_H_EMPLEADO      FOREIGN KEY (ID_EMPLEADO)      REFERENCES D_EMPLEADO(ID_EMPLEADO),
    CONSTRAINT FK_H_TRANSPORTISTA FOREIGN KEY (ID_TRANSPORTISTA) REFERENCES D_TRANSPORTISTA(ID_TRANSPORTISTA)
);
GO
