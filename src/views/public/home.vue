<script setup>
import { ref, computed, watch, onMounted } from 'vue';
import { RouterLink } from 'vue-router';
import Navbar from '@/components/Navbar.vue';
import Footer from '@/components/Footer.vue';
import ProductCard from '@/components/ProductCard.vue';

/* ── CATEGORÍAS ── */
const CATEGORIAS = [
  { id: 'ofertas',        label: 'Precios imperdibles' },
  { id: 'Celulares',      label: 'Celulares'           },
  { id: 'Computadores',   label: 'Computadores'        },
  { id: 'TV y Monitores', label: 'TV y Monitores'      },
  { id: 'Audio',          label: 'Audio'               },
  { id: 'Periféricos',    label: 'Periféricos'         },
];

const PRODUCTOS_POR_PAGINA = 16;

/* ── ESTADO ── */
const categoriaActiva = ref('ofertas');
const ordenamiento    = ref('precio-asc');
const cargando        = ref(false);
const todosProductos  = ref([]);
const pagina          = ref(1);

/* ── COMPUTADOS ── */
const productosOrdenados = computed(() => {
  const arr = [...todosProductos.value];
  const [campo, dir] = ordenamiento.value.split('-');
  arr.sort((a, b) => {
    const va = campo === 'precio' ? a.precio : a.nombre.toLowerCase();
    const vb = campo === 'precio' ? b.precio : b.nombre.toLowerCase();
    return dir === 'asc' ? (va > vb ? 1 : -1) : (va < vb ? 1 : -1);
  });
  return arr;
});

const productosVisibles = computed(() =>
  productosOrdenados.value.slice(0, pagina.value * PRODUCTOS_POR_PAGINA)
);

const hayMas = computed(() =>
  productosVisibles.value.length < todosProductos.value.length
);

/* ── CARGA ── */
async function cargarProductos() {
  cargando.value = true;
  pagina.value = 1;
  try {
    const url = categoriaActiva.value === 'ofertas'
      ? '/api/productos/listar'
      : `/api/productos/listar?categoria=${encodeURIComponent(categoriaActiva.value)}`;
    const res = await fetch(url);
    const json = await res.json();
    const data = json.data ?? [];
    todosProductos.value = categoriaActiva.value === 'ofertas'
      ? data.filter(p => p.descuento > 0)
      : data;
  } catch {
    todosProductos.value = [];
  } finally {
    cargando.value = false;
  }
}

function seleccionarCategoria(id) {
  if (categoriaActiva.value !== id) categoriaActiva.value = id;
}

function verMas() {
  pagina.value += 1;
}

function manejarTeclaCategoria(e, id) {
  if (e.key === 'Enter' || e.key === ' ') {
    e.preventDefault();
    seleccionarCategoria(id);
  }
}

watch(categoriaActiva, cargarProductos);
watch(ordenamiento, () => { pagina.value = 1; });

onMounted(cargarProductos);
</script>

