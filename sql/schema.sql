-- ============================================================
--  NexShop Group S.A. — schema.sql
--  Base de datos relacional completa
--  Elaborado por: Juan Fernandez Frances
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS nexshop;
CREATE DATABASE nexshop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE nexshop;

CREATE TABLE sede (
    id_sede       INT AUTO_INCREMENT PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    tipo          ENUM('tienda','almacen') NOT NULL,
    ciudad        VARCHAR(100) NOT NULL,
    direccion     VARCHAR(200)
);

CREATE TABLE empleado (
    id_empleado         INT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    apellidos           VARCHAR(150) NOT NULL,
    dni                 VARCHAR(9)   NOT NULL UNIQUE,
    email_corporativo   VARCHAR(150) NOT NULL UNIQUE,
    fecha_incorporacion DATE         NOT NULL,
    id_sede             INT          NOT NULL,
    CONSTRAINT fk_emp_sede FOREIGN KEY (id_sede) REFERENCES sede(id_sede)
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL UNIQUE,
    descripcion  TEXT
);

CREATE TABLE subcategoria (
    id_subcategoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    id_categoria    INT NOT NULL,
    CONSTRAINT fk_sub_cat FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE producto (
    id_producto     INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    referencia      VARCHAR(50)  NOT NULL UNIQUE,
    pvp_actual      DECIMAL(10,2) NOT NULL CHECK (pvp_actual >= 0),
    id_subcategoria INT NOT NULL,
    CONSTRAINT fk_prod_sub FOREIGN KEY (id_subcategoria) REFERENCES subcategoria(id_subcategoria)
);

CREATE TABLE historial_pvp (
    id_historial_pvp INT AUTO_INCREMENT PRIMARY KEY,
    id_producto      INT           NOT NULL,
    pvp              DECIMAL(10,2) NOT NULL CHECK (pvp >= 0),
    fecha_inicio     DATE          NOT NULL,
    fecha_fin        DATE,
    CONSTRAINT fk_hpvp_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE promocion (
    id_promocion         INT AUTO_INCREMENT PRIMARY KEY,
    nombre               VARCHAR(150) NOT NULL,
    descuento_porcentaje DECIMAL(5,2) NOT NULL CHECK (descuento_porcentaje > 0 AND descuento_porcentaje <= 100),
    fecha_inicio         DATE NOT NULL,
    fecha_fin            DATE NOT NULL,
    CONSTRAINT chk_promo_fechas CHECK (fecha_fin >= fecha_inicio)
);

CREATE TABLE promocion_producto (
    id_promocion INT NOT NULL,
    id_producto  INT NOT NULL,
    PRIMARY KEY (id_promocion, id_producto),
    CONSTRAINT fk_pp_promo FOREIGN KEY (id_promocion) REFERENCES promocion(id_promocion),
    CONSTRAINT fk_pp_prod  FOREIGN KEY (id_producto)  REFERENCES producto(id_producto)
);

CREATE TABLE proveedor (
    id_proveedor    INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(150) NOT NULL,
    cif             VARCHAR(15)  NOT NULL UNIQUE,
    telefono        VARCHAR(20),
    email           VARCHAR(150),
    id_empleado_rep INT NOT NULL,
    CONSTRAINT fk_prov_emp FOREIGN KEY (id_empleado_rep) REFERENCES empleado(id_empleado)
);

CREATE TABLE producto_proveedor (
    id_prod_prov       INT AUTO_INCREMENT PRIMARY KEY,
    id_producto        INT           NOT NULL,
    id_proveedor       INT           NOT NULL,
    precio_coste       DECIMAL(10,2) NOT NULL CHECK (precio_coste >= 0),
    plazo_entrega_dias INT           NOT NULL CHECK (plazo_entrega_dias > 0),
    fecha_inicio       DATE          NOT NULL,
    fecha_fin          DATE,
    CONSTRAINT fk_prodprov_prod FOREIGN KEY (id_producto)  REFERENCES producto(id_producto),
    CONSTRAINT fk_prodprov_prov FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

CREATE TABLE stock_ubicacion (
    id_producto INT NOT NULL,
    id_sede     INT NOT NULL,
    cantidad    INT NOT NULL DEFAULT 0 CHECK (cantidad >= 0),
    PRIMARY KEY (id_producto, id_sede),
    CONSTRAINT fk_stock_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_stock_sede FOREIGN KEY (id_sede)     REFERENCES sede(id_sede)
);

CREATE TABLE cliente (
    id_cliente            INT AUTO_INCREMENT PRIMARY KEY,
    nombre                VARCHAR(100),
    apellidos             VARCHAR(150),
    email                 VARCHAR(150) UNIQUE,
    password_hash         VARCHAR(255),
    fecha_nacimiento      DATE,
    es_anonimo            TINYINT(1) NOT NULL DEFAULT 0,
    id_cliente_registrado INT,
    CONSTRAINT fk_cli_cli FOREIGN KEY (id_cliente_registrado) REFERENCES cliente(id_cliente)
);

CREATE TABLE direccion_cliente (
    id_direccion  INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente    INT  NOT NULL,
    tipo          ENUM('domicilio','trabajo','otra') NOT NULL DEFAULT 'domicilio',
    calle         VARCHAR(200) NOT NULL,
    numero        VARCHAR(10)  NOT NULL,
    piso          VARCHAR(20),
    codigo_postal VARCHAR(10)  NOT NULL,
    ciudad        VARCHAR(100) NOT NULL,
    pais          VARCHAR(100) NOT NULL DEFAULT 'España',
    CONSTRAINT fk_dir_cli FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE pedido_online (
    id_pedido                  INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente                 INT           NOT NULL,
    id_direccion_entrega       INT           NOT NULL,
    fecha_pedido               DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado                     ENUM('pendiente','en_proceso','enviado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
    total                      DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    puntos_descuento_aplicados INT NOT NULL DEFAULT 0 CHECK (puntos_descuento_aplicados >= 0),
    CONSTRAINT fk_ped_cli FOREIGN KEY (id_cliente)           REFERENCES cliente(id_cliente),
    CONSTRAINT fk_ped_dir FOREIGN KEY (id_direccion_entrega) REFERENCES direccion_cliente(id_direccion)
);

CREATE TABLE linea_pedido (
    id_linea_pedido    INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido          INT           NOT NULL,
    id_producto        INT           NOT NULL,
    cantidad           INT           NOT NULL CHECK (cantidad > 0),
    pvp_unitario       DECIMAL(10,2) NOT NULL CHECK (pvp_unitario >= 0),
    descuento_aplicado DECIMAL(5,2)  NOT NULL DEFAULT 0 CHECK (descuento_aplicado >= 0 AND descuento_aplicado <= 100),
    CONSTRAINT fk_lp_ped  FOREIGN KEY (id_pedido)   REFERENCES pedido_online(id_pedido),
    CONSTRAINT fk_lp_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE envio (
    id_envio               INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido              INT          NOT NULL,
    id_sede_origen         INT          NOT NULL,
    numero_seguimiento     VARCHAR(100) NOT NULL UNIQUE,
    transportista          VARCHAR(100) NOT NULL,
    fecha_estimada_entrega DATE         NOT NULL,
    fecha_entrega_real     DATE,
    estado                 ENUM('preparando','en_transito','entregado','recogida') NOT NULL DEFAULT 'preparando',
    CONSTRAINT fk_env_ped  FOREIGN KEY (id_pedido)      REFERENCES pedido_online(id_pedido),
    CONSTRAINT fk_env_sede FOREIGN KEY (id_sede_origen) REFERENCES sede(id_sede)
);

CREATE TABLE linea_envio (
    id_envio         INT NOT NULL,
    id_linea_pedido  INT NOT NULL,
    cantidad_enviada INT NOT NULL CHECK (cantidad_enviada > 0),
    PRIMARY KEY (id_envio, id_linea_pedido),
    CONSTRAINT fk_le_env FOREIGN KEY (id_envio)        REFERENCES envio(id_envio),
    CONSTRAINT fk_le_lp  FOREIGN KEY (id_linea_pedido) REFERENCES linea_pedido(id_linea_pedido)
);

CREATE TABLE ticket_venta (
    id_ticket_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_sede         INT           NOT NULL,
    id_empleado     INT           NOT NULL,
    id_cliente      INT,
    fecha_venta     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total           DECIMAL(10,2) NOT NULL CHECK (total >= 0),
    CONSTRAINT fk_tv_sede FOREIGN KEY (id_sede)     REFERENCES sede(id_sede),
    CONSTRAINT fk_tv_emp  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    CONSTRAINT fk_tv_cli  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente)
);

CREATE TABLE linea_ticket_venta (
    id_linea_ticket INT AUTO_INCREMENT PRIMARY KEY,
    id_ticket_venta INT           NOT NULL,
    id_producto     INT           NOT NULL,
    cantidad        INT           NOT NULL CHECK (cantidad > 0),
    pvp_unitario    DECIMAL(10,2) NOT NULL CHECK (pvp_unitario >= 0),
    CONSTRAINT fk_ltv_tv   FOREIGN KEY (id_ticket_venta) REFERENCES ticket_venta(id_ticket_venta),
    CONSTRAINT fk_ltv_prod FOREIGN KEY (id_producto)     REFERENCES producto(id_producto)
);

CREATE TABLE devolucion_tienda (
    id_devolucion    INT AUTO_INCREMENT PRIMARY KEY,
    id_ticket_venta  INT  NOT NULL,
    id_producto      INT  NOT NULL,
    cantidad         INT  NOT NULL CHECK (cantidad > 0),
    fecha_devolucion DATE NOT NULL,
    motivo           TEXT,
    CONSTRAINT fk_dev_tv   FOREIGN KEY (id_ticket_venta) REFERENCES ticket_venta(id_ticket_venta),
    CONSTRAINT fk_dev_prod FOREIGN KEY (id_producto)     REFERENCES producto(id_producto)
);

CREATE TABLE transferencia_stock (
    id_transferencia        INT AUTO_INCREMENT PRIMARY KEY,
    id_producto             INT      NOT NULL,
    id_sede_origen          INT      NOT NULL,
    id_sede_destino         INT      NOT NULL,
    cantidad                INT      NOT NULL CHECK (cantidad > 0),
    fecha                   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_empleado_autorizador INT      NOT NULL,
    CONSTRAINT fk_ts_prod   FOREIGN KEY (id_producto)             REFERENCES producto(id_producto),
    CONSTRAINT fk_ts_origen FOREIGN KEY (id_sede_origen)          REFERENCES sede(id_sede),
    CONSTRAINT fk_ts_dest   FOREIGN KEY (id_sede_destino)         REFERENCES sede(id_sede),
    CONSTRAINT fk_ts_emp    FOREIGN KEY (id_empleado_autorizador) REFERENCES empleado(id_empleado),
    CONSTRAINT chk_ts_sedes CHECK (id_sede_origen <> id_sede_destino)
);

CREATE TABLE ticket_incidencia (
    id_ticket       INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT,
    id_pedido       INT,
    id_agente       INT NOT NULL,
    asunto          VARCHAR(255) NOT NULL,
    descripcion     TEXT         NOT NULL,
    fecha_apertura  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado          ENUM('abierto','en_gestion','resuelto') NOT NULL DEFAULT 'abierto',
    fecha_cierre    DATETIME,
    nota_resolucion TEXT,
    CONSTRAINT fk_ti_cli   FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_ti_ped   FOREIGN KEY (id_pedido)  REFERENCES pedido_online(id_pedido),
    CONSTRAINT fk_ti_agent FOREIGN KEY (id_agente)  REFERENCES empleado(id_empleado)
);

CREATE TABLE valoracion (
    id_valoracion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente    INT        NOT NULL,
    id_producto   INT        NOT NULL,
    puntuacion    TINYINT    NOT NULL CHECK (puntuacion >= 1 AND puntuacion <= 5),
    comentario    TEXT,
    fecha         DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    verificada    TINYINT(1) NOT NULL DEFAULT 0,
    UNIQUE KEY uq_val_cli_prod (id_cliente, id_producto),
    CONSTRAINT fk_val_cli  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente),
    CONSTRAINT fk_val_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE puntos_movimiento (
    id_movimiento   INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT      NOT NULL,
    id_pedido       INT,
    tipo            ENUM('ganado','canjeado') NOT NULL,
    cantidad_puntos INT      NOT NULL CHECK (cantidad_puntos > 0),
    fecha           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pm_cli FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_pm_ped FOREIGN KEY (id_pedido)  REFERENCES pedido_online(id_pedido)
);

SET FOREIGN_KEY_CHECKS = 1;