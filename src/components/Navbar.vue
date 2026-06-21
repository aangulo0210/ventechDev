<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import { RouterLink } from 'vue-router';

const isScrolled    = ref(false);
const sidebarOpen   = ref(false);
const searchOpen    = ref(false);
const searchInput   = ref(null);

function handleScroll() {
  isScrolled.value = window.scrollY > 50;
}
function toggleSidebar() {
  sidebarOpen.value = !sidebarOpen.value;
  if (sidebarOpen.value) searchOpen.value = false;
}
function closeSidebar() {
  sidebarOpen.value = false;
}
function toggleSearch() {
  searchOpen.value = !searchOpen.value;
  if (sidebarOpen.value) sidebarOpen.value = false;
  if (searchOpen.value) {
    // foco al input cuando se abre
    setTimeout(() => searchInput.value?.focus(), 50);
  }
}
function closeSearch() {
  searchOpen.value = false;
}

onMounted(() => window.addEventListener('scroll', handleScroll, { passive: true }));
onUnmounted(() => window.removeEventListener('scroll', handleScroll));
</script>

<template>
  <!-- Navbar principal -->
  <nav class="vt-navbar" :class="{ 'is-scrolled': isScrolled || searchOpen }">
    <div class="vt-navbar__inner">

      <!-- Izquierda: logo -->
      <RouterLink to="/" class="vt-navbar__logo" aria-label="VenTech inicio">
        <span class="vt-navbar__logo-text">VenTech</span>
      </RouterLink>

      <!-- Centro: links + buscador (solo desktop ≥ 1024px) -->
      <div class="vt-navbar__center">
        <RouterLink to="/" class="vt-navbar__link">Inicio</RouterLink>
        <RouterLink to="/catalogo" class="vt-navbar__link">Productos</RouterLink>
        <a href="#ofertas" class="vt-navbar__link">Ofertas</a>

        <div class="vt-navbar__search">
          <svg class="vt-navbar__search-icon" viewBox="0 0 24 24" fill="none"
               stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
          </svg>
          <input type="text" class="vt-navbar__search-input"
                 placeholder="Buscar productos..." aria-label="Buscar" />
        </div>
      </div>

      <!-- Centro compacto: solo links sin buscador (tablet 768–1023px) -->
      <div class="vt-navbar__center-compact">
        <RouterLink to="/" class="vt-navbar__link">Inicio</RouterLink>
        <RouterLink to="/catalogo" class="vt-navbar__link">Productos</RouterLink>
        <a href="#ofertas" class="vt-navbar__link">Ofertas</a>
      </div>

      <!-- Derecha -->
      <div class="vt-navbar__right">
        <!-- Ícono búsqueda — visible en tablet y mobile -->
        <button class="vt-navbar__icon-btn vt-navbar__search-toggle"
                @click="toggleSearch"
                :aria-expanded="searchOpen"
                aria-label="Buscar">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
               stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
          </svg>
        </button>

        <RouterLink to="/auth" class="btn-vt-primary vt-navbar__btn">
          Iniciar sesión
        </RouterLink>
        <RouterLink to="/auth?modo=registro" class="btn-vt-secondary vt-navbar__btn vt-navbar__btn--secondary">
          Crear cuenta
        </RouterLink>

        <div class="vt-navbar__cart" role="button" aria-label="Carrito de compras">
          <svg class="vt-navbar__cart-icon" viewBox="0 0 24 24" fill="none"
               stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
          </svg>
        </div>

        <button class="vt-navbar__hamburger"
                @click="toggleSidebar"
                aria-label="Menú"
                :aria-expanded="sidebarOpen">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </div>
    </div>

    <!-- Barra de búsqueda expandida (tablet y mobile) -->
    <div class="vt-navbar__searchbar" :class="{ 'is-open': searchOpen }">
      <div class="vt-navbar__searchbar-inner">
        <svg class="vt-navbar__searchbar-icon" viewBox="0 0 24 24" fill="none"
             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
        </svg>
        <input
          ref="searchInput"
          type="text"
          class="vt-navbar__searchbar-input"
          placeholder="Buscar productos, marcas o categorías..."
          aria-label="Buscar"
          @keydown.escape="closeSearch"
        />
        <button class="vt-navbar__searchbar-close" @click="closeSearch" aria-label="Cerrar búsqueda">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
               stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M18 6 6 18M6 6l12 12"/>
          </svg>
        </button>
      </div>
    </div>
  </nav>

  <!-- Overlay oscuro cuando la búsqueda está abierta -->
  <div class="vt-search-overlay" :class="{ 'is-open': searchOpen }" @click="closeSearch"></div>

  <!-- Overlay sidebar móvil -->
  <div class="vt-sidebar-overlay" :class="{ 'is-open': sidebarOpen }" @click="closeSidebar"></div>

  <!-- Sidebar móvil -->
  <div class="vt-sidebar-mobile" :class="{ 'is-open': sidebarOpen }">
    <RouterLink to="/" class="vt-navbar__link" @click="closeSidebar">Inicio</RouterLink>
    <RouterLink to="/catalogo" class="vt-navbar__link" @click="closeSidebar">Productos</RouterLink>
    <a href="#ofertas" class="vt-navbar__link" @click="closeSidebar">Ofertas</a>
    <div style="margin-top: 24px; display: flex; flex-direction: column; gap: 12px;">
      <RouterLink to="/auth" class="btn-vt-primary" @click="closeSidebar">Iniciar sesión</RouterLink>
      <RouterLink to="/auth?modo=registro" class="btn-vt-secondary" @click="closeSidebar">Crear cuenta</RouterLink>
    </div>
  </div>
