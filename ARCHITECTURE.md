# VenTech — Arquitectura del Sistema

> Documento técnico de referencia para el equipo de desarrollo y el instructor del proyecto SENA Ficha 3186630.
> Última actualización: junio 2026.

---

## Tabla de Contenidos

1. [Descripción General](#1-descripción-general)
2. [Stack Tecnológico](#2-stack-tecnológico)
3. [Estructura de Carpetas](#3-estructura-de-carpetas)
4. [Arquitectura MVC](#4-arquitectura-mvc)
5. [Base de Datos](#5-base-de-datos)
6. [Sistema de Roles y Permisos](#6-sistema-de-roles-y-permisos)
7. [Flujo de Autenticación](#7-flujo-de-autenticación)
8. [Flujo de Datos](#8-flujo-de-datos)
9. [Configuración de Entorno](#9-configuración-de-entorno)
10. [Despliegue — Local y Producción](#10-despliegue--local-y-producción)
11. [Seguridad](#11-seguridad)
12. [Convenciones del Proyecto](#12-convenciones-del-proyecto)

---

## 1. Descripción General

**VenTech** es una plataforma de comercio electrónico B2B (Business to Business) especializada en productos tecnológicos para empresas colombianas. Permite a las organizaciones adquirir equipos, periféricos y soluciones tecnológicas a través de un canal digital seguro, con gestión de pedidos, inventario, pagos y facturación electrónica integrada.

### Características principales

- Catálogo de productos tecnológicos con filtros por categoría, marca y precio.
- Proceso de compra orientado a empresas: NIT, datos de empresa, facturación.
- Panel administrativo multi-rol para gestión interna del negocio.
- Sistema de permisos granular por módulo, configurable por el SuperAdmin.
- Integración con métodos de pago colombianos: PSE, Nequi, tarjeta de crédito y MercadoPago.

### Alcance del sistema

El sistema está dividido en tres capas principales que trabajan en conjunto:

- **Frontend:** Interfaz de usuario construida con Vue 3, ejecutada en el navegador del cliente.
- **Backend:** API REST construida con Node.js y Express.js, que contiene toda la lógica de negocio.
- **Base de datos:** MySQL como motor de persistencia, con acceso a través del driver `mysql2`.

---

## 2. Stack Tecnológico

### Backend

| Tecnología | Versión | Propósito |
|---|---|---|
| Node.js | LTS | Runtime de JavaScript del lado del servidor |
| Express.js | ^4.x | Framework web para construir la API REST |
| mysql2 | ^3.x | Driver para conexión directa a MySQL (con soporte a Promises) |
| jsonwebtoken | ^9.x | Generación y verificación de tokens JWT para sesiones |
| bcrypt | ^5.x | Hash seguro de contraseñas (saltRounds entre 10 y 12) |
| dotenv | ^16.x | Carga de variables de entorno desde el archivo `.env` |
| express-validator | ^7.x | Validación y sanitización de entradas del usuario |

**Patrón de diseño:** MVC (Modelo — Vista — Controlador), con separación clara de responsabilidades entre rutas, controladores y modelos.

### Frontend

| Tecnología | Versión | Propósito |
|---|---|---|
| Vue 3 | ^3.x | Framework JavaScript con Composition API |
| Bootstrap 5 | ^5.x | Framework CSS instalado vía npm (no CDN) |
| Vue Router | ^4.x | Enrutamiento del lado del cliente (SPA) |

Bootstrap 5 se importa desde `node_modules` y se registra en `main.js` usando `provide/inject`, junto con `bootstrap.bundle.js` para los componentes JavaScript (modales, tooltips, etc.).

### Base de Datos

| Ambiente | Motor | Herramienta |
|---|---|---|
| Desarrollo local | MySQL 8.x | XAMPP (MySQL integrado, puerto 3306) |
| Producción | MySQL 8.x | Railway (recomendado) o Render |

El cambio de desarrollo a producción solo requiere actualizar las variables de entorno en el archivo `.env`. No se modifica ninguna línea de código.

---

## 3. Estructura de Carpetas

```
ventech/
├── src/
│   ├── controllers/        # Lógica de negocio, un archivo por módulo
│   ├── models/             # Definición de tablas y queries MySQL
│   ├── routes/             # Rutas Express, separadas por módulo
│   ├── middleware/         # Autenticación JWT, verificación de roles
│   ├── views/
│   │   ├── public/         # Páginas sin requerimiento de sesión
│   │   │   ├── home.vue
│   │   │   ├── catalog.vue
│   │   │   ├── product-detail.vue
│   │   │   └── auth.vue
│   │   └── private/        # Páginas con requerimiento de permisos
│   │       ├── cart.vue
│   │       ├── checkout.vue
│   │       ├── account/
│   │       │   ├── dashboard.vue
│   │       │   └── orders.vue
│   │       └── admin/
│   │           ├── dashboard.vue
│   │           ├── products.vue
│   │           ├── inventory.vue
│   │           ├── orders.vue
│   │           ├── sales.vue
│   │           ├── invoicing.vue
│   │           ├── reports.vue
│   │           ├── users.vue
│   │           └── settings.vue
│   └── components/         # Componentes reutilizables Vue
│       ├── Navbar.vue
│       ├── Footer.vue
│       ├── BtnPrimary.vue
│       ├── BtnSecondary.vue
│       ├── ProductCard.vue
│       └── AuthForm.vue
├── public/                 # Archivos estáticos (imágenes, favicon)
├── config/
│   └── db.js               # Configuración de conexión MySQL
├── app.js                  # Punto de entrada Express
├── .env                    # Variables de entorno (NO subir a GitHub)
├── .env.example            # Plantilla de variables de entorno
└── package.json
```

### Descripción de cada directorio

**`src/controllers/`**
Contiene la lógica de negocio de cada módulo. Un controlador recibe el request de Express, procesa los datos usando el modelo correspondiente y devuelve la respuesta JSON. Ejemplo: `auth-controller.js`, `products-controller.js`, `orders-controller.js`.

**`src/models/`**
Define la estructura de cada tabla y encapsula los queries SQL. Los modelos son funciones que reciben parámetros y ejecutan queries con `mysql2`. No contienen lógica de negocio. Ejemplo: `user-model.js`, `product-model.js`.

**`src/routes/`**
Define los endpoints de la API REST y los asocia con su controlador correspondiente. Cada módulo tiene su propio archivo de rutas. Ejemplo: `auth-routes.js` define `POST /api/auth/login` y `POST /api/auth/logout`.

**`src/middleware/`**
Funciones intermedias que se ejecutan antes de que el request llegue al controlador. Contiene `auth-middleware.js` (verifica el JWT) y `role-middleware.js` (verifica si el usuario tiene permiso para el módulo solicitado).

**`src/views/public/`**
Páginas Vue accesibles sin sesión iniciada. Cualquier visitante puede ver el catálogo, el detalle de un producto y la pantalla de inicio de sesión.

**`src/views/private/`**
Páginas Vue que requieren sesión activa y permisos específicos. Se dividen en `/account/` (panel del comprador) y `/admin/` (panel de gestión interna).

**`src/components/`**
Componentes Vue reutilizables que se usan en múltiples vistas. Todos los componentes van obligatoriamente en esta carpeta, en PascalCase.

**`config/db.js`**
Configuración central de la conexión a MySQL usando un pool de conexiones de `mysql2`. Es el único archivo que importa las credenciales de la base de datos desde `.env`.

**`public/`**
Archivos estáticos servidos directamente por Express: imágenes de productos, favicon, logos. No pasan por ningún controlador.

**`app.js`**
Punto de entrada de la aplicación. Inicializa Express, registra middlewares globales (CORS, JSON parser), monta las rutas de cada módulo y arranca el servidor en el puerto definido en `.env`.

---

## 4. Arquitectura MVC

VenTech sigue el patrón **Modelo — Vista — Controlador**, que separa claramente las tres responsabilidades del sistema:

```
Navegador (Vue)
      │
      │  HTTP Request (JSON)
      ▼
┌─────────────────────────────────────────────────┐
│                  Express.js                     │
│                                                 │
│  routes/          →   middleware/               │
│  (define el           (verifica JWT             │
│   endpoint)            y permisos)              │
│                              │                  │
│                              ▼                  │
│                    controllers/                 │
│                    (lógica de negocio)          │
│                              │                  │
│                              ▼                  │
│                    models/                      │
│                    (queries SQL)                │
└─────────────────────────────────────────────────┘
      │
      │  Query SQL
      ▼
   MySQL
      │
      │  Resultado
      ▼
┌─────────────────────────────────────────────────┐
│  models/ → controllers/ → respuesta JSON        │
└─────────────────────────────────────────────────┘
      │
      │  HTTP Response (JSON)
      ▼
Navegador (Vue actualiza la interfaz)
```

### El Modelo (`src/models/`)

Representa los datos y el acceso a la base de datos. Cada archivo de modelo expone funciones que ejecutan queries SQL específicas. El modelo no sabe nada del request HTTP ni de la lógica de negocio; solo sabe hablar con MySQL.

### La Vista (`src/views/` + `src/components/`)

Son los componentes Vue que el usuario ve e interactúa. La "vista" en este contexto es la SPA (Single Page Application) en el navegador. Las vistas no acceden directamente a la base de datos; siempre consumen datos a través de la API del backend.

### El Controlador (`src/controllers/`)

Es el intermediario. Recibe el request de Express, llama al modelo para obtener o guardar datos, aplica las reglas de negocio (validaciones, cálculos, autorizaciones adicionales) y devuelve la respuesta JSON a la vista.

---

## 5. Base de Datos

### Motor y convenciones

- **Motor:** MySQL 8.x
- **Nombres de tablas:** `snake_case` en plural
- **Claves primarias:** `id` de tipo `INT AUTO_INCREMENT`
- **Claves foráneas:** `id_tabla_referenciada` (ejemplo: `id_usuario`, `id_producto`)
- **Fechas:** `DATETIME` para registros con hora, `DATE` para fechas sin hora
- **Estados:** campos `ENUM` con valores fijos definidos

---

### `usuarios`

Almacena todos los usuarios del sistema, tanto compradores como operadores y administradores.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `nombre` | VARCHAR(100) | Nombre del usuario |
| `apellido` | VARCHAR(100) | Apellido del usuario |
| `correo` | VARCHAR(150) UNIQUE | Correo electrónico (usado para login) |
| `empresa` | VARCHAR(200) | Nombre de la empresa |
| `nit` | VARCHAR(20) | NIT de la empresa colombiana |
| `telefono` | VARCHAR(20) | Teléfono de contacto |
| `password_hash` | VARCHAR(255) | Contraseña encriptada con bcrypt |
| `activo` | TINYINT(1) | 1 = activo, 0 = suspendido |
| `fecha_creacion` | DATETIME | Fecha y hora de registro |
| `id_rol_base` | INT | FK → `roles.id` |

---

### `roles`

Define los cuatro roles base del sistema.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `nombre` | ENUM | `superadmin`, `admin`, `operador`, `comprador` |

---

### `modulos`

Catálogo de todos los módulos del sistema sobre los que se pueden asignar permisos.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `nombre` | VARCHAR(100) | Nombre legible del módulo (ej: "Gestión de Productos") |
| `descripcion` | TEXT | Descripción breve del módulo |
| `ruta` | VARCHAR(150) | Ruta de la vista (ej: `/admin/products`) |

---

### `usuario_modulos`

Tabla de permisos. Relaciona cada usuario con los módulos a los que tiene acceso. Es la tabla central del sistema de autorización.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `id_usuario` | INT | FK → `usuarios.id` |
| `id_modulo` | INT | FK → `modulos.id` |
| `activo` | TINYINT(1) | 1 = permiso activo, 0 = revocado |

---

### `productos`

Catálogo de productos tecnológicos disponibles para la venta.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `nombre` | VARCHAR(200) | Nombre del producto |
| `marca` | VARCHAR(100) | Marca del fabricante |
| `descripcion` | TEXT | Descripción detallada |
| `categoria` | VARCHAR(100) | Categoría (ej: "Portátiles", "Impresoras") |
| `precio` | DECIMAL(12,2) | Precio de venta actual en COP |
| `precio_anterior` | DECIMAL(12,2) | Precio antes del descuento (para mostrar tachado) |
| `descuento` | DECIMAL(5,2) | Porcentaje de descuento aplicado |
| `emoji_referencia` | VARCHAR(10) | Emoji para identificación visual rápida |
| `activo` | TINYINT(1) | 1 = visible en catálogo, 0 = oculto |
| `fecha_creacion` | DATETIME | Fecha de registro del producto |

---

### `inventario`

Controla el stock disponible de cada producto.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `id_producto` | INT | FK → `productos.id` |
| `stock_actual` | INT | Unidades disponibles en bodega |
| `stock_minimo` | INT | Umbral de alerta de stock bajo |
| `ultima_actualizacion` | DATETIME | Fecha y hora del último movimiento de inventario |

---

### `pedidos`

Registra cada orden de compra realizada por un usuario.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `id_usuario` | INT | FK → `usuarios.id` |
| `fecha_compra` | DATETIME | Momento en que se realizó el pedido |
| `fecha_entrega_estimada` | DATE | Fecha estimada de entrega |
| `fecha_entrega_real` | DATE | Fecha real de entrega (NULL hasta que se entregue) |
| `estado` | ENUM | `pendiente`, `pagado`, `despachado`, `en_camino`, `entregado`, `cancelado` |
| `total` | DECIMAL(14,2) | Valor total del pedido en COP |
| `id_pago` | INT | FK → `pagos.id` |

---

### `detalle_pedidos`

Almacena cada línea de producto dentro de un pedido (equivalente a los ítems del carrito al momento de comprar).

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `id_pedido` | INT | FK → `pedidos.id` |
| `id_producto` | INT | FK → `productos.id` |
| `cantidad` | INT | Unidades del producto en este pedido |
| `precio_unitario` | DECIMAL(12,2) | Precio del producto al momento de la compra |
| `subtotal` | DECIMAL(14,2) | `cantidad × precio_unitario` |

---

### `pagos`

Registra la transacción de pago asociada a cada pedido.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `id_pedido` | INT | FK → `pedidos.id` |
| `metodo` | ENUM | `pse`, `nequi`, `tarjeta`, `mercadopago` |
| `estado` | ENUM | `aprobado`, `rechazado`, `pendiente` |
| `monto` | DECIMAL(14,2) | Monto procesado en COP |
| `fecha_transaccion` | DATETIME | Momento de la transacción |
| `referencia_externa` | VARCHAR(200) | ID de la transacción en la pasarela de pago |

---

### `facturas`

Registra la factura electrónica generada para cada pedido pagado.

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | INT AUTO_INCREMENT | Clave primaria |
| `id_pedido` | INT | FK → `pedidos.id` |
| `numero_factura` | VARCHAR(50) UNIQUE | Número consecutivo de factura |
| `fecha_generacion` | DATETIME | Fecha y hora de emisión |
| `total` | DECIMAL(14,2) | Total facturado en COP |
| `ruta_pdf` | VARCHAR(300) | Ruta del archivo PDF generado en el servidor |
| `descargable` | TINYINT(1) | 1 = el comprador puede descargar la factura |

---

### Diagrama de relaciones

```
roles ──────────────── usuarios ─────────────────────── pedidos
  1                    N    1                            N    1
                            │                                 │
                            │ N                               │
                     usuario_modulos                   detalle_pedidos
                            │ N                          N    │
                            │                                 │
                          modulos                        productos
                                                              │ 1
                                                              │
                                                         inventario
                                                              1

pedidos ──── pagos
  1    1

pedidos ──── facturas
  1    1
```

---

## 6. Sistema de Roles y Permisos

### Los cuatro roles

VenTech maneja cuatro roles base. El rol base (`id_rol_base` en la tabla `usuarios`) define el perfil general del usuario, pero los permisos reales se controlan módulo a módulo en la tabla `usuario_modulos`.

#### SuperAdmin
Tiene acceso total a todos los módulos del sistema. Es el único rol que puede:
- Crear, modificar y suspender usuarios.
- Asignar qué módulos puede ver cada usuario al momento de crearlo.
- Acceder a reportes administrativos globales.
- Modificar la configuración del sistema.

#### Admin
Tiene acceso a los mismos módulos que el SuperAdmin, excepto: gestión de usuarios, reportes administrativos y configuración del sistema. Ideal para gerentes o supervisores operativos.

#### Operador
Tiene acceso únicamente a los módulos que el SuperAdmin le asignó al crear su cuenta. Casos de uso típicos: un bodeguero con acceso a inventario y pedidos, o un vendedor con acceso a ventas y facturación. Los módulos disponibles para un Operador son configurables sin tocar el código.

#### Comprador
Tiene acceso al catálogo público, carrito, proceso de pago, historial de pedidos, descarga de facturas y su panel de cuenta personal. No tiene acceso a ningún módulo administrativo.

---

### Cómo funcionan los permisos en la práctica

Los permisos **no están codificados como condiciones fijas en el código**. Se almacenan en la base de datos en la tabla `usuario_modulos`. Esto significa que cambiar los permisos de un usuario no requiere modificar ni redesplegar el código: basta con actualizar un registro en la base de datos.

**Flujo de asignación:**
1. El SuperAdmin crea un nuevo usuario (Operador) desde el panel de administración.
2. Durante la creación, selecciona qué módulos tendrá habilitados (ej: Inventario, Pedidos, Ventas).
3. Se insertan registros en `usuario_modulos` con `activo = 1` para esos módulos.
4. Cuando el operador inicia sesión, su JWT incluye la lista de módulos permitidos.
5. El `role-middleware.js` verifica en cada request si el módulo solicitado está en esa lista.

---

## 7. Flujo de Autenticación

El sistema de autenticación combina `bcrypt` para la verificación segura de contraseñas y `JWT` para la gestión de sesiones sin estado (stateless).

**Paso a paso del proceso de login:**

1. El usuario escribe su correo y contraseña en el formulario `AuthForm.vue` y hace clic en "Ingresar". El componente Vue envía una petición `POST /api/auth/login` con el cuerpo `{ correo, password }`.

2. El `AuthController` en el backend recibe la petición y usa el modelo de usuarios para buscar en MySQL el registro donde `correo` coincida con el enviado. Si no existe ningún usuario con ese correo, devuelve un error `401 Unauthorized`.

3. Si el usuario existe, `bcrypt.compare(password, usuario.password_hash)` compara la contraseña ingresada contra el hash almacenado. `bcrypt` aplica el mismo salt automáticamente y determina si la contraseña es correcta. Si no coincide, devuelve `401 Unauthorized`.

4. Si la comparación es exitosa, el controlador consulta en `usuario_modulos` la lista de módulos con `activo = 1` para ese usuario. Luego genera un `JWT` con el payload `{ id_usuario, id_rol_base, modulos: [lista_de_modulos] }`, firmado con `JWT_SECRET` del archivo `.env`, con expiración de `15 minutos` (configurado en `JWT_EXPIRES_IN`).

5. El token JWT se envía como respuesta al frontend. El componente Vue lo almacena en `localStorage` del navegador bajo la clave `ventech_token`.

6. En cada petición posterior a rutas privadas, el frontend incluye el token en el header `Authorization: Bearer <token>`. El `auth-middleware.js` de Express intercepta el request, verifica la firma del token y extrae el payload. El `role-middleware.js` verifica que el módulo solicitado (identificado por la ruta) esté incluido en `payload.modulos`. Si alguna verificación falla, devuelve `401` o `403 Forbidden`.

7. La sesión cierra automáticamente después de 15 minutos de inactividad (RNF01 del proyecto). Esto se implementa a través del tiempo de expiración del JWT (`exp` en el payload). Cuando el token expira, el middleware rechaza el request y el frontend redirige al usuario a la pantalla de login.

---

## 8. Flujo de Datos

Esta sección describe el ciclo de vida completo de una petición, desde que el usuario hace clic en el navegador hasta que la base de datos responde y la interfaz se actualiza.

**Ejemplo: El comprador agrega un producto al carrito.**

```
1. ACCIÓN EN EL NAVEGADOR
   El usuario hace clic en "Agregar al carrito" dentro del componente
   ProductCard.vue. El evento dispara una función en el Composition
   API del componente.

2. LLAMADA A LA API
   La función ejecuta una petición HTTP:
   POST /api/carrito/agregar
   Headers: { Authorization: Bearer <token> }
   Body: { id_producto: 42, cantidad: 2 }

3. ENRUTAMIENTO EN EXPRESS
   app.js tiene montado el router de carrito:
   app.use('/api/carrito', carritoRoutes)
   El router identifica la ruta /agregar y la asocia al controlador.

4. MIDDLEWARES
   Antes de llegar al controlador, el request pasa por:
   → auth-middleware.js: verifica que el JWT sea válido y no haya expirado.
   → role-middleware.js: verifica que el usuario tenga permiso para
     el módulo de carrito (los compradores siempre lo tienen).

5. CONTROLADOR
   carritoController.agregar() recibe req.body y req.user (inyectado
   por el middleware). Valida que la cantidad sea mayor a 0 y que el
   producto exista y esté activo.

6. MODELO Y BASE DE DATOS
   El controlador llama a carritoModel.agregarItem(id_usuario, id_producto, cantidad).
   El modelo ejecuta el query SQL contra MySQL usando mysql2:
   INSERT INTO carrito (id_usuario, id_producto, cantidad) VALUES (?, ?, ?)
   ON DUPLICATE KEY UPDATE cantidad = cantidad + ?
   mysql2 devuelve el resultado de la operación.

7. RESPUESTA JSON
   El controlador construye la respuesta:
   { success: true, mensaje: "Producto agregado al carrito", carrito: [...] }
   Express la serializa a JSON y la envía con status 200.

8. ACTUALIZACIÓN DE LA INTERFAZ
   Vue recibe la respuesta. La lógica reactiva del componente actualiza
   el estado del carrito (usando provide/inject o Pinia si aplica).
   El ícono del carrito en el Navbar.vue muestra el nuevo total de ítems
   sin recargar la página.
```

---

## 9. Configuración de Entorno

### Archivo `.env.example`

Este archivo se sube al repositorio como plantilla. Cada desarrollador crea su propio `.env` local con sus valores reales. El archivo `.env` real **nunca se sube a GitHub**.

```env
# Base de datos
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=ventech

# Autenticación
JWT_SECRET=cambia_esto_por_un_secreto_largo_y_aleatorio
JWT_EXPIRES_IN=15m

# Servidor
NODE_ENV=development
PORT=3000
```

### Conexión a MySQL — `config/db.js`

Se usa un **pool de conexiones** para reutilizar conexiones activas y evitar el overhead de abrir una conexión nueva en cada request.

```javascript
const mysql = require('mysql2/promise');
require('dotenv').config();

const pool = mysql.createPool({
  host:     process.env.DB_HOST,
  port:     process.env.DB_PORT,
  user:     process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

module.exports = pool;
```

**Uso en un modelo:**

```javascript
const pool = require('../../config/db');

async function buscarPorCorreo(correo) {
  const [rows] = await pool.execute(
    'SELECT * FROM usuarios WHERE correo = ? AND activo = 1',
    [correo]
  );
  return rows[0] || null;
}

module.exports = { buscarPorCorreo };
```

### Punto de entrada — `app.js`

```javascript
const express = require('express');
const dotenv  = require('dotenv');

dotenv.config();

const authRoutes     = require('./src/routes/auth-routes');
const productoRoutes = require('./src/routes/product-routes');
// ... demás rutas

const app = express();

app.use(express.json());
app.use(express.static('public'));

app.use('/api/auth',     authRoutes);
app.use('/api/productos', productoRoutes);
// ... demás rutas

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`VenTech API corriendo en http://localhost:${PORT}`);
});
```

---

## 10. Despliegue — Local y Producción

### Desarrollo local con XAMPP

XAMPP provee un servidor MySQL listo para usar en Windows, sin configuración adicional.

1. Abrir el panel de control de XAMPP y iniciar el módulo **MySQL** (puerto 3306).
2. Abrir **phpMyAdmin** en `http://localhost/phpmyadmin`.
3. Crear la base de datos `ventech`.
4. Importar el script SQL inicial (schema + datos de prueba).
5. Copiar `.env.example` como `.env` en la raíz del proyecto y completar las variables (el usuario por defecto en XAMPP es `root` sin contraseña).
6. Ejecutar `npm install` para instalar las dependencias.
7. Ejecutar `node app.js` para arrancar el servidor en `http://localhost:3000`.

### Producción con Railway (recomendado)

Railway es la opción recomendada por su integración nativa con Node.js y MySQL, y por su facilidad de despliegue desde GitHub.

**Pasos para desplegar:**

1. Crear una cuenta en [railway.app](https://railway.app) y conectar la cuenta de GitHub.
2. Crear un nuevo proyecto y seleccionar **"Deploy from GitHub repo"**. Railway detecta automáticamente que es un proyecto Node.js gracias al `package.json`.
3. Dentro del mismo proyecto, hacer clic en **"Add a service"** → **MySQL**. Railway despliega una instancia MySQL administrada y genera las credenciales.
4. En la sección **Variables** del servicio Node.js, configurar las variables de entorno con los valores de producción:

```env
DB_HOST=<host_generado_por_railway>
DB_PORT=<puerto_generado_por_railway>
DB_USER=<usuario_generado_por_railway>
DB_PASSWORD=<contraseña_generada_por_railway>
DB_NAME=ventech
JWT_SECRET=<secreto_largo_y_aleatorio_para_produccion>
JWT_EXPIRES_IN=15m
NODE_ENV=production
PORT=3000
```

5. Railway genera automáticamente una **URL pública** para el backend (ej: `ventech-api.railway.app`).
6. Cada `git push` a la rama principal dispara un redespliegue automático.

**Ventaja clave:** no se modifica ninguna línea de código. El mismo proyecto que corre en XAMPP funciona en Railway sin cambios.

### Alternativa: Render

Render ofrece la misma capacidad (Node.js + MySQL administrado) con un modelo de precios fijos y predecibles por servicio, a diferencia de Railway que cobra por consumo de recursos.

**Diferencia práctica:**
- **Railway:** créditos gratuitos mensuales, luego pago por uso. Conveniente para proyectos pequeños o pruebas.
- **Render:** planes fijos desde $0/mes (con limitaciones) hasta planes pagos. Mejor para presupuestos controlados.

En ambos casos, el proceso de migración es idéntico: conectar el repo GitHub, crear el servicio de base de datos MySQL y actualizar las variables de entorno.

---

## 11. Seguridad

### Contraseñas — bcrypt

Las contraseñas **nunca se almacenan en texto plano**. Antes de guardar una contraseña en la base de datos, se aplica `bcrypt.hash(password, saltRounds)` con un `saltRounds` entre 10 y 12. Este valor determina el número de rondas de hashing: a mayor número, más seguro pero más lento. Para verificar una contraseña en el login se usa `bcrypt.compare(passwordIngresado, hashAlmacenado)`.

### Sesiones — JWT

Las sesiones se manejan con JSON Web Tokens (JWT), lo que las hace **stateless** (sin estado): el servidor no almacena las sesiones en base de datos. El token incluye en su payload el `id_usuario`, el `id_rol_base` y la lista de módulos permitidos. Está firmado con `JWT_SECRET` (definido en `.env`), lo que garantiza que no puede ser alterado sin invalidarse.

### Cierre de sesión por inactividad (RNF01)

Las sesiones cierran automáticamente después de **15 minutos de inactividad**. Esto se implementa configurando `JWT_EXPIRES_IN=15m` en el `.env`. Cuando el token expira, el middleware rechaza el request con `401 Unauthorized` y el frontend redirige al usuario al login automáticamente.

### HTTPS obligatorio en producción

Toda comunicación entre el frontend y el backend debe ocurrir sobre HTTPS en producción. Railway y Render proveen HTTPS automáticamente con sus URLs públicas. El token JWT viaja en el header de cada request y HTTPS garantiza que no sea interceptado.

### Validación de entradas — express-validator

Todas las entradas del usuario se validan y sanitizan antes de procesarse en el controlador o de ejecutar queries. Esto previene inyecciones SQL, XSS y datos malformados. El middleware de validación se aplica en la definición de las rutas, antes del controlador.

```javascript
const { body, validationResult } = require('express-validator');

router.post('/login', [
  body('correo').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }),
], authController.login);
```

### Variables de entorno — never in code

Ninguna credencial (contraseñas de base de datos, JWT_SECRET, claves de API de pasarelas de pago) se escribe directamente en el código. Todas se leen desde el archivo `.env` usando `dotenv`. El archivo `.env` está incluido en `.gitignore` y **nunca se sube al repositorio**. Solo se sube `.env.example` como plantilla sin valores reales.

---

## 12. Convenciones del Proyecto

Seguir convenciones consistentes facilita la colaboración y la lectura del código por parte de todos los miembros del equipo.

### Nombres de archivos

| Tipo de archivo | Convención | Ejemplo |
|---|---|---|
| Controladores | `kebab-case` | `auth-controller.js` |
| Modelos | `kebab-case` | `product-model.js` |
| Rutas | `kebab-case` | `order-routes.js` |
| Middlewares | `kebab-case` | `auth-middleware.js` |
| Vistas Vue | `kebab-case` | `product-detail.vue` |
| Componentes Vue | `PascalCase` | `ProductCard.vue` |

### Nombres en código

| Elemento | Convención | Ejemplo |
|---|---|---|
| Variables y funciones JS | `camelCase` | `fechaCreacion`, `buscarPorCorreo()` |
| Componentes Vue (en template) | `PascalCase` | `<ProductCard />` |
| Tablas MySQL | `snake_case` | `detalle_pedidos` |
| Campos MySQL | `snake_case` | `fecha_entrega_estimada` |
| Variables de entorno | `UPPER_SNAKE_CASE` | `JWT_SECRET`, `DB_HOST` |

### Rutas de la API

Todas las rutas siguen el patrón: `/api/modulo/accion`

```
POST   /api/auth/login
POST   /api/auth/logout
GET    /api/productos/listar
GET    /api/productos/:id
POST   /api/productos/crear
PUT    /api/productos/:id/actualizar
DELETE /api/productos/:id/eliminar
POST   /api/carrito/agregar
GET    /api/pedidos/mis-pedidos
GET    /api/admin/usuarios/listar
POST   /api/admin/usuarios/crear
```

### Mensajes de commit

Los commits se escriben en **español**, en modo imperativo, describiendo qué hace el cambio:

```
feat: agregar endpoint de login con JWT
fix: corregir validación de NIT en registro de usuario
refactor: extraer lógica de permisos a middleware separado
docs: actualizar ARCHITECTURE.md con tablas de base de datos
style: aplicar formato a componentes de autenticación
```

### Estructura de respuestas JSON

Todas las respuestas de la API siguen la misma estructura para facilitar el manejo de errores en el frontend:

```json
// Respuesta exitosa
{
  "success": true,
  "data": { ... },
  "mensaje": "Operación completada exitosamente"
}

// Respuesta de error
{
  "success": false,
  "error": "Credenciales incorrectas",
  "codigo": 401
}
```

---

*VenTech — Plataforma B2B de productos tecnológicos para empresas colombianas.*
*Proyecto SENA Ficha 3186630.*
