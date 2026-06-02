USE nexshop;

-- SEDES
INSERT INTO sede (nombre, tipo, ciudad, direccion) VALUES
('Almacén Central Valencia', 'almacen', 'Valencia', 'Polígono Industrial Nord, Nave 12'),
('Tienda Valencia',          'tienda',  'Valencia', 'Calle Colón 45, Local 2'),
('Tienda Madrid',            'tienda',  'Madrid',   'Gran Vía 88, Local 3'),
('Tienda Barcelona',         'tienda',  'Barcelona','Passeig de Gràcia 120, Bajo');

-- EMPLEADOS
INSERT INTO empleado (nombre, apellidos, dni, email_corporativo, fecha_incorporacion, id_sede) VALUES
('Ana',    'Ferrer López',    '12345678A', 'a.ferrer@nexshop.es',    '2015-06-01', 1),
('David',  'Cano Martínez',   '23456789B', 'd.cano@nexshop.es',      '2016-03-15', 1),
('Laura',  'Pons Giménez',    '34567890C', 'l.pons@nexshop.es',      '2017-09-01', 1),
('Sergio', 'Blanco Torres',   '45678901D', 's.blanco@nexshop.es',    '2015-06-01', 1),
('Carlos', 'Ruiz Sánchez',    '56789012E', 'c.ruiz@nexshop.es',      '2018-01-10', 2),
('Marta',  'García Navarro',  '67890123F', 'm.garcia@nexshop.es',    '2019-04-20', 2),
('Pablo',  'Jiménez Ortega',  '78901234G', 'p.jimenez@nexshop.es',   '2020-07-01', 3),
('Elena',  'Morales Vidal',   '89012345H', 'e.morales@nexshop.es',   '2021-02-14', 3),
('Raúl',   'Castro Llorente', '90123456I', 'r.castro@nexshop.es',    '2018-11-05', 4),
('Sofía',  'Ibáñez Pereira',  '01234567J', 's.ibanez@nexshop.es',    '2022-03-01', 4);

-- CATEGORÍAS
INSERT INTO categoria (nombre, descripcion) VALUES
('Informática',   'Ordenadores, periféricos y accesorios'),
('Telefonía',     'Smartphones, tablets y accesorios'),
('Audio y Vídeo', 'Auriculares, altavoces y pantallas'),
('Hogar Digital', 'Domótica y electrodomésticos inteligentes');

-- SUBCATEGORÍAS
INSERT INTO subcategoria (nombre, id_categoria) VALUES
('Portátiles Gaming',     1),
('Portátiles Oficina',    1),
('Portátiles Ultraligero',1),
('Sobremesa',             1),
('Periféricos',           1),
('Smartphones Gama Alta', 2),
('Smartphones Gama Media',2),
('Tablets',               2),
('Auriculares',           3),
('Altavoces',             3),
('Televisores',           3),
('Domótica',              4);

-- PRODUCTOS
INSERT INTO producto (nombre, descripcion, referencia, pvp_actual, id_subcategoria) VALUES
('ASUS ROG Strix G16',       'Portátil gaming Intel i9 RTX 4070', 'PORT-001', 1499.99, 1),
('Lenovo IdeaPad Slim 5',    'Portátil oficina AMD Ryzen 5',      'PORT-002',  749.99, 2),
('MacBook Air M3',           'Ultraligero Apple 15" M3',          'PORT-003', 1399.00, 3),
('Dell XPS 15',              'Portátil premium OLED 4K',          'PORT-004', 1899.99, 3),
('Logitech MX Keys',         'Teclado inalámbrico premium',       'PERI-001',  109.99, 5),
('Samsung Galaxy S24 Ultra', 'Smartphone 200MP titanio',          'TELF-001', 1299.99, 6),
('Xiaomi Redmi Note 13 Pro', 'Smartphone 200MP gama media',       'TELF-002',  349.99, 7),
('iPad Air M2',              'Tablet Apple 11" M2',               'TABL-001',  749.00, 8),
('Sony WH-1000XM5',          'Auriculares noise cancelling',      'AUDI-001',  349.99, 9),
('JBL Charge 5',             'Altavoz portátil resistente agua',  'AUDI-002',  179.99,10),
('LG OLED C3 55"',           'TV OLED 4K 120Hz HDMI 2.1',        'TELE-001', 1199.99,11),
('Philips Hue Starter Kit',  'Kit bombillas inteligentes x3',     'DOMO-001',   89.99,12);

