# Explicación de las consultas · Librería

## 1. JOIN multi-tabla

**1.1 Productos incluidos en cada venta, cliente, fecha y precio unitario.**

Esta consulta relaciona las cuatro tablas principales: `cliente`, `venta`, `detalle_venta` y `producto`. Se utiliza `JOIN` porque la información que se necesita se encuentra distribuida entre estas tablas: el cliente está relacionado con la venta, la venta con el detalle de venta y el detalle con el producto. De esta manera, se puede conocer qué producto fue comprado, quién realizó la compra, cuándo se realizó y cuál era su precio unitario.

**1.2 Clientes que compraron productos de la categoría novela.**

La consulta relaciona `cliente`, `venta`, `detalle_venta` y `producto` para conocer las compras realizadas por los clientes. Se utiliza la condición `WHERE categoria = 'novela'` para mostrar únicamente los productos pertenecientes a esta categoría. Esto permite identificar qué clientes compraron novelas, qué producto adquirieron, cuándo realizaron la compra y qué cantidad compraron.

**1.3 Productos vendidos en cada venta, con cantidad y precio unitario.**

Esta consulta parte de `detalle_venta` y la relaciona con `venta` y `producto`. Se utiliza `detalle_venta` como punto de relación porque esta tabla contiene la información de los productos incluidos en cada venta, además de la cantidad y el precio unitario. De esta manera, se puede consultar el número de venta, el producto vendido, la cantidad adquirida y su precio unitario.

**1.4 Clientes que compraron productos de la categoría técnico.**

Esta consulta relaciona las tablas `cliente`, `venta`, `detalle_venta` y `producto` para conocer qué clientes adquirieron productos de la categoría técnico. Se utiliza un filtro mediante `WHERE categoria = 'tecnico'` para mostrar únicamente los productos que pertenecen a esta categoría. Esto permite identificar el cliente, el producto adquirido, la cantidad y el precio unitario.

**1.5 Clientes que realizaron compras después del 10 de septiembre de 2026.**

La consulta relaciona `cliente`, `venta`, `detalle_venta` y `producto` para obtener información sobre las compras realizadas después de una fecha determinada. Se utiliza la condición `WHERE fecha > '2026-09-10'` para filtrar únicamente las ventas posteriores al 10 de septiembre de 2026. Esto permite conocer el cliente que realizó la compra, la fecha, el producto adquirido y la cantidad.

## 2. Subconsulta correlacionada

**2.1 Última compra realizada por cada cliente.**

La consulta principal recorre todos los registros de la tabla `cliente` y, para cada cliente, la subconsulta busca sus ventas correspondientes. Se utiliza `MAX(v.fecha)` para obtener la fecha más reciente de compra. La condición `v.id_cliente = c.id_cliente` relaciona la subconsulta con el cliente de la consulta principal, por lo que la subconsulta cambia dependiendo del cliente que se esté evaluando. Esto permite conocer la última compra realizada por cada cliente.

**2.2 Cantidad de veces que aparece cada producto en una venta.**

La consulta principal recorre todos los productos y la subconsulta cuenta los registros de `detalle_venta` correspondientes a cada producto. Se utiliza `COUNT(dv.cantidad)` para determinar cuántas veces aparece cada producto en los detalles de las ventas. La condición `dv.id_producto = pr.id_producto` hace que el conteo corresponda únicamente al producto que se está evaluando.

**2.3 Última fecha en la que fue vendido cada producto.**

La consulta principal recorre todos los productos y la subconsulta relaciona `venta` con `detalle_venta` para encontrar las ventas en las que aparece cada producto. Se utiliza `MAX(v.fecha)` para obtener la fecha más reciente de venta. La condición que relaciona `pr.id_producto` con `dv.id_producto` hace que la búsqueda se realice específicamente para cada producto. Esto permite conocer cuándo fue vendido por última vez cada producto.

## 3. UNION

**3.1 Productos de las categorías novela y poesía.**

La primera consulta obtiene los productos cuya categoría es `novela` y la segunda obtiene los productos cuya categoría es `poesia`. Se utiliza `UNION` para combinar ambos resultados en un solo listado. Esto permite consultar conjuntamente los productos pertenecientes a estas dos categorías.

**3.2 Productos con precio menor a $40.000 o con stock menor a 20 unidades.**

La primera consulta obtiene los productos cuyo precio es inferior a $40.000, mientras que la segunda obtiene aquellos que tienen un stock inferior a 20 unidades. Se utiliza `UNION` para reunir ambos resultados en un solo listado. Esto permite identificar productos que cumplen alguna de estas dos condiciones, ya sea porque tienen un precio bajo o porque cuentan con pocas unidades disponibles.

**3.3 Productos con precio menor a $35.000 o superior a $50.000.**

La primera consulta obtiene los productos cuyo precio es menor a $35.000 y la segunda obtiene aquellos cuyo precio es superior a $50.000. Se utiliza `UNION` para combinar ambos grupos en un solo resultado. Esto permite identificar los productos que se encuentran en los extremos del rango de precios, es decir, los productos de menor y mayor valor.

## Resultados esperados (para validar)

* **1.1:** Debe mostrar los productos incluidos en cada venta junto con el cliente, la fecha y el precio unitario.
* **1.2:** Debe mostrar únicamente los clientes que compraron productos de categoría `novela`, junto con el producto, fecha y cantidad.
* **1.3:** Debe mostrar cada venta con sus respectivos productos, cantidad y precio unitario.
* **1.4:** Debe mostrar únicamente los clientes que compraron productos de categoría `tecnico`.
* **1.5:** Debe mostrar únicamente las compras realizadas después del **10 de septiembre de 2026**.
* **2.1:** Cada cliente debe aparecer con la fecha de su última compra; si un cliente nunca ha comprado, el resultado será `NULL`.
* **2.2:** Cada producto debe aparecer con la cantidad de veces que está registrado en `detalle_venta`.
* **2.3:** Cada producto debe aparecer con la fecha de su última venta; si nunca ha sido vendido, el resultado será `NULL`.
* **3.1:** Debe aparecer un solo listado con los productos de las categorías `novela` y `poesia`.
* **3.2:** Debe aparecer un solo listado con los productos que tienen precio menor a $40.000 o stock menor a 20.
* **3.3:** Debe aparecer un solo listado con los productos cuyo precio es menor a $35.000 o superior a $50.000.
