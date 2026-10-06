---------------------------------------------------------------------------------------------
-- JOIN

-- ¿Qué productos fueron incluidos en cada venta, quién realizó la compra, 
-- cuándo se realizó y cuál era el precio unitario de cada producto?

SELECT pr.id_producto, pr.nombre AS producto, c.nombre AS cliente, v.fecha, dv.precio_unitario
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto;


-- ¿Qué clientes han comprado productos de la categoría "novela", 
-- indicando el producto, la fecha de compra y la cantidad adquirida?

SELECT c.nombre AS cliente, pr.nombre AS producto, v.fecha, dv.cantidad
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto
WHERE categoria = 'novela';


-- ¿Qué productos se vendieron en cada venta, indicando el número de venta, 
-- el nombre del producto, la cantidad comprada y el precio unitario?

SELECT pr.nombre AS producto, v.id_venta, dv.cantidad, dv.precio_unitario
FROM detalle_venta dv 
JOIN venta v ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto;

-- ¿Qué clientes compraron productos de la categoría "tecnico", 
-- indicando el nombre del cliente, el producto, la cantidad comprada y el precio unitario?

SELECT c.nombre AS cliente, pr.nombre AS producto, dv.cantidad, dv.precio_unitario
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto
WHERE categoria = 'tecnico';

-- Qué clientes realizaron compras después del 10 de septiembre de 2026, 
-- indicando el nombre del cliente, la fecha de la compra, el producto adquirido y la cantidad?

SELECT c.nombre AS cliente, pr.nombre AS producto, dv.cantidad, v.fecha
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto
WHERE fecha > '2026-09-10';


----------------------------------------------------------------------------------------------------------
-- SUBCONSULTAS

-- Para cada cliente, mostrar su nombre y la fecha de su última compra.

SELECT c.nombre,
	(SELECT MAX(v.fecha) FROM venta v WHERE v.id_cliente = c.id_cliente) AS ultima_compra
FROM cliente c;

-- Para cada producto, mostrar su nombre y cuántas veces aparece en una venta.

SELECT pr.nombre,
	(SELECT COUNT(dv.cantidad) FROM detalle_venta dv WHERE dv.id_producto = pr.id_producto) AS cantidad 
FROM producto pr; 


-- Para cada producto, mostrar su nombre y la fecha de la última vez que fue vendido.

SELECT pr.nombre,
	(SELECT MAX(v.fecha) FROM venta v JOIN detalle_venta dv ON dv.id_venta = v.id_venta WHERE pr.id_producto = dv.id_producto) AS ultima_venta
FROM producto pr; 


----------------------------------------------------------------------------------------------------------
-- UNION

-- Unificar los productos de las categorías novela y poesía
SELECT nombre, categoria FROM producto WHERE categoria = 'novela'
UNION
SELECT nombre, categoria FROM producto WHERE categoria = 'poesia';

-- Unificar los productos con precio menor a $40.000 y los productos con stock menor a 20 unidades
SELECT nombre, precio, stock FROM producto WHERE precio < 40000
UNION
SELECT nombre, precio, stock FROM producto WHERE stock < 20;

-- Unificar los productos con precio menor a $35.000 y los productos con precio superior a $50.000
SELECT nombre, precio FROM producto WHERE precio < 35000
UNION
SELECT nombre, precio FROM producto WHERE precio > 50000;