-- HISTORIAL PVP
INSERT INTO historial_pvp (id_producto, pvp, fecha_inicio, fecha_fin) VALUES
(1, 1699.99, '2023-01-01', '2023-11-30'),
(1, 1499.99, '2023-12-01', NULL),
(6, 1399.99, '2023-01-01', '2023-09-30'),
(6, 1299.99, '2023-10-01', NULL),
(11,1399.99, '2023-01-01', '2023-06-30'),
(11,1199.99, '2023-07-01', NULL);

-- PROMOCIONES
INSERT INTO promocion (nombre, descuento_porcentaje, fecha_inicio, fecha_fin) VALUES
('Black Friday 2023',     15.00, '2023-11-24', '2023-11-27'),
('Rebajas Enero 2024',    10.00, '2024-01-07', '2024-01-31'),
('Promo Verano 2024',     20.00, '2024-07-01', '2024-08-31'),
('Flash Sale Portátiles',  8.00, '2024-03-15', '2024-03-17');

INSERT INTO promocion_producto (id_promocion, id_producto) VALUES
(1,1),(1,6),(1,11),
(2,2),(2,7),(2,10),
(3,9),(3,10),(3,12),
(4,1),(4,2),(4,3);

-- PROVEEDORES
INSERT INTO proveedor (nombre, cif, telefono, email, id_empleado_rep) VALUES
('TechDistrib SL',     'B12345678', '963001001', 'ventas@techdistrib.es',  2),
('Iberian Components', 'A23456789', '916002002', 'comercial@iberian.es',   2),
('GlobalTech Import',  'B34567890', '932003003', 'imports@globaltech.com', 1);

INSERT INTO producto_proveedor (id_producto, id_proveedor, precio_coste, plazo_entrega_dias, fecha_inicio, fecha_fin) VALUES
(1, 1, 1100.00, 7,  '2023-01-01', '2023-12-31'),
(1, 1, 1050.00, 5,  '2024-01-01', NULL),
(1, 2,  980.00, 10, '2023-06-01', NULL),
(6, 1,  900.00, 7,  '2023-01-01', NULL),
(6, 3,  880.00, 12, '2024-01-01', NULL),
(11,2,  750.00, 14, '2023-01-01', NULL),
(9, 3,  200.00, 10, '2023-01-01', NULL),
(3, 3, 1000.00, 7,  '2023-01-01', NULL);

-- STOCK POR UBICACIÓN
INSERT INTO stock_ubicacion (id_producto, id_sede, cantidad) VALUES
(1,1,50),(1,2,8),(1,3,5),(1,4,3),
(2,1,80),(2,2,12),(2,3,10),(2,4,7),
(3,1,30),(3,2,4),(3,3,6),(3,4,4),
(4,1,20),(4,2,3),(4,3,2),(4,4,1),
(5,1,150),(5,2,20),(5,3,18),(5,4,15),
(6,1,60),(6,2,10),(6,3,8),(6,4,5),
(7,1,100),(7,2,15),(7,3,12),(7,4,10),
(8,1,40),(8,2,6),(8,3,5),(8,4,4),
(9,1,70),(9,2,12),(9,3,10),(9,4,8),
(10,1,90),(10,2,14),(10,3,12),(10,4,9),
(11,1,25),(11,2,4),(11,3,3),(11,4,2),
(12,1,120),(12,2,18),(12,3,15),(12,4,12);

