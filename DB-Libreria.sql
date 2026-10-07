CREATE DATABASE IF NOT EXISTS checkpoint_caso_04;
USE checkpoint_caso_04;

CREATE TABLE producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE venta (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,	
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE detalle_venta (
    id_detalle_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

INSERT INTO producto (nombre, categoria, precio, stock) VALUES
('Novela contemporánea', 'novela', 48000, 30),
('Libro técnico universitario', 'tecnico', 85000, 15),
('Cuento infantil', 'infantil', 32000, 40),
('Libro de poesía', 'poesia', 35000, 20),
('Cómic', 'comic', 28000, 25),
('Ensayo histórico', 'ensayo', 52000, 12);

INSERT INTO cliente (nombre, correo, telefono) VALUES
('Paula Arango', 'paula.arango@mail.com', '3000400000'),
('Esteban Duque', 'esteban.duque@mail.com', '3000400001'),
('Manuela Giraldo', 'manuela.giraldo@mail.com', '3000400002'),
('Tomás Salazar', 'tomás.salazar@mail.com', '3000400003'),
('Antonia Ramírez', 'antonia.ramírez@mail.com', '3000400004'),
('Sebastián Jaramillo', 'sebastián.jaramillo@mail.com', '3000400005');
-- Nota: el último cliente (Sebastián Jaramillo) queda sin transacciones a propósito,
-- para practicar LEFT JOIN igual que en la Sesión 4.

INSERT INTO venta (fecha, id_cliente) VALUES
('2026-09-02', 1),
('2026-09-05', 2),
('2026-09-08', 3),
('2026-09-11', 4),
('2026-09-14', 5),
('2026-09-17', 1),
('2026-09-20', 2);

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 5, 1, 28000),
(1, 6, 2, 52000),
(2, 1, 2, 48000),
(2, 2, 3, 85000),
(3, 3, 3, 32000),
(3, 4, 1, 35000),
(4, 5, 1, 28000),
(4, 6, 2, 52000),
(5, 1, 2, 48000),
(5, 2, 3, 85000),
(6, 3, 3, 32000),
(6, 4, 1, 35000),
(7, 5, 1, 28000),
(7, 6, 2, 52000);

