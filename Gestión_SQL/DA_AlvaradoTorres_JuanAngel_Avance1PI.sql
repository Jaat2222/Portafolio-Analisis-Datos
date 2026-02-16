--PASO 1: CREAR LA BASE DE DATOS

CREATE DATABASE FastFoodDb
ON
(
	NAME = 'FastFoodDb',
	FILENAME = 'C:\SQL_DB\FastFoodDb.mdf', -- RUTA
	SIZE = 50 MB,
	MAXSIZE = 1 GB,
	FILEGROWTH = 10 MB
)
LOG ON -- UTIL PARA DISASTER RECOVERY
(
	NAME = 'FastFoodDbLog',
	FILENAME = 'C:\SQL_DB\FastFoodDbLog.ldf', -- RUTA
	SIZE = 50 MB,
	MAXSIZE = 1 GB,
	FILEGROWTH = 10 MB
)
;


-- PASO 2: ACTIVAR LA BASE DE DATOS

USE FastFoodDb
;

-- PASO 3: CREAR TABLAS

-- CATEGORIAS
CREATE TABLE Categorias
(
	CategoriaId INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(100) NOT NULL
)
;

-- PRODUCTOS

CREATE TABLE Productos
(
	ProductoId INT PRIMARY KEY IDENTITY,
	Nombre NVARCHAR(100) NOT NULL,
	CategoriaId INT,
	Precio DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(CategoriaId) REFERENCES Categorias(CategoriaId)
)
;

-- SUCURSALES

CREATE TABLE Sucursales
(
	SucursalID INT PRIMARY KEY IDENTITY,
	Nombre NVARCHAR(100) NOT NULL,
	Direccion VARCHAR(100) NOT NULL
)
;

-- EMPLEADOS

CREATE TABLE Empleados
(
	EmpleadoID INT PRIMARY KEY IDENTITY,
	Nombre NVARCHAR(100) NOT NULL,
	Posicion NVARCHAR(100) NOT NULL,
	Departamento NVARCHAR(100) NOT NULL,
	SucursalID INT,
	Rol NVARCHAR(50) NOT NULL,
	FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID)
)
;
-- CLIENTES

CREATE TABLE Clientes
(
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre NVARCHAR(100) NOT NULL,
	Direccion NVARCHAR(100),
	Correo NVARCHAR(100),
	Telefono NVARCHAR(30),
	FechaNacimiento DATETIME
)
;

-- ORIGEN ORDEN
CREATE TABLE OrigenOrden
(
	OrigenID INT PRIMARY KEY IDENTITY,
	Descripcion NVARCHAR(255) NOT NULL
)
;


-- TIPO PAGO

CREATE TABLE TiposPago
(
	TipoPagoID INT PRIMARY KEY IDENTITY,
	Descripcion NVARCHAR(100) NOT NULL
)
;

-- MENSAJERO

CREATE TABLE Mensajero
(
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre NVARCHAR(100) NOT NULL,
	Vinculacion BIT NOT NULL
)
;

-- ORDENES
CREATE TABLE Ordenes
(
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT,
	EmpleadoID INT,
	SucursalID INT,
	MensajeroID INT,
	TipoPagoID INT,
	OrigenID INT,
	HorarioVenta NVARCHAR(100) NOT NULL,
	TotalCompra DECIMAL(10,2) NOT NULL,
	KilometrosRecorrer DECIMAL(10,2),
	FechaDespacho DATETIME NOT NULL,
	FechaEntrega DATETIME  NOT NULL,
	FechaOrdenTomada DATETIME  NOT NULL,
	FechaOrdenLista DATETIME  NOT NULL,
	FOREIGN KEY(ClienteID) REFERENCES Clientes(ClienteID),
	FOREIGN KEY(EmpleadoID) REFERENCES Empleados(EmpleadoID),
	FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID),
	FOREIGN KEY(MensajeroID) REFERENCES Mensajero(MensajeroID),
	FOREIGN KEY(TipoPagoID) REFERENCES TiposPago(TipoPagoID),
	FOREIGN KEY(OrigenID) REFERENCES OrigenOrden(OrigenID)
)
;

-- DETALLE
CREATE TABLE DetalleOrdenes
(
	OrdenID INT,
	ProductoID INT,
	Cantidad INT,
	Precio DECIMAL(10,2),
	PRIMARY KEY (OrdenID,ProductoID),
	FOREIGN KEY(ProductoID) REFERENCES Productos(ProductoID),
	FOREIGN KEY(OrdenID) REFERENCES Ordenes(OrdenID)
)
;