-- CLIENTES
INSERT INTO cliente (nombre, apellidos, email, password_hash, fecha_nacimiento, es_anonimo, id_cliente_registrado) VALUES
('Javier',   'López Muñoz',    'javier.lopez@gmail.com', '$2y$10$abc1', '1990-03-15', 0, NULL),
('Carmen',   'Martín García',  'carmen.martin@yahoo.es', '$2y$10$abc2', '1985-07-22', 0, NULL),
('Miguel',   'Fernández Ruiz', 'miguel.f@hotmail.com',   '$2y$10$abc3', '1992-11-08', 0, NULL),
('Lucía',    'Sánchez Pérez',  'lucia.sp@gmail.com',     '$2y$10$abc4', '1995-04-30', 0, NULL),
('Fernando', 'Torres Gil',     'fernando.t@outlook.com', '$2y$10$abc5', '1988-09-14', 0, NULL),
(NULL, NULL, NULL, NULL, NULL, 1, NULL),
(NULL, NULL, NULL, NULL, NULL, 1, NULL),
(NULL, NULL, NULL, NULL, NULL, 1, 1);

-- DIRECCIONES
INSERT INTO direccion_cliente (id_cliente, tipo, calle, numero, piso, codigo_postal, ciudad, pais) VALUES
(1,'domicilio','Calle Mayor',    '10','3B','46001','Valencia', 'España'),
(1,'trabajo',  'Av. del Puerto', '23','',  '46021','Valencia', 'España'),
(2,'domicilio','Calle Gran Vía', '45','2A','28013','Madrid',   'España'),
(3,'domicilio','Calle Diagonal', '88','5C','08029','Barcelona','España'),
(4,'domicilio','Calle Sierpes',  '12','1D','41004','Sevilla',  'España'),
(5,'domicilio','Calle Real',     '77','',  '15001','A Coruña', 'España'),
(5,'otra',     'Calle Cervantes','3', 'Bajo','15004','A Coruña','España');

-- PEDIDOS ONLINE
INSERT INTO pedido_online (id_cliente, id_direccion_entrega, fecha_pedido, estado, total, puntos_descuento_aplicados) VALUES
(1, 1, '2024-01-15 10:30:00', 'entregado',  1499.99, 0),
(2, 3, '2024-02-20 16:45:00', 'entregado',  1649.98, 500),
(3, 4, '2024-03-05 09:15:00', 'enviado',     349.99, 0),
(4, 5, '2024-04-10 14:00:00', 'en_proceso',  179.99, 0),
(1, 2, '2024-05-01 11:00:00', 'pendiente',  1399.00, 1000),
(5, 6, '2024-05-15 18:30:00', 'cancelado',   749.99, 0);

-- LÍNEAS DE PEDIDO
INSERT INTO linea_pedido (id_pedido, id_producto, cantidad, pvp_unitario, descuento_aplicado) VALUES
(1, 1, 1, 1499.99, 0.00),
(2, 6, 1, 1299.99, 0.00),
(2, 5, 1,  109.99, 0.00),
(3, 7, 1,  349.99, 0.00),
(4,10, 1,  179.99, 0.00),
(5, 3, 1, 1399.00, 0.00),
(6, 2, 1,  749.99, 0.00);

-- ENVÍOS
INSERT INTO envio (id_pedido, id_sede_origen, numero_seguimiento, transportista, fecha_estimada_entrega, fecha_entrega_real, estado) VALUES
(1, 1, 'TRK-2024-001', 'SEUR',    '2024-01-18', '2024-01-17', 'entregado'),
(2, 1, 'TRK-2024-002', 'MRW',     '2024-02-24', '2024-02-23', 'entregado'),
(3, 1, 'TRK-2024-003', 'DHL',     '2024-03-09', NULL,         'en_transito'),
(4, 2, 'TRK-2024-004', 'Correos', '2024-04-15', NULL,         'preparando'),
(5, 1, 'TRK-2024-005', 'SEUR',    '2024-05-06', NULL,         'preparando');

INSERT INTO linea_envio (id_envio, id_linea_pedido, cantidad_enviada) VALUES
(1,1,1),(2,2,1),(2,3,1),(3,4,1),(4,5,1),(5,6,1);

-- TICKETS DE VENTA PRESENCIAL
INSERT INTO ticket_venta (id_sede, id_empleado, id_cliente, fecha_venta, total) VALUES
(2, 5, 6,    '2024-01-10 11:00:00',  179.99),
(2, 6, NULL, '2024-02-14 16:00:00',  349.99),
(3, 7, 7,    '2024-03-01 12:30:00',  109.99),
(4, 9, 8,    '2024-04-20 10:00:00', 1199.99);