<template>
  <Navbar />

  <main class="vt-home">

    <!-- ── HERO ── -->
    <section class="vt-hero-split">
      <div class="vt-hero-split__inner">

        <!-- Columna izquierda -->
        <div class="vt-hero-split__content">
          <h1 class="vt-h1">Tecnología que <span class="vt-text-gradient">transforma</span> tu empresa</h1>
          <p class="vt-body-lg vt-hero-split__subtitle">
            Lo último en tecnología para impulsar la productividad, innovación y crecimiento de tu negocio.
          </p>

          <ul class="vt-hero-split__trust" aria-label="Beneficios">
            <li>
              <svg aria-hidden="true" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                <path d="M10 1.5 L18 5 V10 C18 14.5 14.5 17.8 10 19 C5.5 17.8 2 14.5 2 10 V5 Z"/>
                <path d="M7 10 L9.5 12.5 L13.5 8"/>
              </svg>
              Compra segura
            </li>
            <li>
              <svg aria-hidden="true" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                <rect x="2" y="7" width="16" height="10" rx="2"/>
                <path d="M5 7V5a5 5 0 0 1 10 0v2"/>
                <circle cx="10" cy="12" r="1.5"/>
              </svg>
              Envíos a toda Colombia
            </li>
            <li>
              <svg aria-hidden="true" viewBox="0 0 20 20" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                <path d="M3 7h14l-1.5 9H4.5L3 7Z"/>
                <path d="M7 7V5a3 3 0 0 1 6 0v2"/>
              </svg>
              Garantía por fabricantes
            </li>
          </ul>

          <div class="vt-hero-split__actions">
            <RouterLink to="/catalogo" class="btn-vt-primary">Ver productos</RouterLink>
            <RouterLink to="/auth?modo=registro" class="btn-vt-secondary">Crear cuenta</RouterLink>
          </div>
        </div>

        <!-- Columna derecha: placeholder imagen -->
        <div class="vt-hero-split__placeholder" aria-label="Imagen promocional pendiente">
          <svg aria-hidden="true" class="vt-hero-split__placeholder-icon" viewBox="0 0 64 64" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
            <rect x="4" y="10" width="56" height="44" rx="4"/>
            <circle cx="22" cy="26" r="5"/>
            <path d="M4 44 L18 30 L28 40 L38 28 L60 54"/>
          </svg>
          <span class="vt-hero-split__placeholder-text">Imagen promocional pendiente</span>
        </div>

      </div>
    </section>

    <!-- ── CATEGORÍAS ── -->
    <section class="vt-categories">
      <div class="vt-categories__inner">
        <h2 class="vt-h2 vt-categories__title">Categorías destacadas</h2>

        <div class="vt-categories__grid" role="list">
          <div
            v-for="cat in CATEGORIAS"
            :key="cat.id"
            class="vt-cat-card"
            :class="{ 'is-active': categoriaActiva === cat.id }"
            role="button"
            tabindex="0"
            :aria-pressed="categoriaActiva === cat.id"
            :aria-label="cat.label"
            @click="seleccionarCategoria(cat.id)"
            @keydown="manejarTeclaCategoria($event, cat.id)"
          >
            <!-- Precios imperdibles -->
            <svg v-if="cat.id === 'ofertas'" aria-hidden="true" class="vt-cat-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"/>
              <line x1="7" y1="7" x2="7.01" y2="7"/>
            </svg>
            <!-- Celulares -->
            <svg v-else-if="cat.id === 'Celulares'" aria-hidden="true" class="vt-cat-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <rect x="5" y="2" width="14" height="20" rx="2" ry="2"/>
              <line x1="12" y1="18" x2="12.01" y2="18"/>
            </svg>
            <!-- Computadores -->
            <svg v-else-if="cat.id === 'Computadores'" aria-hidden="true" class="vt-cat-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="3" width="20" height="14" rx="2" ry="2"/>
              <line x1="8" y1="21" x2="16" y2="21"/>
              <line x1="12" y1="17" x2="12" y2="21"/>
            </svg>
            <!-- TV y Monitores -->
            <svg v-else-if="cat.id === 'TV y Monitores'" aria-hidden="true" class="vt-cat-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="7" width="20" height="15" rx="2" ry="2"/>
              <polyline points="17 2 12 7 7 2"/>
            </svg>
            <!-- Audio -->
            <svg v-else-if="cat.id === 'Audio'" aria-hidden="true" class="vt-cat-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <path d="M3 18v-6a9 9 0 0 1 18 0v6"/>
              <path d="M21 19a2 2 0 0 1-2 2h-1a2 2 0 0 1-2-2v-3a2 2 0 0 1 2-2h3zM3 19a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2H3z"/>
            </svg>
            <!-- Periféricos -->
            <svg v-else aria-hidden="true" class="vt-cat-card__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="5" width="20" height="14" rx="2"/>
              <path d="M6 9h.01M10 9h.01M14 9h.01M18 9h.01M6 13h.01M10 13h.01M14 13h.01M18 13h.01"/>
            </svg>

            <span class="vt-cat-card__label">{{ cat.label }}</span>
          </div>
        </div>
      </div>
    </section>

    <!-- ── BARRA DE ORDENAMIENTO ── -->
    <div class="vt-sort-bar">
      <div class="vt-sort-bar__inner">
        <label class="vt-body vt-sort-bar__label" for="orden">Ordenar por:</label>
        <select id="orden" class="vt-field__input vt-sort-bar__select" v-model="ordenamiento">
          <option value="precio-asc">Precio de menor a mayor</option>
          <option value="precio-desc">Precio de mayor a menor</option>
          <option value="nombre-asc">Nombre ascendente (A–Z)</option>
          <option value="nombre-desc">Nombre descendente (Z–A)</option>
        </select>
      </div>
    </div>

    <!-- ── GRILLA DE PRODUCTOS ── -->
    <section class="vt-products" aria-label="Productos">
      <div class="vt-products__inner">

        <!-- Skeletons de carga -->
        <div v-if="cargando" class="vt-products__grid">
          <div v-for="n in 8" :key="n" class="vt-skeleton" aria-hidden="true"></div>
        </div>

        <!-- Sin productos -->
        <div v-else-if="todosProductos.length === 0" class="vt-empty-state">
          <svg class="vt-empty-state__icon" aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"/>
            <line x1="8" y1="12" x2="16" y2="12"/>
          </svg>
          <h3 class="vt-empty-state__title">Sin productos en esta categoría</h3>
          <p class="vt-empty-state__description">Pronto agregaremos más productos. Explora otras categorías.</p>
        </div>

        <!-- Productos -->
        <template v-else>
          <div class="vt-products__grid">
            <ProductCard
              v-for="producto in productosVisibles"
              :key="producto.id"
              :producto="producto"
              @agregar="() => {}"
            />
          </div>

          <div v-if="hayMas" class="vt-products__more">
            <button class="btn-vt-secondary" @click="verMas">Ver más</button>
          </div>
        </template>

      </div>
    </section>

  </main>

  <Footer />
