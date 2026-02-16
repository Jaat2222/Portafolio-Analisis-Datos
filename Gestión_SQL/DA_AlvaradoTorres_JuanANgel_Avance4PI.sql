--1: ¿Como puedo obtener una lista de todos los productos junto con sus categorías

USE [FastFoodDb]
GO

--Usando left
SELECT
	A.Nombre AS NombreProducto,
	B.Nombre AS NombreCategoria
FROM [dbo].[Productos] AS A
LEFT JOIN [dbo].[Categorias] AS B
ON A.CategoriaId=B.CategoriaId

--Usando Join
SELECT
	A.Nombre AS NombreProducto,
	B.Nombre AS NombreCategoria
FROM [dbo].[Productos] AS A
INNER JOIN [dbo].[Categorias] AS B
ON A.CategoriaId=B.CategoriaId
;

--2: ¿Como puedo saber a que sucursal está asignado cada empleado?
SELECT 
	A.EmpleadoID,
	A.Nombre AS [Nombre Empleado],
	B.Nombre AS [Nombre Sucursal]
FROM [dbo].[Empleados] AS A
INNER JOIN [dbo].[Sucursales] AS B
ON A.SucursalID=B.SucursalID
;

--3: ¿Existen productos que no tengan una categoría asignada?
SELECT
	A.Nombre AS NombreProducto,
	B.Nombre AS NombreCategoria
FROM [dbo].[Productos] AS A
LEFT JOIN [dbo].[Categorias] AS B
ON A.CategoriaId=B.CategoriaId
WHERE B.CategoriaId IS NULL

--4: ¿Cómo puedo obtener un detalle completo de las órdenes, incluyendo el Nombre del cliente,
--Nombre del empleado y Nombre del mensajero que la entregó?
SELECT
	A.OrdenID,
	A.FechaOrdenTomada,
	B.Nombre AS NombreCliente,
	C.Nombre AS NombreEmpleado,
	D.Nombre AS NombreMensajero
FROM [dbo].[Ordenes] AS A
INNER JOIN [dbo].[Clientes] AS B
	ON A.ClienteID = B.ClienteID
INNER JOIN [dbo].[Empleados] AS C
	ON A.EmpleadoID = C.EmpleadoID
INNER JOIN [dbo].[Mensajero] AS D
	ON A.MensajeroID = D.MensajeroID
;

--5: ¿Cuantos artículos correspondientes a cada categoría de productos se han vendido en cada sucursal?
SELECT
	--A.OrdenID,
	SUM(A.Cantidad) AS CantidadArticulo,
	--B.Nombre AS NombreProducto,
	C.Nombre AS NombreCategoria,
	E.Nombre AS NombreSucursal
FROM [dbo].[DetalleOrdenes] AS A
INNER JOIN [dbo].[Productos] AS B
	ON A.ProductoID = B.ProductoId
INNER JOIN [dbo].[Categorias] AS C
	ON B.CategoriaId = C.CategoriaId
INNER JOIN [dbo].[Ordenes] AS D
	ON A.OrdenID = D.OrdenID
INNER JOIN [dbo].[Sucursales] As E
	ON D.SucursalID = E.SucursalID
GROUP BY E.Nombre, C.Nombre
;




