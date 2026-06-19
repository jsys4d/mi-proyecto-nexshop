# 🛒 NexShop Group S.A. — Base de Datos Relacional

Base de datos relacional completa para NexShop Group S.A., empresa de distribución y venta al por menor con tienda online y tres tiendas físicas.

> Proyecto desarrollado en el módulo de Bases de Datos — CodeArts Solutions

## 🏗️ Stack Tecnológico

![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Relacional-orange)

## 🗂️ Estructura de la base de datos

| Tabla | Descripción |
|---|---|
| `sede` | Tiendas físicas y almacén central (Valencia, Madrid, Barcelona) |
| `empleado` | 47 empleados asignados a sedes |
| `producto` | +2.000 referencias con jerarquía categoría/subcategoría |
| `cliente` | Clientes registrados y anónimos |
| `pedido_online` | Pedidos web con múltiples envíos parciales |
| `ticket_venta` | Ventas presenciales en tienda física |
| `stock_ubicacion` | Stock por producto y sede |
| `puntos_movimiento` | Histórico del programa de fidelización |

## 🚀 Importación

```sql
SOURCE sql/schema.sql;
SOURCE sql/datos.sql;
SOURCE consultas/consultas.sql;
```

## 📊 Características

- Modelo relacional normalizado (3FN)
- Gestión de stock multi-sede
- Sistema de fidelización con puntos
- Pedidos online con envíos parciales
- Ventas presenciales y online integradas

---
*Desarrollado durante prácticas FCT en CodeArts Solutions — CESUR Zaragoza Junio-2026*
