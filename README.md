# Librería

Proyecto de **Bases de Datos II**.

Base de datos en MySQL para una librería que permite registrar productos, clientes y las ventas realizadas. La base de datos permite consultar información sobre los productos vendidos, los clientes que realizan compras, las categorías de los productos, sus precios y el stock disponible.

## Contenido del repositorio

| Archivo                    | Descripción                                                             |
| -------------------------- | ----------------------------------------------------------------------- |
| `DB - Librería.sql`        | Crea la base de datos, sus 4 tablas y los datos de prueba.              |
| `Scrip-parcial-corte-1.sql` | 11 consultas: JOIN multi-tabla, subconsultas correlacionadas y UNION.   |
| `explicacion_consultas.md` | Explicación de cada consulta, su funcionamiento y resultados esperados. |

## Modelo de datos

* **producto**: `id_producto`, `nombre`, `categoria`, `precio`, `stock`
* **cliente**: `id_cliente`, `nombre`, `correo`, `telefono`
* **venta**: `id_venta`, `fecha`, `id_cliente` (FK → cliente)
* **detalle_venta**: `id_detalle_venta`, `id_venta` (FK → venta), `id_producto` (FK → producto), `cantidad`, `precio_unitario`

Un cliente puede realizar varias ventas, y cada venta puede incluir varios productos mediante la tabla `detalle_venta`.

La tabla `producto` contiene la información de cada producto disponible en la librería, mientras que `detalle_venta` registra los productos incluidos en cada venta, junto con la cantidad y el precio unitario.

## Consultas incluidas

**1. JOIN multi-tabla (5)**

1. Productos incluidos en cada venta, indicando el cliente, la fecha y el precio unitario.
2. Clientes que compraron productos de la categoría `novela`, indicando el producto, la fecha y la cantidad.
3. Productos vendidos en cada venta, indicando el número de venta, la cantidad y el precio unitario.
4. Clientes que compraron productos de la categoría `tecnico`, indicando el producto, la cantidad y el precio unitario.
5. Clientes que realizaron compras después del 10 de septiembre de 2026, indicando el producto, la fecha y la cantidad.

**2. Subconsultas correlacionadas (3)**

1. Última compra realizada por cada cliente.
2. Cantidad de veces que aparece cada producto en una venta.
3. Última fecha en la que fue vendido cada producto.

**3. UNION (3)**

1. Productos pertenecientes a las categorías `novela` y `poesia`.
2. Productos con precio menor a $40.000 y productos con stock menor a 20 unidades.
3. Productos con precio menor a $35.000 y productos con precio superior a $50.000.

## Cómo ejecutarlo

1. Abre **MySQL Workbench** (o cualquier cliente MySQL).
2. Ejecuta `DB - Librería.sql` para crear la base de datos, las tablas y cargar los datos.
3. Ejecuta `Consultas - Librería.sql` para realizar las consultas. Puedes ejecutar cada consulta por separado.
4. Revisa `explicacion_consultas.md` para conocer qué hace cada consulta y validar los resultados obtenidos.

## Autor

**Sofia Ocampo** · Bases de Datos II
