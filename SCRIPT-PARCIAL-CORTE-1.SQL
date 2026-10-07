-- =====================================================================
-- CASO · Librería
-- Bases de Datos II
-- Consultas: JOIN multi-tabla, Subconsulta correlacionada y UNION
-- =====================================================================

-- =====================================================================
-- 1. JOIN MULTI-TABLA (5 consultas)
-- =====================================================================

-- 1.1 ¿Qué productos fueron incluidos en cada venta, quién realizó la
-- compra, cuándo se realizó y cuál era el precio unitario?
-- Tablas: cliente, venta, detalle_venta, producto.
-- Se relacionan las cuatro tablas para obtener en un mismo resultado
-- la información del cliente, la venta y los productos adquiridos.

SELECT pr.id_producto, pr.nombre AS producto, c.nombre AS cliente, v.fecha, dv.precio_unitario
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto;

-- 1.2 ¿Qué clientes han comprado productos de la categoría "novela",
-- indicando el producto, la fecha de compra y la cantidad adquirida?
-- Tablas: cliente, venta, detalle_venta, producto.
-- Se utiliza WHERE para filtrar únicamente los productos cuya categoría
-- sea 'novela'. El resultado muestra el cliente, producto, fecha y cantidad.

SELECT c.nombre AS cliente, pr.nombre AS producto, v.fecha, dv.cantidad
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto
WHERE categoria = 'novela';

-- 1.3 ¿Qué productos se vendieron en cada venta, indicando el número
-- de venta, el nombre del producto, la cantidad comprada y el
-- precio unitario?
-- Tablas: detalle_venta, venta, producto.
-- Se utiliza detalle_venta como punto de partida porque contiene la
-- relación entre cada venta y los productos incluidos en ella.
-- También contiene la cantidad y el precio unitario de cada producto.

SELECT pr.nombre AS producto, v.id_venta, dv.cantidad, dv.precio_unitario
FROM detalle_venta dv 
JOIN venta v ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto;

-- 1.4 ¿Qué clientes compraron productos de la categoría "tecnico",
-- indicando el nombre del cliente, el producto, la cantidad
-- comprada y el precio unitario?
-- Tablas: cliente, venta, detalle_venta, producto.
-- Se relacionan las tablas para identificar qué clientes realizaron
-- compras y qué productos adquirieron.
-- El filtro WHERE permite mostrar únicamente productos de categoría
-- 'tecnico'.

SELECT c.nombre AS cliente, pr.nombre AS producto, dv.cantidad, dv.precio_unitario
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto
WHERE categoria = 'tecnico';

-- 1.5 ¿Qué clientes realizaron compras después del 10 de septiembre
-- de 2026, indicando el nombre del cliente, la fecha de la compra,
-- el producto adquirido y la cantidad?
-- Tablas: cliente, venta, detalle_venta, producto.
-- Se utiliza la fecha registrada en la tabla venta para filtrar las
-- compras posteriores al 10 de septiembre de 2026.
-- La condición permite consultar únicamente las ventas realizadas
-- después de la fecha indicada.

SELECT c.nombre AS cliente, pr.nombre AS producto, dv.cantidad, v.fecha
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN producto pr ON dv.id_producto = pr.id_producto
WHERE fecha > '2026-09-10';

-- =====================================================================
-- 2. SUBCONSULTA CORRELACIONADA (3 consultas)
-- =====================================================================

-- 2.1 ¿Cuál fue la última compra realizada por cada cliente?
-- La subconsulta se ejecuta para cada cliente de la consulta principal.
-- La condición v.id_cliente = c.id_cliente relaciona la subconsulta
-- con el cliente que se está evaluando.
-- MAX(v.fecha) permite obtener la fecha más reciente de compra.

SELECT c.nombre,
	(SELECT MAX(v.fecha) FROM venta v WHERE v.id_cliente = c.id_cliente) AS ultima_compra
FROM cliente c;

-- 2.2 ¿Cuántas veces aparece cada producto en una venta?
-- La consulta principal recorre todos los productos.
-- La subconsulta cuenta los registros de detalle_venta que corresponden
-- al producto actual mediante dv.id_producto = pr.id_producto.
-- COUNT() permite conocer cuántas veces aparece cada producto.

SELECT pr.nombre,
	(SELECT COUNT(dv.cantidad) FROM detalle_venta dv WHERE dv.id_producto = pr.id_producto) AS cantidad 
FROM producto pr; 

-- 2.3 ¿Cuál fue la última fecha en la que se vendió cada producto?
-- La consulta principal recorre todos los productos.
-- La subconsulta relaciona venta y detalle_venta para encontrar las
-- fechas en las que fue vendido cada producto.
-- MAX(v.fecha) selecciona la fecha más reciente para cada producto.

SELECT pr.nombre,
	(SELECT MAX(v.fecha) FROM venta v JOIN detalle_venta dv ON dv.id_venta = v.id_venta WHERE pr.id_producto = dv.id_producto) AS ultima_venta
FROM producto pr; 

-- =====================================================================
-- 3. UNION (3 consultas)
-- =====================================================================


-- 3.1 Productos de las categorías "novela" y "poesia".
-- La primera consulta obtiene los productos de categoría novela y la
-- segunda obtiene los productos de categoría poesia.
-- UNION combina ambos resultados en un solo listado.
-- Ambas consultas devuelven las mismas dos columnas: nombre y categoria.

SELECT nombre, categoria FROM producto WHERE categoria = 'novela'
UNION
SELECT nombre, categoria FROM producto WHERE categoria = 'poesia';

-- 3.2 Productos con precio menor a $40.000 y productos con stock
-- menor a 20 unidades.
-- Listado A: productos cuyo precio es inferior a $40.000.
-- Listado B: productos cuyo stock es inferior a 20 unidades.
-- UNION permite combinar ambos grupos en un solo resultado.
-- Las dos consultas devuelven las mismas tres columnas: nombre,
-- precio y stock.

SELECT nombre, precio, stock FROM producto WHERE precio < 40000
UNION
SELECT nombre, precio, stock FROM producto WHERE stock < 20;

-- 3.3 Productos con precio menor a $35.000 y productos con precio
-- superior a $50.000.
-- Listado A: productos con precio inferior a $35.000.
-- Listado B: productos con precio superior a $50.000.
-- UNION combina ambos grupos en un solo listado.
-- Ambas consultas devuelven las mismas dos columnas: nombre y precio.

SELECT nombre, precio FROM producto WHERE precio < 35000
UNION
SELECT nombre, precio FROM producto WHERE precio > 50000;
