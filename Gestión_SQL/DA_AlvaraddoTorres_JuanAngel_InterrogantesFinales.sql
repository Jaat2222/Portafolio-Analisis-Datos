USE FastFoodDb
GO;
--Eficiencia de los mensajeros: ¿Cuál es el tiempo promedio desde el despacho hasta la entrega de los 
--pedidos gestionados por todo el equipo de mensajería? 
SELECT 
    AVG(DATEDIFF(MINUTE, FechaDespacho, FechaEntrega)) AS TiempoPromedioMinutos
FROM 
    ordenes;
--Tiempo promedio en minutos son 30

--Análisis de Ventas por Origen de Orden: ¿Qué canal de ventas genera más ingresos?
SELECT 
    o.Descripcion AS CanalDeVentas, 
    SUM(ord.TotalCompra) AS IngresosTotales
FROM 
    Ordenes ord
JOIN 
    OrigenOrden o ON ord.OrigenID = o.OrigenID
GROUP BY 
    o.Descripcion
ORDER BY 
    IngresosTotales DESC;
--El canal de ventas que más ingresos genera es el presencial


--Productividad de los Empleados: ¿Cuál es el nivel de ingreso generado por Empleado? 
SELECT 
    e.Nombre AS Empleado, 
    SUM(o.TotalCompra) AS IngresosGenerados
FROM 
    Ordenes o
JOIN 
    Empleados e ON o.EmpleadoID = e.EmpleadoID
GROUP BY 
    e.Nombre
ORDER BY 
    IngresosGenerados DESC;
--El nivel de ingreso generado por empleado no muestra gran variabilidad, el rango está entre [0-195]


--Análisis de Demanda por Horario y Día: ¿Cómo varía la demanda de productos a lo largo del día? 
--NOTA: Esta consulta no puede ser implementada sin una definición clara del horario (mañana, tarde, noche) en la base de datos existente. 
--Asumiremos que HorarioVenta refleja esta información correctamente. 
SELECT 
    HorarioVenta, 
    SUM(TotalCompra) AS IngresosPorHorario
FROM 
    Ordenes
GROUP BY 
    HorarioVenta
ORDER BY 
    HorarioVenta;
--La demanda va de mayor a menor desde la mañana a la noche, decreciendo poco a poco


--Comparación de Ventas Mensuales: ¿Cuál es la tendencia de los ingresos generados en cada periodo mensual? 
SELECT 
    MONTH(FechaDespacho) AS Mes, 
    SUM(TotalCompra) AS IngresosMensuales
FROM 
    Ordenes
GROUP BY 
    MONTH(FechaDespacho)
ORDER BY 
    Mes;
--Debido a que la variabilidad es muy pequeña no existe una tendencia a la alza ni a la baja, mas bien tenemos un ciclo de estacionalidad.


--Análisis de Fidelidad del Cliente: ¿Qué porcentaje de clientes son recurrentes versus nuevos clientes cada mes?
--NOTA: La consulta se enfocaría en la frecuencia de órdenes por cliente para inferir la fidelidad. 
SELECT 
    ClienteID, 
    COUNT(OrdenID) AS FrecuenciaOrdenes
FROM 
    Ordenes
GROUP BY 
    ClienteID
ORDER BY 
    FrecuenciaOrdenes DESC;
--Como todos los clientes que tengo tienen solamente una orden, infiero desde aqui que todos son clientes nuevos
--en caso de que hubiese visto otra frecuencia se pudo resolver con un case.

