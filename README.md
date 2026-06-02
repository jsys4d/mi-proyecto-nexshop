\# NexShop Group S.A. — Base de Datos



\*\*Alumno:\*\* Juan Fernandez Frances

\*\*Modulo:\*\* Bases de Datos — CodeArts

\*\*Nivel:\*\* Intermedio-Avanzado



\## Descripcion del proyecto



Base de datos relacional completa para NexShop Group S.A., empresa de distribucion y venta al por menor con tienda online (nexshop.es) y tres tiendas fisicas en Valencia, Madrid y Barcelona.



\## Instrucciones de importacion



SOURCE sql/schema.sql;

SOURCE sql/datos.sql;

SOURCE consultas/consultas.sql;



\## Tablas principales



sede - Tiendas fisicas y almacen central

empleado - 47 empleados asignados a sedes

producto - +2.000 referencias con jerarquia categoria/subcategoria

cliente - Clientes registrados y anonimos

pedido\_online - Pedidos web con multiples envios parciales

ticket\_venta - Ventas presenciales en tienda fisica

stock\_ubicacion - Stock por producto y sede

puntos\_movimiento - Historico del programa de fidelizacion

