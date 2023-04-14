-- Se crea la base de datos con nombre Sprint
CREATE DATABASE sprint;

-- Instruccion para mostrar todas las tablas
SHOW TABLES;

-- Selects de prueba
SELECT * FROM PRODUCTO;
SELECT * FROM CLIENTE;
SELECT * FROM PROVEEDOR;

-- Instruccion para usar esa base de datos especificamente sprint
use sprint;

-- Se crea la tabla de clientes
CREATE TABLE cliente(
	id_cliente int not null auto_increment,
    nombre_cliente varchar(255) not null,
    apellido_cliente varchar(255) not null,
    direccion_cliente varchar(255) not null UNIQUE,
    primary key(id_cliente)
);

-- Se crea la tabla producto
CREATE TABLE producto(
	id_producto int not null auto_increment,
    nombre_producto varchar(255) not null,
    categoria_producto varchar(255) not null,
    precio int not null,
    color varchar(255) not null,
    stock_producto int not null,
    primary key(id_producto)
);

-- Se crea la tabla proveedor con su respectiva relacion de uno a muchos
CREATE TABLE proveedor(
	id_proveedor int not null auto_increment,
    nombre_legal varchar(255) not null,
    nombre_corporativo varchar(255) not null,
    telefono_uno varchar(255) not null,
    telefono_dos varchar(255),
    correo varchar(255),
    id_producto int not null,
    primary key(id_proveedor),
    foreign key(id_producto) references producto(id_producto)
);

-- Agregando Clientes (SON 5)
INSERT INTO cliente (nombre_cliente, apellido_cliente, direccion_cliente)
VALUES ('Juan', 'Perez', 'Calle Principal #123, Ciudad X'),
       ('María', 'Gomez', 'Avenida Central #456, Ciudad Y'),
       ('Carlos', 'Fernandez', 'Paseo de la Montaña #789, Ciudad Z'),
       ('Laura', 'Lopez', 'Calle del Bosque #567, Ciudad A'),
       ('Andrés', 'Ramirez', 'Avenida de la Playa #234, Ciudad B');
       
-- Agregando Productos (SON 10)
INSERT INTO producto (nombre_producto, categoria_producto, precio, color, stock_producto)
VALUES ('ASUS ROG Strix', 'Teléfono inteligente', 500, 'Negro', 20),
       ('MSI X75', 'Notebook Gamer', 300, 'Rojo', 15),
       ('I9 9900X', 'Procesador', 150, 'Azul', 10),
       ('RADEON 9900', 'Tarjeta Grafica', 1000,'Rojo', 5),
       ('RTX 4090TI', 'Tarjeta Grafica', 80, 'Verde', 30);
       
-- Agregando Proveedores (SON 5)
INSERT INTO proveedor (nombre_legal, nombre_corporativo, telefono_uno, telefono_dos, correo, id_producto)
VALUES ('ASUS', 'ASUS Corp', '123456789', '987654321', 'asus@proveedor.com', 1),
       ('MSI', 'MSI Corp', '987654321', '123456789', 'msi@proveedor.com', 2),
       ('Intel', 'Intel Corp', '456789123', '321987654', 'intel@proveedor.com', 3),
       ('AMD', 'AMD Corp', '789123456', '654321987', 'amd@proveedor.com', 4),
       ('Nvidia', 'Nvidia Corp', '654321987', '789123456', 'nvidia@proveedor.com', 5);

-- Desarrollo

-- Cuál es la categoría de productos que más se repite.

SELECT categoria_producto, COUNT(*) as count
FROM producto
GROUP BY categoria_producto
ORDER BY count DESC
LIMIT 1;

-- Cuáles son los productos con mayor stock

SELECT *
FROM producto
WHERE stock_producto = (SELECT MAX(stock_producto) FROM producto);

-- Qué color de producto es más común en nuestra tienda.

SELECT color
FROM producto
WHERE color = (SELECT MAX(color) FROM producto);

-- Cual o cuales son los proveedores con menor stock de productos.

SELECT p.*
FROM proveedor p
WHERE p.id_proveedor = (SELECT id_producto
                        FROM producto
                        ORDER BY stock_producto ASC
                        LIMIT 1);

-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.     

UPDATE producto
SET categoria_producto = 'Electrónica y computación'
WHERE categoria_producto = (
    SELECT categoria_producto
    FROM (
        SELECT categoria_producto
        FROM producto
        GROUP BY categoria_producto
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS subquery
);       

-- Integrantes: Cristian Trureo, Marcelo Vargas, Leandro Villalba, Luis Zambrano.





