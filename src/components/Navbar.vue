<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import { RouterLink } from 'vue-router';

const isScrolled = ref(false);
const sidebarOpen = ref(false);

function handleScroll() {
  isScrolled.value = window.scrollY > 50;
}

function toggleSidebar() {
  sidebarOpen.value = !sidebarOpen.value;
}

function closeSidebar() {
  sidebarOpen.value = false;
}

onMounted(() => window.addEventListener('scroll', handleScroll, { passive: true }));
onUnmounted(() => window.removeEventListener('scroll', handleScroll));
</script>

<template>
  <nav class="vt-navbar" :class="{ 'is-scrolled': isScrolled }">
    <div class="vt-navbar__inner">
      <!-- Izquierda: logo -->
      <RouterLink to="/" class="vt-navbar__logo" aria-label="VenTech inicio">
        <span class="vt-navbar__logo-text">VenTech</span>
      </RouterLink>

      <!-- Centro: links + buscador -->
      <div class="vt-navbar__center">
        <RouterLink to="/" class="vt-navbar__link">Inicio</RouterLink>
        <RouterLink to="/catalogo" class="vt-navbar__link">Productos</RouterLink>
        <a href="#ofertas" class="vt-navbar__link">Ofertas</a>

        <div class="vt-navbar__search">
          <svg class="vt-navbar__search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
          </svg>
          <input type="text" class="vt-navbar__search-input" placeholder="Buscar productos..." aria-label="Buscar" />
        </div>
      </div>

      <!-- Derecha: botones + carrito + hamburguesa -->
      <div class="vt-navbar__right">
        <RouterLink to="/auth" class="btn-vt-primary vt-navbar__btn">
          Iniciar sesión
        </RouterLink>
        <RouterLink to="/auth?modo=registro" class="btn-vt-secondary vt-navbar__btn">
          Crear cuenta
        </RouterLink>

        <div class="vt-navbar__cart" role="button" aria-label="Carrito de compras">
          <svg class="vt-navbar__cart-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
          </svg>
        </div>

        <button class="vt-navbar__hamburger" @click="toggleSidebar" aria-label="Menú" :aria-expanded="sidebarOpen">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </div>
    </div>
  </nav>

  <!-- Overlay móvil -->
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
.vt-navbar {
  position: fixed; top: 0; left: 0; width: 100%; height: 64px;
  z-index: 1000; display: flex; align-items: center; padding: 0 32px;
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
  display: flex; align-items: center;
  position: relative;
}

/* Izquierda */
.vt-navbar__logo {
  display: flex; align-items: center;
  text-decoration: none; flex-shrink: 0;
}
.vt-navbar__logo-text {
  font-size: 1.25rem; font-weight: 800; letter-spacing: -0.02em;
  background: var(--vt-gradient);
  -webkit-background-clip: text; background-clip: text;
  -webkit-text-fill-color: transparent; color: transparent;
}

/* Centro — absolutamente centrado en el navbar */
.vt-navbar__center {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  display: flex; align-items: center; gap: 20px;
}
.vt-navbar__link {
  font-size: 1rem; font-weight: 500; color: var(--vt-text-secondary);
  text-decoration: none; white-space: nowrap;
}
.vt-navbar__link:hover { color: var(--vt-blue); }
.vt-navbar__link.router-link-active { color: var(--vt-blue); }

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

/* Derecha */
.vt-navbar__right {
  margin-left: auto;
  display: flex; align-items: center; gap: 12px; flex-shrink: 0;
}
.vt-navbar__btn {
  font-size: 0.875rem; padding: 7px 16px;
}
.vt-navbar__cart {
  position: relative; cursor: pointer; color: var(--vt-text-secondary);
}
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

@media (max-width: 767px) {
  .vt-navbar { height: 56px; padding: 0 16px; }
  .vt-navbar__center { display: none; }
  .vt-navbar__btn { display: none; }
  .vt-navbar__hamburger { display: flex; }
}
</style>
