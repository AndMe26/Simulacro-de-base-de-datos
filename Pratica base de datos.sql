drop database test_simulacro;
create database test_simulacro;
use test_simulacro;

create table ciudades(
id int primary key auto_increment,
nombre varchar(50) not null,
departamento varchar(50)

);

create table categorias(
id int primary key auto_increment,
nombre varchar(50) not null unique,
descripcion text
);

create table proveedores(
id int primary key auto_increment,
nombre varchar(50) not null,
nit varchar(20) unique not null,
telefono varchar(20),
email varchar(50),
ciudad_id int,
foreign key (ciudad_id) references ciudades(id)
);

create table bodegas (
id int primary key auto_increment,
nombre varchar(50) not null,
direccion varchar(150),
responsable varchar(40) not null,
ciudad_id int not null,
foreign key (ciudad_id) references ciudades(id)
);


create table productos (
id int primary key auto_increment,
nombre varchar(60) not null,
descripcion text,
precio_unitario numeric(12,2) not null check (precio_unitario > 0),
unidad_medida varchar(50) not null,
stock int default 0,
categorias_id int not null,
foreign key (categorias_id) references categorias(id)
);


create table compras (
id int primary key auto_increment,
fecha date not null,
proveedor_id int,
foreign key (proveedor_id) references proveedores(id) ,
valor_total numeric(12,2) 
);

create table detalle_compra(
id int primary key auto_increment,
cantidad int not null,
precio_unitario numeric(12,2) not null check (precio_unitario > 0),
compra_id int,
producto_id int,
foreign key (compra_id) references compras(id),
foreign key (producto_id) references productos(id)
);

create table movimiento_inv(
id int primary key auto_increment,
fecha_movimiento date not null,
tipo_movimiento varchar(20) not null,
cantidad int not null,
producto_id int,
bodega_id int,
foreign key (producto_id) references productos(id),
foreign key (bodega_id) references bodegas(id)
);

INSERT INTO ciudades (nombre, departamento)
VALUES 
('Bogotá', 'Cundinamarca'),
('Medellín', 'Antioquia'),
('Cali', 'Valle del Cauca'),
('Barranquilla', 'Atlántico'),
('Bucaramanga', 'Santander');

INSERT INTO categorias (nombre, descripcion)
VALUES 
('Ferretería', 'Herramientas y materiales de ferretería'),
('Plomería', 'Tuberías, válvulas y accesorios'),
('Pinturas', 'Pinturas y recubrimientos'),
('Metales', 'Perfiles y láminas metálicas'),
('Eléctrico', 'Materiales y equipos eléctricos'),
('Construcción', 'Materiales para obra y construcción');

insert into proveedores (nombre,nit,telefono,email,ciudad_id) 
values 
('Ferreteria Torres S.A.S.', '900123456-1', '3101234567','ferreteria.torres@gmail.com',1),
('Distribuidora Electronica Medellin','800987654-2','3209876543','dist_electronica@gmail.com' ,2),
('Plastiflex Cali Ltda','860456789-3','3154567890','plastiflex@cali.com',3),
('Suministros Ind. del Norte', '901234567-4','3057891234','suministros.norte@empresa.co',4),
('Tecno Partes Ltda.', '700345678-5','6014567890','tecnopartes.ltda@gmail.com',1),
('Metales y aleaciones s.a', '890654321-6','3168765432','metales@industriacol.com',5);

insert into bodegas (nombre,ciudad_id,direccion,responsable)
values 
('Bodega Central Bogotá',1,'Cra 30 # 15-40','Carlos Rodríguez'),
('Bodega Norte Barranquilla',4,'Calle 80 # 43-20','María Pérez'),
('Bodega Sur-Cali',3,'Av. Las Américas # 5-30','Andrés Gómez'),
('Bodega Medellín',2,'Cra 50 # 45-67','Luisa Martínez');