</template>

<style scoped>
/* ── NAVBAR BASE ── */
.vt-navbar {
  position: fixed; top: 0; left: 0; width: 100%;
  z-index: 1000;
  background-color: rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  transition: background-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}
.vt-navbar.is-scrolled {
  background-color: rgba(255, 255, 255, 0.95);
  box-shadow: var(--vt-shadow-navbar);
}

.vt-navbar__inner {
  width: 100%; max-width: 1280px; margin: 0 auto;
  height: 64px;
  display: flex; align-items: center;
  padding: 0 32px;
  position: relative;
}

/* ── LOGO ── */
.vt-navbar__logo { display: flex; align-items: center; text-decoration: none; flex-shrink: 0; }
.vt-navbar__logo-text {
  font-size: 1.25rem; font-weight: 800; letter-spacing: -0.02em;
  background: var(--vt-gradient);
  -webkit-background-clip: text; background-clip: text;
  -webkit-text-fill-color: transparent; color: transparent;
}

/* ── CENTRO DESKTOP: links + buscador (≥ 1024px) ── */
.vt-navbar__center {
  position: absolute; left: 50%; transform: translateX(-50%);
  display: flex; align-items: center; gap: 20px;
}

/* ── CENTRO COMPACTO: solo links (768–1023px) ── */
.vt-navbar__center-compact {
  display: none;
  flex: 1; justify-content: center; align-items: center; gap: 24px;
  margin: 0 16px;
}

/* ── LINKS ── */
.vt-navbar__link {
  font-size: 1rem; font-weight: 500; color: var(--vt-text-secondary);
  text-decoration: none; white-space: nowrap;
}
.vt-navbar__link:hover { color: var(--vt-blue); }
.vt-navbar__link.router-link-active { color: var(--vt-blue); }

/* ── BUSCADOR DESKTOP ── */
.vt-navbar__search { position: relative; width: 220px; flex-shrink: 0; }
.vt-navbar__search-input {
  width: 100%; padding: 7px 14px 7px 36px;
  background: var(--vt-bg-input); border: 1px solid var(--vt-border-input);
  border-radius: var(--vt-radius-md); font-family: var(--vt-font-sans);
  font-size: 0.875rem; color: var(--vt-text-primary); outline: none;
}
.vt-navbar__search-input::placeholder { color: var(--vt-text-muted); }
.vt-navbar__search-input:focus {
  border-color: var(--vt-border-focus);
  box-shadow: 0 0 0 3px rgba(20, 144, 242, 0.12);
  background: #fff;
}
.vt-navbar__search-icon {
  position: absolute; left: 11px; top: 50%; transform: translateY(-50%);
  width: 15px; height: 15px; color: var(--vt-text-muted); pointer-events: none;
}

/* ── DERECHA ── */
.vt-navbar__right {
  margin-left: auto;
  display: flex; align-items: center; gap: 12px; flex-shrink: 0;
}
.vt-navbar__btn { font-size: 0.875rem; padding: 7px 16px; }

/* Ícono de búsqueda (oculto en desktop, visible en tablet/mobile) */
.vt-navbar__search-toggle {
  display: none;
}
.vt-navbar__icon-btn {
  background: none; border: none; cursor: pointer; padding: 6px;
  color: var(--vt-text-secondary); border-radius: var(--vt-radius-md);
  display: flex; align-items: center; justify-content: center;
}
.vt-navbar__icon-btn:hover { color: var(--vt-blue); background: var(--vt-bg-subtle); }
.vt-navbar__icon-btn svg { width: 20px; height: 20px; display: block; }

