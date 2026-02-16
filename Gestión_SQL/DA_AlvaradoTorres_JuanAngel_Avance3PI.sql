--P1:Total de Ventas Globales
USE [FastFoodDb]
;

SELECT 
	SUM(TotalCompra) AS TotalVentas
FROM [dbo].[Ordenes]

--P2: promedio de precio por categorias
SELECT 
	AVG(Precio) AS PromedioPrecio,CategoriaId
FROM [dbo].[Productos]
GROUP BY CategoriaId
ORDER BY PromedioPrecio DESC
;

--JOIN IMPLICITO (Siempre da el resultado de un inner join)
SELECT
	CAST(AVG(Precio) AS DECIMAL(10,2)) AS PromedioPrecio,
	B.Nombre
FROM
	[dbo].[Productos] AS A,
	[dbo].[Categorias] AS B
WHERE A.CategoriaId = B.CategoriaId
GROUP BY B.Nombre
ORDER BY PromedioPrecio DESC
;

--P3: Orden máxima y mínima por sucursal
SELECT
	MIN(TotalCompra) AS ValorOrdenMinima,
	MAX(TotalCompra) AS ValorOrdenMaxima,
	SucursalId
FROM [dbo].[Ordenes]
GROUP BY SucursalId
;

--P4: Mayor numero de kilometros recorridos para entrega
SELECT
	MAX(KilometrosRecorrer) AS KilometrosMaximo
FROM [dbo].[Ordenes]
;

--Alternativa
SELECT 
	TOP 1
	KilometrosRecorrer
FROM [dbo].[Ordenes]
ORDER BY KilometrosRecorrer DESC
;

--P5: Promedio de cantidad de productos por orden
SELECT
	AVG(Cantidad) AS PromedioCantidadProductos,
	OrdenId
FROM [dbo].[DetalleOrdenes]
GROUP BY OrdenId
;

--P6: Total de ventas por tipo de pago
SELECT
	SUM(TotalCompra) AS TotalVentas,
	TipoPagoId
FROM [dbo].[Ordenes]
GROUP BY TipoPagoId
ORDER BY TotalVentas DESC
;

--P7: Sucursal con la venta promedio mas alta
SELECT
	TOP 1
	SucursalID,
	AVG(TotalCompra) AS VentaPromedio
FROM [dbo].[Ordenes]
GROUP BY SucursalID
ORDER BY VentaPromedio DESC
;

--P8: Sucursal con la mayor cantidad de ventas por encima de un umbral
SELECT 
	TOP 1
	SucursalID,
	SUM(TotalCompra) AS VentaTotal
FROM [dbo].[Ordenes]
GROUP BY SucursalID
HAVING SUM(TotalCompra)>1000
ORDER BY VentaTotal DESC
;

--P9: Comparación de ventas promedio antes y después de una fecha específica
--¿Como se comparan las ventas promedio antes y después del 1 de Julio de 2023?
--SELECT * FROM [dbo].[Ordenes]
SELECT 
	AVG(TotalCompra) AS PromedioVentas
FROM [dbo].[Ordenes]
WHERE FechaOrdenTomada > '2023-07-01'
;

SELECT 
	AVG(TotalCompra) AS PromedioVentas
FROM [dbo].[Ordenes]
WHERE FechaOrdenTomada <= '2023-07-01'
;

--CASE WHEN
SELECT
	Umbral,
	CAST(AVG(TotalCompra) AS DECIMAL(10,1)) AS PromedioVentas
FROM
(
	SELECT
		CASE
			WHEN FechaOrdenTomada > '2023-07-01' THEN 'PosteriorUmbral'
			ELSE 'AnteriorUmbral'
		END Umbral,
		TotalCompra
	FROM [dbo].[Ordenes]
) AS Subconsulta
GROUP BY Umbral
;

--P10: Análisis de actividad de ventas por horario
--¿Durante qué horario del día (mañana,tarde,noche) se registra la mayor cantidad de ventas?
--Cuál es el ingreso promedio de estas ventas, y cual ha sido el importe máximo alcanzado por una orden en dicha jornada?

SELECT 
	HorarioVenta,
	COUNT(OrdenID) AS CantidadVentas,
	AVG(TotalCompra) AS IngresoPromedio,
	MAX(TotalCompra) AS ImporteMaximo
FROM [dbo].[Ordenes]
GROUP BY HorarioVenta
ORDER BY CantidadVentas DESC
;