-- categoria_id: 1=Ferretería, 2=Electrónica, 3=Plomería, 4=Pinturas, 5=Metales, 6=Construcción
insert into productos (nombre,descripcion,precio_unitario,unidad_medida,stock,categorias_id)
values
('Tornillo hexagonal 1/2 pulgada','Tornillo metálico para uso estructural',1200,'Unidad',0,1),
('Tubo PVC 4 pulgadas','Tubo de PVC sanitario diámetro 4 pulgadas',8900,'Metro',0,2),
('Válvula de paso 1/2 pulgada','Válvula de paso en bronce 1/2"',15000,'Unidad',0,2),
('Pintura base agua blanca 1GL','Pintura caucho blanca',35000,'Galón',0,3),
('Perfil de aluminio 1x1','Perfil de aluminio cuadrado 1 pulgada',22000,'Metro',0,4),
('Interruptor sencillo','Interruptor eléctrico sencillo 110V',8500,'Unidad',0,5),
('Cemento gris 50kg','Cemento portland tipo I 50 kilos',28000,'Bulto',0,6);


insert into compras (fecha,proveedor_id,valor_total)
values
('2023-07-12',5,null),
('2023-08-25',4,990000),
('2023-10-04',1,1047899),
('2024-04-27',2,720900),
('2024-06-07',6,814000),
('2024-06-17', 5, 4968000),
('2023-09-02', 2, 1308300),
('2023-10-14', 4, 1174800),
('2023-03-29', 1, 2016000),
('2024-08-29', 4, 3857000);

insert into detalle_compra (compra_id,producto_id,cantidad,precio_unitario)
values
(1,7,184,8500),
(2,4,66,15000),
(3,7,136,8500),
(4,3,81,8900),
(5,6,37,22000);


INSERT INTO movimiento_inv (fecha_movimiento, tipo_movimiento, cantidad, producto_id, bodega_id) VALUES
('2023-07-12', 'Entrada', 170, 6, 2),
('2023-08-25', 'Entrada', 39, 3, 2),
('2023-10-04', 'Salida', 26, 6, 2),
('2024-04-27', 'Entrada', 42, 2, 3),
('2024-06-07', 'Entrada', 17, 5, 2),
('2024-06-17', 'Entrada', 138, 7, 1),
('2023-09-02', 'Entrada', 85, 2, 3),
('2023-10-14', 'Salida', 129, 2, 4),
('2023-03-29', 'Entrada', 59, 7, 2),
('2024-08-29', 'Salida', 61, 7, 3);

SELECT 
    p.nombre AS producto,
    c.nombre AS categoria,
    p.unidad_medida,
    p.stock
FROM productos p
JOIN categorias c ON p.categorias_id = c.id
ORDER BY p.stock ASC;

-- Stock por producto con categoría
SELECT productos.nombre, categorias.nombre, productos.unidad_medida, productos.stock
FROM productos
JOIN categorias ON productos.categorias_id = categorias.id
ORDER BY productos.stock ASC;

--  Movimientos por bodega discriminados por tipo
SELECT bodegas.nombre, movimiento_inv.tipo_movimiento, COUNT(*) AS total_movimientos
FROM movimiento_inv
JOIN bodegas ON movimiento_inv.bodega_id = bodegas.id
GROUP BY bodegas.nombre, movimiento_inv.tipo_movimiento
HAVING COUNT(*) > 5
ORDER BY total_movimientos DESC;

-- Total comprado por proveedor con ciudad
SELECT proveedores.nombre, ciudades.nombre, COUNT(compras.id), SUM(compras.valor_total)
FROM proveedores
LEFT JOIN compras ON proveedores.id = compras.proveedor_id
LEFT JOIN ciudades ON proveedores.ciudad_id = ciudades.id
GROUP BY proveedores.nombre, ciudades.nombre
ORDER BY SUM(compras.valor_total) DESC;

-- Producto más comprado por volumen
SELECT productos.nombre, SUM(detalle_compra.cantidad)
FROM detalle_compra
JOIN productos ON detalle_compra.producto_id = productos.id
GROUP BY productos.nombre
ORDER BY SUM(detalle_compra.cantidad) DESC
LIMIT 1;