.vt-navbar__cart { position: relative; cursor: pointer; color: var(--vt-text-secondary); }
.vt-navbar__cart:hover { color: var(--vt-blue); }
.vt-navbar__cart-icon { width: 22px; height: 22px; display: block; }

.vt-navbar__hamburger {
  display: none; flex-direction: column; gap: 5px;
  cursor: pointer; padding: 4px; background: none; border: none;
}
.vt-navbar__hamburger span {
  display: block; width: 22px; height: 2px;
  background: var(--vt-text-secondary); border-radius: 2px;
}

/* ── BARRA BÚSQUEDA EXPANDIDA (tablet y mobile) ── */
.vt-navbar__searchbar {
  overflow: hidden;
  max-height: 0;
  transition: max-height 0.3s ease-in-out;
}
.vt-navbar__searchbar.is-open {
  max-height: 72px;
}
.vt-navbar__searchbar-inner {
  display: flex; align-items: center; gap: 12px;
  padding: 10px 32px 12px;
  position: relative;
}
.vt-navbar__searchbar-icon {
  position: absolute; left: 48px; top: 50%; transform: translateY(-50%);
  width: 16px; height: 16px; color: var(--vt-text-muted); pointer-events: none;
}
.vt-navbar__searchbar-input {
  flex: 1;
  padding: 9px 14px 9px 38px;
  background: var(--vt-bg-input); border: 1px solid var(--vt-border-input);
  border-radius: var(--vt-radius-md); font-family: var(--vt-font-sans);
  font-size: 0.9375rem; color: var(--vt-text-primary); outline: none;
}
.vt-navbar__searchbar-input::placeholder { color: var(--vt-text-muted); }
.vt-navbar__searchbar-input:focus {
  border-color: var(--vt-border-focus);
  box-shadow: 0 0 0 3px rgba(20, 144, 242, 0.12);
  background: #fff;
}
.vt-navbar__searchbar-close {
  flex-shrink: 0; background: none; border: none; cursor: pointer; padding: 6px;
  color: var(--vt-text-muted); border-radius: var(--vt-radius-md);
  display: flex; align-items: center;
}
.vt-navbar__searchbar-close:hover { color: var(--vt-text-primary); background: var(--vt-bg-overlay); }
.vt-navbar__searchbar-close svg { width: 18px; height: 18px; }

/* ── OVERLAY BÚSQUEDA ── */
.vt-search-overlay {
  position: fixed; inset: 0; z-index: 999;
  opacity: 0; visibility: hidden;
  transition: opacity 0.3s ease-in-out, visibility 0.3s ease-in-out;
}
.vt-search-overlay.is-open { opacity: 1; visibility: visible; }

/* ── SIDEBAR Y OVERLAY MÓVIL ── */
.vt-sidebar-overlay {
  position: fixed; inset: 0; background: rgba(0,0,0,0.4);
  z-index: 1050; opacity: 0; visibility: hidden;
  transition: opacity 0.3s ease-in-out, visibility 0.3s ease-in-out;
}
.vt-sidebar-overlay.is-open { opacity: 1; visibility: visible; }

.vt-sidebar-mobile {
  position: fixed; top: 0; left: 0; height: 100%; width: 280px;
  background: #fff; box-shadow: var(--vt-shadow-dropdown);
  z-index: 1100; padding: 80px 24px 24px;
  transform: translateX(-100%);
  transition: transform 0.3s ease-in-out;
  display: flex; flex-direction: column; gap: 20px;
}
.vt-sidebar-mobile.is-open { transform: translateX(0); }

/* ── BREAKPOINT TABLET (768–1023px) ── */
@media (max-width: 1023px) {
  .vt-navbar__center          { display: none; }
  .vt-navbar__center-compact  { display: flex; }
  .vt-navbar__search-toggle   { display: flex; }
  .vt-navbar__btn--secondary  { display: none; }
  .vt-navbar__searchbar-inner { padding: 10px 24px 12px; }
  .vt-navbar__searchbar-icon  { left: 40px; }
}

/* ── BREAKPOINT MOBILE (< 768px) ── */
@media (max-width: 767px) {
  .vt-navbar__inner           { padding: 0 16px; height: 56px; }
  .vt-navbar__center-compact  { display: none; }
  .vt-navbar__btn             { display: none; }
  .vt-navbar__hamburger       { display: flex; }
  .vt-navbar__searchbar-inner { padding: 10px 16px 12px; }
  .vt-navbar__searchbar-icon  { left: 32px; }
}
</style>