</template>

<style scoped>
/* ── HOME WRAPPER ── */
.vt-home {
  padding-top: 64px;
  min-height: 100vh;
}

/* ── HERO ── */
.vt-hero-split {
  background: linear-gradient(160deg, #f5f7fa 0%, #ffffff 60%);
  padding: 72px 0 64px;
}
.vt-hero-split__inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 32px;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 56px;
  align-items: center;
}

.vt-hero-split__content {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.vt-hero-split__subtitle {
  color: var(--vt-text-secondary);
  max-width: 480px;
}

.vt-hero-split__trust {
  list-style: none;
  padding: 0; margin: 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.vt-hero-split__trust li {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 0.9375rem;
  font-weight: 500;
  color: var(--vt-text-secondary);
}
.vt-hero-split__trust li svg {
  width: 20px; height: 20px;
  flex-shrink: 0;
  color: var(--vt-blue);
}

.vt-hero-split__actions {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.vt-hero-split__placeholder {
  background: var(--vt-bg-subtle);
  border-radius: var(--vt-radius-xl);
  border: 2px dashed var(--vt-border-light);
  min-height: 380px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 16px;
  padding: 32px;
}
.vt-hero-split__placeholder-icon {
  width: 72px; height: 72px;
  color: var(--vt-text-disabled);
}
.vt-hero-split__placeholder-text {
  font-size: 0.9375rem;
  color: var(--vt-text-muted);
  text-align: center;
}

/* ── CATEGORÍAS ── */
.vt-categories {
  background: var(--vt-bg-base);
  padding: 56px 0 48px;
}
.vt-categories__inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 32px;
}
.vt-categories__title {
  text-align: center;
  margin-bottom: 32px;
  color: var(--vt-text-primary);
}

.vt-categories__grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 16px;
}

.vt-cat-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 12px;
  padding: 24px 12px;
  background: var(--vt-bg-card);
  border: 1px solid var(--vt-border-light);
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-card);
  cursor: pointer;
  user-select: none;
  outline: none;
  text-align: center;
  color: var(--vt-text-secondary);
}
.vt-cat-card:hover {
  box-shadow: var(--vt-shadow-card-hover);
  transform: translateY(-2px);
  border-color: var(--vt-border-active);
  color: var(--vt-blue);
}
.vt-cat-card:focus-visible {
  box-shadow: 0 0 0 3px rgba(20, 144, 242, 0.25);
  border-color: var(--vt-blue);
}
.vt-cat-card.is-active {
  border-color: var(--vt-blue);
  background: var(--vt-info-bg);
  color: var(--vt-blue);
  box-shadow: var(--vt-shadow-card-hover);
}

