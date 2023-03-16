CREATE SCHEMA minimercado;

USE minimercado;

#Creamos la tabla productos
CREATE TABLE productos(
productos_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_producto VARCHAR(50)
);

#Creamos la tabla categoría
CREATE TABLE categoria(
categoria_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
categoria VARCHAR(30)
);

#Creamos la tabla proveedores
CREATE TABLE proveedores(
proveedores_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_proveedor VARCHAR(50),
email_proveedor VARCHAR(50),
telefono_proveedor VARCHAR(15)
);

#Creamos la tabla relacional productosProveedores
CREATE TABLE productosProveedores(
productos_id INTEGER NOT NULL,
proveedores_id INTEGER NOT NULL
);

#Creamos la tabla ventas
CREATE TABLE ventas(
ventas_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
fecha_venta DATE,
monto_total INTEGER
);

#Creamos la tabla detalleVentas
CREATE TABLE detalleVentas(
detalleVentas_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
cantidad_productos INTEGER,
precio_producto INTEGER
);

#Agregamos la columna categoria_id a la tabla productos para que sea Foreign Key
ALTER TABLE productos add categoria_id INTEGER NOT NULL;
ALTER TABLE productos
ADD FOREIGN KEY (categoria_id) REFERENCES categoria (categoria_id);

#Agregamos Foreign Keys a tabla relacional productosProveedores
ALTER TABLE productosProveedores
ADD FOREIGN KEY (productos_id) REFERENCES productos (productos_id);
ALTER TABLE productosProveedores
ADD FOREIGN KEY (proveedores_id) REFERENCES proveedores (proveedores_id);

#agregamos columnas a la tabla detalleVentas para vincularla con las tablas ventas y productos
ALTER TABLE detalleVentas add producto_id INTEGER NOT NULL;
ALTER TABLE detalleVentas add ventas_id INTEGER NOT NULL;
ALTER TABLE detalleVentas
ADD FOREIGN KEY (productos_id) REFERENCES productos (productos_id);
ALTER TABLE detalleVentas
ADD FOREIGN KEY (ventas_id) REFERENCES ventas (ventas_id);


#agregamos datos a la tabla categoria
INSERT INTO categoria (categoria) VALUES ("Bebida vegetal"),
("Pastas"),
("Limpieza"),
("Lácteos"),
("Panadería"),
("Huevos"),
("Aseo personal")
;

#Agregamos datos a la tabla productos
INSERT INTO productos (nombre_producto, categoria_id) VALUES ("Bebida vegetal almendra", 1),
("Fusilli integral", 2),
("Detergente líquido", 3),
("Leche de vaca", 4),
("Huevos color 12 ud", 6),
("Pan integral grano entero", 5),
("Shampoo en barra", 7)
;

#Agregamos datos a la tabla proveedores
INSERT INTO proveedores(nombre_proveedor, email_proveedor, telefono_proveedor) VALUES ("Comercializadora Nehuen", "Nehuen@ventas.cl", "945783456"),
("Panadería Messina", "panaderia@messina.com", "994583495"),
("Abarrotes Josefina", "josefinaabarrotes@gmail.com", "945731234"),
("Cosmética Natural Andina", "ventas@cnandinas.cl", "9483449542"),
("Huevos Pollito Feliz", "pollitofeliz@gmail.com", "956734754"),
("Productos de Limpieza FM", "limpiezafm@gmail.com", "978657843")
;

#Agregamos datos a la tabla relacional productosProveedores
INSERT INTO productosProveedores (productos_id, proveedores_id) VALUES (1, 1),
(1, 3),
(2, 1),
(2, 3),
(3, 5),
(4, 1),
(4, 5),
(5, 5),
(6, 2),
(6, 3),
(7, 4)
;

#Agregamos datos a la tabla ventas
INSERT INTO ventas ( fecha_venta, monto_total)
VALUES ('2022-06-30', 10000),
('2022-07-20', 6000),
('2022-08-25', 15000),
('2022-09-10', 9000),
('2022-10-23', 20000),
('2022-12-24', 10000),
('2023-01-03', 25000),
('2023-02-20', 4000)
;

#Agregamos datos a la tabla detalleVentas
INSERT INTO detalleVentas (cantidad_productos, precio_producto, productos_id, ventas_id)
VALUES (2, 5000, 7, 1),
(2, 3000, 3, 2),
(2, 1500, 2, 3),
(7, 1000, 4, 3),
(1, 5000, 7, 3),
(3, 3000, 6, 4),
(4, 5000, 7, 5),
(3, 2500, 5, 6),
(1, 1500, 2, 6),
(1, 1000, 4, 6),
(5, 3000, 6, 7),
(2, 5000, 7, 7),
(1, 1500, 2, 8),
(1, 2500, 5, 8)
;






#Traer la información completa de cada tabla
SELECT * FROM categoria;
SELECT * FROM Productos;
SELECT * FROM Proveedores;
SELECT * FROM productosProveedores;
SELECT * FROM ventas;
SELECT * FROM detalleVentas;


#Solicitud para traer el nombre del producto junto con su categoría
SELECT nombre_producto, categoria
FROM productos JOIN categoria on productos.categoria_id = categoria.categoria_id;

#Solicitud para traer el nombre del producto, junto con el id del producto y el id del proveedor.
SELECT nombre_producto, productosProveedores.productos_id, proveedores_id
FROM productos JOIN productosProveedores on productos.productos_id = productosProveedores.productos_id;

#Muestra el total de todo lo vendido hasta la fecha.
SELECT SUM(monto_total)
FROM ventas;


#Muestra todo lo vendido en el año 2022
SELECT SUM(monto_total)
FROM ventas
WHERE fecha_venta like '%2022%';

#Muestra todo lo vendido en el años 2023
SELECT SUM(monto_total)
FROM ventas
WHERE fecha_venta like '%2023%';

#Muestra la cantidad de productos vendidos en total
SELECT SUM(cantidad_productos)
FROM detalleVentas;

#Muestra las unidades vendidas por cada producto
SELECT nombre_producto, SUM(detalleVentas.cantidad_productos) AS unidades_vendidas FROM detalleVentas
LEFT JOIN productos ON productos.productos_id = detalleVentas.productos_id
GROUP BY productos.productos_id;

#Muestra cuánto dinero representó la venta de cada producto
SELECT nombre_producto, SUM(cantidad_productos*precio_producto) AS ventas_productos FROM detalleVentas
LEFT JOIN productos on productos.productos_id = detalleVentas.productos_id
GROUP BY productos.productos_id;









