USE [FastFood_DB];

--UPDATE Y DELETE

--ACTUALIZACIONES DE EJEMPLO (UPDATE)

-- Aumentar el precio de todos los productos en la categoría 1
UPDATE Productos SET Precio = Precio + 1 WHERE CategoriaID = 1;

-- Cambiar la posición de todos los empleados del departamento 'Cocina' a 'Chef'
UPDATE Empleados SET Posicion = 'Chef' WHERE Departamento = 'Cocina';

-- Actualizar la dirección de una sucursal específica
UPDATE Sucursales SET Direccion = '1234 New Address St' WHERE SucursalID = 1;

--ELIMINACIONES DE EJEMPLO (DELETE)

/*1. Eliminar una orden específica
Imaginemos que quieres eliminar una orden específica, 
por ejemplo, la orden con OrdenID = 10. 
Esta operación eliminaría la orden junto con sus detalles asociados 
(deberías asegurarte de eliminar o actualizar cualquier dato relacionado 
para mantener la integridad referencial).*/

DELETE FROM DetalleOrdenes WHERE OrdenID = 10;
DELETE FROM Ordenes WHERE OrdenID = 10;

/*2. Eliminar todos los productos de una categoría específica
Si decides dejar de ofrecer todos los "Postres" 
(supongamos que Categorias.CategoriaID = 2 para "Postres"), 
podrías querer eliminar todos los productos asociados a esa categoría.*/

DELETE FROM Productos WHERE CategoriaID = 2;
--Antes de ejecutar este comando, deberías considerar si hay órdenes que incluyen estos productos y decidir cómo manejar esas referencias.

select * from DetalleOrdenes

/*3. Eliminar empleados de una sucursal que cerró
Si una sucursal cierra, por ejemplo, 
SucursalID = 10 (Sucursal Bosque), 
podrías necesitar eliminar a todos los empleados asociados con esa sucursal.*/

DELETE FROM Empleados WHERE SucursalID = 10;