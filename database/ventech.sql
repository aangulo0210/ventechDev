-- ============================================================
-- VenTech — Script inicial de base de datos
-- Motor: MySQL 8.x
-- Proyecto SENA Ficha 3186630
-- ============================================================

CREATE DATABASE IF NOT EXISTS ventech
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ventech;

-- ------------------------------------------------------------
-- ROLES
-- ------------------------------------------------------------
CREATE TABLE roles (
  id     INT AUTO_INCREMENT PRIMARY KEY,
  nombre ENUM('superadmin', 'admin', 'operador', 'comprador') NOT NULL
);

INSERT INTO roles (nombre) VALUES
  ('superadmin'),
  ('admin'),
  ('operador'),
  ('comprador');

-- ------------------------------------------------------------
-- USUARIOS
-- ------------------------------------------------------------
CREATE TABLE usuarios (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(100)  NOT NULL,
  apellido        VARCHAR(100)  NOT NULL,
  correo          VARCHAR(150)  NOT NULL UNIQUE,
  empresa         VARCHAR(200)  NOT NULL,
  nit             VARCHAR(20)   NOT NULL,
  telefono        VARCHAR(20)   NOT NULL,
  password_hash   VARCHAR(255)  NOT NULL,
  activo          TINYINT(1)    NOT NULL DEFAULT 1,
  fecha_creacion  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  id_rol_base     INT           NOT NULL,
  CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol_base) REFERENCES roles(id)
);

-- SuperAdmin de prueba — contraseña: Admin1234*
-- Hash generado con bcrypt (Node.js) saltRounds=10 — prefijo $2b$ requerido por el módulo nativo
INSERT INTO usuarios (nombre, apellido, correo, empresa, nit, telefono, password_hash, activo, id_rol_base) VALUES
  ('Super', 'Admin', 'superadmin@ventech.com', 'VenTech SAS', '900123456-1', '3001234567',
   '$2b$10$GOJpq9btWdDIsq6qFUqVg.FUxOFQ4uc3Wlgt..e99Jl/g3/reRZNu', 1, 1);

-- ------------------------------------------------------------
-- MÓDULOS
-- ------------------------------------------------------------
CREATE TABLE modulos (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL,
  descripcion TEXT,
  ruta        VARCHAR(150) NOT NULL
);

INSERT INTO modulos (nombre, descripcion, ruta) VALUES
  ('Catálogo',           'Visualización del catálogo de productos',             '/catalog'),
  ('Carrito',            'Gestión del carrito de compras',                      '/cart'),
  ('Checkout',           'Proceso de pago y confirmación de pedido',            '/checkout'),
  ('Mi Cuenta',          'Panel personal del comprador',                        '/account/dashboard'),
  ('Mis Pedidos',        'Historial de pedidos del comprador',                  '/account/orders'),
  ('Panel Admin',        'Dashboard administrativo general',                    '/admin/dashboard'),
  ('Gestión Productos',  'Crear, editar y desactivar productos del catálogo',   '/admin/products'),
  ('Inventario',         'Control de stock y alertas de stock mínimo',          '/admin/inventory'),
  ('Pedidos Admin',      'Gestión y seguimiento de todos los pedidos',          '/admin/orders'),
  ('Ventas',             'Reporte y análisis de ventas',                        '/admin/sales'),
  ('Facturación',        'Generación y descarga de facturas electrónicas',      '/admin/invoicing'),
  ('Reportes',           'Reportes administrativos globales',                   '/admin/reports'),
  ('Usuarios',           'Gestión de usuarios y asignación de permisos',        '/admin/users'),
  ('Configuración',      'Configuración general del sistema',                   '/admin/settings');

-- ------------------------------------------------------------
-- USUARIO_MODULOS (permisos)
-- ------------------------------------------------------------
CREATE TABLE usuario_modulos (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT        NOT NULL,
  id_modulo  INT        NOT NULL,
  activo     TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_um_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
  CONSTRAINT fk_um_modulo  FOREIGN KEY (id_modulo)  REFERENCES modulos(id),
  UNIQUE KEY uq_usuario_modulo (id_usuario, id_modulo)
);

-- El SuperAdmin (id=1) tiene acceso a todos los módulos
INSERT INTO usuario_modulos (id_usuario, id_modulo, activo)
SELECT 1, id, 1 FROM modulos;