.vt-cat-card__icon {
  width: 36px; height: 36px;
  flex-shrink: 0;
}
.vt-cat-card__label {
  font-size: 0.8125rem;
  font-weight: 600;
  line-height: 1.3;
}

/* ── SORT BAR ── */
.vt-sort-bar {
  background: var(--vt-bg-subtle);
  border-top: 1px solid var(--vt-border-light);
  border-bottom: 1px solid var(--vt-border-light);
  padding: 14px 0;
}
.vt-sort-bar__inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 32px;
  display: flex;
  align-items: center;
  gap: 12px;
}
.vt-sort-bar__label {
  white-space: nowrap;
  color: var(--vt-text-secondary);
  font-weight: 500;
}
.vt-sort-bar__select {
  width: auto;
  min-width: 220px;
  padding: 7px 12px;
  cursor: pointer;
}

/* ── PRODUCTOS ── */
.vt-products {
  padding: 48px 0 80px;
  background: var(--vt-bg-base);
}
.vt-products__inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 32px;
}

.vt-products__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
}

.vt-products__more {
  display: flex;
  justify-content: center;
  margin-top: 40px;
}

.vt-skeleton {
  background: var(--vt-bg-subtle);
  border-radius: var(--vt-radius-lg);
  height: 320px;
  animation: vt-shimmer 1.4s ease-in-out infinite;
}
@keyframes vt-shimmer {
  0%, 100% { opacity: 1; }
  50%       { opacity: 0.5; }
}

.vt-empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 80px 24px;
  gap: 12px;
}
.vt-empty-state__icon {
  width: 56px; height: 56px;
  color: var(--vt-text-disabled);
}
.vt-empty-state__title {
  font-size: 1.25rem; font-weight: 600;
  color: var(--vt-text-secondary); margin: 0;
}
.vt-empty-state__description {
  font-size: 1rem; color: var(--vt-text-muted);
  max-width: 340px; margin: 0;
}

/* ── RESPONSIVE ── */
@media (max-width: 1023px) {
  .vt-categories__grid { grid-template-columns: repeat(3, 1fr); }
  .vt-products__grid   { grid-template-columns: repeat(3, 1fr); }
}

@media (max-width: 767px) {
  .vt-home { padding-top: 56px; }

  .vt-hero-split { padding: 48px 0 40px; }
  .vt-hero-split__inner {
    grid-template-columns: 1fr;
    gap: 32px;
    padding: 0 20px;
  }
  .vt-hero-split__placeholder { min-height: 220px; }

  .vt-categories { padding: 40px 0 32px; }
  .vt-categories__inner { padding: 0 20px; }
  .vt-categories__grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }

  .vt-sort-bar__inner { padding: 0 20px; flex-wrap: wrap; }
  .vt-sort-bar__select { width: 100%; min-width: unset; }

  .vt-products { padding: 32px 0 56px; }
  .vt-products__inner { padding: 0 20px; }
  .vt-products__grid { grid-template-columns: repeat(2, 1fr); gap: 16px; }
}

@media (max-width: 479px) {
  .vt-hero-split__actions { flex-direction: column; }
  .vt-hero-split__actions a { text-align: center; }
  .vt-categories__grid { grid-template-columns: repeat(2, 1fr); }
  .vt-products__grid   { grid-template-columns: 1fr; }
}
</style>