-- Valor total del inventario por bodega
SELECT bodegas.nombre, bodegas.ciudad_id, SUM(movimiento_inv.cantidad * productos.precio_unitario)
FROM movimiento_inv
JOIN bodegas ON movimiento_inv.bodega_id = bodegas.id
JOIN productos ON movimiento_inv.producto_id = productos.id
GROUP BY bodegas.nombre, bodegas.ciudad_id
HAVING SUM(movimiento_inv.cantidad * productos.precio_unitario) > 500000
ORDER BY SUM(movimiento_inv.cantidad * productos.precio_unitario) DESC;

-- Proveedores con total comprado mayor al promedio
SELECT proveedores.nombre, SUM(compras.valor_total)
FROM proveedores
JOIN compras ON proveedores.id = compras.proveedor_id
GROUP BY proveedores.nombre
HAVING SUM(compras.valor_total) > (
    SELECT AVG(total) FROM (
        SELECT SUM(valor_total) AS total
        FROM compras
        GROUP BY proveedor_id
    ) AS sub
);

--  Categorías con precio promedio mayor a 10000
SELECT categorias.nombre, COUNT(productos.id), AVG(productos.precio_unitario)
FROM productos
JOIN categorias ON productos.categorias_id = categorias.id
GROUP BY categorias.nombre
HAVING AVG(productos.precio_unitario) > 10000
ORDER BY AVG(productos.precio_unitario) DESC;

-- 1. Actualizar email y nombre del proveedor con id = 2
UPDATE proveedores 
SET email = 'nuevo_email@distribuidora.com', 
    nombre = 'Distribuidora Electrónica Medellín' 
WHERE id = 2;

-- 2. Restar 10 unidades del stock del producto con id = 3
UPDATE productos 
SET stock = stock - 10 
WHERE id = 3 AND stock >= 10;

-- 3. Eliminar movimientos de tipo Salida antes del 2024
DELETE FROM movimiento_inv 
WHERE tipo_movimiento = 'Salida' 
AND fecha_movimiento < '2024-01-01';

-- 4. Eliminar proveedor con id = 3 solo si no tiene compras
DELETE FROM proveedores 
WHERE id = 3
AND id NOT IN (SELECT proveedor_id FROM compras);

-- Vista 35: Stock por producto reutilizable para reportes
CREATE VIEW vw_stock_por_producto AS
SELECT productos.nombre, categorias.nombre, productos.unidad_medida, productos.stock
FROM productos
JOIN categorias ON productos.categorias_id = categorias.id
ORDER BY productos.stock ASC;

-- Vista extra: Resumen de compras por proveedor
CREATE VIEW vw_compras_por_proveedor AS
SELECT proveedores.nombre, ciudades.nombre, COUNT(compras.id), SUM(compras.valor_total)
FROM proveedores
LEFT JOIN compras ON proveedores.id = compras.proveedor_id
LEFT JOIN ciudades ON proveedores.ciudad_id = ciudades.id
GROUP BY proveedores.nombre, ciudades.nombre;

SELECT * FROM vw_stock_por_producto;
SELECT * FROM vw_compras_por_proveedor;

START TRANSACTION;

-- Savepoint antes de insertar proveedor
SAVEPOINT sp_proveedor;

-- Insertar nuevo proveedor
INSERT INTO proveedores (nombre, nit, telefono, email, ciudad_id)
VALUES ('Metales del Pacífico Ltda', '950111222-3', '3001234567', 'metalesdelpacific@gmail.com', 3);

-- Savepoint antes de insertar producto
SAVEPOINT sp_producto;

-- Insertar producto asociado
-- Si ya existiera se haría ROLLBACK TO sp_producto
INSERT INTO productos (nombre, descripcion, precio_unitario, unidad_medida, stock, categorias_id)
VALUES ('Lámina de acero 2mm', 'Lámina de acero laminado en frío', 45000, 'Unidad', 0, 4);

-- Si todo salió bien confirmamos
COMMIT;

-- Deshacer solo el producto pero mantener el proveedor
ROLLBACK TO sp_producto;

-- O deshacer todo
ROLLBACK;

