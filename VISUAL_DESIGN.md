# VenTech — Sistema de Diseño Visual

> Documento de referencia para el equipo de desarrollo. Consultar durante la implementación en Vue 3 + Bootstrap 5 para mantener consistencia visual en toda la plataforma.
> Última actualización: junio 2026.

---

## Índice

1. [Tipografía](#1-tipografía)
2. [Paleta de Colores y Design Tokens](#2-paleta-de-colores-y-design-tokens)
3. [Navbar](#3-navbar)
4. [Botones](#4-botones)
5. [Campos de Formulario e Inputs](#5-campos-de-formulario-e-inputs)
6. [Tarjetas de Producto](#6-tarjetas-de-producto)
7. [Badges y Etiquetas de Estado](#7-badges-y-etiquetas-de-estado)
8. [Mensajes Emergentes y Notificaciones](#8-mensajes-emergentes-y-notificaciones)
9. [Pie de Página (Footer)](#9-pie-de-página-footer)
10. [Transiciones Globales del Sistema](#10-transiciones-globales-del-sistema)

---

## 1. Tipografía

### Fuentes del proyecto

VenTech usa dos familias tipográficas importadas desde Google Fonts. La combinación de una fuente humanista variable para la interfaz y una monoespaciada para datos numéricos refuerza la claridad y el carácter técnico de la plataforma.

```html
<!-- Importar en el <head> del HTML principal o en main.js vía @import CSS -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
  href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;600&display=swap"
  rel="stylesheet"
/>
```

```css
/* Aplicar en el selector raíz del proyecto */
:root {
  --vt-font-sans: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
  --vt-font-mono: 'JetBrains Mono', 'Courier New', monospace;
}

body {
  font-family: var(--vt-font-sans);
  font-size: 16px;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
```

| Fuente | Pesos disponibles | Uso principal |
|---|---|---|
| Plus Jakarta Sans | 400, 500, 600, 700, 800 | UI general: navegación, títulos, cuerpo, botones, labels |
| JetBrains Mono | 400, 600 | Precios en COP, números de pedido, referencias, códigos |

---

### Escala tipográfica

La escala se construye sobre una base de **16px (1rem)** aplicando el ratio **Major Third (×1.25)**. Los valores descienden o ascienden multiplicando o dividiendo por 1.25 en cada nivel.

| Nivel | px | rem | font-weight | line-height | Uso en el proyecto |
|---|---|---|---|---|---|
| Hero / Display | 39px | 2.441rem | 800 | 1.2 | Titular principal de la landing y secciones hero |
| H1 | 31px | 1.953rem | 700 | 1.25 | Títulos de página: Catálogo, Carrito, Dashboard |
| H2 | 25px | 1.563rem | 700 | 1.3 | Títulos de sección dentro de una página |
| H3 | 20px | 1.25rem | 600 | 1.3 | Subtítulos de tarjetas y paneles laterales |
| H4 | 16px | 1rem | 600 | 1.4 | Etiquetas de campo, nombre de producto en tarjeta |
| Body Large | 18px | 1.125rem | 400 | 1.6 | Párrafos de descripción en hero y detalle de producto |
| Body Base | 16px | 1rem | 400 | 1.5 | Cuerpo de texto general, descripciones cortas |
| Body Small | 14px | 0.875rem | 400 | 1.5 | Metadatos, fechas, conteo de reseñas, etiquetas de campo |
| Caption | 12px | 0.75rem | 400 | 1.4 | Textos de apoyo, avisos legales, copyright del footer |
| Price | 20px | 1.25rem | 700 | 1.2 | Precios en COP — usa JetBrains Mono |
| Code / Mono | 14px | 0.875rem | 400 | 1.5 | Números de pedido, referencias — usa JetBrains Mono |

> **Regla importante:** El tamaño mínimo de fuente en la interfaz es **12px**. Nunca usar valores menores. En dispositivos móviles, el Body Base nunca puede bajar de **16px** para respetar los estándares de accesibilidad y evitar el zoom automático en Safari iOS.

```css
/* Clases utilitarias tipográficas para usar en componentes Vue */
.vt-hero    { font-size: 2.441rem; font-weight: 800; line-height: 1.2; }
.vt-h1      { font-size: 1.953rem; font-weight: 700; line-height: 1.25; }
.vt-h2      { font-size: 1.563rem; font-weight: 700; line-height: 1.3; }
.vt-h3      { font-size: 1.25rem;  font-weight: 600; line-height: 1.3; }
.vt-h4      { font-size: 1rem;     font-weight: 600; line-height: 1.4; }
.vt-body-lg { font-size: 1.125rem; font-weight: 400; line-height: 1.6; }
.vt-body    { font-size: 1rem;     font-weight: 400; line-height: 1.5; }
.vt-body-sm { font-size: 0.875rem; font-weight: 400; line-height: 1.5; }
.vt-caption { font-size: 0.75rem;  font-weight: 400; line-height: 1.4; }
.vt-price   { font-family: var(--vt-font-mono); font-size: 1.25rem; font-weight: 700; line-height: 1.2; }
.vt-mono    { font-family: var(--vt-font-mono); font-size: 0.875rem; font-weight: 400; line-height: 1.5; }
```

### Gradiente de texto (titulares de acento)

```css
/* Aplicar en titulares hero y totales de precio destacados */
.vt-text-gradient {
  background: linear-gradient(90deg, #1490F2, #00CECE);
  -webkit-background-clip: text;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  color: transparent; /* fallback para contextos sin soporte */
}
```

---

## 2. Paleta de Colores y Design Tokens

Todos los valores del sistema de diseño se definen como variables CSS en `:root`. Usar siempre los tokens `--vt-*` en el código, nunca valores hexadecimales directos fuera de esta declaración.

```css
:root {

  /* ── COLORES DE MARCA ── */
  --vt-blue:           #1490F2;  /* Azul principal — botones primarios, enlaces, foco */
  --vt-teal:           #00CECE;  /* Cian turquesa — acento secundario, badges activos */
  --vt-gradient:       linear-gradient(90deg, #1490F2, #00CECE);
  --vt-gradient-text:  linear-gradient(90deg, #1490F2, #00CECE); /* con background-clip: text */

  /* ── FONDOS Y SUPERFICIES ── */
  --vt-bg-base:        #FFFFFF;            /* Fondo general de todas las páginas */
  --vt-bg-subtle:      #F5F7FA;            /* Fondo de secciones alternadas y sidebar */
  --vt-bg-card:        #FFFFFF;            /* Superficie de tarjetas (con sombra) */
  --vt-bg-input:       #F5F7FA;            /* Fondo de campos de formulario en reposo */
  --vt-bg-overlay:     rgba(0,0,0,0.04);  /* Hover sutil sobre tarjetas y filas de tabla */

  /* ── TEXTO ── */
  --vt-text-primary:   #111827;  /* Títulos y texto de alto peso */
  --vt-text-secondary: #374151;  /* Cuerpo de texto general */
  --vt-text-muted:     #6B7280;  /* Metadatos, fechas, textos de apoyo */
  --vt-text-disabled:  #D1D5DB;  /* Texto de elementos inactivos */
  --vt-text-inverse:   #FFFFFF;  /* Texto sobre fondos de color o gradiente */
  --vt-text-link:      #1490F2;  /* Enlaces y acciones en texto */

  /* ── BORDES ── */
  --vt-border-light:   #E5E7EB;  /* Borde de tarjetas y divisores */
  --vt-border-input:   #D1D5DB;  /* Borde de campos de formulario en reposo */
  --vt-border-focus:   #1490F2;  /* Borde de campo activo con foco */
  --vt-border-active:  #1490F2;  /* Borde de elemento seleccionado */

  /* ── ESTADOS SEMÁNTICOS ── */
  --vt-success:        #16A34A;  /* Éxito, entregado, stock disponible */
  --vt-success-bg:     #F0FDF4;
  --vt-warning:        #D97706;  /* Advertencia, stock bajo, en camino */
  --vt-warning-bg:     #FFFBEB;
  --vt-error:          #DC2626;  /* Error, cancelado, descuento, campo inválido */
  --vt-error-bg:       #FEF2F2;
  --vt-info:           #1490F2;  /* Informativo, procesando */
  --vt-info-bg:        #EFF6FF;

  /* ── SOMBRAS ── */
  --vt-shadow-card:         0 1px 3px rgba(0,0,0,0.08), 0 1px 2px rgba(0,0,0,0.04);
  --vt-shadow-card-hover:   0 4px 12px rgba(20,144,242,0.12), 0 2px 4px rgba(0,0,0,0.06);
  --vt-shadow-navbar:       0 2px 8px rgba(0,0,0,0.08);
  --vt-shadow-dropdown:     0 8px 24px rgba(0,0,0,0.10);

  /* ── BORDER RADIUS ── */
  --vt-radius-sm:    6px;     /* Badges, etiquetas pequeñas */
  --vt-radius-md:    8px;     /* Inputs, botones, chips */
  --vt-radius-lg:    12px;    /* Tarjetas de producto */
  --vt-radius-xl:    16px;    /* Tarjetas grandes, paneles laterales */
  --vt-radius-full:  9999px;  /* Pills, avatares, burbujas de carrito */
}
```

---

## 3. Navbar

### Comportamiento y CSS

El navbar está fijo en la parte superior con `position: fixed`. Cambia de estado transparente (con efecto glassmorphism) a casi opaco al hacer scroll, comunicando profundidad sin cortar visualmente el contenido.

**Nota crítica:** El efecto `backdrop-filter` solo es visible si el fondo del elemento tiene transparencia (valor alfa menor a 1). Si el fondo es `#FFFFFF` sólido, el efecto no se muestra.

```css
/* ── NAVBAR BASE ── */
.vt-navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 64px;
  z-index: 1000;
  display: flex;
  align-items: center;
  padding: 0 32px;
  gap: 24px;

  /* Estado inicial: glassmorphism */
  background-color: rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px); /* Safari */
  transition: background-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

/* Estado scroll: casi opaco */
.vt-navbar.is-scrolled {
  background-color: rgba(255, 255, 255, 0.95);
  box-shadow: var(--vt-shadow-navbar);
}

/* Ancho máximo del contenido interno */
.vt-navbar__inner {
  width: 100%;
  max-width: 1280px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  gap: 24px;
}

/* ── PLACEHOLDER DEL LOGO ── */
.vt-navbar__logo {
  width: 120px;
  height: 32px;
  background-color: #F5F7FA;
  border-radius: 4px;
  flex-shrink: 0;
  cursor: pointer;
  text-decoration: none;
}

/* ── ENLACES DE NAVEGACIÓN ── */
.vt-navbar__link {
  font-size: 1rem;
  font-weight: 500;
  color: var(--vt-text-secondary);
  text-decoration: none;
  transition: color 0.3s ease-in-out;
  white-space: nowrap;
}
.vt-navbar__link:hover { color: var(--vt-blue); }

/* ── BUSCADOR ── */
.vt-navbar__search {
  position: relative;
  width: 240px;
  flex-shrink: 0;
}
.vt-navbar__search-input {
  width: 100%;
  padding: 8px 14px 8px 38px;
  background: var(--vt-bg-input);
  border: 1px solid var(--vt-border-input);
  border-radius: var(--vt-radius-md);
  font-family: var(--vt-font-sans);
  font-size: 0.875rem;
  color: var(--vt-text-primary);
  transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
  outline: none;
}
.vt-navbar__search-input::placeholder { color: var(--vt-text-muted); }
.vt-navbar__search-input:focus {
  border-color: var(--vt-border-focus);
  box-shadow: 0 0 0 3px rgba(20, 144, 242, 0.12);
}
.vt-navbar__search-icon {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  width: 16px;
  height: 16px;
  color: var(--vt-text-muted);
  pointer-events: none;
}

/* ── ÍCONO DE CARRITO ── */
.vt-navbar__cart {
  position: relative;
  cursor: pointer;
  color: var(--vt-text-secondary);
  transition: color 0.3s ease-in-out;
}
.vt-navbar__cart:hover { color: var(--vt-blue); }
.vt-navbar__cart-icon { width: 24px; height: 24px; }
.vt-navbar__cart-badge {
  position: absolute;
  top: -6px;
  right: -6px;
  min-width: 18px;
  height: 18px;
  padding: 0 4px;
  background: var(--vt-gradient);
  border-radius: var(--vt-radius-full);
  color: #FFFFFF;
  font-family: var(--vt-font-mono);
  font-size: 10px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* ── ESPACIADOR ── */
.vt-navbar__spacer { flex: 1; }
```

### JavaScript — Cambio de estado al hacer scroll

```javascript
// Agregar en el componente Navbar.vue dentro de onMounted()
// o en el archivo main.js si el navbar es global.

const navbar = document.querySelector('.vt-navbar');

window.addEventListener('scroll', () => {
  if (window.scrollY > 50) {
    navbar.classList.add('is-scrolled');
  } else {
    navbar.classList.remove('is-scrolled');
  }
}, { passive: true });
```

En Vue 3 con Composition API, dentro de `Navbar.vue`:

```vue
<script setup>
import { onMounted, onUnmounted, ref } from 'vue';

const isScrolled = ref(false);

function handleScroll() {
  isScrolled.value = window.scrollY > 50;
}

onMounted(() => window.addEventListener('scroll', handleScroll, { passive: true }));
onUnmounted(() => window.removeEventListener('scroll', handleScroll));
</script>

<template>
  <nav class="vt-navbar" :class="{ 'is-scrolled': isScrolled }">
    <!-- contenido del navbar -->
  </nav>
</template>
```

---

### Elementos del navbar de izquierda a derecha (desktop)

1. **Placeholder del logo** — Rectángulo 120×32px, fondo `#F5F7FA`, `border-radius: 4px`. Navega a `/` al hacer clic.
2. **Inicio** — Body Base, peso 500, `--vt-text-secondary`. Hover: `--vt-blue`.
3. **Productos** — Mismo estilo que Inicio.
4. **Ofertas** — Mismo estilo que Inicio.
5. **Buscador** — Campo de 240px con ícono de lupa integrado a la izquierda (ver CSS arriba).
6. **Botón "Iniciar Sesión"** — Botón primario con gradiente (`.btn-vt-primary`).
7. **Botón "Crear cuenta"** — Botón secundario con borde azul (`.btn-vt-secondary`).
8. **Ícono carrito** — SVG 24×24px con badge circular de conteo.

---

### Estado autenticado (usuario con sesión activa)

Los botones "Iniciar Sesión" y "Crear cuenta" se reemplazan por el avatar del usuario y un menú desplegable.

```css
/* ── AVATAR DEL USUARIO ── */
.vt-navbar__user {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  position: relative;
}
.vt-navbar__avatar {
  width: 32px;
  height: 32px;
  border-radius: var(--vt-radius-full);
  background: var(--vt-gradient);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #FFFFFF;
  font-size: 12px;
  font-weight: 700;
  flex-shrink: 0;
}
.vt-navbar__user-label {
  font-size: 0.875rem;
  color: var(--vt-text-secondary);
  transition: color 0.3s ease-in-out;
}
.vt-navbar__user:hover .vt-navbar__user-label { color: var(--vt-blue); }

/* ── DROPDOWN DE USUARIO ── */
/* Usa visibility + opacity para que los clics no atraviesen el elemento oculto */
.vt-navbar__dropdown {
  position: absolute;
  top: calc(100% + 12px);
  right: 0;
  min-width: 180px;
  background: #FFFFFF;
  border: 1px solid var(--vt-border-light);
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-dropdown);
  padding: 8px 0;

  visibility: hidden;
  opacity: 0;
  transform: translateY(-8px);
  transition: opacity 0.3s ease-in-out,
              transform 0.3s ease-in-out,
              visibility 0.3s ease-in-out;
}
.vt-navbar__user:hover .vt-navbar__dropdown,
.vt-navbar__dropdown.is-open {
  visibility: visible;
  opacity: 1;
  transform: translateY(0);
}
.vt-navbar__dropdown-item {
  display: block;
  padding: 10px 16px;
  font-size: 0.875rem;
  color: var(--vt-text-secondary);
  text-decoration: none;
  cursor: pointer;
  transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
}
.vt-navbar__dropdown-item:hover {
  background-color: var(--vt-bg-subtle);
  color: var(--vt-blue);
}
.vt-navbar__dropdown-item--danger { color: var(--vt-error); }
.vt-navbar__dropdown-item--danger:hover {
  background-color: var(--vt-error-bg);
  color: var(--vt-error);
}
```

---

### Navbar del panel de administración

Comparte altura (64px), posición fija y el mismo comportamiento de scroll. Difiere en el contenido:

- **Izquierda:** Placeholder del logo (mismo que en navbar público).
- **Centro:** Texto `"Panel de Administración"`, Body Base, `font-weight: 600`, `--vt-text-primary`. Centrado con `flex: 1; text-align: center`.
- **Derecha:** Ícono campana (notificaciones con badge numérico) + avatar del administrador con iniciales y dropdown de sesión.

```css
.vt-navbar--admin .vt-navbar__title {
  flex: 1;
  text-align: center;
  font-size: 1rem;
  font-weight: 600;
  color: var(--vt-text-primary);
}
```

---

### Navbar responsive (mobile < 768px)

En móvil los enlaces y el buscador se ocultan. Aparece un ícono hamburguesa que despliega un sidebar lateral con deslizamiento horizontal.

```css
/* Ocultar en mobile */
@media (max-width: 767px) {
  .vt-navbar { height: 56px; padding: 0 16px; }
  .vt-navbar__link,
  .vt-navbar__search { display: none; }
  .vt-navbar__hamburger { display: flex; }
}

/* Hamburguesa */
.vt-navbar__hamburger {
  display: none;
  flex-direction: column;
  gap: 5px;
  cursor: pointer;
  padding: 4px;
}
.vt-navbar__hamburger span {
  display: block;
  width: 22px;
  height: 2px;
  background: var(--vt-text-secondary);
  border-radius: 2px;
  transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
}

/* Sidebar mobile */
.vt-sidebar-mobile {
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 280px;
  background: #FFFFFF;
  box-shadow: var(--vt-shadow-dropdown);
  z-index: 1100;
  padding: 80px 24px 24px;
  transform: translateX(-100%);
  transition: transform 0.3s ease-in-out;
}
.vt-sidebar-mobile.is-open { transform: translateX(0); }

/* Overlay oscuro detrás del sidebar */
.vt-sidebar-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 1050;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s ease-in-out, visibility 0.3s ease-in-out;
}
.vt-sidebar-overlay.is-open { opacity: 1; visibility: visible; }
```

---

## 4. Botones

### Botón primario — `.btn-vt-primary`

Acción principal: "Agregar al carrito", "Pagar", "Iniciar sesión", "Crear pedido".

```css
.btn-vt-primary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 10px 24px;
  background: var(--vt-gradient);
  color: #FFFFFF;
  font-family: var(--vt-font-sans);
  font-size: 1rem;
  font-weight: 600;
  border: none;
  border-radius: var(--vt-radius-md);
  cursor: pointer;
  text-decoration: none;
  transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
  white-space: nowrap;
}
.btn-vt-primary:hover {
  opacity: 0.9;
  transform: translateY(-1px);
}
.btn-vt-primary:active {
  opacity: 0.95;
  transform: translateY(0);
}
.btn-vt-primary:disabled,
.btn-vt-primary.is-disabled {
  opacity: 0.4;
  cursor: not-allowed;
  transform: none;
  pointer-events: none;
}
```

### Botón secundario — `.btn-vt-secondary`

Acción alternativa: "Crear cuenta", "Ver detalles", "Cancelar".

```css
.btn-vt-secondary {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 10px 24px;
  background: transparent;
  color: var(--vt-blue);
  font-family: var(--vt-font-sans);
  font-size: 1rem;
  font-weight: 600;
  border: 1px solid var(--vt-blue);
  border-radius: var(--vt-radius-md);
  cursor: pointer;
  text-decoration: none;
  transition: background-color 0.3s ease-in-out,
              color 0.3s ease-in-out,
              border-color 0.3s ease-in-out;
  white-space: nowrap;
}
.btn-vt-secondary:hover {
  background-color: #EFF6FF;
  border-color: var(--vt-blue);
}
.btn-vt-secondary:active { background-color: #DBEAFE; }
.btn-vt-secondary:disabled,
.btn-vt-secondary.is-disabled {
  opacity: 0.4;
  cursor: not-allowed;
  pointer-events: none;
}
```

### Botón de peligro — `.btn-vt-danger`

Acciones destructivas o irreversibles: "Eliminar producto", "Cancelar pedido".

```css
.btn-vt-danger {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 10px 24px;
  background: transparent;
  color: var(--vt-error);
  font-family: var(--vt-font-sans);
  font-size: 1rem;
  font-weight: 600;
  border: 1px solid var(--vt-error);
  border-radius: var(--vt-radius-md);
  cursor: pointer;
  text-decoration: none;
  transition: background-color 0.3s ease-in-out;
  white-space: nowrap;
}
.btn-vt-danger:hover { background-color: var(--vt-error-bg); }
.btn-vt-danger:disabled,
.btn-vt-danger.is-disabled {
  opacity: 0.4;
  cursor: not-allowed;
  pointer-events: none;
}
```

### Botón ghost — `.btn-vt-ghost`

Acciones sutiles en tablas, filas, menús contextuales.

```css
.btn-vt-ghost {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  padding: 6px 12px;
  background: transparent;
  color: var(--vt-text-muted);
  font-family: var(--vt-font-sans);
  font-size: 0.875rem;
  font-weight: 500;
  border: none;
  border-radius: var(--vt-radius-md);
  cursor: pointer;
  text-decoration: none;
  transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
}
.btn-vt-ghost:hover {
  background-color: var(--vt-bg-overlay);
  color: var(--vt-text-primary);
}
```

---

## 5. Campos de Formulario e Inputs

### Estructura HTML recomendada

```html
<div class="vt-field">
  <label class="vt-field__label" for="correo">Correo electrónico</label>
  <input
    id="correo"
    type="email"
    class="vt-field__input"
    placeholder="ejemplo@empresa.com"
  />
  <!-- Solo visible cuando hay error -->
  <span class="vt-field__error">Ingresa un correo válido.</span>
</div>
```

### CSS completo de campos

```css
/* ── CONTENEDOR ── */
.vt-field {
  display: flex;
  flex-direction: column;
  gap: 4px;
  width: 100%;
}

/* ── LABEL ── */
.vt-field__label {
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--vt-text-secondary);
  line-height: 1.4;
  cursor: pointer;
}

/* ── INPUT — Estado reposo ── */
.vt-field__input,
.vt-field__select,
.vt-field__textarea {
  width: 100%;
  padding: 10px 14px;
  background: var(--vt-bg-input);
  border: 1px solid var(--vt-border-input);
  border-radius: var(--vt-radius-md);
  font-family: var(--vt-font-sans);
  font-size: 1rem;
  color: var(--vt-text-primary);
  line-height: 1.5;
  outline: none;
  appearance: none;
  transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}
.vt-field__input::placeholder,
.vt-field__textarea::placeholder {
  color: var(--vt-text-muted);
}

/* ── INPUT — Estado foco ── */
.vt-field__input:focus,
.vt-field__select:focus,
.vt-field__textarea:focus {
  border-color: var(--vt-border-focus);
  box-shadow: 0 0 0 3px rgba(20, 144, 242, 0.12);
  background: #FFFFFF;
}

/* ── INPUT — Estado error ── */
.vt-field.has-error .vt-field__input,
.vt-field.has-error .vt-field__select,
.vt-field.has-error .vt-field__textarea {
  border-color: var(--vt-error);
}
.vt-field.has-error .vt-field__input:focus {
  box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.10);
}

/* ── MENSAJE DE ERROR ── */
.vt-field__error {
  font-size: 0.75rem;
  color: var(--vt-error);
  padding-top: 2px;
  opacity: 0;
  visibility: hidden;
  transition: opacity 0.3s ease-in-out, visibility 0.3s ease-in-out;
}
.vt-field.has-error .vt-field__error {
  opacity: 1;
  visibility: visible;
}

/* ── INPUT — Estado deshabilitado ── */
.vt-field__input:disabled,
.vt-field__select:disabled,
.vt-field__textarea:disabled {
  background: #F9FAFB;
  color: var(--vt-text-disabled);
  cursor: not-allowed;
  opacity: 0.6;
}
```

---

## 6. Tarjetas de Producto

### Estructura HTML

```html
<article class="product-card">
  <!-- Área de imagen -->
  <div class="product-card__image-wrapper">
    <img src="/img/producto.jpg" alt="Laptop Dell XPS 13" class="product-card__image" />
    <!-- Badge de categoría o descuento superpuesto -->
    <span class="product-card__badge product-card__badge--discount">-15%</span>
  </div>

  <!-- Cuerpo de la tarjeta -->
  <div class="product-card__body">
    <span class="product-card__brand">Dell</span>
    <h3 class="product-card__name">Laptop Dell XPS 13 Core i7 16GB RAM</h3>

    <!-- Calificación -->
    <div class="product-card__rating">
      <span class="product-card__stars">★★★★★</span>
      <span class="product-card__reviews">(48 reseñas)</span>
    </div>

    <!-- Precios -->
    <div class="product-card__pricing">
      <span class="product-card__price">$6.999.000</span>
      <span class="product-card__price-old">$8.234.000</span>
    </div>

    <button class="btn-vt-primary product-card__cta">Agregar al carrito</button>
  </div>
</article>
```

### CSS de la tarjeta

```css
/* ── TARJETA ── */
.product-card {
  background: var(--vt-bg-card);
  border: 1px solid var(--vt-border-light);
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-card);
  overflow: hidden;
  display: flex;
  flex-direction: column;
  transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}
.product-card:hover {
  transform: translateY(-3px);
  box-shadow: var(--vt-shadow-card-hover);
}

/* ── ÁREA DE IMAGEN ── */
.product-card__image-wrapper {
  position: relative;
  background: var(--vt-bg-subtle);
  height: 180px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}
.product-card__image {
  max-height: 140px;
  max-width: 85%;
  object-fit: contain;
}

/* Badge superpuesto en esquina superior izquierda */
.product-card__badge {
  position: absolute;
  top: 10px;
  left: 10px;
  font-size: 0.75rem;
  font-weight: 700;
  padding: 2px 10px;
  border-radius: var(--vt-radius-full);
}
.product-card__badge--discount {
  background: var(--vt-error-bg);
  color: var(--vt-error);
  border: 1px solid rgba(220, 38, 38, 0.2);
}
.product-card__badge--new {
  background: var(--vt-info-bg);
  color: var(--vt-blue);
  border: 1px solid rgba(20, 144, 242, 0.2);
}

/* ── CUERPO ── */
.product-card__body {
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
}

/* Etiqueta de marca */
.product-card__brand {
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--vt-blue);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* Nombre del producto: máximo 2 líneas */
.product-card__name {
  font-size: 1rem;
  font-weight: 700;
  color: var(--vt-text-primary);
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  margin: 0;
}

/* Calificación */
.product-card__rating { display: flex; align-items: center; gap: 6px; }
.product-card__stars { color: #F59E0B; font-size: 0.75rem; }
.product-card__reviews { font-size: 0.75rem; color: var(--vt-text-muted); }

/* Precios */
.product-card__pricing {
  display: flex;
  align-items: baseline;
  gap: 8px;
  flex-wrap: wrap;
  margin-top: 4px;
}
.product-card__price {
  font-family: var(--vt-font-mono);
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--vt-text-primary);
}
.product-card__price-old {
  font-size: 0.75rem;
  color: var(--vt-text-disabled);
  text-decoration: line-through;
  font-family: var(--vt-font-mono);
}

/* Botón al fondo de la tarjeta */
.product-card__cta {
  width: 100%;
  margin-top: auto;
  padding-top: 12px;
}
```

---

## 7. Badges y Etiquetas de Estado

### CSS base compartido

```css
/* ── BASE — Todos los badges comparten estos estilos ── */
.vt-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 2px 10px;
  border-radius: var(--vt-radius-full);
  font-size: 0.75rem;
  font-weight: 600;
  line-height: 1.4;
  white-space: nowrap;
}
```

### Variantes por estado

```css
/* ── PEDIDOS ── */
.vt-badge--entregado {
  background: var(--vt-success-bg);
  color: var(--vt-success);
  border: 1px solid rgba(22, 163, 74, 0.2);
}
.vt-badge--en-camino {
  background: var(--vt-warning-bg);
  color: var(--vt-warning);
  border: 1px solid rgba(217, 119, 6, 0.2);
}
.vt-badge--procesando,
.vt-badge--pagado,
.vt-badge--despachado {
  background: var(--vt-info-bg);
  color: var(--vt-info);
  border: 1px solid rgba(20, 144, 242, 0.2);
}
.vt-badge--cancelado,
.vt-badge--rechazado {
  background: var(--vt-error-bg);
  color: var(--vt-error);
  border: 1px solid rgba(220, 38, 38, 0.2);
}
.vt-badge--pendiente {
  background: var(--vt-warning-bg);
  color: var(--vt-warning);
  border: 1px solid rgba(217, 119, 6, 0.2);
}

/* ── INVENTARIO ── */
.vt-badge--en-stock {
  background: var(--vt-success-bg);
  color: var(--vt-success);
  border: 1px solid rgba(22, 163, 74, 0.2);
}
.vt-badge--stock-bajo {
  background: var(--vt-warning-bg);
  color: var(--vt-warning);
  border: 1px solid rgba(217, 119, 6, 0.2);
}
.vt-badge--sin-stock {
  background: var(--vt-error-bg);
  color: var(--vt-error);
  border: 1px solid rgba(220, 38, 38, 0.2);
}

/* ── PRODUCTO ── */
.vt-badge--nuevo {
  background: var(--vt-info-bg);
  color: var(--vt-blue);
  border: 1px solid rgba(20, 144, 242, 0.2);
}
.vt-badge--oferta {
  background: var(--vt-error-bg);
  color: var(--vt-error);
  border: 1px solid rgba(220, 38, 38, 0.2);
}
```

**Uso en plantillas Vue:**

```html
<span class="vt-badge vt-badge--entregado">Entregado</span>
<span class="vt-badge vt-badge--en-camino">En camino</span>
<span class="vt-badge vt-badge--procesando">Procesando</span>
<span class="vt-badge vt-badge--cancelado">Cancelado</span>
<span class="vt-badge vt-badge--en-stock">En stock</span>
<span class="vt-badge vt-badge--stock-bajo">Stock bajo</span>
<span class="vt-badge vt-badge--sin-stock">Sin stock</span>
<span class="vt-badge vt-badge--nuevo">Nuevo</span>
<span class="vt-badge vt-badge--oferta">-20%</span>
```

---

## 8. Mensajes Emergentes y Notificaciones

### Toasts de confirmación

Los toasts aparecen en la esquina superior derecha y desaparecen automáticamente después de 3 segundos. Se distinguen por un borde izquierdo de color semántico.

```css
/* ── TOAST ── */
.vt-toast {
  position: fixed;
  top: 80px;
  right: 24px;
  z-index: 2000;
  min-width: 280px;
  max-width: 360px;
  background: #FFFFFF;
  border: 1px solid var(--vt-border-light);
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-dropdown);
  padding: 14px 16px;
  display: flex;
  align-items: flex-start;
  gap: 12px;

  /* Estado inicial: oculto */
  opacity: 0;
  visibility: hidden;
  transform: translateX(24px);
  transition: opacity 0.3s ease-in-out,
              transform 0.3s ease-in-out,
              visibility 0.3s ease-in-out;
}
/* Estado visible */
.vt-toast.is-visible {
  opacity: 1;
  visibility: visible;
  transform: translateX(0);
}

/* Variantes por tipo */
.vt-toast--success { border-left: 3px solid var(--vt-success); }
.vt-toast--error   { border-left: 3px solid var(--vt-error); }
.vt-toast--info    { border-left: 3px solid var(--vt-blue); }

.vt-toast__icon { width: 20px; height: 20px; flex-shrink: 0; margin-top: 1px; }
.vt-toast--success .vt-toast__icon { color: var(--vt-success); }
.vt-toast--error   .vt-toast__icon { color: var(--vt-error); }
.vt-toast--info    .vt-toast__icon { color: var(--vt-blue); }

.vt-toast__message {
  font-size: 0.875rem;
  color: var(--vt-text-secondary);
  line-height: 1.5;
}
```

**Lógica en Vue 3 para mostrar y ocultar un toast:**

```javascript
// composable: useToast.js
import { ref } from 'vue';

const isVisible = ref(false);
let timer = null;

function showToast() {
  isVisible.value = true;
  clearTimeout(timer);
  timer = setTimeout(() => { isVisible.value = false; }, 3000);
}
```

---

### Estados vacíos

Se usan cuando no hay resultados: carrito vacío, sin pedidos, sin resultados de búsqueda.

```css
/* ── ESTADO VACÍO ── */
.vt-empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 64px 24px;
  gap: 12px;
}
.vt-empty-state__icon {
  width: 64px;
  height: 64px;
  color: var(--vt-text-disabled);
}
.vt-empty-state__title {
  font-size: 1.25rem;
  font-weight: 600;
  color: var(--vt-text-secondary);
  margin: 0;
}
.vt-empty-state__description {
  font-size: 1rem;
  color: var(--vt-text-muted);
  max-width: 320px;
  margin: 0;
}
.vt-empty-state__action { margin-top: 8px; }
```

**Ejemplo de uso:**

```html
<div class="vt-empty-state">
  <svg class="vt-empty-state__icon"><!-- ícono carrito vacío --></svg>
  <h3 class="vt-empty-state__title">Tu carrito está vacío</h3>
  <p class="vt-empty-state__description">
    Explora el catálogo y agrega los productos que necesitas.
  </p>
  <div class="vt-empty-state__action">
    <a href="/catalogo" class="btn-vt-primary">Ver catálogo</a>
  </div>
</div>
```

---

## 9. Pie de Página (Footer)

### Estructura HTML

```html
<footer class="vt-footer">
  <div class="vt-footer__inner">

    <!-- Grid principal de 4 columnas -->
    <div class="vt-footer__grid">

      <!-- Columna 1: identidad -->
      <div class="vt-footer__brand">
        <div class="vt-footer__logo-placeholder"></div>
        <p class="vt-footer__tagline">
          Tecnología empresarial para Colombia. Calidad garantizada.
        </p>
        <p class="vt-footer__location">Cali, Valle del Cauca · Colombia</p>
      </div>

      <!-- Columna 2: empresa -->
      <div class="vt-footer__col">
        <h4 class="vt-footer__col-title">Empresa</h4>
        <ul class="vt-footer__list">
          <li><a class="vt-footer__link" href="#">Quiénes somos</a></li>
          <li><a class="vt-footer__link" href="#">Cómo comprar</a></li>
          <li><a class="vt-footer__link" href="#">Trabaja con nosotros</a></li>
        </ul>
      </div>

      <!-- Columna 3: soporte -->
      <div class="vt-footer__col">
        <h4 class="vt-footer__col-title">Soporte</h4>
        <ul class="vt-footer__list">
          <li><a class="vt-footer__link" href="#">Centro de ayuda</a></li>
          <li><a class="vt-footer__link" href="#">Seguimiento de pedidos</a></li>
          <li><a class="vt-footer__link" href="#">Garantías y devoluciones</a></li>
        </ul>
      </div>

      <!-- Columna 4: legal + medios de pago -->
      <div class="vt-footer__col">
        <h4 class="vt-footer__col-title">Legal</h4>
        <ul class="vt-footer__list">
          <li><a class="vt-footer__link" href="#">Términos de uso</a></li>
          <li><a class="vt-footer__link" href="#">Privacidad</a></li>
          <li><a class="vt-footer__link" href="#">Política de cookies</a></li>
        </ul>

        <!-- Medios de pago -->
        <div class="vt-footer__payments">
          <div class="vt-footer__payment-icon">MP</div>
          <div class="vt-footer__payment-icon">PSE</div>
          <div class="vt-footer__payment-icon">VISA</div>
          <div class="vt-footer__payment-icon">MC</div>
        </div>
      </div>

    </div><!-- /grid -->

    <!-- Separador y copyright -->
    <div class="vt-footer__bottom">
      <p class="vt-footer__copyright">© 2026 VenTech · Todos los derechos reservados</p>
    </div>

  </div>
</footer>
```

### CSS del footer

```css
/* ── FOOTER ── */
.vt-footer {
  background: #1F2937;
  padding: 48px 0 0 0;
}
.vt-footer__inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 32px;
}

/* Grid principal 4 columnas */
.vt-footer__grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr;
  gap: 40px;
}

/* ── COLUMNA DE MARCA ── */
.vt-footer__logo-placeholder {
  width: 120px;
  height: 32px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
  margin-bottom: 16px;
}
.vt-footer__tagline,
.vt-footer__location {
  font-size: 0.875rem;
  color: #9CA3AF;
  line-height: 1.5;
  margin: 0 0 8px 0;
}

/* ── COLUMNAS DE ENLACES ── */
.vt-footer__col-title {
  font-size: 0.875rem;
  font-weight: 700;
  color: #F9FAFB;
  margin: 0 0 16px 0;
  text-transform: none;
}
.vt-footer__list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.vt-footer__link {
  font-size: 0.875rem;
  color: #9CA3AF;
  text-decoration: none;
  cursor: pointer;
  transition: color 0.3s ease-in-out;
}
.vt-footer__link:hover { color: #FFFFFF; }

/* ── MEDIOS DE PAGO ── */
.vt-footer__payments {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
  margin-top: 20px;
}
.vt-footer__payment-icon {
  padding: 4px 10px;
  background: rgba(255, 255, 255, 0.08);
  border-radius: var(--vt-radius-sm);
  font-size: 0.75rem;
  font-weight: 700;
  color: #9CA3AF;
}

/* ── SEPARADOR Y COPYRIGHT ── */
.vt-footer__bottom {
  border-top: 1px solid rgba(255, 255, 255, 0.08);
  margin-top: 40px;
  padding: 20px 0;
}
.vt-footer__copyright {
  font-size: 0.75rem;
  color: #6B7280;
  margin: 0;
}

/* ── RESPONSIVE MOBILE ── */
@media (max-width: 767px) {
  .vt-footer__grid {
    grid-template-columns: 1fr;
    gap: 32px;
  }
  .vt-footer__inner { padding: 0 20px; }
}
```

---

## 10. Transiciones Globales del Sistema

### Regla global

La siguiente regla se aplica como reset de transiciones en todos los elementos interactivos del proyecto. Se define en el archivo CSS principal (`main.css` o `assets/styles/global.css`) y se importa en `main.js` de Vue.

```css
/* ── TRANSICIONES GLOBALES ── */
*,
*::before,
*::after {
  transition:
    color            0.3s ease-in-out,
    background-color 0.3s ease-in-out,
    border-color     0.3s ease-in-out,
    box-shadow       0.3s ease-in-out,
    opacity          0.3s ease-in-out,
    transform        0.3s ease-in-out;
}
```

> **Nota de rendimiento:** La regla `*` con `transition` puede afectar el rendimiento en páginas con muchos elementos. Si se detectan problemas, limitar la regla solo a los selectores de componentes interactivos (`.btn-vt-*`, `.vt-field__input`, `.product-card`, etc.) en lugar de usar el selector universal.

---

### Resumen de transiciones por componente

| Componente | Propiedad animada | Duración | Trigger |
|---|---|---|---|
| Navbar | `background-color`, `box-shadow` | 0.3s | Scroll > 50px |
| Sidebar mobile | `transform translateX` | 0.3s | Clic hamburguesa |
| Dropdown de usuario | `opacity`, `transform translateY`, `visibility` | 0.3s | Hover / clic |
| Botón primario | `opacity`, `transform translateY(-1px)` | 0.3s | `:hover` |
| Botón secundario | `background-color`, `border-color` | 0.3s | `:hover` |
| Botón ghost | `background-color`, `color` | 0.3s | `:hover` |
| Input / campo | `border-color`, `box-shadow` | 0.3s | `:focus` |
| Mensaje de error | `opacity`, `visibility` | 0.3s | Estado `.has-error` |
| Tarjeta de producto | `transform translateY(-3px)`, `box-shadow` | 0.3s | `:hover` |
| Toast | `opacity`, `transform translateX`, `visibility` | 0.3s | Clase `.is-visible` |
| Enlace navbar | `color` | 0.3s | `:hover` |
| Enlace footer | `color` | 0.3s | `:hover` |
| Badge / etiqueta | ninguna — estáticos | — | — |

---

### Accesibilidad — `prefers-reduced-motion`

Los usuarios que tienen configurada la preferencia de movimiento reducido en su sistema operativo (por motivos de accesibilidad, epilepsia fotosensible u otras condiciones) deben ver una interfaz sin animaciones. Este bloque desactiva todas las transiciones y animaciones para esos usuarios.

```css
/* ── ACCESIBILIDAD: sin movimiento ── */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

Este bloque va al **final** del archivo CSS global para garantizar que tenga mayor especificidad y no sea sobreescrito por reglas anteriores.

---

*VenTech — Sistema de Diseño Visual v1.0*
*Proyecto SENA Ficha 3186630.*