-- ------------------------------------------------------------
-- PRODUCTOS
-- ------------------------------------------------------------
CREATE TABLE productos (
  id               INT AUTO_INCREMENT PRIMARY KEY,
  nombre           VARCHAR(200)   NOT NULL,
  marca            VARCHAR(100)   NOT NULL,
  descripcion      TEXT,
  categoria        VARCHAR(100)   NOT NULL,
  precio           DECIMAL(12,2)  NOT NULL,
  precio_anterior  DECIMAL(12,2)  DEFAULT NULL,
  descuento        DECIMAL(5,2)   DEFAULT 0.00,
  emoji_referencia VARCHAR(10)    DEFAULT NULL,
  activo           TINYINT(1)     NOT NULL DEFAULT 1,
  fecha_creacion   DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO productos (nombre, marca, descripcion, categoria, precio, precio_anterior, descuento, emoji_referencia) VALUES
  ('Laptop ThinkPad E15',    'Lenovo', 'Portátil empresarial Intel Core i5, 16GB RAM, 512GB SSD',  'Portátiles',   3200000.00, 3800000.00, 15.79, '💻'),
  ('Monitor UltraSharp 27"', 'Dell',   'Monitor IPS 4K 27 pulgadas con panel antirreflejo',        'Monitores',    1850000.00, NULL,         0.00, '🖥️'),
  ('Teclado MX Keys',        'Logitech','Teclado inalámbrico retroiluminado para empresas',        'Periféricos',   320000.00, 380000.00,  15.79, '⌨️'),
  ('Mouse MX Master 3',      'Logitech','Mouse ergonómico inalámbrico de alta precisión',          'Periféricos',   280000.00, NULL,         0.00, '🖱️'),
  ('Switch 24 puertos',      'TP-Link', 'Switch administrable Gigabit 24 puertos para oficina',   'Redes',        1200000.00, 1400000.00,  14.29, '🔌');

-- ------------------------------------------------------------
-- INVENTARIO
-- ------------------------------------------------------------
CREATE TABLE inventario (
  id                   INT AUTO_INCREMENT PRIMARY KEY,
  id_producto          INT      NOT NULL UNIQUE,
  stock_actual         INT      NOT NULL DEFAULT 0,
  stock_minimo         INT      NOT NULL DEFAULT 5,
  ultima_actualizacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_inventario_producto FOREIGN KEY (id_producto) REFERENCES productos(id)
);

INSERT INTO inventario (id_producto, stock_actual, stock_minimo) VALUES
  (1, 20, 5),
  (2, 15, 3),
  (3, 50, 10),
  (4, 45, 10),
  (5,  8, 2);

-- ------------------------------------------------------------
-- PAGOS
-- Se crea antes que pedidos para que pedidos pueda referenciarla.
-- La FK pagos.id_pedido → pedidos.id se agrega al final con ALTER TABLE
-- para resolver la dependencia circular entre ambas tablas.
-- ------------------------------------------------------------
CREATE TABLE pagos (
  id                  INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido           INT           NOT NULL,
  metodo              ENUM('pse', 'nequi', 'tarjeta', 'mercadopago') NOT NULL,
  estado              ENUM('aprobado', 'rechazado', 'pendiente')     NOT NULL DEFAULT 'pendiente',
  monto               DECIMAL(14,2) NOT NULL,
  fecha_transaccion   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  referencia_externa  VARCHAR(200)  DEFAULT NULL
);

-- ------------------------------------------------------------
-- PEDIDOS
-- ------------------------------------------------------------
CREATE TABLE pedidos (
  id                     INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario             INT           NOT NULL,
  fecha_compra           DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_entrega_estimada DATE          DEFAULT NULL,
  fecha_entrega_real     DATE          DEFAULT NULL,
  estado                 ENUM('pendiente', 'pagado', 'despachado', 'en_camino', 'entregado', 'cancelado') NOT NULL DEFAULT 'pendiente',
  total                  DECIMAL(14,2) NOT NULL,
  id_pago                INT           DEFAULT NULL,
  CONSTRAINT fk_pedidos_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
  CONSTRAINT fk_pedidos_pago    FOREIGN KEY (id_pago)    REFERENCES pagos(id)
);

-- ------------------------------------------------------------
-- DETALLE_PEDIDOS
-- ------------------------------------------------------------
CREATE TABLE detalle_pedidos (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido       INT           NOT NULL,
  id_producto     INT           NOT NULL,
  cantidad        INT           NOT NULL,
  precio_unitario DECIMAL(12,2) NOT NULL,
  subtotal        DECIMAL(14,2) NOT NULL,
  CONSTRAINT fk_detalle_pedido   FOREIGN KEY (id_pedido)   REFERENCES pedidos(id),
  CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES productos(id)
);

-- ------------------------------------------------------------
-- FACTURAS
-- ------------------------------------------------------------
CREATE TABLE facturas (
  id               INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido        INT           NOT NULL UNIQUE,
  numero_factura   VARCHAR(50)   NOT NULL UNIQUE,
  fecha_generacion DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  total            DECIMAL(14,2) NOT NULL,
  ruta_pdf         VARCHAR(300)  DEFAULT NULL,
  descargable      TINYINT(1)    NOT NULL DEFAULT 1,
  CONSTRAINT fk_facturas_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id)
);

-- ------------------------------------------------------------
-- FK DIFERIDA — pagos.id_pedido → pedidos.id
-- Se agrega aquí porque pagos se creó antes que pedidos.
-- ------------------------------------------------------------
ALTER TABLE pagos
  ADD CONSTRAINT fk_pagos_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id);
