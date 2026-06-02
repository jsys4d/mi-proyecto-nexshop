USE nexshop;

-- Q1: Todos los empleados del sistema
SELECT * FROM empleado;

-- Q2: Nombre, apellidos y email de clientes registrados
SELECT nombre, apellidos, email
FROM cliente
WHERE es_anonimo = 0;

-- Q3: Pedidos con estado 'pendiente'
SELECT id_pedido, id_cliente, fecha_pedido, total
FROM pedido_online
WHERE estado = 'pendiente';

-- Q4: Productos cuyo nombre contenga palabras clave de portátil
SELECT id_producto, nombre, pvp_actual
FROM producto
WHERE nombre LIKE '%Portátil%'
   OR nombre LIKE '%Air%'
   OR nombre LIKE '%IdeaPad%';

-- Q5: Clientes registrados cuyo nombre empiece por 'C'
SELECT nombre, apellidos, email
FROM cliente
WHERE nombre LIKE 'C%'
  AND es_anonimo = 0;

-- Q6: Pedidos realizados entre el 1 enero y 30 abril 2024
SELECT id_pedido, id_cliente, fecha_pedido, estado, total
FROM pedido_online
WHERE fecha_pedido BETWEEN '2024-01-01 00:00:00' AND '2024-04-30 23:59:59';

-- Q7: Productos con PVP entre 100 y 800 euros
SELECT nombre, referencia, pvp_actual
FROM producto
WHERE pvp_actual BETWEEN 100 AND 800
ORDER BY pvp_actual;

-- Q8: Líneas de pedido con cantidad mayor que 0 ordenadas por cantidad
SELECT lp.id_linea_pedido, p.nombre, lp.cantidad, lp.pvp_unitario
FROM linea_pedido lp
JOIN producto p ON p.id_producto = lp.id_producto
WHERE lp.cantidad > 0
ORDER BY lp.cantidad DESC;

-- Q9: Pedidos ordenados del más antiguo al más reciente (ASC)
SELECT id_pedido, id_cliente, fecha_pedido, estado, total
FROM pedido_online
ORDER BY fecha_pedido ASC;

-- Q10: Productos ordenados de mayor a menor PVP (DESC)
SELECT nombre, referencia, pvp_actual
FROM producto
ORDER BY pvp_actual DESC;

-- Q11: Clientes registrados ordenados alfabéticamente por apellidos
SELECT nombre, apellidos, email
FROM cliente
WHERE es_anonimo = 0
ORDER BY apellidos ASC, nombre ASC;

-- Q12: Cambiar estado del pedido 3 a 'entregado'
UPDATE pedido_online
SET estado = 'entregado'
WHERE id_pedido = 3;

-- Q13: Actualizar email corporativo de empleado por su DNI
UPDATE empleado
SET email_corporativo = 'c.ruiz.nuevo@nexshop.es'
WHERE dni = '56789012E';

-- Q14: JOIN clientes con sus pedidos online
SELECT
    c.nombre,
    c.apellidos,
    p.id_pedido,
    p.fecha_pedido,
    p.estado,
    p.total
FROM cliente c
JOIN pedido_online p ON p.id_cliente = c.id_cliente
WHERE c.es_anonimo = 0
ORDER BY c.apellidos, p.fecha_pedido;