INSERT INTO linea_ticket_venta (id_ticket_venta, id_producto, cantidad, pvp_unitario) VALUES
(1,10,1,179.99),
(2, 9,1,349.99),
(3, 5,1,109.99),
(4,11,1,1199.99);

-- DEVOLUCIONES
INSERT INTO devolucion_tienda (id_ticket_venta, id_producto, cantidad, fecha_devolucion, motivo) VALUES
(2, 9, 1, '2024-02-20', 'Producto defectuoso: cancelación de ruido no funciona'),
(3, 5, 1, '2024-03-08', 'Cliente arrepentido, dentro del plazo de devolución');

-- TRANSFERENCIAS DE STOCK
INSERT INTO transferencia_stock (id_producto, id_sede_origen, id_sede_destino, cantidad, fecha, id_empleado_autorizador) VALUES
(1, 1, 2, 5, '2024-02-01 08:00:00', 2),
(6, 1, 3, 3, '2024-02-15 09:30:00', 2),
(11,1, 4, 2, '2024-03-10 10:00:00', 2),
(9, 1, 3, 5, '2024-04-05 08:45:00', 2),
(7, 2, 3, 4, '2024-04-20 11:00:00', 5);

-- TICKETS DE INCIDENCIA
INSERT INTO ticket_incidencia (id_cliente, id_pedido, id_agente, asunto, descripcion, fecha_apertura, estado, fecha_cierre, nota_resolucion) VALUES
(1, 1, 3, 'Retraso en entrega',   'El pedido no llegó en la fecha indicada',        '2024-01-19 09:00:00', 'resuelto',    '2024-01-19 11:00:00', 'Se confirmó entrega el 17/01.'),
(2, 2, 3, 'Producto incorrecto',  'Recibí el móvil en color negro en lugar de titanio', '2024-02-25 10:30:00', 'resuelto', '2024-03-02 12:00:00', 'Se gestionó devolución y reenvío.'),
(3, 3, 3, 'Seguimiento envío',    '¿Cuándo llegará mi pedido?',                     '2024-03-07 16:00:00', 'en_gestion', NULL,                  NULL),
(NULL,NULL,3,'Consulta general',  '¿Tenéis tienda en Sevilla?',                     '2024-04-01 14:00:00', 'resuelto',   '2024-04-01 14:15:00', 'Tienda más cercana en Madrid.');

-- VALORACIONES
INSERT INTO valoracion (id_cliente, id_producto, puntuacion, comentario, fecha, verificada) VALUES
(1, 1, 5, 'Portátil gaming increíble, corre todo sin problemas.',     '2024-01-25 18:00:00', 1),
(2, 6, 4, 'Muy buen móvil, la cámara es espectacular.',               '2024-03-01 10:00:00', 1),
(2, 5, 5, 'El mejor teclado que he usado. Silencioso y preciso.',      '2024-03-01 10:15:00', 1),
(3, 7, 4, 'Buena relación calidad-precio para gama media.',            '2024-03-20 09:00:00', 1),
(4, 9, 3, 'Bien pero el cable de carga se rompe pronto.',              '2023-06-10 12:00:00', 0);

-- PUNTOS DE FIDELIZACIÓN
INSERT INTO puntos_movimiento (id_cliente, id_pedido, tipo, cantidad_puntos, fecha) VALUES
(1, 1,    'ganado',   14999, '2024-01-15 10:30:00'),
(2, 2,    'ganado',   16499, '2024-02-20 16:45:00'),
(2, NULL, 'canjeado',   500, '2024-02-20 16:45:00'),
(3, 3,    'ganado',    3499, '2024-03-05 09:15:00'),
(4, 4,    'ganado',    1799, '2024-04-10 14:00:00'),
(1, 5,    'canjeado', 10000, '2024-05-01 11:00:00'),
(1, 5,    'ganado',   13990, '2024-05-01 11:00:00');